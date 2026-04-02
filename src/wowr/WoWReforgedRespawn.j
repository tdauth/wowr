library WoWReforgedRespawn initializer Init requires UnitGroupRespawnSystem, TextTagUtils, WoWReforgedUtils, WoWReforgedEvolution, WoWReforgedMapData

globals
    private trigger deathTrigger = CreateTrigger()
    private trigger respawnTrigger = CreateTrigger()
endglobals

private function GetRespawnBuildingSize takes nothing returns real
    return 1400.0
endfunction

private function FilterFunctionIsBuilding takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local player owner = GetOwningPlayer(filterUnit)
    local boolean result = IsUnitType(filterUnit, UNIT_TYPE_STRUCTURE) and owner != Player(PLAYER_NEUTRAL_AGGRESSIVE) and owner != Player(PLAYER_NEUTRAL_PASSIVE) and owner != GetMapGaiaPlayer()
    set owner = null
    set filterUnit = null
    return result
endfunction

function RespawnCoordinatesContainNoBuilding takes real x, real y returns boolean
    local group g = CreateGroup()
    local filterfunc f =  Filter(function FilterFunctionIsBuilding)
    local boolean result = false
    call GroupEnumUnitsInRange(g, x, y, GetRespawnBuildingSize(), filter)
    set result = BlzGroupGetSize(g) > 0
    call DestroyBoolExpr(filter)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return result
endfunction

function RespawnAllGroupsInRange takes real x, real y, real range returns integer
	local integer result = 0
	local integer i = 0
	loop
		exitwhen (i == GetRespawnUnitCounter())
		if (IsRespawnUnitValid(i) and DistanceBetweenCoordinates(x, y, GetRespawnUnitX(i), GetRespawnUnitY(i)) <= range) then
            call RespawnUnit(i)
			set result = result + 1
		endif
		set i = i + 1
	endloop
	return result
endfunction

function RespawnAllItemsInRange takes real x, real y, real range returns integer
	local integer result = 0
	local integer i = 0
	loop
		exitwhen (i == GetItemRespawnCounter())
		if (IsRespawnItemValid(i) and GetRespawnItem(i) == null and DistanceBetweenCoordinates(x, y, GetRespawnItemX(i), GetRespawnItemY(i)) <= range) then
            call RespawnItem(i)
			set result = result + 1
		endif
		set i = i + 1
	endloop
	return result
endfunction

private function PreventUnitRespawnTextTag takes unit whichUnit returns nothing
    call ShowGeneralFadingTextTagForForce(GetPlayersAll(), Format(GetLocalizedString("PREVENT_UNIT_RESPAWN")).s(GetUnitName(whichUnit)).result(), GetUnitX(whichUnit), GetUnitY(whichUnit), 255, 255, 255, 0)
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE)) then
        call StartAllUnitRespawnsNotRunning()
    endif
    return false
endfunction

private function TriggerConditionRespawn takes nothing returns boolean
    local real x = GetUnitX(GetRespawningUnit())
    local real y = GetUnitY(GetRespawningUnit())

    if (RespawnCoordinatesContainNoBuilding(x, y)) then
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", x, y))
        if (not IsUnitType(GetRespawningUnit(), UNIT_TYPE_HERO)) then
            call AddEvolution(GetRespawningUnit())
        endif
        if (GetOwningPlayer(GetRespawningUnit()) == GetMapGaiaPlayer()) then
            call UpdateGaiaUnitForAllPlayers(GetRespawningUnit())
        endif
        if (IsUnitRandomCorpse(GetRespawningUnit())) then
            call ReplaceRandomCorpse(GetRespawningUnit())
        endif
    else
        call PreventUnitRespawnTextTag(GetRespawningUnit())
        call PreventUnitRespawn(GetRespawningUnit())
    endif
    
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterUnitRespawnEvent(respawnTrigger)
    call TriggerAddCondition(respawnTrigger, Condition(function TriggerConditionRespawn))
endfunction

endlibrary
