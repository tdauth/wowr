library SafeString

/*
 * Saving the game with a string longer than 1023 characters will lead to a crash when loading the savegame in Warcraft III: Reforged.
 * This library provides GetLocalizedStringSafe which checks for the length and does not return and localized string which is longar than 1023 characters.
 */

globals
    constant integer MAX_STRING_LENGTH = 1023
endglobals

function GetLocalizedStringSafe takes string source returns string
    local string r = GetLocalizedString(source)
    if (StringLength(r) <= MAX_STRING_LENGTH) then
        return r
    endif
    return source + " is longer than " + I2S(MAX_STRING_LENGTH)
endfunction

endlibrary
