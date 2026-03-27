library SimError initializer init
//**************************************************************************************************
//*
//*  SimError
//*
//*     Mimic an interface error message
//*       call SimError(ForPlayer, msg)
//*         ForPlayer : The player to show the error
//*         msg       : The error
//*   
//*     To implement this function, copy this trigger and paste it in your map.
//* Unless of course you are actually reading the library from wc3c's scripts section, then just
//* paste the contents into some custom text trigger in your map.
//*
//**************************************************************************************************

globals
    private sound error
endglobals

function SimError takes player ForPlayer, string msg returns nothing
    if (GetLocalPlayer() == ForPlayer) then
        call ClearTextMessages()
    endif
    // Barade: This must be outside of GetLocalPlayer due to the hook for DisplayTimedTextToPlayer from Log.
    call DisplayTimedTextToPlayer(ForPlayer, 0.52, 0.96, 2.00, "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n|cffffcc00" + msg + "|r")
    if (GetLocalPlayer() == ForPlayer) then
        call StartSound(error)
    endif
endfunction

private function init takes nothing returns nothing
     set error=CreateSoundFromLabel("InterfaceError",false,false,false,10,10)
     //call StartSound( error ) //apparently the bug in which you play a sound for the first time
                                //and it doesn't work is not there anymore in patch 1.22
endfunction

endlibrary
