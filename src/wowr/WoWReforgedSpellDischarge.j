library WoWReforgedSpellDischarge initializer Init requires SimError, WoWReforgedAbilitySkill

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

function GetDischargeCooldownBonus takes unit caster, integer abilityId, integer level returns real
    return 5.00 + I2R(level) * 5.00
endfunction

// TODO Add priority to high level spells!
function StartRandomAbilityCooldown takes unit target, real cooldown returns integer
    local integer i = 0
    local integer max = 10
    local integer abilityId = 0
    loop
        exitwhen (i == max)
        set abilityId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(target, i))
        if (abilityId != 0 and BlzGetUnitAbilityCooldownRemaining(target, abilityId) > 0.0) then
            call BlzStartUnitAbilityCooldown(target, abilityId, cooldown)
            return abilityId
        endif
        set i = i + 1
    endloop
    
    return 0
endfunction

function Discharge takes unit caster, integer abilityId, unit target returns nothing
    local integer index = StartRandomAbilityCooldown(target, GetDischargeCooldownBonus(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId)))
    if (index == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_ABILITY_WITHOUT_COOLDOWNS"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_DISCHARGE) then
        call Discharge(GetTriggerUnit(), GetSpellAbilityId(), GetSpellTargetUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call RegisterAbilityFieldCustomReal0(ABILITY_DISCHARGE, GetDischargeCooldownBonus)
endfunction

endlibrary
