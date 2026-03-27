library WoWReforgedUiUrl initializer Init requires OnStartGame, FrameLoader, WoWReforgedUi

globals
    private constant real X = 0.26
    private constant real Y = 0.45
    private constant real UI_SIZE_X = 0.55
    private constant real UI_SIZE_Y = 0.15
    private constant real UI_TITLE_Y = 0.42
    private constant real UI_TITLE_HEIGHT = 0.1
    private constant real UI_LINEEDIT_X = 0.31
    private constant real UI_LINEEDIT_Y = 0.40
    private constant real UI_LINEEDIT_WIDTH = 0.2
    private constant real UI_LINE_START_Y = 0.528122
    private constant real UI_LINE_HEIGHT = 0.03
    private constant real UI_CLOSE_BUTTON_X = 0.35
    private constant real UI_CLOSE_BUTTON_Y = 0.36
    private constant real UI_CLOSE_BUTTON_WIDTH = 0.12
    private constant real UI_CLOSE_BUTTON_HEIGHT = 0.03

    private framehandle BackgroundFrame
    private framehandle TitleFrame
    private framehandle EditBox
    private framehandle CloseButton
    private trigger CloseTrigger
endglobals

function SetUrlUiVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(BackgroundFrame, visible)
    call BlzFrameSetVisible(TitleFrame, visible)
    call BlzFrameSetVisible(EditBox, visible)
    call BlzFrameSetVisible(CloseButton, visible)
endfunction

function HideUrlUi takes nothing returns nothing
    call SetUrlUiVisible(false)
endfunction

function SetUrlUiVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetUrlUiVisible(visible)
    endif
endfunction

function ShowUrlUi takes player whichPlayer, string title, string text returns nothing
    call SetUrlUiVisibleForPlayer(whichPlayer, true)
    
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetText(TitleFrame, title)
        call BlzFrameSetText(EditBox, text)
    endif
endfunction

function ShowDiscordUI takes player whichPlayer returns nothing
    call ShowUrlUi(whichPlayer, "Discord", URL_DISCORD)
endfunction

function ShowWebsiteUI takes player whichPlayer returns nothing
    call ShowUrlUi(whichPlayer, "Website", URL_WEBSITE)
endfunction

function ShowDownloadUI takes player whichPlayer returns nothing
    call ShowUrlUi(whichPlayer, "Download", URL_DOWNLOAD)
endfunction

function HideUrlUiForPlayer takes player whichPlayer returns nothing
    call SetUrlUiVisibleForPlayer(whichPlayer, false)
endfunction

private function CloseFunction takes nothing returns nothing
    //call BJDebugMsg("Click close")
    call HideUrlUiForPlayer(GetTriggerPlayer())
endfunction

private function CreateUrlUi takes nothing returns nothing
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, UI_SIZE_X, Y - UI_SIZE_Y)

    set TitleFrame = BlzCreateFrameByType("TEXT", "DiscordGuiTitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_TOPLEFT, X, UI_TITLE_Y)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_BOTTOMRIGHT, UI_SIZE_X, UI_TITLE_Y - UI_TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(TitleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(TitleFrame, 1.0)
    call BlzFrameSetVisible(TitleFrame, false)

    set EditBox = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBox, FRAMEPOINT_TOPLEFT, UI_LINEEDIT_X, UI_LINEEDIT_Y)
    call BlzFrameSetAbsPoint(EditBox, FRAMEPOINT_BOTTOMRIGHT, UI_LINEEDIT_X + UI_LINEEDIT_WIDTH, UI_LINEEDIT_Y - UI_LINE_HEIGHT)
    call BlzFrameSetEnable(EditBox, true)
    
    set CloseButton = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(CloseButton, FRAMEPOINT_TOPLEFT, UI_CLOSE_BUTTON_X, UI_CLOSE_BUTTON_Y)
    call BlzFrameSetAbsPoint(CloseButton, FRAMEPOINT_BOTTOMRIGHT, UI_CLOSE_BUTTON_X + UI_CLOSE_BUTTON_WIDTH, UI_CLOSE_BUTTON_Y - UI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(CloseButton, GetLocalizedString("CLOSE_YELLOW"))
    call BlzFrameSetScale(CloseButton, 1.00)

    set CloseTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CloseTrigger, CloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(CloseTrigger, function CloseFunction)

    // hide for all players
    call SetUrlUiVisible(false)
endfunction

private function Init takes nothing returns nothing
    call OnStartGame(function CreateUrlUi)

    call FrameLoaderAdd(function CreateUrlUi)

static if (LIBRARY_FrameSaver) then
    //call FrameSaverAdd(function HideUrlUi)
endif
endfunction

endlibrary
