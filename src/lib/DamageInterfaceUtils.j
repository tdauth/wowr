library DamageInterfaceUtils requires Evasion, CriticalStrike, LifeSteal, SpellPower, SpellVamp
    /* ------- Utility Library for all the Damage Interface Custom Events ------- */
    /* ---------------------------- v2.4 by Chopinski --------------------------- */
    // JASS API:
    //     Evasion System:
    //         function UnitAddEvasionChanceTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to a unit Evasion chance the specified amount for a given period
    
    //         function UnitAddMissChanceTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to a unit Miss chance the specified amount for a given period

    //     Critical Strike System:
    //         function UnitAddCriticalStrikeTimed takes unit u, real chance, real multiplier, real duration returns nothing
    //             -> Adds the specified values of chance and multiplier to a unit for a given period
        
    //         function UnitAddCriticalChanceTimed takes unit u, real chance, real duration returns nothing
    //             -> Adds the specified values of critical chance to a unit for a given period
        
    //         function UnitAddCriticalMultiplierTimed takes unit u, real multiplier, real duration returns nothing
    //             -> Adds the specified values of critical multiplier to a unit for a given period

    //     Spell Power System:
    //         function UnitAddSpellPowerFlatTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to the Flat amount of Spell Power of a unit for a given period

    //         function UnitAddSpellPowerPercentTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to the Percent amount of Spell Power of a unit for a given period

    //         function AbilitySpellDamage takes unit u, integer abilityId, abilityreallevelfield field returns string
    //             -> Given an ability field, will return a string that represents the damage that would be dealt
    //             taking into consideration the spell power bonusses of a unit.

    //         function AbilitySpellDamageEx takes real amount, unit u returns string
    //             -> Similar to GetSpellDamage will return the damage that would be dealt but as a string

    //     Life Steal System:
    //         function UnitAddLifeStealTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to the Life Steal amount of a unit the given amount for a given period

    //     Spell Vamp System:
    //         function UnitAddSpellVampTimed takes unit u, real amount, real duration returns nothing
    //             -> Add to the Spell Vamp amount of a unit the given amount for a given period
    /* ----------------------------------- END ---------------------------------- */
    
    /* -------------------------------------------------------------------------- */
    /*                                Evasion utils                               */
    /* -------------------------------------------------------------------------- */
    private struct EvasionUtils extends Evasion
        static thistype array data
        static integer        didx  = -1
        static timer          timer = CreateTimer()

        unit    unit
        real    amount
        real    ticks
        boolean type

        method remove takes integer i returns integer
            if type then
                call setEvasionChance(unit, getEvasionChance(unit) - amount)
            else
                call setMissChance(unit, getMissChance(unit) - amount)
            endif

            set data[i] = data[didx]
            set didx    = didx - 1
            set unit    = null
            set ticks   = 0

            if didx == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
            
            loop
                exitwhen i > didx
                    set this = data[i]

                    if ticks <= 0 then
                        set i = remove(i)
                    endif
                    set ticks = ticks - 1
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration, boolean evasion returns nothing 
            local thistype this = thistype.allocate()

            set .unit      = u
            set .amount    = amount
            set .ticks     = duration/0.03125000
            set .type      = evasion
            set didx       = didx + 1
            set data[didx] = this

            if type then
                call setEvasionChance(u, getEvasionChance(u) + amount)
            else
                call setMissChance(u, getMissChance(u) + amount)
            endif
            
            if didx == 0 then
                call TimerStart(timer, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct

    /* -------------------------------------------------------------------------- */
    /*                            Critical Strike Utils                           */
    /* -------------------------------------------------------------------------- */
    //region Critical Strike
    private struct CriticalUtils extends Critical
        static thistype array data
        static integer        didx  = -1
        static timer          timer = CreateTimer()

        unit    unit
        real    crit
        real    multi
        real    ticks
        integer type

        method remove takes integer i returns integer
            if type == 0 then
                call add(unit, -crit, -multi)
            elseif type == 1 then
                call setChance(unit, getChance(unit) - crit)
            else
                call setMultiplier(unit, getMultiplier(unit) - multi)
            endif

            set data[i] = data[didx]
            set didx    = didx - 1
            set unit    = null
            set ticks   = 0

            if didx == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
            
            loop
                exitwhen i > didx
                    set this = data[i]

                    if ticks <= 0 then
                        set i = remove(i)
                    endif
                    set ticks = ticks - 1
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real chance, real multiplier, real duration, integer types returns nothing 
            local thistype this = thistype.allocate()

            set .unit      = u
            set .crit      = chance
            set .multi     = multiplier
            set .ticks     = duration/0.03125000
            set .type      = types
            set didx       = didx + 1
            set data[didx] = this

            if types == 0 then
                call add(u, crit, multi)
            elseif types == 1 then
                call setChance(u, getChance(u) + crit)
            else
                call setMultiplier(u, getMultiplier(u) + multi)
            endif
            
            if didx == 0 then
                call TimerStart(timer, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct
    //endregion

    /* -------------------------------------------------------------------------- */
    /*                              Spell Power Utils                             */
    /* -------------------------------------------------------------------------- */
    //region Spell Power
    private struct SpellPowerUtils extends SpellPower
        static thistype array data
        static integer        didx  = -1
        static timer          timer = CreateTimer()

        unit    unit
        real    amount
        real    ticks
        boolean isFlat

        method remove takes integer i returns integer
            if isFlat then
                call setFlat(unit, getFlat(unit) - amount)
            else
                call setPercent(unit, getPercent(unit) - amount)
            endif

            set data[i] = data[didx]
            set didx    = didx - 1
            set unit    = null
            set ticks   = 0

            if didx == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
            
            loop
                exitwhen i > didx
                    set this = data[i]

                    if ticks <= 0 then
                        set i = remove(i)
                    endif
                    set ticks = ticks - 1
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration, boolean isFlat returns nothing 
            local thistype this = thistype.allocate()

            set .unit      = u
            set .amount    = amount
            set .ticks     = duration/0.03125000
            set .isFlat    = isFlat
            set didx       = didx + 1
            set data[didx] = this

            if isFlat then
                call setFlat(u, getFlat(u) + amount)
            else
                call setPercent(u, getPercent(u) + amount)
            endif
            
            if didx == 0 then
                call TimerStart(timer, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct
    //endregion

    /* -------------------------------------------------------------------------- */
    /*                              Life Steal Utils                              */
    /* -------------------------------------------------------------------------- */
    //region Life Steal
    private struct LifeStealUtils extends LifeSteal
        static thistype array data
        static integer        didx  = -1
        static timer          timer = CreateTimer()

        unit unit
        real lifeSteal
        real ticks

        method remove takes integer i returns integer
            call Set(unit, Get(unit) - lifeSteal)

            set data[i] = data[didx]
            set didx    = didx - 1
            set unit    = null
            set ticks   = 0

            if didx == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
            
            loop
                exitwhen i > didx
                    set this = data[i]

                    if ticks <= 0 then
                        set i = remove(i)
                    endif
                    set ticks = ticks - 1
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration returns nothing
            local thistype this = thistype.allocate()

            set .unit      = u
            set .lifeSteal = amount
            set .ticks     = duration/0.03125000
            set didx       = didx + 1
            set data[didx] = this

            call Set(u, Get(u) + lifeSteal)
            
            if didx == 0 then
                call TimerStart(timer, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct
    //endregion

    /* -------------------------------------------------------------------------- */
    /*                              Spell Vamp Utils                              */
    /* -------------------------------------------------------------------------- */
    //region Spell Vamp
    private struct SpellVampUtils extends SpellVamp
        static thistype array data
        static integer        didx  = -1
        static timer          timer = CreateTimer()

        unit unit
        real spellVamp
        real ticks

        method remove takes integer i returns integer
            call Set(unit, Get(unit) - spellVamp)

            set data[i] = data[didx]
            set didx    = didx - 1
            set unit    = null
            set ticks   = 0

            if didx == -1 then
                call PauseTimer(timer)
            endif

            call deallocate()

            return i - 1
        endmethod

        static method onPeriod takes nothing returns nothing
            local integer  i = 0
            local thistype this
           
            loop
                exitwhen i > didx
                    set this = data[i]

                    if ticks <= 0 then
                        set i = remove(i)
                    endif
                    set ticks = ticks - 1
                set i = i + 1
            endloop
        endmethod

        static method addTimed takes unit u, real amount, real duration returns nothing
            local thistype this = thistype.allocate()

            set .unit      = u
            set .spellVamp = amount
            set .ticks     = duration/0.03125000
            set didx       = didx + 1
            set data[didx] = this

            call Set(u, Get(u) + spellVamp)
           
            if didx == 0 then
                call TimerStart(timer, 0.03125000, true, function thistype.onPeriod)
            endif
        endmethod
    endstruct

    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function UnitAddEvasionChanceTimed takes unit u, real amount, real duration returns nothing
        call EvasionUtils.addTimed(u, amount, duration, true)
    endfunction

    function UnitAddMissChanceTimed takes unit u, real amount, real duration returns nothing
        call EvasionUtils.addTimed(u, amount, duration, false)
    endfunction

    function UnitAddCriticalStrikeTimed takes unit u, real chance, real multiplier, real duration returns nothing
        call CriticalUtils.addTimed(u, chance, multiplier, duration, 0)
    endfunction

    function UnitAddCriticalChanceTimed takes unit u, real chance, real duration returns nothing
        call CriticalUtils.addTimed(u, chance, 0, duration, 1)
    endfunction

    function UnitAddCriticalMultiplierTimed takes unit u, real multiplier, real duration returns nothing
        call CriticalUtils.addTimed(u, 0, multiplier, duration, 2)
    endfunction

    function UnitAddSpellPowerFlatTimed takes unit u, real amount, real duration returns nothing
        call SpellPowerUtils.addTimed(u, amount, duration, true)
    endfunction

    function UnitAddSpellPowerPercentTimed takes unit u, real amount, real duration returns nothing
        call SpellPowerUtils.addTimed(u, amount, duration, false)
    endfunction

    function AbilitySpellDamage takes unit u, integer abilityId, abilityreallevelfield field returns string
        return I2S(R2I((BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilityId), field, GetUnitAbilityLevel(u, abilityId) - 1) + SpellPower.getFlat(u)) * (1 + SpellPower.getPercent(u))))
    endfunction

    function AbilitySpellDamageEx takes real amount, unit u returns string
        return I2S(R2I((amount + SpellPower.getFlat(u)) * (1 + SpellPower.getPercent(u))))
    endfunction

    function UnitAddLifeStealTimed takes unit u, real amount, real duration returns nothing
        call LifeStealUtils.addTimed(u, amount, duration)
    endfunction

    function UnitAddSpellVampTimed takes unit u, real amount, real duration returns nothing
        call SpellVampUtils.addTimed(u, amount, duration)
    endfunction
endlibrary
