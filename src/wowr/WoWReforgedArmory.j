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
            set pageName = GetEquipmentItemTypeCategoryName(i)
            call NextPagedButtonsPage(shop, pageName)
        endif
        call AddPagedButtonsItemType(shop, GetEquipmentItemTypeId(i))
        set i = i + 1
    endloop

    // Forsaken Kingdom
    call NextPagedButtonsPage(shop, "Forsaken Kingdom Equipment")
    call AddPagedButtonsItemType(shop, ITEM_ABOMINATIONS_HOOK)
    call AddPagedButtonsItemType(shop, ITEM_AGUS_SHAMBLING_HAND)
    call AddPagedButtonsItemType(shop, ITEM_ANCIENT_BRONZE_HELMET)
    call AddPagedButtonsItemType(shop, ITEM_ARMOR_OF_THE_SCARLET_CRUSADE)
    call AddPagedButtonsItemType(shop, ITEM_BANDIT_MASK)
    call AddPagedButtonsItemType(shop, ITEM_BLACKSMITHS_APRON)
    call AddPagedButtonsItemType(shop, ITEM_BLADE_DANCERS_GERAVES)
    call AddPagedButtonsItemType(shop, ITEM_BLIGHTWEAVER_BOOTS)
    call AddPagedButtonsItemType(shop, ITEM_BLUE_DRAGON_FIGURINE)

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
