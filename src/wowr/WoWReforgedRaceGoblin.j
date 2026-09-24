library WoWReforgedRaceGoblin initializer Init requires SimError, MathUtils, OnUnitRemoval

globals
    private group oilPlatforms = CreateGroup()
    private integer array goblinOilPlatformCounts
    private group array paints
    private player filterPlayer = null
    private boolexpr filterIsPaint = null
    private trigger channelTrigger = CreateTrigger()
    private trigger timerTrigger = CreateTrigger()
endglobals

function AddGoblinOilPlatform takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, oilPlatforms)) then
        if (GetUnitTypeId(whichUnit) == GOBLIN_OIL_PLATFORM) then
            set goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(whichUnit))] = goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(whichUnit))] + 1
        endif
        call GroupAddUnit(oilPlatforms, whichUnit)
        call EnableTrigger(timerTrigger)
    endif
endfunction

function RemoveGoblinOilPlatform takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, oilPlatforms)) then
        if (GetUnitTypeId(whichUnit) == GOBLIN_OIL_PLATFORM) then
            set goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(whichUnit))] = goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(whichUnit))] - 1
        endif
        call GroupRemoveUnit(oilPlatforms, whichUnit)
        if (BlzGroupGetSize(oilPlatforms) == 0) then
            call DisableTrigger(timerTrigger)
        endif
    endif
endfunction

private function Paint takes unit caster, integer unitTypeId, real x, real y returns nothing
    if (BlzGroupGetSize(paints[GetPlayerId(GetOwningPlayer(caster))]) < 10) then
        call GroupAddUnit(paints[GetPlayerId(GetOwningPlayer(caster))], CreateUnit(GetOwningPlayer(caster), unitTypeId, x, y, bj_UNIT_FACING))
    else
        call SimError(GetOwningPlayer(caster), GetLocalizedString("REACHED_LIMIT_OF_COLORS"))
    endif
endfunction

private function FilterIsPaint takes nothing returns boolean
    return IsUnitInGroup(GetFilterUnit(), paints[GetPlayerId(filterPlayer)])
endfunction

private function EnumRemovePaint takes nothing returns nothing
    call GroupRemoveUnit(paints[GetPlayerId(filterPlayer)], GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

private function Erase takes unit caster, real x, real y returns nothing
    local group g = CreateGroup()
    set filterPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 200.0, filterIsPaint)
    call ForGroup(g, function EnumRemovePaint)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0CJ') then // Drop Air Supplies
        call CreateItem('I04F', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
    elseif (GetSpellAbilityId() == 'A0C7') then // Paint Red
        call Paint(GetTriggerUnit(), 'n046', GetSpellTargetX(), GetSpellTargetY())
    elseif (GetSpellAbilityId() == 'A0C9') then // Paint Blue
        call Paint(GetTriggerUnit(), 'n047', GetSpellTargetX(), GetSpellTargetY())
    elseif (GetSpellAbilityId() == 'A0CA') then // Paint Yellow
        call Paint(GetTriggerUnit(), 'n048', GetSpellTargetX(), GetSpellTargetY())
    elseif (GetSpellAbilityId() == 'A0C8') then // Erase
        call Erase(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    elseif (GetSpellAbilityId() == 'A0BC') then // Goblin Tunnel Blow Up
        call KillUnit(GetTriggerUnit())
    endif
    return false
endfunction

private function EnumOilPlatforms takes nothing returns nothing
    local integer value = 0
    if (GetUnitTypeId(GetEnumUnit()) == KULTIRAS_CRANE or GetPlayerTechCountSimple(UPG_GOBLIN_OIL_DRILLING, GetOwningPlayer(GetEnumUnit())) > 0) then
        set value = 60 / goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(GetEnumUnit()))]
        call AdjustPlayerStateBJ(value, GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD)
        call ShowGoldTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetEnumUnit()))], GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), value)
        set value = 30 / goblinOilPlatformCounts[GetPlayerId(GetOwningPlayer(GetEnumUnit()))]
        call AdjustPlayerStateBJ(value, GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_LUMBER)
        call ShowLumberTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(GetEnumUnit()))], PolarProjectionX(GetUnitX(GetEnumUnit()), 100.00, 0), PolarProjectionY(GetUnitY(GetEnumUnit()), 100.00, 0), value)
    endif
endfunction

private function TriggerActionTimer takes nothing returns nothing
    call ForGroup(oilPlatforms, function EnumOilPlatforms)
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (IsUnitInGroup(whichUnit, paints[i])) then
            call GroupRemoveUnit(paints[i], whichUnit)
        endif
        set i = i + 1
    endloop
    call RemoveGoblinOilPlatform(whichUnit)
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set paints[i] = CreateGroup()
        set i = i + 1
    endloop

    set filterIsPaint = Filter(function FilterIsPaint)

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    call DisableTrigger(timerTrigger)
    call TriggerRegisterTimerEventPeriodic(timerTrigger, 10.0)
    call TriggerAddAction(timerTrigger, function TriggerActionTimer)

    call OnUnitRemoval(HookRemoveUnit)
endfunction

endlibrary
