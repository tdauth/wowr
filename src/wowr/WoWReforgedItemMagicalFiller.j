library WoWReforgedItemMagicalFiller initializer Init requires SimError, WoWReforgedResources

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function MagicalFiller takes unit caster, unit mine returns nothing
    if (IsMine(mine) or GetUnitAbilityLevel(mine, 'Agld') > 0) then
        if (GetUnitAbilityLevel(mine, 'Agld') > 0) then
            call SetResourceAmount(mine, 9999999999)
        endif
        if (IsMine(mine)) then
            call RefillUnitResources(mine)
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_MUST_BE_A_MINE"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1VT') then
        call MagicalFiller(GetTriggerUnit(), GetSpellTargetUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
