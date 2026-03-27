library WoWReforgedPreloadScript initializer Init requires GenerateIds, PlayerUtils, WoWReforgedIcons, WoWReforgedProfessions, WoWReforgedRaces, WoWReforgedHeroes, WoWReforgedStartLocations

// C:\Users\%USER%\Documents\Warcraft III\CustomMapData\PreloadWorldOfWarcraftReforged.pld

function PreloadWoWReforged takes nothing returns nothing
    call Preloader("war3mapImported\\PreloadWorldOfWarcraftReforged.pld")
endfunction

private function FileWriteLinePreload takes string filePath returns nothing
    if (GenerateIdString(filePath)) then
        call FileWriteLine(filePath)
    endif
endfunction

function GeneratePreloadScript takes nothing returns nothing
    local integer i = 0
    local integer max = 0
    
    call ClearGeneratedStringIds()
    
    call FileStart()
    
    call FileWriteLinePreload("ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp")
    
    set i = 0
    set max = GetProfessionsMax()
    loop
        exitwhen (i == max)
        call FileWriteLinePreload(GetIconByProfession(i))
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetRacesMax()
    loop
        exitwhen (i == max)
        call FileWriteLinePreload(GetIconByRace(i))
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetHeroesMax()
    loop
        exitwhen (i == max)
        call FileWriteLinePreload(BlzGetAbilityIcon(GetHeroUnitType(i)))
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetMaxStartLocations()
    loop
        exitwhen (i == max)
        call FileWriteLinePreload(GetStartLocationIcon(i))
        set i = i + 1
    endloop
    
    // Stats
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNHumanCaptureFlag.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNSorceressMaster.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNSkillz.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\UI\\Feedback\\Resources\\ResourceGold.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\UI\\Feedback\\Resources\\ResourceLumber.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\UI\\Feedback\\Resources\\ResourceSupply.blp")
    call FileWriteLinePreload("ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp")
    
    call FileSave("PreloadWorldOfWarcraftReforged.pld")
endfunction

private function Init takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyPlayerChatEvent(t, "-preload", true)
    call TriggerAddAction(t, function GeneratePreloadScript)
    
    call PreloadWoWReforged()
endfunction

endlibrary
