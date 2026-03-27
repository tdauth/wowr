library DiplomacyUIConfig

public function IsPlayerAllowed takes player whichPlayer returns boolean
    local integer playerId = GetPlayerId(whichPlayer)
    return playerId != PLAYER_RESCUABLE and playerId != PLAYER_BOSSES
endfunction

public function GetValidPlayers takes nothing returns force
    local force f = CreateForce()
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) != PLAYER_SLOT_STATE_EMPTY and IsPlayerAllowed(slotPlayer)) then
            call ForceAddPlayer(f, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    return f
endfunction

endlibrary
