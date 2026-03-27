library Crafting initializer Init requires MathUtils, PagedButtons, OpLimit, StringFormat

/*
Baradé's Crafting 1.0

Allows crafting items and units by using the items in the unit inventory as requirements.
Items sold by the the crafting unit are used as recipes.
Buying the recipes will craft the matching item or unit and might consume the required items from
the crafting unit's inventory.

Recipes define which items 

Features:
- Recipes based on sellable items to craft items.
- Stocks to represent the number of available charges per recipe.
- Multipages based on the system PagedButtons.
- Linking multiple inventories.
- Minimum requirements.
- Customized requirements via callbacks.
- Disassemble crafted items and units back into their requirements.

###################################################################################################

function GetRecipesMax takes nothing returns integer

function GetRecipeItemTypeId takes integer recipe returns integer

function GetRecipeUIItemTypeId takes integer recipe returns integer

function AddRecipe takes integer itemTypeId, integer uiItemTypeId returns integer

function AddRecipeRequirementItem takes integer recipe, integer itemTypeId, integer charges, boolean consume returns integer

function SetRecipeIsUnit takes integer recipe, boolean flag returns nothing

function GetRecipeIsUnit takes integer recipe returns boolean

function SetRecipeIsSpacer takes integer recipe, boolean flag returns nothing

function GetRecipeIsSpacer takes integer recipe returns boolean

function AddRecipeSpacer takes string pageName returns integer

function SetRecipePageName takes integer recipe, string pageName returns nothing

function GetRecipeNotAvailableForPlayer takes integer recipe, integer playerId returns boolean

function SetRecipeNotAvailableForPlayer takes integer recipe, integer playerId, boolean notAvailable returns nothing

function GetRecipeAvailableForPlayer takes integer recipe, integer playerId returns boolean

function SetRecipeAvailableForPlayer takes integer recipe, integer playerId, boolean available returns nothing

function GetLastCreatedRecipe takes nothing returns integer

function SetLastRecipePageName takes string pageName returns nothing

function GetRecipeRequirementsCount takes integer recipe returns integer

function GetRecipeRequirementItemTypeId takes integer recipe, integer requirement returns integer

function GetRecipeRequirementCharges takes integer recipe, integer requirement returns integer

function GetRecipeRequirementConsume takes integer recipe, integer requirement returns boolean

function GetRecipeMinRequirements takes integer recipe returns integer

function SetRecipeMinRequirements takes integer recipe, integer minRequirements returns nothing

function SetRecipeRequirementCallback takes CraftingRequirementCallback callback returns nothing

function SetRecipeRequirementCallbackTrigger takes trigger callback returns nothing

function SetRecipeShowCallbackTrigger takes trigger callback returns nothing

function TriggerRegisterItemCraftingEvent takes trigger whichTrigger returns integer
function TriggerRegisterUnitCraftingEvent takes trigger whichTrigger returns integer

function TriggerRegisterItemDisassembleEvent takes trigger whichTrigger returns integer
function GetTriggerRecipe takes nothing returns integer

function GetTriggerCraftingUnit takes nothing returns unit

function GetTriggerCraftedItem takes nothing returns item
function GetTriggerCraftedUnit takes nothing returns unit

function GetTriggerCraftedCharges takes nothing returns integer

function GetRecipeByItemTypeId takes integer itemTypeId returns integer

function IsItemCraftingRecipeEnabled takes unit whichUnit, integer recipe returns boolean

function GetRecipeName takes integer recipe returns string

function GetRecipeByUIItemTypeId takes integer uIItemTypeId returns integer

function SetItemCraftingRecipeEnabled takes unit whichUnit, integer recipe, boolean enabled returns nothing

function EnableItemCraftingUnit takes unit whichUnit returns nothing

function IsItemCraftingUnitEnabled takes unit whichUnit returns boolean

function DisableItemCraftingUnit takes unit whichUnit returns boolean

function LinkItemCraftingUnitInventories takes unit whichUnit0, unit whichUnit1 returns group

function LinkItemCraftingGroupInventories takes group source returns group

function UnlinkItemCraftingUnitInventories takes unit whichUnit0, unit whichUnit1 returns group

function ItemCraftingUnitInventoriesAreLinked takes unit whichUnit0, unit whichUnit1 returns boolean

function DisassembleItem takes item soldItem, unit sellingUnit returns integer

function DisassembleUnit takes unit target, unit sellingUnit returns integer

###################################################################################################
*/

function interface CraftingRequirementCallback takes integer recipe, unit craftingUnit returns integer

globals
    public constant integer MAX_REQUIREMENTS = 30
    public constant integer MAX_SLOTS = 7
    public constant integer DISASSEMBLE_ABILITY_ID = 'A1DP'
    // We can only set the start delay and replenish interval of items to 3600 seconds maximum.
    // This interval defines how often the stocks are updated and start again with their start delay.
    public constant real UPDATE_INTERVAL = 60.0

    private integer array recipesItemTypeIds
    private integer array recipesUIItemTypeIds
    private boolean array recipesIsUnit
    private boolean array recipesIsSpacer
    private string array recipesPageName
    private boolean array recipesNotAvailableForPlayer
    private integer array recipesMinRequirements
    private integer array recipesRequirementCounters
    private integer array recipesRequirementItemTypeIds
    private integer array recipesRequirementCharges
    private boolean array recipesRequirementConsume
    private integer recipesCounter = 0

    // callbacks
    private CraftingRequirementCallback recipeRequirementCallback = 0
    private trigger recipeRequirementCallbackTrigger = null
    private trigger recipeShowCallbackTrigger = null
    private trigger array craftingCallbackTriggers
    private integer craftingCallbackTriggersCounter = 0
    private trigger array craftingCallbackUnitTriggers
    private integer craftingCallbackUnitTriggersCounter = 0
    private trigger array disassembleCallbackTriggers
    private integer disassembleCallbackTriggersCounter = 0
    
    private integer lastCreatedRecipe = 0

    private integer triggerRecipe = 0
    private unit triggerCraftingUnit = null
    private item triggerCraftedItem = null
    private unit triggerCraftedUnit = null
    private integer triggerCraftedCharges = 0

    private group itemCraftingUnits = CreateGroup()
    private trigger pickupTrigger = CreateTrigger()
    private trigger dropTrigger = CreateTrigger()
    private trigger itemCraftTrigger = CreateTrigger()
    private trigger itemDisassembleTrigger = CreateTrigger()

    private hashtable itemCraftingUnitsHashTable = InitHashtable()
    private trigger itemCraftingChangePageTrigger = CreateTrigger()
    private timer itemCraftingStockUpdateTimer = CreateTimer()
    
    // update food available
    private trigger trainStartTrigger = CreateTrigger()
    private trigger trainCancelTrigger = CreateTrigger()
    private trigger sellTrigger = CreateTrigger()
    private trigger reviveStartTrigger = CreateTrigger()
    private trigger reviveCancelTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    

    private constant integer HASHTABLE_KEY_PAGE = 0
    private constant integer HASHTABLE_KEY_GROUP = 1 // For linking multiple crafting units.
    private constant integer HASHTABLE_KEY_DISABLED_RECIPES = 2 // Disable recipes per unit. This has to be the last key. All following keys are the disabled recipes.
endglobals

function GetCraftingStockUpdateTimerHandleId takes nothing returns integer
    return GetHandleId(itemCraftingStockUpdateTimer)
endfunction

function GetRecipesMax takes nothing returns integer
    return recipesCounter
endfunction

function GetRecipeItemTypeId takes integer recipe returns integer
    return recipesItemTypeIds[recipe]
endfunction

function GetRecipeUIItemTypeId takes integer recipe returns integer
    return recipesUIItemTypeIds[recipe]
endfunction

function AddRecipe takes integer itemTypeId, integer uiItemTypeId returns integer
    local integer index = recipesCounter
    set recipesItemTypeIds[index] = itemTypeId
    set recipesUIItemTypeIds[index] = uiItemTypeId
    set recipesIsUnit[index] = false
    set recipesIsSpacer[index] = false
    set recipesPageName[index] = ""
    set recipesMinRequirements[index] = 0
    set recipesRequirementCounters[index] = 0
    set recipesCounter = recipesCounter + 1
    set lastCreatedRecipe = index
    return index
endfunction

function AddRecipeRequirementItem takes integer recipe, integer itemTypeId, integer charges, boolean consume returns integer
    local integer counter = recipesRequirementCounters[recipe]
    local integer index = Index2D(recipe, counter, MAX_REQUIREMENTS)
    set recipesRequirementItemTypeIds[index] = itemTypeId
    set recipesRequirementCharges[index] = charges
    set recipesRequirementConsume[index] = consume
    set recipesRequirementCounters[recipe] = counter + 1
    set recipesMinRequirements[recipe] = counter + 1
    return counter
endfunction

function SetRecipeIsUnit takes integer recipe, boolean flag returns nothing
    set recipesIsUnit[recipe] = flag
endfunction

function GetRecipeIsUnit takes integer recipe returns boolean
    return recipesIsUnit[recipe]
endfunction

function SetRecipeIsSpacer takes integer recipe, boolean flag returns nothing
    set recipesIsSpacer[recipe] = flag
endfunction

function GetRecipeIsSpacer takes integer recipe returns boolean
    return recipesIsSpacer[recipe]
endfunction

function AddRecipeSpacer takes string pageName returns integer
    local integer recipe = AddRecipe(0, 0)
    call SetRecipeIsSpacer(recipe, true)
    set recipesPageName[recipe] = pageName
    return recipe
endfunction

function SetRecipePageName takes integer recipe, string pageName returns nothing
    set recipesPageName[recipe] = pageName
endfunction

function GetRecipeNotAvailableForPlayer takes integer recipe, integer playerId returns boolean
    local integer index = Index2D(recipe, playerId, bj_MAX_PLAYERS)
    return recipesNotAvailableForPlayer[index]
endfunction

function SetRecipeNotAvailableForPlayer takes integer recipe, integer playerId, boolean notAvailable returns nothing
    local integer index = Index2D(recipe, playerId, bj_MAX_PLAYERS)
    set recipesNotAvailableForPlayer[index] = notAvailable
endfunction

function GetRecipeAvailableForPlayer takes integer recipe, integer playerId returns boolean
    local integer index = Index2D(recipe, playerId, bj_MAX_PLAYERS)
    return not recipesNotAvailableForPlayer[index]
endfunction

function SetRecipeAvailableForPlayer takes integer recipe, integer playerId, boolean available returns nothing
    local integer index = Index2D(recipe, playerId, bj_MAX_PLAYERS)
    set recipesNotAvailableForPlayer[index] = not available
endfunction

function GetLastCreatedRecipe takes nothing returns integer
    return lastCreatedRecipe
endfunction

function SetLastRecipePageName takes string pageName returns nothing
    set recipesPageName[lastCreatedRecipe] = pageName
endfunction

function GetRecipeRequirementsCount takes integer recipe returns integer
    return recipesRequirementCounters[recipe]
endfunction

function GetRecipeRequirementItemTypeId takes integer recipe, integer requirement returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    return recipesRequirementItemTypeIds[index]
endfunction

function GetRecipeRequirementCharges takes integer recipe, integer requirement returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    return recipesRequirementCharges[index]
endfunction

function GetRecipeRequirementConsume takes integer recipe, integer requirement returns boolean
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    return recipesRequirementConsume[index]
endfunction

function GetRecipeMinRequirements takes integer recipe returns integer
    return recipesMinRequirements[recipe]
endfunction

function SetRecipeMinRequirements takes integer recipe, integer minRequirements returns nothing
    set recipesMinRequirements[recipe] = minRequirements
endfunction

function SetRecipeRequirementCallback takes CraftingRequirementCallback callback returns nothing
    set recipeRequirementCallback = callback
endfunction

function SetRecipeRequirementCallbackTrigger takes trigger callback returns nothing
    set recipeRequirementCallbackTrigger = callback
endfunction

function SetRecipeShowCallbackTrigger takes trigger callback returns nothing
    set recipeShowCallbackTrigger = callback
endfunction

function TriggerRegisterItemCraftingEvent takes trigger whichTrigger returns integer
    local integer counter = craftingCallbackTriggersCounter
    set craftingCallbackTriggers[counter] = whichTrigger
    set craftingCallbackTriggersCounter = craftingCallbackTriggersCounter + 1
    return counter
endfunction

function TriggerRegisterUnitCraftingEvent takes trigger whichTrigger returns integer
    local integer counter = craftingCallbackUnitTriggersCounter
    set craftingCallbackUnitTriggers[counter] = whichTrigger
    set craftingCallbackUnitTriggersCounter = craftingCallbackUnitTriggersCounter + 1
    return counter
endfunction

function TriggerRegisterItemDisassembleEvent takes trigger whichTrigger returns integer
    local integer counter = disassembleCallbackTriggersCounter
    set disassembleCallbackTriggers[counter] = whichTrigger
    set disassembleCallbackTriggersCounter = disassembleCallbackTriggersCounter + 1
    return counter
endfunction

function GetTriggerRecipe takes nothing returns integer
    return triggerRecipe
endfunction

function GetTriggerCraftingUnit takes nothing returns unit
    return triggerCraftingUnit
endfunction

function GetTriggerCraftedItem takes nothing returns item
    return triggerCraftedItem
endfunction

function GetTriggerCraftedUnit takes nothing returns unit
    return triggerCraftedUnit
endfunction

function GetTriggerCraftedCharges takes nothing returns integer
    return triggerCraftedCharges
endfunction

private function ExecuteCraftingCallbacks takes integer recipe, unit craftingUnit, item craftedItem returns nothing
    local integer i = 0
    set triggerRecipe = recipe
    set triggerCraftingUnit = craftingUnit
    set triggerCraftedItem = craftedItem
    loop
        exitwhen (i == craftingCallbackTriggersCounter)
        if (IsTriggerEnabled(craftingCallbackTriggers[i])) then
            call ConditionalTriggerExecute(craftingCallbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteCraftingCallbacksUnit takes integer recipe, unit craftingUnit, unit craftedUnit returns nothing
    local integer i = 0
    set triggerRecipe = recipe
    set triggerCraftingUnit = craftingUnit
    set triggerCraftedUnit = craftedUnit
    loop
        exitwhen (i == craftingCallbackUnitTriggersCounter)
        if (IsTriggerEnabled(craftingCallbackUnitTriggers[i])) then
            call ConditionalTriggerExecute(craftingCallbackUnitTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ExecuteDisassembleCallbacks takes integer recipe, unit craftingUnit, item craftedItem, unit craftedUnit returns nothing
    local integer i = 0
    set triggerRecipe = recipe
    set triggerCraftingUnit = craftingUnit
    set triggerCraftedItem = craftedItem
    set triggerCraftedUnit = craftedUnit
    loop
        exitwhen (i == disassembleCallbackTriggersCounter)
        if (IsTriggerEnabled(disassembleCallbackTriggers[i])) then
            call ConditionalTriggerExecute(disassembleCallbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function GetRecipeByItemTypeId takes integer itemTypeId returns integer
    local integer counter = recipesCounter
    local integer recipe = 0
    loop
        exitwhen (recipe == counter)
        if (recipesItemTypeIds[recipe] == itemTypeId) then
            return recipe
        endif
        set recipe = recipe + 1
    endloop
    return -1
endfunction

private function SetItemCraftingUnitGroup takes unit whichUnit, group whichGroup returns nothing
    call SaveGroupHandle(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_GROUP, whichGroup)
endfunction

private function GetItemCraftingUnitGroup takes unit whichUnit returns group
    return LoadGroupHandle(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_GROUP)
endfunction

function IsItemCraftingRecipeEnabled takes unit whichUnit, integer recipe returns boolean
    local integer counter = LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES)
    local integer disabledRecipe = 0
    local integer i = 0
    loop
        exitwhen (i >= counter)
        set disabledRecipe = LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES + i)
        if (disabledRecipe == recipe) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

function GetRecipeName takes integer recipe returns string
    return GetObjectName(recipesUIItemTypeIds[recipe])
endfunction

private function CheckRecipeRequirement takes integer recipe, integer requirement, unit whichUnit, integer craftedCharges returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    local integer requiredItemTypeId = recipesRequirementItemTypeIds[index]
    local integer requiredCharges = recipesRequirementCharges[index]
    local integer matchingCharges = 0
    local item slotItem = null
    local integer i = 0
    local integer j = 0
    
    if (requiredItemTypeId != 0) then
        //call BJDebugMsg("CheckRecipeRequirement for recipe " + GetRecipeName(recipe) + " with requirement item " + GetObjectName(requiredItemTypeId))
    
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(whichUnit, i)
            if (slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId) then
                // check the callback for each charge separately
                set j = 0
                loop
                    exitwhen (j == IMaxBJ(GetItemCharges(slotItem), 1))
                    if (recipeRequirementCallbackTrigger != null) then
                        set triggerRecipe = recipe
                        set triggerCraftingUnit = whichUnit
                        set triggerCraftedItem = null
                        set triggerCraftedCharges = craftedCharges + matchingCharges / requiredCharges
                        exitwhen (not TriggerEvaluate(recipeRequirementCallbackTrigger))
                    endif
                    set matchingCharges = matchingCharges + 1
                    set j = j + 1
                endloop
                
                //call BJDebugMsg("CheckRecipeRequirement " + I2S(matchingCharges) + " for recipe " + GetRecipeName(recipe) + " with slot item " + GetItemName(slotItem))
            endif

            set slotItem = null
            set i = i + 1
        endloop
        //call BJDebugMsg("Checking recipe requirement for recipe " + GetRecipeName(recipe) + " with item type " + GetObjectName(requiredItemTypeId) + " and found charges: " + I2S(matchingCharges) + " resulting in " + I2S( matchingCharges / recipesRequirementCharges[index]))
        return matchingCharges / requiredCharges
    endif

    return 0
endfunction

private function ConsumeRecipeRequirement takes integer recipe, integer requirement, integer charges, unit whichUnit returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    local integer requiredItemTypeId = recipesRequirementItemTypeIds[index]
    local integer matchingCharges = 0
    local integer reducedCharges = 0
    local item slotItem = null
    local integer i = 0
    local group whichGroup = GetItemCraftingUnitGroup(whichUnit)
    local integer j = 0
    local unit groupUnit = null
    if (requiredItemTypeId != 0) then
        set j = 0
        loop
            exitwhen (j >= BlzGroupGetSize(whichGroup))
            set groupUnit = BlzGroupUnitAt(whichGroup, j)
            loop
                exitwhen (i == bj_MAX_INVENTORY)
                set slotItem = UnitItemInSlot(groupUnit, i)
                if (slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId) then
                    set reducedCharges = charges * recipesRequirementCharges[index]
                    set matchingCharges = matchingCharges + reducedCharges
                    //call BJDebugMsg("Consuming " + I2S(reducedCharges) + " of item " + GetItemName(slotItem) + " from unit " + GetUnitName(groupUnit) + ".")
                    set reducedCharges = GetItemCharges(slotItem) - reducedCharges
                    if (reducedCharges > 0) then
                        call SetItemCharges(slotItem, reducedCharges)
                    else
                        call RemoveItem(slotItem)
                    endif
                endif
                set i = i + 1
            endloop
            set groupUnit = null
            set j = j + 1
        endloop
    endif

    set whichGroup = null

    return reducedCharges
endfunction

private function CheckRecipeRequirements takes integer recipe, unit whichUnit returns integer
    local integer requirementCheckCounter = 0
    local integer result = 0
    local boolean initResult = false
    local integer matchingRequirements = 0
    local integer minRequirements = recipesMinRequirements[recipe]
    local integer counter = recipesRequirementCounters[recipe]
    local integer i = 0
    local group whichGroup = GetItemCraftingUnitGroup(whichUnit)
    local player owner = GetOwningPlayer(whichUnit)
    local integer j = 0

    if (recipeRequirementCallback != 0) then
        set result = recipeRequirementCallback.evaluate(recipe, whichUnit)
        //call BJDebugMsg("Result with custom callback " + I2S(result))
    endif

    loop
        exitwhen (i >= counter or matchingRequirements >= minRequirements)
        set j = 0
        loop
            exitwhen (j >= BlzGroupGetSize(whichGroup) or matchingRequirements >= minRequirements)
            set requirementCheckCounter = CheckRecipeRequirement(recipe, i, BlzGroupUnitAt(whichGroup, j), result)

            if (requirementCheckCounter > 0) then
                // TODO What if there is yet another requirement which has more charges?
                set matchingRequirements = matchingRequirements + 1
                if (not initResult) then // initially result is 0
                    set result = requirementCheckCounter
                else
                    set result = IMinBJ(result, requirementCheckCounter)
                endif
                
                //call BJDebugMsg("Checking recipe requirement for recipe " + GetRecipeName(recipe) + " and found charges: " + I2S(requirementCheckCounter) + " resulting in requirements matching " + I2S(matchingRequirements))
            endif
            //call BJDebugMsg("Result: " + I2S(result))
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set whichGroup = null
    
    // food check
    if (GetRecipeIsUnit(recipe)) then
        set result = IMinBJ((GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_CAP) - GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_USED)) / GetFoodUsed(recipesItemTypeIds[recipe]), result)
    endif
    
    set owner = null
    
    // make sure that it matches at least the number of minimum requirements is reached
    if (matchingRequirements >= minRequirements) then
        return result
    endif
    
    return 0
endfunction

private function ConsumeRecipeRequirements takes integer recipe, integer charges, unit whichUnit returns integer
    local integer result = 0
    local integer counter = recipesRequirementCounters[recipe]
    local integer matchingRequirements = 0
    local integer minRequirements = recipesMinRequirements[recipe]
    local integer consumedRequirements = 0
    local boolean consume = false
    local integer i = 0
    loop
        exitwhen (i == counter or matchingRequirements >= minRequirements)
        set consume = GetRecipeRequirementConsume(recipe, i)
        if (consume) then
            set consumedRequirements = ConsumeRecipeRequirement(recipe, i, charges, whichUnit)
            set result = result + consumedRequirements
        endif
        if (consumedRequirements > 0 or not consume) then
            set matchingRequirements = matchingRequirements + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetRecipeByUIItemTypeId takes integer uIItemTypeId returns integer
    local integer counter = recipesCounter
    local integer recipe = 0
    loop
        exitwhen (recipe == counter)
        if (recipesUIItemTypeIds[recipe] == uIItemTypeId) then
            return recipe
        endif
        set recipe = recipe + 1
    endloop
    return -1
endfunction

private function CheckAllRecipesRequirementsForPageEx takes unit whichUnit, integer page returns integer
    local integer result = 0
    local integer requirementCheckCounter = 0
    local integer startSlot = page * MAX_SLOTS
    local integer maxSlot = startSlot + MAX_SLOTS
    local integer slot = startSlot
    local integer recipe = 0
    local group whichGroup = GetItemCraftingUnitGroup(whichUnit)
    local integer j = 0
    local unit groupUnit = null
    //call BJDebugMsg("Checking " + I2S(counter) + " recipes for unit " + GetUnitName(whichUnit) + " at page " + I2S(page) + " with " + I2S(recipesPerPage) + " recipes per page.")
    loop
        exitwhen (slot >= maxSlot)
        if (not IsPagedButtonSpacer(whichUnit, slot)) then
            set recipe = GetRecipeByUIItemTypeId(GetPagedButtonId(whichUnit, slot))
            if (recipe != -1) then
                set requirementCheckCounter = CheckRecipeRequirements(recipe, whichUnit)
                //call BJDebugMsg("Get requirement counter " + I2S(requirementCheckCounter) + " and group size " + I2S(BlzGroupGetSize(whichGroup)))
                set j = 0
                loop
                    exitwhen (j >= BlzGroupGetSize(whichGroup))
                    set groupUnit = BlzGroupUnitAt(whichGroup, j)
                    if (IsItemCraftingRecipeEnabled(groupUnit, recipe)) then
                        //call BJDebugMsg("Item crafting is enabled." )
                        if (requirementCheckCounter > 0) then
                            set result = result + 1
                           
                            //call BJDebugMsg("Adding UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " to unit " + GetUnitName(groupUnit))
                            call RemoveItemFromStock(groupUnit, recipesUIItemTypeIds[recipe])
                            //call BJDebugMsg("Crafted item: " + GetObjectName(recipesUIItemTypeIds[recipe]) + " with stock " + I2S(requirementCheckCounter))
                            // Even although this is 2 it becomes like 1 or something by the paged buttons system?
                            call AddItemToStock(groupUnit, recipesUIItemTypeIds[recipe], requirementCheckCounter, requirementCheckCounter)
                        else
                            //call BJDebugMsg("Removing UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " from unit " + GetUnitName(groupUnit))
                            call RemoveItemFromStock(groupUnit, recipesUIItemTypeIds[recipe])
                            call AddItemToStock(groupUnit, recipesUIItemTypeIds[recipe], 0, 1)
                        endif
                    //else
                        //call BJDebugMsg("Item crafting is disabled." )
                    else
                        // Do not show when showing the page but only when trying to craft.
                        //call SimError(GetOwningPlayer(whichUnit), Format(GetLocalizedString("X_IS_DISABLED")).s(GetRecipeName(recipe)).result())
                    endif
                    set groupUnit = null
                    set j = j + 1
                endloop
            endif
        endif
        set slot = slot + 1
    endloop
    set whichGroup = null
    return result
endfunction

globals
    private unit tmpUnit = null
    private integer tmpInteger0 = 0
endglobals

private function CheckAllRecipesRequirementsForPageNewOpLimit takes nothing returns nothing
    call CheckAllRecipesRequirementsForPageEx(tmpUnit, tmpInteger0)
endfunction

private function CheckAllRecipesRequirementsForPage takes unit whichUnit, integer page returns nothing
    set tmpUnit = whichUnit
    set tmpInteger0 = page
    call NewOpLimit(function CheckAllRecipesRequirementsForPageNewOpLimit)
endfunction

private function UpdateStocks takes unit whichUnit returns nothing
    call CheckAllRecipesRequirementsForPage(whichUnit, GetPagedButtonsPage(whichUnit))
endfunction

private function ClearItemCraftingUnit takes unit whichUnit returns nothing
    local group whichGroup = GetItemCraftingUnitGroup(whichUnit)
    if (whichGroup != null) then
        call GroupRemoveUnit(whichGroup, whichUnit)
        if (BlzGroupGetSize(whichGroup) == 0) then
            call GroupClear(whichGroup)
            call DestroyGroup(whichGroup)
        endif
        set whichGroup = null
    endif

    call FlushChildHashtable(itemCraftingUnitsHashTable, GetHandleId(whichUnit))
endfunction

function SetItemCraftingRecipeEnabled takes unit whichUnit, integer recipe, boolean enabled returns nothing
    local integer page = GetPagedButtonsPage(whichUnit)
    local integer counter = LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES)
    local integer disabledRecipe = 0
    local boolean found = false
    local integer i = 0
    if (enabled) then
        loop
            exitwhen (i >= counter)
            set disabledRecipe = LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES + i)
            if (found == true) then
                call SaveInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES + i - 1, disabledRecipe)
            endif
            if (disabledRecipe == recipe) then
                set found = true
            endif
            set i = i + 1
        endloop
        if (found) then
            call SaveInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES, counter - 1)
        endif
    else
        loop
            exitwhen (i >= counter)
            set disabledRecipe = LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES + i)
            if (disabledRecipe == recipe) then
                set found = true
            endif
            set i = i + 1
        endloop
        if (not found) then
            call SaveInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES + counter, recipe)
            call SaveInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_DISABLED_RECIPES, counter + 1)
        endif
    endif
    call CheckAllRecipesRequirementsForPage(whichUnit, page)
endfunction

function CraftItem takes item soldItem, unit sellingUnit, unit buyingUnit returns item
    local integer page = GetPagedButtonsPage(sellingUnit)
    local integer soldItemTypeId = GetItemTypeId(soldItem)
    local player owner = GetOwningPlayer(sellingUnit)
    local player ownerBuying = GetOwningPlayer(buyingUnit)
    local integer playerIdBuying = GetPlayerId(ownerBuying)
    local integer charges = 0
    local integer chargesWithFoodLimit = 0
    local integer availableFood = 0
    local item craftedItem = null
    local unit craftedUnit = null
    local item array additionalCraftedItems
    local integer additionalCraftedItemsCounter = 0
    local integer counter = recipesCounter
    local integer j = 0
    local integer recipe = 0
    loop
        exitwhen (recipe >= counter and craftedItem != null)
        if (not GetRecipeIsSpacer(recipe) and recipesUIItemTypeIds[recipe] == soldItemTypeId) then
            call RemoveItem(soldItem)
            set soldItem = null
            if (GetRecipeAvailableForPlayer(recipe, playerIdBuying)) then
                set charges = CheckRecipeRequirements(recipe, sellingUnit)
                if (charges > 0) then
                    if (GetRecipeIsUnit(recipe)) then
                        set availableFood = GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_CAP) - GetPlayerState(owner, PLAYER_STATE_RESOURCE_FOOD_USED)
                        set chargesWithFoodLimit = availableFood / GetFoodUsed(recipesItemTypeIds[recipe])
                        set chargesWithFoodLimit = IMinBJ(chargesWithFoodLimit, charges)
                        if (chargesWithFoodLimit > 0) then
                            if (chargesWithFoodLimit < charges) then
                                call SimError(owner, Format(GetLocalizedString("CAN_ONLY_SUMMON_FOOD_LIMIT")).i(chargesWithFoodLimit).result())
                            endif
                        
                            set j = 0
                            loop
                                exitwhen (j >= chargesWithFoodLimit)
                                set craftedUnit = CreateUnit(owner, recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit), GetUnitFacing(sellingUnit))
                                call ExecuteCraftingCallbacksUnit(recipe, sellingUnit, craftedUnit)
                                set j = j + 1
                            endloop

                            call ConsumeRecipeRequirements(recipe, chargesWithFoodLimit, sellingUnit)
                        else
                            call SimError(owner, GetLocalizedString("NOT_ENOUGH_FOOD"))
                        endif
                    else
                        set craftedItem = CreateItem(recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit))
                        
                        if (GetItemCharges(craftedItem) > 0) then
                            call SetItemCharges(craftedItem, charges)
                            call ExecuteCraftingCallbacks(recipe, sellingUnit, craftedItem)
                        // create non charged items separately
                        else
                            call ExecuteCraftingCallbacks(recipe, sellingUnit, craftedItem)
                            
                            set j = 1
                            loop
                                exitwhen (j >= charges)
                                set craftedItem = CreateItem(recipesItemTypeIds[recipe], GetUnitX(sellingUnit), GetUnitY(sellingUnit))
                                call ExecuteCraftingCallbacks(recipe, sellingUnit, craftedItem)
                                set additionalCraftedItems[additionalCraftedItemsCounter] = craftedItem
                                set additionalCraftedItemsCounter = additionalCraftedItemsCounter + 1
                                set j = j + 1
                            endloop
                        endif
                        
                        call ConsumeRecipeRequirements(recipe, charges, sellingUnit)
                        
                        // add item after callbacks since it might lead to stacking and the crafted item may become null
                        // call ite also after consuming requirements since the inventory might have more slots now
                        call UnitAddItem(sellingUnit, craftedItem)
                        set j = 0
                        loop
                            exitwhen (j >= additionalCraftedItemsCounter)
                            call UnitAddItem(sellingUnit, additionalCraftedItems[j]) // TODO Drops the item next to the crafting unit.
                            set j = j + 1
                        endloop
                    endif
                else
                    call SimError(ownerBuying, Format(GetLocalizedString("MISSING_REQUIREMENTS_FOR_X")).s(GetObjectName(recipesItemTypeIds[recipe])).result())
                endif
            else
                call SimError(ownerBuying, Format(GetLocalizedString("X_IS_NOT_AVAILABLE")).s(GetObjectName(recipesItemTypeIds[recipe])).result())
            endif
            exitwhen (true) // found the matching recipe
        endif
        set recipe = recipe + 1
    endloop
    call CheckAllRecipesRequirementsForPage(sellingUnit, page) // update all stocks but after crafting something we might need some delay to update stocks.
    set owner = null
    set ownerBuying = null
    return craftedItem
endfunction

private function ForGroupUpdateStocks takes nothing returns nothing
    call UpdateStocks(GetEnumUnit())
endfunction

private function UpdateAllStocks takes nothing returns nothing
    call ForGroup(itemCraftingUnits, function ForGroupUpdateStocks)
endfunction

private function ShowRecipeForUnit takes integer recipe, unit whichUnit returns boolean
    if (recipeShowCallbackTrigger != null and IsTriggerEnabled(recipeShowCallbackTrigger)) then
        set triggerRecipe = recipe
        set triggerCraftingUnit = whichUnit
        return TriggerEvaluate(recipeShowCallbackTrigger)
    endif
    return true
endfunction

function EnableItemCraftingUnit takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    local integer i = 0
    local integer index = 0
    local group whichGroup = CreateGroup()
    call GroupAddUnit(whichGroup, whichUnit)
    call GroupAddUnit(itemCraftingUnits, whichUnit)
    call SetItemCraftingUnitGroup(whichUnit, whichGroup)
    //call BJDebugMsg("Enable crafting for unit " + GetUnitName(whichUnit))
    call EnablePagedButtons(whichUnit)
    call SetPagedButtonsSlotsPerPage(whichUnit, MAX_SLOTS)
    set i = 0
    loop
        exitwhen (i == recipesCounter)
        //call BJDebugMsg("Recipe " + I2S(i) + ": " + GetObjectName(recipesUIItemTypeIds[i]))
        if (GetRecipeAvailableForPlayer(i, playerId) and ShowRecipeForUnit(i, whichUnit)) then
            if (recipesIsSpacer[i]) then
                call SetPagedButtonsCurrentPageName(whichUnit, recipesPageName[i])
                call AddPagedButtonsSpacersRemaining(whichUnit)
            else
                if (recipesPageName[i] != null and StringLength(recipesPageName[i]) > 0) then
                    call SetPagedButtonsCurrentPageName(whichUnit, recipesPageName[i])
                endif
                set index = AddPagedButtonsItemType(whichUnit, recipesUIItemTypeIds[i])
                set PagedButtons_SlotType(GetPagedButton(whichUnit, index)).replenish = false // prevents auto replenish
            endif
        endif
        set i = i + 1
    endloop
    //call CheckAllRecipesRequirementsForPage(whichUnit, 0, PagedButtonsSystem_SLOTS_PER_PAGE)

    if (BlzGroupGetSize(itemCraftingUnits) == 1) then
        // This timer is required since we can only set the maximum time to 3600 seconds.
        call TimerStart(itemCraftingStockUpdateTimer, UPDATE_INTERVAL, true, function UpdateAllStocks)
    endif
endfunction

function IsItemCraftingUnitEnabled takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, itemCraftingUnits)
endfunction

function DisableItemCraftingUnit takes unit whichUnit returns boolean
    if (IsItemCraftingUnitEnabled(whichUnit)) then
        call GroupRemoveUnit(itemCraftingUnits, whichUnit)
        call DisablePagedButtons(whichUnit)

        call ClearItemCraftingUnit(whichUnit)

        if (BlzGroupGetSize(itemCraftingUnits) == 0) then
            call PauseTimer(itemCraftingStockUpdateTimer)
        endif
        
        return true
    endif
    return false
endfunction

function LinkItemCraftingUnitInventories takes unit whichUnit0, unit whichUnit1 returns group
    local group whichGroup0 = GetItemCraftingUnitGroup(whichUnit0)
    local group whichGroup1 = GetItemCraftingUnitGroup(whichUnit1)
    local integer i = 0

    if (whichGroup0 == null) then
        set whichGroup0 = CreateGroup()
        call GroupAddUnit(whichGroup0, whichUnit0)
    endif

    if (whichGroup1 == null) then
        set whichGroup1 = CreateGroup()
        call GroupAddUnit(whichGroup1, whichUnit1)
    endif

    if (whichGroup0 != null and whichGroup1 != null) then
        call GroupAddGroup(whichGroup1, whichGroup0)

        set i = 0
        loop
            exitwhen (i == BlzGroupGetSize(whichGroup0))
            call SetItemCraftingUnitGroup(BlzGroupUnitAt(whichGroup0, i), whichGroup0)
            set i = i + 1
        endloop
        call GroupClear(whichGroup1)
        call DestroyGroup(whichGroup1)
        set whichGroup1 = null
    endif
    
    call UpdateStocks(whichUnit0)
    call UpdateStocks(whichUnit1)

    return whichGroup0
endfunction

function LinkItemCraftingGroupInventories takes group source returns group
    local unit first = FirstOfGroup(source)
    local integer i = 1
    if (first != null) then
        loop
            exitwhen (i == BlzGroupGetSize(source))
            call LinkItemCraftingUnitInventories(BlzGroupUnitAt(source, i), first)
            set i = i + 1
        endloop
        set first = null
        return GetItemCraftingUnitGroup(first)
    endif
    return null
endfunction

function UnlinkItemCraftingUnitInventories takes unit whichUnit0, unit whichUnit1 returns group
    local group whichGroup0 = GetItemCraftingUnitGroup(whichUnit0)
    local group whichGroup1 = GetItemCraftingUnitGroup(whichUnit1)

    if (whichGroup0 != null) then
        call GroupRemoveUnit(whichGroup0, whichUnit1)
    endif

    if (whichGroup1 != null and IsUnitInGroup(whichUnit1, whichGroup1)) then
        call GroupRemoveUnit(whichGroup1, whichUnit1)
        if (BlzGroupGetSize(whichGroup1) == 0) then
            call GroupClear(whichGroup1)
            call DestroyGroup(whichGroup1)
            set whichGroup1 = null
        endif
    endif

    set whichGroup1 = CreateGroup()
    call GroupAddUnit(whichGroup1, whichUnit1)

    call SetItemCraftingUnitGroup(whichUnit1, whichGroup1)
    
    call UpdateStocks(whichUnit0)
    call UpdateStocks(whichUnit1)

    return whichGroup1
endfunction

function ItemCraftingUnitInventoriesAreLinked takes unit whichUnit0, unit whichUnit1 returns boolean
    local group whichGroup0 = GetItemCraftingUnitGroup(whichUnit0)

    return IsUnitInGroup(whichUnit1, whichGroup0)
endfunction

private function TriggerConditionIsItemCraftingUnitEnabled takes nothing returns boolean
    return IsItemCraftingUnitEnabled(GetTriggerUnit())
endfunction

private function TriggerActionCheckAllRecipesRequirements takes nothing returns nothing
    //call BJDebugMsg("Crafter " + GetUnitName(GetTriggerUnit()) + " picks up or drops an item.")
    call UpdateStocks(GetTriggerUnit())
endfunction

private function TriggerActionCheckAllRecipesRequirementsDelayed takes nothing returns nothing
    //call BJDebugMsg("Crafter " + GetUnitName(GetTriggerUnit()) + " picks up or drops an item.")
    local unit triggerUnit = GetTriggerUnit()
    call TriggerSleepAction(0.0) // wait until item has been dropped
    call UpdateStocks(triggerUnit)
    set triggerUnit = null
endfunction

private function TriggerActionCraftItem takes nothing returns nothing
    local unit shop = GetSellingUnit()
    call CraftItem(GetSoldItem(), shop, GetBuyingUnit())
    call TriggerSleepAction(0.0) // wait until we can refresh the stock
    call UpdateStocks(shop)
    set shop = null
endfunction

private function TriggerConditionDisassemble takes nothing returns boolean
    return GetSpellAbilityId() == DISASSEMBLE_ABILITY_ID
endfunction

function DisassembleItem takes item soldItem, unit sellingUnit returns integer
    local integer recipe = GetRecipeByItemTypeId(GetItemTypeId(soldItem))
    local integer i = 0
    local integer max = 0
    local integer count = IMaxBJ(GetItemCharges(soldItem), 1)
    local integer charges = 0
    local item requirement = null
    local integer minRequirements = 0
    local integer result = 0
    
    if (recipe != -1) then
        call ExecuteDisassembleCallbacks(recipe, sellingUnit, soldItem, null)
        call RemoveItem(soldItem)
        set soldItem = null
        set i = 0
        set max = GetRecipeRequirementsCount(recipe)
        set minRequirements = GetRecipeMinRequirements(recipe)
        loop
            exitwhen (i == max or (minRequirements > 0 and i > minRequirements))
            set requirement = CreateItem(GetRecipeRequirementItemTypeId(recipe, i), GetUnitX(sellingUnit), GetUnitY(sellingUnit))
            set charges = GetRecipeRequirementCharges(recipe, i) * count
            if (GetItemCharges(requirement) > 0 or charges > 1) then
                call SetItemCharges(requirement, charges)
            endif
            call UnitAddItem(sellingUnit, requirement)
            set result = result + charges
            set i = i + 1
        endloop
    endif
    
    return result
endfunction

function DisassembleUnit takes unit target, unit sellingUnit returns integer
    local integer recipe = GetRecipeByItemTypeId(GetUnitTypeId(target))
    local integer i = 0
    local integer max = 0
    local integer count = 1
    local integer charges = 0
    local item requirement = null
    local integer minRequirements = 0
    local integer result = 0
    
    if (recipe != -1) then
        call ExecuteDisassembleCallbacks(recipe, sellingUnit, null, target)
        call RemoveUnit(target)
        set target = null
        set i = 0
        set max = GetRecipeRequirementsCount(recipe)
        set minRequirements = GetRecipeMinRequirements(recipe)
        loop
            exitwhen (i == max or (minRequirements > 0 and i > minRequirements))
            set requirement = CreateItem(GetRecipeRequirementItemTypeId(recipe, i), GetUnitX(sellingUnit), GetUnitY(sellingUnit))
            set charges = GetRecipeRequirementCharges(recipe, i) * count
            if (GetItemCharges(requirement) > 0 or charges > 1) then
                call SetItemCharges(requirement, charges)
            endif
            call UnitAddItem(sellingUnit, requirement)
            set result = result + charges
            set i = i + 1
        endloop
    endif
    
    return result
endfunction

private function TriggerActionDisassembleItem takes nothing returns nothing
    local unit sellingUnit = GetTriggerUnit()
    local unit target = GetSpellTargetUnit()
    local item targetItem = GetSpellTargetItem()
    local item slotItem = null
    local integer counter = 0
    local integer i = 0
    if (target != null) then
        if (IsItemCraftingUnitEnabled(target) and GetOwningPlayer(sellingUnit) == GetOwningPlayer(target)) then
            loop
                exitwhen (i == bj_MAX_INVENTORY)
                set slotItem = UnitItemInSlot(sellingUnit, i)
                if (slotItem != null) then
                    set counter = counter + DisassembleItem(slotItem, sellingUnit)
                endif
                set slotItem = null
                set i = i + 1
            endloop
            if (counter == 0) then
                call SimError(GetOwningPlayer(sellingUnit), GetLocalizedString("NO_ITEMS_TO_DISASSEMBLE"))
            endif
        else
            set counter = DisassembleUnit(target, sellingUnit)
            if (counter == 0) then
                call SimError(GetOwningPlayer(sellingUnit), GetLocalizedString("CANNOT_BE_DISASSEMBLED"))
            endif
        endif
    elseif (targetItem != null) then
        set counter = DisassembleItem(targetItem, sellingUnit)
        if (counter == 0) then
            call SimError(GetOwningPlayer(sellingUnit), GetLocalizedString("CANNOT_BE_DISASSEMBLED"))
        endif
    endif
    set sellingUnit = null
    set target = null
    set targetItem = null
endfunction

private function TriggerConditionChangePage takes nothing returns boolean
    return IsItemCraftingUnitEnabled(GetTriggerShop())
endfunction

private function TriggerActionChangePage takes nothing returns nothing
    call UpdateStocks(GetTriggerShop())
endfunction

private function TriggerConditionTrainStart takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction
    
private function TriggerConditionTrainCancel takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction
    
private function TriggerConditionReviveStart takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction
    
private function TriggerConditionReviveCancel takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction
    
private function TriggerConditionSell takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction
    
private function TriggerConditionDeath takes nothing returns boolean
    call UpdateAllStocks()
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupTrigger, Condition(function TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(pickupTrigger, function TriggerActionCheckAllRecipesRequirements)
    
    call TriggerRegisterAnyUnitEventBJ(dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropTrigger, Condition(function TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(dropTrigger, function TriggerActionCheckAllRecipesRequirementsDelayed)

    call TriggerRegisterAnyUnitEventBJ(itemCraftTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(itemCraftTrigger, Condition(function TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(itemCraftTrigger, function TriggerActionCraftItem)
    
    call TriggerRegisterAnyUnitEventBJ(itemDisassembleTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(itemDisassembleTrigger, Condition(function TriggerConditionDisassemble))
    call TriggerAddAction(itemDisassembleTrigger, function TriggerActionDisassembleItem)

    call TriggerRegisterChangePagedButtons(itemCraftingChangePageTrigger)
    call TriggerAddCondition(itemCraftingChangePageTrigger, Condition(function TriggerConditionChangePage))
    call TriggerAddAction(itemCraftingChangePageTrigger, function TriggerActionChangePage)
    
    // update food available
    call TriggerRegisterAnyUnitEventBJ(trainStartTrigger, EVENT_PLAYER_UNIT_TRAIN_START)
    call TriggerAddCondition(trainStartTrigger, Condition(function TriggerConditionTrainStart))
    
    call TriggerRegisterAnyUnitEventBJ(trainCancelTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(trainCancelTrigger, Condition(function TriggerConditionTrainCancel))
    
    call TriggerRegisterAnyUnitEventBJ(reviveStartTrigger, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerAddCondition(reviveStartTrigger, Condition(function TriggerConditionReviveStart))
    
    call TriggerRegisterAnyUnitEventBJ(reviveCancelTrigger, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    call TriggerAddCondition(reviveCancelTrigger, Condition(function TriggerConditionReviveCancel))
    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

hook RemoveUnit DisableItemCraftingUnit

endlibrary
