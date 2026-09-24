library WoWReforgedRaceKobold initializer Init

globals
    private trigger deathTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    if (GetUnitAbilityLevel(GetTriggerUnit(), 'A0X4') > 0) then
        call UnitDropItem(GetTriggerUnit(), 'I0FT')
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
