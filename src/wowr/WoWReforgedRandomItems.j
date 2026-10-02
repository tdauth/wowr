library WoWReforgedRandomItems initializer Init

globals
    private itemtype array allowedItemTypes
    private integer allowedItemTypesCount = 0
endglobals

private function AddAllowedItemType takes itemtype t returns nothing
    set allowedItemTypes[allowedItemTypesCount] = t
    set allowedItemTypesCount = allowedItemTypesCount + 1
endfunction

private function GetRandomItemType takes nothing returns itemtype
    return allowedItemTypes[GetRandomInt(0, allowedItemTypesCount - 1)]
endfunction

// Only items which can be sold.
function GetRandomDropableItemTypeId takes integer itemLevel returns integer
    local itemtype pickedItemType = GetRandomItemType()
    local integer iteration = 0
    local integer  pickedItemId

    loop
        set pickedItemId = ChooseRandomItemEx(pickedItemType, itemLevel)
        exitwhen IsItemIdSellable(pickedItemId)

        // If we get hung up on an entire class/level combo of unsellable
        // items, or a very unlucky series of random numbers, give up.
        set iteration = iteration + 1
        if (iteration > bj_STOCK_MAX_ITERATIONS) then
            return 0
        endif
    endloop

    return pickedItemId
endfunction

private function Init takes nothing returns nothing
    // No ITEM_TYPE_CAMPAIGN to prevent Backpack items from Forsaken Kingdom to be dropped.
    call AddAllowedItemType(ITEM_TYPE_PERMANENT)
    call AddAllowedItemType(ITEM_TYPE_CHARGED)
    call AddAllowedItemType(ITEM_TYPE_POWERUP)
    call AddAllowedItemType(ITEM_TYPE_ARTIFACT)
    call AddAllowedItemType(ITEM_TYPE_PURCHASABLE)
    call AddAllowedItemType(ITEM_TYPE_MISCELLANEOUS)
endfunction

endlibrary
