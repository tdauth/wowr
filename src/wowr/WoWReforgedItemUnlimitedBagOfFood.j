library WoWReforgedItemUnlimitedBagOfFood initializer Init

//call UnlimitedBagOfFood(GetTriggerUnit())

globals
    private integer array ids
    private integer counter = 0
endglobals

private function GetRandomId takes nothing returns integer
    return ids[GetRandomInt(0, counter)]
endfunction

function UnlimitedBagOfFood takes unit whichUnit returns nothing
    call UnitAddItemById(whichUnit, GetRandomId())
endfunction

private function AddId takes integer id returns nothing
    set ids[counter] = id
    set counter = counter + 1
endfunction

private function Init takes nothing returns nothing
    call AddId(ITEM_BUNDLE_OF_WHEAT)
    call AddId(ITEM_APPLE)
    call AddId(ITEM_BANANA)
    call AddId(ITEM_CHERRY)
    call AddId(ITEM_FISH)
    call AddId(ITEM_GARLIC)
    call AddId(ITEM_LEMON)
    call AddId(ITEM_MEAT)
    call AddId(ITEM_ORANGE)
    call AddId(ITEM_PLUM)
    call AddId(ITEM_PUMPKIN)
    call AddId(ITEM_WOOL)
endfunction

endlibrary
