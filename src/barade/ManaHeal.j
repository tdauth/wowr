library ManaHeal initializer Init requires SimError, TextTagUtils, SafeString

globals
    public constant integer ABILITY_ID = 'A0AO'

    private trigger channelTrigger = CreateTrigger()
endglobals

private function ManaHeal takes unit caster returns nothing
    local real mana = GetUnitState(caster, UNIT_STATE_MANA)
    if (mana > 0.0) then
        if (GetUnitState(caster, UNIT_STATE_LIFE) < GetUnitState(caster, UNIT_STATE_MAX_LIFE)) then
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + mana)
            call SetUnitState(caster, UNIT_STATE_MANA, 0.0)
            call ShowGeneralFadingTextTagForForce(null, I2S(R2I(mana)), GetUnitX(caster), GetUnitY(caster), 0, 255, 0, 0)
        else
            call IssueImmediateOrder(caster, "stop")
            call SimError(GetOwningPlayer(caster), GetLocalizedStringSafe("HERO_HAS_FULL_LIFE"))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster) , GetLocalizedStringSafe("TARGET_HAS_NO_MANA"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call ManaHeal(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
