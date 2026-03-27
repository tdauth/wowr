library WoWReforgedSkinDependencyEquivalents initializer Init requires SimError, WoWReforgedBackpacks, WoWReforgedEquipmentBags, WoWReforgedAccount

globals
    private hashtable h = InitHashtable()
    
    constant integer NEXT_SKIN_ABILITY_ID = 'A263'
    constant integer NEXT_SKIN_ITEM_ABILITY_ID = 'A0AK'
    constant integer NEXT_SKIN_UNIT_TYPE_ID = 'o0C0'
endglobals

function SetUnitSkinWithHeroIcon takes unit whichUnit, integer skinId returns nothing
    local player owner = GetOwningPlayer(whichUnit)
    call BlzSetUnitSkin(whichUnit, skinId)
    // The owner has to be changed to fix the hero icon.
    call SetUnitOwner(whichUnit, Player(PLAYER_NEUTRAL_PASSIVE), true)
    call SetUnitOwner(whichUnit, owner, true)
    call RefreshBackpackForPlayer(owner)
    call RecreateAllEquipmentBags(owner)
    set owner = null
endfunction

struct SkinDependencyEquivalents
    boolean primary // is the primary unit
    integer array ids[10]
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

function GetSkinDependencyEquivalents takes integer id returns SkinDependencyEquivalents
    return LoadInteger(h, id, 0)
endfunction

function AddSkinDependencyEquivalentsSingle takes integer id, integer other, boolean primary returns nothing
    local SkinDependencyEquivalents d = GetSkinDependencyEquivalents(id)
    if (d == 0) then
        set d = SkinDependencyEquivalents.create()
        call SaveInteger(h, id, 0, d)
    endif
    set d.primary = primary
    set d.ids[d.count] = other
    set d.count = d.count + 1
endfunction

function AddSkinDependencyEquivalents takes integer id, integer other returns nothing
    call AddSkinDependencyEquivalentsSingle(id, other, true)
    call AddSkinDependencyEquivalentsSingle(other, id, false)
endfunction

function IsSkinDependencyEquivalent takes integer id, integer other returns boolean
    local SkinDependencyEquivalents d = GetSkinDependencyEquivalents(id)
    if (d != 0) then
        return d.contains(other)
    endif
    
    return false
endfunction

function GetPrimarySkinDependencyEquivalent takes integer id returns integer
    local SkinDependencyEquivalents d = GetSkinDependencyEquivalents(id)
    local integer i = 0
    if (d != 0 and not d.primary and d.count > 0) then
        loop
            exitwhen (i >= d.count)
            if (GetSkinDependencyEquivalents(d.ids[i]).primary) then
                return d.ids[i]
            endif
            set i = i + 1
        endloop
    endif
    
    return id
endfunction

function NextSkin takes unit whichUnit returns nothing
    local integer id = BlzGetUnitSkin(whichUnit)
    local integer baseId = GetPrimarySkinDependencyEquivalent(id)
    local SkinDependencyEquivalents d = GetSkinDependencyEquivalents(baseId)
    local integer i = 0
    local integer array skins
    local integer skinsCounter = 0
    local integer currentIndex = 0
    local integer skinIndex = 0
    local integer skin = baseId
    if (d != 0 and d.count > 0) then
        set skins[0] = baseId
        set skinsCounter = skinsCounter + 1
        set i = 0
        loop
            exitwhen (i >= d.count)
            if (PlayerHasUnlocked(GetOwningPlayer(whichUnit), d.ids[i])) then
                if (id == d.ids[i]) then
                    set currentIndex = skinsCounter
                endif
                set skins[skinsCounter] = d.ids[i]
                set skinsCounter = skinsCounter + 1
            endif
            set i = i + 1
        endloop
        //call BJDebugMsg("Current skin index " + I2S(currentIndex) + " with skins counter " + I2S(skinsCounter))
        set skinIndex = ModuloInteger(currentIndex + 1, skinsCounter)
        set skin = skins[skinIndex]
        call SetUnitSkinWithHeroIcon(whichUnit, skin)
        call UnitAddAbility(whichUnit, 'A071') // hero glow
        call DisplayTextToPlayer(GetOwningPlayer(whichUnit), 0.0, 0.0, Format(GetLocalizedString("SKIN_CHANGED_RANGE")).s(GetObjectName(skin)).i(skinIndex + 1).i(skinsCounter).result()) // Changed skin to %1% (%2%/%3%).
    else
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("SKIN_NO_OTHER")) // No other skins.
    endif
endfunction

private function Init takes nothing returns nothing
    call AddSkinDependencyEquivalents(ARTHAS, ARTHAS_MOUNTED)
    call AddSkinDependencyEquivalents(ARCHMAGE, WIZARD)
    call AddSkinDependencyEquivalents(DARK_KNIGHT, KNIGHT)
    call AddSkinDependencyEquivalents(CAPTAIN_HERO, FOOTMAN)

    call AddSkinDependencyEquivalents(SHAMAN_HERO, WARLOCK)
    call AddSkinDependencyEquivalents(SHAMAN_HERO, FEL_WARLOCK)
    call AddSkinDependencyEquivalents(BLADE_MASTER, FEL_BLADEMASTER)
    call AddSkinDependencyEquivalents(RAIDER_HERO, FEL_RAIDER)
    call AddSkinDependencyEquivalents(PEON_HERO, FEL_PEON)
    call AddSkinDependencyEquivalents(KODO_BEAST_HERO, FEL_KODO_BEAST)
    
    // Undead

    call AddSkinDependencyEquivalents(BANSHEE, WRAITH)
    call AddSkinDependencyEquivalents(BANSHEE_HERO, WRAITH)

    
    call AddSkinDependencyEquivalents(KEEPER, KEEPER_OF_THE_GROVE_GHOST)
    call AddSkinDependencyEquivalents(KEEPER, CENARIUS_HERO)
    
    call AddSkinDependencyEquivalents(MOUNTAIN_GIANT_HERO, 'e012') // Frost Giant
    call AddSkinDependencyEquivalents(MOUNTAIN_GIANT_HERO, 'e013') // Molten Giant
    call AddSkinDependencyEquivalents(MOUNTAIN_GIANT_HERO, SEA_GIANT) // Molten Giant
    
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, ANCIENT_WAR)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, ANCIENT_WIND)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, TREE_AGES)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, TREE_ETERNITY)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, TREE_LIFE)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, ANCIENT_PROTECT)
    call AddSkinDependencyEquivalents(ANCIENT_OF_LORE_HERO, DEN_OF_WONDERS)
    
    call AddSkinDependencyEquivalents(RANGER, DARK_RANGER)
    call AddSkinDependencyEquivalents(RANGER, RANGER_NIGHT_ELF)
    
    call AddSkinDependencyEquivalents(WITCH_DOCTOR_HERO, 'ndth') // Dark Troll High Priest
    call AddSkinDependencyEquivalents(WITCH_DOCTOR_HERO, 'nfsh') // Forest Troll High Priest
    call AddSkinDependencyEquivalents(WITCH_DOCTOR_HERO, 'nith') // Ice Troll High Priest

    call AddSkinDependencyEquivalents(TROLL_WARLORD, 'Ndtw') // Dark Troll Warlord
    call AddSkinDependencyEquivalents(TROLL_WARLORD, 'nitw') // Ice Troll Warlord
    
    call AddSkinDependencyEquivalents(FURBOLG_URSA_WARRIOR_HERO, 'nfpu') // Polar Furbolg Ursa Warrior
    
    call AddSkinDependencyEquivalents(NAGA_SORCERESS, LADY_VASHJ)
    call AddSkinDependencyEquivalents(NAGA_SORCERESS, NAGA_SIREN_HERO)
    
    call AddSkinDependencyEquivalents(DARK_VALKYR, GOLDEN_VALKYR)
    
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, 'nggr') // Granite Golem
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, 'ngrk') // Mud Golem
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, 'nggm') // Moss Covered Granite Golem
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, 'ngst') // Rock Golem
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, 'nfgl') // Flesh Golem
    call AddSkinDependencyEquivalents(SIEGE_GOLEM, DIVINE_GOLEM)
    
    call AddSkinDependencyEquivalents(SALAMANDER_LORD, 'nslv') // Salamander Vizier
    call AddSkinDependencyEquivalents(SALAMANDER_LORD, 'nstw') // Storm Wyrm
    
    call AddSkinDependencyEquivalents(HARPY_QUEEN, 'nhrr') // Harpy Rogue
    call AddSkinDependencyEquivalents(HARPY_QUEEN, 'nhrw') // Harpy Windwitch
    
    call AddSkinDependencyEquivalents(ANCIENT_SASQUATCH, ANCIENT_WENDIGO)
    call AddSkinDependencyEquivalents(ANCIENT_SASQUATCH, ENRANGED_JUNGLE_STALKER)
    
    call AddSkinDependencyEquivalents(BROOD_MOTHER, 'nsgp') // Forest Spider
    call AddSkinDependencyEquivalents(BROOD_MOTHER, 'nsgt') // Giant Spider
    
    call AddSkinDependencyEquivalents(RED_DRAGON_HERO, BLACK_DRAGON)
    call AddSkinDependencyEquivalents(RED_DRAGON_HERO, BRONZE_DRAGON)
    call AddSkinDependencyEquivalents(RED_DRAGON_HERO, BLUE_DRAGON)
    call AddSkinDependencyEquivalents(RED_DRAGON_HERO, GREEN_DRAGON)
    call AddSkinDependencyEquivalents(RED_DRAGON_HERO, NETHER_DRAGON)
    
    call AddSkinDependencyEquivalents(GNOMISH_SUBMARINE_HERO, GOBLIN_SUBMARINE_HERO)
    call AddSkinDependencyEquivalents(GNOMISH_SUBMARINE_HERO, DWARF_SUBMARINE_HERO)
    
    call AddSkinDependencyEquivalents(GNOMISH_SUBMARINE_HERO_PILOT, GOBLIN_SUBMARINE_HERO)
    
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, ORC_JUGGERNAUGHT)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, UNDEAD_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, ELF_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, BLOOD_ELF_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, HIGH_ELF_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, KULTIRAS_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, KULTIRAS_DREADNOUGHT)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, KULTIRAS_PIRATE_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, PANDAREN_BATTLESHIP)
    call AddSkinDependencyEquivalents(HUMAN_BATTLESHIP_HERO, WORGEN_BATTLESHIP)
endfunction

endlibrary
