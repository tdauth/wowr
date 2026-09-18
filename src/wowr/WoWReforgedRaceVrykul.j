library WoWReforgedRaceVrykul initializer Init requires OnUnitRemoval, WoWReforgedRaces

globals
    private boolexpr filterIsHall = null
    private hashtable h = InitHashtable()
    private group champions = CreateGroup()
    private group halls = CreateGroup()
    private trigger deathTrigger = CreateTrigger()
endglobals

function AddHallOfValor takes unit whichUnit returns nothing
    if (not IsUnitInGroup(whichUnit, halls)) then
        call GroupAddUnit(halls, whichUnit)
    endif
endfunction

function RemoveHallOfValor takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, halls)) then
        call GroupRemoveUnit(halls, whichUnit)
    endif
endfunction

private function FilterIsHall takes nothing returns boolean
    return IsUnitInGroup(GetFilterUnit(), halls)
endfunction

private function CountHallsOfPlayer takes player whichPlayer returns integer
    local group g = CreateGroup()
    local integer count = 0
    call GroupEnumUnitsOfPlayer(g, whichPlayer, filterIsHall)
    set count = BlzGroupGetSize(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return count
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (GetKillingUnit() != null and not IsUnitType(GetKillingUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetKillingUnit(), UNIT_TYPE_HERO)) then // Champion kills
        if (GetObjectRace(GetUnitTypeId(GetKillingUnit())) == udg_RaceVrykul and IsUnitInGroup(GetKillingUnit(), champions)) then
            if (CountHallsOfPlayer(GetOwningPlayer(GetKillingUnit())) > 0) then
                call SaveInteger(h, GetHandleId(GetKillingUnit()), 0, LoadInteger(h, GetHandleId(GetKillingUnit()), 0) + 1)
                if (LoadInteger(h, GetHandleId(GetKillingUnit()), 0) == 3) then
                    call GroupAddUnit(champions, GetKillingUnit())
                    call FlushChildHashtable(h, GetHandleId(GetKillingUnit()))
                endif
            endif
        endif
    endif
    if (IsUnitInGroup(GetTriggerUnit(), champions)) then // Champion dies
        return true
    endif
    return false
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local unit dummy = null
    call GroupRemoveUnit(champions, GetTriggerUnit())
    set dummy = CreateUnit(GetOwningPlayer(GetTriggerUnit()), 'h0CG', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), bj_UNIT_FACING)
    call IssueImmediateOrder(dummy, "resurrection")
    call ShowUnit(dummy, false)
    call PolledWait(2.0)
    call RemoveUnit(dummy)
    set dummy = null
endfunction

private function HookRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
    if (IsUnitInGroup(whichUnit, champions)) then
        call GroupRemoveUnit(champions, whichUnit)
    endif
endfunction

private function Init takes nothing returns nothing
    set filterIsHall = Filter(function FilterIsHall)
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)

    call OnUnitRemoval(HookRemoveUnit)
endfunction

endlibrary
