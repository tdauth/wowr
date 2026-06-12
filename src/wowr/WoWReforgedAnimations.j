library WoWReforgedAnimations initializer Init

globals
    private trigger deathTrigger = CreateTrigger()
    private trigger damagedTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
    if (unitTypeId == 'u00A') then
        return true
    elseif (unitTypeId == 'u009') then
        return true
    elseif (unitTypeId == 'u00C') then
        return true
    elseif (unitTypeId == 'u00G') then
        return true
    elseif (unitTypeId == 'h01R') then
        return true
    elseif (unitTypeId == 'e00D') then
        return true
    elseif (unitTypeId == 'h020') then
        return true
    elseif (unitTypeId == 'h021') then
        return true
    elseif (unitTypeId == 'o019') then
        return true
    elseif (unitTypeId == 'o00R') then
        return true
    elseif (unitTypeId == 'n05F') then
        return true
    elseif (unitTypeId == 'h0A9') then
        return true
    elseif (unitTypeId == 'h0QH') then
        return true
    elseif (unitTypeId == 'o00I') then
        return true
    elseif (unitTypeId == 'n0DP') then
        return true
    elseif (unitTypeId == 'h0P7') then
        return true
    elseif (unitTypeId == 'n02Q') then
        return true
    elseif (unitTypeId == 'N06C') then
        return true
    elseif (unitTypeId == 'N069') then
        return true
    elseif (unitTypeId == 'N06E') then
        return true
    endif
    return false
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    if (unitTypeId == 'N06C' or unitTypeId == 'N069' or unitTypeId == 'N06E') then
        call SetUnitTimeScalePercent(u, 800.00 )
        call SetUnitAnimation(u, "decay")
        call TriggerSleepAction(2.0)
        call SetUnitTimeScalePercent(u, 100.00)
    else
        call ShowUnitHide(u)
    endif
    set u = null
endfunction

private function TriggerConditionDamaged takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
    if (unitTypeId == 'n0CC') then // dummy
        call SetUnitAnimation(GetTriggerUnit(), "stand hit")
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)

    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))
endfunction

endlibrary
