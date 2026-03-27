library WoWReforgedProfessionProspector initializer Init requires Resources

globals
    private integer array goldItemTypeIds
    private integer goldItemTypeIdsCounter = 0
endglobals

function IsGoldItem takes integer itemTypeId returns boolean
    local integer i = 0
    loop
        exitwhen (i == goldItemTypeIdsCounter)
        if (itemTypeId == goldItemTypeIds[i]) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function AddGoldItemTypeId takes integer itemTypeId returns nothing
    set goldItemTypeIds[goldItemTypeIdsCounter] = itemTypeId
    set goldItemTypeIdsCounter = goldItemTypeIdsCounter + 1
endfunction

function ProspectorPickup takes unit hero, item whichItem returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    if (IsGoldItem(itemTypeId) and UnitHasItemOfTypeBJ(hero, ITEM_GOLD_DRILL)) then
        call SetItemCharges(whichItem, IMaxBJ(1, GetItemCharges(whichItem)) + 1)
    endif
endfunction

private function Init takes nothing returns nothing
    call AddGoldItemTypeId(ITEM_ORE_GOLD)
    call AddGoldItemTypeId(ITEM_GOLD_BARS)
    call AddGoldItemTypeId(ITEM_GOLD_COINS)
endfunction

endlibrary
