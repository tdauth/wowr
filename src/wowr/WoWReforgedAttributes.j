library WoWReforgedAttributes initializer Init requires NewBonus, PagedButtons, HeroUtils, Attributes, UnitGroupUtils, OnStartGame, WoWReforgedUtils, WoWReforgedSkillMenu, WoWReforgedHeroTransformation

globals
    private player filterPlayer = null
    
    private trigger sellTrigger = CreateTrigger()
    public trigger levelUpTrigger = CreateTrigger() // public for WoWReforgedHeroTransformation
    private trigger channelTrigger = CreateTrigger()
endglobals

function ShowWowReforgedSkillPoints takes unit hero returns nothing
    call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("ATTRIBUTE_POINTS_MESSAGE")).i(R2I(GetUnitAttribute(hero, udg_AttributeAttributePoints))).i(R2I(GetUnitAttribute(hero, udg_AttributeSkillPoints))).result())
endfunction

function ResetWowReforgedSkillPoints takes unit hero returns nothing
    local real skillPoints = 0.0
    set skillPoints = skillPoints + IMaxBJ(GetHeroStr(hero, false) - 1, 0)
    set skillPoints = skillPoints + IMaxBJ(GetHeroAgi(hero, false) - 1, 0)
    set skillPoints = skillPoints + IMaxBJ(GetHeroInt(hero, false) - 1, 0)
    if (skillPoints > 0.0) then
        call SetHeroStr(hero, 1, true)
        call SetHeroAgi(hero, 1, true)
        call SetHeroInt(hero, 1, true)
        call AddUnitAttribute(hero, udg_AttributeAttributePoints, skillPoints)
        call ShowWowReforgedSkillPoints(hero)
    else
        call SimError(GetOwningPlayer(hero), GetLocalizedString("NO_ATTRIBUTE_POINTS_SPENT"))
    endif
endfunction

function GetHeroSecondaryStat takes unit hero returns integer
    local integer primary = GetHeroPrimaryStat(hero)
    if (primary == bj_HEROSTAT_STR) then
        return bj_HEROSTAT_AGI
    elseif (primary == bj_HEROSTAT_AGI) then
        return bj_HEROSTAT_STR
    endif
    
    return bj_HEROSTAT_AGI
endfunction

function EqualWowReforgedSkillPoints takes unit hero returns nothing
    local integer value = 0
    local integer mod = 0
    call ResetWowReforgedSkillPoints(hero)
    set value = R2I(GetUnitAttribute(hero, udg_AttributeAttributePoints) / 3.0)
    set mod = R2I(ModuloReal(GetUnitAttribute(hero, udg_AttributeAttributePoints), 3.0))
    if (value > 0.0) then
        call ModifyHeroStat(bj_HEROSTAT_STR, hero, bj_MODIFYMETHOD_ADD, value)
        call ModifyHeroStat(bj_HEROSTAT_AGI, hero, bj_MODIFYMETHOD_ADD, value)
        call ModifyHeroStat(bj_HEROSTAT_INT, hero, bj_MODIFYMETHOD_ADD, value)
        call RemoveUnitAttribute(hero, udg_AttributeAttributePoints, value * 3.0 + I2R(mod))
        
        if (mod > 0) then
            call ModifyHeroStat(GetHeroPrimaryStat(hero), hero, bj_MODIFYMETHOD_ADD, 1)
        
            if (mod > 1) then
                call ModifyHeroStat(GetHeroSecondaryStat(hero), hero, bj_MODIFYMETHOD_ADD, mod - 1)
            endif
        endif
        
        call ShowWowReforgedSkillPoints(hero)
    else
        call SimError(GetOwningPlayer(hero), GetLocalizedString("NO_ATTRIBUTE_POINTS"))
    endif
endfunction

function WoWReforgedSkillAttribute takes unit hero, integer whichStat, real value returns nothing
    if (value > 0.0) then
        if (GetUnitAttribute(hero, udg_AttributeAttributePoints) >= value) then
            call AddUnitAttribute(hero, udg_AttributeAttributePoints, -value)
            call ModifyHeroStat(whichStat, hero, bj_MODIFYMETHOD_ADD, R2I(value))
            call ShowWowReforgedSkillPoints(hero)
        else
            call SimError(GetOwningPlayer(hero), GetLocalizedString("NO_ATTRIBUTE_POINTS"))
        endif
    elseif (value < 0.0) then
        set value = value * -1.0
        set value = RMinBJ(I2R(GetHeroStatBJ(whichStat, hero, false)) - 1.0, value) // keep 1.0 of the attribute
        set value = RMaxBJ(0.0, value)
        if (value > 0.0) then
            call AddUnitAttribute(udg_TmpUnit, udg_AttributeAttributePoints, value)
            call ModifyHeroStat(whichStat, hero, bj_MODIFYMETHOD_SUB, R2I(value))
            call ShowWowReforgedSkillPoints(hero)
        else
            call SimError(GetOwningPlayer(hero), GetLocalizedString("ATTRIBUTE_CANNOT_BE_UNSKILLED"))
        endif
    endif
endfunction

private function IsPlayerHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and GetOwningPlayer(GetFilterUnit()) == filterPlayer // CanUseCustomizableAttributes(GetFilterUnit())
endfunction

private function GetUnitSelectedCustomizableAttributeHeroes takes player whichPlayer returns group
    local group g = CreateGroup()
    call SyncSelections()
    set filterPlayer = whichPlayer
    call GroupEnumUnitsSelected(g, whichPlayer, Filter(function IsPlayerHero))
    return g
endfunction

function SkillAttribute takes player whichPlayer, integer a, real v returns nothing
    local group g = GetUnitSelectedCustomizableAttributeHeroes(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call WoWReforgedSkillAttribute(BlzGroupUnitAt(g, i), a, v)
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function SkillStr takes player whichPlayer, real str returns nothing
    call SkillAttribute(whichPlayer, bj_HEROSTAT_STR, str)
endfunction

function SkillAgi takes player whichPlayer, real agi returns nothing
    call SkillAttribute(whichPlayer, bj_HEROSTAT_AGI, agi)
endfunction

function SkillInt takes player whichPlayer, real int returns nothing
    call SkillAttribute(whichPlayer, bj_HEROSTAT_INT, int)
endfunction

function SkillAttributeMax takes player whichPlayer, integer a returns nothing
    local group g = GetUnitSelectedCustomizableAttributeHeroes(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call WoWReforgedSkillAttribute(BlzGroupUnitAt(g, i), a, GetUnitAttribute(BlzGroupUnitAt(g, i), udg_AttributeAttributePoints))
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function SkillStrMax takes player whichPlayer returns nothing
    call SkillAttributeMax(whichPlayer, bj_HEROSTAT_STR)
endfunction

function SkillAgiMax takes player whichPlayer returns nothing
    call SkillAttributeMax(whichPlayer, bj_HEROSTAT_AGI)
endfunction

function SkillIntMax takes player whichPlayer returns nothing
    call SkillAttributeMax(whichPlayer, bj_HEROSTAT_INT)
endfunction

function ResetAllSkillPoints takes player whichPlayer returns nothing
    local group g = GetUnitSelectedCustomizableAttributeHeroes(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call ResetWowReforgedSkillPoints(BlzGroupUnitAt(g, i))
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function EqualizeAllSkillPoints takes player whichPlayer returns nothing
    local group g = GetUnitSelectedCustomizableAttributeHeroes(whichPlayer)
    local integer i = 0
    local integer max = BlzGroupGetSize(g)
    loop
        exitwhen (i == max)
        call EqualWowReforgedSkillPoints(BlzGroupUnitAt(g, i))
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function TriggerConditionSell takes nothing returns boolean
    if (IsUnitType(GetSoldUnit(), UNIT_TYPE_HERO)) then
        call AddSkillPointsInitial(GetSoldUnit())
        if (CanUseCustomizableAttributes(GetSoldUnit())) then
            call AddUnitAttribute(GetSoldUnit(), udg_AttributeAttributePoints, START_ATTRIBUTE_POINTS)
        endif
    endif
    return false
endfunction

private function TriggerConditionLevelUp takes nothing returns boolean
    if (IsUnitType(GetSoldUnit(), UNIT_TYPE_HERO)) then
        call AddSkillPointsLevelUp(GetLevelingUnit())
        if (CanUseCustomizableAttributes(GetLevelingUnit())) then
            call AddUnitAttribute(GetLevelingUnit(), udg_AttributeAttributePoints, IMaxBJ(1, GetGainedHeroLevels(GetLevelingUnit())) * ATTRIBUTE_POINTS_PER_LEVEL)
        endif
   endif
    return false
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (abilityId == 'A1L5') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_STR, 1.0)
    elseif (abilityId == 'A1L6') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_AGI, 1.0)
    elseif (abilityId == 'A1L7') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_INT, 1.0)
    elseif (abilityId == 'A1L8') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_STR, -1.0)
    elseif (abilityId == 'A1L9') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_AGI, -1.0)
    elseif (abilityId == 'A1LA') then
        call WoWReforgedSkillAttribute(GetTriggerUnit(), bj_HEROSTAT_INT, -1.0)
    elseif (abilityId == 'A1LB') then
        call ShowWowReforgedSkillPoints(GetTriggerUnit())
    elseif (abilityId == 'A1LC') then
        call ResetWowReforgedSkillPoints(GetTriggerUnit())
    elseif (abilityId == 'A1LD') then
        call EqualWowReforgedSkillPoints(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))

    call TriggerRegisterAnyUnitEventBJ(levelUpTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(levelUpTrigger, Condition(function TriggerConditionLevelUp))

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    set udg_AttributeAttributePoints = AddAttribute(GetLocalizedStringSafe("ATTRIBUTE_POINTS"))
    call SetAttributeIcon(udg_AttributeAttributePoints, "ReplaceableTextures\\CommandButtons\\BTNStatUp.blp")
    call SetAttributeDescription(udg_AttributeAttributePoints, GetLocalizedStringSafe("ATTRIBUTE_POINTS_DESCRIPTION"))
    
    set udg_AttributeSkillPoints = AddAttribute(GetLocalizedStringSafe("SKILL_POINTS"))
    call SetAttributeIcon(udg_AttributeAttributePoints, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp")
    call SetAttributeDescription(udg_AttributeAttributePoints, GetLocalizedStringSafe("SKILL_POINTS_DESCRIPTION"))
endfunction

endlibrary
