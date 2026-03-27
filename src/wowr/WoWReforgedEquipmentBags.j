library WoWReforgedEquipmentBags requires SimError, WoWReforgedUtils, WoWReforgedAbilityFields, WoWReforgedSkillMenu, WoWReforgedCommandButtons

globals
    constant integer MAX_EQUIPMENT_BAGS = 3
endglobals

function GetMaxEquipmentBags takes player whichPlayer returns integer
    local integer heroLevel = GetHighestHeroLevel(whichPlayer)
    if (heroLevel >= HERO_JOURNEY_EQUIPMENT_BAG_1) then
        if (heroLevel >= HERO_JOURNEY_EQUIPMENT_BAG_2) then
            if (heroLevel >= HERO_JOURNEY_EQUIPMENT_BAG_3) then
                return MAX_EQUIPMENT_BAGS
            endif
            
            return 2
        endif
        
        return 1
    endif
    
    return 0
endfunction

function GetEquipmentBagsCount takes player whichPlayer returns integer
    return BlzGroupGetSize(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

function EquipmentBagAddAbilities takes unit bag, item whichItem returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(bag))
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer abilityId = 0
    local unit hero = udg_Hero[playerId]
    local integer i = 1
    if (hero != null) then
        loop
            exitwhen (i > MAX_ITEM_ABILITIES or abilityId == 0)
            set abilityId = BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, i))
            //set abilityId = GetAbilityId(itemTypeId, i)

            if (abilityId != 0) then
                if (not GetAbilityIdUnusable(abilityId) and (GetAbilityIdStack(abilityId) or GetUnitAbilityLevel(hero, abilityId) <= 0)) then
                    call UnitAddAbility(hero, abilityId)
                    call BlzUnitHideAbility(hero, abilityId, not GetAbilityIdShow(abilityId))
                endif
            endif
            set i = i + 1
        endloop
    endif
    set hero = null
endfunction

private function ItemHasAbilityId takes item whichItem, integer abilityId returns boolean
    local integer a = 0
    local integer i = 0
    loop
        exitwhen (i > MAX_ITEM_ABILITIES or a == 0)
        set a = BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, i))

        if (a == abilityId) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

private function HeroHasItemsWithAbilityId takes unit hero, integer abilityId returns boolean
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null and ItemHasAbilityId(whichItem, abilityId)) then
            return true
        endif
        set whichItem = null
        set i = i + 1
    endloop
    return false
endfunction

function EquipmentBagRemoveAbilities takes unit bag, item whichItem returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(bag))
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer abilityId = 0
    local boolean stacking = false
    local unit hero = udg_Hero[playerId]
    local integer i = 1
    if (hero != null) then
        loop
            exitwhen (i > MAX_ITEM_ABILITIES or abilityId == 0)
            set abilityId = BlzGetAbilityId(BlzGetItemAbilityByIndex(whichItem, i))
            //set abilityId = GetAbilityId(itemTypeId, i)
            //set stacking = GetAbilityIdStacking(itemTypeId, abilityId)

            if (abilityId != 0) then
                if (not GetAbilityIdUnusable(abilityId) and (GetAbilityIdStack(abilityId) or not HeroHasItemsWithAbilityId(hero, abilityId))) then
                    call UnitRemoveAbility(hero, abilityId)
                endif
            endif
            set i = i + 1
        endloop
    endif
    set hero = null
endfunction

function RemoveEquipmentBags takes player whichPlayer returns nothing
    local integer max = GetEquipmentBagsCount(whichPlayer)
    local unit equipmentBag = null
    local integer i = 0
    loop
        exitwhen (i >= max)
        set equipmentBag = BlzGroupUnitAt(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], i)
        call DropAllItemsFromHero(equipmentBag)
        call DisableItemCraftingUnit(equipmentBag)
        call RemoveUnit(equipmentBag)
        set equipmentBag = null
        set i = i + 1
    endloop
    call GroupClear(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

function UpdateEquipmentBagHeroLevels takes player whichPlayer returns nothing
    local integer highHeroLevel = GetHighestHeroLevel(whichPlayer)
    local integer max = GetEquipmentBagsCount(whichPlayer)
    local unit equipmentBag = null
    local integer i = 0
    loop
        exitwhen (i >= max)
        set equipmentBag = BlzGroupUnitAt(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], i)
        call SuspendHeroXP(equipmentBag, false)
        if (GetHeroLevel(equipmentBag) < highHeroLevel) then
            call SetHeroLevel(equipmentBag, highHeroLevel, true)
        endif
        call SuspendHeroXP(equipmentBag, true)
        set equipmentBag = null
        set i = i + 1
    endloop
    //call BJDebugMsg("Update equipment bag hero levels to highest hero level " + I2S(highHeroLevel))
endfunction

private function CreateSingleEquipmentBag takes player whichPlayer, integer index, boolean addSkillMenu returns unit
    local integer playerId = GetPlayerId(whichPlayer)
    local unit equipmentBag = CreateUnit(whichPlayer, EQUIPMENT_BAG, GetUnitX(udg_Hero[playerId]), GetUnitY(udg_Hero[playerId]), bj_UNIT_FACING)
    local string equipmentBagName = Format(GetLocalizedString("EQUIPMENT_BAG_INDEX")).i(index).result()
    call SuspendHeroXP(equipmentBag, true)
    call GroupAddUnit(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], equipmentBag)
    call UnitRemoveAbility(equipmentBag, 'A02N')
    call UnitAddAbility(equipmentBag, 'AInv')
    call BlzSetUnitName(equipmentBag, equipmentBagName)
    call BlzSetHeroProperName(equipmentBag, equipmentBagName)
    if (addSkillMenu) then
        call AddSkillMenu(equipmentBag)
    endif
    call AddCommandButtonsForced(equipmentBag)
    return equipmentBag
endfunction

function CreateEquipmentBags takes player whichPlayer, integer equipmentBags returns nothing
    local integer max = GetMaxEquipmentBags(whichPlayer)
    local integer i = 0
    loop
        exitwhen (i >= max)
        call CreateSingleEquipmentBag(whichPlayer, GetEquipmentBagsCount(whichPlayer) + 1, true)
        set i = i + 1
    endloop
    call UpdateEquipmentBagHeroLevels(whichPlayer)
    call LinkItemCraftingGroupInventories(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

private function ForGroupRemoveUnit takes nothing returns nothing
    local unit u = GetEnumUnit()
    //call BJDebugMsg("Remove 1")
    call DropAllItemsFromHero(u)
    //call BJDebugMsg("Remove 2")
    call DisableItemCraftingUnit(u)
    //call BJDebugMsg("Remove 3")
    call RemoveUnit(u)
    //call BJDebugMsg("Remove 4")
    set u = null
endfunction

function RecreateEquipmentBags takes player whichPlayer, integer equipmentBags returns nothing
    local integer oldMax = GetEquipmentBagsCount(whichPlayer)
    local integer max = IMaxBJ(oldMax, equipmentBags)
    local unit equipmentBag = null
    local integer sourceHandleId = 0
    local group oldBags = CopyGroup(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    local group removingBags = CreateGroup()
    local integer i = 0
    set max = IMinBJ(max, GetMaxEquipmentBags(whichPlayer))
    loop
        exitwhen (i >= max)
        //call BJDebugMsg("Equipment bags old max " + I2S(oldMax) + " and max " + I2S(max) + " and i " + I2S(i))
        if (i < oldMax) then
            set equipmentBag = BlzGroupUnitAt(oldBags, i)
            //call BJDebugMsg("Adding bag with ID " + I2S(GetHandleId(equipmentBag)))
            call GroupAddUnit(removingBags, equipmentBag)
            set sourceHandleId = GetHandleId(equipmentBag)
        else
            set sourceHandleId = 0
        endif
        set equipmentBag = CreateSingleEquipmentBag(whichPlayer, i + 1, sourceHandleId == 0)
        if (sourceHandleId > 0) then
            call TransferSkillMenu(sourceHandleId, GetHandleId(equipmentBag), equipmentBag)
        endif
        set equipmentBag = null
        set i = i + 1
    endloop
    //call BJDebugMsg("Remove 1 old equipment bags with count " + I2S(CountUnitsInGroup(removingBags)))
    call GroupRemoveGroup(removingBags, udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    //call BJDebugMsg("Remove 2 old equipment bags with count " + I2S(CountUnitsInGroup(removingBags)))
    call ForGroup(removingBags, function ForGroupRemoveUnit)
    call GroupClear(removingBags)
    call DestroyGroup(removingBags)
    set removingBags = null
    call GroupClear(oldBags)
    call DestroyGroup(oldBags)
    set oldBags = null
    call UpdateEquipmentBagHeroLevels(whichPlayer)
    call LinkItemCraftingGroupInventories(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

function ResetEquipmentBags takes player whichPlayer returns nothing
    //call BJDebugMsg("Equipment bags size " + I2S(GetEquipmentBagsCount(whichPlayer)))
    call ForGroup(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], function ForGroupRemoveUnit)
    call GroupClear(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

function AddEquipmentBag takes player whichPlayer returns nothing
    local integer max = GetMaxEquipmentBags(whichPlayer)
    if (GetEquipmentBagsCount(whichPlayer) < max) then
        call CreateSingleEquipmentBag(whichPlayer, GetEquipmentBagsCount(whichPlayer) + 1, true)
        call UpdateEquipmentBagHeroLevels(whichPlayer)
        call LinkItemCraftingGroupInventories(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    else
        call SimError(whichPlayer, Format(GetLocalizedString("MAXIMUM_EQUIPMENT_BAGS")).i(max).result())
    endif
endfunction

function RecreateAllEquipmentBags takes player whichPlayer returns nothing
    local integer count = GetEquipmentBagsCount(whichPlayer)
    call RecreateEquipmentBags(whichPlayer, count)
endfunction

endlibrary
