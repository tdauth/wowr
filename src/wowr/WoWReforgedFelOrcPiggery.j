library WoWReforgedFelOrcPiggery initializer Init requires ResourcesLoadedMines, WoWReforgedI18n

globals
    public constant integer UNIT_TYPE_ID_PIG_FARM = 'n0K3'
    public constant integer UNIT_TYPE_ID_FEL_BOAR = 'n0KV'
    private trigger constructedTrigger = CreateTrigger()
    private trigger gatherTrigger = CreateTrigger()
endglobals

private function TriggerConditionConstructFinish takes nothing returns boolean
    local unit b = GetConstructedStructure()
    if (GetUnitTypeId(b) == UNIT_TYPE_ID_PIG_FARM) then
        call AddLoadedMine(b, udg_ResourceMeat, 200, 20)
        call SetLoadedMineAllowedWorkerUnitTypeId(b, UNIT_TYPE_ID_FEL_BOAR, true)
        call SetMineExplodesOnDeath(b, false)
    endif
    set b = null
    return false
endfunction

private function KillUnitEnum takes nothing returns nothing
    call IssueTargetOrder(GetTriggerMine(), "unload", GetEnumUnit())
    call KillUnit(GetEnumUnit())
endfunction

private function KillCargo takes unit mine returns nothing
    local group cargo = GetCargoTransportedUnitGroup(mine)
    //call BJDebugMsg("Cargo " + I2S(BlzGroupGetSize(cargo)))
    call ForGroup(cargo, function KillUnitEnum)
    call GroupClear(cargo)
    call DestroyGroup(cargo)
    set cargo = null
endfunction

private function TriggerConditionGather takes nothing returns boolean
    //call BJDebugMsg("Gather: " + GetUnitName(GetTriggerWorker()) + " in mine " + GetUnitName(GetTriggerMine()))
    if (GetUnitTypeId(GetTriggerWorker()) == UNIT_TYPE_ID_FEL_BOAR) then
        call KillCargo(GetTriggerMine())
        call SetUnitResource(GetTriggerMine(), udg_ResourceMeat, 200)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructedTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructedTrigger, Condition(function TriggerConditionConstructFinish))
    
    call TriggerRegisterGatherEvent(gatherTrigger)
    call TriggerAddCondition(gatherTrigger, Condition(function TriggerConditionGather))
endfunction

endlibrary
