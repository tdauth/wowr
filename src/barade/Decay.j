library Decay initializer Init requires SimError

globals
    //public constant integer ABILITY_ID = 'A1BP'
    public constant integer ABILITY_ID_ITEM = 'A1BR'

    private trigger castTrigger = CreateTrigger()
endglobals

private function FilterIsCorpse takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and IsUnitDeadBJ(GetFilterUnit())
endfunction

function Decay takes integer abilityId, unit caster, real x, real y, real range returns nothing
    local group targets = CreateGroup()
    local integer i = 0
    local integer max = 0
    local unit target = null
    local real maxHP = 0.0
    local boolean heroAbility = false //= abilityId == ABILITY_ID
    call BJDebugMsg("Decay with range " + R2S(range))
    call PingMinimap(x, y, 2.0)
    call GroupEnumUnitsInRange(targets, x, y, range, Filter(function FilterIsCorpse))
    if (BlzGroupGetSize(targets) > 0) then
        set i = 0
        set max = BlzGroupGetSize(targets)
        loop
            exitwhen (i == max)
            set target = BlzGroupUnitAt(targets, i)
            if (heroAbility) then
                set maxHP = maxHP + GetUnitState(target, UNIT_STATE_MAX_LIFE)
            endif
            call RemoveUnit(target)
            set target = null
            set i = i + 1
        endloop
        // heal effect
        if (heroAbility) then
            call SetUnitLifeBJ(caster, RMinBJ(GetUnitState(caster, UNIT_STATE_MAX_LIFE), GetUnitState(caster, UNIT_STATE_LIFE) + maxHP * GetUnitAbilityLevel(caster, abilityId) * 0.01))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_CORPSES_IN_TARGET_AREA"))
    endif
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    //if (GetSpellAbilityId() == ABILITY_ID) then
    //    call BJDebugMsg(GetObjectName(GetSpellAbilityId()) + " with spell level " + I2S(GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())) + " and range " + R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(GetTriggerUnit(), GetSpellAbilityId()), ABILITY_RLF_AREA_OF_EFFECT, GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()))))
    //    call Decay(GetSpellAbilityId(), GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), BlzGetAbilityRealLevelField(BlzGetUnitAbility(GetTriggerUnit(), GetSpellAbilityId()), ABILITY_RLF_AREA_OF_EFFECT, GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
    if (GetSpellAbilityId() == ABILITY_ID_ITEM) then
        call Decay(GetSpellAbilityId(), GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), 128.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
