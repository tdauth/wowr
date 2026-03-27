library NewBonusUtils requires NewBonus, RegisterPlayerUnitEvent
    /* ------------------------------------- NewBonusUtils v2.4 ------------------------------------- */
    // Required Library: RegisterPlayerUnitEvent -> www.hiveworkshop.com/threads/snippet-registerplayerunitevent.203338/

    // API:
    // function AddUnitBonusTimed takes unit u, integer bonus_type, real amount, real duration returns nothing
    //     -> Add the specified amount for the specified bonus type for unit for a duration
    //     -> Example: call AddUnitBonusTimed(GetTriggerUnit(), BONUS_ARMOR, 13, 10.5)

    // function LinkBonusToBuff takes unit u, integer bonus_type, real amount, integer buffId returns nothing
    //     -> Links the bonus amount specified to a buff or ability. As long as the unit has the buff or
    //     -> the ability represented by the parameter buffId the bonus is not removed.
    //     -> Example: call LinkBonusToBuff(GetTriggerUnit(), BONUS_ARMOR, 10, 'B000')

    // function LinkBonusToItem takes unit u, integer bonus_type, real amount, item i returns nothing
    //     -> Links the bonus amount specified to an item. As long as the unit has that item the bonus is not removed.
    //     -> Note that it will work for items with the same id, because it takes as parameter the item object.
    //     -> Example: call LinkBonusToItem(GetManipulatingUnit(), BONUS_ARMOR, 10, GetManipulatedItem())

    // function UnitCopyBonuses takes unit source, unit target returns nothing
    //     -> Copy the source unit bonuses using the Add functionality to the target unit
    //     -> Example: call UnitCopyBonuses(GetTriggerUnit(), GetSummonedUnit())

    // function UnitMirrorBonuses takes unit source, unit target returns nothing
    //     -> Copy the source unit bonuses using the Set functionality to the target unit
    //     -> Example: call UnitMirrorBonuses(GetTriggerUnit(), GetSummonedUnit())
    /* ---------------------------------------- By Chopinski ---------------------------------------- */
    
    /* ---------------------------------------------------------------------------------------------- */
    /*                                            JASS API                                            */
    /* ---------------------------------------------------------------------------------------------- */
    function AddUnitBonusTimed takes unit source, integer bonus, real amount, real duration returns nothing
        call NewBonusUtils.linkTimed(source, bonus, amount, duration, true)
    endfunction

    function LinkBonusToBuff takes unit source, integer bonus, real amount, integer id returns nothing
        call NewBonusUtils.linkBuff(source, bonus, amount, id, false)
    endfunction

    function LinkBonusToItem takes unit source, integer bonus, real amount, item i returns nothing
        call NewBonusUtils.linkItem(source, bonus, amount, i)
    endfunction

    function UnitCopyBonuses takes unit source, unit target returns nothing
        call NewBonusUtils.copy(source, target)
    endfunction

    function UnitMirrorBonuses takes unit source, unit target returns nothing
        call NewBonusUtils.mirror(source, target)
    endfunction

    /* ---------------------------------------------------------------------------------------------- */
    /*                                             System                                             */
    /* ---------------------------------------------------------------------------------------------- */
    struct NewBonusUtils extends NewBonus
        static constant real period = 0.03125000
        static timer timer = CreateTimer()
        static integer index = -1
        static thistype array array
        static integer k = -1
        static thistype array items

        unit source
        item item
        real duration
        integer bonus_t
        integer buff
        real value
        boolean link

        method remove takes integer i, boolean isItem returns integer
            static if NewBonus_EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
                if bonus_t == BONUS_COOLDOWN_REDUCTION then
                    call UnitRemoveCooldownReduction(source, value)
                elseif bonus_t == BONUS_TENACITY then
                    call UnitRemoveTenacity(source, value)
                else
                    call AddUnitBonus(source, bonus_t, -value)
                endif
            else
                call AddUnitBonus(source, bonus_t, -value)
            endif

            if isItem then
                set items[i] = items[k]
                set k = k - 1
            else
                set array[i] = array[index]
                set index = index - 1

                if index == -1 then
                    call PauseTimer(timer)
                endif
            endif

            set source = null
            set item = null
            
            call deallocate()

            return i - 1
        endmethod

        static method onDrop takes nothing returns nothing
            local item itm = GetManipulatedItem()
            local integer i = 0
            local thistype this
            
            loop
                exitwhen i > k
                    set this = items[i]
                    
                    if item == itm then
                        set i = remove(i, true)
                    endif
                set i = i + 1
            endloop
        endmethod
     
        static method onPeriod takes nothing returns nothing
            local integer i = 0
            local thistype this

            loop
                exitwhen i > index
                    set this = array[i]

                    if link then
                        if duration <= 0 then
                            set i = remove(i, false)
                        endif
                        set duration = duration - period
                    else
                        if GetUnitAbilityLevel(source, buff) == 0 then
                            set i = remove(i, false)
                        endif
                    endif
                set i = i + 1
            endloop
        endmethod

        static method linkTimed takes unit source, integer bonus, real amount, real duration, boolean link returns nothing
            local thistype this = thistype.allocate()

            set this.source = source
            set this.duration = duration
            set this.link = link
            set this.value = AddUnitBonus(source, bonus, amount)
            set this.bonus_t = linkType
            set index = index + 1
            set array[index] = this
         
            if index == 0 then
                call TimerStart(timer, period, true, function thistype.onPeriod)
            endif
        endmethod

        static method linkBuff takes unit source, integer bonus, real amount, integer id, boolean link returns nothing
            local thistype this = thistype.allocate()

            set this.source = source
            set this.buff = id
            set this.link = link
            set this.value = AddUnitBonus(source, bonus, amount)
            set this.bonus_t = linkType
            set index = index + 1
            set array[index] = this
         
            if index == 0 then
                call TimerStart(timer, period, true, function thistype.onPeriod)
            endif
        endmethod

        static method linkItem takes unit source, integer bonus, real amount, item i returns nothing
            local thistype this = thistype.allocate()

            set this.source = source
            set this.item = i
            set this.value = AddUnitBonus(source, bonus, amount)
            set this.bonus_t = linkType
            set k = k + 1
            set items[k] = this
        endmethod

        static method copy takes unit source, unit target returns nothing
            local integer i = 1

            loop
                exitwhen i > last
                    if GetUnitBonus(source, i) != 0 then
                        call AddUnitBonus(target, i, GetUnitBonus(source, i))
                    endif
                set i = i + 1
            endloop
        endmethod

        static method mirror takes unit source, unit target returns nothing
            local integer i = 1
            
            loop
                exitwhen i > last
                    call SetUnitBonus(target, i, GetUnitBonus(source, i))
                set i = i + 1
            endloop
        endmethod

        static method onInit takes nothing returns nothing
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DROP_ITEM, function thistype.onDrop)
        endmethod
    endstruct
endlibrary
