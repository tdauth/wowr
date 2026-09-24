library WoWReforgedRaceSatyr initializer Init

globals
    private trigger constructFinish = CreateTrigger()
endglobals

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == SATYR_HOUSING) then
        call SetResourceAmount(GetConstructedStructure(), 1000000)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructFinish, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinish, Condition(function TriggerConditionConstructFinish))
endfunction

endlibrary
