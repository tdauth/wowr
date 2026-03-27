library Tunnel initializer Init requires UnitEventEx, SimError, SelectionUtils

/*
 * The tunnel system allows loading units into tunnels and unloading them at any other tunnel building.
 *
 * It is realized by copying the loaded unit and loading it to all other tunnels by the player.
 */

globals
    public constant integer UNIT_TYPE_ID = NERUBIAN_TUNNEL
    public constant integer UNIT_TYPE_ID_2 = KOBOLD_TUNNEL
    public constant integer UNIT_TYPE_ID_3 = GOBLIN_TUNNEL
    public constant integer REGENERATION_ABILITY_ID = 'A1DK'

    private group loaded = CreateGroup()
    private group copies = CreateGroup()
    private trigger loadTrigger = CreateTrigger()
    private trigger constructionTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    
    private unit tmpUnit = null
    
    private constant integer KEY_SOURCE = 0
    private constant integer KEY_TUNNEL = 1
    private constant integer KEY_X = 2
    private constant integer KEY_Y = 3
endglobals

private function IsLoaded takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, loaded)
endfunction

private function IsCopy takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, copies)
endfunction

private function IsCopyOf takes unit whichUnit, unit source returns boolean
    return LoadUnitHandle(h, GetHandleId(whichUnit), KEY_SOURCE) == source
endfunction

private function GetCopySource takes unit whichUnit returns unit
    return LoadUnitHandle(h, GetHandleId(whichUnit), KEY_SOURCE) 
endfunction

private function GetTunnel takes unit whichUnit returns unit
    return LoadUnitHandle(h, GetHandleId(whichUnit), KEY_TUNNEL) 
endfunction

private function MoveToUnloadPosition takes unit whichUnit returns nothing
    local integer handleId = GetHandleId(whichUnit)
    if (HaveSavedReal(h, handleId, KEY_X)) then
        call SetUnitX(whichUnit, LoadReal(h, handleId, KEY_X))
        call SetUnitY(whichUnit, LoadReal(h, handleId, KEY_Y))
    endif
endfunction

private function SetUnloadPosition takes unit whichUnit, real x, real y returns nothing
    local integer handleId = GetHandleId(whichUnit)
    call SaveReal(h, handleId, KEY_X, x)
    call SaveReal(h, handleId, KEY_Y, y)
endfunction

private function CopyUnit takes unit whichUnit, real x, real y, real face returns unit
    local unit copy = CreateUnit(GetOwningPlayer(whichUnit), GetUnitTypeId(whichUnit), x, y, face)
    call SetUnitUseFood(copy, false)
    call SetUnitInvulnerable(copy, true)
    if (IsUnitType(copy, UNIT_TYPE_HERO)) then
        call BlzSetUnitBooleanField(copy, UNIT_BF_HERO_HIDE_HERO_INTERFACE_ICON, true)
    endif
    call GroupAddUnit(copies, copy)
    call SaveUnitHandle(h, GetHandleId(copy), KEY_SOURCE, whichUnit)
    
    return copy
endfunction

function IsTunnel takes integer unitTypeId returns boolean
    if (unitTypeId == UNIT_TYPE_ID) then
        return true
    elseif (unitTypeId == UNIT_TYPE_ID_2) then
        return true
    endif
    return false
endfunction

function IsUnitTunnel takes unit whichUnit returns boolean
    return IsTunnel(GetUnitTypeId(whichUnit))
endfunction

private function FilterIsDifferentTunnel takes nothing returns boolean
    return IsUnitTunnel(GetFilterUnit()) and GetTunnel(tmpUnit) != GetFilterUnit()
endfunction

private function CreateCopies takes unit whichUnit returns nothing
    local player owner = GetOwningPlayer(whichUnit)
    local group tunnels = CreateGroup()
    local unit tunnel = null
    local integer i = 0
    local integer max = 0
    local real x = 0.0
    local real y = 0.0
    local real face = 0.0
    set tmpUnit = whichUnit
    call GroupEnumUnitsOfPlayer(tunnels, GetOwningPlayer(whichUnit), Filter(function FilterIsDifferentTunnel))
    set max = BlzGroupGetSize(tunnels)
    set i = 0
    loop
        exitwhen (i == max)
        set tunnel = BlzGroupUnitAt(tunnels, i)
        if (GetOwningPlayer(tunnel) == owner) then
            set x = GetUnitX(tunnel)
            set y = GetUnitY(tunnel)
            set face = GetUnitFacing(tunnel)
            call BlzQueueTargetOrderById(tunnel, OrderId("load"), CopyUnit(whichUnit, x, y, face))
            //call IssueTargetOrder(tunnel, "load", CopyUnit(whichUnit, x, y, face))
        endif
        set i = i + 1
    endloop
    call GroupClear(tunnels)
    call DestroyGroup(tunnels)
    set tunnels = null
    set owner = null
endfunction

private function CreateExistingCopies takes unit tunnel returns nothing
    local player owner = GetOwningPlayer(tunnel)
    local real x = GetUnitX(tunnel)
    local real y = GetUnitY(tunnel)
    local real face = GetUnitFacing(tunnel)
    local unit u = null
    local integer i = 0
    local integer max = BlzGroupGetSize(loaded)
    loop
        exitwhen (i == max)
        set u = BlzGroupUnitAt(loaded, i)
        if (GetOwningPlayer(u) == owner) then
            call IssueTargetOrder(tunnel, "load", CopyUnit(u, x, y, face))
        endif
        set u = null
        set i = i + 1
    endloop
    set owner = null
endfunction

private function ForGroupClearCopy takes nothing returns nothing
    if (IsCopyOf(GetEnumUnit(), tmpUnit)) then
        call GroupRemoveUnit(copies, GetEnumUnit())
        call FlushChildHashtable(h, GetHandleId(GetEnumUnit()))
        call ShowUnit(GetEnumUnit(), false)
        call RemoveUnit(GetEnumUnit())
    endif
endfunction

private function ClearCopies takes unit source returns nothing
    set tmpUnit = source
    call ForGroup(copies, function ForGroupClearCopy)
endfunction

private function FilterIsTunnel takes nothing returns boolean
    return IsUnitTunnel(GetFilterUnit())
endfunction

private function GetSelectedTunnel takes player whichPlayer returns unit
    local group tunnels = CreateGroup()
    local unit tunnel = null
    call SyncSelections()
    call GroupEnumUnitsOfPlayer(tunnels, whichPlayer, Filter(function FilterIsTunnel))
    set tunnel = GetNextUnitToSelect(tunnels , whichPlayer)
    call GroupClear(tunnels)
    call DestroyGroup(tunnels)
    set tunnels = null
    return tunnel
endfunction

function GetNextTunnel takes player whichPlayer returns unit
    local group tunnels = CreateGroup()
    local unit tunnel = null
    local integer i = 0
    local integer max = 0
    local unit selectedTunnel = GetSelectedTunnel(whichPlayer)
    local boolean foundSelectedTunnel = false
    local boolean foundNewTunnel = false
    call GroupEnumUnitsOfPlayer(tunnels, whichPlayer, Filter(function FilterIsTunnel))
    set max = BlzGroupGetSize(tunnels)
    set i = 0
    loop
        exitwhen (i == max or foundNewTunnel)
        set tunnel = BlzGroupUnitAt(tunnels, i)
        if (selectedTunnel == null or foundSelectedTunnel) then
            set selectedTunnel = tunnel
            set foundNewTunnel = true
        elseif (tunnel == selectedTunnel) then
            set foundSelectedTunnel = true
        endif
        set i = i + 1
    endloop
    
    if (not foundNewTunnel) then
        set selectedTunnel = FirstOfGroup(tunnels)
    endif
    
    call GroupClear(tunnels)
    call DestroyGroup(tunnels)
    set tunnels = null
    return selectedTunnel
endfunction

private function TriggerConditionLoad takes nothing returns boolean
    local unit transportUnit = GetTransportUnit()
    local unit loadedUnit = GetLoadedUnit()
    if (IsCopy(loadedUnit)) then
        call UnitAddAbility(loadedUnit, REGENERATION_ABILITY_ID)
        call SaveUnitHandle(h, GetHandleId(loadedUnit), KEY_TUNNEL, transportUnit)
    elseif (IsUnitTunnel(transportUnit)) then
        call UnitAddAbility(loadedUnit, REGENERATION_ABILITY_ID)
        call SaveUnitHandle(h, GetHandleId(loadedUnit), KEY_TUNNEL, transportUnit)
        call GroupAddUnit(loaded, loadedUnit)
        call CreateCopies(loadedUnit)
    endif
    set transportUnit = null
    set loadedUnit = null
    return false
endfunction

private function TriggerFunctionUnload takes nothing returns nothing
    local unit eventUnit = GetEventUnit()
    local unit source = null
    if (IsLoaded(eventUnit)) then
        call UnitRemoveAbility(eventUnit, REGENERATION_ABILITY_ID)
        call MoveToUnloadPosition(eventUnit)
        call ClearCopies(eventUnit)
        call GroupRemoveUnit(loaded, eventUnit)
        call FlushChildHashtable(h, GetHandleId(eventUnit))
    elseif (IsCopy(eventUnit)) then
        call UnitRemoveAbility(eventUnit, REGENERATION_ABILITY_ID)
        set source = GetCopySource(eventUnit)
        call SetUnloadPosition(source, GetUnitX(eventUnit), GetUnitY(eventUnit))
        call IssueTargetOrder(GetTunnel(source), "unload", source)
        call ClearCopies(eventUnit)
    endif
    set eventUnit = null
endfunction

private function TriggerConditionConstructed takes nothing returns boolean
    local unit building = GetConstructedStructure()
    if (IsUnitTunnel(building)) then
        call CreateExistingCopies(building)
    endif
    set building = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(loadTrigger, EVENT_PLAYER_UNIT_LOADED)
    call TriggerAddCondition(loadTrigger, Condition(function TriggerConditionLoad))
    
    call RegisterNativeEvent(EVENT_ON_CARGO_UNLOAD, function TriggerFunctionUnload)
    
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionTrigger, Condition(function TriggerConditionConstructed))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call GroupRemoveUnit(loaded, whichUnit)
    call GroupRemoveUnit(copies, whichUnit)
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
