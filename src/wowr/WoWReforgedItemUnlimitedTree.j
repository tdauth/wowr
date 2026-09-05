library WoWReforgedItemUnlimitedTree initializer Init

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A11D') then
        call CreateDestructable('B00G', GetSpellTargetX(), GetSpellTargetY(), GetRandomDirectionDeg(), 1, 0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ( castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( castTrigger, Condition( function TriggerConditionCast ) )
endfunction

endlibrary
