library WoWReforgedRaceDragonkin initializer Init

globals
    private player filterPlayer = null
    private boolexpr filterIsBlackDragon = null
    private trigger researchFinishTrigger = CreateTrigger()
endglobals

function AddDragonkinBlackDragon takes unit whichUnit returns nothing
    call BlzUnitHideAbility(whichUnit, 'A0WE', true)
    if (GetPlayerTechCountSimple(UPG_DRAGONKIN_FIRE_ATTACK, GetOwningPlayer(whichUnit)) == 0) then
        call UnitRemoveAbility(whichUnit, 'A0WE')
    endif
endfunction

private function FilterIsBlackDragon takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == DRAGONKIN_BLACK_DRAGON
endfunction

private function EnumUpdateBlackDragon takes nothing returns nothing
    if (GetPlayerTechCountSimple(UPG_DRAGONKIN_FIRE_ATTACK, filterPlayer) == 0) then
        call UnitRemoveAbility(GetEnumUnit(), 'A0WE')
    else
        call UnitAddAbility(GetEnumUnit(), 'A0WE')
    endif
endfunction

function UpdateDragonkinBlackDragons takes player whichPlayer returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filterIsBlackDragon)
    set filterPlayer = whichPlayer
    call ForGroup(g, function EnumUpdateBlackDragon)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    if (GetResearched() == UPG_DRAGONKIN_FIRE_ATTACK) then
        call UpdateDragonkinBlackDragons(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsBlackDragon = Filter(function FilterIsBlackDragon)
    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))
endfunction

endlibrary
