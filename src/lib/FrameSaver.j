library FrameSaver initializer Init

globals
    private constant real DELAY = 5.0
    private trigger saveTrigger = CreateTrigger()
    private trigger loadTrigger = CreateTrigger()
    private trigger afterSaveTrigger = CreateTrigger()
    private timer t = CreateTimer()
endglobals

function FrameSaverAdd takes code func returns nothing
    call TriggerAddAction(saveTrigger, func)
endfunction

function FrameSaverAddEx takes code func, code func2 returns nothing
    call FrameSaverAdd(func)
    call TriggerAddAction(afterSaveTrigger, func2)
endfunction

private function TimerFunctionAfterSave takes nothing returns nothing
    call TriggerExecute(afterSaveTrigger)
endfunction

private function TriggerActionStartAfterSaveTimer takes nothing returns nothing
    call TimerStart(t, DELAY, false, function TimerFunctionAfterSave)
endfunction

private function TriggerActionCancelAfterSaveTimer takes nothing returns nothing
    call PauseTimer(t)
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterGameEvent(saveTrigger, EVENT_GAME_SAVE)    
    call TriggerAddAction(saveTrigger, function TriggerActionStartAfterSaveTimer)
    
    call TriggerRegisterGameEvent(loadTrigger, EVENT_GAME_LOADED)    
    call TriggerAddAction(loadTrigger, function TriggerActionCancelAfterSaveTimer)
endfunction

endlibrary
