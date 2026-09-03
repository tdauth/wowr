library WoWReforgedItemWeatherBalloon initializer Init requires WoWReforgedCalendar

globals
    private trigger useItemTrigger = CreateTrigger()
endglobals

private function TriggerConditionUseItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == 'I145') then
        call WeatherPrediction(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(useItemTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(useItemTrigger, Condition(function TriggerConditionUseItem))
endfunction

endlibrary
