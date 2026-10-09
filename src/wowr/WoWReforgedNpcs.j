library WoWReforgedNpcs

globals
    private group npcs = CreateGroup()
endglobals

function GetNpcs takes nothing returns group
    return npcs
endfunction

function AddNpc takes unit whichUnit returns nothing
    call GroupAddUnit(npcs, whichUnit)
endfunction

endlibrary
