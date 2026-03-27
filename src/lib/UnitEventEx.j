/*
    UnitEventEx v1.03
    by Spellbound
    Barade: Adapt to RegisterPlayerUnitEvent by Magtheridon96.
  
    Credits to Bribe for the excellent GUI Unit Event, of which this library is the vJASS
    version of. He was also helpful in understanding how his system works so that I may code this.
    
    Additional credits to Jesus4Lyf for Transport, Nestharus for UnitEvent and grim001 for AutoEvents.
*/
/*
    _________________________________________________________________________
    DESCRIPTION
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    UnitEventEx provides you with extra events not available in the vanilla game. Specifically, 
    you will be able to detect when a unit transforms, loads and unloads from a transport unit, is
    reanimated by Reanimate Dead, reincarnates or is brought back to life.
  
    Additionally, each of those events can be toggled on or off depending on whether you need them.
    See // CONFIGURATION under the globals block below.
*/
/*
    _________________________________________________________________________
    INSTALLATION
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    UnitEventEx requires:
  
        UnitDex by TriggerHappy (Make sure you have the Detect Leave (UnitDex) ability in your map)
        https://www.hiveworkshop.com/threads/system-unitdex-unit-indexer.248209/
      
        RegisterEvent Pack by Bannar (both RegisterNativeEvent and RegisterPlayerUnitEvent)
        https://www.hiveworkshop.com/threads/snippet-registerevent-pack.250266/
    
    Optionally uses:
    
        ListT by Bannar
        https://www.hiveworkshop.com/threads/containers-list-t.249011/
        
        WorldBounds by Nestharus
        https://github.com/nestharus/JASS/blob/master/jass/Systems/WorldBounds/script.j
  
    Once you have the required libraries in place, either copy the Detect Transform (UnitEventEx)
    ability to your map and set DETECT_TRANSFORM_ABILITY in the globals block below to the id of
    the spell.
  
    Alternatively, you can use the textmacro below. Import UnitEventEx, uncomment it, save your map,
    close it, reload and comment it out again. The ability will have been created in your Object Editor.
*/
    // //! external ObjectMerger w3a Adef EETD anam "Detect Transform" ansf "(UnitEventEx)" aart "" acat "" arac 0
/*
    _________________________________________________________________________
    CONFUGRATION
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    UnitEventEx can be configured to exclude those events you do not wish to use. Define which
    events will be needed in the CONFIG block below.
*/
/*
    _________________________________________________________________________
    API
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    
    Event Registration
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    call RegisterNativeEvent(yourEvent, function yourFunction )
        This registers the event for all players.
    
    call RegisterIndexNativeEvent(playerIndex, yourEvent, function yourFunction )
        This registers the event for a specific player.
        NB: Player 1 starts on zero.
    
    call RegisterIndexNativeEvent(GetHandleId(event unit), yourEvent, function yourFunction )
        This registers the event for a specific unit.
        
    call GetIndexNativeEventTrigger(GetHandleId(event unit), yourEvent)
        This returns the trigger associated with that unit id and event id. Destroy that trigger
        to remove it. Useful for temporary events.
        
        Also works with playerIndex.
        
    The Events you can call are:
  
    EVENT_ON_TRANSFORM
    EVENT_ON_CARGO_LOAD
    EVENT_ON_CARGO_UNLOAD
    EVENT_ON_RESURRECTION
    EVENT_ON_ANIMATE_DEAD
    EVENT_ON_REINCARNATION_START
    EVENT_ON_REINCARNATION_FINISH
    EVENT_ON_UNIT_CREATED
    
    Event Getters
    ¯¯¯¯¯¯¯¯¯¯¯¯¯
    call GetEventUnit() returns unit
        returns the event unit, similar to GetTriggerUnit().
        MB: GetTriggerUnit() will NOT work with UnitEventEx.
      
    call GetCargoUnit() returns unit
        returns the transport unit.
        NB: Only works on EVENT_ON_CARGO_LOAD and EVENT_ON_CARGO_UNLOAD
      
    call GetCargoSize() returns integer
        returns the number of units loaded in a transport.
        NB: Only works on EVENT_ON_CARGO_LOAD and EVENT_ON_CARGO_UNLOAD

    Cargo Getters
    ¯¯¯¯¯¯¯¯¯¯¯¯¯
    call IsUnitInTransporter(whichUnit) returns boolean
        returns true/false on whether a unit is loaded into a transporter.
    call GetUnitTransporter(whichUnit) returns unit
        returns the transport unit that is currently carrying whichUnit.
        the value will be null if the unit isn't in any transport.
    call GetCargoTransportedUnitGroup(transporter) returns group
        returns a copy of the group of the units in the cargo of transporter.
        NB: you must destroy the group that is returned after you're done with it.
    **Only if you have ListT
    call GetCargoTransportedUnitList(transporter) returne UEExList
        returns a copy of the list of the units in the cargo of transporter.
        NB: you must destroy the list that is returned after you're done with it.
*/
library UnitEventEx requires UnitDex, RegisterPlayerUnitEvent, optional ListT, WorldBounds
globals
    
    // CONFIGURATION
    
    // the transform detection ability. If DETECT_TRANSFORM is false, this is not needed.
    private constant integer    DETECT_TRANSFORM_ABILITY = 'UEdt'
    
    // toggles the detection of transform events.
    private constant boolean    DETECT_TRANSFORM        = false
    
    // toggles the detection of load/unload of cargo units, except for dead units (eg Meat Wagon's Exhume Corpse)
    private constant boolean    DETECT_CARGO            = true
    
    // toggles the detection of unloading dead units in cargo (Exhume Corpse). Does nothing if DETECT_CARGO is false.
    private constant boolean    DETECT_CARGO_DEAD       = true
    
    // toggles the detection of when a unit begins and finishes reincarnating.
    private constant boolean    DETECT_REINCARNATION    = true
    
    // toggles the detection of when a unit is animated via animate dead.
    private constant boolean    DETECT_ANIMATE_DEAD     = true
    
    // toggles the detection of units that are brought back to life via resurrection.
    private constant boolean    DETECT_RESURRECTION     = false
    
    // this overrides reincarnation, animate dead and resurrection. Set to true if you want any of these events to work.
    // for some reason setting DETECT_REVIVES = (DETECT_REINCARNATION or DETECT_ANIMATE_DEAD or DETECT_RESURRECTION) does not work.
    private constant boolean    DETECT_REVIVES          = false
    // this particular event will run after a zero-second delay so that units are able to fully enter the creation scope.
    // it can be useful if you need something to run after both indexing and other events like EVENT_PLAYER_UNIT_CONSTRUCT_START
    private constant boolean    DETECT_CREATION         = false
    
    // END CONFIGURATION
    
    private unit eventUnit = null
    private unit eventOther = null
    private integer eventPreType = 0
    
    integer EVENT_ON_TRANSFORM
    integer EVENT_ON_CARGO_LOAD
    integer EVENT_ON_CARGO_UNLOAD
    integer EVENT_ON_RESURRECTION
    integer EVENT_ON_ANIMATE_DEAD
    integer EVENT_ON_REINCARNATION_START
    integer EVENT_ON_REINCARNATION_FINISH
    integer EVENT_ON_UNIT_CREATED
    
    private integer Stack = -1
    private unit array IndexedUnit
    private unit array CargoUnit
    private group array CargoGroup
    private unit array Transporter
    private integer array PreTransformType
    
    private real MaxX
    private real MaxY
    
    private boolean array IsNew
    private boolean array IsAlive
    private boolean array IsReincarnating
    private boolean array IsTransforming
    
    private timer AfterIndexTimer = CreateTimer()
    private boolean rezCheck = true
    
endglobals
native UnitAlive takes unit u returns boolean
//! runtextmacro optional DEFINE_LIST("", "UEExList", "unit")
private function FireEvent takes integer ev, unit u, unit other returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(u))
    local integer handleId = GetHandleId(u)
    local integer id = GetUnitId(u)
    local unit prevUnit = eventUnit
    local unit prevOther = eventOther
    local integer prevType = eventPreType
    
    set eventUnit = u
    set eventOther = other
    set eventPreType = PreTransformType[id]
    
    call TriggerEvaluate(GetNativeEventTrigger(ev))
    if IsNativeEventRegistered(playerId, ev) then
        call TriggerEvaluate(GetIndexNativeEventTrigger(playerId, ev))
    elseif IsNativeEventRegistered(handleId, ev) then
        call TriggerEvaluate(GetIndexNativeEventTrigger(handleId, ev))
    endif
    
    set eventUnit = prevUnit
    set eventOther = prevOther
    set eventPreType = prevType
    
    set prevUnit = null
    set prevOther = null
endfunction
private struct Cargo
    
    static if LIBRARY_ListT then
        static UEExList array CargoList
    endif
    
    static method delete takes integer transport_id returns nothing
        static if LIBRARY_ListT then
            call CargoList[transport_id].destroy()
        else
            call DestroyGroup(CargoGroup[transport_id])
        endif
    endmethod
    
    static method remove takes unit u, unit transport returns nothing
        local integer transport_id = GetUnitId(transport)
        static if LIBRARY_ListT then
            call CargoList[transport_id].removeElem(u)
        else
            call GroupRemoveUnit(CargoGroup[transport_id], u)
        endif
        set Transporter[GetUnitId(u)] = null
        call FireEvent(EVENT_ON_CARGO_UNLOAD, u, transport)
    endmethod
    
    static method add takes unit u, unit transport returns nothing
        local integer transport_id = GetUnitId(transport)
        static if LIBRARY_ListT then
            call CargoList[transport_id].push(u)
        else
            call GroupAddUnit(CargoGroup[transport_id], u)
        endif
        set Transporter[GetUnitId(u)] = transport
        call FireEvent(EVENT_ON_CARGO_LOAD, u, transport)
    endmethod
    
    static method size takes integer transport_id returns integer
        static if LIBRARY_ListT then
            return CargoList[transport_id].size()
        else
            return CountUnitsInGroup(CargoGroup[transport_id])
        endif
    endmethod
    
    static method exists takes integer transport_id returns boolean
        static if LIBRARY_ListT then
            return (CargoList[transport_id] != 0)
        else
            return (CargoGroup[transport_id] != null)
        endif
    endmethod
    static method copyGroup takes integer transport_id returns group
        local group g = CreateGroup()
        static if LIBRARY_ListT then
            local UEExListItem node = CargoList[transport_id].first
            loop
                exitwhen node == 0
                call GroupAddUnit(g, node.data)
                set node = node.next
            endloop
        else
            //call BlzGroupAddGroupFast(g, CargoGroup[transport_id])
            call GroupAddGroup(CargoGroup[transport_id], g)
        endif
        return g
    endmethod
    static if LIBRARY_ListT then
        static method copyList takes integer transport_id returns UEExList
            local UEExListItem node = CargoList[transport_id].first
            local UEExList list = UEExList.create()
            loop
                exitwhen node == 0
                call list.push(node.data)
                set node = node.next
            endloop
            return list
        endmethod
    endif
    
    static method create takes integer transport_id returns thistype
        static if LIBRARY_ListT then
            set CargoList[transport_id] = UEExList.create()
        else
            set CargoGroup[transport_id] = CreateGroup()
        endif
        return 0
    endmethod
    
endstruct
// these functions are here so that they don't call functions below them.
function GetEventUnit takes nothing returns unit
    return eventUnit
endfunction
function GetCargoUnit takes nothing returns unit
    return eventOther
endfunction
function GetCargoSize takes unit transport returns integer
    return Cargo.size(GetUnitId(transport))
endfunction
function IsUnitInTransporter takes unit whichUnit returns boolean
    return Transporter[GetUnitId(whichUnit)] != null
endfunction
function GetUnitTransporter takes unit whichUnit returns unit
    return Transporter[GetUnitId(whichUnit)]
endfunction
function GetCargoTransportedUnitGroup takes unit transporter returns group
    return Cargo.copyGroup(GetUnitId(transporter))
endfunction
static if LIBRARY_ListT then
    function GetCargoTransportedUnitList takes unit transporter returns UEExList
        return Cargo.copyList(GetUnitId(transporter))
    endfunction
endif

private module UnitEventExCore
    
    /*/* afterIndex */*/
    private static method afterIndex takes nothing returns nothing
        local integer i = Stack
        local integer id
        local unit u
        
        loop
            exitwhen i < 0
            set u = IndexedUnit[i]
            set id = GetUnitId(u)
            
            if IsNew[id] then
                set IsNew[id] = false
                static if DETECT_CREATION then
                    call FireEvent(EVENT_ON_UNIT_CREATED, u, null)
                endif
                
            elseif IsTransforming[id] then
                
                static if DETECT_TRANSFORM then
                    call FireEvent(EVENT_ON_TRANSFORM, u, null)
                    set IsTransforming[id] = false
                    // The unit has finished transforming. Store it's new type id.
                    set PreTransformType[id] = GetUnitTypeId(u)
                    call UnitAddAbility(u, DETECT_TRANSFORM_ABILITY)
                endif
                
            elseif IsAlive[id] then
            
                static if DETECT_REINCARNATION then
                    set IsReincarnating[id] = true
                    set IsAlive[id] = false
                    call FireEvent(EVENT_ON_REINCARNATION_START, u, null)
                endif
                
            endif
            
            set IndexedUnit[i] = null
            set i = i - 1
        endloop
        set Stack = -1
            
        set u = null
    endmethod
    
    
    /*/* timerCheck */*/
    private static method timerCheck takes unit u returns nothing
        set Stack = Stack + 1
        set IndexedUnit[Stack] = u
        call TimerStart(AfterIndexTimer, 0., false, function thistype.afterIndex)
    endmethod
    
    
    /*/* unload */*/
    private static method unload takes unit u returns nothing
        local integer id = GetUnitId(u)
        local integer cargo_id = GetUnitId(CargoUnit[id])
        
        call Cargo.remove(u, CargoUnit[id])
        
        if not IsUnitLoaded(u) or not UnitAlive(CargoUnit[id]) then
            set CargoUnit[id] = null
        endif
    endmethod
    
    
    /*/* onOrder */*/
    private static method onOrder takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer id = GetUnitId(u)
        
            // onOrder occurs after onEnter
            
        /*
            NB: when units are unloaded from a transport, they fire a stop order (see below)
            When units are removed from the game or die, they fire an undefend order.
        */
        
        // If id is not zero then the unit has been indexed.
        if id > 0 then
            
            // Detect Cargo
            static if DETECT_CARGO then
                
                if GetIssuedOrderId() == 851972 then // order stop
                    
                    // This does not detect unloaded corpses.
                    if CargoUnit[id] != null and not IsUnitLoaded(u) or UnitAlive(u) then
                        call thistype.unload(u)
                    endif
                    
                    set u = null
                    return
                endif
                
            endif
            
            // Detect Morph
            static if DETECT_TRANSFORM then
                
                if GetUnitAbilityLevel(u, DETECT_TRANSFORM_ABILITY) == 0 and not IsTransforming[id] then
                    // re-adding DETECT_TRANSFORM_ABILITY immediately doesn't work, so it has to be
                    // done after a zero-second timer.
                    set IsTransforming[id] = true
                    call thistype.timerCheck(u)
                    
                    set u = null
                    return
                endif
                
            endif
            
            // Detect Revives
            static if DETECT_REVIVES then
            
                // If unit was not previously alive and ...
                if not IsAlive[id] and UnitAlive(u) then
                    
                    set IsAlive[id] = true
                        
                    // ... it is also a summoned unit then it has been Reanimated.
                    if IsUnitType(u, UNIT_TYPE_SUMMONED) then
                    
                        static if DETECT_ANIMATE_DEAD then
                            call FireEvent(EVENT_ON_ANIMATE_DEAD, u, null)
                        endif
                        
                    // ... IsReincarnating[id] is true then it is done reincarnating.
                    elseif IsReincarnating[id] then
                    
                        static if DETECT_REINCARNATION then
                            call FireEvent(EVENT_ON_REINCARNATION_FINISH, u, null)
                        endif
                        
                    // ... neither of the above two conditions have been met, it has been resurrected.
                    elseif not IsNew[id] and not rezCheck then
                        
                        static if DETECT_RESURRECTION then
                            call FireEvent(EVENT_ON_RESURRECTION, u, null)
                        endif
                    
                    endif
                
                // Else if the unit is dead then ...
                elseif not UnitAlive(u) then
                    
                    // if unit was just indexed then it was created as a corpse.
                    if IsNew[id] then
                        set IsAlive[id] = false
                        
                    // else if either of these parameters are true then ...
                    elseif CargoUnit[id] == null or not IsUnitType(u, UNIT_TYPE_HERO) then
                    
                        /* order undefend fires before a UNIT_DEATH event, so if the unit is not
                        alive, yet IsAlive[id] is true, that means the unit is potentially reincar-
                        nating. Fire a zero-second timer to give time for the UNIT_DEATH event to
                        trigger. If IsAlive[id] is still true, then the unit is reincarnating. */
                        if IsAlive[id] then
                            call thistype.timerCheck(u)
                        endif
                        
                    endif
                
                endif
                
            endif // static if DETECT_REVIVES then
            
        endif
        
        set u = null
    endmethod
    
    
    /*/* onDeath */*/
    private static method onDeath takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer id = GetUnitId(u)
        
        // This checks if the unit has been indexed.
        if id > 0 then
            set IsAlive[id] = false
        endif
        
        static if DETECT_CARGO then
            if CargoUnit[id] != null then
                call FireEvent(EVENT_ON_CARGO_UNLOAD, u, CargoUnit[id])
                set CargoUnit[id] = null
            endif
        endif
        
        set u = null
    endmethod
    
    
    /*/* onLoad */*/
    private static method onLoad takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer id = GetUnitId(u)
        local integer cargo_id
        
        // if unit somehow loaded into a transport while being inside another, unload it
        if CargoUnit[id] != null then
            call thistype.unload(u)
        endif
        
        static if DETECT_CARGO_DEAD then
            // if a Meat Wagon loads up a corpse either by grabbing one on the ground or via Exhume
            // Corpse, that corpse is sent to the edge of the map by this system. This way, when it
            // is unloaded and placed back at the Meat Wagon's location, it fires an onEnter event,
            // which allows the system to detect when a corpse was unloaded from a transport.
            if not UnitAlive(u) then
                if LIBRARY_WorldBounds then
                    call SetUnitX(u, WorldBounds.maxX)
                    call SetUnitY(u, WorldBounds.maxY)
                else
                    call SetUnitX(u, MaxX)
                    call SetUnitY(u, MaxY)
                endif
            endif
        endif
        
        set CargoUnit[id] = GetTransportUnit()
        set cargo_id = GetUnitId(CargoUnit[id])
        
        if not Cargo.exists(cargo_id) then
            call Cargo.create(cargo_id)
        endif
        call Cargo.add(u, CargoUnit[id])
        
        set u = null
    endmethod
    
    
    /*/* onEnter */*/
    private static method onEnter takes nothing returns nothing
        local unit u = GetFilterUnit()
        local integer id = GetUnitId(u)
        local integer cargo_id = GetUnitId(CargoUnit[id])
        
            // onEnter occurs AFTER onIndex
            
        // The unit was dead, but has re-entered the map. Used to detect when a Meat Wagon unloads a corpse.
        if id > 0 then
            if not IsUnitLoaded(u) and CargoUnit[id] != null then
                call thistype.unload(u)
            endif
        endif
        
        set u = null
    endmethod
    
    
    /*/* onIndex */*/
    private static method onIndex takes nothing returns nothing
        local unit u = GetIndexedUnit()
        local integer id = GetUnitId(u)
        
            // onIndex occurs BEFORE onEnter
        
        set IsNew[id] = true
        
        static if DETECT_TRANSFORM then
            set IsTransforming[id] = false
            set PreTransformType[id] = GetUnitTypeId(u)
            call UnitAddAbility(u, DETECT_TRANSFORM_ABILITY)
        endif
        
        static if DETECT_REINCARNATION and DETECT_REVIVES then
            set IsReincarnating[id] = false
        endif
        
        if UnitAlive(u) then
            set IsAlive[id] = true
        else
            set IsAlive[id] = false
        endif
        
        // This is called here so as to set the variable IsNew[] to false after 0. seconds.
        call thistype.timerCheck(u)
        
        set u = null
    endmethod
    
    
    /*/* onDeindex */*/
    private static method onDeindex takes nothing returns nothing
        local unit u = GetIndexedUnit()
        local integer id = GetUnitId(u)
        
        if Cargo.exists(id) then
            call Cargo.delete(id)
        endif
        
        set u = null
    endmethod
    
    
    private static method onInit takes nothing returns nothing
        local integer i
        
        static if DETECT_CARGO and DETECT_CARGO_DEAD then
            static if (not LIBRARY_WorldBounds) then
                local rect world = GetWorldBounds()
                local region reg = CreateRegion()
                set MaxX = GetRectMaxX(world)
                set MaxY = GetRectMaxY(world)
            endif
        endif
        
        set EVENT_ON_CARGO_LOAD             = CreateNativeEvent()
        set EVENT_ON_CARGO_UNLOAD           = CreateNativeEvent()
        set EVENT_ON_TRANSFORM              = CreateNativeEvent()
        set EVENT_ON_ANIMATE_DEAD           = CreateNativeEvent()
        set EVENT_ON_RESURRECTION           = CreateNativeEvent()
        set EVENT_ON_REINCARNATION_START    = CreateNativeEvent()
        set EVENT_ON_REINCARNATION_FINISH   = CreateNativeEvent()
        set EVENT_ON_UNIT_CREATED           = CreateNativeEvent()
        
        call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER, function thistype.onOrder)
        call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DEATH, function thistype.onDeath)
        
        static if DETECT_CARGO then
            
            static if DETECT_CARGO_DEAD then
            
                static if (not LIBRARY_WorldBounds) then
                    call RegionAddRect(reg, world)
                    call TriggerRegisterEnterRegion(CreateTrigger(), reg, function thistype.onEnter)
                    call RemoveRect(world)
                    set world = null
                    set reg = null
                else
                    call TriggerRegisterEnterRegion(CreateTrigger(), WorldBounds.worldRegion, function thistype.onEnter)
                endif
                call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_LOADED, function thistype.onLoad)
            
            endif
            call RegisterUnitIndexEvent(Condition(function thistype.onDeindex), EVENT_UNIT_DEINDEX)
            
        endif
        
        call RegisterUnitIndexEvent(Condition(function thistype.onIndex), EVENT_UNIT_INDEX)
        
        static if DETECT_TRANSFORM then
            set i = 0
            loop
                call SetPlayerAbilityAvailable(Player(i), DETECT_TRANSFORM_ABILITY, false)
                set i = i + 1
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
        endif
        
        // see resurrectionTimer below.
        call TimerStart(CreateTimer(), 0., false, function thistype.resurrectionTimer)
        
    endmethod
    
    // for some reason dummy recyclers creating dummies to store fires off a resurrection event, so
    // this boolean rezCheck is set to false after a 0. second timer to prevent this from happening.
    // rezCheck must be false for a resurrection event to happen.
    private static method resurrectionTimer takes nothing returns nothing
        set rezCheck = false
        call DestroyTimer(GetExpiredTimer())
    endmethod
    
endmodule
private struct UnitEventEx
    implement UnitEventExCore
endstruct
endlibrary
