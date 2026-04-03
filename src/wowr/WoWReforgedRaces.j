library WoWReforgedRaces initializer Init requires WoWReforgedUtils, WoWReforgedVIPs, WoWReforgedDependencyEquivalents, WoWReforgedObjectMappings, WoWReforgedResearches

globals
    constant integer RACE_OBJECT_TYPE_NONE = 0
    // BUILDINGS
    constant integer RACE_OBJECT_TYPE_FARM = 1
    constant integer RACE_OBJECT_TYPE_ALTAR = 2
    constant integer RACE_OBJECT_TYPE_MILL = 3
    constant integer RACE_OBJECT_TYPE_BLACK_SMITH = 4
    constant integer RACE_OBJECT_TYPE_BARRACKS = 5
    constant integer RACE_OBJECT_TYPE_SHOP = 6
    constant integer RACE_OBJECT_TYPE_SCOUT_TOWER = 7
    constant integer RACE_OBJECT_TYPE_GUARD_TOWER = 8
    constant integer RACE_OBJECT_TYPE_CANNON_TOWER = 9
    constant integer RACE_OBJECT_TYPE_ARCANE_TOWER = 10
    constant integer RACE_OBJECT_TYPE_ARCANE_SANCTUM = 11
    constant integer RACE_OBJECT_TYPE_WORKSHOP = 12
    constant integer RACE_OBJECT_TYPE_GRYPHON_AVIARY = 13
    constant integer RACE_OBJECT_TYPE_SACRIFICIAL_PIT = 14
    constant integer RACE_OBJECT_TYPE_TIER_1 = 15
    constant integer RACE_OBJECT_TYPE_TIER_2 = 16
    constant integer RACE_OBJECT_TYPE_TIER_3 = 17
    constant integer RACE_OBJECT_TYPE_HOUSING = 18
    constant integer RACE_OBJECT_TYPE_MINE = 19
    constant integer RACE_OBJECT_TYPE_SHIPYARD = 20
    constant integer RACE_OBJECT_TYPE_SHIPYARD_2 = 21
    constant integer RACE_OBJECT_TYPE_SPECIAL_BUILDING = 22
    constant integer RACE_OBJECT_TYPE_SPECIAL_BUILDING_2 = 23
    // ITEMS
    constant integer RACE_OBJECT_TYPE_SCEPTER_ITEM = 24
    constant integer RACE_OBJECT_TYPE_TIER_1_ITEM = 25
    constant integer RACE_OBJECT_TYPE_TIER_2_ITEM = 26
    constant integer RACE_OBJECT_TYPE_TIER_3_ITEM = 27
    constant integer RACE_OBJECT_TYPE_FARM_ITEM = 28
    constant integer RACE_OBJECT_TYPE_ALTAR_ITEM = 29
    constant integer RACE_OBJECT_TYPE_MILL_ITEM = 30
    constant integer RACE_OBJECT_TYPE_BLACK_SMITH_ITEM = 31
    constant integer RACE_OBJECT_TYPE_BARRACKS_ITEM = 32
    constant integer RACE_OBJECT_TYPE_SHOP_ITEM = 33
    constant integer RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM = 34
    constant integer RACE_OBJECT_TYPE_GUARD_TOWER_ITEM = 35
    constant integer RACE_OBJECT_TYPE_CANNON_TOWER_ITEM = 36
    constant integer RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM = 37
    constant integer RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM = 38
    constant integer RACE_OBJECT_TYPE_WORKSHOP_ITEM = 39
    constant integer RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM = 40
    constant integer RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM = 41
    constant integer RACE_OBJECT_TYPE_HOUSING_ITEM = 42
    constant integer RACE_OBJECT_TYPE_SHIPYARD_ITEM = 43
    constant integer RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM = 44
    constant integer RACE_OBJECT_TYPE_SPECIAL_BUILDING_2_ITEM = 45
    // UNITS
    constant integer RACE_OBJECT_TYPE_WORKER = 46
    constant integer RACE_OBJECT_TYPE_MALE_CITIZEN = 47
    constant integer RACE_OBJECT_TYPE_TOWN_HALL_3 = 48
    constant integer RACE_OBJECT_TYPE_TOWN_HALL_4 = 49
    constant integer RACE_OBJECT_TYPE_FEMALE_CITIZEN = 50
    constant integer RACE_OBJECT_TYPE_CHILD = 51
    constant integer RACE_OBJECT_TYPE_PET = 52
    constant integer RACE_OBJECT_TYPE_FOOTMAN = 53
    constant integer RACE_OBJECT_TYPE_RIFLEMAN = 54
    constant integer RACE_OBJECT_TYPE_KNIGHT = 55
    constant integer RACE_OBJECT_TYPE_BARRACKS_4 = 56
    constant integer RACE_OBJECT_TYPE_PRIEST = 57
    constant integer RACE_OBJECT_TYPE_SORCERESS = 58
    constant integer RACE_OBJECT_TYPE_SPELLBREAKER = 59
    constant integer RACE_OBJECT_TYPE_ARCANE_SANCTUM_4 = 60
    constant integer RACE_OBJECT_TYPE_FLYING_MACHINE = 61
    constant integer RACE_OBJECT_TYPE_SIEGE_ENGINE = 62
    constant integer RACE_OBJECT_TYPE_MORTAR = 63
    constant integer RACE_OBJECT_TYPE_WORKSHOP_4 = 64
    constant integer RACE_OBJECT_TYPE_GRYPHON = 65
    constant integer RACE_OBJECT_TYPE_DRAGONHAWK = 66
    constant integer RACE_OBJECT_TYPE_AVIARY_3 = 67
    constant integer RACE_OBJECT_TYPE_AVIARY_4 = 68
    constant integer RACE_OBJECT_TYPE_TAUREN = 69
    constant integer RACE_OBJECT_TYPE_SHADE = 70
    constant integer RACE_OBJECT_TYPE_TRANSPORT_SHIP = 71
    constant integer RACE_OBJECT_TYPE_FRIGATE = 72
    constant integer RACE_OBJECT_TYPE_BATTLESHIP = 73
    constant integer RACE_OBJECT_TYPE_SHIP_SPECIAL_1 = 74
    constant integer RACE_OBJECT_TYPE_SHIP_SPECIAL_2 = 75

    constant integer RACE_MAX_OBJECT_TYPES = 76
    
    private hashtable objectTypeHashTable = InitHashtable()
    private integer array objectTypeIds
    
    private integer array objectTypeAbilities
    private integer array objectTypeAbilitiesLevels
    private integer array objectTypeAbilitiesRace
    private integer objectTypeAbilitiesCounter = 0

    private integer racesCounter = 0
endglobals

function GetRacesMax takes nothing returns integer
    return racesCounter
endfunction

function GetPlayerRace1 takes player whichPlayer returns integer
    return udg_PlayerRace[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerRace2 takes player whichPlayer returns integer
    return udg_PlayerRace2[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerRace3 takes player whichPlayer returns integer
    return udg_PlayerRace3[GetConvertedPlayerId(whichPlayer)]
endfunction

function PlayerHasRace takes player whichPlayer, integer whichRace returns boolean
    return GetPlayerRace1(whichPlayer) == whichRace or GetPlayerRace2(whichPlayer) == whichRace or GetPlayerRace3(whichPlayer) == whichRace
endfunction

function IsRaceUnit takes integer t returns boolean
    if (t == RACE_OBJECT_TYPE_WORKER) then
        return true
    elseif (t == RACE_OBJECT_TYPE_MALE_CITIZEN) then
        return true
    elseif (t == RACE_OBJECT_TYPE_FEMALE_CITIZEN) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TOWN_HALL_4) then
        return true
    elseif (t == RACE_OBJECT_TYPE_PET) then
        return true
    elseif (t == RACE_OBJECT_TYPE_FOOTMAN) then
        return true
    elseif (t == RACE_OBJECT_TYPE_RIFLEMAN) then
        return true
    elseif (t == RACE_OBJECT_TYPE_KNIGHT) then
        return true
    elseif (t == RACE_OBJECT_TYPE_PRIEST) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SORCERESS) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SPELLBREAKER) then
        return true
   elseif (t == RACE_OBJECT_TYPE_ARCANE_SANCTUM_4) then
        return true 
    elseif (t == RACE_OBJECT_TYPE_SIEGE_ENGINE) then
        return true
    elseif (t == RACE_OBJECT_TYPE_MORTAR) then
        return true
    elseif (t == RACE_OBJECT_TYPE_GRYPHON) then
        return true
    elseif (t == RACE_OBJECT_TYPE_DRAGONHAWK) then
        return true
    elseif (t == RACE_OBJECT_TYPE_AVIARY_3) then
        return true
    elseif (t == RACE_OBJECT_TYPE_AVIARY_4) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TAUREN) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHADE) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TRANSPORT_SHIP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_FRIGATE) then
        return true
    elseif (t == RACE_OBJECT_TYPE_BATTLESHIP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIP_SPECIAL_1) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIP_SPECIAL_2) then
        return true
    endif
    return false
endfunction

function IsRaceItem takes integer t returns boolean
    if (t == RACE_OBJECT_TYPE_SCEPTER_ITEM) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_1_ITEM) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_2_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_3_ITEM) then
        return true
    elseif (t == RACE_OBJECT_TYPE_FARM_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_ALTAR_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_MILL_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_BLACK_SMITH_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_BARRACKS_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_SHOP_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_GUARD_TOWER_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_CANNON_TOWER_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_WORKSHOP_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_HOUSING_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIPYARD_ITEM) then    
        return true
    elseif (t == RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM) then    
        return true
    endif
    return false
endfunction

function IsRaceBuilding takes integer t returns boolean
    if (t == RACE_OBJECT_TYPE_FARM) then
        return true
    elseif (t == RACE_OBJECT_TYPE_ALTAR) then
        return true
    elseif (t == RACE_OBJECT_TYPE_MILL) then
        return true
    elseif (t == RACE_OBJECT_TYPE_BLACK_SMITH) then
        return true
    elseif (t == RACE_OBJECT_TYPE_BARRACKS) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHOP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SCOUT_TOWER) then
        return true
    elseif (t == RACE_OBJECT_TYPE_GUARD_TOWER) then
        return true
    elseif (t == RACE_OBJECT_TYPE_CANNON_TOWER) then
        return true
    elseif (t == RACE_OBJECT_TYPE_ARCANE_TOWER) then
        return true
    elseif (t == RACE_OBJECT_TYPE_ARCANE_SANCTUM) then
        return true
    elseif (t == RACE_OBJECT_TYPE_WORKSHOP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_GRYPHON_AVIARY) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SACRIFICIAL_PIT) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_1) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_2) then
        return true
    elseif (t == RACE_OBJECT_TYPE_TIER_3) then
        return true
    elseif (t == RACE_OBJECT_TYPE_HOUSING) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIPYARD) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIPYARD_2) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SPECIAL_BUILDING) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SPECIAL_BUILDING_2) then
        return true
    endif
    return false
endfunction

function IsWaterRaceUnit takes integer t returns boolean
    if (t == RACE_OBJECT_TYPE_TRANSPORT_SHIP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_FRIGATE) then
        return true
    elseif (t == RACE_OBJECT_TYPE_BATTLESHIP) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIP_SPECIAL_1) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SHIP_SPECIAL_2) then
        return true
    endif
    return false
endfunction

function SetRaceObjectType takes integer whichRace, integer objectType, integer objectTypeId returns nothing
    call SaveInteger(objectTypeHashTable, objectTypeId, whichRace, objectType)
    set objectTypeIds[Index2D(whichRace, objectType, RACE_MAX_OBJECT_TYPES)] = objectTypeId
endfunction

function GetRaceObjectType takes integer whichRace, integer objectTypeId returns integer
    return LoadInteger(objectTypeHashTable, objectTypeId, whichRace)
endfunction

function GetRaceObjectTypeIncludingDependencyEquivalents takes integer whichRace, integer objectTypeId returns integer
    local integer result = GetRaceObjectType(whichRace, objectTypeId)
    if (result == RACE_OBJECT_TYPE_NONE) then
        set result = GetRaceObjectType(whichRace, GetPrimaryDependencyEquivalent(objectTypeId))
    endif
    return result
endfunction

function GetRaceObjectTypeId takes integer whichRace, integer objectType returns integer
    return objectTypeIds[Index2D(whichRace, objectType, RACE_MAX_OBJECT_TYPES)]
endfunction

function GetObjectRace takes integer objectTypeId returns integer
    local integer id = GetPrimaryDependencyEquivalent(objectTypeId)
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i == max)
        if (GetRaceObjectType(i, id) != RACE_OBJECT_TYPE_NONE) then
            return i
        endif
        set i = i + 1
    endloop

    return udg_RaceNone
endfunction

function IsWater takes integer unitTypeId returns boolean
    if (IsWaterRaceUnit(GetObjectRace(unitTypeId))) then
        return true
    endif
    
    if (unitTypeId == GNOMISH_SUBMARINE) then
        return true
    elseif (unitTypeId == ENGINEER_SHIP) then
        return true
    endif
    
    return false
endfunction

function IsWaterUnit takes unit whichUnit returns boolean
    return ConvertMoveType(BlzGetUnitIntegerField(whichUnit, UNIT_IF_MOVE_TYPE)) == MOVE_TYPE_FLOAT
endfunction

function GetObjectRaceType takes integer objectTypeId returns integer
    local integer i = 0
    local integer tmpType = 0
    local integer result = RACE_OBJECT_TYPE_NONE
    local integer max = GetRacesMax()
    loop
        exitwhen (i >= max or result != RACE_OBJECT_TYPE_NONE)
        set tmpType = GetRaceObjectTypeIncludingDependencyEquivalents(i, objectTypeId)
        if (tmpType != RACE_OBJECT_TYPE_NONE) then
            set result = tmpType
        endif
        set i = i + 1
    endloop

    return result
endfunction

function IsShip takes integer id returns boolean
    return IsWaterRaceUnit(GetObjectRaceType(id))
endfunction

function IsUnitShip takes unit whichUnit returns boolean
    return IsShip(GetUnitTypeId(whichUnit))
endfunction

function MapRaceObjectType takes integer objectTypeId, integer targetRace returns integer
    local integer i = 0
    local integer max = GetRacesMax()
    local integer tmpType = 0
    loop
        exitwhen (i == max)
        set tmpType = GetRaceObjectTypeIncludingDependencyEquivalents(i, objectTypeId)
        if (tmpType != RACE_OBJECT_TYPE_NONE) then
            return GetRaceObjectTypeId(targetRace, tmpType)
        endif
        set i = i + 1
    endloop

    return 0
endfunction

function GetBuildingRace takes integer buildingID returns integer
    return GetObjectRace(buildingID)
endfunction

function GetItemRace takes integer itemID returns integer
    return GetObjectRace(itemID)
endfunction

function GetUnitIDRace takes integer unitID returns integer
    return GetObjectRace(unitID)
endfunction

function MapBuildingID takes integer buildingID, integer targetRace returns integer
    return MapRaceObjectType(buildingID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapBuildingNumber takes integer buildingID, integer targetRace returns integer
    return 1
endfunction

function MapBuildingIDToItemID takes integer buildingID, integer targetRace returns integer
    local integer raceType = GetObjectRaceType(buildingID)

    if (raceType == RACE_OBJECT_TYPE_TIER_1) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_TIER_1_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_TIER_2) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_TIER_2_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_TIER_3) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_TIER_3_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_FARM) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_FARM_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_ALTAR) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_ALTAR_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_MILL) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_MILL_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_BLACK_SMITH) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_BLACK_SMITH_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_SHOP) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_SHOP_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_BARRACKS) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_BARRACKS_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_SCOUT_TOWER) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_GUARD_TOWER) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_GUARD_TOWER_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_CANNON_TOWER) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_CANNON_TOWER_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_ARCANE_TOWER) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_ARCANE_SANCTUM) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_WORKSHOP) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_WORKSHOP_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_GRYPHON_AVIARY) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_SACRIFICIAL_PIT) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_HOUSING) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_HOUSING_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_SHIPYARD) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_SHIPYARD_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_SPECIAL_BUILDING) then
        return GetRaceObjectTypeId(targetRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM)
    elseif (IsWall(buildingID)) then
        return ITEM_TINY_WALL
    endif

    return GetObjectMapping(buildingID)
endfunction

function MapUnitID takes integer unitID, integer targetRace, boolean includingWorkers returns integer
    local integer raceType = -1
    if (not includingWorkers) then
        set raceType = GetObjectRaceType(unitID)

        if (raceType == RACE_OBJECT_TYPE_WORKER or raceType == RACE_OBJECT_TYPE_MALE_CITIZEN) then
            return 0
        endif
    endif

    return MapRaceObjectType(unitID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapUnitNumber takes integer unitID, integer targetRace returns integer
    return 1
endfunction

function MapItemID takes integer unitID, integer targetRace returns integer
    return MapRaceObjectType(unitID, targetRace)
endfunction

function GetRaceName takes integer whichRace returns string
    return GetObjectName(udg_RaceTavernItemType[whichRace])
endfunction

function IsCitizen takes integer objectTypeId returns boolean
    local integer t = GetObjectRaceType(objectTypeId)
    return t == RACE_OBJECT_TYPE_MALE_CITIZEN or t == RACE_OBJECT_TYPE_FEMALE_CITIZEN or t == RACE_OBJECT_TYPE_CHILD
endfunction

function AddAbility takes integer objectTypeId, integer levels, integer whichRace returns integer
    local integer index = objectTypeAbilitiesCounter
    set objectTypeAbilities[index] = objectTypeId
    set objectTypeAbilitiesLevels[index] = levels
    set objectTypeAbilitiesRace[index] = whichRace
    set objectTypeAbilitiesCounter = objectTypeAbilitiesCounter + 1
    return index
endfunction

function GetAbilitiesMax takes nothing returns integer
    return objectTypeAbilitiesCounter
endfunction

function GetAbility takes integer index returns integer
    return objectTypeAbilities[index]
endfunction

function GetAbilityLevels takes integer index returns integer
    return objectTypeAbilitiesLevels[index]
endfunction

function GetAbilityRace takes integer index returns integer
    return objectTypeAbilitiesRace[index]
endfunction

function IsRaceBonus takes integer r returns boolean
    return udg_RaceIsBonus[r]
endfunction

function GetRaceHasFootmanWorker takes integer r returns boolean
    return udg_RaceHasFootmanWorker[r]
endfunction

function GetRaceHasBlight takes integer r returns boolean
    return udg_RaceHasBlight[r]
endfunction

function GetRaceAIScript takes integer r returns string
    return udg_RaceAIScript[r]
endfunction

function GetRaceItemTypeId takes integer r returns integer
    return udg_RaceItemType[r]
endfunction

private function AddRace takes nothing returns integer
    local integer index = racesCounter
    set racesCounter = racesCounter + 1
    return index
endfunction

function GetIconByRace takes integer whichRace returns string
    if (whichRace == udg_RaceNone or udg_RaceTavernItemType[whichRace] == 0) then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return BlzGetAbilityIcon(udg_RaceTavernItemType[whichRace])
endfunction

function GetRaceTeam takes integer r returns integer
    return udg_RaceTeam[r]
endfunction

private function SetRaceTeam takes integer whichRace, integer team returns nothing
    set udg_RaceTeam[whichRace] = team
endfunction

private function SetRaceTavernItemType takes integer whichRace, integer itemTypeId returns nothing
    set udg_RaceName[whichRace] = GetObjectName(itemTypeId)
    set udg_RaceTavernItemType[whichRace] = itemTypeId
endfunction

// scepter
private function SetRaceItemType takes integer whichRace, integer itemTypeId returns nothing
    set udg_RaceItemType[whichRace] = itemTypeId
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCEPTER_ITEM, itemTypeId)
endfunction

private function SetRaceAiScript takes integer whichRace, string aiScript returns nothing
    set udg_RaceAIScript[whichRace] = aiScript
endfunction

private function SetRaceHasFootmanWorker takes integer whichRace, boolean flag returns nothing
    set udg_RaceHasFootmanWorker[whichRace] = flag
endfunction

private function SetRaceHasBlight takes integer whichRace, boolean flag returns nothing
    set udg_RaceHasBlight[whichRace] = flag
endfunction

/*
function AddUnitTypeMadeItemType takes nothing returns nothing
     call AddObjectIdIntegerListFieldValue(udg_TmpUnitType, OBJECT_DATA_FIELD_UMKI, udg_TmpItemTypeId)
endfunction

function AddUnitTypeTrainedUnitType takes nothing returns nothing
     call AddObjectIdIntegerListFieldValue(udg_TmpUnitType, OBJECT_DATA_FIELD_UTRA, udg_TmpUnitType2)
endfunction

function AddUnitTypeUpgradeUnitType takes nothing returns nothing
     call AddObjectIdIntegerListFieldValue(udg_TmpUnitType, OBJECT_DATA_FIELD_UUPT, udg_TmpUnitType2)
endfunction

function AddUnitTypeResearchType takes nothing returns nothing
     call AddObjectIdIntegerListFieldValue(udg_TmpUnitType, OBJECT_DATA_FIELD_URES, udg_TmpTechType)
endfunction
*/

function GetRaceByTavernItemTypeId takes integer tavernItemTypeId returns integer
    local integer max = GetRacesMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (tavernItemTypeId == udg_RaceTavernItemType[i]) then
            return i
        endif
        set i = i + 1
    endloop
    return udg_RaceNone
endfunction

function PlayerCanPickRaceEx takes player whichPlayer, integer tavernItemTypeId returns boolean
    local integer index = GetRaceByTavernItemTypeId(tavernItemTypeId)
    if (index > 0) then
        return not IsRaceBonus(index) or udg_UnlockedAll or IsPlayerVIP(whichPlayer) or GetHeroLevel1(whichPlayer) >= 30
    endif
    return false
endfunction

function IsGoldmine takes integer unitTypeId returns boolean
    if (unitTypeId == GOLD_MINE) then
        return true
    endif
    return GetObjectRaceType(unitTypeId) == RACE_OBJECT_TYPE_MINE
endfunction

function IsUnitGoldmine takes unit whichUnit returns boolean
    return IsGoldmine(GetUnitTypeId(whichUnit))
endfunction

function IsHousing takes integer unitTypeId returns boolean
    return GetObjectRaceType(unitTypeId) == RACE_OBJECT_TYPE_HOUSING
endfunction

function IsUnitHousing takes unit whichUnit returns boolean
    return IsHousing(GetUnitTypeId(whichUnit))
endfunction

private function SetRaceTier1 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_1, id)
endfunction

private function SetRaceTier1Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_1_ITEM, id)
endfunction

private function SetRaceTier2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_2, id)
endfunction

private function SetRaceTier2Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_2_ITEM, id)
endfunction

private function SetRaceTier3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_3, id)
endfunction

private function SetRaceTier3Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_3_ITEM, id)
endfunction

private function SetRaceFarm takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FARM, id)
endfunction

private function SetRaceFarmItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FARM_ITEM, id)
endfunction

private function SetRaceBarracks takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS, id)
endfunction

private function SetRaceBarracksItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS_ITEM, id)
endfunction

private function SetRaceBlacksmith takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH, id)
endfunction

private function SetRaceBlacksmithItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH_ITEM, id)
endfunction

private function SetRaceMill takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MILL, id)
endfunction

private function SetRaceMillItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MILL_ITEM, id)
endfunction

private function SetRaceAltar takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ALTAR, id)
endfunction

private function SetRaceAltarItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ALTAR_ITEM, id)
endfunction

private function SetRaceArcaneSanctum takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM, id)
endfunction

private function SetRaceArcaneSanctumItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM, id)
endfunction

private function SetRaceShop takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHOP, id)
endfunction

private function SetRaceShopItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHOP_ITEM, id)
endfunction

private function SetRaceScoutTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCOUT_TOWER, id)
endfunction

private function SetRaceScoutTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM, id)
endfunction

private function SetRaceGuardTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GUARD_TOWER, id)
endfunction

private function SetRaceGuardTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GUARD_TOWER_ITEM, id)
endfunction

private function SetRaceCannonTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CANNON_TOWER, id)
endfunction

private function SetRaceCannonTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CANNON_TOWER_ITEM, id)
endfunction

private function SetRaceArcaneTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_TOWER, id)
endfunction

private function SetRaceArcaneTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM, id)
endfunction

private function SetRaceWorkshop takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP, id)
endfunction

private function SetRaceWorkshopItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP_ITEM, id)
endfunction

private function SetRaceAviary takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY, id)
endfunction

private function SetRaceAviaryItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM, id)
endfunction

private function SetRaceSacrificialPit takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT, id)
endfunction

private function SetRaceSacrificialPitItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM, id)
endfunction

function GetRaceHousing takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_HOUSING)
endfunction

private function SetRaceHousing takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_HOUSING, id)
endfunction

private function SetRaceHousingItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_HOUSING_ITEM, id)
endfunction

function GetRaceMine takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE)
endfunction

private function SetRaceMine takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MINE, id)
endfunction

function GetRaceShipyard takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIPYARD)
endfunction

function SetRaceShipyard takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIPYARD, id)
endfunction

function GetRaceShipyard2 takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIPYARD_2)
endfunction

private function SetRaceShipyard2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIPYARD_2, id)
endfunction

private function SetRaceShipyardItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIPYARD_ITEM, id)
endfunction

private function SetRaceSpecialBuilding takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING, id)
endfunction

private function SetRaceSpecialBuildingItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM, id)
endfunction

private function SetRaceSpecialBuilding2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2, id)
endfunction

private function SetRaceSpecialBuilding2Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2_ITEM, id)
endfunction

function GetRaceWorker takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_WORKER)
endfunction

private function SetRaceWorker takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKER, id)
endfunction

private function SetRaceTownHall3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TOWN_HALL_3, id)
endfunction

private function SetRaceTownHall4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TOWN_HALL_4, id)
endfunction

private function SetRaceFootman takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FOOTMAN, id)
endfunction

private function SetRaceRifleman takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_RIFLEMAN, id)
endfunction

private function SetRaceKnight takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_KNIGHT, id)
endfunction

private function SetRaceBarracks4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS_4, id)
endfunction

private function SetRacePriest takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_PRIEST, id)
endfunction

private function SetRaceSorceress takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SORCERESS, id)
endfunction

private function SetRaceSpellBreaker takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPELLBREAKER, id)
endfunction

private function SetRaceArcaneSanctum4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM_4, id)
endfunction

private function SetRaceFlyingMachine takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FLYING_MACHINE, id)
endfunction

private function SetRaceSiegeEngine takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SIEGE_ENGINE, id)
endfunction

private function SetRaceMortar takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MORTAR, id)
endfunction

private function SetRaceWorkshop4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP_4, id)
endfunction

private function SetRaceTauren takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TAUREN, id)
endfunction

private function SetRaceGryphon takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON, id)
endfunction

private function SetRaceDragonHawk takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_DRAGONHAWK, id)
endfunction

private function SetRaceAviary3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_AVIARY_3, id)
endfunction

private function SetRaceAviary4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_AVIARY_4, id)
endfunction

private function SetRaceShade takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHADE, id)
endfunction

private function SetRaceCitizenMale takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MALE_CITIZEN, id)
endfunction

private function SetRaceCitizenFemale takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FEMALE_CITIZEN, id)
endfunction

private function SetRaceChild takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CHILD, id)
endfunction

private function SetRacePet takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_PET, id)
endfunction

private function SetRaceTransportShip takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TRANSPORT_SHIP, id)
endfunction

function GetRaceTransportShip takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_TRANSPORT_SHIP)
endfunction

private function SetRaceFrigate takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FRIGATE, id)
endfunction

function GetRaceFrigate takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_FRIGATE)
endfunction

private function SetRaceBattleship takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BATTLESHIP, id)
endfunction

function GetRaceBattleship takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_BATTLESHIP)
endfunction

private function SetRaceShipSpecial1 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIP_SPECIAL_1, id)
endfunction

function GetRaceShipSpecial1 takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIP_SPECIAL_1)
endfunction

private function SetRaceShipSpecial2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIP_SPECIAL_2, id)
endfunction

function GetRaceShipSpecial2 takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIP_SPECIAL_2)
endfunction

private function AddNone takes nothing returns nothing
    local integer r = udg_RaceNone
    
    call AddResearch(r, UPG_EVOLUTION)
    call AddResearch(r, UPG_TEMPLE_OF_DEMIGODS_BLUEPRINTS)
    call AddResearch(r, UPG_STORM_PROTECTION)
    call AddResearch(r, UPG_IMPROVED_AIR_TRANSPORT)
    call AddResearch(r, UPG_REINFORCED_WALLS)
    call AddResearch(r, UPG_MASONRY_ENGINEER)
endfunction

private function AddFreelancer takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceFreelancer = r
    call SetRaceTavernItemType(r, ITEM_FREELANCER)
    call SetRaceAiScript(r, "wowr\\Freelancer.ai")
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, FREELANCER_TIER_1)
    call SetRaceTier1Item(r, ITEM_FREELANCER_TIER_1)
    call SetRaceTier2(r, FREELANCER_TIER_2)
    call SetRaceTier2Item(r, ITEM_FREELANCER_TIER_2)
    call SetRaceTier3(r, FREELANCER_TIER_3)
    call SetRaceTier3Item(r, ITEM_FREELANCER_TIER_3)
    call SetRaceFarm(r, FREELANCER_LABORATORY)
    call SetRaceFarmItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceBarracks(r, FREELANCER_MERCENARY_CAMP)
    call SetRaceBarracksItem(r, ITEM_FREELANCER_MERCENARY_CAMP)
    call SetRaceBlacksmith(r, FREELANCER_LABORATORY)
    call SetRaceBlacksmithItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceMill(r, FREELANCER_LABORATORY)
    call SetRaceMillItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceAltar(r, FREELANCER_LABORATORY)
    call SetRaceAltarItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceArcaneSanctum(r, FREELANCER_LABORATORY)
    call SetRaceArcaneSanctumItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceShop(r, FREELANCER_SHOP)
    call SetRaceShopItem(r, ITEM_FREELANCER_SHOP)
    call SetRaceScoutTower(r, FREELANCER_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_FREELANCER_TOWER)
    call SetRaceGuardTower(r, FREELANCER_ADVANCED_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_FREELANCER_ADVANCED_TOWER)
    call SetRaceCannonTower(r, FREELANCER_ADVANCED_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_FREELANCER_ADVANCED_TOWER)
    call SetRaceArcaneTower(r, FREELANCER_ADVANCED_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_FREELANCER_ADVANCED_TOWER)
    call SetRaceWorkshop(r, FREELANCER_LABORATORY)
    call SetRaceWorkshopItem(r, ITEM_FREELANCER_LABORATORY)
    call SetRaceAviary(r, FREELANCER_MERCENARY_CAMP)
    call SetRaceAviaryItem(r, ITEM_FREELANCER_MERCENARY_CAMP)
    call SetRaceHousing(r, FREELANCER_HOUSING)
    call SetRaceHousingItem(r, ITEM_FREELANCER_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceSpecialBuilding(r, HUMAN_ARCANE_OBSERVATORY)
    //call SetRaceSpecialBuildingItem(r, ITEM_HUMAN_SPECIAL_BUILDING)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, FREELANCER_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_FREELANCER_SHIPYARD)

    // researches
    call AddResearch(r, UPG_FREELANCER_MAGIC_SENTRY)
    call AddResearch(r, UPG_FREELANCER_CHEAP_EVOLUTION)

    // units
    call SetRaceWorker(r, FREELANCER_CITIZEN_MALE)
    call SetRaceFootman(r, CREEP_UNBROKEN_DARK_WEAVER)
    call SetRaceRifleman(r, CREEP_EREDAR_WARLOCK)
    call SetRaceKnight(r, CREEP_BANDIT_LORD)
    call SetRacePriest(r, CREEP_DARK_TROLL_PRIEST)
    call SetRaceSorceress(r, CREEP_WRAITH)
    call SetRaceSpellBreaker(r, CREEP_DARK_WIZARD)
    call SetRaceSiegeEngine(r, CREEP_SEA_GIANT_BEHEMOTH)
    call SetRaceMortar(r, CREEP_SEA_GIANT_BEHEMOTH)
    call SetRaceFlyingMachine(r, CREEP_HARPY)
    call SetRaceTauren(r, CREEP_DOOM_GUARD)
    call SetRaceGryphon(r, CREEP_GREEN_DRAKE)
    call SetRaceDragonHawk(r, CREEP_HARPY)
    call SetRaceCitizenMale(r, FREELANCER_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, FREELANCER_CITIZEN_FEMALE)
    call SetRaceChild(r, FREELANCER_CHILD)
    call SetRacePet(r, FREELANCER_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddHuman takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceHuman = r
    call SetRaceTavernItemType(r, ITEM_HUMAN)
    call SetRaceAiScript(r, "wowr\\Human.ai")
    call SetRaceItemType(r, ITEM_HUMAN_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, TOWN_HALL)
    call SetRaceTier1Item(r, ITEM_HUMAN_TIER_1)
    call SetRaceTier2(r, KEEP)
    call SetRaceTier2Item(r, ITEM_HUMAN_TIER_2)
    call SetRaceTier3(r, CASTLE)
    call SetRaceTier3Item(r, ITEM_HUMAN_TIER_3)
    call SetRaceFarm(r, HOUSE)
    call SetRaceFarmItem(r, ITEM_HUMAN_FARM)
    call SetRaceBarracks(r, BARRACKS)
    call SetRaceBarracksItem(r, ITEM_HUMAN_BARRACKS)
    call SetRaceBlacksmith(r, BLACKSMITH)
    call SetRaceBlacksmithItem(r, ITEM_HUMAN_BLACK_SMITH)
    call SetRaceMill(r, LUMBER_MILL)
    call SetRaceMillItem(r, ITEM_HUMAN_MILL)
    call SetRaceAltar(r, HUMAN_ALTAR)
    call SetRaceAltarItem(r, ITEM_HUMAN_ALTAR)
    call SetRaceArcaneSanctum(r, ARCANE_SANCTUM)
    call SetRaceArcaneSanctumItem(r, ITEM_HUMAN_ARCANE_SANCTUM)
    call SetRaceShop(r, ARCANE_VAULT)
    call SetRaceShopItem(r, ITEM_HUMAN_SHOP)
    call SetRaceScoutTower(r, WATCH_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_HUMAN_SCOUT_TOWER)
    call SetRaceGuardTower(r, GUARD_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_HUMAN_GUARD_TOWER)
    call SetRaceCannonTower(r, CANNON_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_HUMAN_CANNON_TOWER)
    call SetRaceArcaneTower(r, ARCANE_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_HUMAN_ARCANE_TOWER)
    call SetRaceWorkshop(r, WORKSHOP)
    call SetRaceWorkshopItem(r, ITEM_HUMAN_WORKSHOP)
    call SetRaceAviary(r, AVIARY)
    call SetRaceAviaryItem(r, ITEM_HUMAN_GRYPHON_AVIARY)
    call SetRaceHousing(r, HUMAN_HOUSING)
    call SetRaceHousingItem(r, ITEM_HUMAN_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, HUMAN_ARCANE_OBSERVATORY)
    call SetRaceSpecialBuildingItem(r, ITEM_HUMAN_SPECIAL_BUILDING)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, HUMAN_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_HUMAN_SHIPYARD)

    // researches
    call AddResearch(r, UPG_HUMAN_BACKPACK)
    call AddResearch(r, UPG_MASONRY)
    call AddResearch(r, UPG_SIGHT)
    call AddResearch(r, UPG_DEFEND)
    call AddResearch(r, UPG_BREEDING)
    call AddResearch(r, UPG_PRAYING)
    call AddResearch(r, UPG_SORCERY)
    call AddResearch(r, UPG_LEATHER)
    call AddResearch(r, UPG_ARMOR)
    call AddResearch(r, UPG_MELEE)
    call AddResearch(r, UPG_RANGED)
    call AddResearch(r, UPG_BANDIT_WOOD)
    call AddResearch(r, UPG_GUN_RANGE)
    call AddResearch(r, UPG_WOOD)
    call AddResearch(r, UPG_SENTINEL)
    call AddResearch(r, UPG_BOMBS)
    call AddResearch(r, UPG_HAMMERS)
    call AddResearch(r, UPG_CONT_MAGIC)
    call AddResearch(r, UPG_FRAGS)
    call AddResearch(r, UPG_TANK)
    call AddResearch(r, UPG_FLAK)
    call AddResearch(r, UPG_CLOUD)
    call AddResearch(r, UPG_HUMAN_SUNDERING_BLADES)
    call AddResearch(r, UPG_HUMAN_FLARE)
    call AddResearch(r, UPG_HUMAN_ARCANE_OBSERVATORY)

    // units
    call SetRaceWorker(r, PEASANT)
    call SetRaceFootman(r, FOOTMAN)
    call SetRaceRifleman(r, RIFLEMAN)
    call SetRaceKnight(r, KNIGHT)
    call SetRacePriest(r, PRIEST)
    call SetRaceSorceress(r, SORCERESS)
    call SetRaceSpellBreaker(r, SPELL_BREAKER)
    call SetRaceSiegeEngine(r, TANK)
    call SetRaceMortar(r, MORTAR)
    call SetRaceFlyingMachine(r, GYRO)
    //call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    call SetRaceGryphon(r, GRYPHON)
    call SetRaceDragonHawk(r, HUMAN_DRAGON_HAWK)
    call SetRaceCitizenMale(r, HUMAN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, HUMAN_CITIZEN_FEMALE)
    call SetRaceChild(r, HUMAN_CHILD)
    call SetRacePet(r, HUMAN_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
endfunction

private function AddOrc takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceOrc = r
    call SetRaceTavernItemType(r, ITEM_ORC)
    call SetRaceAiScript(r, "wowr\\Orc.ai")
    call SetRaceItemType(r, ITEM_ORC_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, GREAT_HALL)
    call SetRaceTier1Item(r, ITEM_ORC_TIER_1)
    call SetRaceTier2(r, STRONGHOLD)
    call SetRaceTier2Item(r, ITEM_ORC_TIER_2)
    call SetRaceTier3(r, FORTRESS)
    call SetRaceTier3Item(r, ITEM_ORC_TIER_3)
    call SetRaceFarm(r, BURROW)
    call SetRaceFarmItem(r, ITEM_ORC_BURROW)
    call SetRaceBarracks(r, ORC_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_ORC_BARRACKS)
    call SetRaceBlacksmith(r, FORGE)
    call SetRaceBlacksmithItem(r, ITEM_ORC_MILL)
    call SetRaceMill(r, FORGE)
    call SetRaceMillItem(r, ITEM_ORC_MILL)
    call SetRaceAltar(r, ORC_ALTAR)
    call SetRaceAltarItem(r, ITEM_ORC_ALTAR)
    call SetRaceArcaneSanctum(r, LODGE)
    call SetRaceArcaneSanctumItem(r, ITEM_ORC_LODGE)
    call SetRaceShop(r, VOODOO_LOUNGE)
    call SetRaceShopItem(r, ITEM_ORC_VOODOO_LOUNGE)
    call SetRaceScoutTower(r, ORC_WATCH_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_ORC_WATCH_TOWER)
    call SetRaceGuardTower(r, ORC_WATCH_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_ORC_WATCH_TOWER)
    call SetRaceCannonTower(r, ORC_WATCH_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_ORC_WATCH_TOWER)
    call SetRaceArcaneTower(r, ORC_WATCH_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_ORC_WATCH_TOWER)
    call SetRaceWorkshop(r, BESTIARY)
    call SetRaceWorkshopItem(r, ITEM_ORC_BEASTIARY )
    call SetRaceAviary(r, TOTEM)
    call SetRaceAviaryItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, ORC_HOUSING)
    call SetRaceHousingItem(r, ITEM_ORC_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, FOUNTAIN_OF_BLOOD)
    call SetRaceSpecialBuildingItem(r, ITEM_ORC_SPECIAL_BUILDING)
    call SetRaceSpecialBuilding2(r, FEL_DRAGON_ROOST)
    call SetRaceShipyard(r, ORC_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_ORC_SHIPYARD)

    // researches
    call AddResearch(r, UPG_ORC_BACKPACK)
    call AddResearch(r, UPG_ORC_MELEE)
    call AddResearch(r, UPG_ORC_RANGED)
    call AddResearch(r, UPG_ORC_ARMOR)
    call AddResearch(r, UPG_ORC_WAR_DRUMS)
    call AddResearch(r, UPG_ORC_PILLAGE)
    call AddResearch(r, UPG_ORC_BERSERK)
    call AddResearch(r, UPG_ORC_PULVERIZE)
    call AddResearch(r, UPG_ORC_ENSNARE)
    call AddResearch(r, UPG_ORC_VENOM)
    call AddResearch(r, UPG_ORC_DOCS)
    call AddResearch(r, UPG_ORC_SHAMAN)
    call AddResearch(r, UPG_ORC_SPIKES)
    call AddResearch(r, UPG_ORC_BURROWS)
    call AddResearch(r, UPG_ORC_REGEN)
    call AddResearch(r, UPG_ORC_FIRE)
    call AddResearch(r, UPG_ORC_SWALKER)
    call AddResearch(r, UPG_ORC_BERSERKER)
    call AddResearch(r, UPG_ORC_NAPTHA)
    call AddResearch(r, UPG_FEL)

    // units
    call SetRaceWorker(r, PEON)
    call SetRaceFootman(r, GRUNT)
    call SetRaceRifleman(r, HEAD_HUNTER)
    call SetRaceKnight(r, RAIDER)
    call SetRacePriest(r, WITCH_DOCTOR)
    call SetRaceSorceress(r, SHAMAN)
    call SetRaceSpellBreaker(r, SPIRIT_WALKER)
    call SetRaceSiegeEngine(r, KODO_BEAST)
    call SetRaceMortar(r, CATAPULT)
    call SetRaceFlyingMachine(r, BATRIDER)
    call SetRaceTauren(r, TAUREN)
    call SetRaceGryphon(r, WYVERN)
    call SetRaceDragonHawk(r, BATRIDER)
    call SetRaceCitizenMale(r, ORC_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, ORC_CITIZEN_FEMALE)
    call SetRaceChild(r, ORC_CHILD)
    call SetRacePet(r, ORC_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddUndead takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceUndead = r
    call SetRaceTavernItemType(r, ITEM_UNDEAD)
    call SetRaceAiScript(r, "wowr\\Undead.ai")
    call SetRaceItemType(r, ITEM_UNDEAD_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)
    call SetRaceHasFootmanWorker(r, true)
    call SetRaceHasBlight(r, true)

    // buildings
    call SetRaceTier1(r, NECROPOLIS_1)
    call SetRaceTier1Item(r, ITEM_UNDEAD_TIER_1)
    call SetRaceTier2(r, NECROPOLIS_2)
    call SetRaceTier2Item(r, ITEM_UNDEAD_TIER_2)
    call SetRaceTier3(r, NECROPOLIS_3)
    call SetRaceTier3Item(r, ITEM_UNDEAD_TIER_3)
    call SetRaceFarm(r, ZIGGURAT_1)
    call SetRaceFarmItem(r, ITEM_UNDEAD_ZIGURRAT)
    call SetRaceBarracks(r, CRYPT)
    call SetRaceBarracksItem(r, ITEM_UNDEAD_CRYPT)
    call SetRaceBlacksmith(r, GRAVEYARD)
    call SetRaceBlacksmithItem(r, ITEM_UNDEAD_GRAVEYARD)
    call SetRaceMill(r, GRAVEYARD)
    call SetRaceMillItem(r, ITEM_UNDEAD_GRAVEYARD)
    call SetRaceAltar(r, UNDEAD_ALTAR)
    call SetRaceAltarItem(r, ITEM_UNDEAD_ALTAR)
    call SetRaceArcaneSanctum(r, DAMNED_TEMPLE)
    call SetRaceArcaneSanctumItem(r, ITEM_UNDEAD_TEMPLE_OF_THE_DAMNED)
    call SetRaceShop(r, TOMB_OF_RELICS)
    call SetRaceShopItem(r, ITEM_UNDEAD_TOMB_OF_RELICS)
    call SetRaceScoutTower(r, ZIGGURAT_1)
    call SetRaceScoutTowerItem(r, ITEM_UNDEAD_ZIGURRAT)
    call SetRaceGuardTower(r, ZIGGURAT_2)
    call SetRaceGuardTowerItem(r, ITEM_UNDEAD_SPIRIT_TOWER)
    call SetRaceCannonTower(r, ZIGGURAT_FROST)
    call SetRaceCannonTowerItem(r, ITEM_UNDEAD_NERUBIAN_TOWER)
    call SetRaceArcaneTower(r, ZIGGURAT_FROST)
    call SetRaceArcaneTowerItem(r, ITEM_UNDEAD_NERUBIAN_TOWER)
    call SetRaceWorkshop(r, SLAUGHTERHOUSE)
    call SetRaceWorkshopItem(r, ITEM_UNDEAD_SLAUGHTERHOUSE)
    call SetRaceAviary(r, BONEYARD)
    call SetRaceAviaryItem(r, ITEM_UNDEAD_BONEYARD)
    call SetRaceSacrificialPit(r, SAC_PIT)
    call SetRaceSacrificialPitItem(r, ITEM_UNDEAD_SACRIFICIAL_PIT)
    call SetRaceMine(r, UNDEAD_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, UNDEAD_HOUSING)
    call SetRaceHousingItem(r, ITEM_UNDEAD_HOUSING)
    call SetRaceSpecialBuilding(r, UNDEAD_LICH_KING)
    call SetRaceSpecialBuildingItem(r, ITEM_UNDEAD_SPECIAL_BUILDING)
    call SetRaceShipyard(r, UNDEAD_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_UNDEAD_SHIPYARD)

    // researches
    call AddResearch(r, UPG_UNDEAD_BACKPACK)
    call AddResearch(r, UPG_UNHOLY_STR)
    call AddResearch(r, UPG_CR_ATTACK)
    call AddResearch(r, UPG_UNHOLY_ARMOR)
    call AddResearch(r, UPG_CANNIBALIZE)
    call AddResearch(r, UPG_GHOUL_FRENZY)
    call AddResearch(r, UPG_FIEND_WEB)
    //call AddResearch(r, UPG_ABOM)
    call AddResearch(r, UPG_STONE_FORM)
    call AddResearch(r, UPG_NECROS)
    call AddResearch(r, UPG_BANSHEE)
    //call AddResearch(r, UPG_MEAT_WAGON)
    call AddResearch(r, UPG_WYRM_BREATH)
    call AddResearch(r, UPG_SKEL_LIFE)
    call AddResearch(r, UPG_SKEL_MASTERY)
    call AddResearch(r, UPG_EXHUME)
    //call AddResearch(r, UPG_SACRIFICE)
    //call AddResearch(r, UPG_ABOM_EXPL)
    call AddResearch(r, UPG_CR_ARMOR)
    call AddResearch(r, UPG_PLAGUE)
    call AddResearch(r, UPG_BLK_SPHINX)
    call AddResearch(r, UPG_BURROWING)
    call AddResearch(r, UPG_UNDEAD_LICH_KING)

    // units
    call SetRaceWorker(r, ACOLYTE)
    call SetRaceFootman(r, GHOUL)
    call SetRaceRifleman(r, CRYPT_FIEND)
    call SetRaceKnight(r, ABOMINATION)
    call SetRacePriest(r, NECRO)
    call SetRaceSorceress(r, BANSHEE)
    call SetRaceSpellBreaker(r, OBSIDIAN_STATUE)
    call SetRaceSiegeEngine(r, MEAT_WAGON)
    call SetRaceMortar(r, MEAT_WAGON)
    call SetRaceFlyingMachine(r, UNDEAD_BARGE)
    call SetRaceTauren(r, ABOMINATION)
    call SetRaceGryphon(r, FROST_WYRM)
    call SetRaceDragonHawk(r, GARGOYLE)
    call SetRaceShade(r, SHADE)
    call SetRaceCitizenMale(r, UNDEAD_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, UNDEAD_CITIZEN_FEMALE)
    call SetRaceChild(r, UNDEAD_CHILD)
    call SetRacePet(r, UNDEAD_PET)
    call SetRaceTransportShip(r, UNDEAD_TRANSPORT_SHIP)
    call SetRaceFrigate(r, UNDEAD_FRIGATE)
    call SetRaceBattleship(r, UNDEAD_BATTLESHIP)
endfunction

private function AddNightElf takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceNightElf = r
    call SetRaceTavernItemType(r, ITEM_ELF)
    call SetRaceAiScript(r, "wowr\\NightElf.ai")
    call SetRaceItemType(r, ITEM_ELF_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, TREE_LIFE)
    call SetRaceTier1Item(r, ITEM_ELF_TIER_1)
    call SetRaceTier2(r, TREE_AGES)
    call SetRaceTier2Item(r, ITEM_ELF_TIER_2)
    call SetRaceTier3(r, TREE_ETERNITY)
    call SetRaceTier3Item(r, ITEM_ELF_TIER_3)
    call SetRaceFarm(r, MOON_WELL)
    call SetRaceFarmItem(r, ITEM_ELF_MOON_WELL)
    call SetRaceBarracks(r, ANCIENT_WAR)
    call SetRaceBarracksItem(r, ITEM_ELF_ANCIENT_OF_WAR)
    call SetRaceBlacksmith(r, HUNTERS_HALL)
    call SetRaceBlacksmithItem(r, ITEM_ELF_HUNTERS_HALL)
    call SetRaceMill(r, HUNTERS_HALL)
    call SetRaceMillItem(r, ITEM_ELF_HUNTERS_HALL)
    call SetRaceAltar(r, ELF_ALTAR)
    call SetRaceAltarItem(r, ITEM_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, ANCIENT_WIND)
    call SetRaceArcaneSanctumItem(r, ITEM_ELF_ANCIENT_OF_WIND)
    call SetRaceShop(r, DEN_OF_WONDERS)
    call SetRaceShopItem(r, ITEM_ELF_ANCIENT_OF_WONDERS)
    call SetRaceScoutTower(r, ANCIENT_PROTECT)
    call SetRaceScoutTowerItem(r, ITEM_ELF_ANCIENT_PROTECTOR)
    call SetRaceGuardTower(r, ANCIENT_PROTECT)
    call SetRaceGuardTowerItem(r, ITEM_ELF_ANCIENT_PROTECTOR)
    call SetRaceCannonTower(r, ANCIENT_PROTECT)
    call SetRaceCannonTowerItem(r, ITEM_ELF_ANCIENT_PROTECTOR)
    call SetRaceArcaneTower(r, ANCIENT_PROTECT)
    call SetRaceArcaneTowerItem(r, ITEM_ELF_ANCIENT_PROTECTOR)
    call SetRaceWorkshop(r, ANCIENT_LORE)
    call SetRaceWorkshopItem(r, ITEM_ELF_ANCIENT_OF_LORE)
    call SetRaceAviary(r, CHIMAERA_ROOST)
    call SetRaceAviaryItem(r, ITEM_ELF_CHIMAERA_ROOST)
    call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, ELF_HOUSING)
    call SetRaceHousingItem(r, ITEM_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, ELF_WORLD_TREE)
    call SetRaceSpecialBuildingItem(r, ITEM_ELF_SPECIAL_BUILDING)
    call SetRaceShipyard(r, ELF_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_ELF_BACKPACK)
    call AddResearch(r, UPG_STR_MOON)
    call AddResearch(r, UPG_STR_WILD)
    call AddResearch(r, UPG_MOON_ARMOR)
    call AddResearch(r, UPG_HIDES)
    call AddResearch(r, UPG_ULTRAVISION)
    call AddResearch(r, UPG_BLESSING)
    call AddResearch(r, UPG_SCOUT)
    call AddResearch(r, UPG_GLAIVE)
    call AddResearch(r, UPG_BOWS)
    call AddResearch(r, UPG_MARKSMAN)
    call AddResearch(r, UPG_DRUID_TALON)
    call AddResearch(r, UPG_DRUID_CLAW)
    call AddResearch(r, UPG_ABOLISH)
    call AddResearch(r, UPG_CHIM_ACID)
    call AddResearch(r, UPG_HIPPO_TAME)
    //call AddResearch(r, UPG_BOLT)
    call AddResearch(r, UPG_MARK_CLAW)
    call AddResearch(r, UPG_MARK_TALON)
    call AddResearch(r, UPG_HARD_SKIN)
    call AddResearch(r, UPG_RESIST_SKIN)
    call AddResearch(r, UPG_WELL_SPRING)
    call AddResearch(r, UPG_ELF_VORPAL_BLADES)
    call AddResearch(r, UPG_ELF_WORLD_TREE)

    // units
    call SetRaceWorker(r, WISP)
    call SetRaceFootman(r, ARCHER)
    call SetRaceRifleman(r, ARCHER)
    call SetRaceKnight(r, HUNTRESS)
    call SetRacePriest(r, DRUID_TALON)
    call SetRaceSorceress(r, DRUID_CLAW)
    call SetRaceSpellBreaker(r, DRYAD)
    call SetRaceSiegeEngine(r, BALLISTA)
    call SetRaceMortar(r, BALLISTA)
    call SetRaceFlyingMachine(r, HIPPO)
    call SetRaceTauren(r, MOUNTAIN_GIANT)
    call SetRaceGryphon(r, CHIMAERA)
    call SetRaceDragonHawk(r, HIPPO)
    call SetRaceCitizenMale(r, ELF_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, ELF_CITIZEN_FEMALE)
    call SetRaceChild(r, ELF_CHILD)
    call SetRacePet(r, ELF_PET)
    call SetRaceTransportShip(r, ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ELF_FRIGATE)
    call SetRaceBattleship(r, ELF_BATTLESHIP)
endfunction

private function AddBloodElf takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceBloodElf = r
    call SetRaceTavernItemType(r, ITEM_BLOOD_ELF)
    call SetRaceAiScript(r, "wowr\\BloodElf.ai")
    call SetRaceItemType(r, ITEM_BLOOD_ELF_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, BLOOD_ELF_TOWN_HALL)
    call SetRaceTier1Item(r, ITEM_BLOOD_ELF_TIER_1)
    call SetRaceTier2(r, BLOOD_ELF_KEEP)
    call SetRaceTier2Item(r, ITEM_BLOOD_ELF_TIER_2)
    call SetRaceTier3(r, BLOOD_ELF_CASTLE)
    call SetRaceTier3Item(r, ITEM_BLOOD_ELF_TIER_3)
    call SetRaceFarm(r, BLOOD_ELF_FARM)
    call SetRaceFarmItem(r, ITEM_BLOOD_ELF_FARM)
    call SetRaceBarracks(r, BLOOD_ELF_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_BLOOD_ELF_BARRACKS)
    call SetRaceBlacksmith(r, BLOOD_ELF_BLACK_SMITH)
    call SetRaceBlacksmithItem(r, ITEM_BLOOD_ELF_BLACK_SMITH)
    call SetRaceMill(r, BLOOD_ELF_LUMBER_MILL)
    call SetRaceMillItem(r, ITEM_BLOOD_ELF_LUMBER_MILL)
    call SetRaceAltar(r, BLOOD_ELF_ALTAR)
    call SetRaceAltarItem(r, ITEM_BLOOD_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, BLOOD_ELF_ARCANE_SACNTUM)
    call SetRaceArcaneSanctumItem(r, ITEM_BLOOD_ELF_ARCANE_SANCTUM)
    call SetRaceShop(r, BLOOD_ELF_ARCANE_VAULT)
    call SetRaceShopItem(r, ITEM_BLOOD_ELF_ARCANE_VAULT)
    call SetRaceScoutTower(r, BLOOD_ELF_SCOUT_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_BLOOD_ELF_SCOUT_TOWER)
    call SetRaceGuardTower(r, BLOOD_ELF_GUARD_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_BLOOD_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, BLOOD_ELF_ARCANE_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_BLOOD_ELF_ARCANE_TOWER)
    call SetRaceArcaneTower(r, BLOOD_ELF_ARCANE_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_BLOOD_ELF_ARCANE_TOWER)
    call SetRaceWorkshop(r, BLOOD_ELF_WORKSHOP)
    call SetRaceWorkshopItem(r, ITEM_BLOOD_ELF_WORKSHOP)
    call SetRaceAviary(r, BLOOD_ELF_AVIARY)
    call SetRaceAviaryItem(r, ITEM_BLOOD_ELF_AVIARY)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, BLOOD_ELF_HOUSING)
    call SetRaceHousingItem(r, ITEM_BLOOD_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, BLOOD_ELF_MAGIC_VAULT)
    call SetRaceSpecialBuildingItem(r, ITEM_BLOOD_ELF_MAGIC_VAULT)
    call SetRaceShipyard(r, BLOOD_ELF_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_BLOOD_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_BLOOD_ELF_BACKPACK)
    call AddResearch(r, UPG_BLOOD_ELF_DEFEND)
    call AddResearch(r, UPG_BLOOD_ELF_SORCERY)
    call AddResearch(r, UPG_BLOOD_ELF_SENTINEL)
    call AddResearch(r, UPG_BLOOD_ELF_BREEDING)
    call AddResearch(r, UPG_BLOOD_ELF_BOWS)
    call AddResearch(r, UPG_BLOOD_ELF_WOOD)
    call AddResearch(r, UPG_BLOOD_ELF_MASONRY)
    call AddResearch(r, UPG_BLOOD_ELF_MELEE)
    call AddResearch(r, UPG_BLOOD_ELF_ARMOR)
    call AddResearch(r, UPG_BLOOD_ELF_MARKSMAN)
    call AddResearch(r, UPG_BLOOD_ELF_MOON_ARMOR)
    call AddResearch(r, UPG_BLOOD_ELF_PRAYING)
    call AddResearch(r, UPG_BLOOD_ELF_STR_MOON)
    call AddResearch(r, UPG_BLOOD_ELF_LEATHER)
    call AddResearch(r, UPG_BLOOD_ELF_BURNING_OIL)
    call AddResearch(r, UPG_BLOOD_ELF_IMPROVED_SIEGE)
    call AddResearch(r, UPG_BLOOD_ELF_CONT_MAGIC)
    call AddResearch(r, UPG_BLOOD_ELF_CLOUD)
    call AddResearch(r, UPG_BLOOD_ELF_SIPHON_MANA)
    call AddResearch(r, UPG_BLOOD_ELF_PHOENIX_EGGS)
    call AddResearch(r, UPG_BLOOD_ELF_PHOENIX_FIRE)
    call AddResearch(r, UPG_BLOOD_ELF_MAGIC_VAULT)

    // units
    call SetRaceWorker(r, BLOOD_ELF_WORKER)
    call SetRaceFootman(r, BLOOD_ELF_SWORDMAN)
    call SetRaceRifleman(r, BLOOD_ELF_ARCHER)
    call SetRaceKnight(r, BLOOD_ELF_LIEUTENANT)
    call SetRacePriest(r, BLOOD_ELF_PRIEST)
    call SetRaceSorceress(r, BLOOD_ELF_SORCERESS)
    call SetRaceSpellBreaker(r, BLOOD_ELF_SPELL_BREAKER)
    call SetRaceSiegeEngine(r, BLOOD_ELF_DECIMATOR)
    call SetRaceMortar(r, BLOOD_ELF_BALLISTA)
    call SetRaceWorkshop4(r, BLOOD_ELF_CAGE)
    call SetRaceTauren(r, BLOOD_ELF_WAGON)
    call SetRaceGryphon(r, BLOOD_ELF_PHOENIX)
    call SetRaceDragonHawk(r, BLOOD_ELF_DRAGON_HAWK)
    call SetRaceFlyingMachine(r, BLOOD_ELF_SKYSHIP)
    call SetRaceCitizenMale(r, BLOOD_ELF_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, BLOOD_ELF_CITIZEN_FEMALE)
    call SetRaceChild(r, BLOOD_ELF_CHILD)
    call SetRacePet(r, BLOOD_ELF_PET)
    call SetRaceTransportShip(r, BLOOD_ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, BLOOD_ELF_FRIGATE)
    call SetRaceBattleship(r, BLOOD_ELF_BATTLESHIP)
endfunction

private function AddNaga takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceNaga = r
    call SetRaceTavernItemType(r, ITEM_NAGA)
    call SetRaceAiScript(r, "wowr\\Naga.ai")
    call SetRaceItemType(r, ITEM_NAGA_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)
    
    // buildings
    call SetRaceTier1(r, NAGA_TEMPLE_1)
    call SetRaceTier1Item(r, ITEM_NAGA_TIER_1)
    call SetRaceTier2(r, NAGA_TEMPLE)
    call SetRaceTier2Item(r, ITEM_NAGA_TIER_2)
    call SetRaceTier3(r, NAGA_TEMPLE_3)
    call SetRaceTier3Item(r, ITEM_NAGA_TIER_3)
    call SetRaceFarm(r, NAGA_CORAL)
    call SetRaceFarmItem(r, ITEM_NAGA_CORAL_BED)
    call SetRaceBarracks(r, NAGA_SPAWNING)
    call SetRaceBarracksItem(r, ITEM_NAGA_SPAWNING_GROUNDS)
    call SetRaceBlacksmith(r, NAGA_ROYAL_VAULT)
    call SetRaceBlacksmithItem(r, ITEM_NAGA_ROYAL_VAULT)
    call SetRaceMill(r, NAGA_ROYAL_VAULT)
    call SetRaceMillItem(r, ITEM_NAGA_ROYAL_VAULT)
    call SetRaceAltar(r, NAGA_ALTAR)
    call SetRaceAltarItem(r, ITEM_NAGA_ALTAR)
    call SetRaceArcaneSanctum(r, NAGA_SHRINE)
    call SetRaceArcaneSanctumItem(r, ITEM_NAGA_SHRINE)
    call SetRaceShop(r, NAGA_TREASURY_OF_THE_TIDES)
    call SetRaceShopItem(r, ITEM_NAGA_TREASURY_OF_THE_TIDES)
    call SetRaceScoutTower(r, NAGA_GUARDIAN)
    call SetRaceScoutTowerItem(r, ITEM_NAGA_GUARDIAN)
    call SetRaceGuardTower(r, NAGA_GUARDIAN)
    call SetRaceGuardTowerItem(r, ITEM_NAGA_GUARDIAN)
    call SetRaceCannonTower(r, NAGA_GUARDIAN)
    call SetRaceCannonTowerItem(r, ITEM_NAGA_GUARDIAN)
    call SetRaceArcaneTower(r, NAGA_GUARDIAN)
    call SetRaceArcaneTowerItem(r, ITEM_NAGA_GUARDIAN)
    call SetRaceWorkshop(r, NAGA_HATCHERY)
    call SetRaceWorkshopItem(r, ITEM_NAGA_HATCHERY)
    call SetRaceAviary(r, NAGA_SERPENT_PYRAMID)
    call SetRaceAviaryItem(r, ITEM_NAGA_SERPENT_PYRAMID)
    call SetRaceSacrificialPit(r, NAGA_PORTAL)
    call SetRaceSacrificialPitItem(r, ITEM_NAGA_SERPENT_PYRAMID)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, NAGA_HOUSING)
    call SetRaceHousingItem(r, ITEM_NAGA_HOUSING)
    call SetRaceSpecialBuilding(r, NAGA_STATUE_OF_ASZHARA)
    call SetRaceSpecialBuildingItem(r, ITEM_NAGA_STATUE_OF_AZSHARA)
    call SetRaceShipyard(r, NAGA_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_NAGA_SHIPYARD)

    // researches
    call AddResearch(r, UPG_NAGA_ARMOR)
    call AddResearch(r, UPG_NAGA_ATTACK)
    call AddResearch(r, UPG_NAGA_ABOLISH)
    call AddResearch(r, UPG_SIREN)
    call AddResearch(r, UPG_NAGA_ENSNARE)
    call AddResearch(r, UPG_NAGA_SUBMERGE)
    call AddResearch(r, UPG_NAGA_SORCEROR)
    call AddResearch(r, UPG_NAGA_BACKPACK)
    call AddResearch(r, UPG_NAGA_RESISTANT_SKIN)
    call AddResearch(r, UPG_NAGA_TIDAL_WYRMS)
    call AddResearch(r, UPG_NAGA_SPIKED_SHELL)
    call AddResearch(r, UPG_NAGA_SLOW_POISON)
    call AddResearch(r, UPG_NAGA_SPAWN_HYDRA_HATCHLING)
    call AddResearch(r, UPG_NAGA_STATUE_OF_AZSHARA)

    // units
    call SetRaceWorker(r, NAGA_SLAVE)
    call SetRaceFootman(r, NAGA_REAVER)
    call SetRaceRifleman(r, NAGA_SNAP_DRAGON)
    call SetRaceKnight(r, NAGA_MYRMIDON)
    call SetRacePriest(r, NAGA_SORCEROR)
    call SetRaceSorceress(r, NAGA_SIREN)
    call SetRaceSpellBreaker(r, NAGA_WHALER)
    call SetRaceSiegeEngine(r, NAGA_TURTLE)
    call SetRaceMortar(r, NAGA_CORAL_GOLEM)
    call SetRaceWorkshop4(r, NAGA_HYDRA_X)
    call SetRaceTauren(r, NAGA_ROYAL)
    call SetRaceGryphon(r, NAGA_COUATL)
    call SetRaceDragonHawk(r, NAGA_COUATL)
    call SetRaceFlyingMachine(r, NAGA_COUATL)
    call SetRaceCitizenMale(r, NAGA_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, NAGA_CITIZEN_FEMALE)
    call SetRaceChild(r, NAGA_CHILD)
    call SetRacePet(r, NAGA_PET)
    call SetRaceTransportShip(r, ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ELF_FRIGATE)
    call SetRaceBattleship(r, ELF_BATTLESHIP)
endfunction

private function AddDraenei takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDraenei = r
    call SetRaceTavernItemType(r, ITEM_EREDAR)
    call SetRaceAiScript(r, "wowr\\Draenei.ai")
    call SetRaceItemType(r, ITEM_EREDAR_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, EREDAR_TIER_1)
    call SetRaceTier1Item(r, ITEM_EREDAR_TIER_1)
    call SetRaceTier2(r, EREDAR_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, EREDAR_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, EREDAR_PYLON)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, EREDAR_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, EREDAR_FORGE)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, EREDAR_ARGUNITE_MILL)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, EREDAR_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, EREDAR_MANARI_CRYSTAL)
    //call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, EREDAR_SHOP)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, EREDAR_SPIRE)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, EREDAR_GUARD_SPIRE)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, EREDAR_SIEGE_SPIRE)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, EREDAR_ARCANE_SPIRE)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, EREDAR_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, EREDAR_STABLES)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, EREDAR_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, EREDAR_EXODAR)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, EREDAR_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)
    
    // researches
    call AddResearch(r, UPG_EREDAR_BACKPACK)
    call AddResearch(r, UPG_EREDAR_DEFEND)
    call AddResearch(r, UPG_EREDAR_ARKONITE_DEFENSE)
    call AddResearch(r, UPG_EREDAR_MYSTIC)
    call AddResearch(r, UPG_EREDAR_HIGH_TEMPLAR)
    call AddResearch(r, UPG_EREDAR_SPACE_TRAVEL)
    call AddResearch(r, UPG_EREDAR_EXODAR)
    
    // units
    call SetRaceWorker(r, EREDAR_ARTIFICER)
    call SetRaceFootman(r, EREDAR_PEACEKEEPER)
    call SetRaceRifleman(r, EREDAR_RANGARI)
    call SetRaceKnight(r, EREDAR_OUTRIDER)
    call SetRacePriest(r, EREDAR_SORCERER)
    call SetRaceSorceress(r, EREDAR_SUCCUBUS)
    //call SetRaceSpellBreaker(r, HIGH_ELF_ARCH_CLERIC)
    call SetRaceSiegeEngine(r, EREDAR_ELEKK_KNIGHT)
    call SetRaceMortar(r, EREDAR_SIEGEBREAKER)
    call SetRaceFlyingMachine(r, EREDAR_DIMENSIONAL_SHIP)
    call SetRaceTauren(r, EREDAR_VIGILANT)
    call SetRaceGryphon(r, EREDAR_NETHER_RAY)
    //call SetRaceDragonHawk(r, HIGH_ELF_DRAGON_HAWK_RIDER)
    call SetRaceCitizenMale(r, EREDAR_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, EREDAR_CITIZEN_FEMALE)
    call SetRaceChild(r, EREDAR_CHILD)
    call SetRacePet(r, EREDAR_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddLostOnes takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceLostOnes = r
    call SetRaceTavernItemType(r, ITEM_LOST_ONES)
    call SetRaceAiScript(r, "wowr\\LostOnes.ai")
    call SetRaceItemType(r, ITEM_LOST_ONES_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, DRAENEI_HAVEN)
    call SetRaceTier1Item(r, ITEM_LOST_ONES_TIER_1)
    call SetRaceTier2(r, DRAENEI_HAVEN)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, DRAENEI_HAVEN)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, DRAENEI_HUT)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, DRAENEI_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, DRAENEI_MILL)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, DRAENEI_MILL)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, DRAENEI_ALTAR_OF_SEERS)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, DRAENEI_SEERS_DEN)
    //call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, DRAENEI_SHOP)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, DRAENEI_BOULDER_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, DRAENEI_ADVANCED_BOULDER_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, DRAENEI_ADVANCED_BOULDER_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, DRAENEI_ADVANCED_BOULDER_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    //call SetRaceWorkshop(r, EREDAR_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    //call SetRaceAviary(r, EREDAR_STABLES)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, DRAENEI_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, DRAENEI_PRISON)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, DRAENEI_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)
    
    // researches
    call AddResearch(r, UPG_DRAENEI_DEVOUR)
    call AddResearch(r, UPG_DRAENEI_DEMON_FIRE)
    call AddResearch(r, UPG_DRAENEI_HARBRINGER_ADEPT)
    call AddResearch(r, UPG_DRAENEI_SEER_ADEPT)
    call AddResearch(r, UPG_DRAENEI_IMPROVED_MASONRY)
    call AddResearch(r, UPG_DRAENEI_STEEL_ARMOR)
    call AddResearch(r, UPG_DRAENEI_STEEL_MELEE_WEAPONS)
    call AddResearch(r, UPG_DRAENEI_STEEL_RANGED_WEAPONS)
    call AddResearch(r, UPG_DRAENEI_PRISON)

    // units
    call SetRaceWorker(r, DRAENEI_LABORER)
    call SetRaceFootman(r, DRAENEI_VINDICATOR)
    call SetRaceRifleman(r, DRAENEI_SALAMANDER)
    call SetRaceKnight(r, DRAENEI_STALKER)
    call SetRacePriest(r, DRAENEI_SEER)
    call SetRaceSorceress(r, DRAENEI_HARBINGER)
    //call SetRaceSpellBreaker(r, HIGH_ELF_ARCH_CLERIC)
    //call SetRaceSiegeEngine(r, EREDAR_ELEKK_KNIGHT)
    call SetRaceMortar(r, DRAENEI_DEMOLISHER)
    //call SetRaceFlyingMachine(r, HIGH_ELF_EAGLE)
    //call SetRaceTauren(r, EREDAR_VIGILANT)
    call SetRaceGryphon(r, DRAENEI_NETHER_DRAKE)
    //call SetRaceDragonHawk(r, HIGH_ELF_DRAGON_HAWK_RIDER)
    call SetRaceCitizenMale(r, DRAENEI_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DRAENEI_CITIZEN_FEMALE)
    call SetRaceChild(r, DRAENEI_CHILD)
    call SetRacePet(r, DRAENEI_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddDemon takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDemon = r
    call SetRaceTavernItemType(r, ITEM_DEMON)
    call SetRaceAiScript(r, "wowr\\Demon.ai")
    call SetRaceItemType(r, ITEM_DEMON_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, DEMON_GATE_1)
    call SetRaceTier1Item(r, ITEM_DEMON_TIER_1)
    call SetRaceTier2(r, DEMON_GATE_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, DEMON_GATE_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, DEMON_FORTIFIED_INFERNAL_MACHINE)
    call SetRaceFarmItem(r, ITEM_DEMON_FORTIFIED_INFERNAL_MACHINE)
    call SetRaceBarracks(r, DEMON_DIMENSIONAL_GATE)
    call SetRaceBarracksItem(r, ITEM_DEMON_DIMENSIONAL_GATE)
    call SetRaceBlacksmith(r, DEMON_FLOATING_ROCKS)
    call SetRaceBlacksmithItem(r, ITEM_DEMON_FLOATING_ROCKS)
    call SetRaceMill(r, DEMON_LEGION_TRANSPORTER)
    call SetRaceMillItem(r, ITEM_DEMON_LEGION_TRANSPORTER)
    call SetRaceAltar(r, DEMON_ALTAR)
    call SetRaceAltarItem(r, ITEM_DEMON_ALTAR)
    call SetRaceArcaneSanctum(r, DEMON_DUNGEON_OF_PAIN)
    call SetRaceArcaneSanctumItem(r, ITEM_DEMON_DUNGEON_OF_PAIN)
    call SetRaceShop(r, DEMON_OBELISK)
    call SetRaceShopItem(r, ITEM_DEMON_OBELISK)
    call SetRaceScoutTower(r, DEMON_FORTIFIED_INFERNAL_JUGGERNAUT)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, DEMON_FORTIFIED_INFERNAL_JUGGERNAUT)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, DEMON_FORTIFIED_INFERNAL_JUGGERNAUT)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, DEMON_FORTIFIED_INFERNAL_JUGGERNAUT)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, DEMON_PORTAL)
    call SetRaceWorkshopItem(r, ITEM_DEMON_PORTAL)
    call SetRaceAviary(r, DEMON_SHRINE)
    call SetRaceAviaryItem(r, ITEM_DEMON_SHRINE)
    call SetRaceSacrificialPit(r, DEMON_SACRIFICAL_PIT)
    call SetRaceHousing(r, DEMON_HOUSING)
    call SetRaceHousingItem(r, ITEM_DEMON_HOUSING)
    call SetRaceSpecialBuilding(r, DEMON_BOOK_OF_SUMMONING)
    call SetRaceSpecialBuildingItem(r, ITEM_DEMON_BOOK_OF_SUMMONING)
    call SetRaceShipyard(r, DEMON_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_DEMON_SHIPYARD)

    // researches
    call AddResearch(r, UPG_DEMON_UNHOLY_STR)
    call AddResearch(r, UPG_DEMON_UNHOLY_ARMOR)
    call AddResearch(r, UPG_DEMON_CR_ATTACK)
    call AddResearch(r, UPG_DEMON_CR_ARMOR)
    call AddResearch(r, UPG_DEMON_WEB)
    call AddResearch(r, UPG_DEMON_CLEAVING_ATTACK)
    call AddResearch(r, UPG_DEMON_DEVOUR_MAGIC)
    call AddResearch(r, UPG_DEMON_FIRE)
    call AddResearch(r, UPG_DEMON_RAIN_OF_FIRE)
    call AddResearch(r, UPG_DEMON_DEFEND)
    call AddResearch(r, UPG_DEMON_CRIPPLE)
    call AddResearch(r, UPG_DEMON_SLOW)
    call AddResearch(r, UPG_DEMON_SUCCUBUS)
    call AddResearch(r, UPG_DEMON_EREDAR_SORCERER)
    call AddResearch(r, UPG_DEMON_RESISTANT_SKIN)
    call AddResearch(r, UPG_DEMON_PERMANENT_IMMOLATION)
    call AddResearch(r, UPG_DEMON_HARDENED_SKIN)
    call AddResearch(r, UPG_DEMON_WAR_STOMP)
    call AddResearch(r, UPG_DEMON_IMPROVED_DEVOUR)
    call AddResearch(r, UPG_DEMON_ANTI_MAGIC_SHELL)
    call AddResearch(r, UPG_DEMON_SOUL_THEFT)
    call AddResearch(r, UPG_DEMON_SPACE_TRAVEL)
    call AddResearch(r, UPG_DEMON_FEL_TRANSPORTING)
    call AddResearch(r, UPG_DEMON_INFERNO)
    call AddResearch(r, UPG_DEMON_BACKPACK)
    call AddResearch(r, UPG_DEMON_BOOK_OF_SUMMONING)

    // units
    call SetRaceWorker(r, DEMON_IMP)
    call SetRaceFootman(r, DEMON_OVERLORD)
    call SetRaceRifleman(r, DEMON_FEL_STALKER)
    call SetRaceKnight(r, DEMON_FEL_STALKER)
    call SetRacePriest(r, DEMON_EREDAR_SORCERER)
    call SetRaceSorceress(r, DEMON_SUCCUBUS)
    call SetRaceSpellBreaker(r, DEMON_GREATER_VOID_WALKER)
    call SetRaceArcaneSanctum4(r, DEMON_INQUISITOR)
    call SetRaceSiegeEngine(r, DEMON_INFERNAL_MACHINE)
    call SetRaceMortar(r, DEMON_INFERNAL_MACHINE)
    call SetRaceFlyingMachine(r, DEMON_LEGION_SHIP)
    call SetRaceTauren(r, DEMON_INFERNAL)
    call SetRaceGryphon(r, DEMON_NETHER_DRAKE)
    call SetRaceDragonHawk(r, DEMON_INFERNAL_REAVER)
    call SetRaceAviary3(r, DEMON_VOID_REAVER)
    call SetRaceAviary4(r, DEMON_FEL_REAVER)
    call SetRaceShade(r, DEMON_JAILER)
    call SetRaceCitizenMale(r, DEMON_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DEMON_CITIZEN_FEMALE)
    call SetRaceChild(r, DEMON_CHILD)
    call SetRacePet(r, DEMON_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddFurbolg takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceFurbolg = r
    call SetRaceTavernItemType(r, ITEM_FURBOLG)
    call SetRaceAiScript(r, "wowr\\Furbolg.ai")
    call SetRaceItemType(r, ITEM_FURBOLG_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, FURBOLG_TRIBAL_CENTER)
    call SetRaceTier1Item(r, ITEM_FURBOLG_TIER_1)
    call SetRaceTier2(r, FURBOLG_TRIBAL_CENTER)
    call SetRaceTier2Item(r, ITEM_FURBOLG_TIER_1)
    call SetRaceTier3(r, FURBOLG_TRIBAL_CENTER)
    call SetRaceTier3Item(r, ITEM_FURBOLG_TIER_1)
    call SetRaceFarm(r, FURBOLG_HUT)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, FURBOLG_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, FURBOLG_LUMBER_CAMP)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, FURBOLG_LUMBER_CAMP)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, RESURRECTION_STONE)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, FURBOLG_DEFILED_FOUNTAIN)
    //call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, FURBOLG_MARKETPLACE)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, GUARDING_FURBOLG)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, GUARDING_FURBOLG)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, GUARDING_FURBOLG)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, GUARDING_FURBOLG)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, FURBOLG_WOLVES_CAGE)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, FURBOLG_GREEN_DRAGON_ROOST)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    call SetRaceSacrificialPit(r, FURBOLG_POLAR_HUT)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, FURBOLG_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, FURBOLG_CORRUPTED_ANCIENT_PROTECTOR)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    //call SetRaceSpecialBuilding2(r, DEMON_OUTLAND_DIMENSIONAL_GATE)
    //call SetRaceSpecialBuilding2Item(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, FURBOLG_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_FURBOLG_BACKPACK)
    call AddResearch(r, UPG_FURBOLG_WEB)
    call AddResearch(r, UPG_FURBOLG_STEEL_RWEAPONS)
    call AddResearch(r, UPG_FURBOLG_STEEL_WEAPONS)
    call AddResearch(r, UPG_FURBOLG_STEEL_ARMOR)
    call AddResearch(r, UPG_FURBOLG_LUMBER)
    call AddResearch(r, UPG_FURBOLG_SHAMAN)
    call AddResearch(r, UPG_FURBOLG_ELDER_SHAMAN)
    call AddResearch(r, UPG_FURBOLG_FAERIE_FIRE)
    call AddResearch(r, UPG_FURBOLG_ENSNARE)
    call AddResearch(r, UPG_FURBOLG_CR_ARMOR)
    call AddResearch(r, UPG_FURBOLG_CR_ATTACK)
    call AddResearch(r, UPG_FURBOLG_CORRUPTION)
    call AddResearch(r, UPG_FURBOLG_BLOOD_LUST)
    call AddResearch(r, UPG_FURBOLG_BASH)
    call AddResearch(r, UPG_FURBOLG_CORRUPTED_ANCIENT_PROTECTOR)

    // units
    call SetRaceWorker(r, YOUNG_FURBOLG)
    call SetRaceFootman(r, FURBOLG_EX)
    call SetRaceRifleman(r, FURBOLG_TRACKER_EX)
    call SetRaceKnight(r, FURBOLG_CHAMPION_EX)
    call SetRacePriest(r, FURBOLG_SHAMAN_EX)
    call SetRaceSorceress(r, FURBOLG_ELDER_SHAMAN)
    call SetRaceSpellBreaker(r, POLAR_FURBOLG)
    call SetRaceSiegeEngine(r, GIANT_WOLF)
    call SetRaceMortar(r, DIRE_WOLF)
    call SetRaceFlyingMachine(r, TIMBER_WOLF)
    call SetRaceTauren(r, FURBOLG_URSA_WARRIOR)
    call SetRaceGryphon(r, GREEN_DRAKE)
    call SetRaceDragonHawk(r, GREEN_DRAKE)
    call SetRaceShade(r, POLAR_FURBOLG_CHAMPION)
    call SetRaceCitizenMale(r, FURBOLG_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, FURBOLG_CITIZEN_FEMALE)
    call SetRaceChild(r, FURBOLG_CHILD)
    call SetRacePet(r, FURBOLG_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddGoblin takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceGoblin = r
    call SetRaceTavernItemType(r, ITEM_GOBLIN)
    call SetRaceAiScript(r, "wowr\\Goblin.ai")
    call SetRaceItemType(r, ITEM_GOBLIN_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, GOBLIN_TIER_1)
    call SetRaceTier1Item(r, ITEM_GOBLIN_TIER_1)
    call SetRaceTier2(r, GOBLIN_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, GOBLIN_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, GOBLIN_HUT)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, GOBLIN_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, GOBLIN_FUEL_PUMP)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, GOBLIN_FUEL_PUMP)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, GOBLIN_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, GOBLIN_ARCANE_LABORATORY)
    //call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, GOBLIN_SHOP)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, GOBLIN_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, GOBLIN_ROCKET_TOWER_1)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, GOBLIN_ROCKET_TOWER_2)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, GOBLIN_ROCKET_TOWER_3)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, GOBLIN_TANK_FACTORY)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, GOBLIN_AIR_FIELD)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    call SetRaceSacrificialPit(r, GOBLIN_TUNNEL)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, GOBLIN_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, GOBLIN_HEAVY_TANK)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    //call SetRaceSpecialBuilding2(r, DEMON_OUTLAND_DIMENSIONAL_GATE)
    //call SetRaceSpecialBuilding2Item(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, GOBLIN_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_GOBLIN_BACKPACK)
    call AddResearch(r, UPG_GOBLIN_STEEL_RWEAPONS)
    call AddResearch(r, UPG_GOBLIN_STEEL_WEAPONS)
    call AddResearch(r, UPG_GOBLIN_STEEL_ARMOR)
    call AddResearch(r, UPG_GOBLIN_ALCHEMIST_ADEPT)
    call AddResearch(r, UPG_GOBLIN_MAGE_ADEPT)
    call AddResearch(r, UPG_GOBLIN_SORCERESS_ADEPT)
    call AddResearch(r, UPG_GOBLIN_AIR_SUPPLIES)
    call AddResearch(r, UPG_GOBLIN_BARRAGE)
    call AddResearch(r, UPG_GOBLIN_CHEMISTRY)
    call AddResearch(r, UPG_GOBLIN_CLUSTER_ROCKETS)
    call AddResearch(r, UPG_GOBLIN_CUT_DOWN_TREES)
    call AddResearch(r, UPG_GOBLIN_DEMOLISH)
    call AddResearch(r, UPG_GOBLIN_ENGINEERING)
    call AddResearch(r, UPG_GOBLIN_EXPLOSIVE_BARREL)
    call AddResearch(r, UPG_GOBLIN_EXPLOSIVES)
    call AddResearch(r, UPG_GOBLIN_FLAME_GRENADES)
    call AddResearch(r, UPG_GOBLIN_BURNING_OIL)
    call AddResearch(r, UPG_GOBLIN_FUEL)
    call AddResearch(r, UPG_GOBLIN_WAR_ZEPPELIN_BOMBS)
    call AddResearch(r, UPG_GOBLIN_IMPROVED_CONSTRUCTION)
    call AddResearch(r, UPG_GOBLIN_MOBILE_TURRET)
    call AddResearch(r, UPG_GOBLIN_OBSERVATORY)
    call AddResearch(r, UPG_GOBLIN_OIL_DRILLING)
    call AddResearch(r, UPG_GOBLIN_REPAIR)
    call AddResearch(r, UPG_GOBLIN_BANKING)
    call AddResearch(r, UPG_GOBLIN_LUMBER)
    call AddResearch(r, UPG_GOBLIN_BERSERK_TANK)

    // units
    call SetRaceWorker(r, GOBLIN_LABORER)
    call SetRaceFootman(r, GOBLIN_FLAMETHROWER)
    call SetRaceRifleman(r, GOBLIN_SAPPER)
    call SetRaceKnight(r, OGRE_GOBLIN_SQUAD)
    call SetRaceBarracks4(r, GOBLIN_FLAME_SHREDDER)
    call SetRacePriest(r, GOBLIN_MAGE)
    call SetRaceSorceress(r, GOBLIN_SORCERESS)
    call SetRaceSpellBreaker(r, GOBLIN_ALCHEMIST)
    call SetRaceArcaneSanctum4(r, GOBLIN_TURRET)
    call SetRaceSiegeEngine(r, GOBLIN_ASSAULT_TANK)
    call SetRaceMortar(r, GOBLIN_STEAM_ROLLER)
    call SetRaceFlyingMachine(r, GOBLIN_ZEPPELIN)
    call SetRaceWorkshop4(r, GOBLIN_FLAME_TANK)
    call SetRaceTauren(r, GOBLIN_EMPEROR)
    call SetRaceGryphon(r, GOBLIN_AIR_DRONE)
    call SetRaceDragonHawk(r, GOBLIN_WAR_ZEPPELIN)
    call SetRaceShade(r, GOBLIN_ARTIST)
    call SetRaceCitizenMale(r, GOBLIN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, GOBLIN_CITIZEN_FEMALE)
    call SetRaceChild(r, GOBLIN_CHILD)
    call SetRacePet(r, GOBLIN_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
    call SetRaceShipSpecial1(r, GOBLIN_SUBMARINE)
endfunction

private function AddDwarf takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDwarf = r
    call SetRaceTavernItemType(r, ITEM_DWARF)
    call SetRaceAiScript(r, "wowr\\Dwarf.ai")
    call SetRaceItemType(r, ITEM_DWARF_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, DWARF_TIER_1)
    call SetRaceTier1Item(r, ITEM_DWARF_TIER_1)
    call SetRaceTier2(r, DWARF_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, DWARF_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, DWARF_HOUSE)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, DWARF_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, DWARF_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, DWARF_BLACKSMITH)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, DWARF_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, DWARF_MYSTICAL_HALL)
    //call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, DWARF_TAVERN)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, DWARF_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, DWARF_TOWER_GUARD)
    //call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, DWARF_TOWER_CANNON)
    //call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, DWARF_TOWER_GUN)
    //call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, DWARF_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, DWARF_BEASTIARY)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceSacrificialPit(r, GOBLIN_TUNNEL)
    call SetRaceMine(r, DWARF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, DWARF_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, DWARF_LUMBER_MILL)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    //call SetRaceSpecialBuilding2(r, DEMON_OUTLAND_DIMENSIONAL_GATE)
    //call SetRaceSpecialBuilding2Item(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, DWARF_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_DWARF_BACKPACK)
    call AddResearch(r, UPG_DWARF_RANGED)
    call AddResearch(r, UPG_DWARF_MELEE)
    call AddResearch(r, UPG_DWARF_ARMOR)
    call AddResearch(r, UPG_DWARF_LEATHER)
    call AddResearch(r, UPG_DWARF_BATTLEPRIEST)
    call AddResearch(r, UPG_DWARF_RUNECASTER)
    call AddResearch(r, UPG_DWARF_BERSERK)
    call AddResearch(r, UPG_DWARF_SLAM)
    call AddResearch(r, UPG_DWARF_SLEEP_FORM)
    call AddResearch(r, UPG_DWARF_ANIMAL_WAR_TRAINING)
    call AddResearch(r, UPG_DWARF_BARRAGE)
    call AddResearch(r, UPG_DWARF_BREEDING)
    call AddResearch(r, UPG_DWARF_DEVOUR)
    call AddResearch(r, UPG_DWARF_ELITE_SIEGE_TANK)
    call AddResearch(r, UPG_DWARF_FLAK_CANNONS)
    call AddResearch(r, UPG_DWARF_FLARE)
    call AddResearch(r, UPG_DWARF_MITHRIL)
    call AddResearch(r, UPG_DWARF_POLAR_BEARS)
    call AddResearch(r, UPG_DWARF_FLYING_MACHINE_BOMBS)
    call AddResearch(r, UPG_DWARF_FRAGMENTATION_SHARDS)
    call AddResearch(r, UPG_DWARF_LONG_RIFLES)
    call AddResearch(r, UPG_DWARF_STORM_HAMMERS)
    call AddResearch(r, UPG_DWARF_MASONRY)
    call AddResearch(r, UPG_DWARF_LUMBER)
    call AddResearch(r, UPG_DWARF_LUMBER_MILL)

    // units
    call SetRaceWorker(r, DWARF_MINER)
    call SetRaceFootman(r, DWARF_TROLL_SLAYER)
    call SetRaceRifleman(r, DWARF_RIFLEMAN)
    call SetRaceKnight(r, DWARF_RIDER)
    call SetRacePriest(r, DWARF_BATTLEPRIEST)
    call SetRaceSorceress(r, DWARF_RUNECASTER)
    call SetRaceSpellBreaker(r, DWARF_WAR_GOLEM)
    call SetRaceSiegeEngine(r, DWARF_SIEGE_ENGINE)
    call SetRaceMortar(r, DWARF_MORTAR)
    call SetRaceFlyingMachine(r, DWARF_FLYING_MACHINE)
    call SetRaceWorkshop4(r, DWARF_STEAM_FORTRESS)
    call SetRaceTauren(r, DWARF_POLAR_BEAR)
    call SetRaceGryphon(r, DWARF_GRYPHON_RIDER)
    call SetRaceDragonHawk(r, DWARF_GRYPHON)
    call SetRaceCitizenMale(r, DWARF_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DWARF_CITIZEN_FEMALE)
    call SetRaceChild(r, DWARF_CHILD)
    call SetRacePet(r, DWARF_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
    call SetRaceShipSpecial1(r, DWARF_SUBMARINE)
endfunction

private function AddHighElf takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceHighElf = r
    call SetRaceTavernItemType(r, ITEM_HIGH_ELF)
    call SetRaceAiScript(r, "wowr\\HighElf.ai")
    call SetRaceItemType(r, ITEM_HIGH_ELF_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, HIGH_ELF_TIER_1)
    call SetRaceTier1Item(r, ITEM_HIGH_ELF_TIER_1)
    call SetRaceTier2(r, HIGH_ELF_TIER_2)
    call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, HIGH_ELF_TIER_3)
    call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, HIGH_ELF_FARM)
    call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, HIGH_ELF_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, HIGH_ELF_DRAGON_NEXUS)
    call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, HIGH_ELF_ALTAR)
    call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, HIGH_ELF_MAGE_TOWER)
    call SetRaceArcaneSanctumItem(r, ITEM_HIGH_ELF_MAGE_TOWER)
    call SetRaceShop(r, HIGH_ELF_BAZAAR)
    call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, HIGH_ELF_OUTPOST)
    call SetRaceScoutTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTower(r, HIGH_ELF_GUARD_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTower(r, HIGH_ELF_GUARD_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTower(r, HIGH_ELF_GUARD_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_HIGH_ELF_GUARD_TOWER)
    call SetRaceWorkshop(r, HIGH_ELF_STABLES)
    call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, HIGH_ELF_AVIARY)
    call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, HIGH_ELF_HOUSING)
    call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, HIGH_ELF_SUNWELL)
    call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, HIGH_ELF_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_HIGH_ELF_DEFEND)
    call AddResearch(r, UPG_HIGH_ELF_BOWS)
    call AddResearch(r, UPG_HIGH_ELF_WOOD)
    call AddResearch(r, UPG_HIGH_ELF_MASONRY)
    call AddResearch(r, UPG_HIGH_ELF_MELEE)
    call AddResearch(r, UPG_HIGH_ELF_ARMOR)
    call AddResearch(r, UPG_HIGH_ELF_STR_MOON)
    call AddResearch(r, UPG_HIGH_ELF_LEATHER)
    call AddResearch(r, UPG_HIGH_ELF_MARKSMAN)
    call AddResearch(r, UPG_HIGH_ELF_PRAYING)
    call AddResearch(r, UPG_HIGH_ELF_SORCERY)
    call AddResearch(r, UPG_HIGH_ELF_PRAYING_CLERIC)
    call AddResearch(r, UPG_HIGH_ELF_ANIMAL)
    call AddResearch(r, UPG_HIGH_ELF_ANTIMAGIC)
    call AddResearch(r, UPG_HIGH_ELF_CLOUD)
    call AddResearch(r, UPG_HIGH_ELF_TAMING)
    call AddResearch(r, UPG_HIGH_ELF_BACKPACK)
    call AddResearch(r, UPG_HIGH_ELF_MAGIC_SENTRY)
    call AddResearch(r, UPG_HIGH_ELF_DRAGONHAWL_TAMING)
    call AddResearch(r, UPG_HIGH_ELF_DIURNAL)
    call AddResearch(r, UPG_HIGH_ELF_SUNWELL)

    // units
    call SetRaceWorker(r, HIGH_ELF_ENGINEER)
    call SetRaceFootman(r, HIGH_ELF_SWORDMAN)
    call SetRaceRifleman(r, HIGH_ELF_ARCHER)
    call SetRaceKnight(r, HIGH_ELF_KNIGHT)
    call SetRacePriest(r, HIGH_ELF_PRIEST)
    call SetRaceSorceress(r, HIGH_ELF_SORCERESS)
    call SetRaceSpellBreaker(r, HIGH_ELF_ARCH_CLERIC)
    call SetRaceSiegeEngine(r, HIGH_ELF_BIRDIEPULT)
    call SetRaceMortar(r, HIGH_ELF_BIRDIEPULT)
    call SetRaceFlyingMachine(r, HIGH_ELF_EAGLE)
    call SetRaceTauren(r, HIGH_ELF_LIEUTENANT)
    call SetRaceGryphon(r, HIGH_ELF_DRAGON)
    call SetRaceDragonHawk(r, HIGH_ELF_DRAGON_HAWK_RIDER)
    call SetRaceAviary3(r, HIGH_ELF_DRAGON_HAWK)
    call SetRaceCitizenMale(r, HIGH_ELF_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, HIGH_ELF_CITIZEN_FEMALE)
    call SetRaceChild(r, HIGH_ELF_CHILD)
    call SetRacePet(r, HIGH_ELF_PET)
    call SetRaceTransportShip(r, HIGH_ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HIGH_ELF_FRIGATE)
    call SetRaceBattleship(r, HIGH_ELF_BATTLESHIP)
endfunction

private function AddGnome takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceGnome = r
    call SetRaceTavernItemType(r, ITEM_GNOME)
    call SetRaceAiScript(r, "wowr\\Gnome.ai")
    call SetRaceItemType(r, ITEM_GNOME_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, GNOME_TIER_1)
    call SetRaceTier1Item(r, ITEM_GNOME_TIER_1)
    call SetRaceTier2(r, GNOME_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, GNOME_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, GNOME_GEAR)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, GNOME_BRASSMAN)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, GNOME_FACTORY)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, GNOME_FACTORY)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, GNOME_ALTAR_OF_TECHNOLOGY)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, GNOME_LABORATORY)
    //call SetRaceArcaneSanctumItem(r, ITEM_ELF_ANCIENT_OF_WIND)
    call SetRaceShop(r, GNOME_TECHNOLOGY_FAIR)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, GNOME_TURRET)
    call SetRaceScoutTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceGuardTower(r, GNOME_TURRET)
    call SetRaceGuardTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceCannonTower(r, GNOME_TURRET)
    call SetRaceCannonTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceArcaneTower(r, GNOME_TURRET)
    call SetRaceArcaneTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceWorkshop(r, GNOME_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, GNOME_AVIARY)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    call SetRaceSacrificialPit(r, GNOME_TELEPORTER)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, GNOME_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, GNOME_SKYFIRE_GUNSHIP)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, GNOME_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_GNOME_BACKPACK)
    call AddResearch(r, UPG_GNOME_INVENTIONS)
    call AddResearch(r, UPG_GNOME_SORCERESS)
    call AddResearch(r, UPG_GNOME_ARCANIST)
    call AddResearch(r, UPG_GNOME_MAGE)
    call AddResearch(r, UPG_GNOME_DAMAGE)
    call AddResearch(r, UPG_GNOME_ARMOR)
    call AddResearch(r, UPG_GNOME_ENGINEERING)
    call AddResearch(r, UPG_GNOME_RESISTANT_SKIN)
    call AddResearch(r, UPG_GNOME_LONG_RIFLES)
    call AddResearch(r, UPG_GNOME_WINDWALK)
    call AddResearch(r, UPG_GNOME_SKYFIRE_GUNSHIP)

    // units
    call SetRaceWorker(r, GNOME_ENGINEER)
    call SetRaceFootman(r, GNOME_ROGUE)
    call SetRaceRifleman(r, GNOME_RIFLEMAN)
    call SetRaceKnight(r, GNOME_FIELD_ENGINEER)
    call SetRacePriest(r, GNOME_ARCANIST)
    call SetRaceSorceress(r, GNOME_SORCERESS)
    call SetRaceSpellBreaker(r, GNOME_MAGE)
    call SetRaceSiegeEngine(r, GNOME_ARTILLERY_TANK)
    call SetRaceMortar(r, GNOME_MORTAR_TEAM)
    call SetRaceFlyingMachine(r, GNOME_FLYING_MACHINE)
    call SetRaceTauren(r, GNOME_DRILL_ENGINE)
    call SetRaceGryphon(r, GNOME_GRYPHON_RIDER)
    call SetRaceDragonHawk(r, GNOME_HOVER_COPTER)
    call SetRaceCitizenMale(r, GNOME_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, GNOME_CITIZEN_FEMALE)
    call SetRaceChild(r, GNOME_CITIZEN_CHILD)
    call SetRacePet(r, GNOME_CITIZEN_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
endfunction

private function AddTroll takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceTroll = r
    call SetRaceTavernItemType(r, ITEM_TROLL)
    call SetRaceAiScript(r, "wowr\\Troll.ai")
    call SetRaceItemType(r, ITEM_TROLL_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, TROLL_TIER_1)
    call SetRaceTier1Item(r, ITEM_TROLL_TIER_1)
    call SetRaceTier2(r, TROLL_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, TROLL_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, TROLL_HUT)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, TROLL_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, TROLL_WAR_MILL)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, TROLL_WAR_MILL)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, TROLL_ALTAR_OF_BLOOD)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, TROLL_SPIRIT_LODGE)
    //call SetRaceArcaneSanctumItem(r, ITEM_ELF_ANCIENT_OF_WIND)
    call SetRaceShop(r, TROLL_VOODOO_LOUNGE)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, TROLL_WATCH_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceGuardTower(r, TROLL_WATCH_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceCannonTower(r, TROLL_WATCH_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceArcaneTower(r, TROLL_WATCH_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceWorkshop(r, TROLL_BESTIARY)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, TROLL_ICE_TROLL_HUT)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    call SetRaceSacrificialPit(r, TROLL_ARENA)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, TROLL_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, TROLL_TEMPLE_OF_SACRIFICE)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, TROLL_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_TROLL_BACKPACK)
    call AddResearch(r, UPG_TROLL_SPEARS)
    call AddResearch(r, UPG_TROLL_ARMOR)
    call AddResearch(r, UPG_TROLL_CREATURE_ATTACK)
    call AddResearch(r, UPG_TROLL_CREATURE_ARMOR)
    call AddResearch(r, UPG_TROLL_TROLL_REGENEARTION)
    call AddResearch(r, UPG_TROLL_ICE_TROLL_HIGH_PRIEST)
    call AddResearch(r, UPG_TROLL_TRUESHOT_AURA)
    call AddResearch(r, UPG_TROLL_WAR_DRUMS)
    call AddResearch(r, UPG_TROLL_TROLL_HEXER)
    call AddResearch(r, UPG_TROLL_SHAMAN)
    call AddResearch(r, UPG_TROLL_TROLL_WITCH_DOCTOR)
    call AddResearch(r, UPG_TROLL_TROLL_BLOODMAGE)
    call AddResearch(r, UPG_TROLL_TROLL_TRIBES)
    call AddResearch(r, UPG_TROLL_BERSERKER)
    call AddResearch(r, UPG_TROLL_LIQUID_FIRE)
    call AddResearch(r, UPG_TROLL_BARRAGE)
    call AddResearch(r, UPG_TROLL_TEMPLE_OF_SACRIFICE)

    // units
    call SetRaceWorker(r, TROLL_GATHERER)
    call SetRaceFootman(r, TROLL_MAN_HUNTER)
    call SetRaceRifleman(r, TROLL_HEAD_HUNTER)
    call SetRaceKnight(r, TROLL_RIDER)
    call SetRacePriest(r, TROLL_WITCH_DOCTOR)
    call SetRaceSorceress(r, TROLL_SHAMAN)
    call SetRaceSpellBreaker(r, TROLL_HEXER)
    call SetRaceArcaneSanctum4(r, TROLL_BLOOD_MAGE)
    call SetRaceSiegeEngine(r, TROLL_ICE_TROLL_WARLORD)
    call SetRaceMortar(r, TROLL_VOODOO_CANNONEER)
    call SetRaceFlyingMachine(r, TROLL_ICE_TROLL_HIGH_PRIEST)
    call SetRaceTauren(r, TROLL_THRONE_OF_WAR)
    call SetRaceGryphon(r, TROLL_BATRIDER)
    call SetRaceDragonHawk(r, TROLL_BAT)
    call SetRaceCitizenMale(r, TROLL_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, TROLL_CITIZEN_FEMALE)
    call SetRaceChild(r, TROLL_CHILD)
    call SetRacePet(r, TROLL_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
    call SetRaceShipSpecial1(r, TROLL_TIGERSHARK_RIDER)
endfunction

private function AddTauren takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceTauren = r
    call SetRaceTavernItemType(r, ITEM_TAUREN)
    call SetRaceAiScript(r, "wowr\\Tauren.ai")
    call SetRaceItemType(r, ITEM_TAUREN_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, TAUREN_TIER_1)
    call SetRaceTier1Item(r, ITEM_TAUREN_TIER_1)
    call SetRaceTier2(r, TAUREN_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, TAUREN_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, TAUREN_TENT)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, TAUREN_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, TAUREN_LUMBER_MILL)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, TAUREN_LUMBER_MILL)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, TAUREN_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, TAUREN_SPIRIT_LODGE)
    //call SetRaceArcaneSanctumItem(r, ITEM_ELF_ANCIENT_OF_WIND)
    call SetRaceShop(r, TAUREN_SPIRIT_LOUNGE)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, TAUREN_WATCH_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceGuardTower(r, TAUREN_WATCH_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceCannonTower(r, TAUREN_WATCH_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceArcaneTower(r, TAUREN_WATCH_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceWorkshop(r, TAUREN_TAUREN_TOTEM)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, TAUREN_WYVERN_ROOST)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceSacrificialPit(r, GNOME_TELEPORTER)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, TAUREN_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, TAUREN_TOTEM_POLE)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, TAUREN_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_TAUREN_BACKPACK)
    call AddResearch(r, UPG_TAUREN_ARMOR)
    call AddResearch(r, UPG_TAUREN_MELEE)
    call AddResearch(r, UPG_TAUREN_RANGED)
    call AddResearch(r, UPG_TAUREN_EARTH_MOTHER)
    call AddResearch(r, UPG_TAUREN_INVISIBILITY)
    call AddResearch(r, UPG_TAUREN_PULVERIZE)
    call AddResearch(r, UPG_TAUREN_DRUID)
    call AddResearch(r, UPG_TAUREN_SPIRIT_WALKER)
    call AddResearch(r, UPG_TAUREN_WAR_DRUMS)
    call AddResearch(r, UPG_TAUREN_ELITE_TAUREN)
    call AddResearch(r, UPG_TAUREN_TOTEM_POLE)

    // units
    call SetRaceWorker(r, TAUREN_WORKER)
    call SetRaceFootman(r, TAUREN_AXE_FIGHTER)
    call SetRaceRifleman(r, TAUREN_SPEAR_THROWER)
    call SetRaceKnight(r, TAUREN_KODO_BEAST_RIDER)
    call SetRacePriest(r, TAUREN_DRUID)
    call SetRaceSorceress(r, TAUREN_SPIRIT_WALKER)
    call SetRaceSpellBreaker(r, TAUREN_SPIRIT_WALKER)
    call SetRaceSiegeEngine(r, TAUREN_KODO_BEAST_RIDERLESS)
    call SetRaceMortar(r, TAUREN_CATAPULT)
    call SetRaceFlyingMachine(r, TAUREN_SPIRIT_WYVERN)
    call SetRaceTauren(r, TAUREN_TAUREN)
    call SetRaceGryphon(r, TAUREN_WYVERN)
    call SetRaceDragonHawk(r, TAUREN_SPIRIT_WYVERN)
    call SetRaceCitizenMale(r, TAUREN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, TAUREN_CITIZEN_FEMALE)
    call SetRaceChild(r, TAUREN_CHILD)
    call SetRacePet(r, TAUREN_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddPandaren takes nothing returns nothing
    local integer r = AddRace()
    set udg_RacePandaren = r
    call SetRaceTavernItemType(r, ITEM_PANDAREN)
    call SetRaceAiScript(r, "wowr\\Pandaren.ai")
    call SetRaceItemType(r, ITEM_PANDAREN_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, PANDAREN_TIER_1)
    call SetRaceTier1Item(r, ITEM_PANDAREN_TIER_1)
    call SetRaceTier2(r, PANDAREN_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HIGH_ELF_TIER_2)
    call SetRaceTier3(r, PANDAREN_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HIGH_ELF_TIER_3)
    call SetRaceFarm(r, PANDAREN_SHELTER)
    //call SetRaceFarmItem(r, ITEM_HIGH_ELF_FARM)
    call SetRaceBarracks(r, PANDAREN_WAR_ACADEMY)
    //call SetRaceBarracksItem(r, ITEM_HIGH_ELF_BARRACKS)
    call SetRaceBlacksmith(r, PANDAREN_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_HIGH_ELF_DRAGON_NEXUS)
    call SetRaceMill(r, PANDAREN_LUMBER_MILL)
    //call SetRaceMillItem(r, ITEM_HIGH_ELF_ENCHANTER_TOWER)
    call SetRaceAltar(r, PANDAREN_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HIGH_ELF_ALTAR)
    call SetRaceArcaneSanctum(r, PANDAREN_ELEMENTAL_SANCTUARY)
    //call SetRaceArcaneSanctumItem(r, ITEM_ELF_ANCIENT_OF_WIND)
    call SetRaceShop(r, PANDAREN_BREWERY)
    //call SetRaceShopItem(r, ITEM_HIGH_ELF_BAZAAR)
    call SetRaceScoutTower(r, PANDAREN_SCOUT_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceGuardTower(r, PANDAREN_GUARD_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceCannonTower(r, PANDAREN_CANNON_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceArcaneTower(r, PANDAREN_MAGIC_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_GNOME_TURRET)
    call SetRaceWorkshop(r, PANDAREN_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HIGH_ELF_STABLES)
    call SetRaceAviary(r, PANDAREN_STORM_SPIRE)
    //call SetRaceAviaryItem(r, ITEM_HIGH_ELF_AVIARY)
    //call SetRaceSacrificialPit(r, GNOME_TELEPORTER)
    //call SetRaceMine(r, ELF_MINE)
    //call SetRaceMineItem(r, ITEM_ORC_TOTEM)
    call SetRaceHousing(r, PANDAREN_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HIGH_ELF_HOUSING)
    call SetRaceSpecialBuilding(r, PANDAREN_JADE_FOREST)
    //call SetRaceSpecialBuildingItem(r, ITEM_HIGH_ELF_SUNWELL)
    call SetRaceShipyard(r, PANDAREN_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HIGH_ELF_SHIPYARD)

    // researches
    call AddResearch(r, UPG_PANDAREN_BACKPACK)
    call AddResearch(r, UPG_PANDAREN_MELEE)
    call AddResearch(r, UPG_PANDAREN_ARMOR)
    call AddResearch(r, UPG_PANDAREN_DRINK)
    call AddResearch(r, UPG_PANDAREN_DEFEND)
    call AddResearch(r, UPG_PANDAREN_IMPROVED_BOWS)
    call AddResearch(r, UPG_PANDAREN_DRUNK_PANDA)
    call AddResearch(r, UPG_PANDAREN_DRUID)
    call AddResearch(r, UPG_PANDAREN_MONK)
    call AddResearch(r, UPG_PANDAREN_SAGE)
    call AddResearch(r, UPG_PANDAREN_BERSERK)
    call AddResearch(r, UPG_PANDAREN_CHAIN_LIGHTNING)
    call AddResearch(r, UPG_PANDAREN_CLOUD)
    call AddResearch(r, UPG_PANDAREN_COMMAND_AURA)
    call AddResearch(r, UPG_PANDAREN_FIREWORK)
    call AddResearch(r, UPG_PANDAREN_FRAGMENTATION_SHARDS)
    call AddResearch(r, UPG_PANDAREN_HARDENED_SKIN)
    call AddResearch(r, UPG_PANDAREN_MAGIC_SENTRY)
    call AddResearch(r, UPG_PANDAREN_SPIKED_SHELL)
    call AddResearch(r, UPG_PANDAREN_BAMBOO_STICKS)
    call AddResearch(r, UPG_PANDAREN_JADE_FOREST)

    // units
    call SetRaceWorker(r, PANDAREN_WOODCUTTER)
    call SetRaceFootman(r, PANDAREN_HONORGUARD)
    call SetRaceRifleman(r, PANDAREN_ARCHER)
    call SetRaceKnight(r, PANDAREN_WARLORD)
    call SetRacePriest(r, PANDAREN_SHAMAN)
    call SetRaceSorceress(r,  PANDAREN_SAGE)
    call SetRaceSpellBreaker(r, PANDAREN_DRUID)
    call SetRaceSiegeEngine(r, PANDAREN_DRAGON_TURTLE)
    call SetRaceMortar(r, PANDAREN_FIREWORK_TEAM)
    call SetRaceFlyingMachine(r, PANDAREN_GIANT_SEA_TURTLE)
    call SetRaceTauren(r, PANDAREN_PRIMAL_PANDAREN)
    call SetRaceGryphon(r, PANDAREN_CLOUD_SERPENT)
    call SetRaceDragonHawk(r, PANDAREN_CLOUD_SERPENT)
    call SetRaceCitizenMale(r, PANDAREN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, PANDAREN_CITIZEN_FEMALE)
    call SetRaceChild(r, PANDAREN_CHILD)
    call SetRacePet(r, PANDAREN_PET)
    call SetRaceTransportShip(r, PANDAREN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ELF_FRIGATE)
    call SetRaceBattleship(r, PANDAREN_BATTLESHIP)
endfunction

private function AddLordaeron takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceLordaeron = r
    call SetRaceTavernItemType(r, ITEM_LORDAERON)
    call SetRaceAiScript(r, "wowr\\Lordaeron.ai")
    call SetRaceItemType(r, ITEM_LORDAERON_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, LORDAERON_TIER_1)
    call SetRaceTier1Item(r, ITEM_LORDAERON_TIER_1)
    call SetRaceTier2(r, LORDAERON_TIER_2)
    //call SetRaceTier2Item(r, ITEM_STORMWIND_TIER_2)
    call SetRaceTier3(r, LORDAERON_TIER_3)
    //call SetRaceTier3Item(r, ITEM_STORMWIND_TIER_3)
    call SetRaceFarm(r, LORDAERON_FARM)
    //call SetRaceFarmItem(r, ITEM_STORMWIND_FARM)
    call SetRaceBarracks(r, LORDAERON_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_STORMWIND_BARRACKS)
    call SetRaceBlacksmith(r, LORDAERON_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_STORMWIND_BLACKSMITH)
    call SetRaceMill(r, LORDAERON_LUMBER_MILL)
    //call SetRaceMillItem(r, ITEM_STORMWIND_LUMBER_MILL)
    call SetRaceAltar(r, LORDAERON_ALTAR)
    //call SetRaceAltarItem(r, ITEM_STORMWIND_ALTAR)
    call SetRaceArcaneSanctum(r, LORDAERON_MAGE_TOWER)
    //call SetRaceArcaneSanctumItem(r, ITEM_STORMWIND_MAGE_TOWER)
    call SetRaceShop(r, LORDAERON_TRADE_HOUSE)
    //call SetRaceShopItem(r, ITEM_STORMWIND_ARCANE_VAULT)
    call SetRaceScoutTower(r, LORDAERON_SCOUT_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_STORMWIND_SCOUT_TOWER)
    call SetRaceGuardTower(r, LORDAERON_GUARD_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_STORMWIND_GUARD_TOWER)
    call SetRaceCannonTower(r, LORDAERON_CANNON_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_STORMWIND_CANNON)
    call SetRaceArcaneTower(r, LORDAERON_ARCANE_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_STORMWIND_ARCANE_TOWER)
    call SetRaceWorkshop(r, LORDAERON_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_STORMWIND_WORKSHOP)
    call SetRaceAviary(r, LORDAERON_AVIARY)
    //call SetRaceAviaryItem(r, ITEM_STORMWIND_AVIARY)
    //call SetRaceSacrificialPit(r, DALARAN_ELEMENTAL_SANCTUARY_1)
    //call SetRaceMine(r, DALARAN_MINE)
    call SetRaceHousing(r, LORDAERON_HOUSING)
    //call SetRaceHousingItem(r, ITEM_STORMWIND_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, LORDAERON_SCARLET_MONASTERY)
    //call SetRaceSpecialBuildingItem(r, ITEM_STORMWIND_CATHEDRAL_OF_LIGHT)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, LORDAERON_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_STORMWIND_SHIPYARD)

    call AddResearch(r, UPG_LORDAERON_LUMBER)
    call AddResearch(r, UPG_LORDAERON_MASONRY)
    call AddResearch(r, UPG_LORDAERON_MELEE)
    call AddResearch(r, UPG_LORDAERON_ARMOR)
    call AddResearch(r, UPG_LORDAERON_RANGED)
    call AddResearch(r, UPG_LORDAERON_LEATHER)
    call AddResearch(r, UPG_LORDAERON_DEFEND)
    call AddResearch(r, UPG_LORDAERON_LONG_RIFLES)
    call AddResearch(r, UPG_LORDAERON_BACKPACK)
    call AddResearch(r, UPG_LORDAERON_SORCERY)
    call AddResearch(r, UPG_LORDAERON_MAGE)
    call AddResearch(r, UPG_LORDAERON_RAIN_OF_FIRE)
    call AddResearch(r, UPG_LORDAERON_ANIMAL)
    call AddResearch(r, UPG_LORDAERON_CROSSBOWMEN)
    call AddResearch(r, UPG_LORDAERON_HUMAN_COURAGE)
    call AddResearch(r, UPG_LORDAERON_ARCHERY)
    call AddResearch(r, UPG_LORDAERON_ENGINEERING)
    call AddResearch(r, UPG_LORDAERON_SCARLET_CRUSADE)
    call AddResearch(r, UPG_LORDAERON_SPEARMEN)
    call AddResearch(r, UPG_LORDAERON_SCARLET_MONASTERY)

    // units
    call SetRaceWorker(r, LORDAERON_WORKER)
    call SetRaceFootman(r, LORDAERON_FOOTMAN)
    call SetRaceRifleman(r, LORDAERON_ARCHER)
    call SetRaceKnight(r, LORDAERON_KNIGHT)
    call SetRacePriest(r, LORDAERON_MAGE)
    call SetRaceSorceress(r, LORDAERON_SORCERESS)
    call SetRaceSpellBreaker(r, LORDAERON_BATTLE_MAGE)
    call SetRaceSiegeEngine(r, LORDAERON_ALLIANCE_SIEGE_TOWER)
    call SetRaceMortar(r, LORDAERON_RIFLEMAN)
    call SetRaceFlyingMachine(r,  LORDAERON_AIR_SHIP)
    call SetRaceWorkshop4(r, LORDAERON_BANNER_CARRIER)
    call SetRaceTauren(r, LORDAERON_SCARLET_CRUSADE_PALADIN)
    call SetRaceGryphon(r, LORDAERON_GRYPHON_RIDER)
    call SetRaceDragonHawk(r, LORDAERON_PEGASUS_KNIGHT)
    //call SetRaceShade(r, DALARAN_MUTANT)
    call SetRaceCitizenMale(r, LORDAERON_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, LORDAERON_CITIZEN_FEMALE)
    call SetRaceChild(r, LORDAERON_CHILD)
    call SetRacePet(r, LORDAERON_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
endfunction

private function AddStormwind takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceStormwind = r
    call SetRaceTavernItemType(r, ITEM_STORMWIND)
    call SetRaceAiScript(r, "wowr\\Stormwind.ai")
    call SetRaceItemType(r, ITEM_STORMWIND_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, STORMWIND_TIER_1)
    call SetRaceTier1Item(r, ITEM_STORMWIND_TIER_1)
    call SetRaceTier2(r, STORMWIND_TIER_2)
    call SetRaceTier2Item(r, ITEM_STORMWIND_TIER_2)
    call SetRaceTier3(r, STORMWIND_TIER_3)
    call SetRaceTier3Item(r, ITEM_STORMWIND_TIER_3)
    call SetRaceFarm(r, STORMWIND_FARM)
    call SetRaceFarmItem(r, ITEM_STORMWIND_FARM)
    call SetRaceBarracks(r, STORMWIND_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_STORMWIND_BARRACKS)
    call SetRaceBlacksmith(r, STORMWIND_BLACKSMITH)
    call SetRaceBlacksmithItem(r, ITEM_STORMWIND_BLACKSMITH)
    call SetRaceMill(r, STORMWIND_LUMBER_MILL)
    call SetRaceMillItem(r, ITEM_STORMWIND_LUMBER_MILL)
    call SetRaceAltar(r, STORMWIND_ALTAR)
    call SetRaceAltarItem(r, ITEM_STORMWIND_ALTAR)
    call SetRaceArcaneSanctum(r, STORMWIND_MAGE_TOWER)
    call SetRaceArcaneSanctumItem(r, ITEM_STORMWIND_MAGE_TOWER)
    call SetRaceShop(r, STORMWIND_ARCANE_VAULT)
    call SetRaceShopItem(r, ITEM_STORMWIND_ARCANE_VAULT)
    call SetRaceScoutTower(r, STORMWIND_SCOUT_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_STORMWIND_SCOUT_TOWER)
    call SetRaceGuardTower(r, STORMWIND_GUARD_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_STORMWIND_GUARD_TOWER)
    call SetRaceCannonTower(r, STORMWIND_CANNON_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_STORMWIND_CANNON)
    call SetRaceArcaneTower(r, STORMWIND_ARCANE_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_STORMWIND_ARCANE_TOWER)
    call SetRaceWorkshop(r, STORMWIND_WORKSHOP)
    call SetRaceWorkshopItem(r, ITEM_STORMWIND_WORKSHOP)
    call SetRaceAviary(r, STORMWIND_AVIARY)
    call SetRaceAviaryItem(r, ITEM_STORMWIND_AVIARY)
    //call SetRaceSacrificialPit(r, DALARAN_ELEMENTAL_SANCTUARY_1)
    //call SetRaceMine(r, DALARAN_MINE)
    call SetRaceHousing(r, STORMWIND_HOUSING)
    call SetRaceHousingItem(r, ITEM_STORMWIND_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, STORMWIND_CATHEDRAL_OF_LIGHT)
    call SetRaceSpecialBuildingItem(r, ITEM_STORMWIND_CATHEDRAL_OF_LIGHT)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, STORMWIND_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_STORMWIND_SHIPYARD)

    call AddResearch(r, UPG_STORMWIND_LUMBER)
    call AddResearch(r, UPG_STORMWIND_MASONRY)
    call AddResearch(r, UPG_STORMWIND_MELEE)
    call AddResearch(r, UPG_STORMWIND_ARMOR)
    call AddResearch(r, UPG_STORMWIND_RANGED)
    call AddResearch(r, UPG_STORMWIND_LEATHER)
    call AddResearch(r, UPG_STORMWIND_DEFEND)
    call AddResearch(r, UPG_STORMWIND_BOWS)
    call AddResearch(r, UPG_STORMWIND_MARKSMANSHIP)
    call AddResearch(r, UPG_STORMWIND_SUNDERING_BLADES)
    call AddResearch(r, UPG_STORMWIND_BACKPACK)
    call AddResearch(r, UPG_STORMWIND_SORCERY)
    call AddResearch(r, UPG_STORMWIND_MAGE)
    call AddResearch(r, UPG_STORMWIND_PRIEST)
    call AddResearch(r, UPG_STORMWIND_ANIMAL)
    call AddResearch(r, UPG_STORMWIND_UNMOUNT)
    call AddResearch(r, UPG_STORMWIND_MAGIC_SENTRY)
    call AddResearch(r, UPG_STORMWIND_REINFORCED_DEFENSES)
    call AddResearch(r, UPG_STORMWIND_CATHEDRAL_OF_LIGHT)

    // units
    call SetRaceWorker(r, STORMWIND_WORKER)
    call SetRaceFootman(r, STORMWIND_FOOTMAN)
    call SetRaceRifleman(r, STORMWIND_RANGER)
    call SetRaceKnight(r, STORMWIND_KNIGHT)
    call SetRacePriest(r, STORMWIND_PRIEST)
    call SetRaceSorceress(r, STORMWIND_SORCERESS)
    call SetRaceSpellBreaker(r, STORMWIND_MAGE)
    call SetRaceSiegeEngine(r, STORMWIND_ALLIANCE_SIEGE_TOWER)
    call SetRaceMortar(r, STORMWIND_CANNON)
    call SetRaceFlyingMachine(r,  STORMWIND_AIR_SHIP)
    call SetRaceWorkshop4(r, STORMWIND_BANNER_CARRIER)
    call SetRaceTauren(r, STORMWIND_BISHOP)
    call SetRaceGryphon(r, STORMWIND_GRYPHON_RIDER)
    call SetRaceDragonHawk(r, STORMWIND_EAGLE_KNIGHT)
    call SetRaceAviary3(r,  STORMWIND_GRYPHON_KNIGHT)
    call SetRaceAviary4(r, STORMWIND_LION_RIDER)
    //call SetRaceShade(r, DALARAN_MUTANT)
    call SetRaceCitizenMale(r, STORMWIND_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, STORMWIND_CITIZEN_FEMALE)
    call SetRaceChild(r, STORMWIND_CHILD)
    call SetRacePet(r, STORMWIND_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
endfunction

private function AddDalaran takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDalaran = r
    call SetRaceTavernItemType(r, ITEM_DALARAN)
    call SetRaceAiScript(r, "wowr\\Dalaran.ai")
    call SetRaceItemType(r, ITEM_DALARAN_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, DALARAN_TIER_1)
    call SetRaceTier1Item(r, ITEM_DALARAN_TIER_1)
    call SetRaceTier2(r, DALARAN_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HUMAN_TIER_2)
    call SetRaceTier3(r, DALARAN_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HUMAN_TIER_3)
    call SetRaceFarm(r, DALARAN_POWER_GENERATOR)
    //call SetRaceFarmItem(r, ITEM_HUMAN_FARM)
    call SetRaceBarracks(r, DALARAN_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_HUMAN_BARRACKS)
    call SetRaceBlacksmith(r, DALARAN_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_HUMAN_BLACK_SMITH)
    call SetRaceMill(r, DALARAN_BLACKSMITH)
    //call SetRaceMillItem(r, ITEM_HUMAN_MILL)
    call SetRaceAltar(r, DALARAN_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HUMAN_ALTAR)
    call SetRaceArcaneSanctum(r, DALARAN_ARCANE_SANCTUM)
    //call SetRaceArcaneSanctumItem(r, ITEM_HUMAN_ARCANE_SANCTUM)
    call SetRaceShop(r, DALARAN_SHOP)
    //call SetRaceShopItem(r, ITEM_HUMAN_SHOP)
    call SetRaceScoutTower(r, DALARAN_GUARD_TOWER_1)
    //call SetRaceScoutTowerItem(r, ITEM_HUMAN_SCOUT_TOWER)
    call SetRaceGuardTower(r, DALARAN_GUARD_TOWER_2)
    //call SetRaceGuardTowerItem(r, ITEM_HUMAN_GUARD_TOWER)
    call SetRaceCannonTower(r, DALARAN_GUARD_TOWER_2)
    //call SetRaceCannonTowerItem(r, ITEM_HUMAN_CANNON_TOWER)
    call SetRaceArcaneTower(r, DALARAN_GUARD_TOWER_2)
    //call SetRaceArcaneTowerItem(r, ITEM_HUMAN_ARCANE_TOWER)
    call SetRaceWorkshop(r, DALARAN_ZOO)
    //call SetRaceWorkshopItem(r, ITEM_HUMAN_WORKSHOP)
    call SetRaceAviary(r, DALARAN_AVIARY)
    //call SetRaceAviaryItem(r, ITEM_HUMAN_GRYPHON_AVIARY)
    call SetRaceSacrificialPit(r, DALARAN_ELEMENTAL_SANCTUARY_1)
    call SetRaceMine(r, DALARAN_MINE)
    call SetRaceHousing(r, DALARAN_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HUMAN_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, DALARAN_VIOLET_CITADEL)
    //call SetRaceSpecialBuildingItem(r, ITEM_HUMAN_SPECIAL_BUILDING)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, DALARAN_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HUMAN_SHIPYARD)

    call AddResearch(r, UPG_DALARAN_GOLD)
    call AddResearch(r, UPG_DALARAN_MELEE)
    call AddResearch(r, UPG_DALARAN_ARMOR)
    call AddResearch(r, UPG_DALARAN_CR_ATTACK)
    call AddResearch(r, UPG_DALARAN_CR_ARMOR)
    call AddResearch(r, UPG_DALARAN_DEFEND)
    call AddResearch(r, UPG_DALARAN_SORCERESS)
    call AddResearch(r, UPG_DALARAN_WIZARD)
    call AddResearch(r, UPG_DALARAN_FIRE_MAGE)
    call AddResearch(r, UPG_DALARAN_GOLEM)
    call AddResearch(r, UPG_DALARAN_ANIMAL)
    call AddResearch(r, UPG_DALARAN_CLOUD)
    call AddResearch(r, UPG_DALARAN_BACKPACK)
    call AddResearch(r, UPG_DALARAN_MAGIC_SENTRY)
    call AddResearch(r, UPG_DALARAN_BLINK)
    call AddResearch(r, UPG_DALARAN_MANA_SHIELD)
    call AddResearch(r, UPG_DALARAN_SPAWN_FIRE_ELEMENTALS)
    call AddResearch(r, UPG_DALARAN_SHIELD)
    call AddResearch(r, UPG_DALARAN_ELEMENTAL)
    call AddResearch(r, UPG_DALARAN_FEEDBACK)
    call AddResearch(r, UPG_DALARAN_FLYING_CITY)
    call AddResearch(r, UPG_DALARAN_VIOLET_CITADEL)

    // units
    call SetRaceWorker(r, DALARAN_WORKER)
    call SetRaceTownHall3(r, DALARAN_SAND_ELEMENTAL)
    call SetRaceFootman(r, DALARAN_PIKEMAN)
    call SetRaceRifleman(r, DALARAN_APPRENTICE_WIZARD)
    call SetRaceKnight(r, DALARAN_SUPPLY_CART)
    call SetRaceBarracks4(r, DALARAN_REJECT)
    call SetRacePriest(r, DALARAN_WIZARD)
    call SetRaceSorceress(r, DALARAN_SORCERESS)
    call SetRaceSpellBreaker(r, DALARAN_FIRE_MAGE)
    call SetRaceArcaneSanctum4(r, DALARAN_FROST_ELEMENTAL)
    call SetRaceSiegeEngine(r, DALARAN_GUARDIAN_GOLEM)
    call SetRaceMortar(r, DALARAN_FLESH_GOLEM)
    call SetRaceFlyingMachine(r,  DALARAN_FIRE_ELEMENTAL)
    call SetRaceWorkshop4(r, DALARAN_VOID_ELEMENTAL)
    //call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    call SetRaceGryphon(r, DALARAN_AIR_ELEMENTAL)
    call SetRaceDragonHawk(r, DALARAN_DRAGON_HAWK)
    call SetRaceAviary3(r,  DALARAN_LIGHTNING_ELEMENTAL)
    call SetRaceAviary4(r, DALARAN_POISON_ELEMENTAL)
    call SetRaceShade(r, DALARAN_MUTANT)
    call SetRaceCitizenMale(r, DALARAN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DALARAN_CITIZEN_FEMALE)
    call SetRaceChild(r, DALARAN_CHILD)
    call SetRacePet(r, DALARAN_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
    call SetRaceShipSpecial1(r, DALARAN_WATER_ELEMENTAL)
    call SetRaceShipSpecial2(r, DALARAN_SEA_ELEMENTAL)
endfunction

private function AddKulTiras takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceKulTiras = r
    call SetRaceTavernItemType(r, ITEM_KUL_TIRAS)
    call SetRaceAiScript(r, "wowr\\KulTiras.ai")
    call SetRaceItemType(r, ITEM_KUL_TIRAS_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, KULTIRAS_TIER_1)
    call SetRaceTier1Item(r, ITEM_KUL_TIRAS_TIER_1)
    call SetRaceTier2(r, KULTIRAS_TIER_2)
    //call SetRaceTier2Item(r, ITEM_HUMAN_TIER_2)
    call SetRaceTier3(r, KULTIRAS_TIER_3)
    //call SetRaceTier3Item(r, ITEM_HUMAN_TIER_3)
    call SetRaceFarm(r, KULTIRAS_HOUSE)
    //call SetRaceFarmItem(r, ITEM_HUMAN_FARM)
    call SetRaceBarracks(r, KULTIRAS_BARRACKS_1)
    //call SetRaceBarracksItem(r, ITEM_HUMAN_BARRACKS)
    call SetRaceBlacksmith(r, KULTIRAS_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_HUMAN_BLACK_SMITH)
    call SetRaceMill(r, KULTIRAS_LUMBER_MILL)
    //call SetRaceMillItem(r, ITEM_HUMAN_MILL)
    call SetRaceAltar(r, KULTIRAS_ALTAR)
    //call SetRaceAltarItem(r, ITEM_HUMAN_ALTAR)
    call SetRaceArcaneSanctum(r, KULTIRAS_ARCANE_SANCTUM)
    //call SetRaceArcaneSanctumItem(r, ITEM_HUMAN_ARCANE_SANCTUM)
    call SetRaceShop(r, KULTIRAS_SHOP)
    //call SetRaceShopItem(r, ITEM_HUMAN_SHOP)
    call SetRaceScoutTower(r, KULTIRAS_WATCH_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_HUMAN_SCOUT_TOWER)
    call SetRaceGuardTower(r, KULTIRAS_GUARD_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_HUMAN_GUARD_TOWER)
    call SetRaceCannonTower(r, KULTIRAS_CANNON_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_HUMAN_CANNON_TOWER)
    call SetRaceArcaneTower(r, KULTIRAS_ARCANE_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_HUMAN_ARCANE_TOWER)
    call SetRaceWorkshop(r, KULTIRAS_WORKSHOP)
    //call SetRaceWorkshopItem(r, ITEM_HUMAN_WORKSHOP)
    call SetRaceAviary(r, KULTIRAS_AVIARY)
    //call SetRaceAviaryItem(r, ITEM_HUMAN_GRYPHON_AVIARY)
    call SetRaceSacrificialPit(r, KULTIRAS_CRANE)
    //call SetRaceMine(r, DALARAN_MINE)
    call SetRaceHousing(r, KULTIRAS_HOUSING)
    //call SetRaceHousingItem(r, ITEM_HUMAN_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, KULTIRAS_PROUDMOORE_KEEP)
    //call SetRaceSpecialBuildingItem(r, ITEM_HUMAN_SPECIAL_BUILDING)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, KULTIRAS_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_HUMAN_SHIPYARD)
    call SetRaceShipyard2(r, KULTIRAS_SHIPYARD_ADVANCED)

    call AddResearch(r, UPG_KULTIRAS_LUMBER)
    call AddResearch(r, UPG_KULTIRAS_MASONRY)
    call AddResearch(r, UPG_KULTIRAS_MELEE)
    call AddResearch(r, UPG_KULTIRAS_ARMOR)
    call AddResearch(r, UPG_KULTIRAS_RANGED)
    call AddResearch(r, UPG_KULTIRAS_LEATHER)
    call AddResearch(r, UPG_KULTIRAS_DEFEND)
    call AddResearch(r, UPG_KULTIRAS_LONG_RIFLES)
    call AddResearch(r, UPG_KULTIRAS_BACKPACK)
    call AddResearch(r, UPG_KULTIRAS_TRUE_SIGHT)
    call AddResearch(r, UPG_KULTIRAS_SHIP_DOCTOR)
    call AddResearch(r, UPG_KULTIRAS_SORCERER)
    call AddResearch(r, UPG_KULTIRAS_HYDROMANCER)
    call AddResearch(r, UPG_KULTIRAS_CLEAVING_ATTACK)
    call AddResearch(r, UPG_KULTIRAS_SUNDERING_BLADES)
    call AddResearch(r, UPG_KULTIRAS_ANIMAL)
    call AddResearch(r, UPG_KULTIRAS_DEVOUR)
    call AddResearch(r, UPG_KULTIRAS_ENSNARE)
    call AddResearch(r, UPG_KULTIRAS_GHOSTS)
    call AddResearch(r, UPG_KULTIRAS_MAGIC_SENTRY)
    call AddResearch(r, UPG_KULTIRAS_LAND_CANNONS)
    call AddResearch(r, UPG_KULTIRAS_SHIP_CANNONS)
    call AddResearch(r, UPG_KULTIRAS_SHIPYARD_REPAIR)
    call AddResearch(r, UPG_KULTIRAS_TRANSPORTERS)
    call AddResearch(r, UPG_KULTIRAS_FRAGS)
    call AddResearch(r, UPG_KULTIRAS_FLARE)
    call AddResearch(r, UPG_KULTIRAS_PROUDMOORE_KEEP)

    // units
    call SetRaceWorker(r, KULTIRAS_WORKER)
    call SetRaceFootman(r, KULTIRAS_FOOTMAN)
    call SetRaceRifleman(r, KULTIRAS_RIFLEMAN)
    call SetRaceKnight(r, KULTIRAS_KNIGHT)
    call SetRaceBarracks4(r, KULTIRAS_GUARDSMAN)
    call SetRacePriest(r, KULTIRAS_SHIP_DOCTOR)
    call SetRaceSorceress(r, KULTIRAS_STORM_SORCERER)
    call SetRaceSpellBreaker(r, KULTIRAS_HYDROMANCER)
    call SetRaceSiegeEngine(r, KULTIRAS_LAND_SHIP)
    call SetRaceMortar(r, KULTIRAS_CANONEER_TEAM)
    call SetRaceFlyingMachine(r,  KULTIRAS_FLYING_DREADNOUGHT)
    call SetRaceWorkshop4(r, DALARAN_VOID_ELEMENTAL)
    call SetRaceTauren(r, KULTIRAS_ROYAL_GUARD)
    call SetRaceGryphon(r, KULTIRAS_ALBATROSS_RIDER)
    call SetRaceDragonHawk(r, KULTIRAS_PEREGRIN_FALCON)
    call SetRaceShade(r, KULTIRAS_FLIBUSTIER)
    call SetRaceCitizenMale(r, KULTIRAS_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, KULTIRAS_CITIZEN_FEMALE)
    call SetRaceChild(r, KULTIRAS_CHILD)
    call SetRacePet(r, KULTIRAS_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, KULTIRAS_BATTLESHIP)
    call SetRaceShipSpecial1(r, KULTIRAS_DREADNOUGHT)
    call SetRaceShipSpecial2(r, KULTIRAS_PIRATE_BATTLESHIP)
endfunction

private function AddWorgen takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceWorgen = r
    call SetRaceTavernItemType(r, ITEM_WORGEN)
    call SetRaceAiScript(r, "wowr\\Worgen.ai")
    call SetRaceItemType(r, ITEM_WORGEN_SCEPTER)
    call SetRaceTeam(r, TEAM_ALLIANCE)

    // buildings
    call SetRaceTier1(r, WORGEN_TOWN_HALL)
    call SetRaceTier1Item(r, ITEM_WORGEN_TIER_1)
    call SetRaceTier2(r, WORGEN_KEEP)
    call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, WORGEN_CASTLE)
    call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, WORGEN_HOUSE)
    call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, WORGEN_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, WORGEN_BLACKSMITH)
    call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, WORGEN_LUMBER_MILL)
    call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, WORGEN_ALTAR)
    call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, WORGEN_WIZARD_TOWER)
    call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, WORGEN_TRADE_HOUSE)
    call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, WORGEN_SCOUT_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, WORGEN_GUARD_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, WORGEN_CANNON_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, WORGEN_ARCANE_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, WORGEN_WORKSHOP)
    call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, WORGEN_MANOR)
    call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, KOBOLD_TUNNEL)
    call SetRaceHousing(r, WORGEN_HOUSING)
    call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, WORGEN_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, WORGEN_CATHEDRAL)
    call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)
    call SetRaceSpecialBuilding2(r, WORGEN_GREYMANE_WALL)
    call SetRaceSpecialBuilding2Item(r, ITEM_WORGEN_GREYMANE_WALL)

    // researches
    call AddResearch(r, UPG_WORGEN_DRUID)
    call AddResearch(r, UPG_WORGEN_NOCTURNAL)
    call AddResearch(r, UPG_WORGEN_CURSE)
    call AddResearch(r, UPG_WORGEN_BACKPACK)
    call AddResearch(r, UPG_WORGEN_CATHEDRAL)
    call AddResearch(r, UPG_WORGEN_GREYMANE_WALL)
    call AddResearch(r, UPG_WORGEN_ANIMAL_WAR_TRAINING)
    call AddResearch(r, UPG_WORGEN_BARRAGE)
    call AddResearch(r, UPG_WORGEN_CARGO)
    call AddResearch(r, UPG_WORGEN_DEFEND)
    call AddResearch(r, UPG_WORGEN_NIGHTSTALKER)
    call AddResearch(r, UPG_WORGEN_RAIN_OF_FIRE)
    call AddResearch(r, UPG_WORGEN_ROCKETS)
    call AddResearch(r, UPG_WORGEN_SLOW_POISON)
    call AddResearch(r, UPG_WORGEN_WORGEN_CLAWS)
    call AddResearch(r, UPG_WORGEN_ARMOR)
    call AddResearch(r, UPG_WORGEN_RANGE)
    call AddResearch(r, UPG_WORGEN_HUMAN_COURAGE)
    call AddResearch(r, UPG_WORGEN_IMPROVED_CRITICAL_STRIKE)
    call AddResearch(r, UPG_WORGEN_IMPROVED_WALL)
    call AddResearch(r, UPG_WORGEN_LONG_RIFLES)
    call AddResearch(r, UPG_WORGEN_MAGIC_SENTRY)

    // units
    call SetRaceWorker(r, WORGEN_PEASANT)
    call SetRaceFootman(r, WORGEN_FOOTMAN)
    call SetRaceRifleman(r, WORGEN_RIFLEMAN)
    call SetRaceKnight(r, WORGEN_KNIGHT)
    call SetRacePriest(r, WORGEN_DRUID)
    call SetRaceSorceress(r, WORGEN_NIGHTSTALKER)
    call SetRaceSpellBreaker(r, WORGEN_BATTLE_MAGE)
    call SetRaceSiegeEngine(r, WORGEN_MANTICORE)
    call SetRaceMortar(r, WORGEN_BANNER_CARRIER)
    call SetRaceTauren(r, WORGEN_MINDLESS_WORGEN)
    call SetRaceGryphon(r, WORGEN_STORMCROW_KNIGHT)
    call SetRaceDragonHawk(r, WORGEN_GILNEAS_GUNSHIP)
    call SetRaceCitizenMale(r, WORGEN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, WORGEN_CITIZEN_FEMALE)
    call SetRaceChild(r, WORGEN_CHILD)
    call SetRacePet(r, WORGEN_PET)
    call SetRaceTransportShip(r, WORGEN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, WORGEN_FRIGATE)
    call SetRaceBattleship(r, WORGEN_BATTLESHIP)
endfunction

private function AddVrykul takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceVrykul = r
    call SetRaceTavernItemType(r, ITEM_VRYKUL)
    call SetRaceAiScript(r, "wowr\\Vrykul.ai")
    call SetRaceItemType(r, ITEM_VRYKUL_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, VRYKUL_TIER_1)
    call SetRaceTier1Item(r, ITEM_VRYKUL_TIER_1)
    call SetRaceTier2(r, VRYKUL_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, VRYKUL_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, VRYKUL_FISHER_HOUSE)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, VRYKUL_LONGHOUSE)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, VRYKUL_BLACKSMITH)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, VRYKUL_BLACKSMITH)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, VRYKUL_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, VRYKUL_VALKYR_TEMPLE)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, VRYKUL_INN)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, VRYKUL_LAMP)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, VRYKUL_LAMP)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, VRYKUL_LAMP)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, VRYKUL_LAMP)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, VRYKUL_BEASTIARY)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, VRYKUL_PROTO_DRAKE_ROOST)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, KOBOLD_TUNNEL)
    call SetRaceHousing(r, VRYKUL_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, VRYKUL_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, VRYKUL_HALL_OF_VALOR)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_VRYKUL_BACKPACK)
    call AddResearch(r, UPG_VRYKUL_DEFEND)
    call AddResearch(r, UPG_VRYKUL_DEVOUR)
    call AddResearch(r, UPG_VRYKUL_SPIKED_SHELL)
    call AddResearch(r, UPG_VRYKUL_VALKYR_DARK)
    call AddResearch(r, UPG_VRYKUL_VALKYR_GOLDEN)
    call AddResearch(r, UPG_VRYKUL_RUNECARVER)
    call AddResearch(r, UPG_VRYKUL_LUMBER)
    call AddResearch(r, UPG_VRYKUL_HALLS_OF_VALOR)
    call AddResearch(r, UPG_VRYKUL_CREATURE_ATTACK)
    call AddResearch(r, UPG_VRYKUL_CREATURE_SKIN)
    call AddResearch(r, UPG_VRYKUL_IRON_SWORDS)
    call AddResearch(r, UPG_VRYKUL_IRON_PLATING)
    call AddResearch(r, UPG_VRYKUL_RESISTANT_SKIN)
    call AddResearch(r, UPG_VRYKUL_GIANTS)
    call AddResearch(r, UPG_VRYKUL_ULTRAVISION)

    // units
    call SetRaceWorker(r, VRYKUL_WORKER)
    call SetRaceFootman(r, VRYKUL_WARRIOR)
    call SetRaceRifleman(r, VRYKUL_SPEAR_CARRIER)
    call SetRaceKnight(r, VRYKUL_MAMMOTH_RIDER)
    call SetRacePriest(r, VRYKUL_VALKYR_GOLDEN)
    call SetRaceSorceress(r, VRYKUL_VALKYR_DARK)
    call SetRaceSpellBreaker(r, VRYKUL_UNDEAD_VRYKUL)
    call SetRaceSiegeEngine(r, VRYKUL_MAMMOTH)
    call SetRaceMortar(r, VRYKUL_ARMORED_WOLF)
    call SetRaceTauren(r, VRYKUL_GIANT_POLAR_BEAR)
    call SetRaceGryphon(r, VRYKUL_PROTO_DRAKE)
    call SetRaceDragonHawk(r, VRYKUL_PROTO_DRAKE)
    call SetRaceFlyingMachine(r, VRYKUL_PROTO_DRAKE)
    call SetRaceCitizenMale(r, VRYKUL_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, VRYKUL_CITIZEN_FEMALE)
    call SetRaceChild(r, VRYKUL_CHILD)
    call SetRacePet(r, VRYKUL_PET)
    call SetRaceTransportShip(r, HUMAN_TRANSPORT_SHIP)
    call SetRaceFrigate(r, HUMAN_FRIGATE)
    call SetRaceBattleship(r, HUMAN_BATTLESHIP)
    call SetRaceShipSpecial1(r, VRYKUL_RAKKAR_SHIP)
endfunction

private function AddNerubian takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceNerubian = r
    call SetRaceTavernItemType(r, ITEM_NERUBIAN)
    call SetRaceAiScript(r, "wowr\\Nerubian.ai")
    call SetRaceItemType(r, ITEM_NERUBIAN_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, NERUBIAN_TIER_1)
    call SetRaceTier1Item(r, ITEM_NERUBIAN_TIER_1)
    call SetRaceTier2(r, NERUBIAN_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, NERUBIAN_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, NERUBIAN_ZIGGURAT)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, NERUBIAN_SPAWNING_PIT)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, NERUBIAN_HATCHERY)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, NERUBIAN_HATCHERY)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, NERUBIAN_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, NERUBIAN_ANCIENT_SHRINE)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, NERUBIAN_VAULT_OF_RELICS)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, NERUBIAN_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, NERUBIAN_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, NERUBIAN_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, NERUBIAN_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, NERUBIAN_NEST)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, NERUBIAN_SPAWNING_GROUND)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    call SetRaceSacrificialPit(r, NERUBIAN_TUNNEL)
    call SetRaceHousing(r, NERUBIAN_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, NERUBIAN_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, NERUBIAN_AZJOL_NERUB)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_NERUBIAN_ANCIENT_POWER)
    call AddResearch(r, UPG_NERUBIAN_AZJOL_NERUB)
    call AddResearch(r, UPG_NERUBIAN_BACKPACK)
    call AddResearch(r, UPG_NERUBIAN_COCOON)
    call AddResearch(r, UPG_NERUBIAN_CORROSIVE_BREATH)
    call AddResearch(r, UPG_NERUBIAN_IMPROVED_ANCIENT_ARCHITECTURE)
    call AddResearch(r, UPG_NERUBIAN_ARMOR)
    call AddResearch(r, UPG_NERUBIAN_WEAPONS)
    call AddResearch(r, UPG_NERUBIAN_WINGS)
    call AddResearch(r, UPG_NERUBIAN_SEER)
    call AddResearch(r, UPG_NERUBIAN_WEBSPINNER)
    call AddResearch(r, UPG_NERUBIAN_SPAWN_SPIDERLINGS)
    call AddResearch(r, UPG_NERUBIAN_SPIDER_EGG)
    call AddResearch(r, UPG_NERUBIAN_SPIDER_POISON)
    call AddResearch(r, UPG_NERUBIAN_WEB)

    // units
    call SetRaceWorker(r, NERUBIAN_WORKER)
    call SetRaceFootman(r, NERUBIAN_WARRIOR)
    call SetRaceRifleman(r, NERUBIAN_SPEAR_THROWER)
    call SetRaceKnight(r, NERUBIAN_SPIDER_LORD)
    call SetRacePriest(r, NERUBIAN_SEER)
    call SetRaceSorceress(r, NERUBIAN_WEBSPINNER)
    call SetRaceSpellBreaker(r, NERUBIAN_WEBSPINNER)
    call SetRaceSiegeEngine(r, NERUBIAN_CRYPT_FIEND)
    call SetRaceMortar(r, NERUBIAN_CRYPT_FIEND)
    call SetRaceTauren(r, NERUBIAN_QUEEN)
    call SetRaceGryphon(r, NERUBIAN_CRYPT_DRONE)
    call SetRaceDragonHawk(r, NERUBIAN_FLYING_BOMBARDER)
    call SetRaceFlyingMachine(r, NERUBIAN_FLYING_BOMBARDER)
    call SetRaceCitizenMale(r, NERUBIAN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, NERUBIAN_CITIZEN_FEMALE)
    call SetRaceChild(r, NERUBIAN_CHILD)
    call SetRacePet(r, NERUBIAN_PET)
    call SetRaceTransportShip(r, UNDEAD_TRANSPORT_SHIP)
    call SetRaceFrigate(r, UNDEAD_FRIGATE)
    call SetRaceBattleship(r, UNDEAD_BATTLESHIP)
endfunction

private function AddTuskarr takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceTuskarr = r
    call SetRaceTavernItemType(r, ITEM_TUSKARR)
    call SetRaceAiScript(r, "wowr\\Tuskarr.ai")
    call SetRaceItemType(r, ITEM_TUSKARR_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, TUSKARR_FROZEN_HALL)
    call SetRaceTier1Item(r, ITEM_TUSKARR_TIER_1)
    call SetRaceTier2(r, TUSKARR_FROZEN_STRONGHOLD)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, TUSKARR_FROZEN_FORTRESS)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, TUSKARR_IGLOO)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, TUSKARR_IGLOO_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, TUSKARR_ICY_SPIRE)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, TUSKARR_ICY_SPIRE)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, TUSKARR_ALTAR_OF_ICE)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, TUSKARR_ICE_CUTTERS_LODGE)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, TUSKARR_NORTHERN_VENDOR_SHOP)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, TUSKARR_BLOCK_OF_ICE)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, TUSKARR_SPIDER_SHRINE)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, TUSKARR_ICE_WALL)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, TUSKARR_FROST_SNOWMAN)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, TUSKARR_HUNTERS_REST)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, TUSKARR_DECORATED_CAVERN)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, NERUBIAN_TUNNEL)
    call SetRaceHousing(r, TUSKARR_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, TUSKARR_TUSKARR_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, TUSKARR_BURIAL_PLACE)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_TUSKARR_BACKPACK)
    call AddResearch(r, UPG_TUSKARR_BEAST_PROTECTION)
    call AddResearch(r, UPG_TUSKARR_CLANS)
    call AddResearch(r, UPG_TUSKARR_CLEAVING_ATTACK)
    call AddResearch(r, UPG_TUSKARR_CRITICAL_STRIKE)
    call AddResearch(r, UPG_TUSKARR_DEVOUR)
    call AddResearch(r, UPG_TUSKARR_ELITE_ARMORED_POLAR_BEAR)
    call AddResearch(r, UPG_TUSKARR_ENSNARE)
    call AddResearch(r, UPG_TUSKARR_ETHERAL_BEASTS)
    call AddResearch(r, UPG_TUSKARR_FROST_IMMUNITY)
    call AddResearch(r, UPG_NERUBIAN_WEBSPINNER)
    call AddResearch(r, UPG_TUSKARR_IMPROVED_FISHING)
    call AddResearch(r, UPG_TUSKARR_MAGIC_SENTRY)
    call AddResearch(r, UPG_TUSKARR_SHAMAN_ADEPT_TRAINING)
    call AddResearch(r, UPG_TUSKARR_TUSKARR_ARMOR)
    call AddResearch(r, UPG_TUSKARR_HARPOONS)
    call AddResearch(r, UPG_TUSKARR_HEALER_ADEPT_TRAINING)
    call AddResearch(r, UPG_TUSKARR_TUSKARR_WEAPONS)
    call AddResearch(r, UPG_TUSKARR_WAR_STOMP)
    call AddResearch(r, UPG_TUSKARR_BURIAL_PLACE)

    // units
    call SetRaceWorker(r, TUSKARR_WORKER)
    call SetRaceFootman(r, TUSKARR_FIGHTER)
    call SetRaceRifleman(r, TUSKARR_SPEARMAN)
    call SetRaceKnight(r, TUSKARR_MAMMOTH_RIDER)
    call SetRacePriest(r, TUSKARR_HEALER)
    call SetRaceSorceress(r, TUSKARR_SHAMAN)
    call SetRaceSpellBreaker(r, TUSKARR_SHAMAN)
    call SetRaceSiegeEngine(r, TUSKARR_POLAR_BEAR)
    call SetRaceMortar(r, TUSKARR_ICETUSK_MAMMOTH)
    call SetRaceTauren(r, TUSKARR_CHIEFTAIN)
    call SetRaceGryphon(r, TUSKARR_GIANT_SNOWY_OWL)
    call SetRaceDragonHawk(r, TUSKARR_GIANT_SNOWY_OWL)
    call SetRaceFlyingMachine(r, TUSKARR_GIANT_FROST_WOLF)
    call SetRaceCitizenMale(r, TUSKARR_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, TUSKARR_CITIZEN_FEMALE)
    call SetRaceChild(r, TUSKARR_CHILD)
    call SetRacePet(r, TUSKARR_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddMurloc takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceMurloc = r
    call SetRaceTavernItemType(r, ITEM_MURLOC)
    call SetRaceAiScript(r, "wowr\\Murloc.ai")
    call SetRaceItemType(r, ITEM_MURLOC_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, MURLOC_TIER_1)
    call SetRaceTier1Item(r, ITEM_MURLOC_TIER_1)
    call SetRaceTier2(r, MURLOC_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, MURLOC_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, MURLOC_HUT)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, MURLOC_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, MURLOC_BLADEMAKING_HUT)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, MURLOC_LUMBER_KEEP)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, MURLOC_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, MURLOC_SORCERER_DEN)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, MURLOC_SHOP)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, MURLOC_BONE_CHIPPER)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, MURLOC_BONE_CHIPPER)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, MURLOC_BONE_CHIPPER)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, MURLOC_BONE_CHIPPER)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, MURLOC_HATCHLING_GROUNDS)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    //call SetRaceAviary(r, TUSKARR_DECORATED_CAVERN)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, NERUBIAN_TUNNEL)
    call SetRaceHousing(r, MURLOC_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, MURLIC_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, MURLOC_FISHER)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_MURLOC_BACKPACK)
    call AddResearch(r, UPG_MURLOC_DAMAGE)
    call AddResearch(r, UPG_MURLOC_ARMOR)
    call AddResearch(r, UPG_MURLOC_BUBBLE_MAGE)
    call AddResearch(r, UPG_MURLOC_SHADOW_CASTER)
    call AddResearch(r, UPG_MURLOC_CULTIST)
    call AddResearch(r, UPG_MURLOC_RIVER_BANK)
    call AddResearch(r, UPG_MURLOC_EGGS)
    call AddResearch(r, UPG_MURLOC_SWARMING)
    call AddResearch(r, UPG_MURLOC_PULVERIZE)
    call AddResearch(r, UPG_MURLOC_SIEGE_DRAGON_TURTLE)
    call AddResearch(r, UPG_MURLOC_FISHER)

    // units
    call SetRaceWorker(r, MURLOC_WORKER)
    call SetRaceFootman(r, MURLOC_TIDESRUNNER)
    call SetRaceRifleman(r, MURLOC_HUNTER)
    call SetRaceKnight(r, MURLOC_FLESH_EATER)
    call SetRacePriest(r, MURLOC_SHADOWCASTER)
    call SetRaceSorceress(r, MURLOC_BUBBLE_MAGE)
    call SetRaceSpellBreaker(r, MURLOC_CULTIST)
    call SetRaceSiegeEngine(r, MURLOC_DRAGON_TURTLE)
    call SetRaceMortar(r, MURLOC_SNAP_DRAGON)
    call SetRaceTauren(r, MURLOC_SEA_GIANT)
    call SetRaceGryphon(r, MURLOC_COUATL)
    call SetRaceDragonHawk(r, MURLOC_COUATL)
    call SetRaceFlyingMachine(r, MURLOC_COUATL)
    call SetRaceCitizenMale(r, MURLOC_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, MURLOC_CITIZEN_FEMALE)
    call SetRaceChild(r, MURLOC_CHILD)
    call SetRacePet(r, MURLOC_PET)
    call SetRaceTransportShip(r, ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ELF_FRIGATE)
    call SetRaceBattleship(r, ELF_BATTLESHIP)
endfunction

private function AddOgre takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceOgre = r
    call SetRaceTavernItemType(r, ITEM_OGRE)
    call SetRaceAiScript(r, "wowr\\Ogre.ai")
    call SetRaceItemType(r, ITEM_OGRE_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, OGRE_TIER_1)
    call SetRaceTier1Item(r, ITEM_OGRE_TIER_1)
    call SetRaceTier2(r, OGRE_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, OGRE_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, OGRE_TENT)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, OGRE_CAVE)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, OGRE_FORGE)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, OGRE_FORGE)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, OGRE_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, OGRE_MAGI_LODGE)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, OGRE_DRAENOR_MERCHANT)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, OGRE_BOULDER_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, OGRE_ADVANCED_BOULDER_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, OGRE_ADVANCED_BOULDER_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, OGRE_ADVANCED_BOULDER_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, OGRE_BEASTIARY)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, OGRE_ARENA)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, NERUBIAN_TUNNEL)
    call SetRaceHousing(r, OGRE_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, OGRE_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, OGRE_STONEMAUL_CAMP)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_OGRE_AMBUSH)
    call AddResearch(r, UPG_OGRE_BACKPACK)
    call AddResearch(r, UPG_OGRE_BREATH_OF_FIRE)
    call AddResearch(r, UPG_OGRE_DEMOLISH)
    call AddResearch(r, UPG_OGRE_ENSNARE)
    call AddResearch(r, UPG_OGRE_LIGHTNING_ATTACK)
    call AddResearch(r, UPG_OGRE_NECROMANCER)
    call AddResearch(r, UPG_OGRE_ARMOR)
    call AddResearch(r, UPG_OGRE_MELEE)
    call AddResearch(r, UPG_OGRE_MAGI)
    call AddResearch(r, UPG_OGRE_RANGED)
    call AddResearch(r, UPG_OGRE_STRENGTH)
    call AddResearch(r, UPG_OGRE_WARLOCK)
    call AddResearch(r, UPG_OGRE_PULVERIZE)
    call AddResearch(r, UPG_OGRE_REINCARNATION)
    call AddResearch(r, UPG_OGRE_RESISTANT_SKIN)
    call AddResearch(r, UPG_OGRE_ROAR)
    call AddResearch(r, UPG_OGRE_SUMMON_BEAR)
    call AddResearch(r, UPG_OGRE_TAUNT)
    call AddResearch(r, UPG_OGRE_WAR_STOMP)
    call AddResearch(r, UPG_OGRE_STONEMAUL_CAMP)
    call AddResearch(r, UPG_OGRE_GRONN_CLUBS)

    // units
    call SetRaceWorker(r, OGRE_OGRE_SLAVE)
    call SetRaceFootman(r, OGRE_OGRE_WARRIOR)
    call SetRaceRifleman(r, OGRE_OGRE_HUNTER)
    call SetRaceKnight(r, OGRE_OGRE_LORD)
    call SetRaceBarracks4(r, OGRE_KORGALL)
    call SetRacePriest(r, OGRE_OGRE_WARLOCK)
    call SetRaceSorceress(r, OGRE_OGRE_MAGI)
    call SetRaceSpellBreaker(r, OGRE_OGRE_NECROMANCER)
    call SetRaceSiegeEngine(r, OGRE_CLEFTHOOF)
    call SetRaceMortar(r, OGRE_OGRE_STONE_THROWER)
    call SetRaceTauren(r, OGRE_GRONN)
    call SetRaceGryphon(r, OGRE_DRAKE)
    call SetRaceDragonHawk(r, OGRE_MOKNATHAL)
    call SetRaceFlyingMachine(r, OGRE_ZEPPELIN)
    call SetRaceAviary3(r, OGRE_STONEMAUL_OGRE)
    call SetRaceAviary4(r, OGRE_STONEMAUL_MAGI)
    call SetRaceShade(r, OGRE_OGRE_FIRE_BREATHER)
    call SetRaceCitizenMale(r, OGRE_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, OGRE_CITIZEN_FEMALE)
    call SetRaceChild(r, OGRE_CHILD)
    call SetRacePet(r, OGRE_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddFelOrc takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceFelOrc = r
    call SetRaceTavernItemType(r, ITEM_FEL_ORC)
    call SetRaceAiScript(r, "wowr\\FelOrc.ai")
    call SetRaceItemType(r, ITEM_FEL_ORC_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, FEL_ORC_TIER_1)
    call SetRaceTier1Item(r, ITEM_FEL_ORC_TIER_1)
    call SetRaceTier2(r, FEL_ORC_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, FEL_ORC_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, FEL_ORC_PIG_FARM)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, FEL_ORC_BARRACKS)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, FEL_ORC_WAR_MILL)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, FEL_ORC_WAR_MILL)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, FEL_ORC_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, FEL_ORC_WARLOCK_TEMPLE)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, FEL_ORC_SHOP)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, FEL_ORC_WATCH_TOWER)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, FEL_ORC_WATCH_TOWER)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, FEL_ORC_WATCH_TOWER)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, FEL_ORC_WATCH_TOWER)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, FEL_ORC_BEASTIARY)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, FEL_ORC_RED_DRAGON_ROOST)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    call SetRaceSacrificialPit(r, FEL_ORC_DEMON_GATE)
    call SetRaceHousing(r, FEL_ORC_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, FEL_ORC_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, FEL_ORC_HELLFIRE_CITADEL)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_FEL_ORC_BACKPACK)
    call AddResearch(r, UPG_FEL_ORC_BURNING_OIL)
    call AddResearch(r, UPG_FEL_ORC_DEMON_POWER)
    call AddResearch(r, UPG_FEL_ORC_ELDER)
    call AddResearch(r, UPG_FEL_ORC_WARLOCK)
    call AddResearch(r, UPG_FEL_ORC_CULTIST)
    call AddResearch(r, UPG_FEL_ORC_ENSNARE)
    call AddResearch(r, UPG_FEL_ORC_FEL)
    call AddResearch(r, UPG_FEL_ORC_HELLFIRE_CITADEL)
    call AddResearch(r, UPG_FEL_ORC_IMPROVED_CROSSBOWS)
    call AddResearch(r, UPG_FEL_ORC_MARKSMANSHIP)
    call AddResearch(r, UPG_FEL_ORC_ARMOR)
    call AddResearch(r, UPG_FEL_ORC_MELEE)
    call AddResearch(r, UPG_FEL_ORC_RANGED)
    call AddResearch(r, UPG_FEL_ORC_WAR_DRUMS)
    call AddResearch(r, UPG_FEL_ORC_PIGGERY)

    // units
    call SetRaceWorker(r, FEL_ORC_PEON)
    call SetRaceFootman(r, FEL_ORC_GRUNT)
    call SetRaceRifleman(r, FEL_ORC_CROSSBOWMAN)
    call SetRaceKnight(r, FEL_ORC_RAIDER)
    call SetRacePriest(r, FEL_ORC_ELDER)
    call SetRaceSorceress(r, FEL_ORC_WARLOCK)
    call SetRaceSpellBreaker(r, FEL_ORC_CULTIST)
    call SetRaceSiegeEngine(r, FEL_ORC_KODO_BEAST)
    call SetRaceMortar(r, FEL_ORC_WAR_MACHINE)
    call SetRaceGryphon(r, FEL_ORC_RED_DRAGON)
    call SetRaceDragonHawk(r, FEL_ORC_LANCER)
    call SetRaceFlyingMachine(r, FEL_ORC_LANCER)
    call SetRaceCitizenMale(r, FEL_ORC_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, FEL_ORC_CITIZEN_FEMALE)
    call SetRaceChild(r, FEL_ORC_CHILD)
    call SetRacePet(r, FEL_ORC_PET)
    call SetRaceTransportShip(r, ORC_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ORC_FRIGATE)
    call SetRaceBattleship(r, ORC_JUGGERNAUGHT)
endfunction

private function AddFacelessOne takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceFacelessOne = r
    call SetRaceTavernItemType(r, ITEM_FACELESS_ONE)
    call SetRaceAiScript(r, "wowr\\FacelessOne.ai")
    call SetRaceItemType(r, ITEM_FACELESS_ONE_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, FACELESS_ONE_TIER_1)
    call SetRaceTier1Item(r, ITEM_FACELESS_ONE_TIER_1)
    call SetRaceTier2(r, FACELESS_ONE_TIER_2)
    //call SetRaceTier2Item(r, ITEM_WORGEN_TIER_2)
    call SetRaceTier3(r, FACELESS_ONE_TIER_3)
    //call SetRaceTier3Item(r, ITEM_WORGEN_TIER_3)
    call SetRaceFarm(r, FACELESS_ONE_TENTACLE)
    //call SetRaceFarmItem(r, ITEM_WORGEN_HOUSE)
    call SetRaceBarracks(r, FACELESS_ONE_COLONY)
    //call SetRaceBarracksItem(r, ITEM_WORGEN_BARRACKS)
    call SetRaceBlacksmith(r, FACELESS_ONE_PRISON)
    //call SetRaceBlacksmithItem(r, ITEM_WORGEN_BLACKSMITH)
    call SetRaceMill(r, FACELESS_ONE_PRISON)
    //call SetRaceMillItem(r, ITEM_WORGEN_LUMBER_MILL)
    call SetRaceAltar(r, FACELESS_ONE_ALTAR)
    //call SetRaceAltarItem(r, ITEM_WORGEN_ALTAR)
    call SetRaceArcaneSanctum(r, FACELESS_ONE_LIBRARY)
    //call SetRaceArcaneSanctumItem(r, ITEM_WORGEN_WIZARD_TOWER)
    call SetRaceShop(r, FACELESS_ONE_SHOP)
    //call SetRaceShopItem(r, ITEM_WORGEN_SHOP)
    call SetRaceScoutTower(r, FACELESS_ONE_TENTACLE_PIT)
    //call SetRaceScoutTowerItem(r, ITEM_WORGEN_SCOUT_TOWER)
    call SetRaceGuardTower(r, FACELESS_ONE_TENTACLE_PIT)
    //call SetRaceGuardTowerItem(r, ITEM_WORGEN_GUARD_TOWER)
    call SetRaceCannonTower(r, FACELESS_ONE_TENTACLE_PIT)
    //call SetRaceCannonTowerItem(r, ITEM_WORGEN_CANNON_TOWER)
    call SetRaceArcaneTower(r, FACELESS_ONE_TENTACLE_PIT)
    //call SetRaceArcaneTowerItem(r, ITEM_WORGEN_ARCANE_TOWER)
    call SetRaceWorkshop(r, FACELESS_ONE_POOL)
    //call SetRaceWorkshopItem(r, ITEM_WORGEN_WORKSHOP)
    call SetRaceAviary(r, FACELESS_ONE_CAVERN)
    //call SetRaceAviaryItem(r, ITEM_WORGEN_MANOR)
    //call SetRaceSacrificialPit(r, NERUBIAN_TUNNEL)
    call SetRaceHousing(r, FACELESS_ONE_HOUSING)
    //call SetRaceHousingItem(r, ITEM_WORGEN_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, FACELESS_ONE_SHIPYARD)
    //call SetRaceShipyardItem(r, ITEM_WORGEN_SHIPYARD)
    call SetRaceSpecialBuilding(r, FACELESS_ONE_FORGOTTEN_ONE)
    //call SetRaceSpecialBuildingItem(r, ITEM_WORGEN_CATHEDRAL)

    // researches
    call AddResearch(r, UPG_FACELESS_ONE_BACKPACK)
    call AddResearch(r, UPG_FACELESS_ONE_DAMAGE)
    call AddResearch(r, UPG_FACELESS_ONE_ARMOR)
    call AddResearch(r, UPG_FACELESS_ONE_CULTIST)
    call AddResearch(r, UPG_FACELESS_ONE_FORGOTTEN_ONE)
    call AddResearch(r, UPG_FACELESS_ONE_TENTACLE)
    call AddResearch(r, UPG_FACELESS_ONE_WITCH)
    
    // units
    call SetRaceWorker(r, FACELESS_ONE_WORKER)
    call SetRaceFootman(r, FACELESS_ONE_UNBROCKEN_DARKHUNTER)
    call SetRaceRifleman(r, FACELESS_ONE_BONE_THROWER)
    call SetRaceKnight(r, FACELESS_ONE_RIDER)
    call SetRacePriest(r, FACELESS_ONE_WITCH)
    call SetRaceSorceress(r, FACELESS_ONE_CULTIST)
    call SetRaceSpellBreaker(r, FACELESS_ONE_WITCH)
    call SetRaceSiegeEngine(r, FACELESS_ONE_BALLISTA)
    call SetRaceMortar(r, FACELESS_ONE_AQIR)
    call SetRaceTauren(r, FACELESS_ONE_KING)
    call SetRaceGryphon(r, FACELESS_ONE_NIGHTMARE_WEAVER)
    call SetRaceDragonHawk(r, FACELESS_ONE_TRICKSTER)
    call SetRaceFlyingMachine(r, FACELESS_ONE_BERSERKER)
    call SetRaceCitizenMale(r, FACELESS_ONE_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, FACELESS_ONE_CITIZEN_FEMALE)
    call SetRaceChild(r, FACELESS_ONE_CHILD)
    call SetRacePet(r, FACELESS_ONE_PET)
    call SetRaceTransportShip(r, UNDEAD_TRANSPORT_SHIP)
    call SetRaceFrigate(r, UNDEAD_FRIGATE)
    call SetRaceBattleship(r, UNDEAD_BATTLESHIP)
endfunction

private function AddSatyr takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceSatyr = r
    call SetRaceTavernItemType(r, ITEM_SATYR)
    call SetRaceAiScript(r, "wowr\\Satyr.ai")
    call SetRaceItemType(r, ITEM_SATYR_SCEPTER)
    call SetRaceTeam(r, TEAM_HORDE)

    // buildings
    call SetRaceTier1(r, SATYR_TIER_1)
    call SetRaceTier1Item(r, ITEM_SATYR_TIER_1)
    call SetRaceTier2(r, SATYR_TIER_2)
    call SetRaceTier3(r, SATYR_TIER_3)
    call SetRaceFarm(r, SATYR_MOON_WELL)
    call SetRaceBarracks(r, SATYR_ANCIENT_OF_WAR)
    call SetRaceBlacksmith(r, SATYR_HUNTERS_HALL)
    call SetRaceMill(r, SATYR_HUNTERS_HALL)
    call SetRaceAltar(r, SATYR_ALTAR)
    call SetRaceArcaneSanctum(r, SATYR_ANCIENT_OF_LORE)
    call SetRaceShop(r, SATYR_ANCIENT_OF_WONDERS)
    call SetRaceScoutTower(r, SATYR_ANCIENT_PROTECTOR)
    call SetRaceGuardTower(r, SATYR_ANCIENT_PROTECTOR)
    call SetRaceCannonTower(r, SATYR_ANCIENT_PROTECTOR)
    call SetRaceArcaneTower(r, SATYR_ANCIENT_PROTECTOR)
    call SetRaceWorkshop(r, SATYR_ANCIENT_OF_WIND)
    call SetRaceAviary(r, SATYR_DEMON_GATE)
    call SetRaceSacrificialPit(r, SATYR_DEFILED_FOUNTAIN_OF_LIFE)
    call SetRaceHousing(r, SATYR_HOUSING)
    call SetRaceMine(r, SATYR_MINE)
    call SetRaceShipyard(r, ELF_SHIPYARD)
    call SetRaceSpecialBuilding(r, SATYR_SKULL_OF_GULDAN)

    // researches
    call AddResearch(r, UPG_SATYR_BACKPACK)
    call AddResearch(r, UPG_SATYR_STR_MOON)
    call AddResearch(r, UPG_SATYR_MOON_ARMOR)
    call AddResearch(r, UPG_SATYR_STR_WILD)
    call AddResearch(r, UPG_SATYR_HIDES)
    call AddResearch(r, UPG_SATYR_SLUDGE_FLINGER)
    call AddResearch(r, UPG_SATYR_CORRUPTED_ANCIENT_PROTECTORS)
    call AddResearch(r, UPG_SATYR_MANA_BURN)
    call AddResearch(r, UPG_SATRY_BLESSING)
    call AddResearch(r, UPG_SATYR_SKULL_OF_GULDAN)

    // units
    call SetRaceWorker(r, SATYR_WORKER)
    call SetRaceFootman(r, SATYR_SATYR)
    call SetRaceRifleman(r, SATYR_TRICKSTER)
    call SetRaceKnight(r, SATYR_GIANT_SKELETON_WARRIOR)
    call SetRacePriest(r, SATYR_SLUDGE_FLINGER)
    call SetRaceSorceress(r, SATYR_GHOST)
    call SetRaceSpellBreaker(r, SATYR_SATYR_SHADOWDANCER)
    call SetRaceSiegeEngine(r, SATYR_FEL_STALKER)
    call SetRaceMortar(r, SATYR_CORRUPTED_TREANT)
    call SetRaceTauren(r, SATYR_SATYR_HELLCALLER)
    call SetRaceGryphon(r, SATYR_GREEN_DRAKE)
    call SetRaceDragonHawk(r, SATYR_INFERNAL)
    call SetRaceFlyingMachine(r, SATYR_DOOMG_GUARD)

    call SetRaceCitizenMale(r, SATYR_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, SATYR_CITIZEN_FEMALE)
    call SetRaceChild(r, SATYR_CHILD)
    call SetRacePet(r, SATYR_PET)
    call SetRaceTransportShip(r, ELF_TRANSPORT_SHIP)
    call SetRaceFrigate(r, ELF_FRIGATE)
    call SetRaceBattleship(r, ELF_BATTLESHIP)
endfunction

private function AddCentaur takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceCentaur = r
    call SetRaceTavernItemType(r, ITEM_CENTAUR)
    call SetRaceAiScript(r, "wowr\\Centaur.ai")
    call SetRaceItemType(r, ITEM_CENTAUR_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, CENTAUR_TIER_1)
    call SetRaceTier1Item(r, ITEM_CENTAUR_TIER_1)
    call SetRaceTier2(r, CENTAUR_TIER_2)
    call SetRaceTier3(r, CENTAUR_TIER_3)
    call SetRaceFarm(r, CENTAUR_TENT)
    call SetRaceBarracks(r, CENTAUR_BARRACKS)
    call SetRaceBlacksmith(r, CENTAUR_MILL)
    call SetRaceMill(r, CENTAUR_MILL)
    call SetRaceAltar(r, CENTAUR_ALTAR)
    call SetRaceArcaneSanctum(r, CENTAUR_LODGE)
    call SetRaceShop(r, CENTAUR_SHOP)
    call SetRaceScoutTower(r, CENTAUR_TOWER)
    call SetRaceGuardTower(r, CENTAUR_TOWER)
    call SetRaceCannonTower(r, CENTAUR_TOWER)
    call SetRaceArcaneTower(r, CENTAUR_TOWER)
    call SetRaceWorkshop(r, CENTAUR_ROOST)
    call SetRaceAviary(r, CENTAUR_KHAN_TENT)
    //call SetRaceSacrificialPit(r, KOBOLD_TUNNEL)
    call SetRaceHousing(r, CENTAUR_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, ORC_SHIPYARD)
    call SetRaceSpecialBuilding(r, CENTAUR_SPECIAL_BUILDING)
    //call SetRaceSpecialBuilding2(r, KOBOLD_BOULDER_TOWER)

    // researches
    call AddResearch(r, UPG_CENTAUR_BACKPACK)
    call AddResearch(r, UPG_CENTAUR_DIVINER)
    call AddResearch(r, UPG_CENTAUR_HORSE_SHOES)
    call AddResearch(r, UPG_CENTAUR_REINCARNATION)
    call AddResearch(r, UPG_CENTAUR_SPECIAL_BUILDING)
    call AddResearch(r, UPG_CENTAUR_SORCERER)
    call AddResearch(r, UPG_CENTAUR_SEARING_ARROWS)
    call AddResearch(r, UPG_CENTAUR_MELEE)
    call AddResearch(r, UPG_CENTAUR_RANGED)
    call AddResearch(r, UPG_CENTAUR_ARMOR)
    call AddResearch(r, UPG_CENTAUR_RIDE_DOWN)
    call AddResearch(r, UPG_CENTAUR_TRUE_SIGHT)
    call AddResearch(r, UPG_CENTAUR_SLEEP)

    // units
    call SetRaceWorker(r, CENTAUR_WORKER)
    call SetRaceFootman(r, CENTAUR_DRUDGE)
    call SetRaceRifleman(r, CENTAUR_ARCHER)
    call SetRaceKnight(r, CENTAUR_OUTRUNNER)
    call SetRacePriest(r, CENTAUR_DIVINER)
    call SetRaceSorceress(r, CENTAUR_SORCERER)
    call SetRaceSpellBreaker(r, CENTAUR_SORCERER)
    call SetRaceSiegeEngine(r, CENTAUR_OUTRUNNER)
    call SetRaceTauren(r, CENTAUR_KHAN)
    call SetRaceGryphon(r, CENTAUR_EAGLE)
    call SetRaceDragonHawk(r, CENTAUR_HARPY)
    call SetRaceCitizenMale(r, CENTAUR_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, CENTAUR_CITIZEN_FEMALE)
    call SetRaceChild(r, CENTAUR_CHILD)
    call SetRacePet(r, CENTAUR_PET)
endfunction

private function AddGnoll takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceGnoll = r
    call SetRaceTavernItemType(r, ITEM_GNOLL)
    call SetRaceAiScript(r, "wowr\\Gnoll.ai")
    call SetRaceItemType(r, ITEM_GNOLL_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, GNOLL_TIER_1)
    call SetRaceTier1Item(r, ITEM_GNOLL_TIER_1)
    call SetRaceTier2(r, GNOLL_TIER_2)
    call SetRaceTier3(r, GNOLL_TIER_3)
    call SetRaceFarm(r, GNOLL_HUT)
    call SetRaceBarracks(r, GNOLL_KENNEL)
    call SetRaceBlacksmith(r, GNOLL_LUMBERYARD)
    call SetRaceMill(r, GNOLL_LUMBERYARD)
    call SetRaceAltar(r, GNOLL_ALTAR)
    call SetRaceArcaneSanctum(r, GNOLL_ELEMENTAL_GROVE)
    call SetRaceShop(r, GNOLL_SHOP)
    call SetRaceScoutTower(r, GNOLL_SAVAGE_TOWER)
    call SetRaceGuardTower(r, GNOLL_SAVAGE_TOWER)
    call SetRaceCannonTower(r, GNOLL_SAVAGE_TOWER)
    call SetRaceArcaneTower(r, GNOLL_SAVAGE_TOWER)
    call SetRaceWorkshop(r, GNOLL_BATTLE_ARENA)
    call SetRaceAviary(r, GNOLL_BATTLE_ARENA)
    //call SetRaceSacrificialPit(r, KOBOLD_TUNNEL)
    call SetRaceHousing(r, GNOLL_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, KOBOLD_SHIPYARD)
    call SetRaceSpecialBuilding(r, KOBOLD_MINES)
    //call SetRaceSpecialBuilding2(r, KOBOLD_BOULDER_TOWER)

    // researches
    call AddResearch(r, UPG_GNOLL_BACKPACK)
    call AddResearch(r, UPG_GNOLL_ENVENOMED_WEAPONS)
    call AddResearch(r, UPG_GNOLL_ENSLAVEMENT)
    call AddResearch(r, UPG_GNOLL_BARREL_FORM)

    // units
    call SetRaceWorker(r, GNOLL_WORKER)
    call SetRaceFootman(r, GNOLL_BRUTE)
    call SetRaceRifleman(r, GNOLL_ASSASSIN)
    call SetRaceKnight(r, GNOLL_OVERSEER)
    call SetRacePriest(r, GNOLL_MYSTWEAVER)
    call SetRaceSorceress(r, GNOLL_TREASURE_HUNTER)
    //call SetRaceSpellBreaker(r, QUILLBOAR_NECROMANCER)
    call SetRaceSiegeEngine(r, GNOLL_ROCKBREAKER)
    call SetRaceTauren(r, GNOLL_WARLORD)
    call SetRaceGryphon(r, GNOLL_WARHAWK)
    //call SetRaceDragonHawk(r, QUILLBOAR_HARPY_WINDWITCH)
    call SetRaceCitizenMale(r, GNOLL_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, GNOLL_CITIZEN_FEMALE)
    call SetRaceChild(r, GNOLL_CHILD)
    call SetRacePet(r, GNOLL_PET)
endfunction

private function AddKobold takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceKobold = r
    call SetRaceTavernItemType(r, ITEM_KOBOLD)
    call SetRaceAiScript(r, "wowr\\Kobold.ai")
    call SetRaceItemType(r, ITEM_KOBOLD_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, KOBOLD_TIER_1)
    call SetRaceTier1Item(r, ITEM_KOBOLD_TIER_1)
    call SetRaceTier2(r, KOBOLD_TIER_2)
    call SetRaceTier3(r, KOBOLD_TIER_3)
    call SetRaceFarm(r, KOBOLD_CAVERN)
    call SetRaceBarracks(r, KOBOLD_BARRACKS)
    call SetRaceBlacksmith(r, KOBOLD_MILL)
    call SetRaceMill(r, KOBOLD_MILL)
    call SetRaceAltar(r, KOBOLD_ALTAR)
    call SetRaceArcaneSanctum(r, KOBOLD_LODGE)
    call SetRaceShop(r, KOBOLD_SHOP)
    call SetRaceScoutTower(r, KOBOLD_BOULDER_TOWER)
    call SetRaceGuardTower(r, KOBOLD_ADVANCED_BOULDER_TOWER)
    call SetRaceCannonTower(r, KOBOLD_ADVANCED_BOULDER_TOWER)
    call SetRaceArcaneTower(r, KOBOLD_ADVANCED_BOULDER_TOWER)
    call SetRaceWorkshop(r, KOBOLD_BEASTIARY)
    call SetRaceAviary(r, KOBOLD_TUNNEL)
    //call SetRaceSacrificialPit(r, KOBOLD_TUNNEL)
    call SetRaceHousing(r, KOBOLD_HOUSING)
    //call SetRaceMine(r, KOBOLD_BOULDER_TOWER)
    call SetRaceShipyard(r, KOBOLD_SHIPYARD)
    call SetRaceSpecialBuilding(r, KOBOLD_MINES)
    //call SetRaceSpecialBuilding2(r, KOBOLD_BOULDER_TOWER)

    // researches
    call AddResearch(r, UPG_KOBOLD_BACKPACK)
    call AddResearch(r, UPG_KOBOLD_BURROW)
    call AddResearch(r, UPG_KOBOLD_CANDLES)
    call AddResearch(r, UPG_KOBOLD_MELEE)
    call AddResearch(r, UPG_KOBOLD_ARMOR)
    call AddResearch(r, UPG_KOBOLD_GEOMANCER)
    call AddResearch(r, UPG_KOBOLD_MINING)
    call AddResearch(r, UPG_KOBOLD_GOLD_COINS)
    call AddResearch(r, UPG_KOBOLD_MINES)

    // units
    call SetRaceWorker(r, KOBOLD_WORKER)
    call SetRaceFootman(r, KOBOLD_WARRIOR)
    call SetRaceRifleman(r, KOBOLD_HUNTER)
    call SetRaceKnight(r, KOBOLD_TUNNELER)
    call SetRacePriest(r, KOBOLD_GEOMANCER)
    call SetRaceSorceress(r, KOBOLD_MUSHROOM_CASTER)
    //call SetRaceSpellBreaker(r, QUILLBOAR_NECROMANCER)
    //call SetRaceSiegeEngine(r, QUILLBOAR_QUILBEAST)
    //call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    //call SetRaceGryphon(r, QUILLBOAR_HARPY_ROGUE)
    //call SetRaceDragonHawk(r, QUILLBOAR_HARPY_WINDWITCH)
    call SetRaceCitizenMale(r, KOBOLD_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, KOBOLD_CITIZEN_FEMALE)
    call SetRaceChild(r, KOBOLD_CHILD)
    call SetRacePet(r, KOBOLD_PET)
endfunction

private function AddQuillboar takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceQuillboar = r
    call SetRaceTavernItemType(r, ITEM_QUILLBOAR)
    call SetRaceAiScript(r, "wowr\\Quillboar.ai")
    call SetRaceItemType(r, ITEM_QUILLBOAR_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, QUILLBOAR_TIER_1)
    call SetRaceTier1Item(r, ITEM_QUILLBOAR_TIER_1)
    call SetRaceTier2(r, QUILLBOAR_TIER_2)
    call SetRaceTier3(r, QUILLBOAR_TIER_3)
    call SetRaceFarm(r, QUILLBOAR_HUT)
    call SetRaceBarracks(r, QUILLBOAR_TRAINING_CAMP)
    call SetRaceBlacksmith(r, QUILLBOAR_FORGE)
    call SetRaceMill(r, QUILLBOAR_FORGE)
    call SetRaceAltar(r, QUILLBOAR_ALTAR)
    call SetRaceArcaneSanctum(r, QUILLBOAR_HOUSE_OF_ANCESTRY)
    call SetRaceShop(r, QUILLBOAR_SHOP)
    call SetRaceScoutTower(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceGuardTower(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceCannonTower(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceArcaneTower(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceWorkshop(r, QUILLBOAR_ANIMAL_BATTLE_GROUNDS)
    call SetRaceAviary(r, QUILLBOAR_SACRIFICIAL_GROUNDS)
    call SetRaceHousing(r, QUILLBOAR_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceShipyard(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceSpecialBuilding(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)

    // researches
    call AddResearch(r, UPG_QUILLBOAR_BACKPACK)
    call AddResearch(r, UPG_QUILLBOAR_MEDICINE_MAN)
    call AddResearch(r, UPG_QUILLBOAR_MYSTIC)
    call AddResearch(r, UPG_QUILLBOAR_NECROMANCER)
    call AddResearch(r, UPG_QUILLBOAR_QUIL_SPRAY)
    call AddResearch(r, UPG_QUILLBOAR_QUILLS)
    call AddResearch(r, UPG_QUILLBOAR_THORNS_AURA)
    call AddResearch(r, UPG_QUILLBOAR_MELEE)
    call AddResearch(r, UPG_QUILLBOAR_RANGED)
    call AddResearch(r, UPG_QUILLBOAR_ARMOR)

    // units
    call SetRaceWorker(r, QUILLBOAR_WORKER)
    call SetRaceFootman(r, QUILLBOAR_QUILLBOAR)
    call SetRaceRifleman(r, QUILLBOAR_HUNTER)
    call SetRaceKnight(r, QUILLBOAR_RAIDER)
    call SetRacePriest(r, QUILLBOAR_MEDICINE_MAN)
    call SetRaceSorceress(r, QUILLBOAR_MYSTIC)
    call SetRaceSpellBreaker(r, QUILLBOAR_NECROMANCER)
    call SetRaceSiegeEngine(r, QUILLBOAR_QUILBEAST)
    call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    call SetRaceGryphon(r, QUILLBOAR_HARPY_ROGUE)
    call SetRaceDragonHawk(r, QUILLBOAR_HARPY_WINDWITCH)
    call SetRaceCitizenMale(r, QUILLBOAR_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, QUILLBOAR_CITIZEN_FEMALE)
    call SetRaceChild(r, QUILLBOAR_CHILD)
    call SetRacePet(r, QUILLBOAR_PET)
endfunction

private function AddBandit takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceBandit = r
    call SetRaceTavernItemType(r, ITEM_BANDIT)
    call SetRaceAiScript(r, "wowr\\Bandit.ai")
    call SetRaceItemType(r, ITEM_BANDIT_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, BANDIT_TIER_1)
    call SetRaceTier1Item(r, ITEM_BANDIT_TIER_1)
    call SetRaceTier2(r, BANDIT_TIER_2)
    call SetRaceTier2Item(r, ITEM_TINY_BANDIT_TIER_2)
    call SetRaceTier3(r, BANDIT_TIER_3)
    call SetRaceTier3Item(r, ITEM_TINY_BANDIT_TIER_3)
    call SetRaceFarm(r, BANDIT_TENT)
    call SetRaceFarmItem(r, ITEM_TINY_BANDIT_TENT)
    call SetRaceBarracks(r, BANDIT_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_TINY_BANDIT_BARRACKS)
    call SetRaceBlacksmith(r, BANDIT_BLACKSMITH)
    call SetRaceBlacksmithItem(r, ITEM_TINY_BANDIT_BLACKSMITH)
    call SetRaceMill(r, BANDIT_MILL)
    call SetRaceMillItem(r, ITEM_TINY_BANDIT_MILL)
    call SetRaceAltar(r, BANDIT_ALTAR)
    call SetRaceAltarItem(r, ITEM_TINY_BANDIT_ALTAR)
    call SetRaceArcaneSanctum(r, BANDIT_CHURCH)
    call SetRaceArcaneSanctumItem(r, ITEM_TINY_BANDIT_CHURCH)
    call SetRaceShop(r, BANDIT_MARKET)
    call SetRaceShopItem(r, ITEM_TINY_BANDIT_MARKET)
    call SetRaceScoutTower(r, BANDIT_WATCH_TOWER)
    call SetRaceScoutTowerItem(r, ITEM_TINY_BANDIT_WATCH_TOWER)
    call SetRaceGuardTower(r, BANDIT_WATCH_TOWER)
    call SetRaceGuardTowerItem(r, ITEM_TINY_BANDIT_WATCH_TOWER)
    call SetRaceCannonTower(r, BANDIT_WATCH_TOWER)
    call SetRaceCannonTowerItem(r, ITEM_TINY_BANDIT_WATCH_TOWER)
    call SetRaceArcaneTower(r, BANDIT_WATCH_TOWER)
    call SetRaceArcaneTowerItem(r, ITEM_TINY_BANDIT_WATCH_TOWER)
    call SetRaceWorkshop(r, BANDIT_PRISON)
    call SetRaceWorkshopItem(r, ITEM_TINY_BANDIT_PRISON)
    call SetRaceAviary(r, BANDIT_AVIARY)
    call SetRaceAviaryItem(r, ITEM_TINY_BANDIT_AVIARY)
    call SetRaceHousing(r, BANDIT_HOUSING)
    call SetRaceHousingItem(r, ITEM_TINY_BANDIT_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceShipyard(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, BANDIT_THIEVES_GUILD)
    call SetRaceSpecialBuildingItem(r, ITEM_TINY_BANDIT_THIEVES_GUILD)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, BANDIT_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_TINY_BANDIT_SHIPYARD)

    // researches
    call AddResearch(r, UPG_BANDIT_BACKPACK)
    call AddResearch(r, UPG_BANDIT_ENSNARE)
    call AddResearch(r, UPG_BANDIT_SHADOW_MELD)
    call AddResearch(r, UPG_BANDIT_ROB)
    call AddResearch(r, UPG_BANDIT_ENVENOMED_WEAPONS)
    call AddResearch(r, UPG_BANDIT_ENSLAVEMENT)
    call AddResearch(r, UPG_BANDIT_WIZARD)
    call AddResearch(r, UPG_BANDIT_HERETIC)
    call AddResearch(r, UPG_BANDIT_SLAVE_MASTER)
    call AddResearch(r, UPG_BANDIT_ARMOR)
    call AddResearch(r, UPG_BANDIT_MELEE)
    call AddResearch(r, UPG_BANDIT_RANGED)
    call AddResearch(r, UPG_BANDIT_WOOD)
    call AddResearch(r, UPG_BANDIT_FEATHER_ATTACK)
    call AddResearch(r, UPG_BANDIT_TRUE_SIGHT)
    call AddResearch(r, UPG_BANDIT_STORM_HAMMERS)
    call AddResearch(r, UPG_BANDIT_RIDE_DOWN)
    call AddResearch(r, UPG_BANDIT_RESISTANT_SKIN)
    call AddResearch(r, UPG_BANDIT_THIEVES_GUILD)

    // units
    call SetRaceWorker(r, BANDIT_WORKER)
    call SetRaceFootman(r, BANDIT_BANDIT)
    call SetRaceRifleman(r, BANDIT_BRIGAND)
    call SetRaceKnight(r, BANDIT_BANDIT_LORD)
    call SetRacePriest(r, BANDIT_WIZARD)
    call SetRaceSorceress(r, BANDIT_HERETIC)
    call SetRaceSpellBreaker(r, BANDIT_SLAVE_MASTER)
    call SetRaceSiegeEngine(r, BANDIT_CARGE_CART)
    call SetRaceMortar(r, BANDIT_AMBAL)
    call SetRaceFlyingMachine(r, BANDIT_CROSSBOWMAN)
    //call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    call SetRaceGryphon(r, BANDIT_GRYPHON_RAIDER)
    call SetRaceDragonHawk(r, BANDIT_CROW)
    call SetRaceAviary3(r, BANDIT_FLYING_SPEAR_THROWER)
    call SetRaceCitizenMale(r, BANDIT_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, BANDIT_CITIZEN_FEMALE)
    call SetRaceChild(r, BANDIT_CHILD)
    call SetRacePet(r, BANDIT_PET)
endfunction

private function AddDungeon takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDungeon = r
    call SetRaceTavernItemType(r, ITEM_DUNGEON)
    call SetRaceAiScript(r, "wowr\\Dungeon.ai")
    call SetRaceItemType(r, ITEM_DUNGEON_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, DUNGEON_TIER_1)
    call SetRaceTier1Item(r, ITEM_DUNGEON_TIER_1)
    call SetRaceTier2(r, DUNGEON_TIER_2)
    call SetRaceTier2Item(r, ITEM_DUNGEON_TIER_2)
    call SetRaceTier3(r, DUNGEON_TIER_3)
    call SetRaceTier3Item(r, ITEM_DUNGEON_TIER_3)
    call SetRaceFarm(r, DUNGEON_CAGE)
    call SetRaceFarmItem(r, ITEM_DUNGEON_CAGE)
    call SetRaceBarracks(r, DUNGEON_BARRACKS)
    call SetRaceBarracksItem(r, ITEM_DUNGEON_BARRACKS)
    call SetRaceBlacksmith(r, DUNGEON_TORTURE_CHAMBER)
    call SetRaceBlacksmithItem(r, ITEM_DUNGEON_MILL)
    call SetRaceMill(r, DUNGEON_TORTURE_CHAMBER)
    call SetRaceMillItem(r, ITEM_DUNGEON_MILL)
    call SetRaceAltar(r, DUNGEON_ALTAR)
    call SetRaceAltarItem(r, ITEM_DUNGEON_ALTAR)
    call SetRaceArcaneSanctum(r, DUNGEON_BRAZIER)
    call SetRaceArcaneSanctumItem(r, ITEM_DUNGEON_BRAZIER)
    call SetRaceShop(r, DUNGEON_SHOP)
    call SetRaceShopItem(r, ITEM_DUNGEON_SHOP)
    call SetRaceScoutTower(r, DUNGEON_SPIKES)
    call SetRaceScoutTowerItem(r, ITEM_DUNGEON_SPIKES)
    call SetRaceGuardTower(r, DUNGEON_SPIKES)
    call SetRaceGuardTowerItem(r, ITEM_DUNGEON_SPIKES)
    call SetRaceCannonTower(r, DUNGEON_SPIKES)
    call SetRaceCannonTowerItem(r, ITEM_DUNGEON_SPIKES)
    call SetRaceArcaneTower(r, DUNGEON_SPIKES)
    call SetRaceArcaneTowerItem(r, ITEM_DUNGEON_SPIKES)
    call SetRaceWorkshop(r, DUNGEON_PRISON)
    call SetRaceWorkshopItem(r, ITEM_DUNGEON_PRISON)
    call SetRaceAviary(r, DUNGEON_DRAGON_ROOST)
    call SetRaceAviaryItem(r, ITEM_DUNGEON_DRAGON_ROOST)
    call SetRaceHousing(r, DUNGEON_HOUSING)
    call SetRaceHousingItem(r, ITEM_DUNGEON_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    //call SetRaceShipyard(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceSpecialBuilding(r, DUNGEON_THRONE)
    call SetRaceSpecialBuildingItem(r, ITEM_DUNGEON_THRONE)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, DUNGEON_SHIPYARD)
    call SetRaceShipyardItem(r, ITEM_DUNGEON_SHIPYARD)

    // researches
    call AddResearch(r, UPG_DUNGEON_BACKPACK)
    call AddResearch(r, UPG_DUNGEON_MELEE)
    call AddResearch(r, UPG_DUNGEON_ARMOR)
    call AddResearch(r, UPG_DUNGEON_RANGED)
    call AddResearch(r, UPG_DUNGEON_EAT_TREE)
    call AddResearch(r, UPG_DUNGEON_BURNING_ARROWS)
    call AddResearch(r, UPG_DUNGEON_GHOST)
    call AddResearch(r, UPG_DUNGEON_FIRE_REVENANT)
    call AddResearch(r, UPG_DUNGEON_SKELETON_BONES)
    call AddResearch(r, UPG_DUNGEON_CREATE_CORPSE)
    call AddResearch(r, UPG_DUNGEON_CAPTURE)
    call AddResearch(r, UPG_DUNGEON_DEVOUR)
    call AddResearch(r, UPG_DUNGEON_BERSERK)
    call AddResearch(r, UPG_DUNGEON_SLEEP_FORM)
    call AddResearch(r, UPG_DUNGEON_WAR_STOMP)
    call AddResearch(r, UPG_DUNGEON_SPIKES)
    call AddResearch(r, UPG_DUNGEON_RESISTANT_SKIN)
    call AddResearch(r, UPG_DUNGEON_THRONE)

    // units
    call SetRaceWorker(r, DUNGEON_WORKER)
    call SetRaceFootman(r, DUNGEON_SKELETON_WARRIOR)
    call SetRaceRifleman(r, DUNGEON_SKELETON_ARCHER)
    call SetRaceKnight(r, DUNGEON_SKELETON_BERSERKER)
    call SetRacePriest(r, DUNGEON_FIRE_REVENANT)
    call SetRaceSorceress(r, DUNGEON_GHOST)
    call SetRaceSpellBreaker(r, DUNGEON_HERETIC)
    call SetRaceSiegeEngine(r, DUNGEON_SALAMANDER)
    call SetRaceMortar(r, DUNGEON_SLUDGE)
    call SetRaceFlyingMachine(r, DUNGEON_WAR_GOLEM)
    call SetRaceTauren(r, DUNGEON_LORD)
    call SetRaceGryphon(r, DUNGEON_RED_DRAGON)
    call SetRaceDragonHawk(r, DUNGEON_WILDKIN)
    call SetRaceShade(r, DUNGEON_PRISONER)
    call SetRaceCitizenMale(r, DUNGEON_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DUNGEON_CITIZEN_FEMALE)
    call SetRaceChild(r, DUNGEON_CHILD)
    call SetRacePet(r, DUNGEON_PET)
endfunction

private function AddDragonkin takes nothing returns nothing
    local integer r = AddRace()
    set udg_RaceDragonkin = r
    call SetRaceTavernItemType(r, ITEM_DRAGONKIN)
    call SetRaceAiScript(r, "wowr\\Dragonkin.ai")
    call SetRaceItemType(r, ITEM_DRAGONKIN_SCEPTER)
    call SetRaceTeam(r, TEAM_NONE)

    // buildings
    call SetRaceTier1(r, DRAGONKIN_TIER_1)
    call SetRaceTier1Item(r, ITEM_DRAGONKIN_TIER_1)
    call SetRaceTier2(r, DRAGONKIN_TIER_2)
    call SetRaceTier3(r, DRAGONKIN_TIER_3)
    call SetRaceFarm(r, DRAGONKIN_NEST)
    call SetRaceBarracks(r, DRAGONKIN_BARRACKS)
    call SetRaceBlacksmith(r, DRAGONKIN_FORGE)
    call SetRaceMill(r, DRAGONKIN_QUARRY)
    call SetRaceAltar(r, DRAGONKIN_ALTAR)
    call SetRaceArcaneSanctum(r, DRAGONKIN_ARCANE_TEMPLE)
    call SetRaceShop(r, DRAGONKIN_SHOP)
    call SetRaceScoutTower(r, DRAGONKIN_TOWER)
    call SetRaceGuardTower(r, DRAGONKIN_TOWER)
    call SetRaceCannonTower(r, DRAGONKIN_TOWER)
    call SetRaceArcaneTower(r, DRAGONKIN_TOWER)
    call SetRaceWorkshop(r, DRAGONKIN_ARENA)
    call SetRaceAviary(r, DRAGONKIN_ROOST)
    call SetRaceHousing(r, DRAGONKIN_HOUSING)
    //call SetRaceMine(r, QUILLBOAR_THORNY_SPIRE)
    call SetRaceShipyard(r, DRAGONKIN_SHIPYARD)
    call SetRaceSpecialBuilding(r, DRAGONKIN_WYRMREST_TEMPLE)
    //call SetRaceSpecialBuilding2(r, QUILLBOAR_THORNY_SPIRE)

    // researches
    call AddResearch(r, UPG_DRAGONKIN_BACKPACK)
    call AddResearch(r, UPG_DRAGONKIN_SPELL_DAMAGE_REDUCTION)
    call AddResearch(r, UPG_DRAGONKIN_RESISTANT_SKIN)
    call AddResearch(r, UPG_DRAGONKIN_FIRE_ATTACK)

    // units
    call SetRaceWorker(r, DRAGONKIN_WORKER)
    call SetRaceFootman(r, DRAGONKIN_FOOTMAN)
    call SetRaceRifleman(r, DRAGONKIN_RIFLEMAN)
    call SetRaceKnight(r, DRAGONKIN_BLACK_DRAGON)
    call SetRaceGryphon(r, DRAGONKIN_BLACK_DRAGON)
    call SetRacePriest(r, DRAGONKIN_DRAGON_PRIEST)
    /*
    call SetRaceSorceress(r, QUILLBOAR_MYSTIC)
    call SetRaceSpellBreaker(r, QUILLBOAR_NECROMANCER)
    call SetRaceSiegeEngine(r, QUILLBOAR_QUILBEAST)
    call SetRaceTauren(r, QUILLBOAR_CHIEFTAIN)
    call SetRaceGryphon(r, QUILLBOAR_HARPY_ROGUE)
    call SetRaceDragonHawk(r, QUILLBOAR_HARPY_WINDWITCH)
    */
    call SetRaceCitizenMale(r, DRAGONKIN_CITIZEN_MALE)
    call SetRaceCitizenFemale(r, DRAGONKIN_CITIZEN_FEMALE)
    call SetRaceChild(r, DRAGONKIN_CHILD)
    call SetRacePet(r, DRAGONKIN_PET)
endfunction

private function AddRaceScepterItems takes nothing returns nothing
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i == max)
        call SetRaceObjectType(i, RACE_OBJECT_TYPE_SCEPTER_ITEM, udg_RaceItemType[i])
        set i = i + 1
    endloop
endfunction

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

private function AddRaceStandardObjectIdFields takes nothing returns nothing
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

private function Init takes nothing returns nothing
    call AddNone()
    call AddFreelancer()
    call AddHuman()
    call AddOrc()
    call AddUndead()
    call AddNightElf()
    call AddBloodElf()
    call AddNaga()
    call AddDraenei()
    call AddLostOnes()
    call AddDemon()
    call AddFurbolg()
    call AddGoblin()
    call AddDwarf()
    call AddHighElf()
    call AddGnome()
    call AddTroll()
    call AddTauren()
    call AddPandaren()
    call AddLordaeron()
    call AddStormwind()
    call AddDalaran()
    call AddKulTiras()
    call AddWorgen()
    call AddVrykul()
    call AddNerubian()
    call AddTuskarr()
    call AddMurloc()
    call AddOgre()
    call AddFelOrc()
    call AddFacelessOne()
    call AddSatyr()
    call AddCentaur()
    call AddGnoll()
    call AddKobold()
    call AddQuillboar()
    call AddBandit()
    call AddDungeon()
    call AddDragonkin()
    
    call AddRaceScepterItems()
    
    call AddRaceStandardObjectIdFields() // Do this after the hero initialization!
    
    // Abilities
    
    // RESKILLABLE
    call AddAbility('A14U', 1, udg_RaceNone)
    call AddAbility('Abds', 1, udg_RaceNone)
    call AddAbility('Abdl', 1, udg_RaceNone)
    call AddAbility('Abgs', 1, udg_RaceNone)
    call AddAbility('Abgl', 1, udg_RaceNone)
    call AddAbility('Avul', 1, udg_RaceNone)
    call AddAbility('Awrp', 1, udg_RaceNone)
    call AddAbility('ARal', 1, udg_RaceNone)
    call AddAbility('A0MZ', 1, udg_RaceNone)
    call AddAbility('A09M', 1, udg_RaceNone)
    call AddAbility('A04Y', 1, udg_RaceNone)
    call AddAbility('A04W', 1, udg_RaceNone)
    call AddAbility('A09I', 1, udg_RaceNone)
    call AddAbility('ACmi', 1, udg_RaceNone)
    call AddAbility('A0N6', 1, udg_RaceNone)
    // HUMAN
    call AddAbility('Adef', 1, udg_RaceHuman)
    call AddAbility('Asth', 1, udg_RaceHuman)
    call AddAbility('Ahea', 1, udg_RaceHuman)
    call AddAbility('Aslo', 1, udg_RaceHuman)
    // NIGHT ELF
    call AddAbility('Aro2', 1, udg_RaceNightElf)
    // BLOOD ELF
    call AddAbility('A16I', 1, udg_RaceBloodElf)
    // GOBLIN
    call AddAbility('A0BA', 1, udg_RaceGoblin)
    // KUL TIRAS
    call AddAbility('A0RI', 1, udg_RaceKulTiras)
    call AddAbility('A0RJ', 1, udg_RaceKulTiras)
    call AddAbility('A0JE', 1, udg_RaceKulTiras)
    // WORGEN
    call AddAbility('A11Y', 1, udg_RaceWorgen)
    // DALARAN
    call AddAbility('A0NI', 1, udg_RaceDalaran)
    call AddAbility('A0NZ', 1, udg_RaceDalaran)
endfunction

endlibrary
