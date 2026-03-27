library WoWReforgedProfessionEngineer

function IsEngineerBuilding takes integer unitTypeId returns boolean
    if (unitTypeId == FLAME_TOWER) then
        return true
    elseif (unitTypeId == ADVANCED_FLAME_TOWER) then
        return true
    elseif (unitTypeId == COLD_TOWER) then
        return true
    elseif (unitTypeId == ADVANCED_COLD_TOWER) then
        return true
    elseif (unitTypeId == BOULDER_TOWER) then
        return true
    elseif (unitTypeId == ADANCED_BOULDER_TOWER) then
        return true
    elseif (unitTypeId == DEATH_TOWER) then
        return true
    elseif (unitTypeId == ADVANCED_DEATH_TOWER) then
        return true
    elseif (unitTypeId == POWER_GENERATOR_ENGINEER) then
        return true
    endif

    return false
endfunction

function IsUnitEngineerBuilding takes unit whichUnit returns boolean
    return IsEngineerBuilding(GetUnitTypeId(whichUnit))
endfunction

endlibrary
