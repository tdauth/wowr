library WoWReforgedAlchemistLab initializer Init requires SimError, PagedButtons, ItemUtils, StringFormat, WoWReforgedUtils, WoWReforgedRaces

globals
    constant integer ABILITY_ID_CONVERT_UNIT = 'A16S'
    constant integer ABILITY_ID_CONVERT_ITEM = 'A1BI'
    constant integer UNIT_TYPE_ID_CONVERT = 'h03S'
    
    private trigger sellItemTrigger = CreateTrigger()
    private trigger sellUnitTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

private function SetShopRace takes unit shop, integer whichRace returns nothing
    call SetUnitUserData(shop, whichRace)
    call BlzSetUnitName(shop, Format(GetLocalizedString("ALCHEMIST_LAB_X")).s(GetObjectName(udg_RaceTavernItemType[whichRace])).result())
    //call BJDebugMsg("Change shop race to " + GetObjectName(udg_RaceTavernItemType[whichRace]))
endfunction

function AddAlchemistLab takes unit shop returns nothing
    local integer max = GetRacesMax()
    local integer i = 0
    call SetShopRace(shop, udg_RaceFreelancer)
    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop, 8)
    loop
        exitwhen (i >= max)
        call AddPagedButtonsItemType(shop, udg_RaceTavernItemType[i])
        set i = i + 1
    endloop
endfunction

private function IsRaceTypeAllowed takes player whichPlayer, integer t, integer targetRace returns boolean
    if (not PlayerHasUnlockedRace(whichPlayer, targetRace)) then
        if (t == RACE_OBJECT_TYPE_TIER_1) then
            return false
        elseif (t == RACE_OBJECT_TYPE_TIER_2) then
            return false
        elseif (t == RACE_OBJECT_TYPE_TIER_3) then
            return false
        elseif (t == RACE_OBJECT_TYPE_SCEPTER_ITEM) then
            return false
        elseif (t == RACE_OBJECT_TYPE_TIER_1_ITEM) then
            return false
        elseif (t == RACE_OBJECT_TYPE_TIER_2_ITEM) then
            return false
        elseif (t == RACE_OBJECT_TYPE_TIER_3_ITEM) then
            return false
        endif
    endif
    return true
endfunction

globals
    private trigger array convertTriggers
    private integer convertTriggersCounter = 0
    private unit triggerConverter = null
    private unit triggerReplacingUnit = null
    private item triggerReplacingItem = null
endglobals

function TriggerRegisterConvertEvent takes trigger whichTrigger returns nothing
    set convertTriggers[convertTriggersCounter] = whichTrigger
    set convertTriggersCounter = convertTriggersCounter + 1
endfunction

function GetTriggerConverter takes nothing returns unit
    return triggerConverter
endfunction

function GetTriggerReplacingUnit takes nothing returns unit
    return triggerReplacingUnit
endfunction

function GetTriggerReplacingItem takes nothing returns item
    return triggerReplacingItem
endfunction

private function ExecuteCallbacks takes unit converter, unit replacingUnit, item replacingItem returns nothing
    local integer i = 0
    loop
        exitwhen (i >= convertTriggersCounter)
        if (IsTriggerEnabled(convertTriggers[i])) then
            set triggerConverter = converter
            set triggerReplacingUnit = replacingUnit
            set triggerReplacingItem = replacingItem
            call ConditionalTriggerExecute(convertTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ConvertUnit takes unit caster, unit target, integer targetRace returns nothing
    local player owner = GetOwningPlayer(caster)
    local integer targetUnitTypeId = MapUnitID(GetUnitTypeId(target), targetRace, false)
    if (targetUnitTypeId != 0) then
        if (IsRaceTypeAllowed(owner, GetRaceObjectType(targetRace, targetUnitTypeId), targetRace)) then
            if (targetUnitTypeId != GetUnitTypeId(target)) then
                call ReplaceUnitBJ(target, targetUnitTypeId, bj_UNIT_STATE_METHOD_RELATIVE)
                call ExecuteCallbacks(caster, GetLastReplacedUnitBJ(), null)
            else
                call IssueImmediateOrder(caster, "stop")
                call SimError(owner, GetLocalizedString("COULD_NOT_CONVERT_TARGET_UNIT"))
            endif        
        else
            call IssueImmediateOrder(caster, "stop")
            call SimError(owner, GetLocalizedString("CONVERSION_NOT_ALLOWED"))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, GetLocalizedString("COULD_NOT_CONVERT_TARGET_UNIT"))
    endif
    set owner = null
endfunction

private function ConvertItem takes unit caster, item target, integer targetRace returns nothing
    local player owner = GetOwningPlayer(caster)
    local integer targetItemTypeId = MapRaceObjectType(GetItemTypeId(target), targetRace)
    local item whichItem = null
    if (targetItemTypeId != 0) then
        if (IsRaceTypeAllowed(owner, GetRaceObjectType(targetRace, targetItemTypeId), targetRace)) then            
            if (targetItemTypeId != GetItemTypeId(target)) then
                set whichItem = ReplaceItem(target, targetItemTypeId)
                call ExecuteCallbacks(caster, null, whichItem)
            else
                call IssueImmediateOrder(caster, "stop")
                call SimError(owner, GetLocalizedString("COULD_NOT_CONVERT_TARGET_ITEM"))
            endif
        else
            call IssueImmediateOrder(caster, "stop")
            call SimError(owner, GetLocalizedString("CONVERSION_NOT_ALLOWED"))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, GetLocalizedString("COULD_NOT_CONVERT_TARGET_ITEM"))
    endif
    set owner = null
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    local integer r = udg_RaceNone
    //call BJDebugMsg("Shop " + GetUnitName(shop) + " sells item " + GetItemName(soldItem))
    if (GetUnitTypeId(GetSellingUnit()) == ALCHEMIST_LAB) then
        set r = GetRaceByTavernItemTypeId(GetItemTypeId(GetSoldItem()))
        if (r != udg_RaceNone) then
            call SetShopRace(GetSellingUnit(),r)
        endif
        call RemoveItem(GetSoldItem())
    endif
    return false
endfunction

private function TriggerConditionSellUnit takes nothing returns boolean
    if (GetUnitTypeId(GetSoldUnit()) == UNIT_TYPE_ID_CONVERT) then
        call ConvertUnit(GetSellingUnit(), GetBuyingUnit(), GetUnitUserData(GetSellingUnit()))
        call RemoveUnit(GetSoldUnit())
    endif
    return false
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local unit shop = GetTriggerUnit()
    local integer abilityId = GetSpellAbilityId()
    local integer targetRace = GetUnitUserData(shop)
    local unit targetUnit = GetSpellTargetUnit()
    local item targetItem = GetSpellTargetItem()
    
    if (abilityId == ABILITY_ID_CONVERT_UNIT or abilityId == ABILITY_ID_CONVERT_ITEM) then
        if (targetUnit != null) then
            call ConvertUnit(shop, targetUnit, targetRace)
        elseif (targetItem != null) then
            call ConvertItem(shop, targetItem, targetRace)
        endif
    endif
    
    set shop = null
    set targetUnit = null
    set targetItem = null
    
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSellItem))
    
    call TriggerRegisterAnyUnitEventBJ(sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellUnitTrigger, Condition(function TriggerConditionSellUnit))
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
