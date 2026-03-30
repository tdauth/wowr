library WoWReforgedChatCommands initializer Init requires HostUtils, StringUtils, StringFormat, SafeString, PlayerColorUtils, WoWReforgedMapData, optional QueueUI, WoWReforgedPlayerInfos, WoWReforgedStats, optional WoWReforgedActionsBarUI, WoWReforgedStats, WoWReforgedAttributes, WoWReforgedPrestoredSaveCodes

globals
    private ChatCommand array chatCommands
    private integer chatCommandsCounter = 0
endglobals

struct ChatCommand
    string array commands[5]
    integer commandsCounter = 0
    boolean exactMatch
    // Use different chat event triggers in hope that using TriggerRegisterPlayerChatEvent is faster to filter chat commands than any custom string checks.
    trigger t = CreateTrigger()

    method addAlias takes string c returns nothing
        set this.commands[this.commandsCounter] = c
        set this.commandsCounter = this.commandsCounter + 1
    endmethod

    static method create takes string command, boolean exactMatch, code f returns thistype
        local thistype this = thistype.allocate()
        set this.exactMatch = exactMatch
        call TriggerAddAction(t, f)
        call this.addAlias(command)

        set chatCommands[chatCommandsCounter] = this
        set chatCommandsCounter = chatCommandsCounter + 1

        return this
    endmethod
endstruct

private function Add takes string command, boolean exactMatch, code f returns nothing
    call ChatCommand.create(command, exactMatch, f)
endfunction

private function AddAlias takes string c returns nothing
    call chatCommands[chatCommandsCounter - 1].addAlias(c)
endfunction

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
    local integer i = 0
    local integer max = chatCommandsCounter
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = chatCommands[i].commandsCounter
        loop
            exitwhen (j == max2)
            call TriggerRegisterPlayerChatEvent(chatCommands[i].t, GetEnumPlayer(), chatCommands[i].commands[j], chatCommands[i].exactMatch)
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function Help takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpText())
endfunction

private function HelpPing takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextPing())
endfunction

private function HelpClan takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextClan())
endfunction

private function HelpAi takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextAi())
endfunction

private function HelpAlly takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextAlly())
endfunction

private function HelpVisual takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextVisual())
endfunction

private function HelpResources takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextResources())
endfunction

private function HelpAttributes takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextAttributes())
endfunction

private function HelpSave takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextSave())
endfunction

private function HelpFood takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextFood())
endfunction

private function HelpTime takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextTime())
endfunction

private function HelpReset takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextReset())
endfunction

private function HelpCheats takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextCheats())
endfunction

private function Discord takes nothing returns nothing
    call ShowDiscordUI(GetTriggerPlayer())
endfunction

private function Website takes nothing returns nothing
    call ShowWebsiteUI(GetTriggerPlayer())
endfunction

private function Download takes nothing returns nothing
    call ShowDownloadUI(GetTriggerPlayer())
endfunction

private function Version takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetVersionMessage())
endfunction

private function Time takes nothing returns nothing
    call DisplayTime(GetTriggerPlayer())
endfunction

private function Info takes nothing returns nothing
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
endfunction

private function Host takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("HOST_X")).s(GetPlayerNameColored(GetHost())).result())
endfunction

private function Get takes nothing returns nothing
    call RecreateHeroItems(GetTriggerPlayer())
endfunction

private function Players takes nothing returns nothing
    call ShowPlayers(GetTriggerPlayer())
endfunction

private function Accounts takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetPrestoredSaveCodeAccounts())
endfunction

private function Bans takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetBanInfo())
endfunction

private function Vips takes nothing returns nothing
    call DisplayVIPs(GetTriggerPlayer())
endfunction

private function Str takes nothing returns nothing
    call SkillStr(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
endfunction

private function StrMax takes nothing returns nothing
    call SkillStrMax(GetTriggerPlayer())
endfunction

private function Agi takes nothing returns nothing
    call SkillAgi(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
endfunction

private function AgiMax takes nothing returns nothing
    call SkillAgiMax(GetTriggerPlayer())
endfunction

private function Int takes nothing returns nothing
    call SkillInt(GetTriggerPlayer(), I2R(S2I(StringTokenEnteredChatMessageEx(1, true))))
endfunction

private function IntMax takes nothing returns nothing
    call SkillIntMax(GetTriggerPlayer())
endfunction

private function ResetA takes nothing returns nothing
    call ResetAllSkillPoints(GetTriggerPlayer())
endfunction

private function EqualA takes nothing returns nothing
    call EqualizeAllSkillPoints(GetTriggerPlayer())
endfunction

private function AiEasy takes nothing returns nothing
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_EASY)
endfunction

private function AiNormal takes nothing returns nothing
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_NORMAL)
endfunction

private function AiHard takes nothing returns nothing
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_HARD)
endfunction

private function AiInsane takes nothing returns nothing
    call ChatCommandAiDifficulty(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_INSANE)
endfunction

private function AiNone takes nothing returns nothing
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_NONE)
endfunction

private function AiNeutral takes nothing returns nothing
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_NEUTRAL)
endfunction

private function AiCreep takes nothing returns nothing
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_CREEP)
endfunction

private function AiComputer takes nothing returns nothing
    call ChatCommandAiControl(GetTriggerPlayer(), GetEventPlayerChatString(), MAP_CONTROL_CREEP)
endfunction

private function AiOn takes nothing returns nothing
    call ChatCommandAiEnable(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_DISABLED_ON)
endfunction

private function AiOff takes nothing returns nothing
    call ChatCommandAiEnable(GetTriggerPlayer(), GetEventPlayerChatString(), COMMAND_DISABLED_OFF)
endfunction

private function Hide takes nothing returns nothing
    call HideUI(GetTriggerPlayer())
endfunction

private function Show takes nothing returns nothing
    call ShowUI(GetTriggerPlayer())
endfunction

private function Init takes nothing returns nothing
    call Add("-help", true, function Help)
    call AddAlias("-h")
    call AddAlias("help")
    call AddAlias("h")
    call Add("-helpping", true, function HelpPing)
    call Add("-helpclan", true, function HelpClan)
    call Add("-helpai", true, function HelpAi)
    call Add("-helpally", true, function HelpAlly)
    call Add("-helpvisual", true, function HelpVisual)
    call Add("-helpresources", true, function HelpResources)
    call Add("-helpattributes", true, function HelpAttributes)
    call Add("-helpsave", true, function HelpSave)
    call Add("-helpfood", true, function HelpFood)
    call Add("-helptime", true, function HelpTime)
    call Add("-helpreset", true, function HelpReset)
    call Add("-helpcheats", true, function HelpCheats)

    call Add("-discord", true, function Discord)
    call AddAlias("-d")
    call Add("-website", true, function Website)
    call AddAlias("-w")
    call Add("-download", true, function Download)
    call AddAlias("-o")
    call Add("-version", true, function Version)
    call AddAlias("-v")
    call Add("-time", true, function Time)

    call Add("-info", false, function Info)
    call AddAlias("-i")
    call Add("-host", true, function Host)

    call Add("-get", true, function Get)
    call AddAlias("-g")
    call Add("-players", true, function Players)
    call Add("-accounts", true, function Accounts)
    call Add("-bans", true, function Bans)
    call AddAlias("-b")
    call Add("-vips", true, function Vips)

    call Add("-str", false, function Str)
    call Add("-str", true, function StrMax)
    call Add("-agi", false, function Agi)
    call Add("-agi", true, function AgiMax)
    call Add("-int", false, function Int)
    call Add("-int", true, function IntMax)
    call Add("-reseta", true, function ResetA)
    call Add("-equala", true, function EqualA)

    call Add("-aieasy", false, function AiEasy)
    call Add("-ainormal", false, function AiNormal)
    call Add("-aihard", false, function AiHard)
    call Add("-aiinsane", false, function AiInsane)
    call Add("-ainone", false, function AiNone)
    call Add("-aineutral", false, function AiNeutral)
    call Add("-aicreep", false, function AiCreep)
    call Add("-aicomputer", false, function AiComputer)
    call Add("-aion", false, function AiOn)
    call Add("-aioff", false, function AiOff)

    call Add("-hide", true, function Hide)
    call Add("-show", true, function Show)

    // after all chat commands
    call ForForce(GetPlayersAll(), function EnumPlayerRegisterChatEvent)
endfunction

endlibrary
