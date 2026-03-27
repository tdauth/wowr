library ResourcesGui initializer Init requires OnStartGame, StringFormat, Resources, optional FrameLoader, optional UnitEventEx

globals
    private constant real X = 0.3053
    private constant real Y = 0.06
    private constant real WIDTH = 0.05
    private constant real HEIGHT = 0.05
    private constant real TEXT_X = X + WIDTH
    private constant real TEXT_WIDTH = 0.1
    
    private constant real X_GATHERED = 0.404
    private constant real Y_GATHERED = 0.09
    private constant real TEXT_X_GATHERED = X_GATHERED + WIDTH

    private framehandle IconFrame
    private framehandle TextFrame
    
    private framehandle IconFrameGathered
    private framehandle TextFrameGathered
    
    private framehandle IconFrameGathered2
    private framehandle TextFrameGathered2
    
    private trigger selectionTrigger = CreateTrigger()
    private trigger deselectionTrigger = CreateTrigger()
    private trigger gatherTrigger = CreateTrigger()
    private trigger returnTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    private timer array updateTimer
    private boolean array updateTimerRunning
    private unit array currentMine // currently selected unit of the corresponding player
    
    private trigger progressBarStartTrigger = CreateTrigger()
    private trigger progressBarFinishTrigger = CreateTrigger()
    private group progressBarUnits = CreateGroup()
    
    private player tmpPlayer = null
    private trigger tmpTrigger = CreateTrigger()
endglobals

private function SetResourcesUIVisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(IconFrame, visible)
    call BlzFrameSetVisible(TextFrame, visible)
endfunction

private function SetResourcesUIGatheredVisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(IconFrameGathered, visible)
    call BlzFrameSetVisible(TextFrameGathered, visible)
    call BlzFrameSetVisible(IconFrameGathered2, visible)
    call BlzFrameSetVisible(TextFrameGathered2, visible)
endfunction

private function SetResourcesUIGathered2VisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(IconFrameGathered2, visible)
    call BlzFrameSetVisible(TextFrameGathered2, visible)
endfunction

private function SetResourcesUIVisible takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetResourcesUIVisibleAll(visible)
    endif
endfunction

private function SetResourcesUIGatheredVisible takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetResourcesUIGatheredVisibleAll(visible)
    endif
endfunction

private function ShowResourcesUI takes player whichPlayer returns nothing
    call SetResourcesUIVisible(whichPlayer, true)
endfunction

private function HideResourcesUI takes player whichPlayer returns nothing
    call SetResourcesUIVisible(whichPlayer, false)
endfunction

private function ShowResourcesGatheredUI takes player whichPlayer returns nothing
    call SetResourcesUIGatheredVisible(whichPlayer, true)
endfunction

private function HideResourcesGatheredUI takes player whichPlayer returns nothing
    call SetResourcesUIGatheredVisible(whichPlayer, false)
endfunction

private function CreateResourcesUI takes nothing returns nothing
    set IconFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(IconFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(IconFrame, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(IconFrame, 1)

    set TextFrame = BlzCreateFrameByType("TEXT", "ResourceGuiText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TextFrame, FRAMEPOINT_TOPLEFT, TEXT_X, Y)
    call BlzFrameSetAbsPoint(TextFrame, FRAMEPOINT_BOTTOMRIGHT, TEXT_X + TEXT_WIDTH, Y - HEIGHT)
    call BlzFrameSetTextAlignment(TextFrame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(TextFrame, 1.0)
    call BlzFrameSetLevel(TextFrame, 1)
    
    set IconFrameGathered = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(IconFrameGathered, FRAMEPOINT_TOPLEFT, X_GATHERED, Y_GATHERED)
    call BlzFrameSetAbsPoint(IconFrameGathered, FRAMEPOINT_BOTTOMRIGHT, X_GATHERED + WIDTH, Y_GATHERED - HEIGHT)
    call BlzFrameSetLevel(IconFrameGathered, 1)

    set TextFrameGathered = BlzCreateFrameByType("TEXT", "ResourceGuiTextGathered", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TextFrameGathered, FRAMEPOINT_TOPLEFT, TEXT_X_GATHERED, Y_GATHERED)
    call BlzFrameSetAbsPoint(TextFrameGathered, FRAMEPOINT_BOTTOMRIGHT, TEXT_X_GATHERED + TEXT_WIDTH, Y_GATHERED - HEIGHT)
    call BlzFrameSetTextAlignment(TextFrameGathered, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(TextFrameGathered, 1.0)
    call BlzFrameSetLevel(TextFrameGathered, 1)
    
    set IconFrameGathered2 = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(IconFrameGathered2, FRAMEPOINT_TOPLEFT, X_GATHERED, Y)
    call BlzFrameSetAbsPoint(IconFrameGathered2, FRAMEPOINT_BOTTOMRIGHT, X_GATHERED + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(IconFrameGathered2, 1)

    set TextFrameGathered2 = BlzCreateFrameByType("TEXT", "ResourceGuiTextGathered2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TextFrameGathered2, FRAMEPOINT_TOPLEFT, TEXT_X_GATHERED, Y)
    call BlzFrameSetAbsPoint(TextFrameGathered2, FRAMEPOINT_BOTTOMRIGHT, TEXT_X_GATHERED + TEXT_WIDTH, Y - HEIGHT)
    call BlzFrameSetTextAlignment(TextFrameGathered2, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(TextFrameGathered2, 1.0)
    call BlzFrameSetLevel(TextFrameGathered2, 1)

    // hide for all players
    call SetResourcesUIVisibleAll(false)
    call SetResourcesUIGatheredVisibleAll(false)
    call SetResourcesUIGathered2VisibleAll(false)
endfunction

private function GetPrimaryResourceEx takes unit mine, Resource ignore returns Resource
    local Resource resource = 0
    local Resource result = 0
    local integer current = 0
    local integer currentMax = 0
    local integer v = 0
    local integer w = 0
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (resource != ignore) then
            set v = GetUnitResource(mine, resource)
            set w = GetUnitResourceMax(mine, resource)
            if (v > current) then
                set result = resource
                set current = v
            elseif (not IsStandardResource(resource) and current == 0 and w > currentMax) then
                set result = resource
                set currentMax = w
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

private function GetPrimaryResource takes unit mine returns Resource
    return GetPrimaryResourceEx(mine, 0)
endfunction

private function GetResourceGatheredText takes unit worker, Resource resource returns string
    if (GetPlayerResourceBonus(GetOwningPlayer(worker), resource) > 0) then
        return Format(GetLocalizedString("RESOURCE_X_OF_Y_BONUS_POSITIVE")).s(GetResourceName(resource)).i(GetUnitResource(worker, resource)).i(GetUnitResourceMax(worker, resource)).i(GetPlayerResourceBonus(GetOwningPlayer(worker), resource)).result()
    elseif (GetPlayerResourceBonus(GetOwningPlayer(worker), resource) < 0) then
        return Format(GetLocalizedString("RESOURCE_X_OF_Y_BONUS_NEGATIVE")).s(GetResourceName(resource)).i(GetUnitResource(worker, resource)).i(GetUnitResourceMax(worker, resource)).i(GetPlayerResourceBonus(GetOwningPlayer(worker), resource)).result()
    endif
    return Format(GetLocalizedString("RESOURCE_X_OF_Y")).s(GetResourceName(resource)).i(GetUnitResource(worker, resource)).i(GetUnitResourceMax(worker, resource)).result()
endfunction

private function UpdateGathered takes player whichPlayer, unit worker returns nothing
    local Resource resource = GetPrimaryResource(worker)
    local Resource resource2 = GetPrimaryResourceEx(worker, resource)
    //call BJDebugMsg("resource " + I2S(resource))
    if (GetLocalPlayer() == whichPlayer) then
        if (resource != 0) then
            call BlzFrameSetTexture(IconFrameGathered, GetResourceIconAtt(resource), 0, true)
            call BlzFrameSetText(TextFrameGathered, GetResourceGatheredText(worker, resource))
            //call BJDebugMsg("Icon mine " + GetResourceIcon(resource))
            //call BJDebugMsg("Text mine " + BlzFrameGetText(TextFrame))
            call SetResourcesUIGatheredVisibleAll(true)
        else
            call SetResourcesUIGatheredVisibleAll(false)
        endif
        
        if (resource2 != 0) then
            call BlzFrameSetTexture(IconFrameGathered2, GetResourceIconAtt(resource2), 0, true)
            call BlzFrameSetText(TextFrameGathered2, GetResourceGatheredText(worker, resource2))
            call SetResourcesUIGathered2VisibleAll(true)
        else
            call SetResourcesUIGathered2VisibleAll(false)
        endif
    endif
endfunction

private function ForGroupPrint takes nothing returns nothing
    call BJDebugMsg(GetUnitName(GetEnumUnit()))
endfunction

/*
 * Only returns a unit if it is the only selected unit by the given player.
 *
 * Actions like casting mirror image to not trigger deselection events, so we cannot use them to
 * get the current selection.
 */
private function GetSingleSelectedUnit takes player whichPlayer returns unit
    local group selected = CreateGroup()
    local unit first = null
    // Avoid SyncSelections in GetUnitsSelectedAll which delays and cannot be used in trigger conditions and too many uses will cause massive lags in the game.
    call GroupEnumUnitsSelected(selected, whichPlayer, null)
    if (BlzGroupGetSize(selected) == 1) then
        set first = FirstOfGroup(selected)
    endif
    call GroupClear(selected)
    call DestroyGroup(selected)
    set selected = null
    return first
endfunction

function PrintResourcesGuiSelection takes player whichPlayer returns nothing
    call BJDebugMsg("current selected unit from system " + GetUnitName(currentMine[GetPlayerId(whichPlayer)]))
    call BJDebugMsg("current selected unit by player " + GetUnitName(GetSingleSelectedUnit(whichPlayer)))
endfunction

private function HasNonEmptyCargo takes unit mine returns boolean
static if (LIBRARY_UnitEventEx) then
    return GetCargoSize(mine) > 0
else
    return false
endif
endfunction

private function HasProgressBar takes unit mine returns boolean
    return IsUnitInGroup(mine, progressBarUnits)
endfunction

function UpdatePlayerResourceSelectionGui takes player whichPlayer returns nothing
    local Resource resource = 0
    local integer playerId = GetPlayerId(whichPlayer)
    //call BJDebugMsg("UpdatePlayerResourceSelectionGui")
    set currentMine[playerId] = GetSingleSelectedUnit(whichPlayer)
    //call BJDebugMsg("Current single selected unit " + GetUnitName(currentMine[playerId]))
    // heroes have no space for the icons
    if (currentMine[playerId] != null and IsUnitType(currentMine[playerId], UNIT_TYPE_HERO)) then
        set currentMine[playerId] = null
    endif
    
    // with cargo there is no space for icons
static if (LIBRARY_UnitEventEx) then
    if (currentMine[playerId] != null and HasNonEmptyCargo(currentMine[playerId])) then
        set currentMine[playerId] = null
    endif
endif

    if (currentMine[playerId] != null and HasProgressBar(currentMine[playerId])) then
        set currentMine[playerId] = null
    endif

    //call BJDebugMsg("XXXXXXXXXXXX")
    if (currentMine[playerId] != null) then
        set resource = GetPrimaryResource(currentMine[playerId])
        
        //call PrintResourcesGuiSelection(whichPlayer)
        //call BJDebugMsg("mine " + GetUnitName(currentMine[playerId]) + " with primary resource " + I2S(resource))
        if (IsMine(currentMine[playerId]) and IsAlliedMine(currentMine[playerId], whichPlayer)) then
           // call BJDebugMsg("is mine")
            if (resource != 0) then
                //call BJDebugMsg("Show mine " + GetUnitName(currentMine[playerId]))
                if (GetLocalPlayer() == whichPlayer) then
                    call BlzFrameSetTexture(IconFrame, GetResourceIconAtt(resource), 0, true)
                    call BlzFrameSetText(TextFrame, Format(GetLocalizedString("RESOURCE_X")).s(GetResourceName(resource)).i(GetUnitResource(currentMine[playerId], resource)).result())
                    //call BJDebugMsg("Icon mine " + GetResourceIcon(resource))
                    //call BJDebugMsg("Text mine " + BlzFrameGetText(TextFrame))
                    call SetResourcesUIVisibleAll(true)
                    call SetResourcesUIGatheredVisibleAll(false)
                    call SetResourcesUIGathered2VisibleAll(false)
                endif
            else
                //call BJDebugMsg("selection counter is not 1 " + I2S(selectionCounter[playerId] ))
                //call BJDebugMsg("Hide mine " + GetUnitName(selected))
                if (GetLocalPlayer() == whichPlayer) then
                    call SetResourcesUIVisibleAll(false)
                    call SetResourcesUIGatheredVisibleAll(false)
                    call SetResourcesUIGathered2VisibleAll(false)
                endif
            endif
        elseif (resource != 0 and IsAlliedMine(currentMine[playerId], whichPlayer))then
            //call BJDebugMsg("Update gathered resources UI for player " + GetPlayerName(whichPlayer))
            call SetResourcesUIVisibleAll(false)
            call UpdateGathered(whichPlayer, currentMine[playerId])
        else
            //call BJDebugMsg("Hide gathered resources UI for player " + GetPlayerName(whichPlayer))
            call SetResourcesUIVisibleAll(false)
            call SetResourcesUIGatheredVisibleAll(false)
            call SetResourcesUIGathered2VisibleAll(false)
        endif
    else
        //call BJDebugMsg("Hide all resources UI for player " + GetPlayerName(whichPlayer))
        call SetResourcesUIVisibleAll(false)
        call SetResourcesUIGatheredVisibleAll(false)
        call SetResourcesUIGathered2VisibleAll(false)
    endif
endfunction

private function TriggerActionTmp takes nothing returns nothing
    call UpdatePlayerResourceSelectionGui(tmpPlayer)
endfunction

private function TimerFunctionUpdate takes nothing returns nothing
    local integer playerId = LoadInteger(h, GetHandleId(GetExpiredTimer()), 0)
    //call BJDebugMsg("Timer function with playerId " + I2S(playerId))
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    set tmpPlayer = Player(playerId)
    call TriggerExecute(tmpTrigger)
    set updateTimerRunning[playerId] = false
endfunction

private function StartUpdateTimer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    if (not updateTimerRunning[playerId]) then
        set updateTimerRunning[playerId] = true
        call TimerStart(updateTimer[playerId], 0.0, false, function TimerFunctionUpdate)
    endif
endfunction

public function StartUpdateTimerForUnits takes unit u0, unit u1 returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and ((u0 != null and IsUnitSelected(u0, slotPlayer)) or (u1 != null and IsUnitSelected(u1, slotPlayer)))) then
            call StartUpdateTimer(slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

private function TriggerActionSelected takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call StartUpdateTimer(GetTriggerPlayer())
endfunction

private function TriggerActionDeselected takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call StartUpdateTimer(GetTriggerPlayer())
endfunction

private function TriggerActionGather takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call StartUpdateTimerForUnits(GetTriggerWorker(), GetTriggerMine())
endfunction

private function TriggerActionReturn takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call StartUpdateTimerForUnits(GetTriggerWorker(), GetTriggerReturnBuilding())
endfunction

private function TriggerActionProgressBarStart takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if (not IsUnitInGroup(u, progressBarUnits)) then
        call GroupAddUnit(progressBarUnits, u)
        call StartUpdateTimerForUnits(u, null)
    endif
    set u = null
endfunction

private function TriggerActionProgressBarFinish takes nothing returns nothing
    local unit u = GetTriggerUnit()
    if (IsUnitInGroup(u, progressBarUnits)) then
        call GroupRemoveUnit(progressBarUnits, u)
        call StartUpdateTimerForUnits(u, null)
    endif
    set u = null
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set currentMine[i] = null
        set updateTimer[i] = CreateTimer()
        call SaveInteger(h, GetHandleId(updateTimer[i]), 0, i)
        set i = i + 1
    endloop
    call TriggerRegisterAnyUnitEventBJ(selectionTrigger, EVENT_PLAYER_UNIT_SELECTED)
    call TriggerAddAction(selectionTrigger, function TriggerActionSelected)
    
    call TriggerRegisterAnyUnitEventBJ(deselectionTrigger, EVENT_PLAYER_UNIT_DESELECTED)
    call TriggerAddAction(deselectionTrigger, function TriggerActionDeselected)
    
    call TriggerRegisterGatherEvent(gatherTrigger)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(gatherTrigger, function TriggerActionGather)
    
    call TriggerRegisterReturnEvent(returnTrigger)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(returnTrigger, function TriggerActionReturn)

    call OnStartGame(function CreateResourcesUI)
    
    call TriggerAddAction(tmpTrigger, function TriggerActionTmp)
    
    call TriggerRegisterAnyUnitEventBJ(progressBarStartTrigger, EVENT_PLAYER_UNIT_UPGRADE_START)
    call TriggerRegisterAnyUnitEventBJ(progressBarStartTrigger, EVENT_PLAYER_UNIT_RESEARCH_START)
    call TriggerRegisterAnyUnitEventBJ(progressBarStartTrigger, EVENT_PLAYER_UNIT_TRAIN_START)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(progressBarStartTrigger, function TriggerActionProgressBarStart)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerRegisterAnyUnitEventBJ(progressBarFinishTrigger, EVENT_PLAYER_UNIT_DEATH)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(progressBarFinishTrigger, function TriggerActionProgressBarFinish)
    
    static if LIBRARY_FrameLoader then
        call FrameLoaderAdd(function CreateResourcesUI)
    endif
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, progressBarUnits)) then
        call GroupRemoveUnit(progressBarUnits, whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
