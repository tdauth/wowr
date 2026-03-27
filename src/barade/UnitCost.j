library UnitCost

/*
 * Baradé's Unit Cost 1.0
 *
 * GetUnitGoldCost and GetUnitWoodCost will crash the game when used with an ID of a hero unit type.
 * This system provides GetUnitGoldCostSafe and GetUnitWoodCostSafe which will always return default
 * values for hero unit types and not crash the game.
 */

globals
    public constant integer HERO_GOLD_COST = 0
    public constant integer HERO_WOOD_COST = 0
endglobals

function GetUnitGoldCostSafe takes integer unitid returns integer
    if (IsUnitIdType(unitid, UNIT_TYPE_HERO)) then
        return HERO_GOLD_COST
    endif
    return GetUnitGoldCost(unitid)
endfunction

function GetUnitWoodCostSafe takes integer unitid returns integer
    if (IsUnitIdType(unitid, UNIT_TYPE_HERO)) then
        return HERO_WOOD_COST
    endif
    return GetUnitWoodCost(unitid)
endfunction

endlibrary
