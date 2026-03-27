library HeroReviveEvents initializer Init requires HeroReviveCancelEvent
// Created by Baradé for the Queue library.

globals
    public constant integer ORDER_ID_START_REVIVE = 852027
    public constant integer ORDER_ID_REVIVE = 852039

    private trigger orderTrigger = CreateTrigger()
    private trigger startReviveTrigger = CreateTrigger()
    private trigger finishReviveTrigger = CreateTrigger()
    private group heroes = CreateGroup()
    private hashtable h = InitHashtable()
     
    private trigger array callbackOrderStartReviveTriggers
    private integer callbackStartOrderStartTriggersCounter = 0
    private trigger array callbackOrderCancelReviveTriggers
    private integer callbackStartOrderCancelTriggersCounter = 0
    private trigger array callbackStartReviveTriggers
    private integer callbackStartReviveTriggersCounter = 0
    private trigger array callbackFinishReviveTriggers
    private integer callbackFinishReviveTriggersCounter = 0
    private unit triggerReviveAltar = null
    private unit triggerReviveHero = null
endglobals

function TriggerRegisterHeroReviveOrderStartEvent takes trigger whichTrigger returns nothing
    set callbackOrderStartReviveTriggers[callbackStartOrderStartTriggersCounter] = whichTrigger
    set callbackStartOrderStartTriggersCounter = callbackStartOrderStartTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveOrderCancelEvent takes trigger whichTrigger returns nothing
    set callbackOrderCancelReviveTriggers[callbackStartOrderCancelTriggersCounter] = whichTrigger
    set callbackStartOrderCancelTriggersCounter = callbackStartOrderCancelTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveStartEvent takes trigger whichTrigger returns nothing
    set callbackStartReviveTriggers[callbackStartReviveTriggersCounter] = whichTrigger
    set callbackStartReviveTriggersCounter = callbackStartReviveTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveFinishEvent takes trigger whichTrigger returns nothing
    set callbackFinishReviveTriggers[callbackFinishReviveTriggersCounter] = whichTrigger
    set callbackFinishReviveTriggersCounter = callbackFinishReviveTriggersCounter + 1
endfunction

function GetTriggerReviveAltar takes nothing returns unit
    return triggerReviveAltar
endfunction

function GetTriggerReviveHero takes nothing returns unit
    return triggerReviveHero
endfunction

private function ExecuteCallbacksOrderStartRevive takes unit altar, unit hero returns nothing
    local integer i = 0
    set triggerReviveAltar = altar
    set triggerReviveHero = hero
    loop
        exitwhen (i == callbackStartOrderStartTriggersCounter)
        if (IsTriggerEnabled(callbackOrderStartReviveTriggers[i])) then
            call ConditionalTriggerExecute(callbackOrderStartReviveTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteCallbacksOrderCancelRevive takes unit altar, unit hero returns nothing
    local integer i = 0
    set triggerReviveAltar = altar
    set triggerReviveHero = hero
    loop
        exitwhen (i == callbackStartOrderCancelTriggersCounter)
        if (IsTriggerEnabled(callbackOrderCancelReviveTriggers[i])) then
            call ConditionalTriggerExecute(callbackOrderCancelReviveTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteCallbacksStartRevive takes unit altar, unit hero returns nothing
    local integer i = 0
    set triggerReviveAltar = altar
    set triggerReviveHero = hero
    loop
        exitwhen (i == callbackStartReviveTriggersCounter)
        if (IsTriggerEnabled(callbackStartReviveTriggers[i])) then
            call ConditionalTriggerExecute(callbackStartReviveTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteCallbacksFinishRevive takes unit altar, unit hero returns nothing
    local integer i = 0
    set triggerReviveAltar = altar
    set triggerReviveHero = hero
    loop
        exitwhen (i == callbackFinishReviveTriggersCounter)
        if (IsTriggerEnabled(callbackFinishReviveTriggers[i])) then
            call ConditionalTriggerExecute(callbackFinishReviveTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    local unit altar = GetTriggerUnit()
    local unit hero = GetOrderTargetUnit()
    local integer orderId = GetIssuedOrderId()
    //call BJDebugMsg("Order " + GetUnitName(altar) + " " + I2S(orderId) + " with target unit " + GetUnitName(hero))
    // https://www.hiveworkshop.com/threads/getting-the-reviving-altar-for-event_unit_hero_revive_start.356746/#post-3645129
    if (orderId == ORDER_ID_START_REVIVE) then
        // save the corresponding altar for the hero
        call SaveUnitHandle(h, GetHandleId(hero), 0, altar)
        call ExecuteCallbacksOrderStartRevive(altar, hero)
    elseif (orderId == ORDER_ID_REVIVE) then // works only with HeroReviveCancelEvent
        call FlushChildHashtable(h, GetHandleId(hero))
        call GroupRemoveUnit(heroes, hero)
        call ExecuteCallbacksOrderCancelRevive(altar, hero)
    endif
    set altar = null
    set hero = null

    return false
endfunction

private function TriggerConditionStartRevive takes nothing returns boolean
    local unit hero = GetRevivingUnit()
    if (not IsUnitInGroup(hero, heroes)) then
        call GroupAddUnit(heroes, hero)
        // GetTriggerUnit is not the altar https://www.hiveworkshop.com/threads/getting-the-reviving-altar-for-event_unit_hero_revive_start.356746/
        call ExecuteCallbacksStartRevive(LoadUnitHandle(h, GetHandleId(hero), 0), hero)
    endif
    set hero = null

    return false
endfunction

private function TriggerConditionFinishRevive takes nothing returns boolean
    local unit hero = GetRevivingUnit()
    if (IsUnitInGroup(GetRevivingUnit(), heroes)) then
        call GroupRemoveUnit(heroes, hero)
        call ExecuteCallbacksFinishRevive(LoadUnitHandle(h, GetHandleId(hero), 0), hero)
        call FlushChildHashtable(h, GetHandleId(hero))
    endif
    set hero = null
    
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))

    call TriggerRegisterAnyUnitEventBJ(startReviveTrigger, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerAddCondition(startReviveTrigger, Condition(function TriggerConditionStartRevive))
    
    call TriggerRegisterAnyUnitEventBJ(finishReviveTrigger, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddCondition(finishReviveTrigger, Condition(function TriggerConditionFinishRevive))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
    if (IsUnitInGroup(whichUnit, heroes)) then
        call GroupRemoveUnit(heroes, whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
