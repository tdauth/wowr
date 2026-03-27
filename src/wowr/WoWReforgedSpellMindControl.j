library WoWReforgedSpellMindControl initializer Init requires SimError, StringFormat, WoWReforgedAbilitySkill, WoWReforgedMapData

globals
    public constant integer ABILITY_ID = 'A22T'
    private trigger castTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    private force notAllowedPlayers = CreateForce()
endglobals

function GetMindControlDuration takes unit caster, integer abilityId, integer level returns real
    return 15.0 + I2R(level) * 5.0
endfunction

function AddNotAllowedPlayerForMindControl takes player whichPlayer returns nothing
    call ForceAddPlayer(notAllowedPlayers, whichPlayer)
endfunction

function ClearNotAllowedPlayerForMindControl takes nothing returns nothing
    call ForceClear(notAllowedPlayers)
endfunction

private function SharedAlliance takes player source, player target, boolean value returns nothing
    call SetPlayerAlliance(source, target, ALLIANCE_SHARED_CONTROL, value)
    call SetPlayerAlliance(source, target, ALLIANCE_SHARED_ADVANCED_CONTROL, value)
    call SetPlayerAlliance(source, target, ALLIANCE_SHARED_SPELLS, value)
endfunction

private function TimerFunctionExpire takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local player owner = LoadPlayerHandle(h, handleId, 0)
    local player targetOwner = LoadPlayerHandle(h, handleId, 1)
    call SharedAlliance(targetOwner, owner, false)
    set owner = null
    set targetOwner = null
    call PauseTimer(t)
    call FlushChildHashtable(h, handleId)
    call DestroyTimer(t)
    set t = null
endfunction

private function MindControlEx takes unit caster, unit target returns nothing
    local player owner = GetOwningPlayer(caster)
    local player targetOwner = GetOwningPlayer(target)
    local timer t = CreateTimer()
    local integer handleId = GetHandleId(t)
    local real duration = GetMindControlDuration(caster, ABILITY_ID, GetUnitAbilitySkillLevelSafe(caster, ABILITY_ID))
    call SharedAlliance(targetOwner, owner, true)
    call SavePlayerHandle(h, handleId, 0, owner)
    call SavePlayerHandle(h, handleId, 1, targetOwner)
    call TimerStart(t, duration, false, function TimerFunctionExpire)
    set owner = null
    set targetOwner = null
endfunction

function MindControl takes unit caster, unit target returns nothing
    local player owner = GetOwningPlayer(caster)
    local player targetOwner = GetOwningPlayer(target)
    if (not IsUnitAlly(target, owner)) then
        if (not IsPlayerInForce(targetOwner, notAllowedPlayers)) then
            call MindControlEx(caster, target)
        else
            call SimError(owner, Format(GetLocalizedString("OWNER_X_IS_NOT_ALLOWED")).s(GetPlayerName(targetOwner)).result())
            call IssueImmediateOrder(caster, "stop")
        endif
    else
        call SimError(owner, GetLocalizedString("TARGET_IS_ALLIED"))
        call IssueImmediateOrder(caster, "stop")
    endif
    set owner = null
    set targetOwner = null
endfunction

private function TriggerConditionCast takes nothing returns boolean
    if (GetSpellAbilityId() == ABILITY_ID) then
        call MindControl(GetTriggerUnit(), GetSpellTargetUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call AddNotAllowedPlayerForMindControl(GetMapBossesPlayer())
    
    call RegisterAbilityFieldCustomReal0(ABILITY_ID, GetMindControlDuration)
endfunction

endlibrary
