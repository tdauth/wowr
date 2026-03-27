/*****************************************************************************
*
*    RegisterNativeEvent v1.1.1.5
*       by Bannar
*
*    Storage of trigger handles for native events.
*
******************************************************************************
*
*    Optional requirements:
*
*       Table by Bribe
*          hiveworkshop.com/threads/snippet-new-table.188084/
*
******************************************************************************
*
*    Important:
*
*       Avoid using TriggerSleepAction within functions registered.
*       Destroy native event trigger on your own responsibility.
*
******************************************************************************
*
*    Core:
*
*       function IsNativeEventRegistered takes integer whichIndex, integer whichEvent returns boolean
*          Whether index whichIndex has already been attached to event whichEvent.
*
*       function RegisterNativeEventTrigger takes integer whichIndex, integer eventId returns boolean
*          Registers whichIndex within whichEvent scope and assigns new trigger handle for it.
*
*       function GetIndexNativeEventTrigger takes integer whichIndex, integer whichEvent returns trigger
*          Retrieves trigger handle for event whichEvent specific to provided index whichIndex.
*
*       function GetNativeEventTrigger takes integer whichEvent returns trigger
*          Retrieves trigger handle for event whichEvent.
*
*
*    Custom events:
*
*       function CreateNativeEvent takes nothing returns integer
*          Returns unique id for new event and registers it with RegisterNativeEvent.
*
*       function RegisterIndexNativeEvent takes integer whichIndex, integer whichEvent, code func returns triggercondition
*          Registers new event handler func for event whichEvent specific to index whichIndex.
*
*       function RegisterNativeEvent takes integer whichEvent, code func returns triggercondition
*          Registers new event handler func for specified event whichEvent.
*
*       function UnregisterNativeEventHandler takes integer whichEvent, triggercondition handler returns nothing
*          Unregisters specified event handler for event whichEvent. Requires Warcraft 1.30.4+.
*
*****************************************************************************/
library RegisterNativeEvent uses optional Table

globals
    private integer eventIndex = 500 // 0-499 reserved for Blizzard native events
endglobals

private module NativeEventInit
    private static method onInit takes nothing returns nothing
static if LIBRARY_Table then
        set table = TableArray[0x2000]
endif
    endmethod
endmodule

private struct NativeEvent extends array
static if LIBRARY_Table then
    static TableArray table
else
    static hashtable table = InitHashtable()
endif
    implement NativeEventInit
endstruct

function IsNativeEventRegistered takes integer whichIndex, integer whichEvent returns boolean
static if LIBRARY_Table then
    return NativeEvent.table[whichEvent].trigger.has(whichIndex)
else
    return HaveSavedHandle(NativeEvent.table, whichEvent, whichIndex)
endif
endfunction

function RegisterNativeEventTrigger takes integer whichIndex, integer whichEvent returns boolean
    if not IsNativeEventRegistered(whichIndex, whichEvent) then
static if LIBRARY_Table then
        set NativeEvent.table[whichEvent].trigger[whichIndex] = CreateTrigger()
else
        call SaveTriggerHandle(NativeEvent.table, whichEvent, whichIndex, CreateTrigger())
endif
        return true
    endif
    return false
endfunction

function GetIndexNativeEventTrigger takes integer whichIndex, integer whichEvent returns trigger
static if LIBRARY_Table then
    return NativeEvent.table[whichEvent].trigger[whichIndex]
else
    return LoadTriggerHandle(NativeEvent.table, whichEvent, whichIndex)
endif
endfunction

function GetNativeEventTrigger takes integer whichEvent returns trigger
    return GetIndexNativeEventTrigger(bj_MAX_PLAYER_SLOTS, whichEvent)
endfunction

function CreateNativeEvent takes nothing returns integer
    local integer eventId = eventIndex
    call RegisterNativeEventTrigger(bj_MAX_PLAYER_SLOTS, eventId)
    set eventIndex = eventIndex + 1
    return eventId
endfunction

function RegisterIndexNativeEvent takes integer whichIndex, integer whichEvent, code func returns triggercondition
    call RegisterNativeEventTrigger(whichIndex, whichEvent)
    return TriggerAddCondition(GetIndexNativeEventTrigger(whichIndex, whichEvent), Condition(func))
endfunction

function RegisterNativeEvent takes integer whichEvent, code func returns triggercondition
    return RegisterIndexNativeEvent(bj_MAX_PLAYER_SLOTS, whichEvent, func)
endfunction

function UnregisterNativeEventHandler takes integer whichEvent, triggercondition handler returns nothing
    call TriggerRemoveCondition(GetNativeEventTrigger(whichEvent), handler)
endfunction

endlibrary
