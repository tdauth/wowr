library WoWReforgedProfessions initializer Init requires MaxItemStacks, MathUtils, TextTagUtils, ForceUtils

globals
    constant real DOCTOR_MANA_COST = 1200.0
    constant real GRAND_MASTER_MANA_COST = 1000.0
    constant real MASTER_MANA_COST = 800.0
    constant real ADEPT_MANA_COST = 600.0
    constant real ADVANCED_MANA_COST = 400.0
    constant real NOVICE_MANA_COST = 200.0
    
    constant integer PROFESSION_RANK_MAX = 6
    constant integer PROFESSION_RANK_DOCTOR = 5
    constant integer PROFESSION_RANK_GRAND_MASTER = 4
    constant integer PROFESSION_RANK_MASTER = 3
    constant integer PROFESSION_RANK_ADEPT = 2
    constant integer PROFESSION_RANK_ADVANCED = 1
    constant integer PROFESSION_RANK_NOVICE = 0
    
    constant integer PROFESSION_RANK_FINAL = PROFESSION_RANK_DOCTOR
    
    constant integer PROFESSION_MAX_CRAFTED = 4
    
    private integer professionsCounter = 0
    private Profession array professions
    
    private integer tmpRankCounter = PROFESSION_RANK_NOVICE
    
    private trigger castTrigger = CreateTrigger()
endglobals

function PlayerCanPickProfession takes player whichPlayer, integer id returns boolean
    return id != ITEM_TYPE_SCRIBE or udg_Tomes
endfunction

function GetRankName takes integer rank returns string
    if (rank == PROFESSION_RANK_DOCTOR) then
        return GetLocalizedString("DOCTOR")
    elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
        return GetLocalizedString("GRAND_MASTER")
    elseif (rank == PROFESSION_RANK_MASTER) then
        return GetLocalizedString("MASTER")
    elseif (rank == PROFESSION_RANK_ADEPT) then
        return GetLocalizedString("ADEPT")
    elseif (rank == PROFESSION_RANK_ADVANCED) then
        return GetLocalizedString("ADVANCED")
    elseif (rank == PROFESSION_RANK_NOVICE) then
        return GetLocalizedString("NOVICE")
    endif
    
    return GetLocalizedString("UNKNOWN")
endfunction

struct Rank
    integer craftedItemAbilityId
    integer craftedItemsCount // counts crafted
    integer array craftedItems[PROFESSION_MAX_CRAFTED] // GetCraftedIndex
    integer array craftedUnits[PROFESSION_MAX_CRAFTED]
    integer array craftedCount[PROFESSION_MAX_CRAFTED]
    boolean array craftedOnCast[PROFESSION_MAX_CRAFTED]
endstruct

struct Profession
    integer itemTypeId
    integer bookItemTypeId
    Rank array ranks[PROFESSION_RANK_MAX]
endstruct

function GetProfessionsMax takes nothing returns integer
    return professionsCounter
endfunction

function GetProfession takes integer index returns Profession
    return professions[index]
endfunction

function GetProfessionName takes integer index returns string
    local Profession p = GetProfession(index)
    return GetObjectName(p.itemTypeId)
endfunction

function GetProfessionFromString takes string s returns integer
    return S2I(s)
endfunction

function IsValidProfession takes integer p returns boolean
    return p > udg_ProfessionNone and p < GetProfessionsMax()
endfunction

private function GetIconByProfessionEx takes integer profession returns string
    local Profession p = GetProfession(profession)
    local Rank r = p.ranks[PROFESSION_RANK_NOVICE]
    
    if (r != 0 and r.craftedItemsCount > 0) then
        if (r.craftedItems[0] != 0) then
            return BlzGetAbilityIcon(r.craftedItems[0])
        elseif (r.craftedUnits[0] != 0) then
            return BlzGetAbilityIcon(r.craftedUnits[0])
        endif
    endif
    
    return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
endfunction

function GetIconByProfession takes integer profession returns string
    if (profession == udg_ProfessionNone) then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif
    
    return GetIconByProfessionEx(profession)
endfunction

function AddProfession takes nothing returns nothing
    local Profession p = Profession.create()
    local integer index = GetProfessionsMax()
    local integer i = 0
    
    set professions[index] = p
    set p.itemTypeId = udg_TmpItemTypeId
    set p.bookItemTypeId = udg_TmpItemTypeId2
    
    loop
        exitwhen (i == PROFESSION_RANK_MAX)
        set p.ranks[i] = Rank.create()
        set i = i + 1
    endloop
    
    set udg_ProfessionName[index] = GetObjectName(udg_TmpItemTypeId)
    set udg_ProfessionItemType[index] = udg_TmpItemTypeId2
    set udg_ProfessionItemTypeTavern[index] = udg_TmpItemTypeId
    
    set udg_LastAddedProfession = index
    
    set tmpRankCounter = PROFESSION_RANK_NOVICE
    
    set professionsCounter = professionsCounter + 1
    
    // for adding the items
    set udg_TmpInteger = 1
    set udg_TmpBoolean = true
endfunction

function GetProfessionByTavernItemTypeId takes integer tavernItemTypeId returns integer
    local integer max = GetProfessionsMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (tavernItemTypeId == udg_ProfessionItemTypeTavern[i]) then
            return i
        endif
        set i = i + 1
    endloop
    return -1 // udg_ProfessionNone
endfunction

function AddProfessionRank takes nothing returns nothing
    set tmpRankCounter = IMinBJ(PROFESSION_RANK_FINAL, tmpRankCounter + 1)
endfunction

function AddProfessionCrafted takes integer itemTypeId, integer unitTypeId, integer charges, boolean onCast, integer abilityId returns nothing
    local integer index = IMaxBJ(0, GetProfessionsMax() - 1)
    local Profession p = GetProfession(index)
    local integer rank = IMinBJ(PROFESSION_RANK_FINAL, tmpRankCounter)
    local Rank r = p.ranks[rank]
    local integer index2 = r.craftedItemsCount
    
    //call BJDebugMsg(GetProfessionName(index) + " - " + GetRankName(rank) + " count " + I2S(r.craftedItemsCount) + " index2 " + I2S(index2))
    
    set r.craftedItems[index2] = itemTypeId
    set r.craftedUnits[index2] = unitTypeId
    set r.craftedCount[index2] = charges
    set r.craftedOnCast[index2] = onCast
    
    set r.craftedItemAbilityId = abilityId
    set r.craftedItemsCount = r.craftedItemsCount + 1
    
    set udg_TmpInteger = 1 // charges
    set udg_TmpBoolean = true // onCast
endfunction

function AddProfessionCraftedItem takes nothing returns nothing
    call AddProfessionCrafted(udg_TmpItemTypeId, 0, udg_TmpInteger, udg_TmpBoolean, udg_TmpAbilityCode)
endfunction

function AddProfessionCraftedUnit takes nothing returns nothing
    call AddProfessionCrafted(0, udg_TmpUnitType, udg_TmpInteger, udg_TmpBoolean, udg_TmpAbilityCode)
endfunction

function GetProfessionItemTypeId takes integer index returns integer
    local Profession p = GetProfession(index)
    return p.itemTypeId
endfunction

function GetProfessionBookItemTypeId takes integer index returns integer
    local Profession p = GetProfession(index)
    return p.bookItemTypeId
endfunction

function GetProfessionCraftedItem takes integer i, integer rank, integer j returns integer
    local Profession p = GetProfession(i)
    return p.ranks[rank].craftedItems[j]
endfunction

function GetProfessionCraftedUnit takes integer i, integer rank, integer j returns integer
    local Profession p = GetProfession(i)
    return p.ranks[rank].craftedUnits[j]
endfunction

function GetProfessionCraftedCount takes integer i, integer rank, integer j returns integer
    local Profession p = GetProfession(i)
    return p.ranks[rank].craftedCount[j]
endfunction

function GetProfessionCraftedOnCast takes integer i, integer rank, integer j returns boolean
    local Profession p = GetProfession(i)
    return p.ranks[rank].craftedOnCast[j]
endfunction

function GetProfessionCraftedItemsCount takes integer i, integer rank returns integer
    local Profession p = GetProfession(i)
    return p.ranks[rank].craftedItemsCount
endfunction

function SetPlayerProfession1 takes player whichPlayer, integer p returns nothing
    set udg_PlayerProfession[GetConvertedPlayerId(whichPlayer)] = p
endfunction

function GetPlayerProfession1 takes player whichPlayer returns integer
    return udg_PlayerProfession[GetConvertedPlayerId(whichPlayer)]
endfunction

function SetPlayerProfession2 takes player whichPlayer, integer p returns nothing
    set udg_PlayerProfession2[GetConvertedPlayerId(whichPlayer)] = p
endfunction

function GetPlayerProfession2 takes player whichPlayer returns integer
    return udg_PlayerProfession2[GetConvertedPlayerId(whichPlayer)]
endfunction

function SetPlayerProfession3 takes player whichPlayer, integer p returns nothing
    set udg_PlayerProfession3[GetConvertedPlayerId(whichPlayer)] = p
endfunction

function GetPlayerProfession3 takes player whichPlayer returns integer
    return udg_PlayerProfession3[GetConvertedPlayerId(whichPlayer)]
endfunction

function PlayerHasProfession takes player whichPlayer, integer profession returns boolean
    return GetPlayerProfession1(whichPlayer) == profession or GetPlayerProfession2(whichPlayer) == profession or GetPlayerProfession3(whichPlayer) == profession
endfunction

// Used for Computer AI.
function GetRandomComputerProfessionEx takes integer exclude0, integer exclude1 returns integer
    local integer random = GetRandomInt(0, 13) // all possible menu items
    local integer array a
    local integer c = 0
    set a[c] = udg_ProfessionHerbalist
    set c = c + 1
    set a[c] = udg_ProfessionAlchemist
    set c = c + 1
    set a[c] = udg_ProfessionWeaponSmith
    set c = c + 1
    set a[c] = udg_ProfessionArmourer
    set c = c + 1
    set a[c] = udg_ProfessionEngineer
    set c = c + 1
    set a[c] = udg_ProfessionDemolitionExpert
    set c = c + 1
    set a[c] = udg_ProfessionDragonBreeder
    set c = c + 1
    set a[c] = udg_ProfessionLoreMaster
    set c = c + 1
    set a[c] = udg_ProfessionRuneforger
    set c = c + 1
    set a[c] = udg_ProfessionSorcerer
    set c = c + 1
    set a[c] = udg_ProfessionJewelcrafter
    set c = c + 1
    set a[c] = udg_ProfessionArchaeologist
    set c = c + 1
    set a[c] = udg_ProfessionWitchDoctor
    set c = c + 1

    return a[GetRandomInt(0, c)]
endfunction

function GetRandomComputerProfession takes nothing returns integer
    return GetRandomComputerProfessionEx(udg_ProfessionNone, udg_ProfessionNone)
endfunction

function ComputerAutopickProfession2 takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    set udg_PlayerProfession2[convertedPlayerId] = GetRandomComputerProfessionEx(udg_PlayerProfession[convertedPlayerId], udg_ProfessionNone)
endfunction

function ComputerAutopickProfession3 takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    set udg_PlayerProfession2[convertedPlayerId] = GetRandomComputerProfessionEx(udg_PlayerProfession[convertedPlayerId], udg_PlayerProfession2[convertedPlayerId])
endfunction

// TODO Determine by registered stuff not manually except for archeology and rune master
function GetNextCraftedProfessionItemEx takes integer profession, integer rank returns integer
	if (profession == udg_ProfessionHerbalist) then
        if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_FOUNTAIN_OF_HEALTH
        elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ITEM_SCROLL_OF_HEALING
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TALISMAN_OF_EVERLASTING
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_POTION_OF_INVULNERABILITY
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_HEALTH_STONE
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_POTION_OF_GREATER_HEALING
		endif
	elseif (profession == udg_ProfessionAlchemist) then
        if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_FOUNTAIN_OF_MANA
        elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ITEM_SCROLL_OF_MANA
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TALISMAN_OF_SPELL_PROTECTION
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_WAND_OF_MANA_STEALING
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_MANA_STONE
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_POTION_OF_GREATER_MANA
		endif
	elseif (profession == udg_ProfessionWeaponSmith) then
        if (rank == PROFESSION_RANK_GRAND_MASTER) then
			return ITEM_MYTHICAL_POISON_BLADE
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_BLESSED_DRAGON_LANCE
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_DEMON_SLAYER_AXE
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_MITHRIL_LONG_SWORD
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_BOW_OF_FIRE
		endif
    elseif (profession == udg_ProfessionArmourer) then
        if (rank == PROFESSION_RANK_GRAND_MASTER) then
			return ITEM_MYTHICAL_GOLDEN_ARMOR
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_BLESSED_CHAMPION_ARMOR
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_HEAVY_PLATED_SHIELD
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_PLATED_HELMET
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_LIGHT_LEATHER_ARMOR
		endif
    elseif (profession == udg_ProfessionEngineer) then
        if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_POWER_GENERATOR_ENGINEER
        elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ITEM_SCROLL_OF_REPAIR
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_SLEDGE_HAMMER
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TINY_DEATH_TOWER
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_TINY_BOULDER_TOWER
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_TINY_COLD_TOWER
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_TINY_FLAME_TOWER
		endif
    elseif (profession == udg_ProfessionDemolitionExpert) then
        if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_NUCLEAR_SILO
        //elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            // 2 TNT catapults
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_SLEDGE_HAMMER
		//elseif (rank == PROFESSION_RANK_ADEPT) then
			// 2 sappers
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_EXPLOSIVE_BARRELS
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_GOBLIN_LAND_MINES
		endif
    elseif (profession == udg_ProfessionLoreMaster) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_ANKH_OF_REINCARNATION
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_SCROLL_OF_RESURRECTION
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_SCROLL_OF_RESTORATION
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_SCROLL_OF_PROTECTION
		endif
    elseif (profession == udg_ProfessionSorcerer) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_WAND_OF_SORCERER_ILLUSION
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_WAND_OF_REANIMATION
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_WAND_OF_THE_WIND
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_WAND_OF_NEUTRALIZATION
		endif
    elseif (profession == udg_ProfessionRuneforger) then
        if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_RUNE_OF_GREATER_RESURRECTION
        elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_RUNE_OF_LESSER_RESURRECTION_RUNEFORGER
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_RUNE_OF_REBIRTH_RUNEFORGER
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_RUNE_OF_RESTORATION_RUNEFORGER
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_RUNE_OF_DISPEL_MAGIC_RUNEFORGER
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_RUNE_OF_SPEED_RUNEFORGER
		endif
    elseif (profession == udg_ProfessionDragonBreeder) then
        if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_DRAGON_BREEDER_ROOST
        //elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            //return ITEM_SCROLL_OF_HEALING
        // grand master crafts dragon egg which then can be used to summon a dragon
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_GREEN_DRAGON_EGG
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_GREEN_DRAKE_EGG
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_THARIFAS_EGG
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_GREEN_DRAGON_WHELP_EGG
		endif
    elseif (profession == udg_ProfessionJewelcrafter) then
        if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_GOLDEN_CROWN
        elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_BRACELET
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_JEWEL_AMULET
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_GREEN_GEMSTONE
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_ENCHANTED_GEMSTONE
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_RING_OF_SUPERIORITY
		endif
    elseif (profession == udg_ProfessionArchaeologist) then
        if (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ChooseRandomItemExBJ(8, ITEM_TYPE_ANY)
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ChooseRandomItemExBJ(7, ITEM_TYPE_ANY)
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ChooseRandomItemExBJ(5, ITEM_TYPE_ANY)
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ChooseRandomItemExBJ(3, ITEM_TYPE_ANY)
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ChooseRandomItemExBJ(1, ITEM_TYPE_ANY)
		endif
    elseif (profession == udg_ProfessionWitchDoctor) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_HEALING_WARDS
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_MANA_WARDS
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_STASIS_TRAPS
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_SENTRY_WARDS
		endif
    elseif (profession == udg_ProfessionTamer) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_MONSTER_LURE
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_ADVANCED_BAIT
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_BAIT
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_SMALL_BAIT
		endif
    elseif (profession == udg_ProfessionNecromancer) then
        if (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ITEM_SCROLL_OF_ANIMATE_DEAD
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_BOOK_OF_THE_DEAD
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_SACRIFICAL_SCULL
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_WAND_OF_CORPSES
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_ROD_OF_NECROMANCY
		endif
    elseif (profession == udg_ProfessionGolemSculptor) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TINY_FLESH_GOLEM
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_TINY_SIEGE_GOLEM
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_TINY_WAR_GOLEM
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_TINY_MUD_GOLEM
		endif
    elseif (profession == udg_ProfessionWarlock) then
       if (rank == PROFESSION_RANK_DOCTOR) then
            return ITEM_TINY_FEL_FOUNTAIN
        elseif (rank == PROFESSION_RANK_GRAND_MASTER) then
            return ITEM_DEMONIC_FIGURE // ITEM_SPIKED_COLLAR
		elseif (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TINY_DEMON_GATE
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_DEMON_BLOOD
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_INFERNO_STONE
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_WAND_OF_DRAIN
		endif
    elseif (profession == udg_ProfessionAstromancer) then
		if (rank == PROFESSION_RANK_MASTER) then
			return ITEM_TINY_ARCANE_OBSERVATORY_ASTROMANCER
		elseif (rank == PROFESSION_RANK_ADEPT) then
			return ITEM_METEOR_STONE
		elseif (rank == PROFESSION_RANK_ADVANCED) then
			return ITEM_FLARE_GUN
		elseif (rank == PROFESSION_RANK_NOVICE) then
			return ITEM_NAVIGATION_SCROLL
		endif
	endif
	return 0
endfunction

function GetProfessionItemCharges takes integer itemTypeId returns integer
    return 0
endfunction

function GetProfessionCraftRankByMana takes unit hero returns integer
    local real mana = GetUnitState(hero, UNIT_STATE_MANA)
    if (mana >= DOCTOR_MANA_COST) then
        return PROFESSION_RANK_DOCTOR
    elseif (mana >= GRAND_MASTER_MANA_COST) then
        return PROFESSION_RANK_GRAND_MASTER
    elseif (mana >= MASTER_MANA_COST) then
        return PROFESSION_RANK_MASTER
    elseif (mana >= ADEPT_MANA_COST) then
        return PROFESSION_RANK_ADEPT
    elseif (mana >= ADVANCED_MANA_COST) then
        return PROFESSION_RANK_ADVANCED
    elseif (mana >= NOVICE_MANA_COST) then
        return PROFESSION_RANK_NOVICE
    endif
    return PROFESSION_RANK_NOVICE
endfunction

function GetNextCraftedProfession1Item takes unit hero returns integer
	local integer profession = GetPlayerProfession1(GetOwningPlayer(hero))
    local integer rank = GetProfessionCraftRankByMana(hero)
	return GetNextCraftedProfessionItemEx(profession, rank)
endfunction

function GetNextCraftedProfession2Item takes unit hero returns integer
	local integer profession = GetPlayerProfession2(GetOwningPlayer(hero))
    local integer rank = GetProfessionCraftRankByMana(hero)
	return GetNextCraftedProfessionItemEx(profession, rank)
endfunction

function GetNextCraftedProfession3Item takes unit hero returns integer
	local integer profession = GetPlayerProfession3(GetOwningPlayer(hero))
    local integer rank = GetProfessionCraftRankByMana(hero)
	return GetNextCraftedProfessionItemEx(profession, rank)
endfunction

function CraftProfessionItemAIEx takes unit hero, integer itemTypeId returns item
    local item result = null
    local item slotItem = null
    local integer charges = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY or result != null)
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem == null) then
            call UnitAddItemToSlotById(hero, itemTypeId, i)
            set result = UnitItemInSlot(hero, i)
            set charges = GetProfessionItemCharges(itemTypeId)
            if (charges > 0) then
                call SetItemCharges(result, charges)
            endif
        elseif (GetItemTypeId(slotItem) == itemTypeId and  GetItemCharges(slotItem) > 0 and GetItemCharges(slotItem) < GetMaxStacksByItemTypeId(itemTypeId)) then
            set charges = GetProfessionItemCharges(itemTypeId)
            if (charges == 0) then
                set charges = 1
            endif
            call SetItemCharges(slotItem, GetItemCharges(slotItem) + charges)
        endif
        set slotItem = null
        set i = i + 1
    endloop
    return result
endfunction

function CraftProfessionItemAI1 takes unit hero returns item
    local integer itemTypeId = GetNextCraftedProfession1Item(hero)
    if (itemTypeId != 0) then
        return CraftProfessionItemAIEx(hero, itemTypeId)
    endif
    
    return null
endfunction

function CraftProfessionItemAI2 takes unit hero returns item
    local integer itemTypeId = GetNextCraftedProfession2Item(hero)
    if (itemTypeId != 0) then
        return CraftProfessionItemAIEx(hero, itemTypeId)
    endif
    
    return null
endfunction

function CraftProfessionItemAI3 takes unit hero returns item
    local integer itemTypeId = GetNextCraftedProfession3Item(hero)
    if (itemTypeId != 0) then
        return CraftProfessionItemAIEx(hero, itemTypeId)
    endif
    
    return null
endfunction

function CraftProfessionItemsAI takes unit hero returns nothing
    local item whichItem = null
    if (IsUnitAliveBJ(hero)) then
        set whichItem = CraftProfessionItemAI1(hero)
        if (whichItem != null) then
            call UnitAddItem(hero, whichItem)
        endif
        set whichItem = CraftProfessionItemAI2(hero)
        if (whichItem != null) then
            call UnitAddItem(hero, whichItem)
        endif
        set whichItem = CraftProfessionItemAI3(hero)
        if (whichItem != null) then
            call UnitAddItem(hero, whichItem)
        endif
    endif
endfunction

function GetBookItemProfession takes integer itemTypeId returns integer
    local integer i = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i >= max)
        if (udg_ProfessionItemType[i] == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return udg_ProfessionNone
endfunction

function GetObjectProfession takes integer objectId returns integer
    local integer j = 0
    local integer i = 0
    local integer k = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i >= max)
        if (udg_ProfessionItemType[i] == objectId) then
            return i
        endif
        set j = 0
        loop
            exitwhen (j == PROFESSION_RANK_MAX)
            set k = 0
            loop
                exitwhen (k == PROFESSION_MAX_CRAFTED)
                if (GetProfessionCraftedUnit(i, j, k) == objectId or GetProfessionCraftedItem(i, j, k) == objectId) then
                    return i
                endif
                set k = k + 1
            endloop
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    return udg_ProfessionNone
endfunction

function ProfessionBonusCharges takes unit hero returns integer
    return GetHeroLevel(hero) / 15
endfunction

private function CraftUnits takes unit hero, integer unitTypeId, integer charges returns nothing
    local player owner = GetOwningPlayer(hero)
    local real x = GetUnitX(hero)
    local real y = GetUnitY(hero)
    local real face = GetUnitFacing(hero)
    local unit u = null
    local integer count = charges + ProfessionBonusCharges(hero)
     loop
        set count = count - 1
        exitwhen count < 0
        set u = CreateUnit(owner, unitTypeId, x, y, face)
        if (unitTypeId == HUNTING_HAWK) then
            call GroupAddUnit(udg_Hunters, u)
        endif
        set u = null
    endloop
    set owner = null
endfunction

private function CraftItems takes unit hero, integer itemTypeId, integer charges returns nothing
    local item whichItem = CreateItem(itemTypeId, GetUnitX(hero), GetUnitY(hero))
    // set charges before adding the item to the hero to avoid stacking before setting charges
    if (GetItemCharges(whichItem) > 0 or charges > 1) then
        call SetItemCharges(whichItem, charges + ProfessionBonusCharges(hero))
    endif
    call UnitAddItem(hero, whichItem)
    set whichItem = null
endfunction

private function GetProfessionIndexByAbilityId takes integer abilityId returns integer
    local integer j = 0
    local integer i = 0
    local Profession profession = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i >= max)
        set profession = GetProfession(i)
        set j = 0
        loop
            exitwhen (j == PROFESSION_RANK_MAX)
            if (profession.ranks[j].craftedItemAbilityId == abilityId) then
                return i
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    return -1
endfunction

private function GetProfessionRankByAbilityId takes integer abilityId returns integer
    local integer j = 0
    local integer i = 0
    local Profession profession = 0
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i >= max)
        set profession = GetProfession(i)
        set j = 0
        loop
            exitwhen (j == PROFESSION_RANK_MAX)
            if (profession.ranks[j].craftedItemAbilityId == abilityId) then
                return j
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    return -1
endfunction

function ProfessionCraftTextTag takes unit hero, real cooldown returns nothing
    local force allies = GetAlliesWithSharedControl(GetOwningPlayer(hero))
    if (ProfessionBonusCharges(hero) > 0) then
        call ShowGeneralFadingTextTagForForce(allies, Format(GetLocalizedString("CRAFT_TEXT")).i(ProfessionBonusCharges(hero)).i(R2I(cooldown)).result(), GetUnitX(hero), GetUnitY(hero), 0, 0, 255, 0)
    else
        call ShowGeneralFadingTextTagForForce(allies, Format(GetLocalizedString("CRAFT_TEXT_COOLDOWN_ONLY")).i(R2I(cooldown)).result(), GetUnitX(hero), GetUnitY(hero), 0, 0, 255, 0)
    endif
    call DestroyForce(allies)
    set allies = null
endfunction

function ProfessionCraft takes unit hero, integer abilityId, integer id, integer count, boolean isUnit returns nothing
    local real cooldown = RMaxBJ(5.0,  BlzGetAbilityRealLevelField(BlzGetUnitAbility(hero, abilityId), ABILITY_RLF_COOLDOWN, 0) - I2R(GetHeroLevel(hero)))
    if (isUnit) then
        call CraftUnits(hero, id, count)
    else
        call CraftItems(hero, id, count)
    endif
    call ProfessionCraftTextTag(hero, cooldown)
    // sleep is required since the shared spell book cooldown apparently triggers after some sleep
    call TriggerSleepAction(0.1)
    if (GetUnitTypeId(hero) != 0) then
        call BlzStartUnitAbilityCooldown(hero, 'Aspb', cooldown)
    endif    
endfunction

function ProfessionCraftUnits takes unit hero, integer abilityId, integer unitTypeId, integer count returns nothing
    call ProfessionCraft(hero, abilityId, unitTypeId, count, true)
endfunction

function ProfessionCraftItems takes unit hero, integer abilityId, integer itemTypeId, integer count returns nothing
    call ProfessionCraft(hero, abilityId, itemTypeId, count, false)
endfunction

private function CastCraft takes unit hero, integer abilityId, integer index returns nothing
    local Profession p = GetProfession(index)
    local integer i = 0
    local integer index2 = 0
    local integer rank = GetProfessionRankByAbilityId(abilityId)
    local integer max = GetProfessionCraftedItemsCount(index, rank)
    //call BJDebugMsg("Craft " + I2S(max) + " IDs.")
    loop
        exitwhen (i >= max)
        if (p.ranks[rank].craftedOnCast[i]) then
            if (p.ranks[rank].craftedUnits[i] != 0) then
                call ProfessionCraftUnits(hero, abilityId, p.ranks[rank].craftedUnits[i], p.ranks[rank].craftedCount[i])
            elseif (p.ranks[rank].craftedItems[i] != 0) then
                call ProfessionCraftItems(hero, abilityId,  p.ranks[rank].craftedItems[i], p.ranks[rank].craftedCount[i])
            endif
        endif
        set i = i + 1
    endloop
endfunction

private function TriggerActionCast takes nothing returns nothing
    local integer abilityId = GetSpellAbilityId()
    local integer index = GetProfessionIndexByAbilityId(abilityId)
    if (index != -1) then
        call CastCraft(GetTriggerUnit(), abilityId, index)
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddAction(castTrigger, function TriggerActionCast)
endfunction

endlibrary
