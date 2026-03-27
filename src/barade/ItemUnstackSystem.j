// Define this function, to return custom values. It is only used if CHECK_MAX_STACKS is false.
constant function ItemUnstackItemGetMaxStacks takes integer itemTypeId returns integer
    return 1000
endfunction

library ItemUnstackSystem initializer Init requires optional MaxItemStacks
// Baradé's Item Unstack System 1.9
//
// Supports the missing Warcraft III feature of unstacking stacked items in your inventory.
//
// Usage:
// - Enable Warcraft's native stack system in the "Advanced - Gameplay Constants - Inventory - Enable Item Stacking".
// - Give certain item types a maximum stack value: "Stats - Max Stacks". Note that some of them like Wards do already have specified some values greater than 0 here.
// - Copy this code into your map script or a trigger converted into code.
// - Optional: Adapt the values of the constants for your map.
// - Optional: Redefine ItemUnstackItemGetMaxStacks if necessary.
// - Optional (recommended): Change the "Advanced - Game Interface - Text - General" from "|cff808080Drop item on shop to sell|R" into "|cff808080Drop item on shop to sell|NDouble right click item to unstack|R" to guide the player.
//
// Download:
// https://www.hiveworkshop.com/threads/barad%C3%A9s-item-unstack-system-1-1.339109/
//
// API:
//
// function SetItemUnstackEnabled takes unit whichUnit, boolean enabled returns nothing
//
// Enables item unstack for the given unit or disables it. It is enabled by default.
//
// function IsItemUnstackEnabled takes unit whichUnit returns boolean
//
// Returns if item unstack is enabled for the given unit which should be true by default.

globals
    // The number of charges which are unstacked at maximum if available.
    private constant integer MAX_UNSTACKED_CHARGES = 1
    // Overwrites the previous value if set to true. It always unstacks the half of charges. For uneven numbers it will unstack the lower value. For example, for 3 it will unstack 1 charge.
    private constant boolean UNSTACK_HALF_CHARGES = false
    // Unstacking an item can be moved to the next slot if it has the same item type and stack with it.
    private constant boolean ALLOW_STACKING_NEXT_ITEM = true
    // This option only has an effect is ALLOW_STACKING_NEXT_ITEM is true. The unstacked item might be stacked to an item in a previous slot in the inventory if this option is true.
    private constant boolean STACKING_NEXT_ITEM_FROM_START = true
    // Checks for the maximum possible stacks for every item type. Otherwise, ItemUnstackItemGetMaxStacks is used.
    private constant boolean CHECK_MAX_STACKS = true

    private trigger orderTrigger = CreateTrigger()
    private group disabledUnits = CreateGroup()
endglobals

function SetItemUnstackEnabled takes unit whichUnit, boolean enabled returns nothing
    if (enabled) then
        if (IsUnitInGroup(whichUnit, disabledUnits)) then
            call GroupRemoveUnit(disabledUnits, whichUnit)
        endif
    else
        if (not IsUnitInGroup(whichUnit, disabledUnits)) then
            call GroupAddUnit(disabledUnits, whichUnit)
        endif
    endif
endfunction

function IsItemUnstackEnabled takes unit whichUnit returns boolean
    return not IsUnitInGroup(whichUnit, disabledUnits)
endfunction

private function GetMaxStacksByItemTypeIdIntern takes integer itemTypeId returns integer
static if (CHECK_MAX_STACKS) then
    return GetMaxStacksByItemTypeId(itemTypeId)
else
    return ItemUnstackItemGetMaxStacks(itemTypeId)
endif
endfunction

private function CopyItemProps takes item sourceItem, item targetItem returns nothing
    // some seem broken
    //call BlzSetItemName(targetItem, GetItemName(sourceItem))
    call BlzSetItemDescription(targetItem, BlzGetItemDescription(sourceItem))
    //call BlzSetItemTooltip(targetItem, BlzGetItemTooltip(sourceItem))
    call BlzSetItemExtendedTooltip(targetItem, BlzGetItemExtendedTooltip(sourceItem))
    //call BlzSetItemIconPath(targetItem, BlzGetItemIconPath(sourceItem))
    call SetItemPawnable(targetItem, IsItemPawnable(sourceItem))
    call SetItemInvulnerable(targetItem, IsItemInvulnerable(sourceItem))
    if (GetItemPlayer(sourceItem) != null) then
        call SetItemPlayer(targetItem, GetItemPlayer(sourceItem), false)
    endif
endfunction

private function GetItemSlot takes unit hero, item whichItem returns integer
    local integer sourceSlot = -1
    local integer i = 0
    loop
        if (UnitItemInSlot(hero, i) == whichItem) then
            set sourceSlot = i
        endif
        set i = i + 1
        exitwhen (sourceSlot != -1 or i >= UnitInventorySize(hero))
    endloop
    return sourceSlot
endfunction

private function AddUnstackedItem takes unit hero, integer itemTypeId, integer charges, integer sourceSlot, item sourceItem returns nothing
    local item itemInNextSlot = null
    local item itemInPreviousSlot = null
    local integer inventorySize = UnitInventorySize(hero)
    local integer slotItemCharges = 0
    local boolean addedToFreeSlot = false
    // we need to specify the target slot explicitly to prevent stacking the items again
    // we prefer empty slots next to the unstacked item
    local item unstackedItem = null
    local integer remainingCharges = charges
    local integer unstackedCharges = 0
    local integer maxCharges = 0
    local integer i = sourceSlot + 1
    local integer j = sourceSlot - 1
    // check for a slot with an item with the same type and free stacks
    if (ALLOW_STACKING_NEXT_ITEM) then
        set maxCharges = GetMaxStacksByItemTypeIdIntern(itemTypeId)
        loop
            set itemInNextSlot = UnitItemInSlot(hero, i)
            if (i < inventorySize) then
                if (itemInNextSlot == null) then
                    set addedToFreeSlot = true
                    call UnitAddItemToSlotById(hero, itemTypeId, i)
                    set unstackedItem = UnitItemInSlot(hero, i)
                    set unstackedCharges = IMinBJ(maxCharges, remainingCharges)
                    call SetItemCharges(unstackedItem, unstackedCharges)
                    set remainingCharges = remainingCharges - unstackedCharges
                elseif (GetItemTypeId(itemInNextSlot) == itemTypeId) then
                    set slotItemCharges = GetItemCharges(itemInNextSlot)
                    if (slotItemCharges < maxCharges) then
                        set unstackedItem = itemInNextSlot
                        set unstackedCharges = IMinBJ(maxCharges - GetItemCharges(itemInNextSlot), remainingCharges)
                        call SetItemCharges(unstackedItem, slotItemCharges + unstackedCharges)
                        set remainingCharges = remainingCharges - unstackedCharges
                    endif
                endif
            endif
            set i = i + 1
            exitwhen (remainingCharges == 0 or i >= inventorySize)
        endloop
        if (STACKING_NEXT_ITEM_FROM_START and remainingCharges > 0 and sourceSlot > 0) then
            set i = 0
            loop
                set itemInNextSlot = UnitItemInSlot(hero, i)
                if (i < sourceSlot) then
                    if (itemInNextSlot == null) then
                        set addedToFreeSlot = true
                        call UnitAddItemToSlotById(hero, itemTypeId, i)
                        set unstackedItem = UnitItemInSlot(hero, i)
                        set unstackedCharges = IMinBJ(maxCharges, remainingCharges)
                        call SetItemCharges(unstackedItem, unstackedCharges)
                        set remainingCharges = remainingCharges - unstackedCharges
                    elseif (GetItemTypeId(itemInNextSlot) == itemTypeId) then
                        set slotItemCharges = GetItemCharges(itemInNextSlot)
                        if (slotItemCharges < maxCharges) then
                            set unstackedItem = itemInNextSlot
                            set unstackedCharges = IMinBJ(maxCharges - GetItemCharges(itemInNextSlot), remainingCharges)
                            call SetItemCharges(unstackedItem, slotItemCharges + unstackedCharges)
                            set remainingCharges = remainingCharges - unstackedCharges
                        endif
                    endif
                endif
                set i = i + 1
                exitwhen (remainingCharges == 0 or i >= sourceSlot)
            endloop
        endif
    endif

    // check for a free slot
    if (remainingCharges > 0) then
        set i = sourceSlot + 1
        set j = sourceSlot - 1
        loop
            set itemInNextSlot = UnitItemInSlot(hero, i)
            set itemInPreviousSlot = UnitItemInSlot(hero, j)
            if (i < inventorySize and itemInNextSlot == null) then
                set addedToFreeSlot = true
                call UnitAddItemToSlotById(hero, itemTypeId, i)
                set unstackedItem = UnitItemInSlot(hero, i)
                call CopyItemProps(sourceItem, unstackedItem)
                set unstackedCharges = IMinBJ(maxCharges, remainingCharges)
                call SetItemCharges(unstackedItem, unstackedCharges)
                set remainingCharges = remainingCharges - unstackedCharges
            elseif (j >= 0 and itemInPreviousSlot == null) then
                set addedToFreeSlot = true
                call UnitAddItemToSlotById(hero, itemTypeId, j)
                set unstackedItem = UnitItemInSlot(hero, j)
                call CopyItemProps(sourceItem, unstackedItem)
                set unstackedCharges = IMinBJ(maxCharges, remainingCharges)
                call SetItemCharges(unstackedItem, unstackedCharges)
                set remainingCharges = remainingCharges - unstackedCharges
            endif
            set i = i + 1
            set j = j - 1
            exitwhen (remainingCharges == 0 or (i >= inventorySize and j < 0))
        endloop
    endif

    // create the item for the hero with one slot if all slots are used
    loop
        exitwhen (remainingCharges == 0)
        set unstackedItem = CreateItem(itemTypeId, GetUnitX(hero), GetUnitY(hero))
        set unstackedCharges = IMinBJ(maxCharges, remainingCharges)
        call SetItemCharges(unstackedItem, unstackedCharges)
        call CopyItemProps(sourceItem, unstackedItem)
        set remainingCharges = remainingCharges - unstackedCharges
    endloop

    set unstackedItem = null
endfunction

private function TriggerConditionOrderUnstack takes nothing returns boolean
    local boolean isEnabled = IsItemUnstackEnabled(GetTriggerUnit())
    local integer orderId = GetIssuedOrderId()
    local item targetItem = GetOrderTargetItem()
    local integer maxStacks = GetMaxStacksByItemTypeIdIntern(GetItemTypeId(targetItem))
    local integer charges = GetItemCharges(targetItem)
    local boolean result = isEnabled and orderId >= 852002 and orderId <= 852007 and targetItem != null and maxStacks > 0 and charges > 1 and GetItemSlot(GetTriggerUnit(), targetItem) == orderId - 852002
    set targetItem = null
    return result
endfunction

private function TriggerActionOrderUnstack takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local item sourceItem = GetOrderTargetItem()
    local integer sourceItemTypeId = GetItemTypeId(sourceItem)
    local integer sourceSlot = GetItemSlot(hero, sourceItem)
    local integer charges = 1
    // wait for completing the order or the item is not at the target slot
    call TriggerSleepAction(0.0)
    // item does still exist and was dropped on its previous slot
    // we are not sure if this works when the item is removed via triggers since the value of the variable becomes an invalid reference
    if (sourceItem != null and GetWidgetLife(sourceItem) > 0.0 and GetItemCharges(sourceItem) > 0 and UnitItemInSlot(hero, sourceSlot) == sourceItem) then
        if (UNSTACK_HALF_CHARGES) then
            set charges = IMaxBJ(GetItemCharges(sourceItem) / 2, 1)
        else
            set charges = IMinBJ(GetItemCharges(sourceItem) - 1, MAX_UNSTACKED_CHARGES)
        endif
        if (charges > 0) then
            call SetItemCharges(sourceItem, GetItemCharges(sourceItem) - charges)
            call AddUnstackedItem(hero, sourceItemTypeId, charges, sourceSlot, sourceItem)
        endif
    endif

    set hero = null
    set sourceItem = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrderUnstack))
    call TriggerAddAction(orderTrigger, function TriggerActionOrderUnstack)
    
    call SetItemUnstackEnabled(MaxItemStacks_GetStackItemDummy(), false)
endfunction

// Change Log:
//
// 1.9 2023-01-10:
// - Fix checking for the charges maximums of the corresponding item types when unstacking items.
// - Store more information in local variables to improve the performance.
// - Add function SetItemUnstackEnabled.
// - Add function IsItemUnstackEnabled.
// - Revise tooltips, stocks and number for items in example map.
// - Give players gold and lumber in example map.
//
// 1.8 2022-12-18:
// - Unstack item charges -1 at maximum instead of all item charges which would be like moving the item.
// - Do never unstack charges equal to or less than 0 to prevent bugs.
//
// 1.7 2022-10-29:
// - Simplify TriggerConditionOrderUnstack by using more local variables.
// - Add option STACKING_NEXT_ITEM_FROM_START.
//
// 1.6 2022-07-15:
// - Add separate library MaxItemStacks.
//
// 1.5 2022-07-10:
// - Use vJass since we have two triggers now, can use the initializer and use static ifs.
// - Use constants instead of constant functions for the options of the system.
// - Calculate the max stacks per item type with the help of a dummy if enabled.
// - Increase the max stacks possible to 1000 since this is the maximum possible value in the object editor.
// - Add option UNSTACK_HALF_CHARGES.
//
// 1.4 2022-07-09:
// - ItemUnstackMaximumCharges allows changing the number of unstacked charges.
// - ItemUnstackAllowStackingNextItem allows stacking the unstacked item to the next item with the same type instead of only using a free slot.
// - ItemUnstackItemGetMaxStacks to check if the item is even stackable and to make sure item charges will not be over the maximum.
//
// 1.3 2022-04-16:
// - Refactor function names.
//
// 1.2 2022-04-13:
// - Use UnitInventorySize instead of bj_MAX_INVENTORY to support different inventory sizes.
// - Place Footmen with unit inventories to check different inventory sizes.
//
// 1.1 2022-04-11:
// - Split into multiple functions.
// - Do not apply item name, tooltip and icon path on unstacking since it is broken.
// - Prefer the nearest empty slot on unstacking.
// - Add a line break to the unstacking hint.
// - Add some items with custom names and descriptions to test stacking/unstacking them.
// - Move system code into converted trigger.
// - Update preview image.
endlibrary
