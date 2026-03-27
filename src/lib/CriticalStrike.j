library CriticalStrike requires DamageInterface optional Evasion
    /* ------------------------ CriticalStrike v2.4 by Chopinski ----------------------- */
    // CriticalStrike implements an easy way to register and detect a custom critical event.
    // allows the manipulation of a unit critical strike chance and multiplier, as well as
    // manipulating the critical damage dealt.

    // It works by monitoring custom critical strike chance and multiplier values given to units.

    // It will only detect custom critical strikes, so all critical chance given to a
    // unit must be done so using the public API provided by this system.

    // *CriticalStrike requires DamageInterface. Do not use TriggerSleepAction() with Evasion.
    // It also requires optional Evasion so that this library is written after the Evasion
    // library, so both custom events will not fire at the same time.

    // The API:
    //     function RegisterCriticalStrikeEvent(function YourFunction)
    //         -> YourFunction will run when a unit hits a critical strike.

    //     function GetCriticalSource takes nothing returns unit
    //         -> Returns the unit hitting a critical strike.
    
    //     function GetCriticalTarget takes nothing returns unit
    //         -> Returns the unit being hit by a critical strike.
    
    //     function GetCriticalDamage takes nothing returns real
    //         -> Returns the critical strike damage amount.
    
    //     function GetUnitCriticalChance takes unit u returns real
    //         -> Returns the chance to hit a critical strike to specified unit.
    
    //     function GetUnitCriticalMultiplier takes unit u returns real
    //         -> Returns the chance to hit a critical strike to specified unit.
    
    //     function SetUnitCriticalChance takes unit u, real value returns nothing
    //         -> Set's the unit chance to hit a critical strike to specified value.
    //         -> 15.0 = 15%
    
    //     function SetUnitCriticalMultiplier takes unit u, real value returns nothing
    //         -> Set's the unit multiplier of damage when hitting a critical to value
    //         -> 1.0 = increases the multiplier by 1. all units have a multiplier of 1.0
    //             by default, so by adding 1.0, for example, the critical damage will be 
    //             2x the normal damage

    //     function SetCriticalEventDamage takes real newValue returns nothing
    //         -> Modify the critical damage dealt to the specified value.
    
    //     function UnitAddCriticalStrike takes unit u, real chance, real multiplier returns nothing
    //         -> Adds the specified values of chance and multiplier to a unit
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct Critical
        static constant real    TEXT_SIZE = 0.016
        readonly static trigger trigger = CreateTrigger()
        static Unit             source
        static Unit             target
        static real             damage
        static real array       chance
        static real array       multiplier

        static method getChance takes unit u returns real
            return chance[GetUnitUserData(u)]
        endmethod

        static method getMultiplier takes unit u returns real
            return multiplier[GetUnitUserData(u)]
        endmethod

        static method setChance takes unit u, real value returns nothing
            set chance[GetUnitUserData(u)] = value
        endmethod

        static method setMultiplier takes unit u, real value returns nothing
            set multiplier[GetUnitUserData(u)] = value
        endmethod

        static method add takes unit u, real chance, real multuplier returns nothing
            call setChance(u, getChance(u) + chance)
            call setMultiplier(u, getMultiplier(u) + multuplier)
        endmethod

        static method text takes unit whichUnit, string text, real duration, integer red, integer green, integer blue, integer alpha returns nothing
            local texttag tx = CreateTextTag()
            
            call SetTextTagText(tx, text, TEXT_SIZE)
            call SetTextTagPosUnit(tx, whichUnit, 0)
            call SetTextTagColor(tx, red, green, blue, alpha)
            call SetTextTagLifespan(tx, duration)
            call SetTextTagVelocity(tx, 0.0, 0.0355)
            call SetTextTagPermanent(tx, false)
            
            set tx = null
        endmethod

        static method onDamage takes nothing returns nothing
            local real amount = GetEventDamage()
        
            if amount > 0 and GetRandomReal(0, 100) <= chance[Damage.source.id] and Damage.isEnemy and not Damage.target.isStructure and multiplier[Damage.source.id] > 0 then
                set source = Damage.source
                set target = Damage.target
                set damage = amount*(1 + multiplier[Damage.source.id])

                call TriggerEvaluate(trigger)
                call BlzSetEventDamage(damage)
                if damage > 0 then
                    call text(target.unit, (I2S(R2I(damage)) + "!"), 1.5, 255, 0, 0, 255)
                endif

                set damage = 0
                set source = 0
                set target = 0
            endif
        endmethod

        static method register takes code c returns nothing
            call TriggerAddCondition(trigger, Filter(c))
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterAttackDamageEvent(function thistype.onDamage)
        endmethod
    endstruct
    
    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function RegisterCriticalStrikeEvent takes code c returns nothing
        call Critical.register(c)
    endfunction

    function GetCriticalSource takes nothing returns unit
        return Critical.source.unit
    endfunction

    function GetCriticalTarget takes nothing returns unit
        return Critical.target.unit
    endfunction

    function GetCriticalDamage takes nothing returns real
        return Critical.damage
    endfunction

    function GetUnitCriticalChance takes unit u returns real
        return Critical.getChance(u)
    endfunction

    function GetUnitCriticalMultiplier takes unit u returns real
        return Critical.getMultiplier(u)
    endfunction

    function SetUnitCriticalChance takes unit u, real value returns nothing
        call Critical.setChance(u, value)
    endfunction

    function SetUnitCriticalMultiplier takes unit u, real value returns nothing
        call Critical.setMultiplier(u, value)
    endfunction

    function SetCriticalEventDamage takes real newValue returns nothing
        set Critical.damage = newValue
    endfunction

    function UnitAddCriticalStrike takes unit u, real chance, real multiplier returns nothing
        call Critical.add(u, chance, multiplier)
    endfunction
endlibrary
