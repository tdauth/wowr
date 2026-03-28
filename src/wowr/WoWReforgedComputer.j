library WoWReforgedComputer initializer Init requires PlayerColorUtils, ItemUtils, WoWReforgedRaces, WoWReforgedZones, WoWReforgedUtils, WoWReforgedMounts, WoWReforgedRaces, WoWReforgedBackpacks, WoWReforgedResearches, WoWReforgedDependencyEquivalents, WoWReforgedAltars, WoWReforgedMapData

globals
    private trigger heroLevelTrigger = CreateTrigger()
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

function GetComputerAINavy takes player whichPlayer returns group
    return udg_ComputerNavy[GetPlayerId(whichPlayer)]
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

function AutloadWorkersIntoMinesAI takes player whichPlayer returns nothing
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

function StartingUnitsPeons takes player whichPlayer, location l, integer whichRace returns nothing
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

function StartingUnitsShredders takes player whichPlayer, location l, integer whichRace returns nothing
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

function StartingUnitsReplaceMine takes player whichPlayer, unit mine, integer whichRace returns nothing
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

function StartingUnitsReplaceAllMines takes player whichPlayer, location l, integer whichRace returns nothing
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

function StartingUnitsAndPickAIStandard takes player whichPlayer, location l, integer whichRace, boolean recreate returns nothing
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

function StartingUnitsAndPickAIEx takes player whichPlayer, location l, integer whichRace, boolean recreate returns nothing
    local integer mineId = GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE)
    call PingMinimap(GetLocationX(l), GetLocationY(l), 4.0)
    //call BJDebugMsg("Create starting units with peons for player " + GetPlayerName(whichPlayer) + " and race " + I2S(whichRace))
    call StartingUnitsAndPickAIStandard(whichPlayer, l, whichRace, recreate)
    if (mineId != 0) then
        call StartingUnitsReplaceAllMines(whichPlayer, l, whichRace)
        call EnableTrigger(gg_trg_Computer_Auto_Load_Mines)
        call AutloadWorkersIntoMinesAI(whichPlayer)
    endif
endfunction

function StartingUnitsAndPickAI takes player whichPlayer, location l, integer whichRace returns nothing
    call StartingUnitsAndPickAIEx(whichPlayer, l, whichRace, false)
endfunction

function RecreateStartingUnitsAI takes player whichPlayer returns nothing
    local location l = GetRectCenter(udg_TownHallLocation[udg_ComputerStartLocation[GetConvertedPlayerId(whichPlayer)]])
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

private function TriggerConditionHeroLevel takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    if (GetPlayerController(owner) == MAP_CONTROL_COMPUTER and udg_Held[convertedPlayerId] == GetTriggerUnit()) then
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
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(heroLevelTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(heroLevelTrigger, Condition(function TriggerConditionHeroLevel))

    /*
     * Prevents attacking each other from the beginning.
     * Do NOT enumerate all units and stop them in the beginning of the game which would cause a massive lag.
     */
    call SetPlayerAllianceStateBJ(GetMapBossesPlayer(), Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(GetMapBossesPlayer(), GetMapGaiaPlayer(), bj_ALLIANCE_NEUTRAL)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetMapBossesPlayer(), bj_ALLIANCE_ALLIED_VISION)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetMapGaiaPlayer(), bj_ALLIANCE_NEUTRAL)
endfunction

endlibrary
