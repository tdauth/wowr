library Log initializer Init requires MathUtils, StringUtils, PlayerColorUtils

globals
    constant boolean LOG_CHAT = true
    constant boolean LOG_CINEMATIC_TRANSMISSIONS = true
    // This will remove all empty lines at the beginning of a message which helps with SimError.
    constant boolean REMOVE_STARTING_EMPTY_LINES = true

    constant integer LOG_MAXIMUM = 5000
    private string array log
    private integer array logCounter
    private boolean array logEnabled
    private integer array logMaximum
    
    private trigger array callbackTriggers
    private integer callbackTriggersCounter = 0
    private player triggerLogPlayer = null
    private string triggerLogMessage = null
    
    private string tmpMessage = ""
endglobals

function TriggerRegisterLogEvent takes trigger whichTrigger returns nothing
    set callbackTriggers[callbackTriggersCounter] = whichTrigger
    set callbackTriggersCounter = callbackTriggersCounter + 1
endfunction

function GetTriggerLogPlayer takes nothing returns player
    return triggerLogPlayer
endfunction

function GetTriggerLogMessage takes nothing returns string
    return triggerLogMessage
endfunction

private function ExecuteCallbackTriggers takes player whichPlayer, string msg returns nothing
    local integer i = 0
    local player slotPlayer = null
    loop
        exitwhen (i == callbackTriggersCounter)
        if (IsTriggerEnabled(callbackTriggers[i])) then
            set triggerLogPlayer = whichPlayer
            set triggerLogMessage = msg
            call ConditionalTriggerExecute(callbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function GetLogEntryIndex takes player whichPlayer, integer index returns integer
    return Index2D(index, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)
endfunction

function ClearLog takes player whichPlayer returns nothing
    set logCounter[GetPlayerId(whichPlayer)] = 0
endfunction

function IsLogEnabled takes player whichPlayer returns boolean
    return logEnabled[GetPlayerId(whichPlayer)]
endfunction

function SetLogEnabled takes player whichPlayer, boolean enabled returns nothing
    set logEnabled[GetPlayerId(whichPlayer)] = enabled
endfunction

function GetLogMaximum takes player whichPlayer returns integer
    return logMaximum[GetPlayerId(whichPlayer)]
endfunction

function SetLogMaximum takes player whichPlayer, integer maximum returns nothing
    set logMaximum[GetPlayerId(whichPlayer)] = maximum
endfunction

function GetLogEntry takes player whichPlayer, integer index returns string
    return log[GetLogEntryIndex(whichPlayer, index)]
endfunction

function GetLogCounter takes player whichPlayer returns integer
    return logCounter[GetPlayerId(whichPlayer)]
endfunction

static if (REMOVE_STARTING_EMPTY_LINES) then
function RemoveStartingEmptyLines takes string s returns string
    local integer i = 0
    local integer max = StringLength(s)
    if (max > 0) then
        loop
            exitwhen (i >= max or SubString(s, i, i + 1) != "\n")
            set i = i + 1
        endloop
 
        return SubString(s, i, max)
    endif
    
    return s
endfunction
endif

function AddLog takes player whichPlayer, string msg returns nothing
    local integer index = GetLogCounter(whichPlayer)
    local integer i = 0
    local integer max = 0
    if (IsLogEnabled(whichPlayer)) then
        // Do this before removing empty lines since StringLength seems to already localize the passed string.
        set msg = GetLocalizedString(msg)
static if (REMOVE_STARTING_EMPTY_LINES) then
        set msg = RemoveStartingEmptyLines(msg)
endif
        
        set max = GetLogMaximum(whichPlayer)
        if (index >= max) then
            set i = 1
            loop
                exitwhen (i >= max)
                set log[GetLogEntryIndex(whichPlayer, i - 1)] = log[GetLogEntryIndex(whichPlayer, i)]
                set i = i + 1
            endloop
            set log[GetLogEntryIndex(whichPlayer, max - 1)] = msg
        else
            set logCounter[GetPlayerId(whichPlayer)] = index + 1
            set log[GetLogEntryIndex(whichPlayer, index)] = msg
        endif
        
        call ExecuteCallbackTriggers(whichPlayer, msg)
    endif
endfunction

private function DisplayTextToPlayerHook takes player toPlayer, real x, real y, string message returns nothing
    call AddLog(toPlayer, message)
endfunction

private function DisplayTimedTextToPlayerHook takes player toPlayer, real x, real y, real duration, string message returns nothing
    call AddLog(toPlayer, message)
endfunction

private function DisplayTimedTextFromPlayerHook takes player toPlayer, real x, real y, real duration, string message returns nothing
    call AddLog(toPlayer, message)
endfunction

private function ForForceAddLog takes nothing returns nothing
    call AddLog(GetEnumPlayer(), tmpMessage)
endfunction

private function DisplayTextToForceHook takes force toForce, string message returns nothing
    set tmpMessage = message
    call ForForce(toForce, function ForForceAddLog)
endfunction

private function DisplayTimedTextToForceHook takes force toForce, real duration, string message returns nothing
    set tmpMessage = message
    call ForForce(toForce, function ForForceAddLog)
endfunction

private function QuestMessageBJHook takes force f, integer messageType, string message returns nothing
    set tmpMessage = " "
    call ForForce(f, function ForForceAddLog)
    set tmpMessage = message
    call ForForce(f, function ForForceAddLog)
endfunction

private function BJDebugMsgHook takes string msg returns nothing
    set tmpMessage = msg
    call ForForce(GetPlayersAll(), function ForForceAddLog)
endfunction

private function GetChatMessageRecipient takes integer recipient returns string
    if (recipient == 0) then
        return GetLocalizedString("CHAT_RECIPIENT_ALL")
    elseif (recipient == 1) then
        return GetLocalizedString("CHAT_RECIPIENT_ALLIES")
    elseif (recipient == 2) then
        return GetLocalizedString("CHAT_RECIPIENT_OBSERVERS")
    endif
    
    return GetLocalizedString("CHAT_RECIPIENT_PRIVATE")
endfunction

// recipient: changes the type of chat channel prefix shown. It has no effect on the message's visibility.
// 0: "All" chat prefix
// 1: "Allies"
// 2: "Observers"
// 3+: "Private"
private function BlzDisplayChatMessageHook takes player whichPlayer, integer recipient, string message returns nothing
    set tmpMessage = GetChatMessageRecipient(recipient) + " " + GetPlayerNameColoredSimple(whichPlayer) + ": " + message
    call ForForce(GetPlayersAll(), function ForForceAddLog)
endfunction

hook DisplayTextToPlayer DisplayTextToPlayerHook
hook DisplayTimedTextToPlayer DisplayTimedTextToPlayerHook
hook DisplayTimedTextFromPlayer DisplayTimedTextFromPlayerHook
hook DisplayTextToForce DisplayTextToForceHook
hook DisplayTimedTextToForce DisplayTimedTextToForceHook
hook QuestMessageBJ QuestMessageBJHook
hook BJDebugMsg BJDebugMsgHook
hook BlzDisplayChatMessage BlzDisplayChatMessageHook

static if (LOG_CINEMATIC_TRANSMISSIONS) then
private function TransmissionFromUnitWithNameBJHook takes force toForce, unit whichUnit, string unitName, sound soundHandle, string message, integer timeType, real timeVal, boolean wait returns nothing
    set tmpMessage = " "
    call ForForce(toForce, function ForForceAddLog)
    set tmpMessage = "|cffffcc00" + GetLocalizedString(unitName) + ":|r " + GetLocalizedString(message)
    call ForForce(toForce, function ForForceAddLog)
endfunction

private function TransmissionFromUnitTypeWithNameBJHook takes force toForce, player fromPlayer, integer unitId, string unitName, location loc, sound soundHandle, string message, integer timeType, real timeVal, boolean wait returns nothing
    set tmpMessage = " "
    call ForForce(toForce, function ForForceAddLog)
    set tmpMessage = "|cffffcc00" + GetLocalizedString(GetObjectName(unitId)) + ":|r " + GetLocalizedString(message)
    call ForForce(toForce, function ForForceAddLog)
endfunction

private function SetCinematicSceneHook takes integer portraitUnitId, playercolor color, string speakerTitle, string text, real sceneDuration, real voiceoverDuration returns nothing
    set tmpMessage = " "
    call ForForce(GetPlayersAll(), function ForForceAddLog)
    set tmpMessage = "|cffffcc00" + speakerTitle + ":|r " + GetLocalizedString(text)
    call ForForce(GetPlayersAll(), function ForForceAddLog)
endfunction

private function SetCinematicSceneBJHook takes sound soundHandle, integer portraitUnitId, playercolor color, string speakerTitle, string text, real sceneDuration, real voiceoverDuration returns nothing
    set tmpMessage = " "
    call ForForce(GetPlayersAll(), function ForForceAddLog)
    set tmpMessage = "|cffffcc00" + speakerTitle + ":|r " + GetLocalizedString(text)
    call ForForce(GetPlayersAll(), function ForForceAddLog)
endfunction

hook TransmissionFromUnitWithNameBJ TransmissionFromUnitWithNameBJHook
hook TransmissionFromUnitTypeWithNameBJ TransmissionFromUnitTypeWithNameBJHook
hook SetCinematicScene SetCinematicSceneHook
hook SetCinematicSceneBJ SetCinematicSceneBJHook

endif

static if (LOG_CHAT) then
private function TriggerActionChatMessage takes nothing returns nothing
    call AddLog(GetTriggerPlayer(), GetPlayerNameColoredSimple(GetTriggerPlayer()) + ": " + GetEventPlayerChatString())
endfunction
endif

private function Init takes nothing returns nothing
    local trigger t = null
    local integer i = 0
    local player slotPlayer = null
static if (LOG_CHAT) then
     set t = CreateTrigger()
     call TriggerAddAction(t, function TriggerActionChatMessage)
endif
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        call SetLogEnabled(slotPlayer, GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING)
        call SetLogMaximum(slotPlayer, LOG_MAXIMUM)
static if (LOG_CHAT) then
        call TriggerRegisterPlayerChatEvent(t, slotPlayer, "", false)
endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

endlibrary
