// Barade's Save Code System 1.0
//
// Allows storing and loading custom save codes which contain any information.
//
// Details:
// save code digit - a digit of the number system used for a save code. This can be decimal, hexadecimal or custom.
// save code segment - a savecode consists of multiple segments storing information about specific properties.
// save code segment separator - the segments are separated by a special digit which is not used in the save code's digit to identify where a new segment starts
// save code - a save code using the digits of a sepcific number system consisting of one or several segments.
// string hash - a decimal value generated from a string using a one way function which cannot be converted back into its original string. We only use positive hash values to keep it simple.
// player name hash - a hash value from the player name used to verify that the savecode belongs to the using player
// save code checksum - a checksum of the save code in form of ea save code segment created by hashing the string up to excluding the checksum segment itself. This is used to verify that the savecode was not created manually although it could be faked.
//
// A save code could look the following way:
// <player name hash segment>X<game mode/single or multiplayer flag>X<game type>X<hero XP rate>X<hero XP>X<checksum>
//
// Obfuscation: Since it is pretty easy to know which segment has which information using these save code segments, we want to obfuscate the final generated save code a bit.
// We can do this by shifting the used digits using the player name hash since it will also be the same when the player loads the save code. By shifting the digits we might get different digits for different player name hashs.
//
// Compression: We want to keep the savecodes as short as possible. Hence, we combine flags like game mode and single/multiplayer in one number. We could go even further as long as we know the maximum number of a value.
// Another form of compression is to make the string hashes much shorter by using the modulo operation. This comes with the risk of having less different string hashes for different player names or as checksums but as long
// as there are enough possibilities it is hard enough to fake the correct string hash value.
library SaveCodeSystem requires WoWReforgedUtils, Ascii

globals
    // ASCII without space, \, " and ~. The character \ caused issues and was duplicated by Warcraft. The characters " and \ are not supported by FileIO:
    constant string SAVE_CODE_DIGITS = "_Ci{o98%*rQaHA=cM>Pj]NTUq/u7y(-S!)hzpR:}DKLvBJXI4O[k@e53<FVftm,6dlZ&bY2^#nx'+wG|?s`E1$;.0gW"
    constant string SAVE_CODE_SEGMENT_SEPARATOR = "~" // must not be part of SAVE_CODE_DIGITS
    constant string SAVE_CODE_SYMBOL_UNKNOWN = "~" // must not be part of SAVE_CODE_DIGITS
    constant boolean SAVE_CODE_COMPRESS_STRING_HASHS = true
    constant boolean SAVE_CODE_OBFUSCATE = true
endglobals

function CheckStringForDuplicatedCharacters takes string source returns nothing
    local boolean foundDuplicated = false
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == StringLength(source))
        set j = 0
        loop
            exitwhen (j == StringLength(source))
            if (i != j and SubString(source, i, i + 1) == SubString(source, j, j + 1)) then
                set foundDuplicated = true
                call BJDebugMsg("Duplicated digit at " + I2S(i) + " and " + I2S(j) + ": " + SubString(source, i, i + 1))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    if (not foundDuplicated) then
        call BJDebugMsg("No duplicates have been found!")
    endif
endfunction

function CheckStringForNonAsciiCharacters takes string source returns nothing
    local integer i = 0
    loop
        exitwhen (i == StringLength(source))
        call Char2Ascii(SubString(source, i, i + 1))
        set i = i + 1
    endloop
endfunction

function CheckSaveCodeDigitsUnique takes nothing returns nothing
    call CheckStringForDuplicatedCharacters(SAVE_CODE_DIGITS)
endfunction

function CheckSaveCodeDigitsAscii takes nothing returns nothing
    call CheckStringForNonAsciiCharacters(SAVE_CODE_DIGITS)
endfunction

// Returns the base for the custom number system.
function GetMaxSaveCodeDigitsEx takes string alphabet returns integer
    return StringLength(alphabet)
endfunction

function GetMaxSaveCodeDigits takes nothing returns integer
    return GetMaxSaveCodeDigitsEx(SAVE_CODE_DIGITS)
endfunction

function ConvertDecimalDigitToSaveCodeDigit takes integer digit returns string
    return SubString(SAVE_CODE_DIGITS, digit, digit + 1)
endfunction

function IndexOfSaveCodeDigitEx takes string symbol, string alphabet returns integer
    return IndexOfString(symbol, alphabet)
endfunction

function IndexOfSaveCodeDigit takes string symbol returns integer
    return IndexOfSaveCodeDigitEx(symbol, SAVE_CODE_DIGITS)
endfunction

function GetObfuscationSaveCodeDigitsEx takes string alphabet returns string
    // we want to have the separator in it so we can obfuscate the whole save code with separators.
    return alphabet + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function GetObfuscationSaveCodeDigits takes nothing returns string
    return GetObfuscationSaveCodeDigitsEx(SAVE_CODE_DIGITS)
endfunction

function GetMaxObfuscationSaveCodeDigitsEx takes string alphabet returns integer
    return GetMaxSaveCodeDigitsEx(alphabet) + 1
endfunction

function GetMaxObfuscationSaveCodeDigits takes nothing returns integer
    return GetMaxObfuscationSaveCodeDigitsEx(SAVE_CODE_DIGITS)
endfunction


function GetShiftedSaveCodeSplitPositionEx takes integer n, string alphabet returns integer
    return ModuloInteger(n, GetMaxObfuscationSaveCodeDigitsEx(alphabet))
endfunction

function GetShiftedSaveCodeSplitPosition takes integer n returns integer
    return GetShiftedSaveCodeSplitPositionEx(n, SAVE_CODE_DIGITS)
endfunction

// Use a hash value (like the player name's hash) to move the symbol table. This might prevent reproducing savecodes too easily.
function GetShiftedSaveCodeDigitsEx takes integer n, string alphabet returns string
    local integer max = GetMaxObfuscationSaveCodeDigitsEx(alphabet)
    local string saveCodeDigits = GetObfuscationSaveCodeDigitsEx(alphabet)
    local integer splitPosition = GetShiftedSaveCodeSplitPositionEx(n, alphabet)
    return SubString(saveCodeDigits, splitPosition, GetMaxObfuscationSaveCodeDigitsEx(alphabet)) + SubString(saveCodeDigits, 0, splitPosition)
endfunction

function GetShiftedSaveCodeDigits takes integer n returns string
    return GetShiftedSaveCodeDigitsEx(n, SAVE_CODE_DIGITS)
endfunction

// TODO Can be slow for big numbers. Maybe move into a separate trigger with a new OpLimit.
function ConvertDecimalNumberToSaveCodeSegment takes integer number returns string
    local string result = ""
    local integer start = number
    local integer base = GetMaxSaveCodeDigits()
    local integer mod = 0
    //call BJDebugMsg("Converting number " + I2S(start))
    loop
        //call BJDebugMsg("Dividing number " + I2S(start) + " by " + I2S(base))
        set mod = ModuloInteger(start, base)
        set start = start / base
        set result = ConvertDecimalDigitToSaveCodeDigit(mod) + result
        exitwhen (start == 0)
        //call BJDebugMsg("Result: " + result)
    endloop

    return result + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function ConvertSaveCodeToObfuscatedVersion takes string saveCode, integer hash returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigits(hash)
    local string saveCodeDigits = GetObfuscationSaveCodeDigits()
    local integer index = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set index = IndexOfString(SubString(saveCode, i, i + 1), saveCodeDigits)
        if (index != -1) then
            set result = result + SubString(shiftedSaveCodeDigits, index, index + 1)
        else
            set result = result + SAVE_CODE_SYMBOL_UNKNOWN
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ConvertSaveCodeFromObfuscatedVersionEx takes string saveCode, integer hash, string alphabet returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigitsEx(hash, alphabet)
    local integer splitPosition = GetShiftedSaveCodeSplitPositionEx(hash, alphabet)
    local integer shiftedIndex = -1
    local integer originalIndex = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set shiftedIndex = IndexOfString(SubString(saveCode, i, i + 1), shiftedSaveCodeDigits)
        if (shiftedIndex != -1) then
            set result = result + SubString(GetObfuscationSaveCodeDigitsEx(alphabet), shiftedIndex, shiftedIndex + 1)
        else
            set result = result + SAVE_CODE_SYMBOL_UNKNOWN
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ConvertSaveCodeFromObfuscatedVersion takes string saveCode, integer hash returns string
    return ConvertSaveCodeFromObfuscatedVersionEx(saveCode, hash, SAVE_CODE_DIGITS)
endfunction

function PowI takes integer x, integer y returns integer
    local integer result = 1
    local integer i = 0
    loop
        exitwhen (i == y)
        set result = result * x
        set i = i + 1
    endloop

    return result
endfunction

// Convert our number system into the decimal system number.
function ConvertSaveCodeSegmentIntoDecimalNumberEx takes string symbol, integer n, string alphabet returns integer
    local integer index = IndexOfSaveCodeDigitEx(symbol, alphabet)
    if (index != -1) then
        //call BJDebugMsg("Index " + I2S(index) +  " for symbol " + symbol + " pow " + I2S(GetMaxSaveCodeDigits()) + ", " + I2S(n))
        return index * PowI(GetMaxSaveCodeDigitsEx(alphabet), n)
    endif
    //call BJDebugMsg("Cannot find symbol: " + symbol + " with n: " + I2S(n))
    return 0
endfunction

function ConvertSaveCodeSegmentIntoDecimalNumber takes string symbol, integer n returns integer
    return ConvertSaveCodeSegmentIntoDecimalNumberEx(symbol, n, SAVE_CODE_DIGITS)
endfunction

// the separator comes after a segment
function GetSaveCodeSegments takes string saveCode returns integer
    local integer separatorCounter = 0
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        endif
        set i = i + 1
    endloop

    return separatorCounter
endfunction

// includes the separator character!
function GetSaveCodeUntil takes string saveCode, integer excludedIndex returns string
    local integer separatorCounter = 0
    local integer index = StringLength(saveCode)
    local integer i = 0
    loop
        exitwhen (separatorCounter >= excludedIndex or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
            set index = i + 1 // include the separator character!
        endif
        set i = i + 1
    endloop

    return SubString(saveCode, 0, index)
endfunction

/**
 * Extracts the part of a save code with index and converts it into a decimal number.
 */
 function ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCodeEx takes string saveCode, integer index, string alphabet returns integer
    local string substr = ""
    local integer result = 0
    local integer separatorCounter = 0
    local integer n = -1 // start with n - 1 and end with 0
    local integer i = 0
    loop
        exitwhen (separatorCounter > index or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        elseif (separatorCounter == index) then
            set substr = substr + SubString(saveCode, i, i + 1)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // convert into decimal number
    //call BJDebugMsg("Calculate number back " + substr)
    set i = 0
    loop
        exitwhen (i == StringLength(substr))
        set result = result + ConvertSaveCodeSegmentIntoDecimalNumberEx(SubString(substr, i, i + 1), n, alphabet)
        //call BJDebugMsg("Result " + I2S(result))
        set n = n - 1
        set i = i + 1
    endloop

    return result
endfunction

function ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode takes string saveCode, integer index returns integer
    return ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCodeEx(saveCode, index, SAVE_CODE_DIGITS)
endfunction

// Strings are just obfuscated per character.
// Otherwise, we would need to store the length per character.
// The characters must be in the savecode alphabet. Otherwise, they will become a ? character.
function ConvertStringToSaveCodeSegment takes string whichString, integer hash returns string
    local string result = ""
    local string character = ""
    local integer i = 0
    loop
        exitwhen (i == StringLength(whichString))
        set character = SubString(whichString, i, i + 1)
        // no space characters please
        if (character == " ") then
            set character = "_"
        endif
        set result = result + ConvertSaveCodeToObfuscatedVersion(character, hash)
        set i = i + 1
    endloop
    return result + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function ConvertSaveCodeSegmentIntoStringFromSaveCode takes string saveCode, integer index, integer hash returns string
    local string substr = ""
    local string character = ""
    local string result = ""
    local integer separatorCounter = 0
    local integer n = -1 // start with n - 1 and end with 0
    local integer i = 0
    loop
        exitwhen (separatorCounter > index or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        elseif (separatorCounter == index) then
            set substr = substr + SubString(saveCode, i, i + 1)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // convert into decimal number
    //call BJDebugMsg("Calculate number back " + substr)
    set i = 0
    loop
        exitwhen (i == StringLength(substr))
        set character = ConvertSaveCodeFromObfuscatedVersion(SubString(substr, i, i + 1), hash)
        // underscores are space characters by default
        if (character == "_") then
            set character = " "
        endif
        set result = result + character
        //call BJDebugMsg("Result " + I2S(result))
        set n = n - 1
        set i = i + 1
    endloop

    return result
endfunction

// We don't want to handle negative numbers.
function AbsStringHash takes string whichString returns integer
    return IAbsBJ(StringHash(whichString))
endfunction

// If the string hash value is too big, the savecodes get too long.
function CompressedAbsStringHash takes string whichString returns integer
    local integer absStringHash = AbsStringHash(whichString)
    if (SAVE_CODE_COMPRESS_STRING_HASHS) then
        return ModuloInteger(absStringHash, GetMaxSaveCodeDigits() * 3)
    endif
    return absStringHash
endfunction

function IsCharacterUpperCase takes string letter returns boolean
    return letter == "A" or letter == "B" or letter == "C" or letter == "D" or letter == "E" or letter == "F" or letter == "G" or letter == "H" or letter == "I" or letter == "J" or letter == "K" or letter == "L" or letter == "M" or letter == "N" or letter == "O" or letter == "P" or letter == "Q" or letter == "R" or letter == "S" or letter == "T" or letter == "U" or letter == "V" or letter == "W" or letter == "X" or letter == "Y" or letter == "Z"
endfunction

function ColoredSaveCode takes string saveCode returns string
    local string result = ""
    local string char = ""
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        set char = SubString(saveCode, i, i + 1)
        if (IsCharacterUpperCase(char)) then
            set result = result + "|cffffcc00" + char + "|r"
        elseif (char == "|") then
            set result = result + "||" // escape to avoid invalid color codes
        else
            set result = result + char
        endif
        set i = i + 1
    endloop

    return result
endfunction

function AppendFileContent takes string content returns string
    return "\r\n" + content
endfunction

function AppendFileContentLeft takes string content returns string
    return "\r\n" + content
endfunction

endlibrary
