library CooldownReduction requires RegisterPlayerUnitEvent, Table, Alloc, Indexer
/* ------------------ Cooldown Reduction v1.9 by Chopinski ------------------ */
    // Intro
    //     This library intension in to introduce to warcraft an easy way to 
    //     manipulate abilities cooldowns based on a cooldown reduction value that
    //     is unique for each unit.

    // How it Works?
    //     When casting an ability, its "new" cooldown is calculated based on the 
    //     amount of cooldown reduction of the casting unit. the formula for 
    //     calculation is:
    //         Cooldown = (Default Cooldown - Cooldown Offset) * [(1 - source1)*(1 - source2)*...] * (1 - Cooldown Reduction Flat)

    //     The system also allow negative values for CDR, resulting in increased
    //     ability cooldown.

    //     It does not acumulate because the abilities are registered automatically
    //     on the first cast, saving its base cooldown (Object Editor values) and 
    //     always using this base value for calculation, so you can still edit 
    //     the ability via the editor and the system takes care of the rest.

    // How to Import
    //     simply copy the CooldownReduction folder over to your map, and start 
    //     use the API functions

    // Requirements
    //     CooldownReduction requires RegisterPlayerUnitEvent, Alloc and a Unit Indexer.
    //     Credits to Magtheridon96 for RegisterPlayerUnitEvent and to Bribe for
    //     the UnitIndexer. It also requires patch 1.31+.

    //     RegisterPlayerUnitEvent: www.hiveworkshop.com/threads/snippet-registerplayerunitevent.203338/
    //     UnitIndexer: www.hiveworkshop.com/threads/gui-unit-indexer-1-4-0-0.197329/#resource-45899
    //     Alloc: www.hiveworkshop.com/threads/snippet-alloc.192348/
    /* ----------------------------------- END ---------------------------------- */
    
    /* -------------------------------------------------------------------------- */
    /*                                Configuration                               */
    /* -------------------------------------------------------------------------- */
    // Use this function to filter out units you dont want to have abilities registered.
    // By default dummy units do not trigger the system.
    private function UnitFilter takes unit source returns boolean
        return GetUnitAbilityLevel(source, 'Aloc') == 0
    endfunction
    
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    private module List
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
    
    private struct AbilityList extends array
        implement Alloc
        implement List
        
        unit unit
        ability ability
        Table defaults
        integer id
        integer levels
        
        method destroy takes nothing returns nothing
            local thistype node = this.next
        
            loop
                exitwhen node == this
                    set node.ability = null
                    call node.defaults.destroy()
                    call node.pop()
                    call node.deallocate()
                set node = node.next
            endloop
            call deallocate()

            set unit = null
        endmethod
        
        method insert takes integer id returns thistype
            local thistype node = push(allocate())
            local integer i = 0

            set node.id = id
            set node.ability = BlzGetUnitAbility(unit, id)
            set node.levels = BlzGetAbilityIntegerField(node.ability, ABILITY_IF_LEVELS)
            set node.defaults = Table.create()
            
            loop
                exitwhen i >= node.levels
                    set node.defaults.real[i] = BlzGetAbilityRealLevelField(node.ability, ABILITY_RLF_COOLDOWN, i)
                set i = i + 1
            endloop

            return node
        endmethod
        
        method update takes integer count, real normal, real flat, real offset returns nothing
            local thistype node = this.next
            local real cooldown
            local integer i
        
            loop
                exitwhen node == this
                    set i = 0
                    loop
                        exitwhen i >= node.levels
                            if count > 0 then
                                set cooldown = ((node.defaults.real[i] - offset) * normal * (1 - flat))
                            else
                                set cooldown = ((node.defaults.real[i] - offset) * (1 - flat))
                            endif
                            call BlzSetAbilityRealLevelField(node.ability, ABILITY_RLF_COOLDOWN, i, cooldown)
                            call IncUnitAbilityLevel(unit, node.id)
                            call DecUnitAbilityLevel(unit, node.id)
                        set i = i + 1
                    endloop
                set node = node.next
            endloop
        endmethod
        
        method calculate takes integer id, integer level, real cooldown, integer count, real normal, real flat, real offset returns nothing
            if count > 0 then
                call BlzSetAbilityRealLevelField(BlzGetUnitAbility(unit, id), ABILITY_RLF_COOLDOWN, level, ((cooldown - offset) * normal * (1 - flat)))
            else
                call BlzSetAbilityRealLevelField(BlzGetUnitAbility(unit, id), ABILITY_RLF_COOLDOWN, level, ((cooldown - offset) * (1 - flat)))
            endif
            call IncUnitAbilityLevel(unit, id)
            call DecUnitAbilityLevel(unit, id)
        endmethod
        
        method simulate takes real cooldown, integer count, real normal, real flat, real offset returns real
            local real cd
            
            if count > 0 then
                set cd = ((cooldown - offset) * normal * (1 - flat))
            else
                set cd = ((cooldown - offset) * (1 - flat))
            endif
            
            return cd
        endmethod
        
        static method create takes unit source returns thistype
            local thistype this = thistype(allocate()).init()
            
            set unit = source
            
            return this
        endmethod
    endstruct
    
    struct CDR
        readonly static hashtable hashtable = InitHashtable()
        private static AbilityList array n
        private  static integer array count
        readonly static real array normal
        readonly static real array flat
        readonly static real array offset
    
        private static method getInstance takes unit source returns AbilityList
            local integer i = GetUnitUserData(source)
            
            if n[i] == 0 then
                set n[i] = AbilityList.create(source)
            endif

            return n[i]
        endmethod
    
        private static method update takes unit u returns nothing
            local integer id = GetUnitUserData(u)
            local AbilityList list = getInstance(u)

            call list.update(count[id], normal[id], flat[id], offset[id])
        endmethod
        
        private static method calculate takes unit u returns real
            local integer idx = GetUnitUserData(u)
            local integer id = GetHandleId(u)
            local integer i = 0
            local real cdr = 0
            local real aux

            loop
                exitwhen i > count[idx]
                    set aux = LoadReal(hashtable, id, i) 
                    
                    if i > 0 then
                        set cdr = cdr * (1 - aux)
                    else
                        set cdr = 1 - aux
                    endif
                set i = i + 1
            endloop

            return cdr
        endmethod
    
        static method get takes unit u, integer types returns real
            if types == 0 then
                return normal[GetUnitUserData(u)]
            elseif types == 1 then
                return flat[GetUnitUserData(u)]
            else
                return offset[GetUnitUserData(u)]
            endif
        endmethod

        static method Set takes unit u, real value, integer types returns nothing
            if types == 0 then
                set normal[GetUnitUserData(u)] = value
            elseif types == 1 then
                set flat[GetUnitUserData(u)] = value
            else
                set offset[GetUnitUserData(u)] = value
            endif

            call update(u)
        endmethod

        static method add takes unit u, real amount returns nothing
            local integer i = GetUnitUserData(u)

            if amount != 0 then
                call SaveReal(hashtable, GetHandleId(u), count[i], amount)
                set normal[i] = calculate(u)
                set count[i] = count[i] + 1
                call update(u)
            endif
        endmethod
        
        static method remove takes unit u, real amount returns nothing
            local integer idx = GetUnitUserData(u)
            local integer id = GetHandleId(u)
            local integer i = 0
            local real aux

            if amount == 0 then
                return
            endif

            loop
                exitwhen i > count[idx] - 1
                    set aux = LoadReal(hashtable, id, i)
                    
                    if aux == amount then
                        call RemoveSavedReal(hashtable, id, i)
                        if i != count[idx] - 1 then
                            set aux = LoadReal(hashtable, id, count[idx] - 1)
                            call SaveReal(hashtable, id, i, aux)
                            call RemoveSavedReal(hashtable, id, count[idx] - 1)
                        endif
                        set count[idx] = count[idx] - 1
                        set normal[idx] = calculate(u)
                        set i = count[idx] + 1
                        call update(u)
                    else
                        set i = i + 1
                    endif
            endloop
        endmethod
    
        static method calculateCooldown takes unit u, integer id, integer level, real cooldown returns nothing
            local integer i = GetUnitUserData(u)
            local AbilityList list = getInstance(u)

            call list.calculate(id, level - 1, cooldown, count[i], normal[i], flat[i], offset[i])
        endmethod
        
        static method simulateCooldown takes unit u, real cooldown returns real
            local integer i = GetUnitUserData(u)
            local AbilityList list = getInstance(u)

            return list.simulate(cooldown, count[i], normal[i], flat[i], offset[i])
        endmethod
    
        static method register takes unit u, integer id returns nothing
            local AbilityList list
            local integer i
            
            if UnitFilter(u) then
                set list = getInstance(u)
                set i = GetUnitUserData(u)
                
                if not LoadBoolean(hashtable, list, id) then
                    call list.insert(id)
                    call SaveBoolean(hashtable, list, id, true)
                    
                    if count[i] > 0 or normal[i] != 0 or flat[i] != 0 or offset[i] != 0 then
                        call update(u)
                    endif
                endif
            endif
        endmethod
    
        private static method onCast takes nothing returns nothing
            call register(GetTriggerUnit(), GetSpellAbilityId())
        endmethod
        
        private static method onLevel takes nothing returns nothing
            call register(GetTriggerUnit(), GetLearnedSkill())
        endmethod
        
        private static method onDeindex takes nothing returns nothing
            local unit source = GetIndexUnit()
            local integer i = GetUnitUserData(source)
            local AbilityList list = getInstance(source)
            
            set n[i] = 0
            set normal[i] = 0
            set flat[i] = 0
            set offset[i] = 0
            set count[i] = 0

            if list != 0 then
                call list.destroy()
                call FlushChildHashtable(hashtable, list)
            endif
            call FlushChildHashtable(hashtable, GetHandleId(source))
        endmethod
    
        private static method onInit takes nothing returns nothing
            call RegisterUnitDeindexEvent(function thistype.onDeindex)
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, function thistype.onCast)
            call RegisterPlayerUnitEvent(EVENT_PLAYER_HERO_SKILL, function thistype.onLevel)
        endmethod
    endstruct
    
    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function GetUnitCooldownReduction takes unit u returns real
        return 1 - CDR.get(u, 0)
    endfunction

    function GetUnitCooldownReductionFlat takes unit u returns real
        return CDR.get(u, 1)
    endfunction

    function GetUnitCooldownOffset takes unit u returns real
        return CDR.get(u, 2)
    endfunction

    function SetUnitCooldownReduction takes unit u, real value returns nothing
        call CDR.Set(u, value, 0)
    endfunction

    function SetUnitCooldownReductionFlat takes unit u, real value returns nothing
        call CDR.Set(u, value, 1)
    endfunction

    function SetUnitCooldownOffset takes unit u, real value returns nothing
        call CDR.Set(u, value, 2)
    endfunction

    function UnitAddCooldownReduction takes unit u, real value returns nothing
        call CDR.add(u, value)
    endfunction

    function UnitAddCooldownReductionFlat takes unit u, real value returns nothing
        call CDR.Set(u, CDR.get(u, 1) + value, 1)
    endfunction

    function UnitAddCooldownOffset takes unit u, real value returns nothing
        call CDR.Set(u, CDR.get(u, 2) + value, 2)
    endfunction

    function UnitRemoveCooldownReduction takes unit u, real value returns nothing
        call CDR.remove(u, value)
    endfunction

    function CalculateAbilityCooldown takes unit u, integer id, integer level, real cooldown returns nothing
        call CDR.calculateCooldown(u, id, level, cooldown)
    endfunction 
    
    function SimulateAbilityCooldown takes unit u, real cooldown returns real
        return CDR.simulateCooldown(u, cooldown)
    endfunction 
    
    function RegisterAbility takes unit u, integer id returns nothing
        call CDR.register(u, id)
    endfunction
endlibrary
