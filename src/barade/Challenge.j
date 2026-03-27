library Challenge initializer Init requires SimError

globals
    public constant integer ABILITY_ID = 'A1NO'

    private trigger castTrigger = CreateTrigger()
endglobals

function Challenge takes integer abilityId, unit caster, unit target returns nothing
    if (GetUnitLevel(caster) > GetUnitLevel(target)) then
        call SetUnitOwner(target, GetOwningPlayer(caster), true)
    elseif (GetUnitLevel(caster) < GetUnitLevel(target)) then
        //call BJDebugMsg("Challenge kill " + GetUnitName(caster))
        call KillUnit(caster)
    else
        call SimError(GetOwningPlayer(caster), GetLocalizedString("DOT_DRAW"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        if (GetSpellTargetUnit() != null) then
            if (not IsUnitAlly(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit()))) then
                if (GetOwningPlayer(GetTriggerUnit()) != GetOwningPlayer(GetSpellTargetUnit())) then
                    call Challenge(GetSpellAbilityId(), GetTriggerUnit(), GetSpellTargetUnit())
                else
                    call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_BELONGS_TO_YOU"))
                endif
            else
                call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_IS_ALLIED"))
            endif
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_TARGET"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
