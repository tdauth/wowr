library Corpse initializer Init

globals
    public constant integer ABILITY_ID = 'A1NL'
    public constant integer ABILITY_ID_ITEM = 'A1M0'

    private trigger castTrigger = CreateTrigger()
endglobals

function Corpse takes integer abilityId, unit caster, real x, real y returns nothing
    call CreateCorpse(GetOwningPlayer(caster), 'ucry', x, y, 0.0)
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID_ITEM or GetSpellAbilityId() == ABILITY_ID) then
        call Corpse(GetSpellAbilityId(), GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
