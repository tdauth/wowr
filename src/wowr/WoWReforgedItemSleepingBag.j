library WoWReforgedItemSleepingBag initializer Init

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

private function FilterIsHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

private function HealHeroesEnum takes nothing returns nothing
    call SetUnitLifePercentBJ(GetEnumUnit(), 100.0)
    call SetUnitManaPercentBJ(GetEnumUnit(), 100.0)
endfunction

private function SleepingBag takes unit caster, real whatTime returns nothing
    local group heroes = CreateGroup()
    call GroupEnumUnitsInRect(heroes, GetPlayableMapRect(), Filter(function FilterIsHero))
    call SetTimeOfDay(whatTime)
    call ForGroup(heroes, function HealHeroesEnum)
    call GroupClear(heroes)
    call DestroyGroup(heroes)
    set heroes = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (abilityId == 'A1QO') then // Next Morning
        call SleepingBag(GetTriggerUnit(), 8)
    elseif (abilityId == 'A1QP') then // Next Noon
        call SleepingBag(GetTriggerUnit(), 12)
    elseif (abilityId == 'A1QQ') then // Next Evening
        call SleepingBag(GetTriggerUnit(), 20)
    elseif (abilityId == 'A1QR') then // Midnight
        call SleepingBag(GetTriggerUnit(), 24)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
