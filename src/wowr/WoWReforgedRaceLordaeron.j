library WoWReforgedRaceLordaeron initializer Init

globals
    private trigger damagedTrigger = CreateTrigger()
endglobals

private function TriggerConditionDamaged takes nothing returns boolean
    if (GetUnitAbilityLevel(GetEventDamageSource(), 'A18L') > 0 and IsUnitType(BlzGetEventDamageTarget(), UNIT_TYPE_UNDEAD)) then
        call DisableTrigger(GetTriggeringTrigger())
        call UnitDamageTargetBJ(GetEventDamageSource(), BlzGetEventDamageTarget(), GetEventDamage() * 0.1, BlzGetEventAttackType(), BlzGetEventDamageType())
        call EnableTrigger(GetTriggeringTrigger())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))
endfunction

endlibrary
