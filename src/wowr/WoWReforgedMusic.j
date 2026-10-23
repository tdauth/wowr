library WoWReforgedMusic initializer Init

globals
    private string array musicName
    private integer musicCounter = 0
endglobals

private function GetMaxMusic takes nothing returns integer
    return musicCounter
endfunction

private function AddMusic takes string name returns nothing
    local integer index = musicCounter
    set musicName[index] = name
    set musicCounter = musicCounter + 1
endfunction

function GetMusicName takes integer index returns string
    return musicName[index]
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
        set result = result + GetMusicName(i)
        set i = i + 1
    endloop
    return result
endfunction

private function Init takes nothing returns nothing
    call AddMusic("Human1")
    call AddMusic("Human2")
    call AddMusic("Human3")
    call AddMusic("HumanX1")
    call AddMusic("HumanDefeat")
    call AddMusic("HumanVictory")
    call AddMusic("Orc1")
    call AddMusic("Orc2")
    call AddMusic("Orc3")
    call AddMusic("OrcX1")
    call AddMusic("OrcDefeat")
    call AddMusic("OrcVictory")
    call AddMusic("Undead1")
    call AddMusic("Undead2")
    call AddMusic("Undead3")
    call AddMusic("UndeadX1")
    call AddMusic("UndeadDefeat")
    call AddMusic("UndeadVictory")
    call AddMusic("NightElf1")
    call AddMusic("NightElf2")
    call AddMusic("NightElf3")
    call AddMusic("NightElfX1")
    call AddMusic("NightElfDefeat")
    call AddMusic("NightElfVictory")
    call AddMusic("BloodElfTheme")
    call AddMusic("NagaTheme")
    call AddMusic("IllidansTheme")
    call AddMusic("LichKingTheme")
    call AddMusic("HeroicVictory")
    call AddMusic("PH1")
    call AddMusic("Forsaken1")
    call AddMusic("Forsaken2")
    call AddMusic("Forsaken3")
    call AddMusic("Combat1")
    call AddMusic("Combat2")
    call AddMusic("Combat3")
endfunction

endlibrary
