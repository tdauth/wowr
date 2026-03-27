library CameraUtils requires Utilities

function SmartCameraTo takes real sourceX, real sourceY, real targetX, real targetY, real duration returns nothing
    local real dist = DistanceBetweenCoordinates(targetX, targetY, sourceX, sourceY)
    if (dist >= bj_SMARTPAN_TRESHOLD_SNAP) then
        // If the user is too far away, snap the camera.
        call PanCameraToTimed(targetX, targetY, 0)
    elseif (dist >= bj_SMARTPAN_TRESHOLD_PAN) then
        // If the user is moderately close, pan the camera.
        call PanCameraToTimed(targetX, targetY, duration)
    else
        // User is close enough, so don't touch the camera.
    endif
endfunction

function SmartCameraPanToUnit takes player whichPlayer, unit target, real duration returns nothing
    local real x = GetUnitX(target)
    local real y = GetUnitY(target)
    if (GetLocalPlayer() == whichPlayer) then
        call SmartCameraTo(GetCameraTargetPositionX(), GetCameraTargetPositionY(), x, y, duration)
    endif
endfunction

endlibrary
