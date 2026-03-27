library WoWReforgedRacing initializer Init requires SimError, Refund, PlayerColorUtils, WoWReforgedUtils

globals
    public constant integer MAX_CHECKPOINTS = 100
    public constant real CHECKPOINT_RADIUS = 100.0
    public constant string CHECKPOINT_TARGET_EFFECT = "Abilities\\Spells\\Other\\Aneu\\AneuTarget.mdl"

    private RacingTrack currentRacingTrack = 0
    private player firstPlace = null
    private player secondPlace = null
    private player thirdPlace = null
    private timer currentRacingTrackTimer = CreateTimer()
    private timerdialog currentRacingTrackTimerDialog = null
    private RacingTrack array racingTracks
    private integer racingTracksCounter = 0
    private trigger sellItemTrigger = CreateTrigger()
    private trigger enterCheckpointTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

function GetRacingTracksCount takes nothing returns integer
    return racingTracksCounter
endfunction

function GetRacingTrack takes integer index returns RacingTrack
    return racingTracks[index] 
endfunction

struct RacingTrack
    string name
    integer itemTypeId
    integer firstPlaceTrophyItemTypeId
    integer secondPlaceTrophyItemTypeId
    integer thirdPlaceTrophyItemTypeId
    unit array checkpoints[MAX_CHECKPOINTS]
    integer checkpointsCounter = 0
    integer array checkpointsDone[28] // bj_MAX_PLAYERS
    effect array checkpointEffects[28] // bj_MAX_PLAYERS
    boolean array finished[28] // bj_MAX_PLAYERS
endstruct

function RacingTrackWasFinished takes RacingTrack racingTrack, player whichPlayer returns boolean
    return racingTrack.finished[GetPlayerId(whichPlayer)]
endfunction

private function RefreshRacingTrackCheckpointEffect takes RacingTrack racingTrack, integer playerId returns nothing
    local player whichPlayer = Player(playerId)
    local integer index = racingTrack.checkpointsDone[playerId]
    if (racingTrack.checkpointEffects[playerId] != null) then
        if (index > 0) then
            call UnitShareVision(racingTrack.checkpoints[index - 1], whichPlayer, false)
        endif
        call DestroyEffect(racingTrack.checkpointEffects[playerId])
        set racingTrack.checkpointEffects[playerId] = null
    endif
    set racingTrack.checkpointEffects[playerId] = AddSpecialEffectTarget(CHECKPOINT_TARGET_EFFECT, racingTrack.checkpoints[index], "overhead")
    call BlzSetSpecialEffectColorByPlayer(racingTrack.checkpointEffects[playerId], whichPlayer)
    call UnitShareVision(racingTrack.checkpoints[index], whichPlayer, true)
    call PingMinimapForPlayer(whichPlayer, GetUnitX(racingTrack.checkpoints[index]), GetUnitY(racingTrack.checkpoints[index]), 6.0)
    set whichPlayer = null
endfunction

private function SetCheckPointsVisible takes RacingTrack racingTrack, boolean visible returns nothing
    local integer max = racingTrack.checkpointsCounter
    local integer i = 0
    loop
        exitwhen (i == max)
        call ShowUnit(racingTrack.checkpoints[i], visible)
        set i = i + 1
    endloop
endfunction

private function SetAllCheckPointsVisible takes boolean visible returns nothing
    local integer i = 0
    loop
        exitwhen (i >= racingTracksCounter)
        call SetCheckPointsVisible(racingTracks[i], visible)
        set i = i + 1
    endloop
endfunction

function HideCheckPointsVisible takes nothing returns nothing
    call SetAllCheckPointsVisible(false)
endfunction

private function SetCheckPointsDone takes RacingTrack racingTrack, integer done returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set racingTrack.checkpointsDone[i] = done
        set i = i + 1
    endloop
endfunction

private function RefreshAllCheckPointEffects takes RacingTrack racingTrack returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call RefreshRacingTrackCheckpointEffect(racingTrack, i)
        set i = i + 1
    endloop
endfunction

function GetPlayerRacingTrackNextCheckPoint takes player whichPlayer returns unit
    if (currentRacingTrack == 0) then
        return null
    endif
    return currentRacingTrack.checkpoints[currentRacingTrack.checkpointsDone[GetPlayerId(whichPlayer)]]
endfunction

private function DestoyAllCheckPointEffects takes RacingTrack racingTrack returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (racingTrack.checkpointEffects[i] != null) then
            call DestroyEffect(racingTrack.checkpointEffects[i])
            set racingTrack.checkpointEffects[i] = null
            call UnitShareVision(GetPlayerRacingTrackNextCheckPoint(Player(i)), Player(i), false)
        endif
        set i = i + 1
    endloop
endfunction

private function FinishRacingTrack takes RacingTrack racingTrack returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (racingTrack.checkpointsDone[i] >=  racingTrack.checkpointsCounter and not racingTrack.finished[i]) then
            set racingTrack.finished[i] = true
        endif
        set i = i + 1
    endloop
endfunction

private function ResetRaceWinners takes nothing returns nothing
    set firstPlace = null
    set secondPlace = null
    set thirdPlace = null
endfunction

function GetRacingWinners takes nothing returns string
    local string msg = "1st: " 
    if (firstPlace != null) then
        set msg = msg + GetPlayerNameColored(firstPlace)
    else
        set msg = msg + "-"
    endif
    set msg = msg + ", 2nd: "
    if (secondPlace != null) then
        set msg = msg + GetPlayerNameColored(secondPlace)
    else
        set msg = msg + "-"
    endif
    set msg = msg + ", 3rd: "
    if (thirdPlace != null) then
        set msg = msg + GetPlayerNameColored(thirdPlace)
    else
        set msg = msg + "-"
    endif
    return msg
endfunction

function GiveRaceRewards takes nothing returns nothing
    if (firstPlace != null) then
        call UnitAddItemById(GetPlayerHero1(firstPlace), currentRacingTrack.firstPlaceTrophyItemTypeId)
    endif
    if (secondPlace != null) then
        call UnitAddItemById(GetPlayerHero1(firstPlace), currentRacingTrack.secondPlaceTrophyItemTypeId)
    endif
    if (thirdPlace != null) then
        call UnitAddItemById(GetPlayerHero1(firstPlace), currentRacingTrack.thirdPlaceTrophyItemTypeId)
    endif
endfunction

function EndRace takes RacingTrack racingTrack returns boolean
    if (currentRacingTrack == racingTrack) then
        call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_SECRET, Format(GetLocalizedString("RACE_HAS_ENDED")).s(currentRacingTrack.name).s(GetRacingWinners()).result())
        call GiveRaceRewards()

        set currentRacingTrack = 0
        call TimerDialogDisplay(currentRacingTrackTimerDialog, false)
        call SetCheckPointsVisible(racingTrack, false)
        call DestoyAllCheckPointEffects(racingTrack)
        call FinishRacingTrack(racingTrack)
        call ResetRaceWinners()
        
        return true
    endif
    
    return false
endfunction

private function TimerFunctionEndRace takes nothing returns nothing
    if (currentRacingTrack != 0) then
        call EndRace(currentRacingTrack)
    endif
endfunction

function GetRacingTrackDistance takes RacingTrack racingTrack returns real
    local real distance = 0.0
    local integer max = racingTrack.checkpointsCounter
    local integer i = 0
    loop
        exitwhen (i + 1 >= max)
        set distance = distance + DistanceBetweenUnits(racingTrack.checkpoints[i], racingTrack.checkpoints[i + 1])
        set i = i + 1
    endloop
    return distance
endfunction

function GetRacingTrackDuration takes RacingTrack racingTrack returns real
    return GetRacingTrackDistance(racingTrack) / 100.0
endfunction

function StartRace takes RacingTrack racingTrack returns boolean
    if (currentRacingTrack == 0) then
        set currentRacingTrack = racingTrack
        call SetCheckPointsVisible(racingTrack, true)
        call SetCheckPointsDone(racingTrack, 0)
        call ResetRaceWinners()
        call RefreshAllCheckPointEffects(racingTrack)
        
        call TimerStart(currentRacingTrackTimer, GetRacingTrackDuration(racingTrack), false, function TimerFunctionEndRace)
        if (currentRacingTrackTimerDialog == null) then
            set currentRacingTrackTimerDialog = CreateTimerDialog(currentRacingTrackTimer)
        endif
        call TimerDialogSetTitle(currentRacingTrackTimerDialog, racingTrack.name)
        call TimerDialogDisplay(currentRacingTrackTimerDialog, true)
        
        return true
    endif
    
    return false
endfunction

private function CheckAllPlayersForRaceEnd takes nothing returns boolean
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER and currentRacingTrack.checkpointsDone[i] < currentRacingTrack.checkpointsCounter) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

private function CheckForRaceEnd takes nothing returns nothing
    if (currentRacingTrack != 0) then
        if (CheckAllPlayersForRaceEnd()) then
            call EndRace(currentRacingTrack)
        endif
    endif
endfunction

private function PlaceRaceWinner takes player whichPlayer returns nothing
    if (firstPlace == null) then
        set firstPlace = whichPlayer
    elseif (secondPlace == null and firstPlace != whichPlayer) then
        set secondPlace = whichPlayer
    elseif (thirdPlace == null and firstPlace != whichPlayer and secondPlace != whichPlayer) then
        set thirdPlace = whichPlayer
    endif
    call CheckForRaceEnd()
endfunction

function GetRacingTrackByItemTypeId takes integer itemTypeId returns RacingTrack
    local integer i = 0
    loop
        exitwhen (i == racingTracksCounter)
        if (itemTypeId == racingTracks[i].itemTypeId) then
            return racingTracks[i]
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function AddRacingTrack takes string name, integer itemTypeId, integer firstPlaceTrophyItemTypeId, integer secondPlaceTrophyItemTypeId, integer thirdPlaceTrophyItemTypeId returns RacingTrack
    local RacingTrack this = RacingTrack.create()
    set this.name = name
    set this.itemTypeId = itemTypeId
    set this.firstPlaceTrophyItemTypeId = firstPlaceTrophyItemTypeId
    set this.secondPlaceTrophyItemTypeId = secondPlaceTrophyItemTypeId
    set this.thirdPlaceTrophyItemTypeId = thirdPlaceTrophyItemTypeId
    
    set racingTracks[racingTracksCounter] = this
    set racingTracksCounter = racingTracksCounter + 1
    
    return this
endfunction

function AddRacingTrackCheckpoint takes RacingTrack t, unit whichUnit returns nothing
    local integer index = t.checkpointsCounter
    local location l = GetUnitLoc(whichUnit)
    local region r = CreateRegion()
    local integer handleId = GetHandleId(r)
    call RegionAddRect(r, GetRectFromCircleBJ(l, CHECKPOINT_RADIUS))
    call RemoveLocation(l)
    set l = null
    call SaveInteger(h, handleId, 0, t)
    call SaveInteger(h, handleId, 1, index)
    set t.checkpoints[index] = whichUnit
    set t.checkpointsCounter = index + 1
    call TriggerRegisterEnterRegion(enterCheckpointTrigger, r, null)
endfunction

function AddRacingTrackWoWReforged takes nothing returns nothing
    set udg_TmpInteger = AddRacingTrack(udg_TmpString, udg_TmpItemTypeId, udg_TmpItemTypeId2, udg_TmpItemTypeId3, udg_TmpItemTypeId4)
endfunction

function AddRacingTrackCheckpointWoWReforged takes nothing returns nothing
    call AddRacingTrackCheckpoint(udg_TmpInteger, udg_TmpUnit)
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    local item whichItem = GetSoldItem()
    local RacingTrack t = GetRacingTrackByItemTypeId(GetItemTypeId(whichItem))
    local player owner = GetOwningPlayer(GetBuyingUnit())
    if (t != 0) then
        if (StartRace(t)) then
             call RemoveItem(whichItem)
        else
            call SimError(owner, Format(GetLocalizedString("RACE_ALREADY_RUNNING")).s(currentRacingTrack.name).result())
            call RefundItem(whichItem, owner)
        endif
    endif
    set whichItem = null
    set owner = null
    return false
endfunction

private function TriggerConditionEnterCheckpoint takes nothing returns boolean
    local integer handleId = GetHandleId(GetTriggeringRegion())
    local RacingTrack t = LoadInteger(h, handleId, 0)
    local integer index = LoadInteger(h, handleId, 1)
    local unit hero = GetTriggerUnit()
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    if (t != 0 and currentRacingTrack == t and IsPlayerHero1(hero) and t.checkpointsDone[playerId] == index) then
        set t.checkpointsDone[playerId] = t.checkpointsDone[playerId] + 1
        call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_SECRET, Format(GetLocalizedString("RACE_CHECKPOINTS")).i(t.checkpointsDone[playerId]).i(t.checkpointsCounter).result())
        if (t.checkpointsDone[playerId] >= t.checkpointsCounter) then
            call PlaceRaceWinner(owner)
        else
            call RefreshRacingTrackCheckpointEffect(t, playerId)
        endif
    endif
    set owner = null
    set hero = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSellItem))
    
    call TriggerAddCondition(enterCheckpointTrigger, Condition(function TriggerConditionEnterCheckpoint))
endfunction

endlibrary
