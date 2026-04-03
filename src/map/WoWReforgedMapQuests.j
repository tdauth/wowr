library WoWReforgedMapQuests initializer Init requires WoWReforgedQuests

private function Init takes nothing returns nothing
    set udg_MainQuest[1] = AddQuest("MainQuest1", GetLocalizedStringSafe("ARCHIMONDE"), GetLocalizedStringSafe("QUEST_ARCHIMONDE_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNArchimonde.blp", gg_unit_Hjai_0012, 'I027')
    call AddQuestItem(GetLocalizedStringSafe("Q_ARCHIMONDE_0"))

    // Human Quests
    set udg_HumanQuestPingTarget = GetRectCenter(gg_rct_Human_Quest_1_discover_and_complete)
    set udg_HumanQuest[1] = AddQuest("HumanQuest1", GetLocalizedStringSafe("Q_DRAGON_SLAYER_TITLE"), GetLocalizedStringSafe("Q_DRAGON_SLAYER_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNRedDragon.blp", gg_unit_Haah_2745, ITEM_RING_OF_THE_ARCHMAGI)
    call AddQuestItem(GetLocalizedStringSafe("Q_DRAGON_SLAYER_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_DRAGON_SLAYER_1"))
    set udg_HumanQuest[2] = AddQuestNext("HumanQuest2", GetLocalizedStringSafe("Q_GOLEM_FACTORY_TITLE"), GetLocalizedStringSafe("Q_GOLEM_FACTORY_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNArmorGolem.blp", gg_unit_H006_0527, ITEM_BLADEBADE_ARMOR)
    call AddQuestItem(GetLocalizedStringSafe("Q_GOLEM_FACTORY_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_GOLEM_FACTORY_1"))
    set udg_HumanQuest[3] = AddQuestNext("HumanQuest3", GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_TITLE"), GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNAvatar.blp", gg_unit_H006_0527, ITEM_MURADINS_AXE)
    call AddQuestItem(GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_1"))
    set udg_HumanQuest[4] = AddQuestNext("HumanQuest4", GetLocalizedStringSafe("Q_CRUSADE_TITLE"), GetLocalizedStringSafe("Q_CRUSADE_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNHeroPaladin.blp", gg_unit_H005_0528, ITEM_ROYAL_PALADIN_HAMMER)
    call AddQuestItem(GetLocalizedStringSafe("Q_CRUSADE_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_CRUSADE_1"))

    // Village Quests
    set udg_VillageQuestPingTarget = GetRectCenter(gg_rct_Village_Quest_1_Discover)
    set udg_Village_Quest[1] = AddQuest("VillageQuest1", GetLocalizedStringSafe("Q_BANDIT_LORD_TITLE"), GetLocalizedStringSafe("Q_BANDIT_LORD_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNSorceressMaster.blp", gg_unit_N0O1_3203, ITEM_MEDAILLION_OF_COURAGE)
    call AddQuestItem(GetLocalizedStringSafe("Q_BANDIT_LORD_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_BANDIT_LORD_1"))
    set udg_Village_Quest[2] = AddQuestNext("VillageQuest2", GetLocalizedStringSafe("Q_FIEF_TITLE"), GetLocalizedStringSafe("Q_FIEF_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNFootman.blp", gg_unit_N0O1_3203, ITEM_HELM_OF_BATTLETHIRST)
    call AddQuestItem(GetLocalizedStringSafe("Q_FIEF_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_FIEF_1"))
    set udg_Village_Quest[3] = AddQuestNext("VillageQuest3", GetLocalizedStringSafe("Q_HARVEST_TITLE"), GetLocalizedStringSafe("Q_HARVEST_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNWheat.blp", gg_unit_N0O1_3203, ITEM_UNLIMITED_BAG_OF_FOOD)
    call AddQuestItem(GetLocalizedStringSafe("Q_HARVEST_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_HARVEST_1"))
    call AddQuestItem(GetLocalizedStringSafe("Q_HARVEST_2"))
    call AddQuestItem(GetLocalizedStringSafe("Q_HARVEST_3"))
    call AddQuestItem(GetLocalizedStringSafe("Q_HARVEST_4"))
    set udg_Village_Quest[4] = AddQuestNext("VillageQuest4", GetLocalizedStringSafe("Q_THE_PLAGUE_TITLE"), GetLocalizedStringSafe("Q_THE_PLAGUE_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNWheat.blp", gg_unit_N0O1_3203, ITEM_ENCHANTED_VIAL)
    call AddQuestItem(GetLocalizedStringSafe("Q_THE_PLAGUE_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_THE_PLAGUE_1"))
    call AddQuestItem(GetLocalizedStringSafe("Q_THE_PLAGUE_2"))

    // Dalaran Quests
    set udg_DalaranQuestPingTarget = GetRectCenter(gg_rct_Dalaran_Quest_1_Discover)
    set udg_Dalaran_Quest[1] = AddQuest("DalaranQuest1", GetLocalizedStringSafe("Q_RECONSTRUCTION_TITLE"), GetLocalizedStringSafe("Q_RECONSTRUCTION_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNGeneradorazul.blp", gg_unit_H08B_1934, 'pmna')
    call AddQuestItem(GetLocalizedStringSafe("Q_RECONSTRUCTION_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_RECONSTRUCTION_1"))

    set udg_Dalaran_Quest[1] = AddQuestNext("DalaranQuest2", GetLocalizedStringSafe("Q_FIRE_ELEMENTAL_TITLE"), GetLocalizedStringSafe("Q_FIRE_ELEMENTAL_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNFireSpawn.blp", gg_unit_H08B_1934, 'mnsf')
    call AddQuestItem(GetLocalizedStringSafe("Q_FIRE_ELEMENTAL_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_FIRE_ELEMENTAL_1"))

    set udg_Dalaran_Quest[3] = AddQuestNext("DalaranQuest3", GetLocalizedStringSafe("Q_ARCANE_MAGIC_TITLE"), GetLocalizedStringSafe("Q_ARCANE_MAGIC_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNFeedBack.blp", gg_unit_H08B_1934, 'amrc')
    call AddQuestItem(GetLocalizedStringSafe("Q_ARCANE_MAGIC_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_ARCANE_MAGIC_1"))

    set udg_Dalaran_Quest[3] = AddQuestNext("DalaranQuest4", GetLocalizedStringSafe("Q_SIEGE_OF_DALARAN_TITLE"), GetLocalizedStringSafe("Q_SIEGE_OF_DALARAN_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNArcaneCastle.blp", gg_unit_H08B_1934, 'rwiz')
    call AddQuestItem(GetLocalizedStringSafe("Q_SIEGE_OF_DALARAN_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_SIEGE_OF_DALARAN_1"))
endfunction

endlibrary
