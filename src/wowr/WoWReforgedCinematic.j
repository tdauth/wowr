library WoWReforgedCinematic initializer Init requires TextTagUtils, SelectionUtils, ItemRespawn, optional QueueUI, WoWReforgedTextTag, WoWReforgedCalendar, optional WoWReforgedUiActionsBar

globals
    public constant string PREFIX_X = "CINEMATIC_X"
    public constant string PREFIX_Y = "CINEMATIC_Y"

    private group array playerSelections
    private boolean array playerQueueUIEnabled
    private real array playerCameraX
    private real array playerCameraY
    
    private trigger syncTrigger = CreateTrigger()
    private group actors = CreateGroup()
    private effect array effects
    private integer effectsCounter = 0
endglobals

function AddCinematicActor takes unit whichUnit returns nothing
    call GroupAddUnit(actors, whichUnit)
endfunction

function AddCinematicEffectLastCreated takes nothing returns nothing
    set effects[effectsCounter] = GetLastCreatedEffectBJ()
    set effectsCounter = effectsCounter + 1
endfunction

function RemoveAllCinematicEffects takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == effectsCounter)
        call DestroyEffect(effects[i])
        set i = i + 1
    endloop
    set effectsCounter = 0
endfunction

static if (LIBRARY_QueueUI) then
private function StorePlayerQueueUI takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        set playerQueueUIEnabled[i] = IsQueueUIEnabledForPlayer(slotPlayer)
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function RestorePlayerQueueUI takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        call SetQueueUIEnabledForPlayer(slotPlayer, playerQueueUIEnabled[i])
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction
endif

static if (LIBRARY_WoWReforgedUiActionsBar) then
private function EnumHideActionsBar takes nothing returns nothing
    call HideActionsBarUI(GetEnumPlayer())
endfunction
endif

function PrepareCinematic takes nothing returns nothing
    set udg_CinematicPreparation = true
static if (LIBRARY_QueueUI) then
    call StorePlayerQueueUI()
    call HideQueueUI()
endif
static if (LIBRARY_WoWReforgedUiActionsBar) then
    call ForForce(GetPlayersAll(), function EnumHideActionsBar)
endif
endfunction

function EndPrepareCinematic takes nothing returns nothing
    set udg_CinematicPreparation = false
endfunction

static if (LIBRARY_WoWReforgedUiActionsBar) then
private function EnumShowActionsBar takes nothing returns nothing
    call ShowActionsBarUI(GetEnumPlayer())
endfunction
endif

function UnprepareCinematic takes nothing returns nothing
static if (LIBRARY_QueueUI) then
    call RestorePlayerQueueUI()
endif
static if (LIBRARY_WoWReforgedUiActionsBar) then
    call ForForce(GetPlayersAll(), function EnumShowActionsBar)
endif
endfunction

private function StorePlayerSelections takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        
        if (playerSelections[i] != null) then
            call GroupClear(playerSelections[i])
            call DestroyGroup(playerSelections[i])
            set playerSelections[i] = null
        endif
        
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            set playerSelections[i] = GetUnitsSelectedAllSafe(slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function RestorePlayerSelections takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        
        if (playerSelections[i] != null and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call SelectGroupForPlayerBJ(playerSelections[i], slotPlayer)
        endif
        
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function EnumHideAllTextTags takes nothing returns nothing
    call ShowAllTextTagsForPlayer(GetEnumPlayer(), false)
endfunction

private function SyncCameraPositions takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            if (slotPlayer == GetLocalPlayer()) then
                call BlzSendSyncData(PREFIX_X, R2S(GetCameraTargetPositionX()))
                call BlzSendSyncData(PREFIX_Y, R2S(GetCameraTargetPositionY()))
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

globals
    private group paused = CreateGroup()
endglobals

private function FilterIsNotPaused takes nothing returns boolean
    return not IsUnitPaused(GetFilterUnit())
endfunction

function PauseAllUnits takes nothing returns nothing
    local integer index
    local player  indexPlayer
    local group   g

    set bj_pauseAllUnitsFlag = true
    set g = CreateGroup()
    call GroupClear(paused)
    set index = 0
    loop
        set indexPlayer = Player( index )

        // If this is a computer slot, pause/resume the AI.
        if (GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER) then
            call PauseCompAI(indexPlayer, true)
        endif

        // Enumerate and unpause every unit owned by the player.
        call GroupEnumUnitsOfPlayer(g, indexPlayer, Filter(function FilterIsNotPaused))
        call ForGroup(g, function PauseAllUnitsBJEnum)
        call GroupAddGroup(g, paused)
        call GroupClear(g)

        set index = index + 1
        exitwhen index == bj_MAX_PLAYER_SLOTS
    endloop
    call DestroyGroup(g)
    set g = null
endfunction

function UnpauseAllUnits takes nothing returns nothing
    local integer index
    local player  indexPlayer

    set bj_pauseAllUnitsFlag = false
    call ForGroup(paused, function PauseAllUnitsBJEnum)
    set index = 0
    loop
        set indexPlayer = Player(index)

        // If this is a computer slot, pause/resume the AI.
        if (GetPlayerController(indexPlayer) == MAP_CONTROL_COMPUTER) then
            call PauseCompAI(indexPlayer, false)
        endif

        set index = index + 1
        exitwhen index == bj_MAX_PLAYER_SLOTS
    endloop
    call GroupClear(paused)
endfunction

function EnableCinematic takes nothing returns nothing
    call StorePlayerSelections()
    call ForForce(GetPlayersAll(), function EnumHideAllTextTags)
    call SyncCameraPositions()
    call DisableCalendar()
    call ClearSelection()
    call PauseAllRespawnItems()
    call PauseAllUnits()
    call CinematicModeBJ(true, GetPlayersAll())
    set udg_CinematicRunning = true
endfunction

private function ForForceDisableCinematic takes nothing returns nothing
    local player p = GetEnumPlayer()
    local integer playerId = GetPlayerId(p)
    call ShowAllTextTagsForPlayer(p, true)
    call PanCameraToTimedForPlayer(p, playerCameraX[playerId], playerCameraY[playerId], 0.0)
    set p = null
endfunction

private function EnumRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function RemoveAllCinematicActors takes nothing returns nothing
    call ForGroup(actors, function EnumRemoveUnit)
    call GroupClear(actors)
endfunction

function DisableCinematic takes nothing returns nothing
    call RestorePlayerSelections()
    call ForForce(GetPlayersAll(), function ForForceDisableCinematic)
    call RemoveAllCinematicActors()
    call RemoveAllCinematicEffects()
    if (IsSeasonsEnabled()) then
        call EnableCalendar()
    endif
    call UnpauseAllUnits()
    call ResumeAllRespawnItems()
    call ResetToGameCamera(0.0)
endfunction

private function ForForceSelectHero takes nothing returns nothing
    local player p = GetEnumPlayer()
    local unit hero = GetLivingHero(p)
    if (hero != null) then
        call PanCameraToTimedForPlayer(p, GetUnitX(hero), GetUnitY(hero), 0.0)
        call SelectUnitForPlayerSingle(hero, p)
    endif
    set p = null
endfunction

function SelectHeroes takes nothing returns nothing
    call ForForce(GetPlayersAll(), function ForForceSelectHero)
endfunction

function WaitForCinematicEnd takes nothing returns nothing
    if (udg_CinematicRunning or udg_CinematicPreparation) then
        loop
            exitwhen not udg_CinematicRunning and not udg_CinematicCleanup and not udg_CinematicPreparation
            call TriggerSleepAction(bj_POLLED_WAIT_INTERVAL)
        endloop
    endif
endfunction

private function TriggerActionSync takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    local string prefix = BlzGetTriggerSyncPrefix()
    local string data = BlzGetTriggerSyncData()
    if (prefix == PREFIX_X) then
        set playerCameraX[playerId] = S2R(data)
    elseif (prefix == PREFIX_Y) then
        set playerCameraY[playerId] = S2R(data)
    endif
endfunction

private function Init takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerSelections[i] = CreateGroup()
        set slotPlayer = Player(i)
        set playerCameraX[i] = GetPlayerStartLocationX(slotPlayer)
        set playerCameraY[i] = GetPlayerStartLocationY(slotPlayer)
        call BlzTriggerRegisterPlayerSyncEvent(syncTrigger, slotPlayer, PREFIX_X, false)
        call BlzTriggerRegisterPlayerSyncEvent(syncTrigger, slotPlayer, PREFIX_Y, false)
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(syncTrigger, function TriggerActionSync)
endfunction

endlibrary
