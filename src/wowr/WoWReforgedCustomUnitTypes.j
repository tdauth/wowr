library WoWReforgedCustomUnitTypes initializer Init requires CustomUnitTypes, UnitGroupRespawnSystem, UnitGroupRespawnSystemConfig, WoWReforgedAutoSkill, WoWReforgedPortals, WoWReforgedHeroes, WoWReforgedBosses, WoWReforgedRaces, WoWReforgedProfessions, WoWReforgedResources, WoWReforgedProperties, WoWReforgedSkins, WoWReforgedArmory, WoWReforgedTaverns, WoWReforgedSummonedUnits, WoWReforgedGaia, WoWReforgedChests, WoWReforegdHideout, WoWReforgedTrainer, WoWReforgedProfessionHunter, WoWReforgedCommandButtons, WoWReforgedGoldMines, WoWReforgedLevers, WoWReforgedRandomCorpse, WoWReforgedProfessionBooksShop, WoWReforgedSceptersShop, WoWReforgedBanners, WoWReforgedVIPs, WoWReforgedAlchemistLab, WoWReforgedMounts, WoWReforgedCraftingStash, WoWReforgedMapData

private function AddCustomMine takes unit whichUnit returns nothing
    local integer index = GetMineTypeIndex(GetUnitTypeId(whichUnit))
    if (index != -1) then
        call CreateMine(whichUnit, index)
    endif
endfunction

private function AddCustomProperty takes unit whichUnit returns nothing
    local integer index = GetPropertyIndexByUnitTypeId(GetUnitTypeId(whichUnit))
    if (index != -1) then
        call AddUnitProperty(whichUnit, index)
    endif
endfunction

private function AddTentacle takes unit whichUnit returns nothing
    call AddSummonedUnitBonus(whichUnit, MAX_HERO_SPELL_LEVEL)
endfunction

private struct CustomUnitTypePlayerHideout extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call SetPlayerHideout(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeFishSchool extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddFishSchool(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeBerryBush extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddBerryBush(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypePortal extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call UpdatePortalNameByItself(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddCustomMine extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddCustomMine(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddProperty extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddCustomProperty(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeHideLibrary extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call HideLibrary(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddResourcesShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddResourcesShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddAntimagicWard extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddAntimagicWard(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddBannersShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddBannersShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddMountsShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddMountsShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddSceptersShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddSceptersShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddProfessionBooksShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddProfessionBooksShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddTrainer extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddTrainer(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddSkinsShop extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddSkinsShop(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddArmory extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddArmory(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddChest extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddChest(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeEnableItemCraftingUnit extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        local integer i = udg_RecipeCooking
        local integer max = GetRecipesMax()
        call EnableItemCraftingUnit(whichUnit)
        loop
            exitwhen (i >= max)
            call SetItemCraftingRecipeEnabled(whichUnit, i, false)
            set i = i + 1
        endloop
    endmethod

endstruct

private struct CustomUnitTypeAddAlchemistLab extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddAlchemistLab(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddGameModesTavern extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddGameModesTavern(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddHeroesTavern extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddHeroesTavern(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddRacesTavern extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddRacesTavern(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddProfessionsTavern extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddProfessionsTavern(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddStartLocationsTavern extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddStartLocationsTavern(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeCreateRandomMine extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call CreateRandomMine(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeCreateRandomWaterMine extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call CreateRandomWaterMine(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeReplaceRandomCorpse extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call ReplaceRandomCorpse(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddGoldMine extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddGoldMine(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddRecordPlayer extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddRecordPlayer(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddRespawnUnit extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddRespawnUnit(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeEnableAllLevers extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call EnableAllLevers(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddVIPMercenaryCamp extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddVIPMercenaryCamp(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeAddTentacle extends CustomUnitType
    
    public stub method onEnter takes unit whichUnit returns nothing
        call AddTentacle(whichUnit)
    endmethod

endstruct

private struct CustomUnitTypeReturnBuilding extends CustomUnitType

    public stub method onEnter takes unit whichUnit returns nothing
        if (GetUnitAbilityLevel(whichUnit, 'Argl') > 0 or GetUnitAbilityLevel(whichUnit, 'Argd') > 0 or GetUnitAbilityLevel(whichUnit, 'Arlm') > 0) then
            call AddWoWReforgedReturnBuilding(whichUnit)
        endif
    endmethod

    public stub method onDeath takes unit whichUnit returns nothing
        if (IsReturnBuilding(whichUnit)) then
            call RemoveReturnBuilding(whichUnit)
        endif
    endmethod

    public stub method onRemove takes unit whichUnit returns nothing
        if (IsReturnBuilding(whichUnit)) then
            call RemoveReturnBuilding(whichUnit)
        endif
    endmethod

endstruct

private function EnumUnitInit takes nothing returns nothing
    local unit whichUnit = GetEnumUnit()
    local integer unitTypeId = GetPrimaryDependencyEquivalent(GetUnitTypeId(whichUnit))
    local player owner = GetOwningPlayer(whichUnit)
    local integer index = -1
    call AddCommandButtons(whichUnit)
    if (IsCustomUnitType(unitTypeId)) then
        call CallCustomUnitTypeOnEnter(whichUnit)
    endif
    
    //if (RectContainsUnit(GetMapPlayerSelectionRect(), whichUnit) and unitTypeId != 'n061') then
        //call Trig_Player_Selection_Floating_Texts_Func003A(whichUnit)
    //endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO) and GetHeroClass(unitTypeId) != CLASS_NONE) then
        //call AddCommandButtons(whichUnit) // Add before so they have command buttons, make sure the hero has no invulnerable ability and is owned by Neutral Passive.
        call ModifyHeroSkillPoints(whichUnit, bj_MODIFYMETHOD_SET, GetHeroLevel(whichUnit) * SKILL_POINTS_PER_LEVEL)
        call AddSkillMenu(whichUnit)
        call ApplyHeroClass(whichUnit)
        call AutoSkillHero(whichUnit)
    endif
    
    if (unitTypeId != LEGENDARY_ARTIFACT and unitTypeId != RANDOM_MINE and unitTypeId != RANDOM_WATER_MINE and not IsCrate(unitTypeId) and (owner == GetMapBossesPlayer() or owner == GetMapGaiaPlayer() or owner == Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
         call AddRespawnUnitGroupFromUnitStart(whichUnit)
         
         if (owner == GetMapGaiaPlayer()) then
            set index = GetUnitRespawnUnitIndex(whichUnit)
            if (IsRespawnUnitValid(index)) then
                call SetRespawnUnitTimeout(index, 300.0)
                set index = GetRespawnUnitGroupIndex(index)
                if (IsRespawnUnitGroupValid(index)) then
                    call SetRespawnUnitGroupItemDropEnabled(index, false)
                endif
            endif
        endif
    endif

    if (owner == Player(PLAYER_NEUTRAL_PASSIVE) and IsCritter(unitTypeId)) then
        call AddRespawnUnit(whichUnit)
    endif

    set owner = null
    set whichUnit = null
endfunction

// Call once during map initialization after all other initializations for the best performance since it will enumerate units only once.
function InitAllPreplacedUnits takes nothing returns nothing
    local timer t = CreateTimer()
    local group g = CreateGroup()
    local integer i = 0
    local integer max = 0
    local CustomUnitType c = 0
    call TimerStart(t, 9999999.0, false, null)
    
    set c = CustomUnitTypeAddCustomMine.create()
    set i = 0
    set max = GetMaxMines()
    loop
        exitwhen (i == max)
        //call BJDebugMsg("Mine type " + I2S(i) + " " + GetObjectName(GetMineTypeId(i)))
        call AddCustomUnitType(GetMineTypeId(i), c)
        set i = i + 1
    endloop
    
    set c = CustomUnitTypeAddProperty.create()
    set i = 0
    set max = GetMaxProperties()
    loop
        exitwhen (i == max)
        call AddCustomUnitType(GetProperty(i).unitTypeId, c)
        set i = i + 1
    endloop
    
    call ForceAddPlayer(UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, GetMapBossesPlayer())
    call ForceAddPlayer(UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, Player(PLAYER_NEUTRAL_AGGRESSIVE))
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), null) // This should be the only GroupEnumUnits during the initialization!!!
    call ForGroup(g, function EnumUnitInit)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    call PauseTimer(t)
    //call BJDebugMsg("Init time: " + R2S(TimerGetElapsed(t)))
    call DestroyTimer(t)
    set t = null
endfunction

private function Init takes nothing returns nothing
    local CustomUnitType c = 0
    local integer i = 0
    local integer max = 0

    call AddCustomUnitType(HIDEOUT, CustomUnitTypePlayerHideout.create())
    
    call AddCustomUnitType(FISH_SCHOOL, CustomUnitTypeFishSchool.create())
    call AddCustomUnitType(BERRY_BUSHES, CustomUnitTypeBerryBush.create())

    set c = CustomUnitTypePortal.create()
    call AddCustomUnitType(PORTAL, c)
    call AddCustomUnitType(PORTAL_NEUTRAL, c)
    call AddCustomUnitType(PORTAL_NEUTRAL_WATER, c)
    
    call AddCustomUnitType(LIBRARY, CustomUnitTypeHideLibrary.create())
    
    call AddCustomUnitType(TRADING_POST, CustomUnitTypeAddResourcesShop.create())
     
    call AddCustomUnitType(ANTIMAGIC_WARD, CustomUnitTypeAddAntimagicWard.create())

    set c = CustomUnitTypeAddBannersShop.create()
    call AddCustomUnitType(BANNER_SHOP, c)
    call AddCustomUnitType(BANNER_SHOP_NEUTRAL, c)

    set c = CustomUnitTypeAddMountsShop.create()
    call AddCustomUnitType(MOUNTS_SHOP, c)
    call AddCustomUnitType(MOUNTS_CAGE, c)
        
    call AddCustomUnitType(SCEPTERS_SHOP, CustomUnitTypeAddSceptersShop.create())
    call AddCustomUnitType(PROFESSION_BOOKS_SHOP, CustomUnitTypeAddProfessionBooksShop.create())
    
    set c = CustomUnitTypeAddTrainer.create()
    call AddCustomUnitType(TRAINER, c)
    call AddCustomUnitType(TRAINER_NEUTRAL, c)
    
    set c = CustomUnitTypeAddSkinsShop.create()
    call AddCustomUnitType(SKINS, c)
    call AddCustomUnitType(SKINS_NEUTRAL, c)

    set c = CustomUnitTypeAddArmory.create()
    call AddCustomUnitType(ARMORY, c)
    call AddCustomUnitType(ARMORY_NEUTRAL, c)
    
    call AddCustomUnitType(CHEST_NEUTRAL, CustomUnitTypeAddChest.create())

    set c = CustomUnitTypeEnableItemCraftingUnit.create()
    call AddCustomUnitType(CRAFTING_STASH, c)
    call AddCustomUnitType(CRAFTING_STASH_NEUTRAL, c)
    
    set c = CustomUnitTypeAddAlchemistLab.create()
    call AddCustomUnitType(ALCHEMIST_LAB, c)
    call AddCustomUnitType(ALCHEMIST_LAB_NEUTRAL, c)
    
    call AddCustomUnitType(GAME_MODE_TAVERN, CustomUnitTypeAddGameModesTavern.create())
    call AddCustomUnitType(HEROES_TAVERN, CustomUnitTypeAddHeroesTavern.create())
    call AddCustomUnitType(RACES_TAVERN, CustomUnitTypeAddRacesTavern.create())
    call AddCustomUnitType(PROFESSIONS_TAVERN, CustomUnitTypeAddProfessionsTavern.create())
    call AddCustomUnitType(START_LOCATIONS_TAVERN, CustomUnitTypeAddStartLocationsTavern.create())
    
    call AddCustomUnitType(RANDOM_MINE, CustomUnitTypeCreateRandomMine.create())
    call AddCustomUnitType(RANDOM_WATER_MINE, CustomUnitTypeCreateRandomWaterMine.create())
    
    call AddCustomUnitType(RANDOM_CORPSE, CustomUnitTypeReplaceRandomCorpse.create())
    
    set c = CustomUnitTypeAddGoldMine.create()
    call AddCustomUnitType(OIL_PATCH, c)
    //call AddCustomUnitType(GOLD_MINE, c)
    
    call AddCustomUnitType(RECORD_PLAYER, CustomUnitTypeAddRecordPlayer.create())
    
    set c = CustomUnitTypeAddRespawnUnit.create()
    call AddCustomUnitType(CRATES_0, c)
    call AddCustomUnitType(CRATES_1, c)
    call AddCustomUnitType(BARREL_0, c)
    call AddCustomUnitType(BARREL_1, c)
    
    set c = CustomUnitTypeEnableAllLevers.create()
    call AddCustomUnitType(LEVER_BRIDGE, c)
    call AddCustomUnitType(LEVER_GATE, c)
    call AddCustomUnitType(LEVER_GATE_AND_BRIDGE, c)
    call AddCustomUnitType(LEVER_GATE_AND_PORTAL, c)
    call AddCustomUnitType(LEVER_ALL, c)
    
    call AddCustomUnitType(MERCENARY_CAMP_VIP, CustomUnitTypeAddVIPMercenaryCamp.create())

    set c = CustomUnitTypeAddTentacle.create()
    call AddCustomUnitType(TENTACLE_CTHUN, c)
    call AddCustomUnitType(TENTACLE_NZOTH, c)
    call AddCustomUnitType(TENTACLE_YOGG_SARON, c)
    call AddCustomUnitType(EYE_TENTACLE_CTHUN, c)
    call AddCustomUnitType(EYE_TENTACLE_NZOTH, c)
    call AddCustomUnitType(MACE_TENTACLE_YOGG_SARON, c)

    set c = CustomUnitTypeReturnBuilding.create()
    call AddCustomUnitType(TEMPLE_OF_DARKNESS, c)
    call AddCustomUnitType(TEMPLE_OF_LIGHT, c)
    set i = 0
    set max = GetRacesMax()
    loop
        exitwhen (i == max)
        if (GetRaceTier1(i) != 0) then
            call AddCustomUnitType(GetRaceTier1(i), c)
        endif
        if (GetRaceTier2(i) != 0) then
            call AddCustomUnitType(GetRaceTier2(i), c)
        endif
        if (GetRaceTier3(i) != 0) then
            call AddCustomUnitType(GetRaceTier3(i), c)
        endif
        if (GetRaceMill(i) != 0) then
            call AddCustomUnitType(GetRaceMill(i), c)
        endif
        set i = i + 1
    endloop
endfunction

endlibrary
