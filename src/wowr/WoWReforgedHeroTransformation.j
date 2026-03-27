library WoWReforgedHeroTransformation initializer Init requires WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedSkillMenu, WoWReforgedCommandButtons, WoWReforgedMounts

globals
    private trigger array callbackTriggersTransform
    private integer callbackTriggersTransformCounter = 0
    
    private unit triggerHero = null
    private integer triggerOriginalUnitTypeId = 0
endglobals

function TriggerRegisterHeroTransform takes trigger whichTrigger returns nothing
    local integer index = callbackTriggersTransformCounter
    set callbackTriggersTransform[index] = whichTrigger
    set callbackTriggersTransformCounter = index + 1
endfunction

function GetTriggerTransformedHero takes nothing returns unit
    return triggerHero
endfunction

function GetTriggerTransformOriginalUnitTypeId takes nothing returns integer
    return triggerOriginalUnitTypeId
endfunction

private function ExecuteHeroTransformCallbacks takes unit hero, integer originalUnitTypeId returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackTriggersTransformCounter)
        if (IsTriggerEnabled(callbackTriggersTransform[i])) then
            set triggerHero = hero
            set triggerOriginalUnitTypeId = originalUnitTypeId
            call ConditionalTriggerExecute(callbackTriggersTransform[i])
        endif
        set i = i + 1
    endloop
endfunction

function ReplaceHero takes unit hero, integer newUnitId, integer unitStateMethod, boolean keepAttributes, boolean keepAttributesPerLevel returns unit
    local integer sourceHandleId = GetHandleId(hero)
    local integer targetHandleId = 0
    local player owner = GetOwningPlayer(hero)
    local boolean isHero1 = GetPlayerHero1(owner) == hero
    local boolean isHero2 = GetPlayerHero2(owner) == hero
    local boolean isHero3 = GetPlayerHero3(owner) == hero
    local integer primaryAttribute = BlzGetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE)
    local integer str = GetHeroStr(hero, false)
    local integer agi = GetHeroAgi(hero, false)
    local integer int = GetHeroInt(hero, false)
    local real strPerLevel = BlzGetUnitRealField(hero, UNIT_RF_STRENGTH_PER_LEVEL)
    local real agiPerLevel = BlzGetUnitRealField(hero, UNIT_RF_AGILITY_PER_LEVEL)
    local real intPerLevel = BlzGetUnitRealField(hero, UNIT_RF_INTELLIGENCE_PER_LEVEL)
    local string properName = GetHeroProperName(hero)
    local boolean attackEnabled0 = BlzGetUnitWeaponBooleanField(hero, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0)
    local integer attackType0 = BlzGetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
    local boolean attackEnabled1 = BlzGetUnitWeaponBooleanField(hero, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1)
    local integer attackType1 = BlzGetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1)
    local integer defenseType = BlzGetUnitIntegerField(hero, UNIT_IF_DEFENSE_TYPE)
    local unit mount = MountGet(hero)
    local unit result = null
    
    call TransferSkillMenu(sourceHandleId, 0, null)
    call CopyHeroLevelGainData(sourceHandleId, 0)
    call CopyUnitAttributeData(udg_AttributeAttributePoints, sourceHandleId, 0)
    call CopyUnitAttributeData(udg_AttributeSkillPoints, sourceHandleId, 0)

    call DisableTrigger(WoWReforgedAttributes_levelUpTrigger)
    set result = ReplaceUnitBJ(hero, newUnitId, unitStateMethod)
    call AddCommandButtonsForced(result)
    call EnableTrigger(WoWReforgedAttributes_levelUpTrigger)
    
    set targetHandleId = GetHandleId(result)
    call TransferSkillMenu(0, targetHandleId, result)
    call CopyHeroLevelGainData(0, targetHandleId)
    call CopyUnitAttributeData(udg_AttributeAttributePoints, 0, targetHandleId)
    call CopyUnitAttributeData(udg_AttributeSkillPoints, 0, targetHandleId)
    
    if (mount != null) then
        call MountAssign(result, mount)
    endif
    
    call ModifyHeroSkillPoints(result, bj_MODIFYMETHOD_SET, R2I(GetUnitAttribute(result, udg_AttributeSkillPoints)))
    
    if (keepAttributes) then
        call SetHeroStr(result, str, true)
        call SetHeroAgi(result, agi, true)
        call SetHeroInt(result, int, true)
    endif
    
    if (keepAttributesPerLevel) then
        call BlzSetUnitRealField(result, UNIT_RF_STRENGTH_PER_LEVEL, strPerLevel)
        call BlzSetUnitRealField(result, UNIT_RF_AGILITY_PER_LEVEL, agiPerLevel)
        call BlzSetUnitRealField(result, UNIT_RF_INTELLIGENCE_PER_LEVEL, intPerLevel)
    endif
    
    call BlzSetUnitIntegerField(result, UNIT_IF_PRIMARY_ATTRIBUTE, primaryAttribute)
    call BlzSetHeroProperName(result, properName)
    
    if (attackEnabled0) then
        call BlzSetUnitWeaponIntegerField(result, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, attackType0)
    endif
    if (attackEnabled1) then
        call BlzSetUnitWeaponIntegerField(result, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, attackType1)
    endif

    call BlzSetUnitIntegerField(result, UNIT_IF_DEFENSE_TYPE, defenseType)
    
    if (isHero1) then
        call SetPlayerHero1(owner, result)
    endif
    
    if (isHero2) then
        call SetPlayerHero2(owner, result)
    endif
    
    if (isHero3) then
        call SetPlayerHero3(owner, result)
    endif
    
    call UpdateMount(result)
    
    return result
endfunction

function ReplaceHeroForTransformation takes unit hero, integer unitTypeId returns unit
    local integer sourceHandleId = GetHandleId(hero)
    local force selectedForce = GetSelectedForce(hero)
    local integer orignalUnitTypeId = GetUnitTypeId(hero)
    local unit replacedUnit = ReplaceHero(hero, unitTypeId, bj_UNIT_STATE_METHOD_RELATIVE, true, false)
    if (IsPlayerInForce(GetLocalPlayer(), selectedForce)) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call SelectUnit(replacedUnit, true)
    endif
    //call ResetHeroLearnedSkills(sourceHandleId)
    call ExecuteHeroTransformCallbacks(replacedUnit, orignalUnitTypeId)
    call ForceClear(selectedForce)
    call DestroyForce(selectedForce)
    set selectedForce = null
    return replacedUnit
endfunction

struct HeroTransformationItemType
    integer id
    integer unitTypeId
    string animProperties = "" // alternate
    
    public method matchesUnit takes unit whichUnit returns boolean
        return unitTypeId == GetUnitTypeId(whichUnit)
    endmethod
endstruct

globals
    private trigger pickupTrigger = CreateTrigger()
    private trigger dropTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
    private HeroTransformationItemType array types
    private integer typesCounter = 0
    
    private constant integer MAX_HEROES = 3
    private integer array playerHeroOriginalUnitTypeId
endglobals

function GetMaxHeroTransformationTypes takes nothing returns integer
    return typesCounter
endfunction

function GetHeroTransformationType takes integer index returns HeroTransformationItemType
    return types[index]
endfunction

function AddHeroTransformationItemTypeIdEx takes integer id, integer unitTypeId returns integer
    local integer index = typesCounter
    local HeroTransformationItemType t = HeroTransformationItemType.create()
    set t.id = id
    set t.unitTypeId = unitTypeId
    set types[index] = t
    set typesCounter = typesCounter + 1
    return index
endfunction

function AddHeroTransformationItemTypeId takes nothing returns integer
    return AddHeroTransformationItemTypeIdEx(udg_TmpItemTypeId, udg_TmpUnitType)
endfunction

function AddHeroTransformationAbilityId takes nothing returns integer
    return AddHeroTransformationItemTypeIdEx(udg_TmpAbilityCode, udg_TmpUnitType)
endfunction

function SetHeroTransformationAnimProperties takes integer index, string animProperties returns nothing
    set types[index].animProperties = animProperties
endfunction

function SetHeroOriginalUnitType takes player owner, integer heroIndex, integer unitTypeId returns nothing
    set playerHeroOriginalUnitTypeId[Index2D(GetPlayerId(owner), 0, MAX_HEROES)] = unitTypeId
endfunction

function GetHeroOriginalUnitType takes player owner, integer heroIndex returns integer
    return playerHeroOriginalUnitTypeId[Index2D(GetPlayerId(owner), 0, MAX_HEROES)]
endfunction

function IsOriginalUnitTypeCustomizableAttributesHero takes unit hero returns boolean
    local integer heroIndex = GetPlayerHeroIndex(GetOwningPlayer(hero), hero)
    return heroIndex != -1 and GetHeroOriginalUnitType(GetOwningPlayer(hero), heroIndex) == CUSTOMIZABLE_HERO
endfunction

function IsHeroTransformed takes unit hero returns boolean
    local integer heroIndex = GetPlayerHeroIndex(GetOwningPlayer(hero), hero)
    return heroIndex != -1 and GetHeroOriginalUnitType(GetOwningPlayer(hero), heroIndex) != 0
endfunction

function CanUseCustomizableAttributes takes unit whichUnit returns boolean
    return GetUnitTypeId(whichUnit) == CUSTOMIZABLE_HERO or IsOriginalUnitTypeCustomizableAttributesHero(whichUnit)
endfunction

private function FindMatchingType takes integer id returns HeroTransformationItemType
    local integer i = 0
    loop
        exitwhen (i >= typesCounter)
        if (HeroTransformationItemType(types[i]).id == id) then
            return HeroTransformationItemType(types[i])
        endif
        set i = i + 1
    endloop
    return 0
endfunction

private function TransformForId takes unit hero, integer id returns boolean
    local player owner = GetOwningPlayer(hero)
    local integer heroIndex = GetPlayerHeroIndex(owner, hero)
    local HeroTransformationItemType matchingType = FindMatchingType(id)
    local boolean result = false
    local unit replaced = null
    if (matchingType != 0 and heroIndex != -1) then
        call DisableTrigger(pickupTrigger)
        if (GetHeroOriginalUnitType(owner, heroIndex) == 0) then
            //call BJDebugMsg("Hero original unit type: " + GetObjectName(GetUnitTypeId(hero)))
            call SetHeroOriginalUnitType(owner, heroIndex, GetUnitTypeId(hero))
        endif
        set replaced = ReplaceHeroForTransformation(hero, matchingType.unitTypeId)
        call RefreshBackpackForPlayer(owner)
        call RecreateAllEquipmentBags(owner)
        if (StringLength(matchingType.animProperties) > 0) then
            call AddUnitAnimationProperties(replaced, matchingType.animProperties, true)
        endif
        call EnableTrigger(pickupTrigger)
        set result = true
    endif
    set owner = null
    return result
endfunction

private function TransformByHeroInventory takes unit hero returns nothing
    local item slotItem = null
    local integer i = 0
    loop
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem != null and TransformForId(hero, GetItemTypeId(slotItem))) then
            call BJDebugMsg("Still transforming because of item " + GetItemName(slotItem) + " in inventory.")
            set slotItem = null
            exitwhen (true)
        endif
        set slotItem = null
        set i = i + 1
        exitwhen (i == bj_MAX_INVENTORY)
    endloop
endfunction

function TransformHeroBack takes unit hero returns unit
    local player owner = GetOwningPlayer(hero)
    local integer heroIndex = GetPlayerHeroIndex(owner, hero)
    local integer i = 0
    if (heroIndex != -1) then
        loop
            exitwhen (i >= typesCounter)
            //call BJDebugMsg("Matching transform type for ability " + GetObjectName(GetSpellAbilityId()) + ": " + I2S(matchingType) + " and hero Index " + I2S(heroIndex))
            if (HeroTransformationItemType(types[i]).matchesUnit(hero)) then
                call ReplaceHeroForTransformation(hero, GetHeroOriginalUnitType(owner, heroIndex))
                call SetHeroOriginalUnitType(owner, heroIndex, 0) // allows transforming again
                call RefreshBackpackForPlayer(owner)
                call RecreateAllEquipmentBags(owner)
                call TransformByHeroInventory(GetLastReplacedUnitBJ())
                
                return GetLastReplacedUnitBJ()
            endif
            set i = i + 1
        endloop
    endif
    set owner = null
    return hero
endfunction

private function TriggerConditionPickup takes nothing returns boolean
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer heroIndex = GetPlayerHeroIndex(owner, triggerUnit)
    local boolean result = IsUnitType(triggerUnit, UNIT_TYPE_HERO) and heroIndex != -1 and GetHeroOriginalUnitType(owner, heroIndex) == 0
    set triggerUnit = null
    set owner = null
    return result
endfunction

private function TriggerActionPickup takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local player owner = GetOwningPlayer(hero)
    local item whichItem = GetManipulatedItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    // wait for picking the item up into the inventory
    call TriggerSleepAction(0.0)
    if (UnitHasItem(hero, whichItem)) then
        call TransformForId(hero, itemTypeId)
    endif
    set hero = null
    set owner = null
    set whichItem = null
endfunction

private function TriggerConditionDrop takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerHeroIndex(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit()) != -1
endfunction

private function TriggerActionDrop takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer heroIndex = GetPlayerHeroIndex(owner, triggerUnit)
    local HeroTransformationItemType matchingType = FindMatchingType(GetItemTypeId(GetManipulatedItem()))
    if (matchingType != 0 and heroIndex != -1 and matchingType.matchesUnit(triggerUnit)) then
        // wait for dropping the item from the inventory
        call TriggerSleepAction(0.0)
        // refresh values
        set heroIndex = GetPlayerHeroIndex(owner, triggerUnit)
        if (heroIndex != -1) then
            call DisableTrigger(dropTrigger)
            call TransformHeroBack(triggerUnit)
            call EnableTrigger(dropTrigger)
        endif
    endif
    set triggerUnit = null
    set owner = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerHeroIndex(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit()) != -1
endfunction

private function TriggerActionCast takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer heroIndex = GetPlayerHeroIndex(owner, triggerUnit)
    local integer abilityId = GetSpellAbilityId()
    local HeroTransformationItemType matchingType = FindMatchingType(abilityId)
    local unit u = null
    //call BJDebugMsg("Matching transform type for ability " + GetObjectName(GetSpellAbilityId()) + ": " + I2S(matchingType) + " and hero Index " + I2S(heroIndex))
    if (matchingType != 0 and heroIndex != -1) then
        //if (GetHeroOriginalUnitType(owner, heroIndex) == 0) then
            //call TransformForId(triggerUnit, abilityId)
        // restore
        if (matchingType.matchesUnit(triggerUnit)) then
            call TransformHeroBack(triggerUnit)
        // transform
        else
            call TransformForId(triggerUnit, abilityId)
        endif
    endif
    set triggerUnit = null
    set owner = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupTrigger, Condition(function TriggerConditionPickup))
    call TriggerAddAction(pickupTrigger, function TriggerActionPickup)
    
    call TriggerRegisterAnyUnitEventBJ(dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropTrigger, Condition(function TriggerConditionDrop))
    call TriggerAddAction(dropTrigger, function TriggerActionDrop)
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT) // After consuming the mana costs.
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
endfunction

endlibrary
