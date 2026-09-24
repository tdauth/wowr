library WoWReforgedRaceHighElf initializer Init requires SimError, NewBonusUtils

globals
    private boolean isDay = false
    private hashtable h = InitHashtable()
    private boolexpr filterIsDayTarget = null
    private boolexpr filterIsNightTarget = null
    private boolexpr filterIsValidSunwellResurrectionTarget = null
    private player filterPlayer = null
    private trigger researchFinishTrigger = CreateTrigger()
    private trigger nightTrigger = CreateTrigger()
    private trigger dayTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

private function AddUnitTypeId takes integer unitTypeId, integer targetUnitTypeId returns nothing
    call SaveInteger(h, unitTypeId, 0, targetUnitTypeId)
endfunction

private function GetTargetUnitTypeId takes integer unitTypeId returns integer
    return LoadInteger(h, unitTypeId, 0)
endfunction

private function EnableDiurnalEffect takes unit whichUnit returns nothing
    if (not IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        call SetPlayerTechResearched(GetOwningPlayer(whichUnit), 'R0D3', 1)
    endif
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
endfunction

private function EnumNight takes nothing returns nothing
    call SetPlayerTechResearched(GetOwningPlayer(GetEnumUnit()), UPG_HIGH_ELF_DIURNAL, 0)
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
    return GetUnitAbilityLevelSwapped('A1ER', GetFilterUnit()) > 0
endfunction

private function TriggerConditionNight takes nothing returns boolean
    if (isDay and (GetTimeOfDay() >= 18.00 or GetTimeOfDay() < 6.00)) then
        call Night()
    endif
    return false
endfunction

private function TriggerConditionDay takes nothing returns boolean
    if (not isDay and GetTimeOfDay() < 18.00) then
        call Daylight()
    endif
    return false
endfunction

private function FilterIsValidSunwellResurrectionTarget takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), filterPlayer) and GetTargetUnitTypeId(GetUnitTypeId(GetFilterUnit())) != 0
endfunction

private function EnumResurrect takes nothing returns nothing
    local integer targetUnitTypeId = GetTargetUnitTypeId(GetUnitTypeId(GetEnumUnit()))
    call ReplaceUnitBJ(GetEnumUnit(), targetUnitTypeId, bj_UNIT_STATE_METHOD_RELATIVE)
    call SetUnitOwner(GetLastReplacedUnitBJ(), filterPlayer, true)
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
    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))

    set filterIsNightTarget = Filter(function FilterIsNightTarget)
    call TriggerRegisterGameStateEventTimeOfDay(nightTrigger, GREATER_THAN_OR_EQUAL, 18.00)
    call TriggerRegisterGameStateEventTimeOfDay(nightTrigger, GREATER_THAN_OR_EQUAL, 0.00)
    call TriggerAddCondition(nightTrigger, Condition(function TriggerConditionNight))

    call TriggerRegisterGameStateEventTimeOfDay(dayTrigger, GREATER_THAN_OR_EQUAL, 6.00)
    call TriggerAddCondition(dayTrigger, Condition(function TriggerConditionDay))

    set filterIsValidSunwellResurrectionTarget = Filter(function FilterIsValidSunwellResurrectionTarget)
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call AddUnitTypeId(SHADE, HIGH_ELF_SWORDMAN)
    call AddUnitTypeId(BANSHEE, HIGH_ELF_ARCHER)
    call AddUnitTypeId(NECRO, HIGH_ELF_SORCERESS)
endfunction

endlibrary
