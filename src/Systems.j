//TESH.scrollpos=400
//TESH.alwaysfold=0

function Index2D takes integer Value1, integer Value2, integer MaxValue2 returns integer
    return ((Value1 * MaxValue2) + Value2)
endfunction

function Index3D takes integer Value1, integer Value2, integer Value3, integer MaxValue2, integer MaxValue3 returns integer
    return ((Value1 * (MaxValue2 * MaxValue3)) + (Value2 * MaxValue3) + Value3)
endfunction

function SaveTriggerParameterInteger takes handle Trigger, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(Trigger), ParameterKey, Value)
endfunction

function LoadTriggerParameterInteger takes handle Trigger, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(Trigger), ParameterKey)
endfunction

function TriggerParameterIntegerExists takes handle Trigger, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(Trigger), ParameterKey)
endfunction

function DestroyParameterTrigger takes trigger Trigger returns nothing
    call FlushChildHashtable(udg_DB, GetHandleId(Trigger))
    call DestroyTrigger(Trigger)
endfunction

function SaveUnitParameterInteger takes unit whichUnit, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(whichUnit), ParameterKey, Value)
endfunction

function LoadUnitParameterInteger takes unit whichUnit, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(whichUnit), ParameterKey)
endfunction

function UnitParameterIntegerExists takes unit whichUnit, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(whichUnit), ParameterKey)
endfunction

function SaveDestructableParameterInteger takes destructable whichDestructable, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey, Value)
endfunction

function LoadDestructableParameterInteger takes destructable whichDestructable, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey)
endfunction

function DestructableParameterIntegerExists takes destructable whichDestructable, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey)
endfunction

function FlushUnitParameters takes unit whichUnit returns nothing
    call FlushChildHashtable(udg_DB, GetHandleId(whichUnit))
endfunction

function PlayerIsOnlineUser takes integer PlayerNumber returns boolean
    return GetPlayerController(Player(PlayerNumber)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(PlayerNumber)) == PLAYER_SLOT_STATE_PLAYING
endfunction

globals
	string array raceIcons
	string array professionIcons
	//hashtable ObjectIdIconsHashTable = InitHashtable()
endglobals

function AddRaceIcon takes integer whichRace, string icon returns nothing
    set raceIcons[whichRace] = icon
endfunction

function GetIconByRace takes integer whichRace returns string
    local string result = raceIcons[whichRace]
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function AddProfessionIcon takes integer profession, string icon returns nothing
    set professionIcons[profession] = icon
endfunction

function GetIconByProfession takes integer profession returns string
    local string result = professionIcons[profession]
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function AddUnitTypeIcon takes integer unitTypeId, string icon returns nothing
	 //call SaveStr(ObjectIdIconsHashTable, unitTypeId, 0, icon)
endfunction

function AddItemTypeIcon takes integer itemTypeId, string icon returns nothing
	 //call SaveStr(ObjectIdIconsHashTable, itemTypeId, 0, icon)
endfunction

function GetIconByUnitType takes integer unitTypeId returns string
	//local string result = LoadStr(ObjectIdIconsHashTable, unitTypeId, 0)
	local string result = BlzGetAbilityIcon(unitTypeId)
    if (unitTypeId == 0 or result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function GetIconByItemType takes integer itemTypeId returns string
	//local string result = LoadStr(ObjectIdIconsHashTable, itemTypeId, 0)
	local string result = BlzGetAbilityIcon(itemTypeId)
    if (itemTypeId == 0 or result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp"
    endif

    return result
endfunction

// https://www.hiveworkshop.com/threads/detecting-item-price.120355/
function GetUnitShop takes nothing returns integer
    return 'ngme'                                                               // This is the raw code for the goblin shop
endfunction

function GetUnitSell takes nothing returns integer
    return 'Hpal'                                                               // This is the raw code for the paladin
endfunction

function GetItemValueGold takes integer i returns integer
    local real x   = 0                                                          // This is the x position where we create the dummy units. Dont place it in the water.
    local real y   = 0                                                          // This is the y position where we create the dummy units. Dont place it in the water.
    local unit u1  = CreateUnit(Player(12),GetUnitShop(),x,y,0)
    local unit u2  = CreateUnit(Player(12),GetUnitSell(),x,y-100,90)
    local item a   = UnitAddItemByIdSwapped(i,u2)
    local integer g1 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD)
    local integer g2 = 0
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD) - g1
    call SetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemValueLumber takes integer i returns integer
    local real x   = 0                                                          // This is the x position where we create the dummy units. Dont place it in the water.
    local real y   = 0                                                          // This is the y position where we create the dummy units. Dont place it in the water.
    local unit u1  = CreateUnit(Player(12),GetUnitShop(),x,y,0)
    local unit u2  = CreateUnit(Player(12),GetUnitSell(),x,y-100,90)
    local item a   = UnitAddItemByIdSwapped(i,u2)
    local integer g1 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2 = 0
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER) - g1
    call SetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemTypePerishable takes integer i returns boolean
    local item tmpItem = CreateItem(i, 0.0, 0.0)
    local boolean result = BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return result
endfunction

function ClearRucksackItem takes integer index returns nothing
    set udg_RucksackItemType[index] = 0
    set udg_RucksackItemCharges[index] = 0
    set udg_RucksackItemName[index] = ""
    set udg_RucksackItemDescription[index] = ""
    set udg_RucksackItemTooltip[index] = ""
    set udg_RucksackItemTooltipExtended[index] = ""
endfunction

function SetRucksackItemFromItem takes item whichItem, integer index returns nothing
    set udg_RucksackItemType[index] = GetItemTypeId(whichItem)
    set udg_RucksackItemCharges[index] = GetItemCharges(whichItem)
    set udg_RucksackItemPawnable[index] = IsItemPawnable(whichItem)
    set udg_RucksackItemInvulnerable[index] = IsItemInvulnerable(whichItem)
    set udg_RucksackItemName[index] = GetItemName(whichItem)
    set udg_RucksackItemDescription[index] = BlzGetItemDescription(whichItem)
    set udg_RucksackItemTooltip[index] = BlzGetItemTooltip(whichItem)
    set udg_RucksackItemTooltipExtended[index] = BlzGetItemExtendedTooltip(whichItem)
endfunction

function ApplyRucksackItem takes item whichItem, integer index returns nothing
    call SetItemCharges(whichItem, udg_RucksackItemCharges[index])
    call SetItemPawnable(whichItem, udg_RucksackItemPawnable[index])
    call SetItemDroppable(whichItem, true) // all items must be droppable in the backpack!
    call SetItemInvulnerable(whichItem, udg_RucksackItemInvulnerable[index])
    call BlzSetItemName(whichItem, udg_RucksackItemName[index])
    call BlzSetItemDescription(whichItem, udg_RucksackItemDescription[index])
    call BlzSetItemTooltip(whichItem, udg_RucksackItemTooltip[index])
    call BlzSetItemExtendedTooltip(whichItem, udg_RucksackItemTooltipExtended[index])
endfunction

function BackpackCountItemsOfItemTypeForPlayer takes integer PlayerNumber, integer itemTypeId returns integer
	local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local integer result = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[PlayerNumber] == I0) then
				if (UnitItemInSlot(udg_Rucksack[PlayerNumber], I1) != null and GetItemTypeId(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)) == itemTypeId) then
					set result = result + 1
				endif
            else
				if (udg_RucksackItemType[index] == itemTypeId) then
					set result = result + 1
				endif
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
	return result
endfunction

function RemoveAllBackpackItemTypesForPlayer takes integer PlayerNumber, integer itemTypeId returns integer
	local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local integer result = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[PlayerNumber] == I0) then
				if (UnitItemInSlot(udg_Rucksack[PlayerNumber], I1) != null and GetItemTypeId(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)) == itemTypeId) then
					call RemoveItem(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1))
					set result = result + 1
				endif
            else
				if (udg_RucksackItemType[index] == itemTypeId) then
                    call ClearRucksackItem(index)
					set result = result + 1
				endif
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
	return result
endfunction

function DropBackpackForPlayer takes integer PlayerNumber, rect whichRect returns nothing
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item whichItem = null
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[PlayerNumber] == I0) then
                set whichItem = CreateItem(GetItemTypeId(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)), GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            else
                set whichItem = CreateItem(udg_RucksackItemType[index], GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            endif

            call ApplyRucksackItem(whichItem, index)

            if (udg_RucksackPageNumber[PlayerNumber] == I0) then
                call SetItemCharges(whichItem, GetItemCharges(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)))
            else
                call SetItemCharges(whichItem, udg_RucksackItemCharges[index])
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
endfunction

function DropQuestItemFromHeroAtRect takes integer PlayerNumber, integer itemTypeId, rect whichRect returns item
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item whichItem = null
    // Check the hero inventory
    set I1 = 0
    loop
        exitwhen(I1 == bj_MAX_INVENTORY)
        if (GetItemTypeId(UnitItemInSlot(udg_Hero[PlayerNumber], I1)) == itemTypeId) then
            call RemoveItem(UnitItemInSlot(udg_Hero[PlayerNumber], I1))
            set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            call SetItemInvulnerable(whichItem, true)
            exitwhen (true)
        endif
        set I1 = I1 + 1
    endloop
	// Check second hero inventory
	if (udg_Hero2[PlayerNumber] != null) then
		set I1 = 0
    		loop
        		exitwhen(I1 == bj_MAX_INVENTORY)
        		if (GetItemTypeId(UnitItemInSlot(udg_Hero2[PlayerNumber], I1)) == itemTypeId) then
            			call RemoveItem(UnitItemInSlot(udg_Hero2[PlayerNumber], I1))
            			set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            			call SetItemInvulnerable(whichItem, true)
            			exitwhen (true)
        		endif
        		set I1 = I1 + 1
		endloop
	endif
	// Check third hero inventory
	if (udg_Hero3[PlayerNumber] != null) then
		set I1 = 0
    		loop
        		exitwhen(I1 == bj_MAX_INVENTORY)
        		if (GetItemTypeId(UnitItemInSlot(udg_Hero3[PlayerNumber], I1)) == itemTypeId) then
                    call RemoveItem(UnitItemInSlot(udg_Hero3[PlayerNumber], I1))
                    set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
                    call SetItemInvulnerable(whichItem, true)
                    exitwhen (true)
        		endif
        		set I1 = I1 + 1
		endloop
	endif
    // Check the backpack
    if (whichItem == null) then
        set I0 = 0
        loop
            exitwhen(I0 == udg_RucksackMaxPages)
            set I1 = 0
            loop
                exitwhen(I1 == bj_MAX_INVENTORY)
                set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                if (udg_RucksackItemType[index] == itemTypeId or (udg_RucksackPageNumber[PlayerNumber] == I0 and GetItemTypeId(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)) == itemTypeId)) then
                    if (udg_RucksackPageNumber[PlayerNumber] == I0) then
                        call RemoveItem(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1))
                    endif
                    call ClearRucksackItem(index)
                    set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
                    call SetItemInvulnerable(whichItem, true)
                    exitwhen (true)
                endif
                set I1 = I1 + 1
            endloop
            set I0 = I0 + 1
        endloop
    endif

    return whichItem
endfunction

function DropQuestItemFromHeroAtRectByDyingUnit takes integer itemTypeId, rect whichRect returns item
    return DropQuestItemFromHeroAtRect(GetPlayerId(GetOwningPlayer(GetTriggerUnit())), itemTypeId, whichRect)
endfunction

function DropQuestItemFromCreepHeroAtRect takes unit hero, integer itemTypeId, rect whichRect returns item
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (GetItemTypeId(UnitItemInSlot(hero, i)) == itemTypeId) then
            call RemoveItem(UnitItemInSlot(hero, i))
            set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            call SetItemInvulnerable(whichItem, true)
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    return whichItem
endfunction

function ClearCurrentRucksackPageForPlayer takes integer PlayerNumber returns nothing
    local integer I1 = 0
    local integer index = 0
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(PlayerNumber, udg_RucksackPageNumber[PlayerNumber], I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearRucksackItem(index)
            set I1 = I1 + 1
        endloop
endfunction

function ClearRucksackForPlayer takes integer PlayerNumber returns nothing
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearRucksackItem(index)
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
endfunction

function AddItemToBackpackForPlayer takes integer PlayerNumber, item whichItem returns boolean
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        exitwhen (whichItem == null)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            exitwhen (whichItem == null)
            set index = Index3D(PlayerNumber, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackItemType[index] == 0) then
                call SetRucksackItemFromItem(whichItem, index)
                call RemoveItem(whichItem)
                set whichItem = null

                return true
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop

    return false
endfunction

function DestroyRucksackSystemForPlayer takes integer PlayerNumber returns nothing
    if (udg_Rucksack[PlayerNumber] != null) then
        call RemoveUnit(udg_Rucksack[PlayerNumber])
        set udg_Rucksack[PlayerNumber] = null
    endif
    call ClearRucksackForPlayer(PlayerNumber)
endfunction

function RefreshRucksackPage takes integer PlayerNumber returns nothing
    local integer RucksackPage = udg_RucksackPageNumber[PlayerNumber]
    local integer I0 = 0
    local integer index = 0
    local item whichItem = null
	call DisableTrigger(gg_trg_Legendary_Artifact_Counter_Pickup)
	call DisableTrigger(udg_PlayerRucksackTriggerPickup[PlayerNumber])
	call DisableTrigger(udg_PlayerRucksackTriggerDrop[PlayerNumber])
    // Create All Items From Next/Previous Page
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(PlayerNumber, RucksackPage, I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        if (udg_RucksackItemType[index] != 0) then
            //call BJDebugMsg("Item type " + GetObjectName(udg_RucksackItemType[index]) + " at index " + I2S(index))
            call UnitAddItemToSlotById(udg_Rucksack[PlayerNumber], udg_RucksackItemType[index], I0)
            set whichItem = UnitItemInSlot(udg_Rucksack[PlayerNumber], I0)
            call ApplyRucksackItem(whichItem, index)
        //else
            //call BJDebugMsg("Empty at index " + I2S(index))
        endif
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Legendary_Artifact_Counter_Pickup)
	call EnableTrigger(udg_PlayerRucksackTriggerPickup[PlayerNumber])
	call EnableTrigger(udg_PlayerRucksackTriggerDrop[PlayerNumber])
endfunction

function ChangeRucksackPageEx takes integer PlayerNumber, integer newRucksackPage returns nothing
    local integer I0 = 0
    local integer index = 0
    local player RucksackOwner = Player(PlayerNumber)
    local item SlotItem = null
	call DisableTrigger(gg_trg_Legendary_Artifact_Counter_Drop)
	call DisableTrigger(udg_PlayerRucksackTriggerPickup[PlayerNumber])
	call DisableTrigger(udg_PlayerRucksackTriggerDrop[PlayerNumber])
    // Save All Items
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(PlayerNumber, udg_RucksackPageNumber[PlayerNumber], I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        set SlotItem = UnitItemInSlot(udg_Rucksack[PlayerNumber], I0)
        if (SlotItem != null) then
            call SetRucksackItemFromItem(SlotItem, index)
            //call BJDebugMsg("Storing at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            call RemoveItem(SlotItem)
            set SlotItem = null
        else
            //call BJDebugMsg("Storing empty at index " + I2S(index))
            call ClearRucksackItem(index)
        endif
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Legendary_Artifact_Counter_Drop)
	call EnableTrigger(udg_PlayerRucksackTriggerPickup[PlayerNumber])
	call EnableTrigger(udg_PlayerRucksackTriggerDrop[PlayerNumber])
	// change page
    set udg_RucksackPageNumber[PlayerNumber] = newRucksackPage
    call DisplayTimedTextToPlayer(RucksackOwner, 0.00, 0.00, 4.00, ("Open Bag " + I2S(newRucksackPage + 1) + "."))
    call RefreshRucksackPage(PlayerNumber)
    set RucksackOwner = null
endfunction

function ChangeRucksackPage takes integer PlayerNumber, boolean Forward returns nothing
    local integer RucksackPage = udg_RucksackPageNumber[PlayerNumber]
    local integer newRucksackPage = 0
    if (Forward) then
        if (RucksackPage != (udg_RucksackMaxPages - 1)) then
            set newRucksackPage = RucksackPage + 1
        else
            set newRucksackPage = 0
        endif
    else
        if (RucksackPage != 0) then
            set newRucksackPage = RucksackPage - 1
        else
            set newRucksackPage = udg_RucksackMaxPages - 1
        endif
    endif
    call ChangeRucksackPageEx(PlayerNumber, newRucksackPage)
endfunction

function UpdateItemsForBackpackUI takes player whichPlayer returns nothing
    local integer index = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BlzFrameSetTexture(BackpackItemFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
            call BlzFrameSetText(BackpackItemChargesFrame[index], I2S(udg_RucksackItemCharges[index]))
            if (udg_RucksackItemType[index] == 0) then
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            else
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
                if (BackpackUIVisible[GetPlayerId(whichPlayer)] and GetItemTypePerishable(udg_RucksackItemType[index])) then
                    call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function TriggerConditionChangeRucksackPage takes nothing returns boolean
    return GetSpellAbilityId() == udg_RucksackAbility1 or GetSpellAbilityId() == udg_RucksackAbility2
endfunction

function TriggerFunctionChangeRucksackPage takes nothing returns nothing
    if (GetSpellAbilityId() == udg_RucksackAbility1) then
        call ChangeRucksackPage(GetPlayerId(GetTriggerPlayer()), true)
    elseif (GetSpellAbilityId() == udg_RucksackAbility2) then
        call ChangeRucksackPage(GetPlayerId(GetTriggerPlayer()), false)
    endif
    call UpdateItemsForBackpackUI(GetTriggerPlayer())
endfunction

function TriggerConditionPickupRucksackItem takes nothing returns boolean
    return GetTriggerUnit() == udg_Rucksack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction


function TriggerFunctionPickupRucksackItem takes nothing returns nothing
    local integer PlayerNumber = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    local item whichItem = GetManipulatedItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer index = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(GetTriggerUnit(), i) != null and UnitItemInSlot(GetTriggerUnit(), i) == whichItem) then
            set index = Index3D(PlayerNumber, udg_RucksackPageNumber[PlayerNumber], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            call SetRucksackItemFromItem(whichItem, index)
            //call BJDebugMsg("Picking item up at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(GetOwningPlayer(GetTriggerUnit()))
    set whichItem = null
endfunction

function TriggerConditionDropRucksackItem takes nothing returns boolean
    return GetTriggerUnit() == udg_Rucksack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction


function TriggerFunctionDropRucksackItem takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer PlayerNumber = GetPlayerId(owner)
    local integer index = 0
    local integer i = 0
    call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(triggerUnit, i) == null) then
            set index = Index3D(PlayerNumber, udg_RucksackPageNumber[PlayerNumber], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            set udg_RucksackItemType[index] = 0
            set udg_RucksackItemCharges[index] = 0
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(owner)
    set owner = null
    set triggerUnit = null
endfunction

globals
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
endglobals

function TriggerConditionMoveRucksackItem takes nothing returns boolean
    return GetIssuedOrderId() >= A_ORDER_ID_MOVE_SLOT_0 and GetIssuedOrderId() <= A_ORDER_ID_MOVE_SLOT_5
endfunction


function TriggerFunctionMoveRucksackItem takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer PlayerNumber = GetPlayerId(owner)
    local integer i = 0
    local item whichItem = null
    local integer index = 0
    call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
    //call BJDebugMsg("Moved item!")
    // update all items of the current bag after moving the item
    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set index = Index3D(PlayerNumber, udg_RucksackPageNumber[PlayerNumber], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(triggerUnit, i)
        if (whichItem == null) then
            //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            call ClearRucksackItem(index)
        else
            call SetRucksackItemFromItem(whichItem, index)
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(owner)
    set owner = null
    set triggerUnit = null
endfunction

function CreateRucksackForPlayer takes integer PlayerNumber returns nothing
    local player RucksackPlayer = Player(PlayerNumber)
    set udg_Rucksack[PlayerNumber] = CreateUnit(RucksackPlayer, udg_RucksackUnitType, GetUnitX(udg_Hero[PlayerNumber]), GetUnitY(udg_Hero[PlayerNumber]), 0.00)
    call SuspendHeroXPBJ(false, udg_Rucksack[PlayerNumber])
    call SetUnitInvulnerable(udg_Rucksack[PlayerNumber], true)
    // Change Ruckack Page Trigger
    if (udg_PlayerRucksackTrigger[PlayerNumber] == null) then
        set udg_PlayerRucksackTrigger[PlayerNumber] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTrigger[PlayerNumber], RucksackPlayer, EVENT_PLAYER_UNIT_SPELL_CHANNEL, null)
        call TriggerAddCondition(udg_PlayerRucksackTrigger[PlayerNumber], Condition(function TriggerConditionChangeRucksackPage))
        call TriggerAddAction(udg_PlayerRucksackTrigger[PlayerNumber], function TriggerFunctionChangeRucksackPage)
    endif
    if (udg_PlayerRucksackTriggerPickup[PlayerNumber] == null) then
        set udg_PlayerRucksackTriggerPickup[PlayerNumber] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerPickup[PlayerNumber], RucksackPlayer, EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerPickup[PlayerNumber], Condition(function TriggerConditionPickupRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerPickup[PlayerNumber], function TriggerFunctionPickupRucksackItem)
    endif
    if (udg_PlayerRucksackTriggerDrop[PlayerNumber] == null) then
        set udg_PlayerRucksackTriggerDrop[PlayerNumber] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerDrop[PlayerNumber], RucksackPlayer, EVENT_PLAYER_UNIT_DROP_ITEM, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerDrop[PlayerNumber], Condition(function TriggerConditionDropRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerDrop[PlayerNumber], function TriggerFunctionDropRucksackItem)
    endif
    if (udg_PlayerRucksackTriggerMove[PlayerNumber] == null) then
        set udg_PlayerRucksackTriggerMove[PlayerNumber] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerMove[PlayerNumber], RucksackPlayer, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerMove[PlayerNumber], Condition(function TriggerConditionMoveRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerMove[PlayerNumber], function TriggerFunctionMoveRucksackItem)
    endif
    // Remove All
    set RucksackPlayer = null
endfunction

function RefreshRucksackForPlayer takes integer PlayerNumber returns nothing
    local player RucksackPlayer = Player(PlayerNumber)
    if (udg_Rucksack[PlayerNumber] != null) then
        call RemoveUnit(udg_Rucksack[PlayerNumber])
        set udg_Rucksack[PlayerNumber] = null
        set udg_Rucksack[PlayerNumber] = CreateUnit(RucksackPlayer, udg_RucksackUnitType, GetUnitX(udg_Hero[PlayerNumber]), GetUnitY(udg_Hero[PlayerNumber]), 0.00)
        call SuspendHeroXPBJ(false, udg_Rucksack[PlayerNumber])
        call SetUnitInvulnerable(udg_Rucksack[PlayerNumber], true)
        call RefreshRucksackPage(PlayerNumber)
    endif
    set RucksackPlayer = null
endfunction

function GetRespawnBuildingSize takes nothing returns real
    return 1400.0
endfunction

function GetRespawnGroupOfUnit takes unit Unit returns integer
    if (UnitParameterIntegerExists(Unit, 0)) then
        debug call BJDebugMsg("Unit " + GetUnitName(Unit) + " has a group!")
        return LoadUnitParameterInteger(Unit, 0)
    endif
    debug call BJDebugMsg("Unit " + GetUnitName(Unit) + " has no group!")
    return -1
endfunction

function GetRespawnGroupOfDestructable takes destructable whichDestructable returns integer
    if (DestructableParameterIntegerExists(whichDestructable, 0)) then
        debug call BJDebugMsg("Destructable " + GetDestructableName(whichDestructable) + " has a group!")
        return LoadDestructableParameterInteger(whichDestructable, 0)
    endif
    debug call BJDebugMsg("Destructable " + GetDestructableName(whichDestructable) + " has no group!")
    return -1
endfunction

function RespawnRectContainsNoBuilding takes integer Group returns boolean
    local location RespawnRectCenter = GetRectCenter(udg_RespawnRect[Group])
    local rect BuildingRect = RectFromCenterSizeBJ(RespawnRectCenter, GetRespawnBuildingSize(), GetRespawnBuildingSize())
    local group BuildingGroup = GetUnitsInRectAll(BuildingRect)
    local unit FirstOfBuildingGroup
    local player OwningPlayer
    local boolean BuildingDoesNotExist = true
    loop
        exitwhen(IsUnitGroupEmptyBJ(BuildingGroup))
        set FirstOfBuildingGroup = FirstOfGroup(BuildingGroup)
        set OwningPlayer = GetOwningPlayer(FirstOfBuildingGroup)
        if (IsUnitType(FirstOfBuildingGroup, UNIT_TYPE_STRUCTURE) and OwningPlayer != Player(PLAYER_NEUTRAL_AGGRESSIVE) and OwningPlayer != Player(PLAYER_NEUTRAL_PASSIVE) and OwningPlayer != udg_TheBurningLegion) then
            set BuildingDoesNotExist = false
            set FirstOfBuildingGroup = null
            set OwningPlayer = null
            exitwhen(true)
        endif
        call GroupRemoveUnit(BuildingGroup, FirstOfBuildingGroup)
        set FirstOfBuildingGroup = null
        set OwningPlayer = null
    endloop
    call DestroyGroup(BuildingGroup)
    set BuildingGroup = null
    call RemoveLocation(RespawnRectCenter)
    set RespawnRectCenter = null
    call RemoveRect(BuildingRect)
    set BuildingRect = null
    return BuildingDoesNotExist
endfunction

function AssignUnitToGroup takes unit whichUnit, integer Group returns nothing
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        // avoids permanent removal if too many heroes from the same player died
        call BlzSetUnitRealField(whichUnit, UNIT_RF_DEATH_TIME, 99999999.0)
    endif
    call SaveUnitParameterInteger(whichUnit, 0, Group)
endfunction

function AssignUnitToCurrentGroupEx takes integer lastIndex, unit lastMember returns nothing
    local integer memberIndex = Index2D(udg_TmpGroupIndex, lastIndex, udg_RespawnGroupMaxMembers)
    debug call BJDebugMsg("Assign to unit " + GetUnitName(lastMember) + " with handle ID " + I2S(GetHandleId(lastMember)) + " with index " + I2S(lastIndex) + " the current group " + I2S(udg_TmpGroupIndex) + " the unit group has a size of " + I2S(CountUnitsInGroup(udg_RespawnGroup[udg_TmpGroupIndex])))
    set udg_RespawnUnitType[memberIndex] = GetUnitTypeId(lastMember)
    set udg_RespawnLocationPerUnit[memberIndex] = GetUnitLoc(lastMember)
	// set the rect for the building check
	if (udg_RespawnRect[udg_TmpGroupIndex] == null) then
		set udg_RespawnRect[udg_TmpGroupIndex] = RectFromCenterSizeBJ(GetUnitLoc(lastMember), 200.00, 200.00)
	endif
    call AssignUnitToGroup(lastMember, udg_TmpGroupIndex)
	if (IsUnitType(lastMember, UNIT_TYPE_HERO)) then
		set udg_RespawnHero[memberIndex] = lastMember
	endif
	set udg_RespawnGroupMembers[udg_TmpGroupIndex] = lastIndex + 1
endfunction

function AssignUnitToCurrentGroup takes nothing returns nothing
    call AssignUnitToCurrentGroupEx(CountUnitsInGroup(udg_RespawnGroup[udg_TmpGroupIndex]) - 1, udg_LastAddedUnitToGroup)
endfunction

function CopyGroup takes group whichGroup returns group
    local group tmpGroup = CreateGroup()
    call GroupAddGroup(whichGroup, tmpGroup)
    return tmpGroup
endfunction

function AssignDestructableToCurrentGroup takes nothing returns nothing
    set udg_RespawnGroupDestructable[udg_TmpGroupIndex] = udg_CurrentRespawnDestructable
    call TriggerRegisterDeathEvent(udg_RespawnDestructableTrigger, udg_CurrentRespawnDestructable)
    call SaveDestructableParameterInteger(udg_CurrentRespawnDestructable, 0, udg_TmpGroupIndex)
endfunction

function AssignAllUnitsToCurrentGroup takes nothing returns nothing
    local integer count = CountUnitsInGroup(udg_RespawnGroup[udg_TmpGroupIndex])
    local group copy = CopyGroup(udg_RespawnGroup[udg_TmpGroupIndex])
    local integer i = 0
    local unit first = null
    loop
        set first = FirstOfGroup(copy)
        exitwhen (first == null)
        call AssignUnitToCurrentGroupEx(i, first)
        call GroupRemoveUnit(copy, first)
        set first = null
        set i = i + 1
    endloop
    call GroupClear(copy)
    call DestroyGroup(copy)
    call AssignDestructableToCurrentGroup()
endfunction

function InitCurrentGroup takes nothing returns nothing
    set udg_TmpGroupIndex = udg_TmpGroupIndex + 1
    set udg_RespawnGroup[udg_TmpGroupIndex] = CreateGroup()
    set udg_CurrentRespawnGroup = udg_RespawnGroup[udg_TmpGroupIndex]
endfunction

function RespawnGroup takes integer Group returns boolean
	local boolean result = false
    local integer I0 = 0
    local integer index = 0
	local integer I1 = 0
	local integer maxMembers = udg_RespawnGroupMaxMembers
    local location RespawnLocation
    local unit GroupMember = null
    debug call BJDebugMsg("Respawn group: " + I2S(Group))
    if (IsUnitGroupEmptyBJ(udg_RespawnGroup[Group]) or (udg_RespawnGroupMembers[Group] > 0 and CountUnitsInGroup(udg_RespawnGroup[Group]) < udg_RespawnGroupMembers[Group])) then
        debug call BJDebugMsg("Is empty: " + I2S(Group))
        if (udg_RespawnGroupMembers[Group] > 0) then
            set maxMembers = udg_RespawnGroupMembers[Group]
        endif
        set I0 = 0
        loop
            exitwhen(I0 == maxMembers)
            set index = Index2D(Group, I0, udg_RespawnGroupMaxMembers)
            if (udg_RespawnUnitType[index] != null and udg_RespawnUnitType[index] != 0) then
                if (udg_RespawnHero[index] != null) then // hero
                    set GroupMember = udg_RespawnHero[index]
                    if (not IsUnitInGroup(GroupMember, udg_RespawnGroup[Group])) then // the hero could be still alive and in the group
                        // hero creeps should keep their XP
                        if (udg_RespawnLocationPerUnit[index] != null) then
                            set RespawnLocation = udg_RespawnLocationPerUnit[index]
                        else
                            set RespawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
                        endif
                        debug call PingMinimapLocForForce(GetPlayersAll(), RespawnLocation, 5)
                        call ReviveHeroLoc(GroupMember, RespawnLocation, true)
                        call GroupAddUnit(udg_RespawnGroup[Group], GroupMember)
                        debug call BJDebugMsg("Group " + I2S(Group) + " revive hero: " + GetUnitName(GroupMember))
                        if (udg_RespawnLocationPerUnit[index] == null) then
                            call RemoveLocation(RespawnLocation)
                        endif
                        set RespawnLocation = null
                    endif
                    set GroupMember = null
                else // regular unit
					if (udg_RespawnLocationPerUnit[index] != null) then
						set RespawnLocation = udg_RespawnLocationPerUnit[index]
					else
						set RespawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
					endif
					set GroupMember = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_RespawnUnitType[index], GetLocationX(RespawnLocation), GetLocationY(RespawnLocation), GetRandomReal(0.00, 360.00))
					if (GetPlayerTechCountSimple('R00U', Player(PLAYER_NEUTRAL_AGGRESSIVE)) > 0) then
						    set udg_TmpUnit = GroupMember
						    set udg_TmpInteger = ( GetPlayerTechCountSimple('R00U', Player(PLAYER_NEUTRAL_AGGRESSIVE)) / 10 )
						    set udg_TmpInteger2 = ( GetPlayerTechCountSimple('R00U', Player(PLAYER_NEUTRAL_AGGRESSIVE)) / 10 )
						    set udg_TmpReal = I2R(udg_TmpInteger2)
						    call ConditionalTriggerExecute( gg_trg_Evolution_Add_Unit_Level_And_Defense )
					endif
					call AssignUnitToGroup(GroupMember, Group)
					call GroupAddUnit(udg_RespawnGroup[Group], GroupMember)
					if (udg_RespawnLocationPerUnit[index] == null) then
						call RemoveLocation(RespawnLocation)
					endif
					set RespawnLocation = null
				endif
            else
                // if one type is not set we assume the group has no more members
                exitwhen(true)
            endif
            set I0 = I0 + 1
        endloop

        if (udg_RespawnGroupDestructable[Group] != null and GetDestructableLife(udg_RespawnGroupDestructable[Group]) <= 0.0) then
            call DestructableRestoreLife(udg_RespawnGroupDestructable[Group], GetDestructableMaxLife(udg_RespawnGroupDestructable[Group]), true)
        endif

		set result = true
    endif

	return result
endfunction

function RespawnAllGroupsInRange takes real x, real y, real range returns integer
	local location tmpLocation = Location(x, y)
	local integer result = 0
	local integer i = 0
	loop
		exitwhen (i == udg_TmpGroupIndex + 1)
		if (DistanceBetweenPoints(GetRectCenter(udg_RespawnRect[i]), tmpLocation) <= range and RespawnGroup(i)) then
			set result = result + 1
		endif
		set i = i + 1
	endloop
	call RemoveLocation(tmpLocation)
	set tmpLocation = null
	return result
endfunction

function TriggerConditionNoBuilding takes nothing returns boolean
    local integer Group = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    return RespawnRectContainsNoBuilding(Group)
endfunction

function TriggerActionRespawnGroup takes nothing returns nothing
    local integer Group = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    call RespawnGroup(Group)
    call DestroyParameterTrigger(GetTriggeringTrigger())
endfunction

function RespawnGroupTimed takes integer Group returns nothing
    set udg_RespawnGroupTrigger[Group] = CreateTrigger()
    call TriggerRegisterTimerEvent(udg_RespawnGroupTrigger[Group], udg_RespawnTime, true)
    call TriggerAddCondition(udg_RespawnGroupTrigger[Group], Condition(function TriggerConditionNoBuilding))
    call TriggerAddAction(udg_RespawnGroupTrigger[Group], function TriggerActionRespawnGroup)
    call SaveTriggerParameterInteger(udg_RespawnGroupTrigger[Group], 0, Group)
endfunction

function RespawnAllGroups takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen(i == udg_MaxRespawnGroups)
        call RespawnGroup(i)
        set i = i + 1
    endloop
endfunction

function SetupRPGSystems takes nothing returns nothing
    set udg_UseRucksackSystem = true
    set udg_UseRespawningSystem = true
endfunction

function SetupCustomRucksackSystem takes nothing returns nothing
    set	udg_RucksackUnitType = 'E008'
    set udg_RucksackAbility1 = 'A02L'
    set	udg_RucksackAbility2 = 'A02M'
    set	udg_RucksackMaxPages = 30
    set udg_RucksackMoveTime = 0.10
endfunction

function SetupCustomRespawningSystem takes nothing returns nothing
    set udg_RespawnGroupMaxMembers = 22
    set udg_RespawnTime = 100.00
    set udg_RespawnItemChance = 30.00
endfunction

function TriggerActionMoveRucksack takes nothing returns nothing
    local integer I0 = 0
    local player RucksackOwner = GetTriggerPlayer()
    local location HeroPosition = GetUnitLoc(udg_Hero[GetPlayerId(RucksackOwner)])
    set RucksackOwner = null
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_PLAYERS)
        set RucksackOwner = Player(I0)
        if (PlayerIsOnlineUser(I0)) then
            if (udg_Rucksack[I0] != null) then
                set HeroPosition = GetUnitLoc(udg_Hero[I0])
                call SetUnitPosition(udg_Rucksack[I0], GetLocationX(HeroPosition), GetLocationY(HeroPosition))
                call RemoveLocation(HeroPosition)
                set HeroPosition = null
            endif
        endif
        set RucksackOwner = null
        set I0 = I0 + 1
    endloop
endfunction

function DropAllItemsFromHero takes unit hero returns nothing
	local integer i = 1
	loop
		exitwhen (i > bj_MAX_INVENTORY)
		call UnitRemoveItemFromSlotSwapped(i, hero)
		set i = i + 1
	endloop
endfunction

function PrepareRandomDist takes integer highestCreepLevel returns nothing
    local integer level0Percentage = 100
	local integer level4Percentage = 100
	local integer level6Percentage = 100
	local integer level8Percentage = 100
	local integer i
	call RandomDistReset()

	if (highestCreepLevel > 8) then
		call RandomDistAddItem('infs', level8Percentage)
		call RandomDistAddItem('hval', level8Percentage)
		call RandomDistAddItem('scav', level8Percentage)
		call RandomDistAddItem('rej6', level8Percentage)
		call RandomDistAddItem('shar', level8Percentage)
		call RandomDistAddItem('engr', level8Percentage)
		call RandomDistAddItem('ankh', level8Percentage)
		call RandomDistAddItem('sor5', level8Percentage)
	endif

	if (highestCreepLevel > 5) then
		call RandomDistAddItem('will', level6Percentage)
		call RandomDistAddItem('fgdg', level6Percentage)
		call RandomDistAddItem('rej3', level6Percentage)
		call RandomDistAddItem('rej4', level6Percentage)
		call RandomDistAddItem('sand', level6Percentage)
		call RandomDistAddItem('lmbr', level6Percentage)
		call RandomDistAddItem('rat6', level6Percentage)
		call RandomDistAddItem('rat6', level6Percentage)
		call RandomDistAddItem('fgun', level6Percentage)
	endif

	if (highestCreepLevel > 5) then
        call RandomDistAddItem('hslv', level4Percentage)
        call RandomDistAddItem('rhe2', level4Percentage)
        call RandomDistAddItem('rma2', level4Percentage)
        call RandomDistAddItem('totw', level4Percentage)
        call RandomDistAddItem('shea', level4Percentage)
        call RandomDistAddItem('whwd', level4Percentage)
        call RandomDistAddItem('fgrg', level4Percentage)
        call RandomDistAddItem('wswd', level4Percentage)
        call RandomDistAddItem('rman', level4Percentage)
        call RandomDistAddItem('gold', level4Percentage)
        call RandomDistAddItem('shar', level4Percentage)
        call RandomDistAddItem('fgrd', level4Percentage)
        call RandomDistAddItem('fgfh', level4Percentage)
        call RandomDistAddItem('sres', level4Percentage)
        call RandomDistAddItem('sror', level4Percentage)
        call RandomDistAddItem('pinv', level4Percentage)
	endif
	// low level general stuff
	call RandomDistAddItem('rnec', level0Percentage)
	call RandomDistAddItem('skul', level0Percentage)
	call RandomDistAddItem('silk', level0Percentage)
	call RandomDistAddItem('hslv', level0Percentage)
	call RandomDistAddItem('rhe2', level0Percentage)
	call RandomDistAddItem('pman', level0Percentage)
	call RandomDistAddItem('pclr', level0Percentage)
	call RandomDistAddItem('rspd', level0Percentage)
	call RandomDistAddItem('sreg', level0Percentage)
	call RandomDistAddItem('rspl', level0Percentage)
	call RandomDistAddItem('rnec', level0Percentage)
	call RandomDistAddItem('rsps', level0Percentage)
	call RandomDistAddItem('rdis', level0Percentage)

	set i = 0
	loop
		exitwhen (i == bj_randDistCount)
		set bj_randDistChance[i] = 100 / bj_randDistCount
		set i = i + 1
	endloop
endfunction

function DropRandomItem takes unit whichUnit, integer highestCreepLevel returns item
    call PrepareRandomDist(highestCreepLevel)
	return UnitDropItem(whichUnit, RandomDistChoose())
endfunction

function DropRandomItemFromWidget takes widget inWidget, integer highestCreepLevel returns item
    call PrepareRandomDist(highestCreepLevel)
    return WidgetDropItem(inWidget, RandomDistChoose())
endfunction

function GetUnitLevelByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_LEVEL)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDamageTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitWeaponIntegerField(dummy , UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDefenseTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_DEFENSE_TYPE)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitMovementTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_MOVE_TYPE)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetHighestLevelFromGroup takes integer Group returns integer
	local integer result = 0
	local integer index = 0
	local integer level = 0
	local integer i = 0
        loop
		exitwhen(i == udg_RespawnGroupMaxMembers)
		set index = Index2D(Group, i, udg_RespawnGroupMaxMembers)
		if (udg_RespawnUnitType[index] != null and udg_RespawnUnitType[index] != 0) then
			set level = GetUnitLevelByType(udg_RespawnUnitType[index])
			if (level > result) then
				set result = level
			endif
		endif
		set i = i + 1
	endloop
	return result
endfunction

function DropRandomItemForGroup takes unit whichUnit, integer Group returns item
	return DropRandomItem(whichUnit, GetHighestLevelFromGroup(Group))
endfunction

function DropRandomItemForGroupFromWidget takes widget inWidget, integer Group returns item
	return DropRandomItemFromWidget(inWidget, GetHighestLevelFromGroup(Group))
endfunction

function DropRandomItemForGroupNTimes takes unit whichUnit, integer Group returns nothing
	local integer n = GetRandomInt(0, 2)
	local item whichItem = null
	local integer i = 0
	loop
		exitwhen (i == n)
		set whichItem = DropRandomItemForGroup(whichUnit, Group)
        call AddItemToAllStock(GetItemTypeId(whichItem), 1, 1)
		set i = i + 1
	endloop
endfunction

function DropRandomItemForGroupNTimesFromWidget takes widget inWidget, integer Group returns nothing
	local integer n = GetRandomInt(0, 2)
	local item whichItem = null
	local integer i = 0
	loop
		exitwhen (i == n)
		set whichItem = DropRandomItemForGroupFromWidget(inWidget, Group)
        call AddItemToAllStock(GetItemTypeId(whichItem), 1, 1)
		set i = i + 1
	endloop
endfunction

function TriggerConditionRespawnMonster takes nothing returns boolean
    return GetRespawnGroupOfUnit(GetTriggerUnit()) != -1
endfunction

function TriggerActionRespawnMonster takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local integer Group = GetRespawnGroupOfUnit(triggerUnit)
    local real RandomNumber = 0.0
    local location ItemSpawnLocation = null
    local item whichItem = null
    debug call BJDebugMsg("Respawn monster with group " + I2S(Group) + " handle ID: " + I2S(GetHandleId(triggerUnit)))
    if (Group != -1) then
        call GroupRemoveUnit(udg_RespawnGroup[Group], triggerUnit)
        if (not IsUnitType(triggerUnit, UNIT_TYPE_HERO)) then
			call FlushUnitParameters(triggerUnit)
			call AddUnitToAllStock(GetUnitTypeId(triggerUnit), 1, 1)
		endif
		if (IsUnitGroupEmptyBJ(udg_RespawnGroup[Group])) then
            set RandomNumber = GetRandomReal(0.00, 100.00)
            if (RandomNumber <= udg_RespawnItemChance) then
                //set ItemSpawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
                //set whichItem = CreateItem(udg_RespawnItemType[Group], GetLocationX(ItemSpawnLocation), GetLocationY(ItemSpawnLocation))
                call DropRandomItemForGroupNTimes(triggerUnit, Group)
                //call AddItemToAllStock(GetItemTypeId(whichItem), 1, 1)
                //call RemoveLocation(ItemSpawnLocation)
                //set ItemSpawnLocation = null
            endif
            call RespawnGroupTimed(Group)
        endif
    endif
    set triggerUnit = null
endfunction

function TriggerActionDestructableDrops takes nothing returns nothing
    local integer Group = GetRespawnGroupOfDestructable(GetDyingDestructable())
    call DropRandomItemForGroupNTimesFromWidget(GetDyingDestructable(), Group)
endfunction

function InitCustomSystems takes nothing returns nothing
    local integer I0 = 0
    set udg_DB = InitHashtable()
    call SetupRPGSystems()
    call SetupCustomRucksackSystem()
    call SetupCustomRespawningSystem()
    // Movement Trigger
    if (udg_UseRucksackSystem) then
        set udg_RucksackTrigger = CreateTrigger()
        call TriggerRegisterTimerEvent(udg_RucksackTrigger, udg_RucksackMoveTime, true)
        call TriggerAddAction(udg_RucksackTrigger, function TriggerActionMoveRucksack)
    endif
    // Respawn Trigger
    if (udg_UseRespawningSystem) then
        set udg_RespawnTrigger = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_RespawnTrigger, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH, null)
		call TriggerRegisterPlayerUnitEvent(udg_RespawnTrigger, udg_BossesPlayer, EVENT_PLAYER_UNIT_DEATH, null)
		call TriggerRegisterPlayerUnitEvent(udg_RespawnTrigger, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_CHANGE_OWNER, null)
		call TriggerRegisterPlayerUnitEvent(udg_RespawnTrigger, udg_BossesPlayer, EVENT_PLAYER_UNIT_CHANGE_OWNER, null)
		call TriggerAddCondition(udg_RespawnTrigger, Condition(function TriggerConditionRespawnMonster))
        call TriggerAddAction(udg_RespawnTrigger, function TriggerActionRespawnMonster)

        set udg_RespawnDestructableTrigger = CreateTrigger()
        call TriggerAddAction(udg_RespawnDestructableTrigger, function TriggerActionDestructableDrops)
    endif
endfunction

function GetPlayerColorRed takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0xFF
    elseif c == PLAYER_COLOR_BLUE then
        return 0x00
    elseif c == PLAYER_COLOR_CYAN then
        return 0x1B
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x53
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFF
    elseif c == PLAYER_COLOR_ORANGE then
        return 0xFE
    elseif c == PLAYER_COLOR_GREEN then
        return 0x1F
    elseif c == PLAYER_COLOR_PINK then
        return 0xE4
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x94
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0x7D
    elseif c == PLAYER_COLOR_AQUA then
        return 0x0F
    elseif c == PLAYER_COLOR_BROWN then
        return 0x4D
    elseif c == PLAYER_COLOR_MAROON then
        return 0x9B
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0x00
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xBE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xEB
    elseif c == PLAYER_COLOR_PEACH then
        return 0xF8
    elseif c == PLAYER_COLOR_MINT then
        return 0xBF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xDC
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xEB
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x00
    elseif c == PLAYER_COLOR_PEANUT then
        return 0xA4
    else
        return 0xFF
    endif
    return 0
endfunction

function GetPlayerColorGreen takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0x41
    elseif c == PLAYER_COLOR_CYAN then
        return 0xE5
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x00
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFC
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x89
    elseif c == PLAYER_COLOR_GREEN then
        return 0xBF
    elseif c == PLAYER_COLOR_PINK then
        return 0x5A
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x95
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xBE
    elseif c == PLAYER_COLOR_AQUA then
        return 0x61
    elseif c == PLAYER_COLOR_BROWN then
        return 0x29
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xEA
    elseif c == PLAYER_COLOR_VIOLET then
        return 0x00
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xCD
    elseif c == PLAYER_COLOR_PEACH then
        return 0xA4
    elseif c == PLAYER_COLOR_MINT then
        return 0xFF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xB9
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xF0
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x78
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x6F
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorBlue takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0xFF
    elseif c == PLAYER_COLOR_CYAN then
        return 0xB8
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x80
    elseif c == PLAYER_COLOR_YELLOW then
        return 0x00
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x0D
    elseif c == PLAYER_COLOR_GREEN then
        return 0x00
    elseif c == PLAYER_COLOR_PINK then
        return 0xAF
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x96
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xF1
    elseif c == PLAYER_COLOR_AQUA then
        return 0x45
    elseif c == PLAYER_COLOR_BROWN then
        return 0x03
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0xC3
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xFF
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xFE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0x87
    elseif c == PLAYER_COLOR_PEACH then
        return 0x8B
    elseif c == PLAYER_COLOR_MINT then
        return 0x80
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xEB
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xFF
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x1E
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x33
    else
        return 0xFF
    endif
endfunction

function IntToPrecentage takes integer v, integer max returns real
    return I2R(v) / I2R(max) * 100.0
endfunction

function GetPlayerColorString takes player p, string text returns string
//Credits to Andrewgosu from TH for the color codes//
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return "|cffFF0202" + text + "|r"
    elseif c == PLAYER_COLOR_BLUE then
        return "|cff0041FF" + text + "|r"
    elseif c == PLAYER_COLOR_CYAN then
        return "|cff1BE5B8" + text + "|r"
    elseif c == PLAYER_COLOR_PURPLE then
        return "|cff530080" + text + "|r"
    elseif c == PLAYER_COLOR_YELLOW then
        return "|cffFFFC00" + text + "|r"
    elseif c == PLAYER_COLOR_ORANGE then
        return "|cffFE890D" + text + "|r"
    elseif c == PLAYER_COLOR_GREEN then
        return "|cff1FBF00" + text + "|r"
    elseif c == PLAYER_COLOR_PINK then
        return "|cffE45AAF" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return "|cff949596" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return "|cff7DBEF1" + text + "|r"
    elseif c == PLAYER_COLOR_AQUA then
        return "|cff0F6145" + text + "|r"
    elseif c == PLAYER_COLOR_BROWN then
        return "|cff4D2903" + text + "|r"
    elseif c == PLAYER_COLOR_MAROON then
        return "|cff9B0000" + text + "|r"
    elseif c == PLAYER_COLOR_NAVY then
        return "|cff0000C3" + text + "|r"
    elseif c == PLAYER_COLOR_TURQUOISE then
        return "|cff00EAFF" + text + "|r"
    elseif c == PLAYER_COLOR_VIOLET then
        return "|cffBE00FE" + text + "|r"
    elseif c == PLAYER_COLOR_WHEAT then
        return "|cffEBCD87" + text + "|r"
    elseif c == PLAYER_COLOR_PEACH then
        return "|cffF8A48B" + text + "|r"
    elseif c == PLAYER_COLOR_MINT then
        return "|cffBFFF80" + text + "|r"
    elseif c == PLAYER_COLOR_LAVENDER then
        return "|cffDCB9EB" + text + "|r"
    elseif c == PLAYER_COLOR_COAL then
        return "|cff282828" + text + "|r"
    elseif c == PLAYER_COLOR_SNOW then
        return "|cffEBF0FF" + text + "|r"
    elseif c == PLAYER_COLOR_EMERALD then
        return "|cff00781E" + text + "|r"
    elseif c == PLAYER_COLOR_PEANUT then
        return "|cffA46F33" + text + "|r"
    else
        return "|cffFFFFFF" + text + "|r"
    endif
endfunction

function GetPlayerNameColored takes player whichPlayer returns string
	return "[" + I2S(GetPlayerId(whichPlayer) + 1) + "]" + GetPlayerColorString(whichPlayer, GetPlayerName(whichPlayer))
endfunction

function HookAddUnitToGroup takes unit whichUnit, group whichGroup returns nothing
    set udg_LastAddedUnitToGroup = whichUnit
endfunction

hook GroupAddUnitSimple HookAddUnitToGroup

function GetNextCraftedProfessionItemEx takes player whichPlayer, integer profession returns integer
	local unit hero = udg_Held[GetConvertedPlayerId(whichPlayer)]
	if (profession == udg_ProfessionHerbalist) then // Herbalism
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I025'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'pnvu'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'hlst'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'pghe'
		endif

	endif
	if (profession == udg_ProfessionAlchemist) then // Alchemy
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I024'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'woms'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'mnst'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'pgma'
		endif

	endif
	if (profession == udg_ProfessionWeaponSmith) then // Weapon Smith
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00R'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'I00Q'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00P'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00O'
		endif

	endif
	if (profession == udg_ProfessionArmourer) then // Armourer
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00N'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'I00M'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00L'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00K'
		endif

	endif
	if (profession == udg_ProfessionEngineer) then // Engineer
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00S' // tiny death tower
		endif
//		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			//return 'I00M' // 2 gobline sappers
//		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00U' // tiny cold tower
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00T' // tiny flame tower
		endif

	endif
	return 0
endfunction

function GetNextCraftedProfessionItem takes player whichPlayer returns integer
	local integer profession = udg_PlayerProfession[GetConvertedPlayerId(whichPlayer)]
	return GetNextCraftedProfessionItemEx(whichPlayer, profession)
endfunction

function GetNextCraftedProfession2Item takes player whichPlayer returns integer
	local integer profession = udg_PlayerProfession2[GetConvertedPlayerId(whichPlayer)]
	return GetNextCraftedProfessionItemEx(whichPlayer, profession)
endfunction

/**
 * Race system.
 *
 * All unit, building and item types might belong to a specific race. This information can be useful when replacing units, buildings or items or preventing players from using them since
 * they have chosen different races.
 */
globals
    // BUILDINGS
    constant integer RACE_OBJECT_TYPE_FARM = 0
    constant integer RACE_OBJECT_TYPE_ALTAR = 1
    constant integer RACE_OBJECT_TYPE_MILL = 2
    constant integer RACE_OBJECT_TYPE_BLACK_SMITH = 3
    constant integer RACE_OBJECT_TYPE_BARRACKS = 4
    constant integer RACE_OBJECT_TYPE_SHOP = 5
    constant integer RACE_OBJECT_TYPE_SCOUT_TOWER = 6
    constant integer RACE_OBJECT_TYPE_GUARD_TOWER = 7
    constant integer RACE_OBJECT_TYPE_CANNON_TOWER = 8
    constant integer RACE_OBJECT_TYPE_ARCANE_TOWER = 9
    constant integer RACE_OBJECT_TYPE_ARCANE_SANCTUM = 10
    constant integer RACE_OBJECT_TYPE_WORKSHOP = 11
    constant integer RACE_OBJECT_TYPE_GRYPHON_AVIARY = 12
    constant integer RACE_OBJECT_TYPE_TIER_1 = 13
    constant integer RACE_OBJECT_TYPE_TIER_2 = 14
    constant integer RACE_OBJECT_TYPE_TIER_3 = 15
    constant integer RACE_OBJECT_TYPE_HOUSING = 16
    constant integer RACE_OBJECT_TYPE_SHIPYARD = 17
    // ITEMS
    constant integer RACE_OBJECT_TYPE_SCEPTER_ITEM = 18
    constant integer RACE_OBJECT_TYPE_TIER_1_ITEM = 19
    constant integer RACE_OBJECT_TYPE_TIER_2_ITEM = 20
    // UNITS
    constant integer RACE_OBJECT_TYPE_WORKER = 21
    constant integer RACE_OBJECT_TYPE_MALE_CITIZEN = 22
    constant integer RACE_OBJECT_TYPE_FEMALE_CITIZEN = 23
    constant integer RACE_OBJECT_TYPE_PET = 24
    constant integer RACE_OBJECT_TYPE_FOOTMAN = 25
    constant integer RACE_OBJECT_TYPE_RIFLEMAN = 26
    constant integer RACE_OBJECT_TYPE_KNIGHT = 27
    constant integer RACE_OBJECT_TYPE_PRIEST = 28
    constant integer RACE_OBJECT_TYPE_SORCERESS = 29
    constant integer RACE_OBJECT_TYPE_SIEGE_ENGINE = 30
    constant integer RACE_OBJECT_TYPE_MORTAR = 31
    constant integer RACE_OBJECT_TYPE_GRYPHON = 32

    constant integer RACE_MAX_OBJECT_TYPES = 33

    integer array raceObjectType
endglobals

function SetRaceObjectType takes integer whichRace, integer unitType, integer objectTypeId returns nothing
    set raceObjectType[Index2D(whichRace, unitType, RACE_MAX_OBJECT_TYPES)] = objectTypeId
endfunction

function GetRaceObjectType takes integer whichRace, integer unitType returns integer
    return raceObjectType[Index2D(whichRace, unitType, RACE_MAX_OBJECT_TYPES)]
endfunction

function GetObjectRace takes integer objectTypeId returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return i
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return udg_RaceNone
endfunction

function GetObjectRaceType takes integer objectTypeId returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return j
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return -1
endfunction

function MapRaceObjectType takes integer objectTypeId, integer targetRace returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return GetRaceObjectType(targetRace, j)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return 0
endfunction

function InitStandardRaceObjectTypes takes nothing returns nothing
    // BUILDINGS

    // farms
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_FARM, 'hhou')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_FARM, 'otrb')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_FARM, 'uzig')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_FARM, 'emow')

    // altars
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_ALTAR, 'halt')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_ALTAR, 'oalt')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_ALTAR, 'uaod')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_ALTAR, 'eate')

    // mills
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_MILL, 'hlum')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_MILL, 'ofor')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_MILL, 'ugrv')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_MILL, 'edob')

    // black smiths
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_BLACK_SMITH, 'hbla')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_BLACK_SMITH, 'ofor')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_BLACK_SMITH, 'ugrv')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_BLACK_SMITH, 'edob')

    // barracks
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_BARRACKS, 'hbar')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_BARRACKS, 'obar')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_BARRACKS, 'usep')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_BARRACKS, 'eaom')

    // shops
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_SHOP, 'hars')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_SHOP, 'ovln')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_SHOP, 'utom')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_SHOP, 'eden')

    // guard tower
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_GUARD_TOWER, 'hgtw')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_GUARD_TOWER, 'owtw')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_GUARD_TOWER, 'uzg1')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_GUARD_TOWER, 'etrp')

    // arcane sanctum
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'hars')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'osld')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'utod')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'eaoe')

    // gryphon aviary
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'hgra')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'otto')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'ubon')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'edos')

    // tier 1
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_1, 'htow')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_1, 'ogre')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_1, 'unpl')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_1, 'etol')

    // tier 2
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_2, 'hkee')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_2, 'ostr')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_2, 'unp1')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_2, 'etoa')

    // tier 3
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_3, 'hcas')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_3, 'ofrt')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_3, 'unp2')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_3, 'etoe')

    // ITEMS

    // tier 1 item
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02P')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_1_ITEM, 'tgrh')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02K')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02J')
    call SetRaceObjectType(udg_RaceNaga, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02M')
    call SetRaceObjectType(udg_RaceBloodElf, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02L')
    call SetRaceObjectType(udg_RaceDemon, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02N')
    call SetRaceObjectType(udg_RaceDraenei, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02O')
    call SetRaceObjectType(udg_RaceFurbolg, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I03A')
    call SetRaceObjectType(udg_RaceGoblin, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I03A')

   // tier 2 item
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_2_ITEM, 'tcas')

   // UNITS

   // worker
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_WORKER, 'hpea')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_WORKER, 'opeo')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_WORKER, 'uaco')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_WORKER, 'ewsp')

   // male citizen
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00E')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00I')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00G')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00O')

   // footman
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_FOOTMAN, 'hfoo')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_FOOTMAN, 'ogru')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_FOOTMAN, 'ugho')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_FOOTMAN, 'earc')

   // rifleman
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_RIFLEMAN, 'hrif')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_RIFLEMAN, 'ohun')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_RIFLEMAN, 'ucry')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_RIFLEMAN, 'esen')

   // knight
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_KNIGHT, 'hkni')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_KNIGHT, 'orai')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_KNIGHT, 'uabo')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_KNIGHT, 'edoc')
endfunction

function GetBuildingRace takes integer buildingID returns integer
    return GetObjectRace(buildingID)
endfunction

// exclude certain buildings since every race can build them
function IsBuildingAllRaces takes integer buildingID returns boolean
    if (buildingID == 'n025') then // power generator
        return true
    elseif (buildingID == 'h00N') then // Temple of Darkness
        return true
    elseif (buildingID == 'h00M') then // Temple of Light
        return true
    elseif (buildingID == 'h020') then // Gate horizontal closed
        return true
    elseif (buildingID == 'h021') then // Gate horizontal open
        return true
    endif

    return false
endfunction

function GetItemRace takes integer itemID returns integer
    return GetObjectRace(itemID)
endfunction

function GetUnitIDRace takes integer unitID returns integer
    return GetObjectRace(unitID)
endfunction

function MapBuildingID takes integer buildingID, integer targetRace returns integer
    return MapRaceObjectType(buildingID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapBuildingNumber takes integer buildingID, integer targetRace returns integer
    return 1
endfunction

function MapBuildingIDToItemID takes integer buildingID, integer targetRace returns integer
    local integer raceType = GetObjectRaceType(buildingID)

    if (raceType == RACE_OBJECT_TYPE_TIER_1) then
        return GetRaceObjectType(targetRace, RACE_OBJECT_TYPE_TIER_1_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_TIER_2) then
        return GetRaceObjectType(targetRace, RACE_OBJECT_TYPE_TIER_2_ITEM)
    endif

    return 0
endfunction

function MapUnitID takes integer unitID, integer targetRace, boolean includingWorkers returns integer
    local integer raceType = -1
    if (not includingWorkers) then
        set raceType = GetObjectRaceType(unitID)

        if (raceType == RACE_OBJECT_TYPE_WORKER or raceType == RACE_OBJECT_TYPE_MALE_CITIZEN) then
            return 0
        endif
    endif

    return MapRaceObjectType(unitID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapUnitNumber takes integer unitID, integer targetRace returns integer
    return 1
endfunction

function FilterIsBuilding takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

// TODO Group created items by their ID with more charges per item.
function WrapUpAllBuildings takes player whichPlayer, real x, real y returns integer
    local group allBuildings = CreateGroup()
    local unit first = null
    local integer itemTypeId = 0
    local integer targetRace = udg_RaceNone
    local item whichItem = null
    local integer counter = 0
    local boolean remove = false
    call GroupEnumUnitsOfPlayer(allBuildings, whichPlayer, Filter(function FilterIsBuilding))
    loop
        set first = FirstOfGroup(allBuildings)
        exitwhen (first == null)
        set remove = false
        set targetRace = GetBuildingRace(GetUnitTypeId(first))
        call BJDebugMsg("Building " + GetUnitName(first) + " has target race " + I2S(targetRace))
        if (targetRace != udg_RaceNone) then
            set itemTypeId = MapBuildingIDToItemID(GetUnitTypeId(first), targetRace)
            call BJDebugMsg("Building " + GetUnitName(first) + " has target item type " + GetObjectName(itemTypeId))
            if (itemTypeId != 0) then
                set whichItem = CreateItem(itemTypeId, x, y)
                call SetItemCharges(whichItem, MapBuildingNumber(GetUnitTypeId(first), targetRace))
                set counter = counter + 1
                set remove = true
            endif
        endif
        call GroupRemoveUnit(allBuildings, first)

        if (remove) then
            call RemoveUnit(first)
        endif

        set first = null
    endloop
    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null

    return counter
endfunction


/**
 * Barade's save code system.
 *
 * save code digit - a digit of the number system used for a save code. This can be decimal, hexadecimal or custom.
 * save code segment - a savecode consists of multiple segments storing information about specific properties.
 * save code segment separator - the segments are separated by a special digit which is not used in the save code's digit to identify where a new segment starts
 * save code - a save code using the digits of a sepcific number system consisting of one or several segments.
 * string hash - a decimal value generated from a string using a one way function which cannot be converted back into its original string. We only use positive hash values to keep it simple.
 * player name hash - a hash value from the player name used to verify that the savecode belongs to the using player
 * save code checksum - a checksum of the save code in form of ea save code segment created by hashing the string up to excluding the checksum segment itself. This is used to verify that the savecode was not created manually although it could be faked.
 *
 * Our save code looks the following way:
 * <player name hash segment>X<game mode/single or multiplayer flag>X<game type>X<hero XP rate>X<hero XP>X<checksum>
 *
 * Obfuscation: Since it is pretty easy to know which segment has which information using these save code segments, we want to obfuscate the final generated save code a bit.
 * We can do this by shifting the used digits using the player name hash since it will also be the same when the player loads the save code. By shifting the digits we might get different digits for different player name hashs.
 *
 * Compression: We want to keep the savecodes as short as possible. Hence, we combine flags like game mode and single/multiplayer in one number. We could go even further as long as we know the maximum number of a value.
 * Another form of compression is to make the string hashes much shorter by using the modulo operation. This comes with the risk of having less different string hashes for different player names or as checksums but as long
 * as there are enough possibilities it is hard enough to fake the correct string hash value.
 */

globals
    //constant string SAVE_CODE_DIGITS = "0123456789ABCDEF" // hexadecimal digits
    constant string SAVE_CODE_DIGITS = "w19B2hj5c74LHlWmAKrvGPopUuSNeRzIDkCFVQ8Y6OqdytiTJsnx0g3bMafZE" // 1.9.6
    //constant string SAVE_CODE_DIGITS = "_Ci{o98%*rQaHA=cM>Pj]NTUq/u7y(-S!)hzpR:}DKLvBJXI4O [k@e53<FVftm,6dlZ&bY2~^#\"nx'+wG|?s\\`E1$;.0gW" // ASCII
    constant string SAVE_CODE_SEGMENT_SEPARATOR = "X" // must not be part of SAVE_CODE_DIGITS
    constant boolean SAVE_CODE_COMPRESS_STRING_HASHS = true
    constant boolean SAVE_CODE_OBFUSCATE = true
endglobals

function CheckStringForDuplicatedCharacters takes string source returns nothing
    local boolean foundDuplicated = false
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == StringLength(source))
        set j = 0
        loop
            exitwhen (j == StringLength(source))
            if (i != j and SubString(source, i, i + 1) == SubString(source, j, j + 1)) then
                set foundDuplicated = true
                call BJDebugMsg("Duplicated digit at " + I2S(i) + " and " + I2S(j) + ": " + SubString(source, i, i + 1))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    if (not foundDuplicated) then
        call BJDebugMsg("No duplicates have been found!")
    endif
endfunction

function CheckSaveCodeDigitsUnique takes nothing returns nothing
    call CheckStringForDuplicatedCharacters(SAVE_CODE_DIGITS)
endfunction

/**
 * Returns the base for the custom number system.
 */
function GetMaxSaveCodeDigits takes nothing returns integer
    return StringLength(SAVE_CODE_DIGITS)
endfunction

function ConvertDecimalDigitToSaveCodeDigit takes integer digit returns string
    return SubString(SAVE_CODE_DIGITS, digit, digit + 1)
endfunction


/**
 * Convert a decimal number into our number system.
 */
function ConvertDecimalNumberToSaveCodeSegment takes integer number returns string
    local string result = ""
    local integer start = number
    local integer base = GetMaxSaveCodeDigits()
    local integer mod = 0
    //call BJDebugMsg("Converting number " + I2S(start))
    loop
        //call BJDebugMsg("Dividing number " + I2S(start) + " by " + I2S(base))
        set mod = ModuloInteger(start, base)
        set start = start / base
        set result = ConvertDecimalDigitToSaveCodeDigit(mod) + result
        exitwhen (start == 0)
        //call BJDebugMsg("Result: " + result)
    endloop

    return result + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function IndexOfString takes string symbol, string source returns integer
    local integer i = 0
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        exitwhen (i == StringLength(source))
        if (SubString(source, i, i + 1) == symbol) then
            //call BJDebugMsg("Index: " + I2S(i))
            return i
        endif
        set i = i + 1
    endloop

    call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return -1
endfunction


function IndexOfSaveCodeDigit takes string symbol returns integer
    return IndexOfString(symbol, SAVE_CODE_DIGITS)
endfunction

function GetObfuscationSaveCodeDigits takes nothing returns string
    // we want to have the separator in it so we can obfuscate the whole save code with separators.
    return SAVE_CODE_DIGITS + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function GetMaxObfuscationSaveCodeDigits takes nothing returns integer
    return GetMaxSaveCodeDigits() + 1
endfunction

function GetShiftedSaveCodeSplitPosition takes integer n returns integer
    return ModuloInteger(n, GetMaxObfuscationSaveCodeDigits())
endfunction

/**
 * Use a hash value (like the player name's hash) to move the symbol table. This might prevent reproducing savecodes too easily.
 */
function GetShiftedSaveCodeDigits takes integer n returns string
    local integer max = GetMaxObfuscationSaveCodeDigits()
    local string saveCodeDigits = GetObfuscationSaveCodeDigits()
    local integer splitPosition = GetShiftedSaveCodeSplitPosition(n)
    return SubString(saveCodeDigits, splitPosition, GetMaxObfuscationSaveCodeDigits()) + SubString(saveCodeDigits, 0, splitPosition)
endfunction

function ConvertSaveCodeToObfuscatedVersion takes string saveCode, integer hash returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigits(hash)
    local string saveCodeDigits = GetObfuscationSaveCodeDigits()
    local integer index = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set index = IndexOfString(SubString(saveCode, i, i + 1), saveCodeDigits)
        if (index != -1) then
            set result = result + SubString(shiftedSaveCodeDigits, index, index + 1)
        else
            set result = result + "?"
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ConvertSaveCodeFromObfuscatedVersion takes string saveCode, integer hash returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigits(hash)
    local integer splitPosition = GetShiftedSaveCodeSplitPosition(hash)
    local integer shiftedIndex = -1
    local integer originalIndex = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set shiftedIndex = IndexOfString(SubString(saveCode, i, i + 1), shiftedSaveCodeDigits)
        if (shiftedIndex != -1) then
            set result = result + SubString(GetObfuscationSaveCodeDigits(), shiftedIndex, shiftedIndex + 1)
        else
            set result = result + "?"
        endif
        set i = i + 1
    endloop
    return result
endfunction

function PowI takes integer x, integer y returns integer
    local integer result = 1
    local integer i = 0
    loop
        exitwhen (i == y)
        set result = result * x
        set i = i + 1
    endloop

    return result
endfunction

/**
 * Convert our number system into the decimal system number.
 */
function ConvertSaveCodeSegmentIntoDecimalNumber takes string symbol, integer n returns integer
    local integer index = IndexOfSaveCodeDigit(symbol)
    if (index != -1) then
        //call BJDebugMsg("Index " + I2S(index) +  " for symbol " + symbol + " pow " + I2S(GetMaxSaveCodeDigits()) + ", " + I2S(n))
        return index * PowI(GetMaxSaveCodeDigits(), n)
    endif
    //call BJDebugMsg("Cannot find symbol: " + symbol + " with n: " + I2S(n))
    return 0
endfunction

// the separator comes after a segment
function GetSaveCodeSegments takes string saveCode returns integer
    local integer separatorCounter = 0
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        endif
        set i = i + 1
    endloop

    return separatorCounter
endfunction

// includes the separator character!
function GetSaveCodeUntil takes string saveCode, integer excludedIndex returns string
    local integer separatorCounter = 0
    local integer index = StringLength(saveCode)
    local integer i = 0
    loop
        exitwhen (separatorCounter >= excludedIndex or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
            set index = i + 1 // include the separator character!
        endif
        set i = i + 1
    endloop

    return SubString(saveCode, 0, index)
endfunction

/**
 * Extracts the part of a save code with index and converts it into a decimal number.
 */
function ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode takes string saveCode, integer index returns integer
    local string substr = ""
    local integer result = 0
    local integer separatorCounter = 0
    local integer n = -1 // start with n - 1 and end with 0
    local integer i = 0
    loop
        exitwhen (separatorCounter > index or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        elseif (separatorCounter == index) then
            set substr = substr + SubString(saveCode, i, i + 1)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // convert into decimal number
    //call BJDebugMsg("Calculate number back " + substr)
    set i = 0
    loop
        exitwhen (i == StringLength(substr))
        set result = result + ConvertSaveCodeSegmentIntoDecimalNumber(SubString(substr, i, i + 1), n)
        //call BJDebugMsg("Result " + I2S(result))
        set n = n - 1
        set i = i + 1
    endloop

    return result
endfunction

function FilterPlayerFunctionUsedUser takes nothing returns boolean
    return GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER and GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING
endfunction

function IsInSinglePlayer takes nothing returns boolean
    return CountPlayersInForceBJ(GetPlayersMatching(Condition(function FilterPlayerFunctionUsedUser))) == 1
endfunction

// We don't want to handle negative numbers.
function AbsStringHash takes string whichString returns integer
    return IAbsBJ(StringHash(whichString))
endfunction

function CompressedAbsStringHash takes string whichString returns integer
    local integer absStringHash = AbsStringHash(whichString)
    if (SAVE_CODE_COMPRESS_STRING_HASHS) then
        return ModuloInteger(absStringHash, GetMaxSaveCodeDigits() * 3)
    endif
    return absStringHash
endfunction

function AppendFileContent takes string content returns string
    return "\r\n\t\t\t\t" + content
endfunction

function ConvertSaveCodeDemigodValueToInfo takes integer value returns string
    if (value == 1) then
        return "Light Demigod"
    elseif (value == 2) then
        return "Dark Demigod"
    endif

    return "No Demigod"
endfunction

function CreateSaveCodeTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer xpRate, integer heroLevel, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer improvedNavyLevel, integer demigodValue, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -load " + saveCode)
    set content = content + AppendFileContent("Player: " + playerName)
    set content = content + AppendFileContent("Singleplayer: " + singleplayer)
    set content = content + AppendFileContent("Game Mode: " + gameMode)
    set content = content + AppendFileContent("Game Type: " + gameType)
    set content = content + AppendFileContent("XP rate: " + I2S(xpRate))
    set content = content + AppendFileContent("Hero Level: " + I2S(heroLevel))
    set content = content + AppendFileContent("XP: " + I2S(xp))
    set content = content + AppendFileContent("Demigod: " + ConvertSaveCodeDemigodValueToInfo(demigodValue))
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Evolution: " + I2S(evolutionLevel))
    set content = content + AppendFileContent("Improved Power Generator: " + I2S(powerGeneratorLevel))
    set content = content + AppendFileContent("Hand of God: " + I2S(handOfGodLevel))
    set content = content + AppendFileContent("Improved Mount: " + I2S(mountLevel))
    set content = content + AppendFileContent("Improved Masonry: " + I2S(masonryLevel))
    set content = content + AppendFileContent("Improved Navy: " + I2S(improvedNavyLevel))
    set content = content + AppendFileContent("Hero Kills: " + I2S(heroKills))
    set content = content + AppendFileContent("Hero Deaths: " + I2S(heroDeaths))
    set content = content + AppendFileContent("Unit Kills: " + I2S(unitKills))
    set content = content + AppendFileContent("Unit Deaths: " + I2S(unitDeaths))
    set content = content + AppendFileContent("Buildings Razed: " + I2S(buildingsRazed))
    set content = content + AppendFileContent("Boss Kills: " + I2S(totalBossKills))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Hero Level 2: " + I2S(heroLevel2))
    set content = content + AppendFileContent("XP 2: " + I2S(xp2))

    set content = content + AppendFileContent("Hero Level 3: " + I2S(heroLevel3))
    set content = content + AppendFileContent("XP 3: " + I2S(xp3))

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-heroLevel-" + I2S(heroLevel) + "-xp-" + I2S(xp) + "-heroLevel2-" + I2S(heroLevel2) + "-xp2-" + I2S(xp2) + "-heroLevel3-" + I2S(heroLevel3) + "-xp3-" + I2S(xp3) + "-" + ConvertSaveCodeDemigodValueToInfo(demigodValue) + ".txt")
endfunction

// use one single symbol to store these two flags
function GetSinglePlayerAndGameMode takes boolean isSinglePlayer, boolean isWarlord returns integer
    if (isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 0")
        return 0
    elseif (isSinglePlayer and not isWarlord) then
        //call BJDebugMsg("Save code single player and mode 1")
        return 1
    elseif (not isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 2")
        return 2
    else
        //call BJDebugMsg("Save code single player and mode 3")
        return 3
    endif

    return 0
endfunction

function GetSinglePlayerFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return true
    elseif (saveCodeSegment == 2) then
        return false
    else
        return false
    endif

    return false
endfunction

function GetWarlordFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return false
    elseif (saveCodeSegment == 2) then
        return true
    else
        return false
    endif

    return false
endfunction

function GetSaveCodeEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, integer heroLevel, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer improvedNavyLevel, integer demigodValue returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp)

    // resources
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber)

    // upgrades
    set result = result + ConvertDecimalNumberToSaveCodeSegment(evolutionLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(powerGeneratorLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(handOfGodLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(mountLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(masonryLevel)

    // stats
    set result = result + ConvertDecimalNumberToSaveCodeSegment(heroKills)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(heroDeaths)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(unitKills)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(unitDeaths)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(buildingsRazed)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(totalBossKills)

    // hero 2
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp2)

    // hero 3
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp3)

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // upgrades
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedNavyLevel)

    // demigod
    set result = result + ConvertDecimalNumberToSaveCodeSegment(demigodValue)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeTextFile(playerName, isSinglePlayer, isWarlord, gameType, xpRate, heroLevel, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills, heroLevel2, xp2, heroLevel3, xp3, improvedNavyLevel, demigodValue, result)

    return result
endfunction

globals
    constant integer UPG_EVOLUTION                                   = 'R00U'
    constant integer UPG_CHEAP_EVOLUTION                             = 'R01V'
	constant integer UPG_IMPROVED_POWER_GENERATOR                    = 'R01T'
	constant integer UPG_IMPROVED_MOUNT                              = 'R024'
	constant integer UPG_IMPROVED_HAND_OF_GOD                        = 'R00V'
	constant integer UPG_IMPROVED_MASONRY                            = 'R00W'
	constant integer UPG_IMPROVED_NAVY                               = 'R035'
endglobals

function GetSaveCodeDemigodValue takes integer unitTypeId returns integer
    if (unitTypeId == 'H003') then
        return 1
    elseif (unitTypeId == 'H002') then
        return 2
    endif

    return 0
endfunction

/**
 * Simple Save/Load system which converts decimal numbers into numbers from SAVE_CODE_DIGITS.
 * It starts with the player name's hash, so you can only use your own savecodes in multiplayer games etc.
 * Besides, the settings are stored. All numbers are separated by a separator character.
 * It adds a final checksum of the savecode to make it harder to fake any savecode by just replacing certain values of it.
 * If it ends with separators it will be compressed by removing separator characters from the end.
 * TODO If we only store the level value, the save code gets MUCH shorter.
 * TODO Store stats for the multiboard to show what a player has achieved. This could also be useful for online leaderboards.
 */
function GetSaveCode takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))
    local integer heroLevel = GetHeroLevel(udg_Held[GetConvertedPlayerId(whichPlayer)])
    local integer xp = GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])
    local integer gold = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
    local integer lumber = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
    local integer evolutionLevel = GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
    local integer powerGeneratorLevel = GetPlayerTechCountSimple(UPG_IMPROVED_POWER_GENERATOR, whichPlayer)
    local integer handOfGodLevel = GetPlayerTechCountSimple(UPG_IMPROVED_HAND_OF_GOD, whichPlayer)
    local integer mountLevel = GetPlayerTechCountSimple(UPG_IMPROVED_MOUNT, whichPlayer)
    local integer masonryLevel = GetPlayerTechCountSimple(UPG_IMPROVED_MASONRY, whichPlayer)
    local integer heroKills = GetPlayerScore(whichPlayer, PLAYER_SCORE_HEROES_KILLED)
    local integer heroDeaths = udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)]
    local integer unitKills = GetPlayerScore(whichPlayer, PLAYER_SCORE_UNITS_KILLED)
    local integer unitDeaths =  udg_UnitsLost[GetConvertedPlayerId(whichPlayer)]
    local integer buildingsRazed = GetPlayerScore(whichPlayer, PLAYER_SCORE_STRUCT_RAZED)
    local integer totalBossKills = udg_BossKills[GetConvertedPlayerId(whichPlayer)]
    local integer heroLevel2 = GetHeroLevel(udg_Held2[GetConvertedPlayerId(whichPlayer)])
    local integer xp2 = GetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)])
    local integer heroLevel3 = GetHeroLevel(udg_Held3[GetConvertedPlayerId(whichPlayer)])
    local integer xp3 = GetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)])
    local integer improvedNavyLevel = GetPlayerTechCountSimple(UPG_IMPROVED_NAVY, whichPlayer)

    if (udg_Held2[GetConvertedPlayerId(whichPlayer)] == null) then
        set xp2 = udg_Held2XP[GetConvertedPlayerId(whichPlayer)]
        set heroLevel2 = 0 // TODO Set hero level by XP
    endif

    return GetSaveCodeEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, heroLevel, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills, heroLevel2, xp2, heroLevel3, xp3, improvedNavyLevel, GetSaveCodeDemigodValue(GetUnitTypeId(udg_Held[GetConvertedPlayerId(whichPlayer)])))
endfunction

function ReadSaveCode takes string saveCode, integer hash returns string
    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Deobfuscating with the hash!")
        return ConvertSaveCodeFromObfuscatedVersion(saveCode, hash)
    endif

    //call BJDebugMsg("Just returning!")

    return saveCode
endfunction

function SetPlayerTechResearchedIfHigher takes player whichPlayer, integer techId, integer level returns boolean
    if (level > GetPlayerTechCountSimple(techId, whichPlayer)) then
        call SetPlayerTechResearched(whichPlayer, techId, level)
        return true
    endif

    return false
endfunction

function ApplySaveCodeOld takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        call SetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)], xp, true)

        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_EVOLUTION, evolutionLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_CHEAP_EVOLUTION, evolutionLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_POWER_GENERATOR, powerGeneratorLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_HAND_OF_GOD, handOfGodLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MOUNT, mountLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MASONRY, masonryLevel)

        set udg_HeroKills[GetConvertedPlayerId(whichPlayer)] = heroKills
        set udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)] = heroDeaths
        set udg_UnitKills[GetConvertedPlayerId(whichPlayer)] = unitKills
        set udg_UnitsLost[GetConvertedPlayerId(whichPlayer)] = unitDeaths
        set udg_BuildingsRazed[GetConvertedPlayerId(whichPlayer)] = buildingsRazed
        set udg_BossKills[GetConvertedPlayerId(whichPlayer)] = totalBossKills

        if (udg_Held2[GetConvertedPlayerId(whichPlayer)] != null and xp2 > GetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)])) then
            call SetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)], xp2, true)
        endif

        if (udg_Held2[GetConvertedPlayerId(whichPlayer)] == null and xp2 > udg_Held2XP[GetConvertedPlayerId(whichPlayer)]) then
            set udg_Held2XP[GetConvertedPlayerId(whichPlayer)] = xp2
        endif

        return true
    endif

    return false
endfunction

function ApplySaveCode takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        call SetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)], xp, true)

        if (demigodValue == 1) then
            set udg_TmpUnit = udg_Held[GetConvertedPlayerId(whichPlayer)]
            call TriggerExecute(gg_trg_Become_Demigod_Light)
        elseif (demigodValue == 2) then
            set udg_TmpUnit = udg_Held[GetConvertedPlayerId(whichPlayer)]
            call TriggerExecute(gg_trg_Become_Demigod_Dark)
        endif

        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_EVOLUTION, evolutionLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_CHEAP_EVOLUTION, evolutionLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_POWER_GENERATOR, powerGeneratorLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_HAND_OF_GOD, handOfGodLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MOUNT, mountLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MASONRY, masonryLevel)
        call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_NAVY, improvedNavyLevel)

        set udg_HeroKills[GetConvertedPlayerId(whichPlayer)] = heroKills
        set udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)] = heroDeaths
        set udg_UnitKills[GetConvertedPlayerId(whichPlayer)] = unitKills
        set udg_UnitsLost[GetConvertedPlayerId(whichPlayer)] = unitDeaths
        set udg_BuildingsRazed[GetConvertedPlayerId(whichPlayer)] = buildingsRazed
        set udg_BossKills[GetConvertedPlayerId(whichPlayer)] = totalBossKills

        if (udg_Held2[GetConvertedPlayerId(whichPlayer)] != null and xp2 > GetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)])) then
            call SetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)], xp2, true)
        endif

        if (udg_Held2[GetConvertedPlayerId(whichPlayer)] == null and xp2 > udg_Held2XP[GetConvertedPlayerId(whichPlayer)]) then
            set udg_Held2XP[GetConvertedPlayerId(whichPlayer)] = xp2
        endif

        if (udg_Held3[GetConvertedPlayerId(whichPlayer)] != null and xp3 > GetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)])) then
            call SetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)], xp3, true)
        endif

        if (udg_Held3[GetConvertedPlayerId(whichPlayer)] == null and xp3 > udg_Held3XP[GetConvertedPlayerId(whichPlayer)]) then
            set udg_Held3XP[GetConvertedPlayerId(whichPlayer)] = xp3
        endif

        return true
    endif

    // for savecodes from older versions of the map
    return ApplySaveCodeOld(whichPlayer, s)
endfunction

function GetSaveCodeErrors takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set result = result + "Expected different checksum!"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected different player name!"
    endif

    if (isSinglePlayer != IsInSinglePlayer()) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isSinglePlayer) then
            set result = result + "Expected singleplayer!"
        else
            set result = result + "Expected multiplayer!"
        endif
    endif

    if (gameType != udg_GameType) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected game type: " + I2S(gameType)
    endif

    if (isWarlord != udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isWarlord) then
            set result = result + "Expected game mode Warlord!"
        else
            set result = result + "Expected game mode Freelancer!"
        endif
    endif

    if (xpRate != R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected XP rate: " + I2S(xpRate)
    endif

    if (xp <= GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected more XP than your current!"
    endif

    if (checksum == CompressedAbsStringHash(saveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        set result = "None errors detected. Stored " + I2S(xp) + "XP."
    endif

    return result
endfunction

function GetGameTypeName takes integer gameType returns string
    if (gameType == udg_GameTypeEasy) then
        return "Easy"
    elseif (gameType == udg_GameTypeHardcore) then
        return "Hardcore"
    elseif (gameType == udg_GameTypeFast) then
        return "Fast"
    endif

    return "Normal"
endfunction

function AppendSaveCodeInfo takes string result, string appended returns string
    if (StringLength(result) > 0) then
        set result = result + "|n"
    endif

    return result + appended
endfunction

function GetSaveCodeInfos takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerName = GetPlayerName(whichPlayer)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif


    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "XP: " + I2S(xp))
    set result = AppendSaveCodeInfo(result, "Demigod: " + demigodValueInfo)
    set result = AppendSaveCodeInfo(result, "XP 2: " + I2S(xp2))
    set result = AppendSaveCodeInfo(result, "XP 3: " + I2S(xp3))
    set result = AppendSaveCodeInfo(result, "Gold: " + I2S(gold))
    set result = AppendSaveCodeInfo(result, "Lumber: " + I2S(lumber))
    set result = AppendSaveCodeInfo(result, "Evolution: " + I2S(evolutionLevel))
    set result = AppendSaveCodeInfo(result, "Power Generator: " + I2S(powerGeneratorLevel))
    set result = AppendSaveCodeInfo(result, "Hand of God: " + I2S(handOfGodLevel))
    set result = AppendSaveCodeInfo(result, "Mount: " + I2S(mountLevel))
    set result = AppendSaveCodeInfo(result, "Masonry: " + I2S(masonryLevel))
    set result = AppendSaveCodeInfo(result, "Navy: " + I2S(improvedNavyLevel))
    set result = AppendSaveCodeInfo(result, "Hero Kills: " + I2S(heroKills))
    set result = AppendSaveCodeInfo(result, "Hero Deaths: " + I2S(heroDeaths))
    set result = AppendSaveCodeInfo(result, "Hero Kills: " + I2S(unitKills))
    set result = AppendSaveCodeInfo(result, "Unit Deaths: " + I2S(unitDeaths))
    set result = AppendSaveCodeInfo(result, "Buildings Razed: " + I2S(buildingsRazed))
    set result = AppendSaveCodeInfo(result, "Boss kills: " + I2S(totalBossKills))

    return result
endfunction

function IsCharacterUpperCase takes string letter returns boolean
    return letter == "A" or letter == "B" or letter == "C" or letter == "D" or letter == "E" or letter == "F" or letter == "G" or letter == "H" or letter == "I" or letter == "J" or letter == "K" or letter == "L" or letter == "M" or letter == "N" or letter == "O" or letter == "P" or letter == "Q" or letter == "R" or letter == "S" or letter == "T" or letter == "U" or letter == "V" or letter == "W" or letter == "X" or letter == "Y" or letter == "Z"
endfunction

function ColoredSaveCode takes string saveCode returns string
    local string result = ""
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        if (IsCharacterUpperCase(SubString(saveCode, i, i + 1))) then
            set result = result + "|cffffcc00" + SubString(saveCode, i, i + 1) + "|r"
        else
            set result = result + SubString(saveCode, i, i + 1)
        endif
        set i = i + 1
    endloop

    return result
endfunction

function FormatIntegerToTwoDigits takes integer value returns string
    if (value > 9) then
        return I2S(value)
    else
        return "0" + I2S(value)
    endif
endfunction

function FormatTimeString takes integer seconds returns string
    local integer minutes = seconds / 60
    local integer hours = minutes / 60
    local integer hoursInMinutes = hours * 60
    local integer minutesInSeconds = minutes * 60

    set minutes = minutes - hoursInMinutes
    set seconds = seconds - minutesInSeconds

    if (hours > 0) then
        return FormatIntegerToTwoDigits(hours) + ":" + FormatIntegerToTwoDigits(minutes) + ":" + FormatIntegerToTwoDigits(seconds)
    elseif (minutes > 0) then
        return FormatIntegerToTwoDigits(minutes) + ":" + FormatIntegerToTwoDigits(seconds)
    else
        return I2S(seconds) + " seconds "
    endif
endfunction


globals
    string array SaveObjectNameUnit
    integer array SaveObjectIdUnit
    integer SaveObjectUnitCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameBuilding
    integer array SaveObjectIdBuilding
    integer SaveObjectBuildingCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameItem
    integer array SaveObjectIdItem
    integer SaveObjectItemCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameResearch
    integer array SaveObjectIdResearch
    integer SaveObjectResearchCounter = 1 // start with 1 so 0 won't lead to anything
endglobals

function DisplaySaveObjectCounters takes nothing returns nothing
    call BJDebugMsg("Save Object Unit Counter: " + I2S(SaveObjectUnitCounter))
    call BJDebugMsg("Save Object Building Counter: " + I2S(SaveObjectBuildingCounter))
    call BJDebugMsg("Save Object Item Counter: " + I2S(SaveObjectItemCounter))
    call BJDebugMsg("Save Object Research Counter: " + I2S(SaveObjectResearchCounter))
endfunction

function DisplayDuplicateSaveObjects takes nothing returns nothing
    local integer j
    local integer i = 0
    call BJDebugMsg("Save Object Duplicates:")
    loop
        exitwhen (i == SaveObjectUnitCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectUnitCounter)
            if (i != j and SaveObjectIdUnit[i] == SaveObjectIdUnit[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdUnit[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectBuildingCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectBuildingCounter)
            if (i != j and SaveObjectIdBuilding[i] == SaveObjectIdBuilding[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdBuilding[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectItemCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectItemCounter)
            if (i != j and SaveObjectIdItem[i] == SaveObjectIdItem[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdItem[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectResearchCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectResearchCounter)
            if (i != j and SaveObjectIdResearch[i] == SaveObjectIdResearch[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdResearch[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddSaveObjectUnitTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectUnitCounter
    set SaveObjectNameUnit[index] = name
    set SaveObjectIdUnit[index] = id
    set SaveObjectUnitCounter = SaveObjectUnitCounter + 1
    return index
endfunction

function AddSaveObjectBuildingTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectBuildingCounter
    set SaveObjectNameBuilding[index] = name
    set SaveObjectIdBuilding[index] = id
    set SaveObjectBuildingCounter = SaveObjectBuildingCounter + 1
    return index
endfunction

function AddSaveObjectUnitType takes nothing returns integer
    if (IsUnitIdType(udg_TmpUnitType, UNIT_TYPE_STRUCTURE)) then
        return AddSaveObjectBuildingTypeEx(GetObjectName(udg_TmpUnitType), udg_TmpUnitType)
    else
        return AddSaveObjectUnitTypeEx(GetObjectName(udg_TmpUnitType), udg_TmpUnitType)
    endif
endfunction

function GetSaveObjectUnitType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectUnitCounter)
        if (SaveObjectIdUnit[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectUnitId takes integer number returns integer
    return SaveObjectIdUnit[number]
endfunction

function GetSaveObjectBuildingType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectBuildingCounter)
        if (SaveObjectIdBuilding[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectBuildingId takes integer number returns integer
    return SaveObjectIdBuilding[number]
endfunction

function AddSaveObjectItemTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectItemCounter
    set SaveObjectNameItem[index] = name
    set SaveObjectIdItem[index] = id
    set SaveObjectItemCounter = SaveObjectItemCounter + 1
    return index
endfunction

function AddSaveObjectItemType takes nothing returns integer
    return AddSaveObjectItemTypeEx(GetObjectName(udg_TmpItemTypeId), udg_TmpItemTypeId)
endfunction

function GetSaveObjectItemType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectItemCounter)
        if (SaveObjectIdItem[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectItemId takes integer number returns integer
    return SaveObjectIdItem[number]
endfunction

function AddSaveObjectResearchTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectResearchCounter
    set SaveObjectNameResearch[index] = name
    set SaveObjectIdResearch[index] = id
    set SaveObjectResearchCounter = SaveObjectResearchCounter + 1
    return index
endfunction

function AddSaveObjectResearch takes nothing returns integer
    return AddSaveObjectResearchTypeEx(GetObjectName(udg_TmpTechType), udg_TmpTechType)
endfunction

function GetSaveObjectResearchType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectResearchCounter)
        if (SaveObjectIdResearch[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectResearchId takes integer number returns integer
    return SaveObjectIdResearch[number]
endfunction

function DisplaySaveCodeError takes player whichPlayer, string message returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, message)
endfunction

function DisplaySaveCodeErrorAtLeastOne takes player whichPlayer, boolean atLeastOne returns nothing
    if (not atLeastOne) then
        call DisplaySaveCodeError(whichPlayer, "Empty savecode!")
    endif
endfunction

function DisplaySaveCodeErrorLowerResearch takes player whichPlayer, integer techId returns nothing
    call DisplaySaveCodeError(whichPlayer, "Not loading research " + GetObjectName(techId) + " since your current level is higher or equal!")
endfunction

function CreateSaveCodeBuildingsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer buildings, string buildingNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadb " + saveCode)
    set content = content + AppendFileContent("Buildings: " + I2S(buildings))
    set content = content + AppendFileContent("Building Names: " + buildingNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-buildings-" + I2S(buildings) + "-" + buildingNames + ".txt")
endfunction

globals
    constant integer SAVE_CODE_MAX_BUILDINGS = 8
endglobals

function FilterIsLivingBuildingToBeSaved takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetSaveObjectBuildingType(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

function GetPlayerBuildingsOrderedByPriority takes player whichPlayer returns group
    local group whichGroup = CreateGroup()
    local group buildingsToBeSaved = GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingBuildingToBeSaved))
    local unit first = null
    call GroupAddGroup(udg_SaveCodeIncludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)
    loop
        set first = FirstOfGroup(buildingsToBeSaved)
        exitwhen (first == null)
        if (not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(buildingsToBeSaved, first)
    endloop

    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)

    call GroupClear(buildingsToBeSaved)
    call DestroyGroup(buildingsToBeSaved)
    set buildingsToBeSaved = null

    return whichGroup
endfunction

function GetAbsCoordinate takes real coordinate, real min returns real
    return RAbsBJ(min) + coordinate
endfunction

function GetAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = GetAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function GetAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = GetAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function ConvertAbsCoordinate takes real coordinate, real min returns real
    return coordinate - RAbsBJ(min)
endfunction

function ConvertAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = ConvertAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function ConvertAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = ConvertAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function GetSaveCodeBuildingsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner, group b returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local group buildings = CopyGroup(b)
    local unit first = null
    local integer id = -1
    local integer i = 0
    local integer buildingsCounter = 0
    local string buildingNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    //call BJDebugMsg("Size of buildings: " + I2S(CountUnitsInGroup(buildings)))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    // 5 buildings with their locations
    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set first = FirstOfGroup(buildings)
        exitwhen (first == null)
        set id = GetSaveObjectBuildingType(GetUnitTypeId(first))
        if (id != -1) then
            //call BJDebugMsg("Saving building: " + GetObjectName(GetUnitTypeId(first)))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitX(first))))
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitX(first)))
            //call BJDebugMsg("Saving building X (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateX(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateX(GetUnitX(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitY(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitY(first)))
            //call BJDebugMsg("Saving building Y (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateY(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateY(GetUnitY(first))))
            set buildingsCounter = buildingsCounter + 1
            if (buildingNames != "") then
                set buildingNames = buildingNames + ","
            endif
            set buildingNames = buildingNames + GetUnitName(first)
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        call GroupRemoveUnit(buildings, first)
        set first = null
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_BUILDINGS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    call GroupClear(buildings)
    call DestroyGroup(buildings)
    set buildings = null

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeBuildingsTextFile(playerName, isSinglePlayer, isWarlord, gameType, buildingsCounter, buildingNames, result)

    return result
endfunction

function GetSaveCodeBuildingsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local group buildings = GetPlayerBuildingsOrderedByPriority(owner)
    local string result = GetSaveCodeBuildingsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, owner, buildings)

    call GroupClear(buildings)
    call DestroyGroup(buildings)
    set buildings = null

    return result
endfunction

function GetSaveCodeBuildings takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeBuildingsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function IsObjectFromPlayerRace takes integer objectID, player whichPlayer returns boolean
    local integer objectRace = GetObjectRace(objectID)
    return objectRace == udg_RaceNone or objectRace == udg_PlayerRace[GetConvertedPlayerId(whichPlayer)] or objectRace == udg_PlayerRace2[GetConvertedPlayerId(whichPlayer)]
endfunction

function DisplayObjectRaceLoadError takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, "Unable to load " + GetObjectName(objectID) + " since it does not belong to your chosen race(s)!")
endfunction

function ApplySaveCodeBuildings takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        set i = 0
        loop
            exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
            set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
            if (saveObject > 0) then
                set saveObjectId = GetSaveObjectBuildingId(saveObject)
                if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                    set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
                    set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
                    //call BJDebugMsg("Loading building " + GetObjectName(saveObjectId) + " at " + R2S(x) + "|" + R2S(y))
                    call CreateUnit(whichPlayer, saveObjectId, x, y, bj_UNIT_FACING)
                    set atLeastOne = true
                else
                    call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                endif
            endif
            set i = i + 1
            set pos = pos + 3
        endloop

        call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

        return atLeastOne
    endif

    return false
endfunction

function GetSaveCodeInfosBuildings takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectBuildingId(saveObject)
            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + R2S(x) + "|" + R2S(y) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + R2S(x) + "|" + R2S(y) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Building Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Building with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 3
    endloop

    return result
endfunction


function CreateSaveCodeItemsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer items, string itemNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadi " + saveCode)
    set content = content + AppendFileContent("Items: " + I2S(items))
    set content = content + AppendFileContent("Item Names: " + itemNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-items-" + I2S(items)  + "-" + itemNames + ".txt")
endfunction

function GetSaveCodeItemsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, item itemSlot0, item itemSlot1, item itemSlot2, item itemSlot3, item itemSlot4, item itemSlot5 returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local integer id = -1
    local integer itemCounter = 0
    local string itemNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    if (itemSlot0 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot0))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot0))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot0)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
        endif
    endif

    if (itemSlot1 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot1))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot1))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot1)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot1))
        endif
    endif

    if (itemSlot2 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot2))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot2))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot2)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot2))
        endif
    endif

    if (itemSlot3 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot3))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot3))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot3)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot3))
        endif
    endif

    if (itemSlot4 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot4))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot4))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot4)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot4))
        endif
    endif

    if (itemSlot5 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot5))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot5))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot5)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot5))
        endif
    endif

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeItemsTextFile(playerName, isSinglePlayer, isWarlord, gameType, itemCounter, itemNames, result)

    return result
endfunction

function GetSaveCodeItemsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, unit hero returns string
    return GetSaveCodeItemsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, UnitItemInSlot(hero, 0), UnitItemInSlot(hero, 1), UnitItemInSlot(hero, 2), UnitItemInSlot(hero, 3), UnitItemInSlot(hero, 4), UnitItemInSlot(hero, 5))
endfunction


function GetSaveCodeItems takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, udg_Hero[GetPlayerId(whichPlayer)])
endfunction

function ApplySaveCodeItems takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local unit hero = udg_Hero[GetPlayerId(whichPlayer)]
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        set i = 0
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
            if (saveObject > 0) then
                set saveObjectId = GetSaveObjectItemId(saveObject)
                if (IsObjectFromPlayerRace(saveObject, whichPlayer)) then
                    call UnitAddItemByIdSwapped(saveObjectId, hero)
                    call SetItemCharges(bj_lastCreatedItem, ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1))
                    set atLeastOne = true
                else
                    call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                endif
            endif
            set i = i + 1
            set pos = pos + 2
        endloop

        call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

        return atLeastOne
    endif

    return false
endfunction

function GetSaveCodeInfosItems takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer charges = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectItemId(saveObject)
            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(charges) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(charges) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Item Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

globals
    constant integer SAVE_CODE_MAX_UNITS = 10
endglobals

function FilterIsLivingUnitToBeSaved takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetUnitTypeId(GetFilterUnit()) != 'o018' and GetUnitTypeId(GetFilterUnit()) != 'o00P' and GetSaveObjectUnitType(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

function CountUnitsOfTypeFromGroup takes group whichGroup, integer unitTypeId returns integer
    local group tmpGroup = CopyGroup(whichGroup)
    local integer i = 0
    local unit first = null
    loop
        set first = FirstOfGroup(tmpGroup)
        exitwhen (first == null)
        if (GetUnitTypeId(first) == unitTypeId) then
            set i = i + 1
        endif
        call GroupRemoveUnit(tmpGroup, first)
    endloop

    call GroupClear(tmpGroup)
    call DestroyGroup(tmpGroup)
    set tmpGroup = null

    return i
endfunction

function DistinctGroup takes group whichGroup returns group
    local group tmpGroup = CopyGroup(whichGroup)
    local group result = CreateGroup()
    local unit first = null
    loop
        set first = FirstOfGroup(tmpGroup)
        exitwhen (first == null)
        if (CountUnitsOfTypeFromGroup(result, GetUnitTypeId(first)) == 0) then
            call GroupAddUnit(result, first)
        endif
        call GroupRemoveUnit(tmpGroup, first)
    endloop

    call GroupClear(tmpGroup)
    call DestroyGroup(tmpGroup)
    set tmpGroup = null

    return result
endfunction

function GetPlayerUnitsOrderedByPriority takes player whichPlayer returns group
    local group whichGroup = CreateGroup()
    local group livingUnitsToBeSaved = GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingUnitToBeSaved))
    local unit first = null
    local group result = null
    call GroupAddGroup(udg_SaveCodeIncludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)
    loop
        set first = FirstOfGroup(livingUnitsToBeSaved)
        exitwhen (first == null)
        if (not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(livingUnitsToBeSaved, first)
    endloop
    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)

    //call BJDebugMsg("Size of units before distinct: " + I2S(CountUnitsInGroup(whichGroup)))

    set result = DistinctGroup(whichGroup)

    //call BJDebugMsg("Size of units after distinct: " + I2S(CountUnitsInGroup(result)))

    call GroupClear(whichGroup)
    call DestroyGroup(whichGroup)
    set whichGroup = null

    call GroupClear(livingUnitsToBeSaved)
    call DestroyGroup(livingUnitsToBeSaved)
    set livingUnitsToBeSaved = null

    return result
endfunction

function CreateSaveCodeUnitsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer units, string unitNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadu " + saveCode)
    set content = content + AppendFileContent("Units: " + I2S(units))
    set content = content + AppendFileContent("Unit Names: " + unitNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-units-" + I2S(units)  + "-" + unitNames + ".txt")
endfunction

function GetSaveCodeUnitsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner, group source returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local group units = CopyGroup(source)
    local unit first = null
    local integer id = -1
    local integer i = 0
    local integer unitsCounter = 0
    local group tmpGroup = null
    local integer count = 0
    local string unitNames = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    set i = 0
    loop
        exitwhen (unitsCounter == SAVE_CODE_MAX_UNITS)
        set first = FirstOfGroup(units)
        exitwhen (first == null)
        set id = GetSaveObjectUnitType(GetUnitTypeId(first))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set tmpGroup = GetUnitsOfPlayerAndTypeId(owner, GetUnitTypeId(first))
            set count = CountUnitsInGroup(tmpGroup)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(count)
            if (unitNames != "") then
                set unitNames = unitNames + ","
            endif
            set unitNames = unitNames + I2S(count) + GetUnitName(first)
            call GroupClear(tmpGroup)
            call DestroyGroup(tmpGroup)
            set tmpGroup = null
            set unitsCounter = unitsCounter + 1
            //call BJDebugMsg("Added " + GetUnitName(first) + " with count " + I2S(count))
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        call GroupRemoveUnit(units, first)
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_UNITS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    call GroupClear(units)
    call DestroyGroup(units)
    set units = null

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeUnitsTextFile(playerName, isSinglePlayer, isWarlord, gameType, unitsCounter, unitNames, result)

    return result
endfunction

function GetSaveCodeUnitsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local group units = GetPlayerUnitsOrderedByPriority(owner)
    local string result = GetSaveCodeUnitsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, owner, units)

    call GroupClear(units)
    call DestroyGroup(units)
    set units = null

    return result
endfunction


function GetSaveCodeUnits takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeUnitsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function ApplySaveCodeUnits takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer j = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local location tmpLocation = Location(GetUnitX(udg_Hero[GetPlayerId(whichPlayer)]), GetUnitY(udg_Hero[GetPlayerId(whichPlayer)]))
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        set i = 0
        loop
            exitwhen (i == SAVE_CODE_MAX_UNITS)
            set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
            //call BJDebugMsg("Loading save object: " + I2S(saveObject))
            if (saveObject > 0) then
                set saveObjectId = GetSaveObjectUnitId(saveObject)
                set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                set j = 0
                loop
                    exitwhen (j == count)
                    // the player does not have to build all farms before but the limit should not be exceeded
                    if (GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED) + GetFoodUsed(saveObjectId) <= GetPlayerState(whichPlayer, PLAYER_STATE_FOOD_CAP_CEILING)) then
                        if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                            call CreateUnitAtLocSaveLast(whichPlayer, saveObjectId, tmpLocation, GetUnitFacing(udg_Hero[GetPlayerId(whichPlayer)]))
                            set atLeastOne = true
                        else
                            call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                        endif
                    else
                        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetObjectName(saveObjectId) + " exceeds your food maximum and hence is not loaded.")
                    endif
                    set j = j + 1
                endloop
            endif
            set i = i + 1
            set pos = pos + 2
        endloop

        call RemoveLocation(tmpLocation)
        set tmpLocation = null

        call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

        return atLeastOne
    endif

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return false
endfunction

function GetSaveCodeInfosUnits takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_UNITS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        //call BJDebugMsg("Loading save object: " + I2S(saveObject))
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectUnitId(saveObject)
            set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(count) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(count) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Unit Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

globals
    constant integer SAVE_CODE_MAX_RESEARCHES = 10
endglobals

function CreateSaveCodeResearchesTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer researches, string researchNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadr " + saveCode)
    set content = content + AppendFileContent("Researches: " + I2S(researches))
    set content = content + AppendFileContent("Research Names: " + researchNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-researches-" + I2S(researches)  + "-" + researchNames + ".txt")
endfunction

function GetSaveCodeResearchesEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local integer id = -1
    local integer i = 0
    local integer researchesCounter = 0
    local integer count = 0
    local string researchNames = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    set i = 0
    loop
        exitwhen (researchesCounter == SAVE_CODE_MAX_RESEARCHES or i == SaveObjectResearchCounter)
        set id = GetSaveObjectResearchType(i)
        set count = GetPlayerTechCountSimple(id, owner)
        if (id != -1 and count > 0) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetPlayerTechCountSimple(id, owner))
            if (researchNames != "") then
                set researchNames = researchNames + ","
            endif
            set researchNames = researchNames + I2S(count) + GetObjectName(id)
            set researchesCounter = researchesCounter + 1
        endif
        set i = i + 1
    endloop

    // fill rest
    set i = researchesCounter
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeResearchesTextFile(playerName, isSinglePlayer, isWarlord, gameType, researchesCounter, researchNames, result)

    return result
endfunction


function GetSaveCodeResearches takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeResearchesEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function ApplySaveCodeResearches takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        set i = 0
        loop
            exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
            set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
            //call BJDebugMsg("Loading save object: " + I2S(saveObject))
            if (saveObject > 0) then
                set saveObjectId = GetSaveObjectResearchId(saveObject)
                if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                    set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                    //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                    if (not SetPlayerTechResearchedIfHigher(whichPlayer, saveObjectId, count)) then
                        call DisplaySaveCodeErrorLowerResearch(whichPlayer, saveObjectId)
                    endif
                    set atLeastOne = true
                else
                    call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                endif
            endif
            set i = i + 1
            set pos = pos + 2
        endloop

        call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

        return atLeastOne
    endif

    return false
endfunction


function GetSaveCodeInfosResearches takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer level = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectResearchId(saveObject)
            set level = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(level) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(level) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Research Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Research with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

globals
    constant integer SAVE_CODE_MAX_CLAN_MEMBERS = 6

    constant integer UPG_IMPROVED_CLAN_HALL = 'R03C'
    constant integer UPG_IMPROVED_CLAN = 'R03B'
endglobals

function GetClanRankName takes integer rank returns string
    if (rank == udg_ClanRankLeader) then
        return "Leader"
    elseif (rank == udg_ClanRankCaptain) then
        return "Captain"
    else
        return "Member"
    endif
endfunction

function CreateSaveCodeClanTextFile takes boolean isSinglePlayer, string name, integer icon, integer gold, integer lumber, integer improvedClanHallLevel, integer improvedClanLevel, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string leader = ""
    local string members = ""
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (StringLength(playerName0) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName0 + "_" + GetClanRankName(playerRank0)

        if (playerRank0 == udg_ClanRankLeader) then
            set leader = playerName0
        endif
    endif

    if (StringLength(playerName1) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName1 + "_" + GetClanRankName(playerRank1)

        if (playerRank1 == udg_ClanRankLeader) then
            set leader = playerName1
        endif
    endif

    if (StringLength(playerName2) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName2 + "_" + GetClanRankName(playerRank2)

        if (playerRank2 == udg_ClanRankLeader) then
            set leader = playerName2
        endif
    endif

    if (StringLength(playerName3) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName3 + "_" + GetClanRankName(playerRank3)

        if (playerRank3 == udg_ClanRankLeader) then
            set leader = playerName3
        endif
    endif

    if (StringLength(playerName4) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName4 + "_" + GetClanRankName(playerRank4)

        if (playerRank4 == udg_ClanRankLeader) then
            set leader = playerName4
        endif
    endif


    if (StringLength(playerName5) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName5 + "_" + GetClanRankName(playerRank5)

        if (playerRank5 == udg_ClanRankLeader) then
            set leader = playerName5
        endif
    endif

    if (StringLength(playerName6) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        set members = members + playerName6 + "_" + GetClanRankName(playerRank6)

        if (playerRank6 == udg_ClanRankLeader) then
            set leader = playerName6
        endif
    endif

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadc " + saveCode)
    set content = content + AppendFileContent("Name: " + name)
    set content = content + AppendFileContent("Icon: " + GetObjectName(icon))
    set content = content + AppendFileContent("Leader: " + leader)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Members: " + members)
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Improved Clan Hall Level: " + I2S(improvedClanHallLevel))
    set content = content + AppendFileContent("Improved Clan Level: " + I2S(improvedClanLevel))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-Clan-" + name + "-" + playerName0 + "-" + singlePlayerFileName + "-gold-" + I2S(gold) + "-lumber-" + I2S(lumber) + "-" + members + ".txt")
endfunction

function GetSaveCodeClanEx takes boolean isSinglePlayer, string name, integer icon, integer gold, integer lumber, integer improvedClanHallLevel, integer improvedClanLevel, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6 returns string
    local string result = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (isSinglePlayer) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
    else
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1)
    endif
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(name))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(icon)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedClanHallLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedClanLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName0))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank0)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName1))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank1)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName2))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank2)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName3))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank3)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName4))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank4)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName5))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank5)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName6))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank6)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, CompressedAbsStringHash(name))
    endif

    call CreateSaveCodeClanTextFile(isSinglePlayer, name, icon, gold, lumber, improvedClanHallLevel, improvedClanLevel, playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6, result)

    return result
endfunction

function GetSaveCodeClan takes integer clan returns string
     local string playerName0 = ""
     local integer playerRank0 = udg_ClanRankMember
     local string playerName1 = ""
     local integer playerRank1 = udg_ClanRankMember
     local string playerName2 = ""
     local integer playerRank2 = udg_ClanRankMember
     local string playerName3 = ""
     local integer playerRank3 = udg_ClanRankMember
     local string playerName4 = ""
     local integer playerRank4 = udg_ClanRankMember
     local string playerName5 = ""
     local integer playerRank5 = udg_ClanRankMember
     local string playerName6 = ""
     local integer playerRank6 = udg_ClanRankMember
     local integer improvedClanHallLevel = 0
     local integer improvedClanLevel = 0
     local integer clanMemberCounter = 0
     local integer i = 0
     loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
            set improvedClanHallLevel = IMaxBJ(GetPlayerTechCountSimple(UPG_IMPROVED_CLAN_HALL, Player(i)), improvedClanHallLevel)
            set improvedClanLevel = IMaxBJ(GetPlayerTechCountSimple(UPG_IMPROVED_CLAN, Player(i)), improvedClanLevel)

            if (clanMemberCounter == 0) then
                set playerName0 = GetPlayerName(Player(i))
                set playerRank0 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 1) then
                set playerName1 = GetPlayerName(Player(i))
                set playerRank1 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 2) then
                set playerName2 = GetPlayerName(Player(i))
                set playerRank2 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 3) then
                set playerName3 = GetPlayerName(Player(i))
                set playerRank3 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 4) then
                set playerName4 = GetPlayerName(Player(i))
                set playerRank4 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 5) then
                set playerName5 = GetPlayerName(Player(i))
                set playerRank5 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 6) then
                set playerName6 = GetPlayerName(Player(i))
                set playerRank6 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            endif
            set clanMemberCounter = clanMemberCounter + 1
        endif
        set i = i + 1
    endloop

    return GetSaveCodeClanEx(bj_isSinglePlayer, udg_ClanName[clan], udg_ClanIcon[clan], udg_ClanGold[clan], udg_ClanLumber[clan], improvedClanHallLevel, improvedClanLevel, playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6)
endfunction

function ApplySaveCodeClan takes player whichPlayer, string name, string s returns boolean
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer improvedClanHallLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer improvedClanLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and nameHash == CompressedAbsStringHash(name) and isSinglePlayer == IsInSinglePlayer()) then
        if (playerNameHash == playerNameHash0 or playerNameHash == playerNameHash1 or playerNameHash == playerNameHash2 or playerNameHash == playerNameHash3 or playerNameHash == playerNameHash4 or playerNameHash == playerNameHash5 or playerNameHash == playerNameHash6) then
            set i = 1
            loop
                exitwhen (i > udg_ClanCounter)
                if (StringLength(udg_ClanName[i]) > 0 and udg_ClanName[i] == name) then
                    set clan = i
                endif
                set i = i + 1
            endloop

            if (clan == 0) then
                set udg_ClanName[udg_ClanCounter] = name
                set udg_ClanGold[udg_ClanCounter] = gold
                set udg_ClanLumber[udg_ClanCounter] = lumber
                set udg_ClanCounter = udg_ClanCounter + 1

            endif

            set i = 0
            loop
                exitwhen (i == bj_MAX_PLAYERS)

                if (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash0 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash1 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash2 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash3 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash4 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash6) then
                    set atLeastOne = true
                    if (not IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
                        call ForceAddPlayer(udg_ClanPlayers[clan], Player(i))
                    endif
                    set udg_ClanPlayerClan[i + 1] = clan
                    call SetPlayerTechResearchedIfHigher(Player(i), UPG_IMPROVED_CLAN_HALL, improvedClanHallLevel)
                    call SetPlayerTechResearchedIfHigher(Player(i), UPG_IMPROVED_CLAN, improvedClanLevel)
                endif

                if (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash0) then
                    set udg_ClanPlayerRank[i + 1] = playerRank0
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash1) then
                    set udg_ClanPlayerRank[i + 1] = playerRank1
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash2) then
                    set udg_ClanPlayerRank[i + 1] = playerRank2
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash3) then
                    set udg_ClanPlayerRank[i + 1] = playerRank3
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash4) then
                    set udg_ClanPlayerRank[i + 1] = playerRank4
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5) then
                    set udg_ClanPlayerRank[i + 1] = playerRank5
                elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash6) then
                    set udg_ClanPlayerRank[i + 1] = playerRank6
                endif
                set i = i + 1
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

            return atLeastOne
        else
            call DisplaySaveCodeError(whichPlayer, "You are not a member of this clan!")
        endif
    endif

    return false
endfunction

function GetSaveCodeStrong takes string playerName, boolean singlePlayer, boolean warlord returns string
    return GetSaveCodeEx(playerName, singlePlayer, warlord, udg_GameTypeNormal, 130, 1000, 50049900, 800000, 800000, 1000, 100, 100, 100, 100, 8000, 0, 20000, 0, 20000, 5000, 1000, 50049900, 1000, 50049900, 100, 2)
endfunction

function GetSaveCodeNormal takes string playerName, boolean singlePlayer, boolean warlord returns string
    return GetSaveCodeEx(playerName, singlePlayer, warlord, udg_GameTypeNormal, 130, 30, 50000, 100000, 100000, 20, 20, 20, 20, 20, 30, 0, 2000, 0, 800, 10, 30, 50000, 30, 50000, 20, 0)
endfunction

function ForGroupRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function GetSaveCodeBase takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allBuildings = CreateGroup()
    local string result
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'htow', GetRectCenterX(gg_rct_Save_Code_Town_Hall), GetRectCenterY(gg_rct_Save_Code_Town_Hall), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_1), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_1), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_2), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_2), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'halt', GetRectCenterX(gg_rct_Save_Code_Altar), GetRectCenterY(gg_rct_Save_Code_Altar), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hlum', GetRectCenterX(gg_rct_Save_Code_Lumber_Mill), GetRectCenterY(gg_rct_Save_Code_Lumber_Mill), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hvlt', GetRectCenterX(gg_rct_Save_Code_Arcane_Vault), GetRectCenterY(gg_rct_Save_Code_Arcane_Vault), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'harm', GetRectCenterX(gg_rct_Save_Code_Workshop), GetRectCenterY(gg_rct_Save_Code_Workshop), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hbar', GetRectCenterX(gg_rct_Save_Code_Barracks), GetRectCenterY(gg_rct_Save_Code_Barracks), bj_UNIT_FACING))

    set result = GetSaveCodeBuildingsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer, allBuildings)

    call ForGroupBJ(allBuildings, function ForGroupRemoveUnit)

    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function GetSaveCodeDragonUnits takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allDragons = CreateGroup()
    local group allDragonsDistinct
    local string result
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nrwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'ngrd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nadr', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbzd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nndr', whichPlayer, tmpLocation, 0.0), allDragons)

    set allDragonsDistinct = DistinctGroup(allDragons)

    set result = GetSaveCodeUnitsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer, allDragonsDistinct)

    call ForGroupBJ(allDragons, function ForGroupRemoveUnit)

    call GroupClear(allDragons)
    call DestroyGroup(allDragons)
    set allDragons = null

    call GroupClear(allDragonsDistinct)
    call DestroyGroup(allDragonsDistinct)
    set allDragonsDistinct = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function GetSaveCodeGoodItems takes string playerName, boolean singlePlayer, boolean warlord returns string
    local item item0 = CreateItem('gcel', 0.0, 0.0)
    local item item1 = CreateItem('pnvu', 0.0, 0.0)
    local item item2 = CreateItem('sres', 0.0, 0.0)
    local item item3 = CreateItem('ankh', 0.0, 0.0)
    local item item4 = CreateItem('whwd', 0.0, 0.0)
    local item item5 = CreateItem('hlst', 0.0, 0.0)
    local string result

    call SetItemCharges(item0, 100)
    call SetItemCharges(item1, 100)
    call SetItemCharges(item2, 100)
    call SetItemCharges(item3, 100)
    call SetItemCharges(item4, 100)
    call SetItemCharges(item5, 100)

    set result = GetSaveCodeItemsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, item0, item1, item2, item3, item4, item5)

    call RemoveItem(item0)
    set item0 = null

    call RemoveItem(item1)
    set item1 = null

    call RemoveItem(item2)
    set item2 = null

    call RemoveItem(item3)
    set item3 = null

    call RemoveItem(item4)
    set item4 = null

    call RemoveItem(item5)
    set item5 = null

    return result
endfunction

function GetSaveCodeHumanUpgrades takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local integer ironForgedSwordsLevel = GetPlayerTechCountSimple('Rhme', whichPlayer)
    local string result

    call SetPlayerTechResearched(whichPlayer, 'Rhme', 3)

    set result = GetSaveCodeResearchesEx(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer)

    call SetPlayerTechResearched(whichPlayer, 'Rhme', ironForgedSwordsLevel)

    return result
endfunction

function GetSaveCodeStrongClan takes boolean singlePlayer, string playerName returns string
    return GetSaveCodeClanEx(singlePlayer, "StrongClan", 'I04S', 100000, 100000, 100, 100, playerName, udg_ClanRankLeader, "Runeblade14#2451", udg_ClanRankCaptain, "Toasty", udg_ClanRankCaptain, "", 0, "", 0, "", 0, "", 0)
endfunction

function GenerateSaveCodes takes player whichPlayer returns nothing
    local integer playerNameSize = 2
    local string array playerName
    local integer singlePlayerSize = 2
    local boolean array singlePlayer
    local integer warlordSize = 2
    local boolean array warlord
    local integer i = 0
    local integer j = 0
    local integer k = 0
    set playerName[0] = "Barade#2569"
    set playerName[1] = "WorldEdit"
    set singlePlayer[0] = true
    set singlePlayer[1] = false
    set warlord[0] = true
    set warlord[1] = false
    set i = 0
    loop
        exitwhen (i >= playerNameSize)
        set j = 0
        loop
            exitwhen (j >= singlePlayerSize)
            set k = 0
            loop
                exitwhen (k >= warlordSize)
                call GetSaveCodeStrong(playerName[i], singlePlayer[j], warlord[k])
                call GetSaveCodeNormal(playerName[i], singlePlayer[j], warlord[k])
                call GetSaveCodeBase(whichPlayer, playerName[i], singlePlayer[j], warlord[k])
                call GetSaveCodeDragonUnits(whichPlayer, playerName[i], singlePlayer[j], warlord[k])
                call GetSaveCodeGoodItems(playerName[i], singlePlayer[j], warlord[k])
                call GetSaveCodeHumanUpgrades(whichPlayer, playerName[i], singlePlayer[j], warlord[k])
                set k = k  + 1
            endloop
            call GetSaveCodeStrongClan(singlePlayer[j], playerName[i])
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function CreateSaveCodeAutoTextFile takes string playerName, string saveCode, string saveCodeItems, string saveCodeUnits, string saveCodeResearches, string saveCodeBuildings returns nothing
    local string content = ""
    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Player: " + playerName)
    set content = content + AppendFileContent("-load " + saveCode)
    set content = content + AppendFileContent("-loadi " + saveCodeItems)
    set content = content + AppendFileContent("-loadu " + saveCodeUnits)
    set content = content + AppendFileContent("-loadr " + saveCodeResearches)
    set content = content + AppendFileContent("-loadb " + saveCodeBuildings)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-auto.txt")
endfunction

/**
 * Baradé's Backpack UI system.
 */

globals
    boolean array BackpackUIVisible
    framehandle array BackpackBackgroundFrame
    framehandle array BackpackTitleFrame
    framehandle array BackpackItemFrame
    framehandle array BackpackItemBackdropFrame
    framehandle array BackpackItemChargesFrame
    trigger array BackpackItemTrigger
    trigger array BackpackItemMouseDownTrigger
    trigger array BackpackItemMouseUpTrigger
    trigger array BackpackItemTooltipOnTrigger
    trigger array BackpackItemTooltipOffTrigger
    framehandle array BackpackTooltipFrame
    framehandle array BackpackItemGoldFrame
    framehandle array BackpackItemGoldIconFrame
    framehandle array BackpackTooltipText
    framehandle array BackpackCloseButton
    trigger array BackpackCloseTrigger
    constant real BACKPACK_UI_SIZE_X = 0.80
    constant real BACKPACK_UI_SIZE_Y = 0.42
    constant real BACKPACK_UI_BUTTON_SIZE = 0.02818
    constant real BACKPACK_UI_CHARGES_POS = 0.003
    constant real BACKPACK_UI_CHARGES_SIZE = 0.02
    constant real BACKPACK_UI_BUTTON_SPACE = 0.005
endglobals

function ShowBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    set BackpackUIVisible[GetPlayerId(whichPlayer)] = true
    call UpdateItemsForBackpackUI(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], true)
        call BlzFrameSetVisible(BackpackTitleFrame[GetPlayerId(whichPlayer)], true)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], true)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], true)
        set i = 0
        loop
            exitwhen (i == udg_RucksackMaxPages)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                call BlzFrameSetVisible(BackpackItemFrame[index], true)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], true)
                if (udg_RucksackItemType[index] != 0 and GetItemTypePerishable(udg_RucksackItemType[index])) then
                    call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                endif
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif
endfunction

function HideBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    set BackpackUIVisible[GetPlayerId(whichPlayer)] = false
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], false)
        call BlzFrameSetVisible(BackpackTitleFrame[GetPlayerId(whichPlayer)], false)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], false)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], false)
        set i = 0
        loop
            exitwhen (i == udg_RucksackMaxPages)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                call BlzFrameSetVisible(BackpackItemFrame[index], false)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif
endfunction

function BackpackClickItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    local integer bag = LoadTriggerParameterInteger(GetTriggeringTrigger(), 2)
    local integer slot = LoadTriggerParameterInteger(GetTriggeringTrigger(), 3)
    //call BJDebugMsg("Clicking on item " + I2S(index))

    call ChangeRucksackPageEx(playerId, bag)
endfunction

function BackpackMouseDownItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
endfunction

function BackpackMouseUpItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)

    if (BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT) then
        // https://www.hiveworkshop.com/threads/how-to-fake-the-cursor-dragging-an-item.337534/
        // TODO Create a fake drag cursor.
    endif
endfunction

function GetItemTypeTooltip takes integer itemTypeId returns string
    local item tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
    local string tooltip = BlzGetItemTooltip(tmpItem)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return tooltip
endfunction

function GetItemTypeExtendedTooltip takes integer itemTypeId returns string
    local item tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
    local string tooltip = BlzGetItemExtendedTooltip(tmpItem)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return tooltip
endfunction

function BackpackEnterItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    local integer bag = LoadTriggerParameterInteger(GetTriggeringTrigger(), 2)
    local integer slot = LoadTriggerParameterInteger(GetTriggeringTrigger(), 3)
    local string tooltip = "Empty slot " + I2S(slot + 1) + " at bag " + I2S(bag + 1) + "."
    //call BJDebugMsg("Entering item " + I2S(index))

    if (udg_RucksackItemType[index] != 0) then
        if (udg_RucksackItemPawnable[index]) then
            set tooltip = GetObjectName(udg_RucksackItemType[index]) + "|n"

            if (GetItemValueGold(udg_RucksackItemType[index]) > 0) then
                set tooltip = tooltip + "|cffFCD20D" + I2S(GetItemValueGold(udg_RucksackItemType[index])) + " Gold|r"
            endif

            if (GetItemValueLumber(udg_RucksackItemType[index]) > 0) then
                if (GetItemValueGold(udg_RucksackItemType[index]) > 0) then
                    set tooltip = tooltip + " "
                endif

                set tooltip = tooltip + "|cffFCD20D" + I2S(GetItemValueLumber(udg_RucksackItemType[index])) + " Lumber|r"
            endif

            set tooltip = tooltip + "|n|cff808080Drop item on shop to sell|R|n" + GetItemTypeExtendedTooltip(udg_RucksackItemType[index])
        else
            set tooltip = GetObjectName(udg_RucksackItemType[index]) + "|n|n" + GetItemTypeExtendedTooltip(udg_RucksackItemType[index])
        endif
    endif

    set tooltip = tooltip + "|n|cff808080Click to open the bag.|R|n"

    call BlzFrameSetText(BackpackTooltipText[playerId], tooltip)
endfunction

function BackpackLeaveItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    //call BJDebugMsg("Leave item " + I2S(index))
    call BlzFrameSetText(BackpackTooltipText[playerId], "")
endfunction

function BackpackCloseFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    call HideBackpackUI(Player(playerId))
endfunction

function CreateBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local real x = 0.0
    local real y = 0.0
    local integer index = 0

    set BackpackBackgroundFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0)
    call BlzFrameSetAbsPoint(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.57)
    call BlzFrameSetAbsPoint(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.57 - BACKPACK_UI_SIZE_Y)

    set BackpackTitleFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "BackpackTitle" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(BackpackTitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.54)
    call BlzFrameSetAbsPoint(BackpackTitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.54 - 0.1)
    call BlzFrameSetText(BackpackTitleFrame[GetPlayerId(whichPlayer)], "Backpack")
    call BlzFrameSetTextAlignment(BackpackTitleFrame[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(BackpackTitleFrame[GetPlayerId(whichPlayer)], 1.0)
    call BlzFrameSetVisible(BackpackTitleFrame[GetPlayerId(whichPlayer)], false)

    set x = 0.03
    set y = 0.53
    set i = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            set BackpackItemFrame[index] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_BOTTOMRIGHT, x + BACKPACK_UI_BUTTON_SIZE, y - BACKPACK_UI_BUTTON_SIZE)
            //call BlzFrameSetTexture(BackpackItemFrame[index], GetIconByItemType(0), 0, true)
            //call BlzFrameSetText(BackpackItemFrame[index], I2S(index))
            call BlzFrameSetScale(BackpackItemFrame[index], 1.00)
            call BlzFrameSetVisible(BackpackItemFrame[index], false)

            set BackpackItemBackdropFrame[index] = BlzCreateFrameByType("BACKDROP", "BackdropFrame" + I2S(index), BackpackItemFrame[index], "", 1)
            call BlzFrameSetAllPoints(BackpackItemBackdropFrame[index], BackpackItemFrame[index])
//             call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
            call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)

            set BackpackItemTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTrigger[index], BackpackItemFrame[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(BackpackItemTrigger[index], function BackpackClickItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 0, GetPlayerId(whichPlayer))
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 3, j)

            set BackpackItemMouseDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemMouseDownTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_DOWN)
            call TriggerAddAction(BackpackItemMouseDownTrigger[index], function BackpackMouseDownItemFunction)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 0, GetPlayerId(whichPlayer))
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 3, j)

            set BackpackItemMouseUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemMouseUpTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_UP)
            call TriggerAddAction(BackpackItemMouseUpTrigger[index], function BackpackMouseUpItemFunction)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 0, GetPlayerId(whichPlayer))
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 3, j)

            set BackpackItemTooltipOnTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOnTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_ENTER)
            call TriggerAddAction(BackpackItemTooltipOnTrigger[index], function BackpackEnterItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 0, GetPlayerId(whichPlayer))
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 3, j)

            set BackpackItemTooltipOffTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOffTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_LEAVE)
            call TriggerAddAction(BackpackItemTooltipOffTrigger[index], function BackpackLeaveItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTooltipOffTrigger[index], 0, GetPlayerId(whichPlayer))
            call SaveTriggerParameterInteger(BackpackItemTooltipOffTrigger[index], 1, index)

            // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.

            set BackpackItemChargesFrame[index] = BlzCreateFrameByType("TEXT", "charges" + I2S(index), BackpackItemFrame[index], "", 0)
            call BlzFrameSetAllPoints(BackpackItemChargesFrame[index], BackpackItemFrame[index])
            call BlzFrameSetText(BackpackItemChargesFrame[index], "|cffFFFFFFCharges|r")
            call BlzFrameSetTextAlignment(BackpackItemChargesFrame[index], TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)
            call BlzFrameSetScale(BackpackItemChargesFrame[index], 1.0)
            call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            call BlzFrameSetEnable(BackpackItemChargesFrame[index], false)

            set x = x + BACKPACK_UI_BUTTON_SIZE + BACKPACK_UI_BUTTON_SPACE

            set j = j + 1
        endloop

        set i = i + 1

        // every 3 bags start another line
        if (ModuloInteger(i, 3) == 0) then
            set x = 0.03
            set y = y - BACKPACK_UI_BUTTON_SIZE - BACKPACK_UI_BUTTON_SPACE
        endif
    endloop


    set BackpackTooltipFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BackpackBackgroundFrame[GetPlayerId(whichPlayer)],0,0)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.62, 0.54)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, 0.78, 0.20)

    set BackpackItemGoldFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.65, 0.50)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, 0.67, 0.48)
    //call BlzFrameSetAllPoints(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], BackpackBackgroundFrame[GetPlayerId(whichPlayer)])
    call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], false)

    set BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("BACKDROP", "BackdropFrameGoldIcon" + I2S(GetPlayerId(whichPlayer)), BackpackItemGoldFrame[GetPlayerId(whichPlayer)], "", 1)
    call BlzFrameSetAllPoints(BackpackItemGoldIconFrame[index], BackpackItemGoldFrame[index])
    call BlzFrameSetTexture(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], false)

    set BackpackTooltipText[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "BackpackTooltipText" + I2S(GetPlayerId(whichPlayer)),  BackpackBackgroundFrame[GetPlayerId(whichPlayer)], "", 0)
    call BlzFrameSetAbsPoint(BackpackTooltipText[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.65, 0.505800)
    call BlzFrameSetAbsPoint(BackpackTooltipText[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, 0.74, 0.236500)
    call BlzFrameSetText(BackpackTooltipText[GetPlayerId(whichPlayer)], "")
    call BlzFrameSetEnable(BackpackTooltipText[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(BackpackTooltipText[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(BackpackTooltipText[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    //call BlzFrameSetTooltip(Frame05, BackpackTooltipText[GetPlayerId(whichPlayer)])

    set BackpackCloseButton[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BackpackBackgroundFrame[GetPlayerId(whichPlayer)], 0, 0)
    set x = 0.34
    set y = 0.202
    call BlzFrameSetAbsPoint(BackpackCloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(BackpackCloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(BackpackCloseButton[GetPlayerId(whichPlayer)], "|cffFCD20DClose|r")
    call BlzFrameSetScale(BackpackCloseButton[GetPlayerId(whichPlayer)], 1.00)

    set BackpackCloseTrigger[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BackpackCloseTrigger[GetPlayerId(whichPlayer)], BackpackCloseButton[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BackpackCloseTrigger[GetPlayerId(whichPlayer)], function BackpackCloseFunction)
    call SaveTriggerParameterInteger(BackpackCloseTrigger[GetPlayerId(whichPlayer)], 0, GetPlayerId(whichPlayer))

    call BlzFrameSetVisible(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], false)
endfunction

/**
 * Savecode GUI which helps to copy & paste savecodes.
 */
globals
    constant real SAVECODE_UI_LABEL_X = 0.055
    constant real SAVECODE_UI_LABEL_WIDTH = 0.058018

    constant real SAVECODE_UI_LINEEDIT_X = SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH + 0.01
    constant real SAVECODE_UI_LINEEDIT_WIDTH = 0.35

    constant real SAVECODE_UI_UPDATE_BUTTON_X = 0.47837
    constant real SAVECODE_UI_UPDATE_BUTTON_WIDTH = 0.060

    constant real SAVECODE_UI_LOAD_BUTTON_X = 0.54136
    constant real SAVECODE_UI_LOAD_BUTTON_WIDTH = 0.060

    constant real SAVECODE_UI_LOAD_AUTO_BUTTON_X = 0.3
    constant real SAVECODE_UI_LOAD_AUTO_BUTTON_WIDTH = 0.066

    constant real SAVECODE_UI_WRITE_AUTO_BUTTON_X = 0.4
    constant real SAVECODE_UI_WRITE_AUTO_BUTTON_WIDTH = 0.066

    constant real SAVECODE_UI_LINE_START_Y = 0.528122
    constant real SAVECODE_UI_LINE_HEIGHT = 0.03
    constant real SAVECODE_UI_LINE_SPACING = 0.02

    constant real SAVECODE_UI_TOOLTIP_X = 0.61
    constant real SAVECODE_UI_TOOLTIP_WIDTH = 0.17
    constant real SAVECODE_UI_TOOLTIP_HEIGHT = 0.34

    constant real SAVECODE_UI_TOOLTIP_LABEL_X = 0.64
    constant real SAVECODE_UI_TOOLTIP_LABEL_Y = 0.49
    constant real SAVECODE_UI_TOOLTIP_LABEL_WIDTH = 0.10
    constant real SAVECODE_UI_TOOLTIP_LABEL_HEIGHT = 0.32

    framehandle array SaveCodeUIBackgroundFrame
    framehandle array SaveCodeUITitleFrame

    framehandle array SaveCodeUITooltipBackgroundFrame
    framehandle array SaveCodeUITooltipLabelFrame

    // line 1: heroes savecode
    framehandle array SaveCodeUILabelFrameHeroes
    framehandle array SaveCodeUIEditBoxHeroes
    trigger array SaveCodeUITriggerEditBoxHeroes
    framehandle array SaveCodeUIUpdateButtonFrameHeroes
    trigger array SaveCodeUIUpdateTriggerHeroes
    framehandle array SaveCodeUILoadButtonFrameHeroes
    trigger array SaveCodeUILoadTriggerHeroes
    trigger array SaveCodeUIEnterTriggerHeroes

    // line 2: items savecode
    framehandle array SaveCodeUILabelFrameItems
    framehandle array SaveCodeUIEditBoxItems
    trigger array SaveCodeUITriggerEditBoxItems
    framehandle array SaveCodeUIUpdateButtonFrameItems
    trigger array SaveCodeUIUpdateTriggerItems
    framehandle array SaveCodeUILoadButtonFrameItems
    trigger array SaveCodeUILoadTriggerItems
    trigger array SaveCodeUIEnterTriggerItems

    // line 3: units savecode
    framehandle array SaveCodeUILabelFrameUnits
    framehandle array SaveCodeUIEditBoxUnits
    trigger array SaveCodeUITriggerEditBoxUnits
    framehandle array SaveCodeUIUpdateButtonFrameUnits
    trigger array SaveCodeUIUpdateTriggerUnits
    framehandle array SaveCodeUILoadButtonFrameUnits
    trigger array SaveCodeUILoadTriggerUnits
    trigger array SaveCodeUIEnterTriggerUnits

    // line 4: researches savecode
    framehandle array SaveCodeUILabelFrameResearches
    framehandle array SaveCodeUIEditBoxResearches
    trigger array SaveCodeUITriggerEditBoxResearches
    framehandle array SaveCodeUIUpdateButtonFrameResearches
    trigger array SaveCodeUIUpdateTriggerResearches
    framehandle array SaveCodeUILoadButtonFrameResearches
    trigger array SaveCodeUILoadTriggerResearches
    trigger array SaveCodeUIEnterTriggerResearches

    // line 5: buildings savecode
    framehandle array SaveCodeUILabelFrameBuildings
    framehandle array SaveCodeUIEditBoxBuildings
    trigger array SaveCodeUITriggerEditBoxBuildings
    framehandle array SaveCodeUIUpdateButtonFrameBuildings
    trigger array SaveCodeUIUpdateTriggerBuildings
    framehandle array SaveCodeUILoadButtonFrameBuildings
    trigger array SaveCodeUILoadTriggerBuildings
    trigger array SaveCodeUIEnterTriggerBuildings

    // end line: all save codes
    framehandle array SaveCodeUILabelFrameAll
    framehandle array SaveCodeUIWriteAutoButtonFrameAll
    trigger array SaveCodeUIWriteAutoTriggerAll
    framehandle array SaveCodeUILoadAutoButtonFrameAll
    trigger array SaveCodeUILoadAutoTriggerAll
    framehandle array SaveCodeUIUpdateButtonFrameAll
    trigger array SaveCodeUIUpdateTriggerAll
    framehandle array SaveCodeUILoadButtonFrameAll
    trigger array SaveCodeUILoadTriggerAll

    framehandle array SaveCodeUICloseButton
    trigger array SaveCodeUICloseTrigger
endglobals

function StringStartsWith takes string source, string start returns boolean
    local integer i = 0
    loop
        exitwhen (i == StringLength(start) or i >= StringLength(source))

        if (SubString(source, i, i + 1) != SubString(start, i, i + 1)) then
            return false
        endif

        set i = i + 1
    endloop

    return i == StringLength(start)
endfunction

function StringRemoveFromStart takes string source, string start returns string
    if (StringStartsWith(source, start)) then
        return SubString(source, StringLength(start), StringLength(source))
    endif

    return source
endfunction

function SetSaveCodeUITooltip takes player whichPlayer, string tooltip returns nothing
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], tooltip)
endfunction

function FormattedSaveCodeHeroes takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-load ")) then
        return StringRemoveFromStart(saveCode, "-load ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIHeroesText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIHeroesText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIHeroesText takes player whichPlayer returns nothing
    call SetSaveCodeUIHeroesText(whichPlayer, "-load " + GetSaveCode(whichPlayer))
endfunction

function SetSaveCodeUITooltipHeroesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeHeroes(GetSaveCodeUIHeroesText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Heroes:|n" + GetSaveCodeInfos(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeItems takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadi ")) then
        return StringRemoveFromStart(saveCode, "-loadi ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIItemsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIItemsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIItemsText takes player whichPlayer returns nothing
    call SetSaveCodeUIItemsText(whichPlayer, "-loadi " + GetSaveCodeItems(whichPlayer))
endfunction

function SetSaveCodeUITooltipItemsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeItems(GetSaveCodeUIItemsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Items:|n" + GetSaveCodeInfosItems(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeUnits takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadu ")) then
        return StringRemoveFromStart(saveCode, "-loadu ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIUnitsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIUnitsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIUnitsText takes player whichPlayer returns nothing
    call SetSaveCodeUIUnitsText(whichPlayer, "-loadu " + GetSaveCodeUnits(whichPlayer))
endfunction

function SetSaveCodeUITooltipUnitsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeUnits(GetSaveCodeUIUnitsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Units:|n" + GetSaveCodeInfosUnits(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeResearches takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadr ")) then
        return StringRemoveFromStart(saveCode, "-loadr ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIResearchesText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIResearchesText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIResearchesText takes player whichPlayer returns nothing
    call SetSaveCodeUIResearchesText(whichPlayer, "-loadr " + GetSaveCodeResearches(whichPlayer))
endfunction

function SetSaveCodeUITooltipResearchesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResearches(GetSaveCodeUIResearchesText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Researches:|n" + GetSaveCodeInfosResearches(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeBuildings takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadb ")) then
        return StringRemoveFromStart(saveCode, "-loadb ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIBuildingsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIBuildingsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIBuildingsText takes player whichPlayer returns nothing
    call SetSaveCodeUIBuildingsText(whichPlayer, "-loadb " + GetSaveCodeBuildings(whichPlayer))
endfunction

function SetSaveCodeUITooltipBuildingsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeBuildings(GetSaveCodeUIBuildingsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Buildings:|n" + GetSaveCodeInfosBuildings(whichPlayer, saveCode))
endfunction

function SaveCodeUIUpdateAll takes player whichPlayer returns nothing
    call UpdateSaveCodeUIHeroesText(whichPlayer)
    call UpdateSaveCodeUIItemsText(whichPlayer)
    call UpdateSaveCodeUIUnitsText(whichPlayer)
    call UpdateSaveCodeUIResearchesText(whichPlayer)
    call UpdateSaveCodeUIBuildingsText(whichPlayer)
endfunction

function SetSaveCodeUIVisible takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], visible)
        // heroes
        call BlzFrameSetVisible(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], visible)
        // items
        call BlzFrameSetVisible(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], visible)
        // units
        call BlzFrameSetVisible(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], visible)
        // researches
        call BlzFrameSetVisible(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], visible)
        // buildings
        call BlzFrameSetVisible(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], visible)
        // all
        call BlzFrameSetVisible(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], visible)
        //call BlzFrameSetVisible(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        //call BlzFrameSetVisible(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        // close
        call BlzFrameSetVisible(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], visible)
    endif

    if (visible) then
        call SaveCodeUIUpdateAll(whichPlayer)
    endif
endfunction

function ShowSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, true)
endfunction

function HideSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, false)
endfunction

function SaveCodeUIEditBoxEnterHeroes takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipHeroesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionHeroes takes nothing returns nothing
    call SaveCodeUIEditBoxEnterHeroes(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionHeroes takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateSaveCodeUIHeroesText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for heroes.")
endfunction

function SaveCodeUILoadHeroes takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeHeroes(GetSaveCodeUIHeroesText(whichPlayer))
    //call BJDebugMsg("Click load heroes")

    // TODO Check and Apply cooldowns!
    if (ApplySaveCode(whichPlayer, saveCode)) then
        call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
    else
        call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: "  + ColoredSaveCode(saveCode))
    endif
endfunction

function SaveCodeUILoadFunctionHeroes takes nothing returns nothing
    call SaveCodeUILoadHeroes(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterItems takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipItemsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionItems takes nothing returns nothing
    call SaveCodeUIEditBoxEnterItems(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionItems takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateSaveCodeUIItemsText(GetTriggerPlayer())
    call SetSaveCodeUITooltip(GetTriggerPlayer(), "Updated savecode for items.")
endfunction

function SaveCodeUILoadItems takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeItems(GetSaveCodeUIItemsText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeItems(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load item savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionItems takes nothing returns nothing
    call SaveCodeUILoadItems(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterUnits takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipUnitsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionUnits takes nothing returns nothing
    call SaveCodeUIEditBoxEnterUnits(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionUnits takes nothing returns nothing
    //call BJDebugMsg("Click update units")
    call UpdateSaveCodeUIUnitsText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for units.")
endfunction

function SaveCodeUILoadUnits takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeUnits(GetSaveCodeUIUnitsText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeUnits(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load unit savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionUnits takes nothing returns nothing
    call SaveCodeUILoadUnits(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterResearches takes player whichPlayer returns nothing
     call SetSaveCodeUITooltipResearchesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeUIEnterFunctionResearches takes nothing returns nothing
    call SaveCodeUIEditBoxEnterResearches(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionResearches takes nothing returns nothing
    //call BJDebugMsg("Click update researches")
    call UpdateSaveCodeUIResearchesText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for researches.")
endfunction

function SaveCodeUILoadResearches takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResearches(GetSaveCodeUIResearchesText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeResearches(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load research savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionResearches takes nothing returns nothing
    call SaveCodeUILoadResearches(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterBuildings takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipBuildingsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionBuildings takes nothing returns nothing
    call SaveCodeUIEditBoxEnterBuildings(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionBuildings takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateSaveCodeUIBuildingsText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for buildings.")
endfunction

function SaveCodeUILoadBuildings takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeBuildings(GetSaveCodeUIBuildingsText(whichPlayer))
    //call BJDebugMsg("Click load buildings")

    if (TimerGetRemaining(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeBuildings(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load building savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionBuildings takes nothing returns nothing
    call SaveCodeUILoadBuildings(GetTriggerPlayer())
endfunction

function SaveCodeUILoadAutoFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click load auto")
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Tried to load auto savecodes.")
endfunction

function SaveCodeUIWriteAutoFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click write auto")
    call CreateSaveCodeAutoTextFile(GetPlayerName(GetTriggerPlayer()), GetSaveCode(GetTriggerPlayer()), GetSaveCodeItems(GetTriggerPlayer()), GetSaveCodeUnits(GetTriggerPlayer()), GetSaveCodeResearches(GetTriggerPlayer()), GetSaveCodeBuildings(GetTriggerPlayer()))

    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Tried to save auto savecodes.")
endfunction

function SaveCodeUIUpdateFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click update all")
    call SaveCodeUIUpdateAll(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated all savecodes.")
endfunction

function SaveCodeUILoadFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click load all")
    call SaveCodeUILoadHeroes(GetTriggerPlayer())
    call SaveCodeUILoadItems(GetTriggerPlayer())
    call SaveCodeUILoadUnits(GetTriggerPlayer())
    call SaveCodeUILoadResearches(GetTriggerPlayer())
    call SaveCodeUILoadBuildings(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Tried to load all savecodes.")
endfunction

function SaveCodeUICloseFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    //call BJDebugMsg("Click close")
    call HideSaveCodeUI(Player(playerId))
endfunction

function CreateSaveCodeUI takes player whichPlayer returns nothing
    local real x
    local real y

    call BlzLoadTOCFile("war3mapImported\\saveguiTOC.toc")

    set SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.57)
    call BlzFrameSetAbsPoint(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.57 - BACKPACK_UI_SIZE_Y)

    set SaveCodeUITitleFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiTitle" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.54)
    call BlzFrameSetAbsPoint(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.54 - 0.1)
    call BlzFrameSetText(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], "Save Codes")
    call BlzFrameSetTextAlignment(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], 1.0)
    call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], false)

    set SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_TOOLTIP_X, SAVECODE_UI_LINE_START_Y)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_TOOLTIP_X + SAVECODE_UI_TOOLTIP_WIDTH, SAVECODE_UI_LINE_START_Y - SAVECODE_UI_TOOLTIP_HEIGHT)

    set SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiTooltipLabel" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_TOOLTIP_LABEL_X, SAVECODE_UI_TOOLTIP_LABEL_Y)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_TOOLTIP_LABEL_X + SAVECODE_UI_TOOLTIP_LABEL_WIDTH, SAVECODE_UI_TOOLTIP_LABEL_Y - SAVECODE_UI_TOOLTIP_LABEL_HEIGHT)
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], "Save Code Info")
    call BlzFrameSetEnable(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    // line 1: heroes
    set y = SAVECODE_UI_LINE_START_Y

    set SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelHeroes" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], "|cffFFCC00Heroes:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionHeroes)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionHeroes)

    set SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionHeroes)

    set SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionHeroes)

    // line 2: items
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelItems" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], "|cffFFCC00Items:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionItems)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionItems)

    set SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionItems)

    set SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionItems)

    // line 3: units
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelUnits" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], "|cffFFCC00Units:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionUnits)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionUnits)

    set SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionUnits)

    set SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionUnits)

    // line 4: researches
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelResearches" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], "|cffFFCC00Researches:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)], function SaveCodeUIEnterFunctionResearches)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUIEnterFunctionResearches)

    set SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionResearches)

    set SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionResearches)

    // line 4: buildings
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelBuildings" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], "|cffFFCC00Buildings:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionBuildings)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionBuildings)

    set SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionBuildings)

    set SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionBuildings)


    // final line: all
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelAll" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], "|cffFFCC00All:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], true)

    //set SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    //call BlzFrameSetAbsPoint(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_AUTO_BUTTON_X, y)
    //call BlzFrameSetAbsPoint(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_AUTO_BUTTON_X + SAVECODE_UI_LOAD_AUTO_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    //call BlzFrameSetText(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DLoad Auto|r")
    //call BlzFrameSetScale(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    //set SaveCodeUILoadAutoTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    //call BlzTriggerRegisterFrameEvent(SaveCodeUILoadAutoTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    //call TriggerAddAction(SaveCodeUILoadAutoTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUILoadAutoFunctionAll)

    //set SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    //call BlzFrameSetAbsPoint(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_WRITE_AUTO_BUTTON_X, y)
    //call BlzFrameSetAbsPoint(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_WRITE_AUTO_BUTTON_X + SAVECODE_UI_WRITE_AUTO_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    //call BlzFrameSetText(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DWrite Auto|r")
    //call BlzFrameSetScale(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    //set SaveCodeUIWriteAutoTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    //call BlzTriggerRegisterFrameEvent(SaveCodeUIWriteAutoTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    //call TriggerAddAction(SaveCodeUIWriteAutoTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUIWriteAutoFunctionAll)

    set SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionAll)

    set SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionAll)

    // close button


    //eventHandler = CreateTrigger() --Create the FRAMEEVENT_EDITBOX_TEXT_CHANGED trigger
    //TriggerAddAction(eventHandler, TEXT_CHANGED)
    //BlzTriggerRegisterFrameEvent(eventHandler, editbox, FRAMEEVENT_EDITBOX_TEXT_CHANGED)

    set SaveCodeUICloseButton[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    set x = 0.34
    set y = 0.22
    call BlzFrameSetAbsPoint(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], "|cffFCD20DClose|r")
    call BlzFrameSetScale(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], function SaveCodeUICloseFunction)
    call SaveTriggerParameterInteger(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], 0, GetPlayerId(whichPlayer))

    call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], false)
    // heroes
    call BlzFrameSetVisible(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], false)
    // items
    call BlzFrameSetVisible(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], false)
    // units
    call BlzFrameSetVisible(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], false)
    // researches
    call BlzFrameSetVisible(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], false)
    // buildings
    call BlzFrameSetVisible(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], false)
    // all
    call BlzFrameSetVisible(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIWriteAutoButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadAutoButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], false)
    // close
    call BlzFrameSetVisible(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], false)
endfunction

function ShowTextTagForForce takes force whichForce, texttag textTag, boolean show returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        call SetTextTagVisibility(textTag, true)
    endif
endfunction

function ShowFadingTextTagForForce takes force whichForce, string text, real size, real x, real y, integer red, integer green, integer blue, integer alpha, real velocity, real fadepoint, real lifespan returns nothing
    local player localPlayer
    local texttag textTag = CreateTextTag()
    call SetTextTagText(textTag, text, size)
    call SetTextTagPos(textTag, x, y, 0.0)
    call SetTextTagColor(textTag, red, green, blue, alpha)
    call SetTextTagVelocity(textTag, 0.0, velocity)
    if (whichForce == null) then
        call SetTextTagVisibility(textTag, true)
    else
        call ShowTextTagForForce(whichForce, textTag, true)
    endif
    call SetTextTagFadepoint(textTag, fadepoint)
    call SetTextTagLifespan(textTag, lifespan)
    call SetTextTagPermanent(textTag, false)
    set textTag = null
endfunction

function ShowGeneralFadingTextTagForForce takes force whichForce, string text, real x, real y, integer red, integer green, integer blue, integer alpha returns nothing
    call ShowFadingTextTagForForce(whichForce, text, 0.025, x, y, red, green, blue, alpha, 0.03, 1.0, 2.0)
endfunction

function ShowGoldTextTagForForce takes force whichForce, real x, real y, integer gold returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(gold), 0.025, x, y, 255, 220, 0, 255, 0.03, 1.0, 2.0)
endfunction

function ShowLumberTextTagForForce takes force whichForce, real x, real y, integer lumber returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(lumber), 0.025, x, y, 0, 200, 80, 255, 0.03, 1.0, 2.0)
endfunction

function ShowBountyTextTagForForce takes force whichForce, real x, real y, integer bounty returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(bounty), 0.025, x, y, 255, 220, 0, 255, 0.03, 2.0, 3.0)
endfunction

function ShowMissTextTagForForce takes force whichForce, real x, real y returns nothing
    call ShowFadingTextTagForForce(whichForce, GetLocalizedString("MISS") + "!", 0.025, x, y, 255, 0, 0, 255, 0.03, 1.0, 3.0)
endfunction

function ShowCriticalStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowShadowStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 160, 255, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowManaBurnTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, "-" + I2S(damage), 0.025, x, y, 82, 82, 255, 255, 0.04, 2.0, 5.0)
endfunction

function ShowBashTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function Bounty takes force whichForce, real x, real y, integer bounty returns nothing
    local string effectPath = ""
    local effect whichEffect
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), whichForce)) then
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + bounty)
        endif
        set i = i + 1
    endloop
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        set effectPath = "UI\\Feedback\\GoldCredit\\GoldCredit.mdl"
    endif
    set whichEffect = AddSpecialEffect(effectPath, x, y)
    call DestroyEffect(whichEffect)
    set whichEffect = null
    call ShowBountyTextTagForForce(whichForce, x, y, bounty)
endfunction

function RandomizeString takes string source returns string
    local string result = ""
    local integer sourcePosition = 0
    loop
        exitwhen (StringLength(source) == 0)
        set sourcePosition = GetRandomInt(0, StringLength(source) - 1)
        set result = result + SubString(source, sourcePosition, sourcePosition + 1)
        set source = SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, StringLength(source))
    endloop

    return result
endfunction

globals
    constant integer GOBLIN_TUNNEL_DIRECTION_NORTH = 0
    constant integer GOBLIN_TUNNEL_DIRECTION_SOUTH = 1
    constant integer GOBLIN_TUNNEL_DIRECTION_WEST = 2
    constant integer GOBLIN_TUNNEL_DIRECTION_EAST = 3
    constant integer GOBLIN_TUNNEL_DIRECTION_PREVIOUS = 4
    constant integer GOBLIN_TUNNEL_DIRECTION_NORTH_START = 5
    constant integer GOBLIN_TUNNEL_DIRECTION_SOUTH_START = 6
    constant integer GOBLIN_TUNNEL_DIRECTION_WEST_START = 7
    constant integer GOBLIN_TUNNEL_DIRECTION_EAST_START = 8

    constant integer GOBLIN_TUNNEL_SYSTEM = 'o018'
    constant integer GOBLIN_TUNNEL = 'o00P'
    constant real GOBLIN_TUNNEL_EXPAND_DISTANCE = 100.0

    constant integer GOBLIN_TUNNEL_START_ABILITY_ID = 'A0CS'
    constant integer GOBLIN_TUNNEL_END_ABILITY_ID = 'A0CT'
endglobals

function GetAngleByGoblinTunnelDirection takes integer direction returns real
    if (direction == GOBLIN_TUNNEL_DIRECTION_NORTH) then
        return 90.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_SOUTH) then
        return 270.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_WEST) then
        return 180.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_EAST) then
        return 0.0
    endif

    return 0.0
endfunction

function SetNextGoblinTunnelPart takes unit whichUnit, integer direction, unit part returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction, part)
endfunction

function GetNextGoblinTunnelPart takes unit whichUnit, integer direction returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction)
endfunction

function SetPreviousGoblinTunnelPart takes unit whichUnit, unit part returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_PREVIOUS, part)
endfunction

function GetPreviousGoblinTunnelPart takes unit whichUnit returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_PREVIOUS)
endfunction

function GetGoblinTunnelSystem takes unit whichUnit returns unit
    local unit tmpUnit = whichUnit
    loop
        set tmpUnit = GetPreviousGoblinTunnelPart(whichUnit)
        exitwhen (tmpUnit == null)
        set whichUnit = tmpUnit
    endloop

    if (GetUnitTypeId(whichUnit) == GOBLIN_TUNNEL_SYSTEM) then
        return whichUnit
    endif

    return null
endfunction

function SetGoblinTunnelSystemStart takes unit whichUnit, integer direction, unit start returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction + GOBLIN_TUNNEL_DIRECTION_PREVIOUS + 1, start)
endfunction

function GetGoblinTunnelSystemStart takes unit whichUnit, integer direction returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction + GOBLIN_TUNNEL_DIRECTION_PREVIOUS + 1)
endfunction

function FilterFunctionIsLivingGoblinTunnel takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'o00P' and IsUnitAliveBJ(GetFilterUnit())
endfunction


function GetNextGoblinTunnelEx takes unit start, integer direction, group allConnected, integer recursionLevel returns unit
    local unit next = GetNextGoblinTunnelPart(start, direction)

    if (next != null) then
        if (allConnected != null) then
            call GroupAddUnit(allConnected, next)
        endif

        return GetNextGoblinTunnelEx(next, direction, allConnected, recursionLevel + 1)
    else
        //call BJDebugMsg("Return start")

        return start
    endif
endfunction

function GetNextGoblinTunnel takes unit start, integer direction returns unit
    local unit next = GetNextGoblinTunnelEx(start, direction, null, 0)

    if (next != null) then
        return next
    else
        //call BJDebugMsg("Return start")

        return start
    endif
endfunction

function PolarProjectionX takes real x, real angle, real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function PolarProjectionY takes real y, real angle, real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function ExpandGoblinTunnel takes unit start, integer direction returns unit
    local real angle = GetAngleByGoblinTunnelDirection(direction)
    local unit previous = GetNextGoblinTunnel(start, direction)
    local unit expanded = null
    local unit system = null
    if (previous != null and GetNextGoblinTunnelPart(previous, direction) == null) then
        set expanded = CreateUnit(GetOwningPlayer(start), GOBLIN_TUNNEL, PolarProjectionX(GetUnitX(previous), angle, GOBLIN_TUNNEL_EXPAND_DISTANCE), PolarProjectionY(GetUnitY(previous), angle, GOBLIN_TUNNEL_EXPAND_DISTANCE), bj_UNIT_FACING)
        call SetNextGoblinTunnelPart(previous, direction, expanded)
        call SetPreviousGoblinTunnelPart(expanded, previous)
        call GroupAddUnit(udg_GoblinTunnels, expanded)

        if (GetUnitTypeId(previous) == GOBLIN_TUNNEL_SYSTEM) then
            call SetGoblinTunnelSystemStart(previous, direction, expanded)
            call WaygateActivate(expanded, true)
            call WaygateSetDestination(expanded, GetUnitX(expanded), GetUnitY(expanded))
            call UnitAddAbility(expanded, GOBLIN_TUNNEL_START_ABILITY_ID)
        else
            call WaygateActivate(previous, false)
            call UnitRemoveAbility(previous, GOBLIN_TUNNEL_END_ABILITY_ID)

            set system = GetGoblinTunnelSystem(expanded)
            if (system != null) then
                set system = GetGoblinTunnelSystemStart(system, direction)
                if (system != null) then
                    call WaygateActivate(system, true)
                    call WaygateSetDestination(system, GetUnitX(expanded), GetUnitY(expanded))
                    call UnitAddAbility(expanded, GOBLIN_TUNNEL_END_ABILITY_ID)
                    call WaygateActivate(expanded, true)
                    call WaygateSetDestination(expanded, GetUnitX(system), GetUnitY(system))
                endif
            endif
        endif
    else
        call BJDebugMsg("Previous: " + GetUnitName(previous) + " and next existing part " + GetUnitName(GetNextGoblinTunnelPart(previous, direction)))
    endif

    return expanded
endfunction

function UpdateDeadGoblinTunnelPart takes unit whichUnit returns nothing
    local unit previous = GetPreviousGoblinTunnelPart(whichUnit)
    local unit next = null
    local integer i = 0
    loop
        exitwhen (i == GOBLIN_TUNNEL_DIRECTION_EAST + 1)
        set next = GetNextGoblinTunnelPart(whichUnit, i)
        if (next != null) then
            call SetPreviousGoblinTunnelPart(next, null)
        endif
        set i = i + 1
    endloop
    if (previous != null) then
        set i = 0
        loop
            exitwhen (i == GOBLIN_TUNNEL_DIRECTION_EAST + 1)
            set next = GetNextGoblinTunnelPart(previous, i)
            if (next == whichUnit) then
                call SetNextGoblinTunnelPart(previous, i, null)
                exitwhen (true)
            endif
            set i = i + 1
        endloop
    endif
endfunction

function GetAllConnectedGoblinTunnelParts takes unit start returns group
    local group result = CreateGroup()
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_NORTH, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_SOUTH, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_WEST, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_EAST, result, 0)

    return result
endfunction

function ForGroupFunctionKill takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function KillAllConnectedGoblinTunnelParts takes unit start returns nothing
    local group connected = GetAllConnectedGoblinTunnelParts(start)
    call ForGroup(connected, function ForGroupFunctionKill)
    call GroupClear(connected)
    call DestroyGroup(connected)
    set connected = null
endfunction

globals
    hashtable HeroAbilitiesHashTable = InitHashtable()
    hashtable HeroAbilitiesMaximumLevelHashTable = InitHashtable()
endglobals

function GetHeroAbilityMaximum takes integer unitTypeId returns integer
    return LoadInteger(HeroAbilitiesHashTable, unitTypeId, 0) + 1
endfunction

function GetHeroAbility takes integer unitTypeId, integer index returns integer
    return LoadInteger(HeroAbilitiesHashTable, unitTypeId, index)
endfunction

function GetHeroAbilityMaximumLevel takes integer unitTypeId, integer index returns integer
    return LoadInteger(HeroAbilitiesMaximumLevelHashTable, unitTypeId, index)
endfunction

function GetHeroAbilityIndex takes integer unitTypeId, integer abilityId returns integer
    local integer i = 1
    local integer max = GetHeroAbilityMaximum(unitTypeId)
    loop
        exitwhen (i >= max)
        if (GetHeroAbility(unitTypeId, i) == abilityId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function RegisterHeroAbilityEx takes integer unitTypeId, integer abilityId, integer maxLevel returns integer
    local integer maxIndex = GetHeroAbilityMaximum(unitTypeId)
    call SaveInteger(HeroAbilitiesHashTable, unitTypeId, 0, maxIndex)
    call SaveInteger(HeroAbilitiesHashTable, unitTypeId, maxIndex, abilityId)
    call SaveInteger(HeroAbilitiesMaximumLevelHashTable, unitTypeId, maxIndex, maxLevel)

    return maxIndex
endfunction

function RegisterHeroAbility takes nothing returns integer
    return RegisterHeroAbilityEx(udg_TmpUnitType, udg_TmpAbilityCode, udg_TmpInteger)
endfunction

function RemoveHeroAbility takes unit hero, integer abilityId returns boolean
    local integer level = GetUnitAbilityLevel(hero, abilityId)
    local integer skillPoints = GetHeroSkillPoints(hero)
    local integer index = GetHeroAbilityIndex(GetUnitTypeId(hero), abilityId)
    local integer diff = GetHeroAbilityMaximumLevel(GetUnitTypeId(hero), index) - level
    local integer i = 0
    if (index < 1) then
        call BJDebugMsg("Invalid ability index " + I2S(index) + " for hero ability " + GetObjectName(abilityId) + " for unit type " + GetObjectName(GetUnitTypeId(hero)))
    endif
    call BJDebugMsg("Removing hero ability " + GetObjectName(abilityId) + " by adding " + I2S(diff) + " skill points and skilling the ability to its max level which currently has level " + I2S(level) + " (readded as skill points) to remove it.")
    // TODO Do we need to increase the hero level as well for skip requirements? We will have to disable ALL triggers which react to a gain level event!
    if (diff > 0) then
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_ADD, diff)
        set i = 0
        loop
            exitwhen (i == diff)
            call SelectHeroSkill(hero, abilityId)
            set i = i + 1
        endloop
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_SET, skillPoints)
    endif

    // give all skill points back
    if (level > 0) then
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_ADD, level)
    endif

    return UnitRemoveAbility(hero, abilityId)
endfunction

function RemoveAllHeroAbilities takes unit hero returns nothing
    local integer max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
    local integer i = 1
    loop
        exitwhen (i >= max)
        call RemoveHeroAbility(hero, GetHeroAbility(GetUnitTypeId(hero), i))
        set i = i + 1
    endloop
endfunction

function AddAllHeroAbilities takes unit hero returns nothing
    local integer max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
    local integer i = 1
    loop
        exitwhen (i >= max)
        call BJDebugMsg("Adding hero ability " + GetObjectName(GetHeroAbility(GetUnitTypeId(hero), i)))
        if (GetUnitAbilityLevel(hero, GetHeroAbility(GetUnitTypeId(hero), i)) <= 0) then
            call UnitAddAbility(hero, GetHeroAbility(GetUnitTypeId(hero), i))
            call SetUnitAbilityLevel(hero, GetHeroAbility(GetUnitTypeId(hero), i), 0)
        endif
        set i = i + 1
    endloop
endfunction

function AutoSkillHero takes unit hero returns integer
    local integer level = GetHeroLevel(hero)
    local integer skillPoints = GetHeroSkillPoints(hero)
    local integer start = level - skillPoints
    //local integer modulo = 0
    local boolean matched = false
    local integer remaining = skillPoints
    local integer index = 1
    local integer max = 0
    local integer abilityId = 0
    local integer abilityMaxLevel = 0
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= skillPoints)
        set matched = false
        //set modulo = ModuloInteger(start + i, 5)
        set max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
        set index = 1
        loop
            exitwhen (index >= max or matched)
            set abilityId = GetHeroAbility(GetUnitTypeId(hero), index)
            set abilityMaxLevel = GetHeroAbilityMaximumLevel(GetUnitTypeId(hero), index)
            if (GetUnitAbilityLevel(hero, abilityId) < abilityMaxLevel) then
                call SelectHeroSkill(hero, abilityId)
                set remaining = remaining - 1
                set matched = true
            endif
            set index = index + 1
        endloop
        exitwhen (not matched)
        set i = i + 1
    endloop

    return remaining
endfunction

function SetEvolutionLevelOfPlayer takes player whichPlayer, integer level returns nothing
    call SetPlayerTechResearched(whichPlayer, UPG_EVOLUTION, level)
endfunction

function GetEvolutionLevelOfPlayer takes player whichPlayer returns integer
    return GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
endfunction

globals
    trigger orderTrigger
endglobals

function TriggerConditionDebugOrder takes nothing returns boolean
    local string order = OrderId2String(GetIssuedOrderId())
    return order != "move" and order != "harvest" and order != "stop" and order != "attack" and order != "resumeharvesting" and order != "smart" and order != "unsubmerge"
endfunction

function GetOrderName takes integer orderId returns string
    if (UnitId2String(orderId) != "" and UnitId2String(orderId) != null) then
        return UnitId2String(orderId)
    elseif (AbilityId2String(orderId) != "" and AbilityId2String(orderId) != null) then
        return AbilityId2String(orderId)
    endif

     return OrderId2String(orderId)
endfunction

function TriggerActionDebugOrder takes nothing returns nothing
    if (GetOrderTargetUnit() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target unit " + GetUnitName(GetOrderTargetUnit()))
    elseif (GetOrderTargetDestructable() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target destructible " + GetDestructableName(GetOrderTargetDestructable()))
    elseif (GetOrderTargetItem() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target item " + GetItemName(GetOrderTargetItem()))
    else
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()))
    endif
endfunction

function InitOrderDebugger takes nothing returns nothing
    set orderTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionDebugOrder))
    call TriggerAddAction(orderTrigger, function TriggerActionDebugOrder)
    call DisableTrigger(orderTrigger)
endfunction

function EnableOrderDebugger takes nothing returns nothing
    call EnableTrigger(orderTrigger)
endfunction

function DisableOrderDebugger takes nothing returns nothing
    call DisableTrigger(orderTrigger)
endfunction

function StringToken takes string source, integer index returns string
    local string result = ""
    local boolean inWhitespace = false
    local integer currentIndex = 0
    local integer i = 0
    loop
        exitwhen (i == StringLength(source) or currentIndex > index)
        if (SubString(source, i, i + 1) == " ") then
            if (not inWhitespace) then
                set inWhitespace = true
                set currentIndex = currentIndex + 1
            endif
        elseif (currentIndex == index) then
            set result = result + SubString(source, i, i + 1)
        endif
        set i = i + 1
    endloop

    return result
endfunction
