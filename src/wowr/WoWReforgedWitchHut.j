library WoWReforgedWitchHut initializer Init requires StringUtils, Refund, WoWReforgedSkillMenu

globals
    private trigger sellTrigger = CreateTrigger()
endglobals

private function TriggerConditionSell takes nothing returns boolean
    if (GetUnitTypeId(GetSoldUnit()) == 'h03R') then
        if (not IsUnitType(GetBuyingUnit(), UNIT_TYPE_HERO) and GetSkillMenu(GetBuyingUnit()) != 0) then
            call AddSkillMenu(GetBuyingUnit())
        else
            call RefundUnit(GetSoldUnit())
            call SimError(GetOwningPlayer(GetBuyingUnit()), Format(GetLocalizedString("INVALID_UNIT")).s(GetUnitName(GetBuyingUnit())).result())
        endif
        call RemoveUnit(GetSoldUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
endfunction

endlibrary
