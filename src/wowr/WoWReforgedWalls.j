library WoWReforgedWalls initializer Init

// This system is based on [Medieval Wall Trigger Map](https://www.hiveworkshop.com/pastebin/907781cf76579f09be5b3697c14733b8.24012) by The_Silent

globals
	private constant integer DIR_NORTH = 0
	private constant integer DIR_SOUTH = 1
	private constant integer DIR_EAST = 2
	private constant integer DIR_WEST = 3

	private constant integer UNIT_TYPE_CROSS_PIECE_GROUND = 'h0DZ'
	private constant integer UNIT_TYPE_AIR_PIECE_GROUND = 'h0EK'

	private integer array wallTypeGround
	private integer array wallTypeAir

	private trigger deathTrigger = CreateTrigger()
	private trigger constructFinishTrigger = CreateTrigger()
	private trigger upgradeFinishTrigger = CreateTrigger()
endglobals

private function UnitIsWall takes unit u, boolean ground returns boolean
	local integer unitTypeId = GetUnitTypeId(u)
	if (ground) then
		return unitTypeId == wallTypeGround[0]
	endif
	return unitTypeId == wallTypeAir[0]
endfunction

private function WallDetectNeighbours takes player owner, real x, real y, integer dir, boolean ground returns unit
	local real dist = 128.0 // neighbour pos
	local real sub_dist = 16.0// range of exact position to check
	local real pos_x = x
	local real pos_y = y
	local unit fog = null
	local unit w = null
	local group g = CreateGroup()

	// Why is wc3 coordinates so weird!!!??
	if dir == DIR_NORTH then
		set pos_y = pos_y + dist
	elseif dir == DIR_SOUTH then
		set pos_y = pos_y - dist
	elseif dir == DIR_EAST then
		set pos_x = pos_x + dist
	elseif dir == DIR_WEST then
		set pos_x = pos_x - dist
	endif

	call GroupEnumUnitsInRange(g, pos_x, pos_x, sub_dist, null)

	loop
		set fog = FirstOfGroup(g)
		exitwhen fog == null or w != null

		if (UnitIsWall(fog, ground) and (GetOwningPlayer(fog) == owner)) then
			set w = fog
		endif

		call GroupRemoveUnit(g, fog)
	endloop

	call GroupClear(g)
	call DestroyGroup(g)
	set g = null

	// cleanup
	set fog = null

	// return
	return w
endfunction

private function WallUpdate takes unit u, boolean main_piece, boolean ground returns nothing
	local player p = GetOwningPlayer(u)
	local real x = GetUnitX(u)
	local real y = GetUnitY(u)
	local integer result = 0
	local integer count = 0
	// Cardinal neighbours
	local unit n = WallDetectNeighbours(p, x, y, DIR_NORTH, ground)
	local unit s = WallDetectNeighbours(p, x, y, DIR_SOUTH, ground)
	local unit e = WallDetectNeighbours(p, x, y, DIR_EAST, ground)
	local unit w = WallDetectNeighbours(p, x, y, DIR_WEST, ground)
	local group g = CreateGroup()

	// Early exits
	if IsUnitAliveBJ(u) == false then
		set n = null
		set s = null
		set e = null
		set w = null

		return
	endif

	// Update cardinal neighbours
	if main_piece == true then
		if n != null then
			call WallUpdate(n, false, ground)
		endif
		if s != null then
			call WallUpdate(s, false, ground)
		endif
		if e != null then
			call WallUpdate(e, false, ground)
		endif
		if w != null then
			call WallUpdate(w, false, ground)
		endif
	endif

	// Detect type of piece
	if (n == null) then
		call GroupAddUnit(g, n)
	endif
	if (s == null) then
		call GroupAddUnit(g, s)
	endif
	if (e == null) then
		call GroupAddUnit(g, e)
	endif
	if (w == null) then
		call GroupAddUnit(g, w)
	endif

	set count = BlzGroupGetSize(g)

	// End piece
	if count == 1 then
		if n != null then
			set result = wallTypeGround[1]
		elseif w != null then
			set result = wallTypeGround[2]
		elseif e != null then
			set result = wallTypeGround[3]
		elseif s != null then
			set result = wallTypeGround[4]
		endif

	// T-cross
	elseif count == 3 then
		if n == null then
			set result = wallTypeGround[5]
		elseif s == null then
			set result = wallTypeGround[6]
		elseif w == null then
			set result = wallTypeGround[7]
		elseif e == null then
			set result = wallTypeGround[8]
		endif

	// Straight piece or corner piece
	elseif count == 2 then
		// Straight piece
		if (n == null and s == null) or (e == null and w == null) then
			if n == null then
				set result = wallTypeGround[9]
			elseif e == null then
				set result = wallTypeGround[10]
			endif
		else
			// Corner piece
			if s != null then
				if w != null then
					set result = wallTypeGround[11]
				elseif e != null then
					set result = wallTypeGround[12]
				endif
			elseif n != null then
				if e != null then
					set result = wallTypeGround[13]
				elseif w != null then
					set result = wallTypeGround[14]
				endif
			endif

		endif
	elseif (ground ) then
		// Else return cross piece
		set result = UNIT_TYPE_CROSS_PIECE_GROUND
	else
		set result = UNIT_TYPE_AIR_PIECE_GROUND
	endif
	call GroupClear(g)
	call DestroyGroup(g)
	set g = null

	call BlzSetUnitSkin(u, result)

	//cleanup

	set n = null
	set s = null
	set e = null
	set w = null
endfunction

private function IsWallTypeGround takes integer unitTypeId returns boolean
	local integer i = 0
	local integer max = 15
	loop
		exitwhen (i == max)
		if (wallTypeGround[i] == unitTypeId) then
			return true
		endif
		set i = i + 1
	endloop
	return false
endfunction

private function IsWallTypeAir takes integer unitTypeId returns boolean
	local integer i = 0
	local integer max = 15
	loop
		exitwhen (i == max)
		if (wallTypeAir[i] == unitTypeId) then
			return true
		endif
		set i = i + 1
	endloop
	return false
endfunction

private function FilterIsWallGround takes nothing returns boolean
	return IsWallTypeGround(GetUnitTypeId(GetFilterUnit()))
endfunction

private function FilterIsWallAir takes nothing returns boolean
	return IsWallTypeGround(GetUnitTypeId(GetFilterUnit()))
endfunction

private function ForGroupUpdateWallGround takes nothing returns nothing
	call WallUpdate(GetEnumUnit(), true, true)
endfunction

private function ForGroupUpdateWallAir takes nothing returns nothing
	call WallUpdate(GetEnumUnit(), true, false)
endfunction

private function UpdateAllWallsAroundGround takes unit wall returns nothing
	local group wallsAround = CreateGroup()
	call GroupEnumUnitsInRange(wallsAround, GetUnitX(wall), GetUnitY(wall), 800.0, Filter(function FilterIsWallGround))
	call ForGroup(wallsAround, function ForGroupUpdateWallGround)
	call GroupClear(wallsAround)
	call DestroyGroup(wallsAround)
	set wallsAround = null
endfunction

private function UpdateAllWallsAroundAir takes unit wall returns nothing
	local group wallsAround = CreateGroup()
	call GroupEnumUnitsInRange(wallsAround, GetUnitX(wall), GetUnitY(wall), 800.0, Filter(function FilterIsWallAir))
	call ForGroup(wallsAround, function ForGroupUpdateWallAir)
	call GroupClear(wallsAround)
	call DestroyGroup(wallsAround)
	set wallsAround = null
endfunction

private function TriggerConditionDeath takes nothing returns boolean
	local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
	if (IsWallTypeGround(unitTypeId)) then
		call UpdateAllWallsAroundGround(GetTriggerUnit())
	elseif (IsWallTypeAir(unitTypeId)) then
		call UpdateAllWallsAroundAir(GetTriggerUnit())
	endif
	return false
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
	if (GetUnitTypeId(GetConstructedStructure()) == wallTypeGround[0]) then
		call WallUpdate(GetConstructedStructure(), true, true)
	endif
	return false
endfunction

private function TriggerConditionUpgradeFinish takes nothing returns boolean
	local integer unitTypeId = GetUnitTypeId(GetTriggerUnit())
	if (unitTypeId == 'h0E0') then
		call WallUpdate(GetTriggerUnit(), true, true)
	elseif (unitTypeId == wallTypeAir[0]) then
		call WallUpdate(GetTriggerUnit(), true, false)
	endif
	return false
endfunction

private function Init takes nothing returns nothing
	call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

	call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
	call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))

	// Barade: Necessary for World of Warcraft Reforged.
	call TriggerRegisterAnyUnitEventBJ(upgradeFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
	call TriggerAddCondition(upgradeFinishTrigger, Condition(function TriggerConditionUpgradeFinish))

	// Main piece and cross
	set wallTypeGround[0] = 'h04Q'
	// Wall Ends
	// North End
	set wallTypeGround[1] = 'h094'
	// West End
	set wallTypeGround[2] = 'h04S'
	// East End
	set wallTypeGround[3] = 'h093'
	// South End
	set wallTypeGround[4] = 'h095'
	// Wall T-Cross
	// North End
	set wallTypeGround[5] = 'h0DP'
	// South End
	set wallTypeGround[6] = 'h0DQ'
	// West End
	set wallTypeGround[7] = 'h0DR'
	// East End
	set wallTypeGround[8] = 'h0DS'
	// Wall Straight
	// Horizontal
	set wallTypeGround[9] = 'h04R'
	// Vertical
	set wallTypeGround[10] = 'h096'
	// Wall Corner
	// South West
	set wallTypeGround[11] = 'h0DT'
	// South East
	set wallTypeGround[12] = 'h0DU'
	// North East
	set wallTypeGround[13] = 'h0DV'
	// North West
	set wallTypeGround[14] = 'h0DW'

	// Main piece and cross
	set wallTypeAir[0] = 'h0DM'
	// Wall Ends
	// North End
	set wallTypeAir[1] = 'h0EO'
	// West End
	set wallTypeAir[2] = 'h04S'
	// East End
	set wallTypeAir[3] = 'h0EN'
	// South End
	set wallTypeAir[4] = 'h095'
	// Wall T-Cross
	// North End
	set wallTypeAir[5] = 'h0EX'
	// South End
	set wallTypeAir[6] = 'h0EQ'
	// West End
	set wallTypeAir[7] = 'h0EW'
	// East End
	set wallTypeAir[8] = 'h0EM'
	// Wall Straight
	// Horizontal
	set wallTypeAir[9] = 'h0ET'
	// Vertical
	set wallTypeAir[10] = 'h0EU'
	// Wall Corner
	// South West
	set wallTypeAir[11] = 'h0ES'
	// South East
	set wallTypeAir[12] = 'h0EY'
	// North East
	set wallTypeAir[13] = 'h0EZ'
	// North West
	set wallTypeAir[14] = 'h0EP'
endfunction

endlibrary
