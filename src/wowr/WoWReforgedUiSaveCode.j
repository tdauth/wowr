library WoWReforgedUiSaveCode initializer Init requires OpLimit, OnStartGame, FrameLoader, WoWReforgedUtils, WoWReforgedUi, WoWReforgedSaveCodes, WoWReforgedSaveCodesAll

/**
 * Savecode GUI which helps to copy & paste savecodes.
 */
globals
    private constant real LABEL_X = 0.03
    private constant real LABEL_WIDTH = 0.058018
    
    private constant real COLUMN_SPACING = 0.002
    
    private constant real INDEX_X = LABEL_X + LABEL_WIDTH + COLUMN_SPACING
    private constant real INDEX_WIDTH = 0.04
    
    private constant real BUTTON_UP_X = INDEX_X + INDEX_WIDTH + COLUMN_SPACING
    private constant real BUTTON_UP_WIDTH = 0.02
    
    private constant real BUTTON_DOWN_X = BUTTON_UP_X + BUTTON_UP_WIDTH + COLUMN_SPACING
    private constant real BUTTON_DOWN_WIDTH = 0.02

    private constant real LINEEDIT_X = BUTTON_DOWN_X + BUTTON_DOWN_WIDTH + COLUMN_SPACING
    private constant real LINEEDIT_WIDTH = 0.30

    private constant real UPDATE_BUTTON_X = LINEEDIT_X + LINEEDIT_WIDTH + COLUMN_SPACING
    private constant real UPDATE_BUTTON_WIDTH = 0.060

    private constant real LOAD_BUTTON_X = UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH + COLUMN_SPACING
    private constant real LOAD_BUTTON_WIDTH = 0.060

    private constant real LOAD_AUTO_BUTTON_X = 0.3
    private constant real LOAD_AUTO_BUTTON_WIDTH = 0.066

    private constant real WRITE_AUTO_BUTTON_X = 0.4
    private constant real WRITE_AUTO_BUTTON_WIDTH = 0.066

    private constant real LINE_START_Y = 0.528122
    private constant real LINE_HEIGHT = 0.03
    private constant real LINE_SPACING = 0.005

    private constant real TOOLTIP_X = 0.61
    private constant real TOOLTIP_WIDTH = 0.17
    private constant real TOOLTIP_HEIGHT = 0.34

    private constant real TOOLTIP_LABEL_X = 0.64
    private constant real TOOLTIP_LABEL_Y = 0.50
    private constant real TOOLTIP_LABEL_WIDTH = 0.10
    private constant real TOOLTIP_LABEL_HEIGHT = 0.32

    private framehandle BackgroundFrame
    private framehandle TitleFrame

    private framehandle TooltipBackgroundFrame
    private framehandle TooltipLabelFrame

    // line 1: heroes savecode
    private framehandle LabelFrameHeroes
    private framehandle EditBoxHeroes
    private trigger TriggerEditBoxHeroes
    private framehandle UpdateButtonFrameHeroes
    private trigger UpdateTriggerHeroes
    private framehandle LoadButtonFrameHeroes
    private trigger LoadTriggerHeroes
    private trigger EnterTriggerHeroes

    // line 2: items savecode
    private framehandle LabelFrameItems
    private framehandle ItemsEditIndex
    private trigger TriggerEditBoxItemsIndex
    private framehandle ItemsEditArrowUp
    private framehandle ItemsEditArrowUpFrame
    private framehandle ItemsEditArrowDown
    private framehandle ItemsEditArrowDownFrame
    private trigger ItemsUpTrigger
    private trigger ItemsDownTrigger
    private integer itemsIndex
    private framehandle EditBoxItems
    private trigger TriggerEditBoxItems
    private framehandle UpdateButtonFrameItems
    private trigger UpdateTriggerItems
    private framehandle LoadButtonFrameItems
    private trigger LoadTriggerItems
    private trigger EnterTriggerItems

    // line 3: units savecode
    private framehandle LabelFrameUnits
    private framehandle UnitsEditIndex
    private trigger TriggerEditBoxUnitsIndex
    private framehandle UnitsEditArrowUp
    private framehandle UnitsEditArrowUpFrame
    private framehandle UnitsEditArrowDown
    private framehandle UnitsEditArrowDownFrame
    private trigger UnitsUpTrigger
    private trigger UnitsDownTrigger
    private integer unitsIndex
    private framehandle EditBoxUnits
    private trigger TriggerEditBoxUnits
    private framehandle UpdateButtonFrameUnits
    private trigger UpdateTriggerUnits
    private framehandle LoadButtonFrameUnits
    private trigger LoadTriggerUnits
    private trigger EnterTriggerUnits

    // line 4: researches savecode
    private framehandle LabelFrameResearches
    private framehandle ResearchesEditIndex
    private trigger TriggerEditBoxResearchesIndex
    private framehandle ResearchesEditArrowUp
    private framehandle ResearchesEditArrowUpFrame
    private framehandle ResearchesEditArrowDown
    private framehandle ResearchesEditArrowDownFrame
    private trigger ResearchesUpTrigger
    private trigger ResearchesDownTrigger
    private integer researchesIndex
    private framehandle EditBoxResearches
    private trigger TriggerEditBoxResearches
    private framehandle UpdateButtonFrameResearches
    private trigger UpdateTriggerResearches
    private framehandle LoadButtonFrameResearches
    private trigger LoadTriggerResearches
    private trigger EnterTriggerResearches

    // line 5: buildings savecode
    private framehandle LabelFrameBuildings
    private framehandle BuildingsEditIndex
    private trigger TriggerEditBoxBuildingsIndex
    private framehandle BuildingsEditArrowUp
    private framehandle BuildingsEditArrowUpFrame
    private framehandle BuildingsEditArrowDown
    private framehandle BuildingsEditArrowDownFrame
    private trigger BuildingsUpTrigger
    private trigger BuildingsDownTrigger
    private integer buildingsIndex
    private framehandle EditBoxBuildings
    private trigger TriggerEditBoxBuildings
    private framehandle UpdateButtonFrameBuildings
    private trigger UpdateTriggerBuildings
    private framehandle LoadButtonFrameBuildings
    private trigger LoadTriggerBuildings
    private trigger EnterTriggerBuildings
    
    // line 6: resources savecode
    private framehandle LabelFrameResources
    private framehandle EditBoxResources
    private trigger TriggerEditBoxResources
    private framehandle UpdateButtonFrameResources
    private trigger UpdateTriggerResources
    private framehandle LoadButtonFrameResources
    private trigger LoadTriggerResources
    private trigger EnterTriggerResources

    // line 7: clan savecode
    private framehandle LabelFrameClan
    private framehandle EditBoxClan
    private trigger TriggerEditBoxClan
    private framehandle UpdateButtonFrameClan
    private trigger UpdateTriggerClan
    private framehandle LoadButtonFrameClan
    private trigger LoadTriggerClan
    private trigger EnterTriggerClan
    
    // line 8: savecode dir
    private framehandle LabelFrameDirectory
    private framehandle EditBoxDirectory
    private trigger TriggerEditBoxDirectory
    private framehandle UpdateButtonFrameDirectory
    private trigger UpdateTriggerDirectory
    private framehandle LoadButtonFrameDirectory
    private trigger LoadTriggerDirectory
    private trigger EnterTriggerDirectory

    // end line: all save codes
    private framehandle LabelFrameAll
    private framehandle WriteAllButtonFrameAll
    private trigger WriteAllTriggerAll
    private framehandle LoadAllButtonFrameAll
    private trigger LoadAllTriggerAll
    private framehandle UpdateButtonFrameAll
    private trigger UpdateTriggerAll
    private framehandle LoadButtonFrameAll
    private trigger LoadTriggerAll

    private framehandle CloseButton
    private trigger CloseTrigger

    private trigger SyncTrigger
endglobals

function SetTooltip takes player whichPlayer, string tooltip returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(TooltipLabelFrame, tooltip)
    endif
endfunction

function SetHeroesText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxHeroes, txt)
    endif
endfunction

function GetHeroesText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxHeroes)
endfunction

function UpdateHeroesText takes player whichPlayer returns nothing
    call SetHeroesText(whichPlayer, "-load " + GetSaveCode(whichPlayer))
endfunction

function FormattedSaveCodeHeroes takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-load ")) then
        return StringRemoveFromStart(saveCode, "-load ")
    endif

    return saveCode
endfunction

function SetTooltipHeroesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeHeroes(GetHeroesText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("HEROES_NEW_LINE")).s(GetSaveCodeInfos(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeItems takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadi ")) then
        return StringRemoveFromStart(saveCode, "-loadi ")
    endif

    return saveCode
endfunction

function SetItemsText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxItems, txt)
    endif
endfunction

function GetItemsText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxItems)
endfunction

function UpdateItemsText takes player whichPlayer returns nothing
    call SetItemsText(whichPlayer, "-loadi " + GetSaveCodeItems(whichPlayer))
endfunction

function UpdateItemsTextForIndex takes player whichPlayer, integer index returns nothing
    call SetItemsText(whichPlayer, "-loadi " + GetSaveCodeItemsForIndex(whichPlayer, false, index))
endfunction

function SetTooltipItemsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeItems(GetItemsText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("ITEMS_NEW_LINE")).s(GetSaveCodeInfosItems(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeUnits takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadu ")) then
        return StringRemoveFromStart(saveCode, "-loadu ")
    endif

    return saveCode
endfunction

function SetUnitsText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxUnits, txt)
    endif
endfunction

function GetUnitsText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxUnits)
endfunction

function UpdateUnitsText takes player whichPlayer returns nothing
    call SetUnitsText(whichPlayer, "-loadu " + GetSaveCodeUnits(whichPlayer))
endfunction

function UpdateUnitsTextForIndex takes player whichPlayer, integer index returns nothing
    call SetUnitsText(whichPlayer, "-loadu " + GetSaveCodeUnitsForIndex(whichPlayer, false, index))
endfunction

function SetTooltipUnitsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeUnits(GetUnitsText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("UNITS_NEW_LINE")).s(GetSaveCodeInfosUnits(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeResearches takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadr ")) then
        return StringRemoveFromStart(saveCode, "-loadr ")
    endif

    return saveCode
endfunction

function SetResearchesText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxResearches, txt)
    endif
endfunction

function GetResearchesText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxResearches)
endfunction

function UpdateResearchesText takes player whichPlayer returns nothing
    call SetResearchesText(whichPlayer, "-loadr " + GetSaveCodeResearches(whichPlayer))
endfunction

function UpdateResearchesTextForIndex takes player whichPlayer, integer index returns nothing
    call SetResearchesText(whichPlayer, "-loadr " + GetSaveCodeResearchesForIndex(whichPlayer, false, index))
endfunction

function SetTooltipResearchesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResearches(GetResearchesText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("RESEARCHES_NEW_LINE")).s(GetSaveCodeInfosResearches(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeBuildings takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadb ")) then
        return StringRemoveFromStart(saveCode, "-loadb ")
    endif

    return saveCode
endfunction

function SetBuildingsText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxBuildings, txt)
    endif
endfunction

function GetBuildingsText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxBuildings)
endfunction

function UpdateBuildingsText takes player whichPlayer returns nothing
    call SetBuildingsText(whichPlayer, "-loadb " + GetSaveCodeBuildings(whichPlayer))
endfunction

function UpdateBuildingsTextForIndex takes player whichPlayer, integer index returns nothing
    call SetBuildingsText(whichPlayer, "-loadb " + GetSaveCodeBuildingsForIndex(whichPlayer, false, index))
endfunction

function SetTooltipBuildingsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeBuildings(GetBuildingsText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("BUILDINGS_NEW_LINE")).s(GetSaveCodeInfosBuildings(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeResources takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadres ")) then
        return StringRemoveFromStart(saveCode, "-loadres ")
    endif

    return saveCode
endfunction

function SetResourcesText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxResources, txt)
    endif
endfunction

function GetResourcesText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxResources)
endfunction

function UpdateResourcesText takes player whichPlayer returns nothing
    call SetResourcesText(whichPlayer, "-loadres " + GetSaveCodeResources(whichPlayer))
endfunction

function SetTooltipResourcesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResources(GetResourcesText(whichPlayer))
    call SetTooltip(whichPlayer, Format(GetLocalizedString("RESOURCES_NEW_LINE")).s(GetSaveCodeInfosResources(whichPlayer, saveCode)).result())
endfunction

function FormattedSaveCodeClan takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadc ")) then
        return StringToken(saveCode, 1)
    endif

    return StringToken(saveCode, 0)
endfunction

function FormattedSaveCodeClanName takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadc ")) then
        return StringToken(saveCode, 2)
    endif

    return StringToken(saveCode, 1)
endfunction

function SetClanText takes player whichPlayer, string txt returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(EditBoxClan, txt)
    endif
endfunction

function GetClanText takes player whichPlayer returns string
    return BlzFrameGetText(EditBoxClan)
endfunction

function UpdateClanText takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    if (udg_ClanPlayerClan[convertedPlayerId] > 0) then
        call SetClanText(whichPlayer, "-loadc " + GetSaveCodeClan(udg_ClanPlayerClan[convertedPlayerId]) + " " + udg_ClanName[udg_ClanPlayerClan[convertedPlayerId]])
    endif
endfunction

function SetTooltipClanSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeClan(GetClanText(whichPlayer))
    local string clanName = FormattedSaveCodeClanName(GetClanText(whichPlayer))
    //call BJDebugMsg("Clan name: " + clanName)
    if (StringLength(clanName) > 0) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("RESOURCES_NEW_LINE")).s(GetSaveCodeInfosClan(clanName, saveCode)).result())
    else
        call SetTooltip(whichPlayer, GetLocalizedString("MISSING_CLAN_NAME"))
    endif
endfunction

function UpdateAll takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    call UpdateHeroesText(whichPlayer)
    call UpdateItemsText(whichPlayer)
    set itemsIndex = 0
    call UpdateUnitsText(whichPlayer)
    set unitsIndex = 0
    call UpdateResearchesText(whichPlayer)
    set researchesIndex = 0
    call UpdateBuildingsText(whichPlayer)
    set buildingsIndex = 0
    call UpdateResourcesText(whichPlayer)
    call UpdateClanText(whichPlayer)
    
    if (GetLocalPlayer() == whichPlayer) then
        call BlzFrameSetText(ItemsEditIndex, I2S(itemsIndex))
        call BlzFrameSetText(UnitsEditIndex, I2S(unitsIndex))
        call BlzFrameSetText(ResearchesEditIndex, I2S(researchesIndex))
        call BlzFrameSetText(BuildingsEditIndex, I2S(buildingsIndex))
    endif
endfunction

function LoadHeroes takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeHeroes(input)
    //call BJDebugMsg("Click load heroes")

    if (ApplySaveCode(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadItems takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeItems(input)

    if (ApplySaveCodeItems(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadUnits takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeUnits(input)

    if (ApplySaveCodeUnits(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadResearches takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeResearches(input)

    if (ApplySaveCodeResearches(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadBuildings takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeBuildings(input)
    //call BJDebugMsg("Click load buildings")

    if (ApplySaveCodeBuildings(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadResources takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeBuildings(input)
    //call BJDebugMsg("Click load buildings")

    if (ApplySaveCodeResources(whichPlayer, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function LoadClan takes player whichPlayer, string input returns nothing
    local string saveCode = FormattedSaveCodeClan(input)
    local string clanName = FormattedSaveCodeClanName(input)
    //call BJDebugMsg("Click load buildings")

    if (ApplySaveCodeClan(whichPlayer, clanName, saveCode)) then
        call SetTooltip(whichPlayer, Format(GetLocalizedString("SUCCESSFULLY_LOADED_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    else
        call SetTooltip(whichPlayer, Format(GetLocalizedString("ERROR_ON_LOADING_SAVECODE_X")).s(ColoredSaveCode(saveCode)).result())
    endif
endfunction

function TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer = GetTriggerPlayer()
    local string prefix = BlzGetTriggerSyncPrefix()
    local string data = BlzGetTriggerSyncData()
    local string input = StringTokenEx(data, 1, "_", false)
    local integer playerId = GetPlayerId(whichPlayer)

    //call BJDebugMsg("Sync save code data " + data + " with prefix " + prefix + " with input " + input)

    if (StringStartsWith(data, "LoadHeroes")) then
        call LoadHeroes(whichPlayer, input)
    elseif (StringStartsWith(data, "LoadItems")) then
        call LoadItems(whichPlayer, input)
    elseif (StringStartsWith(data, "LoadUnits")) then
        call LoadUnits(whichPlayer, input)
    elseif (StringStartsWith(data, "LoadResearches")) then
        call LoadResearches(whichPlayer, input)
    elseif (StringStartsWith(data, "LoadBuildings")) then
        call LoadBuildings(whichPlayer, input)
    elseif (StringStartsWith(data, "LoadResources")) then
        call LoadResources(whichPlayer, input)    
    elseif (StringStartsWith(data, "LoadClan")) then
        call LoadClan(whichPlayer, input)
    endif
    set whichPlayer = null
endfunction

function SyncLoadHeroes takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadHeroes_" + GetHeroesText(whichPlayer))
    endif
endfunction

function SyncLoadItems takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadItems_" + GetItemsText(whichPlayer))
    endif
endfunction

function SyncLoadUnits takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadUnits_" + GetUnitsText(whichPlayer))
    endif
endfunction

function SyncLoadResearches takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadResearches_" + GetResearchesText(whichPlayer))
    endif
endfunction

function SyncLoadBuildings takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadBuildings_" + GetBuildingsText(whichPlayer))
    endif
endfunction

function SyncLoadResources takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadResources_" + GetResourcesText(whichPlayer))
    endif
endfunction

function SyncLoadClan takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (GetLocalPlayer() == whichPlayer) then
        call BlzSendSyncData("", "LoadClan_" + GetClanText(whichPlayer))
    endif
endfunction

function SetSaveCodeUIVisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(BackgroundFrame, visible)
    call BlzFrameSetVisible(TitleFrame, visible)
    call BlzFrameSetVisible(TooltipBackgroundFrame, visible)
    call BlzFrameSetVisible(TooltipLabelFrame, visible)
    // heroes
    call BlzFrameSetVisible(LabelFrameHeroes, visible)
    call BlzFrameSetVisible(EditBoxHeroes, visible)
    call BlzFrameSetVisible(UpdateButtonFrameHeroes, visible)
    call BlzFrameSetVisible(LoadButtonFrameHeroes, visible)
    // items
    call BlzFrameSetVisible(LabelFrameItems, visible)
    call BlzFrameSetVisible(ItemsEditIndex, visible)
    call BlzFrameSetVisible(ItemsEditArrowUp, visible)
    call BlzFrameSetVisible(ItemsEditArrowUpFrame, visible)
    call BlzFrameSetVisible(ItemsEditArrowDown, visible)
    call BlzFrameSetVisible(ItemsEditArrowDownFrame, visible)
    call BlzFrameSetVisible(EditBoxItems, visible)
    call BlzFrameSetVisible(UpdateButtonFrameItems, visible)
    call BlzFrameSetVisible(LoadButtonFrameItems, visible)
    // units
    call BlzFrameSetVisible(LabelFrameUnits, visible)
    call BlzFrameSetVisible(UnitsEditIndex, visible)
    call BlzFrameSetVisible(UnitsEditArrowUp, visible)
    call BlzFrameSetVisible(UnitsEditArrowUpFrame, visible)
    call BlzFrameSetVisible(UnitsEditArrowDown, visible)
    call BlzFrameSetVisible(UnitsEditArrowDownFrame, visible)
    call BlzFrameSetVisible(EditBoxUnits, visible)
    call BlzFrameSetVisible(UpdateButtonFrameUnits, visible)
    call BlzFrameSetVisible(LoadButtonFrameUnits, visible)
    // researches
    call BlzFrameSetVisible(LabelFrameResearches, visible)
    call BlzFrameSetVisible(ResearchesEditIndex, visible)
    call BlzFrameSetVisible(ResearchesEditArrowUp, visible)
    call BlzFrameSetVisible(ResearchesEditArrowUpFrame, visible)
    call BlzFrameSetVisible(ResearchesEditArrowDown, visible)
    call BlzFrameSetVisible(ResearchesEditArrowDownFrame, visible)
    call BlzFrameSetVisible(EditBoxResearches, visible)
    call BlzFrameSetVisible(UpdateButtonFrameResearches, visible)
    call BlzFrameSetVisible(LoadButtonFrameResearches, visible)
    // buildings
    call BlzFrameSetVisible(LabelFrameBuildings, visible)
    call BlzFrameSetVisible(BuildingsEditIndex, visible)
    call BlzFrameSetVisible(BuildingsEditArrowUp, visible)
    call BlzFrameSetVisible(BuildingsEditArrowUpFrame, visible)
    call BlzFrameSetVisible(BuildingsEditArrowDown, visible)
    call BlzFrameSetVisible(BuildingsEditArrowDownFrame, visible)
    call BlzFrameSetVisible(EditBoxBuildings, visible)
    call BlzFrameSetVisible(UpdateButtonFrameBuildings, visible)
    call BlzFrameSetVisible(LoadButtonFrameBuildings, visible)
    // resources
    call BlzFrameSetVisible(LabelFrameResources, visible)
    call BlzFrameSetVisible(EditBoxResources, visible)
    call BlzFrameSetVisible(UpdateButtonFrameResources, visible)
    call BlzFrameSetVisible(LoadButtonFrameResources, visible)
    // clan
    call BlzFrameSetVisible(LabelFrameClan, visible)
    call BlzFrameSetVisible(EditBoxClan, visible)
    call BlzFrameSetVisible(UpdateButtonFrameClan, visible)
    call BlzFrameSetVisible(LoadButtonFrameClan, visible)
    // directory
    call BlzFrameSetVisible(LabelFrameDirectory, visible)
    call BlzFrameSetVisible(EditBoxDirectory, visible)
    call BlzFrameSetVisible(UpdateButtonFrameDirectory, visible)
    call BlzFrameSetVisible(LoadButtonFrameDirectory, visible)
    // all
    call BlzFrameSetVisible(LabelFrameAll, visible)
    call BlzFrameSetVisible(WriteAllButtonFrameAll, visible)
    call BlzFrameSetVisible(LoadAllButtonFrameAll, visible)
    call BlzFrameSetVisible(UpdateButtonFrameAll, visible)
    call BlzFrameSetVisible(LoadButtonFrameAll, visible)
    // close
    call BlzFrameSetVisible(CloseButton, visible)
endfunction

function SetSaveCodeUIVisible takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call SetSaveCodeUIVisibleAll(visible)
    endif
    
    if (visible) then
        call UpdateAll(whichPlayer)
    endif
endfunction

function ShowSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, true)
endfunction

function HideSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, false)
endfunction

function HideSaveCodeUIAll takes nothing returns nothing
    call SetSaveCodeUIVisibleAll(false)
endfunction

function EditBoxEnterHeroes takes player whichPlayer returns nothing
    call SetTooltipHeroesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionHeroes takes nothing returns nothing
    call EditBoxEnterHeroes(GetTriggerPlayer())
endfunction

function UpdateFunctionHeroes takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateHeroesText(GetTriggerPlayer())
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_HEROES"))
    endif
endfunction

function LoadFunctionHeroes takes nothing returns nothing
    call SyncLoadHeroes(GetTriggerPlayer())
endfunction

function SaveCodeEnterFunctionItemsIndex takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    set itemsIndex = IMaxBJ(0, IMinBJ(30, S2I(BlzFrameGetText(ItemsEditIndex))))

    call UpdateItemsTextForIndex(GetTriggerPlayer(), itemsIndex)
endfunction

function ItemsUpFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (itemsIndex == 0) then
        set itemsIndex = GetSaveCodeItemsMax()
    else
        set itemsIndex = itemsIndex - 1
    endif
    
     if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(ItemsEditIndex, I2S(itemsIndex))
    endif
    
    call UpdateItemsTextForIndex(GetTriggerPlayer(), itemsIndex)
endfunction

function ItemsDownFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (itemsIndex == GetSaveCodeItemsMax()) then
        set itemsIndex = 0
    else
        set itemsIndex = itemsIndex + 1
    endif
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(ItemsEditIndex, I2S(itemsIndex))
    endif
    
    call UpdateItemsTextForIndex(GetTriggerPlayer(), itemsIndex)
endfunction

function EditBoxEnterItems takes player whichPlayer returns nothing
    call SetTooltipItemsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionItems takes nothing returns nothing
    call EditBoxEnterItems(GetTriggerPlayer())
endfunction

function UpdateFunctionItems takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateItemsText(GetTriggerPlayer())
    call SetTooltip(GetTriggerPlayer(), GetLocalizedString("UPDATED_SAVE_CODES_ITEMS"))
endfunction

function LoadFunctionItems takes nothing returns nothing
    call SyncLoadItems(GetTriggerPlayer())
endfunction

function SaveCodeEnterFunctionUnitsIndex takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    set unitsIndex = IMaxBJ(0, IMinBJ(30, S2I(BlzFrameGetText(UnitsEditIndex))))

    call UpdateUnitsTextForIndex(GetTriggerPlayer(), unitsIndex)
endfunction

function UnitsUpFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (unitsIndex == 0) then
        set unitsIndex = GetSaveCodeUnitsMax()
    else
        set unitsIndex = unitsIndex - 1
    endif
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetText(UnitsEditIndex, I2S(unitsIndex))
    endif
    
    call UpdateUnitsTextForIndex(GetTriggerPlayer(), unitsIndex)
endfunction

function UnitsDownFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (unitsIndex == GetSaveCodeUnitsMax()) then
        set unitsIndex = 0
    else
        set unitsIndex = unitsIndex + 1
    endif
    
    if (GetTriggerPlayer() == GetLocalPlayer()) then
        call BlzFrameSetText(UnitsEditIndex, I2S(unitsIndex))
    endif
    
    call UpdateUnitsTextForIndex(GetTriggerPlayer(), unitsIndex)
endfunction

function EditBoxEnterUnits takes player whichPlayer returns nothing
    call SetTooltipUnitsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionUnits takes nothing returns nothing
    call EditBoxEnterUnits(GetTriggerPlayer())
endfunction

function UpdateFunctionUnits takes nothing returns nothing
    //call BJDebugMsg("Click update units")
    call UpdateUnitsText(GetTriggerPlayer())
     if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_UNITS"))
    endif
endfunction

function LoadFunctionUnits takes nothing returns nothing
    call SyncLoadUnits(GetTriggerPlayer())
endfunction

function SaveCodeEnterFunctionResearchesIndex takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    set researchesIndex = IMaxBJ(0, IMinBJ(30, S2I(BlzFrameGetText(ResearchesEditIndex))))

    call UpdateResearchesTextForIndex(GetTriggerPlayer(), researchesIndex)
endfunction

function ResearchesUpFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (researchesIndex == 0) then
        set researchesIndex = GetSaveCodeResearchesMax()
    else
        set researchesIndex = researchesIndex - 1
    endif
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(ResearchesEditIndex, I2S(researchesIndex))
    endif
    
    call UpdateResearchesTextForIndex(GetTriggerPlayer(), researchesIndex)
endfunction

function ResearchesDownFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (researchesIndex == GetSaveCodeResearchesMax()) then
        set researchesIndex = 0
    else
        set researchesIndex = researchesIndex + 1
    endif
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(ResearchesEditIndex, I2S(researchesIndex))
    endif
    
    call UpdateResearchesTextForIndex(GetTriggerPlayer(), researchesIndex)
endfunction

function EditBoxEnterResearches takes player whichPlayer returns nothing
     call SetTooltipResearchesSaveCodeInfo(whichPlayer)
endfunction

function EnterFunctionResearches takes nothing returns nothing
    call EditBoxEnterResearches(GetTriggerPlayer())
endfunction

function UpdateFunctionResearches takes nothing returns nothing
    //call BJDebugMsg("Click update researches")
    call UpdateResearchesText(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_RESEARCHES"))
    endif
endfunction

function LoadFunctionResearches takes nothing returns nothing
    call SyncLoadResearches(GetTriggerPlayer())
endfunction

function SaveCodeEnterFunctionBuildingsIndex takes nothing returns nothing
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    set researchesIndex = IMaxBJ(0, IMinBJ(30, S2I(BlzFrameGetText(BuildingsEditIndex))))

    call UpdateBuildingsTextForIndex(GetTriggerPlayer(), researchesIndex)
endfunction

function BuildingsUpFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (buildingsIndex == 0) then
        set buildingsIndex = GetSaveCodeBuildingsMax()
    else
        set buildingsIndex = buildingsIndex - 1
    endif
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(BuildingsEditIndex, I2S(buildingsIndex))
    endif
    
    call UpdateBuildingsTextForIndex(GetTriggerPlayer(), buildingsIndex)
endfunction

function BuildingsDownFunction takes nothing returns nothing
    local integer playerId = GetPlayerId(GetTriggerPlayer())
    
    call PlayClickSound(GetTriggerPlayer())
    
    if (buildingsIndex == GetSaveCodeBuildingsMax()) then
        set buildingsIndex = 0
    else
        set buildingsIndex = buildingsIndex + 1
    endif
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(BuildingsEditIndex, I2S(buildingsIndex))
    endif
    
    call UpdateBuildingsTextForIndex(GetTriggerPlayer(), buildingsIndex)
endfunction

function EditBoxEnterBuildings takes player whichPlayer returns nothing
    call SetTooltipBuildingsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionBuildings takes nothing returns nothing
    call EditBoxEnterBuildings(GetTriggerPlayer())
endfunction

function UpdateFunctionBuildings takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateBuildingsText(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_BUILDINGS"))
    endif
endfunction

function LoadFunctionBuildings takes nothing returns nothing
    call SyncLoadBuildings(GetTriggerPlayer())
endfunction


function EditBoxEnterResources takes player whichPlayer returns nothing
    call SetTooltipResourcesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionResources takes nothing returns nothing
    call EditBoxEnterResources(GetTriggerPlayer())
endfunction

function UpdateFunctionResources takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateResourcesText(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_RESEARCHES"))
    endif
endfunction

function LoadFunctionResources takes nothing returns nothing
    call SyncLoadResources(GetTriggerPlayer())
endfunction

function EditBoxEnterClan takes player whichPlayer returns nothing
    call SetTooltipClanSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionClan takes nothing returns nothing
    call EditBoxEnterClan(GetTriggerPlayer())
endfunction

function UpdateFunctionClan takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateClanText(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODE_CLAN"))
    endif
endfunction

function LoadFunctionClan takes nothing returns nothing
    call SyncLoadClan(GetTriggerPlayer())
endfunction

function EditBoxEnterDirectory takes player whichPlayer returns nothing
    call SetTooltip(whichPlayer, GetLocalizedString("SAVE_CODE_DIRECTORY_INFO"))
endfunction

function SaveCodeEnterFunctionDirectory takes nothing returns nothing
    call EditBoxEnterDirectory(GetTriggerPlayer())
endfunction

function LoadAllFunctionAll takes nothing returns nothing
    local string fileName = GetSaveCodeAllFileNameForPlayer(GetTriggerPlayer())
    //call BJDebugMsg("Click load auto")
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, Format(GetLocalizedString("TRYING_TO_LOAD_SAVECODES_FROM_X")).s(fileName).result())
    endif
    call GetSaveCodeAllTextFile(GetTriggerPlayer())
endfunction

function WriteAllFunctionAll takes nothing returns nothing
    local string fileName = GetSaveCodeAllFileNameForPlayer(GetTriggerPlayer())
    //call BJDebugMsg("Click write auto")
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, Format(GetLocalizedString("SAVED_ALL_SAVE_CODES_INTO_X")).s(fileName).result())
    endif
    call CreateSaveCodeAllTextFile(GetTriggerPlayer())
endfunction

private function UpdateFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click update all")
    call UpdateAll(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("UPDATED_SAVE_CODES_ALL"))
    endif
endfunction

private function LoadFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click load all")
    call SyncLoadHeroes(GetTriggerPlayer())
    call SyncLoadItems(GetTriggerPlayer())
    call SyncLoadUnits(GetTriggerPlayer())
    call SyncLoadResearches(GetTriggerPlayer())
    call SyncLoadBuildings(GetTriggerPlayer())
    call SyncLoadClan(GetTriggerPlayer())
    
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call BlzFrameSetText(TooltipLabelFrame, GetLocalizedString("TRIED_TO_LOAD_ALL_SAVE_CODES"))
    endif
endfunction

private function CloseFunction takes nothing returns nothing
    call HideSaveCodeUI(GetTriggerPlayer())
endfunction

private function CreateSaveCodeUI takes nothing returns nothing
    local real x = 0.0
    local real y = 0.0

    set BackgroundFrame = CreateFullScreenFrame()

    set TitleFrame = CreateFullScreenTitle("SaveGuiTitle", GetLocalizedString("SAVE_CODES"))

    set TooltipBackgroundFrame = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(TooltipBackgroundFrame, FRAMEPOINT_TOPLEFT, TOOLTIP_X, LINE_START_Y)
    call BlzFrameSetAbsPoint(TooltipBackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_X + TOOLTIP_WIDTH, LINE_START_Y - TOOLTIP_HEIGHT)

    set TooltipLabelFrame = BlzCreateFrameByType("TEXT", "SaveGuiTooltipLabel", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(TooltipLabelFrame, FRAMEPOINT_TOPLEFT, TOOLTIP_LABEL_X, TOOLTIP_LABEL_Y)
    call BlzFrameSetAbsPoint(TooltipLabelFrame, FRAMEPOINT_BOTTOMRIGHT, TOOLTIP_LABEL_X + TOOLTIP_LABEL_WIDTH, TOOLTIP_LABEL_Y - TOOLTIP_LABEL_HEIGHT)
    call BlzFrameSetText(TooltipLabelFrame, "Save Code Info")
    call BlzFrameSetTextAlignment(TooltipLabelFrame, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    // line 1: heroes
    set y = LINE_START_Y

    set LabelFrameHeroes = BlzCreateFrameByType("TEXT", "SaveGuiLabelHeroes", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameHeroes, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameHeroes, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameHeroes, GetLocalizedString("COLON_HEROES")) // "|cffFFCC00Heroes:|r"
    call BlzFrameSetTextAlignment(LabelFrameHeroes, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxHeroes = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxHeroes, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxHeroes, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxHeroes, "-load xxx")

    set TriggerEditBoxHeroes = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxHeroes, function SaveCodeEnterFunctionHeroes)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxHeroes, EditBoxHeroes, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerHeroes = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerHeroes, EditBoxHeroes, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerHeroes, function SaveCodeEnterFunctionHeroes)

    set UpdateButtonFrameHeroes = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameHeroes, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameHeroes, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameHeroes, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerHeroes = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerHeroes, UpdateButtonFrameHeroes, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerHeroes, function UpdateFunctionHeroes)

    set LoadButtonFrameHeroes = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameHeroes, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameHeroes, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameHeroes, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerHeroes = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerHeroes, LoadButtonFrameHeroes, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerHeroes, function LoadFunctionHeroes)

    // line 2: items
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameItems = BlzCreateFrameByType("TEXT", "SaveGuiLabelItems", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameItems, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameItems, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameItems, GetLocalizedString("COLON_ITEMS"))
    call BlzFrameSetTextAlignment(LabelFrameItems, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxItems = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxItems, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxItems, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxItems, "-load xxx")

    set TriggerEditBoxItems = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxItems, function SaveCodeEnterFunctionItems)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxItems, EditBoxItems, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerItems = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerItems, EditBoxItems, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerItems, function SaveCodeEnterFunctionItems)

    set UpdateButtonFrameItems = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameItems, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameItems, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameItems, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerItems = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerItems, UpdateButtonFrameItems, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerItems, function UpdateFunctionItems)

    set LoadButtonFrameItems = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameItems, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameItems, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameItems, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerItems = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerItems, LoadButtonFrameItems, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerItems, function LoadFunctionItems)
    
    set ItemsEditIndex = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ItemsEditIndex, FRAMEPOINT_TOPLEFT, INDEX_X, y)
    call BlzFrameSetAbsPoint(ItemsEditIndex, FRAMEPOINT_BOTTOMRIGHT, INDEX_X + INDEX_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(ItemsEditIndex, "0")

    set TriggerEditBoxItemsIndex = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxItemsIndex, function SaveCodeEnterFunctionItemsIndex)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxItemsIndex, ItemsEditIndex, FRAMEEVENT_EDITBOX_ENTER)
    
    set ItemsEditArrowUp = BlzCreateFrameByType("BUTTON", "ItemsUpButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(ItemsEditArrowUp, FRAMEPOINT_TOPLEFT, BUTTON_UP_X, y)
    call BlzFrameSetAbsPoint(ItemsEditArrowUp, FRAMEPOINT_BOTTOMRIGHT, BUTTON_UP_X + BUTTON_UP_WIDTH, y - LINE_HEIGHT)
    
    set ItemsEditArrowUpFrame = BlzCreateFrameByType("BACKDROP", "ItemsUpFrame", ItemsEditArrowUp, "", 0)
    call BlzFrameSetAllPoints(ItemsEditArrowUpFrame, ItemsEditArrowUp)
    call BlzFrameSetTexture(ItemsEditArrowUpFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)

    set ItemsUpTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ItemsUpTrigger, ItemsEditArrowUp, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ItemsUpTrigger, function ItemsUpFunction)
            
    set ItemsEditArrowDown = BlzCreateFrameByType("BUTTON", "ItemsDownButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(ItemsEditArrowDown, FRAMEPOINT_TOPLEFT, BUTTON_DOWN_X, y)
    call BlzFrameSetAbsPoint(ItemsEditArrowDown, FRAMEPOINT_BOTTOMRIGHT, BUTTON_DOWN_X + BUTTON_DOWN_WIDTH, y - LINE_HEIGHT)

    set ItemsEditArrowDownFrame = BlzCreateFrameByType("BACKDROP", "ItemsDownFrame", ItemsEditArrowDown, "", 0)
    call BlzFrameSetAllPoints(ItemsEditArrowDownFrame, ItemsEditArrowDown)
    call BlzFrameSetTexture(ItemsEditArrowDownFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)

    set ItemsDownTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ItemsDownTrigger, ItemsEditArrowDown, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ItemsDownTrigger, function ItemsDownFunction)

    // line 3: units
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameUnits = BlzCreateFrameByType("TEXT", "SaveGuiLabelUnits", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameUnits, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameUnits, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameUnits, GetLocalizedString("COLON_UNITS"))
    call BlzFrameSetTextAlignment(LabelFrameUnits, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    
    set EditBoxUnits = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxUnits, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxUnits, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxUnits, "-load xxx")
    
    set TriggerEditBoxUnits = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxUnits, function SaveCodeEnterFunctionUnits)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxUnits, EditBoxUnits, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerUnits = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerUnits, EditBoxUnits, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerUnits, function SaveCodeEnterFunctionUnits)

    set UpdateButtonFrameUnits = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameUnits, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameUnits, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameUnits, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerUnits = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerUnits, UpdateButtonFrameUnits, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerUnits, function UpdateFunctionUnits)

    set LoadButtonFrameUnits = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameUnits, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameUnits, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameUnits, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerUnits = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerUnits, LoadButtonFrameUnits, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerUnits, function LoadFunctionUnits)
    
    set UnitsEditIndex = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UnitsEditIndex, FRAMEPOINT_TOPLEFT, INDEX_X, y)
    call BlzFrameSetAbsPoint(UnitsEditIndex, FRAMEPOINT_BOTTOMRIGHT, INDEX_X + INDEX_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UnitsEditIndex, "0")

    set TriggerEditBoxUnitsIndex = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxUnitsIndex, function SaveCodeEnterFunctionUnitsIndex)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxUnitsIndex, UnitsEditIndex, FRAMEEVENT_EDITBOX_ENTER)
    
    set UnitsEditArrowUp = BlzCreateFrameByType("BUTTON", "UnitsUpButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(UnitsEditArrowUp, FRAMEPOINT_TOPLEFT, BUTTON_UP_X, y)
    call BlzFrameSetAbsPoint(UnitsEditArrowUp, FRAMEPOINT_BOTTOMRIGHT, BUTTON_UP_X + BUTTON_UP_WIDTH, y - LINE_HEIGHT)

    set UnitsEditArrowUpFrame = BlzCreateFrameByType("BACKDROP", "UnitsUpFrame", UnitsEditArrowUp, "", 0)
    call BlzFrameSetAllPoints(UnitsEditArrowUpFrame, UnitsEditArrowUp)
    call BlzFrameSetTexture(UnitsEditArrowUpFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)

    set UnitsUpTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UnitsUpTrigger, UnitsEditArrowUp, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UnitsUpTrigger, function UnitsUpFunction)
            
    set UnitsEditArrowDown = BlzCreateFrameByType("BUTTON", "UnitsDownButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(UnitsEditArrowDown, FRAMEPOINT_TOPLEFT, BUTTON_DOWN_X, y)
    call BlzFrameSetAbsPoint(UnitsEditArrowDown, FRAMEPOINT_BOTTOMRIGHT, BUTTON_DOWN_X + BUTTON_DOWN_WIDTH, y - LINE_HEIGHT)

    set UnitsEditArrowDownFrame = BlzCreateFrameByType("BACKDROP", "UnitsDownFrame", UnitsEditArrowDown, "", 0)
    call BlzFrameSetAllPoints(UnitsEditArrowDownFrame, UnitsEditArrowDown)
    call BlzFrameSetTexture(UnitsEditArrowDownFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)

    set UnitsDownTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UnitsDownTrigger, UnitsEditArrowDown, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UnitsDownTrigger, function UnitsDownFunction)

    // line 4: researches
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameResearches = BlzCreateFrameByType("TEXT", "SaveGuiLabelResearches", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameResearches, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameResearches, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameResearches, GetLocalizedString("COLON_RESEARCHES"))
    call BlzFrameSetTextAlignment(LabelFrameResearches, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxResearches = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxResearches, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxResearches, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxResearches, "-load xxx")

    set TriggerEditBoxResearches = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxResearches, function EnterFunctionResearches)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxResearches, EditBoxResearches, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerResearches = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerResearches, EditBoxResearches, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerResearches, function EnterFunctionResearches)

    set UpdateButtonFrameResearches = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameResearches, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameResearches, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameResearches, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerResearches = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerResearches, UpdateButtonFrameResearches, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerResearches, function UpdateFunctionResearches)

    set LoadButtonFrameResearches = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameResearches, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameResearches, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameResearches, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerResearches = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerResearches, LoadButtonFrameResearches, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerResearches, function LoadFunctionResearches)

    set ResearchesEditIndex = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ResearchesEditIndex, FRAMEPOINT_TOPLEFT, INDEX_X, y)
    call BlzFrameSetAbsPoint(ResearchesEditIndex, FRAMEPOINT_BOTTOMRIGHT, INDEX_X + INDEX_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(ResearchesEditIndex, "0")

    set TriggerEditBoxResearchesIndex = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxResearchesIndex, function SaveCodeEnterFunctionResearchesIndex)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxResearchesIndex, ResearchesEditIndex, FRAMEEVENT_EDITBOX_ENTER)
    
    set ResearchesEditArrowUp = BlzCreateFrameByType("BUTTON", "ResearchesUpButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(ResearchesEditArrowUp, FRAMEPOINT_TOPLEFT, BUTTON_UP_X, y)
    call BlzFrameSetAbsPoint(ResearchesEditArrowUp, FRAMEPOINT_BOTTOMRIGHT, BUTTON_UP_X + BUTTON_UP_WIDTH, y - LINE_HEIGHT)

    set ResearchesEditArrowUpFrame = BlzCreateFrameByType("BACKDROP", "ResearchesUpFrame", ResearchesEditArrowUp, "", 0)
    call BlzFrameSetAllPoints(ResearchesEditArrowUpFrame, ResearchesEditArrowUp)
    call BlzFrameSetTexture(ResearchesEditArrowUpFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)

    set ResearchesUpTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ResearchesUpTrigger, ResearchesEditArrowUp, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ResearchesUpTrigger, function ResearchesUpFunction)
            
    set ResearchesEditArrowDown = BlzCreateFrameByType("BUTTON", "ResearchesDownButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(ResearchesEditArrowDown, FRAMEPOINT_TOPLEFT, BUTTON_DOWN_X, y)
    call BlzFrameSetAbsPoint(ResearchesEditArrowDown, FRAMEPOINT_BOTTOMRIGHT, BUTTON_DOWN_X + BUTTON_DOWN_WIDTH, y - LINE_HEIGHT)

    set ResearchesEditArrowDownFrame = BlzCreateFrameByType("BACKDROP", "ResearchesDownFrame", ResearchesEditArrowDown, "", 0)
    call BlzFrameSetAllPoints(ResearchesEditArrowDownFrame, ResearchesEditArrowDown)
    call BlzFrameSetTexture(ResearchesEditArrowDownFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)

    set ResearchesDownTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(ResearchesDownTrigger, ResearchesEditArrowDown, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(ResearchesDownTrigger, function ResearchesDownFunction)

    // line 4: buildings
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameBuildings = BlzCreateFrameByType("TEXT", "SaveGuiLabelBuildings", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameBuildings, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameBuildings, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameBuildings, GetLocalizedString("COLON_BUILDINGS"))
    call BlzFrameSetTextAlignment(LabelFrameBuildings, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxBuildings = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxBuildings, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxBuildings, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxBuildings, "-load xxx")

    set TriggerEditBoxBuildings = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxBuildings, function SaveCodeEnterFunctionBuildings)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxBuildings, EditBoxBuildings, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerBuildings = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerBuildings, EditBoxBuildings, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerBuildings, function SaveCodeEnterFunctionBuildings)

    set UpdateButtonFrameBuildings = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameBuildings, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameBuildings, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameBuildings, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerBuildings = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerBuildings, UpdateButtonFrameBuildings, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerBuildings, function UpdateFunctionBuildings)

    set LoadButtonFrameBuildings = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameBuildings, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameBuildings, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameBuildings, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerBuildings = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerBuildings, LoadButtonFrameBuildings, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerBuildings, function LoadFunctionBuildings)
    
    set BuildingsEditIndex = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BuildingsEditIndex, FRAMEPOINT_TOPLEFT, INDEX_X, y)
    call BlzFrameSetAbsPoint(BuildingsEditIndex, FRAMEPOINT_BOTTOMRIGHT, INDEX_X + INDEX_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(BuildingsEditIndex, "0")

    set TriggerEditBoxBuildingsIndex = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxBuildingsIndex, function SaveCodeEnterFunctionBuildingsIndex)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxBuildingsIndex, BuildingsEditIndex, FRAMEEVENT_EDITBOX_ENTER)
    
    set BuildingsEditArrowUp = BlzCreateFrameByType("BUTTON", "BuildingsUpButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(BuildingsEditArrowUp, FRAMEPOINT_TOPLEFT, BUTTON_UP_X, y)
    call BlzFrameSetAbsPoint(BuildingsEditArrowUp, FRAMEPOINT_BOTTOMRIGHT, BUTTON_UP_X + BUTTON_UP_WIDTH, y - LINE_HEIGHT)

    set BuildingsEditArrowUpFrame = BlzCreateFrameByType("BACKDROP", "BuildingsUpFrame", BuildingsEditArrowUp, "", 0)
    call BlzFrameSetAllPoints(BuildingsEditArrowUpFrame, BuildingsEditArrowUp)
    call BlzFrameSetTexture(BuildingsEditArrowUpFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedUp.blp", 0, true)

    set BuildingsUpTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BuildingsUpTrigger, BuildingsEditArrowUp, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BuildingsUpTrigger, function BuildingsUpFunction)
            
    set BuildingsEditArrowDown = BlzCreateFrameByType("BUTTON", "BuildingsDownButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "ScoreScreenTabButtonTemplate", 0)
    call BlzFrameSetAbsPoint(BuildingsEditArrowDown, FRAMEPOINT_TOPLEFT, BUTTON_DOWN_X, y)
    call BlzFrameSetAbsPoint(BuildingsEditArrowDown, FRAMEPOINT_BOTTOMRIGHT, BUTTON_DOWN_X + BUTTON_DOWN_WIDTH, y - LINE_HEIGHT)

    set BuildingsEditArrowDownFrame = BlzCreateFrameByType("BACKDROP", "BuildingsDownFrame", BuildingsEditArrowDown, "", 0)
    call BlzFrameSetAllPoints(BuildingsEditArrowDownFrame, BuildingsEditArrowDown)
    call BlzFrameSetTexture(BuildingsEditArrowDownFrame, "ReplaceableTextures\\CommandButtons\\BTNReplay-SpeedDown.blp", 0, true)

    set BuildingsDownTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BuildingsDownTrigger, BuildingsEditArrowDown, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BuildingsDownTrigger, function BuildingsDownFunction)
    
    // line 5: resources
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameResources = BlzCreateFrameByType("TEXT", "SaveGuiLabelResources", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameResources, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameResources, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameResources, GetLocalizedString("COLON_RESOURCES"))
    call BlzFrameSetTextAlignment(LabelFrameResources, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxResources = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxResources, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxResources, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxResources, "-loadres xxx")
    
    set TriggerEditBoxResources = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxResources, function SaveCodeEnterFunctionResources)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxResources, EditBoxResources, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerResources = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerResources, EditBoxResources, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerResources, function SaveCodeEnterFunctionResources)

    set UpdateButtonFrameResources = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameResources, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameResources, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameResources, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerResources = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerResources, UpdateButtonFrameResources, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerResources, function UpdateFunctionResources)

    set LoadButtonFrameResources = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameResources, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameResources, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameResources, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerResources = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerResources, LoadButtonFrameResources, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerResources, function LoadFunctionResources)

    // line 6: clan
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameClan = BlzCreateFrameByType("TEXT", "SaveGuiLabelClan", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameClan, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameClan, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameClan, GetLocalizedString("COLON_CLAN"))
    call BlzFrameSetTextAlignment(LabelFrameClan, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxClan = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxClan, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxClan, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxClan, "-loadc xxx")

    set TriggerEditBoxClan = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxClan, function SaveCodeEnterFunctionClan)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxClan, EditBoxClan, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerClan = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerClan, EditBoxClan, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerClan, function SaveCodeEnterFunctionClan)

    set UpdateButtonFrameClan = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameClan, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameClan, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameClan, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerClan = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerClan, UpdateButtonFrameClan, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerClan, function UpdateFunctionClan)

    set LoadButtonFrameClan = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameClan, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameClan, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameClan, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerClan = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerClan, LoadButtonFrameClan, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerClan, function LoadFunctionClan)
    
    // line 7: directory
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameDirectory = BlzCreateFrameByType("TEXT", "SaveGuiLabelDirectory", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameDirectory, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameDirectory, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameDirectory, GetLocalizedString("COLON_DIRECTORY"))
    call BlzFrameSetTextAlignment(LabelFrameDirectory, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    set EditBoxDirectory = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(EditBoxDirectory, FRAMEPOINT_TOPLEFT, LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(EditBoxDirectory, FRAMEPOINT_BOTTOMRIGHT, LINEEDIT_X + LINEEDIT_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(EditBoxDirectory, USER_SAVE_CODE_FOLDER)

    set TriggerEditBoxDirectory = CreateTrigger()
    call TriggerAddAction(TriggerEditBoxDirectory, function SaveCodeEnterFunctionDirectory)
    call BlzTriggerRegisterFrameEvent(TriggerEditBoxDirectory, EditBoxDirectory, FRAMEEVENT_EDITBOX_ENTER)

    set EnterTriggerDirectory = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(EnterTriggerDirectory, EditBoxDirectory, FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(EnterTriggerDirectory, function SaveCodeEnterFunctionDirectory)
    
    set UpdateButtonFrameDirectory = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameDirectory, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameDirectory, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameDirectory, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerDirectory = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerDirectory, UpdateButtonFrameDirectory, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerDirectory, function UpdateFunctionAll)

    set LoadButtonFrameDirectory = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameDirectory, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameDirectory, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameDirectory, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerDirectory = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerDirectory, LoadButtonFrameDirectory, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerDirectory, function LoadFunctionAll)

    // final line: all
    set y = y - LINE_HEIGHT - LINE_SPACING

    set LabelFrameAll = BlzCreateFrameByType("TEXT", "SaveGuiLabelAll", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(LabelFrameAll, FRAMEPOINT_TOPLEFT, LABEL_X, y)
    call BlzFrameSetAbsPoint(LabelFrameAll, FRAMEPOINT_BOTTOMRIGHT, LABEL_X + LABEL_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LabelFrameAll, GetLocalizedString("COLON_ALL"))
    call BlzFrameSetTextAlignment(LabelFrameAll, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    
    set LoadAllButtonFrameAll = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadAllButtonFrameAll, FRAMEPOINT_TOPLEFT, LOAD_AUTO_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadAllButtonFrameAll, FRAMEPOINT_BOTTOMRIGHT, LOAD_AUTO_BUTTON_X + LOAD_AUTO_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadAllButtonFrameAll, GetLocalizedString("LOAD_ALL_YELLOW"))

    set LoadAllTriggerAll = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadAllTriggerAll, LoadAllButtonFrameAll, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadAllTriggerAll, function LoadAllFunctionAll)

    set WriteAllButtonFrameAll = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(WriteAllButtonFrameAll, FRAMEPOINT_TOPLEFT, WRITE_AUTO_BUTTON_X, y)
    call BlzFrameSetAbsPoint(WriteAllButtonFrameAll, FRAMEPOINT_BOTTOMRIGHT, WRITE_AUTO_BUTTON_X + WRITE_AUTO_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(WriteAllButtonFrameAll, GetLocalizedString("WRITE_ALL_YELLOW"))

    set WriteAllTriggerAll = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(WriteAllTriggerAll, WriteAllButtonFrameAll, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(WriteAllTriggerAll, function WriteAllFunctionAll)

    set UpdateButtonFrameAll = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(UpdateButtonFrameAll, FRAMEPOINT_TOPLEFT, UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(UpdateButtonFrameAll, FRAMEPOINT_BOTTOMRIGHT, UPDATE_BUTTON_X + UPDATE_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(UpdateButtonFrameAll, GetLocalizedString("UPDATE_YELLOW"))

    set UpdateTriggerAll = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(UpdateTriggerAll, UpdateButtonFrameAll, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(UpdateTriggerAll, function UpdateFunctionAll)

    set LoadButtonFrameAll = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LoadButtonFrameAll, FRAMEPOINT_TOPLEFT, LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(LoadButtonFrameAll, FRAMEPOINT_BOTTOMRIGHT, LOAD_BUTTON_X + LOAD_BUTTON_WIDTH, y - LINE_HEIGHT)
    call BlzFrameSetText(LoadButtonFrameAll, GetLocalizedString("LOAD_YELLOW"))

    set LoadTriggerAll = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LoadTriggerAll, LoadButtonFrameAll, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LoadTriggerAll, function LoadFunctionAll)

    set CloseButton = CreateFullScreenCloseButton()
    set CloseTrigger = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(CloseTrigger, CloseButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(CloseTrigger, function CloseFunction)

    // hide for all players
    call HideSaveCodeUIAll()
endfunction

private function Init takes nothing returns nothing
    set SyncTrigger = CreateTrigger()
    call TriggerRegisterAnyPlayerSyncEvent(SyncTrigger, "", false)
    call TriggerAddAction(SyncTrigger, function TriggerActionSyncData)
    
    call OnStartGame(function CreateSaveCodeUI)
    
    call FrameLoaderAdd(function CreateSaveCodeUI)
    
static if (LIBRARY_FrameSaver) then
    //call FrameSaverAdd(function HideSaveCodeUIAll)
endif
endfunction

endlibrary
