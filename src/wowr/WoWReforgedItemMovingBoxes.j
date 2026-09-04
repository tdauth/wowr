library WoWReforgedItemMovingBoxes initializer Init requires ItemUtils, WoWReforgedRaces

globals
    private boolexpr filter = null
    private trigger spellCastTrigger = CreateTrigger()
    private player filterPlayer = null
endglobals

private function GetBuildingItemId takes integer unitTypeId returns integer
    return MapBuildingIDToItemID(unitTypeId, GetObjectRace(unitTypeId))
endfunction

private function FilterIsWrapableBuilding takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterPlayer and IsUnitAliveBJ(GetFilterUnit()) and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and GetBuildingItemId(GetUnitTypeId(GetFilterUnit())) != 0
endfunction

private function CancelAllOrdersInBuilding takes unit whichBuilding returns nothing
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

private function WrapUpAllBuildings takes unit caster, real x, real y returns integer
    local player whichPlayer = GetOwningPlayer(caster)
    local group allBuildings = CreateGroup()
    local integer counter = 0
    local integer i = 0
    local integer max = 0
    local integer j = 0
    local item whichItem = null
    local item array allItems
    local integer allItemsCounter = 0
    set filterPlayer = whichPlayer
    call GroupEnumUnitsInRange(allBuildings, x, y, 1024.0, filter)
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

private function WrapUpAllBuildingsInArea takes unit caster, real x, real y returns nothing
    local integer count = WrapUpAllBuildings(caster, x, y)
    if (count == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_WRAPABLE_BUILDINGS"))
    endif
endfunction

private function TriggerConditionSpellCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A18Z') then
        call WrapUpAllBuildingsInArea(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsWrapableBuilding)

    call TriggerRegisterAnyUnitEventBJ(spellCastTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(spellCastTrigger, Condition(function TriggerConditionSpellCast))
endfunction

endlibrary

