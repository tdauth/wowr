library WoWReforgedAnimations initializer Init

globals
    private trigger deathTrigger = CreateTrigger()
    private trigger damagedTrigger = CreateTrigger()
    private trigger constructStartTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
    if (unitTypeId == DEMON_DIMENSIONAL_GATE) then
        return true
    elseif (unitTypeId == DEMON_FLOATING_ROCKS) then
        return true
    elseif (unitTypeId == DEMON_DUNGEON_OF_PAIN) then
        return true
    elseif (unitTypeId == DEMON_OBELISK) then
        return true
    elseif (unitTypeId == RESURRECTION_STONE) then
        return true
    elseif (unitTypeId == BLOOD_ELF_CAGE) then
        return true
    elseif (unitTypeId == GATE_CLOSED_HORIZONTAL) then
        return true
    elseif (unitTypeId == GATE_OPEN_HORIZONTAL) then
        return true
    elseif (unitTypeId == GOBLIN_HUT) then
        return true
    elseif (unitTypeId == GOBLIN_AIR_FIELD) then
        return true
    elseif (unitTypeId == HIGH_ELF_SUNWELL) then
        return true
    elseif (unitTypeId == PANDAREN_WORKSHOP) then
        return true
    elseif (unitTypeId == PANDAREN_BREWERY) then
        return true
    elseif (unitTypeId == NAGA_STATUE_OF_ASZHARA) then
        return true
    elseif (unitTypeId == 'n0DP') then
        return true
    elseif (unitTypeId == VRYKUL_LAMP) then
        return true
    elseif (unitTypeId == 'n02Q') then
        return true
    elseif (unitTypeId == NZOTH) then
        return true
    elseif (unitTypeId == YOGG_SARON) then
        return true
    elseif (unitTypeId == CTHUN) then
        return true
    endif
    return false
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer unitTypeId = GetUnitTypeId(u)
    if (unitTypeId == NZOTH or unitTypeId == YOGG_SARON or unitTypeId == CTHUN) then
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

private function TriggerConditionConstructStart takes nothing returns boolean
    return GetUnitTypeId(GetTriggerUnit()) == DEMON_IMP or GetUnitTypeId(GetTriggerUnit()) == NERUBIAN_WORKER
endfunction

private function TriggerActionConstructStart takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    call ResetUnitAnimation(triggerUnit)
    call PolledWait(1.0)
    call ResetUnitAnimation(triggerUnit)
    set triggerUnit = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)

    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))

    call TriggerRegisterAnyUnitEventBJ(constructStartTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(constructStartTrigger, Condition(function TriggerConditionConstructStart))
    call TriggerAddAction(constructStartTrigger, function TriggerActionConstructStart)
endfunction

endlibrary
