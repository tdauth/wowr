library WoWReforgedThievesGuild initializer Init requires WoWReforgedRaces

globals
    private trigger deathTrigger = CreateTrigger()
    private trigger changesOwnerTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger sellUnitTrigger = CreateTrigger()
    private trigger sellItemTrigger = CreateTrigger()
    
    private timer stockUpdateTimer = CreateTimer()

    private group thievesGuilds = CreateGroup()
    private unit tmpUnit = null
    private player tmpPreviousOwner = null
endglobals

function GetThiefStockUpdateTimerHandleId takes nothing returns integer
    return GetHandleId(stockUpdateTimer)
endfunction

//===========================================================================
// Find a sellable item of the given type and level, and then add it.
//
private function UpdateEachStockBuildingEnum takes nothing returns nothing
    local integer iteration = 0
    local integer pickedItemId

    loop
        set pickedItemId = ChooseRandomItemEx(bj_stockPickedItemType, bj_stockPickedItemLevel)
        exitwhen IsItemIdSellable(pickedItemId)

        // If we get hung up on an entire class/level combo of unsellable
        // items, or a very unlucky series of random numbers, give up.
        set iteration = iteration + 1
        if (iteration > bj_STOCK_MAX_ITERATIONS) then
            return
        endif
    endloop
    call AddItemToStock(GetEnumUnit(), pickedItemId, 1, 1)
endfunction

//===========================================================================
private function UpdateEachStockBuilding takes itemtype iType, integer iLevel returns nothing
    set bj_stockPickedItemType = iType
    set bj_stockPickedItemLevel = iLevel

    call ForGroup(thievesGuilds, function UpdateEachStockBuildingEnum)
endfunction

//===========================================================================
// Update stock inventory.
//
private function PerformStockUpdates takes nothing returns nothing
    local integer  pickedItemId
    local itemtype pickedItemType
    local integer  pickedItemLevel = 0
    local integer  allowedCombinations = 0
    local integer  iLevel

    // Give each type/level combination a chance of being picked.
    set iLevel = 1
    loop
        if (bj_stockAllowedPermanent[iLevel]) then
            set allowedCombinations = allowedCombinations + 1
            if (GetRandomInt(1, allowedCombinations) == 1) then
                set pickedItemType = ITEM_TYPE_PERMANENT
                set pickedItemLevel = iLevel
            endif
        endif
        if (bj_stockAllowedCharged[iLevel]) then
            set allowedCombinations = allowedCombinations + 1
            if (GetRandomInt(1, allowedCombinations) == 1) then
                set pickedItemType = ITEM_TYPE_CHARGED
                set pickedItemLevel = iLevel
            endif
        endif
        if (bj_stockAllowedArtifact[iLevel]) then
            set allowedCombinations = allowedCombinations + 1
            if (GetRandomInt(1, allowedCombinations) == 1) then
                set pickedItemType = ITEM_TYPE_ARTIFACT
                set pickedItemLevel = iLevel
            endif
        endif

        set iLevel = iLevel + 1
        exitwhen iLevel > bj_MAX_ITEM_LEVEL
    endloop

    // Make sure we found a valid item type to add.
    if (allowedCombinations == 0) then
        return
    endif

    call UpdateEachStockBuilding(pickedItemType, pickedItemLevel)
endfunction

//===========================================================================
// Perform the first update, and then arrange future updates.
//
private function StartStockUpdates takes nothing returns nothing
    call PerformStockUpdates()
    call TimerStart(stockUpdateTimer, bj_STOCK_RESTOCK_INTERVAL, true, function PerformStockUpdates)
endfunction

function IsThievesGuild takes integer unitTypeId returns boolean
    return unitTypeId == THIEVES_GUILD_THIEF or unitTypeId == THIEVES_GUILD or unitTypeId == BANDIT_THIEVES_GUILD
endfunction

function IsUnitThievesGuild takes unit whichUnit returns boolean
    return IsThievesGuild(GetUnitTypeId(whichUnit))
endfunction

private function IsValidUnit takes player previousOwner, unit whichUnit returns boolean
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    if (previousOwner != Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
        return false
    elseif (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        return false
    elseif (IsUnitType(whichUnit, UNIT_TYPE_PEON)) then
        return false
    elseif (IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE)) then
        return false
    elseif (IsUnitType(whichUnit, UNIT_TYPE_SUMMONED)) then
        return false
    elseif (IsCitizen(unitTypeId)) then
        return false
    endif
    return true
endfunction

private function ForGroupAddUnitToThievesGuild takes nothing returns nothing
    local integer unitTypeId = GetUnitTypeId(tmpUnit)
    local integer whichRace = GetObjectRace(unitTypeId)
    local unit u = GetEnumUnit()
    local player owner = GetOwningPlayer(u)
    //call BJDebugMsg("Checking thieves guild " + GetUnitName(u) + " with enemy " + GetUnitName(tmpUnit))
    if (IsPlayerEnemy(tmpPreviousOwner, owner) and (whichRace == udg_RaceNone or PlayerHasRace(owner, whichRace))) then
        call AddUnitToStock(u, GetUnitTypeId(tmpUnit), 1, 1)
    endif
    set u = null
    set owner = null
endfunction

private function AddUnitToThievesGuild takes player previousOwner, unit whichUnit returns nothing
    set tmpUnit = whichUnit
    set tmpPreviousOwner = previousOwner
    call ForGroup(thievesGuilds, function ForGroupAddUnitToThievesGuild)
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local player owner = GetOwningPlayer(u)
    if (IsUnitInGroup(u, thievesGuilds)) then
        call GroupRemoveUnit(thievesGuilds, u)
    elseif (IsValidUnit(owner, u)) then
        call AddUnitToThievesGuild(owner, u)
    endif
    set u = null
    set owner = null

    return false
endfunction

private function TriggerConditionChangesOwner takes nothing returns boolean
    local unit u = GetTriggerUnit()
    if (IsValidUnit(GetChangingUnitPrevOwner(), u)) then
        call AddUnitToThievesGuild(GetChangingUnitPrevOwner(), u)
    endif
    set u = null

    return false
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    local unit b = GetConstructedStructure()
    local integer unitTypeId = GetUnitTypeId(b)
    if (IsThievesGuild(unitTypeId)) then
        call GroupAddUnit(thievesGuilds, b)
    
        if (unitTypeId == THIEVES_GUILD_THIEF or unitTypeId == BANDIT_THIEVES_GUILD) then
            call SetItemTypeSlots(b, 6)
            call SetUnitTypeSlots(b, 6)
        else
            call SetItemTypeSlots(b, 0)
            call SetUnitTypeSlots(b, 12)
        endif
    endif
    set b = null

    return false
endfunction

private function RemovePurchasedUnit takes nothing returns nothing
    call RemoveUnitFromStock(GetSellingUnit(), GetUnitTypeId(GetSoldUnit()))
endfunction

private function TriggerConditionSell takes nothing returns boolean
    if (IsUnitThievesGuild(GetSellingUnit())) then
        call RemovePurchasedUnit()
    endif

    return false
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    if (IsUnitThievesGuild(GetSellingUnit())) then
        call RemovePurchasedItem()
    endif

    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(changesOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changesOwnerTrigger, Condition(function TriggerConditionChangesOwner))
    
    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))
    
    call TriggerRegisterAnyUnitEventBJ(sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellUnitTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSellItem))
    
    // Arrange the first update.
    call TimerStart(stockUpdateTimer, bj_STOCK_RESTOCK_INITIAL_DELAY, false, function StartStockUpdates)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, thievesGuilds)) then
        call GroupRemoveUnit(thievesGuilds, whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
