library WoWReforgedTextTag requires TextTagUtils

globals
    private player tmpPlayer = Player(0)
    private boolean tmpShow = false
endglobals

private function ForFunctionShowTextTag takes nothing returns nothing
    if (tmpPlayer == GetLocalPlayer()) then
        call SetTextTagVisibility(GetEnumTextTag(), tmpShow)
    endif
endfunction

private function ShowPlayerSelectionTextTags takes player whichPlayer returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (whichPlayer == GetLocalPlayer()) then
            call SetTextTagVisibility(udg_PlayerSelectionSelectModeText[i + 1], false)
            call SetTextTagVisibility(udg_PlayerSelectionSettingsText[i + 1], false)
        endif
        set i = i + 1
    endloop
    if (whichPlayer == GetLocalPlayer()) then
        call SetTextTagVisibility(udg_PlayerSelectionSelectModeText[GetConvertedPlayerId(whichPlayer)], true)
        call SetTextTagVisibility(udg_PlayerSelectionSettingsText[GetConvertedPlayerId(whichPlayer)], true)
    endif
endfunction

function ShowAllTextTagsForPlayer takes player whichPlayer, boolean show returns nothing
    set tmpPlayer = whichPlayer
    set tmpShow = show
    call ForAllTextTags(function ForFunctionShowTextTag)
    if (show) then
        call ShowPlayerSelectionTextTags(whichPlayer)
    endif
endfunction

endlibrary
