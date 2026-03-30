library WoWReforgedBuilder initializer Init requires PagedButtons, SafeString, WoWReforgedRaces, WoWReforgedNeutral

globals
    constant integer BUILDER = 'E027'
    
    constant integer ITEM_TYPE_ID_PLAYER_RED = 'I0VZ'
    constant integer ITEM_TYPE_ID_NEUTRAL_HOSTILE = 'I0W0'
    constant integer ITEM_TYPE_ID_NEUTRAL_PASSIVE = 'I0W1'
    
    constant integer ITEM_TYPE_ID_COLOR_RED = 'I0W2'
    
    private integer array targetPlayerIndex

    private trigger sellTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger orderTargetTrigger = CreateTrigger()
endglobals

function EnableBuilder takes unit whichUnit returns nothing
    local integer max = 0
    local integer i = 0
    local integer max2 = 0
    local integer j = 0
    call EnablePagedButtons(whichUnit)
    
    call SetPagedButtonsCurrentPageName(whichUnit, GetLocalizedStringSafe("PLAYERS"))
    call AddPagedButtonsItemType(whichUnit, ITEM_TYPE_ID_PLAYER_RED)
    call AddPagedButtonsItemType(whichUnit, ITEM_TYPE_ID_NEUTRAL_HOSTILE)
    call AddPagedButtonsItemType(whichUnit, ITEM_TYPE_ID_NEUTRAL_PASSIVE)
    
    call AddPagedButtonsSpacersRemaining(whichUnit)
   
    call SetPagedButtonsCurrentPageName(whichUnit, GetLocalizedStringSafe("COLORS"))
    call AddPagedButtonsItemType(whichUnit, ITEM_TYPE_ID_COLOR_RED)
    call AddPagedButtonsSpacersRemaining(whichUnit)
    
    call SetPagedButtonsCurrentPageName(whichUnit, GetLocalizedStringSafe("CREEPS"))
    set i = 0
    set max = GetCreepsMax()
    loop
        exitwhen (i >= max)
        if (GetCreep(i) != 0) then
            call AddPagedButtonsUnitType(whichUnit, GetCreep(i))
        endif
        set i = i + 1
    endloop
    
    call SetPagedButtonsCurrentPageName(whichUnit, GetLocalizedStringSafe("RACES"))
    set max = GetRacesMax()
    loop
        exitwhen (i >= max)
        set max2 = RACE_MAX_OBJECT_TYPES
        set j = 0
        loop
            exitwhen (j >= max2)
            if (GetRaceObjectTypeId(i, j) != 0) then
                if (IsRaceItem(i)) then
                    call AddPagedButtonsItemType(whichUnit, GetRaceObjectTypeId(i, j))
                else
                    call AddPagedButtonsUnitType(whichUnit, GetRaceObjectTypeId(i, j))
                endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function GetTargetPlayer takes player whichPlayer returns player
    return Player(targetPlayerIndex[GetPlayerId(whichPlayer)])
endfunction

private function TriggerConditionSell takes nothing returns boolean
    local unit b = GetSellingUnit()
    local integer itemTypeId = GetItemTypeId(GetSoldItem())
    local player owner = GetOwningPlayer(b)
    local integer playerId = GetPlayerId(owner)
    if (GetUnitTypeId(b) == BUILDER) then
        if (itemTypeId == ITEM_TYPE_ID_PLAYER_RED) then
            set targetPlayerIndex[playerId] = 0
        elseif (itemTypeId == ITEM_TYPE_ID_NEUTRAL_HOSTILE) then
            set targetPlayerIndex[playerId] = PLAYER_NEUTRAL_AGGRESSIVE
        elseif (itemTypeId == ITEM_TYPE_ID_NEUTRAL_PASSIVE) then
            set targetPlayerIndex[playerId] = PLAYER_NEUTRAL_PASSIVE
        elseif (itemTypeId == ITEM_TYPE_ID_COLOR_RED) then
            call SetPlayerColor(GetTargetPlayer(owner), PLAYER_COLOR_RED) 
        else
            call CreateUnit(GetTargetPlayer(owner), itemTypeId, GetUnitX(b), GetUnitY(b), GetUnitFacing(b))
        endif
        call RemoveItem(GetSoldItem())
    endif
    set b = null
    set owner = null
    return false
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    if (GetUnitTypeId(GetTriggerUnit()) == BUILDER) then
        if (GetIssuedOrderId() == OrderId("smart") or GetIssuedOrderId() == OrderId("move")) then
            call IssuePointOrder(GetTriggerUnit(), "blink", GetOrderPointX(), GetOrderPointY())
        endif
    endif
    return false
endfunction

private function TriggerConditionOrderTarget takes nothing returns boolean
    if (GetUnitTypeId(GetTriggerUnit()) == BUILDER) then
        if (GetIssuedOrderId() == OrderId("smart") or GetIssuedOrderId() == OrderId("move")) then
            call IssuePointOrder(GetTriggerUnit(), "blink", GetWidgetX(GetOrderTarget()), GetWidgetY(GetOrderTarget()))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    
    call TriggerRegisterAnyUnitEventBJ(orderTargetTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTargetTrigger, Condition(function TriggerConditionOrderTarget))
endfunction

endlibrary
