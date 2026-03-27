library WoWReforgedPortals initializer Init requires WoWReforgedZones, WoWReforgedI18n, WoWReforgedAntimagicWards, WoWReforgedMapData

globals
    private constant integer ABILITY_ID_SELECT_DESTINATION = 'A05U'
    private constant integer ABILITY_ID_SELECT_LOCATION = 'A0MG'
    private constant integer ABILITY_ID_CONNECT_WITH_DESTINATION = 'A0MF'
    private constant integer ABILITY_ID_PING_DESTINATION = 'A05W'
    private constant integer ABILITY_ID_DISABLE_PORTAL = 'A05V'

    private constant integer KEY_TARGET = 0
    private constant integer KEY_SOURCES = 1

    private boolean initialized = false
    private hashtable h = InitHashtable()
    private group portals = CreateGroup()
    private trigger constructFinishedTrigger = CreateTrigger()
    private trigger upgradeFinishTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
endglobals

function IsPortal takes integer unitTypeId returns boolean
    return unitTypeId == PORTAL or unitTypeId == PORTAL_NEUTRAL or unitTypeId == PORTAL_NEUTRAL_WATER
endfunction

function HasPortalAbilities takes integer unitTypeId returns boolean
    if (IsPortal(unitTypeId)) then
        return true
    elseif (unitTypeId == HIDEOUT) then
        return true
    elseif (unitTypeId == FORTIFIED_HIDEOUT) then
        return true
    elseif (unitTypeId == GUARDIANS_CITADEL) then
        return true
    elseif (unitTypeId == TEMPLE_OF_DARKNESS) then
        return true
    elseif (unitTypeId == TEMPLE_OF_LIGHT) then
        return true
    endif
    return true
endfunction

function UpdatePortalName takes unit whichUnit, boolean activate, real destinationX, real destinationY returns nothing
    local Zone zone = 0
    
    if (activate) then
        set zone = GetZoneByCoordinates(destinationX, destinationY)
        if (zone != 0) then
            call BlzSetUnitName(whichUnit, Format(GetLocalizedString("PORTAL_TO")).s(GetZoneName(zone)).result())
            call SetUnitColor(whichUnit, GetZoneColor(zone))
        else
            call BlzSetUnitName(whichUnit, GetLocalizedString("PORTAL"))
            call SetUnitColor(whichUnit, GetPlayerColor(GetOwningPlayer(whichUnit)))
        endif
    else
        call BlzSetUnitName(whichUnit, GetLocalizedString("DISABLED_PORTAL"))
        call SetUnitColor(whichUnit, GetPlayerColor(GetOwningPlayer(whichUnit)))
    endif
endfunction

function UpdatePortalNameByItself takes unit whichUnit returns nothing
    call UpdatePortalName(whichUnit, WaygateIsActive(whichUnit), WaygateGetDestinationX(whichUnit), WaygateGetDestinationY(whichUnit))
endfunction

function AddPortal takes unit whichUnit returns nothing
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    if (HasPortalAbilities(unitTypeId)) then
        call GroupAddUnit(portals, whichUnit)
    endif
endfunction

function IsUnitInPortalGroup takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, portals)
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    local unit u = GetConstructedStructure()
    local integer unitTypeId = GetUnitTypeId(u)
    if (IsPortal(unitTypeId)) then
        call UpdatePortalNameByItself(u)
    endif
    if (HasPortalAbilities(unitTypeId)) then
        call GroupAddUnit(portals, u)
    endif
    set u = null
    return false
endfunction

private function TriggerConditionUpgradeFinish takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    if (HasPortalAbilities(unitTypeId)) then
        call GroupAddUnit(portals, u)
    endif
    set u = null
    return false
endfunction

private function RemovePortalEnum takes nothing returns nothing
    call WaygateActivate(GetEnumUnit(), false)
endfunction

private function ClearPortalSources takes unit whichUnit returns nothing
    local integer handleId = GetHandleId(whichUnit)
    local group sources = null
    if (HaveSavedHandle(h, handleId, KEY_SOURCES)) then
        set sources = LoadGroupHandle(h, handleId, KEY_SOURCES)
        call ForGroup(sources, function RemovePortalEnum)
        call DestroyGroup(sources)
        set sources = null
    endif
    call FlushChildHashtable(h, handleId)
endfunction

private function AddPortalSource takes unit portal, unit source returns nothing
    local integer handleId = GetHandleId(portal)
    local group sources = LoadGroupHandle(h, handleId, KEY_SOURCES)
    if (sources == null) then
        set sources = CreateGroup()
    endif
    call GroupAddUnit(sources, source)
    call SaveGroupHandle(h, handleId, 0, sources)
endfunction

private function RemovePortal takes unit whichUnit returns nothing
   if (IsUnitInPortalGroup(whichUnit)) then
        call GroupRemoveUnit(portals, whichUnit)
        call ClearPortalSources(whichUnit)
    endif
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    call RemovePortal(GetTriggerUnit())
    return false
endfunction

private function SelectPortalDestination takes unit whichUnit, unit destination returns nothing
    local real x = GetUnitX(destination)
    local real y = GetUnitY(destination)
    if (IsUnitInPortalGroup(destination)) then
        if (not IsAreaPortectedByAntimagicWard(GetOwningPlayer(whichUnit), x, y)) then
            call WaygateActivate(whichUnit, true)
            call WaygateSetDestination(whichUnit, x, y)
            call PingMinimapForPlayer(GetOwningPlayer(whichUnit), x, y, 4.0)
            call DisableTrigger(orderTrigger)
            call IssueTargetOrder(whichUnit, "setrally", destination)
            call EnableTrigger(orderTrigger)
            call SaveUnitHandle(h, GetHandleId(whichUnit), KEY_TARGET, destination)
            call AddPortalSource(destination, whichUnit)
        else
            call IssueImmediateOrder(whichUnit, "stop")
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("AREA_PROTECTED_BY_ANTIMAGIC_WARD"))
        endif
    else
        call IssueImmediateOrder(whichUnit, "stop")
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("TARGET_MUST_BE_A_PORTAL"))
    endif
endfunction

private function SelectPortalDestinationLocation takes unit whichUnit, real x, real y returns nothing
    if (MapLocationCanBeTeleportedTo(whichUnit, x, y)) then
        if (not IsAreaPortectedByAntimagicWard(GetOwningPlayer(whichUnit), x, y)) then
            call WaygateActivate(whichUnit, true)
            call WaygateSetDestination(whichUnit, x, y)
            call PingMinimapForPlayer(GetOwningPlayer(whichUnit), x, y, 4.0)
            call DisableTrigger(orderTrigger)
            call IssuePointOrder(whichUnit, "setrally", x, y)
            call EnableTrigger(orderTrigger)
            call RemoveSavedHandle(h, GetHandleId(whichUnit), KEY_TARGET)
        else
            call IssueImmediateOrder(whichUnit, "stop")
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("AREA_PROTECTED_BY_ANTIMAGIC_WARD"))
        endif
    else
        call IssueImmediateOrder(whichUnit, "stop")
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("CANNOT_TELEPORT_INTO_THIS_AREA"))
    endif
endfunction

private function DisablePortal takes unit whichUnit returns nothing
    local integer handleId = GetHandleId(whichUnit)
    local unit target = null
    call WaygateActivate(whichUnit, false)
    if (HaveSavedHandle(h, handleId, KEY_TARGET)) then
        set target = LoadUnitHandle(h, handleId, KEY_TARGET)
        if (HaveSavedHandle(h, GetHandleId(target), KEY_SOURCES)) then
            call GroupRemoveUnit(LoadGroupHandle(h, GetHandleId(target), KEY_SOURCES), whichUnit)
        endif
        call RemoveSavedHandle(h, handleId, KEY_TARGET)
    endif
endfunction

private function PingPortalDestination takes unit whichUnit returns nothing
    if (WaygateIsActive(whichUnit)) then
        call PingMinimapForPlayer(GetOwningPlayer(whichUnit), WaygateGetDestinationX(whichUnit), WaygateGetDestinationY(whichUnit), 4.0)
    else
        call IssueImmediateOrder(whichUnit, "stop")
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("PORTAL_IS_DISABLED"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local unit u = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    if (IsUnitInPortalGroup(u)) then
        if (abilityId == ABILITY_ID_SELECT_DESTINATION) then
            call SelectPortalDestination(u, target)
        elseif (abilityId == ABILITY_ID_SELECT_LOCATION) then
            call SelectPortalDestinationLocation(u, GetSpellTargetX(), GetSpellTargetY())
        elseif (abilityId == ABILITY_ID_CONNECT_WITH_DESTINATION) then
            call SelectPortalDestination(u, target)
            call SelectPortalDestination(target, u)
        elseif (abilityId == ABILITY_ID_DISABLE_PORTAL) then
            call DisablePortal(u)
        elseif (abilityId == ABILITY_ID_PING_DESTINATION) then
            call PingPortalDestination(u)
        endif
    endif
    set u = null
    set target = null
    return false
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    if (IsUnitInPortalGroup(GetTriggerUnit()) and GetIssuedOrderId() == OrderId("setrally")) then
        if (GetOrderTargetUnit() != null) then
            if (IsUnitInPortalGroup(GetOrderTargetUnit())) then
                call SelectPortalDestination(GetTriggerUnit(), GetOrderTargetUnit())
                if (GetOwningPlayer(GetOrderTargetUnit()) == GetOwningPlayer(GetTriggerUnit())) then
                    call SelectPortalDestination(GetOrderTargetUnit(), GetTriggerUnit())
                endif
            else
                call SelectPortalDestinationLocation(GetTriggerUnit(), GetUnitX(GetOrderTargetUnit()), GetUnitY(GetOrderTargetUnit()))
            endif
        elseif (GetOrderTargetItem() != null) then
            call SelectPortalDestinationLocation(GetTriggerUnit(), GetItemX(GetOrderTargetItem()), GetItemY(GetOrderTargetItem()))
        elseif (GetOrderTargetDestructable() != null) then
            call SelectPortalDestinationLocation(GetTriggerUnit(), GetDestructableX(GetOrderTargetDestructable()), GetDestructableY(GetOrderTargetDestructable()))
        elseif (GetPlayerTechCountSimple(UPG_ARCANE_PORTALS, GetOwningPlayer(GetTriggerUnit())) > 0) then
            call SelectPortalDestinationLocation(GetTriggerUnit(), GetOrderPointX(), GetOrderPointY())
        endif
    endif
    return false
endfunction

private function FilterIsEnemyPortal takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == PORTAL and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(tmpAntimagicWard))
endfunction

private function EnumDisablePortal takes nothing returns nothing
    call DisablePortal(GetEnumUnit())
endfunction

private function TriggerActionPlaceAntimagicWard takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRange(g, GetUnitX(tmpAntimagicWard), GetUnitY(tmpAntimagicWard), WoWReforgedAntimagicWards_MAX_DISTANCE, Filter(function FilterIsEnemyPortal))
    call ForGroup(g, function EnumDisablePortal)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Init takes nothing returns nothing
    set initialized = true
    
    call TriggerRegisterAnyUnitEventBJ(constructFinishedTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishedTrigger, Condition(function TriggerConditionConstructFinish))
    
    call TriggerRegisterAnyUnitEventBJ(upgradeFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(upgradeFinishTrigger, Condition(function TriggerConditionUpgradeFinish))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    
    call TriggerAddAction(antimagicWardPlacementTrigger, function TriggerActionPlaceAntimagicWard)
endfunction

private function HookWaygateActivate takes unit waygate, boolean activate returns nothing
    if (initialized and IsPortal(GetUnitTypeId(waygate))) then
        call UpdatePortalName(waygate, activate, WaygateGetDestinationX(waygate), WaygateGetDestinationY(waygate))
    endif
endfunction

private function HookWaygateActivateBJ takes boolean activate, unit waygate returns nothing
    if (initialized and IsPortal(GetUnitTypeId(waygate))) then
        call UpdatePortalName(waygate, activate, WaygateGetDestinationX(waygate), WaygateGetDestinationY(waygate))
    endif
endfunction

private function HookWaygateSetDestination takes unit waygate, real x, real y returns nothing
    if (initialized and IsPortal(GetUnitTypeId(waygate))) then
        call UpdatePortalName(waygate, WaygateIsActive(waygate), x, y)
    endif
endfunction

private function HookWaygateSetDestinationLocBJ takes unit waygate, location loc returns nothing
    if (initialized and IsPortal(GetUnitTypeId(waygate))) then
        call UpdatePortalName(waygate, WaygateIsActive(waygate), GetLocationX(loc), GetLocationY(loc))
    endif
endfunction

hook WaygateActivate HookWaygateActivate
hook WaygateActivateBJ HookWaygateActivateBJ
hook WaygateSetDestination HookWaygateSetDestination
hook WaygateSetDestinationLocBJ HookWaygateSetDestinationLocBJ
hook RemoveUnit RemovePortal

endlibrary
