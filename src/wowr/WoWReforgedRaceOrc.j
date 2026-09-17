library WoWReforgedRaceOrc initializer Init requires SimError

globals
    private player filterOwner = null
    private boolexpr filter = null
    private hashtable h = InitHashtable()
    private trigger channelTrigger = CreateTrigger()
endglobals

private function AddFelOrc takes integer unitTypeId, integer felUnitTypeId returns nothing
    call SaveInteger(h, unitTypeId, 0, felUnitTypeId)
endfunction

private function GetFelOrc takes integer unitTypeId returns integer
    return LoadInteger(h, unitTypeId, 0)
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == filterOwner and GetFelOrc(GetUnitTypeId(GetFilterUnit())) != 0
endfunction

private function EnumReplaceWithFel takes nothing returns nothing
    local integer felUnitTypeId =  GetFelOrc(GetUnitTypeId(GetEnumUnit()))
    if (felUnitTypeId != 0) then
        call ReplaceUnitBJ(GetEnumUnit(), felUnitTypeId, bj_UNIT_STATE_METHOD_RELATIVE)
    endif
endfunction

private function FountainOfBlood takes unit caster, real x, real y returns nothing
    local group g = CreateGroup()
    set filterOwner = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 512.0, filter)
    if (BlzGroupGetSize(g) == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
    else
        call ForGroup(g, function EnumReplaceWithFel)
        call PlaySoundOnUnitBJ(gg_snd_O05Mannoroth41, 100, caster)
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A08O') then // Fel
        call FountainOfBlood(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsValidTarget)
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    call AddFelOrc('opeo', 'ncpn')
    call AddFelOrc('ogru', 'nchg')
    call AddFelOrc('orai', 'nchr')
    call AddFelOrc('oshm', 'nchw')
    call AddFelOrc('okod', 'nckb')
endfunction

endlibrary
