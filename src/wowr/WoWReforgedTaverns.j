library WoWReforgedTaverns initializer Init requires PagedButtons, OpLimit, UnitGroupUtils, WoWReforgedUtils, WoWReforgedHeroes, WoWReforgedRaces, WoWReforgedProfessions, WoWReforgedStartLocations, WoWReforgedPrestoredSaveCodes

globals
    private unit tmpUnit = null
    private integer index = 0
    private string tmpString = null
    
    private group gameModeTaverns = CreateGroup()
    private group heroesTaverns = CreateGroup()
    private group racesTaverns = CreateGroup()
    private group professionsTaverns = CreateGroup()
    private group startLocationsTaverns = CreateGroup()
    
    private trigger sellTrigger = CreateTrigger()
endglobals

function AddGameModesTavern takes unit tavern returns nothing
    call GroupAddUnit(gameModeTaverns, tavern)
endfunction

private function AddHeroToTavern takes nothing returns nothing
    local unit tavern = tmpUnit
    local integer i = index
    local string pageName = tmpString
    if (GetHeroCategory(i) != "" and GetHeroCategory(i) != null and GetHeroCategory(i) != pageName) then
        set pageName = GetHeroCategory(i)
        call NextPagedButtonsPage(tavern, pageName)
        set tmpString = pageName
    endif
    call AddPagedButtonsUnitType(tavern, GetHeroUnitType(i))
endfunction

function AddHeroesTavern takes unit tavern returns nothing
    local integer i = 0
    local integer max = GetHeroesMax()
    local string pageName = ""
    call GroupAddUnit(heroesTaverns, tavern)
    call EnablePagedButtons(tavern)
    call SetPagedButtonsSlotsPerPage(tavern, 9)
    
    call AddPagedButtonsItemType(tavern, ITEM_TYPE_RANDOM_HERO)
    
    set i = 0
    loop
        exitwhen (i >= max)
        set index = i
        set tmpUnit = tavern
        set tmpString = pageName
        call NewOpLimit(function AddHeroToTavern)
        set pageName = tmpString
        set i = i + 1
    endloop
    
    call NextPagedButtonsPage(tavern, GetLocalizedString("BOSSES"))
    set i = 0
    set max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i >= max)
        call AddPagedButtonsUnitType(tavern, GetUnitTypeId(BlzGroupUnitAt(udg_Bosses, i)))
        set i = i + 1
    endloop
    
    call SetPagedButtonsPage(tavern, 0)
endfunction

function AddRacesTavern takes unit tavern returns nothing
    local integer i = 1 // skip udg_RaceNone
    call GroupAddUnit(racesTaverns, tavern)
    call EnablePagedButtons(tavern)
    call SetPagedButtonsSlotsPerPage(tavern, 9)
    
    call AddPagedButtonsItemType(tavern, ITEM_TYPE_RANDOM_RACE)
    
    set i = 1 // skip udg_RaceNone
    loop
        exitwhen (i >= GetRacesMax())
        call AddPagedButtonsItemType(tavern, udg_RaceTavernItemType[i])
        set i = i + 1
    endloop
    call SetPagedButtonsPage(tavern, 0)
endfunction

function AddProfessionsTavern takes unit tavern returns nothing
    local integer i = 0
    call GroupAddUnit(professionsTaverns, tavern)
    call EnablePagedButtons(tavern)
    call SetPagedButtonsSlotsPerPage(tavern, 9)
    
    call AddPagedButtonsItemType(tavern, ITEM_TYPE_RANDOM_PROFESSION)
    
    set i = 0
    loop
        exitwhen (i >= GetProfessionsMax())
        call AddPagedButtonsItemType(tavern, GetProfessionItemTypeId(i))
        set i = i + 1
    endloop
    call SetPagedButtonsPage(tavern, 0)
endfunction

function AddStartLocationsTavern takes unit tavern returns nothing
    local integer i = 0
    call GroupAddUnit(startLocationsTaverns, tavern)
    call EnablePagedButtons(tavern)
    call SetPagedButtonsSlotsPerPage(tavern, 9)
    call AddPagedButtonsItemType(tavern, ITEM_TYPE_RANDOM_START_LOCATION)
    set i = 0
    loop
        exitwhen (i >= GetMaxStartLocations())
        call AddPagedButtonsItemType(tavern, GetStartLocationItemTypeId(i))
        set i = i + 1
    endloop
    call SetPagedButtonsPage(tavern, 0)
endfunction

function SelectRandomGameMode takes unit buyingUnit, unit tavern returns integer
    local player owner = GetOwningPlayer(buyingUnit)
    local integer id = ITEM_WARLORD
    if (GetRandomInt(0, 1) == 0) then
        set id = ITEM_FREELANCER
    endif
    
    call IssueNeutralImmediateOrderById(owner, tavern, id)
    
    set owner = null
    
    return id
endfunction

function SelectRandomHero takes unit buyingUnit, unit tavern returns nothing
    local player owner = GetOwningPlayer(buyingUnit)
    local integer array availableIds
    local integer availableIdsCounter = 0
    local integer id = 0
    local integer random = 0
    local integer page = 0
    local integer i = 0
    local integer max = GetHeroesMax()
    loop
        exitwhen (i >= max)
        set id = GetHeroUnitType(i)
        if (PlayerCanBuyHeroEx(owner, id)) then
            set availableIds[availableIdsCounter] = id
            set availableIdsCounter = availableIdsCounter + 1
        endif
        set i = i + 1
    endloop
    if (GetHeroLevel1(owner) >= 50) then
        set i = 0
        set max = BlzGroupGetSize(udg_Bosses)
        loop
            exitwhen (i >= max)
            set id = GetUnitTypeId(BlzGroupUnitAt(udg_Bosses, i))
            if (PlayerCanBuyHeroEx(owner, id)) then
                set availableIds[availableIdsCounter] = id
                set availableIdsCounter = availableIdsCounter + 1
            endif
            set i = i + 1
        endloop
    endif
    
    set random = GetRandomInt(0, availableIdsCounter - 1)
    set id = availableIds[random]
    //call BJDebugMsg("Selected random " + GetObjectName(id))
    set index = GetPagedButtonIndex(tavern, id)
    //call BJDebugMsg("index " + I2S(index))
    set page = GetPagedButtonsPageByIndex(tavern, index)
    //call BJDebugMsg("page " + I2S(page))
    call SetPagedButtonsPage(tavern, page)
    call IssueNeutralImmediateOrderById(owner, tavern, id)
    
    set owner = null
endfunction

function SelectCustomizableHero takes unit buyingUnit, unit tavern returns nothing
    call SetPagedButtonsPage(tavern, 0)
    call IssueNeutralImmediateOrderById(GetOwningPlayer(buyingUnit), tavern, CUSTOMIZABLE_HERO)
endfunction

function SelectRandomRace takes unit buyingUnit, unit tavern returns nothing
    local player owner = GetOwningPlayer(buyingUnit)
    local integer array availableIds
    local integer availableIdsCounter = 0
    local integer id = 0
    local integer random = 0
    local integer page = 0
    local integer index = 0
    local integer i = 1 // skip udg_RaceNone
    local integer max = GetRacesMax()
    loop
        exitwhen (i >= max)
        set id = udg_RaceTavernItemType[i]
        if (PlayerCanPickRaceEx(owner, id)) then
            set availableIds[availableIdsCounter] = id
            set availableIdsCounter = availableIdsCounter + 1
        endif
        set i = i + 1
    endloop
    
    set random = GetRandomInt(0, availableIdsCounter - 1)
    set id = availableIds[random]
    //call BJDebugMsg("Selected random " + GetObjectName(id))
    set index = GetPagedButtonIndex(tavern, id)
    //call BJDebugMsg("index " + I2S(index))
    set page = GetPagedButtonsPageByIndex(tavern, index)
    //call BJDebugMsg("page " + I2S(page))
    call SetPagedButtonsPage(tavern, page)
    call IssueNeutralImmediateOrderById(owner, tavern, id)
    
    set owner = null
endfunction

function SelectRandomProfession takes unit buyingUnit, unit tavern returns nothing
    local player owner = GetOwningPlayer(buyingUnit)
    local integer array availableIds
    local integer availableIdsCounter = 0
    local integer id = 0
    local integer random = 0
    local integer page = 0
    local integer index = 0
    local integer i = 1 // skip udg_RaceNone
    local integer max = GetProfessionsMax()
    loop
        exitwhen (i >= max)
        set id = GetProfessionItemTypeId(i)
        if (PlayerCanPickProfession(owner, id)) then
            set availableIds[availableIdsCounter] = id
            set availableIdsCounter = availableIdsCounter + 1
        endif
        set i = i + 1
    endloop
    
    set random = GetRandomInt(0, availableIdsCounter - 1)
    set id = availableIds[random]
    //call BJDebugMsg("Selected random " + GetObjectName(id))
    set index = GetPagedButtonIndex(tavern, id)
    //call BJDebugMsg("index " + I2S(index))
    set page = GetPagedButtonsPageByIndex(tavern, index)
    //call BJDebugMsg("page " + I2S(page))
    call SetPagedButtonsPage(tavern, page)
    call IssueNeutralImmediateOrderById(owner, tavern, id)
    
    set owner = null
endfunction

function PlayerCanBuyStartLocationEx takes player whichPlayer, integer itemTypeId returns boolean
    local integer index = GetStartLocationByItemTypeId(itemTypeId)
    if (index >= 0) then
        return not GetStartLocationIsClanArea(index) or PlayerIsInElvenClan(whichPlayer)
    endif
    return false
endfunction

function SelectRandomStartLocation takes unit buyingUnit, unit tavern returns nothing
    local player owner = GetOwningPlayer(buyingUnit)
    local integer array availableIds
    local integer availableIdsCounter = 0
    local integer id = 0
    local integer random = 0
    local integer page = 0
    local integer index = 0
    local integer i = 1 // skip udg_RaceNone
    local integer max = GetMaxStartLocations()
    loop
        exitwhen (i >= max)
        set id = GetStartLocationItemTypeId(i)
        if (PlayerCanBuyStartLocationEx(owner, id)) then
            set availableIds[availableIdsCounter] = id
            set availableIdsCounter = availableIdsCounter + 1
        endif
        set i = i + 1
    endloop
    
    set random = GetRandomInt(0, availableIdsCounter - 1)
    set id = availableIds[random]
    //call BJDebugMsg("Selected random " + GetObjectName(id))
    set index = GetPagedButtonIndex(tavern, id)
    //call BJDebugMsg("index " + I2S(index))
    set page = GetPagedButtonsPageByIndex(tavern, index)
    //call BJDebugMsg("page " + I2S(page))
    call SetPagedButtonsPage(tavern, page)
    call IssueNeutralImmediateOrderById(owner, tavern, id)
    
    set owner = null
endfunction

function SelectAllRandom takes unit buyingUnit, unit tavern returns nothing
    local integer gameMode = SelectRandomGameMode(buyingUnit, FirstOfGroup(gameModeTaverns))
    call SelectRandomHero(buyingUnit, FirstOfGroup(heroesTaverns))
    if (gameMode == ITEM_WARLORD) then
        call SelectRandomRace(buyingUnit, FirstOfGroup(racesTaverns))
    endif
    call SelectRandomProfession(buyingUnit, FirstOfGroup(professionsTaverns))
    call SelectRandomStartLocation(buyingUnit, FirstOfGroup(startLocationsTaverns))
endfunction

function SelectAllRandomWithCustomizableHero takes unit buyingUnit, unit tavern returns nothing
    local integer gameMode = SelectRandomGameMode(buyingUnit, FirstOfGroup(gameModeTaverns))
    call SelectCustomizableHero(buyingUnit, FirstOfGroup(heroesTaverns))
    if (gameMode == ITEM_WARLORD) then
        call SelectRandomRace(buyingUnit, FirstOfGroup(racesTaverns))
    endif
    call SelectRandomProfession(buyingUnit, FirstOfGroup(professionsTaverns))
    call SelectRandomStartLocation(buyingUnit, FirstOfGroup(startLocationsTaverns))
endfunction

private function TriggerActionSellItem takes nothing returns boolean
    local integer itemTypeId = GetItemTypeId(GetSoldItem())
    if (itemTypeId == ITEM_TYPE_RANDOM_HERO) then
        call SelectRandomHero(GetBuyingUnit(), GetTriggerUnit())
        call RemoveItem(GetSoldItem())
    elseif (itemTypeId == ITEM_TYPE_RANDOM_RACE) then
        call SelectRandomRace(GetBuyingUnit(), GetTriggerUnit())
        call RemoveItem(GetSoldItem())
    elseif (itemTypeId == ITEM_TYPE_RANDOM_PROFESSION) then
        call SelectRandomProfession(GetBuyingUnit(), GetTriggerUnit())
        call RemoveItem(GetSoldItem())
    elseif (itemTypeId == ITEM_TYPE_RANDOM_START_LOCATION) then
        call SelectRandomStartLocation(GetBuyingUnit(), GetTriggerUnit())
        call RemoveItem(GetSoldItem())
    elseif (itemTypeId == ITEM_TYPE_RANDOM) then
        call SelectAllRandom(GetBuyingUnit(), GetTriggerUnit())
        call RemoveItem(GetSoldItem())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddAction(sellTrigger, function TriggerActionSellItem)
endfunction

endlibrary
