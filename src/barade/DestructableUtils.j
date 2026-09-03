library DestructableUtils initializer Init requires MathUtils

function ReplaceDestructable takes destructable d, integer objectid, real face, real scale, integer variation, integer stateMethod returns destructable
    local real x = GetDestructableX(d)
    local real y = GetDestructableY(d)
    local real life = GetDestructableLife(d)
    local real max = GetDestructableMaxLife(d)
    local boolean invulnerable = IsDestructableInvulnerable(d)
    local real oldRatio
    call RemoveDestructable(d)
    set d = CreateDestructable(objectid, x, y, face, scale, variation)
    call SetDestructableMaxLife(d, max)

     // Set the unit's life and mana according to the requested method.
    if (stateMethod == bj_UNIT_STATE_METHOD_RELATIVE) then
        // Set the replacement's current/max life ratio to that of the old unit.
        // If both units have mana, do the same for mana.
        if (max > 0) then
            set oldRatio = life / max
            call SetDestructableLife(d, oldRatio * max)
        endif
    elseif (stateMethod == bj_UNIT_STATE_METHOD_ABSOLUTE) then
        // Set the replacement's current life to that of the old unit.
        // If the new unit has mana, do the same for mana.
        call SetDestructableLife(d, life)
    elseif (stateMethod == bj_UNIT_STATE_METHOD_DEFAULTS) then
        // The newly created unit should already have default life and mana.
    elseif (stateMethod == bj_UNIT_STATE_METHOD_MAXIMUM) then
        // Use max life and mana.
        call SetDestructableLife(d, max)
    else
        // Unrecognized unit state method - ignore the request.
    endif

    call SetDestructableInvulnerable(d, invulnerable)
    return d
endfunction

globals
    private real filterCenterX = 0.0
    private real filterCenterY = 0.0
    private boolexpr filterEnumDestructablesInCircleWithFilter

    private trigger filterEvalTrigger = CreateTrigger()
endglobals

private function EnumDestructablesInCircleFilter takes nothing returns boolean
    return DistBetweenCoordinates(filterCenterX, filterCenterY, GetDestructableX(GetFilterDestructable()), GetDestructableY(GetFilterDestructable())) <= bj_enumDestructableRadius and TriggerEvaluate(filterEvalTrigger)
endfunction

private function ReturnTrue takes nothing returns boolean
    return true
endfunction

function EnumDestructablesInCircle takes real centerX, real centerY, real radius, boolexpr filter, code actionFunc returns nothing
    local rect r = null
    local triggercondition cond = null

    if (radius >= 0.0) then
        set filterCenterX = centerX
        set filterCenterY = centerY
        set bj_enumDestructableRadius = radius
        set r = GetRectFromCircle(centerX, centerY, radius)
        if (filter != null) then
            set cond = TriggerAddCondition(filterEvalTrigger, filter)
        else
            set cond = TriggerAddCondition(filterEvalTrigger, Condition(function ReturnTrue))
        endif
        call EnumDestructablesInRect(r, filterEnumDestructablesInCircleWithFilter, actionFunc)
        call RemoveRect(r)
        set r = null
        call TriggerRemoveCondition(filterEvalTrigger, cond)
        set cond = null
    endif
endfunction

private function Init takes nothing returns nothing
    set filterEnumDestructablesInCircleWithFilter = Filter(function EnumDestructablesInCircleFilter)
endfunction

endlibrary
