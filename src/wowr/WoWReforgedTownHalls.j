library WoWReforgedTownHalls initializer Init requires SimError, StringUtils, StringFormat, SafeString, PlayerColorUtils, WoWReforgedUtils, WoWReforgedMapData

globals
    private player tmpPlayer = null
    private boolean tmpBoolean = false
    private group array givenUnits
    private timer array rewardTimer
    private trigger upgradeFinishTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
endglobals

private function EnumUnitTransfer takes nothing returns nothing
    if (GetPlayerState(tmpPlayer, PLAYER_STATE_RESOURCE_FOOD_USED) + GetUnitFoodUsed(GetEnumUnit()) <= IMinBJ(GetPlayerState(tmpPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP), GetPlayerState(tmpPlayer, PLAYER_STATE_FOOD_CAP_CEILING))) then
        call SetUnitOwner(GetEnumUnit(), tmpPlayer, true)
        call PingMinimapForPlayer(tmpPlayer, GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 5.00)
    else
        if (tmpBoolean) then
            call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], Format(GetLocalizedStringSafe("CANNOT_GIVE_UNITS_FOOD_MAX")).s(GetUnitName(GetEnumUnit())).result())
            set tmpBoolean = true
        endif
    endif
endfunction

function ChatCommandTransfer takes nothing returns nothing
    local player targetPlayer = GetPlayerFromString(StringTokenEnteredChatMessageEx(1, true))
    if (BlzGroupGetSize(givenUnits[GetPlayerId(GetTriggerPlayer())]) > 0) then
        if (targetPlayer != null and IsPlayerInForce(targetPlayer, GetMapLobbyPlayers())) then
            if (IsPlayerAlly(GetTriggerPlayer(), targetPlayer)) then
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], Format(GetLocalizedStringSafe("GIVE_UNITS_TO_X")).s(GetPlayerNameColored(targetPlayer)).result())
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(targetPlayer)], Format(GetLocalizedStringSafe("RECEIVING_UNITS_FROM_X")).s(GetPlayerNameColored(GetTriggerPlayer())).result())
                set tmpBoolean = false
                set tmpPlayer = targetPlayer
                call ForGroup(givenUnits[GetPlayerId(GetTriggerPlayer())], function EnumUnitTransfer)
            else
                call SimError(GetTriggerPlayer(), Format(GetLocalizedStringSafe("CANNOT_GIVE_UNITS_TO_PLAYER_X")).s(GetPlayerNameColored(targetPlayer)).result())
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("INVALID_PLAYER"))
        endif
    else
        call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("GIVEN_UNITS_EMPTY"))
    endif
endfunction

function ChatCommandNoTransfer takes nothing returns nothing
    call GroupClear(givenUnits[GetPlayerId(GetTriggerPlayer())])
    call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], GetLocalizedStringSafe("CLEAR_GIVE_UNITS"))
endfunction

private function TriggerConditionUpgradeFinish takes nothing returns boolean
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_TOWNHALL) == true and (GetUnitTypeId(GetTriggerUnit()) == 'h00K' or GetUnitTypeId(GetTriggerUnit()) == 'h00L')) then
        // The spell book abilities disappear after an upgrade of the building. This trigger readds them.
        call UnitRemoveAbility(GetTriggerUnit(), 'A08R')
        call UnitAddAbility(GetTriggerUnit(), 'A08R')
    endif
    return false
endfunction

private function FilterIsGivableUnit takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == tmpPlayer and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not  IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') <= 0
endfunction

function UpdateGiveUnitsForPlayer takes player whichPlayer, real x, real y returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    set tmpPlayer = whichPlayer
    call GroupClear(givenUnits[playerId])
    call GroupEnumUnitsInRange(givenUnits[playerId], x, y, 512.0, Filter(function FilterIsGivableUnit))
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
    elseif (GetSpellAbilityId() == 'A04Y') then // Transfer Units
        call UpdateGiveUnitsForPlayer(GetTriggerPlayer(), GetSpellTargetX(), GetSpellTargetY())
        if (BlzGroupGetSize(givenUnits[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]) > 0) then
            call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], Format(GetLocalizedStringSafe("SELECTED_UNITS_FOR_TRANSFER")).i(BlzGroupGetSize(givenUnits[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))])).result())
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedStringSafe("NO_VALID_TARGETS_IN_THIS_AREA"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set givenUnits[i] = CreateGroup()
        set rewardTimer[i] = CreateTimer()
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(upgradeFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(upgradeFinishTrigger, Condition( function TriggerConditionUpgradeFinish))

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
