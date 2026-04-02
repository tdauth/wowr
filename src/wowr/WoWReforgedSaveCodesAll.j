library WoWReforgedSaveCodesAll initializer Init requires FileIO, FileUtils, WoWReforgedUtils, WoWReforgedSaveCodes, WoWReforgedSaveCodesResources

globals
    private trigger syncTrigger = CreateTrigger()
    
    private boolean array loadedAllOnce
    private player tmpPlayer = null
    private string tmpString = ""
endglobals

function ResetSaveCodeAllTextFile takes player whichPlayer returns nothing
    set loadedAllOnce[GetPlayerId(whichPlayer)] = true
endfunction

function GetModeSuffix takes nothing returns string
    if (IsInSinglePlayer()) then
        return "Singleplayer"
    endif
    return "Multiplayer"
endfunction

function GetGameModeSuffix takes boolean isWarlord returns string
    if (isWarlord) then
        return "Warlord"
    endif
    
    return "Freelancer"
endfunction

function GetSaveCodeAllFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + ".txt"
endfunction

function GetSaveCodeAllItemsFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + "-Items.txt"
endfunction

function GetSaveCodeAllUnitsFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + "-Units.txt"
endfunction

function GetSaveCodeAllBuildingsFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + "-Buildings.txt"
endfunction

function GetSaveCodeAllResearchesFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + "-Researches.txt"
endfunction

function GetSaveCodeAllResourcesFileName takes string playerName, boolean isWarlord returns string
    return SAVE_CODE_FOLDER + "\\" + playerName + "-" + GetModeSuffix() + "-" + GetGameModeSuffix(isWarlord) + "-Resources.txt"
endfunction

function GetSaveCodeAllFileNameForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function GetSaveCodeAllFileNameItemsForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllItemsFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function GetSaveCodeAllFileNameUnitsForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllUnitsFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function GetSaveCodeAllFileNameBuildingsForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllBuildingsFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function GetSaveCodeAllFileNameResearchesForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllResearchesFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function GetSaveCodeAllFileNameResourcesForPlayer takes player whichPlayer returns string
    return GetSaveCodeAllResourcesFileName(GetPlayerName(whichPlayer), IsPlayerWarlord(whichPlayer))
endfunction

function CreateSaveCodeAllHeroesTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = GetSaveCode(whichPlayer)
    local string content = ""
    
    set content = content + " -load " + saveCode
    set content = content + " "
    
    call FileIO_Write(GetSaveCodeAllFileNameForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllHeroesTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllHeroesTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllHeroesTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllHeroesTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllItemsTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ""
    local string content = ""
    local integer i = 0
    local integer max = GetSaveCodeItemsMax()
    loop
        exitwhen (i >= max)
        set saveCode = GetSaveCodeItemsForIndex(whichPlayer, false, i)
        if (saveCode != null and saveCode != "") then
            set content = content + " -loadi " + saveCode
            set content = content + " "
        endif
        set i = i + 1
    endloop

    call FileIO_Write(GetSaveCodeAllFileNameItemsForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllItemsTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllItemsTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllItemsTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllItemsTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllUnitsTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ""
    local string content = ""
    local integer i = 0
    local integer max = GetSaveCodeUnitsMax()
    loop
        exitwhen (i >= max)
        //call BJDebugMsg("Loop " + I2S(i) + " for units")
        set saveCode = GetSaveCodeUnitsForIndex(whichPlayer, false, i)
        if (saveCode != null and saveCode != "") then
            set content = content + " -loadu " + saveCode
            set content = content + " "
        endif
        set i = i + 1
    endloop
    
    call FileIO_Write(GetSaveCodeAllFileNameUnitsForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllUnitsTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllUnitsTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllUnitsTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllUnitsTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllBuildingsTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ""
    local string content = ""
    local integer i = 0
    local integer max = GetSaveCodeBuildingsMax()
    loop
        exitwhen (i >= max)
        //call BJDebugMsg("Loop " + I2S(i) + " for buildings")
        set saveCode = GetSaveCodeBuildingsForIndex(whichPlayer, false, i)
        if (saveCode != null and saveCode != "") then
            set content = content + " -loadb " + saveCode
            set content = content + " "
        endif
        set i = i + 1
    endloop

    set content = content + " "

    call FileIO_Write(GetSaveCodeAllFileNameBuildingsForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllBuildingsTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllBuildingsTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllBuildingsTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllBuildingsTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllResearchesTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ""
    local string content = ""
    local integer i = 0
    local integer max = GetSaveCodeResearchesMax()
    loop
        exitwhen (i >= max)
        //call BJDebugMsg("Loop " + I2S(i) + " for researches")
        set saveCode = GetSaveCodeResearchesForIndex(whichPlayer, false, i)
        if (saveCode != null and saveCode != "") then
            set content = content + " -loadr " + saveCode
            set content = content + " "
        endif
        set i = i + 1
    endloop

    set content = content + " "

    call FileIO_Write(GetSaveCodeAllFileNameResearchesForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllResearchesTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllResearchesTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllResearchesTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllResearchesTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllResourcesTextFileEx takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = GetSaveCodeResources(whichPlayer)
    local string content = ""

    set content = content + " -loadres " + saveCode
    set content = content + " "

    call FileIO_Write(GetSaveCodeAllFileNameResourcesForPlayer(whichPlayer), content)
endfunction

function CreateSaveCodeAllResourcesTextFileNewOpLimit takes nothing returns nothing
    call CreateSaveCodeAllResourcesTextFileEx(tmpPlayer)
endfunction

function CreateSaveCodeAllResourcesTextFile takes player whichPlayer returns nothing
    set tmpPlayer = whichPlayer
    call NewOpLimit(function CreateSaveCodeAllResourcesTextFileNewOpLimit)
endfunction

function CreateSaveCodeAllTextFile takes player whichPlayer returns nothing
    if (loadedAllOnce[GetPlayerId(whichPlayer)]) then
        call CreateSaveCodeAllHeroesTextFile(whichPlayer)
        //call BJDebugMsg("After heroes")
        call CreateSaveCodeAllItemsTextFile(whichPlayer)
        //call BJDebugMsg("After items")
        call CreateSaveCodeAllUnitsTextFile(whichPlayer)
        //call BJDebugMsg("After units")
        call CreateSaveCodeAllBuildingsTextFile(whichPlayer)
        //call BJDebugMsg("After buildings")
        call CreateSaveCodeAllResearchesTextFile(whichPlayer)
        //call BJDebugMsg("After researches")
        call CreateSaveCodeAllResourcesTextFile(whichPlayer)
        //call BJDebugMsg("After resources")
    else
        call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("AT_LEAST_ONE_ALOAD"))
    endif
endfunction

function GetSaveCodeFromFile takes string s, string prefix, integer tokenIndex returns string
    local integer index = 0
    local integer index2 = 0
    local integer i = 0
    loop
        set index = IndexOfStringEx(prefix, s, index2)
        if (index != -1) then
            set index2 = IndexOfStringEx(" ", s, index + StringLength(prefix))
            if (index2 != -1 and tokenIndex == i) then
                return SubString(s, index + StringLength(prefix), index2)
            endif
        endif
        exitwhen (index == -1 or index2 == -1)
        set i = i + 1
    endloop
    return null
endfunction

// TODO Create hero and apply settings before.
function LoadSaveCodeAllHeroes takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = GetSaveCodeFromFile(allSaveCodes, "-load ", 0)
    if (saveCode != null) then
        call ApplySaveCode(whichPlayer, saveCode)
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_SAVE_CODES"))
    else
        call SimError(whichPlayer, Format(GetLocalizedString("MISSING_SAVE_CODE_WITH_LOAD")).s(allSaveCodes).result())
    endif
endfunction

function LoadSaveCodeAllItems takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = null
    local integer i = 0
    loop
        set saveCode = GetSaveCodeFromFile(allSaveCodes, "-loadi ", i)
        exitwhen (saveCode == null)
        call ApplySaveCodeItems(whichPlayer, saveCode)
        set i = i + 1
    endloop
        
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_ITEM_SAVE_CODES"))
endfunction

function LoadSaveCodeAllUnits takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = null
    local integer i = 0
    loop
        set saveCode = GetSaveCodeFromFile(allSaveCodes, "-loadu ", i)
        exitwhen (saveCode == null)
        call ApplySaveCodeUnits(whichPlayer, saveCode)
        set i = i + 1
    endloop
        
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_UNIT_SAVE_CODES"))
endfunction

function LoadSaveCodeAllBuildings takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = null
    local integer i = 0
    loop
        set saveCode = GetSaveCodeFromFile(allSaveCodes, "-loadb ", i)
        exitwhen (saveCode == null)
        call ApplySaveCodeBuildings(whichPlayer, saveCode)
        set i = i + 1
    endloop
        
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_BUILDING_SAVE_CODES"))
endfunction

function LoadSaveCodeAllResearches takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = null
    local integer i = 0
    loop
        set saveCode = GetSaveCodeFromFile(allSaveCodes, "-loadr ", i)
        exitwhen (saveCode == null)
        call ApplySaveCodeResearches(whichPlayer, saveCode)
        set i = i + 1
    endloop
        
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_RESEARCH_SAVE_CODES"))
endfunction

function LoadSaveCodeAllResources takes player whichPlayer, string allSaveCodes returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local string saveCode = GetSaveCodeFromFile(allSaveCodes, "-loadres ", 0)
    local integer i = 0
    if (saveCode != null) then
        if (ApplySaveCodeResources(whichPlayer, saveCode)) then
            call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetLocalizedString("LOADED_RESOURCES_SAVE_CODES"))
        endif
    else
        call SimError(whichPlayer, Format(GetLocalizedString("MISSING_SAVE_CODE_WITH_LOADRES")).s(allSaveCodes).result())
    endif
endfunction

function GetSaveCodeAllTextFile takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerId = GetPlayerId(whichPlayer)
    local string fileNameHeroes = GetSaveCodeAllFileNameForPlayer(whichPlayer)
    local string fileNameItems = GetSaveCodeAllFileNameItemsForPlayer(whichPlayer)
    local string fileNameUnits = GetSaveCodeAllFileNameUnitsForPlayer(whichPlayer)
    local string fileNameBuildings = GetSaveCodeAllFileNameBuildingsForPlayer(whichPlayer)
    local string fileNameResearches = GetSaveCodeAllFileNameResearchesForPlayer(whichPlayer)
    local string fileNameResources = GetSaveCodeAllFileNameResourcesForPlayer(whichPlayer)
    local string fileContent = null
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, Format(GetLocalizedString("LOADING_YOUR_CHARACTER_FROM_FILE")).s(fileNameHeroes).result())
    if (GetLocalPlayer() == whichPlayer) then
        set fileContent = FileIO_Read(fileNameHeroes)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllHeroes", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllHeroes", "missing")
        endif
        
        set fileContent = FileIO_Read(fileNameItems)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllItems", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllItems", "missing")
        endif
        
        set fileContent = FileIO_Read(fileNameUnits)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllUnits", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllUnits", "missing")
        endif
        
        set fileContent = FileIO_Read(fileNameBuildings)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllBuildings", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllBuildings", "missing")
        endif
        
        set fileContent = FileIO_Read(fileNameResearches)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllResearches", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllResearches", "missing")
        endif
        
        set fileContent = FileIO_Read(fileNameResources)
        //call BJDebugMsg("File content: " + fileContent)
        if (fileContent != null) then
            call BlzSendSyncData("SaveCodeAllResources", fileContent)
        else
            call BlzSendSyncData("SaveCodeAllResources", "missing")
        endif
    endif
endfunction

private function TriggerActionSync takes nothing returns nothing
    local player triggerPlayer = GetTriggerPlayer()
    local integer playerId = GetPlayerId(triggerPlayer)
    local string prefix = BlzGetTriggerSyncPrefix()
    local string data = BlzGetTriggerSyncData()
    if (prefix == "SaveCodeAllHeroes") then
        set loadedAllOnce[playerId] = true
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_HEROES_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllHeroes(triggerPlayer, data)
        endif
    elseif (prefix == "SaveCodeAllItems") then
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_ITEMS_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllItems(triggerPlayer, data)
        endif
    elseif (prefix == "SaveCodeAllUnits") then
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_UNITS_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllUnits(triggerPlayer, data)
        endif
    elseif (prefix == "SaveCodeAllBuildings") then
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_BUILDINGS_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllBuildings(triggerPlayer, data)
        endif
    elseif (prefix == "SaveCodeAllResearches") then
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_RESEARCHES_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllResearches(triggerPlayer, data)
        endif
    elseif (prefix == "SaveCodeAllResources") then
        //call BJDebugMsg("Synced: " + BlzGetTriggerSyncData())
        if (data == "missing") then
            call SimError(triggerPlayer, GetLocalizedString("MISSING_RESOURCES_SAVE_CODE_FILE"))
        else
            call LoadSaveCodeAllResources(triggerPlayer, data)
        endif
    endif
    set triggerPlayer = null
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerEvent(syncTrigger, Player(i), EVENT_PLAYER_SYNC_DATA)
        set i = i + 1
    endloop
    call TriggerAddAction(syncTrigger, function TriggerActionSync)
endfunction

endlibrary
