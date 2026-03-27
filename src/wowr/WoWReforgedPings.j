library WoWReforgedPings requires WoWReforgedUtils, WoWReforgedAltars, WoWReforgedResurrectionStone, WoWReforgedRacing, WoWReforgedNpcs

globals
    constant real PING_DURATION = 5.0
    private player owner = null
endglobals

// Non leaking ping functions:

function PingUnitForPlayer takes unit whichUnit, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetUnitX(whichUnit), GetUnitY(whichUnit), PING_DURATION)
endfunction

function PingUnitForPlayerWoWReforged takes nothing returns nothing
    call PingUnitForPlayer(udg_TmpUnit, udg_TmpPlayer)
endfunction

function PingItemForPlayer takes item whichItem, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetItemX(whichItem), GetItemY(whichItem), PING_DURATION)
endfunction

function PingItemForPlayerWoWReforged takes nothing returns nothing
    call PingItemForPlayer(udg_TmpItem, udg_TmpPlayer)
endfunction

function PingRectForPlayer takes rect whichRect, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetRectCenterX(whichRect), GetRectCenterY(whichRect), PING_DURATION)
endfunction

function PingRectForPlayerWoWReforged takes nothing returns nothing
    call PingRectForPlayer(udg_TmpRect, udg_TmpPlayer)
endfunction

function PingDestructableForPlayer takes destructable whichDestructable, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetDestructableX(whichDestructable), GetDestructableY(whichDestructable), PING_DURATION)
endfunction

function PingDestructableForPlayerWoWReforged takes nothing returns nothing
    call PingDestructableForPlayer(udg_TmpDestructible, udg_TmpPlayer)
endfunction

function PingAlliedHeroes takes player whichPlayer returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerAlly(slotPlayer, whichPlayer)) then
            if (GetPlayerHero1(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero1(slotPlayer), whichPlayer)
            endif
            if (GetPlayerHero2(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero2(slotPlayer), whichPlayer)
            endif
            if (GetPlayerHero3(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero3(slotPlayer), whichPlayer)
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

function PingBosses takes player whichPlayer returns nothing
    local integer i = 0
    local integer max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i == max)
        call PingUnitForPlayer(BlzGroupUnitAt(udg_Bosses, i), whichPlayer)
        set i = i + 1
    endloop
endfunction

function PingAlliedFreelancerHeroes takes player whichPlayer returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerAlly(slotPlayer, whichPlayer) and IsPlayerFreelancer(slotPlayer)) then
            if (GetPlayerHero1(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero1(slotPlayer), whichPlayer)
            endif
            if (GetPlayerHero2(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero2(slotPlayer), whichPlayer)
            endif
            if (GetPlayerHero3(slotPlayer) != null) then
                call PingUnitForPlayer(GetPlayerHero3(slotPlayer), whichPlayer)
            endif
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

function GetAltars takes player whichPlayer returns group
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function IsAltarFilter))
    return g
endfunction

function PingAltarForPlayer takes unit altar, player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimapEx(GetUnitX(altar), GetUnitY(altar), 4.0, 0, 255, 0, false)
        //call StartSound(bj_pingMinimapSound)
    endif
endfunction

function PingAltars takes player whichPlayer returns nothing
    local group g = GetAltars(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call PingAltarForPlayer(BlzGroupUnitAt(g, i), whichPlayer)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function IsResurrectionStoneFilter takes nothing returns boolean
    return IsUnitResurrectionStone(GetFilterUnit())
endfunction

function GetResurrectionStones takes player whichPlayer returns group
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), Filter(function IsResurrectionStoneFilter))
    return g
endfunction

function PingResurrectionStoneForPlayer takes unit u, player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimapEx(GetUnitX(u), GetUnitY(u), 4.0, 0, 255, 0, false)
        //call StartSound(bj_pingMinimapSound)
    endif
endfunction

function PingRacingTrackNextCheckPointForPlayer takes player whichPlayer returns nothing
    local unit u = GetPlayerRacingTrackNextCheckPoint(whichPlayer)
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimapEx(GetUnitX(u), GetUnitY(u), 4.0, 0, 255, 0, false)
        //call StartSound(bj_pingMinimapSound)
    endif
    set u = null
endfunction

function PingResurrectionStones takes player whichPlayer returns nothing
    local group g = GetResurrectionStones(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call PingResurrectionStoneForPlayer(BlzGroupUnitAt(g, i), whichPlayer)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function IsNpcFilter takes nothing returns boolean
    return IsUnitNpc(GetFilterUnit())
endfunction

function GetNpcs takes nothing returns group
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_PASSIVE), Filter(function IsNpcFilter))
    return g
endfunction

function PingNpcForPlayer takes unit altar, player whichPlayer returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call PingMinimapEx(GetUnitX(altar), GetUnitY(altar), 4.0, 0, 255, 0, false)
        //call StartSound(bj_pingMinimapSound)
    endif
endfunction

function PingNpcs takes player whichPlayer returns nothing
    local group g = GetNpcs()
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call PingNpcForPlayer(BlzGroupUnitAt(g, i), whichPlayer)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function PingGoldMines takes player whichPlayer returns nothing
    local group g = GetUnitsOfTypeId(GOLD_MINE, Player(PLAYER_NEUTRAL_PASSIVE))
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call PingUnitForPlayer(BlzGroupUnitAt(g, i), whichPlayer)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

endlibrary
