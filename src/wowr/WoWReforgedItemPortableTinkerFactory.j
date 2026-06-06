library WoWReforgedItemPortableTinkerFactory initializer Init

globals
    private player filterPlayer = null
    private unittype filterType = null
    private boolean filterAdd = false

    private trigger channelTrigger = CreateTrigger()
endglobals

private function FilterIsValidTarget takes nothing returns boolean
    return filterPlayer == GetOwningPlayer(GetFilterUnit()) and filterAdd == not IsUnitType(GetFilterUnit(), filterType)
endfunction

private function Convert takes unit caster, unittype t, boolean add, real x, real y returns nothing
    local group g = CreateGroup()
    local integer i = 0
    local integer max = 0
    set filterPlayer = GetOwningPlayer(caster)
    set filterType = t
    set filterAdd = add
    call GroupEnumUnitsInRange(g, x, y, 512.0, Filter(function FilterIsValidTarget))
    set i = 0
    set max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        if (add) then
            call UnitAddType(BlzGroupUnitAt(g, i), t)
        else
            call UnitRemoveType(BlzGroupUnitAt(g, i), t)
        endif
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (abilityId == 'A0D3') then // Convert into Mechanical
        call Convert(GetTriggerUnit(), UNIT_TYPE_MECHANICAL, true, GetSpellTargetX(), GetSpellTargetY())
    elseif (abilityId == 'A0D4') then // Convert into Organic
        call Convert(GetTriggerUnit(), UNIT_TYPE_MECHANICAL, false, GetSpellTargetX(), GetSpellTargetY())
    elseif (abilityId == 'A0D7') then // Convert into Undead
        call Convert(GetTriggerUnit(), UNIT_TYPE_UNDEAD, true, GetSpellTargetX(), GetSpellTargetY())
    elseif (abilityId == 'A0D8') then // Convert into Non-Undead
        call Convert(GetTriggerUnit(), UNIT_TYPE_UNDEAD, false, GetSpellTargetX(), GetSpellTargetY())
    elseif (abilityId == 'A0D5') then // Convert into Ancient
        call Convert(GetTriggerUnit(), UNIT_TYPE_ANCIENT, true, GetSpellTargetX(), GetSpellTargetY())
    elseif (abilityId == 'A0D6') then // Convert into Non-Ancient
        call Convert(GetTriggerUnit(), UNIT_TYPE_ANCIENT, false, GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
