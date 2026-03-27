library WoWReforgedBanners initializer Init requires SimError, PagedButtons, WoWReforgedUtils

globals
    private integer array skinItemTypeId
    private integer array skinUnitTypeId
    private integer skinCounter = 0
endglobals

function GetMaxBanners takes nothing returns integer
    return skinCounter
endfunction

function AddBanner takes integer itemTypeId, integer unitTypeId returns integer
    local integer index = skinCounter
    set skinItemTypeId[index] = itemTypeId
    set skinUnitTypeId[index] = unitTypeId
    set skinCounter = skinCounter + 1
    return index
endfunction

function GetBannerItemTypeId takes integer index returns integer
    return skinItemTypeId[index]
endfunction

function GetBannerUnitTypeId takes integer index returns integer
    return skinUnitTypeId[index]
endfunction

function AddBannersShop takes unit shop returns nothing
    local integer i = 0
    //call BJDebugMsg("Before enabling shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    call EnablePagedButtons(shop)
    loop
        exitwhen (i >= skinCounter)
        call AddPagedButtonsItemType(shop, GetBannerItemTypeId(i))
         //call BJDebugMsg("Skill " + I2S(i)) // Stops at 189
        set i = i + 1
    endloop
    //call BJDebugMsg("Before enabling paged buttons for shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
    
    //call BJDebugMsg("Enabled shop " + GetUnitName(shop) + " with " + I2S(max) + " total learnable skills.")
endfunction

function IsBannerShop takes integer id returns boolean
    return id == BANNER_SHOP
endfunction

function IsUnitBannerShop takes unit whichUnit returns boolean
    return IsBannerShop(GetUnitTypeId(whichUnit))
endfunction

private function Init takes nothing returns nothing
    call DisableTrigger(bj_stockItemPurchased) // do not remove items on selling them

    // banners
    call AddBanner(ITEM_TINY_BANNER_STORMWIND, BANNER_STORMWIND)
    call AddBanner(ITEM_TINY_BANNER_KUL_TIRAS, BANNER_KUL_TIRAS)
    call AddBanner(ITEM_TINY_BANNER_DALARAN, BANNER_DALARAN)
    call AddBanner(ITEM_TINY_BANNER_ALTERAC, BANNER_ALTERAC)
    call AddBanner(ITEM_TINY_BANNER_GILNEAS, BANNER_GILNEAS)
    call AddBanner(ITEM_TINY_BANNER_THERAMORE, BANNER_THERAMORE)
    call AddBanner(ITEM_TINY_BANNER_STROMGARDE, BANNER_STROMGARDE)
    call AddBanner(ITEM_TINY_BANNER_LORDAERON, BANNER_LORDAERON)
    call AddBanner(ITEM_TINY_BANNER_HIGH_ELF, BANNER_HIGH_ELF)
    call AddBanner(ITEM_TINY_BANNER_BLOOD_ELF, BANNER_BLOOD_ELF)
    call AddBanner(ITEM_TINY_BANNER_BRONZEBEARD, BANNER_BRONZEBEARD)
    call AddBanner(ITEM_TINY_BANNER_IRONFORGE, BANNER_IRONFORGE)
    call AddBanner(ITEM_TINY_BANNER_WILDHAMMER, BANNER_WILDHAMMER)
    call AddBanner(ITEM_TINY_BANNER_STORMPIKE, BANNER_STORMPIKE)
    call AddBanner(ITEM_TINY_BANNER_DARK_IRON, BANNER_DARK_IRON)
    call AddBanner(ITEM_TINY_BANNER_EXPLORERS, BANNER_EXPLORERS)
    call AddBanner(ITEM_TINY_BANNER_ORC, BANNER_ORC)
    call AddBanner(ITEM_TINY_BANNER_UNDEAD, BANNER_UNDEAD)
    call AddBanner(ITEM_TINY_BANNER_NIGHT_ELF, BANNER_NIGHT_ELF)
    call AddBanner(ITEM_TINY_BANNER_PANDAREN, BANNER_PANDAREN)
endfunction

endlibrary
