library SpellVamp requires DamageInterface
    /* ------------------------ SpellVamp v2.4 by Chopinski ----------------------- */
    // SpellVamp intends to introduce to warcraft a healing based on Spell damage, like
    // in LoL or Dota 2.

    // Whenever a unit deals Spell damage, and it has a value of spell vamp given by
    // this system, it will heal based of this value and the damage amount.

    // The formula for spell vamp is:
    // heal = damage * lspell vamp
    // fror spell vamp: 0.1 = 10%

    // *SpellVamp requires DamageInterface. Do not use TriggerSleepAction() within triggers.

    // The API:
    //     function SetUnitSpellVamp takes unit u, real amount returns nothing
    //         -> Set the Spell Vamp amount for a unit
    
    //     function GetUnitSpellVamp takes unit u returns real
    //         -> Returns the Spell Vamp amount of a unit
    
    //     function UnitAddSpellVamp takes unit u, real amount returns nothing
    //         -> Add to the Spell Vamp amount of a unit the given amount
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct SpellVamp
        static real array amount

        static method Get takes unit u returns real
            return amount[GetUnitUserData(u)]
        endmethod

        static method Set takes unit u, real value returns nothing
            set amount[GetUnitUserData(u)] = value
        endmethod  

        static method onDamage takes nothing returns nothing
            local real damage = GetEventDamage()
        
            if damage > 0 and amount[Damage.source.id] > 0 and not Damage.target.isStructure then
                call SetWidgetLife(Damage.source.unit, (GetWidgetLife(Damage.source.unit) + (damage * amount[Damage.source.id])))
            endif
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterSpellDamageEvent(function thistype.onDamage)
        endmethod
    endstruct

    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function SetUnitSpellVamp takes unit u, real amount returns nothing
        call SpellVamp.Set(u, amount)
    endfunction

    function GetUnitSpellVamp takes unit u returns real
        return SpellVamp.Get(u)
    endfunction

    function UnitAddSpellVamp takes unit u, real amount returns nothing
        call SpellVamp.Set(u, SpellVamp.Get(u) + amount)
    endfunction
endlibrary
