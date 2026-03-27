library WoWReforgedCreeps requires WoWReforgedNeutral, WoWReforgedProfessionHunter

function CompareCreeps takes nothing returns nothing
    local group g = CreateGroup()
    local unit u = null
    local integer max = GetCreepsMax()
    local integer i = 0
    local integer j = 0
    local integer max2 = 0
    local boolean found = false
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_AGGRESSIVE), null)
    loop
        exitwhen (i >= max)
        if (not IsCritter(GetCreep(i))) then
            set found = false
            set j = 0
            set max2 = BlzGroupGetSize(g)
            loop
                exitwhen (j >= max2 or found)
                set u = BlzGroupUnitAt(g, j)
                if (GetCreep(i) == GetUnitTypeId(u)) then
                    set found = true
                endif
                set u = null
                set j = j + 1
            endloop
            if (not found) then
                call BJDebugMsg("Missing creep type " + GetObjectName(GetCreep(i)))
            endif
        endif
        set i = i + 1
    endloop
    
    // critters
    call GroupClear(g)
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_PASSIVE), null)
    set i = 0
    loop
        exitwhen (i >= max)
        if (IsCritter(GetCreep(i))) then
            set found = false
            set j = 0
            set max2 = BlzGroupGetSize(g)
            loop
                exitwhen (j >= max2 or found)
                set u = BlzGroupUnitAt(g, j)
                if (GetCreep(i) == GetUnitTypeId(u)) then
                    set found = true
                endif
                set u = null
                set j = j + 1
            endloop
            if (not found) then
                call BJDebugMsg("Missing critter type " + GetObjectName(GetCreep(i)))
            endif
        endif
        set i = i + 1
    endloop
    call GroupClear(g)
    
    call DestroyGroup(g)
    set g = null
endfunction

endlibrary
