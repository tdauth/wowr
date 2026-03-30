library WoWReforgedMapRacingTracks initializer Init requires WoWReforgedRacing

private function Init takes nothing returns nothing
    local RacingTrack r = 0

    set r = AddRacingTrack(GetLocalizedStringSafe("AZEROTH_GRAND_PRIX"), 'I14X', 'I14U', 'I14V', 'I14W')
    set udg_RacingTrackAzerothGrandprix = r
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2694)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2697)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2695)

    set r = AddRacingTrack(GetLocalizedStringSafe("NORTHREND_RACE"), 'I14T', 'I14U', 'I14V', 'I14W')
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2695)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2748)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2749)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2750)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2751)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2752)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2753)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2754)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2695)

    set r = AddRacingTrack(GetLocalizedStringSafe("OUTLAND_RACE"), 'I152', 'I153', 'I154', 'I155')
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2695)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2748)
    call AddRacingTrackCheckpoint(r, gg_unit_n0MW_2695)

    // After adding all tracks.
    call HideCheckPointsVisible()
endfunction

endlibrary
