library Attributes

private struct A
    string name
    string icon
    string description
    
    public static method create takes string name returns thistype
        local thistype this = thistype.allocate()
        set this.name = name
        return this
    endmethod
    
endstruct

globals
    private hashtable h = InitHashtable()
    private A array attributes
    private integer attributesCounter = 0
endglobals

function SetAttributeName takes A a, string name returns nothing
    set a.name = name
endfunction

function GetAttributeName takes A a returns string
    return a.name
endfunction

function SetAttributeIcon takes A a, string icon returns nothing
    set a.icon = icon
endfunction

function GetAttributeIcon takes A a returns string
    return a.icon
endfunction

function SetAttributeDescription takes A a, string description returns nothing
    set a.description = description
endfunction

function GetAttributeDescription takes A a returns string
    return a.description
endfunction

function AddAttribute takes string name returns A
    local A a = A.create(name)
    set attributes[attributesCounter] = a
    set attributesCounter = attributesCounter + 1
    
    return a
endfunction

function GetMaxAttributes takes nothing returns integer
    return attributesCounter
endfunction

function GetAttribute takes integer index returns A
    return attributes[index]
endfunction

private struct V
    real value
    real max
    real regeneration
endstruct

function GetUnitAttribute takes unit whichUnit, A a returns real
    return LoadReal(h, GetHandleId(whichUnit), a)
endfunction

function SetUnitAttribute takes unit whichUnit, A a, real v returns nothing
    //call BJDebugMsg("Set attribute " + GetAttributeName(a) + " to " + R2S(v))
    call SaveReal(h, GetHandleId(whichUnit), a, v)
endfunction

function AddUnitAttribute takes unit whichUnit, A a, real v returns nothing
    call SetUnitAttribute(whichUnit, a, GetUnitAttribute(whichUnit, a) + v)
endfunction

function RemoveUnitAttribute takes unit whichUnit, A a, real v returns nothing
    call SetUnitAttribute(whichUnit, a, RMaxBJ(0.0, GetUnitAttribute(whichUnit, a) - v))
endfunction

function CopyUnitAttributeData takes A a, integer sourceHandleId, integer targetHandleId returns nothing
    call SaveReal(h, targetHandleId, a, LoadReal(h, sourceHandleId, a))
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit HookRemoveUnit

endlibrary
