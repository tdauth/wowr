library WoWReforgedSpellMultiTier initializer Init

globals
    private trigger deathTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    if (GetUnitAbilityLevel(GetKillingUnit(), 'A1HO') > 0 and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetKillingUnit()))) then
        if (GetUnitTypeId(GetKillingUnit()) == 'n0FU') then
            call ReplaceUnitBJ(GetKillingUnit(), 'n0FV', bj_UNIT_STATE_METHOD_RELATIVE)
        elseif (GetUnitTypeId(GetKillingUnit()) == 'n0FV') then
            call ReplaceUnitBJ(GetKillingUnit(), 'n0FW', bj_UNIT_STATE_METHOD_RELATIVE)
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
