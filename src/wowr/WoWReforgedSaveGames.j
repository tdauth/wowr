library WoWReforgedSaveGames initializer Init requires WoWReforgedStats, WoWReforgedCalendar

globals
    private trigger loadedTrigger = CreateTrigger()
endglobals

private function TriggerActionLoaded takes nothing returns nothing
    // Recreates all UIs which are corrupted since Warcraft III does not save frames properly.
    // Somehow Warcraft changes the title color to white after loading a save game.
    call FixStatsMultiboardTitleColor()
    call FixCalendarMultiboardTitleColor()
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterGameEvent(loadedTrigger, EVENT_GAME_LOADED)
    call TriggerAddAction(loadedTrigger, function TriggerActionLoaded)
endfunction

endlibrary
