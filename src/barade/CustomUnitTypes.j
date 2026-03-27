library CustomUnitTypes
/*
 * Custom Unit Types 1.0
 * 
 * System to avoid enumerating all units in the map multiple times, for example with GetUnitsOfTypeIdAll.
 * Register handlers for all custom unit types.
 * Call the handlers ONCE in the beginning of the game and whenever a new unit enters the map.
 */
globals
    private constant integer KEY_HANDLER = 0

    private trigger enterTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    private boolean init = false
endglobals

struct CustomUnitType
    
    public stub method filter takes unit whichUnit returns boolean
        return true
    endmethod
    
    public stub method handler takes unit whichUnit returns nothing
    endmethod
    
endstruct

function AddCustomUnitType takes integer unitTypeId, CustomUnitType c returns nothing
    call SaveInteger(h, unitTypeId, KEY_HANDLER, c)
endfunction

function IsCustomUnitType takes integer unitTypeId returns boolean
    return HaveSavedInteger(h, unitTypeId, KEY_HANDLER)
endfunction

function CallCustomUnitTypeHandler takes unit whichUnit returns nothing
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local CustomUnitType c = LoadInteger(h, unitTypeId, KEY_HANDLER)
    if (c != 0 and c.filter.evaluate(whichUnit)) then
        call c.handler.execute(whichUnit)
    endif
endfunction

private function FilterHasCustomUnitType takes nothing returns boolean
    return IsCustomUnitType(GetUnitTypeId(GetFilterUnit()))
endfunction

private function EnumCustomUnitType takes nothing returns nothing
    call CallCustomUnitTypeHandler(GetEnumUnit())
endfunction

private function TriggerConditionEnter takes nothing returns boolean
    if (IsCustomUnitType(GetUnitTypeId(GetTriggerUnit()))) then
        call CallCustomUnitTypeHandler(GetTriggerUnit())
    endif
    return false
endfunction

// Call this function AFTER all the AddCustomUnitType calls.
function InitCustomUnitTypes takes nothing returns nothing
    if (init) then
        call BJDebugMsg("Multiple calls of InitCustomUnitTypes!")
    else
        set init = true
        set bj_wantDestroyGroup = true
        call ForGroup(GetUnitsInRectMatching(GetPlayableMapRect(), Filter(function FilterHasCustomUnitType)), function EnumCustomUnitType)
        
        call TriggerRegisterEnterRectSimple(enterTrigger, GetPlayableMapRect())
        call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
    endif
endfunction

endlibrary
