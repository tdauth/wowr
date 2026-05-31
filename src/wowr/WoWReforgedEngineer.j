library WoWReforgedEngineer initializer Init
// The base unit has to be able to build everything so they other forms can build their buildings.

globals
    private trigger sellTrigger = CreateTrigger()
endglobals

function TriggerConditionSell takes nothing returns boolean
    if (GetUnitTypeId(GetSoldUnit()) == 'n09Q') then
        call UnitAddAbility(GetSoldUnit(), 'A0S4')
        call UnitRemoveAbility(GetSoldUnit(), 'A0S4')
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
endfunction

endlibrary
