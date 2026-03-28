library WoWReforgedRacesLimits initializer Init requires WoWReforgedUtils, WoWReforgedRaces

function SetRacesLimits takes integer housingLimit, integer towerLimit returns nothing
    local integer max = GetRacesMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_HOUSING) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_HOUSING), housingLimit)
        endif

        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SCOUT_TOWER) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SCOUT_TOWER), towerLimit)
        endif
        
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_GUARD_TOWER) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_GUARD_TOWER), towerLimit)
        endif
        
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_CANNON_TOWER) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_CANNON_TOWER), towerLimit)
        endif
        
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_ARCANE_TOWER) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_ARCANE_TOWER), towerLimit)
        endif
        
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING), 1)
        endif
        
        if (GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2) != 0) then
            call SetTechMaxAllowed(GetRaceObjectTypeId(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2), 1)
        endif
        set i = i + 1
    endloop
endfunction

function AddRacesLimits takes nothing returns nothing
    call SetRacesLimits(4, 15)
endfunction

function ResetRacesLimits takes nothing returns nothing
    call SetRacesLimits(-1, -1)
endfunction

private function Init takes nothing returns nothing
    call AddRacesLimits()
endfunction

endlibrary
