library WoWReforgedSceptersShop requires PagedButtons, WoWReforgedRaces

function AddSceptersShop takes unit shop returns nothing
    local integer i = 0
    local integer max = GetRacesMax()
    call EnablePagedButtons(shop)
    loop
        exitwhen (i == max)
         call AddPagedButtonsItemType(shop, udg_RaceItemType[i])
        set i = i + 1
    endloop
endfunction

endlibrary
