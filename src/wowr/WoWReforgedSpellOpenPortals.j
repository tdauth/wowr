library WoWReforgedSpellOpenPortals initializer Init requires SimError, WoWReforgedAbilitySkill

globals
    private trigger channelTrigger = CreateTrigger()
endglobals

function GetOpenPortalsDuration takes unit caster, integer abilityId, integer level returns real
    return 30.0 + R2I(level) * 5.0
endfunction

private function CreateBothPortals takes unit caster, real x, real y, real duration returns nothing
    local real targetX = GetUnitX(caster)
    local real targetY = GetUnitY(caster)
    local unit portal0 = CreateUnit(GetOwningPlayer(caster), OPEN_PORTALS_PORTAL, x, y, bj_UNIT_FACING)
    local unit portal1 = CreateUnit(GetOwningPlayer(caster), OPEN_PORTALS_PORTAL, targetX, targetY, bj_UNIT_FACING)
    call WaygateActivate(portal0, true)
    call WaygateSetDestination(portal0, targetX, targetY)
    call UnitApplyTimedLife(portal0, 'BTLF', duration)
    call WaygateActivate(portal1, true)
    call WaygateSetDestination(portal1, x, y)
    call UnitApplyTimedLife(portal1, 'BTLF', duration)
endfunction

function OpenPortals takes unit caster, integer abilityId, real x, real y returns nothing
    if (IsVisibleToPlayer(x, y, GetOwningPlayer(caster))) then
        call CreateBothPortals(caster, x, y, GetOpenPortalsDuration(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId)))
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_LOCATION_MUST_BE_VISIBLE"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_OPEN_PORTALS) then
        call OpenPortals(GetTriggerUnit(), GetSpellAbilityId(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call RegisterAbilityFieldCustomReal0(ABILITY_OPEN_PORTALS, GetOpenPortalsDuration)
endfunction

endlibrary
