library WoWReforgedSpellCharge initializer Init

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

private function TriggerActionChannel takes nothing returns nothing
    if (GetSpellAbilityId() == ABILITY_CHARGE) then
        call UnitResetCooldown(GetTriggerUnit())
        call BlzStartUnitAbilityCooldown(GetTriggerUnit(), ABILITY_CHARGE, BlzGetAbilityRealLevelField(BlzGetUnitAbility(GetTriggerUnit(), GetSpellAbilityId()), ABILITY_RLF_COOLDOWN, 1))
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(channelTrigger, function TriggerActionChannel)
endfunction

endlibrary
