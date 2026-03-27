library WoWReforgedSpellWindGust initializer onInit requires SimError, Knockback, WoWReforgedAbilitySkill

globals
    private trigger channelTrigger = CreateTrigger()
    private KnockbackType knockbackType
    private constant integer ABILITY_ID = ABILITY_WIND_GUST
    private constant string EFFECT = "Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl"
    private constant string EXPLOSION_EFFECT = "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl"
endglobals

function GetWindGustDamage takes unit caster, integer abilityId, integer level returns real
    return 150.00 + I2R(level) * 40.0
endfunction

function GetWindGustDistance takes unit caster, integer abilityId, integer level returns real
    return 150.00 + I2R(level) * 40.0
endfunction

//let us explode explosive barrels
function onDestHit takes Knockback kb, destructable hit returns nothing
    if (IsTree(GetDestructableTypeId(hit))) then
        call kb.destroy()
        call DestroyEffect(AddSpecialEffect(EXPLOSION_EFFECT, GetDestructableX(hit), GetDestructableY(hit)))
        call KillDestructable(hit)
        call UnitDamagePoint(kb.caster, 0.15, 175., GetDestructableX(hit), GetDestructableY(hit), GetWindGustDamage(kb.caster, ABILITY_ID, GetUnitAbilitySkillLevelSafe(kb.caster, ABILITY_ID)), false, true, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_FIRE, null)
        call RemoveDestructable(hit)
    else
        call KillDestructable(hit)
    endif
endfunction

//this filters all units out that should not be knocked back
function filterFunc takes Knockback kb, unit enum returns boolean
    return IsUnitEnemy(enum, GetOwningPlayer(kb.caster)) and not IsUnitType(enum, UNIT_TYPE_FLYING) and not IsUnitType(enum, UNIT_TYPE_MAGIC_IMMUNE) and not IsUnitType(enum, UNIT_TYPE_STRUCTURE)
endfunction

//when the units hits another unit
function onUnitHit takes Knockback kb, unit hit returns nothing
    local real angle = (Atan2((GetUnitY(kb.target)-GetUnitY(hit)), (GetUnitX(kb.target)-GetUnitX(hit))) - 180) * bj_RADTODEG
    call UnitDamageTarget(kb.caster, hit, GetWindGustDamage(kb.caster, ABILITY_ID, GetUnitAbilitySkillLevelSafe(kb.caster, ABILITY_ID)), false, true, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, null)
    if not Knockback.isUnitKnockedBack(hit) then
        call Knockback.create(kb.caster, hit, kb.distance * 0.5, kb.duration * 0.5, angle, knockbackType)
    endif
endfunction

private function FilterTargets takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_MAGIC_IMMUNE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_FLYING)
endfunction

//start the knockback
private function WindGust takes unit caster, real x, real y returns nothing
    local player casterOwner = GetOwningPlayer(caster)
    local group targets = CreateGroup()
    local unit target = null
    local location targetLoc = null
    local location casterLoc = GetUnitLoc(caster)
    local real angle = 0.0
    local integer i = 0
    local integer targetCounter = 0
    call GroupEnumUnitsInRange(targets, x, y, 512.0, Filter(function FilterTargets))
    loop
        exitwhen (i == BlzGroupGetSize(targets))
        set target = BlzGroupUnitAt(targets, i)
        if (IsUnitEnemy(target, casterOwner)) then
            set targetLoc = GetUnitLoc(target)
            set angle = AngleBetweenPoints(casterLoc, targetLoc)
            call Knockback.create(caster, target, GetWindGustDistance(caster, ABILITY_ID, GetUnitAbilitySkillLevelSafe(caster, ABILITY_ID)), 1.5, angle, knockbackType).addSpecialEffect(EFFECT, "origin")
            call RemoveLocation(targetLoc)
            set targetLoc = null
            set targetCounter = targetCounter + 1
        endif
        set target = null
        set i = i + 1
    endloop
    call RemoveLocation(casterLoc)
    set casterLoc = null
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
    if (targetCounter == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(casterOwner, GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
    endif
    set casterOwner = null
endfunction

private function TriggerActionChannel takes nothing returns nothing
    if (GetSpellAbilityId() == ABILITY_ID) then
        call WindGust(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
endfunction
    
private function onInit takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(channelTrigger, function TriggerActionChannel)

    set knockbackType = KnockbackType.create()
    set knockbackType.onDestructableHitAction = onDestHit
    set knockbackType.onUnitHitAction = onUnitHit
    set knockbackType.filterFunc = filterFunc
    
    call RegisterAbilityFieldCustomReal0(ABILITY_WIND_GUST, GetWindGustDamage)
    call RegisterAbilityFieldCustomReal1(ABILITY_WIND_GUST, GetWindGustDistance)
endfunction

endlibrary
