library WoWReforgedMapData initializer Init requires StringUtils, WoWReforgedTerrain, WoWReforgedVIPs

// Do not use udg_xxxx variables which might not be initialized yet.
function GetMapGaiaPlayer takes nothing returns player
    return Player(PLAYER_RESCUABLE)
endfunction

function GetMapBossesPlayer takes nothing returns player
    return Player(PLAYER_BOSSES)
endfunction

function GetMapPlayerSelectionRect takes nothing returns rect
    return gg_rct_Player_Selection
endfunction

function MapLocationCanBeTeleportedTo takes unit whichUnit, real x, real y returns boolean
    return not RectContainsCoords(gg_rct_Player_Selection, x, y)
endfunction

function GetMapNeutralZoneX takes player whichPlayer returns real
    return GetRectCenterX(gg_rct_redirect_forbidden_zone)
endfunction

function GetMapNeutralZoneY takes player whichPlayer returns real
    return GetRectCenterY(gg_rct_redirect_forbidden_zone)
endfunction

function GetMapNeutralZoneFacing takes player whichPlayer returns real
    return 270.0
endfunction

function GetMapWaterNeutralZoneX takes player whichPlayer returns real
    return GetRectCenterX(gg_rct_Start_Location_Theramore_Water)
endfunction

function GetMapWaterNeutralZoneY takes player whichPlayer returns real
    return GetRectCenterY(gg_rct_Start_Location_Theramore_Water)
endfunction

function GetMapWaterNeutralZoneFacing takes player whichPlayer returns real
    return 270.0
endfunction

function GetMapAllowConfigureAIPlayer takes player whichPlayer returns boolean
    return whichPlayer != GetMapBossesPlayer() and whichPlayer != GetMapGaiaPlayer()
endfunction

function AddMapSettings takes framehandle textArea returns nothing
    call BlzFrameAddText(textArea, Format(GetLocalizedString("SETTINGS_VICTORY")).s(B2Option(udg_VictoryByKillingArchimonde)).result())
endfunction

private function Init takes nothing returns nothing
    call AddMapTile(TILE_TYPE_DIRT)
    call AddMapTile(TILE_TYPE_ROUGH_DIRT)
    call AddMapTile(TILE_TYPE_GRASSY_DIRT)
    call AddMapTile(TILE_TYPE_LARGE_BRICKS)
    call AddMapTile(TILE_TYPE_GRASS)
    call AddMapTile(TILE_TYPE_DARK_DESERT)
    call AddMapTile(TILE_TYPE_DARK_ICE)
    call AddMapTile(TILE_TYPE_SQUARE_TILES)
    call AddMapTile(TILE_TYPE_BRICK)
    call AddMapTile(TILE_TYPE_ABYSS)
    call AddMapTile(TILE_TYPE_SNOW)
    call AddMapTile(TILE_TYPE_SAND)
    call AddMapTile(TILE_TYPE_OUTLAND_DIRT)
    call AddMapTile(TILE_TYPE_DARK_GRASS)
    call AddMapTile(TILE_TYPE_OUTLAND_ROUGH_DIRT)
    call AddMapTile(TILE_TYPE_UNDERGROUND_BRICK)
endfunction

endlibrary
