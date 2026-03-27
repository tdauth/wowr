library WoWReforgedAltars requires WoWReforgedUtils, WoWReforgedRaces, WoWReforgedResurrectionStone

function IsAltar takes integer unitTypeId returns boolean
    if (unitTypeId == FOUNTAIN_OF_LIFE) then
        return true
    elseif (unitTypeId == HIDEOUT) then
        return true
    elseif (unitTypeId == FORTIFIED_HIDEOUT) then
        return true
    elseif (unitTypeId == GUARDIANS_CITADEL) then
        return true
    elseif (unitTypeId == TEMPLE_OF_DARKNESS) then
        return true
    elseif (unitTypeId == TEMPLE_OF_LIGHT) then
        return true
    endif

    return GetObjectRaceType(unitTypeId) == RACE_OBJECT_TYPE_ALTAR
endfunction

function IsUnitAltar takes unit whichUnit returns boolean
    return IsAltar(GetUnitTypeId(whichUnit))
endfunction

function IsAltarFilter takes nothing returns boolean
    return IsAltar(GetUnitTypeId(GetFilterUnit()))
endfunction

globals
    private player filterPlayer = null
endglobals

private function IsResurrectionStoneFilter takes nothing returns boolean
    return IsUnitResurrectionStone(GetFilterUnit()) and ResurrectionStoneHasHeroOfPlayer(GetResurrectionStoneFromUnit(GetFilterUnit()), filterPlayer)
endfunction

function SelectNextAltar takes player whichPlayer returns unit
    local group altars = CreateGroup()
    local group resurrectionStones = CreateGroup()
    local unit result = null
    call GroupEnumUnitsOfPlayer(altars, whichPlayer, Filter(function IsAltarFilter))
    set filterPlayer = whichPlayer
    call GroupEnumUnitsInRect(resurrectionStones, GetPlayableMapRect(), Filter(function IsResurrectionStoneFilter))
    call GroupAddGroup(resurrectionStones, altars)
    set result = GetNextUnitToSelect(altars, whichPlayer)
    call GroupClear(altars)
    call DestroyGroup(altars)
    set altars = null
    call GroupClear(resurrectionStones)
    call DestroyGroup(resurrectionStones)
    set resurrectionStones = null
    
    if (result != null) then
        call SelectUnitForPlayerSingle(result, whichPlayer)
        call SmartCameraPanToUnit(whichPlayer, result, 0.0)
    else
        call SimError(whichPlayer, GetLocalizedString("NO_ALTARS"))
    endif
    
    return result
endfunction

endlibrary
