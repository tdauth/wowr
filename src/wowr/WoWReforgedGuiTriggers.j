library WoWReforgedGuiTriggers

// Call this in a GUI trigger with map initialization event which is executed AFTER InitGlobals in war3map.j.
// Remove this library when all GUI triggers have been refactored into vJass code.
function InitWoWReforgedGuiVariables takes nothing returns nothing
    // Game Modes
    set udg_FreelancerXPRate = 130.0
    set udg_WarlordXPRate = 100.0
    set udg_FreelancerBonusAttributes = 15
    // Races
    set udg_RaceNone = 0
    set udg_RaceFreelancer = RACE_FREELANCER
endfunction

endlibrary
