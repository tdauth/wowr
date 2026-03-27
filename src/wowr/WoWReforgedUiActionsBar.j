library WoWReforgedUiActionsBar initializer Init requires optional Tracer, OnStartGame, FrameSaver, FrameLoader, LogUI, DamageCalculationTableUI, DiplomacyUI, WoWReforgedUiNews, WoWReforgedAutoSkill, optional HandleCountersMultiboard, optional PeriodicWatcherMultiboard, WoWReforgedUi, WoWReforgedUtils, WoWReforgedItemUtils, WoWReforgedBackpacks, WoWReforgedUiBackpack, WoWReforgedMounts, WoWReforgedUiSaveCode, WoWReforgedSummonedUnits, WoWReforgedAltars, WoWReforgedCalendarMultiboard, WoWReforgedResources, WoWReforgedStats

globals
    private constant string PREFIX = "WoWReforgedUiActionsBar"
    private constant string REPLACEABLE_TEXTURES_PATH = "ReplaceableTextures\\CommandButtons\\"

    private constant real UI_X = 0.20
    private constant real UI_Y = 0.163
    private constant real UI_BUTTON_SIZE = 0.020
    private constant real UI_SPACE = 0.003
    
    private constant real UI_CHECKBOX_X = UI_X
    private constant real UI_CLEAR_X = UI_CHECKBOX_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_PICKUP_ITEMS_X = UI_CLEAR_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_DROP_ITEMS_X = UI_PICKUP_ITEMS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_BACKPACK_X = UI_DROP_ITEMS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_MOUNTS_X = UI_BACKPACK_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_SUMMONED_UNITS_X = UI_MOUNTS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_TOWN_HALLS_X = UI_SUMMONED_UNITS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_ALTARS_X = UI_TOWN_HALLS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_SAVECODES_X = UI_ALTARS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_AUTO_SKILL_X = UI_SAVECODES_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_LOG_X = UI_AUTO_SKILL_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_DCT_X = UI_LOG_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_DIPLOMACY_X = UI_DCT_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_SETTINGS_X = UI_DIPLOMACY_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_NEWS_X = UI_SETTINGS_X + UI_BUTTON_SIZE + UI_SPACE
    private constant real UI_MULTIBOARD_X = UI_NEWS_X + UI_BUTTON_SIZE + UI_SPACE
    
    private trigger SyncTrigger = CreateTrigger()
    
    private framehandle CheckboxButton
    private framehandle CheckboxTooltip
    private trigger CheckboxCheckTrigger
    private trigger CheckboxUncheckTrigger
    
    private framehandle ClearButton
    private framehandle ClearFrame
    private framehandle ClearTooltip
    private trigger ClearTrigger

    private framehandle PickupItemsButton
    private framehandle PickupItemsFrame
    private framehandle PickupItemsTooltip
    private trigger PickupItemsTrigger
    
    private framehandle DropItemsButton
    private framehandle DropItemsFrame
    private framehandle DropItemsTooltip
    private trigger DropItemsTrigger
    
    private framehandle BackpackButton
    private framehandle BackpackFrame
    private framehandle BackpackTooltip
    private trigger BackpackTrigger
    
    private framehandle MountsButton
    private framehandle MountsFrame
    private framehandle MountsTooltip
    private trigger MountsTrigger
    
    private framehandle SummonedUnitsButton
    private framehandle SummonedUnitsFrame
    private framehandle SummonedUnitsTooltip
    private trigger SummonedUnitsTrigger
    
    private framehandle TownHallsButton
    private framehandle TownHallsFrame
    private framehandle TownHallsTooltip
    private trigger TownHallsTrigger
    
    private framehandle AltarsButton
    private framehandle AltarsFrame
    private framehandle AltarsTooltip
    private trigger AltarsTrigger
    
    private framehandle SaveCodesButton
    private framehandle SaveCodesFrame
    private framehandle SaveCodesTooltip
    private trigger SaveCodesTrigger
    
    private framehandle AutoSkillButton
    private framehandle AutoSkillFrame
    private framehandle AutoSkillTooltip
    private trigger AutoSkillTrigger
    
    private framehandle LogButton
    private framehandle LogFrame
    private framehandle LogTooltip
    private trigger LogTrigger
    
    // Damage Calculation Table
    private framehandle DctButton
    private framehandle DctFrame
    private framehandle DctTooltip
    private trigger DctTrigger
        
    private framehandle DiplomacyButton
    private framehandle DiplomacyFrame
    private framehandle DiplomacyTooltip
    private trigger DiplomacyTrigger
    
    private framehandle SettingsButton
    private framehandle SettingsFrame
    private framehandle SettingsTooltip
    private trigger SettingsTrigger
    
    private framehandle NewsButton
    private framehandle NewsFrame
    private framehandle NewsTooltip
    private trigger NewsTrigger
    
    private framehandle MultiboardButton
    private framehandle MultiboardFrame
    private framehandle MultiboardTooltip
    private trigger MultiboardTrigger
    
    private integer array currentMultiboard
    private boolean array checked
endglobals

function SetActionsBarUIRaceTextures takes string mountsTexture, string summonedUnitsTexture, string townHallsTexture, string altarsTexture returns nothing
    call BlzFrameSetTexture(MountsFrame, REPLACEABLE_TEXTURES_PATH + mountsTexture, 0, true)
    call BlzFrameSetTexture(SummonedUnitsFrame, REPLACEABLE_TEXTURES_PATH + summonedUnitsTexture, 0, true)
    call BlzFrameSetTexture(TownHallsFrame, REPLACEABLE_TEXTURES_PATH + townHallsTexture, 0, true)
    call BlzFrameSetTexture(AltarsFrame, REPLACEABLE_TEXTURES_PATH + altarsTexture, 0, true)
endfunction

private function HasHandleCounters takes nothing returns boolean
static if (LIBRARY_HandleCountersMultiboard) then
    return true
else
    return false
endif
endfunction

private function HasPeriodicWatchers takes nothing returns boolean
static if (LIBRARY_PeriodicWatcherMultiboard) then
    return true
else
    return false
endif
endfunction

private function GetMax takes nothing returns integer
    local integer max = 3
    
static if (LIBRARY_HandleCountersMultiboard) then
    set max = max + 1
endif

static if (LIBRARY_PeriodicWatcherMultiboard) then
    set max = max + 1
endif

    return max
endfunction

private function GetIndex2 takes nothing returns integer
    return 3
endfunction

private function GetIndex3 takes nothing returns integer
    local integer result = 3
    
static if (LIBRARY_HandleCountersMultiboard and LIBRARY_PeriodicWatcherMultiboard) then
    set result = result + 1
endif

    return result
endfunction

function RemoveActionsBarUIFocusEx takes framehandle f, player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetFocus(f, false)
    endif
endfunction

function RemoveActionsBarUIFocus takes player whichPlayer returns nothing
    call RemoveActionsBarUIFocusEx(BlzGetTriggerFrame(), whichPlayer)
endfunction

function SetActionsBarUIVisible takes boolean visible, boolean includeChecbox returns nothing
    if (includeChecbox) then
        call BlzFrameSetVisible(CheckboxButton, visible)
    endif
    if (visible) then
        set visible = not checked[GetPlayerId(GetLocalPlayer())]
    endif
    call BlzFrameSetVisible(ClearButton, visible)
    call BlzFrameSetVisible(ClearFrame, visible)
    call BlzFrameSetVisible(PickupItemsButton, visible)
    call BlzFrameSetVisible(DropItemsButton, visible)
    call BlzFrameSetVisible(PickupItemsFrame, visible)
    call BlzFrameSetVisible(BackpackButton, visible)
    call BlzFrameSetVisible(BackpackFrame, visible)
    call BlzFrameSetVisible(MountsButton, visible)
    call BlzFrameSetVisible(MountsFrame, visible)
    call BlzFrameSetVisible(SummonedUnitsButton, visible)
    call BlzFrameSetVisible(SummonedUnitsFrame, visible)
    call BlzFrameSetVisible(TownHallsButton, visible)
    call BlzFrameSetVisible(TownHallsFrame, visible)
    call BlzFrameSetVisible(AltarsButton, visible)
    call BlzFrameSetVisible(AltarsFrame, visible)
    call BlzFrameSetVisible(SaveCodesButton, visible)
    call BlzFrameSetVisible(SaveCodesFrame, visible)
    call BlzFrameSetVisible(AutoSkillButton, visible)
    call BlzFrameSetVisible(AutoSkillFrame, visible)
    call BlzFrameSetVisible(LogButton, visible)
    call BlzFrameSetVisible(LogFrame, visible)
    call BlzFrameSetVisible(DctButton, visible)
    call BlzFrameSetVisible(DctFrame, visible)
    call BlzFrameSetVisible(DiplomacyButton, visible)
    call BlzFrameSetVisible(DiplomacyFrame, visible)
    call BlzFrameSetVisible(SettingsButton, visible)
    call BlzFrameSetVisible(SettingsFrame, visible)
    call BlzFrameSetVisible(NewsButton, visible)
    call BlzFrameSetVisible(NewsFrame, visible)
    call BlzFrameSetVisible(MultiboardButton, visible)
    call BlzFrameSetVisible(MultiboardFrame, visible)
endfunction

function SetActionsBarUIVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetActionsBarUIVisible(visible, true)
    endif
endfunction

function ShowActionsBarUI takes player whichPlayer returns nothing
    call SetActionsBarUIVisibleForPlayer(whichPlayer, true)
endfunction

function HideActionsBarUI takes player whichPlayer returns nothing
    call SetActionsBarUIVisibleForPlayer(whichPlayer, false)
endfunction

private function CheckedFunction takes nothing returns nothing
    //! runtextmacro optional Trace("ActionsBarUiChecked")
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Checked")
    endif

    call RemoveActionsBarUIFocus(GetTriggerPlayer())
endfunction
    
private function UncheckedFunction takes nothing returns nothing
    //! runtextmacro optional Trace("ActionsBarUiUnchecked")
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Unchecked")
    endif
    
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
endfunction

private function EnumPlayersUpdateActionBar takes nothing returns nothing
    set checked[GetPlayerId(GetEnumPlayer())] = false
    call ShowActionsBarUI(GetEnumPlayer())
endfunction

private function UpdateAllActionBars takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumPlayersUpdateActionBar)
endfunction

private function ClearClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call ClearTextMessages()
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(ClearFrame, GetTriggerPlayer())
endfunction

private function PickupItemsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "PickupItems")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(PickupItemsFrame, GetTriggerPlayer())
endfunction

private function DropItemsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "DropBackpack")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(DropItemsFrame, GetTriggerPlayer())
endfunction

private function BackpackClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Backpack")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(BackpackFrame, GetTriggerPlayer())
endfunction

private function MountsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Mount")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(MountsFrame, GetTriggerPlayer())
endfunction

private function SummonedUnitsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "SummonedUnit")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(SummonedUnitsFrame, GetTriggerPlayer())
endfunction

private function TownHallsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "TownHall")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(TownHallsFrame, GetTriggerPlayer())
endfunction

private function AltarsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Altar")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(AltarsFrame, GetTriggerPlayer())
endfunction

private function SaveCodesClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "SaveCodes")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(SaveCodesFrame, GetTriggerPlayer())
endfunction

private function AutoSkillClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "AutoSkill")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(AutoSkillFrame, GetTriggerPlayer())
endfunction

private function LogClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Log")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(LogFrame, GetTriggerPlayer())
endfunction

private function DctClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Dct")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(LogFrame, GetTriggerPlayer())
endfunction


private function DiplomacyClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Diplomacy")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(DiplomacyFrame, GetTriggerPlayer())
endfunction

private function SettingsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Settings")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(DiplomacyFrame, GetTriggerPlayer())
endfunction

private function NewsClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "News")
    endif
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(DiplomacyFrame, GetTriggerPlayer())
endfunction

private function UpdateMultiboard takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    
    //call BJDebugMsg("Current multiboard index " + I2S(currentMultiboard[playerId]) + " with index 2 " + I2S(GetIndex2()) + " and index 3 " + I2S(GetIndex3()))
    
    if (currentMultiboard[playerId] == 0) then
        // stats
        call HideCalendarMultiboardForPlayer(whichPlayer)
        if (whichPlayer == GetLocalPlayer()) then
            call HidePlayerResourceMultiboard(whichPlayer)
        endif
static if (LIBRARY_HandleCountersMultiboard) then
        call HideHandleCountersMultiboardForPlayer(whichPlayer)
endif
static if (LIBRARY_PeriodicWatcherMultiboard) then
        call HidePeriodicWatcherMultiboardForPlayer(whichPlayer)
endif
        call ShowStatsMultiboard(whichPlayer)
    elseif (currentMultiboard[playerId] == 1) then
        // resources UI
        call HideStatsMultiboard(whichPlayer)
        call HideCalendarMultiboardForPlayer(whichPlayer)
static if (LIBRARY_HandleCountersMultiboard) then
        call HideHandleCountersMultiboardForPlayer(whichPlayer)
endif
static if (LIBRARY_PeriodicWatcherMultiboard) then
        call HidePeriodicWatcherMultiboardForPlayer(whichPlayer)
endif
        if (whichPlayer == GetLocalPlayer()) then
            call ShowPlayerResourceMultiboard(whichPlayer)
        endif
    elseif (currentMultiboard[playerId] == 2) then
        // calendar UI
        if (whichPlayer == GetLocalPlayer()) then
            call HidePlayerResourceMultiboard(whichPlayer)
        endif
        call HideStatsMultiboard(whichPlayer)
static if (LIBRARY_HandleCountersMultiboard) then
        call HideHandleCountersMultiboardForPlayer(whichPlayer)
endif
static if (LIBRARY_PeriodicWatcherMultiboard) then
        call HidePeriodicWatcherMultiboardForPlayer(whichPlayer)
endif
        call ShowCalendarMultiboardForPlayer(whichPlayer)
    elseif (currentMultiboard[playerId] == GetIndex2() and HasHandleCounters()) then
        // handles UI
        if (whichPlayer == GetLocalPlayer()) then
            call HidePlayerResourceMultiboard(whichPlayer)
        endif
        call HideStatsMultiboard(whichPlayer)
        call HideCalendarMultiboardForPlayer(whichPlayer)
static if (LIBRARY_PeriodicWatcherMultiboard) then
        call HidePeriodicWatcherMultiboardForPlayer(whichPlayer)
endif
static if (LIBRARY_HandleCountersMultiboard) then
        call ShowHandleCountersMultiboardForPlayer(whichPlayer)
endif
    elseif (currentMultiboard[playerId] == GetIndex3() and HasPeriodicWatchers()) then
        // timers UI
        if (whichPlayer == GetLocalPlayer()) then
            call HidePlayerResourceMultiboard(whichPlayer)
        endif
        call HideStatsMultiboard(whichPlayer)
        call HideCalendarMultiboardForPlayer(whichPlayer)
static if (LIBRARY_HandleCountersMultiboard) then
        call HideHandleCountersMultiboardForPlayer(whichPlayer)
endif
static if (LIBRARY_PeriodicWatcherMultiboard) then
        call ShowPeriodicWatcherMultiboardForPlayer(whichPlayer)
endif
    endif
endfunction

private function EnumPlayersUpdateMultiboard takes nothing returns nothing
    call UpdateMultiboard(GetEnumPlayer())
endfunction

private function UpdateAllMultiboards takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumPlayersUpdateMultiboard)
endfunction

private function Multiboard takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    set currentMultiboard[playerId] = ModuloInteger(currentMultiboard[playerId] + 1, GetMax())
    
    call UpdateMultiboard(whichPlayer)
endfunction

private function MultiboardClickFunction takes nothing returns nothing
    call PlayClickSound(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzSendSyncData(PREFIX, "Multiboard")
    endif
    
    call RemoveActionsBarUIFocus(GetTriggerPlayer())
    call RemoveActionsBarUIFocusEx(MultiboardFrame, GetTriggerPlayer())
endfunction

private function CreateActionsBarUI takes nothing returns nothing
    // checkbox
    set CheckboxButton = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(CheckboxButton, FRAMEPOINT_TOPLEFT, UI_CHECKBOX_X, UI_Y)
    call BlzFrameSetAbsPoint(CheckboxButton, FRAMEPOINT_BOTTOMRIGHT, UI_CHECKBOX_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(CheckboxButton, true)
    call BlzFrameSetValue(CheckboxButton, 1.0)
    
    set CheckboxTooltip = BlzCreateFrameByType("TEXT", "CheckboxTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(CheckboxButton, CheckboxTooltip)
    call BlzFrameSetPoint(CheckboxTooltip, FRAMEPOINT_BOTTOM, CheckboxButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(CheckboxTooltip, false)
    call BlzFrameSetText(CheckboxTooltip, GetLocalizedString("TOGGLE_ACTION_BAR")) // Toggle action bar.

    set CheckboxCheckTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxCheckTrigger, CheckboxButton, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(CheckboxCheckTrigger, function CheckedFunction)
    
    set CheckboxUncheckTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxUncheckTrigger, CheckboxButton, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(CheckboxUncheckTrigger, function UncheckedFunction)

    // clear
    set ClearButton = BlzCreateFrameByType("BUTTON", "ClearButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(ClearButton, FRAMEPOINT_TOPLEFT, UI_CLEAR_X, UI_Y)
    call BlzFrameSetAbsPoint(ClearButton, FRAMEPOINT_BOTTOMRIGHT, UI_CLEAR_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(ClearButton, true)
    
    set ClearFrame = BlzCreateFrameByType("BACKDROP", "ClearFrame", ClearButton, "", 0)
    call BlzFrameSetAllPoints(ClearFrame, ClearButton)
    call BlzFrameSetTexture(ClearFrame, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true)
    call BlzFrameSetEnable(ClearFrame, true)
    
    set ClearTooltip = BlzCreateFrameByType("TEXT", "ClearTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(ClearButton, ClearTooltip)
    call BlzFrameSetPoint(ClearTooltip, FRAMEPOINT_BOTTOM, ClearButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(ClearTooltip, false)
    call BlzFrameSetText(ClearTooltip, GetLocalizedString("CLEAR_SCREEN_TEXT")) // Clear screen text.

    set ClearTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ClearTrigger, ClearButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ClearTrigger, function ClearClickFunction)

    // pickup items
    set PickupItemsButton = BlzCreateFrameByType("BUTTON", "PickupItemsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(PickupItemsButton, FRAMEPOINT_TOPLEFT, UI_PICKUP_ITEMS_X, UI_Y)
    call BlzFrameSetAbsPoint(PickupItemsButton, FRAMEPOINT_BOTTOMRIGHT, UI_PICKUP_ITEMS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(PickupItemsButton, true)
    
    set PickupItemsFrame = BlzCreateFrameByType("BACKDROP", "PickupItemsFrame", PickupItemsButton, "", 0)
    call BlzFrameSetAllPoints(PickupItemsFrame, PickupItemsButton)
    call BlzFrameSetTexture(PickupItemsFrame, "ReplaceableTextures\\CommandButtons\\BTNPickUpItem.blp", 0, true)
    call BlzFrameSetEnable(PickupItemsFrame, true)
    
    set PickupItemsTooltip = BlzCreateFrameByType("TEXT", "PickupItemsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(PickupItemsButton, PickupItemsTooltip)
    call BlzFrameSetPoint(PickupItemsTooltip, FRAMEPOINT_BOTTOM, PickupItemsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(PickupItemsTooltip, false)
    call BlzFrameSetText(PickupItemsTooltip, GetLocalizedString("PICKUP_ALL_ITEMS_NEARBY")) // Pick up all items nearby.

    set PickupItemsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PickupItemsTrigger, PickupItemsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PickupItemsTrigger, function PickupItemsClickFunction)
    
    // drop items
    set DropItemsButton = BlzCreateFrameByType("BUTTON", "PickupItemsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(DropItemsButton, FRAMEPOINT_TOPLEFT, UI_DROP_ITEMS_X, UI_Y)
    call BlzFrameSetAbsPoint(DropItemsButton, FRAMEPOINT_BOTTOMRIGHT, UI_DROP_ITEMS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(DropItemsButton, true)
    
    set DropItemsFrame = BlzCreateFrameByType("BACKDROP", "DropItemsFrame", DropItemsButton, "", 0)
    call BlzFrameSetAllPoints(DropItemsFrame, DropItemsButton)
    call BlzFrameSetTexture(DropItemsFrame, "ReplaceableTextures\\CommandButtons\\BTNUndeadUnLoad.blp", 0, true)
    call BlzFrameSetEnable(DropItemsFrame, true)
    
    set DropItemsTooltip = BlzCreateFrameByType("TEXT", "DropItemsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(DropItemsButton, DropItemsTooltip)
    call BlzFrameSetPoint(DropItemsTooltip, FRAMEPOINT_BOTTOM, DropItemsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(DropItemsTooltip, false)
    call BlzFrameSetText(DropItemsTooltip, GetLocalizedString("DROP_ALL_ITEMS_FROM_BACKPACK")) // Drop all items from backpack.

    set DropItemsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(DropItemsTrigger, DropItemsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(DropItemsTrigger, function DropItemsClickFunction)
    
    // backpack
    set BackpackButton = BlzCreateFrameByType("BUTTON", "BackpackButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(BackpackButton, FRAMEPOINT_TOPLEFT, UI_BACKPACK_X, UI_Y)
    call BlzFrameSetAbsPoint(BackpackButton, FRAMEPOINT_BOTTOMRIGHT, UI_BACKPACK_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(BackpackButton, true)
    
    set BackpackFrame = BlzCreateFrameByType("BACKDROP", "BackpackFrame", BackpackButton, "", 0)
    call BlzFrameSetAllPoints(BackpackFrame, BackpackButton)
    call BlzFrameSetTexture(BackpackFrame, "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Bag_09.blp", 0, true)
    call BlzFrameSetEnable(BackpackFrame, true)
    
    set BackpackTooltip = BlzCreateFrameByType("TEXT", "BackpackTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(BackpackButton, BackpackTooltip)
    call BlzFrameSetPoint(BackpackTooltip, FRAMEPOINT_BOTTOM, BackpackButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(BackpackTooltip, false)
    call BlzFrameSetText(BackpackTooltip, GetLocalizedString("DOT_BACKPACK_ITEMS")) // Backpack items.

    set BackpackTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BackpackTrigger, BackpackButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BackpackTrigger, function BackpackClickFunction)
    
    // mounts
    set MountsButton = BlzCreateFrameByType("BUTTON", "MountsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(MountsButton, FRAMEPOINT_TOPLEFT, UI_MOUNTS_X, UI_Y)
    call BlzFrameSetAbsPoint(MountsButton, FRAMEPOINT_BOTTOMRIGHT, UI_MOUNTS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(MountsButton, true)
    
    set MountsFrame = BlzCreateFrameByType("BACKDROP", "MountsFrame", MountsButton, "", 0)
    call BlzFrameSetAllPoints(MountsFrame, MountsButton)
    call BlzFrameSetTexture(MountsFrame, "ReplaceableTextures\\CommandButtons\\BTNGryphonRider.blp", 0, true)
    call BlzFrameSetEnable(MountsFrame, true)
    
    set MountsTooltip = BlzCreateFrameByType("TEXT", "MountsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(MountsButton, MountsTooltip)
    call BlzFrameSetPoint(MountsTooltip, FRAMEPOINT_BOTTOM, MountsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(MountsTooltip, false)
    call BlzFrameSetText(MountsTooltip, GetLocalizedString("DOT_MOUNTS")) // Mounts.

    set MountsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(MountsTrigger, MountsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(MountsTrigger, function MountsClickFunction)
    
    // summoned units
    set SummonedUnitsButton = BlzCreateFrameByType("BUTTON", "SummonedUnitsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(SummonedUnitsButton, FRAMEPOINT_TOPLEFT, UI_SUMMONED_UNITS_X, UI_Y)
    call BlzFrameSetAbsPoint(SummonedUnitsButton, FRAMEPOINT_BOTTOMRIGHT, UI_SUMMONED_UNITS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(SummonedUnitsButton, true)
    
    set SummonedUnitsFrame = BlzCreateFrameByType("BACKDROP", "SummonedUnitsFrame", SummonedUnitsButton, "", 0)
    call BlzFrameSetAllPoints(SummonedUnitsFrame, SummonedUnitsButton)
    call BlzFrameSetTexture(SummonedUnitsFrame, "ReplaceableTextures\\CommandButtons\\BTNSummonWaterElemental.blp", 0, true)
    call BlzFrameSetEnable(SummonedUnitsFrame, true)
    
    set SummonedUnitsTooltip = BlzCreateFrameByType("TEXT", "SummonedUnitsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(SummonedUnitsButton, SummonedUnitsTooltip)
    call BlzFrameSetPoint(SummonedUnitsTooltip, FRAMEPOINT_BOTTOM, SummonedUnitsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(SummonedUnitsTooltip, false)
    call BlzFrameSetText(SummonedUnitsTooltip, GetLocalizedString("DOT_SUMMONED_UNITS")) // Summoned units.

    set SummonedUnitsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SummonedUnitsTrigger, SummonedUnitsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SummonedUnitsTrigger, function SummonedUnitsClickFunction)
    
    // town halls
    set TownHallsButton = BlzCreateFrameByType("BUTTON", "TownHallsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(TownHallsButton, FRAMEPOINT_TOPLEFT, UI_TOWN_HALLS_X, UI_Y)
    call BlzFrameSetAbsPoint(TownHallsButton, FRAMEPOINT_BOTTOMRIGHT, UI_TOWN_HALLS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(TownHallsButton, true)
    
    set TownHallsFrame = BlzCreateFrameByType("BACKDROP", "TownHallsFrame", TownHallsButton, "", 0)
    call BlzFrameSetAllPoints(TownHallsFrame, TownHallsButton)
    call BlzFrameSetTexture(TownHallsFrame, "ReplaceableTextures\\CommandButtons\\BTNCastle.blp", 0, true)
    call BlzFrameSetEnable(TownHallsFrame, true)
    
    set TownHallsTooltip = BlzCreateFrameByType("TEXT", "TownHallsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(TownHallsButton, TownHallsTooltip)
    call BlzFrameSetPoint(TownHallsTooltip, FRAMEPOINT_BOTTOM, TownHallsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(TownHallsTooltip, false)
    call BlzFrameSetText(TownHallsTooltip, GetLocalizedString("DOT_TOWN_HALLS")) // Town Halls.

    set TownHallsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(TownHallsTrigger, TownHallsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(TownHallsTrigger, function TownHallsClickFunction)
    
    // altars
    set AltarsButton = BlzCreateFrameByType("BUTTON", "AltarsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(AltarsButton, FRAMEPOINT_TOPLEFT, UI_ALTARS_X, UI_Y)
    call BlzFrameSetAbsPoint(AltarsButton, FRAMEPOINT_BOTTOMRIGHT, UI_ALTARS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(AltarsButton, true)
    
    set AltarsFrame = BlzCreateFrameByType("BACKDROP", "AltarsFrame", AltarsButton, "", 0)
    call BlzFrameSetAllPoints(AltarsFrame, AltarsButton)
    call BlzFrameSetTexture(AltarsFrame, "ReplaceableTextures\\CommandButtons\\BTNAltarOfKings.blp", 0, true)
    call BlzFrameSetEnable(AltarsFrame, true)
    
    set AltarsTooltip = BlzCreateFrameByType("TEXT", "TownHallsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(AltarsButton, AltarsTooltip)
    call BlzFrameSetPoint(AltarsTooltip, FRAMEPOINT_BOTTOM, AltarsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(AltarsTooltip, false)
    call BlzFrameSetText(AltarsTooltip, GetLocalizedString("DOT_ALTARS")) // Altars.

    set AltarsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(AltarsTrigger, AltarsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(AltarsTrigger, function AltarsClickFunction)
    
    // save codes
    set SaveCodesButton = BlzCreateFrameByType("BUTTON", "SaveCodesButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(SaveCodesButton, FRAMEPOINT_TOPLEFT, UI_SAVECODES_X, UI_Y)
    call BlzFrameSetAbsPoint(SaveCodesButton, FRAMEPOINT_BOTTOMRIGHT, UI_SAVECODES_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(SaveCodesButton, true)
    
    set SaveCodesFrame = BlzCreateFrameByType("BACKDROP", "SaveCodesFrame", SaveCodesButton, "", 0)
    call BlzFrameSetAllPoints(SaveCodesFrame, SaveCodesButton)
    call BlzFrameSetTexture(SaveCodesFrame, "ReplaceableTextures\\CommandButtons\\BTNIconSave.blp", 0, true)
    call BlzFrameSetEnable(SaveCodesFrame, true)
    
    set SaveCodesTooltip = BlzCreateFrameByType("TEXT", "SaveCodesTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(SaveCodesButton, SaveCodesTooltip)
    call BlzFrameSetPoint(SaveCodesTooltip, FRAMEPOINT_BOTTOM, SaveCodesButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(SaveCodesTooltip, false)
    call BlzFrameSetText(SaveCodesTooltip, GetLocalizedString("DOT_SAVE_CODES")) // Save Codes

    set SaveCodesTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodesTrigger, SaveCodesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodesTrigger, function SaveCodesClickFunction)
    
    // auto skill
    set AutoSkillButton = BlzCreateFrameByType("BUTTON", "AutoSkillButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(AutoSkillButton, FRAMEPOINT_TOPLEFT, UI_AUTO_SKILL_X, UI_Y)
    call BlzFrameSetAbsPoint(AutoSkillButton, FRAMEPOINT_BOTTOMRIGHT, UI_AUTO_SKILL_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(AutoSkillButton, true)
    
    set AutoSkillFrame = BlzCreateFrameByType("BACKDROP", "AutoSkillFrame", AutoSkillButton, "", 0)
    call BlzFrameSetAllPoints(AutoSkillFrame, AutoSkillButton)
    call BlzFrameSetTexture(AutoSkillFrame, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0, true)
    call BlzFrameSetEnable(AutoSkillFrame, true)
    
    set AutoSkillTooltip = BlzCreateFrameByType("TEXT", "AutoSkillTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(AutoSkillButton, AutoSkillTooltip)
    call BlzFrameSetPoint(AutoSkillTooltip, FRAMEPOINT_BOTTOM, AutoSkillButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(AutoSkillTooltip, false)
    call BlzFrameSetText(AutoSkillTooltip, GetLocalizedString("DOT_AUTO_SKILL")) // Auto skill.

    set AutoSkillTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(AutoSkillTrigger, AutoSkillButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(AutoSkillTrigger, function AutoSkillClickFunction)
    
    // log
    set LogButton = BlzCreateFrameByType("BUTTON", "LogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(LogButton, FRAMEPOINT_TOPLEFT, UI_LOG_X, UI_Y)
    call BlzFrameSetAbsPoint(LogButton, FRAMEPOINT_BOTTOMRIGHT, UI_LOG_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(LogButton, true)
    
    set LogFrame = BlzCreateFrameByType("BACKDROP", "LogFrame", LogButton, "", 0)
    call BlzFrameSetAllPoints(LogFrame, LogButton)
    call BlzFrameSetTexture(LogFrame, "ReplaceableTextures\\CommandButtons\\BTNSpy.blp", 0, true)
    call BlzFrameSetEnable(LogFrame, true)
    
    set LogTooltip = BlzCreateFrameByType("TEXT", "LogTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(LogButton, LogTooltip)
    call BlzFrameSetPoint(LogTooltip, FRAMEPOINT_BOTTOM, LogButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(LogTooltip, false)
    call BlzFrameSetText(LogTooltip, GetLocalizedString("DOT_MULTIPLAYER_LOG")) // Multiplayer Log.

    set LogTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LogTrigger, LogButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LogTrigger, function LogClickFunction)
    
    // damage calculation table
    set DctButton = BlzCreateFrameByType("BUTTON", "DctButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(DctButton, FRAMEPOINT_TOPLEFT, UI_DCT_X, UI_Y)
    call BlzFrameSetAbsPoint(DctButton, FRAMEPOINT_BOTTOMRIGHT, UI_DCT_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(DctButton, true)
    
    set DctFrame = BlzCreateFrameByType("BACKDROP", "DctFrame", DctButton, "", 0)
    call BlzFrameSetAllPoints(DctFrame, DctButton)
    call BlzFrameSetTexture(DctFrame, "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp", 0, true)
    call BlzFrameSetEnable(DctFrame, true)
    
    set DctTooltip = BlzCreateFrameByType("TEXT", "DctTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(DctButton, DctTooltip)
    call BlzFrameSetPoint(DctTooltip, FRAMEPOINT_BOTTOM, DctButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(DctTooltip, false)
    call BlzFrameSetText(DctTooltip, GetLocalizedString("DOT_DAMAGE_CALCULATION_TABLE")) // Damage Calculation Table.

    set LogTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LogTrigger, DctButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LogTrigger, function DctClickFunction)
    
    // diplomacy
    set DiplomacyButton = BlzCreateFrameByType("BUTTON", "DiplomacyButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(DiplomacyButton, FRAMEPOINT_TOPLEFT, UI_DIPLOMACY_X, UI_Y)
    call BlzFrameSetAbsPoint(DiplomacyButton, FRAMEPOINT_BOTTOMRIGHT, UI_DIPLOMACY_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(DiplomacyButton, true)
    
    set DiplomacyFrame = BlzCreateFrameByType("BACKDROP", "DiplomacyFrame", DiplomacyButton, "", 0)
    call BlzFrameSetAllPoints(DiplomacyFrame, DiplomacyButton)
    call BlzFrameSetTexture(DiplomacyFrame, "ReplaceableTextures\\CommandButtons\\BTNStaffOfPreservation.blp", 0, true)
    call BlzFrameSetEnable(DiplomacyFrame, true)
    
    set DiplomacyTooltip = BlzCreateFrameByType("TEXT", "DiplomacyTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(DiplomacyButton, DiplomacyTooltip)
    call BlzFrameSetPoint(DiplomacyTooltip, FRAMEPOINT_BOTTOM, DiplomacyButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(DiplomacyTooltip, false)
    call BlzFrameSetText(DiplomacyTooltip, GetLocalizedString("DOT_DIPLOMACY")) // Diplomacy.

    set DiplomacyTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(DiplomacyTrigger, DiplomacyButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(DiplomacyTrigger, function DiplomacyClickFunction)
    
    // settings
    set SettingsButton = BlzCreateFrameByType("BUTTON", "SettingsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(SettingsButton, FRAMEPOINT_TOPLEFT, UI_SETTINGS_X, UI_Y)
    call BlzFrameSetAbsPoint(SettingsButton, FRAMEPOINT_BOTTOMRIGHT, UI_SETTINGS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(SettingsButton, true)
    
    set SettingsFrame = BlzCreateFrameByType("BACKDROP", "SettingsFrame", SettingsButton, "", 0)
    call BlzFrameSetAllPoints(SettingsFrame, SettingsButton)
    call BlzFrameSetTexture(SettingsFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-loop.blp", 0, true)
    call BlzFrameSetEnable(SettingsFrame, true)
    
    set SettingsTooltip = BlzCreateFrameByType("TEXT", "SettingsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(SettingsButton, SettingsTooltip)
    call BlzFrameSetPoint(SettingsTooltip, FRAMEPOINT_BOTTOM, SettingsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(SettingsTooltip, false)
    call BlzFrameSetText(SettingsTooltip, GetLocalizedString("DOT_SETTINGS")) // Settings.

    set SettingsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SettingsTrigger, SettingsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SettingsTrigger, function SettingsClickFunction)
    
    // news
    set NewsButton = BlzCreateFrameByType("BUTTON", "NewsButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(NewsButton, FRAMEPOINT_TOPLEFT, UI_NEWS_X, UI_Y)
    call BlzFrameSetAbsPoint(NewsButton, FRAMEPOINT_BOTTOMRIGHT, UI_NEWS_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(NewsButton, true)
    
    set NewsFrame = BlzCreateFrameByType("BACKDROP", "NewsFrame", LogButton, "", 0)
    call BlzFrameSetAllPoints(NewsFrame, NewsButton)
    call BlzFrameSetTexture(NewsFrame, "ReplaceableTextures\\CommandButtons\\BTNINV_Letter_03.blp", 0, true)
    call BlzFrameSetEnable(NewsFrame, true)
    
    set NewsTooltip = BlzCreateFrameByType("TEXT", "NewsTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(NewsButton, NewsTooltip)
    call BlzFrameSetPoint(NewsTooltip, FRAMEPOINT_BOTTOM, NewsButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(NewsTooltip, false)
    call BlzFrameSetText(NewsTooltip, GetLocalizedString("DOT_NEWS")) // News.

    set NewsTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(NewsTrigger, NewsButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(NewsTrigger, function NewsClickFunction)
    
    // multiboards
    set MultiboardButton = BlzCreateFrameByType("BUTTON", "MultiboardButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(MultiboardButton, FRAMEPOINT_TOPLEFT, UI_MULTIBOARD_X, UI_Y)
    call BlzFrameSetAbsPoint(MultiboardButton, FRAMEPOINT_BOTTOMRIGHT, UI_MULTIBOARD_X + UI_BUTTON_SIZE, UI_Y - UI_BUTTON_SIZE)
    call BlzFrameSetEnable(MultiboardButton, true)
    
    set MultiboardFrame = BlzCreateFrameByType("BACKDROP", "MultiboardFrame", MultiboardButton, "", 0)
    call BlzFrameSetAllPoints(MultiboardFrame, MultiboardButton)
    call BlzFrameSetTexture(MultiboardFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-Play.blp", 0, true)
    call BlzFrameSetEnable(MultiboardFrame, true)
    
    set MultiboardTooltip = BlzCreateFrameByType("TEXT", "BlzFrameSetTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(MultiboardButton, MultiboardTooltip)
    call BlzFrameSetPoint(MultiboardTooltip, FRAMEPOINT_BOTTOM, MultiboardButton, FRAMEPOINT_TOP, 0, 0.01)
    call BlzFrameSetEnable(MultiboardTooltip, false)
    call BlzFrameSetText(MultiboardTooltip, GetLocalizedString("DOT_TOGGLE_MULTIBOARDS")) // Toggle multiboards.

    set MultiboardTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(MultiboardTrigger, MultiboardButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(MultiboardTrigger, function MultiboardClickFunction)
   
    call SetActionsBarUIVisible(true, true)
    //call BlzFrameSetVisible(CheckboxButton, true)
endfunction

private function TriggerActionSync takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    local string data = BlzGetTriggerSyncData()
    //! runtextmacro optional Trace("ActionsBarSync " + data + " from player " + GetPlayerName(GetTriggerPlayer()))
    if (data == "Checked") then
        set checked[playerId] = true
        if (GetTriggerPlayer() == GetLocalPlayer()) then
            call SetActionsBarUIVisible(false, false)
        endif
    elseif (data == "Unchecked") then
        set checked[playerId] = false
        if (GetTriggerPlayer() == GetLocalPlayer()) then
            call SetActionsBarUIVisible(true, true)
        endif
    elseif (data == "PickupItems") then
        call PickupAllItemsAroundByPlayer(GetTriggerPlayer())
    elseif (data == "DropBackpack") then
        call DropAllItemsFromBackpack(GetTriggerPlayer())
    elseif (data == "Backpack") then            
        if (GetPlayerBackpack(GetTriggerPlayer()) != null) then
            call SelectUnitForPlayerSingle(GetPlayerBackpack(GetTriggerPlayer()), GetTriggerPlayer())
            call ShowBackpackUI(GetTriggerPlayer())
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("DOT_NO_BACKPACK")) // No backpack.
        endif
    elseif (data == "Mount") then
        call SelectNextMount(GetTriggerPlayer())
    elseif (data == "SummonedUnit") then
        call SelectNextSummonedUnit(GetTriggerPlayer())
    elseif (data == "TownHall") then
        call SelectNextTownHall(GetTriggerPlayer())
    elseif (data == "Altar") then
       call SelectNextAltar(GetTriggerPlayer())
    elseif (data == "SaveCodes") then
        call ShowSaveCodeUI(GetTriggerPlayer())
    elseif (data == "AutoSkill") then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call AutoSkillHero(GetPlayerHero1(GetTriggerPlayer()))
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("DOT_NO_HERO_1")) // No hero 1.
        endif
    elseif (data == "Log") then
        call ShowLogUIForPlayer(GetTriggerPlayer())
    elseif (data == "Dct") then
        call ShowDamageCalculationTableUIForPlayer(GetTriggerPlayer())
    elseif (data == "Diplomacy") then
        if (GetTriggerPlayer() == GetHost()) then
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call ShowDiplomacyUI()
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedString("HOST_DIPLOMACY")) // You must be host to configure diplomacy.
        endif
    elseif (data == "Settings") then
        if (GetLocalPlayer() == GetTriggerPlayer()) then
            call ShowSettingsUI()
        endif
    elseif (data == "News") then
        if (GetLocalPlayer() == GetTriggerPlayer()) then
            call ShowNewsUI()
        endif
    elseif (data == "Multiboard") then
        call Multiboard(GetTriggerPlayer())
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyPlayerSyncEvent(SyncTrigger, PREFIX, false)
    call TriggerAddAction(SyncTrigger, function TriggerActionSync)
    
    call OnStartGame(function CreateActionsBarUI)
    
static if LIBRARY_FrameLoader then
    call FrameLoaderAdd(function CreateActionsBarUI)
    call FrameLoaderAdd(function UpdateAllMultiboards)
    call FrameLoaderAdd(function UpdateAllActionBars)
endif
endfunction

endlibrary
