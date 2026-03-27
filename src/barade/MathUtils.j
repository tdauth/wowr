library MathUtils requires Utilities

function Index2D takes integer v1, integer v2, integer max2 returns integer
    return v1 * max2 + v2
endfunction

function Index3D takes integer v1, integer v2, integer v3, integer max2, integer max3 returns integer
    return v1 * max2 * max3 + v2 * max3 + v3
endfunction

function PolarProjectionX takes real x, real angle, real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function PolarProjectionY takes real y, real angle, real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function AngleBetweenCoordinatesRad takes real x1, real y1, real x2, real y2 returns real
    return Atan2(y2 - y1, x2 - x1)
endfunction

// Utilities already uses the identifier AngleBetweenCoordinates.
function AngleBetweenCoordinatesDeg takes real x1, real y1, real x2, real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

function AngleBetweenUnitsDeg takes unit whichUnit0, unit whichUnit1 returns real
    return AngleBetweenCoordinatesDeg(GetUnitX(whichUnit0), GetUnitY(whichUnit0), GetUnitX(whichUnit1), GetUnitY(whichUnit1))
endfunction

// Utilities already uses the identifier DistanceBetweenCoordinates.
function DistBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    local real dx = x2 - x1
    local real dy = y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

function DistanceBetweenUnits takes unit whichUnit0, unit whichUnit1 returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit0), GetUnitY(whichUnit0), GetUnitX(whichUnit1), GetUnitY(whichUnit1))
endfunction

function DistanceBetweenUnitAndPoint takes unit whichUnit0, real x, real y returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit0), GetUnitY(whichUnit0), x, y)
endfunction

function DistanceBetweenUnitAndItem takes unit whichUnit, item whichItem returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit), GetUnitY(whichUnit), GetItemX(whichItem), GetItemY(whichItem))
endfunction

function DistanceBetweenUnitAndDestructable takes unit whichUnit, destructable whichDestructable returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit), GetUnitY(whichUnit), GetDestructableX(whichDestructable), GetDestructableY(whichDestructable))
endfunction

function IntToPrecentage takes integer v, integer max returns real
    return I2R(v) * 100.0 / I2R(max)
endfunction

function GetRectFromCircle takes real centerX, real centerY, real radius returns rect
    return Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
endfunction

endlibrary
