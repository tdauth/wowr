library ResourcesLoadedMines initializer Init requires SimError, UnitEventEx, MathUtils, StringFormat, Resources

/**
 * Optional system for resource loaded mines.
 */

globals
    public constant real HARVEST_INTERVAL = 3.0
    public constant integer ORDER_ID_LOAD = 852046
    private group mines = CreateGroup()
    private trigger orderTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private timer harvestTimer = CreateTimer()
    private hashtable h = InitHashtable()
    private constant integer KEY_HARVEST_BONUS_PER_WORKER = 0
    private constant integer KEY_ALLOWED_WORKER_UNIT_TYPE_ID = 1
    private constant integer MAX_KEYS = 2
endglobals

function IsLoadedMine takes unit mine returns boolean
    return IsUnitInGroup(mine, mines)
endfunction

function SetLoadedMineHarvestBonusPerWorker takes unit mine, integer bonus returns nothing
    call SaveInteger(h, GetHandleId(mine), Index2D(0, KEY_HARVEST_BONUS_PER_WORKER, MAX_KEYS), bonus)
endfunction

function GetLoadedMineHarvestBonusPerWorker takes unit mine returns integer
    return LoadInteger(h, GetHandleId(mine), Index2D(0, KEY_HARVEST_BONUS_PER_WORKER, MAX_KEYS))
endfunction

function SetLoadedMineAllowedWorkerUnitTypeId takes unit mine, integer unitTypeId, boolean allowed returns nothing
    call SaveBoolean(h, GetHandleId(mine), Index2D(unitTypeId, KEY_ALLOWED_WORKER_UNIT_TYPE_ID, MAX_KEYS), allowed)
endfunction

function GetLoadedMineAllowedWorkerUnitTypeId takes unit mine, integer unitTypeId returns boolean
    return LoadBoolean(h, GetHandleId(mine), Index2D(unitTypeId, KEY_ALLOWED_WORKER_UNIT_TYPE_ID, MAX_KEYS))
endfunction

function AddLoadedMineWorkerUnitTypeId takes unit mine, integer unitTypeId returns nothing
    call SetLoadedMineAllowedWorkerUnitTypeId(mine, unitTypeId, true)
endfunction

function AddLoadedMine takes unit mine, Resource resource, integer max, integer harvestBonusPerWorker returns nothing
    call AddMineEx(mine, resource, max)
    call GroupAddUnit(mines, mine)
    call SetLoadedMineHarvestBonusPerWorker(mine, harvestBonusPerWorker)
    call SetUnitDisableStopMiningOnError(mine, true)
endfunction

function RemoveLoadedMine takes unit mine returns nothing
    call RemoveMine(mine)
    call GroupRemoveUnit(mines, mine)
    call FlushChildHashtable(h, GetHandleId(mine))
endfunction

function PauseHarvestTimer takes nothing returns nothing
    call PauseTimer(harvestTimer)
endfunction

function ResumeHarvestTimer takes nothing returns nothing
    call ResumeTimer(harvestTimer)
endfunction

private function GetFirstWorkerInLoadedMine takes unit mine returns unit
    local group cargo = GetCargoTransportedUnitGroup(mine)
    local unit first = FirstOfGroup(cargo)
    call GroupClear(cargo)
    call DestroyGroup(cargo)
    set cargo = null
    return first
endfunction

private function HarvestMine takes unit mine, integer amount returns nothing
    local unit firstWorker = GetFirstWorkerInLoadedMine(mine)
    local Resource r = 0
    local integer i = 0
    local integer max = GetMaxResources()
    local integer actualAmount = 0
    loop
        exitwhen (i == max)
        set r = GetResource(i)
        set actualAmount = GetUnitResource(mine, r)
        if (actualAmount > 0) then
            set actualAmount = IMinBJ(actualAmount, amount + GetPlayerResourceBonus(GetOwningPlayer(mine), r))
            call SetUnitResource(mine, r, GetUnitResource(mine, r) - actualAmount)
            call CustomBountyEx(mine, GetOwningPlayer(firstWorker), r, actualAmount)
            call ExecuteGatherCallbacks(mine, firstWorker, r, actualAmount)
        endif
        set i = i + 1
    endloop
    set firstWorker = null
endfunction

private function ForGroupHarvest takes nothing returns nothing
    local unit mine = GetEnumUnit()
    local integer cargoSize = 0
    local integer amount = 0
    if (not IsUnitPaused(mine)) then
        set cargoSize = GetCargoSize(mine)
        if (cargoSize > 0) then
            set amount = cargoSize * GetLoadedMineHarvestBonusPerWorker(mine)
            if (amount > 0) then
                call QueueUnitAnimation(mine, "stand work")
                
                call HarvestMine(mine, amount)
                                    
                if (IsMineEmpty(mine)) then
                    if (GetMineExplodesOnDeath(mine)) then
                        call KillUnit(mine)
                    else
                        call RemoveLoadedMine(mine)
                    endif
                endif
            endif
        endif
    else
        call ResetUnitAnimation(mine)
    endif
    set mine = null
endfunction

private function TimerFunctionHarvest takes nothing returns nothing
    call ForGroup(mines, function ForGroupHarvest)
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    local integer orderId = GetIssuedOrderId()
    local unit worker = GetOrderTargetUnit()
    local unit mine = GetTriggerUnit()
    if (orderId == ORDER_ID_LOAD and mine != null and IsLoadedMine(mine) and not GetLoadedMineAllowedWorkerUnitTypeId(mine, GetUnitTypeId(worker))) then
        call IssueImmediateOrder(worker, "stop")
        call SimError(GetOwningPlayer(worker), Format(GetLocalizedString("CANNOT_HARVEST")).s(GetUnitName(worker)).s(GetUnitName(mine)).result())
    endif
    set worker = null
    set mine = null
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsLoadedMine(GetTriggerUnit())) then
        call RemoveLoadedMine(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TimerStart(harvestTimer, HARVEST_INTERVAL, true, function TimerFunctionHarvest)
endfunction

endlibrary
