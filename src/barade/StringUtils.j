library StringUtils

function B2S takes boolean b returns string
    if (b) then
        return "true"
    endif
    return "false"
endfunction

function B2Option takes boolean b returns string
    if (b) then
        return GetLocalizedString("ON")
    endif
    return GetLocalizedString("OFF")
endfunction

function StringRepeat takes string str, integer count returns string
    local string result = ""
    local integer i = 0
    loop
        exitwhen (i >= count)
        set result = result + str
        set i = i + 1
    endloop
    return result
endfunction

function StringReplace takes string source, string match, string replace returns string
    local integer i = 0
    local integer max = StringLength(source)
    local integer matchLength = StringLength(match)
    local integer index = 0
    local string result = ""
    loop
        exitwhen (i == max)
        set index = i + matchLength
        if (SubString(source, i, index) == match) then
            set result = result + replace
            set i = index
        else
            set index = i + 1
            set result = result + SubString(source, i, index)
            set i = index
        endif
    endloop
    return result
endfunction

function StringRemove takes string source, string match returns string
    return StringReplace(source, match, "")
endfunction

/**
 * Returns true if string source starts with string start.
 * Otherwise, it returns false.
 */
function StringStartsWith takes string source, string start returns boolean
    local integer i = 0
    local integer j = 1
    local integer maxStart = StringLength(start)
    if (maxStart > StringLength(source)) then
        return false
    endif
    loop
        exitwhen (i == maxStart)

        if (SubString(source, i, j) != SubString(start, i, j)) then
            return false
        endif

        set i = i + 1
        set j = j + 1
    endloop

    return true
endfunction

function StringRemoveFromStart takes string source, string start returns string
    if (StringStartsWith(source, start)) then
        return SubString(source, StringLength(start), StringLength(source))
    endif

    return source
endfunction

function IndexOfStringEx takes string symbol, string source, integer start returns integer
    local integer symbolLength = StringLength(symbol)
    local integer length = StringLength(source)
    local integer i2 = 0
    local integer i = start
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        set i2 = i + symbolLength
        exitwhen (i >= length or i2 > length)
        if (SubString(source, i, i2) == symbol) then
            //call BJDebugMsg("Index: " + I2S(i))
            return i
        endif
        set i = i + 1
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return -1
endfunction

function IndexOfString takes string symbol, string source returns integer
    return IndexOfStringEx(symbol, source, 0)
endfunction

function StringIndexOf takes string symbol, string source returns integer
    return IndexOfString(symbol, source)
endfunction

function StringCount takes string source, string symbol returns integer
    local integer result = 0
    local integer symbolLength = StringLength(symbol)
    local integer length = StringLength(source)
    local integer i = 0
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        exitwhen (i == length)
        if (SubString(source, i, i + symbolLength) == symbol) then
            //call BJDebugMsg("Index: " + I2S(i))
            set result = result + 1
            set i = i + symbolLength
        else
            set i = i + 1
        endif
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return result
endfunction

/*
 * Returns the token with the given index from string source splitting tokens by the given separator.
 * Returns null if the there is no more token for the given index.
 */
function StringSplit takes string source, integer index, string separator returns string
    local string result= null
    local integer currentIndex = 0
    local integer separatorLength = StringLength(separator)
    local integer length = StringLength(source)
    local integer i = 0
    loop
        exitwhen (i == length or currentIndex > index)
        if (SubString(source, i, i + separatorLength) == separator) then
            if (currentIndex == index and result == null) then
                set result = ""
            endif
            set currentIndex = currentIndex + 1
            set i = i + separatorLength
        else
            if (currentIndex == index) then
                if (result == null) then
                    set result = ""
                endif
                set result = result + SubString(source, i, i + 1)
            endif
            set i = i + 1
        endif
    endloop

    return result
endfunction

/**
 * Useful for getting parts of a chat message to implement chat commands.
 * Note that his skips multiple separators next to each other like whitespaces and counts them as one.
 */
function StringTokenEx takes string source, integer index, string separator, boolean toTheEnd returns string
    local string result = ""
    local boolean inWhitespace = false
    local integer currentIndex = 0
    local integer separatorLength = StringLength(separator)
    local integer length = StringLength(source)
    local integer i = 0
    loop
        exitwhen (i == length or currentIndex > index)
        if (SubString(source, i, i + separatorLength) == separator and (not toTheEnd or currentIndex < index)) then
            if (not inWhitespace) then
                set inWhitespace = true
                set currentIndex = currentIndex + 1
                set i = i + separatorLength
            endif
        else
            if (currentIndex == index) then
                set result = result + SubString(source, i, i + 1)
            endif
            set inWhitespace = false
            set i = i + 1
        endif
    endloop

    return result
endfunction

function StringToken takes string source, integer index returns string
    return StringTokenEx(source, index, " ", false)
endfunction

function StringTokenEnteredChatMessageEx takes integer index, boolean toTheEnd returns string
    return StringTokenEx(GetEventPlayerChatString(), index, " ", toTheEnd)
endfunction

function StringTokenEnteredChatMessage takes integer index returns string
    return StringToken(GetEventPlayerChatString(), index)
endfunction

function RandomizeString takes string source returns string
    local string result = ""
    local integer sourcePosition = 0
    local integer max = StringLength(source)
    loop
        exitwhen (max == 0)
        set sourcePosition = GetRandomInt(0, max - 1)
        set result = result + SubString(source, sourcePosition, sourcePosition + 1)
        set source = SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, max)
        set max = StringLength(source)
    endloop

    return result
endfunction

function StringRandomize takes string source returns string
    return RandomizeString(source)
endfunction

function I2SW takes integer i, integer width returns string
    local integer a = 0
    local string result = ""
    local integer max = 0
    if (width > 0) then
        set a = IAbsBJ(i)
        set max = R2I(Pow(R2I(10), R2I(width - 1)))
        if (i < 0) then
            set result = result + "-"
        endif
        loop
            if (a >= max or max <= 1) then
                set result = result + I2S(a)
                exitwhen (true)
            else
                set result = result + "0"
                set max = max / 10 
            endif
        endloop
    else
        set result = I2S(i)
    endif
    return result
endfunction

function FormatTimeString takes integer seconds returns string
    local integer minutes = seconds / 60
    local integer hours = minutes / 60
    local integer hoursInMinutes = hours * 60
    local integer minutesInSeconds = minutes * 60

    set minutes = minutes - hoursInMinutes
    set seconds = seconds - minutesInSeconds

    if (hours > 0) then
        return I2SW(hours, 2) + ":" + I2SW(minutes, 2) + ":" + I2SW(seconds, 2)
    elseif (minutes > 0) then
        return I2SW(minutes, 2) + ":" + I2SW(seconds, 2)
    else
        return I2S(seconds) + " seconds"
    endif
endfunction

function FormatTime takes real time returns string
    local integer hours= R2I(time / 3600.0)
    local integer minutes=  R2I(time - hours * 3600) / 60
    local integer seconds= R2I(time - hours * 3600 - minutes * 60)
    
    return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
endfunction

function IsCharacterDigit takes string c returns boolean
    return c == "0" or c == "1" or c == "2" or c == "3" or c == "4" or c == "5" or c == "6" or c == "7" or c == "8" or c == "9"
endfunction

function IsStringNumber takes string whichString returns boolean
    local integer length = StringLength(whichString)
    local integer i = 0
    loop
        exitwhen (i == length)
        if (not IsCharacterDigit(SubString(whichString, i, i + 1))) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

/**
 * Inserts line break escape sequence characters ('\n') into string \p whichString by separating it into sub strings of maximum length \p maxLineLength.
 * Useful for displaying text paragraphs (such as dialog messages).
 * \param whichString String which is separated into sub strings ending with a line break character.
 * \param maxLineLength Maximum allowed length of one sub string line.
 * \return Returns \p whichString separated into sub strings of maximum length \p maxLineLength ending with '\n' character.
 * \todo bugged?
 */
function InsertLineBreaks takes string whichString, integer maxLineLength returns string
    local integer i
    local string result
    local integer max = StringLength(whichString)
    if (max <= maxLineLength) then
        return whichString
    endif
    set result = ""
    set i = maxLineLength
    loop
        exitwhen (i > max)
        set result = result + SubString(whichString, i - maxLineLength, i) + "\n"
        set i = i + maxLineLength
    endloop

    if (i < max) then
        set result = result + SubString(whichString, i - maxLineLength, max)
    endif

    return result
endfunction

/**
 * \author Extrarius
 * <a href="http://www.wc3jass.com/">source</a>
 */
function GetExternalString takes integer index returns string
    if (index < 0) then
        return ""
    elseif (index < 10) then
        return GetLocalizedString("TRIGSTR_00" + I2S(index))
    elseif (index < 100) then
        return GetLocalizedString("TRIGSTR_0" + I2S(index))
    else
        return GetLocalizedString("TRIGSTR_" + I2S(index))
    endif
endfunction

endlibrary
