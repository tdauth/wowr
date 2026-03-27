library WoWReforgedWrapUp initializer Init requires ItemUtils, WoWReforgedRaces

globals
    private trigger constructionTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private group constructedBuildings = CreateGroup()
    private player tmpPlayer = null
endglobals

function GetBuildingItemId takes integer unitTypeId returns integer
    return MapBuildingIDToItemID(unitTypeId, GetObjectRace(unitTypeId))
endfunction

function FilterIsWrapableBuilding takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local boolean result = GetOwningPlayer(filterUnit) == tmpPlayer and (not IsUnitType(filterUnit, UNIT_TYPE_STRUCTURE) or IsUnitInGroup(filterUnit, constructedBuildings)) and GetBuildingItemId(GetUnitTypeId(filterUnit)) != 0
    set filterUnit = null
    return result
endfunction

function CancelAllOrdersInBuilding takes unit whichBuilding returns nothing
    local integer i = 0
    loop
        exitwhen (i == 8) // all slots
        call IssueImmediateOrderById(whichBuilding, 851976)
        set i = i + 1
    endloop
endfunction

function WrapUpBuilding takes real x, real y, unit source returns item
    local integer unitTypeId = GetUnitTypeId(source)
    local integer itemTypeId = GetBuildingItemId(unitTypeId)
    local item whichItem = null
    if (itemTypeId != 0) then
        set whichItem = CreateItem(itemTypeId, x, y)
        call SetItemCharges(whichItem, 1)
        call IssueImmediateOrder(source, "stop")
        call DropAllItemsFromHero(source)
        call CancelAllOrdersInBuilding(source)
        call UnitRemoveAbility(source, 'A0NY') // Spawn Fire Elementals
        call KillUnit(source) // kill to unload units etc.
    endif

    return whichItem
endfunction

function WrapUpAllBuildings takes unit caster, real x, real y returns integer
    local player whichPlayer = GetOwningPlayer(caster)
    local group allBuildings = CreateGroup()
    local integer counter = 0
    local integer i = 0
    local integer max = 0
    local integer j = 0
    local item whichItem = null
    local item array allItems
    local integer allItemsCounter = 0
    set tmpPlayer = whichPlayer
    call GroupEnumUnitsInRange(allBuildings, x, y, 1024.0, Filter(function FilterIsWrapableBuilding))
    set max = BlzGroupGetSize(allBuildings)
    loop
        exitwhen (i == max)
        set whichItem = WrapUpBuilding(GetUnitX(caster), GetUnitY(caster), BlzGroupUnitAt(allBuildings, i))
        if (whichItem != null) then
            set counter = counter + 1
            call UnitAddItem(caster, whichItem)
            set allItems[allItemsCounter] = whichItem
            set allItemsCounter = allItemsCounter + 1
        endif
        set whichItem = null
        set i = i + 1
    endloop
    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null
    set whichPlayer = null
    
    // group all items of the same type
    set i = 0
    set max = allItemsCounter
    loop
        exitwhen (i == allItemsCounter)
        if (allItems[i] != null) then
            set j = i + 1
            loop
                exitwhen (j >= allItemsCounter)
                if (allItems[j] != null and GetItemCharges(allItems[i]) < 100 and GetItemTypeId(allItems[i]) == GetItemTypeId(allItems[j])) then
                    call SetItemCharges(allItems[i], IMaxBJ(GetItemCharges(allItems[i]), 1) + IMaxBJ(GetItemCharges(allItems[j]), 1))
                    call RemoveItem(allItems[j])
                    set allItems[j] = null
                endif
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop

    return counter
endfunction

private function TriggerActionConstructed takes nothing returns nothing
    call GroupAddUnit(constructedBuildings, GetConstructedStructure())
endfunction

private function TriggerConditionIsConstructed takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), constructedBuildings)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    call GroupRemoveUnit(constructedBuildings, GetTriggerUnit())
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddAction(constructionTrigger, function TriggerActionConstructed)
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionIsConstructed))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
endfunction

private function HookRemoveConstructedBuilding takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, constructedBuildings)) then
        call GroupRemoveUnit(constructedBuildings, whichUnit)
    endif
endfunction

hook RemoveUnit HookRemoveConstructedBuilding

endlibrary
