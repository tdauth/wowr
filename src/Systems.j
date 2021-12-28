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
    return 1200.0
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
        if (IsUnitType(FirstOfBuildingGroup, UNIT_TYPE_STRUCTURE) and PlayerIsOnlineUser(GetPlayerId(OwningPlayer))) then
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

function AssignUnitToCurrentGroup takes nothing returns nothing
    local integer lastIndex = CountUnitsInGroup(udg_RespawnGroup[udg_TmpGroupIndex]) - 1
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
		call GroupAddUnitSimple(lastMember, udg_RespawnGroupHeroes[udg_TmpGroupIndex])
	endif
    set lastMember = null
endfunction

function InitCurrentGroup takes nothing returns nothing
    set udg_TmpGroupIndex = udg_TmpGroupIndex + 1
    set udg_RespawnGroup[udg_TmpGroupIndex] = CreateGroup()
	set udg_RespawnGroupHeroes[udg_TmpGroupIndex] = CreateGroup()
endfunction

function GetHeroUnitMatching takes integer Group, integer unitTypeId, group revivedHeroes returns unit
	local unit first = null
	local unit hero = null
	local group tmpGroup = CreateGroup()
	call GroupAddGroup(udg_RespawnGroupHeroes[Group], tmpGroup)
	loop
		set first = FirstOfGroup(tmpGroup)
		exitwhen (first == null or hero != null)
		if (GetUnitTypeId(first) == unitTypeId and not IsUnitInGroup(first, revivedHeroes)) then
			set hero = first
		endif
		call GroupRemoveUnit(tmpGroup, first)
	endloop

	call GroupClear(tmpGroup)
	call DestroyGroup(tmpGroup)
	set tmpGroup = null
	set first = null

	return hero
endfunction

function RespawnGroup takes integer Group returns boolean
	local boolean result = false
    local integer I0 = 0
    local integer index = 0
	local integer I1 = 0
    local location RespawnLocation
    local unit GroupMember = null
	local group revivedHeroes = CreateGroup()
    debug call BJDebugMsg("Respawn group: " + I2S(Group))
    if (IsUnitGroupEmptyBJ(udg_RespawnGroup[Group])) then
        debug call BJDebugMsg("Is empty: " + I2S(Group))
        set I0 = 0
        loop
            exitwhen(I0 == udg_RespawnGroupMaxMembers)
            set index = Index2D(Group, I0, udg_RespawnGroupMaxMembers)
            if (udg_RespawnUnitType[index] != null and udg_RespawnUnitType[index] != 0) then
				if (not IsUnitGroupEmptyBJ(udg_RespawnGroupHeroes[Group])) then
					set GroupMember = GetHeroUnitMatching(Group, udg_RespawnUnitType[index], revivedHeroes)
					debug call BJDebugMsg("Group " + I2S(Group) + " has heroes and the member is " + GetUnitName(GroupMember) )
				else
					set GroupMember = null
					debug call BJDebugMsg("Group " + I2S(Group) + " has no heroes")
				endif

				if (GroupMember == null) then
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
				else
					// hero creeps should keep their XP
					if (udg_RespawnLocationPerUnit[index] != null) then
						set RespawnLocation = udg_RespawnLocationPerUnit[index]
					else
						set RespawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
					endif
					debug call PingMinimapLocForForce(GetPlayersAll(), RespawnLocation, 5)
					call ReviveHeroLoc(GroupMember, RespawnLocation, true)
					call GroupAddUnit(udg_RespawnGroup[Group], GroupMember)
					call GroupAddUnit(revivedHeroes, GroupMember)
					debug call BJDebugMsg("Group " + I2S(Group) + " revive hero: " + GetUnitName(GroupMember))
					if (udg_RespawnLocationPerUnit[index] == null) then
						call RemoveLocation(RespawnLocation)
					endif
					set RespawnLocation = null
				endif
            else
                exitwhen(true)
            endif
            set I0 = I0 + 1
        endloop

		set result = true
    endif

	call GroupClear(revivedHeroes)
	call DestroyGroup(revivedHeroes)
	set revivedHeroes = null

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
	return result
endfunction

function TriggerConditionNoBuilding takes nothing returns boolean
    local trigger triggeringTrigger = GetTriggeringTrigger()
    local integer Group = LoadTriggerParameterInteger(triggeringTrigger, 0)
    set triggeringTrigger = null
    return RespawnRectContainsNoBuilding(Group)
endfunction

function TriggerActionRespawnGroup takes nothing returns nothing
    local trigger triggeringTrigger = GetTriggeringTrigger()
    local integer Group = LoadTriggerParameterInteger(triggeringTrigger, 0)
    call RespawnGroup(Group)
    call DestroyParameterTrigger(triggeringTrigger)
    set triggeringTrigger = null
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

function TriggerActionRespawnMonster takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local integer Group = GetRespawnGroupOfUnit(triggerUnit)
    local real RandomNumber = 0.0
    local location ItemSpawnLocation = null
    local item whichItem = null
    debug call BJDebugMsg("Respawn monster with group " + I2S(Group) + " handle ID: " + I2S(GetHandleId(triggerUnit)))
    if (Group != -1) then
        call GroupRemoveUnit(udg_RespawnGroup[Group], triggerUnit)
        if (IsUnitType(triggerUnit, UNIT_TYPE_HERO)) then
			call DropAllItemsFromHero(triggerUnit)
		else
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
