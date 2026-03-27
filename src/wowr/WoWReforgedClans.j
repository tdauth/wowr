library WoWReforgedClans requires PlayerColorUtils, ItemTypeUtils, TextTagUtils, WoWReforgedRaces

globals
    constant integer SAVE_CODE_MAX_CLAN_MEMBERS = 6
endglobals

function GetPlayerClan takes player whichPlayer returns integer
    return udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)]
endfunction

function PlayerHasClan takes player whichPlayer returns boolean
    return GetPlayerClan(whichPlayer) != 0
endfunction

function GetClanName takes integer clan returns string
    return udg_ClanName[clan]
endfunction

function GetClanIcon takes integer clan returns integer
    return udg_ClanIcon[clan]
endfunction

function GetClanIconPath takes integer clan returns string
    return GetItemTypeIcon(GetClanIcon(clan))
endfunction

function GetClanSound takes integer clan returns sound
    return udg_ClanSound[clan]
endfunction

function GetClanRankName takes integer rank returns string
    if (rank == udg_ClanRankLeader) then
        return GetLocalizedString("LEADER")
    elseif (rank == udg_ClanRankCaptain) then
        return GetLocalizedString("CAPTAIN")
    else
        return GetLocalizedString("MEMBER")
    endif
endfunction

globals
    private timer clanResourceTimer = CreateTimer()
    private boolean clanResourceTimerStarted = false
endglobals

function GetClanResourceTimerHandleId takes nothing returns integer
    return GetHandleId(clanResourceTimer)
endfunction

private function ShowClanResourcesFromAiTextTag takes integer clan, integer gold, integer lumber, force f returns nothing
    local unit clanHall = udg_ClanHall[clan]
    local integer startLocation = GetPlayerStartLocation(udg_ClanAIPlayer[clan])
    local real x = GetStartLocationX(startLocation)
    local real y = GetStartLocationY(startLocation)
    if (clanHall != null) then
        set x = GetUnitX(clanHall)
        set y = GetUnitY(clanHall)
        set clanHall = null
    endif
    call ShowGeneralFadingTextTagForForce(f, Format(GetLocalizedString("CLAN_RESOURCES_FROM_AI")).s(GetPlayerNameColored(udg_ClanAIPlayer[clan])).i(gold).i(lumber).result(), x, y, 255, 255, 255, 0)
endfunction

private function TimerFunctionClanResources takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local integer gold = 0
    local integer lumber = 0
    local player slotPlayer = null
    local force f = CreateForce()
    loop
        exitwhen (i == udg_ClanCounter)
        if (udg_ClanAIPlayer[i] != null) then
            set gold = IMinBJ(100, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD))
            set lumber = IMinBJ(100, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER))
            call ForceClear(f)

            set j = 0
            loop
                exitwhen (j == bj_MAX_PLAYERS)
                set slotPlayer = Player(j)
                if (IsPlayerInForce(slotPlayer, udg_ClanPlayers[i])) then
                    if (gold > 0) then
                        call SetPlayerStateBJ(slotPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(slotPlayer, PLAYER_STATE_RESOURCE_GOLD) + gold / CountPlayersInForceBJ(udg_ClanPlayers[i]))
                    endif
                    if (lumber > 0) then
                        call SetPlayerStateBJ(slotPlayer, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(slotPlayer, PLAYER_STATE_RESOURCE_LUMBER) + lumber / CountPlayersInForceBJ(udg_ClanPlayers[i]))
                    endif
                    if (udg_ClanShowAIResourcesMessage[GetConvertedPlayerId(slotPlayer)] and gold > 0 or lumber > 0) then
                        call ForceAddPlayer(f, slotPlayer)
                    endif
                endif
                set slotPlayer = null
                set j = j + 1
            endloop
            
            call ShowClanResourcesFromAiTextTag(i, gold, lumber, f)

            // do not remove the resources to limit the player
            //if (gold > 0) then
                //call SetPlayerStateBJ(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD) - gold)
            //endif
            //if (lumber > 0) then
                //call SetPlayerStateBJ(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER) - lumber)
            //endif
        endif
        set i = i + 1
    endloop
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

// Chooses one AI player to share gold and lumber with all clan players every X seconds.
function PickClanAIPlayer takes integer clan returns player
    local player result = null
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (slotPlayer != udg_BossesPlayer and slotPlayer != udg_Gaia and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            if (result == null) then
                set result = slotPlayer
            // prefer warlords due to more gold and lumber
            elseif (result != null and udg_PlayerIsWarlord[GetConvertedPlayerId(slotPlayer)] and not udg_PlayerIsWarlord[GetConvertedPlayerId(result)]) then
                set result = slotPlayer
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop

    if (result != null) then
        set udg_ClanAIPlayer[clan] = result
        call TimerStart(clanResourceTimer, 300.0, true, function TimerFunctionClanResources)
        set i = 0
        loop
            exitwhen (i == bj_MAX_PLAYERS)
            set slotPlayer = Player(i)
            if (IsPlayerInForce(slotPlayer, udg_ClanPlayers[clan])) then
                set udg_ClanShowAIResourcesMessage[GetConvertedPlayerId(slotPlayer)] = true
            endif
            set slotPlayer = null
            set i = i + 1
        endloop
    endif

    return result
endfunction

function GetClanPlayerNames takes integer clan returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
            if (counter > 0) then
                set result = result + ", "
            endif
            set result = result + GetPlayerNameColored(Player(i))
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetClansInfo takes nothing returns string
    local string result = GetLocalizedString("CLANS_MESSAGE")
    local integer i = 1
    loop
        exitwhen (i >= udg_ClanCounter)
        set result = result + Format(GetLocalizedString("CLANS_ITEM")).s(udg_ClanName[i]).i(CountPlayersInForceBJ(udg_ClanPlayers[i])).s(GetClanPlayerNames(i)).result()
        set i = i + 1
    endloop
    return result
endfunction

endlibrary
