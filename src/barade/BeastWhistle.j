library BeastWhistle initializer Init requires SimError, SafeString

globals
    public constant integer ABILITY_ID = 'A0MN'

    private trigger channelTrigger = CreateTrigger()
    private player filterPlayer = null
endglobals

private function FilterIsAlliedSummonedUnit takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAlly(GetFilterUnit(), filterPlayer)
endfunction

private function EnumApplyTimedLife takes nothing returns nothing
    call UnitApplyTimedLife(GetEnumUnit(), 'BTLF', 60.0)
endfunction

private function BeastWhistle takes unit caster, real x, real y returns nothing
    local group targets = CreateGroup()
    set filterPlayer = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(targets, x, y, 512.0, Condition(function FilterIsAlliedSummonedUnit))
    if (BlzGroupGetSize(targets) > 0) then
        call ForGroup(targets, function EnumApplyTimedLife)
    else
        call IssueImmediateOrder(caster, "stop")
        call SimError(GetOwningPlayer(caster) , GetLocalizedStringSafe("NO_VALID_TARGETS_IN_THIS_AREA"))
    endif
    call GroupClear(targets)
    call DestroyGroup(targets)
    set targets = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call BeastWhistle(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
