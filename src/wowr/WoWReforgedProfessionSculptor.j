library WoWReforgedProfessionSculptor initializer Init

globals
    private trigger constructFinishTrigger = CreateTrigger()

    constant integer SCULPTOR_MUD_GOLEM = 'n0H2'
    constant integer SCULPTOR_WAR_GOLEM = 'n0H3'
    constant integer SCULPTOR_SIEGE_GOLEM = 'n0H4'
    constant integer SCULPTOR_FLESH_GOLEM = 'n0H5'
    constant integer SCULPTOR_DIVINE_GOLEM = 'n0O7'
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
