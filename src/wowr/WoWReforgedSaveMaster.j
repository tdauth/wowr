library WoWReforgedSaveMaster initializer Init requires SimError, SafeString, WoWReforgedSaveCodeObjects

globals
    private group array includedUnits
    private group array excludedUnits
    private trigger channelTrigger = CreateTrigger()
endglobals

function GetPlayerIncludedSaveUnits takes player whichPlayer returns group
    return includedUnits[GetPlayerId(whichPlayer)]
endfunction

function GetPlayerExcludedSaveUnits takes player whichPlayer returns group
    return excludedUnits[GetPlayerId(whichPlayer)]
endfunction

private function EnumPing takes nothing returns nothing
    call UnitAddIndicatorBJ(GetEnumUnit(), 100, 100, 100, 0)
endfunction

private function IncludeUnit takes player owner, unit whichUnit returns nothing
    local integer playerId = GetPlayerId(owner)
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer saveObjectUnit = GetSaveObjectUnitType(unitTypeId)
    local integer saveObjectBuilding = GetSaveObjectBuildingType(unitTypeId)
    if (saveObjectUnit != -1 and saveObjectBuilding != -1) then
        if (not IsUnitInGroup(whichUnit, includedUnits[playerId])) then
            call GroupRemoveUnit(excludedUnits[playerId], whichUnit)
            call GroupAddUnit(includedUnits[playerId], whichUnit)
            call DisplayTextToForce(bj_FORCE_PLAYER[playerId], GetLocalizedStringSafe("INCLUDED_UNIT"))
        else
            call SimError(owner, GetLocalizedStringSafe("UNIT_ALREADY_INCLUDED"))
        endif
    else
        call SimError(owner, GetLocalizedStringSafe("INVALID_TARGET"))
    endif
endfunction

private function ExcludeUnit takes player owner, unit whichUnit returns nothing
    local integer playerId = GetPlayerId(owner)
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer saveObjectUnit = GetSaveObjectUnitType(unitTypeId)
    local integer saveObjectBuilding = GetSaveObjectBuildingType(unitTypeId)
    if (saveObjectUnit != -1 and saveObjectBuilding != -1) then
        if (not IsUnitInGroup(whichUnit, excludedUnits[playerId])) then
            call GroupRemoveUnit(includedUnits[playerId], whichUnit)
            call GroupAddUnit(excludedUnits[playerId], whichUnit)
            call DisplayTextToForce(bj_FORCE_PLAYER[playerId], GetLocalizedStringSafe("EXCLUDED_UNIT"))
        else
            call SimError(owner, GetLocalizedStringSafe("UNIT_ALREADY_EXCLUDED"))
        endif
    else
        call SimError(owner, GetLocalizedStringSafe("INVALID_TARGET"))
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (abilityId == 'A09Y') then // ping included
        call ForGroup(includedUnits[playerId], function EnumPing)
    elseif (abilityId == 'A09Z') then // ping excluded
        call ForGroup(excludedUnits[playerId], function EnumPing)
    elseif (abilityId == 'A09U') then // clear included
        call GroupClear(includedUnits[playerId])
        call DisplayTextToForce(bj_FORCE_PLAYER[playerId], GetLocalizedStringSafe("CLEARED_INCLUDED"))
    elseif (abilityId == 'A09V') then // clear excluded
        call GroupClear(excludedUnits[playerId])
        call DisplayTextToForce(bj_FORCE_PLAYER[playerId], GetLocalizedStringSafe("CLEARED_EXCLUDED"))
    elseif (abilityId == 'A09S') then // include unit
        call IncludeUnit(GetOwningPlayer(GetTriggerUnit()), GetSpellTargetUnit())
    elseif (abilityId == 'A09T') then // exclude unit
        call ExcludeUnit(GetOwningPlayer(GetTriggerUnit()), GetSpellTargetUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set includedUnits[i] = CreateGroup()
        set excludedUnits[i] = CreateGroup()
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsUnitInGroup(whichUnit, includedUnits[i])) then
            call GroupRemoveUnit(includedUnits[i], whichUnit)
        endif
                if (IsUnitInGroup(whichUnit, excludedUnits[i])) then
            call GroupRemoveUnit(excludedUnits[i], whichUnit)
        endif
        set i = i + 1
    endloop
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
