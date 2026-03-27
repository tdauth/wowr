library WoWReforgedRaceUnits requires WoWReforgedRaces, WoWReforgedResources

globals
    private player filterPlayer = null
endglobals

private function IsReplacableUnit takes nothing returns boolean
    local unit u = GetFilterUnit()
    local integer id = GetUnitTypeId(u)
    local integer whichRace = udg_RaceNone
    local boolean result = false
    if (id != FOUNTAIN_OF_LIFE and id != FREELANCER_PROTECTION_TOWER and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED)) then
        set whichRace = GetObjectRace(id)
        
        set result = whichRace != udg_RaceNone and not PlayerHasRace(filterPlayer, whichRace)
    endif
    set u = null
    return result
endfunction

private function IsActualWorker takes integer id returns boolean
    if (id == NEUTRAL_CITIZEN) then
        return true
    elseif (id == NEUTRAL_CITIZEN_FEMALE) then
        return true
    endif
    return false
endfunction

private function EnumUnitUpdate takes nothing returns nothing
    local unit u = GetEnumUnit()
    local integer id = GetUnitTypeId(u)
    local integer targetId = 0
    if (targetId == 0 and GetPlayerRace1(filterPlayer) != udg_RaceNone) then
        set targetId = MapRaceObjectType(id, GetPlayerRace1(filterPlayer))
    endif
    if (targetId == 0 and GetPlayerRace2(filterPlayer) != udg_RaceNone) then
        set targetId = MapRaceObjectType(id, GetPlayerRace2(filterPlayer))
    endif
    if (targetId == 0 and GetPlayerRace3(filterPlayer) != udg_RaceNone) then
        set targetId = MapRaceObjectType(id, GetPlayerRace3(filterPlayer))
    endif
    if (targetId != 0 and (GetPlayerTechMaxAllowed(filterPlayer, targetId) == 0 or CountLivingPlayerUnitsOfTypeIdFast(targetId, filterPlayer) < GetPlayerTechMaxAllowed(filterPlayer, targetId))) then
        call ReplaceUnitBJ(u, targetId, bj_UNIT_STATE_METHOD_RELATIVE)
        if (IsUnitType(u, UNIT_TYPE_PEON) or IsActualWorker(id)) then
            call AddWoWReforgedWorker(null, GetLastReplacedUnitBJ())
        endif
    else
        call RemoveUnit(u)
    endif
    set u = null
endfunction

function UpdateAllRaceUnitsForPlayer takes player whichPlayer returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function IsReplacableUnit))
    set filterPlayer = whichPlayer
    call ForGroup(g, function EnumUnitUpdate)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

endlibrary
