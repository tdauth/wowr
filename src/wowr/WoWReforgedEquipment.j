library WoWReforgedEquipment initializer Init requires SimError, Villager255, WoWReforgedUtils, WoWReforgedEquipmentBags, WoWReforgedBackpacks, WoWReforgedHeroTransformation, WoWReforgedSaveCodeObjects

globals
    public constant integer CATEGORY_HEAD = 0
    public constant integer CATEGORY_LEFT_HAND = 1
    public constant integer CATEGORY_RIGHT_HAND = 2
    public constant integer CATEGORY_BODY = 3
    public constant integer CATEGORY_FOOT = 4
    public constant integer CATEGORY_MAX = 5
    
    public constant integer CATEGORY_TYPE_ONE_HANDED = 0
    public constant integer CATEGORY_TYPE_TWO_HANDED = 1
    public constant integer CATEGORY_TYPE_RANGE = 2
    public constant integer CATEGORY_TYPE_MAX = 3

    private hashtable h = InitHashtable()
    private hashtable h2 = InitHashtable()

    private trigger pickupTrigger = CreateTrigger()
    private trigger dropTrigger = CreateTrigger()
    private trigger attackTrigger = CreateTrigger()
    
    private integer array equipmentItemTypeId
    private string array equipmentItemTypeCategoryName
    private integer array equipmentItemTypeCategory
    private boolean array equipmentItemTypeCategoryType
    private integer array equipmentItemTypeAnimation
    private integer equipmentTypesCounter = 1 // start with 1 so 0 means none
endglobals

function GetEquipmentItemTypeId takes integer index returns integer
    return equipmentItemTypeId[index]
endfunction

function GetEquipmentItemTypeCategoryName takes integer index returns string
    return equipmentItemTypeCategoryName[index]
endfunction

function GetEquipmentItemTypeCategory takes integer index returns integer
    return equipmentItemTypeCategory[index]
endfunction

function GetEquipmentItemTypeCategoryType takes integer index, integer category returns boolean
    local integer i = Index2D(index, category, CATEGORY_TYPE_MAX)
    return equipmentItemTypeCategoryType[i]
endfunction

function SetEquipmentItemTypeCategoryType takes integer index, integer category, boolean value returns nothing
    local integer i = Index2D(index, category, CATEGORY_TYPE_MAX)
    set equipmentItemTypeCategoryType[i] = value
endfunction

function GetEquipmentTypeAnimation takes integer index returns integer
    return equipmentItemTypeAnimation[index] 
endfunction

function SetEquipmentTypeAnimation takes integer index, integer animation returns nothing
    set equipmentItemTypeAnimation[index] = animation
endfunction

function AddEquipmentItemType takes integer itemTypeId, string categoryName, integer category, integer animation returns integer
    set equipmentItemTypeId[equipmentTypesCounter] = itemTypeId
    set equipmentItemTypeCategoryName[equipmentTypesCounter]= categoryName
    set equipmentItemTypeCategory[equipmentTypesCounter] = category
    set equipmentItemTypeAnimation[equipmentTypesCounter] = animation
    set equipmentTypesCounter = equipmentTypesCounter + 1
    return equipmentTypesCounter
endfunction

// VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON
function AddEquipmentItemTypeWoWReforged takes nothing returns integer
    local integer index = AddEquipmentItemType(udg_TmpItemTypeId, udg_TmpString, udg_TmpInteger, udg_TmpInteger2)
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON
    return index
endfunction

function EquipmentCategoryTwoHanded takes nothing returns nothing
    call SetEquipmentItemTypeCategoryType(equipmentTypesCounter, CATEGORY_TYPE_TWO_HANDED, true)
endfunction

function EquipmentCategoryRange takes nothing returns nothing
    call SetEquipmentItemTypeCategoryType(equipmentTypesCounter, CATEGORY_TYPE_RANGE, true)
endfunction

function EquipmentCategoryHead takes nothing returns nothing
    set udg_TmpInteger = CATEGORY_HEAD
endfunction

function EquipmentCategoryLeftHand takes nothing returns nothing
    set udg_TmpInteger = CATEGORY_LEFT_HAND
endfunction

function EquipmentCategoryRightHand takes nothing returns nothing
    set udg_TmpInteger = CATEGORY_RIGHT_HAND
endfunction

function EquipmentCategoryBody takes nothing returns nothing
    set udg_TmpInteger = CATEGORY_BODY
endfunction

function EquipmentCategoryFoot takes nothing returns nothing
    set udg_TmpInteger = CATEGORY_FOOT
endfunction

function EquipmentAnimationShield takes nothing returns nothing
     set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_SHIELD
endfunction

function EquipmentAnimationNoWeapon takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON
endfunction

function EquipmentAnimationLeftHandWeapon takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_LEFT_HAND_WEAPON
endfunction

function EquipmentAnimationTwoHandHammer takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_TWO_HAND_HAMMER
endfunction

function EquipmentAnimationTwoWeapons takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_TWO_WEAPONS
endfunction

function EquipmentAnimationBow takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_BOW
endfunction

function EquipmentAnimationMinigun takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_MINIGUN
endfunction

function EquipmentAnimationTwoHand takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_TWO_HAND
endfunction

function EquipmentAnimationGun takes nothing returns nothing
    set udg_TmpInteger2 = VILLAGER_255_ANIMATION_ATTACK_SHOOT_GUN
endfunction

function GetMaxEquipmentItemTypes takes nothing returns integer
    return equipmentTypesCounter
endfunction

function GetEquipmentItemTypeByItemTypeId takes integer itemTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i >= equipmentTypesCounter)
        if (equipmentItemTypeId[i] == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return 0
endfunction

private function SetUnitEquipmentType takes unit hero, integer c, integer index returns nothing
    call SaveInteger(h, GetHandleId(hero), c, index)
endfunction

private function SetUnitEquipmentTypeItem takes unit hero, integer c, item whichItem returns nothing
    call SaveItemHandle(h2, GetHandleId(hero), c, whichItem)
endfunction

function GetUnitEquipmentType takes unit hero, integer c returns integer
    return LoadInteger(h, GetHandleId(hero), c)
endfunction

function GetUnitEquipmentTypeItem takes unit hero, integer c returns item
    return LoadItemHandle(h2, GetHandleId(hero), c)
endfunction

function GetUnitEquipmentTypeByHandleId takes integer handleId, integer c returns integer
    return LoadInteger(h, handleId, c)
endfunction

function GetUnitEquipmentTypeItemByHandleId takes integer handleId, integer c returns item
    return LoadItemHandle(h2, handleId, c)
endfunction

function DropEquipment takes unit hero, integer c returns nothing
    local integer index =  GetUnitEquipmentType(hero, c)
    if (index != 0) then
        //call BJDebugMsg("Drop item " + GetItemName(GetUnitEquipmentTypeItem(hero, c)))
        call DisableTrigger(dropTrigger)
        call UnitDropItemPoint(hero, GetUnitEquipmentTypeItem(hero, c), GetUnitX(hero), GetUnitY(hero))
        call EnableTrigger(dropTrigger)
        call SetUnitEquipmentType(hero, c, 0)
        call SetUnitEquipmentTypeItem(hero, c, null)
    else
        //call BJDebugMsg("Item in category " + I2S(c) + " is null")
    endif        
endfunction

function ReplaceHeroForEquipment takes unit hero, integer unitTypeId returns unit
    local integer i = 0
    local integer oldHandleId = GetHandleId(hero)
    local player owner = GetOwningPlayer(hero)
    local unit replaced = null
    call DisableTrigger(pickupTrigger)
    call DisableTrigger(dropTrigger)
    set replaced = ReplaceHeroForTransformation(hero, unitTypeId)
    call RefreshBackpackForPlayer(owner)
    call RecreateAllEquipmentBags(owner)
    set i = 0
    loop
        exitwhen (i == CATEGORY_MAX)
        call SetUnitEquipmentType(replaced, i, GetUnitEquipmentTypeByHandleId(oldHandleId, i))
        call SetUnitEquipmentTypeItem(replaced, i, GetUnitEquipmentTypeItemByHandleId(oldHandleId, i))
        set i = i + 1
    endloop
    if (oldHandleId != GetHandleId(replaced)) then
        call FlushChildHashtable(h, oldHandleId)
        call FlushChildHashtable(h2, oldHandleId)
    endif
    call EnableTrigger(pickupTrigger)
    call EnableTrigger(dropTrigger)
    set owner = null
    return replaced
endfunction

private function UpdateEquipmentFromInventory takes unit hero returns nothing
    local item slotItem = null
    local integer c = 0
    local integer index = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem != null) then
             set index = GetEquipmentItemTypeByItemTypeId(GetItemTypeId(slotItem))
             if (index != 0) then
                set c = GetEquipmentItemTypeCategory(index)
                call SetUnitEquipmentType(hero, c, index)
                call SetUnitEquipmentTypeItem(hero, c, slotItem)
             endif
        endif
        set slotItem = null
        set i = i + 1
    endloop
endfunction

private function TriggerConditionIsCustomizableAttriburesHero takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
    return unitTypeId == CUSTOMIZABLE_HERO or unitTypeId == ITEM_VALUES_DUMMY_HERO
endfunction

private function TriggerActionPickupItem takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local item whichItem = GetManipulatedItem()
    local integer unitTypeId = GetUnitTypeId(hero)
    local integer c = 0
    local integer indexOld = 0
    local integer index = GetEquipmentItemTypeByItemTypeId(GetItemTypeId(whichItem))
    if (index != 0) then
        set c = GetEquipmentItemTypeCategory(index)
        if (GetEquipmentItemTypeCategoryType(index, CATEGORY_TYPE_TWO_HANDED)) then
            //call BJDebugMsg("Drop all weapons.")
            call DropEquipment(hero, CATEGORY_LEFT_HAND)
            call DropEquipment(hero, CATEGORY_RIGHT_HAND)
        else
            // drop equipped two hand weapons if necessary
            if (GetUnitEquipmentType(hero, CATEGORY_LEFT_HAND) != 0 and GetEquipmentItemTypeCategoryType(GetUnitEquipmentType(hero, CATEGORY_LEFT_HAND), CATEGORY_TYPE_TWO_HANDED)) then
                call DropEquipment(hero, CATEGORY_LEFT_HAND)
            endif
            
            if (GetUnitEquipmentType(hero, CATEGORY_RIGHT_HAND) != 0 and GetEquipmentItemTypeCategoryType(GetUnitEquipmentType(hero, CATEGORY_RIGHT_HAND), CATEGORY_TYPE_TWO_HANDED)) then
                call DropEquipment(hero, CATEGORY_RIGHT_HAND)
            endif
            
            //call BJDebugMsg("Drop current weapon from category " + I2S(c))
            // always drop the replaced equipment
            call DropEquipment(hero, c)
        endif
        
        call SetUnitEquipmentType(hero, c, index)
        call SetUnitEquipmentTypeItem(hero, c, whichItem)
        
        //call BJDebugMsg("Set equipment " + I2S(c) + " to " + GetItemName(whichItem))
        
        if (GetEquipmentItemTypeCategoryType(index, CATEGORY_TYPE_RANGE)) then
            call GiveHeroRangeAttack(hero, 0)
        else
            call GiveHeroMeleeAttack(hero, 0)
        endif
        
        //call UpdateEquipmentFromInventory(hero)
    endif
    set whichItem = null
    set hero = null
endfunction

private function TriggerActionDropItem takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local integer index = GetEquipmentItemTypeByItemTypeId(GetItemTypeId(GetManipulatedItem()))
    local integer c = 0
    if (index != 0) then
        set c = GetEquipmentItemTypeCategory(index)
        //call BJDebugMsg("Drop " + I2S(c) + " with item " + GetItemName(GetUnitEquipmentTypeItem(hero, c)))
        call SetUnitEquipmentType(hero, c, 0)
        call SetUnitEquipmentTypeItem(hero, c, null)
        //call UpdateEquipmentFromInventory(hero)
    endif
    set hero = null
endfunction

private function TriggerConditionAttack takes nothing returns boolean
    return BlzGetUnitSkin(GetAttacker()) == CUSTOMIZABLE_HERO
endfunction

private function TriggerActionAttack takes nothing returns nothing
    local unit hero = GetAttacker()
    local integer leftHandIndex = GetUnitEquipmentType(hero, CATEGORY_LEFT_HAND)
    local integer rightHandIndex = GetUnitEquipmentType(hero, CATEGORY_RIGHT_HAND)
    if (rightHandIndex != 0) then
        if (leftHandIndex != 0 and GetEquipmentTypeAnimation(rightHandIndex) == VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON) then
            //call BJDebugMsg("Left hand weapon even with right.")
            call SetVillager255Animation(hero, GetEquipmentTypeAnimation(leftHandIndex))
        else
            //call BJDebugMsg("Right hand weapon.")
            call SetVillager255Animation(hero, GetEquipmentTypeAnimation(rightHandIndex))
        endif
    elseif (leftHandIndex != 0) then
        //call BJDebugMsg("Left hand weapon.")
        //call BJDebugMsg("Left hand weapon index " + I2S(leftHandIndex))
        //call BJDebugMsg("Left hand weapon animation index " + I2S(GetEquipmentTypeAnimation(leftHandIndex)))
        call SetVillager255Animation(hero, GetEquipmentTypeAnimation(leftHandIndex))
    else
        call SetVillager255Animation(hero, VILLAGER_255_ANIMATION_ATTACK_NO_WEAPON)
    endif
    set hero = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupTrigger, Condition(function TriggerConditionIsCustomizableAttriburesHero))
    call TriggerAddAction(pickupTrigger, function TriggerActionPickupItem)
    
    call TriggerRegisterAnyUnitEventBJ(dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropTrigger, Condition(function TriggerConditionIsCustomizableAttriburesHero))
    call TriggerAddAction(dropTrigger, function TriggerActionDropItem)
    
    call TriggerRegisterAnyUnitEventBJ(attackTrigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(attackTrigger, Condition(function TriggerConditionAttack))
    call TriggerAddAction(attackTrigger, function TriggerActionAttack)
endfunction

function AddSaveObjectItemTypesFromEquipment takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxEquipmentItemTypes()
    loop
        exitwhen (i == max)
        if (GetEquipmentItemTypeId(i) != 0) then
            set udg_TmpItemTypeId = GetEquipmentItemTypeId(i)
            call AddSaveObjectItemType()
        endif
        set i = i + 1
    endloop
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    local integer handleId = GetHandleId(whichUnit)
    call FlushChildHashtable(h, handleId)
    call FlushChildHashtable(h2, handleId)
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
