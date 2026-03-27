library WoWReforgedUiBackpackEvaluate

function UpdateItemsForBackpackUIEvaluate takes player whichPlayer returns nothing
    set updateBackpackUIPlayer = whichPlayer
    call TriggerExecute(updateBackpackUITrigger)
endfunction

endlibrary
