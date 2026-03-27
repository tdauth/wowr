library TenacityUtils requires Tenacity
    /* ------------------------------------- Tenacity Utils v1.0 ------------------------------------ */
    // Utility Library that include a few extra functions to deal with Tenacity
    /* ---------------------------------------- By Chopinski ---------------------------------------- */

    /* ---------------------------------------------------------------------------------------------- */
    /*                                            JASS API                                            */
    /* ---------------------------------------------------------------------------------------------- */
    function UnitAddTenacityTimed takes unit u, real value, real duration returns nothing
        call TenacityUtils.addTimed(u, value, duration, 0)
    endfunction

    function UnitAddTenacityFlatTimed takes unit u, real value, real duration returns nothing
        call TenacityUtils.addTimed(u, value, duration, 1)
    endfunction

    function UnitAddTenacityOffsetTimed takes unit u, real value, real duration returns nothing
        call TenacityUtils.addTimed(u, value, duration, 2)
    endfunction

    /* ---------------------------------------------------------------------------------------------- */
    /*                                             System                                             */
    /* ---------------------------------------------------------------------------------------------- */
    struct TenacityUtils extends Tenacity
        private static timer timer = CreateTimer()
        private static thistype array array
        private static integer key = -1
        private static real period = 0.03125000

        private unit unit
        private real value
        private integer type
        private real duration

        private method destroy takes nothing returns nothing
            if key == -1 then
                call PauseTimer(timer)
            endif

            set unit = null
            call deallocate()
        endmethod

        private static method onPeriod takes nothing returns nothing
            local thistype this
            local integer i = 0
            
            loop
                exitwhen i > key
                    set this = array[i]

                    if duration <= 0 then
                        if type == 0 then
                            call remove(unit, value)
                        else
                            call add(unit, -value, type)
                        endif

                        set array[i] = array[key]
                        set key = key - 1
                        set i = i - 1
                        call destroy()
                    endif
                    set duration = duration - period
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration, integer types returns nothing
            local thistype this = thistype.allocate()

            set unit = u
            set value = amount
            set type = types
            set .duration = duration
            set key = key + 1
            set array[key] = this

            call add(unit, value, type)
            
            if key == 0 then
                call TimerStart(timer, period, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct
endlibrary
