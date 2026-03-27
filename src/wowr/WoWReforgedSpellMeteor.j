library WoWReforgedSpellMeteor initializer Init requires Knockback, TreeUtils, WoWReforgedUtils, WoWReforgedAbilitySkill

globals    
    private KnockbackType kbType = 0
    private trigger castTrigger = CreateTrigger()
    private unit filterCaster = null
endglobals

private function onUnitHit takes Knockback kb, unit hit returns nothing
    //if (not IsUnitAlly(hit, GetOwningPlayer(kb.caster))) then
        //call UnitDamageTarget(kb.caster, hit, GetUnitAbilityLevel(kb.caster, 'A0W7') * 100.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    //endif
endfunction

private function onDestructableHit takes Knockback kb, destructable hit returns nothing
    if (IsDestructableTree(hit)) then
        call KillDestructable(hit)
    endif
endfunction

private function filterFunction takes Knockback kb, unit enum returns boolean
    return not IsUnitAlly(enum, GetOwningPlayer(kb.caster))
endfunction

function IsMeteorAbilityId takes integer abilityId returns boolean
    return abilityId == ABILITY_METEOR_ITEM or abilityId == ABILITY_METEOR_ARCANE_OBSERVATORY or abilityId == ABILITY_METEOR
endfunction

function GetMeteorDamage takes unit caster, integer abilityId, integer level returns real
    return 100.00 + I2R(level) * 30.00
endfunction

function GetMeteorDistance takes unit caster, integer abilityId, integer level returns real
    return 500.0 + I2R(level) * 60.0
endfunction

private function FilterIsTarget takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_GROUND) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_MAGIC_IMMUNE) and IsUnitAliveBJ(GetFilterUnit()) and not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(filterCaster)) and GetOwningPlayer(GetFilterUnit()) != GetOwningPlayer(filterCaster)
endfunction

private function EnumKillTree takes nothing returns nothing
    if (IsTree(GetDestructableTypeId(GetEnumDestructable()))) then
        call KillDestructable(GetEnumDestructable())
    endif
endfunction

function Meteor takes unit caster, integer abilityId, real x, real y returns nothing
    local effect e = null
    local group targets = CreateGroup()
    local unit dummy = null
    local group dummies = CreateGroup()
    local unit target = null
    local integer level = GetUnitAbilitySkillLevel(caster, abilityId)
    local integer i = 0
    local integer max = 0
    local real distance = 0.0
    local location l = Location(x, y)
    call PolledWait(2.0)
    set e = AddSpecialEffect("war3mapImported\\MeteorStrike.mdx", x, y)
    call UnitDamagePoint(caster, 0.0, 512.0, x, y, GetMeteorDamage(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId)), true, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
    call PolledWait(0.80)
    call EnumDestructablesInCircleBJ(512.0, l, function EnumKillTree)
    set filterCaster = caster
    call GroupEnumUnitsInRange(targets, x, y, 512.0, Filter(function FilterIsTarget))
    set max = BlzGroupGetSize(targets)
    if (max > 0) then
        set distance = GetMeteorDistance(caster, abilityId, level)
        set i = 0
        loop
            exitwhen (i == max)
            set target = BlzGroupUnitAt(targets, i)
            // Stun
            set dummy = CreateUnit(GetOwningPlayer(caster), 'h0PX', GetUnitX(target), GetUnitY(target), bj_UNIT_FACING)
            call ShowUnit(dummy, false)
            call SkillAbility(dummy, ABILITY_METEOR_DUMMY, level)
            call IssueTargetOrder(dummy, "firebolt", target)
            call GroupAddUnit(dummies, dummy)
            call Knockback.create(target, target, distance, 2.0, AngleBetweenUnitsDeg(dummy, target), kbType)
            set target = null
            set i = i + 1
        endloop
    endif
    call PolledWait(4.00)
    call DestroyEffect(e)
    set e = null
    call GroupClear(dummies)
    call DestroyGroup(dummies)
    set dummies = null
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
    call RemoveLocation(l)
    set l = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    return IsMeteorAbilityId(GetSpellAbilityId())
endfunction

private function TriggerActionCast takes nothing returns nothing
    call Meteor(GetTriggerUnit(), GetSpellAbilityId(), GetSpellTargetX(), GetSpellTargetY())
endfunction

private function Init takes nothing returns nothing
    set kbType = KnockbackType.create()
    set kbType.onUnitHitAction = onUnitHit
    set kbType.onDestructableHitAction = onDestructableHit
    set kbType.filterFunc = filterFunction
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_METEOR, GetMeteorDamage)
    call RegisterAbilityFieldCustomReal1(ABILITY_METEOR, GetMeteorDistance)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_METEOR_ARCANE_OBSERVATORY, GetMeteorDamage)
    call RegisterAbilityFieldCustomReal1(ABILITY_METEOR_ARCANE_OBSERVATORY, GetMeteorDistance)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_METEOR_ITEM, GetMeteorDamage)
    call RegisterAbilityFieldCustomReal1(ABILITY_METEOR_ITEM, GetMeteorDistance)
endfunction

endlibrary
