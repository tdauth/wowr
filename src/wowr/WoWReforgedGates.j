library WoWReforgedGates initializer Init

globals
    private group gates = CreateGroup()
    private trigger spellFinishTrigger = CreateTrigger()
endglobals

function AddGate takes unit whichUnit returns nothing
    call GroupAddUnit(gates, whichUnit)
endfunction

function RemoveGate takes unit whichUnit returns nothing
    call GroupRemoveUnit(gates, whichUnit)
endfunction

private function TriggerConditionSpellFinish takes nothing returns boolean
    return GetSpellAbilityId() == 'A09I'
endfunction

private function TriggerActionSpellFinish takes nothing returns nothing
    local unit whichUnit = GetTriggerUnit()
    call PolledWait(0.10)
    if (GetUnitTypeId(whichUnit) != 0 and whichUnit != null and IsUnitInGroup(whichUnit, gates) and IsUnitAliveBJ(whichUnit)) then
        if (GetUnitTypeId(whichUnit) == GATE_OPEN_HORIZONTAL) then
            call SetUnitAnimation(whichUnit, "death alternate")
        else
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
