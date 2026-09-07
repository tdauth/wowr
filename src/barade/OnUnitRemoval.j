library OnUnitRemoval initializer Init requires Indexer

/*
 * Register callbacks for unit removals not depending on a specific unit indexer system.
 * Safer than using hook RemoveUnit MyFunction since BJ functions will not be affected by vJass hooks.
 */

function interface OnUnitRemovalFunctionInterface takes unit whichUnit returns nothing

globals
    private OnUnitRemovalFunctionInterface array callbacks
    private integer callbacksCounter = 0
endglobals

function OnUnitRemoval takes OnUnitRemovalFunctionInterface f returns nothing
    set callbacks[callbacksCounter] = f
    set callbacksCounter = callbacksCounter + 1
endfunction

private function OnDeindex takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbacksCounter)
        call callbacks[i].evaluate(GetIndexUnit())
        set i = i + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    call RegisterUnitDeindexEvent(function OnDeindex)
endfunction

endlibrary