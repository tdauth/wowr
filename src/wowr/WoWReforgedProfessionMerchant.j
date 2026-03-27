library WoWReforgedProfessionMerchant initializer Init requires ItemTypeUtils, ForceUtils, TextTagUtils, UnitCost

globals
    private trigger purchaseItemTrigger = CreateTrigger()
    private trigger purchaseUnitTrigger = CreateTrigger()
    private trigger constructionFinishTrigger = CreateTrigger()
endglobals

private function UseItemsOfType takes unit hero, integer itemTypeId returns integer
    local integer count = 0
    local item whichItem
    local integer i = 0
    if (hero != null) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set whichItem = UnitItemInSlot(hero, i)
            if (whichItem != null and GetItemTypeId(whichItem) == itemTypeId) then
                set count = count + IMaxBJ(1, GetItemCharges(whichItem))
                call RemoveItem(whichItem)
                set whichItem = null
            endif
            set i = i + 1
        endloop
    endif
    return count
endfunction

private function RefundCosts takes unit hero, integer goldCost, integer lumberCost, integer count returns nothing
    local player owner = GetOwningPlayer(hero)
    local force allies = GetAlliesWithSharedControl(owner)
    local integer cost = 0
    if (count > 0) then
        if (goldCost > 0) then
            set cost = IMinBJ(goldCost, count * 10 * goldCost / 100)
            call AdjustPlayerStateBJ(cost, owner, PLAYER_STATE_GOLD_GATHERED)
            call Bounty(allies, GetUnitX(hero) - 100.0, GetUnitY(hero), cost)
        endif
        if (lumberCost > 0) then
            set cost = IMinBJ(lumberCost, count * 10 * lumberCost / 100)
            call AdjustPlayerStateBJ(cost, owner, PLAYER_STATE_LUMBER_GATHERED)
            call BountyLumber(allies, GetUnitX(hero) - 200.0, GetUnitY(hero), cost)
        endif
    endif
    set owner = null
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

private function MerchantShop takes unit whichUnit returns nothing
    local integer i = 0
    call SetItemTypeSlots(whichUnit, 6)
    call SetUnitTypeSlots(whichUnit, 5)
    set i = 0
    loop
        exitwhen (i == 6)
        call AddItemToStock(whichUnit, ChooseRandomItem(GetRandomInt(0, 8)), 1, 1)
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == 5)
        call AddUnitToStock(whichUnit, ChooseRandomCreep(GetRandomInt(0, 10)), 1, 1)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionPurchaseItem takes nothing returns boolean
    local unit hero = GetBuyingUnit()
    local integer count = UseItemsOfType(hero, ITEM_AMULET_OF_HAGGLE)
    local integer id = GetItemTypeId(GetSoldItem())
    if (GetUnitTypeId(GetSellingUnit()) == MERCHANT_SHOP) then
        set count = count + 2
    endif
    if (count > 0) then
        call RefundCosts(hero, GetItemGoldCost(id), GetItemWoodCost(id), count)
    endif
    set hero = null
    return false
endfunction

private function TriggerConditionPurchaseUnit takes nothing returns boolean
     local unit hero = GetBuyingUnit()
    local integer count = UseItemsOfType(hero, ITEM_AMULET_OF_HAGGLE)
    local integer id = GetUnitTypeId(GetSoldUnit())
    if (GetUnitTypeId(GetSellingUnit()) == MERCHANT_SHOP) then
        set count = count + 2
    endif
    if (count > 0) then
        call RefundCosts(hero, GetUnitGoldCostSafe(id), GetUnitWoodCostSafe(id), count)
    endif
    set hero = null
    return false
endfunction

private function TriggerConditionConstructionFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == MERCHANT_SHOP) then
        call MerchantShop(GetConstructedStructure())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(purchaseItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(purchaseItemTrigger, Condition(function TriggerConditionPurchaseItem))
    
    call TriggerRegisterAnyUnitEventBJ(purchaseUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(purchaseUnitTrigger, Condition(function TriggerConditionPurchaseUnit))
    
    call TriggerRegisterAnyUnitEventBJ(constructionFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionFinishTrigger, Condition(function TriggerConditionConstructionFinish))
endfunction

endlibrary
