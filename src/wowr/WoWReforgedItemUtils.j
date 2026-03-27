library WoWReforgedItemUtils requires UnitEventEx, WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedItemCheck, WoWReforgedProfessions, WoWReforgedRaces, SimError

globals
    private integer pickedupItemsCounter = 0
    private unit pickedupItemsHero = null
endglobals

function ActionFunctionPickupItem takes nothing returns nothing
    local player heroOwner = GetOwningPlayer(pickedupItemsHero)
    if (CanItemBePickedUp(GetEnumItem(), pickedupItemsHero) and AddItemToBackpackForPlayer(heroOwner, GetEnumItem())) then
        set pickedupItemsCounter = pickedupItemsCounter + 1
    endif
    set heroOwner = null
endfunction

function PickupAllItemsAround takes unit hero, unit backpack returns integer
    local location tmpLocation = GetUnitLoc(hero)
    local rect tmpRect = RectFromCenterSizeBJ(tmpLocation, 2200.00, 2200.00)
    set pickedupItemsCounter = 0
    set pickedupItemsHero = backpack
    call EnumItemsInRect(tmpRect, null, function ActionFunctionPickupItem)
    if (pickedupItemsCounter == 1) then
        call BackpackMessage(GetOwningPlayer(hero), GetLocalizedString("PICKED_UP_1_ITEM"))
    else
        call BackpackMessage(GetOwningPlayer(hero), Format(GetLocalizedString("PICKED_UP_X_ITEMS")).i(pickedupItemsCounter).result())
    endif
    call RemoveRect(tmpRect)
    set tmpRect = null
    call RemoveLocation(tmpLocation)
    set tmpLocation = null
    return pickedupItemsCounter
endfunction

function PickupAllItemsAroundByPlayer takes player whichPlayer returns integer
    local unit hero = GetPlayerHero1(whichPlayer)
    local unit backpack = GetPlayerBackpack(whichPlayer)
    if (backpack != null) then
        if (hero != null) then
            if (IsUnitAliveBJ(hero)) then
                if (not IsUnitInTransporter(hero)) then
                    return PickupAllItemsAround(hero, backpack)
                else
                    call SimError(whichPlayer, GetLocalizedString("DOT_HERO_IS_IN_TRANSPORTER"))
                endif
            else
                 call SimError(whichPlayer, GetLocalizedString("DOT_HERO_IS_DEAD"))
            endif
        else
            call SimError(whichPlayer, GetLocalizedString("DOT_NO_HERO_1"))
        endif
    else
        call SimError(whichPlayer, GetLocalizedString("DOT_NO_BACKPACK"))
    endif
    set hero = null
    set backpack = null
    return 0
endfunction

function DropAllItemsFromBackpack takes player whichPlayer returns nothing
    local integer count = DropBackpack(whichPlayer)
    call BackpackMessage(whichPlayer, Format(GetLocalizedString("DROPPED_ALL_ITEMS_FROM_BACKPACK")).i(count).result())
endfunction

function DropAllItemsNotFromRaceForHero takes unit hero returns nothing
    local player owner = GetOwningPlayer(hero)
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    local boolean playerUnlockedAllRaces = udg_PlayerUnlockedAllRaces[convertedPlayerId]
    local integer playerRace1 = udg_PlayerRace[convertedPlayerId]
    local integer playerRace2 = udg_PlayerRace2[convertedPlayerId]
    local integer playerRace3 = udg_PlayerRace3[convertedPlayerId]
    local item slotItem = null
    local integer itemRace = udg_RaceNone
    local integer i = 0
    if (not playerUnlockedAllRaces) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(hero, i)
            if (slotItem != null) then
                set itemRace = GetItemRace(GetItemTypeId(slotItem))
                if (itemRace != udg_RaceNone and itemRace != playerRace1 and itemRace != playerRace2 and itemRace != playerRace3) then
                    call BackpackMessage(owner, Format(GetLocalizedString("DROPPING_ITEM_OF_OTHER_RACE")).s(GetItemName(slotItem)).result())
                    call UnitRemoveItemFromSlot(hero, i)
                endif
            endif
            set slotItem = null
            set i = i + 1
        endloop
    endif
    set owner = null
endfunction

function DropAllItemsNotFromRace takes player whichPlayer returns nothing
    local boolean result = false
    if (GetPlayerHero1(whichPlayer) != null) then
        set result = true
        call DropAllItemsNotFromRaceForHero(GetPlayerHero1(whichPlayer))
    endif
    if (GetPlayerHero2(whichPlayer) != null) then
        set result = true
        call DropAllItemsNotFromRaceForHero(GetPlayerHero2(whichPlayer))
    endif
    if (GetPlayerHero3(whichPlayer) != null) then
        set result = true
        call DropAllItemsNotFromRaceForHero(GetPlayerHero3(whichPlayer))
    endif
    if (not result) then
        call SimError(whichPlayer, GetLocalizedString("DOT_NO_HERO"))
    endif
endfunction

function DropAllItemsNotFromProfessionForHero takes unit hero returns nothing
    local player owner = GetOwningPlayer(hero)
    local integer convertedPlayerId = GetConvertedPlayerId(owner)
    local integer playerProfession1 = udg_PlayerProfession[convertedPlayerId]
    local integer playerProfession2 = udg_PlayerProfession2[convertedPlayerId]
    local integer playerProfession3 = udg_PlayerProfession3[convertedPlayerId]
    local item slotItem = null
    local integer j = 0
    local integer i = 0
    local integer max2 = GetProfessionsMax()
    if (not udg_PlayerUnlockedAllRaces[convertedPlayerId]) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(hero, i)
            if (slotItem != null) then
                set j = 0
                loop
                    exitwhen (j == max2)
                    if (GetProfession(i).itemTypeId == GetItemTypeId(slotItem) and playerProfession1 != j and playerProfession2 != j and playerProfession3 != j) then
                        call BackpackMessage(owner, Format(GetLocalizedString("DROPPING_ITEM_OF_OTHER_PROFESSION")).s(GetItemName(slotItem)).result())
                        call UnitRemoveItemFromSlot(hero, i)
                        exitwhen (true)
                    endif
                    set j = j + 1
                endloop
            endif
            set slotItem = null
            set i = i + 1
        endloop
    endif
    set owner = null
endfunction

function DropAllItemsNotFromProfession takes player whichPlayer returns nothing
    if (GetPlayerHero1(whichPlayer) != null) then
        call DropAllItemsNotFromProfessionForHero(GetPlayerHero1(whichPlayer))
    endif
    if (GetPlayerHero2(whichPlayer) != null) then
        call DropAllItemsNotFromProfessionForHero(GetPlayerHero2(whichPlayer))
    endif
    if (GetPlayerHero3(whichPlayer) != null) then
        call DropAllItemsNotFromProfessionForHero(GetPlayerHero3(whichPlayer))
    endif
endfunction

function DropItemAtRectFromHeroByItemType takes unit hero, integer itemTypeId, rect whichRect returns nothing
    local player owner = GetOwningPlayer(hero)
    if (hero == GetPlayerHero1(owner)) then
        call DropQuestItemFromHeroAtRect(owner, itemTypeId, whichRect)
    else
        call DropFirstItemFromHeroAtRect(hero, itemTypeId, whichRect)
    endif
    set owner = null
endfunction

endlibrary
