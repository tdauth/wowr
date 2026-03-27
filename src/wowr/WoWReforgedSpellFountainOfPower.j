library WoWReforgedSpellFountainOfPower initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    local integer level = GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_FOUNTAIN_OF_POWER)
    if (GetUnitTypeId(GetSummonedUnit()) == POWER_WARD and level > 0) then
        call SkillAbility(GetSummonedUnit(), ABILITY_LIFE_REGENERATION_NEUTRAL, level)
        call SkillAbility(GetSummonedUnit(), ABILITY_MANA_REGENERATION_NEUTRAL, level)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
