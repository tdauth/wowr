library WoWReforgedRaceNightElf initializer Init requires SimError, UnitEventEx

globals
    private unit filterUnit = null
    private boolexpr filter = null
    private boolexpr filterIsValidImmortalityTarget = null
    private trigger channelTrigger = CreateTrigger()
endglobals

private function FilterIsValidDemonTarget takes nothing returns boolean
    return GetUnitRace(GetFilterUnit()) == RACE_DEMON and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(filterUnit))
endfunction

private function PowerOfCenarius takes unit caster, real x, real y returns boolean
    local boolean result = false
    local lightning array allLightnings
    local integer i = 0
    local integer max = 0
    local real damage = 0.0
    local unit target = null
    local group g = CreateGroup()
    set filterUnit = caster
    call GroupEnumUnitsInRange(g, x, y, 900.0, filter)
    if (not IsUnitGroupEmptyBJ(g)) then
        call PlaySoundOnUnitBJ(gg_snd_TheHornOfCenarius, 100, caster)
        set damage = 100.0 + I2R(GetCargoSize(caster)) * 100.0
        set i = 0
        set max = BlzGroupGetSize(g)
        loop
            exitwhen (i >= max)
            set target = BlzGroupUnitAt(g, i)
            call UnitDamageTargetBJ(caster, target, damage, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL)
            set allLightnings[i] = AddLightning("MBUR", false, GetUnitX(caster), GetUnitY(caster), GetUnitX(target), GetUnitY(target))
            set target = null
            set i = i + 1
        endloop
        call PolledWait(2.0)
        set i = 0
        loop
            exitwhen (i >= max)
            call DestroyLightning(allLightnings[i])
            set allLightnings[i] = null
            set i = i + 1
        endloop
        set result = true
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return result
endfunction

private function FilterIsValidImmortalityTarget takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) and GetUnitRace(GetFilterUnit()) == RACE_NIGHTELF and (GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) >= GetUnitState(GetFilterUnit(), UNIT_STATE_MAX_LIFE) or GetUnitState(GetFilterUnit(), UNIT_STATE_MANA) >= GetUnitState(GetFilterUnit(), UNIT_STATE_MAX_MANA))
endfunction

private function Immortaility takes unit caster returns boolean
    local boolean result = false
    local unit dummy = null
    local lightning array allLightnings
    local integer i = 0
    local integer max = 0
    local unit target = null
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), filterIsValidImmortalityTarget)
    if (not IsUnitGroupEmptyBJ(g)) then
        call PlaySoundOnUnitBJ(gg_snd_O05Cenarius01, 100, caster)
        set i = 0
        set max = BlzGroupGetSize(g)
        loop
            exitwhen (i >= max)
            set target = BlzGroupUnitAt(g, i)
            call SetUnitLifePercentBJ(target, 100.0)
            call SetUnitManaPercentBJ(target, 100.0)
            set allLightnings[i] = AddLightning("HWPB", false, GetUnitX(caster), GetUnitY(caster), GetUnitX(target), GetUnitY(target))
            set i = i + 1
        endloop
        if (GetCargoSize(caster) == 10) then
            call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(caster))], GetLocalizedString("RESURRECTION_ALL_OVER_THE_MAP"))
            set dummy = CreateUnit(GetOwningPlayer(caster), 'h01N', GetUnitX(caster), GetUnitY(caster), bj_UNIT_FACING)
            call IssueImmediateOrder(dummy, "resurrection")
            call PolledWait(2.0)
            call RemoveUnit(dummy)
            set dummy = null
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NOT_ENOUGH_WISPS_IN_WORLD_TREE"))
        endif
        call PolledWait(2.0)
        set i = 0
        loop
            exitwhen (i >= max)
            call DestroyLightning(allLightnings[i])
            set allLightnings[i] = null
            set i = i + 1
        endloop
        set result = true
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return result
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    return GetSpellAbilityId() == 'A08Q' or GetSpellAbilityId() == 'A08P'
endfunction

private function TriggerActionChannel takes nothing returns nothing
    if (GetSpellAbilityId() == 'A08Q') then // Power of Cenarius
        if (not PowerOfCenarius(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
        endif
    elseif (GetSpellAbilityId() == 'A08P') then // Immortaility
        if (not Immortaility(GetTriggerUnit())) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
        endif
    endif
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsValidDemonTarget)
    set filterIsValidImmortalityTarget = Filter(function FilterIsValidImmortalityTarget)

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    call TriggerAddAction(channelTrigger, function TriggerActionChannel)
endfunction

endlibrary
