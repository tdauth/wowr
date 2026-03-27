library WoWReforgedRandomCorpse requires UnitGroupRespawnSystem

function IsRandomCorpse takes integer unitTypeId returns boolean
    return unitTypeId == RANDOM_CORPSE
endfunction

function IsUnitRandomCorpse takes unit whichUnit returns boolean
    return IsRandomCorpse(GetUnitTypeId(whichUnit))
endfunction

function ReplaceRandomCorpse takes unit whichUnit returns unit
    local real x = GetUnitX(whichUnit)
    local real y = GetUnitY(whichUnit)
    local location l = Location(x, y)
    local real face = GetUnitFacing(whichUnit)
    local unit u = null

    call SetUnitPathing(whichUnit, false)
    
    set u = CreatePermanentCorpseLocBJ(bj_CORPSETYPE_FLESH, ChooseRandomCreep(GetRandomInt(1, 10)), GetOwningPlayer(whichUnit), l, face)
    call UnitDropItem(u, 'rren')
    call AddRespawnUnit(u)
    
    call RemoveUnit(whichUnit)
    set whichUnit = null
    call RemoveLocation(l)
    set l = null
    
    return u
endfunction

endlibrary
