library WoWReforgedSpellHolyNova initializer Init requires MathUtils, SimError, WoWReforgedAbilitySkill

globals
    private unit tmpCaster = null
    
    private trigger castTrigger = CreateTrigger()
endglobals

function GetHolyNovaDamage takes unit caster, integer abilityId, integer level returns real
    return level * 40.0 + 80.0
endfunction

private function FilterIsEnemyInRange takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and ((IsUnitType(GetFilterUnit(), UNIT_TYPE_UNDEAD) and not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(tmpCaster)) and GetOwningPlayer(GetFilterUnit()) != GetOwningPlayer(tmpCaster) and not BlzIsUnitInvulnerable(GetFilterUnit())) or (not IsUnitType(GetFilterUnit(), UNIT_TYPE_UNDEAD) and (IsUnitAlly(GetFilterUnit(), GetOwningPlayer(tmpCaster)) or GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(tmpCaster)) and GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) < GetUnitState(GetFilterUnit(), UNIT_STATE_MAX_LIFE)))
endfunction

function HolyNova takes unit caster, integer abilityId returns nothing
    local player owner = GetOwningPlayer(caster)
    local real damage = GetHolyNovaDamage(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    local group targets = CreateGroup()
    local unit target = null
    local effect array effects
    local integer effectsCounter = 0
    local effect casterEffect
    local integer max = 0
    local integer i = 0
    set tmpCaster = caster
    call GroupEnumUnitsInRange(targets, GetUnitX(caster), GetUnitY(caster), 900.0, Filter(function FilterIsEnemyInRange))
    set max = BlzGroupGetSize(targets)
    if (max > 0) then
        set casterEffect = AddSpecialEffectTarget("war3mapImported\\Holy Nova.mdx", caster, "origin")
        loop
            exitwhen (i >= max)
            set target = BlzGroupUnitAt(targets, i)
            if (IsUnitAlly(target, owner) or GetOwningPlayer(target) == owner) then
                call SetUnitState(target, UNIT_STATE_LIFE, RMinBJ(GetUnitState(target, UNIT_STATE_LIFE) + damage, GetUnitState(target, UNIT_STATE_MAX_LIFE)))
            else
                call UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
            set effects[i] = AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin")
            set target = null
            set i = i + 1
        endloop
        call PolledWait(3.0)
        set i = 0
        set max = effectsCounter
        loop
            exitwhen (i >= max)
            call DestroyEffect(effects[i])
            set effects[i] = null
            set i = i + 1
        endloop
        call DestroyEffect(casterEffect)
        set casterEffect = null
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, GetLocalizedString("NO_VALID_TARGETS"))
    endif
    set owner = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_HOLY_NOVA
endfunction

private function TriggerActionCast takes nothing returns nothing
    call HolyNova(GetTriggerUnit(), GetSpellAbilityId())
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_HOLY_NOVA, GetHolyNovaDamage)
endfunction

endlibrary
