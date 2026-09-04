library WoWReforgedItemQuiver initializer Init

globals
    private trigger useItemTrigger = CreateTrigger()
    private trigger attackTrigger = CreateTrigger()
endglobals

private function TriggerConditionUseItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == ITEM_QUIVER) then
        if (GetUnitAbilityLevel(GetTriggerUnit(), 'A1R4') == 0) then
            call UnitAddAbility(GetTriggerUnit(), 'A1R4')
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("ALREADY_USED"))
        endif
    endif
    return false
endfunction

private function TriggerConditionAttack takes nothing returns boolean
    if (GetUnitAbilityLevel(GetAttacker(), 'A1R4') > 0) then // Item Attack Speed Bonus (Quiver)
        call UnitRemoveAbility(GetAttacker(), 'A1R4')
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(useItemTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(useItemTrigger, Condition(function TriggerConditionUseItem))

    call TriggerRegisterAnyUnitEventBJ(attackTrigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(attackTrigger, Condition(function TriggerConditionAttack))
endfunction

endlibrary
