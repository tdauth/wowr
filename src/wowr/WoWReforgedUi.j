library WoWReforgedUi initializer Init requires PlayerUtils, StringUtils

function CreateFullScreenFrame takes nothing returns framehandle
    local framehandle f = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_Y - UI_FULLSCREEN_HEIGHT)
    return f
endfunction

function CreateFullScreenTitle takes string name, string text returns framehandle
    local framehandle f = BlzCreateFrameByType("TEXT", name, BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_X, UI_FULLSCREEN_TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_X + UI_FULLSCREEN_WIDTH, UI_FULLSCREEN_TITLE_Y - UI_FULLSCREEN_TITLE_HEIGHT)
    call BlzFrameSetText(f, text)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    return f
endfunction

function CreateFullScreenCloseButton takes nothing returns framehandle
    local framehandle f = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_CLOSE_BUTTON_X, UI_FULLSCREEN_BOTTOM_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_CLOSE_BUTTON_X + UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH, UI_FULLSCREEN_BOTTOM_BUTTON_Y - UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT)
    call BlzFrameSetText(f, GetLocalizedString("CLOSE_YELLOW"))
    return f
endfunction

function CreateFullScreenNextPageButton takes framehandle p, string text returns framehandle
    local framehandle f = BlzCreateFrame("ScriptDialogButton", p, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_NEXT_PAGE_BUTTON_X, UI_FULLSCREEN_BOTTOM_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_NEXT_PAGE_BUTTON_X + UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH, UI_FULLSCREEN_BOTTOM_BUTTON_Y - UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT)
    call BlzFrameSetText(f, text)
    return f
endfunction

function CreateFullScreenPreviousPageButton takes framehandle p, string text returns framehandle
    local framehandle f = BlzCreateFrame("ScriptDialogButton", p, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, UI_FULLSCREEN_PREVIOUS_PAGE_BUTTON_X, UI_FULLSCREEN_BOTTOM_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, UI_FULLSCREEN_PREVIOUS_PAGE_BUTTON_X + UI_FULLSCREEN_BOTTOM_BUTTON_WIDTH, UI_FULLSCREEN_BOTTOM_BUTTON_Y - UI_FULLSCREEN_BOTTOM_BUTTON_HEIGHT)
    call BlzFrameSetText(f, text)
    return f
endfunction

// TODO Make the icon depending on the race?
function GetIconUp takes nothing returns string
    return UI_ICON_UP
endfunction

function GetIconDown takes nothing returns string
    return UI_ICON_DOWN
endfunction

function PlayClickSound takes player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call StartSound(gg_snd_BigButtonClick)
    endif
endfunction

function SetTextAreaText takes framehandle f, string text returns nothing
    local string t = null
    local integer i = 0
    call BlzFrameSetText(f, "")
    loop
        set t = StringSplit(text, i, "|n")
        exitwhen (t == null)
        if (StringLength(t) == 0) then
            set t = " " // empty line
        endif
        call BlzFrameAddText(f, t)
        set i = i + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    call BlzLoadTOCFile("wowr\\wowrTOC.toc")
endfunction

endlibrary
