library WoWReforgedGuiTriggers requires MathUtils
// Remove this library when all GUI triggers have been refactored into vJass code.

// Call this in a GUI trigger with map initialization event which is executed AFTER InitGlobals in war3map.j.
function InitWoWReforgedGuiVariables takes nothing returns nothing
    // Game Modes
    set udg_FreelancerXPRate = 130.0
    set udg_WarlordXPRate = 100.0
    set udg_FreelancerBonusAttributes = 15
    // Professions
    set udg_ProfessionNone = PROFESSION_NONE
    set udg_ProfessionScribe = PROFESSION_SCRIBE
    // Races
    set udg_RaceNone = 0
    set udg_RaceFreelancer = RACE_FREELANCER
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
