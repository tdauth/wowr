library WoWReforgedMapCheatSaveCodes requires WoWReforgedSaveCodes

function GetSaveCodeStrong takes string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns string
    return GetSaveCodeEx(GetTriggerPlayer(), playerName, singlePlayer, warlord, xpRate, 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3)
endfunction

function GetSaveCodeNormal takes string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns string
    return GetSaveCodeEx(GetTriggerPlayer(), playerName, singlePlayer, warlord, xpRate, 30, 50000, 30, 50000, 30, 50000, 100000, 100000, 30, 0, 2)
endfunction

function ForGroupRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function GetSaveCodeBase takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allBuildings = CreateGroup()
    local string result
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'htow', GetRectCenterX(gg_rct_Save_Code_Town_Hall), GetRectCenterY(gg_rct_Save_Code_Town_Hall), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_1), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_1), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_2), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_2), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'halt', GetRectCenterX(gg_rct_Save_Code_Altar), GetRectCenterY(gg_rct_Save_Code_Altar), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hlum', GetRectCenterX(gg_rct_Save_Code_Lumber_Mill), GetRectCenterY(gg_rct_Save_Code_Lumber_Mill), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hvlt', GetRectCenterX(gg_rct_Save_Code_Arcane_Vault), GetRectCenterY(gg_rct_Save_Code_Arcane_Vault), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'harm', GetRectCenterX(gg_rct_Save_Code_Workshop), GetRectCenterY(gg_rct_Save_Code_Workshop), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hbar', GetRectCenterX(gg_rct_Save_Code_Barracks), GetRectCenterY(gg_rct_Save_Code_Barracks), bj_UNIT_FACING))

    set result = GetSaveCodeBuildingsEx2(playerName, singlePlayer, warlord, 100, true, 0, whichPlayer, allBuildings)

    call ForGroup(allBuildings, function ForGroupRemoveUnit)

    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function CreateAllDragons takes player whichPlayer returns group
    local location tmpLocation = Location(0.0, 0.0)
    local group allDragons = CreateGroup()
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nrwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'ngrd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nadr', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbzd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nndr', whichPlayer, tmpLocation, 0.0), allDragons)

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return allDragons
endfunction

function GetSaveCodeDragonUnits takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allDragons = CreateAllDragons(whichPlayer)
    local group allDragonsDistinct = DistinctGroup(allDragons)
    local string result = GetSaveCodeUnitsEx2(playerName, singlePlayer, warlord, 100, true, 0, whichPlayer, allDragonsDistinct)

    call ForGroup(allDragons, function ForGroupRemoveUnit)

    call GroupClear(allDragons)
    call DestroyGroup(allDragons)
    set allDragons = null

    call GroupClear(allDragonsDistinct)
    call DestroyGroup(allDragonsDistinct)
    set allDragonsDistinct = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function GetSaveCodeGoodItems takes string playerName, boolean singlePlayer, boolean warlord returns string
    local item item0 = CreateItem('gcel', 0.0, 0.0)
    local item item1 = CreateItem('pnvu', 0.0, 0.0)
    local item item2 = CreateItem('sres', 0.0, 0.0)
    local item item3 = CreateItem('ankh', 0.0, 0.0)
    local item item4 = CreateItem('whwd', 0.0, 0.0)
    local item item5 = CreateItem('hlst', 0.0, 0.0)
    local string result

    call SetItemCharges(item0, 100)
    call SetItemCharges(item1, 100)
    call SetItemCharges(item2, 100)
    call SetItemCharges(item3, 100)
    call SetItemCharges(item4, 100)
    call SetItemCharges(item5, 100)

    set result = GetSaveCodeItemsEx2(playerName, singlePlayer, warlord, 100, true, 0, item0, item1, item2, item3, item4, item5)

    call RemoveItem(item0)
    set item0 = null

    call RemoveItem(item1)
    set item1 = null

    call RemoveItem(item2)
    set item2 = null

    call RemoveItem(item3)
    set item3 = null

    call RemoveItem(item4)
    set item4 = null

    call RemoveItem(item5)
    set item5 = null

    return result
endfunction

function GetSaveCodeHumanUpgrades takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local integer ironForgedSwordsLevel = GetPlayerTechCountSimple('Rhme', whichPlayer)
    local string result

    call SetPlayerTechResearched(whichPlayer, 'Rhme', 3)

    set result = GetSaveCodeResearchesEx(playerName, singlePlayer, warlord, 100, true, 0, whichPlayer)

    call SetPlayerTechResearched(whichPlayer, 'Rhme', ironForgedSwordsLevel)

    return result
endfunction

globals
    private player generateSaveCodePlayer
    private string generateSaveCodePlayerName
    private boolean generateSaveCodeSinglePlayer
    private boolean generateSaveCodeWarlord
    private integer generateSaveCodeXpRate
endglobals

function GenerateSaveCode takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns nothing
    call GetSaveCodeStrong(playerName, singlePlayer, warlord, xpRate)
    call GetSaveCodeNormal(playerName, singlePlayer, warlord, xpRate)
    call GetSaveCodeBase(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeDragonUnits(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeGoodItems(playerName, singlePlayer, warlord)
    call GetSaveCodeHumanUpgrades(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeLetter(true, playerName, "all", "Hello citizens!")
endfunction

function GenerateSaveCodeNewOpLimit takes nothing returns nothing
    call GenerateSaveCode(generateSaveCodePlayer, generateSaveCodePlayerName, generateSaveCodeSinglePlayer, generateSaveCodeWarlord, generateSaveCodeXpRate)
endfunction

function GenerateSaveCodes takes player whichPlayer returns nothing
    local integer playerNameSize = 2
    local string array playerName
    local integer singlePlayerSize = 2
    local boolean array singlePlayer
    local integer warlordSize = 2
    local boolean array warlord
    local integer xpRate = 100
    local integer i = 0
    local integer j = 0
    local integer k = 0
    set playerName[0] = "Barade#2569"
    set playerName[1] = "WorldEdit"
    set singlePlayer[0] = true
    set singlePlayer[1] = false
    set warlord[0] = true
    set warlord[1] = false
    set i = 0
    loop
        exitwhen (i >= playerNameSize)
        set j = 0
        loop
            exitwhen (j >= singlePlayerSize)
            set k = 0
            loop
                exitwhen (k >= warlordSize)
                if (not warlord[k]) then
                    set xpRate = 130
                else
                    set xpRate = 100
                endif
                call BJDebugMsg("Generating savecodes for player name " + playerName[i])
                if (singlePlayer[j]) then
                    call BJDebugMsg("Singleplayer")
                else
                    call BJDebugMsg("Multiplayer")
                endif
                if (warlord[k]) then
                    call BJDebugMsg("Warlord")
                else
                    call BJDebugMsg("Freelancer")
                endif

                set generateSaveCodePlayer = whichPlayer
                set generateSaveCodePlayerName = playerName[i]
                set generateSaveCodeSinglePlayer = singlePlayer[j]
                set generateSaveCodeWarlord = warlord[k]
                set generateSaveCodeXpRate = xpRate
                call NewOpLimit(function GenerateSaveCodeNewOpLimit)
                set k = k  + 1
            endloop
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

endlibrary
