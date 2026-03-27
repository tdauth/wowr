library WoWReforgedZones initializer Init requires SimError, SelectionUtils, WoWReforgedUtils

globals
    constant integer TERRAIN_TYPE_NONE = 0
    constant integer TERRAIN_TYPE_LORDAERON = 1
    constant integer TERRAIN_TYPE_ASHENVALE = 2
    constant integer TERRAIN_TYPE_NORTHREND = 3
    constant integer TERRAIN_TYPE_BARRENS = 4
    constant integer TERRAIN_TYPE_OUTLAND = 5
    constant integer TERRAIN_TYPE_SUNKEN_RUINS = 6
    constant integer TERRAIN_TYPE_SEA = 7
    constant integer TERRAIN_TYPE_DUNGEON = 8
    constant integer TERRAIN_TYPE_UNDERGROUND = 9
    constant integer TERRAIN_TYPE_LORDAERON_FALL = 10
    
    constant integer MAX_ZONE_RECTS = 20
    
    constant integer ZONE_TYPE_ZONE = 0
    constant integer ZONE_TYPE_WORLD = 1
    constant integer ZONE_TYPE_CONTINENT = 2
endglobals

struct AbstractZone //[50000]
    string name
    string icon
    string id
    AbstractZone parent
    integer zoneType
endstruct

struct Zone extends AbstractZone
    region r
    rect array rects[MAX_ZONE_RECTS]
    integer rectsCounter = 0
    playercolor color
    integer treeTypeId = 0
    boolean array discovered[28]
    
    // seasons
    integer terrainType = TERRAIN_TYPE_NONE
    
    static method create takes nothing returns thistype
        local thistype this = thistype.allocate()
        set this.r = CreateRegion() // never in a globals block!
        return this
    endmethod
endstruct

globals
    private AbstractZone array zones
    private integer zonesCounter = 0
    
    private trigger enterTrigger = CreateTrigger()
    
    private AbstractZone currentWorld = 0
    private AbstractZone currentContinent = 0
    private Zone currentZone = 0
endglobals

function GetZonesMax takes nothing returns integer
    return zonesCounter
endfunction

private function AddZoneRectEx takes Zone z, rect whichRect returns nothing
    if (z.rectsCounter < MAX_ZONE_RECTS) then
        call RegionAddRect(z.r, whichRect)
        set z.rects[z.rectsCounter] = whichRect
        set z.rectsCounter = z.rectsCounter + 1
    else
        call BJDebugMsg("Reached limit of rects for zone " + z.name)
    endif
endfunction

function AddZone takes string name, rect whichRect, string icon, playercolor color, string id, integer treeTypeId, integer terrainType returns Zone
    local Zone z = Zone.create()
    set z.name = name
    call AddZoneRectEx(z, whichRect)
    call TriggerRegisterEnterRegion(enterTrigger, z.r, null)
    set z.icon = icon
    set z.color = color
    set z.id = id
    set z.treeTypeId = treeTypeId
    set z.terrainType = terrainType
    set z.zoneType = ZONE_TYPE_ZONE
    
    if (currentContinent != 0) then
        set z.parent = currentContinent
    elseif (currentWorld != 0) then
        set z.parent = currentWorld
    endif
    
    set zones[zonesCounter] = z
    set zonesCounter = zonesCounter + 1
    
    set currentZone = z
    
    return z
endfunction

function AddZoneWorld takes string name, string icon, string id returns AbstractZone
    local AbstractZone z = AbstractZone.create()
    set z.name = name
    set z.icon = icon
    set z.zoneType = ZONE_TYPE_WORLD
    set z.parent = 0
    
    set zones[zonesCounter] = z
    set zonesCounter = zonesCounter + 1
    
    set currentWorld = z
    
    return z
endfunction

function AddZoneContinent takes string name, string icon, string id returns AbstractZone
    local AbstractZone z = AbstractZone.create()
    set z.name = name
    set z.icon = icon
    set z.zoneType = ZONE_TYPE_CONTINENT
    
    set currentContinent = z
    
    if (currentWorld != 0) then
        set z.parent = currentWorld
    endif
    
    set zones[zonesCounter] = z
    set zonesCounter = zonesCounter + 1
    
    return z
endfunction

function ResetZoneCurrentWorld takes nothing returns nothing
    set currentWorld = 0
endfunction

function ResetZoneCurrentContinent takes nothing returns nothing
    set currentContinent = 0
endfunction

function AddZoneRect takes rect r returns nothing
    call AddZoneRectEx(currentZone, r)
endfunction

function GetZone takes integer index returns AbstractZone
    return zones[index]
endfunction

function GetZoneName takes AbstractZone z returns string
    return z.name
endfunction

function GetZoneRectsCounter takes Zone z returns integer
    return z.rectsCounter
endfunction

function GetZoneRect takes Zone z, integer index returns rect
    return z.rects[index]
endfunction

function GetZoneArea takes Zone z returns real
    local real result = 0.0
    local integer i = 0
    local integer max = GetZoneRectsCounter(z)
    loop
        exitwhen (i == max)
        set result = result + GetRectWidthBJ(GetZoneRect(z, i)) * GetRectHeightBJ(GetZoneRect(z, i))
        set i = i + 1
    endloop
    return result
endfunction

function GetZoneAreaOfChildren takes AbstractZone zone returns real
    local AbstractZone z = 0
    local real result = 0.0
    local integer i = 0
    local integer max = GetZonesMax()
    loop
        exitwhen (i == max)
        set z = GetZone(i)
        if (z.parent == zone and z.zoneType == ZONE_TYPE_ZONE) then
            set result = result + GetZoneArea(Zone(z))
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetZoneAreaOfGrandChildren takes AbstractZone zone returns real
    local AbstractZone z = 0
    local real result = 0.0
    local integer i = 0
    local integer max = GetZonesMax()
    loop
        exitwhen (i == max)
        set z = GetZone(i)
        if (z.parent == zone) then
            if (z.zoneType == ZONE_TYPE_CONTINENT) then
                set result = result + GetZoneAreaOfChildren(z)
            elseif (z.zoneType == ZONE_TYPE_ZONE) then
                set result = result + GetZoneArea(Zone(z))
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetZoneTotalArea takes AbstractZone zone returns real
    if (zone.zoneType == ZONE_TYPE_WORLD) then
        return GetZoneAreaOfGrandChildren(zone)
    elseif (zone.zoneType == ZONE_TYPE_CONTINENT) then
        return GetZoneAreaOfChildren(zone)
    elseif (zone.zoneType == ZONE_TYPE_ZONE) then
        return GetZoneArea(Zone(zone))
    endif
    return 0.0
endfunction

function GetZoneIcon takes AbstractZone z returns string
    return z.icon
endfunction

function GetZoneColor takes Zone z returns playercolor
    return z.color
endfunction

function GetZoneId takes AbstractZone z returns string
    return z.id
endfunction

function GetZoneTreeTypeId takes Zone z returns integer
    return z.treeTypeId
endfunction

function GetZoneTerrainType takes Zone z returns integer
    return z.terrainType
endfunction

function GetZoneDiscoveringMessage takes AbstractZone z returns string
    return Format(GetLocalizedString("ZONE_DISCOVERED")).s(z.name).result()
endfunction

function GetZoneEnteringMessage takes AbstractZone z returns string
    return Format(GetLocalizedString("ZONE_ENTER")).s(z.name).result()
endfunction

function GetZoneIndexByCoordinates takes real x, real y returns integer
    local integer i = 0
    local integer max = GetZonesMax()
    local integer result = -1
    local AbstractZone z = 0
    loop
        exitwhen (i == max)
        set z = GetZone(i)
        if (z.zoneType == ZONE_TYPE_ZONE and IsPointInRegion(Zone(z).r, x, y)) then
            set result = i
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetZoneByCoordinates takes real x, real y returns Zone
    local integer i = 0
    local integer max = GetZonesMax()
    local AbstractZone z = 0
    loop
        exitwhen (i == max)
        set z = GetZone(i)
        if (z.zoneType == ZONE_TYPE_ZONE and IsPointInRegion(Zone(z).r, x, y)) then
            return Zone(z)
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function GetZoneRectByCoordinates takes Zone z, real x, real y returns integer
    local integer i = 0
    local integer max = GetZoneRectsCounter(z)
    loop
        exitwhen (i == max)
        if (RectContainsCoords(GetZoneRect(z, i), x, y)) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetZoneNameByCoordinates takes real x, real y returns string
    local Zone z = GetZoneByCoordinates(x, y)
    if (z != 0) then
        return z.name
    endif
    return ""
endfunction

function GetPlayerShowZoneHints takes player whichPlayer returns boolean
    return udg_PlayerShowZonesHints[GetConvertedPlayerId(whichPlayer)] 
endfunction

function SetPlayerShowZoneHints takes player whichPlayer, boolean show returns nothing
    set udg_PlayerShowZonesHints[GetConvertedPlayerId(whichPlayer)] = show
endfunction

function ShowCurrentZoneEx takes player whichPlayer, unit first returns nothing
    local real x = GetUnitX(first)
    local real y = GetUnitY(first)
    local Zone z = GetZoneByCoordinates(x, y)
    if (z != 0) then
        call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)], bj_QUESTMESSAGE_HINT, Format(GetLocalizedString("ZONE_NAME")).s(z.name).result())
    endif
endfunction

function GetZoneFullHint takes AbstractZone zone returns string
    if (zone.parent != 0 and zone.parent.parent != 0) then
        return Format(GetLocalizedString("ZONE_NAME_3")).s(zone.name).s(zone.parent.name).s(zone.parent.parent.name).result()
    elseif (zone.parent != 0) then
        return Format(GetLocalizedString("ZONE_NAME_2")).s(zone.name).s(zone.parent.name).result()
    endif
    
    return Format(GetLocalizedString("ZONE_NAME")).s(zone.name).result()
endfunction

function ShowCurrentZoneFullEx takes player whichPlayer, unit first returns nothing
    local real x = GetUnitX(first)
    local real y = GetUnitY(first)
    local Zone z = GetZoneByCoordinates(x, y)
    if (z != 0) then
        call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)], bj_QUESTMESSAGE_HINT, GetZoneFullHint(z))
    endif
endfunction

private function GetFirstSelected takes player whichPlayer returns unit
    local group g = GetUnitsSelectedAllSafe(whichPlayer)
    local unit first = FirstOfGroup(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return first
endfunction

function ShowCurrentZone takes player whichPlayer returns nothing
    local unit first = GetFirstSelected(whichPlayer)
    if (first != null) then
        call ShowCurrentZoneEx(whichPlayer, first)
        set first = null
    else
        call SimError(whichPlayer, GetLocalizedString("NO_UNIT_SELECTED")) // No unit selected.
    endif
endfunction

function ShowCurrentZoneFull takes player whichPlayer returns nothing
    local unit first = GetFirstSelected(whichPlayer)
    if (first != null) then
        call ShowCurrentZoneFullEx(whichPlayer, first)
        set first = null
    else
        call SimError(whichPlayer, GetLocalizedString("NO_UNIT_SELECTED")) // No unit selected.
    endif
endfunction

private function TriggerConditionEnter takes nothing returns boolean
    local unit enteringUnit = GetEnteringUnit()
    local player owner = GetOwningPlayer(enteringUnit)
    local integer playerId = GetPlayerId(owner)
    local Zone z = 0
    if (IsPlayerHero(enteringUnit)) then
        set z = GetZoneByCoordinates(GetUnitX(enteringUnit), GetUnitY(enteringUnit))
        if (z != 0) then
            if (z.discovered[playerId]) then
                if (GetPlayerShowZoneHints(owner)) then
                    call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_HINT, GetZoneEnteringMessage(z))
                endif
            else
                set z.discovered[playerId] = true
                if (GetPlayerShowZoneHints(owner)) then
                    call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_HINT, GetZoneDiscoveringMessage(z))
                endif
            endif
        endif
    endif
    set enteringUnit = null
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
endfunction

endlibrary
