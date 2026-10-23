library WoWReforgedMusic initializer Init

globals
    private string array musicName
    private string array musicFile
    private integer musicCounter = 0
endglobals

private function GetMaxMusic takes nothing returns integer
    return musicCounter
endfunction

private function AddMusic takes string name, string file returns nothing
    local integer index = musicCounter
    set musicName[index] = name
    set musicFile[index] = file
    set musicCounter = musicCounter + 1
endfunction

function GetMusicFile takes integer index returns string
    return musicFile[index]
endfunction

function GetMusicByName takes string name returns integer
    local integer i = 0
    local integer max = GetMaxMusic()
    loop
        exitwhen (i >= max)
        if (musicName[i] != name) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetMusicList takes nothing returns string
    local string result = ""
    local integer i = 0
    local integer max = GetMaxMusic()
    loop
        exitwhen (i >= max)
        if (i > 0) then
            set result = result + ", "
        endif
        set result = result + musicName[i]
        set i = i + 1
    endloop
    return result
endfunction

private function Init takes nothing returns nothing
    call AddMusic("orc1", "Sound/Music/mp3Music/Orc1.flac")
endfunction

endlibrary
