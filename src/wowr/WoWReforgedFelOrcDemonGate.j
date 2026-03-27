library WoWReforgedFelOrcDemonGate initializer Init

globals
    public constant integer UNIT_TYPE_ID = 'n0KO'
    public constant integer RESEARCH_ID = 'R0H4'
    
    public constant integer DOOM_GUARD = 'n0KZ'
    public constant integer FEL_STALKER = 'n0L1'
    public constant integer INFERNAL = 'n0L0'

    private integer array playerKillsCounter
    private trigger constructedTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private group gates = CreateGroup()
endglobals

private function TriggerConditionConstructed takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == UNIT_TYPE_ID) then
        call GroupAddUnit(gates, GetConstructedStructure())
    endif
    return false
endfunction

private function UpdateDemonGates takes player whichPlayer, integer count returns nothing
    local integer i = 0
    local integer max = BlzGroupGetSize(gates)
    local unit u = null
    loop
        exitwhen (i == max)
        set u = BlzGroupUnitAt(gates, i)
        if (GetOwningPlayer(u) == whichPlayer) then
            call BlzSetUnitName(u, GetObjectName(GetUnitTypeId(u)) + " (" + I2S(count) + ")")
        endif
        set u = null
        set i = i + 1
    endloop
endfunction

private function IncreaseDemonGates takes player whichPlayer, integer count returns nothing
    local integer i = 0
    local integer max = BlzGroupGetSize(gates)
    local unit u = null
    loop
        exitwhen (i == max)
        set u = BlzGroupUnitAt(gates, i)
        if (GetOwningPlayer(u) == whichPlayer) then
            call AddUnitToStock(u, FEL_STALKER, count, count)
            call AddUnitToStock(u, INFERNAL, count, count)
            call AddUnitToStock(u, DOOM_GUARD, count, count)
        endif
        set u = null
        set i = i + 1
    endloop
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local integer count = 0
    if (IsUnitInGroup(GetTriggerUnit(), gates)) then
        call GroupRemoveUnit(gates, GetTriggerUnit())
    endif
    if (GetUnitFoodUsed(GetTriggerUnit()) > 0 and GetKillingUnit() != null and GetOwningPlayer(GetKillingUnit()) != GetOwningPlayer(GetTriggerUnit()) and not IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetKillingUnit()))) then
        set playerKillsCounter[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] = playerKillsCounter[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] + GetUnitFoodUsed(GetTriggerUnit())
        set count = playerKillsCounter[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] / (30 - GetPlayerTechCountSimple(RESEARCH_ID, GetOwningPlayer(GetKillingUnit())) * 5)
        call UpdateDemonGates(GetOwningPlayer(GetKillingUnit()), count)
        if (count > 0) then
            call IncreaseDemonGates(GetOwningPlayer(GetKillingUnit()), count)
            set playerKillsCounter[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] = ModuloInteger(playerKillsCounter[GetPlayerId(GetOwningPlayer(GetKillingUnit()))], 30)
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructedTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructedTrigger, Condition(function TriggerConditionConstructed))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, gates)) then
        call GroupRemoveUnit(gates, whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
