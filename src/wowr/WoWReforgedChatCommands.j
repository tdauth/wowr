library WoWReforgedChatCommands initializer Init requires Ascii, SimError, HostUtils, StringUtils, StringFormat, SafeString, ForceUtils, PlayerColorUtils, WoWReforgedUtils, WoWReforgedMapData, optional QueueUI, WoWReforgedPlayerInfos, WoWReforgedStats, WoWReforgedSaveCodeObjects, WoWReforgedHeroes, WoWReforgedBosses, WoWReforgedQuests, WoWReforgedProfessions, optional WoWReforgedUiActionsBar, WoWReforgedStats, WoWReforgedAttributes, WoWReforgedAccount, WoWReforgedComputerStartLocations, WoWReforgedSaveCodesAll, WoWReforgedZones, WoWReforgedCinematic, WoWReforgedTownHalls, WoWReforgedRaces, WoWReforgedBackpacks, WoWReforgedUiBackpack, WoWReforgedPlayerSelection, WoWReforgedVIPs, WoWReforgedProfessionInscriptor, WoWReforgedProfessionHunter, WoWReforgedProfessionEnchanter, WoWReforgedPlayers, WoWReforgedSelfdestruct, optional OrdersWatcher, OnStartGame

/*
 * Chat commands and cheats.
 */

globals
    private boolexpr filterIsValidAutoSkillTarget = null
    private boolexpr filterIsValidAnimTarget = null
    private boolexpr filterIsValidRenameTarget = null
    private boolexpr filterIsValidScaleTarget = null
    private boolexpr filterIsValidTeamColorTarget = null
    private player filterPlayer = null
    private string filterName = null

    // TODO Do we really need sto store the instances? We could register trigger events instantly.
    private ChatCommand array chatCommands
    private integer chatCommandsCounter = 0
endglobals

struct ChatCommand
    string array commands[5]
    boolean array commandsExactMatch[5]
    integer commandsCounter = 0
    boolean isCheat = false
    // Use different chat event triggers in hope that using TriggerRegisterPlayerChatEvent is faster to filter chat commands than any custom string checks.
    trigger t = CreateTrigger()

    method addAlias takes string c, boolean exactMatch returns nothing
        set this.commands[this.commandsCounter] = c
        set this.commandsExactMatch[this.commandsCounter] = exactMatch
        set this.commandsCounter = this.commandsCounter + 1
    endmethod

    static method create takes string command, boolean exactMatch, code f returns thistype
        local thistype this = thistype.allocate()
        call TriggerAddAction(t, f)
        call this.addAlias(command, exactMatch)

        set chatCommands[chatCommandsCounter] = this
        set chatCommandsCounter = chatCommandsCounter + 1

        return this
    endmethod
endstruct

private function Add takes string command, boolean exactMatch, code f returns nothing
    call ChatCommand.create(command, exactMatch, f)
endfunction

private function AddAlias takes string c, boolean exactMatch returns nothing
    call chatCommands[chatCommandsCounter - 1].addAlias(c, exactMatch)
endfunction

private function TriggerConditionCheat takes nothing returns boolean
    return udg_Cheats
endfunction

private function AddCheat takes string command, boolean exactMatch, code f returns nothing
    local ChatCommand c = ChatCommand.create(command, exactMatch, f)
    call TriggerAddCondition(c.t, Condition(function TriggerConditionCheat))
    set c.isCheat = true
endfunction

function ShowUI takes player whichPlayer returns nothing
static if (LIBRARY_QueueUI) then
    call SetQueueUIEnabledForPlayer(whichPlayer, true)
endif
static if (LIBRARY_WoWReforgedUiActionsBar) then
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
static if (LIBRARY_WoWReforgedUiActionsBar) then
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
    local ChatCommand c = 0
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set c = chatCommands[i]
        set j = 0
        set max2 = c.commandsCounter
        loop
            exitwhen (j == max2)
            if (c.commandsExactMatch[j]) then
                call TriggerRegisterPlayerChatEvent(c.t, GetEnumPlayer(), c.commands[j], c.commandsExactMatch[j])
            else
                call TriggerRegisterPlayerChatEvent(c.t, GetEnumPlayer(), c.commands[j], true)
                call TriggerRegisterPlayerChatEvent(c.t, GetEnumPlayer(), c.commands[j] + " ", false)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function Help takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpText())
endfunction

private function HelpDonate takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextDonate())
endfunction

private function HelpPing takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetHelpTextPing())
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

private function GetHelpTextCheats takes nothing returns string
    return "-cheats, -nocheats, -creeps, -cinoutro, -cinlichking, -cinoldgods, -cininvasion, -boots, -terrain, -heroskills, -bonus, -quests, -fields, -read, -write, -maxresources, -respawngroupcounter, -respawnall, -maxlevel, -levelX, -col, -medivh, -demigodlight, -demigoddark, -trydemigod, -orderon, -orderoff, -races, -kill, -fill, -res, -share, -unitinfo, -checksave, -generatesave, -savecounters, -savecodeduplicates, -savecodemissing, -autoskill, -orbs, -herolevels, -claws, -clawsbonus, -regennight, -craft, -legendary, -professions, -aigui, -aicraft, -aiharveston/off, -jaina, -arena, -evolution X Y, -unlockcampaigns, -nagaquest4, -website"
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

private function Donate takes nothing returns nothing
    call ShowDonateUI(GetTriggerPlayer())
endfunction

private function Subscribe takes nothing returns nothing
    call ShowSubscribeUI(GetTriggerPlayer())
endfunction

private function Patreon takes nothing returns nothing
    call ShowPatreonUI(GetTriggerPlayer())
endfunction

private function Version takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetVersionMessage())
endfunction

private function Time takes nothing returns nothing
    call DisplayTime(GetTriggerPlayer())
endfunction

private function Info takes nothing returns nothing
    local string x = StringToken(GetEventPlayerChatString(), 1)
    local Account a = 0
    local player p = GetPlayerFromString(x)
    if (p == null) then
        set a = GetAccountByName(x)
        if (a == null) then
            call DisplayStats(GetTriggerPlayer(), GetTriggerPlayer())
        else
            call DisplayAccountInfo(GetTriggerPlayer(), a)
        endif
    else
        call DisplayStats(GetTriggerPlayer(), p)
        set p = null
    endif
endfunction

private function Host takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("HOST_X")).s(GetPlayerNameColored(GetHost())).result())
endfunction

private function Revive takes nothing returns nothing
    call PanCameraToTimedForPlayer(GetTriggerPlayer(), GetUnitX(GetPlayerFountainOfLife(GetTriggerPlayer())), GetUnitY(GetPlayerFountainOfLife(GetTriggerPlayer())), 0.0)
    call SelectUnitForPlayerSingle(GetPlayerFountainOfLife(GetTriggerPlayer()), GetTriggerPlayer() )
endfunction

private function Get takes nothing returns nothing
    call RecreateHeroItems(GetTriggerPlayer())
endfunction

private function Players takes nothing returns nothing
    call ShowPlayers(GetTriggerPlayer())
endfunction

private function Accounts takes nothing returns nothing
    call DisplayAccounts(GetTriggerPlayer())
endfunction

private function Bans takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, GetBanInfo())
endfunction

private function Vips takes nothing returns nothing
    call DisplayVIPs(GetTriggerPlayer())
endfunction

private function EnumFriends takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, true, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_ALLIED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumEnemies takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_HOSTILE")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumNeutralAll takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NEUTRAL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumVisionAll takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, true, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_VISION")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumNoVision takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, false, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_VISION")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumControlAll takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, true, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumNoControl takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer()) then
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, false, GetEnumPlayer())
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetEnumPlayer())
        call DisplayTextToPlayer(GetEnumPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    endif
endfunction

private function EnumAi takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer() and IsPlayerAlly(GetEnumPlayer(), GetTriggerPlayer()) and GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_CONTROL, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
endfunction

private function EnumNoAi takes nothing returns nothing
    if (GetEnumPlayer() != GetTriggerPlayer() and IsPlayerAlly(GetEnumPlayer(), GetTriggerPlayer()) and GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_CONTROL, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
endfunction

private function AllianceChange takes code f returns nothing
    call DisableAllianceChangesTrigger()
    call ForForce(GetMapLobbyPlayers(), f)
    call EnableAllianceChangesTrigger()
endfunction

private function Friends takes nothing returns nothing
    call AllianceChange(function EnumFriends)
endfunction

private function Enemies takes nothing returns nothing
    call AllianceChange(function EnumEnemies)
endfunction

private function NeutralAll takes nothing returns nothing
    call AllianceChange(function EnumNeutralAll)
endfunction

private function VisionAll takes nothing returns nothing
    call AllianceChange(function EnumVisionAll)
endfunction

private function NoVision takes nothing returns nothing
    call AllianceChange(function EnumNoVision)
endfunction

private function ControlAll takes nothing returns nothing
    call AllianceChange(function EnumControlAll)
endfunction

private function NoControl takes nothing returns nothing
    call AllianceChange(function EnumNoControl)
endfunction

private function Ai takes nothing returns nothing
    call AllianceChange(function EnumAi)
    call ShowStatsMultiboard(GetTriggerPlayer())
endfunction

private function NoAi takes nothing returns nothing
    call AllianceChange(function EnumNoAi)
    call ShowStatsMultiboard(GetTriggerPlayer())
endfunction

private function Ally takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, true, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_ALLIED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Unally takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, false, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_HOSTILE")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Neutral takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_XP, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_SPELLS, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_REQUEST, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_HELP_RESPONSE, false, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_PASSIVE, true, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NEUTRAL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Vision takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, true, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_VISION")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Unvision takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_VISION, false, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_VISION")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Control takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
endfunction

private function Uncontrol takes nothing returns nothing
    local player p = GetPlayerFromString(StringToken(GetEventPlayerChatString(), 1))
    if (p != null and p != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(p)) then
        call DisableAllianceChangesTrigger()
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_CONTROL, true, p)
        call SetPlayerAllianceBJ(GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, p)
        call EnableAllianceChangesTrigger()
        call DisplayTextToPlayer(p, 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
    endif
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

private function PingAiStarts takes nothing returns nothing
    local ComputerStartLocation l = 0
    local integer i = 0
    local integer max = GetMaxComputerStartLocations()
    loop
        exitwhen (i == max)
        set l = GetComputerStartLocation(i)
        if (l.taken) then
            call PingMinimapForPlayer(GetTriggerPlayer(), l.x, l.y, 5.0)
        endif
        set i = i + 1
    endloop
endfunction

private function Hide takes nothing returns nothing
    call HideUI(GetTriggerPlayer())
endfunction

private function Show takes nothing returns nothing
    call ShowUI(GetTriggerPlayer())
endfunction

private function UiOn takes nothing returns nothing
static if LIBRARY_PagedButtonsUI then
    call SetPagedButtonsUIEnabledForPlayer(GetTriggerPlayer(), true)
endif
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ENABLED_PAGED_BUTTONS_UI"))
endfunction

private function UiOff takes nothing returns nothing
static if LIBRARY_PagedButtonsUI then
    call SetPagedButtonsUIEnabledForPlayer(GetTriggerPlayer(), false)
endif
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("DISABLED_PAGED_BUTTONS_UI"))
endfunction

private function UiQueueOn takes nothing returns nothing
    call SetQueueUIEnabledForPlayer(GetTriggerPlayer(), true)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ENABLED_QUEUE_UI"))
endfunction

private function UiQueueOff takes nothing returns nothing
    call SetQueueUIEnabledForPlayer(GetTriggerPlayer(), false)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("DISABLED_QUEUE_UI"))
endfunction

private function UiQueueClear takes nothing returns nothing
    if (GetPlayerQueue(GetTriggerPlayer()) != 0) then
        call ClearQueue(GetPlayerQueue(GetTriggerPlayer()))
    endif
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("CLEARED_QUEUE_UI"))
endfunction

private function BagInfoOn takes nothing returns nothing
    call SetPlayerBagInfo(GetTriggerPlayer(), true)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ENABLED_BAG_INFO"))
endfunction

private function BagInfoOff takes nothing returns nothing
    call SetPlayerBagInfo(GetTriggerPlayer(), false)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("DISABLED_BAG_INFO"))
endfunction

private function BagUiOn takes nothing returns nothing
    set udg_BackpackDontShowUI[GetConvertedPlayerId(GetTriggerPlayer())] = true
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ENABLED_BACKPACK_UI"))
endfunction

private function BagUiOff takes nothing returns nothing
    set udg_BackpackDontShowUI[GetConvertedPlayerId(GetTriggerPlayer())] = false
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("DISABLED_BACKPACK_UI"))
endfunction

private function Repick takes nothing returns nothing
    call HeroRepick(GetTriggerPlayer())
endfunction

private function Unlocked takes nothing returns nothing
    call ShowUnlockedAccountIds(GetTriggerPlayer())
endfunction

private function Items takes nothing returns nothing
    call ShowBackpackUI(GetTriggerPlayer())
endfunction

private function Pickup takes nothing returns nothing
    call PickupAllItemsAroundByPlayer(GetTriggerPlayer())
endfunction

private function Order takes nothing returns nothing
    call OrderBackpack(GetTriggerPlayer())
endfunction

private function PingHeroes takes nothing returns nothing
    call PingAlliedHeroes(GetTriggerPlayer())
endfunction

private function PingGoldMinesAction takes nothing returns nothing
    call PingGoldMines(GetTriggerPlayer())
endfunction

private function PingNpcsAction takes nothing returns nothing
    call PingNpcs(GetTriggerPlayer())
endfunction

private function PingDragonRoostsAction takes nothing returns nothing
    call PingDragonRoosts(GetTriggerPlayer())
endfunction

private function PingLegendaryItemsAction takes nothing returns nothing
    call PingLegendaryItems(GetTriggerPlayer())
endfunction

private function PingMountsAction takes nothing returns nothing
    call PingMounts(GetTriggerPlayer())
endfunction

private function PingPortalsAction takes nothing returns nothing
    call PingPortals(GetTriggerPlayer())
endfunction

private function PingBossesAction takes nothing returns nothing
    call PingBosses(GetTriggerPlayer())
endfunction

private function PingPropertiesAction takes nothing returns nothing
    call PingProperties(GetTriggerPlayer())
endfunction

private function PingAltarsAction takes nothing returns nothing
    call PingAltars(GetTriggerPlayer())
endfunction

private function PingRes takes nothing returns nothing
    call PingResurrectionStones(GetTriggerPlayer())
endfunction

private function PingRaces takes nothing returns nothing
    call PingRacingTrackNextCheckPointForPlayer(GetTriggerPlayer())
endfunction

private function EnumSuicide takes nothing returns nothing
    if (GetOwningPlayer(GetEnumUnit()) == GetTriggerPlayer()) then
        call SelfdestructUnit(GetOwningPlayer(GetEnumUnit()), GetEnumUnit())
    endif
endfunction

private function Suicide takes nothing returns nothing
    local group g = GetUnitsSelectedAll(GetTriggerPlayer())
    call ForGroup(g, function EnumSuicide)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Clear takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ClearTextMessages()
    endif
endfunction

private function FilterIsValidAutoSkillTarget takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function EnumAutoSkill takes nothing returns nothing
    call AutoSkillHero(GetEnumUnit())
endfunction

private function Auto takes nothing returns nothing
    local group g = CreateGroup()
     call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    set filterPlayer = GetTriggerPlayer()
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), filterIsValidAutoSkillTarget)
    call ForGroup(g, function EnumAutoSkill)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("AUTO_SKILL_SELECTED"))
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function ResetRevolution takes nothing returns nothing
    local string token = StringTokenEnteredChatMessageEx(1, true)
    local integer level = S2I(token)
    if (GetPlayerTechCountSimple(UPG_EVOLUTION, GetTriggerPlayer()) > level) then
        call SetPlayerTechResearched(GetTriggerPlayer(), UPG_EVOLUTION, level)
        if (IsPlayerFreelancer(GetTriggerPlayer())) then
            call SetPlayerTechResearched(GetTriggerPlayer(), UPG_CHEAP_EVOLUTION, level)
        endif
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedString("RESET_EVOLUTION")).i(level).result())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("RESET_EVOLUTION_LEVEL_ERROR"))
    endif
endfunction

private function Save takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, 45.00, ColoredSaveCode(GetSaveCode(GetTriggerPlayer())))
            call GetAllSaveCodeItems(GetTriggerPlayer())
            call GetAllSaveCodeUnits(GetTriggerPlayer())
            call GetAllSaveCodeBuildings(GetTriggerPlayer())
            call GetAllSaveCodeResearches(GetTriggerPlayer())
            call GetSaveCodeResources(GetTriggerPlayer())
            call CreateSaveCodeAllTextFile(GetTriggerPlayer())
            call ShowSaveCodeUI(GetTriggerPlayer())
        else
            call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function SaveClear takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call GetSaveCode(GetTriggerPlayer())
            call GetSaveCodeItems(GetTriggerPlayer())
            call GetSaveCodeUnits(GetTriggerPlayer())
            call GetSaveCodeBuildings(GetTriggerPlayer())
            call GetSaveCodeResearches(GetTriggerPlayer())
            call CreateSaveCodeAllTextFile(GetTriggerPlayer())
            // TODO Some feedback
        else
            call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function SaveAutoOn takes nothing returns nothing
    call EnableAutoSaveForPlayer(GetTriggerPlayer())
endfunction

private function SaveAutoOff takes nothing returns nothing
    call DisableAutoSaveForPlayer(GetTriggerPlayer())
endfunction

private function SaveGui takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        call ShowSaveCodeUI(GetTriggerPlayer())
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function ASave takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        call CreateSaveCodeAllTextFile(GetTriggerPlayer())
        // TODO Feedback.
    else
         call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function ALoad takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        call GetSaveCodeAllTextFile(GetTriggerPlayer())
        // TODO Feedback.
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function AReset takes nothing returns nothing
    if (udg_SaveAndLoadEnabled) then
        call ResetSaveCodeAllTextFile(GetTriggerPlayer())
        // TODO Feedback.
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function Load takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCode(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function LoadI takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCodeItems(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function LoadU takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCodeUnits(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function LoadB takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCodeBuildings(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function LoadR takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCodeResearches(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function LoadRes takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    if (udg_SaveAndLoadEnabled) then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("COLON_LOADING_SAVE_CODE"))
            call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ColoredSaveCode(saveCode))
            if (ApplySaveCodeResources(GetTriggerPlayer(), saveCode)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("SUCCESSFULLY_LOADED_YOUR_SAVE_CODE"))
                set udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] = udg_PlayerSaveCodeLoads[GetConvertedPlayerId(GetTriggerPlayer())] + 1
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_SUCCESSFULLY_LOADED")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_SAVE_CODE_X")).s(GetSaveCodeErrors(GetTriggerPlayer(), saveCode)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("PICK_YOUR_HERO_FIRST"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("LOADING_SAVECODES_DISABLED"))
    endif
endfunction

private function SaveCheck takes nothing returns nothing
    local string saveCode = StringToken(GetEventPlayerChatString(), 1)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "Checking savecode: " + ColoredSaveCode(saveCode))
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "Check: " + GetSaveCodeInfos(GetTriggerPlayer(), saveCode))
endfunction

private function Generated takes nothing returns nothing
    call DisplayGeneratedSaveCodes(GetTriggerPlayer())
endfunction

private function ClearGenerated takes nothing returns nothing
    call ClearGeneratedSaveCodesVIP(GetTriggerPlayer())
endfunction

private function ZonesOn takes nothing returns nothing
    set udg_PlayerShowZonesHints[GetConvertedPlayerId(GetTriggerPlayer())] = true
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ZONE_ENABLE"))
endfunction

private function ZonesOff takes nothing returns nothing
    set udg_PlayerShowZonesHints[GetConvertedPlayerId(GetTriggerPlayer())] = false
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ZONE_DISABLE"))
endfunction

private function Zone takes nothing returns nothing
    call ShowCurrentZone(GetTriggerPlayer())
endfunction

private function ZoneFull takes nothing returns nothing
    call ShowCurrentZoneFull(GetTriggerPlayer())
endfunction

private function MountName1 takes nothing returns nothing
    call SetMountName1(GetTriggerPlayer(), StringTokenEnteredChatMessageEx(1, true))
endfunction

private function MountName2 takes nothing returns nothing
    call SetMountName2(GetTriggerPlayer(), StringTokenEnteredChatMessageEx(1, true))
endfunction

private function MountName3 takes nothing returns nothing
    call SetMountName3(GetTriggerPlayer(), StringTokenEnteredChatMessageEx(1, true))
endfunction

private function FilterIsValidAnimTarget takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterPlayer and GetPlayerAlliance(GetOwningPlayer(GetFilterUnit()), filterPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)
endfunction

private function EnumAnim takes nothing returns nothing
    call QueueUnitAnimationBJ(GetEnumUnit(), filterName)
endfunction

private function AnimForSelectedUnits takes player whichPlayer, string animation returns nothing
    local group g = CreateGroup()
    call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    set filterPlayer = GetTriggerPlayer()
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), filterIsValidAnimTarget)
    set filterName = animation
    call ForGroup(g, function EnumAnim)
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedString("PLAYING_ANIMATION_X")).s(animation).result())
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Anim takes nothing returns nothing
    local string token = StringTokenEx(GetEventPlayerChatString(), 1, " ", true)
    if (StringLength(token) > 0) then
        call AnimForSelectedUnits(GetTriggerPlayer(), token)
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("ANIM_USAGE"))
    endif
endfunction

private function Dice takes nothing returns nothing
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local integer sides = 6
    if (StringLength(token) > 0) then
        set sides = S2I(token)
    endif
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("ROLLED_A_DICE")).s(GetPlayerNameWithoutTagColored(GetTriggerPlayer())).i(sides).i(GetRandomInt(1, sides)).result())
endfunction

private function CommandSay takes nothing returns nothing
    call Say(GetTriggerPlayer(), StringTokenEnteredChatMessageEx(1, true))
endfunction

private function CommandShout takes nothing returns nothing
    call Shout(GetTriggerPlayer(), StringTokenEnteredChatMessageEx(1, true))
endfunction

private function PlayerCanDoVisualChatCommand takes player whichPlayer returns boolean
    return udg_UnlockedAll or IsPlayerVIP(whichPlayer) or GetPlayerTechCountSimple(UPG_HERO_LEVEL_75, whichPlayer) > 0
endfunction

private function PlayerColor takes nothing returns nothing
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local player p = GetPlayerFromString(token)
    local string playerColor
    local playercolor c = null
    if (p != null) then
        if ((GetPlayerController(p) == MAP_CONTROL_COMPUTER and GetMapAllowConfigureAIPlayer(p)) or (p == GetTriggerPlayer() and PlayerCanDoVisualChatCommand(GetTriggerPlayer()))) then
            set playerColor = StringToken(GetEventPlayerChatString(), 2)
            set c = GetPlayerColorFromString(playerColor)
            if (c != null) then
                call SetPlayerColorBJ(p, c, true)
                call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_CHANGED_COLOR_FOR_PLAYER_Y")).s(GetPlayerNameColored(GetTriggerPlayer())).s(playerColor).result() )
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_PLAYER_COLOR_X")).s(playerColor).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("ONLY_MAX_HERO_LEVEL_VIP_COMPUTER"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("INVALID_TARGET_PLAYER"))
    endif
endfunction

private function PlayerName takes nothing returns nothing
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local player p = GetPlayerFromString(token)
    local string playerName
    if (p != null) then
        if ((GetPlayerController(p) == MAP_CONTROL_COMPUTER and GetMapAllowConfigureAIPlayer(p)) or (p == GetTriggerPlayer() and PlayerCanDoVisualChatCommand(GetTriggerPlayer()))) then
            set playerName = StringToken(GetEventPlayerChatString(), 2)
            call SetPlayerName(p, playerName)
            call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_CHANGED_NAME_FOR_PLAYER_Y")).s(GetPlayerNameColored(GetTriggerPlayer())).s(playerName).result())
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("ONLY_MAX_HERO_LEVEL_VIP_COMPUTER"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("INVALID_TARGET_PLAYER"))
    endif
endfunction

private function FilterIsValidRenameTarget takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterPlayer and GetUnitTypeId(GetFilterUnit()) != BACKPACK and GetUnitTypeId(GetFilterUnit()) != EQUIPMENT_BAG and (PlayerCanDoVisualChatCommand(filterPlayer) or GetUnitTypeId(GetFilterUnit()) == CUSTOMIZABLE_HERO)
endfunction

private function EnumRename takes nothing returns nothing
    call DisplayTextToPlayer(filterPlayer, 0.0, 0.0, Format(GetLocalizedString("CHANGED_NAME_INTO_X")).s(filterName).result())
    if (IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO)) then
        call BlzSetHeroProperName(GetEnumUnit(), filterName)
    else
        call BlzSetUnitName(GetEnumUnit(), filterName)
    endif
endfunction

private function Rename takes nothing returns nothing
    local string name = StringTokenEnteredChatMessageEx(1, true)
    local group g = CreateGroup()
    call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    set filterPlayer = GetTriggerPlayer()
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), filterIsValidRenameTarget)
    if (BlzGroupGetSize(g) > 0) then
        set filterName = name
        call ForGroup(g, function EnumRename)
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("ONLY_MAX_HERO_LEVEL_VIP"))
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function FilterIsValidScaleTarget takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterPlayer and GetUnitTypeId(GetFilterUnit()) != BACKPACK and GetUnitTypeId(GetFilterUnit()) != EQUIPMENT_BAG
endfunction

private function ScaleUnitsSelectedByPlayer takes player whichPlayer, real scale returns nothing
    local integer i = 0
    local integer max = 0
    local group g = CreateGroup()
    call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    set filterPlayer = whichPlayer
    call GroupEnumUnitsSelected(g, whichPlayer, filterIsValidScaleTarget)
     if (BlzGroupGetSize(g) > 0) then
        set i = 0
        set max = BlzGroupGetSize(g)
        loop
            exitwhen (i >= max)
            call SetUnitScalePercent(BlzGroupUnitAt(g, i), 100.0 * scale, 100.0 * scale, 100.0 * scale)
            set i = i + 1
        endloop
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Scale takes nothing returns nothing
    if (PlayerCanDoVisualChatCommand(GetTriggerPlayer())) then
        call ScaleUnitsSelectedByPlayer(GetTriggerPlayer(), RMinBJ(RMaxBJ(S2R(StringToken(GetEventPlayerChatString(), 1)), 0.10), 10.0))
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("ONLY_MAX_HERO_LEVEL_VIP"))
    endif
endfunction

private function FilterIsValidTeamColorTarget takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function SetTeamColorForUnitsSelectedByPlayer takes player whichPlayer, playercolor c returns nothing
    local integer i = 0
    local integer max = 0
    local group g = CreateGroup()
    call SyncSelections() // delays, issues in trigger conditions and multiplayer games
    set filterPlayer = whichPlayer
    call GroupEnumUnitsSelected(g, whichPlayer, filterIsValidTeamColorTarget)
     if (BlzGroupGetSize(g) > 0) then
        set i = 0
        set max = BlzGroupGetSize(g)
        loop
            exitwhen (i >= max)
            call SetUnitColor(BlzGroupUnitAt(g, i), c)
            set i = i + 1
        endloop
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TeamColor takes nothing returns nothing
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local playercolor c = GetPlayerColorFromString(token)
    if (PlayerCanDoVisualChatCommand(GetTriggerPlayer())) then
        if (c != null) then
            call SetTeamColorForUnitsSelectedByPlayer(GetTriggerPlayer(), c)
        else
            call SimError(GetTriggerPlayer(), Format(GetLocalizedString("INVALID_PLAYER_COLOR_X")).s(token).result())
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("ONLY_MAX_HERO_LEVEL_VIP"))
    endif
endfunction

private function EnumMakeRescuable takes nothing returns nothing
    call MakeUnitRescuableToForceBJ(GetEnumUnit(), true, udg_GaiaRescuingPlayers)
endfunction

private function GaiaOn takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("ENABLED_GAIA"))
    call ForceAddPlayerSimple(GetTriggerPlayer(), udg_GaiaRescuingPlayers)
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_Gaia), function EnumMakeRescuable)
endfunction

private function EnumMakeUnrescuable takes nothing returns nothing
    call MakeUnitRescuableToForceBJ(GetEnumUnit(), true, udg_GaiaRescuingPlayers)
endfunction

private function GaiaOff takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, GetLocalizedString("DISABLED_GAIA"))
    call ForceRemovePlayerSimple(GetTriggerPlayer(), udg_GaiaRescuingPlayers)
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_Gaia), function EnumMakeUnrescuable)
endfunction

private function Enchanter takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, EnchanterInfo(GetTriggerPlayer()))
endfunction

private function Inscriptor takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, InscriptorInfo(GetTriggerPlayer()))
endfunction

private function Trophies takes nothing returns nothing
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, TrophiesInfo(GetTriggerPlayer()))
endfunction

// Cheats

private function EnumKill takes nothing returns nothing
    call KillUnit(GetEnumUnit())
    call DisplayTimedTextToForce(GetPlayersAll(), 30.0, GetPlayerName(GetTriggerPlayer()) + " is killing " + GetUnitName(GetEnumUnit()) + ".")
endfunction

private function CheatKill takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), function EnumKill)
endfunction

private function EnumFill takes nothing returns nothing
    call SetUnitLifePercentBJ(GetEnumUnit(), 100)
    call SetUnitManaPercentBJ(GetEnumUnit(), 100)
    call UnitResetCooldown(GetEnumUnit())
    call DisplayTimedTextToForce(GetPlayersAll(), 30.0, GetPlayerName(GetTriggerPlayer()) + " is filling " + GetUnitName(GetEnumUnit()) + ".")
endfunction

private function CheatFill takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), function EnumFill)
endfunction

private function EnumResurrectHero takes nothing returns nothing
    call ReviveHero(GetEnumUnit(), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), true)
endfunction

private function CheatResurrect takes nothing returns nothing
    call ForGroup(GetPlayerHeroes(GetTriggerPlayer()), function EnumResurrectHero)
endfunction

private function CheatLevel takes nothing returns nothing
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local integer level = S2I(token)
    if (GetPlayerHero1(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero1(GetTriggerPlayer()), level, true)
    endif
    if (GetPlayerHero2(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero2(GetTriggerPlayer()), level, true)
    endif
    if (GetPlayerHero3(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero3(GetTriggerPlayer()), level, true)
    endif
endfunction

private function CheatMaxLevel takes nothing returns nothing
    if (GetPlayerHero1(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero1(GetTriggerPlayer()), MAX_HERO_LEVEL, true)
    endif
    if (GetPlayerHero2(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero2(GetTriggerPlayer()), MAX_HERO_LEVEL, true)
    endif
    if (GetPlayerHero3(GetTriggerPlayer()) != null) then
        call SetHeroLevel(GetPlayerHero3(GetTriggerPlayer()), MAX_HERO_LEVEL, true)
    endif
endfunction

function CheatUnfreeze takes nothing returns nothing
    call PauseAllUnitsBJ(false)
endfunction

private function EnumRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function CheatNoCreeps takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_AGGRESSIVE)), function EnumRemoveUnit)
    call BJDebugMsg("Removed all creeps.")
endfunction

function CheatNoBosses takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(GetMapBossesPlayer()), function EnumRemoveUnit)
    call BJDebugMsg("Removed all bosses.")
endfunction

function CheatNoPassive takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_PASSIVE)), function EnumRemoveUnit)
    call BJDebugMsg("Removed all passive.")
endfunction

function CheatLegendaryItems takes player whichPlayer returns nothing
    local unit hero = GetPlayerHero1(whichPlayer)
    local item whichItem = null
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (udg_LegendaryItemType[i] != 0) then
            set whichItem = UnitAddItemById(hero, udg_LegendaryItemType[i])
        else
            call BJDebugMsg("Warning: Legendary item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

function CheatItems takes player whichPlayer returns nothing
    local unit hero = GetPlayerHero1(whichPlayer)
    local item whichItem = null
    local integer i = 0
    local integer max = GetSaveObjectItemMax()

    // contain race and profession items
    set i = 1
    loop
        exitwhen (i == max)
        if (GetSaveObjectItemId(i) != 0) then
            set whichItem = UnitAddItemById(hero, GetSaveObjectItemId(i))
            if (GetItemCharges(whichItem) > 0) then
                call SetItemCharges(whichItem, 100)
            endif
        else
            call BJDebugMsg("Warning: Item save object with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop

    call CheatLegendaryItems(whichPlayer)

    set i = 0
    set max = GetQuestsMax()
    loop
        exitwhen (i == max)
        if (GetQuestReward(i) != 0) then
            set whichItem = UnitAddItemById(hero, GetQuestReward(i))
        else
            call BJDebugMsg("Warning: Quest reward item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

function CheatMaxResources takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        call SetPlayerResource(whichPlayer, GetResource(i), 9999999)
        set i = i + 1
    endloop
endfunction

private function CheatHeroSkills takes nothing returns nothing
    local unit hero = null
    local integer i = 0
    local integer max = GetHeroesMax()
    loop
        exitwhen (i == max)
        set hero = CreateUnit(GetTriggerPlayer(), GetHeroUnitType(i), 0.0, 0.0, 0.0)
        call SetHeroLevel(hero, MAX_HERO_LEVEL, false)
        call AutoSkillHero(hero)
        call RemoveUnit(hero)
        set hero = null
        set i = i + 1
    endloop
    set i = 0
    set max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i == max)
        set hero = CreateUnit(GetTriggerPlayer(), GetUnitTypeId(BlzGroupUnitAt(udg_Bosses, i)), 0.0, 0.0, 0.0)
        call SetHeroLevel(hero, MAX_HERO_LEVEL, false)
        call AutoSkillHero(hero)
        call RemoveUnit(hero)
        set hero = null
        set i = i + 1
    endloop
endfunction

private function ForGroupCheckSaveCodeMissing takes nothing returns nothing
    local integer unitTypeId = GetUnitTypeId(GetEnumUnit())
    local integer index = GetSaveObjectUnitType(unitTypeId)

    if (index == -1) then
        set index = GetSaveObjectBuildingType(unitTypeId)
    endif

    if (index == -1) then
        call BJDebugMsg("Missing save code for unit type " + GetObjectName(unitTypeId))
    endif
endfunction

private function ForItemGroupCheckSaveCodeMissing takes nothing returns nothing
    local integer unitTypeId = GetItemTypeId(GetEnumItem())
    local integer index = GetSaveObjectItemType(unitTypeId)

    if (index == -1) then
        call BJDebugMsg("Missing save code for item type " + GetObjectName(unitTypeId))
    endif
endfunction

function CheatSaveCodeMissing takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_AGGRESSIVE), null)
    call ForGroup(g, function ForGroupCheckSaveCodeMissing)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null

    call EnumItemsInRect(GetPlayableMapRect(), null, function ForItemGroupCheckSaveCodeMissing)
endfunction

private function PrintProfession takes integer p returns nothing
    local integer i = 0
    local integer max = PROFESSION_RANK_MAX
    local integer j = 0
    local integer max2 = 0
    call BJDebugMsg("- " + GetProfessionName(p))
    loop
        exitwhen (i >= max)
        set j = 0
        set max2 = GetProfessionCraftedItemsCount(p, i)
        call BJDebugMsg(GetProfessionName(p) + " Rank " + GetRankName(i) + " with count " + I2S(max2))
        loop
            exitwhen (j >= max2)
            if (GetProfessionCraftedUnit(p, i, j) != 0) then
                call BJDebugMsg(GetProfessionName(p) + " " + GetObjectName(GetProfessionCraftedUnit(p, i, j)) + " with count " + I2S(GetProfessionCraftedCount(p, i, j)))
            elseif (GetProfessionCraftedItem(p, i, j) != 0) then
                call BJDebugMsg(GetProfessionName(p) + " " + GetObjectName(GetProfessionCraftedItem(p, i, j)) + " with count " + I2S(GetProfessionCraftedCount(p, i, j)))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function CheatProfessions takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i == max)
        call PrintProfession(i)
        set i = i + 1
    endloop
endfunction

private function CreateItemForFirstHero takes player whichPlayer, integer itemTypeId returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, Format(GetLocalizedStringSafe("CREATED_X_FOR_FIRST_HERO")).s(GetObjectName(itemTypeId)).result())
    if (GetPlayerHero1(whichPlayer) != null) then
        call UnitAddItemById(GetPlayerHero1(whichPlayer), itemTypeId)
    endif
endfunction

private function CheatBoots takes nothing returns nothing
    call CreateItemForFirstHero(GetTriggerPlayer(), ITEM_BOOTS_OF_TELEPORTATION)
endfunction

private function CheatTool takes nothing returns nothing
    call CreateItemForFirstHero(GetTriggerPlayer(), ITEM_GOBLIN_TOOL_BOX)
endfunction

private function CheatSpade takes nothing returns nothing
    call CreateItemForFirstHero(GetTriggerPlayer(), ITEM_SPADE)
endfunction

private function CheatTerrain takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, 6.0, "Tile: " + A2S(GetTerrainType(GetCameraTargetPositionX(), GetCameraTargetPositionY())))
endfunction

private function CheatLoadMines takes nothing returns nothing
    call AutoloadComputerWorkersIntoMines()
    call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "Auto loaded Computer workers into mines.")
endfunction

private function CheatOrderOn takes nothing returns nothing
static if (LIBRARY_OrdersWatcher) then
    call EnableOrderDebugger()
endif
endfunction

private function CheatOrderOff takes nothing returns nothing
static if (LIBRARY_OrdersWatcher) then
    call DisableOrderDebugger()
endif
endfunction

private function CheatRaces takes nothing returns nothing
    local integer i = 1 // udg_RaceNone is 0
    loop
        exitwhen (i >= GetRacesMax())
        call BJDebugMsg("Race " + I2S(i) + ": " + GetRaceName(i) + " with tavern item " + GetObjectName(GetRaceTavernItemTypeId(i)) + " and scepter " + GetObjectName(GetRaceItemTypeId(i)) + " and tier 1 item " + GetObjectName(GetRaceTier1Item(i)))
        set i = i + 1
    endloop
endfunction

private function CheatMedivh takes nothing returns nothing
    if (GetPlayerHero1(GetTriggerPlayer()) != null) then
        call UnitAddItemById(GetPlayerHero1(GetTriggerPlayer()), ITEM_MEDIVHS_SPELL_BOOK)
    endif
endfunction

private function CheatEvolution takes nothing returns nothing
    local string x = StringToken(GetEventPlayerChatString(), 1)
    local player p = GetPlayerFromString(x)
    local string y = StringToken(GetEventPlayerChatString(), 2)
    local integer level = S2I(y)
    local integer i = 0
    if (p == null) then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "Usage: \"-evolution <player> <level>\". Evolution for all players:")
        loop
            exitwhen (i >= bj_MAX_PLAYER_SLOTS)
            if (IsPlayerInForce(Player(i), GetMapLobbyPlayers()) or Player(i) == GetMapGaiaPlayer() or Player(i) == GetMapBossesPlayer() or Player(i) == Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "- " + GetPlayerNameColored(Player(i)) + ": " + I2S(GetPlayerTechCountSimple(UPG_EVOLUTION, Player(i))))
            endif
            set i = i + 1
        endloop
    else
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, "Set evolution for " + GetPlayerNameColored(p) + " from level " + I2S(GetPlayerTechCountSimple(UPG_EVOLUTION, p)) + " to level: " + I2S(level))
        //call SetEvolutionLevelForCreeps(udg_TmpInteger)
        call SetPlayerTechResearched(p, UPG_EVOLUTION, level)
        call SetPlayerTechResearched(p, UPG_CHEAP_EVOLUTION, level)
        call SetEvolutionLevelOfPlayer(p, level)

    endif
endfunction

private function CheatUnlockCampaigns takes nothing returns nothing
    // Tutorial
    call SetTutorialCleared(true)
    call SetCampaignAvailable(bj_CAMPAIGN_INDEX_T, true)
    call SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_T, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_T, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_T, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_T, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_T, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_T, 4, true)
    // Human
    call SetCampaignAvailable(bj_CAMPAIGN_INDEX_H, true)
    call SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_H, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 9, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 10, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_H, 11, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_H, true)
    // Undead
    call SetCampaignAvailable(bj_CAMPAIGN_INDEX_U, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_U, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_U, 9, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_U, true)
    // Orc
    call SetCampaignAvailable(bj_CAMPAIGN_INDEX_O, true)
    call SetOpCinematicAvailable(bj_CAMPAIGN_INDEX_O, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 9, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_O, 10, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_O, true)
    // Night Elf
    call SetCampaignAvailable(bj_CAMPAIGN_INDEX_N, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_INDEX_N, 9, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_N, true)
    // Expansion Night Elf
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_XN, true)
    call SetOpCinematicAvailable(bj_CAMPAIGN_OFFSET_XN, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 9, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XN, 10, true)
    // Expansion Human
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_XH, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XH, 9, true)
    // Expansion Undead
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_XU, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_OFFSET_XU, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 4, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 5, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 6, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 7, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 8, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 9, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 10, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 11, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 12, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XU, 13, true)
    // Expansion Orc
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_XO, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XO, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XO, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XO, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_XO, 3, true)
    // Rebirth Human
    call SetOpCinematicAvailable(bj_CAMPAIGN_OFFSET_RH, true)
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_RH, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RH, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RH, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RH, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RH, 3, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RH, 4, true)
    // Rebirth Undead
    call SetCampaignAvailable(bj_CAMPAIGN_OFFSET_RU, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RU, 0, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RU, 1, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RU, 2, true)
    call SetMissionAvailable(bj_CAMPAIGN_OFFSET_RU, 3, true)
    call SetEdCinematicAvailable(bj_CAMPAIGN_INDEX_RU, true)

    call DisplayTextToForce(GetPlayersAll(), GetLocalizedString("UNLOCKED_ALL_CAMPAIGNS"))
endfunction

private function StartGame takes nothing returns nothing
    set udg_Cheats = GetAllPlayingUsersCount() == 1 and (GetPlayerName(Player(0)) == "WorldEdit" or GetPlayerName(Player(0)) == "Barade" or  GetPlayerName(Player(0)) == "Barade#2569")
endfunction

private function Init takes nothing returns nothing
    set filterIsValidAutoSkillTarget = Filter(function FilterIsValidAutoSkillTarget)
    set filterIsValidAnimTarget = Filter(function FilterIsValidAnimTarget)
    set filterIsValidRenameTarget = Filter(function FilterIsValidRenameTarget)
    set filterIsValidScaleTarget = Filter(function FilterIsValidScaleTarget)
    set filterIsValidTeamColorTarget = Filter(function FilterIsValidTeamColorTarget)

    call Add("-help", true, function Help)
    call AddAlias("-h", true)
    call AddAlias("help", true)
    call AddAlias("h", true)
    call Add("-helpdonate", true, function HelpDonate)
    call Add("-helpping", true, function HelpPing)
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
    call AddAlias("-d", true)
    call Add("-website", true, function Website)
    call AddAlias("-w", true)
    call Add("-download", true, function Download)
    call AddAlias("-o", true)
    call Add("-donate", true, function Donate)
    call Add("-subscribe", true, function Subscribe)
    call Add("-patreon", true, function Patreon)

    call Add("-version", true, function Version)
    call AddAlias("-v", true)
    call Add("-time", true, function Time)

    call Add("-info", false, function Info)
    call AddAlias("-i", false)
    call Add("-host", true, function Host)
    call Add("-revive", true, function Revive)
    call AddAlias("-x", true)

    call Add("-get", true, function Get)
    call AddAlias("-g", true)
    call Add("-players", true, function Players)
    call AddAlias("-p", true)
    call Add("-accounts", true, function Accounts)
    call AddAlias("-a", true)
    call Add("-bans", true, function Bans)
    call AddAlias("-b", true)
    call Add("-vips", true, function Vips)

    call Add("-friends", true, function Friends)
    call Add("-enemies", true, function Enemies)
    call Add("-neutralall", true, function NeutralAll)
    call Add("-visionall", true, function VisionAll)
    call Add("-novision", true, function NoVision)
    call Add("-controlall", true, function ControlAll)
    call Add("-nocontrol", true, function NoControl)
    call Add("-ai", true, function Ai)
    call Add("-noai", true, function NoAi)
    call Add("-ally", false, function Ally)
    call Add("-unally", false, function Unally)
    call Add("-neutral", false, function Neutral)
    call Add("-vision", false, function Vision)
    call Add("-unvision", false, function Unvision)
    call Add("-control", false, function Control)
    call Add("-uncontrol", false, function Uncontrol)

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

    call Add("-pingaistarts", true, function PingAiStarts)

    call Add("-hide", true, function Hide)
    call Add("-show", true, function Show)
    call Add("-uion", true, function UiOn)
    call Add("-uioff", true, function UiOff)
    call Add("-uiqueueon", true, function UiQueueOn)
    call Add("-uiqueueoff", true, function UiQueueOff)
    call Add("-uiqueueclear", true, function UiQueueClear)
    call Add("-baginfoon", true, function BagInfoOn)
    call Add("-baginfooff", true, function BagInfoOff)
    call Add("-baguion", true, function BagUiOn)
    call Add("-baguioff", true, function BagUiOff)

    // TODO Hero repick and ping chat commands
    call Add("-repick", true, function Repick)

    call Add("-unlocked", true, function Unlocked)
    call AddAlias("-u", true)

    call Add("-items", true, function Items)
    call AddAlias("-it", true)
    call Add("-pickup", true, function Pickup)
    call AddAlias("-pi", true)
    call Add("-order", true, function Order)
    call AddAlias("-or", true)

    call Add("-pingh", true, function PingHeroes)
    call Add("-pinggoldmines", true, function PingGoldMinesAction)
    call Add("-pingnpcs", true, function PingNpcsAction)
    call Add("-pingdragons", true, function PingDragonRoostsAction)
    call Add("-pingl", true, function PingLegendaryItemsAction)
    call Add("-pingm", true, function PingMountsAction)
    call Add("-pingportals", true, function PingPortalsAction)
    call Add("-pingbosses", true, function PingBossesAction)
    call AddAlias("-pingb", true)
    call AddAlias("-bosses", true)
    call Add("-pingproperties", true, function PingPropertiesAction)
    call Add("-pingaltars", true, function PingAltarsAction)
    call Add("-pingres", true, function PingRes)
    call AddAlias("-resurrectionstones", true)
    call Add("-pingraces", true, function PingRaces)

    call Add("-suicide", true, function Suicide)
    call AddAlias("-k", true)
    call Add("-clear", true, function Clear)
    call AddAlias("-c", true)
    call Add("-auto", true, function Auto)
    call Add("-resetevolution", false, function ResetRevolution)

    call Add("-save", true, function Save)
    call Add("-savec", true, function SaveClear)
    call AddAlias("-s", true)
    call Add("-saveautoon", true, function SaveAutoOn)
    call Add("-saveautoff", true, function SaveAutoOff)
    call Add("-savegui", true, function SaveGui)
    call Add("-asave", true, function ASave)
    call Add("-aload", true, function ALoad)
    call Add("-areset", true, function AReset)
    call Add("-load", false, function Load)
    call AddAlias("-l", false)
    call Add("-loadi", false, function LoadI)
    call Add("-loadu", false, function LoadU)
    call Add("-loadb", false, function LoadB)
    call Add("-loadr", false, function LoadR)
    call Add("-loadres", false, function LoadRes)
    call Add("-savecheck", true, function SaveCheck)
    call Add("-generated", true, function Generated)
    call Add("-cleargenerated", true, function ClearGenerated)

    call Add("-zoneson", true, function ZonesOn)
    call Add("-zonesoff", true, function ZonesOff)
    call Add("-zone", true, function Zone)
    call AddAlias("-z", true)
    call Add("-zonefull", true, function ZoneFull)
    call AddAlias("-zf", true)

    call Add("-mountname1", false, function MountName1)
    call Add("-mountname2", false, function MountName2)
    call Add("-mountname3", false, function MountName3)

    call Add("-anim", false, function Anim)
    call Add("-dice", false, function Dice)
    call Add("-say", false, function CommandSay)
    call Add("-shout", false, function CommandShout)

    call Add("-transfer", false, function ChatCommandTransfer)
    call Add("-notransfer", true, function ChatCommandNoTransfer)

    call Add("-playercolor", false, function PlayerColor)
    call Add("-playername", false, function PlayerName)
    call Add("-rename", false, function Rename)
    call Add("-scale", false, function Scale)
    call Add("-teamcolor", false, function TeamColor)

    call Add("-gaiaon", true, function GaiaOn)
    call Add("-gaiaoff", true, function GaiaOff)

    call Add("-enchanter", true, function Enchanter)
    call AddAlias("-e", true)
    call Add("-inscriptor", true, function Inscriptor)
    call AddAlias("-n", true)
    call Add("-trophies", true, function Trophies)
    call AddAlias("-t", true)

    // Cheats
    call AddCheat("-kill", true, function CheatKill)
    call AddCheat("-fill", true, function CheatFill)
    call AddCheat("-res", true, function CheatResurrect)
    call AddCheat("-level", false, function CheatLevel)
    call AddCheat("-maxlevel", false, function CheatMaxLevel)
    call AddCheat("-unfreeze", true, function CheatUnfreeze)
    call AddCheat("-nocreeps", true, function CheatNoCreeps)
    call AddCheat("-nobosses", true, function CheatNoBosses)
    call AddCheat("-nopassive", true, function CheatNoPassive)
    call AddCheat("-creeps", true, function CompareCreeps)
    call AddCheat("-boots", true, function CheatBoots)
    call AddCheat("-tool", true, function CheatTool)
    call AddCheat("-spade", true, function CheatSpade)
    call AddCheat("-terrain", true, function CheatTerrain)
    call AddCheat("-heroskills", true, function CheatHeroSkills)
    call AddCheat("-bonus", true, function DisplayNewBonusConfig)
    call AddCheat("-loadmines", true, function CheatLoadMines)
    call AddCheat("-orderon", true, function CheatOrderOn)
    call AddCheat("-orderoff", true, function CheatOrderOff)
    call AddCheat("-races", true, function CheatRaces)
    call AddCheat("-medivh", true, function CheatMedivh)
    call AddCheat("-evolution", false, function CheatEvolution)
    call AddCheat("-unlockcampaigns", true, function CheatUnlockCampaigns)

    // after all chat commands
    call ForForce(GetAllPlayingUsers(), function EnumPlayerRegisterChatEvent)

    call OnStartGame(function StartGame)
endfunction

endlibrary
