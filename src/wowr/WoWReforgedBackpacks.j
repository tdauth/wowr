/**
 * World of Warcraft Reforged Backpack System
 *
 * A backpack is a hero with a hero inventory consisting of multiple pages. The items in its inventory do not affect the backpack hero in any way. However, they can be transported, stacked, dropped and moved into different slots.
 * The pages are changed with abilities of the backpack hero.
 * The backpack hero is always moved to the location of the player's first hero automatically which allows exchanging items faster.
 */
library WoWReforgedBackpacks initializer Init requires HeroUtils, ItemUtils, CargoLocationSystem, TextTagUtils, WoWReforgedUtils, WoWReforgedItemCheck, WoWReforgedUiBackpackEvaluate

globals
    constant integer BACKPACK_NEXT_PAGE_ABILITY_ID = 'A02L'
    constant integer BACKPACK_PREVIOUS_PAGE_ABILITY_ID = 'A02M'
    constant integer BACKPACK_MAX_PAGES = 30
    constant real BACKPACK_MOVE_INTERVAL = 0.10

    constant integer A_ORDER_ID_SMART = 851971
    constant integer A_ORDER_ID_MOVE = 851986
    constant integer A_ORDER_ID_DROP_ITEM = 852001
    constant integer A_ORDER_ID_MOVE_SLOT_0 = 852002
    constant integer A_ORDER_ID_MOVE_SLOT_1 = 852003
    constant integer A_ORDER_ID_MOVE_SLOT_2 = 852004
    constant integer A_ORDER_ID_MOVE_SLOT_3 = 852005
    constant integer A_ORDER_ID_MOVE_SLOT_4 = 852006
    constant integer A_ORDER_ID_MOVE_SLOT_5 = 852007
    constant integer A_ORDER_ID_USE_SLOT_0 = 852008
    constant integer A_ORDER_ID_USE_SLOT_1 = 852009
    constant integer A_ORDER_ID_USE_SLOT_2 = 852010
    constant integer A_ORDER_ID_USE_SLOT_3 = 852011
    constant integer A_ORDER_ID_USE_SLOT_4 = 852012
    constant integer A_ORDER_ID_USE_SLOT_5 = 852013

    // item slot data
    private integer array BackpackItemType
    private integer array BackpackItemCharges
    private boolean array BackpackItemPawnable
    private boolean array BackpackItemInvulnerable
    private string array BackpackItemName
    private string array BackpackItemDescription
    private string array BackpackItemTooltip
    private string array BackpackItemTooltipExtended
    private player array BackpackItemPlayer

    // player data
    private unit array Backpack
    private integer array BackpackPageNumber
    private trigger array BackpackTriggerChangePage
    private trigger array BackpackTriggerPickup
    private trigger array BackpackTriggerDrop
    private trigger array BackpackTriggerMove
    private trigger array BackpackTriggerOrder
    private item array BackpackTargetItem
    private boolean array BackpackPlayerBagInfo
    
    private boolean BackpackPickupTimerHasStarted = false

    private timer BackpackPickupTimer = CreateTimer()
    private timer BackpackUpdateLocationTimer = CreateTimer()
endglobals

function SetPlayerBagInfo takes player whichPlayer, boolean info returns nothing
    set BackpackPlayerBagInfo[GetPlayerId(whichPlayer)] = info
endfunction

function GetPlayerBagInfo takes player whichPlayer returns boolean
    return BackpackPlayerBagInfo[GetPlayerId(whichPlayer)]
endfunction

function GetPlayerBackpack takes player whichPlayer returns unit
    return Backpack[GetPlayerId(whichPlayer)]
endfunction

function PlayerHasBackpack takes player whichPlayer returns boolean
    return GetPlayerBackpack(whichPlayer) != null
endfunction

function BackpackMessage takes player whichPlayer, string message returns nothing
    if (GetPlayerBagInfo(whichPlayer)) then
        call UnitMessage(GetPlayerBackpack(whichPlayer), message)
    endif
endfunction

function GetBackpackItemIndex takes integer playerId, integer page, integer slot returns integer
    return Index3D(playerId, page, slot, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
endfunction

function GetBackpackItemTypeId takes integer index returns integer
    return BackpackItemType[index]
endfunction

function GetBackpackItemCharges takes integer index returns integer
    return BackpackItemCharges[index]
endfunction

function GetBackpackItemIsPawnable takes integer index returns boolean
    return BackpackItemPawnable[index]
endfunction

function GetBackpackItemTooltipExtended takes integer index returns string
    return BackpackItemTooltipExtended[index]
endfunction

function GetBackpackItemPlayer takes integer index returns player
    return BackpackItemPlayer[index]
endfunction

function ClearBackpackItem takes integer index returns nothing
    set BackpackItemType[index] = 0
    set BackpackItemCharges[index] = 0
    set BackpackItemPawnable[index] = false
    set BackpackItemInvulnerable[index] = false
    set BackpackItemName[index] = ""
    set BackpackItemDescription[index] = ""
    set BackpackItemTooltip[index] = ""
    set BackpackItemTooltipExtended[index] = ""
    set BackpackItemPlayer[index] = null
endfunction

function SetBackpackItemFromItem takes item whichItem, integer index returns nothing
    set BackpackItemType[index] = GetItemTypeId(whichItem)
    set BackpackItemCharges[index] = GetItemCharges(whichItem)
    set BackpackItemPawnable[index] = IsItemPawnable(whichItem)
    set BackpackItemInvulnerable[index] = IsItemInvulnerable(whichItem)
    set BackpackItemName[index] = GetItemName(whichItem)
    set BackpackItemDescription[index] = BlzGetItemDescription(whichItem)
    set BackpackItemTooltip[index] = BlzGetItemTooltip(whichItem)
    set BackpackItemTooltipExtended[index] = BlzGetItemExtendedTooltip(whichItem)
    set BackpackItemPlayer[index] = GetItemPlayer(whichItem)
endfunction

function ApplyBackpackItem takes item whichItem, integer index returns nothing
    call SetItemCharges(whichItem, BackpackItemCharges[index])
    call SetItemPawnable(whichItem, BackpackItemPawnable[index])
    call SetItemDroppable(whichItem, true) // all items must be droppable in the backpack!
    call SetItemInvulnerable(whichItem, BackpackItemInvulnerable[index])
    call BlzSetItemName(whichItem, BackpackItemName[index])
    call BlzSetItemDescription(whichItem, BackpackItemDescription[index])
    call BlzSetItemTooltip(whichItem, BackpackItemTooltip[index])
    call BlzSetItemExtendedTooltip(whichItem, BackpackItemTooltipExtended[index])
    call SetItemPlayer(whichItem, BackpackItemPlayer[index], false)
endfunction

function SetBackpackItemFromIndex takes integer index, integer sourceIndex returns nothing
    set BackpackItemType[index] = BackpackItemType[sourceIndex]
    set BackpackItemCharges[index] = BackpackItemCharges[sourceIndex]
    set BackpackItemPawnable[index] = BackpackItemPawnable[sourceIndex]
    set BackpackItemInvulnerable[index] = BackpackItemInvulnerable[sourceIndex]
    set BackpackItemName[index] = BackpackItemName[sourceIndex]
    set BackpackItemDescription[index] = BackpackItemDescription[sourceIndex]
    set BackpackItemTooltip[index] = BackpackItemTooltip[sourceIndex]
    set BackpackItemTooltipExtended[index] = BackpackItemTooltipExtended[sourceIndex]
    set BackpackItemPlayer[index] = BackpackItemPlayer[sourceIndex]
endfunction

function BackpackCountItemsOfItemTypeForPlayer takes player whichPlayer, integer itemTypeId returns integer
    local integer playerId = GetPlayerId(whichPlayer)
	local integer i = 0
    local integer j = 0
    local integer index = 0
    local integer result = 0
    local item slotItem = null
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            if (BackpackPageNumber[playerId] == i) then
                set slotItem = UnitItemInSlot(Backpack[playerId], j)
				if (slotItem != null and GetItemTypeId(slotItem) == itemTypeId) then
					set result = result + 1
				endif
                set slotItem = null
            else
				if (BackpackItemType[index] == itemTypeId) then
					set result = result + 1
				endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
	return result
endfunction

function Hero1CountItemsOfItemType takes unit hero, integer itemTypeId returns integer
    local player owner = GetOwningPlayer(hero)
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    local integer result = CountItemsOfItemTypeId(hero, itemTypeId)
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(GetPlayerEquipmentBags(owner)))
        set result = result + CountItemsOfItemTypeId(BlzGroupUnitAt(GetPlayerEquipmentBags(owner), i), itemTypeId)
        set i = i + 1
    endloop
    set owner = null
	return result
endfunction

function PlayerCountItemsOfItemType takes player whichPlayer, integer itemTypeId returns integer
    local integer result = BackpackCountItemsOfItemTypeForPlayer(whichPlayer, itemTypeId)
    local unit hero1 = GetPlayerHero1(whichPlayer)
    local unit hero2 = GetPlayerHero2(whichPlayer)
    local unit hero3 = GetPlayerHero3(whichPlayer)
    if (hero1 != null) then
        set result = result + Hero1CountItemsOfItemType(hero1, itemTypeId)
    endif
    if (hero2 != null) then
        set result = result + Hero1CountItemsOfItemType(hero2, itemTypeId)
    endif
    if (hero3 != null) then
        set result = result + Hero1CountItemsOfItemType(hero3, itemTypeId)
    endif

    return result
endfunction

function HeroDropRandomItem takes unit hero returns item
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    local unit array heroes
    local integer array slots
    local integer counter = 0
    local unit bag = null
    local integer maxBags = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(hero, i) != null) then
            set heroes[counter] = hero
            set slots[counter] = i
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    if (hero == GetPlayerHero1(owner)) then
        set maxBags = BlzGroupGetSize(GetPlayerEquipmentBags(owner))
        set i = 0
        loop
            exitwhen(i == maxBags)
            set bag = BlzGroupUnitAt(GetPlayerEquipmentBags(owner), i)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                if (UnitItemInSlot(bag, j) != null) then
                    set heroes[counter] = bag
                    set slots[counter] = j
                    set counter = counter + 1
                endif
                set j = j + 1
            endloop
            set bag = null
            set i = i + 1
        endloop
    endif
    set owner = null
    if (counter > 0) then
        set i = GetRandomInt(0, counter)
        return UnitRemoveItemFromSlot(heroes[i], slots[i])
    endif

    return null
endfunction

function RemoveAllBackpackItemTypesForPlayer takes player whichPlayer, integer itemTypeId returns integer
    local integer playerId = GetPlayerId(whichPlayer)
	local integer i = 0
    local integer j = 0
    local integer index = 0
    local integer result = 0
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            if (BackpackPageNumber[playerId] == i) then
				if (UnitItemInSlot(Backpack[playerId], j) != null and GetItemTypeId(UnitItemInSlot(Backpack[playerId], j)) == itemTypeId) then
					call RemoveItem(UnitItemInSlot(Backpack[playerId], j))
					set result = result + 1
				endif
            else
				if (BackpackItemType[index] == itemTypeId) then
                    call ClearBackpackItem(index)
					set result = result + 1
				endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
	return result
endfunction

// This does not clear the backpack inventory!
function DropBackpackForPlayerTo takes player whichPlayer, real x, real y returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local item whichItem = null
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            if (BackpackPageNumber[playerId] == i) then
                set whichItem = CreateItem(GetItemTypeId(UnitItemInSlot(Backpack[playerId], j)), x, y)
            else
                set whichItem = CreateItem(BackpackItemType[index], x, y)
            endif

            call ApplyBackpackItem(whichItem, index)

            if (BackpackPageNumber[playerId] == i) then
                call SetItemCharges(whichItem, GetItemCharges(UnitItemInSlot(Backpack[playerId], j)))
            else
                call SetItemCharges(whichItem, BackpackItemCharges[index])
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    
    call UpdateItemsForBackpackUIEvaluate(whichPlayer)
endfunction

function DropBackpackForPlayer takes player whichPlayer, rect whichRect returns nothing
    call DropBackpackForPlayerTo(whichPlayer,  GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

function DropBackpack takes player whichPlayer returns integer
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local item whichItem = null
    local real x = GetUnitX(Backpack[playerId])
    local real y = GetUnitY(Backpack[playerId])
    local integer result = 0
    // drop before so they won't have to be cleared or removed
    set result = DropAllItemsFromHero(Backpack[playerId])
    set j = 0
    loop
        exitwhen (j == bj_MAX_INVENTORY)
        set index = Index3D(playerId, BackpackPageNumber[playerId], j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
        call ClearBackpackItem(index)
        set j = j + 1
    endloop
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            if (BackpackItemType[index] != 0) then
                set whichItem = CreateItem(BackpackItemType[index], x, y)
                call ApplyBackpackItem(whichItem, index)
                call SetItemCharges(whichItem, BackpackItemCharges[index])
                call ClearBackpackItem(index)
                set result = result + 1
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    
    call UpdateItemsForBackpackUIEvaluate(whichPlayer)

    return result
endfunction

function DropFirstItemFromHeroAtRect takes unit hero, integer itemTypeId, rect whichRect returns item
    local item whichItem = DropFirstItemFromHero(hero, itemTypeId)
    if (whichItem != null) then
        call SetItemPosition(whichItem, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
    endif
    return whichItem
endfunction

function DropQuestItemFromHeroAtRect takes player whichPlayer, integer itemTypeId, rect whichRect returns item
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local item slotItem = null
    local item whichItem = DropFirstItemFromHeroAtRect(GetPlayerHero1(whichPlayer), itemTypeId, whichRect)
	// Check second hero inventory
	if (whichItem == null and GetPlayerHero2(whichPlayer) != null) then
        set whichItem = DropFirstItemFromHeroAtRect(GetPlayerHero2(whichPlayer), itemTypeId, whichRect)
	endif
	// Check third hero inventory
	if (whichItem == null and GetPlayerHero3(whichPlayer) != null) then
		set whichItem = DropFirstItemFromHeroAtRect(GetPlayerHero3(whichPlayer), itemTypeId, whichRect)
	endif
	// Check Equipment Bags
	if (whichItem == null and GetPlayerEquipmentBags(whichPlayer) != null) then
        set i = 0
        loop
            exitwhen(i == BlzGroupGetSize(GetPlayerEquipmentBags(whichPlayer)) or whichItem != null)
            set whichItem = DropFirstItemFromHeroAtRect(BlzGroupUnitAt(GetPlayerEquipmentBags(whichPlayer), i), itemTypeId, whichRect)
            set i = i + 1
        endloop
	endif
    // Check the backpack
    if (whichItem == null) then
        set i = 0
        loop
            exitwhen(i == BACKPACK_MAX_PAGES or whichItem != null)
            set j = 0
            loop
                exitwhen(j == bj_MAX_INVENTORY or whichItem != null)
                set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
                if (BackpackPageNumber[playerId] == i) then
                    set slotItem = UnitItemInSlot(Backpack[playerId], j)
                endif
                if (BackpackItemType[index] == itemTypeId or (BackpackPageNumber[playerId] == i and GetItemTypeId(slotItem) == itemTypeId)) then
                    if (BackpackPageNumber[playerId] == i) then
                        call UnitRemoveItem(Backpack[playerId], slotItem)
                        call SetItemPosition(slotItem, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
                    else
                        set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
                        call SetBackpackItemFromItem(whichItem, index)
                    endif
                    call ClearBackpackItem(index)
                endif
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif

    return whichItem
endfunction

function DropQuestItemFromHeroAtRectByDyingUnit takes integer itemTypeId, rect whichRect returns item
    return DropQuestItemFromHeroAtRect(GetOwningPlayer(GetDyingUnit()), itemTypeId, whichRect)
endfunction

function DropQuestItemFromDyingUnit takes nothing returns item
    return DropQuestItemFromHeroAtRectByDyingUnit(udg_TmpItemTypeId, udg_TmpRect)
endfunction

function ClearCurrentBackpackPageForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer j = 0
    local integer index = 0
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, BackpackPageNumber[playerId], j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearBackpackItem(index)
            set j = j + 1
        endloop
endfunction

function ClearBackpackForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearBackpackItem(index)
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddItemToBackpackForPlayer takes player whichPlayer, item whichItem returns boolean
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local integer itemRespawn = -1
    local item slotItem = null
    // try to add it to the inventory first
    set i = 0
    loop
        exitwhen(i == bj_MAX_INVENTORY)
        exitwhen (whichItem == null)
        set slotItem = UnitItemInSlot(Backpack[playerId], i)
        if (slotItem == null or (GetItemCharges(whichItem) > 0 and GetItemTypeId(whichItem) == GetItemTypeId(slotItem) and GetMaxStacksByItemTypeId(GetItemTypeId(whichItem)) >= GetItemCharges(slotItem) + GetItemCharges(whichItem))) then
            if (UnitAddItem(Backpack[playerId], whichItem)) then
                call BackpackMessage(whichPlayer, Format(GetLocalizedString("BAG_ADDED")).s(GetItemName(whichItem)).i(i + 1).i(j + 1).result()) // Added %1% to backpack bag %2% by stacking it to slot %3%.

                set whichItem = null
                return true
            else
                // TODO Seems to happen for slots with the same item type. If this does not work by default, we have to change the charges and update the backpack page.
                call BackpackMessage(whichPlayer, Format(GetLocalizedString("BAG_ADDED_PROBLEM")).s(GetItemName(whichItem)).i(BackpackPageNumber[playerId] + 1).i(i + 1).result()) // Problem on adding %1% to backpack bag %2% by stacking it to slot %3%.
            endif
        endif
        set slotItem = null
        set i = i + 1
    endloop
    // try adding it to another bag then
    set i = 0
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        exitwhen (whichItem == null)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            exitwhen (whichItem == null)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            // empty slot
            if (BackpackItemType[index] == 0) then
                if (GetPlayerBagInfo(whichPlayer)) then
                    call BackpackMessage(whichPlayer, Format(GetLocalizedString("BAG_ADDED_EMPTY")).s(GetItemName(whichItem)).i(i + 1).i(j + 1).result()) // Added %1% to backpack bag %2% to empty slot %3%.
                endif
                call SetBackpackItemFromItem(whichItem, index)
                set itemRespawn = GetItemRespawnIndex(whichItem)
                call RemoveItem(whichItem)
                set whichItem = null
                if (itemRespawn != -1) then
                    call StartItemRespawn(itemRespawn)
                endif

                return true
            // stack
            elseif (GetItemCharges(whichItem) > 0 and GetItemTypeId(whichItem) == BackpackItemType[index] and GetMaxStacksByItemTypeId(BackpackItemType[index]) >= BackpackItemCharges[index] + GetItemCharges(whichItem)) then
                call BackpackMessage(whichPlayer, Format(GetLocalizedString("BAG_ADDED")).s(GetItemName(whichItem)).i(i + 1).i(j + 1).result()) // Added %1% to backpack bag %2% by stacking it to slot %3%.
                set BackpackItemCharges[index] = BackpackItemCharges[index] + GetItemCharges(whichItem)
                set itemRespawn = GetItemRespawnIndex(whichItem)
                call RemoveItem(whichItem)
                set whichItem = null
                if (itemRespawn != -1) then
                    call StartItemRespawn(itemRespawn)
                endif

                return true
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    
    call UpdateItemsForBackpackUIEvaluate(whichPlayer)

    return false
endfunction

function DestroyBackpackSystemForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    if (Backpack[playerId] != null) then
        call RemoveUnit(Backpack[playerId])
        set Backpack[playerId] = null
    endif
    call ClearBackpackForPlayer(whichPlayer)
endfunction

function DisableItemPickupTriggers takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
	call DisableTrigger(BackpackTriggerPickup[playerId])
	call DisableTrigger(BackpackTriggerDrop[playerId])
endfunction

function EnableItemPickupTriggers takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
	call EnableTrigger(BackpackTriggerPickup[playerId])
	call EnableTrigger(BackpackTriggerDrop[playerId])
endfunction

function GetBackpackPageNumber takes player whichPlayer returns integer
    local integer playerId = GetPlayerId(whichPlayer)
    return BackpackPageNumber[playerId]
endfunction

function RefreshBackpackPage takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer page = GetBackpackPageNumber(whichPlayer)
    local integer i = 0
    local integer index = 0
    local item whichItem = null
	call DisableItemPickupTriggers(whichPlayer)
    // Create All Items From Next/Previous Page
    set i = 0
    loop
        exitwhen(i == bj_MAX_INVENTORY)
        set index = Index3D(playerId, page, i, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
        if (BackpackItemType[index] != 0) then
            //call BJDebugMsg("Item type " + GetObjectName(BackpackItemType[index]) + " at index " + I2S(index))
            call UnitAddItemToSlotById(Backpack[playerId], BackpackItemType[index], i)
            set whichItem = UnitItemInSlot(Backpack[playerId], i)
            call ApplyBackpackItem(whichItem, index)
        //else
            //call BJDebugMsg("Empty at index " + I2S(index))
        endif
        set i = i + 1
    endloop
	call EnableItemPickupTriggers(whichPlayer)
endfunction

function ChangeBackpackPageEx takes player whichPlayer, integer newBackpackPage returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer index = 0
    local item SlotItem = null
	call DisableItemPickupTriggers(whichPlayer)
    // Save All Items
    set i = 0
    loop
        exitwhen(i == bj_MAX_INVENTORY)
        set index = Index3D(playerId, BackpackPageNumber[playerId], i, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
        set SlotItem = UnitItemInSlot(GetPlayerBackpack(whichPlayer), i)
        if (SlotItem != null) then
            call SetBackpackItemFromItem(SlotItem, index)
            //call BJDebugMsg("Storing at index " + I2S(index) + " with type " + GetObjectName(BackpackItemType[index]))
            call RemoveItem(SlotItem)
            set SlotItem = null
        else
            //call BJDebugMsg("Storing empty at index " + I2S(index))
            call ClearBackpackItem(index)
        endif
        set i = i + 1
    endloop
	call EnableItemPickupTriggers(whichPlayer)
	// change page
    set BackpackPageNumber[playerId] = newBackpackPage
    call BlzSetUnitName(GetPlayerBackpack(whichPlayer), Format(GetLocalizedString("BAG_WITH_INDEX")).i(newBackpackPage + 1).result()) // Bag %1%
    //call BackpackMessage(whichPlayer, ("Open Bag " + I2S(newBackpackPage + 1) + "."))
    call RefreshBackpackPage(whichPlayer)
endfunction

function ChangeToNextFreeBagInBackpack takes player whichPlayer returns integer
    local integer playerId = GetPlayerId(whichPlayer)
    local integer currentPage = BackpackPageNumber[playerId]
    local integer result = -1
    local integer index = 0
    local integer j = 0
    local integer i = currentPage
    loop
        exitwhen(i == BACKPACK_MAX_PAGES)
        exitwhen (result != -1)
        set j = 0
        loop
            exitwhen(j == bj_MAX_INVENTORY)
            exitwhen (result != -1)
            set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            // empty slot
            if (BackpackItemType[index] == 0) then
                set result = i
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    if (result == -1) then
        set i = 0
        loop
            exitwhen(i >= currentPage)
            exitwhen (result != -1)
            set j = 0
            loop
                exitwhen(j == bj_MAX_INVENTORY)
                exitwhen (result != -1)
                set index = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
                // empty slot
                if (BackpackItemType[index] == 0) then
                    set result = i
                endif
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif
    
    if (result != -1) then
        call ChangeBackpackPageEx(whichPlayer, result)
    endif
    
    return result
endfunction

function ChangeToFirstBagInBackpack takes player whichPlayer returns nothing
    call ChangeBackpackPageEx(whichPlayer, 0)
endfunction

function ChangeToLastBagInBackpack takes player whichPlayer returns nothing
    call ChangeBackpackPageEx(whichPlayer, BACKPACK_MAX_PAGES - 1)
endfunction

function ChangeBackpackPage takes player whichPlayer, boolean next returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer page = BackpackPageNumber[playerId]
    local integer newPage = 0
    if (next) then
        if (page != (BACKPACK_MAX_PAGES - 1)) then
            set newPage = page + 1
        else
            set newPage = 0
        endif
    else
        if (page != 0) then
            set newPage = page - 1
        else
            set newPage = BACKPACK_MAX_PAGES - 1
        endif
    endif
    call ChangeBackpackPageEx(whichPlayer, newPage)
endfunction

function ClearHeroInventory takes unit hero returns nothing
    local item slotItem = null
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_INVENTORY)
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem != null) then
            call RemoveItem(slotItem)
            set slotItem = null
        endif
        set i = i + 1
    endloop
endfunction

// Starts from left to right and tries to stack all items of the same type which can be stacked or move items to empty slots.
function OrderBackpack takes player whichPlayer returns integer
    local integer playerId = GetPlayerId(whichPlayer)
    local integer orderedItems = 0
    local integer index1 = 0
    local integer index2 = 0
    local integer maxCharges1 = 0
    local integer charges1 = 0
    local integer charges2 = 0
    local integer stackedCharges = 0
    local integer itemTypeId1 = 0
    local integer itemTypeId2 = 0
    local integer i = 0
    local integer j = 0
    local integer k = 0
    local integer l = 0
    local integer countEmptySlotsAfter = 0
    local integer remainingSlotsAfter = 0
    local boolean doneWithCurrentSlot = false
    local boolean doneWithAll = false
    loop
        exitwhen (i == BACKPACK_MAX_PAGES or doneWithAll)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY or doneWithAll)
            set index1 = Index3D(playerId, i, j, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            set itemTypeId1 = BackpackItemType[index1]
            set charges1 = BackpackItemCharges[index1]
            set maxCharges1 = GetMaxStacksByItemTypeId(itemTypeId1)
            set doneWithCurrentSlot = itemTypeId1 != 0 and (charges1 == 0) or (charges1 >= maxCharges1) // stop if the slot is already full
            set countEmptySlotsAfter = 0
            set remainingSlotsAfter = (bj_MAX_INVENTORY - j - 1) + IMaxBJ(0, (BACKPACK_MAX_PAGES - i - 1)) * bj_MAX_INVENTORY
            set k = i
            loop
                exitwhen (k >= BACKPACK_MAX_PAGES or doneWithCurrentSlot)
                if (k == i) then
                    set l = j + 1
                else
                    set l = 0
                endif
                loop
                    exitwhen (l >= bj_MAX_INVENTORY or doneWithCurrentSlot)
                    set index2 = Index3D(playerId, k, l, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
                    set itemTypeId2 = BackpackItemType[index2]
                    set charges2 = BackpackItemCharges[index2]
                    // stack items
                    if (itemTypeId1 != 0 and itemTypeId1 == itemTypeId2 and charges1 > 0 and charges1 < maxCharges1) then
                        set orderedItems = orderedItems + 1
                        
                        set stackedCharges = IMinBJ(charges2, maxCharges1 - charges1)
                        set charges1 = charges1 + stackedCharges
                        set BackpackItemCharges[index1] = charges1

                        if (stackedCharges == charges2) then
                            call ClearBackpackItem(index2)
                            set countEmptySlotsAfter = countEmptySlotsAfter + 1
                        else
                            set BackpackItemCharges[index2] = charges2 - stackedCharges
                        endif

                        set doneWithCurrentSlot = charges1 >= maxCharges1
                    // move the item to this empty slot
                    elseif (itemTypeId1 == 0 and itemTypeId2 != 0) then
                        set orderedItems = orderedItems + 1
                        set countEmptySlotsAfter = countEmptySlotsAfter + 1
                        
                        set itemTypeId1 = itemTypeId2
                        set charges1 = charges2
                        set maxCharges1 = GetMaxStacksByItemTypeId(itemTypeId2)

                        call SetBackpackItemFromIndex(index1, index2)
                        call ClearBackpackItem(index2)
                        
                        set doneWithCurrentSlot = charges1 == 0 or charges1 >= maxCharges1 // stop if it is not stackable
                    elseif (itemTypeId2 == 0) then
                        set countEmptySlotsAfter = countEmptySlotsAfter + 1
                    endif
                    set l = l + 1
                endloop
                set k = k + 1
            endloop
            
            //call BJDebugMsg("Remaining slots after " + I2S(remainingSlotsAfter) + " and empty slots " + I2S(countEmptySlotsAfter))
            
            // stop early if there are only empty slots remaining
            set doneWithAll = (countEmptySlotsAfter >= remainingSlotsAfter)
            
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    call ClearHeroInventory(GetPlayerBackpack(whichPlayer))
    call RefreshBackpackPage(whichPlayer)
    call UpdateItemsForBackpackUIEvaluate(whichPlayer)
    
    call BackpackMessage(whichPlayer, Format(GetLocalizedString("ORDERED_ITEMS")).i(orderedItems).result()) // Ordered %1% items.
    
    return orderedItems
endfunction

private function TriggerConditionChangeBackpackPage takes nothing returns boolean
    return GetSpellAbilityId() == BACKPACK_NEXT_PAGE_ABILITY_ID or GetSpellAbilityId() == BACKPACK_PREVIOUS_PAGE_ABILITY_ID
endfunction

private function TriggerFunctionChangeBackpackPage takes nothing returns nothing
    if (GetSpellAbilityId() == BACKPACK_NEXT_PAGE_ABILITY_ID) then
        call ChangeBackpackPage(GetOwningPlayer(GetTriggerUnit()), true)
    elseif (GetSpellAbilityId() == BACKPACK_PREVIOUS_PAGE_ABILITY_ID) then
        call ChangeBackpackPage(GetOwningPlayer(GetTriggerUnit()), false)
    endif
    call UpdateItemsForBackpackUIEvaluate(GetOwningPlayer(GetTriggerUnit()))
endfunction

private function TriggerConditionPickupBackpackItem takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    return GetTriggerUnit() == Backpack[playerId]
endfunction

private function TriggerFunctionPickupBackpackItem takes nothing returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    local item whichItem = null
    local integer index = 0
    local integer i = 0
    // update the backpack items from the current inventory
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(GetTriggerUnit(), i)
        if (whichItem != null) then
            set index = Index3D(playerId, BackpackPageNumber[playerId], i, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            call SetBackpackItemFromItem(whichItem, index)
            set whichItem = null
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUIEvaluate(GetOwningPlayer(GetTriggerUnit()))
endfunction

private function TriggerConditionDropBackpackItem takes nothing returns boolean
    return GetTriggerUnit() == Backpack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction

private function TriggerFunctionDropBackpackItem takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer playerId = GetPlayerId(owner)
    local integer index = 0
    local integer i = 0
    call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(triggerUnit, i) == null) then
            set index = Index3D(playerId, BackpackPageNumber[playerId], i, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(BackpackItemType[index]))
            set BackpackItemType[index] = 0
            set BackpackItemCharges[index] = 0
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUIEvaluate(owner)
    set owner = null
    set triggerUnit = null
endfunction

private function IsMoveItemOrder takes integer orderId returns boolean
    return orderId >= A_ORDER_ID_MOVE_SLOT_0 and orderId <= A_ORDER_ID_MOVE_SLOT_5
endfunction

private function IsRedirectOrder takes integer orderId returns boolean
    return orderId == A_ORDER_ID_SMART or orderId == A_ORDER_ID_MOVE or orderId == A_ORDER_ID_DROP_ITEM
endfunction

private function TriggerConditionMoveBackpackItem takes nothing returns boolean
    local integer orderId = GetIssuedOrderId()
    return GetTriggerUnit() == Backpack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] and (IsMoveItemOrder(orderId) or IsRedirectOrder(orderId))
endfunction

private function TriggerFunctionMoveBackpackItem takes nothing returns nothing
    local integer orderId = GetIssuedOrderId()
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer playerId = GetPlayerId(owner)
    local integer i = 0
    local item whichItem = null
    local integer index = 0
    local item orderTargetItem = GetOrderTargetItem()
    local unit orderTargetUnit = GetOrderTargetUnit()
    local boolean smartOrder = IsRedirectOrder(orderId)
    local boolean moveItem = IsMoveItemOrder(orderId)
    if (moveItem) then
        call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
        //call BJDebugMsg("Moved item!")
        // update all items of the current bag after moving the item
        set i = 0
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set index = Index3D(playerId, BackpackPageNumber[playerId], i, BACKPACK_MAX_PAGES, bj_MAX_INVENTORY)
            set whichItem = UnitItemInSlot(triggerUnit, i)
            if (whichItem == null) then
                //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(BackpackItemType[index]))
                call ClearBackpackItem(index)
            else
                call SetBackpackItemFromItem(whichItem, index)
            endif
            set i = i + 1
        endloop
        call UpdateItemsForBackpackUIEvaluate(owner)
    elseif (GetPlayerHero1(owner) != null and IsRedirectOrder(orderId)) then
        if (orderTargetItem != null) then
            // redirect order to hero
            call IssueTargetOrderById(GetPlayerHero1(owner), orderId, orderTargetItem)
        elseif (orderTargetUnit != null) then
            if (orderId == A_ORDER_ID_DROP_ITEM) then
                if (DistanceBetweenUnits(triggerUnit, orderTargetUnit) > 200.0) then
                    call IssueTargetOrderById(GetPlayerHero1(owner), A_ORDER_ID_MOVE, orderTargetUnit)
                endif
            else
                call IssueTargetOrderById(GetPlayerHero1(owner), orderId, orderTargetUnit)
            endif
        endif
    endif
    set orderTargetItem = null
    set orderTargetUnit = null
    set owner = null
    set triggerUnit = null
endfunction

function InventoryIsFull takes unit whichUnit, integer itemTypeId returns boolean
    local integer size = UnitInventorySize(whichUnit)
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == size)
        set whichItem = UnitItemInSlot(whichUnit, i)
        if (whichItem == null or (GetItemTypeId(whichItem) == itemTypeId and GetMaxStacksByItemTypeId(itemTypeId) > GetItemCharges(whichItem))) then
            return false
        endif
        set whichItem = null
        set i = i + 1
    endloop
    return true
endfunction

private function TriggerConditionOrderBackpackItem takes nothing returns boolean
    return GetPlayerHero1(GetOwningPlayer(GetTriggerUnit())) == GetTriggerUnit() and GetIssuedOrderId() == A_ORDER_ID_SMART and GetOrderTargetItem() != null and not IsItemPowerup(GetOrderTargetItem()) and InventoryIsFull(GetTriggerUnit(), GetItemTypeId(GetOrderTargetItem()))
endfunction

// This code is directly taken from the system "EasyItemStacknSplit v2.7.4" and allows picking up items even if the inventory is full.
private function TimerFunctionPickupItem takes nothing returns nothing
    local integer i = 0
    local player slotPlayer = null
    local unit hero = null
    local unit backpack = null
    local item targetItem = null
    local boolean noTargets = true
    local real x = 0.0
    local real y = 0.0
    local integer order = 0
    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        set hero = GetPlayerHero1(slotPlayer)
        set backpack = GetPlayerBackpack(slotPlayer)
        set targetItem = BackpackTargetItem[i]
        if (targetItem != null and hero != null and backpack != null) then
            //call BJDebugMsg("Update backpack for player " + GetPlayerName(slotPlayer) + " with target item " + GetItemName(targetItem) + ".")
            if (GetWidgetLife(hero) > 0.0 and GetWidgetLife(targetItem) > 0.0) then
                //call BJDebugMsg("Order to item with full inventory periodically.")
                if (GetUnitCurrentOrder(hero) == 851986) then // move
                    set x = GetItemX(targetItem) - GetUnitX(hero)
                    set y = GetItemY(targetItem) - GetUnitY(hero)

                    if (x * x + y * y <= 22500) then
                        call IssueImmediateOrder(hero, "stop")
                        // TODO play fake sound
                        call SetUnitFacing(hero, bj_RADTODEG * Atan2(GetItemY(targetItem) - GetUnitY(hero), GetItemX(targetItem) - GetUnitX(hero)))
                        
                        if (CanItemBePickedUp(targetItem, backpack)) then
                            if (not AddItemToBackpackForPlayer(slotPlayer, targetItem)) then
                                call SimError(slotPlayer, GetLocalizedString("INVENTORY_IS_FULL"))
                            endif
                        else
                            call SimError(slotPlayer, Format(GetLocalizedString("PICKUP_ERROR")).s(GetItemName(targetItem)).s(GetItemPickupErrorReason(targetItem , hero)).result()) // %1% cannot be picked up: %2%
                        endif
                        set BackpackTargetItem[i] = null
                    endif
                endif
            else
                //call BJDebugMsg("Reset ordering to item with full inventory.")
                set BackpackTargetItem[i] = null
            endif

            if (BackpackTargetItem[i] != null) then
                set noTargets = false
            endif
        endif
        set hero = null
        set targetItem = null
        set slotPlayer = null
        set i = i + 1
    endloop
    if (noTargets) then
        set BackpackPickupTimerHasStarted = false
        call PauseTimer(GetExpiredTimer())
    endif
endfunction

private function TriggerFunctionOrderBackpackItem takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    local item whichItem = GetOrderTargetItem()
    //call BJDebugMsg("Order to item with full inventory start.")
    set BackpackTargetItem[playerId] = whichItem
    if (not BackpackPickupTimerHasStarted) then
        set BackpackPickupTimerHasStarted = true
        call TimerStart(BackpackPickupTimer, 0.05, true, function TimerFunctionPickupItem)
    endif
    call IssuePointOrder(GetTriggerUnit(), "move", GetItemX(whichItem), GetItemY(whichItem))
    set hero = null
    set owner = null
    set whichItem = null
endfunction

function CreateBackpackForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    set Backpack[playerId] = CreateUnit(whichPlayer, BACK_PACK, GetUnitX(GetPlayerHero1(whichPlayer)), GetUnitY(GetPlayerHero1(whichPlayer)), 0.00)
    call SuspendHeroXP(Backpack[playerId], true)
    call SetUnitInvulnerable(Backpack[playerId], true)
    call BlzSetUnitName(Backpack[playerId], Format(GetLocalizedString("BAG_WITH_INDEX")).i(1).result()) // Bag %1%
    // Change Ruckack Page Trigger
    if (BackpackTriggerChangePage[playerId] == null) then
        set BackpackTriggerChangePage[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(BackpackTriggerChangePage[playerId], whichPlayer, EVENT_PLAYER_UNIT_SPELL_CHANNEL, null)
        call TriggerAddCondition(BackpackTriggerChangePage[playerId], Condition(function TriggerConditionChangeBackpackPage))
        call TriggerAddAction(BackpackTriggerChangePage[playerId], function TriggerFunctionChangeBackpackPage)
    endif
    if (BackpackTriggerPickup[playerId] == null) then
        set BackpackTriggerPickup[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(BackpackTriggerPickup[playerId], whichPlayer, EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerAddCondition(BackpackTriggerPickup[playerId], Condition(function TriggerConditionPickupBackpackItem))
        call TriggerAddAction(BackpackTriggerPickup[playerId], function TriggerFunctionPickupBackpackItem)
    endif
    if (BackpackTriggerDrop[playerId] == null) then
        set BackpackTriggerDrop[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(BackpackTriggerDrop[playerId], whichPlayer, EVENT_PLAYER_UNIT_DROP_ITEM, null)
        call TriggerAddCondition(BackpackTriggerDrop[playerId], Condition(function TriggerConditionDropBackpackItem))
        call TriggerAddAction(BackpackTriggerDrop[playerId], function TriggerFunctionDropBackpackItem)
    endif
    if (BackpackTriggerMove[playerId] == null) then
        set BackpackTriggerMove[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(BackpackTriggerMove[playerId], whichPlayer, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, null)
        call TriggerAddCondition(BackpackTriggerMove[playerId], Condition(function TriggerConditionMoveBackpackItem))
        call TriggerAddAction(BackpackTriggerMove[playerId], function TriggerFunctionMoveBackpackItem)
    endif
    if (BackpackTriggerOrder[playerId] == null) then
        set BackpackTriggerOrder[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(BackpackTriggerOrder[playerId], whichPlayer, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, null)
        call TriggerAddCondition(BackpackTriggerOrder[playerId], Condition(function TriggerConditionOrderBackpackItem))
        call TriggerAddAction(BackpackTriggerOrder[playerId], function TriggerFunctionOrderBackpackItem)
    endif
endfunction

function RefreshBackpackForPlayer takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
     if (Backpack[playerId] != null) then
        call DisableItemPickupTriggers(whichPlayer)
        call RemoveUnit(Backpack[playerId])
        set Backpack[playerId] = null
        call EnableItemPickupTriggers(whichPlayer)
    endif
    call CreateBackpackForPlayer(whichPlayer)
    call RefreshBackpackPage(whichPlayer)
    call UpdateItemsForBackpackUIEvaluate(whichPlayer)
endfunction

private function TimerFunctionUpdateLocationsOfBackpackAndEquipmentBags takes nothing returns nothing
    local player slotPlayer = null
    local unit hero1 = null
    local integer countEquipmentBags = 0
    local integer i = 0
    local real x = 0.0
    local real y = 0.0
    local integer j = 0
    local unit bag = null
    loop
        exitwhen(i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set hero1 = GetPlayerHero1(slotPlayer)
            if (hero1 != null) then
                // get hero position even in transporter
                set x = GetUnitActualX(hero1)
                set y = GetUnitActualY(hero1)
            else
                set x = GetStartLocationX(i)
                set y = GetStartLocationY(i)
            endif

            if (Backpack[i] != null) then
                set bag = Backpack[i]
                call SetUnitX(bag, x)
                call SetUnitY(bag, y)
                set bag = null
            endif

            if (GetPlayerEquipmentBags(slotPlayer) != null) then
                set countEquipmentBags = BlzGroupGetSize(GetPlayerEquipmentBags(slotPlayer))
                set j = 0
                loop
                    exitwhen (j == countEquipmentBags)
                    set bag = BlzGroupUnitAt(GetPlayerEquipmentBags(slotPlayer), j)
                    call SetUnitX(bag, x)
                    call SetUnitY(bag, y)
                    // update hero stats for replaced hero spells
                    if (hero1 != null) then
                        call SetHeroStr(bag, GetHeroStr(hero1, false), true)
                        //call SetHeroStr(bag, GetHeroStrBonus(hero1), false)
                        call SetHeroAgi(bag, GetHeroAgi(hero1, false), true)
                        //call SetHeroAgi(bag, GetHeroAgiBonus(hero1), false)
                        call SetHeroInt(bag, GetHeroInt(hero1, false), true)
                        //call SetHeroInt(bag, GetHeroIntBonus(hero1), false)
                    else
                        call SetHeroStr(bag, 10, true)
                        //call SetHeroStr(bag, 0, false)
                        call SetHeroAgi(bag, 10, true)
                        //call SetHeroAgi(bag, 0, false)
                        call SetHeroInt(bag, 10, true)
                        //call SetHeroInt(bag, 0, false)
                    endif
                    set bag = null
                    set j = j + 1
                endloop
            endif
            set hero1 = null
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

function GetBackpackUpdateLocatiomTimerHandleId takes nothing returns integer
    return GetHandleId(BackpackUpdateLocationTimer)
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        set BackpackPlayerBagInfo[i] = true
        set i = i + 1
        exitwhen (i == bj_MAX_PLAYERS)
    endloop
    call TimerStart(BackpackUpdateLocationTimer, BACKPACK_MOVE_INTERVAL, true, function TimerFunctionUpdateLocationsOfBackpackAndEquipmentBags)
endfunction

endlibrary
