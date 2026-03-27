library WoWReforgedSpellSummonCreep initializer Init requires SimError, WoWReforgedAbilitySkill, WoWReforgedSummonedUnits

globals
    private trigger castTrigger = CreateTrigger()
endglobals

function GetSummonCreepCreepLevel takes unit caster, integer abilityId, integer level returns integer
    return IMinBJ(10, level)
endfunction

function SummonCreep takes unit caster, integer abilityId returns nothing
    local integer level = GetUnitAbilitySkillLevelSafe(caster, abilityId)
    local integer creepLevel = GetSummonCreepCreepLevel(caster, abilityId, level)
    local unit creep = CreateUnit(GetOwningPlayer(caster), ChooseRandomCreepBJ(creepLevel), GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    call UnitApplyTimedLife(creep, 'BTLF', 60.0)
    call AddSummonedUnitBonus(creep, level)
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_SUMMON_CREEP) then
        call SummonCreep(GetTriggerUnit(), ABILITY_SUMMON_CREEP)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_SUMMON_CREEP, GetSummonCreepCreepLevel)
endfunction

endlibrary
