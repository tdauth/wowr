library WoWReforgedBackpackAbilities initializer Init requires WoWReforgedBackpacks, WoWReforgedUiBackpack, WoWReforgedUiSaveCode

globals
    private trigger selectionTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionSelect takes nothing returns boolean
    if (GetUnitTypeId(GetTriggerUnit()) == BACKPACK and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER) then
        if ( bj_isSinglePlayer and not udg_BackpackDontShowUI[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) then
            call ShowBackpackUI(GetOwningPlayer(GetTriggerUnit()))
        endif
    endif
    return false
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetUnitTypeId(GetTriggerUnit()) == BACKPACK) then
        if (GetSpellAbilityId() == 'A0N5') then // Save GUI
            if (udg_SaveAndLoadEnabled) then
                call ShowSaveCodeUI(GetTriggerPlayer())
            else
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], GetLocalizedString("SAVE_CODES_DISABLED"))
            endif
        elseif (GetSpellAbilityId() == 'A0A0') then // Show User Interface
            call ShowBackpackUI(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A09K') then // Pick up all items around
            call PickupAllItemsAroundByPlayer(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A09C') then // Drop all Items
            call DropAllItemsFromBackpack(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A0KR') then // Toggle UI
            if (udg_BackpackDontShowUI[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) then
                set udg_BackpackDontShowUI[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = false
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], GetLocalizedString("BACKPACK_UI_ENABLE"))
            else
                set udg_BackpackDontShowUI[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = true
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(GetTriggerPlayer())], GetLocalizedString("BACKPACK_UI_DISABLE"))
            endif
        elseif (GetSpellAbilityId() == 'A0MQ') then // Order Items
            call OrderBackpack(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A0PA') then // Next Free Bag
            call ChangeToNextFreeBagInBackpack(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A0PC') then // First Bag
            call ChangeToFirstBagInBackpack(GetOwningPlayer(GetTriggerUnit()))
        elseif (GetSpellAbilityId() == 'A0PB') then // Last Bag
            call ChangeToLastBagInBackpack(GetOwningPlayer(GetTriggerUnit()))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerSelectionEventBJ(selectionTrigger, Player(i), true)
        set i = i + 1
    endloop
    call TriggerAddCondition(selectionTrigger, Condition(function TriggerConditionSelect))

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
