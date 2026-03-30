library WoWReforgedLevers initializer Init requires SoundUtils

struct Lever
    unit u
    destructable d
    unit sourcePortal
    real sourcePortalX
    real sourcePortalY
    unit targetPortal
    real targetPortalX
    real targetPortalY
    integer leverType
endstruct

globals
    constant integer LEVER_TYPE_GATE = 0
    constant integer LEVER_TYPE_BRIDGE = 1
    constant integer LEVER_TYPE_PORTAL = 2

    private Lever array levers
    private integer leversCount = 0
    
    private hashtable h = InitHashtable()
    private trigger sellTrigger = CreateTrigger()
    
    private group leverPortals = CreateGroup()
    
    private constant integer KEY_COUNT = 0
    private constant integer KEY_INDEX = 1
endglobals

function GetUnitLeverCount takes unit whichUnit returns integer
    return LoadInteger(h, GetHandleId(whichUnit), KEY_COUNT)
endfunction

function GetUnitLever takes unit whichUnit, integer index returns Lever
    return LoadInteger(h, GetHandleId(whichUnit), KEY_INDEX + index)
endfunction

function IsUnitLeverPortal takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, leverPortals)
endfunction

function AddLever takes unit u, destructable d, unit sourcePortal, real sourcePortalX, real sourcePortalY, unit targetPortal, real targetPortalX, real targetPortalY, integer leverType returns Lever
    local Lever l = Lever.create()
    local integer count = GetUnitLeverCount(u)
    local integer handleId = GetHandleId(u)
    set l.u = u
    set l.d = d
    set l.sourcePortal = sourcePortal
    set l.sourcePortalX = sourcePortalX
    set l.sourcePortalY = sourcePortalY
    set l.targetPortal = targetPortal
    set l.targetPortalX = targetPortalX
    set l.targetPortalY = targetPortalY
    set l.leverType = leverType
    set levers[leversCount] = l
    set leversCount = leversCount + 1
    
    call GroupAddUnit(leverPortals, sourcePortal)
    call GroupAddUnit(leverPortals, targetPortal)
    
    call SaveInteger(h, handleId, KEY_INDEX + count, l)
    call SaveInteger(h, handleId, KEY_COUNT, count + 1)
    
    return l
endfunction

private function EnableLeverPortal takes Lever l returns nothing
    call WaygateActivate(l.sourcePortal, true)
    call WaygateSetDestination(l.sourcePortal, l.targetPortalX, l.targetPortalY)
    call WaygateActivate(l.targetPortal, true)
    call WaygateSetDestination(l.targetPortal, l.sourcePortalX, l.sourcePortalY)
endfunction

private function DisableLeverPortal takes Lever l returns nothing
    call WaygateActivate(l.sourcePortal, false)
    call WaygateActivate(l.targetPortal, false)
endfunction

function AddLeverGate takes unit lever, destructable gate returns nothing
    call AddLever(lever, gate, null, 0.0, 0.0, null, 0.0, 0.0, LEVER_TYPE_GATE)
    call KillDestructable(gate) // open
    call SetDestructableAnimation(gate, "death alternate")
endfunction

function AddLeverBridge takes unit lever, destructable bridge returns nothing
    call AddLever(lever, bridge, null, 0.0, 0.0, null, 0.0, 0.0, LEVER_TYPE_BRIDGE)
endfunction

function AddLeverPortal takes unit lever, unit sourcePortal, rect sourceRect, unit targetPortal, rect targetRect returns nothing
    local Lever l = AddLever(lever, null, sourcePortal, GetRectCenterX(sourceRect), GetRectCenterY(sourceRect), targetPortal, GetRectCenterX(targetRect), GetRectCenterY(targetRect), LEVER_TYPE_PORTAL)
    call EnableLeverPortal(l)
endfunction

function IsLeverGate takes integer unitTypeId returns boolean
    return unitTypeId == CLOSE_GATE or unitTypeId == OPEN_GATE
endfunction

function IsLeverBridge takes integer unitTypeId returns boolean
    return unitTypeId == MOVE_BRIDGE_DOWN or unitTypeId == MOVE_BRIDGE_UP
endfunction

function IsLeverPortal takes integer unitTypeId returns boolean
    return unitTypeId == DISABLE_PORTAL or unitTypeId == ENABLE_PORTAL
endfunction

function IsLeverUnit takes integer unitTypeId returns boolean
    return IsLeverGate(unitTypeId) or IsLeverBridge(unitTypeId) or IsLeverPortal(unitTypeId)
endfunction

function GetLeverType takes integer unitTypeId returns integer
    if (IsLeverBridge(unitTypeId)) then
        return LEVER_TYPE_BRIDGE
    elseif (IsLeverPortal(unitTypeId)) then
        return LEVER_TYPE_PORTAL
    endif
    
    return LEVER_TYPE_GATE
endfunction

function EnableAllLevers takes unit whichUnit returns nothing
    local integer i = 0
    local integer max = GetUnitLeverCount(whichUnit)
    loop
        exitwhen (i == max)
        call EnableLeverPortal(GetUnitLever(whichUnit, i))
        set i = i + 1
    endloop
endfunction

private function TriggerConditionSell takes nothing returns boolean
    local Lever l = 0
    local unit shop = GetSellingUnit()
    local unit u = GetSoldUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    local integer count = 0
    local integer i = 0
    if (IsLeverUnit(unitTypeId)) then
        set count = GetUnitLeverCount(shop)
        //call BJDebugMsg("Is lever unit type " + GetObjectName(unitTypeId) + " with count " + I2S(count) + " for shop " + GetUnitName(shop))
        set i = 0
        loop
            exitwhen (i >= count)
            set l = GetUnitLever(shop, i)
            if (l != 0 and GetLeverType(unitTypeId) == l.leverType) then
                if (IsLeverPortal(unitTypeId)) then
                    if (unitTypeId == ENABLE_PORTAL) then
                        call EnableLeverPortal(l)
                        call SetUnitAnimation(shop, "stand") // TODO Play this only if everything is enabled?
                    else
                        call DisableLeverPortal(l)
                        call SetUnitAnimation(shop, "stand alternate")
                    endif
                else
                    if (unitTypeId == MOVE_BRIDGE_UP or unitTypeId == CLOSE_GATE) then
                        call DestructableRestoreLife(l.d, GetDestructableMaxLife(l.d), true)
                        call SetDestructableAnimation(l.d, "stand")
                        if (unitTypeId == CLOSE_GATE) then
                            call PlaySoundOnDestructable(gg_snd_LargeCityGateOpen1, 100, l.d)
                        endif
                        call SetUnitAnimation(shop, "stand alternate")
                    else
                        call KillDestructable(l.d)
                        call SetDestructableAnimation(l.d, "death alternate")
                        if (unitTypeId == OPEN_GATE) then
                            call PlaySoundOnDestructable(gg_snd_LargeCityGateOpen1, 100, l.d)
                        endif
                        call SetUnitAnimation(shop, "stand")
                    endif
                endif
                
                exitwhen (true)
            endif
            set i = i + 1
        endloop
        call RemoveUnit(u)
    endif
    set u = null
    set shop = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
endfunction

endlibrary
