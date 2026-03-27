library WoWReforgedSpellRevive initializer Init requires SimError, WoWReforgedAbilitySkill

globals
    private trigger channelTrigger = CreateTrigger()
    
    private unit filterCaster = null
endglobals

function GetReviveMaximumTargets takes unit caster, integer abilityId, integer level returns integer
    return 3 + level
endfunction

function ReviveUnit takes unit whichUnit returns unit
    local unit dummy = CreateUnit(GetOwningPlayer(whichUnit), REVIVE_DUMMY, GetUnitX(whichUnit), GetUnitY(whichUnit), bj_UNIT_FACING)
    call IssueImmediateOrder(dummy, "resurrection")
    return dummy
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return IsUnitDeadBJ(GetFilterUnit()) and not IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(filterCaster)) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

private function EnumUnitRemove takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function Revive takes unit caster, integer abilityId, real x, real y returns nothing
    local group dummies = CreateGroup()
    local group g = CreateGroup()
    local integer i = 0
    local integer max = 0
    local unit t = null
    local integer counter = 0
    local integer maxTargets = GetReviveMaximumTargets(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    set filterCaster = caster
    call GroupEnumUnitsInRange(g, x, y, 512.0, Filter(function FilterIsValidTarget))
    set max = BlzGroupGetSize(g)
    if (max > 0) then
        // heroes
        set i = 0
        loop
            exitwhen (i == max or counter >= maxTargets)
            set t = BlzGroupUnitAt(g, i)
            if (IsUnitType(t, UNIT_TYPE_HERO)) then
                call ReviveHero(t, GetUnitX(t), GetUnitY(t), true)
                set counter = counter + 1
            endif
            set t = null
            set i = i + 1
        endloop
        // units
        set i = 0
        loop
            exitwhen (i == max or counter >= maxTargets)
            set t = BlzGroupUnitAt(g, i)
            if (not IsUnitType(t, UNIT_TYPE_HERO)) then
                call GroupAddUnit(dummies, ReviveUnit(t))
                set counter = counter + 1
            endif
            set t = null
            set i = i + 1
        endloop
        call PolledWait(2.0)
        call ForGroup(dummies, function EnumUnitRemove)
    else
        call IssueImmediateOrder(caster, "stop" )
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_TARGETS"))
    endif
    call GroupClear(dummies)
    call DestroyGroup(dummies)
    set dummies = null
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_REVIVE) then
        call Revive(GetTriggerUnit(), GetSpellAbilityId(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_REVIVE, GetReviveMaximumTargets)
endfunction

endlibrary
