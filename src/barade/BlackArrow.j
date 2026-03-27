library BlackArrow initializer Init

// Baradé's Black Arrow 1.2
//
// Supports Black Arrow abilities for target units with levels greater than 5.
// The standard Black Arrow abilities from Warcraft only work with target units up to level 5.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Copy the custom buff ability "Black Arrow Buff" (A000) into your map and adapt the raw code in the constant BUFF_ABILITY_ID to the new raw code in your map.
// - Optional: Add all preplaced units in your map with enabled Black Arrow auto casting using the function BlackArrowAddAutoCaster.
// - Optional: Use the API functions to register custom abilities and item types.
// - Optional: Create triggers and register Black Arrow events for further custom actions.
//
// Design:
// Auto casters are detected by issued orders. Preplaced units are created in the generated map script function CreateAllUnits which is called in the generated
// method main before the initialization of this system. This means that issued orders from preplaced units won't be detected by the system's order triggers.
// Hence, you have to use the function BlackArrowAddAutoCaster to add all preplaced units in your map with enabled Black Arrow auto casting.
//
// API:
//
// function BlackArrowAddAbility takes integer abilityId, integer level, integer summonedUnitTypeId, integer summonedUnitsCount, real summonedUnitDuration, real durationHero, real durationUnit, integer buffId returns integer
//
// Adds another custom ability to the system with the given configuration. Whenever a unit with the added ability at the given level kills a target with a level greater than 5, it will automatically summon the minions
// with the given unit type for the given amount of time.
// The function returns a unique index refering to the added ability. The first index starts at 1.
//
// function BlackArrowAddItemTypeId takes integer itemTypeId, integer abilityIndex returns integer
//
// Adds an item type which has the Black Arrow ability with the given index. You can combine this function with BlackArrowAddAbility and directly add the ability when adding the item type.
// Whenever a unit with carrying an item with the added item type kills a target unit with a level greater than 5, it will automatically summon the minions with the given configuration from the given ability.
// The function returns a unique index refering to the added item type. The first index starts at 1.
//
// function BlackArrowAddAutoCaster takes unit whichUnit returns nothing
//
// Adds the given unit as auto caster. This is required to detect damage caused by auto casters and cast the Black Arrow effect.
// All preplaced units with an enabled Black Arrow ability in the map must be added manually with this function.
//
// function BlackArrowRemoveAutoCaster takes unit whichUnit returns nothing
//
// Removes the given unit from the group of auto casters.
//
// function BlackArrowIsAutoCaster takes unit which returns boolean
//
// Returns true if the given unit is an auto caster. Otherwise, it returns false.
//
// function TriggerRegisterBlackArrowEvent takes trigger whichTrigger returns nothing
//
// Registers a Black Arrow event for the given callback trigger. This means that the trigger is evaluated and executed whenever an added Black Arrow ability is casted for a target unit above level 5.
// For the standard ability casts, you have to use the standard ability cast events instead.
//
// function GetTriggertriggerCaster takes nothing returns unit
//
// Returns the casting unit for the current callback trigger.
//
// function GetTriggertriggerTarget takes nothing returns unit
//
// Returns the target unit for the current callback trigger.
//
// function GetTriggerBlackArrowSummonedUnits takes nothing returns group
//
// Returns all summoned minions for the current callback trigger. Never destroy this group since it is basically bj_lastCreatedGroup and does not leak.
//
// function GetTriggerBlackArrowAbilityId takes nothing returns integer
//
// Returns the ability ID of the casted Black Arrow ability.

globals
    public constant integer BUFF_ABILITY_ID = 'A0F0'
    public constant string ORDER_ON = "blackarrowon"
    public constant string ORDER_OFF = "blackarrowoff"
    public constant boolean ADD_STANDARD_OBJECT_DATA = true
    public constant boolean ADD_ALL_UNITS_WITH_ORBS = true

    private integer array BlackArrowAbiliyId
    private integer array BlackArrowAbiliyLevel
    private integer array BlackArrowAbiliySummonedUnitTypeId
    private integer array BlackArrowAbiliySummonedUnitsCount
    private real array BlackArrowAbiliySummonedUnitDuration
    private real array BlackArrowAbiliyDurationHero
    private real array BlackArrowAbiliyDurationUnit
    private integer array BlackArrowAbiliyBuffId
    private integer abilityCounter = 0

    private integer array itemTypeId
    private integer array itemTypeAbilityIndex
    private integer itemTypeCounter = 0

    private hashtable h = InitHashtable()
    private group targets = CreateGroup()
    private group autoCasters = CreateGroup()
    private group itemUnits = CreateGroup()
    private trigger damageTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger pickupTrigger = CreateTrigger()
    private trigger dropTrigger = CreateTrigger()

    // callbacks
    private unit triggerCaster = null
    private unit triggerTarget = null
    private group BlackArrowSummonedUnits = null
    private integer BlackArrowAbilityId = 0
    private trigger array callbackTrigger
    private integer callbackTriggerCounter = 0
endglobals

function GetTriggerBlackArrowCaster takes nothing returns unit
    return triggerCaster
endfunction

function GetTriggerBlackArrowTarget takes nothing returns unit
    return triggerTarget
endfunction

function GetTriggerBlackArrowSummonedUnits takes nothing returns group
    return BlackArrowSummonedUnits
endfunction

function GetTriggerBlackArrowAbilityId takes nothing returns integer
    return BlackArrowAbilityId
endfunction

function TriggerRegisterBlackArrowEvent takes trigger whichTrigger returns nothing
    set callbackTrigger[callbackTriggerCounter] = whichTrigger
    set callbackTriggerCounter = callbackTriggerCounter + 1
endfunction

function BlackArrowAddAbility takes integer abilityId, integer level, integer summonedUnitTypeId, integer summonedUnitsCount, real summonedUnitDuration, real durationHero, real durationUnit, integer buffId returns integer
    local integer index = abilityCounter
    set BlackArrowAbiliyId[index] = abilityId
    set BlackArrowAbiliyLevel[index] = level
    set BlackArrowAbiliySummonedUnitTypeId[index] = summonedUnitTypeId
    set BlackArrowAbiliySummonedUnitsCount[index] = summonedUnitsCount
    set BlackArrowAbiliySummonedUnitDuration[index] = summonedUnitDuration
    set BlackArrowAbiliyDurationHero[index] = durationHero
    set BlackArrowAbiliyDurationUnit[index] = durationUnit
    set BlackArrowAbiliyBuffId[index] = buffId

    set abilityCounter = abilityCounter + 1

    return index
endfunction

function BlackArrowAddItemTypeId takes integer id, integer i returns integer
    local integer index = itemTypeCounter
    set itemTypeId[index] = id
    set itemTypeAbilityIndex[index] = i

    set itemTypeCounter = itemTypeCounter + 1

    return index
endfunction

function BlackArrowAddAutoCaster takes unit whichUnit returns nothing
    call GroupAddUnit(autoCasters, whichUnit)
endfunction

function BlackArrowRemoveAutoCaster takes unit whichUnit returns nothing
    call GroupRemoveUnit(autoCasters, whichUnit)
endfunction

function BlackArrowIsAutoCaster takes unit which returns boolean
    return IsUnitInGroup(which, autoCasters)
endfunction

function BlackArrowPrintDebug takes nothing returns nothing
    call BJDebugMsg("Targets: " + I2S(CountUnitsInGroup(targets)))
    call BJDebugMsg("Auto Casters: " + I2S(CountUnitsInGroup(autoCasters)))
    call BJDebugMsg("Item Units: " + I2S(CountUnitsInGroup(itemUnits)))
endfunction

private function GetMatchingAbilityIndex takes unit caster returns integer
    local integer result = -1
    local integer i = 0
    loop
        exitwhen (i >= abilityCounter or result != -1)
        if (GetUnitAbilityLevel(caster, BlackArrowAbiliyId[i]) == BlackArrowAbiliyLevel[i]) then
            set result = i
        endif
        set i = i + 1
    endloop

    return result
endfunction

private function GetMatchingItemTypeIndex takes integer id returns integer
    local integer result = -1
    local integer i = 0
    loop
        exitwhen (i >= itemTypeCounter or result != -1)
        if (itemTypeId[i] == id) then
            set result = i
        endif
        set i = i + 1
    endloop

    return result
endfunction

private function TimerFunctionBuffExpires takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit target = LoadUnitHandle(h, GetHandleId(t), 0)
    call FlushChildHashtable(h, GetHandleId(target))
    call UnitRemoveAbility(target, BUFF_ABILITY_ID)
    call GroupRemoveUnit(targets, target)
    set target = null
    call FlushChildHashtable(h, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function MarkTarget takes integer abilityIndex, unit source, unit target returns nothing
    local timer whichTimer = LoadTimerHandle(h, 0, GetHandleId(target))
    local real duration = 0.0
    
    if (IsUnitType(target, UNIT_TYPE_HERO)) then
        set duration = BlackArrowAbiliyDurationHero[abilityIndex]
    else
        set duration = BlackArrowAbiliyDurationUnit[abilityIndex]
    endif

    //call BJDebugMsg("Marking Black Arrow target " + GetUnitName(GetTriggerUnit()))

    if (whichTimer != null) then
        call FlushChildHashtable(h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer = null
    endif

    set whichTimer = CreateTimer()
    call SaveUnitHandle(h, GetHandleId(whichTimer), 0, target)
    call SaveTimerHandle(h, GetHandleId(target), 0, whichTimer)
    call SaveUnitHandle(h, GetHandleId(target), 1, source)
    call SaveInteger(h, GetHandleId(target), 2, abilityIndex)
    call TimerStart(whichTimer, duration, false, function TimerFunctionBuffExpires)

    call UnitAddAbility(target, BUFF_ABILITY_ID)

    if (not IsUnitInGroup(target, targets)) then
        call GroupAddUnit(targets, target)
    endif
endfunction

private function ExecuteCallbackTriggers takes unit source, unit target, group summonedUnits, integer abilityId returns nothing
    local integer i = 0
    set triggerCaster = source
    set triggerTarget = target
    set BlackArrowSummonedUnits = summonedUnits
    set BlackArrowAbilityId = abilityId
    loop
        exitwhen (i == callbackTriggerCounter)
        if (IsTriggerEnabled(callbackTrigger[i])) then
            call TriggerExecute(callbackTrigger[i])
        endif
        set i = i + 1
    endloop
endfunction

private function CreateNUnits takes integer count, integer unitId, player whichPlayer, real x, real y, real face returns group
    call GroupClear(bj_lastCreatedGroup)
    loop
        set count = count - 1
        exitwhen count < 0
        call GroupAddUnit(bj_lastCreatedGroup, CreateUnit(whichPlayer, unitId, x, y, face))
    endloop
    return bj_lastCreatedGroup
endfunction

private function SummonEffect takes integer abilityIndex, unit source, unit target returns group
    // Does not leak since it uses bj_lastCreatedGroup:
    local group summonedUnits = CreateNUnits(BlackArrowAbiliySummonedUnitsCount[abilityIndex],  BlackArrowAbiliySummonedUnitTypeId[abilityIndex], GetOwningPlayer(source), GetUnitX(target), GetUnitY(target), GetUnitFacing(target))
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(summonedUnits))
        call SetUnitAnimation(BlzGroupUnitAt(summonedUnits, i), "Birth")
        call UnitApplyTimedLife(BlzGroupUnitAt(summonedUnits, i), BlackArrowAbiliyBuffId[abilityIndex], BlackArrowAbiliySummonedUnitDuration[abilityIndex])
        set i = i + 1
    endloop

    call ExecuteCallbackTriggers(source, target, summonedUnits, BlackArrowAbiliyId[abilityIndex])

    return summonedUnits
endfunction

private function Effect takes unit target returns group
     local timer whichTimer = LoadTimerHandle(h, GetHandleId(target), 0)
     local unit source = LoadUnitHandle(h, GetHandleId(target), 1)
     local integer abilityIndex = LoadInteger(h, GetHandleId(target), 2)
     local group summonedUnits = SummonEffect(abilityIndex, source, target)

     //call BJDebugMsg("Black Arrow effect on target " + GetUnitName(target) + " with ability level " + I2S(BlackArrowAbiliyLevel[abilityIndex]) + " summoning units of type " + GetObjectName(BlackArrowAbiliySummonedUnitTypeId[abilityIndex]))

    if (whichTimer != null) then
        call FlushChildHashtable(h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer = null
    endif

    call FlushChildHashtable(h, GetHandleId(target))
    call UnitRemoveAbility(target, BUFF_ABILITY_ID)
    call GroupRemoveUnit(targets, target)

    // remove the decaying corpse
    call RemoveUnit(target)
    set target = null

    set source = null

    return summonedUnits
endfunction

private function TriggerConditionDamage takes nothing returns boolean
    local unit whichUnit = GetTriggerUnit()
    local unit source = GetEventDamageSource()
    local boolean result = not IsUnitType(whichUnit, UNIT_TYPE_HERO) and not IsUnitType(whichUnit, UNIT_TYPE_SUMMONED) and not IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL) and not IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE) and not IsUnitType(whichUnit, UNIT_TYPE_RESISTANT) and not IsUnitType(whichUnit, UNIT_TYPE_MAGIC_IMMUNE) and GetUnitLevel(whichUnit) > 5 and ((IsUnitInGroup(source, autoCasters) and GetMatchingAbilityIndex(source) != -1) or IsUnitInGroup(source, itemUnits))
    set whichUnit = null
    set source = null
    return result
endfunction

function BlackArrowUnitGetOrbItem takes unit whichUnit, item excludeItem returns integer
    local item slotItem = null
    local integer i = 0
    // only heroes can use items
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        loop
            exitwhen (i >= UnitInventorySize(whichUnit))
            set slotItem = UnitItemInSlot(whichUnit, i)
            if ((excludeItem == null or slotItem != excludeItem) and GetMatchingItemTypeIndex(GetItemTypeId(slotItem)) != -1) then
                return i
            endif
            set slotItem = null
            set i = i + 1
        endloop
    endif
    return -1
endfunction

private function TriggerActionDamage takes nothing returns nothing
    local unit source = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local integer itemIndex = -1
    local integer abilityIndex = GetMatchingAbilityIndex(source)
    if (abilityIndex != -1) then
        call MarkTarget(abilityIndex, source, target)
    else
        set itemIndex = BlackArrowUnitGetOrbItem(source, null)
        if (itemIndex != -1) then
            call MarkTarget(itemTypeAbilityIndex[itemIndex], source, target)
        endif
    endif
    set source = null
    set target = null
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), targets)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    call Effect(GetTriggerUnit())
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    return GetIssuedOrderId() == OrderId(ORDER_ON) or GetIssuedOrderId() == OrderId(ORDER_OFF)
endfunction

private function TriggerActionOrder takes nothing returns nothing
    if (GetIssuedOrderId() == OrderId(ORDER_ON)) then
        if (not BlackArrowIsAutoCaster(GetTriggerUnit())) then
            call BlackArrowAddAutoCaster(GetTriggerUnit())
        //call BJDebugMsg("Adding unit " + GetUnitName(caster) + " to casters.")
        endif
    else
        if (BlackArrowIsAutoCaster(GetTriggerUnit())) then
            call BlackArrowRemoveAutoCaster(GetTriggerUnit())
            //call BJDebugMsg("Removing unit " + GetUnitName(GetTriggerUnit()) + " from casters.")
        endif
    endif
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    // only heroes can use items
    return not IsUnitInGroup(GetTriggerUnit(), itemUnits) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetMatchingItemTypeIndex(GetItemTypeId(GetManipulatedItem())) != -1
endfunction

private function TriggerActionPickupItem takes nothing returns nothing
    call GroupAddUnit(itemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " picked up a Black Arrow orb item.")
endfunction

private function TriggerConditionDropItem takes nothing returns boolean
    // we need to exclude the dropped item since it is not dropped yet
    return IsUnitInGroup(GetTriggerUnit(), itemUnits) and GetMatchingItemTypeIndex(GetItemTypeId(GetManipulatedItem())) != -1 and BlackArrowUnitGetOrbItem(GetTriggerUnit(), GetManipulatedItem()) == -1
endfunction

private function TriggerActionDropItem takes nothing returns nothing
    call GroupRemoveUnit(itemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " dropped the final Black Arrow orb item.")
endfunction

private function AddStandardObjectData takes nothing returns nothing
    call BlackArrowAddAbility('ANba', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ANba', 2, 'ndr2', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ANba', 3, 'ndr3', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ACbk', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddItemTypeId('odef', BlackArrowAddAbility('ANbs', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm'))
endfunction

private function FilterForUnitWithOrb takes nothing returns boolean
    return UnitInventorySize(GetFilterUnit()) > 0 and BlackArrowUnitGetOrbItem(GetFilterUnit(), null) != -1
endfunction

private function AddAllUnitsWithOrbs takes nothing returns nothing
    local group whichGroup = CreateGroup()
    call GroupEnumUnitsInRect(whichGroup, GetPlayableMapRect(), Filter(function FilterForUnitWithOrb))
    set bj_wantDestroyGroup = true
    call GroupAddGroup(whichGroup, itemUnits)
    //call BJDebugMsg("Units with orbs size " + I2S(CountUnitsInGroup(itemUnits)))
    set whichGroup = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damageTrigger, Condition(function TriggerConditionDamage))
    call TriggerAddAction(damageTrigger, function TriggerActionDamage)

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)

    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    call TriggerAddAction(orderTrigger, function TriggerActionOrder)

    call TriggerRegisterAnyUnitEventBJ(pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupTrigger, Condition(function TriggerConditionPickupItem))
    call TriggerAddAction(pickupTrigger, function TriggerActionPickupItem)

    call TriggerRegisterAnyUnitEventBJ(dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropTrigger, Condition(function TriggerConditionDropItem))
    call TriggerAddAction(dropTrigger, function TriggerActionDropItem)

static if (ADD_STANDARD_OBJECT_DATA) then
    call AddStandardObjectData()
endif
static if (ADD_ALL_UNITS_WITH_ORBS) then
    call AddAllUnitsWithOrbs()
endif
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    local timer whichTimer = LoadTimerHandle(h, 0, GetHandleId(whichUnit))
    if (IsUnitInGroup(whichUnit, targets)) then
        call GroupRemoveUnit(targets, whichUnit)
    endif
    if (IsUnitInGroup(whichUnit, autoCasters)) then
        call GroupRemoveUnit(autoCasters, whichUnit)
    endif
    if (IsUnitInGroup(whichUnit, itemUnits)) then
        call GroupRemoveUnit(itemUnits, whichUnit)
    endif
    if (whichTimer != null) then
        call FlushChildHashtable(h, GetHandleId(whichUnit))
        call FlushChildHashtable(h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer = null
    endif
endfunction

hook RemoveUnit RemoveUnitHook

// ChangeLog:
//
// 1.2 2025-04-16:
// - Refactor.
// - Check for disabled triggers in callbacks.
// - Fix timer leak for expired buffs.
// - Fix leaks when removing units.
// - Fix only heroes using Orb items.
//
// 1.1 2022-09-24:
// - Use vJass and a library, many private declarations and with early automatic initialization in a module.
// - Add options ADD_STANDARD_OBJECT_DATA and ADD_ALL_UNITS_WITH_ORBS.
// - Add function BlackArrowIsAutoCaster.
// - BlackArrowAbiliyDurationHero is used for target heroes now.
// - Add API documentation with usable functions.
// - Add event handling functions which allow adding actions to Black Arrow events.
// - Refactor some functions.
endlibrary
