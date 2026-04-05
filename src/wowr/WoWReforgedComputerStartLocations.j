library WoWReforgedComputerStartLocations requires MathUtils, WoWReforgedTmpVariables, WoWReforgedRaces

function GetRandomRaceWithAISupport takes nothing returns integer
    return GetRandomInt(0, GetRacesMax() - 1) // with freelancer
endfunction

function GetRandomWarlordRaceWithAISupport takes nothing returns integer
    return GetRandomInt(1, GetRacesMax() - 1) // no freelancer
endfunction

function GetRandomWarlordTeamRaceWithAISupport takes integer team returns integer
    local integer array r
    local integer c = 0
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i == max)
        if (GetRaceTeam(i) == team or GetRaceTeam(i) == TEAM_NONE) then
            set r[c] = i
            set c = c + 1
        endif
        set i = i + 1
    endloop
    return r[GetRandomInt(0, c - 1)]
endfunction

function GetRandomWarlordAllianceRaceWithAISupport takes nothing returns integer
    return GetRandomWarlordTeamRaceWithAISupport(TEAM_ALLIANCE)
endfunction

function GetRandomWarlordHordeRaceWithAISupport takes nothing returns integer
    return GetRandomWarlordTeamRaceWithAISupport(TEAM_HORDE)
endfunction

struct ComputerStartLocation
    real x
    real y
    boolean hasShipyard = false
    real shipyardX
    real shipyardY
    integer array possibleRaces[10]
    integer possibleRacesCounter = 0
    boolean taken = false

    method getRandomPossibleRace takes integer team returns integer
        local integer raceTeam = TEAM_NONE
        local integer i = 0
        local integer array r
        local integer c = 0
        loop
            exitwhen (i == possibleRacesCounter)
            set raceTeam = GetRaceTeam(possibleRaces[i])
            if (raceTeam == team or raceTeam == TEAM_NONE) then
                call BJDebugMsg("Possible race " + GetRaceName(possibleRaces[i]) + " for start location " + I2S(this))
                set r[c] = possibleRaces[i]
                set c = c + 1
            endif
            set i = i + 1
        endloop

        call BJDebugMsg("Possible races count" + I2S(c))

        if (c > 0) then
            return r[GetRandomInt(0, c)]
        endif

        if (team == TEAM_ALLIANCE) then
            return GetRandomWarlordAllianceRaceWithAISupport()
        elseif (team == TEAM_HORDE) then
            return GetRandomWarlordHordeRaceWithAISupport()
        endif

        return GetRandomWarlordRaceWithAISupport()
    endmethod

    method hasRace takes integer whichRace returns boolean
        local integer i = 0
        loop
            exitwhen (i == possibleRacesCounter)
            if (possibleRaces[i] == whichRace) then
                return true
            endif
            set i = i + 1
        endloop
        return false
    endmethod

    method hasTeam takes integer team returns boolean
        local integer i = 0
        local integer raceTeam = TEAM_NONE
        if (possibleRacesCounter == 0) then
            return true
        endif
        loop
            exitwhen (i == possibleRacesCounter)
            set raceTeam = GetRaceTeam(possibleRaces[i])
            if (raceTeam == team) then
                return true
            endif
            set i = i + 1
        endloop
        return false
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
