library WoWReforgedNeutralZone requires WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedMapData, WoWReforgedI18n, WoWReforgedResurrectionStone

function ResetHeroToNeutralZone takes unit hero, real x, real y, real facing returns nothing
    call SetUnitPosition(hero, x, y)
    call ReviveHero(hero, x, y, true)
    call SetUnitFacing(hero, facing)
    call SetUnitInvulnerable(hero, false) // could be from player selection
    call DropAllItemsFromHero(hero)
endfunction

// Only when a player leaves the game.
function ResetAllHeroesToNeutralZone takes player whichPlayer returns nothing
    local real x = GetMapNeutralZoneX(whichPlayer)
    local real y = GetMapNeutralZoneY(whichPlayer)
    local real facing = GetMapNeutralZoneFacing(whichPlayer)
    
    // Prevent endless automatic hero revivals of left players.
    call DeactivateAllResurrectionStones(whichPlayer)
    
    if (GetPlayerHero1(whichPlayer) != null) then
        call ResetHeroToNeutralZone(GetPlayerHero1(whichPlayer), x, y, facing)
    endif
    if (GetPlayerHero2(whichPlayer) != null) then
        call ResetHeroToNeutralZone(GetPlayerHero2(whichPlayer), x, y, facing)
    endif
    if (GetPlayerHero3(whichPlayer) != null) then
        call ResetHeroToNeutralZone(GetPlayerHero3(whichPlayer), x, y, facing)
    endif
    call DropBackpackForPlayerTo(whichPlayer, x, y)
endfunction

endlibrary
