library WoWReforgedUiAiPlayers initializer Init requires OnStartGame, FrameLoader, FrameSaver, PlayerColorUtils, HostUtils, WoWReforgedUi, WoWReforgedUtils, WoWReforgedMapData, WoWReforgedHeroes, WoWReforgedRaces, WoWReforgedComputerStartLocations

/**
 * AI Players GUI which helps to configure AI players for one game in the beginning of the game.
 * Only the host sees this GUI and can specify heroes, races etc.
 */

globals
    private constant string PREFIX = "WoWReforgedUiAiPlayers"

    private constant real LINE_HEADERS_Y = UI_FULLSCREEN_Y - 0.05
    private constant real LINE_HEADERS_HEIGHT = 0.006

    private constant real LINE_HEIGHT = 0.03

    private constant real LINE_HEIGHT_SPACING = 0.1

    private constant real START_X = UI_FULLSCREEN_X + 0.03

    private constant real COLUMN_PLAYER_NAME_X = START_X
    private constant real COLUMN_PLAYER_NAME_WIDTH = 0.10

    private constant real COLUMN_SPACING_X = 0.003

    private constant real LINE_SPACING_Y = 0.005

    private constant real COLUMN_COLOR_X = COLUMN_PLAYER_NAME_X + COLUMN_PLAYER_NAME_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_COLOR_WIDTH = 0.08

    private constant real COLUMN_COLOR_EDIT_X = COLUMN_COLOR_X + 0.03
    private constant real COLUMN_COLOR_EDIT_WIDTH = 0.03
    private constant real COLUMN_COLOR_EDIT_HEIGHT = 0.03

    private constant real COLUMN_TEAM_X = COLUMN_COLOR_X + COLUMN_COLOR_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_TEAM_WIDTH = 0.07

    private constant real COLUMN_HERO_X = COLUMN_TEAM_X + COLUMN_TEAM_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_HERO_WIDTH = 0.15

    private constant real COLUMN_HERO_START_LEVEL_X = COLUMN_HERO_X + COLUMN_HERO_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_HERO_START_LEVEL_WIDTH = 0.04

    // new line
    private constant real COLUMN_START_LOCATION_X = START_X
    private constant real COLUMN_START_LOCATION_WIDTH = 0.13

    private constant real COLUMN_RACE_X = COLUMN_START_LOCATION_X + COLUMN_START_LOCATION_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_RACE_WIDTH = 0.15

    private constant real COLUMN_PROFESSION_X = COLUMN_RACE_X + COLUMN_RACE_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_PROFESSION_WIDTH = 0.13

    // new line
    private constant real COLUMN_START_GOLD_X = START_X
    private constant real COLUMN_START_GOLD_WIDTH = 0.06

    private constant real COLUMN_START_LUMBER_X = COLUMN_START_GOLD_X + COLUMN_START_GOLD_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_START_LUMBER_WIDTH = 0.06

    private constant real COLUMN_FOOD_LIMIT_X = COLUMN_START_LUMBER_X + COLUMN_START_LUMBER_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_FOOD_LIMIT_WIDTH = 0.06

    private constant real COLUMN_START_EVOLUTION_X = COLUMN_FOOD_LIMIT_X + COLUMN_FOOD_LIMIT_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_START_EVOLUTION_WIDTH = 0.06

    private constant real COLUMN_START_IMPROVED_POWER_GENERATOR_X = COLUMN_START_EVOLUTION_X + COLUMN_START_EVOLUTION_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_START_IMPROVED_POWER_GENERATOR_WIDTH = 0.06

    private constant real COLUMN_START_IMPROVED_CREEP_HUNTER_X = COLUMN_START_IMPROVED_POWER_GENERATOR_X + COLUMN_START_IMPROVED_POWER_GENERATOR_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_START_IMPROVED_CREEP_HUNTER_WIDTH = 0.06

    private constant real COLUMN_START_IMPROVED_NAVY_X = COLUMN_START_IMPROVED_CREEP_HUNTER_X + COLUMN_START_IMPROVED_CREEP_HUNTER_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_START_IMPROVED_NAVY_WIDTH = 0.06

    private constant real COLUMN_ATTACK_PLAYERS_X = COLUMN_START_EVOLUTION_X + COLUMN_START_EVOLUTION_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_ATTACK_PLAYERS_WIDTH = 0.03

    private constant real COLUMN_HEROES_X = COLUMN_ATTACK_PLAYERS_X + COLUMN_ATTACK_PLAYERS_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_HEROES_WIDTH = 0.06

    private constant real COLUMN_EXPANSIONS_X = COLUMN_HEROES_X + COLUMN_HEROES_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_EXPANSIONS_WIDTH = 0.06

    private constant real COLUMN_SHARED_CONTROL_X = COLUMN_EXPANSIONS_X + COLUMN_EXPANSIONS_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_SHARED_CONTROL_WIDTH = 0.03

    private constant real COLUMN_DIFFICULTY_X = COLUMN_SHARED_CONTROL_X + COLUMN_SHARED_CONTROL_WIDTH + COLUMN_SPACING_X
    private constant real COLUMN_DIFFICULTY_WIDTH = 0.08

    private constant real BUTTONS_Y = 0.24

    // default values
    private constant integer START_GOLD = 500
    private constant integer START_LUMBER = 400

    // HeroesPopupMenu
    private constant integer HEROES_MENU_ITEM_RANDOM_MATCHING_RACE = 0
    private constant integer HEROES_MENU_ITEM_RANDOM = 1
    private constant integer HEROES_MENU_ITEM_FINAL = 204

    // StartLocationsPopupMenu
    private constant integer START_LOCATION_MENU_ITEM_RANDOM_MATCHING_TEAM = 0
    private constant integer START_LOCATION_MENU_ITEM_RANDOM = 1
    private constant integer START_LOCATION_MENU_ITEM_RANDOM_ALLIANCE = 2
    private constant integer START_LOCATION_MENU_ITEM_RANDOM_HORDE = 3
    private constant integer START_LOCATION_MENU_ITEM_TERDRASSIL = 4

    // RacesPopupMenu
    private constant integer RACES_MENU_ITEM_MATCHING_START_LOCATION = 0
    private constant integer RACES_MENU_ITEM_RANDOM_WARLORD = 1
    private constant integer RACES_MENU_ITEM_RANDOM = 2
    private constant integer RACES_MENU_ITEM_RANDOM_FREELANCER = 3
    private constant integer RACES_MENU_ITEM_RANDOM_ALLIANCE = 4
    private constant integer RACES_MENU_ITEM_RANDOM_HORDE = 5
    private constant integer RACES_MENU_ITEM_HUMAN = 6

    // ProfessionsPopupMenu
    private constant integer PROFESSIONS_MENU_ITEM_RANDOM = 0
    private constant integer PROFESSIONS_MENU_ITEM_HERBALIST = 1
    private constant integer PROFESSIONS_MENU_ITEM_ALCHEMIST = 2
    private constant integer PROFESSIONS_MENU_ITEM_WEAPON_SMITH = 3
    private constant integer PROFESSIONS_MENU_ITEM_ARMORER = 4
    private constant integer PROFESSIONS_MENU_ITEM_ENGINEER = 5
    private constant integer PROFESSIONS_MENU_ITEM_DEMOLITION_EXPERT = 6
    private constant integer PROFESSIONS_MENU_ITEM_DRAGON_BREEDER = 7
    private constant integer PROFESSIONS_MENU_ITEM_LORE_MASTER = 8
    private constant integer PROFESSIONS_MENU_ITEM_RUNE_FORGER = 9
    private constant integer PROFESSIONS_MENU_ITEM_SORCERER = 10
    private constant integer PROFESSIONS_MENU_ITEM_JEWELCRAFTER = 11
    private constant integer PROFESSIONS_MENU_ITEM_ARCHAEOLOGIST = 12
    private constant integer PROFESSIONS_MENU_ITEM_WITCH_DOCTOR = 13
    private constant integer PROFESSIONS_MENU_ITEM_TAMER = 14
    private constant integer PROFESSIONS_MENU_ITEM_NECROMANCER = 15
    private constant integer PROFESSIONS_MENU_ITEM_GOLEM_SCULPTOR = 16
    private constant integer PROFESSIONS_MENU_ITEM_WARLOCK = 17
    private constant integer PROFESSIONS_MENU_ITEM_ASTROMANCER = 18

    private hashtable h = InitHashtable()
    private integer Counter = 0 // number of players and pages
    private force Force = CreateForce()
    private integer Page = 0 // async

    private framehandle backgroundFrame
    private framehandle titleFrame

    // header line
    private framehandle playerNameLabel
    private framehandle colorLabel
    private framehandle teamLabel
    private framehandle heroLabel
    private framehandle heroLabelStartLevel
    private framehandle startLocationLabel
    private framehandle raceLabel // including freelancer
    private framehandle labelProfession
    private framehandle goldLabel
    private framehandle lumberLabel
    private framehandle foodLimitLabel
    private framehandle evolutionLabel
    private framehandle labelStartImprovedPowerGenerator
    private framehandle labelStartImprovedCreepHunter
    private framehandle labelStartImprovedNavy
    private framehandle attacksLabel
    private framehandle heroesLabel
    private framehandle expansionsLabel
    private framehandle sharedControlLabel
    private framehandle difficultyLabel

    // sync data
    private string array PlayerNames
    private integer array Color
    private integer array Teams
    private integer array Heroes
    private integer array HeroStartLevels
    private integer array StartLocations
    private integer array Races
    private integer array Professions
    private integer array StartGold
    private integer array StartLumber
    private integer array FoodLimit
    private integer array StartEvolution
    private integer array AttackPlayers
    private integer array HeroesCount
    private integer array Expansions
    private integer array SharedControl
    private integer array Difficulty
    private boolean array SyncDone

    private trigger syncTrigger = CreateTrigger()

    // player lines
    private framehandle array playerNameEdit
    private framehandle array colorLabelPopup
    private framehandle array colorComboBox
    private framehandle array colorLabelArrowUp
    private framehandle array colorLabelArrowUpFrame
    private framehandle array colorLabelArrowDown
    private framehandle array colorLabelArrowDownFrame
    private trigger array colorPopupMenuTrigger
    private trigger array colorUpTrigger
    private trigger array colorDownTrigger
    private framehandle array teamComboBox
    private framehandle array heroComboBox
    private framehandle array heroComboBoxArrowUp
    private framehandle array heroComboBoxArrowUpFrame
    private framehandle array heroComboBoxArrowDown
    private framehandle array heroComboBoxArrowDownFrame
    private trigger array heroUpTrigger
    private trigger array heroDownTrigger
    private framehandle array heroLabelStartLevelEdit
    private framehandle array startLocationComboBox
    private framehandle array startLocationComboBoxArrowUp
    private framehandle array startLocationComboBoxArrowUpFrame
    private framehandle array startLocationComboBoxArrowDown
    private framehandle array startLocationComboBoxArrowDownFrame
    private trigger array startLocationUpTrigger
    private trigger array startLocationDownTrigger
    private framehandle array raceLabelEdit
    private framehandle array raceLabelEditArrowUp
    private framehandle array raceLabelEditArrowUpFrame
    private framehandle array raceLabelEditArrowDown
    private framehandle array raceLabelEditArrowDownFrame
    private trigger array raceUpTrigger
    private trigger array raceDownTrigger
    private framehandle array professionComboBox
    private framehandle array goldEdit
    private framehandle array lumberEdit
    private framehandle array foodEdit
    private framehandle array evolutionEdit
    private framehandle array labelStartImprovedPowerGeneratorEdit
    private framehandle array labelStartImprovedCreepHunterEdit
    private framehandle array labelStartImprovedNavyEdit
    private framehandle array attacksCheckBox
    private framehandle array heroesEdit
    private framehandle array expansionsEdit
    private framehandle array sharedControlCheckBox
    private framehandle array difficultyComboBox

    // bottom buttons
    private framehandle previousPageButton
    private trigger previousPageTrigger = null

    private framehandle nextPageButton
    private trigger nextPageTrigger = null

    private framehandle applyButton
    private trigger applyTrigger = null
endglobals

function DisplayAISettingsInfo takes nothing returns nothing
      call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedStringSafe("AI_HOST_CHOOSES")).s(GetPlayerNameColored(GetHost())).result())
endfunction

private function UpdateComputerPlayersTitle takes nothing returns nothing
    call BlzFrameSetText(titleFrame, Format(GetLocalizedStringSafe("AI_UI_TITLE")).i(Page + 1).i(Counter).result())
endfunction

function GetAiPlayersWithConfig takes nothing returns force
    local player aiPlayer = null
    local force result = CreateForce()
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set aiPlayer = Player(i)
        if (GetPlayerController(aiPlayer) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(aiPlayer) == PLAYER_SLOT_STATE_PLAYING and GetMapAllowConfigureAIPlayer(aiPlayer)) then
            call ForceAddPlayer(result, aiPlayer)
        endif
        set aiPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function CountAiPlayersWithConfig takes nothing returns integer
    local force aiPlayers = GetAiPlayersWithConfig()
    local integer result = CountPlayersInForceBJ(aiPlayers)
    call ForceClear(aiPlayers)
    call DestroyForce(aiPlayers)
    set aiPlayers = null
    return result
endfunction

private function SetVisible takes boolean visible returns nothing
    local integer currentPage = Page
    local integer counterStart = currentPage
    local integer counterEnd = counterStart
    local integer counter = 0
    local integer i = 0

    call BlzFrameSetVisible(backgroundFrame, visible)
    call BlzFrameSetVisible(titleFrame, visible)
    call BlzFrameSetVisible(playerNameLabel, visible)
    call BlzFrameSetVisible(colorLabel, visible)
    call BlzFrameSetVisible(teamLabel, visible)
    call BlzFrameSetVisible(heroLabel, visible)
    call BlzFrameSetVisible(heroLabelStartLevel, visible)
    call BlzFrameSetVisible(startLocationLabel, visible)
    call BlzFrameSetVisible(raceLabel, visible)
    call BlzFrameSetVisible(labelProfession, visible)
    call BlzFrameSetVisible(goldLabel, visible)
    call BlzFrameSetVisible(lumberLabel, visible)
    call BlzFrameSetVisible(foodLimitLabel, visible)
    call BlzFrameSetVisible(evolutionLabel, visible)
    call BlzFrameSetVisible(attacksLabel, visible)
    call BlzFrameSetVisible(heroesLabel, visible)
    call BlzFrameSetVisible(expansionsLabel, visible)
    call BlzFrameSetVisible(sharedControlLabel, visible)
    call BlzFrameSetVisible(difficultyLabel, visible)
    call BlzFrameSetVisible(applyButton, visible)
    call BlzFrameSetVisible(previousPageButton, visible)
    call BlzFrameSetVisible(nextPageButton, visible)

    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), Force)) then
            if ((visible and counter >= counterStart and counter <= counterEnd) or not visible) then
                call BlzFrameSetVisible(playerNameEdit[counter], visible)
                call BlzFrameSetVisible(colorLabelPopup[counter], visible)
                call BlzFrameSetVisible(colorComboBox[counter], visible)
                call BlzFrameSetVisible(colorLabelArrowUp[counter], visible)
                call BlzFrameSetVisible(colorLabelArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(colorLabelArrowDown[counter], visible)
                call BlzFrameSetVisible(colorLabelArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(teamComboBox[counter], visible)
                call BlzFrameSetVisible(heroComboBox[counter], visible)
                call BlzFrameSetVisible(heroComboBoxArrowUp[counter], visible)
                call BlzFrameSetVisible(heroComboBoxArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(heroComboBoxArrowDown[counter], visible)
                call BlzFrameSetVisible(heroComboBoxArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(heroLabelStartLevelEdit[counter], visible)
                call BlzFrameSetVisible(startLocationComboBox[counter], visible)
                call BlzFrameSetVisible(startLocationComboBoxArrowUp[counter], visible)
                call BlzFrameSetVisible(startLocationComboBoxArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(startLocationComboBoxArrowDown[counter], visible)
                call BlzFrameSetVisible(startLocationComboBoxArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(raceLabelEdit[counter], visible)
                call BlzFrameSetVisible(raceLabelEditArrowUp[counter], visible)
                call BlzFrameSetVisible(raceLabelEditArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(raceLabelEditArrowDown[counter], visible)
                call BlzFrameSetVisible(raceLabelEditArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(professionComboBox[counter], visible)
                call BlzFrameSetVisible(goldEdit[counter], visible)
                call BlzFrameSetVisible(lumberEdit[counter], visible)
                call BlzFrameSetVisible(foodEdit[counter], visible)
                call BlzFrameSetVisible(evolutionEdit[counter], visible)
                call BlzFrameSetVisible(attacksCheckBox[counter], visible)
                call BlzFrameSetVisible(heroesEdit[counter], visible)
                call BlzFrameSetVisible(expansionsEdit[counter], visible)
                call BlzFrameSetVisible(sharedControlCheckBox[counter], visible)
                call BlzFrameSetVisible(difficultyComboBox[counter], visible)
            endif

            set counter = counter + 1
        endif
        set i = i + 1
    endloop
endfunction

function SetAiPlayersUiVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
    if (visible) then
        call UpdateComputerPlayersTitle()
    endif
    if (whichPlayer == GetLocalPlayer()) then
        call SetVisible(visible)
    endif
endfunction

function ShowAiPlayersUiForPlayer takes player whichPlayer returns nothing
    call SetAiPlayersUiVisibleForPlayer(whichPlayer, true)
endfunction

function HideAiPlayersUiForPlayer takes player whichPlayer returns nothing
    call SetAiPlayersUiVisibleForPlayer(whichPlayer, false)
endfunction

function HideAiPlayersUi takes nothing returns nothing
    call SetVisible(false)
endfunction

private function TriggerActionSyncData takes nothing returns nothing
    local player triggerPlayer = GetTriggerPlayer()
    local string prefix = BlzGetTriggerSyncPrefix()
    local string data = BlzGetTriggerSyncData()
    local integer playerId = GetPlayerId(triggerPlayer)
    local string indexString = StringTokenEx(data, 1, "_", false)
    local integer index = S2I(indexString)
    local string actualData = StringTokenEx(data, 2, "_", false)
    //call BJDebugMsg("Synced data " + data + " with prefix " + prefix + " leading to index " + I2S(index) + " and actual data: " + actualData + ".")
    if (data == "Done") then
        set SyncDone[playerId] = true
        //call BJDebugMsg("Synced done")
    elseif (StringStartsWith(data, "PlayerName")) then
        set PlayerNames[index] = actualData
    elseif (StringStartsWith(data, "Color")) then
        set Color[index] = S2I(actualData)
    elseif (StringStartsWith(data, "Team")) then
        set Teams[index] = S2I(actualData)
    elseif (StringStartsWith(data, "HeroStartLevel")) then
        set HeroStartLevels[index] = S2I(actualData)
    elseif (StringStartsWith(data, "StartHero")) then
        set Heroes[index] = S2I(actualData)
    elseif (StringStartsWith(data, "StartLocation")) then
        set StartLocations[index] = S2I(actualData)
    elseif (StringStartsWith(data, "Races")) then
        set Races[index] = S2I(actualData)
    elseif (StringStartsWith(data, "Profession")) then
        set Professions[index] = S2I(actualData)
    elseif (StringStartsWith(data, "StartGold")) then
        set StartGold[index] = S2I(actualData)
    elseif (StringStartsWith(data, "StartLumber")) then
        set StartLumber[index] = S2I(actualData)
    elseif (StringStartsWith(data, "FoodLimit")) then
        set FoodLimit[index] = S2I(actualData)
    elseif (StringStartsWith(data, "StartEvolution")) then
        set StartEvolution[index] = S2I(actualData)
   elseif (StringStartsWith(data, "AttackPlayers")) then
        set AttackPlayers[index] = S2I(actualData)
    elseif (StringStartsWith(data, "HeroesCount")) then
        set HeroesCount[index] = S2I(actualData)
    elseif (StringStartsWith(data, "Expansions")) then
        set Expansions[index] = S2I(actualData)
    elseif (StringStartsWith(data, "SharedControl")) then
        set SharedControl[index] = S2I(actualData)
    elseif (StringStartsWith(data, "Difficulty")) then
        set Difficulty[index] = S2I(actualData)
    endif
    set triggerPlayer = null
endfunction

private function SyncData takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer index = 0
    local integer counter = Counter
    local integer i = 0
    loop
        exitwhen (i >= counter)
        set index = i
        if (GetLocalPlayer() == whichPlayer) then
            call BlzSendSyncData(PREFIX, "PlayerName_" + I2S(index) + "_" + BlzFrameGetText(playerNameEdit[index]))
            call BlzSendSyncData(PREFIX, "Color_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(colorLabelPopup[index]))))
            call BlzSendSyncData(PREFIX, "Team_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(teamComboBox[index]))))
            call BlzSendSyncData(PREFIX, "StartHero_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(heroComboBox[index]))))
            call BlzSendSyncData(PREFIX, "HeroStartLevel_" + I2S(index) + "_" + BlzFrameGetText(heroLabelStartLevelEdit[index]))
            call BlzSendSyncData(PREFIX, "StartLocation_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(startLocationComboBox[index]))))
            call BlzSendSyncData(PREFIX, "Races_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(raceLabelEdit[index]))))
            call BlzSendSyncData(PREFIX, "Profession_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(professionComboBox[index]))))
            call BlzSendSyncData(PREFIX, "StartGold_" + I2S(index) + "_" + BlzFrameGetText(goldEdit[index]))
            call BlzSendSyncData(PREFIX, "StartLumber_" + I2S(index) + "_" + BlzFrameGetText(lumberEdit[index]))
            call BlzSendSyncData(PREFIX, "FoodLimit_" + I2S(index) + "_" + BlzFrameGetText(foodEdit[index]))
            call BlzSendSyncData(PREFIX, "StartEvolution_" + I2S(index) + "_" + BlzFrameGetText(evolutionEdit[index]))
            call BlzSendSyncData(PREFIX, "AttackPlayers_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(attacksCheckBox[index]))))
            call BlzSendSyncData(PREFIX, "HeroesCount_" + I2S(index) + "_" + BlzFrameGetText(heroesEdit[index]))
            call BlzSendSyncData(PREFIX, "Expansions_" + I2S(index) + "_" + BlzFrameGetText(expansionsEdit[index]))
            call BlzSendSyncData(PREFIX, "SharedControl_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(sharedControlCheckBox[index]))))
            call BlzSendSyncData(PREFIX, "Difficulty_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(difficultyComboBox[index]))))
        endif
        set i = i + 1
    endloop
    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData(PREFIX, "Done")
    endif
    // wait for sync is done
    loop
        exitwhen (SyncDone[playerId])
        call TriggerSleepAction(5.0)
        //call BJDebugMsg("Polling")
    endloop
    set SyncDone[playerId] = false
endfunction

private function ApplyFunction takes nothing returns nothing
    call HideAiPlayersUiForPlayer(GetTriggerPlayer())
    call SyncData(GetTriggerPlayer())
    set WoWReforgedComputer_startLobbySettingsPlayer = GetTriggerPlayer()
    call TriggerExecute(WoWReforgedComputer_startLobbySettingsTrigger)
endfunction

private function GetPlayerIndex takes player whichPlayer returns integer
    local integer index = 0
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), Force)) then
            if (Player(i) == whichPlayer) then
                return index
            else
                set index = index + 1
            endif
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function AiPlayersUIGetPlayerName takes player whichPlayer returns string
    local integer index = GetPlayerIndex(whichPlayer)

    if (index != -1) then
        return PlayerNames[index]
    endif

    return GetPlayerName(whichPlayer)
endfunction

function AiPlayersUIGetColor takes player whichPlayer returns playercolor
    local integer index = GetPlayerIndex(whichPlayer)

    if (index != -1) then
        return ConvertPlayerColor(Color[index])
    endif

    return GetPlayerColor(whichPlayer)
endfunction

function AiPlayersUIGetTeam takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)

    if (index != -1) then
        return Teams[index]
    endif

    return GetPlayerTeam(whichPlayer)
endfunction

function AiPlayersUIGetHero takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0

    if (index != -1) then
        set frameValue = Heroes[index]

        if (frameValue == HEROES_MENU_ITEM_RANDOM_MATCHING_RACE) then
            return ChooseRandomHeroFromRace(GetPlayerRace1(whichPlayer))
        elseif (frameValue == HEROES_MENU_ITEM_RANDOM) then
            return GetRandomInt(0, GetHeroesMax() - 1)
        endif
    endif

    return frameValue - HEROES_MENU_ITEM_RANDOM - 1
endfunction

function AiPlayersUIGetHeroStartLevel takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return HeroStartLevels[index]
    endif

    return 1
endfunction

function AiPlayersUIChooseComputerStartLocation takes integer startIndex returns integer
    local integer i = startIndex
    local integer max = GetMaxComputerStartLocations()
    loop
        exitwhen (i >= max)
        if (not GetComputerStartLocation(i).taken) then
            return i
        endif
        set i = i + 1
    endloop
    if (startIndex > 0) then
        return AiPlayersUIChooseComputerStartLocation(0)
    endif
    return -1
endfunction

function AiPlayersUIChooseComputerStartLocationTeam takes integer team returns integer
    local integer i = 0
    local integer max = GetMaxComputerStartLocations()
    local integer array choices
    local integer choicesCounter = 0
    loop
        exitwhen (i >= max)
        if (not GetComputerStartLocation(i).taken and GetComputerStartLocation(i).hasTeam(team)) then
            set choices[choicesCounter] = i
            set choicesCounter = choicesCounter + 1
        endif
        set i = i + 1
    endloop
    call BJDebugMsg("Choose computer start location with team " + I2S(team) + " and matches " + I2S(choicesCounter))
    if (choicesCounter > 0) then
        return AiPlayersUIChooseComputerStartLocation(choices[GetRandomInt(0, choicesCounter - 1)])
    endif
    return -1
endfunction

function AiPlayersUIChooseComputerStartLocationAlliance takes nothing returns integer
    return AiPlayersUIChooseComputerStartLocationTeam(0)
endfunction

function AiPlayersUIChooseComputerStartLocationHorde takes nothing returns integer
    return AiPlayersUIChooseComputerStartLocationTeam(1)
endfunction

function AiPlayersUIGetPlayerWarlord takes player whichPlayer returns boolean
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0
    if (index != -1) then
        set frameValue = Races[index]
        if (frameValue == RACES_MENU_ITEM_RANDOM) then
            return GetRandomInt(0, 1) == 0
        elseif (frameValue == RACES_MENU_ITEM_RANDOM_FREELANCER) then
            return false
        endif
    endif

    return true
endfunction

function AiPlayersUIGetPlayerRace takes player whichPlayer, integer startLocation, integer team returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0
    local integer random = 0

    if (index != -1) then
        set frameValue = Races[index]
        if (frameValue == RACES_MENU_ITEM_MATCHING_START_LOCATION) then
            call BJDebugMsg("RACES_MENU_ITEM_MATCHING_START_LOCATION")
            return GetComputerStartLocation(startLocation).getRandomPossibleRace(team)
        elseif (frameValue == RACES_MENU_ITEM_RANDOM_WARLORD) then
            return GetRandomWarlordRaceWithAISupport()
        elseif (frameValue == RACES_MENU_ITEM_RANDOM_ALLIANCE) then
            return GetRandomWarlordAllianceRaceWithAISupport()
        elseif (frameValue == RACES_MENU_ITEM_RANDOM_HORDE) then
            return GetRandomWarlordHordeRaceWithAISupport()
        elseif (frameValue == RACES_MENU_ITEM_RANDOM) then
            return GetRandomRaceWithAISupport()
        elseif (frameValue == RACES_MENU_ITEM_RANDOM_FREELANCER) then
            return udg_RaceFreelancer
        else
            return frameValue - RACES_MENU_ITEM_RANDOM_HORDE // Ignore Freelancer race
        endif
    endif

    call BJDebugMsg("AiPlayersUIGetPlayerRace udg_RaceNone")

    return udg_RaceNone
endfunction

function AiPlayersUIGetPlayerProfession takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0

    if (index != -1) then
        set frameValue = Professions[index]
        if (frameValue == PROFESSIONS_MENU_ITEM_HERBALIST) then
            return udg_ProfessionHerbalist
        elseif (frameValue == PROFESSIONS_MENU_ITEM_ALCHEMIST) then
            return udg_ProfessionAlchemist
        elseif (frameValue == PROFESSIONS_MENU_ITEM_WEAPON_SMITH) then
            return udg_ProfessionWeaponSmith
        elseif (frameValue == PROFESSIONS_MENU_ITEM_ARMORER) then
            return udg_ProfessionArmourer
        elseif (frameValue == PROFESSIONS_MENU_ITEM_ENGINEER) then
            return udg_ProfessionEngineer
        elseif (frameValue == PROFESSIONS_MENU_ITEM_DEMOLITION_EXPERT) then
            return udg_ProfessionDemolitionExpert
        elseif (frameValue == PROFESSIONS_MENU_ITEM_DRAGON_BREEDER) then
            return udg_ProfessionDragonBreeder
        elseif (frameValue == PROFESSIONS_MENU_ITEM_LORE_MASTER) then
            return udg_ProfessionLoreMaster
        elseif (frameValue == PROFESSIONS_MENU_ITEM_RUNE_FORGER) then
            return udg_ProfessionRuneforger
        elseif (frameValue == PROFESSIONS_MENU_ITEM_SORCERER) then
            return udg_ProfessionSorcerer
        elseif (frameValue == PROFESSIONS_MENU_ITEM_JEWELCRAFTER) then
            return udg_ProfessionJewelcrafter
        elseif (frameValue == PROFESSIONS_MENU_ITEM_ARCHAEOLOGIST) then
            return udg_ProfessionArchaeologist
        elseif (frameValue == PROFESSIONS_MENU_ITEM_WITCH_DOCTOR) then
            return udg_ProfessionWitchDoctor
        elseif (frameValue == PROFESSIONS_MENU_ITEM_TAMER) then
            return udg_ProfessionTamer
        elseif (frameValue == PROFESSIONS_MENU_ITEM_NECROMANCER) then
            return udg_ProfessionNecromancer
        elseif (frameValue == PROFESSIONS_MENU_ITEM_GOLEM_SCULPTOR) then
            return udg_ProfessionGolemSculptor
        elseif (frameValue == PROFESSIONS_MENU_ITEM_WARLOCK) then
            return udg_ProfessionWarlock
        elseif (frameValue == PROFESSIONS_MENU_ITEM_ASTROMANCER) then
            return udg_ProfessionAstromancer
        endif
    endif

    return GetRandomComputerProfession()
endfunction

function AiPlayersUIGetStartLocation takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0

    if (index != -1) then
        set frameValue = StartLocations[index]
        if (frameValue == START_LOCATION_MENU_ITEM_RANDOM_MATCHING_TEAM) then
            return AiPlayersUIChooseComputerStartLocationTeam(Teams[index])
        elseif (frameValue == START_LOCATION_MENU_ITEM_RANDOM) then
            return AiPlayersUIChooseComputerStartLocation(GetRandomInt(0, GetMaxComputerStartLocations() - 1))
        elseif (frameValue == START_LOCATION_MENU_ITEM_RANDOM_ALLIANCE) then
            return AiPlayersUIChooseComputerStartLocationAlliance()
        elseif (frameValue == START_LOCATION_MENU_ITEM_RANDOM_HORDE) then
            return AiPlayersUIChooseComputerStartLocationHorde()
        else
            return AiPlayersUIChooseComputerStartLocation(frameValue - START_LOCATION_MENU_ITEM_TERDRASSIL)
        endif
    endif

    return AiPlayersUIChooseComputerStartLocation(0)
endfunction

function AiPlayersUIGetStartGold takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return StartGold[index]
    endif

    return START_GOLD
endfunction

function AiPlayersUIGetStartLumber takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return StartLumber[index]
    endif

    return START_LUMBER
endfunction

function AiPlayersUIGetFoodLimit takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return FoodLimit[index]
    endif

    return 300
endfunction

function AiPlayersUIGetStartEvolution takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return StartEvolution[index]
    endif

    return 1
endfunction

function AiPlayersUIGetAttackPlayers takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return AttackPlayers[index]
    endif

    return 1
endfunction

function AiPlayersUIGetHeroesCount takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return HeroesCount[index]
    endif

    return 1
endfunction

function AiPlayersUIGetExpansions takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return Expansions[index]
    endif

    return 1
endfunction

function AiPlayersUIGetSharedControl takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return SharedControl[index]
    endif

    return 1
endfunction

function AiPlayersUIGetDifficulty takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return Difficulty[index]
    endif

    return 1 // normal
endfunction

private function ColorPopupMenuFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetTexture(colorComboBox[index], GetPlayerColorTexture(ConvertPlayerColor(R2I(BlzFrameGetValue(colorLabelPopup[index])))), 0, true)
    endif
endfunction

private function ColorUpFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    local integer c = 0

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        set c = R2I(BlzFrameGetValue(colorLabelPopup[index]))
        if (c == 0) then
            set c = 23
        else
            set c = c - 1
        endif
        call BlzFrameSetValue(colorLabelPopup[index], c)
        call BlzFrameSetTexture(colorComboBox[index], GetPlayerColorTexture(ConvertPlayerColor(c)), 0, true)
    endif
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function ColorDownFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    local integer c = 0

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        set c = R2I(BlzFrameGetValue(colorLabelPopup[index]))
        if (c == 23) then
            set c = 0
        else
            set c = c + 1
        endif
        call BlzFrameSetValue(colorLabelPopup[index], c)
        call BlzFrameSetTexture(colorComboBox[index], GetPlayerColorTexture(ConvertPlayerColor(c)), 0, true)
    endif
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function HeroUpFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(heroComboBox[index]) == 0) then
            call BlzFrameSetValue(heroComboBox[index], HEROES_MENU_ITEM_FINAL)
        else
            call BlzFrameSetValue(heroComboBox[index], BlzFrameGetValue(heroComboBox[index]) - 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function HeroDownFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(heroComboBox[index]) == HEROES_MENU_ITEM_FINAL) then
            call BlzFrameSetValue(heroComboBox[index], 0)
        else
            call BlzFrameSetValue(heroComboBox[index], BlzFrameGetValue(heroComboBox[index]) + 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function GetStartLocationsLastIndex takes nothing returns integer
    return GetMaxComputerStartLocations() + START_LOCATION_MENU_ITEM_RANDOM_HORDE
endfunction

private function StartLocationUpFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(startLocationComboBox[index]) == 0) then
            call BlzFrameSetValue(startLocationComboBox[index], GetStartLocationsLastIndex())
        else
            call BlzFrameSetValue(startLocationComboBox[index], BlzFrameGetValue(startLocationComboBox[index]) - 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function StartLocationDownFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(startLocationComboBox[index]) == GetStartLocationsLastIndex()) then
            call BlzFrameSetValue(startLocationComboBox[index], 0)
        else
            call BlzFrameSetValue(startLocationComboBox[index], BlzFrameGetValue(startLocationComboBox[index]) + 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function GetRacesLastIndex takes nothing returns integer
    return GetRacesMax() - 1 + RACES_MENU_ITEM_RANDOM_HORDE
endfunction

private function RaceUpFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(raceLabelEdit[index]) == 0) then
            call BlzFrameSetValue(raceLabelEdit[index], GetRacesLastIndex())
        else
            call BlzFrameSetValue(raceLabelEdit[index], BlzFrameGetValue(raceLabelEdit[index]) - 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function RaceDownFunction takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(raceLabelEdit[index]) == GetRacesLastIndex()) then
            call BlzFrameSetValue(raceLabelEdit[index], 0)
        else
            call BlzFrameSetValue(raceLabelEdit[index], BlzFrameGetValue(raceLabelEdit[index]) + 1)
        endif
    endif

    call PlayClickSound(GetTriggerPlayer())
endfunction

private function PreviousPageFunction takes nothing returns nothing
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (Page == 0) then
            set Page = Counter - 1
        else
            set Page = Page - 1
        endif

        call UpdateComputerPlayersTitle()
    endif

    call SetAiPlayersUiVisibleForPlayer(GetTriggerPlayer(), false)
    call SetAiPlayersUiVisibleForPlayer(GetTriggerPlayer(), true)
endfunction

private function NextPageFunction takes nothing returns nothing
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (Page == Counter - 1) then
            set Page = 0
        else
            set Page = Page + 1
        endif

        call UpdateComputerPlayersTitle()
    endif

    call SetAiPlayersUiVisibleForPlayer(GetTriggerPlayer(), false)
    call SetAiPlayersUiVisibleForPlayer(GetTriggerPlayer(), true)
endfunction

function CreateAiPlayersUiEx takes force aiPlayers returns nothing
    local integer i = 0
    local integer counter = 0
    local player aiPlayer = null
    local integer index = 0
    local real x
    local real y
    local integer playerColor = 0
    local integer team = 0

    set backgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(backgroundFrame, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_Y)
    call BlzFrameSetAbsPoint(backgroundFrame, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_Y - UI_FULLSCREEN_HEIGHT)

    set titleFrame = BlzCreateFrameByType("TEXT", "AiPlayersGuiTitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(titleFrame, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_TITLE_Y)
    call BlzFrameSetAbsPoint(titleFrame, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_TITLE_Y - UI_FULLSCREEN_TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(titleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    // line 1
    set y = LINE_HEADERS_Y

    set playerNameLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLinePlayerName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(playerNameLabel, FRAMEPOINT_TOPLEFT, COLUMN_PLAYER_NAME_X, y)
    call BlzFrameSetAbsPoint(playerNameLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_PLAYER_NAME_X + COLUMN_PLAYER_NAME_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(playerNameLabel, GetLocalizedStringSafe("NAME"))
    call BlzFrameSetTextAlignment(playerNameLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set colorLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineColor", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(colorLabel, FRAMEPOINT_TOPLEFT, COLUMN_COLOR_X, y)
    call BlzFrameSetAbsPoint(colorLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_COLOR_X + COLUMN_COLOR_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(colorLabel, GetLocalizedStringSafe("COLOR")) // Color
    call BlzFrameSetTextAlignment(colorLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set teamLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineTeam", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(teamLabel, FRAMEPOINT_TOPLEFT, COLUMN_TEAM_X, y)
    call BlzFrameSetAbsPoint(teamLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_TEAM_X + COLUMN_TEAM_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(teamLabel, GetLocalizedStringSafe("TEAM"))
    call BlzFrameSetTextAlignment(teamLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set heroLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHero", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(heroLabel, FRAMEPOINT_TOPLEFT, COLUMN_HERO_X, y)
    call BlzFrameSetAbsPoint(heroLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_X + COLUMN_HERO_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(heroLabel, GetLocalizedStringSafe("HERO"))
    call BlzFrameSetTextAlignment(heroLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set heroLabelStartLevel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHeroStartLevel", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(heroLabelStartLevel, FRAMEPOINT_TOPLEFT, COLUMN_HERO_START_LEVEL_X, y)
    call BlzFrameSetAbsPoint(heroLabelStartLevel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_START_LEVEL_X + COLUMN_HERO_START_LEVEL_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(heroLabelStartLevel, GetLocalizedStringSafe("LEVEL"))
    call BlzFrameSetTextAlignment(heroLabelStartLevel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    // line 2
    set y = y - LINE_HEADERS_HEIGHT - LINE_HEIGHT - LINE_HEIGHT_SPACING

    set startLocationLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLocation", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(startLocationLabel, FRAMEPOINT_TOPLEFT, COLUMN_START_LOCATION_X, y)
    call BlzFrameSetAbsPoint(startLocationLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LOCATION_X + COLUMN_START_LOCATION_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(startLocationLabel, GetLocalizedStringSafe("LOCATION_WARLORD_ONLY"))
    call BlzFrameSetTextAlignment(startLocationLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set raceLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineRace", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(raceLabel, FRAMEPOINT_TOPLEFT, COLUMN_RACE_X, y)
    call BlzFrameSetAbsPoint(raceLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_RACE_X + COLUMN_RACE_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(raceLabel, GetLocalizedStringSafe("RACE"))
    call BlzFrameSetTextAlignment(raceLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set labelProfession = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineProfession", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(labelProfession, FRAMEPOINT_TOPLEFT, COLUMN_PROFESSION_X, y)
    call BlzFrameSetAbsPoint(labelProfession, FRAMEPOINT_BOTTOMRIGHT, COLUMN_PROFESSION_X + COLUMN_PROFESSION_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(labelProfession, GetLocalizedStringSafe("PROFESSION"))
    call BlzFrameSetTextAlignment(labelProfession, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    // line 3
    set y = y - LINE_HEADERS_HEIGHT - LINE_HEIGHT - LINE_HEIGHT_SPACING

    set goldLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartGold", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(goldLabel, FRAMEPOINT_TOPLEFT, COLUMN_START_GOLD_X, y)
    call BlzFrameSetAbsPoint(goldLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_GOLD_X + COLUMN_START_GOLD_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(goldLabel, GetLocalizedStringSafe("GOLD"))
    call BlzFrameSetTextAlignment(goldLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set lumberLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLumber", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(lumberLabel, FRAMEPOINT_TOPLEFT, COLUMN_START_LUMBER_X, y)
    call BlzFrameSetAbsPoint(lumberLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LUMBER_X + COLUMN_START_LUMBER_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(lumberLabel, GetLocalizedStringSafe("LUMBER"))
    call BlzFrameSetTextAlignment(lumberLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set foodLimitLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineFoodLimit", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(foodLimitLabel, FRAMEPOINT_TOPLEFT, COLUMN_FOOD_LIMIT_X, y)
    call BlzFrameSetAbsPoint(foodLimitLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_FOOD_LIMIT_X + COLUMN_FOOD_LIMIT_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(foodLimitLabel, GetLocalizedStringSafe("FOOD_MAXIMUM"))
    call BlzFrameSetTextAlignment(foodLimitLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set evolutionLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartEvolution", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(evolutionLabel, FRAMEPOINT_TOPLEFT, COLUMN_START_EVOLUTION_X, y)
    call BlzFrameSetAbsPoint(evolutionLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_EVOLUTION_X + COLUMN_START_EVOLUTION_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(evolutionLabel, GetLocalizedStringSafe("EVOLUTION"))
    call BlzFrameSetTextAlignment(evolutionLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set attacksLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineAttackPlayers", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(attacksLabel, FRAMEPOINT_TOPLEFT, COLUMN_ATTACK_PLAYERS_X, y)
    call BlzFrameSetAbsPoint(attacksLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_ATTACK_PLAYERS_X + COLUMN_ATTACK_PLAYERS_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(attacksLabel, GetLocalizedStringSafe("ATTACKS")) // Attacks
    call BlzFrameSetTextAlignment(attacksLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set heroesLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHeroes", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(heroesLabel, FRAMEPOINT_TOPLEFT, COLUMN_HEROES_X, y)
    call BlzFrameSetAbsPoint(heroesLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_HEROES_X + COLUMN_HEROES_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(heroesLabel, GetLocalizedStringSafe("HEROES"))
    call BlzFrameSetTextAlignment(heroesLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set expansionsLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineExpansions", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(expansionsLabel, FRAMEPOINT_TOPLEFT, COLUMN_EXPANSIONS_X, y)
    call BlzFrameSetAbsPoint(expansionsLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_EXPANSIONS_X + COLUMN_EXPANSIONS_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(expansionsLabel, GetLocalizedStringSafe("EXPANSIONS"))
    call BlzFrameSetTextAlignment(expansionsLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set sharedControlLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineSharedControl", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(sharedControlLabel, FRAMEPOINT_TOPLEFT, COLUMN_SHARED_CONTROL_X, y)
    call BlzFrameSetAbsPoint(sharedControlLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_SHARED_CONTROL_X + COLUMN_SHARED_CONTROL_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(sharedControlLabel, GetLocalizedStringSafe("SHARED"))
    call BlzFrameSetTextAlignment(sharedControlLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set difficultyLabel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineDifficulty", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(difficultyLabel, FRAMEPOINT_TOPLEFT, COLUMN_DIFFICULTY_X, y)
    call BlzFrameSetAbsPoint(difficultyLabel, FRAMEPOINT_BOTTOMRIGHT, COLUMN_DIFFICULTY_X + COLUMN_DIFFICULTY_WIDTH, y - LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(difficultyLabel, GetLocalizedStringSafe("DIFFICULTY"))
    call BlzFrameSetTextAlignment(difficultyLabel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    if (Force != null) then
        call ForceClear(Force)
        call DestroyForce(Force)
        set Force = null
    endif

    set Force = CreateForce()

    // players
    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set aiPlayer = Player(i)
        if (IsPlayerInForce(aiPlayer, aiPlayers)) then
            call ForceAddPlayer(Force, aiPlayer)

            set index = counter

            // line 1
            set y = LINE_HEADERS_Y - LINE_HEADERS_HEIGHT

            set playerNameEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(playerNameEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_PLAYER_NAME_X, y)
            call BlzFrameSetAbsPoint(playerNameEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_PLAYER_NAME_X + COLUMN_PLAYER_NAME_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(playerNameEdit[index], GetPlayerName(aiPlayer))
            set PlayerNames[index] = GetPlayerName(aiPlayer)
            call BlzFrameSetEnable(playerNameEdit[index], true)

            set colorLabelPopup[index] = BlzCreateFrame("PlayerColorsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(colorLabelPopup[index], FRAMEPOINT_TOPLEFT, COLUMN_COLOR_X, y)
            call BlzFrameSetAbsPoint(colorLabelPopup[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_COLOR_X + COLUMN_COLOR_WIDTH, y - LINE_HEIGHT)
            set playerColor = IMinBJ(23, GetHandleId(GetPlayerColor(aiPlayer)))
            call BlzFrameSetValue(colorLabelPopup[index], playerColor)
            call BlzFrameSetEnable(colorLabelPopup[index], true)

            if (colorPopupMenuTrigger[index] != null) then
                call DestroyTrigger(colorPopupMenuTrigger[index])
                set colorPopupMenuTrigger[index] = null
            endif

            set colorPopupMenuTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(colorPopupMenuTrigger[index], colorLabelPopup[index], FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
            call TriggerAddAction(colorPopupMenuTrigger[index], function ColorPopupMenuFunction)
            call SaveInteger(h, GetHandleId(colorPopupMenuTrigger[index]), 0, index)

            set colorComboBox[index] = BlzCreateFrameByType("BACKDROP", "ColorFrame" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(colorComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_COLOR_EDIT_X, y - 0.04)
            call BlzFrameSetAbsPoint(colorComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_COLOR_EDIT_X + COLUMN_COLOR_EDIT_WIDTH, y - 0.04 - COLUMN_COLOR_EDIT_HEIGHT)
            call BlzFrameSetTexture(colorComboBox[index], GetPlayerColorTexture(GetPlayerColor(aiPlayer)), 0, true)
            call BlzFrameSetEnable(colorComboBox[index], true)

            //call BJDebugMsg("Texture: " + GetPlayerColorTexture(GetPlayerColor(aiPlayer)))

            set colorLabelArrowUp[index] = BlzCreateFrameByType("BUTTON", "ColorUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(colorLabelArrowUp[index], FRAMEPOINT_TOPLEFT, COLUMN_COLOR_X, y - 0.04)
            call BlzFrameSetAbsPoint(colorLabelArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_COLOR_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(colorLabelArrowUp[index], true)

            set colorLabelArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "ColorUpFrame" + I2S(index), colorLabelArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(colorLabelArrowUpFrame[index], colorLabelArrowUp[index])
            call BlzFrameSetTexture(colorLabelArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(colorLabelArrowUpFrame[index], true)

            if (colorUpTrigger[index] != null) then
                call DestroyTrigger(colorUpTrigger[index])
                set colorUpTrigger[index] = null
            endif

            set colorUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(colorUpTrigger[index], colorLabelArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(colorUpTrigger[index], function ColorUpFunction)
            call SaveInteger(h, GetHandleId(colorUpTrigger[index]), 0, index)

            set colorLabelArrowDown[index] = BlzCreateFrameByType("BUTTON", "ColorDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(colorLabelArrowDown[index], FRAMEPOINT_TOPLEFT, COLUMN_COLOR_X, y - 0.07)
            call BlzFrameSetAbsPoint(colorLabelArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_COLOR_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(colorLabelArrowDown[index], true)

            set colorLabelArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "ColoreDownFrame" + I2S(index), colorLabelArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(colorLabelArrowDownFrame[index], colorLabelArrowDown[index])
            call BlzFrameSetTexture(colorLabelArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(colorLabelArrowDownFrame[index], true)

            if (colorDownTrigger[index] != null) then
                call DestroyTrigger(colorDownTrigger[index])
                set colorDownTrigger[index] = null
            endif

            set colorDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(colorDownTrigger[index], colorLabelArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(colorDownTrigger[index], function ColorDownFunction)
            call SaveInteger(h, GetHandleId(colorDownTrigger[index]), 0, index)

            set teamComboBox[index] = BlzCreateFrame("TeamPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(teamComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_TEAM_X, y)
            call BlzFrameSetAbsPoint(teamComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_TEAM_X + COLUMN_TEAM_WIDTH, y - LINE_HEIGHT)
            set team = IMinBJ(TEAM_MAX_AI - 1, GetPlayerTeam(aiPlayer))
            call BlzFrameSetValue(teamComboBox[index], team)
            set Teams[index] = team
            call BlzFrameSetEnable(teamComboBox[index], true)

            set heroComboBox[index] = BlzCreateFrame("HeroesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(heroComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_HERO_X, y)
            call BlzFrameSetAbsPoint(heroComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_X + COLUMN_HERO_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetValue(heroComboBox[index], HEROES_MENU_ITEM_RANDOM_MATCHING_RACE)
            set Heroes[index] = HEROES_MENU_ITEM_RANDOM_MATCHING_RACE
            call BlzFrameSetEnable(heroComboBox[index], true)

            set heroComboBoxArrowUp[index] = BlzCreateFrameByType("BUTTON", "HeroUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(heroComboBoxArrowUp[index], FRAMEPOINT_TOPLEFT, COLUMN_HERO_X, y - 0.04)
            call BlzFrameSetAbsPoint(heroComboBoxArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(heroComboBoxArrowUp[index], true)

            set heroComboBoxArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "HeroUpFrame" + I2S(index), heroComboBoxArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(heroComboBoxArrowUpFrame[index], heroComboBoxArrowUp[index])
            call BlzFrameSetTexture(heroComboBoxArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(heroComboBoxArrowUpFrame[index], true)

            if (heroUpTrigger[index] != null) then
                call DestroyTrigger(heroUpTrigger[index])
                set heroUpTrigger[index] = null
            endif

            set heroUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(heroUpTrigger[index], heroComboBoxArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(heroUpTrigger[index], function HeroUpFunction)
            call SaveInteger(h, GetHandleId(heroUpTrigger[index]), 0, index)

            set heroComboBoxArrowDown[index] = BlzCreateFrameByType("BUTTON", "HeroDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(heroComboBoxArrowDown[index], FRAMEPOINT_TOPLEFT, COLUMN_HERO_X, y - 0.07)
            call BlzFrameSetAbsPoint(heroComboBoxArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(heroComboBoxArrowDown[index], true)

            set heroComboBoxArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "HeroeDownFrame" + I2S(index), heroComboBoxArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(heroComboBoxArrowDownFrame[index], heroComboBoxArrowDown[index])
            call BlzFrameSetTexture(heroComboBoxArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(heroComboBoxArrowDownFrame[index], true)

            if (heroDownTrigger[index] != null) then
                call DestroyTrigger(heroDownTrigger[index])
                set heroDownTrigger[index] = null
            endif

            set heroDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(heroDownTrigger[index], heroComboBoxArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(heroDownTrigger[index], function HeroDownFunction)
            call SaveInteger(h, GetHandleId(heroDownTrigger[index]), 0, index)

            set heroLabelStartLevelEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(heroLabelStartLevelEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_HERO_START_LEVEL_X, y)
            call BlzFrameSetAbsPoint(heroLabelStartLevelEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_HERO_START_LEVEL_X + COLUMN_HERO_START_LEVEL_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(heroLabelStartLevelEdit[index], "1")
            set HeroStartLevels[index] = 1
            call BlzFrameSetEnable(heroLabelStartLevelEdit[index], true)

            // line 2
            set y = y - LINE_HEIGHT - LINE_HEIGHT_SPACING - LINE_HEADERS_HEIGHT

            set startLocationComboBox[index] = BlzCreateFrame("StartLocationsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(startLocationComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_START_LOCATION_X, y)
            call BlzFrameSetAbsPoint(startLocationComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LOCATION_X + COLUMN_START_LOCATION_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetValue(startLocationComboBox[index], 0)
            set StartLocations[index] = 0
            call BlzFrameSetEnable(startLocationComboBox[index], true)

            set startLocationComboBoxArrowUp[index] = BlzCreateFrameByType("BUTTON", "StartLocationUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(startLocationComboBoxArrowUp[index], FRAMEPOINT_TOPLEFT, COLUMN_START_LOCATION_X, y - 0.04)
            call BlzFrameSetAbsPoint(startLocationComboBoxArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LOCATION_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(startLocationComboBoxArrowUp[index], true)

            set startLocationComboBoxArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "StartLocationUpFrame" + I2S(index), startLocationComboBoxArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(startLocationComboBoxArrowUpFrame[index], startLocationComboBoxArrowUp[index])
            call BlzFrameSetTexture(startLocationComboBoxArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(startLocationComboBoxArrowUpFrame[index], true)

            if (startLocationUpTrigger[index] != null) then
                call DestroyTrigger(startLocationUpTrigger[index])
                set startLocationUpTrigger[index] = null
            endif

            set startLocationUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(startLocationUpTrigger[index], startLocationComboBoxArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(startLocationUpTrigger[index], function StartLocationUpFunction)
            call SaveInteger(h, GetHandleId(startLocationUpTrigger[index]), 0, index)

            set startLocationComboBoxArrowDown[index] = BlzCreateFrameByType("BUTTON", "StartLocationDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(startLocationComboBoxArrowDown[index], FRAMEPOINT_TOPLEFT, COLUMN_START_LOCATION_X, y - 0.07)
            call BlzFrameSetAbsPoint(startLocationComboBoxArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LOCATION_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(startLocationComboBoxArrowDown[index], true)

            set startLocationComboBoxArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "StartLocationDownFrame" + I2S(index), startLocationComboBoxArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(startLocationComboBoxArrowDownFrame[index], startLocationComboBoxArrowDown[index])
            call BlzFrameSetTexture(startLocationComboBoxArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(startLocationComboBoxArrowDownFrame[index], true)

            if (startLocationDownTrigger[index] != null) then
                call DestroyTrigger(startLocationDownTrigger[index])
                set startLocationDownTrigger[index] = null
            endif

            set startLocationDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(startLocationDownTrigger[index], startLocationComboBoxArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(startLocationDownTrigger[index], function StartLocationDownFunction)
            call SaveInteger(h, GetHandleId(startLocationDownTrigger[index]), 0, index)

            set raceLabelEdit[index] = BlzCreateFrame("RacesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(raceLabelEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_RACE_X, y)
            call BlzFrameSetAbsPoint(raceLabelEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_RACE_X + COLUMN_RACE_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetValue(raceLabelEdit[index], RACES_MENU_ITEM_MATCHING_START_LOCATION)
            set Races[index] = RACES_MENU_ITEM_MATCHING_START_LOCATION
            call BlzFrameSetEnable(raceLabelEdit[index], true)

            set raceLabelEditArrowUp[index] = BlzCreateFrameByType("BUTTON", "RaceUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(raceLabelEditArrowUp[index], FRAMEPOINT_TOPLEFT, COLUMN_RACE_X, y - 0.04)
            call BlzFrameSetAbsPoint(raceLabelEditArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_RACE_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(raceLabelEditArrowUp[index], true)

            set raceLabelEditArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "RaceUpFrame" + I2S(index), raceLabelEditArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(raceLabelEditArrowUpFrame[index], raceLabelEditArrowUp[index])
            call BlzFrameSetTexture(raceLabelEditArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(raceLabelEditArrowUpFrame[index], true)

            if (raceUpTrigger[index] != null) then
                call DestroyTrigger(raceUpTrigger[index])
                set raceUpTrigger[index] = null
            endif

            set raceUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(raceUpTrigger[index], raceLabelEditArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(raceUpTrigger[index], function RaceUpFunction)
            call SaveInteger(h, GetHandleId(raceUpTrigger[index]), 0, index)

            set raceLabelEditArrowDown[index] = BlzCreateFrameByType("BUTTON", "RaceDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(raceLabelEditArrowDown[index], FRAMEPOINT_TOPLEFT, COLUMN_RACE_X, y - 0.07)
            call BlzFrameSetAbsPoint(raceLabelEditArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_RACE_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(raceLabelEditArrowDown[index], true)

            set raceLabelEditArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "RaceDownFrame" + I2S(index), raceLabelEditArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(raceLabelEditArrowDownFrame[index], raceLabelEditArrowDown[index])
            call BlzFrameSetTexture(raceLabelEditArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(raceLabelEditArrowDownFrame[index], true)

            if (raceDownTrigger[index] != null) then
                call DestroyTrigger(raceDownTrigger[index])
                set raceDownTrigger[index] = null
            endif

            set raceDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(raceDownTrigger[index], raceLabelEditArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(raceDownTrigger[index], function RaceDownFunction)
            call SaveInteger(h, GetHandleId(raceDownTrigger[index]), 0, index)

            set professionComboBox[index] = BlzCreateFrame("ProfessionsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(professionComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_PROFESSION_X, y)
            call BlzFrameSetAbsPoint(professionComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_PROFESSION_X + COLUMN_PROFESSION_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetValue(professionComboBox[index], 0)
            set Professions[index] = 0
            call BlzFrameSetEnable(professionComboBox[index], true)

            // line 3
            set y = y - LINE_HEIGHT - LINE_HEIGHT_SPACING - LINE_HEADERS_HEIGHT

            set goldEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(goldEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_START_GOLD_X, y)
            call BlzFrameSetAbsPoint(goldEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_GOLD_X + COLUMN_START_GOLD_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(goldEdit[index], I2S(START_GOLD))
            set StartGold[index] = START_GOLD
            call BlzFrameSetEnable(goldEdit[index], true)

            set lumberEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(lumberEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_START_LUMBER_X, y)
            call BlzFrameSetAbsPoint(lumberEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_LUMBER_X + COLUMN_START_LUMBER_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(lumberEdit[index], I2S(START_LUMBER))
            set StartLumber[index] = START_LUMBER
            call BlzFrameSetEnable(lumberEdit[index], true)

            set foodEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(foodEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_FOOD_LIMIT_X, y)
            call BlzFrameSetAbsPoint(foodEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_FOOD_LIMIT_X + COLUMN_FOOD_LIMIT_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(foodEdit[index], "100")
            set FoodLimit[index] = 100
            call BlzFrameSetEnable(foodEdit[index], true)

            set evolutionEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(evolutionEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_START_EVOLUTION_X, y)
            call BlzFrameSetAbsPoint(evolutionEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_START_EVOLUTION_X + COLUMN_START_EVOLUTION_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(evolutionEdit[index], "1")
            set StartEvolution[index] = 1
            call BlzFrameSetEnable(evolutionEdit[index], true)

            set attacksCheckBox[index] = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(attacksCheckBox[index], FRAMEPOINT_TOPLEFT, COLUMN_ATTACK_PLAYERS_X, y)
            call BlzFrameSetAbsPoint(attacksCheckBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_ATTACK_PLAYERS_X + COLUMN_ATTACK_PLAYERS_WIDTH, y - LINE_HEIGHT)
            set AttackPlayers[index] = 0
            call BlzFrameSetEnable(attacksCheckBox[index], true)
            if (GetAIDifficulty(aiPlayer) == AI_DIFFICULTY_INSANE) then
                call BlzFrameSetValue(attacksCheckBox[index], 1.0)
            endif

            set heroesEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(heroesEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_HEROES_X, y)
            call BlzFrameSetAbsPoint(heroesEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_HEROES_X + COLUMN_HEROES_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(heroesEdit[index], "1")
            set HeroesCount[index] = 1
            call BlzFrameSetEnable(heroesEdit[index], true)

            set expansionsEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(expansionsEdit[index], FRAMEPOINT_TOPLEFT, COLUMN_EXPANSIONS_X, y)
            call BlzFrameSetAbsPoint(expansionsEdit[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_EXPANSIONS_X + COLUMN_EXPANSIONS_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetText(expansionsEdit[index], "0")
            set Expansions[index] = 0
            call BlzFrameSetEnable(expansionsEdit[index], true)

            set sharedControlCheckBox[index] = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(sharedControlCheckBox[index], FRAMEPOINT_TOPLEFT, COLUMN_SHARED_CONTROL_X, y)
            call BlzFrameSetAbsPoint(sharedControlCheckBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_SHARED_CONTROL_X + COLUMN_SHARED_CONTROL_WIDTH, y - LINE_HEIGHT)
            set SharedControl[index] = 0
            call BlzFrameSetEnable(sharedControlCheckBox[index], true)

            set difficultyComboBox[index] = BlzCreateFrame("DifficultyPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(difficultyComboBox[index], FRAMEPOINT_TOPLEFT, COLUMN_DIFFICULTY_X , y)
            call BlzFrameSetAbsPoint(difficultyComboBox[index], FRAMEPOINT_BOTTOMRIGHT, COLUMN_DIFFICULTY_X  + COLUMN_DIFFICULTY_WIDTH, y - LINE_HEIGHT)
            call BlzFrameSetValue(difficultyComboBox[index], 1) // normal
            set Difficulty[index] = 1 // normal
            call BlzFrameSetEnable(difficultyComboBox[index], true)

            set counter = counter + 1
        endif
        set aiPlayer = null
        set i = i + 1
    endloop

    set Counter = counter

    // apply button

    set applyButton = BlzCreateFrame("ScriptDialogButton", backgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(applyButton, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_CLOSE_BUTTON_X, UI_FULLSCREEN_BOTTOM_BUTTON_Y)
    call BlzFrameSetAbsPoint(applyButton, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_CLOSE_BUTTON_X + UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH, UI_FULLSCREEN_BOTTOM_BUTTON_Y - UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT)
    call BlzFrameSetText(applyButton, GetLocalizedStringSafe("APPLY_YELLOW"))

    if (applyTrigger != null) then
        call DestroyTrigger(applyTrigger)
        set applyTrigger = null
    endif

    set applyTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(applyTrigger, applyButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(applyTrigger, function ApplyFunction)

    // previous page button

    set previousPageButton = CreateFullScreenPreviousPageButton(backgroundFrame, GetLocalizedStringSafe("PREVIOUS_PLAYER_YELLOW"))
    call BlzFrameSetEnable(previousPageButton, counter > 1)

    if (previousPageTrigger != null) then
        call DestroyTrigger(previousPageTrigger)
        set previousPageTrigger = null
    endif

    set previousPageTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(previousPageTrigger, previousPageButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(previousPageTrigger, function PreviousPageFunction)

    // next page button

    set nextPageButton = CreateFullScreenNextPageButton(backgroundFrame, GetLocalizedStringSafe("NEXT_PLAYER_YELLOW"))
    call BlzFrameSetEnable(nextPageButton, counter > 1)

    if (nextPageTrigger != null) then
        call DestroyTrigger(nextPageTrigger)
        set nextPageTrigger = null
    endif

    set nextPageTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(nextPageTrigger, nextPageButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(nextPageTrigger, function NextPageFunction)

    // hide
    call HideAiPlayersUi()
endfunction

private function CreateAiPlayersUI takes nothing returns nothing
    local force aiPlayers = GetAiPlayersWithConfig()
    call CreateAiPlayersUiEx(aiPlayers)
    call ForceClear(aiPlayers)
    call DestroyForce(aiPlayers)
    set aiPlayers = null
endfunction

private function Init takes nothing returns nothing
    // sync trigger
    call TriggerRegisterAnyPlayerSyncEvent(syncTrigger, PREFIX, false)
    call TriggerAddAction(syncTrigger, function TriggerActionSyncData)

    call OnStartGame(function CreateAiPlayersUI)

    call FrameLoaderAdd(function CreateAiPlayersUI)

    //call FrameSaverAdd(function HideAiPlayersUi)
endfunction

endlibrary
