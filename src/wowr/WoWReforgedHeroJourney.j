library WoWReforgedHeroJourney initializer Init requires WoWReforgedUtils, WoWReforgedVIPs

function ResetHeroJourneyLevel takes player whichPlayer returns nothing
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_5, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_10, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_10_VIP, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_15, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_20, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_25, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_30, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_35, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_40, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_BONUS_HEROES, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_45, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_50, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_55, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_60, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_65, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_70, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_75, 0)
    call SetPlayerTechResearched(whichPlayer, UPG_HERO_LEVEL_75_VIP, 0)
    call UpdateResearchesForVIP(whichPlayer)
endfunction

private function HeroJourneyMessage takes player whichPlayer, integer heroLevel returns nothing
    local string k = "HERO_JOURNEY_5"
    if (heroLevel == 5) then
        set k = "HERO_JOURNEY_5"
    elseif (heroLevel == 10) then
        set k = "HERO_JOURNEY_10"
    elseif (heroLevel == 15) then
        set k = "HERO_JOURNEY_15"
    elseif (heroLevel == 20) then
        set k = "HERO_JOURNEY_20"
    elseif (heroLevel == 25) then
        set k = "HERO_JOURNEY_25"
    elseif (heroLevel == 30) then
        set k = "HERO_JOURNEY_30"
    elseif (heroLevel == 35) then
        set k = "HERO_JOURNEY_35"
    elseif (heroLevel == 40) then
        set k = "HERO_JOURNEY_40"
    elseif (heroLevel == 45) then
        set k = "HERO_JOURNEY_45"
    elseif (heroLevel == 50) then
        set k = "HERO_JOURNEY_50"
    elseif (heroLevel == 55) then
        set k = "HERO_JOURNEY_55"
    elseif (heroLevel == 60) then
        set k = "HERO_JOURNEY_60"
    elseif (heroLevel == 65) then
        set k = "HERO_JOURNEY_65"
    elseif (heroLevel == 70) then
        set k = "HERO_JOURNEY_70"
    elseif (heroLevel == 75) then
        set k = "HERO_JOURNEY_75_1"
    endif
    call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)], bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedString("HERO_JOURNEY_X_MESSAGE")).i(heroLevel).s(GetLocalizedString(k)).result())
endfunction

function SetHeroJourneyLevelEx takes player owner, boolean isHero1, integer level, boolean showMessage returns nothing
    if (GetHeroLevel1(owner) == MAX_HERO_LEVEL and GetHeroLevel2(owner) == MAX_HERO_LEVEL and GetHeroLevel3(owner) == MAX_HERO_LEVEL and not udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(owner)]) then
        set udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(owner)] = true
        if (showMessage) then
            call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(owner)], bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedString("HERO_JOURNEY_X_MESSAGE")).i(75).s(GetLocalizedString("HERO_JOURNEY_75_3")).result())
        endif
    endif
    if (isHero1) then
        if (level >= 5 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_5, owner) == 0) then
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n02X_0549), GetUnitY(gg_unit_n02X_0549), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_5, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 5)
            endif
        endif
        if (level >= 10 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_10, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n02X_0549), GetUnitY(gg_unit_n02X_0549), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_10, 1)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_10_VIP, 1)
            //call HeroJourneyMessage(owner, 10)
        endif
        if (level >= 15 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_15, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_15, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 15)
            endif
        endif
        if (level >= 20 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_20, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_20, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 20)
            endif
        endif
        if (level >= 25 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_25, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_25, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 25)
            endif
        endif
        if (level >= 30 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_30, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_30, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 30)
            endif
        endif
        if (level >= 35 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_35, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_35, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 35)
            endif
        endif
        if (level >= 40 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_40, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_40, 1)
            call SetPlayerTechResearched(owner, UPG_BONUS_HEROES, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 40)
            endif
        endif
        if (level >= 45 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_45, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n06S_1514), GetUnitY(gg_unit_n06S_1514), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_45, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 45)
            endif
        endif
        if (level >= 50 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_50, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_50, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 50)
            endif
        endif
        if (level >= 55 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_55, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_55, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 55)
            endif
        endif
        if (level >= 60 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_60, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_60, 1)
            if (showMessage and IsPlayerWarlord(owner)) then
                call HeroJourneyMessage(owner, 60)
            endif
        endif
        if (level >= 65 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_65, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_65, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 65)
            endif
        endif
        if (level >= 70 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_70, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_70, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 70)
            endif
        endif
        if (level >= 75 and GetPlayerTechCountSimple(UPG_HERO_LEVEL_75, owner) == 0) then    
            //call PingMinimapForPlayer(owner, GetUnitX(gg_unit_n0I0_0974), GetUnitY(gg_unit_n0I0_0974), 4.00)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_75, 1)
            call SetPlayerTechResearched(owner, UPG_HERO_LEVEL_75_VIP, 1)
            if (showMessage) then
                call HeroJourneyMessage(owner, 75)
            endif
        endif
    endif
endfunction

function UpdateHeroJourneyLevel takes player owner returns nothing
    call ResetHeroJourneyLevel(owner)
    call SetHeroJourneyLevelEx(owner, true, GetHeroLevel1(owner), false)
endfunction

function UpdateHeroJourneyLevelEx takes player owner, integer heroLevel1 returns nothing
    call ResetHeroJourneyLevel(owner)
    call SetHeroJourneyLevelEx(owner, true, heroLevel1, false)
endfunction

private function TriggerConditionLevel takes nothing returns boolean
    call SetHeroJourneyLevelEx(GetOwningPlayer(GetTriggerUnit()), GetPlayerHero1(GetOwningPlayer(GetTriggerUnit())) == GetTriggerUnit(), GetHeroLevel(GetTriggerUnit()), true)
    return false
endfunction

private function Init takes nothing returns nothing
    local trigger levelTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(levelTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(levelTrigger, Condition(function TriggerConditionLevel))
endfunction

endlibrary
