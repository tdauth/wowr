library WoWReforgedChatCommands initializer Init requires HostUtils, StringUtils, StringFormat, SafeString, PlayerColorUtils, WoWReforgedMapData, optional QueueUI, WoWReforgedPlayerInfos, WoWReforgedStats, optional WoWReforgedActionsBarUI, WoWReforgedStats, WoWReforgedAttributes, WoWReforgedPrestoredSaveCodes

globals
    // Use different chat event triggers in hope that using TriggerRegisterPlayerChatEvent is faster to filter chat commands than any custom string checks.
    private trigger help = CreateTrigger()
    private trigger helpPing = CreateTrigger()
    private trigger helpClan = CreateTrigger()
    private trigger helpAi = CreateTrigger()
    private trigger info = CreateTrigger()
    private trigger host = CreateTrigger()
    
    private trigger str = CreateTrigger()
    private trigger strMax = CreateTrigger()
    private trigger agi = CreateTrigger()
    private trigger agiMax = CreateTrigger()
    private trigger int = CreateTrigger()
    private trigger intMax = CreateTrigger()
    private trigger resetA = CreateTrigger()
    private trigger equalA = CreateTrigger()
    
    private trigger aiEasy = CreateTrigger()
    private trigger aiNormal = CreateTrigger()
    private trigger aiHard = CreateTrigger()
    private trigger aiInsane = CreateTrigger()
    private trigger aiNone = CreateTrigger()
    private trigger aiNeutral = CreateTrigger()
    private trigger aiCreep = CreateTrigger()
    private trigger aiComputer = CreateTrigger()
    private trigger aiOn = CreateTrigger()
    private trigger aiOff = CreateTrigger()
endglobals

function ShowUI takes player whichPlayer returns nothing
static if (LIBRARY_QueueUI) then
    call SetQueueUIEnabledForPlayer(whichPlayer, true)
endif
static if (LIBRARY_WoWReforgedActionsBarUI) then
    call ShowActionsBarUI(whichPlayer)
endif
    call ShowStatsMultiboard(whichPlayer)
    call ShowCalendarMultiboardForPlayer(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call ShowPlayerResourceMultiboard(whichPlayer)
    endif
endfunction

function HideUI takes player whichPlayer returns nothing
static if (LIBRARY_QueueUI) then
    call SetQueueUIEnabledForPlayer(whichPlayer, false)
endif
static if (LIBRARY_WoWReforgedActionsBarUI) then
    call HideActionsBarUI(whichPlayer)
endif
    call HideStatsMultiboard(whichPlayer)
    call HideCalendarMultiboardForPlayer(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call HidePlayerResourceMultiboard(whichPlayer)
    endif
endfunction

private function GetAiCommandDifficultyName takes integer difficulty returns string
    if (difficulty == COMMAND_EASY) then
        return GetLocalizedStringSafe("EASY")
    elseif (difficulty == COMMAND_HARD) then
        return GetLocalizedStringSafe("HARD")
    elseif (difficulty == COMMAND_INSANE) then
        return GetLocalizedStringSafe("INSANE")
    endif
    return GetLocalizedStringSafe("NORMAL")
endfunction

/*
 * \param difficulty COMMAND_EASY, COMMAND_NORMAL, COMMAND_HARD, COMMAND_INSANE
 */
private function ChatCommandAiDifficulty takes player whichPlayer, string command, integer difficulty returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string target = StringToken(command, 1)
    local force f = GetForceFromString(target)
    local boolean none = true
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerInForce(slotPlayer, f) and slotPlayer != GetMapBossesPlayer() and slotPlayer != Player(PLAYER_NEUTRAL_AGGRESSIVE) and slotPlayer != whichPlayer and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call CommandAI(slotPlayer, difficulty, playerId)
            call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE")).s(GetAiCommandDifficultyName(difficulty)).s(GetPlayerNameColored(slotPlayer)).result())
            set none = false
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    if (none) then
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE_ERROR")).s(GetAiCommandDifficultyName(difficulty)).s(target).result())
    endif
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

private function GetAiCommandControlName takes mapcontrol controlType returns string
    if (controlType == MAP_CONTROL_NONE) then
        return GetLocalizedStringSafe("NONE")
    elseif (controlType == MAP_CONTROL_NEUTRAL) then
        return GetLocalizedStringSafe("NEUTRAL")
    elseif (controlType == MAP_CONTROL_CREEP) then
        return GetLocalizedStringSafe("CREEP")
    endif
    return GetLocalizedStringSafe("COMPUTER")
endfunction

private function ChatCommandAiControl takes player whichPlayer, string command, mapcontrol controlType returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string target = StringToken(command, 1)
    local force f = GetForceFromString(target)
    local boolean none = true
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerInForce(slotPlayer, f) and slotPlayer != GetMapBossesPlayer() and IsPlayerAlly(slotPlayer, whichPlayer) and slotPlayer != whichPlayer and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call SetPlayerController(slotPlayer, controlType)
            call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE")).s(GetAiCommandControlName(controlType)).s(GetPlayerNameColored(slotPlayer)).result())
            set none = false
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    if (none) then
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE_ERROR")).s(GetAiCommandControlName(controlType)).s(target).result())
    endif
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

private function GetAiCommandEnabled takes integer aiCommand returns string
    if (aiCommand == COMMAND_DISABLED_ON) then
        return GetLocalizedStringSafe("ENABLED")
    endif
    return GetLocalizedStringSafe("DISABLED")
endfunction

private function GetAiCommandEnable takes integer aiCommand returns string
    if (aiCommand == COMMAND_DISABLED_ON) then
        return GetLocalizedStringSafe("ENABLE")
    endif
    return GetLocalizedStringSafe("DISABLE")
endfunction

private function ChatCommandAiEnable takes player whichPlayer, string command, integer aiCommand returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string target = StringToken(command, 1)
    local force f = GetForceFromString(target)
    local boolean none = true
    local player slotPlayer = null
    local integer heroLevel = GetHighestHeroLevel(whichPlayer)
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerInForce(slotPlayer, f) and slotPlayer != GetMapBossesPlayer() and IsPlayerAlly(slotPlayer, whichPlayer) and (heroLevel >= MAX_HERO_LEVEL or slotPlayer != whichPlayer) and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call PauseCompAI(slotPlayer, aiCommand == COMMAND_DISABLED_OFF)
            call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE")).s(GetAiCommandEnabled(aiCommand)).s(GetPlayerNameColored(slotPlayer)).result())
            set none = false
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    if (none) then
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("AI_CHANGE_ERROR")).s(GetAiCommandEnable(aiCommand)).s(target).result())
    endif
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

private function EnumPlayerRegisterChatEvent takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(help, GetEnumPlayer(), "-help", true)
    call TriggerRegisterPlayerChatEvent(help, GetEnumPlayer(), "help", true)
    call TriggerRegisterPlayerChatEvent(help, GetEnumPlayer(), "-h", true)
    call TriggerRegisterPlayerChatEvent(helpPing, GetEnumPlayer(), "-helpping", true)
    call TriggerRegisterPlayerChatEvent(helpClan, GetEnumPlayer(), "-helpclan", true)
    call TriggerRegisterPlayerChatEvent(helpAi, GetEnumPlayer(), "-helpai", true)
    call TriggerRegisterPlayerChatEvent(info, GetEnumPlayer(), "-info", false)
    call TriggerRegisterPlayerChatEvent(info, GetEnumPlayer(), "-i", false)
    call TriggerRegisterPlayerChatEvent(info, GetEnumPlayer(), "-stats", false)
    call TriggerRegisterPlayerChatEvent(host, GetEnumPlayer(), "-host", true)
    
    call TriggerRegisterPlayerChatEvent(str, GetEnumPlayer(), "-str ", false)
    call TriggerRegisterPlayerChatEvent(strMax, GetEnumPlayer(), "-str", true)
    call TriggerRegisterPlayerChatEvent(agi, GetEnumPlayer(), "-agi ", false)
    call TriggerRegisterPlayerChatEvent(agiMax, GetEnumPlayer(), "-agi", true)
    call TriggerRegisterPlayerChatEvent(int, GetEnumPlayer(), "-int ", false)
    call TriggerRegisterPlayerChatEvent(intMax, GetEnumPlayer(), "-int", true)
    call TriggerRegisterPlayerChatEvent(resetA, GetEnumPlayer(), "-reseta", true)
    call TriggerRegisterPlayerChatEvent(equalA, GetEnumPlayer(), "-equala", true)
    
    call TriggerRegisterPlayerChatEvent(aiEasy, GetEnumPlayer(), "-aieasy", false)
    call TriggerRegisterPlayerChatEvent(aiNormal, GetEnumPlayer(), "-ainormal", false)
    call TriggerRegisterPlayerChatEvent(aiHard, GetEnumPlayer(), "-aihard", false)
    call TriggerRegisterPlayerChatEvent(aiInsane, GetEnumPlayer(), "-aiinsane", false)
    call TriggerRegisterPlayerChatEvent(aiNone, GetEnumPlayer(), "-ainone", false)
    call TriggerRegisterPlayerChatEvent(aiNeutral, GetEnumPlayer(), "-aineutral", false)
    call TriggerRegisterPlayerChatEvent(aiCreep, GetEnumPlayer(), "-aicreep", false)
    call TriggerRegisterPlayerChatEvent(aiComputer, GetEnumPlayer(), "-aicomputer", false)
    call TriggerRegisterPlayerChatEvent(aiOn, GetEnumPlayer(), "-aion", false)
    call TriggerRegisterPlayerChatEvent(aiOff, GetEnumPlayer(), "-aioff", false)
endfunction

private function TriggerConditionHelp takes nothing returns boolean
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpText())
    return false
endfunction

private function TriggerConditionHelpPing takes nothing returns boolean
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextPing())
    return false
endfunction

private function TriggerConditionHelpClan takes nothing returns boolean
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextClan())
    return false
endfunction

private function TriggerConditionHelpAi takes nothing returns boolean
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextAi())
    return false
endfunction

private function TriggerConditionInfo takes nothing returns boolean
    local string x = StringToken(GetEventPlayerChatString(), 1)
    local player p = GetPlayerFromString(x)
    if (p == null) then
        if (StringLength(x) == 0 or not IsValidAccount(x)) then
            call DisplayStats(GetTriggerPlayer(), GetTriggerPlayer())
        else
            call DisplayAccountInfo(GetTriggerPlayer(), x)
        endif
    else
        call DisplayStats(GetTriggerPlayer(), p)
        set p = null
    endif
    return false
endfunction

private function TriggerConditionHost takes nothing returns boolean
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("HOST_X")).s(GetPlayerNameColored(GetHost())).result())

    return false
endfunction

private function TriggerConditionStr takes nothing returns boolean
    call SkillStr(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
    return false
endfunction

private function TriggerConditionStrMax takes nothing returns boolean
    call SkillStrMax(GetTriggerPlayer())
    return false
endfunction

private function TriggerConditionAgi takes nothing returns boolean
    call SkillAgi(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
    return false
endfunction

private function TriggerConditionAgiMax takes nothing returns boolean
    call SkillAgiMax(GetTriggerPlayer())
    return false
endfunction

private function TriggerConditionInt takes nothing returns boolean
    call SkillInt(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
    return false
endfunction

private function TriggerConditionIntMax takes nothing returns boolean
    call SkillIntMax(GetTriggerPlayer())
    return false
endfunction

private function TriggerConditionResetA takes nothing returns boolean
    call ResetAllSkillPoints(GetTriggerPlayer())
    return false
endfunction

private function TriggerConditionEqualA takes nothing returns boolean
    call EqualizeAllSkillPoints(GetTriggerPlayer())
    return false
endfunction

private function TriggerConditionAiEasy takes nothing returns boolean
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_EASY)
    return false
endfunction

private function TriggerConditionAiNormal takes nothing returns boolean
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_NORMAL)
    return false
endfunction

private function TriggerConditionAiHard takes nothing returns boolean
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_HARD)
    return false
endfunction

private function TriggerConditionAiInsane takes nothing returns boolean
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_INSANE)
    return false
endfunction

private function TriggerConditionAiNone takes nothing returns boolean
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_NONE)
    return false
endfunction

private function TriggerConditionAiNeutral takes nothing returns boolean
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_NEUTRAL)
    return false
endfunction

private function TriggerConditionAiCreep takes nothing returns boolean
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_CREEP)
    return false
endfunction

private function TriggerConditionAiComputer takes nothing returns boolean
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_CREEP)
    return false
endfunction

private function TriggerConditionAiOn takes nothing returns boolean
    call ChatCommandAiEnable(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_DISABLED_ON)
    return false
endfunction

private function TriggerConditionAiOff takes nothing returns boolean
    call ChatCommandAiEnable(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_DISABLED_OFF)
    return false
endfunction

private function Init takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumPlayerRegisterChatEvent)
    call TriggerAddCondition(help, Condition(function TriggerConditionHelp))
    call TriggerAddCondition(helpPing, Condition(function TriggerConditionHelpPing))
    call TriggerAddCondition(helpClan, Condition(function TriggerConditionHelpClan))
    call TriggerAddCondition(helpAi, Condition(function TriggerConditionHelpAi))
    call TriggerAddCondition(info, Condition(function TriggerConditionInfo))
    call TriggerAddCondition(host, Condition(function TriggerConditionHost))
    
    call TriggerAddCondition(str, Condition(function TriggerConditionStr))
    call TriggerAddCondition(strMax, Condition(function TriggerConditionStrMax))
    call TriggerAddCondition(agi, Condition(function TriggerConditionAgi))
    call TriggerAddCondition(agiMax, Condition(function TriggerConditionAgiMax))
    call TriggerAddCondition(int, Condition(function TriggerConditionInt))
    call TriggerAddCondition(intMax, Condition(function TriggerConditionIntMax))
    call TriggerAddCondition(resetA, Condition(function TriggerConditionResetA))
    call TriggerAddCondition(equalA, Condition(function TriggerConditionEqualA))
    
    call TriggerAddCondition(aiEasy, Condition(function TriggerConditionAiEasy))
    call TriggerAddCondition(aiNormal, Condition(function TriggerConditionAiNormal))
    call TriggerAddCondition(aiHard, Condition(function TriggerConditionAiHard))
    call TriggerAddCondition(aiInsane, Condition(function TriggerConditionAiInsane))
    call TriggerAddCondition(aiNone, Condition(function TriggerConditionAiNone))
    call TriggerAddCondition(aiNeutral, Condition(function TriggerConditionAiNeutral))
    call TriggerAddCondition(aiCreep, Condition(function TriggerConditionAiCreep))
    call TriggerAddCondition(aiComputer, Condition(function TriggerConditionAiComputer))
    call TriggerAddCondition(aiOn, Condition(function TriggerConditionAiOn))
    call TriggerAddCondition(aiOff, Condition(function TriggerConditionAiOff))
endfunction

endlibrary
