library HostUtils initializer Init

globals
    private player Host = null
endglobals

function InitHost takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set Host = Player(i)
            exitwhen (true)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

private function Init takes nothing returns nothing
    call InitHost()
endfunction

function GetHost takes nothing returns player
    if (Host == null or GetPlayerSlotState(Host) != PLAYER_SLOT_STATE_PLAYING) then
        call InitHost()
    endif

    return Host
endfunction

endlibrary
