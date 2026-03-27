// TODO Create a system SaveCodeObjectSystem depending on the SaveCodeSystem which allows registering any IDs in a 2D array.
library WoWReforgedSaveCodeObjects requires SaveCodeSystem, WoWReforgedQuests, WoWReforgedBanners

globals
    private hashtable h = InitHashtable()

    private integer array unitIds
    private integer unitIdsCounter = 0

    private integer array buildingIds
    private integer buildingIdsCounter = 0

    private integer array itemIds
    private integer itemIdsCounter = 0

    private integer array researchIds
    private integer array researchRaces
    private integer researchIdsCounter = 0
endglobals

function GetSaveObjectUnitMax takes nothing returns integer
    return unitIdsCounter
endfunction

function GetSaveObjectBuildingMax takes nothing returns integer
    return buildingIdsCounter
endfunction

function GetSaveObjectResearchMax takes nothing returns integer
    return researchIdsCounter
endfunction

function DisplaySaveObjectCounters takes nothing returns nothing
    call BJDebugMsg("Save Object Unit Counter: " + I2S(unitIdsCounter))
    call BJDebugMsg("Save Object Building Counter: " + I2S(buildingIdsCounter))
    call BJDebugMsg("Save Object Item Counter: " + I2S(itemIdsCounter))
    call BJDebugMsg("Save Object Research Counter: " + I2S(researchIdsCounter))
endfunction

function DisplayDuplicateSaveObjects takes nothing returns nothing
    local integer j
    local integer i = 0
    call BJDebugMsg("Save Object Duplicates:")
    loop
        exitwhen (i == unitIdsCounter)
        set j = 0
        loop
            exitwhen (j == unitIdsCounter)
            if (i != j and unitIds[i] == unitIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(unitIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == buildingIdsCounter)
        set j = 0
        loop
            exitwhen (j == buildingIdsCounter)
            if (i != j and buildingIds[i] == buildingIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(buildingIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == itemIdsCounter)
        set j = 0
        loop
            exitwhen (j == itemIdsCounter)
            if (i != j and itemIds[i] == itemIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(itemIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        
        set j = 0
        loop
            exitwhen (j == GetQuestsMax())
            if (itemIds[i] == GetQuestReward(j)) then
                call BJDebugMsg("Quest reward item save object " + GetObjectName(itemIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == researchIdsCounter)
        set j = 0
        loop
            exitwhen (j == researchIdsCounter)
            if (i != j and researchIds[i] == researchIds[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(researchIds[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddSaveObjectUnitTypeEx takes integer id returns integer
    local integer index = unitIdsCounter
    call SaveInteger(h, id, 0, index)
    set unitIds[index] = id
    set unitIdsCounter = unitIdsCounter + 1
    return index
endfunction

function AddSaveObjectBuildingTypeEx takes integer id returns integer
    local integer index = buildingIdsCounter
    call SaveInteger(h, id, 0, index)
    set buildingIds[index] = id
    set buildingIdsCounter = buildingIdsCounter + 1
    return index
endfunction

function AddSaveObjectUnitType takes nothing returns integer
    if (IsUnitIdType(udg_TmpUnitType, UNIT_TYPE_STRUCTURE)) then
        return AddSaveObjectBuildingTypeEx(udg_TmpUnitType)
    else
        return AddSaveObjectUnitTypeEx(udg_TmpUnitType)
    endif
endfunction

function GetSaveObjectUnitType takes integer id returns integer
    if (HaveSavedInteger(h, id, 0)) then
        return LoadInteger(h, id, 0)
    endif
    return -1
endfunction

function GetSaveObjectUnitId takes integer number returns integer
    return unitIds[number]
endfunction

function GetSaveObjectBuildingType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectBuildingId takes integer number returns integer
    return buildingIds[number]
endfunction

function AddSaveObjectItemTypeEx takes integer id returns integer
    local integer index = itemIdsCounter
    call SaveInteger(h, id, 0, index)
    set itemIds[index] = id
    set itemIdsCounter = itemIdsCounter + 1
    return index
endfunction

function AddSaveObjectItemType takes nothing returns integer
    return AddSaveObjectItemTypeEx(udg_TmpItemTypeId)
endfunction

function GetSaveObjectItemType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectItemId takes integer number returns integer
    return itemIds[number]
endfunction

function GetSaveObjectItemMax takes nothing returns integer
    return itemIdsCounter
endfunction

function AddSaveObjectResearchTypeEx takes integer id, integer whichRace returns integer
    local integer index = researchIdsCounter
    call SaveInteger(h, id, 0, index)
    set researchIds[index] = id
    set researchRaces[index] = whichRace
    set researchIdsCounter = researchIdsCounter + 1
    return index
endfunction

function AddSaveObjectResearch takes nothing returns integer
    return AddSaveObjectResearchTypeEx(udg_TmpTechType, udg_TmpInteger)
endfunction

function GetSaveObjectResearchType takes integer id returns integer
    return GetSaveObjectUnitType(id)
endfunction

function GetSaveObjectResearchId takes integer index returns integer
    return researchIds[index]
endfunction

function GetSaveObjectResearchRace takes integer index returns integer
    return researchRaces[index]
endfunction

function AddProfessionItemsSaveObjects takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()
    local integer j = 0
    local integer max2 = 0
    local integer k = 0
    local integer max3 = 0
    loop
        exitwhen (i == max)
        set udg_TmpItemTypeId = GetProfession(i).bookItemTypeId
        call AddSaveObjectItemType()
        set j = 0
        set max2 = PROFESSION_RANK_MAX
        loop
            exitwhen (j == max2)
            set k = 0
            set max3 = GetProfessionCraftedItemsCount(i, j)
            loop
                exitwhen (k == max3)
                if (GetProfessionCraftedItem(i, j, k) != 0) then
                    set udg_TmpItemTypeId = GetProfessionCraftedItem(i, j, k)
                    call AddSaveObjectItemType()
                endif
                set k = k + 1
            endloop
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddSaveObjectItemTypesFromRecipes takes nothing returns nothing
    local integer i = 0
    local integer max = GetRecipesMax()
    loop
        exitwhen (i == max)
        if (not GetRecipeIsUnit(i) and GetRecipeItemTypeId(i) != 0) then
            set udg_TmpItemTypeId = GetRecipeItemTypeId(i)
            call AddSaveObjectItemType()
        endif
        set i = i + 1
    endloop
endfunction

function AddSaveObjectItemTypesFromBanners takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxBanners()
    loop
        exitwhen (i == max)
        set udg_TmpItemTypeId = GetBannerItemTypeId(i)
        call AddSaveObjectItemType()
        set i = i + 1
    endloop
endfunction

function AddSaveObjectBuildingTypesFromBanners takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxBanners()
    loop
        exitwhen (i == max)
        set udg_TmpUnitType = GetBannerUnitTypeId(i)
        call AddSaveObjectUnitType()
        set i = i + 1
    endloop
endfunction

endlibrary
