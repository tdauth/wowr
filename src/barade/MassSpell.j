library MassSpell initializer Init requires SimError

globals
    public constant integer DUMMY_UNIT_TYPE_ID = 'h0PY'
    public constant real DUMMY_REMOVAL_DELAY = 4.00

    private hashtable h = InitHashtable()
    private trigger channelTrigger = CreateTrigger()
    
    private unit filterCaster = null
    private integer filterAbilityId = 0
endglobals

function interface MassSpellDummyAbilityLevelFunction takes unit caster, integer abilityId, unit dummy, MassSpell s returns nothing

struct MassSpell
    integer dummyAbilityId
    string dummyAbilityOrder
    real radius
    filterfunc filter
    MassSpellDummyAbilityLevelFunction dummyAbilityLevelFunction
endstruct

function AddMassSpell takes integer dummyAbilityId, string dummyAbilityOrder, real radius, filterfunc filter, MassSpellDummyAbilityLevelFunction dummyAbilityLevelFunction returns MassSpell
    local MassSpell this = MassSpell.create()
    set this.dummyAbilityId = dummyAbilityId
    set this.dummyAbilityOrder = dummyAbilityOrder
    set this.radius = radius
    set this.filter = filter
    set this.dummyAbilityLevelFunction = dummyAbilityLevelFunction
    return this
endfunction

function RegisterMassSpell takes integer abilityId, MassSpell massSpell returns nothing
    call SaveInteger(h, abilityId, 0, massSpell)
endfunction

function GetMassSpellFilterCaster takes nothing returns unit
    return filterCaster
endfunction

function GetMassSpellFilterAbilityId takes nothing returns integer
    return filterAbilityId
endfunction

private function LoadMassSpell takes integer abilityId returns MassSpell
    return LoadInteger(h, abilityId, 0)
endfunction

private function TriggerConditionMassSpell takes nothing returns boolean
    return LoadMassSpell(GetSpellAbilityId()) != 0
endfunction

private function RemoveUnitEnum takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

private function TriggerActionMassSpell takes nothing returns nothing
    local integer abilityId = GetSpellAbilityId()
    local MassSpell s = LoadMassSpell(abilityId)
    local group targets = CreateGroup()
    local group dummies = CreateGroup()
    local integer max = 0
    local integer i = 0
    local unit caster = GetTriggerUnit()
    local player owner = GetOwningPlayer(caster)
    local integer abilityLevel = GetUnitAbilityLevel(caster, abilityId)
    //local real radius = BlzGetAbilityRealLevelField(BlzGetUnitAbility(caster, abilityId), ABILITY_RLF_AREA_OF_EFFECT, abilityLevel) // TODO always returns 0
    local real radius = s.radius
    local unit dummy = null
    local unit target = null
    local boolean hasTargets = false
    set filterCaster = caster
    set filterAbilityId = abilityId
    call GroupEnumUnitsInRange(targets, GetSpellTargetX(), GetSpellTargetY(), radius, s.filter)
    set max = BlzGroupGetSize(targets)
    set hasTargets = max > 0
    //call BJDebugMsg("Mass spell " + GetObjectName(abilityId) + " with targets " + I2S(BlzGroupGetSize(targets)) + " and radius " + R2S(radius) + " and ability level " + I2S(abilityLevel) + " and filter " + I2S(GetHandleId(s.filter)))
    if (hasTargets) then
        //call BJDebugMsg("Mass spell dummy ability level " + I2S(dummyAbilityLevel))
        set i = 0
        loop
            exitwhen (i == max)
            set target = BlzGroupUnitAt(targets, i)
            set dummy = CreateUnit(owner, DUMMY_UNIT_TYPE_ID, GetUnitX(target), GetUnitY(target), bj_UNIT_FACING)
            call GroupAddUnit(dummies, dummy)
            call ShowUnit(dummy, false)
            call UnitAddAbility(dummy, s.dummyAbilityId)
            call s.dummyAbilityLevelFunction.evaluate(caster, abilityId, dummy, s)
            call IssueTargetOrder(dummy, s.dummyAbilityOrder, target)
            set target = null
            set i = i + 1
        endloop
    else
        call SimError(owner, GetLocalizedString("NO_TARGETS"))
        call IssueImmediateOrder(caster, "stop")
    endif
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
    if (hasTargets) then
        call TriggerSleepAction(DUMMY_REMOVAL_DELAY)
        call ForGroup(dummies, function RemoveUnitEnum)
        call GroupClear(dummies)
    endif
    call DestroyGroup(dummies)
    set dummies = null
    set owner = null
    set caster = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionMassSpell))
    call TriggerAddAction(channelTrigger, function TriggerActionMassSpell)
endfunction

endlibrary
