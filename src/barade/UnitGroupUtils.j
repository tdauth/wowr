library UnitGroupUtils initializer Init

// Similar to GetUnitsOfTypeIdAll but for one single owner only.
function GetUnitsOfTypeId takes integer unitid, player owner returns group
    local group result = CreateGroup()
    set bj_groupEnumTypeId = unitid
    call GroupEnumUnitsOfPlayer(result, owner, filterGetUnitsOfTypeIdAll)
    return result
endfunction

globals
    private integer counterLivingPlayerUnitsOfTypeId = 0
    private boolexpr filterLivingPlayerUnitsOfTypeIdWithCount = null
endglobals

function CountLivingPlayerUnitsOfTypeIdFast takes integer unitId, player whichPlayer returns integer
    local group g = CreateGroup()
    set bj_livingPlayerUnitsTypeId = unitId
    set counterLivingPlayerUnitsOfTypeId = 0
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filterLivingPlayerUnitsOfTypeIdWithCount)
    call DestroyGroup(g)
    set g = null

    return counterLivingPlayerUnitsOfTypeId
endfunction

function LivingPlayerUnitsOfTypeIdFilterFast takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local boolean result = IsUnitAliveBJ(filterUnit) and GetUnitTypeId(filterUnit) == bj_livingPlayerUnitsTypeId
    if (result) then
        set counterLivingPlayerUnitsOfTypeId = counterLivingPlayerUnitsOfTypeId + 1
    endif
    return result
endfunction

private function Init takes nothing returns nothing
    set filterLivingPlayerUnitsOfTypeIdWithCount =  Filter(function LivingPlayerUnitsOfTypeIdFilterFast)
endfunction

endlibrary
