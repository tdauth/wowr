library WoWReforgedRaceTroll initializer Init requires SimError, WoWReforgedUtils, WoWReforgedRaces

globals
    private player filterPlayer = null
    private boolexpr filter = null
    private boolean enumResult = false
    private trigger channelTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
endglobals

private function FilterIsSacrificeTarget takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function EnumSacrifice takes nothing returns nothing
    if (GetObjectRace(GetUnitTypeId(GetEnumUnit())) == WOWR_RACE_TROLL) then
        call ReplaceUnitBJ(GetEnumUnit(), ChooseRandomCreepBJ(GetUnitBaseLevel(GetEnumUnit())), bj_UNIT_STATE_METHOD_RELATIVE)
        set enumResult = true
    endif
endfunction

private function Sacrifice takes unit caster, real x, real y returns boolean
    local group g = CreateGroup()
    set filterPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 512.0, filter)
    set enumResult = false
    call ForGroup(g, function EnumSacrifice)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return enumResult
endfunction

function AddTrollArena takes unit whichUnit returns nothing
    call EnablePagedButtons(whichUnit)
    // ###########################
    call NextPagedButtonsPage(whichUnit, GetLocalizedString("FOREST_TROLLS"))
    call AddPagedButtonsUnitType(whichUnit, 'nftr')
    call AddPagedButtonsUnitType(whichUnit, 'nfsp')
    call AddPagedButtonsUnitType(whichUnit, 'nftt')
    call AddPagedButtonsUnitType(whichUnit, 'nftb')
    call AddPagedButtonsUnitType(whichUnit, 'nfsh')
    call AddPagedButtonsUnitType(whichUnit, 'nftk')
    // ###########################
    call NextPagedButtonsPage(whichUnit, GetLocalizedString("DARK_TROLLS"))
    call AddPagedButtonsUnitType(whichUnit, 'ndtr')
    call AddPagedButtonsUnitType(whichUnit, 'ndtp')
    call AddPagedButtonsUnitType(whichUnit, 'ndtt')
    call AddPagedButtonsUnitType(whichUnit, 'ndtb')
    call AddPagedButtonsUnitType(whichUnit, 'ndth')
    call AddPagedButtonsUnitType(whichUnit, 'ndtw')
    // ###########################
    call NextPagedButtonsPage(whichUnit, GetLocalizedString("ICE_TROLLS"))
    call AddPagedButtonsUnitType(whichUnit, 'nitr')
    call AddPagedButtonsUnitType(whichUnit, 'nitp')
    call AddPagedButtonsUnitType(whichUnit, 'nitt')
    call AddPagedButtonsUnitType(whichUnit, 'nits')
    call AddPagedButtonsUnitType(whichUnit, 'nith')
    call AddPagedButtonsUnitType(whichUnit, 'nitw')
    // ###########################
endfunction

function RemoveTrollArena takes unit whichUnit returns nothing
    call DisablePagedButtons(whichUnit)
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1DU' and not Sacrifice(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())) then // Sacrifice
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsSacrificeTarget)
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
