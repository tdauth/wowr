library WoWReforgedUiBackpack initializer Init requires OnStartGame, FrameLoader, FrameSaver, PagedButtonsConfig, WoWReforgedUi, WoWReforgedBackpacks, WoWReforgedIcons

globals
    private constant real BACKPACK_UI_BUTTON_SIZE = 0.02818
    private constant real BACKPACK_UI_CHARGES_BACKGROUND_SIZE = 0.014
    private constant real BACKPACK_UI_CHARGES_POS = 0.003
    private constant real BACKPACK_UI_CHARGES_SIZE = 0.02
    private constant real BACKPACK_UI_BUTTON_SPACE = 0.005
    
    private constant real UI_SLOT_X = 0.03
    private constant real UI_SLOT_Y = 0.53

    private constant real UI_CHECKBOX_X = 0.48
    private constant real UI_CHECKBOX_Y = 0.20
    private constant real UI_CHECKBOX_SIZE = 0.02818
    
    private constant real UI_TOOLTIP_FRAME_X = 0.62
    private constant real UI_TOOLTIP_FRAME_Y = 0.54
    private constant real UI_TOOLTIP_FRAME_WIDTH = 0.16
    private constant real UI_TOOLTIP_FRAME_HEIGHT = 0.36
    
    private constant real UI_TOOLTIP_X = 0.639
    private constant real UI_TOOLTIP_Y = 0.47
    private constant real UI_TOOLTIP_WIDTH = 0.12
    private constant real UI_TOOLTIP_HEIGHT = 0.26
    
    private constant real UI_TOOLTIP_ICON_X = UI_TOOLTIP_X
    private constant real UI_TOOLTIP_ICON_Y = 0.515
    private constant real UI_TOOLTIP_ICON_SIZE = 0.02
    
    public constant real TOOLTIP_FONT_HEIGHT = 0.008
    
    private hashtable h = InitHashtable()

    private constant integer KEY_INDEX = 1
    private constant integer KEY_BAG = 2
    private constant integer KEY_SLOT = 3

    private boolean array BackpackUIVisible
    private framehandle BackpackBackgroundFrame
    private framehandle BackpackTitleFrame
    private framehandle array BackpackItemFrame
    private framehandle array BackpackItemBackdropFrame
    private framehandle array BackpackItemChargesBackgroundFrame
    private framehandle array BackpackItemChargesFrame
    private framehandle array BackpackItemBagBackgroundFrame
    private framehandle array BackpackItemBagFrame
    private trigger array BackpackItemTrigger
    private trigger array BackpackItemTooltipOnTrigger
    private trigger array BackpackItemTooltipOffTrigger
    private framehandle BackpackTooltipFrame
    private framehandle BackpackTooltipIcon
    private framehandle BackpackTooltipModel
    private framehandle BackpackItemGoldFrame
    private framehandle BackpackItemGoldIconFrame
    private framehandle BackpackTooltipText
    private framehandle Checkbox
    private trigger CheckTrigger
    private trigger UncheckTrigger
    private trigger CheckboxTooltipOnTrigger
    private trigger CheckboxTooltipOffTrigger
    private framehandle BackpackCloseButton
    private trigger BackpackCloseTrigger
    private trigger BackpackSyncTrigger
    private boolean array Checked
endglobals

function UpdateItemsForBackpackUI takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer itemTypeId = 0
    local integer index = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index2D(i, j, bj_MAX_INVENTORY)
            set itemTypeId = GetBackpackItemTypeId(index)
            if (itemTypeId == 0) then
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
                call BlzFrameSetVisible(BackpackItemChargesBackgroundFrame[index], false)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            else
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], GetIconByItemType(itemTypeId), 0, true)
                call BlzFrameSetText(BackpackItemChargesFrame[index], I2S(GetBackpackItemCharges(index)))
                if (BackpackUIVisible[playerId] and GetBackpackItemCharges(index) > 0) then
                    if (whichPlayer == GetLocalPlayer()) then
                        call BlzFrameSetVisible(BackpackItemChargesBackgroundFrame[index], true)
                        call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                    endif
                endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function BackpackUIExists takes nothing returns boolean
    return BackpackBackgroundFrame != null
endfunction

private function TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer = GetTriggerPlayer()
    local string prefix = BlzGetTriggerSyncPrefix()
    local string data = BlzGetTriggerSyncData()
    local integer bag = S2I(data)
    call ChangeBackpackPageEx(whichPlayer, bag)
    set whichPlayer = null
endfunction

function ShowBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local integer playerId = GetPlayerId(whichPlayer)
    if (not BackpackUIExists()) then
        return
    endif
    set BackpackUIVisible[playerId] = true
    call UpdateItemsForBackpackUI(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame, true)
        call BlzFrameSetVisible(BackpackTitleFrame, true)
        call BlzFrameSetVisible(Checkbox, true)
        call BlzFrameSetVisible(BackpackCloseButton, true)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], true)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], true)
        call BlzFrameSetVisible(BackpackTooltipIcon, false)
        call BlzFrameSetVisible(BackpackTooltipModel, false)
    endif
    set i = 0
    loop
        exitwhen (i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index2D(i, j, bj_MAX_INVENTORY)
            if (whichPlayer == GetLocalPlayer()) then
                call BlzFrameSetVisible(BackpackItemFrame[index], true)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], true)
                call BlzFrameSetVisible(BackpackItemBagBackgroundFrame[index], Checked[playerId])
                call BlzFrameSetVisible(BackpackItemBagFrame[index], Checked[playerId])
            endif
            if (GetBackpackItemTypeId(index) != 0 and GetItemTypePerishable(GetBackpackItemTypeId(index))) then
                if (whichPlayer == GetLocalPlayer()) then
                    call BlzFrameSetVisible(BackpackItemChargesBackgroundFrame[index], true)
                    call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function HideBackpackUI takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    if (not BackpackUIExists()) then
        return
    endif
    set BackpackUIVisible[playerId] = false
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame, false)
        call BlzFrameSetVisible(BackpackTitleFrame, false)
        call BlzFrameSetVisible(Checkbox, false)
        call BlzFrameSetVisible(BackpackCloseButton, false)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], false)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], false)
        call BlzFrameSetVisible(BackpackTooltipIcon, false)
        call BlzFrameSetVisible(BackpackTooltipModel, false)
    endif
    set i = 0
    loop
        exitwhen (i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index2D(i, j, bj_MAX_INVENTORY)
            if (whichPlayer == GetLocalPlayer()) then
                call BlzFrameSetVisible(BackpackItemFrame[index], false)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)
                call BlzFrameSetVisible(BackpackItemBagBackgroundFrame[index], false)
                call BlzFrameSetVisible(BackpackItemBagFrame[index], false)
                call BlzFrameSetVisible(BackpackItemChargesBackgroundFrame[index], false)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function HideBackpackUIForAllPlayers takes nothing returns nothing
    local integer i = 0
    if (BackpackUIExists()) then
        loop
            exitwhen (i == bj_MAX_PLAYERS)
            call HideBackpackUI(Player(i))
            set i = i + 1
        endloop
    endif
endfunction

function BackpackClickItemFunction takes nothing returns nothing
    local integer handleId = GetHandleId(GetTriggeringTrigger())
    local integer index = LoadInteger(h, handleId, KEY_INDEX)
    local integer bag = LoadInteger(h, handleId, KEY_BAG)
    local integer slot = LoadInteger(h, handleId, KEY_SLOT)
    local string text = Format(GetLocalizedString("BAG_CHANGED")).i(bag + 1).result() // Changed to bag %1%.
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetText(BackpackTooltipText, text)
        call BlzSendSyncData("BackpackUI", I2S(bag))
    endif
endfunction

private function EnterItemFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    local integer handleId = GetHandleId(GetTriggeringTrigger())
    local integer index = LoadInteger(h, handleId, KEY_INDEX)
    local integer bag = LoadInteger(h, handleId, KEY_BAG)
    local integer slot = LoadInteger(h, handleId, KEY_SLOT)
    local string tooltip = Format(GetLocalizedString("BAG_EMPTY_SLOT")).i(slot + 1).i(bag + 1).result()
    local integer itemTypeId = GetBackpackItemTypeId(index)
    local PagedButtonsConfig c = 0
    local PagedButtonsConfig cDefault = 0
    //call BJDebugMsg("Entering item " + I2S(index))

    if (itemTypeId != 0) then
        if (GetBackpackItemIsPawnable(index)) then
            set tooltip = GetObjectName(itemTypeId)
            
            if (GetBackpackItemCharges(index) > 1) then
                set tooltip = tooltip + Format(GetLocalizedString("BAG_CHARGES")).i(GetBackpackItemCharges(index)).result() //  (|cffffcc00%1%|r)
            endif
            
            set tooltip = tooltip + "|n"

            if (GetItemValueGold(itemTypeId) > 0) then
                //call BlzFrameSetVisible(BackpackItemGoldIconFrame[playerId], true)
                set tooltip = tooltip + Format(GetLocalizedString("BAG_GOLD_VALUE")).i(IMaxBJ(1, GetBackpackItemCharges(index)) * GetItemValueGold(itemTypeId)).result() // |cffFCD20D%1% Gold|r
            else
                //call BlzFrameSetVisible(BackpackItemGoldIconFrame[playerId], false)
            endif

            if (GetItemValueLumber(itemTypeId) > 0) then
                if (GetItemValueGold(itemTypeId) > 0) then
                    set tooltip = tooltip + " "
                endif

                set tooltip = tooltip + Format(GetLocalizedString("BAG_LUMBER_VALUE")).i(IMaxBJ(1, GetBackpackItemCharges(index)) * GetItemValueLumber(itemTypeId)).result() // |cffFCD20D%1% Lumber|r
            endif
        else
            //call BlzFrameSetVisible(BackpackItemGoldIconFrame[playerId], false)
            set tooltip = Format(GetLocalizedString("BAG_TOOLTIP")).s(GetObjectName(itemTypeId)).s(GetBackpackItemTooltipExtended(index)).result() // %1%|n|n%2%
        endif
    else
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[playerId], false)
    endif
    
    if (itemTypeId != 0) then
        set c = GetPagedButtonsConfig(itemTypeId)
        set cDefault = GetPagedButtonsConfig(0)
        
        if (GetBackpackItemIsPawnable(index)) then
            set tooltip = tooltip + GetLocalizedString("BAG_DROP_TO_SELL_ITEM") + GetBackpackItemTooltipExtended(index) // |n|n|cff808080Drop item on shop to sell|R|n
        endif

        if (GetBackpackItemPlayer(index) != null and GetBackpackItemPlayer(index) != Player(PLAYER_NEUTRAL_PASSIVE)) then
            set tooltip = tooltip + Format(GetLocalizedString("BAG_ITEM_OWNER")).s(GetPlayerNameColored(GetBackpackItemPlayer(index))).result() // |n|nOwner: %1%
        endif
        
        if (GetTriggerPlayer() == GetLocalPlayer()) then
            call BlzFrameSetTexture(BackpackTooltipIcon, GetIconByItemType(itemTypeId), 0, false)
            //call BJDebugMsg("Icon " + GetIconByItemType(itemTypeId) + " for item type " + GetObjectName(itemTypeId))
            
            if (c != 0) then
                call BlzFrameSetModel(BackpackTooltipModel, c.modelPath, 1)
                call BlzFrameSetScale(BackpackTooltipModel, c.modelScale)
                call BlzFrameSetAbsPoint(BackpackTooltipModel, FRAMEPOINT_CENTER, c.modelX, c.modelY)
            else
                call BlzFrameSetModel(BackpackTooltipModel, GetItemTypeModel(itemTypeId), 0)
                call BlzFrameSetScale(BackpackTooltipModel, cDefault.modelScale)
                call BlzFrameSetAbsPoint(BackpackTooltipModel, FRAMEPOINT_CENTER, cDefault.modelX, cDefault.modelY)
            endif
            call BlzFrameSetSpriteAnimate(BackpackTooltipModel, 2, 0)
            
            call BlzFrameSetVisible(BackpackTooltipIcon, true)
            call BlzFrameSetVisible(BackpackTooltipModel, true)
        endif
    else
        if (GetTriggerPlayer() == GetLocalPlayer()) then
            call BlzFrameSetVisible(BackpackTooltipIcon, false)
            call BlzFrameSetVisible(BackpackTooltipModel, false)
        endif
    endif

    set tooltip = tooltip + GetLocalizedString("BAG_CLICK_OPEN") // |n|n|cff808080Click to open the bag.|R|n

    if (GetTriggerPlayer() == GetLocalPlayer()) then
        //call BlzFrameSetText(BackpackTooltipText, tooltip)
        call SetTextAreaText(BackpackTooltipText, tooltip)
    endif
endfunction

private function LeaveItemFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    local integer index = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 1)
    //call BJDebugMsg("Leave item " + I2S(index))
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetTexture(BackpackTooltipIcon, "", 0, false)
        call BlzFrameSetVisible(BackpackTooltipIcon, false)
        call BlzFrameSetModel(BackpackTooltipModel, "", 0)
        call BlzFrameSetVisible(BackpackTooltipModel, false)
        call BlzFrameSetText(BackpackTooltipText, "")
    endif
endfunction

private function CheckedFunction takes nothing returns nothing
    set Checked[GetPlayerId(GetTriggerPlayer())] = true
    call ShowBackpackUI(GetTriggerPlayer())
endfunction
    
private function UncheckedFunction takes nothing returns nothing
    set Checked[GetPlayerId(GetTriggerPlayer())] = false
    call ShowBackpackUI(GetTriggerPlayer())
endfunction

private function CheckboxEnterItemFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetText(BackpackTooltipText, GetLocalizedString("DOT_HIDE_BAG_NUMBERS")) // Hide bag numbers.
    endif
endfunction

private function CheckboxLeaveItemFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetText(BackpackTooltipText, "")
    endif
endfunction

private function CloseFunction takes nothing returns nothing
    call HideBackpackUI(GetTriggerPlayer())
endfunction

private function CreateBackpackUI takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local real x = 0.0
    local real y = 0.0
    local integer index = 0

    set BackpackBackgroundFrame = CreateFullScreenFrame()
    set BackpackTitleFrame = CreateFullScreenTitle("BackpackTitle", GetLocalizedString("BACKPACK")) // Backpack
    call BlzFrameSetVisible(BackpackTitleFrame, false)

    set x = UI_SLOT_X
    set y = UI_SLOT_Y
    set i = 0
    loop
        exitwhen (i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index2D(i, j, bj_MAX_INVENTORY)
            set BackpackItemFrame[index] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_BOTTOMRIGHT, x + BACKPACK_UI_BUTTON_SIZE, y - BACKPACK_UI_BUTTON_SIZE)
            //call BlzFrameSetTexture(BackpackItemFrame[index], GetIconByItemType(0), 0, true)
            //call BlzFrameSetText(BackpackItemFrame[index], I2S(index))
            call BlzFrameSetVisible(BackpackItemFrame[index], false)

            set BackpackItemBackdropFrame[index] = BlzCreateFrameByType("BACKDROP", "BackdropFrame" + I2S(index), BackpackItemFrame[index], "", 1)
            call BlzFrameSetAllPoints(BackpackItemBackdropFrame[index], BackpackItemFrame[index])
//             call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
            call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)

            set BackpackItemTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTrigger[index], BackpackItemFrame[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(BackpackItemTrigger[index], function BackpackClickItemFunction)
            call SaveInteger(h, GetHandleId(BackpackItemTrigger[index]), KEY_INDEX, index)
            call SaveInteger(h, GetHandleId(BackpackItemTrigger[index]), KEY_BAG, i)
            call SaveInteger(h, GetHandleId(BackpackItemTrigger[index]), KEY_SLOT, j)

            set BackpackItemTooltipOnTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOnTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_ENTER)
            call TriggerAddAction(BackpackItemTooltipOnTrigger[index], function EnterItemFunction)
            call SaveInteger(h, GetHandleId(BackpackItemTooltipOnTrigger[index]), KEY_INDEX, index)
            call SaveInteger(h, GetHandleId(BackpackItemTooltipOnTrigger[index]), KEY_BAG, i)
            call SaveInteger(h, GetHandleId(BackpackItemTooltipOnTrigger[index]), KEY_SLOT, j)

            set BackpackItemTooltipOffTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOffTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_LEAVE)
            call TriggerAddAction(BackpackItemTooltipOffTrigger[index], function LeaveItemFunction)
            call SaveInteger(h, GetHandleId(BackpackItemTooltipOffTrigger[index]), 1, index)

            // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.
            
            set BackpackItemBagBackgroundFrame[index] = BlzCreateFrameByType("BACKDROP", "ItemBagBackrgroundFrame" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(BackpackItemBagBackgroundFrame[index], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(BackpackItemBagBackgroundFrame[index], FRAMEPOINT_BOTTOMRIGHT, x + BACKPACK_UI_CHARGES_BACKGROUND_SIZE, y - BACKPACK_UI_CHARGES_BACKGROUND_SIZE)
            call BlzFrameSetTexture(BackpackItemBagBackgroundFrame[index], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
            call BlzFrameSetVisible(BackpackItemBagBackgroundFrame[index], false)
            call BlzFrameSetLevel(BackpackItemBagBackgroundFrame[index], 1)

            set BackpackItemBagFrame[index] = BlzCreateFrameByType("TEXT", "bag" + I2S(index), BackpackItemBagBackgroundFrame[index], "", 0)
            call BlzFrameSetAllPoints(BackpackItemBagFrame[index], BackpackItemBagBackgroundFrame[index])
            call BlzFrameSetText(BackpackItemBagFrame[index], I2S(i + 1))
            call BlzFrameSetTextAlignment(BackpackItemBagFrame[index], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
            call BlzFrameSetScale(BackpackItemBagFrame[index], 0.7)
            call BlzFrameSetVisible(BackpackItemBagFrame[index], false)
            call BlzFrameSetEnable(BackpackItemBagFrame[index], false)
            call BlzFrameSetLevel(BackpackItemBagFrame[index], 2)
            
            set BackpackItemChargesBackgroundFrame[index] = BlzCreateFrameByType("BACKDROP", "ItemChargesBackrgroundFrame" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(BackpackItemChargesBackgroundFrame[index], FRAMEPOINT_TOPLEFT, x + BACKPACK_UI_BUTTON_SIZE - BACKPACK_UI_CHARGES_BACKGROUND_SIZE, y - BACKPACK_UI_BUTTON_SIZE + BACKPACK_UI_CHARGES_BACKGROUND_SIZE)
            call BlzFrameSetAbsPoint(BackpackItemChargesBackgroundFrame[index], FRAMEPOINT_BOTTOMRIGHT, x + BACKPACK_UI_BUTTON_SIZE, y - BACKPACK_UI_BUTTON_SIZE)
            call BlzFrameSetTexture(BackpackItemChargesBackgroundFrame[index], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
            call BlzFrameSetVisible(BackpackItemChargesBackgroundFrame[index], false)
            call BlzFrameSetLevel(BackpackItemChargesBackgroundFrame[index], 1)

            set BackpackItemChargesFrame[index] = BlzCreateFrameByType("TEXT", "charges" + I2S(index), BackpackItemChargesBackgroundFrame[index], "", 0)
            call BlzFrameSetAllPoints(BackpackItemChargesFrame[index], BackpackItemChargesBackgroundFrame[index])
            call BlzFrameSetTextAlignment(BackpackItemChargesFrame[index], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
            call BlzFrameSetScale(BackpackItemChargesFrame[index], 0.7)
            call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            call BlzFrameSetEnable(BackpackItemChargesFrame[index], false)
            call BlzFrameSetLevel(BackpackItemChargesFrame[index], 2)

            set x = x + BACKPACK_UI_BUTTON_SIZE + BACKPACK_UI_BUTTON_SPACE

            set j = j + 1
        endloop

        set i = i + 1

        // every 3 bags start another line
        if (ModuloInteger(i, 3) == 0) then
            set x = UI_SLOT_X
            set y = y - BACKPACK_UI_BUTTON_SIZE - BACKPACK_UI_BUTTON_SPACE
        endif
    endloop

    set BackpackTooltipFrame = BlzCreateFrame("EscMenuBackdrop", BackpackBackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame, FRAMEPOINT_TOPLEFT, UI_TOOLTIP_FRAME_X , UI_TOOLTIP_FRAME_Y)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame, FRAMEPOINT_BOTTOMRIGHT, UI_TOOLTIP_FRAME_X + UI_TOOLTIP_FRAME_WIDTH, UI_TOOLTIP_FRAME_Y - UI_TOOLTIP_FRAME_HEIGHT)

    set BackpackItemGoldFrame = BlzCreateFrame("BACKDROP", BackpackBackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame, FRAMEPOINT_TOPLEFT, 0.69, 0.50)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame, FRAMEPOINT_BOTTOMRIGHT, 0.71, 0.48)
    //call BlzFrameSetAllPoints(BackpackItemGoldFrame, BackpackBackgroundFrame)
    call BlzFrameSetVisible(BackpackItemGoldFrame, false)

    set BackpackItemGoldIconFrame = BlzCreateFrameByType("BACKDROP", "TooltipGoldFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(BackpackItemGoldIconFrame, FRAMEPOINT_TOPLEFT, 0.67, 0.50)
    call BlzFrameSetAbsPoint(BackpackItemGoldIconFrame, FRAMEPOINT_BOTTOMRIGHT, 0.69, 0.48)
    call BlzFrameSetTexture(BackpackItemGoldIconFrame, "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    call BlzFrameSetVisible(BackpackItemGoldIconFrame, false)

    set BackpackTooltipIcon = BlzCreateFrameByType("BACKDROP", "TooltipIconFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(BackpackTooltipIcon, FRAMEPOINT_TOPLEFT, UI_TOOLTIP_ICON_X, UI_TOOLTIP_ICON_Y)
    call BlzFrameSetAbsPoint(BackpackTooltipIcon, FRAMEPOINT_BOTTOMRIGHT, UI_TOOLTIP_ICON_X + UI_TOOLTIP_ICON_SIZE, UI_TOOLTIP_ICON_Y - UI_TOOLTIP_ICON_SIZE)
    call BlzFrameSetTexture(BackpackTooltipIcon, "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp", 0, true)
    call BlzFrameSetVisible(BackpackTooltipIcon, false)
    
    /*
     -- create a Sprite copy the button's positions
    local model =  BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    BlzFrameSetAbsPoint(model, FRAMEPOINT_CENTER, 0.4, 0.3)
    BlzFrameSetSize(model, 0.01, 0.01)
    -- apply the model
    BlzFrameSetModel(model, "Abilities\\Weapons\\RockBoltMissile\\RockBoltMissile.mdl", 0)
    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    BlzFrameSetScale(model, 0.00006)
    -- play death animation
	-- birth = 0
    -- death = 1
    -- stand = 2
    -- morph = 3
    -- alternate = 4
    BlzFrameSetSpriteAnimate(model, 1, 0)
    */
    set BackpackTooltipModel = BlzCreateFrameByType("SPRITE", "TooltipModelFrame", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(BackpackTooltipModel, FRAMEPOINT_TOPLEFT, 0.65, 0.20)
    call BlzFrameSetAbsPoint(BackpackTooltipModel, FRAMEPOINT_BOTTOMRIGHT, 0.70, 0.12)
    call BlzFrameSetModel(BackpackTooltipModel, "Abilities\\Weapons\\RockBoltMissile\\RockBoltMissile.mdl", 0)
    call BlzFrameSetScale(BackpackTooltipModel, 0.00006)
    call BlzFrameSetSpriteAnimate(BackpackTooltipModel, 2, 0)
    call BlzFrameSetVisible(BackpackTooltipModel, false)

    set BackpackTooltipText = BlzCreateFrame("EscMenuTextAreaTemplate", BackpackBackgroundFrame, 0, 0) //BlzCreateFrameByType("TEXT", "BackpackTooltipText", BackpackBackgroundFrame, "", 0)
    call BlzFrameSetAbsPoint(BackpackTooltipText, FRAMEPOINT_TOPLEFT, UI_TOOLTIP_X, UI_TOOLTIP_Y)
    call BlzFrameSetAbsPoint(BackpackTooltipText, FRAMEPOINT_BOTTOMRIGHT, UI_TOOLTIP_X + UI_TOOLTIP_WIDTH, UI_TOOLTIP_Y - UI_TOOLTIP_HEIGHT)
    call BlzFrameSetText(BackpackTooltipText, "")
    call BlzFrameSetFont(BackpackTooltipText, "MasterFont", TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetEnable(BackpackTooltipText, false)
    call BlzFrameSetScale(BackpackTooltipText, 1.00)
    call BlzFrameSetTextAlignment(BackpackTooltipText, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetLevel(BackpackTooltipText, 1)
    //call BlzFrameSetTooltip(Frame05, BackpackTooltipText)
    
    set Checkbox = BlzCreateFrame("QuestCheckBox2", BackpackBackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_TOPLEFT, UI_CHECKBOX_X, UI_CHECKBOX_Y)
    call BlzFrameSetAbsPoint(Checkbox, FRAMEPOINT_BOTTOMRIGHT, UI_CHECKBOX_X + UI_CHECKBOX_SIZE, UI_CHECKBOX_Y - UI_CHECKBOX_SIZE)
    call BlzFrameSetScale(Checkbox, 1.00)

    set CheckTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckTrigger, Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(CheckTrigger, function CheckedFunction)
    
    set UncheckTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UncheckTrigger, Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(UncheckTrigger, function UncheckedFunction)
    
    set CheckboxTooltipOnTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxTooltipOnTrigger, Checkbox, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(CheckboxTooltipOnTrigger, function CheckboxEnterItemFunction)
    
    set CheckboxTooltipOffTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CheckboxTooltipOffTrigger, Checkbox, FRAMEEVENT_MOUSE_LEAVE)
    call TriggerAddAction(CheckboxTooltipOffTrigger, function CheckboxLeaveItemFunction)
    
    set BackpackCloseButton = CreateFullScreenCloseButton()

    set BackpackCloseTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BackpackCloseTrigger, BackpackCloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BackpackCloseTrigger, function CloseFunction)

    call BlzFrameSetVisible(BackpackBackgroundFrame, false)
    call BlzFrameSetVisible(BackpackCloseButton, false)
endfunction

private function Init takes nothing returns nothing
    set BackpackSyncTrigger = CreateTrigger()
    call TriggerRegisterAnyPlayerSyncEvent(BackpackSyncTrigger, "BackpackUI", false)
    call TriggerAddAction(BackpackSyncTrigger, function TriggerActionSyncData)

    call OnStartGame(function CreateBackpackUI)

    call FrameLoaderAdd(function CreateBackpackUI)
    
    //call FrameSaverAdd(function HideBackpackUIForAllPlayers)
endfunction

endlibrary
