library UnitGroupRespawnSystem initializer Init requires UnitGroupRespawnSystemConfig
// Baradé's Unit Group Respawn System 1.2
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

globals
    constant integer UNIT_RESPAWN_TYPE_UNIT = 0
    constant integer UNIT_RESPAWN_TYPE_UNITPOOL = 1
    constant integer UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL = 2

    private integer respawnUnitCounter = 0
    private integer respawnUnitFreeIndex = 1
    private boolean array respawnUnitIsValid
    private integer array respawnUnitType
    private unit array respawnUnitUnit
    private integer array respawnUnitHandleId
    private integer array respawnUnitUnitTypeId
    private unitpool array respawnUnitPool
    private integer array respawnUnitRandomCreepLevel
    private player array respawnUnitOwner
    private real array respawnUnitFacing
    private real array respawnUnitX
    private real array respawnUnitY
    private boolean array respawnUnitUseDyingLoc
    private timer array respawnUnitTimer
    private real array respawnUnitTimeout
    private boolean array respawnUnitEnabled
    private integer array respawnUnitGroupIndex
    private boolean array respawnUnitReadyForRespawn

    private integer callbackRespawnTriggersCounter = 0
    private trigger array callbackRespawnTriggers

    private integer callbackRespawnStartsTriggersCounter = 0
    private trigger array callbackRespawnStartsTriggers

    private unit callbackUnit = null
    private integer callbackIndex = -1

    private integer respawnUnitGroupCounter = 0
    private integer respawnUnitGroupFreeIndex = 1
    private boolean array respawnUnitGroupIsValid
    private group array respawnUnitGroup
    private timer array respawnUnitGroupTimer
    private real array respawnUnitGroupTimeout
    private boolean array respawnUnitGroupEnabled
    private boolean array respawnUnitGroupItemDropEnabled

    private trigger unitDeathOrCharmOrRescueTrigger = CreateTrigger()
    private hashtable respawnUnitHashTable = InitHashtable()

    private unit filterUnit = null
endglobals

function GetRespawningUnit takes nothing returns unit
    return callbackUnit
endfunction

function GetRespawningUnitIndex takes nothing returns integer
    return callbackIndex
endfunction

function TriggerRegisterUnitRespawnEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnTriggersCounter
    set callbackRespawnTriggers[index] = whichTrigger
    set callbackRespawnTriggersCounter = callbackRespawnTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnTriggersCounter)
        if (IsTriggerEnabled(callbackRespawnTriggers[i])) then
            set callbackUnit = respawnUnitUnit[index]
            set callbackIndex = index
            call ConditionalTriggerExecute(callbackRespawnTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function TriggerRegisterUnitRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnStartsTriggersCounter
    set callbackRespawnStartsTriggers[index] = whichTrigger
    set callbackRespawnStartsTriggersCounter = callbackRespawnStartsTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnStartsTriggersCounter)
        if (IsTriggerEnabled(callbackRespawnStartsTriggers[i])) then
            set callbackUnit = respawnUnitUnit[index]
            set callbackIndex = index
            call ConditionalTriggerExecute(callbackRespawnStartsTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function ClearRespawnUnitIndex takes integer handleID returns nothing
    if (HaveSavedInteger(respawnUnitHashTable, handleID, 0)) then
        call FlushChildHashtable(respawnUnitHashTable, handleID)
    endif
endfunction

private function GetRespawnUnitIndexByHandleID takes integer handleID returns integer
    if (HaveSavedInteger(respawnUnitHashTable, handleID, 0)) then
        return LoadInteger(respawnUnitHashTable, handleID, 0)
    endif

    return -1
endfunction

function GetUnitRespawnUnitIndex takes unit whichUnit returns integer
    return GetRespawnUnitIndexByHandleID(GetHandleId(whichUnit))
endfunction

function GetRespawnUnitCounter takes nothing returns integer
    return respawnUnitCounter
endfunction

function IsRespawnUnitValid takes integer index returns boolean
    return index > 0 and respawnUnitIsValid[index]
endfunction

function IsRespawnUnitGroupValid takes integer index returns boolean
    return index > 0 and respawnUnitGroupIsValid[index]
endfunction

function RespawnUnit takes integer index returns boolean
    local boolean add = false
    local integer groupIndex = respawnUnitGroupIndex[index]
    if (not IsRespawnUnitValid(index)) then
        return false
    endif
    if (respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNIT) then
        if (respawnUnitUnit[index] != null and IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
            call ReviveHero(respawnUnitUnit[index], respawnUnitX[index], respawnUnitY[index], UnitGroupRespawnSystemConfig_HERO_RESPAWN_DO_EYECANDY)
        else
            set respawnUnitUnit[index] = CreateUnit(respawnUnitOwner[index], respawnUnitUnitTypeId[index], respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
            set add = true
        endif
    elseif (respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNITPOOL) then
        set respawnUnitUnit[index] = PlaceRandomUnit(respawnUnitPool[index], respawnUnitOwner[index], respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
        set add = true
    elseif (respawnUnitType[index] == UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL) then
        set respawnUnitUnit[index] = CreateUnit(respawnUnitOwner[index], ChooseRandomCreep(respawnUnitRandomCreepLevel[index]), respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
        set add = true
    endif
    set respawnUnitReadyForRespawn[index] = false
    set respawnUnitHandleId[index] = GetHandleId(respawnUnitUnit[index])
    call SaveInteger(respawnUnitHashTable, respawnUnitHandleId[index], 0, index)
    
static if (UnitGroupRespawnSystemConfig_SET_MAX_DEATH_TIME_TO_UNITS) then
    if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
        call BlzSetUnitRealField(respawnUnitUnit[index], UNIT_RF_DEATH_TIME, 99999999.0)
    endif
endif

    if (add and IsRespawnUnitGroupValid(groupIndex)) then
        //call BJDebugMsg("Adding back unit " + GetUnitName(respawnUnitUnit[index]) + " with index " + I2S(index) + " to group " + I2S(groupIndex))
        call GroupAddUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
    endif

    call EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllUnits takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and respawnUnitUnit[i] == null) then
            call RespawnUnit(i)
        endif
        set i = i + 1
    endloop
endfunction

function PreventUnitRespawn takes unit whichUnit returns nothing
    local integer index = GetUnitRespawnUnitIndex(whichUnit)
    if (IsRespawnUnitValid(index)) then
        if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
            call KillUnit(whichUnit)
        else
            call ClearRespawnUnitIndex(respawnUnitHandleId[index])
            set respawnUnitHandleId[index] = 0
            call RemoveUnit(whichUnit)
        endif
    endif
endfunction

private function TimerFunctionRespawnUnit takes nothing returns nothing
    local integer index = LoadInteger(respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnit(index)
endfunction

function StartUnitRespawn takes integer index returns nothing
    call EvaluateAndExecuteCallbackRespawnStartsTriggers(index)
    
    if (not respawnUnitReadyForRespawn[index]) then
        call BJDebugMsg("Duplicated start respawn timer for index " + I2S(index) + " for unit " + GetUnitName(respawnUnitUnit[index]))
    endif

    if (respawnUnitHandleId[index] != 0) then
        call ClearRespawnUnitIndex(respawnUnitHandleId[index])
    endif
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0

    call TimerStart(respawnUnitTimer[index], respawnUnitTimeout[index], false, function TimerFunctionRespawnUnit)
    set respawnUnitReadyForRespawn[index] = false
endfunction

function StartAllUnitRespawnsNotRunning takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and respawnUnitUnit[i] == null and respawnUnitReadyForRespawn[i]) then
            call StartUnitRespawn(i)
        endif
        set i = i + 1
    endloop
endfunction

private function AddRespawnUnitDefault takes integer index, real x, real y returns nothing
    set respawnUnitIsValid[index] = true
    set respawnUnitX[index] = x
    set respawnUnitY[index] = y
    set respawnUnitFacing[index] = GetRandomDirectionDeg()
    set respawnUnitUseDyingLoc[index] = false
    set respawnUnitOwner[index] = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    set respawnUnitTimer[index] = CreateTimer()
    set respawnUnitTimeout[index] = UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(respawnUnitHashTable, GetHandleId(respawnUnitTimer[index]), 0, index)
    set respawnUnitEnabled[index] = true
    set respawnUnitGroupIndex[index] = -1
    set respawnUnitReadyForRespawn[index] = true

    loop
        set respawnUnitFreeIndex = respawnUnitFreeIndex + 1
        exitwhen (not IsRespawnUnitValid(respawnUnitFreeIndex))
    endloop

    if (respawnUnitFreeIndex >= JASS_MAX_ARRAY_SIZE) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(respawnUnitFreeIndex))
    endif

    if (index >= respawnUnitCounter) then
        set respawnUnitCounter = index + 1
    endif
endfunction

function AddRespawnUnit takes unit whichUnit returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_UNIT
    set respawnUnitUnit[index] = whichUnit
    set respawnUnitHandleId[index] = GetHandleId(whichUnit)
    set respawnUnitUnitTypeId[index] = GetUnitTypeId(whichUnit)
    set respawnUnitPool[index] = null
    call AddRespawnUnitDefault(index, GetUnitX(whichUnit), GetUnitY(whichUnit))
    set respawnUnitFacing[index] = GetUnitFacing(whichUnit)
    set respawnUnitOwner[index] = GetOwningPlayer(whichUnit)
    set respawnUnitReadyForRespawn[index] = false
static if (UnitGroupRespawnSystemConfig_SET_MAX_DEATH_TIME_TO_UNITS) then
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        call BlzSetUnitRealField(whichUnit, UNIT_RF_DEATH_TIME, 99999999.0)
    endif
endif

    call SaveInteger(respawnUnitHashTable, respawnUnitHandleId[index], 0, index)

    return index
endfunction

function SetRespawnUnitGroupIndex takes integer index, integer groupIndex returns nothing
    if (IsRespawnUnitGroupValid(groupIndex)) then
        if (IsRespawnUnitGroupValid(respawnUnitGroupIndex[index]) and respawnUnitUnit[index] != null) then
            call GroupRemoveUnit(respawnUnitGroup[respawnUnitGroupIndex[index]], respawnUnitUnit[index])
        endif
        set respawnUnitGroupIndex[index] = groupIndex
        if (respawnUnitUnit[index] != null) then
            call GroupAddUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
        endif
    endif
endfunction

function AddRespawnUnitPoolEx takes unitpool whichUnitPool, real x, real y, integer groupIndex returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_UNITPOOL
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0
    set respawnUnitUnitTypeId[index] = 0
    set respawnUnitPool[index] = whichUnitPool
    call AddRespawnUnitDefault(index, x, y)
    // Set group index before respawning.
    call SetRespawnUnitGroupIndex(index, groupIndex)
    
    call RespawnUnit(index)

    return index
endfunction

function AddRespawnUnitPool takes unitpool whichUnitPool, real x, real y returns integer
    return AddRespawnUnitPoolEx(whichUnitPool, x, y, -1)
endfunction

function AddRespawnUnitRandomCreepEx takes integer level, real x, real y, integer groupIndex returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0
    set respawnUnitUnitTypeId[index] = 0
    set respawnUnitPool[index] = null
    set respawnUnitRandomCreepLevel[index] = level
    call AddRespawnUnitDefault(index, x, y)
    // Set group index before respawning.
    call SetRespawnUnitGroupIndex(index, groupIndex)

    call RespawnUnit(index)

    return index
endfunction

function AddRespawnUnitRandomCreep takes integer level, real x, real y returns integer
    return AddRespawnUnitRandomCreepEx(level, x, y, -1)
endfunction


function RemoveRespawnUnit takes integer index returns boolean
    //call BJDebugMsg("Remove respawn unit " + I2S(index))
    if (IsRespawnUnitValid(index)) then
        set respawnUnitIsValid[index] = false

        if (respawnUnitUnit[index] != null) then
            call ClearRespawnUnitIndex(GetHandleId(respawnUnitUnit[index]))
        endif

        set respawnUnitTimeout[index] = 0
        set respawnUnitType[index] = 0
        set respawnUnitUnit[index] = null
        set respawnUnitHandleId[index] = 0
        set respawnUnitUnitTypeId[index] = 0
        set respawnUnitPool[index] = null
        set respawnUnitRandomCreepLevel[index] = 0
        set respawnUnitUseDyingLoc[index] = false

        call PauseTimer(respawnUnitTimer[index])
        call FlushChildHashtable(respawnUnitHashTable, GetHandleId(respawnUnitTimer[index]))
        call DestroyTimer(respawnUnitTimer[index])

        set respawnUnitFreeIndex = index

        if (index == respawnUnitCounter - 1) then
            set respawnUnitCounter = respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitEnabled takes integer index, boolean enabled returns nothing
    set respawnUnitEnabled[index] = enabled
endfunction

function IsRespawnUnitEnabled takes integer index returns boolean
    return respawnUnitEnabled[index]
endfunction

function GetRespawnUnitTimer takes integer index returns timer
    return respawnUnitTimer[index]
endfunction

function GetRespawnUnitType takes integer index returns integer
    return respawnUnitType[index]
endfunction

function SetRespawnUnitTimeout takes integer index, real timeout returns nothing
    set respawnUnitTimeout[index] = timeout
endfunction

function GetRespawnUnitTimeout takes integer index returns real
    return respawnUnitTimeout[index]
endfunction

function SetRespawnUnitOwner takes integer index, player owner returns nothing
    set respawnUnitOwner[index] = owner
endfunction

function GetRespawnUnitOwner takes integer index returns player
    return respawnUnitOwner[index]
endfunction
function SetRespawnUnitFacing takes integer index, real facing returns nothing
    set respawnUnitFacing[index] = facing
endfunction

function GetRespawnUnitFacing takes integer index returns real
    return respawnUnitFacing[index]
endfunction

function SetRespawnUnitX takes integer index, real x returns nothing
    set respawnUnitX[index] = x
endfunction

function GetRespawnUnitX takes integer index returns real
    return respawnUnitX[index]
endfunction

function SetRespawnUnitY takes integer index, real y returns nothing
    set respawnUnitX[index] = y
endfunction

function GetRespawnUnitY takes integer index returns real
    return respawnUnitY[index]
endfunction

function SetRespawnUnitUseDyingLoc takes integer index, boolean use returns nothing
    set respawnUnitUseDyingLoc[index] = use
endfunction

function GetRespawnUnitUseDyingLoc takes integer index returns boolean
    return respawnUnitUseDyingLoc[index]
endfunction

function SetRespawnUnit takes integer index, unit whichUnit returns nothing
    local integer groupIndex = respawnUnitGroupIndex[index]
    local boolean validRespawnUnitGroup = IsRespawnUnitGroupValid(groupIndex)
    local integer handleId = GetHandleId(whichUnit)
    if (respawnUnitUnit[index] != null) then
        if (validRespawnUnitGroup) then
            call GroupRemoveUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
        endif

        call ClearRespawnUnitIndex(GetHandleId(respawnUnitUnit[index]))
    endif
    set respawnUnitUnit[index] = whichUnit
    set respawnUnitHandleId[index] = handleId
    set respawnUnitType[index] = GetUnitTypeId(whichUnit)
    call SaveInteger(respawnUnitHashTable, handleId, 0, index)
    set respawnUnitReadyForRespawn[index] = false
    if (validRespawnUnitGroup) then
        call GroupAddUnit(respawnUnitGroup[groupIndex], whichUnit)
    endif
endfunction

function GetRespawnUnit takes integer index returns unit
    return respawnUnitUnit[index]
endfunction

function SetRespawnUnitPool takes integer index, unitpool whichUnitPool returns nothing
    set respawnUnitPool[index] = whichUnitPool
endfunction

function GetRespawnUnitPool takes integer index returns unitpool
    return respawnUnitPool[index]
endfunction

function SetRespawnUnitLevel takes integer index, integer level returns nothing
    set respawnUnitRandomCreepLevel[index] = level
endfunction

function GetRespawnUnitLevel takes integer index returns integer
    return respawnUnitRandomCreepLevel[index]
endfunction

function GetRespawnUnitGroupCounter takes nothing returns integer
    return respawnUnitGroupCounter
endfunction

function GetRespawnUnitGroupIndex takes integer index returns integer
    return respawnUnitGroupIndex[index]
endfunction

function AddRespawnUnitGroup takes nothing returns integer
    local integer index = respawnUnitGroupFreeIndex
    set respawnUnitGroupIsValid[index] = true
    set respawnUnitGroup[index] = CreateGroup()
    set respawnUnitGroupTimer[index] = CreateTimer()
    set respawnUnitGroupTimeout[index] = UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(respawnUnitHashTable, GetHandleId(respawnUnitGroupTimer[index]), 0, index)
    set respawnUnitGroupEnabled[index] = true
    set respawnUnitGroupItemDropEnabled[index] = UnitGroupRespawnSystemConfig_AUTO_ADDED_DROP_RANDOM_ITEMS

    loop
        set respawnUnitGroupFreeIndex = respawnUnitGroupFreeIndex + 1
        exitwhen (not IsRespawnUnitGroupValid(respawnUnitGroupFreeIndex))
    endloop

    if (respawnUnitGroupFreeIndex >= JASS_MAX_ARRAY_SIZE) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(respawnUnitGroupFreeIndex))
    endif

    if (index >= respawnUnitGroupCounter) then
        set respawnUnitGroupCounter = index + 1
    endif

    return index
endfunction

globals
    private force filterForce = null
endglobals

private function FilterFunctionBelongsToSameOwnerAndHasRespawn takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local integer respawnUnitIndex = -1
    if (IsPlayerInForce(GetOwningPlayer(filterUnit), filterForce)) then
        set respawnUnitIndex = GetUnitRespawnUnitIndex(filterUnit)
        set filterUnit = null
        return IsRespawnUnitValid(respawnUnitIndex) and IsRespawnUnitGroupValid(GetRespawnUnitGroupIndex(respawnUnitIndex))
    endif
    set filterUnit = null
    return false
endfunction

function AddRespawnUnitGroupFromUnitEx takes unit whichUnit, force whichForce, real maxDistance returns integer
    local group allNearbyUnitsFromTheSameOwner = CreateGroup()
    local unit first = null
    local integer groupIndex = -1
    local integer index = -1
    set filterForce = whichForce
    call GroupEnumUnitsInRange(allNearbyUnitsFromTheSameOwner, GetUnitX(whichUnit), GetUnitY(whichUnit), maxDistance, Filter(function FilterFunctionBelongsToSameOwnerAndHasRespawn))
    set first = FirstOfGroup(allNearbyUnitsFromTheSameOwner)
    call GroupClear(allNearbyUnitsFromTheSameOwner)
    call DestroyGroup(allNearbyUnitsFromTheSameOwner)
    set allNearbyUnitsFromTheSameOwner = null
    if (first != null) then
        set groupIndex = GetRespawnUnitGroupIndex(GetUnitRespawnUnitIndex(first))
        set first = null
    else
        // add a new group for the unit since we found no neighbours with the same owner
        set groupIndex = AddRespawnUnitGroup()
    endif
    set index = AddRespawnUnit(whichUnit)
    call SetRespawnUnitGroupIndex(index, groupIndex)
    return groupIndex
endfunction

function AddRespawnUnitGroupFromUnit takes unit whichUnit returns integer
    return AddRespawnUnitGroupFromUnitEx(whichUnit, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE)
endfunction

private function PolarProjectionX takes real x, real dist, real angle returns real
    return x + dist * Cos(angle * bj_DEGTORAD)
endfunction

private function PolarProjectionY takes real y, real dist, real angle returns real
    return y + dist * Sin(angle * bj_DEGTORAD)
endfunction

private function GetRandomLocInRange takes real x, real y, real range returns location
    local real dist = GetRandomReal(0.0, range)
    local real angle = GetRandomDirectionDeg()
    return Location(PolarProjectionX(x, dist, angle), PolarProjectionY(y, dist, angle))
endfunction

function AddRespawnUnitGroupFromUnitPool takes unitpool whichUnitPool, integer countMembers, real x, real y, real range returns integer
    local integer groupIndex = AddRespawnUnitGroup()
    local location whichLocation = null
    local integer i = 0
    loop
        exitwhen (i >= countMembers)
        set whichLocation = GetRandomLocInRange(x, y, range)
        call AddRespawnUnitPoolEx(whichUnitPool, GetLocationX(whichLocation), GetLocationY(whichLocation), groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation = null
        set i = i + 1
    endloop
    return groupIndex
endfunction

function AddRespawnUnitGroupFromRandomCreepLevel takes integer minCreepLevel, integer maxCreepLevel, integer countMembers, real x, real y, real range returns integer
    local integer groupIndex = AddRespawnUnitGroup()
    local location whichLocation = null
    local integer i = 0
    loop
        exitwhen (i >= countMembers)
        set whichLocation = GetRandomLocInRange(x, y, range)
        call AddRespawnUnitRandomCreepEx(GetRandomInt(minCreepLevel, maxCreepLevel), GetLocationY(whichLocation), GetLocationY(whichLocation), groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation = null
        set i = i + 1
    endloop
    return groupIndex
endfunction

function RemoveRespawnUnitGroup takes integer index returns boolean
    if (IsRespawnUnitValid(index)) then
        set respawnUnitGroupIsValid[index] = false
        set respawnUnitGroupEnabled[index] = false

        if (respawnUnitGroup[index] != null) then
            call GroupClear(respawnUnitGroup[index])
            call DestroyGroup(respawnUnitGroup[index])
            set respawnUnitGroup[index] = null
        endif

        call PauseTimer(respawnUnitGroupTimer[index])
        call FlushChildHashtable(respawnUnitHashTable, GetHandleId(respawnUnitGroupTimer[index]))
        call DestroyTimer(respawnUnitGroupTimer[index])

        set respawnUnitFreeIndex = index

        if (index == respawnUnitCounter - 1) then
            set respawnUnitCounter = respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitGroupTimeout takes integer index, real timeout returns nothing
    set respawnUnitGroupTimeout[index] = timeout
endfunction

function GetRespawnUnitGroupTimeout takes integer index returns real
    return respawnUnitGroupTimeout[index]
endfunction

function SetRespawnUnitGroupEnabled takes integer index, boolean enabled returns nothing
    set respawnUnitGroupEnabled[index] = enabled
endfunction

function IsRespawnUnitGroupEnabled takes integer index returns boolean
    return respawnUnitGroupEnabled[index]
endfunction

function SetRespawnUnitGroupItemDropEnabled takes integer index, boolean enabled returns nothing
    set respawnUnitGroupItemDropEnabled[index] = enabled
endfunction

function GetRespawnUnitGroupItemDropEnabled takes integer index returns boolean
    return respawnUnitGroupItemDropEnabled[index]
endfunction

function GetRespawnUnitGroupUnits takes integer index returns group
    return respawnUnitGroup[index]
endfunction

function RespawnUnitGroup takes integer index returns boolean
    local integer i = 0
    //call BJDebugMsg("Respawn unit group " + I2S(index))
    if (not IsRespawnUnitGroupValid(index)) then
        return false
    endif
    // We do not know the members anymore since we have removed them from the group. Hence, we need to find all matching respawns.
    // TODO Store the list of indices in the group?
    set i = 0
    loop
        exitwhen (i == GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and GetRespawnUnitGroupIndex(i) == index) then
            //call BJDebugMsg("Respawn unit with index " + I2S(i) + " from group " + I2S(index))
            call RespawnUnit(i)
        endif
        set i = i + 1
    endloop

    return true
endfunction

private function TimerFunctionRespawnUnitGroup takes nothing returns nothing
    local integer index = LoadInteger(respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnitGroup(index)
endfunction

function StartUnitGroupRespawn takes integer index returns nothing
    local unit member = null
    local integer memberIndex = -1
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(respawnUnitGroup[index]))
        set member = BlzGroupUnitAt(respawnUnitGroup[index], i)
        set memberIndex = GetUnitRespawnUnitIndex(member)
        set respawnUnitReadyForRespawn[memberIndex] = false // makes sure that StartAllUnitRespawnsNotRunning does not start a duplicated respawn.
        //call BJDebugMsg("Making group member " + I2S(memberIndex) + " not ready for respawn anymore!")
        set member = null
        set i = i + 1
    endloop
    
    // start call backs
    loop
        exitwhen (i == BlzGroupGetSize(respawnUnitGroup[index]))
        set member = BlzGroupUnitAt(respawnUnitGroup[index], i)
        set memberIndex = GetUnitRespawnUnitIndex(member)
        call EvaluateAndExecuteCallbackRespawnStartsTriggers(memberIndex)
        set member = null
        set i = i + 1
    endloop

    // Cleanup since we do not know how long the unit will decay etc.
    set i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(respawnUnitGroup[index]))
        set member = BlzGroupUnitAt(respawnUnitGroup[index], i)
        set memberIndex = GetUnitRespawnUnitIndex(member)

        if (not IsUnitType(member, UNIT_TYPE_HERO)) then
            if (respawnUnitHandleId[memberIndex] != 0) then
                call ClearRespawnUnitIndex(respawnUnitHandleId[memberIndex])
            endif
            set respawnUnitUnit[memberIndex] = null
            set respawnUnitHandleId[memberIndex] = 0
            call GroupRemoveUnit(respawnUnitGroup[index], member) // only remove non-heroes
        else
            set i = i + 1
        endif

        set member = null
    endloop
    
    //call BJDebugMsg("Starting respawn timer for group " + I2S(index))

    call TimerStart(respawnUnitGroupTimer[index], respawnUnitGroupTimeout[index], false, function TimerFunctionRespawnUnitGroup)
endfunction

private function TriggerConditionRespawnUnit takes nothing returns boolean
    local integer index = GetUnitRespawnUnitIndex(GetTriggerUnit())
    return IsRespawnUnitValid(index) and IsRespawnUnitEnabled(index)
endfunction

private function IsUnitGroupReadyForRespawnEnum takes nothing returns nothing
    local integer index = GetUnitRespawnUnitIndex(GetEnumUnit())
    //call BJDebugMsg("Checking member: " + I2S(index))
    if (not respawnUnitReadyForRespawn[index]) then
        set bj_isUnitGroupDeadResult = false
    endif
endfunction

private function IsUnitGroupReadyForRespawn takes group g returns boolean
    set bj_isUnitGroupDeadResult = true
    call ForGroup(g, function IsUnitGroupReadyForRespawnEnum)
    //call BJDebugMsg("Result")
    return bj_isUnitGroupDeadResult
endfunction

private function TriggerActionRespawnUnit takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local integer index = GetUnitRespawnUnitIndex(triggerUnit)
    local integer groupIndex = GetRespawnUnitGroupIndex(index)

    if (GetRespawnUnitUseDyingLoc(index)) then
        call SetRespawnUnitFacing(index, GetUnitFacing(triggerUnit))
        call SetRespawnUnitX(index, GetUnitX(triggerUnit))
        call SetRespawnUnitY(index, GetUnitY(triggerUnit))
    endif

    set respawnUnitReadyForRespawn[index] = true

    if (IsRespawnUnitGroupValid(groupIndex) and IsRespawnUnitGroupEnabled(groupIndex)) then
        if (IsUnitGroupReadyForRespawn(GetRespawnUnitGroupUnits(groupIndex))) then
            call UnitGroupRespawnSystemConfig_DropItemForGroup(groupIndex, triggerUnit, GetRespawnUnitGroupUnits(groupIndex), GetRespawnUnitGroupItemDropEnabled(groupIndex))
            //call BJDebugMsg("Start group unit respawn for index " + I2S(groupIndex) + " with " + I2S(BlzGroupGetSize(GetRespawnUnitGroupUnits(groupIndex))) + " members")
            call StartUnitGroupRespawn(groupIndex)
        endif
    else
        //call BJDebugMsg("Start unit respawn for index " + I2S(index))
        call StartUnitRespawn(index)
    endif
    set triggerUnit = null
endfunction

function AddRespawnUnitGroupFromUnitStartEx takes unit whichUnit, force whichForce, real maxDistance, boolean autoAddedGroups returns nothing
    if (not IsRespawnUnitValid(GetUnitRespawnUnitIndex(whichUnit))) then
        if (autoAddedGroups) then
            call AddRespawnUnitGroupFromUnitEx(whichUnit, whichForce, maxDistance)
        else
            call AddRespawnUnit(whichUnit)
        endif
    endif
endfunction

function AddRespawnUnitGroupFromUnitStart takes unit whichUnit returns nothing
    call AddRespawnUnitGroupFromUnitStartEx(whichUnit, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUPS)
endfunction

private function AddRespawnUnitGroupFromEnumUnit takes nothing returns nothing
    call AddRespawnUnitGroupFromUnitStart(GetEnumUnit())
endfunction

static if (UnitGroupRespawnSystemConfig_AUTO_ADD_ALL_PREPLACED_CREEPS) then
private function AddAllPreplacedCreeps takes nothing returns nothing
    local timer expiredTimer = GetExpiredTimer()
    local group allCreeps = CreateGroup()
    
    call UnitGroupRespawnSystemConfig_AddAllUserSpecifiedPreplacedCreeps(allCreeps)
    call ForGroup(allCreeps, function AddRespawnUnitGroupFromEnumUnit)
    call GroupClear(allCreeps)
    call DestroyGroup(allCreeps)
    set allCreeps = null
    
    call PauseTimer(expiredTimer)
    call DestroyTimer(expiredTimer)
    set expiredTimer = null
endfunction
endif

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(unitDeathOrCharmOrRescueTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(unitDeathOrCharmOrRescueTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(unitDeathOrCharmOrRescueTrigger, Condition(function TriggerConditionRespawnUnit))
    call TriggerAddAction(unitDeathOrCharmOrRescueTrigger, function TriggerActionRespawnUnit)

static if (UnitGroupRespawnSystemConfig_AUTO_ADD_ALL_PREPLACED_CREEPS) then
    // waiting makes sure that all units are already placed on the map
    call TimerStart(CreateTimer(), 0.0, false, function AddAllPreplacedCreeps)
else
endif
endfunction

private function RemoveUnitCleanup takes unit whichUnit returns nothing
    local integer handleID = GetHandleId(whichUnit)
    call ClearRespawnUnitIndex(handleID)
endfunction

hook RemoveUnit RemoveUnitCleanup

/*
 * ChangeLog:
 *
 * 1.2:
 * - Add function AddRespawnUnitGroupFromUnitStart.
 * - Add function AddRespawnUnitGroupFromUnitEx
 * - Add function UnitGroupRespawnSystemConfig_BeforeAddAllUserSpecifiedPreplacedCreeps.
 * - Add function UnitGroupRespawnSystemConfig_AfterAddAllUserSpecifiedPreplacedCreeps.
 *
 * 1.1:
 * - Fix changing the unit type when changing the unit.
 * - Improve API documentation.
 * - Increase default timeout from 30 to 90 seconds.
 * - Rename GetTriggerRespawnUnit into GetRespawningUnit.
 * - Rename GetTriggerRespawnUnitIndex into GetRespawningUnitIndex.
 * - Remove forces global variable and related code from the config library.
 * - Remove nulling from PreventUnitRespawn.
 * - GetUnitLevelByType caches the unit type level in a hashtable now for better performance.
 * - Add preplaced creeps after 0 seconds to include non neutral units. 
 * - Add option RESPAWN_ON_RESCUE.
 * - StartAllUnitRespawnsNotRunning only respawns units which are ready to respawn now.
 * - Fix location for pool based unit group respawns.
 * - Fix checking if a unit exists before checking if it is a hero.
 * - Fix setting the unit respawn group for members of unit pool based respawn groups before respawning them.
 * - Start with index 1 for valid unit respawns and unit group respawns.
 * - Only add preplaced units if they do not already have unit respawn to prevent duplicated respawns.
 * - Drop random items on group deaths in the example map.
 * - Simplify functions IsRespawnUnitValid and IsRespawnUnitGroupValid.
 * - Do not trigger disabled callback triggers.
 * - Remove function GetUnitRespawnGroupIndex.
 * - Split into two libraries.
 * - Use AUTO_ADDED_GROUP_PLAYERS to check if nearby units have the same owner.
 * - Reduce player number from 4 to 2 in the example map.
 * - Reduce the number of respawning units in the example map.
 * - Do not add neutral passive buildings to unit respawn groups anymore in the example map.
 * - Add a player for creep heroes to the example map since heroes cannot be revived for neutral hostile.
 */
endlibrary
