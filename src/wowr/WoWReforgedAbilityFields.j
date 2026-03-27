library WoWReforgedAbilityFields
// Stores all fields which can be used to apply bonuses to.
// This is required by the Enchanter profession and for Evolution Stones.
// Not all field changes work in Reforged:
// https://www.hiveworkshop.com/threads/blzsetabilityreallevelfield-is-not-working.339882/
// https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187

globals
    private hashtable AbilityFieldHashTable = InitHashtable()
    private hashtable AbilityFieldCountersHashTable = InitHashtable()
    private hashtable AbilityFieldCustomHashTable = InitHashtable()

    constant integer ABILITY_FIELD_TYPE_UNKNOWN = 0
    constant integer ABILITY_FIELD_TYPE_DEFENSE_INTEGER = 1
    constant integer ABILITY_FIELD_TYPE_HERO_STATS_INTEGER = 2
    constant integer ABILITY_FIELD_TYPE_DURATION_REAL = 3
    constant integer ABILITY_FIELD_TYPE_DAMAGE_REAL = 4
    constant integer ABILITY_FIELD_TYPE_LIFE_REAL = 5
    constant integer ABILITY_FIELD_TYPE_MANA_REAL = 6
    constant integer ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER = 7
    constant integer ABILITY_FIELD_TYPE_CHANCE_REAL = 8
    constant integer ABILITY_FIELD_TYPE_NEGATIVE_CHANCE_REAL = 9 // Enemy movement speed modifier. Drunken Haze.
    constant integer ABILITY_FIELD_TYPE_DEFENSE_REAL = 10
    constant integer ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER = 11
    constant integer ABILITY_FIELD_TYPE_LIFE_INTEGER = 12
    constant integer ABILITY_FIELD_TYPE_MANA_INTEGER = 13
    constant integer ABILITY_FIELD_TYPE_COOLDOWN_REAL = 14 // negative
    constant integer ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER = 15 // maximum creep level
    constant integer ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL = 16
    constant integer ABILITY_FIELD_TYPE_ILLUSIONS_INTEGER = 17 // maximum is 9
    
    constant integer ABILITY_FIELD_TYPE_CUSTOM_INTEGER_0 = 18
    constant integer ABILITY_FIELD_TYPE_CUSTOM_INTEGER_1 = 19
    constant integer ABILITY_FIELD_TYPE_CUSTOM_REAL_0 = 20
    constant integer ABILITY_FIELD_TYPE_CUSTOM_REAL_1 = 21
    constant integer ABILITY_FIELD_TYPE_CUSTOM_REAL_2 = 22
endglobals

function IsAbilityFieldTypeCustom takes integer fieldType returns boolean
    if (fieldType == ABILITY_FIELD_TYPE_CUSTOM_INTEGER_0) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_INTEGER_1) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_0) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_1) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_2) then
        return true
    endif
    return false
endfunction

function IsAbilityFieldTypeReal takes integer fieldType returns boolean
    if (fieldType == ABILITY_FIELD_TYPE_DURATION_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_MANA_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_CHANCE_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_NEGATIVE_CHANCE_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_DEFENSE_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_COOLDOWN_REAL) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL) then
        return true  
    endif
    return false
endfunction

function IsAbilityFieldTypeInteger takes integer fieldType returns boolean
    if (fieldType == ABILITY_FIELD_TYPE_DEFENSE_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_HERO_STATS_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_MANA_INTEGER) then
        return true
    elseif (fieldType == ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER) then
        return true
   elseif (fieldType == ABILITY_FIELD_TYPE_ILLUSIONS_INTEGER) then
        return true 
    endif
    return false
endfunction

function GetAbilityFieldTypeName takes integer fieldType returns string
    if (fieldType == ABILITY_FIELD_TYPE_DEFENSE_INTEGER) then
        return "Defense"
    elseif (fieldType == ABILITY_FIELD_TYPE_HERO_STATS_INTEGER) then
        return "Hero Stats"
    elseif (fieldType == ABILITY_FIELD_TYPE_DURATION_REAL) then
        return "Duration"
    elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_REAL) then
        return "Damage"
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REAL) then
        return "Life"
    elseif (fieldType == ABILITY_FIELD_TYPE_MANA_REAL) then
        return "Mana"
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER) then
        return "Life Regeneration"
    elseif (fieldType == ABILITY_FIELD_TYPE_CHANCE_REAL) then
        return "Chance"
    elseif (fieldType == ABILITY_FIELD_TYPE_NEGATIVE_CHANCE_REAL) then
        return "Negative Chance"
    elseif (fieldType == ABILITY_FIELD_TYPE_DEFENSE_REAL) then
        return "Defense"
     elseif (fieldType == ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) then
        return "Summoned Units"
    elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_INTEGER) then
        return "Life"
    elseif (fieldType == ABILITY_FIELD_TYPE_MANA_INTEGER) then
        return "Mana"
    elseif (fieldType == ABILITY_FIELD_TYPE_COOLDOWN_REAL) then
        return "Cooldown"
    elseif (fieldType == ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER) then
        return "Unit Level"
    elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL) then
        return "Damage Multiplier"
    elseif (fieldType == ABILITY_FIELD_TYPE_ILLUSIONS_INTEGER) then
        return "Illusions"   
    endif
    return "Unknown"
endfunction

function RegisterAbilityFieldType takes integer fieldId, integer fieldType returns nothing
    call SaveInteger(AbilityFieldHashTable, fieldId, 0, fieldType)
endfunction

function GetAbilityFieldTypeByFieldId takes integer fieldId returns integer
    return LoadInteger(AbilityFieldHashTable, fieldId, 0)
endfunction

function RegisterAbilityField takes integer abilityId, integer fieldId returns integer
    local integer counter = LoadInteger(AbilityFieldCountersHashTable, abilityId, 0) + 1
    call SaveInteger(AbilityFieldCountersHashTable, abilityId, counter, fieldId)
    call SaveInteger(AbilityFieldCountersHashTable, abilityId, 0, counter)
    return counter
endfunction

function interface CustomAbilityFieldInteger takes unit caster, integer abilityId, integer level returns integer

function interface CustomAbilityFieldReal takes unit caster, integer abilityId, integer level returns real

function RegisterAbilityFieldCustomInteger0 takes integer abilityId, CustomAbilityFieldInteger f returns integer
    local integer counter = RegisterAbilityField(abilityId, 'ci00')
    call SaveInteger(AbilityFieldCustomHashTable, abilityId, 'ci00', f)
    return counter
endfunction

function GetAbilityFieldCustomInteger0 takes integer abilityId returns CustomAbilityFieldInteger
    return LoadInteger(AbilityFieldCustomHashTable, abilityId, 'ci00')
endfunction

function RegisterAbilityFieldCustomInteger1 takes integer abilityId, CustomAbilityFieldInteger f returns integer
    local integer counter = RegisterAbilityField(abilityId, 'ci01')
    call SaveInteger(AbilityFieldCustomHashTable, abilityId, 'ci01', f)
    return counter
endfunction

function GetAbilityFieldCustomInteger1 takes integer abilityId returns CustomAbilityFieldInteger
    return LoadInteger(AbilityFieldCustomHashTable, abilityId, 'ci01')
endfunction

function RegisterAbilityFieldCustomReal0 takes integer abilityId, CustomAbilityFieldReal f returns integer
    local integer counter = RegisterAbilityField(abilityId, 'cr00')
    call SaveInteger(AbilityFieldCustomHashTable, abilityId, 'cr00', f)
    return counter
endfunction

function GetAbilityFieldCustomReal0 takes integer abilityId returns CustomAbilityFieldReal
    return LoadInteger(AbilityFieldCustomHashTable, abilityId, 'cr00')
endfunction

function RegisterAbilityFieldCustomReal1 takes integer abilityId, CustomAbilityFieldReal f returns integer
    local integer counter = RegisterAbilityField(abilityId, 'cr01')
    call SaveInteger(AbilityFieldCustomHashTable, abilityId, 'cr01', f)
    return counter
endfunction

function GetAbilityFieldCustomReal1 takes integer abilityId returns CustomAbilityFieldReal
    return LoadInteger(AbilityFieldCustomHashTable, abilityId, 'cr01')
endfunction

function RegisterAbilityFieldCustomReal2 takes integer abilityId, CustomAbilityFieldReal f returns integer
    local integer counter = RegisterAbilityField(abilityId, 'cr02')
    call SaveInteger(AbilityFieldCustomHashTable, abilityId, 'cr02', f)
    return counter
endfunction

function GetAbilityFieldCustomReal2 takes integer abilityId returns CustomAbilityFieldReal
    return LoadInteger(AbilityFieldCustomHashTable, abilityId, 'cr02')
endfunction

function GetMaxAbilityFields takes integer abilityId returns integer
    return LoadInteger(AbilityFieldCountersHashTable, abilityId, 0)
endfunction

function GetAbilityFieldId takes integer abilityId, integer index returns integer
    return LoadInteger(AbilityFieldCountersHashTable, abilityId, index + 1)
endfunction

function GetAbilityFieldType takes integer abilityId, integer index returns integer
    return GetAbilityFieldTypeByFieldId(GetAbilityFieldId(abilityId, index))
endfunction

function AddAbilityFieldBonuses takes integer abilityId, ability whichAbility, integer level, integer defenseBonus, integer heroStatsBonus, real durationBonus, real damageBonus, real lifeRealBonus, real manaRealBonus, integer lifeRegenerationBonus, real chanceRealBonus, real defenseRealBonus, integer summonedUnitsBonus, integer lifeBonus, integer manaBonus, real cooldownRealBonus, integer unitLevelBonus, real damageMultiplierBonus returns nothing
    local integer max = GetMaxAbilityFields(abilityId)
    local integer fieldType = 0
    local integer fieldId = 0
    local boolean result = false
    local integer i = 0
    loop
        exitwhen (i >= max)
        set fieldId = GetAbilityFieldId(abilityId, i)
        set fieldType = GetAbilityFieldTypeByFieldId(fieldId)
        if (fieldType == ABILITY_FIELD_TYPE_DEFENSE_INTEGER) then
            //call BJDebugMsg("Adding defense bonus to field " + I2S(fieldId) + " of " + I2S(defenseBonus) + " for level " + I2S(level) + " with previous defense " + I2S(BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level)) + " expected field ID " + I2S('Idef'))
            set result = BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + defenseBonus)
            //call BJDebugMsg("Current defense of field " + I2S(fieldId) + ": " + I2S(BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level)))
            //if (result) then
                //call BJDebugMsg("Result is true.")
            //else
                //call BJDebugMsg("Result is false.")
            //endif
        elseif (fieldType == ABILITY_FIELD_TYPE_HERO_STATS_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + heroStatsBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) then
            //call BJDebugMsg("Adding defense bonus to field " + I2S(fieldId) + "/" + A2S(fieldId) + " of " + I2S(summonedUnitsBonus) + " for level " + I2S(level) + " with previous count " + I2S(BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level)))
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + summonedUnitsBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DURATION_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + durationBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_REAL) then
            //call BJDebugMsg("Adding damage bonus to field " + I2S(fieldId) + " of " + R2S(damageBonus) + " for level " + I2S(level) + " with previous damage " + R2S(BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level)) + " expected field ID " + I2S('Idam'))
            set result = BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + damageBonus)
            //call BJDebugMsg("Current damage of field " + I2S(fieldId) + ": " + R2S(BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level)))
            //if (result) then
              //  call BJDebugMsg("Result is true.")
            //else
              //  call BJDebugMsg("Result is false.")
            //endif
        elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + lifeRealBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_MANA_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + manaRealBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + lifeRegenerationBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_CHANCE_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + chanceRealBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_NEGATIVE_CHANCE_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, RMaxBJ(0.01, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) - chanceRealBonus))
            
        elseif (fieldType == ABILITY_FIELD_TYPE_DEFENSE_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + defenseRealBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + lifeBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_MANA_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + manaBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_COOLDOWN_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, RMaxBJ(0.1, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) - cooldownRealBonus))
        elseif (fieldType == ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + unitLevelBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + damageMultiplierBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_ILLUSIONS_INTEGER) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, IMinBJ(9, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + summonedUnitsBonus))
        endif
        set i = i + 1
    endloop
endfunction

globals
    private hashtable h = InitHashtable()
    
    private integer array abilityIds
    private integer abilityIdsCounter = 0
endglobals

function GetAbilityIdShow takes integer abilityId returns boolean
    return LoadBoolean(h, abilityId, 0)
endfunction

function GetAbilityIdStack takes integer abilityId returns boolean
    return LoadBoolean(h, abilityId, 1)
endfunction

function GetAbilityIdUnusable takes integer abilityId returns boolean
    return LoadBoolean(h, abilityId, 2)
endfunction

function GetAbilityIdIsItem takes integer abilityId returns boolean
    return LoadBoolean(h, abilityId, 3)
endfunction

function RegisterAbilityWithFields takes integer abilityId, boolean show, boolean stack, boolean unusable, boolean isItem returns nothing
    call SaveBoolean(h, abilityId, 0, show)
    call SaveBoolean(h, abilityId, 1, stack)
    call SaveBoolean(h, abilityId, 2, unusable)
    call SaveBoolean(h, abilityId, 3, isItem)
    set abilityIds[abilityIdsCounter] = abilityId
    set abilityIdsCounter = abilityIdsCounter + 1
endfunction

function AbilityFieldsListNonItemAbilities takes nothing returns string
    local string result = ""
    local integer counter = 0
    local integer abilityId = 0
    local integer i = 0
    loop
        exitwhen (i >= abilityIdsCounter)
        set abilityId = abilityIds[i]
        if (not GetAbilityIdIsItem(abilityId)) then
            if (counter > 0) then
                set result = result + ", "
            endif
            set result = result + GetObjectName(abilityId)
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function AbilityFieldsListItemAbilities takes nothing returns string
    local string result = ""
    local integer counter = 0
    local integer abilityId = 0
    local integer i = 0
    loop
        exitwhen (i >= abilityIdsCounter)
        set abilityId = abilityIds[i]
        if (GetAbilityIdIsItem(abilityId)) then
            if (counter > 0) then
                set result = result + ", "
            endif
            set result = result + GetObjectName(abilityId)
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

endlibrary
