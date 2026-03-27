library WoWReforgedCages initializer Init

function IsCage takes integer unitTypeId returns boolean
    return unitTypeId == CAGE_0 or unitTypeId == CAGE_1 or unitTypeId == CAGE_2
endfunction

function IsUnitCage takes unit whichUnit returns boolean
    return IsCage(GetUnitTypeId(whichUnit))
endfunction

globals
    private trigger deathTrigger = CreateTrigger()
endglobals

private function SpawnRandomCreep takes unit cage, unit killer returns unit
    local player owner = GetOwningPlayer(killer)
    local unit creep = null
    if (killer == null) then
        set owner = udg_Gaia
    endif
    set creep = CreateUnit(owner, ChooseRandomCreep(GetRandomInt(1, 10)), GetUnitX(cage), GetUnitY(cage), GetUnitFacing(cage))
    call UnitApplyTimedLife(creep, 'B000', 60.0)
    set owner = null
    return creep
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitCage(GetTriggerUnit())) then
        call SpawnRandomCreep(GetTriggerUnit(), GetKillingUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary
