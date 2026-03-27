library SafeString

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
