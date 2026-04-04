library WoWReforgedSpellEscapePortal initializer Init requires SimError

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

private function TriggerConditionChannel takes nothing returns boolean
    local unit portal = null
    local unit dummy = null
    if (GetSpellAbilityId() == 'A0TJ') then
        if (IsVisibleToPlayer(GetSpellTargetX(), GetSpellTargetY(), GetOwningPlayer(GetTriggerUnit()))) then
            set portal = CreateUnit(GetOwningPlayer(GetTriggerUnit()), 'n09W', GetSpellTargetX(), GetSpellTargetY(), bj_UNIT_FACING)
            call SetUnitInvulnerable(portal, true)
            call WaygateActivate(portal, true)
            call WaygateSetDestination(portal, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
            call UnitApplyTimedLife(portal, 'BTLF', 60.0)
            set dummy = CreateUnit(GetOwningPlayer(GetTriggerUnit()), 'h0CH', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), bj_UNIT_FACING)
            call IssueTargetOrder(dummy, "massteleport", GetTriggerUnit())
            call PolledWait(6.00)
            call RemoveUnit(dummy)
            set dummy = null
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_LOCATION_MUST_BE_VISIBLE"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
