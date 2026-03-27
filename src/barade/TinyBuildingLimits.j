library TinyBuildingsLimits initializer Init requires SimError, StringFormat, UnitGroupUtils

globals
    private trigger constructionTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

function AddTinyBuildingItem takes integer abilityId, integer buildingTypeId returns nothing
    call SaveInteger(h, abilityId, 0, buildingTypeId)
endfunction

function CheckTinyBuildingForPlayer takes unit caster, integer unitTypeId returns boolean
    local player owner = GetOwningPlayer(caster)
    local integer max = GetPlayerTechMaxAllowed(owner, unitTypeId)
    if (max >= 0) then
        if (CountLivingPlayerUnitsOfTypeIdFast(unitTypeId, owner) >= max) then
            call IssueImmediateOrder(caster, "stop")
            call SimError(owner, Format(GetLocalizedString("REACHED_LIMIT_OF_X_FOR_Y")).i(max).s(GetObjectName(unitTypeId)).result())
            set owner = null
            
            return false
        endif
    endif
    
    set owner = null
    
    return true
endfunction

private function TriggerConditionConstruct takes nothing returns boolean
    local integer buildingTypeId = LoadInteger(h, GetSpellAbilityId(), 0)
    if (buildingTypeId != 0) then
        call CheckTinyBuildingForPlayer(GetTriggerUnit(), buildingTypeId)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(constructionTrigger, Condition(function TriggerConditionConstruct))
endfunction

endlibrary
