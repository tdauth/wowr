library ManaBurn initializer Init requires SimError, TextTagUtils, SafeString

globals
    public constant integer ABILITY_ID = 'A0AP'

    private trigger channelTrigger = CreateTrigger()
endglobals

private function ManaBurn takes unit caster, unit target returns nothing
    local real mana = GetUnitState(target, UNIT_STATE_MANA)
    if (mana > 0.0) then
        call UnitDamageTarget(caster, target, mana, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        call SetUnitState(target, UNIT_STATE_MANA, 0.0)
        call ShowManaBurnTextTagForForce(null, GetUnitX(target), GetUnitY(target), R2I(mana))
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster) , GetLocalizedStringSafe("TARGET_HAS_NO_MANA"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call ManaBurn(GetTriggerUnit(), GetSpellTargetUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
