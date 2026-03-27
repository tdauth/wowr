library WoWReforgedEnslave initializer Init requires Utilities

globals
    constant integer UNIT_TYPE_ID = 'h05T'

    private trigger deathTrigger = CreateTrigger()
endglobals

private function FilterIsTownHall takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL)
endfunction

private function Enslave takes unit whichUnit, unit killer returns nothing
    local group g = CreateGroup()
    local unit townHall = null
    local unit slave = null
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(killer), Filter(function FilterIsTownHall))
    set townHall = GetClosestUnitGroup(GetUnitX(whichUnit), GetUnitY(whichUnit), g)
    if (townHall != null) then
        set slave = CreateUnit(GetOwningPlayer(killer), UNIT_TYPE_ID, GetUnitX(townHall), GetUnitY(townHall), GetUnitFacing(whichUnit))
        call BlzSetUnitSkin(slave, BlzGetUnitSkin(whichUnit))
        call UnitAddType(slave, UNIT_TYPE_SUMMONED)
        call RemoveUnit(whichUnit)
        set whichUnit = null
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function HasEnslavementAbility takes unit whichUnit returns boolean
    return GetUnitAbilityLevel(whichUnit, 'A030') > 0 or GetUnitAbilityLevel(whichUnit, 'A03J') > 0 or GetUnitAbilityLevel(whichUnit, 'A0KD') > 0
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetKillingUnit() != null and IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and not  IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) and GetOwningPlayer(GetTriggerUnit()) != GetOwningPlayer(GetKillingUnit()) and HasEnslavementAbility(GetKillingUnit())) then
        call Enslave(GetTriggerUnit(), GetKillingUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
