library WoWReforgedTradingPosts initializer Init requires MathUtils, PagedButtons

globals
    private group tradingPosts = CreateGroup()
    private boolean array autoExchange
    private trigger castTrigger = CreateTrigger()
    private trigger gatherTrigger = CreateTrigger()
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger sellTrigger = CreateTrigger()
endglobals

private struct TradingPostResource
    Resource resource
    integer buyUnitTypeId
    integer sellUnitTypeId
endstruct

globals
    private TradingPostResource array tradingPostResource
    private integer tradingPostResourceCount = 0
endglobals

function AddTradingPostResource takes Resource resource, integer buyUnitTypeId, integer sellUnitTypeId returns nothing
    local TradingPostResource r = TradingPostResource.create()
    set r.resource = resource
    set r.buyUnitTypeId = buyUnitTypeId
    set r.sellUnitTypeId = sellUnitTypeId
    set tradingPostResource[tradingPostResourceCount] = r
    set tradingPostResourceCount = tradingPostResourceCount + 1
endfunction

function AddTradingPostResourceWoWReforged takes nothing returns nothing
    call AddTradingPostResource(udg_TmpInteger, udg_TmpUnitType, udg_TmpUnitType2)
endfunction

function AddResourcesShop takes unit shop returns nothing
    local integer i = 0
    local TradingPostResource r = 0
    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop, 8) // 12 - 2 Page Buttons
    loop
        exitwhen (i == tradingPostResourceCount)
        set r = tradingPostResource[i]
        call AddPagedButtonsUnitType(shop, r.buyUnitTypeId) // Buy 100
        call AddPagedButtonsUnitType(shop, r.sellUnitTypeId) // Sell 100
        set i = i + 1
    endloop
endfunction

function TradingPostSellsUnit takes unit tradingPost, unit soldUnit returns nothing
    local integer unitTypeId = GetUnitTypeId(soldUnit)
    local player owner = GetOwningPlayer(soldUnit)
    local TradingPostResource r = 0
    local integer i = 0
    loop
        exitwhen (i == tradingPostResourceCount)
        set r = tradingPostResource[i]
        if (unitTypeId == r.buyUnitTypeId) then // Buy 100
            call AddPlayerResource(owner, r.resource, 100)
            call RemoveUnit(soldUnit)
            exitwhen (true)
        elseif (unitTypeId == r.sellUnitTypeId) then // Sell 100
            if (ExchangePlayerResource(owner, r.resource, Resources_GOLD, 100) == 0) then
                call SimError(owner, Format(GetLocalizedString("NO_X")).s(GetResourceName(r.resource)).result())
            endif
            call RemoveUnit(soldUnit)
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    set owner = null
endfunction

private function TriggerConditionGather takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerWorker()))
    if (autoExchange[playerId]) then
        call CustomBountyFadingText(GetTriggerWorker(), Resources_GOLD, GetTriggerResourceAmount())
        call ExchangePlayerResource(GetOwningPlayer(GetTriggerWorker()), GetTriggerResource(), Resources_GOLD, GetTriggerResourceAmount())
    endif
    return false
endfunction

private function TriggerConditionAutoExchangeCast takes nothing returns boolean
    return GetSpellAbilityId() == 'A1TW'
endfunction

private function TriggerActionAutoExchangeCast takes nothing returns nothing
    set autoExchange[GetPlayerId(GetTriggerPlayer())] = not autoExchange[GetPlayerId(GetTriggerPlayer())]
    if (autoExchange[GetPlayerId(GetTriggerPlayer())]) then
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0.0, 0.0, GetLocalizedString("ENABLED_GOLD_AUTO_EXCHANGE"))
    else
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0.0, 0.0, GetLocalizedString("DISABLED_GOLD_AUTO_EXCHANGE"))
    endif
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == TRADING_POST) then
        call GroupAddUnit(tradingPosts, GetConstructedStructure())
        call AddResourcesShop(GetConstructedStructure())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitInGroup(GetTriggerUnit(), tradingPosts)) then
        call GroupRemoveUnit(tradingPosts, GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionSell takes nothing returns boolean
    if (IsUnitInGroup(GetTriggerUnit(), tradingPosts)) then
        call TradingPostSellsUnit(GetTriggerUnit(), GetSoldUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionAutoExchangeCast))
    call TriggerAddAction(castTrigger, function TriggerActionAutoExchangeCast)
    
    call TriggerRegisterGatherEvent(gatherTrigger)
    call TriggerAddCondition(gatherTrigger, Condition(function TriggerConditionGather))
    
    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
endfunction

endlibrary
