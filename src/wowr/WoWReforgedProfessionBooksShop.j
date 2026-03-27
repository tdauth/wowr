library WoWReforgedProfessionBooksShop requires PagedButtons, WoWReforgedProfessions

function AddProfessionBooksShop takes unit shop returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()
    call EnablePagedButtons(shop)
    loop
        exitwhen (i == max)
         call AddPagedButtonsItemType(shop, udg_ProfessionItemType[i])
        set i = i + 1
    endloop
endfunction

endlibrary
