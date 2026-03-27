library WoWReforgedProfessionFarmer initializer Init

globals
    private filterfunc f
    private player owner

    private trigger deathTrigger = CreateTrigger()
    private integer array seedUnitTypeIds
    private integer array foodItemTypeIds
    private integer seedItemTypeIdsCounter = 0
endglobals

private function FilterIsWaterSupply takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == WATER_SUPPLY and GetOwningPlayer(GetFilterUnit()) == owner
endfunction

private function AddSeed takes integer unitTypeId, integer itemTypeId returns nothing
    local integer index  = seedItemTypeIdsCounter
    set seedUnitTypeIds[index] = unitTypeId
    set foodItemTypeIds[index] = itemTypeId
    set seedItemTypeIdsCounter = seedItemTypeIdsCounter + 1
endfunction

private function DropGrownItem takes integer itemTypeId, unit whichUnit returns nothing
    local group g = CreateGroup()
    local real x = GetUnitX(whichUnit)
    local real y = GetUnitY(whichUnit)
    local item i = CreateItem(itemTypeId, x, y)
    set owner = GetOwningPlayer(whichUnit)
    call GroupEnumUnitsInRange(g, x, y, 400.0, f)
    call SetItemCharges(i, 1 + BlzGroupGetSize(g))
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    set i = null
endfunction

private function DropPossibleGrownItemFromSeed takes unit whichUnit returns nothing
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer i = 0
    loop
        exitwhen (i == seedItemTypeIdsCounter)
        if (unitTypeId == seedUnitTypeIds[i]) then
            call DropGrownItem(foodItemTypeIds[i], whichUnit)
        endif
        set i = i + 1
    endloop
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetKillingUnit() == null) then
        call DropPossibleGrownItemFromSeed(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set f = Filter(function FilterIsWaterSupply)

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call AddSeed(PUMPKIN_SEED, ITEM_PUMPKIN)
    call AddSeed(APPLE_TREE, ITEM_APPLE)
    call AddSeed(PLUM_TREE, ITEM_PLUM)
    call AddSeed(CHERRY_TREE, ITEM_CHERRY)
    call AddSeed(STRAWBERRY_BUSH, ITEM_STRAWBERRY)
    call AddSeed(BEEHIVE, ITEM_HONEYCOMB)
endfunction

endlibrary
