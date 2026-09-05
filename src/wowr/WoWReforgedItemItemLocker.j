library WoWReforgedItemItemLocker initializer Init requires SimError

globals
    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionSpellCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0MR') then
        if (GetItemType(GetSpellTargetItem()) != ITEM_TYPE_CAMPAIGN and  GetItemType(GetSpellTargetItem()) != ITEM_TYPE_ARTIFACT) then
            if (GetItemPlayer(GetSpellTargetItem()) == null or IsPlayerAlly(GetOwningPlayer(GetTriggerUnit()), GetItemPlayer(GetSpellTargetItem()))) then
                call SetItemPlayer(GetSpellTargetItem(), GetOwningPlayer(GetTriggerUnit()), true)
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], Format(GetLocalizedString("LOCKED_ITEM_X")).s(GetItemName(GetSpellTargetItem())).result())
            else
                if (GetItemPlayer(GetSpellTargetItem()) == GetOwningPlayer(GetTriggerUnit())) then
                    call SetItemPlayer(GetSpellTargetItem(), Player(PLAYER_NEUTRAL_PASSIVE), true)
                    call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], Format(GetLocalizedString("UNLOCKED_ITEM_X")).s(GetItemName(GetSpellTargetItem())).result())
                else
                    call IssueImmediateOrder(GetTriggerUnit(), "stop")
                    call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("ITEM_IS_OWNED_BY_ANOTHER_PLAYER"))
                endif
            endif
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("CANNOT_LOCK_ITEM"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionSpellCast))
endfunction

endlibrary
