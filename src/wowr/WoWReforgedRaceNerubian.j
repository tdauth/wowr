library WoWReforgedRaceNerubian initializer Init requires Tunnel

globals
    private trigger castTrigger = CreateTrigger()
    private trigger spellFinishTrigger = CreateTrigger()
    private trigger damagedTrigger = CreateTrigger()
endglobals

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1CK') then // Enable Hatchery
        call UnitAddAbility(GetTriggerUnit(), 'A1CI')
        call UnitRemoveAbility(GetTriggerUnit(), GetSpellAbilityId())
        call UnitAddAbility(GetTriggerUnit(), 'A1CL')
        call ResetUnitAnimation(GetTriggerUnit())
    elseif (GetSpellAbilityId() == 'A1CL') then // Disable Hatchery
        call UnitRemoveAbility(GetTriggerUnit(), 'A1CI')
        call UnitRemoveAbility(GetTriggerUnit(), GetSpellAbilityId())
        call UnitAddAbility(GetTriggerUnit(), 'A1CK')
        call ResetUnitAnimation(GetTriggerUnit())
    endif
    return false
endfunction

private function IsNerubianBurrowAbility takes integer abilityId returns boolean
    return abilityId == 'A1D3' or abilityId == 'A1D2' or abilityId == 'A1A3' or abilityId == 'A1D9' or abilityId == 'A1CP' or abilityId == 'A1CM' or abilityId == 'A1A7' or abilityId == 'A1D0' or abilityId == 'A1DA' or abilityId == 'A1CY' or abilityId == 'A1D1' or abilityId == 'A1CZ'
endfunction

private function SelectNextTunnel takes player whichPlayer returns nothing
    local unit tunnel = GetNextTunnel(whichPlayer)
    if (tunnel != null) then
        call SelectUnitForPlayerSingle(tunnel, whichPlayer)
        call PanCameraToTimedForPlayer(whichPlayer, GetUnitX(tunnel), GetUnitY(tunnel), 0)
        set tunnel = null
    endif
endfunction

private function TriggerConditionSpellFinish takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_TOWNHALL) and (abilityId == 'A1D3' or abilityId == 'A1D2' or abilityId == 'A1A3')) then
        call UnitRemoveAbility(GetTriggerUnit(), 'A08R')
        call UnitAddAbility(GetTriggerUnit(), 'A08R')
    endif
    if (IsNerubianBurrowAbility(abilityId)) then
         call SetUnitAnimation(GetTriggerUnit(), "stand")
        if (abilityId == 'A1CP') then // Burrow Altar
            call UnitAddAbility(GetTriggerUnit(), 'Arev')
        endif
    elseif (abilityId == 'A1DJ') then // Next Tunnel
        call SelectNextTunnel(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function TriggerConditionDamaged takes nothing returns boolean
    return GetUnitTypeId(GetEventDamageSource()) == 'n0EK' or GetUnitTypeId(GetEventDamageSource()) == 'n0EL'
endfunction

private function TriggerActionDamaged takes nothing returns nothing
    local unit dummy = CreateUnit(GetOwningPlayer(GetEventDamageSource()), 'h0P0', GetUnitX(GetEventDamageSource()), GetUnitY(GetEventDamageSource()), bj_UNIT_FACING)
    call SetUnitInvulnerable(dummy, true)
    call ShowUnit(dummy, false)
    call IssueTargetOrder(dummy, "web", BlzGetEventDamageTarget())
    call PolledWait(2.0)
    call RemoveUnit(dummy)
    set dummy = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    // The spell book abilities disappear after burrowing/unburrowing the building. This trigger readds them.
    call TriggerRegisterAnyUnitEventBJ(spellFinishTrigger, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(spellFinishTrigger, Condition(function TriggerConditionSpellFinish))

    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))
    call TriggerAddAction(damagedTrigger, function TriggerActionDamaged)
endfunction

endlibrary
