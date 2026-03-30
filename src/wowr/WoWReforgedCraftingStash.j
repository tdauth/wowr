library WoWReforgedCraftingStash initializer Init requires Crafting, WoWReforgedBosses, WoWReforgedMapLegendaryItems

globals
    private trigger castTrigger = CreateTrigger()
    private trigger craftItemTrigger = CreateTrigger()
    private trigger craftUnitTrigger = CreateTrigger()
    private trigger onRequirementTrigger = CreateTrigger()
    private trigger disassembleTrigger = CreateTrigger()
endglobals

private function AddRequirementsLegendaryItems takes integer r, integer charges returns nothing
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        call AddRecipeRequirementItem(r, GetLegendaryItemTypeId(i), charges, false)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0MZ') then
        if (IsItemCraftingUnitEnabled(GetSpellTargetUnit())) then
            if (ItemCraftingUnitInventoriesAreLinked(GetTriggerUnit(), GetSpellTargetUnit())) then
                call UnlinkItemCraftingUnitInventories(GetTriggerUnit(), GetSpellTargetUnit())
                call DisplayTextToForce( GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), GetLocalizedString("UNLINKED_CRAFTING_STASHES"))
                call PingUnitForPlayer(GetTriggerUnit(), GetOwningPlayer(GetTriggerUnit()))
                call PingUnitForPlayer(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit()))
            else
                call LinkItemCraftingUnitInventories(GetTriggerUnit(), GetSpellTargetUnit())
                call DisplayTextToForce( GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), GetLocalizedString("LINKED_CRAFTING_STASHES"))
                call PingUnitForPlayer(GetTriggerUnit(), GetOwningPlayer(GetTriggerUnit()))
                call PingUnitForPlayer(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit()))
            endif
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedStringSafe("TARGET_MUST_BE_A_CRAFTING_STASH"))
        endif
    endif
    return false
endfunction

private function CraftItemTriggerAction takes nothing returns nothing
    call CraftItemCook(GetTriggerCraftingUnit(), GetTriggerCraftedItem())
    call QuestMessageBJ(GetForceOfPlayer(GetOwningPlayer(GetTriggerCraftingUnit())), bj_QUESTMESSAGE_ITEMACQUIRED, Format(GetLocalizedStringSafe("CRAFTED_ITEM_X")).s(GetItemName(GetTriggerCraftedItem())).i(IMaxBJ(1, GetItemCharges(GetTriggerCraftedItem()))).result())
    call PingItemForPlayer(GetTriggerCraftedItem(), GetOwningPlayer(GetTriggerCraftingUnit()))
endfunction

private function CraftUnitTriggerAction takes nothing returns nothing
    call QuestMessageBJ(GetForceOfPlayer(GetOwningPlayer(GetTriggerCraftingUnit())), bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedStringSafe("CRAFTED_UNIT_X")).s(GetUnitName(GetTriggerCraftingUnit())).result())
    call PingUnitForPlayer(GetTriggerCraftingUnit(), GetOwningPlayer(GetTriggerCraftingUnit()))
endfunction

private function TriggerConditionOnRequirement takes nothing returns boolean
    if (GetTriggerRecipe() == udg_RecipeBootsOfTeleportation and GetUnitLegendaryItemsCount(GetTriggerCraftingUnit()) < 6) then
        //call BJDebugMsg("Boots of Teleportation with 6 legendary items! Counter " + I2S(GetUnitLegendaryItemsCount(GetTriggerCraftingUnit())))
        return false
    elseif (GetTriggerRecipe() == udg_RecipePotionOfGreaterHealing and not PlayerHasProfession(GetOwningPlayer(GetTriggerCraftingUnit()), udg_ProfessionHerbalist)) then
        return false
    elseif (GetTriggerRecipe() == udg_RecipePotionOfGreaterMana and not PlayerHasProfession(GetOwningPlayer(GetTriggerCraftingUnit()), udg_ProfessionAlchemist)) then
        return false
    elseif (GetTriggerRecipe() == udg_RecipeGoblinLandMines and not PlayerHasProfession(GetOwningPlayer(GetTriggerCraftingUnit()), udg_ProfessionDemolitionExpert)) then
        return false
    elseif (GetTriggerRecipe() >= udg_RecipeCooking and not PlayerHasProfession(GetOwningPlayer(GetTriggerCraftingUnit()), udg_ProfessionCook)) then
        return false
    endif
    return true
endfunction

private function TriggerActionOnDisassembleItem takes nothing returns nothing
    call QuestMessageBJ( GetForceOfPlayer(GetOwningPlayer(GetTriggerCraftingUnit())), bj_QUESTMESSAGE_ITEMACQUIRED, Format(GetLocalizedStringSafe("DISASSEMBLED_ITEM_X")).s(GetItemName(GetTriggerCraftedItem())).i(IMaxBJ(1, GetItemCharges(GetTriggerCraftedItem()))).result())
    call PingItemForPlayer(GetTriggerCraftedItem(), GetOwningPlayer(GetTriggerCraftingUnit()))
endfunction

private function Init takes nothing returns nothing
    local integer r = 0

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterItemCraftingEvent(craftItemTrigger)
    call TriggerAddAction(craftItemTrigger, function CraftItemTriggerAction)

    call TriggerRegisterUnitCraftingEvent(craftUnitTrigger)
    call TriggerAddAction(craftUnitTrigger, function CraftUnitTriggerAction)

    call SetRecipeRequirementCallbackTrigger(onRequirementTrigger)
    call TriggerAddCondition(onRequirementTrigger, Condition(function TriggerConditionOnRequirement))

    call TriggerRegisterItemDisassembleEvent(disassembleTrigger)
    call TriggerAddAction(disassembleTrigger, function TriggerActionOnDisassembleItem)

    // UNIQUE
    set udg_RecipeBootsOfTeleportation = AddRecipe(ITEM_BOOTS_OF_TELEPORTATION, 'I0YJ')
    call AddRequirementsLegendaryItems(r, 1)
    call SetRecipeMinRequirements(r, 6)

    // Spacer
    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_UNIQUE"))

    // ORBS
    // Orb of Orbs
    set r = AddRecipe(ITEM_ORB_OF_ORBS, 'I09A')
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_FROST, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_CORRUPTION, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_FIRE, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_FIRE_2, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_LIGHTNING, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_LIGHTNING_2, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_SLOW, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_VENOM, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_DARKNESS, 1, true)
    call AddRecipeRequirementItem(r, ITEM_DWARVEN_CELESTIAL_ORB_OF_SOULS, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_SUN, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_ENGINEERING, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_WIND, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_BLOOD, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_LIGHT, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_WEB, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_MAGIC, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_ANCESTORS, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_MOON, 1, true)
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_NATURE, 1, true)
    call SetRecipeMinRequirements(r, 6)

    set r = AddRecipe(ITEM_SHADOW_ORB_1, 'I0NV')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 1, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_2, 'I0NW')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 2, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_3, 'I0NX')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 3, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_4, 'I0NY')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 4, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_5, 'I0NZ')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 5, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_6, 'I0O0')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 6, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_ORBS"))

    set r = AddRecipe(ITEM_SHADOW_ORB_7, 'I0O1')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 7, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_8, 'I0O2')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 8, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_9, 'sor9')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 9, true)

    set r = AddRecipe(ITEM_SHADOW_ORB_10, 'sora')
    call AddRecipeRequirementItem(r, ITEM_SHADOW_ORB_FRAGMENT, 10, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_ORBS"))

    // MISC
    set r = AddRecipe(ITEM_GOLD_BARS, 'I096')
    call AddRecipeRequirementItem(r, ITEM_ORE_GOLD, 3, true)

    set r = AddRecipe(ITEM_SILVER_BARS, 'I0KR')
    call AddRecipeRequirementItem(r, ITEM_ORE_SILVER, 3, true)

    set r = AddRecipe(ITEM_IRON_BARS, 'I0H6')
    call AddRecipeRequirementItem(r, ITEM_ORE_IRON, 3, true)

    set r = AddRecipe(ITEM_BOARDS, 'I097')
    call AddRecipeRequirementItem(r, ITEM_BRANCH, 3, true)

    set udg_RecipeGoblinLandMines = AddRecipe(ITEM_GOBLIN_LAND_MINES, 'I09B')
    call AddRecipeRequirementItem(udg_RecipeGoblinLandMines, ITEM_BLACK_POWDER, 3, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_MISC"))

    // POTIONS
    set r = AddRecipe(ITEM_POTION_OF_HEALING, 'I093')
    call AddRecipeRequirementItem(r, ITEM_HEALING_HERB, 3, true)

    set udg_RecipePotionOfGreaterHealing = AddRecipe(ITEM_POTION_OF_GREATER_HEALING, 'I10Z')
    call AddRecipeRequirementItem(r, ITEM_HEALING_HERB, 5, true)

    set r = AddRecipe(ITEM_POTION_OF_MANA, 'I091')
    call AddRecipeRequirementItem(r, ITEM_MANA_HERB, 3, true)

    set udg_RecipePotionOfGreaterMana = AddRecipe(ITEM_POTION_OF_GREATER_MANA, 'I111')
    call AddRecipeRequirementItem(r, ITEM_MANA_HERB, 5, true)

    set r = AddRecipe(ITEM_POTION_OF_INVISIBILITY, 'I112')
    call AddRecipeRequirementItem(r, ITEM_HEALING_HERB, 3, true)
    call AddRecipeRequirementItem(r, ITEM_MANA_HERB, 3, true)

    set r = AddRecipe(ITEM_POTION_OF_GREATER_INVISIBILITY, 'I113')
    call AddRecipeRequirementItem(r, ITEM_HEALING_HERB, 5, true)
    call AddRecipeRequirementItem(r, ITEM_MANA_HERB, 5, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_POTIONS"))

    set r = AddRecipe(ITEM_POTION_OF_GREATER_RESTORATION, 'I098')
    call AddRecipeRequirementItem(r, ITEM_POTION_OF_GREATER_HEALING, 1, true)
    call AddRecipeRequirementItem(r, ITEM_POTION_OF_GREATER_MANA, 1, true)

    set r = AddRecipe(ITEM_RESTORATION_STONE, 'I099')
    call AddRecipeRequirementItem(r, ITEM_HEALTH_STONE, 1, true)
    call AddRecipeRequirementItem(r, ITEM_MANA_STONE, 1, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_POTIONS"))

    // SUMMONING
    set r = AddRecipe(ITEM_STONE_TOKEN, 'I094')
    call AddRecipeRequirementItem(r, ITEM_ROCKS, 3, true)

    set r = AddRecipe(ITEM_SPIKED_COLLAR, 'I0KJ')
    call AddRecipeRequirementItem(r, ITEM_SPIKE, 3, true)

    set r = AddRecipe(ITEM_DEMONIC_FIGURE, 'I0A0')
    call AddRecipeRequirementItem(r, ITEM_SPIKED_COLLAR, 3, true)

    set r = AddRecipe(ITEM_INFERNO_STONE, 'I0JO')
    call AddRecipeRequirementItem(r, ITEM_SPIKED_COLLAR, 2, true)
    call AddRecipeRequirementItem(r, ITEM_DEMONIC_FIGURE, 1, true)

    set r = AddRecipe(ITEM_ICE_SHARD, 'I0JQ')
    call AddRecipeRequirementItem(r, ITEM_ICE, 2, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_SUMMONING"))

    // PERMANENT
    set r = AddRecipe(ITEM_CLAWS_OF_ATTACK_12, 'I09W')
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_3, 1, true)
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_9, 1, true)

    set r = AddRecipe(ITEM_CLAWS_OF_ATTACK_15, 'I09X')
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_3, 1, true)
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_12, 1, true)

    set r = AddRecipe(ITEM_RING_OF_PROTECTION_3, 'I09Y')
    call AddRecipeRequirementItem(r, ITEM_RING_OF_PROTECTION_2, 1, true)
    call AddRecipeRequirementItem(r, ITEM_RING_OF_PROTECTION_1, 1, true)

    set r = AddRecipe(ITEM_RING_OF_PROTECTION_4, 'I09Z')
    call AddRecipeRequirementItem(r, ITEM_RING_OF_PROTECTION_3, 1, true)
    call AddRecipeRequirementItem(r, ITEM_RING_OF_PROTECTION_1, 1, true)

    set r = AddRecipe(ITEM_RING_OF_PROTECTION_8, 'I0RL')
    call AddRecipeRequirementItem(r, ITEM_RING_OF_PROTECTION_4, 2, true)

    set r = AddRecipe(ITEM_SHIELD_OF_HONOR, 'I0O7')
    call AddRecipeRequirementItem(r, ITEM_SILVER_BARS, 5, true)

    set r = AddRecipe(ITEM_ENCHANTED_SHIELD, 'I0OA')
    call AddRecipeRequirementItem(r, ITEM_IRON_BARS, 2, true)
    call AddRecipeRequirementItem(r, ITEM_SILVER_BARS, 2, true)

    set r = AddRecipe(ITEM_FROST_GUARD, 'I0O9')
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_12, 3, true)

    set r = AddRecipe(ITEM_FIREHAND_GAUNTLETS, 'I16D')
    call AddRecipeRequirementItem(r, ITEM_ORB_OF_FIRE_2, 3, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_PERMANENT"))

    set r = AddRecipe(ITEM_SEARING_BLADE, 'I0OB')
    call AddRecipeRequirementItem(r, ITEM_CLAWS_OF_ATTACK_12, 5, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_PERMANENT"))

    // DRAGONS
    set r = AddRecipe(RED_DRAGON, 'I0B0')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    set r = AddRecipe(GREEN_DRAGON, 'I0AL')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    set r = AddRecipe(BLACK_DRAGON, 'I0AM')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    set r = AddRecipe(BLUE_DRAGON, 'I0B2')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    set r = AddRecipe(BRONZE_DRAGON, 'I0AN')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    set r = AddRecipe(NETHER_DRAGON, 'I0B3')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DRAGON_EGG, 5, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_DRAGONS"))

    set r = AddRecipe(GUARD_OF_THE_OLD_GODS, 'I0OT')
    call SetRecipeIsUnit(r, true)
    call AddRecipeRequirementItem(r, ITEM_DIAMOND, 4, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_POWERFUL_CREATURES"))

    // COOK
    set r = AddRecipe(ITEM_FISH_MENU, 'I0WQ')
    call AddRecipeRequirementItem(r, ITEM_FISH, 3, true)
    call AddRecipeRequirementItem(r, ITEM_LEMON, 1, true)

    set r = AddRecipe(ITEM_WARRIOR_MENU, 'I0WZ')
    call AddRecipeRequirementItem(r, ITEM_MEAT, 5, true)
    call AddRecipeRequirementItem(r, ITEM_ORANGE, 2, true)

    set r = AddRecipe(ITEM_RANGER_MENU, 'I0X5')
    call AddRecipeRequirementItem(r, ITEM_BANANA, 5, true)
    call AddRecipeRequirementItem(r, ITEM_ORANGE, 2, true)

    set r = AddRecipe(ITEM_MAGICIAN_MENU, 'I0X6')
    call AddRecipeRequirementItem(r, ITEM_GARLIC, 5, true)
    call AddRecipeRequirementItem(r, ITEM_ORANGE, 2, true)

    call AddRecipeSpacer(GetLocalizedStringSafe("PAGE_TITLE_COOKING"))
endfunction

endlibrary
