library ItemCarrierGroups initializer Init

/*
 * This system tries to improve the performance of UnitHasItemOfTypeBJ to check for specific item
 * types in a heroes inventory. For example, if you check on every unit attack or damage event
 * it can be very costly to loop through the whole inventory every time.
 * The system stores carriers for specific item type IDs does no loop on checking if a unit still
 * carries this item.
 */

globals
    private hashtable h = InitHashtable()
    private hashtable h2 = InitHashtable()
    private integer array itemTypeIds
    private integer itemTypeIdsCounter = 0
    private trigger pickupItemTrigger = CreateTrigger()
    private trigger dropItemTrigger = CreateTrigger()
endglobals

function AddItemCarrierGroup takes integer itemTypeId returns nothing
    call SaveGroupHandle(h, itemTypeId, 0, CreateGroup())
    set itemTypeIds[itemTypeIdsCounter] = itemTypeId
    set itemTypeIdsCounter = itemTypeIdsCounter + 1
endfunction

function HasItemCarrierGroup takes integer itemTypeId returns boolean
    return HaveSavedHandle(h, itemTypeId, 0)
endfunction

function LoadItemCarrierGroup takes integer itemTypeId returns group
    return LoadGroupHandle(h, itemTypeId, 0)
endfunction

function IsUnitInItemCarrierGroup takes unit whichUnit, integer itemTypeId returns boolean
    if (HasItemCarrierGroup(itemTypeId)) then
        return IsUnitInGroup(whichUnit, LoadItemCarrierGroup(itemTypeId))
    endif
    return false
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    local integer itemTypeId = GetItemTypeId(GetManipulatedItem())
    if (HasItemCarrierGroup(itemTypeId)) then
        call GroupAddUnit(LoadItemCarrierGroup(itemTypeId), GetTriggerUnit())
    endif
    return false
endfunction

private function TimerFunctionDropItem takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit carrier = LoadUnitHandle(h2, handleId, 0)
    local item whichItem = LoadItemHandle(h2, handleId, 1)
    local integer itemTypeId = GetItemTypeId(whichItem)

    if (GetUnitTypeId(carrier) != 0 and HasItemCarrierGroup(itemTypeId) and not UnitHasItemOfTypeBJ(carrier, itemTypeId)) then
        call GroupRemoveUnit(LoadItemCarrierGroup(itemTypeId), carrier)
    endif

    call FlushChildHashtable(h2, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function TimedDropItemAction takes unit hero, item whichItem returns nothing
    local timer t = CreateTimer()
    local integer handleId = GetHandleId(t)
    call SaveUnitHandle(h2, handleId, 0, hero)
    call SaveItemHandle(h2, handleId, 1, whichItem)
    call TimerStart(t, 0.0, false, function TimerFunctionDropItem)
endfunction

private function TriggerActionDropItem takes nothing returns nothing
    local item whichItem = GetManipulatedItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    local unit carrier = GetTriggerUnit()
    if (HasItemCarrierGroup(itemTypeId)) then
        call TimedDropItemAction(carrier, whichItem)
    endif
    set whichItem = null
    set carrier = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))

    call TriggerRegisterAnyUnitEventBJ(dropItemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(dropItemTrigger, function TriggerActionDropItem)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    local integer i = 0
    loop
        exitwhen (i == itemTypeIdsCounter)
        call GroupRemoveUnit(LoadItemCarrierGroup(itemTypeIds[i]), whichUnit)
        set i = i + 1
    endloop
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
