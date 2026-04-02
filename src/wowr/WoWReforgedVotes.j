library WoWReforgedVotes initializer Init requires Votes, WoWReforgedMapData, WoWReforgedTomes, WoWReforgedComputer, WoWReforgedStats, WoWReforgedBuilder, WoWReforgedCalendar

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
    call DisableAllianceChangesTrigger()
    call ForForce(GetMapLobbyPlayers(), function EnumFFA)
    call EnableAllianceChangesTrigger()
    call DisplayVoteEnabled(GetLocalizedStringSafe("FFA"))
endfunction

private function EnumLobby takes nothing returns nothing
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[GetPlayerId(GetEnumPlayer())], GetMapLobbyPlayers(), bj_ALLIANCE_UNALLIED)
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[GetPlayerId(GetEnumPlayer())], GetMapTeamPlayers(GetPlayerTeam(GetEnumPlayer())), bj_ALLIANCE_ALLIED)
endfunction

private function Lobby takes nothing returns nothing
    call DisableAllianceChangesTrigger()
    call ForForce(GetMapLobbyPlayers(), function EnumLobby)
    call EnableAllianceChangesTrigger()
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
    call ResetComputerPlayers()
    call DisplayVoteEnabled(GetLocalizedStringSafe("AI_RESET"))
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

private function Builder takes nothing returns nothing
    if (not udg_SaveAndLoadEnabled) then
        call CreateAllBuilders()
        call DisplayVoteEnabled(GetLocalizedStringSafe("BUILDER"))
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("BUILDER_NO_SAVE_CODES"))
    endif
endfunction

private function NoBuilder takes nothing returns nothing
    call RemoveAllBuilders()
    call DisplayVoteDisabled(GetLocalizedStringSafe("BUILDER"))
endfunction

private function AmbientSound takes nothing returns nothing
    call SetAmbientDaySound("SunkenRuinsDay")
    call SetAmbientNightSound("SunkenRuinsNight")
endfunction

private function AmbientSoundAshenvale takes nothing returns nothing
    call SetAmbientDaySound("AshenvaleDay")
    call SetAmbientNightSound("AshenvaleNight")
endfunction

private function AmbientSoundLordaeronSummer takes nothing returns nothing
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
endfunction

private function NoAmbientSound takes nothing returns nothing
    call SetAmbientDaySound("")
    call SetAmbientNightSound("")
endfunction

private function Sky takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
endfunction

private function SkyAshenvale takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\AshenvaleSky\\AshenvaleSky.mdl")
endfunction

private function SkyBarrens takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\BarrensSky\\BarrensSky.mdl")
endfunction

private function SkyBlizzard takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\BlizzardSky\\BlizzardSky.mdl")
endfunction

private function SkyDalaran takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\DalaranSky\\DalaranSky.mdl")
endfunction

private function SkyDalaranRuins takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\DalaranRuinsSky\\DalaranRuinsSky.mdl")
endfunction

private function SkyFelwood takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\FelwoodSky\\FelwoodSky.mdl")
endfunction

private function SkyFogged takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\FoggedSky\\FoggedSky.mdl")
endfunction

private function SkyGeneric takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\Sky\\SkyLight.mdl")
endfunction

private function SkyMoon takes nothing returns nothing
    call SetSkyModel("war3mapImported\\MoonySky.mdx")
endfunction

private function EnumFood50 takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 50)
endfunction

private function Food50 takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumFood50)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOOD_50"))
endfunction

private function EnumFood100 takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 100)
endfunction

private function Food100 takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumFood100)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOOD_100"))
endfunction

private function EnumFood200 takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 200)
endfunction

private function Food200 takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumFood200)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOOD_200"))
endfunction

private function EnumFood300 takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 300)
endfunction

private function Food300 takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumFood300)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOOD_300"))
endfunction

private function EnumFood600 takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 600)
endfunction

private function Food600 takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumFood600)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOOD_600"))
endfunction

private function Limits takes nothing returns nothing
    call AddRacesLimits()
    call DisplayVoteEnabled(GetLocalizedStringSafe("LIMITS"))
endfunction

private function NoLimits takes nothing returns nothing
    call ResetRacesLimits()
    call DisplayVoteDisabled(GetLocalizedStringSafe("LIMITS"))
endfunction

private function Seasons takes nothing returns nothing
    call EnableSeasons()
    call DisplayVoteEnabled(GetLocalizedStringSafe("SEASONS"))
endfunction

private function NoSeasons takes nothing returns nothing
    call DisableSeasons()
    call DisplayVoteDisabled(GetLocalizedStringSafe("SEASONS"))
endfunction

private function Winter takes nothing returns nothing
    call Winter()
    call DisplayVoteEnabled(GetLocalizedStringSafe("WINTER"))
endfunction

private function Spring takes nothing returns nothing
    call Spring()
    call DisplayVoteEnabled(GetLocalizedStringSafe("SPRING"))
endfunction

private function Summer takes nothing returns nothing
    call Summer()
    call DisplayVoteEnabled(GetLocalizedStringSafe("SUMMER"))
endfunction

private function Fall takes nothing returns nothing
    call Fall()
    call DisplayVoteEnabled(GetLocalizedStringSafe("FALL"))
endfunction

private function Weather takes nothing returns nothing
    call StartWeatherImmediately()
    call DisplayVoteEnabled(GetLocalizedStringSafe("WEATHER"))
endfunction

private function NoWeather takes nothing returns nothing
    call StopWeather()
    call DisplayVoteDisabled(GetLocalizedStringSafe("WEATHER"))
endfunction

private function Morning takes nothing returns nothing
    call SetTimeOfDay(6.00)
    call DisplayVoteEnabled(GetLocalizedStringSafe("MORNING"))
endfunction

private function Noon takes nothing returns nothing
    call SetTimeOfDay(12)
    call DisplayVoteEnabled(GetLocalizedStringSafe("NOON"))
endfunction

private function Evening takes nothing returns nothing
    call SetTimeOfDay(18.00)
    call DisplayVoteEnabled(GetLocalizedStringSafe("EVENING"))
endfunction

private function Midnight takes nothing returns nothing
    call SetTimeOfDay(24.00)
    call DisplayVoteEnabled(GetLocalizedStringSafe("MIDNIGHT"))
endfunction

private function TimeCycle takes nothing returns nothing
    call UseTimeOfDayBJ(true)
    call DisplayVoteEnabled(GetLocalizedStringSafe("DNC"))
endfunction

private function NoTimeCycle takes nothing returns nothing
    call UseTimeOfDayBJ(false)
    call DisplayVoteDisabled(GetLocalizedStringSafe("DNC"))
endfunction

private function Water takes nothing returns nothing
    call SetWaterBaseColorBJ(100, 100, 100, 0.00)
    call DisplayVoteEnabled(GetLocalizedStringSafe("WATER"))
endfunction

private function NoWater takes nothing returns nothing
    call SetWaterBaseColorBJ(100, 100, 100, 100.00)
    call DisplayVoteDisabled(GetLocalizedStringSafe("WATER"))
endfunction

private function WaterRed takes nothing returns nothing
    call SetWaterBaseColorBJ(100, 50.00, 50.00, 0.00)
    call DisplayVoteEnabled(GetLocalizedStringSafe("RED_WATER"))
endfunction

private function Fog takes nothing returns nothing
    call SetTerrainFogExBJ(0, 1000, 8000, 0, 100, 100, 100)
    call DisplayVoteEnabled(GetLocalizedStringSafe("FOG"))
endfunction

private function NoFog takes nothing returns nothing
    call ResetTerrainFogBJ()
    call DisplayVoteDisabled(GetLocalizedStringSafe("FOG"))
endfunction

private function Reveal takes nothing returns nothing
    call FogEnableOff()
    call FogMaskEnableOff()
    call DisplayVoteEnabled(GetLocalizedStringSafe("REVEAL"))
endfunction

private function NoReveal takes nothing returns nothing
    call FogEnableOn()
    call FogMaskEnableOn()
    call DisplayVoteDisabled(GetLocalizedStringSafe("REVEAL"))
endfunction

private function Cheats takes nothing returns nothing
    set udg_Cheats = true
    call DisplayVoteEnabled(GetLocalizedStringSafe("CHEATS"))
endfunction

private function NoCheats takes nothing returns nothing
    set udg_Cheats = false
    call DisplayVoteDisabled(GetLocalizedStringSafe("CHEATS"))
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

    call Add(GetLocalizedStringSafe("BUILDER"), "-builder", function Builder)
    call Add(GetLocalizedStringSafe("NO_BUILDER"), "-nobuilder", function NoBuilder)

    call Add(GetLocalizedStringSafe("AMBIENT_SOUND"), "-ambientsound", function AmbientSound)
    call Add(GetLocalizedStringSafe("AMBIENT_SOUND_ASHENVALE"), "-ambientsoundashenvale", function AmbientSoundAshenvale)
    call Add(GetLocalizedStringSafe("AMBIENT_SOUND_LORDAERON_S"), "-ambientsoundlordaeronsummer", function AmbientSoundLordaeronSummer)
    call Add(GetLocalizedStringSafe("NO_AMBIENT_SOUND"), "-noambientsound", function NoAmbientSound)

    call Add(GetLocalizedStringSafe("SKY"), "-sky", function Sky)
    call Add(GetLocalizedStringSafe("SKY_ASHENVALE"), "-skyashenvale", function SkyAshenvale)
    call Add(GetLocalizedStringSafe("SKY_BARRENS"), "-skybarrens", function SkyBarrens)
    call Add(GetLocalizedStringSafe("SKY_BLIZZARD"), "-skyblizzard", function SkyBlizzard)
    call Add(GetLocalizedStringSafe("SKY_DALARAN"), "-skydalaran", function SkyDalaran)
    call Add(GetLocalizedStringSafe("SKY_DALARAN_RUINS"), "-skydalaranruins", function SkyDalaranRuins)
    call Add(GetLocalizedStringSafe("SKY_FELWOOD"), "-skyfelwood", function SkyFelwood)
    call Add(GetLocalizedStringSafe("SKY_FOGGED"), "-skyfogged", function SkyFogged)
    call Add(GetLocalizedStringSafe("SKY_GENERIC"), "-skygeneric", function SkyGeneric)
    call Add(GetLocalizedStringSafe("SKY_MOON"), "-skymoon", function SkyMoon)

    call Add(GetLocalizedStringSafe("FOOD_50"), "-food50", function Food50)
    call Add(GetLocalizedStringSafe("FOOD_100"), "-food100", function Food100)
    call Add(GetLocalizedStringSafe("FOOD_200"), "-food200", function Food200)
    call Add(GetLocalizedStringSafe("FOOD_300"), "-food300", function Food300)
    call Add(GetLocalizedStringSafe("FOOD_600"), "-food600", function Food600)

    call Add(GetLocalizedStringSafe("LIMITS"), "-limits", function Limits)
    call Add(GetLocalizedStringSafe("NO_LIMITS"), "-nolimits", function NoLimits)

    call Add(GetLocalizedStringSafe("SEASONS"), "-seasons", function Seasons)
    call Add(GetLocalizedStringSafe("NO_SEASONS"), "-noseasons", function NoSeasons)

    call Add(GetLocalizedStringSafe("WINTER"), "-winter", function Winter)
    call Add(GetLocalizedStringSafe("SPRING"), "-spring", function Spring)
    call Add(GetLocalizedStringSafe("SUMMER"), "-summer", function Summer)
    call Add(GetLocalizedStringSafe("FALL"), "-fall", function Fall)

    call Add(GetLocalizedStringSafe("WEATHER"), "-weather", function Weather)
    call Add(GetLocalizedStringSafe("NO_WEATHER"), "-noweather", function NoWeather)

    call Add(GetLocalizedStringSafe("MORNING"), "-morning", function Morning)
    call Add(GetLocalizedStringSafe("NOON"), "-noon", function Noon)
    call Add(GetLocalizedStringSafe("DAY"), "-day", function Noon)
    call Add(GetLocalizedStringSafe("EVENING"), "-evening", function Evening)
    call Add(GetLocalizedStringSafe("MIDNIGHT"), "-midnight", function Midnight)
    call Add(GetLocalizedStringSafe("NIGHT"), "-night", function Midnight)

    call Add(GetLocalizedStringSafe("DNC"), "-dnc", function TimeCycle)
    call Add(GetLocalizedStringSafe("NO_DNC"), "-nodnc", function NoTimeCycle)

    call Add(GetLocalizedStringSafe("NO_WATER"), "-nowater", function NoWater)
    call Add(GetLocalizedStringSafe("WATER"), "-water", function Water)

    call Add(GetLocalizedStringSafe("RED_WATER"), "-waterred", function WaterRed)

    call Add(GetLocalizedStringSafe("FOG"), "-fog", function Fog)
    call Add(GetLocalizedStringSafe("NO_FOG"), "-nofog", function NoFog)

    call Add(GetLocalizedStringSafe("REVEAL"), "-reveal", function Reveal)
    call Add(GetLocalizedStringSafe("NO_REVEAL"), "-noreveal", function NoReveal)

    call Add(GetLocalizedStringSafe("CHEATS"), "-cheats", function Cheats)
    call Add(GetLocalizedStringSafe("NO_CHEATS"), "-nocheats", function NoCheats)
endfunction

endlibrary
