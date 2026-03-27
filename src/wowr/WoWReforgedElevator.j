library WoWReforgedElevator initializer Init

globals
    constant integer ELEVATOR = 'h0QR'
    constant integer ELEVATOR_DESTRUCTABLE = 'DTrx'
    constant integer ELEVATOR_RAISE = 'o07F'
    constant integer ELEVATOR_LOWER = 'o07G'

    private trigger constructionTrigger = CreateTrigger()
    private trigger sellTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

private function GetElevator takes unit building returns destructable
    return LoadDestructableHandle(h, GetHandleId(building), 0)
endfunction

private function TriggerConditionConstructionFinished takes nothing returns boolean
    local unit building = GetConstructedStructure()
    if (GetUnitTypeId(building) == ELEVATOR) then
        call SaveDestructableHandle(h, GetHandleId(building), 0, CreateDestructable(ELEVATOR_DESTRUCTABLE, GetUnitX(building), GetUnitY(building), 0.0, 1.0, 0))
        call SetDestructableInvulnerable(GetElevator(building), true)
    endif
    set building = null
    return false
endfunction

private function TriggerConditionSell takes nothing returns boolean
    local unit shop = GetSellingUnit()
    local player owner = GetOwningPlayer(shop)
    local destructable elevator = GetElevator(shop)
    local unit action = GetSoldUnit()
    local integer actionType = GetUnitTypeId(action)
    if (GetUnitTypeId(shop) == ELEVATOR) then
        if (actionType == ELEVATOR_RAISE) then
            if (GetElevatorHeight(elevator) < 3) then
                call ChangeElevatorHeight(elevator, GetElevatorHeight(elevator) + 1)
            else
                call SimError(owner, GetLocalizedString("REACHED_MAXIMUM_HEIGHT_LEVEL"))
            endif
            call RemoveUnit(action)
        elseif (actionType == ELEVATOR_LOWER) then
            if (GetElevatorHeight(elevator) > 1) then
                call ChangeElevatorHeight(elevator, GetElevatorHeight(elevator) - 1)
            else
                call SimError(owner, GetLocalizedString("REACHED_MINIMUM_HEIGHT_LEVEL"))
            endif
            call RemoveUnit(action)
        endif
    endif
    set shop = null
    set owner = null
    set elevator = null
    set action = null
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local unit dyingUnit = GetDyingUnit()
    local destructable elevator = GetElevator(dyingUnit)
    if (GetUnitTypeId(dyingUnit) == ELEVATOR) then
        call RemoveDestructable(elevator)
        call FlushChildHashtable(h, GetHandleId(dyingUnit))
    endif
    set dyingUnit = null
    set elevator = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionTrigger, Condition(function TriggerConditionConstructionFinished))
    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
