library WoWReforgedUiBackpackUpdate initializer Init requires WoWReforgedUiBackpack

globals
    player updateBackpackUIPlayer = null
    trigger updateBackpackUITrigger = CreateTrigger()
endglobals

private function TriggerActionUpdateBackpackUI takes nothing returns nothing
    call UpdateItemsForBackpackUI(updateBackpackUIPlayer)
endfunction

private function Init takes nothing returns nothing
    call TriggerAddAction(updateBackpackUITrigger, function TriggerActionUpdateBackpackUI)
endfunction

endlibrary
