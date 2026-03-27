library TreeUtils initializer Init

globals
    constant integer SUMMER_TREE_WALL = 'LTlt'
    constant integer ASHENVALE_TREE_WALL = 'ATtr'
    constant integer ASHENVALE_CANOPY_TREE = 'ATtc'
    constant integer BARRENS_TREE_WALL = 'BTtw'
    constant integer BARRENS_CANOPY_TREE = 'BTtc'
    constant integer BLACK_CITADEL_TREE_WALL = 'KTtw'
    constant integer CITYSCAPE_SNOWY_TREE_WALL = 'YTst'
    constant integer CITYSCAPE_FALL_TREE_WALL = 'YTft'
    constant integer CITYSCAPE_WINTER_TREE_WALL = 'YTwt'
    constant integer CITYSCAPE_SUMMER_TREE_WALL = 'YTct'
    constant integer DALARAN_RUINS_TREE_WALL = 'JTtw'
    constant integer DUNGEON_TREE_WALL = 'DTsh'
    constant integer FELWOOD_TREE_WALL = 'CTtr'
    constant integer FELWOOD_CANOPY_TREE = 'CTtc'
    constant integer ICECROWN_TREE_WALL = 'ITtw'
    constant integer ICECROWN_CANOPY_TREE = 'ITtc'
    constant integer WINTER_TREE_WALL = 'WTtw'
    constant integer NORTHREND_TREE_WALL = 'NTtw'
    constant integer SNOWY_TREE_WALL = 'WTst'
    constant integer OUTLAND_TREE_WALL = 'OTtw'
    constant integer RUINS_TREE_WALL = 'ZTtw'
    constant integer RUINS_CANOPY_TREE = 'ZTtc'
    constant integer UNDERGROUND_TREE_WALL = 'GTsh'
    constant integer VILLAGE_TREE_WALL = 'VTlt'
    constant integer FALL_TREE_WALL = 'FTtw'
    constant integer SCORCHED_TREE_WALL = 'Ytsc'
    constant integer SILVERMOON_TREE = 'Yts1'
endglobals

globals
    private integer array ids
    private integer count = 0
endglobals

function AddTree takes integer id returns integer
    local integer index = count
    set ids[index] = id
    set count = index + 1
    return index
endfunction

function GetTree takes integer index returns integer
    return ids[index]
endfunction

function GetTreeCount takes nothing returns integer
    return count
endfunction

function IsTree takes integer id returns boolean
    local integer i = 0
    loop
        exitwhen (i == count)
        if (ids[i] == id) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function IsDestructableTree takes destructable whichDestructable returns boolean
    return IsTree(GetDestructableTypeId(whichDestructable))
endfunction

private function Init takes nothing returns nothing
    call AddTree(SUMMER_TREE_WALL)
    call AddTree(ASHENVALE_TREE_WALL)
    call AddTree(ASHENVALE_CANOPY_TREE)
    call AddTree(BARRENS_TREE_WALL)
    call AddTree(BARRENS_CANOPY_TREE)
    call AddTree(BLACK_CITADEL_TREE_WALL)
    call AddTree(CITYSCAPE_SNOWY_TREE_WALL)
    call AddTree(CITYSCAPE_FALL_TREE_WALL)
    call AddTree(CITYSCAPE_WINTER_TREE_WALL)
    call AddTree(CITYSCAPE_SUMMER_TREE_WALL)
    call AddTree(DALARAN_RUINS_TREE_WALL)
    call AddTree(DUNGEON_TREE_WALL)
    call AddTree(FELWOOD_TREE_WALL)
    call AddTree(FELWOOD_CANOPY_TREE)
    call AddTree(ICECROWN_TREE_WALL)
    call AddTree(ICECROWN_CANOPY_TREE)
    call AddTree(WINTER_TREE_WALL)
    call AddTree(NORTHREND_TREE_WALL)
    call AddTree(SNOWY_TREE_WALL)
    call AddTree(OUTLAND_TREE_WALL)
    call AddTree(RUINS_TREE_WALL)
    call AddTree(RUINS_CANOPY_TREE)
    call AddTree(UNDERGROUND_TREE_WALL)
    call AddTree(VILLAGE_TREE_WALL)
    call AddTree(FALL_TREE_WALL)
    call AddTree(SCORCHED_TREE_WALL)
    call AddTree(SILVERMOON_TREE)
endfunction

endlibrary
