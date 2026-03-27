library PluginSpellEffect requires RegisterPlayerUnitEvent
    /* ------------------- SpellEffectPlugin v1.1 by Chopinski ------------------ */
    // Simple plugin for the SpellEffectEvent library by Bribe to cache some usefull
    // values.

    // Credits to Bribe and Magtheridon96
    /* ----------------------------------- END ---------------------------------- */
    private struct SUnit
        unit    unit
        player  player
        integer handle
        boolean isHero
        boolean isStructure
        integer id
        real    x
        real    y
        real    z
        
        static method create takes nothing returns thistype
            return thistype.allocate()
        endmethod
    endstruct
    
    private module Event
        readonly static location location = Location(0, 0)
        readonly static SUnit    source
        readonly static SUnit    target
        readonly static ability  ability
        readonly static integer  level
        readonly static integer  id
        readonly static real     x
        readonly static real     y
        readonly static real     z

        private static method GetUnitZ takes unit u returns real
            call MoveLocation(location, GetUnitX(u), GetUnitY(u))
            return GetUnitFlyHeight(u) + GetLocationZ(location)
        endmethod

        private static method GetSpellTargetZ takes nothing returns real
            call MoveLocation(location, x, y)
            if target.unit != null then
                return GetUnitZ(target.unit)
            else
                return GetLocationZ(location)
            endif
        endmethod

        private static method onCast takes nothing returns nothing
            set source.unit   = GetTriggerUnit()
            set source.player = GetOwningPlayer(source.unit)
            set source.handle = GetHandleId(source.unit)
            set source.id     = GetUnitUserData(source.unit)
            set source.x      = GetUnitX(source.unit)
            set source.y      = GetUnitY(source.unit)
            set source.z      = GetUnitZ(source.unit)
            set source.isHero = IsUnitType(source.unit, UNIT_TYPE_HERO)
            set source.isStructure = IsUnitType(source.unit, UNIT_TYPE_STRUCTURE)
            
            set target.unit   = GetSpellTargetUnit()
            set target.player = GetOwningPlayer(target.unit)
            set target.handle = GetHandleId(target.unit)
            set target.id     = GetUnitUserData(target.unit)
            set target.x      = GetUnitX(target.unit)
            set target.y      = GetUnitY(target.unit)
            set target.z      = GetUnitZ(target.unit)
            set target.isHero = IsUnitType(target.unit, UNIT_TYPE_HERO)
            set target.isStructure = IsUnitType(target.unit, UNIT_TYPE_STRUCTURE)
            
            set x             = GetSpellTargetX()
            set y             = GetSpellTargetY()
            set z             = GetSpellTargetZ()
            set id            = GetSpellAbilityId()
            set level         = GetUnitAbilityLevel(source.unit, id)
            set ability       = BlzGetUnitAbility(source.unit, id)
        endmethod

        private static method onInit takes nothing returns nothing
            set source = SUnit.create()
            set target = SUnit.create()
        
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT, function thistype.onCast)
        endmethod
    endmodule

    struct Spell extends array
        implement Event
    endstruct
endlibrary
