library WowReforgedProfessionCook initializer Init requires NewBonusUtils, Crafting

globals
    constant integer ITEM_TYPE_ID_RECIPE = 'I0XC'
    
    constant integer ITEM_TYPE_ID_GARLIC = 'I0WW'
    constant integer ITEM_TYPE_ID_BANANA = 'I0S8'
    constant integer ITEM_TYPE_ID_ORANGE = 'I0U3'
    constant integer ITEM_TYPE_ID_LEMON = 'I0U2'
    constant integer ITEM_TYPE_ID_MEAT = 'I0X1'
    
    private integer array foodItemTypeIds
    private integer foodItemTypeIdsCounter = 0
endglobals

function GetRandomFoodItemTypeId takes nothing returns integer
    return foodItemTypeIds[GetRandomInt(0, foodItemTypeIdsCounter - 1)]
endfunction

function IsFood takes integer itemTypeId returns boolean
    local integer i = 0
    loop
        exitwhen (i == foodItemTypeIdsCounter)
        if (itemTypeId == foodItemTypeIds[i]) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function AddFoodItemTypeId takes integer itemTypeId returns nothing
    set foodItemTypeIds[foodItemTypeIdsCounter] = itemTypeId
    set foodItemTypeIdsCounter = foodItemTypeIdsCounter + 1
endfunction

function AddCookFirePit takes unit whichUnit returns nothing
    local integer i = 0
    local integer max = udg_RecipeCooking
    call EnableItemCraftingUnit(whichUnit)
    loop
        exitwhen (i >= max)
        call SetItemCraftingRecipeEnabled(whichUnit, i, false)
        set i = i + 1
    endloop
    //call SetItemCraftingRecipeEnabled(whichUnit, udg_RecipeHolyGrail, false)
    
    //call SetPagedButtonsPage(whichUnit, GetRecipePage(udg_RecipeCooking))
endfunction

function WarriorsMenu takes unit hero returns nothing
    call AddUnitBonusTimed(hero, BONUS_STRENGTH, 5.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_DAMAGE, 5.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_HEALTH, 100.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_HEALTH_REGEN, 0.3, 60.0)
endfunction

function RangersMenu takes unit hero returns nothing
    call AddUnitBonusTimed(hero, BONUS_AGILITY, 5.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_ARMOR, 5.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_MOVEMENT_SPEED, 100.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_ATTACK_SPEED, 0.3, 60.0)
endfunction

function MagiciansMenu takes unit hero returns nothing
    call AddUnitBonusTimed(hero, BONUS_INTELLIGENCE, 5.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_MAGIC_RESISTANCE, 30.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_MANA, 100.0, 60.0)
    call AddUnitBonusTimed(hero, BONUS_MANA_REGEN, 0.3, 60.0)
endfunction

function IsItemTypeIdCookingRecipe takes integer itemTypeId returns boolean
    local integer i = 0
    local integer max = udg_RecipeCooking
    loop
        exitwhen (i == max)
        if (itemTypeId == GetRecipeItemTypeId(i)) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

private function ShowRecipesFloatingText takes unit hero, item whichItem, integer recipes returns nothing
    local force whichForce = CreateForce()
    call ForceAddPlayer(whichForce, GetOwningPlayer(hero))
    call ShowGeneralFadingTextTagForForce(whichForce, Format(GetLocalizedString("CRAFT_BONUS")).i(recipes).s(GetItemName(whichItem)).result(), GetUnitX(hero), GetUnitY(hero), 0, 0, 0, 0)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
endfunction

function CraftItemCook takes unit crafter, item whichItem returns nothing
    local integer recipes = CountItemsOfItemTypeId(crafter, ITEM_TYPE_ID_RECIPE)
    //call BJDebugMsg("Recipes " + I2S(recipes))
    if (recipes > 0) then
        if (IsItemTypeIdCookingRecipe(GetItemTypeId(whichItem))) then
            //call BJDebugMsg("Is cooking recipe")
            call SetItemCharges(whichItem, GetItemCharges(whichItem) + recipes)
            call RemoveAllItemsOfTypeId(crafter, ITEM_TYPE_ID_RECIPE)
            call ShowRecipesFloatingText(crafter, whichItem, recipes)
        else
            //call BJDebugMsg("Is no cooking recipe")
        endif
    endif
endfunction

function CookCutKitchenKnife takes unit hero, item whichItem returns nothing
    if (IsFood(GetItemTypeId(whichItem))) then
        call SetItemCharges(whichItem, GetItemCharges(whichItem) + 1)
    else
        call IssueImmediateOrder(hero, "stop")
        call SimError(GetOwningPlayer(hero), GetLocalizedString("TARGET_ITEM_MUST_BE_FOOD"))
    endif
endfunction

private function Init takes nothing returns nothing
    call AddFoodItemTypeId(ITEM_TYPE_ID_GARLIC)
    call AddFoodItemTypeId(ITEM_TYPE_ID_BANANA)
    call AddFoodItemTypeId(ITEM_TYPE_ID_ORANGE)
    call AddFoodItemTypeId(ITEM_TYPE_ID_LEMON)
    call AddFoodItemTypeId(ITEM_TYPE_ID_MEAT)
endfunction

endlibrary
