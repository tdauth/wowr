library WoWReforgedRandomSaveCode requires WoWReforgedUtils, WoWReforgedSaveCodes, optional WoWReforgedUrlUi

private function CreateRandomUnits takes player whichPlayer returns group
    local location tmpLocation = Location(0.0, 0.0)
    local group allCreeps = CreateGroup()
    local integer i = 0
    local integer max = GetRandomInt(2, 8)
    loop
        exitwhen (i >= max)
        call GroupAddGroup(CreateNUnitsAtLoc(GetRandomInt(1, 6), ChooseRandomCreep(GetRandomInt(1, 10)), whichPlayer, tmpLocation, 0.0), allCreeps)
        set i = i + 1
    endloop

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return allCreeps
endfunction

private function GetSaveCodeRandomUnits takes player whichPlayer returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allCreeps = CreateRandomUnits(whichPlayer)
    local group allCreepsDistinct = DistinctGroup(allCreeps)
    local string result = GetSaveCodeUnitsEx2(GetPlayerName(whichPlayer), IsInSinglePlayer(), IsPlayerWarlord(whichPlayer), R2I(GetPlayerHandicapXP(whichPlayer)), true, 0, whichPlayer, allCreepsDistinct)

    call ForGroupBJ(allCreeps, function ForGroupRemoveUnit)

    call GroupClear(allCreeps)
    call DestroyGroup(allCreeps)
    set allCreeps = null

    call GroupClear(allCreepsDistinct)
    call DestroyGroup(allCreepsDistinct)
    set allCreepsDistinct = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

private function GetSaveCodeRandomItems takes player whichPlayer returns string
    local item item0 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local item item1 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local item item2 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local item item3 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local item item4 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local item item5 = CreateItem(ChooseRandomItem(GetRandomInt(0, 8)), 0.0, 0.0)
    local string result

    call SetItemCharges(item0, GetRandomInt(1, 30))
    call SetItemCharges(item1, GetRandomInt(1, 30))
    call SetItemCharges(item2, GetRandomInt(1, 30))
    call SetItemCharges(item3, GetRandomInt(1, 30))
    call SetItemCharges(item4, GetRandomInt(1, 30))
    call SetItemCharges(item5, GetRandomInt(1, 30))

    set result = GetSaveCodeItemsEx2(GetPlayerName(whichPlayer), IsInSinglePlayer(), IsPlayerWarlord(whichPlayer), R2I(GetPlayerHandicapXP(whichPlayer)), true, 0, item0, item1, item2, item3, item4, item5)

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

private function ShowUrl takes player whichPlayer, string title, string saveCode returns nothing
static if (LIBRARY_WoWReforgedUrlUi) then
    call ShowUrlUi(whichPlayer, title, saveCode)
else
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 999999.0, saveCode)
endif
endfunction

function GenerateRandomSaveCode takes unit hero returns nothing
    if (GetRandomInt(0, 1) == 0) then
        call ShowUrl(GetOwningPlayer(hero), GetLocalizedString("UNITS_SAVE_CODE"), GetSaveCodeRandomUnits(GetOwningPlayer(hero)))
    else
        call ShowUrl(GetOwningPlayer(hero), GetLocalizedString("ITEMS_SAVE_CODE"), GetSaveCodeRandomItems(GetOwningPlayer(hero)))
    endif
endfunction

endlibrary
