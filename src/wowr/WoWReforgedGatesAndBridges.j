library WoWReforgedGatesAndBridges initializer Init

globals
    private trigger spellFinishTrigger = CreateTrigger()
endglobals

private function TriggerConditionSpellFinish takes nothing returns boolean
    return GetSpellAbilityId() == 'A09I' or GetSpellAbilityId() == 'A0M0'
endfunction

private function TriggerActionSpellFinish takes nothing returns nothing
    local unit whichUnit = GetTriggerUnit()
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    call PolledWait(0.10)
    if (unitTypeId != 0 and whichUnit != null and IsUnitAliveBJ(whichUnit)) then
        if (unitTypeId == GATE_OPEN_HORIZONTAL) then
            call SetUnitAnimation(whichUnit, "death alternate")
        elseif (unitTypeId == GATE_CLOSED_HORIZONTAL) then
            call SetUnitAnimation(whichUnit, "stand")
        elseif (unitTypeId == BRIDGE_DIAGONAL_DISABLED or unitTypeId == BRIDGE_HORIZONTAL_DISABLED) then
            call SetUnitAnimation(whichUnit, "death")
        elseif (unitTypeId == BRIDGE_DIAGONAL or unitTypeId == BRIDGE_HORIZONTAL) then
            call SetUnitAnimation(whichUnit, "stand")
        endif
    endif
    set whichUnit = null
endfunction


private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(spellFinishTrigger, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(spellFinishTrigger, Condition(function TriggerConditionSpellFinish))
    call TriggerAddAction(spellFinishTrigger, function TriggerActionSpellFinish)
endfunction

endlibrary
