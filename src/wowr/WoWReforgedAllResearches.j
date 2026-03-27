library WoWReforgedAllResearches initializer Init requires WoWReforgedRaces, WoWReforgedResearches, WoWReforgedMapData

private function Init takes nothing returns nothing
    local integer i = 0
    local integer max = GetRacesMax()
    loop
        exitwhen (i == max)
        call ResearchAllForPlayer(GetMapBossesPlayer(), i)
        call ResearchAllForPlayer(Player(PLAYER_NEUTRAL_AGGRESSIVE), i)
        set i = i + 1
    endloop
endfunction

endlibrary
