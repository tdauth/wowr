library WoWReforgedCommandButtons initializer Init requires WoWReforgedClasses

globals
    constant integer ABILITY_ID_COMMAND_BUTTONS = 'A1X3'
    constant integer ABILITY_ATTACK = 'A1X6'
    constant integer ABILITY_PATROL = 'A1X7'
    constant integer ABILITY_MOVE = 'A1X4'
    constant integer ABILITY_STOP = 'A1X5'
    constant integer ABILITY_HOLD_POSITION = 'A0JY'
    constant integer ABILITY_HERO_SKILLS = 'A1X9'
    constant integer ABILITY_ROTATE = 'A0XW'
    
    private hashtable h = InitHashtable()
    private trigger channelTrigger = CreateTrigger()
    private trigger enterTrigger = CreateTrigger()
endglobals

function AddCommandButtonsForced takes unit whichUnit returns nothing
    //call BJDebugMsg("Add ability " + GetObjectName(ABILITY_ID_COMMAND_BUTTONS) + " to " + GetUnitName(whichUnit))
    call UnitAddAbility(whichUnit, ABILITY_ID_COMMAND_BUTTONS)
    call UnitMakeAbilityPermanent(whichUnit, true, ABILITY_ID_COMMAND_BUTTONS)
endfunction

function AddCommandButtons takes unit whichUnit returns boolean
    //call BJDebugMsg("Try to add command buttons to unit " + GetUnitName(whichUnit))
    if (GetUnitAbilityLevel(whichUnit, ABILITY_ID_COMMAND_BUTTONS) > 0) then
        return false
    endif
    if (GetUnitTypeId(whichUnit) == BACKPACK) then
        return false
    endif
    if (GetUnitAbilityLevel(whichUnit, 'Aro1') > 0) then
        return false
    endif
    if (GetUnitAbilityLevel(whichUnit, 'Aro2') > 0) then
        return false
    endif
    if (GetUnitMoveSpeed(whichUnit) <= 0.00) then
        return false
    endif
    if (GetOwningPlayer(whichUnit) == Player(PLAYER_NEUTRAL_PASSIVE) and GetUnitAbilityLevel(whichUnit, 'Avul') > 0 and GetHeroClass(GetUnitTypeId(whichUnit)) == CLASS_NONE) then
        return false
    endif
    if (IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE) and BlzGetUnitIntegerField(whichUnit, UNIT_IF_MOVE_TYPE) == 0) then
        return false
    endif
    call AddCommandButtonsForced(whichUnit)
    return true
endfunction

function ReaddCommandButtons takes unit whichUnit returns nothing
    call UnitRemoveAbility(whichUnit, ABILITY_ID_COMMAND_BUTTONS)
    call AddCommandButtonsForced(whichUnit)
endfunction

function RemoveCommandButtons takes unit whichUnit returns nothing
    call UnitRemoveAbility(whichUnit, ABILITY_ID_COMMAND_BUTTONS)
endfunction

private function TimerFunctionAbility takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local integer abilityId = LoadInteger(h, handleId, 0)
    local unit caster = LoadUnitHandle(h, handleId, 1)
    local real x = LoadReal(h, handleId, 2)
    local real y = LoadReal(h, handleId, 3)
    local unit target = LoadUnitHandle(h, handleId, 4)
    local destructable targetDestructable = LoadDestructableHandle(h, handleId, 5)
    
    if (abilityId == ABILITY_ATTACK) then
        call IssueImmediateOrder(caster, "stop")
        call ResetUnitAnimation(caster)
        if (target != null) then
            call IssueTargetOrder(caster, "attack", target)
        else
            if (targetDestructable != null) then
                call IssueTargetOrder(caster, "attack", targetDestructable)
            else
                call IssuePointOrder(caster, "attack", x, y)
            endif
        endif
    elseif (abilityId == ABILITY_PATROL) then
        call IssueImmediateOrder(caster, "stop")
        call ResetUnitAnimation(caster)
        if (target != null) then
            call IssueTargetOrder(caster, "smart", target)
        else
            if (targetDestructable != null) then
                call IssueTargetOrder(caster, "smart", targetDestructable)
            else
                call IssuePointOrder(caster, "patrol", x, y)
            endif
        endif
    elseif (abilityId == ABILITY_MOVE) then
        call IssueImmediateOrder(caster, "stop")
        call ResetUnitAnimation(caster)
        if (target != null) then
            call IssueTargetOrder(caster, "move", target)
        else
            if (targetDestructable != null) then
                call IssueTargetOrder(caster, "smart", targetDestructable)
            else
                call IssuePointOrder(caster, "move", x, y)
            endif
        endif
    elseif (abilityId == ABILITY_STOP or abilityId == ABILITY_HOLD_POSITION) then
        call ResetUnitAnimation(caster)
    endif
    
    set caster = null
    set target = null
    set targetDestructable = null
    
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local timer t = null
    local integer handleId = 0
    if (abilityId == ABILITY_ATTACK or abilityId == ABILITY_PATROL or abilityId == ABILITY_MOVE or abilityId == ABILITY_STOP or abilityId == ABILITY_HOLD_POSITION) then
        set t = CreateTimer()
        set handleId = GetHandleId(t)
        call SaveInteger(h, handleId, 0, abilityId)
        call SaveUnitHandle(h, handleId, 1, GetTriggerUnit())
        call SaveReal(h, handleId, 2, GetSpellTargetX())
        call SaveReal(h, handleId, 3, GetSpellTargetY())
        call SaveUnitHandle(h, handleId, 4, GetSpellTargetUnit())
        call SaveDestructableHandle(h, handleId, 4, GetSpellTargetDestructable())
        call TimerStart(t, 0.0, false, function TimerFunctionAbility)
        if (abilityId == ABILITY_STOP) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
        elseif (abilityId == ABILITY_HOLD_POSITION) then
            call IssueImmediateOrder(GetTriggerUnit(), "holdposition")
        endif
    elseif (abilityId == ABILITY_HERO_SKILLS) then
        if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)) then
            call ResetUnitAnimation( GetTriggerUnit() )
            call IssueImmediateOrderById(GetTriggerUnit(), 852000)
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("UNIT_IS_NO_HERO"))
        endif
    elseif (abilityId == ABILITY_ROTATE) then
        call SetUnitFacingTimed(GetTriggerUnit(), ModuloReal((GetUnitFacing(GetTriggerUnit()) + 15.00), 360.00), 0)
    endif
    return false
endfunction

private function TriggerConditionEnter takes nothing returns boolean
    call AddCommandButtons(GetTriggerUnit())
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call TriggerRegisterEnterRectSimple(enterTrigger, GetPlayableMapRect())
    call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
endfunction

endlibrary
