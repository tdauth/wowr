library MaxHpResearch initializer Init requires MaxHPResearchConfig

/*
https://www.hiveworkshop.com/threads/list-of-warcraft-iii-crashes.194706/page-4#post-3637812
https://www.hiveworkshop.com/threads/research-based-on-rhan-leads-to-negative-maximum-hp.356442/
*/

/**
 * Baradé's Maximum Hit Points Research 1.0
 * 
 * Warcraft III researches which increase the maximum hit points of units lead to overflows when the
 * bonus adds more than 255 hit points since the bonus is stored in only one single byte.
 * The affected research effects are 'rhpo' and 'rhpx'.
 * Hence, this system fakes HP bonuses for researches using the native BlzSetUnitMaxHP without this overflow bug.
 *
 * Requires you to define this function:
 * function UnitHasMaxHpResearch takes unit whichUnit, integer id returns boolean
 */

struct R
    integer id
    integer maxHpBase
    integer maxHpLevel
    real percentageBase
    real percentageLevel
    boolean isPercentage
endstruct

globals
    private R array researches
    private integer researchesCounter = 0
    
    private R filterResearch = 0

    private trigger trainTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
    private trigger sellTrigger = CreateTrigger()
    private trigger changeOwnerTrigger = CreateTrigger()
    private trigger researchTrigger = CreateTrigger()
    private trigger upgradeTrigger = CreateTrigger()
endglobals

function AddMaxHpResearchAbsolute takes integer id, integer maxHpBase, integer maxHpLevel returns R
    local R this = R.create()
    local integer index = researchesCounter
    
    set this.id = id
    set this.maxHpBase = maxHpBase
    set this.maxHpLevel = maxHpLevel
    set this.isPercentage = false
    
    set researches[index] = this
    set researchesCounter = researchesCounter + 1
    
    return this
endfunction

function AddMaxHpResearchPercentage takes integer id, real percentageBase, real percentageLevel returns R
    local R this = R.create()
    local integer index = researchesCounter
    
    set this.id = id
    set this.percentageBase = percentageBase
    set this.percentageLevel = percentageLevel
    set this.isPercentage = true
    
    set researches[index] = this
    set researchesCounter = researchesCounter + 1
    
    return this
endfunction

function ApplyMaxHpResearchEffect takes unit whichUnit, integer level, R research returns nothing
    local integer maxHp = BlzGetUnitMaxHP(whichUnit)
    local integer lifeBonus = 0
    if (research.isPercentage) then
        set lifeBonus = R2I(I2R(maxHp) * (research.percentageBase + research.percentageLevel * I2R(level)))
    else
        set lifeBonus = research.maxHpBase + level * research.maxHpLevel
    endif
    call BlzSetUnitMaxHP(whichUnit, maxHp + lifeBonus)
    call SetUnitState(whichUnit, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE) + I2R(lifeBonus))
endfunction

function ApplyMaxHpResearch takes unit whichUnit, R r, integer level returns nothing
    if (level > 0 and UnitHasMaxHpResearch(whichUnit, r.id)) then
        call ApplyMaxHpResearchEffect(whichUnit, level, r)
    endif
endfunction

function ApplyAllMaxHpResearches takes unit whichUnit, player previousOwner returns nothing
    local integer level = 0
    local integer i = 0
    loop
        exitwhen (i == researchesCounter)
        set level = GetPlayerTechCount(GetOwningPlayer(whichUnit), researches[i].id, false)
        if (previousOwner != null) then
            set level = level - GetPlayerTechCount(previousOwner, researches[i].id, false)
        endif
        call ApplyMaxHpResearch(whichUnit, researches[i], level)
        set i = i + 1
    endloop
endfunction

function GetMaxHpResearch takes integer id returns R
    local integer i = 0
    loop
        exitwhen (i == researchesCounter)
        if (researches[i].id == id) then
            return researches[i]
        endif
        set i = i + 1
    endloop
    return 0
endfunction

private function FilterIsAffectedUnit takes nothing returns boolean
    return UnitHasMaxHpResearch(GetFilterUnit(), filterResearch.id)
endfunction

function ApplyMaxHpResearchToAllUnitsEx takes player whichPlayer, R research, integer levels returns nothing
    local group g = CreateGroup()
    local integer i = 0
    local integer max = 0
    set filterResearch = research
    call GroupEnumUnitsOfPlayer(g, whichPlayer, Filter(function FilterIsAffectedUnit))
    set max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call ApplyMaxHpResearch(BlzGroupUnitAt(g, i), research, levels)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function ApplyMaxHpResearchToAllUnits takes player whichPlayer, integer id, integer levels returns nothing
    local R r = GetMaxHpResearch(id)
    if (r != 0) then
        call ApplyMaxHpResearchToAllUnitsEx(whichPlayer, r, levels)
    endif
endfunction

private function TriggerConditionTrain takes nothing returns boolean
    call ApplyAllMaxHpResearches(GetTrainedUnit(), null)
    return false
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    call ApplyAllMaxHpResearches(GetSummonedUnit(), null)
    return false
endfunction

private function TriggerConditionSell takes nothing returns boolean
    call ApplyAllMaxHpResearches(GetSoldUnit(), null)
    return false
endfunction

private function TriggerConditionChangeOwner takes nothing returns boolean
    call ApplyAllMaxHpResearches(GetTriggerUnit(), GetChangingUnitPrevOwner())
    return false
endfunction

private function TriggerConditionResearch takes nothing returns boolean
    call ApplyMaxHpResearchToAllUnits(GetOwningPlayer(GetTriggerUnit()), GetResearched(), 1)
    return false
endfunction

private function TriggerConditionUpgrade takes nothing returns boolean
    call ApplyAllMaxHpResearches(GetTriggerUnit(), null)
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(trainTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(trainTrigger, Condition(function TriggerConditionTrain))
    
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))
    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))
    
    call TriggerRegisterAnyUnitEventBJ(researchTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchTrigger, Condition(function TriggerConditionResearch))
    
    call TriggerRegisterAnyUnitEventBJ(upgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(upgradeTrigger, Condition(function TriggerConditionUpgrade))
endfunction

private function HookSetPlayerTechResearched takes player whichPlayer, integer techid, integer setToLevel returns nothing
    call ApplyMaxHpResearchToAllUnits(whichPlayer, techid, setToLevel - GetPlayerTechCountSimple(techid, whichPlayer))
endfunction

private function HookAddPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    call ApplyMaxHpResearchToAllUnits(whichPlayer, techid, levels)
endfunction

private function HookBlzDecPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    call ApplyMaxHpResearchToAllUnits(whichPlayer, techid, -levels)
endfunction

hook SetPlayerTechResearched HookSetPlayerTechResearched
hook AddPlayerTechResearched HookAddPlayerTechResearched
hook BlzDecPlayerTechResearched HookBlzDecPlayerTechResearched

endlibrary
