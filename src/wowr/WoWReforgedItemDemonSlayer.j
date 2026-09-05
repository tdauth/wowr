library WoWReforgedItemDemonSlayer initializer Init requires TextTagUtils, WoWReforgedRaces

globals
    private trigger damagedTrigger = CreateTrigger()
endglobals

private function TriggerConditionDamaged takes nothing returns boolean
    local real damage = 0.0
    if (UnitHasItemOfTypeBJ(GetEventDamageSource(), ITEM_DEMON_SLAYER)) then
        if (GetObjectRace(GetUnitTypeId(GetTriggerUnit())) == udg_RaceDemon or GetUnitRace(GetTriggerUnit()) == RACE_DEMON) then
            set damage = GetEventDamage() * 0.30
            call DisableTrigger(GetTriggeringTrigger())
            call UnitDamageTargetBJ(GetEventDamageSource(), GetTriggerUnit(), damage, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
            call EnableTrigger(GetTriggeringTrigger())
            call ShowBashTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetEventDamageSource()))], GetUnitX(GetEventDamageSource()), GetUnitY(GetEventDamageSource()), R2I(damage))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))
endfunction

endlibrary
