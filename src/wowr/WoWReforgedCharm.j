library WoWReforgedCharm initializer Init

globals
    private trigger changeOwnerTrigger = CreateTrigger()
endglobals

private function TriggerConditionChangeOwner takes nothing returns boolean
    if (IsUnitType(GetChangingUnit(), UNIT_TYPE_PEON)) then
        call DisableTrigger(GetTriggeringTrigger())
        call SetUnitOwner(GetChangingUnit(), GetChangingUnitPrevOwner(), true)
        call EnableTrigger(GetTriggeringTrigger())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))
endfunction

endlibrary
