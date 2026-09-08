library WoWReforgedProfessionMerchant initializer Init requires ItemTypeUtils, ForceUtils, TextTagUtils, UnitCost

globals
    private trigger purchaseItemTrigger = CreateTrigger()
    private trigger purchaseUnitTrigger = CreateTrigger()
    private trigger constructionFinishTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
    private trigger pawnItemTrigger = CreateTrigger()

    private integer array billAbilityIds
    private integer array billAbilityCounters
    private integer billAbilityIdsCounter = 0
endglobals

private function AddBillAbility takes integer abilityId, integer counter returns nothing
    local integer index = billAbilityIdsCounter
    set billAbilityIds[index] = abilityId
    set billAbilityCounters[index] = counter
    set billAbilityIdsCounter = billAbilityIdsCounter + 1
endfunction

private function GetBillAbilityByAbilityId takes integer abilityId returns integer
    local integer i = 0
    loop
        exitwhen (i >= billAbilityIdsCounter)
        if (billAbilityIds[i] == abilityId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

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

private function IsValidTargetItem takes integer itemTypeId returns boolean
    return itemTypeId != ITEM_SMALL_BILL and itemTypeId != ITEM_BILL and itemTypeId != ITEM_LARGE_BILL and itemTypeId != ITEM_RING_OF_THE_TRADING_GUILD
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer index = -1
    local integer count = 0
    if (GetSpellTargetItem() != null) then
        set index = GetBillAbilityByAbilityId(GetSpellAbilityId())
        if (index != -1) then
            if (GetItemCharges(GetSpellTargetItem()) > 0 and IsValidTargetItem(GetItemTypeId(GetSpellTargetItem()))) then
                set count = billAbilityCounters[index]
                call SetItemCharges(GetSpellTargetItem(), GetItemCharges(GetSpellTargetItem()) + count)
            else
                call IssueImmediateOrder(GetTriggerUnit(), "stop")
                call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("INVALID_TARGET_ITEM"))
            endif
        endif
    endif
    return false
endfunction

private function TriggerConditionPawnItem takes nothing returns boolean
    local integer i = 0
    local integer charges = 0
    local integer bounty = 0
    local item slotItem = null
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)) then
        loop
            exitwhen (i >= bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(GetTriggerUnit(), i)
            if (slotItem != null and GetItemTypeId(slotItem) == ITEM_RING_OF_THE_TRADING_GUILD) then
                set charges = charges + GetItemCharges(slotItem)
                call RemoveItem(slotItem)
                set slotItem = null
            endif
            set i = i + 1
        endloop
        if (charges > 0) then
            set bounty = IMaxBJ(GetItemValueGold(GetItemTypeId(GetSoldItem())), 10)
            if (GetItemCharges(GetSoldItem()) > 0) then
                set bounty = GetItemCharges(GetSoldItem()) * bounty
            endif
            call Bounty(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], GetUnitX(GetTriggerUnit()) - 100.0, GetUnitY(GetTriggerUnit()), charges * bounty)
            set bounty = IMaxBJ(GetItemValueLumber(GetItemTypeId(GetSoldItem())), 10)
            if (GetItemCharges(GetSoldItem()) > 0) then
                set bounty = GetItemCharges(GetSoldItem()) * bounty
            endif
            call BountyLumber(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], GetUnitX(GetTriggerUnit()) - 200.0, GetUnitY(GetTriggerUnit()), charges * bounty)
        endif
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

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterAnyUnitEventBJ(pawnItemTrigger, EVENT_PLAYER_UNIT_PAWN_ITEM)
    call TriggerAddCondition(pawnItemTrigger, Condition(function TriggerConditionPawnItem))

    call AddBillAbility('A0U5', 1)
    call AddBillAbility('A0U7', 2)
    call AddBillAbility('A0U8', 3)
endfunction

endlibrary
