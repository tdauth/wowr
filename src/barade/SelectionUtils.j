library SelectionUtils

function GetNextUnitToSelect takes group g, player whichPlayer returns unit
    local integer max = BlzGroupGetSize(g)
    local integer i = 0
    local unit u = null
    local unit result = null
    local boolean found = false
    if (max > 0) then
        loop
            exitwhen (i == max)
            set u = BlzGroupUnitAt(g, i)
            if (IsUnitSelected(u, whichPlayer)) then
                set found = true
            elseif (found) then
                set result = u
            endif
            set u = null
            set i = i + 1
        endloop
    
        // this happens if none of them is selected or the last one
        if (result == null) then
            set result = BlzGroupUnitAt(g, 0) // start at first
        endif
    endif
    
    return result
endfunction

function GetUnitsSelectedAllSafe takes player whichPlayer returns group
    local group g = CreateGroup()
    //call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    call GroupEnumUnitsSelected(g, whichPlayer, null)
    return g
endfunction

endlibrary
