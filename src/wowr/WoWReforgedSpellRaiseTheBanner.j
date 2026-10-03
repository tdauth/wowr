library WoWReforgedSpellRaiseTheBanner initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    call SkillAbility(GetSummonedUnit(), ABILITY_RAISE_THE_BANNER_CRIT, GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_RAISE_THE_BANNER))
    call SkillAbility(GetSummonedUnit(), ABILITY_RAISE_THE_BANNER_SPELL_CRIT, GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_RAISE_THE_BANNER))
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
