library WoWReforgedProfessionFarmer initializer Init requires Resources

globals
    private filterfunc f
    private player owner

    private trigger sellTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private integer array seedUnitTypeIds
    private integer array foodItemTypeIds
    private integer seedItemTypeIdsCounter = 0
endglobals

function AddFarmFarmer takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 200)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddWheatField takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 300)
endfunction

function AddCowshed takes unit whichUnit returns nothing
    call AddLoadedMine(whichUnit, udg_ResourceMilk, 800, 5)
    call SetLoadedMineAllowedWorkerUnitTypeId(whichUnit, COW, true)
    call SetMineExplodesOnDeath(whichUnit, true)
endfunction

function AddSheepfold takes unit whichUnit returns nothing
    call AddLoadedMine(whichUnit, udg_ResourceWool, 800, 5)
    call SetLoadedMineAllowedWorkerUnitTypeId(whichUnit, SHEEP, true)
    call SetMineExplodesOnDeath(whichUnit, true)
endfunction

function AddWaterSupply takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceWater, 500)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddGranary takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 400)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddWindMill takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 600)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

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

function AddFarmhand takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceMeat, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    call AddResourceToWorker(worker, udg_ResourceGrain, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    call AddResourceToWorker(worker, udg_ResourceWater, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

private function AddFarmerSheep takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 30)
endfunction

private function AddFarmerChicken takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 10)
endfunction

private function AddFarmerCow takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 100)
endfunction

private function AddFarmerPig takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 60)
endfunction

private function TriggerConditionSell takes nothing returns boolean
    local integer soldUnitTypeId = 0
    if (GetUnitTypeId(GetSellingUnit()) == FARM_FARMER) then
        set soldUnitTypeId = GetUnitTypeId(GetSoldUnit())
        if (soldUnitTypeId == COW) then
            call AddFarmerCow(GetTriggerUnit(), GetSoldUnit())
        elseif (soldUnitTypeId == PIG) then
            call AddFarmerPig(GetTriggerUnit(), GetSoldUnit())
        elseif (soldUnitTypeId == CHICKEN) then
            call AddFarmerChicken(GetTriggerUnit(), GetSoldUnit())
        elseif (soldUnitTypeId == SHEEP) then
             call AddFarmerSheep(GetTriggerUnit(), GetSoldUnit())
        endif
    endif

    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetKillingUnit() == null) then
        call DropPossibleGrownItemFromSeed(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set f = Filter(function FilterIsWaterSupply)

    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))

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
