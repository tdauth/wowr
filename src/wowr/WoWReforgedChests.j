library WoWReforgedChests initializer Init

globals
    private trigger sellTrigger = CreateTrigger()
endglobals

function AddChest takes unit whichUnit returns nothing
    call AddUnitToStock(whichUnit, CHEST_NEUTRAL_EMPTY, 0, 1)
endfunction

private function UnitEmptiesChest takes unit whichUnit returns nothing
    local integer i = 0
    local integer max = GetRandomInt(2, 4)
    loop
        exitwhen i == max
        call UnitAddItemById(whichUnit, ChooseRandomItemExBJ(-1, ITEM_TYPE_ANY))
        set i = i + 1
    endloop
endfunction

private function TriggerConditionSell takes nothing returns boolean
    if (GetUnitTypeId(GetSoldUnit()) == CHEST_NEUTRAL_EMPTY) then
        call RemoveUnit(GetSoldUnit())
        call UnitEmptiesChest(GetBuyingUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
endfunction

endlibrary
