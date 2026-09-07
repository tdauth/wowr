library WoWReforgedProfessionTamer initializer Init requires SimError, WoWReforgedUtils

globals
    private player filterPlayer = Player(0)
    private trigger changeOwnerTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
    private trigger damageTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()

    private integer array baitAbilityIds
    private integer array baitAbilityLevels
    private integer baitAbilityIdsCounter = 0
endglobals

private function AddBaitAbility takes integer abilityId, integer level returns nothing
    local integer index = baitAbilityIdsCounter
    set baitAbilityIds[index] = abilityId
    set baitAbilityLevels[index] = level
    set baitAbilityIdsCounter = baitAbilityIdsCounter + 1
endfunction

private function GetBaitAbilityByAbilityId takes integer abilityId returns integer
    local integer i = 0
    loop
        exitwhen (i >= baitAbilityIdsCounter)
        if (baitAbilityIds[i] == abilityId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function FilterIsCage takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == CAGE_TAMER and GetOwningPlayer(GetFilterUnit()) == filterPlayer
endfunction

private function Multiply takes unit whichUnit returns nothing
    local integer id = GetUnitTypeId(whichUnit)
    local real x = GetUnitX(whichUnit)
    local real y = GetUnitY(whichUnit)
    local real face = GetUnitFacing(whichUnit)
    local group g = CreateGroup()
    local integer count = 0
    set filterPlayer = GetOwningPlayer(whichUnit)
    call GroupEnumUnitsInRange(g, x, y, 800.0, Filter(function FilterIsCage))
    set count = BlzGroupGetSize(g)
    if (count > 0) then
        loop
            set count = count - 1
            exitwhen (count < 0)
            call CreateUnit(filterPlayer, id, x, y, face)
        endloop
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionChangeOwner takes nothing returns boolean
    if (not IsUnitType(GetTriggerUnit(), UNIT_TYPE_MECHANICAL)) then
        call Multiply(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer index = GetBaitAbilityByAbilityId(GetSpellAbilityId())
    local integer level = 0
    if (index != -1) then
        if (GetOwningPlayer(GetSpellTargetUnit()) == Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
            set level = baitAbilityLevels[index]
            if (GetUnitBaseLevel(GetSpellTargetUnit()) <= level) then
                call SetUnitOwner( GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit()), true )
            else
                call IssueImmediateOrder(GetTriggerUnit(), "stop")
                call SimError(GetOwningPlayer(GetTriggerUnit()), Format(GetLocalizedString("TARGET_MUST_BE_MAX_LEVEL_X")).i(level).result())
            endif
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TARGET_MUST_BE_A_CREEP"))
        endif
    endif
    return false
endfunction

private function TriggerConditionDamage takes nothing returns boolean
    if (GetUnitTypeId(GetTriggerUnit()) == MONSTER_LURE and GetOwningPlayer(GetEventDamageSource()) == Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
        if (GetUnitBaseLevel(GetEventDamageSource()) <= 9) then
            call BlzUnitInterruptAttack(GetEventDamageSource())
            call SetUnitOwner(GetEventDamageSource(), GetOwningPlayer(GetTriggerUnit()), true)
            call KillUnit(GetTriggerUnit())
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), Format(GetLocalizedString("TARGET_MUST_BE_MAX_LEVEL_X")).i(9).result())
        endif
    endif
    return false
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == MONSTER_LURE) then
        call SetUnitOwner(GetSummonedUnit(), GetOwningPlayer(GetSummoningUnit()), true)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damageTrigger, Condition(function TriggerConditionDamage))

    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))

    call AddBaitAbility('A192', 3)
    call AddBaitAbility('A193', 5)
    call AddBaitAbility('A195', 7)
endfunction

endlibrary
