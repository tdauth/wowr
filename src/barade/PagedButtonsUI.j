library PagedButtonsUI initializer Init requires FrameLoader, FrameSaver, ItemTypeUtils, OnStartGame, StringFormat, PagedButtons, optional PagedButtonsConfig

globals
    // Specifies if it is enabled by default for all players.
    public constant boolean ENABLED_BY_DEFAULT = false
    // Specifies if a charge number is shown which indicates the slot's page.
    public constant boolean SHOW_PAGE_NUMBERS = false
    // Specifies if preview registered models for IDs are shown below the tooltip.
    public constant boolean SHOW_PREVIEW_MODELS = false
    public constant integer MAX_SLOTS = 130
    public constant integer MAX_SLOTS_PER_LINE = 13
    public constant integer HERO_GOLD_COST = 0
    public constant integer HERO_LUMBER_COST = 0
    
    public constant boolean LOAD_TOC_FILE = false
    public constant string TOC_FILE = "war3mapImported\\PagedButtonsUITOC.toc"
    
    public constant string PREFIX = "PagedButtonsUI"
    public constant real X = 0.0
    public constant real Y = 0.57
    public constant real SIZE_X = 0.80
    public constant real SIZE_Y = 0.42
    public constant real TITLE_Y = 0.543
    public constant real TITLE_HEIGHT = 0.1
    public constant real BUTTON_X = 0.032
    public constant real BUTTON_Y = 0.53
    public constant real BUTTON_SIZE = 0.02818
    public constant real CHARGES_BACKGROUND_SIZE = 0.011
    public constant real CHARGES_POS = 0.003
    public constant real CHARGES_SIZE = 0.02
    public constant real BUTTON_SPACE = 0.005
    
    public constant real TOOLTIP_FRAME_X = 0.46
    public constant real TOOLTIP_FRAME_Y = 0.55
    public constant real TOOLTIP_FRAME_WIDTH = 0.32
    public constant real TOOLTIP_FRAME_HEIGHT = 0.386
    
    public constant real TOOLTIP_HORIZONTAL_SPACING = 0.03
    public constant real TOOLTIP_X = TOOLTIP_FRAME_X + TOOLTIP_HORIZONTAL_SPACING

    public constant real TOOLTIP_ICON_X = TOOLTIP_X
    public constant real TOOLTIP_ICON_Y = 0.52
    public constant real TOOLTIP_ICON_SIZE = 0.034
    
    public constant real TOOLTIP_PAGE_NAME_X = TOOLTIP_ICON_X + TOOLTIP_ICON_SIZE + 0.003
    public constant real TOOLTIP_PAGE_NAME_Y = 0.52
    public constant real TOOLTIP_PAGE_NAME_WIDTH = 0.1
    public constant real TOOLTIP_PAGE_NAME_HEIGHT = 0.011
    
    public constant real VERTICAL_SPACE = 0.0004
    
    public constant real SUMMON_X = TOOLTIP_PAGE_NAME_X
    public constant real SUMMON_Y = TOOLTIP_PAGE_NAME_Y - TOOLTIP_PAGE_NAME_HEIGHT - VERTICAL_SPACE
    public constant real SUMMON_HEIGHT = 0.011
    
    public constant real COST_SPACE = 0.009
    public constant real COST_ICON_SPACE = 0.003
    
    public constant real COST_X = SUMMON_X
    public constant real COST_Y = SUMMON_Y - SUMMON_HEIGHT - VERTICAL_SPACE
    public constant real COST_HEIGHT = 0.011
    public constant real COST_ICON_SIZE = 0.01
    public constant real COST_GOLD_X = COST_X + COST_ICON_SIZE + COST_ICON_SPACE
    public constant real COST_WIDTH = 0.03
    
    public constant real COST_ICON_LUMBER_X = COST_GOLD_X + COST_WIDTH + COST_SPACE
    public constant real COST_LUMBER_X = COST_ICON_LUMBER_X + COST_ICON_SIZE + COST_ICON_SPACE
    public constant real COST_ICON_FOOD_X = COST_LUMBER_X + COST_WIDTH + COST_SPACE
    public constant real COST_FOOD_X = COST_ICON_FOOD_X + COST_ICON_SIZE + COST_ICON_SPACE
    
    public constant real TOOLTIP_WIDTH = TOOLTIP_FRAME_WIDTH - 2.0 * TOOLTIP_HORIZONTAL_SPACING
    public constant real TOOLTIP_Y = COST_Y - COST_HEIGHT - BUTTON_SPACE
    public constant real TOOLTIP_HEIGHT = 0.29
    public constant real TOOLTIP_FONT_HEIGHT = 0.008
    
    public constant real PREVIEW_X = TOOLTIP_X + 0.05
    public constant real PREVIEW_Y = TOOLTIP_FRAME_Y - TOOLTIP_HEIGHT + 0.03
    public constant real PREVIEW_WIDTH = TOOLTIP_WIDTH
    public constant real PREVIEW_HEIGHT = 0.02
    
    public constant real NEXT_PAGE_BUTTON_X = 0.18
    public constant real PREVIOUS_PAGE_BUTTON_X = 0.06
    public constant real PAGE_BUTTON_WIDTH = 0.12
    
    public constant real CHECKBOX_X = 0.032
    public constant real CHECKBOX_SIZE = 0.026
    
    public constant real CLOSE_BUTTON_X = 0.34
    public constant real BOTTOM_BUTTONS_Y = 0.203
    public constant real CLOSE_BUTTON_WIDTH = 0.12
    public constant real CLOSE_BUTTON_HEIGHT = 0.03
    
    // player data
    private boolean array enabledForPlayer
    private boolean array UIVisible
    private unit array UIShop
    private integer array PagesIndex
    private boolean array checked
    // static if (SHOW_PREVIEW_MODELS) then
    private real array previewModelX
    private real array previewModelY
    private real array previewModelScale
    private string array previewModelFile
    //endif
    
    private framehandle BackgroundFrame
    private framehandle TitleFrame
    private framehandle array SlotFrame
    private framehandle array SlotBackdropFrame
    private framehandle array SlotChargesBackgroundFrame
    private framehandle array SlotChargesFrame
    private framehandle array SlotPageBackgroundFrame
    private framehandle array SlotPageFrame
    private trigger array SlotClickTrigger
    private trigger array SlotTooltipOnTrigger
    private trigger array SlotTooltipOffTrigger
    private framehandle TooltipFrame
    private framehandle PageNameText
    private framehandle TooltipIcon
    private framehandle SummonFrame
    private framehandle ItemGoldFrame
    private framehandle ItemGoldIconFrame
    private framehandle ItemLumberFrame
    private framehandle ItemLumberIconFrame
    private framehandle ItemFoodFrame
    private framehandle ItemFoodIconFrame
    private framehandle TooltipText
    private framehandle PreviewSprite = null
    private effect PreviewEffect = null
    private framehandle NextPagesButton
    private trigger NextPagesTrigger = null
    private framehandle PreviousPagesButton
    private trigger PreviousPagesTrigger = null
    private framehandle Checkbox
    private trigger CheckedTrigger = null
    private trigger UncheckedTrigger = null
    private framehandle CloseButton
    private trigger CloseTrigger = null
    
    private hashtable h = InitHashtable()
    private trigger syncTrigger = CreateTrigger()
    private trigger selectionTrigger = CreateTrigger()
    private trigger changePageButtonsTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
endglobals

static if (SHOW_PREVIEW_MODELS) then
private function ResetPreviewFrame takes nothing returns nothing
    set PreviewSprite = null
endfunction

private function RefreshPreviewFrame takes nothing returns nothing
    if (PreviewSprite != null) then
        call BlzDestroyFrame(PreviewSprite)
        set PreviewSprite = null
    endif
    set PreviewSprite = BlzCreateFrameByType("SPRITE", "PagedButtonsUIPreviewSprite", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
endfunction

private function RefreshPreviewFrameForPlayerOnly takes real x, real y, real modelScale, string modelPath returns nothing
    call BlzFrameSetAbsPoint(PreviewSprite, FRAMEPOINT_CENTER, x, y)
    //call BlzFrameSetModel(PreviewSprite, modelPath, 0)
    //call BlzFrameSetModel(PreviewSprite, modelPath, 1) // works for item models
    call BlzFrameSetModel(PreviewSprite, modelPath, 1) // works for item models
    call BlzFrameSetSpriteAnimate(PreviewSprite, 2, 0) // Stand
    call BlzFrameSetScale(PreviewSprite, modelScale)
    call BlzFrameSetVisible(PreviewSprite, true)
endfunction
endif

function SetPagedButtonsUIEnabledForPlayer takes player whichPlayer, boolean enabled returns nothing
    set enabledForPlayer[GetPlayerId(whichPlayer)] = enabled
endfunction

function IsPagedButtonsUIEnabledForPlayer takes player whichPlayer returns boolean
    return enabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

private function GetButtonSlotIcon takes unit shop, integer index returns string
    return BlzGetAbilityIcon(GetPagedButtonId(shop, index))
endfunction

private function GetMaxPageIndex takes integer playerId returns integer
     return GetPagedButtonsNonSpacerButtonsCount(UIShop[playerId]) / MAX_SLOTS
endfunction

private function SetSlotChargesVisible takes integer i, boolean visible returns nothing
    call BlzFrameSetVisible(SlotChargesBackgroundFrame[i], visible)
    call BlzFrameSetVisible(SlotChargesFrame[i], visible)
endfunction

private function SetTooltipVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(TooltipIcon, visible)
    call BlzFrameSetVisible(PageNameText, visible)
    call BlzFrameSetVisible(SummonFrame, visible)
    call BlzFrameSetVisible(TooltipText, visible)
    call BlzFrameSetVisible(ItemGoldFrame, visible)
    call BlzFrameSetVisible(ItemGoldIconFrame, visible)
    call BlzFrameSetVisible(ItemLumberFrame, visible)
    call BlzFrameSetVisible(ItemLumberIconFrame, visible)
    call BlzFrameSetVisible(ItemFoodFrame, visible)
    call BlzFrameSetVisible(ItemFoodIconFrame, visible)
static if (SHOW_PREVIEW_MODELS) then
    call BlzFrameSetVisible(PreviewSprite, visible)
endif
endfunction

private function SetVisible takes boolean visible returns nothing
    call BlzFrameSetVisible(BackgroundFrame, visible)
    call BlzFrameSetVisible(TitleFrame, visible)
    call BlzFrameSetVisible(Checkbox, visible)
    
    call SetTooltipVisible(visible)
endfunction

private function SetSlotVisible takes integer i, boolean visible returns nothing
    call BlzFrameSetVisible(SlotFrame[i], visible)
    call BlzFrameSetVisible(SlotBackdropFrame[i], visible)
    call BlzFrameSetVisible(SlotPageBackgroundFrame[i], visible)
    call BlzFrameSetVisible(SlotPageFrame[i], visible)
    if (visible) then
        set visible = checked[GetPlayerId(GetLocalPlayer())]
    endif
    call SetSlotChargesVisible(i, visible)
endfunction

private function SetAllSlotChargesVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
    local integer i = 0
    loop
        exitwhen (i >= MAX_SLOTS)
        if (whichPlayer == GetLocalPlayer()) then
            if (BlzFrameIsVisible(SlotFrame[i])) then
                call SetSlotChargesVisible(i, visible)
            endif
        endif
        set i = i + 1
    endloop
endfunction

private function UpdateItemsForUI takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer objectId = 0
    local integer i = 0
    local unit shop = UIShop[playerId]
    local integer slot = 0
    local integer nonSpacerSlots = 0
    local integer startSlot = PagesIndex[playerId] * MAX_SLOTS
    local integer maxSlots = GetPagedButtonsCount(shop)
    local integer page = GetPagedButtonsPage(shop)
    local string pageName = GetPagedButtonsPageName(shop, page)
    local integer maxPageIndex = GetMaxPageIndex(playerId)
    local integer handleId = 0
    if (pageName == null or StringLength(pageName) == 0) then
        set pageName = GetUnitName(shop)
    endif
    if (maxPageIndex > 0) then
        set pageName = Format(GetLocalizedString("PAGE_NAME")).s(pageName).i(PagesIndex[playerId] + 1).i(maxPageIndex + 1).result()
        if (whichPlayer == GetLocalPlayer()) then
            call BlzFrameSetVisible(NextPagesButton, true)
            call BlzFrameSetVisible(PreviousPagesButton, true)
        endif
    else
        if (whichPlayer == GetLocalPlayer()) then
            call BlzFrameSetVisible(NextPagesButton, false)
            call BlzFrameSetVisible(PreviousPagesButton, false)
        endif
    endif
    //call BJDebugMsg("max page index " + I2S(maxPageIndex))
    // set UIShop[playerId] = shop
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetText(TitleFrame, pageName)
    endif
    loop
        exitwhen (slot >= maxSlots or i >= MAX_SLOTS)
        if (not IsPagedButtonSpacer(shop, slot)) then
            set nonSpacerSlots = nonSpacerSlots + 1
            if (nonSpacerSlots > startSlot) then
                set objectId = GetPagedButtonId(shop, slot)
                if (UIVisible[playerId]) then //  and GetItemCharges(index) > 0
                    if (whichPlayer == GetLocalPlayer()) then
                        call BlzFrameSetTexture(SlotBackdropFrame[i], BlzGetAbilityIcon(objectId), 0, true)
                        call BlzFrameSetText(SlotChargesFrame[i], "1") // I2S(GetItemCharges(index))
                        call BlzFrameSetText(SlotPageFrame[i], I2S(GetPagedButtonsPageByIndex(shop, slot) + 1))
                        call BlzFrameSetVisible(SlotChargesBackgroundFrame[i], checked[playerId])
                        call BlzFrameSetVisible(SlotChargesFrame[i], checked[playerId])
static if (SHOW_PAGE_NUMBERS) then
                        call BlzFrameSetVisible(SlotPageBackgroundFrame[i], checked[playerId])
                        call BlzFrameSetVisible(SlotPageFrame[i], checked[playerId])
endif
                        call BlzFrameSetVisible(SlotFrame[i], true)
                        call BlzFrameSetVisible(SlotBackdropFrame[i], true)
                    endif
                endif
                
                set handleId = GetHandleId(SlotClickTrigger[i])
                call SaveInteger(h, handleId, 0, slot)
                set handleId = GetHandleId(SlotTooltipOnTrigger[i])
                call SaveInteger(h, handleId, 0, slot)
                set handleId = GetHandleId(SlotTooltipOffTrigger[i])
                call SaveInteger(h, handleId, 0, slot)
                
                set i = i + 1
            endif
        endif
        
        set slot = slot + 1
    endloop
    
    loop
        exitwhen (i >= MAX_SLOTS)
        if (whichPlayer == GetLocalPlayer()) then
            call SetSlotVisible(i, false)
        endif
        set i = i + 1
    endloop

endfunction

private function UIExists takes nothing returns boolean
    return BackgroundFrame != null
endfunction

private function GetPagesIndexFromPagedButtonsShopEx takes unit shop returns integer
    local integer currentPage = GetPagedButtonsPage(shop)
    local integer i = 0
    local integer max = GetPagedButtonsCount(shop)
    local integer countNonSpacerButtons = 0
    loop
        exitwhen (i >= max)
        if (GetPagedButtonsPageByIndex(shop, i) >= currentPage) then
            return countNonSpacerButtons / MAX_SLOTS
        endif
        
        if (not IsPagedButtonSpacer(shop, i)) then
            set countNonSpacerButtons = countNonSpacerButtons + 1
        endif
        set i = i + 1
    endloop
    return 0
endfunction

private function GetPagesIndexFromPagedButtonsShop takes unit shop returns integer
    if (HasPagedButtons(shop)) then
        return GetPagesIndexFromPagedButtonsShopEx(shop)
    endif
    return 0
endfunction

function ShowPagedButtonsUI takes player whichPlayer, unit shop returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    if (not UIExists()) then
        return
    endif
    set UIVisible[playerId] = true
    set UIShop[playerId] = shop
    set PagesIndex[playerId] = GetPagesIndexFromPagedButtonsShop(shop)
    call UpdateItemsForUI(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call SetVisible(true)
        call SetTooltipVisible(false)
    endif
endfunction

private function HidePagedButtonsUISlots takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == MAX_SLOTS)
        call SetSlotVisible(i, false)
        set i = i + 1
    endloop
endfunction

function HidePagedButtonsUI takes nothing returns nothing
    call SetVisible(false)
    call HidePagedButtonsUISlots()
endfunction

function HidePagedButtonsUIForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer index = 0
    if (not UIExists()) then
        return
    endif
    set UIVisible[playerId] = false
    set UIShop[playerId] = null
    set PagesIndex[playerId] = 0
static if (SHOW_PREVIEW_MODELS) then
    set previewModelX[playerId] = 0.0
    set previewModelY[playerId] = 0.0
    set previewModelScale[playerId] = 0.0
    set previewModelFile[playerId] = ""
endif
    if (whichPlayer == GetLocalPlayer()) then
        call SetVisible(false)
    endif
    set i = 0
    loop
        exitwhen (i == MAX_SLOTS)
        if (whichPlayer == GetLocalPlayer()) then
            call SetSlotVisible(i, false)
        endif
        set i = i + 1
    endloop
endfunction

private function ClickItemFunction takes nothing returns nothing
    local integer handleId = GetHandleId(GetTriggeringTrigger())
    local integer slot = LoadInteger(h, handleId, 0)
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, I2S(slot))
    endif
endfunction

private function CompareReals takes real a, real b returns boolean
     return a >= b and a <= b
endfunction

/**
 * Returns the token at the given index for the given source using the given separator.
 * Returns null if it has reached the end of the string without finding the requested token.
 * Returns an empty string or non-empty string if the requested token was found.
 */
private function StringSplit takes string source, integer index, string separator returns string
    local string result = null
    local integer currentIndex = 0
    local integer separatorLength = StringLength(separator)
    local integer length = StringLength(source)
    local integer i = 0
    loop
        exitwhen (i == length or currentIndex > index)
        if (SubString(source, i, i + separatorLength) == separator) then
            if (currentIndex == index and result == null) then
                set result = ""
            endif
            set currentIndex = currentIndex + 1
            set i = i + separatorLength
        else
            if (currentIndex == index) then
                if (result == null) then
                    set result = ""
                endif
                set result = result + SubString(source, i, i + 1)
            endif
            set i = i + 1
        endif
    endloop

    return result
endfunction

private function SetTextAreaText takes framehandle f, string text returns nothing
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

private function EnterItemFunction takes nothing returns nothing
    local integer handleId = GetHandleId(GetTriggeringTrigger())
    local integer slot = LoadInteger(h, handleId, 0)
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    local unit shop = UIShop[playerId]
    local integer id = GetPagedButtonId(shop, slot)
    local integer page = GetPagedButtonsPageByIndex(shop, slot)
    local string pageName = ""
    local string tooltip = ""
    local integer goldCost = 0
    local integer lumberCost = 0
    local integer foodCost = 0
    local string summonText = ""
    local real modelX = 0.0
    local real modelY = 0.0
    local real modelScale = 0.0
    local string modelPath = ""
static if (LIBRARY_PagedButtonsConfig) then
    local PagedButtonsConfig c = GetPagedButtonsConfig(id)
endif
    if (slot >= 0 and slot < GetPagedButtonsCount(shop)) then
        set pageName = GetPagedButtonsPageName(shop, page)
        set summonText = BlzGetAbilityTooltip(id, 0)
        if (IsPagedButtonUnit(shop, slot)) then
            if (IsUnitIdType(id, UNIT_TYPE_HERO)) then
                //call BJDebugMsg("Hero code " + A2S(id))
static if (LIBRARY_PagedButtonsConfig) then
                set goldCost = c.heroGoldCost
                set lumberCost = c.heroLumberCost
else
                set goldCost = HERO_GOLD_COST
                set lumberCost = HERO_LUMBER_COST
endif
            else
                set goldCost = GetUnitGoldCost(id)
                set lumberCost = GetUnitWoodCost(id)
            endif
            set foodCost = GetFoodUsed(id)
        elseif (IsPagedButtonItem(shop, slot)) then
            set goldCost = GetItemCostGold(id)
            set lumberCost = GetItemCostLumber(id)
        endif
        
static if (LIBRARY_PagedButtonsConfig and SHOW_PREVIEW_MODELS) then
        set modelX = c.modelX
        set modelY = c.modelY
        set modelScale = c.modelScale
        set modelPath = c.modelPath
endif
        
        if (summonText != null and StringLength(summonText) > 0) then
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetText(SummonFrame, summonText)
                call BlzFrameSetVisible(SummonFrame, true)
            endif
        endif
        
        if (goldCost > 0) then
             if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetText(ItemGoldFrame, "|cffffcc00" + I2S(goldCost) + "|r")
                call BlzFrameSetVisible(ItemGoldIconFrame, true)
                call BlzFrameSetVisible(ItemGoldFrame, true)
            endif
        else
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(ItemGoldIconFrame, false)
                call BlzFrameSetVisible(ItemGoldFrame, false)
            endif
        endif
        
        if (lumberCost > 0) then
             if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetText(ItemLumberFrame, "|cffffcc00" + I2S(lumberCost) + "|r")
                call BlzFrameSetVisible(ItemLumberIconFrame, true)
                call BlzFrameSetVisible(ItemLumberFrame, true)
            endif
        else
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(ItemLumberIconFrame, false)
                call BlzFrameSetVisible(ItemLumberFrame, false)
            endif
        endif
        
        if (foodCost > 0) then
             if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetText(ItemFoodFrame, "|cffffcc00" + I2S(foodCost) + "|r")
                call BlzFrameSetVisible(ItemFoodIconFrame, true)
                call BlzFrameSetVisible(ItemFoodFrame, true)
            endif
        else
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(ItemFoodIconFrame, false)
                call BlzFrameSetVisible(ItemFoodFrame, false)
            endif
        endif
        //call BJDebugMsg("Entering item " + I2S(index))
        
        if (pageName != null) then
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetText(PageNameText, pageName)
                call BlzFrameSetVisible(PageNameText, true)
            endif
        else
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(PageNameText, false)
            endif
        endif

        if (id != 0) then
            set tooltip = tooltip + BlzGetAbilityExtendedTooltip(id, 0)
        else
            set tooltip = tooltip + Format(GetLocalizedString("EMPTY_SLOT_TOOLTIP")).i(slot + 1).i(page + 1).result()
            //call BlzFrameSetVisible(ItemGoldIconFrame[playerId], false)
        endif
        
        if (id != 0) then
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetTexture(TooltipIcon, GetButtonSlotIcon(shop, slot), 0, false)
                call BlzFrameSetVisible(TooltipIcon, true)
            endif
            set tooltip = tooltip + GetLocalizedString("BUY_TOOLTIP_SUFFIX")
        else
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(TooltipIcon, false)
            endif
            set tooltip = tooltip + GetLocalizedString("SLOT_TOOLTIP_SUFFIX")
        endif

        if (GetLocalPlayer() == GetTriggerPlayer()) then
            call SetTextAreaText(TooltipText, tooltip)
            //call BlzFrameSetText(TooltipText, tooltip)
            call BlzFrameSetVisible(TooltipText, true)
        endif
        
static if (SHOW_PREVIEW_MODELS) then
        if (StringLength(modelPath) > 0) then
            // https://us.forums.blizzard.com/en/warcraft3/t/jasslua-frameeventmouseenter-infinite-loop/28659
            // because of this bug we store the model path and scaling and only refresh the sprite if it changed.
            if (previewModelFile[playerId] != modelPath or not CompareReals(previewModelX[playerId], modelX) or not CompareReals(previewModelY[playerId], modelY) or not CompareReals(previewModelScale[playerId], modelScale)) then
                //call BJDebugMsg("Refresh with model path because of different scale or path: " + modelPath)
                set previewModelX[playerId] = modelX
                set previewModelY[playerId] = modelY
                set previewModelScale[playerId] = modelScale
                set previewModelFile[playerId] = modelPath
                // It won't work if we do not recreate the framehandle.
                call RefreshPreviewFrame()
                
                if (GetLocalPlayer() == GetTriggerPlayer()) then
                    call RefreshPreviewFrameForPlayerOnly(modelX, modelY, modelScale, modelPath)
                endif
            endif
        else
            set previewModelX[playerId] = 0.4
            set previewModelY[playerId] = 0.3
            set previewModelFile[playerId] = ""
            set previewModelScale[playerId] = 0.0
            if (GetLocalPlayer() == GetTriggerPlayer()) then
                call BlzFrameSetVisible(PreviewSprite, false)
            endif
        endif
endif
    endif
    
    set shop = null
endfunction

private function LeaveItemFunction takes nothing returns nothing
    /*
    https://us.forums.blizzard.com/en/warcraft3/t/jasslua-frameeventmouseenter-infinite-loop/28659
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call SetTooltipVisible(false)
    endif
    */
endfunction

private function PreviousPagesFunction takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, "PreviousPage")
    endif
endfunction

private function NextPagesFunction takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, "NextPage")
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

private function CloseFunction takes nothing returns nothing
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzSendSyncData(PREFIX, "Close")
    endif
endfunction

public function CreateUI takes nothing returns nothing
    local integer i = 0
    local integer handleId = 0
    local real x = 0.0
    local real y = 0.0
    
    set BackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_TOPLEFT, X, Y)
    call BlzFrameSetAbsPoint(BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, SIZE_X, Y - SIZE_Y)

    set y = TITLE_Y
    set TitleFrame = BlzCreateFrameByType("TEXT", "PagedButtonsUITitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_TOPLEFT, 0.0, y)
    call BlzFrameSetAbsPoint(TitleFrame, FRAMEPOINT_BOTTOMRIGHT, SIZE_X, y - TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(TitleFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

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

        set SlotBackdropFrame[i] = BlzCreateFrameByType("BACKDROP", "PagedButtonsUIBackdropFrame" + I2S(i), SlotFrame[i], "", 1)
        call BlzFrameSetAllPoints(SlotBackdropFrame[i], SlotFrame[i])
//             call BlzFrameSetTexture(SlotBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)

        if (SlotClickTrigger[i] != null) then
            set handleId = GetHandleId(SlotClickTrigger[i])
            call FlushChildHashtable(h, handleId)
            call DestroyTrigger(SlotClickTrigger[i])
        endif
        set SlotClickTrigger[i] = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(SlotClickTrigger[i], SlotFrame[i], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(SlotClickTrigger[i], function ClickItemFunction)
        set handleId = GetHandleId(SlotClickTrigger[i])
        call SaveInteger(h, handleId, 0, i)

        if (SlotTooltipOnTrigger[i] != null) then
            set handleId = GetHandleId(SlotTooltipOnTrigger[i])
            call FlushChildHashtable(h, handleId)
            call DestroyTrigger(SlotTooltipOnTrigger[i])
        endif
        set SlotTooltipOnTrigger[i] = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(SlotTooltipOnTrigger[i], SlotFrame[i], FRAMEEVENT_MOUSE_ENTER)
        call TriggerAddAction(SlotTooltipOnTrigger[i], function EnterItemFunction)
        set handleId = GetHandleId(SlotTooltipOnTrigger[i])
        call SaveInteger(h, handleId, 0, i)
        
        if (SlotTooltipOffTrigger[i] != null) then
            set handleId = GetHandleId(SlotTooltipOffTrigger[i])
            call FlushChildHashtable(h, handleId)
            call DestroyTrigger(SlotTooltipOffTrigger[i])
        endif
        set SlotTooltipOffTrigger[i] = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(SlotTooltipOffTrigger[i], SlotFrame[i], FRAMEEVENT_MOUSE_LEAVE)
        call TriggerAddAction(SlotTooltipOffTrigger[i], function LeaveItemFunction)
        call SaveInteger(h, handleId, 0, i)

        // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.
        
        set SlotPageBackgroundFrame[i] = BlzCreateFrameByType("BACKDROP", "ItemBagBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(SlotPageBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(SlotPageBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + CHARGES_BACKGROUND_SIZE, y - CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetTexture(SlotPageBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(SlotPageBackgroundFrame[i], 1)

        set SlotPageFrame[i] = BlzCreateFrameByType("TEXT", "PagedButtonsUIBag" + I2S(i), SlotPageBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(SlotPageFrame[i], SlotPageBackgroundFrame[i])
        call BlzFrameSetText(SlotPageFrame[i], I2S(i + 1))
        call BlzFrameSetTextAlignment(SlotPageFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(SlotPageFrame[i], 0.7)
        call BlzFrameSetEnable(SlotPageFrame[i], false)
        call BlzFrameSetLevel(SlotPageFrame[i], 2)
        
        set SlotChargesBackgroundFrame[i] = BlzCreateFrameByType("BACKDROP", "PagedButtonsUIItemChargesBackrgroundFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(SlotChargesBackgroundFrame[i], FRAMEPOINT_TOPLEFT, x + BUTTON_SIZE - CHARGES_BACKGROUND_SIZE, y - BUTTON_SIZE + CHARGES_BACKGROUND_SIZE)
        call BlzFrameSetAbsPoint(SlotChargesBackgroundFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + BUTTON_SIZE, y - BUTTON_SIZE)
        call BlzFrameSetTexture(SlotChargesBackgroundFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(SlotChargesBackgroundFrame[i], 1)

        set SlotChargesFrame[i] = BlzCreateFrameByType("TEXT", "PagedButtonsUICharges" + I2S(i), SlotChargesBackgroundFrame[i], "", 0)
        call BlzFrameSetAllPoints(SlotChargesFrame[i], SlotChargesBackgroundFrame[i])
        call BlzFrameSetTextAlignment(SlotChargesFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(SlotChargesFrame[i], 0.7)
        call BlzFrameSetEnable(SlotChargesFrame[i], false)
        call BlzFrameSetLevel(SlotChargesFrame[i], 2)

        set x = x + BUTTON_SIZE + BUTTON_SPACE

        set i = i + 1

        // every 3 bags start another line
        if (ModuloInteger(i, MAX_SLOTS_PER_LINE) == 0) then
            set x = BUTTON_X
            set y = y - BUTTON_SIZE - BUTTON_SPACE
        endif
    endloop

    set TooltipFrame = BlzCreateFrame("EscMenuBackdrop", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(TooltipFrame, FRAMEPOINT_TOPLEFT, TOOLTIP_FRAME_X, TOOLTIP_FRAME_Y)
    call BlzFrameSetAbsPoint(TooltipFrame, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_FRAME_X + TOOLTIP_FRAME_WIDTH, TOOLTIP_FRAME_Y - TOOLTIP_FRAME_HEIGHT)
    
    set TooltipIcon = BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipIconFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TooltipIcon, FRAMEPOINT_TOPLEFT, TOOLTIP_ICON_X, TOOLTIP_ICON_Y)
    call BlzFrameSetAbsPoint(TooltipIcon, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_ICON_X + TOOLTIP_ICON_SIZE, TOOLTIP_ICON_Y - TOOLTIP_ICON_SIZE)
    call BlzFrameSetTexture(TooltipIcon, "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp", 0, true)
    
    set PageNameText = BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipPageName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(PageNameText, FRAMEPOINT_TOPLEFT, TOOLTIP_PAGE_NAME_X, TOOLTIP_PAGE_NAME_Y)
    call BlzFrameSetAbsPoint(PageNameText, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_PAGE_NAME_X + TOOLTIP_PAGE_NAME_WIDTH, TOOLTIP_PAGE_NAME_Y - TOOLTIP_PAGE_NAME_HEIGHT)
    
    set SummonFrame = BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipSummon", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SummonFrame, FRAMEPOINT_TOPLEFT,  SUMMON_X, SUMMON_Y)
    call BlzFrameSetAbsPoint(SummonFrame, FRAMEPOINT_BOTTOMRIGHT, SUMMON_X + TOOLTIP_WIDTH, SUMMON_Y - SUMMON_HEIGHT)

    set ItemGoldIconFrame = BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipGoldFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemGoldIconFrame, FRAMEPOINT_TOPLEFT, COST_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemGoldIconFrame, FRAMEPOINT_BOTTOMRIGHT, COST_X + COST_ICON_SIZE, COST_Y - COST_ICON_SIZE)
    call BlzFrameSetTexture(ItemGoldIconFrame, "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    
    set ItemGoldFrame = BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipGold", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemGoldFrame, FRAMEPOINT_TOPLEFT, COST_GOLD_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemGoldFrame, FRAMEPOINT_BOTTOMRIGHT, COST_GOLD_X + COST_WIDTH, COST_Y - COST_HEIGHT)
    
    set ItemLumberIconFrame = BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipLumberFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemLumberIconFrame, FRAMEPOINT_TOPLEFT, COST_ICON_LUMBER_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemLumberIconFrame, FRAMEPOINT_BOTTOMRIGHT, COST_ICON_LUMBER_X + COST_ICON_SIZE, COST_Y - COST_ICON_SIZE)
    call BlzFrameSetTexture(ItemLumberIconFrame, "UI\\Feedback\\Resources\\ResourceLumber.blp", 0, true)
    
    set ItemLumberFrame = BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipLumber", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemLumberFrame, FRAMEPOINT_TOPLEFT, COST_LUMBER_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemLumberFrame, FRAMEPOINT_BOTTOMRIGHT,  COST_LUMBER_X + COST_WIDTH, COST_Y - COST_ICON_SIZE)
    
    set ItemFoodIconFrame = BlzCreateFrameByType("BACKDROP", "PagedButtonsUITooltipFoodFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemFoodIconFrame, FRAMEPOINT_TOPLEFT, COST_ICON_FOOD_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemFoodIconFrame, FRAMEPOINT_BOTTOMRIGHT, COST_ICON_FOOD_X + COST_ICON_SIZE, COST_Y - COST_ICON_SIZE)
    call BlzFrameSetTexture(ItemFoodIconFrame, "UI\\Feedback\\Resources\\ResourceSupply.blp", 0, true)
    
    set ItemFoodFrame = BlzCreateFrameByType("TEXT", "PagedButtonsUITooltipFood", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ItemFoodFrame, FRAMEPOINT_TOPLEFT, COST_FOOD_X, COST_Y)
    call BlzFrameSetAbsPoint(ItemFoodFrame, FRAMEPOINT_BOTTOMRIGHT, COST_FOOD_X + COST_WIDTH, COST_Y - COST_ICON_SIZE)
    
    set TooltipText = BlzCreateFrame("EscMenuTextAreaTemplate", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(TooltipText, FRAMEPOINT_TOPLEFT, TOOLTIP_X, TOOLTIP_Y)
    call BlzFrameSetAbsPoint(TooltipText, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_X + TOOLTIP_WIDTH, TOOLTIP_Y - TOOLTIP_HEIGHT)
    call BlzFrameSetFont(TooltipText, "MasterFont", TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetEnable(TooltipText, false)
    call BlzFrameSetTextAlignment(TooltipText, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetLevel(TooltipText, 1)
    
    //call BJDebugMsg("Icon " + GetIconByItemType(itemTypeId) + " for item type " + GetObjectName(itemTypeId))

static if (SHOW_PREVIEW_MODELS) then
    call RefreshPreviewFrame()
endif

    set NextPagesButton = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(NextPagesButton, FRAMEPOINT_TOPLEFT, NEXT_PAGE_BUTTON_X, BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(NextPagesButton, FRAMEPOINT_BOTTOMRIGHT, NEXT_PAGE_BUTTON_X + PAGE_BUTTON_WIDTH, BOTTOM_BUTTONS_Y - CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(NextPagesButton, GetLocalizedString("NEXT_PAGE_BUTTON"))

    if (NextPagesTrigger != null) then
        call DestroyTrigger(NextPagesTrigger)
    endif
    set NextPagesTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(NextPagesTrigger, NextPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(NextPagesTrigger, function NextPagesFunction)
    
    set PreviousPagesButton = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(PreviousPagesButton, FRAMEPOINT_TOPLEFT, PREVIOUS_PAGE_BUTTON_X, BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(PreviousPagesButton, FRAMEPOINT_BOTTOMRIGHT, PREVIOUS_PAGE_BUTTON_X + PAGE_BUTTON_WIDTH, BOTTOM_BUTTONS_Y - CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(PreviousPagesButton, GetLocalizedString("PREVIOUS_PAGE_BUTTON"))

    if (PreviousPagesTrigger != null) then
        call DestroyTrigger(PreviousPagesTrigger)
    endif
    set PreviousPagesTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(PreviousPagesTrigger, PreviousPagesButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(PreviousPagesTrigger, function PreviousPagesFunction)

    set Checkbox = BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_TOPLEFT, CHECKBOX_X, BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_BOTTOMRIGHT, CHECKBOX_X + CHECKBOX_SIZE, BOTTOM_BUTTONS_Y - CHECKBOX_SIZE)
    call BlzFrameSetEnable(Checkbox, true)
    call BlzFrameSetValue(Checkbox, 1.0)
   
    if (CheckedTrigger != null) then
        call DestroyTrigger(CheckedTrigger)
    endif
    set CheckedTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckedTrigger, Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(CheckedTrigger, function CheckedFunction)
    
    if (UncheckedTrigger != null) then
        call DestroyTrigger(UncheckedTrigger)
    endif
    set UncheckedTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UncheckedTrigger, Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(UncheckedTrigger, function UncheckedFunction)

    set CloseButton = BlzCreateFrame("ScriptDialogButton", BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(CloseButton, FRAMEPOINT_TOPLEFT, CLOSE_BUTTON_X, BOTTOM_BUTTONS_Y)
    call BlzFrameSetAbsPoint(CloseButton, FRAMEPOINT_BOTTOMRIGHT, CLOSE_BUTTON_X + CLOSE_BUTTON_WIDTH, BOTTOM_BUTTONS_Y - CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(CloseButton, GetLocalizedString("CLOSE_BUTTON"))

    if (CloseTrigger != null) then
        call DestroyTrigger(CloseTrigger)
    endif
    set CloseTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CloseTrigger, CloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(CloseTrigger, function CloseFunction)

    call HidePagedButtonsUI()
endfunction

private function TriggerActionSelected takes nothing returns nothing
    if (HasPagedButtons(GetTriggerUnit()) and GetPagedButtonsCount(GetTriggerUnit()) > 0 and IsPagedButtonsUIEnabledForPlayer(GetTriggerPlayer())) then
        call ShowPagedButtonsUI(GetTriggerPlayer(), GetTriggerUnit())
    endif
endfunction

private function TriggerConditionChangePage takes nothing returns boolean
    local unit shop = GetTriggerShop()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (shop == UIShop[i]) then
            call UpdateItemsForUI(Player(i))
        endif
        set i = i + 1
    endloop
    set shop = null
    return false
endfunction

private function HidePagedButtonsShopForAllPlayers takes unit shop returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (shop == UIShop[i]) then
            call HidePagedButtonsUIForPlayer(Player(i))
        endif
        set i = i + 1
    endloop
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local unit shop = GetTriggerUnit()
    if (HasPagedButtons(shop)) then
        call HidePagedButtonsShopForAllPlayers(shop)
    endif
    set shop = null
    return false
endfunction

private function TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer = GetTriggerPlayer()
    local integer playerId = GetPlayerId(whichPlayer)
    local string data = BlzGetTriggerSyncData()
    local integer slot = 0
    local unit shop = UIShop[playerId]
    local integer id = 0
    local integer newPage = 0
    if (data == "PreviousPage") then
        if (PagesIndex[playerId] == 0) then
            set PagesIndex[playerId] = GetMaxPageIndex(playerId)
        else
            set PagesIndex[playerId] = PagesIndex[playerId] - 1
        endif
        call UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Previous pages button with index " + I2S(PagesIndex[playerId]))
    elseif (data == "NextPage") then
        if (PagesIndex[playerId]  < GetMaxPageIndex(playerId)) then
            set PagesIndex[playerId] = PagesIndex[playerId] + 1
        else
            set PagesIndex[playerId] = 0
        endif
        call UpdateItemsForUI(whichPlayer)
        //call BJDebugMsg("Next pages button with index " + I2S(PagesIndex[playerId]))
    elseif (data == "Checked") then
        set checked[playerId] = true
        call SetAllSlotChargesVisibleForPlayer(whichPlayer, true)
    elseif (data == "Unchecked") then
        set checked[playerId] = false
        call SetAllSlotChargesVisibleForPlayer(whichPlayer, false)
    elseif (data == "Close") then
        call HidePagedButtonsUIForPlayer(whichPlayer)
    else
        set slot = S2I(data)
        set id = GetPagedButtonId(shop, slot)
        set newPage = GetPagedButtonsPageByIndex(shop, slot)
        if (newPage < GetPagedButtonsMaxPages(shop) and newPage >= 0) then
            call SetPagedButtonsPage(shop, newPage)
            if (id != 0 and (IsPagedButtonUnit(shop, slot) or IsPagedButtonItem(shop, slot))) then
                call IssueNeutralImmediateOrderById(whichPlayer, shop, id)
            endif
        endif
    endif
    set whichPlayer = null
    set shop = null
endfunction

private function Init takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i >= MAX_SLOTS)
        set SlotClickTrigger[i] = null
        set SlotTooltipOnTrigger[i] = null
        set SlotTooltipOffTrigger[i] = null
        
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER) then
            set enabledForPlayer[i] = ENABLED_BY_DEFAULT
            call BlzTriggerRegisterPlayerSyncEvent(syncTrigger, slotPlayer, PREFIX, false)
static if (SHOW_PREVIEW_MODELS) then
            set previewModelX[i] = 0.0
            set previewModelY[i] = 0.0
            set previewModelScale[i] = 0.0
            set previewModelFile[i] = ""
endif
        endif
        set slotPlayer = null
        
        set i = i + 1
    endloop
    call TriggerAddAction(syncTrigger, function TriggerActionSyncData)
    
static if (LOAD_TOC_FILE) then
    call BlzLoadTOCFile(TOC_FILE)
endif
    
    call TriggerRegisterAnyUnitEventBJ(selectionTrigger, EVENT_PLAYER_UNIT_SELECTED)
    // Barade: Using trigger conditions with selection events led to weird behavior, so use a trigger action here.
    call TriggerAddAction(selectionTrigger, function TriggerActionSelected)
    
    call TriggerRegisterChangePagedButtons(changePageButtonsTrigger)
    call TriggerAddCondition(changePageButtonsTrigger, Condition(function TriggerConditionChangePage))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call OnStartGame(function CreateUI)
    call FrameLoaderAdd(function CreateUI)
    call FrameSaverAdd(function HidePagedButtonsUI)
static if (SHOW_PREVIEW_MODELS) then
    call FrameSaverAdd(function ResetPreviewFrame) // Destroying the frame will crash the game.
endif
endfunction

endlibrary
