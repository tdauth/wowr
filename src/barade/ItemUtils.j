library ItemUtils initializer Init

function DropAllItemsFromHero takes unit hero returns integer
	local item slotItem = null
	local integer result = 0
	local integer i = 0
	local integer max = UnitInventorySize(hero)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInSlot(hero, i)
		if (slotItem != null) then
			call UnitRemoveItem(hero, slotItem)
			set result = result + 1
		endif
		set slotItem = null
		set i = i + 1
	endloop

	// Forsaken Kingdom
	set i = 0
	set max = UnitExtendedInventorySize(hero)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInBagSlot(hero, i)
		if (slotItem != null) then
			call UnitRemoveItem(hero, slotItem)
			set result = result + 1
		endif
		set slotItem = null
		set i = i + 1
	endloop

	set i = 0
	loop
		exitwhen (i >= bj_MAX_EQUIPMENT_INVENTORY)
		set slotItem = UnitItemInEquipmentSlot(hero, ConvertLoadoutSlot(i))
		if (slotItem != null) then
			call UnitRemoveItem(hero, slotItem)
			set result = result + 1
		endif
		set slotItem = null
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
	local item slotItem = null
	local integer result = 0
	local integer i = 0
	local integer max = UnitInventorySize(whichUnit)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInSlot(whichUnit, i)
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
			endif
			set slotItem = null
		endif
		set i = i + 1
	endloop

	// Forsaken Kingdom
	set i = 0
	set max = UnitExtendedInventorySize(whichUnit)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInBagSlot(whichUnit, i)
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
			endif
			set slotItem = null
		endif
		set i = i + 1
	endloop

	set i = 0
	loop
		exitwhen (i >= bj_MAX_EQUIPMENT_INVENTORY)
		set slotItem = UnitItemInEquipmentSlot(whichUnit, ConvertLoadoutSlot(i))
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
			endif
			set slotItem = null
		endif
		set i = i + 1
	endloop

	return result
endfunction

function RemoveAllItemsOfTypeId takes unit whichUnit, integer itemId returns integer
	local item slotItem = null
	local integer result = 0
	local integer i = 0
	local integer max = UnitInventorySize(whichUnit)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInSlot(whichUnit, i)
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
				call RemoveItem(slotItem)
			endif
			set slotItem = null
		endif
		set i = i + 1
	endloop

	// Forsaken Kingdom
	set i = 0
	set max = UnitExtendedInventorySize(whichUnit)
	loop
		exitwhen (i >= max)
		set slotItem = UnitItemInBagSlot(whichUnit, i)
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
				call RemoveItem(slotItem)
			endif
			set slotItem = null
		endif
		set i = i + 1
	endloop

	set i = 0
	loop
		exitwhen (i >= bj_MAX_EQUIPMENT_INVENTORY)
		set slotItem = UnitItemInEquipmentSlot(whichUnit, ConvertLoadoutSlot(i))
		if (slotItem != null) then
			if (GetItemTypeId(slotItem) == itemId) then
				set result = result + IMaxBJ(GetItemCharges(slotItem), 1)
				call RemoveItem(slotItem)
			endif
			set slotItem = null
		endif
		set i = i + 1
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
	local integer max = UnitInventorySize(hero)
	loop
		exitwhen (i >= max or whichItem != null)
		set slotItem = UnitItemInSlot(hero, i)
		if (slotItem != null and GetItemTypeId(slotItem) == itemTypeId) then
			call UnitRemoveItem(hero, slotItem)
			set whichItem = slotItem
		endif
		set slotItem = null
		set i = i + 1
	endloop

	// Forsaken Kingdom
	set i = 0
	set max = UnitExtendedInventorySize(hero)
	loop
		exitwhen (i >= max or whichItem != null)
		set slotItem = UnitItemInBagSlot(hero, i)
		if (slotItem != null and GetItemTypeId(slotItem) == itemTypeId) then
			call UnitRemoveItem(hero, UnitItemInBagSlot(hero, i))
			set whichItem = slotItem
		endif
		set slotItem = null
		set i = i + 1
	endloop

	set i = 0
	loop
		exitwhen (i >= bj_MAX_EQUIPMENT_INVENTORY or whichItem != null)
		set slotItem = UnitItemInEquipmentSlot(hero, ConvertLoadoutSlot(i))
		if (slotItem != null and GetItemTypeId(slotItem) == itemTypeId) then
			call UnitRemoveItem(hero, slotItem)
			set whichItem = slotItem
		endif
		set i = i + 1
	endloop

	return whichItem
endfunction

private function Init takes nothing returns nothing
	set filterIsItemOfType = Filter(function FilterIsItemOfType)
endfunction

endlibrary
