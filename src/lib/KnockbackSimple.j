library KnockbackSimple initializer Init requires TreeUtils,

globals
    group knockbackTargets = null
    item It = null
endglobals
////////////////////Vexorian's Check Pathability////////////////////

function CheckPathabilityTrickGet takes nothing returns nothing
    set bj_rescueChangeColorUnit = bj_rescueChangeColorUnit or (GetEnumItem()!=bj_itemRandomCurrentPick)
endfunction

function CheckPathabilityTrick takes real x, real y returns boolean
    local integer i = 30
    local real X
    local real Y
    local rect r
    call SetItemPosition(It, x, y)
    set X = GetItemX(It) - x
    set Y = GetItemY(It) - y
    if X * X + Y * Y <= 100 then
        return true
    endif
    set r = Rect(x - i, y - i, x + i, y + i)
    set bj_rescueChangeColorUnit = false
    call EnumItemsInRect(r, null, function CheckPathabilityTrickGet)
    call RemoveRect(r)
    set r = null
    return bj_rescueChangeColorUnit
endfunction

function CheckPathability takes real x, real y returns boolean
    local boolean b = CheckPathabilityTrick(x,y)
    call SetItemVisible(It,false)
    return b
endfunction

///////////////////////////////////////////////////////////////////

private struct KnockbackS
    unit target
    real d1
    real d2
    real sin
    real cos
    real r
    string efect
    string attachmentPoint
endstruct

function Knockback_TreeFilter takes nothing returns boolean
    return IsDestructableTree(GetFilterDestructable())
endfunction

function Knockback_KillTree takes nothing returns nothing
    call KillDestructable(GetEnumDestructable())
endfunction

globals
    timer Timer = CreateTimer()
    boolexpr filter
    KnockbackS array ar
    integer Total = 0
    constant real Interval = 0.04
endglobals

private function Loop takes nothing returns nothing
    local KnockbackS knock
    local integer i = 0
    local real x
    local real y
    local rect r
    loop
        exitwhen i >= Total
        set knock = ar[i]
        set x = GetUnitX(knock.target) + knock.d1 * knock.cos
        set y = GetUnitY(knock.target) + knock.d1 * knock.sin
        if knock.r != 0 then
            set r = Rect(x - knock.r, y - knock.r, x + knock.r, y + knock.r)
            call EnumDestructablesInRect(r, filter, function Knockback_KillTree)
            call RemoveRect(r)
        endif
        if CheckPathability(x, y) then
            call SetUnitX(knock.target, x)
            call SetUnitY(knock.target, y)
            call DestroyEffect(AddSpecialEffectTargetUnitBJ(knock.attachmentPoint, knock.target, knock.efect))
        endif
        set knock.d1 = knock.d1 - knock.d2
        if knock.d1 <= 0 or not CheckPathability(x, y) then
            set ar[i] = ar[Total - 1]
            set Total = Total - 1
            call PauseUnit(knock.target, false)
            call GroupRemoveUnit(knockbackTargets, knock.target)
            call knock.destroy()
        endif
        set i = i + 1
    endloop
    if Total == 0 then
        call PauseTimer(Timer)
    endif

endfunction

function KnockbackUnitSimple takes unit target, real distance, real angle, real duration, real radius, string efect, string attachmentPoint returns nothing
    local KnockbackS kd = KnockbackS.create()
    local integer q = R2I(duration / Interval)
    set kd.target = target
    set kd.d1 = 2 * distance / (q + 1)
    set kd.d2 = kd.d1 / q
    set kd.cos = Cos(angle * bj_DEGTORAD)
    set kd.sin = Sin(angle * bj_DEGTORAD)
    set kd.r = radius
    set kd.efect = efect
    set kd.attachmentPoint = attachmentPoint
    call PauseUnit(target, true)
    if Total == 0 then
        call TimerStart(Timer, Interval, true, function Loop)
    endif
    set ar[Total] = kd
    set Total = Total + 1
    call GroupAddUnit(knockbackTargets, target)
endfunction

function GetKnockbackTargets takes nothing returns group
    return knockbackTargets
endfunction

function IsUnitKnockbackTarget takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, knockbackTargets)
endfunction

private function Init takes nothing returns nothing
    set knockbackTargets = CreateGroup()
    set It = CreateItem('ciri', 0, 0)
    set filter = Filter(function Knockback_TreeFilter)
endfunction

endlibrary
