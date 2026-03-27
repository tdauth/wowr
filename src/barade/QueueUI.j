library QueueUI initializer Init requires Queue, OnStartGame, optional QueueUIResearches, optional FrameLoader

globals
    // Set to false if the TOC file should not be loaded automatically.
    public constant boolean LOAD_TOC_FILE = false
    public constant string TOC_FILE = "war3mapImported\\QueueUI.toc"
    public constant integer MAX_SLOTS = 8
    public constant boolean PAN_CAMERA = true
    public constant string PREFIX = "QueueUI"
    public constant real Y = 0.19
    public constant real CHECK_BOX_X = 0.05
    public constant real CHECK_BOX_Y = Y
    public constant real CHECK_BOX_SIZE = 0.02
    public constant real BUTTON_SPACE = 0.001
    public constant real BUTTON_X = CHECK_BOX_X + CHECK_BOX_SIZE + BUTTON_SPACE
    public constant real BUTTON_Y = Y
    public constant real BUTTON_SIZE = 0.024
    public constant real CHARGES_SIZE = 0.014
    public constant real TOOLTIP_FONT_HEIGHT = 0.009
    public constant real TOOLTIP_Y = 0.007
    public constant string TOOLTIP_FONT = "fonts\\dfst-m3u.ttf"
    
    private boolean array enabledForPlayer
    private trigger CheckboxCheckedTrigger
    private trigger CheckboxUncheckedTrigger
    private framehandle Checkbox
    private framehandle CheckboxTooltip
    private framehandle array SlotFrame
    private framehandle array SlotBackdropFrame
    private framehandle array SlotChargesBackdropFrame
    private framehandle array SlotChargesFrame
    private framehandle array SlotTooltip
    private trigger array SlotClickTrigger
    
    private boolean array checked
    
    private hashtable h = InitHashtable()
    private trigger syncTrigger = CreateTrigger()
    private trigger queueTrigger = CreateTrigger()
endglobals

function IsQueueUIEnabledForPlayer takes player whichPlayer returns boolean
    return enabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

private function SetSlotVisible takes integer i, boolean visible returns nothing
    call BlzFrameSetVisible(SlotFrame[i], visible)
    call BlzFrameSetVisible(SlotBackdropFrame[i], visible)
    call BlzFrameSetVisible(SlotChargesBackdropFrame[i], visible)
    call BlzFrameSetVisible(SlotChargesFrame[i], visible)
    call BlzFrameSetEnable(SlotTooltip[i], visible)
endfunction

private function SetAllSlotChargesVisible takes boolean visible returns nothing
    local integer i = 0
    loop
        exitwhen (i >= MAX_SLOTS)
        call SetSlotVisible(i, visible)
        set i = i + 1
    endloop
endfunction

private function UpdateUIForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local Queue current = GetPlayerQueue(whichPlayer)
    local integer i = 0
    if (Checkbox != null and IsQueueUIEnabledForPlayer(whichPlayer) and not checked[playerId]) then
        //call BJDebugMsg("Update for player " + GetPlayerName(whichPlayer))
        loop
            exitwhen (i >= MAX_SLOTS or current == 0)
            if (whichPlayer == GetLocalPlayer() and BlzFrameIsVisible(Checkbox)) then // has not been manually hidden before
                //call BJDebugMsg("Show slot " + I2S(i))
static if (LIBRARY_QueueUIResearches) then
                call BlzFrameSetTexture(SlotBackdropFrame[i], QueueUIResearches_GetIcon(current.id, whichPlayer), 0, true)
                call BlzFrameSetText(SlotTooltip[i], QueueUIResearches_GetName(current.id, whichPlayer))
else
                call BlzFrameSetTexture(SlotBackdropFrame[i], BlzGetAbilityIcon(current.id), 0, true)
                call BlzFrameSetText(SlotTooltip[i], GetObjectName(current.id))
endif
                call BlzFrameSetText(SlotChargesFrame[i], I2S(current.counter))
                call BlzFrameSetEnable(SlotTooltip[i], true)
                call SetSlotVisible(i, true)
            endif
            
            //call BJDebugMsg("Show slot " + I2S(i) + ": " + BlzGetAbilityIcon(current.id))
            //call BJDebugMsg("UI check " + I2S(current) + " with ID " + GetObjectName(current.id))
            
            set current = current.next
            set i = i + 1
        endloop
    endif
    
    loop
        exitwhen (i >= MAX_SLOTS)
        if (whichPlayer == GetLocalPlayer()) then
            call BlzFrameSetTexture(SlotBackdropFrame[i], "", 0, true)
            call BlzFrameSetEnable(SlotTooltip[i], false)
            call SetSlotVisible(i, false)
        endif
        
        set i = i + 1
    endloop
endfunction

private function ForForceUpdateUI takes nothing returns nothing
    call UpdateUIForPlayer(GetEnumPlayer())
endfunction

private function UpdateUI takes nothing returns nothing
    call ForForce(GetPlayersAll(), function ForForceUpdateUI)
endfunction

private function GetNextUnitToSelect takes group g,player whichPlayer returns unit
    local integer max = BlzGroupGetSize(g)
    local integer i= 0
    local unit u= null
    local unit result= null
    local boolean found = false
    if (max > 0) then
        loop
            exitwhen (i == max)
            set u = BlzGroupUnitAt(g, i)
            if (IsUnitSelected(u, whichPlayer)) then
                set found = true
            elseif (found) then
                set result = u
            endif
            set u = null
            set i = i + 1
        endloop
    
        // this happens if none of them is selected or the last one
        if (result == null) then
            set result = BlzGroupUnitAt(g, 0) // start at first
        endif
    endif
    
    return result
endfunction

private function DistanceBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    local real dx = (x2 - x1)
    local real dy = (y2 - y1)

    return SquareRoot(dx * dx + dy * dy)
endfunction

private function SmartCameraPanToUnit takes player whichPlayer,unit target,real duration returns nothing
    local real dist
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.

        set dist = DistanceBetweenCoordinates(x, y, GetCameraTargetPositionX(), GetCameraTargetPositionY())
        if (dist >= bj_SMARTPAN_TRESHOLD_SNAP) then
            // If the user is too far away, snap the camera.
            call PanCameraToTimed(x, y, 0)
        elseif (dist >= bj_SMARTPAN_TRESHOLD_PAN) then
            // If the user is moderately close, pan the camera.
            call PanCameraToTimed(x, y, duration)
        else
            // User is close enough, so don't touch the camera.
        endif
    endif
endfunction

private function SelectNextSource takes player whichPlayer, integer slot returns nothing
    local Queue q = GetPlayerQueueByIndex(whichPlayer, slot)
    local unit n = null
    if (q != 0) then
        set n = GetNextUnitToSelect(q.sources , whichPlayer)
        
        if (n != null) then
            call SelectUnitForPlayerSingle(n, whichPlayer)
static if (PAN_CAMERA) then
            call SmartCameraPanToUnit(whichPlayer, n, 0.0)
endif
        endif
    endif
endfunction

private function TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer = GetTriggerPlayer()
    local integer playerId = GetPlayerId(whichPlayer)
    local string data = BlzGetTriggerSyncData()
    local integer slot = 0
    if (data == "Checked") then
        set checked[playerId] = true
        if (whichPlayer == GetLocalPlayer()) then
            call BlzFrameSetText(CheckboxTooltip, GetLocalizedString("SHOW_QUEUE_UI"))
        endif
        call UpdateUIForPlayer(whichPlayer)
    elseif (data == "Unchecked") then
        set checked[playerId] = false
        if (whichPlayer == GetLocalPlayer()) then
            call BlzFrameSetText(CheckboxTooltip, GetLocalizedString("HIDE_QUEUE_UI"))
        endif
        call UpdateUIForPlayer(whichPlayer)
    else
        set slot = S2I(data)
        call SelectNextSource(whichPlayer, slot)
    endif
    set whichPlayer = null
endfunction

function ShowQueueUI takes nothing returns nothing
    call BlzFrameSetVisible(Checkbox, true)
    //call BlzFrameSetVisible(CheckboxTooltip, true) // will show the text
    call SetAllSlotChargesVisible(true)
endfunction

function HideQueueUI takes nothing returns nothing
    call BlzFrameSetVisible(Checkbox, false)
    call BlzFrameSetVisible(CheckboxTooltip, false)
    call SetAllSlotChargesVisible(false)
endfunction

function SetQueueUIEnabledForPlayer takes player whichPlayer, boolean enabled returns nothing
    set enabledForPlayer[GetPlayerId(whichPlayer)] = enabled
    if (enabled) then
        if (whichPlayer == GetLocalPlayer()) then
            call ShowQueueUI()
        endif
        call UpdateUIForPlayer(whichPlayer)
    else
        if (whichPlayer == GetLocalPlayer()) then
            call HideQueueUI()
        endif
    endif
endfunction

private function CheckedFunction takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, "Checked")
    endif
endfunction

private function UncheckedFunction takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, "Unchecked")
    endif
endfunction

private function ClickItemFunction takes nothing returns nothing
    local integer handleId = GetHandleId(GetTriggeringTrigger())
    local integer slot = LoadInteger(h, handleId, 0)
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, I2S(slot))
    endif
endfunction

private function CreateUI takes nothing returns nothing
    local integer i = 0
    local integer handleId = 0
    local real x = 0.0
    local real y = 0.0

    set x = CHECK_BOX_X
    set y = CHECK_BOX_Y
    
    set Checkbox = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_BOTTOMRIGHT, x + CHECK_BOX_SIZE, y - CHECK_BOX_SIZE)
    
    set CheckboxTooltip = BlzCreateFrameByType("TEXT", "QueueUICheckboxTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(Checkbox, CheckboxTooltip)
    call BlzFrameSetPoint(CheckboxTooltip, FRAMEPOINT_BOTTOM, Checkbox, FRAMEPOINT_TOP, 0, TOOLTIP_Y)
    call BlzFrameSetFont(CheckboxTooltip, TOOLTIP_FONT, TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetText(CheckboxTooltip, GetLocalizedString("HIDE_QUEUE_UI"))
    
    set CheckboxCheckedTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxCheckedTrigger, Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(CheckboxCheckedTrigger, function CheckedFunction)
    
    set CheckboxUncheckedTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxUncheckedTrigger, Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(CheckboxUncheckedTrigger, function UncheckedFunction)
    
    set x = BUTTON_X
    set y = BUTTON_Y
    set i = 0
    loop
        exitwhen (i == MAX_SLOTS)
        set SlotFrame[i] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetAbsPoint(SlotFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(SlotFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + BUTTON_SIZE, y - BUTTON_SIZE)
        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(0), 0, true)
        //call BlzFrameSetText(SlotFrame[index], I2S(index))

        set SlotBackdropFrame[i] = BlzCreateFrameByType("BACKDROP", "QueueUIBackdropFrame" + I2S(i), SlotFrame[i], "", 1)
        call BlzFrameSetAllPoints(SlotBackdropFrame[i], SlotFrame[i])
//             call BlzFrameSetTexture(SlotBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)

        // TODO Set Tooltip frame for the object name
        
        set SlotChargesBackdropFrame[i] = BlzCreateFrameByType("BACKDROP", "QueueUIChargesBackdropFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(SlotChargesBackdropFrame[i], FRAMEPOINT_TOPLEFT, x + BUTTON_SIZE - CHARGES_SIZE, y - BUTTON_SIZE + CHARGES_SIZE)
        call BlzFrameSetAbsPoint(SlotChargesBackdropFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + BUTTON_SIZE, y - BUTTON_SIZE)
        call BlzFrameSetTexture(SlotChargesBackdropFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(SlotChargesBackdropFrame[i], 1)

        set SlotChargesFrame[i] = BlzCreateFrameByType("TEXT", "QueueUIChargesFrame" + I2S(i), SlotChargesBackdropFrame[i], "", 0)
        call BlzFrameSetAllPoints(SlotChargesFrame[i], SlotChargesBackdropFrame[i])
        call BlzFrameSetTextAlignment(SlotChargesFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(SlotChargesFrame[i], 0.7)
        call BlzFrameSetEnable(SlotChargesFrame[i], false)
        call BlzFrameSetLevel(SlotChargesFrame[i], 2)

        set SlotClickTrigger[i] = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(SlotClickTrigger[i], SlotFrame[i], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(SlotClickTrigger[i], function ClickItemFunction)
        set handleId = GetHandleId(SlotClickTrigger[i])
        call SaveInteger(h, handleId, 0, i)
        
        set SlotTooltip[i] = BlzCreateFrameByType("TEXT", "QueueUITooltip" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetTooltip(SlotFrame[i], SlotTooltip[i])
        call BlzFrameSetPoint(SlotTooltip[i], FRAMEPOINT_BOTTOM, SlotFrame[i], FRAMEPOINT_TOP, 0, TOOLTIP_Y)
        call BlzFrameSetFont(SlotTooltip[i], TOOLTIP_FONT, TOOLTIP_FONT_HEIGHT, 0)
        call BlzFrameSetEnable(SlotTooltip[i], false)

        set x = x + BUTTON_SIZE + BUTTON_SPACE

        set i = i + 1
    endloop

    call UpdateUI()
endfunction

private function TriggerActionUpdateQueue takes nothing returns nothing
    //call BJDebugMsg("Queue update " + GetObjectName(GetTriggerQueueId()))
    call UpdateUIForPlayer(GetOwningPlayer(GetTriggerQueueUnit()))
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER) then
            set enabledForPlayer[i] = true
            call BlzTriggerRegisterPlayerSyncEvent(syncTrigger, slotPlayer, PREFIX, false)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(syncTrigger, function TriggerActionSyncData)
    
    call TriggerRegisterQueueEvent(queueTrigger)
    call TriggerAddAction(queueTrigger, function TriggerActionUpdateQueue)
    
static if (LOAD_TOC_FILE) then
    call BlzLoadTOCFile(TOC_FILE)
endif

    call OnStartGame(function CreateUI)
    
static if (LIBRARY_FrameLoader) then
    call FrameLoaderAdd(function CreateUI)
endif
endfunction

endlibrary
