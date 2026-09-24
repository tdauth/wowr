library WoWReforgedRaceDungeon initializer Init

globals
    private trigger deathTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    if (GetKillingUnit() != null and IsUnitEnemy(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) and GetUnitTypeId(GetTriggerUnit()) == 'n0AO') then
        call UnitDropItem(GetTriggerUnit(), 'I0HA')
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
