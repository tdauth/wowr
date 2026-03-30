library WoWReforgedResources initializer Init requires Resources, PlayerColorUtils, StringUtils, SafeString, SimError, SelectionUtils, WoWReforgedUtils, WoWReforgedRaces, WoWReforgedStats, WoWReforgedComputerStartLocations

globals
    private integer maxMines = 0
    private integer array mineTypes
    private integer array mineResource
    private integer array mineStartAmount

    private integer maxWaterMines = 0
    private integer array waterMineTypes
    private integer array waterMineResource
    private integer array waterMineStartAmount

    private integer randomMinesCounter = 0
    private integer randomWaterMinesCounter = 0

    private trigger triggerChatCommandGuiOn = CreateTrigger()
    private trigger triggerChatCommandGuiOff = CreateTrigger()
    private trigger triggerChatCommandInfo = CreateTrigger()
endglobals

function GetMaxMines takes nothing returns integer
    return maxMines
endfunction

function GetMineTypeId takes integer index returns integer
    return mineTypes[index]
endfunction

function GetMaxWaterMines takes nothing returns integer
    return maxWaterMines
endfunction

function GetWaterMineTypeId takes integer index returns integer
    return waterMineTypes[index]
endfunction

function GetRandomMinesCount takes nothing returns integer
    return randomMinesCounter
endfunction

function GetRandomWaterMinesCount takes nothing returns integer
    return randomWaterMinesCounter
endfunction

function GetMineTypeIndex takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i == maxMines)
        if (mineTypes[i] == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function AddWoWReforgedReturnBuilding takes unit whichUnit returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    call AddReturnBuilding(whichUnit)
    loop
        exitwhen (i == max)
        call SetUnitReturnResource(whichUnit, GetResource(i), true)
        set i = i + 1
    endloop
endfunction

function AddWoWReforgedOilShip takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceOil, 'A1PL', "harvest", 'A1PN', "spies", 'A1PO', "robogoblin", 200, 20, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

function AddWoWReforgedWorker takes unit producer, unit worker returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    call AddWorker(worker)
    loop
        exitwhen (i == max)
        if (not IsStandardResource(GetResource(i))) then
            call AddResourceToWorker(worker, GetResource(i), 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 10, 20, "gold")
        endif
        set i = i + 1
    endloop
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

function AddWoWReforgedFaithWorker takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceFavor, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

function AddWoWReforgedFaithMine takes unit mine returns nothing
    call AddMineEx(mine, udg_ResourceFavor, 200)
endfunction

function AddRandomMine takes integer buildingTypeId, integer resource, integer startAmount returns integer
    local integer index = maxMines
    set maxMines = maxMines + 1
    set mineTypes[index] = buildingTypeId
    set mineResource[index] = resource
    set mineStartAmount[index] = startAmount
    return index
endfunction

function AddRandomWaterMine takes integer buildingTypeId, integer resource, integer startAmount returns integer
    local integer index = maxWaterMines
    set maxWaterMines = maxWaterMines + 1
    set waterMineTypes[index] = buildingTypeId
    set waterMineResource[index] = resource
    set waterMineStartAmount[index] = startAmount
    return index
endfunction

function AddFishSchool takes unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 50000)
endfunction

function AddBerryBush takes unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceFruits, 500)
endfunction

// Call after initializing the global variables.
function InitRandomMines takes nothing returns nothing
    call AddRandomMine(GEMSTONES_MINE, udg_ResourceGemstones, 500)
    call AddRandomMine(ORE_MINE, udg_ResourceIron, 5000)
    call AddRandomMine(WELL, udg_ResourceWater, 5000)
    call AddRandomMine(OIL_PLATFORM, udg_ResourceOil, 1000)
    call AddRandomMine(FOOD_FARM, udg_ResourceGrain, 5000)
    call AddRandomMine(POWER_CRYSTAL_MINE, udg_ResourceElectricity, 2000)
    call AddRandomMine(MONUMENT, udg_ResourceFavor, 2000)
    call AddRandomMine(FRUIT_STAND, udg_ResourceFruits, 5000)
    call AddRandomMine(ROCKS_MINE, udg_ResourceRock, 2000)
    call AddRandomMine(ARGUNITE_MINE, udg_ResourceArgunite, 2000)
    call AddRandomMine(FEL_MINE, udg_ResourceFel, 2000)
    call AddRandomMine(ANIMAL_PEN, udg_ResourceWool, 2000)

    call AddRandomWaterMine(WATER_OIL_PLATFORM, udg_ResourceOil, 20000)
endfunction

private function FilterIsRandomMine takes nothing returns boolean
    return GetMineTypeIndex(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

private function ForGroupRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function RemoveRandomMinesAtAIStartLocation takes integer computerStartLocation returns nothing
    local ComputerStartLocation c =  GetComputerStartLocation(computerStartLocation)
    local group mines = CreateGroup()
    call GroupEnumUnitsInRange(mines, c.x, c.y, 4096.0, Filter(function FilterIsRandomMine))
    call ForGroup(mines, function ForGroupRemoveUnit)
    call GroupClear(mines)
    call DestroyGroup(mines)
    set mines = null
endfunction

function CreateMine takes unit source, integer index returns unit
    local real x = GetUnitX(source)
    local real y = GetUnitY(source)
    local unit result = ReplaceUnitBJ(source, mineTypes[index], bj_UNIT_STATE_METHOD_MAXIMUM)
    call SetUnitOwner(result, Player(PLAYER_NEUTRAL_PASSIVE), true)
    call SetUnitX(result, x)
    call SetUnitY(result, y)
    
    call AddMineEx(result, mineResource[index], mineStartAmount[index])
    
    return result
endfunction

function CreateRandomMine takes unit source returns unit
    local unit result = CreateMine(source, GetRandomInt(0, maxMines - 1))
    set randomMinesCounter = randomMinesCounter + 1
    
    return result
endfunction

function CreateRandomWaterMine takes unit source returns unit
    local integer random = GetRandomInt(0, maxWaterMines - 1)
    local real x = GetUnitX(source)
    local real y = GetUnitY(source)
    local unit result = ReplaceUnitBJ(source, waterMineTypes[random], bj_UNIT_STATE_METHOD_MAXIMUM)
    call SetUnitX(result, x)
    call SetUnitY(result, y)
    set randomWaterMinesCounter = randomWaterMinesCounter + 1
    
    call AddMineEx(result, waterMineResource[random], waterMineStartAmount[random])
    
    return result
endfunction

function GetRandomResourceExceptFood takes nothing returns Resource
    local Resource r
    local integer counter = 0
    local Resource array resources
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        set r = GetResource(i)
        if (r != Resources_FOOD and r != Resources_FOOD_MAX) then
            set resources[counter] = r
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    
    return resources[GetRandomInt(0, counter - 1)]
endfunction

function CreateRandomResources takes unit hero returns nothing
    if (GetRandomInt(0, 1) == 0) then
        call CustomBounty(hero, GetRandomResourceExceptFood(), GetRandomInt(0, 50))
    endif
endfunction

function RewardFlotsam takes unit flotsam, unit killer returns nothing
    if (GetRandomInt(0, 1) == 0) then
        call CustomBounty(flotsam, GetRandomResourceExceptFood(), GetRandomInt(5, 50))
    endif
endfunction

function UseMeatItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceMeat, 30)
endfunction

function UseFishItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceMeat, 30)
endfunction

function UseBananaItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UseLemonItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UseOrangeItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UseGarlicItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UsePumpkinItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UseAppleItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceFruits, 30)
endfunction

function UseBundleOfWheatItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceGrain, 30)
endfunction

function UseBlackPowderItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceBlackPowder, 12)
endfunction

function UseRockItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceRock, 25)
endfunction

function UseMilkItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceMilk, 30)
endfunction

function UseWoolItem takes unit hero returns nothing
    call CustomBounty(hero, udg_ResourceWool, 30)
endfunction

function AddFishingBoat takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceMeat, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 200, 20, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

function AddFarmhand takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceMeat, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    call AddResourceToWorker(worker, udg_ResourceGrain, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    call AddResourceToWorker(worker, udg_ResourceWater, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 20, 5, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

function AddFarmerSheep takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 30)
endfunction

function AddFarmerChicken takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 10)
endfunction

function AddFarmerCow takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 100)
endfunction

function AddFarmerPig takes unit farm, unit whichUnit returns nothing
    call AddMineEx(whichUnit, udg_ResourceMeat, 60)
endfunction

function AddFarm takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 200)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddWheatField takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 300)
endfunction

function AddCowshed takes unit whichUnit returns nothing
    call AddLoadedMine(whichUnit, udg_ResourceMilk, 800, 5)
    call SetLoadedMineAllowedWorkerUnitTypeId(whichUnit, COW, true)
    call SetMineExplodesOnDeath(whichUnit, true)
endfunction

function AddSheepfold takes unit whichUnit returns nothing
    call AddLoadedMine(whichUnit, udg_ResourceWool, 800, 5)
    call SetLoadedMineAllowedWorkerUnitTypeId(whichUnit, SHEEP, true)
    call SetMineExplodesOnDeath(whichUnit, true)
endfunction

function AddWaterSupply takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceWater, 500)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddGranary takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 400)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddWindMill takes unit whichUnit returns nothing
     call AddMineEx(whichUnit, udg_ResourceGrain, 600)
     call SetMineExplodesOnDeath(whichUnit, false)
endfunction

function AddOilBoat takes unit producer, unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker, udg_ResourceOil, 'A1PM', "heal", 'A1PN', "spies", 'A1PO', "robogoblin", 100, 100, "gold")
    if (producer != null) then
        call ReorderWorkerToMineRally(producer, worker)
    endif
endfunction

private function Add takes string name, string description, real exchangeRate, integer red, integer green, integer blue, string icon, string iconAtt returns integer
    local integer r = AddResource(name)
    call SetResourceGoldExchangeRate(r, exchangeRate)
    call SetResourceIcon(r, icon)
    call SetResourceIconAtt(r, iconAtt)
    call SetResourceDescription(r, description)
    call SetResourceColorRed(r, red)
    call SetResourceColorGreen(r, green)
    call SetResourceColorBlue(r, blue)
    
    return r
endfunction

function IsSellableResource takes integer index returns boolean
    return index >= 0 and index < GetMaxResources() and GetResource(index) != Resources_FOOD and GetResource(index) != Resources_FOOD_MAX
endfunction

function ShowResourceInfo takes player whichPlayer returns nothing
    local string msg = ""
    local group selected = GetUnitsSelectedAllSafe(whichPlayer)
    local unit first = null
    local integer i = 0
    local integer max = GetMaxResources()
    local integer r = 0
    set first = FirstOfGroup(selected)
    if (first != null) then
        loop
            exitwhen (i == max)
            set r = GetResource(i)
            if (GetUnitResourceMax(first, r) > 0 or GetUnitResource(first, r) > 0) then
                if (GetUnitResourceMax(first, r) > 0) then
                    if (not IsMine(first)) then
                        if (msg != "") then
                            set msg = msg + ", "
                        endif
                        set msg = msg + "Max " + GetResourceName(r) + ": " + I2S(GetUnitResourceMax(first, r))
                    endif
                endif
                if (GetUnitResource(first, r) > 0) then
                    if (msg != "") then
                        set msg = msg + ", "
                    endif
                    set msg = msg + "Carried " + GetResourceName(r) + ": " + I2S(GetUnitResource(first, r))
                endif
                if (not IsMine(first) and GetUnitResourcePerHit(first, r) > 0) then
                    if (msg != "") then
                        set msg = msg + ", "
                    endif
                
                    set msg = msg + "Per Hit " + GetResourceName(r) + ": " + I2S(GetUnitResourcePerHit(first, r))
                endif
            endif
            if (GetUnitReturnResource(first, r)) then
                if (msg != "") then
                    set msg = msg + ", "
                endif
            
                set msg = msg + "Allows returning " + GetResourceName(r)
            endif
            set i = i + 1
        endloop
        if (msg == "") then
            set msg = "No resources."
        endif
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, msg)
        set first = null
    else
        call SimError(whichPlayer, GetLocalizedString("NO_UNIT_SELECTED"))
    endif
    call GroupClear(selected)
    call DestroyGroup(selected)
    set selected = null
endfunction

function SellAllResources takes player whichPlayer returns nothing
    local integer r = 0
    local integer gold = 0
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        set r = GetResource(i)
        if (r != Resources_GOLD and r != Resources_LUMBER and r != Resources_FOOD and r != Resources_FOOD_MAX and GetResourceGoldExchangeRate(r) > 0.0 and GetPlayerResource(whichPlayer, r) > 0) then
            set gold = gold + ExchangePlayerResource(whichPlayer, r, Resources_GOLD, GetPlayerResource(whichPlayer, r))
        endif
        set i = i + 1
    endloop
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("SOLD_ALL_FOR_GOLD")).i(gold).result())
endfunction

function SellAllLumber takes player whichPlayer returns nothing
    local integer gold = 0
    if (GetResourceGoldExchangeRate(Resources_LUMBER) > 0.0 and GetPlayerResource(whichPlayer, Resources_LUMBER) > 0) then
        set gold = ExchangePlayerResource(whichPlayer, Resources_LUMBER, Resources_GOLD, GetPlayerResource(whichPlayer, Resources_LUMBER))
    endif
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("SOLD_ALL_LUMBER_FOR_GOLD")).i(gold).result())
endfunction

private function RefillUnitResources takes unit mine returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        call SetUnitResource(mine, i, GetUnitResourceMax(mine, i))
        set i = i + 1
    endloop
endfunction

function MagicalFiller takes unit caster, unit mine returns nothing
    if (IsMine(mine) or GetUnitAbilityLevel(mine, 'Agld') > 0) then
        if (GetUnitAbilityLevel(mine, 'Agld') > 0) then
            call SetResourceAmount(mine, 9999999999)
        endif
        if (IsMine(mine)) then
            call RefillUnitResources(mine)
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_MUST_BE_A_MINE"))
    endif
endfunction

private function EnumRegisterChatCommandEvents takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(triggerChatCommandGuiOn, GetEnumPlayer(), "-resgui", false)
    call TriggerRegisterPlayerChatEvent(triggerChatCommandGuiOn, GetEnumPlayer(), "-resguion", false)
    call TriggerRegisterPlayerChatEvent(triggerChatCommandGuiOff, GetEnumPlayer(), "-resguioff", false)
    call TriggerRegisterPlayerChatEvent(triggerChatCommandInfo, GetEnumPlayer(), "-resinfo", true)
    call TriggerRegisterPlayerChatEvent(triggerChatCommandInfo, GetEnumPlayer(), "-resourcesinfo", true)
endfunction

private function TriggerConditionChatCommandGuiOn takes nothing returns boolean
    local player targetPlayer = GetTriggerPlayer()
    local string token = StringToken(GetEventPlayerChatString(), 1)
    local player tokenPlayer = GetPlayerFromString(token)
    if (tokenPlayer != null) then
        set targetPlayer = tokenPlayer
    endif
    call ShowPlayerResourceMultiboard(targetPlayer)
    set udg_MultiboardsToggled[GetConvertedPlayerId(GetTriggerPlayer())] = true
    return false
endfunction

private function TriggerConditionChatCommandGuiOff takes nothing returns boolean
    call HidePlayerResourceMultiboard(GetTriggerPlayer())
    call ShowStatsMultiboard(GetTriggerPlayer())
    set udg_MultiboardsToggled[GetConvertedPlayerId(GetTriggerPlayer())] = false
    return false
endfunction

private function TriggerConditionChatCommandInfo takes nothing returns boolean
    call ShowResourceInfo(GetTriggerPlayer())
    return false
endfunction

private function Init takes nothing returns nothing
    call ForForce(GetPlayersByMapControl(MAP_CONTROL_USER), function EnumRegisterChatCommandEvents)
    call TriggerAddCondition(triggerChatCommandGuiOn, Condition(function TriggerConditionChatCommandGuiOn))
    call TriggerAddCondition(triggerChatCommandGuiOff, Condition(function TriggerConditionChatCommandGuiOff))
    call TriggerAddCondition(triggerChatCommandInfo, Condition(function TriggerConditionChatCommandInfo))

    set udg_ResourceGold = Resources_GOLD
    set udg_ResourceLumber = Resources_LUMBER
    set udg_ResourceOil = Add(GetLocalizedStringSafe("OIL"), GetLocalizedStringSafe("OIL_DESCRIPTION"), 2.0, 50, 50, 50, "ReplaceableTextures\\CommandButtons\\BTNOil.blp", "ReplaceableTextures\\CommandButtons\\BTNOil.blp")
    set udg_ResourceCopper = Add(GetLocalizedStringSafe("COPPER"), GetLocalizedStringSafe("COPPER_DESCRIPTION"), 0.25, 184, 115, 51, "ReplaceableTextures\\CommandButtons\\BTNCopperCoins.blp", "ReplaceableTextures\\CommandButtons\\BTNCopperCoins.blp")
    set udg_ResourceSilver = Add(GetLocalizedStringSafe("SILVER"), GetLocalizedStringSafe("SILVER_DESCRIPTION"), 0.5, 192, 192, 192, "ReplaceableTextures\\CommandButtons\\BTNSilverCoin.blp", "ReplaceableTextures\\CommandButtons\\BTNSilverCoin.blp")
    set udg_ResourceGemstones = Add(GetLocalizedStringSafe("GEMSTONES"), GetLocalizedStringSafe("GEMSTONES_DESCRIPTION"), 2.5, 192, 192, 192, "ReplaceableTextures\\CommandButtons\\BTNEnchantedGemstone.blp", "ReplaceableTextures\\CommandButtons\\BTNEnchantedGemstone.blp")
    set udg_ResourceMeat = Add(GetLocalizedStringSafe("MEAT"), GetLocalizedStringSafe("MEAT_DESCRIPTION"), 0.4, 255, 165, 0, "ReplaceableTextures\\CommandButtons\\BTNMonsterLure.blp", "ReplaceableTextures\\CommandButtons\\BTNMonsterLure.blp")
    set udg_ResourceGrain = Add(GetLocalizedStringSafe("GRAIN"), GetLocalizedStringSafe("GRAIN_DESCRIPTION"), 0.4, 243, 164, 2, "ReplaceableTextures\\CommandButtons\\BTNWheat.blp", "ReplaceableTextures\\CommandButtons\\BTNWheat.blp")
    set udg_ResourceMilk = Add(GetLocalizedStringSafe("MILK"), GetLocalizedStringSafe("MILK_DESCRIPTION"), 0.6, 255, 255, 255, "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Milk_04.blp", "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Milk_04.blp")
    set udg_ResourceWool = Add(GetLocalizedStringSafe("WOOL"), GetLocalizedStringSafe("WOOL_DESCRIPTION"), 1.2, 255, 255, 255, "ReplaceableTextures\\CommandButtons\\BTNSheep.blp", "ReplaceableTextures\\CommandButtons\\BTNSheep.blp")
    set udg_ResourceRock = Add(GetLocalizedStringSafe("ROCKS"), GetLocalizedStringSafe("ROCKS_DESCRIPTION"), 0.4, 128, 128, 128, "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Rock_01.blp", "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Rock_01.blp")
    set udg_ResourceIron = Add(GetLocalizedStringSafe("IRON"), GetLocalizedStringSafe("IRON_DESCRIPTION"), 0.5, 161, 157, 148, "ReplaceableTextures\\CommandButtons\\BTNINV_Ingot_Iron.blp", "ReplaceableTextures\\CommandButtons\\BTNINV_Ingot_Iron.blp")
    set udg_ResourceBlackPowder = Add(GetLocalizedStringSafe("BLACK_POWDER"), GetLocalizedStringSafe("BLACK_POWDER_DESCRIPTION"), 0.8, 0, 0, 0, "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne.blp", "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne.blp")    
    set udg_ResourceBlackPowder = Add(GetLocalizedStringSafe("WATER"), GetLocalizedStringSafe("WATER_DESCRIPTION"), 0.20, 14, 135, 204, "ReplaceableTextures\\CommandButtons\\BTNINV_WaterBucket.blp", "ReplaceableTextures\\CommandButtons\\BTNINV_WaterBucket.blp")
    set udg_ResourceElectricity = Add(GetLocalizedStringSafe("POWER"), GetLocalizedStringSafe("POWER_DESCRIPTION"), 1.30, 179, 206, 255, "ReplaceableTextures\\CommandButtons\\BTNElectricity Breakout.blp", "ReplaceableTextures\\CommandButtons\\BTNElectricity Breakout.blp")
    set udg_ResourceFavor = Add(GetLocalizedStringSafe("FAVOR"), GetLocalizedStringSafe("FAVOR_DESCRIPTION"), 1.1, 234, 208, 35, "ReplaceableTextures\\CommandButtons\\BTNTestOfFaith.blp", "ReplaceableTextures\\CommandButtons\\BTNTestOfFaith.blp")
    set udg_ResourceFruits = Add(GetLocalizedStringSafe("FRUITS"), GetLocalizedStringSafe("FRUITS_DESCRIPTION"), 0.4, 255, 165, 0, "ReplaceableTextures\\CommandButtons\\BTNOrange.blp", "ReplaceableTextures\\CommandButtons\\BTNOrange.blp")
    set udg_ResourceFel = Add(GetLocalizedStringSafe("FEL"), GetLocalizedStringSafe("FEL_DESCRIPTION"), 2.0, 50, 255, 50, "ReplaceableTextures\\CommandButtons\\BTNFelBurn.blp", "ReplaceableTextures\\CommandButtons\\BTNFelBurn.blp")
    set udg_ResourceArgunite = Add(GetLocalizedStringSafe("ARGUNITE"), GetLocalizedStringSafe("ARGUNITE_DESCRIPTION"), 2.0, 191, 85, 236, "ReplaceableTextures\\CommandButtons\\BTNBTNDraeneiPylon.dds", "ReplaceableTextures\\CommandButtons\\BTNBTNDraeneiPylon.dds")

    call InitRandomMines()
endfunction

endlibrary
