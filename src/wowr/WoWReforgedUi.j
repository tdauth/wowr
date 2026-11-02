library WoWReforgedUi initializer Init requires PlayerUtils, StringUtils

globals
    private hashtable h = InitHashtable()
endglobals

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

// TODO Allow creating picker buttons in UIs to choose player colors, heroes, start locations, professions and races
struct UiPickerButton
    private framehandle upButton
    private framehandle upFrame
    private trigger upTrigger
    private framehandle downButton
    private framehandle downFrame
    private trigger downTrigger

    private static method triggerActionPickerUp takes nothing returns nothing
    endmethod

    private static method triggerActionPickerDown takes nothing returns nothing
    endmethod

    public static method create takes string name, real x, real y, real width, real height returns thistype
        local thistype this = thistype.allocate()

        set this.upButton = BlzCreateFrameByType("BUTTON", name + "UpButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetAbsPoint(this.upButton, FRAMEPOINT_TOPLEFT, x, y - height)
        call BlzFrameSetAbsPoint(this.upButton, FRAMEPOINT_BOTTOMRIGHT, x + width, y - height)
        call BlzFrameSetEnable(this.upButton, true)

        set this.upFrame = BlzCreateFrameByType("BACKDROP", name + "UpFrame", this.upButton, "", 0)
        call BlzFrameSetAllPoints(this.upFrame, this.upButton)
        call BlzFrameSetTexture(this.upFrame, GetIconUp(), 0, true)
        call BlzFrameSetEnable(this.upFrame, true)

        set this.upTrigger = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(this.upTrigger, this.upButton, FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(this.upTrigger, function thistype.triggerActionPickerUp)
        call SaveInteger(h, GetHandleId(this.upTrigger), 0, this)

        set this.downButton = BlzCreateFrameByType("BUTTON", name + "DownButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetAbsPoint(this.downButton, FRAMEPOINT_TOPLEFT, x, y - height)
        call BlzFrameSetAbsPoint(this.downButton, FRAMEPOINT_BOTTOMRIGHT, x + width, y - height)
        call BlzFrameSetEnable(this.downButton, true)

        set this.downFrame = BlzCreateFrameByType("BACKDROP", name + "DownFrame", this.downButton, "", 0)
        call BlzFrameSetAllPoints(this.downFrame, this.downButton)
        call BlzFrameSetTexture(this.downFrame, GetIconDown(), 0, true)
        call BlzFrameSetEnable(this.downFrame, true)

        set this.downTrigger = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(this.downTrigger, this.downButton, FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(this.downTrigger, function thistype.triggerActionPickerDown)
        call SaveInteger(h, GetHandleId(this.downTrigger), 0, this)

        return this
    endmethod

endstruct

struct UiPickerEntries
    private string array labels[200]
    private string array icons[200]
    private integer size = 0

    public method addEntry takes string label, string icon returns nothing
        local integer index = this.size
        set this.labels[index] = label
        set this.icons[index] = icon
        set this.size = this.size + 1
    endmethod

    public method getEntryLabel takes integer index returns string
        return labels[index]
    endmethod

    public method getEntryIcon takes integer index returns string
        return icons[index]
    endmethod

    public method getSize takes nothing returns integer
        return size
    endmethod
endstruct

struct UiPicker
    private UiPickerEntries entries
    private framehandle icon
    private framehandle label
    private UiPickerButton pickerButton

    public static method create takes string name, real x, real y, real width, real height, UiPickerEntries entries returns thistype
        local thistype this = thistype.allocate()
        set this.entries = entries

        set this.icon = BlzCreateFrameByType("BACKDROP", name + "Icon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(this.icon, FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(this.icon, FRAMEPOINT_BOTTOMRIGHT, x + width, y - height)
        call BlzFrameSetTexture(this.icon, "", 0, true)
        call BlzFrameSetEnable(this.icon, true)

        set this.label = BlzCreateFrameByType("TEXT", name + "Label", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(this.label, FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(this.label, FRAMEPOINT_BOTTOMRIGHT, x + width, y - height)
        call BlzFrameSetText(this.label, "")
        call BlzFrameSetTextAlignment(this.label, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

        set this.pickerButton = UiPickerButton.create(name, x, y, 0.02, 0.04)

        return this
    endmethod
endstruct

private function Init takes nothing returns nothing
    call BlzLoadTOCFile("wowr\\wowrTOC.toc")
endfunction

endlibrary
