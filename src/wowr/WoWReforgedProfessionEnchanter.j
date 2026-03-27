library WoWReforgedProfessionEnchanter initializer Init requires WoWReforgedAbilityFields, WoWReforgedEquipmentBags, WoWReforgedUtils

globals
    private hashtable EnchanterSystemHashTable = InitHashtable()
    private group EnchantedUnits = CreateGroup()

    constant integer ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS = 1
    constant integer ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS = 2
    constant integer ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS = 3

    constant integer ENCHANTER_ITEM_TYPE_ID_NOVICE = 'I07F'
    constant integer ENCHANTER_STAT_BONUS_NOVICE = 1
    constant integer ENCHANTER_DAMAGE_BONUS_NOVICE = 3
    constant integer ENCHANTER_HIT_POINTS_BONUS_NOVICE = 50
    constant integer ENCHANTER_ITEM_TYPE_ID_ADVANCED = 'I07H'
    constant integer ENCHANTER_STAT_BONUS_ADVANCED = 2
    constant integer ENCHANTER_DAMAGE_BONUS_ADVANCED = 5
    constant integer ENCHANTER_HIT_POINTS_BONUS_ADVANCED = 100
    constant integer ENCHANTER_ITEM_TYPE_ID_ADEPT = 'I07I'
    constant integer ENCHANTER_STAT_BONUS_ADEPT = 3
    constant integer ENCHANTER_DAMAGE_BONUS_ADEPT = 7
    constant integer ENCHANTER_HIT_POINTS_BONUS_ADEPT = 150
    constant integer ENCHANTER_ITEM_TYPE_ID_MASTER = 'I07J'
    constant integer ENCHANTER_STAT_BONUS_MASTER = 4
    constant integer ENCHANTER_DAMAGE_BONUS_MASTER = 9
    constant integer ENCHANTER_HIT_POINTS_BONUS_MASTER = 200
    constant integer ENCHANTER_ITEM_TYPE_ID_GRAND_MASTER = ITEM_GRAND_MASTER_ENCHANTING_FORMULA
    constant integer ENCHANTER_STAT_BONUS_GRAND_MASTER = 5
    constant integer ENCHANTER_DAMAGE_BONUS_GRAND_MASTER = 11
    constant integer ENCHANTER_HIT_POINTS_BONUS_GRAND_MASTER = 250
    constant integer ENCHANTER_ITEM_TYPE_ID_DOCTOR = ITEM_DOCTOR_ENCHANTING_FORMULA
    constant integer ENCHANTER_STAT_BONUS_DOCTOR = 6
    constant integer ENCHANTER_DAMAGE_BONUS_DOCTOR = 13
    constant integer ENCHANTER_HIT_POINTS_BONUS_DOCTOR = 300

    private trigger pickupItemTrigger = CreateTrigger()
    private trigger dropItemTrigger = CreateTrigger()
endglobals

function EnchanterSystemSaveBonus takes unit hero, integer bonusType, integer bonus returns nothing
    call SaveInteger(EnchanterSystemHashTable, GetHandleId(hero), bonusType, bonus)
endfunction

function EnchanterSystemLoadBonus takes unit hero, integer bonusType returns integer
    return LoadInteger(EnchanterSystemHashTable, GetHandleId(hero), bonusType)
endfunction

function EnchanterSystemSaveBonusReal takes unit hero, integer bonusType, real bonus returns nothing
    call SaveReal(EnchanterSystemHashTable, GetHandleId(hero), bonusType, bonus)
endfunction

function EnchanterSystemLoadBonusReal takes unit hero, integer bonusType returns real
    return LoadReal(EnchanterSystemHashTable, GetHandleId(hero), bonusType)
endfunction

function EnchanterAddItemBonusesEx takes unit hero, item whichItem, integer bonusHeroStatsAndDefense, real bonusDamage, real bonusHitPoints returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer abilityId = 0
    local ability whichAbility = null
    local integer i = 0
    loop
        exitwhen (i >= MAX_ITEM_ABILITIES)
        set whichAbility = BlzGetItemAbilityByIndex(whichItem, i)
        set abilityId = BlzGetAbilityId(whichAbility)
        if (abilityId != 0) then
            //call BJDebugMsg("Adding bonus to ability " + GetObjectName(abilityId) + " of item " + GetItemName(whichItem))
            call AddAbilityFieldBonuses(abilityId, whichAbility, 0, bonusHeroStatsAndDefense, bonusHeroStatsAndDefense, 0.0, bonusDamage, bonusHitPoints, bonusHitPoints, 0, 0.0, I2R(bonusHeroStatsAndDefense), bonusHeroStatsAndDefense, R2I(bonusHitPoints), R2I(bonusHitPoints), 0.0, 0, 0.0)
            // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
            call IncUnitAbilityLevel(hero, abilityId)
            call DecUnitAbilityLevel(hero, abilityId)
        endif
        set i = i + 1
    endloop
endfunction

function IsHeroEnchanted takes unit hero returns boolean
    return IsUnitInGroup(hero, EnchantedUnits)
endfunction

private function EnchanterSystemRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(EnchanterSystemHashTable, GetHandleId(whichUnit))
endfunction

hook RemoveUnit EnchanterSystemRemoveUnit

function EnchanterSetHeroBonus takes unit hero returns integer
    local item whichItem = null
    local integer oldEnchantingBonusHeroStatAndDefense = EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldEnchantingBonusDamage = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldEnchantingBonusHitPoints = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)
    local integer enchantingItemsCounter = 0
    local integer heroStatsAndDefenseBonus = 0
    local real damageBonus = 0
    local real hitPointsBonus = 0
    local integer heroStatsAndDefenseBonusDiff = 0
    local real damageBonusDiff = 0
    local real hitPointsBonusDiff = 0
    local integer itemTypeId = 0
    local integer factor = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null) then
            set itemTypeId = GetItemTypeId(whichItem)
            set factor = GetItemCharges(whichItem)
            if (itemTypeId == ENCHANTER_ITEM_TYPE_ID_NOVICE) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_NOVICE * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_NOVICE * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_NOVICE * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            elseif (itemTypeId == ENCHANTER_ITEM_TYPE_ID_ADVANCED) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_ADVANCED * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_ADVANCED * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_ADVANCED * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            elseif (itemTypeId == ENCHANTER_ITEM_TYPE_ID_ADEPT) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_ADEPT * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_ADEPT * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_ADEPT * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            elseif (itemTypeId == ENCHANTER_ITEM_TYPE_ID_MASTER) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_MASTER * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_MASTER * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_MASTER * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            elseif (itemTypeId == ENCHANTER_ITEM_TYPE_ID_GRAND_MASTER) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_GRAND_MASTER * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_GRAND_MASTER * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_GRAND_MASTER * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            elseif (itemTypeId == ENCHANTER_HIT_POINTS_BONUS_DOCTOR) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + ENCHANTER_STAT_BONUS_DOCTOR  * factor
                set damageBonus = damageBonus + ENCHANTER_DAMAGE_BONUS_DOCTOR * factor
                set hitPointsBonus = hitPointsBonus + ENCHANTER_HIT_POINTS_BONUS_DOCTOR * factor
                set enchantingItemsCounter = enchantingItemsCounter + 1
            endif
        endif
        set whichItem = null
        set i = i + 1
    endloop

    //call BJDebugMsg("Old Hero stats and defense bonus " + I2S(oldEnchantingBonusHeroStatAndDefense) + " and damage bonus " + R2S(oldEnchantingBonusDamage) + " and hit points bonus " + R2S(oldEnchantingBonusHitPoints))

    set heroStatsAndDefenseBonusDiff = heroStatsAndDefenseBonus - oldEnchantingBonusHeroStatAndDefense
    set damageBonusDiff = damageBonus - oldEnchantingBonusDamage
    set hitPointsBonusDiff = hitPointsBonus - oldEnchantingBonusHitPoints

    //call BJDebugMsg("Hero stats and defense bonus " + I2S(heroStatsAndDefenseBonusDiff) + " and damage bonus " + R2S(damageBonusDiff) + " and hit points bonus " + R2S(hitPointsBonusDiff))

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null) then
            call EnchanterAddItemBonusesEx(hero, whichItem, heroStatsAndDefenseBonusDiff, damageBonusDiff, hitPointsBonusDiff)
        endif
        set whichItem = null
        set i = i + 1
    endloop

    if (enchantingItemsCounter > 0) then
        call EnchanterSystemSaveBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS, heroStatsAndDefenseBonus)
        call EnchanterSystemSaveBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS, damageBonus)
        call EnchanterSystemSaveBonusReal(hero, ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS, hitPointsBonus)
        if (not IsUnitInGroup(hero, EnchantedUnits)) then
            call GroupAddUnit(EnchantedUnits, hero)
        endif
    elseif (IsUnitInGroup(hero, EnchantedUnits)) then
        call EnchanterSystemRemoveUnit(hero)
        call GroupRemoveUnit(EnchantedUnits, hero)
    endif

    return enchantingItemsCounter
endfunction

function EnchanterAddItemBonus takes unit hero, item whichItem returns nothing
    local integer oldEnchantingBonusHeroStatAndDefense = EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldEnchantingBonusDamage = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldEnchantingBonusHitPoints = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)

    //call BJDebugMsg("Add old Hero stats and defense bonus " + I2S(oldEnchantingBonusHeroStatAndDefense) + " and damage bonus " + R2S(oldEnchantingBonusDamage) + " and hit points bonus " + R2S(oldEnchantingBonusHitPoints) + " to picked up item " + GetItemName(whichItem))

    call EnchanterAddItemBonusesEx(hero, whichItem, oldEnchantingBonusHeroStatAndDefense, oldEnchantingBonusDamage, oldEnchantingBonusHitPoints)
endfunction

function EnchanterRemoveItemBonus takes unit hero, item whichItem returns nothing
    local integer oldEnchantingBonusHeroStatAndDefense = -EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldEnchantingBonusDamage = -EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldEnchantingBonusHitPoints = -EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)

    //call BJDebugMsg("Remove old Hero stats and defense bonus " + I2S(oldEnchantingBonusHeroStatAndDefense) + " and damage bonus " + R2S(oldEnchantingBonusDamage) + " and hit points bonus " + R2S(oldEnchantingBonusHitPoints) + " from dropped item " + GetItemName(whichItem))

    call EnchanterAddItemBonusesEx(hero, whichItem, oldEnchantingBonusHeroStatAndDefense, oldEnchantingBonusDamage, oldEnchantingBonusHitPoints)
endfunction

function EnchanterHeroInfo takes unit hero returns string
    local integer oldEnchantingBonusHeroStatAndDefense = EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldEnchantingBonusDamage = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldEnchantingBonusHitPoints = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)

    if (oldEnchantingBonusHeroStatAndDefense > 0) then
        return Format(GetLocalizedString("INSCRIPTOR_HERO_INFO")).s(GetUnitName(hero)).i(oldEnchantingBonusHeroStatAndDefense).i(R2I(oldEnchantingBonusDamage)).i(R2I(oldEnchantingBonusHitPoints)).result()
    endif

    return null
endfunction

function EnchanterInfo takes player whichPlayer returns string
    local string text = GetLocalizedString("ENCHANTABLE_ITEM_ABILITIES") + AbilityFieldsListItemAbilities()
    //local group heroes = GetUnitsSelectedAll(whichPlayer) // TODO Desync.
    local group heroes = GetPlayerHeroes(whichPlayer)
    local unit hero = null
    local string heroTxt = ""
    local string txt = null
    local integer i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(heroes))
        set hero = BlzGroupUnitAt(heroes, i)
        if (IsUnitType(hero, UNIT_TYPE_HERO)) then
            set txt = EnchanterHeroInfo(hero)
            call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, txt)
            if (txt != null) then
                if (heroTxt != "") then
                    set heroTxt = heroTxt + ", "
                endif

                set heroTxt = heroTxt + txt
            endif
        endif
        set hero = null
        set i = i + 1
    endloop
    call GroupClear(heroes)
    call DestroyGroup(heroes)
    set heroes = null

    if (heroTxt != "") then
        return heroTxt + ", " + text
    endif

    return text
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    if (IsHeroEnchanted(GetTriggerUnit())) then
        return true
    endif

    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetUnitTypeId(GetTriggerUnit()) != BACK_PACK and GetUnitTypeId(GetTriggerUnit()) != EQUIPMENT_BAG and (GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_NOVICE or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_ADEPT or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_MASTER)
endfunction

private function TriggerActionSetHeroBonus takes nothing returns nothing
    if (GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_NOVICE or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_ADEPT or GetItemTypeId(GetManipulatedItem()) == ENCHANTER_ITEM_TYPE_ID_MASTER) then
        call EnchanterSetHeroBonus(GetTriggerUnit())
        //call DisplayEnchanterHeroInfo(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit())
    endif
    call EnchanterAddItemBonus(GetTriggerUnit(), GetManipulatedItem())
endfunction

private function TriggerConditionDropItem takes nothing returns boolean
    return IsHeroEnchanted(GetTriggerUnit())
endfunction

private function TriggerActionSetHeroBonusDrop takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(GetTriggerUnit())
    local item droppedItem = GetManipulatedItem()
    call EnchanterRemoveItemBonus(triggerUnit, GetManipulatedItem())
    call TriggerSleepAction(0.0)
    if (GetItemTypeId(droppedItem) == ENCHANTER_ITEM_TYPE_ID_NOVICE or GetItemTypeId(droppedItem) == ENCHANTER_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(droppedItem) == ENCHANTER_ITEM_TYPE_ID_ADEPT or GetItemTypeId(droppedItem) == ENCHANTER_ITEM_TYPE_ID_MASTER) then
        call EnchanterSetHeroBonus(triggerUnit)
        //call DisplayEnchanterHeroInfo(owner, triggerUnit)
    endif
    set droppedItem = null
    set triggerUnit = null
    set owner = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))
    call TriggerAddAction(pickupItemTrigger, function TriggerActionSetHeroBonus)

    call TriggerRegisterAnyUnitEventBJ(dropItemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropItemTrigger, Condition(function TriggerConditionDropItem))
    call TriggerAddAction(dropItemTrigger, function TriggerActionSetHeroBonusDrop)
endfunction

endlibrary
