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

function FlushUnitParameters takes unit whichUnit returns nothing
    call FlushChildHashtable(udg_DB, GetHandleId(whichUnit))
endfunction

function PlayerIsOnlineUser takes integer PlayerNumber returns boolean
    return GetPlayerController(Player(PlayerNumber)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(PlayerNumber)) == PLAYER_SLOT_STATE_PLAYING
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
					set udg_RucksackItemType[index] = 0
					set udg_RucksackItemCharges[index] = 0
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
                call SetItemCharges(whichItem, GetItemCharges(UnitItemInSlot(udg_Rucksack[PlayerNumber], I1)))
            else
                set whichItem = CreateItem(udg_RucksackItemType[index], GetRectCenterX(whichRect), GetRectCenterY(whichRect))
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
                    set udg_RucksackItemType[index] = 0
                    set udg_RucksackItemCharges[index] = 0
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
            set udg_RucksackItemType[index] = 0
            set udg_RucksackItemCharges[index] = 0
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
            set udg_RucksackItemType[index] = 0
            set udg_RucksackItemCharges[index] = 0
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
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
    local item SlotItem = null
    local integer CarriedItemType = 0
    local integer I0 = 0
    local integer index = 0
	call DisableTrigger(gg_trg_Legendary_Artifact_Counter_Pickup)
    // Create All Items From Next/Previous Page
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(PlayerNumber, RucksackPage, I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        call UnitAddItemByIdSwapped(udg_RucksackItemType[index], udg_Rucksack[PlayerNumber])
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Legendary_Artifact_Counter_Pickup)
    // Remove All None Items
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set SlotItem = UnitItemInSlot(udg_Rucksack[PlayerNumber], I0)
        set CarriedItemType = GetItemTypeId(UnitItemInSlot(udg_Rucksack[PlayerNumber], I0))
        if (CarriedItemType == udg_RucksackNoneItemType) then
            call RemoveItem(SlotItem)
        endif
        set SlotItem = null
        set I0 = I0 + 1
    endloop
endfunction

function ChangeRucksackPage takes integer PlayerNumber, boolean Forward returns nothing
    local integer I0 = 0
    local integer index = 0
    local player RucksackOwner = Player(PlayerNumber)
    local integer RucksackPage = udg_RucksackPageNumber[PlayerNumber]
    local item SlotItem = null
    local integer CarriedItemType = 0
	call DisableTrigger(gg_trg_Legendary_Artifact_Counter_Drop)
    // Save All Items
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set SlotItem = UnitItemInSlot(udg_Rucksack[PlayerNumber], I0)
        set CarriedItemType = GetItemTypeId(SlotItem)
        set index = Index3D(PlayerNumber, RucksackPage, I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        if (CarriedItemType != null) then
            set udg_RucksackItemType[index] = CarriedItemType
            set udg_RucksackItemCharges[index] = GetItemCharges(SlotItem)
        else
            set udg_RucksackItemType[index] = udg_RucksackNoneItemType
            set udg_RucksackItemCharges[index] = 0
        endif
        call RemoveItem(SlotItem)
        set SlotItem = null
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Legendary_Artifact_Counter_Drop)
    // Change Page
    if (Forward) then
        if (RucksackPage != (udg_RucksackMaxPages - 1)) then
            set udg_RucksackPageNumber[PlayerNumber] = (udg_RucksackPageNumber[PlayerNumber] + 1)
        else
            set udg_RucksackPageNumber[PlayerNumber] = 0
        endif
    else
        if (RucksackPage != 0) then
            set udg_RucksackPageNumber[PlayerNumber] = (udg_RucksackPageNumber[PlayerNumber] - 1)
        else
            set udg_RucksackPageNumber[PlayerNumber] = (udg_RucksackMaxPages - 1)
        endif
    endif
    set RucksackPage = udg_RucksackPageNumber[PlayerNumber]
    call DisplayTimedTextToPlayer(RucksackOwner, 0.00, 0.00, 4.00, ("Open Bag " + I2S(RucksackPage + 1) + "."))
    call RefreshRucksackPage(PlayerNumber)
    set RucksackOwner = null
endfunction

function TriggerFunctionChangeRucksackPage takes nothing returns nothing
    if (GetSpellAbilityId() == udg_RucksackAbility1) then
        call ChangeRucksackPage(GetPlayerId(GetTriggerPlayer()), true)
    elseif (GetSpellAbilityId() == udg_RucksackAbility2) then
        call ChangeRucksackPage(GetPlayerId(GetTriggerPlayer()), false)
    endif
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
        call TriggerAddAction(udg_PlayerRucksackTrigger[PlayerNumber], function TriggerFunctionChangeRucksackPage)
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
    call SaveUnitParameterInteger(whichUnit, 0, Group)
endfunction

function AssignUnitToCurrentGroupEx takes integer lastIndex returns nothing
    local integer memberIndex = Index2D(udg_TmpGroupIndex, lastIndex, udg_RespawnGroupMaxMembers)
    local unit lastMember = udg_LastAddedUnitToGroup
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
    set lastMember = null
endfunction

function AssignUnitToCurrentGroup takes nothing returns nothing
    call AssignUnitToCurrentGroupEx(CountUnitsInGroup(udg_RespawnGroup[udg_TmpGroupIndex]) - 1)
endfunction

function InitCurrentGroup takes nothing returns nothing
    set udg_TmpGroupIndex = udg_TmpGroupIndex + 1
    set udg_RespawnGroup[udg_TmpGroupIndex] = CreateGroup()
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
    set	udg_RucksackNoneItemType = 'I028'
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

function DropRandomItem takes unit whichUnit, integer highestCreepLevel returns item
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
	return UnitDropItem(whichUnit, RandomDistChoose())
endfunction

function GetUnitLevelByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_LEVEL)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDamageTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitWeaponIntegerField(dummy , UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDefenseTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_DEFENSE_TYPE)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitMovementTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
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
    endif
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

globals
	string array raceIcons[500]
	string array professionIcons[500]
	hashtable UnitTypeIconsHashTable = InitHashtable()
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
	 call SaveStr(UnitTypeIconsHashTable, unitTypeId, 0, icon)
endfunction

function GetIconByUnitType takes integer unitTypeId returns string
	local string result = LoadStr(UnitTypeIconsHashTable, unitTypeId, 0)
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
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
    constant string SAVE_CODE_DIGITS = "w19B2hj5c74LHlWmAKrvGPopUuSNeRzIDkCFVQ8Y6OqdytiTJsnx0g3bMafZE"
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
    return GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER and GetPlayerSlotState(GetFilterPlayer()) != PLAYER_SLOT_STATE_EMPTY
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

function CreateSaveCodeTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer xpRate, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills, string saveCode returns nothing
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
    set content = content + AppendFileContent("Player: " + playerName + "\r\n\t\t\t\t" + "Singleplayer: " + singleplayer + "\r\n\t\t\t\t" + "Game Mode: " + gameMode + "\r\n\t\t\t\t" + "Game Type: " + gameType + "\r\n\t\t\t\t" + "XP rate: " + I2S(xpRate) + "\r\n\t\t\t\t" + "XP: " + I2S(xp))
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("Evolution: " + I2S(evolutionLevel))
    set content = content + AppendFileContent("Improved Power Generator: " + I2S(powerGeneratorLevel))
    set content = content + AppendFileContent("Hand of God: " + I2S(handOfGodLevel))
    set content = content + AppendFileContent("Improved Mount: " + I2S(mountLevel))
    set content = content + AppendFileContent("Improved Masonry: " + I2S(masonryLevel))
    set content = content + AppendFileContent("Hero Kills: " + I2S(heroKills))
    set content = content + AppendFileContent("Hero Deaths: " + I2S(heroDeaths))
    set content = content + AppendFileContent("Unit Kills: " + I2S(unitKills))
    set content = content + AppendFileContent("Unit Deaths: " + I2S(unitDeaths))
    set content = content + AppendFileContent("Buildings Razed: " + I2S(buildingsRazed))
    set content = content + AppendFileContent("Boss Kills: " + I2S(totalBossKills))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-xp" + I2S(xp) + ".txt")
endfunction

function GetSaveCodeEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    // use one single symbol to store these two flags
    if (isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 0")
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
    elseif (isSinglePlayer and not isWarlord) then
        //call BJDebugMsg("Save code single player and mode 1")
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1)
    elseif (not isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 2")
        set result = result + ConvertDecimalNumberToSaveCodeSegment(2)
    else
        //call BJDebugMsg("Save code single player and mode 3")
        set result = result + ConvertDecimalNumberToSaveCodeSegment(3)
    endif

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

    call CreateSaveCodeTextFile(playerName, isSinglePlayer, isWarlord, gameType, xpRate, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills, result)

    return result
endfunction

globals
    constant integer UPG_EVOLUTION                                   = 'R00U'
	constant integer UPG_IMPROVED_POWER_GENERATOR                    = 'R01T'
	constant integer UPG_IMPROVED_MOUNT                              = 'R024'
	constant integer UPG_IMPROVED_HAND_OF_GOD                        = 'R00V'
	constant integer UPG_IMPROVED_MASONRY                            = 'R00W'
endglobals

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

    return GetSaveCodeEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills)
endfunction

function GetSaveCodeBarade takes nothing returns string
    return GetSaveCodeEx("Barade#2569", false, false, udg_GameTypeNormal, 130, 50049900, 800000, 800000, 100, 100, 100, 100, 100, 8000, 0, 20000, 0, 20000, 5000)
endfunction

function ReadSaveCode takes string saveCode, integer hash returns string
    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Deobfuscating with the hash!")
        return ConvertSaveCodeFromObfuscatedVersion(saveCode, hash)
    endif

    //call BJDebugMsg("Just returning!")

    return saveCode
endfunction

function ApplySaveCode takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = false
    local boolean isWarlord = false
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

    // use one single symbol to store these two flags
    if (isSinglePlayerAndWarlord == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        set isSinglePlayer = true
        set isWarlord = true
    elseif (isSinglePlayerAndWarlord == 1) then
        //call BJDebugMsg("Save code single player and mode 1")
        set isSinglePlayer = true
        set isWarlord = false
    elseif (isSinglePlayerAndWarlord == 2) then
        //call BJDebugMsg("Save code single player and mode 2")
        set isSinglePlayer = false
        set isWarlord = true
    else
        //call BJDebugMsg("Save code single player and mode 3")
        set isSinglePlayer = false
        set isWarlord = false
    endif

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        call SetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)], xp, true)

        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
        call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        call SetPlayerTechResearched(whichPlayer, UPG_EVOLUTION, evolutionLevel)
        call SetPlayerTechResearched(whichPlayer, UPG_IMPROVED_POWER_GENERATOR, powerGeneratorLevel)
        call SetPlayerTechResearched(whichPlayer, UPG_IMPROVED_HAND_OF_GOD, handOfGodLevel)
        call SetPlayerTechResearched(whichPlayer, UPG_IMPROVED_MOUNT, mountLevel)
        call SetPlayerTechResearched(whichPlayer, UPG_IMPROVED_MASONRY, masonryLevel)
        set udg_HeroKills[GetConvertedPlayerId(whichPlayer)] = heroKills
        set udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)] = heroDeaths
        set udg_UnitKills[GetConvertedPlayerId(whichPlayer)] = unitKills
        set udg_UnitsLost[GetConvertedPlayerId(whichPlayer)] = unitDeaths
        set udg_BuildingsRazed[GetConvertedPlayerId(whichPlayer)] = buildingsRazed
        set udg_BossKills[GetConvertedPlayerId(whichPlayer)] = totalBossKills

        return true
    endif

    return false
endfunction

function GetSaveCodeErrors takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = false
    local boolean isWarlord = false
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set result = result + "Expected different checksum!"
    endif

    // use one single symbol to store these two flags
    if (isSinglePlayerAndWarlord == 0) then
        set isSinglePlayer = true
        set isWarlord = true
    elseif (isSinglePlayerAndWarlord == 1) then
        set isSinglePlayer = true
        set isWarlord = false
    elseif (isSinglePlayerAndWarlord == 2) then
        set isSinglePlayer = false
        set isWarlord = true
    else
        set isSinglePlayer = false
        set isWarlord = false
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

function GetSaveCodeInfos takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = false
    local boolean isWarlord = false
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Invalid checksum"
    endif


    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Invalid player name checksum"
    endif

    // use one single symbol to store these two flags
    if (isSinglePlayerAndWarlord == 0) then
        set isSinglePlayer = true
        set isWarlord = true
    elseif (isSinglePlayerAndWarlord == 1) then
        set isSinglePlayer = true
        set isWarlord = false
    elseif (isSinglePlayerAndWarlord == 2) then
        set isSinglePlayer = false
        set isWarlord = true
    else
        set isSinglePlayer = false
        set isWarlord = false
    endif

    if (isSinglePlayer) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Singleplayer"
    else
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Multiplayer"
    endif

    if (isWarlord) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Warlord"
    else
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Freelancer"
    endif

    if (StringLength(result) > 0) then
        set result = result + ", "
    endif
     set result = result + "Game type: " + I2S(gameType)

    if (StringLength(result) > 0) then
        set result = result + ", "
    endif
    set result = result + "XP rate: " + I2S(xpRate)

     if (StringLength(result) > 0) then
        set result = result + ", "
    endif

     set result = result + "XP: " + I2S(xp)

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
