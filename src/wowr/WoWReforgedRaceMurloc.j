library WoWReforgedRaceMurloc initializer Init requires NewBonusUtils

globals
    private constant real PERIODIC_INTERVAL = 2.0

    private timer riverBankTimer = CreateTimer()
    private boolean riverBankTimerIsRunning = false
    private timer swarmingTimer = CreateTimer()
    private boolean swarmingTimerIsRunning = false
    private boolexpr filterIsRiverBankTarget = null
    private boolexpr filterIsSwarmingTarget = null
    private group riverBankGroup = CreateGroup()
    private group swarmingGroup = CreateGroup()
    private trigger channelTrigger = CreateTrigger()
    private trigger researchFinishTrigger = CreateTrigger()
endglobals

private function EnumRiverBank takes nothing returns nothing
    if (IsTerrainPathable(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), PATHING_TYPE_FLOATABILITY)) then
        call UnitAddAbility(GetEnumUnit(), 'A1IC')
        call AddUnitBonusTimed(GetEnumUnit(), BONUS_MOVEMENT_SPEED, 90.0, PERIODIC_INTERVAL)
        call AddUnitBonusTimed(GetEnumUnit(), BONUS_ATTACK_SPEED, 0.1, PERIODIC_INTERVAL)
    else
        call UnitRemoveAbility(GetEnumUnit(), 'A1IC')
    endif
endfunction

private function TimerFunctionRiverBank takes nothing returns nothing
    call ForGroup(riverBankGroup, function EnumRiverBank)
endfunction

private function StartRiverBankTimer takes nothing returns nothing
    if (not riverBankTimerIsRunning) then
        set riverBankTimerIsRunning = true
        call TimerStart(riverBankTimer, PERIODIC_INTERVAL, true, function TimerFunctionRiverBank)
    endif
endfunction

function AddMurlocRiverBank takes unit whichUnit returns nothing
    if (GetPlayerTechCountSimple(UPG_MURLOC_RIVER_BANK, GetOwningPlayer(whichUnit)) > 0 and GetUnitAbilityLevel(whichUnit, 'A1I7') > 0 and not IsUnitInGroup(whichUnit, riverBankGroup)) then
        call GroupAddUnit(riverBankGroup, whichUnit)
        call StartRiverBankTimer()
    endif
endfunction

function RemoveMurlocRiverBank takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, riverBankGroup)) then
        call GroupRemoveUnit(riverBankGroup, whichUnit)
        if (BlzGroupGetSize(riverBankGroup) == 0) then
            call PauseTimer(riverBankTimer)
            set riverBankTimerIsRunning = false
        endif
    endif
endfunction

private function EnumSwarming takes nothing returns nothing
    local group g = CreateGroup()
    // TODO Only of the same owner.
    call GroupEnumUnitsInRange(g, GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 1024.0, filterIsSwarmingTarget)
    if (BlzGroupGetSize(g) > 1) then // including the Murloc itself
        call UnitAddAbility(GetEnumUnit(), 'A1ID')
        call AddUnitBonusTimed(GetEnumUnit(), BONUS_MOVEMENT_SPEED, 90.0, PERIODIC_INTERVAL)
        call AddUnitBonusTimed(GetEnumUnit(), BONUS_ATTACK_SPEED, 0.1, PERIODIC_INTERVAL)
    else
         call UnitRemoveAbility(GetEnumUnit(), 'A1ID')
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TimerFunctionSwarming takes nothing returns nothing
    call ForGroup(swarmingGroup, function EnumSwarming)
endfunction

private function StartSwarmingTimer takes nothing returns nothing
    if (not swarmingTimerIsRunning) then
        set swarmingTimerIsRunning = true
        call TimerStart(swarmingTimer, PERIODIC_INTERVAL, true, function TimerFunctionSwarming)
    endif
endfunction

function AddMurlocSwarming takes unit whichUnit returns nothing
    if (GetPlayerTechCountSimple(UPG_MURLOC_SWARMING, GetOwningPlayer(whichUnit)) > 0 and GetUnitAbilityLevel(whichUnit, 'A1I6') > 0 and not IsUnitInGroup(whichUnit, swarmingGroup)) then
        call GroupAddUnit(swarmingGroup, whichUnit)
        call StartSwarmingTimer()
    endif
endfunction

function RemoveMurlocSwarming takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, swarmingGroup)) then
        call GroupRemoveUnit(swarmingGroup, whichUnit)
        if (BlzGroupGetSize(swarmingGroup) == 0) then
            call PauseTimer(swarmingTimer)
            set swarmingTimerIsRunning = false
        endif
    endif
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1VG') then
        call PlaySoundOnUnitBJ(gg_snd_MurlocSound, 100, GetTriggerUnit())
    endif
    return false
endfunction

private function RiverBank takes unit caster returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), filterIsRiverBankTarget)
    if (BlzGroupGetSize(g) > 0) then
        call GroupAddGroup(g, riverBankGroup)
        call StartRiverBankTimer()
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Swarming takes unit caster returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), filterIsSwarmingTarget)
    if (BlzGroupGetSize(g) > 0) then
        call GroupAddGroup(g, swarmingGroup)
        call StartSwarmingTimer()
    endif
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function FilterIsRiverBankTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A1I7') > 0
endfunction

private function FilterIsSwarmingTarget takes nothing returns boolean
    return GetUnitAbilityLevel(GetFilterUnit(), 'A1I6') > 0
endfunction

private function TriggerConditionResearchFinish takes nothing returns boolean
    if (GetResearched() == UPG_MURLOC_RIVER_BANK) then
        call RiverBank(GetTriggerUnit())
    elseif (GetResearched() == UPG_MURLOC_SWARMING) then
        call Swarming(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsRiverBankTarget = Filter(function FilterIsRiverBankTarget)
    set filterIsSwarmingTarget = Filter(function FilterIsSwarmingTarget)

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    call TriggerRegisterAnyUnitEventBJ(researchFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH )
    call TriggerAddCondition(researchFinishTrigger, Condition(function TriggerConditionResearchFinish))
endfunction

endlibrary
