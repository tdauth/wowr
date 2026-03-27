library OnStartGame initializer Init

globals
    private trigger startGameTrigger = CreateTrigger()
endglobals

function OnStartGame takes code func returns nothing
    call TriggerAddAction(startGameTrigger, func)
endfunction

private function TimerFunctionStartGame takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call TriggerExecute(startGameTrigger)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 0.0, false, function TimerFunctionStartGame)
endfunction

endlibrary
