library Queue initializer Init requires optional HeroReviveEvents

globals
    // This is an indicator for an invalid ObjectName. It has to be the same for every language to avoid desyncs.
    private constant string EMPTY_STRING = "Default string"

    private trigger cancelTrainTrigger = CreateTrigger()
    private trigger finishTrainTrigger = CreateTrigger()
    private trigger cancelResearchTrigger = CreateTrigger()
    private trigger finishResearchTrigger = CreateTrigger()
    private trigger cancelUpgradeTrigger = CreateTrigger()
    private trigger finishUpgradeTrigger = CreateTrigger()
    private trigger startConstructTrigger = CreateTrigger()
    private trigger finishConstructTrigger = CreateTrigger()
    private trigger orderReviveStartTrigger = CreateTrigger()
    private trigger orderReviveCancelTrigger = CreateTrigger()
    private trigger finishReviveTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    
    private Queue array playerQueue
    private boolean array isEnabledForPlayer
    
    private hashtable h = InitHashtable()
    private group constructions = CreateGroup()
    
    private group ignored = CreateGroup()
    
    // callbacks
    private trigger array callbackTriggers
    private integer callbackTriggersCount = 0
    private unit triggerUnit = null
    private integer triggerId = 0
endglobals

struct Queue
    integer id
    group sources = CreateGroup()
    integer counter = 0

    Queue previous = 0
    Queue next = 0
    
    method onDestroy takes nothing returns nothing
        if (this.next != 0) then
            set this.next.previous = this.previous
        endif
        
        if (this.previous != 0) then
            set this.previous.next = this.next
        endif
        
        call GroupClear(sources)
        call DestroyGroup(sources)
        set sources = null
    endmethod
endstruct

function IsQueueEnabledForPlayer takes player whichPlayer returns boolean
    return isEnabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

function SetQueueEnabledForPlayer takes player whichPlayer, boolean enabled returns nothing
    set isEnabledForPlayer[GetPlayerId(whichPlayer)] = enabled
endfunction

function IgnoreQueueUnit takes unit whichUnit returns nothing
    call GroupAddUnit(ignored, whichUnit)
endfunction

function UnignoreQueueUnit takes unit whichUnit returns nothing
    call GroupRemoveUnit(ignored, whichUnit)
endfunction

function IsQueueUnitIgnored takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, ignored)
endfunction

private function SetSourceCounter takes unit source, integer id, integer count returns nothing
    call SaveInteger(h, GetHandleId(source), id, count)
endfunction

private function GetSourceCounter takes unit source, integer id returns integer
    return LoadInteger(h, GetHandleId(source), id)
endfunction

private function ClearSourceCounter takes unit source returns nothing
    call FlushChildHashtable(h, GetHandleId(source))
endfunction

function GetTriggerQueueUnit takes nothing returns unit
    return triggerUnit
endfunction

function GetTriggerQueueId takes nothing returns integer
    return triggerId
endfunction

function TriggerRegisterQueueEvent takes trigger whichTrigger returns nothing
    set callbackTriggers[callbackTriggersCount] = whichTrigger
    set callbackTriggersCount = callbackTriggersCount + 1
endfunction

private function ExecuteTriggerCallbacks takes unit whichUnit, integer id returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackTriggersCount)
        if (IsTriggerEnabled(callbackTriggers[i])) then
            set triggerUnit = whichUnit
            set triggerId = id
            call ConditionalTriggerExecute(callbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function GetPlayerQueue takes player whichPlayer returns Queue
    return playerQueue[GetPlayerId(whichPlayer)]
endfunction

function GetPlayerQueueByIndex takes player whichPlayer, integer index returns Queue
    local Queue current = GetPlayerQueue(whichPlayer)
    local integer i = 0
    loop
        exitwhen (current == 0 or index == i)
        set current = current.next
        set i = i + 1
    endloop
    return current
endfunction

function ClearQueue takes Queue queue returns nothing
    local Queue current = queue
    local unit source = null
    local integer j = 0
    local integer max = 0
    loop
        exitwhen (current == 0)
        set queue = current.next
        
        set j = 0
        set max = BlzGroupGetSize(queue.sources)
        loop
            exitwhen (j == max)
            set source = BlzGroupUnitAt(current.sources, j)
            call SetSourceCounter(source, current.id, GetSourceCounter(source, current.id) - 1)
            set source = null
            set j = j + 1
        endloop
        call current.destroy()
        set current = queue
    endloop
endfunction

function AddQueue takes unit source, integer id returns nothing
    local Queue current = GetPlayerQueue(GetOwningPlayer(source))
    local Queue previous = 0
    local boolean found = false
    loop
        exitwhen (current == 0)
        //call BJDebugMsg("Test: " + I2S(current) + " with ID " + GetObjectName(current.id) + " looking for ID " + GetObjectName(id))
        if (current.id == id) then
            set found = true
        endif
        
        exitwhen (found)
        
        set previous = current
        set current = current.next
    endloop
    if (current == 0) then
        set current = Queue.create()
        set current.id = id
        //call BJDebugMsg("Creating new queue " + I2S(current) + " with previous " + I2S(previous))
        
        if (playerQueue[GetPlayerId(GetOwningPlayer(source))] == 0) then
            set playerQueue[GetPlayerId(GetOwningPlayer(source))] = current
        elseif (previous != 0) then
            set current.previous = previous
            set previous.next = current
        endif
    endif
    
    //call BJDebugMsg("Current: " + I2S(current))
    
    if (not IsUnitInGroup(source, current.sources)) then
        call GroupAddUnit(current.sources, source)
    endif
    
    call SetSourceCounter(source, id, GetSourceCounter(source, id) + 1)
    set current.counter = current.counter + 1
    
    call ExecuteTriggerCallbacks(source, id)
endfunction

function RemoveQueue takes unit source, integer id returns nothing
    local player owner = GetOwningPlayer(source)
    local integer playerId = GetPlayerId(owner)
    local Queue current = GetPlayerQueue(owner)
    local Queue previous = current
    local boolean found = false
    loop
        exitwhen (current == 0)
        if (current.id == id and IsUnitInGroup(source, current.sources)) then
            set found = true
        endif
        
        exitwhen (found)
        
        set previous = current
        set current = current.next
    endloop
    
    if (current != 0) then
        call SetSourceCounter(source, id, GetSourceCounter(source, id) - 1)
        set current.counter = current.counter - 1
        if (GetSourceCounter(source, id) == 0) then
            call GroupRemoveUnit(current.sources, source)
        endif
        
        if (BlzGroupGetSize(current.sources) == 0) then
            if (GetPlayerQueue(owner) == current) then
                set playerQueue[playerId] = current.next
            endif
            //call BJDebugMsg("Destroying " + I2S(current))
            call current.destroy()
        endif
    endif
    
    call ExecuteTriggerCallbacks(source, id)
endfunction

private function TriggerConditionCancelTrain takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), GetTrainedUnitType())
    endif
    
    return false
endfunction

private function TriggerConditionFinishTrain takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), GetTrainedUnitType())
    endif

    return false
endfunction

private function TriggerConditionCancelResearch takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), GetResearched())
    endif
    
    return false
endfunction

private function TriggerConditionFinishResearch takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), GetResearched())
    endif

    return false
endfunction

private function TriggerConditionCancelUpgrade takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), LoadInteger(h, GetHandleId(GetTriggerUnit()), 0)) // Use the ID from start upgrade.
    endif
    
    return false
endfunction

private function TriggerConditionFinishUpgrade takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call RemoveQueue(GetTriggerUnit(), GetUnitTypeId(GetTriggerUnit())) // Already has the new ID from start upgrade at this point.
    endif

    return false
endfunction

private function TriggerConditionStartConstruct takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetConstructingStructure()))) then
        call AddQueue(GetConstructingStructure(), GetUnitTypeId(GetConstructingStructure()))
        call GroupAddUnit(constructions, GetConstructingStructure())
    endif
    
    return false
endfunction

private function TriggerConditionCancelConstruct takes nothing returns boolean
    //call BJDebugMsg("Cancel construction of " + GetUnitName(GetTriggerUnit()))
    
    return false
endfunction

private function TriggerConditionFinishConstruct takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetConstructedStructure()))) then
        call RemoveQueue(GetConstructedStructure(), GetUnitTypeId(GetConstructedStructure()))
        call GroupRemoveUnit(constructions, GetConstructedStructure())
    endif

    return false
endfunction

static if (LIBRARY_HeroReviveEvents) then
private function TriggerConditionOrderReviveStart takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " starts the revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerReviveAltar()))) then
        call AddQueue(GetTriggerReviveAltar(), GetUnitTypeId(GetTriggerReviveHero()))
    endif

    return false
endfunction

private function TriggerConditionOrderReviveCancel takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " cancels the revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerReviveAltar()))) then
        call RemoveQueue(GetTriggerReviveAltar(), GetUnitTypeId(GetTriggerReviveHero()))
    endif
    
    return false
endfunction

private function TriggerConditionFinishRevive takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " finishes revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerReviveAltar()))) then
        call RemoveQueue(GetTriggerReviveAltar(), GetUnitTypeId(GetTriggerReviveHero()))
    endif

    return false
endfunction
endif

private function IsValidBuilding takes unit whichUnit returns boolean
    if (not IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE)) then
        return false
    elseif (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then // structure heroes are possible with the Root ability
        return false
    elseif (GetUnitAbilityLevel(whichUnit, 'Aneu') > 0) then
        return false
    elseif (GetUnitAbilityLevel(whichUnit, 'Ane2') > 0) then
        return false
    elseif (GetUnitAbilityLevel(whichUnit, 'Apit') > 0) then
        return false
    elseif (IsUnitInGroup(whichUnit, ignored)) then
        return false
    endif 
    return true
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    local unit building = GetTriggerUnit()
    local integer trainId = GetIssuedOrderId()
    //call BJDebugMsg("Order " + I2S(GetIssuedOrderId()) + ": " + GetObjectName(GetIssuedOrderId()))
    // Use only structures which do not sell units or items to avoid getting summoned and sold units and sold items.
    if (IsQueueEnabledForPlayer(GetOwningPlayer(building)) and GetObjectName(trainId) != EMPTY_STRING and GetObjectName(trainId) != null and IsValidBuilding(building)) then
        call SaveInteger(h, GetHandleId(building), 0, trainId)
        call AddQueue(building, trainId)
    endif
    
    set building = null
    
    return false
endfunction

private function ClearSourceCounterExtended takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, constructions)) then
        call RemoveQueue(whichUnit, GetUnitTypeId(whichUnit))
        call GroupRemoveUnit(constructions, whichUnit)
    endif

    call ClearSourceCounter(whichUnit)
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsQueueEnabledForPlayer(GetOwningPlayer(GetTriggerUnit()))) then
        call ClearSourceCounterExtended(GetTriggerUnit())
    endif

    return false
endfunction

private function Init takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER) then
            set isEnabledForPlayer[i] = true
        endif
        set slotPlayer = null
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(cancelTrainTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(cancelTrainTrigger, Condition(function TriggerConditionCancelTrain))
    
    call TriggerRegisterAnyUnitEventBJ(finishTrainTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(finishTrainTrigger, Condition(function TriggerConditionFinishTrain))
    
    call TriggerRegisterAnyUnitEventBJ(cancelResearchTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerAddCondition(cancelResearchTrigger, Condition(function TriggerConditionCancelResearch))
    
    call TriggerRegisterAnyUnitEventBJ(finishResearchTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(finishResearchTrigger, Condition(function TriggerConditionFinishResearch))
    
    call TriggerRegisterAnyUnitEventBJ(cancelUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerAddCondition(cancelUpgradeTrigger, Condition(function TriggerConditionCancelUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(finishUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(finishUpgradeTrigger, Condition(function TriggerConditionFinishUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(startConstructTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(startConstructTrigger, Condition(function TriggerConditionStartConstruct))
    
    call TriggerRegisterAnyUnitEventBJ(finishConstructTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(finishConstructTrigger, Condition(function TriggerConditionFinishConstruct))
    
static if (LIBRARY_HeroReviveEvents) then
    call TriggerRegisterHeroReviveOrderStartEvent(orderReviveStartTrigger)
    call TriggerAddCondition(orderReviveStartTrigger, Condition(function TriggerConditionOrderReviveStart))
    
    call TriggerRegisterHeroReviveOrderCancelEvent(orderReviveCancelTrigger)
    call TriggerAddCondition(orderReviveCancelTrigger, Condition(function TriggerConditionOrderReviveCancel))
    
    call TriggerRegisterHeroReviveFinishEvent(finishReviveTrigger)
    call TriggerAddCondition(finishReviveTrigger, Condition(function TriggerConditionFinishRevive))
endif

    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call ClearSourceCounterExtended(whichUnit)
    if (IsQueueUnitIgnored(whichUnit)) then
        call UnignoreQueueUnit(whichUnit)
    endif
endfunction

hook RemoveUnit ClearSourceCounterExtended

endlibrary
