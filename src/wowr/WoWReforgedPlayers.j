library WoWReforgedPlayers initializer Init requires ForceUtils, WoWReforgedBackpacks, WoWReforgedNeutralZone

globals
    private trigger leavesTrigger = CreateTrigger()
endglobals

private function EnumRegisterPlayerLeavesEvent takes nothing returns nothing
    call TriggerRegisterPlayerEvent(leavesTrigger, GetEnumPlayer(), EVENT_PLAYER_LEAVE)
endfunction

private function TriggerConditionLeave takes nothing returns boolean
    return GetPlayerController(GetTriggerPlayer()) == MAP_CONTROL_USER
endfunction

private function GetUserAlliesPlaying takes player whichPlayer returns force
    local force f = CreateForce()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and IsPlayerAlly(whichPlayer, Player(i))) then
            call ForceAddPlayer(f, Player(i))
        endif
        set i = i + 1
    endloop
    return f
endfunction

private function GetUserEnemiesPlaying takes player whichPlayer returns force
    local force f = CreateForce()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and IsPlayerEnemy(whichPlayer, Player(i))) then
            call ForceAddPlayer(f, Player(i))
        endif
        set i = i + 1
    endloop
    return f
endfunction

private function GetUserNeutralPlaying takes player whichPlayer returns force
    local force f = CreateForce()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING  and not IsPlayerAlly(whichPlayer, Player(i)) and not IsPlayerEnemy(whichPlayer, Player(i))) then
            call ForceAddPlayer(f, Player(i))
        endif
        set i = i + 1
    endloop
    return f
endfunction

private function TriggerActionLeave takes nothing returns nothing
    local force alliedUsersPlaying = GetUserAlliesPlaying(GetTriggerPlayer())
    local force enemyUsersPlaying = GetUserEnemiesPlaying(GetTriggerPlayer())
    local force neutralUsersPlaying = GetUserNeutralPlaying(GetTriggerPlayer())
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("PLAYER_LEFT_GAME")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    // TODO Enumerate All players and set alliance depending on the player.
    // Enemy Computer Players
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[PLAYER_NEUTRAL_AGGRESSIVE], bj_FORCE_PLAYER[playerId], bj_ALLIANCE_UNALLIED)
    // Allied Users
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], alliedUsersPlaying, bj_ALLIANCE_ALLIED_ADVUNITS)
    // Hostile Users
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], enemyUsersPlaying, bj_ALLIANCE_UNALLIED_VISION)
    // Neutral Users
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], neutralUsersPlaying, bj_ALLIANCE_NEUTRAL_VISION)
    // Votes
    // TODO Recalculate?
    // Heroes and Items
    call ResetAllHeroesToNeutralZone(GetTriggerPlayer())
    // Destroy the backpack since we cannot use it in full shared control properly
    call DestroyBackpackSystemForPlayer(GetTriggerPlayer())

    call ForceClear(alliedUsersPlaying)
    call DestroyForce(alliedUsersPlaying)
    set alliedUsersPlaying = null

    call ForceClear(enemyUsersPlaying)
    call DestroyForce(enemyUsersPlaying)
    set enemyUsersPlaying = null

    call ForceClear(neutralUsersPlaying)
    call DestroyForce(neutralUsersPlaying)
    set neutralUsersPlaying = null
endfunction

private function Init takes nothing returns nothing
    call ForForce(GetAllPlayingUsers(), function EnumRegisterPlayerLeavesEvent)
    call TriggerAddCondition(leavesTrigger, Condition(function TriggerConditionLeave))
    call TriggerAddAction(leavesTrigger, function TriggerActionLeave)
endfunction

endlibrary
