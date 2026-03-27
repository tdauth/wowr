library WoWReforgedItemCheck requires ItemUtils, WoWReforgedProfessions, WoWReforgedRaces, WoWReforgedProperties, WoWReforgedTomes

function PlayerIsAllowedItemRace takes player whichPlayer, integer itemTypeId returns boolean
    local integer itemRace = GetItemRace(itemTypeId)
    return itemRace == udg_RaceNone or PlayerHasRace(whichPlayer, itemRace) or PropertyAllowsItemTypeId(whichPlayer, itemRace, itemTypeId)
endfunction

function PlayerIsAllowedItemProfession takes player whichPlayer, integer itemTypeId returns boolean
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

function GetItemTypeIdPickupErrorReason takes integer itemTypeId, unit hero returns string
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
function IsUniqueScepterOrProfessionBook takes item whichItem, unit hero returns boolean
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

function ShowItemPickupError takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("PICKUP_ERROR")).s(GetItemName(whichItem)).s(GetItemPickupErrorReason(whichItem, hero)).result())
endfunction

function SimErrorRefundProfessionItem takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_PROFESSION")).s(GetItemName(whichItem)).s(GetProfessionName(GetBookItemProfession(GetItemTypeId(whichItem)))).result())
endfunction

function SimErrorRefundRaceItem takes unit hero, item whichItem returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_RACE")).s(GetItemName(whichItem)).s(GetRaceName(GetObjectRace(GetItemTypeId(whichItem)))).result())
endfunction

function SimErrorRefundRaceUnit takes unit hero, unit whichUnit returns nothing
    call SimError(GetOwningPlayer(hero), Format(GetLocalizedString("BELONGS_TO_RACE")).s(GetUnitName(whichUnit)).s(GetRaceName(GetObjectRace(GetUnitTypeId(whichUnit)))).result())
endfunction

endlibrary
