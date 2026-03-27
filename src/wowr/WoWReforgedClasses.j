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
    set CLASS_WARRIOR = AddHeroClass('I03K', ABILITY_STORM_BOLT, GetLocalizedStringSafe("STORM_BOLT_TOOLTIP"), ABILITY_BERSERK, GetLocalizedStringSafe("BERSERK_TOOLTIP"), ABILITY_THUNDER_CLAP, GetLocalizedStringSafe("THUNDER_CLAP_TOOLTIP"), ABILITY_SPIKED_SHELL, GetLocalizedStringSafe("SPIKED_SHELL_TOOLTIP"), ABILITY_WAR_STOMP, GetLocalizedStringSafe("WAR_STOMP_TOOLTIP"), ABILITY_BASH, GetLocalizedStringSafe("BASH_TOOLTIP"), ABILITY_CLEAVING_ATTACK, GetLocalizedStringSafe("CLEAVING_ATTACK_TOOLTIP"), ABILITY_COMMAND_AURA, GetLocalizedStringSafe("COMMAND_AURA_TOOLTIP"), ABILITY_IMPALE, GetLocalizedStringSafe("IMPALE_TOOLTIP"), ABILITY_CLUB_STRIKE, GetLocalizedStringSafe("CLUB_STRIKE_TOOLTIP"), ABILITY_AVATAR, GetLocalizedStringSafe("AVATAR_TOOLTIP"))
    set CLASS_HUNTER = AddHeroClass('I07O', ABILITY_RAIN_OF_ARROWS, GetLocalizedStringSafe("RAIN_OF_ARROWS_TOOLTIP"), ABILITY_SENTINEL, GetLocalizedStringSafe("SENTINEL_TOOLTIP"), ABILITY_SCOUT, GetLocalizedStringSafe("SCOUT_TOOLTIP"), ABILITY_SEARING_ARROWS, GetLocalizedStringSafe("SEARING_ARROWS_TOOLTIP"), ABILITY_BARRAGE, GetLocalizedStringSafe("BARRAGE_TOOLTIP"), ABILITY_SUMMON_BEAR, GetLocalizedStringSafe("SUMMON_BEAR_TOOLTIP"), ABILITY_SUMMON_QUILBEAST, GetLocalizedStringSafe("SUMMON_QUILBEAST_TOOLTIP"), ABILITY_SUMMON_HAWK, GetLocalizedStringSafe("SUMMON_HAWK_TOOLTIP"), ABILITY_TRUESHOT_AURA, GetLocalizedStringSafe("TRUESHOT_AURA_TOOLTIP"), ABILITY_MASS_DEVOUR, GetLocalizedStringSafe("MASS_DEVOUR_TOOLTIP"), ABILITY_STARFALL, GetLocalizedStringSafe("STARFALL_TOOLTIP"))
    set CLASS_PALADIN = AddHeroClass('I04K', ABILITY_HEAL, GetLocalizedStringSafe("HEAL_TOOLTIP"), ABILITY_INNFER_FIRE, GetLocalizedStringSafe("INNER_FIRE_TOOLTIP"), ABILITY_HOLY_LIGHT, GetLocalizedStringSafe("HOLY_LIGHT_TOOLTIP"), ABILITY_DIVINE_SHIELD, GetLocalizedStringSafe("DIVINE_SHIELD_TOOLTIP"), ABILITY_HEALING_WAVE, GetLocalizedStringSafe("HEALING_WAVE_TOOLTIP"), ABILITY_HOLY_AURA, GetLocalizedStringSafe("HOLY_AURA_TOOLTIP"), ABILITY_HEALING_SPRAY, GetLocalizedStringSafe("HEALING_SPRAY_TOOLTIP"), ABILITY_DEVOTION_AURA, GetLocalizedStringSafe("DEVOTION_AURA_TOOLTIP"), ABILITY_HOLY_NOVA, GetLocalizedStringSafe("HOLY_NOVA_TOOLTIP"), ABILITY_HORN_OF_STORMWIND, GetLocalizedStringSafe("HORN_OF_STORMWIND_TOOLTIP"), ABILITY_RESURRECTION, GetLocalizedStringSafe("RESURRECTION_TOOLTIP"))
    set CLASS_DEATH_KNIGHT = AddHeroClass('I07P', ABILITY_CURSE, GetLocalizedStringSafe("CURSE_TOOLTIP"), ABILITY_UNHOLY_FRENZY, GetLocalizedStringSafe("UNHOLY_FRENZY_TOOLTIP"), ABILITY_BLACK_ARROW, GetLocalizedStringSafe("BLACK_ARROW_TOOLTIP"), ABILITY_DEATH_COIL, GetLocalizedStringSafe("DEATH_COIL_TOOLTIP"), ABILITY_CARRION_SWARM, GetLocalizedStringSafe("CARRION_SWARM_TOOLTIP"), ABILITY_SLEEP, GetLocalizedStringSafe("SLEEP_TOOLTIP"), ABILITY_UNHOLY_AURA, GetLocalizedStringSafe("UNHOLY_AURA_TOOLTIP"), ABILITY_VAMPIRIC_AURA, GetLocalizedStringSafe("VAMPIRIC_AURA_TOOLTIP"), ABILITY_ORB_OF_ANNHILIATION, GetLocalizedStringSafe("ORB_OF_ANNHILIATION_TOOLTIP"), ABILITY_ANIMATE_DEAD, GetLocalizedStringSafe("ANIMATE_DEAD_TOOLTIP"), ABILITY_DEATH_AND_DECAY, GetLocalizedStringSafe("DEATH_AND_DECAY_TOOLTIP"))
    set CLASS_ROGUE = AddHeroClass('I07Q', ABILITY_ENSNARE, GetLocalizedStringSafe("ENSNARE_TOOLTIP"), ABILITY_FAN_OF_KNIVES, GetLocalizedStringSafe("FAN_OF_KNIVES_TOOLTIP"), ABILITY_CRITICAL_STRIKE, GetLocalizedStringSafe("CRITICAL_STRIKE_TOOLTIP"), ABILITY_SHADOW_STRIKE, GetLocalizedStringSafe("SHADOW_STRIKE_TOOLTIP"), ABILITY_ACID_BOMB, GetLocalizedStringSafe("ACID_BOMB_TOOLTIP"), ABILITY_WIND_WALK, GetLocalizedStringSafe("WIND_WALK_TOOLTIP"), ABILITY_FERAL_SPIRIT, GetLocalizedStringSafe("FERAL_SPIRIT_TOOLTIP"), ABILITY_POISON_ARROWS, GetLocalizedStringSafe("POISON_ARROWS_TOOLTIP"), ABILITY_ENVENOMED_WEAPONS, GetLocalizedStringSafe("ENVENOMED_WEAPONS_TOOLTIP"), ABILITY_FIND_ARTIFACTS, GetLocalizedStringSafe("FIND_ARTIFACTS_TOOLTIP"), ABILITY_VENGEANCE, GetLocalizedStringSafe("VENGEANCE_TOOLTIP"))        
    set CLASS_DRUID = AddHeroClass('I06Z', ABILITY_REJUVENATION, GetLocalizedStringSafe("REJUVENATION_TOOLTIP"), ABILITY_FAERIE_FIRE, GetLocalizedStringSafe("FAERIE_FIRE_TOOLTIP"), ABILITY_FORCE_OF_NATURE, GetLocalizedStringSafe("FORCE_OF_NATURE_TOOLTIP"), ABILITY_THORNS_AURA, GetLocalizedStringSafe("THORNS_AURA_TOOLTIP"), ABILITY_ENTANGLING_ROOTS, GetLocalizedStringSafe("ENTANGLING_ROOTS_TOOLTIP"), ABILITY_FULL_REGENERATION, GetLocalizedStringSafe("FULL_REGENERATION_TOOLTIP"), ABILITY_EAT_TREE, GetLocalizedStringSafe("EAT_TREE_TOOLTIP"), ABILITY_MASS_FORESTATION, GetLocalizedStringSafe("MASS_FORESTATION_TOOLTIP"), ABILITY_DRUID_FORMS, GetLocalizedStringSafe("DRUID_FORMS_TOOLTIP"), ABILITY_ROAR, GetLocalizedStringSafe("ROAR_TOOLTIP"), ABILITY_TRANQUILITY, GetLocalizedStringSafe("TRANQUILITY_TOOLTIP"))
    set CLASS_WARLOCK = AddHeroClass('I04D', ABILITY_CRIPPLE, GetLocalizedStringSafe("CRIPPLE_TOOLTIP"), ABILITY_MANA_BURN, GetLocalizedStringSafe("MANA_BURN_TOOLTIP"), ABILITY_DEVOUR_MAGIC, GetLocalizedStringSafe("DEVOUR_MAGIC_TOOLTIP"), ABILITY_FEL, GetLocalizedStringSafe("FEL_TOOLTIP"), ABILITY_DARK_SUMMONING, GetLocalizedStringSafe("DARK_SUMMONING_TOOLTIP"), ABILITY_HOWL_OF_TERROR, GetLocalizedStringSafe("HOWL_OF_TERROR_TOOLTIP"), ABILITY_DOOM, GetLocalizedStringSafe("DOOM_TOOLTIP"), ABILITY_DARK_PORTAL, GetLocalizedStringSafe("DARK_PORTAL_TOOLTIP"), ABILITY_METAMORPHOSIS, GetLocalizedStringSafe("METAMORPHOSIS_TOOLTIP"), ABILITY_RAIN_OF_CHAOS, GetLocalizedStringSafe("RAIN_OF_CHAOS_TOOLTIP"), ABILITY_FINGER_OF_DEATH, GetLocalizedStringSafe("FINGER_OF_DEATH_TOOLTIP"))
    set CLASS_MONK = AddHeroClass('I07R', ABILITY_SLIDE, GetLocalizedStringSafe("SLIDE_TOOLTIP"), ABILITY_CHARGE, GetLocalizedStringSafe("CHARGE_TOOLTIP"), ABILITY_DRUNKEN_BRAWLER, GetLocalizedStringSafe("DRUNKEN_BRAWLER_TOOLTIP"), ABILITY_DISARMAMENT, GetLocalizedStringSafe("DISARMAMENT_TOOLTIP"), ABILITY_DRUNKEN_HAZE, GetLocalizedStringSafe("DRUNKEN_HAZE_TOOLTIP"), ABILITY_MISS_AURA, GetLocalizedStringSafe("MISS_AURA_TOOLTIP"), ABILITY_MIRROR_IMAGE, GetLocalizedStringSafe("MIRROR_IMAGE_TOOLTIP"), ABILITY_DRUNKEN_AURA, GetLocalizedStringSafe("DRUNKEN_AURA_TOOLTIP"), ABILITY_CLONE, GetLocalizedStringSafe("CLONE_TOOLTIP"), ABILITY_STORM_EARTH_FIRE, GetLocalizedStringSafe("STORM_EARTH_FIRE_TOOLTIP"), ABILITY_BLADESTORM, GetLocalizedStringSafe("BLADESTORM_TOOLTIP"))
    set CLASS_ARCANIST = AddHeroClass('I05H', ABILITY_BANISH, GetLocalizedStringSafe("BANISH_TOOLTIP"), ABILITY_SPELL_STEAL, GetLocalizedStringSafe("SPELL_STEAL_TOOLTIP"), ABILITY_CONTROL_MAGIC, GetLocalizedStringSafe("CONTROL_MAGIC_TOOLTIP"), ABILITY_FEEDBACK, GetLocalizedStringSafe("FEEDBACK_TOOLTIP"), ABILITY_INVISIBILITY, GetLocalizedStringSafe("INVISIBILITY_TOOLTIP"), ABILITY_MANA_SHIELD, GetLocalizedStringSafe("MANA_SHIELD_TOOLTIP"), ABILITY_SIPHON_MANA, GetLocalizedStringSafe("SIPHON_MANA_TOOLTIP"), ABILITY_DISPEL_MAGIC, GetLocalizedStringSafe("DISPEL_MAGIC_TOOLTIP"), ABILITY_BRILLIANCE_AURA, GetLocalizedStringSafe("BRILLIANCE_AURA_TOOLTIP"), ABILITY_MASS_TELEPORT, GetLocalizedStringSafe("MASS_TELEPORT_TOOLTIP"), ABILITY_POLYMORPH, GetLocalizedStringSafe("POLYMORPH_TOOLTIP"))
    set CLASS_PYROMANCER = AddHeroClass('I04M', ABILITY_FIREBOLT, GetLocalizedStringSafe("FIREBOLT_TOOLTIP"), ABILITY_IMMOLATION, GetLocalizedStringSafe("IMMOLATION_TOOLTIP"), ABILITY_RAIN_OF_FIRE, GetLocalizedStringSafe("RAIN_OF_FIRE_TOOLTIP"), ABILITY_FLAME_STRIKE, GetLocalizedStringSafe("FLAME_STRIKE_TOOLTIP"), ABILITY_METEOR, GetLocalizedStringSafe("METEOR_TOOLTIP"), ABILITY_SUMMON_LAVA_SPAWN, GetLocalizedStringSafe("SUMMON_LAVA_SPAWN_TOOLTIP"), ABILITY_VOLCANO, GetLocalizedStringSafe("VOLCANO_TOOLTIP"), ABILITY_FLAME_STORM, GetLocalizedStringSafe("FLAME_STORM_TOOLTIP"), ABILITY_BREATH_OF_FIRE, GetLocalizedStringSafe("BREATH_OF_FIRE_TOOLTIP"), ABILITY_INCINERATE, GetLocalizedStringSafe("INCINERATE_TOOLTIP"), ABILITY_PHOENIX, GetLocalizedStringSafe("PHOENIX_TOOLTIP"))
    set CLASS_HYDROMANCER = AddHeroClass('I07L', ABILITY_CRUSHING_WAVE, GetLocalizedStringSafe("CRUSHING_WAVE_TOOLTIP"), ABILITY_FOUNTAIN_OF_POWER, GetLocalizedStringSafe("FOUNTAIN_OF_POWER_TOOLTIP"), ABILITY_SUMMON_WATER_ELEMENTAL, GetLocalizedStringSafe("SUMMON_WATER_ELEMENTAL_TOOLTIP"), ABILITY_REFLECTION, GetLocalizedStringSafe("REFLECTION_TOOLTIP"), ABILITY_BREATH_OF_FROST, GetLocalizedStringSafe("BREATH_OF_FROST_TOOLTIP"), ABILITY_FROST_ARMOR, GetLocalizedStringSafe("FROST_ARMOR_TOOLTIP"), ABILITY_BLIZZARD, GetLocalizedStringSafe("BLIZZARD_TOOLTIP"), ABILITY_FROST_NOVA, GetLocalizedStringSafe("FROST_NOVA_TOOLTIP"), ABILITY_FROST_ARROWS, GetLocalizedStringSafe("FROST_ARROWS_TOOLTIP"), ABILITY_FROST_BOLT, GetLocalizedStringSafe("FROST_BOLT_TOOLTIP"), ABILITY_MONSOON, GetLocalizedStringSafe("MONSOON_TOOLTIP"))
    set CLASS_GEOMANCER = AddHeroClass('I04L', ABILITY_HURL_BOULDER, GetLocalizedStringSafe("HURL_BOULDER_TOOLTIP"), ABILITY_SUMMON_WALL, GetLocalizedStringSafe("SUMMON_WALL_TOOLTIP"), ABILITY_ENDURANCE_AURA, GetLocalizedStringSafe("ENDURANCE_AURA_TOOLTIP"), ABILITY_FAR_SIGHT, GetLocalizedStringSafe("FAR_SIGHT_TOOLTIP"), ABILITY_SHOCKWAVE, GetLocalizedStringSafe("SHOCKWAVE_TOOLTIP"), ABILITY_SLAM, GetLocalizedStringSafe("SLAM_TOOLTIP"), ABILITY_SUMMON_GOLEM, GetLocalizedStringSafe("SUMMON_GOLEM_TOOLTIP"), ABILITY_BLOODLUST, GetLocalizedStringSafe("BLOODLUST_TOOLTIP"), ABILITY_EARTH_QUAKE, GetLocalizedStringSafe("EARTH_QUAKE_TOOLTIP"), ABILITY_STAMPEDE, GetLocalizedStringSafe("STAMPEDE_TOOLTIP"), ABILITY_REINCARNATION, GetLocalizedStringSafe("REINCARNATION_TOOLTIP"))
    set CLASS_AEROMANCER = AddHeroClass('I070', ABILITY_CYCLONE, GetLocalizedStringSafe("CYCLONE_TOOLTIP"), ABILITY_CHAIN_LIGHTNING, GetLocalizedStringSafe("CHAIN_LIGHTNING_TOOLTIP"), ABILITY_WIND_GUST, GetLocalizedStringSafe("WIND_GUST_TOOLTIP"), ABILITY_EVASION, GetLocalizedStringSafe("EVASION_TOOLTIP"), ABILITY_CLOUD, GetLocalizedStringSafe("CLOUD_TOOLTIP"), ABILITY_BLINK, GetLocalizedStringSafe("BLINK_TOOLTIP"), ABILITY_FORKED_LIGHTNING, GetLocalizedStringSafe("FORKED_LIGHTNING_TOOLTIP"), ABILITY_SUMMON_DJINN, GetLocalizedStringSafe("SUMMON_DJINN_TOOLTIP"), ABILITY_AERIAL_SHACKLES, GetLocalizedStringSafe("AERIAL_SHACKLES_TOOLTIP"), ABILITY_LIGHTNING_SHIELD, GetLocalizedStringSafe("LIGHTNING_SHIELD_TOOLTIP"), ABILITY_TORNADO, GetLocalizedStringSafe("TORNADO_TOOLTIP"))
    set CLASS_NECROMANCER = AddHeroClass('I07N', ABILITY_RAISE_DEAD, GetLocalizedStringSafe("RAISE_DEAD_TOOLTIP"), ABILITY_CANNIBALIZE, GetLocalizedStringSafe("CANNIBALIZE_TOOLTIP"), ABILITY_DEATH_PACT, GetLocalizedStringSafe("DEATH_PACT_TOOLTIP"), ABILITY_DARK_RITUAL, GetLocalizedStringSafe("DARK_RITUAL_TOOLTIP"), ABILITY_SUMMON_MEAT_WAGON, GetLocalizedStringSafe("SUMMON_MEAT_WAGON_TOOLTIP"), ABILITY_CARRION_BEETLES, GetLocalizedStringSafe("CARRION_BEETLES_TOOLTIP"), ABILITY_SKELETAL_MASTERY, GetLocalizedStringSafe("SKELETAL_MASTERY_TOOLTIP"), ABILITY_SPAWN_TENTACLE, GetLocalizedStringSafe("SPAWN_TENTACLE_TOOLTIP"), ABILITY_DISEASE_CLOUD, GetLocalizedStringSafe("DISEASE_CLOUD_TOOLTIP"), ABILITY_LIFE_DRAIN, GetLocalizedStringSafe("LIFE_DRAIN_TOOLTIP"), ABILITY_SUMMON_SAPPHIRON, GetLocalizedStringSafe("SUMMON_SAPPHIRON_TOOLTIP"))
    set CLASS_WITCH_DOCTOR = AddHeroClass('I07M', ABILITY_SERPENT_WARD, GetLocalizedStringSafe("SERPENT_WARD_TOOLTIP"), ABILITY_SILENCE, GetLocalizedStringSafe("SILENCE_TOOLTIP"), ABILITY_SLOW, GetLocalizedStringSafe("SLOW_TOOLTIP"), ABILITY_ANTIMAGIC_SHIELD, GetLocalizedStringSafe("ANTIMAGIC_SHIELD_TOOLTIP"), ABILITY_HEX, GetLocalizedStringSafe("HEX_TOOLTIP"), ABILITY_SCREAM, GetLocalizedStringSafe("SCREAM_TOOLTIP"), ABILITY_GHOST_FORM, GetLocalizedStringSafe("GHOST_FORM_TOOLTIP"), ABILITY_LOCUST_SWARM, GetLocalizedStringSafe("LOCUST_SWARM_TOOLTIP"), ABILITY_SPELL_SHIELD, GetLocalizedStringSafe("SPELL_SHIELD_TOOLTIP"), ABILITY_CHARM, GetLocalizedStringSafe("CHARM_TOOLTIP"), ABILITY_BIG_BAD_VOODOO, GetLocalizedStringSafe("BIG_BAD_VOODOO_TOOLTIP"))
    set CLASS_TINKER = AddHeroClass('I06Y', ABILITY_REPAIR, GetLocalizedStringSafe("REPAIR_TOOLTIP"), ABILITY_HARVEST, GetLocalizedStringSafe("HARVEST_TOOLTIP"), ABILITY_DEMOLISH, GetLocalizedStringSafe("DEMOLISH_TOOLTIP"), ABILITY_POCKET_FACTORY, GetLocalizedStringSafe("POCKET_FACTORY_TOOLTIP"), ABILITY_EXPLOSIVE_BARREL, GetLocalizedStringSafe("EXPLOSIVE_BARREL_TOOLTIP"), ABILITY_REPAIR_AURA, GetLocalizedStringSafe("REPAIR_AURA_TOOLTIP"), ABILITY_JETPACK, GetLocalizedStringSafe("JETPACK_TOOLTIP"), ABILITY_CLUSTER_ROCKETS, GetLocalizedStringSafe("CLUSTER_ROCKETS_TOOLTIP"), ABILITY_ENGINEERING_UPGRADE, GetLocalizedStringSafe("ENGINEERING_UPGRADE_TOOLTIP"), ABILITY_TRANSMUTE, GetLocalizedStringSafe("TRANSMUTE_TOOLTIP"), ABILITY_ROBO_GOBLIN, GetLocalizedStringSafe("ROBO_GOBLIN_TOOLTIP"))
endfunction

endlibrary
