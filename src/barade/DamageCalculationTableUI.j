library DamageCalculationTableUI initializer Init requires OnStartGame, optional FrameLoader, StringUtils, DamageCalculationTable

globals
    public constant string CHAT_COMMAND = "-dct"
    
    public constant string TOC_FILE = "war3mapImported\\xxx.toc"
    
    public constant real FULLSCREEN_HEIGHT = 0.6
    public constant real FULLSCREEN_WIDTH = 0.8

    public constant real WIDTH = 0.384
    public constant real HEIGHT = 0.38
    public constant real X = FULLSCREEN_WIDTH / 2.0 - (WIDTH / 2.0)
    public constant real Y = FULLSCREEN_HEIGHT - 0.0335
    public constant real TITLE_X = X
    public constant real TITLE_Y = Y - 0.028
    public constant real TITLE_HEIGHT = 0.015
    
    public constant real TABLE_BORDER_SPACE = 0.03
    public constant real VERTICAL_SPACE = 0.01
    
    public constant real TABLE_CELL_WIDTH = 0.032
    public constant real TABLE_LINE_HEIGHT = 0.032
  
    public constant real TABLE_X = X + TABLE_BORDER_SPACE
    public constant real TABLE_Y = TITLE_Y - TITLE_HEIGHT - VERTICAL_SPACE
    public constant real TABLE_WIDTH = WIDTH - 2.0 * TABLE_BORDER_SPACE
    public constant real TABLE_HEIGHT = (MAX_ATTACK_TYPES + 1) * TABLE_LINE_HEIGHT

    public constant real CLOSE_BUTTON_WIDTH = 0.13
    public constant real CLOSE_BUTTON_HEIGHT = 0.035
    public constant real CLOSE_BUTTON_X = FULLSCREEN_WIDTH / 2.0 - (CLOSE_BUTTON_WIDTH / 2.0)
    public constant real CLOSE_BUTTON_Y = TABLE_Y - TABLE_HEIGHT - VERTICAL_SPACE
    
    private framehandle BackgroundFrame
    
    private framehandle array attackTypes
    private framehandle array attackTypesTooltips
    private framehandle array defenseTypes
    private framehandle array defenseTypesTooltips
    private framehandle array cells
    private framehandle array cellsTooltips
    
    private trigger closeTrigger = null
    private trigger chatCommandTrigger = CreateTrigger()
endglobals

function EnableDamageCalculationTableUI takes nothing returns nothing
    call EnableTrigger(closeTrigger)
    call EnableTrigger(chatCommandTrigger)
endfunction

function DisableDamageCalculationTableUI takes nothing returns nothing
    call DisableTrigger(closeTrigger)
    call DisableTrigger(chatCommandTrigger)
endfunction

function SetDamageCalculationTableUIVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(BackgroundFrame, visible)
endfunction

function ShowDamageCalculationTableUI takes nothing returns nothing
    call SetDamageCalculationTableUIVisible(true)
endfunction

function HideDamageCalculationTableUI takes nothing returns nothing
    call SetDamageCalculationTableUIVisible(false)
endfunction

function SetDamageCalculationTableUIVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
     if (whichPlayer == GetLocalPlayer()) then
        call SetDamageCalculationTableUIVisible(visible)
    endif
endfunction

function ShowDamageCalculationTableUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetDamageCalculationTableUIVisible(true)
    endif
endfunction

function HideDamageCalculationTableUIForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetDamageCalculationTableUIVisible(false)
    endif
endfunction 

private function CloseFunction takes nothing returns nothing
    call HideDamageCalculationTableUIForPlayer(GetTriggerPlayer())
endfunction

function GetDefenseTypeName takes integer v returns string
    if (v == GetHandleId(DEFENSE_TYPE_NORMAL)) then
        return GetLocalizedString("NORMAL")
    elseif (v == GetHandleId(DEFENSE_TYPE_LIGHT)) then
        return GetLocalizedString("SMALL")
    elseif (v == GetHandleId(DEFENSE_TYPE_MEDIUM)) then
        return GetLocalizedString("MEDIUM")
    elseif (v == GetHandleId(DEFENSE_TYPE_LARGE)) then
        return GetLocalizedString("LARGE")
    elseif (v == GetHandleId(DEFENSE_TYPE_FORT)) then
        return GetLocalizedString("FORTIFIED")
    elseif (v == GetHandleId(DEFENSE_TYPE_HERO)) then
        return GetLocalizedString("HERO")
    elseif (v == GetHandleId(DEFENSE_TYPE_DIVINE)) then
        return GetLocalizedString("DIVINE")
    elseif (v == DEFENSE_TYPE_ETHEREAL) then
        return GetLocalizedString("ETHEREAL")
    endif
    
    return GetLocalizedString("NONE")
endfunction

function GetDefenseTypeIcon takes integer v returns string
    if (v == GetHandleId(DEFENSE_TYPE_NORMAL)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-small.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_LIGHT)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-small.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_MEDIUM)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-medium.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_LARGE)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-large.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_FORT)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-fortified.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_HERO)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-armor-hero.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_DIVINE)) then
        return "ReplaceableTextures\\CommandButtons\\ATTDivineArmorNew.blp"
    elseif (v == GetHandleId(DEFENSE_TYPE_NONE)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-unarmored.blp"
    elseif (v == DEFENSE_TYPE_ETHEREAL) then
        return "ReplaceableTextures\\CommandButtons\\ATTBanish.blp"
    endif
    
    return "UI\\Widgets\\Console\\Human\\Infocard-neutral-armor-unarmored.blp"
endfunction

function GetAttackTypeName takes integer v returns string
    if (v == GetHandleId(ATTACK_TYPE_NORMAL)) then
        return GetLocalizedString("SPELLS")
    elseif (v == GetHandleId(ATTACK_TYPE_PIERCE)) then
        return GetLocalizedString("PIERCE")
    elseif (v == GetHandleId(ATTACK_TYPE_SIEGE)) then
        return GetLocalizedString("SIEGE")
    elseif (v == GetHandleId(ATTACK_TYPE_MELEE)) then
        return GetLocalizedString("NORMAL")
    elseif (v == GetHandleId(ATTACK_TYPE_CHAOS)) then
        return GetLocalizedString("CHAOS")
    elseif (v == GetHandleId(ATTACK_TYPE_HERO)) then
        return GetLocalizedString("HERO")
    elseif (v == GetHandleId(ATTACK_TYPE_MAGIC)) then
        return GetLocalizedString("MAGIC")
    endif
    
    return GetLocalizedString("NONE")
endfunction

function GetAttackTypeIcon takes integer v returns string
    if (v == GetHandleId(ATTACK_TYPE_NORMAL)) then
        return "ReplaceableTextures\\CommandButtons\\ATTSorceressMaster.blp" // spells
    elseif (v == GetHandleId(ATTACK_TYPE_PIERCE)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-piercing.blp"
    elseif (v == GetHandleId(ATTACK_TYPE_SIEGE)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-siege.blp"
    elseif (v == GetHandleId(ATTACK_TYPE_MELEE)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-melee.blp"
    elseif (v == GetHandleId(ATTACK_TYPE_CHAOS)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-chaos.blp"
    elseif (v == GetHandleId(ATTACK_TYPE_HERO)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-hero.blp"
    elseif (v == GetHandleId(ATTACK_TYPE_MAGIC)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-magic.blp"
    endif
    
    return "UI\\Widgets\\Console\\Human\\Infocard-neutral-attack-melee.blp"
endfunction

public function CreateUI takes nothing returns nothing
    local framehandle f = null
    local integer i = 0
    local integer j = 0
    local integer index = 0
    
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, X + WIDTH, Y - HEIGHT)
    call BlzFrameSetLevel(BackgroundFrame, 1)

    set f = BlzCreateFrame("EscMenuTitleTextTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TITLE_X, TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TITLE_X + WIDTH, TITLE_Y - TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetText(f, GetLocalizedString("DAMAGE_CALCULATION_TABLE"))
    
    // y
    set i = 0
    loop
        exitwhen (i == MAX_ATTACK_TYPES)
        set f = BlzCreateFrameByType("BACKDROP", "AttackTypeFrame" + I2S(i), BackgroundFrame, "", 0)
        set attackTypes[i] = f
        call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TABLE_X, TABLE_Y - (i + 1) * TABLE_LINE_HEIGHT)
        call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TABLE_X + TABLE_CELL_WIDTH, TABLE_Y - (i + 1) * TABLE_LINE_HEIGHT - TABLE_LINE_HEIGHT)
        call BlzFrameSetTexture(f, GetAttackTypeIcon(i), 0, false)
        
        set f = BlzCreateFrameByType("TEXT", "AttackTypeTooltip" + I2S(i), BackgroundFrame, "", 0)
        set attackTypesTooltips[i] = f
        call BlzFrameSetTooltip(attackTypes[i], f)
        call BlzFrameSetPoint(f, FRAMEPOINT_BOTTOM, attackTypes[i], FRAMEPOINT_TOP, 0, 0.01)
        call BlzFrameSetEnable(f, false)
        call BlzFrameSetText(f, GetAttackTypeName(i))
        
        set i = i + 1
    endloop
    
    // x
    set i = 0
    loop
        exitwhen (i == MAX_DEFENSE_TYPES)
        set f = BlzCreateFrameByType("BACKDROP", "DefenseTypeFrame" + I2S(i), BackgroundFrame, "", 0)
        set defenseTypes[i] = f
        call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TABLE_X + (i + 1) * TABLE_CELL_WIDTH, TABLE_Y)
        call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TABLE_X + (i + 1) * TABLE_CELL_WIDTH + TABLE_CELL_WIDTH, TABLE_Y - TABLE_LINE_HEIGHT)
        call BlzFrameSetTexture(f, GetDefenseTypeIcon(i), 0, false)
        
        set f = BlzCreateFrameByType("TEXT", "DefenseTypeTooltip" + I2S(i), BackgroundFrame, "", 0)
        set defenseTypesTooltips[i] = f
        call BlzFrameSetTooltip(defenseTypes[i], f)
        call BlzFrameSetPoint(f, FRAMEPOINT_BOTTOM, defenseTypes[i], FRAMEPOINT_TOP, 0, 0.01)
        call BlzFrameSetEnable(f, false)
        call BlzFrameSetText(f, GetDefenseTypeName(i))
        
        set i = i + 1
    endloop
    
    set i = 0 // y
    loop
        exitwhen (i == MAX_ATTACK_TYPES)
        set j = 0 // x
        loop
            exitwhen (j == MAX_DEFENSE_TYPES)
            set index = Index2D(i, j, MAX_DEFENSE_TYPES)
            set f = BlzCreateFrameByType("TEXT", "CellFrame" + I2S(index), BackgroundFrame, "", 1)
            set cells[index] = f
            call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, TABLE_X + (j + 1) * TABLE_CELL_WIDTH, TABLE_Y - (i + 1) * TABLE_LINE_HEIGHT)
            call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, TABLE_X + (j + 1) * TABLE_CELL_WIDTH + TABLE_CELL_WIDTH, TABLE_Y - (i + 1) * TABLE_LINE_HEIGHT - TABLE_LINE_HEIGHT)
            call BlzFrameSetText(f, I2S(R2I(100 * GetDamageCalculationTableValue(i, j))) + " %%")
            call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
            
            set f = BlzCreateFrameByType("TEXT", "CellTooltip" + I2S(index), BackgroundFrame, "", 0)
            set cellsTooltips[index] = f
            call BlzFrameSetTooltip(cells[index], f)
            call BlzFrameSetPoint(f, FRAMEPOINT_BOTTOM, cells[index], FRAMEPOINT_TOP, 0, 0.0005)
            call BlzFrameSetEnable(f, false)
            call BlzFrameSetText(f, GetAttackTypeName(i) + " - " + GetDefenseTypeName(j))
            
            set j = j + 1
        endloop
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

    call HideDamageCalculationTableUI()
endfunction

private function TriggerActionShowUI takes nothing returns nothing
    call ShowDamageCalculationTableUIForPlayer(GetTriggerPlayer())
endfunction

private function Start takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            if (StringLength(CHAT_COMMAND) > 0) then
                call TriggerRegisterPlayerChatEvent(chatCommandTrigger, slotPlayer, CHAT_COMMAND, true)
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(chatCommandTrigger, function TriggerActionShowUI)

    call BlzLoadTOCFile(TOC_FILE)
    
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
