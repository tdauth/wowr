library WoWReforgedSpellSummonWall initializer Init requires MathUtils, SimError, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_ID = 'A1E3'
    public constant integer UNIT_TYPE_ID = 'h0P8'

    private trigger castTrigger = CreateTrigger()
endglobals

function GetSummonWallPieces takes unit cater, integer abilityId, integer level returns integer
    return level + 4
endfunction

function GetSummonWallDuration takes unit cater, integer abilityId, integer level returns real
    return I2R(level) * 5.0 + 45.0
endfunction

function GetSummonWallDamage takes unit cater, integer abilityId, integer level returns real
    return I2R(level) * 5.0 + 10.0
endfunction

function SummonWall takes unit caster, real targetX, real targetY returns nothing
    local player owner = GetOwningPlayer(caster)
    local integer level = GetUnitAbilitySkillLevelSafe(caster, ABILITY_ID)
    local integer max = GetSummonWallPieces(caster, ABILITY_ID, level)
    local real duration = GetSummonWallDuration(caster, ABILITY_ID, level)
    local real damage = GetSummonWallDamage(caster, ABILITY_ID, level)
    local real face = AngleBetweenCoordinatesDeg(GetUnitX(caster), GetUnitY(caster), targetX, targetY) // GetUnitFacing(caster)
    local real distance = 0.0
    local real x = targetX
    local real y = targetY
    local unit wall = null
    local integer counter = 0
    loop
        exitwhen (IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) or counter >= max)
        set counter = counter + 1
        call UnitDamagePoint(caster, 0.0, 128.0, x, y, damage, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
        set wall = CreateUnit(owner, UNIT_TYPE_ID, x, y, face)
        call PlaySoundOnUnitBJ(gg_snd_RockGolemWhat1, 100.0, wall)
        call UnitApplyTimedLife(wall, 'BTLF', duration)
        set distance = distance + 90.0
        set x = PolarProjectionX(targetX, face, distance)
        set y = PolarProjectionY(targetY, face, distance)
        call PolledWait(0.03)
    endloop
    if (counter == 0) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, GetLocalizedString("NO_SPACE"))
    endif
    set owner = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID
endfunction

private function TriggerActionCast takes nothing returns nothing
    call SummonWall(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_SUMMON_WALL, GetSummonWallPieces)
    call RegisterAbilityFieldCustomReal0(ABILITY_SUMMON_WALL, GetDivineShieldDuration)
    call RegisterAbilityFieldCustomReal1(ABILITY_SUMMON_WALL, GetSummonWallDamage)
endfunction

endlibrary
