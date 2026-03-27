library WoWReforgedSpellHarvest initializer Init requires SimError, WoWReforgedAbilitySkill

globals
    private trigger castTrigger = CreateTrigger()
endglobals

function GetHarvestCharges takes unit caster, integer abilityId, integer level returns integer
    return level
endfunction

// Do not add it to the hero so it is consumed immediately. This allows you to give it to other players.
private function AddItem takes unit caster, integer itemTypeId, integer charges returns nothing
    local integer i = 0
    loop
        exitwhen (i == charges)
        call CreateItem(itemTypeId, GetUnitX(caster), GetUnitY(caster))
        set i = i + 1
    endloop
endfunction

function Harvest takes unit caster, integer abilityId returns nothing
    local integer charges = GetHarvestCharges(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    if (not RectContainsUnit(gg_rct_Player_Selection, caster)) then
        call AddItem(caster, 'lmbr', charges)
        call AddItem(caster, 'gold', charges)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NOT_ALLOWED_IN_PLAYER_SELECTION"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_HARVEST) then
        call Harvest(GetTriggerUnit(), GetSpellAbilityId())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_HARVEST, GetHarvestCharges)
endfunction

endlibrary
