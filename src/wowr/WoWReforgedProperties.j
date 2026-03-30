library WoWReforgedProperties initializer Init requires GenerateIds, PagedButtons, optional PagedButtonsUI, Resources, optional ResourcesGui, WoWReforgedRaces, WoWReforgedPings, WoWReforgedResearches, WoWReforgedResources, WoWReforgedAccount

globals
    public constant real RESOURCES_INTERVAL = 30.0
    public constant integer RESOURCES_BONUS = 80
    public constant integer SELECT_UNIT_ABILITY_ID = 'Ane2'
    public constant integer SELECT_HERO_ABILITY_ID = 'Aneu'

    private trigger purchaseTrigger = CreateTrigger()
    
    private Property array properties
    private integer propertiesCounter = 0
    
    private group properiesGroup = CreateGroup()
    private hashtable h = InitHashtable()
    private timer resourcesTimer = CreateTimer()
    private boolean resourcesTimerStarted = false
    private group purchasedProperties = CreateGroup()
endglobals

struct Property
    integer unitTypeId
    integer purchaseUnitTypeId
    integer resource
    integer soldRace
    boolean shipyard
endstruct

function GetMaxProperties takes nothing returns integer
    return propertiesCounter
endfunction

function GetProperty takes integer index returns Property
    return properties[index]
endfunction

function GetPropertyIndex takes unit whichUnit returns integer
    local integer handleId = GetHandleId(whichUnit)
    if (HaveSavedInteger(h, handleId, 0)) then
        return LoadInteger(h, GetHandleId(whichUnit), 0)
    endif
    return -1
endfunction

function PlayerOwnsPropertyOfRace takes player whichPlayer, integer whichRace returns boolean
    local integer i = 0
    local integer max = 0
    local integer index = 0
    local unit whichUnit = null
    if (whichRace == udg_RaceNone) then
        return true
    endif
    
    set max = BlzGroupGetSize(properiesGroup)
    loop
        exitwhen (i == max)
        set whichUnit = BlzGroupUnitAt(properiesGroup, i)
        set index = GetPropertyIndex(whichUnit)
        if (index != -1 and GetProperty(index).soldRace == whichRace) then
            return true
        endif
        set whichUnit = null
        set i = i + 1
    endloop
    
    return false
endfunction

function PropertyAllowsItemTypeId takes player whichPlayer, integer whichRace, integer itemTypeId returns boolean
    local integer t = GetRaceObjectType(whichRace, itemTypeId)
    
    if (t == RACE_OBJECT_TYPE_NONE) then
        return true
    elseif (t == RACE_OBJECT_TYPE_SCEPTER_ITEM) then
        return false
    elseif (t == RACE_OBJECT_TYPE_TIER_1_ITEM) then    
        return false
    elseif (t == RACE_OBJECT_TYPE_TIER_2_ITEM) then    
        return false
    elseif (t == RACE_OBJECT_TYPE_TIER_3_ITEM) then    
        return false
    endif
    
    return PlayerOwnsPropertyOfRace(whichPlayer, GetObjectRace(itemTypeId))
endfunction

function GetPropertyIndexByUnitTypeId takes integer unitTypeId returns integer
    local integer i = 0
    local integer max = GetMaxProperties()
    loop
        exitwhen (i >= max)
        if (GetProperty(i).unitTypeId == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function IsProperty takes integer unitTypeId returns boolean
    return GetPropertyIndexByUnitTypeId(unitTypeId) != -1
endfunction

function IsUnitProperty takes unit whichUnit returns boolean
    return IsProperty(GetUnitTypeId(whichUnit))
endfunction

private function AddProperty takes integer unitTypeId, integer purchaseUnitTypeId, integer resource, integer soldRace, boolean shipyard returns Property
    local Property property = Property.create()
    set property.unitTypeId = unitTypeId
    set property.purchaseUnitTypeId = purchaseUnitTypeId
    set property.resource = resource
    set property.soldRace = soldRace
    set property.shipyard = shipyard
    
    set properties[propertiesCounter] = property
    set propertiesCounter = propertiesCounter + 1
    
    return property
endfunction

private function AddUnitType takes integer index, unit shop, integer t returns nothing
    local integer unitTypeId = GetRaceObjectTypeId(GetProperty(index).soldRace, t)
     if (unitTypeId != 0 and GenerateId(unitTypeId)) then
        call AddPagedButtonsUnitType(shop, unitTypeId)
    endif
endfunction

private function AddItemType takes integer index, unit shop, integer t returns nothing
    local integer itemTypeId = GetRaceObjectTypeId(GetProperty(index).soldRace, t)
     if (itemTypeId != 0 and GenerateId(itemTypeId)) then
        call AddPagedButtonsItemType(shop, itemTypeId)
    endif
endfunction

private function EnumPropertyResources takes nothing returns nothing
    local integer index = GetPropertyIndex(GetEnumUnit())
    local Property p = GetProperty(index)
    call CustomBounty(GetEnumUnit(), p.resource, RESOURCES_BONUS)
endfunction

private function TimerUpdateResources takes nothing returns nothing
    call ForGroup(purchasedProperties, function EnumPropertyResources)
endfunction

private function StartResourcesTimer takes nothing returns nothing
    if (not resourcesTimerStarted) then
        call TimerStart(resourcesTimer, RESOURCES_INTERVAL, true, function TimerUpdateResources)
        set resourcesTimerStarted = true
    endif
endfunction

private function PurchaseProperty takes integer index, unit whichUnit, player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    
    call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedString("PURCHASED_PROPERTY_X")).s(GetUnitName(whichUnit)).result())
    
    call GroupAddUnit(purchasedProperties, whichUnit)
    
    call SetUnitOwner(whichUnit, whichPlayer, true)
    
    call ResearchAllForPlayer(whichPlayer, GetProperty(index).soldRace)
    
    call RemoveUnitFromStock(whichUnit, GetProperty(index).purchaseUnitTypeId)
    
    call EnablePagedButtons(whichUnit)
    call SetPagedButtonsSlotsPerPage(whichUnit, 7)
    call ClearGeneratedIds()
    call NextPagedButtonsPage(whichUnit, GetLocalizedString("PAGE_TITLE_UNITS"))
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_TOWN_HALL_3)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_TOWN_HALL_4)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_FEMALE_CITIZEN)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_CHILD)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_PET)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_FOOTMAN)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_RIFLEMAN)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_KNIGHT)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_BARRACKS_4)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_PRIEST)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SORCERESS)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SPELLBREAKER)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_GRYPHON)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_DRAGONHAWK)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_AVIARY_3)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_AVIARY_4)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_FLYING_MACHINE)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SIEGE_ENGINE)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_MORTAR)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_WORKSHOP_4)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_TAUREN)
    call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SHADE)
    
    if (GetProperty(index).shipyard) then
        call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_TRANSPORT_SHIP)
        call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_FRIGATE)
        call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_BATTLESHIP)
        call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SHIP_SPECIAL_1)
        call AddUnitType(index, whichUnit, RACE_OBJECT_TYPE_SHIP_SPECIAL_2)
        
        call AddPagedButtonsUnitType(whichUnit, GNOMISH_SUBMARINE)
        call AddPagedButtonsUnitType(whichUnit, ENGINEER_SHIP)
    endif
    
    call NextPagedButtonsPage(whichUnit, GetLocalizedString("PAGE_TITLE_BUILDINGS"))
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_FARM_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_ALTAR_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_MILL_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_BLACK_SMITH_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_BARRACKS_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SHOP_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SCOUT_TOWER_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_ARCANE_SANCTUM_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_WORKSHOP_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_GRYPHON_AVIARY_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SACRIFICIAL_PIT_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SHIPYARD_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SPECIAL_BUILDING_ITEM)
    call AddItemType(index, whichUnit, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2_ITEM)

static if (LIBRARY_PagedButtonsUI) then
    call ShowPagedButtonsUI(whichPlayer, whichUnit)
endif
endfunction

function PingProperties takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = BlzGroupGetSize(properiesGroup)
    loop
        exitwhen (i >= max)
        call PingUnitForPlayer(BlzGroupUnitAt(properiesGroup, i), whichPlayer)
        set i = i + 1
    endloop
endfunction

private function GetPropertyIndexByPurchaseUnitTypeId takes integer unitTypeId returns integer
    local integer i = 0
    local integer max = GetMaxProperties()
    loop
        exitwhen (i >= max)
        if (GetProperty(i).purchaseUnitTypeId == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function TriggerActionPurchase takes nothing returns nothing
    local integer unitTypeId = GetUnitTypeId(GetSoldUnit())
    local integer index = GetPropertyIndexByPurchaseUnitTypeId(unitTypeId)
    local player owner = GetOwningPlayer(GetBuyingUnit())
    local Property p = GetProperty(index)
    if (index != -1) then
        call RemoveUnit(GetSoldUnit())
        
        if (PlayerHasUnlocked(owner, p.unitTypeId)) then
            if (PlayerHasUnlocked(owner, p.purchaseUnitTypeId)) then
                if (PlayerHasFaction(owner, GetRaceTeam(p.soldRace)) or udg_UnlockedAll) then
                    call PurchaseProperty(index, GetSellingUnit(), owner)
                else
                    call SimError(owner, Format(GetLocalizedString("RESTRICTED_TO_FACTION")).s(GetFactionName(GetRaceTeam(p.soldRace))).result())
                endif
            else
                call SimError(owner, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetLocalizedString("PROPERTY")).s(GetAllUnlockedAccountNames(p.purchaseUnitTypeId)).result())
            endif
        else
            call SimError(owner, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetLocalizedString("PROPERTY")).s(GetAllUnlockedAccountNames(p.unitTypeId)).result())
        endif
    endif
    set owner = null
endfunction

function AddUnitProperty takes unit whichUnit, integer index returns nothing
    call GroupAddUnit(properiesGroup, whichUnit)
    call SaveInteger(h, GetHandleId(whichUnit), 0, index)
    call UnitAddAbility(whichUnit, 'Asud')
    call UnitAddAbility(whichUnit, SELECT_UNIT_ABILITY_ID)
    call UnitAddAbility(whichUnit, SELECT_HERO_ABILITY_ID)
    call UnitAddAbility(whichUnit, 'Avul')
    call AddUnitToStock(whichUnit, GetProperty(index).purchaseUnitTypeId, 1, 1)
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(purchaseTrigger, EVENT_PLAYER_UNIT_SELL)
    // Use a trigger action because of ResourcesGui_StartUpdateTimerForUnits and the player selection.
    call TriggerAddAction(purchaseTrigger, function TriggerActionPurchase)

    call AddProperty('n0NF', 'h0YE', udg_ResourceFruits, udg_RaceHuman, true) // Theramore Isle
    call AddProperty('n07I', 'h0WP', udg_ResourceIron, udg_RaceStormwind, true) // New Stormwind
    call AddProperty('n0NH', 'h0YG', udg_ResourceFruits, udg_RaceKulTiras, true) // Boralus
    call AddProperty('n09G', 'h07N', udg_ResourceGold, udg_RaceBandit, true) // Deadmines
    call AddProperty('n0NI', 'h0YH', udg_ResourceElectricity, udg_RaceDalaran, true) // Dalaran
    call AddProperty('n097', 'h0X0', udg_ResourceGemstones, udg_RaceDwarf, true) // Ironforge
    call AddProperty('n0HI', 'h0XE', udg_ResourceIron, udg_RaceGnome, true) // Gnomeregan
    call AddProperty('n0LW', 'h0XN', udg_ResourceMeat, udg_RaceGnoll, false) // Gnoll Camp
    call AddProperty('n0LV', 'h0XM', udg_ResourceGold, udg_RaceKobold, false) // Kobold Camp
    call AddProperty('n0LO', 'h0XH', udg_ResourceRock, udg_RaceWorgen, true) // Gilneas City
    call AddProperty('n07N', 'h0WS', udg_ResourceMeat, udg_RaceOrc, true) // Orgrimmar
    call AddProperty('n08S', 'h0WW', udg_ResourceFavor, udg_RaceTauren, true) // Thunder Bluff
    call AddProperty('n0LX', 'h0XO', udg_ResourceMeat, udg_RaceCentaur, false) // Maraudon
    call AddProperty('n0LY', 'h0XP', udg_ResourceMeat, udg_RaceQuillboar, false) // Razorfen Kraul
    call AddProperty('n0BK', 'h0X5', udg_ResourceOil, udg_RaceTroll, true) // Darkspear Isle
    call AddProperty('n07O', 'h0WT', udg_ResourceFavor, udg_RaceUndead, false) // Undercity
    call AddProperty('n098', 'h0X1', udg_ResourceGold, udg_RaceBloodElf, true) // Sunstrider Isle
    call AddProperty('n099', 'h0X2', udg_ResourceSilver, udg_RaceHighElf, true) // Silvermoon
    call AddProperty('n0LR', 'h0XI', udg_ResourceGold, udg_RaceUndead, true) // Icecrown Citadel
    call AddProperty('n07W', 'h0WU', udg_ResourceSilver, udg_RaceNerubian, true) // Azjol-Nerub
    call AddProperty('n0LL', 'h0XF', udg_ResourceMeat, udg_RaceVrykul, true) // Utgarde Keep
    call AddProperty('n0CT', 'h0X7', udg_ResourceMeat, udg_RaceTuskarr, true) // Moa'ki Harbor
    call AddProperty('n0E5', 'h0XB', udg_ResourceArgunite, udg_RaceDraenei, true) // Exodar
    call AddProperty('n0LM', 'h0XG', udg_ResourceFel, udg_RaceDemon, true) // Antorus, the Burning Throne
    call AddProperty('n08J', 'h0WV', udg_ResourceFruits, udg_RaceNightElf, true) // Terdrassil
    call AddProperty('n0C9', 'h0X6', udg_ResourceLumber, udg_RaceFurbolg, false) // Timbermaw Hold
    call AddProperty('n0D6', 'h0X8', udg_ResourceLumber, udg_RaceSatyr, false) // Jadefire Glen
    call AddProperty('n0GA', 'h0XD', udg_ResourceOil, udg_RaceGoblin, true) // The Undermine
    call AddProperty('n096', 'h0WZ', udg_ResourceWater, udg_RaceNaga, true) // Nazjatar
    call AddProperty('n0LS', 'h0XJ', udg_ResourceWater, udg_RaceMurloc, true) // Murloc Camp
    call AddProperty('n08Z', 'h0WX', udg_ResourceMeat, udg_RaceOgre, true) // Gruul's Lair
    call AddProperty('n095', 'h0WY', udg_ResourceFel, udg_RaceFelOrc, true) // Hellfire Citadel
    call AddProperty('n0LU', 'h0XL', udg_ResourceArgunite, udg_RaceLostOnes, true) // Fallow Sanctuary
    call AddProperty('n09A', 'h0X3', udg_ResourceLumber, udg_RacePandaren, true) // The Shrine of Seven Stars
    call AddProperty('n0EU', 'h0XC', udg_ResourceGold, udg_RaceFacelessOne, true) // Ny'alotha
    call AddProperty('n0AA', 'h07Y', udg_ResourceGold, udg_RaceDungeon, true) // Dungeon
    call AddProperty('n0O4', 'h08I', udg_ResourceWool, udg_RaceLordaeron, false) // Capital City
    call AddProperty('n0OC', 'h0AO', udg_ResourceGold, udg_RaceDragonkin, false) // Wyrmrest Temple
endfunction

endlibrary
