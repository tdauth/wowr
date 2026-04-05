library WoWReforgedItemCheck initializer Init requires ItemUtils, WoWReforgedProfessions, WoWReforgedRaces, WoWReforgedProperties, WoWReforgedTomes

globals
    private trigger pickupItemTrigger = CreateTrigger()
    private trigger sellItemTrigger = CreateTrigger()
    private trigger sellUnitTrigger = CreateTrigger()
endglobals

private function PlayerIsAllowedItemRace takes player whichPlayer, integer itemTypeId returns boolean
    local integer itemRace = GetItemRace(itemTypeId)
    return itemRace == udg_RaceNone or PlayerHasRace(whichPlayer, itemRace) or PropertyAllowsItemTypeId(whichPlayer, itemRace, itemTypeId)
endfunction

private function PlayerIsAllowedItemProfession takes player whichPlayer, integer itemTypeId returns boolean
    local integer itemProfession = GetBookItemProfession(itemTypeId)
    return itemProfession == udg_ProfessionNone or PlayerHasProfession(whichPlayer, itemProfession)
endfunction

// TODO Make this function faster by caching item type races and professions!
function CanItemTypeIdBePickedUp takes integer itemTypeId, unit hero returns boolean
    local player heroOwner = GetOwningPlayer(hero)
    local boolean result = true
    if (GetUnitTypeId(hero) != ITEM_VALUES_DUMMY_HERO) then
        if (not udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(heroOwner)]) then
            if (not PlayerIsAllowedItemRace(heroOwner, itemTypeId)) then
                set result = false
            elseif (not PlayerIsAllowedItemProfession(heroOwner, itemTypeId)) then
                set result = false
            endif
        endif
        
        if (result and not udg_Tomes and GetUnitTypeId(hero) != BACKPACK) then
            set result = not IsTome(itemTypeId)
        endif
    endif
    
    set heroOwner = null
    return result
endfunction

private function GetItemTypeIdPickupErrorReason takes integer itemTypeId, unit hero returns string
    local player heroOwner = GetOwningPlayer(hero)
    if (GetUnitTypeId(hero) != ITEM_VALUES_DUMMY_HERO) then
        if (not udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(heroOwner)]) then
            if (PlayerIsAllowedItemRace(heroOwner, itemTypeId)) then
                return Format(GetLocalizedString("BELONGS_TO_RACE")).s(GetObjectName(itemTypeId)).s(GetRaceName(GetItemRace(itemTypeId))).result()
            elseif (not PlayerIsAllowedItemProfession(heroOwner, itemTypeId)) then
                return Format(GetLocalizedString("BELONGS_TO_PROFESSION")).s(GetObjectName(itemTypeId)).s(GetProfessionName(GetBookItemProfession(itemTypeId))).result()
            endif
        endif
        
        if (not udg_Tomes and GetUnitTypeId(hero) != BACKPACK and IsTome(itemTypeId)) then
            return GetLocalizedString("TOMES_DISABLED")
        endif
    endif

    return null
endfunction

/**
 * Abilities will be used multiple times if your hero has the same item multiple times in the inventory.
 * This would craft multiple items and summon multiple units at once which is pretty unbalanced.
 */
private function IsUniqueScepterOrProfessionBook takes item whichItem, unit hero returns boolean
    local integer itemTypeId = GetItemTypeId(whichItem)
    if (GetUnitTypeId(hero) == BACKPACK or GetUnitTypeId(hero) == ITEM_VALUES_DUMMY_HERO) then
        return true
    endif
    if (GetBookItemProfession(itemTypeId) != udg_ProfessionNone or GetObjectRaceType(itemTypeId) == RACE_OBJECT_TYPE_SCEPTER_ITEM) then
        return CountItemsOfItemTypeId(hero, itemTypeId) <= 1
    endif
    return true
endfunction

function CanItemBePickedUp takes item whichItem, unit hero returns boolean
    local player heroOwner = GetOwningPlayer(hero)
    local player itemOwner = GetItemPlayer(whichItem)
    local boolean result = GetUnitTypeId(hero) == ITEM_VALUES_DUMMY_HERO or ((itemOwner == null or itemOwner == Player(PLAYER_NEUTRAL_PASSIVE) or itemOwner == heroOwner) and IsUniqueScepterOrProfessionBook(whichItem, hero) and CanItemTypeIdBePickedUp(GetItemTypeId(whichItem), hero))
    set heroOwner = null
    set itemOwner = null
    return result
endfunction

function GetItemPickupErrorReason takes item whichItem, unit hero returns string
    local player heroOwner = GetOwningPlayer(hero)
    local player itemOwner = GetItemPlayer(whichItem)
    local string result = null
    if (GetUnitTypeId(hero) != ITEM_VALUES_DUMMY_HERO) then
        if (itemOwner != null and itemOwner != Player(PLAYER_NEUTRAL_PASSIVE) and itemOwner != heroOwner) then
            set result = Format(GetLocalizedString("OWNER_IS")).s(GetPlayerNameColored(itemOwner)).result()
        elseif (not IsUniqueScepterOrProfessionBook(whichItem, hero)) then
            set result = GetLocalizedString("ITEM_CAN_ONLY_BE_ONCE_INVENTORY")
        else
            set result = GetItemTypeIdPickupErrorReason(GetItemTypeId(whichItem), hero)
        endif
    endif
    set heroOwner = null
    set itemOwner = null
    return result
endfunction

private function ShowItemPickupError takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("PICKUP_ERROR")).s(GetItemName(whichItem)).s(GetItemPickupErrorReason(whichItem, hero)).result())
endfunction

private function SimErrorRefundProfessionItem takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_PROFESSION")).s(GetItemName(whichItem)).s(GetProfessionName(GetBookItemProfession(GetItemTypeId(whichItem)))).result())
endfunction

private function SimErrorRefundRaceItem takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_RACE")).s(GetItemName(whichItem)).s(GetRaceName(GetObjectRace(GetItemTypeId(whichItem)))).result())
endfunction

private function SimErrorRefundRaceUnit takes unit hero, unit whichUnit returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_RACE")).s(GetUnitName(whichUnit)).s(GetRaceName(GetObjectRace(GetUnitTypeId(whichUnit)))).result())
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    local item whichItem = GetManipulatedItem()
    // The item could have already been removed by some other trigger
    if (GetItemTypeId(whichItem) != 0 and  GetWidgetLife(whichItem) > 0.0 and not CanItemBePickedUp(whichItem, GetTriggerUnit())) then
        call DisableTrigger(GetTriggeringTrigger())
        call ShowItemPickupError(GetTriggerUnit(), whichItem)
        call UnitRemoveItem(GetTriggerUnit(), whichItem)
        call EnableTrigger(GetTriggeringTrigger())
    endif
    set whichItem = null
    return false
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    local unit buyer = GetBuyingUnit()
    local integer buyerUnitTypeId = GetUnitTypeId(buyer)
    local player buyerOwner = GetOwningPlayer(buyer)
    local unit shop = GetTriggerUnit()
    local integer shopUnitTypeId = GetUnitTypeId(shop)
    local item soldItem = GetSoldItem()
    local integer soldItemTypeId = GetItemTypeId(soldItem)
    // Properties are allowed to sell race items.
    if (not udg_UnlockedAll and buyerUnitTypeId != ITEM_VALUES_DUMMY_HERO) then
        if (not PlayerIsAllowedItemProfession(buyerOwner, soldItemTypeId)) then
            call SimErrorRefundProfessionItem(buyer, soldItem)
            call RefundItem(soldItem, buyerOwner)
        elseif (not IsProperty(shopUnitTypeId) and not PlayerHasUnlockedRace(buyerOwner, GetObjectRace(soldItemTypeId))) then
            call SimErrorRefundRaceItem(buyer, soldItem)
            call RefundItem(soldItem, buyerOwner)
        endif
    endif
    set buyer = null
    set buyerOwner = null
    set shop = null
    set soldItem = null
    return false
endfunction

private function TriggerConditionSellUnit takes nothing returns boolean
    local unit soldUnit = GetSoldUnit()
    local integer soldUnitTypeId = GetUnitTypeId(soldUnit)
    local integer shopUnitTypeId = GetUnitTypeId(GetTriggerUnit())
    // The unit could have already been removed by some other trigger
    // Never refund/remove sold heroes.
    if (soldUnitTypeId != 0 and GetWidgetLife(soldUnit) > 0.0 and not IsUnitType(soldUnit, UNIT_TYPE_HERO)) then
        if (not udg_UnlockedAll and not PlayerHasUnlockedRace(GetOwningPlayer(soldUnit), GetObjectRace(soldUnitTypeId))) then
            // Water units (ships) can always be purchased from shipyards.
            if (not IsWaterRaceUnit(GetRaceObjectType(GetObjectRace(soldUnitTypeId), soldUnitTypeId))) then
                // Properties are allowed to sell race units.
                if (not IsProperty(shopUnitTypeId)) then
                    call SimErrorRefundRaceUnit(GetBuyingUnit(), soldUnit)
                    call RefundUnit(soldUnit)
                endif
            endif
        endif
    endif
    set soldUnit = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))

    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition( function TriggerConditionSellItem))

    call TriggerRegisterAnyUnitEventBJ(sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellUnitTrigger, Condition( function TriggerConditionSellUnit))
endfunction

endlibrary
