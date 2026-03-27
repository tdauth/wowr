library WoWReforgedSaveCodesResources requires SaveCodeSystem, Resources, WoWReforgedUtils, WoWReforgedSaveCodes

function IsSavedResource takes integer index returns boolean
    local Resource r = GetResource(index)
    return r != Resources_GOLD and r != Resources_LUMBER and r != Resources_FOOD and r != Resources_FOOD_MAX
endfunction

function CreateSaveCodeResourcesTextFile takes player owner, string playerName, boolean isSinglePlayer, boolean isWarlord, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string content = ""
    local string fileName = ""
    local integer i = 0
    local integer max = GetMaxResources()

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    call FileStart()

    set content = content + AppendFileContent("Code: -loadres " + saveCode)
    set content = content + AppendFileContent("")
    
    // The line below creates the log
    call FileWriteLine(content)
    set content = ""
    
    set i = 0
    loop
        exitwhen (i == max)
        if (IsSavedResource(i)) then
            set content = content + AppendFileContent(GetResourceName(GetResource(i)) + " - " + I2S(GetPlayerResource(owner, GetResource(i))))     
            set fileName = fileName + "-" + I2S(GetPlayerResource(owner, GetResource(i)))
        endif
        set i = i + 1
    endloop
    
    set content = content + AppendFileContent("")

    // The line below creates the log
    call FileWriteLine(content)
    set content = ""

    // The line below creates the file at the specified location
    call FileSave(SAVE_CODE_FOLDER + "\\" + playerName + "-" + singlePlayerFileName + "-" + gameMode + "-resources" + fileName + ".txt")
endfunction

function GetSaveCodeResourcesEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer xpRate, player owner returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ""
    local integer max = GetMaxResources()
    local integer i = 0

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(SAVE_CODE_TYPE_RESOURCES)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    set i = 0
    loop
        exitwhen (i == max)
        if (IsSavedResource(i)) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetPlayerResource(owner, GetResource(i)))
        endif
        set i = i + 1
    endloop

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeResourcesTextFile(owner, playerName, isSinglePlayer, isWarlord, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeResources takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeResourcesEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, xpRate, whichPlayer)
endfunction

function ApplySaveCodeResources takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer pos = 4
    local integer i = 0
    local integer max = GetMaxResources()

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
                exitwhen (i >= max)
                if (IsSavedResource(i)) then
                    call SetPlayerResource(whichPlayer, GetResource(i), ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos))
                endif
                set i = i + 1
                set pos = pos + 1
            endloop
            
            call AddGeneratedSaveCode(s)
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosResources takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer pos = 4
    local integer i = 0
    local integer max = GetMaxResources()
    local string saveCodeTypeName = GetSaveCodeTypeName(saveCodeType)
    local string checksumStatus = GetChecksumStatus(checksum, checkedSaveCode)
    local string result = ""

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Type: " + saveCodeTypeName)
    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i >= max)
        if (IsSavedResource(i)) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetResourceName(GetResource(i)) + " (" + I2S(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)) + ")")
            set pos = pos + 1
        endif
        set i = i + 1
    endloop

    return result
endfunction

function GetSaveCodeShortInfosResources takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer saveCodeType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local string playerName = GetPlayerNameByHash(GetPlayerName(whichPlayer), playerNameHash)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer pos = 4
    local integer i = 0
    local integer max = GetMaxResources()
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
        exitwhen (i >= max)
        if (IsSavedResource(i)) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetResourceName(GetResource(i)) + " (" + I2S(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)) + ")")
            set pos = pos + 1
        endif
        set i = i + 1
    endloop

    return singlePlayerStatus + "-" + warlordStatus + result
endfunction

endlibrary
