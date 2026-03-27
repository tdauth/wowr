library WoWReforgedHeroes requires PagedButtonsConfig, StringUtils, UnitTypeUtils, WoWReforgedUtils, WoWReforgedAccount, WoWReforgedClasses, WoWReforgedRaces, WoWReforgedDependencyEquivalents

private function AddHeroPagedButtonsConfig takes integer id, string modelPath returns nothing
    call AddPagedButtonsConfigHero(id, 0, 0, 1, 1, 0, 0, modelPath)
endfunction

function GetHeroesMax takes nothing returns integer
    return udg_HeroUnitTypeIndex
endfunction

function GetHeroRace takes integer index returns integer
    return udg_HeroRace[index]
endfunction

function GetHeroUnitType takes integer index returns integer
    return udg_HeroUnitType[index]
endfunction

function GetHeroMountUnitTypeId takes integer index returns integer
    return udg_HeroMountUnitType[index]
endfunction

function GetHeroIsBonus takes integer index returns boolean
    return udg_HeroIsBonus[index]
endfunction

function GetHeroCategory takes integer index returns string
    return udg_HeroCategory[index]
endfunction

function GetHeroIndexByUnitTypeId takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i >= udg_MaxHeroUnitTypes)
        if (GetHeroUnitType(i) == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function PlayerCanBuyHeroEx takes player whichPlayer, integer unitTypeId returns boolean
    local integer index = GetHeroIndexByUnitTypeId(unitTypeId)
    if (index > -1) then
        return PlayerHasUnlocked(whichPlayer, GetHeroUnitType(index)) and (not GetHeroIsBonus(index) or GetHeroLevel1(whichPlayer) >= HERO_JOURNEY_BONUS_HEROS or udg_UnlockedAll)
    endif
    return true
endfunction

function PlayerCanBuyHero takes player whichPlayer, unit hero returns boolean
    return PlayerCanBuyHeroEx(whichPlayer, GetUnitTypeId(hero))
endfunction

function PlayerCanBuyHeroErrorMessageEx takes player whichPlayer, integer unitTypeId returns string
    local integer index = GetHeroIndexByUnitTypeId(unitTypeId)
    if (index > -1) then
        if (not PlayerHasUnlocked(whichPlayer, GetHeroUnitType(index))) then
            return Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetObjectName(unitTypeId)).s(GetAllUnlockedAccountNames(GetHeroUnitType(index))).result()
        elseif (GetHeroIsBonus(index) and GetHeroLevel1(whichPlayer) < HERO_JOURNEY_BONUS_HEROS and not udg_UnlockedAll) then
            return Format(GetLocalizedString("BONUS_HERO_REQUIRES_LEVEL")).i(HERO_JOURNEY_BONUS_HEROS).result()
        endif
    endif
    return ""
endfunction

function PlayerCanBuyHeroErrorMessage takes player whichPlayer, unit hero returns string
    return PlayerCanBuyHeroErrorMessageEx(whichPlayer, GetUnitTypeId(hero))
endfunction

private function AddHero takes integer unitTypeId, integer whichClass, integer whichRace, integer mountUnitTypeId, boolean isBonus, string category, string accountNames returns integer
    local integer index = udg_HeroUnitTypeIndex
    set udg_HeroUnitType[index] = unitTypeId
    set udg_HeroRace[index] = whichRace
    set udg_HeroMountUnitType[index] = mountUnitTypeId
    set udg_HeroIsBonus[index] = isBonus
    set udg_HeroCategory[index] = category
    set udg_HeroAccountNames[index] = accountNames
    set udg_HeroUnitTypeIndex = udg_HeroUnitTypeIndex + 1
    set udg_MaxHeroUnitTypes = udg_HeroUnitTypeIndex
    
    //call AddHeroPagedButtonsConfig(unitTypeId, "")
    if (whichClass != CLASS_NONE) then
        call AssignHeroClass(unitTypeId, whichClass)
    endif
    
    return index
endfunction

function ChooseRandomHeroFromRace takes integer whichRace returns integer
    local integer array heroIndices
    local integer heroIndicesCounter = 0
    local integer i = 0
    loop
        exitwhen (i >= udg_MaxHeroUnitTypes)
        if ((udg_HeroRace[i] == whichRace or whichRace == udg_RaceFreelancer)) then
            //call BJDebugMsg("Adding index " + I2S(i) + " possible heroes for race " + GetObjectName(udg_RaceTavernItemType[whichRace]) + ": " + GetObjectName(udg_HeroUnitType[i]))
            set heroIndices[heroIndicesCounter] = i
            set heroIndicesCounter = heroIndicesCounter + 1
        endif
        set i = i + 1
    endloop
    
    //call BJDebugMsg("Got " + I2S(heroIndicesCounter) + " possible heroes for race " + GetObjectName(udg_RaceTavernItemType[whichRace]))
    
    if (heroIndicesCounter > 0) then
        return heroIndices[GetRandomInt(0, heroIndicesCounter - 1)]
    endif
    
    return 0
endfunction

function GetHeroMountUnitTypeIdByUnitTypeId takes integer unitTypeId returns integer
    local integer index = GetHeroIndexByUnitTypeId(unitTypeId)
    if (index != -1) then
        return GetHeroMountUnitTypeId(index)
    endif
    return GRYPHON_MOUNT
endfunction

function ApplyHeroMount takes unit hero returns nothing
    call SetHeroMountTypeByUnitTypeId(hero, GetHeroMountUnitTypeIdByUnitTypeId(GetPrimaryDependencyEquivalent(GetUnitTypeId(hero))))
endfunction

function InitHeroes takes nothing returns nothing
    // Customizable
    call AddHero(CUSTOMIZABLE_HERO, -1, udg_RaceNone, GRYPHON_MOUNT, false, GetLocalizedString("CUSTOMIZABLE"), "")
    
    // Human
    call AddHero(PALADIN, CLASS_PALADIN, udg_RaceHuman, GRYPHON_MOUNT, false, GetLocalizedString("HUMAN"), "")
    call AddHero(WIZARD, CLASS_ARCANIST, udg_RaceHuman, GRYPHON_MOUNT, false, GetLocalizedString("HUMAN"), "")
    call AddHero(DARK_KNIGHT, CLASS_WARRIOR, udg_RaceHuman, GRYPHON_MOUNT, false, GetLocalizedString("HUMAN"), "")
    call AddHero(PEASANT_HERO, CLASS_TINKER, udg_RaceHuman, GRYPHON_MOUNT, false, GetLocalizedString("HUMAN"), "")
    call AddHero(CAPTAIN, CLASS_WARRIOR, udg_RaceHuman, GRYPHON_MOUNT, false, GetLocalizedString("HUMAN"), "")
    call AddHero(ARTHAS, CLASS_PALADIN, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("HUMAN"), "")
    call SetIsCampaign(ARTHAS, true)
    call AddHero(UTHER, CLASS_PALADIN, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("HUMAN"), "")
    call SetIsCampaign(UTHER, true)
    call AddHero(LORD_GARITHOS, CLASS_WARRIOR, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("HUMAN"), "")
    call SetIsCampaign(LORD_GARITHOS, true)
    call AddHero(ANDUIN_WRYNN, CLASS_PALADIN, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("HUMAN"), "")
    call SetIsCampaign(ANDUIN_WRYNN, true)
    
    // Dwarf
    call AddHero(MTN_KING, CLASS_WARRIOR, udg_RaceDwarf, GRYPHON_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(MORTAR_TEAM, CLASS_HUNTER, udg_RaceDwarf, GRYPHON_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(DWARF_MAGE, CLASS_GEOMANCER, udg_RaceDwarf, GRYPHON_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(ELITE_RIFLEMAN, CLASS_HUNTER, udg_RaceDwarf, FLYING_MACHINE_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(SIEGE_ENGINE, CLASS_TINKER, udg_RaceDwarf, FLYING_MACHINE_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(BARD, CLASS_DRUID, udg_RaceDwarf, GRYPHON_MOUNT, false, GetLocalizedString("DWARF"), "")
    call AddHero(MURADIN_BRONZEBEARD, CLASS_WARRIOR, udg_RaceDwarf, GRYPHON_MOUNT, true, GetLocalizedString("DWARF"), "")
    call SetIsCampaign(MURADIN_BRONZEBEARD, true)
    call AddHero(GRYPHON_RIDER, CLASS_WARRIOR, udg_RaceDwarf, GRYPHON_MOUNT, true, GetLocalizedString("DWARF"), "")
    
    // Blood Elf
    call AddHero(BLOOD_MAGE, CLASS_PYROMANCER, udg_RaceBloodElf, DRAGONHAWK_MOUNT, false, GetLocalizedString("BLOOD_ELF"), "")
    call AddHero(SPELLBREAKER_HERO, CLASS_ARCANIST, udg_RaceBloodElf, DRAGONHAWK_MOUNT, false, GetLocalizedString("BLOOD_ELF"), "")
    call AddHero(PHOENIX_HERO, CLASS_PYROMANCER, udg_RaceBloodElf, PHOENIX_MOUNT, true, GetLocalizedString("BLOOD_ELF"), "Barade#2569")
    call AddHero(ANASTERIAN_SUNSTRIDER, CLASS_ARCANIST, udg_RaceBloodElf, DRAGONHAWK_MOUNT, true, GetLocalizedString("BLOOD_ELF"), "")
    call SetIsCampaign(ANASTERIAN_SUNSTRIDER, true)
    call AddHero(KAEL_HERO, CLASS_PYROMANCER, udg_RaceBloodElf, DRAGONHAWK_MOUNT, true, GetLocalizedString("BLOOD_ELF"), "")
    call SetIsCampaign(KAEL_HERO, true)
    
    // High Elf
    call AddHero(RANGER, CLASS_HUNTER, udg_RaceHighElf, DRAGONHAWK_MOUNT, false, GetLocalizedString("HIGH_ELF"), "")
    call AddHero(SORCERESS_HERO, CLASS_ARCANIST, udg_RaceHighElf, DRAGONHAWK_MOUNT, false, GetLocalizedString("HIGH_ELF"), "")
    call AddHero(PRIEST_HERO, CLASS_PALADIN, udg_RaceHighElf, DRAGONHAWK_MOUNT, false, GetLocalizedString("HIGH_ELF"), "")
    call AddHero(SYLVANAS_WINDRUNNER, CLASS_HUNTER, udg_RaceHighElf, DRAGONHAWK_MOUNT, true, GetLocalizedString("HIGH_ELF"), "")
    call SetIsCampaign(SYLVANAS_WINDRUNNER, true)
    call AddHero(THALORIEN_DAWNSEEKER, CLASS_WARRIOR, udg_RaceHighElf, DRAGONHAWK_MOUNT, true, GetLocalizedString("HIGH_ELF"), "")
    call SetIsCampaign(THALORIEN_DAWNSEEKER, true)
    
    // Orc
    call AddHero(BLADE_MASTER, CLASS_ROGUE, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(FAR_SEER, CLASS_GEOMANCER, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(WARLOCK, CLASS_WARLOCK, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(STORMREAVER_WARLOCK, CLASS_WARLOCK, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(SKELETAL_ORC_CHAMPION, CLASS_WARRIOR, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(PEON_HERO, CLASS_TINKER, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(KODO_BEAST_HERO, CLASS_WARRIOR, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(RAIDER_HERO, CLASS_ROGUE, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(SHAMAN_HERO, CLASS_GEOMANCER, udg_RaceOrc, WYVERN_MOUNT, false, GetLocalizedString("ORC"), "")
    call AddHero(THRALL_HERO, CLASS_GEOMANCER, udg_RaceOrc, WYVERN_MOUNT, true, GetLocalizedString("ORC"), "")
    call SetIsCampaign(THRALL_HERO, true)
    call AddHero(GROMMASH_HELLSCREAM, CLASS_ROGUE, udg_RaceOrc, WYVERN_MOUNT, true, GetLocalizedString("ORC"), "")
    call SetIsCampaign(GROMMASH_HELLSCREAM, true)
    call AddHero(DREKTHAR, CLASS_GEOMANCER, udg_RaceOrc, WYVERN_MOUNT, true, GetLocalizedString("ORC"), "")
    call SetIsCampaign(DREKTHAR, true)
    call AddHero(NERZHUL, CLASS_WARLOCK, udg_RaceOrc, WYVERN_MOUNT, true, GetLocalizedString("ORC"), "")
    call SetIsCampaign(NERZHUL, true)
    call AddHero(GULDAN, CLASS_WARLOCK, udg_RaceOrc, WYVERN_MOUNT, true, GetLocalizedString("ORC"), "")
    call SetIsCampaign(GULDAN, true)
    
    // Undead
    call AddHero(DEATH_KNIGHT, CLASS_DEATH_KNIGHT, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(LICH, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(DARK_RANGER, CLASS_HUNTER, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(NECROMANCER_HERO, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(ABOMINATION_HERO, CLASS_WARRIOR, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(BANSHEE_HERO, CLASS_WITCH_DOCTOR, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(ACOLYTE_HERO, CLASS_TINKER, udg_RaceUndead, GARGOYLE_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(OBSIDIAN_STATUE_HERO, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, false, GetLocalizedString("UNDEAD"), "")
    call AddHero(ARTHAS_UNDEAD, CLASS_DEATH_KNIGHT, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(ARTHAS_UNDEAD, true)
    call AddHero(KELTHUZAD, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(KELTHUZAD, true)
    call AddHero(KELTHUZAD_LICH, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(KELTHUZAD_LICH, true)
    call AddHero(MALGANIS_HERO, CLASS_NECROMANCER, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(MALGANIS_HERO, true)
    call AddHero(SYLVANAS_UNDEAD, CLASS_HUNTER, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(SYLVANAS_UNDEAD, true)
    call AddHero(LICH_KING, CLASS_DEATH_KNIGHT, udg_RaceUndead, FROST_WYRM_MOUNT, true, GetLocalizedString("UNDEAD"), "")
    call SetIsCampaign(LICH_KING, true)
    
    // Nerubian
    call AddHero(CRYPT_LORD, CLASS_WARRIOR, udg_RaceNerubian, FROST_WYRM_MOUNT, false, GetLocalizedString("NERUBIAN"), "")
    call AddHero(NERUBIAN_QUEEN_HERO, CLASS_NECROMANCER, udg_RaceNerubian, FROST_WYRM_MOUNT, false, GetLocalizedString("NERUBIAN"), "")
    call AddHero(ANUBARAK_HERO, CLASS_WARRIOR, udg_RaceNerubian, FROST_WYRM_MOUNT, true, GetLocalizedString("NERUBIAN"), "")
    call SetIsCampaign(ANUBARAK_HERO, true)
    
    // Night Elf
    call AddHero(RANGER_NIGHT_ELF, CLASS_HUNTER, udg_RaceNightElf, HIPPOGROPH_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(KEEPER, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(MOON_CHICK, CLASS_HUNTER, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(DEMON_HUNTER, CLASS_WARLOCK, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(WARDEN, CLASS_WARRIOR, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(MOUNTAIN_GIANT_HERO, CLASS_WARRIOR, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(DRUID_OF_THE_CLAW, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(DRUID_OF_THE_TALON, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(DRYAD_HERO, CLASS_HUNTER, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(WISP_HERO, CLASS_TINKER, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(ANCIENT_OF_LORE_HERO, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, false, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(FURION, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(FURION, true)
    call AddHero(MALFURION, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(MALFURION, true)
    call AddHero(ILLIDAN_HERO, CLASS_WARLOCK, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(ILLIDAN_HERO, true)
    call AddHero(ILLIDAN_EVIL, CLASS_WARLOCK, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(ILLIDAN_EVIL, true)
    call AddHero(TYRANDE_HERO, CLASS_HUNTER, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(TYRANDE_HERO, true)
    call AddHero(MAIEV_HERO, CLASS_WARRIOR, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(MAIEV_HERO, true)
    call AddHero(SHANDRIS_FEATHER_MOON, CLASS_HUNTER, udg_RaceNightElf, HIPPOGROPH_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(SHANDRIS_FEATHER_MOON, true)
    call AddHero(KEEPER_OF_THE_GROVE_GHOST, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(CENARIUS_HERO, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call SetIsCampaign(CENARIUS_HERO, true)
    call AddHero(ARCHDRUID, CLASS_DRUID, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(PRIESTESS_OF_THE_MOON_OWL, CLASS_HUNTER, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    call AddHero(CHIMAERA_HERO, CLASS_WARRIOR, udg_RaceNightElf, CHIMAERA_MOUNT, true, GetLocalizedString("NIGHT_ELF"), "")
    
    // Goblin
    call AddHero(ALCHEMIST, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(TINKER, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(FLAME_SHREDDER, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(GOBLIN_SHREDDER_HERO, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(GOBLIN_GUNNER, CLASS_HUNTER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(ENGINEER, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    call AddHero(SAPPER_HERO, CLASS_TINKER, udg_RaceGoblin, ZEPPELIN_MOUNT, false, GetLocalizedString("GOBLIN"), "")
    
    // Naga
    call AddHero(NAGA_SORCERESS, CLASS_HYDROMANCER, udg_RaceNaga, COUATL_MOUNT, false, GetLocalizedString("NAGA"), "")
    call AddHero(NAGA_ROYAL_GUARD_HERO, CLASS_WARRIOR, udg_RaceNaga, COUATL_MOUNT, false, GetLocalizedString("NAGA"), "")
    call AddHero(NAGA_SIREN_HERO, CLASS_NECROMANCER, udg_RaceNaga, COUATL_MOUNT, false, GetLocalizedString("NAGA"), "")
    call AddHero(LADY_VASHJ, CLASS_HYDROMANCER, udg_RaceNaga, COUATL_MOUNT, true, GetLocalizedString("NAGA"), "")
    call SetIsCampaign(LADY_VASHJ, true)

    // Gnome
    call AddHero(GNOME_ENGINEER_HERO, CLASS_TINKER, udg_RaceGnome, FLYING_MACHINE_MOUNT, false, GetLocalizedString("GNOME"), "")
    call AddHero(GNOME_WARLOCK_HERO, CLASS_WARLOCK, udg_RaceGnome, FLYING_MACHINE_MOUNT, false, GetLocalizedString("GNOME"), "")
    
    // Pandaren
    call AddHero(BREWMASTER, CLASS_MONK, udg_RacePandaren, CLOUD_SERPENT_MOUNT, false, GetLocalizedString("PANDAREN"), "")
    call AddHero(IRON_FIST, CLASS_WARLOCK, udg_RacePandaren, CLOUD_SERPENT_MOUNT, false, GetLocalizedString("PANDAREN"), "")
    call AddHero(SHADO_PAN, CLASS_ROGUE, udg_RacePandaren, CLOUD_SERPENT_MOUNT, false, GetLocalizedString("PANDAREN"), "")
    call AddHero(MONK, CLASS_MONK, udg_RacePandaren, CLOUD_SERPENT_MOUNT, false, GetLocalizedString("PANDAREN"), "")
    call AddHero(CHEN_STORMSTOUT, CLASS_MONK, udg_RacePandaren, CLOUD_SERPENT_MOUNT, true, GetLocalizedString("PANDAREN"), "")
    call SetIsCampaign(CHEN_STORMSTOUT, true)
    
    // Troll
    call AddHero(SHADOW_HUNTER, CLASS_WITCH_DOCTOR, udg_RaceTroll, BAT_MOUNT, false, GetLocalizedString("TROLL"), "")
    call AddHero(WITCH_DOCTOR_HERO, CLASS_WITCH_DOCTOR, udg_RaceTroll, BAT_MOUNT, false, GetLocalizedString("TROLL"), "")
    call AddHero(TROLL_WARLORD, CLASS_WARRIOR, udg_RaceTroll, BAT_MOUNT, false, GetLocalizedString("TROLL"), "")
    call AddHero(ROKHAN, CLASS_WITCH_DOCTOR, udg_RaceTroll, BAT_MOUNT, true, GetLocalizedString("TROLL"), "")
    call SetIsCampaign(ROKHAN, true)
    
    // Tauren
    call AddHero(TAUREN_CHIEF, CLASS_GEOMANCER, udg_RaceTauren, WYVERN_MOUNT, false, GetLocalizedString("TAUREN"), "")
    call AddHero(SPIRIT_WALKER_HERO, CLASS_WITCH_DOCTOR, udg_RaceTauren, WYVERN_MOUNT, false, GetLocalizedString("TAUREN"), "")
    call AddHero(CAIRNE_BLOODHOOF, CLASS_GEOMANCER, udg_RaceTauren, WYVERN_MOUNT, true, GetLocalizedString("TAUREN"), "")
    call SetIsCampaign(CAIRNE_BLOODHOOF, true)
    
    // Demon
    call AddHero(DREAD_LORD, CLASS_DEATH_KNIGHT, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(PIT_LORD_HERO, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(EREDAR_WARLOCK_HERO, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(SUCCUBUS, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(DOOM_GUARD, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(FEL_BEAST, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(INFERNAL_HERO, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(JAILER, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(MOARG_OVERLORD, CLASS_WARRIOR, udg_RaceDemon, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DEMON"), "")
    call AddHero(ARCHIMONDE, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    call SetIsCampaign(ARCHIMONDE, true)
    call AddHero(MANNOROTH, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    call SetIsCampaign(MANNOROTH, true)
    call AddHero(KIL_JAEDEN, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    call SetIsCampaign(KIL_JAEDEN, true)
    call AddHero(TICHONDRIUS_HERO, CLASS_DEATH_KNIGHT, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    call SetIsCampaign(TICHONDRIUS_HERO, true)
    call AddHero(MAGTHERIDON, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    call SetIsCampaign(MAGTHERIDON, true)
    call AddHero(DOOM_LORD, CLASS_WARLOCK, udg_RaceDemon, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DEMON"), "")
    
    // Lost Ones
    call AddHero(ELDER_SAGE, CLASS_ROGUE, udg_RaceLostOnes, NETHER_DRAKE_MOUNT, false, GetLocalizedString("LOST_ONES"), "")
    call AddHero(VINDICATOR, CLASS_PALADIN, udg_RaceLostOnes, NETHER_DRAKE_MOUNT, false, GetLocalizedString("LOST_ONES"), "")
    
    // Furbolg
    call AddHero(FURBOLG_URSA_WARRIOR_HERO, CLASS_DRUID, udg_RaceFurbolg, GREEN_DRAGON_MOUNT, false, GetLocalizedString("FURBOLG"), "")
    
    // Dalaran
    call AddHero(ARCHMAGE, CLASS_ARCANIST, udg_RaceDalaran, DRAGONHAWK_MOUNT, false, GetLocalizedString("DALARAN"), "")
    call AddHero(ARCH_SORCERESS, CLASS_ARCANIST, udg_RaceDalaran, DRAGONHAWK_MOUNT, false, GetLocalizedString("DALARAN"), "")
    call AddHero(ANTONIDAS, CLASS_ARCANIST, udg_RaceDalaran, DRAGONHAWK_MOUNT, true, GetLocalizedString("DALARAN"), "")
    call SetIsCampaign(AEGWYNN, true)
    call AddHero(ANTONIDAS_GHOST, CLASS_ARCANIST, udg_RaceDalaran, DRAGONHAWK_MOUNT, true, GetLocalizedString("DALARAN"), "")
    call SetIsCampaign(AEGWYNN, true)
    call AddHero(KHADGAR, CLASS_ARCANIST, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("DALARAN"), "")
    call SetIsCampaign(KHADGAR, true)
    call AddHero(MEDIVH, CLASS_ARCANIST, udg_RaceHuman, GRYPHON_MOUNT, true, GetLocalizedString("DALARAN"), "")
    call SetIsCampaign(MEDIVH, true)
    call AddHero(AEGWYNN, CLASS_ARCANIST, udg_RaceDalaran, DRAGONHAWK_MOUNT, true, GetLocalizedString("DALARAN"), "")
    call SetIsCampaign(AEGWYNN, true)
    
    // Kul Tiras
    call AddHero(HYDROMANCER, CLASS_HYDROMANCER, udg_RaceKulTiras, ALBATROSS_MOUNT, false, GetLocalizedString("KUL_TIRAS"), "")
    call AddHero(TIDESAGE, CLASS_WITCH_DOCTOR, udg_RaceKulTiras, ALBATROSS_MOUNT, false, GetLocalizedString("KUL_TIRAS"), "")
    call AddHero(JAINA_HERO, CLASS_HYDROMANCER, udg_RaceKulTiras, ALBATROSS_MOUNT, true, GetLocalizedString("KUL_TIRAS"), "")
    call SetIsCampaign(JAINA_HERO, true)
    call AddHero(ADMIRAL_PROUDMOORE, CLASS_WARRIOR, udg_RaceKulTiras, ALBATROSS_MOUNT, true, GetLocalizedString("KUL_TIRAS"), "")
    call SetIsCampaign(ADMIRAL_PROUDMOORE, true)
    
    // Stormwind
    call AddHero(LION_RIDER, CLASS_PALADIN, udg_RaceStormwind, GRYPHON_MOUNT, false, GetLocalizedString("STORMWIND"), "")
    call AddHero(BISHOP, CLASS_PALADIN, udg_RaceStormwind, GRYPHON_MOUNT, false, GetLocalizedString("STORMWIND"), "")
    
    // Vrykul
    call AddHero(THANE, CLASS_WARRIOR, udg_RaceVrykul, PROTO_DRAKE_MOUNT, false, GetLocalizedString("VRYKUL"), "")
    call AddHero(FLAMEBINDER, CLASS_PYROMANCER, udg_RaceVrykul, PROTO_DRAKE_MOUNT, false, GetLocalizedString("VRYKUL"), "")
    call AddHero(WOLF_RIDER, CLASS_HUNTER, udg_RaceVrykul, PROTO_DRAKE_MOUNT, false, GetLocalizedString("VRYKUL"), "")
    call AddHero(DARK_VALKYR, CLASS_DEATH_KNIGHT, udg_RaceVrykul, PROTO_DRAKE_MOUNT, false, GetLocalizedString("VRYKUL"), "")
    call AddHero(GOLDEN_VALKYR, CLASS_PALADIN, udg_RaceVrykul, PROTO_DRAKE_MOUNT, false, GetLocalizedString("VRYKUL"), "")
    
    // Worgen
    call AddHero(DEATHCLAW, CLASS_ROGUE, udg_RaceWorgen, CROW_MOUNT, false, GetLocalizedString("WORGEN"), "")
    call AddHero(WORGEN_DEATH_KNIGHT, CLASS_DEATH_KNIGHT, udg_RaceWorgen, CROW_MOUNT, false, GetLocalizedString("WORGEN"), "")
    call AddHero(GENN_GREYMANE, CLASS_ROGUE, udg_RaceWorgen, CROW_MOUNT, true, GetLocalizedString("WORGEN"), "")
    call SetIsCampaign(GENN_GREYMANE, true)
    
    // Tuskarr
    call AddHero(HERO_TUSKARR_CHIEFTAIN, CLASS_WARRIOR, udg_RaceTuskarr, SNOWY_OWL_MOUNT, false, GetLocalizedString("TUSKARR"), "")
    
    // Murloc
    call AddHero(MURLOC_SORCERER, CLASS_NECROMANCER, udg_RaceMurloc, COUATL_MOUNT, false, GetLocalizedString("MURLOC"), "")
    
    // Ogre
    call AddHero(OGRE_LORD, CLASS_WARRIOR, udg_RaceOgre, BLACK_DRAGON_MOUNT, false, GetLocalizedString("OGRE"), "")
    call AddHero(OGRE_MAGI_HERO, CLASS_ARCANIST, udg_RaceOgre, BLACK_DRAGON_MOUNT, false, GetLocalizedString("OGRE"), "")
    call AddHero(GRONN, CLASS_WARRIOR, udg_RaceOgre, BLACK_DRAGON_MOUNT, false, GetLocalizedString("OGRE"), "")
    call AddHero(BEASTMASTER, CLASS_HUNTER, udg_RaceOgre, BLACK_DRAGON_MOUNT, false, GetLocalizedString("OGRE"), "")
    call AddHero(REXXAR, CLASS_HUNTER, udg_RaceOgre, BLACK_DRAGON_MOUNT, true, GetLocalizedString("OGRE"), "")
    call SetIsCampaign(REXXAR, true)
    
    // Draenei
    call AddHero(EREDAR_ANNIHILATOR, CLASS_WARRIOR, udg_RaceDraenei, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DRAENEI"), "")
    call AddHero(EREDAR_VINDICATOR, CLASS_PALADIN, udg_RaceDraenei, NETHER_DRAKE_MOUNT, false, GetLocalizedString("DRAENEI"), "")
    call AddHero(VELEN, CLASS_PALADIN, udg_RaceDraenei, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DRAENEI"), "")
    call SetIsCampaign(VELEN, true)
    call AddHero(NAARU, CLASS_PALADIN, udg_RaceDraenei, NETHER_DRAKE_MOUNT, true, GetLocalizedString("DRAENEI"), "")
    
    // Fel Orc
    call AddHero(FEL_BLADEMASTER, CLASS_ROGUE, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_WARLOCK, CLASS_WARLOCK, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_WARLORD, CLASS_WARRIOR, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_CROSSBOWMAN, CLASS_HUNTER, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_RAIDER, CLASS_ROGUE, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_PEON, CLASS_TINKER, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_KODO_BEAST, CLASS_WARRIOR, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FEL_ORC"), "")
    call AddHero(FEL_GROMMASH_HELLSCREAM, CLASS_ROGUE, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, true, GetLocalizedString("FEL_ORC"), "")
    call AddHero(KARGATH_BLADEFIST, CLASS_WARRIOR, udg_RaceFelOrc, BLACK_DRAGON_MOUNT, true, GetLocalizedString("FEL_ORC"), "")
    call SetIsCampaign(KARGATH_BLADEFIST, true)
    
    // Faceless One
    call AddHero(UNBROKEN, CLASS_WITCH_DOCTOR, udg_RaceFacelessOne, BLACK_DRAGON_MOUNT, false, GetLocalizedString("FACELESS_ONE"), "")
    call AddHero(GENERAL_VEZAX, CLASS_WARRIOR, udg_RaceFacelessOne, BLACK_DRAGON_MOUNT, true, GetLocalizedString("FACELESS_ONE"), "")
    call SetIsCampaign(GENERAL_VEZAX, true)
    
    // Satyr
    call AddHero(SATYR_HELLCALLER, CLASS_WARLOCK, udg_RaceSatyr, GREEN_DRAGON_MOUNT, false, GetLocalizedString("SATYR"), "")
    call AddHero(SATYR_TRICKSTER_HERO, CLASS_ROGUE, udg_RaceSatyr, GREEN_DRAGON_MOUNT, false, GetLocalizedString("SATYR"), "")
    
    // Centaur
    call AddHero(CENTAUR_KHAN_HERO, CLASS_GEOMANCER, udg_RaceCentaur, EAGLE_MOUNT, false, GetLocalizedString("CENTAUR"), "")
    
    // Gnoll
    call AddHero(GNOLL_ALPHA, CLASS_WARRIOR, udg_RaceGnoll, EAGLE_MOUNT, false, GetLocalizedString("GNOLL"), "")
    
    // Kobold
    call AddHero(GEOMANCER, CLASS_GEOMANCER, udg_RaceKobold, EAGLE_MOUNT, false, GetLocalizedString("KOBOLD"), "")
    
    // Quillboar
    call AddHero(RAZORMANE_CHIEFTAIN, CLASS_WARRIOR, udg_RaceQuillboar, EAGLE_MOUNT, false, GetLocalizedString("QUILLBOAR"), "")
    
    // Bandit
    call AddHero(BANDIT_LORD, CLASS_WARRIOR, udg_RaceBandit, CROW_MOUNT, false, GetLocalizedString("BANDIT"), "")
    call AddHero(DARK_WIZARD, CLASS_NECROMANCER, udg_RaceBandit, CROW_MOUNT, false, GetLocalizedString("BANDIT"), "")
    call AddHero(ASSASSIN, CLASS_HUNTER, udg_RaceBandit, CROW_MOUNT, false, GetLocalizedString("BANDIT"), "")
    call AddHero(ROGUE, CLASS_ROGUE, udg_RaceBandit, CROW_MOUNT, false, GetLocalizedString("BANDIT"), "")
    
    // Dungeon
    call AddHero(GIANT_SKELETON, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    call AddHero(SIEGE_GOLEM, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    call AddHero(REVENANT, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    call AddHero(SALAMANDER_LORD, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    call AddHero(SLUDGE_MONSTROSITY, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    call AddHero(BERSERK_WILDKIN, CLASS_WARRIOR, udg_RaceDungeon, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DUNGEON"), "")
    
    // Dragonkin
    call AddHero(EVOKER, CLASS_ARCANIST, udg_RaceDragonkin, GREEN_DRAGON_MOUNT, false, GetLocalizedString("DRAGONKIN"), "")
    call AddHero(DRAGONSPAWN, CLASS_WARRIOR, udg_RaceDragonkin, GREEN_DRAGON_MOUNT, false, GetLocalizedString("DRAGONKIN"), "")
    
    // Elements
    call AddHero(FIRELORD, CLASS_PYROMANCER, udg_RaceNone, PHOENIX_MOUNT, false, GetLocalizedString("ELEMENTS"), "")
    call AddHero(FROSTLORD, CLASS_HYDROMANCER, udg_RaceNone, FROST_WYRM_MOUNT, false, GetLocalizedString("ELEMENTS"), "")
    call AddHero(EARTHLORD, CLASS_GEOMANCER, udg_RaceNone, WYVERN_MOUNT, false, GetLocalizedString("ELEMENTS"), "")
    call AddHero(WINDLORD, CLASS_AEROMANCER, udg_RaceNone, CLOUD_SERPENT_MOUNT, false, GetLocalizedString("ELEMENTS"), "")
    call AddHero(VOID_LORD, CLASS_ARCANIST, udg_RaceNone, NETHER_DRAKE_MOUNT, false, GetLocalizedString("ELEMENTS"), "")
    
    // Neutral
    call AddHero(SEA_GIANT, CLASS_HYDROMANCER, udg_RaceNone, COUATL_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(REVENANT_DEEPLORD, CLASS_HYDROMANCER, udg_RaceNone, COUATL_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(MAGNATAUR_DESTROYER, CLASS_WARRIOR, udg_RaceNone, SNOWY_OWL_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(ANCIENT_HYDRA, CLASS_HYDROMANCER, udg_RaceNone, COUATL_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(BROOD_MOTHER, CLASS_ROGUE, udg_RaceNone, GREEN_DRAGON_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(ANCIENT_SASQUATCH, CLASS_DRUID, udg_RaceNone, GREEN_DRAGON_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(ANCIENT_WENDIGO, CLASS_HYDROMANCER, udg_RaceNone, GREEN_DRAGON_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(ENRANGED_JUNGLE_STALKER, CLASS_DRUID, udg_RaceNone, GREEN_DRAGON_MOUNT, false, GetLocalizedString("NEUTRAL"), "")
    call AddHero(RAMKAHEN_HUNTRESS, CLASS_HUNTER, udg_RaceNone, BLACK_DRAGON_MOUNT, false, GetLocalizedString("NEUTRAL"), "")

    call AddHero(HARPY_QUEEN, CLASS_AEROMANCER, udg_RaceNone, EAGLE_MOUNT, true, GetLocalizedString("NEUTRAL"), "")
    call AddHero(RED_DRAGON_HERO, CLASS_PYROMANCER, udg_RaceNone, BLACK_DRAGON_MOUNT, true, GetLocalizedString("NEUTRAL"), "")
    
    // Navy
    call AddHero(HUMAN_BATTLESHIP_HERO, CLASS_TINKER, udg_RaceNone, GRYPHON_MOUNT, false, GetLocalizedString("TAVERN_NAVY"), "")
    call AddHero(CAPTAIN_HERO, CLASS_WARRIOR, udg_RaceNone, GRYPHON_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(GNOMISH_SUBMARINE_HERO, CLASS_TINKER, udg_RaceNone, FLYING_MACHINE_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(GNOMISH_SUBMARINE_HERO_PILOT, CLASS_TINKER, udg_RaceNone, FLYING_MACHINE_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(GOBLIN_SUBMARINE_HERO, CLASS_TINKER, udg_RaceNone, ZEPPELIN_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(GOBLIN_SUBMARINE_PILOT_HERO, CLASS_TINKER, udg_RaceNone, ZEPPELIN_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(DWARF_SUBMARINE_HERO, CLASS_TINKER, udg_RaceNone, GRYPHON_MOUNT, false, GetLocalizedString("NAVY"), "")
    call AddHero(DWARF_SUBMARINE_PILOT_HERO, CLASS_TINKER, udg_RaceNone, GRYPHON_MOUNT, false, GetLocalizedString("NAVY"), "")
    
    // Demigods
    call AddHero(DEMIGOD_LIGHT, CLASS_PALADIN, udg_RaceNone, GREEN_DRAGON_MOUNT, false, GetLocalizedString("DEMIGODS"), "")
    call AddHero(DEMIGOD_DARK, CLASS_DEATH_KNIGHT, udg_RaceNone, BLACK_DRAGON_MOUNT, false, GetLocalizedString("DEMIGODS"), "")
    
    // VIP
    call AddHero(BARADE, CLASS_MONK, udg_RaceNone, SNOWY_OWL_MOUNT, false, GetLocalizedString("VIP"), "Barade#2569,Barade,WorldEdit")
    call SetIsCampaign(BARADE, true)
    
    call AddHero(EYLON, CLASS_MONK, udg_RaceNone, DRAGONHAWK_MOUNT, false, GetLocalizedString("VIP"), "Etos7#2138")
    call SetIsCampaign(EYLON, true)
    
    // TODO Enum all boss hero units, assign their classes and auto skill them.
endfunction

endlibrary
