globals
//globals from ItemRespawn:
constant boolean LIBRARY_ItemRespawn=true
    // The default delay until an item will be respawned.
constant real ItemRespawn_DEFAULT_TIMEOUT= 30.0
    // All preplaced items on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
constant boolean ItemRespawn_AUTO_ADD_ALL_PREPLACED_ITEMS= true

constant integer ItemRespawn_ITEM_RESPAWN_TYPE_ITEM= 0
constant integer ItemRespawn_ITEM_RESPAWN_TYPE_ITEMPOOL= 1
constant integer ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_LEVEL= 2
constant integer ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL= 3

integer ItemRespawn___respawnItemCounter= 0
integer ItemRespawn___respawnItemFreeIndex= 0
boolean array ItemRespawn___respawnItemIsValid
integer array ItemRespawn___respawnItemType
item array ItemRespawn___respawnItemItem
integer array ItemRespawn___respawnItemHandleId
integer array ItemRespawn___respawnItemItemTypeId
itempool array ItemRespawn___respawnItemPool
integer array ItemRespawn___respawnItemRandomLevel
itemtype array ItemRespawn___respawnItemRandomType
real array ItemRespawn___respawnItemX
real array ItemRespawn___respawnItemY
timer array ItemRespawn___respawnItemTimer
real array ItemRespawn___respawnItemTimeout
boolean array ItemRespawn___respawnItemEnabled
trigger array ItemRespawn___respawnItemDeathTrigger

integer ItemRespawn___callbackRespawnTriggersCounter= 0
trigger array ItemRespawn___callbackRespawnTriggers

integer ItemRespawn___callbackRespawnStartsTriggersCounter= 0
trigger array ItemRespawn___callbackRespawnStartsTriggers

item ItemRespawn___callbackItem= null
integer ItemRespawn___callbackIndex= - 1

trigger ItemRespawn___pickupItemTrigger= CreateTrigger()
hashtable ItemRespawn___respawnItemHashTable= InitHashtable()
integer ItemRespawn___evaluateIndex= - 1
trigger ItemRespawn___refreshEvaluateTrigger= CreateTrigger()
//endglobals from ItemRespawn
    // Generated
rect gg_rct_Item_Level_Respawn= null
rect gg_rct_Item_Pool_Respawn= null
rect gg_rct_Item_Type_and_Level_Respawn= null
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Item_Respawn= null
trigger gg_trg_Item_Respawn_Starts= null
trigger gg_trg_Inite_Respawn_Callbacks= null
trigger gg_trg_Init_Respawning_Items_Extended= null
unit gg_unit_Hpal_0000= null
unit gg_unit_Hpal_0029= null

trigger l__library_init

//JASSHelper struct globals:
trigger array st___prototype25
item f__arg_item1

endglobals

function sc___prototype25_execute takes integer i,item a1 returns nothing
    set f__arg_item1=a1

    call TriggerExecute(st___prototype25[i])
endfunction
function sc___prototype25_evaluate takes integer i,item a1 returns nothing
    set f__arg_item1=a1

    call TriggerEvaluate(st___prototype25[i])

endfunction
function h__RemoveItem takes item a0 returns nothing
    //hook: ItemRespawn___RemoveItemCleanup
    call sc___prototype25_evaluate(1,a0)
call RemoveItem(a0)
endfunction

//library ItemRespawn:

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


function GetTriggerRespawnItem takes nothing returns item
    return ItemRespawn___callbackItem
endfunction

function GetTriggerRespawnItemIndex takes nothing returns integer
    return ItemRespawn___callbackIndex
endfunction

function TriggerRegisterItemRespawnEvent takes trigger whichTrigger returns nothing
    local integer index= ItemRespawn___callbackRespawnTriggersCounter
    set ItemRespawn___callbackRespawnTriggers[index]=whichTrigger
    set ItemRespawn___callbackRespawnTriggersCounter=ItemRespawn___callbackRespawnTriggersCounter + 1
endfunction

function ItemRespawn___EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= ItemRespawn___callbackRespawnTriggersCounter )
        if ( IsTriggerEnabled(ItemRespawn___callbackRespawnTriggers[i]) ) then
            set ItemRespawn___callbackItem=ItemRespawn___respawnItemItem[index]
            set ItemRespawn___callbackIndex=index
            call ConditionalTriggerExecute(ItemRespawn___callbackRespawnTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function TriggerRegisterItemRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index= ItemRespawn___callbackRespawnStartsTriggersCounter
    set ItemRespawn___callbackRespawnStartsTriggers[index]=whichTrigger
    set ItemRespawn___callbackRespawnStartsTriggersCounter=ItemRespawn___callbackRespawnStartsTriggersCounter + 1
endfunction

function ItemRespawn___EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= ItemRespawn___callbackRespawnStartsTriggersCounter )
        if ( IsTriggerEnabled(ItemRespawn___callbackRespawnStartsTriggers[i]) ) then
            set ItemRespawn___callbackItem=ItemRespawn___respawnItemItem[index]
            set ItemRespawn___callbackIndex=index
            call ConditionalTriggerExecute(ItemRespawn___callbackRespawnStartsTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function ItemRespawn___ClearItemRespawnIndex takes integer handleID returns nothing
    if ( HaveSavedInteger(ItemRespawn___respawnItemHashTable, handleID, 0) ) then
        call FlushChildHashtable(ItemRespawn___respawnItemHashTable, handleID)
    endif
endfunction

function ItemRespawn___GetItemRespawnIndexByHandleID takes integer handleID returns integer
    if ( HaveSavedInteger(ItemRespawn___respawnItemHashTable, handleID, 0) ) then
        return LoadInteger(ItemRespawn___respawnItemHashTable, handleID, 0)
    endif

    return - 1
endfunction

function GetItemRespawnIndex takes item whichItem returns integer
    return ItemRespawn___GetItemRespawnIndexByHandleID(GetHandleId(whichItem))
endfunction

function GetItemRespawnCounter takes nothing returns integer
    return ItemRespawn___respawnItemCounter
endfunction

function IsRespawnItemValid takes integer index returns boolean
    if ( index < 0 ) then
        return false
    endif
    return ItemRespawn___respawnItemIsValid[index]
endfunction

function RespawnItem takes integer index returns boolean
    if ( not IsRespawnItemValid(index) ) then
        return false
    endif
    if ( ItemRespawn___respawnItemType[index] == ItemRespawn_ITEM_RESPAWN_TYPE_ITEM ) then
        set ItemRespawn___respawnItemItem[index]=CreateItem(ItemRespawn___respawnItemItemTypeId[index], ItemRespawn___respawnItemX[index], ItemRespawn___respawnItemY[index])
    elseif ( ItemRespawn___respawnItemType[index] == ItemRespawn_ITEM_RESPAWN_TYPE_ITEMPOOL ) then
        set ItemRespawn___respawnItemItem[index]=PlaceRandomItem(ItemRespawn___respawnItemPool[index], ItemRespawn___respawnItemX[index], ItemRespawn___respawnItemY[index])
    elseif ( ItemRespawn___respawnItemType[index] == ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_LEVEL ) then
        set ItemRespawn___respawnItemItem[index]=CreateItem(ChooseRandomItem(ItemRespawn___respawnItemRandomLevel[index]), ItemRespawn___respawnItemX[index], ItemRespawn___respawnItemY[index])
    elseif ( ItemRespawn___respawnItemType[index] == ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL ) then
        set ItemRespawn___respawnItemItem[index]=CreateItem(ChooseRandomItemEx(ItemRespawn___respawnItemRandomType[index], ItemRespawn___respawnItemRandomLevel[index]), ItemRespawn___respawnItemX[index], ItemRespawn___respawnItemY[index])
    endif
    set ItemRespawn___respawnItemHandleId[index]=GetHandleId(ItemRespawn___respawnItemItem[index])
    call SaveInteger(ItemRespawn___respawnItemHashTable, ItemRespawn___respawnItemHandleId[index], 0, index)
    set ItemRespawn___evaluateIndex=index
    call TriggerEvaluate(ItemRespawn___refreshEvaluateTrigger)
    call ItemRespawn___EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllItems takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= ItemRespawn___respawnItemCounter )
        if ( IsRespawnItemValid(i) and ItemRespawn___respawnItemItem[i] == null ) then
            call RespawnItem(i)
        endif
        set i=i + 1
    endloop
endfunction

function PauseAllRespawnItems takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= ItemRespawn___respawnItemCounter )
        if ( IsRespawnItemValid(i) and ItemRespawn___respawnItemItem[i] == null ) then
            call PauseTimer(ItemRespawn___respawnItemTimer[i])
        endif
        set i=i + 1
    endloop
endfunction

function ResumeAllRespawnItems takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= ItemRespawn___respawnItemCounter )
        if ( IsRespawnItemValid(i) and ItemRespawn___respawnItemItem[i] == null ) then
            call ResumeTimer(ItemRespawn___respawnItemTimer[i])
        endif
        set i=i + 1
    endloop
endfunction

function ItemRespawn___TimerFunctionRespawnItem takes nothing returns nothing
    local integer index= LoadInteger(ItemRespawn___respawnItemHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnItem(index)
endfunction

function StartItemRespawn takes integer index returns nothing
    call ItemRespawn___EvaluateAndExecuteCallbackRespawnStartsTriggers(index)

    if ( ItemRespawn___respawnItemHandleId[index] != 0 ) then
        call ItemRespawn___ClearItemRespawnIndex(ItemRespawn___respawnItemHandleId[index])
    endif
    set ItemRespawn___respawnItemItem[index]=null
    set ItemRespawn___respawnItemHandleId[index]=0
    call TimerStart(ItemRespawn___respawnItemTimer[index], ItemRespawn___respawnItemTimeout[index], false, function ItemRespawn___TimerFunctionRespawnItem)
endfunction

function ItemRespawn___TriggerActionDeath takes nothing returns nothing
    local integer index= ItemRespawn___GetItemRespawnIndexByHandleID(GetHandleId(GetTriggerWidget()))
    call StartItemRespawn(index)
endfunction

function ItemRespawn___RefreshDeathTrigger takes integer index returns nothing
    if ( ItemRespawn___respawnItemDeathTrigger[index] != null ) then
        call DestroyTrigger(ItemRespawn___respawnItemDeathTrigger[index])
        set ItemRespawn___respawnItemDeathTrigger[index]=null
    endif

    set ItemRespawn___respawnItemDeathTrigger[index]=CreateTrigger()
    call TriggerRegisterDeathEvent(ItemRespawn___respawnItemDeathTrigger[index], ItemRespawn___respawnItemItem[index])
    call TriggerAddAction(ItemRespawn___respawnItemDeathTrigger[index], function ItemRespawn___TriggerActionDeath)
endfunction

function ItemRespawn___RefreshDeathTriggerEvaluate takes nothing returns boolean
    call ItemRespawn___RefreshDeathTrigger(ItemRespawn___evaluateIndex)
    return false
endfunction

function ItemRespawn___AddRespawnItemDefault takes integer index,real x,real y returns nothing
    set ItemRespawn___respawnItemIsValid[index]=true
    set ItemRespawn___respawnItemX[index]=x
    set ItemRespawn___respawnItemY[index]=y
    set ItemRespawn___respawnItemTimer[index]=CreateTimer()
    set ItemRespawn___respawnItemTimeout[index]=ItemRespawn_DEFAULT_TIMEOUT
    call SaveInteger(ItemRespawn___respawnItemHashTable, GetHandleId(ItemRespawn___respawnItemTimer[index]), 0, index)
    set ItemRespawn___respawnItemEnabled[index]=true
    call ItemRespawn___RefreshDeathTrigger(index)

    loop
        set ItemRespawn___respawnItemFreeIndex=ItemRespawn___respawnItemFreeIndex + 1
        exitwhen ( not IsRespawnItemValid(ItemRespawn___respawnItemFreeIndex) )
    endloop

    if ( index >= ItemRespawn___respawnItemCounter ) then
        set ItemRespawn___respawnItemCounter=index + 1
    endif
endfunction

function AddRespawnItem takes item whichItem returns integer
    local integer index= ItemRespawn___respawnItemFreeIndex
    set ItemRespawn___respawnItemType[index]=ItemRespawn_ITEM_RESPAWN_TYPE_ITEM
    set ItemRespawn___respawnItemItem[index]=whichItem
    set ItemRespawn___respawnItemHandleId[index]=GetHandleId(whichItem)
    set ItemRespawn___respawnItemItemTypeId[index]=GetItemTypeId(whichItem)
    set ItemRespawn___respawnItemPool[index]=null
    call ItemRespawn___AddRespawnItemDefault(index , GetItemX(whichItem) , GetItemY(whichItem))

    call SaveInteger(ItemRespawn___respawnItemHashTable, ItemRespawn___respawnItemHandleId[index], 0, index)

    return index
endfunction

function AddRespawnItemPool takes itempool whichItemPool,real x,real y returns integer
    local integer index= ItemRespawn___respawnItemFreeIndex
    set ItemRespawn___respawnItemType[index]=ItemRespawn_ITEM_RESPAWN_TYPE_ITEMPOOL
    set ItemRespawn___respawnItemItem[index]=null
    set ItemRespawn___respawnItemHandleId[index]=0
    set ItemRespawn___respawnItemItemTypeId[index]=0
    set ItemRespawn___respawnItemPool[index]=whichItemPool
    call ItemRespawn___AddRespawnItemDefault(index , x , y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandom takes integer level,real x,real y returns integer
    local integer index= ItemRespawn___respawnItemFreeIndex
    set ItemRespawn___respawnItemType[index]=ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_LEVEL
    set ItemRespawn___respawnItemItem[index]=null
    set ItemRespawn___respawnItemHandleId[index]=0
    set ItemRespawn___respawnItemItemTypeId[index]=0
    set ItemRespawn___respawnItemPool[index]=null
    set ItemRespawn___respawnItemRandomLevel[index]=level
    set ItemRespawn___respawnItemRandomType[index]=null
    call ItemRespawn___AddRespawnItemDefault(index , x , y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandomEx takes itemtype whichType,integer level,real x,real y returns integer
    local integer index= ItemRespawn___respawnItemFreeIndex
    set ItemRespawn___respawnItemType[index]=ItemRespawn_ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL
    set ItemRespawn___respawnItemItem[index]=null
    set ItemRespawn___respawnItemHandleId[index]=0
    set ItemRespawn___respawnItemItemTypeId[index]=0
    set ItemRespawn___respawnItemPool[index]=null
    set ItemRespawn___respawnItemRandomLevel[index]=level
    set ItemRespawn___respawnItemRandomType[index]=whichType
    call ItemRespawn___AddRespawnItemDefault(index , x , y)

    call RespawnItem(index)

    return index
endfunction

function RemoveRespawnItem takes integer index returns boolean
    if ( IsRespawnItemValid(index) ) then
        set ItemRespawn___respawnItemIsValid[index]=false

        if ( ItemRespawn___respawnItemItem[index] != null ) then
            call ItemRespawn___ClearItemRespawnIndex(GetHandleId(ItemRespawn___respawnItemItem[index]))
        endif

        set ItemRespawn___respawnItemTimeout[index]=0
        set ItemRespawn___respawnItemType[index]=0
        set ItemRespawn___respawnItemItem[index]=null
        set ItemRespawn___respawnItemHandleId[index]=0
        set ItemRespawn___respawnItemItemTypeId[index]=0
        set ItemRespawn___respawnItemPool[index]=null
        set ItemRespawn___respawnItemRandomLevel[index]=0
        set ItemRespawn___respawnItemRandomType[index]=null

        call PauseTimer(ItemRespawn___respawnItemTimer[index])
        call FlushChildHashtable(ItemRespawn___respawnItemHashTable, GetHandleId(ItemRespawn___respawnItemTimer[index]))
        call DestroyTimer(ItemRespawn___respawnItemTimer[index])

        set ItemRespawn___respawnItemFreeIndex=index

        if ( index == ItemRespawn___respawnItemCounter - 1 ) then
            set ItemRespawn___respawnItemCounter=ItemRespawn___respawnItemCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnItemEnabled takes integer index,boolean enabled returns nothing
    set ItemRespawn___respawnItemEnabled[index]=enabled
endfunction

function IsRespawnItemEnabled takes integer index returns boolean
    return ItemRespawn___respawnItemEnabled[index]
endfunction

function GetRespawnItemTimer takes integer index returns timer
    return ItemRespawn___respawnItemTimer[index]
endfunction

function GetRespawnItemType takes integer index returns integer
    return ItemRespawn___respawnItemType[index]
endfunction

function SetRespawnItemTimeout takes integer index,real timeout returns nothing
    set ItemRespawn___respawnItemTimeout[index]=timeout
endfunction

function GetRespawnItemTimeout takes integer index returns real
    return ItemRespawn___respawnItemTimeout[index]
endfunction

function SetRespawnItemX takes integer index,real x returns nothing
    set ItemRespawn___respawnItemX[index]=x
endfunction

function GetRespawnItemX takes integer index returns real
    return ItemRespawn___respawnItemX[index]
endfunction

function SetRespawnItemY takes integer index,real y returns nothing
    set ItemRespawn___respawnItemX[index]=y
endfunction

function GetRespawnItemY takes integer index returns real
    return ItemRespawn___respawnItemY[index]
endfunction

function SetRespawnItem takes integer index,item whichItem returns nothing
    set ItemRespawn___respawnItemItem[index]=whichItem
endfunction

function GetRespawnItem takes integer index returns item
    return ItemRespawn___respawnItemItem[index]
endfunction

function SetRespawnItemPool takes integer index,itempool whichItemPool returns nothing
    set ItemRespawn___respawnItemPool[index]=whichItemPool
endfunction

function GetRespawnItemPool takes integer index returns itempool
    return ItemRespawn___respawnItemPool[index]
endfunction

function SetRespawnItemLevel takes integer index,integer level returns nothing
    set ItemRespawn___respawnItemRandomLevel[index]=level
endfunction

function GetRespawnItemLevel takes integer index returns integer
    return ItemRespawn___respawnItemRandomLevel[index]
endfunction

function SetRespawnItemItemType takes integer index,itemtype whichItemType returns nothing
    set ItemRespawn___respawnItemRandomType[index]=whichItemType
endfunction

function GetRespawnItemItemType takes integer index returns itemtype
    return ItemRespawn___respawnItemRandomType[index]
endfunction

function ItemRespawn___TriggerConditionRespawnItem takes nothing returns boolean
    local integer index= (ItemRespawn___GetItemRespawnIndexByHandleID(GetHandleId((GetManipulatedItem())))) // INLINED!!
    return IsRespawnItemValid(index) and (ItemRespawn___respawnItemEnabled[(index)]) // INLINED!!
endfunction

function ItemRespawn___TriggerActionRespawnItem takes nothing returns nothing
    local integer index= (ItemRespawn___GetItemRespawnIndexByHandleID(GetHandleId((GetManipulatedItem())))) // INLINED!!
    call StartItemRespawn(index)
endfunction

function ItemRespawn___AddEnumItem takes nothing returns nothing
    call AddRespawnItem(GetEnumItem())
endfunction

function ItemRespawn___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(ItemRespawn___pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(ItemRespawn___pickupItemTrigger, Condition(function ItemRespawn___TriggerConditionRespawnItem))
    call TriggerAddAction(ItemRespawn___pickupItemTrigger, function ItemRespawn___TriggerActionRespawnItem)

    call TriggerAddCondition(ItemRespawn___refreshEvaluateTrigger, Condition(function ItemRespawn___RefreshDeathTriggerEvaluate))


    call EnumItemsInRect(GetPlayableMapRect(), null, function ItemRespawn___AddEnumItem)

endfunction

function ItemRespawn___RemoveItemCleanup takes item whichItem returns nothing
    local integer handleID= GetHandleId(whichItem)
    call ItemRespawn___ClearItemRespawnIndex(handleID)
endfunction

//processed hook: hook RemoveItem ItemRespawn___RemoveItemCleanup

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

//library ItemRespawn ends
//===========================================================================
// 
// Baradé's Item Respawn System 1.2
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: Baradé
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades Item Respawn


//***************************************************************************
//*
//*  Items
//*
//***************************************************************************

function CreateAllItems takes nothing returns nothing
    local integer itemID

    call BlzCreateItemWithSkin('hlst', - 838.2, 50.6, 'hlst')
    call BlzCreateItemWithSkin('hlst', - 957.4, - 71.4, 'hlst')
    call BlzCreateItemWithSkin('hlst', - 953.0, 172.2, 'hlst')
    call BlzCreateItemWithSkin('hlst', - 841.8, 175.9, 'hlst')
    call BlzCreateItemWithSkin('hlst', - 958.0, 51.4, 'hlst')
    call BlzCreateItemWithSkin('hlst', 232.1, - 393.8, 'hlst')
    call BlzCreateItemWithSkin('hlst', 171.9, - 388.9, 'hlst')
    call BlzCreateItemWithSkin('hlst', 229.2, - 304.7, 'hlst')
    call BlzCreateItemWithSkin('hlst', 24.0, - 305.9, 'hlst')
    call BlzCreateItemWithSkin('hlst', 96.3, - 304.7, 'hlst')
    call BlzCreateItemWithSkin('hlst', 27.3, - 389.5, 'hlst')
    call BlzCreateItemWithSkin('hlst', 104.8, - 383.0, 'hlst')
    call BlzCreateItemWithSkin('hlst', 162.7, - 302.5, 'hlst')
    call BlzCreateItemWithSkin('hlst', - 830.0, - 69.1, 'hlst')
    call BlzCreateItemWithSkin('pghe', - 219.4, - 386.0, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 283.8, - 383.7, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 362.3, - 380.3, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 147.2, - 315.5, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 359.4, - 297.4, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 216.2, - 307.0, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 284.2, - 302.2, 'pghe')
    call BlzCreateItemWithSkin('pghe', - 150.2, - 386.0, 'pghe')
    call BlzCreateItemWithSkin('ratf', - 708.6, - 284.3, 'ratf')
    call BlzCreateItemWithSkin('ratf', - 709.5, - 358.0, 'ratf')
    call BlzCreateItemWithSkin('ratf', - 538.5, - 292.3, 'ratf')
    call BlzCreateItemWithSkin('ratf', - 612.4, - 290.0, 'ratf')
    call BlzCreateItemWithSkin('ratf', - 542.4, - 368.9, 'ratf')
    call BlzCreateItemWithSkin('ratf', - 617.3, - 362.4, 'ratf')
    call BlzCreateItemWithSkin('tst2', 709.7, - 67.8, 'tst2')
    call BlzCreateItemWithSkin('tst2', 573.4, - 329.7, 'tst2')
    call BlzCreateItemWithSkin('tst2', 716.3, - 340.8, 'tst2')
    call BlzCreateItemWithSkin('tst2', 569.7, - 74.1, 'tst2')
    call BlzCreateItemWithSkin('tst2', 705.6, 63.0, 'tst2')
    call BlzCreateItemWithSkin('tst2', 567.7, 56.8, 'tst2')
    call BlzCreateItemWithSkin('tst2', 721.1, - 205.3, 'tst2')
    call BlzCreateItemWithSkin('tst2', 575.9, - 206.8, 'tst2')
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0000=BlzCreateUnitWithSkin(p, 'Hpal', - 325.6, - 88.6, 270.000, 'Hpal')
    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 329.0, 21.6, 270.000, 'hfoo')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0029=BlzCreateUnitWithSkin(p, 'Hpal', - 192.5, - 76.6, 270.000, 'Hpal')
    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 198.0, 16.8, 270.000, 'hfoo')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ngme', 128.0, 0.0, 270.000, 'ngme')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_Item_Level_Respawn=Rect(- 448.0, 512.0, - 416.0, 544.0)
    set gg_rct_Item_Pool_Respawn=Rect(- 992.0, - 288.0, - 960.0, - 256.0)
    set gg_rct_Item_Type_and_Level_Respawn=Rect(32.0, 512.0, 64.0, 544.0)
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func002A takes nothing returns nothing
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call SetPlayerTechResearchedSwap('Rhpm', 1, GetEnumPlayer())
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func002A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_014")
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0000, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0029, Player(1))
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Item Respawn
//===========================================================================
function Trig_Item_Respawn_Actions takes nothing returns nothing
    call PingMinimapLocForForce(GetPlayersAll(), GetItemLoc((ItemRespawn___callbackItem)), 2.00) // INLINED!!
    call DestroyEffect(AddSpecialEffectLocBJ(GetItemLoc((ItemRespawn___callbackItem)), "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl")) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Item_Respawn takes nothing returns nothing
    set gg_trg_Item_Respawn=CreateTrigger()
    call TriggerAddAction(gg_trg_Item_Respawn, function Trig_Item_Respawn_Actions)
endfunction

//===========================================================================
// Trigger: Item Respawn Starts
//===========================================================================
function Trig_Item_Respawn_Starts_Actions takes nothing returns nothing
    call DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), ( "Picked up respawning item " + ( GetItemName((ItemRespawn___callbackItem)) + "!" ) )) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Item_Respawn_Starts takes nothing returns nothing
    set gg_trg_Item_Respawn_Starts=CreateTrigger()
    call TriggerAddAction(gg_trg_Item_Respawn_Starts, function Trig_Item_Respawn_Starts_Actions)
endfunction

//===========================================================================
// Trigger: Inite Respawn Callbacks
//===========================================================================
function Trig_Inite_Respawn_Callbacks_Actions takes nothing returns nothing
    call TriggerRegisterItemRespawnEvent(gg_trg_Item_Respawn)
    call TriggerRegisterItemRespawnStartsEvent(gg_trg_Item_Respawn_Starts)
endfunction

//===========================================================================
function InitTrig_Inite_Respawn_Callbacks takes nothing returns nothing
    set gg_trg_Inite_Respawn_Callbacks=CreateTrigger()
    call TriggerAddAction(gg_trg_Inite_Respawn_Callbacks, function Trig_Inite_Respawn_Callbacks_Actions)
endfunction

//===========================================================================
// Trigger: Init Respawning Items Extended
//===========================================================================
function Trig_Init_Respawning_Items_Extended_Actions takes nothing returns nothing
    local itempool whichItemPool= CreateItemPool()
    local real x= 0.0
    local real y= 0.0
    call ItemPoolAddItemType(whichItemPool, 'clfm', 0.5)
    call ItemPoolAddItemType(whichItemPool, 'crys', 0.5)
    set x=GetRectCenterX(gg_rct_Item_Pool_Respawn)
    set y=GetRectCenterY(gg_rct_Item_Pool_Respawn)
    call AddRespawnItemPool(whichItemPool , x , y)
    set x=GetRectCenterX(gg_rct_Item_Level_Respawn)
    set y=GetRectCenterY(gg_rct_Item_Level_Respawn)
    call AddRespawnItemRandom(8 , x , y)
    set x=GetRectCenterX(gg_rct_Item_Type_and_Level_Respawn)
    set y=GetRectCenterY(gg_rct_Item_Type_and_Level_Respawn)
    call AddRespawnItemRandomEx(ITEM_TYPE_PERMANENT , 6 , x , y)
endfunction

//===========================================================================
function InitTrig_Init_Respawning_Items_Extended takes nothing returns nothing
    set gg_trg_Init_Respawning_Items_Extended=CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Respawning_Items_Extended, function Trig_Init_Respawning_Items_Extended_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Item_Respawn()
    call InitTrig_Item_Respawn_Starts()
    call InitTrig_Inite_Respawn_Callbacks()
    call InitTrig_Init_Respawning_Items_Extended()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
    call ConditionalTriggerExecute(gg_trg_Inite_Respawn_Callbacks)
    call ConditionalTriggerExecute(gg_trg_Init_Respawning_Items_Extended)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(0), true)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(1), true)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_006
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateRegions()
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs741858125")
call ExecuteFunc("ItemRespawn___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_001")
    call SetMapDescription("TRIGSTR_003")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 256.0, - 128.0)
    call DefineStartLocation(1, - 256.0, - 128.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype25_ItemRespawn___RemoveItemCleanup takes nothing returns boolean
    call ItemRespawn___RemoveItemCleanup(f__arg_item1)
    return true
endfunction

function jasshelper__initstructs741858125 takes nothing returns nothing
    set st___prototype25[1]=CreateTrigger()
    call TriggerAddAction(st___prototype25[1],function sa___prototype25_ItemRespawn___RemoveItemCleanup)
    call TriggerAddCondition(st___prototype25[1],Condition(function sa___prototype25_ItemRespawn___RemoveItemCleanup))

endfunction

