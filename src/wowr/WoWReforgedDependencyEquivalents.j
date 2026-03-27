library WoWReforgedDependencyEquivalents initializer Init requires UnitTypeUtils

globals
    private hashtable h = InitHashtable()
endglobals

struct DependencyEquivalents
    boolean primary // is the primary unit
    integer array ids[5]
    integer count = 0
    
    method contains takes integer id returns boolean
        local integer i = 0
        loop
            exitwhen (i >= count)
            if (ids[i] == id) then
                return true
            endif
            set i = i + 1
        endloop
        return false
    endmethod
endstruct

function GetDependencyEquivalents takes integer id returns DependencyEquivalents
    return LoadInteger(h, id, 0)
endfunction

function AddDependencyEquivalentsSingle takes integer id, integer other, boolean primary returns nothing
    local DependencyEquivalents d = GetDependencyEquivalents(id)
    if (d == 0) then
        set d = DependencyEquivalents.create()
        call SaveInteger(h, id, 0, d)
    endif
    set d.primary = primary
    set d.ids[d.count] = other
    set d.count = d.count + 1
endfunction

function AddDependencyEquivalents takes integer id, integer other returns nothing
    call AddDependencyEquivalentsSingle(id, other, true)
    call AddDependencyEquivalentsSingle(other, id, false)
endfunction

function AddDependencyEquivalentsCampaign takes integer id, integer other returns nothing
    call AddDependencyEquivalents(id, other)
    call SetIsCampaign(other, true)
endfunction

function IsDependencyEquivalent takes integer id, integer other returns boolean
    local DependencyEquivalents d = GetDependencyEquivalents(id)
    if (d != 0) then
        return d.contains(other)
    endif
    
    return false
endfunction

function GetPrimaryDependencyEquivalent takes integer id returns integer
    local DependencyEquivalents d = GetDependencyEquivalents(id)
    local integer i = 0
    if (d != 0 and not d.primary and d.count > 0) then
        loop
            exitwhen (i >= d.count)
            if (GetDependencyEquivalents(d.ids[i]).primary) then
                return d.ids[i]
            endif
            set i = i + 1
        endloop
    endif
    
    return id
endfunction

function IsPrimaryDependencyEquivalent takes integer id returns boolean
    return GetPrimaryDependencyEquivalent(id) == id
endfunction

private function Init takes nothing returns nothing
    // Freelancer
    call AddDependencyEquivalents(FREELANCER_TIER_1, FREELANCER_TIER_2)
    call AddDependencyEquivalents(FREELANCER_TIER_1, FREELANCER_TIER_3)

    // Human
    call AddDependencyEquivalents(PEASANT, MILITIA)
    call AddDependencyEquivalents(TANK, ROCKET_TANK)
    
    call AddDependencyEquivalentsCampaign(ANDUIN_WRYNN, ANDUIN_WRYNN_M)
    
    // Orc
    call AddDependencyEquivalents(HEAD_HUNTER, BERSERKER)
    call AddDependencyEquivalents(SPIRIT_WALKER, SPIRIT_WALKER_M)
    
    call AddDependencyEquivalentsCampaign(GROMMASH_HELLSCREAM, GROMMASH_HELLSCREAM_M)
    call AddDependencyEquivalentsCampaign(NERZHUL, NERZHUL_M)

    // Undead
    call AddDependencyEquivalents(CRYPT_FIEND, UNDEAD_CRYPT_FIEND_BURROWED)
    call AddDependencyEquivalents(GARGOYLE, GARGOYLE_MORPH)
    call AddDependencyEquivalents(OBSIDIAN_STATUE, BLK_SPHINX)
    
    call AddDependencyEquivalents(ACOLYTE_HERO, ACOLYTE_HERO_M)
    call AddDependencyEquivalents(OBSIDIAN_STATUE_HERO, OBSIDIAN_STATUE_HERO_M)

    // Night Elf
    call AddDependencyEquivalents(HIPPO, HIPPO_RIDER)
    call AddDependencyEquivalents(DRUID_TALON, DRUID_TALON_M)
    call AddDependencyEquivalents(DRUID_CLAW, DRUID_CLAW_M)
    call AddDependencyEquivalents(DEMON_HUNTER, DEMON_HUNTER_M)
    call AddDependencyEquivalents(ANCIENT_OF_LORE_HERO, ANCIENT_OF_LORE_HERO_ROOTED)
    
    call AddDependencyEquivalentsCampaign(ILLIDAN_HERO, ILLIDAN_HERO_M)
    call AddDependencyEquivalentsCampaign(ILLIDAN_EVIL, ILLIDAN_EVIL_M)

    // Undead
    call AddDependencyEquivalents(CARRION_BEETLE_2, CARRION_BEETLE_2_BURROWED)
    call AddDependencyEquivalents(CARRION_BEETLE_3, CARRION_BEETLE_3_BURROWED)
    
    // Blood Elf
    call AddDependencyEquivalents(PHOENIX, PHOENIX_EGG)
    call AddDependencyEquivalents(ANCIENT_PHOENIX, ANCIENT_PHOENIX_EGG)
    call AddDependencyEquivalents(BLOOD_ELF_PHOENIX, BLOOD_ELF_PHOENIX_EGG)
    
    // Naga
    call AddDependencyEquivalents(NAGA_SNAP_DRAGON, NAGA_SNAP_DRAGON_SUBMERGED)
    call AddDependencyEquivalents(NAGA_MYRMIDON, NAGA_MYRMIDON_SUBMERGED)
    call AddDependencyEquivalents(NAGA_ROYAL, NAGA_ROYAL_SUBMERGED)
    call AddDependencyEquivalents(NAGA_WHALER, NAGA_WHALER_SUBMERGED)
    
    call AddDependencyEquivalents(NAGA_SORCERESS, SUBMERGED_SEAWITCH)
    call AddDependencyEquivalents(NAGA_ROYAL_GUARD_HERO, SUBMERGED_NAGA_ROYAL_GUARD_HERO)
    call AddDependencyEquivalentsCampaign(LADY_VASHJ, SUBMERGED_LADY_VASHJ)
    
    // Furbolg
    call AddDependencyEquivalents(FURBOLG_URSA_WARRIOR_HERO, FURBOLG_URSA_WARRIOR_HERO_M)
    
    // Goblin
    call AddDependencyEquivalents(GOBLIN_FLAMETHROWER, GOBLIN_MOBILE_TURRET)
    call AddDependencyEquivalents(OGRE_GOBLIN_SQUAD, OGRE_GOBLIN_SQUAD_M)
    call AddDependencyEquivalents(GOBLIN_ALCHEMIST, GOBLIN_ALCHEMIST_M)
    call AddDependencyEquivalents(GOBLIN_FLAMETHROWER, GOBLIN_MOBILE_TURRET)
    call AddDependencyEquivalents(GOBLIN_FLAMETHROWER, GOBLIN_MOBILE_TURRET)
    call AddDependencyEquivalents(GOBLIN_FLAMETHROWER, GOBLIN_MOBILE_TURRET)
    
    call AddDependencyEquivalents(TINKER, TINKER_M)
    
    // Dwarf
    call AddDependencyEquivalents(DWARF_WAR_GOLEM, DWARF_WAR_GOLEM_M)
    call AddDependencyEquivalents(DWARF_GRYPHON, DWARF_GRYPHON_M)
    call AddDependencyEquivalents(DWARF_SIEGE_ENGINE, DWARF_SIEGE_ENGINE_BARRAGE)
    call AddDependencyEquivalents(DWARF_SIEGE_ENGINE, DWARF_ELITE_SIEGE_TANK)
    
    call AddDependencyEquivalents(DWARF_MINE, DWARF_MINE_2)
    call AddDependencyEquivalents(DWARF_MINE, DWARF_MINE_3)
    call AddDependencyEquivalents(DWARF_TOWER, DWARF_TOWER_GUARD)
    call AddDependencyEquivalents(DWARF_TOWER, DWARF_TOWER_CANNON)
    call AddDependencyEquivalents(DWARF_TOWER, DWARF_TOWER_GUN)
    
    // High Elf
    call AddDependencyEquivalentsCampaign(SYLVANAS_WINDRUNNER, SYLVANAS_WINDRUNNER_M)
    
    // Tauren
    call AddDependencyEquivalents(TAUREN_SPIRIT_WALKER, TAUREN_SPIRIT_WALKER_M)
    call AddDependencyEquivalents(TAUREN_DRUID, TAUREN_DRUID_M)
    call AddDependencyEquivalents(TAUREN_TAUREN, TAUREN_ELITE_TAUREN)
    
    call AddDependencyEquivalents(SPIRIT_WALKER_HERO, SPIRIT_WALKER_HERO_M)
    
    // Pandaren
    call AddDependencyEquivalents(PANDAREN_DRUID, PANDAREN_DRUID_M)
    
    // Lordaeron
    call AddDependencyEquivalents(LORDAERON_FOOTMAN, LORDAERON_SPEARMAN)
    call AddDependencyEquivalents(LORDAERON_ARCHER, LORDAERON_CROSSBOWMAN)
    
    // Stormwind
    call AddDependencyEquivalents(STORMWIND_KNIGHT, STORMWIND_KNIGHT_UNMOUNTED)
    
    // Dalaran
    call AddDependencyEquivalents(DALARAN_ELEMENTAL_SANCTUARY_1, DALARAN_ELEMENTAL_SANCTUARY_2)
    
    // Kul Tiras
    call AddDependencyEquivalents(KULTIRAS_BARRACKS_1, KULTIRAS_BARRACKS_2)
    call AddDependencyEquivalents(KULTIRAS_SHIPYARD, KULTIRAS_SHIPYARD_ADVANCED)
    
    call AddDependencyEquivalents(KULTIRAS_FLIBUSTIER, KULTIRAS_FLIBUSTIER_GUN)
    
    call AddDependencyEquivalentsCampaign(ADMIRAL_PROUDMOORE, ADMIRAL_PROUDMOORE_M)
    
    // Nerubian
    call AddDependencyEquivalents(CRYPT_LORD, CRYPT_LORD_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_QUEEN_HERO, NERUBIAN_QUEEN_HERO_BURROWED)
    call AddDependencyEquivalentsCampaign(ANUBARAK_HERO, ANUBARAK_HERO_BURROWED)
    
    call AddDependencyEquivalents(NERUBIAN_TIER_1, NERUBIAN_TIER_1_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_TIER_2, NERUBIAN_TIER_2_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_TIER_3, NERUBIAN_TIER_3_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_ALTAR, NERUBIAN_ALTAR_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_ANCIENT_SHRINE, NERUBIAN_ANCIENT_SHRINE_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_HATCHERY, NERUBIAN_HATCHERY_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_TOWER, NERUBIAN_TOWER_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_ZIGGURAT, NERUBIAN_ZIGGURAT_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_NEST, NERUBIAN_NEST_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_SPAWNING_GROUND, NERUBIAN_SPAWNING_GROUND_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_SPAWNING_PIT, NERUBIAN_SPAWNING_PIT_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_VAULT_OF_RELICS, NERUBIAN_VAULT_OF_RELICS_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_HOUSING, NERUBIAN_HOUSING_BURROWED)

    call AddDependencyEquivalents(NERUBIAN_WORKER, NERUBIAN_WORKER_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_CRYPT_FIEND, NERUBIAN_CRYPT_FIEND_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_SEER, NERUBIAN_SEER_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_SPEAR_THROWER, NERUBIAN_SPEAR_THROWER_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_SPIDER_LORD, NERUBIAN_SPIDER_LORD_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_WARRIOR, NERUBIAN_WARRIOR_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_WEBSPINNER, NERUBIAN_WEBSPINNER_BURROWED)
    call AddDependencyEquivalents(NERUBIAN_CRYPT_DRONE, NERUBIAN_CRYPT_DRONE_COCOON)
    call AddDependencyEquivalents(NERUBIAN_QUEEN, NERUBIAN_QUEEN_BURROWED)
    
    // Murloc
    call AddDependencyEquivalents(MURLOC_DRAGON_TURTLE, MURLOC_DRAGON_TURTLE_SIEGE_FORM)
    
    // Kobold
    call AddDependencyEquivalents(GEOMANCER, GEOMANCER_BURROWED)
    call AddDependencyEquivalents(KOBOLD_TUNNELER, KOBOLD_TUNNELER_BURROWED)
    
    // Dungeon
    call AddDependencyEquivalents(DUNGEON_WAR_GOLEM, DUNGEON_WAR_GOLEM_M)
    
    // Creeps
    call AddDependencyEquivalents(BARBED_ARACHNATHID_WITH_BURROW, BARBED_ARACHNATHID_BURROWED)
    call AddDependencyEquivalents(SAND_WORM, SAND_WORM_BURROWED)
    call AddDependencyEquivalents(LIVING_STATUE, LIVING_STATUE_M)
    call AddDependencyEquivalents(CREEP_PHOENIX, CREEP_PHOENIX_EGG)
    
    // Abilities
    // Helps to change into similar abilities more quickly.
    call AddDependencyEquivalents(ABILITY_SUMMON_WATER_ELEMENTAL, ABILITY_SUMMON_SEA_ELEMENTAL)
    call AddDependencyEquivalents(ABILITY_SUMMON_WATER_ELEMENTAL, ABILITY_SUMMON_FIRE_ELEMENTAL)
    call AddDependencyEquivalents(ABILITY_SUMMON_WATER_ELEMENTAL, ABILITY_SUMMON_DJINN)
    call AddDependencyEquivalents(ABILITY_SUMMON_WATER_ELEMENTAL, ABILITY_SUMMON_EARTH_ELEMENTAL)
    
    call AddDependencyEquivalents(ABILITY_FIREBOLT, ABILITY_FROST_BOLT)
    call AddDependencyEquivalents(ABILITY_FIREBOLT, ABILITY_STORM_BOLT)
    
    call AddDependencyEquivalents(ABILITY_RAIN_OF_FIRE, ABILITY_BLIZZARD)
    call AddDependencyEquivalents(ABILITY_RAIN_OF_FIRE, ABILITY_RAIN_OF_ARROWS)
    
    call AddDependencyEquivalents(ABILITY_SHOCKWAVE, ABILITY_CRUSHING_WAVE)
    call AddDependencyEquivalents(ABILITY_SHOCKWAVE, ABILITY_CARRION_SWARM)
    
    call AddDependencyEquivalents(ABILITY_BREATH_OF_FIRE, ABILITY_BREATH_OF_FROST)
    
    call AddDependencyEquivalents(ABILITY_HOWL_OF_TERROR, ABILITY_SCREAM)
    
    call AddDependencyEquivalents(ABILITY_HOLY_LIGHT, ABILITY_DEATH_COIL)
    
    call AddDependencyEquivalents(ABILITY_STARFALL, ABILITY_MONSOON)
    call AddDependencyEquivalents(ABILITY_STARFALL, ABILITY_TORNADO)
    call AddDependencyEquivalents(ABILITY_STARFALL, ABILITY_EARTH_QUAKE)
    call AddDependencyEquivalents(ABILITY_STARFALL, ABILITY_VOLCANO)
    
    call AddDependencyEquivalents(ABILITY_TELEPORTATION, ABILITY_MASS_TELEPORT)
    call AddDependencyEquivalents(ABILITY_TELEPORTATION, ABILITY_OPEN_PORTALS)
    call AddDependencyEquivalents(ABILITY_TELEPORTATION, ABILITY_DARK_SUMMONING)
    
    call AddDependencyEquivalents(ABILITY_HEX, ABILITY_POLYMORPH)
    
    call AddDependencyEquivalents(ABILITY_ROBO_GOBLIN, ABILITY_METAMORPHOSIS)
    call AddDependencyEquivalents(ABILITY_ROBO_GOBLIN, ABILITY_DRUID_FORMS)
    call AddDependencyEquivalents(ABILITY_ROBO_GOBLIN, ABILITY_GHOST_FORM)
    
    call AddDependencyEquivalents(ABILITY_RAIN_OF_CHAOS, ABILITY_INFERNO)
endfunction

endlibrary
