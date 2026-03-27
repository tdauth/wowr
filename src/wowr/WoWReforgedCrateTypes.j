library WoWReforgedCrateTypes

function IsCrate takes integer unitTypeId returns boolean
    return unitTypeId == CRATES_0 or unitTypeId == CRATES_1 or unitTypeId == BARREL_0 or unitTypeId == BARREL_1
endfunction

function IsUnitCrate takes unit whichUnit returns boolean
    return IsCrate(GetUnitTypeId(whichUnit))
endfunction

endlibrary
