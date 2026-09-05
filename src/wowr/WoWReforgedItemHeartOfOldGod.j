library WoWReforgedItemHeartOfOldGod initializer Init requires SimError, WoWReforgedRaces

globals
    private integer array races
    private integer array abilityIds
    private integer counter = 0

    private player filterOwner = null
    private integer filterTargetRace = 0
    private boolean filterFoundTarget = false
    private boolexpr filter = null
    private trigger channelTrigger = CreateTrigger()
endglobals

private function AddRaceAbilityId takes integer whichRace, integer abilityId returns nothing
    local integer index = counter
    set races[index] = whichRace
    set abilityIds[index] = abilityId
endfunction

private function GetRaceByAbilityId takes integer abilityId returns integer
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i >= max)
        if (abilityIds[i] == abilityId) then
            return races[i]
        endif
        set i = i + 1
    endloop
    return udg_RaceNone
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and IsUnitAliveBJ(GetFilterUnit()) and GetOwningPlayer(GetFilterUnit()) == filterOwner
endfunction

private function EnumConvert takes nothing returns nothing
    local integer targetId = MapUnitID(GetUnitTypeId(GetEnumUnit()), filterTargetRace, false)
    local integer whichRace = GetUnitIDRace(GetUnitTypeId(GetEnumUnit()))
    if (targetId != 0 and  whichRace != filterTargetRace) then
        call ReplaceUnitBJ(GetEnumUnit(), targetId, bj_UNIT_STATE_METHOD_RELATIVE)
        set filterFoundTarget = true
    endif
endfunction

private function ConvertTargets takes unit caster, real x, real y, integer whichRace returns boolean
    local group g = CreateGroup()
    set filterOwner = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 512.0, filter)
    set filterTargetRace = whichRace
    set filterFoundTarget = false
    call ForGroup(g, function EnumConvert)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return filterFoundTarget
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer whichRace = GetRaceByAbilityId(GetSpellAbilityId())
    if (whichRace != udg_RaceNone) then
        if (not ConvertTargets(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY(), whichRace)) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsValidTarget)
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    // Init after races.
    call AddRaceAbilityId(udg_RaceHuman, 'A0AU')
    call AddRaceAbilityId(udg_RaceOrc, 'A0AV')
    call AddRaceAbilityId(udg_RaceUndead, 'A0AT')
    call AddRaceAbilityId(udg_RaceNightElf, 'A0AW')
    call AddRaceAbilityId(udg_RaceBloodElf, 'A0AX')
    call AddRaceAbilityId(udg_RaceNaga, 'A0AY')
    call AddRaceAbilityId(udg_RaceDemon, 'A0AZ')
    call AddRaceAbilityId(udg_RaceLostOnes, 'A0B0')
    call AddRaceAbilityId(udg_RaceFurbolg, 'A0B1')
    call AddRaceAbilityId(udg_RaceGoblin, 'A0CG')
    call AddRaceAbilityId(udg_RaceDwarf, 'A0F4')
endfunction

endlibrary
