library NewBonus requires optional DamageInterface, optional Evasion, optional CriticalStrike, optional SpellPower, optional LifeSteal, optional SpellVamp, optional CooldownReduction, optional Tenacity
    /*
    https://www.hiveworkshop.com/threads/new-bonus-vjass-lua.324058/

    GetUnitCooldownReduction
    EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
    */

    /* ---------------------------------------- NewBonus v2.4 --------------------------------------- */
    // Since ObjectMerger is broken and we still have no means to edit
    // bonus values (green values) i decided to create a light weight
    // Bonus library that works in the same way that the original Bonus Mod
    // by Earth Fury did. NewBonus requires patch 1.30+.
    // Credits to Earth Fury for the original Bonus idea

    // How to Import?
    // Importing bonus mod is really simple. Just copy the 9 abilities with the
    // prefix "NewBonus" from the Object Editor into your map and match their new raw
    // code to the bonus types in the global block below. Then create a trigger called
    // NewBonus, convert it to custom text and paste this code there. You done!
    /* ---------------------------------------- By Chopinski ---------------------------------------- */
    
    /* ---------------------------------------------------------------------------------------------- */
    /*                                          Configuration                                         */
    /* ---------------------------------------------------------------------------------------------- */
    globals
        // If true will use the extended version of the system.
        // Make sure you have the DamageInterface and Cooldown Reduction libraries
        public constant boolean EXTENDED                  = true
    
        // This is the maximum recursion limit allowed by the system.
        // It's value must be greater than or equal to 0. When equal to 0
        // no recursion is allowed. Values too big can cause screen freezes.
        private constant integer RECURSION_LIMIT          = 8
    
        //The bonus types
        constant integer BONUS_DAMAGE                     = 1
        constant integer BONUS_ARMOR                      = 2
        constant integer BONUS_AGILITY                    = 3
        constant integer BONUS_STRENGTH                   = 4
        constant integer BONUS_INTELLIGENCE               = 5
        constant integer BONUS_HEALTH                     = 6
        constant integer BONUS_MANA                       = 7
        constant integer BONUS_MOVEMENT_SPEED             = 8
        constant integer BONUS_SIGHT_RANGE                = 9
        constant integer BONUS_HEALTH_REGEN               = 10
        constant integer BONUS_MANA_REGEN                 = 11
        constant integer BONUS_ATTACK_SPEED               = 12
        constant integer BONUS_MAGIC_RESISTANCE           = 13
        constant integer BONUS_EVASION_CHANCE             = 14
        constant integer BONUS_CRITICAL_DAMAGE            = 15
        constant integer BONUS_CRITICAL_CHANCE            = 16
        constant integer BONUS_LIFE_STEAL                 = 17
        constant integer BONUS_MISS_CHANCE                = 18
        constant integer BONUS_SPELL_POWER_FLAT           = 19
        constant integer BONUS_SPELL_POWER_PERCENT        = 20
        constant integer BONUS_SPELL_VAMP                 = 21
        constant integer BONUS_COOLDOWN_REDUCTION         = 22
        constant integer BONUS_COOLDOWN_REDUCTION_FLAT    = 23
        constant integer BONUS_COOLDOWN_OFFSET            = 24
        constant integer BONUS_TENACITY                   = 25
        constant integer BONUS_TENACITY_FLAT              = 26
        constant integer BONUS_TENACITY_OFFSET            = 27
    
        //The abilities codes for each bonus
        //When pasting the abilities over to your map
        //their raw code should match the bonus here
        private constant integer DAMAGE_ABILITY           = 'Z001'
        private constant integer ARMOR_ABILITY            = 'Z002'
        private constant integer STATS_ABILITY            = 'Z003'
        private constant integer HEALTH_ABILITY           = 'Z004'
        private constant integer MANA_ABILITY             = 'Z005'
        private constant integer HEALTHREGEN_ABILITY      = 'Z006'
        private constant integer MANAREGEN_ABILITY        = 'Z007'
        private constant integer ATTACKSPEED_ABILITY      = 'Z008'
        private constant integer MOVEMENTSPEED_ABILITY    = 'Z009'
        private constant integer SIGHT_RANGE_ABILITY      = 'Z00A'
        private constant integer MAGIC_RESISTANCE_ABILITY = 'Z00B'
        private constant integer CRITICAL_STRIKE_ABILITY  = 'Z00C'
        private constant integer EVASION_ABILITY          = 'Z00D'
        private constant integer LIFE_STEAL_ABILITY       = 'Z00E'
    
        //The abilities fields that are modified. For the sake of readability
        private constant abilityintegerlevelfield DAMAGE_FIELD           = ABILITY_ILF_ATTACK_BONUS
        private constant abilityintegerlevelfield ARMOR_FIELD            = ABILITY_ILF_DEFENSE_BONUS_IDEF
        private constant abilityintegerlevelfield AGILITY_FIELD          = ABILITY_ILF_AGILITY_BONUS
        private constant abilityintegerlevelfield STRENGTH_FIELD         = ABILITY_ILF_STRENGTH_BONUS_ISTR
        private constant abilityintegerlevelfield INTELLIGENCE_FIELD     = ABILITY_ILF_INTELLIGENCE_BONUS
        private constant abilityintegerlevelfield HEALTH_FIELD           = ABILITY_ILF_MAX_LIFE_GAINED
        private constant abilityintegerlevelfield MANA_FIELD             = ABILITY_ILF_MAX_MANA_GAINED
        private constant abilityintegerlevelfield MOVEMENTSPEED_FIELD    = ABILITY_ILF_MOVEMENT_SPEED_BONUS
        private constant abilityintegerlevelfield SIGHT_RANGE_FIELD      = ABILITY_ILF_SIGHT_RANGE_BONUS
        private constant abilityreallevelfield    HEALTHREGEN_FIELD      = ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED
        private constant abilityreallevelfield    MANAREGEN_FIELD        = ABILITY_RLF_AMOUNT_REGENERATED
        private constant abilityreallevelfield    ATTACKSPEED_FIELD      = ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1
        private constant abilityreallevelfield    MAGIC_RESISTANCE_FIELD = ABILITY_RLF_DAMAGE_REDUCTION_ISR2
        private constant abilityreallevelfield    CRITICAL_CHANCE_FIELD  = ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE
        private constant abilityreallevelfield    CRITICAL_DAMAGE_FIELD  = ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2
        private constant abilityreallevelfield    EVASION_FIELD          = ABILITY_RLF_CHANCE_TO_EVADE_EEV1
        private constant abilityreallevelfield    LIFE_STEAL_FIELD       = ABILITY_RLF_LIFE_STOLEN_PER_ATTACK
    endglobals
    
    /* ---------------------------------------------------------------------------------------------- */
    /*                                            JASS API                                            */
    /* ---------------------------------------------------------------------------------------------- */
    function GetUnitBonus takes unit source, integer bonus returns real
        return NewBonus.get(source, bonus)
    endfunction

    function SetUnitBonus takes unit source, integer bonus, real amount returns real
        return NewBonus.Set(source, bonus, amount, false)
    endfunction
    
    function RemoveUnitBonus takes unit source, integer bonus returns nothing
        if bonus == BONUS_CRITICAL_DAMAGE then
            call NewBonus.Set(source, bonus, 1, false)
        else
            call NewBonus.Set(source, bonus, 0, false)
        endif
        
        if bonus == BONUS_LIFE_STEAL then
            call UnitRemoveAbility(source, LIFE_STEAL_ABILITY)
        endif
    endfunction
    
    function AddUnitBonus takes unit source, integer bonus, real amount returns real
        return NewBonus.add(source, bonus, amount)
    endfunction
    
    function RegisterBonusEvent takes code c returns nothing
        call NewBonus.register(c, 0)
    endfunction
    
    function RegisterBonusTypeEvent takes integer bonus, code c returns nothing
        call NewBonus.register(c, bonus)
    endfunction
    
    function GetBonusUnit takes nothing returns unit
        return NewBonus.unit[NewBonus.key]
    endfunction
    
    function GetBonusType takes nothing returns integer
        return NewBonus.type[NewBonus.key]
    endfunction
    
    function SetBonusType takes integer bonus returns nothing
        if bonus >= BONUS_DAMAGE and bonus <= NewBonus.last then
            set NewBonus.type[NewBonus.key] = bonus
        endif
    endfunction
    
    function GetBonusAmount takes nothing returns real
        return NewBonus.amount[NewBonus.key]
    endfunction
    
    function SetBonusAmount takes real amount returns nothing
        set NewBonus.amount[NewBonus.key] = amount
    endfunction

    /* ---------------------------------------------------------------------------------------------- */
    /*                                             System                                             */
    /* ---------------------------------------------------------------------------------------------- */
    struct NewBonus
        private static trigger trigger = CreateTrigger()
        readonly static integer key = -1
        private static trigger array event
        private static integer count = 0
        readonly static unit array unit
        readonly static integer last
        readonly static integer linkType
        static integer array type
        static real array amount
        
        private static method checkOverflow takes real current, real value returns real
            if value > 0 and current > 2147483647 - value then
                return 2147483647 - current
            elseif value < 0 and current < -2147483648 - value then
                return -2147483648 - current
            else
                return value
            endif
        endmethod

        private static method onEvent takes integer key returns nothing
            local integer i = 0
            local integer next = -1
            local integer prev = -2

            set count = count + 1
            
            if amount[key] != 0 and (count - last < RECURSION_LIMIT) then
                loop
                    exitwhen type[key] == next or (i - last > RECURSION_LIMIT)
                        set next = type[key]

                        if event[next] != null then
                            call TriggerEvaluate(event[next])
                        endif

                        if type[key] != next then
                            set i = i + 1
                        else
                            if next != prev then
                                call TriggerEvaluate(trigger)

                                if type[key] != next then
                                    set i = i + 1
                                    set prev = next
                                endif
                            endif
                        endif
                endloop
            endif
            
            set count = count - 1
            set .key = key
        endmethod
        
        private static method setAbilityI takes unit source, integer id, abilityintegerlevelfield field, real value, boolean adding returns real
            if GetUnitAbilityLevel(source, id) == 0 then
                call UnitAddAbility(source, id)
                call UnitMakeAbilityPermanent(source, true, id)
            endif
            
            if adding then
                if BlzSetAbilityIntegerLevelField(BlzGetUnitAbility(source, id), field, 0, BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, id), field, 0) + R2I(value)) then
                    call IncUnitAbilityLevel(source, id)
                    call DecUnitAbilityLevel(source, id)
                endif
            else
                if BlzSetAbilityIntegerLevelField(BlzGetUnitAbility(source, id), field, 0, R2I(value)) then
                    call IncUnitAbilityLevel(source, id)
                    call DecUnitAbilityLevel(source, id)
                endif
            endif
            
            set linkType = type[key]
            
            if key > -1 then
                set key = key - 1
            endif
        
            return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, id), field, 0))
        endmethod

        private static method setAbilityR takes unit source, integer id, abilityreallevelfield field, real value returns real
            if GetUnitAbilityLevel(source, id) == 0 then
                call UnitAddAbility(source, id)
                call UnitMakeAbilityPermanent(source, true, id)
            endif
        
            if BlzSetAbilityRealLevelField(BlzGetUnitAbility(source, id), field, 0, value) then
                call IncUnitAbilityLevel(source, id)
                call DecUnitAbilityLevel(source, id)
            endif
            
            set linkType = type[key]
            
            if key > -1 then
                set key = key - 1
            endif
        
            return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, id), field, 0)
        endmethod

        static method get takes unit source, integer bonus returns real
            if bonus == BONUS_DAMAGE then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, DAMAGE_ABILITY), DAMAGE_FIELD, 0))
            elseif bonus == BONUS_ARMOR then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, ARMOR_ABILITY), ARMOR_FIELD, 0))
            elseif bonus == BONUS_HEALTH then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, HEALTH_ABILITY), HEALTH_FIELD, 0))
            elseif bonus == BONUS_MANA then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, MANA_ABILITY), MANA_FIELD, 0))
            elseif bonus == BONUS_AGILITY then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, STATS_ABILITY), AGILITY_FIELD, 0))
            elseif bonus == BONUS_STRENGTH then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, STATS_ABILITY), STRENGTH_FIELD, 0))
            elseif bonus == BONUS_INTELLIGENCE then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, STATS_ABILITY), INTELLIGENCE_FIELD, 0))
            elseif bonus == BONUS_MOVEMENT_SPEED then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, MOVEMENTSPEED_ABILITY), MOVEMENTSPEED_FIELD, 0))
            elseif bonus == BONUS_SIGHT_RANGE then
                return I2R(BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(source, SIGHT_RANGE_ABILITY), SIGHT_RANGE_FIELD, 0))
            elseif bonus == BONUS_HEALTH_REGEN then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, HEALTHREGEN_ABILITY), HEALTHREGEN_FIELD, 0)
            elseif bonus == BONUS_MANA_REGEN then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, MANAREGEN_ABILITY), MANAREGEN_FIELD, 0)
            elseif bonus == BONUS_ATTACK_SPEED then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, ATTACKSPEED_ABILITY), ATTACKSPEED_FIELD, 0)
            elseif bonus == BONUS_MAGIC_RESISTANCE then
                return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, MAGIC_RESISTANCE_ABILITY), MAGIC_RESISTANCE_FIELD, 0)
            elseif bonus >= BONUS_EVASION_CHANCE and bonus <= last then
                static if EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
                    if bonus == BONUS_EVASION_CHANCE then
                        return GetUnitEvasionChance(source)
                    elseif bonus == BONUS_MISS_CHANCE then
                        return GetUnitMissChance(source)
                    elseif bonus == BONUS_CRITICAL_CHANCE then
                        return GetUnitCriticalChance(source)
                    elseif bonus == BONUS_CRITICAL_DAMAGE then
                        return GetUnitCriticalMultiplier(source)
                    elseif bonus == BONUS_SPELL_POWER_FLAT then
                        return GetUnitSpellPowerFlat(source)
                    elseif bonus == BONUS_SPELL_POWER_PERCENT then
                        return GetUnitSpellPowerPercent(source)
                    elseif bonus == BONUS_LIFE_STEAL then
                        return GetUnitLifeSteal(source)
                    elseif bonus == BONUS_SPELL_VAMP then
                        return GetUnitSpellVamp(source)
                    elseif bonus == BONUS_COOLDOWN_REDUCTION then
                        return GetUnitCooldownReduction(source)
                    elseif bonus == BONUS_COOLDOWN_REDUCTION_FLAT then
                        return GetUnitCooldownReductionFlat(source)
                    elseif bonus == BONUS_COOLDOWN_OFFSET then
                        return GetUnitCooldownOffset(source)
                    elseif bonus == BONUS_TENACITY then
                        return GetUnitTenacity(source)
                    elseif bonus == BONUS_TENACITY_FLAT then
                        return GetUnitTenacityFlat(source)
                    elseif bonus == BONUS_TENACITY_OFFSET then
                        return GetUnitTenacityOffset(source)
                    endif
                else
                    if bonus == BONUS_CRITICAL_CHANCE then
                        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, CRITICAL_STRIKE_ABILITY), CRITICAL_CHANCE_FIELD, 0)
                    elseif bonus == BONUS_CRITICAL_DAMAGE then
                        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, CRITICAL_STRIKE_ABILITY), CRITICAL_DAMAGE_FIELD, 0)
                    elseif bonus == BONUS_EVASION_CHANCE then
                        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, EVASION_ABILITY), EVASION_FIELD, 0)
                    elseif bonus == BONUS_LIFE_STEAL then
                        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(source, LIFE_STEAL_ABILITY), LIFE_STEAL_FIELD, 0)
                    endif
                endif
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type")
            endif
            
            return -1.
        endmethod

        static method Set takes unit source, integer bonus, real value, boolean adding returns real
            local real p
            
            if not adding then
                set key = key + 1
                set unit[key] = source
                set type[key] = bonus
                set amount[key] = value
                
                call onEvent(key)
                
                if amount[key] != value then
                    set value = amount[key]
                endif
                
                if type[key] != bonus then
                    return Set(unit[key], type[key], amount[key], not adding)
                endif
            else
                set unit[key] = source
                set type[key] = bonus
                set amount[key] = value
            endif

            if bonus == BONUS_DAMAGE then
                return setAbilityI(source, DAMAGE_ABILITY, DAMAGE_FIELD, value, adding)
            elseif bonus == BONUS_ARMOR then
                return setAbilityI(source, ARMOR_ABILITY, ARMOR_FIELD, value, adding)
            elseif bonus == BONUS_HEALTH then
                set p = GetUnitLifePercent(source)

                if value == 0 and not adding then
                    call BlzSetUnitMaxHP(source, R2I(BlzGetUnitMaxHP(source) - get(source, bonus)))
                else
                    call BlzSetUnitMaxHP(source, R2I(BlzGetUnitMaxHP(source) + value))
                endif

                call setAbilityI(source, HEALTH_ABILITY, HEALTH_FIELD, value, adding)
                call SetUnitLifePercentBJ(source, p)

                return value
            elseif bonus == BONUS_MANA then
                set p = GetUnitManaPercent(source)

                if value == 0 and not adding then
                    call BlzSetUnitMaxMana(source, R2I(BlzGetUnitMaxMana(source) - get(source, bonus)))
                else
                    call BlzSetUnitMaxMana(source, R2I(BlzGetUnitMaxMana(source) + value))
                endif

                call setAbilityI(source, MANA_ABILITY, MANA_FIELD, value, adding)
                call SetUnitManaPercentBJ(source, p)

                return value
            elseif bonus == BONUS_AGILITY then
                return setAbilityI(source, STATS_ABILITY, AGILITY_FIELD, value, adding)
            elseif bonus == BONUS_STRENGTH then
                return setAbilityI(source, STATS_ABILITY, STRENGTH_FIELD, value, adding)
            elseif bonus == BONUS_INTELLIGENCE then
                return setAbilityI(source, STATS_ABILITY, INTELLIGENCE_FIELD, value, adding)
            elseif bonus == BONUS_MOVEMENT_SPEED then
                return setAbilityI(source, MOVEMENTSPEED_ABILITY, MOVEMENTSPEED_FIELD, value, adding)
            elseif bonus == BONUS_SIGHT_RANGE then
                if value == 0 and not adding then
                    call BlzSetUnitRealField(source, UNIT_RF_SIGHT_RADIUS, (BlzGetUnitRealField(source, UNIT_RF_SIGHT_RADIUS) - get(source, bonus)))
                else
                    call BlzSetUnitRealField(source, UNIT_RF_SIGHT_RADIUS, (BlzGetUnitRealField(source, UNIT_RF_SIGHT_RADIUS) + value))
                endif

                call setAbilityI(source, SIGHT_RANGE_ABILITY, SIGHT_RANGE_FIELD, value, adding)

                return value
            elseif bonus == BONUS_HEALTH_REGEN then
                return setAbilityR(source, HEALTHREGEN_ABILITY, HEALTHREGEN_FIELD, value)
            elseif bonus == BONUS_MANA_REGEN then
                return setAbilityR(source, MANAREGEN_ABILITY, MANAREGEN_FIELD, value)
            elseif bonus == BONUS_ATTACK_SPEED then
                return setAbilityR(source, ATTACKSPEED_ABILITY, ATTACKSPEED_FIELD, value)
            elseif bonus == BONUS_MAGIC_RESISTANCE then
                return setAbilityR(source, MAGIC_RESISTANCE_ABILITY, MAGIC_RESISTANCE_FIELD, value)
            elseif bonus >= BONUS_EVASION_CHANCE and bonus <= last then
                static if EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
                    if bonus == BONUS_EVASION_CHANCE then
                        call SetUnitEvasionChance(source, value)
                    elseif bonus == BONUS_MISS_CHANCE then
                        call SetUnitMissChance(source, value)
                    elseif bonus == BONUS_CRITICAL_CHANCE then
                        call SetUnitCriticalChance(source, value)
                    elseif bonus == BONUS_CRITICAL_DAMAGE then
                        call SetUnitCriticalMultiplier(source, value)
                    elseif bonus == BONUS_SPELL_POWER_FLAT then
                        call SetUnitSpellPowerFlat(source, value)
                    elseif bonus == BONUS_SPELL_POWER_PERCENT then
                        call SetUnitSpellPowerPercent(source, value)
                    elseif bonus == BONUS_LIFE_STEAL then
                        call SetUnitLifeSteal(source, value)
                    elseif bonus == BONUS_SPELL_VAMP then
                        call SetUnitSpellVamp(source, value)
                    elseif bonus == BONUS_COOLDOWN_REDUCTION then
                        if adding then
                            call UnitAddCooldownReduction(source, value)
                        else
                            call SetUnitCooldownReduction(source, value)
                        endif
                    elseif bonus == BONUS_COOLDOWN_REDUCTION_FLAT then
                        call SetUnitCooldownReductionFlat(source, value)
                    elseif bonus == BONUS_COOLDOWN_OFFSET then
                        call SetUnitCooldownOffset(source, value)
                    elseif bonus == BONUS_TENACITY then
                        if adding then
                            call UnitAddTenacity(source, value)
                        else
                            call SetUnitTenacity(source, value)
                        endif
                    elseif bonus == BONUS_TENACITY_FLAT then
                        call SetUnitTenacityFlat(source, value)
                    elseif bonus == BONUS_TENACITY_OFFSET then
                        call SetUnitTenacityOffset(source, value)
                    endif
                    
                    set linkType = bonus
                    
                    if key > -1 then
                        set key = key - 1
                    endif
                    
                    return value
                else
                    if bonus == BONUS_CRITICAL_CHANCE then
                        return setAbilityR(source, CRITICAL_STRIKE_ABILITY, CRITICAL_CHANCE_FIELD, value)
                    elseif bonus == BONUS_CRITICAL_DAMAGE then
                        return setAbilityR(source, CRITICAL_STRIKE_ABILITY, CRITICAL_DAMAGE_FIELD, value)
                    elseif bonus == BONUS_EVASION_CHANCE then
                        return setAbilityR(source, EVASION_ABILITY, EVASION_FIELD, value)
                    elseif bonus == BONUS_LIFE_STEAL then
                        return setAbilityR(source, LIFE_STEAL_ABILITY, LIFE_STEAL_FIELD, value)
                    endif
                endif
            else
                call DisplayTimedTextToPlayer(Player(0), 0, 0, 10, "Invalid Bonus Type: " + I2S(bonus) + " with last " + I2S(last))
            endif

            return -1.
        endmethod

        static method add takes unit source, integer bonus, real value returns real
            if value != 0 then
                set key = key + 1
                set unit[key] = source
                set type[key] = bonus
                set amount[key] = value
                
                if bonus <= BONUS_SIGHT_RANGE then
                    set amount[key] = checkOverflow(get(source, bonus), R2I(value))
                endif
                
                call onEvent(key)
                set value = amount[key] 
                
                if type[key] <= BONUS_SIGHT_RANGE then
                    call Set(unit[key], type[key], checkOverflow(get(unit[key], type[key]), R2I(amount[key])), true)
                else
                    static if EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
                        if type[key] == BONUS_COOLDOWN_REDUCTION or type[key] == BONUS_TENACITY then
                            call Set(unit[key], type[key], amount[key], true)
                        else
                            call Set(unit[key], type[key], get(unit[key], type[key]) + amount[key], true)
                        endif
                    else
                        call Set(unit[key], type[key], get(unit[key], type[key]) + amount[key], true)
                    endif
                endif
                
                return value
            endif
            
            return 0.
        endmethod
        
        static method register takes code c, integer bonus returns nothing
            if bonus >= BONUS_DAMAGE and bonus <= last then
                if event[bonus] == null then
                    set event[bonus] = CreateTrigger()
                endif
                call TriggerAddCondition(event[bonus], Filter(c))
            else
                call TriggerAddCondition(trigger, Filter(c))
            endif
        endmethod
        
        private static method onInit takes nothing returns nothing
            static if EXTENDED and LIBRARY_DamageInterface and LIBRARY_Evasion and LIBRARY_CriticalStrike and LIBRARY_SpellPower and LIBRARY_LifeSteal and LIBRARY_SpellVamp and LIBRARY_Tenacity then
                set last = BONUS_TENACITY_OFFSET
            else
                set last = BONUS_LIFE_STEAL
            endif
        endmethod
    endstruct
endlibrary
