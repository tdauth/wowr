library WoWReforgedPrevention initializer Init requires WoWReforgedMapData

globals
    private trigger castTrigger = CreateTrigger()
    private trigger constructStartTrigger = CreateTrigger()
endglobals

private function IsTeleportAbilityId takes integer abilityId returns boolean
    if (abilityId == 'A0DE') then
        return true
    elseif (abilityId == 'A01Y') then
        return true
    elseif (abilityId == 'AImt') then
        return true
    elseif (abilityId == 'AHmt') then
        return true
    elseif (abilityId == 'A0DE') then
        return true
    elseif (abilityId == 'AImt') then
        return true
    elseif (abilityId == 'A01Y') then
        return true
    elseif (abilityId == 'A13N') then
        return true
    elseif (abilityId == 'A0CV') then
        return true
    elseif (abilityId == 'A0PQ') then
        return true
    elseif (abilityId == 'A0P4') then
        return true
    elseif (abilityId == 'A08B') then
        return true
    elseif (abilityId == 'A08C') then
        return true
    elseif (abilityId == 'A234') then
        return true
    endif
    return false
endfunction

private function IsBlinkAbilityId takes integer abilityId returns boolean
    if (abilityId == 'A0OZ') then
        return true
    elseif (abilityId == 'A005') then
        return true
    elseif (abilityId == 'A02U') then
        return true
    elseif (abilityId == 'AEbl') then
        return true
    elseif (abilityId == 'ANbl') then
        return true
    elseif (abilityId == 'AIbk') then
        return true
    elseif (abilityId == 'A02H') then
        return true
    elseif (abilityId == 'A0H9') then
        return true
    elseif (abilityId == 'A22W') then
        return true
    elseif (abilityId == 'A0NK') then
        return true
    elseif (abilityId == 'A0G2') then
        return true
    elseif (abilityId == 'A01E') then
        return true
    endif
    return false
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (IsTeleportAbilityId(GetSpellAbilityId())) then
        if (not MapLocationCanBeTeleportedTo(GetTriggerUnit(), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())) or not MapLocationCanBeTeleportedTo(GetTriggerUnit(), GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit()))) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("CANNOT_TELEPORT_INTO_THIS_AREA"))
        endif
    elseif (IsBlinkAbilityId(GetSpellAbilityId())) then
        if (not MapLocationCanBeTeleportedTo(GetTriggerUnit(), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())) or not MapLocationCanBeTeleportedTo(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("CANNOT_TELEPORT_INTO_THIS_AREA"))
        endif
    endif
    return false
endfunction

private function TriggerConditionConstructStart takes nothing returns boolean
    if (not MapLocationCanBeTeleportedTo(GetConstructingStructure(), GetUnitX(GetConstructingStructure()), GetUnitY(GetConstructingStructure()))) then
        call KillUnit(GetConstructingStructure())
        call SimError(GetOwningPlayer(GetConstructingStructure()), GetLocalizedString("YOU_CANNOT_BUILD_HERE"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterAnyUnitEventBJ(constructStartTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(constructStartTrigger, Condition(function TriggerConditionConstructStart))
endfunction

endlibrary
