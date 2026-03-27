library WoWReforgedLockPick requires TextTagUtils

function LockPickUnlockedMessage takes player whichPlayer, real x, real y returns nothing
    call ShowFadingTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)] , GetLocalizedString("UNLOCKED") + "!", 0.025, x, y, 0, 255, 0, 255, 0.03, 1.0, 3.0)
endfunction

endlibrary
