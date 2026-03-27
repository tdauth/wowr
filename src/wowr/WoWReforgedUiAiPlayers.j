library WoWReforgedUiAiPlayers initializer Init requires OnStartGame, FrameLoader, FrameSaver, PlayerColorUtils, HostUtils, WoWReforgedUi, WoWReforgedUtils, WoWReforgedMapData, WoWReforgedHeroes, WoWReforgedRaces, WoWReforgedComputer 
/**
 * AI Players GUI which helps to configure AI players for one game in the beginning of the game.
 * Only the host sees this GUI and can specify heroes, races etc.
 */

globals
    private constant string PREFIX = "WoWReforgedUiAiPlayers"

    constant integer AI_PLAYERS_UI_MAX_PLAYERS = 1 // less players make combo boxes visible

    constant real AI_PLAYERS_UI_LINE_HEADERS_Y = UI_FULLSCREEN_Y - 0.05
    constant real AI_PLAYERS_UI_LINE_HEADERS_HEIGHT = 0.006

    constant real AI_PLAYERS_UI_LINE_HEIGHT = 0.03
    
    constant real AI_PLAYERS_UI_LINE_HEIGHT_SPACING = 0.12
    
    constant real AI_PLAYERS_UI_START_X = UI_FULLSCREEN_X + 0.03

    constant real AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X = AI_PLAYERS_UI_START_X
    constant real AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH = 0.10

    constant real AI_PLAYERS_UI_COLUMN_SPACING_X = 0.003

    constant real AI_PLAYERS_UI_LINE_SPACING_Y = 0.005
    
    constant real AI_PLAYERS_UI_COLUMN_COLOR_X = AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_COLOR_WIDTH = 0.08
    
    constant real AI_PLAYERS_UI_COLUMN_COLOR_EDIT_X = AI_PLAYERS_UI_COLUMN_COLOR_X + 0.03
    constant real AI_PLAYERS_UI_COLUMN_COLOR_EDIT_WIDTH = 0.03
    constant real AI_PLAYERS_UI_COLUMN_COLOR_EDIT_HEIGHT = 0.03

    constant real AI_PLAYERS_UI_COLUMN_TEAM_X = AI_PLAYERS_UI_COLUMN_COLOR_X + AI_PLAYERS_UI_COLUMN_COLOR_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_TEAM_WIDTH = 0.07

    constant real AI_PLAYERS_UI_COLUMN_HERO_X = AI_PLAYERS_UI_COLUMN_TEAM_X + AI_PLAYERS_UI_COLUMN_TEAM_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_HERO_WIDTH = 0.15

    constant real AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X = AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH = 0.04

    constant real AI_PLAYERS_UI_COLUMN_START_LOCATION_X = AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH = 0.13

    constant real AI_PLAYERS_UI_COLUMN_RACE_X = AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_RACE_WIDTH = 0.15

    // new line
    constant real AI_PLAYERS_UI_COLUMN_PROFESSION_X = AI_PLAYERS_UI_START_X
    constant real AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH = 0.13
    
    constant real AI_PLAYERS_UI_COLUMN_START_GOLD_X = AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_START_LUMBER_X = AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X = AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X = AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_POWER_GENERATOR_X = AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_POWER_GENERATOR_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_CREEP_HUNTER_X = AI_PLAYERS_UI_COLUMN_START_IMPROVED_POWER_GENERATOR_X + AI_PLAYERS_UI_COLUMN_START_IMPROVED_POWER_GENERATOR_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_CREEP_HUNTER_WIDTH = 0.06

    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_NAVY_X = AI_PLAYERS_UI_COLUMN_START_IMPROVED_CREEP_HUNTER_X + AI_PLAYERS_UI_COLUMN_START_IMPROVED_CREEP_HUNTER_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_IMPROVED_NAVY_WIDTH = 0.06
    
    constant real AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X = AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_WIDTH = 0.03
    
    constant real AI_PLAYERS_UI_COLUMN_HEROES_X = AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X + AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_HEROES_WIDTH = 0.06
    
    constant real AI_PLAYERS_UI_COLUMN_EXPANSIONS_X = AI_PLAYERS_UI_COLUMN_HEROES_X + AI_PLAYERS_UI_COLUMN_HEROES_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_EXPANSIONS_WIDTH = 0.06
    
    constant real AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X = AI_PLAYERS_UI_COLUMN_EXPANSIONS_X + AI_PLAYERS_UI_COLUMN_EXPANSIONS_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_WIDTH = 0.03
    
    constant real AI_PLAYERS_UI_COLUMN_DIFFICULTY_X = AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X + AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_DIFFICULTY_WIDTH = 0.08

    constant real AI_PLAYERS_UI_BUTTONS_Y = 0.24

    // default values
    constant integer AI_PLAYERS_UI_START_GOLD = 500
    constant integer AI_PLAYERS_UI_START_LUMBER = 400

    // HeroesPopupMenu
    constant integer AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM_MATCHING_RACE = 0
    constant integer AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM = 1
    constant integer AI_PLAYERS_UI_HEROES_MENU_ITEM_FINAL = 204

    // StartLocationsPopupMenu
    constant integer AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_MATCHING_TEAM = 0
    constant integer AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM = 1
    constant integer AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_ALLIANCE = 2
    constant integer AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_HORDE = 3
    constant integer AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_TERDRASSIL = 4

    // RacesPopupMenu
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_MATCHING_START_LOCATION = 0
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_WARLORD = 1
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM = 2
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_FREELANCER = 3
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_ALLIANCE = 4
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_HORDE = 5
    constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_HUMAN = 6

    // ProfessionsPopupMenu
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_RANDOM = 0
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_HERBALIST = 1
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ALCHEMIST = 2
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WEAPON_SMITH = 3
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ARMORER = 4
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ENGINEER = 5
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_DEMOLITION_EXPERT = 6
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_DRAGON_BREEDER = 7
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_LORE_MASTER = 8
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_RUNE_FORGER = 9
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_SORCERER = 10
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_JEWELCRAFTER = 11
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ARCHAEOLOGIST = 12
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WITCH_DOCTOR = 13
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_TAMER = 14
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_NECROMANCER = 15
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_GOLEM_SCULPTOR = 16
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WARLOCK = 17
    constant integer AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ASTROMANCER = 18
    
    private integer Counter = 0
    private integer MaxPages = 0
    private force Force = CreateForce()
    private integer Page = 0 // async

    private framehandle BackgroundFrame
    private framehandle TitleFrame

    // header line
    private framehandle LabelFrameColumnPlayerName
    private framehandle LabelFrameColumnColor
    private framehandle LabelFrameColumnTeam
    private framehandle LabelFrameColumnHero
    private framehandle LabelFrameColumnHeroStartLevel
    private framehandle LabelFrameColumnStartLocation
    private framehandle LabelFrameColumnRace // including freelancer
    private framehandle LabelFrameColumnProfession
    private framehandle LabelFrameColumnStartGold
    private framehandle LabelFrameColumnStartLumber
    private framehandle LabelFrameColumnFoodLimit
    private framehandle LabelFrameColumnStartEvolution
    private framehandle LabelFrameColumnStartImprovedPowerGenerator
    private framehandle LabelFrameColumnStartImprovedCreepHunter
    private framehandle LabelFrameColumnStartImprovedNavy
    private framehandle LabelFrameColumnAttackPlayers
    private framehandle LabelFrameColumnHeroes
    private framehandle LabelFrameColumnExpansions
    private framehandle LabelFrameColumnSharedControl
    private framehandle LabelFrameColumnDifficulty

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

    private trigger SyncTrigger

    // player lines
    private framehandle array LabelFrameColumnPlayerNameEdit
    private framehandle array LabelFrameColumnColorPopup
    private framehandle array LabelFrameColumnColorEdit
    private framehandle array LabelFrameColumnColorArrowUp
    private framehandle array LabelFrameColumnColorArrowUpFrame
    private framehandle array LabelFrameColumnColorArrowDown
    private framehandle array LabelFrameColumnColorArrowDownFrame
    private trigger array ColorPopupMenuTrigger
    private trigger array ColorUpTrigger
    private trigger array ColorDownTrigger
    private framehandle array LabelFrameColumnTeamEdit
    private framehandle array LabelFrameColumnHeroEdit
    private framehandle array LabelFrameColumnHeroEditArrowUp
    private framehandle array LabelFrameColumnHeroEditArrowUpFrame
    private framehandle array LabelFrameColumnHeroEditArrowDown
    private framehandle array LabelFrameColumnHeroEditArrowDownFrame
    private trigger array HeroUpTrigger
    private trigger array HeroDownTrigger
    private framehandle array LabelFrameColumnHeroStartLevelEdit
    private framehandle array LabelFrameColumnStartLocationEdit
    private framehandle array LabelFrameColumnStartLocationEditArrowUp
    private framehandle array LabelFrameColumnStartLocationEditArrowUpFrame
    private framehandle array LabelFrameColumnStartLocationEditArrowDown
    private framehandle array LabelFrameColumnStartLocationEditArrowDownFrame
    private trigger array StartLocationUpTrigger
    private trigger array StartLocationDownTrigger
    private framehandle array LabelFrameColumnRaceEdit
    private framehandle array LabelFrameColumnRaceEditArrowUp
    private framehandle array LabelFrameColumnRaceEditArrowUpFrame
    private framehandle array LabelFrameColumnRaceEditArrowDown
    private framehandle array LabelFrameColumnRaceEditArrowDownFrame
    private trigger array RaceUpTrigger
    private trigger array RaceDownTrigger
    private framehandle array LabelFrameColumnProfessionEdit
    private framehandle array LabelFrameColumnStartGoldEdit
    private framehandle array LabelFrameColumnStartLumberEdit
    private framehandle array LabelFrameColumnFoodLimitEdit
    private framehandle array LabelFrameColumnStartEvolutionEdit
    private framehandle array LabelFrameColumnStartImprovedPowerGeneratorEdit
    private framehandle array LabelFrameColumnStartImprovedCreepHunterEdit
    private framehandle array LabelFrameColumnStartImprovedNavyEdit
    private framehandle array LabelFrameColumnAttackPlayerCheckbox
    private framehandle array LabelFrameColumnHeroesEdit
    private framehandle array LabelFrameColumnExpansionsEdit
    private framehandle array LabelFrameColumnSharedControlCheckbox
    private framehandle array LabelFrameColumnDifficultyEdit
    // bottom buttons

    private framehandle PreviousPageButton
    private trigger PreviousPageTrigger = null

    private framehandle NextPageButton
    private trigger NextPageTrigger = null

    private framehandle ApplyButton
    private trigger ApplyTrigger = null
endglobals

function DisplayAISettingsInfo takes nothing returns nothing
      call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("AI_HOST_CHOOSES")).s(GetPlayerNameColored(GetHost())).result())
endfunction

private function UpdateComputerPlayersTitle takes nothing returns nothing
    call BlzFrameSetText(TitleFrame, Format(GetLocalizedString("AI_UI_TITLE")).i(Page + 1).i(MaxPages).result()) // Computer Players (%1%/%2%)
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
    local integer counterStart = currentPage * AI_PLAYERS_UI_MAX_PLAYERS
    local integer counterEnd = counterStart + AI_PLAYERS_UI_MAX_PLAYERS - 1
    local integer counter = 0
    local integer i = 0

    call BlzFrameSetVisible(BackgroundFrame, visible)
    call BlzFrameSetVisible(TitleFrame, visible)
    call BlzFrameSetVisible(LabelFrameColumnPlayerName, visible)
    call BlzFrameSetVisible(LabelFrameColumnColor, visible)
    call BlzFrameSetVisible(LabelFrameColumnTeam, visible)
    call BlzFrameSetVisible(LabelFrameColumnHero, visible)
    call BlzFrameSetVisible(LabelFrameColumnHeroStartLevel, visible)
    call BlzFrameSetVisible(LabelFrameColumnStartLocation, visible)
    call BlzFrameSetVisible(LabelFrameColumnRace, visible)
    call BlzFrameSetVisible(LabelFrameColumnProfession, visible)
    call BlzFrameSetVisible(LabelFrameColumnStartGold, visible)
    call BlzFrameSetVisible(LabelFrameColumnStartLumber, visible)
    call BlzFrameSetVisible(LabelFrameColumnFoodLimit, visible)
    call BlzFrameSetVisible(LabelFrameColumnStartEvolution, visible)
    call BlzFrameSetVisible(LabelFrameColumnAttackPlayers, visible)
    call BlzFrameSetVisible(LabelFrameColumnHeroes, visible)
    call BlzFrameSetVisible(LabelFrameColumnExpansions, visible)
    call BlzFrameSetVisible(LabelFrameColumnSharedControl, visible)
    call BlzFrameSetVisible(LabelFrameColumnDifficulty, visible)
    call BlzFrameSetVisible(ApplyButton, visible)
    call BlzFrameSetVisible(PreviousPageButton, visible)
    call BlzFrameSetVisible(NextPageButton, visible)

    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), Force)) then
            if ((visible and counter >= counterStart and counter <= counterEnd) or not visible) then
                call BlzFrameSetVisible(LabelFrameColumnPlayerNameEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorPopup[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorArrowUp[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorArrowDown[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnColorArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnTeamEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroEditArrowUp[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroEditArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroEditArrowDown[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroEditArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroStartLevelEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLocationEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLocationEditArrowUp[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLocationEditArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLocationEditArrowDown[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLocationEditArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnRaceEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnRaceEditArrowUp[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnRaceEditArrowUpFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnRaceEditArrowDown[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnRaceEditArrowDownFrame[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnProfessionEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartGoldEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartLumberEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnFoodLimitEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnStartEvolutionEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnAttackPlayerCheckbox[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnHeroesEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnExpansionsEdit[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnSharedControlCheckbox[counter], visible)
                call BlzFrameSetVisible(LabelFrameColumnDifficultyEdit[counter], visible)
            endif

            set counter = counter + 1
        endif
        set i = i + 1
    endloop
endfunction

function SetAiPlayersUiVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
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
            call BlzSendSyncData(PREFIX, "PlayerName_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnPlayerNameEdit[index]))
            call BlzSendSyncData(PREFIX, "Color_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnColorPopup[index]))))
            call BlzSendSyncData(PREFIX, "Team_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnTeamEdit[index]))))
            call BlzSendSyncData(PREFIX, "StartHero_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnHeroEdit[index]))))
            call BlzSendSyncData(PREFIX, "HeroStartLevel_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnHeroStartLevelEdit[index]))
            call BlzSendSyncData(PREFIX, "StartLocation_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnStartLocationEdit[index]))))
            call BlzSendSyncData(PREFIX, "Races_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnRaceEdit[index]))))
            call BlzSendSyncData(PREFIX, "Profession_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnProfessionEdit[index]))))
            call BlzSendSyncData(PREFIX, "StartGold_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnStartGoldEdit[index]))
            call BlzSendSyncData(PREFIX, "StartLumber_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnStartLumberEdit[index]))
            call BlzSendSyncData(PREFIX, "FoodLimit_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnFoodLimitEdit[index]))
            call BlzSendSyncData(PREFIX, "StartEvolution_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnStartEvolutionEdit[index]))
            call BlzSendSyncData(PREFIX, "AttackPlayers_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnAttackPlayerCheckbox[index]))))
            call BlzSendSyncData(PREFIX, "HeroesCount_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnHeroesEdit[index]))
            call BlzSendSyncData(PREFIX, "Expansions_" + I2S(index) + "_" + BlzFrameGetText(LabelFrameColumnExpansionsEdit[index]))
            call BlzSendSyncData(PREFIX, "SharedControl_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnSharedControlCheckbox[index]))))
            call BlzSendSyncData(PREFIX, "Difficulty_" + I2S(index) + "_" + I2S(R2I(BlzFrameGetValue(LabelFrameColumnDifficultyEdit[index]))))
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
    set udg_TmpPlayer2 = GetTriggerPlayer()
    call ConditionalTriggerExecute(gg_trg_Computer_Start_Lobby_Settings)
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
        
        if (frameValue == AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM_MATCHING_RACE) then
            return ChooseRandomHeroFromRace(udg_PlayerRace[GetConvertedPlayerId(whichPlayer)])
        elseif (frameValue == AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM) then
            return GetRandomInt(0, udg_MaxHeroUnitTypes - 1)
        endif
    endif

    return frameValue - AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM - 1
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
    loop
        exitwhen (i >= udg_Max_TownHalls)
        if (not udg_ComputerStartLocationTaken[i]) then
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
    local integer array choices
    local integer choicesCounter = 0
    loop
        exitwhen (i >= udg_Max_TownHalls)
        if (not udg_ComputerStartLocationTaken[i] and (udg_TownHallRace[i] == udg_RaceNone or GetRaceTeam(udg_TownHallRace[i]) == team)) then
            set choices[choicesCounter] = i
            set choicesCounter = choicesCounter + 1
        endif
        set i = i + 1
    endloop
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
    local integer random = GetRandomInt(0, 1)
    local integer frameValue = 0
    if (index != -1) then
        set frameValue = Races[index]
        if (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM) then
            return random == 0
        elseif (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_FREELANCER) then
            return false
        endif

        return AiPlayersUIChooseComputerStartLocation(0) > -1
    endif

    return (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM and random == 0) or AiPlayersUIChooseComputerStartLocation(0) > -1
endfunction

function GetRandomRaceWithAISupport takes nothing returns integer
    return GetRandomInt(1, GetRacesMax() - 1) // no freelancer
endfunction

function GetRandomTeamRaceWithAISupport takes integer team returns integer
    local integer array r
    local integer c = 0
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i == max)
        if (GetRaceTeam(i) == team or GetRaceTeam(i) == TEAM_NONE) then
            set r[c] = i
            set c = c + 1
        endif
        set i = i + 1
    endloop
    return r[GetRandomInt(0, c - 1)]
endfunction

function GetRandomAllianceRaceWithAISupport takes nothing returns integer
    return GetRandomTeamRaceWithAISupport(TEAM_ALLIANCE)
endfunction

function GetRandomHordeRaceWithAISupport takes nothing returns integer
    return GetRandomTeamRaceWithAISupport(TEAM_HORDE)
endfunction

function AiPlayersUIGetPlayerRace takes player whichPlayer, integer startLocation returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0
    local integer random = 0
    local race whichRace = GetPlayerRace(whichPlayer)

    if (index != -1) then
        set frameValue = Races[index]
        //constant integer AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM = 1
        if (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_MATCHING_START_LOCATION) then
            return udg_TownHallRace[startLocation]
        elseif (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_WARLORD) then
            return GetRandomRaceWithAISupport()
        elseif (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_ALLIANCE) then
            return GetRandomAllianceRaceWithAISupport()
        elseif (frameValue == AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_HORDE) then
            return GetRandomHordeRaceWithAISupport()
        else
            return frameValue - AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_HORDE // Ignore Freelancer race
        endif
    endif

    return udg_RaceNone
endfunction

function AiPlayersUIGetPlayerProfession takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    local integer frameValue = 0
    local race whichRace = GetPlayerRace(whichPlayer)

    if (index != -1) then
        set frameValue = Professions[index]
        if (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_HERBALIST) then
            return udg_ProfessionHerbalist
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ALCHEMIST) then
            return udg_ProfessionAlchemist
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WEAPON_SMITH) then
            return udg_ProfessionWeaponSmith
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ARMORER) then
            return udg_ProfessionArmourer
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ENGINEER) then
            return udg_ProfessionEngineer
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_DEMOLITION_EXPERT) then
            return udg_ProfessionDemolitionExpert
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_DRAGON_BREEDER) then
            return udg_ProfessionDragonBreeder
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_LORE_MASTER) then
            return udg_ProfessionLoreMaster
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_RUNE_FORGER) then
            return udg_ProfessionRuneforger
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_SORCERER) then    
            return udg_ProfessionSorcerer
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_JEWELCRAFTER) then    
            return udg_ProfessionJewelcrafter
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ARCHAEOLOGIST) then    
            return udg_ProfessionArchaeologist
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WITCH_DOCTOR) then    
            return udg_ProfessionWitchDoctor
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_TAMER) then    
            return udg_ProfessionTamer
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_NECROMANCER) then    
            return udg_ProfessionNecromancer
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_GOLEM_SCULPTOR) then    
            return udg_ProfessionGolemSculptor
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_WARLOCK) then    
            return udg_ProfessionWarlock
        elseif (frameValue == AI_PLAYERS_UI_PROFESSIONS_MENU_ITEM_ASTROMANCER) then    
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
        if (frameValue == AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_MATCHING_TEAM) then
            return AiPlayersUIChooseComputerStartLocationTeam(Teams[index])
        elseif (frameValue == AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM) then
            return AiPlayersUIChooseComputerStartLocation(GetRandomInt(0, udg_Max_TownHalls - 1))
        elseif (frameValue == AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_ALLIANCE) then
            return AiPlayersUIChooseComputerStartLocationAlliance()
        elseif (frameValue == AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_HORDE) then
            return AiPlayersUIChooseComputerStartLocationHorde()
        else
            return AiPlayersUIChooseComputerStartLocation(frameValue - AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_TERDRASSIL)
        endif
    endif

    return AiPlayersUIChooseComputerStartLocation(0)
endfunction

function AiPlayersUIGetStartGold takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return StartGold[index]
    endif

    return AI_PLAYERS_UI_START_GOLD
endfunction

function AiPlayersUIGetStartLumber takes player whichPlayer returns integer
    local integer index = GetPlayerIndex(whichPlayer)
    if (index != -1) then
        return StartLumber[index]
    endif

    return AI_PLAYERS_UI_START_LUMBER
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
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetTexture(LabelFrameColumnColorEdit[index], GetPlayerColorTexture(ConvertPlayerColor(R2I(BlzFrameGetValue(LabelFrameColumnColorPopup[index])))), 0, true)
    endif
endfunction

private function ColorUpFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer c = 0
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        set c = R2I(BlzFrameGetValue(LabelFrameColumnColorPopup[index]))
        if (c == 0) then
            set c = 23
        else
            set c = c - 1
        endif
        call BlzFrameSetValue(LabelFrameColumnColorPopup[index], c)
        call BlzFrameSetTexture(LabelFrameColumnColorEdit[index], GetPlayerColorTexture(ConvertPlayerColor(c)), 0, true)
    endif
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function ColorDownFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer c = 0

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        set c = R2I(BlzFrameGetValue(LabelFrameColumnColorPopup[index]))
        if (c == 23) then
            set c = 0
        else
            set c = c + 1
        endif
        call BlzFrameSetValue(LabelFrameColumnColorPopup[index], c)
        call BlzFrameSetTexture(LabelFrameColumnColorEdit[index], GetPlayerColorTexture(ConvertPlayerColor(c)), 0, true)
    endif
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function HeroUpFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnHeroEdit[index]) == 0) then
            call BlzFrameSetValue(LabelFrameColumnHeroEdit[index], AI_PLAYERS_UI_HEROES_MENU_ITEM_FINAL)
        else
            call BlzFrameSetValue(LabelFrameColumnHeroEdit[index], BlzFrameGetValue(LabelFrameColumnHeroEdit[index]) - 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function HeroDownFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnHeroEdit[index]) == AI_PLAYERS_UI_HEROES_MENU_ITEM_FINAL) then
            call BlzFrameSetValue(LabelFrameColumnHeroEdit[index], 0)
        else
            call BlzFrameSetValue(LabelFrameColumnHeroEdit[index], BlzFrameGetValue(LabelFrameColumnHeroEdit[index]) + 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function GetStartLocationsLastIndex takes nothing returns integer
    return udg_TownHallCounter + AI_PLAYERS_UI_START_LOCATION_MENU_ITEM_RANDOM_HORDE
endfunction

private function StartLocationUpFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnStartLocationEdit[index]) == 0) then
            call BlzFrameSetValue(LabelFrameColumnStartLocationEdit[index], GetStartLocationsLastIndex())
        else
            call BlzFrameSetValue(LabelFrameColumnStartLocationEdit[index], BlzFrameGetValue(LabelFrameColumnStartLocationEdit[index]) - 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function StartLocationDownFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnStartLocationEdit[index]) == GetStartLocationsLastIndex()) then
            call BlzFrameSetValue(LabelFrameColumnStartLocationEdit[index], 0)
        else
            call BlzFrameSetValue(LabelFrameColumnStartLocationEdit[index], BlzFrameGetValue(LabelFrameColumnStartLocationEdit[index]) + 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function GetRacesLastIndex takes nothing returns integer
    return GetRacesMax() - 1 + AI_PLAYERS_UI_RACES_MENU_ITEM_RANDOM_HORDE
endfunction

private function RaceUpFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnRaceEdit[index]) == 0) then
            call BlzFrameSetValue(LabelFrameColumnRaceEdit[index], GetRacesLastIndex())
        else
            call BlzFrameSetValue(LabelFrameColumnRaceEdit[index], BlzFrameGetValue(LabelFrameColumnRaceEdit[index]) - 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function RaceDownFunction takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (BlzFrameGetValue(LabelFrameColumnRaceEdit[index]) == GetRacesLastIndex()) then
            call BlzFrameSetValue(LabelFrameColumnRaceEdit[index], 0)
        else
            call BlzFrameSetValue(LabelFrameColumnRaceEdit[index], BlzFrameGetValue(LabelFrameColumnRaceEdit[index]) + 1)
        endif
    endif
    
    call PlayClickSound(GetTriggerPlayer())
endfunction

private function PreviousPageFunction takes nothing returns nothing
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        if (Page == 0) then
            set Page = MaxPages - 1
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
        if (Page == MaxPages - 1) then
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

    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_Y - UI_FULLSCREEN_HEIGHT)

    set TitleFrame = BlzCreateFrameByType("TEXT", "AiPlayersGuiTitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_TITLE_Y)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_TITLE_Y - UI_FULLSCREEN_TITLE_HEIGHT)
    call UpdateComputerPlayersTitle()
    call BlzFrameSetTextAlignment(TitleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    // header line
    set LabelFrameColumnPlayerName = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLinePlayerName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnPlayerName, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnPlayerName, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnPlayerName, GetLocalizedString("NAME")) // Name
    call BlzFrameSetTextAlignment(LabelFrameColumnPlayerName, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    
    set LabelFrameColumnColor = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineColor", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnColor, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_COLOR_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnColor, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_COLOR_X + AI_PLAYERS_UI_COLUMN_COLOR_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnColor, GetLocalizedString("COLOR")) // Color
    call BlzFrameSetTextAlignment(LabelFrameColumnColor, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnTeam = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineTeam", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnTeam, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_TEAM_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnTeam, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_TEAM_X + AI_PLAYERS_UI_COLUMN_TEAM_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnTeam, GetLocalizedString("TEAM")) // Team
    call BlzFrameSetTextAlignment(LabelFrameColumnTeam, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnHero = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHero", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnHero, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnHero, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnHero, GetLocalizedString("HERO")) // Hero
    call BlzFrameSetTextAlignment(LabelFrameColumnHero, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnHeroStartLevel = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHeroStartLevel", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnHeroStartLevel, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnHeroStartLevel, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnHeroStartLevel, GetLocalizedString("LEVEL")) // Level
    call BlzFrameSetTextAlignment(LabelFrameColumnHeroStartLevel, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnStartLocation = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLocation", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartLocation, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartLocation, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnStartLocation, GetLocalizedString("LOCATION_WARLORD_ONLY")) // Location (Warlord only)
    call BlzFrameSetTextAlignment(LabelFrameColumnStartLocation, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnRace = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineRace", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnRace, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(LabelFrameColumnRace, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + AI_PLAYERS_UI_COLUMN_RACE_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnRace, GetLocalizedString("RACE")) // Race
    call BlzFrameSetTextAlignment(LabelFrameColumnRace, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    // new line
    set y = AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEIGHT - AI_PLAYERS_UI_LINE_HEIGHT_SPACING
    
    set LabelFrameColumnProfession = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineProfession", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnProfession, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PROFESSION_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnProfession, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnProfession, GetLocalizedString("PROFESSION")) // Profession
    call BlzFrameSetTextAlignment(LabelFrameColumnProfession, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnStartGold = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartGold", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartGold, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_GOLD_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartGold, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnStartGold, GetLocalizedString("GOLD")) // Gold
    call BlzFrameSetTextAlignment(LabelFrameColumnStartGold, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnStartLumber = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLumber", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartLumber, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartLumber, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnStartLumber, GetLocalizedString("LUMBER")) // Lumber
    call BlzFrameSetTextAlignment(LabelFrameColumnStartLumber, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnFoodLimit = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineFoodLimit", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnFoodLimit, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnFoodLimit, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnFoodLimit, GetLocalizedString("FOOD_MAXIMUM")) // Food Maximum
    call BlzFrameSetTextAlignment(LabelFrameColumnFoodLimit, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    
    set LabelFrameColumnStartEvolution = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartEvolution", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartEvolution, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnStartEvolution, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnStartEvolution, GetLocalizedString("EVOLUTION")) // Evolution
    call BlzFrameSetTextAlignment(LabelFrameColumnStartEvolution, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnAttackPlayers = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineAttackPlayers", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnAttackPlayers, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnAttackPlayers, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X + AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnAttackPlayers, GetLocalizedString("ATTACKS")) // Attacks
    call BlzFrameSetTextAlignment(LabelFrameColumnAttackPlayers, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnHeroes = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHeroes", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnHeroes, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HEROES_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnHeroes, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HEROES_X + AI_PLAYERS_UI_COLUMN_HEROES_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnHeroes, GetLocalizedString("HEROES")) // Heroes
    call BlzFrameSetTextAlignment(LabelFrameColumnHeroes, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    
    set LabelFrameColumnExpansions = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineExpansions", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnExpansions, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_EXPANSIONS_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnExpansions, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_EXPANSIONS_X + AI_PLAYERS_UI_COLUMN_EXPANSIONS_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnExpansions, GetLocalizedString("EXPANSIONS")) // Expansions
    call BlzFrameSetTextAlignment(LabelFrameColumnExpansions, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set LabelFrameColumnSharedControl = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineSharedControl", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnSharedControl, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnSharedControl, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X + AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnSharedControl, GetLocalizedString("SHARED")) // Shared
    call BlzFrameSetTextAlignment(LabelFrameColumnSharedControl, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    
    set LabelFrameColumnDifficulty = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineDifficulty", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameColumnDifficulty, FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_DIFFICULTY_X, y)
    call BlzFrameSetAbsPoint(LabelFrameColumnDifficulty, FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_DIFFICULTY_X + AI_PLAYERS_UI_COLUMN_DIFFICULTY_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(LabelFrameColumnDifficulty, GetLocalizedString("DIFFICULTY")) // Difficulty
    call BlzFrameSetTextAlignment(LabelFrameColumnDifficulty, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set y = AI_PLAYERS_UI_LINE_HEADERS_Y - 2 * (AI_PLAYERS_UI_LINE_HEADERS_HEIGHT + AI_PLAYERS_UI_LINE_SPACING_Y)
    
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

            set LabelFrameColumnPlayerNameEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnPlayerNameEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnPlayerNameEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnPlayerNameEdit[index], GetPlayerName(aiPlayer))
            set PlayerNames[index] = GetPlayerName(aiPlayer)
            call BlzFrameSetEnable(LabelFrameColumnPlayerNameEdit[index], true)
            
            set LabelFrameColumnColorPopup[index] = BlzCreateFrame("PlayerColorsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorPopup[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_COLOR_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorPopup[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_COLOR_X + AI_PLAYERS_UI_COLUMN_COLOR_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            set playerColor = IMinBJ(23, GetHandleId(GetPlayerColor(aiPlayer)))
            call BlzFrameSetValue(LabelFrameColumnColorPopup[index], playerColor)
            call BlzFrameSetEnable(LabelFrameColumnColorPopup[index], true)
            
            if (ColorPopupMenuTrigger[index] != null) then
                call DestroyTrigger(ColorPopupMenuTrigger[index])
                set ColorPopupMenuTrigger[index] = null
            endif
            
            set ColorPopupMenuTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(ColorPopupMenuTrigger[index], LabelFrameColumnColorPopup[index], FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
            call TriggerAddAction(ColorPopupMenuTrigger[index], function ColorPopupMenuFunction)
            call SaveTriggerParameterInteger(ColorPopupMenuTrigger[index], 0, index)
            
            set LabelFrameColumnColorEdit[index] = BlzCreateFrameByType("BACKDROP", "ColorFrame" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_COLOR_EDIT_X, y - 0.04)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_COLOR_EDIT_X + AI_PLAYERS_UI_COLUMN_COLOR_EDIT_WIDTH, y - 0.04 - AI_PLAYERS_UI_COLUMN_COLOR_EDIT_HEIGHT)
            call BlzFrameSetTexture(LabelFrameColumnColorEdit[index], GetPlayerColorTexture(GetPlayerColor(aiPlayer)), 0, true)
            call BlzFrameSetEnable(LabelFrameColumnColorEdit[index], true)
            
            //call BJDebugMsg("Texture: " + GetPlayerColorTexture(GetPlayerColor(aiPlayer)))
            
            set LabelFrameColumnColorArrowUp[index] = BlzCreateFrameByType("BUTTON", "ColorUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorArrowUp[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_COLOR_X, y - 0.04)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_COLOR_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(LabelFrameColumnColorArrowUp[index], true)
            
            set LabelFrameColumnColorArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "ColorUpFrame" + I2S(index), LabelFrameColumnColorArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnColorArrowUpFrame[index], LabelFrameColumnColorArrowUp[index])
            call BlzFrameSetTexture(LabelFrameColumnColorArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnColorArrowUpFrame[index], true)
            
            if (ColorUpTrigger[index] != null) then
                call DestroyTrigger(ColorUpTrigger[index])
                set ColorUpTrigger[index] = null
            endif
            
            set ColorUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(ColorUpTrigger[index], LabelFrameColumnColorArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(ColorUpTrigger[index], function ColorUpFunction)
            call SaveTriggerParameterInteger(ColorUpTrigger[index], 0, index)
            
            set LabelFrameColumnColorArrowDown[index] = BlzCreateFrameByType("BUTTON", "ColorDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorArrowDown[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_COLOR_X, y - 0.07)
            call BlzFrameSetAbsPoint(LabelFrameColumnColorArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_COLOR_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(LabelFrameColumnColorArrowDown[index], true)
            
            set LabelFrameColumnColorArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "ColoreDownFrame" + I2S(index), LabelFrameColumnColorArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnColorArrowDownFrame[index], LabelFrameColumnColorArrowDown[index])
            call BlzFrameSetTexture(LabelFrameColumnColorArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnColorArrowDownFrame[index], true)
            
            if (ColorDownTrigger[index] != null) then
                call DestroyTrigger(ColorDownTrigger[index])
                set ColorDownTrigger[index] = null
            endif
            
            set ColorDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(ColorDownTrigger[index], LabelFrameColumnColorArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(ColorDownTrigger[index], function ColorDownFunction)
            call SaveTriggerParameterInteger(ColorDownTrigger[index], 0, index)

            set LabelFrameColumnTeamEdit[index] = BlzCreateFrame("TeamPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnTeamEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_TEAM_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnTeamEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_TEAM_X + AI_PLAYERS_UI_COLUMN_TEAM_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            set team = IMinBJ(TEAM_MAX_AI - 1, GetPlayerTeam(aiPlayer))
            call BlzFrameSetValue(LabelFrameColumnTeamEdit[index], team)
            set Teams[index] = team
            call BlzFrameSetEnable(LabelFrameColumnTeamEdit[index], true)

            set LabelFrameColumnHeroEdit[index] = BlzCreateFrame("HeroesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetValue(LabelFrameColumnHeroEdit[index], AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM_MATCHING_RACE)
            set Heroes[index] = AI_PLAYERS_UI_HEROES_MENU_ITEM_RANDOM_MATCHING_RACE
            call BlzFrameSetEnable(LabelFrameColumnHeroEdit[index], true)
            
            set LabelFrameColumnHeroEditArrowUp[index] = BlzCreateFrameByType("BUTTON", "HeroUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEditArrowUp[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, y - 0.04)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEditArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(LabelFrameColumnHeroEditArrowUp[index], true)
            
            set LabelFrameColumnHeroEditArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "HeroUpFrame" + I2S(index), LabelFrameColumnHeroEditArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnHeroEditArrowUpFrame[index], LabelFrameColumnHeroEditArrowUp[index])
            call BlzFrameSetTexture(LabelFrameColumnHeroEditArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnHeroEditArrowUpFrame[index], true)
            
            if (HeroUpTrigger[index] != null) then
                call DestroyTrigger(HeroUpTrigger[index])
                set HeroUpTrigger[index] = null
            endif
            
            set HeroUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(HeroUpTrigger[index], LabelFrameColumnHeroEditArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(HeroUpTrigger[index], function HeroUpFunction)
            call SaveTriggerParameterInteger(HeroUpTrigger[index], 0, index)
            
            set LabelFrameColumnHeroEditArrowDown[index] = BlzCreateFrameByType("BUTTON", "HeroDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEditArrowDown[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, y - 0.07)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroEditArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(LabelFrameColumnHeroEditArrowDown[index], true)
            
            set LabelFrameColumnHeroEditArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "HeroeDownFrame" + I2S(index), LabelFrameColumnHeroEditArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnHeroEditArrowDownFrame[index], LabelFrameColumnHeroEditArrowDown[index])
            call BlzFrameSetTexture(LabelFrameColumnHeroEditArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnHeroEditArrowDownFrame[index], true)
            
            if (HeroDownTrigger[index] != null) then
                call DestroyTrigger(HeroDownTrigger[index])
                set HeroDownTrigger[index] = null
            endif
            
            set HeroDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(HeroDownTrigger[index], LabelFrameColumnHeroEditArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(HeroDownTrigger[index], function HeroDownFunction)
            call SaveTriggerParameterInteger(HeroDownTrigger[index], 0, index)

            set LabelFrameColumnHeroStartLevelEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroStartLevelEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroStartLevelEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnHeroStartLevelEdit[index], "1")
            set HeroStartLevels[index] = 1
            call BlzFrameSetEnable(LabelFrameColumnHeroStartLevelEdit[index], true)

            set LabelFrameColumnStartLocationEdit[index] = BlzCreateFrame("StartLocationsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetValue(LabelFrameColumnStartLocationEdit[index], 0)
            set StartLocations[index] = 0
            call BlzFrameSetEnable(LabelFrameColumnStartLocationEdit[index], true)
            
            set LabelFrameColumnStartLocationEditArrowUp[index] = BlzCreateFrameByType("BUTTON", "StartLocationUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEditArrowUp[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, y - 0.04)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEditArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(LabelFrameColumnStartLocationEditArrowUp[index], true)
            
            set LabelFrameColumnStartLocationEditArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "StartLocationUpFrame" + I2S(index), LabelFrameColumnStartLocationEditArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnStartLocationEditArrowUpFrame[index], LabelFrameColumnStartLocationEditArrowUp[index])
            call BlzFrameSetTexture(LabelFrameColumnStartLocationEditArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnStartLocationEditArrowUpFrame[index], true)
            
            if (StartLocationUpTrigger[index] != null) then
                call DestroyTrigger(StartLocationUpTrigger[index])
                set StartLocationUpTrigger[index] = null
            endif
            
            set StartLocationUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(StartLocationUpTrigger[index], LabelFrameColumnStartLocationEditArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(StartLocationUpTrigger[index], function StartLocationUpFunction)
            call SaveTriggerParameterInteger(StartLocationUpTrigger[index], 0, index)
            
            set LabelFrameColumnStartLocationEditArrowDown[index] = BlzCreateFrameByType("BUTTON", "StartLocationDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEditArrowDown[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, y - 0.07)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLocationEditArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(LabelFrameColumnStartLocationEditArrowDown[index], true)
            
            set LabelFrameColumnStartLocationEditArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "StartLocationDownFrame" + I2S(index), LabelFrameColumnStartLocationEditArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnStartLocationEditArrowDownFrame[index], LabelFrameColumnStartLocationEditArrowDown[index])
            call BlzFrameSetTexture(LabelFrameColumnStartLocationEditArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnStartLocationEditArrowDownFrame[index], true)
            
            if (StartLocationDownTrigger[index] != null) then
                call DestroyTrigger(StartLocationDownTrigger[index])
                set StartLocationDownTrigger[index] = null
            endif
            
            set StartLocationDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(StartLocationDownTrigger[index], LabelFrameColumnStartLocationEditArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(StartLocationDownTrigger[index], function StartLocationDownFunction)
            call SaveTriggerParameterInteger(StartLocationDownTrigger[index], 0, index)
            
            set LabelFrameColumnRaceEdit[index] = BlzCreateFrame("RacesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + AI_PLAYERS_UI_COLUMN_RACE_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetValue(LabelFrameColumnRaceEdit[index], AI_PLAYERS_UI_RACES_MENU_ITEM_MATCHING_START_LOCATION)
            set Races[index] = AI_PLAYERS_UI_RACES_MENU_ITEM_MATCHING_START_LOCATION
            call BlzFrameSetEnable(LabelFrameColumnRaceEdit[index], true)
            
            set LabelFrameColumnRaceEditArrowUp[index] = BlzCreateFrameByType("BUTTON", "RaceUpButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEditArrowUp[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, y - 0.04)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEditArrowUp[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + 0.02, y - 0.02 - 0.04)
            call BlzFrameSetEnable(LabelFrameColumnRaceEditArrowUp[index], true)
            
            set LabelFrameColumnRaceEditArrowUpFrame[index] = BlzCreateFrameByType("BACKDROP", "RaceUpFrame" + I2S(index), LabelFrameColumnRaceEditArrowUp[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnRaceEditArrowUpFrame[index], LabelFrameColumnRaceEditArrowUp[index])
            call BlzFrameSetTexture(LabelFrameColumnRaceEditArrowUpFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnRaceEditArrowUpFrame[index], true)
            
            if (RaceUpTrigger[index] != null) then
                call DestroyTrigger(RaceUpTrigger[index])
                set RaceUpTrigger[index] = null
            endif
            
            set RaceUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(RaceUpTrigger[index], LabelFrameColumnRaceEditArrowUp[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(RaceUpTrigger[index], function RaceUpFunction)
            call SaveTriggerParameterInteger(RaceUpTrigger[index], 0, index)
            
            set LabelFrameColumnRaceEditArrowDown[index] = BlzCreateFrameByType("BUTTON", "RaceDownButton" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEditArrowDown[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, y - 0.07)
            call BlzFrameSetAbsPoint(LabelFrameColumnRaceEditArrowDown[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + 0.02, y - 0.02 - 0.07)
            call BlzFrameSetEnable(LabelFrameColumnRaceEditArrowDown[index], true)
            
            set LabelFrameColumnRaceEditArrowDownFrame[index] = BlzCreateFrameByType("BACKDROP", "RaceDownFrame" + I2S(index), LabelFrameColumnRaceEditArrowDown[index], "", 0)
            call BlzFrameSetAllPoints(LabelFrameColumnRaceEditArrowDownFrame[index], LabelFrameColumnRaceEditArrowDown[index])
            call BlzFrameSetTexture(LabelFrameColumnRaceEditArrowDownFrame[index], "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)
            call BlzFrameSetEnable(LabelFrameColumnRaceEditArrowDownFrame[index], true)
            
            if (RaceDownTrigger[index] != null) then
                call DestroyTrigger(RaceDownTrigger[index])
                set RaceDownTrigger[index] = null
            endif
            
            set RaceDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(RaceDownTrigger[index], LabelFrameColumnRaceEditArrowDown[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(RaceDownTrigger[index], function RaceDownFunction)
            call SaveTriggerParameterInteger(RaceDownTrigger[index], 0, index)
            
            // new line
            set y = y - AI_PLAYERS_UI_LINE_HEIGHT - AI_PLAYERS_UI_LINE_HEIGHT_SPACING
            
            set LabelFrameColumnProfessionEdit[index] = BlzCreateFrame("ProfessionsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnProfessionEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PROFESSION_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnProfessionEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetValue(LabelFrameColumnProfessionEdit[index], 0)
            set Professions[index] = 0
            call BlzFrameSetEnable(LabelFrameColumnProfessionEdit[index], true)

            set LabelFrameColumnStartGoldEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartGoldEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_GOLD_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartGoldEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnStartGoldEdit[index], I2S(AI_PLAYERS_UI_START_GOLD))
            set StartGold[index] = AI_PLAYERS_UI_START_GOLD
            call BlzFrameSetEnable(LabelFrameColumnStartGoldEdit[index], true)

            set LabelFrameColumnStartLumberEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLumberEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartLumberEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnStartLumberEdit[index], I2S(AI_PLAYERS_UI_START_LUMBER))
            set StartLumber[index] = AI_PLAYERS_UI_START_LUMBER
            call BlzFrameSetEnable(LabelFrameColumnStartLumberEdit[index], true)

            set LabelFrameColumnFoodLimitEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnFoodLimitEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnFoodLimitEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnFoodLimitEdit[index], "100")
            set FoodLimit[index] = 100
            call BlzFrameSetEnable(LabelFrameColumnFoodLimitEdit[index], true)

            set LabelFrameColumnStartEvolutionEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartEvolutionEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnStartEvolutionEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnStartEvolutionEdit[index], "1")
            set StartEvolution[index] = 1
            call BlzFrameSetEnable(LabelFrameColumnStartEvolutionEdit[index], true)
            
            set LabelFrameColumnAttackPlayerCheckbox[index] = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnAttackPlayerCheckbox[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnAttackPlayerCheckbox[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_X + AI_PLAYERS_UI_COLUMN_ATTACK_PLAYERS_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            set AttackPlayers[index] = 0
            call BlzFrameSetEnable(LabelFrameColumnAttackPlayerCheckbox[index], true)
            if (GetAIDifficulty(aiPlayer) == AI_DIFFICULTY_INSANE) then
                call BlzFrameSetValue(LabelFrameColumnAttackPlayerCheckbox[index], 1.0)
            endif
            
            set LabelFrameColumnHeroesEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroesEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HEROES_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnHeroesEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HEROES_X + AI_PLAYERS_UI_COLUMN_HEROES_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnHeroesEdit[index], "1")
            set HeroesCount[index] = 1
            call BlzFrameSetEnable(LabelFrameColumnHeroesEdit[index], true)
            
            set LabelFrameColumnExpansionsEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnExpansionsEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_EXPANSIONS_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnExpansionsEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_EXPANSIONS_X + AI_PLAYERS_UI_COLUMN_EXPANSIONS_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetText(LabelFrameColumnExpansionsEdit[index], "0")
            set Expansions[index] = 0
            call BlzFrameSetEnable(LabelFrameColumnExpansionsEdit[index], true)
            
            set LabelFrameColumnSharedControlCheckbox[index] = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnSharedControlCheckbox[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X, y)
            call BlzFrameSetAbsPoint(LabelFrameColumnSharedControlCheckbox[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_X + AI_PLAYERS_UI_COLUMN_SHARED_CONTROL_WIDTH, y - AI_PLAYERS_UI_LINE_HEIGHT)
            set SharedControl[index] = 0
            call BlzFrameSetEnable(LabelFrameColumnSharedControlCheckbox[index], true)
            
            set LabelFrameColumnDifficultyEdit[index] = BlzCreateFrame("DifficultyPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(LabelFrameColumnDifficultyEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_DIFFICULTY_X , y)
            call BlzFrameSetAbsPoint(LabelFrameColumnDifficultyEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_DIFFICULTY_X  + AI_PLAYERS_UI_COLUMN_DIFFICULTY_WIDTH , y - AI_PLAYERS_UI_LINE_HEIGHT)
            call BlzFrameSetValue(LabelFrameColumnDifficultyEdit[index], 1) // normal
            set Difficulty[index] = 1 // normal
            call BlzFrameSetEnable(LabelFrameColumnDifficultyEdit[index], true)

            set y = y - AI_PLAYERS_UI_LINE_HEIGHT - AI_PLAYERS_UI_LINE_SPACING_Y
            set counter = counter + 1

            if (ModuloInteger(counter, AI_PLAYERS_UI_MAX_PLAYERS) == 0) then
                set y = AI_PLAYERS_UI_LINE_HEADERS_Y - 2 * (AI_PLAYERS_UI_LINE_HEADERS_HEIGHT + AI_PLAYERS_UI_LINE_SPACING_Y)
            endif
        endif
        set aiPlayer = null
        set i = i + 1
    endloop

    set Counter = counter
    set MaxPages = counter / AI_PLAYERS_UI_MAX_PLAYERS

    if (ModuloInteger(counter, AI_PLAYERS_UI_MAX_PLAYERS) > 0) then
        set MaxPages = MaxPages + 1
    endif

    // apply button

    set ApplyButton = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(ApplyButton, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_CLOSE_BUTTON_X, UI_FULLSCREEN_BOTTOM_BUTTON_Y)
    call BlzFrameSetAbsPoint(ApplyButton, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_CLOSE_BUTTON_X + UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH, UI_FULLSCREEN_BOTTOM_BUTTON_Y - UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT)
    call BlzFrameSetText(ApplyButton, GetLocalizedString("APPLY_YELLOW"))
    
    if (ApplyTrigger != null) then
        call DestroyTrigger(ApplyTrigger)
        set ApplyTrigger = null
    endif

    set ApplyTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ApplyTrigger, ApplyButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ApplyTrigger, function ApplyFunction)

    // previous page button

    set PreviousPageButton = CreateFullScreenPreviousPageButton(BackgroundFrame, GetLocalizedString("PREVIOUS_PLAYER_YELLOW"))
    call BlzFrameSetEnable(PreviousPageButton, counter > AI_PLAYERS_UI_MAX_PLAYERS)
    
    if (PreviousPageTrigger != null) then
        call DestroyTrigger(PreviousPageTrigger)
        set PreviousPageTrigger = null
    endif

    set PreviousPageTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PreviousPageTrigger, PreviousPageButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PreviousPageTrigger, function PreviousPageFunction)

    // next page button

    set NextPageButton = CreateFullScreenNextPageButton(BackgroundFrame, GetLocalizedString("NEXT_PLAYER_YELLOW"))
    call BlzFrameSetEnable(NextPageButton, counter > AI_PLAYERS_UI_MAX_PLAYERS)

    if (NextPageTrigger != null) then
        call DestroyTrigger(NextPageTrigger)
        set NextPageTrigger = null
    endif

    set NextPageTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(NextPageTrigger, NextPageButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(NextPageTrigger, function NextPageFunction)

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
    set SyncTrigger = CreateTrigger()
    call TriggerRegisterAnyPlayerSyncEvent(SyncTrigger, PREFIX, false)
    call TriggerAddAction(SyncTrigger, function TriggerActionSyncData)
    
    call OnStartGame(function CreateAiPlayersUI)
    
    call FrameLoaderAdd(function CreateAiPlayersUI)

    //call FrameSaverAdd(function HideAiPlayersUi)
endfunction

endlibrary
