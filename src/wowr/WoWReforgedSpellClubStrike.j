library WoWReforgedSpellClubStrike initializer Init requires SimError, Knockback, TreeUtils, MathUtils, WoWReforgedAbilitySkill

globals
    private KnockbackType kbType = 0
    private trigger castTrigger = CreateTrigger()
    private player tmpPlayer = null
endglobals

function GetClubStrikeDistance takes unit caster, integer abilityId, integer level returns real
    return 50.0 + I2R(level) * 100.0
endfunction

function GetClubStrikeDamage takes unit caster, integer abilityId, integer level returns real
    return I2R(level) * 30.0
endfunction

private function onUnitHit takes Knockback kb, unit hit returns nothing
    if (not IsUnitAlly(hit, GetOwningPlayer(kb.caster))) then
        call UnitDamageTarget(kb.caster, hit, GetClubStrikeDamage(kb.caster, ABILITY_CLUB_STRIKE, GetUnitAbilitySkillLevelSafe(kb.caster, ABILITY_CLUB_STRIKE)), true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
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

private function FiterIsTarget takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitAlly(GetFilterUnit(), tmpPlayer)
endfunction

function ClubStrike takes unit caster, integer abilityId returns nothing
    local group targets = CreateGroup()
    local integer i = 0
    local integer max = 0
    local real distance = GetClubStrikeDistance(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    local unit target = null
    set tmpPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(targets, GetUnitX(caster), GetUnitY(caster), 512.0, Filter(function FiterIsTarget))
    set max = BlzGroupGetSize(targets)
    if (max > 0) then
        set i = 0
        loop
            exitwhen (i == max)
            set target = BlzGroupUnitAt(targets, i)
            call Knockback.create(caster, target, distance, 2.0, AngleBetweenUnitsDeg(caster, target), kbType)
            set target = null
            set i = i + 1
        endloop
    else
        call SimError(tmpPlayer, GetLocalizedString("NO_TARGETS"))
        call IssueImmediateOrder(caster, "stop")
    endif
    set tmpPlayer = null
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_CLUB_STRIKE) then
        call ClubStrike(GetTriggerUnit(), ABILITY_CLUB_STRIKE)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    set kbType = KnockbackType.create()
    set kbType.onUnitHitAction = onUnitHit
    set kbType.onDestructableHitAction = onDestructableHit
    set kbType.filterFunc = filterFunction
    
    call RegisterAbilityFieldCustomReal0(ABILITY_CLUB_STRIKE, GetClubStrikeDistance)
    call RegisterAbilityFieldCustomReal1(ABILITY_CLUB_STRIKE, GetClubStrikeDamage)
endfunction

endlibrary
