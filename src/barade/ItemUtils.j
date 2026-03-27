library ItemUtils initializer Init

function DropAllItemsFromHero takes unit hero returns integer
    local integer max = UnitInventorySize(hero)
    local integer result = 0
	local integer i = 0
	loop
		exitwhen (i >= max)
		if (UnitItemInSlot(hero, i) != null) then
            call UnitRemoveItemFromSlot(hero, i)
            set result = result + 1
        endif
		set i = i + 1
	endloop

	return result
endfunction

function ReplaceItem takes item whichItem, integer itemTypeId returns item
    local item result = CreateItem(itemTypeId, GetItemX(whichItem), GetItemY(whichItem))
    call SetItemCharges(result, GetItemCharges(whichItem))
    call SetItemInvulnerable(result, IsItemInvulnerable(whichItem))
    //call SetItemPlayer()
    return result
endfunction

function CountItemsOfItemTypeId takes unit whichUnit, integer itemId returns integer
    local integer index
    local item    indexItem
    local integer result = 0

    set index = 0
    loop
        set indexItem = UnitItemInSlot(whichUnit, index)
        if (indexItem != null) then
            if (GetItemTypeId(indexItem) == itemId) then
                set result = result + IMaxBJ(GetItemCharges(indexItem), 1)
            endif
            set indexItem = null
        endif

        set index = index + 1
        exitwhen index >= bj_MAX_INVENTORY
    endloop
    return result
endfunction

function RemoveAllItemsOfTypeId takes unit whichUnit, integer itemId returns integer
    local integer index
    local item    indexItem
    local integer result = 0

    set index = 0
    loop
        set indexItem = UnitItemInSlot(whichUnit, index)
        if (indexItem != null) then
            if (GetItemTypeId(indexItem) == itemId) then
                set result = result + IMaxBJ(GetItemCharges(indexItem), 1)
                call RemoveItem(indexItem)
            endif
            set indexItem = null
        endif

        set index = index + 1
        exitwhen index >= bj_MAX_INVENTORY
    endloop
    return result
endfunction

globals
    private filterfunc filterIsItemOfType
    private integer filterItemTypeId = 0
    private integer countFilteredItems = 0
endglobals

private function FilterIsItemOfType takes nothing returns boolean
    if (GetItemTypeId(GetFilterItem()) == filterItemTypeId) then
        set countFilteredItems = countFilteredItems + 1
    endif
    return false
endfunction

function CountItemsOfTypeIdAllEx takes rect whichRect, integer itemTypeId returns integer
    set filterItemTypeId = itemTypeId
    set countFilteredItems = 0
    call EnumItemsInRect(whichRect, filterIsItemOfType, null)
    return countFilteredItems
endfunction

function CountItemsOfTypeIdAll takes integer itemTypeId returns integer
    return CountItemsOfTypeIdAllEx(GetPlayableMapRect(), itemTypeId)
endfunction

function DropFirstItemFromHero takes unit hero, integer itemTypeId returns item
    local item whichItem = null
    local item slotItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY or whichItem != null)
        set slotItem = UnitItemInSlot(hero, i)
        if (GetItemTypeId(slotItem) == itemTypeId) then
            call UnitRemoveItem(hero, slotItem)
            set whichItem = slotItem
        endif
        set slotItem = null
        set i = i + 1
    endloop
    return whichItem
endfunction

private function Init takes nothing returns nothing
    set filterIsItemOfType = Filter(function FilterIsItemOfType)
endfunction

endlibrary
