library WoWReforgedSpellSlide initializer Init requires Knockback, WoWReforgedUtils, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_SLIDE_PANDAREN = 'A1KB'

    private KnockbackType kbType = 0
    private trigger channelTrigger = CreateTrigger()
endglobals

function GetSlideDistance takes unit caster, integer abilityId, integer level returns real
    return I2R(level) * 60.0 + 100.0
endfunction

function GetSlideDamage takes unit caster, integer abilityId, integer level returns real
    return I2R(level) * 40.0
endfunction

private function onUnitHit takes Knockback kb, unit hit returns nothing
    local integer level = 0
    if (not IsUnitAlly(hit, GetOwningPlayer(kb.caster))) then
        set level = IMaxBJ(GetUnitAbilitySkillLevelSafe(kb.caster, ABILITY_SLIDE), GetUnitAbilitySkillLevelSafe(kb.caster, ABILITY_SLIDE_PANDAREN))
        call UnitDamageTarget(kb.caster, hit, GetSlideDamage(kb.caster, ABILITY_SLIDE, level), true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    endif
endfunction

private function onDestructableHit takes Knockback kb, destructable hit returns nothing
    if (IsDestructableTree(hit)) then
        call KillDestructable(hit)
    endif
endfunction

private function filterFunction takes Knockback kb, unit enum returns boolean
    return not IsUnitAlly(enum, GetOwningPlayer(kb.caster))
endfunction

private function Slide takes unit caster, integer abilityId, real x, real y returns nothing
    local integer level = GetUnitAbilitySkillLevelSafe(caster, abilityId)
    call Knockback.create(caster, caster, GetSlideDistance(caster, abilityId, level), 2.0, AngleBetweenCoordinatesDeg(GetUnitX(caster), GetUnitY(caster), x, y), kbType)
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (abilityId == ABILITY_SLIDE or abilityId == ABILITY_SLIDE_PANDAREN) then
        call Slide(GetTriggerUnit(), abilityId, GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set kbType = KnockbackType.create()
    set kbType.onUnitHitAction = onUnitHit
    set kbType.onDestructableHitAction = onDestructableHit
    set kbType.filterFunc = filterFunction
    
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call RegisterAbilityFieldCustomReal0(ABILITY_SLIDE, GetSlideDistance)
    call RegisterAbilityFieldCustomReal1(ABILITY_SLIDE, GetSlideDamage)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_SLIDE_PANDAREN, GetSlideDistance)
    call RegisterAbilityFieldCustomReal1(ABILITY_SLIDE_PANDAREN, GetSlideDamage)
endfunction

endlibrary
