library WoWReforgedClasses initializer Init requires SafeString, WoWReforgedSkillMenu, WoWReforgedDependencyEquivalents

globals
    integer CLASS_NONE = -1
    integer CLASS_ARCANIST = -1
    integer CLASS_PYROMANCER = -1
    integer CLASS_HYDROMANCER = -1
    integer CLASS_GEOMANCER = -1
    integer CLASS_AEROMANCER = -1
    integer CLASS_PALADIN = -1
    integer CLASS_DEATH_KNIGHT = -1
    integer CLASS_WARLOCK = -1
    integer CLASS_DRUID = -1
    integer CLASS_WARRIOR = -1
    integer CLASS_HUNTER = -1
    integer CLASS_ROGUE = -1
    integer CLASS_MONK = -1
    integer CLASS_NECROMANCER = -1
    integer CLASS_WITCH_DOCTOR = -1
    integer CLASS_TINKER = -1

    private integer array classItemTypeIds
    private integer array classes
    private integer classesCounter = 0

    private hashtable h = InitHashtable()
endglobals

function GetMaxHeroClasses takes nothing returns integer
    return classesCounter
endfunction

function GetRandomHeroClass takes nothing returns integer
    return GetRandomInt(0, GetMaxHeroClasses() - 1)
endfunction

function GetHeroClassByIndex takes integer index returns integer
    return classes[index]
endfunction

function GetHeroClassItemTypeId takes integer index returns integer
    return classItemTypeIds[index]
endfunction

function GetHeroClassName takes integer index returns string
    return GetObjectName(GetHeroClassItemTypeId(index))
endfunction

function GetHeroClassDescription takes integer index returns string
    return BlzGetAbilityExtendedTooltip(GetHeroClassItemTypeId(index), 0)
endfunction

function GetHeroClassByItemTypeId takes integer itemTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i == classesCounter)
        if (itemTypeId == classItemTypeIds[i]) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function AddHeroClass takes integer itemTypeId, integer abilityId0, string abilityTooltip0, integer abilityId1, string abilityTooltip1, integer abilityId2, string abilityTooltip2, integer abilityId3, string abilityTooltip3, integer abilityId4, string abilityTooltip4, integer abilityId5, string abilityTooltip5, integer abilityId6, string abilityTooltip6, integer abilityId7, string abilityTooltip7, integer abilityId8, string abilityTooltip8, integer abilityId9, string abilityTooltip9, integer abilityId10, string abilityTooltip10 returns integer
    local integer index = AddLearnableAbilityId(0, abilityId0)
    call SetAbilityTooltip(abilityId0, abilityTooltip0)
    set classItemTypeIds[classesCounter] = itemTypeId
    set classes[classesCounter] = index
    set classesCounter = classesCounter + 1
    call AddLearnableAbilityId(1, abilityId1)
    call SetAbilityTooltip(abilityId1, abilityTooltip1)
    call AddLearnableAbilityId(2, abilityId2)
    call SetAbilityTooltip(abilityId2, abilityTooltip2)
    call AddLearnableAbilityId(3, abilityId3)
    call SetAbilityTooltip(abilityId3, abilityTooltip3)
    call AddLearnableAbilityId(4, abilityId4)
    call SetAbilityTooltip(abilityId4, abilityTooltip4)
    call AddLearnableAbilityId(5, abilityId5)
    call SetAbilityTooltip(abilityId5, abilityTooltip5)
    call AddLearnableAbilityId(6, abilityId6)
    call SetAbilityTooltip(abilityId6, abilityTooltip6)
    call AddLearnableAbilityId(7, abilityId7)
    call SetAbilityTooltip(abilityId7, abilityTooltip7)
    call AddLearnableAbilityId(8, abilityId8)
    call SetAbilityTooltip(abilityId8, abilityTooltip8)
    call AddLearnableAbilityId(9, abilityId9)
    call SetAbilityTooltip(abilityId9, abilityTooltip9)
    call AddLearnableAbilityId(10, abilityId10)
    call SetAbilityTooltip(abilityId10, abilityTooltip10)
    return index
endfunction

function AssignHeroClass takes integer unitTypeId, integer heroClass returns nothing
    call SaveInteger(h, unitTypeId, 0, heroClass)
endfunction

function GetHeroClass takes integer unitTypeId returns integer
    local integer baseId = GetPrimaryDependencyEquivalent(unitTypeId)
    if (HaveSavedInteger(h, baseId, 0)) then
        return LoadInteger(h, baseId, 0)
    endif
    return CLASS_NONE
endfunction

function ApplySpecificHeroClass takes unit hero, integer heroClass, boolean showMessage returns boolean
    if (heroClass != -1) then
        call BlzSetUnitName(hero, GetHeroClassName(heroClass))
        //call BlzSetHeroProperName(hero, GetObjectName(classItemTypeIds[heroClass])) // TODO For campaign heroes
        call ChangeAllSlotAbilities(hero, heroClass)
        call ShowCurrentlySkilledAbilities(hero) // Updates icons and tooltips.

        if (showMessage) then
            call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedStringSafe("HERO_HAS_CLASS_X")).s(GetHeroClassName(heroClass)).result())
        endif

        return true
    endif

    return false
endfunction

function ApplyHeroClassEx takes unit hero, boolean showMessage returns boolean
    return ApplySpecificHeroClass(hero, GetHeroClass(GetUnitTypeId(hero)), showMessage)
endfunction

function ApplyHeroClass takes unit hero returns boolean
    return ApplyHeroClassEx(hero, false)
endfunction

function ApplyRandomHeroClassEx takes unit hero returns boolean
    return ApplySpecificHeroClass(hero, GetRandomHeroClass(), true)
endfunction

function ApplyMatchingHeroClass takes unit hero returns nothing
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        if (not ApplyHeroClassEx(hero, true)) then
            call SimError(GetOwningPlayer(hero), GetLocalizedStringSafe("NO_MATCHING_CLASS"))
        endif
    else
        call SimError(GetOwningPlayer(hero), GetLocalizedStringSafe("NO_MATCHING_CLASS"))
    endif
endfunction

function ApplyRandomHeroClass takes unit hero returns nothing
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        if (not ApplyRandomHeroClassEx(hero)) then
            call SimError(GetOwningPlayer(hero), GetLocalizedStringSafe("NO_MATCHING_CLASS"))
        endif
    else
        call SimError(GetOwningPlayer(hero), GetLocalizedStringSafe("NO_MATCHING_CLASS"))
    endif
endfunction

private function Init takes nothing returns nothing
    set CLASS_WARRIOR = AddHeroClass('I03K', ABILITY_STORM_BOLT, "STORM_BOLT_TOOLTIP", ABILITY_BERSERK, "BERSERK_TOOLTIP", ABILITY_THUNDER_CLAP, "THUNDER_CLAP_TOOLTIP", ABILITY_SPIKED_SHELL, "SPIKED_SHELL_TOOLTIP", ABILITY_WAR_STOMP, "WAR_STOMP_TOOLTIP", ABILITY_BASH, "BASH_TOOLTIP", ABILITY_CLEAVING_ATTACK, "CLEAVING_ATTACK_TOOLTIP", ABILITY_COMMAND_AURA, "COMMAND_AURA_TOOLTIP", ABILITY_IMPALE, "IMPALE_TOOLTIP", ABILITY_CLUB_STRIKE, "CLUB_STRIKE_TOOLTIP", ABILITY_AVATAR, "AVATAR_TOOLTIP")
    set CLASS_HUNTER = AddHeroClass('I07O', ABILITY_RAIN_OF_ARROWS, "RAIN_OF_ARROWS_TOOLTIP", ABILITY_SENTINEL, "SENTINEL_TOOLTIP", ABILITY_SCOUT, "SCOUT_TOOLTIP", ABILITY_SEARING_ARROWS, "SEARING_ARROWS_TOOLTIP", ABILITY_BARRAGE, "BARRAGE_TOOLTIP", ABILITY_SUMMON_BEAR, "SUMMON_BEAR_TOOLTIP", ABILITY_SUMMON_QUILBEAST, "SUMMON_QUILBEAST_TOOLTIP", ABILITY_SUMMON_HAWK, "SUMMON_HAWK_TOOLTIP", ABILITY_TRUESHOT_AURA, "TRUESHOT_AURA_TOOLTIP", ABILITY_MASS_DEVOUR, "MASS_DEVOUR_TOOLTIP", ABILITY_STARFALL, "STARFALL_TOOLTIP")
    set CLASS_PALADIN = AddHeroClass('I04K', ABILITY_HEAL, "HEAL_TOOLTIP", ABILITY_INNFER_FIRE, "INNER_FIRE_TOOLTIP", ABILITY_HOLY_LIGHT, "HOLY_LIGHT_TOOLTIP", ABILITY_DIVINE_SHIELD, "DIVINE_SHIELD_TOOLTIP", ABILITY_HEALING_WAVE, "HEALING_WAVE_TOOLTIP", ABILITY_HOLY_AURA, "HOLY_AURA_TOOLTIP", ABILITY_HEALING_SPRAY, "HEALING_SPRAY_TOOLTIP", ABILITY_DEVOTION_AURA, "DEVOTION_AURA_TOOLTIP", ABILITY_HOLY_NOVA, "HOLY_NOVA_TOOLTIP", ABILITY_HORN_OF_STORMWIND, "HORN_OF_STORMWIND_TOOLTIP", ABILITY_RESURRECTION, "RESURRECTION_TOOLTIP")
    set CLASS_DEATH_KNIGHT = AddHeroClass('I07P', ABILITY_CURSE, "CURSE_TOOLTIP", ABILITY_UNHOLY_FRENZY, "UNHOLY_FRENZY_TOOLTIP", ABILITY_BLACK_ARROW, "BLACK_ARROW_TOOLTIP", ABILITY_DEATH_COIL, "DEATH_COIL_TOOLTIP", ABILITY_CARRION_SWARM, "CARRION_SWARM_TOOLTIP", ABILITY_SLEEP, "SLEEP_TOOLTIP", ABILITY_UNHOLY_AURA, "UNHOLY_AURA_TOOLTIP", ABILITY_VAMPIRIC_AURA, "VAMPIRIC_AURA_TOOLTIP", ABILITY_ORB_OF_ANNHILIATION, "ORB_OF_ANNHILIATION_TOOLTIP", ABILITY_ANIMATE_DEAD, "ANIMATE_DEAD_TOOLTIP", ABILITY_DEATH_AND_DECAY, "DEATH_AND_DECAY_TOOLTIP")
    set CLASS_ROGUE = AddHeroClass('I07Q', ABILITY_ENSNARE, "ENSNARE_TOOLTIP", ABILITY_FAN_OF_KNIVES, "FAN_OF_KNIVES_TOOLTIP", ABILITY_CRITICAL_STRIKE, "CRITICAL_STRIKE_TOOLTIP", ABILITY_SHADOW_STRIKE, "SHADOW_STRIKE_TOOLTIP", ABILITY_ACID_BOMB, "ACID_BOMB_TOOLTIP", ABILITY_WIND_WALK, "WIND_WALK_TOOLTIP", ABILITY_FERAL_SPIRIT, "FERAL_SPIRIT_TOOLTIP", ABILITY_POISON_ARROWS, "POISON_ARROWS_TOOLTIP", ABILITY_ENVENOMED_WEAPONS, "ENVENOMED_WEAPONS_TOOLTIP", ABILITY_FIND_ARTIFACTS, "FIND_ARTIFACTS_TOOLTIP", ABILITY_VENGEANCE, "VENGEANCE_TOOLTIP")
    set CLASS_DRUID = AddHeroClass('I06Z', ABILITY_REJUVENATION, "REJUVENATION_TOOLTIP", ABILITY_FAERIE_FIRE, "FAERIE_FIRE_TOOLTIP", ABILITY_FORCE_OF_NATURE, "FORCE_OF_NATURE_TOOLTIP", ABILITY_THORNS_AURA, "THORNS_AURA_TOOLTIP", ABILITY_ENTANGLING_ROOTS, "ENTANGLING_ROOTS_TOOLTIP", ABILITY_FULL_REGENERATION, "FULL_REGENERATION_TOOLTIP", ABILITY_EAT_TREE, "EAT_TREE_TOOLTIP", ABILITY_MASS_FORESTATION, "MASS_FORESTATION_TOOLTIP", ABILITY_DRUID_FORMS, "DRUID_FORMS_TOOLTIP", ABILITY_ROAR, "ROAR_TOOLTIP", ABILITY_TRANQUILITY, "TRANQUILITY_TOOLTIP")
    set CLASS_WARLOCK = AddHeroClass('I04D', ABILITY_CRIPPLE, "CRIPPLE_TOOLTIP", ABILITY_MANA_BURN, "MANA_BURN_TOOLTIP", ABILITY_DEVOUR_MAGIC, "DEVOUR_MAGIC_TOOLTIP", ABILITY_FEL, "FEL_TOOLTIP", ABILITY_DARK_SUMMONING, "DARK_SUMMONING_TOOLTIP", ABILITY_HOWL_OF_TERROR, "HOWL_OF_TERROR_TOOLTIP", ABILITY_DOOM, "DOOM_TOOLTIP", ABILITY_DARK_PORTAL, "DARK_PORTAL_TOOLTIP", ABILITY_METAMORPHOSIS, "METAMORPHOSIS_TOOLTIP", ABILITY_RAIN_OF_CHAOS, "RAIN_OF_CHAOS_TOOLTIP", ABILITY_FINGER_OF_DEATH, "FINGER_OF_DEATH_TOOLTIP")
    set CLASS_MONK = AddHeroClass('I07R', ABILITY_SLIDE, "SLIDE_TOOLTIP", ABILITY_CHARGE, "CHARGE_TOOLTIP", ABILITY_DRUNKEN_BRAWLER, "DRUNKEN_BRAWLER_TOOLTIP", ABILITY_DISARMAMENT, "DISARMAMENT_TOOLTIP", ABILITY_DRUNKEN_HAZE, "DRUNKEN_HAZE_TOOLTIP", ABILITY_MISS_AURA, "MISS_AURA_TOOLTIP", ABILITY_MIRROR_IMAGE, "MIRROR_IMAGE_TOOLTIP", ABILITY_DRUNKEN_AURA, "DRUNKEN_AURA_TOOLTIP", ABILITY_CLONE, "CLONE_TOOLTIP", ABILITY_STORM_EARTH_FIRE, "STORM_EARTH_FIRE_TOOLTIP", ABILITY_BLADESTORM, "BLADESTORM_TOOLTIP")
    set CLASS_ARCANIST = AddHeroClass('I05H', ABILITY_BANISH, "BANISH_TOOLTIP", ABILITY_SPELL_STEAL, "SPELL_STEAL_TOOLTIP", ABILITY_CONTROL_MAGIC, "CONTROL_MAGIC_TOOLTIP", ABILITY_FEEDBACK, "FEEDBACK_TOOLTIP", ABILITY_INVISIBILITY, "INVISIBILITY_TOOLTIP", ABILITY_MANA_SHIELD, "MANA_SHIELD_TOOLTIP", ABILITY_SIPHON_MANA, "SIPHON_MANA_TOOLTIP", ABILITY_DISPEL_MAGIC, "DISPEL_MAGIC_TOOLTIP", ABILITY_BRILLIANCE_AURA, "BRILLIANCE_AURA_TOOLTIP", ABILITY_MASS_TELEPORT, "MASS_TELEPORT_TOOLTIP", ABILITY_POLYMORPH, "POLYMORPH_TOOLTIP")
    set CLASS_PYROMANCER = AddHeroClass('I04M', ABILITY_FIREBOLT, "FIREBOLT_TOOLTIP", ABILITY_IMMOLATION, "IMMOLATION_TOOLTIP", ABILITY_RAIN_OF_FIRE, "RAIN_OF_FIRE_TOOLTIP", ABILITY_FLAME_STRIKE, "FLAME_STRIKE_TOOLTIP", ABILITY_METEOR, "METEOR_TOOLTIP", ABILITY_SUMMON_LAVA_SPAWN, "SUMMON_LAVA_SPAWN_TOOLTIP", ABILITY_VOLCANO, "VOLCANO_TOOLTIP", ABILITY_FLAME_STORM, "FLAME_STORM_TOOLTIP", ABILITY_BREATH_OF_FIRE, "BREATH_OF_FIRE_TOOLTIP", ABILITY_INCINERATE, "INCINERATE_TOOLTIP", ABILITY_PHOENIX, "PHOENIX_TOOLTIP")
    set CLASS_HYDROMANCER = AddHeroClass('I07L', ABILITY_CRUSHING_WAVE, "CRUSHING_WAVE_TOOLTIP", ABILITY_FOUNTAIN_OF_POWER, "FOUNTAIN_OF_POWER_TOOLTIP", ABILITY_SUMMON_WATER_ELEMENTAL, "SUMMON_WATER_ELEMENTAL_TOOLTIP", ABILITY_REFLECTION, "REFLECTION_TOOLTIP", ABILITY_BREATH_OF_FROST, "BREATH_OF_FROST_TOOLTIP", ABILITY_FROST_ARMOR, "FROST_ARMOR_TOOLTIP", ABILITY_BLIZZARD, "BLIZZARD_TOOLTIP", ABILITY_FROST_NOVA, "FROST_NOVA_TOOLTIP", ABILITY_FROST_ARROWS, "FROST_ARROWS_TOOLTIP", ABILITY_FROST_BOLT, "FROST_BOLT_TOOLTIP", ABILITY_MONSOON, "MONSOON_TOOLTIP")
    set CLASS_GEOMANCER = AddHeroClass('I04L', ABILITY_HURL_BOULDER, "HURL_BOULDER_TOOLTIP", ABILITY_SUMMON_WALL, "SUMMON_WALL_TOOLTIP", ABILITY_ENDURANCE_AURA, "ENDURANCE_AURA_TOOLTIP", ABILITY_FAR_SIGHT, "FAR_SIGHT_TOOLTIP", ABILITY_SHOCKWAVE, "SHOCKWAVE_TOOLTIP", ABILITY_SLAM, "SLAM_TOOLTIP", ABILITY_SUMMON_GOLEM, "SUMMON_GOLEM_TOOLTIP", ABILITY_BLOODLUST, "BLOODLUST_TOOLTIP", ABILITY_EARTH_QUAKE, "EARTH_QUAKE_TOOLTIP", ABILITY_STAMPEDE, "STAMPEDE_TOOLTIP", ABILITY_REINCARNATION, "REINCARNATION_TOOLTIP")
    set CLASS_AEROMANCER = AddHeroClass('I070', ABILITY_CYCLONE, "CYCLONE_TOOLTIP", ABILITY_CHAIN_LIGHTNING, "CHAIN_LIGHTNING_TOOLTIP", ABILITY_WIND_GUST, "WIND_GUST_TOOLTIP", ABILITY_EVASION, "EVASION_TOOLTIP", ABILITY_CLOUD, "CLOUD_TOOLTIP", ABILITY_BLINK, "BLINK_TOOLTIP", ABILITY_FORKED_LIGHTNING, "FORKED_LIGHTNING_TOOLTIP", ABILITY_SUMMON_DJINN, "SUMMON_DJINN_TOOLTIP", ABILITY_AERIAL_SHACKLES, "AERIAL_SHACKLES_TOOLTIP", ABILITY_LIGHTNING_SHIELD, "LIGHTNING_SHIELD_TOOLTIP", ABILITY_TORNADO, "TORNADO_TOOLTIP")
    set CLASS_NECROMANCER = AddHeroClass('I07N', ABILITY_RAISE_DEAD, "RAISE_DEAD_TOOLTIP", ABILITY_CANNIBALIZE, "CANNIBALIZE_TOOLTIP", ABILITY_DEATH_PACT, "DEATH_PACT_TOOLTIP", ABILITY_DARK_RITUAL, "DARK_RITUAL_TOOLTIP", ABILITY_SUMMON_MEAT_WAGON, "SUMMON_MEAT_WAGON_TOOLTIP", ABILITY_CARRION_BEETLES, "CARRION_BEETLES_TOOLTIP", ABILITY_SKELETAL_MASTERY, "SKELETAL_MASTERY_TOOLTIP", ABILITY_SPAWN_TENTACLE, "SPAWN_TENTACLE_TOOLTIP", ABILITY_DISEASE_CLOUD, "DISEASE_CLOUD_TOOLTIP", ABILITY_LIFE_DRAIN, "LIFE_DRAIN_TOOLTIP", ABILITY_SUMMON_SAPPHIRON, "SUMMON_SAPPHIRON_TOOLTIP")
    set CLASS_WITCH_DOCTOR = AddHeroClass('I07M', ABILITY_SERPENT_WARD, "SERPENT_WARD_TOOLTIP", ABILITY_SILENCE, "SILENCE_TOOLTIP", ABILITY_SLOW, "SLOW_TOOLTIP", ABILITY_ANTIMAGIC_SHIELD, "ANTIMAGIC_SHIELD_TOOLTIP", ABILITY_HEX, "HEX_TOOLTIP", ABILITY_SCREAM, "SCREAM_TOOLTIP", ABILITY_GHOST_FORM, "GHOST_FORM_TOOLTIP", ABILITY_LOCUST_SWARM, "LOCUST_SWARM_TOOLTIP", ABILITY_SPELL_SHIELD, "SPELL_SHIELD_TOOLTIP", ABILITY_CHARM, "CHARM_TOOLTIP", ABILITY_BIG_BAD_VOODOO, "BIG_BAD_VOODOO_TOOLTIP")
    set CLASS_TINKER = AddHeroClass('I06Y', ABILITY_REPAIR, "REPAIR_TOOLTIP", ABILITY_HARVEST, "HARVEST_TOOLTIP", ABILITY_DEMOLISH, "DEMOLISH_TOOLTIP", ABILITY_POCKET_FACTORY, "POCKET_FACTORY_TOOLTIP", ABILITY_EXPLOSIVE_BARREL, "EXPLOSIVE_BARREL_TOOLTIP", ABILITY_REPAIR_AURA, "REPAIR_AURA_TOOLTIP", ABILITY_JETPACK, "JETPACK_TOOLTIP", ABILITY_CLUSTER_ROCKETS, "CLUSTER_ROCKETS_TOOLTIP", ABILITY_ENGINEERING_UPGRADE, "ENGINEERING_UPGRADE_TOOLTIP", ABILITY_TRANSMUTE, "TRANSMUTE_TOOLTIP", ABILITY_ROBO_GOBLIN, "ROBO_GOBLIN_TOOLTIP")
endfunction

endlibrary
