library WoWReforgedMapLevers initializer Init requires WoWReforgedLevers

private function Init takes nothing returns nothing
    // Northrend
    call AddLeverGate(gg_unit_n0ES_2035, gg_dest_ITg1_7756)
    call AddLeverGate(gg_unit_n0ES_2358, gg_dest_ITg2_7663)
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
    // Dalaran
    call AddLeverGate(gg_unit_n0ES_0044, gg_dest_LTg1_17155)
    call AddLeverGate(gg_unit_n0ES_0046, gg_dest_LTg3_1334)
    // Orgrimmar
    call AddLeverGate(gg_unit_n0ES_2034, gg_dest_DTg7_5031)
    call AddLeverGate(gg_unit_n0ES_2058, gg_dest_DTg5_4824)
    // Thunder Bluff
    call AddLeverGate(gg_unit_n0ES_2059, gg_dest_DTg8_5096)
    call AddLeverGate(gg_unit_n0ES_0058, gg_dest_DTg7_2184)
    // Outland
    call AddLeverGate(gg_unit_n0ES_0072, gg_dest_ATg4_2185)
endfunction

endlibrary
