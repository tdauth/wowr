library WoWReforgedProperties initializer Init requires GenerateIds, PagedButtons, optional PagedButtonsUI, Resources, optional ResourcesGui, WoWReforgedRaces, WoWReforgedPings, WoWReforgedResearches, WoWReforgedAccount

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

function AddProperty takes integer unitTypeId, integer purchaseUnitTypeId, integer resource, integer soldRace, boolean shipyard returns Property
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

function AddPropertyWoWReforged takes nothing returns nothing
    set udg_TmpInteger = AddProperty(udg_TmpUnitType, udg_TmpUnitType2, udg_TmpInteger, udg_TmpInteger3, udg_TmpBoolean)
    set udg_TmpBoolean = false
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
endfunction

endlibrary
