library WoWReforgedAuraAbilities initializer Init requires Aura

globals
    AuraFilterFunction auraFilterFunc = 0
endglobals

function FilterIsNoInvulnerableInvalidTarget takes unit target returns boolean
        return GetUnitTypeId(target) != BACK_PACK and GetUnitTypeId(target) != EQUIPMENT_BAG and not BlzIsUnitInvulnerable(target)
endfunction

function FilterAlliedTargetsNonStructureMana takes unit caster, unit target, integer abilityId returns boolean
    return IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and GetUnitState(target, UNIT_STATE_MAX_MANA) > 0.0 and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraAlliedTargetsNonStructureMana takes nothing returns nothing
    set auraFilterFunc = FilterAlliedTargetsNonStructureMana
endfunction

function FilterAlliedTargetsNonStructure takes unit caster, unit target, integer abilityId returns boolean
    return IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraAlliedTargetsNonStructure takes nothing returns nothing
    set auraFilterFunc = FilterAlliedTargetsNonStructure
endfunction

function FilterAlliedTargetsNonStructureNoSummoned takes unit caster, unit target, integer abilityId returns boolean
    return IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and not IsUnitType(target, UNIT_TYPE_SUMMONED) and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraAlliedTargetsNonStructureNoSummoned takes nothing returns nothing
    set auraFilterFunc = FilterAlliedTargetsNonStructureNoSummoned
endfunction

function FilterAlliedTargets takes unit caster, unit target, integer abilityId returns boolean
    return IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraAlliedTargets takes nothing returns nothing
    set auraFilterFunc = FilterAlliedTargets
endfunction

function FilterEnemyTargets takes unit caster, unit target, integer abilityId returns boolean
    return not IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraEnemyTargets takes nothing returns nothing
    set auraFilterFunc = FilterEnemyTargets
endfunction

function FilterEnemyTargetsNonStructure takes unit caster, unit target, integer abilityId returns boolean
    return not IsUnitAlly(target, GetOwningPlayer(caster)) and IsUnitAliveBJ(target) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and FilterIsNoInvulnerableInvalidTarget(target)
endfunction

function SetAuraEnemyTargetsNonStructure takes nothing returns nothing
    set auraFilterFunc = FilterEnemyTargetsNonStructure
endfunction

function GetAuraBonus0 takes unit caster, integer abilityId, integer level returns real
    return LoadAura(abilityId).bonus_amount * I2R(level)
endfunction

function GetAuraBonus1 takes unit caster, integer abilityId, integer level returns real
    return LoadAura(abilityId).bonus_amount2 * I2R(level)
endfunction

function GetAuraBonus2 takes unit caster, integer abilityId, integer level returns real
    return LoadAura(abilityId).bonus_amount3 * I2R(level)
endfunction

private function Init takes nothing returns nothing
    call AddAura(ABILITY_PILLAGE_AURA, 'A142', 'A140', FilterAlliedTargetsNonStructure, 512.0, false, 0, 0.0, 0, 0.0, 0, 0.0)
    
    call AddAura(ABILITY_MISS_AURA, 'A1KV', 0, FilterEnemyTargetsNonStructure, 512.0, false, BONUS_MISS_CHANCE, 3.0, 0, 0.0, 0, 0.0)
    call RegisterAbilityFieldCustomReal0(ABILITY_MISS_AURA, GetAuraBonus0)
    
    call AddAura('A1L0', 'A1KV', 0, FilterEnemyTargetsNonStructure, 512.0, false, BONUS_MISS_CHANCE, 3.0, 0, 0.0, 0, 0.0)
    call RegisterAbilityFieldCustomReal0('A1L0', GetAuraBonus0)
    
    call AddAura(ABILITY_DRUNKEN_AURA, 'A1E1', 0, FilterAlliedTargetsNonStructure, 512.0, false, BONUS_CRITICAL_CHANCE, 1.0, BONUS_CRITICAL_DAMAGE, 0.4, BONUS_EVASION_CHANCE, 1.0)
    call RegisterAbilityFieldCustomReal0(ABILITY_DRUNKEN_AURA, GetAuraBonus0)
    call RegisterAbilityFieldCustomReal1(ABILITY_DRUNKEN_AURA, GetAuraBonus1)
    call RegisterAbilityFieldCustomReal2(ABILITY_DRUNKEN_AURA, GetAuraBonus2)
endfunction

endlibrary
