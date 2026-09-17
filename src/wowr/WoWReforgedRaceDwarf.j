library WoWReforgedRaceDwarf initializer Init requires MathUtils, TreeUtils, OnUnitRemoval

globals
    private boolexpr filter = null
    private real filterX = 0.0
    private real filterY = 0.0
    private real filterRadius = 0.0
    private hashtable h = InitHashtable()
    private timer t = CreateTimer()
    private group lumberMills = CreateGroup()
    private group runeOfRebirthTargets = CreateGroup()
    private trigger castTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger anyCastTrigger = CreateTrigger()
    private trigger anyUpgradeTrigger = CreateTrigger()
endglobals

private function EnumPickFirstLivingTreeInCircleFilter takes nothing returns boolean
    if (bj_destRandomCurrentPick == null and IsDestructableAliveBJ(GetFilterDestructable()) and IsDestructableTree(GetFilterDestructable()) and DistanceBetweenCoordinates(GetDestructableX(GetFilterDestructable()), GetDestructableY(GetFilterDestructable()), filterX, filterY) <= filterRadius) then
        set bj_destRandomCurrentPick = GetFilterDestructable()
    endif
    return false
endfunction

private function RandomLivingTreeDestructableInCircle takes real x, real y, real radius returns destructable
    set filterX = x
    set filterY = y
    set filterRadius = radius
    set bj_destRandomCurrentPick = null
    call EnumDestructablesInCircle(x, y, radius, filter, null)
    return bj_destRandomCurrentPick
endfunction

private function EnumIssueOrderReturnResources takes nothing returns nothing
    call IssueImmediateOrder(GetEnumUnit(), "returnresources")
endfunction

private function EnumPickNearbyTree takes nothing returns nothing
    local destructable d = LoadDestructableHandle(h, GetHandleId(GetEnumUnit()), 0)
    if (d == null or IsDestructableDeadBJ(d)) then
        set d = RandomLivingTreeDestructableInCircle(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 4000.0)
        if (d != null) then
            call IssueTargetOrder(GetEnumUnit(), "harvest", d)
            call SaveDestructableHandle(h, GetHandleId(GetEnumUnit()), 0, d)
        endif
    else
        call IssueTargetOrder(GetEnumUnit(), "harvest", d)
    endif
endfunction

private function TimerFunctionUpdateLumberMills takes nothing returns nothing
    call ForGroup(lumberMills, function EnumIssueOrderReturnResources)
    call PolledWait(5.0)
    call ForGroup(lumberMills, function EnumPickNearbyTree)
endfunction

function AddDwarfLumberMill takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, lumberMills)) then
        call GroupAddUnit(lumberMills, whichUnit)
        call TimerStart(t, 30.0, true, function TimerFunctionUpdateLumberMills)
    endif
endfunction

function RemoveDwarfLumberMill takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, lumberMills)) then
        call GroupRemoveUnit(lumberMills, whichUnit)
        call FlushChildHashtable(h, GetHandleId(whichUnit))
        if (IsUnitGroupEmptyBJ(lumberMills)) then
            call PauseTimer(t)
        endif
    endif
endfunction

function AddDwarfMineShaft takes unit whichUnit returns nothing
    call SetResourceAmount(whichUnit, 1000000)
endfunction

function RemoveDwarfMineShaft takes unit whichUnit returns nothing
    call ReplaceUnitBJ(whichUnit, 'ngol', bj_UNIT_STATE_METHOD_DEFAULTS )
    call SetUnitOwner(GetLastReplacedUnitBJ(), Player(PLAYER_NEUTRAL_PASSIVE), true)
    call SetResourceAmount(GetLastReplacedUnitBJ(), 1000000)
endfunction

private function RuneOfRebirth takes unit caster, unit target returns nothing
    if (not IsUnitInGroup(target, runeOfRebirthTargets)) then
        if (not IsUnitType(target, UNIT_TYPE_RESISTANT)) then
            call GroupAddUnit(runeOfRebirthTargets, target)
        else
            call IssueImmediateOrder(caster, "stop")
            call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET"))
        endif
    else
        call IssueImmediateOrder(caster, "stop" )
        call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == 'A0EL') then // Sleep Form
        if (GetUnitTypeId(GetTriggerUnit()) == 'n04X') then // Start
            call SetUnitAnimation(GetTriggerUnit(), "sleep")
        elseif (GetUnitTypeId(GetTriggerUnit()) == 'n052') then // End
            call SetUnitAnimation(GetTriggerUnit(), "stand" )
        endif
    elseif (GetSpellAbilityId() == 'A0E0') then // Breeding Form
        if (GetUnitTypeId(GetTriggerUnit()) == 'n04V') then // Start
            call SetUnitAnimation(GetTriggerUnit(), "upgrade first")
        elseif (GetUnitTypeId(GetTriggerUnit()) == 'n04Y') then // End
            call SetUnitAnimation(GetTriggerUnit(), "stand alternate")
            call UnitRemoveAbility(GetTriggerUnit(), 'ARal')
        endif
    elseif (GetSpellAbilityId() == 'A0EE') then // Rune of Rebirth
        call RuneOfRebirth(GetTriggerUnit(), GetSpellTargetUnit())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitInGroup(GetTriggerUnit(), runeOfRebirthTargets)) then
        call GroupRemoveUnit(runeOfRebirthTargets, GetTriggerUnit())
        call UnitDropItem(GetTriggerUnit(), 'rreb')
    endif
    return false
endfunction

private function IsDwarfMineShaft takes integer unitTypeId returns boolean
    return unitTypeId == DWARF_MINE_AI or unitTypeId == DWARF_HOUSING or unitTypeId == DWARF_MINE_2 or unitTypeId == DWARF_MINE_3
endfunction

private function TriggerConditionAnyCast takes nothing returns boolean
    if ((GetSpellAbilityId() == 'S00H' or GetSpellAbilityId() == 'S00I') and IsDwarfMineShaft(GetUnitTypeId(GetTriggerUnit()))) then // Dwarf Mine Chaos
        call AddDwarfMineShaft(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionAnyUpgrade takes nothing returns boolean
    if (IsDwarfMineShaft(GetUnitTypeId(GetTriggerUnit()))) then
        call AddDwarfMineShaft(GetTriggerUnit())
    endif
    return false
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    call GroupRemoveUnit(runeOfRebirthTargets, GetTriggerUnit())
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function EnumPickFirstLivingTreeInCircleFilter)

    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(anyCastTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerRegisterAnyUnitEventBJ(anyCastTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerRegisterAnyUnitEventBJ(anyCastTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerRegisterAnyUnitEventBJ(anyCastTrigger, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerRegisterAnyUnitEventBJ(anyCastTrigger, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    call TriggerAddCondition(anyCastTrigger, Condition(function TriggerConditionAnyCast))

    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_START)
    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_RESEARCH_START)
    call TriggerRegisterAnyUnitEventBJ(anyUpgradeTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerAddCondition(anyUpgradeTrigger, Condition(function TriggerConditionAnyUpgrade))

    call OnUnitRemoval(HookRemoveUnit)
endfunction

endlibrary
