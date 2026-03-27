library ResourcesCosts initializer Init requires MathUtils, SimError, Refund, StringFormat, Resources

/**
 * Optional system for unit type resource costs.
 */

globals
    // Source for refund values: http://classic.battle.net/war3/basics/buildings.shtml
    public constant real REFUND_BUILDING = 0.75
    public constant real REFUND_RESEARCH = 1.0
    public constant real REFUND_UPGRADE = 0.75
    public constant real REFUND_UNIT_TRAINING = 1.0
    public constant real REFUND_HERO_REVIVAL = 1.0
    public constant real REFUND_ITEM = 0.5 // the item value when selling items in general
    public constant integer MAX_LEVEL = 100
    public constant integer CANCEL_ORDER_ID = 851976
    public constant integer KEY_HAS_COSTS = bj_MAX_PLAYERS
    public constant integer KEY_IS_RESEARCH = bj_MAX_PLAYERS + 1
    public constant integer KEY_IS_ABILITY = bj_MAX_PLAYERS + 2
    public constant integer KEY_GOLD_VALUE = bj_MAX_PLAYERS + 3
    public constant integer KEY_LUMBER_VALUE = bj_MAX_PLAYERS + 4
    public constant integer MAX_KEYS = bj_MAX_PLAYERS + 5
    
    private sound array playerSoundNotEnough
    private hashtable h = InitHashtable() // for object type IDs
    private hashtable h2 = InitHashtable() // for timers only
    private trigger issueTrigger = CreateTrigger()
    private trigger constructCancelTrigger = CreateTrigger()
    private trigger trainCancelTrigger = CreateTrigger()
    private trigger researchCancelTrigger = CreateTrigger()
    private trigger heroReviveCancelTrigger = CreateTrigger()
    private trigger unitSellTrigger = CreateTrigger()
    private trigger itemSellTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
endglobals

private function GetAlliesWithSharedControl takes player owner returns force
    local force allies = CreateForce()
    local player slotPlayer = null
    local integer i = 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    return allies
endfunction

private function StartSoundForAllies takes player whichPlayer, sound whichSound returns nothing
    local force allies = GetAlliesWithSharedControl(whichPlayer)
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call StartSound(whichSound)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

private function SimErrorForAllies takes player whichPlayer, string msg returns nothing
    local force allies = GetAlliesWithSharedControl(whichPlayer)
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), allies)) then
            call SimError(Player(i), msg)
        endif
        set i = i + 1
    endloop
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

function SetObjectTypeResourcesCostsIsResearch takes integer objectTypeId, boolean hasLevels returns nothing
    call SaveBoolean(h, objectTypeId, Index3D(0, KEY_IS_RESEARCH, 0, MAX_KEYS, MAX_LEVEL), hasLevels)
endfunction

function GetObjectTypeResourcesCostsIsResearch takes integer objectTypeId returns boolean
    return LoadBoolean(h, objectTypeId, Index3D(0, KEY_IS_RESEARCH, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function SetObjectTypeResourcesCostsIsAbility takes integer objectTypeId, boolean hasLevels returns nothing
    call SaveBoolean(h, objectTypeId, Index3D(0, KEY_IS_ABILITY, 0, MAX_KEYS, MAX_LEVEL), hasLevels)
endfunction

function GetObjectTypeResourcesCostsIsAbility takes integer objectTypeId returns boolean
    return LoadBoolean(h, objectTypeId, Index3D(0, KEY_IS_ABILITY, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function SetObjectTypeResourcesCostsHasCosts takes integer objectTypeId, boolean hasCosts returns nothing
    call SaveBoolean(h, objectTypeId, Index3D(0, KEY_HAS_COSTS, 0, MAX_KEYS, MAX_LEVEL), hasCosts)
endfunction

function GetObjectTypeResourcesCostsHasCosts takes integer objectTypeId returns boolean
    return LoadBoolean(h, objectTypeId, Index3D(0, KEY_HAS_COSTS, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function SetObjectTypeGoldValue takes integer objectTypeId, integer value returns nothing
    call SaveInteger(h, objectTypeId, Index3D(0, KEY_GOLD_VALUE, 0, MAX_KEYS, MAX_LEVEL), value)
endfunction

function GetObjectTypeGoldValue takes integer objectTypeId returns integer
    return LoadInteger(h, objectTypeId, Index3D(0, KEY_GOLD_VALUE, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function HasObjectTypeGoldValue takes integer objectTypeId returns boolean
    return HaveSavedInteger(h, objectTypeId, Index3D(0, KEY_GOLD_VALUE, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function SetObjectTypeLumberValue takes integer objectTypeId, integer value returns nothing
    call SaveInteger(h, objectTypeId, Index3D(0, KEY_LUMBER_VALUE, 0, MAX_KEYS, MAX_LEVEL), value)
endfunction

function GetObjectTypeLumberValue takes integer objectTypeId returns integer
    return LoadInteger(h, objectTypeId, Index3D(0, KEY_LUMBER_VALUE, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function HasObjectTypeLumberValue takes integer objectTypeId returns boolean
    return HaveSavedInteger(h, objectTypeId, Index3D(0, KEY_LUMBER_VALUE, 0, MAX_KEYS, MAX_LEVEL))
endfunction

function SetObjectTypeLevelResourcesCostsForPlayer takes player whichPlayer, integer objectTypeId, integer level, Resource resource, integer amount returns nothing
    if (amount > 0) then
        call SetObjectTypeResourcesCostsHasCosts(objectTypeId, true)
    endif
    call SaveInteger(h, objectTypeId, Index3D(resource, GetPlayerId(whichPlayer), level, MAX_KEYS, MAX_LEVEL), amount)
endfunction

function GetObjectTypeLevelResourcesCostsForPlayer takes player whichPlayer, integer objectTypeId, integer level, Resource resource returns integer
    return LoadInteger(h, objectTypeId, Index3D(resource, GetPlayerId(whichPlayer), level, MAX_KEYS, MAX_LEVEL))
endfunction

function SetResearchCostsForLevel takes integer objectTypeId, integer level, Resource resource, integer amount returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call SetObjectTypeLevelResourcesCostsForPlayer(Player(i), objectTypeId, level, resource, amount)
        set i = i + 1
    endloop
    call SetObjectTypeResourcesCostsIsResearch(objectTypeId, true)
endfunction

function SetResearchCosts takes integer objectTypeId, Resource resource, integer amount returns nothing
    call SetResearchCostsForLevel(objectTypeId, 0, resource, amount)
endfunction

function SetAbilityCostsForLevel takes integer objectTypeId, integer level, Resource resource, integer amount returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call SetObjectTypeLevelResourcesCostsForPlayer(Player(i), objectTypeId, level, resource, amount)
        set i = i + 1
    endloop
    call SetObjectTypeResourcesCostsIsAbility(objectTypeId, true)
endfunction

function SetAbilityCosts takes integer objectTypeId, Resource resource, integer amount returns nothing
    call SetAbilityCostsForLevel(objectTypeId, 1, resource, amount)
endfunction

function SetObjectTypeResourcesCostsForPlayer takes player whichPlayer, integer objectTypeId, Resource resource, integer amount returns nothing
    call SetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, 0, resource, amount)
endfunction

function GetObjectTypeResourcesCostsForPlayer takes player whichPlayer, integer objectTypeId, Resource resource returns integer
    return GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, 0, resource)
endfunction

function SetObjectTypeResourcesCosts takes integer objectTypeId, Resource resource, integer amount returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call SetObjectTypeResourcesCostsForPlayer(Player(i), objectTypeId, resource, amount)
        set i = i + 1
    endloop
endfunction

function SetCosts takes integer objectTypeId, Resource resource, integer amount returns nothing
    call SetObjectTypeResourcesCosts(objectTypeId, resource, amount)
endfunction

function GetCosts takes player whichPlayer, integer objectTypeId, Resource resource returns nothing
    call GetObjectTypeResourcesCostsForPlayer(whichPlayer, objectTypeId, resource)
endfunction

function GetCostsForLevel takes player whichPlayer, integer objectTypeId, integer level, Resource resource returns nothing
    call GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, level, resource)
endfunction

function RemoveObjectTypeResourcesCosts takes integer objectTypeId returns nothing
    call FlushChildHashtable(h, objectTypeId)
endfunction

function SetNotEnoughResourcesSound takes player whichPlayer, Resource resource, sound whichSound returns nothing
    set playerSoundNotEnough[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)] = whichSound
endfunction

function GetNotEnoughResourcesSound takes player whichPlayer, Resource resource returns sound
    return playerSoundNotEnough[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)]
endfunction

function SetNotEnoughResourcesSoundForAllPlayers takes Resource resource, sound whichSound returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerSoundNotEnough[Index2D(resource, i, bj_MAX_PLAYERS)] = whichSound
        set i = i + 1
    endloop
endfunction

private function GetLevel takes player whichPlayer, unit worker, integer objectTypeId returns integer
    if (GetObjectTypeResourcesCostsIsResearch(objectTypeId)) then
        return GetPlayerTechCountSimple(objectTypeId, whichPlayer)
    elseif (GetObjectTypeResourcesCostsIsAbility(objectTypeId)) then
        return GetUnitAbilityLevel(worker, objectTypeId)
    endif
    return 0
endfunction

function CheckResourceCosts takes player whichPlayer, unit worker, integer objectTypeId, boolean showError returns boolean
    local Resource resource = 0
    local integer cost = 0
    local boolean enough = true
    local boolean hasCost = GetObjectTypeResourcesCostsHasCosts(objectTypeId)
    local integer level = 0
    local integer max = GetMaxResources()
    local integer i = 0
    //call BJDebugMsg(GetObjectName(objectTypeId) + " has costs.")
    if (hasCost) then
        set level = GetLevel(whichPlayer, worker, objectTypeId)
        //call BJDebugMsg("Level " + I2S(level))
        loop
            exitwhen (i == max or not enough)
            set resource = GetResource(i)
            set cost = GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, level, resource)
            if (cost > GetPlayerResource(whichPlayer, resource)) then
                if (showError) then
                    call SimErrorForAllies(whichPlayer, Format(GetLocalizedString("NOT_ENOUGH_X")).s(GetResourceName(resource)).result())
                    if (GetNotEnoughResourcesSound(whichPlayer, resource) != null) then
                        call StartSoundForAllies(whichPlayer, GetNotEnoughResourcesSound(whichPlayer, resource))
                    endif
                endif
                set enough = false
            endif
            set i = i + 1
        endloop
    endif
    return enough
endfunction

function RemoveResourceCosts takes player whichPlayer, unit worker, integer objectTypeId returns nothing
    local Resource resource = 0
    local boolean hasCost = GetObjectTypeResourcesCostsHasCosts(objectTypeId)
    local integer level = 0
    local integer max = GetMaxResources()
    local integer i = 0
    if (hasCost) then
        set level = GetLevel(whichPlayer, worker, objectTypeId)
        loop
            exitwhen (i == max)
            set resource = GetResource(i)
            call RemovePlayerResource(whichPlayer, resource, GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, level, resource))
            set i = i + 1
        endloop
    endif
endfunction

function RefundResourceCosts takes player whichPlayer, unit worker, integer objectTypeId, real factor returns nothing
    local Resource resource = 0
    local boolean hasCost = GetObjectTypeResourcesCostsHasCosts(objectTypeId)
    local integer cost = 0
    local integer level = 0
    local integer max = GetMaxResources()
    local integer i = 0
    //call BJDebugMsg("Refund cost with factor " + R2S(factor))
    if (hasCost) then
        set level = GetLevel(whichPlayer, worker, objectTypeId)
        loop
            exitwhen (i == max)
            set resource = GetResource(i)
            set cost = GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer, objectTypeId, level, resource)
            if (cost > 0) then
                call AddPlayerResource(whichPlayer, resource, R2I(I2R(cost) * factor))
                //call BJDebugMsg("Refund " + I2S(R2I(I2R(cost) * factor)) + " of " + GetResourceName(resource))
            endif
            set i = i + 1
        endloop
    endif
endfunction

private function TriggerConditionIssue takes nothing returns boolean
    if (CheckResourceCosts(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), GetIssuedOrderId(), true)) then
        // remove resources on ordering the unit which also happens in Warcraft III when you order a worker to build something
        call RemoveResourceCosts(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), GetIssuedOrderId())
        
        return false
    endif
    
    return true
endfunction

private function EnableCancelTriggers takes nothing returns nothing
    call EnableTrigger(constructCancelTrigger)
    call EnableTrigger(trainCancelTrigger)
    call EnableTrigger(researchCancelTrigger)
    call EnableTrigger(heroReviveCancelTrigger)
endfunction

private function DisableCancelTriggers takes nothing returns nothing
    call DisableTrigger(constructCancelTrigger)
    call DisableTrigger(trainCancelTrigger)
    call DisableTrigger(researchCancelTrigger)
    call DisableTrigger(heroReviveCancelTrigger)
endfunction

private function TimerFunctionCancel takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit whichUnit = LoadUnitHandle(h2, handleId, 0)
    call DisableCancelTriggers()
    call IssueImmediateOrderById(whichUnit, CANCEL_ORDER_ID)
    call IssueImmediateOrder(whichUnit, "stop") // for constructions
    call EnableCancelTriggers()
    call FlushChildHashtable(h2, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
endfunction

private function TriggerActionIssue takes nothing returns nothing
    local timer t = CreateTimer()
    call SaveUnitHandle(h2, GetHandleId(t), 0, GetTriggerUnit())
    call TimerStart(t, 0.0, false, function TimerFunctionCancel)
endfunction

private function TriggerConditionConstructCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetCancelledStructure()), GetTriggerUnit(), GetUnitTypeId(GetCancelledStructure()), REFUND_BUILDING)
    return false
endfunction

private function TriggerConditionTrainCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), GetTrainedUnitType(), REFUND_UNIT_TRAINING)
    return false
endfunction

private function TriggerConditionResearchCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetResearchingUnit()), GetTriggerUnit(), GetResearched(), REFUND_RESEARCH)
    return false
endfunction

private function TriggerConditionHeroReviveCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetRevivingUnit()), GetTriggerUnit(), GetUnitTypeId(GetRevivableUnit()), REFUND_HERO_REVIVAL)
    return false
endfunction

private function TriggerConditionUnitSell takes nothing returns boolean
    if (CheckResourceCosts(GetOwningPlayer(GetBuyingUnit()), GetBuyingUnit(), GetUnitTypeId(GetSoldUnit()), true)) then
        call RemoveResourceCosts(GetOwningPlayer(GetBuyingUnit()), GetBuyingUnit(), GetUnitTypeId(GetSoldUnit()))
    else
        call RefundUnit(GetSoldUnit())
        call RemoveUnit(GetSoldUnit())
    endif
    return false
endfunction

private function TriggerConditionItemSell takes nothing returns boolean
    if (CheckResourceCosts(GetOwningPlayer(GetBuyingUnit()), GetBuyingUnit(), GetItemTypeId(GetSoldItem()), true)) then
        call RemoveResourceCosts(GetOwningPlayer(GetBuyingUnit()), GetBuyingUnit(), GetItemTypeId(GetSoldItem()))
    else
        call RefundItem(GetSoldItem(), GetOwningPlayer(GetBuyingUnit()))
        call RemoveItem(GetSoldItem())
    endif
    return false
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    //call BJDebugMsg("Checking ability costs for " + GetObjectName(GetSpellAbilityId()) + " for caster " + GetUnitName(GetTriggerUnit()) + " with level " + I2S(GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
    if (CheckResourceCosts(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), GetSpellAbilityId(), true)) then
        call RemoveResourceCosts(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), GetSpellAbilityId())
    else
        //call SetUnitState(GetTriggerUnit(), UNIT_STATE_MANA, GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) + BlzGetAbilityManaCost(GetSpellAbilityId(), GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(issueTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(issueTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(issueTrigger, Condition(function TriggerConditionIssue))
    call TriggerAddAction(issueTrigger, function TriggerActionIssue)
    
    call TriggerRegisterAnyUnitEventBJ(constructCancelTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    call TriggerAddCondition(constructCancelTrigger, Condition(function TriggerConditionConstructCancel))
    
    call TriggerRegisterAnyUnitEventBJ(trainCancelTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(trainCancelTrigger, Condition(function TriggerConditionTrainCancel))
    
    call TriggerRegisterAnyUnitEventBJ(researchCancelTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerAddCondition(researchCancelTrigger, Condition(function TriggerConditionResearchCancel))
    
    call TriggerRegisterAnyUnitEventBJ(heroReviveCancelTrigger, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    call TriggerAddCondition(heroReviveCancelTrigger, Condition(function TriggerConditionHeroReviveCancel))
    
    call TriggerRegisterAnyUnitEventBJ(unitSellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(unitSellTrigger, Condition(function TriggerConditionUnitSell))
    
    call TriggerRegisterAnyUnitEventBJ(itemSellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(itemSellTrigger, Condition(function TriggerConditionItemSell))
    
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
