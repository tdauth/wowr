library WoWReforgedSpellParry initializer Init requires SimError, MathUtils, TextTagUtils, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_ID = ABILITY_PARRY
    public constant integer BUFF_ABILITY_ID = 'A1Z7'
    private trigger castTrigger = CreateTrigger()
    private trigger attackTrigger = CreateTrigger()
    private group casters = CreateGroup()
    private hashtable h = InitHashtable()
endglobals

function GetParryDuration takes unit caster, integer abilityId, integer level returns real
    return 1.0 + I2R(level) * 0.5
endfunction

private function TimerFunctionExpires takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit caster = LoadUnitHandle(h, handleId, 0)
    
    call GroupRemoveUnit(casters, caster)
    call UnitRemoveAbility(caster, BUFF_ABILITY_ID)
    
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

function Parry takes unit caster returns nothing
    local integer handleId = GetHandleId(caster)
    local timer t = LoadTimerHandle(h, handleId, 0)
    local integer level = GetUnitAbilitySkillLevelSafe(caster, ABILITY_ID)
    local real duration = GetParryDuration(caster, ABILITY_ID, level)
    call GroupAddUnit(casters, caster)
    call UnitAddAbility(caster, BUFF_ABILITY_ID)
    if (t == null) then
        set t = CreateTimer()
    endif
    call TimerStart(t, duration, false, function TimerFunctionExpires)
    call SaveTimerHandle(h, handleId, 0, t)
    set handleId = GetHandleId(t)
    call SaveUnitHandle(h, handleId, 0, caster)
    set t = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call Parry(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionAttack takes nothing returns boolean
    local unit u = GetTriggerUnit()
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    if (IsUnitInGroup(GetTriggerUnit(), casters)) then
        call BlzUnitInterruptAttack(GetAttacker())
        call ShowFadingTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(u))], GetLocalizedString("PARRY_TEXTTAG"), 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
        call ShowFadingTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetAttacker()))], GetLocalizedString("PARRY_TEXTTAG"), 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
    endif
    set u = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerRegisterAnyUnitEventBJ(attackTrigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(attackTrigger, Condition(function TriggerConditionAttack))
    
    call RegisterAbilityFieldCustomReal0(ABILITY_PARRY, GetParryDuration)
endfunction

private function StopEffect takes unit whichUnit returns nothing
    local integer handleId = GetHandleId(whichUnit)
    local timer t = LoadTimerHandle(h, handleId, 0)
    call FlushChildHashtable(h, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    call FlushChildHashtable(h, handleId)
    call GroupRemoveUnit(casters, whichUnit)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, casters)) then
        call StopEffect(whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
