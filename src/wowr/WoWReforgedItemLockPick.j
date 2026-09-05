library WoWReforgedItemLockPick initializer Init requires SimError, TextTagUtils, SoundUtils

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function LockPickUnlockedMessage takes player whichPlayer, real x, real y returns nothing
    call ShowFadingTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)] , GetLocalizedString("UNLOCKED") + "!", 0.025, x, y, 0, 255, 0, 255, 0.03, 1.0, 3.0)
endfunction

private function IsLockable takes integer destructableTypeId returns boolean
    if (destructableTypeId == 'ATg2') then
        return true
    elseif (destructableTypeId == 'ATg4') then
        return true
    elseif (destructableTypeId == 'ATg1') then
        return true
    elseif ( destructableTypeId == 'ATg3') then
        return true
    elseif (destructableTypeId == 'LTe2') then
        return true
    elseif (destructableTypeId == 'LTe4') then
        return true
    elseif (destructableTypeId == 'LTe1') then
        return true
    elseif (destructableTypeId == 'LTe3') then
        return true
    elseif (destructableTypeId == 'LTg2') then
        return true
    elseif (destructableTypeId == 'LTg4') then
        return true
    elseif (destructableTypeId == 'LTg1') then
        return true
    elseif (destructableTypeId == 'LTg3') then
        return true
    elseif (destructableTypeId == 'DTg6') then
        return true
    elseif (destructableTypeId == 'DTg8') then
        return true
    elseif (destructableTypeId == 'DTg5') then
        return true
    elseif (destructableTypeId == 'DTg7') then
        return true
    elseif (destructableTypeId == 'B00N') then
        return true
    endif
    return false
endfunction

private function TriggerConditionSpellCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A03B') then
        if (GetSpellTargetDestructable() != null and IsDestructableAliveBJ(GetSpellTargetDestructable())  and IsLockable(GetDestructableTypeId(GetSpellTargetDestructable()))) then
            call ModifyGateBJ(bj_GATEOPERATION_OPEN, GetSpellTargetDestructable())
            call PlaySoundOnDestructable(gg_snd_LargeCityGateOpen1, 100, GetSpellTargetDestructable())
            call LockPickUnlockedMessage(GetOwningPlayer(GetTriggerUnit()), GetDestructableX(GetSpellTargetDestructable()), GetDestructableY(GetSpellTargetDestructable()))
        else
            if (GetSpellTargetUnit() != null and GetUnitTypeId(GetSpellTargetUnit()) == GATE_CLOSED_HORIZONTAL) then
                call IssueImmediateOrder(GetSpellTargetUnit(), "bearform")
            else
                if (GetSpellTargetUnit() != null and GetUnitTypeId(GetSpellTargetUnit()) == CHEST_NEUTRAL) then
                    call RemoveUnitFromStock(GetSpellTargetUnit(), CHEST_NEUTRAL_EMPTY)
                    call AddUnitToStock(GetSpellTargetUnit(), CHEST_NEUTRAL_EMPTY, 1, 1)
                    call LockPickUnlockedMessage(GetOwningPlayer(GetTriggerUnit()), GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit()))
                else
                    call IssueImmediateOrder(GetTriggerUnit(), "stop")
                    call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("CLOSED_GATE_OR_LOCKED_CHEST"))
                endif
            endif
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionSpellCast))
endfunction

endlibrary

