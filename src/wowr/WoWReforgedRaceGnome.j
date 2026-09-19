library WoWReforgedRaceGnome initializer Init requires ForceUtils, TextTagUtils

globals
    private boolexpr filterIsTownHall = null
    private trigger researchFinishTrigger = CreateTrigger()
endglobals

private function FilterIsTownHall takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL)
endfunction

private function EnumTownHallBounty takes nothing returns nothing
    local force f = CreateForce()
    call ForceAddAlliesWithSharedControl(f, GetEnumPlayer())
    call AdjustPlayerStateBJ(100, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call ShowBountyTextTagForForce(f, GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 100)
    call AdjustPlayerStateBJ(100, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
    call ShowLumberTextTagForForce(f, GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 100)
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

private function BountyInTownHalls takes player whichPlayer returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filterIsTownHall)
    call ForGroup(g, function EnumTownHallBounty)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function EnumResearches takes nothing returns nothing
    if (GetPlayerTechCountSimple(UPG_GNOME_INVENTIONS, GetEnumPlayer()) > 0) then
        if (GetPlayerTechCountSimple('R0FF', GetEnumPlayer()) < 10) then
            call SetPlayerTechResearched(GetEnumPlayer(), 'R0FF', GetPlayerTechCountSimple('R0FF', GetEnumPlayer()) + 1)
        endif
        call BountyInTownHalls(GetEnumPlayer())
    endif
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    call ForForce(GetPlayersAll(), function EnumResearches)
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsTownHall = Filter(function FilterIsTownHall)
    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))
endfunction

endlibrary
