library ItemRespawn initializer Init

// Baradé's Item Respawn 1.2
//
// Allows picked up or destroyed items to respawn after some time.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Place some items on the map.
//
// API:
//
// function TriggerRegisterItemRespawnEvent takes trigger whichTrigger returns nothing
//
// Registers an item respawn event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any item is respawned by this system. You can access the triggering respawning item
// and index from the system via functions.
//
// function TriggerRegisterItemRespawnStartsEvent takes trigger whichTrigger returns nothing
//
// Registers an item respawn start event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any item respawn timer is started by this system. You can access the previously pickedup or destroyed item
// and index from the system via functions.
//
// function GetTriggerRespawnItem takes nothing returns item
//
// Returns the triggering respawned item from a trigger which was evaluated or executed due to a respawn event.
// Returns the triggering picked up previously respawned item if the event is a respawn starts event.
//
// function GetTriggerRespawnItemIndex takes nothing returns integer
//
// Returns the corresponding index of the item respawn from the respawned item or item for which the respawn timer has been started of the
// evaluated or executed trigger.
//
// function GetItemRespawnIndex takes item whichItem returns integer
//
// Returns the corresponding index of the item respawn matching the passed item. If there is none, it returns -1.
//
// function GetItemRespawnCounter takes nothing returns integer
//
// Returns the maximum number of item respawn indices. Note that not every index in between has to be valid. This function might help integer
// loops to go through all existing item respawns. Please use IsRespawnItemValid to check if an index in between 0 and the return value of
// this function is actually used.
//
// function IsRespawnItemValid takes integer index returns boolean
//
// Returns if the passed index belongs to a valid item respawn.
//
// function RespawnItem takes integer index returns boolean
//
// Respawns the item from the item respawn with the corresponding index. The index must be valid. Returns false if
// the passed index is not valid.
//
// function RespawnAllItems takes nothing returns nothing
//
// Respawns all items from all item respawns which have no item at the moment.
//
// function PauseAllRespawnItems takes nothing returns nothing
//
// function ResumeAllRespawnItems takes nothing returns nothing
//
// function StartItemRespawn takes integer index returns nothing
//
// Manually starts the respawn of an item respawn no matter if the item has not been picked up or destroyed yet.
//
// function AddRespawnItem takes item whichItem returns integer
//
// Creates a new item respawn for the specified item and returns the corresponding index.
//
// function AddRespawnItemPool takes itempool whichItemPool, real x, real y returns integer
//
// function AddRespawnItemRandom takes integer level, real x, real y returns integer
//
// function AddRespawnItemRandomEx takes itemtype whichType, integer level, real x, real y returns integer
//
// function RemoveRespawnItem takes integer index returns boolean
//
// function SetRespawnItemEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnItemEnabled takes integer index returns boolean
//
// function GetRespawnItemTimer takes integer index returns timer
//
// function GetRespawnItemType takes integer index returns integer
//
// function SetRespawnItemTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnItemTimeout takes integer index returns real
//
// function SetRespawnItemX takes integer index, real x returns nothing
//
// function GetRespawnItemX takes integer index returns real
//
// function SetRespawnItemY takes integer index, real y returns nothing
//
// function GetRespawnItemY takes integer index returns real
//
// function SetRespawnItem takes integer index, item whichItem returns nothing
//
// function GetRespawnItem takes integer index returns item
//
// function SetRespawnItemPool takes integer index, itempool whichItemPool returns nothing
//
// function GetRespawnItemPool takes integer index returns itempool
//
// function SetRespawnItemLevel takes integer index, integer level returns nothing
//
// function GetRespawnItemLevel takes integer index returns integer
//
// function SetRespawnItemItemType takes integer index, itemtype whichItemType returns nothing
//
// function GetRespawnItemItemType takes integer index returns itemtype

globals
    // The default delay until an item will be respawned.
    public constant real DEFAULT_TIMEOUT = 30.0
    // All preplaced items on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
    public constant boolean AUTO_ADD_ALL_PREPLACED_ITEMS = true

    public constant integer ITEM_RESPAWN_TYPE_ITEM = 0
    public constant integer ITEM_RESPAWN_TYPE_ITEMPOOL = 1
    public constant integer ITEM_RESPAWN_TYPE_RANDOM_LEVEL = 2
    public constant integer ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL = 3

    private integer respawnItemCounter = 0
    private integer respawnItemFreeIndex = 0
    private boolean array respawnItemIsValid
    private integer array respawnItemType
    private item array respawnItemItem
    private integer array respawnItemHandleId
    private integer array respawnItemItemTypeId
    private itempool array respawnItemPool
    private integer array respawnItemRandomLevel
    private itemtype array respawnItemRandomType
    private real array respawnItemX
    private real array respawnItemY
    private timer array respawnItemTimer
    private real array respawnItemTimeout
    private boolean array respawnItemEnabled
    private trigger array respawnItemDeathTrigger

    private integer callbackRespawnTriggersCounter = 0
    private trigger array callbackRespawnTriggers

    private integer callbackRespawnStartsTriggersCounter = 0
    private trigger array callbackRespawnStartsTriggers

    private item callbackItem = null
    private integer callbackIndex = -1

    private trigger pickupItemTrigger = CreateTrigger()
    private hashtable respawnItemHashTable = InitHashtable()
    private integer evaluateIndex = -1
    private trigger refreshEvaluateTrigger = CreateTrigger()
endglobals

function GetTriggerRespawnItem takes nothing returns item
    return callbackItem
endfunction

function GetTriggerRespawnItemIndex takes nothing returns integer
    return callbackIndex
endfunction

function TriggerRegisterItemRespawnEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnTriggersCounter
    set callbackRespawnTriggers[index] = whichTrigger
    set callbackRespawnTriggersCounter = callbackRespawnTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnTriggersCounter)
        if (IsTriggerEnabled(callbackRespawnTriggers[i])) then
            set callbackItem = respawnItemItem[index]
            set callbackIndex = index
            call ConditionalTriggerExecute(callbackRespawnTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function TriggerRegisterItemRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnStartsTriggersCounter
    set callbackRespawnStartsTriggers[index] = whichTrigger
    set callbackRespawnStartsTriggersCounter = callbackRespawnStartsTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnStartsTriggersCounter)
        if (IsTriggerEnabled(callbackRespawnStartsTriggers[i])) then
            set callbackItem = respawnItemItem[index]
            set callbackIndex = index
            call ConditionalTriggerExecute(callbackRespawnStartsTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ClearItemRespawnIndex takes integer handleID returns nothing
    if (HaveSavedInteger(respawnItemHashTable, handleID, 0)) then
        call FlushChildHashtable(respawnItemHashTable, handleID)
    endif
endfunction

private function GetItemRespawnIndexByHandleID takes integer handleID returns integer
    if (HaveSavedInteger(respawnItemHashTable, handleID, 0)) then
        return LoadInteger(respawnItemHashTable, handleID, 0)
    endif

    return -1
endfunction

function GetItemRespawnIndex takes item whichItem returns integer
    return GetItemRespawnIndexByHandleID(GetHandleId(whichItem))
endfunction

function GetItemRespawnCounter takes nothing returns integer
    return respawnItemCounter
endfunction

function IsRespawnItemValid takes integer index returns boolean
    if (index < 0) then
        return false
    endif
    return respawnItemIsValid[index]
endfunction

function RespawnItem takes integer index returns boolean
    if (not IsRespawnItemValid(index)) then
        return false
    endif
    if (respawnItemType[index] == ITEM_RESPAWN_TYPE_ITEM) then
        set respawnItemItem[index] = CreateItem(respawnItemItemTypeId[index], respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_ITEMPOOL) then
        set respawnItemItem[index] = PlaceRandomItem(respawnItemPool[index], respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_RANDOM_LEVEL) then
        set respawnItemItem[index] = CreateItem(ChooseRandomItem(respawnItemRandomLevel[index]), respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL) then
        set respawnItemItem[index] = CreateItem(ChooseRandomItemEx(respawnItemRandomType[index], respawnItemRandomLevel[index]), respawnItemX[index], respawnItemY[index])
    endif
    set respawnItemHandleId[index] = GetHandleId(respawnItemItem[index])
    call SaveInteger(respawnItemHashTable, respawnItemHandleId[index], 0, index)
    set evaluateIndex = index
    call TriggerEvaluate(refreshEvaluateTrigger)
    call EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllItems takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= respawnItemCounter)
        if (IsRespawnItemValid(i) and respawnItemItem[i] == null) then
            call RespawnItem(i)
        endif
        set i = i + 1
    endloop
endfunction

function PauseAllRespawnItems takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= respawnItemCounter)
        if (IsRespawnItemValid(i) and respawnItemItem[i] == null) then
            call PauseTimer(respawnItemTimer[i])
        endif
        set i = i + 1
    endloop
endfunction

function ResumeAllRespawnItems takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= respawnItemCounter)
        if (IsRespawnItemValid(i) and respawnItemItem[i] == null) then
            call ResumeTimer(respawnItemTimer[i])
        endif
        set i = i + 1
    endloop
endfunction

private function TimerFunctionRespawnItem takes nothing returns nothing
    local integer index = LoadInteger(respawnItemHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnItem(index)
endfunction

function StartItemRespawn takes integer index returns nothing
    call EvaluateAndExecuteCallbackRespawnStartsTriggers(index)

    if (respawnItemHandleId[index] != 0) then
        call ClearItemRespawnIndex(respawnItemHandleId[index])
    endif
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    call TimerStart(respawnItemTimer[index], respawnItemTimeout[index], false, function TimerFunctionRespawnItem)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local integer index = GetItemRespawnIndexByHandleID(GetHandleId(GetTriggerWidget()))
    call StartItemRespawn(index)
endfunction

private function RefreshDeathTrigger takes integer index returns nothing
    if (respawnItemDeathTrigger[index] != null) then
        call DestroyTrigger(respawnItemDeathTrigger[index])
        set respawnItemDeathTrigger[index] = null
    endif

    set respawnItemDeathTrigger[index] = CreateTrigger()
    call TriggerRegisterDeathEvent(respawnItemDeathTrigger[index], respawnItemItem[index])
    call TriggerAddAction(respawnItemDeathTrigger[index], function TriggerActionDeath)
endfunction

private function RefreshDeathTriggerEvaluate takes nothing returns boolean
    call RefreshDeathTrigger(evaluateIndex)
    return false
endfunction

private function AddRespawnItemDefault takes integer index, real x, real y returns nothing
    set respawnItemIsValid[index] = true
    set respawnItemX[index] = x
    set respawnItemY[index] = y
    set respawnItemTimer[index] = CreateTimer()
    set respawnItemTimeout[index] = DEFAULT_TIMEOUT
    call SaveInteger(respawnItemHashTable, GetHandleId(respawnItemTimer[index]), 0, index)
    set respawnItemEnabled[index] = true
    call RefreshDeathTrigger(index)

    loop
        set respawnItemFreeIndex = respawnItemFreeIndex + 1
        exitwhen (not IsRespawnItemValid(respawnItemFreeIndex))
    endloop

    if (index >= respawnItemCounter) then
        set respawnItemCounter = index + 1
    endif
endfunction

function AddRespawnItem takes item whichItem returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_ITEM
    set respawnItemItem[index] = whichItem
    set respawnItemHandleId[index] = GetHandleId(whichItem)
    set respawnItemItemTypeId[index] = GetItemTypeId(whichItem)
    set respawnItemPool[index] = null
    call AddRespawnItemDefault(index, GetItemX(whichItem), GetItemY(whichItem))

    call SaveInteger(respawnItemHashTable, respawnItemHandleId[index], 0, index)

    return index
endfunction

function AddRespawnItemPool takes itempool whichItemPool, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_ITEMPOOL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = whichItemPool
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandom takes integer level, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_RANDOM_LEVEL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = null
    set respawnItemRandomLevel[index] = level
    set respawnItemRandomType[index] = null
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandomEx takes itemtype whichType, integer level, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = null
    set respawnItemRandomLevel[index] = level
    set respawnItemRandomType[index] = whichType
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function RemoveRespawnItem takes integer index returns boolean
    if (IsRespawnItemValid(index)) then
        set respawnItemIsValid[index] = false

        if (respawnItemItem[index] != null) then
            call ClearItemRespawnIndex(GetHandleId(respawnItemItem[index]))
        endif

        set respawnItemTimeout[index] = 0
        set respawnItemType[index] = 0
        set respawnItemItem[index] = null
        set respawnItemHandleId[index] = 0
        set respawnItemItemTypeId[index] = 0
        set respawnItemPool[index] = null
        set respawnItemRandomLevel[index] = 0
        set respawnItemRandomType[index] = null

        call PauseTimer(respawnItemTimer[index])
        call FlushChildHashtable(respawnItemHashTable, GetHandleId(respawnItemTimer[index]))
        call DestroyTimer(respawnItemTimer[index])

        set respawnItemFreeIndex = index

        if (index == respawnItemCounter - 1) then
            set respawnItemCounter = respawnItemCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnItemEnabled takes integer index, boolean enabled returns nothing
    set respawnItemEnabled[index] = enabled
endfunction

function IsRespawnItemEnabled takes integer index returns boolean
    return respawnItemEnabled[index]
endfunction

function GetRespawnItemTimer takes integer index returns timer
    return respawnItemTimer[index]
endfunction

function GetRespawnItemType takes integer index returns integer
    return respawnItemType[index]
endfunction

function SetRespawnItemTimeout takes integer index, real timeout returns nothing
    set respawnItemTimeout[index] = timeout
endfunction

function GetRespawnItemTimeout takes integer index returns real
    return respawnItemTimeout[index]
endfunction

function SetRespawnItemX takes integer index, real x returns nothing
    set respawnItemX[index] = x
endfunction

function GetRespawnItemX takes integer index returns real
    return respawnItemX[index]
endfunction

function SetRespawnItemY takes integer index, real y returns nothing
    set respawnItemX[index] = y
endfunction

function GetRespawnItemY takes integer index returns real
    return respawnItemY[index]
endfunction

function SetRespawnItem takes integer index, item whichItem returns nothing
    set respawnItemItem[index] = whichItem
endfunction

function GetRespawnItem takes integer index returns item
    return respawnItemItem[index]
endfunction

function SetRespawnItemPool takes integer index, itempool whichItemPool returns nothing
    set respawnItemPool[index] = whichItemPool
endfunction

function GetRespawnItemPool takes integer index returns itempool
    return respawnItemPool[index]
endfunction

function SetRespawnItemLevel takes integer index, integer level returns nothing
    set respawnItemRandomLevel[index] = level
endfunction

function GetRespawnItemLevel takes integer index returns integer
    return respawnItemRandomLevel[index]
endfunction

function SetRespawnItemItemType takes integer index, itemtype whichItemType returns nothing
    set respawnItemRandomType[index] = whichItemType
endfunction

function GetRespawnItemItemType takes integer index returns itemtype
    return respawnItemRandomType[index]
endfunction

private function TriggerConditionRespawnItem takes nothing returns boolean
    local integer index = GetItemRespawnIndex(GetManipulatedItem())
    return IsRespawnItemValid(index) and IsRespawnItemEnabled(index)
endfunction

private function TriggerActionRespawnItem takes nothing returns nothing
    local integer index = GetItemRespawnIndex(GetManipulatedItem())
    call StartItemRespawn(index)
endfunction

private function AddEnumItem takes nothing returns nothing
    if (GetItemTypeId(GetEnumItem()) != DUNGEON_KEY) then
        call AddRespawnItem(GetEnumItem())
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionRespawnItem))
    call TriggerAddAction(pickupItemTrigger, function TriggerActionRespawnItem)

    call TriggerAddCondition(refreshEvaluateTrigger, Condition(function RefreshDeathTriggerEvaluate))

static if (AUTO_ADD_ALL_PREPLACED_ITEMS) then
    call EnumItemsInRect(GetPlayableMapRect(), null, function AddEnumItem)
endif
endfunction

private function RemoveItemCleanup takes item whichItem returns nothing
    local integer handleID = GetHandleId(whichItem)
    call ClearItemRespawnIndex(handleID)
endfunction

hook RemoveItem RemoveItemCleanup

// Change Log:
//
// 1.2 2025-04-18:
// - Add function PauseAllRespawnItems.
// - Add function ResumeAllRespawnItems.
// - Check for trigger conditions in callbacks.
//
// 1.1 2022-07-30:
// - Move system initializer into module to give it the highest priority possible.
// - Store item respawn index per item in a hashtable to improve the performance.
// - Add constant AUTO_ADD_ALL_PREPLACED_ITEMS which is true by default to automatically add all preplaced items.
// - Support item respawns from item pools, levels and types.
// - Support removing item respawns.
// - Support registering callbacks for respawn start events.
// - Add functions AddRespawnItemPool, AddRespawnItemRandom and AddRespawnItemRandomEx, RemoveRespawnItem, IsRespawnItemValid, TriggerRegisterItemRespawnStartsEvent and many setters and getters.
// - Add constants for the different types.
endlibrary
