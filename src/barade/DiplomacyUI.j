library DiplomacyUI initializer Init requires DiplomacyUIConfig, SimError, StringUtils, PlayerColorUtils, MathUtils, optional FrameLoader

globals
    public constant string CHAT_COMMAND = "-diplomacy"
    public constant string CHAT_COMMAND_SHORT = "-dp"
    public constant string PREFIX = "DiplomacyUI"
    public constant string TOC_FILE = "war3mapImported\\diplomacyui.toc"
    public constant boolean LOAD_TOC_FILE = false
    
    public constant real PLAYER_SCALE = 0.1
    public constant real PLAYER_INDENTION = 0.013
    public constant real X = 0.0
    public constant real Y = 0.55
    public constant real TITLE_Y = Y - 0.03
    public constant real WIDTH = 0.8
    public constant real HEIGHT = 0.4
    public constant real TITLE_HEIGHT = 0.04
    public constant real TITLE_VERTICAL_SPACE = 0.01
    public constant real BUTTON_Y = 0.21
    public constant real BUTTON_WIDTH = 0.09
    public constant real BUTTON_HEIGHT = 0.032
    public constant real CANCEL_BUTTON_X = 0.32
    public constant real APPLY_BUTTON_X = CANCEL_BUTTON_X + BUTTON_WIDTH
    public constant real TABLE_WIDTH = WIDTH - 0.02
    public constant real TABLE_HEIGHT = HEIGHT - TITLE_HEIGHT - TITLE_VERTICAL_SPACE - (BUTTON_Y - (Y - HEIGHT))
    public constant real CELL_WIDTH = 0.07 // default for only 1 player
    public constant real CELL_HEIGHT = 0.07
    public constant string TOOLTIP_FONT = "fonts\\dfst-m3u.ttf"
    public constant real TOOLTIP_FONT_HEIGHT = 0.008
    public constant real TOOLTIP_X = 0.55
    public constant real TOOLTIP_Y = 0.50
    public constant real TOOLTIP_WIDTH = 0.20
    public constant real TOOLTIP_HEIGHT = 0.6
    
    private framehandle Background
    private framehandle Title
    private framehandle TableTitle
    private framehandle array ColumnTitles
    private framehandle array RowTitles
    private framehandle array Cells
    private framehandle array CellsTooltip
    private framehandle CancelButton
    private framehandle ApplyButton

    private force allPlayers = null
    private integer allPlayersCount = 0
    private real scale = 1.0
    private real indentionX = 0.0
    private trigger syncTrigger = CreateTrigger()
    private trigger chatTrigger = CreateTrigger()
    private trigger changeTrigger = null
    private trigger cancelTrigger = null
    private trigger applyTrigger = null
endglobals

function GetAllianceState takes player sourcePlayer, player otherPlayer returns integer
    if (IsPlayerAlly(sourcePlayer, otherPlayer)) then
        if (GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)) then
            return bj_ALLIANCE_ALLIED_ADVUNITS
        elseif (GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL)) then
            return bj_ALLIANCE_ALLIED_UNITS
        elseif (GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION)) then
            return bj_ALLIANCE_ALLIED_VISION
        endif
        
        return bj_ALLIANCE_ALLIED
    elseif (IsPlayerEnemy(sourcePlayer, otherPlayer)) then
        if (GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION)) then
            return bj_ALLIANCE_UNALLIED_VISION
        endif
        
        return bj_ALLIANCE_UNALLIED
    endif
    
    if (GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION)) then
        return bj_ALLIANCE_NEUTRAL_VISION
    endif
    
    return bj_ALLIANCE_NEUTRAL
endfunction

private function GetAllianceStateName takes integer allianceState returns string
    if (allianceState == bj_ALLIANCE_UNALLIED) then
        return GetLocalizedString("UNALLIED")
    elseif (allianceState == bj_ALLIANCE_UNALLIED_VISION) then
        return GetLocalizedString("UNALLIED_VISION")
    elseif (allianceState == bj_ALLIANCE_ALLIED) then
        return GetLocalizedString("ALLIED")
    elseif (allianceState == bj_ALLIANCE_ALLIED_VISION) then
        return GetLocalizedString("ALLIED_VISION")
    elseif (allianceState == bj_ALLIANCE_ALLIED_UNITS) then
        return GetLocalizedString("ALLIED_UNITS")
    elseif (allianceState == bj_ALLIANCE_ALLIED_ADVUNITS) then
        return GetLocalizedString("ALLIED_ADVANCED_UNITS")
    elseif (allianceState == bj_ALLIANCE_NEUTRAL) then
        return GetLocalizedString("NEUTRAL")
    endif
    return GetLocalizedString("NEUTRAL_VISION")
endfunction

private function UpdateTooltips takes nothing returns nothing
    local player rowPlayer = null
    local player columnPlayer = null
    local integer row = 0
    local integer column = 0
    local integer index = 0
    local integer allianceState = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    if (rowPlayer != columnPlayer) then
                        set index = Index2D(row, column, bj_MAX_PLAYERS)
                        set allianceState = R2I(BlzFrameGetValue(Cells[index]))
                        call BlzFrameSetText(CellsTooltip[index], Format(GetLocalizedString("FROM_TO_X")).s(GetPlayerNameColored(rowPlayer)).s(GetPlayerNameColored(columnPlayer)).s(GetAllianceStateName(allianceState)).result())
                    endif
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
endfunction

private function UpdateUI takes nothing returns nothing
    local player rowPlayer = null
    local player columnPlayer = null
    local integer row = 0
    local integer column = 0
    local integer index = 0
    local integer allianceState = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            call BlzFrameSetTexture(RowTitles[row], GetPlayerColorTexture(GetPlayerColor(rowPlayer)), 0, true)
            call BlzFrameSetTexture(ColumnTitles[row], GetPlayerColorTexture(GetPlayerColor(rowPlayer)), 0, true)

            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    if (rowPlayer != columnPlayer) then
                        set index = Index2D(row, column, bj_MAX_PLAYERS)
                        set allianceState = GetAllianceState(rowPlayer, columnPlayer)
                        call BlzFrameSetValue(Cells[index], I2R(allianceState))
                    endif
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
    call UpdateTooltips()
endfunction

function SetDiplomacyUIVisible takes boolean visible returns nothing
    local player rowPlayer = null
    local player columnPlayer = null
    local integer row = 0
    local integer column = 0
    local integer index = 0
    call BlzFrameSetVisible(Background, visible)
    call BlzFrameSetVisible(Title, visible)
    call BlzFrameSetVisible(TableTitle, visible)
    call BlzFrameSetVisible(CancelButton, visible)
    call BlzFrameSetVisible(ApplyButton, visible)
    set row = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            call BlzFrameSetVisible(ColumnTitles[row], visible)
            call BlzFrameSetVisible(RowTitles[row], visible)
            
            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    if (rowPlayer != columnPlayer) then
                        set index = Index2D(row, column, bj_MAX_PLAYERS)
                        call BlzFrameSetVisible(Cells[index], visible)
                        
                        if (not visible) then
                            call BlzFrameSetVisible(CellsTooltip[index], visible)
                        endif
                    endif
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
endfunction

function ShowDiplomacyUI takes nothing returns nothing
    call UpdateUI()
    call SetDiplomacyUIVisible(true)
endfunction

function HideDiplomacyUI takes nothing returns nothing
    call SetDiplomacyUIVisible(false)
endfunction

private function TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer = GetTriggerPlayer()
    local integer playerId = GetPlayerId(whichPlayer)
    local string data = BlzGetTriggerSyncData()
    local integer sourcePlayerId = S2I(StringSplit(data, 0, "_"))
    local integer otherPlayerId = S2I(StringSplit(data, 1, "_"))
    local integer allianceState = S2I(StringSplit(data, 2, "_"))
    local player sourcePlayer = Player(sourcePlayerId)
    local player otherPlayer = Player(otherPlayerId)
    //call BJDebugMsg("Synced data " + GetPlayerName(whichPlayer) + " for " + GetPlayerName(sourcePlayer) + " and " + GetPlayerName(otherPlayer) + ": " + I2S(allianceState))
    call SetPlayerAllianceStateBJ(sourcePlayer, otherPlayer, allianceState)
    set whichPlayer = null
    set sourcePlayer = null
    set otherPlayer = null
endfunction

private function TriggerActionChat takes nothing returns nothing
    if (DiplomacyUIConfig_IsPlayerAllowed(GetTriggerPlayer())) then
        if (GetTriggerPlayer() == GetLocalPlayer()) then
            call ShowDiplomacyUI()
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedString("DIPLOMACY_CHANGE_NOT_ALLOWED"))
    endif
endfunction

private function ApplyFunction takes nothing returns nothing
    local player rowPlayer = null
    local player columnPlayer = null
    local integer row = 0
    local integer column = 0
    local integer index = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    if (rowPlayer != columnPlayer) then
                        set index = Index2D(row, column, bj_MAX_PLAYERS)
                        if (GetLocalPlayer() == GetTriggerPlayer()) then
                            call BlzSendSyncData(PREFIX, I2S(row) + "_" + I2S(column) + "_" + I2S(R2I(BlzFrameGetValue(Cells[index]))))
                        endif
                    endif
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
    call HideDiplomacyUI()
endfunction

private function CreateUI takes nothing returns nothing
    local integer row = 0
    local integer column = 0
    local player rowPlayer = null
    local player columnPlayer = null
    local real x = 0.0
    local real headerX = 0.0
    local real headerY = 0.0
    local real y = 0.0
    local integer index = 0
    local real cellWidth = CELL_WIDTH * scale
    local real cellHeight = CELL_HEIGHT * scale

    set Background = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(Background, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(Background, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    
    set Title = BlzCreateFrameByType("TEXT", "DiplomacyUITitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(Title, FRAMEPOINT_TOPLEFT, X, TITLE_Y)
    call BlzFrameSetAbsPoint(Title, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, TITLE_Y - TITLE_HEIGHT)
    call BlzFrameSetText(Title, GetLocalizedString("DIPLOMACY"))
    call BlzFrameSetTextAlignment(Title, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set y = Y - TITLE_HEIGHT - TITLE_VERTICAL_SPACE - cellHeight
    set headerX = indentionX + cellWidth
    set headerY = Y - TITLE_HEIGHT - TITLE_VERTICAL_SPACE
    
    set TableTitle = BlzCreateFrameByType("TEXT", "DiplomacyUITableTitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TableTitle, FRAMEPOINT_TOPLEFT, indentionX, headerY)
    call BlzFrameSetAbsPoint(TableTitle, FRAMEPOINT_BOTTOMRIGHT, indentionX + cellWidth, headerY - cellHeight)
    call BlzFrameSetText(TableTitle, GetLocalizedString("SOURCE_TARGET"))
    call BlzFrameSetTextAlignment(TableTitle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(TableTitle, scale)
    
    set changeTrigger = CreateTrigger()
    set cancelTrigger = CreateTrigger()
    set applyTrigger = CreateTrigger()
    
    call TriggerAddAction(changeTrigger, function UpdateTooltips)
    
    set row = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            set x = indentionX
            
            set RowTitles[row] = BlzCreateFrameByType("BACKDROP", PREFIX + "RowTitle" + I2S(row), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(RowTitles[row], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(RowTitles[row], FRAMEPOINT_BOTTOMRIGHT, x + cellHeight, y - cellHeight)
            //call BlzFrameSetText(RowTitles[row], GetPlayerNameColoredSimple(rowPlayer))
            call BlzFrameSetTexture(RowTitles[row], GetPlayerColorTexture(GetPlayerColor(rowPlayer)), 0, true)
            call BlzFrameSetTextAlignment(RowTitles[row], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
            call BlzFrameSetScale(RowTitles[row], scale)
            
            set x = x + cellHeight
            
            set ColumnTitles[row] = BlzCreateFrameByType("BACKDROP", PREFIX + "ColumnTitle" + I2S(row), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(ColumnTitles[row], FRAMEPOINT_TOPLEFT, headerX, headerY)
            call BlzFrameSetAbsPoint(ColumnTitles[row], FRAMEPOINT_BOTTOMRIGHT, headerX + cellHeight, headerY - cellHeight)
            //call BlzFrameSetText(ColumnTitles[row], GetPlayerNameColoredSimple(rowPlayer))
            call BlzFrameSetTexture(ColumnTitles[row], GetPlayerColorTexture(GetPlayerColor(rowPlayer)), 0, true)
            call BlzFrameSetTextAlignment(ColumnTitles[row], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
            call BlzFrameSetScale(ColumnTitles[row], scale)
            
            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    set index = Index2D(row, column, bj_MAX_PLAYERS)
                    
                    if (rowPlayer != columnPlayer) then
                        set Cells[index] = BlzCreateFrame("AlliancePopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                        call BlzFrameSetAbsPoint(Cells[index], FRAMEPOINT_TOPLEFT, x, y)
                        call BlzFrameSetAbsPoint(Cells[index], FRAMEPOINT_BOTTOMRIGHT, x + cellWidth, y - cellHeight)
                        call BlzFrameSetScale(Cells[index], scale)
                        
                        call BlzTriggerRegisterFrameEvent(changeTrigger, Cells[index], FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
                        
                        set CellsTooltip[index] = BlzCreateFrameByType("TEXT", PREFIX + "CellsTooltip" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
                        call BlzFrameSetTooltip(Cells[index], CellsTooltip[index])
                        call BlzFrameSetAbsPoint(CellsTooltip[index], FRAMEPOINT_TOPLEFT, TOOLTIP_X, TOOLTIP_Y)
                        call BlzFrameSetAbsPoint(CellsTooltip[index], FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_X + TOOLTIP_WIDTH, TOOLTIP_Y - TOOLTIP_HEIGHT)
                        call BlzFrameSetFont(CellsTooltip[index], TOOLTIP_FONT, TOOLTIP_FONT_HEIGHT, 0)
                    endif
                    
                    set x = x + cellWidth
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
            
            set y = y - cellHeight
            set headerX = headerX + cellWidth
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
    
    set CancelButton = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(CancelButton, FRAMEPOINT_TOPLEFT, CANCEL_BUTTON_X, BUTTON_Y)
    call BlzFrameSetAbsPoint(CancelButton, FRAMEPOINT_BOTTOMRIGHT, CANCEL_BUTTON_X + BUTTON_WIDTH, BUTTON_Y - BUTTON_HEIGHT)
    call BlzFrameSetText(CancelButton, GetLocalizedString("CANCEL_YELLOW"))

    set cancelTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(cancelTrigger, CancelButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(cancelTrigger, function HideDiplomacyUI)
    
    set ApplyButton = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ApplyButton, FRAMEPOINT_TOPLEFT, APPLY_BUTTON_X, BUTTON_Y)
    call BlzFrameSetAbsPoint(ApplyButton, FRAMEPOINT_BOTTOMRIGHT, APPLY_BUTTON_X + BUTTON_WIDTH, BUTTON_Y - BUTTON_HEIGHT)
    call BlzFrameSetText(ApplyButton, GetLocalizedString("APPLY_YELLOW"))

    set applyTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(applyTrigger, ApplyButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(applyTrigger, function ApplyFunction)

    call UpdateUI()
    call HideDiplomacyUI()
endfunction

private function DestroyUI takes nothing returns nothing
    local integer row = 0
    local integer column = 0
    local player rowPlayer = null
    local player columnPlayer = null
    local integer index = 0
    
    call HideDiplomacyUI()

    call BlzDestroyFrame(Background)
    call BlzDestroyFrame(Title)
    call BlzDestroyFrame(TableTitle)
    
    set row = 0
    loop
        exitwhen (row == bj_MAX_PLAYERS)
        set rowPlayer = Player(row)
        if (IsPlayerInForce(rowPlayer, allPlayers)) then
            call BlzDestroyFrame(RowTitles[row])
            call BlzDestroyFrame(ColumnTitles[row])
          
            set column = 0
            loop
                exitwhen (column == bj_MAX_PLAYERS)
                set columnPlayer = Player(column)
                if (IsPlayerInForce(columnPlayer, allPlayers)) then
                    set index = Index2D(row, column, bj_MAX_PLAYERS)
                    
                    if (rowPlayer != columnPlayer) then
                        call BlzDestroyFrame(Cells[row])
                        call BlzDestroyFrame(CellsTooltip[row])
                    endif
                endif
                set columnPlayer = null
                set column = column + 1
            endloop
        endif
        set rowPlayer = null
        set row = row + 1
    endloop
    
    call BlzDestroyFrame(CancelButton)
    call DestroyTrigger(cancelTrigger)
    call BlzDestroyFrame(ApplyButton)
    call DestroyTrigger(applyTrigger)
endfunction

function SetDiplomacyUIPlayers takes force whichForce returns nothing
    local integer cellsCount = CountPlayersInForceBJ(whichForce) + 1
    local real width = I2R(cellsCount) * CELL_WIDTH
    local real height = I2R(cellsCount) * CELL_HEIGHT
    local real widthScale = TABLE_WIDTH / width
    local real heightScale = TABLE_HEIGHT / height
    set scale = RMinBJ(widthScale, heightScale)

    if (allPlayers != null) then
        call HideDiplomacyUI()
        call DestroyUI()
        call DestroyForce(allPlayers)
    endif
    set allPlayers = whichForce
    //call BJDebugMsg("with count " + I2S(cellsCount) + ": " + R2S(scale))
    set indentionX = X + (WIDTH - cellsCount * scale * CELL_WIDTH) / 2.0
    
    call CreateUI()
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER) then
            call BlzTriggerRegisterPlayerSyncEvent(syncTrigger, slotPlayer, PREFIX, false)
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, CHAT_COMMAND, true)
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, CHAT_COMMAND_SHORT, true)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(syncTrigger, function TriggerActionSyncData)
    call TriggerAddAction(chatTrigger, function TriggerActionChat)
    
    call SetDiplomacyUIPlayers(DiplomacyUIConfig_GetValidPlayers())
    
static if (LOAD_TOC_FILE) then
    call BlzLoadTOCFile(TOC_FILE)
endif
    
static if (LIBRARY_FrameLoader) then
    call FrameLoaderAdd(function CreateUI)
endif

    call OnStartGame(function CreateUI)
endfunction

endlibrary
