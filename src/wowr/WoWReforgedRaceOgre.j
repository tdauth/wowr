library WoWReforgedRaceOgre initializer Init

globals
    private boolexpr filter = null
    private trigger researchFinishTrigger = CreateTrigger()
endglobals

function AddCapturedBlackDrake takes unit whichUnit returns nothing
    call BlzUnitHideAbility(whichUnit, 'A1P4', true )
    if (GetPlayerTechCountSimple(UPG_OGRE_LIGHTNING_ATTACK, GetOwningPlayer(whichUnit)) == 0) then
        call UnitRemoveAbility(whichUnit, 'A1P4')
    else
        call UnitAddAbility(whichUnit, 'A1P4')
    endif
endfunction

private function EnumUpdateCapturedBlackDrake takes nothing returns nothing
    call AddCapturedBlackDrake(GetEnumUnit())
endfunction

function UpdateAllCapturedBlackDrakes takes player whichPlayer returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filter)
    call ForGroup(g, function EnumUpdateCapturedBlackDrake)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function FilterIsCapturedBlackDrake takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == OGRE_DRAKE
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    if (GetResearched() == UPG_OGRE_LIGHTNING_ATTACK) then
        call UpdateAllCapturedBlackDrakes(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsCapturedBlackDrake)
    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))
endfunction

endlibrary
