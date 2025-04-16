globals
//globals from BlackArrow:
constant boolean LIBRARY_BlackArrow=true
constant integer BlackArrow_BUFF_ABILITY_ID= 'A000'
constant string BlackArrow_ORDER_ON= "blackarrowon"
constant string BlackArrow_ORDER_OFF= "blackarrowoff"
constant boolean BlackArrow_ADD_STANDARD_OBJECT_DATA= true
constant boolean BlackArrow_ADD_ALL_UNITS_WITH_ORBS= true

integer array BlackArrow___BlackArrowAbiliyId
integer array BlackArrow___BlackArrowAbiliyLevel
integer array BlackArrow___BlackArrowAbiliySummonedUnitTypeId
integer array BlackArrow___BlackArrowAbiliySummonedUnitsCount
real array BlackArrow___BlackArrowAbiliySummonedUnitDuration
real array BlackArrow___BlackArrowAbiliyDurationHero
real array BlackArrow___BlackArrowAbiliyDurationUnit
integer array BlackArrow___BlackArrowAbiliyBuffId
integer BlackArrow___abilityCounter= 0

integer array BlackArrow___itemTypeId
integer array BlackArrow___itemTypeAbilityIndex
integer BlackArrow___itemTypeCounter= 0

hashtable BlackArrow___h= InitHashtable()
group BlackArrow___targets= CreateGroup()
group BlackArrow___autoCasters= CreateGroup()
group BlackArrow___itemUnits= CreateGroup()
trigger BlackArrow___damageTrigger= CreateTrigger()
trigger BlackArrow___deathTrigger= CreateTrigger()
trigger BlackArrow___orderTrigger= CreateTrigger()
trigger BlackArrow___pickupTrigger= CreateTrigger()
trigger BlackArrow___dropTrigger= CreateTrigger()

    // callbacks
unit BlackArrow___triggerCaster= null
unit BlackArrow___triggerTarget= null
group BlackArrow___BlackArrowSummonedUnits= null
integer BlackArrow___BlackArrowAbilityId= 0
trigger array BlackArrow___callbackTrigger
integer BlackArrow___callbackTriggerCounter= 0
//endglobals from BlackArrow
    // Generated
trigger gg_trg_Initialization= null
trigger gg_trg_Init_Black_Arrow_Abilities_and_Item_Types= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Chat_Command_Debug= null
trigger gg_trg_Black_Arrow_Cast_Standard= null
trigger gg_trg_Black_Arrow_Cast_Custom= null
unit gg_unit_ninf_0022= null
unit gg_unit_nbal_0023= null
unit gg_unit_Nbrn_0005= null
unit gg_unit_Nbrn_0006= null

trigger l__library_init

//JASSHelper struct globals:
trigger array st___prototype7
unit f__arg_unit1

endglobals

function sc___prototype7_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype7[i])
endfunction
function sc___prototype7_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype7[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: BlackArrow___RemoveUnitHook
    call sc___prototype7_evaluate(1,a0)
call RemoveUnit(a0)
endfunction

//library BlackArrow:

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


function GetTriggerBlackArrowCaster takes nothing returns unit
    return BlackArrow___triggerCaster
endfunction

function GetTriggerBlackArrowTarget takes nothing returns unit
    return BlackArrow___triggerTarget
endfunction

function GetTriggerBlackArrowSummonedUnits takes nothing returns group
    return BlackArrow___BlackArrowSummonedUnits
endfunction

function GetTriggerBlackArrowAbilityId takes nothing returns integer
    return BlackArrow___BlackArrowAbilityId
endfunction

function TriggerRegisterBlackArrowEvent takes trigger whichTrigger returns nothing
    set BlackArrow___callbackTrigger[BlackArrow___callbackTriggerCounter]=whichTrigger
    set BlackArrow___callbackTriggerCounter=BlackArrow___callbackTriggerCounter + 1
endfunction

function BlackArrowAddAbility takes integer abilityId,integer level,integer summonedUnitTypeId,integer summonedUnitsCount,real summonedUnitDuration,real durationHero,real durationUnit,integer buffId returns integer
    local integer index= BlackArrow___abilityCounter
    set BlackArrow___BlackArrowAbiliyId[index]=abilityId
    set BlackArrow___BlackArrowAbiliyLevel[index]=level
    set BlackArrow___BlackArrowAbiliySummonedUnitTypeId[index]=summonedUnitTypeId
    set BlackArrow___BlackArrowAbiliySummonedUnitsCount[index]=summonedUnitsCount
    set BlackArrow___BlackArrowAbiliySummonedUnitDuration[index]=summonedUnitDuration
    set BlackArrow___BlackArrowAbiliyDurationHero[index]=durationHero
    set BlackArrow___BlackArrowAbiliyDurationUnit[index]=durationUnit
    set BlackArrow___BlackArrowAbiliyBuffId[index]=buffId

    set BlackArrow___abilityCounter=BlackArrow___abilityCounter + 1

    return index
endfunction

function BlackArrowAddItemTypeId takes integer id,integer i returns integer
    local integer index= BlackArrow___itemTypeCounter
    set BlackArrow___itemTypeId[index]=id
    set BlackArrow___itemTypeAbilityIndex[index]=i

    set BlackArrow___itemTypeCounter=BlackArrow___itemTypeCounter + 1

    return index
endfunction

function BlackArrowAddAutoCaster takes unit whichUnit returns nothing
    call GroupAddUnit(BlackArrow___autoCasters, whichUnit)
endfunction

function BlackArrowRemoveAutoCaster takes unit whichUnit returns nothing
    call GroupRemoveUnit(BlackArrow___autoCasters, whichUnit)
endfunction

function BlackArrowIsAutoCaster takes unit which returns boolean
    return IsUnitInGroup(which, BlackArrow___autoCasters)
endfunction

function BlackArrowPrintDebug takes nothing returns nothing
    call BJDebugMsg("Targets: " + I2S(CountUnitsInGroup(BlackArrow___targets)))
    call BJDebugMsg("Auto Casters: " + I2S(CountUnitsInGroup(BlackArrow___autoCasters)))
    call BJDebugMsg("Item Units: " + I2S(CountUnitsInGroup(BlackArrow___itemUnits)))
endfunction

function BlackArrow___GetMatchingAbilityIndex takes unit caster returns integer
    local integer result= - 1
    local integer i= 0
    loop
        exitwhen ( i >= BlackArrow___abilityCounter or result != - 1 )
        if ( GetUnitAbilityLevel(caster, BlackArrow___BlackArrowAbiliyId[i]) == BlackArrow___BlackArrowAbiliyLevel[i] ) then
            set result=i
        endif
        set i=i + 1
    endloop

    return result
endfunction

function BlackArrow___GetMatchingItemTypeIndex takes integer id returns integer
    local integer result= - 1
    local integer i= 0
    loop
        exitwhen ( i >= BlackArrow___itemTypeCounter or result != - 1 )
        if ( BlackArrow___itemTypeId[i] == id ) then
            set result=i
        endif
        set i=i + 1
    endloop

    return result
endfunction

function BlackArrow___TimerFunctionBuffExpires takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local unit target= LoadUnitHandle(BlackArrow___h, GetHandleId(t), 0)
    call FlushChildHashtable(BlackArrow___h, GetHandleId(target))
    call UnitRemoveAbility(target, BlackArrow_BUFF_ABILITY_ID)
    call GroupRemoveUnit(BlackArrow___targets, target)
    set target=null
    call FlushChildHashtable(BlackArrow___h, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function BlackArrow___MarkTarget takes integer abilityIndex,unit source,unit target returns nothing
    local timer whichTimer= LoadTimerHandle(BlackArrow___h, 0, GetHandleId(target))
    local real duration= 0.0
    
    if ( IsUnitType(target, UNIT_TYPE_HERO) ) then
        set duration=BlackArrow___BlackArrowAbiliyDurationHero[abilityIndex]
    else
        set duration=BlackArrow___BlackArrowAbiliyDurationUnit[abilityIndex]
    endif

    //call BJDebugMsg("Marking Black Arrow target " + GetUnitName(GetTriggerUnit()))

    if ( whichTimer != null ) then
        call FlushChildHashtable(BlackArrow___h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer=null
    endif

    set whichTimer=CreateTimer()
    call SaveUnitHandle(BlackArrow___h, GetHandleId(whichTimer), 0, target)
    call SaveTimerHandle(BlackArrow___h, GetHandleId(target), 0, whichTimer)
    call SaveUnitHandle(BlackArrow___h, GetHandleId(target), 1, source)
    call SaveInteger(BlackArrow___h, GetHandleId(target), 2, abilityIndex)
    call TimerStart(whichTimer, duration, false, function BlackArrow___TimerFunctionBuffExpires)

    call UnitAddAbility(target, BlackArrow_BUFF_ABILITY_ID)

    if ( not IsUnitInGroup(target, BlackArrow___targets) ) then
        call GroupAddUnit(BlackArrow___targets, target)
    endif
endfunction

function BlackArrow___ExecuteCallbackTriggers takes unit source,unit target,group summonedUnits,integer abilityId returns nothing
    local integer i= 0
    set BlackArrow___triggerCaster=source
    set BlackArrow___triggerTarget=target
    set BlackArrow___BlackArrowSummonedUnits=summonedUnits
    set BlackArrow___BlackArrowAbilityId=abilityId
    loop
        exitwhen ( i == BlackArrow___callbackTriggerCounter )
        if ( IsTriggerEnabled(BlackArrow___callbackTrigger[i]) ) then
            call TriggerExecute(BlackArrow___callbackTrigger[i])
        endif
        set i=i + 1
    endloop
endfunction

function BlackArrow___CreateNUnits takes integer count,integer unitId,player whichPlayer,real x,real y,real face returns group
    call GroupClear(bj_lastCreatedGroup)
    loop
        set count=count - 1
        exitwhen count < 0
        call GroupAddUnit(bj_lastCreatedGroup, CreateUnit(whichPlayer, unitId, x, y, face))
    endloop
    return bj_lastCreatedGroup
endfunction

function BlackArrow___SummonEffect takes integer abilityIndex,unit source,unit target returns group
    // Does not leak since it uses bj_lastCreatedGroup:
    local group summonedUnits= BlackArrow___CreateNUnits(BlackArrow___BlackArrowAbiliySummonedUnitsCount[abilityIndex] , BlackArrow___BlackArrowAbiliySummonedUnitTypeId[abilityIndex] , GetOwningPlayer(source) , GetUnitX(target) , GetUnitY(target) , GetUnitFacing(target))
    local integer i= 0
    loop
        exitwhen ( i == BlzGroupGetSize(summonedUnits) )
        call SetUnitAnimation(BlzGroupUnitAt(summonedUnits, i), "Birth")
        call UnitApplyTimedLife(BlzGroupUnitAt(summonedUnits, i), BlackArrow___BlackArrowAbiliyBuffId[abilityIndex], BlackArrow___BlackArrowAbiliySummonedUnitDuration[abilityIndex])
        set i=i + 1
    endloop

    call BlackArrow___ExecuteCallbackTriggers(source , target , summonedUnits , BlackArrow___BlackArrowAbiliyId[abilityIndex])

    return summonedUnits
endfunction

function BlackArrow___Effect takes unit target returns group
     local timer whichTimer= LoadTimerHandle(BlackArrow___h, GetHandleId(target), 0)
     local unit source= LoadUnitHandle(BlackArrow___h, GetHandleId(target), 1)
     local integer abilityIndex= LoadInteger(BlackArrow___h, GetHandleId(target), 2)
     local group summonedUnits= BlackArrow___SummonEffect(abilityIndex , source , target)

     //call BJDebugMsg("Black Arrow effect on target " + GetUnitName(target) + " with ability level " + I2S(BlackArrowAbiliyLevel[abilityIndex]) + " summoning units of type " + GetObjectName(BlackArrowAbiliySummonedUnitTypeId[abilityIndex]))

    if ( whichTimer != null ) then
        call FlushChildHashtable(BlackArrow___h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer=null
    endif

    call FlushChildHashtable(BlackArrow___h, GetHandleId(target))
    call UnitRemoveAbility(target, BlackArrow_BUFF_ABILITY_ID)
    call GroupRemoveUnit(BlackArrow___targets, target)

    // remove the decaying corpse
    call h__RemoveUnit(target)
    set target=null

    set source=null

    return summonedUnits
endfunction

function BlackArrow___TriggerConditionDamage takes nothing returns boolean
    local unit whichUnit= GetTriggerUnit()
    local unit source= GetEventDamageSource()
    local boolean result= not IsUnitType(whichUnit, UNIT_TYPE_HERO) and not IsUnitType(whichUnit, UNIT_TYPE_SUMMONED) and not IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL) and not IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE) and not IsUnitType(whichUnit, UNIT_TYPE_RESISTANT) and not IsUnitType(whichUnit, UNIT_TYPE_MAGIC_IMMUNE) and GetUnitLevel(whichUnit) > 5 and ( ( IsUnitInGroup(source, BlackArrow___autoCasters) and BlackArrow___GetMatchingAbilityIndex(source) != - 1 ) or IsUnitInGroup(source, BlackArrow___itemUnits) )
    set whichUnit=null
    set source=null
    return result
endfunction

function BlackArrowUnitGetOrbItem takes unit whichUnit,item excludeItem returns integer
    local item slotItem= null
    local integer i= 0
    // only heroes can use items
    if ( IsUnitType(whichUnit, UNIT_TYPE_HERO) ) then
        loop
            exitwhen ( i >= UnitInventorySize(whichUnit) )
            set slotItem=UnitItemInSlot(whichUnit, i)
            if ( ( excludeItem == null or slotItem != excludeItem ) and BlackArrow___GetMatchingItemTypeIndex(GetItemTypeId(slotItem)) != - 1 ) then
                return i
            endif
            set slotItem=null
            set i=i + 1
        endloop
    endif
    return - 1
endfunction

function BlackArrow___TriggerActionDamage takes nothing returns nothing
    local unit source= GetEventDamageSource()
    local unit target= GetTriggerUnit()
    local integer itemIndex= - 1
    local integer abilityIndex= BlackArrow___GetMatchingAbilityIndex(source)
    if ( abilityIndex != - 1 ) then
        call BlackArrow___MarkTarget(abilityIndex , source , target)
    else
        set itemIndex=BlackArrowUnitGetOrbItem(source , null)
        if ( itemIndex != - 1 ) then
            call BlackArrow___MarkTarget(BlackArrow___itemTypeAbilityIndex[itemIndex] , source , target)
        endif
    endif
    set source=null
    set target=null
endfunction

function BlackArrow___TriggerConditionDeath takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), BlackArrow___targets)
endfunction

function BlackArrow___TriggerActionDeath takes nothing returns nothing
    call BlackArrow___Effect(GetTriggerUnit())
endfunction

function BlackArrow___TriggerConditionOrder takes nothing returns boolean
    return GetIssuedOrderId() == OrderId(BlackArrow_ORDER_ON) or GetIssuedOrderId() == OrderId(BlackArrow_ORDER_OFF)
endfunction

function BlackArrow___TriggerActionOrder takes nothing returns nothing
    if ( GetIssuedOrderId() == OrderId(BlackArrow_ORDER_ON) ) then
        if ( not (IsUnitInGroup((GetTriggerUnit()), BlackArrow___autoCasters)) ) then // INLINED!!
            call GroupAddUnit(BlackArrow___autoCasters, (GetTriggerUnit())) // INLINED!!
        //call BJDebugMsg("Adding unit " + GetUnitName(caster) + " to casters.")
        endif
    else
        if ( (IsUnitInGroup((GetTriggerUnit()), BlackArrow___autoCasters)) ) then // INLINED!!
            call GroupRemoveUnit(BlackArrow___autoCasters, (GetTriggerUnit())) // INLINED!!
            //call BJDebugMsg("Removing unit " + GetUnitName(GetTriggerUnit()) + " from casters.")
        endif
    endif
endfunction

function BlackArrow___TriggerConditionPickupItem takes nothing returns boolean
    // only heroes can use items
    return not IsUnitInGroup(GetTriggerUnit(), BlackArrow___itemUnits) and IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and BlackArrow___GetMatchingItemTypeIndex(GetItemTypeId(GetManipulatedItem())) != - 1
endfunction

function BlackArrow___TriggerActionPickupItem takes nothing returns nothing
    call GroupAddUnit(BlackArrow___itemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " picked up a Black Arrow orb item.")
endfunction

function BlackArrow___TriggerConditionDropItem takes nothing returns boolean
    // we need to exclude the dropped item since it is not dropped yet
    return IsUnitInGroup(GetTriggerUnit(), BlackArrow___itemUnits) and BlackArrow___GetMatchingItemTypeIndex(GetItemTypeId(GetManipulatedItem())) != - 1 and BlackArrowUnitGetOrbItem(GetTriggerUnit() , GetManipulatedItem()) == - 1
endfunction

function BlackArrow___TriggerActionDropItem takes nothing returns nothing
    call GroupRemoveUnit(BlackArrow___itemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " dropped the final Black Arrow orb item.")
endfunction

function BlackArrow___AddStandardObjectData takes nothing returns nothing
    call BlackArrowAddAbility('ANba' , 1 , 'ndr1' , 1 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('ANba' , 2 , 'ndr2' , 1 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('ANba' , 3 , 'ndr3' , 1 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('ACbk' , 1 , 'ndr1' , 1 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddItemTypeId('odef' , BlackArrowAddAbility('ANbs' , 1 , 'ndr1' , 1 , 80.0 , 0.0 , 2.0 , 'BNdm'))
endfunction

function BlackArrow___FilterForUnitWithOrb takes nothing returns boolean
    return UnitInventorySize(GetFilterUnit()) > 0 and BlackArrowUnitGetOrbItem(GetFilterUnit() , null) != - 1
endfunction

function BlackArrow___AddAllUnitsWithOrbs takes nothing returns nothing
    local group whichGroup= CreateGroup()
    call GroupEnumUnitsInRect(whichGroup, GetPlayableMapRect(), Filter(function BlackArrow___FilterForUnitWithOrb))
    set bj_wantDestroyGroup=true
    call GroupAddGroup(whichGroup, BlackArrow___itemUnits)
    //call BJDebugMsg("Units with orbs size " + I2S(CountUnitsInGroup(itemUnits)))
    set whichGroup=null
endfunction

function BlackArrow___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(BlackArrow___damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(BlackArrow___damageTrigger, Condition(function BlackArrow___TriggerConditionDamage))
    call TriggerAddAction(BlackArrow___damageTrigger, function BlackArrow___TriggerActionDamage)

    call TriggerRegisterAnyUnitEventBJ(BlackArrow___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(BlackArrow___deathTrigger, Condition(function BlackArrow___TriggerConditionDeath))
    call TriggerAddAction(BlackArrow___deathTrigger, function BlackArrow___TriggerActionDeath)

    call TriggerRegisterAnyUnitEventBJ(BlackArrow___orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(BlackArrow___orderTrigger, Condition(function BlackArrow___TriggerConditionOrder))
    call TriggerAddAction(BlackArrow___orderTrigger, function BlackArrow___TriggerActionOrder)

    call TriggerRegisterAnyUnitEventBJ(BlackArrow___pickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(BlackArrow___pickupTrigger, Condition(function BlackArrow___TriggerConditionPickupItem))
    call TriggerAddAction(BlackArrow___pickupTrigger, function BlackArrow___TriggerActionPickupItem)

    call TriggerRegisterAnyUnitEventBJ(BlackArrow___dropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(BlackArrow___dropTrigger, Condition(function BlackArrow___TriggerConditionDropItem))
    call TriggerAddAction(BlackArrow___dropTrigger, function BlackArrow___TriggerActionDropItem)


    call BlackArrow___AddStandardObjectData()


    call BlackArrow___AddAllUnitsWithOrbs()

endfunction

function BlackArrow___RemoveUnitHook takes unit whichUnit returns nothing
    local timer whichTimer= LoadTimerHandle(BlackArrow___h, 0, GetHandleId(whichUnit))
    if ( IsUnitInGroup(whichUnit, BlackArrow___targets) ) then
        call GroupRemoveUnit(BlackArrow___targets, whichUnit)
    endif
    if ( IsUnitInGroup(whichUnit, BlackArrow___autoCasters) ) then
        call GroupRemoveUnit(BlackArrow___autoCasters, whichUnit)
    endif
    if ( IsUnitInGroup(whichUnit, BlackArrow___itemUnits) ) then
        call GroupRemoveUnit(BlackArrow___itemUnits, whichUnit)
    endif
    if ( whichTimer != null ) then
        call FlushChildHashtable(BlackArrow___h, GetHandleId(whichUnit))
        call FlushChildHashtable(BlackArrow___h, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer=null
    endif
endfunction

//processed hook: hook RemoveUnit BlackArrow___RemoveUnitHook

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

//library BlackArrow ends
//===========================================================================
// 
// Baradé's Black Arrow 1.2
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: Baradé
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades Black Arrow

//***************************************************************************
//*
//*  Items
//*
//***************************************************************************

function CreateAllItems takes nothing returns nothing
    local integer itemID

    call BlzCreateItemWithSkin('I000', - 24.4, 331.1, 'I000')
    call BlzCreateItemWithSkin('I000', 50.4, 327.8, 'I000')
    call BlzCreateItemWithSkin('I000', 128.1, 331.1, 'I000')
    call BlzCreateItemWithSkin('I000', 212.1, 331.1, 'I000')
    call BlzCreateItemWithSkin('I000', - 180.9, 329.5, 'I000')
    call BlzCreateItemWithSkin('I000', - 94.2, 331.1, 'I000')
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Nbrn_0005=BlzCreateUnitWithSkin(p, 'Nbrn', - 75.1, 37.0, 270.000, 'Nbrn')
    call SetHeroLevel(gg_unit_Nbrn_0005, 10, false)
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANba')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANba')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANba')
    call IssueImmediateOrder(gg_unit_Nbrn_0005, "blackarrowon")
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0005, 'ANch')
    set u=BlzCreateUnitWithSkin(p, 'Hamg', - 376.8, - 32.8, 270.000, 'Hamg')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHmt')
    call UnitAddItemToSlotById(u, 'odef', 0)
    set u=BlzCreateUnitWithSkin(p, 'npfm', - 380.4, 188.0, 270.000, 'npfm')
    call IssueImmediateOrder(u, "blackarrowon")
    set u=BlzCreateUnitWithSkin(p, 'n000', - 375.2, 435.6, 270.000, 'n000')
    call IssueImmediateOrder(u, "blackarrowon")
    set u=BlzCreateUnitWithSkin(p, 'N001', - 75.3, 583.9, 270.000, 'N001')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'A001')
    call SelectHeroSkill(u, 'A001')
    call SelectHeroSkill(u, 'A001')
    call IssueImmediateOrder(u, "blackarrowon")
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANch')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Nbrn_0006=BlzCreateUnitWithSkin(p, 'Nbrn', 75.2, 29.0, 270.000, 'Nbrn')
    call SetHeroLevel(gg_unit_Nbrn_0006, 10, false)
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANsi')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANba')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANba')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANba')
    call IssueImmediateOrder(gg_unit_Nbrn_0006, "blackarrowon")
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANdr')
    call SelectHeroSkill(gg_unit_Nbrn_0006, 'ANch')
    set u=BlzCreateUnitWithSkin(p, 'Hamg', - 516.0, - 10.4, 270.000, 'Hamg')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHwe')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHab')
    call SelectHeroSkill(u, 'AHmt')
    call UnitAddItemToSlotById(u, 'odef', 0)
    set u=BlzCreateUnitWithSkin(p, 'npfm', - 519.7, 179.0, 270.000, 'npfm')
    call IssueImmediateOrder(u, "blackarrowon")
    set u=BlzCreateUnitWithSkin(p, 'n000', - 502.2, 438.6, 270.000, 'n000')
    call IssueImmediateOrder(u, "blackarrowon")
    set u=BlzCreateUnitWithSkin(p, 'N001', 54.6, 558.9, 270.000, 'N001')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'ANsi')
    call SelectHeroSkill(u, 'A001')
    call SelectHeroSkill(u, 'A001')
    call SelectHeroSkill(u, 'A001')
    call IssueImmediateOrder(u, "blackarrowon")
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANdr')
    call SelectHeroSkill(u, 'ANch')
endfunction

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nogr', - 1695.9, - 1953.6, 90.000, 'nogr')
    set u=BlzCreateUnitWithSkin(p, 'nomg', - 653.1, - 1950.8, 90.000, 'nomg')
    set u=BlzCreateUnitWithSkin(p, 'nogm', 632.2, - 1961.8, 90.000, 'nogm')
    set u=BlzCreateUnitWithSkin(p, 'nogl', 2054.9, - 1943.8, 90.000, 'nogl')
    set u=BlzCreateUnitWithSkin(p, 'ninf', - 1362.8, 2111.2, 270.000, 'ninf')
    set u=BlzCreateUnitWithSkin(p, 'nbal', - 1625.0, 2124.2, 270.000, 'nbal')
    set gg_unit_ninf_0022=BlzCreateUnitWithSkin(p, 'ninf', 1959.8, 2090.0, 270.000, 'ninf')
    set gg_unit_nbal_0023=BlzCreateUnitWithSkin(p, 'nbal', 1697.5, 2103.0, 270.000, 'nbal')
    set u=BlzCreateUnitWithSkin(p, 'nogm', 573.9, - 2112.8, 90.000, 'nogm')
    set u=BlzCreateUnitWithSkin(p, 'nogm', 741.0, - 2123.4, 90.000, 'nogm')
    set u=BlzCreateUnitWithSkin(p, 'nogl', 1973.8, - 2126.1, 90.000, 'nogl')
    set u=BlzCreateUnitWithSkin(p, 'nogl', 2181.6, - 2123.8, 90.000, 'nogl')
    set u=BlzCreateUnitWithSkin(p, 'nomg', - 722.0, - 2121.5, 90.000, 'nomg')
    set u=BlzCreateUnitWithSkin(p, 'nomg', - 555.5, - 2123.8, 90.000, 'nomg')
    set u=BlzCreateUnitWithSkin(p, 'nogr', - 1777.5, - 2118.2, 90.000, 'nogr')
    set u=BlzCreateUnitWithSkin(p, 'nogr', - 1612.5, - 2125.5, 90.000, 'nogr')
    set u=BlzCreateUnitWithSkin(p, 'Hpal', 2885.6, 297.8, 180.000, 'Hpal')
    call SelectHeroSkill(u, 'AHad')
    set u=BlzCreateUnitWithSkin(p, 'Hpal', 2873.4, 442.7, 180.000, 'Hpal')
    call SelectHeroSkill(u, 'AHad')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ntav', 0.0, 832.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateNeutralHostile()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Init Black Arrow Abilities and Item Types
//===========================================================================
function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008Func001Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'npfm' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'n000' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'Nbrn' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'N001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008Func001C takes nothing returns boolean
    if ( not Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008A takes nothing returns nothing
    if ( Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008Func001C() ) then
        call GroupAddUnit(BlackArrow___autoCasters, (GetEnumUnit())) // INLINED!!
    else
        call DoNothing()
    endif
endfunction

function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Actions takes nothing returns nothing
    call TriggerRegisterBlackArrowEvent(gg_trg_Black_Arrow_Cast_Custom)
    call BlackArrowAddAbility('A001' , 1 , 'ndr1' , 3 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('A001' , 2 , 'ndr2' , 3 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('A001' , 3 , 'ndr3' , 3 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddAbility('A002' , 3 , 'ndr3' , 3 , 80.0 , 0.0 , 2.0 , 'BNdm')
    call BlackArrowAddItemTypeId('I000' , BlackArrowAddAbility('A004' , 1 , 'ndr1' , 3 , 80.0 , 0.0 , 2.0 , 'BNdm'))
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Func008A)
endfunction

//===========================================================================
function InitTrig_Init_Black_Arrow_Abilities_and_Item_Types takes nothing returns nothing
    set gg_trg_Init_Black_Arrow_Abilities_and_Item_Types=CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Black_Arrow_Abilities_and_Item_Types, function Trig_Init_Black_Arrow_Abilities_and_Item_Types_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func008A takes nothing returns nothing
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_Game_Start_Func009001001 takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_EMPTY )
endfunction

function Trig_Game_Start_Func009A takes nothing returns nothing
    call SetForceAllianceStateBJ(GetForceOfPlayer(GetEnumPlayer()), GetPlayersAll(), bj_ALLIANCE_ALLIED_ADVUNITS)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call FogMaskEnableOff()
    call FogEnableOff()
    call BlzSetUnitIntegerFieldBJ(gg_unit_nbal_0023, UNIT_IF_LEVEL, 3)
    call BlzSetUnitIntegerFieldBJ(gg_unit_ninf_0022, UNIT_IF_LEVEL, 3)
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func008A)
    call ForForce(GetPlayersMatching(Condition(function Trig_Game_Start_Func009001001)), function Trig_Game_Start_Func009A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_030")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_031")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_032")
    call SelectUnitForPlayerSingle(gg_unit_Nbrn_0005, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Nbrn_0006, Player(1))
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Chat Command Debug
//===========================================================================
function Trig_Chat_Command_Debug_Actions takes nothing returns nothing
    call BlackArrowPrintDebug()
endfunction

//===========================================================================
function InitTrig_Chat_Command_Debug takes nothing returns nothing
    set gg_trg_Chat_Command_Debug=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Debug, Player(0), "-debug", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Debug, Player(1), "-debug", true)
    call TriggerAddAction(gg_trg_Chat_Command_Debug, function Trig_Chat_Command_Debug_Actions)
endfunction

//===========================================================================
// Trigger: Black Arrow Cast Standard
//===========================================================================
function Trig_Black_Arrow_Cast_Standard_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetSummonedUnit()) == 'ndr1' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSummonedUnit()) == 'ndr2' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSummonedUnit()) == 'ndr3' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Black_Arrow_Cast_Standard_Conditions takes nothing returns boolean
    if ( not Trig_Black_Arrow_Cast_Standard_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Black_Arrow_Cast_Standard_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( GetUnitName(GetSummoningUnit()) + ( " summons " + ( GetUnitName(GetSummonedUnit()) + "." ) ) ))
endfunction

//===========================================================================
function InitTrig_Black_Arrow_Cast_Standard takes nothing returns nothing
    set gg_trg_Black_Arrow_Cast_Standard=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Black_Arrow_Cast_Standard, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(gg_trg_Black_Arrow_Cast_Standard, Condition(function Trig_Black_Arrow_Cast_Standard_Conditions))
    call TriggerAddAction(gg_trg_Black_Arrow_Cast_Standard, function Trig_Black_Arrow_Cast_Standard_Actions)
endfunction

//===========================================================================
// Trigger: Black Arrow Cast Custom
//===========================================================================
function Trig_Black_Arrow_Cast_Custom_Actions takes nothing returns nothing
    local unit caster= (BlackArrow___triggerCaster) // INLINED!!
    local integer abilityId= (BlackArrow___BlackArrowAbilityId) // INLINED!!
    local unit target= (BlackArrow___triggerTarget) // INLINED!!
    local group minions= (BlackArrow___BlackArrowSummonedUnits) // INLINED!!
    call DisplayTextToForce(GetPlayersAll(), GetUnitName(caster) + " casts " + GetAbilityName(abilityId) + " at target unit " + GetUnitName(target) + " with " + I2S(CountUnitsInGroup(minions)) + " summoned minions.")
endfunction

//===========================================================================
function InitTrig_Black_Arrow_Cast_Custom takes nothing returns nothing
    set gg_trg_Black_Arrow_Cast_Custom=CreateTrigger()
    call TriggerAddAction(gg_trg_Black_Arrow_Cast_Custom, function Trig_Black_Arrow_Cast_Custom_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Init_Black_Arrow_Abilities_and_Item_Types()
    call InitTrig_Game_Start()
    call InitTrig_Chat_Command_Debug()
    call InitTrig_Black_Arrow_Cast_Standard()
    call InitTrig_Black_Arrow_Cast_Custom()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
    call ConditionalTriggerExecute(gg_trg_Init_Black_Arrow_Abilities_and_Item_Types)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(0), true)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(1), true)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_002
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)

    //   Shared Control
    call SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)

    //   Shared Advanced Control
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs595568703")
call ExecuteFunc("BlackArrow___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_003")
    call SetMapDescription("TRIGSTR_029")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 0.0, 0.0)
    call DefineStartLocation(1, 0.0, 0.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype7_BlackArrow___RemoveUnitHook takes nothing returns boolean
    call BlackArrow___RemoveUnitHook(f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs595568703 takes nothing returns nothing
    set st___prototype7[1]=CreateTrigger()
    call TriggerAddAction(st___prototype7[1],function sa___prototype7_BlackArrow___RemoveUnitHook)
    call TriggerAddCondition(st___prototype7[1],Condition(function sa___prototype7_BlackArrow___RemoveUnitHook))

endfunction

