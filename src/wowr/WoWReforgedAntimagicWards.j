library WoWReforgedAntimagicWards initializer Init requires MathUtils

globals
    public constant real MAX_DISTANCE = 2048.00
    
    // avoid cyclic dependencies
    unit tmpAntimagicWard = null
    trigger antimagicWardPlacementTrigger = CreateTrigger()
    
    private group wards = CreateGroup()
    private trigger constructFinishedTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

function IsAreaPortectedByAntimagicWard takes player whichPlayer, real x, real y returns boolean
    local boolean result = false
    local unit u = null
    local integer i = 0
    local integer max = BlzGroupGetSize(wards)
    loop
        exitwhen (i == max or result)
        set u = BlzGroupUnitAt(wards, i)
        if (IsUnitEnemy(u, whichPlayer) and DistanceBetweenUnitAndPoint(u, x, y) <= MAX_DISTANCE) then
            set result = true
        endif
        set u = null
        set i = i + 1
    endloop
    return result
endfunction

function IsBlink takes integer abilityId returns boolean
    if (abilityId == 'AEbl') then
        return true
    elseif (abilityId == 'ANbl')then
        return true
    elseif (abilityId == 'A0H9')then
        return true
    endif
    return false
endfunction

function IsTeleport takes integer abilityId returns boolean
    if (abilityId == 'AHmt') then
        return true
    elseif (abilityId == 'A0DE') then
        return true
    elseif (abilityId == 'AImt') then
        return true
    elseif (abilityId == 'AItp') then
        return true
    endif
    return false
endfunction

function AddAntimagicWard takes unit whichUnit returns nothing
    call GroupAddUnit(wards, whichUnit)
    set tmpAntimagicWard = whichUnit
    call TriggerExecute(antimagicWardPlacementTrigger)
endfunction

function RemoveAntimagicWard takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, wards)) then
        call GroupRemoveUnit(wards, whichUnit)
    endif
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == ANTIMAGIC_WARD) then
        call AddAntimagicWard(GetConstructedStructure())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    call RemoveAntimagicWard(GetTriggerUnit())
    return false
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (IsBlink(GetSpellAbilityId()) and IsAreaPortectedByAntimagicWard(GetOwningPlayer(GetTriggerUnit()), GetSpellTargetX(), GetSpellTargetY())) then
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("AREA_PROTECTED_BY_ANTIMAGIC_WARD"))
    endif
    return false
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (IsTeleport(GetSpellAbilityId()) and IsAreaPortectedByAntimagicWard(GetOwningPlayer(GetTriggerUnit()), GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit()))) then
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("AREA_PROTECTED_BY_ANTIMAGIC_WARD"))
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructFinishedTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishedTrigger, Condition(function TriggerConditionConstructFinish))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

hook RemoveUnit RemoveAntimagicWard

endlibrary
