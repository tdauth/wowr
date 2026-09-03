library WoWReforgedItemMagicalSeed initializer Init requires DestructableUtils, TreeUtils

globals
    private boolexpr filterEnumRestoreDestructableLife = null
    private trigger castTrigger = CreateTrigger()
endglobals

private function EnumRestoreDestructableLifeFilter takes nothing returns boolean
    return IsDestructableTree(GetFilterDestructable())
endfunction

private function EnumRestoreDestructableLife takes nothing returns nothing
    call DestructableRestoreLife(GetEnumDestructable(), GetDestructableMaxLife(GetEnumDestructable()), true)
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A01L' or GetSpellAbilityId() == 'A1Q9') then
        // Restore all trees in range
        call EnumDestructablesInCircle(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 1000.00, filterEnumRestoreDestructableLife, function EnumRestoreDestructableLife)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterEnumRestoreDestructableLife = Filter(function EnumRestoreDestructableLifeFilter)
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
