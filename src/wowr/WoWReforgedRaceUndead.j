library WoWReforgedRaceUndead initializer Init

globals
    private trigger spellEffectTrigger = CreateTrigger()
endglobals

private function TriggerConditionSpellEffect takes nothing returns boolean
    if (GetSpellAbilityId() == 'S008') then
        call SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit()), true)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(spellEffectTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(spellEffectTrigger, Condition(function TriggerConditionSpellEffect))
endfunction

endlibrary
