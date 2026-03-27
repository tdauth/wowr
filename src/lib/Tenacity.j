library Tenacity requires Indexer, Alloc
    /* ---------------------------------------- Tenacity v1.0 --------------------------------------- */
    // Intro
    //      This library intension in to introduce to warcraft an easy way to 
    //      manipulate the duration of crowd control on units.
    //
    // How it Works?
    //      Working in conjuction with the Crowd Control Library this library allows you to control the 
    //      duration of disables provided in the Crowd Control library. It work similar to the Tenacity
    //      status in League of Legends or the Status Resistence in Dota 2.
    //
    //      The are basically 3 types of tenacity: Normal (stacks multiplicatively), 
    //      Flat and Offset (stacks additively).The formula for calculation is:
    //          newDuration = (duration - Offset) * [(1 - value1)*(1 - value2)*...] * (1 - Flat)
    //
    //      The system also allow negative values for Tenacity, resulting in increased
    //      crowd control duration. Also note that tenacity will only work on CC applied through
    //      the Crowd Control API
    //
    // How to Import
    //      1. Copy the Indexer and Alloc libraries into your map
    //      2. Copy this library into your map and you are done
    /* ---------------------------------------- By Chopinski ---------------------------------------- */

    /* ---------------------------------------------------------------------------------------------- */
    /*                                            JASS API                                            */
    /* ---------------------------------------------------------------------------------------------- */
    function GetUnitTenacity takes unit u returns real
        return Tenacity.get(u, 0)
    endfunction

    function GetUnitTenacityFlat takes unit u returns real
        return Tenacity.get(u, 1)
    endfunction

    function GetUnitTenacityOffset takes unit u returns real
        return Tenacity.get(u, 2)
    endfunction

    function SetUnitTenacity takes unit u, real value returns nothing
        call Tenacity.Set(u, value, 0)
    endfunction

    function SetUnitTenacityFlat takes unit u, real value returns nothing
        call Tenacity.Set(u, value, 1)
    endfunction

    function SetUnitTenacityOffset takes unit u, real value returns nothing
        call Tenacity.Set(u, value, 2)
    endfunction

    function UnitAddTenacity takes unit u, real value returns nothing
        call Tenacity.add(u, value, 0)
    endfunction

    function UnitAddTenacityFlat takes unit u, real value returns nothing
        call Tenacity.add(u, value, 1)
    endfunction

    function UnitAddTenacityOffset takes unit u, real value returns nothing
        call Tenacity.add(u, value, 2)
    endfunction

    function UnitRemoveTenacity takes unit u, real value returns nothing
        call Tenacity.remove(u, value)
    endfunction

    function GetTenacityDuration takes unit u, real duration returns real
        return Tenacity.calculate(u, duration)
    endfunction 
    
    function RegisterTenacityUnit takes unit u returns Tenacity
        return Tenacity.register(u)
    endfunction

    function DisplayTenacityStatus takes unit u returns nothing
        call Tenacity.print(u)
    endfunction

    /* ---------------------------------------------------------------------------------------------- */
    /*                                             System                                             */
    /* ---------------------------------------------------------------------------------------------- */
    private module ListModule
        readonly thistype next
        readonly thistype prev

        method init takes nothing returns thistype
            set next = this
            set prev = this

            return this
        endmethod

        method push takes thistype node returns thistype
            set node.prev = prev
            set node.next = this
            set prev.next = node
            set prev = node

            return node
        endmethod

        method pop takes nothing returns nothing
            set prev.next = next
            set next.prev = prev
        endmethod
    endmodule
    
    private struct List extends array
        implement Alloc
        implement ListModule

        real tenacity
        real value
        integer size

        method destroy takes nothing returns nothing
            local thistype node = this.next
            
            loop
                exitwhen node == this
                    set node.value = 0
                    call node.pop()
                    call node.deallocate()
                set node = node.next
            endloop

            call deallocate()
        endmethod

        method insert takes real value returns thistype
            local thistype node = push(allocate())

            set node.value = value
            set size = size + 1
            call update()

            return node
        endmethod

        method remove takes real value returns nothing
            local thistype node = this.next
        
            loop
                exitwhen node == this
                    if node.value == value then
                        set size = size - 1
                        call node.pop()
                        call node.deallocate()
                        exitwhen true
                    endif
                set node = node.next
            endloop

            call update()
        endmethod

        method update takes nothing returns nothing
            local thistype node = this.next
            local integer i = 0

            if size > 0 then
                loop
                    exitwhen node == this
                        if i > 0 then
                            set tenacity = tenacity * (1 - node.value) 
                        else
                            set tenacity = 1 - node.value
                        endif
                        set i = i + 1
                    set node = node.next
                endloop
            endif
        endmethod

        static method create takes nothing returns thistype
            local thistype this = thistype(allocate()).init()

            set size = 0
            set tenacity = 0
            
            return this
        endmethod
    endstruct

    struct Tenacity
        private static thistype array struct

        private List list
        private real flat
        private real offset

        static method get takes unit source, integer types returns real
            local integer id = GetUnitUserData(source)
            local thistype this

            if struct[id] != 0 then
                set this = struct[id]
                
                if types == 0 then
                    if list.size > 0 then
                        return 1 - list.tenacity
                    else
                        return 0.
                    endif
                elseif types == 1 then
                    return flat
                else
                    return offset
                endif
            endif

            return 0.
        endmethod

        static method Set takes unit source, real value, integer types returns nothing
            local integer id = GetUnitUserData(source)
            local thistype this

            if struct[id] == 0 then
                set this = register(source)
            else
                set this = struct[id]
            endif

            if types == 0 then
                set list.tenacity = value
            elseif types == 1 then
                set flat = value
            else
                set offset = value
            endif
        endmethod

        static method add takes unit source, real value, integer types returns nothing
            local integer id = GetUnitUserData(source)
            local thistype this

            if value != 0 then
                if struct[id] == 0 then
                    set this = register(source)
                else
                    set this = struct[id]
                endif

                if types == 0 then
                    call list.insert(value)
                elseif types == 1 then
                    set flat = flat + value
                else
                    set offset = offset + value
                endif
            endif
        endmethod

        static method remove takes unit source, real value returns nothing
            local integer id = GetUnitUserData(source)
            local thistype this

            if value != 0 and struct[id] != 0 then
                set this = struct[id]
                call list.remove(value)
            endif
        endmethod

        static method calculate takes unit source, real duration returns real
            local integer id = GetUnitUserData(source)
            local thistype this

            if duration != 0 and struct[id] != 0 then
                set this = struct[id]

                if list.size > 0 then
                    set duration = (duration - offset) * list.tenacity * (1 - flat)
                else
                    set duration = (duration - offset) * (1 - flat)
                endif
                
                if duration <= 0 then
                    return 0.
                endif

                return duration
            endif

            return duration
        endmethod

        static method register takes unit source returns thistype
            local integer id = GetUnitUserData(source)
            local thistype this

            if struct[id] == 0 then
                set this = thistype.allocate()
                set list = List.create()
                set flat = 0
                set offset = 0
                set struct[GetUnitUserData(source)] = this
            endif

            return this
        endmethod

        static method print takes unit source returns nothing
            local integer id = GetUnitUserData(source)
            local thistype this
            local List node
            local integer i = 0
            local real array bonus

            if struct[id] != 0 then
                set this = struct[id]

                if list.size > 0 then
                    set node = list.next

                    loop
                        exitwhen node == list
                            set bonus[i] = node.value
                            set i = i + 1
                        set node = node.next
                    endloop
                endif

                call ClearTextMessages()
                call BJDebugMsg("Tenacity Status for " + GetUnitName(source))
                call BJDebugMsg("Tenacity List [" + R2S(bonus[0]) + " | " + R2S(bonus[1]) + " | " + R2S(bonus[2]) + " | " + R2S(bonus[3]) + " | " + R2S(bonus[4]) + " | " + R2S(bonus[5]) + " | ...] = " + R2S(get(source, 0)))
                call BJDebugMsg("Tenacity Flat [" + R2S(get(source, 1)) + "]")
                call BJDebugMsg("Tenacity Offset [" + R2S(get(source, 2)) + "]")
            endif
        endmethod

        private static method onDeindex takes nothing returns nothing
            local unit source = GetIndexUnit()
            local integer id = GetUnitUserData(source)
            local thistype this

            if struct[id] != 0 then
                set this = struct[id]
                
                call list.destroy()
                call deallocate()

                set struct[id] = 0
            endif
        endmethod

        private static method onInit takes nothing returns nothing
            call RegisterUnitDeindexEvent(function thistype.onDeindex)
        endmethod
    endstruct
endlibrary
