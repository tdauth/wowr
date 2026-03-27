library LogUI initializer Init requires Log, OnStartGame, optional FrameLoader

globals
    public constant boolean CHAT_COMMAND_ENABLE = true
    public constant string CHAT_COMMAND_SHORT = "-l"
    public constant string CHAT_COMMAND = "-log"
    
    public constant boolean UPPER_BUTTON_OVERWRITE = false
    
    public constant boolean LOAD_TOC_FILE = false
    public constant string TOC_FILE = "war3mapImported\\LogTOC.toc"

    public constant real FULLSCREEN_HEIGHT = 0.6
    public constant real FULLSCREEN_WIDTH = 0.8

    // UI/FrameDef/UI/LogDialog.fdf
    public constant real WIDTH = 0.384
    public constant real HEIGHT = 0.432
    public constant real X = FULLSCREEN_WIDTH / 2.0 - (WIDTH / 2.0)
    public constant real Y = FULLSCREEN_HEIGHT - 0.0335
    public constant real TITLE_X = X
    public constant real TITLE_Y = Y - 0.028
    public constant real TITLE_HEIGHT = 0.015
    
    public constant real TEXT_AREA_SPACE = 0.02
    public constant real TEXT_AREA_X = X + TEXT_AREA_SPACE
    public constant real TEXT_AREA_Y = TITLE_Y - TITLE_HEIGHT - TEXT_AREA_SPACE
    public constant real TEXT_AREA_WIDTH = WIDTH - 2.0 * TEXT_AREA_SPACE
    public constant real TEXT_AREA_HEIGHT = 0.29
    
    public constant real CLOSE_BUTTON_WIDTH = 0.13
    public constant real CLOSE_BUTTON_HEIGHT = 0.035
    public constant real CLOSE_BUTTON_X = FULLSCREEN_WIDTH / 2.0 - (CLOSE_BUTTON_WIDTH / 2.0)
    public constant real CLOSE_BUTTON_Y = TEXT_AREA_Y - TEXT_AREA_HEIGHT - TEXT_AREA_SPACE
    
    private framehandle BackgroundFrame = null
    private framehandle TextAreaFrame = null
    
    private trigger closeTrigger = null
    private trigger clickUpperButtonTrigger = null
    private trigger upperButtonHotkeyTrigger = null
    private trigger chatCommandTrigger = CreateTrigger()
    private trigger logTrigger = CreateTrigger()
    
    private sound logSound = CreateSound("Sound\\Interface\\BigButtonClick", false, false, true, 12700, 12700, "")
endglobals

function EnableLogUI takes nothing returns nothing
    call EnableTrigger(closeTrigger)
    call EnableTrigger(chatCommandTrigger)
    call EnableTrigger(logTrigger)
endfunction

function DisableLogUI takes nothing returns nothing
    call DisableTrigger(closeTrigger)
    call DisableTrigger(chatCommandTrigger)
    call DisableTrigger(logTrigger)
endfunction

function UpdateLogUIVisible takes nothing returns nothing
    local integer max = GetLogCounter(GetLocalPlayer())
    local integer i = 0
    call BlzFrameSetText(TextAreaFrame, "")
    loop
        exitwhen (i == max)
        call BlzFrameAddText(TextAreaFrame, GetLogEntry(GetLocalPlayer(), i))
        set i = i + 1
    endloop
endfunction

function SetLogUIVisible takes boolean visible returns nothing
    if (visible) then
        call UpdateLogUIVisible()
    endif
    call BlzFrameSetVisible(BackgroundFrame, visible)
endfunction

function ShowLogUI takes nothing returns nothing
    call SetLogUIVisible(true)
endfunction

function HideLogUI takes nothing returns nothing
    call SetLogUIVisible(false)
endfunction

function SetLogUIVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
     if (whichPlayer == GetLocalPlayer()) then
        call SetLogUIVisible(visible)
    endif
endfunction

function ShowLogUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetLogUIVisible(true)
    endif
endfunction

function HideLogUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetLogUIVisible(false)
    endif
endfunction 

private function CloseFunction takes nothing returns nothing
    call HideLogUIForPlayer(GetTriggerPlayer())
endfunction

private function ClickUpperButtonFunction takes nothing returns nothing
    call ForceUIKeyBJ(GetTriggerPlayer(), "F12")
    call ShowLogUIForPlayer(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call StartSound(logSound)
    endif
endfunction

private function CreateUpperButtonUI takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    if (clickUpperButtonTrigger != null) then
        call DestroyTrigger(clickUpperButtonTrigger)
    endif
    set clickUpperButtonTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(clickUpperButtonTrigger, BlzGetFrameByName("UpperButtonBarChatButton", 0), FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(clickUpperButtonTrigger, function ClickUpperButtonFunction)
    
    if (upperButtonHotkeyTrigger != null) then
        call DestroyTrigger(upperButtonHotkeyTrigger)
    endif
    set upperButtonHotkeyTrigger = CreateTrigger()
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call BlzTriggerRegisterPlayerKeyEvent(upperButtonHotkeyTrigger, slotPlayer, OSKEY_F12, 0, true)
        endif
        set i = i + 1
    endloop
    call TriggerAddAction(upperButtonHotkeyTrigger, function ClickUpperButtonFunction)
endfunction

private function CreateUI takes nothing returns nothing
    local framehandle f = null
    
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(BackgroundFrame, 1)

    set f = BlzCreateFrame("EscMenuTitleTextTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TITLE_X, TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TITLE_X + WIDTH, TITLE_Y - TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetText(f, GetLocalizedString("MESSAGE_LOG"))
    
    set TextAreaFrame = BlzCreateFrame("EscMenuTextAreaTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_TOPLEFT, TEXT_AREA_X, TEXT_AREA_Y)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_BOTTOMRIGHT, TEXT_AREA_X + TEXT_AREA_WIDTH, TEXT_AREA_Y - TEXT_AREA_HEIGHT)
    call BlzFrameSetFont(TextAreaFrame, "MasterFont", 0.011, 0)

    set f = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, CLOSE_BUTTON_X, CLOSE_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, CLOSE_BUTTON_X + CLOSE_BUTTON_WIDTH, CLOSE_BUTTON_Y - CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(f, "|cffffcc00" + GetLocalizedString("OK") + "|r")

    if (closeTrigger != null) then
        call DestroyTrigger(closeTrigger)
    endif
    set closeTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(closeTrigger, f, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(closeTrigger, function CloseFunction)

static if (UPPER_BUTTON_OVERWRITE) then
    call CreateUpperButtonUI()
endif

    call HideLogUI()
endfunction

private function TriggerActionShowLogUI takes nothing returns nothing
    call ShowLogUIForPlayer(GetTriggerPlayer())
endfunction

private function TriggerActionLog takes nothing returns nothing
    if (GetTriggerLogPlayer() == GetLocalPlayer()) then
        if (BlzFrameIsVisible(BackgroundFrame)) then
            call UpdateLogUIVisible()
        endif
    endif
endfunction

private function Start takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
static if (CHAT_COMMAND_ENABLE) then
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            if (StringLength(CHAT_COMMAND_SHORT) > 0) then
                call TriggerRegisterPlayerChatEvent(chatCommandTrigger, slotPlayer, CHAT_COMMAND_SHORT, true)
            endif
            if (StringLength(CHAT_COMMAND) > 0) then
                call TriggerRegisterPlayerChatEvent(chatCommandTrigger, slotPlayer, CHAT_COMMAND, true)
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(chatCommandTrigger, function TriggerActionShowLogUI)
endif

    call TriggerRegisterLogEvent(logTrigger)
    call TriggerAddAction(logTrigger, function TriggerActionLog)

static if (LOAD_TOC_FILE) then
    call BlzLoadTOCFile(TOC_FILE)
endif
    
    call CreateUI()
endfunction

private function Init takes nothing returns nothing
    call OnStartGame(function Start)
    // Prevents crashes on loading save games:
static if (LIBRARY_FrameLoader) then
    call FrameLoaderAdd(function CreateUI)
endif
endfunction

endlibrary
