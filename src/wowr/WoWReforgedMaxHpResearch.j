library WoWReforgedMaxHpResearch initializer Init requires MaxHpResearch

private function Init takes nothing returns nothing
    call AddMaxHpResearchAbsolute(UPG_EVOLUTION, 50, 50)
    call AddMaxHpResearchAbsolute(UPG_OGRE_STRENGTH, 250, 250)
endfunction

endlibrary
