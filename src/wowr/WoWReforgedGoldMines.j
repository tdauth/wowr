library WoWReforgedGoldMines

function AddGoldMine takes unit whichUnit returns nothing
    call UnitAddAbility(whichUnit, 'Agld')
    call SetResourceAmount(whichUnit, 999999)
endfunction

endlibrary
