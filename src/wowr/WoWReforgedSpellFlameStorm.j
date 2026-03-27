library WoWReforgedSpellFlameStorm initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger castTrigger = CreateTrigger()
endglobals

function FlameStorm takes unit caster, integer abilityId returns nothing
    local unit u = CreateUnit(GetOwningPlayer(caster), FLAME_STORM_DUMMY, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    call SkillAbility(u, ABILITY_FLAME_STORM_STARFALL, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    call IssueImmediateOrder(u, "starfall")
    call UnitApplyTimedLife(u, 'BTLF', 20.0)
    set u = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_FLAME_STORM) then
        call FlameStorm(GetTriggerUnit(), GetSpellAbilityId())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
