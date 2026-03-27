library WoWReforgedCalendarEvents

function IsEaster takes nothing returns boolean
    return easter.running
endfunction

function IsChristmas takes nothing returns boolean
    return christmas.running
endfunction

function IsNewYear takes nothing returns boolean
    return newyear.running
endfunction

function IsHalloween takes nothing returns boolean
    return halloween.running
endfunction

function IsCarnival takes nothing returns boolean
    return carnival.running
endfunction

endlibrary
