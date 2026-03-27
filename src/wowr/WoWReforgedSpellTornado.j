library WoWReforgedSpellTornado initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == TORNADO and GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_TORNADO) > 0) then
        call SkillAbility(GetSummonedUnit(), ABILITY_TORNADO_BUILDING_DAMAGE_AURA, GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_TORNADO))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
