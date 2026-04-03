library WoWReforgedMapCinematics initializer Init requires WoWReforgedCinematic, WoWReforgedUiNews, WoWReforgedMapBosses

globals
    private trigger introCleanupTrigger = CreateTrigger()
endglobals

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
            call SetUnitFacing(GetBossArchimonde(), 225.0)
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
            call ConditionalTriggerExecute(gg_trg_Cinematics_End)
        else
            call BJDebugMsg("Cinematics are disabled.")
            call IntroCleanup()
        endif
    else
        call BJDebugMsg("Intro was already shown.")
    endif
endfunction

private function Init takes nothing returns nothing
    call TriggerAddAction(introCleanupTrigger, function IntroCleanup)
endfunction

endlibrary
