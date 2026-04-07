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

function MoveTmpLocationToUnit takes unit whichUnit returns nothing
    call InitTmpLocations()
    call MoveLocationToUnit(udg_TmpLocation, whichUnit)
endfunction

function MoveTmpLocationToRect takes rect whichRect returns nothing
    call InitTmpLocations()
    call MoveLocation(udg_TmpLocation, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
endfunction

endlibrary
