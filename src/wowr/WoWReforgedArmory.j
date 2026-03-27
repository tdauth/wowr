library WoWReforgedArmory initializer Init requires SimError, MathUtils, PagedButtons, Refund, OnStartGame, WoWReforgedUtils, WoWReforgedEquipment

globals
    private trigger sellTrigger = CreateTrigger()
    private trigger constructionTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
endglobals

function AddArmory takes unit shop returns nothing
    local integer i = 1
    local integer max = GetMaxEquipmentItemTypes()
    local string pageName = ""
    //call BJDebugMsg("Before enabling shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop, 9)
    loop
        exitwhen (i >= max)
        if (i > 1 and GetEquipmentItemTypeCategoryName(i) != "" and GetEquipmentItemTypeCategoryName(i) != null and GetEquipmentItemTypeCategoryName(i) != pageName) then
            call AddPagedButtonsSpacersRemaining(shop)
        endif
        call AddPagedButtonsItemType(shop, GetEquipmentItemTypeId(i))
        if (GetEquipmentItemTypeCategoryName(i) != "" and GetEquipmentItemTypeCategoryName(i) != null) then
            set pageName = GetEquipmentItemTypeCategoryName(i)
            call SetPagedButtonsCurrentPageName(shop, pageName)
        endif
        set i = i + 1
    endloop
    
    //call BJDebugMsg("Before enabling paged buttons for shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    
    //call BJDebugMsg("Enabled shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
endfunction

function IsArmory takes integer unitTypeId returns boolean
    return unitTypeId == ARMORY or unitTypeId == ARMORY_NEUTRAL
endfunction

function IsUnitArmory takes unit whichUnit returns boolean
    return IsArmory(GetUnitTypeId(whichUnit))
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    return IsUnitArmory(GetTriggerUnit())
endfunction

private function TriggerAction1SellItem takes nothing returns nothing
    local unit hero = GetBuyingUnit()
    local player owner = GetOwningPlayer(hero)
    local integer unitTypeId = GetUnitTypeId(hero)
    local integer itemTypeId = GetItemTypeId(GetSoldItem())
    local integer index = GetEquipmentItemTypeByItemTypeId(itemTypeId)
    if (index != 0) then
        if (unitTypeId == ITEM_VALUES_DUMMY_HERO) then
            // allow buying equipment to detect item values
        elseif (unitTypeId != CUSTOMIZABLE_HERO) then
            call RefundItem(GetSoldItem(), owner)
            call SimError(owner, GetLocalizedString("ONLY_CUSTOMIZABLE_HEROES_EQUIPMENT"))
        endif
    //else
        //call BJDebugMsg("No matching learnable skill for item " + GetItemName(GetSoldItem()))
    endif
    set hero = null
    set owner = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSellItem))
    call TriggerAddAction(sellTrigger, function TriggerAction1SellItem)
endfunction

endlibrary
