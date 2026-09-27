library WoWReforgedPlayerSelection requires StringFormat

function DisplayPickedGameModeWarlord takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("WARLORD")).result())
endfunction

function DisplayPickedGameModeFreelancer takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("FREELANCER")).result())
endfunction

function RecreatePlayerSoul takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    if ( udg_PlayerSelectionSoul[convertedPlayerId] != null) then
        call UnitRemoveItemFromSlot(udg_PlayerSelectionSoul[convertedPlayerId], 1)
        call RemoveUnit(udg_PlayerSelectionSoul[convertedPlayerId])
    endif
    set udg_PlayerSelectionSoul[convertedPlayerId] = CreateUnit(whichPlayer, HERO_SELECTOR, GetPlayerStartLocationX(whichPlayer), GetPlayerStartLocationY(whichPlayer), bj_UNIT_FACING)
    call SuspendHeroXP(udg_PlayerSelectionSoul[convertedPlayerId], false)
    call PanCameraToTimedForPlayer(whichPlayer, GetPlayerStartLocationX(whichPlayer), GetPlayerStartLocationY(whichPlayer), 0)
endfunction

endlibrary
