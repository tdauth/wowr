library WoWReforgedVotekick initializer Init requires ForceUtils, PlayerColorUtils, StringUtils, StringFormat, SafeString, WoWReforgedMapData

globals
    private trigger startTrigger = CreateTrigger()
    private trigger yesTrigger = CreateTrigger()
    private timer expireTimer = CreateTimer()
    private timerdialog expireTimerDialog = null
    private integer yesCounter = 0
    private player targetPlayer = null
    private boolean array playerHasVoted
    private timer array playerCooldownTimer
    private timer cooldownTimer = CreateTimer()
endglobals

private function EnumRegisterChatEvents takes nothing returns nothing
    call TriggerRegisterPlayerChatEvent(startTrigger, GetEnumPlayer(), "-votekick ", false)
    call TriggerRegisterPlayerChatEvent(yesTrigger, GetEnumPlayer(), "-yes", true)
    set playerHasVoted[GetPlayerId(GetEnumPlayer())] = false
    set playerCooldownTimer[GetPlayerId(GetEnumPlayer())] = CreateTimer()
endfunction

private function EnumReset takes nothing returns nothing
    set playerHasVoted[GetPlayerId(GetEnumPlayer())] = false
endfunction

private function Reset takes nothing returns nothing
    call PauseTimer(expireTimer)
    call TimerDialogDisplay(expireTimerDialog, false)
    call TimerStart(cooldownTimer, 60.0, false, null)
    call TimerStart(playerCooldownTimer[GetPlayerId(targetPlayer)], 60.0, false, null)
    set yesCounter = 0
    call ForForce(GetAllPlayingUsers(), function EnumReset)
endfunction

private function TimerFunctionExpire takes nothing returns nothing
    call DisplayTextToForce(GetAllPlayingUsers(), GetLocalizedStringSafe("VOTEKICK_HAS_EXPIRED"))
    call Reset()
endfunction

private function TriggerConditionStart takes nothing returns boolean
    local player target = null
    if (TimerGetRemaining(cooldownTimer) <= 0.0) then
        set target = GetPlayerFromString(StringTokenEnteredChatMessage(1))
        if (target != GetTriggerPlayer() and GetMapAllowConfigureAIPlayer(target) and GetPlayerSlotState(target) == PLAYER_SLOT_STATE_PLAYING) then
            if (TimerGetRemaining(playerCooldownTimer[GetPlayerId(target)]) <= 0.0) then
                set playerHasVoted[GetPlayerId(GetTriggerPlayer())] = true
                set yesCounter = yesCounter + 1
                call TimerStart(expireTimer, 30.0, false, function TimerFunctionExpire)

                call TimerDialogSetTitle(expireTimerDialog, Format(GetLocalizedStringSafe("VOTEKICK_AGAINST_X")).s(GetPlayerNameColored(target)).result())
                call TimerDialogDisplay(expireTimerDialog, true)
                call DisplayTextToForce(GetAllPlayingUsers(), Format(GetLocalizedStringSafe("VOTEKICK_STARTED_AGAINST_X")).s(GetPlayerNameColored(GetTriggerPlayer())).s(GetPlayerNameColored(target)).result())
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedStringSafe("VOTEKICK_COOLDOWN")).s(FormatTime(TimerGetRemaining(cooldownTimer))).result())
            endif
        else
            call SimError(GetTriggerPlayer(), Format(GetLocalizedStringSafe("VOTEKICK_NOT_ALLOWED")).s(GetPlayerNameColored(target)).result())
        endif
    else
        call SimError(GetTriggerPlayer(), Format(GetLocalizedStringSafe("VOTEKICK_COOLDOWN")).s(FormatTime(TimerGetRemaining(playerCooldownTimer[GetPlayerId(GetTriggerPlayer())]))).result())
    endif
    return false
endfunction

private function TriggerConditionYes takes nothing returns boolean
    if (TimerGetRemaining(expireTimer) > 0.0) then
        if (not playerHasVoted[GetPlayerId(GetTriggerPlayer())]) then
            set yesCounter = yesCounter + 1
            if (yesCounter >= GetAllPlayingUsersCount() / 2) then
                call DisplayTextToForce(GetAllPlayingUsers(), Format(GetLocalizedStringSafe("X_HAS_BEEN_KICKED")).s(GetPlayerNameColored(targetPlayer)).result())
                call CustomDefeatBJ(targetPlayer, GetLocalizedStringSafe("YOU_HAVE_BEEN_KICKED"))
                call Reset()
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("VOTEKICK_ALREADY_VOTED"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("VOTEKICK_NOT_RUNNING"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set expireTimerDialog = CreateTimerDialog(expireTimer)

    call ForForce(GetAllPlayingUsers(), function EnumRegisterChatEvents)

    call TriggerAddCondition(startTrigger, Condition(function TriggerConditionStart))
    call TriggerAddCondition(yesTrigger, Condition(function TriggerConditionYes))
endfunction

endlibrary
