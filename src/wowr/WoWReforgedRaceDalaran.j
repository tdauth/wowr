library WoWReforgedRaceDalaran initializer Init requires SimError, OnUnitRemoval, WoWReforgedMapData

globals
    private hashtable h = InitHashtable()
    private weathereffect array shieldWeatherEffects
    private integer shieldWeatherEffectsCounter = 1
    private group powerGenerators = CreateGroup()
    private unit enumPowerGenerator = null
    private boolexpr filterIsEnemyOfPowerGenerator = null
    private trigger castTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger timerTrigger = CreateTrigger()
endglobals

private function AddShieldWeatherEffect takes weathereffect w returns integer
    local integer index = shieldWeatherEffectsCounter
    set shieldWeatherEffects[index] = w
    set shieldWeatherEffectsCounter = shieldWeatherEffectsCounter + 1
    return index
endfunction

private function GetShieldWeatherEffect takes integer index returns weathereffect
    return shieldWeatherEffects[index]
endfunction

private function FreeShieldWeatherEffect takes integer index returns nothing
    local integer i = index
    local integer j = i + 1
    loop
        exitwhen (j >= shieldWeatherEffectsCounter)
        set shieldWeatherEffects[i] = shieldWeatherEffects[j]
        set i = i + 1
        set j = i + 1
    endloop
    set shieldWeatherEffectsCounter = i
endfunction

private function EnableDalaranShield takes unit powerGenerator returns nothing
    local integer handleId = GetHandleId(powerGenerator)
    local location pos = GetUnitLoc(powerGenerator)
    local rect where = GetRectFromCircleBJ(pos, 500.0)
    local weathereffect w = AddWeatherEffect(where, 'MEds')
    call EnableWeatherEffect(w, true)
    call GroupAddUnit(powerGenerators, powerGenerator)
    call SaveRectHandle(h, handleId, 0, where)
    call SaveInteger(h, handleId, 1, AddShieldWeatherEffect(w))
    call RemoveLocation(pos)
    set pos = null
    set where = null
    set w = null
endfunction

private function GetDalaranShieldRect takes unit powerGenerator returns rect
    local integer handleId = GetHandleId(powerGenerator)
    return LoadRectHandle(h, handleId, 0)
endfunction

private function DisableDalaranShield takes unit powerGenerator returns nothing
    local integer handleId = GetHandleId(powerGenerator)
    local integer weatherEffectIndex = LoadInteger(h, handleId, 1)
    local weathereffect w = null
    local rect where = LoadRectHandle(h, handleId, 0)

    if (weatherEffectIndex > 0) then
        set w = GetShieldWeatherEffect(weatherEffectIndex)
        if (w != null) then
            call EnableWeatherEffect(w, false)
            call RemoveWeatherEffect(w)
        endif
        call FreeShieldWeatherEffect(weatherEffectIndex)
        set w = null
    endif

    if (where != null) then
        call RemoveRect(where)
        set where = null
    endif

    call GroupRemoveUnit(powerGenerators, powerGenerator)
endfunction

private function IsDalaranShieldEnabled takes unit powerGenerator returns boolean
    return IsUnitInGroup(powerGenerator, powerGenerators)
endfunction

private function DalaranShieldsAreEmpty takes nothing returns boolean
    return BlzGroupGetSize(powerGenerators) == 0
endfunction

private function RemoveDalaranPowerGenerator takes unit whichUnit returns nothing
    if (IsDalaranShieldEnabled(whichUnit)) then
        call DisableDalaranShield(whichUnit)
        if (DalaranShieldsAreEmpty()) then
            call DisableTrigger(timerTrigger)
        endif
    endif
endfunction

private function Blink takes unit whichUnit, real x, real y returns nothing
    if (not IsMaskedToPlayer(x, y, GetOwningPlayer(whichUnit))) then
        if (MapLocationCanBeTeleportedTo(whichUnit, x, y)) then
            call SetUnitPosition(whichUnit, x, y)
        else
            call IssueImmediateOrder(whichUnit, "stop")
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("CANNOT_TELEPORT_INTO_THIS_AREA"))
        endif
    else
        call IssueImmediateOrder(whichUnit, "stop")
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("TARGET_LOCATION_MUST_BE_VISIBLE"))
    endif
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (abilityId == 'A0NI') then // Enable Dalaran Shield
        if (not IsDalaranShieldEnabled(GetTriggerUnit())) then
            call EnableDalaranShield(GetTriggerUnit())
            call EnableTrigger(timerTrigger)
            call UnitRemoveAbility(GetTriggerUnit(), abilityId)
            call UnitAddAbility(GetTriggerUnit(), 'A0O7')
        endif
    elseif (abilityId == 'A0O7') then // Disable Dalaran Shield
        if (IsDalaranShieldEnabled(GetTriggerUnit())) then
            call DisableDalaranShield(GetTriggerUnit())
            if (DalaranShieldsAreEmpty()) then
                call DisableTrigger(timerTrigger)
            endif
            call UnitRemoveAbility(GetTriggerUnit(), abilityId)
            call UnitAddAbility(GetTriggerUnit(), 'A0NI')
        endif
    elseif (abilityId == 'A01E') then // Blink
        call Blink(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    call RemoveDalaranPowerGenerator(GetTriggerUnit())
    return false
endfunction

private function FilterIsEnemyOfPowerGenerator takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(enumPowerGenerator))
endfunction

private function EnumDamage takes nothing returns nothing
    call UnitDamageTargetBJ(enumPowerGenerator, GetEnumUnit(), GetUnitState(GetEnumUnit(), UNIT_STATE_MAX_LIFE) / 100.0 * I2R(GetPlayerTechCountSimple('R05R', GetOwningPlayer(enumPowerGenerator))) * 2.0, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
endfunction

private function EnumTimer takes nothing returns nothing
    local group g = CreateGroup()
    set enumPowerGenerator = GetEnumUnit()
    call GroupEnumUnitsInRect(g, GetDalaranShieldRect(GetEnumUnit()), filterIsEnemyOfPowerGenerator)
    set enumPowerGenerator = GetEnumUnit()
    call ForGroup(g, function EnumDamage)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionTimer takes nothing returns boolean
    call ForGroup(powerGenerators, function EnumTimer)
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsEnemyOfPowerGenerator = Filter(function FilterIsEnemyOfPowerGenerator)
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call DisableTrigger(timerTrigger)
    call TriggerRegisterTimerEventPeriodic(timerTrigger, 4.0)
    call TriggerAddCondition(timerTrigger, Condition(function TriggerConditionTimer))

    call OnUnitRemoval(RemoveDalaranPowerGenerator)
endfunction

endlibrary
