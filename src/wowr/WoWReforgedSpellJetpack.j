library WoWReforgedSpellJetpack requires Jump, TreeUtils, WoWReforgedUtils, WoWReforgedAbilitySkill

globals
    private string EFF = "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl"
    private constant integer OID = 852121
    private group ENU = CreateGroup()
    private constant real GRAVITY       = 100
    private constant real SPEED         = 500
    private constant real MAX_HEIGHT    = 250
    private constant real AOE   = 200
    private rect REC = Rect(0, 0, 0, 0)
endglobals

function GetJetpackDamage takes unit caster, integer abilityId, integer level returns real
    return 20.0 + I2R(level) * 25.0
endfunction

struct JumpingStomp

    private static method DestructableFilter takes nothing returns boolean
        if GetDestructableLife(GetFilterDestructable()) > 0 then
            if IsDestructableTree(GetFilterDestructable()) then
                call KillDestructable(GetFilterDestructable())
            endif
        endif
        return false
    endmethod
    
    private static method TargetFilter takes nothing returns boolean
        return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitAlly(GetFilterUnit(), GetOwningPlayer(EVENT_JUMP_UNIT))
    endmethod

    private static method onFinish takes nothing returns boolean
        local real x
        local real y
        local real damage = 0.0
        local integer i = 0
        local integer max = 0
        local group t = null
        local integer level = GetUnitAbilitySkillLevelSafe(EVENT_JUMP_UNIT, ABILITY_JETPACK)
        if not IsUnitType(EVENT_JUMP_UNIT, UNIT_TYPE_DEAD) then
            set x = GetUnitX(EVENT_JUMP_UNIT)
            set y = GetUnitY(EVENT_JUMP_UNIT)
            call DestroyEffect(AddSpecialEffect(EFF, x, y))
            call SetRect(REC, x-AOE, y-AOE, x+AOE, y+AOE)
            call EnumDestructablesInRect(REC, function thistype.DestructableFilter, null)
        endif
        
        if (level > 0) then
            set damage = GetJetpackDamage(EVENT_JUMP_UNIT, ABILITY_JETPACK, level)
            set t = CreateGroup()
            call GroupEnumUnitsInRange(t, x, y, 256.0, Filter(function thistype.TargetFilter))
            set i = 0
            set max = BlzGroupGetSize(t)
            loop
                exitwhen (i == max)
                call UnitDamageTarget(EVENT_JUMP_UNIT, BlzGroupUnitAt(t, i), damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                set i = i + 1
            endloop
            call GroupClear(t)
            call DestroyGroup(t)
            set t = null
        endif
        //set ST = TAB[GetHandleId(EVENT_JUMP_UNIT)]
        //call ST.remove()
        return false
    endmethod
    
    private static method canCast takes nothing returns boolean
        return GetSpellAbilityId() == ABILITY_JETPACK
    endmethod
    
    private static method startJump takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local real x0 = GetUnitX(u)
        local real y0 = GetUnitY(u)
        local real x1 = GetSpellTargetX()
        local real y1 = GetSpellTargetY()
        // Here I make each jump take at least 0.5 seconds. The distance add to the jump time with 0.5 factor.
        local real time = 0.5 + 0.5 * SquareRoot( (x1-x0)*(x1-x0) + (y1-y0)*(y1-y0) ) / SPEED
        call Jump.start(u, x1, y1, MAX_HEIGHT, time, GRAVITY)
        set u = null
    endmethod
    
    private static method onCast takes nothing returns boolean
        if (GetSpellAbilityId() == ABILITY_JETPACK) then
            call thistype.startJump()
        endif
        
        return false
    endmethod
    
    private static method onOrder takes nothing returns boolean
        if GetIssuedOrderId() == OID and not IsPointJumpable(GetOrderPointX(), GetOrderPointY()) then
            call PauseUnit(GetTriggerUnit(), true)
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call PauseUnit(GetTriggerUnit(), false)
            call SimError(GetTriggerPlayer(), GetLocalizedString("CANNOT_JUMP_THERE"))
        endif
        return false
    endmethod

    private static method onInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterVariableEvent(t, "EVENT_JUMP_FINISH", EQUAL, 1)
        call TriggerAddCondition(t, function thistype.onFinish)
        
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        call TriggerAddCondition(t, function thistype.onOrder)
        
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddCondition(t, function thistype.canCast)
        call TriggerAddCondition(t, function thistype.onCast)
        
        call RegisterAbilityFieldCustomReal0(ABILITY_JETPACK, GetJetpackDamage)
    endmethod
endstruct

endlibrary

