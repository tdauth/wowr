library WowReforgedSpellMultiply initializer Init requires SimError, WoWReforgedRaces, WoWReforgedBosses, WoWReforgedAbilitySkill

globals
    public constant integer ABILITY_ID = ABILITY_MULTIPLY
    public constant integer BUFF_ID = 'BFig'
    public constant real DURATION = 60.0

    private trigger castTrigger = CreateTrigger()
endglobals

function GetMultiplyCopies takes unit caster, integer abilityId, integer level returns integer
    return level
endfunction

function MultiplyUnit takes unit caster, unit target returns nothing
    local integer i = 0
    local unit copy = null
    local item copyItem = null
    local integer factor = GetMultiplyCopies(caster, ABILITY_ID, GetUnitAbilitySkillLevelSafe(caster, ABILITY_ID))
    if (IsUnitAlly(target, GetOwningPlayer(caster)) and not IsUnitType(target, UNIT_TYPE_HERO) and not IsUnitType(target, UNIT_TYPE_PEON) and not IsUnitType(target, UNIT_TYPE_TOWNHALL)) then
        if (IsUnitType(target, UNIT_TYPE_STRUCTURE)) then
            set copyItem = WrapUpBuilding(GetUnitX(target), GetUnitY(target), target)
            if (copyItem != null) then
                call SetItemCharges(copyItem, factor)
            else
                call IssueImmediateOrder(caster, "stop")
                call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_BUILDING"))
            endif
        else
            set i = 0
            loop
                exitwhen (i == factor)
                set copy = CreateUnit(GetOwningPlayer(caster), GetUnitTypeId(target), GetUnitX(target), GetUnitY(target), GetUnitFacing(target))
                
                //call ApplyAllMaxHpResearches(GetSummonedUnit(), null)
                call SetUnitState(copy, UNIT_STATE_MAX_MANA, GetUnitState(target, UNIT_STATE_MAX_MANA))
                //call SetUnitState(copy, UNIT_STATE_MAX_LIFE, GetUnitState(target, UNIT_STATE_MAX_LIFE))
                call BlzSetUnitMaxHP(copy, BlzGetUnitMaxHP(target))
                //call SetUnitState(copy, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA))
                call BlzSetUnitMaxMana(copy, BlzGetUnitMaxMana(target))
                call SetUnitState(copy, UNIT_STATE_LIFE, GetUnitState(target, UNIT_STATE_LIFE))
                call BlzSetUnitIntegerField(copy, UNIT_IF_LEVEL, BlzGetUnitIntegerField(target, UNIT_IF_LEVEL))
                call BlzSetUnitRealField(copy, UNIT_RF_DEFENSE, BlzGetUnitRealField(target, UNIT_RF_DEFENSE))
                call UnitApplyTimedLife(copy, BUFF_ID, DURATION)
                call UnitAddType(copy, UNIT_TYPE_SUMMONED)
                set i = i + 1
            endloop
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET"))
    endif
endfunction

function MultiplyItem takes unit caster, item target returns item
    local item copy = null
    local integer factor = GetUnitAbilityLevel(caster, ABILITY_ID)
    if (not IsItemInvulnerable(target) and not IsLegendaryItem(target)) then
        set copy = CreateItem(GetItemTypeId(target), GetItemX(target), GetItemY(target))
        if (GetItemCharges(target) > 1) then
            call SetItemCharges(copy, factor)
        endif
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster), GetLocalizedString("INVALID_TARGET"))
    endif
    return copy
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        if (GetSpellTargetUnit() != null) then
            call MultiplyUnit(GetTriggerUnit(), GetSpellTargetUnit())
        elseif (GetSpellTargetItem() != null) then
            call MultiplyItem(GetTriggerUnit(), GetSpellTargetItem())
        else
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("INVALID_TARGET"))
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call RegisterAbilityFieldCustomInteger0(ABILITY_ID, GetMultiplyCopies)
endfunction

endlibrary
