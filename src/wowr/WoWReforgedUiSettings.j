library WoWReforgedUiSettings initializer Init requires OnStartGame, optional FrameLoader, StringUtils, WoWReforgedUi, WoWReforgedMapData, WoWReforgedUtils, WoWReforgedCalendar

globals
    public constant string CHAT_COMMAND_SHORT = "-st"
    public constant string CHAT_COMMAND = "-settings"
    
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
    
    public constant real TEXT_AREA_BORDER_SPACE = 0.03
    public constant real VERTICAL_SPACE = 0.01
  
    public constant real TEXT_AREA_X = X + TEXT_AREA_BORDER_SPACE
    public constant real TEXT_AREA_Y = TITLE_Y - TITLE_HEIGHT - VERTICAL_SPACE
    public constant real TEXT_AREA_WIDTH = WIDTH - 2.0 * TEXT_AREA_BORDER_SPACE
    public constant real TEXT_AREA_HEIGHT = 0.31

    public constant real CLOSE_BUTTON_WIDTH = 0.13
    public constant real CLOSE_BUTTON_HEIGHT = 0.035
    public constant real CLOSE_BUTTON_X = FULLSCREEN_WIDTH / 2.0 - (CLOSE_BUTTON_WIDTH / 2.0)
    public constant real CLOSE_BUTTON_Y = TEXT_AREA_Y - TEXT_AREA_HEIGHT - VERTICAL_SPACE
    
    private framehandle BackgroundFrame
    
    private framehandle TextAreaFrame
    
    private trigger closeTrigger = null
    private trigger chatCommandTrigger = CreateTrigger()
endglobals

function EnableSettingsUI takes nothing returns nothing
    call EnableTrigger(closeTrigger)
    call EnableTrigger(chatCommandTrigger)
endfunction

function DisableSettingsUI takes nothing returns nothing
    call DisableTrigger(closeTrigger)
    call DisableTrigger(chatCommandTrigger)
endfunction

function SetSettingsUIVisible takes boolean visible returns nothing
    if (visible) then
        // update
        call BlzFrameSetText(TextAreaFrame, "")
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_MAP_NAME")).s(GetExternalString(1)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_MAP_VERSION")).s(MAP_VERSION).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_MAP_DESCRIPTION")).s(GetExternalString(3)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_MAP_DIMENSIONS")).i(R2I(GetRectWidthBJ(GetPlayableMapRect()) / bj_CELLWIDTH)).i(R2I(GetRectHeightBJ(GetPlayableMapRect()) / bj_CELLWIDTH)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_PLAYERS")).i(GetPlayers()).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_TEAMS")).i(2).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_SINGLEPLAYER")).s(B2Option(IsInSinglePlayer())).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_SAVE_CODES")).s(B2Option(udg_SaveAndLoadEnabled)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_TOMES")).s(B2Option(udg_Tomes)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_CINEMATICS")).s(B2Option(udg_Cinematics)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_AI_RESPAWN")).s(B2Option(udg_AIRespawn)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_SEASONS")).s(B2Option(IsSeasonsEnabled())).result())
        call AddMapSettings(TextAreaFrame)
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_CHEATS")).s(B2Option(udg_Cheats)).result())
        call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("SETTINGS_BUILDER")).s(B2Option(udg_Builder != null)).result())
    endif
    call BlzFrameSetVisible(BackgroundFrame, visible)
endfunction

function ShowSettingsUI takes nothing returns nothing
    call SetSettingsUIVisible(true)
endfunction

function HideSettingsUI takes nothing returns nothing
    call SetSettingsUIVisible(false)
endfunction

function SetSettingsUIVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
     if (whichPlayer == GetLocalPlayer()) then
        call SetSettingsUIVisible(visible)
    endif
endfunction

function ShowSettingsUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetSettingsUIVisible(true)
    endif
endfunction

function HideSettingsUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetSettingsUIVisible(false)
    endif
endfunction 

private function CloseFunction takes nothing returns nothing
    call HideSettingsUIForPlayer(GetTriggerPlayer())
endfunction

private function CreateUI takes nothing returns nothing
    local framehandle f = null
    
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(BackgroundFrame, 1)

    set f = BlzCreateFrame("EscMenuTitleTextTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TITLE_X, TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TITLE_X + WIDTH, TITLE_Y - TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetText(f, GetLocalizedString("SETTINGS"))
    
    set TextAreaFrame = BlzCreateFrame("EscMenuTextAreaTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_TOPLEFT, TEXT_AREA_X, TEXT_AREA_Y)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_BOTTOMRIGHT, TEXT_AREA_X + TEXT_AREA_WIDTH, TEXT_AREA_Y - TEXT_AREA_HEIGHT)
    call BlzFrameSetFont(TextAreaFrame, "MasterFont", 0.011, 0)

    set f = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, CLOSE_BUTTON_X, CLOSE_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, CLOSE_BUTTON_X + CLOSE_BUTTON_WIDTH, CLOSE_BUTTON_Y - CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(f, GetLocalizedString("OK_YELLOW"))

    if (closeTrigger != null) then
        call DestroyTrigger(closeTrigger)
    endif
    set closeTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(closeTrigger, f, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(closeTrigger, function CloseFunction)

    call HideSettingsUI()
endfunction

private function TriggerActionShowSettingsUI takes nothing returns nothing
    call ShowSettingsUIForPlayer(GetTriggerPlayer())
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
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
    call TriggerAddAction(chatCommandTrigger, function TriggerActionShowSettingsUI)

    call OnStartGame(function CreateUI)
    // Prevents crashes on loading save games:
static if (LIBRARY_FrameLoader) then
    call FrameLoaderAdd(function CreateUI)
endif
endfunction

endlibrary
