library WoWReforgedMassAbilities initializer Init requires MassSpell, WoWReforgedAbilitySkill

private function FilterFunctionMassSpell takes nothing returns boolean
    local unit caster = GetMassSpellFilterCaster()
    local integer abilityId = GetMassSpellFilterAbilityId()
    local unit u = GetFilterUnit()
    local boolean result = false
    if (abilityId == ABILITY_MASS_INNER_FIRE) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_CHARM or abilityId == ABILITY_MASS_CHARM_ITEM) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and (abilityId == ABILITY_MASS_CHARM_ITEM or GetUnitLevel(u) <= GetUnitAbilitySkillLevelSafe(caster, abilityId) * 5)
    elseif (abilityId == ABILITY_MASS_FINGER_OF_DEATH) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u)
    elseif (abilityId == ABILITY_MASS_DOOM) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and GetUnitLevel(u) <= GetUnitAbilitySkillLevelSafe(caster, abilityId) * 5
    elseif (abilityId == ABILITY_MASS_TRANSMUTE) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and GetUnitLevel(u) <= GetUnitAbilitySkillLevelSafe(caster, abilityId) * 5
    elseif (abilityId == ABILITY_MASS_INVISIBILITY) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_POLYMORPH) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and GetUnitLevel(u) <= GetUnitAbilitySkillLevelSafe(caster, abilityId) * 5
    elseif (abilityId == ABILITY_MASS_SLOW) then    
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u)
    elseif (abilityId == ABILITY_MASS_ENSNARE) then    
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE)
    elseif (abilityId == ABILITY_MASS_ILLUSION) then  
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_CYCLONE) then  
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitAlly(u, GetOwningPlayer(caster)) and not BlzIsUnitInvulnerable(u)
    elseif (abilityId == ABILITY_MASS_REJUVENATION) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_FIREBOLT) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u)
    elseif (abilityId == ABILITY_MASS_BLOODLUST) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(u, GetOwningPlayer(caster))    
    elseif (abilityId == ABILITY_MASS_MANA_BURN) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not IsUnitAlly(u, GetOwningPlayer(caster)) and GetUnitState(u, UNIT_STATE_MANA) > 0.0
    elseif (abilityId == ABILITY_MASS_CRIPPLE) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not IsUnitAlly(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_HEX) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and not IsUnitAlly(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_SLEEP) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and not IsUnitAlly(u, GetOwningPlayer(caster))
    elseif (abilityId == ABILITY_MASS_CONTROL_MAGIC) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u) and GetUnitLevel(u) <= GetUnitAbilitySkillLevelSafe(caster, abilityId) * 5
    elseif (abilityId == ABILITY_MASS_ENTANGLING_ROOTS or abilityId == ABILITY_MASS_ENTANGLING_ROOTS_ITEM) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and not BlzIsUnitInvulnerable(u)
    elseif (abilityId == ABILITY_MASS_DEATH_COIL) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and ((IsUnitType(u, UNIT_TYPE_UNDEAD) and IsUnitAlly(u, GetOwningPlayer(caster))) or (IsUnitType(u, UNIT_TYPE_UNDEAD) and not IsUnitAlly(u, GetOwningPlayer(caster))))
    elseif (abilityId == ABILITY_MASS_HOLY_LIGHT or abilityId == ABILITY_MASS_HOLY_LIGHT_ITEM) then
        set result = IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and ((IsUnitType(u, UNIT_TYPE_UNDEAD) and not IsUnitAlly(u, GetOwningPlayer(caster))) or (IsUnitType(u, UNIT_TYPE_UNDEAD) and IsUnitAlly(u, GetOwningPlayer(caster))))
    endif
    
    set caster = null
    set u = null
    
    return result
endfunction

private function MassSpellDummyAbilityLevelFunction takes unit caster, integer abilityId, unit dummy, MassSpell s returns nothing
    call SkillAbility(dummy, s.dummyAbilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
endfunction

private function AddMassAbility takes integer dummyAbilityId, string order, real radius, integer abilityId0, integer abilityId1, integer abilityId2 returns MassSpell
    local MassSpell s = AddMassSpell(dummyAbilityId, order, radius, Filter(function FilterFunctionMassSpell), MassSpellDummyAbilityLevelFunction)
    if (abilityId0 != 0) then
        call RegisterMassSpell(abilityId0, s)
    endif
    if (abilityId1 != 0) then
        call RegisterMassSpell(abilityId1, s)
    endif
    if (abilityId2 != 0) then
        call RegisterMassSpell(abilityId2, s)
    endif
    return s
endfunction

private function Init takes nothing returns nothing
    call AddMassAbility(ABILITY_MASS_INNER_FIRE_DUMMY, "innerfire", 512.0, ABILITY_MASS_INNER_FIRE, 0, 0)
    call AddMassAbility(ABILITY_MASS_CHARM_DUMMY, "charm", 512.0, ABILITY_MASS_CHARM, ABILITY_MASS_CHARM_ITEM, 0)
    call AddMassAbility(ABILITY_MASS_FINGER_OF_DEATH_DUMMY, "fingerofdeath", 512.0, ABILITY_MASS_FINGER_OF_DEATH, 0, 0)
    call AddMassAbility(ABILITY_MASS_DOOM_DUMMY, "doom", 512.0, ABILITY_MASS_DOOM, 0, 0)
    call AddMassAbility(ABILITY_MASS_TRANSMUTE_DUMMY, "transmute", 512.0, ABILITY_MASS_TRANSMUTE, 0, 0)
    call AddMassAbility(ABILITY_MASS_INVISIBILITY_DUMMY, "invisibility", 512.0, ABILITY_MASS_INVISIBILITY, 0, 0)
    call AddMassAbility(ABILITY_MASS_POLYMORPH_DUMMY, "polymorph", 512.0, ABILITY_MASS_POLYMORPH, 0, 0)
    call AddMassAbility(ABILITY_MASS_SLOW_DUMMY, "slow", 512.0, ABILITY_MASS_SLOW, 0, 0)
    call AddMassAbility(ABILITY_MASS_ENSNARE_DUMMY, "ensnare", 512.0, ABILITY_MASS_ENSNARE, 0, 0)
    call AddMassAbility(ABILITY_MASS_ILLUSION_DUMMY, "firebolt", 512.0, ABILITY_MASS_ILLUSION, 0, 0)
    call AddMassAbility(ABILITY_MASS_CYCLONE_DUMMY, "cyclone", 512.0, ABILITY_MASS_CYCLONE, 0, 0)
    call AddMassAbility(ABILITY_MASS_REJUVENATION_DUMMY, "rejuvenation", 512.0, ABILITY_MASS_REJUVENATION, 0, 0)
    call AddMassAbility(ABILITY_MASS_FIREBOLT_DUMMY, "firebolt", 512.0, ABILITY_MASS_FIREBOLT, 0, 0)
    call AddMassAbility(ABILITY_MASS_BLOODLUST_DUMMY, "bloodlust", 512.0, ABILITY_MASS_BLOODLUST, 0, 0)
    call AddMassAbility(ABILITY_MASS_MANA_BURN_DUMMY, "manaburn", 512.0, ABILITY_MASS_MANA_BURN, 0, 0)
    call AddMassAbility(ABILITY_MASS_CRIPPLE_DUMMY, "cripple", 512.0, ABILITY_MASS_CRIPPLE, 0, 0)
    call AddMassAbility(ABILITY_MASS_HEX_DUMMY, "hex", 512.0, ABILITY_MASS_HEX, 0, 0)
    call AddMassAbility(ABILITY_MASS_SLEEP_DUMMY, "sleep", 512.0, ABILITY_MASS_SLEEP, 0, 0)
    call AddMassAbility(ABILITY_MASS_CONTROL_MAGIC_DUMMY, "controlmagic", 512.0, ABILITY_MASS_CONTROL_MAGIC, 0, 0)
    call AddMassAbility(ABILITY_MASS_ENTANGLING_ROOTS_DUMMY, "entanglingroots", 512.0, ABILITY_MASS_ENTANGLING_ROOTS, ABILITY_MASS_ENTANGLING_ROOTS_ITEM, 0)
    call AddMassAbility(ABILITY_MASS_DEATH_COIL_DUMMY, "deathcoil", 512.0, ABILITY_MASS_DEATH_COIL, 0, 0)
    call AddMassAbility(ABILITY_MASS_HOLY_LIGHT_DUMMY, "holylight", 512.0, ABILITY_MASS_HOLY_LIGHT, ABILITY_MASS_HOLY_LIGHT_ITEM, 0)
endfunction

endlibrary
