library WoWReforegdHideout initializer Init requires SimError, StringFormat, WoWReforgedUtils

globals
    private trigger constructionTrigger = CreateTrigger()
    private trigger itemConstructionTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger upgradeTrigger = CreateTrigger()
    private trigger castTrigger = CreateTrigger()
endglobals

function IsHideout takes integer unitTypeId returns boolean
    if (unitTypeId == HIDEOUT) then
        return true
    elseif (unitTypeId == FORTIFIED_HIDEOUT) then
        return true
    elseif (unitTypeId == GUARDIANS_CITADEL) then
        return true
    endif
    return false
endfunction

function IsUnitHideout takes unit whichUnit returns boolean
    return IsHideout(GetUnitTypeId(whichUnit))
endfunction

function IsTier4 takes integer unitTypeId returns boolean
    if (unitTypeId == TEMPLE_OF_DARKNESS) then
        return true
    elseif (unitTypeId == TEMPLE_OF_LIGHT) then
        return true
    endif
    return false
endfunction

function IsUnitTier4 takes unit whichUnit returns boolean
    return IsTier4(GetUnitTypeId(whichUnit))
endfunction

function SetPlayerHideout takes unit whichUnit returns nothing
    set udg_Hideout[GetConvertedPlayerId(GetOwningPlayer(whichUnit))] = whichUnit
endfunction

private function TriggerConditionConstructionFinished takes nothing returns boolean
    if (IsUnitHideout(GetConstructedStructure())) then
        if (IsPlayerFreelancer(GetOwningPlayer(GetTriggerUnit()))) then
            if (udg_Hideout[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == null) then
                set udg_Hideout[GetConvertedPlayerId(GetTriggerPlayer())] = GetConstructedStructure()
            else
                call KillUnit(GetConstructedStructure())
                call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("HIDEHOUTS_ARE_LIMITED_TO_1"))
            endif
        else
            call KillUnit( GetConstructedStructure() )
            set udg_TmpString = GetLocalizedString("HIDEOUTS_ARE_RESTRUCTED")
            call SimError(GetOwningPlayer(GetTriggerUnit()), udg_TmpString)
        endif
    endif
    return false
endfunction

private function CheckHideoutLimitForPlayer takes unit caster returns boolean
    local player owner = GetOwningPlayer(caster)
    local integer playerIdConverted = GetConvertedPlayerId(owner)
    if (udg_Hideout[playerIdConverted] != null) then
        call IssueImmediateOrder(caster, "stop")
        call SimError(owner, Format(GetLocalizedString("REACHED_LIMIT_OF_X_FOR_Y")).i(1).s(GetObjectName(HIDEOUT)).result())
        set owner = null
            
        return false
    endif
    
    set owner = null
    
    return true
endfunction

private function TriggerConditionConstruct takes nothing returns boolean
    if (GetSpellAbilityId() == 'A01Z') then
        call CheckHideoutLimitForPlayer(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local integer converetdPlayerId = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (GetTriggerUnit() == udg_Hideout[converetdPlayerId]) then
        set udg_Hideout[converetdPlayerId] = null
    endif
    return false
endfunction

private function TriggerConditionUpgrade takes nothing returns boolean
    if (IsUnitHideout(GetTriggerUnit()) or IsUnitTier4(GetTriggerUnit())) then
        call UnitRemoveAbility(GetTriggerUnit(), ABILITY_SPELL_BOOK_HIDEOUT)
        call UnitAddAbility(GetTriggerUnit(), ABILITY_SPELL_BOOK_HIDEOUT)
    endif
    return false
endfunction

private function ShroudOfProtection takes unit caster returns nothing
    local unit dummy = CreateUnit(GetOwningPlayer(caster), ABILITY_SHROUD_OF_PROTECTION_DUMMY, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster))
    call UnitApplyTimedLife(dummy, 'BTLF', 60.0)
    call IssueImmediateOrder(dummy, "voodoo")
    set dummy = null
endfunction

private function TriggerConditionShroudOfProtection takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_SHROUD_OF_PROTECTION and IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE)) then
        call ShroudOfProtection(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionTrigger, Condition(function TriggerConditionConstructionFinished))

    call TriggerRegisterAnyUnitEventBJ(itemConstructionTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(itemConstructionTrigger, Condition(function TriggerConditionConstruct))
    
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(upgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(upgradeTrigger, Condition(function TriggerConditionUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionShroudOfProtection))
endfunction

endlibrary
