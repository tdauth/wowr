library Aura initializer Init requires NewBonusUtils, OpLimit, HeroUtils

globals
    public constant real TIMER_UPDATE_INTERVAL = 0.5 // Standard Warcraft III aura update interval
    public constant real BUFF_DURATION = 0.5
    private hashtable h = InitHashtable()
    private timer t = CreateTimer()
    private trigger learnTrigger = CreateTrigger()
    private trigger unlearnTrigger = CreateTrigger()
    
    private Aura tmpAura = 0
endglobals

function GetAuraTimerHandleId takes nothing returns integer
    return GetHandleId(h)
endfunction

function interface AuraFilterFunction takes unit caster, unit target, integer abilityId returns boolean

private function OrderGroupByPriority takes group t returns group
    local group r = CreateGroup()
    local integer j = 0
    local unit memberJ
    local unit memberI
    local unit tmp
    local integer i = 0
    local integer max = BlzGroupGetSize(t)
    local unit array g
    local integer gCounter = 0
    
    loop
        exitwhen (i >= max)
        set memberI = BlzGroupUnitAt(t, i)
        set g[gCounter] = memberI
        set gCounter = gCounter + 1
        set memberI = null
        set i = i + 1
    endloop
    
    //call BJDebugMsg("Count targets " + I2S(gCounter))
    
    call GroupClear(t)
    call DestroyGroup(t)
    set t = null
    
    loop
        exitwhen (i >= gCounter)
        set memberI = g[i]
        set j = 0
        loop
            exitwhen (j >= gCounter)
            set memberJ = g[j]
            if (memberJ != memberI and BlzGetUnitRealField(memberJ, UNIT_RF_PRIORITY) > BlzGetUnitRealField(memberI, UNIT_RF_PRIORITY)) then
                set tmp = g[i]
                set g[i] = g[j]
                set g[j] = tmp
                set memberI = g[i]
                set memberJ = g[j]
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    
     loop
        exitwhen (i >= gCounter)
        call GroupAddUnit(r, g[i])
        set i = i + 1
    endloop
    
    return r
endfunction

struct Aura
    static Aura array allAuras[500]
    static integer allAurasCounter = 0
    static AuraFilterFunction tmpFilter = 0
    static unit tmpCaster = null
    static integer tmpAbilityId = 0

    group casters = CreateGroup()
    group targets = CreateGroup()
    integer abilityId
    integer buffAbilityId
    integer effectAbilityId
    AuraFilterFunction filterFunction
    real radius
    
    boolean has_bonus_type
    integer bonus_type
    real bonus_amount
    integer bonus_type2
    real bonus_amount2
    integer bonus_type3
    real bonus_amount3
    
    method addCaster takes unit caster returns nothing
        call GroupAddUnit(casters, caster)
    endmethod
    
    method setCasterMaxTargets takes unit caster, integer maxTargets returns nothing
        call SaveInteger(h, abilityId, GetHandleId(caster), maxTargets)
    endmethod
    
    method getCasterMaxTargets takes unit caster returns integer
        return LoadInteger(h, abilityId, GetHandleId(caster))
    endmethod
    
    static method filter takes nothing returns boolean
        local boolean result = thistype.tmpFilter.evaluate(tmpCaster, GetFilterUnit(), tmpAbilityId)
        //call BJDebugMsg("Filter: " + GetUnitName(GetFilterUnit()))
        if (result) then
            //call BJDebugMsg("Result true")
        else
            //call BJDebugMsg("Result false")
        endif
        return result
    endmethod
    
    static method create takes integer abilityId, integer buffAbilityId, integer effectAbilityId, AuraFilterFunction filterFunction, real radius, boolean has_bonus_type, integer bonus_type, real bonus_amount, integer bonus_type2, real bonus_amount2, integer bonus_type3, real bonus_amount3 returns thistype
        local thistype this = thistype.allocate()
        set this.abilityId = abilityId
        set this.buffAbilityId = buffAbilityId
        set this.effectAbilityId = effectAbilityId
        set this.filterFunction = filterFunction
        set this.radius = radius
        set this.has_bonus_type = has_bonus_type
        set this.bonus_type = bonus_type
        set this.bonus_amount = bonus_amount
        set this.bonus_type2 = bonus_type2
        set this.bonus_amount2 = bonus_amount2
        set this.bonus_type3 = bonus_type3
        set this.bonus_amount3 = bonus_amount3
        
        set thistype.allAuras[thistype.allAurasCounter] = this
        set thistype.allAurasCounter = thistype.allAurasCounter + 1
        
        return this
    endmethod
    
    method updateEx takes unit caster, group newTargets, group t returns nothing
        local integer level = GetUnitAbilityLevel(caster, abilityId)
        local integer i = 0
        local integer max = 0
        local integer maxTargets = getCasterMaxTargets(caster)
        local unit target = null
        // if the number of targets is limited make sure that heroes etc. are targetted first
        if (maxTargets > 0) then
            //call BJDebugMsg("Max targets " + I2S(maxTargets))
            set t = OrderGroupByPriority(t)
        endif
        set max = BlzGroupGetSize(t)
        loop
            exitwhen (i == max or (maxTargets > 0 and i >= maxTargets))
            set target = BlzGroupUnitAt(t, i)
            if (not IsUnitInGroup(target, targets)) then
                call UnitAddAbility(target, buffAbilityId)
                if (effectAbilityId != 0) then
                    call UnitAddAbility(target, effectAbilityId)
                    call BlzUnitHideAbility(target, effectAbilityId, true)
                endif
            endif
            
            if (effectAbilityId != 0) then
                call SetUnitAbilityLevel(target, effectAbilityId, level)
            endif
            //call BJDebugMsg("Target " + GetUnitName(target) + " with ability " + GetObjectName(effectAbilityId) + " level " + I2S(level) + " resulting in level " + I2S(GetUnitAbilityLevel(target, effectAbilityId)))
            
            if (has_bonus_type) then
                //call BJDebugMsg("Bonus! " + R2S(bonus_amount))
                if (bonus_type != 0) then
                    call AddUnitBonusTimed(target, bonus_type, level * bonus_amount, BUFF_DURATION)
                endif
                if (bonus_type2 != 0) then
                    call AddUnitBonusTimed(target, bonus_type2, level * bonus_amount2, BUFF_DURATION)
                endif
                
                //call LinkBonusToBuff(target, bonus_type, level * bonus_amount, buffAbilityId)
                //call LinkBonusToBuff(target, bonus_type, level * bonus_amount, buffAbilityId)
            endif
            
            call GroupAddUnit(newTargets, target)
            set target = null
            set i = i + 1
        endloop
    endmethod
    
    method update takes unit caster, group newTargets returns nothing
        local group t = CreateGroup()
        set tmpFilter = filterFunction
        set tmpCaster = caster
        set tmpAbilityId = abilityId
        call GroupEnumUnitsInRange(t, GetUnitX(caster), GetUnitY(caster), radius, Filter(function thistype.filter))
        if (BlzGroupGetSize(t) > 0) then
            call this.updateEx(caster, newTargets, t)
        endif
        
        call GroupClear(t)
        call DestroyGroup(t)
        set t = null
    endmethod
    
    method updateAllCasters takes nothing returns nothing
        // find new targets
        local group newTargets = CreateGroup()
        local integer i = 0
        local integer max = BlzGroupGetSize(casters)
        local unit caster = null
        local unit target = null
        // even update with 0 casters since buffs have to be removed
        loop
            exitwhen (i == max)
            set caster = BlzGroupUnitAt(casters, i)
            if (IsUnitAliveBJ(caster) and not IsUnitPaused(caster)) then
                call update(caster, newTargets)
            endif
            set caster = null
            set i = i + 1
        endloop
        
        // remove old targets which are not part of new targets
        call GroupRemoveGroup(newTargets, targets)
        set i = 0
        set max = BlzGroupGetSize(targets)
        loop
            exitwhen (i == max)
            set target = BlzGroupUnitAt(targets, i)
            //call BJDebugMsg("Remove aura " + GetObjectName(abilityId) + " target: " + GetUnitName(target))
            call UnitRemoveAbility(target, buffAbilityId)
            if (effectAbilityId != 0) then
                call UnitRemoveAbility(target, effectAbilityId)
            endif
            set target = null
            set i = i + 1
        endloop
        
        // swap
        call GroupClear(targets)
        call DestroyGroup(targets)
        set targets = newTargets
    endmethod
    
    method onDestroy takes nothing returns nothing
        call GroupClear(casters)
        call DestroyGroup(casters)
        set casters = null
    
        call GroupClear(targets)
        call DestroyGroup(targets)
        set targets = null
    endmethod
    
    static method removeCasterFromAll takes unit caster returns nothing
        local integer i = 0
        //call BJDebugMsg("Remove caster " + GetUnitName(caster))
        loop
            exitwhen (i == allAurasCounter)
            call GroupRemoveUnit(thistype.allAuras[i].casters, caster)
            set i = i + 1
        endloop
    endmethod
    
    static method getTotalCasters takes nothing returns integer
        local integer result = 0
        local integer i = 0
        loop
            exitwhen (i == allAurasCounter)
            set result = result + BlzGroupGetSize(thistype.allAuras[i].casters)
            set i = i + 1
        endloop
        return result
    endmethod
    
    static method updateAuraCasters takes nothing returns nothing
        // even update with 0 casters since buffs have to be removed
        call tmpAura.updateAllCasters()
    endmethod
    
    static method updateAllAuras takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen (i == allAurasCounter)
            set tmpAura = thistype.allAuras[i]
            call NewOpLimit(function thistype.updateAuraCasters)
            set i = i + 1
        endloop
    endmethod

endstruct

private function SaveAura takes integer abilityId, Aura a returns nothing
    call SaveInteger(h, abilityId, 0, a)
endfunction

function LoadAura takes integer abilityId returns Aura
    return LoadInteger(h, abilityId, 0)
endfunction

private function UpdateAllAuras takes nothing returns nothing
    call Aura.updateAllAuras()
endfunction

function AddAura takes integer abilityId, integer buffAbilityId, integer effectAbilityId, AuraFilterFunction filterFunction, real radius, boolean has_bonus_type, integer bonus_type, real bonus_amount, integer bonus_type2, real bonus_amount2, integer bonus_type3, real bonus_amount3 returns nothing
    call SaveAura(abilityId, Aura.create(abilityId, buffAbilityId, effectAbilityId, filterFunction, radius, has_bonus_type, bonus_type, bonus_amount, bonus_type2, bonus_amount2, bonus_type3, bonus_amount3))
endfunction

function AddAuraCaster takes unit caster, integer abilityId returns nothing
    local Aura aura = LoadAura(abilityId)
    if (aura != 0) then
        if (Aura.getTotalCasters() == 0) then
            call TimerStart(t, TIMER_UPDATE_INTERVAL, true, function UpdateAllAuras)
        endif
        call aura.addCaster(caster)
    endif
endfunction

function RemoveAuraCaster takes unit caster returns nothing
    call Aura.removeCasterFromAll(caster)
    call NewOpLimit(function UpdateAllAuras) // make sure we update one more time to remove effects
    
    if (Aura.getTotalCasters() == 0) then
        call PauseTimer(t)
    endif
endfunction

hook RemoveUnit RemoveAuraCaster

function SetAuraMaxTargets takes unit caster, integer abilityId, integer max returns nothing
    local Aura aura = LoadAura(abilityId)
    if (aura != 0) then
        call aura.setCasterMaxTargets(caster, max)
    endif
endfunction

private function TriggerActionLearnSkill takes nothing returns nothing
    call AddAuraCaster(GetTriggerUnit(), GetLearnedSkill())
endfunction

private function TriggerActionUnlearn takes nothing returns nothing
    //call BJDebugMsg("Remove hero caster for auras " + GetUnitName(GetTriggerUnskilledHero()))
    call RemoveAuraCaster(GetTriggerUnskilledHero())
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(learnTrigger, EVENT_PLAYER_HERO_SKILL)
    call TriggerAddAction(learnTrigger, function TriggerActionLearnSkill)
    
    call TriggerRegisterHeroUnskillEvent(unlearnTrigger)
    call TriggerAddAction(unlearnTrigger, function TriggerActionUnlearn)
endfunction

endlibrary
