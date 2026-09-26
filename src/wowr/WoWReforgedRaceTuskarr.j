library WoWReforgedRaceTuskarr initializer Init requires Resources, WoWReforgedAbilitySkill

globals
    private timer fishTrapsTimer = CreateTimer()
    private group fishTraps = CreateGroup()
    private group array burialPlaces // In theory there can be only one per player right now.
    private trigger damagedTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
endglobals

private function EnumFishTrap takes nothing returns nothing
    call AddPlayerResource(GetOwningPlayer(GetEnumUnit()), RESOURCE_MEAT, 20 + GetUnitAbilityLevel(GetEnumUnit(), 'A1GL') * 5)
endfunction

private function TimerFunctionFishTraps takes nothing returns nothing
    call ForGroup(fishTraps, function EnumFishTrap)
endfunction

function AddFishTrap takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, fishTraps)) then
        call GroupAddUnit(fishTraps, whichUnit)
        if (BlzGroupGetSize(fishTraps) == 1) then
            call TimerStart(fishTrapsTimer, 20.0, true, function TimerFunctionFishTraps)
        endif
    endif
endfunction

function RemoveFishTrap takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, fishTraps)) then
        call GroupRemoveUnit(fishTraps, whichUnit)
        if (BlzGroupGetSize(fishTraps) == 0) then
            call PauseTimer(fishTrapsTimer)
        endif
    endif
endfunction

function AddBurialPlace takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    if (not IsUnitInGroup(whichUnit, burialPlaces[playerId])) then
        call GroupAddUnit(burialPlaces[playerId], whichUnit)
    endif
endfunction

function RemoveBurialPlace takes unit whichUnit returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(whichUnit))
    if (IsUnitInGroup(whichUnit, burialPlaces[playerId])) then
        call GroupRemoveUnit(burialPlaces[playerId], whichUnit)
    endif
endfunction

private function TriggerConditionDamaged takes nothing returns boolean
    if (GetUnitAbilityLevel(GetTriggerUnit(), 'A1GK') > 0 and BlzGetEventDamageType() == DAMAGE_TYPE_COLD) then
        call SetUnitLifeBJ(GetTriggerUnit(), GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) + GetEventDamage())
    endif
    return false
endfunction

private function EnumBurialPlace takes nothing returns nothing
    if (GetUnitAbilityLevel(GetEnumUnit(), 'A1I5') < 8) then
        call SkillAbility(GetEnumUnit(), ABILITY_DEVOTION_AURA, GetUnitAbilitySkillLevel(GetEnumUnit(), ABILITY_DEVOTION_AURA) + 1)
        call SkillAbility(GetEnumUnit(), ABILITY_BRILLIANCE_AURA, GetUnitAbilitySkillLevel(GetEnumUnit(), ABILITY_BRILLIANCE_AURA) + 1)
    endif
endfunction

function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitEnemy(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit()))) then
        call ForGroup(burialPlaces[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], function EnumBurialPlace)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set burialPlaces[i] = CreateGroup()
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(damagedTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(damagedTrigger, Condition(function TriggerConditionDamaged))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary

