library WoWReforgedTrainer initializer Init requires NewBonus, PagedButtons, HeroUtils, Attributes, UnitGroupUtils, WoWReforgedUtils, WoWReforgedAttributes, WoWReforgedClasses

globals
    constant integer ITEM_RANDOM_CLASS = 'I07X'

    constant integer ITEM_EQUAL_ATTRIBUTES = 'I0RV'
    constant integer ITEM_RESET_ATTRIBUTES = 'I0RU'
    constant integer ITEM_ATTRIBUTES = 'I0RT'

    constant integer ITEM_STRENGTH_PLUS_1 = 'I0RO'
    constant integer ITEM_STRENGTH_MINUS_1 = 'I0RN'
    
    constant integer ITEM_AGILITY_PLUS_1 = 'I0RP'
    constant integer ITEM_AGILITY_MINUS_1 = 'I0RR'
    
    constant integer ITEM_INTELLIGENCE_PLUS_1 = 'I0RQ'
    constant integer ITEM_INTELLIGENCE_MINUS_1 = 'I0RS'
    
    constant integer ITEM_FOOT = 'I0OJ'
    constant integer ITEM_AMPHIBIOUS = 'I0OK'
    constant integer ITEM_FLY = 'I0OL'

    constant integer ITEM_STRENGTH = 'I0OM'
    constant integer ITEM_AGILITY = 'I0ON'
    constant integer ITEM_INTELLIGENCE = 'I0OO'
    
    constant integer ITEM_MELEE = 'I0II'
    constant integer ITEM_RANGE = 'I0UZ'

    private trigger sellItemTrigger = CreateTrigger()
endglobals

function IsTrainer takes integer unitTypeId returns boolean
    return unitTypeId == TRAINER or unitTypeId == TRAINER_NEUTRAL
endfunction

function AddTrainer takes unit shop returns nothing
    local integer i = 0
    local integer max = 0

    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop, 9)
    
    // hero classes
    call NextPagedButtonsPage(shop, GetLocalizedString("CLASSES"))
    call AddPagedButtonsItemType(shop, ITEM_RANDOM_CLASS)
    set i = 0
    set max = GetMaxHeroClasses()
    loop
        exitwhen (i == max)
        call AddPagedButtonsItemType(shop, GetHeroClassItemTypeId(i))
        set i = i + 1
    endloop
    
    // primary attributes
    call NextPagedButtonsPage(shop, GetLocalizedString("PRIMARY_ATTRIBUTES"))
    call AddPagedButtonsItemType(shop, ITEM_STRENGTH)
    call AddPagedButtonsItemType(shop, ITEM_AGILITY)
    call AddPagedButtonsItemType(shop, ITEM_INTELLIGENCE)
    
    // attack types
    call NextPagedButtonsPage(shop, GetLocalizedString("ATTACK_TYPES"))
    call AddPagedButtonsItemType(shop, ITEM_MELEE)
    call AddPagedButtonsItemType(shop, ITEM_RANGE)

    // movement types
    call NextPagedButtonsPage(shop, GetLocalizedString("MOVEMENT_TYPES"))
    call AddPagedButtonsItemType(shop, ITEM_FOOT)
    call AddPagedButtonsItemType(shop, ITEM_AMPHIBIOUS)
    call AddPagedButtonsItemType(shop, ITEM_FLY)
    
    // attributes
    call NextPagedButtonsPage(shop, GetLocalizedString("ATTRIBUTES"))
    call AddPagedButtonsItemType(shop, ITEM_EQUAL_ATTRIBUTES)
    call AddPagedButtonsItemType(shop, ITEM_RESET_ATTRIBUTES)
    call AddPagedButtonsItemType(shop, ITEM_ATTRIBUTES)
    call AddPagedButtonsItemType(shop, ITEM_STRENGTH_PLUS_1)
    call AddPagedButtonsItemType(shop, ITEM_STRENGTH_MINUS_1)
    call AddPagedButtonsItemType(shop, ITEM_AGILITY_PLUS_1)
    call AddPagedButtonsItemType(shop, ITEM_AGILITY_MINUS_1)
    call AddPagedButtonsItemType(shop, ITEM_INTELLIGENCE_PLUS_1)
    call AddPagedButtonsItemType(shop, ITEM_INTELLIGENCE_MINUS_1)
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    local unit hero = GetBuyingUnit()
    local item whichItem = GetSoldItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer heroClass = -1
    
    if (itemTypeId == ITEM_EQUAL_ATTRIBUTES) then
        call ShowWowReforgedSkillPoints(hero)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_RESET_ATTRIBUTES) then
        call ResetWowReforgedSkillPoints(hero)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_ATTRIBUTES) then
        call EqualWowReforgedSkillPoints(hero)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_STRENGTH_PLUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_STR, 1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_STRENGTH_MINUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_STR, -1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_AGILITY_PLUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_AGI, 1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_AGILITY_MINUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_AGI, -1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_INTELLIGENCE_PLUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_INT, 1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_INTELLIGENCE_MINUS_1) then
        call WoWReforgedSkillAttribute(hero, bj_HEROSTAT_INT, -1.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_FOOT) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_MOVEMENT_TYPE_TO_X")).s(GetLocalizedString("FOOT")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_MOVE_TYPE, GetHandleId(MOVE_TYPE_FOOT))
        call UnitRemoveType(hero, UNIT_TYPE_FLYING)
        call UnitAddType(hero, UNIT_TYPE_GROUND)
        call BlzSetUnitRealField(hero, UNIT_RF_FLY_HEIGHT, 0.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_AMPHIBIOUS) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_MOVEMENT_TYPE_TO_X")).s(GetLocalizedString("AMPHIBIOUS")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_MOVE_TYPE, GetHandleId(MOVE_TYPE_AMPHIBIOUS))
        call UnitRemoveType(hero, UNIT_TYPE_FLYING)
        call UnitAddType(hero, UNIT_TYPE_GROUND)
        call BlzSetUnitRealField(hero, UNIT_RF_FLY_HEIGHT, 0.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_FLY) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_MOVEMENT_TYPE_TO_X")).s(GetLocalizedString("FLY")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_MOVE_TYPE, GetHandleId(MOVE_TYPE_FLY))
        call UnitRemoveType(hero, UNIT_TYPE_GROUND)
        call UnitAddType(hero, UNIT_TYPE_FLYING)
        call BlzSetUnitRealField(hero, UNIT_RF_FLY_HEIGHT, 280.0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_STRENGTH) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_PRIMARY_ATTRIBUTE_TO_X")).s(GetLocalizedString("STRENGTH")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE, GetHandleId(HERO_ATTRIBUTE_STR))
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_AGILITY) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_PRIMARY_ATTRIBUTE_TO_X")).s(GetLocalizedString("AGILITY")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE, GetHandleId(HERO_ATTRIBUTE_AGI))
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_INTELLIGENCE) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_PRIMARY_ATTRIBUTE_TO_X")).s(GetLocalizedString("INTELLIGENCE")).result())
        call BlzSetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE, GetHandleId(HERO_ATTRIBUTE_INT))
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_MELEE) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_ATTACK_TO_X")).s(GetLocalizedString("MELEE")).result())
        call GiveHeroMeleeAttack(hero, 0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_RANGE) then
        call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("CHANGE_ATTACK_TO_X")).s(GetLocalizedString("RANGE")).result())
        call GiveHeroRangeAttack(hero, 0)
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_RANDOM_CLASS) then
        call ApplyRandomHeroClass(hero)
        call RemoveItem(whichItem)
    else
        set heroClass = GetHeroClassByItemTypeId(GetItemTypeId(whichItem))
        if (heroClass != -1) then
            if (GetUnitTypeId(hero) != BACKPACK and GetUnitTypeId(hero) != HERO_SELECTOR) then
                call ApplySpecificHeroClass(hero, GetHeroClassByIndex(heroClass), true)
            endif
            call RemoveItem(whichItem)
        endif
    endif
    set hero = null
    set whichItem = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellItemTrigger, Condition(function TriggerConditionSellItem))
endfunction

endlibrary
