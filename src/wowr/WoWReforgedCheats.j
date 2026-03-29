library WoWReforgedCheats requires Ascii, WoWReforgedUtils, WoWReforgedSaveCodeObjects, WoWReforgedHeroes, WoWReforgedBosses, WoWReforgedQuests, WoWReforgedProfessions, WoWReforgedCinematic, optional OrdersWatcher

function GetHelpTextCheats takes nothing returns string
    return "-cheats, -nocheats, -creeps, -cinoutro, -cinlichking, -cinoldgods, -cininvasion, -boots, -terrain, -heroskills, -bonus, -quests, -fields, -read, -write, -maxresources, -respawngroupcounter, -respawnall, -maxlevel, -levelX, -col, -medivh, -revive, -resetrepick, -demigodlight, -demigoddark, -trydemigod, -orderon, -orderoff, -kill, -fill, -share, -unitinfo, -checksave, -generatesave, -savecounters, -savecodeduplicates, -savecodemissing, -combination, -autoskill, -orbs, -herolevels, -deathwing, -claws, -clawsbonus, -regennight, -craft, -legendary, -professions, -achievementscheat, -aigui, -aicraft, -aiharveston/off, -day, -night, -jaina, -arena, -evolution, -evolutioncreeps, -nagaquest4, -website"
endfunction

function CheatUnfreeze takes nothing returns nothing
    call PauseAllUnitsBJ(false)
endfunction

private function EnumRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function CheatNoCreeps takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_AGGRESSIVE)), function EnumRemoveUnit)
    call BJDebugMsg("Removed all creeps.")
endfunction

function CheatNoBosses takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(udg_BossesPlayer), function EnumRemoveUnit)
    call BJDebugMsg("Removed all bosses.")
endfunction

function CheatNoPassive takes nothing returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_PASSIVE)), function EnumRemoveUnit)
    call BJDebugMsg("Removed all passive.")
endfunction

function CheatLegendaryItems takes player whichPlayer returns nothing
    local unit hero = GetPlayerHero1(whichPlayer)
    local item whichItem = null
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (udg_LegendaryItemType[i] != 0) then
            set whichItem = UnitAddItemById(hero, udg_LegendaryItemType[i])
        else
            call BJDebugMsg("Warning: Legendary item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

function CheatItems takes player whichPlayer returns nothing
    local unit hero = GetPlayerHero1(whichPlayer)
    local item whichItem = null
    local integer i = 0
    local integer max = GetSaveObjectItemMax()
    
    // contain race and profession items
    set i = 1
    loop
        exitwhen (i == max)
        if (GetSaveObjectItemId(i) != 0) then
            set whichItem = UnitAddItemById(hero, GetSaveObjectItemId(i))
            if (GetItemCharges(whichItem) > 0) then
                call SetItemCharges(whichItem, 100)
            endif
        else
            call BJDebugMsg("Warning: Item save object with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
    
    call CheatLegendaryItems(whichPlayer)
    
    set i = 0
    set max = GetQuestsMax()
    loop
        exitwhen (i == max)
        if (GetQuestReward(i) != 0) then
            set whichItem = UnitAddItemById(hero, GetQuestReward(i))
        else
            call BJDebugMsg("Warning: Quest reward item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

function CheatMaxResources takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        call SetPlayerResource(whichPlayer, GetResource(i), 9999999)
        set i = i + 1
    endloop
endfunction

function CheatHeroSkills takes player whichPlayer returns nothing
    local unit hero = null
    local integer i = 0
    local integer max = GetHeroesMax()
    loop
        exitwhen (i == max)
        set hero = CreateUnit(whichPlayer, GetHeroUnitType(i), 0.0, 0.0, 0.0)
        call SetHeroLevel(hero, MAX_HERO_LEVEL, false)
        call AutoSkillHero(hero)
        call RemoveUnit(hero)
        set hero = null
        set i = i + 1
    endloop
    set i = 0
    set max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i == max)
        set hero = CreateUnit(whichPlayer, GetUnitTypeId(BlzGroupUnitAt(udg_Bosses, i)), 0.0, 0.0, 0.0)
        call SetHeroLevel(hero, MAX_HERO_LEVEL, false)
        call AutoSkillHero(hero)
        call RemoveUnit(hero)
        set hero = null
        set i = i + 1
    endloop
endfunction

private function ForGroupCheckSaveCodeMissing takes nothing returns nothing
    local integer unitTypeId = GetUnitTypeId(GetEnumUnit())
    local integer index = GetSaveObjectUnitType(unitTypeId)
    
    if (index == -1) then
        set index = GetSaveObjectBuildingType(unitTypeId)
    endif
    
    if (index == -1) then
        call BJDebugMsg("Missing save code for unit type " + GetObjectName(unitTypeId))
    endif
endfunction

private function ForItemGroupCheckSaveCodeMissing takes nothing returns nothing
    local integer unitTypeId = GetItemTypeId(GetEnumItem())
    local integer index = GetSaveObjectItemType(unitTypeId)
    
    if (index == -1) then
        call BJDebugMsg("Missing save code for item type " + GetObjectName(unitTypeId))
    endif
endfunction

function CheatSaveCodeMissing takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_AGGRESSIVE), null)
    call ForGroup(g, function ForGroupCheckSaveCodeMissing)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    
    call EnumItemsInRect(GetPlayableMapRect(), null, function ForItemGroupCheckSaveCodeMissing)
endfunction

private function PrintProfession takes integer p returns nothing
    local integer i = 0
    local integer max = PROFESSION_RANK_MAX
    local integer j = 0
    local integer max2 = 0
    call BJDebugMsg("- " + GetProfessionName(p))
    loop
        exitwhen (i >= max)
        set j = 0
        set max2 = GetProfessionCraftedItemsCount(p, i)
        call BJDebugMsg(GetProfessionName(p) + " Rank " + GetRankName(i) + " with count " + I2S(max2))
        loop
            exitwhen (j >= max2)
            if (GetProfessionCraftedUnit(p, i, j) != 0) then
                call BJDebugMsg(GetProfessionName(p) + " " + GetObjectName(GetProfessionCraftedUnit(p, i, j)) + " with count " + I2S(GetProfessionCraftedCount(p, i, j)))
            elseif (GetProfessionCraftedItem(p, i, j) != 0) then
                call BJDebugMsg(GetProfessionName(p) + " " + GetObjectName(GetProfessionCraftedItem(p, i, j)) + " with count " + I2S(GetProfessionCraftedCount(p, i, j)))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function CheatProfessions takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i == max)
        call PrintProfession(i)
        set i = i + 1
    endloop
endfunction

function CheatBoots takes player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Created Boots of Teleportation for your first hero.")
    if (GetPlayerHero1(whichPlayer) != null) then
        call UnitAddItemById(GetPlayerHero1(whichPlayer), ITEM_BOOTS_OF_TELEPORTATION)
    endif
endfunction

function CheatTool takes player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Created Goblin Tool Box for your first hero.")
    if (GetPlayerHero1(whichPlayer) != null) then
        call UnitAddItemById(GetPlayerHero1(whichPlayer), ITEM_GOBLIN_TOOL_BOX)
    endif
endfunction

function CheatSpade takes player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Created Spade for your first hero.")
    if (GetPlayerHero1(whichPlayer) != null) then
        call UnitAddItemById(GetPlayerHero1(whichPlayer), ITEM_SPADE)
    endif
endfunction

function CheatTerrain takes player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Tile: " + A2S(GetTerrainType(GetCameraTargetPositionX(), GetCameraTargetPositionY())))
endfunction

function CheatOrderOn takes nothing returns nothing
static if (LIBRARY_OrdersWatcher) then
    call EnableOrderDebugger()
endif
endfunction

function CheatOrderOff takes nothing returns nothing
static if (LIBRARY_OrdersWatcher) then
    call DisableOrderDebugger()
endif
endfunction

endlibrary
