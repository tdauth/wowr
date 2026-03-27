library WoWReforgedMarketplace initializer Init

globals
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger sellItemTrigger = CreateTrigger()
endglobals

private function IsMarketplace takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == BRUTOSAUR_MOUNT
endfunction

function UpdateEachStockBuildingHook takes itemtype iType, integer iLevel returns nothing
    local group g

    set bj_stockPickedItemType = iType
    set bj_stockPickedItemLevel = iLevel

    set g = CreateGroup()
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), Filter(function IsMarketplace))
    call ForGroup(g, function UpdateEachStockBuildingEnum)
    call DestroyGroup(g)
    set g = null
endfunction

hook UpdateEachStockBuilding UpdateEachStockBuildingHook

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == MARKETPLACE) then
        call SetItemTypeSlots(GetTriggerUnit(), 11)
    endif
    return false
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    if (GetOwningPlayer(GetSellingUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) and GetUnitTypeId(GetSellingUnit()) == MARKETPLACE) then
        call RemovePurchasedItem()
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))
    
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSellItem))
endfunction

endlibrary
