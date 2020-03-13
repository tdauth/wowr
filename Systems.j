//TESH.scrollpos=400
//TESH.alwaysfold=0

function Index2D takes integer Value1, integer Value2, integer MaxValue2 returns integer
    return ((Value1 * MaxValue2) + Value2)
endfunction

function Index3D takes integer Value1, integer Value2, integer Value3, integer MaxValue2, integer MaxValue3 returns integer
    return ((Value1 * (MaxValue2 * MaxValue3)) + (Value2 * MaxValue3) + Value3)
endfunction

function SaveTriggerParameterInteger takes handle Trigger, string ParameterName, integer Value returns nothing
    call SaveInteger(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName), Value)
endfunction

function SaveTriggerParameterBoolean takes handle Trigger, string ParameterName, boolean Value returns nothing
    call SaveBoolean(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName), Value)
endfunction

function SaveTriggerParameterString takes handle Trigger, string ParameterName, string Value returns nothing
    call SaveStr(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName), Value)
endfunction

function SaveTriggerParameterReal takes handle Trigger, string ParameterName, real Value returns nothing
    call SaveReal(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName), Value)
endfunction

function LoadTriggerParameterInteger takes handle Trigger, string ParameterName returns integer
    return LoadInteger(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function LoadTriggerParameterBoolean takes handle Trigger, string ParameterName returns boolean
    return LoadBoolean(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function LoadTriggerParameterString takes handle Trigger, string ParameterName returns string
    return LoadStr(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function LoadTriggerParameterReal takes handle Trigger, string ParameterName returns real
    return LoadReal(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function TriggerParameterIntegerExists takes handle Trigger, string ParameterName returns boolean
    return HaveSavedInteger(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function TriggerParameterBooleanExists takes handle Trigger, string ParameterName returns boolean
    return HaveSavedBoolean(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function TriggerParameterStringExists takes handle Trigger, string ParameterName returns boolean
    return HaveSavedString(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function TriggerParameterRealExists takes handle Trigger, string ParameterName returns boolean
    return HaveSavedReal(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))), StringHash(ParameterName))
endfunction

function DestroyParameterTrigger takes trigger Trigger returns nothing
    call FlushChildHashtable(udg_DB, StringHash("TriggerParameter_" + I2S(GetHandleId(Trigger))))
    call DestroyTrigger(Trigger)
endfunction

function PlayerIsOnlineUser takes integer PlayerNumber returns boolean
    local player User = Player(PlayerNumber)
    local boolean IsOnline = false
    if (GetPlayerController(User) == MAP_CONTROL_USER and GetPlayerSlotState(User) == PLAYER_SLOT_STATE_PLAYING) then
        set IsOnline = true
    endif
    set User = null
    return IsOnline
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
    // Create All Items From Next/Previous Page
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(PlayerNumber, RucksackPage, I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        call UnitAddItemByIdSwapped(udg_RucksackItemType[index], udg_Rucksack[PlayerNumber])
        set I0 = I0 + 1
    endloop
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
    // Change Page
    if (Forward == true) then
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
    local integer I0 = 0
    loop
        exitwhen(I0 == udg_MaxRespawnGroups)
        if (IsUnitInGroup(Unit, udg_RespawnGroup[I0])) then
            return I0
        endif
        set I0 = I0 + 1
    endloop
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

function RespawnGroup takes integer Group returns nothing
    local integer I0
    local player NeutralAggressivePlayer = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local location RespawnLocation
    local unit array GroupMember
    set I0 = 0
    loop
        exitwhen(I0 == udg_RespawnGroupMaxMembers)
        if (udg_RespawnUnitType[Index2D(Group, I0, udg_RespawnGroupMaxMembers)] != null) then
            set RespawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
            set GroupMember[I0] = CreateUnit(NeutralAggressivePlayer, udg_RespawnUnitType[Index2D(Group, I0, udg_RespawnGroupMaxMembers)], GetLocationX(RespawnLocation), GetLocationY(RespawnLocation), GetRandomReal(0.00, 360.00))
            call GroupAddUnit(udg_RespawnGroup[Group], GroupMember[I0])
            call RemoveLocation(RespawnLocation)
            set RespawnLocation = null
        else
            exitwhen(true)
        endif
        set I0 = I0 + 1
    endloop
    set NeutralAggressivePlayer = null
endfunction

function TriggerConditionNoBuilding takes nothing returns boolean
    local trigger triggeringTrigger = GetTriggeringTrigger()
    local integer Group = LoadTriggerParameterInteger(triggeringTrigger, "Group")
    set triggeringTrigger = null
    return RespawnRectContainsNoBuilding(Group)
endfunction

function TriggerActionRespawnGroup takes nothing returns nothing
    local trigger triggeringTrigger = GetTriggeringTrigger()
    local integer Group = LoadTriggerParameterInteger(triggeringTrigger, "Group")
    call RespawnGroup(Group)
    call DestroyParameterTrigger(triggeringTrigger)
    set triggeringTrigger = null
endfunction

function RespawnGroupTimed takes integer Group returns nothing
    set udg_RespawnGroupTrigger[Group] = CreateTrigger()
    call TriggerRegisterTimerEvent(udg_RespawnGroupTrigger[Group], udg_RespawnTime, true)
    call TriggerAddCondition(udg_RespawnGroupTrigger[Group], Condition(function TriggerConditionNoBuilding))
    call TriggerAddAction(udg_RespawnGroupTrigger[Group], function TriggerActionRespawnGroup)
    call SaveTriggerParameterInteger(udg_RespawnGroupTrigger[Group], "Group", Group)
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
    set udg_RespawnItemChance = 50.00
endfunction

function GetPlayerLeavesMessage takes nothing returns string
    return "has left the game."
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
        if (PlayerIsOnlineUser(I0) == true) then
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

function TriggerActionRespawnMonster takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local integer Group = GetRespawnGroupOfUnit(triggerUnit)
    local real RandomNumber = 0.0
    local location ItemSpawnLocation = null
    if (Group  != -1) then
        call GroupRemoveUnit(udg_RespawnGroup[Group], triggerUnit)
        if (IsUnitGroupEmptyBJ(udg_RespawnGroup[Group]) == true) then
            set RandomNumber = GetRandomReal(0.00, 100.00)
            if (RandomNumber <= udg_RespawnItemChance) then
                set ItemSpawnLocation = GetRandomLocInRect(udg_RespawnRect[Group])
                call CreateItem(udg_RespawnItemType[Group], GetLocationX(ItemSpawnLocation), GetLocationY(ItemSpawnLocation))
                call RemoveLocation(ItemSpawnLocation)
                set ItemSpawnLocation = null
            endif
            call RespawnGroupTimed(Group)
        endif
    endif
    set triggerUnit = null
endfunction

function TriggerActionPlayerLeaves takes nothing returns nothing
    local player triggerPlayer = GetTriggerPlayer()
    local force AllPlayers = GetPlayersAll()
    call DisplayTimedTextToForce(AllPlayers, 4.00, (GetPlayerName(triggerPlayer) + " " + GetPlayerLeavesMessage()))
    if (udg_UseRucksackSystem) then
        call DestroyRucksackSystemForPlayer(GetPlayerId(triggerPlayer))
    endif
    set triggerPlayer = null
    set AllPlayers = null
endfunction

function InitCustomSystems takes nothing returns nothing
    local integer I0 = 0
    local trigger LeaveTrigger = null
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
        call TriggerAddAction(udg_RespawnTrigger, function TriggerActionRespawnMonster)
    endif
    // Leave Trigger
    set LeaveTrigger = CreateTrigger()
    loop
        exitwhen(I0 == bj_MAX_PLAYERS)
        if (PlayerIsOnlineUser(I0)) then
            call TriggerRegisterPlayerEvent(LeaveTrigger, Player(I0), EVENT_PLAYER_LEAVE)
        endif
        set I0 = I0 + 1
    endloop
    call TriggerAddAction(LeaveTrigger, function TriggerActionPlayerLeaves)
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