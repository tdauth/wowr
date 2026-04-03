library WoWReforgedVIPs initializer Init requires PlayerColorUtils, UnitGroupUtils, SafeString, OnStartGame, WoWReforgedUtils, WoWReforgedI18n, WoWReforgedMapData

globals
    private integer vipCounter = 0
    private string array vips
    
    private force vipPlayers = CreateForce()
endglobals

function GetVIPsMax takes nothing returns integer
    return vipCounter
endfunction

function GetVIP takes integer index returns string
    return vips[index]
endfunction

function IsAccountVIP takes string account returns boolean
    local integer i = 0
    loop
        exitwhen (i >= vipCounter)
        if (StringCase(vips[i], false) == StringCase(account, false)) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function IsPlayerVIP takes player whichPlayer returns boolean
    return IsPlayerInForce(whichPlayer, vipPlayers)
endfunction

private function WelcomeVIPs takes nothing returns nothing
    local player slotPlayer = null
    local string txt = null
    local integer i = 0
    local integer max = GetMapMaxLobbyPlayers()
    loop
        exitwhen (i >= max)
        set slotPlayer = Player(i)
        if (IsPlayerVIP(slotPlayer)) then
            if (txt != null) then
                set txt = txt + ", "
            endif
            set txt = txt + GetPlayerNameColored(slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call QuestMessageBJ(GetAllPlayingUsers(), bj_QUESTMESSAGE_ALWAYSHINT, Format(GetLocalizedStringSafe("VIP_WELCOME")).s(txt).result())
    call PlaySoundBJ(gg_snd_UtherReturns)
endfunction

function UpdateResearchesForVIP takes player whichPlayer returns nothing
    if (IsPlayerVIP(whichPlayer)) then
        call SetPlayerTechResearched(whichPlayer, UPG_BONUS_HEROES, 1)
        call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_75_VIP, 1)
        call SetPlayerTechResearched(whichPlayer, UPG_VIP, 1)
    endif
endfunction

private function GetVIPsInfoText takes nothing returns string
    local string text = "VIPS:"
    local integer i = 0
    loop
        exitwhen (i >= vipCounter)
        set text = text + "\n- " + vips[i]
        set i = i + 1
    endloop
    return text
endfunction

function DisplayVIPs takes player to returns nothing
    local string text = GetVIPsInfoText()
    call DisplayTimedTextToPlayer(to, 0.0, 0.0, 6.0, text)
endfunction

private function AddVIP takes string vip returns integer
    local integer index = vipCounter
    set vips[index] = vip
    set vipCounter = vipCounter + 1

    return index
endfunction

function AddVIPMercenaryCamp takes unit u returns nothing
    call SetItemTypeSlots(u, 0)
    call SetUnitTypeSlots(u, 11)
    call AddUnitToStock(u, FELLHOUND, 100, 100)
    call AddUnitToStock(u, DOOMGUARD, 100, 100)
    call AddUnitToStock(u, INFERNAL, 100, 100)
    call AddUnitToStock(u, HELLCALLER, 100, 100)
    call AddUnitToStock(u, BLACK_DRAGON, 100, 100)
    call AddUnitToStock(u, BRONZE_DRAGON, 100, 100)
    call AddUnitToStock(u, BLUE_DRAGON, 100, 100)
    call AddUnitToStock(u, GREEN_DRAGON, 100, 100)
    call AddUnitToStock(u, NETHER_DRAGON, 100, 100)
    call AddUnitToStock(u, RED_DRAGON, 100, 100)
endfunction

private function SyncVIPsFromPlayers takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsAccountVIP(GetPlayerName(slotPlayer))) then
            set udg_VIPOnForPlayer[i + 1] = true
            call ForceAddPlayer(vipPlayers, slotPlayer)
            call UpdateResearchesForVIP(slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call WelcomeVIPs()
endfunction

private function Init takes nothing returns nothing
    // Shame on you for adding yourself here! Support the project!
static if (MAP_DEBUG_MODE_ENABLED) then
    call AddVIP("Barade")
    call AddVIP("WorldEdit")
endif
    call AddVIP("Barade#2569")
    call AddVIP("Runeblade14")
    call AddVIP("Runeblade14#2451")
    call AddVIP("Antidenseman#1202")
    call AddVIP("Chaoskrieger#21738")
    call AddVIP("Etos7#2138")
    
    // Do after starting the game because of the message and initialization of a global variable from GUI.
    call OnStartGame(function SyncVIPsFromPlayers)
endfunction

endlibrary
