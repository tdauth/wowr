library WoWReforgedSay requires SelectionUtils, PlayerColorUtils, WoWReforgedZones

function Say takes player whichPlayer, string message returns unit
    local group g = GetUnitsSelectedAllSafe(whichPlayer)
    local unit first = FirstOfGroup(g)
    if (first != null) then
        //call ShowGeneralFadingTextTagForForce(GetPlayersAll(), GetUnitName(first) + ": " + message, GetUnitX(first), GetUnitY(first), 255, 255, 255, 0)
        call ShowFadingTextTagForForce(GetPlayersAll(), GetUnitName(first) + ": " + message, 0.025, GetUnitX(first), GetUnitY(first), 255, 255, 255, 0, 0.02, 1.0, 6.0)
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return first
endfunction

function Shout takes player whichPlayer, string message returns nothing
    local unit first = Say(whichPlayer, message)
    local Zone zone = 0
    if (first != null) then
        set zone = GetZoneByCoordinates(GetUnitX(first), GetUnitY(first))
        if (zone != 0) then
            call DisplayTimedTextFromPlayer(whichPlayer, 0.0, 0.0, 6.0, GetPlayerColorString(GetPlayerColor(whichPlayer), GetUnitName(first)) + ": " + message)
        else
            call DisplayTimedTextFromPlayer(whichPlayer, 0.0, 0.0, 6.0, GetPlayerColorString(GetPlayerColor(whichPlayer), GetUnitName(first)) + " (" + zone.name  + "): " + message)
        endif
        call PingMinimapEx(GetUnitX(first), GetUnitY(first), 6.0, 255, 165, 0, false)
        set first = null
    endif
endfunction

endlibrary
