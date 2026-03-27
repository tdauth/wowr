library WoWReforgedClanShop initializer Init requires SimError, PagedButtons, OpLimit, WoWReforgedUtils

globals
    private integer array clanBanners
    private integer clanBannersCount = 0
    
    private integer array clanSoundsItemTypeIds
    private sound array clanSoundsSounds
    private integer clanSoundsCount = 0
    
    private trigger sellTrigger = CreateTrigger()
endglobals

function GetClanBannersCount takes nothing returns integer
    return clanBannersCount
endfunction

function GetClanBanner takes integer index returns integer
    return clanBanners[index]
endfunction

function GetClanBannerIndex takes integer itemTypeId returns integer
    local integer max = GetClanBannersCount()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (GetClanBanner(i) == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function AddClanBanner takes integer itemTypeId returns integer
    local integer index = clanBannersCount
    set clanBanners[index] = itemTypeId
    set clanBannersCount = clanBannersCount + 1
    return index
endfunction

function GetClanSoundsCount takes nothing returns integer
    return clanSoundsCount
endfunction

function GetClanSoundItemTypeId takes integer index returns integer
    return clanSoundsItemTypeIds[index]
endfunction

function GetClanSoundSound takes integer index returns sound
    return clanSoundsSounds[index]
endfunction

function GetClanSoundName takes integer index returns string
    return GetObjectName(GetClanSoundItemTypeId(index))
endfunction

function GetClanSoundIndex takes sound whichSound returns integer
    local integer max = GetClanSoundsCount()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (GetClanSoundSound(i) == whichSound) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetClanSoundIndexByItemTypeId takes integer itemTypeId returns integer
    local integer max = GetClanSoundsCount()
    local integer i = 0
    loop
        exitwhen (i == max)
        if (GetClanSoundItemTypeId(i) == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function AddClanSound takes integer itemTypeId, sound whichSound returns integer
    local integer index = clanSoundsCount
    set clanSoundsItemTypeIds[index] = itemTypeId
    set clanSoundsSounds[index] = whichSound
    set clanSoundsCount = clanSoundsCount + 1
    return index
endfunction

function AddClanShop takes unit shop returns nothing
    local integer max = 0
    local integer i = 0
    
    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop, 9)
    
    call NextPagedButtonsPage(shop, GetLocalizedString("CLAN_PAGED_BUTTONS_TITLE"))
    call AddPagedButtonsItemType(shop, CLAN_CREATE_CLAN)
    call AddPagedButtonsItemType(shop, CLAN_TINY_CLAN_HALL)
    
    call NextPagedButtonsPage(shop, GetLocalizedString("SOUNDS_PAGED_BUTTONS_TITLE"))
    set i = 0
    set max = GetClanSoundsCount()
    loop
        exitwhen (i == max)
        call AddPagedButtonsItemType(shop, GetClanSoundItemTypeId(i))
        set i = i + 1
    endloop
    
    call NextPagedButtonsPage(shop, GetLocalizedString("BANNERS_PAGED_BUTTONS_TITLE"))
    set i = 0
    set max = GetClanBannersCount()
    loop
        exitwhen (i == max)
        call AddPagedButtonsItemType(shop, GetClanBanner(i))
        set i = i + 1
    endloop
    
    call SetPagedButtonsPage(shop, 0)
endfunction

private function TriggerConditionSellItem takes nothing returns boolean
    local item i = GetSoldItem()
    local integer itemTypeId = GetItemTypeId(i)
    local integer soundIndex = GetClanSoundIndexByItemTypeId(itemTypeId)
    local integer bannerIndex = GetClanBannerIndex(itemTypeId)
    local player owner = GetOwningPlayer(GetBuyingUnit())
    local integer clan = udg_ClanPlayerClan[GetConvertedPlayerId(owner)]
    if (soundIndex != -1) then
        if (clan != 0) then
            if (udg_ClanPlayerRank[GetConvertedPlayerId(owner)] == udg_ClanRankLeader) then
                set udg_ClanSound[clan] = GetClanSoundSound(soundIndex)
                call DisplayTimedTextToPlayer(owner, 0.0, 0.0, 4.0, Format(GetLocalizedString("CHANGED_CLAN_SOUND_TO")).s(GetItemName(i)).result())
            else
                call SimError(owner, GetLocalizedString("YOUR_CLAN_RANK_IS_NOT_LEADER"))
            endif
        else
            call SimError(owner, GetLocalizedString("YOU_HAVE_NO_CLAN"))
        endif
        call RemoveItem(i)
    elseif (bannerIndex != -1) then
        if (clan != 0) then
            if (udg_ClanPlayerRank[GetConvertedPlayerId(owner)] == udg_ClanRankLeader) then
                set udg_ClanIcon[clan] = itemTypeId
                call DisplayTimedTextToPlayer(owner, 0.0, 0.0, 4.0, Format(GetLocalizedString("CHANGED_CLAN_BANNER_TO")).s(GetItemName(i)).result())
            else
                call SimError(owner, GetLocalizedString("YOUR_CLAN_RANK_IS_NOT_LEADER"))
            endif
        else
            call SimError(owner, GetLocalizedString("YOU_HAVE_NO_CLAN"))
        endif
        call RemoveItem(i)
    endif
    set i = null
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSellItem))
    
    call AddClanSound(CLAN_HORN_SOUND, gg_snd_TheHornOfCenarius)
    call AddClanSound(CLAN_LAUGH_SOUND, gg_snd_SargerasLaugh)
    
    call AddClanBanner(CLAN_BANNER_HUMAN)
    call AddClanBanner(CLAN_BANNER_ORC)
    call AddClanBanner(CLAN_BANNER_UNDEAD)
    call AddClanBanner(CLAN_BANNER_NIGHT_ELF)
    call AddClanBanner(CLAN_BANNER_PANDAREN)
    call AddClanBanner(CLAN_BANNER_DWARF)
    call AddClanBanner(CLAN_BANNER_GNOME)
endfunction

endlibrary
