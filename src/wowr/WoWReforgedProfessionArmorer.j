library WoWReforgedProfessionArmorer initializer Init requires SimError, WoWReforgedAbilityFields, WoWReforgedI18n

globals
    private constant integer ABILITY_ID = 'A104'
    private trigger castTrigger = CreateTrigger()
endglobals

private function ForgingHammer takes unit hero, item whichItem, integer defenseBonus returns integer
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer abilityId = 0
    local ability whichAbility = null
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i >= MAX_ITEM_ABILITIES)
        set whichAbility = BlzGetItemAbility(whichItem, abilityId)
        set abilityId = BlzGetAbilityId(whichAbility)
        if (abilityId != 0) then
            call AddAbilityFieldBonuses(abilityId, whichAbility, 0, defenseBonus, 0, 0.0, 0, 0, 0, 0, 0.0, 0, 0, 0, 0, 0.0, 0, 0.0)
            // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
            call IncUnitAbilityLevel(hero, abilityId)
            call DecUnitAbilityLevel(hero, abilityId)
            set result = result + 1
        endif
        set i = i + 1
    endloop
    if (result > 0) then
        call DisplayTimedTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, 4.0, GetLocalizedString("INCREASED_ARMOR_ITEM"))
    endif
    return result
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        if (ForgingHammer(GetTriggerUnit(), GetSpellTargetItem(), 2) <= 0) then
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_ITEM_ARMOR_ABILITIES"))
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
