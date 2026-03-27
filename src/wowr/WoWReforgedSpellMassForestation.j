library WoWReforgedSpellMassForestation initializer Init requires SimError, TreeUtils, WoWReforgedTreeUtils, WoWReforgedZones, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_ID = ABILITY_MASS_FORESTATION
    private trigger castTrigger = CreateTrigger()
    private integer targetUnitLevel = 0
    private player owner = null
    private unit tmpCaster = null
endglobals

function GetMassForestationUnitLevel takes unit caster, integer abilityId, integer level returns integer
    return level * 5
endfunction

private function GetMatchingTreeType takes real x, real y returns integer
    local Zone zone = GetZoneByCoordinates(x, y)
    if (zone != 0 and GetZoneTreeTypeId(zone) != 0) then
        return GetZoneTreeTypeId(zone)
    endif
    
    return RUINS_TREE_WALL
endfunction

private function FilterIsValidEnemyUnit takes nothing returns boolean
    if (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)) then
        return false
    elseif (IsUnitType(GetFilterUnit(), UNIT_TYPE_MAGIC_IMMUNE)) then
        return false
    elseif (IsUnitAlly(GetFilterUnit(), owner)) then
        return false
    elseif (GetUnitAbilityLevel(GetFilterUnit(), 'Avul') > 0) then
        return false
    elseif (GetUnitLevel(GetFilterUnit()) > targetUnitLevel) then
        return false
    endif
    
    return true
endfunction

private function ForGroupConvertIntoTree takes nothing returns nothing
    local unit u = GetEnumUnit()
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local real face = GetUnitFacing(u)
    local destructable d = null
    call UnitDamageTarget(tmpCaster, u, 99999999.0, false, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    set u = null
    set d = CreateDestructable(GetMatchingTreeType(x, y), x, y, face, 1.0, 0)
    call SetDestructableLife(d, 0.0)
    call DestructableRestoreLife(d, GetDestructableMaxLife(d), true)
    set d = null
endfunction

function MassForestation takes unit caster, integer abilityId, real x, real y returns boolean
    local group g = CreateGroup()
    local boolean result = false
    set owner = GetOwningPlayer(caster)
    set targetUnitLevel = GetMassForestationUnitLevel(caster, abilityId, GetUnitAbilitySkillLevelSafe(caster, abilityId))
    call GroupEnumUnitsInRange(g, x, y, 256.0, Filter(function FilterIsValidEnemyUnit))
    set owner = null
    set result = BlzGroupGetSize(g) > 0
    if (result) then
        set tmpCaster = caster
        call ForGroup(g, function ForGroupConvertIntoTree)
        call GroupClear(g)
    endif
    
    call DestroyGroup(g)
    set g = null
    
    return result
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID and not MassForestation(GetTriggerUnit(), GetSpellAbilityId(), GetSpellTargetX(), GetSpellTargetY())) then
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_VALID_TARGETS"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_MASS_FORESTATION, GetMassForestationUnitLevel)
endfunction

endlibrary
