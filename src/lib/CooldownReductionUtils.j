library CooldownReductionUtils requires CooldownReduction
    /* --------------- Cooldown Reduction Utils v1.9 by Chopinski --------------- */
    // Intro
    //     Utility Library that include a few extra functions to deal with 
    //     Cooldown Reduction

    // JASS API
    //     function UnitAddCooldownReductionTimed takes unit u, real value, real duration returns nothing
    //         -> Add to the amount of cdr of a unit for a given duration. Accepts positive and negative values. 
    //         -> It handles removing the bonus automatically
    
    //     function UnitAddCooldownReductionFlatTimed takes unit u, real value, real duration returns nothing
    //         -> Add to the amount of cdr flat of a unit for a given period. Accepts positive and negative values.
    //         -> It handles removing the bonus automatically
    
    //     function UnitAddCooldownOffsetTimed takes unit u, real value, real duration returns nothing
    //         -> Add to the amount of cdr offset of a unit for a given period. Accepts positive and negative values.
    //         -> It handles removing the bonus automatically
        
    //     function GetUnitCooldownReductionEx takes unit u returns string
    //         -> Returns the amount of cdr a unit has as a string factored by 100
    //         -> example of return: 10.50 -> 0.105 internally.
    
    //     function GetUnitCooldownReductionFlatEx takes unit u returns string
    //         -> Returns the amount of cdr flat a unit has as a string factored by 100
    //         -> example of return: 10.50 -> 0.105 internally.
    
    //     function GetUnitCooldownOffsetEx takes unit u returns string
    //         -> Returns the amount of cdr offset a unit has as a string
    
    //     function GetAbilityTable takes nothing returns hashtable
    //         -> Returns the hashtable that holds the units default cooldown reduction values. 
    //         -> Use with caution! you might break stuff
    /* ----------------------------------- END ---------------------------------- */
    
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    private struct CDRUtils extends CDR
        static timer t = CreateTimer()
        //----------------------------------------------
        static integer didx = -1
        static thistype array data
        //----------------------------------------------

        unit    u
        real    ticks
        real    amount
        integer tipo

        method destroy takes nothing returns nothing
            if didx == -1 then
                call PauseTimer(t)
            endif

            set .u     = null
            set .ticks = 0
            call .deallocate()
        endmethod

        private static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
            
            loop
                exitwhen i > didx
                    set this   = data[i]
                    set .ticks = .ticks - 1

                    if .ticks <= 0 then
                        if .tipo == 0 then
                            call remove(.u, .amount)
                        elseif .tipo == 1 then
                            call Set(.u, get(.u, 1) - .amount, 1)
                        else
                            call Set(.u, get(.u, 2) - .amount, 2)
                        endif

                        set  data[i] = data[didx]
                        set  didx    = didx - 1
                        set  i 		 = i - 1
                        call .destroy()
                    endif
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration, integer tipo returns nothing
            local thistype this = thistype.allocate()

            set .u          = u
            set .amount     = amount
            set .tipo       = tipo
            set .ticks      = duration/0.03125000
            set didx        = didx + 1
            set data[didx]  = this

            if tipo == 0 then
                call add(u, amount)
            elseif tipo == 1 then
                call Set(u, get(u, 1) + amount, 1)
            else
                call Set(u, get(u, 2) + amount, 2)
            endif
            
            if didx == 0 then
                call TimerStart(t, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct

    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function UnitAddCooldownReductionTimed takes unit u, real value, real duration returns nothing
        call CDRUtils.addTimed(u, value, duration, 0)
    endfunction

    function UnitAddCooldownReductionFlatTimed takes unit u, real value, real duration returns nothing
        call CDRUtils.addTimed(u, value, duration, 1)
    endfunction

    function UnitAddCooldownOffsetTimed takes unit u, real value, real duration returns nothing
        call CDRUtils.addTimed(u, value, duration, 2)
    endfunction

    function GetUnitCooldownReductionEx takes unit u returns string
        return R2SW(CDRUtils.get(u, 0)*100, 1, 2)
    endfunction

    function GetUnitCooldownReductionFlatEx takes unit u returns string
        return R2SW(CDRUtils.get(u, 1)*100, 1, 2)
    endfunction

    function GetUnitCooldownOffsetEx takes unit u returns string
        return R2SW(CDRUtils.get(u, 2), 1, 2)
    endfunction

    function GetAbilityTable takes nothing returns hashtable
        return CDR.hashtable
    endfunction
    
    public function GetTimerHandleId takes nothing returns integer
        return GetHandleId(CDRUtils.t)
    endfunction
endlibrary
