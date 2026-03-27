library Refund requires ItemTypeUtils, UnitCost

function RefundUnit takes unit whichUnit returns nothing
    local player owner = GetOwningPlayer(whichUnit)
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer gold = GetUnitGoldCostSafe(unitTypeId)
    local integer lumber = GetUnitWoodCostSafe(unitTypeId)
    call AdjustPlayerStateSimpleBJ(owner, PLAYER_STATE_RESOURCE_GOLD, gold)
    call AdjustPlayerStateSimpleBJ(owner, PLAYER_STATE_RESOURCE_LUMBER, lumber)
    call RemoveUnit(whichUnit)
    set whichUnit = null
    set owner = null
endfunction

function RefundItem takes item whichItem, player whichPlayer returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer gold = GetItemGoldCost(itemTypeId)
    local integer lumber = GetItemWoodCost(itemTypeId)
    call AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
    call AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
    call RemoveItem(whichItem)
    set whichItem = null
endfunction

endlibrary
