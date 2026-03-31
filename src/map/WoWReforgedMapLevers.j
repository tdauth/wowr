library WoWReforgedMapLevers initializer Init requires WoWReforgedLevers

private function Init takes nothing returns nothing
    // Northrend
    call AddLeverGate(gg_unit_n0ES_2035, gg_dest_ITg1_7756)
    call AddLeverGate(gg_unit_n0ES_0116, gg_dest_ITg1_0618)
    // Northrend East
    call AddLeverGate(gg_unit_n0ES_2358, gg_dest_ITg2_7663)
    call AddLeverGate(gg_unit_n0ES_0115, gg_dest_ITg1_2219)
    // Eastern Kingdoms
    // New Stormwind
    call AddLeverGate(gg_unit_n0ES_2026, gg_dest_LTe2_20016)
    call AddLeverGate(gg_unit_n0ES_2033, gg_dest_DTg7_1860)
    // Ironforge
    call AddLeverGate(gg_unit_n08R_0648, gg_dest_DTg5_0648)
    call AddLeverBridge(gg_unit_n08R_0648, gg_dest_LT04_0581)
    call AddLeverGate(gg_unit_n0ES_2077, gg_dest_ATg1_0612)
    call AddLeverGate(gg_unit_n0ES_0104, gg_dest_ATg1_1803)
    call AddLeverGate(gg_unit_n0ES_2027, gg_dest_DTg8_1395)
    call AddLeverGate(gg_unit_n0ES_1560, gg_dest_DTg7_1501)
    // Undercity
    call AddLeverGate(gg_unit_n0ES_2029, gg_dest_DTg7_2040)
    call AddLeverGate(gg_unit_n0ES_2028, gg_dest_DTg5_2216)
    call AddLeverGate(gg_unit_n0ES_2078, gg_dest_DTg7_2196)
    // Sunstrider Isle
    call AddLeverGate(gg_unit_n08R_2024, gg_dest_LTe2_2302)
    call AddLeverBridge(gg_unit_n08R_2024, gg_dest_LT07_2301)
    call AddLeverGate(gg_unit_n0ES_0105, gg_dest_LTe3_2186)
    // Ashenvale
    // Teldrassil
    call AddLeverGate(gg_unit_n08R_2076, gg_dest_LTe2_20016)
    call AddLeverBridge(gg_unit_n08R_2076, gg_dest_DTs1_0289)
    call AddLeverGate(gg_unit_n0ES_0056, gg_dest_LTe1_2183)
    // Mount Hyjal
    call AddLeverGate(gg_unit_n0ES_2060, gg_dest_LTe4_5995)
    // Theramore
    call AddLeverGate(gg_unit_n0ES_1635, gg_dest_LTg1_5488)
    call AddLeverGate(gg_unit_n0ES_1631, gg_dest_LTg3_5486)
    // Dakspear Islands
    call AddLeverGate(gg_unit_n0ES_0690, gg_dest_DTg4_17547)
    // Kezan
    call AddLeverGate(gg_unit_n0ES_0113, gg_dest_DTg7_2218)
    // Dalaran
    call AddLeverGate(gg_unit_n0ES_0044, gg_dest_LTg1_17155)
    call AddLeverGate(gg_unit_n0ES_0046, gg_dest_LTg3_1334)
    // Orgrimmar
    call AddLeverGate(gg_unit_n0ES_2034, gg_dest_DTg7_5031)
    call AddLeverGate(gg_unit_n0ES_2058, gg_dest_DTg5_4824)
    // Thunder Bluff
    call AddLeverGate(gg_unit_n0ES_2059, gg_dest_DTg8_5096)
    call AddLeverGate(gg_unit_n0ES_0058, gg_dest_DTg7_2184)
    // Echo Isles
    call AddLeverGate(gg_unit_n0ES_0117, gg_dest_DTg8_2220)
    // Sunken Ruins
    call AddLeverGate(gg_unit_n0ES_0112, gg_dest_ZTsx_2195)
    call AddLeverGate(gg_unit_n0ES_2023, gg_dest_ZTsx_9720)
    // Outland
    call AddLeverGate(gg_unit_n0ES_0072, gg_dest_ATg4_2185)
endfunction

endlibrary
