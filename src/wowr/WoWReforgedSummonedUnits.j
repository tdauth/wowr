library WoWReforgedSummonedUnits initializer Init requires WoWReforgedUtils, WoWReforgedI18n, WoWReforgedAbilitySkill, WoWReforgedProfessionInscriptor

globals
    private hashtable h = InitHashtable()
    private group array summonedUnits
    private hashtable summonedUnitTypesForAbilities
    private trigger summonTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger changeOwnerTrigger = CreateTrigger()
    private trigger selectTrigger = CreateTrigger()
endglobals

private struct SummonedUnitAbilityIds
    integer array abilityIds[10]
    integer array abilityStartLevels[10]
    integer array abilityMaxLevels[10]
    integer array abilityUnitTypeIds[10]
    boolean array abilityTimedLife[10]
    integer abilityIdsCounter = 0
endstruct

private function GetSummonedAbilityIds takes integer unitTypeId returns SummonedUnitAbilityIds
    local SummonedUnitAbilityIds s = LoadInteger(h, unitTypeId, 0)
    if (s == 0) then
        set s = SummonedUnitAbilityIds.create()
        call SaveInteger(h, unitTypeId, 0, s)
    endif
    return s
endfunction

private function RegisterAbilitySummonedUnitType takes integer abilityId, integer unitTypeId, integer newUnitTypeId, integer startLevel, integer maxLevel, boolean timedLife returns nothing
    local SummonedUnitAbilityIds s = GetSummonedAbilityIds(unitTypeId)
    local integer index = s.abilityIdsCounter
    set s.abilityIds[index] = abilityId
    set s.abilityStartLevels[index] = startLevel
    set s.abilityMaxLevels[index] = maxLevel
    set s.abilityUnitTypeIds[index] = newUnitTypeId
    set s.abilityTimedLife[index] = timedLife
    set s.abilityIdsCounter = index + 1
endfunction

function IsOwlScout takes integer unitTypeId returns boolean
    if (unitTypeId == OWL_SCOUT_1) then
        return true
    elseif (unitTypeId == OWL_SCOUT_2) then
        return true
    elseif (unitTypeId == OWL_SCOUT_3) then
        return true
    elseif (unitTypeId == OWL_SCOUT_4) then
        return true
    endif
    return false
endfunction

private function AddSummonedUnitBonusEx takes unit summonedUnit, integer level, integer factor returns nothing
    local boolean isCritter = IsUnitCritter(summonedUnit)
    local boolean isOwlScout = IsOwlScout(GetUnitTypeId(summonedUnit))
    if (isCritter or isOwlScout) then
        call SetUnitMoveSpeed(summonedUnit, GetUnitDefaultMoveSpeed(summonedUnit) + I2R(factor) * I2R(level) * 20.00)
        call BlzSetUnitRealField(summonedUnit, UNIT_RF_SIGHT_RADIUS, BlzGetUnitRealField(summonedUnit, UNIT_RF_SIGHT_RADIUS) + I2R(factor) * I2R(level) * 50.00)
    endif
    if (not isOwlScout) then
        call BlzSetUnitMaxHP(summonedUnit, BlzGetUnitMaxHP(summonedUnit) + factor * level * 100)
        call SetUnitLifePercentBJ(summonedUnit, 100)
        if (not isCritter) then
            if (BlzGetUnitWeaponBooleanField(summonedUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0)) then
                call BlzSetUnitBaseDamage(summonedUnit, BlzGetUnitBaseDamage(summonedUnit, 0) + factor * level * 10, 0)
            endif
            if (BlzGetUnitWeaponBooleanField(summonedUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1)) then
                call BlzSetUnitBaseDamage(summonedUnit, BlzGetUnitBaseDamage(summonedUnit, 1) + factor * level * 10, 1)
            endif
        endif
        call BlzSetUnitArmor(summonedUnit, BlzGetUnitArmor(summonedUnit) + I2R(factor) * I2R(level) * 2.00)
        // Leads to gaining 5 levels for heroes
        if (not IsUnitType(summonedUnit, UNIT_TYPE_HERO)) then
            call BlzSetUnitIntegerField( summonedUnit, UNIT_IF_LEVEL, BlzGetUnitIntegerField(summonedUnit, UNIT_IF_LEVEL) + factor * level)
        endif
    endif
endfunction

function AddSummonedUnitBonus takes unit whichUnit, integer level returns nothing
    call AddSummonedUnitBonusEx(whichUnit, level, 1)
endfunction

function RemoveSummonedUnitBonus takes unit whichUnit, integer level returns nothing
    call AddSummonedUnitBonusEx(whichUnit, level, -11)
endfunction

private function ApplySummonedUnitBonusesEx takes unit caster, unit summonedUnit, SummonedUnitAbilityIds s returns unit
    local integer playerId = GetPlayerId(GetOwningPlayer(caster))
    local integer i = 0
    local integer max = s.abilityIdsCounter
    local integer bonusLevel = 0
    local integer checkLevel = 0
    local integer startLevel = 0
    local integer maxLevel = 0
    local integer abilityId = 0
    local real duration = 0.0
    local boolean replaced = false
    local integer abilityIndex = -1
    //call BJDebugMsg("Checking summon unit bonuses for summoned unit " + GetUnitName(summonedUnit) + " with caster " + GetUnitName(caster) + " and ID " + I2S(s))
    loop
        exitwhen (i == max)
        set abilityId = s.abilityIds[i]
        set startLevel = s.abilityStartLevels[i]
        set maxLevel = s.abilityMaxLevels[i]
        set checkLevel = GetUnitAbilitySkillLevelSafe(caster, abilityId)
        if ((startLevel == -1 or checkLevel >= startLevel) and (maxLevel == -1 or checkLevel <= maxLevel)) then
            set abilityIndex = i
            set bonusLevel = checkLevel - startLevel
            set duration = BlzGetAbilityRealLevelField(BlzGetUnitAbility(caster, abilityId), ABILITY_RLF_DURATION_NORMAL, 0)
            //call BJDebugMsg("Matches ability " + GetObjectName(abilityId) + " with bonus level " + I2S(bonusLevel) + " and abiltiy index " + I2S(abilityIndex) + " and duration " + R2S(duration) + " and ability level for caster " + I2S(GetUnitAbilityLevel(caster, abilityId)) + " and caster " + GetUnitName(caster))
        endif
        set i = i + 1
    endloop
    if (abilityIndex != -1) then
        if (s.abilityUnitTypeIds[abilityIndex] != GetUnitTypeId(summonedUnit)) then
            set summonedUnit = ReplaceUnitBJ(summonedUnit, s.abilityUnitTypeIds[abilityIndex], bj_UNIT_STATE_METHOD_RELATIVE)
            call SummonUnitEffect(summonedUnit)
            set replaced = true
        endif
        set bonusLevel = bonusLevel + InscriptorSystemLoadBonus(caster, INSCRIPTOR_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
        if (bonusLevel > 0) then
            //call BJDebugMsg("Applying summoned unit bonus to " + GetUnitName(summonedUnit) + " summoned from caster " + GetUnitName(caster) + " with level " + I2S(bonusLevel) + ".")
            call AddSummonedUnitBonus(summonedUnit, bonusLevel)
        endif
        if (s.abilityTimedLife[abilityIndex]) then
            call UnitApplyTimedLife(summonedUnit, 'BTLF', 60.0)
        elseif (replaced and duration > 0.0) then
            call UnitApplyTimedLife(summonedUnit, 'BTLF', duration)
        endif
    endif
    call GroupAddUnit(summonedUnits[playerId], summonedUnit)
    return summonedUnit
endfunction

private function ApplySummonedUnitBonuses takes unit caster, unit summonedUnit returns nothing
    local SummonedUnitAbilityIds s = LoadInteger(h, GetUnitTypeId(summonedUnit), 0)
    if (s != 0) then
        call ApplySummonedUnitBonusesEx(caster, summonedUnit, s)
    endif
endfunction

function SelectNextSummonedUnit takes player whichPlayer returns unit
    local unit result = GetNextUnitToSelect(summonedUnits[GetPlayerId(whichPlayer)], whichPlayer)
    
    if (result != null) then
        call SelectUnitForPlayerSingle(result, whichPlayer)
        call SmartCameraPanToUnit(whichPlayer, result, 0.0)
    else
        call SimError(whichPlayer, GetLocalizedString("NO_SUMMONED_UNIT"))
    endif
    
    return result
endfunction

function AddSummonedUnit takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    call GroupAddUnit(summonedUnits[playerId], whichUnit)
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetSummonedUnit()))
    call ApplySummonedUnitBonuses(GetSummoningUnit(), GetSummonedUnit())
    return false
endfunction
        
private function TriggerConditionDeath takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (IsUnitInGroup(GetTriggerUnit(), summonedUnits[playerId])) then
        call GroupRemoveUnit(summonedUnits[playerId], GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionChangeOwner takes nothing returns boolean
    local integer sourcePlayerId = GetPlayerId(GetChangingUnitPrevOwner())
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (IsUnitInGroup(GetTriggerUnit(), summonedUnits[sourcePlayerId])) then
        call GroupRemoveUnit(summonedUnits[sourcePlayerId], GetTriggerUnit())
        call GroupAddUnit(summonedUnits[playerId], GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set summonedUnits[i] = CreateGroup()
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
        
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))
    
    // Register all summoned unit types for all abilities here, so summoned units will have increased stats depending on the ability level:
    // ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1
    
    // Hero Classes
    
    // Pyromancer
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_LAVA_SPAWN, LAVA_SPAWN_1, LAVA_SPAWN_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_LAVA_SPAWN, LAVA_SPAWN_1, LAVA_SPAWN_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_LAVA_SPAWN, LAVA_SPAWN_1, LAVA_SPAWN_3, 3, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_PHOENIX, PHOENIX, PHOENIX, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_PHOENIX, PHOENIX, ANCIENT_PHOENIX, 2, -1, false)
    
    // Hydromancer
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_WATER_ELEMENTAL, WATER_ELEMENTAL_1, WATER_ELEMENTAL_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_WATER_ELEMENTAL, WATER_ELEMENTAL_1, WATER_ELEMENTAL_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_WATER_ELEMENTAL, WATER_ELEMENTAL_1, WATER_ELEMENTAL_3, 3, 3, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_WATER_ELEMENTAL, WATER_ELEMENTAL_1, WATER_ELEMENTAL_4, 4, -1, false)
    
    // Geomancer
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_GOLEM, GRANITE_GOLEM, GRANITE_GOLEM, 1, -1, false)
    
    // Aeromancer
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_DJINN, DJINN, DJINN, 1, -1, false)
    
    // Death Knight
    call RegisterAbilitySummonedUnitType(ABILITY_BLACK_ARROW, DARK_MINION_1, DARK_MINION_1, 1, -1, false)
    
    // Warlock
    call RegisterAbilitySummonedUnitType(ABILITY_DOOM, DOOM_GUARD_SUMMONED, DOOM_GUARD_SUMMONED, 1, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_DARK_PORTAL, FEL_STALKER, FEL_STALKER, 1, -1, true)
    call RegisterAbilitySummonedUnitType(ABILITY_DARK_PORTAL, CREEP_DOOM_GUARD, CREEP_DOOM_GUARD, 1, -1, true)
    
    call RegisterAbilitySummonedUnitType(ABILITY_RAIN_OF_CHAOS, INFERNAL, INFERNAL, 1, -1, false)
    
    // Hunter
    call RegisterAbilitySummonedUnitType(ABILITY_SCOUT, OWL_SCOUT_1, OWL_SCOUT_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SCOUT, OWL_SCOUT_1, OWL_SCOUT_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SCOUT, OWL_SCOUT_1, OWL_SCOUT_3, 3, 3, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SCOUT, OWL_SCOUT_1, OWL_SCOUT_4, 4, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_BEAR, SPIRIT_BEAR_1, SPIRIT_BEAR_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_BEAR, SPIRIT_BEAR_1, SPIRIT_BEAR_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_BEAR, SPIRIT_BEAR_1, SPIRIT_BEAR_3, 3, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_QUILBEAST, QUILBEAST_1, QUILBEAST_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_QUILBEAST, QUILBEAST_1, QUILBEAST_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_QUILBEAST, QUILBEAST_1, QUILBEAST_3, 3, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_HAWK, SPIRIT_HAWK_1, SPIRIT_HAWK_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_HAWK, SPIRIT_HAWK_1, SPIRIT_HAWK_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_HAWK, SPIRIT_HAWK_1, SPIRIT_HAWK_3, 3, -1, false)
    
    // Druid
    call RegisterAbilitySummonedUnitType(ABILITY_FORCE_OF_NATURE, TREANT, TREANT, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_FORCE_OF_NATURE, TREANT, TREANT_4, 2, -1, false)
    
    // Monk
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, FIRE_1, FIRE_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, STORM_1, STORM_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, EARTH_1, EARTH_1, 1, 1, false)
    /*
    TODO Can we replace the hero here?
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, FIRE_1, FIRE_2, 2, -1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, STORM_1, STORM_2, 2, -1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_STORM_EARTH_FIRE, EARTH_1, EARTH_2, 2, -1, false)
    */
    
    // Rogue
    call RegisterAbilitySummonedUnitType(ABILITY_FERAL_SPIRIT, SPIRIT_WOLF_1, SPIRIT_WOLF_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_FERAL_SPIRIT, SPIRIT_WOLF_1, SPIRIT_WOLF_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_FERAL_SPIRIT, SPIRIT_WOLF_1, SPIRIT_WOLF_3, 3, 3, false)
    call RegisterAbilitySummonedUnitType(ABILITY_FERAL_SPIRIT, SPIRIT_WOLF_1, SPIRIT_WOLF_4, 4, -1, false)
    
    // Necromancer
    call RegisterAbilitySummonedUnitType(ABILITY_RAISE_DEAD, SKEL_WARRIOR, SKEL_WARRIOR, 1, -1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_RAISE_DEAD, SKELETAL_MAGE, SKELETAL_MAGE, 1, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_CARRION_BEETLES, CARRION_BEETLE_1, CARRION_BEETLE_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_CARRION_BEETLES, CARRION_BEETLE_1, CARRION_BEETLE_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_CARRION_BEETLES, CARRION_BEETLE_1, CARRION_BEETLE_3, 3, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SPAWN_TENTACLE, TENTACLE, TENTACLE, 1, -1, false)

    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_SAPPHIRON, SUMMONED_SAPPHIRON, SUMMONED_SAPPHIRON, 1, -1, false)
    
    // Witch Doctor
    call RegisterAbilitySummonedUnitType(ABILITY_SERPENT_WARD, SERPENT_WARD_1, SERPENT_WARD_1, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SERPENT_WARD, SERPENT_WARD_1, SERPENT_WARD_2, 2, 2, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SERPENT_WARD, SERPENT_WARD_1, SERPENT_WARD_3, 3, 3, false)
    call RegisterAbilitySummonedUnitType(ABILITY_SERPENT_WARD, SERPENT_WARD_1, SERPENT_WARD_4, 4, -1, false)
    
    // Rogue
    call RegisterAbilitySummonedUnitType(ABILITY_VENGEANCE, AVATAR_OF_VENGEANCE, AVATAR_OF_VENGEANCE, 1, 1, false)
    call RegisterAbilitySummonedUnitType(ABILITY_VENGEANCE, AVATAR_OF_VENGEANCE, ETERNAL_AVATAR_OF_VENGEANCE, 2, -1, false)
    
    // Other
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_FIRE_ELEMENTAL, FIRE_ELEMENTAL, FIRE_ELEMENTAL, 1, 1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_SEA_ELEMENTAL, SEA_ELEMENTAL, SEA_ELEMENTAL, 1, 1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_SUMMON_EARTH_ELEMENTAL, EARTH_ELEMENTAL, EARTH_ELEMENTAL, 1, -1, false)
    
    call RegisterAbilitySummonedUnitType(ABILITY_INFERNO, INFERNAL, INFERNAL, 1, -1, false)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    if (IsUnitInGroup(whichUnit, summonedUnits[playerId])) then
        call GroupRemoveUnit(summonedUnits[playerId], whichUnit)
    endif
endfunction

hook RemoveUnit RemoveUnitHook


endlibrary
