library WoWReforgedIllusions initializer Init

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

private function TriggerConditionSummon takes nothing returns boolean
    if (IsUnitType(GetSummoningUnit(), UNIT_TYPE_HERO) and IsUnitIllusionBJ(GetSummonedUnit()) and GetUnitTypeId(GetSummonedUnit()) == GetUnitTypeId(GetSummoningUnit())) then
        call BlzSetHeroProperName(GetSummonedUnit(), GetHeroProperName(GetSummoningUnit()))
        call BlzSetUnitSkin(GetSummonedUnit(), BlzGetUnitSkin(GetSummoningUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
