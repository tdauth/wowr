library WoWReforgedItemMagicalCreepSummoner initializer Init requires SimError, SafeString, StringFormat, WoWReforgedRespawn

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function SummonCreeps takes unit caster, real radius returns nothing
    local integer count = RespawnAllGroupsInRange(GetUnitX(caster), GetUnitY(caster), radius)
    if (count > 0) then
        call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(caster))], Format(GetLocalizedStringSafe("SUMMONED_X_CREEP_SPOTS")).i(count). result())
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedStringSafe("NO_VALID_TARGETS"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A06B' or GetSpellAbilityId() == 'A1Q8') then
        call SummonCreeps(GetTriggerUnit(), 1000.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
