library WoWReforgedProfessionCombiner initializer Init requires SimError

globals
    private constant integer ABILITY_ID_INSPECT = 'A1OC'
    private constant integer ABILITY_ID_MARK_1 = 'A1OD'
    private constant integer ABILITY_ID_MARK_2 = 'A1OE'
    private constant integer ABILITY_ID_MARK_3 = 'A1OF'
    private constant integer ABILITY_ID_MARK_4 = 'A1OG'
    private constant integer ABILITY_ID_TRANSFER = 'A1OH'

    private hashtable h = InitHashtable()
    private trigger castTrigger = CreateTrigger()
endglobals

private function InspectItem takes player whichPlayer, item whichItem returns nothing
    local string msg = GetItemName(whichItem) + ", Level " + I2S(GetItemLevel(whichItem))
    local integer i = 0
    loop
        exitwhen (i == 4)
        if (BlzGetItemAbilityByIndex(whichItem, i) != null) then
            set msg = msg + ", " + I2S(i) + " " + GetObjectName(BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, i)))
        endif
        set i = i + 1
    endloop
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, msg)
endfunction

private function ItemUnusedAbilities takes item whichItem returns integer
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i == 4)
        if (BlzGetItemAbilityByIndex(whichItem, i) == null) then
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return counter
endfunction

private function GetMaxTransferItemLevel takes unit hero returns integer
    local item slotItem = null
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem != null) then
            if (GetItemTypeId(slotItem) == ITEM_MASTER_COMBINATION_TOOL and result < 8) then
                set result = 8
                exitwhen (true)
            elseif (GetItemTypeId(slotItem) == ITEM_ADVANCED_COMBINATION_TOOL and result < 6) then
                set result = 6
            elseif (GetItemTypeId(slotItem) == ITEM_COMBINATION_TOOL and result < 4) then
                set result = 4
            elseif (GetItemTypeId(slotItem) == ITEM_SMALL_COMBINATION_TOOL and result < 2) then
                set result = 2
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

private function MarkItem takes unit caster, item whichItem, integer abilityIndex returns nothing
    local integer abilityId = BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, abilityIndex))
    if (not IsItemInvulnerable(whichItem)) then
        if (ItemUnusedAbilities(whichItem) > 0) then
            if (abilityId != 0) then
                call SaveItemHandle(h, GetHandleId(caster), 0, whichItem)
                call SaveInteger(h, GetHandleId(caster), 1, abilityIndex)
                call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, 6.0, Format(GetLocalizedString("MARKED_ABILITY_X")).s(GetObjectName(abilityId)).result())
            else
                call SimError(GetOwningPlayer(caster), Format(GetLocalizedString("COMBINE_ERROR_NO_ABILITY_TARGET")).i(abilityIndex + 1).result())
            endif
        else
            call SimError(GetOwningPlayer(caster), GetLocalizedString("COMBINE_ERROR_NO_FREE_TARGET"))
        endif
    else
        call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET_ITEM"))
    endif
endfunction

private function TransferItemAbilityEx takes unit caster, item sourceItem, integer abilityIndex, item targetItem, integer maxLevel returns nothing
    local integer abilityId = BlzGetAbilityId(BlzGetItemAbilityByIndex(sourceItem, abilityIndex))
    if (UnitHasItem(caster, sourceItem)) then
        if (GetItemLevel(sourceItem) <= maxLevel) then
            if (BlzGetItemAbilityByIndex(sourceItem, abilityIndex) != null) then
                if (ItemUnusedAbilities(targetItem) > 0) then
                    if ((GetItemCharges(sourceItem) == 0 and GetItemCharges(targetItem) == 0) or (GetItemCharges(sourceItem) > 0 and GetItemCharges(targetItem) > 0)) then
                        call BlzItemAddAbility(targetItem, abilityId)
                        call BlzItemRemoveAbility(sourceItem, abilityId)
                        call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, 6.0, Format(GetLocalizedString("TRANSFERRED_ABILITY_X")).s(GetObjectName(abilityId)).result())
                    else
                        call SimError(GetOwningPlayer(caster), GetLocalizedString("ITEMS_PERISHABLE_OR_PERMANENT"))
                    endif
                else
                    call SimError(GetOwningPlayer(caster), GetLocalizedString("COMBINE_ERROR_NO_FREE_TARGET"))
                endif
            else
                call SimError(GetOwningPlayer(caster), Format(GetLocalizedString("COMBINE_ERROR_NO_ABILITY_SOURCE")).i(abilityIndex + 1).result())
            endif
        else
            call SimError(GetOwningPlayer(caster), Format(GetLocalizedString("COMBINE_ERROR_MAX_LEVEL")).i(maxLevel).i(GetItemLevel(sourceItem)).result())
        endif
    else
        call SimError(GetOwningPlayer(caster), GetLocalizedString("COMBINE_ERROR_OWNER"))
    endif
endfunction

private function TransferItemAbility takes unit caster, item targetItem, integer maxLevel returns nothing
    local item sourceItem = LoadItemHandle(h, GetHandleId(caster), 0)
    local integer abilityIndex = LoadInteger(h, GetHandleId(caster), 1)
    if (sourceItem != null) then
        call TransferItemAbilityEx(caster, sourceItem, abilityIndex, targetItem, maxLevel)
        set sourceItem = null
    else
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_MARKED_SOURCE_ITEM"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local unit caster = GetTriggerUnit()
    if (abilityId == ABILITY_ID_INSPECT) then
        call InspectItem(GetOwningPlayer(caster), GetSpellTargetItem())
    elseif (abilityId == ABILITY_ID_MARK_1) then
        call MarkItem(caster, GetSpellTargetItem(), 0)
    elseif (abilityId == ABILITY_ID_MARK_2) then
        call MarkItem(caster, GetSpellTargetItem(), 1)
    elseif (abilityId == ABILITY_ID_MARK_3) then
        call MarkItem(caster, GetSpellTargetItem(), 2)
    elseif (abilityId == ABILITY_ID_MARK_4) then
        call MarkItem(caster, GetSpellTargetItem(), 3)
    elseif (abilityId == ABILITY_ID_TRANSFER) then
        call TransferItemAbility(caster, GetSpellTargetItem(), GetMaxTransferItemLevel(caster))
    endif
    set caster = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
