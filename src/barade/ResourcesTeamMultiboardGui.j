library ResourcesTeamMultiboardGui initializer Init requires MathUtils, OnStartGame, Resources

globals
    public constant real TIMER_INTERVAL = 0.5
    public constant boolean INCLUDE_VIEWING_PLAYERS = true
    public constant real NAME_COLUMN_WIDTH = 0.1
    public constant real RESOURCE_COLUMN_WIDTH = 0.07
    public constant real FOOD_COLUMN_WIDTH = 0.06
    private multiboard array playerMultiboards
    private boolean array playerIgnoredMultiboards
    private timer t = CreateTimer()
    private trigger allianceChangeTrigger = CreateTrigger()
endglobals

function IsPlayerIgnoredForTeamResourceMultiboard takes player whichPlayer, player forPlayer returns boolean
    return playerIgnoredMultiboards[Index2D(GetPlayerId(whichPlayer), GetPlayerId(forPlayer), bj_MAX_PLAYERS)]
endfunction

function GetPlayerTeamResourceMultiboard takes player whichPlayer returns multiboard
    return playerMultiboards[GetPlayerId(whichPlayer)]
endfunction

private function CountAlliesWithSharedControl takes player whichPlayer returns integer
    local integer count = 0
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
static if (INCLUDE_VIEWING_PLAYERS) then
         if (slotPlayer == whichPlayer) then
            set count = count + 1
         endif
endif
        if (slotPlayer != whichPlayer and GetPlayerAlliance(slotPlayer, whichPlayer, ALLIANCE_SHARED_CONTROL) or GetPlayerAlliance(slotPlayer, whichPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) and not IsPlayerIgnoredForTeamResourceMultiboard(slotPlayer, whichPlayer)) then
            set count = count + 1
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    return count
endfunction

private function IsAlliedPlayerWithSharedControl takes player viewingPlayer, player alliedPlayer returns boolean
static if (INCLUDE_VIEWING_PLAYERS) then
    if (viewingPlayer == alliedPlayer) then
        return true
    endif
endif
    return viewingPlayer != alliedPlayer and GetPlayerAlliance(alliedPlayer, viewingPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)
endfunction

function UpdatePlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    local multiboard mb = GetPlayerTeamResourceMultiboard(whichPlayer)
    local multiboarditem it = null
    local integer column = 1
    local integer percentage = 0
    local integer j = 0
    local integer max = GetMaxResources()
    local player slotPlayer = null
    local Resource r = 0
    local integer row = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (not IsPlayerIgnoredForTeamResourceMultiboard(slotPlayer, whichPlayer) and IsAlliedPlayerWithSharedControl(whichPlayer, slotPlayer)) then
            set column = 1
            set j = 0
            loop
                exitwhen (j == max)
                set r = GetResource(j)
                if (r != Resources_FOOD_MAX) then
                    set it = MultiboardGetItem(mb, row, column)
                    if (r == Resources_FOOD) then
                        call MultiboardSetItemValue(it, I2S(GetPlayerResource(slotPlayer, r)) + "/" + I2S(GetPlayerResource(slotPlayer, Resources_FOOD_MAX)))
                    else
                        call MultiboardSetItemValue(it, I2S(GetPlayerResource(slotPlayer, r)))
                    endif
                    
                    if (r != Resources_GOLD and r != Resources_LUMBER) then
                        if (r == Resources_FOOD) then
                            set percentage = 100 - GetPlayerResourceUpkeepRate(slotPlayer, Resources_GOLD)
                        else
                            set percentage = 100 - GetPlayerResourceUpkeepRate(slotPlayer, r)
                        endif
                        if (percentage <= 40) then
                            call MultiboardSetItemValueColor(it, 255, 0, 0, 0)
                        elseif (percentage <= 70) then
                            call MultiboardSetItemValueColor(it, 255, 204, 0, 0)
                        elseif (r == Resources_FOOD) then
                            call MultiboardSetItemValueColor(it, 0, 255, 0, 0)
                        else
                            call MultiboardSetItemValueColor(it, 255, 255, 255, 0)
                        endif
                    endif
                    
                    call MultiboardReleaseItem(it)
                    set column = column + 1
                    set it = null
                endif
                set j = j + 1
            endloop
            set row = row + 1
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

function UpdateAllTeamResourceMultiboards takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (playerMultiboards[i] != null) then
            call UpdatePlayerTeamResourceMultiboard(Player(i))
        endif
        set i = i + 1
    endloop
endfunction

function PauseTeamResourceMultiboardsUpdates takes nothing returns nothing
    call PauseTimer(t)
endfunction

function ResumeTeamResourceMultiboardsUpdates takes nothing returns nothing
    call ResumeTimer(t)
endfunction

function ShowPlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay(GetPlayerTeamResourceMultiboard(whichPlayer), true)
endfunction

function HidePlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay(GetPlayerTeamResourceMultiboard(whichPlayer), false)
endfunction

function ShowAllTeamResourceMultiboards takes nothing returns nothing
     local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call MultiboardDisplay(GetPlayerTeamResourceMultiboard(Player(i)), false)
        set i = i + 1
    endloop
endfunction

function HideAllTeamResourceMultiboards takes nothing returns nothing
     local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call MultiboardDisplay(GetPlayerTeamResourceMultiboard(Player(i)), false)
        set i = i + 1
    endloop
endfunction

function CreateTeamResourceMultiboards takes player whichPlayer returns multiboard
    local multiboarditem it = null
    local integer row = 0
    local integer column = 0
    local Resource r = 0
    local integer i = 0
    local integer j = 0
    local player slotPlayer = null
    local integer max = GetMaxResources()
    local integer columns = max
    local integer rows = CountAlliesWithSharedControl(whichPlayer)
    local multiboard mb = CreateMultiboardBJ(columns, rows, GetLocalizedString("TEAM_RESOURCES"))
    call MultiboardSetTitleTextColor(mb, 240, 240, 16, 0)
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (not IsPlayerIgnoredForTeamResourceMultiboard(slotPlayer, whichPlayer) and IsAlliedPlayerWithSharedControl(whichPlayer, slotPlayer)) then
            set column = 0
            set it = MultiboardGetItem(mb, row, column)
            call MultiboardSetItemStyle(it, true, false)
            call MultiboardSetItemWidth(it, NAME_COLUMN_WIDTH)
            call MultiboardSetItemValue(it, GetPlayerName(slotPlayer))
            call MultiboardSetItemValueColor(it, GetPlayerColorRed(GetPlayerColor(slotPlayer)), GetPlayerColorGreen(GetPlayerColor(slotPlayer)), GetPlayerColorBlue(GetPlayerColor(slotPlayer)), 0)
            call MultiboardReleaseItem(it)
            set column = column + 1
            set j = 0
            
            loop
                exitwhen (column == columns)
                set r = GetResource(j)

                if (r != Resources_FOOD_MAX) then
                    set it = MultiboardGetItem(mb, row, column)
                    call MultiboardSetItemStyle(it, true, true)
                    call MultiboardSetItemValue(it, "0")
                    call MultiboardSetItemIcon(it, GetResourceIcon(r))
                    if (r == Resources_FOOD) then
                        call MultiboardSetItemWidth(it, FOOD_COLUMN_WIDTH)
                    else
                        call MultiboardSetItemWidth(it, RESOURCE_COLUMN_WIDTH)
                    endif
                    call MultiboardReleaseItem(it)
                    set column = column + 1
                endif
                set j = j + 1
            endloop
            
             set row = row + 1
        endif
        set slotPlayer = null
        
        set i = i + 1
    endloop
    call MultiboardDisplay(mb, GetLocalPlayer() == whichPlayer)
    call MultiboardMinimize(mb, false)
    
    return mb
endfunction

function RecreateTeamResourceMultiboardForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    if (playerMultiboards[playerId] != null) then
        call DestroyMultiboard(playerMultiboards[playerId])
        set playerMultiboards[playerId] = null
    endif
    if (CountAlliesWithSharedControl(whichPlayer) > 0 and GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
        set playerMultiboards[playerId] = CreateTeamResourceMultiboards(whichPlayer)
    endif
endfunction

function SetPlayerIgnoredForTeamResourceMultiboard takes player whichPlayer, player forPlayer, boolean ignored returns nothing
    set playerIgnoredMultiboards[Index2D(GetPlayerId(whichPlayer), GetPlayerId(forPlayer), bj_MAX_PLAYERS)] = ignored
    if (playerMultiboards[GetPlayerId(forPlayer)] != null) then
        call RecreateTeamResourceMultiboardForPlayer(forPlayer)
        call UpdatePlayerTeamResourceMultiboard(forPlayer)
    endif
endfunction

function RecreateTeamResourceMultiboards takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (playerMultiboards[i] != null) then
            call DestroyMultiboard(playerMultiboards[i])
            set playerMultiboards[i] = null
        endif
        set slotPlayer = Player(i)
        if (CountAlliesWithSharedControl(slotPlayer) > 0 and GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set playerMultiboards[i] = CreateTeamResourceMultiboards(slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function StartTeamResourceMultiboardsUpdates takes nothing returns nothing
    call TimerStart(t, TIMER_INTERVAL, true, function UpdateAllTeamResourceMultiboards)
endfunction

private function StartGame takes nothing returns nothing
    call RecreateTeamResourceMultiboards()
    call UpdateAllTeamResourceMultiboards()
endfunction

private function TriggerConditionAllianceChange takes nothing returns boolean
    call RecreateTeamResourceMultiboards()
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerAllianceChange(allianceChangeTrigger, Player(i), ALLIANCE_SHARED_ADVANCED_CONTROL)
        call TriggerRegisterPlayerAllianceChange(allianceChangeTrigger, Player(i), ALLIANCE_SHARED_CONTROL)
        set i = i + 1
    endloop
    call TriggerAddCondition(allianceChangeTrigger, Condition(function TriggerConditionAllianceChange))
    call StartTeamResourceMultiboardsUpdates()
    call OnStartGame(function StartGame)
endfunction

endlibrary
