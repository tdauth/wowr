library HideInTrees initializer Init requires TreeUtils, MathUtils

globals
    public constant string ORDER_HIDE = "eattree"
    public constant integer ABILITY_ID_HIDE = 'A1QE'
    public constant integer ABILITY_ID_UNHIDE = 'A1QF'
    public constant integer ABILITY_ID_LIFE_REGENERATION = 'A1QG'
    public constant integer ABILITY_ID_MANA_REGENERATION = 'A1U0'
    
    private constant integer KEY_UNIT = 0
    private constant integer KEY_MOVE_TYPE = 1
    private constant integer KEY_ATTACK_0_ENABLED = 2
    private constant integer KEY_ATTACK_1_ENABLED = 3

    private trigger castTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    
    private unit filterCaster = null
    private destructable resultingTree = null
    
    private group casters = CreateGroup()
    private hashtable h = InitHashtable()
endglobals

private function GetTreeHiddenUnit takes destructable t returns unit
    return LoadUnitHandle(h, GetHandleId(t), KEY_UNIT)
endfunction

private function HideUnit takes unit whichUnit, destructable tree returns nothing
    call GroupAddUnit(casters, whichUnit)
    call SetUnitInvulnerable(whichUnit, true)
    call SetUnitPathing(whichUnit, false)
    call SetUnitX(whichUnit, GetDestructableX(tree))
    call SetUnitY(whichUnit, GetDestructableY(tree))
    call BlzUnitDisableAbility(GetTriggerUnit(), 'Amov', true, true)
    call SaveUnitHandle(h, GetHandleId(tree), KEY_UNIT, whichUnit)
    call SaveInteger(h, GetHandleId(whichUnit), KEY_MOVE_TYPE, BlzGetUnitIntegerField(whichUnit, UNIT_IF_MOVE_TYPE))
    call SaveBoolean(h, GetHandleId(whichUnit), KEY_ATTACK_0_ENABLED, BlzGetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0))
    call SaveBoolean(h, GetHandleId(whichUnit), KEY_ATTACK_1_ENABLED, BlzGetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1))
    call BlzSetUnitIntegerField(whichUnit, UNIT_IF_MOVE_TYPE, 0)
    call BlzSetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0, false)
    call BlzSetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1, false)
    call UnitAddAbility(whichUnit, 'Apiv')
    call UnitAddAbility(whichUnit, ABILITY_ID_LIFE_REGENERATION)
    call UnitAddAbility(whichUnit, ABILITY_ID_LIFE_REGENERATION)
    call UnitAddAbility(whichUnit, ABILITY_ID_UNHIDE)
    call UnitAddType(whichUnit, UNIT_TYPE_SNARED)
    //call BJDebugMsg(GetUnitName(whichUnit) + " cast on " + GetDestructableName(tree))
endfunction

private function UnhideUnit takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, casters)) then
        call GroupRemoveUnit(casters, whichUnit)
        call SetUnitInvulnerable(whichUnit, false)
        call SetUnitPathing(whichUnit, true)
        call SetUnitPosition(whichUnit, GetUnitX(whichUnit), GetUnitY(whichUnit)) // for collision
        call BlzUnitDisableAbility(GetTriggerUnit(), 'Amov', false, false)
        call UnitRemoveAbility(whichUnit, 'Apiv')
        call UnitRemoveAbility(whichUnit, ABILITY_ID_LIFE_REGENERATION)
        call UnitRemoveAbility(whichUnit, ABILITY_ID_MANA_REGENERATION)
        call UnitRemoveAbility(whichUnit, ABILITY_ID_UNHIDE)
        //call BJDebugMsg(GetUnitName(whichUnit) + " cast unhide")
        
        call BlzSetUnitIntegerField(whichUnit, UNIT_IF_MOVE_TYPE, LoadInteger(h, GetHandleId(whichUnit), KEY_MOVE_TYPE))
        call BlzSetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0, LoadBoolean(h, GetHandleId(whichUnit), KEY_ATTACK_0_ENABLED))
        call BlzSetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1, LoadBoolean(h, GetHandleId(whichUnit), KEY_ATTACK_1_ENABLED))
   
        call FlushChildHashtable(h, GetHandleId(whichUnit))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID_HIDE) then
        if (GetTreeHiddenUnit(GetSpellTargetDestructable()) == null) then
            call HideUnit(GetTriggerUnit(), GetSpellTargetDestructable())
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TREE_IS_ALREADY_OCCUPIED"))
        endif
    elseif (GetSpellAbilityId() == ABILITY_ID_UNHIDE) then
        call UnhideUnit(GetTriggerUnit())
    endif
    
    return false
endfunction

private function EnumDestructableFreeTree takes nothing returns nothing
    local destructable d = GetEnumDestructable()
    if (IsDestructableTree(d) and GetTreeHiddenUnit(d) == null and (resultingTree == null or DistanceBetweenUnitAndDestructable(filterCaster, d) < DistanceBetweenUnitAndDestructable(filterCaster, resultingTree))) then
        set resultingTree = d
    endif
    set d = null
endfunction

private function GetFreeTreeNextTo takes unit caster, real x, real y returns destructable
    local location l = Location(x, y)
    set resultingTree = null
    set filterCaster = caster
    call EnumDestructablesInCircleBJ(64.0, l, function EnumDestructableFreeTree)
    call RemoveLocation(l)
    set l = null
    return resultingTree
endfunction

private function OrderNextToTree takes unit caster, real x, real y returns nothing
    local destructable tree = GetFreeTreeNextTo(caster, x, y)
    if (tree != null) then
        //call BJDebugMsg("Found tree " + GetDestructableName(tree))
        call IssueTargetDestructableOrder(caster, ORDER_HIDE, tree)
        set tree = null
    endif
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    if (GetIssuedOrderId() == OrderId("smart") and GetUnitAbilityLevel(GetTriggerUnit(), ABILITY_ID_HIDE) > 0) then
        //call BJDebugMsg("Order!")
        call OrderNextToTree(GetTriggerUnit(), GetOrderPointX(), GetOrderPointY())
    endif
    
    return false
endfunction

private function FilterIsTree takes nothing returns boolean
    return IsDestructableTree(GetFilterDestructable())
endfunction

private function RegisterDestDeathInRegionEnumX takes nothing returns nothing
    call TriggerRegisterDeathEvent(bj_destInRegionDiesTrig, GetEnumDestructable())
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetTreeHiddenUnit(GetTriggerDestructable()) != null) then
        call UnhideUnit(GetTreeHiddenUnit(GetTriggerDestructable()))
        call FlushChildHashtable(h, GetHandleId(GetTriggerDestructable()))
    endif
    
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))
    
    set bj_destInRegionDiesTrig = deathTrigger
    call EnumDestructablesInRect(GetPlayableMapRect(), Filter(function FilterIsTree), function RegisterDestDeathInRegionEnumX)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, casters)) then
        call GroupRemoveUnit(casters, whichUnit)
        call FlushChildHashtable(h, GetHandleId(whichUnit))
    endif
endfunction

private function RemoveDestructableHook takes destructable whichDestructable returns nothing
    call FlushChildHashtable(h, GetHandleId(whichDestructable))
endfunction

hook RemoveUnit RemoveUnitHook
hook RemoveDestructable RemoveDestructableHook

endlibrary
