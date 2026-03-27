library LifeSteal requires DamageInterface
    // Creating a Life Steal system is easy using the functions provided by the DamageEvents Library.
    /* ------------------------ LifeSteal v2.4 by Chopinski ----------------------- */
    // LifeSteal intends to simulate the Life Steal system in warcraft, and allow you
    // to easily change the life steal amount of any unit.

    // Whenever a unit deals Physical damage, and it has a value of life steal given by
    // this system, it will heal based of this value and the damage amount.

    // The formula for life steal is:
    // heal = damage * life steal
    // fror life steal: 0.1 = 10%

    // *LifeSteal requires DamageInterface. Do not use TriggerSleepAction() within triggers.

    // The API:
    //     function SetUnitLifeSteal takes unit u, real amount returns nothing
    //         -> Set the Life Steal amount for a unit

    //     function GetUnitLifeSteal takes unit u returns real
    //         -> Returns the Life Steal amount of a unit

    //     function UnitAddLifeSteal takes unit u, real amount returns nothing
    //         -> Add to the Life Steal amount of a unit the given amount
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct LifeSteal
        static string     effect = "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl"
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
                call DestroyEffect(AddSpecialEffectTarget(effect, Damage.source.unit, "origin"))
            endif
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterAttackDamageEvent(function thistype.onDamage)
        endmethod 
    endstruct

    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function SetUnitLifeSteal takes unit u, real amount returns nothing
        call LifeSteal.Set(u, amount)
    endfunction

    function GetUnitLifeSteal takes unit u returns real
        return LifeSteal.Get(u)
    endfunction

    function UnitAddLifeSteal takes unit u, real amount returns nothing
        call LifeSteal.Set(u, LifeSteal.Get(u) + amount)
    endfunction
endlibrary
