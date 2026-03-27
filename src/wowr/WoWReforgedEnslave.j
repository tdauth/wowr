library WoWReforgedEnslave requires Utilities

globals
    constant integer UNIT_TYPE_ID = 'h05T'
endglobals

private function FilterIsTownHall takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL)
endfunction

function Enslave takes unit whichUnit, unit killer returns nothing
    local group g = CreateGroup()
    local unit townHall = null
    local unit slave = null
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(killer), Filter(function FilterIsTownHall))
    set townHall = GetClosestUnitGroup(GetUnitX(whichUnit), GetUnitY(whichUnit), g)
    if (townHall != null) then
        set slave = CreateUnit(GetOwningPlayer(killer), UNIT_TYPE_ID, GetUnitX(townHall), GetUnitY(townHall), GetUnitFacing(whichUnit))
        call BlzSetUnitSkin(slave, BlzGetUnitSkin(whichUnit))
        call UnitAddType(slave, UNIT_TYPE_SUMMONED)
        call RemoveUnit(whichUnit)
        set whichUnit = null
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

endlibrary
