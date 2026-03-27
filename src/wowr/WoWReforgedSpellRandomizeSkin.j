library WoWReforgedSpellRandomizeSkin initializer Init requires WoWReforgedSkins, WoWReforgedSkinDependencyEquivalents

globals
    private trigger castTrigger = CreateTrigger()
endglobals

function RandomizeSkin takes unit caster returns nothing
    call RandomizeHeroSkin(caster)
    call SelectUnitAddForPlayer(caster, GetOwningPlayer(caster))
    call ForceUIKeyBJ(GetOwningPlayer(caster), "C")
    call ForceUIKeyBJ(GetOwningPlayer(caster), "G")
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1XO') then
        call RandomizeSkin(GetTriggerUnit())
    elseif (GetSpellAbilityId() == NEXT_SKIN_ABILITY_ID or GetSpellAbilityId() == NEXT_SKIN_ITEM_ABILITY_ID) then
        call NextSkin(GetTriggerUnit())
        call SelectUnitAddForPlayer(GetTriggerUnit(), GetOwningPlayer(GetTriggerUnit()))
        call ForceUIKeyBJ(GetOwningPlayer(GetTriggerUnit()), "C")
        call ForceUIKeyBJ(GetOwningPlayer(GetTriggerUnit()), "G")
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
