library WoWReforgedResearches

struct Research
    integer researchId
    integer whichRace
    integer levels
    integer goldCostBase
    integer lumberCostBase
    integer timeBase
    
    integer goldIncrement
    integer lumberIncrement
    integer timeIncrement
endstruct

globals
    private Research array researches
    private integer researchesCounter = 0
    
    private Research lastCreatedResearch = 0
endglobals

function GetResearch takes integer index returns Research
    return researches[index]
endfunction

function AddResearch takes integer whichRace, integer researchId returns Research
    local Research r = Research.create()
    set r.researchId = researchId
    set r.whichRace = whichRace
    set r.levels = GetPlayerTechMaxAllowed(Player(0), researchId)
    
    set lastCreatedResearch = r
    
    set researches[researchesCounter] = r
    set researchesCounter = researchesCounter + 1
    
    return r
endfunction

//, integer goldCostBase, integer lumberCostBase, integer timeBase
    //set r.goldCostBase = goldCostBase
    //set r.lumberCostBase = lumberCostBase
    //set r.timeBase = whichRace

function AddResearchLevelData takes integer goldIncrement, integer lumberIncrement, integer timeIncrement returns nothing
    set lastCreatedResearch.goldIncrement = goldIncrement
    set lastCreatedResearch.lumberIncrement = lumberIncrement
    set lastCreatedResearch.timeIncrement = timeIncrement
endfunction

//function AddResearchUnitType takes integer unitTypeId returns nothing
//function AddResearchAbility takes integer abilityId returns nothing

function AddResearchWoWReforged takes nothing returns Research
    return AddResearch(udg_TmpInteger, udg_TmpTechType)
endfunction

function GetResearchesMax takes nothing returns integer
    return researchesCounter
endfunction

function GetResearchId takes Research r returns integer
    return r.researchId
endfunction

function GetResearchRace takes Research r returns integer
    return r.whichRace
endfunction

function GetResearchLevels takes Research r returns integer
    return r.levels
endfunction

function GetResearchGoldCostBase takes Research r returns integer
    return r.goldCostBase
endfunction

function GetResearchLumberCostBase takes Research r returns integer
    return r.lumberCostBase
endfunction

function GetResearchTimeBase takes Research r returns integer
    return r.timeBase
endfunction

//function GetResearchUnitTypeCount takes Research r returns integer
//function GetResearchUnitTypeByIndex takes integer researchId, integer index returns integer

//function GetResearchAbilityCount takes integer researchId returns integer
//function GetResearchAbilityByIndex takes integer researchId, integer index returns integer

function GetResearchesTotalForRace takes integer whichRace returns integer
    local integer i = 0
    local integer max = GetResearchesMax()
    local integer counter = 0
    local Research r = 0
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        if (r.whichRace == whichRace) then
            set counter = counter + r.levels
        endif
        set i = i + 1
    endloop
    return counter
endfunction

function GetResearchesResearchedForRace takes integer whichRace, player whichPlayer returns integer
    local integer i = 0
    local integer max = GetResearchesMax()
    local integer counter = 0
    local Research r = 0
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        if (r.whichRace == whichRace) then
            set counter = counter + GetPlayerTechCountSimple(r.researchId, whichPlayer)
        endif
        set i = i + 1
    endloop
    return counter
endfunction

function GetResearchesPercentageForRace takes integer whichRace, player whichPlayer returns real
    return I2R(GetResearchesResearchedForRace(whichRace, whichPlayer)) / I2R(GetResearchesTotalForRace(whichRace)) * 100.0
endfunction

function ResearchAllForPlayer takes player whichPlayer, integer whichRace returns nothing
    local Research r = 0
    local integer i = 0
    local integer max = GetResearchesMax()
    //call BJDebugMsg("Max researches " + I2S(max) + " and race " + I2S(whichRace) + " " + GetRaceName(whichRace) + " and player " + GetPlayerName(whichPlayer))
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        //call BJDebugMsg("Research " + GetObjectName(r.researchId) + " with levels " + I2S(r.levels) + " for race " + GetRaceName(r.whichRace))
        if (r.whichRace == whichRace and GetPlayerTechCountSimple(r.researchId, whichPlayer) < r.levels) then
            //call BJDebugMsg("Level research " + GetObjectName(r.researchId) + " to " + I2S(r.levels))
            call SetPlayerTechResearched(whichPlayer, r.researchId, r.levels)
        //elseif (r.whichRace == whichRace) then
            //call BJDebugMsg("Not Level research " + GetObjectName(r.researchId) + " to " + I2S(r.levels))
        endif
        set i = i + 1
    endloop
endfunction

endlibrary
