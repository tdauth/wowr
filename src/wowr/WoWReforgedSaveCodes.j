library WoWReforgedSaveCodes requires OpLimit, StringUtils, ForceUtils, MaxHpResearch, SaveCodeSystem, WoWReforgedSaveCodeObjects, WoWReforgedUtils, WoWReforgedMapData, WoWReforgedResources, WoWReforgedEquipmentBags, WoWReforgedClans, WoWReforgedHeroJourney, WoWReforgedEvolution, WoWReforgedDemigod, WoWReforgedDependencyEquivalents, WoWReforgedRaces, WoWReforgedProfessions, WoWReforgedItemCheck, WoWReforgedTradingPosts, WoWReforgedPortals, WoWReforgedAntimagicWards, WoWReforgedBanners, WoWReforgedSkins, WoWReforgedRecordPlayer

globals
    constant integer SAVE_CODE_INDEX_TYPE = 0
    constant integer SAVE_CODE_INDEX_PLAYER_NAME_HASH = 1
    constant integer SAVE_CODE_INDEX_MODE = 2
    constant integer SAVE_CODE_INDEX_XP_RATE = 3
    constant integer SAVE_CODE_INDEX_INDEX = 4 // items, units, buildings, researches etc.
    constant integer SAVE_CODE_INDEX_XP = 4
    constant integer SAVE_CODE_INDEX_XP_2 = 5
    constant integer SAVE_CODE_INDEX_XP_3 = 6
    constant integer SAVE_CODE_INDEX_GOLD = 7
    constant integer SAVE_CODE_INDEX_LUMBER = 8
    constant integer SAVE_CODE_INDEX_EVOLUTION = 9
    constant integer SAVE_CODE_INDEX_DEMIGOD = 10
    constant integer SAVE_CODE_INDEX_EQUIPMENT_BAGS = 11

    constant integer SAVE_CODE_TYPE_HEROES = 0
    constant integer SAVE_CODE_TYPE_ITEMS = 1
    constant integer SAVE_CODE_TYPE_UNITS = 2
    constant integer SAVE_CODE_TYPE_BUILDINGS = 3
    constant integer SAVE_CODE_TYPE_RESEARCHES = 4
    constant integer SAVE_CODE_TYPE_RESOURCES = 5
    constant integer SAVE_CODE_TYPE_CLAN = 6
    constant integer SAVE_CODE_TYPE_LETTER = 7
    
    // store all generated/already loaded save codes during a game to prevent loading them immediately and duplicating stuff
    string array generatedSaveCodes
    integer generatedSaveCodesCounter = 0
endglobals

function GetSaveCodeTypeName takes integer t returns string
    if (t == SAVE_CODE_TYPE_HEROES) then
        return "Heroes"
    elseif (t == SAVE_CODE_TYPE_ITEMS) then
        return "Items"
    elseif (t == SAVE_CODE_TYPE_UNITS) then
        return "Units"
    elseif (t == SAVE_CODE_TYPE_BUILDINGS) then
        return "Buildings"
    elseif (t == SAVE_CODE_TYPE_RESEARCHES) then
        return "Researches"
    elseif (t == SAVE_CODE_TYPE_RESOURCES) then
        return "Resources"
    elseif (t == SAVE_CODE_TYPE_CLAN) then
        return "Clan"
    elseif (t == SAVE_CODE_TYPE_LETTER) then
        return "Letter"
    endif
    return "Unknown"
endfunction

function GetSinglePlayerStatus takes boolean isSinglePlayer returns string
    if (isSinglePlayer) then
        return "S"
    endif

    return "M"
endfunction

function ClearGeneratedSaveCodes takes nothing returns nothing
    set generatedSaveCodesCounter = 0
endfunction

function ClearGeneratedSaveCodesVIP takes player whichPlayer returns nothing
    if (IsPlayerVIP(whichPlayer)) then
        call ClearGeneratedSaveCodes()
        call DisplayTimedTextToForce(GetPlayersAll(), 4.0, Format(GetLocalizedString("X_HAS_RESET_USED_SAVE_CODES")).s(GetPlayerNameColored(whichPlayer)).result())
    else
        call SimError(whichPlayer, GetLocalizedString("ONLY_ALLOWED_FOR_VIPS"))
    endif
endfunction

function GetGeneratedSaveCode takes string saveCode returns integer
    local integer i = 0
    loop
        exitwhen (i >= generatedSaveCodesCounter)
        if (saveCode == generatedSaveCodes[i]) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function IsGeneratedSaveCode takes string saveCode returns boolean
    return GetGeneratedSaveCode(saveCode) != -1
endfunction

function AddGeneratedSaveCode takes string saveCode returns integer
    local integer index = GetGeneratedSaveCode(saveCode)
    if (index == -1) then
        set generatedSaveCodes[generatedSaveCodesCounter] = saveCode
        set generatedSaveCodesCounter = generatedSaveCodesCounter + 1
        return generatedSaveCodesCounter
    endif
    return index
endfunction

function DisplayGeneratedSaveCodes takes player whichPlayer returns nothing
    local string msg = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= generatedSaveCodesCounter)
        set msg = msg + "\n- " + generatedSaveCodes[i]
        set counter =  counter + 1
        set i = i + 1
    endloop
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("GENERATED_SAVE_CODES")).i(counter).s(msg).result())
endfunction

function GetPlayerNameByHash takes string playerName, integer playerNameHash returns string
    if (playerNameHash != CompressedAbsStringHash(playerName)) then
        return GetLocalizedString("NOT_YOURS")
    endif
    return Format(GetLocalizedString("YOURS")).s(playerName).result()
endfunction

function GetGeneratedStatus takes boolean generated returns string
    if (generated) then
        return GetLocalizedString("YES_GREEN")
    endif
    return GetLocalizedString("NO_RED")
endfunction

function GetChecksumStatus takes integer checksum, string checkedSaveCode returns string
    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        return GetLocalizedString("INVALID_RED")
    endif
    return GetLocalizedString("VALID_GREEN")
endfunction

function ConvertSaveCodeDemigodValueToInfo takes integer value returns string
    if (value == 1) then
        return "Light Demigod"
    elseif (value == 2) then
        return "Dark Demigod"
    elseif (value == 3) then
        return "Any Demigod"
    endif

    return "No Demigod"
endfunction

function CreateSaveCodeTextFileHeroes takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, integer heroLevel, integer xp, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer gold, integer lumber, integer evolutionLevel, integer demigodValue, integer equipmentBags, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -load " + saveCode)
    set content = content + AppendFileContent("Player: " + playerName)
    set content = content + AppendFileContent("Singleplayer: " + singleplayer)
    set content = content + AppendFileContent("Game Mode: " + gameMode)
    set content = content + AppendFileContent("XP rate: " + I2S(xpRate))
    set content = content + AppendFileContent("Hero Level 1: " + I2S(heroLevel))
    set content = content + AppendFileContent("XP 1: " + I2S(xp))
    set content = content + AppendFileContent("Hero Level 2: " + I2S(heroLevel2))
    set content = content + AppendFileContent("XP 2: " + I2S(xp2))
    set content = content + AppendFileContent("Hero Level 3: " + I2S(heroLevel3))
    set content = content + AppendFileContent("XP 3: " + I2S(xp3))
    
     // The line below creates the log
    call FileWriteLine(content)

    set content = ""
    
    set content = content + AppendFileContent("Demigod: " + ConvertSaveCodeDemigodValueToInfo(demigodValue))
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("Evolution: " + I2S(evolutionLevel))
    set content = content + AppendFileContent("Equipment Bags: " + I2S(equipmentBags))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-level1-" + I2S(heroLevel) + "-level2-" + I2S(heroLevel2) + "-level3-" + I2S(heroLevel3) + "-gold-" + I2S(gold) + "-lumber-" + I2S(lumber) + ".txt")
endfunction

// use one single symbol to store these two flags
function GetSinglePlayerAndGameMode takes boolean isSinglePlayer, boolean isWarlord returns integer
    if (isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 0")
        return 0
    elseif (isSinglePlayer and not isWarlord) then
        //call BJDebugMsg("Save code single player and mode 1")
        return 1
    elseif (not isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 2")
        return 2
    else
        //call BJDebugMsg("Save code single player and mode 3")
        return 3
    endif

    return 0
endfunction

function GetSinglePlayerFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return true
    elseif (saveCodeSegment == 2) then
        return false
    else
        return false
    endif

    return false
endfunction

function GetWarlordFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return false
    elseif (saveCodeSegment == 2) then
        return true
    else
        return false
    endif

    return false
endfunction

function GetSaveCodeEx takes player whichPlayer, string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, integer heroLevel, integer xp, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer gold, integer lumber, integer evolutionLevel, integer demigodValue, integer equipmentBags returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    
    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_HEROES)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp2)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp3)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(evolutionLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(demigodValue)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(equipmentBags)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    // never store savecode files of other players on the disk
    if (GetLocalPlayer() == whichPlayer) then
        call CreateSaveCodeTextFileHeroes(playerName, isSinglePlayer, isWarlord, xpRate, heroLevel, xp, heroLevel2, xp2, heroLevel3, xp3, gold, lumber, evolutionLevel, demigodValue, equipmentBags, result)
    endif

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeDemigodValue takes player whichPlayer returns integer
    local integer unitTypeId = GetUnitTypeId(udg_Held[GetConvertedPlayerId(whichPlayer)])
    if (unitTypeId == DEMIGOD_LIGHT) then
        return 1
    elseif (unitTypeId == DEMIGOD_DARK) then
        return 2
    elseif (GetPlayerTechCountSimple(UPG_DEMIGOD, whichPlayer) > 0) then
        return 3
    endif

    return 0
endfunction

/**
 * Simple Save/Load system which converts decimal numbers into numbers from SAVE_CODE_DIGITS.
 * It starts with the player name's hash, so you can only use your own savecodes in multiplayer games etc.
 * Besides, the settings are stored. All numbers are separated by a separator character.
 * It adds a final checksum of the savecode to make it harder to fake any savecode by just replacing certain values of it.
 * If it ends with separators it will be compressed by removing separator characters from the end.
 * TODO Store stats for the multiboard to show what a player has achieved. This could also be useful for online leaderboards.
 */
function GetSaveCode takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    local boolean isWarlord = udg_PlayerIsWarlord[convertedPlayerId]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))
    local integer heroLevel = GetHeroLevel1(whichPlayer)
    local integer xp = GetHeroXP1(whichPlayer)
    local integer heroLevel2 = GetHeroLevel2(whichPlayer)
    local integer xp2 = GetHeroXP2(whichPlayer)
    local integer heroLevel3 = GetHeroLevel3(whichPlayer)
    local integer xp3 = GetHeroXP3(whichPlayer)
    local integer gold = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
    local integer lumber = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
    local integer evolutionLevel = GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
    local integer equipmentBags = BlzGroupGetSize(udg_EquipmentBags[convertedPlayerId])

    return GetSaveCodeEx(whichPlayer, GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, heroLevel, xp, heroLevel2, xp2, heroLevel3, xp3, gold, lumber, evolutionLevel, GetSaveCodeDemigodValue(whichPlayer), equipmentBags)
endfunction

function ReadSaveCodeEx takes string saveCode, integer hash, string alphabet returns string
    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Deobfuscating with the hash!")
        return ConvertSaveCodeFromObfuscatedVersionEx(saveCode, hash, alphabet)
    endif

    //call BJDebugMsg("Just returning!")

    return saveCode
endfunction

function ReadSaveCode takes string saveCode, integer hash returns string
    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Deobfuscating with the hash!")
        return ConvertSaveCodeFromObfuscatedVersion(saveCode, hash)
    endif

    //call BJDebugMsg("Just returning!")

    return saveCode
endfunction

function SetPlayerStateIfHigher takes player whichPlayer, playerstate playerState, integer value returns boolean
    if (value > GetPlayerState(whichPlayer, playerState)) then
        call SetPlayerStateBJ(whichPlayer, playerState, value)
        return true
    endif

    return false
endfunction

function SetPlayerTechResearchedIfHigher takes player whichPlayer, integer techId, integer level returns boolean
    if (level > GetPlayerTechCountSimple(techId, whichPlayer)) then
        call SetPlayerTechResearched(whichPlayer, techId, level)
        return true
    endif

    return false
endfunction

function DisplaySaveCodeError takes player whichPlayer, string message returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, message)
endfunction

function DisplaySaveCodeErrorAtLeastOne takes player whichPlayer, boolean atLeastOne returns nothing
    if (not atLeastOne) then
        call DisplaySaveCodeError(whichPlayer, GetLocalizedString("EMPTY_SAVECODE"))
    endif
endfunction

function DisplaySaveCodeErrorLowerResearch takes player whichPlayer, integer techId returns nothing
    call DisplaySaveCodeError(whichPlayer, Format(GetLocalizedString("LOWER_RESEARCH")).s(GetObjectName(techId)).result())
endfunction

function DisplaySaveCodeErrorSameGame takes player whichPlayer returns nothing
    call DisplaySaveCodeError(whichPlayer, GetLocalizedString("SAVE_CODE_SAME_GAME"))
endfunction

function ApplySaveCode takes player whichPlayer, string s returns boolean
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_2)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_GOLD)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_LUMBER)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EVOLUTION)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_DEMIGOD)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EQUIPMENT_BAGS)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local real demigodX = GetMapNeutralZoneX(whichPlayer)
    local real demigodY = GetMapNeutralZoneY(whichPlayer)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[convertedPlayerId] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp >= GetHeroXP(udg_Held[convertedPlayerId])) then
            if (demigodValue == 1) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
                if (udg_Held[convertedPlayerId] != null) then
                    set udg_TmpUnit = udg_Held[convertedPlayerId]
                    call BecomeDemigodLight(udg_TmpUnit)
                endif
            elseif (demigodValue == 2) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
                if (udg_Held[convertedPlayerId] != null) then
                    set udg_TmpUnit = udg_Held[convertedPlayerId]
                    call BecomeDemigodDark(udg_TmpUnit)
                endif
            elseif (demigodValue == 3) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
            endif

            call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
            call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_EVOLUTION, evolutionLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_CHEAP_EVOLUTION, evolutionLevel)
            set udg_TmpPlayer = whichPlayer
            call TriggerExecute(gg_trg_Power_Generator_Update_Heal_Icons)

            if (udg_Held[convertedPlayerId] != null and xp > GetHeroXP(udg_Held[convertedPlayerId])) then
                call SetHeroXP(udg_Held[convertedPlayerId], xp, true)
            endif

            if (udg_Held[convertedPlayerId] == null and xp > udg_CharacterStartXP[convertedPlayerId]) then
                set udg_CharacterStartXP[convertedPlayerId] = xp
                call UpdateHeroJourneyLevelEx(whichPlayer, GetHeroLevelByXP(xp))
            endif

            if (udg_Held2[convertedPlayerId] != null and xp2 > GetHeroXP(udg_Held2[convertedPlayerId])) then
                call SetHeroXP(udg_Held2[convertedPlayerId], xp2, true)
            endif

            if (udg_Held2[convertedPlayerId] == null and xp2 > udg_Held2XP[convertedPlayerId]) then
                set udg_Held2XP[convertedPlayerId] = xp2
            endif

            if (udg_Held3[convertedPlayerId] != null and xp3 > GetHeroXP(udg_Held3[convertedPlayerId])) then
                call SetHeroXP(udg_Held3[convertedPlayerId], xp3, true)
            endif

            if (udg_Held3[convertedPlayerId] == null and xp3 > udg_Held3XP[convertedPlayerId]) then
                set udg_Held3XP[convertedPlayerId] = xp3
            endif

            call RecreateEquipmentBags(whichPlayer, equipmentBags)
            
            call AddGeneratedSaveCode(s)

            return true
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeErrors takes player whichPlayer, string s returns string
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (IsGeneratedSaveCode(s)) then
        set result = result + "Is from the same game!"
    endif

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif
        
        set result = result + "Expected different checksum!"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected different player name!"
    endif

    if (isSinglePlayer != IsInSinglePlayer()) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isSinglePlayer) then
            set result = result + "Expected singleplayer!"
        else
            set result = result + "Expected multiplayer!"
        endif
    endif

    if (isWarlord != udg_PlayerIsWarlord[convertedPlayerId]) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isWarlord) then
            set result = result + "Expected game mode Warlord!"
        else
            set result = result + "Expected game mode Freelancer!"
        endif
    endif

    if (xpRate != R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected XP rate: " + I2S(xpRate)
    endif

    if (xp < GetHeroXP(udg_Held[convertedPlayerId])) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected more XP than your current!"
    endif

    if (checksum == CompressedAbsStringHash(saveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[convertedPlayerId] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp >= GetHeroXP(udg_Held[convertedPlayerId])) then
        set result = "None errors detected. Stored " + I2S(xp) + "XP."
    endif

    return result
endfunction

function AppendSaveCodeInfo takes string result, string appended returns string
    if (StringLength(result) > 0) then
        set result = result + "|n"
    endif

    return result + appended
endfunction

function GetSaveCodeInfos takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_2)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_GOLD)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_LUMBER)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EVOLUTION)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_DEMIGOD)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EQUIPMENT_BAGS)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "XP 1: " + I2S(xp))
    set result = AppendSaveCodeInfo(result, "XP 2: " + I2S(xp2))
    set result = AppendSaveCodeInfo(result, "XP 3: " + I2S(xp3))
    set result = AppendSaveCodeInfo(result, "Demigod: " + demigodValueInfo)
    set result = AppendSaveCodeInfo(result, "Gold: " + I2S(gold))
    set result = AppendSaveCodeInfo(result, "Lumber: " + I2S(lumber))
    set result = AppendSaveCodeInfo(result, "Evolution: " + I2S(evolutionLevel))
    set result = AppendSaveCodeInfo(result, "Equipment Bags: " + I2S(equipmentBags))

    return result
endfunction

function GetSaveCodeShortInfos takes string playerName, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_2)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_GOLD)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_LUMBER)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EVOLUTION)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_DEMIGOD)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_EQUIPMENT_BAGS)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)

    set playerName = GetPlayerNameByHash(playerName, playerNameHash)

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    return singlePlayerStatus + "-" + warlordStatus + "-l1_" + I2S(GetHeroLevelByXP(xp)) + "-l2_" + I2S(GetHeroLevelByXP(xp2)) + "-l3_" + I2S(GetHeroLevelByXP(xp3)) + "-g_" + I2S(gold) + "-l_" + I2S(lumber) + "-e_" + I2S(evolutionLevel)
endfunction

function GetSaveCodeXp1 takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP)
    
    return xp
endfunction

function GetSaveCodeXp2 takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_2)
    
    return xp2
endfunction

function GetSaveCodeXp3 takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_3)
    
    return xp3
endfunction

function GetSaveCodeGold takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    
    return ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_GOLD)
endfunction

function GetSaveCodeLumber takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    
    return ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_LUMBER)
endfunction

function GetSaveCodeIsMatching takes player whichPlayer, string s returns boolean
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)

    return isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))
endfunction

function GetSaveCodeMaxHeroLevel takes string playerName, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer xp = GetSaveCodeXp1(saveCode, playerName)
    local integer xp2 = GetSaveCodeXp2(saveCode, playerName)
    local integer xp3 = GetSaveCodeXp3(saveCode, playerName)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (xp2 > xp and xp2 > xp3) then
        return GetHeroLevelByXP(xp2)
    elseif (xp3 > xp and xp3 > xp2) then
        return GetHeroLevelByXP(xp3)
    endif

    return GetHeroLevelByXP(xp)
endfunction

function GetSaveCodeBuildingsMax takes nothing returns integer
    return 8
endfunction

function CreateSaveCodeBuildingsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer index, integer buildings, string buildingNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadb " + saveCode)
    set content = content + AppendFileContent("Buildings: " + I2S(buildings))
    set content = content + AppendFileContent("Building Names: " + buildingNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-index-" + I2S(index) + "-buildings-" + I2S(buildings) + "-" + buildingNames + ".txt")
endfunction

globals
    constant integer SAVE_CODE_MAX_BUILDINGS = 8
endglobals

function CountUnitsOfTypeFromGroup takes group whichGroup, integer unitTypeId returns integer
    local integer i = 0
    local integer max = BlzGroupGetSize(whichGroup)
    local integer count = 0
    local unit first = null
    loop
        exitwhen (i >= max)
        set first = BlzGroupUnitAt(whichGroup, i)
        if (GetPrimaryDependencyEquivalent(GetUnitTypeId(first)) == GetPrimaryDependencyEquivalent(unitTypeId)) then
            set count = count + 1
        endif
        set first = null
        set i = i + 1
    endloop
    //call BJDebugMsg("Count unit type " + GetObjectName(unitTypeId) + " with count " + I2S(i))

    return count
endfunction

function DistinctGroup takes group whichGroup returns group
    local integer i = 0
    local integer max = BlzGroupGetSize(whichGroup)
    local group result = CreateGroup()
    local unit first = null
    loop
        exitwhen (i >= max)
        set first = BlzGroupUnitAt(whichGroup, i)
        //call BJDebugMsg("First: " + GetUnitName(first))
        exitwhen (first == null)
        if (CountUnitsOfTypeFromGroup(result, GetPrimaryDependencyEquivalent(GetUnitTypeId(first))) == 0) then
            call GroupAddUnit(result, first)
            //call BJDebugMsg("Add to distinct")
        endif
        set first = null
        set i = i + 1
    endloop
    
    if (bj_wantDestroyGroup) then
        call GroupClear(whichGroup)
        call DestroyGroup(whichGroup)
        set whichGroup = null
        set bj_wantDestroyGroup = false
    endif

    return result
endfunction

globals
    private integer tmpFilterId = 0
endglobals

private function FilterIsUnitType takes nothing returns boolean
    return GetPrimaryDependencyEquivalent(GetUnitTypeId(GetFilterUnit())) == tmpFilterId
endfunction

function CountUnitsOfType takes player whichPlayer, integer id returns integer
    local group g = CreateGroup()
    local integer count = 0
    set tmpFilterId = id
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function FilterIsUnitType))
    set count = BlzGroupGetSize(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return count
endfunction

function FilterIsLivingBuildingToBeSaved takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetSaveObjectBuildingType(GetPrimaryDependencyEquivalent(GetUnitTypeId(GetFilterUnit()))) != -1
endfunction

function GetPlayerBuildingsOrderedByPriority takes player whichPlayer, integer index returns group
    local group whichGroup = CreateGroup()
    local group buildingsToBeSaved = CreateGroup()
    local unit first = null
    local integer i = 0
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    call GroupAddGroup(udg_SaveCodeIncludedUnits[convertedPlayerId], buildingsToBeSaved)
    set bj_wantDestroyGroup = true
    call GroupAddGroup(GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingBuildingToBeSaved)), buildingsToBeSaved)
    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[convertedPlayerId], buildingsToBeSaved)
    loop
        set first = FirstOfGroup(buildingsToBeSaved)
        exitwhen (first == null or i >= (index + 1) * SAVE_CODE_MAX_BUILDINGS)
        if (i >= index * SAVE_CODE_MAX_BUILDINGS and i < (index + 1) * SAVE_CODE_MAX_BUILDINGS and not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(buildingsToBeSaved, first)
        set i = i + 1
    endloop

    call GroupClear(buildingsToBeSaved)
    call DestroyGroup(buildingsToBeSaved)
    set buildingsToBeSaved = null

    return whichGroup
endfunction

function GetAbsCoordinate takes real coordinate, real min returns real
    return RAbsBJ(min) + coordinate
endfunction

function GetAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = GetAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function GetAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = GetAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function ConvertAbsCoordinate takes real coordinate, real min returns real
    return coordinate - RAbsBJ(min)
endfunction

function ConvertAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = ConvertAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function ConvertAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = ConvertAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function GetSaveCodeBuildingsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, player owner, group b returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    local integer max = BlzGroupGetSize(b)
    local unit first = null
    local integer id = -1
    local integer i = 0
    local integer buildingsCounter = 0
    local string buildingNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    //call BJDebugMsg("Size of buildings: " + I2S(CountUnitsInGroup(buildings)))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_BUILDINGS)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(index)

    // 5 buildings with their locations
    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_BUILDINGS or i >= max)
        set first = BlzGroupUnitAt(b, i)
        set id = GetSaveObjectBuildingType(GetPrimaryDependencyEquivalent(GetUnitTypeId(first)))
        if (id != -1) then
            //call BJDebugMsg("Saving building: " + GetObjectName(GetUnitTypeId(first)))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitX(first))))
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitX(first)))
            //call BJDebugMsg("Saving building X (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateX(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateX(GetUnitX(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitY(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitY(first)))
            //call BJDebugMsg("Saving building Y (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateY(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateY(GetUnitY(first))))
            set buildingsCounter = buildingsCounter + 1
            if (buildingNames != "") then
                set buildingNames = buildingNames + ","
            endif
            set buildingNames = buildingNames + GetUnitName(first)
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        set first = null
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_BUILDINGS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    if (buildingsCounter > 0) then
        if (writeFile) then
            call CreateSaveCodeBuildingsTextFile(playerName, isSinglePlayer, isWarlord, index, buildingsCounter, buildingNames, result)
        endif

        call AddGeneratedSaveCode(result)
    endif

    return result
endfunction

function GetSaveCodeBuildingsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, player owner returns string
    local group buildings = GetPlayerBuildingsOrderedByPriority(owner, index)
    local string result = GetSaveCodeBuildingsEx2(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, owner, buildings)

    call GroupClear(buildings)
    call DestroyGroup(buildings)
    set buildings = null

    return result
endfunction

function GetSaveCodeBuildingsForIndex takes player whichPlayer, boolean writeFile, integer index returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeBuildingsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, writeFile, index, whichPlayer)
endfunction

function GetSaveCodeBuildings takes player whichPlayer returns string
    return GetSaveCodeBuildingsForIndex(whichPlayer, true, 0)
endfunction

function GetAllSaveCodeBuildings takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = GetSaveCodeBuildingsMax()
    loop
        exitwhen (i == max)
        call GetSaveCodeBuildingsForIndex(whichPlayer, true, i)
        set i = i + 1
    endloop
endfunction

function IsObjectFromPlayerRace takes integer objectID, player whichPlayer returns boolean
    return PlayerHasUnlockedRace(whichPlayer, GetObjectRace(objectID))
endfunction

function IsObjectFromPlayerProfession takes integer objectID, player whichPlayer returns boolean
    return PlayerHasProfession(whichPlayer, GetObjectProfession(objectID))
endfunction

function DisplayObjectRaceLoadSuccess takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, Format(GetLocalizedString("SUCCESSFULLY_LOADED_X")).s(GetObjectName(objectID)).result())
endfunction

function DisplayObjectRaceLoadError takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, Format(GetLocalizedString("UNABLE_TO_LOAD_X")).s(GetObjectName(objectID)).result())
endfunction

function DisplayObjectLimitLoadError takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, Format(GetLocalizedString("UNABLE_TO_LOAD_X_LIMIT_Y")).s(GetObjectName(objectID)).i(CountLivingPlayerUnitsOfTypeIdFast(objectID , whichPlayer)).i(GetPlayerTechMaxAllowed(whichPlayer, objectID)).result())
endfunction

function DisplayObjectTomeLoadError takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, Format(GetLocalizedString("UNABLE_TO_LOAD_X_TOMES")).s(GetObjectName(objectID)).result())
endfunction

function ApplySaveCodeBuildings takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer id = 0
    local real x = 0.0
    local real y = 0.0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectBuildingId(saveObject)
                    set id = saveObjectId
                    if (not IsObjectFromPlayerRace(id, whichPlayer)) then
                        set id = MapBuildingID(id, GetPlayerRace1(whichPlayer))
                    endif
                    
                    if (id != 0 and IsObjectFromPlayerRace(id, whichPlayer) and IsObjectFromPlayerProfession(id, whichPlayer)) then
                        if (GetPlayerTechMaxAllowed(whichPlayer, id) == 0 or CountLivingPlayerUnitsOfTypeIdFast(id , whichPlayer) < GetPlayerTechMaxAllowed(whichPlayer, id)) then
                            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
                            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
                            //call BJDebugMsg("Loading building " + GetObjectName(saveObjectId) + " at " + R2S(x) + "|" + R2S(y))
                            call CreateUnit(whichPlayer, id, x, y, bj_UNIT_FACING)
                            set atLeastOne = true
                            call PingMinimapForPlayer(whichPlayer, x, y, 4.0)
                            call DisplayObjectRaceLoadSuccess(id, whichPlayer)
                        else
                            call DisplayObjectLimitLoadError(saveObjectId, whichPlayer)
                        endif
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 3
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)
            
            if (atLeastOne) then
                call AddGeneratedSaveCode(s)
            endif

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosBuildings takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "Index: " + I2S(index))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectBuildingId(saveObject)
            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, Format(GetLocalizedString("SAVE_CODE_SLOT_BUILDING")).i(i + 1).s(GetObjectName(saveObjectId)).r(x).r(y).result())
            else
                set result = AppendSaveCodeInfo(result, Format(GetLocalizedString("SAVE_CODE_SLOT_BUILDING_RED")).i(i + 1).s(GetObjectName(saveObjectId)).r(x).r(y).result())
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, Format(GetLocalizedString("SAVE_CODE_SLOT_BUILDING_EMPTY")).i(i + 1).result())
        else
            set result = AppendSaveCodeInfo(result, Format(GetLocalizedString("SAVE_CODE_SLOT_BUILDING_INVALID")).i(i + 1).i(saveObject).result())
        endif
        set i = i + 1
        set pos = pos + 3
    endloop

    return result
endfunction

function GetSaveCodeShortInfosBuildings takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local string result = ""
    
    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectBuildingId(saveObject)
            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = result + "|cff00ff00" + GetObjectName(saveObjectId) + "|r"
            else
                set result = result + "|cffff0000" + GetObjectName(saveObjectId) + "|r"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Building Slot"
        else
            set result = result + "Invalid Building with ID "
        endif
        set i = i + 1
        set pos = pos + 3
    endloop

    return singlePlayerStatus + "-" + warlordStatus + "-" + I2S(index) + result
endfunction

function CreateSaveCodeItemsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer index, integer items, string itemNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadi " + saveCode)
    set content = content + AppendFileContent("Items: " + I2S(items))
    set content = content + AppendFileContent("Item Names: " + itemNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-index-" + I2S(index) + "-items-" + I2S(items)  + "-" + itemNames + ".txt")
endfunction

// TODO Add some kind of unique ID for grouping multiple item savecodes together to prevent faking the same items in different slots.
function GetSaveCodeItemsEx3 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, integer itemTypeSlot0, integer itemChargesSlot0, integer itemTypeSlot1, integer itemChargesSlot1, integer itemTypeSlot2, integer itemChargesSlot2, integer itemTypeSlot3, integer itemChargesSlot3, integer itemTypeSlot4, integer itemChargesSlot4, integer itemTypeSlot5, integer itemChargesSlot5 returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    local integer id = -1
    local integer itemCounter = 0
    local string itemNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))
    
    if (itemTypeSlot0 != 0 or itemTypeSlot1 != 0 or itemTypeSlot2 != 0 or itemTypeSlot3 != 0 or itemTypeSlot4 != 0 or itemTypeSlot5 != 0) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_ITEMS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
        set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(index)

        if (itemTypeSlot0 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot0)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot0)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot0)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        if (itemTypeSlot1 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot1)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot1)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot1)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        if (itemTypeSlot2 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot2)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot2)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot2)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        if (itemTypeSlot3 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot3)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot3)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot3)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        if (itemTypeSlot4 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot4)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot4)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot4)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        if (itemTypeSlot5 != 0) then
            set id = GetSaveObjectItemType(itemTypeSlot5)
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(itemChargesSlot5)
                set itemCounter = itemCounter + 1
                if (itemNames != "") then
                    set itemNames = itemNames + ","
                endif
                set itemNames = itemNames + GetObjectName(itemTypeSlot5)
            else
                //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
            endif
        endif

        //call BJDebugMsg("Compressed result: " + result) 
        //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
        //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
        //call BJDebugMsg("Checked save code part: " + result)

        // checksum
        set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

        if (SAVE_CODE_OBFUSCATE) then
            //call BJDebugMsg("Non-obfuscated save code: " + result)
            set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
        endif

        if (itemCounter > 0) then
            call AddGeneratedSaveCode(result)
            
            if (writeFile) then
                call CreateSaveCodeItemsTextFile(playerName, isSinglePlayer, isWarlord, index, itemCounter, itemNames, result)
            endif
            
            return result
        endif
    endif
    
    return ""
endfunction

function GetSaveCodeItemsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, item itemSlot0, item itemSlot1, item itemSlot2, item itemSlot3, item itemSlot4, item itemSlot5 returns string
    return GetSaveCodeItemsEx3(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, GetItemTypeId(itemSlot0), GetItemCharges(itemSlot0), GetItemTypeId(itemSlot1), GetItemCharges(itemSlot1), GetItemTypeId(itemSlot2), GetItemCharges(itemSlot2), GetItemTypeId(itemSlot3), GetItemCharges(itemSlot3), GetItemTypeId(itemSlot4), GetItemCharges(itemSlot4), GetItemTypeId(itemSlot5), GetItemCharges(itemSlot5))
endfunction

function GetSaveCodeItemsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, unit hero, boolean writeFile, integer index returns string
    return GetSaveCodeItemsEx2(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, UnitItemInSlot(hero, 0), UnitItemInSlot(hero, 1), UnitItemInSlot(hero, 2), UnitItemInSlot(hero, 3), UnitItemInSlot(hero, 4), UnitItemInSlot(hero, 5))
endfunction

function GetSaveCodeItemsForIndex takes player whichPlayer, boolean writeFile, integer index returns string
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))
    local integer playerId = GetPlayerId(whichPlayer)
    local string playerName = GetPlayerName(whichPlayer)
    local integer i = index

    if (index == 0) then
        return GetSaveCodeItemsEx(playerName, isSinglePlayer, isWarlord, xpRate, GetPlayerHero1(whichPlayer), writeFile, index)
    elseif (index == 1) then
        return GetSaveCodeItemsEx(playerName, isSinglePlayer, isWarlord, xpRate, GetPlayerHero2(whichPlayer), writeFile, index)
    elseif (index == 3) then
        return GetSaveCodeItemsEx(playerName, isSinglePlayer, isWarlord, xpRate, GetPlayerHero3(whichPlayer), writeFile, index)
    elseif (index > 3 and index < 3 + BACKPACK_MAX_PAGES) then
        set i = index - 3
        //call BJDebugMsg("Backpack item " + I2S(i))
        return GetSaveCodeItemsEx3(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 0)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 0)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 1)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 1)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 2)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 2)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 3)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 3)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 4)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 4)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 5)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 5)))
    elseif (index >= 3 + BACKPACK_MAX_PAGES and index < BlzGroupGetSize(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])) then
        set i = index - 3 + BACKPACK_MAX_PAGES
        return GetSaveCodeItemsEx(playerName, isSinglePlayer, isWarlord, xpRate, BlzGroupUnitAt(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], i), writeFile, index)
    endif
    return ""
endfunction

function GetSaveCodeItems takes player whichPlayer returns string
    return GetSaveCodeItemsForIndex(whichPlayer, true, 0)
endfunction

function GetAllSaveCodeItems takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))
    local integer i = 0
    local integer index = 0
    local integer playerId = GetPlayerId(whichPlayer)
    local integer max = BlzGroupGetSize(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    local string result = GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, GetPlayerHero1(whichPlayer), true, 0)
    call GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, GetPlayerHero2(whichPlayer), true, 1)
    call GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, GetPlayerHero3(whichPlayer), true, 2)
    
    set index = 3
    set i = 0
    set max = BACKPACK_MAX_PAGES
    loop
        exitwhen (i == max)
        call GetSaveCodeItemsEx3(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, true, index, GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 0)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 0)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 1)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 1)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 2)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 2)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 3)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 3)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 4)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 4)), GetBackpackItemTypeId(GetBackpackItemIndex(playerId, i, 5)), GetBackpackItemCharges(GetBackpackItemIndex(playerId, i, 5)))
        set index = index + 1
        set i = i + 1
    endloop
    
    set i = 0
    set max = BlzGroupGetSize(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    loop
        exitwhen (i == max)
        call GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, BlzGroupUnitAt(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], i), true, index)
        set index = index + 1
        set i = i + 1
    endloop
    
    return result
endfunction

function GetSaveCodeItemsMax takes nothing returns integer
    return 3 + BACKPACK_MAX_PAGES + 3
endfunction

function GetSaveCodeItemsFromUnit takes player whichPlayer, unit hero, integer index returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, hero, true, index)
endfunction

function ApplySaveCodeItemsEx takes player whichPlayer, string s, unit hero returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE )
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH )
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer id = 0
    local integer charges = 0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == bj_MAX_INVENTORY or pos >= lastSaveCodeSegment)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectItemId(saveObject)
                    set id = saveObjectId
                    if (not IsObjectFromPlayerRace(id, whichPlayer)) then
                        set id = MapItemID(id, GetPlayerRace1(whichPlayer))
                    endif
                    
                    if (id != 0 and IsObjectFromPlayerRace(id, whichPlayer) and IsObjectFromPlayerProfession(id, whichPlayer)) then
                        if (not IsTome(id) or udg_Tomes) then
                            call UnitAddItemByIdSwapped(id, hero)
                            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                            if (GetItemTypePerishable(id) and charges <= 0) then
                                // never let perishable items be used unlimited
                                set charges = 1
                            endif
                            call SetItemCharges(bj_lastCreatedItem, charges)
                            set atLeastOne = true
                        else
                            call DisplayObjectTomeLoadError(saveObjectId, whichPlayer)
                        endif
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)
            
            if (atLeastOne) then
                call AddGeneratedSaveCode(s)
            endif

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function ApplySaveCodeItems takes player whichPlayer, string s returns boolean
    local unit hero = udg_Hero[GetPlayerId(whichPlayer)]
    return ApplySaveCodeItemsEx(whichPlayer, s, hero)
endfunction

function GetSaveCodeInfosItems takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer charges = 0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "Index: " + I2S(index))

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY or pos >= lastSaveCodeSegment)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectItemId(saveObject)
            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer) and (not IsTome(saveObjectId) or udg_Tomes)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cff00ff00" + GetObjectName(saveObjectId) + "|r")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cffff0000" + GetObjectName(saveObjectId) + "|r")
            endif

            if (charges > 0) then
                set result = result + " (" + I2S(charges) + ")"
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Item Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosItems takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer charges = 0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY or pos >= lastSaveCodeSegment)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectItemId(saveObject)
            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer) and (not IsTome(saveObjectId) or udg_Tomes)) then
                set result = result + "|cff00ff00" + GetObjectName(saveObjectId) + "|r"
            else
                set result = result + "|cffff0000" + GetObjectName(saveObjectId) + "|r"
            endif
            if (charges > 0) then
                set result = result + " (" + I2S(charges) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Item Slot"
        else
            set result = result + "Invalid Item with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + warlordStatus + "-" + I2S(index) + result
endfunction

globals
    constant integer SAVE_CODE_MAX_UNITS = 10
endglobals

function FilterIsLivingUnitToBeSaved takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetUnitTypeId(GetFilterUnit()) != 'o018' and GetUnitTypeId(GetFilterUnit()) != 'o00P' and GetSaveObjectUnitType(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

function GetPlayerUnitsOrderedByPriority takes player whichPlayer, integer index returns group
    local integer i = 0
    local group whichGroup = CreateGroup()
    local group livingUnitsToBeSaved = CreateGroup()
    local unit first = null
    call GroupAddGroup(udg_SaveCodeIncludedUnits[GetConvertedPlayerId(whichPlayer)], livingUnitsToBeSaved)
    set bj_wantDestroyGroup = true
    call GroupAddGroup(GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingUnitToBeSaved)), livingUnitsToBeSaved)
    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[GetConvertedPlayerId(whichPlayer)], livingUnitsToBeSaved)
    //call BJDebugMsg("Size of units: " + I2S(BlzGroupGetSize(livingUnitsToBeSaved)))
    set bj_wantDestroyGroup = true
    set livingUnitsToBeSaved = DistinctGroup(livingUnitsToBeSaved)
    //call BJDebugMsg("Size of units: " + I2S(BlzGroupGetSize(livingUnitsToBeSaved)))
    loop
        set first = FirstOfGroup(livingUnitsToBeSaved)
        exitwhen (first == null or i >= (index + 1) * SAVE_CODE_MAX_UNITS)
        if (i >= index * SAVE_CODE_MAX_UNITS and i < (index + 1) * SAVE_CODE_MAX_UNITS and not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(livingUnitsToBeSaved, first)
        set i = i + 1
    endloop

    //call BJDebugMsg("Size of units before distinct: " + I2S(CountUnitsInGroup(whichGroup)))
    //call BJDebugMsg("Size of units after distinct: " + I2S(CountUnitsInGroup(result)))

    call GroupClear(livingUnitsToBeSaved)
    call DestroyGroup(livingUnitsToBeSaved)
    set livingUnitsToBeSaved = null
    
    //call BJDebugMsg("Size of units: " + I2S(BlzGroupGetSize(whichGroup)))

    return whichGroup
endfunction

function GetSaveCodeUnitsMax takes nothing returns integer
    return 8
endfunction

function CreateSaveCodeUnitsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer index, integer units, string unitNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadu " + saveCode)
    set content = content + AppendFileContent("Units: " + I2S(units))
    set content = content + AppendFileContent("Unit Names: " + unitNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-index-" + I2S(index) + "-units-" + I2S(units)  + "-" + unitNames + ".txt")
endfunction

function GetSaveCodeUnitsEx3 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, integer unitTypeId0, integer unitTypeIdCount0, integer unitTypeId1, integer unitTypeIdCount1, integer unitTypeId2, integer unitTypeIdCount2, integer unitTypeId3, integer unitTypeIdCount3, integer unitTypeId4, integer unitTypeIdCount4, integer unitTypeId5, integer unitTypeIdCount5, integer unitTypeId6, integer unitTypeIdCount6, integer unitTypeId7, integer unitTypeIdCount7 returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    local integer id = -1
    local integer i = 0
    local integer unitsCounter = 0
    local string unitNames = ""
    local integer array unitTypeIds
    local integer array unitTypeIdsCounts
    local integer max = 0
    if (unitTypeId0 != 0) then
        set unitTypeIds[max] = unitTypeId0
        set unitTypeIdsCounts[max] = unitTypeIdCount0
        set max = max + 1
    endif
    if (unitTypeId1 != 0) then
        set unitTypeIds[max] = unitTypeId1
        set unitTypeIdsCounts[max] = unitTypeIdCount1
        set max = max + 1
    endif
    if (unitTypeId2 != 0) then
        set unitTypeIds[max] = unitTypeId2
        set unitTypeIdsCounts[max] = unitTypeIdCount2
        set max = max + 1
    endif
    if (unitTypeId3 != 0) then
        set unitTypeIds[max] = unitTypeId3
        set unitTypeIdsCounts[max] = unitTypeIdCount3
        set max = max + 1
    endif
    if (unitTypeId4 != 0) then
        set unitTypeIds[max] = unitTypeId4
        set unitTypeIdsCounts[max] = unitTypeIdCount4
        set max = max + 1
    endif
    if (unitTypeId5 != 0) then
        set unitTypeIds[max] = unitTypeId5
        set unitTypeIdsCounts[max] = unitTypeIdCount5
        set max = max + 1
    endif
    if (unitTypeId6 != 0) then
        set unitTypeIds[max] = unitTypeId6
        set unitTypeIdsCounts[max] = unitTypeIdCount6
        set max = max + 1
    endif
    if (unitTypeId7 != 0) then
        set unitTypeIds[max] = unitTypeId7
        set unitTypeIdsCounts[max] = unitTypeIdCount7
        set max = max + 1
    endif

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_UNITS)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(index)

    set i = 0
    loop
        exitwhen (unitsCounter >= SAVE_CODE_MAX_UNITS or i >= max)
        if (unitTypeIds[i] != 0) then
            set id = GetSaveObjectUnitType(unitTypeIds[i])
            if (id != -1) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(unitTypeIdsCounts[i])
                if (unitNames != "") then
                    set unitNames = unitNames + ","
                endif
                set unitNames = unitNames + I2S(unitsCounter) + GetObjectName(unitTypeIds[i])
                set unitsCounter = unitsCounter + 1
                //call BJDebugMsg("Added " + GetUnitName(first) + " with count " + I2S(count))
            else
                //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
            endif
        endif
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_UNITS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop
    
    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    if (unitsCounter > 0) then
        if (writeFile) then
            call CreateSaveCodeUnitsTextFile(playerName, isSinglePlayer, isWarlord, index, unitsCounter, unitNames, result)
        endif

        call AddGeneratedSaveCode(result)
    endif

    return result
endfunction

function GetSaveCodeUnitsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, player owner, group source returns string
    local integer max = BlzGroupGetSize(source)
    local unit first = null
    local integer unitTypeId = 0
    local integer array unitTypeIds
    local integer array unitTypeIdCounts
    local integer unitsCounter = 0
    local integer id = 0
    local integer i = 0
    loop
        exitwhen (unitsCounter >= SAVE_CODE_MAX_UNITS or i >= max)
        set first = BlzGroupUnitAt(source, i)
        set unitTypeId = GetPrimaryDependencyEquivalent(GetUnitTypeId(first))
        set id = GetSaveObjectUnitType(unitTypeId)
        if (id != -1) then
            set unitTypeIds[unitsCounter] = unitTypeId
            set unitTypeIdCounts[unitsCounter] = CountUnitsOfType(owner, unitTypeIds[unitsCounter])
            set unitsCounter = unitsCounter + 1
            //call BJDebugMsg("Added " + GetUnitName(first) + " with count " + I2S(count))
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        set first = null
        set i = i + 1
    endloop
    
    return GetSaveCodeUnitsEx3(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, unitTypeIds[0], unitTypeIdCounts[0], unitTypeIds[1], unitTypeIdCounts[1], unitTypeIds[2], unitTypeIdCounts[2], unitTypeIds[3], unitTypeIdCounts[3], unitTypeIds[4], unitTypeIdCounts[4], unitTypeIds[5], unitTypeIdCounts[5], unitTypeIds[6], unitTypeIdCounts[6], unitTypeIds[7], unitTypeIdCounts[7])
endfunction

function GetSaveCodeUnitsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, player owner returns string
    local group units = GetPlayerUnitsOrderedByPriority(owner, index)
    local string result = GetSaveCodeUnitsEx2(playerName, isSinglePlayer, isWarlord, xpRate, writeFile, index, owner, units)

    call GroupClear(units)
    call DestroyGroup(units)
    set units = null

    return result
endfunction

function GetSaveCodeUnitsForIndex takes player whichPlayer, boolean writeFile, integer index returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeUnitsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, writeFile, index, whichPlayer)
endfunction

function GetSaveCodeUnits takes player whichPlayer returns string
    return GetSaveCodeUnitsForIndex(whichPlayer, true, 0)
endfunction

function GetAllSaveCodeUnits takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = GetSaveCodeUnitsMax()
    loop
        exitwhen (i == max)
        call GetSaveCodeUnitsForIndex(whichPlayer, true, i)
        set i = i + 1
    endloop
endfunction

function ForGroupApplyLoadedUnitEvolution takes nothing returns nothing
    call AddEvolution(GetEnumUnit())
endfunction

function ApplySaveCodeUnits takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer j = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer id = 0
    local integer count = 0
    local location tmpLocation = GetUnitLoc(GetPlayerHero1(whichPlayer))
    local boolean atLeastOne = false
    local group createdUnits = CreateGroup()

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == SAVE_CODE_MAX_UNITS)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                //call BJDebugMsg("Loading save object: " + I2S(saveObject))
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectUnitId(saveObject)
                    set id = saveObjectId
                    if (not IsObjectFromPlayerRace(id, whichPlayer)) then
                        set id = MapUnitID(id, GetPlayerRace1(whichPlayer), true)
                    endif
                    
                    if (id != 0) then
                        set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                        //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                        set j = 0
                        loop
                            exitwhen (j == count)
                            // the player does not have to build all farms before but the limit should not be exceeded
                            if (GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED) + GetFoodUsed(id) <= GetPlayerState(whichPlayer, PLAYER_STATE_FOOD_CAP_CEILING)) then
                                if (IsObjectFromPlayerRace(id, whichPlayer) and IsObjectFromPlayerProfession(id, whichPlayer)) then
                                    if (GetPlayerTechMaxAllowed(whichPlayer, id) == 0 or CountLivingPlayerUnitsOfTypeIdFast(id , whichPlayer) < GetPlayerTechMaxAllowed(whichPlayer, id)) then
                                        call MoveLocation(tmpLocation, GetMapWaterNeutralZoneX(whichPlayer), GetMapWaterNeutralZoneY(whichPlayer))
                                        call CreateUnitAtLocSaveLast(whichPlayer, id, tmpLocation, GetMapWaterNeutralZoneFacing(whichPlayer))
                                        
                                        call ApplyAllMaxHpResearches(bj_lastCreatedUnit, null)
                                        
                                        if (not IsWaterUnit(bj_lastCreatedUnit)) then
                                            call MoveLocationToUnit(tmpLocation, GetPlayerHero1(whichPlayer))
                                            call SetUnitPositionLocFacingBJ(bj_lastCreatedUnit, tmpLocation, GetUnitFacing(GetPlayerHero1(whichPlayer)))
                                        endif
                                        
                                        if (IsUnitType(bj_lastCreatedUnit, UNIT_TYPE_PEON)) then
                                            call AddWoWReforgedWorker(null, bj_lastCreatedUnit)
                                        endif
                                        
                                        call GroupAddUnit(createdUnits, bj_lastCreatedUnit)
                                        set atLeastOne = true
                                    else
                                        call DisplayObjectLimitLoadError(saveObjectId, whichPlayer)
                                    endif
                                else
                                    call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                                endif
                            else
                                call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, Format(GetLocalizedString("X_EXCEEDS_FOOD_AND_NOT_LOADED")).s(GetObjectName(saveObjectId)).result())
                            endif
                            set j = j + 1
                        endloop
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call ForGroupBJ(createdUnits, function ForGroupApplyLoadedUnitEvolution)
            call GroupClear(createdUnits)
            call DestroyGroup(createdUnits)
            set createdUnits = null

            call RemoveLocation(tmpLocation)
            set tmpLocation = null

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)
            
            if (atLeastOne) then
                call AddGeneratedSaveCode(s)
            endif

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    call ForGroupBJ(createdUnits, function ForGroupApplyLoadedUnitEvolution)
    call GroupClear(createdUnits)
    call DestroyGroup(createdUnits)
    set createdUnits = null

    return false
endfunction

function GetSaveCodeInfosUnits takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "Index: " + I2S(index))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_UNITS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        //call BJDebugMsg("Loading save object: " + I2S(saveObject))
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectUnitId(saveObject)
            set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cff00ff00" + GetObjectName(saveObjectId) + "|r (" + I2S(count) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cffff0000" + GetObjectName(saveObjectId) + "|r (" + I2S(count) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Unit Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosUnits takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local string result = ""
    
    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_UNITS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        //call BJDebugMsg("Loading save object: " + I2S(saveObject))
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectUnitId(saveObject)
            set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = result + "|cff00ff00" + GetObjectName(saveObjectId) + "|r (" + I2S(count) + ")"
            else
                set result = result + "|cffff0000" + GetObjectName(saveObjectId) + "|r (" + I2S(count) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Unit Slot"
        else
            set result = result + "Invalid Item with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + warlordStatus + "-" + I2S(index) + result
endfunction

globals
    constant integer SAVE_CODE_MAX_RESEARCHES = 10
endglobals

function GetSaveCodeResearchesMax takes nothing returns integer
    return 8
endfunction

function CreateSaveCodeResearchesTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer index, integer researches, string researchNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadr " + saveCode)
    set content = content + AppendFileContent("Researches: " + I2S(researches))
    set content = content + AppendFileContent("Research Names: " + researchNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-index-" + I2S(index) + "-researches-" + I2S(researches)  + "-" + researchNames + ".txt")
endfunction

function GetSaveCodeResearchesEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, boolean writeFile, integer index, player owner returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    local integer id = -1
    local integer i = 0
    local integer researchesCounter = 0
    local integer count = 0
    local string researchNames = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_RESEARCHES)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(index)

    set i = 0
    loop
        exitwhen (researchesCounter == SAVE_CODE_MAX_RESEARCHES or i == GetSaveObjectResearchMax())
        exitwhen (i >= (index + 1) * SAVE_CODE_MAX_RESEARCHES)
        if (i >= index * SAVE_CODE_MAX_RESEARCHES and i < (index + 1) * SAVE_CODE_MAX_RESEARCHES) then
            set id = GetSaveObjectResearchId(i)
            set count = GetPlayerTechCountSimple(id, owner)
            if (count > 0) then
                set result = result + ConvertDecimalNumberToSaveCodeSegment(i)
                set result = result + ConvertDecimalNumberToSaveCodeSegment(GetPlayerTechCountSimple(id, owner))
                if (researchNames != "") then
                    set researchNames = researchNames + ","
                endif
                set researchNames = researchNames + GetObjectName(id) + "_" + I2S(count)
                set researchesCounter = researchesCounter + 1
            endif
        endif
        set i = i + 1
    endloop

    // fill rest
    set i = researchesCounter
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    if (researchesCounter > 0) then
        if (writeFile) then
            call CreateSaveCodeResearchesTextFile(playerName, isSinglePlayer, isWarlord, index, researchesCounter, researchNames, result)
        endif

        call AddGeneratedSaveCode(result)
    endif

    return result
endfunction

function GetSaveCodeResearchesForIndex takes player whichPlayer, boolean writeFile, integer index returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeResearchesEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, writeFile, index, whichPlayer)
endfunction

function GetSaveCodeResearches takes player whichPlayer returns string
    return GetSaveCodeResearchesForIndex(whichPlayer, true, 0)
endfunction

function GetAllSaveCodeResearches takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = GetSaveCodeResearchesMax()
    loop
        exitwhen (i == max)
        call GetSaveCodeResearchesForIndex(whichPlayer, true, i)
        set i = i + 1
    endloop
endfunction

function ApplySaveCodeResearches takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                //call BJDebugMsg("Loading save object: " + I2S(saveObject))
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectResearchId(saveObject)
                    if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                        set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                        //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                        if (not SetPlayerTechResearchedIfHigher(whichPlayer, saveObjectId, count)) then
                            call DisplaySaveCodeErrorLowerResearch(whichPlayer, saveObjectId)
                        endif
                        set atLeastOne = true
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)
            
            if (atLeastOne) then
                call AddGeneratedSaveCode(s)
                set udg_TmpPlayer = whichPlayer
                call ConditionalTriggerExecute(gg_trg_Ogre_Update_Captured_Black_Drakes)
                set udg_TmpPlayer = whichPlayer
                call ConditionalTriggerExecute(gg_trg_Dragonkin_Update_Black_Dragons)
            endif

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosResearches takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer level = 0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "Index: " + I2S(index))

    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectResearchId(saveObject)
            set level = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cff00ff00" + GetObjectName(saveObjectId) + "|r (" + I2S(level) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - |cffff0000" + GetObjectName(saveObjectId) + "|r (" + I2S(level) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Research Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Research with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosResearches takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_TYPE)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_PLAYER_NAME_HASH)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_MODE)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_XP_RATE)
    local integer index = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, SAVE_CODE_INDEX_INDEX)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = SAVE_CODE_INDEX_INDEX + 1
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer level = 0
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local string result = ""
    
    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectResearchId(saveObject)
            set level = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer) and IsObjectFromPlayerProfession(saveObjectId, whichPlayer)) then
                set result = result + "|cff00ff00" + GetObjectName(saveObjectId) + "|r (" + I2S(level) + ")"
            else
                set result = result + "|cffff0000" + GetObjectName(saveObjectId) + "|r (" + I2S(level) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Research Slot"
        else
            set result = result + "Invalid Research with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + warlordStatus + "-" + I2S(index) + result
endfunction

function AppendClanSaveCodeMember takes string members, string playerName, integer playerRank returns string
    if (StringLength(playerName) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        return members + playerName + "_" + GetClanRankName(playerRank)
    endif

    return members
endfunction

function CreateSaveCodeClanTextFile takes boolean isSinglePlayer, string clanName, integer icon, integer clanSoundIndex, integer gold, integer lumber, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6, integer memberCounter, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string leader = ""
    local string members = ""
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    set members = AppendClanSaveCodeMember(members, playerName0, playerRank0)

    if (playerRank0 == udg_ClanRankLeader) then
        set leader = playerName0
    endif

    set members = AppendClanSaveCodeMember(members, playerName1, playerRank1)

    if (playerRank1 == udg_ClanRankLeader) then
        set leader = playerName1
    endif

    set members = AppendClanSaveCodeMember(members, playerName2, playerRank2)

    if (playerRank2 == udg_ClanRankLeader) then
        set leader = playerName2
    endif

    set members = AppendClanSaveCodeMember(members, playerName3, playerRank3)

    if (playerRank3 == udg_ClanRankLeader) then
        set leader = playerName3
    endif

    set members = AppendClanSaveCodeMember(members, playerName4, playerRank4)

    if (playerRank4 == udg_ClanRankLeader) then
        set leader = playerName4
    endif

    set members = AppendClanSaveCodeMember(members, playerName5, playerRank5)

    if (playerRank5 == udg_ClanRankLeader) then
        set leader = playerName5
    endif


    set members = AppendClanSaveCodeMember(members, playerName6, playerRank6)

    if (playerRank6 == udg_ClanRankLeader) then
        set leader = playerName6
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadc " + saveCode + " " + clanName)
    set content = content + AppendFileContent("Singleplayer: " + singleplayer)
    set content = content + AppendFileContent("Name: " + clanName)
    set content = content + AppendFileContent("Icon: " + GetObjectName(icon))
    set content = content + AppendFileContent("Sound: " + GetClanSoundName(clanSoundIndex))
    set content = content + AppendFileContent("Leader: " + leader)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    set content = ""
    set content = content + AppendFileContent("Members: " + members)
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("")
    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave("WoWR-Clan-" + clanName + "-" + playerName0 + "-" + singlePlayerFileName + "-gold-" + I2S(gold) + "-lumber-" + I2S(lumber) + "-members-" + I2S(memberCounter) + ".txt")
endfunction

function GetSaveCodeClanEx takes boolean isSinglePlayer, string clanName, integer icon, integer clanSoundIndex, integer gold, integer lumber, boolean hasAIPlayer, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6, integer membersCounter returns string
    local string result = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))
    
    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_CLAN) // 0

    if (isSinglePlayer) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0) // 1
    else
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1) // 1
    endif
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(clanName)) // 2
    set result = result + ConvertDecimalNumberToSaveCodeSegment(icon) // 3
    set result = result + ConvertDecimalNumberToSaveCodeSegment(clanSoundIndex) // 4
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold) // 5
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber) // 6
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName0)) // 7
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank0) // 8
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName1)) // 9
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank1) // 19
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName2)) // 11
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank2) // 12
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName3)) // 13
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank3) // 14
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName4)) // 15
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank4) // 16
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName5)) // 17
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank5) // 18
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName6)) // 19
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank6) // 20

    if (hasAIPlayer) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1) // 21
    else
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0) // 21
    endif

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, CompressedAbsStringHash(clanName))
    endif

    call CreateSaveCodeClanTextFile(isSinglePlayer, clanName, icon, clanSoundIndex, gold, lumber, playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6, membersCounter, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeClan takes integer clan returns string
     local string playerName0 = ""
     local integer playerRank0 = udg_ClanRankMember
     local string playerName1 = ""
     local integer playerRank1 = udg_ClanRankMember
     local string playerName2 = ""
     local integer playerRank2 = udg_ClanRankMember
     local string playerName3 = ""
     local integer playerRank3 = udg_ClanRankMember
     local string playerName4 = ""
     local integer playerRank4 = udg_ClanRankMember
     local string playerName5 = ""
     local integer playerRank5 = udg_ClanRankMember
     local string playerName6 = ""
     local integer playerRank6 = udg_ClanRankMember
     local integer clanMemberCounter = 0
    local integer clanSoundIndex = GetClanSoundIndex(udg_ClanSound[clan])
     local integer i = 0
     loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
            if (clanMemberCounter == 0) then
                set playerName0 = GetPlayerName(Player(i))
                set playerRank0 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 1) then
                set playerName1 = GetPlayerName(Player(i))
                set playerRank1 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 2) then
                set playerName2 = GetPlayerName(Player(i))
                set playerRank2 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 3) then
                set playerName3 = GetPlayerName(Player(i))
                set playerRank3 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 4) then
                set playerName4 = GetPlayerName(Player(i))
                set playerRank4 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 5) then
                set playerName5 = GetPlayerName(Player(i))
                set playerRank5 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 6) then
                set playerName6 = GetPlayerName(Player(i))
                set playerRank6 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            endif
            set clanMemberCounter = clanMemberCounter + 1
        endif
        set i = i + 1
    endloop

    return GetSaveCodeClanEx(IsInSinglePlayer(), udg_ClanName[clan], udg_ClanIcon[clan], clanSoundIndex, udg_ClanGold[clan], udg_ClanLumber[clan], udg_ClanHasAIPlayer[clan], playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6, clanMemberCounter)
endfunction

function ApplySaveCodeClan takes player whichPlayer, string name, string s returns boolean
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0
    local integer currentPlayerNameHash = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and nameHash == CompressedAbsStringHash(name) and isSinglePlayer == IsInSinglePlayer()) then
            if (playerNameHash == playerNameHash0 or playerNameHash == playerNameHash1 or playerNameHash == playerNameHash2 or playerNameHash == playerNameHash3 or playerNameHash == playerNameHash4 or playerNameHash == playerNameHash5 or playerNameHash == playerNameHash6) then
                set i = 1
                loop
                    exitwhen (i > udg_ClanCounter)
                    if (StringLength(udg_ClanName[i]) > 0 and udg_ClanName[i] == name) then
                        set clan = i
                    endif
                    set i = i + 1
                endloop

                if (clan == 0) then
                    set udg_ClanName[udg_ClanCounter] = name
                    set udg_ClanIcon[udg_ClanCounter] = icon
                    set udg_ClanSound[udg_ClanCounter] = GetClanSound(clanSoundIndex)
                    set udg_ClanGold[udg_ClanCounter] = gold
                    set udg_ClanLumber[udg_ClanCounter] = lumber
                    set clan = udg_ClanCounter
                    set udg_ClanCounter = udg_ClanCounter + 1
                    //call BJDebugMsg("Creating new clan " + name)
                endif

                set i = 0
                loop
                    exitwhen (i == bj_MAX_PLAYERS)
                    if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
                        //call BJDebugMsg("Checking for player " + GetPlayerName(Player(i)))
                        set currentPlayerNameHash = CompressedAbsStringHash(GetPlayerName(Player(i)))
                        if (currentPlayerNameHash == playerNameHash0 or currentPlayerNameHash == playerNameHash1 or currentPlayerNameHash == playerNameHash2 or currentPlayerNameHash == playerNameHash3 or currentPlayerNameHash == playerNameHash4 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5 or currentPlayerNameHash == playerNameHash6) then
                            //call BJDebugMsg("Got clan player " + GetPlayerName(Player(i)))
                            set atLeastOne = true
                            if (not IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
                                call ForceAddPlayer(udg_ClanPlayers[clan], Player(i))
                            endif
                            set udg_ClanPlayerClan[i + 1] = clan
                            call SetPlayerTechResearchedIfHigher(Player(i), UPG_HERO_CLAN, 1)

                            if (clanHasAIPlayer == 1) then
                                call SetPlayerTechResearchedSwap(UPG_CLAN_HAS_NO_AI_PLAYER, 0, Player(i))
                            endif
                        endif

                        if (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash0) then
                            set udg_ClanPlayerRank[i + 1] = playerRank0
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash1) then
                            set udg_ClanPlayerRank[i + 1] = playerRank1
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash2) then
                            set udg_ClanPlayerRank[i + 1] = playerRank2
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash3) then
                            set udg_ClanPlayerRank[i + 1] = playerRank3
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash4) then
                            set udg_ClanPlayerRank[i + 1] = playerRank4
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5) then
                            set udg_ClanPlayerRank[i + 1] = playerRank5
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash6) then
                            set udg_ClanPlayerRank[i + 1] = playerRank6
                        endif
                    endif
                    set i = i + 1
                endloop

                call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

                if (atLeastOne) then
                    call AddGeneratedSaveCode(s)
                
                    call PickClanAIPlayer(clan)

                    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedString("X_HAS_CREATED_A_NEW_CLAN_Y")).s(GetPlayerNameColored(whichPlayer)).s(udg_ClanName[clan]).result())
                    call PlaySoundBJ(gg_snd_ClanInvitation)
                endif

                return atLeastOne
            else
                call DisplaySaveCodeError(whichPlayer, GetLocalizedString("YOU_ARE_NOT_A_MEMBER_OF_THIS_CLAN"))
            endif
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetClanPlayerName takes integer playerNameHash returns string
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (StringLength(GetPlayerName(Player(i))) > 0 and CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash) then
            return GetPlayerName(Player(i))
        endif
        set i = i + 1
    endloop

    return "Unknown"
endfunction

function GetSaveCodeInfosClan takes string name, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local string singlePlayerStatus = "Multiplayer"
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local string clanHasAIPlayerText = "No AI player"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean generated = IsGeneratedSaveCode(s)
    local string generatedStatus = GetGeneratedStatus(generated)
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (clanHasAIPlayer == 1) then
        set clanHasAIPlayerText = "Has AI player"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Generated: " + generatedStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Name: " + name)
    set result = AppendSaveCodeInfo(result, "Icon: " + GetObjectName(icon))
    set result = AppendSaveCodeInfo(result, "Sound: " + GetClanSoundName(clanSoundIndex))
    set result = AppendSaveCodeInfo(result, "Gold: " + I2S(gold))
    set result = AppendSaveCodeInfo(result, "Lumber: " + I2S(lumber))
    set result = AppendSaveCodeInfo(result, clanHasAIPlayerText)
    set result = AppendSaveCodeInfo(result, "Player 1: " + GetClanPlayerName(playerNameHash0) + " (" + GetClanRankName(playerRank0) + ")")
    set result = AppendSaveCodeInfo(result, "Player 2: " + GetClanPlayerName(playerNameHash1) + " (" + GetClanRankName(playerRank1) + ")")
    set result = AppendSaveCodeInfo(result, "Player 3: " + GetClanPlayerName(playerNameHash2) + " (" + GetClanRankName(playerRank2) + ")")
    set result = AppendSaveCodeInfo(result, "Player 4: " + GetClanPlayerName(playerNameHash3) + " (" + GetClanRankName(playerRank3) + ")")
    set result = AppendSaveCodeInfo(result, "Player 5: " + GetClanPlayerName(playerNameHash4) + " (" + GetClanRankName(playerRank4) + ")")
    set result = AppendSaveCodeInfo(result, "Player 6: " + GetClanPlayerName(playerNameHash5) + " (" + GetClanRankName(playerRank5) + ")")
    set result = AppendSaveCodeInfo(result, "Player 7: " + GetClanPlayerName(playerNameHash6) + " (" + GetClanRankName(playerRank6) + ")")

    return result
endfunction

function GetSaveCodeShortInfosClan takes string name, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local string singlePlayerStatus = "M"
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local string clanHasAIPlayerText = "No AI player"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))
    
    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (clanHasAIPlayer == 1) then
        set clanHasAIPlayerText = "Has AI player"
    endif

    return name + "-" + singlePlayerStatus + "-gold_" + I2S(gold) + "-lumber_" + I2S(lumber) + "-p1_" + GetClanPlayerName(playerNameHash0) + "-p2_" + GetClanPlayerName(playerNameHash1) + "-p3_" + GetClanPlayerName(playerNameHash2)
endfunction

function GetSaveCodeClanGold takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)

    return gold
endfunction

function GetSaveCodeClanLumber takes string name, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)

    return lumber
endfunction

function AccountNameBelongsToClanSaveCode takes string clanName, string accountName, string s returns boolean
    local string result = ""
    local integer accountNameHash = StringHash(accountName)
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(clanName))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    
    return accountNameHash == playerNameHash0 or accountNameHash == playerNameHash1 or accountNameHash == playerNameHash2 or accountNameHash == playerNameHash3 or accountNameHash == playerNameHash4 or accountNameHash == playerNameHash5 or accountNameHash == playerNameHash6
endfunction

// Mailbox System

function CreateSaveCodeLetterTextFile takes string playerNameFrom, string playerNameTo, string message, string saveCode returns nothing
    local string content = ""

    call FileStart()

    set content = content + AppendFileContent("Code:")
    set content = content + AppendFileContentLeft("-loadl " + saveCode)
    set content = content + AppendFileContent("From: " + playerNameFrom)
    set content = content + AppendFileContent("To: " + playerNameTo)
    set content = content + AppendFileContent("Message Length: " + I2S(StringLength(message)))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-letter-from_" + playerNameFrom + "-to_" + playerNameTo + "-messageLength_" + I2S(StringLength(message)) + ".txt")
endfunction

function AddGeneratedSaveCodeLetter takes string playerNameFrom, string playerNameTo, string message returns nothing
    local integer index = 0
    local integer i = 0
    loop
        exitwhen(i == bj_MAX_PLAYERS)
        if (GetPlayerName(Player(i)) == playerNameTo) then
            call DisplayTimedTextToPlayer(Player(i), 0.0, 0.0, 40.0, "You received a letter from " + playerNameFrom + ". Use \"-mailbox\" to list all letters.")
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    set index = PrestoredSaveCodeCounter
    set PrestoredSaveCodePlayerName[index] = playerNameTo
    set PrestoredSaveCode[index] = message
    set PrestoredSaveCodeType[index] = PRESTORED_SAVECODE_TYPE_LETTER
    set PrestoredSaveCodePlayerNamesCounter[index] = 0
    set PrestoredSaveCodeCounter = PrestoredSaveCodeCounter + 1
    set lastAddedPrestoredClan = index
endfunction

function GetSaveCodeLetter takes boolean writeFile, string playerNameFrom, string playerNameTo, string message returns string
    local integer i = 0
    local integer playerNameToHash = CompressedAbsStringHash(playerNameTo)
    local string result = ""
    
    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_LETTER)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameToHash)
    set result = result + ConvertStringToSaveCodeSegment(playerNameFrom, playerNameToHash)
    set result = result + ConvertStringToSaveCodeSegment(message, playerNameToHash)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameToHash)
    endif

    if (writeFile) then
        call CreateSaveCodeLetterTextFile(playerNameFrom, playerNameTo, message, result)
    endif

    call AddGeneratedSaveCode(result)
    call AddGeneratedSaveCodeLetter(playerNameFrom, playerNameTo, message)

    return result
endfunction

function GetSaveCodeInfosLetter takes string playerNameTo, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerNameTo))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerNameToText = playerNameTo
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 3, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (playerNameToHash != CompressedAbsStringHash(playerNameTo)) then
        set playerNameToText = "Invalid"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "To: " + playerNameToText)
    set result = AppendSaveCodeInfo(result, "From: " + playerNameFrom)
    set result = AppendSaveCodeInfo(result, "Message: " + message)

    return result
endfunction

function GetSaveCodeShortInfosLetter takes string playerNameTo, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerNameTo))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerNameToText = playerNameTo
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 3, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (playerNameToHash != CompressedAbsStringHash(playerNameTo)) then
        set playerNameToText = "Invalid"
    endif

    return "f_" + playerNameFrom + "-t_" + playerNameToText + "-m_" + I2S(StringLength(message))
endfunction

function ApplySaveCodeLetterEx takes player whichPlayer, string playerName, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 3, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameToHash == CompressedAbsStringHash(playerName)) then
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 120.0, "Letter from " + playerNameFrom + ": " + message)

        return true
    endif

    return false
endfunction

function ApplySaveCodeLetter takes player whichPlayer, string playerName, string s returns boolean
    return ApplySaveCodeLetterEx(whichPlayer, "all", s) or ApplySaveCodeLetterEx(whichPlayer, playerName, s)
endfunction

function GetSaveCodeErrorsLetter takes player whichPlayer, string playerName, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 3, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string result = ""


    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set result = result + "Expected different checksum!"
    endif

    if (playerNameToHash != CompressedAbsStringHash(playerName)) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected different player name!"
    endif

    if (StringLength(result) == 0) then
        set result = "None errors detected."
    endif

    return result
endfunction

// Save and Load Auto

globals
    constant string SAVE_AND_LOAD_AUTO_PREFIX = "SaveAndLoadAuto"
    trigger SaveAndLoadAutoSyncTrigger = CreateTrigger()
    integer array SaveAndLoadAutoSyncCounter
endglobals

function SaveAndLoadAutoGetPlayerFromSyncData takes string source returns player
    return Player(S2I(StringToken(source, 0)))
endfunction

function SaveAndLoadAutoGetContentFromSyncData takes string source returns string
    return StringToken(source, 1)
endfunction

function SaveAndLoadAutoTriggerAction takes nothing returns nothing
    local string syncData = BlzGetTriggerSyncData()
    local player sourcePlayer = SaveAndLoadAutoGetPlayerFromSyncData(syncData)
    local string content = SaveAndLoadAutoGetContentFromSyncData(syncData)
    //call BJDebugMsg("Syncing data from player " + GetPlayerName(sourcePlayer) + ": " + content)
    set SaveAndLoadAutoSyncCounter[GetPlayerId(sourcePlayer)] = SaveAndLoadAutoSyncCounter[GetPlayerId(sourcePlayer)] + 1
endfunction

function SaveAndLoadAutoInit takes nothing returns nothing
    call TriggerRegisterAnyPlayerSyncEvent(SaveAndLoadAutoSyncTrigger, SAVE_AND_LOAD_AUTO_PREFIX, false)
    call TriggerAddAction(SaveAndLoadAutoSyncTrigger, function SaveAndLoadAutoTriggerAction)
endfunction

function LoadFileForAllPlayers takes File file, player whichPlayer returns string
    local force allPlayingUsers = null
    local string content = ""
    local boolean synced = false
    local real timeout = 0.0
    set SaveAndLoadAutoSyncCounter[GetPlayerId(whichPlayer)] = 0
    if (GetLocalPlayer() == whichPlayer) then
        set content = file.read()
        call BlzSendSyncData(SAVE_AND_LOAD_AUTO_PREFIX, I2S(GetPlayerId(whichPlayer)) + " " + content)
    endif

    loop
        set synced = SaveAndLoadAutoSyncCounter[GetPlayerId(whichPlayer)] >= CountPlayersInForceBJ(GetAllPlayingUsers())
        exitwhen (timeout >= 5.0 or synced)
        call TriggerSleepAction(1.0)
        set timeout = timeout + 1.0
    endloop

    if (synced) then
        return content
    endif

    return null
endfunction

endlibrary
