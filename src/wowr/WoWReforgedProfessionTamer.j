library WoWReforgedProfessionTamer initializer Init

globals
    private player filterPlayer = Player(0)
    private trigger changeOwnerTrigger = CreateTrigger()
endglobals

private function FilterIsCage takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == CAGE_TAMER and GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function Multiply takes unit whichUnit returns nothing
    local integer id = GetUnitTypeId(whichUnit)
    local real x = GetUnitX(whichUnit)
    local real y = GetUnitY(whichUnit)
    local real face = GetUnitFacing(whichUnit)
    local group g = CreateGroup()
    local integer count = 0
    set filterPlayer = GetOwningPlayer(whichUnit)
    call GroupEnumUnitsInRange(g, x, y, 800.0, Filter(function FilterIsCage))
    set count = BlzGroupGetSize(g)
    if (count > 0) then
        loop
            set count = count - 1
            exitwhen (count < 0)
            call CreateUnit(filterPlayer, id, x, y, face)
        endloop
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChangeOwner takes nothing returns boolean
    if (not IsUnitType(GetTriggerUnit(), UNIT_TYPE_MECHANICAL)) then
        call Multiply(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))
endfunction

endlibrary
