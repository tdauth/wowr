library WoWReforgedMapCinematics initializer Init requires WoWReforgedCinematic, WoWReforgedUiNews, WoWReforgedMapBosses, WoWReforgedMapData

globals
    private trigger introCleanupTrigger = CreateTrigger()
    private trigger outroCleanupTrigger = CreateTrigger()
    private unit actorArchimonde = null
endglobals

private function EndCinematic takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Cinematics_End)
endfunction

private function IntroCleanup takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
    call ResetUnitAnimation(GetBossArchimonde())
    call StartTimerBJ(udg_MainQuest1Timer, false, 3.0)
    call ShowNewsUI()
    call SelectHeroes()
endfunction

private function EnumIntroCamera takes nothing returns nothing
    call CameraSetupApplyForPlayer(true, gg_cam_intro_0, GetEnumPlayer(), 0.00)
    call CameraSetupApplyForPlayer(true, gg_cam_intro_1, GetEnumPlayer(), 8.00)
endfunction

function PlayIntroCinematic takes nothing returns nothing
    if (not udg_IntroShown) then
        if (udg_Cinematics) then
            call BJDebugMsg("Wait for cinematic end.")
            call WaitForCinematicEnd()
            set udg_IntroShown = true
            set udg_CinematicCleanupTrigger = introCleanupTrigger
            call PrepareCinematic()
            call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 1.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
            call PolledWait(1.50)
            call EnableCinematic()
            call PlayThematicMusicBJ("Doom")
            call SetSkyModel("Environment\\Sky\\Outland_Sky\\Outland_Sky.mdl")
            call SetUnitFacing(GetBossArchimonde(), 241.33)
            call ForForce(GetPlayersAll(), function EnumIntroCamera)
            call PolledWait(0.50)
            call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 1.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
            call EndPrepareCinematic()
            call PolledWait(1.0)
            if (not udg_CinematicRunning) then
                return
            endif
            call SetUnitAnimation(GetBossArchimonde(), "spell slam")
            call TransmissionFromUnitWithNameBJ(GetPlayersAll(), GetBossArchimonde(), GetLocalizedStringSafe("ARCHIMONDE"), gg_snd_U08Archimonde19, GetLocalizedStringSafe("TREMBLE_MORTALS_AND_DESPAIR"), bj_TIMETYPE_ADD, 0, false)
            call PolledWait(GetSoundDurationBJ(GetLastPlayedSound()))
            call EndCinematic()
        else
            call BJDebugMsg("Cinematics are disabled.")
            call IntroCleanup()
        endif
    else
        call BJDebugMsg("Intro was already shown.")
    endif
endfunction

private function EnumOutroCamera takes nothing returns nothing
    call CameraSetupApplyForPlayer(true, gg_cam_intro_0, GetEnumPlayer(), 0.00)
    call CameraSetupApplyForPlayer(true, gg_cam_intro_1, GetEnumPlayer(), 8.00)
endfunction

function PlayOutroCinematic takes nothing returns nothing
    if (udg_Cinematics) then
        call WaitForCinematicEnd()
        set udg_CinematicCleanupTrigger = outroCleanupTrigger
        call PrepareCinematic()
        call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 1.00, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
        call PolledWait(1.50)
        call EnableCinematic()
        call PlayThematicMusicBJ("HeroicVictory")
        call ForForce(GetPlayersAll(), function EnumOutroCamera)
        call ShowUnitHide(gg_unit_N011_0053)
        set actorArchimonde = CreateUnit(GetMapBossesPlayer(), 'N011', GetRectCenterX(gg_rct_Cinematic_Outro_Archimonde), GetRectCenterY(gg_rct_Cinematic_Outro_Archimonde), 241.33)
        call PolledWait(1.00)
        call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 2, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 0, 0, 0, 0)
        call EndPrepareCinematic()
        call PolledWait(1.50)
        if (not udg_CinematicRunning) then
            return
        endif
        call SetUnitTimeScalePercent(actorArchimonde, 30.00)
        call SetUnitAnimation(actorArchimonde, "death")
        call TransmissionFromUnitWithNameBJ(GetPlayersAll(), actorArchimonde, GetLocalizedStringSafe("ARCHIMONDE"), gg_snd_PitlordYes2, "...", bj_TIMETYPE_ADD, 0, false)
        call PolledWait(GetSoundDurationBJ(GetLastPlayedSound()))
        call EndCinematic()
    endif
endfunction

private function OutroCleanup takes nothing returns nothing
    call ShowUnitShow(gg_unit_N011_0053)
    call RemoveUnit(actorArchimonde)
    call SelectHeroes()
endfunction

private function Init takes nothing returns nothing
    call TriggerAddAction(introCleanupTrigger, function IntroCleanup)
    call TriggerAddAction(outroCleanupTrigger, function OutroCleanup)
endfunction

endlibrary
