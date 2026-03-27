library WoWReforgedSpellReflection initializer Init requires MathUtils, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_ID = ABILITY_REFLECTION
    public constant integer DUMMY_UNIT_TYPE_ID = 'h0T4'
    private trigger damageTrigger = CreateTrigger()
endglobals

function GetReflectionChance takes unit caster, integer abilityId, integer level returns real
    return RMinBJ(I2R(level) * 0.05, 0.9)
endfunction

function GetReflectionPercentage takes unit caster, integer abilityId, integer level returns real
    return RMinBJ(I2R(level) * 0.05, 0.9)
endfunction

function Reflect takes unit whichUnit, unit source, real damage returns nothing
    local unit dummy = CreateUnit(GetOwningPlayer(whichUnit), DUMMY_UNIT_TYPE_ID, GetUnitX(whichUnit), GetUnitY(whichUnit), AngleBetweenUnitsDeg(whichUnit, source))

    call SetUnitState(whichUnit, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE) + damage)

    call BlzSetUnitWeaponStringField(dummy, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0, BlzGetUnitWeaponStringField(source, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE     , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE     , 0))             
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE      , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE      , 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE      , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE      , 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE               , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE               , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND              , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND              , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS                  , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS                  , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED                         , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED                         , 0))
    
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT                            , 0))
    
    call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN                            , 0))
    call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS                            , 0))

    //call BlzSetUnitAttackCooldown(dummy, BlzGetUnitAttackCooldown(dummy, 0), 0)
    
    //call SetUnitAnimation(whichUnit, "Parry")
    //call SetUnitAnimationByIndex(whichUnit, 8)
    call IssueTargetOrder(dummy, "attack", source)
    
    call TriggerSleepAction(BlzGetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0))
    call RemoveUnit(dummy)
    set dummy = null
endfunction

private function TriggerConditionDamage takes nothing returns boolean
    local integer level = GetUnitAbilitySkillLevelSafe(GetTriggerUnit(), ABILITY_ID)
    return level > 0 and BlzGetEventWeaponType() == WEAPON_TYPE_WHOKNOWS and GetRandomInt(0, 100) <= R2I(GetReflectionChance(GetTriggerUnit(), ABILITY_ID, level) * 100.0)
endfunction

private function TriggerActionDamage takes nothing returns nothing
    local integer level = GetUnitAbilitySkillLevelSafe(GetTriggerUnit(), ABILITY_ID)
    call Reflect(GetTriggerUnit(), GetEventDamageSource(), GetEventDamage() * GetReflectionPercentage(GetTriggerUnit(), ABILITY_ID, level))
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damageTrigger, Condition(function TriggerConditionDamage))
    call TriggerAddAction(damageTrigger, function TriggerActionDamage)
    
    call RegisterAbilityFieldCustomReal0(ABILITY_ID, GetReflectionChance)
    call RegisterAbilityFieldCustomReal1(ABILITY_ID, GetReflectionPercentage)
endfunction

endlibrary
