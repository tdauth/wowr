library WoWReforgedTmpVariables requires MathUtils

// Global variables are useful for GUI triggers.

function InitTmpLocations takes nothing returns nothing
    if udg_TmpLocation == null then
        set udg_TmpLocation = Location(0.0, 0.0)
    endif

    if udg_TmpLocation2 == null then
        set udg_TmpLocation2 = Location(0.0, 0.0)
    endif
endfunction

function MoveTmpLocation takes real x, real y returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, x, y)
endfunction

function MoveTmpLocationToDestination takes unit whichUnit returns nothing
    call MoveLocation(udg_TmpLocation, WaygateGetDestinationX(whichUnit), WaygateGetDestinationY(whichUnit))
endfunction

function MoveTmpLocationToSpellTarget takes nothing returns nothing
    call InitTmpLocations()
    call MoveTmpLocation(GetSpellTargetX(), GetSpellTargetY())
endfunction

function MoveTmpLocation2 takes real x, real y returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation2, x, y)
endfunction

function MoveTmpLocationToUnit takes unit whichUnit returns nothing
    call InitTmpLocations()
    call MoveLocationToUnit(udg_TmpLocation, whichUnit)
endfunction

function MoveTmpLocation2ToUnit takes unit whichUnit returns nothing
    call InitTmpLocations()
    call MoveLocationToUnit(udg_TmpLocation2, whichUnit)
endfunction

function MoveTmpLocationToRect takes rect whichRect returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

function MoveTmpLocationToDestructable takes destructable d returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetDestructableX(d), GetDestructableY(d))
endfunction

function MoveTmpLocationToItem takes item whichItem returns nothing
    call InitTmpLocations()
    call MoveLocationToItem(udg_TmpLocation, whichItem)
endfunction

function MoveTmpLocationToRandomPointInRect takes rect whichRect returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetRandomReal(GetRectMinX(whichRect), GetRectMaxX(whichRect)), GetRandomReal(GetRectMinY(whichRect), GetRectMaxY(whichRect)))
endfunction

endlibrary
