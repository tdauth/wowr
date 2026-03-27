library PlayerColorUtils initializer Init requires StringUtils, ForceUtils

function GetPlayerColorTexture takes playercolor c returns string
    return "ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId(c), 2)
endfunction

function GetPlayerColorRed takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0xFF
    elseif c == PLAYER_COLOR_BLUE then
        return 0x00
    elseif c == PLAYER_COLOR_CYAN then
        return 0x1B
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x53
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFF
    elseif c == PLAYER_COLOR_ORANGE then
        return 0xFE
    elseif c == PLAYER_COLOR_GREEN then
        return 0x1F
    elseif c == PLAYER_COLOR_PINK then
        return 0xE4
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x94
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0x7D
    elseif c == PLAYER_COLOR_AQUA then
        return 0x0F
    elseif c == PLAYER_COLOR_BROWN then
        return 0x4D
    elseif c == PLAYER_COLOR_MAROON then
        return 0x9B
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0x00
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xBE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xEB
    elseif c == PLAYER_COLOR_PEACH then
        return 0xF8
    elseif c == PLAYER_COLOR_MINT then
        return 0xBF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xDC
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xEB
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x00
    elseif c == PLAYER_COLOR_PEANUT then
        return 0xA4
    else
        return 0xFF
    endif
    return 0
endfunction

function GetPlayerColorGreen takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0x41
    elseif c == PLAYER_COLOR_CYAN then
        return 0xE5
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x00
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFC
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x89
    elseif c == PLAYER_COLOR_GREEN then
        return 0xBF
    elseif c == PLAYER_COLOR_PINK then
        return 0x5A
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x95
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xBE
    elseif c == PLAYER_COLOR_AQUA then
        return 0x61
    elseif c == PLAYER_COLOR_BROWN then
        return 0x29
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xEA
    elseif c == PLAYER_COLOR_VIOLET then
        return 0x00
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xCD
    elseif c == PLAYER_COLOR_PEACH then
        return 0xA4
    elseif c == PLAYER_COLOR_MINT then
        return 0xFF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xB9
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xF0
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x78
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x6F
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorBlue takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0xFF
    elseif c == PLAYER_COLOR_CYAN then
        return 0xB8
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x80
    elseif c == PLAYER_COLOR_YELLOW then
        return 0x00
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x0D
    elseif c == PLAYER_COLOR_GREEN then
        return 0x00
    elseif c == PLAYER_COLOR_PINK then
        return 0xAF
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x96
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xF1
    elseif c == PLAYER_COLOR_AQUA then
        return 0x45
    elseif c == PLAYER_COLOR_BROWN then
        return 0x03
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0xC3
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xFF
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xFE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0x87
    elseif c == PLAYER_COLOR_PEACH then
        return 0x8B
    elseif c == PLAYER_COLOR_MINT then
        return 0x80
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xEB
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xFF
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x1E
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x33
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorString takes playercolor c, string text returns string
//Credits to Andrewgosu from TH for the color codes//
    if c == PLAYER_COLOR_RED then
        return "|cffFF0202" + text + "|r"
    elseif c == PLAYER_COLOR_BLUE then
        return "|cff0041FF" + text + "|r"
    elseif c == PLAYER_COLOR_CYAN then
        return "|cff1BE5B8" + text + "|r"
    elseif c == PLAYER_COLOR_PURPLE then
        return "|cff530080" + text + "|r"
    elseif c == PLAYER_COLOR_YELLOW then
        return "|cffFFFC00" + text + "|r"
    elseif c == PLAYER_COLOR_ORANGE then
        return "|cffFE890D" + text + "|r"
    elseif c == PLAYER_COLOR_GREEN then
        return "|cff1FBF00" + text + "|r"
    elseif c == PLAYER_COLOR_PINK then
        return "|cffE45AAF" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return "|cff949596" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return "|cff7DBEF1" + text + "|r"
    elseif c == PLAYER_COLOR_AQUA then
        return "|cff0F6145" + text + "|r"
    elseif c == PLAYER_COLOR_BROWN then
        return "|cff4D2903" + text + "|r"
    elseif c == PLAYER_COLOR_MAROON then
        return "|cff9B0000" + text + "|r"
    elseif c == PLAYER_COLOR_NAVY then
        return "|cff0000C3" + text + "|r"
    elseif c == PLAYER_COLOR_TURQUOISE then
        return "|cff00EAFF" + text + "|r"
    elseif c == PLAYER_COLOR_VIOLET then
        return "|cffBE00FE" + text + "|r"
    elseif c == PLAYER_COLOR_WHEAT then
        return "|cffEBCD87" + text + "|r"
    elseif c == PLAYER_COLOR_PEACH then
        return "|cffF8A48B" + text + "|r"
    elseif c == PLAYER_COLOR_MINT then
        return "|cffBFFF80" + text + "|r"
    elseif c == PLAYER_COLOR_LAVENDER then
        return "|cffDCB9EB" + text + "|r"
    elseif c == PLAYER_COLOR_COAL then
        return "|cff282828" + text + "|r"
    elseif c == PLAYER_COLOR_SNOW then
        return "|cffEBF0FF" + text + "|r"
    elseif c == PLAYER_COLOR_EMERALD then
        return "|cff00781E" + text + "|r"
    elseif c == PLAYER_COLOR_PEANUT then
        return "|cffA46F33" + text + "|r"
    else
        return "|cffFFFFFF" + text + "|r"
    endif
endfunction

function GetPlayerNameColoredSimple takes player whichPlayer returns string
	return GetPlayerColorString(GetPlayerColor(whichPlayer), GetPlayerName(whichPlayer))
endfunction

function GetPlayerNameColored takes player whichPlayer returns string
	return "[" + I2S(GetPlayerId(whichPlayer) + 1) + "]" + GetPlayerNameColoredSimple(whichPlayer)
endfunction

globals
    private string array PlayerColorNames
endglobals

private function Init takes nothing returns nothing
    set PlayerColorNames[0] = "RED"
    set PlayerColorNames[1] = "BLUE"
    set PlayerColorNames[2] = "CYAN"
    set PlayerColorNames[3] = "PURPLE"
    set PlayerColorNames[4] = "YELLOW"
    set PlayerColorNames[5] = "ORANGE"
    set PlayerColorNames[6] = "GREEN"
    set PlayerColorNames[7] = "PINK"
    set PlayerColorNames[8] = "LIGHT_GRAY"
    set PlayerColorNames[9] = "LIGHT_BLUE"
    set PlayerColorNames[10] = "AQUA"
    set PlayerColorNames[11] = "BROWN"
    set PlayerColorNames[12] = "MAROON"
    set PlayerColorNames[13] = "NAVY"
    set PlayerColorNames[14] = "TURQUOISE"
    set PlayerColorNames[15] = "VIOLET"
    set PlayerColorNames[16] = "WHEAT"
    set PlayerColorNames[17] = "PEACH"
    set PlayerColorNames[18] = "MINT"
    set PlayerColorNames[19] = "LAVENDER"
    set PlayerColorNames[20] = "COAL"
    set PlayerColorNames[21] = "SNOW"
    set PlayerColorNames[22] = "EMERALD"
    set PlayerColorNames[23] = "PEANUT"
endfunction

function GetPlayerColorName takes player whichPlayer returns string
    return StringCase(PlayerColorNames[GetPlayerId(whichPlayer)], false)
endfunction

function GetPlayerColorFromString takes string whichString returns playercolor
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (whichString == I2S(i + 1) or (PlayerColorNames[i] != null and StringLength(PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorNames[i]) or (StringLength(GetPlayerName(Player(i))) > 0 and StringStartsWith(GetPlayerName(Player(i)), whichString))) then
            return ConvertPlayerColor(i)
        endif
        set i = i + 1
    endloop

    return null
endfunction

function GetPlayerFromString takes string whichString returns player
    local integer i = 0
    if (StringLength(whichString) > 0) then
        loop
            exitwhen (i == bj_MAX_PLAYERS)
            if (whichString == I2S(i + 1) or (PlayerColorNames[i] != null and StringLength(PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorNames[i]) or (StringLength(GetPlayerName(Player(i))) > 0 and StringStartsWith(GetPlayerName(Player(i)), whichString))) then
                return Player(i)
            endif
            set i = i + 1
        endloop
    endif

    return null
endfunction

/*
 * Make sure to destroy the returned force to prevent memory leaks.
 */
function GetForceFromString takes string whichString returns force
    local force f = CreateForce()
    local player p = null
    if (whichString == "all" and whichString == "*" or whichString == "any") then
        call ForceAddForce(f, GetPlayersAll())
    else
        set p = GetPlayerFromString(whichString)
        if (p != null) then
            call ForceAddPlayer(f, p)
        endif
    endif
    return f
endfunction

function GetPlayerNameWithoutTagEx takes string playerName returns string
    local integer index = IndexOfString("#", playerName)
    if (index != -1) then
         return SubString(playerName, 0, index)
    endif
    return playerName
endfunction

function GetPlayerNameWithoutTag takes player whichPlayer returns string
     return GetPlayerNameWithoutTagEx(GetPlayerName(whichPlayer))
endfunction

endlibrary
