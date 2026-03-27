library WoWReforgedTreeUtils initializer Init requires TreeUtils

globals
    constant integer EASTERN_TREE_WALL_1 = 'B005'
    constant integer CARROT_TREE_WALL_1 = 'B006'
    constant integer CARROT_TREE_WALL_2 = 'B007'
    constant integer PANDARIA_TREE_WALL = 'B009'
    constant integer ARGUS_TREE_WALL = 'B00K'
    constant integer AZUREMYST_ISLES_TREE_WALL = 'B00M'
    constant integer AZUREMYST_ISLES_TREE_WALL_FALL = 'B00S'
    constant integer AZUREMYST_ISLES_TREE_WALL_WINTER = 'B00R'
    constant integer UNLIMITED_TREE = 'B00G'
    constant integer ASHENVALE_TREE_WALL_FALL = 'B00T'
    constant integer ASHENVALE_TREE_WALL_WINTER = 'B00U'
    constant integer ASHENVALE_SNOWY_TREE_WALL = 'B00V'
    constant integer ASHENVALE_CANOPY_TREE_FALL = 'B00P'
    constant integer ASHENVALE_CANOPY_TREE_WINTER = 'B00Q'
    constant integer CHRISTMAS_TREE_WALL = 'B00W'
    constant integer ASHENVALE_CHRISTMAS_TREE_WALL = 'B00X'
    constant integer AZUREMYST_ISLES_CHRISTMAS_TREE_WALL = 'B00Y'
    constant integer CITYSCAPE_CHRISTMAS_TREE_WALL = 'B00Z'
    constant integer ASHENVALE_CANOPY_CHRISTMAS_TREE_WALL = 'B010'
    constant integer SHADOWLANDS_TREE_WALL = 'B018'
    constant integer NYALOTHA_TREE_WALL = 'B019'
    constant integer VILLAGE_TREE_WALL_FALL = 'B01B'
    constant integer VILLAGE_TREE_WALL_WINTER = 'B01A'
    constant integer VILLAGE_SNOWY_TREE_WALL = 'B01C'
endglobals

private function Init takes nothing returns nothing
    call AddTree(EASTERN_TREE_WALL_1)
    call AddTree(CARROT_TREE_WALL_1)
    call AddTree(CARROT_TREE_WALL_2)
    call AddTree(PANDARIA_TREE_WALL)
    call AddTree(ARGUS_TREE_WALL)
    call AddTree(AZUREMYST_ISLES_TREE_WALL)
    call AddTree(AZUREMYST_ISLES_TREE_WALL_FALL)
    call AddTree(AZUREMYST_ISLES_TREE_WALL_WINTER)
    call AddTree(UNLIMITED_TREE)
    call AddTree(ASHENVALE_TREE_WALL_FALL)
    call AddTree(ASHENVALE_TREE_WALL_WINTER)
    call AddTree(ASHENVALE_SNOWY_TREE_WALL)
    call AddTree(ASHENVALE_CANOPY_TREE_FALL)
    call AddTree(ASHENVALE_CANOPY_TREE_WINTER)
    call AddTree(CHRISTMAS_TREE_WALL)
    call AddTree(ASHENVALE_CHRISTMAS_TREE_WALL)
    call AddTree(AZUREMYST_ISLES_CHRISTMAS_TREE_WALL)
    call AddTree(CITYSCAPE_CHRISTMAS_TREE_WALL)
    call AddTree(ASHENVALE_CANOPY_CHRISTMAS_TREE_WALL)
    call AddTree(SHADOWLANDS_TREE_WALL)
    call AddTree(NYALOTHA_TREE_WALL)
    call AddTree(VILLAGE_TREE_WALL_FALL)
    call AddTree(VILLAGE_TREE_WALL_WINTER)
    call AddTree(VILLAGE_SNOWY_TREE_WALL)
endfunction

endlibrary
