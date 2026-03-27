library WoWReforgedRaces requires WoWReforgedUtils, WoWReforgedVIPs, WoWReforgedDependencyEquivalents, WoWReforgedObjectMappings

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
endglobals

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
    loop
        exitwhen (i == udg_MaxRaces)
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
    loop
        exitwhen (i >= udg_MaxRaces or result != RACE_OBJECT_TYPE_NONE)
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
    local integer tmpType = 0
    loop
        exitwhen (i == udg_MaxRaces)
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

function AddRace takes nothing returns integer
    local integer index = udg_MaxRaces
    set udg_MaxRaces = udg_MaxRaces + 1
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

function SetRaceTeam takes integer whichRace, integer team returns nothing
    set udg_RaceTeam[whichRace] = team
endfunction

function SetRaceTavernItemType takes integer whichRace, integer itemTypeId returns nothing
    set udg_RaceName[whichRace] = GetObjectName(itemTypeId)
    set udg_RaceTavernItemType[whichRace] = itemTypeId
endfunction

// scepter
function SetRaceItemType takes integer whichRace, integer itemTypeId returns nothing
    set udg_RaceItemType[whichRace] = itemTypeId
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCEPTER_ITEM, itemTypeId)
endfunction

function SetRaceAiScript takes integer whichRace, string aiScript returns nothing
    set udg_RaceAIScript[whichRace] = aiScript
endfunction

function SetRaceHasFootmanWorker takes integer whichRace, boolean flag returns nothing
    set udg_RaceHasFootmanWorker[whichRace] = flag
endfunction

function SetRaceHasBlight takes integer whichRace, boolean flag returns nothing
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

function GetRacesMax takes nothing returns integer
    return udg_MaxRaces
endfunction

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

function SetRaceTier1 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_1, id)
endfunction

function SetRaceTier1Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_1_ITEM, id)
    set udg_RaceItemTypeTinyCastle[whichRace] = id
endfunction

function SetRaceTier2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_2, id)
endfunction

function SetRaceTier2Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_2_ITEM, id)
endfunction

function SetRaceTier3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_3, id)
endfunction

function SetRaceTier3Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TIER_3_ITEM, id)
endfunction

function SetRaceFarm takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FARM, id)
endfunction

function SetRaceFarmItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FARM_ITEM, id)
endfunction

function SetRaceBarracks takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS, id)
endfunction

function SetRaceBarracksItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS_ITEM, id)
endfunction

function SetRaceBlacksmith takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH, id)
endfunction

function SetRaceBlacksmithItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH_ITEM, id)
endfunction

function SetRaceMill takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MILL, id)
endfunction

function SetRaceMillItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MILL_ITEM, id)
endfunction

function SetRaceAltar takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ALTAR, id)
endfunction

function SetRaceAltarItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ALTAR_ITEM, id)
endfunction

function SetRaceArcaneSanctum takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM, id)
endfunction

function SetRaceArcaneSanctumItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM, id)
endfunction

function SetRaceShop takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHOP, id)
endfunction

function SetRaceShopItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHOP_ITEM, id)
endfunction

function SetRaceScoutTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCOUT_TOWER, id)
endfunction

function SetRaceScoutTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM, id)
endfunction

function SetRaceGuardTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GUARD_TOWER, id)
endfunction

function SetRaceGuardTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GUARD_TOWER_ITEM, id)
endfunction

function SetRaceCannonTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CANNON_TOWER, id)
endfunction

function SetRaceCannonTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CANNON_TOWER_ITEM, id)
endfunction

function SetRaceArcaneTower takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_TOWER, id)
endfunction

function SetRaceArcaneTowerItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_TOWER_ITEM, id)
endfunction

function SetRaceWorkshop takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP, id)
endfunction

function SetRaceWorkshopItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP_ITEM, id)
endfunction

function SetRaceAviary takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY, id)
endfunction

function SetRaceAviaryItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM, id)
endfunction

function SetRaceSacrificialPit takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT, id)
endfunction

function SetRaceSacrificialPitItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM, id)
endfunction

function GetRaceHousing takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_HOUSING)
endfunction

function SetRaceHousing takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_HOUSING, id)
endfunction

function SetRaceHousingItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_HOUSING_ITEM, id)
endfunction

function GetRaceMine takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE)
endfunction

function SetRaceMine takes integer whichRace, integer id returns nothing
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

function SetRaceShipyard2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIPYARD_2, id)
endfunction

function SetRaceShipyardItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIPYARD_ITEM, id)
endfunction

function SetRaceSpecialBuilding takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING, id)
endfunction

function SetRaceSpecialBuildingItem takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM, id)
endfunction

function SetRaceSpecialBuilding2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2, id)
endfunction

function SetRaceSpecialBuilding2Item takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2_ITEM, id)
endfunction

function GetRaceWorker takes integer whichRace returns integer
    return GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_WORKER)
endfunction

function SetRaceWorker takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKER, id)
endfunction

function SetRaceTownHall3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TOWN_HALL_3, id)
endfunction

function SetRaceTownHall4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TOWN_HALL_4, id)
endfunction

function SetRaceFootman takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FOOTMAN, id)
endfunction

function SetRaceRifleman takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_RIFLEMAN, id)
endfunction

function SetRaceKnight takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_KNIGHT, id)
endfunction

function SetRaceBarracks4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BARRACKS_4, id)
endfunction

function SetRacePriest takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_PRIEST, id)
endfunction

function SetRaceSorceress takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SORCERESS, id)
endfunction

function SetRaceSpellBreaker takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SPELLBREAKER, id)
endfunction

function SetRaceArcaneSanctum4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM_4, id)
endfunction

function SetRaceFlyingMachine takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FLYING_MACHINE, id)
endfunction

function SetRaceSiegeEngine takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SIEGE_ENGINE, id)
endfunction

function SetRaceMortar takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MORTAR, id)
endfunction

function SetRaceWorkshop4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_WORKSHOP_4, id)
endfunction

function SetRaceTauren takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TAUREN, id)
endfunction

function SetRaceGryphon takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_GRYPHON, id)
endfunction

function SetRaceDragonHawk takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_DRAGONHAWK, id)
endfunction

function SetRaceAviary3 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_AVIARY_3, id)
endfunction

function SetRaceAviary4 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_AVIARY_4, id)
endfunction

function SetRaceShade takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHADE, id)
endfunction

function SetRaceCitizenMale takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_MALE_CITIZEN, id)
endfunction

function SetRaceCitizenFemale takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FEMALE_CITIZEN, id)
endfunction

function SetRaceChild takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_CHILD, id)
endfunction

function SetRacePet takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_PET, id)
endfunction

function SetRaceTransportShip takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_TRANSPORT_SHIP, id)
endfunction

function GetRaceTransportShip takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_TRANSPORT_SHIP)
endfunction

function SetRaceFrigate takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_FRIGATE, id)
endfunction

function GetRaceFrigate takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_FRIGATE)
endfunction

function SetRaceBattleship takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_BATTLESHIP, id)
endfunction

function GetRaceBattleship takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_BATTLESHIP)
endfunction

function SetRaceShipSpecial1 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIP_SPECIAL_1, id)
endfunction

function GetRaceShipSpecial1 takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIP_SPECIAL_1)
endfunction

function SetRaceShipSpecial2 takes integer whichRace, integer id returns nothing
    call SetRaceObjectType(whichRace, RACE_OBJECT_TYPE_SHIP_SPECIAL_2, id)
endfunction

function GetRaceShipSpecial2 takes integer r returns integer
    return GetRaceObjectTypeId(r, RACE_OBJECT_TYPE_SHIP_SPECIAL_2)
endfunction

function AddRaceItemsSaveObjects takes nothing returns nothing
    local integer i = 1
    local integer max = udg_MaxRaces
    local integer j = 0
    local integer max2 = 0
    local integer array addedObjectTypeIds
    local integer addedObjectTypeIdsCounter = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceItem(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddSaveObjectItemTypeEx(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddRaceUnitsSaveObjects takes nothing returns nothing
    local integer i = udg_RaceFreelancer
    local integer max = udg_MaxRaces
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceUnit(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddSaveObjectUnitTypeEx(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddRaceBuildingsSaveObjects takes nothing returns nothing
    local integer i = udg_RaceFreelancer
    local integer max = udg_MaxRaces
    local integer j = 0
    local integer max2 = 0
    local integer array addedObjectTypeIds
    local integer addedObjectTypeIdsCounter = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceBuilding(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddSaveObjectBuildingTypeEx(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

endlibrary
