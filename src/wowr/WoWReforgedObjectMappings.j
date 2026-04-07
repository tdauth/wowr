library WoWReforgedObjectMappings initializer Init requires TinyBuildingsLimits, WoWReforgedBanners

globals
    private hashtable h = InitHashtable()
endglobals

function AddObjectMapping takes integer id, integer mapping returns nothing
    call SaveInteger(h, id, 0, mapping)
    call SaveInteger(h, mapping, 0, id)
endfunction

function GetObjectMapping takes integer id returns integer
    return LoadInteger(h, id, 0)
endfunction

private function AddBannersObjectMappings takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxBanners()
    loop
        exitwhen (i == max)
        call AddObjectMapping(GetBannerUnitTypeId(i), GetBannerItemTypeId(i))
        set i = i + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    call AddObjectMapping(POWER_GENERATOR, ITEM_TINY_POWER_GENERATOR)
    call AddObjectMapping(PORTAL, ITEM_TINY_PORTAL)
    call AddObjectMapping(RESEARCH_TENT, ITEM_TINY_RESEARCH_TENT)
    call AddObjectMapping(CRAFTING_STASH, ITEM_TINY_CRAFTING_STASH)
    call AddObjectMapping(TRAINER, ITEM_TINY_TRAINER)
    call AddObjectMapping(ARMORY, ITEM_TINY_ARMORY)
    call AddObjectMapping(TRADING_POST, ITEM_TINY_TRADING_POST)
    call AddObjectMapping(WITCH_HUT, ITEM_TINY_WITCH_HUT)
    call AddObjectMapping(HERO_ABILITIES, ITEM_TINY_HERO_ABILITIES)
    call AddObjectMapping(SKINS, ITEM_TINY_SKINS)
    call AddObjectMapping(FRUIT_STAND_ALL_RACES, ITEM_TINY_FRUIT_STAND_ALL_RACES)
    call AddObjectMapping(THIEVES_GUILD, ITEM_TINY_THIEVES_GUILD)
    call AddObjectMapping(MOUNTS_CAGE, ITEM_TINY_MOUNTS_CAGE)
    call AddObjectMapping(DRAGON_ROOST, ITEM_TINY_DRAGON_ROOST)
    call AddObjectMapping(CHEST, ITEM_TINY_CHEST)
    // Herbalist
    call AddObjectMapping(FOUNTAIN_OF_HEALTH, ITEM_FOUNTAIN_OF_HEALTH)
    // Alchemist
    call AddObjectMapping(FOUNTAIN_OF_MANA, ITEM_FOUNTAIN_OF_MANA)
    // Engineer
    call AddObjectMapping(FLAME_TOWER, ITEM_TINY_FLAME_TOWER)
    call AddObjectMapping(ADVANCED_FLAME_TOWER, ITEM_TINY_FLAME_TOWER)
    call AddObjectMapping(BOULDER_TOWER, ITEM_TINY_BOULDER_TOWER)
    call AddObjectMapping(ADANCED_BOULDER_TOWER, ITEM_TINY_BOULDER_TOWER)
    call AddObjectMapping(COLD_TOWER, ITEM_TINY_COLD_TOWER)
    call AddObjectMapping(ADVANCED_COLD_TOWER, ITEM_TINY_COLD_TOWER)
    call AddObjectMapping(DEATH_TOWER, ITEM_TINY_DEATH_TOWER)
    call AddObjectMapping(ADVANCED_DEATH_TOWER, ITEM_TINY_DEATH_TOWER)
    call AddObjectMapping(POWER_GENERATOR_ENGINEER, ITEM_POWER_GENERATOR_ENGINEER)
    // Demolition Expert
    call AddObjectMapping(GOBLIN_LAND_MINE, ITEM_GOBLIN_LAND_MINES)
    call AddObjectMapping(EXPLOSIVE_BARREL, ITEM_EXPLOSIVE_BARRELS)
    call AddObjectMapping(NUCLEAR_SILO, ITEM_NUCLEAR_SILO)
    // Dragon Breeder
    call AddObjectMapping(DRAGON_BREEDER_ROOST, ITEM_DRAGON_BREEDER_ROOST)
    // Captain
    call AddObjectMapping(SHIPYARD, ITEM_SHIPYARD)
    // Archaeologist
    call AddObjectMapping(EXCAVATION_SITE, ITEM_EXCAVATION_SITE)
    // Merchant
    call AddObjectMapping(MERCHANT_SHOP, ITEM_MERCHANT_SHOP)
    // Farmer
    call AddObjectMapping(FARM_FARMER, ITEM_TINY_FARM_FARMER)
    call AddObjectMapping(WATER_SUPPLY, ITEM_TINY_WATER_SUPPLY)
    call AddObjectMapping(GRANARY, ITEM_TINY_GRANARY)
    call AddObjectMapping(WIND_MILL, ITEM_TINY_WIND_MILL)
    call AddObjectMapping(ANIMAL_PEN_FARMER, ITEM_TINY_ANIMAL_PEN)
    // Tamer
    call AddObjectMapping(CAGE_TAMER, ITEM_CAGE)
    // Necromancer
    call AddObjectMapping(NECROMANCER_GRAVEYARD, ITEM_TINY_NECROMANCER_GRAVEYARD)
    // Golem Sculptor
    call AddObjectMapping(GOLEM_FACTORY, ITEM_TINY_GOLEM_FACTORY)
    // Hunter
    call AddObjectMapping(HUNTING_CAMP, ITEM_HUNTING_CAMP)
    // Cook
    call AddObjectMapping(FIRE_PIT_COOK, ITEM_FIRE_PIT)
    // Fisherman
    call AddObjectMapping(FISHING_PORT, ITEM_FISHING_PORT)
    call AddObjectMapping(FISH_MARKET_FISHERMAN, ITEM_FISH_MARKET)
    // Prospector
    call AddObjectMapping(GOLD_PANNING, ITEM_GOLD_PANNING)
    // Lumberjack
    call AddObjectMapping(SAWMILL, ITEM_SAWMILL)
    // Thief
    call AddObjectMapping(SAFE, ITEM_TINY_SAFE)
    call AddObjectMapping(THIEVES_GUILD_THIEF, ITEM_TINY_THIEVES_GUILD_THIEF)
    // Warlock
    call AddObjectMapping(FEL_FOUNTAIN_WARLOCK, ITEM_TINY_FEL_FOUNTAIN)
    // Astromancer
    call AddObjectMapping(ARCANE_OBSERVATORY_ASTROMANCER, ITEM_ARCANE_OBSERVATORY_ASTROMANCER)
    // Bard
    call AddObjectMapping(RECORD_PLAYER, ITEM_RECORD_PLAYER)
    // Banners
    call AddBannersObjectMappings()

    // Limits
    call AddTinyBuildingItem('A0F3', POWER_GENERATOR)
    call AddTinyBuildingItem('A19L', RESEARCH_TENT)
    call AddTinyBuildingItem('A1QU', ARMORY)
    call AddTinyBuildingItem('A21Y', DRAGON_ROOST)
    call AddTinyBuildingItem('A1BY', FREELANCER_TOWER)
    call AddTinyBuildingItem('A1BZ', FREELANCER_ADVANCED_TOWER)
    call AddTinyBuildingItem('AIbt', WATCH_TOWER)
    call AddTinyBuildingItem('A19I', GUARD_TOWER)
    call AddTinyBuildingItem('A19J', CANNON_TOWER)
    call AddTinyBuildingItem('A19K', ARCANE_TOWER)
    call AddTinyBuildingItem('A0GQ', HIGH_ELF_OUTPOST)
    call AddTinyBuildingItem('A242', HIGH_ELF_GUARD_TOWER)
    call AddTinyBuildingItem('A19F', HUMAN_HOUSING)
    call AddTinyBuildingItem('A19Y', ORC_HOUSING) // TODO Which one is ORC_HOUSING?
    call AddTinyBuildingItem('A19X', ORC_WATCH_TOWER)
    call AddTinyBuildingItem('A1B1', ORC_HOUSING)
    call AddTinyBuildingItem('A1AX', ELF_HOUSING)
    call AddTinyBuildingItem('A241', HIGH_ELF_HOUSING)
    call AddTinyBuildingItem('A1AN', ANCIENT_PROTECT)
    call AddTinyBuildingItem('A19G', HUMAN_ARCANE_OBSERVATORY)
    call AddTinyBuildingItem('A1A0', FOUNTAIN_OF_BLOOD)
    call AddTinyBuildingItem('A1B2', UNDEAD_LICH_KING)
    call AddTinyBuildingItem('A1AY', ELF_WORLD_TREE)
    call AddTinyBuildingItem('A240', HIGH_ELF_SUNWELL)
endfunction

endlibrary
