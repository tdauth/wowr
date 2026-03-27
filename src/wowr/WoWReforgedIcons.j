library WoWReforgedIcons

private function GetIconByUnitTypeEx takes integer unitTypeId returns string
	local string result = BlzGetAbilityIcon(unitTypeId)
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function GetIconByUnitType takes integer unitTypeId returns string
    if (unitTypeId == 0) then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return GetIconByUnitTypeEx(unitTypeId)
endfunction

private function GetIconByItemTypeEx takes integer itemTypeId returns string
	local string result = BlzGetAbilityIcon(itemTypeId)
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp"
    endif

    return result
endfunction

function GetIconByItemType takes integer itemTypeId returns string
    if (itemTypeId == 0) then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp"
    endif

    return GetIconByItemTypeEx(itemTypeId)
endfunction

endlibrary
