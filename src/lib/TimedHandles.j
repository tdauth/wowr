library TimedHandles uses optional TimerUtils
/**************************************************************
*
*   v1.0.5 by TriggerHappy
*   ----------------------
*
*   Use this to destroy a handle after X amount seconds.
*
*   It's useful for things like effects where you may
*   want it to be temporary, but not have to worry
*   about the cleaning memory leak. By default it supports
*   effects, lightning, weathereffect, items, ubersplats, and units.
*
*   If you want to add your own handle types copy a textmacro line
*   at the bottom and add whichever handle you want along with it's destructor.
*
*   Example: //! runtextmacro TIMEDHANDLES("handle", "DestroyHandle")
*
*   Installation
    ----------------------
*       1. Copy this script and over to your map inside a blank trigger.
*       2. If you want more efficiency copy TimerUtils over as well.
*
*   API
*   ----------------------
*       call DestroyEffectTimed(AddSpecialEffect("effect.mdx", 0, 0), 5)
*       call DestroyLightningTimed(AddLightning("CLPB", true, 0, 0, 100, 100), 5)
*
*   Credits to Vexorian for TimerUtils and his help on the script.
*
**************************************************************/

    globals
        // If you don't want a timer to be ran each instance
        // set this to true.
        private constant boolean SINGLE_TIMER = true
        // If you chose a single timer then this will be the speed
        // at which the timer will update
        private constant real    UPDATE_PERIOD = 0.05
    endglobals

    // here you may add or remove handle types
    //! runtextmacro TIMEDHANDLES("effect", "DestroyEffect")
    //! runtextmacro TIMEDHANDLES("lightning", "DestroyLightning")
    //! runtextmacro TIMEDHANDLES("weathereffect", "RemoveWeatherEffect")
    //! runtextmacro TIMEDHANDLES("item", "RemoveItem")
    //! runtextmacro TIMEDHANDLES("unit", "RemoveUnit")
    //! runtextmacro TIMEDHANDLES("ubersplat", "DestroyUbersplat")
    
    // Do not edit below this line
    
    //! textmacro TIMEDHANDLES takes HANDLE,DESTROY
        
        struct $HANDLE$Timed
        
            $HANDLE$ $HANDLE$_var
            static integer index = -1
            static thistype array instance
            static real REAL=UPDATE_PERIOD
            
            static if SINGLE_TIMER then
                static timer timer = CreateTimer()
                real duration
                real elapsed = 0
            else static if not LIBRARY.TimerUtils then
                static hashtable table = InitHashtable()
            endif
            
            method destroy takes nothing returns nothing
                call $DESTROY$(this.$HANDLE$_var)
                set this.$HANDLE$_var = null
                
                static if SINGLE_TIMER then
                    set this.elapsed = 0
                endif
                
                call this.deallocate()
            endmethod
            
            private static method remove takes nothing returns nothing
                static if SINGLE_TIMER then
                    local integer i = 0
                    local thistype this
                    loop
                        exitwhen i > thistype.index
                        set this = instance[i]
                        set this.elapsed = this.elapsed + UPDATE_PERIOD
                        if (this.elapsed >= this.duration) then
                            set instance[i] = instance[index]
                            set i = i - 1
                            set index = index - 1
                            call this.destroy()
                            if (index == -1) then
                                call PauseTimer(thistype.timer)
                            endif
                        endif
                        set i = i + 1
                    endloop
                else
                    local timer t = GetExpiredTimer()
                    static if LIBRARY.TimerUtils then
                        local $HANDLE$Timed this = GetTimerData(t)
                        call ReleaseTimer(t)
                        call this.destroy()
                    else
                        local $HANDLE$Timed this = LoadInteger(table, 0, GetHandleId(t))
                        call DestroyTimer(t)
                        set t = null
                        call this.destroy()
                    endif
                endif
            endmethod
            
            static method create takes $HANDLE$ h, real timeout returns $HANDLE$Timed
                local $HANDLE$Timed this = $HANDLE$Timed.allocate()
                
                static if SINGLE_TIMER then
                    set index = index + 1
                    set instance[index] = this
                    if (index == 0) then
                        call TimerStart(thistype.timer, UPDATE_PERIOD, true, function thistype.remove)
                    endif
                    set this.duration = timeout
                else
                    static if LIBRARY.TimerUtils then
                        call TimerStart(NewTimerEx(this), timeout, false, function $HANDLE$timed.remove)
                    else
                        local timer t = CreateTimer()
                        call SaveInteger(thistype.table, 0, GetHandleId(t), this)
                        call TimerStart(t, timeout, false, function $HANDLE$Timed.remove)
                        set t = null
                    endif
                endif  
                
                set this.$HANDLE$_var = h
                
                return this
            endmethod
            
        endstruct
        
        function $DESTROY$Timed takes $HANDLE$ h, real duration returns $HANDLE$Timed
            return $HANDLE$Timed.create(h, duration)
        endfunction
        
        function Get$HANDLE$TimedTimerHandleId takes nothing returns integer
            static if SINGLE_TIMER then
                return GetHandleId($HANDLE$Timed.timer)
            else
                return 0
            endif
        endfunction

    //! endtextmacro
    
endlibrary
