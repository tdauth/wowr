library WoWReforgedSpellFinishConstructions initializer Init

globals
    private group constructions = CreateGroup()
    private trigger channelTrigger = CreateTrigger()
    private trigger finishConstructionTrigger = CreateTrigger()
    private trigger finishUpgradeTrigger = CreateTrigger()
    private trigger cancelUpgradeTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    
    private unit filterCaster = null
endglobals

private function FilterIsConstructionInProgress takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and IsUnitAlly(GetFilterUnit(), GetOwningPlayer(filterCaster)) and IsUnitInGroup(GetFilterUnit(), constructions)
endfunction

private function EnumUnitFinishConstruction takes nothing returns nothing
    call UnitSetConstructionProgress(GetEnumUnit(), 100)
    call UnitSetUpgradeProgress(GetEnumUnit(), 100)
endfunction

function FinishConstructions takes unit caster, real x, real y returns nothing
    local group g = CreateGroup()
    set filterCaster = caster
    call GroupEnumUnitsInRange(g, x, y, 512.0, Filter(function FilterIsConstructionInProgress))
    if (BlzGroupGetSize(g) > 0) then
        call ForGroup(g, function EnumUnitFinishConstruction)
    else
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_TARGETS"))
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerActionChannel takes nothing returns nothing
    if (GetSpellAbilityId() == ABILITY_FINISH_CONSTRUCTIONS or GetSpellAbilityId() == ABILITY_FINISH_CONSTRUCTIONS_ITEM) then
        call FinishConstructions(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
endfunction

private function TriggerConditionCancelUpgrade takes nothing returns boolean
    call GroupAddUnit(constructions, GetTriggerUnit())
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitInGroup(GetTriggerUnit(), constructions)) then
        call GroupRemoveUnit(constructions, GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(channelTrigger, function TriggerActionChannel)
    
    call TriggerRegisterAnyUnitEventBJ(finishConstructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(finishConstructionTrigger, Condition(function TriggerConditionCancelUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(finishUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(finishUpgradeTrigger, Condition(function TriggerConditionCancelUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(cancelUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerAddCondition(cancelUpgradeTrigger, Condition(function TriggerConditionCancelUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_UPGRADE_START)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
