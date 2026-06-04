library WoWReforgedProfessionMiner initializer Init requires Resources

globals
    private integer array oreItemTypeIds
    private integer oreItemTypeIdsCounter = 0

    private integer array mineralResources
    private integer mineralResourcesCounter = 0

    private trigger itemStartSpawnTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
endglobals

function GetRandomOreItemTypeId takes nothing returns integer
    return oreItemTypeIds[GetRandomInt(0, oreItemTypeIdsCounter - 1)]
endfunction

function IsOre takes integer itemTypeId returns boolean
    local integer i = 0
    loop
        exitwhen (i == oreItemTypeIdsCounter)
        if (itemTypeId == oreItemTypeIds[i]) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function AddOreItemTypeId takes integer itemTypeId returns nothing
    set oreItemTypeIds[oreItemTypeIdsCounter] = itemTypeId
    set oreItemTypeIdsCounter = oreItemTypeIdsCounter + 1
endfunction

function IsGem takes integer itemTypeId returns boolean
    return itemTypeId == ITEM_GEM_DIAMOND
endfunction

function GetRandomMineralResource takes nothing returns integer
    return mineralResources[GetRandomInt(0, mineralResourcesCounter - 1)]
endfunction

function AddMineralResource takes integer resource returns nothing
    set mineralResources[mineralResourcesCounter] = resource
    set mineralResourcesCounter = mineralResourcesCounter + 1
endfunction

function AddMinerMine takes unit mine returns nothing
    call AddMineEx(mine, GetRandomMineralResource(), GetRandomInt(200, 1500))
endfunction

function AddWorkerMiner takes unit worker returns nothing
    local integer i = 0
    call AddWorker(worker)
    loop
        exitwhen (i == mineralResourcesCounter)
        call AddResourceToWorker(worker, mineralResources[i], 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 200, 20, "gold")
        set i = i + 1
    endloop
endfunction

function MinerPickup takes unit hero, item whichItem returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    if ((IsOre(itemTypeId) or IsGem(itemTypeId)) and UnitHasItemOfTypeBJ(hero, ITEM_PICKAXE)) then
        call SetItemCharges(whichItem, IMaxBJ(1, GetItemCharges(whichItem)) + 1)
    endif
endfunction

private function TriggerActionItemSpawn takes nothing returns nothing
    call MinerPickup(GetTriggerUnit(), GetTriggerRespawnItem())
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetSummonedUnit())
    if (unitTypeId == 'h0T9') then
        call AddWorkerMiner(GetSummonedUnit())
    elseif (unitTypeId == 'o08H') then
        call AddMinerMine(GetSummonedUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterItemRespawnStartsEvent(itemStartSpawnTrigger)
    call TriggerAddAction(itemStartSpawnTrigger, function TriggerActionItemSpawn)

    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))

    call AddOreItemTypeId(ITEM_ROCKS)
    call AddOreItemTypeId(ITEM_ORE_GOLD)
    call AddOreItemTypeId(ITEM_ORE_IRON)
    call AddOreItemTypeId(ITEM_ORE_SILVER)

    // do after initializing resources
    call AddMineralResource(udg_ResourceSilver)
    call AddMineralResource(udg_ResourceIron)
    call AddMineralResource(udg_ResourceRock)
    call AddMineralResource(udg_ResourceGemstones)
endfunction

endlibrary
