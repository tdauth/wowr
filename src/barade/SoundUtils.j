library SoundUtils

function PlaySoundOnDestructable takes sound soundHandle, real volumePercent, destructable whichDestructable returns nothing
    local location loc = GetDestructableLoc(whichDestructable)
    local real z = GetLocationZ(loc)
    call SetSoundPositionLocBJ(soundHandle, loc, z)
    call SetSoundVolumeBJ(soundHandle, volumePercent)
    call PlaySoundBJ(soundHandle)
    call RemoveLocation(loc)
    set loc = null
endfunction

function PlaySoundForPlayer takes player whichPlayer, sound soundHandle returns nothing
    if (soundHandle != null) then
        if (whichPlayer == GetLocalPlayer()) then
            call StartSound(soundHandle)
        endif
    endif
endfunction

endlibrary
