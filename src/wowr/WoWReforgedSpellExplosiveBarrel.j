library WoWReforgedSpellExplosiveBarrel initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == CREEP_EXPLOSIVE_BARREL and GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_EXPLOSIVE_BARREL) > 0) then
        call SkillAbility(GetSummonedUnit(), ABILITY_AOE_DAMAGE, GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_EXPLOSIVE_BARREL))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
