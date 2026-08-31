library WoWReforgedSelfdestruct initializer Init requires SimError, SafeString, WoWReforgedMapData

globals
    private trigger spellCastTrigger = CreateTrigger()
endglobals

private function IsAirWall takes integer unitTypeId returns boolean
    if (unitTypeId == 'h0DM') then
        return true
    elseif (unitTypeId == 'h0EK') then
        return true
    elseif (unitTypeId == 'h0EL') then
        return true
    endif
    return false
endfunction

private function TriggerConditionSpellCast takes nothing returns boolean
    local unit triggerUnit = GetTriggerUnit()
    if (GetSpellAbilityId() == 'A09M') then // Selfdestruct
        if (not RectContainsUnit(GetMapPlayerSelectionRect(), triggerUnit)) then
            call KillUnit(triggerUnit)
            call QueueUnitAnimationBJ(triggerUnit, "death")
            if (GetUnitTypeId(triggerUnit) == 'h0P8') then // Rock (Summon Wall)
                call PlaySoundOnUnitBJ(gg_snd_RockChunksDeath1, 100, triggerUnit)
                call PolledWait(0.82)
                call ResetUnitAnimation(triggerUnit)
                call ShowUnitHide(triggerUnit)
            else
                if (IsAirWall(GetUnitTypeId(triggerUnit))) then
                    call PolledWait(0.53)
                    call ResetUnitAnimation(triggerUnit)
                    call ShowUnitHide(triggerUnit)
                else
                    call PolledWait(0.82)
                    call QueueUnitAnimationBJ(triggerUnit, "death")
                endif
            endif
        else
            call SimError(GetTriggerPlayer(), GetLocalizedStringSafe("NOT_ALLOWED_IN_PLAYER_SELECTION"))
        endif
    endif
    set triggerUnit = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(spellCastTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(spellCastTrigger, Condition(function TriggerConditionSpellCast))
endfunction

endlibrary
