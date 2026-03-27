library WoWReforgedItemSets initializer Init requires NewBonus, WoWReforgedI18n

function interface OnItemSetFunction takes unit hero, ItemSet s returns nothing

struct ItemSet
    string name
    integer array components[10]
    integer componentsCounter = 0
    OnItemSetFunction onComplete
    OnItemSetFunction onUncomplete
endstruct

globals
    private ItemSet array itemSets
    private integer itemSetsCounter = 0
    
    private trigger pickupTrigger = CreateTrigger()
    private trigger dropTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

function GetItemSetsMax takes nothing returns integer
    return itemSetsCounter
endfunction

function GetItemSet takes integer index returns ItemSet
    return itemSets[index]
endfunction

function UnitHasItemSet takes unit whichUnit returns boolean
    return LoadBoolean(h, GetHandleId(whichUnit), 0)
endfunction

private function SetUnitHasItemSet takes unit whichUnit, boolean flag returns nothing
    call SaveBoolean(h, GetHandleId(whichUnit), 0, flag)
endfunction

private function ClearUnitHasItemSet takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit ClearUnitHasItemSet

private function CheckAllItemSets takes unit whichUnit returns nothing
    local ItemSet s = 0
    local integer j = 0
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i == itemSetsCounter)
        set s = itemSets[i]
        set counter = 0
        set j = 0
        loop
            exitwhen (j == s.componentsCounter)
            if (UnitHasItemOfTypeBJ(whichUnit, s.components[j])) then
                set counter = counter + 1
            endif
            set j = j + 1
        endloop
        if (counter == s.componentsCounter) then
            if (not UnitHasItemSet(whichUnit)) then
                call SetUnitHasItemSet(whichUnit, true)
                call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(whichUnit))], bj_QUESTMESSAGE_HINT, Format(GetLocalizedString("COMPLETED_ITEM_SET")).s(s.name).result()) // "Completed item set " + s.name + "."
                call s.onComplete.execute(whichUnit, s)
            endif
        else
            if (UnitHasItemSet(whichUnit)) then
                call ClearUnitHasItemSet(whichUnit)
                call s.onUncomplete.execute(whichUnit, s)
            endif
        endif
        set i = i + 1
    endloop
endfunction

function AddItemSet takes string name, OnItemSetFunction onComplete, OnItemSetFunction onUncomplete returns ItemSet
    local ItemSet this = ItemSet.create()
    set this.name = name
    set this.onComplete = onComplete
    set this.onUncomplete = onUncomplete
    set itemSets[itemSetsCounter] = this
    set itemSetsCounter = itemSetsCounter + 1
    return this
endfunction

function AddItemSetComponent takes ItemSet s, integer id returns integer
    local integer index = s.componentsCounter
    set s.components[index] = id
    set s.componentsCounter = s.componentsCounter + 1
    return index
endfunction

private function TriggerActionPickup takes nothing returns nothing
    call CheckAllItemSets(GetTriggerUnit())
endfunction

private function TriggerActionDrop takes nothing returns nothing
    call TriggerSleepAction(0.5) // wait for the item to be dropped
    call CheckAllItemSets(GetTriggerUnit())
endfunction

private function OnCompleteHolySet takes unit hero, ItemSet s returns nothing
    call AddUnitBonus(hero, BONUS_ARMOR, 10.0)
endfunction

private function OnUncompleteHolySet takes unit hero, ItemSet s returns nothing
    call AddUnitBonus(hero, BONUS_ARMOR, -10.0)
endfunction

private function Init takes nothing returns nothing
    local ItemSet s = 0
    
    call TriggerRegisterAnyUnitEventBJ(pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(pickupTrigger, function TriggerActionPickup)
    
    call TriggerRegisterAnyUnitEventBJ(dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddAction(dropTrigger, function TriggerActionDrop)
    
    // All sets
    set s = AddItemSet(GetLocalizedString("HOLY_SET"), OnCompleteHolySet, OnUncompleteHolySet)
    call AddItemSetComponent(s, ITEM_HOLY_CREST)
    call AddItemSetComponent(s, ITEM_HOLY_BOOTS)
    call AddItemSetComponent(s, ITEM_HOLY_GAUNTLET)
    call AddItemSetComponent(s, ITEM_HOLY_ARMOR)
    call AddItemSetComponent(s, ITEM_HOLY_SHIELD)
    call AddItemSetComponent(s, ITEM_HOLY_SWORD)
endfunction

endlibrary
