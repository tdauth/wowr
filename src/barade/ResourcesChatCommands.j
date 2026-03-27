library ResourcesChatCommands initializer Init requires SimError, StringFormat, PlayerColorUtils, Resources

/**
 * Optional system for resource chat commands.
 */

globals
    public constant boolean ALLOW_HELP = true
    public constant boolean ALLOW_LIST = true
    public constant boolean ALLOW_GIVE = true
    public constant boolean ALLOW_ASK = true
    public constant boolean ALLOW_SELL = true
    public constant boolean ALLOW_SELL_ALL = true
    public constant boolean ALLOW_SELL_WOOD = true
    public constant boolean ALLOW_BUY = true
    public constant real HELP_DURATION = 8.0
    public constant real RESOURCES_DURATION = 8.0
    public constant real INFO_DURATION = 4.0
   
    private trigger chatTrigger = CreateTrigger()
endglobals

function GetResourceChatCommands takes nothing returns string
    local string msg = "-helpr/-hr, -resources/-res/-r"
static if (ALLOW_GIVE) then
    set msg = msg + ", -give amount resource player"
endif

static if (ALLOW_ASK) then
    set msg = msg + ", -ask amount resource player"
endif

static if (ALLOW_SELL) then
    set msg = msg + ", -sell amount resource"
endif

static if (ALLOW_SELL_ALL) then
    set msg = msg + ", -sellall/-sa"
endif

static if (ALLOW_SELL_WOOD) then
    set msg = msg + ", -sellwood/-sw"
endif
    
static if (ALLOW_BUY) then
    set msg = msg + ", -buy amount resource"
endif
    return msg
endfunction

function GetResources takes nothing returns string
    local string msg = "Resources: "
    local integer max = GetMaxResources()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (GetResource(i) != Resources_FOOD and GetResource(i) != Resources_FOOD_MAX) then
            if (i > 0) then
                set msg = msg + ", "
            endif
            set msg = msg + I2S(i + 1) + " " + GetResourceName(GetResource(i))
        endif
        set i = i + 1
    endloop

    return msg
endfunction

function SellAllNonStandardResourcesForGold takes player whichPlayer returns integer
    local integer amount = 0
    local integer max = GetMaxResources()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (not IsStandardResource(GetResource(i))) then
            set amount = amount + ExchangePlayerResource(whichPlayer, GetResource(i), Resources_GOLD, GetPlayerResource(whichPlayer, GetResource(i)))
        endif
        set i = i + 1
    endloop

    return amount
endfunction

function SellAllLumberForGold takes player whichPlayer returns integer
    return ExchangePlayerResource(whichPlayer, Resources_LUMBER, Resources_GOLD, GetPlayerResource(whichPlayer, Resources_LUMBER))
endfunction

function GetResourceFromString takes string s returns Resource
    local string lower = StringCase(s, false)
    local integer index = S2I(s)
    local Resource resource = 0
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (StringCase(GetResourceName(resource), false) == lower) then
            return resource
        endif
        set i = i + 1
    endloop
    
    if (i >= 1 and i <= max) then
        return GetResource(i - 1)
    endif
    
    return 0
endfunction

private function GiveChatCommand takes player whichPlayer, string msg returns nothing
    local string amount = StringTokenEx(msg, 1, " ", false)
    local string resource = StringTokenEx(msg, 2, " ", false)
    local string to = StringTokenEx(msg, 3, " ", false)
    local integer a = S2I(amount)
    local Resource r = GetResourceFromString(resource)
    local player t = GetPlayerFromString(to)
    if (r != 0) then
        if (t != null) then
            if (a <= GetPlayerResource(whichPlayer, r)) then
                call AddPlayerResource(t, r, a)
                call RemovePlayerResource(whichPlayer, r, a)
                call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("GAVE_RESOURCES_TO")).i(a).s(GetResourceName(r)).s(GetPlayerNameColored(t)).result())
                call DisplayTimedTextToPlayer(t, 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("RECEIVED_RESOURCES_FROM")).i(a).s(GetResourceName(r)).s(GetPlayerNameColored(whichPlayer)).result())
            else
                call SimError(whichPlayer, Format(GetLocalizedString("NOT_ENOUGH_X")).s(GetResourceName(r)).result())
            endif
        else
            call SimError(whichPlayer, GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer, GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

private function AskChatCommand takes player whichPlayer, string msg returns nothing
    local string amount = StringTokenEx(msg, 1, " ", false)
    local string resource = StringTokenEx(msg, 2, " ", false)
    local string from = StringTokenEx(msg, 3, " ", false)
    local integer a = S2I(amount)
    local Resource r = GetResourceFromString(resource)
    local player f = GetPlayerFromString(from)
    if (r != 0) then
        if (f != null) then
            if (IsPlayerAlly(f, whichPlayer) and GetPlayerController(f) != MAP_CONTROL_USER) then
                if (a <= GetPlayerResource(f, r)) then
                    call AddPlayerResource(whichPlayer, r, a)
                    call RemovePlayerResource(f, r, a)
                    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("RECEIVED_RESOURCES_FROM")).i(a).s(GetResourceName(r)).s(GetPlayerNameColored(whichPlayer)).result())
                else
                    call SimError(whichPlayer, Format(GetLocalizedString("TARGET_PLAYER_HAS_NOT_ENOUGH")).s(GetResourceName(r)).result())
                endif
            else
                call SimError(whichPlayer, GetLocalizedString("TARGET_PLAYER_HAS_TO_BE_ALLIED_C"))
            endif
        else
                call SimError(whichPlayer, GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer, GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

private function SellChatCommand takes player whichPlayer, string msg returns nothing
    local string amount = StringTokenEx(msg, 1, " ", false)
    local string resource = StringTokenEx(msg, 2, " ", false)
    local string targetResource = StringTokenEx(msg, 3, " ", false)
    local integer a = S2I(amount)
    local Resource r = GetResourceFromString(resource)
    local Resource t = Resources_GOLD
    local integer received = 0
    
    if (targetResource != "" and targetResource != null) then
        set t = GetResourceFromString(targetResource)
    endif
    
    if (r != 0) then
        if (t != 0) then
            if (a <= GetPlayerResource(whichPlayer, r)) then
                set received = ExchangePlayerResource(whichPlayer, r, t, a)
                call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("RECEIVED_X_RESOURCES")).i(received).s(GetResourceName(t)).result())
            else
                call SimError(whichPlayer, Format(GetLocalizedString("NOT_ENOUGH_X")).s(GetResourceName(r)).result())
            endif
        else
                call SimError(whichPlayer, GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer, GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

private function BuyChatCommand takes player whichPlayer, string msg returns nothing
    local string amount = StringTokenEx(msg, 1, " ", false)
    local string resource = StringTokenEx(msg, 2, " ", false)
    local integer a = S2I(amount)
    local Resource r = GetResourceFromString(resource)
    local integer received = 0
    
    if (r != 0) then
        set received = ExchangePlayerResource(whichPlayer, Resources_GOLD, r, a)
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("RECEIVED_X_RESOURCES")).i(received).s(GetResourceName(r)).result())
    else
        call SimError(whichPlayer, GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

private function TriggerConditionChat takes nothing returns boolean
    local string msg = GetEventPlayerChatString()
    
    if (ALLOW_HELP and (msg == "-helpresources" or msg == "-helpr" or msg == "-hr")) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, HELP_DURATION, GetResourceChatCommands())
    elseif (ALLOW_LIST and (msg == "-resources" or msg == "-res" or msg == "-r")) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, RESOURCES_DURATION, GetResources())
    elseif (ALLOW_GIVE and StringStartsWith(msg, "-give")) then
        call GiveChatCommand(GetTriggerPlayer(), msg)
    elseif (ALLOW_ASK and StringStartsWith(msg, "-ask")) then
        call AskChatCommand(GetTriggerPlayer(), msg)
    elseif (ALLOW_SELL_ALL and (msg == "-sellall" or msg == "-sa")) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("SOLD_ALL_FOR_GOLD")).i(SellAllNonStandardResourcesForGold(GetTriggerPlayer())).result())
    elseif (ALLOW_SELL_WOOD and (msg == "-sellwood" or msg == "-sw")) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, INFO_DURATION, Format(GetLocalizedString("SOLD_ALL_LUMBER_FOR_GOLD")).i(SellAllLumberForGold(GetTriggerPlayer())).result())
    elseif (ALLOW_SELL and StringStartsWith(msg, "-sell")) then
        call SellChatCommand(GetTriggerPlayer(), msg)
    elseif (ALLOW_BUY and StringStartsWith(msg, "-buy")) then
        call BuyChatCommand(GetTriggerPlayer(), msg)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerChatEvent(chatTrigger, Player(i), "", false)
        set i = i + 1
    endloop
    call TriggerAddCondition(chatTrigger, Condition(function TriggerConditionChat))
endfunction

endlibrary
