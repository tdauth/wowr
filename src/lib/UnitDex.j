library UnitDex uses optional WorldBounds, optional GroupUtils
/***************************************************************
*
*   v1.2.2, by TriggerHappy
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*   UnitDex assigns every unit an unique integer. It attempts to make that number within the
*   maximum array limit so you can associate it with one.
*   _________________________________________________________________________
*   1. Installation
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*   Copy the script to your map, save it, then restart the editor and comment out the line below.
*/
    ///! external ObjectMerger w3a Adef uDex anam "Detect Leave" ansf "(UnitDex)" aart "" acat "" arac 0
/*  ________________________________________________________________________
*   2. Configuration
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
    private module UnitDexConfig
  
        // The raw code of the leave detection ability.
        //static constant integer DETECT_LEAVE_ABILITY = 'uDex'
        // Barade: For World of Warcraft Reforged.
        static constant integer DETECT_LEAVE_ABILITY = 'A02Z'
      
        // Allow debug messages (debug mode must also be on)
        static constant boolean ALLOW_DEBUGGING      = true
      
        // Uncomment the lines below to define a global filter for units being indexed
      
        /*static method onFilter takes unit u returns boolean
            return true
        endmethod*/
      
    endmodule
/*  _________________________________________________________________________
*   3. Function API
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*   Every function inlines.
*
*       function GetUnitId takes unit whichUnit returns integer
*       function GetUnitById takes integer index returns unit
*  
*       function UnitDexEnable takes boolean flag returns nothing
*       function UnitDexRemove takes unit u, boolean runEvents returns boolean
*
*       function IsUnitIndexed takes unit u returns boolean
*       function IsIndexingEnabled takes nothing returns boolean
*
*       function GetIndexedUnit takes nothing returns unit
*       function GetIndexedUnitId takes nothing returns integer
*      
*       function RegisterUnitIndexEvent takes boolexpr func, integer eventtype returns indexevent
*       function RemoveUnitIndexEvent takes triggercondition c, integer eventtype returns nothing
*       function TriggerRegisterUnitIndexEvent takes trigger t, integer eventtype returns nothing
*
*       function OnUnitIndex takes code func returns triggercondition
*       function OnUnitDeidex takes code func returns triggercondition
*   _________________________________________________________________________
*   4. Struct API
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       UnitDex.Enabled = false // toggle the indexer
*       UnitDex.Initialized     // returns true if the preload timer has finished
*       UnitDex.Count           // returns the amount of units indexed
*       UnitDex.Unit[0]         // access the UnitDex array directly
*       UnitDex.Group           // a unit group containing every indexed unit (for enumeration)
*       UnitDex.LastIndex       // returns the last indexed unit's id
*   _________________________________________________________________________
*   5. Public Variables
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       These are to be used with the "eventtype" argument of the event API:
*
*           constant integer EVENT_UNIT_INDEX     = 0
*           constant integer EVENT_UNIT_DEINDEX   = 1
*   _________________________________________________________________________
*   6. Examples
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       1. Associate a unit with a variable
*
*           set UnitFlag[GetUnitId(yourUnit)] = true
*
*       2. Allocate a struct instance using a units assigned ID
*
*           local somestruct data = GetUnitId(yourUnit)
*  
*       3. Detect when a unit leaves the map
*
*           function Exit takes nothing returns nothing
*               call BJDebugMsg("The unit " + GetUnitName(GetIndexedUnit()) + " has left the map.")
*           endfunction
*
*           call OnUnitDeindex(function Exit)
*           // or
*           call RegisterUnitIndexEvent(Filter(function Exit), EVENT_UNIT_DEINDEX)
*
*
*   _________________________________________________________________________
*   7. How it works
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       1. Enumerate all preplaced units
*       2. TriggerRegisterEnterRegion native to detect when a unit enters the map
*       3. Assign each unit that enters the map a unique integer
*       4. Give every unit an ability based off of defend. There is no native to accurately
*          detect when a unit leaves the map but when a unit dies or is removed from the game
*          they are issued the "undefend" order
*       5. Catch the "undefend" order and remove unit from the queue
*   _________________________________________________________________________
*   8. Notes
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       - This system is compatable with GUI because it utilizes UnitUserData (custom values for units).
*       - The object merger line should be commented out after saving and restarting.
*
*   -http://www.hiveworkshop.com/forums/submissions-414/unitdex-lightweight-unit-indexer-248209/
*
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
  
    globals
        // Event types
        constant integer EVENT_UNIT_INDEX     = 0
        constant integer EVENT_UNIT_DEINDEX   = 1
      
        // System variables
        private trigger array IndexTrig
        private integer Index = 0
        private real E=-1
        private boolexpr FilterEnter
    endglobals
  
    function GetUnitId takes unit whichUnit returns integer
        return GetUnitUserData(whichUnit)
    endfunction
  
    function GetUnitById takes integer index returns unit
        return UnitDex.Unit[index]
    endfunction
  
    function GetIndexedUnit takes nothing returns unit
        return UnitDex.Unit[UnitDex.LastIndex]
    endfunction
  
    function GetIndexedUnitId takes nothing returns integer
        return UnitDex.LastIndex
    endfunction
  
    function IsUnitIndexed takes unit u returns boolean
        return (GetUnitById(GetUnitId(u)) != null)
    endfunction
  
    function UnitDexEnable takes boolean flag returns nothing
        set UnitDex.Enabled = flag
    endfunction
  
    function IsIndexingEnabled takes nothing returns boolean
        return UnitDex.Enabled
    endfunction
  
    function RegisterUnitIndexEvent takes boolexpr func, integer eventtype returns triggercondition
        return TriggerAddCondition(IndexTrig[eventtype], func)
    endfunction
  
    function RemoveUnitIndexEvent takes triggercondition c, integer eventtype returns nothing
        call TriggerRemoveCondition(IndexTrig[eventtype], c)
    endfunction
  
    function TriggerRegisterUnitIndexEvent takes trigger t, integer eventtype returns nothing
        call TriggerRegisterVariableEvent(t, SCOPE_PRIVATE + "E", EQUAL, eventtype)
    endfunction
  
    function OnUnitIndex takes code func returns triggercondition
        return TriggerAddCondition(IndexTrig[EVENT_UNIT_INDEX], Filter(func))
    endfunction

    function OnUnitDeindex takes code func returns triggercondition
        return TriggerAddCondition(IndexTrig[EVENT_UNIT_DEINDEX], Filter(func))
    endfunction
  
    /****************************************************************/
  
    private keyword UnitDexCore
  
    struct UnitDex extends array
        static boolean Enabled = true
      
        readonly static integer LastIndex
        readonly static boolean Initialized=false
        readonly static group Group=CreateGroup()
        readonly static unit array Unit
        readonly static integer Count = 0
        readonly static integer array List
      
        implement UnitDexConfig
      
        private static integer Counter = 0
      
        implement UnitDexCore
    endstruct
  
    function UnitDexRemove takes unit u, boolean runEvents returns boolean
        return UnitDex.Remove(u, runEvents)
    endfunction
  
    /****************************************************************/
    
    private module UnitDexCore
  
        static method Remove takes unit u, boolean runEvents returns boolean
            local integer i
          
            if (IsUnitIndexed(u)) then
                set i = GetUnitId(u)
                set UnitDex.List[i] = Index
                set Index = i
              
                call GroupRemoveUnit(UnitDex.Group, u)
                call SetUnitUserData(u, 0)
          
                if (runEvents) then
                    set UnitDex.LastIndex = i
                    set E = EVENT_UNIT_DEINDEX
                    call TriggerEvaluate(IndexTrig[EVENT_UNIT_DEINDEX])
                    set E = -1
                endif
              
                set UnitDex.Unit[i] = null
                set UnitDex.Count = UnitDex.Count - 1
              
                return true
            endif
          
            return false
        endmethod
      
        private static method onGameStart takes nothing returns nothing
            local integer i = 1
          
            loop
                exitwhen i > Counter
              
                set LastIndex = i
              
                call TriggerEvaluate(IndexTrig[EVENT_UNIT_INDEX])
                set E = EVENT_UNIT_INDEX
                set E = -1
              
                set i = i + 1
            endloop

            set LastIndex   = Counter
            set Initialized = true
            set FilterEnter = null
          
            call DestroyTimer(GetExpiredTimer())
        endmethod
      
        private static method onEnter takes nothing returns boolean
            local unit    u = GetFilterUnit()
            local integer i = GetUnitId(u)
            local integer t = Index
          
            if (i == 0 and thistype.Enabled) then
              
                // If a filter was defined pass the unit through it.
                static if (thistype.onFilter.exists) then
                    if (not thistype.onFilter(u)) then
                        set u = null
                        return false // check failed
                    endif
                endif
              
                // Handle debugging
                static if (thistype.DEBUG_MODE and thistype.ALLOW_DEBUGGING) then
                    if (t == 0 and Counter+1 >= JASS_MAX_ARRAY_SIZE) then
                        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "UnitDex: Maximum number of units reached!")
                        set u = null
                        return false
                    endif
                endif
              
                // Add to group of indexed units
                call GroupAddUnit(thistype.Group, u)
              
                // Give unit the leave detection ability
                call UnitAddAbility(u, thistype.DETECT_LEAVE_ABILITY)
                call UnitMakeAbilityPermanent(u, true, thistype.DETECT_LEAVE_ABILITY)
              
                // Allocate index
                if (Index != 0) then
                    set Index = List[t]
                else
                    set Counter = Counter + 1
                    set t = Counter
                endif
              
                set List[t] = -1
                set LastIndex = t
                set thistype.Unit[t] = u
                set Count = Count + 1
              
                // Store the index
                call SetUnitUserData(u, t)
              
                if (thistype.Initialized) then
                    // Execute custom events registered with RegisterUnitIndexEvent
                    call TriggerEvaluate(IndexTrig[EVENT_UNIT_INDEX])
                  
                    // Handle TriggerRegisterUnitIndexEvent
                    set E = EVENT_UNIT_INDEX

                    // Reset so the event can occur again
                    set E = -1
                endif
            endif
          
            set u = null
          
            return false
        endmethod

        private static method onLeave takes nothing returns boolean
            local unit    u
            local integer i
          
            // Check if order is undefend.
            if (thistype.Enabled and GetIssuedOrderId() == 852056) then
              
                set u = GetTriggerUnit()
              
                // If unit was killed (not removed) then don't continue
                if (GetUnitAbilityLevel(u, thistype.DETECT_LEAVE_ABILITY) != 0) then
                    set u = null
                    return false
                endif
              
                set i = GetUnitId(u)

                // If unit has been indexed then deindex it
                if (i > 0 and i <= Counter and u == GetUnitById(i)) then
                  
                    // Recycle the index
                    set List[i]   = Index
                    set Index     = i
                    set LastIndex = i
                  
                    // Remove to group of indexed units
                    call GroupRemoveUnit(thistype.Group, u)
              
                    // Execute custom events without any associated triggers
                    call TriggerEvaluate(IndexTrig[EVENT_UNIT_DEINDEX])
                  
                    // Handle TriggerRegisterUnitIndexEvent
                    set E = EVENT_UNIT_DEINDEX
                  
                    // Remove entry
                    call SetUnitUserData(u, 0)
                    set thistype.Unit[i] = null
                  
                    // Decrement unit count
                    set Count = Count - 1
              
                    // Reset so the event can occur again
                    set E = -1
                endif
              
                set u = null
            endif
          
            return false
        endmethod
      
        private static method onInit takes nothing returns nothing
            local trigger t         = CreateTrigger()
            local integer i         = 0
            local player p
            local unit u
          
            static if (not LIBRARY_WorldBounds) then // Check if WorldBounts exists, if not then define the necessary vars
                local region reg = CreateRegion() // If WorldBounds wasn't found, create the region manually
                local rect world = GetWorldBounds()
            endif
          
            static if (not LIBRARY_GroupUtils) then // Check if GroupUtils exists so we can use it's enumeration group.
                local group ENUM_GROUP = CreateGroup() // If not, create the group.
            endif
          
            set FilterEnter = Filter(function thistype.onEnter)
          
            // Begin to index units when they enter the map
            static if (LIBRARY_WorldBounds) then
                call TriggerRegisterEnterRegion(CreateTrigger(), WorldBounds.worldRegion, FilterEnter)
            else
                call RegionAddRect(reg, world)
                call TriggerRegisterEnterRegion(CreateTrigger(), reg, FilterEnter)
                call RemoveRect(world)
                set world = null
            endif
          
            call TriggerAddCondition(t, Filter(function thistype.onLeave))
          
            set IndexTrig[EVENT_UNIT_INDEX] = CreateTrigger()
            set IndexTrig[EVENT_UNIT_DEINDEX] = CreateTrigger()
          
            loop
                set p = Player(i)
              
                // Detect "undefend"
                call TriggerRegisterPlayerUnitEvent(t, p, EVENT_PLAYER_UNIT_ISSUED_ORDER, null)
              
                // Hide the detect ability from players
                call SetPlayerAbilityAvailable(p, thistype.DETECT_LEAVE_ABILITY, false)
              
                set i = i + 1
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
          
            // Index preplaced units
            set i = 0
            loop
                call GroupEnumUnitsOfPlayer(ENUM_GROUP, Player(i), FilterEnter)
              
                set i = i + 1
              
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
          
            static if (not LIBRARY_GroupUtils) then
                call DestroyGroup(ENUM_GROUP)
                set ENUM_GROUP = null
            endif

            set LastIndex = Counter
          
            // run init triggers
            call TimerStart(CreateTimer(), 0.00, false, function thistype.onGameStart)
        endmethod
  
    endmodule
  
endlibrary
