library WoWReforgedGaia initializer Init requires OnStartGame

private function UpdateGaiaUnitForPlayer takes unit whichUnit, player whichPlayer returns nothing
    call SetUnitRescuable(whichUnit, whichPlayer, GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP) - GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED) >= GetUnitFoodUsed(whichUnit))
    call SetUnitRescueRange(whichUnit, 384.0)
endfunction

function UpdateGaiaUnitForAllPlayers takes unit whichUnit returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) != PLAYER_SLOT_STATE_EMPTY) then
            call UpdateGaiaUnitForPlayer(whichUnit, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

globals
    private trigger updateFoodTriger = CreateTrigger()

    private player tmpPlayer = null
endglobals

private function ForGroupUpdateForPlayer takes nothing returns nothing
    call UpdateGaiaUnitForPlayer(GetEnumUnit(), tmpPlayer)
endfunction

private function UpdateAllGaiaUnitsForPlayer takes player whichPlayer returns nothing
    local group allUnits = GetUnitsOfPlayerAll(udg_Gaia)
    set tmpPlayer = whichPlayer
    call ForGroup(allUnits, function ForGroupUpdateForPlayer)
    call GroupClear(allUnits)
    call DestroyGroup(allUnits)
    set allUnits = null
endfunction

private function ForGroupUpdateForAllPlayers takes nothing returns nothing
    call UpdateGaiaUnitForAllPlayers(GetEnumUnit())
endfunction

private function UpdateAllGaiaUnitsForAllPlayers takes nothing returns nothing
    local group allUnits = GetUnitsOfPlayerAll(udg_Gaia)
    call ForGroup(allUnits, function ForGroupUpdateForAllPlayers)
    call GroupClear(allUnits)
    call DestroyGroup(allUnits)
    set allUnits = null
endfunction

private function TriggerConditionUpdateFood takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    if (GetTriggerEventId() == EVENT_PLAYER_UNIT_SELL) then
        set owner = GetOwningPlayer(GetSoldUnit())
    endif
    if (GetTriggerEventId() == EVENT_PLAYER_HERO_REVIVE_FINISH) then
        set owner = GetOwningPlayer(GetRevivingUnit())
    endif
    if (GetPlayerController(owner) == MAP_CONTROL_USER) then
        call UpdateAllGaiaUnitsForPlayer(owner)
    endif
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(updateFoodTriger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerRegisterAnyUnitEventBJ(updateFoodTriger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerRegisterAnyUnitEventBJ(updateFoodTriger, EVENT_PLAYER_UNIT_SELL)
    call TriggerRegisterAnyUnitEventBJ(updateFoodTriger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(updateFoodTriger, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddCondition(updateFoodTriger, Condition(function TriggerConditionUpdateFood))
    
    call TryInitRescuableTriggersBJ()
    
    // Only player 1 red can rescue the units if this is done during the map initialization. Hence, we delay it.
    call OnStartGame(function UpdateAllGaiaUnitsForAllPlayers)
endfunction

endlibrary
