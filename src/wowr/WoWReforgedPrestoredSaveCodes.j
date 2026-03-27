library WoWReforgedPrestoredSaveCodes initializer Init requires WoWReforgedUtils, WoWReforgedClans, WoWReforgedSaveCodes, WoWReforgedVIPs, WoWReforgedSaveCodeObjects // init after WoWReforgedSaveCodeObjects

globals
    constant integer PRESTORED_SAVECODE_TYPE_HEROES = 0
    constant integer PRESTORED_SAVECODE_TYPE_ITEMS = 1
    constant integer PRESTORED_SAVECODE_TYPE_UNITS = 2
    constant integer PRESTORED_SAVECODE_TYPE_BUILDINGS = 3
    constant integer PRESTORED_SAVECODE_TYPE_RESEARCHES = 4
    constant integer PRESTORED_SAVECODE_TYPE_CLANS = 5
    constant integer PRESTORED_SAVECODE_TYPE_LETTER = 6

    constant integer PRESTORED_SAVECODE_MAX_CLAN_MEMBERS = 20

    string array PrestoredSaveCodePlayerName // can also be the clan name
    string array PrestoredSaveCode
    integer array PrestoredSaveCodeType
    boolean array PrestoredSaveCodeMultiplayer
    string array PrestoredSaveCodePlayerNames // only for clan save codes
    integer array PrestoredSaveCodePlayerRanks // only for clan save codes
    integer array PrestoredSaveCodePlayerNamesCounter // only for clan save codes
    integer PrestoredSaveCodeCounter = 0

    integer lastAddedPrestoredClan = 0

    force prestoredElvenClanMembers = CreateForce()
endglobals

function PlayerIsInElvenClan takes player whichPlayer returns boolean
    return IsPlayerInForce(whichPlayer, prestoredElvenClanMembers)
endfunction

function GetPrestoredClanSaveCodeMatchingPlayer takes integer saveCodeIndex returns player
    local player result = null
    local integer playerRank = -1
    local integer index = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
            set j = 0
            loop
                exitwhen (j >= PrestoredSaveCodePlayerNamesCounter[saveCodeIndex])
                set index = Index2D(saveCodeIndex, j, PRESTORED_SAVECODE_MAX_CLAN_MEMBERS)
                //call BJDebugMsg("Comparing player name " + PrestoredSaveCodePlayerNames[index] + " to online player name " + GetPlayerName(Player(i)))
                if (GetPlayerName(Player(i)) == PrestoredSaveCodePlayerNames[index] and PrestoredSaveCodePlayerRanks[index] > playerRank and udg_ClanPlayerClan[i + 1] == 0) then
                    set result = Player(i)
                    set playerRank = PrestoredSaveCodePlayerRanks[index]
                endif
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
    return result
endfunction

function LoadPrestoredClanSaveCodes takes nothing returns nothing
    local player matchingPlayer = null
    local boolean foundElvenClan = false
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS and PrestoredSaveCodeMultiplayer[i] == not IsInSinglePlayer()) then
            set matchingPlayer = GetPrestoredClanSaveCodeMatchingPlayer(i)
            if (matchingPlayer != null) then
                //call BJDebugMsg("Applying TheElvenClan savecode for player " + GetPlayerName(matchingPlayer))
                call ApplySaveCodeClan(matchingPlayer, PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
                if (PrestoredSaveCodePlayerName[i] == "TheElvenClan") then
                    set foundElvenClan = true
                    set j = 0
                    loop
                        exitwhen (j >= bj_MAX_PLAYERS)
                        if (GetPlayerController(Player(j)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(j)) == PLAYER_SLOT_STATE_PLAYING and udg_ClanPlayerClan[j + 1] > 0 and udg_ClanName[udg_ClanPlayerClan[j + 1]] == "TheElvenClan") then
                            //call BJDebugMsg("Adding player to TheElvenClan")
                            call ForceAddPlayer(prestoredElvenClanMembers, Player(j))
                        endif
                        set j = j + 1
                    endloop
                endif
            endif
        endif
        set i = i + 1
    endloop
    if (not foundElvenClan) then
        //call BJDebugMsg("Did not find TheElvenClan")
    endif
    if (matchingPlayer == null) then
        //call BJDebugMsg("No player of TheElvenClan is online")
    endif
endfunction

function GetPrestoredSaveCodesMax takes nothing returns integer
    return PrestoredSaveCodeCounter
endfunction

function AddPrestoredSaveCodeEx takes integer saveCodeType, string playerName, string saveCode returns integer
    local integer index = PrestoredSaveCodeCounter
    set PrestoredSaveCodePlayerName[index] = playerName
    set PrestoredSaveCode[index] = saveCode
    set PrestoredSaveCodeType[index] = saveCodeType
    set PrestoredSaveCodePlayerNamesCounter[index] = 0
    set PrestoredSaveCodeCounter = PrestoredSaveCodeCounter + 1
    set lastAddedPrestoredClan = index
    return index
endfunction

function AddPrestoredSaveCode takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_HEROES, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeItems takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_ITEMS, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeUnits takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_UNITS, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeBuildings takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_BUILDINGS, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeResearches takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_RESEARCHES, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeLetter takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_LETTER, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeClan takes string clanName, boolean isSinglePlayer, string saveCode returns integer
    local integer result = AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_CLANS, clanName, saveCode)
    set PrestoredSaveCodeMultiplayer[result] = not isSinglePlayer
    return result
endfunction

function AddPrestoredSaveCodeClanPlayer takes string playerName, integer playerRank returns integer
    local integer saveCodePlayerIndex = PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan]
    local integer index = Index2D(lastAddedPrestoredClan, saveCodePlayerIndex, PRESTORED_SAVECODE_MAX_CLAN_MEMBERS)
    set PrestoredSaveCodePlayerNames[index] = playerName
    set PrestoredSaveCodePlayerRanks[index] = playerRank
    set PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan] = PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan] + 1
    return saveCodePlayerIndex
endfunction

function GetPrestoredSaveCodePlayerNameByIndex takes integer index returns string
    return PrestoredSaveCodePlayerName[index]
endfunction

function GetPrestoredSaveCodeByIndex takes integer index returns string
    return PrestoredSaveCode[index]
endfunction

function GetPrestoredSaveCodeTypeByIndex takes integer index returns integer
    return PrestoredSaveCodeType[index]
endfunction

function GetPrestoredSaveCodeMemberPlayerName takes integer index returns string
    return PrestoredSaveCodePlayerNames[index]
endfunction

function GetPrestoredSaveCodeMemberPlayerRank takes integer index returns integer
    return PrestoredSaveCodePlayerRanks[index]
endfunction

function GetPrestoredSaveCodeCounter takes string playerName returns integer
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName) then
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return counter
endfunction

function GetPrestoredSaveCodeIndices takes string playerName returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result + "- " + I2S(i)
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeAccounts takes nothing returns string
    local string result = ""
    local string array onlinePlayers
    local player array onlinePlayersMatching
    local integer onlinePlayersCounter = 0
    local string array offlinePlayers
    local integer offlinePlayersCounter = 0
    local player matchingPlayer = null
    local boolean add = true
    local integer counter = 0
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] != PRESTORED_SAVECODE_TYPE_CLANS and PrestoredSaveCodePlayerName[i] != "all") then
            set add = true
            set matchingPlayer = null
            set j = 0
            loop
                exitwhen (j >= bj_MAX_PLAYERS or matchingPlayer != null)
                if (GetPlayerName(Player(j)) == PrestoredSaveCodePlayerName[i]) then
                    set matchingPlayer = Player(j)
                endif
                set j = j + 1
            endloop
            if (matchingPlayer != null) then
                set j = 0
                loop
                    exitwhen (j >= onlinePlayersCounter or not add)
                    if (onlinePlayers[j] == PrestoredSaveCodePlayerName[i]) then
                        set add = false
                    endif
                    set j = j + 1
                endloop
                if (add) then
                    set onlinePlayers[onlinePlayersCounter] = PrestoredSaveCodePlayerName[i]
                    set onlinePlayersMatching[onlinePlayersCounter] = matchingPlayer
                    set onlinePlayersCounter = onlinePlayersCounter + 1
                endif
            else
                set j = 0
                loop
                    exitwhen (j >= offlinePlayersCounter or not add)
                    if (offlinePlayers[j] == PrestoredSaveCodePlayerName[i]) then
                        set add = false
                    endif
                    set j = j + 1
                endloop
                if (add) then
                    set offlinePlayers[offlinePlayersCounter] = PrestoredSaveCodePlayerName[i]
                    set offlinePlayersCounter = offlinePlayersCounter + 1
                endif
            endif
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= onlinePlayersCounter)
        if (counter > 0) then
            set result = result + "\n"
        endif

        set result = result + GetPlayerNameColored(onlinePlayersMatching[i])
        if (GetPlayerClan(onlinePlayersMatching[i]) != 0) then
            set result = result + " (" + GetClanName(GetPlayerClan(onlinePlayersMatching[i])) + ")"
        endif
        if (IsPlayerVIP(onlinePlayersMatching[i])) then
            set result = result + " (VIP)"
        endif
        set counter = counter + 1
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= offlinePlayersCounter)
        if (counter > 0) then
            set result = result + "\n"
        endif

        set result = result  + offlinePlayers[i] + " (offline)"
         if (IsAccountVIP(offlinePlayers[i])) then
            set result = result + " (VIP)"
        endif
        set counter = counter + 1
        set i = i + 1
    endloop

    return result
endfunction

// only shows matching savecodes to keep the number limited
function GetPrestoredSaveCodeInfos takes player whichPlayer returns string
    local string playerName = GetPlayerName(whichPlayer)
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName or PrestoredSaveCodePlayerName[i] == "all" or (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS and AccountNameBelongsToClanSaveCode(PrestoredSaveCodePlayerName[i], playerName, PrestoredSaveCode[i]))) then
            if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_HEROES and GetSaveCodeIsMatching(whichPlayer, PrestoredSaveCode[i])) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadp " + I2S(i) + ": " + GetSaveCodeShortInfos(playerName, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_ITEMS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpi " + I2S(i) + ": " + GetSaveCodeShortInfosItems(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_UNITS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpu " + I2S(i) + ": " + GetSaveCodeShortInfosUnits(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_BUILDINGS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpb " + I2S(i) + ": " + GetSaveCodeShortInfosBuildings(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_RESEARCHES) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpr " + I2S(i) + ": " + GetSaveCodeShortInfosResearches(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
//             elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_LETTER) then
//                 if (counter > 0) then
//                     set result = result + "\n"
//                 endif
//
//                 set result = result  + "-loadpl " + I2S(i) + ": " + GetSaveCodeShortInfosLetter(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
//
//                 set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadclanp " + I2S(i) + ": " + GetSaveCodeShortInfosClan(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])

                set counter = counter + 1
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeInfosClans takes nothing returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result  + "- " + I2S(i) + ": " + GetSaveCodeShortInfosClan(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeClans takes string accountName returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS and AccountNameBelongsToClanSaveCode(PrestoredSaveCodePlayerName[i], accountName, PrestoredSaveCode[i])) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result  + "- " + I2S(i) + ": " + GetSaveCodeShortInfosClan(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeInfosLetters takes player whichPlayer returns string
    local string result = ""
    local string playerName = GetPlayerName(whichPlayer)
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_LETTER and (PrestoredSaveCodePlayerName[i] == playerName or PrestoredSaveCodePlayerName[i] == "all" or (udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)] > 0 and udg_ClanName[udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)]] == PrestoredSaveCodePlayerName[i]))) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result  + "-loadpl " + I2S(i) + ": " + GetSaveCodeShortInfosLetter(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeMaxLevelIndex takes string skipPlayerName1, string skipPlayerName2, string skipPlayerName3 returns integer
    local integer maxLevel = 0
    local integer tmpMaxLevel = 0
    local integer result = -1
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if ((skipPlayerName1 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName1) and (skipPlayerName2 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName2) and (skipPlayerName3 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName3)) then
            set tmpMaxLevel = GetSaveCodeMaxHeroLevel(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set tmpMaxLevel = IMinBJ(tmpMaxLevel, MAX_HERO_LEVEL)
            if (tmpMaxLevel > maxLevel) then
                set maxLevel = tmpMaxLevel
                set result = i
            endif
        endif
        set i = i + 1
    endloop

    return result
endfunction

function IsValidAccount takes string name returns boolean
    return GetPrestoredSaveCodeCounter(name) > 0
endfunction

function DisplayAccountInfo takes player to, string account returns nothing
    local string prestored = "Prestored savecodes: " + I2S(GetPrestoredSaveCodeCounter(account))
    local string clans = "Clans: " + GetPrestoredSaveCodeClans(account)
    call DisplayTimedTextToPlayer(to, 0, 0, 20.0, account + "):\n" + prestored + "\n- " + clans)
endfunction

private function EnumGeneratePrestoredForVip takes nothing returns nothing
    if (IsPlayerVIP(GetEnumPlayer())) then
        call AddPrestoredSaveCode(GetPlayerName(GetEnumPlayer()), GetSaveCodeEx(null, GetPlayerName(GetEnumPlayer()), false, true, R2I(udg_WarlordXPRate), 10, 50049900, 10, 50049900, 10, 50049900, 10000, 10000, 3, 0, 0))
        call AddPrestoredSaveCodeItems(GetPlayerName(GetEnumPlayer()), GetSaveCodeItemsEx3(GetPlayerName(GetEnumPlayer()), false, true, R2I(udg_WarlordXPRate), false, 0, ITEM_GLOVES_OF_HASTE, 1, ITEM_POTION_OF_INVULNERABILITY, 1, ITEM_SCROLL_OF_RESTORATION, 5, ITEM_ANKH_OF_REINCARNATION, 5, ITEM_HEALING_WARDS, 5, ITEM_HEALTH_STONE, 5))
        call AddPrestoredSaveCodeUnits(GetPlayerName(GetEnumPlayer()), GetSaveCodeUnitsEx3(GetPlayerName(GetEnumPlayer()), false, true, R2I(udg_WarlordXPRate), false, 0, RED_DRAGON, 1, GREEN_DRAGON, 1, BLACK_DRAGON, 1, BLUE_DRAGON, 1, BRONZE_DRAGON, 1, NETHER_DRAGON, 30, 0, 0, 0, 0))
    endif
endfunction

// Add all prestored savecodes into this function
private function Init takes nothing returns nothing
    // ##############################################################
    // WorldOfWarcraftReforged-letter-from_Barade#2569-to_all-messageLength_15.txt
    // Hello citizens!
    call AddPrestoredSaveCodeLetter("all", GetSaveCodeLetter(false, "Barade#2569", "all", "Hello citizens!"))
    // ##############################################################
    // WorldEdit
    call AddPrestoredSaveCode("WorldEdit", GetSaveCodeEx(null, "WorldEdit", false, true, R2I(udg_WarlordXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    call AddPrestoredSaveCode("WorldEdit", GetSaveCodeEx(null, "WorldEdit", false, false, R2I(udg_WarlordXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    call AddPrestoredSaveCode("WorldEdit", GetSaveCodeEx(null, "WorldEdit", true, true, R2I(udg_FreelancerXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    call AddPrestoredSaveCode("WorldEdit", GetSaveCodeEx(null, "WorldEdit", true, false, R2I(udg_FreelancerXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    // ##############################################################
    // Barade#2569
    // Multiplayer - Warlord
    call AddPrestoredSaveCode("Barade#2569", GetSaveCodeEx(null, "Barade#2569", false, true, R2I(udg_WarlordXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    call AddPrestoredSaveCodeItems("Barade#2569", GetSaveCodeItemsEx3("Barade#2569", false, true, R2I(udg_WarlordXPRate), false, 0, ITEM_GLOVES_OF_HASTE, 100, ITEM_POTION_OF_INVULNERABILITY, 100, ITEM_SCROLL_OF_RESTORATION, 100, ITEM_ANKH_OF_REINCARNATION, 100, ITEM_HEALING_WARDS, 100, ITEM_HEALTH_STONE, 100))
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-buildings-7-Guard Tower,Guard Tower,Altar of Kings,Lumber Mill,Arcane Vault,Workshop,Barracks.txt
    call AddPrestoredSaveCodeBuildings("Barade#2569", "!,(!(-(S:(f()HV(SPN(f()HV(SHg(k().5(S]g(e()sC(SAC(,()8h(SQs(3()8h(Sc2(@()89(SN-(!~(")
    call AddPrestoredSaveCodeUnits("Barade#2569", GetSaveCodeUnitsEx3("Barade#2569", false, true, R2I(udg_WarlordXPRate), false, 0, RED_DRAGON, 30, GREEN_DRAGON, 30, BLACK_DRAGON, 30, BLUE_DRAGON, 30, BRONZE_DRAGON, 30, NETHER_DRAGON, 30, 0, 0, 0, 0))
    // Multiplayer - Freelancer
    call AddPrestoredSaveCode("Barade#2569", GetSaveCodeEx(null, "Barade#2569", false, false, R2I(udg_WarlordXPRate), 75, 50049900, 75, 50049900, 75, 50049900, 800000, 800000, 75, 2, 3))
    // Klekot#2393
    call AddPrestoredSaveCode("Klekot#2393", "Phc>c>cj2c[dqcNkWcPWecMcMcMcMcMc>PcUcRicPcPUcmcMcMcMcMcMcMcP3c")
    // ##############################################################
    // CLANS
    // MULTIPLAYER
    // TheElvenClan
    // WorldOfWarcraftReforged-Clan-TheElvenClan-Barade#2569-Multiplayer-gold-40000-lumber-40000-members-5.txt
    // Barade#2569_Leader, WorldEdit_Leader, Runeblade14#2451_Captain, AntiDenseMan#1202_Captain, Chaoskrieger#21738_Captain
    call AddPrestoredSaveCodeClan("TheElvenClan", false, GetSaveCodeClanEx(false, "TheElvenClan", CLAN_BANNER_NIGHT_ELF, 0, 40000, 40000, true, "Barade#2569", udg_ClanRankLeader, "WorldEdit", udg_ClanRankLeader, "Runeblade14#2451", udg_ClanRankLeader, "AntiDenseMan#1202_Captain", udg_ClanRankLeader, "Chaoskrieger#21738_Captain", udg_ClanRankLeader, "", 0, "", 0, 5))
    call AddPrestoredSaveCodeClanPlayer("Barade#2569", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("WorldEdit", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Barade", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Runeblade14#2451", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("AntiDenseMan#1202", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("Chaoskrieger#21738", udg_ClanRankCaptain)
    // B.O.O.M.
    call AddPrestoredSaveCodeClan("B.O.O.M.", false, GetSaveCodeClanEx(false, "B.O.O.M.", CLAN_BANNER_NIGHT_ELF, 0, 2000200, 80100, true, "MedievalMan#1244", udg_ClanRankLeader, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, 1))
    call AddPrestoredSaveCodeClanPlayer("MedievalMan#1244", udg_ClanRankLeader)
    // SINGLEPLAYER
    // TheElvenClan
    // WorldOfWarcraftReforged-Clan-TheElvenClan-Barade#2569-Singleplayer-gold-40000-lumber-40000-members-5.txt
    // Barade#2569_Leader, WorldEdit_Leader, Barade#2569_Leader, Runeblade14#2451_Captain, AntiDenseMan#1202_Captain, Chaoskrieger#21738_Captain
    call AddPrestoredSaveCodeClan("TheElvenClan", true, GetSaveCodeClanEx(true, "TheElvenClan", CLAN_BANNER_NIGHT_ELF, 0, 40000, 40000, true, "Barade#2569", udg_ClanRankLeader, "WorldEdit", udg_ClanRankLeader, "Runeblade14#2451", udg_ClanRankLeader, "AntiDenseMan#1202_Captain", udg_ClanRankLeader, "Chaoskrieger#21738_Captain", udg_ClanRankLeader, "", 0, "", 0, 5))
    call AddPrestoredSaveCodeClanPlayer("Barade#2569", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("WorldEdit", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Barade", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Runeblade14#2451", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("AntiDenseMan#1202", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("Chaoskrieger#21738", udg_ClanRankCaptain)
    // B.O.O.M.
    call AddPrestoredSaveCodeClan("B.O.O.M.", true, GetSaveCodeClanEx(true, "B.O.O.M.", CLAN_BANNER_NIGHT_ELF, 0, 2000200, 80100, true, "MedievalMan#1244", udg_ClanRankLeader, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, 1))
    call AddPrestoredSaveCodeClanPlayer("MedievalMan#1244", udg_ClanRankLeader)
    
    // VIPs
    call ForForce(GetPlayersAll(), function EnumGeneratePrestoredForVip)
    
    // Make sure that none of the prestored save codes counts as generated.
    call ClearGeneratedSaveCodes()
endfunction

endlibrary
