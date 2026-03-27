library WoWReforgedSpellFel initializer Init requires SimError, WoWReforgedI18n, WoWReforgedAbilitySkill

globals
    public constant integer FEL_ORC_ABILITY_ID = 'A1VZ'
    public constant integer MASS_FEL_ABILITY_ID = ABILITY_MASS_FEL // Fel Fountain, profession Warlock
    public constant integer BUFF_ABILITY_ID = 'A1WH'
    public constant integer ITEM_ABILITY_ID = 'A1WS' // I0Y7 Demon Blood
    public constant integer UNIT_ABILITY_ID = ABILITY_FEL
    public constant integer ATTACK_TYPE_CHAOS_VALUE = 5
    
    private constant integer KEY_TIMER = 0
    private constant integer KEY_OLD_ATTACK_TYPE_0 = 1
    private constant integer KEY_OLD_ATTACK_TYPE_1 = 2
    private constant integer KEY_CASTER = 3
    
    private unit tmpCaster = null
    private real tmpDuration = 0.0

    private trigger castTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    private group casters = CreateGroup()
endglobals

function GetFelDuration takes unit caster, integer abilityId, integer level returns real
    return I2R(level) * 2.0 + 20.0
endfunction

private function TimerFunctionExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local integer oldAttackType0 = LoadInteger(h, handleId, KEY_OLD_ATTACK_TYPE_0)
    local integer oldAttackType1 = LoadInteger(h, handleId, KEY_OLD_ATTACK_TYPE_1)
    local unit caster = LoadUnitHandle(h, handleId, KEY_CASTER)
    
    call BlzSetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, oldAttackType0)
    call BlzSetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, oldAttackType1)
    
    call UnitRemoveAbility(caster, BUFF_ABILITY_ID)
    
    call GroupRemoveUnit(casters, caster)
    
    call FlushChildHashtable(h, handleId)
    set handleId = GetHandleId(caster)
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
    set caster = null
endfunction

private function HasAttackTypes takes unit caster returns boolean
    return BlzGetUnitWeaponBooleanField(caster, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0) or BlzGetUnitWeaponBooleanField(caster, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1)
endfunction

private function HasNoChaosAttackTypeByDefault takes unit caster returns boolean
    local integer oldAttackType0 = BlzGetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
    local integer oldAttackType1 = BlzGetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1)
    local integer handleId = GetHandleId(caster)
    local boolean first = not HaveSavedHandle(h, handleId, KEY_TIMER)
    
    return not first or oldAttackType0 != ATTACK_TYPE_CHAOS_VALUE or oldAttackType1 != ATTACK_TYPE_CHAOS_VALUE
endfunction

function Fel takes unit caster, real duration returns nothing
    local integer oldAttackType0 = BlzGetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
    local integer oldAttackType1 = BlzGetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1)
    local integer handleId = GetHandleId(caster)
    local boolean first = not HaveSavedHandle(h, handleId, KEY_TIMER)
    local timer t = null
    if (first) then
        call BlzSetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, ATTACK_TYPE_CHAOS_VALUE)
        call BlzSetUnitWeaponIntegerField(caster, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, ATTACK_TYPE_CHAOS_VALUE)
        set t = CreateTimer()
    else
        set t = LoadTimerHandle(h, handleId, KEY_TIMER)
    endif
    call TimerStart(t, duration, false, function TimerFunctionExpire)
    if (first) then
        call SaveTimerHandle(h, handleId, KEY_TIMER, t)
        set handleId = GetHandleId(t)
        call SaveInteger(h, handleId, KEY_OLD_ATTACK_TYPE_0, oldAttackType0)
        call SaveInteger(h, handleId, KEY_OLD_ATTACK_TYPE_1, oldAttackType1)
        call SaveUnitHandle(h, handleId, KEY_CASTER, caster)
        call GroupAddUnit(casters, caster)
        call UnitAddAbility(caster, BUFF_ABILITY_ID)
    endif
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(tmpCaster)) and HasAttackTypes(GetFilterUnit()) and HasNoChaosAttackTypeByDefault(GetFilterUnit())
endfunction

private function ForGroupFunctionFel takes nothing returns nothing
    call Fel(GetEnumUnit(), tmpDuration)
endfunction

function MassFel takes unit caster, real x, real y, real duration returns nothing
    local group targets = CreateGroup()
    set tmpCaster = caster
    call GroupEnumUnitsInRange(targets, x, y, 512.0, Filter(function FilterIsValidTarget))
    
    if (BlzGroupGetSize(targets) > 0) then
        set tmpDuration = duration
        call ForGroup(targets, function ForGroupFunctionFel)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_VALID_TARGETS")) // No valid targets.
    endif
    
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local unit caster = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(caster, abilityId)
    if (abilityId == FEL_ORC_ABILITY_ID) then
        call Fel(caster, 10 + R2I(level) * 2.0) // BlzGetAbilityRealLevelField(BlzGetUnitAbility(GetTriggerUnit(), abilityId), ABILITY_RLF_DURATION_NORMAL, level)
    elseif (abilityId == ITEM_ABILITY_ID or abilityId == UNIT_ABILITY_ID) then
        if (HasAttackTypes(GetSpellTargetUnit())) then
            if (HasNoChaosAttackTypeByDefault(GetSpellTargetUnit())) then
                call Fel(GetSpellTargetUnit(), GetFelDuration(GetTriggerUnit(), abilityId, GetUnitAbilitySkillLevelSafe(GetTriggerUnit(), abilityId)))
            else
                call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_HAS_ALREADY_CHAOS_ATTACK"))
            endif
        else
            call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_HAS_NO_ATTACK"))
        endif
    elseif (abilityId == MASS_FEL_ABILITY_ID) then
        call MassFel(caster, GetSpellTargetX(), GetSpellTargetY(), GetFelDuration(GetTriggerUnit(), abilityId, GetUnitAbilitySkillLevelSafe(GetTriggerUnit(), abilityId)))
    endif
    set caster = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call RegisterAbilityFieldCustomReal0(ABILITY_FEL, GetFelDuration)
    call RegisterAbilityFieldCustomReal0(ABILITY_MASS_FEL, GetFelDuration)
endfunction

private function FlushCaster takes unit caster returns nothing
    local integer handleId = GetHandleId(caster)
    local timer t = LoadTimerHandle(h, handleId, KEY_TIMER)
    call GroupRemoveUnit(casters, caster)
    call FlushChildHashtable(h, handleId)
    set handleId = GetHandleId(t)
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, casters)) then
        call FlushCaster(whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
