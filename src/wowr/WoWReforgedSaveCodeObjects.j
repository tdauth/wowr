// TODO Create a system SaveCodeObjectSystem depending on the SaveCodeSystem which allows registering any IDs in a 2D array.
// Init after races and professions.
library WoWReforgedSaveCodeObjects initializer Init requires SaveCodeSystem, WoWReforgedRaces, WoWReforgedNeutral, WoWReforgedProfessions, WoWReforgedResearches, WoWReforgedQuests, WoWReforgedBanners, WoWReforgedObjectMappings, WoWReforgedProfessionHunter, WoWReforgedArena, WoWReforgedEquipment, WoWReforgedEquipment

globals
    private hashtable h = InitHashtable()

    private integer array unitIds
    private integer unitIdsCounter = 0

    private integer array buildingIds
    private integer buildingIdsCounter = 0

    private integer array itemIds
    private integer itemIdsCounter = 0

    private integer array researchIds
    private integer array researchRaces
    private integer researchIdsCounter = 0
endglobals

function GetSaveObjectUnitMax takes nothing returns integer
    return unitIdsCounter
endfunction

function GetSaveObjectBuildingMax takes nothing returns integer
    return buildingIdsCounter
endfunction

function GetSaveObjectResearchMax takes nothing returns integer
    return researchIdsCounter
endfunction

function DisplaySaveObjectCounters takes nothing returns nothing
    call BJDebugMsg("Save Object Unit Counter: " + I2S(unitIdsCounter))
    call BJDebugMsg("Save Object Building Counter: " + I2S(buildingIdsCounter))
    call BJDebugMsg("Save Object Item Counter: " + I2S(itemIdsCounter))
    call BJDebugMsg("Save Object Research Counter: " + I2S(researchIdsCounter))
endfunction

function DisplayDuplicateSaveObjects takes nothing returns nothing
    local integer j
    local integer i = 0
    call BJDebugMsg("Save Object Duplicates:")
    loop
        exitwhen (i == unitIdsCounter)
        set j = 0
        loop
            exitwhen (j == unitIdsCounter)
            if (i != j and unitIds[i] == unitIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(unitIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == buildingIdsCounter)
        set j = 0
        loop
            exitwhen (j == buildingIdsCounter)
            if (i != j and buildingIds[i] == buildingIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(buildingIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == itemIdsCounter)
        set j = 0
        loop
            exitwhen (j == itemIdsCounter)
            if (i != j and itemIds[i] == itemIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(itemIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        
        set j = 0
        loop
            exitwhen (j == GetQuestsMax())
            if (itemIds[i] == GetQuestReward(j)) then
                call BJDebugMsg("Quest reward item save object " + GetObjectName(itemIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == researchIdsCounter)
        set j = 0
        loop
            exitwhen (j == researchIdsCounter)
            if (i != j and researchIds[i] == researchIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(researchIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddUnit takes integer id returns integer
    local integer index = unitIdsCounter
    call SaveInteger(h, id, 0, index)
    set unitIds[index] = id
    set unitIdsCounter = unitIdsCounter + 1
    return index
endfunction

private function AddBuilding takes integer id returns integer
    local integer index = buildingIdsCounter
    local integer mappingId = GetObjectMapping(id)
    call SaveInteger(h, id, 0, index)
    set buildingIds[index] = id
    set buildingIdsCounter = buildingIdsCounter + 1
    
    if (mappingId != 0) then
        call SaveInteger(h, mappingId, 0, index + 1)
        set buildingIds[index + 1] = mappingId
        set buildingIdsCounter = buildingIdsCounter + 1
    endif
    
    return index
endfunction

function GetSaveObjectUnitType takes integer id returns integer
    if (HaveSavedInteger(h, id, 0)) then
        return LoadInteger(h, id, 0)
    endif
    return -1
endfunction

function GetSaveObjectUnitId takes integer number returns integer
    return unitIds[number]
endfunction

function GetSaveObjectBuildingType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectBuildingId takes integer number returns integer
    return buildingIds[number]
endfunction

private function AddItem takes integer id returns integer
    local integer index = itemIdsCounter
    call SaveInteger(h, id, 0, index)
    set itemIds[index] = id
    set itemIdsCounter = itemIdsCounter + 1
    return index
endfunction

function GetSaveObjectItemType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectItemId takes integer number returns integer
    return itemIds[number]
endfunction

function GetSaveObjectItemMax takes nothing returns integer
    return itemIdsCounter
endfunction

private function AddResearch takes integer id, integer whichRace returns integer
    local integer index = researchIdsCounter
    call SaveInteger(h, id, 0, index)
    set researchIds[index] = id
    set researchRaces[index] = whichRace
    set researchIdsCounter = researchIdsCounter + 1
    return index
endfunction

function GetSaveObjectResearchType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectResearchId takes integer index returns integer
    return researchIds[index]
endfunction

function GetSaveObjectResearchRace takes integer index returns integer
    return researchRaces[index]
endfunction

private function AddItemsFromProfessions takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()
    local integer j = 0
    local integer max2 = 0
    local integer k = 0
    local integer max3 = 0
    loop
        exitwhen (i == max)
        call AddItem(GetProfession(i).bookItemTypeId)
        set j = 0
        set max2 = PROFESSION_RANK_MAX
        loop
            exitwhen (j == max2)
            set k = 0
            set max3 = GetProfessionCraftedItemsCount(i, j)
            loop
                exitwhen (k == max3)
                if (GetProfessionCraftedItem(i, j, k) != 0) then
                    call AddItem(GetProfessionCraftedItem(i, j, k))
                endif
                set k = k + 1
            endloop
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddItemsFromRecipes takes nothing returns nothing
    local integer itemTypeId = 0
    local integer i = 0
    local integer max = GetRecipesMax()
    loop
        exitwhen (i == max)
        if (not GetRecipeIsUnit(i)) then
            set itemTypeId = GetRecipeItemTypeId(i)
            if (itemTypeId != 0) then
                call AddItem(itemTypeId)
            endif
        endif
        set i = i + 1
    endloop
endfunction

private function AddItemsFromBanners takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxBanners()
    loop
        exitwhen (i == max)
        call AddItem(GetBannerItemTypeId(i))
        set i = i + 1
    endloop
endfunction

private function AddBuildingsFromBanners takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxBanners()
    loop
        exitwhen (i == max)
        call AddUnit(GetBannerUnitTypeId(i))
        set i = i + 1
    endloop
endfunction

private function AddRaceItemsSaveObjects takes nothing returns nothing
    local integer i = 1
    local integer max = GetRacesMax()
    local integer j = 0
    local integer max2 = 0
    local integer array addedObjectTypeIds
    local integer addedObjectTypeIdsCounter = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceItem(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddItem(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddRaceUnitsSaveObjects takes nothing returns nothing
    local integer i = udg_RaceFreelancer
    local integer max = GetRacesMax()
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceUnit(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddUnit(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddRaceBuildingsSaveObjects takes nothing returns nothing
    local integer i = udg_RaceFreelancer
    local integer max = GetRacesMax()
    local integer j = 0
    local integer max2 = 0
    local integer array addedObjectTypeIds
    local integer addedObjectTypeIdsCounter = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = RACE_MAX_OBJECT_TYPES
        loop
            exitwhen (j == max2)
            if (IsRaceBuilding(j) and GetRaceObjectTypeId(i, j) != 0) then
                call AddBuilding(GetRaceObjectTypeId(i, j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddCreepsSaveObjects takes nothing returns nothing
    local integer i = 0
    local integer max = GetCreepsMax()
    loop
        exitwhen (i == max)
        if (GetCreep(i) != 0) then
            call AddUnit(GetCreep(i))
        endif
        set i = i + 1
    endloop
endfunction

private function AddItemsFromTrophies takes nothing returns nothing
    local integer i = 0
    local integer max = GetTrophyCounter()
    loop
        exitwhen (i == max)
        call AddItem(GetTrophyItemTypeId(i))
        set i = i + 1
    endloop
endfunction

private function AddItemsFromArena takes nothing returns nothing
    local integer i = 0
    local integer max = GetArenaTicketsMax()
    loop
        exitwhen (i == max)
        if (GetArenaTicket(i).rewardItemTypeId != 0) then
            call AddItem(GetArenaTicket(i).rewardItemTypeId)
        endif
        set i = i + 1
    endloop
endfunction

private function AddItemsFromEquipment takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxEquipmentItemTypes()
    loop
        exitwhen (i == max)
        if (GetEquipmentItemTypeId(i) != 0) then
            call AddItem(GetEquipmentItemTypeId(i))
        endif
        set i = i + 1
    endloop
endfunction

private function AddItemsFromItemSets takes nothing returns nothing
    local ItemSet s = 0
    local integer j = 0
    local integer counter = 0
    local integer i = 0
    local integer max = GetItemSetsMax()
    loop
        exitwhen (i == max)
        set s = GetItemSet(i)
        set counter = 0
        set j = 0
        loop
            exitwhen (j == s.componentsCounter)
            call AddItem(s.components[j])
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddItems takes nothing returns nothing
    // NEUTRAL SHOPS
    // Goblin Merchant
    call AddItem('I00V')
    call AddItem('I017')
    call AddItem('I120')
    call AddItem('I02V')
    call AddItem('I18H')
    call AddItem('I02W')
    call AddItem('I08X')
    call AddItem('lmbr')
    call AddItem('I0HW')
    // Goblin Laboratory
    call AddItem('I0L0')
    call AddItem('I0Q1')
    call AddItem('I19U')
    call AddItem('I0BV')
    // Black Market
    call AddItem('spsh')
    call AddItem('dust')
    call AddItem('afac')
    call AddItem('ajen')
    call AddItem('kpin')
    call AddItem('lgdh')
    call AddItem('tret')
    call AddItem('sbch')
    call AddItem('ward')
    call AddItem('war2')
    call AddItem('lhst')
    // Arcane Academy of Theramore
    call AddItem('I09F')
    call AddItem('gopr')
    call AddItem('gfor')
    call AddItem('gomn')
    call AddItem('guvi')
    call AddItem('I044')
    call AddItem('I043')
    call AddItem('I042')
    // Auction House
    call AddItem('I12Q')
    call AddItem('I12R')
    // Misc
    call AddItem('I0JM')
    call AddItem('gold')
    call AddItem('I0KN')
    call AddItem('I0KT')
    call AddItem('fgun')
    call AddItem('I145')
    // SPECIAL
    // Demigod
    call AddItem('I00X')
    call AddItem('I00W')
    // RACE SHOPS
    // Goblin Shop
    call AddItem('I049')
    // Dwarf Shop
    call AddItem('I058')
    // High Elf Shop
    call AddItem('I05J')
    // Troll Shop
    call AddItem('I0J9')
    // Tauren Shop
    call AddItem('I0QW')
    // Dalaran Shop
    call AddItem('I0OY')
    // Kul Tiras Shop
    call AddItem('I09U')
    // Lordaeron Shop
    call AddItem('I0JA')
    call AddItem('I0KZ')
    // Worgen Shop
    call AddItem('I0P1')
    call AddItem('I0P0')
    call AddItem('I0OZ')
    // Vrykul Shop
    call AddItem('I0OX')
    // Nerubian Shop
    call AddItem('I0NI')
    call AddItem('I0NJ')
    // Murloc Shop
    call AddItem('I11G')
    // Tuskarr Shop
    call AddItem('I0Q2')
    // Kobold Shop
    call AddItem('I11F')
    call AddItem('I11E')
    // Centaur Shop
    call AddItem('I129')
    // Worgen Shop
    call AddItem('I0DM')
    // Dungeon Shop
    call AddItem('I0GH')
    // OTHER ITEMS
    // Power Ups
    call AddItem('texp')
    call AddItem('I156')
    call AddItem('manh')
    call AddItem('I13F')
    call AddItem('I13E')
    call AddItem('I13G')
    call AddItem('I1A8')
    call AddItem('I1A7')
    call AddItem('I1AB')
    call AddItem('I1AC')
    call AddItem('I1A4')
    call AddItem('tstr')
    call AddItem('tst2')
    call AddItem('tdex')
    call AddItem('tdx2')
    call AddItem('tint')
    call AddItem('tin2')
    call AddItem('tpow')
    call AddItem('I1A5')
    call AddItem('I1A6')
    call AddItem('I183')
    call AddItem('I184')
    call AddItem('rdis')
    call AddItem('rhe3')
    call AddItem('rma2')
    call AddItem('rre2')
    call AddItem('rhe2')
    call AddItem('rhe1')
    call AddItem('rre1')
    call AddItem('rman')
    call AddItem('rreb')
    call AddItem('rres')
    call AddItem('rsps')
    call AddItem('rspd')
    call AddItem('rspl')
    call AddItem('rwat')
    // Artifacts
    call AddItem('ckng')
    call AddItem('tkno')
    // Other
    call AddItem('hslv')
    call AddItem('rat3')
    call AddItem('rat6')
    call AddItem('rat9')
    call AddItem('ratc')
    call AddItem('rst1')
    call AddItem('hval')
    call AddItem('hcun')
    call AddItem('rde0')
    call AddItem('rde1')
    call AddItem('rde2')
    call AddItem('rde3')
    call AddItem('ofro')
    call AddItem('ocor')
    call AddItem('ofir')
    call AddItem('ofr2')
    call AddItem('oli2')
    call AddItem('olig')
    call AddItem('oslo')
    call AddItem('oven')
    call AddItem('odef')
    call AddItem('sorf')
    call AddItem('amrc')
    call AddItem('axas')
    // Permanent
    call AddItem('rhth')
    call AddItem('spre')
    call AddItem('ssan')
    call AddItem('rin1')
    call AddItem('bgst')
    call AddItem('belv')
    call AddItem('bspd')
    call AddItem('cnob')
    call AddItem('desc')
    call AddItem('mcou')
    call AddItem('penr')
    call AddItem('pmna')
    call AddItem('prvt')
    call AddItem('rlif')
    call AddItem('ciri')
    call AddItem('brac')
    call AddItem('rag1')
    call AddItem('rwiz')
    call AddItem('evtl')
    call AddItem('I0U4')
    call AddItem('I0W4')
    // Charged
    call AddItem('pdiv')
    call AddItem('pdi2')
    call AddItem('fgdg')
    call AddItem('fgbd')
    call AddItem('engr')
    call AddItem('iotw')
    call AddItem('fgfh')
    call AddItem('scav')
    call AddItem('ccmd')
    call AddItem('I0KL')
    call AddItem('I0KM')
    call AddItem('I0KN')
    call AddItem('I0S8')
    call AddItem('I0U2')
    call AddItem('I0U3')
    call AddItem('I0WW')
    call AddItem('I140')
    call AddItem('I141')
    call AddItem('I0EJ')
    call AddItem('I0FE')
    call AddItem('I0FP')
    call AddItem('I0X1')
    call AddItem('I0FY')
    call AddItem('I0FZ')
    call AddItem('I0KU')
    call AddItem('I0N5')
    call AddItem('I0Q4')
    call AddItem('I0VO')
    // Misc
    call AddItem('gemt')
    call AddItem('fgrd')
    call AddItem('I0D7')
    call AddItem('I0HJ')
    call AddItem('wild')
    call AddItem('pams')
    call AddItem('plcl')
    call AddItem('pclr')
    call AddItem('rej1')
    call AddItem('rej2')
    call AddItem('rej3')
    call AddItem('rej4')
    call AddItem('rej5')
    call AddItem('rej6')
    call AddItem('mcri')
    call AddItem('pdiv')
    call AddItem('pinv')
    call AddItem('pnvl')
    call AddItem('pres')
    call AddItem('sreg')
    call AddItem('I17W')
    call AddItem('shas')
    call AddItem('vamp')
    call AddItem('I0VS')
    call AddItem('I0VU')
    call AddItem('I0VY')
    call AddItem('I0HF')
    // Respawning Items
    call AddItem('I08A')
    call AddItem('I089')
    call AddItem('I08B')
    call AddItem('I092')
    call AddItem('I090')
    call AddItem('I11P')
    call AddItem('I09C')
    call AddItem('I0B1')
    call AddItem('I08T')
    call AddItem('I095')
    call AddItem('I0JP')
    call AddItem('I0KK')
    call AddItem('I0XI')
    call AddItem('I0OI')
    // PROFESSION ITEMS
    call AddItem('I0KS')
    call AddItem('I142')
    call AddItem('I0FF')
    call AddItem('I0FO')
    call AddItem('I0FV')
    call AddItemsFromProfessions()
    call AddItemsFromTrophies()
    // RACE ITEMS
    call AddRaceItemsSaveObjects()
    // CRAFTING STASH
    call AddItemsFromRecipes()
    // EQUIPMENT ITEMS
    call AddItemsFromEquipment()
    // ARENA REWARD ITEMS
    call AddItemsFromArena()
    // BANNER ITEMS
    call AddItemsFromBanners()
    // SET ITEMS
    call AddItemsFromItemSets()
endfunction

private function AddUnits takes nothing returns nothing
    // Neutral
    call AddUnit('nzep')
    call AddUnit('ngsp')
    call AddUnit('ngir')
    call AddUnit('n0M5')
    call AddUnit('n0H6')
    call AddUnit('n03J')
    call AddUnit('n03F')
    call AddUnit('n070')
    call AddUnit('n06T')
    call AddUnit('n06Z')
    call AddUnit('nbot')
    call AddUnit('n03H')
    call AddUnit('h029')
    // CREEP UNITS
    call AddCreepsSaveObjects()
    // RACE UNITS
    call AddRaceUnitsSaveObjects()
endfunction

private function ExcludeResearchFromSaveObjects takes integer researchId returns boolean
    if (researchId == UPG_EVOLUTION) then
        return true
    elseif (researchId == UPG_CHEAP_EVOLUTION) then
        return true
    endif
    return false
endfunction

private function AddResearches takes nothing returns nothing
    local integer i = 0
    local integer max = GetResearchesMax()
    local Research r = 0
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        if (not ExcludeResearchFromSaveObjects(r.researchId) and r.researchId != 0) then
            call AddResearch(r.researchId, r.whichRace)
        endif
        set i = i + 1
    endloop
endfunction

private function AddBuildings takes nothing returns nothing
    // All Races
    call AddBuilding('n025')
    call AddBuilding('n042')
    call AddBuilding('n054')
    call AddBuilding('h014')
    call AddBuilding('h04V')
    call AddBuilding('o04H')
    call AddBuilding('o054')
    call AddBuilding('o025')
    call AddBuilding('n09D')
    call AddBuilding('nmrk')
    call AddBuilding('n09L')
    call AddBuilding('o01Z')
    call AddBuilding('n04J')
    call AddBuilding('n079')
    call AddBuilding('n0GD')
    call AddBuilding('o05F')
    call AddBuilding('n0IS')
    call AddBuilding('n0E6')
    call AddBuilding('h04Q')
    call AddBuilding('h04R')
    call AddBuilding('h04S')
    call AddBuilding('h020')
    call AddBuilding('h021')
    call AddBuilding('n0ND')
    call AddBuilding('n0NE')
    call AddBuilding('h00M')
    call AddBuilding('h00N')
    // RACES
    call AddRaceBuildingsSaveObjects()
    // BANNER BUILDINGS
    call AddBuildingsFromBanners()
endfunction

private function Init takes nothing returns nothing
    call AddItems()
    call AddUnits()
    call AddBuildings()
    call AddResearches()
endfunction

endlibrary
