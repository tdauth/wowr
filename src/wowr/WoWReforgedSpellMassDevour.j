library WoWReforgedSpellMassDevour initializer Init requires SimError, MathUtils, WoWReforgedAbilitySkill

globals
    private constant real RANGE = 512.0
    private constant integer ABILITY_ID = ABILITY_MASS_DEVOUR
    private constant integer BUFF_ABILITY_ID = 'A0Y1'
    private constant integer DUMMY_ID = 'h0H7'

    private constant integer DUMMY_DEVOUR_ABILITY_ID = ABILITY_MASS_DEVOUR_DUMMY
    private constant integer DUMMY_DEVOUR_CARGO_ABILITY_ID = ABILITY_MASS_DEVOUR_CARGO
    
    private constant string DUMMY_DEVOUR_ORDER = "creepdevour"

    private hashtable h = InitHashtable()
    private trigger castTrigger = CreateTrigger()
    private trigger deathTriggerCaster = CreateTrigger()
    private trigger deathTriggerTarget = CreateTrigger()
    private group casters = CreateGroup()
    private group targets = CreateGroup()
    
    // keys for targets
    private constant integer KEY_CASTER = 0
    private constant integer KEY_DUMMY = 1
    
    // keys for casters
    private constant integer KEY_DUMMIES = 0
    
    private unit c = null
    private player owner = null
    private group dummies = null
endglobals

private function MassDevourClearTarget takes unit target returns nothing
    local integer handleId = GetHandleId(target)
    call FlushChildHashtable(h, handleId)
endfunction

private function MassDevourClearCaster takes unit caster returns nothing
    local integer handleId = GetHandleId(caster)
    local group d = LoadGroupHandle(h, handleId, KEY_DUMMIES)
    if (d != null) then
        call GroupClear(d)
        call DestroyGroup(d)
    endif
    call FlushChildHashtable(h, handleId)
endfunction

private function MassDevourFilter takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local integer level = GetUnitLevel(filterUnit)
    local integer maxLevel = GetUnitAbilityLevel(c, ABILITY_ID) * 5
    local boolean result = level <= maxLevel and not IsUnitAlly(filterUnit, owner) and not IsUnitDeadBJ(filterUnit) and not IsUnitType(filterUnit, UNIT_TYPE_STRUCTURE) and not IsUnitType(filterUnit, UNIT_TYPE_MAGIC_IMMUNE)
    set filterUnit = null
    return result
endfunction

private function ForGroupDevour takes nothing returns nothing
    local unit target = GetEnumUnit()
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    local real facing = GetUnitFacing(target)
    local real dummyX = PolarProjectionX(GetUnitX(target), 60.0, facing)
    local real dummyY = PolarProjectionY(GetUnitY(target), 60.0, facing)
    local real dummyFacing = AngleBetweenCoordinatesDeg(x, y, dummyX, dummyY)
    local unit dummy = CreateUnit(owner, DUMMY_ID, dummyX, dummyY, dummyFacing)
    local integer abilityLevel = GetUnitAbilitySkillLevelSafe(c, ABILITY_ID)
    //call BJDebugMsg("Caster " + GetUnitName(c) + " with ability level " + I2S(abilityLevel) + " for dummy " + GetUnitName(dummy) + " to target " + GetUnitName(target))
    call UnitAddAbility(dummy, DUMMY_DEVOUR_ABILITY_ID)
    call UnitAddAbility(dummy, DUMMY_DEVOUR_CARGO_ABILITY_ID)
    //call BJDebugMsg("Dummy 1 " + GetUnitName(dummy))
    call UnitMakeAbilityPermanent(dummy, true, DUMMY_DEVOUR_ABILITY_ID)
    call UnitMakeAbilityPermanent(dummy, true, DUMMY_DEVOUR_CARGO_ABILITY_ID)
    //call BJDebugMsg("Dummy 2 " + GetUnitName(dummy))
    call SkillAbility(dummy, ABILITY_FLAME_STORM_STARFALL, abilityLevel)
    call SkillAbility(dummy, ABILITY_FLAME_STORM_STARFALL, abilityLevel)
    //call SetUnitAbilityLevel(dummy, DUMMY_DEVOUR_ABILITY_ID, abilityLevel)
    //call SetUnitAbilityLevel(dummy, DUMMY_DEVOUR_CARGO_ABILITY_ID, abilityLevel)
    //call BJDebugMsg("Dummy 3 " + GetUnitName(dummy))
    call SetUnitInvulnerable(dummy, true)
    //call SelectUnit(dummy, true)
    //call BJDebugMsg("After invulnerable")
    call ShowUnit(dummy, false)
    //call BJDebugMsg("Dummy 4 " + GetUnitName(dummy))
    call GroupAddUnit(dummies, dummy)
    call SaveUnitHandle(h, GetHandleId(dummy), KEY_CASTER, c)
    //call BJDebugMsg("Dummy 5 " + GetUnitName(dummy))
    //call BJDebugMsg("Before issuing")
    call IssueTargetOrder(dummy, DUMMY_DEVOUR_ORDER, target)
    //call BJDebugMsg("Dummy 6 " + GetUnitName(dummy))
    //call BJDebugMsg("After issuing")
    set dummy = null
    set target = null
endfunction

globals
    private unit tmpCaster = null
endglobals

private function ForGroupMassDevourCasterDies takes nothing returns nothing
    local unit dummy = GetEnumUnit()
    call SetUnitX(dummy, GetUnitX(tmpCaster))
    call SetUnitY(dummy, GetUnitY(tmpCaster))
    call SetUnitInvulnerable(dummy, false)
    call KillUnit(dummy)
    call RemoveUnit(dummy)
    set dummy = null
endfunction

private function CastMassDevour takes unit caster, real x, real y returns nothing
    local group d = LoadGroupHandle(h, GetHandleId(caster), KEY_DUMMIES)
    local group targets = CreateGroup()
    set owner = GetOwningPlayer(caster)
    set c = caster
    call GroupEnumUnitsInRange(targets, x, y, RANGE, Filter(function MassDevourFilter))
    
    if (BlzGroupGetSize(targets) > 0) then
        if (d == null) then
            set dummies = CreateGroup()
        else
            set dummies = d
        endif
        call ForGroup(targets, function ForGroupDevour)
        call SaveGroupHandle(h, GetHandleId(caster), KEY_DUMMIES, dummies)
        call GroupAddUnit(casters, caster)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, GetLocalizedString("NO_TARGETS"))
    endif
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID
endfunction

private function TriggerActionCast takes nothing returns nothing
    call CastMassDevour(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
endfunction

private function TriggerConditionDeathCaster takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), casters)
endfunction

private function TriggerActionDeathCaster takes nothing returns nothing
    local group d = LoadGroupHandle(h, GetHandleId(GetTriggerUnit()), KEY_DUMMIES)
    set tmpCaster = GetTriggerUnit()
    call ForGroup(d, function ForGroupMassDevourCasterDies)
    call GroupClear(d)
    call DestroyGroup(d)
    call GroupRemoveUnit(casters, GetTriggerUnit())
    call MassDevourClearCaster(GetTriggerUnit())
    set d = null
endfunction

private function TriggerConditionDeathTarget takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), targets)
endfunction

private function TriggerActionDeathTarget takes nothing returns nothing
    local unit target = GetTriggerUnit()
    local unit caster = LoadUnitHandle(h, GetHandleId(target), KEY_CASTER)
    local unit dummy = LoadUnitHandle(h, GetHandleId(target), KEY_DUMMY)
    local group d = LoadGroupHandle(h, GetHandleId(caster), KEY_DUMMIES)
    call GroupRemoveUnit(d, dummy)
    call SetUnitInvulnerable(dummy, false)
    call KillUnit(dummy)
    call RemoveUnit(dummy)
    set dummy = null
    call GroupRemoveUnit(targets, target)
    call MassDevourClearTarget(target)
    if (BlzGroupGetSize(d) == 0) then
        call GroupRemoveUnit(casters, target)
        call MassDevourClearCaster(target)
    endif
    set target = null
    set d = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
    
    call TriggerRegisterAnyUnitEventBJ(deathTriggerCaster, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTriggerCaster, Condition(function TriggerConditionDeathCaster))
    call TriggerAddAction(deathTriggerCaster, function TriggerActionDeathCaster)
    
    call TriggerRegisterAnyUnitEventBJ(deathTriggerTarget, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTriggerTarget, Condition(function TriggerConditionDeathTarget))
    call TriggerAddAction(deathTriggerTarget, function TriggerActionDeathTarget)
endfunction

private function RemoveUnitMassDevour takes unit whichUnit returns nothing
    call GroupRemoveUnit(targets, whichUnit)
    call GroupRemoveUnit(casters, whichUnit)
    call MassDevourClearTarget(whichUnit)
    call MassDevourClearCaster(whichUnit)
endfunction

hook RemoveUnit RemoveUnitMassDevour

endlibrary
