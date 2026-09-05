library WoWReforgedItemItemSummoner initializer Init requires StringFormat

globals
    private integer counter = 0
    private unit currentCaster = null
    private trigger castTrigger = CreateTrigger()
endglobals


private function EnumTeleportItem takes nothing returns nothing
    if (GetItemPlayer(GetEnumItem()) == GetOwningPlayer(GetTriggerUnit())) then
        set counter = counter + 1
        call SetItemPosition(GetEnumItem(), GetUnitX(currentCaster), GetUnitY(currentCaster))
    endif
endfunction

private function SummonItems takes unit caster returns nothing
    set counter = 0
    set currentCaster = caster
    call EnumItemsInRectBJ(GetPlayableMapRect(), function EnumTeleportItem)
    if (counter > 0) then
        call SimError(GetOwningPlayer(GetTriggerUnit()), Format(GetLocalizedString("SUMMONED_X_ITEMS")).i(counter).result())
    else
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_MATCHING_ITEMS"))
    endif
endfunction


private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0N0') then
        call SummonItems(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
