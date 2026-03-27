 library HeroReviveCancelEvent /* v1.1 -- hiveworkshop.com/threads/herorevivecancelevent.293491/#resource-72550

     Information
    ¯¯¯¯¯¯¯¯¯¯¯¯

        Provides an event that fires when a player cancels a hero revival at the altar.
        When using this system, you don't need the default event EVENT_PLAYER_HERO_REVIVE_CANCEL anymore.
       
       
     Mechanics
    ¯¯¯¯¯¯¯¯¯¯
   
        (Issue:)
       
        The default problem is that EVENT_PLAYER_HERO_REVIVE_CANCEL will only fire when using
        the "Cancel" spell, but not when directly clicking on the hero icon in training queue.
       
        (Solution:)
       
        When a hero starts reviving process, so enters the queue, we periodicly order the altar to try to 'revive'
        the hero. Normaly this order will return "false", as the hero is already being revived, but once it returns "true"
        we know, that the hero must not be in queue anymore. Then we fire the event.
       
        This method will work for both, when the "Cancel" spell is used, and when the hero icon is clicked in queue.
 */

//  ====API ====
//! novjass

    struct HeroReviveCancelEvent
   
    // register code
   
        static method register takes code c returns nothing
        static method unregister takes code c returns nothing
       
    // Inside registered code, you can access data:
   
       static thistype instance
           readonly unit hero       // hero that was reviving
           readonly unit building   // altar for revival
       

//! endnovjass
//  ===== End API ====

native UnitAlive takes unit u returns boolean
                                                 
    struct HeroReviveCancelEvent
       
        private static constant integer REVIVE_ORDER_ID_OFFSET = 852027
        private static constant integer CANCEL_ORDER_ID        = 851976
        private static constant integer MAX_HERO_AMOUNT        = 4
       
        private static constant real    TIMEOUT                = 0.1
       
        private static hashtable hash    = InitHashtable()
        private static trigger   handler = CreateTrigger()
       
        readonly static thistype instance
        readonly        unit     hero
        readonly        unit     building
       
        private timer clock
        private player owner
        private boolean exists
       
        private method destroy takes nothing returns nothing
            if .exists then
                set .exists = false
               
                call RemoveSavedInteger(hash, GetHandleId(.clock), 0)
                call RemoveSavedInteger(hash, GetHandleId(.hero), 0)
                call DestroyTimer(.clock)
               
                set .clock    = null
                set .hero     = null
                set .building = null
               
                call .deallocate()
            endif
        endmethod
       
        private static method callback takes nothing returns nothing
            local integer food
            local integer gold
            local integer lumber
           
            local thistype this = LoadInteger(hash, GetHandleId(GetExpiredTimer()), 0)
            if not UnitAlive(.building) or UnitAlive(.hero) then
                 call .destroy()
            endif
           
            // resources backup
            set gold   = GetPlayerState(.owner, PLAYER_STATE_RESOURCE_GOLD)
            set lumber = GetPlayerState(.owner, PLAYER_STATE_RESOURCE_LUMBER)
            set food   = GetPlayerState(.owner, PLAYER_STATE_RESOURCE_FOOD_USED)
           
            // give some conditions that will hopefully be always enough to successfuly order the revive order
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_GOLD, 1000000)
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_LUMBER, 1000000)
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_FOOD_USED, 0)
           
            if IssueTargetOrder(.building, "revive", .hero) then
               
                // 
                call IssueImmediateOrderById(.building, CANCEL_ORDER_ID)
               
                // retrieve original resources before the handler is fired
                call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_GOLD, gold)
                call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_LUMBER, lumber)
                call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_FOOD_USED, food)
               
                // fire event
                set instance = this
                call TriggerEvaluate(.handler)
                call .destroy()
                return
            endif
           
            // retrieve original resources
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_GOLD, gold)
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_LUMBER, lumber)
            call SetPlayerState(.owner, PLAYER_STATE_RESOURCE_FOOD_USED, food)
        endmethod

        private static method create takes unit b, unit h returns thistype
            local thistype this = allocate()
           
            set .exists   = true
            set .clock    = CreateTimer()
            set .hero     = h
            set .building = b
            set .owner    = GetOwningPlayer(h)
           
            call TimerStart(.clock, TIMEOUT, true, function thistype.callback)
            call SaveInteger(hash, GetHandleId(.clock), 0, this)
            call SaveInteger(hash, GetHandleId(.hero), 0, this)
           
            return this
        endmethod
       
        // hero gets into revive queue, so now we start periodicaly watching it
        private static method onReviveStart takes nothing returns boolean
            local integer orderId = GetIssuedOrderId()
            if (orderId >= REVIVE_ORDER_ID_OFFSET and orderId <= REVIVE_ORDER_ID_OFFSET + MAX_HERO_AMOUNT) then
                call create(GetOrderedUnit(), GetOrderTargetUnit())
            endif
            return false
        endmethod
       
        // instantly destroy instance when unit finished reviving
        private static method onReviveFinish takes nothing returns boolean
            call thistype(LoadInteger(hash, GetHandleId(GetTriggerUnit()), 0)).destroy()
            return false
        endmethod
       
        private static method onInit takes nothing returns nothing
            local trigger t
            set t = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
            call TriggerAddCondition(t, Condition(function thistype.onReviveStart))
           
            set t = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_REVIVE_FINISH )
            call TriggerAddCondition(t, Condition(function thistype.onReviveFinish))
        endmethod
       
        // for API
       
        public static method register takes code c returns nothing
            local boolexpr bx = Condition(c)
            call SaveTriggerConditionHandle(hash, GetHandleId(bx), 0, TriggerAddCondition(handler, bx))
            set bx = null
        endmethod
       
        public static method unregister takes code c returns nothing
            local boolexpr bx = Condition(c)
            call TriggerRemoveCondition(handler, LoadTriggerConditionHandle(hash, GetHandleId(bx), 0))
            call FlushChildHashtable(hash, GetHandleId(bx))
            call DestroyBoolExpr(bx)
            set bx = null
        endmethod

    endstruct
endlibrary
