library WoWReforgedGuiTriggers requires MathUtils
// Remove this library when all GUI triggers have been refactored into vJass code.

// Call this in a GUI trigger with map initialization event which is executed AFTER InitGlobals in war3map.j.
function InitWoWReforgedGuiVariables takes nothing returns nothing
    // Game Modes
    set udg_FreelancerXPRate = 130.0
    set udg_WarlordXPRate = 100.0
    set udg_FreelancerBonusAttributes = 15
    // Professions
    set udg_ProfessionHerbalist = PROFESSION_HERBALIST
    set udg_ProfessionAlchemist = PROFESSION_ALCHEMIST
    set udg_ProfessionWeaponSmith = PROFESSION_WEAPON_SMITH
    set udg_ProfessionArmourer = PROFESSION_ARMORER
    set udg_ProfessionEngineer = PROFESSION_ENGINEER
    set udg_ProfessionDemolitionExpert = PROFESSION_DEMOLITION_EXPERT
    set udg_ProfessionLoreMaster = PROFESSION_LORE_MASTER
    set udg_ProfessionSorcerer = PROFESSION_SORCERER
    set udg_ProfessionRuneforger = PROFESSION_RUNE_FORGER
    set udg_ProfessionDragonBreeder = PROFESSION_DRAGON_BREEDER
    set udg_ProfessionJewelcrafter = PROFESSION_JEWELCRAFTER
    set udg_ProfessionEnchanter = PROFESSION_ENCHANTER
    set udg_ProfessionPirate = PROFESSION_CAPTAIN
    set udg_ProfessionArchaeologist = PROFESSION_ARCHAEOLOGIST
    set udg_ProfessionWitchDoctor = PROFESSION_WITCH_DOCTOR
    set udg_ProfessionMerchant = PROFESSION_MERCHANT
    set udg_ProfessionFarmer = PROFESSION_FARMER
    set udg_ProfessionTamer = PROFESSION_TAMER
    set udg_ProfessionInscriptor = PROFESSION_INSCRIPTOR
    set udg_ProfessionNecromancer = PROFESSION_NECROMANCER
    set udg_ProfessionGolemSculptor = PROFESSION_GOLEM_SCULPTOR
    set udg_ProfessionCombiner = PROFESSION_COMBINER
    set udg_ProfessionHunter = PROFESSION_HUNTER
    set udg_ProfessionMiner = PROFESSION_MINER
    set udg_ProfessionCook = PROFESSION_COOK
    set udg_ProfessionFisherman = PROFESSION_FISHERMAN
    set udg_ProfessionProspector = PROFESSION_PROSPECTOR
    set udg_ProfessionLumberjack = PROFESSION_LUMBERJACK
    set udg_ProfessionWarlock = PROFESSION_WARLOCK
    set udg_ProfessionThief = PROFESSION_THIEF
    set udg_ProfessionAstromancer = PROFESSION_ASTROMANCER
    set udg_ProfessionBard = PROFESSION_BARD
    set udg_ProfessionScribe = PROFESSION_SCRIBE
    // Races
    set udg_RaceNone = 0
    set udg_RaceFreelancer = RACE_FREELANCER
    set udg_RaceHuman = WOWR_RACE_HUMAN
    set udg_RaceOrc = WOWR_RACE_ORC
    set udg_RaceUndead = WOWR_RACE_UNDEAD
    set udg_RaceNightElf = WOWR_RACE_NIGHT_ELF
    set udg_RaceBloodElf = WOWR_RACE_BLOOD_ELF
    set udg_RaceNaga = WOWR_RACE_NAGA
    set udg_RaceDraenei = WOWR_RACE_DRAENEI
    set udg_RaceLostOnes = WOWR_RACE_LOST_ONES
    set udg_RaceDemon = WOWR_RACE_DEMON
    set udg_RaceFurbolg = WOWR_RACE_FURBOLG
    set udg_RaceDwarf = WOWR_RACE_DWARF
    set udg_RaceGoblin = WOWR_RACE_GOBLIN
    set udg_RaceHighElf = WOWR_RACE_HIGH_ELF
    set udg_RaceGnome = WOWR_RACE_GNOME
    set udg_RaceTroll = WOWR_RACE_TROLL
    set udg_RaceTauren = WOWR_RACE_TAUREN
    set udg_RacePandaren = WOWR_RACE_PANDAREN
    set udg_RaceLordaeron = WOWR_RACE_LORDAERON
    set udg_RaceStormwind = WOWR_RACE_STORMWIND
    set udg_RaceDalaran = WOWR_RACE_DALARAN
    set udg_RaceKulTiras = WOWR_RACE_KUL_TIRAS
    set udg_RaceWorgen = WOWR_RACE_WORGEN
    set udg_RaceVrykul = WOWR_RACE_VRYKUL
    set udg_RaceNerubian = WOWR_RACE_NERUBIAN
    set udg_RaceTuskarr = WOWR_RACE_TUSKARR
    set udg_RaceMurloc = WOWR_RACE_MURLOC
    set udg_RaceOgre = WOWR_RACE_OGRE
    set udg_RaceFelOrc = WOWR_RACE_FEL_ORC
    set udg_RaceFacelessOne = WOWR_RACE_FACELESS_ONE
    set udg_RaceSatyr = WOWR_RACE_SATYR
    set udg_RaceCentaur = WOWR_RACE_CENTAUR
    set udg_RaceGnoll = WOWR_RACE_GNOLL
    set udg_RaceKobold = WOWR_RACE_KOBOLD
    set udg_RaceQuillboar = WOWR_RACE_QUILLBOAR
    set udg_RaceBandit = WOWR_RACE_BANDIT
    set udg_RaceDungeon = WOWR_RACE_DUNGEON
    set udg_RaceDragonkin = WOWR_RACE_DRAGONKIN
    // Attributes
    set udg_AttributeAttributePoints = ATTRIBUTE_ATTRIBUTE_POINTS
    set udg_AttributeSkillPoints = ATTRIBUTE_SKILL_POINTS
    // Resources
    set udg_ResourceGold = Resources_GOLD
    set udg_ResourceLumber = Resources_LUMBER
    set udg_ResourceOil = RESOURCE_OIL
    set udg_ResourceCopper = RESOURCE_COPPER
    set udg_ResourceSilver = RESOURCE_SILVER
    set udg_ResourceGemstones = RESOURCE_GEMSTONES
    set udg_ResourceMeat = RESOURCE_MEAT
    set udg_ResourceGrain = RESOURCE_GRAIN
    set udg_ResourceMilk = RESOURCE_MILK
    set udg_ResourceWool = RESOURCE_WOOL
    set udg_ResourceRock = RESOURCE_ROCK
    set udg_ResourceIron = RESOURCE_IRON
    set udg_ResourceBlackPowder = RESOURCE_BLACK_POWDER
    set udg_ResourceWater = RESOURCE_WATER
    set udg_ResourceElectricity = RESOURCE_POWER
    set udg_ResourceFavor = RESOURCE_FAVOR
    set udg_ResourceFruits = RESOURCE_FRUITS
    set udg_ResourceFel = RESOURCE_FEL
    set udg_ResourceArgunite = RESOURCE_ARGUNITE
    // Recipes
    set udg_RecipeBootsOfTeleportation = RECIPE_BOOTS_OF_TELEPORTATION
    set udg_RecipeGoblinLandMines = RECIPE_GOBLIN_LAND_MINES
    set udg_RecipePotionOfGreaterHealing = RECIPE_POTION_OF_GREATER_HEALING
    set udg_RecipePotionOfGreaterMana = RECIPE_POTION_OF_GREATER_MANA
    set udg_RecipeCooking = RECIPE_COOKING
endfunction

// Global variables are useful for GUI triggers.

function InitTmpLocations takes nothing returns nothing
    if udg_TmpLocation == null then
        set udg_TmpLocation = Location(0.0, 0.0)
    endif

    if udg_TmpLocation2 == null then
        set udg_TmpLocation2 = Location(0.0, 0.0)
    endif
endfunction

function MoveTmpLocation takes real x, real y returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, x, y)
endfunction

function MoveTmpLocationToDestination takes unit whichUnit returns nothing
    call MoveLocation(udg_TmpLocation, WaygateGetDestinationX(whichUnit), WaygateGetDestinationY(whichUnit))
endfunction

function MoveTmpLocationToSpellTarget takes nothing returns nothing
    call InitTmpLocations()
    call MoveTmpLocation(GetSpellTargetX(), GetSpellTargetY())
endfunction

function MoveTmpLocation2 takes real x, real y returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation2, x, y)
endfunction

function MoveTmpLocationToUnit takes unit whichUnit returns nothing
    call InitTmpLocations()
    call MoveLocationToUnit(udg_TmpLocation, whichUnit)
endfunction

function MoveTmpLocation2ToUnit takes unit whichUnit returns nothing
    call InitTmpLocations()
    call MoveLocationToUnit(udg_TmpLocation2, whichUnit)
endfunction

function MoveTmpLocationToRect takes rect whichRect returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

function MoveTmpLocationToDestructable takes destructable d returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetDestructableX(d), GetDestructableY(d))
endfunction

function MoveTmpLocationToItem takes item whichItem returns nothing
    call InitTmpLocations()
    call MoveLocationToItem(udg_TmpLocation, whichItem)
endfunction

function MoveTmpLocationToRandomPointInRect takes rect whichRect returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetRandomReal(GetRectMinX(whichRect), GetRectMaxX(whichRect)), GetRandomReal(GetRectMinY(whichRect), GetRectMaxY(whichRect)))
endfunction

endlibrary
