library WoWReforgedCitizens initializer Init

globals
    constant integer ABILITY_ID_WANDERING = 'Awan'
    constant integer ABILITY_ID_ENABLE_WANDERING = 'A0PH'
    constant integer ABILITY_ID_DISABLE_WANDERING = 'A0PI'

    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID_DISABLE_WANDERING) then
        call UnitAddAbility(GetTriggerUnit(), ABILITY_ID_WANDERING)
        call UnitRemoveAbility(GetTriggerUnit(), ABILITY_ID_DISABLE_WANDERING)
        call UnitAddAbility(GetTriggerUnit(), ABILITY_ID_DISABLE_WANDERING)
        call ResetUnitAnimation(GetTriggerUnit())
    elseif (GetSpellAbilityId() == ABILITY_ID_DISABLE_WANDERING) then
        call UnitRemoveAbility(GetTriggerUnit(), ABILITY_ID_WANDERING)
        call UnitRemoveAbility(GetTriggerUnit(), ABILITY_ID_DISABLE_WANDERING)
        call UnitAddAbility(GetTriggerUnit(), ABILITY_ID_ENABLE_WANDERING)
        call ResetUnitAnimation(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
