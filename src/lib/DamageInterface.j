library DamageInterface requires optional Table
    /* --------------------- DamageInterface v2.4 by Chopinski --------------------- */
    // Allows for easy registration of specific damage type events like on attack
    // damage or on spell damage, etc...
    /* ----------------------------------- END ---------------------------------- */
    /* -------------------------------------------------------------------------- */
    /*                                Configuration                               */
    /* -------------------------------------------------------------------------- */
    globals
        // This constant is used to define if the system will cache
        // extra information from a Damage Event, like the unit
        // Custom value (UnitUserData), a unit Handle Id, and more
        // Additionaly you can see the CacheResponse method below
        // to have an idea and comment the members you want cached or not
        private constant boolean CACHE_EXTRA = true
        // Since Table can be a bit slow due to using only one hastable
        // for everything, you can choose to use it or not with this
        // system in particular.
        private constant boolean USE_TABLE   = false
    endglobals

    /* -------------------------------------------------------------------------- */
    /*                                   System                                   */
    /* -------------------------------------------------------------------------- */
    struct Unit
        unit    unit
        player  player
        integer handle
        boolean isHero
        boolean isMelee
        boolean isRanged
        boolean isStructure
        boolean isMagicImmune
        integer id
        real    x
        real    y
        real    z
        
        static method create takes nothing returns thistype
            return thistype.allocate()
        endmethod
    endstruct

    struct Damage extends array
        static if LIBRARY_Table and USE_TABLE then
            private static HashTable after
            private static HashTable before
        else
            private static hashtable after = InitHashtable()
            private static hashtable before = InitHashtable()
        endif

        static trigger damaged = CreateTrigger()
        static trigger damaging = CreateTrigger()
        readonly static location location = Location(0, 0)
        
        readonly static damagetype damagetype
        readonly static attacktype attacktype
        readonly static Unit       source
        readonly static Unit       target
        readonly static boolean    isSpell
        readonly static boolean    isAttack
        readonly static boolean    isEnemy
        readonly static boolean    isAlly

        private static method GetUnitZ takes unit u returns real
            call MoveLocation(location, GetUnitX(u), GetUnitY(u))
            return GetUnitFlyHeight(u) + GetLocationZ(location)
        endmethod

        private static method cache takes unit src, unit tgt, damagetype dmg_type, attacktype atk_type returns nothing
            set damagetype  = dmg_type
            set attacktype  = atk_type
            set source.unit = src
            set target.unit = tgt
            set isAttack    = damagetype == DAMAGE_TYPE_NORMAL
            set isSpell     = attacktype == ATTACK_TYPE_NORMAL

            // You can comment the members you dont want to be cached
            // or set CACHE_EXTRA = false to not save them at all
            if CACHE_EXTRA then
                set source.player        = GetOwningPlayer(src)
                set target.player        = GetOwningPlayer(tgt)
                set isEnemy              = IsUnitEnemy(tgt, source.player)
                set isAlly               = IsUnitAlly(tgt, source.player)
                set source.isMelee       = IsUnitType(src, UNIT_TYPE_MELEE_ATTACKER)
                set source.isRanged      = IsUnitType(src, UNIT_TYPE_RANGED_ATTACKER)
                set target.isMelee       = IsUnitType(tgt, UNIT_TYPE_MELEE_ATTACKER)
                set target.isRanged      = IsUnitType(tgt, UNIT_TYPE_RANGED_ATTACKER)
                set source.isHero        = IsUnitType(src, UNIT_TYPE_HERO)
                set target.isHero        = IsUnitType(tgt, UNIT_TYPE_HERO)
                set source.isStructure   = IsUnitType(src, UNIT_TYPE_STRUCTURE)
                set target.isStructure   = IsUnitType(tgt, UNIT_TYPE_STRUCTURE)
                set source.isMagicImmune = IsUnitType(src, UNIT_TYPE_MAGIC_IMMUNE)
                set target.isMagicImmune = IsUnitType(tgt, UNIT_TYPE_MAGIC_IMMUNE)
                set source.x             = GetUnitX(src)
                set source.y             = GetUnitY(src)
                set source.z             = GetUnitZ(src)
                set target.x             = GetUnitX(tgt)
                set target.y             = GetUnitY(tgt)
                set target.z             = GetUnitZ(tgt)
                set source.id            = GetUnitUserData(src)
                set target.id            = GetUnitUserData(tgt)
                set source.handle        = GetHandleId(src)
                set target.handle        = GetHandleId(tgt)
            endif
        endmethod

        private static method onDamaging takes nothing returns nothing
            local integer i
            local integer j
            
            call cache(GetEventDamageSource(), BlzGetEventDamageTarget(), BlzGetEventDamageType(), BlzGetEventAttackType())

            if damagetype != DAMAGE_TYPE_UNKNOWN then
                set i = GetHandleId(attacktype)
                set j = GetHandleId(damagetype)

                static if LIBRARY_Table and USE_TABLE then
                    if before[i].trigger[0] != null then
                        call TriggerEvaluate(before[i].trigger[0])
                    endif

                    if before[0].trigger[j] != null then
                        call TriggerEvaluate(before[0].trigger[j])
                    endif
                    
                    if before[i].trigger[j] != null then
                        call TriggerEvaluate(before[i].trigger[j])
                    endif
                else
                    if HaveSavedHandle(before, i, 0) then
                        call TriggerEvaluate(LoadTriggerHandle(before, i, 0))
                    endif

                    if HaveSavedHandle(before, 0, j) then
                        call TriggerEvaluate(LoadTriggerHandle(before, 0, j))
                    endif
                    
                    if HaveSavedHandle(before, i, j) then
                        call TriggerEvaluate(LoadTriggerHandle(before, i, j))
                    endif
                endif
            endif
        endmethod

        private static method onDamage takes nothing returns nothing
            local integer i
            local integer j
            
            call cache(GetEventDamageSource(), BlzGetEventDamageTarget(), BlzGetEventDamageType(), BlzGetEventAttackType())

            if damagetype != DAMAGE_TYPE_UNKNOWN then
                set i = GetHandleId(attacktype)
                set j = GetHandleId(damagetype)
    
                static if LIBRARY_Table and USE_TABLE then
                    if after[i].trigger[0] != null then
                        call TriggerEvaluate(after[i].trigger[0])
                    endif

                    if after[0].trigger[j] != null then
                        static if LIBRARY_Evasion then
                            if isAttack then
                                if not Evasion.evade then
                                    call TriggerEvaluate(after[0].trigger[j])
                                endif
                            else
                                call TriggerEvaluate(after[0].trigger[j])
                            endif
                        else
                            call TriggerEvaluate(after[0].trigger[j])
                        endif
                    endif
                    
                    if after[i].trigger[j] != null then
                        call TriggerEvaluate(after[i].trigger[j])
                    endif
                else
                    if HaveSavedHandle(after, i, 0) then
                        call TriggerEvaluate(LoadTriggerHandle(after, i, 0))
                    endif

                    if HaveSavedHandle(after, 0, j) then
                        static if LIBRARY_Evasion then
                            if isAttack then
                                if not Evasion.evade then
                                    call TriggerEvaluate(LoadTriggerHandle(after, 0, j))
                                endif
                            else
                                call TriggerEvaluate(LoadTriggerHandle(after, 0, j))
                            endif
                        else
                            call TriggerEvaluate(LoadTriggerHandle(after, 0, j))
                        endif
                    endif
                    
                    if HaveSavedHandle(after, i, j) then
                        call TriggerEvaluate(LoadTriggerHandle(after, i, j))
                    endif
                endif
            endif
        endmethod

        static method register takes attacktype attack, damagetype damage, code c, boolean onDamaged returns nothing
            local integer i = GetHandleId(attack)
            local integer j = GetHandleId(damage)

            if onDamaged then
                static if LIBRARY_Table and USE_TABLE then
                    if after[i].trigger[j] == null then
                        set after[i].trigger[j] = CreateTrigger()
                    endif
                    call TriggerAddCondition(after[i].trigger[j], Filter(c))
                else
                    if not HaveSavedHandle(after, i, j) then
                        call SaveTriggerHandle(after, i, j, CreateTrigger())
                    endif
                    call TriggerAddCondition(LoadTriggerHandle(after, i, j), Filter(c))
                endif
            else
                static if LIBRARY_Table and USE_TABLE then
                    if before[i].trigger[j] == null then
                        set before[i].trigger[j] = CreateTrigger()
                    endif
                    call TriggerAddCondition(before[i].trigger[j], Filter(c))
                else
                    if not HaveSavedHandle(before, i, j) then
                        call SaveTriggerHandle(before, i, j, CreateTrigger())
                    endif
                    call TriggerAddCondition(LoadTriggerHandle(before, i, j), Filter(c))
                endif
            endif
        endmethod
    
        static method onInit takes nothing returns nothing
            static if LIBRARY_Table and USE_TABLE then
                set after = HashTable.create()
                set before = HashTable.create()
            endif
            set source = Unit.create()
            set target = Unit.create()

            call TriggerRegisterAnyUnitEventBJ(damaged, EVENT_PLAYER_UNIT_DAMAGED)
            call TriggerAddCondition(damaged, Condition(function thistype.onDamage))

            call TriggerRegisterAnyUnitEventBJ(damaging, EVENT_PLAYER_UNIT_DAMAGING)
            call TriggerAddCondition(damaging, Condition(function thistype.onDamaging))
        endmethod
    endstruct
    
    /* -------------------------------------------------------------------------- */
    /*                                  JASS API                                  */
    /* -------------------------------------------------------------------------- */
    function RegisterAttackDamageEvent takes code c returns nothing
        call Damage.register(null, DAMAGE_TYPE_NORMAL, c, true)
    endfunction
    
    function RegisterSpellDamageEvent takes code c returns nothing
        call Damage.register(ATTACK_TYPE_NORMAL, null, c, true)
    endfunction

    function RegisterDamageEvent takes attacktype attack, damagetype damage, code c returns nothing
        call Damage.register(attack, damage, c, true)
    endfunction

    function RegisterAnyDamageEvent takes code c returns nothing
        call TriggerAddCondition(Damage.damaged, Filter(c))
    endfunction

    function RegisterAttackDamagingEvent takes code c returns nothing
        call Damage.register(null, DAMAGE_TYPE_NORMAL, c, false)
    endfunction
    
    function RegisterSpellDamagingEvent takes code c returns nothing
        call Damage.register(ATTACK_TYPE_NORMAL, null, c, false)
    endfunction

    function RegisterDamagingEvent takes attacktype attack, damagetype damage, code c returns nothing
        call Damage.register(attack, damage, c, false)
    endfunction 

    function RegisterAnyDamagingEvent takes code c returns nothing
        call TriggerAddCondition(Damage.damaging, Filter(c))
    endfunction
endlibrary
