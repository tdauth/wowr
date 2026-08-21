library WoWReforgedTownHalls initializer Init requires SimError, StringFormat, SafeString, WoWReforgedUtils

globals
    private timer array rewardTimer
    private trigger upgradeFinishTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
endglobals

private function TriggerConditionUpgradeFinish takes nothing returns boolean
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_TOWNHALL) == true and (GetUnitTypeId(GetTriggerUnit()) == 'h00K' or GetUnitTypeId(GetTriggerUnit()) == 'h00L')) then
        // The spell book abilities disappear after an upgrade of the building. This trigger readds them.
        call UnitRemoveAbility(GetTriggerUnit(), 'A08R')
        call UnitAddAbility(GetTriggerUnit(), 'A08R')
    endif
    return false
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (GetSpellAbilityId() == 'A04W') then // Reward Freelancer
        if (TimerGetRemaining(rewardTimer[playerId]) <= 0.00) then
            if (IsPlayerFreelancer(GetOwningPlayer(GetSpellTargetUnit()))) then
                call StartTimerBJ(rewardTimer[playerId], false, 180.00)
                call AdjustPlayerStateBJ(800, GetOwningPlayer(GetSpellTargetUnit()), PLAYER_STATE_RESOURCE_LUMBER)
                call AdjustPlayerStateBJ(800, GetOwningPlayer(GetSpellTargetUnit()), PLAYER_STATE_RESOURCE_GOLD)
                call AddHeroXPSwapped(200, GetSpellTargetUnit(), true)
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetSpellTargetUnit()))], Format(GetLocalizedStringSafe("X_HAS_REWARDED_YOU")).s(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit()))).result())
            else
                call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedStringSafe("OWNER_OF_TARGET_UNIT_FREELANCER"))
            endif
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), Format(GetLocalizedStringSafe("SPELL_IS_READY_IN_X")).time(R2I(TimerGetRemaining(rewardTimer[playerId]))).result())
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set rewardTimer[i] = CreateTimer()
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(upgradeFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(upgradeFinishTrigger, Condition( function TriggerConditionUpgradeFinish))

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
