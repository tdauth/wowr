library WoWReforgedMapQuelThalas initializer Init requires OnStartGame

globals
    constant integer HIGH_ELF_BUILDING_SMALL_SOUTH_WEST_FACING = 'nefm'
    constant integer HIGH_ELF_BUILDING_ONE_STORY_SOUTH_FACING = 'nef0'
    constant integer HIGH_ELF_BUILDING_TWO_STORY_SOUTH_FACING = 'nef1'
    constant integer HIGH_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING = 'nef2'
    constant integer HIGH_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING = 'nef3'
    constant integer HIGH_ELF_BUILDING_ONE_STORY_WEST_FACING = 'nef4'
    constant integer HIGH_ELF_BUILDING_TWO_STORY_EAST_FACING = 'nef5'
    constant integer HIGH_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING = 'nef6'
    constant integer HIGH_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING = 'nef7'

    constant integer NIGHT_ELF_BUILDING_SMALL_SOUTH_WEST_FACING = 'nvr2'
    constant integer NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING = 'nvr0'
    constant integer NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING = 'nvr1'
    constant integer NIGHT_ELF_BUILDING_ONE_STORY_WEST_FACING = 'nvr0'
    constant integer NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING = 'n08F'
    constant integer NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING = 'n06N'
endglobals

function GetQuelThalasBuildingIdFixed takes integer unitTypeId returns integer
    if (unitTypeId == NIGHT_ELF_BUILDING_SMALL_SOUTH_WEST_FACING) then
        return HIGH_ELF_BUILDING_SMALL_SOUTH_WEST_FACING
    elseif (unitTypeId == NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING) then
        return HIGH_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING
    elseif (unitTypeId == NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING) then
        return HIGH_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING
    elseif (unitTypeId == NIGHT_ELF_BUILDING_ONE_STORY_WEST_FACING) then
        return HIGH_ELF_BUILDING_ONE_STORY_WEST_FACING
    elseif (unitTypeId == NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING) then
        return HIGH_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING
    elseif (unitTypeId == NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING) then
        return HIGH_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING
    endif
    return unitTypeId
endfunction

function GetQuelThalasBuildingIdRuined takes integer unitTypeId returns integer
    if (unitTypeId == HIGH_ELF_BUILDING_SMALL_SOUTH_WEST_FACING) then
        return NIGHT_ELF_BUILDING_SMALL_SOUTH_WEST_FACING
    elseif (unitTypeId == HIGH_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING) then
        return NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_WEST_FACING
    elseif (unitTypeId == HIGH_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING) then
        return NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_WEST_FACING
    elseif (unitTypeId == HIGH_ELF_BUILDING_ONE_STORY_WEST_FACING) then
        return NIGHT_ELF_BUILDING_ONE_STORY_WEST_FACING
        elseif (unitTypeId == HIGH_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING) then
        return NIGHT_ELF_BUILDING_ONE_STORY_SOUTH_EAST_FACING
    elseif (unitTypeId == HIGH_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING) then
        return NIGHT_ELF_BUILDING_TWO_STORY_SOUTH_EAST_FACING
    endif
    return unitTypeId
endfunction

function ReplaceQuelThalasBuildingFixed takes unit whichUnit returns unit
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer targetUnitTypeId = GetQuelThalasBuildingIdFixed(unitTypeId)
    if (unitTypeId != targetUnitTypeId) then
        return ReplaceUnitBJ(whichUnit, targetUnitTypeId, bj_UNIT_STATE_METHOD_MAXIMUM)
    endif

    set bj_lastReplacedUnit = whichUnit

    return whichUnit
endfunction

function ReplaceQuelThalasBuildingRuined takes unit whichUnit returns unit
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    local integer targetUnitTypeId = GetQuelThalasBuildingIdRuined(unitTypeId)
    if (unitTypeId != targetUnitTypeId) then
        return ReplaceUnitBJ(whichUnit, targetUnitTypeId, bj_UNIT_STATE_METHOD_MAXIMUM)
    endif

    set bj_lastReplacedUnit = whichUnit

    return whichUnit
endfunction

function ReplaceRectWithTerrain takes rect whichRect, integer source, integer target returns nothing
    local real x = GetRectMinX(whichRect)
    local real y = 0.0
    local real maxX = GetRectMaxX(whichRect)
    local real maxY = GetRectMaxY(whichRect)
    loop
        exitwhen (x >= maxX)
        set y = GetRectMinY(whichRect)
        //call BJDebugMsg("ReplaceWithTerrain 2")
        loop
            exitwhen (y >= maxY)
            //call BJDebugMsg("ReplaceWithTerrain 3")
            if (GetTerrainType(x, y) == source) then
                call SetTerrainType(x, y, target, GetTerrainVariance(x, y), 1, 0)
                //call BJDebugMsg("ReplaceWithTerrain 4")
            endif
            //call BJDebugMsg("ReplaceWithTerrain 5")
            set y = y + bj_CELLWIDTH
        endloop
        set x = x  + bj_CELLWIDTH
    endloop
endfunction

function RemoveQuelThalasBlight takes nothing returns nothing
    call SetBlightRect(null, gg_rct_Zone_Sunwell_Grove, false)
endfunction

function HealQuelThalasTerrain takes nothing returns nothing
    call ReplaceRectWithTerrain(gg_rct_Zone_Sunwell_Grove, TILE_TYPE_SQUARE_TILES, TILE_TYPE_BRICK)
    call ReplaceRectWithTerrain(gg_rct_Zone_Sunwell_Grove, TILE_TYPE_ROUGH_DIRT, TILE_TYPE_GRASS)
    call NewOpLimit(function RemoveQuelThalasBlight)
endfunction

private function EnumHealQuelThalasBuilding takes nothing returns nothing
    call GroupRemoveUnitSimple( GetEnumUnit(), udg_QuelThalasRuinedElvenBuildings )
    call ReplaceQuelThalasBuildingFixed(GetEnumUnit())
    call SetUnitInvulnerable( GetLastReplacedUnitBJ(), true )
    call GroupAddUnitSimple( GetLastReplacedUnitBJ(), udg_QuelThalasRuinedElvenBuildings )
endfunction

function QuelThalasHeal takes nothing returns nothing
    local destructable d = null
    call SetDoodadAnimationRectBJ( "Stand", 'YOsw', gg_rct_Sunwell )
    call RemoveWeatherEffectBJ( udg_QuelThalasWeatherEffect )
    call AddWeatherEffectSaveLast( gg_rct_Weather_Sunwell_Grove, 'LRaa' )
    set udg_QuelThalasWeatherEffect = GetLastCreatedWeatherEffect()
    call RemoveWeatherEffectBJ( udg_QuelThalasWeatherEffectForest )
    call AddWeatherEffectSaveLast( gg_rct_Weather_Sunwell_Grove, 'LRaa' )
    set udg_QuelThalasWeatherEffectForest = GetLastCreatedWeatherEffect()
    call HealQuelThalasTerrain()
    call ForGroup(udg_QuelThalasRuinedElvenBuildings, function EnumHealQuelThalasBuilding)
    set d = ReplaceDestructable(gg_dest_B01E_0969, 'B01F', 0.0, 1.0, 0, bj_UNIT_STATE_METHOD_MAXIMUM)
    call SetDestructableInvulnerable(d, true)
    set d = ReplaceDestructable(gg_dest_LTe1_0968, 'LTe1', 0.0, 1.0, 0, bj_UNIT_STATE_METHOD_MAXIMUM)
    call SetDestructableInvulnerable(d, true)
    call ModifyGateBJ( bj_GATEOPERATION_OPEN, d )
endfunction

private function EnumUpdateQuelThalasBuilding takes nothing returns nothing
    local unit replacedUnit = null
    call GroupRemoveUnit(udg_QuelThalasRuinedElvenBuildings, GetEnumUnit())
    set replacedUnit = ReplaceQuelThalasBuildingRuined(GetEnumUnit())
    call SetUnitInvulnerable(replacedUnit, true )
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, replacedUnit)
    set replacedUnit = null
endfunction

private function StartGame takes nothing returns nothing
    call SetDoodadAnimationRectBJ( "Stand Third", 'YOsw', gg_rct_Sunwell )
    call AddWeatherEffectSaveLast( gg_rct_Weather_Sunwell_Grove, 'FDrl' )
    set udg_QuelThalasWeatherEffect = GetLastCreatedWeatherEffect()
    call AddWeatherEffectSaveLast( gg_rct_Weather_Quel_Thalas, 'FDwl' )
    set udg_QuelThalasWeatherEffectForest = GetLastCreatedWeatherEffect()
endfunction

private function Init takes nothing returns nothing
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0509)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef7_0603)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0460)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0456)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0488)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef4_0515)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0461)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef2_0529)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef2_0511)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef3_0543)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0682)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0681)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0602)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0688)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef3_0625)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0680)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0686)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0683)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef6_0677)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef7_0636)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nefm_0678)
    call GroupAddUnit(udg_QuelThalasRuinedElvenBuildings, gg_unit_nef7_0679)
    call ForGroup(udg_QuelThalasRuinedElvenBuildings, function EnumUpdateQuelThalasBuilding)

    call OnStartGame(function StartGame)
endfunction

endlibrary
