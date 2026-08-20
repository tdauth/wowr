library WoWReforgedPowerGenerators initializer Init

globals
    private player filterPlayer = null
    private filterfunc filter = null
    private trigger constructStartTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger researchFinishTrigger = CreateTrigger()
endglobals

private function FilterIsEnemyStructure takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), filterPlayer) and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

private function EnemyStructuresNearby takes unit u returns boolean
    local boolean result = false
    local group g = CreateGroup()
    set filterPlayer = GetOwningPlayer(u)
    call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 2048.0, filter)
    set result = BlzGroupGetSize(g) > 0
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return result
endfunction

private function TriggerConditionConstructStart takes nothing returns boolean
    if (GetUnitTypeId(GetConstructingStructure()) == POWER_GENERATOR and GetPlayerController(GetOwningPlayer(GetConstructingStructure())) == MAP_CONTROL_USER and EnemyStructuresNearby(GetConstructingStructure())) then
        call IssueImmediateOrder(GetConstructingStructure(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("HOSTILE_BUILDINGS_NEARBY"))
    endif
    return false
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == POWER_GENERATOR) then
        call SetUnitAbilityLevel(GetConstructedStructure(), ABILITY_AUTO_REPAIR_ICON, GetPlayerTechCountSimple(UPG_EVOLUTION, GetOwningPlayer(GetConstructedStructure())))
    endif
    return false
endfunction

private function EnumUpdateHealIcon takes nothing returns nothing
    call SetUnitAbilityLevel(GetEnumUnit(), ABILITY_AUTO_REPAIR_ICON, GetPlayerTechCountSimple(UPG_EVOLUTION, GetOwningPlayer(GetEnumUnit())))
endfunction

function UpdatePowerGeneratorHealIcons takes player whichPlayer returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(whichPlayer, POWER_GENERATOR), function EnumUpdateHealIcon)
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    local integer researchId = GetResearched()
    if (researchId == UPG_EVOLUTION or researchId == UPG_CHEAP_EVOLUTION) then
        call UpdatePowerGeneratorHealIcons(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsEnemyStructure)
    call TriggerRegisterAnyUnitEventBJ(constructStartTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(constructStartTrigger, Condition(function TriggerConditionConstructStart))

    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))

    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))
endfunction

endlibrary
