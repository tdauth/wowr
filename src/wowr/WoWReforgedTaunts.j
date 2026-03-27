library WoWReforgedTaunts requires Taunts

private function AddTauntWoWReforged takes string text, sound s returns nothing
    call AddTaunt(I2S(GetTauntsCount() + 1), text, s)
endfunction

private function Init takes nothing returns nothing
    call AddTauntWoWReforged(GetLocalizedString("YES_MY_LORD"), gg_snd_PeasantYes2)
    call AddTauntWoWReforged(GetLocalizedString("WORK_WORK"), gg_snd_PeonYes3)
    call AddTauntWoWReforged(GetLocalizedString("THATS_IT_I_AM_DEAD"), gg_snd_PeasantYesAttack4)
    call AddTauntWoWReforged(GetLocalizedString("INTRUGING"), gg_snd_NecromancerYes1)
    call AddTauntWoWReforged(GetLocalizedString("FOR_LORDAERON"), gg_snd_ArthasWarcry1)
    call AddTauntWoWReforged(GetLocalizedString("I_SHOULD_HAVE_BEEN_A_FARMER"), gg_snd_CaptainPissed1)
    call AddTauntWoWReforged(GetLocalizedString("WHO_DARES_TO_DEFILE"), gg_snd_Cenarius_What1)
    call AddTauntWoWReforged(GetLocalizedString("TREMBLE_MORTALS_AND_DESPAIR"), gg_snd_DemiDark)
    call AddTauntWoWReforged(GetLocalizedString("FOR_THE_ALLIANCE"), gg_snd_SorceressWarcry1)
    call AddTauntWoWReforged(GetLocalizedString("FOR_THE_HORDE"), gg_snd_ThrallReady1)
endfunction

endlibrary
