library WoWReforgedSpade initializer Init requires WoWReforgedTerrain

globals
    private integer array playerTile
    private trigger channelTrigger = CreateTrigger()
endglobals

private function ReplaceWithTerrain takes rect whichRect, integer t returns nothing
    local real x = GetRectMinX(whichRect)
    local real y = 0.0
    local real maxX = GetRectMaxX(whichRect)
    local real maxY = GetRectMaxY(whichRect)
    loop
        exitwhen (x >= maxX)
        set y = GetRectMinY(whichRect)
        loop
            exitwhen (y >= maxY)
            call SetTerrainType(x, y, t, GetTerrainVariance(x, y), 1, 0)
            set y = y + bj_CELLWIDTH
        endloop
        set x = x  + bj_CELLWIDTH
    endloop
endfunction

private function ShowCurrentTile takes player whichPlayer returns nothing
    local integer index = playerTile[GetPlayerId(whichPlayer)]
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 4.0, GetTileName(GetMapTile(index)) + " (" + I2S(index + 1) + "/" + I2S(GetMapTilesCounter()) + ")")
endfunction

private function ChangeGround takes player whichPlayer, real x, real y returns nothing
    local integer index = playerTile[GetPlayerId(whichPlayer)]
    local location l = Location(x, y)
    call ReplaceWithTerrain(GetRectFromCircleBJ(l, 64.0), GetMapTile(index))
    call ShowCurrentTile(whichPlayer)
    call RemoveLocation(l)
    set l = null
endfunction

private function ChangeTile takes player whichPlayer, integer index returns nothing
    set playerTile[GetPlayerId(whichPlayer)] = index
    call ShowCurrentTile(whichPlayer)
endfunction

private function NextTile takes player whichPlayer returns nothing
    call ChangeTile(whichPlayer, ModuloInteger(playerTile[GetPlayerId(whichPlayer)] + 1, GetMapTilesCounter()))
endfunction

private function PreviousTile takes player whichPlayer returns nothing
    call ChangeTile(whichPlayer,ModuloInteger(playerTile[GetPlayerId(whichPlayer)] - 1, GetMapTilesCounter()))
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A269') then
        call ChangeGround(GetOwningPlayer(GetTriggerUnit()), GetSpellTargetX(), GetSpellTargetY())
    elseif (GetSpellAbilityId() == 'A26B') then
        call NextTile(GetOwningPlayer(GetTriggerUnit()))
    elseif (GetSpellAbilityId() == 'A26C') then
        call PreviousTile(GetOwningPlayer(GetTriggerUnit()))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
