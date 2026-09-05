library WoWReforgedItemArrows initializer Init requires SimError

globals
    private trigger useItemTrigger = CreateTrigger()
endglobals

private function TriggerConditionUseItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == ITEM_ARROWS) then
        if (GetUnitAbilityLevel(GetTriggerUnit(), 'A1R4') == 0) then
            call UnitAddAbility(GetTriggerUnit(), 'A1R4')
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("ALREADY_USED"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(useItemTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(useItemTrigger, Condition(function TriggerConditionUseItem))
endfunction

endlibrary

