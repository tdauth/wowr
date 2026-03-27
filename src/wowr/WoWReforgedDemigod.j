library WoWReforgedDemigod requires WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedEquipmentBags, WoWReforgedHeroTransformation

function BecomeDemigod takes unit hero, integer unitTypeId returns unit
    local unit replaced = ReplaceHero(hero, unitTypeId, bj_UNIT_STATE_METHOD_RELATIVE, false, false)
    call RefreshBackpackForPlayer(GetOwningPlayer(replaced))
    call RecreateAllEquipmentBags(GetOwningPlayer(replaced))
    call DisplayTimedTextToPlayer(GetOwningPlayer(replaced), 0, 0, 30, Format(GetLocalizedString("BECOME_DEMIGOD")).s(GetPlayerNameColored(GetOwningPlayer(replaced))).s(GetObjectName(unitTypeId)).result())
    call SetPlayerTechResearchedSwap(UPG_DEMIGOD, 1, GetOwningPlayer(replaced))
    return replaced
endfunction

function BecomeDemigodLight takes unit hero returns unit
    return BecomeDemigod(hero, DEMIGOD_LIGHT)
endfunction

function BecomeDemigodDark takes unit hero returns unit
    return BecomeDemigod(hero, DEMIGOD_DARK)
endfunction

function GetUnitsInRectOfPlayerAndTypeFilter takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == bj_groupEnumOwningPlayer and GetUnitTypeId(GetFilterUnit()) == bj_groupEnumTypeId
endfunction

function CountDemigodDragonsEx takes player whichPlayer, integer unitTypeId, rect whichRect returns integer
    local group g = CreateGroup()
    local integer count = 0
    set bj_groupEnumOwningPlayer = whichPlayer
    set bj_groupEnumTypeId = unitTypeId
    call GroupEnumUnitsInRect(g, whichRect, Filter(function GetUnitsInRectOfPlayerAndTypeFilter))
    set count = BlzGroupGetSize(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return count
endfunction

function CountDemigodDragons takes nothing returns integer
    return CountDemigodDragonsEx(udg_TmpPlayer, udg_TmpUnitType, udg_TmpRect)
endfunction

endlibrary
