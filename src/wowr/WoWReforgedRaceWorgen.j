library WoWReforgedRaceWorgen initializer Init requires NewBonusUtils

globals
    private boolean isNight = false
    private boolexpr filterIsValidNocturnalTarget = null
    private boolexpr filterHasNocturnalEffect = null
    private trigger deathTrigger = CreateTrigger()
    private trigger researchFinishTrigger = CreateTrigger()
    private trigger nightTrigger = CreateTrigger()
    private trigger dayTrigger = CreateTrigger()
endglobals

private function EnableNocturnalEffect takes unit whichUnit returns nothing
    if (not IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        call SetPlayerTechResearched(GetOwningPlayer(whichUnit), 'R0C1', 1)
    endif
    call UnitAddAbility(whichUnit, 'A1ER')
    call LinkBonusToBuff(whichUnit, BONUS_HEALTH, 80.0, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_HEALTH_REGEN, 0.4, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_ATTACK_SPEED, 0.1, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_MOVEMENT_SPEED, 80, 'B02L')
endfunction

function AddNocturnalWorgen takes unit whichUnit returns nothing
    if (isNight and (GetUnitAbilityLevel(whichUnit, 'A1G3') > 0 or GetUnitAbilityLevel(whichUnit, 'A120') > 0) and GetUnitAbilityLevel(whichUnit, 'A1ER') == 0) then
        call EnableNocturnalEffect(whichUnit)
    endif
endfunction

private function Curse takes unit whichUnit, unit killer returns nothing
    local unit summoned = CreateUnit(GetOwningPlayer(killer), 'h0JM', GetUnitX(whichUnit), GetUnitY(whichUnit), GetUnitFacing(whichUnit))
    call UnitApplyTimedLife(summoned, 'B021', 60.0)
    set summoned = null
endfunction

private function FilterIsValidNocturnalTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A120') > 0 and GetUnitAbilityLevel(GetFilterUnit(), 'A1ER') == 0
endfunction

private function EnumNocturnalEffect takes nothing returns nothing
    call EnableNocturnalEffect(GetEnumUnit())
endfunction

private function EnableNocturnalEffectForAll takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), filterIsValidNocturnalTarget)
    call ForGroup(g, function EnumNocturnalEffect)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function FilterHasNocturnalEffect takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A1ER') > 0
endfunction

private function EnumDisableNocturnalEffect takes nothing returns nothing
    call SetPlayerTechResearched(GetOwningPlayer(GetEnumUnit()), 'R0C1', 0)
    call UnitRemoveAbility(GetEnumUnit(), 'A1ER')
endfunction

private function DisableNocturnalEffectForAll takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), filterHasNocturnalEffect)
    call ForGroup(g, function EnumDisableNocturnalEffect)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetUnitAbilityLevel(GetKillingUnit(), 'A11S') > 0) then // Worgen Curse
        call Curse(GetTriggerUnit(), GetKillingUnit())
    endif
    return false
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    if (GetResearched() == UPG_WORGEN_NOCTURNAL and isNight) then
        call EnableNocturnalEffectForAll()
    endif
    return false
endfunction

private function TriggerConditionNight takes nothing returns boolean
    if (not isNight and (GetTimeOfDay() >= 18.0 or GetTimeOfDay() < 6.0)) then
        set isNight = true
        call EnableNocturnalEffectForAll()
    endif
    return false
endfunction

private function TriggerConditionDay takes nothing returns boolean
    if (isNight and GetTimeOfDay() < 18.00) then
        set isNight = false
        call DisableNocturnalEffectForAll()
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsValidNocturnalTarget = Filter(function FilterIsValidNocturnalTarget)
    set filterHasNocturnalEffect = Filter(function FilterHasNocturnalEffect)
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))

    call TriggerRegisterGameStateEventTimeOfDay(nightTrigger, GREATER_THAN_OR_EQUAL, 18.00)
    call TriggerRegisterGameStateEventTimeOfDay(nightTrigger, GREATER_THAN_OR_EQUAL, 0.00)
    call TriggerAddCondition(nightTrigger, Condition(function TriggerConditionNight))

    call TriggerRegisterGameStateEventTimeOfDay(dayTrigger, GREATER_THAN_OR_EQUAL, 6.00)
    call TriggerAddCondition(dayTrigger, Condition(function TriggerConditionDay))
endfunction

endlibrary

