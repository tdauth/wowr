library WoWReforgedStartLocations requires MathUtils

globals
    private integer array startLocationsItemTypeIds
    private real array startLocationsX
    private real array startLocationsY
    private real array startLocationsFacing
    private integer startLocationsCounter = 0
endglobals

function GetMaxStartLocations takes nothing returns integer
    return startLocationsCounter
endfunction

function AddStartLocation takes integer itemTypeId, rect r, real facing returns integer
    local integer index = startLocationsCounter
    set startLocationsItemTypeIds[index] = itemTypeId
    set startLocationsX[index] = GetRectCenterX(r)
    set startLocationsY[index] = GetRectCenterY(r)
    set startLocationsFacing[index] = facing
    set startLocationsCounter = startLocationsCounter + 1
    
    return index
endfunction

function GetStartLocationItemTypeId takes integer startLocation returns integer
    return startLocationsItemTypeIds[startLocation]
endfunction

function GetStartLocationName takes integer startLocation returns string
    return GetObjectName(GetStartLocationItemTypeId(startLocation))
endfunction

function GetStartLocationIcon takes integer startLocation returns string
    return BlzGetAbilityIcon(GetStartLocationItemTypeId(startLocation))
endfunction

function GetStartLocationCoordinateX takes integer startLocation returns real
    return startLocationsX[startLocation]
endfunction

function GetStartLocationCoordinateY takes integer startLocation returns real
    return startLocationsY[startLocation]
endfunction

function MoveUnitToStartLocation takes unit whichUnit, integer startLocation returns nothing
    call SetUnitX(whichUnit, startLocationsX[startLocation])
    call SetUnitY(whichUnit, startLocationsY[startLocation])
    call SetUnitFacing(whichUnit, startLocationsFacing[startLocation])
endfunction

function GetStartLocationByItemTypeId takes integer itemTypeId returns integer
    local integer i = 0
    local integer max = GetMaxStartLocations()
    loop
        exitwhen (i == max)
        if (itemTypeId == GetStartLocationItemTypeId(i)) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetStartLocationRectByCoordinates takes real x, real y returns integer
    local integer i = 0
    local integer max = GetMaxStartLocations()
    loop
        exitwhen (i == max)
        if (DistBetweenCoordinates(startLocationsX[i], startLocationsY[i], x, y) <= 800.0) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

endlibrary
