library WoWReforgedRaceDwarf initializer Init requires MathUtils, TreeUtils

globals
    private boolexpr filter = null
    private real filterX = 0.0
    private real filterY = 0.0
    private real filterRadius = 0.0
    private hashtable h = InitHashtable()
    private timer t = CreateTimer()
    private group lumberMills = CreateGroup()
endglobals

private function EnumPickFirstLivingTreeInCircleFilter takes nothing returns boolean
    if (bj_destRandomCurrentPick == null and IsDestructableAliveBJ(GetFilterDestructable()) and IsDestructableTree(GetFilterDestructable()) and DistanceBetweenCoordinates(GetDestructableX(GetFilterDestructable()), GetDestructableY(GetFilterDestructable()), filterX, filterY) <= filterRadius) then
        set bj_destRandomCurrentPick = GetFilterDestructable()
    endif
    return false
endfunction

private function RandomLivingTreeDestructableInCircle takes real x, real y, real radius returns destructable
    set filterX = x
    set filterY = y
    set filterRadius = radius
    set bj_destRandomCurrentPick = null
    call EnumDestructablesInCircle(x, y, radius, filter, null)
    return bj_destRandomCurrentPick
endfunction

private function EnumIssueOrderReturnResources takes nothing returns nothing
    call IssueImmediateOrder(GetEnumUnit(), "returnresources")
endfunction

private function EnumPickNearbyTree takes nothing returns nothing
    local destructable d = LoadDestructableHandle(h, GetHandleId(GetEnumUnit()), 0)
    if (d == null or IsDestructableDeadBJ(d)) then
        set d = RandomLivingTreeDestructableInCircle(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 4000.0)
        if (d != null) then
            call IssueTargetOrder(GetEnumUnit(), "harvest", d)
            call SaveDestructableHandle(h, GetHandleId(GetEnumUnit()), 0, d)
        endif
    else
        call IssueTargetOrder(GetEnumUnit(), "harvest", d)
    endif
endfunction

private function TimerFunctionUpdateLumberMills takes nothing returns nothing
    call ForGroup(lumberMills, function EnumIssueOrderReturnResources)
    call PolledWait(5.0)
    call ForGroup(lumberMills, function EnumPickNearbyTree)
endfunction

function AddDwarfLumberMill takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, lumberMills)) then
        call GroupAddUnit(lumberMills, whichUnit)
        call TimerStart(t, 30.0, true, function TimerFunctionUpdateLumberMills)
    endif
endfunction

function RemoveDwarfLumberMill takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, lumberMills)) then
        call GroupRemoveUnit(lumberMills, whichUnit)
        call FlushChildHashtable(h, GetHandleId(whichUnit))
        if (IsUnitGroupEmptyBJ(lumberMills)) then
            call PauseTimer(t)
        endif
    endif
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function EnumPickFirstLivingTreeInCircleFilter)
endfunction

endlibrary
