library WoWReforgedProfessionArchaeologist initializer Init requires WoWReforgedProfessions

globals
    private constant integer ABILITY_ID_DIG_UP_ARTIFACTS = 'A0AB'
    private constant integer ABILITY_ID_NOVICE = 'A0MJ'
    private constant integer ABILITY_ID_ADVANCED ='A0ML'
    private constant integer ABILITY_ID_ADEPT = 'A0MK'
    private constant integer ABILITY_ID_MASTER = 'A0MM'
    private constant integer ABILITY_ID_GRAND_MASTER = 'A10F'
    private trigger castTrigger = CreateTrigger()
    private trigger constructionFinishTrigger = CreateTrigger()
endglobals

function IsArchaeologistAbilityId takes integer abilityId returns boolean
    return abilityId == ABILITY_ID_NOVICE or abilityId == ABILITY_ID_ADVANCED or abilityId == ABILITY_ID_ADEPT or abilityId == ABILITY_ID_MASTER or abilityId == ABILITY_ID_GRAND_MASTER
endfunction

private function GetItemLevelByAbilityId takes integer abilityId returns integer
    if (abilityId == ABILITY_ID_NOVICE) then
        return GetRandomInt(1, 2)
    elseif (abilityId == ABILITY_ID_ADVANCED) then
        return GetRandomInt(3, 4)
    elseif (abilityId == ABILITY_ID_ADEPT) then
        return GetRandomInt(5, 6)
    elseif (abilityId == ABILITY_ID_MASTER) then
        return 7
    elseif (abilityId == ABILITY_ID_GRAND_MASTER) then
        return 8
    endif
    return 1
endfunction

private function CraftRandomItem takes unit caster, integer abilityId returns nothing
    local integer i = 0
    local integer max = 1 + ProfessionBonusCharges(caster)
    loop
        exitwhen (i == max)
        call ProfessionCraftItems(caster, abilityId, ChooseRandomItemExBJ(GetItemLevelByAbilityId(abilityId), ITEM_TYPE_ANY), 1)
        set i = i + 1
    endloop
endfunction

private function RefillExcavationSite takes unit whichUnit returns nothing
    local integer i = 0
    loop
        exitwhen (i == 9)
        call AddItemToStock(whichUnit, ChooseRandomItem(i), 1, 1)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    if (IsArchaeologistAbilityId(abilityId)) then
        call CraftRandomItem(GetTriggerUnit(), abilityId)
    elseif (abilityId == ABILITY_ID_DIG_UP_ARTIFACTS and GetUnitTypeId(GetTriggerUnit()) == EXCAVATION_SITE) then
        call RefillExcavationSite(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionConstructionFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == EXCAVATION_SITE) then
        call RefillExcavationSite(GetConstructedStructure())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call TriggerRegisterAnyUnitEventBJ(constructionFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionFinishTrigger, Condition(function TriggerConditionConstructionFinish))
endfunction

endlibrary
