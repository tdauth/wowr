library WoWReforgedSpellSummonMercenaryCamp initializer Init requires WoWReforgedAbilitySkill

globals
    private trigger summonTrigger = CreateTrigger()
endglobals

function GetSummonMercenaryCampLevel takes unit caster, integer abilityId, integer level returns integer
    return IMinBJ(10, level)
endfunction

function GetSummonMercenaryCampSlots takes unit caster, integer abilityId, integer level returns integer
    return IMinBJ(IMaxBJ(1, level), 10)
endfunction

function GetSummonMercenaryCampStock takes unit caster, integer abilityId, integer level returns integer
    return IMaxBJ(1, level)
endfunction

function SummonMercenaryCamp takes unit caster, integer abilityId, unit camp returns nothing
    local integer level = GetUnitAbilitySkillLevelSafe(caster, abilityId)
    local integer max = GetSummonMercenaryCampSlots(caster, abilityId, level)
    local integer creepLevel = GetSummonMercenaryCampLevel(caster, abilityId, level)
    local integer stock = GetSummonMercenaryCampStock(caster, abilityId, level)
    local integer i = 0
    call SetItemTypeSlots(camp, 0)
    call SetUnitTypeSlots(camp, max)
    loop
        exitwhen (i == max)
        call AddUnitToStock(camp, ChooseRandomCreep(creepLevel), stock, stock)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == SUMMONED_MERCENARY_CAMP and GetUnitAbilitySkillLevelSafe(GetSummoningUnit(), ABILITY_SUMMON_MERCENARY_CAMP) > 0) then
        call SummonMercenaryCamp(GetSummoningUnit(), ABILITY_SUMMON_MERCENARY_CAMP, GetSummonedUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_SUMMON_MERCENARY_CAMP, GetSummonMercenaryCampLevel)
    call RegisterAbilityFieldCustomInteger1(ABILITY_SUMMON_MERCENARY_CAMP, GetSummonMercenaryCampSlots)
    // GetSummonMercenaryCampStock
endfunction

endlibrary
