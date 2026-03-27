library WoWReforgedSkins initializer Init requires SimError, MathUtils, PagedButtons, WoWReforgedUtils, WoWReforgedAccount, WoWReforgedSkinDependencyEquivalents, WoWReforgedHeroes

globals
    private integer array skinItemTypeId
    private integer array skinUnitTypeId
    private integer skinCounter = 0

    private trigger sellItemTrigger = CreateTrigger()
    private trigger sellUnitTrigger = CreateTrigger()
endglobals

function IsSkinsShop takes integer unitTypeId returns boolean
    return unitTypeId == SKINS or unitTypeId == SKINS_NEUTRAL
endfunction

function IsUnitSkinsShop takes unit whichUnit returns boolean
    return IsSkinsShop(GetUnitTypeId(whichUnit))
endfunction

function GetMaxSkins takes nothing returns integer
    return skinCounter
endfunction

private function AddSkin takes integer itemTypeId, integer unitTypeId returns integer
    local integer index = skinCounter
    set skinItemTypeId[index] = itemTypeId
    set skinUnitTypeId[index] = unitTypeId
    set skinCounter = skinCounter + 1
    return index
endfunction

function GetSkinItemTypeId takes integer index returns integer
    return skinItemTypeId[index]
endfunction

function GetSkinUnitTypeId takes integer index returns integer
    return skinUnitTypeId[index]
endfunction

function GetSkinByItemTypeId takes integer itemTypeId returns integer
    local integer result = -1
    local integer i = 0
    loop
        exitwhen (i == skinCounter)
        if (skinItemTypeId[i] == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function IsCustomizableHero takes integer unitTypeId returns boolean
    return unitTypeId == VOID_LORD or unitTypeId == CUSTOMIZABLE_HERO
endfunction

private function GetRandomSkinForPlayer takes player whichPlayer returns integer
    local integer array availableSkins
    local integer availableSkinsCounter = 0
    local integer i = 0
    loop
        exitwhen (i == skinCounter)
        if (PlayerHasUnlocked(whichPlayer, GetSkinUnitTypeId(i)) and PlayerCanBuyHeroEx(whichPlayer, GetSkinUnitTypeId(i))) then
            set availableSkins[availableSkinsCounter] = GetSkinUnitTypeId(i)
            set availableSkinsCounter = availableSkinsCounter + 1
        endif
        set i = i + 1
    endloop
    return availableSkins[GetRandomInt(0, availableSkinsCounter - 1)]
endfunction

function RandomizeHeroSkin takes unit hero returns boolean
    local integer unitTypeId = GetUnitTypeId(hero)
    local player owner = GetOwningPlayer(hero)
    if (IsCustomizableHero(unitTypeId)) then
        call SetUnitSkinWithHeroIcon(hero, GetRandomSkinForPlayer(owner))
        
        return true
    else
        call SimError(owner, GetLocalizedString("SKIN_CUSTOMIZABLE")) // Only customizable heroes can change their skin.
    endif
    
    set owner = null
    
    return false
endfunction

function AddSkinsShop takes unit shop returns nothing
    local integer i = 0
    local integer max = 0
    //call BJDebugMsg("Before enabling shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    call EnablePagedButtons(shop)
    call AddPagedButtonsUnitType(shop, NEXT_SKIN_UNIT_TYPE_ID)
    
    loop
        exitwhen (i >= skinCounter)
        call AddPagedButtonsItemType(shop, GetSkinItemTypeId(i))
         //call BJDebugMsg("Skill " + I2S(i)) // Stops at 189
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetHeroesMax()
    loop
        exitwhen (i == max)
        call AddPagedButtonsUnitType(shop, GetHeroUnitType(i))
        set i = i + 1
    endloop
    
    set i = 0
    set max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i == max)
        call AddPagedButtonsUnitType(shop, GetUnitTypeId(BlzGroupUnitAt(udg_Bosses, i)))
        set i = i + 1
    endloop
    //call BJDebugMsg("Before enabling paged buttons for shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    
    //call BJDebugMsg("Enabled shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
endfunction

private function TriggerAction1SellItem takes nothing returns nothing
    local unit shop = GetSellingUnit()
    local unit hero = GetBuyingUnit()
    local player owner = GetOwningPlayer(hero)
    local integer unitTypeId = GetUnitTypeId(hero)
    local item whichItem = GetSoldItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer shopUnitTypeId = GetUnitTypeId(shop)
    local integer index = GetSkinByItemTypeId(itemTypeId)
    if (index != -1) then
        if (IsCustomizableHero(unitTypeId)) then
            if (PlayerHasUnlocked(owner, GetSkinUnitTypeId(index))) then
                call SetUnitSkinWithHeroIcon(hero, GetSkinUnitTypeId(index))
                call DisplayTextToPlayer(owner, 0.0, 0.0, Format(GetLocalizedString("SKIN_CHANGED")).s(GetObjectName(GetSkinUnitTypeId(index))).result())
            else
                call SimError(owner, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetItemName(whichItem)).s(GetAllUnlockedAccountNames(GetSkinUnitTypeId(index))).result())
            endif
        else 
            call SimError(owner, GetLocalizedString("SKIN_CUSTOMIZABLE"))
        endif
        call RemoveItem(whichItem)
    endif
    set whichItem = null
    set shop = null
    set hero = null
    set owner = null
endfunction

private function TriggerActionSellUnit takes nothing returns nothing
    local unit shop = GetSellingUnit()
    local unit hero = GetBuyingUnit()
    local player owner = GetOwningPlayer(hero)
    local integer unitTypeId = GetUnitTypeId(hero)
    local unit soldUnit = GetSoldUnit()
    local integer soldUnitTypeId = GetUnitTypeId(soldUnit)
    local integer shopUnitTypeId = GetUnitTypeId(shop)
    if (soldUnitTypeId != PagedButtons_NEXT_PAGE_ID and soldUnitTypeId != PagedButtons_PREVIOUS_PAGE_ID) then
        if (soldUnitTypeId == NEXT_SKIN_UNIT_TYPE_ID) then
            call NextSkin(hero)
            call RemoveUnit(soldUnit)
        elseif (IsUnitSkinsShop(shop)) then
            if (IsCustomizableHero(unitTypeId)) then
                if (PlayerHasUnlocked(owner, soldUnitTypeId)) then
                    call SetUnitSkinWithHeroIcon(hero, soldUnitTypeId)
                    call DisplayTextToPlayer(owner, 0.0, 0.0, Format(GetLocalizedString("SKIN_CHANGED")).s(GetObjectName(soldUnitTypeId)).result())
                else
                    call SimError(owner, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetObjectName(soldUnitTypeId)).s(GetAllUnlockedAccountNames(soldUnitTypeId)).result())
                endif
            else 
                call SimError(owner, GetLocalizedString("SKIN_CUSTOMIZABLE"))
            endif
            call RemoveUnit(soldUnit)
        endif
    endif
    set soldUnit = null
    set shop = null
    set hero = null
    set owner = null
endfunction

private function Init takes nothing returns nothing
    call DisableTrigger(bj_stockItemPurchased) // do not remove items on selling them

    call TriggerRegisterAnyUnitEventBJ(sellItemTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddAction(sellItemTrigger, function TriggerAction1SellItem)
    
    call TriggerRegisterAnyUnitEventBJ(sellUnitTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddAction(sellUnitTrigger, function TriggerActionSellUnit)
    
    call AddSkin('I1AG', 'nvl2')
    call AddSkin('I0YR', 'nvlw')
    call AddSkin('I1AE', 'nvlk')
    call AddSkin('I1AF', 'nvk2')
    call AddSkin('I10L', 'hkni')
    call AddSkin('I0ZD', 'ogru')
    call AddSkin('I17Y', 'Edmm')
    call AddSkin('I176', 'H0AJ')
    call AddSkin('I1AH', 'H0AW')
    call AddSkin('I1AO', 'Oths')
    call AddSkin('I0J4', 'ngh2')
endfunction

endlibrary
