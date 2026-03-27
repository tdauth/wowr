library LocationUtils

function MoveLocationToUnit takes location whichLocation, unit whichUnit returns nothing
    call MoveLocation(whichLocation, GetUnitX(whichUnit), GetUnitY(whichUnit))
endfunction

function MoveLocationToItem takes location whichLocation, item whichItem returns nothing
    call MoveLocation(whichLocation, GetItemX(whichItem), GetItemY(whichItem))
endfunction

function MoveLocationToDestructable takes location whichLocation, destructable whichDestructable returns nothing
    call MoveLocation(whichLocation, GetDestructableX(whichDestructable), GetDestructableY(whichDestructable))
endfunction

function MoveLocationToRectCenter takes location whichLocation, rect whichRect returns nothing
    call MoveLocation(whichLocation, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

function MoveLocationToLocation takes location whichLocation, location target returns nothing
    call MoveLocation(whichLocation, GetLocationX(target), GetLocationY(target))
endfunction

function MoveLocationToRallyPoint takes location whichLocation, unit whichUnit returns nothing
    local location rally = GetUnitRallyPoint(whichUnit)
    call MoveLocation(whichLocation, GetLocationX(rally), GetLocationY(rally))
    call RemoveLocation(rally)
    set rally = null
endfunction

endlibrary
