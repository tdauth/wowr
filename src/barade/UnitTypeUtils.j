library UnitTypeUtils initializer Init requires MathUtils
/**
 * Allows retrieving fields by the unit type only without a specific unit.
 * Do not cache it in a hashtable since the value can change per player with the help of researches.
 * We could detect research events b
 */

globals
    private constant integer KEY_LEVEL = 0
    private constant integer KEY_DEFENSE = 1
    private constant integer KEY_DAMAGE_TYPE = 2
    private constant integer KEY_DEFENSE_TYPE = 3
    private constant integer KEY_MOVE_TYPE = 4
    private constant integer KEY_UCAM = 5
    private constant integer MAX_KEYS = 6

    private real X = 0.0
    private real Y = 0.0
    private trigger researchTrigger = CreateTrigger()
    private trigger changeOwnerTrigger = CreateTrigger() // some researches are transfered with ownership
    private hashtable cache = InitHashtable()
endglobals

private function InvalidateCache takes nothing returns nothing
    call FlushParentHashtable(cache)
endfunction

private function GetParentKey takes player whichPlayer, integer k returns integer
    return Index2D(GetPlayerId(whichPlayer), k, MAX_KEYS)
endfunction

private function InvalidatePlayerCache takes player whichPlayer returns nothing
    local integer i = 0
    loop
        exitwhen (i == MAX_KEYS)
        call FlushChildHashtable(cache, GetParentKey(whichPlayer, i))
        set i = i + 1
    endloop
endfunction

private function HookSetPlayerTechResearched takes player whichPlayer, integer techid, integer setToLevel returns nothing
    call InvalidatePlayerCache(whichPlayer)
endfunction

private function HookAddPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    call InvalidatePlayerCache(whichPlayer)
endfunction

private function HookBlzDecPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    call InvalidatePlayerCache(whichPlayer)
endfunction

private function HookFunctionSetPlayerTechResearched takes integer techid, integer levels, player whichPlayer returns nothing
    call InvalidatePlayerCache(whichPlayer)
endfunction

hook SetPlayerTechResearched HookSetPlayerTechResearched
hook AddPlayerTechResearched HookAddPlayerTechResearched
hook BlzDecPlayerTechResearched HookBlzDecPlayerTechResearched

private function TriggerConditionResearchFinish takes nothing returns boolean
    call InvalidatePlayerCache(GetOwningPlayer(GetTriggerUnit()))
    return false
endfunction

private function TriggerConditionChangeOwner takes nothing returns boolean
    call InvalidatePlayerCache(GetOwningPlayer(GetChangingUnit()))
    return false
endfunction

private function Init takes nothing returns nothing
    //set OWNER = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    set X = GetRectCenterX(gg_rct_Evolution_Dummy_Area)
    set Y = GetRectCenterY(gg_rct_Evolution_Dummy_Area)
    call TriggerRegisterAnyUnitEventBJ(researchTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(researchTrigger, Condition(function TriggerConditionResearchFinish))
    call TriggerRegisterAnyUnitEventBJ(changeOwnerTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(changeOwnerTrigger, Condition(function TriggerConditionChangeOwner))
endfunction

private function CreateDummy takes integer unitTypeId, player owner returns unit
    return CreateUnit(owner, unitTypeId, X, Y, 0.0)
endfunction

function GetUnitLevelByTypeFresh takes integer unitTypeId, player owner returns integer
	local unit dummy = CreateDummy(unitTypeId, owner)
	local integer result = BlzGetUnitIntegerField(dummy, UNIT_IF_LEVEL)
    call SaveInteger(cache, GetParentKey(owner, KEY_LEVEL), unitTypeId, result)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitLevelByType takes integer unitTypeId, player owner returns integer
    if (HaveSavedInteger(cache, GetParentKey(owner, KEY_LEVEL), unitTypeId)) then
        return LoadInteger(cache, GetParentKey(owner, KEY_LEVEL), unitTypeId)
    endif
	return GetUnitLevelByTypeFresh(unitTypeId, owner)
endfunction

function GetUnitDefenseByTypeFresh takes integer unitTypeId, player owner returns real
	local unit dummy = CreateDummy(unitTypeId, owner)
	local real result = BlzGetUnitRealField(dummy, UNIT_RF_DEFENSE)
    call SaveReal(cache, GetParentKey(owner, KEY_DEFENSE), unitTypeId, result)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDefenseByType takes integer unitTypeId, player owner returns real
    if (HaveSavedReal(cache, GetParentKey(owner, KEY_DEFENSE), unitTypeId)) then
        return LoadReal(cache, GetParentKey(owner, KEY_DEFENSE), unitTypeId)
    endif
	return GetUnitDefenseByTypeFresh(unitTypeId, owner)
endfunction

function GetUnitDamageTypeByTypeFresh takes integer unitTypeId, player owner returns integer
	local unit dummy = CreateDummy(unitTypeId, owner)
	local integer result = BlzGetUnitWeaponIntegerField(dummy , UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
    call SaveInteger(cache, GetParentKey(owner, KEY_DAMAGE_TYPE), unitTypeId, result)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDamageTypeByType takes integer unitTypeId, player owner returns integer
    if (HaveSavedInteger(cache, GetParentKey(owner, KEY_DAMAGE_TYPE), unitTypeId)) then
        return LoadInteger(cache, GetParentKey(owner, KEY_DAMAGE_TYPE), unitTypeId)
    endif
	return GetUnitDamageTypeByTypeFresh(unitTypeId, owner)
endfunction

function GetUnitDefenseTypeByTypeFresh takes integer unitTypeId, player owner returns integer
	local unit dummy = CreateDummy(unitTypeId, owner)
	local integer result = BlzGetUnitIntegerField(dummy, UNIT_IF_DEFENSE_TYPE)
    call SaveInteger(cache, GetParentKey(owner, KEY_DEFENSE_TYPE), unitTypeId, result)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDefenseTypeByType takes integer unitTypeId, player owner returns integer
    if (HaveSavedInteger(cache, GetParentKey(owner, KEY_DEFENSE_TYPE), unitTypeId)) then
        return LoadInteger(cache, GetParentKey(owner, KEY_DEFENSE_TYPE), unitTypeId)
    endif
	return GetUnitDefenseTypeByTypeFresh(unitTypeId, owner)
endfunction

function GetUnitMovementTypeByTypeFresh takes integer unitTypeId, player owner returns integer
	local unit dummy = CreateDummy(unitTypeId, owner)
	local integer result = BlzGetUnitIntegerField(dummy, UNIT_IF_MOVE_TYPE)
    call SaveInteger(cache, GetParentKey(owner, KEY_MOVE_TYPE), unitTypeId, result)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitMovementTypeByType takes integer unitTypeId, player owner returns integer
    if (HaveSavedInteger(cache, GetParentKey(owner, KEY_MOVE_TYPE), unitTypeId)) then
        return LoadInteger(cache, GetParentKey(owner, KEY_MOVE_TYPE), unitTypeId)
    endif
	return GetUnitMovementTypeByTypeFresh(unitTypeId, owner)
endfunction

function IsCampaign takes integer unitTypeId returns boolean
    return LoadBoolean(cache, unitTypeId, KEY_UCAM)
endfunction

function SetIsCampaign takes integer unitTypeId, boolean isCampaign returns nothing
    call SaveBoolean(cache, unitTypeId, KEY_UCAM, isCampaign)
endfunction

// Do not cache strings which might be different in multiplayer depending on the players game's language and could lead to desyncs.
function GetActualObjectName takes integer id returns string
	local unit dummy = null
    local string name = ""
     if (IsUnitIdType(id, UNIT_TYPE_HERO) and IsCampaign(id)) then
        set dummy = CreateDummy(id, Player(PLAYER_NEUTRAL_PASSIVE))
        set name = GetHeroProperName(dummy)
        call RemoveUnit(dummy)
        set dummy = null
    else
        set name = GetObjectName(id)
    endif

    return name
endfunction

endlibrary
