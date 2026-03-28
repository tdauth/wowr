library WoWReforgedMapStartLocations initializer Init requires WoWReforgedStartLocations

private function Init takes nothing returns nothing
    call AddStartLocation('I066', gg_rct_Start_Location_Stormwind, 0.0)
    call AddStartLocation('I14F', gg_rct_Start_Location_Kul_Tiras, 0.0)
    call AddStartLocation('I15P', gg_rct_Start_Location_Dalaran, 270.0)
    call AddStartLocation('I09N', gg_rct_Start_Location_Khaz_Modan, 270.0)
    call AddStartLocation('I0OF', gg_rct_Start_Darkspear_Islands, 270.0)
    call AddStartLocation('I063', gg_rct_Start_Location_Barrens, 180.0)
    call AddStartLocation('I0OC', gg_rct_Start_Echo_Isles, 180.0)
    call AddStartLocation('I115', gg_rct_Start_Location_Thunder_Buff, 180.0)
    call AddStartLocation('I05S', gg_rct_Start_Location_Terdrassil, 0.0)
    call AddStartLocation('I12M', gg_rct_Start_Location_Mount_Hyjal, 270.0)
    call AddStartLocation('I064', gg_rct_Start_Location_Lordearon, 270.0)
    call AddStartLocation('I116', gg_rct_Start_Location_Sunstrider_Isle, 270.0)
    call AddStartLocation('I114', gg_rct_Start_Location_Sunwell_Grove, 270.0)
    call AddStartLocation('I11L', gg_rct_Start_Location_Icecrown_Citadel, 270.0)
    call AddStartLocation('I062', gg_rct_Start_Location_Draktharon_Keep, 270.0)
    call AddStartLocation('I11H', gg_rct_Start_Location_Kezan, 270.0)
    call AddStartLocation('I065', gg_rct_Start_Location_Sunken_Ruins, 90.0)
    call AddStartLocation('I067', gg_rct_Start_Location_Outland, 90.0)
    call AddStartLocation('I0A4', gg_rct_Start_Location_Theramore, 270.0)
endfunction

endlibrary
