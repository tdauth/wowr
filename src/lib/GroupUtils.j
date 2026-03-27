library GroupUtils initializer Init requires optional xebasic
//******************************************************************************
//* BY: Rising_Dusk
//* 
//* This library is a combination of several features relevant to groups. First
//* and foremost, it contains a group stack that you can access dynamic groups
//* from. It also provides means to refresh groups and clear any shadow
//* references within them. The included boolexprs are there for backwards
//* compatibility with maps that happen to use them. Since the 1.24c patch,
//* null boolexprs used in GroupEnumUnits* calls no longer leak, so there is no
//* performance gain to using the BOOLEXPR_TRUE constant.
//* 
//* Instead of creating/destroying groups, we have moved on to recycling them.
//* NewGroup pulls a group from the stack and ReleaseGroup adds it back. Always
//* remember to call ReleaseGroup on a group when you are done using it. If you
//* fail to do so enough times, the stack will overflow and no longer work.
//* 
//* GroupRefresh cleans a group of any shadow references which may be clogging
//* its hashtable. If you remove a unit from the game who is a member of a unit
//* group, it will 'effectively' remove the unit from the group, but leave a
//* shadow in its place. Calling GroupRefresh on a group will clean up any
//* shadow references that may exist within it. It is only worth doing this on
//* groups that you plan to have around for awhile.
//* 
//* Constants that can be used from the library:
//*     [group]    ENUM_GROUP      As you might expect, this group is good for
//*                                when you need a group just for enumeration.
//*     [boolexpr] BOOLEXPR_TRUE   This is a true boolexpr, which is important
//*                                because a 'null' boolexpr in enumeration
//*                                calls results in a leak. Use this instead.
//*     [boolexpr] BOOLEXPR_FALSE  This exists mostly for completeness.
//* 
//* This library also includes a simple implementation of a group enumeration
//* call that factors collision of units in a given area of effect. This is
//* particularly useful because GroupEnumUnitsInRange doesn't factor collision.
//* 
//* In your map, you can just replace all instances of GroupEnumUnitsInRange
//* with GroupEnumUnitsInArea with identical arguments and your spells will
//* consider all units colliding with the area of effect. After calling this
//* function as you would normally call GroupEnumUnitsInRange, you are free to
//* do anything with the group that you would normally do.
//* 
//* If you don't use xebasic in your map, you may edit the MAX_COLLISION_SIZE
//* variable below and the library will use that as the added radius to check.
//* If you use xebasic, however, the script will automatically use xe's
//* collision size variable.
//* 
//* You are also able to use GroupUnitsInArea. This function returns all units
//* within the area, no matter what they are, which can be convenient for those
//* instances where you actually want that.
//* 
//* Example usage:
//*     local group MyGroup = NewGroup()
//*     call GroupRefresh(MyGroup)
//*     call ReleaseGroup(MyGroup)
//*     call GroupEnumUnitsInArea(ENUM_GROUP, x, y, 350., BOOLEXPR_TRUE)
//*     call GroupUnitsInArea(ENUM_GROUP, x, y, 350.)
//* 
globals
    //If you don't have xebasic in your map, this value will be used instead.
    //This value corresponds to the max collision size of a unit in your map.
    private constant real    MAX_COLLISION_SIZE = 197.
    //If you are insane and don't care about any of the protection involved in
    //this library, but want this script to be really fast, set this to true.
    private constant boolean LESS_SAFETY        = false
endglobals

globals
    //* Constants that are available to the user
    group    ENUM_GROUP     = CreateGroup()
    boolexpr BOOLEXPR_TRUE  = null
    boolexpr BOOLEXPR_FALSE = null
endglobals

globals
    //* Hashtable for debug purposes
    private hashtable     ht     = InitHashtable()
    //* Temporary references for GroupRefresh
    private boolean       Flag   = false
    private group         Refr   = null
    //* Arrays and counter for the group stack
    private group   array Groups
    private integer       Count  = 0
    //* Variables for use with the GroupUnitsInArea function
    private real          X      = 0.
    private real          Y      = 0.
    private real          R      = 0.
    private hashtable     H      = InitHashtable()
endglobals

private function HookDestroyGroup takes group g returns nothing
    if g == ENUM_GROUP then
        call BJDebugMsg(SCOPE_PREFIX+"Warning: ENUM_GROUP destroyed")
    endif
endfunction

debug hook DestroyGroup HookDestroyGroup

private function AddEx takes nothing returns nothing
    if Flag then
        call GroupClear(Refr)
        set Flag = false
    endif
    call GroupAddUnit(Refr, GetEnumUnit())
endfunction
function GroupRefresh takes group g returns nothing
    set Flag = true
    set Refr = g
    call ForGroup(Refr, function AddEx)
    if Flag then
        call GroupClear(g)
    endif
endfunction

function NewGroup takes nothing returns group
    if Count == 0 then
        set Groups[0] = CreateGroup()
    else
        set Count = Count - 1
    endif
    static if not LESS_SAFETY then
        call SaveInteger(ht, 0, GetHandleId(Groups[Count]), 1)
    endif
    return Groups[Count]
endfunction
function ReleaseGroup takes group g returns boolean
    local integer id = GetHandleId(g)
    static if LESS_SAFETY then
        if g == null then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Null groups cannot be released")
            return false
        elseif Count == 8191 then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Max groups achieved, destroying group")
            call DestroyGroup(g)
            return false
        endif
    else
        if g == null then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Null groups cannot be released")
            return false
        elseif not HaveSavedInteger(ht, 0, id) then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Group not part of stack")
            return false
        elseif LoadInteger(ht, 0, id) == 2 then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Groups cannot be multiply released")
            return false
        elseif Count == 8191 then
            debug call BJDebugMsg(SCOPE_PREFIX+"Error: Max groups achieved, destroying group")
            call DestroyGroup(g)
            return false
        endif
        call SaveInteger(ht, 0, id, 2)
    endif
    call GroupClear(g)
    set Groups[Count] = g
    set Count         = Count + 1
    return true
endfunction

private function Filter takes nothing returns boolean
    return IsUnitInRangeXY(GetFilterUnit(), X, Y, R)
endfunction

private function HookDestroyBoolExpr takes boolexpr b returns nothing
    local integer bid = GetHandleId(b)
    if HaveSavedHandle(H, 0, bid) then
        //Clear the saved boolexpr
        call DestroyBoolExpr(LoadBooleanExprHandle(H, 0, bid))
        call RemoveSavedHandle(H, 0, bid)
    endif
endfunction

hook DestroyBoolExpr HookDestroyBoolExpr

private constant function GetRadius takes real radius returns real
    static if LIBRARY_xebasic then
        return radius+XE_MAX_COLLISION_SIZE
    else
        return radius+MAX_COLLISION_SIZE
    endif
endfunction

function GroupEnumUnitsInArea takes group whichGroup, real x, real y, real radius, boolexpr filter returns nothing
    local real    prevX = X
    local real    prevY = Y
    local real    prevR = R
    local integer bid   = 0
    
    //Set variables to new values
    set X = x
    set Y = y
    set R = radius
    if filter == null then
        //Adjusts for null boolexprs passed to the function
        set filter = Condition(function Filter)
    else
        //Check for a saved boolexpr
        set bid = GetHandleId(filter) 
        if HaveSavedHandle(H, 0, bid) then
            //Set the filter to use to the saved one
            set filter = LoadBooleanExprHandle(H, 0, bid)
        else
            //Create a new And() boolexpr for this filter
            set filter = And(Condition(function Filter), filter)
            call SaveBooleanExprHandle(H, 0, bid, filter)
        endif
    endif
    //Enumerate, if they want to use the boolexpr, this lets them
    call GroupEnumUnitsInRange(whichGroup, x, y, GetRadius(radius), filter)
    //Give back original settings so nested enumerations work
    set X = prevX
    set Y = prevY
    set R = prevR
endfunction

function GroupUnitsInArea takes group whichGroup, real x, real y, real radius returns nothing
    local real prevX = X
    local real prevY = Y
    local real prevR = R
    
    //Set variables to new values
    set X = x
    set Y = y
    set R = radius
    //Enumerate
    call GroupEnumUnitsInRange(whichGroup, x, y, GetRadius(radius), Condition(function Filter))
    //Give back original settings so nested enumerations work
    set X = prevX
    set Y = prevY
    set R = prevR
endfunction

private function True takes nothing returns boolean
    return true
endfunction
private function False takes nothing returns boolean
    return false
endfunction
private function Init takes nothing returns nothing
    set BOOLEXPR_TRUE  = Condition(function True)
    set BOOLEXPR_FALSE = Condition(function False)
endfunction
endlibrary
