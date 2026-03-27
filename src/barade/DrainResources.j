library DrainResources initializer Init requires SimError, Resources, TreeUtils

globals
    public constant real TIMER_INTERVAL = 1.0
    public constant integer ABILITY_ID = 0
    public constant integer ABILITY_ID_ITEM = 'A18J'
    
    private constant integer KEY_TARGET = 0
    private constant integer KEY_LIGHTNING = 1
    private constant integer KEY_ABILITY = 2

    private hashtable h = InitHashtable()
    private group casters = CreateGroup()
    private timer t = CreateTimer()
    private trigger castTrigger = CreateTrigger()
    private trigger stopTrigger = CreateTrigger()
endglobals

function GetDrainResourcesTimerHandleId takes nothing returns integer
    return GetHandleId(t)
endfunction

function StopDrainResources takes unit caster returns boolean
    local integer handleId = 0
    if (IsUnitInGroup(caster, casters)) then
        call GroupRemoveUnit(casters, caster)
        set handleId = GetHandleId(caster)
        call DestroyLightning(LoadLightningHandle(h, handleId, KEY_LIGHTNING))
        call FlushChildHashtable(h, handleId)
        if (BlzGroupGetSize(casters) == 0) then
            call PauseTimer(t)
        endif
        return true
    endif
    
    return false
endfunction

private function IsDrainedResource takes integer index returns boolean
    local Resource r = GetResource(index)
    return r != Resources_GOLD and r != Resources_LUMBER and r != Resources_FOOD and r != Resources_FOOD_MAX
endfunction

private function Heal takes unit caster, integer amount returns nothing
    call SetUnitLifeBJ(caster, RMinBJ(GetUnitState(caster, UNIT_STATE_LIFE) + I2R(amount), GetUnitState(caster, UNIT_STATE_MAX_LIFE)))
    call SetUnitManaBJ(caster, RMinBJ(GetUnitState(caster, UNIT_STATE_MANA) + I2R(amount), GetUnitState(caster, UNIT_STATE_MAX_MANA)))
endfunction

private function TimerFunctionDrainResources takes nothing returns nothing
    local unit caster = null
    local integer casterHandleId = 0
    local unit target = null
    local destructable targetTree = null
    local player owner = null
    local integer spellDrainedAmount = 0
    local integer drainedAmount = 0
    local integer abilityId = 0
    local boolean atLeastOneResource = false
    local Resource r = 0
    local integer maxResources = 0
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(casters))
        set caster = BlzGroupUnitAt(casters, i)
        set owner = GetOwningPlayer(caster)
        set casterHandleId = GetHandleId(caster)
        set target = LoadUnitHandle(h, casterHandleId, KEY_TARGET)
        
        if (target == null) then
            set targetTree = LoadDestructableHandle(h, casterHandleId, KEY_TARGET)
        endif
        
        set abilityId = LoadInteger(h, casterHandleId, KEY_ABILITY)
        set atLeastOneResource = false
        if (abilityId == ABILITY_ID) then
            set spellDrainedAmount = 1 + 3 * GetUnitAbilityLevel(caster, abilityId)
        else
            set spellDrainedAmount = 2
        endif
        
        if (target != null) then
            set drainedAmount = IMinBJ(spellDrainedAmount, GetResourceAmount(target))
            if (drainedAmount > 0) then
                call AddResourceAmount(target, drainedAmount * -1)
                call AdjustPlayerStateBJ(drainedAmount, owner, PLAYER_STATE_RESOURCE_GOLD)
                call Heal(caster, drainedAmount)
                set atLeastOneResource = true
            endif
            
            set maxResources = GetMaxResources()
            set j = 0
            loop
                exitwhen (j == maxResources)
                if (IsDrainedResource(j)) then
                    set r = GetResource(j)
                    set drainedAmount = IMinBJ(spellDrainedAmount, GetUnitResource(target, r))
                    if (drainedAmount > 0) then
                        call SetUnitResource(target, r, GetUnitResource(target, r) - drainedAmount)
                        call SetPlayerResource(owner, r, GetPlayerResource(owner, r) + drainedAmount)
                        call Heal(caster, drainedAmount)
                        set atLeastOneResource = true
                    endif
                endif
                set j = j + 1
            endloop
        elseif (targetTree != null) then
            set drainedAmount = IMinBJ(spellDrainedAmount, R2I(GetDestructableLife(targetTree)))
            if (drainedAmount > 0) then
                call SetDestructableLife(targetTree, GetDestructableLife(targetTree) - I2R(drainedAmount))
                call AdjustPlayerStateBJ(drainedAmount, owner, PLAYER_STATE_RESOURCE_LUMBER)
                call Heal(caster, drainedAmount)
                set atLeastOneResource = true
            endif
        endif
        
        if (not atLeastOneResource) then
            call StopDrainResources(caster)
            call IssueImmediateOrder(caster, "stop")
        endif
        
        set caster = null
        set owner = null
        set target = null
        set i = i + 1
    endloop
endfunction

private function TargetHasCustomResources takes unit target returns boolean
    local Resource r = 0
    local integer maxResources = GetMaxResources()
    local integer j = 0
    loop
        exitwhen (j == maxResources)
        set r = GetResource(j)
        if (GetUnitResource(target, r) > 0) then
            return true
        endif
        set j = j + 1
    endloop
    return false
endfunction

function DrainResources takes integer abilityId, unit caster, unit target returns nothing
    local integer handleId = 0
    if (GetResourceAmount(target) > 0 or TargetHasCustomResources(target)) then
        call GroupAddUnit(casters, caster)
        set handleId = GetHandleId(caster)
        call SaveUnitHandle(h, handleId, KEY_TARGET, target)
        call SaveLightningHandle(h, handleId, KEY_LIGHTNING, AddLightning("DRAB", true, GetUnitX(caster), GetUnitY(caster), GetUnitX(target), GetUnitY(target)))
        call SaveInteger(h, handleId, KEY_ABILITY, abilityId)
        if (BlzGroupGetSize(casters) == 1) then
            call TimerStart(t, TIMER_INTERVAL, true, function TimerFunctionDrainResources)
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_HAS_NO_RESOURCES"))
    endif
endfunction

function DrainResourcesTree takes integer abilityId, unit caster, destructable target returns nothing
    local integer handleId = 0
    if (IsDestructableTree(target)) then
        call GroupAddUnit(casters, caster)
        set handleId = GetHandleId(caster)
        call SaveDestructableHandle(h, handleId, KEY_TARGET, target)
        call SaveLightningHandle(h, handleId, KEY_LIGHTNING, AddLightning("DRAB", true, GetUnitX(caster), GetUnitY(caster), GetDestructableX(target), GetDestructableY(target)))
        call SaveInteger(h, handleId, KEY_ABILITY, abilityId)
        if (BlzGroupGetSize(casters) == 1) then
            call TimerStart(t, TIMER_INTERVAL, true, function TimerFunctionDrainResources)
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("TARGET_IS_NOT_A_TREE"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if ((ABILITY_ID != 0 and abilityId == ABILITY_ID) or (ABILITY_ID_ITEM != 0 and abilityId == ABILITY_ID_ITEM)) then
        if (GetSpellTargetUnit() != null) then
            call DrainResources(abilityId, GetTriggerUnit(), GetSpellTargetUnit())
        elseif (GetSpellTargetDestructable() != null) then
            call DrainResourcesTree(abilityId, GetTriggerUnit(), GetSpellTargetDestructable())
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_MUST_BE_A_MINE_OR_TREE"))
        endif
    endif
    return false
endfunction

private function TriggerConditionStop takes nothing returns boolean
    call StopDrainResources(GetTriggerUnit())
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
       
    call TriggerRegisterAnyUnitEventBJ(stopTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(stopTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(stopTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(stopTrigger, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    call TriggerAddCondition(stopTrigger, Condition(function TriggerConditionStop))
endfunction

hook RemoveUnit StopDrainResources

endlibrary
