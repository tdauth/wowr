library WoWReforgedPlayerSelection requires StringFormat

function DisplayPickedGameModeWarlord takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("WARLORD")).result())
endfunction

function DisplayPickedGameModeFreelancer takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("FREELANCER")).result())
endfunction

endlibrary
