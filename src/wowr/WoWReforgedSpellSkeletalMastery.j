library WoWReforgedSpellSkeletalMastery initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

function GetSkeletalMasteryDuration takes unit caster, integer abilityId, integer level returns real
    return 60.0 + level * 5.0
endfunction

private function IsTemporarySummonedUnitType takes integer unitTypeId returns boolean
    if (unitTypeId == SKEL_WARRIOR) then
        return true
    elseif (unitTypeId == SKELETAL_MAGE) then
        return true
    elseif (unitTypeId == TENTACLE) then
        return true
    endif
    return false
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    local integer level = 0
    if (IsTemporarySummonedUnitType(GetUnitTypeId(GetSummonedUnit()))) then
        set level = GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_SKELETAL_MASTERY)
        if (level > 0) then
            call UnitApplyTimedLife(GetSummonedUnit(), 'BTLF', GetSkeletalMasteryDuration(GetSummoningUnit(), ABILITY_SKELETAL_MASTERY, level))
            //call BJDebugMsg("Apply summon duration bonus to " + GetUnitName(GetSummonedUnit()))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
    
    call RegisterAbilityFieldCustomReal0(ABILITY_SKELETAL_MASTERY, GetSkeletalMasteryDuration)
endfunction

endlibrary
