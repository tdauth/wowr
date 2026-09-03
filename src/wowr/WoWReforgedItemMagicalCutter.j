library WoWReforgedItemMagicalCutter initializer Init requires DestructableUtils, TreeUtils

globals
    private boolexpr filterEnumKillDestructable = null
    private trigger castTrigger = CreateTrigger()
endglobals

private function EnumKillDestructableFilter takes nothing returns boolean
    return IsDestructableTree(GetFilterDestructable())
endfunction

private function EnumKillDestructable takes nothing returns nothing
    call KillDestructable(GetEnumDestructable())
endfunction

function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A069' or GetSpellAbilityId() == 'A1QB') then
        call EnumDestructablesInCircle(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 1000.00, filterEnumKillDestructable, function EnumKillDestructable)
    endif
    return true
endfunction

private function Init takes nothing returns nothing
    set filterEnumKillDestructable = Filter(function EnumKillDestructableFilter)
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary

