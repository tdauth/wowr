library WoWReforgedTerrain

globals
    constant integer TILE_TYPE_DIRT = 'Zdrt' // Ruins_Dirt
    constant integer TILE_TYPE_ROUGH_DIRT ='Zdtr' // Ruins_DirtRough
    constant integer TILE_TYPE_GRASSY_DIRT = 'Zdrg' // Ruins_DirtGrass
    constant integer TILE_TYPE_LARGE_BRICKS = 'Zbkl' // Ruins_LargeBricks
    constant integer TILE_TYPE_GRASS = 'Zgrs' // Ruins_Grass
    constant integer TILE_TYPE_DARK_DESERT = 'Bdsd' // Barrens_DesertDark
    constant integer TILE_TYPE_DARK_ICE = 'Idki' // Ice_DarkIce
    constant integer TILE_TYPE_SQUARE_TILES = 'cGc1' // GSquareTiles
    constant integer TILE_TYPE_BRICK = 'Ybtl' // City_BrickTiles
    constant integer TILE_TYPE_ABYSS = 'Oaby'
    constant integer TILE_TYPE_SNOW = 'cWc1'
    constant integer TILE_TYPE_SAND = 'Zsan'
    constant integer TILE_TYPE_OUTLAND_DIRT = 'Odrt'
    constant integer TILE_TYPE_DARK_GRASS = 'Fgrd'
    constant integer TILE_TYPE_OUTLAND_ROUGH_DIRT = 'Osmb'
    constant integer TILE_TYPE_UNDERGROUND_BRICK = 'Gbrk'
    
    private integer array mapTiles
    private integer mapTilesCounter = 0
endglobals

function AddMapTile takes integer tile returns nothing
    set mapTiles[mapTilesCounter] = tile
    set mapTilesCounter = mapTilesCounter + 1
endfunction

function GetMapTile takes integer index returns integer
    return mapTiles[index]
endfunction

function GetMapTilesCounter takes nothing returns integer
    return mapTilesCounter
endfunction

function GetTileName takes integer tile returns string
    if (tile == TILE_TYPE_DIRT) then
        return GetLocalizedString("TILE_DIRT")
    elseif (tile == TILE_TYPE_ROUGH_DIRT) then
        return GetLocalizedString("TILE_ROUGH_DIRT")
    elseif (tile == TILE_TYPE_GRASSY_DIRT) then
        return GetLocalizedString("TILE_GRASSY_DIRT")
    elseif (tile == TILE_TYPE_LARGE_BRICKS) then
        return GetLocalizedString("TILE_LARGE_BRICKS")
    elseif (tile == TILE_TYPE_GRASS) then
        return GetLocalizedString("TILE_GRASS")
    elseif (tile == TILE_TYPE_DARK_DESERT) then
        return GetLocalizedString("TILE_DARK_DESERT")
    elseif (tile == TILE_TYPE_DARK_ICE) then
        return GetLocalizedString("TILE_DARK_ICE")
    elseif (tile == TILE_TYPE_SQUARE_TILES) then
        return GetLocalizedString("TILE_SQUARED_TILES")
    elseif (tile == TILE_TYPE_BRICK) then
        return GetLocalizedString("TILE_BRICK")
    elseif (tile == TILE_TYPE_ABYSS) then
        return GetLocalizedString("TILE_ABYSS")
    elseif (tile == TILE_TYPE_SNOW) then
        return GetLocalizedString("TILE_SNOW")
    elseif (tile == TILE_TYPE_SAND) then
        return GetLocalizedString("TILE_SAND")
    elseif (tile == TILE_TYPE_OUTLAND_DIRT) then
        return GetLocalizedString("TILE_OUTLAND_DIRT")
    elseif (tile == TILE_TYPE_DARK_GRASS) then
        return GetLocalizedString("TILE_DARK_GRASS")
    elseif (tile == TILE_TYPE_OUTLAND_ROUGH_DIRT) then
        return GetLocalizedString("TILE_OUTLAND_ROUGH_DIRT")
    elseif (tile == TILE_TYPE_UNDERGROUND_BRICK) then
        return GetLocalizedString("TILE_UNDERGROUND_BRICK")
    endif
    
    return GetLocalizedString("UNKNOWN")
endfunction

endlibrary
