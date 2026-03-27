library WoWReforgedStandardObjectFields requires WoWReforgedRaces, WoWReforgedEquipment, WoWReforgedObjectMappings

private function AddObjectDependencyEquivalents takes integer whichRace, integer t0, integer t1 returns nothing
    if (GetRaceObjectTypeId(whichRace, t0) != 0 and GetRaceObjectTypeId(whichRace, t1) != 0 and GetRaceObjectTypeId(whichRace, t0) != GetRaceObjectTypeId(whichRace, t1)) then
        call AddDependencyEquivalents(GetRaceObjectTypeId(whichRace, t0), GetRaceObjectTypeId(whichRace, t1))
    endif
endfunction

private function AddObjectMappingTinyItem takes integer whichRace, integer t0, integer t1 returns nothing
    if (GetRaceObjectTypeId(whichRace, t0) != 0 and GetRaceObjectTypeId(whichRace, t1) != 0) then
        call AddObjectMapping(GetRaceObjectTypeId(whichRace, t0), GetRaceObjectTypeId(whichRace, t1))
    endif
endfunction

function AddRaceStandardObjectIdFields takes nothing returns nothing
    local integer max = GetRacesMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        call AddObjectDependencyEquivalents(i, RACE_OBJECT_TYPE_TIER_1, RACE_OBJECT_TYPE_TIER_2)
        call AddObjectDependencyEquivalents(i, RACE_OBJECT_TYPE_TIER_1, RACE_OBJECT_TYPE_TIER_3)
        call AddObjectDependencyEquivalents(i, RACE_OBJECT_TYPE_SCOUT_TOWER, RACE_OBJECT_TYPE_GUARD_TOWER)
        call AddObjectDependencyEquivalents(i, RACE_OBJECT_TYPE_SCOUT_TOWER, RACE_OBJECT_TYPE_CANNON_TOWER)
        call AddObjectDependencyEquivalents(i, RACE_OBJECT_TYPE_SCOUT_TOWER, RACE_OBJECT_TYPE_ARCANE_TOWER)
        
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_TIER_1, RACE_OBJECT_TYPE_TIER_1_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_TIER_2, RACE_OBJECT_TYPE_TIER_2_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_TIER_3, RACE_OBJECT_TYPE_TIER_3_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_FARM, RACE_OBJECT_TYPE_FARM_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_ALTAR, RACE_OBJECT_TYPE_ALTAR_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_MILL, RACE_OBJECT_TYPE_MILL_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_BLACK_SMITH, RACE_OBJECT_TYPE_BLACK_SMITH_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_BARRACKS, RACE_OBJECT_TYPE_BARRACKS_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_WORKSHOP, RACE_OBJECT_TYPE_WORKSHOP_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_ARCANE_SANCTUM, RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SCOUT_TOWER, RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_GUARD_TOWER, RACE_OBJECT_TYPE_GUARD_TOWER_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_CANNON_TOWER, RACE_OBJECT_TYPE_CANNON_TOWER_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_ARCANE_TOWER, RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SHOP, RACE_OBJECT_TYPE_SHOP_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_GRYPHON_AVIARY, RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SACRIFICIAL_PIT, RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_HOUSING, RACE_OBJECT_TYPE_HOUSING_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SHIPYARD, RACE_OBJECT_TYPE_SHIPYARD_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING, RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM)
        call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2_ITEM)
        //call AddObjectMappingTinyItem(i, RACE_OBJECT_TYPE_MINE, RACE_OBJECT_TYPE_MINE_ITEM)
        
        set i = i + 1
    endloop
endfunction

endlibrary
