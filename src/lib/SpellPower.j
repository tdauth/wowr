library SpellPower requires DamageInterface
    /* ------------------------ SpellPower v2.4 by Chopinski ----------------------- */
    // SpellPower intends to simulate a system similiar to Ability Power from LoL or
    // Spell Amplification from Dota 2.

    // Whenever a units deals Spell damage, that dealt damage will be amplified by a flat
    // and percentile amount that represents a unit spell power bonus.

    // The formula for amplification is: 
    // final damage = (initial damage + flat bonus) * (1 + percent bonus)
    // for percent bonus: 0.1 = 10% bonus

    // *SpellPower requires DamageInterface. Do not use TriggerSleepAction() within triggers.

    // The API:
    //     function GetUnitSpellPowerFlat takes unit u returns real
    //         -> Returns the Flat bonus of spell power of a unit

    //     function GetUnitSpellPowerPercent takes unit u returns real
    //         -> Returns the Percent bonus of spell power of a unit

    //     function SetUnitSpellPowerFlat takes unit u, real value returns nothing
    //         -> Set's the Flat amount of Spell Power of a unit

    //     function SetUnitSpellPowerPercent takes unit u, real value returns nothing
    //         -> Set's the Flat amount of Spell Power of a unit

    //     function UnitAddSpellPowerFlat takes unit u, real amount returns nothing
    //         -> Add to the Flat amount of Spell Power of a unit

    //     function UnitAddSpellPowerPercent takes unit u, real amount returns nothing
    //         -> Add to the Percent amount of Spell Power of a unit

    //     function GetSpellDamage takes real amount, unit u returns real
    //         -> Returns the amount of spell damage that would be dealt given an initial damage
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct SpellPower
        static real array flat
        static real array percent

        static method getFlat takes unit u returns real
            return flat[GetUnitUserData(u)]
        endmethod

        static method getPercent takes unit u returns real
            return percent[GetUnitUserData(u)]
        endmethod

        static method setFlat takes unit u, real value returns nothing
            set flat[GetUnitUserData(u)] = value
        endmethod

        static method setPercent takes unit u, real value returns nothing
            set percent[GetUnitUserData(u)] = value
        endmethod

        static method onDamage takes nothing returns nothing
            local real damage = GetEventDamage()
        
            if damage > 0 then
                call BlzSetEventDamage((damage + flat[Damage.source.id])*(1 + percent[Damage.source.id]))
            endif
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterSpellDamageEvent(function thistype.onDamage)
        endmethod
    endstruct
    
    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function GetUnitSpellPowerFlat takes unit u returns real
        return SpellPower.getFlat(u)
    endfunction

    function GetUnitSpellPowerPercent takes unit u returns real
        return SpellPower.getPercent(u)
    endfunction

    function SetUnitSpellPowerFlat takes unit u, real value returns nothing
        call SpellPower.setFlat(u, value)
    endfunction

    function SetUnitSpellPowerPercent takes unit u, real value returns nothing
        call SpellPower.setPercent(u, value)
    endfunction

    function UnitAddSpellPowerFlat takes unit u, real amount returns nothing
        call SpellPower.setFlat(u, SpellPower.getFlat(u) + amount)
    endfunction

    function UnitAddSpellPowerPercent takes unit u, real amount returns nothing
        call SpellPower.setPercent(u, SpellPower.getPercent(u) + amount)
    endfunction

    function GetSpellDamage takes real amount, unit u returns real
        return ((amount + SpellPower.getFlat(u))*(1 + SpellPower.getPercent(u)))
    endfunction
endlibrary
