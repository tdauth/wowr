globals
//globals from UnitGroupRespawnSystemConfig:
constant boolean LIBRARY_UnitGroupRespawnSystemConfig=true
    // The default delay until a unit will be respawned.
constant real UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT= 30.0
    // All preplaced units owned by the CREEPS_OWNER player on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
constant boolean UnitGroupRespawnSystemConfig_AUTO_ADD_ALL_PREPLACED_CREEPS= true
    // Creates unit group respawns from preplaced creeps next to each other if this value is true. Otherwise, it will create separate unit respawns per creep.
constant boolean UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUPS= true
    // Defines the maximum distance between preplaced creep units to belong to the same respawn group if AUTO_ADDED_GROUPS is true.
constant real UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE= 800.0
    // All players who preplaced units are added as respawning groups for.
constant force UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS= CreateForce()
    // All auto added unit respawns and respawn groups will drop random items when the whole group has been killed or charmed when this value is true. The level of the dropped item will be the maximum unit level of the group.
    // Make sure that all item types have set the field "Stats - Include As Random Choice" to the correct value in the object editor.
constant boolean UnitGroupRespawnSystemConfig_AUTO_ADDED_DROP_RANDOM_ITEMS= true
    // Determines a unit's level by its unit type rather than the actual unit. This helps to get a lower level if the unit levels are changed manually during the game.
constant boolean UnitGroupRespawnSystemConfig_GET_UNIT_LEVEL_BY_TYPE= true
    // Shows the eyecandy on respawning hero revivals if set to true. Otherwise, the effect is not shown.
constant boolean UnitGroupRespawnSystemConfig_HERO_RESPAWN_DO_EYECANDY= true
    // Avoids permanent removal if too many heroes from the same player died.
constant boolean UnitGroupRespawnSystemConfig_SET_MAX_DEATH_TIME_TO_UNITS= true
//endglobals from UnitGroupRespawnSystemConfig
//globals from UnitGroupRespawnSystem:
constant boolean LIBRARY_UnitGroupRespawnSystem=true
constant integer UNIT_RESPAWN_TYPE_UNIT= 0
constant integer UNIT_RESPAWN_TYPE_UNITPOOL= 1
constant integer UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL= 2

integer UnitGroupRespawnSystem___respawnUnitCounter= 0
integer UnitGroupRespawnSystem___respawnUnitFreeIndex= 1
boolean array UnitGroupRespawnSystem___respawnUnitIsValid
integer array UnitGroupRespawnSystem___respawnUnitType
unit array UnitGroupRespawnSystem___respawnUnitUnit
integer array UnitGroupRespawnSystem___respawnUnitHandleId
integer array UnitGroupRespawnSystem___respawnUnitUnitTypeId
unitpool array UnitGroupRespawnSystem___respawnUnitPool
integer array UnitGroupRespawnSystem___respawnUnitRandomCreepLevel
player array UnitGroupRespawnSystem___respawnUnitOwner
real array UnitGroupRespawnSystem___respawnUnitFacing
real array UnitGroupRespawnSystem___respawnUnitX
real array UnitGroupRespawnSystem___respawnUnitY
boolean array UnitGroupRespawnSystem___respawnUnitUseDyingLoc
timer array UnitGroupRespawnSystem___respawnUnitTimer
real array UnitGroupRespawnSystem___respawnUnitTimeout
boolean array UnitGroupRespawnSystem___respawnUnitEnabled
integer array UnitGroupRespawnSystem___respawnUnitGroupIndex
boolean array UnitGroupRespawnSystem___respawnUnitReadyForRespawn

integer UnitGroupRespawnSystem___callbackRespawnTriggersCounter= 0
trigger array UnitGroupRespawnSystem___callbackRespawnTriggers

integer UnitGroupRespawnSystem___callbackRespawnStartsTriggersCounter= 0
trigger array UnitGroupRespawnSystem___callbackRespawnStartsTriggers

unit UnitGroupRespawnSystem___callbackUnit= null
integer UnitGroupRespawnSystem___callbackIndex= - 1

integer UnitGroupRespawnSystem___respawnUnitGroupCounter= 0
integer UnitGroupRespawnSystem___respawnUnitGroupFreeIndex= 1
boolean array UnitGroupRespawnSystem___respawnUnitGroupIsValid
group array UnitGroupRespawnSystem___respawnUnitGroup
timer array UnitGroupRespawnSystem___respawnUnitGroupTimer
real array UnitGroupRespawnSystem___respawnUnitGroupTimeout
boolean array UnitGroupRespawnSystem___respawnUnitGroupEnabled
boolean array UnitGroupRespawnSystem___respawnUnitGroupItemDropEnabled

trigger UnitGroupRespawnSystem___unitDeathOrCharmOrRescueTrigger= CreateTrigger()
hashtable UnitGroupRespawnSystem___respawnUnitHashTable= InitHashtable()

unit UnitGroupRespawnSystem___filterUnit= null
force UnitGroupRespawnSystem___filterForce= null
//endglobals from UnitGroupRespawnSystem
    // User-defined
integer udg_UnitType= 0
player udg_PlayerCreepHeroes= null

    // Generated
rect gg_rct_Unit_Level_Respawn= null
rect gg_rct_Unit_Pool_Respawn= null
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Unit_Respawn= null
trigger gg_trg_Unit_Respawn_Starts= null
trigger gg_trg_Init_Respawn_Callbacks= null
trigger gg_trg_Init_Respawning_Units_Extended= null
trigger gg_trg_Chat_Command_Respawn_All= null
trigger gg_trg_Chat_Command_Ping_All= null
trigger gg_trg_Chat_Command_Ping_Extra= null
trigger gg_trg_Chat_Command_Ping_Units= null
unit gg_unit_Hpal_0000= null
unit gg_unit_Hpal_0029= null
unit gg_unit_Nmsr_0038= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__UnitGroupRespawnSystemConfig___S=1
integer si__UnitGroupRespawnSystemConfig___S_F=0
integer si__UnitGroupRespawnSystemConfig___S_I=0
integer array si__UnitGroupRespawnSystemConfig___S_V
trigger array st___prototype15
unit f__arg_unit1

endglobals


//Generated allocator of UnitGroupRespawnSystemConfig___S
function s__UnitGroupRespawnSystemConfig___S__allocate takes nothing returns integer
 local integer this=si__UnitGroupRespawnSystemConfig___S_F
    if (this!=0) then
        set si__UnitGroupRespawnSystemConfig___S_F=si__UnitGroupRespawnSystemConfig___S_V[this]
    else
        set si__UnitGroupRespawnSystemConfig___S_I=si__UnitGroupRespawnSystemConfig___S_I+1
        set this=si__UnitGroupRespawnSystemConfig___S_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__UnitGroupRespawnSystemConfig___S_V[this]=-1
 return this
endfunction

//Generated destructor of UnitGroupRespawnSystemConfig___S
function s__UnitGroupRespawnSystemConfig___S_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__UnitGroupRespawnSystemConfig___S_V[this]!=-1) then
        return
    endif
    set si__UnitGroupRespawnSystemConfig___S_V[this]=si__UnitGroupRespawnSystemConfig___S_F
    set si__UnitGroupRespawnSystemConfig___S_F=this
endfunction
function sc___prototype15_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype15[i])
endfunction
function sc___prototype15_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype15[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: UnitGroupRespawnSystem___RemoveUnitCleanup
    call sc___prototype15_evaluate(1,a0)
call RemoveUnit(a0)
endfunction

//library UnitGroupRespawnSystemConfig:


function UnitGroupRespawnSystemConfig___GetMaxUnitLevelFromGroup takes group whichGroup returns integer
    local integer maxLevel= 0
    local integer unitLevel= 0
    local integer i= 0
    loop
        exitwhen ( i == BlzGroupGetSize(whichGroup) )
        set unitLevel=GetUnitLevel(BlzGroupUnitAt(whichGroup, i))
        set maxLevel=IMaxBJ(unitLevel, maxLevel)
        set i=i + 1
    endloop
    return maxLevel
endfunction

function UnitGroupRespawnSystemConfig___DropItem takes unit dyingUnit,group whichGroup returns nothing
    local integer unitLevel= UnitGroupRespawnSystemConfig___GetMaxUnitLevelFromGroup(whichGroup)
    local integer itemLevel= unitLevel
    local integer chance= GetRandomInt(0, 100)
    // 40 percent chance to drop an item with level above or below
    if ( chance <= 40 ) then
        if ( chance <= 10 ) then // 10 percent level above
            set itemLevel=IMinBJ(8, unitLevel + GetRandomInt(1, 8 - unitLevel))
        else // 30 percent level below
            set itemLevel=IMaxBJ(0, unitLevel - GetRandomInt(1, unitLevel - 1))
        endif
    endif

    call UnitDropItem(dyingUnit, ChooseRandomItemEx(ITEM_TYPE_ANY, itemLevel))
endfunction

function UnitGroupRespawnSystemConfig___DropItemForGroupEx takes integer groupIndex,unit dyingUnit,group whichGroup returns nothing
    local integer unitLevel= UnitGroupRespawnSystemConfig___GetMaxUnitLevelFromGroup(whichGroup)
    local integer chanceToDrop= GetRandomInt(0, 1)
    
    // 50 percent chance to drop an item at all
    if ( chanceToDrop == 0 ) then
        call UnitGroupRespawnSystemConfig___DropItem(dyingUnit , whichGroup)
    endif
endfunction

// Required by the system.
function UnitGroupRespawnSystemConfig_DropItemForGroup takes integer groupIndex,unit dyingUnit,group whichGroup,boolean drop returns nothing

    if ( drop ) then
        call UnitGroupRespawnSystemConfig___DropItemForGroupEx(groupIndex , dyingUnit , whichGroup)
    endif

endfunction

// Required by the system.
function UnitGroupRespawnSystemConfig_BeforeAddAllUserSpecifiedPreplacedCreeps takes nothing returns nothing
endfunction


function UnitGroupRespawnSystemConfig___IsUnitLivingNonStructure takes nothing returns boolean
    return IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS) and IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

// Required by the system.
// Redefine this function to add different preplaced creeps.
function UnitGroupRespawnSystemConfig_AddAllUserSpecifiedPreplacedCreeps takes group allCreeps returns nothing
    call GroupEnumUnitsInRect(allCreeps, GetPlayableMapRect(), Filter(function UnitGroupRespawnSystemConfig___IsUnitLivingNonStructure))
endfunction

// Required by the system.
function UnitGroupRespawnSystemConfig_AfterAddAllUserSpecifiedPreplacedCreeps takes nothing returns nothing
endfunction


//Implemented from module UnitGroupRespawnSystemConfig___Init:

    function s__UnitGroupRespawnSystemConfig___S_UnitGroupRespawnSystemConfig___Init__onInit takes nothing returns nothing
        call ForceAddPlayer(UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, Player(PLAYER_NEUTRAL_AGGRESSIVE))
        call ForceAddPlayer(UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, Player(6)) // Creep Heroes, do not use global variables here since they are not initialized yet.
    endfunction



//library UnitGroupRespawnSystemConfig ends
//library UnitGroupRespawnSystem:
// Baradé's Unit Group Respawn System 1.3
//
// Allows dying or charmed or rescued units from a group or individually to respawn after some time.
// Respawning groups are automatically determined by default from preplaced creeps next to each other owned by player neutral aggressive.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Place some creeps on the map.
//
// You can change the default configuration by changing the code in the library UnitGroupRespawnSystemConfig.
//
// Design:
//
// The unit variables of the respawns are set to null as soon as the respawn starts, not when the unit dies/changes the owner.
// This is done on purpose, so the callbacks can still access the units by index etc.
// The system does not use vJass structs but simple JASS arrays. This allows you to go through all indices and check an index is used or not.
// The system would require some kind of global list if vJass structs were used whenever you want to get all existing instances.
// The limitation of maximum instances is the maximum array size possible in Warcraft III JASS_MAX_ARRAY_SIZE.
// Even with vJass structs you would have to specify a higher limit manually.
// The system is designed to provide a simple JASS API similar to the JASS functions provided by Blizzard.
// The callbacks work like regular trigger events.
//
// API:
//
// function TriggerRegisterUnitRespawnEvent takes trigger whichTrigger returns nothing
//
// Registers an unit respawn event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any unit is respawned by this system. You can access the triggering respawning unit
// and index from the system via functions.
//
// function TriggerRegisterUnitRespawnStartsEvent takes trigger whichTrigger returns nothing
//
// Registers an unit respawn start event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any unit respawn timer is started by this system. You can access the previously killed or charmed unit
// and index from the system via functions.
//
// function GetRespawningUnit takes nothing returns unit
//
// Returns the triggering respawned unit from a trigger which was evaluated or executed due to a respawn event.
// Returns the triggering killed or charmed previously respawned unit if the event is a respawn starts event.
//
// function GetRespawningUnitIndex takes nothing returns integer
//
// Returns the corresponding index of the unit respawn from the respawned unit or unit for which the respawn timer has been started of the
// evaluated or executed trigger.
//
// function PreventUnitRespawn takes unit whichUnit returns nothing
//
// Can be called in a trigger which is executed on the respawn event to prevent the actual respawn. It removes the respawned unit. The respawn has to be started manually.
//
// function GetUnitRespawnUnitIndex takes unit whichUnit returns integer
//
// Returns the corresponding index of the unit respawn matching the passed unit. If there is none, it returns -1.
//
// function GetRespawnUnitCounter takes nothing returns integer
//
// Returns the maximum number of item respawn indices. Note that not every index in between has to be valid. This function might help integer
// loops to go through all existing item respawns. Please use IsRespawnItemValid to check if an index in between 1 and the return value of
// this function is actually used.
//
// function IsRespawnUnitValid takes integer index returns boolean
//
// Returns if the given index belongs to a valid respawn unit or not. 0 and negative numbers are always an invalid index.
//
// function IsRespawnUnitGroupValid takes integer index returns boolean
//
// Returns if the given index belongs to a valid respawn unit group or not. 0 and negative numbers are always an invalid index
//
// function RespawnUnit takes integer index returns boolean
//
// Immediately respawns the unit of the respawn unit with the given index.
// Returns true if the respawn took place. Otherwise, it returns false.
//
// function RespawnAllUnits takes nothing returns nothing
//
// Immediately respawns all units from all respawn units.
//
// function StartUnitRespawn takes integer index returns nothing
//
// function StartAllUnitRespawnsNotRunning takes nothing returns nothing
//
// function AddRespawnUnit takes unit whichUnit returns integer
//
// function AddRespawnUnitPool takes unitpool whichUnitPool, real x, real y returns integer
//
// function AddRespawnUnitRandomCreep takes integer level, real x, real y returns integer
//
// function RemoveRespawnUnit takes integer index returns boolean
//
// function SetRespawnUnitEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnUnitEnabled takes integer index returns boolean
//
// function GetRespawnUnitTimer takes integer index returns timer
//
// function GetRespawnUnitType takes integer index returns integer
//
// function SetRespawnUnitTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnUnitTimeout takes integer index returns real
//
// function SetRespawnUnitOwner takes integer index, player owner returns nothing
//
// function GetRespawnUnitOwner takes integer index returns player
//
// function SetRespawnUnitFacing takes integer index, real facing returns nothing
//
// function GetRespawnUnitFacing takes integer index returns real
//
// function SetRespawnUnitX takes integer index, real x returns nothing
//
// function GetRespawnUnitX takes integer index returns real
//
// function SetRespawnUnitY takes integer index, real y returns nothing
//
// function GetRespawnUnitY takes integer index returns real
//
// function SetRespawnUnitUseDyingLoc takes integer index, boolean use returns nothing
//
// function GetRespawnUnitUseDyingLoc takes integer index returns boolean
//
// function SetRespawnUnit takes integer index, unit whichUnit returns nothing
//
// function GetRespawnUnit takes integer index returns unit
//
// function SetRespawnUnitPool takes integer index, unitpool whichUnitPool returns nothing
//
// function GetRespawnUnitPool takes integer index returns unitpool
//
// function SetRespawnUnitLevel takes integer index, integer level returns nothing
//
// function GetRespawnUnitLevel takes integer index returns integer
//
// function GetRespawnUnitGroupCounter takes nothing returns integer
//
// function SetRespawnUnitGroupIndex takes integer index, integer groupIndex returns nothing
//
// function GetRespawnUnitGroupIndex takes integer index returns integer
//
// function AddRespawnUnitGroup takes nothing returns integer
//
// function AddRespawnUnitGroupFromUnitEx takes unit whichUnit, force whichForce, real maxDistance returns integer
//
// function AddRespawnUnitGroupFromUnit takes unit whichUnit returns integer
//
// function AddRespawnUnitGroupFromUnitPool takes unitpool whichUnitPool, integer countMembers, real x, real y, real range returns integer
//
// function AddRespawnUnitGroupFromRandomCreepLevel takes integer minCreepLevel, integer maxCreepLevel, integer countMembers, real x, real y, real range returns integer
//
// function RemoveRespawnUnitGroup takes integer index returns boolean
//
// function SetRespawnUnitGroupTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnUnitGroupTimeout takes integer index returns real
//
// function SetRespawnUnitGroupEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnUnitGroupEnabled takes integer index returns boolean

// function SetRespawnUnitGroupItemDropEnabled takes integer index, boolean enabled returns nothing
//
// function GetRespawnUnitGroupItemDropEnabled takes integer index returns boolean
//
// function GetRespawnUnitGroupUnits takes integer index returns group
//
// function RespawnUnitGroup takes integer index returns boolean
//
// function StartUnitGroupRespawn takes integer index returns nothing
//
// Starts the timer for the respawning unit group to respawn the whole group even if members are still alive.
//
// function AddRespawnUnitGroupFromUnitStart takes unit whichUnit returns nothing


function GetRespawningUnit takes nothing returns unit
    return UnitGroupRespawnSystem___callbackUnit
endfunction

function GetRespawningUnitIndex takes nothing returns integer
    return UnitGroupRespawnSystem___callbackIndex
endfunction

function TriggerRegisterUnitRespawnEvent takes trigger whichTrigger returns nothing
    local integer index= UnitGroupRespawnSystem___callbackRespawnTriggersCounter
    set UnitGroupRespawnSystem___callbackRespawnTriggers[index]=whichTrigger
    set UnitGroupRespawnSystem___callbackRespawnTriggersCounter=UnitGroupRespawnSystem___callbackRespawnTriggersCounter + 1
endfunction

function UnitGroupRespawnSystem___EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= UnitGroupRespawnSystem___callbackRespawnTriggersCounter )
        if ( IsTriggerEnabled(UnitGroupRespawnSystem___callbackRespawnTriggers[i]) ) then
            set UnitGroupRespawnSystem___callbackUnit=UnitGroupRespawnSystem___respawnUnitUnit[index]
            set UnitGroupRespawnSystem___callbackIndex=index
            call ConditionalTriggerExecute(UnitGroupRespawnSystem___callbackRespawnTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function TriggerRegisterUnitRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index= UnitGroupRespawnSystem___callbackRespawnStartsTriggersCounter
    set UnitGroupRespawnSystem___callbackRespawnStartsTriggers[index]=whichTrigger
    set UnitGroupRespawnSystem___callbackRespawnStartsTriggersCounter=UnitGroupRespawnSystem___callbackRespawnStartsTriggersCounter + 1
endfunction

function UnitGroupRespawnSystem___EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= UnitGroupRespawnSystem___callbackRespawnStartsTriggersCounter )
        if ( IsTriggerEnabled(UnitGroupRespawnSystem___callbackRespawnStartsTriggers[i]) ) then
            set UnitGroupRespawnSystem___callbackUnit=UnitGroupRespawnSystem___respawnUnitUnit[index]
            set UnitGroupRespawnSystem___callbackIndex=index
            call ConditionalTriggerExecute(UnitGroupRespawnSystem___callbackRespawnStartsTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function UnitGroupRespawnSystem___ClearRespawnUnitIndex takes integer handleID returns nothing
    if ( HaveSavedInteger(UnitGroupRespawnSystem___respawnUnitHashTable, handleID, 0) ) then
        call FlushChildHashtable(UnitGroupRespawnSystem___respawnUnitHashTable, handleID)
    endif
endfunction

function UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID takes integer handleID returns integer
    if ( HaveSavedInteger(UnitGroupRespawnSystem___respawnUnitHashTable, handleID, 0) ) then
        return LoadInteger(UnitGroupRespawnSystem___respawnUnitHashTable, handleID, 0)
    endif

    return - 1
endfunction

function GetUnitRespawnUnitIndex takes unit whichUnit returns integer
    return UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId(whichUnit))
endfunction

function GetRespawnUnitCounter takes nothing returns integer
    return UnitGroupRespawnSystem___respawnUnitCounter
endfunction

function IsRespawnUnitValid takes integer index returns boolean
    return index > 0 and UnitGroupRespawnSystem___respawnUnitIsValid[index]
endfunction

function IsRespawnUnitGroupValid takes integer index returns boolean
    return index > 0 and UnitGroupRespawnSystem___respawnUnitGroupIsValid[index]
endfunction

function RespawnUnit takes integer index returns boolean
    local boolean add= false
    local integer groupIndex= UnitGroupRespawnSystem___respawnUnitGroupIndex[index]
    if ( not IsRespawnUnitValid(index) ) then
        return false
    endif
    if ( UnitGroupRespawnSystem___respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNIT ) then
        if ( UnitGroupRespawnSystem___respawnUnitUnit[index] != null and IsUnitType(UnitGroupRespawnSystem___respawnUnitUnit[index], UNIT_TYPE_HERO) ) then
            call ReviveHero(UnitGroupRespawnSystem___respawnUnitUnit[index], UnitGroupRespawnSystem___respawnUnitX[index], UnitGroupRespawnSystem___respawnUnitY[index], UnitGroupRespawnSystemConfig_HERO_RESPAWN_DO_EYECANDY)
        else
            set UnitGroupRespawnSystem___respawnUnitUnit[index]=CreateUnit(UnitGroupRespawnSystem___respawnUnitOwner[index], UnitGroupRespawnSystem___respawnUnitUnitTypeId[index], UnitGroupRespawnSystem___respawnUnitX[index], UnitGroupRespawnSystem___respawnUnitY[index], UnitGroupRespawnSystem___respawnUnitFacing[index])
            set add=true
        endif
    elseif ( UnitGroupRespawnSystem___respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNITPOOL ) then
        set UnitGroupRespawnSystem___respawnUnitUnit[index]=PlaceRandomUnit(UnitGroupRespawnSystem___respawnUnitPool[index], UnitGroupRespawnSystem___respawnUnitOwner[index], UnitGroupRespawnSystem___respawnUnitX[index], UnitGroupRespawnSystem___respawnUnitY[index], UnitGroupRespawnSystem___respawnUnitFacing[index])
        set add=true
    elseif ( UnitGroupRespawnSystem___respawnUnitType[index] == UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL ) then
        set UnitGroupRespawnSystem___respawnUnitUnit[index]=CreateUnit(UnitGroupRespawnSystem___respawnUnitOwner[index], ChooseRandomCreep(UnitGroupRespawnSystem___respawnUnitRandomCreepLevel[index]), UnitGroupRespawnSystem___respawnUnitX[index], UnitGroupRespawnSystem___respawnUnitY[index], UnitGroupRespawnSystem___respawnUnitFacing[index])
        set add=true
    endif
    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=false
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=GetHandleId(UnitGroupRespawnSystem___respawnUnitUnit[index])
    call SaveInteger(UnitGroupRespawnSystem___respawnUnitHashTable, UnitGroupRespawnSystem___respawnUnitHandleId[index], 0, index)
    

    if ( IsUnitType(UnitGroupRespawnSystem___respawnUnitUnit[index], UNIT_TYPE_HERO) ) then
        call BlzSetUnitRealField(UnitGroupRespawnSystem___respawnUnitUnit[index], UNIT_RF_DEATH_TIME, 99999999.0)
    endif


    if ( add and IsRespawnUnitGroupValid(groupIndex) ) then
        //call BJDebugMsg("Adding back unit " + GetUnitName(respawnUnitUnit[index]) + " with index " + I2S(index) + " to group " + I2S(groupIndex))
        call GroupAddUnit(UnitGroupRespawnSystem___respawnUnitGroup[groupIndex], UnitGroupRespawnSystem___respawnUnitUnit[index])
    endif

    call UnitGroupRespawnSystem___EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllUnits takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
        if ( IsRespawnUnitValid(i) and UnitGroupRespawnSystem___respawnUnitUnit[i] == null ) then
            call RespawnUnit(i)
        endif
        set i=i + 1
    endloop
endfunction

function PreventUnitRespawn takes unit whichUnit returns nothing
    local integer index= (UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((whichUnit)))) // INLINED!!
    if ( IsRespawnUnitValid(index) ) then
        if ( IsUnitType(UnitGroupRespawnSystem___respawnUnitUnit[index], UNIT_TYPE_HERO) ) then
            call KillUnit(whichUnit)
        else
            call UnitGroupRespawnSystem___ClearRespawnUnitIndex(UnitGroupRespawnSystem___respawnUnitHandleId[index])
            set UnitGroupRespawnSystem___respawnUnitHandleId[index]=0
            call h__RemoveUnit(whichUnit)
        endif
    endif
endfunction

function UnitGroupRespawnSystem___TimerFunctionRespawnUnit takes nothing returns nothing
    local integer index= LoadInteger(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnit(index)
endfunction

function StartUnitRespawn takes integer index returns nothing
    call UnitGroupRespawnSystem___EvaluateAndExecuteCallbackRespawnStartsTriggers(index)
    
    if ( not UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index] ) then
        call BJDebugMsg("Duplicated start respawn timer for index " + I2S(index) + " for unit " + GetUnitName(UnitGroupRespawnSystem___respawnUnitUnit[index]))
    endif

    if ( UnitGroupRespawnSystem___respawnUnitHandleId[index] != 0 ) then
        call UnitGroupRespawnSystem___ClearRespawnUnitIndex(UnitGroupRespawnSystem___respawnUnitHandleId[index])
    endif
    set UnitGroupRespawnSystem___respawnUnitUnit[index]=null
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=0

    call TimerStart(UnitGroupRespawnSystem___respawnUnitTimer[index], UnitGroupRespawnSystem___respawnUnitTimeout[index], false, function UnitGroupRespawnSystem___TimerFunctionRespawnUnit)
    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=false
endfunction

function StartAllUnitRespawnsNotRunning takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
        if ( IsRespawnUnitValid(i) and UnitGroupRespawnSystem___respawnUnitUnit[i] == null and UnitGroupRespawnSystem___respawnUnitReadyForRespawn[i] ) then
            call StartUnitRespawn(i)
        endif
        set i=i + 1
    endloop
endfunction

function UnitGroupRespawnSystem___AddRespawnUnitDefault takes integer index,real x,real y returns nothing
    set UnitGroupRespawnSystem___respawnUnitIsValid[index]=true
    set UnitGroupRespawnSystem___respawnUnitX[index]=x
    set UnitGroupRespawnSystem___respawnUnitY[index]=y
    set UnitGroupRespawnSystem___respawnUnitFacing[index]=GetRandomDirectionDeg()
    set UnitGroupRespawnSystem___respawnUnitUseDyingLoc[index]=false
    set UnitGroupRespawnSystem___respawnUnitOwner[index]=Player(PLAYER_NEUTRAL_AGGRESSIVE)
    set UnitGroupRespawnSystem___respawnUnitTimer[index]=CreateTimer()
    set UnitGroupRespawnSystem___respawnUnitTimeout[index]=UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(UnitGroupRespawnSystem___respawnUnitTimer[index]), 0, index)
    set UnitGroupRespawnSystem___respawnUnitEnabled[index]=true
    set UnitGroupRespawnSystem___respawnUnitGroupIndex[index]=- 1
    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=true

    loop
        set UnitGroupRespawnSystem___respawnUnitFreeIndex=UnitGroupRespawnSystem___respawnUnitFreeIndex + 1
        exitwhen ( not IsRespawnUnitValid(UnitGroupRespawnSystem___respawnUnitFreeIndex) )
    endloop

    if ( UnitGroupRespawnSystem___respawnUnitFreeIndex >= JASS_MAX_ARRAY_SIZE ) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(UnitGroupRespawnSystem___respawnUnitFreeIndex))
    endif

    if ( index >= UnitGroupRespawnSystem___respawnUnitCounter ) then
        set UnitGroupRespawnSystem___respawnUnitCounter=index + 1
    endif
endfunction

function AddRespawnUnit takes unit whichUnit returns integer
    local integer index= UnitGroupRespawnSystem___respawnUnitFreeIndex
    set UnitGroupRespawnSystem___respawnUnitType[index]=UNIT_RESPAWN_TYPE_UNIT
    set UnitGroupRespawnSystem___respawnUnitUnit[index]=whichUnit
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=GetHandleId(whichUnit)
    set UnitGroupRespawnSystem___respawnUnitUnitTypeId[index]=GetUnitTypeId(whichUnit)
    set UnitGroupRespawnSystem___respawnUnitPool[index]=null
    call UnitGroupRespawnSystem___AddRespawnUnitDefault(index , GetUnitX(whichUnit) , GetUnitY(whichUnit))
    set UnitGroupRespawnSystem___respawnUnitFacing[index]=GetUnitFacing(whichUnit)
    set UnitGroupRespawnSystem___respawnUnitOwner[index]=GetOwningPlayer(whichUnit)
    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=false

    if ( IsUnitType(whichUnit, UNIT_TYPE_HERO) ) then
        call BlzSetUnitRealField(whichUnit, UNIT_RF_DEATH_TIME, 99999999.0)
    endif


    call SaveInteger(UnitGroupRespawnSystem___respawnUnitHashTable, UnitGroupRespawnSystem___respawnUnitHandleId[index], 0, index)

    return index
endfunction

function SetRespawnUnitGroupIndex takes integer index,integer groupIndex returns nothing
    if ( IsRespawnUnitGroupValid(groupIndex) ) then
        if ( IsRespawnUnitGroupValid(UnitGroupRespawnSystem___respawnUnitGroupIndex[index]) and UnitGroupRespawnSystem___respawnUnitUnit[index] != null ) then
            call GroupRemoveUnit(UnitGroupRespawnSystem___respawnUnitGroup[UnitGroupRespawnSystem___respawnUnitGroupIndex[index]], UnitGroupRespawnSystem___respawnUnitUnit[index])
        endif
        set UnitGroupRespawnSystem___respawnUnitGroupIndex[index]=groupIndex
        if ( UnitGroupRespawnSystem___respawnUnitUnit[index] != null ) then
            call GroupAddUnit(UnitGroupRespawnSystem___respawnUnitGroup[groupIndex], UnitGroupRespawnSystem___respawnUnitUnit[index])
        endif
    endif
endfunction

function AddRespawnUnitPoolEx takes unitpool whichUnitPool,real x,real y,integer groupIndex returns integer
    local integer index= UnitGroupRespawnSystem___respawnUnitFreeIndex
    set UnitGroupRespawnSystem___respawnUnitType[index]=UNIT_RESPAWN_TYPE_UNITPOOL
    set UnitGroupRespawnSystem___respawnUnitUnit[index]=null
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=0
    set UnitGroupRespawnSystem___respawnUnitUnitTypeId[index]=0
    set UnitGroupRespawnSystem___respawnUnitPool[index]=whichUnitPool
    call UnitGroupRespawnSystem___AddRespawnUnitDefault(index , x , y)
    // Set group index before respawning.
    call SetRespawnUnitGroupIndex(index , groupIndex)
    
    call RespawnUnit(index)

    return index
endfunction

function AddRespawnUnitPool takes unitpool whichUnitPool,real x,real y returns integer
    return AddRespawnUnitPoolEx(whichUnitPool , x , y , - 1)
endfunction

function AddRespawnUnitRandomCreepEx takes integer level,real x,real y,integer groupIndex returns integer
    local integer index= UnitGroupRespawnSystem___respawnUnitFreeIndex
    set UnitGroupRespawnSystem___respawnUnitType[index]=UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL
    set UnitGroupRespawnSystem___respawnUnitUnit[index]=null
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=0
    set UnitGroupRespawnSystem___respawnUnitUnitTypeId[index]=0
    set UnitGroupRespawnSystem___respawnUnitPool[index]=null
    set UnitGroupRespawnSystem___respawnUnitRandomCreepLevel[index]=level
    call UnitGroupRespawnSystem___AddRespawnUnitDefault(index , x , y)
    // Set group index before respawning.
    call SetRespawnUnitGroupIndex(index , groupIndex)

    call RespawnUnit(index)

    return index
endfunction

function AddRespawnUnitRandomCreep takes integer level,real x,real y returns integer
    return AddRespawnUnitRandomCreepEx(level , x , y , - 1)
endfunction


function RemoveRespawnUnit takes integer index returns boolean
    //call BJDebugMsg("Remove respawn unit " + I2S(index))
    if ( IsRespawnUnitValid(index) ) then
        set UnitGroupRespawnSystem___respawnUnitIsValid[index]=false

        if ( UnitGroupRespawnSystem___respawnUnitUnit[index] != null ) then
            call UnitGroupRespawnSystem___ClearRespawnUnitIndex(GetHandleId(UnitGroupRespawnSystem___respawnUnitUnit[index]))
        endif

        set UnitGroupRespawnSystem___respawnUnitTimeout[index]=0
        set UnitGroupRespawnSystem___respawnUnitType[index]=0
        set UnitGroupRespawnSystem___respawnUnitUnit[index]=null
        set UnitGroupRespawnSystem___respawnUnitHandleId[index]=0
        set UnitGroupRespawnSystem___respawnUnitUnitTypeId[index]=0
        set UnitGroupRespawnSystem___respawnUnitPool[index]=null
        set UnitGroupRespawnSystem___respawnUnitRandomCreepLevel[index]=0
        set UnitGroupRespawnSystem___respawnUnitUseDyingLoc[index]=false

        call PauseTimer(UnitGroupRespawnSystem___respawnUnitTimer[index])
        call FlushChildHashtable(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(UnitGroupRespawnSystem___respawnUnitTimer[index]))
        call DestroyTimer(UnitGroupRespawnSystem___respawnUnitTimer[index])

        set UnitGroupRespawnSystem___respawnUnitFreeIndex=index

        if ( index == UnitGroupRespawnSystem___respawnUnitCounter - 1 ) then
            set UnitGroupRespawnSystem___respawnUnitCounter=UnitGroupRespawnSystem___respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitEnabled takes integer index,boolean enabled returns nothing
    set UnitGroupRespawnSystem___respawnUnitEnabled[index]=enabled
endfunction

function IsRespawnUnitEnabled takes integer index returns boolean
    return UnitGroupRespawnSystem___respawnUnitEnabled[index]
endfunction

function GetRespawnUnitTimer takes integer index returns timer
    return UnitGroupRespawnSystem___respawnUnitTimer[index]
endfunction

function GetRespawnUnitType takes integer index returns integer
    return UnitGroupRespawnSystem___respawnUnitType[index]
endfunction

function SetRespawnUnitTimeout takes integer index,real timeout returns nothing
    set UnitGroupRespawnSystem___respawnUnitTimeout[index]=timeout
endfunction

function GetRespawnUnitTimeout takes integer index returns real
    return UnitGroupRespawnSystem___respawnUnitTimeout[index]
endfunction

function SetRespawnUnitOwner takes integer index,player owner returns nothing
    set UnitGroupRespawnSystem___respawnUnitOwner[index]=owner
endfunction

function GetRespawnUnitOwner takes integer index returns player
    return UnitGroupRespawnSystem___respawnUnitOwner[index]
endfunction
function SetRespawnUnitFacing takes integer index,real facing returns nothing
    set UnitGroupRespawnSystem___respawnUnitFacing[index]=facing
endfunction

function GetRespawnUnitFacing takes integer index returns real
    return UnitGroupRespawnSystem___respawnUnitFacing[index]
endfunction

function SetRespawnUnitX takes integer index,real x returns nothing
    set UnitGroupRespawnSystem___respawnUnitX[index]=x
endfunction

function GetRespawnUnitX takes integer index returns real
    return UnitGroupRespawnSystem___respawnUnitX[index]
endfunction

function SetRespawnUnitY takes integer index,real y returns nothing
    set UnitGroupRespawnSystem___respawnUnitX[index]=y
endfunction

function GetRespawnUnitY takes integer index returns real
    return UnitGroupRespawnSystem___respawnUnitY[index]
endfunction

function SetRespawnUnitUseDyingLoc takes integer index,boolean use returns nothing
    set UnitGroupRespawnSystem___respawnUnitUseDyingLoc[index]=use
endfunction

function GetRespawnUnitUseDyingLoc takes integer index returns boolean
    return UnitGroupRespawnSystem___respawnUnitUseDyingLoc[index]
endfunction

function SetRespawnUnit takes integer index,unit whichUnit returns nothing
    local integer groupIndex= UnitGroupRespawnSystem___respawnUnitGroupIndex[index]
    local boolean validRespawnUnitGroup= IsRespawnUnitGroupValid(groupIndex)
    local integer handleId= GetHandleId(whichUnit)
    if ( UnitGroupRespawnSystem___respawnUnitUnit[index] != null ) then
        if ( validRespawnUnitGroup ) then
            call GroupRemoveUnit(UnitGroupRespawnSystem___respawnUnitGroup[groupIndex], UnitGroupRespawnSystem___respawnUnitUnit[index])
        endif

        call UnitGroupRespawnSystem___ClearRespawnUnitIndex(GetHandleId(UnitGroupRespawnSystem___respawnUnitUnit[index]))
    endif
    set UnitGroupRespawnSystem___respawnUnitUnit[index]=whichUnit
    set UnitGroupRespawnSystem___respawnUnitHandleId[index]=handleId
    set UnitGroupRespawnSystem___respawnUnitType[index]=GetUnitTypeId(whichUnit)
    call SaveInteger(UnitGroupRespawnSystem___respawnUnitHashTable, handleId, 0, index)
    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=false
    if ( validRespawnUnitGroup ) then
        call GroupAddUnit(UnitGroupRespawnSystem___respawnUnitGroup[groupIndex], whichUnit)
    endif
endfunction

function GetRespawnUnit takes integer index returns unit
    return UnitGroupRespawnSystem___respawnUnitUnit[index]
endfunction

function SetRespawnUnitPool takes integer index,unitpool whichUnitPool returns nothing
    set UnitGroupRespawnSystem___respawnUnitPool[index]=whichUnitPool
endfunction

function GetRespawnUnitPool takes integer index returns unitpool
    return UnitGroupRespawnSystem___respawnUnitPool[index]
endfunction

function SetRespawnUnitLevel takes integer index,integer level returns nothing
    set UnitGroupRespawnSystem___respawnUnitRandomCreepLevel[index]=level
endfunction

function GetRespawnUnitLevel takes integer index returns integer
    return UnitGroupRespawnSystem___respawnUnitRandomCreepLevel[index]
endfunction

function GetRespawnUnitGroupCounter takes nothing returns integer
    return UnitGroupRespawnSystem___respawnUnitGroupCounter
endfunction

function GetRespawnUnitGroupIndex takes integer index returns integer
    return UnitGroupRespawnSystem___respawnUnitGroupIndex[index]
endfunction

function AddRespawnUnitGroup takes nothing returns integer
    local integer index= UnitGroupRespawnSystem___respawnUnitGroupFreeIndex
    set UnitGroupRespawnSystem___respawnUnitGroupIsValid[index]=true
    set UnitGroupRespawnSystem___respawnUnitGroup[index]=CreateGroup()
    set UnitGroupRespawnSystem___respawnUnitGroupTimer[index]=CreateTimer()
    set UnitGroupRespawnSystem___respawnUnitGroupTimeout[index]=UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(UnitGroupRespawnSystem___respawnUnitGroupTimer[index]), 0, index)
    set UnitGroupRespawnSystem___respawnUnitGroupEnabled[index]=true
    set UnitGroupRespawnSystem___respawnUnitGroupItemDropEnabled[index]=UnitGroupRespawnSystemConfig_AUTO_ADDED_DROP_RANDOM_ITEMS

    loop
        set UnitGroupRespawnSystem___respawnUnitGroupFreeIndex=UnitGroupRespawnSystem___respawnUnitGroupFreeIndex + 1
        exitwhen ( not IsRespawnUnitGroupValid(UnitGroupRespawnSystem___respawnUnitGroupFreeIndex) )
    endloop

    if ( UnitGroupRespawnSystem___respawnUnitGroupFreeIndex >= JASS_MAX_ARRAY_SIZE ) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(UnitGroupRespawnSystem___respawnUnitGroupFreeIndex))
    endif

    if ( index >= UnitGroupRespawnSystem___respawnUnitGroupCounter ) then
        set UnitGroupRespawnSystem___respawnUnitGroupCounter=index + 1
    endif

    return index
endfunction


function UnitGroupRespawnSystem___FilterFunctionBelongsToSameOwnerAndHasRespawn takes nothing returns boolean
    local unit l__UnitGroupRespawnSystem___filterUnit= GetFilterUnit()
    local integer respawnUnitIndex= - 1
    if ( IsPlayerInForce(GetOwningPlayer(l__UnitGroupRespawnSystem___filterUnit), UnitGroupRespawnSystem___filterForce) ) then
        set respawnUnitIndex=(UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((l__UnitGroupRespawnSystem___filterUnit)))) // INLINED!!
        set l__UnitGroupRespawnSystem___filterUnit=null
        return IsRespawnUnitValid(respawnUnitIndex) and IsRespawnUnitGroupValid((UnitGroupRespawnSystem___respawnUnitGroupIndex[(respawnUnitIndex)])) // INLINED!!
    endif
    set l__UnitGroupRespawnSystem___filterUnit=null
    return false
endfunction

function AddRespawnUnitGroupFromUnitEx takes unit whichUnit,force whichForce,real maxDistance returns integer
    local group allNearbyUnitsFromTheSameOwner= CreateGroup()
    local unit first= null
    local integer groupIndex= - 1
    local integer index= - 1
    set UnitGroupRespawnSystem___filterForce=whichForce
    call GroupEnumUnitsInRange(allNearbyUnitsFromTheSameOwner, GetUnitX(whichUnit), GetUnitY(whichUnit), maxDistance, Filter(function UnitGroupRespawnSystem___FilterFunctionBelongsToSameOwnerAndHasRespawn))
    set first=FirstOfGroup(allNearbyUnitsFromTheSameOwner)
    call GroupClear(allNearbyUnitsFromTheSameOwner)
    call DestroyGroup(allNearbyUnitsFromTheSameOwner)
    set allNearbyUnitsFromTheSameOwner=null
    if ( first != null ) then
        set groupIndex=(UnitGroupRespawnSystem___respawnUnitGroupIndex[((UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((first)))))]) // INLINED!!
        set first=null
    else
        // add a new group for the unit since we found no neighbours with the same owner
        set groupIndex=AddRespawnUnitGroup()
    endif
    set index=AddRespawnUnit(whichUnit)
    call SetRespawnUnitGroupIndex(index , groupIndex)
    return groupIndex
endfunction

function AddRespawnUnitGroupFromUnit takes unit whichUnit returns integer
    return AddRespawnUnitGroupFromUnitEx(whichUnit , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE)
endfunction

function UnitGroupRespawnSystem___PolarProjectionX takes real x,real dist,real angle returns real
    return x + dist * Cos(angle * bj_DEGTORAD)
endfunction

function UnitGroupRespawnSystem___PolarProjectionY takes real y,real dist,real angle returns real
    return y + dist * Sin(angle * bj_DEGTORAD)
endfunction

function UnitGroupRespawnSystem___GetRandomLocInRange takes real x,real y,real range returns location
    local real dist= GetRandomReal(0.0, range)
    local real angle= GetRandomDirectionDeg()
    return Location((((x )*1.0) + (( dist )*1.0) * Cos((( angle)*1.0) * bj_DEGTORAD)), (((y )*1.0) + (( dist )*1.0) * Sin((( angle)*1.0) * bj_DEGTORAD))) // INLINED!!
endfunction

function AddRespawnUnitGroupFromUnitPool takes unitpool whichUnitPool,integer countMembers,real x,real y,real range returns integer
    local integer groupIndex= AddRespawnUnitGroup()
    local location whichLocation= null
    local integer i= 0
    loop
        exitwhen ( i >= countMembers )
        set whichLocation=UnitGroupRespawnSystem___GetRandomLocInRange(x , y , range)
        call AddRespawnUnitPoolEx(whichUnitPool , GetLocationX(whichLocation) , GetLocationY(whichLocation) , groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation=null
        set i=i + 1
    endloop
    return groupIndex
endfunction

function AddRespawnUnitGroupFromRandomCreepLevel takes integer minCreepLevel,integer maxCreepLevel,integer countMembers,real x,real y,real range returns integer
    local integer groupIndex= AddRespawnUnitGroup()
    local location whichLocation= null
    local integer i= 0
    loop
        exitwhen ( i >= countMembers )
        set whichLocation=UnitGroupRespawnSystem___GetRandomLocInRange(x , y , range)
        call AddRespawnUnitRandomCreepEx(GetRandomInt(minCreepLevel, maxCreepLevel) , GetLocationY(whichLocation) , GetLocationY(whichLocation) , groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation=null
        set i=i + 1
    endloop
    return groupIndex
endfunction

function RemoveRespawnUnitGroup takes integer index returns boolean
    if ( IsRespawnUnitValid(index) ) then
        set UnitGroupRespawnSystem___respawnUnitGroupIsValid[index]=false
        set UnitGroupRespawnSystem___respawnUnitGroupEnabled[index]=false

        if ( UnitGroupRespawnSystem___respawnUnitGroup[index] != null ) then
            call GroupClear(UnitGroupRespawnSystem___respawnUnitGroup[index])
            call DestroyGroup(UnitGroupRespawnSystem___respawnUnitGroup[index])
            set UnitGroupRespawnSystem___respawnUnitGroup[index]=null
        endif

        call PauseTimer(UnitGroupRespawnSystem___respawnUnitGroupTimer[index])
        call FlushChildHashtable(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(UnitGroupRespawnSystem___respawnUnitGroupTimer[index]))
        call DestroyTimer(UnitGroupRespawnSystem___respawnUnitGroupTimer[index])

        set UnitGroupRespawnSystem___respawnUnitFreeIndex=index

        if ( index == UnitGroupRespawnSystem___respawnUnitCounter - 1 ) then
            set UnitGroupRespawnSystem___respawnUnitCounter=UnitGroupRespawnSystem___respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitGroupTimeout takes integer index,real timeout returns nothing
    set UnitGroupRespawnSystem___respawnUnitGroupTimeout[index]=timeout
endfunction

function GetRespawnUnitGroupTimeout takes integer index returns real
    return UnitGroupRespawnSystem___respawnUnitGroupTimeout[index]
endfunction

function SetRespawnUnitGroupEnabled takes integer index,boolean enabled returns nothing
    set UnitGroupRespawnSystem___respawnUnitGroupEnabled[index]=enabled
endfunction

function IsRespawnUnitGroupEnabled takes integer index returns boolean
    return UnitGroupRespawnSystem___respawnUnitGroupEnabled[index]
endfunction

function SetRespawnUnitGroupItemDropEnabled takes integer index,boolean enabled returns nothing
    set UnitGroupRespawnSystem___respawnUnitGroupItemDropEnabled[index]=enabled
endfunction

function GetRespawnUnitGroupItemDropEnabled takes integer index returns boolean
    return UnitGroupRespawnSystem___respawnUnitGroupItemDropEnabled[index]
endfunction

function GetRespawnUnitGroupUnits takes integer index returns group
    return UnitGroupRespawnSystem___respawnUnitGroup[index]
endfunction

function RespawnUnitGroup takes integer index returns boolean
    local integer i= 0
    //call BJDebugMsg("Respawn unit group " + I2S(index))
    if ( not IsRespawnUnitGroupValid(index) ) then
        return false
    endif
    // We do not know the members anymore since we have removed them from the group. Hence, we need to find all matching respawns.
    // TODO Store the list of indices in the group?
    set i=0
    loop
        exitwhen ( i == (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
        if ( IsRespawnUnitValid(i) and (UnitGroupRespawnSystem___respawnUnitGroupIndex[(i)]) == index ) then // INLINED!!
            //call BJDebugMsg("Respawn unit with index " + I2S(i) + " from group " + I2S(index))
            call RespawnUnit(i)
        endif
        set i=i + 1
    endloop

    return true
endfunction

function UnitGroupRespawnSystem___TimerFunctionRespawnUnitGroup takes nothing returns nothing
    local integer index= LoadInteger(UnitGroupRespawnSystem___respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnitGroup(index)
endfunction

function StartUnitGroupRespawn takes integer index returns nothing
    local unit member= null
    local integer memberIndex= - 1
    local integer i= 0
    loop
        exitwhen ( i == BlzGroupGetSize(UnitGroupRespawnSystem___respawnUnitGroup[index]) )
        set member=BlzGroupUnitAt(UnitGroupRespawnSystem___respawnUnitGroup[index], i)
        set memberIndex=(UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((member)))) // INLINED!!
        set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[memberIndex]=false // makes sure that StartAllUnitRespawnsNotRunning does not start a duplicated respawn.
        //call BJDebugMsg("Making group member " + I2S(memberIndex) + " not ready for respawn anymore!")
        set member=null
        set i=i + 1
    endloop
    
    // start call backs
    loop
        exitwhen ( i == BlzGroupGetSize(UnitGroupRespawnSystem___respawnUnitGroup[index]) )
        set member=BlzGroupUnitAt(UnitGroupRespawnSystem___respawnUnitGroup[index], i)
        set memberIndex=(UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((member)))) // INLINED!!
        call UnitGroupRespawnSystem___EvaluateAndExecuteCallbackRespawnStartsTriggers(memberIndex)
        set member=null
        set i=i + 1
    endloop

    // Cleanup since we do not know how long the unit will decay etc.
    set i=0
    loop
        exitwhen ( i >= BlzGroupGetSize(UnitGroupRespawnSystem___respawnUnitGroup[index]) )
        set member=BlzGroupUnitAt(UnitGroupRespawnSystem___respawnUnitGroup[index], i)
        set memberIndex=(UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((member)))) // INLINED!!

        if ( not IsUnitType(member, UNIT_TYPE_HERO) ) then
            if ( UnitGroupRespawnSystem___respawnUnitHandleId[memberIndex] != 0 ) then
                call UnitGroupRespawnSystem___ClearRespawnUnitIndex(UnitGroupRespawnSystem___respawnUnitHandleId[memberIndex])
            endif
            set UnitGroupRespawnSystem___respawnUnitUnit[memberIndex]=null
            set UnitGroupRespawnSystem___respawnUnitHandleId[memberIndex]=0
            call GroupRemoveUnit(UnitGroupRespawnSystem___respawnUnitGroup[index], member) // only remove non-heroes
        else
            set i=i + 1
        endif

        set member=null
    endloop
    
    //call BJDebugMsg("Starting respawn timer for group " + I2S(index))

    call TimerStart(UnitGroupRespawnSystem___respawnUnitGroupTimer[index], UnitGroupRespawnSystem___respawnUnitGroupTimeout[index], false, function UnitGroupRespawnSystem___TimerFunctionRespawnUnitGroup)
endfunction

function UnitGroupRespawnSystem___TriggerConditionRespawnUnit takes nothing returns boolean
    local integer index= (UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((GetTriggerUnit())))) // INLINED!!
    return IsRespawnUnitValid(index) and (UnitGroupRespawnSystem___respawnUnitEnabled[(index)]) // INLINED!!
endfunction

function UnitGroupRespawnSystem___IsUnitGroupReadyForRespawnEnum takes nothing returns nothing
    local integer index= (UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((GetEnumUnit())))) // INLINED!!
    //call BJDebugMsg("Checking member: " + I2S(index))
    if ( not UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index] ) then
        set bj_isUnitGroupDeadResult=false
    endif
endfunction

function UnitGroupRespawnSystem___IsUnitGroupReadyForRespawn takes group g returns boolean
    set bj_isUnitGroupDeadResult=true
    call ForGroup(g, function UnitGroupRespawnSystem___IsUnitGroupReadyForRespawnEnum)
    //call BJDebugMsg("Result")
    return bj_isUnitGroupDeadResult
endfunction

function UnitGroupRespawnSystem___TriggerActionRespawnUnit takes nothing returns nothing
    local unit triggerUnit= GetTriggerUnit()
    local integer index= (UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((triggerUnit)))) // INLINED!!
    local integer groupIndex= (UnitGroupRespawnSystem___respawnUnitGroupIndex[(index)]) // INLINED!!

    if ( (UnitGroupRespawnSystem___respawnUnitUseDyingLoc[(index)]) ) then // INLINED!!
        set UnitGroupRespawnSystem___respawnUnitFacing[(index )]=(( GetUnitFacing(triggerUnit))*1.0) // INLINED!!
        set UnitGroupRespawnSystem___respawnUnitX[(index )]=(( GetUnitX(triggerUnit))*1.0) // INLINED!!
        set UnitGroupRespawnSystem___respawnUnitX[(index )]=(( GetUnitY(triggerUnit))*1.0) // INLINED!!
    endif

    set UnitGroupRespawnSystem___respawnUnitReadyForRespawn[index]=true

    if ( IsRespawnUnitGroupValid(groupIndex) and (UnitGroupRespawnSystem___respawnUnitGroupEnabled[(groupIndex)]) ) then // INLINED!!
        if ( UnitGroupRespawnSystem___IsUnitGroupReadyForRespawn((UnitGroupRespawnSystem___respawnUnitGroup[(groupIndex)])) ) then // INLINED!!
            call UnitGroupRespawnSystemConfig_DropItemForGroup(groupIndex , triggerUnit , (UnitGroupRespawnSystem___respawnUnitGroup[(groupIndex)]) , (UnitGroupRespawnSystem___respawnUnitGroupItemDropEnabled[(groupIndex)])) // INLINED!!
            //call BJDebugMsg("Start group unit respawn for index " + I2S(groupIndex) + " with " + I2S(BlzGroupGetSize(GetRespawnUnitGroupUnits(groupIndex))) + " members")
            call StartUnitGroupRespawn(groupIndex)
        endif
    else
        //call BJDebugMsg("Start unit respawn for index " + I2S(index))
        call StartUnitRespawn(index)
    endif
    set triggerUnit=null
endfunction

function AddRespawnUnitGroupFromUnitStartEx takes unit whichUnit,force whichForce,real maxDistance,boolean autoAddedGroups returns nothing
    if ( not IsRespawnUnitValid((UnitGroupRespawnSystem___GetRespawnUnitIndexByHandleID(GetHandleId((whichUnit))))) ) then // INLINED!!
        if ( autoAddedGroups ) then
            call AddRespawnUnitGroupFromUnitEx(whichUnit , whichForce , maxDistance)
        else
            call AddRespawnUnit(whichUnit)
        endif
    endif
endfunction

function AddRespawnUnitGroupFromUnitStart takes unit whichUnit returns nothing
    call AddRespawnUnitGroupFromUnitStartEx(whichUnit , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUPS)
endfunction

function UnitGroupRespawnSystem___AddRespawnUnitGroupFromEnumUnit takes nothing returns nothing
    call AddRespawnUnitGroupFromUnitStartEx((GetEnumUnit()) , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUPS) // INLINED!!
endfunction


function UnitGroupRespawnSystem___AddAllPreplacedCreeps takes nothing returns nothing
    local timer expiredTimer= GetExpiredTimer()
    local group allCreeps= CreateGroup()

    call GroupEnumUnitsInRect((allCreeps), GetPlayableMapRect(), Filter(function UnitGroupRespawnSystemConfig___IsUnitLivingNonStructure)) // INLINED!!
    call ForGroup(allCreeps, function UnitGroupRespawnSystem___AddRespawnUnitGroupFromEnumUnit)
    call GroupClear(allCreeps)
    call DestroyGroup(allCreeps)
    set allCreeps=null
    
    call PauseTimer(expiredTimer)
    call DestroyTimer(expiredTimer)
    set expiredTimer=null
endfunction


function UnitGroupRespawnSystem___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(UnitGroupRespawnSystem___unitDeathOrCharmOrRescueTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(UnitGroupRespawnSystem___unitDeathOrCharmOrRescueTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(UnitGroupRespawnSystem___unitDeathOrCharmOrRescueTrigger, Condition(function UnitGroupRespawnSystem___TriggerConditionRespawnUnit))
    call TriggerAddAction(UnitGroupRespawnSystem___unitDeathOrCharmOrRescueTrigger, function UnitGroupRespawnSystem___TriggerActionRespawnUnit)


    // waiting makes sure that all units are already placed on the map
    call TimerStart(CreateTimer(), 0.0, false, function UnitGroupRespawnSystem___AddAllPreplacedCreeps)


endfunction

function UnitGroupRespawnSystem___RemoveUnitCleanup takes unit whichUnit returns nothing
    local integer handleID= GetHandleId(whichUnit)
    call UnitGroupRespawnSystem___ClearRespawnUnitIndex(handleID)
endfunction

//processed hook: hook RemoveUnit UnitGroupRespawnSystem___RemoveUnitCleanup



//library UnitGroupRespawnSystem ends
//===========================================================================
// 
// Unit Group Respawn System 1.3
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
    set udg_PlayerCreepHeroes=Player(6)
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades Unit Group Respawn System Config
//***************************************************************************
//*  Barades Unit Group Respawn System

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

    set gg_unit_Hpal_0000=BlzCreateUnitWithSkin(p, 'Hpal', - 264.7, - 46.0, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0000, 100, false)
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'ANch')
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'ofro', 0)
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'ratf', 1)
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'ratf', 2)
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'ratf', 3)
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'ratf', 4)
    call UnitAddItemToSlotById(gg_unit_Hpal_0000, 'nspi', 5)
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0029=BlzCreateUnitWithSkin(p, 'Hpal', 210.8, - 55.6, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0029, 100, false)
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'ANch')
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'ofro', 0)
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'ratf', 1)
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'ratf', 2)
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'ratf', 3)
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'ratf', 4)
    call UnitAddItemToSlotById(gg_unit_Hpal_0029, 'nspi', 5)
endfunction

//===========================================================================
function CreateUnitsForPlayer4 takes nothing returns nothing
    local player p= Player(4)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ogru', 2886.8, - 1442.3, 325.392, 'ogru')
    set u=BlzCreateUnitWithSkin(p, 'ogru', 2774.5, - 1379.4, 228.687, 'ogru')
    set u=BlzCreateUnitWithSkin(p, 'ohun', 2904.1, - 1334.7, 235.422, 'ohun')
endfunction

//===========================================================================
function CreateUnitsForPlayer5 takes nothing returns nothing
    local player p= Player(5)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 2934.4, - 3329.1, 350.310, 'hfoo')
    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 3035.6, - 3220.2, 135.488, 'hfoo')
    set u=BlzCreateUnitWithSkin(p, 'hkni', - 3050.2, - 3341.9, 153.121, 'hkni')
endfunction

//===========================================================================
function CreateUnitsForPlayer6 takes nothing returns nothing
    local player p= Player(6)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Nmsr_0038=BlzCreateUnitWithSkin(p, 'Nmsr', 2.5, - 2706.7, 220.590, 'Nmsr')
    call SetHeroLevel(gg_unit_Nmsr_0038, 5, false)
    call SelectHeroSkill(gg_unit_Nmsr_0038, 'ANrf')
    call SelectHeroSkill(gg_unit_Nmsr_0038, 'ANrf')
    call SelectHeroSkill(gg_unit_Nmsr_0038, 'ANrf')
endfunction

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nmrm', 32.9, - 2483.8, 63.393, 'nmrm')
    set u=BlzCreateUnitWithSkin(p, 'nmrr', - 56.1, - 2585.3, 264.207, 'nmrr')
    set u=BlzCreateUnitWithSkin(p, 'nmrr', 103.3, - 2596.9, 153.824, 'nmrr')
    set u=BlzCreateUnitWithSkin(p, 'ngnv', - 2741.4, 2480.7, 187.817, 'ngnv')
    set u=BlzCreateUnitWithSkin(p, 'ngnw', - 2591.8, 2671.6, 57.988, 'ngnw')
    set u=BlzCreateUnitWithSkin(p, 'ngnw', - 2890.6, 2639.7, 259.340, 'ngnw')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ntav', - 256.0, 320.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'ngme', 128.0, 320.0, 270.000, 'ngme')
endfunction

//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nfro', 2840.8, 2643.6, 192.717, 'nfro')
    set u=BlzCreateUnitWithSkin(p, 'nshe', 2594.8, 2119.0, 325.381, 'nshe')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
    call CreateUnitsForPlayer4()
    call CreateUnitsForPlayer5()
    call CreateUnitsForPlayer6()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateNeutralHostile()
    call CreateNeutralPassive()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_Unit_Level_Respawn=Rect(- 544.0, 1024.0, - 512.0, 1056.0)
    set gg_rct_Unit_Pool_Respawn=Rect(- 2720.0, - 160.0, - 2688.0, - 128.0)
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
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call SetPlayerAllianceStateBJ(udg_PlayerCreepHeroes, Player(PLAYER_NEUTRAL_AGGRESSIVE), bj_ALLIANCE_ALLIED_ADVUNITS)
    call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_PlayerCreepHeroes, bj_ALLIANCE_ALLIED_ADVUNITS)
    call SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, udg_PlayerCreepHeroes)
    call SetPlayerColorBJ(udg_PlayerCreepHeroes, ConvertPlayerColor(24), true)
    call IssueImmediateOrderBJ(gg_unit_Nmsr_0038, "stop")
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func002A takes nothing returns nothing
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call SetPlayerMaxHeroesAllowed(1, GetEnumPlayer())
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func002A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_014")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_015")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_016")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_017")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_023")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_024")
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0000, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0029, Player(1))
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Unit Respawn
//===========================================================================
function Trig_Unit_Respawn_Actions takes nothing returns nothing
    local location tmpLocation= GetUnitLoc((UnitGroupRespawnSystem___callbackUnit)) // INLINED!!
    call PingMinimapLocForForce(GetPlayersAll(), tmpLocation, 2.00)
    call DestroyEffect(AddSpecialEffectLocBJ(tmpLocation, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl"))
    call RemoveLocation(tmpLocation)
    set tmpLocation=null
endfunction

//===========================================================================
function InitTrig_Unit_Respawn takes nothing returns nothing
    set gg_trg_Unit_Respawn=CreateTrigger()
    call TriggerAddAction(gg_trg_Unit_Respawn, function Trig_Unit_Respawn_Actions)
endfunction

//===========================================================================
// Trigger: Unit Respawn Starts
//===========================================================================
function Trig_Unit_Respawn_Starts_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( "Starting respawn for unit " + ( GetUnitName((UnitGroupRespawnSystem___callbackUnit)) + "!" ) )) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Unit_Respawn_Starts takes nothing returns nothing
    set gg_trg_Unit_Respawn_Starts=CreateTrigger()
    call TriggerAddAction(gg_trg_Unit_Respawn_Starts, function Trig_Unit_Respawn_Starts_Actions)
endfunction

//===========================================================================
// Trigger: Init Respawn Callbacks
//===========================================================================
function Trig_Init_Respawn_Callbacks_Actions takes nothing returns nothing
    call TriggerRegisterUnitRespawnEvent(gg_trg_Unit_Respawn)
    call TriggerRegisterUnitRespawnStartsEvent(gg_trg_Unit_Respawn_Starts)
endfunction

//===========================================================================
function InitTrig_Init_Respawn_Callbacks takes nothing returns nothing
    set gg_trg_Init_Respawn_Callbacks=CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Respawn_Callbacks, function Trig_Init_Respawn_Callbacks_Actions)
endfunction

//===========================================================================
// Trigger: Init Respawning Units Extended
//===========================================================================
function Trig_Init_Respawning_Units_Extended_Func020Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Init_Respawning_Units_Extended_Func020A takes nothing returns nothing
    if ( Trig_Init_Respawning_Units_Extended_Func020Func001C() ) then
        set UnitGroupRespawnSystem___respawnUnitUseDyingLoc[(AddRespawnUnit(GetEnumUnit()) )]=( true) // INLINED!!
    else
        call DoNothing()
    endif
endfunction

function Trig_Init_Respawning_Units_Extended_Func023Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Init_Respawning_Units_Extended_Func023A takes nothing returns nothing
    if ( Trig_Init_Respawning_Units_Extended_Func023Func001C() ) then
call AddRespawnUnitGroupFromUnitEx((GetEnumUnit()) , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE) // INLINED!!
    else
        call DoNothing()
    endif
endfunction

function Trig_Init_Respawning_Units_Extended_Func025Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_Init_Respawning_Units_Extended_Func025A takes nothing returns nothing
    if ( Trig_Init_Respawning_Units_Extended_Func025Func001C() ) then
call AddRespawnUnitGroupFromUnitEx((GetEnumUnit()) , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS , UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE) // INLINED!!
    else
        call DoNothing()
    endif
endfunction

function Trig_Init_Respawning_Units_Extended_Actions takes nothing returns nothing
    local unitpool whichUnitPool= CreateUnitPool()
    local real x= 0.0
    local real y= 0.0
    // Unit Pool
    set udg_UnitType='ndtp'
    call UnitPoolAddUnitType(whichUnitPool, udg_UnitType, 0.5)
    set udg_UnitType='ndtt'
    call UnitPoolAddUnitType(whichUnitPool, udg_UnitType, 0.5)
    // Unit Group Respawn from Unit Pool
    set x=GetRectCenterX(gg_rct_Unit_Pool_Respawn)
    set y=GetRectCenterY(gg_rct_Unit_Pool_Respawn)
    call AddRespawnUnitGroupFromUnitPool(whichUnitPool , 3 , x , y , 50.0)
    // Unit Group Respawn from Random Creep Level
    set x=GetRectCenterX(gg_rct_Unit_Level_Respawn)
    set y=GetRectCenterY(gg_rct_Unit_Level_Respawn)
    call AddRespawnUnitGroupFromRandomCreepLevel(3 , 8 , 3 , x , y , 50.0)
    // Unit Respawn from separate units from another player (critters)
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_PASSIVE)), function Trig_Init_Respawning_Units_Extended_Func020A)
    // Unit Group Respawn from another player
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(4)), function Trig_Init_Respawning_Units_Extended_Func023A)
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(5)), function Trig_Init_Respawning_Units_Extended_Func025A)
endfunction

//===========================================================================
function InitTrig_Init_Respawning_Units_Extended takes nothing returns nothing
    set gg_trg_Init_Respawning_Units_Extended=CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Respawning_Units_Extended, function Trig_Init_Respawning_Units_Extended_Actions)
endfunction

//===========================================================================
// Trigger: Chat Command Respawn All
//===========================================================================
function Trig_Chat_Command_Respawn_All_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_018")
    call RespawnAllUnits()
endfunction

//===========================================================================
function InitTrig_Chat_Command_Respawn_All takes nothing returns nothing
    set gg_trg_Chat_Command_Respawn_All=CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Chat_Command_Respawn_All, Player(0))
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Chat_Command_Respawn_All, Player(1))
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Respawn_All, Player(0), "-respawn", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Respawn_All, Player(1), "-respawn", true)
    call TriggerAddAction(gg_trg_Chat_Command_Respawn_All, function Trig_Chat_Command_Respawn_All_Actions)
endfunction

//===========================================================================
// Trigger: Chat Command Ping All
//===========================================================================
function Trig_Chat_Command_Ping_All_Actions takes nothing returns nothing
    local boolean array pingedGroup
    local boolean ping= false
    local location tmpLocation= null
    local integer groupIndex= - 1
    local integer i= 0
    call DisplayTextToForce(GetPlayersAll(), "Total respawning units: " + I2S((UnitGroupRespawnSystem___respawnUnitCounter))) // INLINED!!
    call DisplayTextToForce(GetPlayersAll(), "Total respawning unit groups: " + I2S((UnitGroupRespawnSystem___respawnUnitGroupCounter))) // INLINED!!
    loop
    exitwhen ( i == (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
    set ping=false
    if ( IsRespawnUnitValid(i) ) then
    set groupIndex=(UnitGroupRespawnSystem___respawnUnitGroupIndex[(i)]) // INLINED!!
    if ( IsRespawnUnitGroupValid(groupIndex) ) then
    if ( not pingedGroup[groupIndex] ) then
    set pingedGroup[groupIndex]=true
    set ping=true
    call BJDebugMsg("Pinging group " + I2S(groupIndex))
    endif
    else
    call BJDebugMsg("Pinging standalone respawn " + I2S(i))
    set ping=true
    endif
    if ( ping ) then
    call BJDebugMsg("Pinging unit " + GetUnitName((UnitGroupRespawnSystem___respawnUnitUnit[(i)]))) // INLINED!!
    set tmpLocation=Location((UnitGroupRespawnSystem___respawnUnitX[(i)]), (UnitGroupRespawnSystem___respawnUnitY[(i)])) // INLINED!!
    call PingMinimapLocForForce(GetPlayersAll(), tmpLocation, 6.00)
    call RemoveLocation(tmpLocation)
    set tmpLocation=null
    endif
    endif
    set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Chat_Command_Ping_All takes nothing returns nothing
    set gg_trg_Chat_Command_Ping_All=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_All, Player(0), "-ping", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_All, Player(1), "-ping", true)
    call TriggerAddAction(gg_trg_Chat_Command_Ping_All, function Trig_Chat_Command_Ping_All_Actions)
endfunction

//===========================================================================
// Trigger: Chat Command Ping Extra
//===========================================================================
function Trig_Chat_Command_Ping_Extra_Actions takes nothing returns nothing
    local boolean array pingedGroup
    local boolean ping= false
    local location tmpLocation= null
    local integer groupIndex= - 1
    local integer i= 0
    call DisplayTextToForce(GetPlayersAll(), "Total respawning units: " + I2S((UnitGroupRespawnSystem___respawnUnitCounter))) // INLINED!!
    call DisplayTextToForce(GetPlayersAll(), "Total respawning unit groups: " + I2S((UnitGroupRespawnSystem___respawnUnitGroupCounter))) // INLINED!!
    loop
    exitwhen ( i == (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
    set ping=false
    if ( IsRespawnUnitValid(i) and (UnitGroupRespawnSystem___respawnUnitType[(i)]) != UNIT_RESPAWN_TYPE_UNIT ) then // INLINED!!
    set groupIndex=(UnitGroupRespawnSystem___respawnUnitGroupIndex[(i)]) // INLINED!!
    if ( IsRespawnUnitGroupValid(groupIndex) ) then
    if ( not pingedGroup[groupIndex] ) then
    set pingedGroup[groupIndex]=true
    set ping=true
    call BJDebugMsg("Pinging group " + I2S(groupIndex))
    endif
    else
    call BJDebugMsg("Pinging standalone respawn " + I2S(i))
    set ping=true
    endif
    if ( ping ) then
    call BJDebugMsg("Pinging unit " + GetUnitName((UnitGroupRespawnSystem___respawnUnitUnit[(i)]))) // INLINED!!
    set tmpLocation=Location((UnitGroupRespawnSystem___respawnUnitX[(i)]), (UnitGroupRespawnSystem___respawnUnitY[(i)])) // INLINED!!
    call PingMinimapLocForForce(GetPlayersAll(), tmpLocation, 6.00)
    call RemoveLocation(tmpLocation)
    set tmpLocation=null
    endif
    endif
    set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Chat_Command_Ping_Extra takes nothing returns nothing
    set gg_trg_Chat_Command_Ping_Extra=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_Extra, Player(0), "-pingextra", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_Extra, Player(1), "-pingextra", true)
    call TriggerAddAction(gg_trg_Chat_Command_Ping_Extra, function Trig_Chat_Command_Ping_Extra_Actions)
endfunction

//===========================================================================
// Trigger: Chat Command Ping Units
//===========================================================================
function Trig_Chat_Command_Ping_Units_Actions takes nothing returns nothing
    local boolean array pingedGroup
    local boolean ping= false
    local location tmpLocation= null
    local integer groupIndex= - 1
    local integer i= 0
    call DisplayTextToForce(GetPlayersAll(), "Total respawning units: " + I2S((UnitGroupRespawnSystem___respawnUnitCounter))) // INLINED!!
    loop
    exitwhen ( i == (UnitGroupRespawnSystem___respawnUnitCounter) ) // INLINED!!
    set ping=true
    if ( IsRespawnUnitValid(i) ) then
    set groupIndex=(UnitGroupRespawnSystem___respawnUnitGroupIndex[(i)]) // INLINED!!
    if ( ping ) then
    call BJDebugMsg("Pinging unit " + GetUnitName((UnitGroupRespawnSystem___respawnUnitUnit[(i)])) + " with index " + I2S(i) + " belonging to group " + I2S(groupIndex)) // INLINED!!
    set tmpLocation=Location((UnitGroupRespawnSystem___respawnUnitX[(i)]), (UnitGroupRespawnSystem___respawnUnitY[(i)])) // INLINED!!
    call PingMinimapLocForForce(GetPlayersAll(), tmpLocation, 6.00)
    call RemoveLocation(tmpLocation)
    set tmpLocation=null
    endif
    endif
    set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_Chat_Command_Ping_Units takes nothing returns nothing
    set gg_trg_Chat_Command_Ping_Units=CreateTrigger()
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_Units, Player(0), "-pingunits", true)
    call TriggerRegisterPlayerChatEvent(gg_trg_Chat_Command_Ping_Units, Player(1), "-pingunits", true)
    call TriggerAddAction(gg_trg_Chat_Command_Ping_Units, function Trig_Chat_Command_Ping_Units_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Unit_Respawn()
    call InitTrig_Unit_Respawn_Starts()
    call InitTrig_Init_Respawn_Callbacks()
    call InitTrig_Init_Respawning_Units_Extended()
    call InitTrig_Chat_Command_Respawn_All()
    call InitTrig_Chat_Command_Ping_All()
    call InitTrig_Chat_Command_Ping_Extra()
    call InitTrig_Chat_Command_Ping_Units()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
    call ConditionalTriggerExecute(gg_trg_Init_Respawn_Callbacks)
    call ConditionalTriggerExecute(gg_trg_Init_Respawning_Units_Extended)
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

    // Player 4
    call SetPlayerStartLocation(Player(4), 2)
    call ForcePlayerStartLocation(Player(4), 2)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_COMPUTER)

    // Player 5
    call SetPlayerStartLocation(Player(5), 3)
    call ForcePlayerStartLocation(Player(5), 3)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_RESCUABLE)
    call SetPlayerAlliance(Player(5), Player(0), ALLIANCE_RESCUABLE, true)
    call SetPlayerAlliance(Player(5), Player(1), ALLIANCE_RESCUABLE, true)

    // Player 6
    call SetPlayerStartLocation(Player(6), 4)
    call ForcePlayerStartLocation(Player(6), 4)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_COMPUTER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_020
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

    // Force: TRIGSTR_021
    call SetPlayerTeam(Player(4), 1)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)

    // Force: TRIGSTR_022
    call SetPlayerTeam(Player(5), 2)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)

    // Force: TRIGSTR_026
    call SetPlayerTeam(Player(6), 3)
    call SetPlayerState(Player(6), PLAYER_STATE_ALLIED_VICTORY, 1)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(2, 3)
    call SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(2, 3)
    call SetEnemyStartLocPrio(2, 0, 0, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(2, 1, 1, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(4, 5)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(4, 5)
    call SetEnemyStartLocPrio(4, 0, 0, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 1, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 2, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 3, 3, MAP_LOC_PRIO_LOW)
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
    call CreateRegions()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs67182796")
call ExecuteFunc("UnitGroupRespawnSystem___Init")

    set udg_PlayerCreepHeroes=Player(6) // INLINED!!
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_001")
    call SetMapDescription("TRIGSTR_003")
    call SetPlayers(5)
    call SetTeams(5)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 256.0, - 64.0)
    call DefineStartLocation(1, 192.0, - 64.0)
    call DefineStartLocation(2, 2880.0, - 1408.0)
    call DefineStartLocation(3, - 3008.0, - 3264.0)
    call DefineStartLocation(4, 64.0, - 2624.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype15_UnitGroupRespawnSystem___RemoveUnitCleanup takes nothing returns boolean
    call UnitGroupRespawnSystem___RemoveUnitCleanup(f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs67182796 takes nothing returns nothing
    set st___prototype15[1]=CreateTrigger()
    call TriggerAddAction(st___prototype15[1],function sa___prototype15_UnitGroupRespawnSystem___RemoveUnitCleanup)
    call TriggerAddCondition(st___prototype15[1],Condition(function sa___prototype15_UnitGroupRespawnSystem___RemoveUnitCleanup))

call ExecuteFunc("s__UnitGroupRespawnSystemConfig___S_UnitGroupRespawnSystemConfig___Init__onInit")

endfunction

