library WoWReforgedComputer initializer Init requires PlayerColorUtils, ItemUtils, WoWReforgedRaces, WoWReforgedZones, WoWReforgedUtils, WoWReforgedMounts, WoWReforgedRaces, WoWReforgedProfessions, WoWReforgedBackpacks, WoWReforgedResearches, WoWReforgedDependencyEquivalents, WoWReforgedAltars, WoWReforgedComputerStartLocations, WoWReforgedAutoSkill, WoWReforgedMapData, WoWReforgedUiAiPlayers

globals
    private force computerPlayers = CreateForce()
    private force computerLobbyPlayers = CreateForce()
    private force userPlayers = CreateForce()
    private force array teamPlayers
    private group array computerTownHalls
    private group array computerShipyards
    private group array computerNavy
    private trigger playerLeavesTrigger = CreateTrigger()
    private trigger allianceChangeTrigger = CreateTrigger()
    private trigger heroLevelTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
    private timer autoRevivalTimer = CreateTimer()
    private timer autoCraftTimer = CreateTimer()
    private timer autoAttackNavyTimer = CreateTimer()
    private timer autoLoadMinesTimer = CreateTimer()

    // Allows execution in dependency WoWReforgedUiAiPlayers:
    public trigger startLobbySettingsTrigger = CreateTrigger()
    public player startLobbySettingsPlayer = null
endglobals

private function FilterIsAltar takes nothing returns boolean
    return IsUnitAltar(GetFilterUnit())
endfunction

private function FilterIsDeadHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) // TODO check if the hero is already being revived
endfunction

function ComputerAIAutoReviveHeroesEx takes player whichPlayer, group heroes returns nothing
    local group altars = CreateGroup()
    local unit hero = null
    local unit altar = null
    call GroupEnumUnitsOfPlayer(altars, whichPlayer, Filter(function FilterIsAltar))
    if (BlzGroupGetSize(altars) > 0) then
        loop
            set hero = FirstOfGroup(heroes)
            exitwhen (hero == null)
            set altar = FirstOfGroup(altars)
            exitwhen (altar == null)
            call IssueTargetOrder(altar, "revive", hero) 
            call GroupRemoveUnit(heroes, hero)
            call GroupRemoveUnit(altars, altar)
        endloop
    endif
    call GroupClear(altars)
    call DestroyGroup(altars)
    set altars = null
endfunction

function ComputerAIAutoReviveHeroes takes player whichPlayer returns nothing
    local group heroes = CreateGroup()
    call GroupEnumUnitsOfPlayer(heroes, whichPlayer, Filter(function FilterIsDeadHero))
    if (BlzGroupGetSize(heroes) > 0) then
        call ComputerAIAutoReviveHeroesEx(whichPlayer, heroes)
    endif
    call GroupClear(heroes)
    call DestroyGroup(heroes)
    set heroes = null
endfunction

private function EnumComputerAIAutoReviveHeroes takes nothing returns nothing
    call ComputerAIAutoReviveHeroes(GetEnumPlayer())
endfunction

function ComputerAIAutoReviveHeroesAll takes nothing returns nothing
    local force all = CreateForce()
    call ForceAddPlayingComputerPlayers(all)
    call ForceRemovePlayer(all, udg_BossesPlayer)
    call ForForce(all, function EnumComputerAIAutoReviveHeroes)
    call ForceClear(all)
    call DestroyForce(all)
endfunction

private function EnumHeroAutoCrafts takes nothing returns nothing
    call CraftProfessionItemsAI(GetEnumUnit())
endfunction

private function EnumAutoCraft takes nothing returns nothing
    local group heroes = null
    if (GetPlayerProfession1(GetEnumPlayer()) != udg_ProfessionNone or GetPlayerProfession2(GetEnumPlayer()) != udg_ProfessionNone or GetPlayerProfession3(GetEnumPlayer()) != udg_ProfessionNone) then
        set heroes = GetPlayerHeroes(GetEnumPlayer())
        call ForGroup(heroes, function EnumHeroAutoCrafts)
        call GroupClear(heroes)
        call DestroyGroup(heroes)
        set heroes = null
    endif
endfunction

private function ComputerAIAutoCraft takes nothing returns nothing
    call ForForce(computerLobbyPlayers, function EnumAutoCraft)
endfunction

function GetComputerAINavy takes player whichPlayer returns group
    return computerNavy[GetPlayerId(whichPlayer)]
endfunction

function ComputerAINavyAttacks takes player whichPlayer returns nothing
    local integer target = GetRandomInt(0, udg_NavyAttackLocationsCounter)
    local rect targetRect = udg_NavyAttackLocations[target]
    local real x = GetRectCenterX(targetRect)
    local real y = GetRectCenterY(targetRect)
    local string zone = GetZoneNameByCoordinates(x, y)
    call GroupPointOrder(GetComputerAINavy(whichPlayer), "attack", x, y)
    call BlzDisplayChatMessage(whichPlayer, 0, Format(GetLocalizedString("MY_NAVY_WILL_ATTACK_X")).s(zone).result())
    if (IsPlayerAlly(whichPlayer, GetLocalPlayer())) then
        call PingMinimapEx(x, y, 4.0, 0, 255, 0, false)
    endif
    set targetRect = null
endfunction

function ComputerAINavyIsReadyForAttack takes player whichPlayer returns boolean
    return BlzGroupGetSize(GetComputerAINavy(whichPlayer)) >= 5
endfunction

function ComputerAITrainNavy takes unit shipyard returns boolean
    local player owner = GetOwningPlayer(shipyard)
    local integer r = GetPlayerRace1(owner)
    local integer unitTypeId = GetRaceBattleship(r)
    if (GetRaceFrigate(r) != 0 and GetRandomInt(0, 1) == 1) then
        set unitTypeId = GetRaceFrigate(r)
    endif
    if (unitTypeId != 0) then
        return IssueImmediateOrderById(shipyard, unitTypeId)
    endif
    
    return false
endfunction

private function IsRaceMine takes integer r, integer unitTypeId returns boolean
    return r != udg_RaceNone and (unitTypeId == GetRaceMine(r) or unitTypeId == GetRaceHousing(r))
endfunction

private function IsRaceWorker takes integer r, integer unitTypeId returns boolean
    return r != udg_RaceNone and unitTypeId == GetRaceWorker(r)
endfunction

private function FilterIsUnitMineOrHousingOfRace takes nothing returns boolean
    local unit u = GetFilterUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    local player owner = GetOwningPlayer(u)
    local boolean result = IsRaceMine(GetPlayerRace1(owner), unitTypeId) or IsRaceMine(GetPlayerRace2(owner), unitTypeId) or IsRaceMine(GetPlayerRace3(owner), unitTypeId)
    //call BJDebugMsg("Checking mine " + GetUnitName(u) + " for player " + GetPlayerName(owner) + " with race " + GetRaceName(GetPlayerRace1(owner)) + " and race mine " + GetObjectName(GetRaceMine(GetPlayerRace1(owner))))
    set owner = null
    set u = null
    return result
endfunction

private function FilterIsUnitFreeWorker takes nothing returns boolean
    local unit u = GetFilterUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    local player owner = GetOwningPlayer(u)
    local boolean result = IsUnitAliveBJ(u) and not IsUnitLoaded(u) and GetUnitCurrentOrder(u) != OrderId("harvest") and (IsRaceWorker(GetPlayerRace1(owner), unitTypeId) or IsRaceWorker(GetPlayerRace2(owner), unitTypeId) or IsRaceWorker(GetPlayerRace3(owner), unitTypeId))
    set owner = null
    set u = null
    return result
endfunction

globals
    public constant integer MAX_WORKERS_PER_MINE = 5
    private integer autoLoadMineCounter = 0
    private group autoLoadMineWorkers = null
endglobals

private function AutoLoadMineAI takes unit mine returns nothing
    local integer mineRace = GetObjectRace(GetUnitTypeId(mine))
    local unit worker = null
    local integer i = 0
    local integer max = 0
    local group usedWorkers = CreateGroup()
    // TODO How to detect how many workers are already in the mine?
    set max = BlzGroupGetSize(autoLoadMineWorkers)
    set i = 0
    loop
        exitwhen (i == max or BlzGroupGetSize(usedWorkers) >= MAX_WORKERS_PER_MINE) // stop at 5 workers per mine
        set worker = BlzGroupUnitAt(autoLoadMineWorkers, i)
        if (GetObjectRace(GetUnitTypeId(worker)) == mineRace) then
            set autoLoadMineCounter = autoLoadMineCounter + 1
            call IssueTargetOrder(worker, "smart", mine)
            call GroupAddUnit(usedWorkers, worker)
        endif
        set worker = null
        set i = i + 1
    endloop
    //call BJDebugMsg("Used Workers: " + I2S(BlzGroupGetSize(usedWorkers)) + " for mine " + GetUnitName(mine))
    call GroupRemoveGroup(usedWorkers, autoLoadMineWorkers)
    call GroupClear(usedWorkers)
    call DestroyGroup(usedWorkers)
    set usedWorkers = null
endfunction

private function ForGroupAutoLoadMine takes nothing returns nothing
    call AutoLoadMineAI(GetEnumUnit())
endfunction

private function AutloadWorkersIntoMinesAI takes player whichPlayer returns nothing
    local group mines = CreateGroup()
    local group workers = CreateGroup()
    call GroupEnumUnitsOfPlayer(mines, whichPlayer, Filter(function FilterIsUnitMineOrHousingOfRace))
    call GroupEnumUnitsOfPlayer(workers, whichPlayer, Filter(function FilterIsUnitFreeWorker))
    //call BJDebugMsg("Mines: " + I2S(BlzGroupGetSize(mines)))
    //call BJDebugMsg("Workers: " + I2S(BlzGroupGetSize(workers)))
    set autoLoadMineCounter = 0
    set autoLoadMineWorkers = workers
    call ForGroup(mines, function ForGroupAutoLoadMine)
    call GroupClear(mines)
    call DestroyGroup(mines)
    call GroupClear(workers)
    call DestroyGroup(workers)
    set workers = null
    // gets annoying
    //call DisplayTimedTextToForce(GetPlayersAll(), 4.0, "Auto loaded " + I2S(autoLoadMineCounter) + " workers for player " + GetPlayerNameColored(whichPlayer))
    set mines = null
endfunction

globals
    private unit array ghoul
endglobals

private function StartingUnitsPeons takes player whichPlayer, location l, integer whichRace returns nothing
    local integer peonId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_WORKER)
    local integer ghoulId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_FOOTMAN)
    local real     peonX = GetLocationX(l)
    local real     peonY = GetLocationY(l) - 224.00
    local real     unitSpacing   = 64.00
    local unit peon = null
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    // Spawn Peasants directly south of the town hall.
    set peon = CreateUnit(whichPlayer, peonId, peonX + 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
    call GroupAddUnit(udg_ComputerWorkers[convertedPlayerId], peon)
    set peon = CreateUnit(whichPlayer, peonId, peonX + 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
    call GroupAddUnit(udg_ComputerWorkers[convertedPlayerId], peon)
    set peon = CreateUnit(whichPlayer, peonId, peonX + 0.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
    call GroupAddUnit(udg_ComputerWorkers[convertedPlayerId], peon)
    if (GetRaceHasFootmanWorker(whichRace)) then
        set peon = CreateUnit(whichPlayer, ghoulId, peonX - 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
        set ghoul[GetPlayerId(whichPlayer)] = peon
    else
        set peon = CreateUnit(whichPlayer, peonId, peonX - 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
        call GroupAddUnit(udg_ComputerWorkers[convertedPlayerId], peon)
        set peon = CreateUnit(whichPlayer, peonId, peonX - 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
        call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
        call GroupAddUnit(udg_ComputerWorkers[convertedPlayerId], peon)
    endif
endfunction

private function StartingUnitsShredders takes player whichPlayer, location l, integer whichRace returns nothing
    local real     peonX = GetLocationX(l)
    local real     peonY = GetLocationY(l) - 412.00
    local real     unitSpacing   = 64.00
    local unit peon = null
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    // Spawn Peasants directly south of the town hall.
    set peon = CreateUnit(whichPlayer, SHREDDER, peonX + 2.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
    set peon = CreateUnit(whichPlayer, SHREDDER, peonX + 1.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
    set peon = CreateUnit(whichPlayer, SHREDDER, peonX + 0.00 * unitSpacing, peonY + 0.00 * unitSpacing, bj_UNIT_FACING)
    call GroupAddUnit(udg_ComputerUnits[convertedPlayerId], peon)
endfunction

private function FilterFunctionIsMine takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == GOLD_MINE
endfunction

private function StartingUnitsReplaceMine takes player whichPlayer, unit mine, integer whichRace returns nothing
    local integer mineId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE) // TODO Always use AI version
    local location l = GetUnitLoc(mine)
    call ReplaceUnitBJ(mine, mineId, bj_UNIT_STATE_METHOD_RELATIVE)
    call SetUnitOwner(GetLastReplacedUnitBJ(), whichPlayer, true)
    call SetResourceAmount(GetLastReplacedUnitBJ(), 1000000)
    call StartingUnitsPeons(whichPlayer, l, whichRace)
    
    if (GetRaceHasBlight(whichRace)) then
        // Create a patch of blight around the gold mine.
        call SetBlightLoc(whichPlayer, l, 768, true)
    endif
    
    call RemoveLocation(l)
    set l = null
endfunction

private function StartingUnitsReplaceAllMines takes player whichPlayer, location l, integer whichRace returns nothing
    local group mines = GetUnitsInRangeOfLocMatching(2048.00, l, Filter(function FilterFunctionIsMine))
    local integer max = BlzGroupGetSize(mines)
    local integer i = 0
    loop
        exitwhen (i == max)
        call StartingUnitsReplaceMine(whichPlayer, BlzGroupUnitAt(mines, i), whichRace)
        set i = i + 1
    endloop
    call GroupClear(mines)
    call DestroyGroup(mines)
    set mines = null
endfunction

private function StartingUnitsAndPickAIStandard takes player whichPlayer, location l, integer whichRace, boolean recreate returns nothing
    local integer townHallId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_TIER_1)
    local unit townHall = CreateUnitAtLoc(whichPlayer, townHallId, l, bj_UNIT_FACING)
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    call GroupAddUnit(udg_ComputerTownHalls[convertedPlayerId], townHall)
    call GroupAddUnit(udg_ComputerBuildings[convertedPlayerId], townHall)
    // Spawn Peasants directly south of the town hall.
    call StartingUnitsPeons(whichPlayer, l, whichRace)
    call StartingUnitsShredders(whichPlayer, l, whichRace)
    if (not recreate) then
        call StartCampaignAI(whichPlayer, GetRaceAIScript(whichRace))
    endif
    if (GetRaceHasFootmanWorker(whichRace)) then
        call RecycleGuardPosition(ghoul[GetPlayerId(whichPlayer)])
    endif
endfunction

private function StartingUnitsAndPickAIEx takes player whichPlayer, location l, integer whichRace, boolean recreate returns nothing
    local integer mineId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE)
    call PingMinimap(GetLocationX(l), GetLocationY(l), 4.0)
    //call BJDebugMsg("Create starting units with peons for player " + GetPlayerName(whichPlayer) + " and race " + I2S(whichRace))
    call StartingUnitsAndPickAIStandard(whichPlayer, l, whichRace, recreate)
    if (mineId != 0) then
        call StartingUnitsReplaceAllMines(whichPlayer, l, whichRace)
        call AutloadWorkersIntoMinesAI(whichPlayer)
    endif
endfunction

private function StartingUnitsAndPickAI takes player whichPlayer, location l, integer whichRace returns nothing
    call StartingUnitsAndPickAIEx(whichPlayer, l, whichRace, false)
endfunction

function RecreateStartingUnitsAI takes player whichPlayer returns nothing
    local integer index = udg_ComputerStartLocation[GetConvertedPlayerId(whichPlayer)]
    local ComputerStartLocation c = GetComputerStartLocation(index)
    local location l = Location(c.x, c.y)
    call StartingUnitsAndPickAIEx(whichPlayer, l, GetPlayerRace1(whichPlayer), true)
    call RemoveLocation(l)
    set l = null
endfunction

private function FilterIsRemovableUnit takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetFilterUnit())
    return unitTypeId != FOUNTAIN_OF_LIFE and not IsUnitInGroup(GetFilterUnit(), udg_ClanHalls)
endfunction

private function ForGroupRemoveUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    call DropAllItemsFromHero(u)
    call RemoveUnit(u)
    set u = null
endfunction

function RemovePlayerUnits takes player whichPlayer returns nothing
    local group g = CreateGroup()
    call KillAllHauntedGoldMines(whichPlayer)
    call MountKillAll(whichPlayer)
    call DropBackpackForPlayer(whichPlayer, gg_rct_redirect_forbidden_zone)
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function FilterIsRemovableUnit))
    call ForGroup(g, function ForGroupRemoveUnit)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function FilterIsBuilding takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

private function FilterIsTownHall takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL)
endfunction

private function FilterIsUnit takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

private function FilterIsWorker takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

function AddAllPreplacedComputerUnits takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    call GroupEnumUnitsOfPlayer(udg_ComputerBuildings[convertedPlayerId], whichPlayer, Filter(function FilterIsBuilding))
    call GroupEnumUnitsOfPlayer(udg_ComputerTownHalls[convertedPlayerId], whichPlayer, Filter(function FilterIsTownHall))
    call GroupEnumUnitsOfPlayer(udg_ComputerUnits[convertedPlayerId], whichPlayer, Filter(function FilterIsUnit))
    call GroupEnumUnitsOfPlayer(udg_ComputerWorkers[convertedPlayerId], whichPlayer, Filter(function FilterIsWorker))
endfunction

private function PickRandomUnusedRace takes player owner returns integer
    local integer i = 1
    local integer max = GetRacesMax()
    loop
        exitwhen (i >= max)
        if (not PlayerHasRace(owner, i)) then
            return i
        endif
        set i = i + 1
    endloop
    return udg_RaceNone
endfunction

private function EnumAITechnologies takes nothing returns nothing
    // No Portals for AI to avoid crashes
    call SetPlayerUnitAvailableBJ('h014', false, GetEnumPlayer())
    call SetPlayerAbilityAvailableBJ(false, 'A05V', GetEnumPlayer())
    call SetPlayerAbilityAvailableBJ(false, 'A05W', GetEnumPlayer())
    call SetPlayerAbilityAvailableBJ(false, 'A05U', GetEnumPlayer())
    call SetPlayerAbilityAvailableBJ(false, 'Awrp', GetEnumPlayer())
    // Disable goldmines
    call SetPlayerUnitAvailableBJ('u00T', false, GetEnumPlayer())
    call SetPlayerUnitAvailableBJ('u00O', false, GetEnumPlayer())
    // Disable Tunnel Systems
    call SetPlayerUnitAvailableBJ('o00P', false, GetEnumPlayer())
    // Disable Special Buildings
    call SetPlayerUnitAvailableBJ('o01G', false, GetEnumPlayer())
    // Only AI Undead goldmine
    call SetPlayerUnitAvailableBJ('u00O', false, GetEnumPlayer())
    // Only AI Dwarf goldmine
    call SetPlayerUnitAvailableBJ('u00Y', false, GetEnumPlayer())
endfunction

private function EnumUserTechnologies takes nothing returns nothing
    call SetPlayerTechResearchedSwap('R019', 0, GetEnumPlayer())
    call SetPlayerTechResearchedSwap('R01C', 1, GetEnumPlayer())
    // Only non-AI Undead goldmine
    call SetPlayerUnitAvailableBJ('ugol', false, GetEnumPlayer())
    // Only non-AI Dwarf goldmine
    call SetPlayerUnitAvailableBJ('u011', false, GetEnumPlayer())
endfunction

private function EnumUpdateAllianceState takes nothing returns nothing
    if (IsPlayerAlly(GetTriggerPlayer(), GetEnumPlayer())) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_VISION, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_XP, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_SPELLS, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_HELP_REQUEST, true, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_HELP_RESPONSE, true, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_ALLIED")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    else
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_VISION, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_XP, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_SPELLS, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_HELP_REQUEST, false, GetTriggerPlayer())
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_HELP_RESPONSE, false, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_HOSTILE")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
    if (IsPlayerEnemy(GetTriggerPlayer(), GetEnumPlayer())) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_PASSIVE, false, GetTriggerPlayer())
    else
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_PASSIVE, true, GetTriggerPlayer())
    endif
    if (GetPlayerAlliance(GetTriggerPlayer(), GetEnumPlayer(), ALLIANCE_SHARED_CONTROL)) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_CONTROL, true, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    else
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_CONTROL, false, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
    if (GetPlayerAlliance(GetTriggerPlayer(), GetEnumPlayer(), ALLIANCE_SHARED_VISION)) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_VISION, true, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_VISION")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    else
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_VISION, false, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_VISION")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
    if (GetPlayerAlliance(GetTriggerPlayer(), GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL)) then
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, true, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    else
        call SetPlayerAllianceBJ(GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL, false, GetTriggerPlayer())
        call DisplayTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, Format(GetLocalizedStringSafe("ALLIANCE_NO_SHARED_ADVANCED_CONTROL")).s(GetPlayerNameColored(GetEnumPlayer())).result())
    endif
endfunction

private function TriggerConditionPlayerLeaves takes nothing returns boolean
    if (GetTriggerPlayer() == GetHostCached()) then
        if (CountAiPlayersWithConfig() > 0) then
            call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedStringSafe("AI_HOST_CHOOSES")).s(GetPlayerNameColored(GetHost())).result())
            call SetAiPlayersUiVisibleForPlayer(GetHost(), true)
        endif
    endif

    return false
endfunction

function DisableAllianceChangesTrigger takes nothing returns nothing
    call DisableTrigger(allianceChangeTrigger)
endfunction

function EnableAllianceChangesTrigger takes nothing returns nothing
    call EnableTrigger(allianceChangeTrigger)
endfunction

private function TriggerConditionAllianceChange takes nothing returns boolean
    if (GetPlayerController(GetTriggerPlayer()) == MAP_CONTROL_USER and GetTriggerPlayer() != GetMapBossesPlayer()) then
        call DisableAllianceChangesTrigger()
        call ForForce(computerPlayers, function EnumUpdateAllianceState)
        //call h__DisplayTextToForce(GetForceOfPlayer(GetTriggerPlayer()), "TRIGSTR_16466")
        call EnableAllianceChangesTrigger()
        // Recreate the stats multiboard in case Warcraft's shared ressources multiboard appeared.
        call CreateStats()
    endif
    return false
endfunction

private function TriggerConditionHeroLevel takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    if (GetPlayerController(owner) == MAP_CONTROL_COMPUTER) then
        if (udg_Held[convertedPlayerId] == GetTriggerUnit()) then
            if (IsPlayerWarlord(owner)) then
                if (GetHeroLevel(GetTriggerUnit()) >= HERO_JOURNEY_RACE_2 and GetPlayerRace2(owner) == udg_RaceNone) then
                    set udg_PlayerRace2[convertedPlayerId] = PickRandomUnusedRace(owner)
                endif

                if (GetHeroLevel(GetTriggerUnit()) >= HERO_JOURNEY_RACE_3 and GetPlayerRace3(owner) == udg_RaceNone) then
                    set udg_PlayerRace3[convertedPlayerId] = PickRandomUnusedRace(owner)
                endif
            endif

            if (GetHeroLevel(GetTriggerUnit()) >= HERO_JOURNEY_PROFESSION_2 and GetPlayerProfession2(owner) == udg_ProfessionNone) then
                call ComputerAutopickProfession2(GetOwningPlayer(GetTriggerUnit()))
            endif

            if (GetHeroLevel(GetTriggerUnit()) >= HERO_JOURNEY_PROFESSION_3 and GetPlayerProfession3(owner) == udg_ProfessionNone) then
                call ComputerAutopickProfession3(GetOwningPlayer(GetTriggerUnit()))
            endif
        endif

        call AutoSkillHero(GetTriggerUnit())
    endif
    set owner = null
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    local integer playerId = GetPlayerId(owner)
    if (GetPlayerController(owner) == MAP_CONTROL_COMPUTER) then
        if (IsUnitInGroup(GetTriggerUnit(), computerTownHalls[playerId])) then
            call GroupRemoveUnit(computerTownHalls[playerId], GetTriggerUnit())

            // respawn last town hall
            if (BlzGroupGetSize(computerTownHalls[playerId]) == 0 and udg_AIRespawn) then
                call RecreateStartingUnitsAI(owner)

                // The player needs enough gold to build workers
                if (GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) < 100) then
                    call AdjustPlayerStateBJ(100, owner, PLAYER_STATE_RESOURCE_GOLD)
                endif
            endif
        elseif (IsUnitInGroup(GetTriggerUnit(), computerShipyards[playerId])) then
            call GroupRemoveUnit(computerShipyards[playerId], GetTriggerUnit())

            // respawn last shipyard
            if (BlzGroupGetSize(computerShipyards[playerId]) == 0 and udg_AIRespawn) then
                call GroupAddUnit(computerShipyards[playerId], CreateUnit(owner, GetUnitTypeId(GetTriggerUnit()), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), bj_UNIT_FACING))
            endif
        endif

        if (not udg_AIRespawn and GetPlayerState(owner, PLAYER_STATE_GAME_RESULT) != 1 and GetMapAllowConfigureAIPlayer(owner)) then
            call CustomDefeatBJ(owner, GetLocalizedString("GAMEOVER_DEFEAT"))
            call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_DEFEATED_Y")).s(GetPlayerNameColored(GetOwningPlayer(GetKillingUnit()))).s(GetPlayerNameColored(owner)).result())
        endif
    endif
    set owner = null
    return false
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    local player owner = GetOwningPlayer(GetConstructedStructure())
    local integer playerId = GetPlayerId(owner)
    if (GetPlayerController(owner) == MAP_CONTROL_COMPUTER) then
        if (IsUnitType(GetConstructedStructure(), UNIT_TYPE_TOWNHALL)  and not IsUnitInGroup(GetConstructedStructure(), computerTownHalls[playerId])) then
            call GroupAddUnit(computerTownHalls[playerId], GetConstructedStructure())

            if (BlzGroupGetSize(computerTownHalls[playerId]) == 01) then
                // The player needs enough gold to build workers
                if (GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) < 100) then
                    call AdjustPlayerStateBJ(100, owner, PLAYER_STATE_RESOURCE_GOLD)
                endif
            endif
        endif
    endif
    set owner = null
    return false
endfunction

private function EnumAutoTrainNavy takes nothing returns nothing
    call ComputerAITrainNavy(GetEnumUnit())
endfunction

private function EnumAutoAttackNavy takes nothing returns nothing
    local integer playerId = GetPlayerId(GetEnumPlayer())
    if (BlzGroupGetSize(computerNavy[playerId]) >= 5) then
        call ComputerAINavyAttacks(GetEnumPlayer())
    else
        call ForGroup(computerShipyards[playerId], function EnumAutoTrainNavy)
    endif
endfunction

private function TimerFunctionAutoAttackNavy takes nothing returns nothing
    call ForForce(computerPlayers, function EnumAutoAttackNavy)
endfunction

private function EnumAutoLoadMines takes nothing returns nothing
    if (PlayerHasRace(GetEnumPlayer(), udg_RaceDwarf) or PlayerHasRace(GetEnumPlayer(), udg_RaceDalaran) or PlayerHasRace(GetEnumPlayer(), udg_RaceSatyr)) then
        call AutloadWorkersIntoMinesAI(GetEnumPlayer())
    endif
endfunction

private function TimerFunctionAutoLoadMines takes nothing returns nothing
    call ForForce(computerPlayers, function EnumAutoLoadMines)
endfunction

private function EnumStartLobbySettings takes nothing returns nothing
    local integer playerId = GetPlayerId(GetEnumPlayer())
    local integer convertedPlayerId = GetConvertedPlayerId(GetEnumPlayer())
    local boolean isWarlord = false
    local integer startLocationIndex = -1
    local ComputerStartLocation computerStartLocation = 0
    local integer playerRace = udg_RaceNone
    local location l = null
    local integer i = 0
    local integer max = 0
    local unit hero = null
    // Name
    call SetPlayerName(GetEnumPlayer(), AiPlayersUIGetPlayerName(GetEnumPlayer()))
    // Color
    call SetPlayerColorBJ(GetEnumPlayer(), AiPlayersUIGetColor(GetEnumPlayer()), true)
    // Team
    call SetPlayerTeam(GetEnumPlayer(), AiPlayersUIGetTeam(GetEnumPlayer()))
    // TODO Update team forces!
    // Start Gold and Lumber and Food
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, AiPlayersUIGetStartGold(GetEnumPlayer()))
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, AiPlayersUIGetStartLumber(GetEnumPlayer()))
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, AiPlayersUIGetFoodLimit(GetEnumPlayer()))
    // Start Researches
    call SetPlayerTechResearchedSwap(UPG_EVOLUTION, AiPlayersUIGetStartEvolution(GetEnumPlayer()), GetEnumPlayer())
    call SetPlayerTechResearchedSwap(UPG_CHEAP_EVOLUTION, AiPlayersUIGetStartEvolution(GetEnumPlayer()), GetEnumPlayer())
    // Profession
    set udg_PlayerProfession[convertedPlayerId] = AiPlayersUIGetPlayerProfession(GetEnumPlayer())
    // Do not create profession items for AI. They cannot handle it.
    // Either Warlord or Freelancer
    set isWarlord = AiPlayersUIGetPlayerWarlord(GetEnumPlayer())
    // Start
    // Get free start location with a goldmine
    set startLocationIndex = AiPlayersUIGetStartLocation(GetEnumPlayer())
    // Create a main building and hero only if a goldmine is still available
    if (startLocationIndex != -1) then
        // Take Start Location
        set computerStartLocation = GetComputerStartLocation(startLocationIndex)
        set computerStartLocation.taken = true
        set l = Location(computerStartLocation.x, computerStartLocation.y)
        set udg_ComputerStartLocation[convertedPlayerId] = startLocationIndex
        call RemoveRandomMinesAtAIStartLocation(startLocationIndex)
        // Race
        set playerRace = AiPlayersUIGetPlayerRace(GetEnumPlayer(), startLocationIndex, GetPlayerTeam(GetEnumPlayer()))
        set udg_ComputerRace[convertedPlayerId] = playerRace
        set udg_PlayerRace[convertedPlayerId] = playerRace
        // Start Main Building and Workers
        call StartingUnitsAndPickAI(GetEnumPlayer(), l, playerRace)

        // Reveal start location once
        set i = 0
        set max = bj_MAX_PLAYERS
        loop
            exitwhen (i == max)
            call CreateFogModifierRadius(Player(i), FOG_OF_WAR_FOGGED, computerStartLocation.x, computerStartLocation.y, 512, true, true)
            set i = i + 1
        endloop

        // Harvest Bonuses
        if (playerRace == udg_RaceUndead or playerRace == udg_RaceNightElf or playerRace == udg_RaceDwarf or playerRace == udg_RaceDalaran) then
            call SetPlayerTechResearchedSwap('R019', 1, GetEnumPlayer())
        endif
        // Hero
        // After race for matching hero!
        set i = 0
        set max = AiPlayersUIGetHeroesCount(GetEnumPlayer())
        loop
            exitwhen (i == max)
            set hero = CreateUnit(GetEnumPlayer(), GetHeroUnitType(AiPlayersUIGetHero(GetEnumPlayer())), computerStartLocation.x, computerStartLocation.y, bj_UNIT_FACING)
            call SetHeroLevel(hero, AiPlayersUIGetHeroStartLevel(GetEnumPlayer()), false)
            call AddCommandButtons(hero)
            call AddSkillMenu(hero)
            call ApplyHeroClass(hero)
            call ApplyHeroMount(hero)
            call AutoSkillHero(hero)
            // Remove spell Invisible
            call UnitRemoveAbility(hero, 'Aivs')
            if (i == 0) then
                call SetPlayerHero1(GetEnumPlayer(), hero)
            elseif (i == 1) then
                call SetPlayerHero2(GetEnumPlayer(), hero)
            elseif (i == 2) then
                call SetPlayerHero3(GetEnumPlayer(), hero)
            endif
            if (not isWarlord) then
                call ModifyHeroStat(bj_HEROSTAT_STR, hero, bj_MODIFYMETHOD_ADD, udg_FreelancerBonusAttributes)
                call ModifyHeroStat(bj_HEROSTAT_AGI, hero, bj_MODIFYMETHOD_ADD, udg_FreelancerBonusAttributes)
                call ModifyHeroStat(bj_HEROSTAT_INT, hero, bj_MODIFYMETHOD_ADD, udg_FreelancerBonusAttributes)
            endif
            set i = i + 1
        endloop
        // Remove Altar on Theramore to prevent hero revivals there
        set bj_wantDestroyGroup = true
        call RemoveUnit(FirstOfGroup(GetUnitsOfPlayerAndTypeId(GetEnumPlayer(), FOUNTAIN_OF_LIFE)))
        if (isWarlord) then
            set udg_PlayerIsWarlord[convertedPlayerId] = true
            call SetPlayerHandicapXPBJ(GetEnumPlayer(), udg_WarlordXPRate)
        else
            set udg_PlayerIsWarlord[convertedPlayerId] = false
            call SetPlayerHandicapXPBJ(GetEnumPlayer(), udg_FreelancerXPRate)
            call SetPlayerTechResearchedSwap('R01W', 1, GetEnumPlayer())
            // Freelancer AI Gold Harvest Bonus
            call SetPlayerTechResearchedSwap('R02E', 1, GetEnumPlayer())
        endif
    endif
    // Attack Players
    if (AiPlayersUIGetAttackPlayers(GetEnumPlayer()) == 1) then
        call CommandAI(GetEnumPlayer(), COMMAND_ATTACK_PLAYERS_ON, 0)
    endif
    // Expansions
    if (AiPlayersUIGetExpansions(GetEnumPlayer()) > 0) then
        call CommandAI(GetEnumPlayer(), COMMAND_EXPANSIONS, AiPlayersUIGetExpansions(GetEnumPlayer()))
    endif
    // Navy
    if (computerStartLocation != 0 and computerStartLocation.hasShipyard and playerRace != udg_RaceNone) then
        if (GetRaceShipyard(playerRace) != 0) then
            call GroupAddUnit(computerShipyards[playerId], CreateUnit(GetEnumPlayer(), GetRaceShipyard(playerRace), computerStartLocation.shipyardX, computerStartLocation.shipyardY, bj_UNIT_FACING))
        endif
        if (GetRaceShipyard2(playerRace) != 0) then
            call GroupAddUnit(computerShipyards[playerId], CreateUnit(GetEnumPlayer(), GetRaceShipyard2(playerRace), computerStartLocation.shipyardX, computerStartLocation.shipyardY, bj_UNIT_FACING))
        endif
        call CommandAI(GetEnumPlayer(), COMMAND_SHIPS_ON, 0)
    endif
    // Difficulty
    call CommandAI(GetEnumPlayer(), COMMAND_EASY + AiPlayersUIGetDifficulty(GetEnumPlayer()), 0)
    // Allied vision
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], GetMapTeamPlayers(GetPlayerTeam(GetEnumPlayer())), bj_ALLIANCE_ALLIED_VISION)
    call SetForceAllianceStateBJ(GetMapTeamPlayers(GetPlayerTeam(GetEnumPlayer())), bj_FORCE_PLAYER[playerId], bj_ALLIANCE_ALLIED_VISION)
    // Shared control
    if (AiPlayersUIGetSharedControl(GetEnumPlayer()) == 1) then
        call SetForceAllianceStateBJ(bj_FORCE_PLAYER[playerId], GetMapTeamPlayers(GetPlayerTeam(GetEnumPlayer())), bj_ALLIANCE_ALLIED_ADVUNITS)
    endif
endfunction

private function StartLobbySettings takes nothing returns nothing
    call DisableTrigger(playerLeavesTrigger)
    // Create Computer player main buildings, workers and heroes
    call ForForce(computerLobbyPlayers, function EnumStartLobbySettings)
    // Recreate stats multiboard
    call CreateStats()
    // No AI
    //call ConditionalTriggerExecute(gg_trg_Computer_Init_No_AI)
endfunction

private function StartGame takes nothing returns nothing
    if (CountAiPlayersWithConfig() > 0) then
        call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedStringSafe("AI_HOST_CHOOSES")).s(GetPlayerNameColored(GetHost())).result())
        call SetAiPlayersUiVisibleForPlayer(GetHost(), true)
    else
        call StartLobbySettings()
    endif
endfunction

private function Init takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)

        set computerTownHalls[i] = CreateGroup()
        set computerShipyards[i] = CreateGroup()
        set computerNavy[i] = CreateGroup()

        if (GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call ForceAddPlayer(computerPlayers, slotPlayer)

            if (GetMapAllowConfigureAIPlayer(slotPlayer)) then
                call ForceAddPlayer(computerLobbyPlayers, slotPlayer)
            endif

            call TriggerRegisterPlayerEventAllianceChanged(allianceChangeTrigger, slotPlayer)
        elseif (GetPlayerController(slotPlayer) == MAP_CONTROL_USER) then
            call ForceAddPlayer(userPlayers, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop

    call ForForce(computerPlayers, function EnumAITechnologies)
    call ForForce(userPlayers, function EnumUserTechnologies)

    call TriggerAddCondition(playerLeavesTrigger, Condition(function TriggerConditionPlayerLeaves))

    call TriggerAddCondition(allianceChangeTrigger, Condition(function TriggerConditionAllianceChange))

    call TriggerRegisterAnyUnitEventBJ(heroLevelTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(heroLevelTrigger, Condition(function TriggerConditionHeroLevel))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))

    call TriggerAddAction(startLobbySettingsTrigger, function StartLobbySettings)

    /*
     * Prevents attacking each other from the beginning.
     * Do NOT enumerate all units and stop them in the beginning of the game which would cause a massive lag.
     */
    call SetPlayerAllianceStateBJ(GetMapBossesPlayer(), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(GetMapBossesPlayer(), GetMapGaiaPlayer(), bj_ALLIANCE_NEUTRAL)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetMapBossesPlayer(), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetMapGaiaPlayer(), bj_ALLIANCE_NEUTRAL)

    call TimerStart(autoRevivalTimer, 60.0, true, function ComputerAIAutoReviveHeroesAll)
    call TimerStart(autoCraftTimer, 120.0, true, function ComputerAIAutoCraft)
    call TimerStart(autoAttackNavyTimer, 360.0, true, function TimerFunctionAutoAttackNavy)
    call TimerStart(autoLoadMinesTimer, 120.0, true, function TimerFunctionAutoLoadMines)

    call OnStartGame(function StartGame)
endfunction

endlibrary
