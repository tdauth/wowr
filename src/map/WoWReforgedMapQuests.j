library WoWReforgedMapQuests initializer Init requires WoWReforgedQuests

private function Init takes nothing returns nothing
    // Human Quests
    set udg_HumanQuestPingTarget = GetRectCenter(gg_rct_Human_Quest_1_discover_and_complete)
    set udg_HumanQuest[1] = AddQuest("HumanQuest1", GetLocalizedStringSafe("Q_DRAGON_SLAYER_TITLE"), GetLocalizedStringSafe("Q_DRAGON_SLAYER_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNRedDragon.blp", gg_unit_Haah_2745, 'ram4')
    call AddQuestItem(GetLocalizedStringSafe("Q_DRAGON_SLAYER_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_DRAGON_SLAYER_1"))
    set udg_HumanQuest[2] = AddQuestNext("HumanQuest2", GetLocalizedStringSafe("Q_GOLEM_FACTORY_TITLE"), GetLocalizedStringSafe("Q_GOLEM_FACTORY_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNArmorGolem.blp", gg_unit_H006_0527, 'blba')
    call AddQuestItem(GetLocalizedStringSafe("Q_GOLEM_FACTORY_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_GOLEM_FACTORY_1"))
    set udg_HumanQuest[3] = AddQuestNext("HumanQuest3", GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_TITLE"), GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNAvatar.blp", gg_unit_H006_0527, 'I01B')
    call AddQuestItem(GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_SEARCH_FOR_MURADIN_1"))
    set udg_HumanQuest[4] = AddQuestNext("HumanQuest4", GetLocalizedStringSafe("Q_CRUSADE_TITLE"), GetLocalizedStringSafe("Q_CRUSADE_DESCRIPTION"), "ReplaceableTextures\\CommandButtons\\BTNHeroPaladin.blp", gg_unit_H005_0528, 'I01C')
    call AddQuestItem(GetLocalizedStringSafe("Q_CRUSADE_0"))
    call AddQuestItem(GetLocalizedStringSafe("Q_CRUSADE_1"))
endfunction

endlibrary
