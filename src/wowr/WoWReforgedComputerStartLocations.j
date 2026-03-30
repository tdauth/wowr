library WoWReforgedComputerStartLocations requires MathUtils, WoWReforgedTmpVariables

struct ComputerStartLocation
    real x
    real y
    boolean hasShipyard = false
    real shipyardX
    real shipyardY
    integer array possibleRaces[10]
    integer possibleRacesCounter = 0
    boolean taken = false

  method getRandomPossibleRace takes nothing returns integer
        return possibleRaces[GetRandomInt(0, possibleRacesCounter)]
   endmethod
endstruct

globals
    private ComputerStartLocation array computerStartLocations
    private integer computerStartLocationsCounter = 0
    private ComputerStartLocation lastCreatedComputerStartLocation = 0
endglobals

function GetMaxComputerStartLocations takes nothing returns integer
    return computerStartLocationsCounter
endfunction

function GetComputerStartLocation takes integer index returns ComputerStartLocation
    return computerStartLocations[index]
endfunction

function GetLastCreatedComputerStartLocation takes nothing returns ComputerStartLocation
    return lastCreatedComputerStartLocation
endfunction

function AddComputerStartLocation takes real x, real y, boolean hasShipyard, real shipyardX, real shipyardY returns ComputerStartLocation
    local integer index = computerStartLocationsCounter
    local ComputerStartLocation l = ComputerStartLocation.create()
    set l.x = x
    set l.y = y
    set l.hasShipyard = hasShipyard
    set l.shipyardX = shipyardX
    set l.shipyardY = shipyardY
    set computerStartLocations[index] = l
    set computerStartLocationsCounter = index + 1

    set lastCreatedComputerStartLocation = l
    
    return l
endfunction

function AddComputerStartLocationRectWithShipyard takes rect r, rect shipyardRect returns ComputerStartLocation
    return AddComputerStartLocation(GetRectCenterX(r), GetRectCenterY(r), true, GetRectCenterX(shipyardRect), GetRectCenterY(shipyardRect))
endfunction

function AddComputerStartLocationRectNoShipyard takes rect r returns ComputerStartLocation
    return AddComputerStartLocation(GetRectCenterX(r), GetRectCenterY(r), false, 0.0, 0.0)
endfunction

function AddComputerStartLocationPossibleRace takes ComputerStartLocation l, integer r returns integer
	local integer index = l.possibleRacesCounter
	set l.possibleRaces[index] = r
	set l.possibleRacesCounter = index + 1
	return index
endfunction

function AddComputerStartLocationPossibleRaceLast takes integer r returns integer
     return AddComputerStartLocationPossibleRace(GetLastCreatedComputerStartLocation(), r)
endfunction

// TODO Remove as soon as all GUI triggers have been moved to vJass code.
function MoveTmpLocationToComputerStartLocation takes integer index returns nothing
	local ComputerStartLocation l = GetComputerStartLocation(index)
	call MoveTmpLocation(l.x, l.y)
endfunction

endlibrary
