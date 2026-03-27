library WoWReforgedSleepingBag

private function FilterIsHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

private function HealHeroesEnum takes nothing returns nothing
    call SetUnitLifePercentBJ(GetEnumUnit(), 100.0)
    call SetUnitManaPercentBJ(GetEnumUnit(), 100.0)
endfunction

function SleepingBag takes unit caster, real whatTime returns nothing
    local group heroes = CreateGroup()
    call GroupEnumUnitsInRect(heroes, GetPlayableMapRect(), Filter(function FilterIsHero))
    call SetTimeOfDay(whatTime)
    call ForGroup(heroes, function HealHeroesEnum)
    call GroupClear(heroes)
    call DestroyGroup(heroes)
    set heroes = null
endfunction

endlibrary
