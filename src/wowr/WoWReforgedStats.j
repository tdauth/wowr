library WoWReforgedStats requires StringUtils, PlayerColorUtils, ForceUtils, WoWReforgedUtils, WoWReforgedEvolution, WoWReforgedI18n

globals
    private constant real UPDATE_INTERVAL = 5.0

    private multiboard m = null
    private timer t = CreateTimer()
    private integer currentRow = 0
    private force f = CreateForce()
endglobals

function GetStatsTimerHandleId takes nothing returns integer
    return GetHandleId(t)
endfunction

function SetStatsMultiboardVisible takes player whichPlayer, boolean show returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call MultiboardDisplay(m, show)
    endif
endfunction

function ShowStatsMultiboard takes player whichPlayer returns nothing
    call SetStatsMultiboardVisible(whichPlayer, true)
endfunction

function HideStatsMultiboard takes player whichPlayer returns nothing
    call SetStatsMultiboardVisible(whichPlayer, false)
endfunction

function FixStatsMultiboardTitleColor takes nothing returns nothing
    call MultiboardSetTitleTextColorBJ(m, 100, 80, 20, 0)
endfunction

private function ForFunctionUpdateStats takes nothing returns nothing
    local multiboarditem mitem = null
    local player whichPlayer = GetEnumPlayer()
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    local boolean isUser = GetPlayerController(whichPlayer) == MAP_CONTROL_USER
    local boolean isWarlord = udg_PlayerIsWarlord[convertedPlayerId]
    local integer goldUpkeepRate = GetPlayerState(whichPlayer, PLAYER_STATE_GOLD_UPKEEP_RATE)
    local integer itemTypeId = 0
    local integer column = 0
    // Player name plus color and numer
    local string text = GetPlayerNameColored(whichPlayer)
    local integer value = 0
    if (isUser and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_LEFT) then
        set text = Format(GetLocalizedString("STATS_LEFT")).s(text).result()
    elseif (GetPlayerState(whichPlayer, PLAYER_STATE_GAME_RESULT) == 1) then
        set text = Format(GetLocalizedString("STATS_DEFEATED")).s(text).result()
    endif
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemValue(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Team
    set column = column + 1
    set text = I2S(GetPlayerTeam(whichPlayer) + 1)
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemValue(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Game Mode/Race 1
    set column = column + 1
    if (whichPlayer != udg_BossesPlayer) then
        if (isWarlord) then
            set value = udg_PlayerRace[convertedPlayerId]
            set text = GetIconByRace(value)
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, text)
            call MultiboardReleaseItem(mitem)
        else
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, "ReplaceableTextures\\CommandButtons\\BTNMercenaryCamp.blp")
            call MultiboardReleaseItem(mitem)
        endif
    endif
    // Race 2
    set column = column + 1
    if (isUser) then
        if (isWarlord) then
            set value = udg_PlayerRace2[convertedPlayerId]
            set text = GetIconByRace(value)
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, text)
            call MultiboardReleaseItem(mitem)
        else
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, "ReplaceableTextures\\CommandButtons\\BTNMercenaryCamp.blp")
            call MultiboardReleaseItem(mitem)
        endif
    endif
    // Race 3
    set column = column + 1
    if (isUser) then
        if (isWarlord) then
            set value = udg_PlayerRace3[convertedPlayerId]
            set text = GetIconByRace(value)
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, text)
            call MultiboardReleaseItem(mitem)
        else
            set mitem = MultiboardGetItem(m, currentRow, column)
            call MultiboardSetItemIcon(mitem, "ReplaceableTextures\\CommandButtons\\BTNMercenaryCamp.blp")
            call MultiboardReleaseItem(mitem)
        endif
    endif
    // Profession 1
    set column = column + 1
    set value = udg_PlayerProfession[convertedPlayerId]
    set text = GetIconByProfession(value)
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Profession 2
    set column = column + 1
    set value = udg_PlayerProfession2[convertedPlayerId]
    set text = GetIconByProfession(value)
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Profession 3
    set column = column + 1
    set value = udg_PlayerProfession3[convertedPlayerId]
    set text = GetIconByProfession(value)
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Hero Icon/Level 1
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemStyle(mitem, true, true)
    set text = I2S(GetHeroLevel(udg_Held[convertedPlayerId]))
    call MultiboardSetItemValue(mitem, text)
    set value = GetUnitTypeId(udg_Held[convertedPlayerId])
    set text = GetIconByUnitType(value)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Hero Icon/Level  2
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemStyle(mitem, true, true)
    set text = I2S(GetHeroLevel(udg_Held2[convertedPlayerId]))
    call MultiboardSetItemValue(mitem, text)
    set value = GetUnitTypeId(udg_Held2[convertedPlayerId])
    set text = GetIconByUnitType(value)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Hero Icon/Level  3
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    call MultiboardSetItemStyle(mitem, true, true)
    set text = I2S(GetHeroLevel(udg_Held3[convertedPlayerId]))
    call MultiboardSetItemValue(mitem, text)
    set value = GetUnitTypeId(udg_Held3[convertedPlayerId])
    set text = GetIconByUnitType(value)
    call MultiboardSetItemIcon(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Gold
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    set text = I2S(GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD))
    call MultiboardSetItemValue(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Lumber
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    set text = I2S(GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER))
    call MultiboardSetItemValue(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Food
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    set text = I2S(GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED)) + "/" + I2S(IMinBJ(GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP), GetPlayerState(whichPlayer, PLAYER_STATE_FOOD_CAP_CEILING)))
    call MultiboardSetItemValue(mitem, text)
    if (goldUpkeepRate == 0) then
        call MultiboardSetItemValueColor(mitem, PercentTo255(0.0), PercentTo255(100.00), PercentTo255(0.0), 255)
    else
        if (goldUpkeepRate >= 60) then
            call MultiboardSetItemValueColor(mitem, PercentTo255(100.0), PercentTo255(0.00), PercentTo255(0.0), 255)
        else
            call MultiboardSetItemValueColor(mitem, PercentTo255(100.0), PercentTo255(80.00), PercentTo255(20.0), 255)
        endif
    endif
    call MultiboardReleaseItem(mitem)
    // Evolution
    set column = column + 1
    set mitem = MultiboardGetItem(m, currentRow, column)
    set text = I2S(GetEvolutionLevelOfPlayer(whichPlayer))
    call MultiboardSetItemValue(mitem, text)
    call MultiboardReleaseItem(mitem)
    // Increase row
    set currentRow = currentRow + 1
    set whichPlayer = null
endfunction

function UpdateStats takes nothing returns nothing
    local string mode = ""
    if (IsInSinglePlayer()) then
        set mode = GetLocalizedString("SINGLEPLAYER")
    else
        set mode = GetLocalizedString("MULTIPLAYER")
    endif
    call MultiboardSetTitleText(m, Format(GetLocalizedString("STATS_TITLE")).s(mode).s(MAP_VERSION).i(GetAllPlayingUsersCount()).i(GetAllUsersCount()).result())
    set currentRow = 0
    call ForForce(f, function ForFunctionUpdateStats)
endfunction

function PauseStats takes nothing returns nothing
    call PauseTimer(t)
endfunction

function ResumeStats takes nothing returns nothing
    call TimerStart(t, UPDATE_INTERVAL, true, function UpdateStats)
    call UpdateStats()
endfunction

function CreateStats takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    local multiboarditem mitem = null
    local integer column = 0
    local integer row = 0
    local integer red = 0
    local integer green = 0
    local integer blue = 0
    local boolean isUser = false
    if (m != null) then
        call DestroyMultiboard(m)
    endif
    call ForceClear(f)
    call ForceAddForce(f, GetPlayersAll())
    call ForceRemovePlayer(f, udg_BossesPlayer)
    
    set m = CreateMultiboard()
    call MultiboardSetRowCount(m, CountPlayersInForceBJ(f))
    call MultiboardSetColumnCount(m, 15)
    call MultiboardSetTitleText(m, GetLocalizedString("STATS"))
    call MultiboardDisplay(m, true)
    set i = 0
    set row = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerInForce(slotPlayer, f)) then
            set isUser = GetPlayerController(slotPlayer) == MAP_CONTROL_USER
            set red = GetPlayerColorRed(GetPlayerColor(slotPlayer))
            set green = GetPlayerColorGreen(GetPlayerColor(slotPlayer))
            set blue = GetPlayerColorBlue(GetPlayerColor(slotPlayer))
            set column = 0
            // player name plus color and number
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, false)
            call MultiboardSetItemWidth(mitem, 0.14)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Team
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, false)
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Game Mode/Race 1
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, true)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Race 2
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, isUser)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Race 3
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, isUser)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Profession 1
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, true)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Profession 2
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, isUser)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Profession 3
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, false, isUser)
            call MultiboardSetItemWidth(mitem, 0.01)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Hero Level 1
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.04)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Hero Level 2
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.04)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Hero Level 3
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.04)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Gold
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemIcon(mitem, "UI\\Feedback\\Resources\\ResourceGold.blp")
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.06)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Lumber
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemIcon(mitem, "UI\\Feedback\\Resources\\ResourceLumber.blp")
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.06)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Food
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemIcon(mitem, "UI\\Feedback\\Resources\\ResourceSupply.blp")
            call MultiboardSetItemWidth(mitem, 0.05)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Evolution
            set mitem = MultiboardGetItem(m, row, column)
            call MultiboardSetItemStyle(mitem, true, true)
            call MultiboardSetItemIcon(mitem, "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp")
            call MultiboardSetItemValueColor(mitem, red, green, blue, 255)
            call MultiboardSetItemWidth(mitem, 0.03)
            call MultiboardReleaseItem(mitem)
            set column = column + 1
            // Increase row
            set row = row + 1
        endif
        set i = i + 1
    endloop
    call MultiboardMinimize(m, true)
    call ResumeStats()
endfunction

function DestroyStats takes nothing returns nothing
    if (m != null) then
        call DestroyMultiboard(m)
        set m = null
    endif
endfunction

endlibrary
