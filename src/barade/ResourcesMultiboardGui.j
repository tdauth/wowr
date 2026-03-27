library ResourcesMultiboardGui initializer Init requires OnStartGame, Resources

globals
    public constant real TIMER_INTERVAL = 1.0
    public constant boolean SHOW_STANDARD_RESOURCES = false
    public constant boolean SHOW_HEADER = false
    public constant boolean SHOW_COLUMN_NUMBER = false
    public constant boolean SHOW_COLUMN_GOLD_EXCHANGE_RATE = false
    private multiboard array playerMultiboards
    private timer t = CreateTimer()
endglobals

private function GetFirstRow takes nothing returns integer
static if (SHOW_HEADER) then
    return 1
else
    return 0
endif
endfunction

private function GetColumns takes nothing returns integer
if (SHOW_COLUMN_NUMBER and SHOW_COLUMN_GOLD_EXCHANGE_RATE) then
    return 5
elseif (SHOW_COLUMN_GOLD_EXCHANGE_RATE or SHOW_COLUMN_NUMBER) then
    return 4
else
    return 3
endif
endfunction

private function GetAmountColumn takes nothing returns integer
if (SHOW_COLUMN_NUMBER and SHOW_COLUMN_GOLD_EXCHANGE_RATE) then
    return 3
elseif (SHOW_COLUMN_GOLD_EXCHANGE_RATE or SHOW_COLUMN_NUMBER) then
    return 2
else
    return 1
endif
endfunction

private function TimerFunctionUpdate takes nothing returns nothing
    local multiboarditem it = null
    local player slotPlayer = null
    local integer r = 0
    local integer j = 0
    local integer row = 0
    local integer column = 0
    local integer max = GetMaxResources()
    local integer percentage = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (playerMultiboards[i] != null) then
            set row = GetFirstRow()
            set j = 0
            loop
                exitwhen (j == max)
                set r = GetResource(j)
                set column = GetAmountColumn()
                
                if (SHOW_STANDARD_RESOURCES or not IsStandardResource(r)) then
                    set it = MultiboardGetItem(playerMultiboards[i], row, column)
                    call MultiboardSetItemValue(it, I2S(GetPlayerResource(slotPlayer, r)))
                    call MultiboardReleaseItem(it)
                    set column = column + 1
                    
                    set it = MultiboardGetItem(playerMultiboards[i], row, column)
                    set percentage = 100 - GetPlayerResourceUpkeepRate(slotPlayer, r)
                    call MultiboardSetItemValue(it, I2S(percentage) + "%%")
                    if (percentage <= 40) then
                        call MultiboardSetItemValueColor(it, 255, 0, 0, 0)
                    elseif (percentage <= 70) then
                        call MultiboardSetItemValueColor(it, 255, 204, 0, 0)
                    else
                        call MultiboardSetItemValueColor(it, 0, 255, 0, 0)
                    endif
                    call MultiboardReleaseItem(it)
                    set column = column + 1
                    
if (SHOW_COLUMN_GOLD_EXCHANGE_RATE or SHOW_COLUMN_NUMBER) then
                    set it = MultiboardGetItem(playerMultiboards[i], row, column)
                    call MultiboardSetItemValue(it, R2SW(GetResourceGoldExchangeRate(r), 0, 1))
                    call MultiboardReleaseItem(it)
                    set column = column + 1
endif
                    
                    set row = row + 1
                    
                    set it = null
                endif
                set j = j + 1
            endloop
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function CountResourcesForGui takes nothing returns integer
    local integer i = 0
    local integer count = 0
    local integer max = GetMaxResources()
    local Resource resource = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (SHOW_STANDARD_RESOURCES or not IsStandardResource(resource)) then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    return count
endfunction

function PauseResourceMultiboardsUpdates takes nothing returns nothing
    call PauseTimer(t)
endfunction

function ResumeResourceMultiboardsUpdates takes nothing returns nothing
    call ResumeTimer(t)
endfunction

function GetPlayerResourceMultiboard takes player whichPlayer returns multiboard
    return playerMultiboards[GetPlayerId(whichPlayer)]
endfunction

function ShowPlayerResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay(GetPlayerResourceMultiboard(whichPlayer), true)
endfunction

function HidePlayerResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay(GetPlayerResourceMultiboard(whichPlayer), false)
endfunction

function ShowAllPlayerResourceMultiboards takes nothing returns nothing
     local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call MultiboardDisplay(GetPlayerResourceMultiboard(Player(i)), false)
        set i = i + 1
    endloop
endfunction

function HideAllPlayerResourceMultiboards takes nothing returns nothing
     local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call MultiboardDisplay(GetPlayerResourceMultiboard(Player(i)), false)
        set i = i + 1
    endloop
endfunction

function StartResourceMultiboardsUpdates takes nothing returns nothing
    call TimerStart(t, TIMER_INTERVAL, true, function TimerFunctionUpdate)
endfunction

function CreateResourceMultiboards takes nothing returns nothing
    local multiboarditem it = null
    local integer j = 0
    local integer row = 0
    local integer column = 0
    local Resource r = 0
    local integer max = GetMaxResources()
    local integer rows = CountResourcesForGui() + GetFirstRow()
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        set playerMultiboards[i] = CreateMultiboardBJ(GetColumns(), rows, Format(GetLocalizedString("RESOURCES_OF_X")).s(GetPlayerName(slotPlayer)).result())
        call MultiboardSetTitleTextColor(playerMultiboards[i], GetPlayerColorRed(GetPlayerColor(slotPlayer)), GetPlayerColorGreen(GetPlayerColor(slotPlayer)), GetPlayerColorBlue(GetPlayerColor(slotPlayer)), 0)
        call MultiboardSetItemsStyle(playerMultiboards[i], true, true)
        
        set column = 0
        
static if (SHOW_HEADER) then

static if (SHOW_COLUMN_NUMBER) then
        set it = MultiboardGetItem(playerMultiboards[i], 0, column)
        call MultiboardSetItemStyle(it, false, false)
        call MultiboardSetItemWidth(it, 0.02)
        call MultiboardReleaseItem(it)
        set column = column + 1
endif

        set it = MultiboardGetItem(playerMultiboards[i], 0, column)
        call MultiboardSetItemStyle(it, true, false)
        call MultiboardSetItemValue(it, GetLocalizedString("RESOURCE"))
        call MultiboardSetItemWidth(it, 0.1)
        call MultiboardReleaseItem(it)
        set column = column + 1

        set it = MultiboardGetItem(playerMultiboards[i], 0, column)
        call MultiboardSetItemStyle(it, true, false)
        call MultiboardSetItemValue(it, GetLocalizedString("AMOUNT"))
        call MultiboardSetItemWidth(it, 0.1)
        call MultiboardReleaseItem(it)
        set column = column + 1

        set it = MultiboardGetItem(playerMultiboards[i], 0, column)
        call MultiboardSetItemStyle(it, true, false)
        call MultiboardSetItemValue(it, GetLocalizedString("INCOME"))
        call MultiboardSetItemWidth(it, 0.04)
        call MultiboardReleaseItem(it)
        set column = column + 1

static if (SHOW_COLUMN_GOLD_EXCHANGE_RATE) then
        set it = MultiboardGetItem(playerMultiboards[i], 0, column)
        call MultiboardSetItemStyle(it, true, false)
        call MultiboardSetItemValue(it, GetLocalizedString("GOLD_EXCHANGE_RATE"))
        call MultiboardSetItemWidth(it, 0.08)
        call MultiboardReleaseItem(it)
        set column = column + 1
endif

endif

        set row = GetFirstRow()
        set j = 0
        loop
            exitwhen (j >= max)
            set r = GetResource(j)
            
            set column = 0
            
            if (SHOW_STANDARD_RESOURCES or not IsStandardResource(r)) then
            
static if (SHOW_COLUMN_NUMBER) then
                set it = MultiboardGetItem(playerMultiboards[i], row, column)
                call MultiboardSetItemStyle(it, true, false)
                call MultiboardSetItemValue(it, I2S(j))
                call MultiboardSetItemWidth(it, 0.02)
                call MultiboardReleaseItem(it)
                set column = column + 1
endif
                
                set it = MultiboardGetItem(playerMultiboards[i], row, column)
                call MultiboardSetItemIcon(it, GetResourceIcon(r))
                call MultiboardSetItemValue(it, GetResourceName(r))
                call MultiboardSetItemWidth(it, 0.1)
                call MultiboardReleaseItem(it)
                set column = column + 1
                
                set it = MultiboardGetItem(playerMultiboards[i], row, column)
                call MultiboardSetItemStyle(it, true, false)
                call MultiboardSetItemWidth(it, 0.1)
                call MultiboardReleaseItem(it)
                set column = column + 1
                
                set it = MultiboardGetItem(playerMultiboards[i], row, column)
                call MultiboardSetItemStyle(it, true, false)
                call MultiboardSetItemWidth(it, 0.04)
                call MultiboardReleaseItem(it)
                set column = column + 1
                
static if (SHOW_COLUMN_GOLD_EXCHANGE_RATE) then
                set it = MultiboardGetItem(playerMultiboards[i], row, column)
                call MultiboardSetItemStyle(it, true, false)
                call MultiboardSetItemWidth(it, 0.08)
                call MultiboardReleaseItem(it)
                set column = column + 1
endif
                
                set row = row + 1
                
                set it = null
            endif
            set j = j + 1
        endloop
        call MultiboardDisplay(playerMultiboards[i], false)
        set slotPlayer = null
        set i = i + 1
    endloop
    call TimerFunctionUpdate()
    call ShowPlayerResourceMultiboard(GetLocalPlayer())
    call MultiboardMinimize(GetPlayerResourceMultiboard(GetLocalPlayer()), false)
    call StartResourceMultiboardsUpdates()
endfunction


private function Init takes nothing returns nothing
    call OnStartGame(function CreateResourceMultiboards)
endfunction

endlibrary
