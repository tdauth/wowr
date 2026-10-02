library UnitGroupRespawnConfig requires UnitTypeUtils, WoWReforgedProfessionHunter, WoWReforgedCalendarEvents, WoWReforgedCrateTypes, WoWReforgedCages, WoWReforgedRandomItems

globals
    // The default delay until a unit will be respawned.
    public constant real DEFAULT_TIMEOUT = 90.0
    // All preplaced units owned by the CREEPS_OWNER player on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
    public constant boolean AUTO_ADD_ALL_PREPLACED_CREEPS = false
    // Creates unit group respawns from preplaced creeps next to each other if this value is true. Otherwise, it will create separate unit respawns per creep.
    public constant boolean AUTO_ADDED_GROUPS = true
    // Defines the maximum distance between preplaced creep units to belong to the same respawn group if AUTO_ADDED_GROUPS is true.
    public constant real AUTO_ADDED_GROUP_MAX_DISTANCE = 800.0
    // All players who preplaced units are added as respawning groups for.
    public constant force AUTO_ADDED_GROUP_PLAYERS = CreateForce()
    // Shows the eyecandy on respawning hero revivals if set to true. Otherwise, the effect is not shown.
    public constant boolean HERO_RESPAWN_DO_EYECANDY = true
    // Avoids permanent removal if too many heroes from the same player died.
    public constant boolean SET_MAX_DEATH_TIME_TO_UNITS = true
    public constant boolean AUTO_ADDED_DROP_RANDOM_ITEMS = true
    // Uses the unit type levels instead of the current levels of units which could have been changed with function calls for item drops.
    public constant boolean GET_UNIT_LEVEL_BY_TYPE = true

    // World of Warcraft Reforged
    constant integer DROP_CHANCE_ITEM = 50
    constant integer DROP_CHANCE_DIFFERENT_LEVEL = 40
    constant integer DROP_CHANCE_HIGHER_LEVEL = 10
    constant integer DROP_CHANCE_LOWER_LEVEL = DROP_CHANCE_DIFFERENT_LEVEL - DROP_CHANCE_HIGHER_LEVEL

    // Caches the unit levels for unit types.
    private hashtable respawnUnitLevelsHashTable = InitHashtable()
endglobals

private function GetMaxUnitLevelFromGroup takes group whichGroup returns integer
    local integer maxLevel = 0
    local integer unitLevel = 0
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(whichGroup))
        set unitLevel = GetUnitLevelByType(GetUnitTypeId(BlzGroupUnitAt(whichGroup, i)), Player(PLAYER_NEUTRAL_AGGRESSIVE))
        set maxLevel = IMaxBJ(unitLevel, maxLevel)
        set i = i + 1
    endloop
    return maxLevel
endfunction

private function DropItem takes unit dyingUnit, group whichGroup returns nothing
    local integer unitLevel = GetMaxUnitLevelFromGroup(whichGroup)
    local integer itemLevel = unitLevel // 60 percent chance
    local integer chance = GetRandomInt(1, 100)
    local integer itemTypeId = 0

    // 40 percent chance to drop an item with level above or below
    if (chance <= DROP_CHANCE_DIFFERENT_LEVEL) then
        if (chance <= DROP_CHANCE_HIGHER_LEVEL) then // 10 percent level above
            set itemLevel = IMinBJ(8, unitLevel + GetRandomInt(1, 8 - unitLevel))
        else // 30 percent level below
            set itemLevel = IMaxBJ(0, unitLevel - GetRandomInt(1, unitLevel - 1))
        endif
    endif

    set itemTypeId = GetRandomDropableItemTypeId(itemLevel)
    if (itemTypeId != 0) then
        call UnitDropItem(dyingUnit, itemTypeId)
    endif

    if (IsChristmas()) then
        call UnitDropItem(dyingUnit, ITEM_CHRISTMAS_PRESENT)
    endif

    if (IsEaster()) then
        call UnitDropItem(dyingUnit, ITEM_EASTER_EGG)
    endif

    if (IsHalloween()) then
        call UnitDropItem(dyingUnit, ITEM_CANDY)
    endif
endfunction

private function DropItemForGroupEx takes integer groupIndex, unit dyingUnit, group whichGroup returns nothing
    local integer unitLevel = GetMaxUnitLevelFromGroup(whichGroup)
    local integer chanceToDrop = GetRandomInt(1, 100)

    // 50 percent chance to drop an item at all
    if (chanceToDrop <= DROP_CHANCE_ITEM) then
        call DropItem(dyingUnit, whichGroup)
    endif
endfunction

public function DropItemForGroup takes integer groupIndex, unit dyingUnit, group whichGroup, boolean drop returns nothing
    local integer unitTypeId = GetUnitTypeId(dyingUnit)
static if (AUTO_ADDED_DROP_RANDOM_ITEMS) then
    if (drop and unitTypeId != FLOTSAM and not IsCritter(unitTypeId)) then
        call DropItemForGroupEx(groupIndex, dyingUnit, whichGroup)
    endif
endif
endfunction

endlibrary
