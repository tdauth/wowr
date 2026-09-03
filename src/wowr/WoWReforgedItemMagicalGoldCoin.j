library WoWReforgedItemMagicalGoldCoin initializer Init requires SimError, WoWReforgedRaces

globals
    private boolexpr filterEnumRefillMine = null
    private trigger castTrigger = CreateTrigger()
endglobals

private function FilterEnumRefillMine takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and (IsUnitGoldmine(GetFilterUnit()) or IsUnitHousing(GetFilterUnit()))
endfunction

private function EnumRefillMine takes nothing returns nothing
    if (IsUnitGoldmine(GetEnumUnit())) then
        call SetResourceAmount(GetEnumUnit(), 999999)
    elseif (IsUnitHousing(GetEnumUnit())) then
        call SetResourceAmount(GetEnumUnit(), 10000)
    endif
endfunction

private function RefillGoldmines takes unit caster, real x, real y, real radius returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRange(g, x, y, radius, filterEnumRefillMine)
    if (BlzGroupGetSize(g) == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_TARGETS"))
    else
        call ForGroup(g, function EnumRefillMine)
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A21L') then
        call RefillGoldmines(GetTriggerUnit(), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 1000.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterEnumRefillMine = Filter(function FilterEnumRefillMine)
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
