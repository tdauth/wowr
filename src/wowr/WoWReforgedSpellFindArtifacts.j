library WoWReforgedSpellFindArtifacts initializer Init requires SimError, WoWReforgedAbilitySkill

globals
    private trigger castTrigger = CreateTrigger()
endglobals

function GetFindArtifactsItemCount takes unit caster, integer abilityId, integer level returns integer
    return level
endfunction

function GetFindArtifactsItemLevel takes unit caster, integer abilityId, integer level returns integer
    return IMinBJ(8, level)
endfunction

function FindArtifacts takes unit caster, integer abilityId returns nothing
    local integer level = GetUnitAbilitySkillLevelSafe(caster, abilityId)
    local integer itemLevel = GetFindArtifactsItemLevel(caster, abilityId, level)
    local integer i = 0
    local integer max = GetFindArtifactsItemCount(caster, abilityId, level)
    loop
        exitwhen (i == max)
        call UnitAddItemByIdSwapped(ChooseRandomItemExBJ(itemLevel, ITEM_TYPE_ANY), caster)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_FIND_ARTIFACTS) then
        call FindArtifacts(GetTriggerUnit(), ABILITY_FIND_ARTIFACTS)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_FIND_ARTIFACTS, GetFindArtifactsItemCount)
    call RegisterAbilityFieldCustomInteger1(ABILITY_FIND_ARTIFACTS, GetFindArtifactsItemLevel)
endfunction

endlibrary
