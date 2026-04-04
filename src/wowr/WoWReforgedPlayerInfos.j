library WoWReforgedPlayerInfos requires StringUtils, WoWReforgedUtils, WoWReforgedVIPs, WoWReforgedStartLocations, WoWReforgedResearches, WoWReforgedRaces, WoWReforgedI18n
// Make sure no string literal has more than 1023 characters.

function GetHelpText takes nothing returns string
    return "-h/-help, -helpping, -helpai, -helpally, -helpcamera, -helpvisual, -helpresources, -helpattributes, -helpsave, -helpfood, -helptime, -helpreset, -helpcheats, -c/-clear, -uion/off, -uiqueueon/off, -uiqueueclear, -d/-discord, -w/-website, -o/-download, -v/-version, -q/-news, -x/-revive, -l/-log, -dp/-diplomacy, -sel, -host, -p/-players, -a/-accounts, -i/-info X, -qr/-questrewards, -gold X Y, -lumber X Y, -cooldowns, -aireset, -repick, -fullrepick, -g/-get, -auto, -e/-enchanter, -n/-inscriptor, -log, -it/-items, -pi/pickup, -o/-order, -baginfoon/off, -baguion/off -h1/2/3, -p1/2/3, -r1/2/3, -passive, -k/-suicide, -anim X, -gaiaon/off, -camlockon/off, -votekick X, -yes, -wrapup, -goblindeposit, -maxbosslevels, -z/-zoneson/off, -letter X Y, -mailbox, -dice X, -unlock, -lock, -tomes, -notomes, -legion, -nolegion, -vips, -vipson/off, -mountname1/2/3 X"
endfunction

function GetHelpTextPing takes nothing returns string
    return "-ping, -pingh, -pingf, -pingl, -pingm, -pingbosses/pingb/bosses, -pingportals, -pingkey, -pingdragons, -pinggoldmines, -pingnpcs, -pingaistarts, -pingproperties, -pingaltars, -pingres/resurrectionstones, -pingrace, -pinghuman, -pingvillage, -pingdalaran, -pingkultiras, -pingnightelf, -pingorc, -pingnaga, -pingbloodelf, -pingforsaken, -pinglichking, -pingdraenei, -pingdemon, -pingpanda, -pingeredar, -pingtuskarr, -pinggoblin, -pingjaina"
endfunction

function GetHelpTextAi takes nothing returns string
    return "-areset, -airespawn/-noairespawn, -aieasy X, -ainormal X, -aihard X, -aiinsane X, -ainone X, -aineutral X- aicreep X, -aicomputer X, -aion/off X, -aiignoreall X, -aiignore, -aiuse, -aiattackson/off X, -aiattacksplayerson/off X, -aishipson/off X, -aigold/wood X, -aiexpansions X Y, -aishredders X Y, -aizeppelins X Y, -aihero X Y Z, -ailoadmines X, -airevive X, -aiprofession X Y, -aiinfo X, -aitargeton/off X, -aitarget X, -aitraceon/off"
endfunction

function GetHelpTextAlly takes nothing returns string
    return "-ffa, -lobby, -friends, -enemies, -neutralall, -visionall, -novision, -controlall, -nocontrol, -ai, -noai, -ally X, -unally X, -neutral X, -vision X, -unvision X, -control X, -uncontrol X"
endfunction

function GetHelpTextVisual takes nothing returns string
    return "-hide/-show, -uion/off, -uiqueueon/off, -stats, -nostats, -playername X Y, -playercolor X Y, -scale 0.3-4.0, -scalereset, -color X, -colorreset, -transparency 0-70, -teamcolor X, -rename Y X, -say X, -shout X"
endfunction

function GetHelpTextResources takes nothing returns string
    return "-resgui, -resguion/off, -resources, -resinfo, -sell X Y, -buy X Y, -sellall, -sellwood"
endfunction

function GetHelpTextAttributes takes nothing returns string
    return "-str X, -agi X, -int X, -reseta, -equala"
endfunction

function GetHelpTextSave takes nothing returns string
    return "-save, -savec, -savegui, -asave, -aload, -load[i/u/b/r/l] X, -generated"
endfunction

function GetHelpTextFood takes nothing returns string
    return "-food50, -food100, -food200, -food300, -food600"
endfunction

function GetHelpTextTime takes nothing returns string
    return "-time, -dnc, -nodnc, -morning, -noon, -evening, -midnight, -seasons, -noseasons, -winter, -spring, -summer, -fall. -weather, -noweather"
endfunction

function GetHelpTextReset takes nothing returns string
    return "-resetevolution X"
endfunction

function GetVersionMessage takes nothing returns string
    return Format(GetLocalizedString("VERSION_X")).s(MAP_VERSION).result()
endfunction

function ShowPlayers takes player to returns nothing
    local player listedPlayer = null
    local string vip = ""
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set listedPlayer = Player(i)
        if (GetPlayerSlotState(listedPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            if (IsPlayerVIP(listedPlayer)) then
                set vip = ", VIP"
            else 
                set vip = ""
            endif
            call DisplayTimedTextToPlayer(to, 0, 0, 20.0, I2S(GetPlayerTeam(listedPlayer) + 1) + " [" + I2S(i + 1) + "]" + GetPlayerColorString(GetPlayerColor(listedPlayer), GetPlayerName(listedPlayer)) + ": " + GetPlayerColorName(listedPlayer) + vip)
        endif
        set listedPlayer = null
        set i = i + 1
    endloop
endfunction

function DisplayStats takes player to, player from returns nothing
    local integer playerId = GetPlayerId(from)
    local integer convertedPlayerId = GetConvertedPlayerId(from)
    local string team = GetLocalizedString("UNKNOWN")
    local string warlord = GetLocalizedString("WARLORD")
    local string vip = ""
    local string heroName1 = "-"
    local string heroName2 = "-"
    local string heroName3 = "-"
    local string heroLevel1 = "-"
    local string heroLevel2 = "-"
    local string heroLevel3 = "-"
    local integer heroKills = GetPlayerScore(from, PLAYER_SCORE_HEROES_KILLED) // PLAYER_SCORE_HEROES_KILLED
    local integer unitKills = GetPlayerScore(from, PLAYER_SCORE_UNITS_KILLED) // PLAYER_SCORE_UNITS_KILLED
    local integer buildingsRazed = GetPlayerScore(from, PLAYER_SCORE_STRUCT_RAZED)
    local integer bossesKilled = udg_BossKills[convertedPlayerId]
    local integer bossesMax = BlzGroupGetSize(udg_Bosses)
    local string race1 = "-"
    local string race2 = "-"
    local string race3 = "-"
    local string profession1 = "-"
    local string profession2 = "-"
    local string profession3 = "-"
    local integer gold = GetPlayerState(from, PLAYER_STATE_RESOURCE_GOLD)
    local integer lumber = GetPlayerState(from, PLAYER_STATE_RESOURCE_LUMBER)
    local integer foodUsed = GetPlayerState(from, PLAYER_STATE_RESOURCE_FOOD_USED)
    local integer foodMax = IMinBJ(GetPlayerState(from, PLAYER_STATE_FOOD_CAP_CEILING), GetPlayerState(from, PLAYER_STATE_RESOURCE_FOOD_CAP))
    local integer xpRate = R2I(GetPlayerHandicapXP(from) * 100.0)
    local integer evolutionLevel = GetPlayerTechCountSimple(UPG_EVOLUTION, from)

    if (GetPlayerTeam(from) == TEAM_ALLIANCE) then
        set team = ", " + GetLocalizedString("ALLIANCE")
    elseif (GetPlayerTeam(from) == TEAM_HORDE) then
        set team = ", " + GetLocalizedString("HORDE")
    else
        set team = ", -"
    endif

    if (not IsPlayerWarlord(from)) then
        set warlord = GetLocalizedString("FREELANCER")
    endif

    if (IsPlayerVIP(from)) then
        set vip = ", VIP"
    endif

    if (GetPlayerHero1(from) != null) then
        set heroName1 = GetUnitName(GetPlayerHero1(from))
        set heroLevel1 = I2S(GetHeroLevel1(from))
    endif

    if (GetPlayerHero2(from) != null) then
        set heroName2 = GetUnitName(GetPlayerHero2(from))
        set heroLevel2 = I2S(GetHeroLevel2(from))
    endif

    if (GetPlayerHero3(from) != null) then
        set heroName3 = GetUnitName(GetPlayerHero3(from))
        set heroLevel3 = I2S(GetHeroLevel3(from))
    endif

    if (GetPlayerRace1(from) != udg_RaceNone) then
        set race1 = GetRaceName(GetPlayerRace1(from)) + " (" + I2S(R2I(GetResearchesPercentageForRace(GetPlayerRace1(from), from))) + " %%)"
    endif

    if (GetPlayerRace2(from) != udg_RaceNone) then
        set race2 = GetRaceName(GetPlayerRace2(from)) + " (" + I2S(R2I(GetResearchesPercentageForRace(GetPlayerRace2(from), from))) + " %%)"
    endif

    if (GetPlayerRace3(from) != udg_RaceNone) then
        set race2 = GetRaceName(GetPlayerRace3(from)) + " (" + I2S(R2I(GetResearchesPercentageForRace(GetPlayerRace3(from), from))) + " %%)"
    endif

    if (GetPlayerProfession1(from) != udg_ProfessionNone) then
        set profession1 = GetProfessionName(GetPlayerProfession1(from))
    endif

    if (GetPlayerProfession2(from) != udg_ProfessionNone) then
        set profession2 = GetProfessionName(GetPlayerProfession2(from))
    endif

    if (GetPlayerProfession3(from) != udg_ProfessionNone) then
        set profession1 = GetProfessionName(GetPlayerProfession3(from))
    endif

    call DisplayTimedTextToPlayer(to, 0, 0, 20.0, Format(GetLocalizedString("PLAYER_INFOS")).s(GetPlayerNameColored(from)).s(warlord).s(vip).s(team).i(xpRate).s(heroName1).s(heroLevel1).s(heroName2).s(heroLevel2).s(heroName3).s(heroLevel3).s(race1).s(race2).s(race3).s(profession1).s(profession2).s(profession3).i(gold).i(lumber).i(foodUsed).i(foodMax).i(evolutionLevel).i(heroKills).i(unitKills).i(buildingsRazed).i(bossesKilled).i(bossesMax).result())
endfunction

private function GetPlayerSelectionModeName takes integer mode returns string
    if (mode == udg_PlayerSelectionModeInitial) then
        return GetLocalizedString("PLAYER_SELECTION_INITIAL")
    elseif (mode == udg_PlayerSelectionModeRepick) then
        return GetLocalizedString("PLAYER_SELECTION_REPICK")
    elseif (mode == udg_PlayerSelectionModeRepickFull) then
        return GetLocalizedString("PLAYER_SELECTION_REPICK_FULL")
    elseif (mode == udg_PlayerSelectionModeRepickHero1) then
        return Format(GetLocalizedString("PLAYER_SELECTION_HERO_X")).i(1).result()
    elseif (mode == udg_PlayerSelectionModeRepickHero2) then
        return Format(GetLocalizedString("PLAYER_SELECTION_HERO_X")).i(2).result()
    elseif (mode == udg_PlayerSelectionModeRepickHero3) then
        return Format(GetLocalizedString("PLAYER_SELECTION_HERO_X")).i(3).result()
    elseif (mode == udg_PlayerSelectionModeRepickProf1) then
        return Format(GetLocalizedString("PLAYER_SELECTION_PROFESSION_X")).i(1).result()
    elseif (mode == udg_PlayerSelectionModeRepickProf2) then
        return Format(GetLocalizedString("PLAYER_SELECTION_PROFESSION_X")).i(2).result()
    elseif (mode == udg_PlayerSelectionModeRepickProf3) then
        return Format(GetLocalizedString("PLAYER_SELECTION_PROFESSION_X")).i(3).result()
    elseif (mode == udg_PlayerSelectionModeRepickRace1) then
        return Format(GetLocalizedString("PLAYER_SELECTION_RACE_X")).i(1).result()
    elseif (mode == udg_PlayerSelectionModeRepickRace2) then
        return Format(GetLocalizedString("PLAYER_SELECTION_RACE_X")).i(2).result()
    elseif (mode == udg_PlayerSelectionModeRepickRace3) then
        return Format(GetLocalizedString("PLAYER_SELECTION_RACE_X")).i(3).result()
    endif
    return "-"
endfunction
    
function GetPlayerSelectionSettings takes player whichPlayer returns string
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    local string playerSelectionMode = GetPlayerSelectionModeName(udg_PlayerSelectionMode[convertedPlayerId])
    local string mode = "-"
    local string hero1 = "-"
    local string hero2 = "-"
    local string hero3 = "-"
    local string race1 = "-"
    local string race2 = "-"
    local string race3 = "-"
    local string profession1 = "-"
    local string profession2 = "-"
    local string profession3 = "-"
    local string startLocation = "-"

    if (udg_PlayerSelectionGameMode[convertedPlayerId] == 0) then
        set mode = GetLocalizedString("WARLORD")
    endif

    if (udg_PlayerSelectionGameMode[convertedPlayerId] == 1) then
        set mode = GetLocalizedString("FREELANCER")
    endif

    if (GetPlayerHero1(whichPlayer) != null) then
        set hero1 = GetUnitName(GetPlayerHero1(whichPlayer))
    endif

    if (GetPlayerHero2(whichPlayer) != null) then
        set hero2 = GetUnitName(GetPlayerHero2(whichPlayer))
    endif

    if (GetPlayerHero3(whichPlayer) != null) then
        set hero3 = GetUnitName(GetPlayerHero3(whichPlayer))
    endif

    if (udg_PlayerSelectionRace1[convertedPlayerId] != udg_RaceNone) then
        set race1 = GetRaceName(udg_PlayerSelectionRace1[convertedPlayerId])
    endif

    if (udg_PlayerSelectionRace2[convertedPlayerId] != udg_RaceNone) then
        set race2 = GetRaceName(udg_PlayerSelectionRace2[convertedPlayerId])
    endif

    if (udg_PlayerSelectionRace3[convertedPlayerId] != udg_RaceNone) then
        set race3 = GetRaceName(udg_PlayerSelectionRace3[convertedPlayerId])
    endif

    if (udg_PlayerSelectionProfession1[convertedPlayerId] != udg_ProfessionNone) then
        set profession1 = GetProfessionName(udg_PlayerSelectionProfession1[convertedPlayerId])
    endif

    if (udg_PlayerSelectionProfession2[convertedPlayerId] != udg_ProfessionNone) then
        set profession2 = GetProfessionName(udg_PlayerSelectionProfession2[convertedPlayerId])
    endif

    if (udg_PlayerSelectionProfession3[convertedPlayerId] != udg_ProfessionNone) then
        set profession3 = GetProfessionName(udg_PlayerSelectionProfession3[convertedPlayerId])
    endif

    set startLocation = GetStartLocationName(udg_PlayerSelectionStartLocation[convertedPlayerId])

    return Format(GetLocalizedString("PLAYER_SELECTION_SETTINGS")).s(playerSelectionMode).s(mode).s(hero1).s(hero2).s(hero3).s(race1).s(race2).s(race3).s(profession1).s(profession2).s(profession3).s(startLocation).result()
endfunction

function DisplayItemCarryMessage takes player whichPlayer, item whichItem returns nothing
    call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)], Format(GetLocalizedString("YOU_ARE_CARRYING_NOW_THE_X")).s(GetItemName(GetLastCreatedItem())).result())
endfunction

function PickHero1Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_HERO_X")).i(1).result())
endfunction

function PickHero2Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_HERO_X")).i(2).result())
endfunction

function PickHero3Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_HERO_X")).i(3).result())
endfunction

function PickProfession1Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_PROFESSION_X")).i(1).result())
endfunction

function PickProfession2Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_PROFESSION_X")).i(2).result())
endfunction

function PickProfession3Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_PROFESSION_X")).i(3).result())
endfunction

function PickRace1Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_RACE_X")).i(1).result())
endfunction

function PickRace2Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_RACE_X")).i(2).result())
endfunction

function PickRace3Info takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedStringSafe("PICK_RACE_X")).i(3).result())
endfunction

function SimErrorHero2Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_LEVEL_REQUIREMENT")).i(HERO_JOURNEY_HERO_2).result())
endfunction

function SimErrorHero3Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_3_REQUIREMENT")).i(HERO_JOURNEY_HERO_3).result())
endfunction

function SimErrorProfession2Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_LEVEL_REQUIREMENT")).i(HERO_JOURNEY_PROFESSION_2).result())
endfunction

function SimErrorProfession3Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_LEVEL_REQUIREMENT")).i(HERO_JOURNEY_PROFESSION_3).result())
endfunction

function SimErrorRace2Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_LEVEL_REQUIREMENT")).i(HERO_JOURNEY_RACE_2).result())
endfunction

function SimErrorRace3Requirement takes player whichPlayer returns nothing
    call SimError(whichPlayer, Format(GetLocalizedStringSafe("HERO_LEVEL_REQUIREMENT")).i(HERO_JOURNEY_RACE_3).result())
endfunction

function DefeatBossMessage takes player whichPlayer, unit boss returns nothing
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_WARNING, Format(GetLocalizedStringSafe("X_HAS_DEFEATED_Y")).s(GetPlayerNameColored(whichPlayer)).s(GetHeroProperName(boss)).result())
endfunction

endlibrary
