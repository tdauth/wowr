library WoWReforgedRaceKulTiras initializer Init requires SimError, OnUnitRemoval

globals
    private group ghosts = CreateGroup()
    private player filterPlayer = null
    private boolexpr filter = null
    private trigger deathTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    if (not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and GetUnitAbilityLevel(GetTriggerUnit(), 'A0RI') > 0 and GetPlayerTechCountSimple('R06O', GetOwningPlayer(GetTriggerUnit())) > 0 and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) and not IsUnitInGroup(GetTriggerUnit(), ghosts)) then
        // Spawn Ghost
        call ReplaceUnitBJ(GetTriggerUnit(), GetUnitTypeId(GetTriggerUnit()), bj_UNIT_STATE_METHOD_DEFAULTS)
        call UnitApplyTimedLife(GetLastReplacedUnitBJ(), 'BTLF', 60.0)
        call SetUnitVertexColorBJ(GetLastReplacedUnitBJ(), 70.00, 100, 0.00, 70.00)
        call SetUnitUseFood(GetLastReplacedUnitBJ(), false)
        call GroupAddUnit(ghosts, GetLastReplacedUnitBJ())
        call SetUnitExploded(GetLastReplacedUnitBJ(), false)
    elseif (IsUnitInGroup(GetTriggerUnit(), ghosts)) then
        call GroupRemoveUnit(ghosts, GetTriggerUnit())
    endif
    return false
endfunction

private function FilterIsValidTarget takes nothing returns boolean
    return IsUnitInGroup(GetFilterUnit(), ghosts) and IsUnitAlly(GetFilterUnit(), filterPlayer)
endfunction

private function EnumResurrectGhost takes nothing returns nothing
    call GroupRemoveUnit(ghosts, GetEnumUnit())
    call CreateUnit(GetOwningPlayer(GetEnumUnit()), GetUnitTypeId(GetEnumUnit()), GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), GetUnitFacing(GetEnumUnit()))
    call RemoveUnit(GetEnumUnit())
endfunction

private function ResurrectGhosts takes unit caster, real x, real y returns nothing
    local group g = CreateGroup()
    set filterPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, x, y, 512.0, filter)
    if (BlzGroupGetSize(g) > 0) then
        call ForGroup(g, function EnumResurrectGhost)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("NO_VALID_TARGETS"))
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0S7') then // Resurrect Ghosts
        call ResurrectGhosts(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, ghosts)) then
        call GroupRemoveUnit(ghosts, whichUnit)
    endif
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsValidTarget)

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call OnUnitRemoval(HookRemoveUnit)
endfunction

endlibrary
