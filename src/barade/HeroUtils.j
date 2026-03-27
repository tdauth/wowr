library HeroUtils initializer Init

globals
    public constant integer TOME_OF_RETRAINING = 'I0A7' // Tome of Retraining which is used immediately.
endglobals

function GetHeroPrimaryAttribute takes unit hero returns heroattribute
    return ConvertHeroAttribute(BlzGetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE))
endfunction

function GetHeroPrimaryStat takes unit hero returns integer
    local heroattribute a = GetHeroPrimaryAttribute(hero)
    if (a == HERO_ATTRIBUTE_STR) then
        return bj_HEROSTAT_STR
    elseif (a == HERO_ATTRIBUTE_AGI) then
        return bj_HEROSTAT_AGI
    endif
    return bj_HEROSTAT_INT
endfunction

function GetHeroAttributeName takes integer a returns string
    if (a == GetHandleId(HERO_ATTRIBUTE_AGI)) then
        return GetLocalizedString("AGILITY")
    elseif (a == GetHandleId(HERO_ATTRIBUTE_INT)) then
        return GetLocalizedString("INTELLIGENCE")
    endif
    return GetLocalizedString("STRENGTH")
endfunction

function GetHeroAttributeInfocardIcon takes integer a returns string
    if (a == GetHandleId(HERO_ATTRIBUTE_AGI)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-heroattributes-agi.blp"
    elseif (a == GetHandleId(HERO_ATTRIBUTE_INT)) then
        return "UI\\Widgets\\Console\\Human\\Infocard-heroattributes-int.blp"
    endif
    return "UI\\Widgets\\Console\\Human\\Infocard-heroattributes-str.blp"
endfunction

/**
 * \return Returns non-permanent strength of \p hero.
 * \sa GetHeroAgiBonus() GetHeroIntBonus() GetHeroStr() GetHeroAgi() GetHeroInt()
 * \author Baradé
 */
function GetHeroStrBonus takes unit hero returns integer
    return GetHeroStr(hero, true) - GetHeroStr(hero, false)
endfunction

/**
 * \return Returns non-permanent agility of \p hero.
 * \sa GetHeroStrBonus() GetHeroIntBonus() GetHeroStr() GetHeroAgi() GetHeroInt()
 * \author Baradé
 */
function GetHeroAgiBonus takes unit hero returns integer
    return GetHeroAgi(hero, true) - GetHeroAgi(hero, false)
endfunction

/**
 * \return Returns non-permanent intelligence of \p hero.
 * \sa GetHeroStrBonus() GetHeroAgiBonus() GetHeroStr() GetHeroAgi() GetHeroInt()
 * \author Baradé
 */
function GetHeroIntBonus takes unit hero returns integer
    return GetHeroInt(hero, true) - GetHeroInt(hero, false)
endfunction

function LearnHeroSkill takes unit hero, integer abilcode, integer level returns nothing
    local integer i = 0
    loop
        exitwhen (i == level)
        call SelectHeroSkill(hero, abilcode)
        set i = i + 1
    endloop
endfunction

globals
    private trigger array unskillTrigger
    private integer unskillTriggerCounter = 0
    private unit unskilledHero = null
endglobals

function TriggerRegisterHeroUnskillEvent takes trigger whichTrigger returns nothing
    set unskillTrigger[unskillTriggerCounter] = whichTrigger
    set unskillTriggerCounter = unskillTriggerCounter + 1
endfunction

function GetTriggerUnskilledHero takes nothing returns unit
    return unskilledHero
endfunction

private function ExecuteEvaluateCallbackUnskillTriggers takes unit hero returns nothing
    local integer i = 0
    set unskilledHero = hero
    loop
        exitwhen (i == unskillTriggerCounter)
        if (IsTriggerEnabled(unskillTrigger[i])) then
            call ConditionalTriggerExecute(unskillTrigger[i])
        endif
        set i = i + 1
    endloop
endfunction

function UnskillHero takes unit hero returns nothing
    if (GetHeroSkillPoints(hero) < GetHeroLevel(hero)) then
        call UnitResetCooldown(hero)
        call UnitAddItemById(hero, TOME_OF_RETRAINING)
    endif
    
    call ExecuteEvaluateCallbackUnskillTriggers(hero)
endfunction

globals
    private hashtable h = InitHashtable()
    private trigger levelTrigger = CreateTrigger()
endglobals

function GetPreviousHeroLevel takes unit hero returns integer
    return IMaxBJ(LoadInteger(h, GetHandleId(hero), 0), 1)
endfunction

function GetGainedHeroLevels takes unit hero returns integer
    return GetHeroLevel(hero) - GetPreviousHeroLevel(hero)
endfunction

function CopyHeroLevelGainData takes integer sourceHandleId, integer targetHandleId returns nothing
    call SaveInteger(h, targetHandleId, 0, LoadInteger(h, sourceHandleId, 0))
    call SaveInteger(h, targetHandleId, 1, LoadInteger(h, sourceHandleId, 1))
endfunction

private function TriggerConditionLevel takes nothing returns boolean
    local unit levelingUnit = GetLevelingUnit()
    local integer handleId = GetHandleId(levelingUnit)
    call SaveInteger(h, handleId, 0, LoadInteger(h, handleId, 1))
    call SaveInteger(h, handleId, 1, GetHeroLevel(levelingUnit))
    set levelingUnit = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(levelTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(levelTrigger, Condition(function TriggerConditionLevel))
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
