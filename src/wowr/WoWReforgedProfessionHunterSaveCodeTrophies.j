library WoWReforgedProfessionHunterSaveCodeTrophies requires WoWReforgedProfessionHunter, WoWReforgedSaveCodeObjects

function AddSaveCodeItemsTrophies takes nothing returns nothing
    local integer i = 0
    local integer max = GetTrophyCounter()
    loop
        exitwhen (i == max)
        call AddSaveObjectItemTypeEx(GetTrophyItemTypeId(i))
        set i = i + 1
    endloop
endfunction

endlibrary
