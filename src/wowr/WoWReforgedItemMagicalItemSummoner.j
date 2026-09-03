library WoWReforgedItemMagicalItemSummoner initializer Init requires SimError, SafeString, StringFormat, WoWReforgedRespawn

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function SummonItems takes unit caster, real radius returns nothing
    local integer count  = RespawnAllItemsInRange(GetUnitX(caster), GetUnitY(caster), radius)
    if (count > 0) then
        call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(caster))], Format(GetLocalizedStringSafe("RESPAWNED_X_ITEMS")).i(count).result())
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedStringSafe("NO_VALID_ITEMS"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0M8' or GetSpellAbilityId() == 'A1QA' ) then
        call SummonItems(GetTriggerUnit(), 1000.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
