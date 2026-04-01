library WoWReforgedVotes initializer Init requires Votes, WoWReforgedMapData, WoWReforgedTomes, WoWReforgedComputer, WoWReforgedStats
    
function AddWowReforgedVote takes nothing returns nothing
    local integer vote = VoteCreate(udg_TmpString)
    //call VoteAddYesChoice(vote)
    call VoteAddChoice(vote, false, udg_TmpString2, udg_TmpString2)
    call VoteSetStartChatCommand(vote, udg_TmpString2)
    call VoteSetYesTrigger(vote, udg_TmpTrigger)
endfunction

private function Add takes string title, string choice, code triggerAction returns nothing
    local integer vote = VoteCreate(title)
    //call VoteAddYesChoice(vote)
    call VoteAddChoice(vote, false, choice, choice)
    call VoteSetStartChatCommand(vote, choice)
    call VoteSetYesTriggerAction(vote, triggerAction)
endfunction

private function DisplayVoteEnabled takes string name returns nothing
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedStringSafe("VOTE_ENABLED")).s(name).result())
endfunction

private function DisplayVoteDisabled takes string name returns nothing
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedStringSafe("VOTE_DISABLED")).s(name).result())
endfunction

private function Victory takes nothing returns nothing
    set udg_VictoryByKillingArchimonde = true
    call QuestSetTitle(udg_QuestVictory, Format(GetLocalizedStringSafe("IQ_VICTORY_TITLE")).s(GetLocalizedStringSafe("IQ_ENABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("VICTORY"))
    call PlaySoundBJ(gg_snd_VictoryOn)
endfunction

private function NoVictory takes nothing returns nothing
    set udg_VictoryByKillingArchimonde = false
    call QuestSetTitle(udg_QuestVictory, Format(GetLocalizedStringSafe("IQ_VICTORY_TITLE")).s(GetLocalizedStringSafe("IQ_DISABLED")).result())
    call DisplayVoteDisabled(GetLocalizedStringSafe("VICTORY"))
    call PlaySoundBJ(gg_snd_VictoryOff)
endfunction

private function SaveCodes takes nothing returns nothing
    set udg_SaveAndLoadEnabled = true
    call QuestSetTitle(udg_QuestSaveAndLoad, Format(GetLocalizedStringSafe("IQ_SAVE_CODES_TITLE")).s(GetLocalizedStringSafe("IQ_ENABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("SAVE_CODES"))
endfunction

private function NoSaveCodes takes nothing returns nothing
    set udg_SaveAndLoadEnabled = false
    call QuestSetTitle(udg_QuestSaveAndLoad, Format(GetLocalizedStringSafe("IQ_SAVE_CODES_TITLE")).s(GetLocalizedStringSafe("IQ_DISABLED")).result())
    call DisplayVoteDisabled(GetLocalizedStringSafe("SAVE_CODES"))
endfunction

private function EnumFFA takes nothing returns nothing
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[GetPlayerId(GetEnumPlayer())], GetMapLobbyPlayers(), bj_ALLIANCE_UNALLIED)
endfunction

private function FFA takes nothing returns nothing
    call ForForce(GetMapLobbyPlayers(), function EnumFFA)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FFA"))
endfunction

private function EnumLobby takes nothing returns nothing
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[GetPlayerId(GetEnumPlayer())], GetMapLobbyPlayers(), bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[GetPlayerId(GetEnumPlayer())], GetMapTeamPlayers(GetPlayerTeam(GetEnumPlayer())), bj_ALLIANCE_ALLIED)
endfunction

private function Lobby takes nothing returns nothing
    call ForForce(GetMapLobbyPlayers(), function EnumLobby)
    call DisplayVoteEnabled(GetLocalizedStringSafe("LOBBY"))
endfunction

private function EnumUnlock takes nothing returns nothing
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_5, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_10, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_15, 1)    
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_20, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_25, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_30, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_35, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_40, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_BONUS_HEROES, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_45, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_50, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_55, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_60, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_65, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_70, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_HERO_LEVEL_75, 1)
    call SetPlayerTechResearched(GetEnumPlayer(), UPG_DEMIGOD, 1)
endfunction

private function Unlock takes nothing returns nothing
    set udg_UnlockedAll = true
    call ForForce(GetPlayersAll(), function EnumUnlock)
    call DisplayVoteEnabled(GetLocalizedStringSafe("UNLOCK"))
endfunction

private function EnumUpdateHeroJourney takes nothing returns nothing
    call UpdateHeroJourneyLevel(GetEnumPlayer())
endfunction

private function Lock takes nothing returns nothing
    set udg_UnlockedAll = false
    call ForForce(GetPlayersAll(), function EnumUpdateHeroJourney)
    call DisplayVoteEnabled(GetLocalizedStringSafe("LOCK"))
endfunction

private function Tomes takes nothing returns nothing
    set udg_Tomes = true
    call QuestSetTitle(udg_QuestTomes, Format(GetLocalizedStringSafe("IQ_TOMES_TITLE")).s(GetLocalizedStringSafe("IQ_ENABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("TOMES"))
    call ShowLibraries()
endfunction

private function NoTomes takes nothing returns nothing
    set udg_Tomes = false
    call QuestSetTitle(udg_QuestTomes, Format(GetLocalizedStringSafe("IQ_TOMES_TITLE")).s(GetLocalizedStringSafe("IQ_DISABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("NO_TOMES"))
    call HideLibraries()
endfunction

private function Cinematics takes nothing returns nothing
    set udg_Cinematics = true
    call QuestSetTitle(udg_QuestCinematics, Format(GetLocalizedStringSafe("IQ_CINEMATICS_TITLE")).s(GetLocalizedStringSafe("IQ_ENABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("CINEMATICS"))
endfunction

private function NoCinematics takes nothing returns nothing
    set udg_Cinematics = false
    call QuestSetTitle(udg_QuestCinematics, Format(GetLocalizedStringSafe("IQ_CINEMATICS_TITLE")).s(GetLocalizedStringSafe("IQ_DISABLED")).result())
    call DisplayVoteDisabled(GetLocalizedStringSafe("CINEMATICS"))
endfunction

private function AiReset takes nothing returns nothing
    call DisplayVoteEnabled(GetLocalizedStringSafe("AI_RESET"))
    call ResetComputerPlayers()
endfunction

private function AiRespawn takes nothing returns nothing
    set udg_AIRespawn = true
    call QuestSetTitle(udg_QuestAI, Format(GetLocalizedStringSafe("IQ_AI_TITLE")).s(GetLocalizedStringSafe("IQ_ENABLED")).result())
    call DisplayVoteEnabled(GetLocalizedStringSafe("AI_RESPAWN"))
endfunction

private function NoAiRespawn takes nothing returns nothing
    set udg_AIRespawn = false
    call QuestSetTitle(udg_QuestAI, Format(GetLocalizedStringSafe("IQ_AI_TITLE")).s(GetLocalizedStringSafe("IQ_DISABLED")).result())
    call DisplayVoteDisabled(GetLocalizedStringSafe("AI_RESPAWN"))
endfunction

private function Stats takes nothing returns nothing
    call CreateStats()
    call DisplayVoteEnabled(GetLocalizedStringSafe("STATS"))
endfunction

private function NoStats takes nothing returns nothing
    call DestroyStats()
    call DisplayVoteDisabled(GetLocalizedStringSafe("STATS"))
endfunction

private function Init takes nothing returns nothing
    call Add(GetLocalizedStringSafe("VICTORY"), "-victory", function Victory)
    call Add(GetLocalizedStringSafe("NO_VICTORY"), "-novictory", function NoVictory)
    call Add(GetLocalizedStringSafe("SAVE_CODES"), "-savecodes", function SaveCodes)
    call Add(GetLocalizedStringSafe("NO_SAVE_CODES"), "-nosavecodes", function NoSaveCodes)

    call Add(GetLocalizedStringSafe("FFA"), "-ffa", function FFA)
    call Add(GetLocalizedStringSafe("LOBBY"), "-lobby", function Lobby)

    call Add(GetLocalizedStringSafe("UNLOCK"), "-unlock", function Unlock)
    call Add(GetLocalizedStringSafe("LOCK"), "-lock", function Lock)

    call Add(GetLocalizedStringSafe("TOMES"), "-tomes", function Tomes)
    call Add(GetLocalizedStringSafe("NO_TOMES"), "-notomes", function NoTomes)

    call Add(GetLocalizedStringSafe("CINEMATICS"), "-cinematics", function Cinematics)
    call Add(GetLocalizedStringSafe("NO_CINEMATICS"), "-nocinematics", function NoCinematics)

    call Add(GetLocalizedStringSafe("AI_RESET"), "-aireset", function AiReset)

    call Add(GetLocalizedStringSafe("AI_RESPAWN"), "-airespawn", function AiRespawn)
    call Add(GetLocalizedStringSafe("NO_AI_RESPAWN"), "-noairespawn", function NoAiRespawn)

    call Add(GetLocalizedStringSafe("STATS"), "-stats", function Stats)
    call Add(GetLocalizedStringSafe("NO_STATS"), "-nostats", function NoStats)
endfunction

endlibrary
