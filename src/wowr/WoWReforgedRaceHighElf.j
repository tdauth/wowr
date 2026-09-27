library WoWReforgedRaceHighElf initializer Init requires SimError, NewBonusUtils, WoWReforgedRaces

globals
    private boolean isDay = false
    private boolexpr filterIsDayTarget = null
    private boolexpr filterIsNightTarget = null
    private boolexpr filterIsValidSunwellResurrectionTarget = null
    private player filterPlayer = null
    private trigger researchFinishTrigger = CreateTrigger()
    private trigger nightTrigger = CreateTrigger()
    private trigger dayTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

private function EnumEnableDiurnalResearch takes nothing returns nothing
    call SetPlayerTechResearched(GetEnumPlayer(), 'R0D3', 1)
endfunction

private function EnableDiurnalResearch takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumEnableDiurnalResearch)
endfunction

private function EnumDisableDiurnalResearch takes nothing returns nothing
    call SetPlayerTechResearched(GetEnumPlayer(), 'R0D3', 0)
endfunction

private function DisableDiurnalResearch takes nothing returns nothing
    call ForForce(GetPlayersAll(), function EnumDisableDiurnalResearch)
endfunction

private function EnableDiurnalEffect takes unit whichUnit returns nothing
    call UnitAddAbility(whichUnit, 'A1IQ')
    call LinkBonusToBuff(whichUnit, BONUS_HEALTH, 80.0, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_HEALTH_REGEN, 0.4, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_ATTACK_SPEED, 0.1, 'B02L')
    call LinkBonusToBuff(whichUnit, BONUS_MOVEMENT_SPEED, 80, 'B02L')
endfunction

function AddDiurnalHighElf takes unit whichUnit returns nothing
    if (isDay and GetUnitAbilityLevel(whichUnit, 'A1IP') > 0) then
        call EnableDiurnalEffect(GetTrainedUnit())
    endif
endfunction

private function EnumDay takes nothing returns nothing
    call EnableDiurnalEffect(GetEnumUnit())
endfunction

private function Daylight takes nothing returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), filterIsDayTarget)
    call ForGroup(g, function EnumDay)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    call EnableDiurnalResearch()
endfunction

private function EnumNight takes nothing returns nothing
    call UnitRemoveAbility(GetEnumUnit(), 'A1IQ')
endfunction

private function Night takes nothing returns nothing
    local group g = CreateGroup()
    set isDay = false
    call GroupEnumUnitsInRect(g, GetPlayableMapRect(), filterIsNightTarget)
    call ForGroup(g, function EnumNight)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    call DisableDiurnalResearch()
endfunction

private function FilterIsDayTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A1IP') > 0 and GetUnitAbilityLevel(GetFilterUnit(), 'A1IQ') == 0
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    if (GetResearched() == UPG_HIGH_ELF_DIURNAL and isDay) then
        call Daylight()
    endif
    return false
endfunction

private function FilterIsNightTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A1ER') > 0
endfunction

private function TriggerConditionNight takes nothing returns boolean
    if (isDay and (GetTimeOfDay() >= bj_TOD_DUSK or GetTimeOfDay() < bj_TOD_DAWN)) then
        call Night()
    endif
    return false
endfunction

private function TriggerConditionDay takes nothing returns boolean
    if (not isDay and GetTimeOfDay() >= bj_TOD_DAWN and GetTimeOfDay() < bj_TOD_DUSK) then
        call Daylight()
    endif
    return false
endfunction

private function FilterIsValidSunwellResurrectionTarget takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), filterPlayer) and GetObjectRace(GetUnitTypeId(GetFilterUnit())) == WOWR_RACE_UNDEAD
endfunction

private function EnumResurrect takes nothing returns nothing
    local integer targetUnitTypeId = MapUnitID(GetUnitTypeId(GetEnumUnit()), WOWR_RACE_HIGH_ELF, false)
    if (targetUnitTypeId != 0) then
        call ReplaceUnitBJ(GetEnumUnit(), targetUnitTypeId, bj_UNIT_STATE_METHOD_RELATIVE)
        call SetUnitOwner(GetLastReplacedUnitBJ(), filterPlayer, true)
    endif
endfunction

private function Resurrect takes unit whichUnit, real x, real y returns nothing
    local group g = CreateGroup()
    set filterPlayer = GetOwningPlayer(whichUnit)
    call GroupEnumUnitsInRange(g, x, y, 512.0, filterIsValidSunwellResurrectionTarget)
    if (BlzGroupGetSize(g) > 0) then
        call ForGroup(g, function EnumResurrect)
    else
        call IssueImmediateOrder(whichUnit, "stop")
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("NO_VALID_TARGETS_IN_THIS_AREA"))
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0G6') then // Resurrect
        call Resurrect(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsDayTarget = Filter(function FilterIsDayTarget)
    set filterIsNightTarget = Filter(function FilterIsNightTarget)
    set filterIsValidSunwellResurrectionTarget = Filter(function FilterIsValidSunwellResurrectionTarget)

    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))

    call TriggerRegisterGameStateEvent(nightTrigger, GAME_STATE_TIME_OF_DAY, LESS_THAN, bj_TOD_DAWN)
    call TriggerRegisterGameStateEvent(nightTrigger, GAME_STATE_TIME_OF_DAY, GREATER_THAN_OR_EQUAL, bj_TOD_DUSK)
    call TriggerAddCondition(nightTrigger, Condition(function TriggerConditionNight))

    call TriggerRegisterGameStateEvent(dayTrigger, GAME_STATE_TIME_OF_DAY, GREATER_THAN_OR_EQUAL, bj_TOD_DAWN)
    call TriggerRegisterGameStateEvent(dayTrigger, GAME_STATE_TIME_OF_DAY, LESS_THAN, bj_TOD_DUSK)
    call TriggerAddCondition(dayTrigger, Condition(function TriggerConditionDay))

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
endfunction

endlibrary
