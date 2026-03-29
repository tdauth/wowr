library WoWReforgedUiNews initializer Init requires OnStartGame, optional FrameLoader, WoWReforgedUi, WoWReforgedChangeLog

/*
Important information:
- URL and QR Code to subscribe (VIP).
- URL and QR Code donate.
- URL and QR code to Discord.
- URL and QR Code to website.
*/

globals
    public constant string CHAT_COMMAND_SHORT = "-q"
    public constant string CHAT_COMMAND = "-news"
    
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
    
    public constant real LABEL_X = X + TEXT_AREA_BORDER_SPACE
    public constant real LABEL_WIDTH = 0.046
    public constant real LABEL_HEIGHT = 0.03
    
    public constant real URL_X = LABEL_X + LABEL_WIDTH + VERTICAL_SPACE
    public constant real URL_WIDTH = 0.2
    
    public constant real SUBSCRIBE_Y = TITLE_Y - TITLE_HEIGHT - VERTICAL_SPACE
    
    public constant real DONATE_Y = SUBSCRIBE_Y - LABEL_HEIGHT - VERTICAL_SPACE
    
    public constant real DISCORD_Y = DONATE_Y - LABEL_HEIGHT - VERTICAL_SPACE
    
    public constant real WEBSITE_Y = DISCORD_Y - LABEL_HEIGHT - VERTICAL_SPACE
    
    public constant real QR_CODE_X = URL_X + URL_WIDTH + VERTICAL_SPACE
    
    public constant real TEXT_AREA_X = X + TEXT_AREA_BORDER_SPACE
    public constant real TEXT_AREA_Y = WEBSITE_Y - LABEL_HEIGHT - VERTICAL_SPACE
    public constant real TEXT_AREA_WIDTH = WIDTH - 2.0 * TEXT_AREA_BORDER_SPACE
    public constant real TEXT_AREA_HEIGHT = 0.15

    public constant real CLOSE_BUTTON_WIDTH = 0.13
    public constant real CLOSE_BUTTON_HEIGHT = 0.035
    public constant real CLOSE_BUTTON_X = FULLSCREEN_WIDTH / 2.0 - (CLOSE_BUTTON_WIDTH / 2.0)
    public constant real CLOSE_BUTTON_Y = TEXT_AREA_Y - TEXT_AREA_HEIGHT - VERTICAL_SPACE
    
    private framehandle BackgroundFrame
    
    private framehandle labelSubscribe
    private framehandle urlSubscribe
    private framehandle qrCodeSubscribe
    
    private framehandle labelDonate
    private framehandle urlDonate
    private framehandle qrCodeDonate
    
    private framehandle labelDiscord
    private framehandle urlDiscord
    private framehandle qrCodeDiscord
    
    private framehandle labelWebsite
    private framehandle urlWebsite
    private framehandle qrCodeWebsite
    
    private framehandle TextAreaFrame
    
    private trigger closeTrigger = null
    private trigger chatCommandTrigger = CreateTrigger()
endglobals

function EnableNewsUI takes nothing returns nothing
    call EnableTrigger(closeTrigger)
    call EnableTrigger(chatCommandTrigger)
endfunction

function DisableNewsUI takes nothing returns nothing
    call DisableTrigger(closeTrigger)
    call DisableTrigger(chatCommandTrigger)
endfunction

function SetNewsUIVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(BackgroundFrame, visible)
endfunction

function ShowNewsUI takes nothing returns nothing
    call SetNewsUIVisible(true)
endfunction

function HideNewsUI takes nothing returns nothing
    call SetNewsUIVisible(false)
endfunction

function SetNewsUIVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
     if (whichPlayer == GetLocalPlayer()) then
        call SetNewsUIVisible(visible)
    endif
endfunction

function ShowNewsUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetNewsUIVisible(true)
    endif
endfunction

function HideNewsUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetNewsUIVisible(false)
    endif
endfunction 

private function CloseFunction takes nothing returns nothing
    call HideNewsUIForPlayer(GetTriggerPlayer())
endfunction

private function CreateUI takes nothing returns nothing
    local framehandle f = null
    local integer i = 0
    local integer max = 0
    
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(BackgroundFrame, 1)

    set f = BlzCreateFrame("EscMenuTitleTextTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TITLE_X, TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TITLE_X + WIDTH, TITLE_Y - TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetText(f, GetLocalizedString("NEWS")) // News
    
    // Subscribe
    set labelSubscribe = BlzCreateFrameByType("TEXT", "LabelSubscribe", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(labelSubscribe, FRAMEPOINT_TOPLEFT, LABEL_X, SUBSCRIBE_Y)
    call BlzFrameSetAbsPoint(labelSubscribe, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, SUBSCRIBE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(labelSubscribe, GetLocalizedString("COLON_SUBSCRIBE_VIP")) // Subscribe (VIP):
    call BlzFrameSetTextAlignment(labelSubscribe, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    
    set urlSubscribe = BlzCreateFrame("EscMenuEditBoxTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(urlSubscribe, FRAMEPOINT_TOPLEFT, URL_X, SUBSCRIBE_Y)
    call BlzFrameSetAbsPoint(urlSubscribe, FRAMEPOINT_BOTTOMRIGHT, URL_X + URL_WIDTH, SUBSCRIBE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(urlSubscribe, URL_SUBSCRIBE)
    
    set qrCodeSubscribe = BlzCreateFrameByType("BACKDROP", "QrCodeSubscribe", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(qrCodeSubscribe, FRAMEPOINT_TOPLEFT, QR_CODE_X, SUBSCRIBE_Y)
    call BlzFrameSetAbsPoint(qrCodeSubscribe, FRAMEPOINT_BOTTOMRIGHT, QR_CODE_X + LABEL_HEIGHT, SUBSCRIBE_Y - LABEL_HEIGHT)
    call BlzFrameSetTexture(qrCodeSubscribe, QR_CODE_SUBSCRIBE, 0, true)
    call BlzFrameSetLevel(qrCodeSubscribe, 2)
    
    // Donate
    set labelDonate = BlzCreateFrameByType("TEXT", "LabelDonate", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(labelDonate, FRAMEPOINT_TOPLEFT, LABEL_X, DONATE_Y)
    call BlzFrameSetAbsPoint(labelDonate, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, DONATE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(labelDonate, GetLocalizedString("COLON_DONATE")) // Donate:
    call BlzFrameSetTextAlignment(labelDonate, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    
    set urlDonate = BlzCreateFrame("EscMenuEditBoxTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(urlDonate, FRAMEPOINT_TOPLEFT, URL_X, DONATE_Y)
    call BlzFrameSetAbsPoint(urlDonate, FRAMEPOINT_BOTTOMRIGHT, URL_X + URL_WIDTH, DONATE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(urlDonate, URL_DONATE)
    
    set qrCodeDonate = BlzCreateFrameByType("BACKDROP", "QrCodeDonate", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(qrCodeDonate, FRAMEPOINT_TOPLEFT, QR_CODE_X, DONATE_Y)
    call BlzFrameSetAbsPoint(qrCodeDonate, FRAMEPOINT_BOTTOMRIGHT, QR_CODE_X + LABEL_HEIGHT, DONATE_Y - LABEL_HEIGHT)
    call BlzFrameSetTexture(qrCodeDonate, QR_CODE_DONATE, 0, true)
    call BlzFrameSetLevel(qrCodeDonate, 2)
    
    // Discord
    set labelDiscord = BlzCreateFrameByType("TEXT", "LabelDonate", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(labelDiscord, FRAMEPOINT_TOPLEFT, LABEL_X, DISCORD_Y)
    call BlzFrameSetAbsPoint(labelDiscord, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, DISCORD_Y - LABEL_HEIGHT)
    call BlzFrameSetText(labelDiscord, GetLocalizedString("COLON_DISCORD")) // Discord:
    call BlzFrameSetTextAlignment(labelDiscord, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    
    set urlDiscord = BlzCreateFrame("EscMenuEditBoxTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(urlDiscord, FRAMEPOINT_TOPLEFT, URL_X, DISCORD_Y)
    call BlzFrameSetAbsPoint(urlDiscord, FRAMEPOINT_BOTTOMRIGHT, URL_X + URL_WIDTH, DISCORD_Y - LABEL_HEIGHT)
    call BlzFrameSetText(urlDiscord, URL_DISCORD)
    
    set qrCodeDiscord = BlzCreateFrameByType("BACKDROP", "QrCodeDiscord", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(qrCodeDiscord, FRAMEPOINT_TOPLEFT, QR_CODE_X, DISCORD_Y)
    call BlzFrameSetAbsPoint(qrCodeDiscord, FRAMEPOINT_BOTTOMRIGHT, QR_CODE_X + LABEL_HEIGHT, DISCORD_Y - LABEL_HEIGHT)
    call BlzFrameSetTexture(qrCodeDiscord, QR_CODE_DISCORD, 0, true)
    call BlzFrameSetLevel(qrCodeDiscord, 2)
    
    // Website
    set labelWebsite = BlzCreateFrameByType("TEXT", "LabelWebsite", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(labelWebsite, FRAMEPOINT_TOPLEFT, LABEL_X, WEBSITE_Y)
    call BlzFrameSetAbsPoint(labelWebsite, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, WEBSITE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(labelWebsite, GetLocalizedString("COLON_WEBSITE")) // Website:
    call BlzFrameSetTextAlignment(labelWebsite, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    
    set urlWebsite = BlzCreateFrame("EscMenuEditBoxTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(urlWebsite, FRAMEPOINT_TOPLEFT, URL_X, WEBSITE_Y)
    call BlzFrameSetAbsPoint(urlWebsite, FRAMEPOINT_BOTTOMRIGHT, URL_X + URL_WIDTH, WEBSITE_Y - LABEL_HEIGHT)
    call BlzFrameSetText(urlWebsite, URL_WEBSITE)
    
    set qrCodeWebsite = BlzCreateFrameByType("BACKDROP", "QrCodeWebsite", BackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(qrCodeWebsite, FRAMEPOINT_TOPLEFT, QR_CODE_X, WEBSITE_Y)
    call BlzFrameSetAbsPoint(qrCodeWebsite, FRAMEPOINT_BOTTOMRIGHT, QR_CODE_X + LABEL_HEIGHT, WEBSITE_Y - LABEL_HEIGHT)
    call BlzFrameSetTexture(qrCodeWebsite, QR_CODE_WEBSITE, 0, true)
    call BlzFrameSetLevel(qrCodeWebsite, 2)
    
    set TextAreaFrame = BlzCreateFrame("EscMenuTextAreaTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_TOPLEFT, TEXT_AREA_X, TEXT_AREA_Y)
    call BlzFrameSetAbsPoint(TextAreaFrame, FRAMEPOINT_BOTTOMRIGHT, TEXT_AREA_X + TEXT_AREA_WIDTH, TEXT_AREA_Y - TEXT_AREA_HEIGHT)
    call BlzFrameSetFont(TextAreaFrame, "MasterFont", 0.011, 0)
    call BlzFrameAddText(TextAreaFrame, Format(GetLocalizedString("NEWS_LINE_1")).s(MAP_VERSION).result())
    call BlzFrameAddText(TextAreaFrame, GetLocalizedString("NEWS_LINE_2"))
    set i = 0
    set max = GetMaxChangeLogQuestItems()
    loop
        exitwhen (i == max)
        call BlzFrameAddText(TextAreaFrame, "- " + GetLocalizedString(GetVersionQuestItemDescription(i)))
        set i = i + 1
    endloop

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

    call HideNewsUI()
endfunction

private function TriggerActionShowNewsUI takes nothing returns nothing
    call ShowNewsUIForPlayer(GetTriggerPlayer())
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
    call TriggerAddAction(chatCommandTrigger, function TriggerActionShowNewsUI)
    
    call OnStartGame(function CreateUI)
    // Prevents crashes on loading save games:
static if (LIBRARY_FrameLoader) then
    call FrameLoaderAdd(function CreateUI)
endif
endfunction

endlibrary
