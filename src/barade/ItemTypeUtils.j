library ItemTypeUtils

globals
    // Barade: Cache all the values for better performance.
    private hashtable h = InitHashtable()
    
    private constant integer SHOP = 'ngme' // Goblin Shop
    private constant integer SELL_UNIT = ITEM_VALUES_DUMMY_HERO // can buy equipment and all race and profession items
    private constant real PAWN_ITEM_RATE = 0.6 // Gameplay constant - Inventory - Sell Item Return Rate/PawnItemRate
    
    private constant integer KEY_VALUE_GOLD = 0
    private constant integer KEY_VALUE_LUMBER = 1
    private constant integer KEY_PERISHABLE = 2
    private constant integer KEY_MODEL = 3
    private constant integer KEY_ICON = 4
endglobals

// https://www.hiveworkshop.com/threads/detecting-item-price.120355/

// This is the x position where we create the dummy units. Dont place it in the water.
private function GetShopDummyX takes nothing returns real
    return GetRectCenterX(gg_rct_Evolution_Dummy_Area)
endfunction

// This is the y position where we create the dummy units. Dont place it in the water.
private function GetShopDummyY takes nothing returns real
    return GetRectCenterY(gg_rct_Evolution_Dummy_Area)
endfunction

function GetItemValueGoldFresh takes integer i returns integer
    local real x = GetShopDummyX()
    local real y = GetShopDummyY()
    local unit u1  = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),SHOP,x,y,0)
    local unit u2  = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),SELL_UNIT,x,y-100,90)
    local item a   = UnitAddItemById(u2, i)
    local integer g1 = GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_GOLD)
    local integer g2 = 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_GOLD) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_GOLD)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemValueGold takes integer i returns integer
    if (not HaveSavedInteger(h, i, KEY_VALUE_GOLD)) then
        call SaveInteger(h, i, KEY_VALUE_GOLD, GetItemValueGoldFresh(i))
    endif
    return LoadInteger(h, i, KEY_VALUE_GOLD)
endfunction

function GetItemCostGold takes integer i returns integer
    return R2I(I2R(GetItemValueGold(i)) * PAWN_ITEM_RATE)
endfunction

function GetItemGoldCost takes integer i returns integer
    return GetItemCostGold(i)
endfunction

function GetItemValueLumberFresh takes integer i returns integer  
    local real x = GetShopDummyX()
    local real y = GetShopDummyY()
    local unit u1  = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),SHOP,x,y,0)
    local unit u2  = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),SELL_UNIT,x,y-100,90)
    local item a   = UnitAddItemById(u2, i)
    local integer g1 = GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2 = 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_LUMBER) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE),PLAYER_STATE_RESOURCE_LUMBER)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemValueLumber takes integer i returns integer
    if (not HaveSavedInteger(h, i, KEY_VALUE_LUMBER)) then
        call SaveInteger(h, i, KEY_VALUE_LUMBER, GetItemValueLumberFresh(i))
    endif
    return LoadInteger(h, i, KEY_VALUE_LUMBER)
endfunction

function GetItemCostLumber takes integer i returns integer
    return R2I(I2R(GetItemValueLumber(i)) * PAWN_ITEM_RATE)
endfunction

function GetItemWoodCost takes integer i returns integer
    return GetItemCostLumber(i)
endfunction

function GetItemTypePerishableFresh takes integer i returns boolean
    local item tmpItem = CreateItem(i, 0.0, 0.0)
    local boolean result = BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return result
endfunction

function GetItemTypePerishable takes integer i returns boolean
    if (not HaveSavedBoolean(h, i, KEY_PERISHABLE)) then
        call SaveBoolean(h, i, KEY_PERISHABLE, GetItemTypePerishableFresh(i))
    endif
    return LoadBoolean(h, i, KEY_PERISHABLE)
endfunction

function GetItemTypeModelFresh takes integer i returns string
    local item tmpItem = CreateItem(i, 0.0, 0.0)
    local string result = BlzGetItemStringField(tmpItem, ITEM_SF_MODEL_USED)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return result
endfunction

function GetItemTypeModel takes integer i returns string
    if (not HaveSavedString(h, i, KEY_MODEL)) then
        call SaveStr(h, i, KEY_MODEL, GetItemTypeModelFresh(i))
    endif
    return LoadStr(h, i, KEY_MODEL)
endfunction

function GetItemTypeIconFresh takes integer i returns string
    local item tmpItem = CreateItem(i, 0.0, 0.0)
    local string result = BlzGetItemIconPath(tmpItem)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return result
endfunction

function GetItemTypeIcon takes integer i returns string
    if (not HaveSavedString(h, i, KEY_ICON)) then
        call SaveStr(h, i, KEY_ICON, GetItemTypeIconFresh(i))
    endif
    return LoadStr(h, i, KEY_ICON)
endfunction

endlibrary
