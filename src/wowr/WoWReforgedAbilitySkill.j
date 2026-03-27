library WoWReforgedAbilitySkill initializer Init requires Ascii, StringUtils, WoWReforgedAbilityFields
// https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187

globals
    constant integer HERO_STATS_BONUS_PER_LEVEL = 1
    constant real DAMAGE_BONUS_PER_LEVEL = 40.0
    constant real HP_BONUS_PER_LEVEL = 50
    constant real COOLDOWN_BONUS = 1.0
    constant integer UNIT_LEVEL_BONUS = 11
    constant real DURATION_BONUS_PER_LEVEL = 1.0
    constant integer LIFE_REGENERATION_BONUS_PER_LEVEL = 1
    constant real CHANCE_BONUS_PER_LEVEL = 0.01
    constant real DAMAGE_MULTIPLIER_PER_LEVEL = 0.1
    
    private hashtable h = InitHashtable()
    private hashtable skillHashtable = InitHashtable()
    
    private unit DUMMY = null
    
    private trigger array callbackTriggers
    private integer callbackTriggersCounter = 0
    private integer triggerSkilledAbilityId = 0
    private integer triggerSkilledAbilityLevels = 0
    private unit triggerSkillAbilityUnit = null
    private item triggerSkillAbilityItem = null
endglobals

private function AddAbilityToDummy takes integer abilityId returns ability
    if (GetUnitAbilityLevel(DUMMY, abilityId) == 0) then
        call UnitAddAbility(DUMMY, abilityId)
    endif
    
    return BlzGetUnitAbility(DUMMY, abilityId)
endfunction

function TriggerRegisterAbilitySkill takes trigger whichTrigger returns nothing
    set callbackTriggers[callbackTriggersCounter] = whichTrigger
    set callbackTriggersCounter = callbackTriggersCounter + 1
endfunction

function GetTriggerSkilledAbilityId takes nothing returns integer
    return triggerSkilledAbilityId
endfunction

function GetTriggerSkilledAbilityLevels takes nothing returns integer
    return triggerSkilledAbilityLevels
endfunction

function GetTriggerSkillAbilityUnit takes nothing returns unit
    return triggerSkillAbilityUnit
endfunction

function GetTriggerSkillAbilityItem takes nothing returns item
    return triggerSkillAbilityItem
endfunction

private function ExecuteCallbacks takes unit whichUnit, item whichItem, integer abilityId, integer level returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackTriggersCounter)
        if (IsTriggerEnabled(callbackTriggers[i])) then
            set triggerSkilledAbilityId = abilityId
            set triggerSkilledAbilityLevels = level
            set triggerSkillAbilityUnit = whichUnit
            set triggerSkillAbilityItem = whichItem
            call ConditionalTriggerExecute(callbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function SetHandleIdAbilitySkillLevel takes integer handleId, integer abilityId, integer level returns nothing
    call SaveInteger(skillHashtable, handleId, abilityId, level)
endfunction

function GetHandleIdAbilitySkillLevel takes integer handleId, integer abilityId returns integer
    return LoadInteger(skillHashtable, handleId, abilityId)
endfunction

function GetUnitAbilitySkillLevel takes unit whichUnit, integer abilityId returns integer
    return GetHandleIdAbilitySkillLevel(GetHandleId(whichUnit), abilityId)
endfunction

function GetUnitAbilitySkillLevelSafe takes unit whichUnit, integer abilityId returns integer
    return IMaxBJ(GetUnitAbilityLevel(whichUnit, abilityId), GetUnitAbilitySkillLevel(whichUnit, abilityId))
endfunction

function GetItemAbilitySkillLevel takes item whichItem, integer abilityId returns integer
    return GetHandleIdAbilitySkillLevel(GetHandleId(whichItem), abilityId)
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(skillHashtable, GetHandleId(whichUnit))
endfunction

private function HookRemoveItem takes item whichItem returns nothing
    call FlushChildHashtable(skillHashtable, GetHandleId(whichItem))
endfunction

hook RemoveUnit HookRemoveUnit
hook RemoveItem HookRemoveItem

function HasAbilitySkillExtendedTooltip takes integer abilityId, integer level returns boolean
    return HaveSavedString(h, abilityId, level)
endfunction

function GetAbilitySkillExtendedTooltip takes integer abilityId, integer level returns string
    return LoadStr(h, abilityId, level)
endfunction

private function SetAbilitySkillExtendedTooltip takes integer abilityId, integer level, string tooltip returns nothing
    call SaveStr(h, abilityId, level, tooltip)
endfunction

function SetAbilityTooltip takes integer abilityId, string tooltip returns nothing
    call SetAbilitySkillExtendedTooltip(abilityId, 0, tooltip)
endfunction

// Replace fields <this,Htb1,x> and <this,Htb1,x,%> in an ability tooltip with the actual ability values.
function FormatAbilityTooltip takes unit caster, integer abilityId, integer level, string tooltip returns string
    local ability a = null
    local string result = ""
    local integer length = StringLength(tooltip)
    local string rawcodeAbility = ""
    local string rawcodeField = ""
    local string rawcodeLevel = ""
    local string rawcodePercentage = ""
    local integer lastAfterEnd = 0
    local integer index = 0
    local integer index2 = 0
    local integer fieldType = 0
    local string fieldString = ""
    local boolean hasPercentage = false
    local real percentageFactor = 1.0
    local string fieldValue = "X"
    local integer tooltipAbilityId = abilityId
    local boolean continue = true
    //call BJDebugMsg("Formatting ability tooltip " + tooltip + " with level " + I2S(level))
    loop
        exitwhen (index >= length or not continue)
        set continue = false
        set index = IndexOfStringEx("<", tooltip, index)
        //call BJDebugMsg("Index 1: " + I2S(index))
        if (index != -1) then
            set index2 = IndexOfStringEx(">", tooltip, index)
            //call BJDebugMsg("Index 2: " + I2S(index2))
            if (index2 != -1) then
                set fieldString = SubString(tooltip, index + 1, index2)
                if (StringLength(fieldString) > 0) then
                    set rawcodeAbility = ""
                    set rawcodeField = ""
                    set rawcodeLevel = ""
                    set rawcodePercentage = ""
                    set hasPercentage = false
                    set percentageFactor = 1.0
                
                    set rawcodeField = StringTokenEx(fieldString, 1, ",", false)
                    if (rawcodeField != null) then
                        set rawcodeAbility = StringTokenEx(fieldString, 0, ",", false)
                        set rawcodeLevel = StringTokenEx(fieldString, 2, ",", false)
                        set rawcodePercentage = StringTokenEx(fieldString, 3, ",", false)
                        set hasPercentage = rawcodePercentage == "%%"
                        if (hasPercentage) then
                            set percentageFactor = 100.0
                        endif
                        
                        if (rawcodeAbility != null and rawcodeAbility != "this" and StringLength(rawcodeAbility) > 0) then
                            set tooltipAbilityId = S2A(rawcodeAbility)
                        else
                             set tooltipAbilityId = abilityId
                        endif
                        set fieldType = GetAbilityFieldTypeByFieldId(S2A(rawcodeField))
                        if (rawcodeLevel != null and StringLength(rawcodeLevel) > 0 and rawcodeLevel != "x") then
                            set level = S2I(rawcodeLevel)
                        else
                            // x means that we always take level 0 which might have been modified by the skilling.
                            set level = 0
                        endif
                        
                        //call BJDebugMsg("Tooltip of " + GetObjectName(abilityId) + " with rawcode ability " + rawcodeAbility + " and rawcode level " + rawcodeLevel + " leading to level " + I2S(level) + " and rawcode field " + rawcodeField + " and rawcode percentage " + rawcodePercentage)
                        
                        set result = result + SubString(tooltip, lastAfterEnd, index)
                        
                        set fieldValue = "X"
                        
                        if (fieldType != ABILITY_FIELD_TYPE_UNKNOWN) then
                            if (IsAbilityFieldTypeCustom(fieldType)) then
                                // Custom fields do not actually store any value per unit, so we have to use the level of the ability here.
                                if (caster != null) then
                                    set level = IMaxBJ(1, GetUnitAbilitySkillLevelSafe(caster, tooltipAbilityId)) // Start always with level 1 for custom fields since it will be the first level.
                                else
                                    set level = 1
                                endif
                                if (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_0) then
                                    if (GetAbilityFieldCustomReal0(tooltipAbilityId) != 0) then
                                        set fieldValue = I2S(R2I(GetAbilityFieldCustomReal0(tooltipAbilityId).evaluate(caster, tooltipAbilityId, level) * percentageFactor))
                                    else
                                        call BJDebugMsg("Register function for cr00 for ability " + GetObjectName(tooltipAbilityId) + ".")
                                    endif
                                elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_1) then
                                    if (GetAbilityFieldCustomReal1(tooltipAbilityId) != 0) then
                                        set fieldValue = I2S(R2I(GetAbilityFieldCustomReal1(tooltipAbilityId).evaluate(caster, tooltipAbilityId, level) * percentageFactor))
                                    else
                                        call BJDebugMsg("Register function for cr01 for ability " + GetObjectName(tooltipAbilityId) + ".")
                                    endif
                                elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_REAL_2) then
                                    if (GetAbilityFieldCustomReal2(tooltipAbilityId) != 0) then
                                        set fieldValue = I2S(R2I(GetAbilityFieldCustomReal2(tooltipAbilityId).evaluate(caster, tooltipAbilityId, level) * percentageFactor))
                                    else
                                        call BJDebugMsg("Register function for cr02 for ability " + GetObjectName(tooltipAbilityId) + ".")
                                    endif
                                elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_INTEGER_0) then
                                    if (GetAbilityFieldCustomInteger0(tooltipAbilityId) != 0) then
                                        set fieldValue = I2S(GetAbilityFieldCustomInteger0(tooltipAbilityId).evaluate(caster, tooltipAbilityId, level))
                                    else
                                        call BJDebugMsg("Register function for ci00 for ability " + GetObjectName(tooltipAbilityId) + ".")
                                    endif
                                elseif (fieldType == ABILITY_FIELD_TYPE_CUSTOM_INTEGER_1) then
                                    if (GetAbilityFieldCustomInteger1(tooltipAbilityId) != 0) then
                                        set fieldValue = I2S(GetAbilityFieldCustomInteger1(tooltipAbilityId).evaluate(caster, tooltipAbilityId, level))
                                    else
                                        call BJDebugMsg("Register function for ci01 for ability " + GetObjectName(tooltipAbilityId) + ".")
                                    endif
                                endif
                            else
                                if (caster != null) then
                                    set a = BlzGetUnitAbility(caster, tooltipAbilityId)
                                else
                                    set a = null
                                endif
                                
                                // The unit has no ability, so get its value from a dummy.
                                if (a == null) then
                                    set a = AddAbilityToDummy(tooltipAbilityId)
                                endif
                                
                                if (a != null) then
                                    if (IsAbilityFieldTypeReal(fieldType)) then
                                        set fieldValue = I2S(R2I(BlzGetAbilityRealLevelField(a, ConvertAbilityRealLevelField(S2A(rawcodeField)), level) * percentageFactor))
                                        //call BJDebugMsg("Extracting real field " + rawcodeField + " for level " + I2S(level) + " with percentage factor " + R2S(percentageFactor) + " from ability " + GetObjectName(tooltipAbilityId) + ": " + fieldValue)
                                    elseif (IsAbilityFieldTypeInteger(fieldType)) then
                                        set fieldValue = I2S(BlzGetAbilityIntegerLevelField(a, ConvertAbilityIntegerLevelField(S2A(rawcodeField)), level))
                                    endif
                                    
                                endif
                            endif
                        else
                            call BJDebugMsg("Register field type for field " + rawcodeField + "!")
                        endif
                        
                        //call BJDebugMsg("Field value of " + GetObjectName(tooltipAbilityId) + " with rawcode ability " + rawcodeAbility + " and rawcode level " + rawcodeLevel + " leading to level " + I2S(level) + " and rawcode field " + rawcodeField + " and rawcode percentage " + rawcodePercentage + ": " + fieldValue)
                        set result = result + fieldValue
                        
                        set continue = true
                        set lastAfterEnd = index2 + 1
                        set index = lastAfterEnd
                        
                        //call BJDebugMsg("Continue at index " + I2S(index))
                    endif
                endif
            endif
        endif
    endloop
    if (lastAfterEnd < length) then
        set result = result + SubString(tooltip, lastAfterEnd, length)
    endif
    //call BJDebugMsg("Formatted ability tooltip " + tooltip + " with level " + I2S(level) + ": " + result)
    return result
endfunction

private function AddAbilityBonusesEx takes unit hero, ability whichAbility, integer oldLevel, integer newLevel returns nothing
    local integer abilityId = BlzGetAbilityId(whichAbility)
    local integer diff = newLevel - oldLevel
    //call BJDebugMsg("Adding bonus to ability " + GetObjectName(abilityId) + " with diff " + I2S(diff) + " from old level " + I2S(oldLevel) + " and new level " + I2S(newLevel))
    call AddAbilityFieldBonuses(abilityId, whichAbility, 0, diff * HERO_STATS_BONUS_PER_LEVEL, diff * HERO_STATS_BONUS_PER_LEVEL, I2R(diff) * DURATION_BONUS_PER_LEVEL, I2R(diff) * DAMAGE_BONUS_PER_LEVEL, diff * HP_BONUS_PER_LEVEL, diff * HP_BONUS_PER_LEVEL, diff * LIFE_REGENERATION_BONUS_PER_LEVEL, I2R(diff) * CHANCE_BONUS_PER_LEVEL, I2R(diff) * I2R(HERO_STATS_BONUS_PER_LEVEL), diff * HERO_STATS_BONUS_PER_LEVEL, diff * R2I(HP_BONUS_PER_LEVEL), diff * R2I(HP_BONUS_PER_LEVEL), I2R(diff) * COOLDOWN_BONUS, diff * UNIT_LEVEL_BONUS, I2R(diff) * DAMAGE_MULTIPLIER_PER_LEVEL)
    // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
    call IncUnitAbilityLevel(hero, abilityId)
    call DecUnitAbilityLevel(hero, abilityId)
endfunction

function UpdateAbilityTooltip takes unit hero, integer abilityId, ability a, integer level returns nothing
    //call BJDebugMsg("Update ability tooltip for " + GetObjectName(abilityId) + " with level " + I2S(level))
    call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("ABILITY_LEVEL_X")).s(GetObjectName(abilityId)).i(level).result())
    if (HasAbilitySkillExtendedTooltip(abilityId, 0)) then
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, FormatAbilityTooltip(hero, abilityId, level, GetLocalizedString(GetAbilitySkillExtendedTooltip(abilityId, 0))))
    endif
endfunction

function SkillAbilityEx takes unit hero, integer handleId, integer abilityId, ability a, integer level, boolean updateTooltip returns nothing
    //call BJDebugMsg("Skilling ability " + GetObjectName(abilityId) + " for unit " + GetUnitName(hero) + " to level " + I2S(level))
    if (GetMaxAbilityFields(abilityId) > 0) then
        //call BJDebugMsg("Add bonuses for ability " + GetObjectName(abilityId))
        call AddAbilityBonusesEx(hero, a, GetHandleIdAbilitySkillLevel(handleId, abilityId), level)
    endif
    call SetHandleIdAbilitySkillLevel(handleId, abilityId, level) // After adding bonuses with the diff.
    if (BlzGetAbilityManaCost(abilityId, 0) > 0) then
        call BlzSetUnitAbilityManaCost(hero, abilityId, 0, BlzGetAbilityManaCost(abilityId, 0) + level * MANA_COSTS_PER_ABILITY_LEVEL)
    endif
    if (updateTooltip and not BlzGetAbilityBooleanField(a, ABILITY_BF_ITEM_ABILITY)) then
        call UpdateAbilityTooltip(hero, abilityId, a, level)
    endif
    if (abilityId == ABILITY_BARRAGE) then
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_MISSILE_ART, 0, BlzGetUnitWeaponStringField(hero, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0))       
    endif
endfunction

function SkillAbilityEx2 takes unit hero, integer abilityId, integer level, boolean updateTooltip returns nothing
    local ability a = BlzGetUnitAbility(hero, abilityId)
    if (a != null) then
        call SkillAbilityEx(hero, GetHandleId(hero), abilityId, a, level, updateTooltip)
        call ExecuteCallbacks(hero, null, abilityId, level)
    endif
endfunction

function SkillAbility takes unit hero, integer abilityId, integer level returns nothing
    call SkillAbilityEx2(hero, abilityId, level, true)
endfunction

function SkillItemAbility takes unit hero, item whichItem, integer abilityId, integer level returns nothing
    local ability a = BlzGetItemAbility(whichItem, abilityId)
    if (a != null) then
        call SkillAbilityEx(hero, GetHandleId(whichItem), abilityId, a, level, false)
        call ExecuteCallbacks(hero, whichItem, abilityId, level)
    endif
endfunction

private function Init takes nothing returns nothing
    set DUMMY = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ITEM_VALUES_DUMMY_HERO, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), bj_UNIT_FACING)
endfunction

endlibrary
