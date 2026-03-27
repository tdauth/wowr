library WoWReforgedSpellSummonMeatWagon initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    local integer level = 0
    if (GetUnitTypeId(GetSummonedUnit()) == SUMMONED_MEAT_WAGON) then
        set level =  GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_SUMMON_MEAT_WAGON)
        if (level > 0) then
            call SkillAbility(GetSummonedUnit(), 'S00N', level)
            call SkillAbility(GetSummonedUnit(), 'A0KL', level)
            call SkillAbility(GetSummonedUnit(), 'A0KK', level)
        endif
    elseif (GetUnitTypeId(GetSummonedUnit()) == SUMMONED_MEAT_WAGON_CLOUD) then
        set level =  GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_SUMMON_MEAT_WAGON)
        if (level > 0) then
            call SkillAbility(GetSummonedUnit(), 'A1LK', level)
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
