library PlayerUtils

function TriggerRegisterAnyPlayerChatEvent takes trigger whichTrigger, string chatMessageToDetect, boolean exactMatchOnly returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerChatEvent(whichTrigger, Player(i), chatMessageToDetect, exactMatchOnly)
        set i = i + 1
    endloop
endfunction

function TriggerRegisterAnyPlayerSyncEvent takes trigger whichTrigger, string prefix, boolean fromServer returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call BlzTriggerRegisterPlayerSyncEvent(whichTrigger, Player(i), prefix, fromServer)
        set i = i + 1
    endloop
endfunction

endlibrary
