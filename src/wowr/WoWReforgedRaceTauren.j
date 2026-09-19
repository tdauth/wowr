library WoWReforgedRaceTauren initializer Init

globals
    private group array poles
    private trigger deathTrigger = CreateTrigger()
endglobals

function AddTaurenPole takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    if (not IsUnitInGroup(whichUnit, poles[playerId])) then
        call GroupAddUnit(poles[playerId], whichUnit)
    endif
endfunction

function RemoveTaurenPole takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    if (IsUnitInGroup(whichUnit, poles[playerId])) then
        call GroupRemoveUnit(poles[playerId], whichUnit)
    endif
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    return not IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) and GetRandomInt(1, 100) <= 30
endfunction

private function Resurrect takes unit whichUnit, unit killer, boolean changeOwner, boolean moveTarget returns nothing
    local unit dummy = CreateUnit(GetOwningPlayer(whichUnit), 'h0CG', GetUnitX(whichUnit), GetUnitY(whichUnit), bj_UNIT_FACING)
    call ShowUnit(dummy, false)
    call IssueImmediateOrder(dummy, "resurrection")
    if (changeOwner and GetUnitAbilityLevel(whichUnit, 'A1J4') == 0) then
        call SetUnitOwner(whichUnit, GetOwningPlayer(killer), true)
    endif
    if (moveTarget) then
        call SetUnitPosition(whichUnit, GetUnitX(killer), GetUnitY(killer))
    endif
    call PolledWait(2.0)
    call RemoveUnit(dummy)
    set dummy = null
endfunction

private function EnumRessurectPole takes nothing returns nothing
    call Resurrect(GetTriggerUnit(), GetEnumUnit(), false, true)
endfunction

private function ResurrectPoles takes player whichPlayer returns nothing
    call ForGroup(poles[GetPlayerId(whichPlayer)], function EnumRessurectPole)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    if (GetUnitAbilityLevel(GetTriggerUnit(), 'A1J4') > 0 or (GetKillingUnit() != null and GetOwningPlayer(GetTriggerUnit()) == Player(PLAYER_NEUTRAL_AGGRESSIVE) and GetUnitAbilityLevel(GetKillingUnit(), 'A1J4') > 0)) then
        call Resurrect(GetTriggerUnit(), GetKillingUnit(), true, false)
    endif
    if (GetUnitAbilityLevel(GetTriggerUnit(), 'A1J4') == 0) then
        call ResurrectPoles(GetOwningPlayer(GetTriggerUnit()))
    endif
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set poles[i] = CreateGroup()
        set i = i + 1
    endloop
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
endfunction

endlibrary
