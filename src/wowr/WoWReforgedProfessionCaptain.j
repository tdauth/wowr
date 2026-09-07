library WoWReforgedProfessionCaptain initializer Init requires SimError, WoWReforgedRaces

globals
    private boolexpr filter = null
    private unit filterCaster = null
    private trigger useItemTrigger = CreateTrigger()
    private trigger loadedTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
endglobals

private function FilterIsValidTarget takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_GROUND) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(filterCaster))
endfunction

private function EnumShareVision takes nothing returns nothing
    if (IsUnitShip(GetEnumUnit())) then
        call UnitShareVision(GetEnumUnit(), GetOwningPlayer(filterCaster), true)
    endif
endfunction

private function Compass takes unit caster returns nothing
    local group g = CreateGroup()
    set filterCaster = caster
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 8000.0, filter)
    call ForGroup(g, function EnumShareVision)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionUseItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == ITEM_COMPASS) then
        call Compass(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionLoaded takes nothing returns boolean
    if (GetUnitAbilityLevel(GetTransportUnit(), 'A0JR') == 0 and UnitHasItemOfTypeBJ(GetTriggerUnit(), 'I086') and IsUnitShip(GetTriggerUnit())) then
        call BlzSetUnitArmor(GetTransportUnit(), BlzGetUnitArmor(GetTransportUnit()) + 4.0)
        call UnitAddAbility(GetTransportUnit(), 'A0JR')
    endif
    return false
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == 'h06T' and IsTerrainPathable(GetUnitX(GetSummonedUnit()), GetUnitY(GetSummonedUnit()), PATHING_TYPE_FLOATABILITY)) then
        call KillUnit(GetSummonedUnit())
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_AREA_MUST_BE_WATER"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsValidTarget)

    call TriggerRegisterAnyUnitEventBJ(useItemTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(useItemTrigger, Condition(function TriggerConditionUseItem))

    call TriggerRegisterAnyUnitEventBJ(loadedTrigger, EVENT_PLAYER_UNIT_LOADED)
    call TriggerAddCondition(loadedTrigger, Condition(function TriggerConditionLoaded))

    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
endfunction

endlibrary
