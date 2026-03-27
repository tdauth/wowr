library WoWReforgedSpellDivineShield initializer Init requires SimError, WoWReforgedI18n, WoWReforgedAbilitySkill

globals
    public constant integer UNIT_ABILITY_ID = ABILITY_DIVINE_SHIELD
    
    public constant integer ABILITY_TEMPORARY_INVULNERABILITY_DIVINITY_ITEM = 'A1O0'
    public constant integer ABILITY_TEMPORARY_INVULNERABILITY_LESSER_ITEM = 'A1O1'
    
    public constant integer BUFF_ABILITY_ID = 'A01C'
    
    public constant integer DEFENSE_TYPE_DIVINE_VALUE = 6
    
    private constant integer KEY_TIMER = 0
    private constant integer KEY_OLD_DEFENSE_TYPE = 1
    private constant integer KEY_CASTER = 2
    
    private unit tmpCaster = null
    private real tmpDuration = 0.0

    private trigger castTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    private group casters = CreateGroup()
endglobals

function GetDivineShieldDuration takes unit caster, integer abilityId, integer level returns real
    return I2R(level) * 2.0 + 20.0
endfunction

private function TimerFunctionExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local integer oldDefenseType = LoadInteger(h, handleId, KEY_OLD_DEFENSE_TYPE)
    local unit caster = LoadUnitHandle(h, handleId, KEY_CASTER)
    
    call BlzSetUnitIntegerField(caster, UNIT_IF_DEFENSE_TYPE, oldDefenseType)
    
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

private function HasNoDivineDefenseTypeByDefault takes unit caster returns boolean
    local integer oldDefenseType = BlzGetUnitIntegerField(caster, UNIT_IF_DEFENSE_TYPE)
    local integer handleId = GetHandleId(caster)
    local boolean first = not HaveSavedHandle(h, handleId, KEY_TIMER)
    
    return not first or oldDefenseType != DEFENSE_TYPE_DIVINE_VALUE
endfunction

function DivineShield takes unit caster, real duration returns nothing
    local integer oldDefenseType = BlzGetUnitIntegerField(caster, UNIT_IF_DEFENSE_TYPE)
    local integer handleId = GetHandleId(caster)
    local boolean first = not HaveSavedHandle(h, handleId, KEY_TIMER)
    local timer t = null
    if (first) then
        call BlzSetUnitIntegerField(caster, UNIT_IF_DEFENSE_TYPE, DEFENSE_TYPE_DIVINE_VALUE)
        set t = CreateTimer()
    else
        set t = LoadTimerHandle(h, handleId, KEY_TIMER)
    endif
    call TimerStart(t, duration, false, function TimerFunctionExpire)
    if (first) then
        call SaveTimerHandle(h, handleId, KEY_TIMER, t)
        set handleId = GetHandleId(t)
        call SaveInteger(h, handleId, KEY_OLD_DEFENSE_TYPE, oldDefenseType)
        call SaveUnitHandle(h, handleId, KEY_CASTER, caster)
        call GroupAddUnit(casters, caster)
        call UnitAddAbility(caster, BUFF_ABILITY_ID)
    endif
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(tmpCaster)) and HasNoDivineDefenseTypeByDefault(GetFilterUnit())
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local unit caster = GetTriggerUnit()
    if (abilityId == ABILITY_TEMPORARY_INVULNERABILITY_DIVINITY_ITEM or abilityId == ABILITY_TEMPORARY_INVULNERABILITY_LESSER_ITEM) then
        call DivineShield(caster, 10 * 2.0) // BlzGetAbilityRealLevelField(BlzGetUnitAbility(GetTriggerUnit(), abilityId), ABILITY_RLF_DURATION_NORMAL, level)
    elseif (abilityId == UNIT_ABILITY_ID) then
        if (HasNoDivineDefenseTypeByDefault(GetSpellTargetUnit())) then
            call DivineShield(GetSpellTargetUnit(), GetDivineShieldDuration(GetTriggerUnit(), abilityId, GetUnitAbilitySkillLevelSafe(GetTriggerUnit(), abilityId)))
        else
            call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_HAS_ALREADY_DIVINE_DEFENSE"))
        endif
    endif
    set caster = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call RegisterAbilityFieldCustomReal0(ABILITY_DIVINE_SHIELD, GetDivineShieldDuration)
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
