library WoWReforgedProfessionInscriptor initializer Init requires WoWReforgedAbilityFields, WoWReforgedAbilitySkill, WoWReforgedEquipmentBags, WoWReforgedUtils, WoWReforgedI18n

globals
    private hashtable h = InitHashtable()
    private group targets = CreateGroup()

    constant integer INSCRIPTOR_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS = 1
    constant integer INSCRIPTOR_SYSTEM_KEY_DAMAGE_BONUS = 2
    constant integer INSCRIPTOR_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS = 3

    constant integer INSCRIPTOR_ITEM_TYPE_ID_NOVICE = ITEM_NOVICE_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_NOVICE = 1
    constant integer INSCRIPTOR_DAMAGE_BONUS_NOVICE = 3
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_NOVICE = 50
    constant integer INSCRIPTOR_ITEM_TYPE_ID_ADVANCED = ITEM_ADVANCED_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_ADVANCED = 2
    constant integer INSCRIPTOR_DAMAGE_BONUS_ADVANCED = 5
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_ADVANCED = 100
    constant integer INSCRIPTOR_ITEM_TYPE_ID_ADEPT = ITEM_ADEPT_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_ADEPT = 3
    constant integer INSCRIPTOR_DAMAGE_BONUS_ADEPT = 7
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_ADEPT = 150
    constant integer INSCRIPTOR_ITEM_TYPE_ID_MASTER = ITEM_MASTER_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_MASTER = 4
    constant integer INSCRIPTOR_DAMAGE_BONUS_MASTER = 9
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_MASTER = 200
    constant integer INSCRIPTOR_ITEM_TYPE_ID_GRAND_MASTER = ITEM_GRAND_MASTER_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_GRAND_MASTER = 5
    constant integer INSCRIPTOR_DAMAGE_BONUS_GRAND_MASTER = 11
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_GRAND_MASTER = 250
    constant integer INSCRIPTOR_ITEM_TYPE_ID_DOCTOR = ITEM_DOCTOR_GLYPH
    constant integer INSCRIPTOR_STAT_BONUS_DOCTOR = 6
    constant integer INSCRIPTOR_DAMAGE_BONUS_DOCTOR = 13
    constant integer INSCRIPTOR_HIT_POINTS_BONUS_DOCTOR = 300

    private trigger pickupItemTrigger = CreateTrigger()
    private trigger dropItemTrigger = CreateTrigger()
    private trigger learnTrigger = CreateTrigger()
endglobals

function InscriptorSystemSaveBonus takes unit hero, integer bonusType, integer bonus returns nothing
    call SaveInteger(h, GetHandleId(hero), bonusType, bonus)
endfunction

function InscriptorSystemLoadBonus takes unit hero, integer bonusType returns integer
    return LoadInteger(h, GetHandleId(hero), bonusType)
endfunction

function InscriptorSystemSaveBonusReal takes unit hero, integer bonusType, real bonus returns nothing
    call SaveReal(h, GetHandleId(hero), bonusType, bonus)
endfunction

function InscriptorSystemLoadBonusReal takes unit hero, integer bonusType returns real
    return LoadReal(h, GetHandleId(hero), bonusType)
endfunction

function InscriptorAddAbilityBonusesEx takes unit hero, ability whichAbility, integer bonusHeroStatsAndDefense, real bonusDamage, real bonusHitPoints returns nothing
    local integer abilityId = BlzGetAbilityId(whichAbility)
    //call BJDebugMsg("Adding bonus to ability " + GetObjectName(abilityId))
    call AddAbilityFieldBonuses(abilityId, whichAbility, 1, bonusHeroStatsAndDefense, bonusHeroStatsAndDefense, 0.0, bonusDamage, bonusHitPoints, bonusHitPoints, 0, 0.0, I2R(bonusHeroStatsAndDefense), bonusHeroStatsAndDefense, R2I(bonusHitPoints), R2I(bonusHitPoints), bonusDamage, bonusHeroStatsAndDefense, 0.0)
    // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
    //call IncUnitAbilityLevel(hero, abilityId)
    //call DecUnitAbilityLevel(hero, abilityId)
endfunction

function IsHeroInscripted takes unit hero returns boolean
    return IsUnitInGroup(hero, targets)
endfunction

private function InscriptorSystemRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit InscriptorSystemRemoveUnit

function InscriptorSetHeroBonus takes unit hero returns integer
    local item whichItem = null
    local ability whichAbility = null
    local integer oldInscriptionBonusHeroStatAndDefense = InscriptorSystemLoadBonus(hero, INSCRIPTOR_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldInscriptionBonusDamage = InscriptorSystemLoadBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldInscriptionBonusHitPoints = InscriptorSystemLoadBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)
    local integer inscriptionItemsCounter = 0
    local integer heroStatsAndDefenseBonus = 0
    local real damageBonus = 0
    local integer hitPointsBonus = 0
    local integer heroStatsAndDefenseBonusDiff = 0
    local real damageBonusDiff = 0
    local real hitPointsBonusDiff = 0
    local integer itemTypeId = 0
    local integer factor = 0
    local integer heroSpellLevel = GetUnitAbilitySkillLevel(hero, ABILITY_ENGINEERING_UPGRADE)
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null) then
            set itemTypeId = GetItemTypeId(whichItem)
            set factor = GetItemCharges(whichItem)
            if (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_NOVICE) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_NOVICE * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_NOVICE * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_NOVICE * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            elseif (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_ADVANCED) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_ADVANCED * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_ADVANCED * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_ADVANCED * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            elseif (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_ADEPT) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_ADEPT * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_ADEPT * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_ADEPT * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            elseif (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_MASTER) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_MASTER * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_MASTER * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_MASTER * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            elseif (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_GRAND_MASTER) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_GRAND_MASTER * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_GRAND_MASTER * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_GRAND_MASTER * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            elseif (itemTypeId == INSCRIPTOR_ITEM_TYPE_ID_DOCTOR) then
                set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_DOCTOR * factor
                set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_DOCTOR * factor
                set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_DOCTOR * factor
                set inscriptionItemsCounter = inscriptionItemsCounter + 1
            endif
        endif
        set whichItem = null
        set i = i + 1
    endloop
    
    if (heroSpellLevel > 0) then
        set heroStatsAndDefenseBonus = heroStatsAndDefenseBonus + INSCRIPTOR_STAT_BONUS_MASTER * heroSpellLevel
        set damageBonus = damageBonus + INSCRIPTOR_DAMAGE_BONUS_MASTER * heroSpellLevel
        set hitPointsBonus = hitPointsBonus + INSCRIPTOR_HIT_POINTS_BONUS_MASTER * heroSpellLevel
        set inscriptionItemsCounter = inscriptionItemsCounter + 1
    endif

    //call BJDebugMsg("Old Hero stats and defense bonus " + I2S(oldInscriptionBonusHeroStatAndDefense) + " and damage bonus " + R2S(oldInscriptionBonusDamage) + " and hit points bonus " + R2S(oldInscriptionBonusHitPoints))

    set heroStatsAndDefenseBonusDiff = heroStatsAndDefenseBonus - oldInscriptionBonusHeroStatAndDefense
    set damageBonusDiff = damageBonus - oldInscriptionBonusDamage
    set hitPointsBonusDiff = hitPointsBonus - oldInscriptionBonusHitPoints

    //call BJDebugMsg("Hero stats and defense bonus " + I2S(heroStatsAndDefenseBonusDiff) + " and damage bonus " + R2S(damageBonusDiff) + " and hit points bonus " + R2S(hitPointsBonusDiff))

    set i = 0
    loop
        exitwhen (i == MAX_UNIT_ABILITIES)
        set whichAbility = BlzGetUnitAbilityByIndex(hero, i)
        if (whichAbility != null and GetMaxAbilityFields(BlzGetAbilityId(whichAbility)) > 0) then
            call InscriptorAddAbilityBonusesEx(hero, whichAbility, heroStatsAndDefenseBonusDiff, damageBonusDiff, hitPointsBonusDiff)
        endif
        set whichAbility = null
        set i = i + 1
    endloop

    if (inscriptionItemsCounter > 0) then
        call InscriptorSystemSaveBonus(hero, INSCRIPTOR_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS, heroStatsAndDefenseBonus)
        call InscriptorSystemSaveBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_DAMAGE_BONUS, damageBonus)
        call InscriptorSystemSaveBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS, hitPointsBonus)
        if (not IsUnitInGroup(hero, targets)) then
            call GroupAddUnit(targets, hero)
        endif
    elseif (IsUnitInGroup(hero, targets)) then
        call InscriptorSystemRemoveUnit(hero)
        call GroupRemoveUnit(targets, hero)
    endif

    return inscriptionItemsCounter
endfunction

function InscriptorHeroInfo takes unit hero returns string
    local integer oldInscriptionBonusHeroStatAndDefense = InscriptorSystemLoadBonus(hero, INSCRIPTOR_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real oldInscriptionBonusDamage = InscriptorSystemLoadBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_DAMAGE_BONUS)
    local real oldInscriptionBonusHitPoints = InscriptorSystemLoadBonusReal(hero, INSCRIPTOR_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)

    if (oldInscriptionBonusHeroStatAndDefense > 0) then
        return Format(GetLocalizedString("INSCRIPTOR_HERO_INFO")).s(GetUnitName(hero)).i(oldInscriptionBonusHeroStatAndDefense).i(R2I(oldInscriptionBonusDamage)).i(R2I(oldInscriptionBonusHitPoints)).result()
    endif

    return null
endfunction

function InscriptorInfo takes player whichPlayer returns string
    local string text = GetLocalizedString("INSCRIPTABLE_SPELLS") + AbilityFieldsListNonItemAbilities()
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
            set txt = InscriptorHeroInfo(hero)
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

function DisplayInscriptorHeroInfo takes player whichPlayer, unit hero returns nothing
    local string txt = InscriptorHeroInfo(hero)
    if (txt != null) then
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, txt)
    endif
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    if (IsHeroInscripted(GetTriggerUnit())) then
        return true
    endif

    return IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetUnitTypeId(GetTriggerUnit()) != BACK_PACK and GetUnitTypeId(GetTriggerUnit()) != EQUIPMENT_BAG and (GetItemTypeId(GetManipulatedItem()) == INSCRIPTOR_ITEM_TYPE_ID_NOVICE or GetItemTypeId(GetManipulatedItem()) == INSCRIPTOR_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(GetManipulatedItem()) == INSCRIPTOR_ITEM_TYPE_ID_ADEPT or GetItemTypeId(GetManipulatedItem()) == INSCRIPTOR_ITEM_TYPE_ID_MASTER)
endfunction

private function TriggerActionSetHeroBonus takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local item manipulatedItem = GetManipulatedItem()
    if (GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_NOVICE or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_ADEPT or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_MASTER) then
        call InscriptorSetHeroBonus(triggerUnit)
        //call DisplayInscriptorHeroInfo(owner, triggerUnit)
    endif
    set manipulatedItem = null
    set triggerUnit = null
    set owner = null
endfunction

private function TriggerConditionDropItem takes nothing returns boolean
    return IsHeroInscripted(GetTriggerUnit())
endfunction

private function TriggerActionSetHeroBonusDrop takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local item manipulatedItem = GetManipulatedItem()
    call TriggerSleepAction(0.0)
    if (GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_NOVICE or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_ADVANCED or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_ADEPT or GetItemTypeId(manipulatedItem) == INSCRIPTOR_ITEM_TYPE_ID_MASTER) then
        call InscriptorSetHeroBonus(triggerUnit)
        //call DisplayInscriptorHeroInfo(owner, triggerUnit)
    endif
    set manipulatedItem = null
    set triggerUnit = null
    set owner = null
endfunction

private function TriggerConditionLearn takes nothing returns boolean
    if (IsHeroInscripted(GetTriggerSkillAbilityUnit()) or GetTriggerSkilledAbilityId() == ABILITY_ENGINEERING_UPGRADE) then
        call InscriptorSetHeroBonus(GetTriggerSkillAbilityUnit())
        //call DisplayInscriptorHeroInfo(GetOwningPlayer(GetTriggerSkillAbilityUnit()), GetTriggerSkillAbilityUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))
    call TriggerAddAction(pickupItemTrigger, function TriggerActionSetHeroBonus)

    call TriggerRegisterAnyUnitEventBJ(dropItemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropItemTrigger, Condition(function TriggerConditionDropItem))
    call TriggerAddAction(dropItemTrigger, function TriggerActionSetHeroBonusDrop)
    
    call TriggerRegisterAbilitySkill(learnTrigger)
    call TriggerAddCondition(learnTrigger, Condition(function TriggerConditionLearn))
endfunction

endlibrary
