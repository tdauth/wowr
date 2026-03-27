library WoWReforgedSpellTelekinesis initializer Init requires SimError, MathUtils

globals
    private constant integer ABILITY_ID = 'A0XZ'
    private constant integer BUFF_ABILITY_ID = 'A0Y1'
    private constant integer ITEM_ABILITY_ID = 'A1VM'

    private hashtable h = InitHashtable()
    private trigger castTrigger = CreateTrigger()
    private group casters = CreateGroup()
    
    private constant integer KEY_TARGET = 0
    private constant integer KEY_TARGET_TYPE = 1
    
    private constant integer TARGET_TYPE_UNIT = 0
    private constant integer TARGET_TYPE_ITEM = 1
    private constant integer TARGET_TYPE_DESTRUCTABLE = 2
endglobals

private function GetMaxDistance takes unit caster returns real
    if (GetUnitAbilityLevel(caster, ABILITY_ID) > 0) then
        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(caster, ABILITY_ID), ABILITY_RLF_CAST_RANGE, 0)
    endif
    
    return 1200.0
endfunction

private function TelekinesisHasTarget takes unit caster returns boolean
    return HaveSavedHandle(h, GetHandleId(caster), KEY_TARGET)
endfunction

private function TelekinesisSaveUnitTarget takes unit caster, unit target returns nothing
    local integer handleId = GetHandleId(caster)
    call SaveUnitHandle(h, handleId, KEY_TARGET, target)
    call SaveInteger(h, handleId, KEY_TARGET_TYPE, TARGET_TYPE_UNIT)
    call UnitAddAbility(target, BUFF_ABILITY_ID)
    //call BJDebugMsg("Target is " + GetUnitName(target))
endfunction

private function TelekinesisSaveItemTarget takes unit caster, item target returns nothing
    local integer handleId = GetHandleId(caster)
    call SaveItemHandle(h, handleId, KEY_TARGET, target)
    call SaveInteger(h, handleId, KEY_TARGET_TYPE, TARGET_TYPE_ITEM)
endfunction

private function TelekinesisSaveDestructableTarget takes unit caster, destructable target returns nothing
    local integer handleId = GetHandleId(caster)
    call SaveDestructableHandle(h, handleId, KEY_TARGET, target)
    call SaveInteger(h, handleId, KEY_TARGET_TYPE, TARGET_TYPE_DESTRUCTABLE)
endfunction

private function TelekinesisClearTarget takes unit caster returns nothing
    local integer handleId = GetHandleId(caster)
    call FlushChildHashtable(h, handleId)
endfunction

private function IsTelekinesisTargetValid takes unit caster returns boolean
    local integer handleId = GetHandleId(caster)
    local integer targetType = LoadInteger(h, handleId, KEY_TARGET_TYPE)
    local real maxDistance = GetMaxDistance(caster)
    local unit targetUnit = null
    local item targetItem = null
    local destructable targetDestructable = null
    if (targetType == TARGET_TYPE_UNIT) then
        set targetUnit = LoadUnitHandle(h, handleId, KEY_TARGET)
        return DistanceBetweenUnits(caster, targetUnit) <= maxDistance
    elseif (targetType == TARGET_TYPE_ITEM) then
        set targetItem = LoadItemHandle(h, handleId, KEY_TARGET)
        return DistanceBetweenUnitAndItem(caster, targetItem) <= maxDistance
    elseif (targetType == TARGET_TYPE_DESTRUCTABLE) then
        set targetDestructable = LoadDestructableHandle(h, handleId, KEY_TARGET)
        return DistanceBetweenUnitAndDestructable(caster, targetDestructable) <= maxDistance
    endif
    
    return false
endfunction

private function MoveDestructable takes destructable d, real x, real y, real face, real scale, integer variation returns destructable
    local integer typeId = GetDestructableTypeId(d)
    local real life = GetDestructableLife(d)
    local destructable t = null
    call RemoveDestructable(d)
    set t = CreateDestructable(typeId, x, y, face, scale, variation)
    call SetDestructableLife(t, life)
    return t
endfunction

private function TelekinesisMoveTargetTo takes unit caster, real x, real y returns nothing
    local integer handleId = GetHandleId(caster)
    local integer targetType = LoadInteger(h, handleId, KEY_TARGET_TYPE)
    local unit targetUnit = null
    local item targetItem = null
    local destructable targetDestructable = null
    local integer targetDestructableTypeId = 0
    local real targetDestructableLife = 0.0
    if (targetType == TARGET_TYPE_UNIT) then
        set targetUnit = LoadUnitHandle(h, handleId, KEY_TARGET)
        call SetUnitX(targetUnit, x)
        call SetUnitY(targetUnit, y)
        call UnitRemoveAbility(targetUnit, BUFF_ABILITY_ID)
        //call BJDebugMsg("Move target: " + GetUnitName(targetUnit))
        set targetUnit = null
    elseif (targetType == TARGET_TYPE_ITEM) then
        set targetItem = LoadItemHandle(h, handleId, KEY_TARGET)
        call SetItemPosition(targetItem, x, y)
        set targetItem = null
    elseif (targetType == TARGET_TYPE_DESTRUCTABLE) then
        set targetDestructable = LoadDestructableHandle(h, handleId, KEY_TARGET)
        call MoveDestructable(targetDestructable, x, y, GetRandomDirectionDeg(), 1.0, 0)
        set targetDestructable = null
    endif
endfunction

private function TimerFunctionResetAbilityCooldown takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit caster = LoadUnitHandle(h, handleId, 0)
    if (not IsUnitInGroup(caster, casters)) then
        //call BJDebugMsg("Reset cooldown for " + GetUnitName(caster))
        call BlzEndUnitAbilityCooldown(caster, ABILITY_ID)
        call BlzEndUnitAbilityCooldown(caster, ITEM_ABILITY_ID)
    endif
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function ResetAbilityCooldown takes unit caster returns nothing
    local timer t = CreateTimer()
    call GroupRemoveUnit(casters, caster)
    call SaveUnitHandle(h, GetHandleId(t), 0, caster)
    call TimerStart(t, 1.0, false, function TimerFunctionResetAbilityCooldown)
endfunction

private function CastTelekinesisOnUnit takes unit caster, unit target returns nothing
    if (not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE)) then
        if (GetUnitAbilityLevel(target, 'Avul') == 0) then
            call TelekinesisSaveUnitTarget(caster, target)
            call ResetAbilityCooldown(caster)
        else
            call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_IS_INVULNERABLE"))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_IS_MAGIC_IMMUNE"))
    endif
endfunction

private function CastTelekinesisOnItem takes unit caster, item target returns nothing
    call TelekinesisSaveItemTarget(caster, target)
    call ResetAbilityCooldown(caster)
endfunction

private function CastTelekinesisOnDestructable takes unit caster, destructable target returns nothing
    call TelekinesisSaveDestructableTarget(caster, target)
    call ResetAbilityCooldown(caster)
endfunction

private function CastTelekinesisOnPoint takes unit caster, real x, real y returns nothing
    if (TelekinesisHasTarget(caster)) then
        if (IsTelekinesisTargetValid(caster)) then
            call GroupRemoveUnit(casters, caster)
            call TelekinesisMoveTargetTo(caster, x, y)
            call TelekinesisClearTarget(caster)
        else
            call TelekinesisClearTarget(caster)
            call IssueImmediateOrder(caster, "stop")
            call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET"))
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_TARGET"))
    endif
endfunction

private function CastTelekinesis takes nothing returns nothing
    if (GetSpellTargetUnit() != null) then
        call CastTelekinesisOnUnit(GetTriggerUnit(), GetSpellTargetUnit())
    elseif (GetSpellTargetItem() != null) then
        call CastTelekinesisOnItem(GetTriggerUnit(), GetSpellTargetItem())
    elseif (GetSpellTargetDestructable() != null) then
        call CastTelekinesisOnDestructable(GetTriggerUnit(), GetSpellTargetDestructable())
    else
        call CastTelekinesisOnPoint(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    
    return abilityId == ABILITY_ID or abilityId == ITEM_ABILITY_ID
endfunction

private function TriggerActionCast takes nothing returns nothing
    call CastTelekinesis()
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    call TriggerAddAction(castTrigger, function TriggerActionCast)
endfunction

private function RemoveUnitTelekinesis takes unit whichUnit returns nothing
    call GroupRemoveUnit(casters, whichUnit)
    call TelekinesisClearTarget(whichUnit)
endfunction

hook RemoveUnit RemoveUnitTelekinesis

endlibrary
