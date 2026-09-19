library WoWReforgedRacePandaren initializer Init

globals
    private trigger spellFinishTrigger = CreateTrigger()
endglobals

private function TriggerConditionSpellFinish takes nothing returns boolean
    if (GetSpellAbilityId() == 'A13M') then // Drunk Panda
        call BlzSetUnitMaxHP(GetTriggerUnit(), BlzGetUnitMaxHP(GetTriggerUnit()) + 150)
        call SetUnitLifePercentBJ(GetTriggerUnit(), 100.0)
        call UnitRemoveAbility(GetTriggerUnit(), GetSpellAbilityId())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(spellFinishTrigger, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(spellFinishTrigger, Condition(function TriggerConditionSpellFinish))
endfunction

endlibrary
