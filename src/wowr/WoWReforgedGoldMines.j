library WoWReforgedGoldMines initializer Init

globals
    private trigger constructFinishTrigger = CreateTrigger()
endglobals

function AddGoldMine takes unit whichUnit returns nothing
    call UnitAddAbility(whichUnit, 'Agld')
    call SetResourceAmount(whichUnit, 999999)
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetConstructedStructure())
    if (unitTypeId == ELF_MINE) then // Entangled Gold Mine
        call SetResourceAmount( GetConstructedStructure(), 1000000)
    elseif (unitTypeId == DALARAN_HOUSING or unitTypeId == ELF_HOUSING) then // Entangled Gold Mine Housings
        call SetResourceAmount(GetConstructedStructure(), 10000)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))
endfunction

endlibrary
