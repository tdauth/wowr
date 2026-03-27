library Evasion requires DamageInterface
    /* ------------------------ Evasion v2.4 by Chopinski ----------------------- */
    // Evasion implements an easy way to register and detect a custom evasion event.

    // It works by monitoring custom evasion and missing values given to units,
    // and nulling damage when the odds given occurs.

    // It will only detect custom evasion, so all evasion or miss values given to a
    // unit must be done so using the public API provided by this system.

    // *Evasion requires DamageInterface. Do not use TriggerSleepAction() with Evasion.

    // The API:
    //     function RegisterEvasionEvent(function YourFunction)
    //         -> YourFunction will run when a unit evades an attack.

    //     function GetMissingUnit takes nothing returns unit
    //         -> Returns the unit missing the attack

    //     function GetEvadingUnit takes nothing returns unit
    //         -> Returns the unit evading the attack

    //     function GetEvadedDamage takes nothing returns real
    //         -> Returns the amount of evaded damage

    //     function GetUnitEvasionChance takes unit u returns real
    //         -> Returns this system amount of evasion chance given to a unit

    //     function GetUnitMissChance takes unit u returns real
    //         -> Returns this system amount of miss chance given to a unit

    //     function SetUnitEvasionChance takes unit u, real chance returns nothing
    //         -> Sets unit evasion chance to specified amount

    //     function SetUnitMissChance takes unit u, real chance returns nothing
    //         -> Sets unit miss chance to specified amount

    //     function UnitAddEvasionChance takes unit u, real chance returns nothing
    //         -> Add to a unit Evasion chance the specified amount

    //     function UnitAddMissChance takes unit u, real chance returns nothing
    //         -> Add to a unit Miss chance the specified amount

    //     function MakeUnitNeverMiss takes unit u, boolean flag returns nothing
    //         -> Will make a unit never miss attacks no matter the evasion chance of the attacked unit

    //     function DoUnitNeverMiss takes unit u returns boolean
    //         -> Returns true if the unit will never miss an attack
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct Evasion
        static Unit             source
        static Unit             target
        static real             damage
        static real    array    evasion
        static real    array    miss
        static integer array    neverMiss
        readonly static boolean evade     = false
        readonly static trigger trigger   = CreateTrigger()
        static constant real    TEXT_SIZE = 0.016

        static method getEvasionChance takes unit u returns real
            return evasion[GetUnitUserData(u)]
        endmethod

        static method getMissChance takes unit u returns real
            return miss[GetUnitUserData(u)]
        endmethod

        static method setEvasionChance takes unit u, real value returns nothing
            set evasion[GetUnitUserData(u)] = value
        endmethod

        static method setMissChance takes unit u, real value returns nothing
            set miss[GetUnitUserData(u)] = value
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
        
            set evade = false
            if amount > 0 and not (neverMiss[Damage.source.id] > 0) then
                set evade = GetRandomReal(0, 100) <= evasion[Damage.target.id] or GetRandomReal(0, 100) <= miss[Damage.source.id]
                if evade then
                    set source = Damage.source
                    set target = Damage.target
                    set damage = amount

                    call TriggerEvaluate(trigger)
                    call BlzSetEventDamage(0)
                    call BlzSetEventWeaponType(WEAPON_TYPE_WHOKNOWS)
                    call text(source.unit, "miss", 1.5, 255, 0, 0, 255)

                    set damage = 0
                    set source = 0
                    set target = 0
                endif
            endif
        endmethod

        static method register takes code c returns nothing
            call TriggerAddCondition(trigger, Filter(c))
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterAttackDamagingEvent(function thistype.onDamage)
        endmethod
    endstruct
    //endregion

    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function RegisterEvasionEvent takes code c returns nothing
        call Evasion.register(c)
    endfunction

    function GetMissingUnit takes nothing returns unit
        return Evasion.source.unit
    endfunction

    function GetEvadingUnit takes nothing returns unit
        return Evasion.target.unit
    endfunction

    function GetEvadedDamage takes nothing returns real
        return Evasion.damage
    endfunction

    function GetUnitEvasionChance takes unit u returns real
        return Evasion.getEvasionChance(u)
    endfunction

    function GetUnitMissChance takes unit u returns real
        return Evasion.getMissChance(u)
    endfunction

    function SetUnitEvasionChance takes unit u, real chance returns nothing
        call Evasion.setEvasionChance(u, chance)
    endfunction

    function SetUnitMissChance takes unit u, real chance returns nothing
        call Evasion.setMissChance(u, chance)
    endfunction

    function UnitAddEvasionChance takes unit u, real chance returns nothing
        call Evasion.setEvasionChance(u, Evasion.getEvasionChance(u) + chance)
    endfunction

    function UnitAddMissChance takes unit u, real chance returns nothing
        call Evasion.setMissChance(u, Evasion.getMissChance(u) + chance)
    endfunction

    function MakeUnitNeverMiss takes unit u, boolean flag returns nothing
        if flag then
            set Evasion.neverMiss[GetUnitUserData(u)] = Evasion.neverMiss[GetUnitUserData(u)] + 1
        else
            set Evasion.neverMiss[GetUnitUserData(u)] = Evasion.neverMiss[GetUnitUserData(u)] - 1
        endif
    endfunction

    function DoUnitNeverMiss takes unit u returns boolean
        return Evasion.neverMiss[GetUnitUserData(u)] > 0
    endfunction
endlibrary
