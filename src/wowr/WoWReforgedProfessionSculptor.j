library WoWReforgedProfessionSculptor initializer Init

globals
    private trigger constructFinishTrigger = CreateTrigger()
endglobals

function IsSculptorGolem takes integer unitTypeId returns boolean
    return unitTypeId == SCULPTOR_MUD_GOLEM or unitTypeId == SCULPTOR_WAR_GOLEM or unitTypeId == SCULPTOR_SIEGE_GOLEM or unitTypeId == SCULPTOR_FLESH_GOLEM or unitTypeId == SCULPTOR_DIVINE_GOLEM
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (IsSculptorGolem(GetUnitTypeId(GetConstructedStructure()))) then
        call UnitApplyTimedLife(GetConstructedStructure(), 'BTLF', 60.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition( function TriggerConditionConstructFinish))
endfunction

endlibrary
