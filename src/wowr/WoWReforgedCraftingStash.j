library WoWReforgedCraftingStash requires Crafting, WoWReforgedBosses

function AddCraftingStash takes unit whichUnit returns nothing
    local integer i = udg_RecipeCooking
    local integer max = GetRecipesMax()
    call EnableItemCraftingUnit(whichUnit)
    loop
        exitwhen (i >= max)
        call SetItemCraftingRecipeEnabled(whichUnit, i, false)
        set i = i + 1
    endloop
endfunction

function AddRequirementsLegendaryItems takes nothing returns nothing
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        call AddRecipeRequirementItem(udg_TmpInteger, GetLegendaryItemTypeId(i), udg_TmpInteger2, false)
        set i = i + 1
    endloop
    set udg_TmpInteger2 = 1
endfunction

function AddRecipeWoWReforged takes nothing returns integer
    set udg_TmpInteger = AddRecipe(udg_TmpItemTypeId, udg_TmpItemTypeId2)
    set udg_TmpInteger2 = 1
    return udg_TmpInteger
endfunction

function AddRecipeUnitWoWReforged takes nothing returns integer
    set udg_TmpInteger = AddRecipe(udg_TmpUnitType, udg_TmpItemTypeId2)
    call SetRecipeIsUnit(udg_TmpInteger, true)
    set udg_TmpInteger2 = 1
    return udg_TmpInteger
endfunction

function AddRecipeRequirementWoWReforged takes nothing returns integer
    local integer requirement = AddRecipeRequirementItem(udg_TmpInteger, udg_TmpItemTypeId, udg_TmpInteger2, true)
    set udg_TmpInteger2 = 1
    return requirement
endfunction

function AddRecipeRequirementWoWReforgedNonConsuming takes nothing returns integer
    local integer requirement = AddRecipeRequirementItem(udg_TmpInteger, udg_TmpItemTypeId, udg_TmpInteger2, false)
    set udg_TmpInteger2 = 1
    return requirement
endfunction

function SetRecipeMinRequirementsWoWReforged takes nothing returns nothing
    call SetRecipeMinRequirements(udg_TmpInteger, udg_TmpInteger2)
endfunction

endlibrary
