library PocketFactory initializer Init requires WorldBounds, Utilities

/**
 * Summon unit events do not work for Pocket Factory and the Clockwerk Goblins.
 * This system is a workaround for this bug.
 * You can register summon unit events for both types of abilities.
 * It stores the most recent caster of the Pocket Factory ability and when the next Pocket Factory
 * enters the map, it triggers the custom event for this factory and the most recent caster.
 * For entering Clockwerk Goblins it detects the closest factory of the same owner and triggers
 * the custom event.
 */

globals
    private unit triggerCaster = null
    private unit triggerPocketFactory = null
    private unit triggerClockwerkGoblin = null
    private trigger array callbackTriggers
    private integer callbackTriggersCounter = 0
    private trigger array callbackTriggersClockwerkGoblin
    private integer callbackTriggersClockwerkGoblinCounter = 0
    
    private group casters = CreateGroup()
    
    private trigger castTrigger = CreateTrigger()
    private trigger enterTrigger = CreateTrigger()
    private player filterPlayer = null
    private filterfunc f = null
endglobals

function IsPocketFactoryAbility takes integer id returns boolean
    return id == 'ANsy' or id == 'ANs1' or id == 'ANs2' or id == 'ANs3' or id == ABILITY_POCKET_FACTORY
endfunction

function IsPocketFactory takes integer id returns boolean
    return id == 'nfac' or id == 'nfa1' or id == 'nfa2'
endfunction

function IsUnitPocketFactory takes unit whichUnit returns boolean
    return IsPocketFactory(GetUnitTypeId(whichUnit))
endfunction

function IsClockwerkGoblin takes integer id returns boolean
    return id == 'ncgb' or id == 'ncg1' or id == 'ncg2' or id == 'ncg3'
endfunction

function IsUnitClockwerkGoblin takes unit whichUnit returns boolean
    return IsClockwerkGoblin(GetUnitTypeId(whichUnit))
endfunction

function GetTriggerPocketFactoryCaster takes nothing returns unit
    return triggerCaster
endfunction

function GetTriggerPocketFactory takes nothing returns unit
    return triggerPocketFactory
endfunction

function GetTriggerClockwerkGoblin takes nothing returns unit
    return triggerClockwerkGoblin
endfunction

function TriggerRegisterPocketFactorySummon takes trigger whichTrigger returns nothing
    set callbackTriggers[callbackTriggersCounter] = whichTrigger
    set callbackTriggersCounter = callbackTriggersCounter + 1
endfunction

function TriggerRegisterPocketFactorySummonClockwerkGoblin takes trigger whichTrigger returns nothing
    set callbackTriggersClockwerkGoblin[callbackTriggersClockwerkGoblinCounter] = whichTrigger
    set callbackTriggersClockwerkGoblinCounter = callbackTriggersClockwerkGoblinCounter + 1
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (IsPocketFactoryAbility(GetSpellAbilityId()) and not IsUnitInGroup(GetTriggerUnit(), casters)) then
        call GroupAddUnit(casters, GetTriggerUnit())
    endif
    return false
endfunction

private function SummonPocketFactory takes unit factory, unit caster returns nothing
    local integer i = 0
    if (caster != null) then
        call GroupRemoveUnit(casters, caster)
    endif
    loop
        exitwhen (i == callbackTriggersCounter)
        if (IsTriggerEnabled(callbackTriggers[i])) then
            set triggerCaster = caster
            set triggerPocketFactory = factory
            call ConditionalTriggerExecute(callbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

private function SummonClockwerkGoblin takes unit clockwerkGoblin, unit caster returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackTriggersClockwerkGoblinCounter)
        if (IsTriggerEnabled(callbackTriggersClockwerkGoblin[i])) then
            set triggerPocketFactory = caster
            set triggerClockwerkGoblin = clockwerkGoblin
            call ConditionalTriggerExecute(callbackTriggersClockwerkGoblin[i])
        endif
        set i = i + 1
    endloop
endfunction

private function FindClosestFactory takes real x, real y, player owner returns unit
    local group g = CreateGroup()
    local unit result = null
    set filterPlayer = owner
    call GroupEnumUnitsInRange(g, x, y, 600.0, f)
    set result = GetClosestUnitGroup(x, y, g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return result
endfunction

private function TriggerConditionEnter takes nothing returns boolean
    if (IsUnitPocketFactory(GetTriggerUnit())) then
        call SummonPocketFactory(GetTriggerUnit(), FirstOfGroup(casters))
    elseif (IsUnitClockwerkGoblin(GetTriggerUnit())) then
        call SummonClockwerkGoblin(GetTriggerUnit(), FindClosestFactory(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), GetOwningPlayer(GetTriggerUnit())))
    endif
    return false
endfunction

private function FilterIsPocketFactory takes nothing returns boolean
    return IsUnitPocketFactory(GetFilterUnit()) and GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call TriggerRegisterEnterRegion(enterTrigger, WorldBounds.worldRegion, null)
    call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
    
    set f = Filter(function FilterIsPocketFactory)
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call GroupRemoveUnit(casters, whichUnit)
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
