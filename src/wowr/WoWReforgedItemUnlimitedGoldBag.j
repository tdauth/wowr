library WoWReforgedItemUnlimitedGoldBag initializer Init

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A257') then
        call BlzStartUnitAbilityCooldown(GetTriggerUnit(), GetSpellAbilityId(), BlzGetUnitAbilityCooldown(GetTriggerUnit(), GetSpellAbilityId(), GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
