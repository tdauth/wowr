library MaxItemStacks initializer Init
// Baradé's Max Item Stacks System 1.1
//
// Supports the missing Warcraft III feature of calculating the value of 'ista' per item type ID.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Use the function GetMaxStacksByItemTypeId to get the value of 'ista' per item type ID.
//
// Download:
// https://www.hiveworkshop.com/threads/barad%C3%A9s-item-unstack-system-1-1.339109/

globals
    // This dummy is created and hidden once only if CHECK_MAX_STACKS is set to true. It requires an inventory with at least 2 slots.
    private constant integer DUMMY_UNIT_TYPE_MAX_CHECKS = MAX_ITEM_STACKS_DUMMY_HERO
    // Warcraft III has a limit of number of stacks for the field "Stats - Max Stacks" ('ista').
    private constant integer MAX_STACKS_ALLOWED = 1000
    private constant real DUMMY_X = 0.0
    private constant real DUMMY_Y = 0.0

    private integer stackCounter = 0
    private hashtable stackHashTable = InitHashtable()
    private unit stackItemDummy = null
    private trigger stackItemTrigger = CreateTrigger()
endglobals

public function GetStackItemDummy takes nothing returns unit
    return stackItemDummy
endfunction

function GetMaxStacksByItemTypeIdFresh takes integer itemTypeId returns integer
    local integer i = 0
    local item tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
    set stackCounter = 1
    call SetItemCharges(tmpItem, 1)
    call UnitAddItem(stackItemDummy, tmpItem)
    set i = 1
    loop
        set tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
        call SetItemCharges(tmpItem, 1)
        call UnitAddItem(stackItemDummy, tmpItem)
        exitwhen (stackCounter <= i)
        set i = i + 1
        exitwhen (i >= MAX_STACKS_ALLOWED)
    endloop
    if (UnitItemInSlot(stackItemDummy, 0) != null) then
        call RemoveItem(UnitItemInSlot(stackItemDummy, 0))
    endif
    if (UnitItemInSlot(stackItemDummy, 1) != null) then
        call RemoveItem(UnitItemInSlot(stackItemDummy, 1))
    endif
    call SaveInteger(stackHashTable, itemTypeId, 0, stackCounter)
    return stackCounter
endfunction

function GetMaxStacksByItemTypeId takes integer itemTypeId returns integer
    if (HaveSavedInteger(stackHashTable, itemTypeId, 0)) then
        return LoadInteger(stackHashTable, itemTypeId, 0)
    endif
    
    return GetMaxStacksByItemTypeIdFresh(itemTypeId)
endfunction

private function TriggerConditionStack takes nothing returns boolean
    set stackCounter = stackCounter + 1
    return false
endfunction

private function Init takes nothing returns nothing
    set stackItemDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), DUMMY_UNIT_TYPE_MAX_CHECKS, DUMMY_X, DUMMY_Y, 0.0)
    call SetUnitInvulnerable(stackItemDummy, true)
    if (IsUnitType(stackItemDummy, UNIT_TYPE_HERO)) then
        call SuspendHeroXP(stackItemDummy, true)
    endif
    call SetUnitUseFood(stackItemDummy, false)
    call ShowUnit(stackItemDummy, false)
    call BlzSetUnitWeaponBooleanField(stackItemDummy, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0, false)
    call BlzSetUnitWeaponBooleanField(stackItemDummy, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1, false)
    call SetUnitPathing(stackItemDummy, false)
    call SetUnitMoveSpeed(stackItemDummy, 0.0)
    call TriggerRegisterUnitEvent(stackItemTrigger, stackItemDummy, EVENT_UNIT_STACK_ITEM)
    call TriggerAddCondition(stackItemTrigger, Condition(function TriggerConditionStack))
endfunction

// Change Log:
//
// 1.1 2022-12-18:
// - Add function GetMaxStacksByItemTypeIdFresh to move locals and allow avoiding caching.
endlibrary
