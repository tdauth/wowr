library WoWReforgedSpellPocketFactory initializer Init requires WoWReforgedAbilitySkill, WoWReforgedSummonedUnits

globals
    private trigger summonFactoryTrigger = CreateTrigger()
    private trigger summonClockwerkGoblinTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummonFactory takes nothing returns boolean
    if (GetTriggerPocketFactory() != null and GetTriggerPocketFactoryCaster() != null) then
        call SkillAbility(GetTriggerPocketFactory(), ABILITY_POCKET_FACTORY_ABILITY_ICON, GetUnitAbilitySkillLevelSafe(GetTriggerPocketFactoryCaster(), ABILITY_POCKET_FACTORY))
        call AddSummonedUnitBonus(GetTriggerPocketFactory(), GetUnitAbilitySkillLevelSafe(GetTriggerPocketFactoryCaster(), ABILITY_POCKET_FACTORY))
    endif
    return false
endfunction

private function TriggerConditionSummonClockwerkGoblin takes nothing returns boolean
    call SkillAbility(GetTriggerClockwerkGoblin(), ABILITY_POCKET_FACTORY_ABILITY_KABOOM, GetUnitAbilitySkillLevelSafe(GetTriggerPocketFactory(), ABILITY_POCKET_FACTORY_ABILITY_ICON))
    call AddSummonedUnitBonus(GetTriggerClockwerkGoblin(), GetUnitAbilitySkillLevelSafe(GetTriggerPocketFactory(), ABILITY_POCKET_FACTORY_ABILITY_ICON))
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterPocketFactorySummon(summonFactoryTrigger)
    call TriggerAddCondition(summonFactoryTrigger, Condition(function TriggerConditionSummonFactory))
    call TriggerRegisterPocketFactorySummonClockwerkGoblin(summonClockwerkGoblinTrigger)
    call TriggerAddCondition(summonClockwerkGoblinTrigger, Condition(function TriggerConditionSummonClockwerkGoblin))
endfunction

endlibrary
