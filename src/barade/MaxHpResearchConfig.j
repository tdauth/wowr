library MaxHPResearchConfig requires WoWReforgedDependencyEquivalents, WoWReforgedMounts, WoWReforgedProfessionEngineer, WoWReforgedCrateTypes, WoWReforgedCages

globals
    public constant integer OGRE_STRENGTH_ABILITY_ID = 'A1N7'
endglobals

function IsAffectedByEvolution takes integer id returns boolean
    if (IsCrate(id)) then
        return false
    elseif (IsCage(id)) then
        return false
    elseif (id == EGG_SACK) then
        return false
    elseif (id == CREEP_EXPLOSIVE_BARREL) then
        return false
    elseif (id == FLOTSAM) then
        return false
    elseif (id == LEGENDARY_ARTIFACT) then
        return false
    endif
    
    return true
endfunction

function IsUnitAffectedByEvolution takes unit whichUnit returns boolean
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        return false
    elseif (IsUnitIllusion(whichUnit)) then
        return false
    endif

    return IsAffectedByEvolution(GetUnitTypeId(whichUnit))
endfunction

function UnitHasMaxHpResearch takes unit whichUnit, integer id returns boolean
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        return false
    elseif (id == UPG_EVOLUTION) then
        return IsUnitAffectedByEvolution(whichUnit)
    elseif (id == UPG_OGRE_STRENGTH) then
        return GetUnitAbilityLevel(whichUnit, OGRE_STRENGTH_ABILITY_ID) > 0
    elseif (id == UPG_MASONRY_ENGINEER) then
        return IsUnitEngineerBuilding(whichUnit)
    endif
    
    return false
endfunction

endlibrary
