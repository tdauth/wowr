//TESH.scrollpos=400
//TESH.alwaysfold=0

library WoWReforgedUtils

function Index2D takes integer Value1, integer Value2, integer MaxValue2 returns integer
    return ((Value1 * MaxValue2) + Value2)
endfunction

function Index3D takes integer Value1, integer Value2, integer Value3, integer MaxValue2, integer MaxValue3 returns integer
    return ((Value1 * (MaxValue2 * MaxValue3)) + (Value2 * MaxValue3) + Value3)
endfunction

function SaveTriggerParameterInteger takes handle Trigger, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(Trigger), ParameterKey, Value)
endfunction

function LoadTriggerParameterInteger takes handle Trigger, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(Trigger), ParameterKey)
endfunction

function TriggerParameterIntegerExists takes handle Trigger, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(Trigger), ParameterKey)
endfunction

function DestroyParameterTrigger takes trigger Trigger returns nothing
    call FlushChildHashtable(udg_DB, GetHandleId(Trigger))
    call DestroyTrigger(Trigger)
endfunction

function SaveUnitParameterInteger takes unit whichUnit, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(whichUnit), ParameterKey, Value)
endfunction

function LoadUnitParameterInteger takes unit whichUnit, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(whichUnit), ParameterKey)
endfunction

function UnitParameterIntegerExists takes unit whichUnit, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(whichUnit), ParameterKey)
endfunction

function SaveDestructableParameterInteger takes destructable whichDestructable, integer ParameterKey, integer Value returns nothing
    call SaveInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey, Value)
endfunction

function LoadDestructableParameterInteger takes destructable whichDestructable, integer ParameterKey returns integer
    return LoadInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey)
endfunction

function DestructableParameterIntegerExists takes destructable whichDestructable, integer ParameterKey returns boolean
    return HaveSavedInteger(udg_DB, GetHandleId(whichDestructable), ParameterKey)
endfunction

function FlushUnitParameters takes unit whichUnit returns nothing
    call FlushChildHashtable(udg_DB, GetHandleId(whichUnit))
endfunction

function StringStartsWith takes string source, string start returns boolean
    local integer i = 0
    loop
        exitwhen (i == StringLength(start) or i >= StringLength(source))

        if (SubString(source, i, i + 1) != SubString(start, i, i + 1)) then
            return false
        endif

        set i = i + 1
    endloop

    return i == StringLength(start)
endfunction

function StringRemoveFromStart takes string source, string start returns string
    if (StringStartsWith(source, start)) then
        return SubString(source, StringLength(start), StringLength(source))
    endif

    return source
endfunction

function IndexOfString takes string symbol, string source returns integer
    local integer i = 0
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        exitwhen (i == StringLength(source))
        if (SubString(source, i, i + 1) == symbol) then
            //call BJDebugMsg("Index: " + I2S(i))
            return i
        endif
        set i = i + 1
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return -1
endfunction

/**
 * Useful for getting parts of a chat message to implement chat commands.
 */
function StringTokenEx takes string source, integer index, boolean toTheEnd returns string
    local string result = ""
    local boolean inWhitespace = false
    local integer currentIndex = 0
    local integer i = 0
    loop
        exitwhen (i == StringLength(source) or currentIndex > index)
        if (SubString(source, i, i + 1) == " " and (not toTheEnd or currentIndex < index)) then
            if (not inWhitespace) then
                set inWhitespace = true
                set currentIndex = currentIndex + 1
            endif
        else
            if (currentIndex == index) then
                set result = result + SubString(source, i, i + 1)
            endif
            set inWhitespace = false
        endif
        set i = i + 1
    endloop

    return result
endfunction

function StringToken takes string source, integer index returns string
    return StringTokenEx(source, index, false)
endfunction

function StringTokenEnteredChatMessageEx takes integer index, boolean toTheEnd returns string
    return StringTokenEx(GetEventPlayerChatString(), index, toTheEnd)
endfunction

function StringTokenEnteredChatMessage takes integer index returns string
    return StringToken(GetEventPlayerChatString(), index)
endfunction

function SimError takes player whichPlayer, string msg returns nothing
    local sound error = CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
    if (GetLocalPlayer() == whichPlayer) then
        if (msg != "" and  msg != null) then
            call ClearTextMessages()
            call DisplayTimedTextToPlayer(whichPlayer, 0.52, - 1.00, 2.00, "|cffffcc00" + msg + "|r")
        endif
        call StartSound(error)
    endif
    call KillSoundWhenDone(error)
    set error = null
endfunction

function PlayerIsOnlineUser takes integer playerId returns boolean
    local player whichPlayer = Player(playerId)
    local boolean result = GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING
    set whichPlayer = null
    return result
endfunction

function CopyGroup takes group whichGroup returns group
    local group copy = CreateGroup()
    call GroupAddGroup(whichGroup, copy)
    return copy
endfunction

function GetHelpText takes nothing returns string
    return "-h/-help, -clear, -discord, -revive, -sel, -players, -accounts, -info X, -repick, -fullrepick, -enchanter, -profession2, -professionrepick -race2, -racerepick, -racerepick2, -secondrepick, -thirdrepick, -passive -suicide, -anim X, -ping, -pingh, -pingl, -pingm, -pingportals, -pingkeys, -pingdragons, -pinggoldmines, -bounty X Y Z, -bounties, -presave, -clanspresave, -loadp[i/u/b/r/l] X, -loadclanp X, -save, -savec, -savegui, -asave, -aload, -load[i/u/b/r/l] X, -far, close, -camdistance X, -camlockon/off, -camrpgon/off, -votekick X, -yes, -aion/off X, -wrapup, -goblindeposit, -clanrename X, -clangold X, -clanlumber X, -clanwgold X, -clanwlumber X, -clans, -claninfo, -clanrank X Y, -claninvite X, -clanaccept, -clanleave, -clanaion/off, -friends, -friendsv, -friendsvuf, -ally X, -allyv X, -allyvu X, -allyvuf X, -neutral X, -neutralv X, -unally X, -unallyv X, -maxbosslevels, -zoneson/off, -letter X Y, -mailbox, -dice X, -lightsabercolor X Y, -lightsabertype X"
endfunction

function DropAllItemsFromHero takes unit hero returns nothing
	local integer i = 0
	loop
		exitwhen (i >= bj_MAX_INVENTORY)
		call UnitRemoveItemFromSlot(hero, i)
		set i = i + 1
	endloop
endfunction

function DropAllItemsFromHero1 takes player whichPlayer returns nothing
    call DropAllItemsFromHero(udg_Hero[GetPlayerId(whichPlayer)])
endfunction

function DropAllItemsFromHero2 takes player whichPlayer returns nothing
    call DropAllItemsFromHero(udg_Hero2[GetPlayerId(whichPlayer)])
endfunction

function DropAllItemsFromHero3 takes player whichPlayer returns nothing
    call DropAllItemsFromHero(udg_Hero3[GetPlayerId(whichPlayer)])
endfunction

// Tree Finding System

function IsDestructableTree takes destructable whichDestructable returns boolean
     if ( ( GetDestructableTypeId(whichDestructable) == 'LTlt' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ATtr' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ATtc' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'BTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'BTtc' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'KTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'YTst' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'YTft' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'YTwt' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'YTct' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'JTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'DTsh' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'CTtr' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'CTtc' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ITtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ITtc' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'LTlt' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'WTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'NTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'WTst' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'OTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ZTtw' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'ZTtc' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'GTsh' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'VTlt' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'FTtw' ) ) then
        return true
    endif
    // Easter Trees
    if ( ( GetDestructableTypeId(whichDestructable) == 'B005' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'B006' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(whichDestructable) == 'B006' ) ) then
        return true
    endif
    return false
endfunction

function EnumLivingTreeDestructablesInCircleFilter takes nothing returns boolean
    local boolean result = IsDestructableAliveBJ(GetFilterDestructable()) and IsDestructableTree(GetFilterDestructable())
    local location destLoc = null

    if (result) then
        set destLoc = GetDestructableLoc(GetFilterDestructable())
        set result = DistanceBetweenPoints(destLoc, bj_enumDestructableCenter) <= bj_enumDestructableRadius
        call RemoveLocation(destLoc)
        set destLoc = null
    endif

    return result
endfunction

function RandomLivingTreeDestructableInCircle takes real radius, location loc returns destructable
    local boolexpr whichFilter= Filter(function EnumLivingTreeDestructablesInCircleFilter)
    local rect r

    if (radius >= 0) then
        set bj_enumDestructableCenter = loc
        set bj_enumDestructableRadius = radius
        set bj_destRandomConsidered = 0
        set bj_destRandomCurrentPick = null
        set r = GetRectFromCircleBJ(loc, radius)
        call EnumDestructablesInRect(r, whichFilter, function RandomDestructableInRectBJEnum)
        call RemoveRect(r)
        set r = null
    endif

    call DestroyBoolExpr(whichFilter)
    set whichFilter = null

    return bj_destRandomCurrentPick
endfunction

endlibrary

globals
	string array raceIcons
	string array professionIcons
endglobals

function AddRaceIcon takes integer whichRace, string icon returns nothing
    set raceIcons[whichRace] = icon
endfunction

function GetIconByRace takes integer whichRace returns string
    local string result = raceIcons[whichRace]
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function AddProfessionIcon takes integer profession, string icon returns nothing
    set professionIcons[profession] = icon
endfunction

function GetIconByProfession takes integer profession returns string
    local string result = professionIcons[profession]
    if (result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function AddUnitTypeIcon takes integer unitTypeId, string icon returns nothing
endfunction

function AddItemTypeIcon takes integer itemTypeId, string icon returns nothing
endfunction

function GetIconByUnitType takes integer unitTypeId returns string
	local string result = BlzGetAbilityIcon(unitTypeId)
    if (unitTypeId == 0 or result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Unit.blp"
    endif

    return result
endfunction

function GetIconByItemType takes integer itemTypeId returns string
	local string result = BlzGetAbilityIcon(itemTypeId)
    if (itemTypeId == 0 or result == null or result == "") then
        return "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp"
    endif

    return result
endfunction

// https://www.hiveworkshop.com/threads/detecting-item-price.120355/
function GetUnitShop takes nothing returns integer
    return 'ngme'                                                               // This is the raw code for the goblin shop
endfunction

function GetUnitSell takes nothing returns integer
    return 'Hpal'                                                               // This is the raw code for the paladin
endfunction

function GetItemValueGold takes integer i returns integer
    local real x   = 0                                                          // This is the x position where we create the dummy units. Dont place it in the water.
    local real y   = 0                                                          // This is the y position where we create the dummy units. Dont place it in the water.
    local unit u1  = CreateUnit(Player(12),GetUnitShop(),x,y,0)
    local unit u2  = CreateUnit(Player(12),GetUnitSell(),x,y-100,90)
    local item a   = UnitAddItemByIdSwapped(i,u2)
    local integer g1 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD)
    local integer g2 = 0
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD) - g1
    call SetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_GOLD)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemValueLumber takes integer i returns integer
    local real x   = 0                                                          // This is the x position where we create the dummy units. Dont place it in the water.
    local real y   = 0                                                          // This is the y position where we create the dummy units. Dont place it in the water.
    local unit u1  = CreateUnit(Player(12),GetUnitShop(),x,y,0)
    local unit u2  = CreateUnit(Player(12),GetUnitSell(),x,y-100,90)
    local item a   = UnitAddItemByIdSwapped(i,u2)
    local integer g1 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2 = 0
    call UnitDropItemTarget(u2,a,u1)
    set g2 = GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER) - g1
    call SetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER,GetPlayerState(Player(12),PLAYER_STATE_RESOURCE_LUMBER)-g2)

    call RemoveUnit(u1)
    call RemoveUnit(u2)
    set u1 = null
    set u2 = null
    set a  = null
    return g2
endfunction

function GetItemTypePerishable takes integer i returns boolean
    local item tmpItem = CreateItem(i, 0.0, 0.0)
    local boolean result = BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem = null

    return result
endfunction

function ClearRucksackItem takes integer index returns nothing
    set udg_RucksackItemType[index] = 0
    set udg_RucksackItemCharges[index] = 0
    set udg_RucksackItemName[index] = ""
    set udg_RucksackItemDescription[index] = ""
    set udg_RucksackItemTooltip[index] = ""
    set udg_RucksackItemTooltipExtended[index] = ""
endfunction

function SetRucksackItemFromItem takes item whichItem, integer index returns nothing
    set udg_RucksackItemType[index] = GetItemTypeId(whichItem)
    set udg_RucksackItemCharges[index] = GetItemCharges(whichItem)
    set udg_RucksackItemPawnable[index] = IsItemPawnable(whichItem)
    set udg_RucksackItemInvulnerable[index] = IsItemInvulnerable(whichItem)
    set udg_RucksackItemName[index] = GetItemName(whichItem)
    set udg_RucksackItemDescription[index] = BlzGetItemDescription(whichItem)
    set udg_RucksackItemTooltip[index] = BlzGetItemTooltip(whichItem)
    set udg_RucksackItemTooltipExtended[index] = BlzGetItemExtendedTooltip(whichItem)
endfunction

function ApplyRucksackItem takes item whichItem, integer index returns nothing
    call SetItemCharges(whichItem, udg_RucksackItemCharges[index])
    call SetItemPawnable(whichItem, udg_RucksackItemPawnable[index])
    call SetItemDroppable(whichItem, true) // all items must be droppable in the backpack!
    call SetItemInvulnerable(whichItem, udg_RucksackItemInvulnerable[index])
    call BlzSetItemName(whichItem, udg_RucksackItemName[index])
    call BlzSetItemDescription(whichItem, udg_RucksackItemDescription[index])
    call BlzSetItemTooltip(whichItem, udg_RucksackItemTooltip[index])
    call BlzSetItemExtendedTooltip(whichItem, udg_RucksackItemTooltipExtended[index])
endfunction

function BackpackCountItemsOfItemTypeForPlayer takes integer playerId, integer itemTypeId returns integer
	local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local integer result = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[playerId] == I0) then
				if (UnitItemInSlot(udg_Rucksack[playerId], I1) != null and GetItemTypeId(UnitItemInSlot(udg_Rucksack[playerId], I1)) == itemTypeId) then
					set result = result + 1
				endif
            else
				if (udg_RucksackItemType[index] == itemTypeId) then
					set result = result + 1
				endif
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
	return result
endfunction

function HeroCountItemsOfItemType takes unit hero, integer itemTypeId returns integer
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (GetItemTypeId(UnitItemInSlot(hero, i)) == itemTypeId) then
            set result = result + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function Hero1CountItemsOfItemType takes unit hero, integer itemTypeId returns integer
    local integer convertedPlayerId = GetConvertedPlayerId(GetOwningPlayer(hero))
    local integer result = HeroCountItemsOfItemType(hero, itemTypeId)
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(udg_EquipmentBags[convertedPlayerId]))
        set result = result + HeroCountItemsOfItemType(BlzGroupUnitAt(udg_EquipmentBags[convertedPlayerId], i), itemTypeId)
        set i = i + 1
    endloop
	return result
endfunction

function HeroDropRandomItem takes unit hero returns item
    local integer playerId = GetPlayerId(GetOwningPlayer(hero))
    local integer convertedPlayerId = GetConvertedPlayerId(GetOwningPlayer(hero))
    local unit array heroes
    local integer array slots
    local integer counter = 0
    local unit bag = null
    local integer maxBags = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(hero, i) != null) then
            set heroes[counter] = hero
            set slots[counter] = i
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    if (hero == udg_Hero[playerId]) then
        set maxBags = BlzGroupGetSize(udg_EquipmentBags[convertedPlayerId])
        set i = 0
        loop
            exitwhen(i == maxBags)
            set bag = BlzGroupUnitAt(udg_EquipmentBags[convertedPlayerId], i)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                if (UnitItemInSlot(bag, j) != null) then
                    set heroes[counter] = bag
                    set slots[counter] = j
                    set counter = counter + 1
                endif
                set j = j + 1
            endloop
            set bag = null
            set i = i + 1
        endloop
    endif
    if (counter > 0) then
        set i = GetRandomInt(0, counter)
        return UnitRemoveItemFromSlot(heroes[i], slots[i])
    endif

    return null
endfunction

function RemoveAllBackpackItemTypesForPlayer takes integer playerId, integer itemTypeId returns integer
	local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local integer result = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[playerId] == I0) then
				if (UnitItemInSlot(udg_Rucksack[playerId], I1) != null and GetItemTypeId(UnitItemInSlot(udg_Rucksack[playerId], I1)) == itemTypeId) then
					call RemoveItem(UnitItemInSlot(udg_Rucksack[playerId], I1))
					set result = result + 1
				endif
            else
				if (udg_RucksackItemType[index] == itemTypeId) then
                    call ClearRucksackItem(index)
					set result = result + 1
				endif
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
	return result
endfunction


// This does not clear the backpack inventory!
function DropBackpackForPlayer takes integer playerId, rect whichRect returns nothing
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item whichItem = null
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackPageNumber[playerId] == I0) then
                set whichItem = CreateItem(GetItemTypeId(UnitItemInSlot(udg_Rucksack[playerId], I1)), GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            else
                set whichItem = CreateItem(udg_RucksackItemType[index], GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            endif

            call ApplyRucksackItem(whichItem, index)

            if (udg_RucksackPageNumber[playerId] == I0) then
                call SetItemCharges(whichItem, GetItemCharges(UnitItemInSlot(udg_Rucksack[playerId], I1)))
            else
                call SetItemCharges(whichItem, udg_RucksackItemCharges[index])
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
endfunction

function DropBackpack takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item whichItem = null
    local real x = GetUnitX(udg_Rucksack[playerId])
    local real y = GetUnitY(udg_Rucksack[playerId])
    // drop before so they won't have to be cleared or removed
    call DropAllItemsFromHero(udg_Rucksack[playerId])
    set I1 = 0
    loop
        exitwhen (I1 == bj_MAX_INVENTORY)
        set index = Index3D(playerId, udg_RucksackPageNumber[playerId], I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        call ClearRucksackItem(index)
        set I1 = I1 + 1
    endloop
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            set whichItem = CreateItem(udg_RucksackItemType[index], x, y)
            call ApplyRucksackItem(whichItem, index)
            call SetItemCharges(whichItem, udg_RucksackItemCharges[index])
            call ClearRucksackItem(index)
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
endfunction

function DropQuestItemFromCreepHeroAtRect takes unit hero, integer itemTypeId, rect whichRect returns item
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY or whichItem != null)
        if (GetItemTypeId(UnitItemInSlot(hero, i)) == itemTypeId) then
            call RemoveItem(UnitItemInSlot(hero, i))
            set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
            call SetItemInvulnerable(whichItem, true)
        endif
        set i = i + 1
    endloop
    return whichItem
endfunction

function DropQuestItemFromHeroAtRect takes integer playerId, integer itemTypeId, rect whichRect returns item
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item whichItem = DropQuestItemFromCreepHeroAtRect(udg_Hero[playerId], itemTypeId, whichRect)
	// Check second hero inventory
	if (whichItem == null and udg_Hero2[playerId] != null) then
        set whichItem = DropQuestItemFromCreepHeroAtRect(udg_Hero2[playerId], itemTypeId, whichRect)
	endif
	// Check third hero inventory
	if (whichItem == null and udg_Hero3[playerId] != null) then
		set whichItem = DropQuestItemFromCreepHeroAtRect(udg_Hero3[playerId], itemTypeId, whichRect)
	endif
	// Check Equipment Bags
	if (whichItem == null) then
        set I0 = 0
        loop
            exitwhen(I0 == BlzGroupGetSize(udg_EquipmentBags[playerId + 1]) or whichItem != null)
            set whichItem = DropQuestItemFromCreepHeroAtRect(BlzGroupUnitAt(udg_EquipmentBags[playerId + 1], I0), itemTypeId, whichRect)
            set I0 = I0 + 1
        endloop
	endif
    // Check the backpack
    if (whichItem == null) then
        set I0 = 0
        loop
            exitwhen(I0 == udg_RucksackMaxPages or whichItem != null)
            set I1 = 0
            loop
                exitwhen(I1 == bj_MAX_INVENTORY or whichItem != null)
                set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                if (udg_RucksackItemType[index] == itemTypeId or (udg_RucksackPageNumber[playerId] == I0 and GetItemTypeId(UnitItemInSlot(udg_Rucksack[playerId], I1)) == itemTypeId)) then
                    if (udg_RucksackPageNumber[playerId] == I0) then
                        call RemoveItem(UnitItemInSlot(udg_Rucksack[playerId], I1))
                    endif
                    call ClearRucksackItem(index)
                    set whichItem = CreateItem(itemTypeId, GetRectCenterX(whichRect), GetRectCenterY(whichRect))
                    call SetItemInvulnerable(whichItem, true)
                endif
                set I1 = I1 + 1
            endloop
            set I0 = I0 + 1
        endloop
    endif

    return whichItem
endfunction

function DropQuestItemFromHeroAtRectByDyingUnit takes integer itemTypeId, rect whichRect returns item
    return DropQuestItemFromHeroAtRect(GetPlayerId(GetOwningPlayer(GetTriggerUnit())), itemTypeId, whichRect)
endfunction

function ClearCurrentRucksackPageForPlayer takes integer playerId returns nothing
    local integer I1 = 0
    local integer index = 0
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, udg_RucksackPageNumber[playerId], I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearRucksackItem(index)
            set I1 = I1 + 1
        endloop
endfunction

function ClearRucksackForPlayer takes integer playerId returns nothing
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Clearing item at index " + I2S(index))
            call ClearRucksackItem(index)
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop
endfunction

function AddItemToBackpackForPlayer takes integer playerId, item whichItem returns boolean
    local integer I0 = 0
    local integer I1 = 0
    local integer index = 0
    local item slotItem = null
    local integer convertedPlayerId = playerId + 1
    // try to add it to the inventory first
    set I0 = 0
    loop
        exitwhen(I1 == bj_MAX_INVENTORY)
        exitwhen (whichItem == null)
        set slotItem = UnitItemInSlot(udg_Rucksack[convertedPlayerId], I0)
        if (slotItem == null or (GetItemTypeId(whichItem) == GetItemTypeId(slotItem) and GetMaxStacksByItemTypeId(GetItemTypeId(whichItem)) >= GetItemCharges(slotItem) + GetItemCharges(whichItem))) then
            call UnitAddItem(udg_Rucksack[convertedPlayerId], slotItem)
            set whichItem = null
            return true
        endif
        set slotItem = null
        set I0 = I0 + 1
    endloop
    // try adding it to another bag then
    set I0 = 0
    loop
        exitwhen(I0 == udg_RucksackMaxPages)
        exitwhen (whichItem == null)
        set I1 = 0
        loop
            exitwhen(I1 == bj_MAX_INVENTORY)
            exitwhen (whichItem == null)
            set index = Index3D(playerId, I0, I1, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            // empty slot
            if (udg_RucksackItemType[index] == 0) then
                call DisplayTimedTextToPlayer(Player(playerId), 0.00, 0.00, 4.00, ("Added " + GetItemName(whichItem) + " to backpack bag " + I2S(I0 + 1) + " ."))
                call SetRucksackItemFromItem(whichItem, index)
                call RemoveItem(whichItem)
                set whichItem = null

                return true
            // stack
            elseif (GetItemTypeId(whichItem) == udg_RucksackItemType[index] and GetMaxStacksByItemTypeId(udg_RucksackItemType[index]) >= udg_RucksackItemCharges[index] + GetItemCharges(whichItem)) then
                call DisplayTimedTextToPlayer(Player(playerId), 0.00, 0.00, 4.00, ("Added " + GetItemName(whichItem) + " to backpack bag " + I2S(I0 + 1) + " ."))
                set udg_RucksackItemCharges[index] = udg_RucksackItemCharges[index] + GetItemCharges(whichItem)
                call RemoveItem(whichItem)
                set whichItem = null

                return true
            endif
            set I1 = I1 + 1
        endloop
        set I0 = I0 + 1
    endloop

    return false
endfunction

function DestroyRucksackSystemForPlayer takes integer playerId returns nothing
    if (udg_Rucksack[playerId] != null) then
        call RemoveUnit(udg_Rucksack[playerId])
        set udg_Rucksack[playerId] = null
    endif
    call ClearRucksackForPlayer(playerId)
endfunction

function RefreshRucksackPage takes integer playerId returns nothing
    local integer RucksackPage = udg_RucksackPageNumber[playerId]
    local integer I0 = 0
    local integer index = 0
    local item whichItem = null
	call DisableTrigger(gg_trg_Stats_Legendary_Artifact_Counter_Pickup)
	call DisableTrigger(udg_PlayerRucksackTriggerPickup[playerId])
	call DisableTrigger(udg_PlayerRucksackTriggerDrop[playerId])
    // Create All Items From Next/Previous Page
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(playerId, RucksackPage, I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        if (udg_RucksackItemType[index] != 0) then
            //call BJDebugMsg("Item type " + GetObjectName(udg_RucksackItemType[index]) + " at index " + I2S(index))
            call UnitAddItemToSlotById(udg_Rucksack[playerId], udg_RucksackItemType[index], I0)
            set whichItem = UnitItemInSlot(udg_Rucksack[playerId], I0)
            call ApplyRucksackItem(whichItem, index)
        //else
            //call BJDebugMsg("Empty at index " + I2S(index))
        endif
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Stats_Legendary_Artifact_Counter_Pickup)
	call EnableTrigger(udg_PlayerRucksackTriggerPickup[playerId])
	call EnableTrigger(udg_PlayerRucksackTriggerDrop[playerId])
endfunction

function ChangeRucksackPageEx takes integer playerId, integer newRucksackPage returns nothing
    local integer I0 = 0
    local integer index = 0
    local player RucksackOwner = Player(playerId)
    local item SlotItem = null
	call DisableTrigger(gg_trg_Stats_Legendary_Artifact_Counter_Drop)
	call DisableTrigger(udg_PlayerRucksackTriggerPickup[playerId])
	call DisableTrigger(udg_PlayerRucksackTriggerDrop[playerId])
    // Save All Items
    set I0 = 0
    loop
        exitwhen(I0 == bj_MAX_INVENTORY)
        set index = Index3D(playerId, udg_RucksackPageNumber[playerId], I0, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        set SlotItem = UnitItemInSlot(udg_Rucksack[playerId], I0)
        if (SlotItem != null) then
            call SetRucksackItemFromItem(SlotItem, index)
            //call BJDebugMsg("Storing at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            call RemoveItem(SlotItem)
            set SlotItem = null
        else
            //call BJDebugMsg("Storing empty at index " + I2S(index))
            call ClearRucksackItem(index)
        endif
        set I0 = I0 + 1
    endloop
	call EnableTrigger(gg_trg_Stats_Legendary_Artifact_Counter_Drop)
	call EnableTrigger(udg_PlayerRucksackTriggerPickup[playerId])
	call EnableTrigger(udg_PlayerRucksackTriggerDrop[playerId])
	// change page
    set udg_RucksackPageNumber[playerId] = newRucksackPage
    call DisplayTimedTextToPlayer(RucksackOwner, 0.00, 0.00, 4.00, ("Open Bag " + I2S(newRucksackPage + 1) + "."))
    call RefreshRucksackPage(playerId)
    set RucksackOwner = null
endfunction

function ChangeRucksackPage takes integer playerId, boolean Forward returns nothing
    local integer RucksackPage = udg_RucksackPageNumber[playerId]
    local integer newRucksackPage = 0
    if (Forward) then
        if (RucksackPage != (udg_RucksackMaxPages - 1)) then
            set newRucksackPage = RucksackPage + 1
        else
            set newRucksackPage = 0
        endif
    else
        if (RucksackPage != 0) then
            set newRucksackPage = RucksackPage - 1
        else
            set newRucksackPage = udg_RucksackMaxPages - 1
        endif
    endif
    call ChangeRucksackPageEx(playerId, newRucksackPage)
endfunction

function UpdateItemsForBackpackUI takes player whichPlayer returns nothing
    local integer index = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BlzFrameSetTexture(BackpackItemFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
            call BlzFrameSetText(BackpackItemChargesFrame[index], I2S(udg_RucksackItemCharges[index]))
            if (udg_RucksackItemType[index] == 0) then
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            else
                call BlzFrameSetTexture(BackpackItemBackdropFrame[index], GetIconByItemType(udg_RucksackItemType[index]), 0, true)
                if (BackpackUIVisible[GetPlayerId(whichPlayer)] and (GetItemTypePerishable(udg_RucksackItemType[index]) or udg_RucksackItemCharges[index] > 0)) then
                    call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                endif
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function OrderBackpack takes player whichPlayer returns nothing
    local integer index1 = 0
    local integer index2 = 0
    local integer maxCharges = 0
    local integer charges = 0
    local integer stackedCharges = 0
    local integer i = 0
    local integer j = 0
    local integer k = 0
    local integer l = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index1 = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            if (udg_RucksackItemType[index1] != 0) then
                set charges = udg_RucksackItemCharges[index1]
                set maxCharges = GetMaxStacksByItemTypeId(udg_RucksackItemType[index1])
                if (charges < maxCharges) then
                    set k = i
                    loop
                        exitwhen (k == udg_RucksackMaxPages or charges >= maxCharges)
                        set l = j
                        loop
                            exitwhen (l == bj_MAX_INVENTORY or charges >= maxCharges)
                            set index2 = Index3D(GetPlayerId(whichPlayer), k, l, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                            if (udg_RucksackItemType[index2] == udg_RucksackItemType[index2]) then
                                set stackedCharges = IMinBJ(udg_RucksackItemCharges[index2], maxCharges - charges)
                                set charges = charges + stackedCharges

                                if (stackedCharges == udg_RucksackItemCharges[index2]) then
                                    call ClearRucksackItem(index2)
                                else
                                    set udg_RucksackItemCharges[index2] = udg_RucksackItemCharges[index2] - stackedCharges
                                endif
                            endif
                            set l = l + 1
                        endloop
                        set k = k + 1
                    endloop
                endif
                set udg_RucksackItemCharges[index1] = charges
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    call RefreshRucksackPage(GetPlayerId(whichPlayer))
    call UpdateItemsForBackpackUI(whichPlayer)
endfunction

function TriggerConditionChangeRucksackPage takes nothing returns boolean
    return GetSpellAbilityId() == udg_RucksackAbility1 or GetSpellAbilityId() == udg_RucksackAbility2
endfunction

function TriggerFunctionChangeRucksackPage takes nothing returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if (GetSpellAbilityId() == udg_RucksackAbility1) then
        call ChangeRucksackPage(playerId, true)
    elseif (GetSpellAbilityId() == udg_RucksackAbility2) then
        call ChangeRucksackPage(playerId, false)
    endif
    call UpdateItemsForBackpackUI(GetOwningPlayer(GetTriggerUnit()))
endfunction

function TriggerConditionPickupRucksackItem takes nothing returns boolean
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    return GetTriggerUnit() == udg_Rucksack[playerId]
endfunction


function TriggerFunctionPickupRucksackItem takes nothing returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    local item whichItem = null
    local integer index = 0
    local integer i = 0
    // update the backpack items from the current inventory
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(GetTriggerUnit(), i)
        if (whichItem != null) then
            set index = Index3D(playerId, udg_RucksackPageNumber[playerId], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            call SetRucksackItemFromItem(whichItem, index)
            set whichItem = null
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(GetOwningPlayer(GetTriggerUnit()))
endfunction

function TriggerConditionDropRucksackItem takes nothing returns boolean
    return GetTriggerUnit() == udg_Rucksack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction


function TriggerFunctionDropRucksackItem takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer playerId = GetPlayerId(owner)
    local integer index = 0
    local integer i = 0
    call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        if (UnitItemInSlot(triggerUnit, i) == null) then
            set index = Index3D(playerId, udg_RucksackPageNumber[playerId], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            set udg_RucksackItemType[index] = 0
            set udg_RucksackItemCharges[index] = 0
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(owner)
    set owner = null
    set triggerUnit = null
endfunction

globals
    constant integer A_ORDER_ID_SMART = 851971
    constant integer A_ORDER_ID_MOVE_SLOT_0 = 852002
    constant integer A_ORDER_ID_MOVE_SLOT_1 = 852003
    constant integer A_ORDER_ID_MOVE_SLOT_2 = 852004
    constant integer A_ORDER_ID_MOVE_SLOT_3 = 852005
    constant integer A_ORDER_ID_MOVE_SLOT_4 = 852006
    constant integer A_ORDER_ID_MOVE_SLOT_5 = 852007
    constant integer A_ORDER_ID_USE_SLOT_0 = 852008
    constant integer A_ORDER_ID_USE_SLOT_1 = 852009
    constant integer A_ORDER_ID_USE_SLOT_2 = 852010
    constant integer A_ORDER_ID_USE_SLOT_3 = 852011
    constant integer A_ORDER_ID_USE_SLOT_4 = 852012
    constant integer A_ORDER_ID_USE_SLOT_5 = 852013
endglobals

function TriggerConditionMoveRucksackItem takes nothing returns boolean
    return GetTriggerUnit() == udg_Rucksack[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] and GetIssuedOrderId() >= A_ORDER_ID_MOVE_SLOT_0 and GetIssuedOrderId() <= A_ORDER_ID_MOVE_SLOT_5
endfunction

function TriggerFunctionMoveRucksackItem takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local player owner = GetOwningPlayer(triggerUnit)
    local integer playerId = GetPlayerId(owner)
    local integer i = 0
    local item whichItem = null
    local integer index = 0
    call TriggerSleepAction(0.0) // TODO Apparently the item is still there without sleeping.
    //call BJDebugMsg("Moved item!")
    // update all items of the current bag after moving the item
    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set index = Index3D(playerId, udg_RucksackPageNumber[playerId], i, udg_RucksackMaxPages, bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(triggerUnit, i)
        if (whichItem == null) then
            //call BJDebugMsg("Dropping item at index " + I2S(index) + " with type " + GetObjectName(udg_RucksackItemType[index]))
            call ClearRucksackItem(index)
        else
            call SetRucksackItemFromItem(whichItem, index)
        endif
        set i = i + 1
    endloop
    call UpdateItemsForBackpackUI(owner)
    set owner = null
    set triggerUnit = null
endfunction

function InventoryIsFull takes unit whichUnit, integer itemTypeId returns boolean
    local integer size = UnitInventorySize(whichUnit)
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == size)
        set whichItem = UnitItemInSlot(whichUnit, i)
        if (whichItem == null or GetItemTypeId(whichItem) == itemTypeId and GetMaxStacksByItemTypeId(itemTypeId) > GetItemCharges(whichItem)) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

function TriggerConditionOrderRucksackItem takes nothing returns boolean
    return udg_Hero[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit() and GetIssuedOrderId() == A_ORDER_ID_SMART and GetOrderTargetItem() != null and not IsItemPowerup(GetOrderTargetItem()) and InventoryIsFull(GetTriggerUnit(), GetItemTypeId(GetOrderTargetItem()))
endfunction

// This code is directly taken from the system "EasyItemStacknSplit v2.7.4" and allows picking up items even if the inventory is full.
function TimerFunctionPickupItem takes nothing returns nothing
    local integer i = 0
    local unit backpack = null
    local item targetItem = null
    local boolean noTargets = true
    local unit whichUnit = null
    local real x = 0.0
    local real y = 0.0
    local integer order = 0
    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set backpack = udg_Rucksack[i]
        set targetItem = udg_RucksackTargetItem[i]
        if (backpack != null and targetItem != null) then
            set whichUnit = udg_Rucksack[i]
            if (GetWidgetLife(whichUnit) > 0.0 and GetWidgetLife(targetItem) > 0.0) then
                if (GetUnitCurrentOrder(whichUnit) == 851986) then
                    set x = GetItemX(targetItem) - GetUnitX(whichUnit)
                    set y = GetItemY(targetItem) - GetUnitY(whichUnit)

                    if (x * x + y * y <= 22500) then
                        call IssueImmediateOrder(whichUnit, "stop")
                        // TODO play fake sound
                        call SetUnitFacing(whichUnit, bj_RADTODEG * Atan2(GetItemY(targetItem) - GetUnitY(whichUnit), GetItemX(targetItem) - GetUnitX(whichUnit)))
                        if (not AddItemToBackpackForPlayer(i, udg_RucksackTargetItem[i])) then
                            call SimError(Player(i), "Inventory is full.")
                        endif
                        set udg_RucksackTargetItem[i] = null
                    endif
                endif
            else
                set udg_RucksackTargetItem[i] = null
            endif
            set whichUnit = null

            if (udg_RucksackTargetItem[i] != null) then
                set noTargets = false
            endif
        endif
        set backpack = null
        set targetItem = null
        set i = i + 1
    endloop
    if (noTargets) then
        set udg_RucksackPickupTimerHasStarted = false
        call PauseTimer(GetExpiredTimer())
    endif
endfunction

function TriggerFunctionOrderRucksackItem takes nothing returns nothing
    set udg_RucksackTargetItem[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] = GetOrderTargetItem()
    if (not udg_RucksackPickupTimerHasStarted) then
        set udg_RucksackPickupTimerHasStarted = true
        call TimerStart(udg_RucksackPickupTimer, 0.05, true, function TimerFunctionPickupItem)
    endif
    call IssuePointOrder(GetTriggerUnit(), "move", GetItemX(GetOrderTargetItem()), GetItemY(GetOrderTargetItem()))
endfunction

function CreateRucksackForPlayer takes integer playerId returns nothing
    local player RucksackPlayer = Player(playerId)
    set udg_Rucksack[playerId] = CreateUnit(RucksackPlayer, udg_RucksackUnitType, GetUnitX(udg_Hero[playerId]), GetUnitY(udg_Hero[playerId]), 0.00)
    call SuspendHeroXP(udg_Rucksack[playerId], true)
    call SetUnitInvulnerable(udg_Rucksack[playerId], true)
    // Change Ruckack Page Trigger
    if (udg_PlayerRucksackTrigger[playerId] == null) then
        set udg_PlayerRucksackTrigger[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTrigger[playerId], RucksackPlayer, EVENT_PLAYER_UNIT_SPELL_CHANNEL, null)
        call TriggerAddCondition(udg_PlayerRucksackTrigger[playerId], Condition(function TriggerConditionChangeRucksackPage))
        call TriggerAddAction(udg_PlayerRucksackTrigger[playerId], function TriggerFunctionChangeRucksackPage)
    endif
    if (udg_PlayerRucksackTriggerPickup[playerId] == null) then
        set udg_PlayerRucksackTriggerPickup[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerPickup[playerId], RucksackPlayer, EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerPickup[playerId], Condition(function TriggerConditionPickupRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerPickup[playerId], function TriggerFunctionPickupRucksackItem)
    endif
    if (udg_PlayerRucksackTriggerDrop[playerId] == null) then
        set udg_PlayerRucksackTriggerDrop[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerDrop[playerId], RucksackPlayer, EVENT_PLAYER_UNIT_DROP_ITEM, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerDrop[playerId], Condition(function TriggerConditionDropRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerDrop[playerId], function TriggerFunctionDropRucksackItem)
    endif
    if (udg_PlayerRucksackTriggerMove[playerId] == null) then
        set udg_PlayerRucksackTriggerMove[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerMove[playerId], RucksackPlayer, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerMove[playerId], Condition(function TriggerConditionMoveRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerMove[playerId], function TriggerFunctionMoveRucksackItem)
    endif
    if (udg_PlayerRucksackTriggerOrder[playerId] == null) then
        set udg_PlayerRucksackTriggerOrder[playerId] = CreateTrigger()
        call TriggerRegisterPlayerUnitEvent(udg_PlayerRucksackTriggerOrder[playerId], RucksackPlayer, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER, null)
        call TriggerAddCondition(udg_PlayerRucksackTriggerOrder[playerId], Condition(function TriggerConditionOrderRucksackItem))
        call TriggerAddAction(udg_PlayerRucksackTriggerOrder[playerId], function TriggerFunctionOrderRucksackItem)
    endif
    set RucksackPlayer = null
endfunction

function RefreshRucksackForPlayer takes integer playerId returns nothing
     if (udg_Rucksack[playerId] != null) then
        call RemoveUnit(udg_Rucksack[playerId])
        set udg_Rucksack[playerId] = null
    endif
    call CreateRucksackForPlayer(playerId)
    call RefreshRucksackPage(playerId)
endfunction

function SetupCustomRucksackSystem takes nothing returns nothing
    set	udg_RucksackUnitType = 'E008'
    set udg_RucksackAbility1 = 'A02L'
    set	udg_RucksackAbility2 = 'A02M'
    set	udg_RucksackMaxPages = 30
    set udg_RucksackMoveTime = 0.10
endfunction

function TriggerActionMoveRucksack takes nothing returns nothing
    local integer i = 0
    local real x = 0.0
    local real y = 0.0
    local integer j = 0
    local unit bag = null
    loop
        exitwhen(i == bj_MAX_PLAYERS)
        if (PlayerIsOnlineUser(i)) then
            set x = GetUnitX(udg_Hero[i])
            set y = GetUnitY(udg_Hero[i])

            if (udg_Rucksack[i] != null) then
                set bag = udg_Rucksack[i]
                call SetUnitX(bag, x)
                call SetUnitY(bag, y)
                set bag = null
            endif

            set j = 0
            loop
                exitwhen (j == BlzGroupGetSize(udg_EquipmentBags[i + 1]))
                set bag = BlzGroupUnitAt(udg_EquipmentBags[i + 1], j)
                call SetUnitX(bag, x)
                call SetUnitY(bag, y)
                set bag = null
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
endfunction

function GetUnitLevelByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_LEVEL)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDamageTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitWeaponIntegerField(dummy , UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitDefenseTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_DEFENSE_TYPE)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function GetUnitMovementTypeByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, GetRectCenterX(gg_rct_Evolution_Dummy_Area), GetRectCenterY(gg_rct_Evolution_Dummy_Area), 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_MOVE_TYPE)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction

function InitCustomSystems takes nothing returns nothing
    local integer I0 = 0
    set udg_DB = InitHashtable()
    call SetupCustomRucksackSystem()
    // Movement Trigger
    set udg_RucksackTrigger = CreateTrigger()
    call TriggerRegisterTimerEvent(udg_RucksackTrigger, udg_RucksackMoveTime, true)
    call TriggerAddAction(udg_RucksackTrigger, function TriggerActionMoveRucksack)
endfunction

// Baradé's Item Respawn System 1.1
//
// Allows picked up or destroyed items to respawn after some time.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Place some items on the map.
//
// API:
//
// function TriggerRegisterItemRespawnEvent takes trigger whichTrigger returns nothing
//
// Registers an item respawn event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any item is respawned by this system. You can access the triggering respawning item
// and index from the system via functions.
//
// function TriggerRegisterItemRespawnStartsEvent takes trigger whichTrigger returns nothing
//
// Registers an item respawn start event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any item respawn timer is started by this system. You can access the previously picked up or destroyed item
// and index from the system via functions.
//
// function GetTriggerRespawnItem takes nothing returns item
//
// Returns the triggering respawned item from a trigger which was evaluated or executed due to a respawn event.
// Returns the triggering picked up previously respawned item if the event is a respawn starts event.
//
// function GetTriggerRespawnItemIndex takes nothing returns integer
//
// Returns the corresponding index of the item respawn from the respawned item or item for which the respawn timer has been started of the
// evaluated or executed trigger.
//
// function GetItemRespawnIndex takes item whichItem returns integer
//
// Returns the corresponding index of the item respawn matching the passed item. If there is none, it returns -1.
//
// function GetItemRespawnCounter takes nothing returns integer
//
// Returns the maximum number of item respawn indices. Note that not every index in between has to be valid. This function might help integer
// loops to go through all existing item respawns. Please use IsRespawnItemValid to check if an index in between 0 and the return value of
// this function is actually used.
//
// function IsRespawnItemValid takes integer index returns boolean
//
// Returns if the passed index belongs to a valid item respawn.
//
// function RespawnItem takes integer index returns boolean
//
// Respawns the item from the item respawn with the corresponding index. The index must be valid. Returns false if
// the passed index is not valid.
//
// function RespawnAllItems takes nothing returns nothing
//
// Respawns all items from all item respawns which have no item at the moment.
//
// function StartItemRespawn takes integer index returns nothing
//
// Manually starts the respawn of an item respawn no matter if the item has not been picked up or destroyed yet.
//
// function AddRespawnItem takes item whichItem returns integer
//
// Creates a new item respawn for the specified item and returns the corresponding index.
//
// function AddRespawnItemPool takes itempool whichItemPool, real x, real y returns integer
//
// function AddRespawnItemRandom takes integer level, real x, real y returns integer
//
// function AddRespawnItemRandomEx takes itemtype whichType, integer level, real x, real y returns integer
//
// function RemoveRespawnItem takes integer index returns boolean
//
// function SetRespawnItemEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnItemEnabled takes integer index returns boolean
//
// function GetRespawnItemTimer takes integer index returns timer
//
// function GetRespawnItemType takes integer index returns integer
//
// function SetRespawnItemTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnItemTimeout takes integer index returns real
//
// function SetRespawnItemX takes integer index, real x returns nothing
//
// function GetRespawnItemX takes integer index returns real
//
// function SetRespawnItemY takes integer index, real y returns nothing
//
// function GetRespawnItemY takes integer index returns real
//
// function SetRespawnItem takes integer index, item whichItem returns nothing
//
// function GetRespawnItem takes integer index returns item
//
// function SetRespawnItemPool takes integer index, itempool whichItemPool returns nothing
//
// function GetRespawnItemPool takes integer index returns itempool
//
// function SetRespawnItemLevel takes integer index, integer level returns nothing
//
// function GetRespawnItemLevel takes integer index returns integer
//
// function SetRespawnItemItemType takes integer index, itemtype whichItemType returns nothing
//
// function GetRespawnItemItemType takes integer index returns itemtype
//
library ItemRespawnSystem

globals
    // The default delay until an item will be respawned.
    public constant real DEFAULT_TIMEOUT = 180.0
    // All preplaced items on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
    public constant boolean AUTO_ADD_ALL_PREPLACED_ITEMS = true

    public constant integer ITEM_RESPAWN_TYPE_ITEM = 0
    public constant integer ITEM_RESPAWN_TYPE_ITEMPOOL = 1
    public constant integer ITEM_RESPAWN_TYPE_RANDOM_LEVEL = 2
    public constant integer ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL = 3

    private integer respawnItemCounter = 0
    private integer respawnItemFreeIndex = 0
    private boolean array respawnItemIsValid
    private integer array respawnItemType
    private item array respawnItemItem
    private integer array respawnItemHandleId
    private integer array respawnItemItemTypeId
    private itempool array respawnItemPool
    private integer array respawnItemRandomLevel
    private itemtype array respawnItemRandomType
    private real array respawnItemX
    private real array respawnItemY
    private timer array respawnItemTimer
    private real array respawnItemTimeout
    private boolean array respawnItemEnabled
    private trigger array respawnItemDeathTrigger

    private integer callbackRespawnTriggersCounter = 0
    private trigger array callbackRespawnTriggers

    private integer callbackRespawnStartsTriggersCounter = 0
    private trigger array callbackRespawnStartsTriggers

    private item callbackItem = null
    private integer callbackIndex = -1

    private trigger pickupItemTrigger = CreateTrigger()
    private hashtable respawnItemHashTable = InitHashtable()
    private integer evaluateIndex = -1
    private trigger refreshEvaluateTrigger = CreateTrigger()
endglobals

function GetTriggerRespawnItem takes nothing returns item
    return callbackItem
endfunction

function GetTriggerRespawnItemIndex takes nothing returns integer
    return callbackIndex
endfunction

function TriggerRegisterItemRespawnEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnTriggersCounter
    set callbackRespawnTriggers[index] = whichTrigger
    set callbackRespawnTriggersCounter = callbackRespawnTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnTriggersCounter)
        set callbackItem = respawnItemItem[index]
        set callbackIndex = index
        call ConditionalTriggerExecute(callbackRespawnTriggers[i])
        set i = i + 1
    endloop
endfunction

function TriggerRegisterItemRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnStartsTriggersCounter
    set callbackRespawnStartsTriggers[index] = whichTrigger
    set callbackRespawnStartsTriggersCounter = callbackRespawnStartsTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnStartsTriggersCounter)
        set callbackItem = respawnItemItem[index]
        set callbackIndex = index
        call ConditionalTriggerExecute(callbackRespawnStartsTriggers[i])
        set i = i + 1
    endloop
endfunction

private function ClearItemRespawnIndex takes integer handleID returns nothing
    if (HaveSavedInteger(respawnItemHashTable, handleID, 0)) then
        call FlushChildHashtable(respawnItemHashTable, handleID)
    endif
endfunction

private function GetItemRespawnIndexByHandleID takes integer handleID returns integer
    if (HaveSavedInteger(respawnItemHashTable, handleID, 0)) then
        return LoadInteger(respawnItemHashTable, handleID, 0)
    endif

    return -1
endfunction

function GetItemRespawnIndex takes item whichItem returns integer
    return GetItemRespawnIndexByHandleID(GetHandleId(whichItem))
endfunction

function GetItemRespawnCounter takes nothing returns integer
    return respawnItemCounter
endfunction

function IsRespawnItemValid takes integer index returns boolean
    if (index < 0) then
        return false
    endif
    return respawnItemIsValid[index]
endfunction

function RespawnItem takes integer index returns boolean
    if (not IsRespawnItemValid(index)) then
        return false
    endif
    if (respawnItemType[index] == ITEM_RESPAWN_TYPE_ITEM) then
        set respawnItemItem[index] = CreateItem(respawnItemItemTypeId[index], respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_ITEMPOOL) then
        set respawnItemItem[index] = PlaceRandomItem(respawnItemPool[index], respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_RANDOM_LEVEL) then
        set respawnItemItem[index] = CreateItem(ChooseRandomItem(respawnItemRandomLevel[index]), respawnItemX[index], respawnItemY[index])
    elseif (respawnItemType[index] == ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL) then
        set respawnItemItem[index] = CreateItem(ChooseRandomItemEx(respawnItemRandomType[index], respawnItemRandomLevel[index]), respawnItemX[index], respawnItemY[index])
    endif
    set respawnItemHandleId[index] = GetHandleId(respawnItemItem[index])
    call SaveInteger(respawnItemHashTable, respawnItemHandleId[index], 0, index)
    set evaluateIndex = index
    call TriggerEvaluate(refreshEvaluateTrigger)
    call EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllItems takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= respawnItemCounter)
        if (IsRespawnItemValid(i) and respawnItemItem[i] == null) then
            call RespawnItem(i)
        endif
        set i = i + 1
    endloop
endfunction

private function TimerFunctionRespawnItem takes nothing returns nothing
    local integer index = LoadInteger(respawnItemHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnItem(index)
endfunction

function StartItemRespawn takes integer index returns nothing
    call EvaluateAndExecuteCallbackRespawnStartsTriggers(index)

    if (respawnItemHandleId[index] != 0) then
        call ClearItemRespawnIndex(respawnItemHandleId[index])
    endif
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    call TimerStart(respawnItemTimer[index], respawnItemTimeout[index], false, function TimerFunctionRespawnItem)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local integer index = GetItemRespawnIndexByHandleID(GetHandleId(GetTriggerWidget()))
    call StartItemRespawn(index)
endfunction

private function RefreshDeathTrigger takes integer index returns nothing
    if (respawnItemDeathTrigger[index] != null) then
        call DestroyTrigger(respawnItemDeathTrigger[index])
        set respawnItemDeathTrigger[index] = null
    endif

    set respawnItemDeathTrigger[index] = CreateTrigger()
    call TriggerRegisterDeathEvent(respawnItemDeathTrigger[index], respawnItemItem[index])
    call TriggerAddAction(respawnItemDeathTrigger[index], function TriggerActionDeath)
endfunction

private function RefreshDeathTriggerEvaluate takes nothing returns boolean
    call RefreshDeathTrigger(evaluateIndex)
    return false
endfunction

private function AddRespawnItemDefault takes integer index, real x, real y returns nothing
    set respawnItemIsValid[index] = true
    set respawnItemX[index] = x
    set respawnItemY[index] = y
    set respawnItemTimer[index] = CreateTimer()
    set respawnItemTimeout[index] = DEFAULT_TIMEOUT
    call SaveInteger(respawnItemHashTable, GetHandleId(respawnItemTimer[index]), 0, index)
    set respawnItemEnabled[index] = true
    call RefreshDeathTrigger(index)

    loop
        set respawnItemFreeIndex = respawnItemFreeIndex + 1
        exitwhen (not IsRespawnItemValid(respawnItemFreeIndex))
    endloop

    if (index >= respawnItemCounter) then
        set respawnItemCounter = index + 1
    endif
endfunction

function AddRespawnItem takes item whichItem returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_ITEM
    set respawnItemItem[index] = whichItem
    set respawnItemHandleId[index] = GetHandleId(whichItem)
    set respawnItemItemTypeId[index] = GetItemTypeId(whichItem)
    set respawnItemPool[index] = null
    call AddRespawnItemDefault(index, GetItemX(whichItem), GetItemY(whichItem))

    call SaveInteger(respawnItemHashTable, respawnItemHandleId[index], 0, index)

    return index
endfunction

function AddRespawnItemPool takes itempool whichItemPool, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_ITEMPOOL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = whichItemPool
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandom takes integer level, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_RANDOM_LEVEL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = null
    set respawnItemRandomLevel[index] = level
    set respawnItemRandomType[index] = null
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function AddRespawnItemRandomEx takes itemtype whichType, integer level, real x, real y returns integer
    local integer index = respawnItemFreeIndex
    set respawnItemType[index] = ITEM_RESPAWN_TYPE_RANDOM_TYPE_AND_LEVEL
    set respawnItemItem[index] = null
    set respawnItemHandleId[index] = 0
    set respawnItemItemTypeId[index] = 0
    set respawnItemPool[index] = null
    set respawnItemRandomLevel[index] = level
    set respawnItemRandomType[index] = whichType
    call AddRespawnItemDefault(index, x, y)

    call RespawnItem(index)

    return index
endfunction

function RemoveRespawnItem takes integer index returns boolean
    if (IsRespawnItemValid(index)) then
        set respawnItemIsValid[index] = false

        if (respawnItemItem[index] != null) then
            call ClearItemRespawnIndex(GetHandleId(respawnItemItem[index]))
        endif

        set respawnItemTimeout[index] = 0
        set respawnItemType[index] = 0
        set respawnItemItem[index] = null
        set respawnItemHandleId[index] = 0
        set respawnItemItemTypeId[index] = 0
        set respawnItemPool[index] = null
        set respawnItemRandomLevel[index] = 0
        set respawnItemRandomType[index] = null

        call PauseTimer(respawnItemTimer[index])
        call FlushChildHashtable(respawnItemHashTable, GetHandleId(respawnItemTimer[index]))
        call DestroyTimer(respawnItemTimer[index])

        set respawnItemFreeIndex = index

        if (index == respawnItemCounter - 1) then
            set respawnItemCounter = respawnItemCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnItemEnabled takes integer index, boolean enabled returns nothing
    set respawnItemEnabled[index] = enabled
endfunction

function IsRespawnItemEnabled takes integer index returns boolean
    return respawnItemEnabled[index]
endfunction

function GetRespawnItemTimer takes integer index returns timer
    return respawnItemTimer[index]
endfunction

function GetRespawnItemType takes integer index returns integer
    return respawnItemType[index]
endfunction

function SetRespawnItemTimeout takes integer index, real timeout returns nothing
    set respawnItemTimeout[index] = timeout
endfunction

function GetRespawnItemTimeout takes integer index returns real
    return respawnItemTimeout[index]
endfunction

function SetRespawnItemX takes integer index, real x returns nothing
    set respawnItemX[index] = x
endfunction

function GetRespawnItemX takes integer index returns real
    return respawnItemX[index]
endfunction

function SetRespawnItemY takes integer index, real y returns nothing
    set respawnItemX[index] = y
endfunction

function GetRespawnItemY takes integer index returns real
    return respawnItemY[index]
endfunction

function SetRespawnItem takes integer index, item whichItem returns nothing
    set respawnItemItem[index] = whichItem
endfunction

function GetRespawnItem takes integer index returns item
    return respawnItemItem[index]
endfunction

function SetRespawnItemPool takes integer index, itempool whichItemPool returns nothing
    set respawnItemPool[index] = whichItemPool
endfunction

function GetRespawnItemPool takes integer index returns itempool
    return respawnItemPool[index]
endfunction

function SetRespawnItemLevel takes integer index, integer level returns nothing
    set respawnItemRandomLevel[index] = level
endfunction

function GetRespawnItemLevel takes integer index returns integer
    return respawnItemRandomLevel[index]
endfunction

function SetRespawnItemItemType takes integer index, itemtype whichItemType returns nothing
    set respawnItemRandomType[index] = whichItemType
endfunction

function GetRespawnItemItemType takes integer index returns itemtype
    return respawnItemRandomType[index]
endfunction

private function TriggerConditionRespawnItem takes nothing returns boolean
    local integer index = GetItemRespawnIndex(GetManipulatedItem())
    return IsRespawnItemValid(index) and IsRespawnItemEnabled(index)
endfunction

private function TriggerActionRespawnItem takes nothing returns nothing
    local integer index = GetItemRespawnIndex(GetManipulatedItem())
    call StartItemRespawn(index)
endfunction

private function AddEnumItem takes nothing returns nothing
    call AddRespawnItem(GetEnumItem())
endfunction

private module Init

    private static method onInit takes nothing returns nothing
        call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionRespawnItem))
        call TriggerAddAction(pickupItemTrigger, function TriggerActionRespawnItem)

        call TriggerAddCondition(refreshEvaluateTrigger, Condition(function RefreshDeathTriggerEvaluate))

        static if (AUTO_ADD_ALL_PREPLACED_ITEMS) then
            call EnumItemsInRect(GetPlayableMapRect(), null, function AddEnumItem)
        endif
    endmethod
endmodule

private struct S
    implement Init
endstruct

private function RemoveItemCleanup takes item whichItem returns nothing
    local integer handleID = GetHandleId(whichItem)
    call ClearItemRespawnIndex(handleID)
endfunction

hook RemoveItem RemoveItemCleanup


// Change Log:
//
// 1.1 2022-07-30:
// - Move system initializer into module to give it the highest priority possible.
// - Store item respawn index per item in a hashtable to improve the performance.
// - Add constant AUTO_ADD_ALL_PREPLACED_ITEMS which is true by default to automatically add all preplaced items.
// - Support item respawns from item pools, levels and types.
// - Support removing item respawns.
// - Support registering callbacks for respawn start events.
// - Add functions AddRespawnItemPool, AddRespawnItemRandom and AddRespawnItemRandomEx, RemoveRespawnItem, IsRespawnItemValid, TriggerRegisterItemRespawnStartsEvent and many setters and getters.
// - Add constants for the different types.
endlibrary

// Baradé's Unit Group Respawn System 1.1
//
// Allows dying or charmed units from a group or individually to respawn after some time.
// Respawning groups are automatically determined by default from preplaced creeps next to each other owned by player neutral aggressive.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Place some creeps on the map.
//
// You can change the default configuration by changing the code in the library UnitGroupRespawnSystemConfig.
//
// Design:
//
// The unit variables of the respawns are set to null as soon as the respawn starts, not when the unit dies/changes the owner.
// This is done on purpose, so the callbacks can still access the units by index etc.
// The system does not use vJass structs but simple JASS arrays. This allows you to go through all indices and check an index is used or not.
// The system would require some kind of global list if vJass structs were used whenever you want to get all existing instances.
// The limitation of maximum instances is the maximum array size possible in Warcraft III JASS_MAX_ARRAY_SIZE.
// Even with vJass structs you would have to specify a higher limit manually.
// The system is designed to provide a simple JASS API similar to the JASS functions provided by Blizzard.
// The callbacks work like regular trigger events.
//
// API:
//
// function TriggerRegisterUnitRespawnEvent takes trigger whichTrigger returns nothing
//
// Registers an unit respawn event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any unit is respawned by this system. You can access the triggering respawning unit
// and index from the system via functions.
//
// function TriggerRegisterUnitRespawnStartsEvent takes trigger whichTrigger returns nothing
//
// Registers an unit respawn start event for the specified trigger. This means that the trigger is evaluated and executed if
// the condition is true whenever any unit respawn timer is started by this system. You can access the previously killed or charmed unit
// and index from the system via functions.
//
// function GetTriggerRespawnUnit takes nothing returns unit
//
// Returns the triggering respawned unit from a trigger which was evaluated or executed due to a respawn event.
// Returns the triggering killed or charmed previously respawned unit if the event is a respawn starts event.
//
// function GetTriggerRespawnUnitIndex takes nothing returns integer
//
// Returns the corresponding index of the unit respawn from the respawned unit or unit for which the respawn timer has been started of the
// evaluated or executed trigger.
//
// function PreventUnitRespawn takes unit whichUnit returns nothing
//
// Can be called in a trigger which is executed on the respawn event to prevent the actual respawn. It removes the respawned unit. The respawn has to be started manually.
//
// function GetUnitRespawnUnitIndex takes unit whichUnit returns integer
//
// Returns the corresponding index of the unit respawn matching the passed unit. If there is none, it returns -1.
//
// function GetUnitRespawnGroupIndex takes unit whichUnit returns integer
//
// function GetRespawnUnitCounter takes nothing returns integer
//
// Returns the maximum number of item respawn indices. Note that not every index in between has to be valid. This function might help integer
// loops to go through all existing item respawns. Please use IsRespawnItemValid to check if an index in between 0 and the return value of
// this function is actually used.
//
// function IsRespawnUnitValid takes integer index returns boolean
//
// Returns if the given index belongs to a valid respawn unit or not.
//
// function IsRespawnUnitGroupValid takes integer index returns boolean
//
// Returns if the given index belongs to a valid respawn unit group or not.
//
// function RespawnUnit takes integer index returns boolean
//
// Immediately respawns the unit of the respawn unit with the given index.
//
// function RespawnAllUnits takes nothing returns nothing
//
// Immediately respawns all units from all respawn units.
//
// function StartUnitRespawn takes integer index returns nothing
//
// function StartAllUnitRespawnsNotRunning takes nothing returns nothing
//
// function AddRespawnUnit takes unit whichUnit returns integer
//
// function AddRespawnUnitPool takes unitpool whichUnitPool, real x, real y returns integer
//
// function AddRespawnUnitRandomCreep takes integer level, real x, real y returns integer
//
// function RemoveRespawnUnit takes integer index returns boolean
//
// function SetRespawnUnitEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnUnitEnabled takes integer index returns boolean
//
// function GetRespawnUnitTimer takes integer index returns timer
//
// function GetRespawnUnitType takes integer index returns integer
//
// function SetRespawnUnitTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnUnitTimeout takes integer index returns real
//
// function SetRespawnUnitOwner takes integer index, player owner returns nothing
//
// function GetRespawnUnitOwner takes integer index returns player
//
// function SetRespawnUnitFacing takes integer index, real facing returns nothing
//
// function GetRespawnUnitFacing takes integer index returns real
//
// function SetRespawnUnitX takes integer index, real x returns nothing
//
// function GetRespawnUnitX takes integer index returns real
//
// function SetRespawnUnitY takes integer index, real y returns nothing
//
// function GetRespawnUnitY takes integer index returns real
//
// function SetRespawnUnitUseDyingLoc takes integer index, boolean use returns nothing
//
// function GetRespawnUnitUseDyingLoc takes integer index returns boolean
//
// function SetRespawnUnit takes integer index, unit whichUnit returns nothing
//
// function GetRespawnUnit takes integer index returns unit
//
// function SetRespawnUnitPool takes integer index, unitpool whichUnitPool returns nothing
//
// function GetRespawnUnitPool takes integer index returns unitpool
//
// function SetRespawnUnitLevel takes integer index, integer level returns nothing
//
// function GetRespawnUnitLevel takes integer index returns integer
//
// function GetRespawnUnitGroupCounter takes nothing returns integer
//
// function SetRespawnUnitGroupIndex takes integer index, integer groupIndex returns nothing
//
// function GetRespawnUnitGroupIndex takes integer index returns integer
//
// function AddRespawnUnitGroup takes nothing returns integer
//
// function AddRespawnUnitGroupFromUnit takes unit whichUnit returns integer
//
// function AddRespawnUnitGroupFromUnitPool takes unitpool whichUnitPool, integer countMembers, real x, real y, real range returns integer
//
// function AddRespawnUnitGroupFromRandomCreepLevel takes integer minCreepLevel, integer maxCreepLevel, integer countMembers, real x, real y, real range returns integer
//
// function RemoveRespawnUnitGroup takes integer index returns boolean
//
// function SetRespawnUnitGroupTimeout takes integer index, real timeout returns nothing
//
// function GetRespawnUnitGroupTimeout takes integer index returns real
//
// function SetRespawnUnitGroupEnabled takes integer index, boolean enabled returns nothing
//
// function IsRespawnUnitGroupEnabled takes integer index returns boolean
//
// function GetRespawnUnitGroupUnits takes integer index returns group
//
// function RespawnUnitGroup takes integer index returns boolean
//
// function StartUnitGroupRespawn takes integer index returns nothing
//
library UnitGroupRespawnSystemConfig

    globals
        // The default delay until a unit will be respawned.
        public constant real DEFAULT_TIMEOUT = 90.0
        // All preplaced units owned by the CREEPS_OWNER player on the map will automatically respawn if this value is true. Otherwise, you will have to add them manually.
        public constant boolean AUTO_ADD_ALL_PREPLACED_CREEPS = true
        // Creates unit group respawns from preplaced creeps next to each other if this value is true. Otherwise, it will create separate unit respawns per creep.
        public constant boolean AUTO_ADDED_GROUPS = true
        // Defines the maximum distance between preplaced creep units to belong to the same respawn group if AUTO_ADDED_GROUPS is true.
        public constant real AUTO_ADDED_GROUP_MAX_DISTANCE = 800.0
        // All players who preplaced units are added as respawning groups for.
        public constant force AUTO_ADDED_GROUP_PLAYERS = CreateForce()
        // All auto added unit respawns and respawn groups will drop random items when the whole group has been killed or charmed when this value is true. The level of the dropped item will be the maximum unit level of the group.
        // Make sure that all item types have set the field "Stats - Include As Random Choice" to the correct value in the object editor.
        public constant boolean AUTO_ADDED_DROP_RANDOM_ITEMS = true
        // Determines a unit's level by its unit type rather than the actual unit. This helps to get a lower level if the unit levels are changed manually during the game.
        public constant boolean GET_UNIT_LEVEL_BY_TYPE = true
        // Shows the eyecandy on respawning hero revivals if set to true. Otherwise, the effect is not shown.
        public constant boolean HERO_RESPAWN_DO_EYECANDY = true
        // Avoids permanent removal if too many heroes from the same player died.
        public constant boolean SET_MAX_DEATH_TIME_TO_UNITS = true
    endglobals

static if (AUTO_ADD_ALL_PREPLACED_CREEPS) then
    private function IsUnitLivingNonStructure takes nothing returns boolean
        return IsUnitAliveBJ(GetFilterUnit()) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
    endfunction

    // Redefine this function to add different preplaced creeps.
    public function AddAllUserSpecifiedPreplacedCreeps takes group allCreeps returns nothing
        call GroupEnumUnitsOfPlayer(allCreeps, Player(PLAYER_NEUTRAL_AGGRESSIVE), Filter(function IsUnitLivingNonStructure))
        call GroupEnumUnitsOfPlayer(allCreeps, udg_BossesPlayer, Filter(function IsUnitLivingNonStructure))
    endfunction

    private module Init

        private static method onInit takes nothing returns nothing
            call ForceAddPlayer(AUTO_ADDED_GROUP_PLAYERS, Player(PLAYER_NEUTRAL_AGGRESSIVE))
            call ForceAddPlayer(AUTO_ADDED_GROUP_PLAYERS, udg_BossesPlayer)
        endmethod
    endmodule

    private struct S
        implement Init
    endstruct
endif

endlibrary

library UnitGroupRespawnSystem requires UnitGroupRespawnSystemConfig

globals
    constant integer UNIT_RESPAWN_TYPE_UNIT = 0
    constant integer UNIT_RESPAWN_TYPE_UNITPOOL = 1
    constant integer UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL = 2

    private integer respawnUnitCounter = 0
    private integer respawnUnitFreeIndex = 0
    private boolean array respawnUnitIsValid
    private integer array respawnUnitType
    private unit array respawnUnitUnit
    private integer array respawnUnitHandleId
    private integer array respawnUnitUnitTypeId
    private unitpool array respawnUnitPool
    private integer array respawnUnitRandomCreepLevel
    private player array respawnUnitOwner
    private real array respawnUnitFacing
    private real array respawnUnitX
    private real array respawnUnitY
    private boolean array respawnUnitUseDyingLoc
    private timer array respawnUnitTimer
    private real array respawnUnitTimeout
    private boolean array respawnUnitEnabled
    private integer array respawnUnitGroupIndex
    private boolean array respawnUnitReadyForRespawn

    private integer callbackRespawnTriggersCounter = 0
    private trigger array callbackRespawnTriggers

    private integer callbackRespawnStartsTriggersCounter = 0
    private trigger array callbackRespawnStartsTriggers

    private unit callbackUnit = null
    private integer callbackIndex = -1

    private integer respawnUnitGroupCounter = 0
    private integer respawnUnitGroupFreeIndex = 0
    private boolean array respawnUnitGroupIsValid
    private group array respawnUnitGroup
    private timer array respawnUnitGroupTimer
    private real array respawnUnitGroupTimeout
    private boolean array respawnUnitGroupEnabled

    private trigger unitDeathOrCharmTrigger = CreateTrigger()
    private hashtable respawnUnitHashTable = InitHashtable()

    private unit filterUnit = null
    private player filterOwner = null
endglobals

function GetTriggerRespawnUnit takes nothing returns unit
    return callbackUnit
endfunction

function GetTriggerRespawnUnitIndex takes nothing returns integer
    return callbackIndex
endfunction

function TriggerRegisterUnitRespawnEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnTriggersCounter
    set callbackRespawnTriggers[index] = whichTrigger
    set callbackRespawnTriggersCounter = callbackRespawnTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnTriggersCounter)
        set callbackUnit = respawnUnitUnit[index]
        set callbackIndex = index
        call ConditionalTriggerExecute(callbackRespawnTriggers[i])
        set i = i + 1
    endloop
endfunction

function TriggerRegisterUnitRespawnStartsEvent takes trigger whichTrigger returns nothing
    local integer index = callbackRespawnStartsTriggersCounter
    set callbackRespawnStartsTriggers[index] = whichTrigger
    set callbackRespawnStartsTriggersCounter = callbackRespawnStartsTriggersCounter + 1
endfunction

private function EvaluateAndExecuteCallbackRespawnStartsTriggers takes integer index returns nothing
    local integer i = 0
    loop
        exitwhen (i >= callbackRespawnStartsTriggersCounter)
        set callbackUnit = respawnUnitUnit[index]
        set callbackIndex = index
        call ConditionalTriggerExecute(callbackRespawnStartsTriggers[i])
        set i = i + 1
    endloop
endfunction

private function ClearRespawnUnitIndex takes integer handleID returns nothing
    if (HaveSavedInteger(respawnUnitHashTable, handleID, 0)) then
        call FlushChildHashtable(respawnUnitHashTable, handleID)
    endif
endfunction

private function GetRespawnUnitIndexByHandleID takes integer handleID returns integer
    if (HaveSavedInteger(respawnUnitHashTable, handleID, 0)) then
        return LoadInteger(respawnUnitHashTable, handleID, 0)
    endif

    return -1
endfunction

private function GetUnitRespawnGroupIndexByHandleID takes integer handleID returns integer
    if (HaveSavedInteger(respawnUnitHashTable, handleID, 1)) then
        return LoadInteger(respawnUnitHashTable, handleID, 1)
    endif

    return -1
endfunction

function GetUnitRespawnUnitIndex takes unit whichUnit returns integer
    return GetRespawnUnitIndexByHandleID(GetHandleId(whichUnit))
endfunction

function GetUnitRespawnGroupIndex takes unit whichUnit returns integer
    return GetUnitRespawnGroupIndexByHandleID(GetHandleId(whichUnit))
endfunction

function GetRespawnUnitCounter takes nothing returns integer
    return respawnUnitCounter
endfunction

function IsRespawnUnitValid takes integer index returns boolean
    if (index < 0) then
        return false
    endif
    return respawnUnitIsValid[index]
endfunction

function IsRespawnUnitGroupValid takes integer index returns boolean
    if (index < 0) then
        return false
    endif
    return respawnUnitGroupIsValid[index]
endfunction

function RespawnUnit takes integer index returns boolean
    local boolean add = false
    local integer groupIndex = respawnUnitGroupIndex[index]
    if (not IsRespawnUnitValid(index)) then
        return false
    endif
    if (respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNIT) then
        if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO) and respawnUnitUnit[index] != null) then
            call ReviveHero(respawnUnitUnit[index], respawnUnitX[index], respawnUnitY[index], UnitGroupRespawnSystemConfig_HERO_RESPAWN_DO_EYECANDY)
        else
            set respawnUnitUnit[index] = CreateUnit(respawnUnitOwner[index], respawnUnitUnitTypeId[index], respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
            set add = true
        endif
    elseif (respawnUnitType[index] == UNIT_RESPAWN_TYPE_UNITPOOL) then
        set respawnUnitUnit[index] = PlaceRandomUnit(respawnUnitPool[index], respawnUnitOwner[index], respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
        set add = true
    elseif (respawnUnitType[index] == UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL) then
        set respawnUnitUnit[index] = CreateUnit(respawnUnitOwner[index], ChooseRandomCreep(respawnUnitRandomCreepLevel[index]), respawnUnitX[index], respawnUnitY[index], respawnUnitFacing[index])
        set add = true
    endif
    set respawnUnitReadyForRespawn[index] = false
static if (UnitGroupRespawnSystemConfig_SET_MAX_DEATH_TIME_TO_UNITS) then
    if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
        call BlzSetUnitRealField(respawnUnitUnit[index], UNIT_RF_DEATH_TIME, 99999999.0)
    endif
endif
    set respawnUnitHandleId[index] = GetHandleId(respawnUnitUnit[index])
    call SaveInteger(respawnUnitHashTable, respawnUnitHandleId[index], 0, index)

    if (add and IsRespawnUnitGroupValid(groupIndex)) then
        call GroupAddUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
    endif

    call EvaluateAndExecuteCallbackRespawnTriggers(index)
    return true
endfunction

function RespawnAllUnits takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and respawnUnitUnit[i] == null) then
            call RespawnUnit(i)
        endif
        set i = i + 1
    endloop
endfunction

function PreventUnitRespawn takes unit whichUnit returns nothing
    local integer index = GetUnitRespawnUnitIndex(whichUnit)
    if (IsRespawnUnitValid(index)) then
        if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
            call KillUnit(whichUnit)
        else
            call ClearRespawnUnitIndex(respawnUnitHandleId[index])
            set respawnUnitHandleId[index] = 0
            call RemoveUnit(whichUnit)
            set whichUnit = null
        endif
    endif
endfunction

private function TimerFunctionRespawnUnit takes nothing returns nothing
    local integer index = LoadInteger(respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnit(index)
endfunction

function StartUnitRespawn takes integer index returns nothing
    call EvaluateAndExecuteCallbackRespawnStartsTriggers(index)

    if (respawnUnitHandleId[index] != 0) then
        call ClearRespawnUnitIndex(respawnUnitHandleId[index])
    endif
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0
    call TimerStart(respawnUnitTimer[index], respawnUnitTimeout[index], false, function TimerFunctionRespawnUnit)
    set respawnUnitReadyForRespawn[index] = false
endfunction

function StartAllUnitRespawnsNotRunning takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and respawnUnitUnit[i] == null and TimerGetElapsed(respawnUnitTimer[i]) <= 0.0) then
            call StartUnitRespawn(i)
        endif
        set i = i + 1
    endloop
endfunction

private function AddRespawnUnitDefault takes integer index, real x, real y returns nothing
    set respawnUnitIsValid[index] = true
    set respawnUnitX[index] = x
    set respawnUnitY[index] = y
    set respawnUnitFacing[index] = GetRandomDirectionDeg()
    set respawnUnitUseDyingLoc[index] = false
    set respawnUnitOwner[index] = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    set respawnUnitTimer[index] = CreateTimer()
    set respawnUnitTimeout[index] = UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(respawnUnitHashTable, GetHandleId(respawnUnitTimer[index]), 0, index)
    set respawnUnitEnabled[index] = true
    set respawnUnitGroupIndex[index] = -1
    set respawnUnitReadyForRespawn[index] = true

    loop
        set respawnUnitFreeIndex = respawnUnitFreeIndex + 1
        exitwhen (not IsRespawnUnitValid(respawnUnitFreeIndex))
    endloop

    if (respawnUnitFreeIndex >= JASS_MAX_ARRAY_SIZE) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(respawnUnitFreeIndex))
    endif

    if (index >= respawnUnitCounter) then
        set respawnUnitCounter = index + 1
    endif
endfunction

function AddRespawnUnit takes unit whichUnit returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_UNIT
    set respawnUnitUnit[index] = whichUnit
static if (UnitGroupRespawnSystemConfig_SET_MAX_DEATH_TIME_TO_UNITS) then
    if (IsUnitType(respawnUnitUnit[index], UNIT_TYPE_HERO)) then
        call BlzSetUnitRealField(respawnUnitUnit[index], UNIT_RF_DEATH_TIME, 99999999.0)
    endif
endif
    set respawnUnitHandleId[index] = GetHandleId(whichUnit)
    set respawnUnitUnitTypeId[index] = GetUnitTypeId(whichUnit)
    set respawnUnitPool[index] = null
    call AddRespawnUnitDefault(index, GetUnitX(whichUnit), GetUnitY(whichUnit))
    set respawnUnitFacing[index] = GetUnitFacing(whichUnit)
    set respawnUnitOwner[index] = GetOwningPlayer(whichUnit)
    set respawnUnitReadyForRespawn[index] = false

    call SaveInteger(respawnUnitHashTable, respawnUnitHandleId[index], 0, index)

    return index
endfunction

function AddRespawnUnitPool takes unitpool whichUnitPool, real x, real y returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_UNITPOOL
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0
    set respawnUnitUnitTypeId[index] = 0
    set respawnUnitPool[index] = whichUnitPool
    call AddRespawnUnitDefault(index, x, y)

    call RespawnUnit(index)

    return index
endfunction

function AddRespawnUnitRandomCreep takes integer level, real x, real y returns integer
    local integer index = respawnUnitFreeIndex
    set respawnUnitType[index] = UNIT_RESPAWN_TYPE_RANDOM_CREEP_LEVEL
    set respawnUnitUnit[index] = null
    set respawnUnitHandleId[index] = 0
    set respawnUnitUnitTypeId[index] = 0
    set respawnUnitPool[index] = null
    set respawnUnitRandomCreepLevel[index] = level
    call AddRespawnUnitDefault(index, x, y)

    call RespawnUnit(index)

    return index
endfunction

function RemoveRespawnUnit takes integer index returns boolean
    if (IsRespawnUnitValid(index)) then
        set respawnUnitIsValid[index] = false

        if (respawnUnitUnit[index] != null) then
            call ClearRespawnUnitIndex(GetHandleId(respawnUnitUnit[index]))
        endif

        set respawnUnitTimeout[index] = 0
        set respawnUnitType[index] = 0
        set respawnUnitUnit[index] = null
        set respawnUnitHandleId[index] = 0
        set respawnUnitUnitTypeId[index] = 0
        set respawnUnitPool[index] = null
        set respawnUnitRandomCreepLevel[index] = 0
        set respawnUnitUseDyingLoc[index] = false

        call PauseTimer(respawnUnitTimer[index])
        call FlushChildHashtable(respawnUnitHashTable, GetHandleId(respawnUnitTimer[index]))
        call DestroyTimer(respawnUnitTimer[index])

        set respawnUnitFreeIndex = index

        if (index == respawnUnitCounter - 1) then
            set respawnUnitCounter = respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitEnabled takes integer index, boolean enabled returns nothing
    set respawnUnitEnabled[index] = enabled
endfunction

function IsRespawnUnitEnabled takes integer index returns boolean
    return respawnUnitEnabled[index]
endfunction

function GetRespawnUnitTimer takes integer index returns timer
    return respawnUnitTimer[index]
endfunction

function GetRespawnUnitType takes integer index returns integer
    return respawnUnitType[index]
endfunction

function SetRespawnUnitTimeout takes integer index, real timeout returns nothing
    set respawnUnitTimeout[index] = timeout
endfunction

function GetRespawnUnitTimeout takes integer index returns real
    return respawnUnitTimeout[index]
endfunction

function SetRespawnUnitOwner takes integer index, player owner returns nothing
    set respawnUnitOwner[index] = owner
endfunction

function GetRespawnUnitOwner takes integer index returns player
    return respawnUnitOwner[index]
endfunction
function SetRespawnUnitFacing takes integer index, real facing returns nothing
    set respawnUnitFacing[index] = facing
endfunction

function GetRespawnUnitFacing takes integer index returns real
    return respawnUnitFacing[index]
endfunction

function SetRespawnUnitX takes integer index, real x returns nothing
    set respawnUnitX[index] = x
endfunction

function GetRespawnUnitX takes integer index returns real
    return respawnUnitX[index]
endfunction

function SetRespawnUnitY takes integer index, real y returns nothing
    set respawnUnitX[index] = y
endfunction

function GetRespawnUnitY takes integer index returns real
    return respawnUnitY[index]
endfunction

function SetRespawnUnitUseDyingLoc takes integer index, boolean use returns nothing
    set respawnUnitUseDyingLoc[index] = use
endfunction

function GetRespawnUnitUseDyingLoc takes integer index returns boolean
    return respawnUnitUseDyingLoc[index]
endfunction

function SetRespawnUnit takes integer index, unit whichUnit returns nothing
    local integer groupIndex = respawnUnitGroupIndex[index]
    local boolean validRespawnUnitGroup = IsRespawnUnitGroupValid(groupIndex)
    local integer handleId = GetHandleId(whichUnit)
    if (respawnUnitUnit[index] != null) then
        if (validRespawnUnitGroup) then
            call GroupRemoveUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
        endif

        call ClearRespawnUnitIndex(GetHandleId(respawnUnitUnit[index]))
    endif
    set respawnUnitUnit[index] = whichUnit
    set respawnUnitHandleId[index] = handleId
    set respawnUnitType[index] = GetUnitTypeId(whichUnit)
    call SaveInteger(respawnUnitHashTable, handleId, 0, index)
    set respawnUnitReadyForRespawn[index] = false
    if (validRespawnUnitGroup) then
        call GroupAddUnit(respawnUnitGroup[groupIndex], whichUnit)
    endif
endfunction

function GetRespawnUnit takes integer index returns unit
    return respawnUnitUnit[index]
endfunction

function SetRespawnUnitPool takes integer index, unitpool whichUnitPool returns nothing
    set respawnUnitPool[index] = whichUnitPool
endfunction

function GetRespawnUnitPool takes integer index returns unitpool
    return respawnUnitPool[index]
endfunction

function SetRespawnUnitLevel takes integer index, integer level returns nothing
    set respawnUnitRandomCreepLevel[index] = level
endfunction

function GetRespawnUnitLevel takes integer index returns integer
    return respawnUnitRandomCreepLevel[index]
endfunction

function GetRespawnUnitGroupCounter takes nothing returns integer
    return respawnUnitGroupCounter
endfunction

function SetRespawnUnitGroupIndex takes integer index, integer groupIndex returns nothing
    if (IsRespawnUnitGroupValid(groupIndex)) then
        if (IsRespawnUnitGroupValid(respawnUnitGroupIndex[index]) and respawnUnitUnit[index] != null) then
            call GroupRemoveUnit(respawnUnitGroup[respawnUnitGroupIndex[index]], respawnUnitUnit[index])
        endif
        set respawnUnitGroupIndex[index] = groupIndex
        call GroupAddUnit(respawnUnitGroup[groupIndex], respawnUnitUnit[index])
    endif
endfunction

function GetRespawnUnitGroupIndex takes integer index returns integer
    return respawnUnitGroupIndex[index]
endfunction

function AddRespawnUnitGroup takes nothing returns integer
    local integer index = respawnUnitGroupFreeIndex
    set respawnUnitGroupIsValid[index] = true
    set respawnUnitGroup[index] = CreateGroup()
    set respawnUnitGroupTimer[index] = CreateTimer()
    set respawnUnitGroupTimeout[index] = UnitGroupRespawnSystemConfig_DEFAULT_TIMEOUT
    call SaveInteger(respawnUnitHashTable, GetHandleId(respawnUnitGroupTimer[index]), 0, index)
    set respawnUnitGroupEnabled[index] = true

    loop
        set respawnUnitGroupFreeIndex = respawnUnitGroupFreeIndex + 1
        exitwhen (not IsRespawnUnitGroupValid(respawnUnitGroupFreeIndex))
    endloop

    if (respawnUnitGroupFreeIndex >= JASS_MAX_ARRAY_SIZE) then
        call BJDebugMsg("Warning: Reached Warcraft maximum array size for respawn units: " + I2S(respawnUnitGroupFreeIndex))
    endif

    if (index >= respawnUnitGroupCounter) then
        set respawnUnitGroupCounter = index + 1
    endif

    return index
endfunction

private function IsLivingUnitWithRespawn takes nothing returns boolean
    local unit currentUnit = GetFilterUnit()
    local player currentOwner = GetOwningPlayer(filterUnit)
    local integer respawnUnitIndex = GetUnitRespawnUnitIndex(currentUnit)
    local boolean result = currentUnit != filterUnit and IsUnitAliveBJ(currentUnit) and not IsUnitType(currentUnit, UNIT_TYPE_STRUCTURE) and (currentOwner == filterOwner or IsPlayerInForce(currentOwner, UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_PLAYERS)) and IsRespawnUnitValid(respawnUnitIndex) and IsRespawnUnitGroupValid(GetRespawnUnitGroupIndex(respawnUnitIndex))
    set currentUnit = null
    set currentOwner = null
    return result
endfunction

function AddRespawnUnitGroupFromUnit takes unit whichUnit returns integer
    local group allNearbyUnitsFromTheSameOwner = CreateGroup()
    local unit first = null
    local integer groupIndex = -1
    local integer index = -1
    set filterUnit = whichUnit
    set filterOwner = GetOwningPlayer(whichUnit)
    call GroupEnumUnitsInRange(allNearbyUnitsFromTheSameOwner, GetUnitX(whichUnit), GetUnitY(whichUnit), UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUP_MAX_DISTANCE, Filter(function IsLivingUnitWithRespawn))
    set filterUnit = null
    set filterOwner = null
    set first = FirstOfGroup(allNearbyUnitsFromTheSameOwner)
    call GroupClear(allNearbyUnitsFromTheSameOwner)
    call DestroyGroup(allNearbyUnitsFromTheSameOwner)
    set allNearbyUnitsFromTheSameOwner = null
    if (first != null) then
        set groupIndex = GetRespawnUnitGroupIndex(GetUnitRespawnUnitIndex(first))
        set first = null
    else
        set groupIndex = AddRespawnUnitGroup()
    endif
    set index = AddRespawnUnit(whichUnit)
    call SetRespawnUnitGroupIndex(index, groupIndex)
    return groupIndex
endfunction

private function PolarProjectionX takes real x, real dist, real angle returns real
    return x + dist * Cos(angle * bj_DEGTORAD)
endfunction

private function PolarProjectionY takes real y, real dist, real angle returns real
    return y + dist * Sin(angle * bj_DEGTORAD)
endfunction

private function GetRandomLocInRange takes real x, real y, real range returns location
    local real dist = GetRandomReal(0.0, range)
    local real angle = GetRandomDirectionDeg()
    return Location(PolarProjectionX(x, dist, angle), PolarProjectionY(y, dist, angle))
endfunction

function AddRespawnUnitGroupFromUnitPool takes unitpool whichUnitPool, integer countMembers, real x, real y, real range returns integer
    local integer groupIndex = AddRespawnUnitGroup()
    local location whichLocation = null
    local integer i = 0
    loop
        exitwhen (i >= countMembers)
        set whichLocation = GetRandomLocInRange(x, y, range)
        call SetRespawnUnitGroupIndex(AddRespawnUnitPool(whichUnitPool, GetLocationY(whichLocation), GetLocationY(whichLocation)), groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation = null
        set i = i + 1
    endloop
    return groupIndex
endfunction

function AddRespawnUnitGroupFromRandomCreepLevel takes integer minCreepLevel, integer maxCreepLevel, integer countMembers, real x, real y, real range returns integer
    local integer groupIndex = AddRespawnUnitGroup()
    local location whichLocation = null
    local integer i = 0
    loop
        exitwhen (i >= countMembers)
        set whichLocation = GetRandomLocInRange(x, y, range)
        call SetRespawnUnitGroupIndex(AddRespawnUnitRandomCreep(GetRandomInt(minCreepLevel, maxCreepLevel), GetLocationY(whichLocation), GetLocationY(whichLocation)), groupIndex)
        call RemoveLocation(whichLocation)
        set whichLocation = null
        set i = i + 1
    endloop
    return groupIndex
endfunction

function RemoveRespawnUnitGroup takes integer index returns boolean
    if (IsRespawnUnitValid(index)) then
        set respawnUnitGroupIsValid[index] = false
        set respawnUnitGroupEnabled[index] = false

        if (respawnUnitGroup[index] != null) then
            call GroupClear(respawnUnitGroup[index])
            call DestroyGroup(respawnUnitGroup[index])
            set respawnUnitGroup[index] = null
        endif

        call PauseTimer(respawnUnitGroupTimer[index])
        call FlushChildHashtable(respawnUnitHashTable, GetHandleId(respawnUnitGroupTimer[index]))
        call DestroyTimer(respawnUnitGroupTimer[index])

        set respawnUnitFreeIndex = index

        if (index == respawnUnitCounter - 1) then
            set respawnUnitCounter = respawnUnitCounter - 1
        endif

        return true
    endif

    return false
endfunction

function SetRespawnUnitGroupTimeout takes integer index, real timeout returns nothing
    set respawnUnitGroupTimeout[index] = timeout
endfunction

function GetRespawnUnitGroupTimeout takes integer index returns real
    return respawnUnitGroupTimeout[index]
endfunction

function SetRespawnUnitGroupEnabled takes integer index, boolean enabled returns nothing
    set respawnUnitGroupEnabled[index] = enabled
endfunction

function IsRespawnUnitGroupEnabled takes integer index returns boolean
    return respawnUnitGroupEnabled[index]
endfunction

function GetRespawnUnitGroupUnits takes integer index returns group
    return respawnUnitGroup[index]
endfunction

function RespawnUnitGroup takes integer index returns boolean
    local integer i = 0
    if (not IsRespawnUnitGroupValid(index)) then
        return false
    endif
    // We do not know the members anymore since we have removed them from the group. Hence, we need to find all matching respawns.
    set i = 0
    loop
        exitwhen (i == GetRespawnUnitCounter())
        if (IsRespawnUnitValid(i) and GetRespawnUnitGroupIndex(i) == index) then
            call RespawnUnit(i)
        endif
        set i = i + 1
    endloop

    return true
endfunction

private function TimerFunctionRespawnUnitGroup takes nothing returns nothing
    local integer index = LoadInteger(respawnUnitHashTable, GetHandleId(GetExpiredTimer()), 0)
    call RespawnUnitGroup(index)
endfunction

function StartUnitGroupRespawn takes integer index returns nothing
    local unit member = null
    local integer memberIndex = -1
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(respawnUnitGroup[index]))
        set member = BlzGroupUnitAt(respawnUnitGroup[index], i)
        set memberIndex = GetRespawnUnitIndexByHandleID(GetHandleId(member))
        set respawnUnitReadyForRespawn[memberIndex] = false
        set member = null
        call EvaluateAndExecuteCallbackRespawnStartsTriggers(memberIndex)
        set i = i + 1
    endloop

    // Cleanup since we do not know how long the unit will decay etc.
    set i = 0
    loop
        exitwhen (i == BlzGroupGetSize(respawnUnitGroup[index]))
        set member = BlzGroupUnitAt(respawnUnitGroup[index], i)
        set memberIndex = GetRespawnUnitIndexByHandleID(GetHandleId(member))

        if (not IsUnitType(member, UNIT_TYPE_HERO)) then
            if (respawnUnitHandleId[memberIndex] != 0) then
                call ClearRespawnUnitIndex(respawnUnitHandleId[memberIndex])
            endif
            set respawnUnitUnit[memberIndex] = null
            set respawnUnitHandleId[memberIndex] = 0
        endif

        set member = null
        set i = i + 1
    endloop

    call GroupClear(respawnUnitGroup[index])

    call TimerStart(respawnUnitGroupTimer[index], respawnUnitGroupTimeout[index], false, function TimerFunctionRespawnUnitGroup)
endfunction

private function TriggerConditionRespawnUnit takes nothing returns boolean
    local integer index = GetUnitRespawnUnitIndex(GetTriggerUnit())
    return IsRespawnUnitValid(index) and IsRespawnUnitEnabled(index)
endfunction

static if (UnitGroupRespawnSystemConfig_GET_UNIT_LEVEL_BY_TYPE) then
private function GetUnitLevelByType takes integer unitTypeId returns integer
	local unit dummy = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), unitTypeId, 0.0, 0.0, 0.0)
	local integer result = BlzGetUnitIntegerField(dummy , UNIT_IF_LEVEL)
	call RemoveUnit(dummy)
	set dummy = null
	return result
endfunction
endif

private function GetMaxUnitLevelFromGroup takes group whichGroup returns integer
    local integer maxLevel = 0
    local integer unitLevel = 0
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(whichGroup))
static if (UnitGroupRespawnSystemConfig_GET_UNIT_LEVEL_BY_TYPE) then
        set unitLevel = GetUnitLevelByType(GetUnitTypeId(BlzGroupUnitAt(whichGroup, i)))
else
        set unitLevel = GetUnitLevel(BlzGroupUnitAt(whichGroup, i))
endif
        set maxLevel = IMaxBJ(unitLevel, maxLevel)
        set i = i + 1
    endloop
    return maxLevel
endfunction

private function IsUnitGroupReadyForRespawnEnum takes nothing returns nothing
    local integer index = GetRespawnUnitIndexByHandleID(GetHandleId(GetEnumUnit()))
    if not respawnUnitReadyForRespawn[index]  then
        set bj_isUnitGroupDeadResult = false
    endif
endfunction

private function IsUnitGroupReadyForRespawn takes group g returns boolean
    set bj_isUnitGroupDeadResult = true
    call ForGroup(g, function IsUnitGroupReadyForRespawnEnum)
    return bj_isUnitGroupDeadResult
endfunction

private function TriggerActionRespawnUnit takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local integer index = GetUnitRespawnUnitIndex(triggerUnit)
    local integer groupIndex = GetRespawnUnitGroupIndex(index)

    if (GetRespawnUnitUseDyingLoc(index)) then
        call SetRespawnUnitFacing(index, GetUnitFacing(triggerUnit))
        call SetRespawnUnitX(index, GetUnitX(triggerUnit))
        call SetRespawnUnitY(index, GetUnitY(triggerUnit))
    endif

    set respawnUnitReadyForRespawn[index] = true

    if (IsRespawnUnitGroupValid(groupIndex) and IsRespawnUnitGroupEnabled(groupIndex)) then
        if (IsUnitGroupReadyForRespawn(GetRespawnUnitGroupUnits(groupIndex))) then
static if (UnitGroupRespawnSystemConfig_AUTO_ADDED_DROP_RANDOM_ITEMS) then
            call UnitDropItem(triggerUnit, ChooseRandomItem(GetMaxUnitLevelFromGroup(GetRespawnUnitGroupUnits(groupIndex))))
endif
            call StartUnitGroupRespawn(groupIndex)
        endif
    else
        call StartUnitRespawn(index)
    endif
    set triggerUnit = null
endfunction

private function AddRespawnUnitGroupFromEnumUnit takes nothing returns nothing
static if (UnitGroupRespawnSystemConfig_AUTO_ADDED_GROUPS) then
    call AddRespawnUnitGroupFromUnit(GetEnumUnit())
else
    call AddRespawnUnit(GetEnumUnit())
endif
endfunction

static if (UnitGroupRespawnSystemConfig_AUTO_ADD_ALL_PREPLACED_CREEPS) then
private function AddAllPreplacedCreeps takes nothing returns nothing
    local group allCreeps = CreateGroup()
    call UnitGroupRespawnSystemConfig_AddAllUserSpecifiedPreplacedCreeps(allCreeps)
    call ForGroup(allCreeps, function AddRespawnUnitGroupFromEnumUnit)
    call GroupClear(allCreeps)
    call DestroyGroup(allCreeps)
    set allCreeps = null
endfunction
endif

private module Init

    private static method onInit takes nothing returns nothing
        call TriggerRegisterAnyUnitEventBJ(unitDeathOrCharmTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerRegisterAnyUnitEventBJ(unitDeathOrCharmTrigger, EVENT_PLAYER_UNIT_CHANGE_OWNER)
        call TriggerAddCondition(unitDeathOrCharmTrigger, Condition(function TriggerConditionRespawnUnit))
        call TriggerAddAction(unitDeathOrCharmTrigger, function TriggerActionRespawnUnit)

static if (UnitGroupRespawnSystemConfig_AUTO_ADD_ALL_PREPLACED_CREEPS) then
        call AddAllPreplacedCreeps()
endif
    endmethod
endmodule

private struct S
    implement Init
endstruct

private function RemoveUnitCleanup takes unit whichUnit returns nothing
    local integer handleID = GetHandleId(whichUnit)
    call ClearRespawnUnitIndex(handleID)
endfunction

hook RemoveUnit RemoveUnitCleanup

// ChangeLog:
//
// 1.1:
// - Fix changing the unit type when changing the unit.
// - Improve API documentation.
// - Increase default timeout from 30 to 90 seconds.

endlibrary

// TODO Add System DestructableRespawnSystem with all preplaced boxes etc. dropping random items.

// World of Warcraft Reforged Unit Respawns

function GetRespawnBuildingSize takes nothing returns real
    return 1400.0
endfunction

function GetRespawnGroupOfDestructable takes destructable whichDestructable returns integer
    if (DestructableParameterIntegerExists(whichDestructable, 0)) then
        debug call BJDebugMsg("Destructable " + GetDestructableName(whichDestructable) + " has a group!")
        return LoadDestructableParameterInteger(whichDestructable, 0)
    endif
    debug call BJDebugMsg("Destructable " + GetDestructableName(whichDestructable) + " has no group!")
    return -1
endfunction

function FilterFunctionIsBuilding takes nothing returns boolean
    local unit filterUnit = GetFilterUnit()
    local player owner = GetOwningPlayer(filterUnit)
    local boolean result = IsUnitType(filterUnit, UNIT_TYPE_STRUCTURE) and owner != Player(PLAYER_NEUTRAL_AGGRESSIVE) and owner != Player(PLAYER_NEUTRAL_PASSIVE) and owner != udg_TheBurningLegion
    set owner = null
    set filterUnit = null
    return result
endfunction

function RespawnRectContainsNoBuilding takes location respawnCenter returns boolean
    local group BuildingGroup = GetUnitsInRangeOfLocMatching(GetRespawnBuildingSize(), respawnCenter, Filter(function FilterFunctionIsBuilding))
    set bj_wantDestroyGroup = true
    return IsUnitGroupEmptyBJ(BuildingGroup)
endfunction

function DistanceBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    local real dx = x2 - x1
    local real dy = y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

function RespawnAllGroupsInRange takes real x, real y, real range returns integer
	local integer result = 0
	local integer i = 0
	loop
		exitwhen (i == GetRespawnUnitCounter())
		if (IsRespawnUnitValid(i) and DistanceBetweenCoordinates(x, y, GetRespawnUnitX(i), GetRespawnUnitY(i)) <= range) then
            call RespawnUnit(i)
			set result = result + 1
		endif
		set i = i + 1
	endloop
	return result
endfunction

function RespawnAllItemsInRange takes real x, real y, real range returns integer
	local integer result = 0
	local integer i = 0
	loop
		exitwhen (i == GetItemRespawnCounter())
		if (IsRespawnItemValid(i) and GetRespawnItem(i) == null and DistanceBetweenCoordinates(x, y, GetRespawnItemX(i), GetRespawnItemY(i)) <= range) then
            call RespawnItem(i)
			set result = result + 1
		endif
		set i = i + 1
	endloop
	return result
endfunction

function GetPlayerColorRed takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0xFF
    elseif c == PLAYER_COLOR_BLUE then
        return 0x00
    elseif c == PLAYER_COLOR_CYAN then
        return 0x1B
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x53
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFF
    elseif c == PLAYER_COLOR_ORANGE then
        return 0xFE
    elseif c == PLAYER_COLOR_GREEN then
        return 0x1F
    elseif c == PLAYER_COLOR_PINK then
        return 0xE4
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x94
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0x7D
    elseif c == PLAYER_COLOR_AQUA then
        return 0x0F
    elseif c == PLAYER_COLOR_BROWN then
        return 0x4D
    elseif c == PLAYER_COLOR_MAROON then
        return 0x9B
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0x00
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xBE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xEB
    elseif c == PLAYER_COLOR_PEACH then
        return 0xF8
    elseif c == PLAYER_COLOR_MINT then
        return 0xBF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xDC
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xEB
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x00
    elseif c == PLAYER_COLOR_PEANUT then
        return 0xA4
    else
        return 0xFF
    endif
    return 0
endfunction

function GetPlayerColorGreen takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0x41
    elseif c == PLAYER_COLOR_CYAN then
        return 0xE5
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x00
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFC
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x89
    elseif c == PLAYER_COLOR_GREEN then
        return 0xBF
    elseif c == PLAYER_COLOR_PINK then
        return 0x5A
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x95
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xBE
    elseif c == PLAYER_COLOR_AQUA then
        return 0x61
    elseif c == PLAYER_COLOR_BROWN then
        return 0x29
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xEA
    elseif c == PLAYER_COLOR_VIOLET then
        return 0x00
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xCD
    elseif c == PLAYER_COLOR_PEACH then
        return 0xA4
    elseif c == PLAYER_COLOR_MINT then
        return 0xFF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xB9
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xF0
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x78
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x6F
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorBlue takes player p returns integer
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0xFF
    elseif c == PLAYER_COLOR_CYAN then
        return 0xB8
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x80
    elseif c == PLAYER_COLOR_YELLOW then
        return 0x00
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x0D
    elseif c == PLAYER_COLOR_GREEN then
        return 0x00
    elseif c == PLAYER_COLOR_PINK then
        return 0xAF
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x96
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xF1
    elseif c == PLAYER_COLOR_AQUA then
        return 0x45
    elseif c == PLAYER_COLOR_BROWN then
        return 0x03
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0xC3
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xFF
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xFE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0x87
    elseif c == PLAYER_COLOR_PEACH then
        return 0x8B
    elseif c == PLAYER_COLOR_MINT then
        return 0x80
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xEB
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xFF
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x1E
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x33
    else
        return 0xFF
    endif
endfunction

function IntToPrecentage takes integer v, integer max returns real
    return I2R(v) / I2R(max) * 100.0
endfunction

function GetPlayerColorString takes player p, string text returns string
//Credits to Andrewgosu from TH for the color codes//
    local playercolor c = GetPlayerColor(p)
    if c == PLAYER_COLOR_RED then
        return "|cffFF0202" + text + "|r"
    elseif c == PLAYER_COLOR_BLUE then
        return "|cff0041FF" + text + "|r"
    elseif c == PLAYER_COLOR_CYAN then
        return "|cff1BE5B8" + text + "|r"
    elseif c == PLAYER_COLOR_PURPLE then
        return "|cff530080" + text + "|r"
    elseif c == PLAYER_COLOR_YELLOW then
        return "|cffFFFC00" + text + "|r"
    elseif c == PLAYER_COLOR_ORANGE then
        return "|cffFE890D" + text + "|r"
    elseif c == PLAYER_COLOR_GREEN then
        return "|cff1FBF00" + text + "|r"
    elseif c == PLAYER_COLOR_PINK then
        return "|cffE45AAF" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return "|cff949596" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return "|cff7DBEF1" + text + "|r"
    elseif c == PLAYER_COLOR_AQUA then
        return "|cff0F6145" + text + "|r"
    elseif c == PLAYER_COLOR_BROWN then
        return "|cff4D2903" + text + "|r"
    elseif c == PLAYER_COLOR_MAROON then
        return "|cff9B0000" + text + "|r"
    elseif c == PLAYER_COLOR_NAVY then
        return "|cff0000C3" + text + "|r"
    elseif c == PLAYER_COLOR_TURQUOISE then
        return "|cff00EAFF" + text + "|r"
    elseif c == PLAYER_COLOR_VIOLET then
        return "|cffBE00FE" + text + "|r"
    elseif c == PLAYER_COLOR_WHEAT then
        return "|cffEBCD87" + text + "|r"
    elseif c == PLAYER_COLOR_PEACH then
        return "|cffF8A48B" + text + "|r"
    elseif c == PLAYER_COLOR_MINT then
        return "|cffBFFF80" + text + "|r"
    elseif c == PLAYER_COLOR_LAVENDER then
        return "|cffDCB9EB" + text + "|r"
    elseif c == PLAYER_COLOR_COAL then
        return "|cff282828" + text + "|r"
    elseif c == PLAYER_COLOR_SNOW then
        return "|cffEBF0FF" + text + "|r"
    elseif c == PLAYER_COLOR_EMERALD then
        return "|cff00781E" + text + "|r"
    elseif c == PLAYER_COLOR_PEANUT then
        return "|cffA46F33" + text + "|r"
    else
        return "|cffFFFFFF" + text + "|r"
    endif
endfunction

function GetPlayerNameColored takes player whichPlayer returns string
	return "[" + I2S(GetPlayerId(whichPlayer) + 1) + "]" + GetPlayerColorString(whichPlayer, GetPlayerName(whichPlayer))
endfunction

function HookAddUnitToGroup takes unit whichUnit, group whichGroup returns nothing
    set udg_LastAddedUnitToGroup = whichUnit
endfunction

hook GroupAddUnitSimple HookAddUnitToGroup

function GetNextCraftedProfessionItemEx takes player whichPlayer, integer profession returns integer
	local unit hero = udg_Held[GetConvertedPlayerId(whichPlayer)]
	if (profession == udg_ProfessionHerbalist) then // Herbalism
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I025'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'pnvu'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'hlst'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'pghe'
		endif

	endif
	if (profession == udg_ProfessionAlchemist) then // Alchemy
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I024'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'woms'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'mnst'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'pgma'
		endif

	endif
	if (profession == udg_ProfessionWeaponSmith) then // Weapon Smith
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00R'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'I00Q'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00P'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00O'
		endif

	endif
	if (profession == udg_ProfessionArmourer) then // Armourer
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00N'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			return 'I00M'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00L'
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00K'
		endif

	endif
	if (profession == udg_ProfessionEngineer) then // Engineer
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 800.0) then
			return 'I00S' // tiny death tower
		endif
//		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 600.0) then
			//return 'I00M' // 2 gobline sappers
//		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 400.0) then
			return 'I00U' // tiny cold tower
		endif
		if (GetUnitStateSwap(UNIT_STATE_MANA, hero) >= 200.0) then
			return 'I00T' // tiny flame tower
		endif

	endif
	return 0
endfunction

function GetNextCraftedProfessionItem takes player whichPlayer returns integer
	local integer profession = udg_PlayerProfession[GetConvertedPlayerId(whichPlayer)]
	return GetNextCraftedProfessionItemEx(whichPlayer, profession)
endfunction

function GetNextCraftedProfession2Item takes player whichPlayer returns integer
	local integer profession = udg_PlayerProfession2[GetConvertedPlayerId(whichPlayer)]
	return GetNextCraftedProfessionItemEx(whichPlayer, profession)
endfunction

/**
 * Race system.
 *
 * All unit, building and item types might belong to a specific race. This information can be useful when replacing units, buildings or items or preventing players from using them since
 * they have chosen different races.
 */
globals
    // BUILDINGS
    constant integer RACE_OBJECT_TYPE_FARM = 0
    constant integer RACE_OBJECT_TYPE_ALTAR = 1
    constant integer RACE_OBJECT_TYPE_MILL = 2
    constant integer RACE_OBJECT_TYPE_BLACK_SMITH = 3
    constant integer RACE_OBJECT_TYPE_BARRACKS = 4
    constant integer RACE_OBJECT_TYPE_SHOP = 5
    constant integer RACE_OBJECT_TYPE_SCOUT_TOWER = 6
    constant integer RACE_OBJECT_TYPE_GUARD_TOWER = 7
    constant integer RACE_OBJECT_TYPE_CANNON_TOWER = 8
    constant integer RACE_OBJECT_TYPE_ARCANE_TOWER = 9
    constant integer RACE_OBJECT_TYPE_ARCANE_SANCTUM = 10
    constant integer RACE_OBJECT_TYPE_WORKSHOP = 11
    constant integer RACE_OBJECT_TYPE_GRYPHON_AVIARY = 12
    constant integer RACE_OBJECT_TYPE_TIER_1 = 13
    constant integer RACE_OBJECT_TYPE_TIER_2 = 14
    constant integer RACE_OBJECT_TYPE_TIER_3 = 15
    constant integer RACE_OBJECT_TYPE_HOUSING = 16
    constant integer RACE_OBJECT_TYPE_SHIPYARD = 17
    // ITEMS
    constant integer RACE_OBJECT_TYPE_SCEPTER_ITEM = 18
    constant integer RACE_OBJECT_TYPE_TIER_1_ITEM = 19
    constant integer RACE_OBJECT_TYPE_TIER_2_ITEM = 20
    // UNITS
    constant integer RACE_OBJECT_TYPE_WORKER = 21
    constant integer RACE_OBJECT_TYPE_MALE_CITIZEN = 22
    constant integer RACE_OBJECT_TYPE_FEMALE_CITIZEN = 23
    constant integer RACE_OBJECT_TYPE_PET = 24
    constant integer RACE_OBJECT_TYPE_FOOTMAN = 25
    constant integer RACE_OBJECT_TYPE_RIFLEMAN = 26
    constant integer RACE_OBJECT_TYPE_KNIGHT = 27
    constant integer RACE_OBJECT_TYPE_PRIEST = 28
    constant integer RACE_OBJECT_TYPE_SORCERESS = 29
    constant integer RACE_OBJECT_TYPE_SIEGE_ENGINE = 30
    constant integer RACE_OBJECT_TYPE_MORTAR = 31
    constant integer RACE_OBJECT_TYPE_GRYPHON = 32

    constant integer RACE_MAX_OBJECT_TYPES = 33

    integer array raceObjectType
endglobals

function SetRaceObjectType takes integer whichRace, integer unitType, integer objectTypeId returns nothing
    set raceObjectType[Index2D(whichRace, unitType, RACE_MAX_OBJECT_TYPES)] = objectTypeId
endfunction

function GetRaceObjectType takes integer whichRace, integer unitType returns integer
    return raceObjectType[Index2D(whichRace, unitType, RACE_MAX_OBJECT_TYPES)]
endfunction

function GetObjectRace takes integer objectTypeId returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return i
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return udg_RaceNone
endfunction

function GetObjectRaceType takes integer objectTypeId returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return j
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return -1
endfunction

function MapRaceObjectType takes integer objectTypeId, integer targetRace returns integer
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == udg_Max_Voelker)
        set j = 0
        loop
            exitwhen (j == RACE_MAX_OBJECT_TYPES)
            if (GetRaceObjectType(i, j) == objectTypeId) then
                return GetRaceObjectType(targetRace, j)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop

    return 0
endfunction

function InitStandardRaceObjectTypes takes nothing returns nothing
    // BUILDINGS

    // farms
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_FARM, 'hhou')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_FARM, 'otrb')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_FARM, 'uzig')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_FARM, 'emow')

    // altars
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_ALTAR, 'halt')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_ALTAR, 'oalt')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_ALTAR, 'uaod')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_ALTAR, 'eate')

    // mills
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_MILL, 'hlum')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_MILL, 'ofor')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_MILL, 'ugrv')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_MILL, 'edob')

    // black smiths
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_BLACK_SMITH, 'hbla')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_BLACK_SMITH, 'ofor')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_BLACK_SMITH, 'ugrv')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_BLACK_SMITH, 'edob')

    // barracks
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_BARRACKS, 'hbar')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_BARRACKS, 'obar')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_BARRACKS, 'usep')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_BARRACKS, 'eaom')

    // shops
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_SHOP, 'hars')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_SHOP, 'ovln')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_SHOP, 'utom')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_SHOP, 'eden')

    // guard tower
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_GUARD_TOWER, 'hgtw')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_GUARD_TOWER, 'owtw')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_GUARD_TOWER, 'uzg1')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_GUARD_TOWER, 'etrp')

    // arcane sanctum
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'hars')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'osld')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'utod')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_ARCANE_SANCTUM, 'eaoe')

    // gryphon aviary
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'hgra')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'otto')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'ubon')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_GRYPHON_AVIARY, 'edos')

    // tier 1
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_1, 'htow')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_1, 'ogre')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_1, 'unpl')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_1, 'etol')

    // tier 2
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_2, 'hkee')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_2, 'ostr')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_2, 'unp1')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_2, 'etoa')

    // tier 3
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_3, 'hcas')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_3, 'ofrt')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_3, 'unp2')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_3, 'etoe')

    // ITEMS

    // tier 1 item
    call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02P')
    call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_TIER_1_ITEM, 'tgrh')
    call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02K')
    call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02J')
    call SetRaceObjectType(udg_RaceNaga, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02M')
    call SetRaceObjectType(udg_RaceBloodElf, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02L')
    call SetRaceObjectType(udg_RaceDemon, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02N')
    call SetRaceObjectType(udg_RaceDraenei, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I02O')
    call SetRaceObjectType(udg_RaceFurbolg, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I03A')
    call SetRaceObjectType(udg_RaceGoblin, RACE_OBJECT_TYPE_TIER_1_ITEM, 'I03A')

   // tier 2 item
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_TIER_2_ITEM, 'tcas')

   // UNITS

   // worker
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_WORKER, 'hpea')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_WORKER, 'opeo')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_WORKER, 'uaco')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_WORKER, 'ewsp')

   // male citizen
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00E')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00I')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00G')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_MALE_CITIZEN, 'n00O')

   // footman
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_FOOTMAN, 'hfoo')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_FOOTMAN, 'ogru')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_FOOTMAN, 'ugho')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_FOOTMAN, 'earc')

   // rifleman
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_RIFLEMAN, 'hrif')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_RIFLEMAN, 'ohun')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_RIFLEMAN, 'ucry')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_RIFLEMAN, 'esen')

   // knight
   call SetRaceObjectType(udg_RaceHuman, RACE_OBJECT_TYPE_KNIGHT, 'hkni')
   call SetRaceObjectType(udg_RaceOrc, RACE_OBJECT_TYPE_KNIGHT, 'orai')
   call SetRaceObjectType(udg_RaceUndead, RACE_OBJECT_TYPE_KNIGHT, 'uabo')
   call SetRaceObjectType(udg_RaceNightElf, RACE_OBJECT_TYPE_KNIGHT, 'edoc')
endfunction

function GetBuildingRace takes integer buildingID returns integer
    return GetObjectRace(buildingID)
endfunction

// exclude certain buildings since every race can build them
function IsBuildingAllRaces takes integer buildingID returns boolean
    if (buildingID == 'n025') then // Power Generator
        return true
    elseif (buildingID == 'h014') then // Portal
        return true
    elseif (buildingID == 'h00N') then // Temple of Darkness
        return true
    elseif (buildingID == 'h00M') then // Temple of Light
        return true
    elseif (buildingID == 'h02M') then // Clan Hall
        return true
    elseif (buildingID == 'n04N') then // Clan Tower
        return true
    elseif (buildingID == 'n04M') then // Advanced Clan Tower
        return true
    elseif (buildingID == 'h020') then // Gate horizontal closed
        return true
    elseif (buildingID == 'h021') then // Gate horizontal open
        return true
    elseif (buildingID == 'nft1') then // Flame Tower
        return true
    elseif (buildingID == 'nft2') then // Advanced Flame Tower
        return true
    elseif (buildingID == 'ndt1') then // Cold Tower
        return true
    elseif (buildingID == 'ndt2') then // Advanced Cold Tower
        return true
    elseif (buildingID == 'ntt1') then // Death Tower
        return true
    elseif (buildingID == 'ntx2') then // Advanced Death Tower
        return true
    endif

    return false
endfunction

function MapAllRacesBuildingIDToItemID takes integer buildingID returns integer
    if (buildingID == 'n025') then // Power Generator
        return 'I05C'
    elseif (buildingID == 'h014') then // Portal
        return 'I05B'
    elseif (buildingID == 'h02M') then // Clan Hall
        return 'I04I'
    elseif (buildingID == 'n04N') then // Clan Tower
        return 'I05A'
    elseif (buildingID == 'n04M') then // Advanced Clan Tower
        return 'I05A'
    elseif (buildingID == 'nft1') then // Flame Tower
        return 'I00T'
    elseif (buildingID == 'nft2') then // Advanced Flame Tower
        return 'I00T'
    elseif (buildingID == 'ndt1') then // Cold Tower
        return 'I00U'
    elseif (buildingID == 'ndt2') then // Advanced Cold Tower
        return 'I00U'
     elseif (buildingID == 'ntt1') then // Death Tower
        return 'I00S'
    elseif (buildingID == 'ntx2') then // Advanced Death Tower
        return 'I00S'
    endif

    return 0
endfunction

function GetItemRace takes integer itemID returns integer
    return GetObjectRace(itemID)
endfunction

function GetUnitIDRace takes integer unitID returns integer
    return GetObjectRace(unitID)
endfunction

function MapBuildingID takes integer buildingID, integer targetRace returns integer
    return MapRaceObjectType(buildingID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapBuildingNumber takes integer buildingID, integer targetRace returns integer
    return 1
endfunction

function MapBuildingIDToItemID takes integer buildingID, integer targetRace returns integer
    local integer raceType = GetObjectRaceType(buildingID)

    if (IsBuildingAllRaces(buildingID)) then
        return MapAllRacesBuildingIDToItemID(buildingID)
    elseif (raceType == RACE_OBJECT_TYPE_TIER_1) then
        return GetRaceObjectType(targetRace, RACE_OBJECT_TYPE_TIER_1_ITEM)
    elseif (raceType == RACE_OBJECT_TYPE_TIER_2) then
        return GetRaceObjectType(targetRace, RACE_OBJECT_TYPE_TIER_2_ITEM)
    endif

    return 0
endfunction

function MapUnitID takes integer unitID, integer targetRace, boolean includingWorkers returns integer
    local integer raceType = -1
    if (not includingWorkers) then
        set raceType = GetObjectRaceType(unitID)

        if (raceType == RACE_OBJECT_TYPE_WORKER or raceType == RACE_OBJECT_TYPE_MALE_CITIZEN) then
            return 0
        endif
    endif

    return MapRaceObjectType(unitID, targetRace)
endfunction

// TODO does depend on the food produced, some farms might be converted into more farms.
function MapUnitNumber takes integer unitID, integer targetRace returns integer
    return 1
endfunction

function FilterIsBuilding takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE)
endfunction

// TODO Group created items by their ID with more charges per item.
function WrapUpAllBuildings takes player whichPlayer, real x, real y returns integer
    local group allBuildings = CreateGroup()
    local unit first = null
    local integer itemTypeId = 0
    local integer targetRace = udg_RaceNone
    local item whichItem = null
    local integer counter = 0
    local boolean remove = false
    call GroupEnumUnitsOfPlayer(allBuildings, whichPlayer, Filter(function FilterIsBuilding))
    loop
        set first = FirstOfGroup(allBuildings)
        exitwhen (first == null)
        set remove = false
        set targetRace = GetBuildingRace(GetUnitTypeId(first))
        //call BJDebugMsg("Building " + GetUnitName(first) + " has target race " + I2S(targetRace))
        if (targetRace != udg_RaceNone or IsBuildingAllRaces(GetUnitTypeId(first))) then
            set itemTypeId = MapBuildingIDToItemID(GetUnitTypeId(first), targetRace)
            //call BJDebugMsg("Building " + GetUnitName(first) + " has target item type " + GetObjectName(itemTypeId))
            if (itemTypeId != 0) then
                set whichItem = CreateItem(itemTypeId, x, y)
                call SetItemCharges(whichItem, MapBuildingNumber(GetUnitTypeId(first), targetRace))
                set counter = counter + 1
                set remove = true
            endif
        endif
        call GroupRemoveUnit(allBuildings, first)

        if (remove) then
            call RemoveUnit(first)
        endif

        set first = null
    endloop
    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null

    return counter
endfunction

// Barade's Save Code System 1.0
//
// Allows storing and loading custom save codes which contain any information.
//
// Details:
// save code digit - a digit of the number system used for a save code. This can be decimal, hexadecimal or custom.
// save code segment - a savecode consists of multiple segments storing information about specific properties.
// save code segment separator - the segments are separated by a special digit which is not used in the save code's digit to identify where a new segment starts
// save code - a save code using the digits of a sepcific number system consisting of one or several segments.
// string hash - a decimal value generated from a string using a one way function which cannot be converted back into its original string. We only use positive hash values to keep it simple.
// player name hash - a hash value from the player name used to verify that the savecode belongs to the using player
// save code checksum - a checksum of the save code in form of ea save code segment created by hashing the string up to excluding the checksum segment itself. This is used to verify that the savecode was not created manually although it could be faked.
//
// A save code could look the following way:
// <player name hash segment>X<game mode/single or multiplayer flag>X<game type>X<hero XP rate>X<hero XP>X<checksum>
//
// Obfuscation: Since it is pretty easy to know which segment has which information using these save code segments, we want to obfuscate the final generated save code a bit.
// We can do this by shifting the used digits using the player name hash since it will also be the same when the player loads the save code. By shifting the digits we might get different digits for different player name hashs.
//
// Compression: We want to keep the savecodes as short as possible. Hence, we combine flags like game mode and single/multiplayer in one number. We could go even further as long as we know the maximum number of a value.
// Another form of compression is to make the string hashes much shorter by using the modulo operation. This comes with the risk of having less different string hashes for different player names or as checksums but as long
// as there are enough possibilities it is hard enough to fake the correct string hash value.
library SaveCodeSystem requires WoWReforgedUtils

globals
    constant string SAVE_CODE_DIGITS = "_Ci{o98%*rQaHA=cM>Pj]NTUq/u7y(-S!)hzpR:}DKLvBJXI4O[k@e53<FVftm,6dlZ&bY2~^#\"nx'+wG|?s\\`E1$;.0gW" // ASCII without space
    constant string SAVE_CODE_SEGMENT_SEPARATOR = "Ä" // must not be part of SAVE_CODE_DIGITS
    constant boolean SAVE_CODE_COMPRESS_STRING_HASHS = true
    constant boolean SAVE_CODE_OBFUSCATE = true
endglobals

function CheckStringForDuplicatedCharacters takes string source returns nothing
    local boolean foundDuplicated = false
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i == StringLength(source))
        set j = 0
        loop
            exitwhen (j == StringLength(source))
            if (i != j and SubString(source, i, i + 1) == SubString(source, j, j + 1)) then
                set foundDuplicated = true
                call BJDebugMsg("Duplicated digit at " + I2S(i) + " and " + I2S(j) + ": " + SubString(source, i, i + 1))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    if (not foundDuplicated) then
        call BJDebugMsg("No duplicates have been found!")
    endif
endfunction

function CheckSaveCodeDigitsUnique takes nothing returns nothing
    call CheckStringForDuplicatedCharacters(SAVE_CODE_DIGITS)
endfunction

// Returns the base for the custom number system.
function GetMaxSaveCodeDigits takes nothing returns integer
    return StringLength(SAVE_CODE_DIGITS)
endfunction

function ConvertDecimalDigitToSaveCodeDigit takes integer digit returns string
    return SubString(SAVE_CODE_DIGITS, digit, digit + 1)
endfunction

function IndexOfSaveCodeDigit takes string symbol returns integer
    return IndexOfString(symbol, SAVE_CODE_DIGITS)
endfunction

function GetObfuscationSaveCodeDigits takes nothing returns string
    // we want to have the separator in it so we can obfuscate the whole save code with separators.
    return SAVE_CODE_DIGITS + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function GetMaxObfuscationSaveCodeDigits takes nothing returns integer
    return GetMaxSaveCodeDigits() + 1
endfunction

function GetShiftedSaveCodeSplitPosition takes integer n returns integer
    return ModuloInteger(n, GetMaxObfuscationSaveCodeDigits())
endfunction

// Use a hash value (like the player name's hash) to move the symbol table. This might prevent reproducing savecodes too easily.
function GetShiftedSaveCodeDigits takes integer n returns string
    local integer max = GetMaxObfuscationSaveCodeDigits()
    local string saveCodeDigits = GetObfuscationSaveCodeDigits()
    local integer splitPosition = GetShiftedSaveCodeSplitPosition(n)
    return SubString(saveCodeDigits, splitPosition, GetMaxObfuscationSaveCodeDigits()) + SubString(saveCodeDigits, 0, splitPosition)
endfunction

// TODO Can be slow for big numbers. Maybe move into a separate trigger with a new OpLimit.
function ConvertDecimalNumberToSaveCodeSegment takes integer number returns string
    local string result = ""
    local integer start = number
    local integer base = GetMaxSaveCodeDigits()
    local integer mod = 0
    //call BJDebugMsg("Converting number " + I2S(start))
    loop
        //call BJDebugMsg("Dividing number " + I2S(start) + " by " + I2S(base))
        set mod = ModuloInteger(start, base)
        set start = start / base
        set result = ConvertDecimalDigitToSaveCodeDigit(mod) + result
        exitwhen (start == 0)
        //call BJDebugMsg("Result: " + result)
    endloop

    return result + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function ConvertSaveCodeToObfuscatedVersion takes string saveCode, integer hash returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigits(hash)
    local string saveCodeDigits = GetObfuscationSaveCodeDigits()
    local integer index = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set index = IndexOfString(SubString(saveCode, i, i + 1), saveCodeDigits)
        if (index != -1) then
            set result = result + SubString(shiftedSaveCodeDigits, index, index + 1)
        else
            set result = result + "?"
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ConvertSaveCodeFromObfuscatedVersion takes string saveCode, integer hash returns string
    local string shiftedSaveCodeDigits = GetShiftedSaveCodeDigits(hash)
    local integer splitPosition = GetShiftedSaveCodeSplitPosition(hash)
    local integer shiftedIndex = -1
    local integer originalIndex = -1
    local string result = ""
    local integer i = 0
    //call BJDebugMsg("Shifted digits: " + shiftedSaveCodeDigits)
    loop
        exitwhen (i == StringLength(saveCode))
        set shiftedIndex = IndexOfString(SubString(saveCode, i, i + 1), shiftedSaveCodeDigits)
        if (shiftedIndex != -1) then
            set result = result + SubString(GetObfuscationSaveCodeDigits(), shiftedIndex, shiftedIndex + 1)
        else
            set result = result + "?"
        endif
        set i = i + 1
    endloop
    return result
endfunction

function PowI takes integer x, integer y returns integer
    local integer result = 1
    local integer i = 0
    loop
        exitwhen (i == y)
        set result = result * x
        set i = i + 1
    endloop

    return result
endfunction

// Convert our number system into the decimal system number.
function ConvertSaveCodeSegmentIntoDecimalNumber takes string symbol, integer n returns integer
    local integer index = IndexOfSaveCodeDigit(symbol)
    if (index != -1) then
        //call BJDebugMsg("Index " + I2S(index) +  " for symbol " + symbol + " pow " + I2S(GetMaxSaveCodeDigits()) + ", " + I2S(n))
        return index * PowI(GetMaxSaveCodeDigits(), n)
    endif
    //call BJDebugMsg("Cannot find symbol: " + symbol + " with n: " + I2S(n))
    return 0
endfunction

// the separator comes after a segment
function GetSaveCodeSegments takes string saveCode returns integer
    local integer separatorCounter = 0
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        endif
        set i = i + 1
    endloop

    return separatorCounter
endfunction

// includes the separator character!
function GetSaveCodeUntil takes string saveCode, integer excludedIndex returns string
    local integer separatorCounter = 0
    local integer index = StringLength(saveCode)
    local integer i = 0
    loop
        exitwhen (separatorCounter >= excludedIndex or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
            set index = i + 1 // include the separator character!
        endif
        set i = i + 1
    endloop

    return SubString(saveCode, 0, index)
endfunction

/**
 * Extracts the part of a save code with index and converts it into a decimal number.
 */
function ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode takes string saveCode, integer index returns integer
    local string substr = ""
    local integer result = 0
    local integer separatorCounter = 0
    local integer n = -1 // start with n - 1 and end with 0
    local integer i = 0
    loop
        exitwhen (separatorCounter > index or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        elseif (separatorCounter == index) then
            set substr = substr + SubString(saveCode, i, i + 1)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // convert into decimal number
    //call BJDebugMsg("Calculate number back " + substr)
    set i = 0
    loop
        exitwhen (i == StringLength(substr))
        set result = result + ConvertSaveCodeSegmentIntoDecimalNumber(SubString(substr, i, i + 1), n)
        //call BJDebugMsg("Result " + I2S(result))
        set n = n - 1
        set i = i + 1
    endloop

    return result
endfunction

// Strings are just obfuscated per character.
// Otherwise, we would need to store the length per character.
// The characters must be in the savecode alphabet. Otherwise, they will become a ? character.
function ConvertStringToSaveCodeSegment takes string whichString, integer hash returns string
    local string result = ""
    local string character = ""
    local integer i = 0
    loop
        exitwhen (i == StringLength(whichString))
        set character = SubString(whichString, i, i + 1)
        if (character == " ") then
            set character = "_"
        endif
        set result = result + ConvertSaveCodeToObfuscatedVersion(character, hash)
        set i = i + 1
    endloop
    return result + SAVE_CODE_SEGMENT_SEPARATOR
endfunction

function ConvertSaveCodeSegmentIntoStringFromSaveCode takes string saveCode, integer index, integer hash returns string
    local string substr = ""
    local string character = ""
    local string result = ""
    local integer separatorCounter = 0
    local integer n = -1 // start with n - 1 and end with 0
    local integer i = 0
    loop
        exitwhen (separatorCounter > index or i == StringLength(saveCode))
        if (SubString(saveCode, i, i + 1) == SAVE_CODE_SEGMENT_SEPARATOR) then
            set separatorCounter = separatorCounter + 1
        elseif (separatorCounter == index) then
            set substr = substr + SubString(saveCode, i, i + 1)
            set n = n + 1
        endif
        set i = i + 1
    endloop
    // convert into decimal number
    //call BJDebugMsg("Calculate number back " + substr)
    set i = 0
    loop
        exitwhen (i == StringLength(substr))
        set character = ConvertSaveCodeFromObfuscatedVersion(SubString(substr, i, i + 1), hash)
        if (character == "_") then
            set character = " "
        endif
        set result = result + character
        //call BJDebugMsg("Result " + I2S(result))
        set n = n - 1
        set i = i + 1
    endloop

    return result
endfunction

// We don't want to handle negative numbers.
function AbsStringHash takes string whichString returns integer
    return IAbsBJ(StringHash(whichString))
endfunction

function CompressedAbsStringHash takes string whichString returns integer
    local integer absStringHash = AbsStringHash(whichString)
    if (SAVE_CODE_COMPRESS_STRING_HASHS) then
        return ModuloInteger(absStringHash, GetMaxSaveCodeDigits() * 3)
    endif
    return absStringHash
endfunction

function IsCharacterUpperCase takes string letter returns boolean
    return letter == "A" or letter == "B" or letter == "C" or letter == "D" or letter == "E" or letter == "F" or letter == "G" or letter == "H" or letter == "I" or letter == "J" or letter == "K" or letter == "L" or letter == "M" or letter == "N" or letter == "O" or letter == "P" or letter == "Q" or letter == "R" or letter == "S" or letter == "T" or letter == "U" or letter == "V" or letter == "W" or letter == "X" or letter == "Y" or letter == "Z"
endfunction

function ColoredSaveCode takes string saveCode returns string
    local string result = ""
    local integer i = 0
    loop
        exitwhen (i == StringLength(saveCode))
        if (IsCharacterUpperCase(SubString(saveCode, i, i + 1))) then
            set result = result + "|cffffcc00" + SubString(saveCode, i, i + 1) + "|r"
        else
            set result = result + SubString(saveCode, i, i + 1)
        endif
        set i = i + 1
    endloop

    return result
endfunction

function AppendFileContent takes string content returns string
    return "\r\n\t\t\t\t" + content
endfunction

function AppendFileContentLeft takes string content returns string
    return "\r\n" + content
endfunction

function CreateSaveCodeTextFile takes string playerName, string info, string fileName, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -load " + saveCode)
    set content = content + AppendFileContent(info)
    set content = content + AppendFileContent("")

    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd(fileName)
endfunction

endlibrary

function FilterPlayerFunctionUsedUser takes nothing returns boolean
    return GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER and GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING
endfunction

function IsInSinglePlayer takes nothing returns boolean
    //return CountPlayersInForceBJ(GetPlayersMatching(Condition(function FilterPlayerFunctionUsedUser))) == 1
    // https://www.hiveworkshop.com/threads/how-to-detect-single-player.161490/
    // Even works when all players except one have left the game:
    return ReloadGameCachesFromDisk()
endfunction

function GetHeroLevelMaxXP takes integer heroLevel returns integer
    local integer result = 0 // level 1 XP
    local integer i = 3
    loop
        exitwhen (i > heroLevel + 1)
        set result = result + i * 1000
        set i = i + 1
    endloop
    return result
endfunction

function GetHeroLevelByXP takes integer xp returns integer
    local integer heroLevel = 1
    local integer i = 3
    loop
        set xp = xp - i * 1000
        exitwhen (xp < 0)
        set heroLevel = heroLevel + 1
        set i = i + 1
    endloop
    return heroLevel
endfunction

function GetHeroLevel1 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held[playerId] != null) then
        return GetHeroLevel(udg_Held[playerId])
    endif

    return GetHeroLevelByXP(udg_CharacterStartXP[playerId])
endfunction

function GetHeroLevel2 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held2[playerId] != null) then
        return GetHeroLevel(udg_Held2[playerId])
    endif

    return GetHeroLevelByXP(udg_Held2XP[playerId])
endfunction

function GetHeroLevel3 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held3[playerId] != null) then
        return GetHeroLevel(udg_Held3[playerId])
    endif

    return GetHeroLevelByXP(udg_Held3XP[playerId])
endfunction

function GetHighestHeroLevel takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    local integer heroLevel1 = GetHeroLevel1(whichPlayer)
    local integer heroLevel2 = GetHeroLevel2(whichPlayer)
    local integer heroLevel3 = GetHeroLevel3(whichPlayer)

    if (heroLevel1 > heroLevel2 and heroLevel1 > heroLevel3) then
        return heroLevel1
    elseif (heroLevel2 > heroLevel1 and heroLevel2 > heroLevel3) then
        return heroLevel2
    endif

    return heroLevel3
endfunction

function GetHighestHeroLevelFromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetHighestHeroLevel(whichPlayer)
            if (heroLevel > result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function GetLowestHeroLevel takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    local integer heroLevel1 = GetHeroLevel1(whichPlayer)
    local integer heroLevel2 = GetHeroLevel2(whichPlayer)
    local integer heroLevel3 = GetHeroLevel3(whichPlayer)

    if (heroLevel1 < heroLevel2 and heroLevel1 < heroLevel3) then
        return heroLevel1
    elseif (heroLevel2 < heroLevel1 and heroLevel2 < heroLevel3) then
        return heroLevel2
    endif

    return heroLevel3
endfunction

function GetLowestHeroLevelFromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetLowestHeroLevel(whichPlayer)
            if (heroLevel < result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function GetLowestHeroLevel1FromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetHeroLevel1(whichPlayer)
            if (result == 0 or heroLevel < result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

globals
    integer gameSeed = GetRandomInt(0, 100000)
endglobals

function FormatIntegerToTwoDigits takes integer value returns string
    if (value > 9) then
        return I2S(value)
    else
        return "0" + I2S(value)
    endif
endfunction

function FormatTimeString takes integer seconds returns string
    local integer minutes = seconds / 60
    local integer hours = minutes / 60
    local integer hoursInMinutes = hours * 60
    local integer minutesInSeconds = minutes * 60

    set minutes = minutes - hoursInMinutes
    set seconds = seconds - minutesInSeconds

    if (hours > 0) then
        return FormatIntegerToTwoDigits(hours) + ":" + FormatIntegerToTwoDigits(minutes) + ":" + FormatIntegerToTwoDigits(seconds)
    elseif (minutes > 0) then
        return FormatIntegerToTwoDigits(minutes) + ":" + FormatIntegerToTwoDigits(seconds)
    else
        return I2S(seconds) + " seconds"
    endif
endfunction

// look into the exported war3map.j script
function GetMapName takes nothing returns string
    return GetLocalizedString("TRIGSTR_001")
endfunction

function GetSinglePlayerStatus takes boolean isSinglePlayer returns string
    if (isSinglePlayer) then
        return "S"
    endif

    return "M"
endfunction

function GetGameTypeName takes integer gameType returns string
    if (gameType == udg_GameTypeEasy) then
        return "E"
    elseif (gameType == udg_GameTypeHardcore) then
        return "H"
    elseif (gameType == udg_GameTypeFast) then
        return "F"
    endif

    return "N"
endfunction

// keep the folder name short
// otherwise there won't be any folder
function GetSaveCodeFolderNameEx takes force whichForce, real duration, integer seed returns string
    local string result = "wowr-" + GetSinglePlayerStatus(IsInSinglePlayer()) + "-" + GetGameTypeName(udg_GameType)
    local integer playerCounter = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), whichForce)) then
            set playerCounter = playerCounter + 1
        endif
        set i = i + 1
    endloop

    return result + "-" + I2S(playerCounter) + "-" + FormatTimeString(R2I(duration)) + "-S_" + I2S(gameSeed)
endfunction

function GetSaveCodeFolderName takes nothing returns string
    local force whichForce = CreateForce()
    local string result = ""
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if GetPlayerController(Player(i)) == MAP_CONTROL_USER and (GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING or GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_LEFT) then
            call ForceAddPlayer(whichForce, Player(i))
        endif
        set i = i + 1
    endloop
    set result = GetSaveCodeFolderNameEx(whichForce, udg_GameTime, gameSeed)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
    return result
endfunction

globals
    // store all generated save codes during a game to prevent loading them immediately and duplicating stuff
    string array generatedSaveCodes
    integer generatedSaveCodesCounter = 0
endglobals

function AddGeneratedSaveCode takes string saveCode returns integer
    set generatedSaveCodes[generatedSaveCodesCounter] = saveCode
    set generatedSaveCodesCounter = generatedSaveCodesCounter + 1
    return generatedSaveCodesCounter
endfunction

function IsGeneratedSaveCode takes string saveCode returns boolean
    local integer i = 0
    loop
        exitwhen (i >= generatedSaveCodesCounter)
        if (saveCode == generatedSaveCodes[i]) then
            return false
        endif
        set i = i + 1
    endloop
    return false
endfunction

function ConvertSaveCodeDemigodValueToInfo takes integer value returns string
    if (value == 1) then
        return "Light Demigod"
    elseif (value == 2) then
        return "Dark Demigod"
    elseif (value == 3) then
        return "Any Demigod"
    endif

    return "No Demigod"
endfunction

function CreateSaveCodeTextFileHeroes takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer xpRate, integer heroLevel, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer improvedNavyLevel, integer improvedCreepHunterLevel, integer demigodValue, integer equipmentBags, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -load " + saveCode)
    set content = content + AppendFileContent("Player: " + playerName)
    set content = content + AppendFileContent("Singleplayer: " + singleplayer)
    set content = content + AppendFileContent("Game Mode: " + gameMode)
    set content = content + AppendFileContent("Game Type: " + gameType)
    set content = content + AppendFileContent("XP rate: " + I2S(xpRate))
    set content = content + AppendFileContent("Hero Level: " + I2S(heroLevel))
    set content = content + AppendFileContent("XP: " + I2S(xp))
    set content = content + AppendFileContent("Demigod: " + ConvertSaveCodeDemigodValueToInfo(demigodValue))
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Evolution: " + I2S(evolutionLevel))
    set content = content + AppendFileContent("Improved Power Generator: " + I2S(powerGeneratorLevel))
    set content = content + AppendFileContent("Hand of God: " + I2S(handOfGodLevel))
    set content = content + AppendFileContent("Improved Mount: " + I2S(mountLevel))
    set content = content + AppendFileContent("Improved Masonry: " + I2S(masonryLevel))
    set content = content + AppendFileContent("Improved Navy: " + I2S(improvedNavyLevel))
    set content = content + AppendFileContent("Improved Creep Hunter: " + I2S(improvedCreepHunterLevel))
    set content = content + AppendFileContent("Equipment Bags: " + I2S(equipmentBags))
    set content = content + AppendFileContent("Hero Kills: " + I2S(heroKills))
    set content = content + AppendFileContent("Hero Deaths: " + I2S(heroDeaths))
    set content = content + AppendFileContent("Unit Kills: " + I2S(unitKills))
    set content = content + AppendFileContent("Unit Deaths: " + I2S(unitDeaths))
    set content = content + AppendFileContent("Buildings Razed: " + I2S(buildingsRazed))
    set content = content + AppendFileContent("Boss Kills: " + I2S(totalBossKills))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Hero Level 2: " + I2S(heroLevel2))
    set content = content + AppendFileContent("XP 2: " + I2S(xp2))

    set content = content + AppendFileContent("Hero Level 3: " + I2S(heroLevel3))
    set content = content + AppendFileContent("XP 3: " + I2S(xp3))

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-level1-" + I2S(heroLevel) + "-level2-" + I2S(heroLevel2) + "-level3-" + I2S(heroLevel3) + "-gold-" + I2S(gold) + "-lumber-" + I2S(lumber) + ".txt")
endfunction

// use one single symbol to store these two flags
function GetSinglePlayerAndGameMode takes boolean isSinglePlayer, boolean isWarlord returns integer
    if (isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 0")
        return 0
    elseif (isSinglePlayer and not isWarlord) then
        //call BJDebugMsg("Save code single player and mode 1")
        return 1
    elseif (not isSinglePlayer and isWarlord) then
        //call BJDebugMsg("Save code single player and mode 2")
        return 2
    else
        //call BJDebugMsg("Save code single player and mode 3")
        return 3
    endif

    return 0
endfunction

function GetSinglePlayerFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return true
    elseif (saveCodeSegment == 2) then
        return false
    else
        return false
    endif

    return false
endfunction

function GetWarlordFromSaveCodeSegment takes integer saveCodeSegment returns boolean
    if (saveCodeSegment == 0) then
        //call BJDebugMsg("Save code single player and mode 0")
        return true
    elseif (saveCodeSegment == 1) then
        return false
    elseif (saveCodeSegment == 2) then
        return true
    else
        return false
    endif

    return false
endfunction

function GetSaveCodeEx takes player whichPlayer, string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, integer heroLevel, integer xp, integer gold, integer lumber, integer evolutionLevel, integer powerGeneratorLevel, integer handOfGodLevel, integer mountLevel, integer masonryLevel, integer heroKills, integer heroDeaths, integer unitKills, integer unitDeaths, integer buildingsRazed, integer totalBossKills, integer heroLevel2, integer xp2, integer heroLevel3, integer xp3, integer improvedNavyLevel, integer improvedCreepHunterLevel, integer demigodValue, integer equipmentBags returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp)

    // resources
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber)

    // upgrades
    set result = result + ConvertDecimalNumberToSaveCodeSegment(evolutionLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(powerGeneratorLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(handOfGodLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(mountLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(masonryLevel)

    // stats
    set result = result + ConvertDecimalNumberToSaveCodeSegment(heroKills)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(heroDeaths)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(unitKills)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(unitDeaths)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(buildingsRazed)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(totalBossKills)

    // hero 2
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp2)

    // hero 3
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xp3)

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // upgrades
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedNavyLevel)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedCreepHunterLevel)

    // demigod
    set result = result + ConvertDecimalNumberToSaveCodeSegment(demigodValue)

    set result = result + ConvertDecimalNumberToSaveCodeSegment(equipmentBags)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    // never store savecode files of other players on the disk
    if (GetLocalPlayer() == whichPlayer) then
        call CreateSaveCodeTextFileHeroes(playerName, isSinglePlayer, isWarlord, gameType, xpRate, heroLevel, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills, heroLevel2, xp2, heroLevel3, xp3, improvedNavyLevel, improvedCreepHunterLevel, demigodValue, equipmentBags, result)
    endif

    call AddGeneratedSaveCode(result)

    return result
endfunction

globals
    constant integer UPG_EVOLUTION                                   = 'R00U'
    constant integer UPG_CHEAP_EVOLUTION                             = 'R01V'
	constant integer UPG_IMPROVED_POWER_GENERATOR                    = 'R01T'
	constant integer UPG_IMPROVED_MOUNT                              = 'R024'
	constant integer UPG_IMPROVED_HAND_OF_GOD                        = 'R00V'
	constant integer UPG_IMPROVED_MASONRY                            = 'R00W'
	constant integer UPG_IMPROVED_NAVY                               = 'R035'
	constant integer UPG_IMPROVED_CREEP_HUNTER                       = 'R02Z'
	constant integer UPG_DEMIGOD                                     = 'R04S'
endglobals

function GetSaveCodeDemigodValue takes player whichPlayer returns integer
    local integer unitTypeId = GetUnitTypeId(udg_Held[GetConvertedPlayerId(whichPlayer)])
    if (unitTypeId == 'H003') then
        return 1
    elseif (unitTypeId == 'H002') then
        return 2
    elseif (GetPlayerTechCountSimple(UPG_DEMIGOD, whichPlayer) > 0) then
        return 3
    endif

    return 0
endfunction

library Ascii /* v1.1.0.0         Nestharus/Bribe
************************************************************************************
*
*   function Char2Ascii takes string s returns integer
*       integer ascii = Char2Ascii("F")
*
*   function Ascii2Char takes integer a returns string
*       string char = Ascii2Char('F')
*
*   function A2S takes integer a returns string
*       string rawcode = A2S('CODE')
*
*   function S2A takes string s returns integer
*       integer rawcode = S2A("CODE")
*
************************************************************************************/
    globals
        private integer array i //hash
        private integer array h //hash2
        private integer array y //hash3
        private string array c  //char
    endglobals
    function Char2Ascii takes string p returns integer
        local integer z = i[StringHash(p)/0x1F0748+0x40D]
        if (c[z] != p) then
            if (c[z - 32] != p) then
                if (c[h[z]] != p) then
                    if (c[y[z]] != p) then
                        if (c[83] != p) then
                            debug call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,"ASCII ERROR: INVALID CHARACTER: " + p)
                            return 0
                        endif
                        return 83
                    endif
                    return y[z]
                endif
                return h[z]
            endif
            return z - 32
        endif
        return z
    endfunction
    function Ascii2Char takes integer a returns string
        return c[a]
    endfunction
    function A2S takes integer a returns string
        local string s=""
        loop
            set s=c[a-a/256*256]+s
            set a=a/256
            exitwhen 0==a
        endloop
        return s
    endfunction
    function S2A takes string s returns integer
        local integer a=0
        local integer l=StringLength(s)
        local integer j=0
        local string m
        local integer h
        loop
            exitwhen j==l
            set a = a*256 + Char2Ascii(SubString(s,j,j+1))
            set j=j+1
        endloop
        return a
    endfunction
    private module Init
        private static method onInit takes nothing returns nothing
            set i[966] = 8
            set i[1110] = 9
            set i[1621] = 10
            set i[1375] = 12
            set i[447] = 13
            set i[233] = 32
            set i[2014] = 33
            set i[1348] = 34
            set i[1038] = 35
            set i[1299] = 36
            set i[1018] = 37
            set i[1312] = 38
            set i[341] = 39
            set i[939] = 40
            set i[969] = 41
            set i[952] = 42
            set i[2007] = 43
            set i[1415] = 44
            set i[2020] = 45
            set i[904] = 46
            set i[1941] = 47
            set i[918] = 48
            set i[1593] = 49
            set i[719] = 50
            set i[617] = 51
            set i[703] = 52
            set i[573] = 53
            set i[707] = 54
            set i[1208] = 55
            set i[106] = 56
            set i[312] = 57
            set i[124] = 58
            set i[1176] = 59
            set i[74] = 60
            set i[1206] = 61
            set i[86] = 62
            set i[340] = 63
            set i[35] = 64
            set i[257] = 65
            set i[213] = 66
            set i[271] = 67
            set i[219] = 68
            set i[1330] = 69
            set i[1425] = 70
            set i[1311] = 71
            set i[238] = 72
            set i[1349] = 73
            set i[244] = 74
            set i[1350] = 75
            set i[205] = 76
            set i[1392] = 77
            set i[1378] = 78
            set i[1432] = 79
            set i[1455] = 80
            set i[1454] = 81
            set i[1431] = 82
            set i[1409] = 83
            set i[1442] = 84
            set i[534] = 85
            set i[1500] = 86
            set i[771] = 87
            set i[324] = 88
            set i[1021] = 89
            set i[73] = 90
            set i[1265] = 91
            set i[1941] = 92
            set i[1671] = 93
            set i[1451] = 94
            set i[1952] = 95
            set i[252] = 96
            set i[257] = 97
            set i[213] = 98
            set i[271] = 99
            set i[219] = 100
            set i[1330] = 101
            set i[1425] = 102
            set i[1311] = 103
            set i[238] = 104
            set i[1349] = 105
            set i[244] = 106
            set i[1350] = 107
            set i[205] = 108
            set i[1392] = 109
            set i[1378] = 110
            set i[1432] = 111
            set i[1455] = 112
            set i[1454] = 113
            set i[1431] = 114
            set i[1409] = 115
            set i[1442] = 116
            set i[534] = 117
            set i[1500] = 118
            set i[771] = 119
            set i[324] = 120
            set i[1021] = 121
            set i[73] = 122
            set i[868] = 123
            set i[1254] = 124
            set i[588] = 125
            set i[93] = 126
            set i[316] = 161
            set i[779] = 162
            set i[725] = 163
            set i[287] = 164
            set i[212] = 165
            set i[7] = 166
            set i[29] = 167
            set i[1958] = 168
            set i[1009] = 169
            set i[1580] = 170
            set i[1778] = 171
            set i[103] = 172
            set i[400] = 174
            set i[1904] = 175
            set i[135] = 176
            set i[1283] = 177
            set i[469] = 178
            set i[363] = 179
            set i[550] = 180
            set i[1831] = 181
            set i[1308] = 182
            set i[1234] = 183
            set i[1017] = 184
            set i[1093] = 185
            set i[1577] = 186
            set i[606] = 187
            set i[1585] = 188
            set i[1318] = 189
            set i[980] = 190
            set i[1699] = 191
            set i[1292] = 192
            set i[477] = 193
            set i[709] = 194
            set i[1600] = 195
            set i[2092] = 196
            set i[50] = 197
            set i[546] = 198
            set i[408] = 199
            set i[853] = 200
            set i[205] = 201
            set i[411] = 202
            set i[1311] = 203
            set i[1422] = 204
            set i[1808] = 205
            set i[457] = 206
            set i[1280] = 207
            set i[614] = 208
            set i[1037] = 209
            set i[237] = 210
            set i[1409] = 211
            set i[1023] = 212
            set i[1361] = 213
            set i[695] = 214
            set i[161] = 215
            set i[1645] = 216
            set i[1822] = 217
            set i[644] = 218
            set i[1395] = 219
            set i[677] = 220
            set i[1677] = 221
            set i[881] = 222
            set i[861] = 223
            set i[1408] = 224
            set i[1864] = 225
            set i[1467] = 226
            set i[1819] = 227
            set i[1971] = 228
            set i[949] = 229
            set i[774] = 230
            set i[1828] = 231
            set i[865] = 232
            set i[699] = 233
            set i[786] = 234
            set i[1806] = 235
            set i[1286] = 236
            set i[1128] = 237
            set i[1490] = 238
            set i[1720] = 239
            set i[1817] = 240
            set i[729] = 241
            set i[1191] = 242
            set i[1164] = 243
            set i[413] = 244
            set i[349] = 245
            set i[1409] = 246
            set i[660] = 247
            set i[2016] = 248
            set i[1087] = 249
            set i[1497] = 250
            set i[753] = 251
            set i[1579] = 252
            set i[1456] = 253
            set i[606] = 254
            set i[1625] = 255
            set h[92] = 47
            set h[201] = 108
            set h[201] = 76
            set h[203] = 103
            set h[203] = 71
            set h[246] = 115
            set h[246] = 83
            set h[246] = 211
            set h[254] = 187
            set y[201] = 108
            set y[203] = 103
            set y[246] = 115

            set c[8]="\b"
            set c[9]="\t"
            set c[10]="\n"
            set c[12]="\f"
            set c[13]="\r"
            set c[32]=" "
            set c[33]="!"
            set c[34]="\""
            set c[35]="#"
            set c[36]="$"
            set c[37]="%"
            set c[38]="&"
            set c[39]="'"
            set c[40]="("
            set c[41]=")"
            set c[42]="*"
            set c[43]="+"
            set c[44]=","
            set c[45]="-"
            set c[46]="."
            set c[47]="/"
            set c[48]="0"
            set c[49]="1"
            set c[50]="2"
            set c[51]="3"
            set c[52]="4"
            set c[53]="5"
            set c[54]="6"
            set c[55]="7"
            set c[56]="8"
            set c[57]="9"
            set c[58]=":"
            set c[59]=";"
            set c[60]="<"
            set c[61]="="
            set c[62]=">"
            set c[63]="?"
            set c[64]="@"
            set c[65]="A"
            set c[66]="B"
            set c[67]="C"
            set c[68]="D"
            set c[69]="E"
            set c[70]="F"
            set c[71]="G"
            set c[72]="H"
            set c[73]="I"
            set c[74]="J"
            set c[75]="K"
            set c[76]="L"
            set c[77]="M"
            set c[78]="N"
            set c[79]="O"
            set c[80]="P"
            set c[81]="Q"
            set c[82]="R"
            set c[83]="S"
            set c[84]="T"
            set c[85]="U"
            set c[86]="V"
            set c[87]="W"
            set c[88]="X"
            set c[89]="Y"
            set c[90]="Z"
            set c[91]="["
            set c[92]="\\"
            set c[93]="]"
            set c[94]="^"
            set c[95]="_"
            set c[96]="`"
            set c[97]="a"
            set c[98]="b"
            set c[99]="c"
            set c[100]="d"
            set c[101]="e"
            set c[102]="f"
            set c[103]="g"
            set c[104]="h"
            set c[105]="i"
            set c[106]="j"
            set c[107]="k"
            set c[108]="l"
            set c[109]="m"
            set c[110]="n"
            set c[111]="o"
            set c[112]="p"
            set c[113]="q"
            set c[114]="r"
            set c[115]="s"
            set c[116]="t"
            set c[117]="u"
            set c[118]="v"
            set c[119]="w"
            set c[120]="x"
            set c[121]="y"
            set c[122]="z"
            set c[123]="{"
            set c[124]="|"
            set c[125]="}"
            set c[126]="~"
            set c[128] = "€"
            set c[130] = "‚"
            set c[131] = "ƒ"
            set c[132] = "„"
            set c[133] = "…"
            set c[134] = "†"
            set c[135] = "‡"
            set c[136] = "ˆ"
            set c[137] = "‰"
            set c[138] = "Š"
            set c[139] = "‹"
            set c[140] = "Œ"
            set c[142] = "Ž"
            set c[145] = "‘"
            set c[146] = "’"
            set c[147] = "“"
            set c[148] = "”"
            set c[149] = "•"
            set c[150] = "–"
            set c[151] = "—"
            set c[152] = "˜"
            set c[153] = "™"
            set c[154] = "š"
            set c[155] = "›"
            set c[156] = "œ"
            set c[158] = "ž"
            set c[159] = "Ÿ"
            set c[160] = " "
            set c[161] = "¡"
            set c[162] = "¢"
            set c[163] = "£"
            set c[164] = "¤"
            set c[165] = "¥"
            set c[166] = "¦"
            set c[167] = "§"
            set c[168] = "¨"
            set c[169] = "©"
            set c[170] = "ª"
            set c[171] = "«"
            set c[172] = "¬"
            set c[174] = "®"
            set c[175] = "¯"
            set c[176] = "°"
            set c[177] = "±"
            set c[178] = "²"
            set c[179] = "³"
            set c[180] = "´"
            set c[181] = "µ"
            set c[182] = "¶"
            set c[183] = "·"
            set c[184] = "¸"
            set c[185] = "¹"
            set c[186] = "º"
            set c[187] = "»"
            set c[188] = "¼"
            set c[189] = "½"
            set c[190] = "¾"
            set c[191] = "¿"
            set c[192] = "À"
            set c[193] = "Á"
            set c[194] = "Â"
            set c[195] = "Ã"
            set c[196] = "Ä"
            set c[197] = "Å"
            set c[198] = "Æ"
            set c[199] = "Ç"
            set c[200] = "È"
            set c[201] = "É"
            set c[202] = "Ê"
            set c[203] = "Ë"
            set c[204] = "Ì"
            set c[205] = "Í"
            set c[206] = "Î"
            set c[207] = "Ï"
            set c[208] = "Ð"
            set c[209] = "Ñ"
            set c[210] = "Ò"
            set c[211] = "Ó"
            set c[212] = "Ô"
            set c[213] = "Õ"
            set c[214] = "Ö"
            set c[215] = "×"
            set c[216] = "Ø"
            set c[217] = "Ù"
            set c[218] = "Ú"
            set c[219] = "Û"
            set c[220] = "Ü"
            set c[221] = "Ý"
            set c[222] = "Þ"
            set c[223] = "ß"
            set c[224] = "à"
            set c[225] = "á"
            set c[226] = "â"
            set c[227] = "ã"
            set c[228] = "ä"
            set c[229] = "å"
            set c[230] = "æ"
            set c[231] = "ç"
            set c[232] = "è"
            set c[233] = "é"
            set c[234] = "ê"
            set c[235] = "ë"
            set c[236] = "ì"
            set c[237] = "í"
            set c[238] = "î"
            set c[239] = "ï"
            set c[240] = "ð"
            set c[241] = "ñ"
            set c[242] = "ò"
            set c[243] = "ó"
            set c[244] = "ô"
            set c[245] = "õ"
            set c[246] = "ö"
            set c[247] = "÷"
            set c[248] = "ø"
            set c[249] = "ù"
            set c[250] = "ú"
            set c[251] = "û"
            set c[252] = "ü"
            set c[253] = "ý"
            set c[254] = "þ"
            set c[255] = "ÿ"
        endmethod
    endmodule
    private struct Inits extends array
        implement Init
    endstruct
endlibrary

/**
 * Simple Save/Load system which converts decimal numbers into numbers from SAVE_CODE_DIGITS.
 * It starts with the player name's hash, so you can only use your own savecodes in multiplayer games etc.
 * Besides, the settings are stored. All numbers are separated by a separator character.
 * It adds a final checksum of the savecode to make it harder to fake any savecode by just replacing certain values of it.
 * If it ends with separators it will be compressed by removing separator characters from the end.
 * TODO Store stats for the multiboard to show what a player has achieved. This could also be useful for online leaderboards.
 */
function GetSaveCode takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))
    local integer heroLevel = GetHeroLevel(udg_Held[GetConvertedPlayerId(whichPlayer)])
    local integer xp = GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])
    local integer gold = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
    local integer lumber = GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
    local integer evolutionLevel = GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
    local integer powerGeneratorLevel = GetPlayerTechCountSimple(UPG_IMPROVED_POWER_GENERATOR, whichPlayer)
    local integer handOfGodLevel = GetPlayerTechCountSimple(UPG_IMPROVED_HAND_OF_GOD, whichPlayer)
    local integer mountLevel = GetPlayerTechCountSimple(UPG_IMPROVED_MOUNT, whichPlayer)
    local integer masonryLevel = GetPlayerTechCountSimple(UPG_IMPROVED_MASONRY, whichPlayer)
    local integer heroKills = GetPlayerScore(whichPlayer, PLAYER_SCORE_HEROES_KILLED)
    local integer heroDeaths = udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)]
    local integer unitKills = GetPlayerScore(whichPlayer, PLAYER_SCORE_UNITS_KILLED)
    local integer unitDeaths =  udg_UnitsLost[GetConvertedPlayerId(whichPlayer)]
    local integer buildingsRazed = GetPlayerScore(whichPlayer, PLAYER_SCORE_STRUCT_RAZED)
    local integer totalBossKills = udg_BossKills[GetConvertedPlayerId(whichPlayer)]
    local integer heroLevel2 = GetHeroLevel(udg_Held2[GetConvertedPlayerId(whichPlayer)])
    local integer xp2 = GetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)])
    local integer heroLevel3 = GetHeroLevel(udg_Held3[GetConvertedPlayerId(whichPlayer)])
    local integer xp3 = GetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)])
    local integer improvedNavyLevel = GetPlayerTechCountSimple(UPG_IMPROVED_NAVY, whichPlayer)
    local integer improvedCreepHunterLevel = GetPlayerTechCountSimple(UPG_IMPROVED_CREEP_HUNTER, whichPlayer)
    local integer equipmentBags = CountUnitsInGroup(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])

    if (udg_Held[GetConvertedPlayerId(whichPlayer)] == null) then
        set xp = udg_CharacterStartXP[GetConvertedPlayerId(whichPlayer)]
        set heroLevel = GetHeroLevelByXP(xp)
    endif

    if (udg_Held2[GetConvertedPlayerId(whichPlayer)] == null) then
        set xp2 = udg_Held2XP[GetConvertedPlayerId(whichPlayer)]
        set heroLevel2 = GetHeroLevelByXP(xp2)
    endif

    if (udg_Held3[GetConvertedPlayerId(whichPlayer)] == null) then
        set xp3 = udg_Held3XP[GetConvertedPlayerId(whichPlayer)]
        set heroLevel3 = GetHeroLevelByXP(xp3)
    endif

    return GetSaveCodeEx(whichPlayer, GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, heroLevel, xp, gold, lumber, evolutionLevel, powerGeneratorLevel, handOfGodLevel, mountLevel, masonryLevel, heroKills, heroDeaths, unitKills, unitDeaths, buildingsRazed, totalBossKills, heroLevel2, xp2, heroLevel3, xp3, improvedNavyLevel, improvedCreepHunterLevel, GetSaveCodeDemigodValue(whichPlayer), equipmentBags)
endfunction

function ReadSaveCode takes string saveCode, integer hash returns string
    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Deobfuscating with the hash!")
        return ConvertSaveCodeFromObfuscatedVersion(saveCode, hash)
    endif

    //call BJDebugMsg("Just returning!")

    return saveCode
endfunction

function SetPlayerStateIfHigher takes player whichPlayer, playerstate playerState, integer value returns boolean
    if (value > GetPlayerState(whichPlayer, playerState)) then
        call SetPlayerStateBJ(whichPlayer, playerState, value)
        return true
    endif

    return false
endfunction

function SetPlayerTechResearchedIfHigher takes player whichPlayer, integer techId, integer level returns boolean
    if (level > GetPlayerTechCountSimple(techId, whichPlayer)) then
        call SetPlayerTechResearched(whichPlayer, techId, level)
        return true
    endif

    return false
endfunction

function DisplaySaveCodeError takes player whichPlayer, string message returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, message)
endfunction

function DisplaySaveCodeErrorAtLeastOne takes player whichPlayer, boolean atLeastOne returns nothing
    if (not atLeastOne) then
        call DisplaySaveCodeError(whichPlayer, "Empty savecode!")
    endif
endfunction

function DisplaySaveCodeErrorLowerResearch takes player whichPlayer, integer techId returns nothing
    call DisplaySaveCodeError(whichPlayer, "Not loading research " + GetObjectName(techId) + " since your current level is higher or equal!")
endfunction

function DisplaySaveCodeErrorSameGame takes player whichPlayer returns nothing
    call DisplaySaveCodeError(whichPlayer, "Savecode from the same game!")
endfunction

function RemoveEquipmentBags takes player whichPlayer returns nothing
    local integer max = BlzGroupGetSize(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    local unit equipmentBag = null
    local integer i = 0
    loop
        exitwhen (i >= max)
        set equipmentBag = BlzGroupUnitAt(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], i)
        call DropAllItemsFromHero(equipmentBag)
        call DisableItemCraftingUnit(equipmentBag)
        call RemoveUnit(equipmentBag)
        set equipmentBag = null
        set i = i + 1
    endloop
    call GroupClear(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
endfunction

globals
    constant integer MAX_EQUIPMENT_BAGS = 3
endglobals

function CreateEquipmentBags takes player whichPlayer, integer equipmentBags returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local unit equipmentBag = null
    local string equipmentBagName = ""
    local integer i = 0
    loop
        exitwhen (i >= equipmentBags or i >= MAX_EQUIPMENT_BAGS)
        set equipmentBag = CreateUnit(whichPlayer, 'E00R', GetUnitX(udg_Hero[playerId]),  GetUnitY(udg_Hero[playerId]), bj_UNIT_FACING)
        call SuspendHeroXPBJ(false, equipmentBag)
        call GroupAddUnit(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)], equipmentBag)
        call UnitRemoveAbility(equipmentBag, 'A02N')
        call UnitAddAbility(equipmentBag, 'AInv')
        set equipmentBagName = "Equipment Backpack " + I2S(CountUnitsInGroup(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)]))
        call BlzSetUnitName(equipmentBag, equipmentBagName)
        call BlzSetHeroProperName(equipmentBag, equipmentBagName)
        call EnableItemCraftingUnit(equipmentBag)
        set i = i + 1
    endloop
endfunction

function RecreateEquipmentBags takes player whichPlayer, integer equipmentBags returns nothing
    call RemoveEquipmentBags(whichPlayer)
    call CreateEquipmentBags(whichPlayer, equipmentBags)
endfunction

function RecreateAllEquipmentBags takes player whichPlayer returns nothing
    local integer count = CountUnitsInGroup(udg_EquipmentBags[GetConvertedPlayerId(whichPlayer)])
    call RecreateEquipmentBags(whichPlayer, count)
endfunction

function ApplySaveCode takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer improvedCreepHunterLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 23)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
            if (demigodValue == 1) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
                if (udg_Held[GetConvertedPlayerId(whichPlayer)] != null) then
                    set udg_TmpUnit = udg_Held[GetConvertedPlayerId(whichPlayer)]
                    call TriggerExecute(gg_trg_Become_Demigod_Light)
                endif
            elseif (demigodValue == 2) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
                if (udg_Held[GetConvertedPlayerId(whichPlayer)] != null) then
                    set udg_TmpUnit = udg_Held[GetConvertedPlayerId(whichPlayer)]
                    call TriggerExecute(gg_trg_Become_Demigod_Dark)
                endif
            elseif (demigodValue == 3) then
                call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_DEMIGOD, 1)
            endif

            call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
            call SetPlayerStateBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_EVOLUTION, evolutionLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_CHEAP_EVOLUTION, evolutionLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_POWER_GENERATOR, powerGeneratorLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_HAND_OF_GOD, handOfGodLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MOUNT, mountLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_MASONRY, masonryLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_NAVY, improvedNavyLevel)
            call SetPlayerTechResearchedIfHigher(whichPlayer, UPG_IMPROVED_CREEP_HUNTER, improvedCreepHunterLevel)

            set udg_HeroKills[GetConvertedPlayerId(whichPlayer)] = heroKills
            set udg_HeroDeaths[GetConvertedPlayerId(whichPlayer)] = heroDeaths
            set udg_UnitKills[GetConvertedPlayerId(whichPlayer)] = unitKills
            set udg_UnitsLost[GetConvertedPlayerId(whichPlayer)] = unitDeaths
            set udg_BuildingsRazed[GetConvertedPlayerId(whichPlayer)] = buildingsRazed
            set udg_BossKills[GetConvertedPlayerId(whichPlayer)] = totalBossKills

            if (udg_Held[GetConvertedPlayerId(whichPlayer)] != null and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
                call SetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)], xp, true)
            endif

            if (udg_Held[GetConvertedPlayerId(whichPlayer)] == null and xp > udg_CharacterStartXP[GetConvertedPlayerId(whichPlayer)]) then
                set udg_CharacterStartXP[GetConvertedPlayerId(whichPlayer)] = xp
                set udg_TmpPlayer = whichPlayer
                set udg_TmpInteger = GetHeroLevelByXP(xp)
                call TriggerExecute(gg_trg_Hero_Journey_Update_from_Level)
            endif

            if (udg_Held2[GetConvertedPlayerId(whichPlayer)] != null and xp2 > GetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)])) then
                call SetHeroXP(udg_Held2[GetConvertedPlayerId(whichPlayer)], xp2, true)
            endif

            if (udg_Held2[GetConvertedPlayerId(whichPlayer)] == null and xp2 > udg_Held2XP[GetConvertedPlayerId(whichPlayer)]) then
                set udg_Held2XP[GetConvertedPlayerId(whichPlayer)] = xp2
            endif

            if (udg_Held3[GetConvertedPlayerId(whichPlayer)] != null and xp3 > GetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)])) then
                call SetHeroXP(udg_Held3[GetConvertedPlayerId(whichPlayer)], xp3, true)
            endif

            if (udg_Held3[GetConvertedPlayerId(whichPlayer)] == null and xp3 > udg_Held3XP[GetConvertedPlayerId(whichPlayer)]) then
                set udg_Held3XP[GetConvertedPlayerId(whichPlayer)] = xp3
            endif

            call RecreateEquipmentBags(whichPlayer, equipmentBags)

            return true
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeErrors takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set result = result + "Expected different checksum!"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected different player name!"
    endif

    if (isSinglePlayer != IsInSinglePlayer()) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isSinglePlayer) then
            set result = result + "Expected singleplayer!"
        else
            set result = result + "Expected multiplayer!"
        endif
    endif

    if (gameType != udg_GameType) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected game type: " + I2S(gameType)
    endif

    if (isWarlord != udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        if (isWarlord) then
            set result = result + "Expected game mode Warlord!"
        else
            set result = result + "Expected game mode Freelancer!"
        endif
    endif

    if (xpRate != R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected XP rate: " + I2S(xpRate)
    endif

    if (xp <= GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected more XP than your current!"
    endif

    if (checksum == CompressedAbsStringHash(saveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer)) and xp > GetHeroXP(udg_Held[GetConvertedPlayerId(whichPlayer)])) then
        set result = "None errors detected. Stored " + I2S(xp) + "XP."
    endif

    return result
endfunction

function AppendSaveCodeInfo takes string result, string appended returns string
    if (StringLength(result) > 0) then
        set result = result + "|n"
    endif

    return result + appended
endfunction

function GetSaveCodeInfos takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerName = GetPlayerName(whichPlayer)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer improvedCreepHunterLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 23)
    local string result = ""
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif


    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))
    set result = AppendSaveCodeInfo(result, "XP: " + I2S(xp))
    set result = AppendSaveCodeInfo(result, "Demigod: " + demigodValueInfo)
    set result = AppendSaveCodeInfo(result, "XP 2: " + I2S(xp2))
    set result = AppendSaveCodeInfo(result, "XP 3: " + I2S(xp3))
    set result = AppendSaveCodeInfo(result, "Gold: " + I2S(gold))
    set result = AppendSaveCodeInfo(result, "Lumber: " + I2S(lumber))
    set result = AppendSaveCodeInfo(result, "Evolution: " + I2S(evolutionLevel))
    set result = AppendSaveCodeInfo(result, "Power Generator: " + I2S(powerGeneratorLevel))
    set result = AppendSaveCodeInfo(result, "Hand of God: " + I2S(handOfGodLevel))
    set result = AppendSaveCodeInfo(result, "Mount: " + I2S(mountLevel))
    set result = AppendSaveCodeInfo(result, "Masonry: " + I2S(masonryLevel))
    set result = AppendSaveCodeInfo(result, "Navy: " + I2S(improvedNavyLevel))
    set result = AppendSaveCodeInfo(result, "Creep Hunter: " + I2S(improvedCreepHunterLevel))
    set result = AppendSaveCodeInfo(result, "Equipment Bags: " + I2S(equipmentBags))
    set result = AppendSaveCodeInfo(result, "Hero Kills: " + I2S(heroKills))
    set result = AppendSaveCodeInfo(result, "Hero Deaths: " + I2S(heroDeaths))
    set result = AppendSaveCodeInfo(result, "Hero Kills: " + I2S(unitKills))
    set result = AppendSaveCodeInfo(result, "Unit Deaths: " + I2S(unitDeaths))
    set result = AppendSaveCodeInfo(result, "Buildings Razed: " + I2S(buildingsRazed))
    set result = AppendSaveCodeInfo(result, "Boss kills: " + I2S(totalBossKills))

    return result
endfunction

function GetSaveCodeShortInfos takes string playerName, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer improvedCreepHunterLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 23)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif


    if (playerNameHash != CompressedAbsStringHash(playerName)) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    return singlePlayerStatus + "-" + gameTypeName + "-" + warlordStatus + "-l1_" + I2S(GetHeroLevelByXP(xp)) + "-l2_" + I2S(GetHeroLevelByXP(xp2)) + "-l3_" + I2S(GetHeroLevelByXP(xp3)) + "-g_" + I2S(gold) + "-l_" + I2S(lumber) + "-e_" + I2S(evolutionLevel)
endfunction

function GetSaveCodeIsMatching takes player whichPlayer, string s returns boolean
    local string playerName = GetPlayerName(whichPlayer)
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer improvedCreepHunterLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 23)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    return isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))
endfunction

function GetSaveCodeMaxHeroLevel takes string playerName, string s returns integer
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer xp = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer evolutionLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer powerGeneratorLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer handOfGodLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer mountLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer masonryLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer heroKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer heroDeaths = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer unitKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer unitDeaths =  ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer buildingsRazed = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer totalBossKills = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer xp2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer xp3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer improvedNavyLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer improvedCreepHunterLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer demigodValue = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local string demigodValueInfo = ConvertSaveCodeDemigodValueToInfo(demigodValue)
    local integer equipmentBags = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 23)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (xp2 > xp and xp2 > xp3) then
        return GetHeroLevelByXP(xp2)
    elseif (xp3 > xp and xp3 > xp2) then
        return GetHeroLevelByXP(xp3)
    endif

    return GetHeroLevelByXP(xp)
endfunction

// TODO Create a system SaveCodeObjectSystem depending on the SaveCodeSystem which allows registering any IDs in a 2D array.
library SaveCodeObjectSystem requires SaveCodeSystem

globals
    string array SaveObjectNameUnit
    integer array SaveObjectIdUnit
    integer SaveObjectUnitCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameBuilding
    integer array SaveObjectIdBuilding
    integer SaveObjectBuildingCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameItem
    integer array SaveObjectIdItem
    integer SaveObjectItemCounter = 1 // start with 1 so 0 won't lead to anything

    string array SaveObjectNameResearch
    integer array SaveObjectIdResearch
    integer SaveObjectResearchCounter = 1 // start with 1 so 0 won't lead to anything
endglobals

function DisplaySaveObjectCounters takes nothing returns nothing
    call BJDebugMsg("Save Object Unit Counter: " + I2S(SaveObjectUnitCounter))
    call BJDebugMsg("Save Object Building Counter: " + I2S(SaveObjectBuildingCounter))
    call BJDebugMsg("Save Object Item Counter: " + I2S(SaveObjectItemCounter))
    call BJDebugMsg("Save Object Research Counter: " + I2S(SaveObjectResearchCounter))
endfunction

function DisplayDuplicateSaveObjects takes nothing returns nothing
    local integer j
    local integer i = 0
    call BJDebugMsg("Save Object Duplicates:")
    loop
        exitwhen (i == SaveObjectUnitCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectUnitCounter)
            if (i != j and SaveObjectIdUnit[i] == SaveObjectIdUnit[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdUnit[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectBuildingCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectBuildingCounter)
            if (i != j and SaveObjectIdBuilding[i] == SaveObjectIdBuilding[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdBuilding[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectItemCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectItemCounter)
            if (i != j and SaveObjectIdItem[i] == SaveObjectIdItem[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdItem[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == SaveObjectResearchCounter)
        set j = 0
        loop
            exitwhen (j == SaveObjectResearchCounter)
            if (i != j and SaveObjectIdResearch[i] == SaveObjectIdResearch[j]) then
                call BJDebugMsg("Duplicated save object " + GetObjectName(SaveObjectIdResearch[i]) + " with indices " + I2S(i) + " and " + I2S(j))
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function AddSaveObjectUnitTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectUnitCounter
    set SaveObjectNameUnit[index] = name
    set SaveObjectIdUnit[index] = id
    set SaveObjectUnitCounter = SaveObjectUnitCounter + 1
    return index
endfunction

function AddSaveObjectBuildingTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectBuildingCounter
    set SaveObjectNameBuilding[index] = name
    set SaveObjectIdBuilding[index] = id
    set SaveObjectBuildingCounter = SaveObjectBuildingCounter + 1
    return index
endfunction

function AddSaveObjectUnitType takes nothing returns integer
    if (IsUnitIdType(udg_TmpUnitType, UNIT_TYPE_STRUCTURE)) then
        return AddSaveObjectBuildingTypeEx(GetObjectName(udg_TmpUnitType), udg_TmpUnitType)
    else
        return AddSaveObjectUnitTypeEx(GetObjectName(udg_TmpUnitType), udg_TmpUnitType)
    endif
endfunction

function GetSaveObjectUnitType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectUnitCounter)
        if (SaveObjectIdUnit[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectUnitId takes integer number returns integer
    return SaveObjectIdUnit[number]
endfunction

function GetSaveObjectBuildingType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectBuildingCounter)
        if (SaveObjectIdBuilding[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectBuildingId takes integer number returns integer
    return SaveObjectIdBuilding[number]
endfunction

function AddSaveObjectItemTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectItemCounter
    set SaveObjectNameItem[index] = name
    set SaveObjectIdItem[index] = id
    set SaveObjectItemCounter = SaveObjectItemCounter + 1
    return index
endfunction

function AddSaveObjectItemType takes nothing returns integer
    return AddSaveObjectItemTypeEx(GetObjectName(udg_TmpItemTypeId), udg_TmpItemTypeId)
endfunction

function GetSaveObjectItemType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectItemCounter)
        if (SaveObjectIdItem[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectItemId takes integer number returns integer
    return SaveObjectIdItem[number]
endfunction

function AddSaveObjectResearchTypeEx takes string name, integer id returns integer
    local integer index = SaveObjectResearchCounter
    set SaveObjectNameResearch[index] = name
    set SaveObjectIdResearch[index] = id
    set SaveObjectResearchCounter = SaveObjectResearchCounter + 1
    return index
endfunction

function AddSaveObjectResearch takes nothing returns integer
    return AddSaveObjectResearchTypeEx(GetObjectName(udg_TmpTechType), udg_TmpTechType)
endfunction

function GetSaveObjectResearchType takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i == SaveObjectResearchCounter)
        if (SaveObjectIdResearch[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetSaveObjectResearchId takes integer number returns integer
    return SaveObjectIdResearch[number]
endfunction

endlibrary

function CreateSaveCodeBuildingsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer buildings, string buildingNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadb " + saveCode)
    set content = content + AppendFileContent("Buildings: " + I2S(buildings))
    set content = content + AppendFileContent("Building Names: " + buildingNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-buildings-" + I2S(buildings) + "-" + buildingNames + ".txt")
endfunction

globals
    constant integer SAVE_CODE_MAX_BUILDINGS = 8
endglobals

function FilterIsLivingBuildingToBeSaved takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetSaveObjectBuildingType(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

function GetPlayerBuildingsOrderedByPriority takes player whichPlayer returns group
    local group whichGroup = CreateGroup()
    local group buildingsToBeSaved = GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingBuildingToBeSaved))
    local unit first = null
    call GroupAddGroup(udg_SaveCodeIncludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)
    loop
        set first = FirstOfGroup(buildingsToBeSaved)
        exitwhen (first == null)
        if (not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(buildingsToBeSaved, first)
    endloop

    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)

    call GroupClear(buildingsToBeSaved)
    call DestroyGroup(buildingsToBeSaved)
    set buildingsToBeSaved = null

    return whichGroup
endfunction

function GetAbsCoordinate takes real coordinate, real min returns real
    return RAbsBJ(min) + coordinate
endfunction

function GetAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = GetAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function GetAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = GetAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function ConvertAbsCoordinate takes real coordinate, real min returns real
    return coordinate - RAbsBJ(min)
endfunction

function ConvertAbsCoordinateX takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real x = ConvertAbsCoordinate(coordinate, GetRectMinX(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return x
endfunction

function ConvertAbsCoordinateY takes real coordinate returns real
    local rect worldBounds = GetWorldBounds()
    local real y = ConvertAbsCoordinate(coordinate, GetRectMinY(worldBounds))
    call RemoveRect(worldBounds)
    set worldBounds = null

    return y
endfunction

function GetSaveCodeBuildingsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner, group b returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local group buildings = CopyGroup(b)
    local unit first = null
    local integer id = -1
    local integer i = 0
    local integer buildingsCounter = 0
    local string buildingNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    //call BJDebugMsg("Size of buildings: " + I2S(CountUnitsInGroup(buildings)))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    // 5 buildings with their locations
    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set first = FirstOfGroup(buildings)
        exitwhen (first == null)
        set id = GetSaveObjectBuildingType(GetUnitTypeId(first))
        if (id != -1) then
            //call BJDebugMsg("Saving building: " + GetObjectName(GetUnitTypeId(first)))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitX(first))))
            //call BJDebugMsg("Saving building X: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitX(first)))
            //call BJDebugMsg("Saving building X (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateX(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateX(GetUnitX(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + I2S(R2I(GetUnitY(first))))
            //call BJDebugMsg("Saving building Y: " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetUnitY(first)))
            //call BJDebugMsg("Saving building Y (absolute): " + GetObjectName(GetUnitTypeId(first)) + ": " + R2S(GetAbsCoordinateY(GetUnitX(first))))
            set result = result + ConvertDecimalNumberToSaveCodeSegment(R2I(GetAbsCoordinateY(GetUnitY(first))))
            set buildingsCounter = buildingsCounter + 1
            if (buildingNames != "") then
                set buildingNames = buildingNames + ","
            endif
            set buildingNames = buildingNames + GetUnitName(first)
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        call GroupRemoveUnit(buildings, first)
        set first = null
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_BUILDINGS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    call GroupClear(buildings)
    call DestroyGroup(buildings)
    set buildings = null

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeBuildingsTextFile(playerName, isSinglePlayer, isWarlord, gameType, buildingsCounter, buildingNames, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeBuildingsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local group buildings = GetPlayerBuildingsOrderedByPriority(owner)
    local string result = GetSaveCodeBuildingsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, owner, buildings)

    call GroupClear(buildings)
    call DestroyGroup(buildings)
    set buildings = null

    return result
endfunction

function GetSaveCodeBuildings takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeBuildingsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function IsObjectFromPlayerRace takes integer objectID, player whichPlayer returns boolean
    local integer objectRace = GetObjectRace(objectID)
    return objectRace == udg_RaceNone or udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(whichPlayer)] or objectRace == udg_PlayerRace[GetConvertedPlayerId(whichPlayer)] or objectRace == udg_PlayerRace2[GetConvertedPlayerId(whichPlayer)]
endfunction

function DisplayObjectRaceLoadSuccess takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, "Successfully loaded " + GetObjectName(objectID) + "!")
endfunction

function DisplayObjectRaceLoadError takes integer objectID, player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 8.0, "Unable to load " + GetObjectName(objectID) + " since it does not belong to your chosen race(s)!")
endfunction

function ApplySaveCodeBuildings takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectBuildingId(saveObject)
                    if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                        set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
                        set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
                        //call BJDebugMsg("Loading building " + GetObjectName(saveObjectId) + " at " + R2S(x) + "|" + R2S(y))
                        call CreateUnit(whichPlayer, saveObjectId, x, y, bj_UNIT_FACING)
                        set atLeastOne = true
                        call PingMinimapForPlayer(whichPlayer, x, y, 4.0)
                        call DisplayObjectRaceLoadSuccess(saveObjectId, whichPlayer)
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 3
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosBuildings takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectBuildingId(saveObject)
            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + R2S(x) + "|" + R2S(y) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + R2S(x) + "|" + R2S(y) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Building Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Building with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 3
    endloop

    return result
endfunction

function GetSaveCodeShortInfosBuildings takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local real x = 0.0
    local real y = 0.0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_BUILDINGS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectBuildingId(saveObject)
            set x = ConvertAbsCoordinateX(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)))
            set y = ConvertAbsCoordinateY(I2R(ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 2)))
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = result + GetObjectName(saveObjectId)
            else
                set result = result + GetObjectName(saveObjectId) + " (not your race!)"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Building Slot"
        else
            set result = result + "Invalid Building with ID "
        endif
        set i = i + 1
        set pos = pos + 3
    endloop

    return singlePlayerStatus + "-" + gameTypeName + "-" + warlordStatus + result
endfunction

function CreateSaveCodeItemsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer items, string itemNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadi " + saveCode)
    set content = content + AppendFileContent("Items: " + I2S(items))
    set content = content + AppendFileContent("Item Names: " + itemNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-items-" + I2S(items)  + "-" + itemNames + ".txt")
endfunction

function GetSaveCodeItemsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, item itemSlot0, item itemSlot1, item itemSlot2, item itemSlot3, item itemSlot4, item itemSlot5 returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local integer id = -1
    local integer itemCounter = 0
    local string itemNames = ""

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    if (itemSlot0 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot0))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot0))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot0)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot0))
        endif
    endif

    if (itemSlot1 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot1))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot1))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot1)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot1))
        endif
    endif

    if (itemSlot2 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot2))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot2))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot2)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot2))
        endif
    endif

    if (itemSlot3 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot3))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot3))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot3)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot3))
        endif
    endif

    if (itemSlot4 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot4))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot4))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot4)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot4))
        endif
    endif

    if (itemSlot5 != null) then
        set id = GetSaveObjectItemType(GetItemTypeId(itemSlot5))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetItemCharges(itemSlot5))
            set itemCounter = itemCounter + 1
            if (itemNames != "") then
                set itemNames = itemNames + ","
            endif
            set itemNames = itemNames + GetItemName(itemSlot5)
        else
            //call BJDebugMsg("Not registered save object type for " + GetItemName(itemSlot5))
        endif
    endif

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeItemsTextFile(playerName, isSinglePlayer, isWarlord, gameType, itemCounter, itemNames, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeItemsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, unit hero returns string
    return GetSaveCodeItemsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, UnitItemInSlot(hero, 0), UnitItemInSlot(hero, 1), UnitItemInSlot(hero, 2), UnitItemInSlot(hero, 3), UnitItemInSlot(hero, 4), UnitItemInSlot(hero, 5))
endfunction


function GetSaveCodeItems takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeItemsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, udg_Hero[GetPlayerId(whichPlayer)])
endfunction

function ApplySaveCodeItems takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local unit hero = udg_Hero[GetPlayerId(whichPlayer)]
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == bj_MAX_INVENTORY)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectItemId(saveObject)
                    if (IsObjectFromPlayerRace(saveObject, whichPlayer)) then
                        call UnitAddItemByIdSwapped(saveObjectId, hero)
                        call SetItemCharges(bj_lastCreatedItem, ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1))
                        set atLeastOne = true
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosItems takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer charges = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectItemId(saveObject)
            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(charges) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(charges) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Item Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosItems takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer charges = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectItemId(saveObject)
            set charges = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = result + GetObjectName(saveObjectId) + " (" + I2S(charges) + ")"
            else
                set result = result + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(charges) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Item Slot"
        else
            set result = result + "Invalid Item with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + gameTypeName + "-" + warlordStatus + result
endfunction

globals
    constant integer SAVE_CODE_MAX_UNITS = 10
endglobals

function FilterIsLivingUnitToBeSaved takes nothing returns boolean
    return not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_ANCIENT) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_SUMMONED) and IsUnitAliveBJ(GetFilterUnit()) and GetUnitTypeId(GetFilterUnit()) != 'o018' and GetUnitTypeId(GetFilterUnit()) != 'o00P' and GetSaveObjectUnitType(GetUnitTypeId(GetFilterUnit())) != -1
endfunction

function CountUnitsOfTypeFromGroup takes group whichGroup, integer unitTypeId returns integer
    local group tmpGroup = CopyGroup(whichGroup)
    local integer i = 0
    local unit first = null
    loop
        set first = FirstOfGroup(tmpGroup)
        exitwhen (first == null)
        if (GetUnitTypeId(first) == unitTypeId) then
            set i = i + 1
        endif
        call GroupRemoveUnit(tmpGroup, first)
    endloop

    call GroupClear(tmpGroup)
    call DestroyGroup(tmpGroup)
    set tmpGroup = null

    return i
endfunction

function DistinctGroup takes group whichGroup returns group
    local group tmpGroup = CopyGroup(whichGroup)
    local group result = CreateGroup()
    local unit first = null
    loop
        set first = FirstOfGroup(tmpGroup)
        exitwhen (first == null)
        if (CountUnitsOfTypeFromGroup(result, GetUnitTypeId(first)) == 0) then
            call GroupAddUnit(result, first)
        endif
        call GroupRemoveUnit(tmpGroup, first)
    endloop

    call GroupClear(tmpGroup)
    call DestroyGroup(tmpGroup)
    set tmpGroup = null

    return result
endfunction

function GetPlayerUnitsOrderedByPriority takes player whichPlayer returns group
    local group whichGroup = CreateGroup()
    local group livingUnitsToBeSaved = GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterIsLivingUnitToBeSaved))
    local unit first = null
    local group result = null
    call GroupAddGroup(udg_SaveCodeIncludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)
    loop
        set first = FirstOfGroup(livingUnitsToBeSaved)
        exitwhen (first == null)
        if (not IsUnitInGroup(first, whichGroup)) then
            call GroupAddUnit(whichGroup, first)
        endif
        call GroupRemoveUnit(livingUnitsToBeSaved, first)
    endloop
    call GroupRemoveGroup(udg_SaveCodeExcludedUnits[GetConvertedPlayerId(whichPlayer)], whichGroup)

    //call BJDebugMsg("Size of units before distinct: " + I2S(CountUnitsInGroup(whichGroup)))

    set result = DistinctGroup(whichGroup)

    //call BJDebugMsg("Size of units after distinct: " + I2S(CountUnitsInGroup(result)))

    call GroupClear(whichGroup)
    call DestroyGroup(whichGroup)
    set whichGroup = null

    call GroupClear(livingUnitsToBeSaved)
    call DestroyGroup(livingUnitsToBeSaved)
    set livingUnitsToBeSaved = null

    return result
endfunction

function CreateSaveCodeUnitsTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer units, string unitNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadu " + saveCode)
    set content = content + AppendFileContent("Units: " + I2S(units))
    set content = content + AppendFileContent("Unit Names: " + unitNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-units-" + I2S(units)  + "-" + unitNames + ".txt")
endfunction

function GetSaveCodeUnitsEx2 takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner, group source returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local group units = CopyGroup(source)
    local unit first = null
    local integer id = -1
    local integer i = 0
    local integer unitsCounter = 0
    local group tmpGroup = null
    local integer count = 0
    local string unitNames = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    set i = 0
    loop
        exitwhen (unitsCounter == SAVE_CODE_MAX_UNITS)
        set first = FirstOfGroup(units)
        exitwhen (first == null)
        set id = GetSaveObjectUnitType(GetUnitTypeId(first))
        if (id != -1) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set tmpGroup = GetUnitsOfPlayerAndTypeId(owner, GetUnitTypeId(first))
            set count = CountUnitsInGroup(tmpGroup)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(count)
            if (unitNames != "") then
                set unitNames = unitNames + ","
            endif
            set unitNames = unitNames + I2S(count) + GetUnitName(first)
            call GroupClear(tmpGroup)
            call DestroyGroup(tmpGroup)
            set tmpGroup = null
            set unitsCounter = unitsCounter + 1
            //call BJDebugMsg("Added " + GetUnitName(first) + " with count " + I2S(count))
        else
            //call BJDebugMsg("Not registered save object type for " + GetUnitName(first))
        endif
        call GroupRemoveUnit(units, first)
        set i = i + 1
    endloop

    // fill rest
    loop
        exitwhen (i >= SAVE_CODE_MAX_UNITS)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    call GroupClear(units)
    call DestroyGroup(units)
    set units = null

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeUnitsTextFile(playerName, isSinglePlayer, isWarlord, gameType, unitsCounter, unitNames, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeUnitsEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local group units = GetPlayerUnitsOrderedByPriority(owner)
    local string result = GetSaveCodeUnitsEx2(playerName, isSinglePlayer, isWarlord, gameType, xpRate, owner, units)

    call GroupClear(units)
    call DestroyGroup(units)
    set units = null

    return result
endfunction


function GetSaveCodeUnits takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeUnitsEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function ForGroupApplyLoadedUnitEvolution takes nothing returns nothing
    set udg_TmpUnit = GetEnumUnit()
    call TriggerExecute(gg_trg_Evolution_Add_Unit_Level_And_Defense_By_Unit)
endfunction

function ApplySaveCodeUnits takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer j = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local location tmpLocation = Location(GetUnitX(udg_Hero[GetPlayerId(whichPlayer)]), GetUnitY(udg_Hero[GetPlayerId(whichPlayer)]))
    local boolean atLeastOne = false
    local group createdUnits = CreateGroup()

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i == SAVE_CODE_MAX_UNITS)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                //call BJDebugMsg("Loading save object: " + I2S(saveObject))
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectUnitId(saveObject)
                    set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                    //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                    set j = 0
                    loop
                        exitwhen (j == count)
                        // the player does not have to build all farms before but the limit should not be exceeded
                        if (GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED) + GetFoodUsed(saveObjectId) <= GetPlayerState(whichPlayer, PLAYER_STATE_FOOD_CAP_CEILING)) then
                            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                                call CreateUnitAtLocSaveLast(whichPlayer, saveObjectId, tmpLocation, GetUnitFacing(udg_Hero[GetPlayerId(whichPlayer)]))
                                call GroupAddUnit(createdUnits, bj_lastCreatedUnit)
                                set atLeastOne = true
                            else
                                call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                            endif
                        else
                            call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetObjectName(saveObjectId) + " exceeds your food maximum and hence is not loaded.")
                        endif
                        set j = j + 1
                    endloop
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call ForGroupBJ(createdUnits, function ForGroupApplyLoadedUnitEvolution)
            call GroupClear(createdUnits)
            call DestroyGroup(createdUnits)
            set createdUnits = null

            call RemoveLocation(tmpLocation)
            set tmpLocation = null

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    call ForGroupBJ(createdUnits, function ForGroupApplyLoadedUnitEvolution)
    call GroupClear(createdUnits)
    call DestroyGroup(createdUnits)
    set createdUnits = null

    return false
endfunction

function GetSaveCodeInfosUnits takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_UNITS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        //call BJDebugMsg("Loading save object: " + I2S(saveObject))
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectUnitId(saveObject)
            set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(count) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(count) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Unit Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Item with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosUnits takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i == SAVE_CODE_MAX_UNITS)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        //call BJDebugMsg("Loading save object: " + I2S(saveObject))
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectUnitId(saveObject)
            set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = result + GetObjectName(saveObjectId) + " (" + I2S(count) + ")"
            else
                set result = result + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(count) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Unit Slot"
        else
            set result = result + "Invalid Item with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + gameTypeName + "-" + warlordStatus + result
endfunction

globals
    constant integer SAVE_CODE_MAX_RESEARCHES = 10
endglobals

function CreateSaveCodeResearchesTextFile takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameTypeNumber, integer researches, string researchNames, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string gameMode = "Freelancer"
    local string gameType = "Normal"
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    if (isWarlord) then
        set gameMode = "Warlord"
    endif

    if (gameTypeNumber == udg_GameTypeEasy) then
        set gameType = "Easy"
    elseif (gameTypeNumber == udg_GameTypeFast) then
        set gameType = "Fast"
    elseif (gameTypeNumber == udg_GameTypeHardcore) then
        set gameType = "Hardcore"
    endif


    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadr " + saveCode)
    set content = content + AppendFileContent("Researches: " + I2S(researches))
    set content = content + AppendFileContent("Research Names: " + researchNames)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-" + singlePlayerFileName + "-" + gameType + "-" + gameMode + "-researches-" + I2S(researches)  + "-" + researchNames + ".txt")
endfunction

function GetSaveCodeResearchesEx takes string playerName, boolean isSinglePlayer, boolean isWarlord, integer gameType, integer xpRate, player owner returns string
    local integer playerNameHash = CompressedAbsStringHash(playerName)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameHash)
    local integer id = -1
    local integer i = 0
    local integer researchesCounter = 0
    local integer count = 0
    local string researchNames = ""

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    set result = result + ConvertDecimalNumberToSaveCodeSegment(GetSinglePlayerAndGameMode(isSinglePlayer, isWarlord))
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gameType)
    set result = result + ConvertDecimalNumberToSaveCodeSegment(xpRate)

    set i = 0
    loop
        exitwhen (researchesCounter == SAVE_CODE_MAX_RESEARCHES or i == SaveObjectResearchCounter)
        set id = GetSaveObjectResearchType(i)
        set count = GetPlayerTechCountSimple(id, owner)
        if (id != -1 and count > 0) then
            set result = result + ConvertDecimalNumberToSaveCodeSegment(id)
            set result = result + ConvertDecimalNumberToSaveCodeSegment(GetPlayerTechCountSimple(id, owner))
            if (researchNames != "") then
                set researchNames = researchNames + ","
            endif
            set researchNames = researchNames + I2S(count) + GetObjectName(id)
            set researchesCounter = researchesCounter + 1
        endif
        set i = i + 1
    endloop

    // fill rest
    set i = researchesCounter
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0)
        set i = i + 1
    endloop

    //call BJDebugMsg("Compressed result: " + result)
    //call BJDebugMsg("Checksum: " + I2S(CompressedAbsStringHash(result)))
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(result)))
    //call BJDebugMsg("Checked save code part: " + result)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameHash)
    endif

    call CreateSaveCodeResearchesTextFile(playerName, isSinglePlayer, isWarlord, gameType, researchesCounter, researchNames, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeResearches takes player whichPlayer returns string
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local boolean isSinglePlayer = IsInSinglePlayer()
    local boolean isWarlord = udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
    local integer gameType = udg_GameType
    local integer xpRate = R2I(GetPlayerHandicapXPBJ(whichPlayer))

    return GetSaveCodeResearchesEx(GetPlayerName(whichPlayer), isSinglePlayer, isWarlord, gameType, xpRate, whichPlayer)
endfunction

function ApplySaveCodeResearches takes player whichPlayer, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local boolean isWarlord = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer count = 0
    local boolean atLeastOne = false

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameHash == CompressedAbsStringHash(GetPlayerName(whichPlayer)) and isSinglePlayer == IsInSinglePlayer() and gameType == udg_GameType and isWarlord == udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)] and xpRate == R2I(GetPlayerHandicapXPBJ(whichPlayer))) then
            set i = 0
            loop
                exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
                set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
                //call BJDebugMsg("Loading save object: " + I2S(saveObject))
                if (saveObject > 0) then
                    set saveObjectId = GetSaveObjectResearchId(saveObject)
                    if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                        set count = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
                        //call BJDebugMsg("Loading save object " + GetObjectName(saveObjectId) + " with number: " + I2S(count))
                        if (not SetPlayerTechResearchedIfHigher(whichPlayer, saveObjectId, count)) then
                            call DisplaySaveCodeErrorLowerResearch(whichPlayer, saveObjectId)
                        endif
                        set atLeastOne = true
                    else
                        call DisplayObjectRaceLoadError(saveObjectId, whichPlayer)
                    endif
                endif
                set i = i + 1
                set pos = pos + 2
            endloop

            call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

            return atLeastOne
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetSaveCodeInfosResearches takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "Multiplayer"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "Freelancer"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer level = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (isWarlord) then
        set warlordStatus = "Warlord"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Game Mode: " + warlordStatus)
    set result = AppendSaveCodeInfo(result, "Player Name: " + playerName)
    set result = AppendSaveCodeInfo(result, "Game Type: " + gameTypeName)
    set result = AppendSaveCodeInfo(result, "XP rate: " + I2S(xpRate))

    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectResearchId(saveObject)
            set level = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (" + I2S(level) + ")")
            else
                set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(level) + ")")
            endif
        elseif (saveObject == 0) then
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Empty Research Slot")
        else
            set result = AppendSaveCodeInfo(result, I2S(i + 1) + " - " + "Invalid Research with ID " + I2S(saveObject))
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return result
endfunction

function GetSaveCodeShortInfosResearches takes player whichPlayer, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(GetPlayerName(whichPlayer)))
    local string playerName = GetPlayerName(whichPlayer)
    local integer playerNameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local integer isSinglePlayerAndWarlord = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer gameType = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local string gameTypeName = GetGameTypeName(gameType)
    local integer xpRate = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local boolean isSinglePlayer = GetSinglePlayerFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string singlePlayerStatus = "M"
    local boolean isWarlord = GetWarlordFromSaveCodeSegment(isSinglePlayerAndWarlord)
    local string warlordStatus = "F"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local integer i = 0
    local integer pos = 4
    local integer saveObject = 0
    local integer saveObjectId = 0
    local integer level = 0
    local string checksumStatus = "Valid"
    local string result = ""

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (playerNameHash != CompressedAbsStringHash(GetPlayerName(whichPlayer))) then
        set playerName = "Not yours"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (isWarlord) then
        set warlordStatus = "W"
    endif

    set i = 0
    loop
        exitwhen (i >= SAVE_CODE_MAX_RESEARCHES)
        set saveObject = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos)
        set result = result + "-"
        if (saveObject > 0) then
            set saveObjectId = GetSaveObjectResearchId(saveObject)
            set level = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, pos + 1)
            if (IsObjectFromPlayerRace(saveObjectId, whichPlayer)) then
                set result = result + GetObjectName(saveObjectId) + " (" + I2S(level) + ")"
            else
                set result = result + GetObjectName(saveObjectId) + " (not your race!) (" + I2S(level) + ")"
            endif
        elseif (saveObject == 0) then
            set result = result + "Empty Research Slot"
        else
            set result = result + "Invalid Research with ID " + I2S(saveObject)
        endif
        set i = i + 1
        set pos = pos + 2
    endloop

    return singlePlayerStatus + "-" + gameTypeName + "-" + warlordStatus + result
endfunction

// Clan System

globals
    constant integer SAVE_CODE_MAX_CLAN_MEMBERS = 6

    constant integer UPG_HERO_CLAN = 'R03D'
    constant integer UPG_IMPROVED_CLAN_HALL = 'R03C'
    constant integer UPG_IMPROVED_CLAN = 'R03B'
    constant integer UPG_CLAN_HAS_NO_AI_PLAYER = 'R046'

    sound array clanSound
    string array clanSoundFilePath
    integer clanSoundIndex = 0
endglobals

function AddClanSoundEx takes sound whichSound, string soundPath returns integer
    set clanSoundIndex = clanSoundIndex + 1
    set clanSound[clanSoundIndex] = whichSound
    set clanSoundFilePath[clanSoundIndex] = soundPath

    return clanSoundIndex
endfunction

function AddClanSound takes nothing returns integer
    return AddClanSoundEx(udg_TmpSound, udg_TmpString)
endfunction

function GetClanSoundIndex takes sound whichSound returns integer
    local integer i = 0
    loop
        exitwhen (i > clanSoundIndex)
        if (clanSound[i] == whichSound) then
            return i
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function GetClanSoundName takes integer whichSound returns string
    return clanSoundFilePath[whichSound]
endfunction

function GetClanRankName takes integer rank returns string
    if (rank == udg_ClanRankLeader) then
        return "Leader"
    elseif (rank == udg_ClanRankCaptain) then
        return "Captain"
    else
        return "Member"
    endif
endfunction

globals
    timer clanResourceTimer = CreateTimer()
    boolean clanResourceTimerStarted = false
endglobals

function TimerFunctionClanResources takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local integer gold = 0
    local integer lumber = 0
    loop
        exitwhen (i == udg_ClanCounter)
        if (udg_ClanAIPlayer[i] != null) then
            set gold = IMinBJ(100, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD))
            set lumber = IMinBJ(100, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER))

            set j = 0
            loop
                exitwhen (j == bj_MAX_PLAYERS)
                if (IsPlayerInForce(Player(j), udg_ClanPlayers[i])) then
                    if (gold > 0) then
                        call SetPlayerStateBJ(Player(j), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(j), PLAYER_STATE_RESOURCE_GOLD) + gold / CountPlayersInForceBJ(udg_ClanPlayers[i]))
                    endif
                    if (lumber > 0) then
                        call SetPlayerStateBJ(Player(j), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(j), PLAYER_STATE_RESOURCE_LUMBER) + lumber / CountPlayersInForceBJ(udg_ClanPlayers[i]))
                    endif
                    if (udg_ClanShowAIResourcesMessage[GetConvertedPlayerId(Player(i))] and gold > 0 or lumber > 0) then
                        call DisplayTextToPlayer(Player(j), 0, 0, GetPlayerNameColored(udg_ClanAIPlayer[i]) + " gave your clan " + I2S(gold) + " gold and " + I2S(lumber) + " lumber which has been split amongst all online clan players. Enter \"-clanaioff\" to hide these messages.")
                    endif
                endif
                set j = j + 1
            endloop

            // do not remove the resources to limit the player
            //if (gold > 0) then
                //call SetPlayerStateBJ(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_GOLD) - gold)
            //endif
            //if (lumber > 0) then
                //call SetPlayerStateBJ(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(udg_ClanAIPlayer[i], PLAYER_STATE_RESOURCE_LUMBER) - lumber)
            //endif
        endif
        set i = i + 1
    endloop
endfunction

// Chooses one AI player to share gold and lumber with all clan players every X seconds.
function PickClanAIPlayer takes integer clan returns player
    local player result = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (Player(i) != udg_BossesPlayer and Player(i) != udg_TheBurningLegion and Player(i) != udg_TheAlliance and GetPlayerController(Player(i)) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
            if (result == null) then
                set result = Player(i)
            // prefer warlords due to more gold and lumber
            elseif (result != null and udg_PlayerIsWarlord[GetConvertedPlayerId(Player(i))] and not udg_PlayerIsWarlord[GetConvertedPlayerId(result)]) then
                set result = Player(i)
            endif
        endif
        set i = i + 1
    endloop

    if (result != null) then
        set udg_ClanAIPlayer[clan] = result
        call TimerStart(clanResourceTimer, 300.0, true, function TimerFunctionClanResources)
        set i = 0
        loop
            exitwhen (i == bj_MAX_PLAYERS)
            if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
                set udg_ClanShowAIResourcesMessage[GetConvertedPlayerId(Player(i))] = true
            endif
            set i = i + 1
        endloop
    endif

    return result
endfunction

function GetClanPlayerNames takes integer clan returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
            if (counter > 0) then
                set result = result + ", "
            endif
            set result = result + GetPlayerNameColored(Player(i))
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetClansInfo takes nothing returns string
    local string result = "Clans:\n"
    local integer i = 1
    loop
        exitwhen (i >= udg_ClanCounter)
        set result = result + "- " + udg_ClanName[i] + " (" + I2S(CountPlayersInForceBJ(udg_ClanPlayers[i])) + " player(s): " + GetClanPlayerNames(i) + ")\n"
        set i = i + 1
    endloop
    return result
endfunction

function AppendClanSaveCodeMember takes string members, string playerName, integer playerRank returns string
    if (StringLength(playerName) > 0) then
        if (StringLength(members) > 0) then
            set members = members + ", "
        endif

        return members + playerName + "_" + GetClanRankName(playerRank)
    endif

    return members
endfunction

function CreateSaveCodeClanTextFile takes boolean isSinglePlayer, string clanName, integer icon, integer clanSoundIndex, integer gold, integer lumber, integer improvedClanHallLevel, integer improvedClanLevel, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6, string saveCode returns nothing
    local string singleplayer = "no"
    local string singlePlayerFileName = "Multiplayer"
    local string leader = ""
    local string members = ""
    local string content = ""

    if (isSinglePlayer) then
        set singleplayer = "yes"
        set singlePlayerFileName = "Singleplayer"
    endif

    set members = AppendClanSaveCodeMember(members, playerName0, playerRank0)

    if (playerRank0 == udg_ClanRankLeader) then
        set leader = playerName0
    endif

    set members = AppendClanSaveCodeMember(members, playerName1, playerRank1)

    if (playerRank1 == udg_ClanRankLeader) then
        set leader = playerName1
    endif

    set members = AppendClanSaveCodeMember(members, playerName2, playerRank2)

    if (playerRank2 == udg_ClanRankLeader) then
        set leader = playerName2
    endif

    set members = AppendClanSaveCodeMember(members, playerName3, playerRank3)

    if (playerRank3 == udg_ClanRankLeader) then
        set leader = playerName3
    endif

    set members = AppendClanSaveCodeMember(members, playerName4, playerRank4)

    if (playerRank4 == udg_ClanRankLeader) then
        set leader = playerName4
    endif

    set members = AppendClanSaveCodeMember(members, playerName5, playerRank5)

    if (playerRank5 == udg_ClanRankLeader) then
        set leader = playerName5
    endif


    set members = AppendClanSaveCodeMember(members, playerName6, playerRank6)

    if (playerRank6 == udg_ClanRankLeader) then
        set leader = playerName6
    endif

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code: -loadc " + saveCode + " " + clanName)
    set content = content + AppendFileContent("Singleplayer: " + singleplayer)
    set content = content + AppendFileContent("Name: " + clanName)
    set content = content + AppendFileContent("Icon: " + GetObjectName(icon))
    set content = content + AppendFileContent("Sound: " + GetClanSoundName(clanSoundIndex))
    set content = content + AppendFileContent("Leader: " + leader)
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Members: " + members)
    set content = content + AppendFileContent("Gold: " + I2S(gold))
    set content = content + AppendFileContent("Lumber: " + I2S(lumber))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    set content = ""
    set content = content + AppendFileContent("Improved Clan Hall Level: " + I2S(improvedClanHallLevel))
    set content = content + AppendFileContent("Improved Clan Level: " + I2S(improvedClanLevel))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-Clan-" + clanName + "-" + playerName0 + "-" + singlePlayerFileName + "-gold-" + I2S(gold) + "-lumber-" + I2S(lumber) + "-" + members + ".txt")
endfunction

function GetSaveCodeClanEx takes boolean isSinglePlayer, string clanName, integer icon, sound whichSound, integer gold, integer lumber, boolean hasAIPlayer, integer improvedClanHallLevel, integer improvedClanLevel, string playerName0, integer playerRank0, string playerName1, integer playerRank1, string playerName2, integer playerRank2, string playerName3, integer playerRank3, string playerName4, integer playerRank4, string playerName5, integer playerRank5, string playerName6, integer playerRank6 returns string
    local string result = ""
    local integer clanSoundIndex = GetClanSoundIndex(whichSound)

    //call BJDebugMsg("Size of units: " + I2S(CountUnitsInGroup(units)))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (isSinglePlayer) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0) // 0
    else
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1) // 0
    endif
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(clanName)) // 1
    set result = result + ConvertDecimalNumberToSaveCodeSegment(icon) // 2
    set result = result + ConvertDecimalNumberToSaveCodeSegment(clanSoundIndex) // 3
    set result = result + ConvertDecimalNumberToSaveCodeSegment(gold) // 4
    set result = result + ConvertDecimalNumberToSaveCodeSegment(lumber) // 5
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedClanHallLevel) // 6
    set result = result + ConvertDecimalNumberToSaveCodeSegment(improvedClanLevel) // 7
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName0)) // 8
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank0) // 9
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName1)) // 10
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank1) // 11
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName2)) // 12
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank2) // 13
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName3)) // 14
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank3) // 15
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName4)) // 16
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank4) // 17
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName5)) // 18
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank5) // 19
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(playerName6)) // 20
    set result = result + ConvertDecimalNumberToSaveCodeSegment(playerRank6) // 21

    if (hasAIPlayer) then
        set result = result + ConvertDecimalNumberToSaveCodeSegment(1) // 22
    else
        set result = result + ConvertDecimalNumberToSaveCodeSegment(0) // 22
    endif

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, CompressedAbsStringHash(clanName))
    endif

    call CreateSaveCodeClanTextFile(isSinglePlayer, clanName, icon, clanSoundIndex, gold, lumber, improvedClanHallLevel, improvedClanLevel, playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6, result)

    call AddGeneratedSaveCode(result)

    return result
endfunction

function GetSaveCodeClan takes integer clan returns string
     local string playerName0 = ""
     local integer playerRank0 = udg_ClanRankMember
     local string playerName1 = ""
     local integer playerRank1 = udg_ClanRankMember
     local string playerName2 = ""
     local integer playerRank2 = udg_ClanRankMember
     local string playerName3 = ""
     local integer playerRank3 = udg_ClanRankMember
     local string playerName4 = ""
     local integer playerRank4 = udg_ClanRankMember
     local string playerName5 = ""
     local integer playerRank5 = udg_ClanRankMember
     local string playerName6 = ""
     local integer playerRank6 = udg_ClanRankMember
     local integer improvedClanHallLevel = 0
     local integer improvedClanLevel = 0
     local integer clanMemberCounter = 0
     local integer i = 0
     loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
            set improvedClanHallLevel = IMaxBJ(GetPlayerTechCountSimple(UPG_IMPROVED_CLAN_HALL, Player(i)), improvedClanHallLevel)
            set improvedClanLevel = IMaxBJ(GetPlayerTechCountSimple(UPG_IMPROVED_CLAN, Player(i)), improvedClanLevel)

            if (clanMemberCounter == 0) then
                set playerName0 = GetPlayerName(Player(i))
                set playerRank0 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 1) then
                set playerName1 = GetPlayerName(Player(i))
                set playerRank1 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 2) then
                set playerName2 = GetPlayerName(Player(i))
                set playerRank2 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 3) then
                set playerName3 = GetPlayerName(Player(i))
                set playerRank3 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 4) then
                set playerName4 = GetPlayerName(Player(i))
                set playerRank4 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 5) then
                set playerName5 = GetPlayerName(Player(i))
                set playerRank5 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            elseif (clanMemberCounter == 6) then
                set playerName6 = GetPlayerName(Player(i))
                set playerRank6 = udg_ClanPlayerRank[GetConvertedPlayerId(Player(i))]
            endif
            set clanMemberCounter = clanMemberCounter + 1
        endif
        set i = i + 1
    endloop

    return GetSaveCodeClanEx(IsInSinglePlayer(), udg_ClanName[clan], udg_ClanIcon[clan], udg_ClanSound[clan], udg_ClanGold[clan], udg_ClanLumber[clan], udg_ClanHasAIPlayer[clan], improvedClanHallLevel, improvedClanLevel, playerName0, playerRank0, playerName1, playerRank1, playerName2, playerRank2, playerName3, playerRank3, playerName4, playerRank4, playerName5, playerRank5, playerName6, playerRank6)
endfunction

function ApplySaveCodeClan takes player whichPlayer, string name, string s returns boolean
    local integer playerNameHash = CompressedAbsStringHash(GetPlayerName(whichPlayer))
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer improvedClanHallLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer improvedClanLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0
    local integer currentPlayerNameHash = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (not IsGeneratedSaveCode(s)) then
        if (checksum == CompressedAbsStringHash(checkedSaveCode) and nameHash == CompressedAbsStringHash(name) and isSinglePlayer == IsInSinglePlayer()) then
            if (playerNameHash == playerNameHash0 or playerNameHash == playerNameHash1 or playerNameHash == playerNameHash2 or playerNameHash == playerNameHash3 or playerNameHash == playerNameHash4 or playerNameHash == playerNameHash5 or playerNameHash == playerNameHash6) then
                set i = 1
                loop
                    exitwhen (i > udg_ClanCounter)
                    if (StringLength(udg_ClanName[i]) > 0 and udg_ClanName[i] == name) then
                        set clan = i
                    endif
                    set i = i + 1
                endloop

                if (clan == 0) then
                    set udg_ClanName[udg_ClanCounter] = name
                    set udg_ClanIcon[udg_ClanCounter] = icon
                    set udg_ClanSound[udg_ClanCounter] = clanSound[clanSoundIndex]
                    set udg_ClanGold[udg_ClanCounter] = gold
                    set udg_ClanLumber[udg_ClanCounter] = lumber
                    set clan = udg_ClanCounter
                    set udg_ClanCounter = udg_ClanCounter + 1
                    //call BJDebugMsg("Creating new clan " + name)
                endif

                set i = 0
                loop
                    exitwhen (i == bj_MAX_PLAYERS)
                    if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
                        //call BJDebugMsg("Checking for player " + GetPlayerName(Player(i)))
                        set currentPlayerNameHash = CompressedAbsStringHash(GetPlayerName(Player(i)))
                        if (currentPlayerNameHash == playerNameHash0 or currentPlayerNameHash == playerNameHash1 or currentPlayerNameHash == playerNameHash2 or currentPlayerNameHash == playerNameHash3 or currentPlayerNameHash == playerNameHash4 or CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5 or currentPlayerNameHash == playerNameHash6) then
                            //call BJDebugMsg("Got clan player " + GetPlayerName(Player(i)))
                            set atLeastOne = true
                            if (not IsPlayerInForce(Player(i), udg_ClanPlayers[clan])) then
                                call ForceAddPlayer(udg_ClanPlayers[clan], Player(i))
                            endif
                            set udg_ClanPlayerClan[i + 1] = clan
                            call SetPlayerTechResearchedIfHigher(Player(i), UPG_HERO_CLAN, 1)
                            call SetPlayerTechResearchedIfHigher(Player(i), UPG_IMPROVED_CLAN_HALL, improvedClanHallLevel)
                            call SetPlayerTechResearchedIfHigher(Player(i), UPG_IMPROVED_CLAN, improvedClanLevel)

                            if (clanHasAIPlayer == 1) then
                                call SetPlayerTechResearchedSwap(UPG_CLAN_HAS_NO_AI_PLAYER, 0, Player(i))
                            endif
                        endif

                        if (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash0) then
                            set udg_ClanPlayerRank[i + 1] = playerRank0
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash1) then
                            set udg_ClanPlayerRank[i + 1] = playerRank1
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash2) then
                            set udg_ClanPlayerRank[i + 1] = playerRank2
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash3) then
                            set udg_ClanPlayerRank[i + 1] = playerRank3
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash4) then
                            set udg_ClanPlayerRank[i + 1] = playerRank4
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash5) then
                            set udg_ClanPlayerRank[i + 1] = playerRank5
                        elseif (CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash6) then
                            set udg_ClanPlayerRank[i + 1] = playerRank6
                        endif
                    endif
                    set i = i + 1
                endloop

                call DisplaySaveCodeErrorAtLeastOne(whichPlayer, atLeastOne)

                if (atLeastOne) then
                    call PickClanAIPlayer(clan)

                    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UNITACQUIRED, GetPlayerNameColored(whichPlayer) + " has created a new clan " + udg_ClanName[clan] + "!")
                    call PlaySoundBJ(gg_snd_ClanInvitation)
                endif

                return atLeastOne
            else
                call DisplaySaveCodeError(whichPlayer, "You are not a member of this clan!")
            endif
        endif
    else
        call DisplaySaveCodeErrorSameGame(whichPlayer)
    endif

    return false
endfunction

function GetClanPlayerName takes integer playerNameHash returns string
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (StringLength(GetPlayerName(Player(i))) > 0 and CompressedAbsStringHash(GetPlayerName(Player(i))) == playerNameHash) then
            return GetPlayerName(Player(i))
        endif
        set i = i + 1
    endloop

    return "Unknown"
endfunction

function GetSaveCodeInfosClan takes string name, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local string singlePlayerStatus = "Multiplayer"
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer improvedClanHallLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer improvedClanLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local string clanHasAIPlayerText = "No AI player"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "Singleplayer"
    endif

    if (clanHasAIPlayer == 1) then
        set clanHasAIPlayerText = "Has AI player"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "Game: " + singlePlayerStatus)
    set result = AppendSaveCodeInfo(result, "Name: " + name)
    set result = AppendSaveCodeInfo(result, "Icon: " + GetObjectName(icon))
    set result = AppendSaveCodeInfo(result, "Sound: " + GetClanSoundName(clanSoundIndex))
    set result = AppendSaveCodeInfo(result, "Gold: " + I2S(gold))
    set result = AppendSaveCodeInfo(result, "Lumber: " + I2S(lumber))
    set result = AppendSaveCodeInfo(result, "Improved Clan Hall: " + I2S(improvedClanHallLevel))
    set result = AppendSaveCodeInfo(result, "Improved Clan: " + I2S(improvedClanLevel))
    set result = AppendSaveCodeInfo(result, "Clan has AI player: " + clanHasAIPlayerText)
    set result = AppendSaveCodeInfo(result, "Player 1 Name: " + GetClanPlayerName(playerNameHash0))
    set result = AppendSaveCodeInfo(result, "Player 1 Rank: " + GetClanRankName(playerRank0))
    set result = AppendSaveCodeInfo(result, "Player 2 Name: " + GetClanPlayerName(playerNameHash1))
    set result = AppendSaveCodeInfo(result, "Player 2 Rank: " + GetClanRankName(playerRank1))
    set result = AppendSaveCodeInfo(result, "Player 3 Name: " + GetClanPlayerName(playerNameHash2))
    set result = AppendSaveCodeInfo(result, "Player 3 Rank: " + GetClanRankName(playerRank2))
    set result = AppendSaveCodeInfo(result, "Player 4 Name: " + GetClanPlayerName(playerNameHash3))
    set result = AppendSaveCodeInfo(result, "Player 4 Rank: " + GetClanRankName(playerRank3))
    set result = AppendSaveCodeInfo(result, "Player 5 Name: " + GetClanPlayerName(playerNameHash4))
    set result = AppendSaveCodeInfo(result, "Player 5 Rank: " + GetClanRankName(playerRank4))
    set result = AppendSaveCodeInfo(result, "Player 6 Name: " + GetClanPlayerName(playerNameHash5))
    set result = AppendSaveCodeInfo(result, "Player 6 Rank: " + GetClanRankName(playerRank5))

    return result
endfunction

function GetSaveCodeShortInfosClan takes string name, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(name))
    local integer isSinglePlayerFlag = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local boolean isSinglePlayer = isSinglePlayerFlag == 0
    local string singlePlayerStatus = "M"
    local integer nameHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 1)
    local integer icon = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 2)
    local integer clanSoundIndex = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 3)
    local integer gold = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 4)
    local integer lumber = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 5)
    local integer improvedClanHallLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 6)
    local integer improvedClanLevel = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 7)
    local integer playerNameHash0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 8)
    local integer playerRank0 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 9)
    local integer playerNameHash1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 10)
    local integer playerRank1 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 11)
    local integer playerNameHash2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 12)
    local integer playerRank2 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 13)
    local integer playerNameHash3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 14)
    local integer playerRank3 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 15)
    local integer playerNameHash4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 16)
    local integer playerRank4 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 17)
    local integer playerNameHash5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 18)
    local integer playerRank5 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 19)
    local integer playerNameHash6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 20)
    local integer playerRank6 = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 21)
    local integer clanHasAIPlayer = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 22)
    local string clanHasAIPlayerText = "No AI player"
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"
    local boolean atLeastOne = false
    local integer clan = 0
    local integer i = 0

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    if (isSinglePlayer) then
        set singlePlayerStatus = "S"
    endif

    if (clanHasAIPlayer == 1) then
        set clanHasAIPlayerText = "Has AI player"
    endif

    return name + "-" + singlePlayerStatus + "-gold_" + I2S(gold) + "-lumber_" + I2S(lumber) + "-p1_" + GetClanPlayerName(playerNameHash0) + "-p2_" + GetClanPlayerName(playerNameHash1) + "-p3_" + GetClanPlayerName(playerNameHash2)
endfunction

// Mailbox System

function CreateSaveCodeLetterTextFile takes string playerNameFrom, string playerNameTo, string message, string saveCode returns nothing
    local string content = ""

    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Code:")
    set content = content + AppendFileContentLeft("-loadl " + saveCode)
    set content = content + AppendFileContent("From: " + playerNameFrom)
    set content = content + AppendFileContent("To: " + playerNameTo)
    set content = content + AppendFileContent("Message Length: " + I2S(StringLength(message)))
    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-letter-from_" + playerNameFrom + "-to_" + playerNameTo + "-messageLength_" + I2S(StringLength(message)) + ".txt")
endfunction

function AddGeneratedSaveCodeLetter takes string playerNameFrom, string playerNameTo, string message returns nothing
    local integer index = 0
    local integer i = 0
    loop
        exitwhen(i == bj_MAX_PLAYERS)
        if (GetPlayerName(Player(i)) == playerNameTo) then
            call DisplayTimedTextToPlayer(Player(i), 0.0, 0.0, 40.0, "You received a letter from " + playerNameFrom + ". Use \"-mailbox\" to list all letters.")
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    set index = PrestoredSaveCodeCounter
    set PrestoredSaveCodePlayerName[index] = playerNameTo
    set PrestoredSaveCode[index] = message
    set PrestoredSaveCodeType[index] = PRESTORED_SAVECODE_TYPE_LETTER
    set PrestoredSaveCodePlayerNamesCounter[index] = 0
    set PrestoredSaveCodeCounter = PrestoredSaveCodeCounter + 1
    set lastAddedPrestoredClan = index
endfunction

function GetSaveCodeLetter takes string playerNameFrom, string playerNameTo, string message returns string
    local integer i = 0
    local integer playerNameToHash = CompressedAbsStringHash(playerNameTo)
    local string result = ConvertDecimalNumberToSaveCodeSegment(playerNameToHash)

    set result = result + ConvertStringToSaveCodeSegment(playerNameFrom, playerNameToHash)
    set result = result + ConvertStringToSaveCodeSegment(message, playerNameToHash)

    // checksum
    set result = result + ConvertDecimalNumberToSaveCodeSegment(CompressedAbsStringHash(result))

    if (SAVE_CODE_OBFUSCATE) then
        //call BJDebugMsg("Non-obfuscated save code: " + result)
        set result = ConvertSaveCodeToObfuscatedVersion(result, playerNameToHash)
    endif

    call CreateSaveCodeLetterTextFile(playerNameFrom, playerNameTo, message, result)

    call AddGeneratedSaveCode(result)
    call AddGeneratedSaveCodeLetter(playerNameFrom, playerNameTo, message)

    return result
endfunction

function GetSaveCodeInfosLetter takes string playerNameTo, string s returns string
    local string result = ""
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerNameTo))
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerNameToText = playerNameTo
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 1, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (playerNameToHash != CompressedAbsStringHash(playerNameTo)) then
        set playerNameToText = "Invalid"
    endif

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    set result = AppendSaveCodeInfo(result, "Checksum: " + checksumStatus)
    set result = AppendSaveCodeInfo(result, "To: " + playerNameToText)
    set result = AppendSaveCodeInfo(result, "From: " + playerNameFrom)
    set result = AppendSaveCodeInfo(result, "Message: " + message)

    return result
endfunction

function GetSaveCodeShortInfosLetter takes string playerNameTo, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerNameTo))
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerNameToText = playerNameTo
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 1, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string checksumStatus = "Valid"

    //call BJDebugMsg("Obfuscated save code: " + s)
    //call BJDebugMsg("Non-Obfuscated save code: " + saveCode)

    //call BJDebugMsg("Checked save code part: " + checkedSaveCode)
    //call BJDebugMsg("Checked save code part length: " + I2S(StringLength(checkedSaveCode)))
    //call BJDebugMsg("Checksum: " + I2S(checksum))

    //call BJDebugMsg("Save code playerNameHash " + I2S(playerNameHash))
    //call BJDebugMsg("Save code XP " + I2S(xp))

    if (playerNameToHash != CompressedAbsStringHash(playerNameTo)) then
        set playerNameToText = "Invalid"
    endif

    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set checksumStatus = "Invalid"
    endif

    return "f_" + playerNameFrom + "-t_" + playerNameToText + "-m_" + I2S(StringLength(message))
endfunction

function ApplySaveCodeLetter takes player whichPlayer, string playerName, string s returns boolean
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 1, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)

    if (checksum == CompressedAbsStringHash(checkedSaveCode) and playerNameToHash == CompressedAbsStringHash(playerName)) then
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 40.0, "Letter from " + playerNameFrom + ": " + message)

        return true
    endif

    return false
endfunction

function GetSaveCodeErrorsLetter takes player whichPlayer, string playerName, string s returns string
    local string saveCode = ReadSaveCode(s, CompressedAbsStringHash(playerName))
    local integer playerNameToHash = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, 0)
    local string playerNameFrom = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 1, playerNameToHash)
    local string message = ConvertSaveCodeSegmentIntoStringFromSaveCode(saveCode, 2, playerNameToHash)
    local integer lastSaveCodeSegment = GetSaveCodeSegments(saveCode) - 1
    local string checkedSaveCode = GetSaveCodeUntil(saveCode, lastSaveCodeSegment)
    local integer checksum = ConvertSaveCodeSegmentIntoDecimalNumberFromSaveCode(saveCode, lastSaveCodeSegment)
    local string result = ""


    if (checksum != CompressedAbsStringHash(checkedSaveCode)) then
        set result = result + "Expected different checksum!"
    endif

    if (playerNameToHash != CompressedAbsStringHash(playerName)) then
        if (StringLength(result) > 0) then
            set result = result + ", "
        endif

        set result = result + "Expected different player name!"
    endif

    if (StringLength(result) == 0) then
        set result = "None errors detected."
    endif

    return result
endfunction

library FileIO
/***************************************************************
*
*   v1.1.0, by TriggerHappy
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*
*   Provides functionality to read and write files.
*   _________________________________________________________________________
*   1. Requirements
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       - Patch 1.29 or higher.
*       - JassHelper (vJASS)
*   _________________________________________________________________________
*   2. Installation
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*   Copy the script to your map and save it.
*   _________________________________________________________________________
*   3. API
*   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*       struct File extends array
*
*           static constant integer AbilityCount
*           static constant integer PreloadLimit
*
*           readonly static boolean ReadEnabled
*           readonly static integer Counter
*           readonly static integer array List
*
*           static method open takes string filename returns File
*           static method create takes string filename returns File
*
*           ---------
*
*           method write takes string value returns File
*           method read takes nothing returns string
*           method clear takes nothing returns File
*
*           method readEx takes boolean close returns string
*           method readAndClose takes nothing returns string
*           method readBuffer takes nothing returns string
*           method writeBuffer takes string contents returns nothing
*           method appendBuffer takes string contents returns nothing
*
*           method close takes nothing returns nothing
*
*           public function Write takes string filename, string contents returns nothing
*           public function Read takes string filename returns string
*
***************************************************************/

    globals
        // Enable this if you want to allow the system to read files generated in patch 1.30 or below.
        // NOTE: For this to work properly you must edit the 'Amls' ability and change the levels to 2
        // as well as typing something in "Level 2 - Text - Tooltip - Normal" text field.
        //
        // Enabling this will also cause the system to treat files written with .write("") as empty files.
        //
        // This setting is really only intended for those who were already using the system in their map
        // prior to patch 1.31 and want to keep old files created with this system to still work.
        private constant boolean BACKWARDS_COMPATABILITY = false
    endglobals

    private keyword FileInit
    struct File extends array
        static constant integer AbilityCount = 10
        static constant integer PreloadLimit = 200

        readonly static integer Counter = 0
        readonly static integer array List
        readonly static integer array AbilityList

        readonly static boolean ReadEnabled

        readonly string filename
        private string buffer

        static method open takes string filename returns thistype
            local thistype this = .List[0]

            if (this == 0) then
                set this = Counter + 1
                set Counter = this
            else
                set .List[0] = .List[this]
            endif

            set this.filename = filename
            set this.buffer = null

            debug if (this >= JASS_MAX_ARRAY_SIZE) then
            debug   call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") WARNING: Maximum instance limit " + I2S(JASS_MAX_ARRAY_SIZE) + " reached.")
            debug endif

            return this
        endmethod

        // This is used to detect invalid characters which aren't supported in preload files.
        static if (DEBUG_MODE) then
            private static method validateInput takes string contents returns string
                local integer i = 0
                local integer l = StringLength(contents)
                local string ch = ""
                loop
                    exitwhen i >= l
                    set ch = SubString(contents, i, i + 1)
                    if (ch == "\\") then
                        return ch
                    elseif (ch == "\"") then
                        return ch
                    endif
                    set i = i + 1
                endloop
                return null
            endmethod
        endif
        method write takes string contents returns thistype
            local integer i = 0
            local integer c = 0
            local integer len = StringLength(contents)
            local integer lev = 0
            local string prefix = "-" // this is used to signify an empty string vs a null one
            local string chunk
            debug if (.validateInput(contents) != null) then
            debug   call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") ERROR: Invalid character |cffffcc00" + .validateInput(contents) + "|r")
            debug   return this
            debug endif

            set this.buffer = null

            // Check if the string is empty. If null, the contents will be cleared.
            if (contents == "") then
                set len = len + 1
            endif

            // Begin to generate the file
            call PreloadGenClear()
            call PreloadGenStart()
            loop
                exitwhen i >= len

                debug if (c >= .AbilityCount) then
                debug call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO(" + filename + ") ERROR: String exceeds max length (" + I2S(.AbilityCount * .PreloadLimit) + ").|r")
                debug endif

                set lev = 0
                static if (BACKWARDS_COMPATABILITY) then
                    if (c == 0) then
                        set lev = 1
                        set prefix = ""
                    else
                        set prefix = "-"
                    endif
                endif

                set chunk = SubString(contents, i, i + .PreloadLimit)
                call Preload("\" )\ncall BlzSetAbilityTooltip(" + I2S(.AbilityList[c]) + ", \"" + prefix + chunk + "\", " + I2S(lev) + ")\n//")
                set i = i + .PreloadLimit
                set c = c + 1
            endloop
            call Preload("\" )\nendfunction\nfunction a takes nothing returns nothing\n //")
            call PreloadGenEnd(this.filename)

            return this
        endmethod

        method clear takes nothing returns thistype
            return this.write(null)
        endmethod

        private method readPreload takes nothing returns string
            local integer i = 0
            local integer lev = 0
            local string array original
            local string chunk = ""
            local string output = ""

            loop
                exitwhen i == .AbilityCount
                set original[i] = BlzGetAbilityTooltip(.AbilityList[i], 0)
                set i = i + 1
            endloop

            // Execute the preload file
            call Preloader(this.filename)

            // Read the output
            set i = 0
            loop
                exitwhen i == .AbilityCount

                set lev = 0

                // Read from ability index 1 instead of 0 if
                // backwards compatability is enabled
                static if (BACKWARDS_COMPATABILITY) then
                    if (i == 0) then
                        set lev = 1
                    endif
                endif

                // Make sure the tooltip has changed
                set chunk = BlzGetAbilityTooltip(.AbilityList[i], lev)

                if (chunk == original[i]) then
                    if (i == 0 and output == "") then
                        return null // empty file
                    endif
                    return output
                endif

                // Check if the file is an empty string or null
                static if not (BACKWARDS_COMPATABILITY) then
                    if (i == 0) then
                        if (SubString(chunk, 0, 1) != "-") then
                            return null // empty file
                        endif
                        set chunk = SubString(chunk, 1, StringLength(chunk))
                    endif
                endif

                // Remove the prefix
                if (i > 0) then
                    set chunk = SubString(chunk, 1, StringLength(chunk))
                endif

                // Restore the tooltip and append the chunk
                call BlzSetAbilityTooltip(.AbilityList[i], original[i], lev)

                set output = output + chunk

                set i = i + 1
            endloop

            return output
        endmethod

        method close takes nothing returns nothing
            if (this.buffer != null) then
                call .write(.readPreload() + this.buffer)
                set this.buffer = null
            endif
            set .List[this] = .List[0]
            set .List[0] = this
        endmethod

        method readEx takes boolean close returns string
            local string output = .readPreload()
            local string buf = this.buffer

            if (close) then
                call this.close()
            endif

            if (output == null) then
                return buf
            endif

            if (buf != null) then
                set output = output + buf
            endif

            return output
        endmethod

        method read takes nothing returns string
            return .readEx(false)
        endmethod

        method readAndClose takes nothing returns string
            return .readEx(true)
        endmethod

        method appendBuffer takes string contents returns thistype
            set .buffer = .buffer + contents
            return this
        endmethod

        method readBuffer takes nothing returns string
            return .buffer
        endmethod

        method writeBuffer takes string contents returns nothing
            set .buffer = contents
        endmethod

        static method create takes string filename returns thistype
            return .open(filename).write("")
        endmethod

        implement FileInit
    endstruct
    private module FileInit
        private static method onInit takes nothing returns nothing
            local string originalTooltip

            // We can't use a single ability with multiple levels because
            // tooltips return the first level's value if the value hasn't
            // been set. This way we don't need to edit any object editor data.
            set File.AbilityList[0] = 'Amls'
            set File.AbilityList[1] = 'Aroc'
            set File.AbilityList[2] = 'Amic'
            set File.AbilityList[3] = 'Amil'
            set File.AbilityList[4] = 'Aclf'
            set File.AbilityList[5] = 'Acmg'
            set File.AbilityList[6] = 'Adef'
            set File.AbilityList[7] = 'Adis'
            set File.AbilityList[8] = 'Afbt'
            set File.AbilityList[9] = 'Afbk'

            // Backwards compatability check
            static if (BACKWARDS_COMPATABILITY) then
                static if (DEBUG_MODE) then
                    set originalTooltip = BlzGetAbilityTooltip(File.AbilityList[0], 1)
                    call BlzSetAbilityTooltip(File.AbilityList[0], SCOPE_PREFIX, 1)
                    if (BlzGetAbilityTooltip(File.AbilityList[0], 1) == originalTooltip) then
                        call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0, 120, "FileIO WARNING: Backwards compatability enabled but \"" + GetObjectName(File.AbilityList[0]) + "\" isn't setup properly.|r")
                    endif
                endif
            endif

            // Read check
            set File.ReadEnabled = File.open("FileTester.pld").write(SCOPE_PREFIX).readAndClose() == SCOPE_PREFIX
        endmethod
    endmodule
    public function Write takes string filename, string contents returns nothing
        call File.open(filename).write(contents).close()
    endfunction
    public function Read takes string filename returns string
        return File.open(filename).readEx(true)
    endfunction
endlibrary

// Save and Load Auto

globals
    constant string SAVE_AND_LOAD_AUTO_PREFIX = "SaveAndLoadAuto"
    trigger SaveAndLoadAutoSyncTrigger = CreateTrigger()
    integer array SaveAndLoadAutoSyncCounter
endglobals

function GetAllPlayingUsers takes nothing returns force
    local player whichPlayer = null
    local force result = CreateForce()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call ForceAddPlayer(result, whichPlayer)
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function SaveAndLoadAutoGetPlayerFromSyncData takes string source returns player
    return Player(S2I(StringToken(source, 0)))
endfunction

function SaveAndLoadAutoGetContentFromSyncData takes string source returns string
    return StringToken(source, 1)
endfunction

function SaveAndLoadAutoTriggerAction takes nothing returns nothing
    local string syncData = BlzGetTriggerSyncData()
    local player sourcePlayer = SaveAndLoadAutoGetPlayerFromSyncData(syncData)
    local string content = SaveAndLoadAutoGetContentFromSyncData(syncData)
    call BJDebugMsg("Syncing data from player " + GetPlayerName(sourcePlayer) + ": " + content)
    set SaveAndLoadAutoSyncCounter[GetPlayerId(sourcePlayer)] = SaveAndLoadAutoSyncCounter[GetPlayerId(sourcePlayer)] + 1
endfunction

function SaveAndLoadAutoInit takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call BlzTriggerRegisterPlayerSyncEvent(SaveAndLoadAutoSyncTrigger, Player(i), SAVE_AND_LOAD_AUTO_PREFIX, false)
        set i = i + 1
    endloop
    call TriggerAddAction(SaveAndLoadAutoSyncTrigger, function SaveAndLoadAutoTriggerAction)
endfunction

function LoadFileForAllPlayers takes File file, player whichPlayer returns string
    local force allPlayingUsers = null
    local string content = ""
    local boolean synced = false
    local real timeout = 0.0
    set SaveAndLoadAutoSyncCounter[GetPlayerId(whichPlayer)] = 0
    if (GetLocalPlayer() == whichPlayer) then
        set content = file.read()
        call BlzSendSyncData(SAVE_AND_LOAD_AUTO_PREFIX, I2S(GetPlayerId(whichPlayer)) + " " + content)
    endif

    loop
        set allPlayingUsers = GetAllPlayingUsers()
        set synced = SaveAndLoadAutoSyncCounter[GetPlayerId(whichPlayer)] >= CountPlayersInForceBJ(allPlayingUsers)
        call ForceClear(allPlayingUsers)
        call DestroyForce(allPlayingUsers)
        set allPlayingUsers = null
        exitwhen (timeout >= 5.0 or synced)
        call TriggerSleepAction(1.0)
        set timeout = timeout + 1.0
    endloop

    if (synced) then
        return content
    endif

    return null
endfunction

function LoadAutoLoadSaveCode takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local File file = File.open("WorldOfWarcraftReforged-" + playerName + "-auto.txt")
    local string content = LoadFileForAllPlayers(file, whichPlayer)
    local integer indexOfLoad = -1
    local boolean result = true

    if (content != null) then
        set indexOfLoad = IndexOfString(content, "-load ")
        if (indexOfLoad != -1) then
            call BJDebugMsg("Found savecode")
            call ApplySaveCode(whichPlayer, content)
        else
            call BJDebugMsg("Found no savecode")
        endif
    else
        set result = false
        call BJDebugMsg("Error on syncing savecode")
    endif
    call file.close()
endfunction

function WriteAutoLoadSaveCodes takes player whichPlayer returns nothing
    local string playerName = GetPlayerName(whichPlayer)
    local File file = File.open("WorldOfWarcraftReforged-" + playerName + "-auto.txt")
    call file.write("-load " + GetSaveCode(whichPlayer))
    call file.close()
endfunction

// Generated Save Codes

function GetSaveCodeStrong takes string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns string
    return GetSaveCodeEx(GetTriggerPlayer(), playerName, singlePlayer, warlord, udg_GameTypeNormal, xpRate, 1000, 50049900, 800000, 800000, 1000, 100, 100, 100, 100, 8000, 0, 20000, 0, 20000, 5000, 1000, 50049900, 1000, 50049900, 100, 100, 2, 3)
endfunction

function GetSaveCodeNormal takes string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns string
    return GetSaveCodeEx(GetTriggerPlayer(), playerName, singlePlayer, warlord, udg_GameTypeNormal, xpRate, 30, 50000, 100000, 100000, 20, 20, 20, 20, 20, 30, 0, 2000, 0, 800, 10, 30, 50000, 30, 50000, 20, 20, 0, 2)
endfunction

function ForGroupRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

function GetSaveCodeBase takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allBuildings = CreateGroup()
    local string result
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'htow', GetRectCenterX(gg_rct_Save_Code_Town_Hall), GetRectCenterY(gg_rct_Save_Code_Town_Hall), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_1), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_1), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hgtw', GetRectCenterX(gg_rct_Save_Code_Guard_Tower_2), GetRectCenterY(gg_rct_Save_Code_Guard_Tower_2), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'halt', GetRectCenterX(gg_rct_Save_Code_Altar), GetRectCenterY(gg_rct_Save_Code_Altar), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hlum', GetRectCenterX(gg_rct_Save_Code_Lumber_Mill), GetRectCenterY(gg_rct_Save_Code_Lumber_Mill), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hvlt', GetRectCenterX(gg_rct_Save_Code_Arcane_Vault), GetRectCenterY(gg_rct_Save_Code_Arcane_Vault), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'harm', GetRectCenterX(gg_rct_Save_Code_Workshop), GetRectCenterY(gg_rct_Save_Code_Workshop), bj_UNIT_FACING))
    call GroupAddUnit(allBuildings, CreateUnit(whichPlayer, 'hbar', GetRectCenterX(gg_rct_Save_Code_Barracks), GetRectCenterY(gg_rct_Save_Code_Barracks), bj_UNIT_FACING))

    set result = GetSaveCodeBuildingsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer, allBuildings)

    call ForGroupBJ(allBuildings, function ForGroupRemoveUnit)

    call GroupClear(allBuildings)
    call DestroyGroup(allBuildings)
    set allBuildings = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function CreateAllDragons takes player whichPlayer returns group
    local location tmpLocation = Location(0.0, 0.0)
    local group allDragons = CreateGroup()
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nrwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'ngrd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbwm', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nadr', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nbzd', whichPlayer, tmpLocation, 0.0), allDragons)
    call GroupAddGroup(CreateNUnitsAtLoc(10, 'nndr', whichPlayer, tmpLocation, 0.0), allDragons)

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return allDragons
endfunction

function GetSaveCodeDragonUnits takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local location tmpLocation = Location(0.0, 0.0)
    local group allDragons = CreateAllDragons(whichPlayer)
    local group allDragonsDistinct = DistinctGroup(allDragons)
    local string result = GetSaveCodeUnitsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer, allDragonsDistinct)

    call ForGroupBJ(allDragons, function ForGroupRemoveUnit)

    call GroupClear(allDragons)
    call DestroyGroup(allDragons)
    set allDragons = null

    call GroupClear(allDragonsDistinct)
    call DestroyGroup(allDragonsDistinct)
    set allDragonsDistinct = null

    call RemoveLocation(tmpLocation)
    set tmpLocation = null

    return result
endfunction

function GetSaveCodeGoodItems takes string playerName, boolean singlePlayer, boolean warlord returns string
    local item item0 = CreateItem('gcel', 0.0, 0.0)
    local item item1 = CreateItem('pnvu', 0.0, 0.0)
    local item item2 = CreateItem('sres', 0.0, 0.0)
    local item item3 = CreateItem('ankh', 0.0, 0.0)
    local item item4 = CreateItem('whwd', 0.0, 0.0)
    local item item5 = CreateItem('hlst', 0.0, 0.0)
    local string result

    call SetItemCharges(item0, 100)
    call SetItemCharges(item1, 100)
    call SetItemCharges(item2, 100)
    call SetItemCharges(item3, 100)
    call SetItemCharges(item4, 100)
    call SetItemCharges(item5, 100)

    set result = GetSaveCodeItemsEx2(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, item0, item1, item2, item3, item4, item5)

    call RemoveItem(item0)
    set item0 = null

    call RemoveItem(item1)
    set item1 = null

    call RemoveItem(item2)
    set item2 = null

    call RemoveItem(item3)
    set item3 = null

    call RemoveItem(item4)
    set item4 = null

    call RemoveItem(item5)
    set item5 = null

    return result
endfunction

function GetSaveCodeHumanUpgrades takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord returns string
    local integer ironForgedSwordsLevel = GetPlayerTechCountSimple('Rhme', whichPlayer)
    local string result

    call SetPlayerTechResearched(whichPlayer, 'Rhme', 3)

    set result = GetSaveCodeResearchesEx(playerName, singlePlayer, warlord, udg_GameTypeNormal, 100, whichPlayer)

    call SetPlayerTechResearched(whichPlayer, 'Rhme', ironForgedSwordsLevel)

    return result
endfunction

function GetSaveCodeTheElvenClan takes boolean singlePlayer, string playerName returns string
    // there seems to be an issue if we pass these values directly as literals
    local integer clanIcon = 0 // TODO Leads to stopping the code execution 'I04S'
    local integer gold = 10000
    local integer lumber = 10000
    return GetSaveCodeClanEx(singlePlayer, "TheElvenClan", clanIcon, clanSound[1], gold, lumber, true, 10, 10, playerName, udg_ClanRankLeader, "WorldEdit", udg_ClanRankLeader, "Barade", udg_ClanRankLeader, "Runeblade14#2451", udg_ClanRankCaptain, "AntiDenseMan#1202", udg_ClanRankCaptain, "", 0, "", 0)
endfunction

globals
    player generateSaveCodePlayer
    string generateSaveCodePlayerName
    boolean generateSaveCodeSinglePlayer
    boolean generateSaveCodeWarlord
    integer generateSaveCodeXpRate

    boolean generateSaveCodeClanSinglePlayer
    string generateSaveCodeClanPlayerName
endglobals

function NewOpLimit takes code callback returns nothing
    call ForForce(bj_FORCE_PLAYER[0], callback)
endfunction

function GenerateSaveCode takes player whichPlayer, string playerName, boolean singlePlayer, boolean warlord, integer xpRate returns nothing
    call GetSaveCodeStrong(playerName, singlePlayer, warlord, xpRate)
    call GetSaveCodeNormal(playerName, singlePlayer, warlord, xpRate)
    call GetSaveCodeBase(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeDragonUnits(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeGoodItems(playerName, singlePlayer, warlord)
    call GetSaveCodeHumanUpgrades(whichPlayer, playerName, singlePlayer, warlord)
    call GetSaveCodeLetter(playerName, playerName, "Hello World!")
endfunction

function GenerateSaveCodeNewOpLimit takes nothing returns nothing
    call GenerateSaveCode(generateSaveCodePlayer, generateSaveCodePlayerName, generateSaveCodeSinglePlayer, generateSaveCodeWarlord, generateSaveCodeXpRate)
endfunction

function GetSaveCodeTheElvenClanNewOpLimit takes nothing returns nothing
    call GetSaveCodeTheElvenClan(generateSaveCodeClanSinglePlayer, generateSaveCodeClanPlayerName)
endfunction

function GenerateSaveCodes takes player whichPlayer returns nothing
    local integer playerNameSize = 2
    local string array playerName
    local integer singlePlayerSize = 2
    local boolean array singlePlayer
    local integer warlordSize = 2
    local boolean array warlord
    local integer xpRate = 100
    local integer i = 0
    local integer j = 0
    local integer k = 0
    set playerName[0] = "Barade#2569"
    set playerName[1] = "WorldEdit"
    set singlePlayer[0] = true
    set singlePlayer[1] = false
    set warlord[0] = true
    set warlord[1] = false
    set i = 0
    loop
        exitwhen (i >= playerNameSize)
        set j = 0
        loop
            exitwhen (j >= singlePlayerSize)
            set k = 0
            loop
                exitwhen (k >= warlordSize)
                if (not warlord[k]) then
                    set xpRate = 130
                else
                    set xpRate = 100
                endif
                call BJDebugMsg("Generating savecodes for player name " + playerName[i])
                if (singlePlayer[j]) then
                    call BJDebugMsg("Singleplayer")
                else
                    call BJDebugMsg("Multiplayer")
                endif
                if (warlord[k]) then
                    call BJDebugMsg("Warlord")
                else
                    call BJDebugMsg("Freelancer")
                endif

                set generateSaveCodePlayer = whichPlayer
                set generateSaveCodePlayerName = playerName[i]
                set generateSaveCodeSinglePlayer = singlePlayer[j]
                set generateSaveCodeWarlord = warlord[k]
                set generateSaveCodeXpRate = xpRate
                call NewOpLimit(function GenerateSaveCodeNewOpLimit)
                set k = k  + 1
            endloop
            call BJDebugMsg("Clan Save Code")
            set generateSaveCodeClanSinglePlayer = singlePlayer[j]
            set generateSaveCodeClanPlayerName = playerName[i]
            call NewOpLimit(function GetSaveCodeTheElvenClanNewOpLimit)
            call BJDebugMsg("After Generating Clan Save Code")
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function CreateSaveCodeAllTextFileEx takes string playerName, string saveCode, string saveCodeItems, string saveCodeUnits, string saveCodeResearches, string saveCodeBuildings, string saveCodeClan returns nothing
    local string content = ""
    call PreloadGenClear()
    call PreloadGenStart()

    set content = content + AppendFileContent("Player: " + playerName)
    set content = content + AppendFileContent("-load " + saveCode)
    set content = content + AppendFileContent("-loadi " + saveCodeItems)
    set content = content + AppendFileContent("-loadu " + saveCodeUnits)
    set content = content + AppendFileContent("-loadr " + saveCodeResearches)
    set content = content + AppendFileContent("-loadb " + saveCodeBuildings)

    if (saveCodeClan != null) then
        set content = content + AppendFileContent("-loadc " + saveCodeClan)
    else
        set content = content + AppendFileContent("No Clan")
    endif

    set content = content + AppendFileContent("")

    // The line below creates the log
    call Preload(content)

    // The line below creates the file at the specified location
    call PreloadGenEnd("WorldOfWarcraftReforged-" + playerName + "-all.txt")
endfunction

function CreateSaveCodeAllTextFile takes player whichPlayer returns nothing
    local string clanSaveCode = null
    if (udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)] > 0) then
        set clanSaveCode = GetSaveCodeClan(udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)])
    endif
    call CreateSaveCodeAllTextFileEx(GetPlayerName(whichPlayer), GetSaveCode(whichPlayer), GetSaveCodeItems(whichPlayer), GetSaveCodeUnits(whichPlayer), GetSaveCodeResearches(whichPlayer), GetSaveCodeBuildings(whichPlayer), clanSaveCode)
endfunction

/**
 * Baradé's Backpack UI system.
 */
globals
    boolean array BackpackUIVisible
    framehandle array BackpackBackgroundFrame
    framehandle array BackpackTitleFrame
    framehandle array BackpackItemFrame
    framehandle array BackpackItemBackdropFrame
    framehandle array BackpackItemChargesFrame
    trigger array BackpackItemTrigger
    trigger array BackpackItemMouseDownTrigger
    trigger array BackpackItemMouseUpTrigger
    trigger array BackpackItemTooltipOnTrigger
    trigger array BackpackItemTooltipOffTrigger
    framehandle array BackpackTooltipFrame
    framehandle array BackpackItemGoldFrame
    framehandle array BackpackItemGoldIconFrame
    framehandle array BackpackTooltipText
    framehandle array BackpackCloseButton
    trigger array BackpackCloseTrigger
    constant real BACKPACK_UI_SIZE_X = 0.80
    constant real BACKPACK_UI_SIZE_Y = 0.42
    constant real BACKPACK_UI_BUTTON_SIZE = 0.02818
    constant real BACKPACK_UI_CHARGES_POS = 0.003
    constant real BACKPACK_UI_CHARGES_SIZE = 0.02
    constant real BACKPACK_UI_BUTTON_SPACE = 0.005
endglobals

function BackpackUIExists takes player whichPlayer returns boolean
    return BackpackBackgroundFrame[GetPlayerId(whichPlayer)] != null
endfunction

function ShowBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    if (not BackpackUIExists(whichPlayer)) then
        return
    endif
    set BackpackUIVisible[GetPlayerId(whichPlayer)] = true
    call UpdateItemsForBackpackUI(whichPlayer)
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], true)
        call BlzFrameSetVisible(BackpackTitleFrame[GetPlayerId(whichPlayer)], true)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], true)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], true)
        set i = 0
        loop
            exitwhen (i == udg_RucksackMaxPages)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                call BlzFrameSetVisible(BackpackItemFrame[index], true)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], true)
                if (udg_RucksackItemType[index] != 0 and GetItemTypePerishable(udg_RucksackItemType[index])) then
                    call BlzFrameSetVisible(BackpackItemChargesFrame[index], true)
                endif
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif
endfunction

function HideBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    if (not BackpackUIExists(whichPlayer)) then
        return
    endif
    set BackpackUIVisible[GetPlayerId(whichPlayer)] = false
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(BackpackBackgroundFrame[GetPlayerId(whichPlayer)], false)
        call BlzFrameSetVisible(BackpackTitleFrame[GetPlayerId(whichPlayer)], false)
        //call BlzFrameSetVisible(BackpackItemGoldFrame[GetPlayerId(whichPlayer)], false)
        //call BlzFrameSetVisible(BackpackItemGoldIconFrame[GetPlayerId(whichPlayer)], false)
        set i = 0
        loop
            exitwhen (i == udg_RucksackMaxPages)
            set j = 0
            loop
                exitwhen (j == bj_MAX_INVENTORY)
                set index = Index3D(GetPlayerId(whichPlayer), i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
                call BlzFrameSetVisible(BackpackItemFrame[index], false)
                call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)
                call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
                set j = j + 1
            endloop
            set i = i + 1
        endloop
    endif
endfunction

function BackpackClickItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    local integer bag = LoadTriggerParameterInteger(GetTriggeringTrigger(), 2)
    local integer slot = LoadTriggerParameterInteger(GetTriggeringTrigger(), 3)
    //call BJDebugMsg("Clicking on item " + I2S(index))

    call ChangeRucksackPageEx(playerId, bag)
endfunction

function BackpackMouseDownItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
endfunction

function BackpackMouseUpItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)

    if (BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT) then
        // https://www.hiveworkshop.com/threads/how-to-fake-the-cursor-dragging-an-item.337534/
        // TODO Create a fake drag cursor.
    endif
endfunction

function BackpackEnterItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    local integer bag = LoadTriggerParameterInteger(GetTriggeringTrigger(), 2)
    local integer slot = LoadTriggerParameterInteger(GetTriggeringTrigger(), 3)
    local string tooltip = "Empty slot " + I2S(slot + 1) + " at bag " + I2S(bag + 1) + "."
    //call BJDebugMsg("Entering item " + I2S(index))

    if (udg_RucksackItemType[index] != 0) then
        if (udg_RucksackItemPawnable[index]) then
            set tooltip = GetObjectName(udg_RucksackItemType[index]) + "|n"

            if (GetItemValueGold(udg_RucksackItemType[index]) > 0) then
                set tooltip = tooltip + "|cffFCD20D" + I2S(GetItemValueGold(udg_RucksackItemType[index])) + " Gold|r"
            endif

            if (GetItemValueLumber(udg_RucksackItemType[index]) > 0) then
                if (GetItemValueGold(udg_RucksackItemType[index]) > 0) then
                    set tooltip = tooltip + " "
                endif

                set tooltip = tooltip + "|cffFCD20D" + I2S(GetItemValueLumber(udg_RucksackItemType[index])) + " Lumber|r"
            endif

            set tooltip = tooltip + "|n|cff808080Drop item on shop to sell|R|n" + udg_RucksackItemTooltipExtended[index]
        else
            set tooltip = GetObjectName(udg_RucksackItemType[index]) + "|n|n" + udg_RucksackItemTooltipExtended[index]
        endif
    endif

    set tooltip = tooltip + "|n|cff808080Click to open the bag.|R|n"

    call BlzFrameSetText(BackpackTooltipText[playerId], tooltip)
endfunction

function BackpackLeaveItemFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local integer index = LoadTriggerParameterInteger(GetTriggeringTrigger(), 1)
    //call BJDebugMsg("Leave item " + I2S(index))
    call BlzFrameSetText(BackpackTooltipText[playerId], "")
endfunction

function BackpackCloseFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    call HideBackpackUI(Player(playerId))
endfunction

function CreateBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local real x = 0.0
    local real y = 0.0
    local integer index = 0
    local integer playerId = GetPlayerId(whichPlayer)

    set BackpackBackgroundFrame[playerId] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),0,0)
    call BlzFrameSetAbsPoint(BackpackBackgroundFrame[playerId], FRAMEPOINT_TOPLEFT, 0.0, 0.57)
    call BlzFrameSetAbsPoint(BackpackBackgroundFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.57 - BACKPACK_UI_SIZE_Y)

    set BackpackTitleFrame[playerId] = BlzCreateFrameByType("TEXT", "BackpackTitle" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(BackpackTitleFrame[playerId], FRAMEPOINT_TOPLEFT, 0.0, 0.54)
    call BlzFrameSetAbsPoint(BackpackTitleFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.54 - 0.1)
    call BlzFrameSetText(BackpackTitleFrame[playerId], "Backpack")
    call BlzFrameSetTextAlignment(BackpackTitleFrame[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(BackpackTitleFrame[playerId], 1.0)
    call BlzFrameSetVisible(BackpackTitleFrame[playerId], false)

    set x = 0.03
    set y = 0.53
    set i = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            set BackpackItemFrame[index] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(BackpackItemFrame[index], FRAMEPOINT_BOTTOMRIGHT, x + BACKPACK_UI_BUTTON_SIZE, y - BACKPACK_UI_BUTTON_SIZE)
            //call BlzFrameSetTexture(BackpackItemFrame[index], GetIconByItemType(0), 0, true)
            //call BlzFrameSetText(BackpackItemFrame[index], I2S(index))
            call BlzFrameSetScale(BackpackItemFrame[index], 1.00)
            call BlzFrameSetVisible(BackpackItemFrame[index], false)

            set BackpackItemBackdropFrame[index] = BlzCreateFrameByType("BACKDROP", "BackdropFrame" + I2S(index), BackpackItemFrame[index], "", 1)
            call BlzFrameSetAllPoints(BackpackItemBackdropFrame[index], BackpackItemFrame[index])
//             call BlzFrameSetTexture(BackpackItemBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)
            call BlzFrameSetVisible(BackpackItemBackdropFrame[index], false)

            set BackpackItemTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTrigger[index], BackpackItemFrame[index], FRAMEEVENT_CONTROL_CLICK)
            call TriggerAddAction(BackpackItemTrigger[index], function BackpackClickItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 0, playerId)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemTrigger[index], 3, j)

            set BackpackItemMouseDownTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemMouseDownTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_DOWN)
            call TriggerAddAction(BackpackItemMouseDownTrigger[index], function BackpackMouseDownItemFunction)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 0, playerId)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemMouseDownTrigger[index], 3, j)

            set BackpackItemMouseUpTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemMouseUpTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_UP)
            call TriggerAddAction(BackpackItemMouseUpTrigger[index], function BackpackMouseUpItemFunction)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 0, playerId)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemMouseUpTrigger[index], 3, j)

            set BackpackItemTooltipOnTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOnTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_ENTER)
            call TriggerAddAction(BackpackItemTooltipOnTrigger[index], function BackpackEnterItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 0, playerId)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 1, index)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 2, i)
            call SaveTriggerParameterInteger(BackpackItemTooltipOnTrigger[index], 3, j)

            set BackpackItemTooltipOffTrigger[index] = CreateTrigger()
            call BlzTriggerRegisterFrameEvent(BackpackItemTooltipOffTrigger[index], BackpackItemFrame[index], FRAMEEVENT_MOUSE_LEAVE)
            call TriggerAddAction(BackpackItemTooltipOffTrigger[index], function BackpackLeaveItemFunction)
            call SaveTriggerParameterInteger(BackpackItemTooltipOffTrigger[index], 0, playerId)
            call SaveTriggerParameterInteger(BackpackItemTooltipOffTrigger[index], 1, index)

            // TODO Mouse down and mouse up to drag & drop to another bag or switch or do it like Warcraft's inventory with right click and left click. Add the icon of the item to the mouse cursor. If you click on the map it is dropped, if you click on the inventory it is dropped there.

            set BackpackItemChargesFrame[index] = BlzCreateFrameByType("TEXT", "charges" + I2S(index), BackpackItemFrame[index], "", 0)
            call BlzFrameSetAllPoints(BackpackItemChargesFrame[index], BackpackItemFrame[index])
            call BlzFrameSetText(BackpackItemChargesFrame[index], "|cffFFFFFFCharges|r")
            call BlzFrameSetTextAlignment(BackpackItemChargesFrame[index], TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT)
            call BlzFrameSetScale(BackpackItemChargesFrame[index], 1.0)
            call BlzFrameSetVisible(BackpackItemChargesFrame[index], false)
            call BlzFrameSetEnable(BackpackItemChargesFrame[index], false)

            set x = x + BACKPACK_UI_BUTTON_SIZE + BACKPACK_UI_BUTTON_SPACE

            set j = j + 1
        endloop

        set i = i + 1

        // every 3 bags start another line
        if (ModuloInteger(i, 3) == 0) then
            set x = 0.03
            set y = y - BACKPACK_UI_BUTTON_SIZE - BACKPACK_UI_BUTTON_SPACE
        endif
    endloop


    set BackpackTooltipFrame[playerId] = BlzCreateFrame("EscMenuBackdrop", BackpackBackgroundFrame[playerId],0,0)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame[playerId], FRAMEPOINT_TOPLEFT, 0.62, 0.54)
    call BlzFrameSetAbsPoint(BackpackTooltipFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, 0.78, 0.20)

    set BackpackItemGoldFrame[playerId] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame[playerId], FRAMEPOINT_TOPLEFT, 0.65, 0.50)
    call BlzFrameSetAbsPoint(BackpackItemGoldFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, 0.67, 0.48)
    //call BlzFrameSetAllPoints(BackpackItemGoldFrame[playerId], BackpackBackgroundFrame[playerId])
    call BlzFrameSetVisible(BackpackItemGoldFrame[playerId], false)

    set BackpackItemGoldIconFrame[playerId] = BlzCreateFrameByType("BACKDROP", "BackdropFrameGoldIcon" + I2S(playerId), BackpackItemGoldFrame[playerId], "", 1)
    call BlzFrameSetAllPoints(BackpackItemGoldIconFrame[index], BackpackItemGoldFrame[index])
    call BlzFrameSetTexture(BackpackItemGoldIconFrame[playerId], "UI\\Feedback\\Resources\\ResourceGold.blp", 0, true)
    call BlzFrameSetVisible(BackpackItemGoldIconFrame[playerId], false)

    set BackpackTooltipText[playerId] = BlzCreateFrameByType("TEXT", "BackpackTooltipText" + I2S(playerId),  BackpackBackgroundFrame[playerId], "", 0)
    call BlzFrameSetAbsPoint(BackpackTooltipText[playerId], FRAMEPOINT_TOPLEFT, 0.65, 0.505800)
    call BlzFrameSetAbsPoint(BackpackTooltipText[playerId], FRAMEPOINT_BOTTOMRIGHT, 0.74, 0.236500)
    call BlzFrameSetText(BackpackTooltipText[playerId], "")
    call BlzFrameSetEnable(BackpackTooltipText[playerId], false)
    call BlzFrameSetScale(BackpackTooltipText[playerId], 1.00)
    call BlzFrameSetTextAlignment(BackpackTooltipText[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    //call BlzFrameSetTooltip(Frame05, BackpackTooltipText[playerId])

    set BackpackCloseButton[playerId] = BlzCreateFrame("ScriptDialogButton", BackpackBackgroundFrame[playerId], 0, 0)
    set x = 0.34
    set y = 0.202
    call BlzFrameSetAbsPoint(BackpackCloseButton[playerId], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(BackpackCloseButton[playerId], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(BackpackCloseButton[playerId], "|cffFCD20DClose|r")
    call BlzFrameSetScale(BackpackCloseButton[playerId], 1.00)

    set BackpackCloseTrigger[playerId] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(BackpackCloseTrigger[playerId], BackpackCloseButton[playerId], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(BackpackCloseTrigger[playerId], function BackpackCloseFunction)
    call SaveTriggerParameterInteger(BackpackCloseTrigger[playerId], 0, playerId)

    call BlzFrameSetVisible(BackpackBackgroundFrame[playerId], false)
endfunction

function DestroyBackpackUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local integer playerId = GetPlayerId(whichPlayer)

    call BlzDestroyFrame(BackpackBackgroundFrame[playerId])
    set BackpackBackgroundFrame[playerId] = null

    call BlzDestroyFrame(BackpackTitleFrame[playerId])
    set BackpackTitleFrame[playerId] = null

    set i = 0
    loop
        exitwhen (i == udg_RucksackMaxPages)
        set j = 0
        loop
            exitwhen (j == bj_MAX_INVENTORY)
            set index = Index3D(playerId, i, j, udg_RucksackMaxPages, bj_MAX_INVENTORY)
            call BlzDestroyFrame(BackpackItemFrame[index])
            set BackpackItemFrame[index] = null

            call BlzDestroyFrame(BackpackItemBackdropFrame[index])
            set BackpackItemBackdropFrame[index] = null

            call DestroyParameterTrigger(BackpackItemTrigger[index])
            set BackpackItemTrigger[index] = null

            call DestroyParameterTrigger(BackpackItemMouseDownTrigger[index])
            set BackpackItemMouseDownTrigger[index] = null

            call DestroyParameterTrigger(BackpackItemMouseUpTrigger[index])
            set BackpackItemMouseUpTrigger[index] = null

            call DestroyParameterTrigger(BackpackItemTooltipOnTrigger[index])
            set BackpackItemTooltipOnTrigger[index] = null

            call DestroyParameterTrigger(BackpackItemTooltipOffTrigger[index])
            set BackpackItemTooltipOffTrigger[index] = null

            call DestroyParameterTrigger(BackpackItemTooltipOffTrigger[index])
            set BackpackItemTooltipOffTrigger[index] = null

            call BlzDestroyFrame(BackpackItemChargesFrame[index])
            set BackpackItemChargesFrame[index] = null
            set j = j + 1
        endloop

        set i = i + 1
    endloop


    call BlzDestroyFrame(BackpackTooltipFrame[playerId])
    set BackpackTooltipFrame[playerId] = null

    call BlzDestroyFrame(BackpackItemGoldFrame[playerId])
    set BackpackItemGoldFrame[playerId] = null

    call BlzDestroyFrame(BackpackItemGoldIconFrame[playerId])
    set BackpackItemGoldIconFrame[playerId] = null

    call BlzDestroyFrame(BackpackTooltipText[playerId])
    set BackpackTooltipText[playerId] = null

    call BlzDestroyFrame(BackpackCloseButton[playerId])
    set BackpackCloseButton[playerId] = null

    call DestroyParameterTrigger(BackpackCloseTrigger[playerId])
    set BackpackCloseTrigger[playerId] = null
endfunction

/**
 * AI Players GUI which helps to configure AI players.
 */
globals
    constant integer AI_PLAYERS_UI_MAX_PLAYERS = 5

    constant real AI_PLAYERS_UI_X = 0.0
    constant real AI_PLAYERS_UI_Y = 0.55
    constant real AI_PLAYERS_UI_SIZE_X = 0.80
    constant real AI_PLAYERS_UI_SIZE_Y = 0.38

    constant real AI_PLAYERS_UI_LINE_HEADERS_Y = AI_PLAYERS_UI_Y - 0.06
    constant real AI_PLAYERS_UI_LINE_HEADERS_HEIGHT = 0.027

    constant real AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X = AI_PLAYERS_UI_X + 0.05
    constant real AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH = 0.07

    constant real AI_PLAYERS_UI_COLUMN_SPACING_X = 0.007

    constant real AI_PLAYERS_UI_LINE_SPACING_Y = 0.007

    constant real AI_PLAYERS_UI_COLUMN_HERO_X = AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_HERO_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X = AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_START_LOCATION_X = AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_RACE_X = AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_RACE_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_PROFESSION_X = AI_PLAYERS_UI_COLUMN_RACE_X + AI_PLAYERS_UI_COLUMN_RACE_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_START_GOLD_X = AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_START_LUMBER_X = AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X = AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X = AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH + AI_PLAYERS_UI_COLUMN_SPACING_X
    constant real AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH = 0.058018

    constant real AI_PLAYERS_UI_TOOLTIP_X = 0.61
    constant real AI_PLAYERS_UI_TOOLTIP_WIDTH = 0.17
    constant real AI_PLAYERS_UI_TOOLTIP_HEIGHT = 0.34

    constant real AI_PLAYERS_UI_TOOLTIP_LABEL_X = 0.64
    constant real AI_PLAYERS_UI_TOOLTIP_LABEL_Y = 0.49
    constant real AI_PLAYERS_UI_TOOLTIP_LABEL_WIDTH = 0.10
    constant real AI_PLAYERS_UI_TOOLTIP_LABEL_HEIGHT = 0.32

    integer array AiPlayersUICounter
    force array AiPlayersUIForce
    integer array AiPlayersUIPage

    framehandle array AiPlayersUIBackgroundFrame
    framehandle array AiPlayersUITitleFrame

    // header line
    framehandle array AiPlayersUILabelFrameColumnPlayerName
    framehandle array AiPlayersUILabelFrameColumnHero
    framehandle array AiPlayersUILabelFrameColumnHeroStartLevel
    framehandle array AiPlayersUILabelFrameColumnStartLocation
    framehandle array AiPlayersUILabelFrameColumnRace // including freelancer
    framehandle array AiPlayersUILabelFrameColumnProfession
    framehandle array AiPlayersUILabelFrameColumnStartGold
    framehandle array AiPlayersUILabelFrameColumnStartLumber
    framehandle array AiPlayersUILabelFrameColumnFoodLimit
    framehandle array AiPlayersUILabelFrameColumnStartEvolution
    framehandle array AiPlayersUILabelFrameColumnStartImprovedPowerGenerator
    framehandle array AiPlayersUILabelFrameColumnStartImprovedCreepHunter
    framehandle array AiPlayersUILabelFrameColumnStartImprovedNavy

    // player lines
    framehandle array AiPlayersUILabelFrameColumnPlayerNameEdit
    framehandle array AiPlayersUILabelFrameColumnHeroEdit
    framehandle array AiPlayersUILabelFrameColumnHeroStartLevelEdit
    framehandle array AiPlayersUILabelFrameColumnStartLocationEdit
    framehandle array AiPlayersUILabelFrameColumnRaceEdit
    framehandle array AiPlayersUILabelFrameColumnProfessionEdit
    framehandle array AiPlayersUILabelFrameColumnStartGoldEdit
    framehandle array AiPlayersUILabelFrameColumnStartLumberEdit
    framehandle array AiPlayersUILabelFrameColumnFoodLimitEdit
    framehandle array AiPlayersUILabelFrameColumnStartEvolutionEdit

    // player settings
    string array AiPlayersUIPlayerName
    integer array AiPlayersUIHero
    integer array AiPlayersUIHeroStartLevel
    integer array AiPlayersUIHeroStartLocation
    integer array AiPlayersUIHeroStartRace

    // bottom buttons

    framehandle array AiPlayersUINextPageButton
    trigger array AiPlayersUINextPageTrigger

    framehandle array AiPlayersUIApplyButton
    trigger array AiPlayersUIApplyTrigger
endglobals

function CountAiPlayers takes nothing returns integer
    local player aiPlayer = null
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set aiPlayer = Player(i)
        if (GetPlayerController(aiPlayer) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(aiPlayer) == PLAYER_SLOT_STATE_PLAYING and aiPlayer != udg_BossesPlayer and aiPlayer != udg_TheBurningLegion and aiPlayer != udg_TheAlliance) then
            set counter = counter + 1
        endif
        set aiPlayer = null
        set i = i + 1
    endloop
    return counter
endfunction

function AiPlayersUIGetPlayerName takes integer playerId, integer counter returns string
    local integer index = Index2D(counter, playerId, bj_MAX_PLAYERS)

    return BlzFrameGetText(AiPlayersUILabelFrameColumnPlayerNameEdit[index])
endfunction

function SetAiPlayersUIVisible takes player whichPlayer, boolean visible returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer index = 0
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(AiPlayersUITitleFrame[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnPlayerName[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHero[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLocation[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnRace[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnProfession[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartGold[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLumber[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnFoodLimit[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartEvolution[playerId], visible)

        set i = 0
        loop
            exitwhen (i >= bj_MAX_PLAYERS)
            set index = Index2D(i, playerId, bj_MAX_PLAYERS)
            if (AiPlayersUILabelFrameColumnPlayerNameEdit[index] != null) then
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnPlayerNameEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLocationEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnRaceEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnProfessionEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartGoldEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLumberEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnFoodLimitEdit[index], visible)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], visible)
            endif
            set i = i + 1
        endloop

        call BlzFrameSetVisible(AiPlayersUIBackgroundFrame[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUIApplyButton[playerId], visible)
        call BlzFrameSetVisible(AiPlayersUINextPageButton[playerId], visible)
    endif
endfunction

function ShowAiPlayersUI takes player whichPlayer returns nothing
    call SetAiPlayersUIVisible(whichPlayer, true)
endfunction

function HideAiPlayersUI takes player whichPlayer returns nothing
    call SetAiPlayersUIVisible(whichPlayer, false)
endfunction

function AiPlayersUIApplyFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    //call BJDebugMsg("Click close")
    call HideAiPlayersUI(Player(playerId))
    call ConditionalTriggerExecute(gg_trg_Computer_Start_Lobby_Settings)
endfunction

function AiPlayersUINextPageFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    local boolean atEnd = AiPlayersUICounter[playerId] - AiPlayersUIPage[playerId] * AI_PLAYERS_UI_MAX_PLAYERS <= 0
    local integer startCounter = 0
    local integer endCounter = 0
    local integer i = 0
    local integer counter = 0
    local player aiPlayer = null
    local integer index = 0
    if (atEnd) then
        set AiPlayersUIPage[playerId] = 0
    else
        set AiPlayersUIPage[playerId] = AiPlayersUIPage[playerId] + 1
    endif
    set startCounter = AiPlayersUIPage[playerId] * AI_PLAYERS_UI_MAX_PLAYERS
    set endCounter = IMinBJ(startCounter + AI_PLAYERS_UI_MAX_PLAYERS, AiPlayersUICounter[playerId])
    set i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set aiPlayer = Player(i)
        if (IsPlayerInForce(aiPlayer, AiPlayersUIForce[playerId])) then
            if (counter >= startCounter and counter <= endCounter) then
                set index = Index2D(counter - startCounter, playerId, bj_MAX_PLAYERS)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnPlayerNameEdit[index], GetPlayerName(aiPlayer))
                // TODO Set all fields
            endif
            set counter = counter + 1
        endif
        set aiPlayer = null
        set i = i + 1
    endloop
endfunction

function CreateAiPlayersUI takes player whichPlayer returns nothing
    local integer i = 0
    local integer counter = 0
    local player aiPlayer = null
    local integer index = 0
    local real x
    local real y
    local integer playerId = GetPlayerId(whichPlayer)

    set AiPlayersUIBackgroundFrame[playerId] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(AiPlayersUIBackgroundFrame[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_X, AI_PLAYERS_UI_Y)
    call BlzFrameSetAbsPoint(AiPlayersUIBackgroundFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_X + AI_PLAYERS_UI_SIZE_X, AI_PLAYERS_UI_Y - AI_PLAYERS_UI_SIZE_Y)

    set AiPlayersUITitleFrame[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiTitle" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUITitleFrame[playerId], FRAMEPOINT_TOPLEFT, 0.0, 0.52)
    call BlzFrameSetAbsPoint(AiPlayersUITitleFrame[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_SIZE_X, 0.54 - 0.1)
    call BlzFrameSetText(AiPlayersUITitleFrame[playerId], "AI Players")
    call BlzFrameSetTextAlignment(AiPlayersUITitleFrame[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUITitleFrame[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUITitleFrame[playerId], false)

    // header line
    set AiPlayersUILabelFrameColumnPlayerName[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLinePlayerName" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnPlayerName[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnPlayerName[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnPlayerName[playerId], "Player Name")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnPlayerName[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnPlayerName[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnPlayerName[playerId], false)

    set AiPlayersUILabelFrameColumnHero[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHero" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHero[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHero[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnHero[playerId], "Hero")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnHero[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnHero[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHero[playerId], false)

    set AiPlayersUILabelFrameColumnHeroStartLevel[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineHeroStartLevel" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], "Hero Start Level")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroStartLevel[playerId], false)

    set AiPlayersUILabelFrameColumnStartLocation[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLocation" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLocation[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLocation[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnStartLocation[playerId], "Start Location")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnStartLocation[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnStartLocation[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLocation[playerId], false)

    set AiPlayersUILabelFrameColumnRace[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineRace" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnRace[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnRace[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + AI_PLAYERS_UI_COLUMN_RACE_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnRace[playerId], "Race")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnRace[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnRace[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnRace[playerId], false)

    set AiPlayersUILabelFrameColumnProfession[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineProfession" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnProfession[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PROFESSION_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnProfession[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnProfession[playerId], "Profession")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnProfession[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnProfession[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnProfession[playerId], false)

    set AiPlayersUILabelFrameColumnStartGold[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartGold" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartGold[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_GOLD_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartGold[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnStartGold[playerId], "Start Gold")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnStartGold[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnStartGold[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartGold[playerId], false)

    set AiPlayersUILabelFrameColumnStartLumber[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartLumber" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLumber[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLumber[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnStartLumber[playerId], "Start Lumber")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnStartLumber[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnStartLumber[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLumber[playerId], false)

    set AiPlayersUILabelFrameColumnFoodLimit[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineFoodLimit" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnFoodLimit[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnFoodLimit[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnFoodLimit[playerId], "Food Limit")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnFoodLimit[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnFoodLimit[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnFoodLimit[playerId], false)

    set AiPlayersUILabelFrameColumnStartEvolution[playerId] = BlzCreateFrameByType("TEXT", "AiPlayersGuiHeaderLineStartEvolution" + I2S(playerId), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartEvolution[playerId], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X, AI_PLAYERS_UI_LINE_HEADERS_Y)
    call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartEvolution[playerId], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH, AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
    call BlzFrameSetText(AiPlayersUILabelFrameColumnStartEvolution[playerId], "Start Evolution")
    call BlzFrameSetTextAlignment(AiPlayersUILabelFrameColumnStartEvolution[playerId], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(AiPlayersUILabelFrameColumnStartEvolution[playerId], 1.0)
    call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartEvolution[playerId], false)

    set y = AI_PLAYERS_UI_LINE_HEADERS_Y - AI_PLAYERS_UI_LINE_SPACING_Y
    set AiPlayersUIForce[playerId] = CreateForce()

    // players
    set i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set aiPlayer = Player(i)
        if (GetPlayerController(aiPlayer) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(aiPlayer) == PLAYER_SLOT_STATE_PLAYING and aiPlayer != udg_BossesPlayer and aiPlayer != udg_TheBurningLegion and aiPlayer != udg_TheAlliance) then
            set counter = counter + 1
            call ForceAddPlayer(AiPlayersUIForce[playerId], aiPlayer)

            if (counter < AI_PLAYERS_UI_MAX_PLAYERS) then
                set index = Index2D(counter, playerId, bj_MAX_PLAYERS)

                set AiPlayersUILabelFrameColumnPlayerNameEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnPlayerNameEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnPlayerNameEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PLAYER_NAME_X + AI_PLAYERS_UI_COLUMN_PLAYER_NAME_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnPlayerNameEdit[index], GetPlayerName(aiPlayer))
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnPlayerNameEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnPlayerNameEdit[index], false)

                set AiPlayersUILabelFrameColumnHeroEdit[index] = BlzCreateFrame("HeroesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_X, y)
                //call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_X + AI_PLAYERS_UI_COLUMN_HERO_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                //call BlzFrameSetText(AiPlayersUILabelFrameColumnHeroEdit[index], "AI " + I2S(i + 1))
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnHeroEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroEdit[index], false)

                set AiPlayersUILabelFrameColumnHeroStartLevelEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_X + AI_PLAYERS_UI_COLUMN_HERO_START_LEVEL_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], "1")
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnHeroStartLevelEdit[index], false)

                set AiPlayersUILabelFrameColumnStartLocationEdit[index] = BlzCreateFrame("StartLocationsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLocationEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X, y)
                //call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLocationEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LOCATION_X + AI_PLAYERS_UI_COLUMN_START_LOCATION_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                //call BlzFrameSetText(AiPlayersUILabelFrameColumnStartLocationEdit[index], "AI " + I2S(i + 1))
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnStartLocationEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLocationEdit[index], false)

                set AiPlayersUILabelFrameColumnRaceEdit[index] = BlzCreateFrame("RacesPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnRaceEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_RACE_X, y)
                //call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnRaceEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_RACE_X + AI_PLAYERS_UI_COLUMN_RACE_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                //call BlzFrameSetText(AiPlayersUILabelFrameColumnRaceEdit[index], "AI " + I2S(i + 1))
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnRaceEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnRaceEdit[index], false)

                set AiPlayersUILabelFrameColumnProfessionEdit[index] = BlzCreateFrame("ProfessionsPopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnProfessionEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_PROFESSION_X, y)
                //call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnProfessionEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_PROFESSION_X + AI_PLAYERS_UI_COLUMN_PROFESSION_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                //call BlzFrameSetText(AiPlayersUILabelFrameColumnProfessionEdit[index], "AI " + I2S(i + 1))
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnProfessionEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnProfessionEdit[index], false)

                set AiPlayersUILabelFrameColumnStartGoldEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartGoldEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_GOLD_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartGoldEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_GOLD_X + AI_PLAYERS_UI_COLUMN_START_GOLD_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnStartGoldEdit[index], "500")
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnStartGoldEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartGoldEdit[index], false)

                set AiPlayersUILabelFrameColumnStartLumberEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLumberEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartLumberEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_LUMBER_X + AI_PLAYERS_UI_COLUMN_START_LUMBER_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnStartLumberEdit[index], "400")
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnStartLumberEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartLumberEdit[index], false)

                set AiPlayersUILabelFrameColumnFoodLimitEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnFoodLimitEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnFoodLimitEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_X + AI_PLAYERS_UI_COLUMN_FOOD_LIMIT_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnFoodLimitEdit[index], "300")
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnFoodLimitEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnFoodLimitEdit[index], false)

                set AiPlayersUILabelFrameColumnStartEvolutionEdit[index] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], FRAMEPOINT_TOPLEFT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X, y)
                call BlzFrameSetAbsPoint(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], FRAMEPOINT_BOTTOMRIGHT, AI_PLAYERS_UI_COLUMN_START_EVOLUTION_X + AI_PLAYERS_UI_COLUMN_START_EVOLUTION_WIDTH, y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT)
                call BlzFrameSetText(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], "1")
                call BlzFrameSetEnable(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], true)
                call BlzFrameSetVisible(AiPlayersUILabelFrameColumnStartEvolutionEdit[index], false)

                set y = y - AI_PLAYERS_UI_LINE_HEADERS_HEIGHT - AI_PLAYERS_UI_LINE_SPACING_Y
            endif
        endif
        set aiPlayer = null
        set i = i + 1
    endloop

    set AiPlayersUICounter[playerId] = counter

    // apply button

    set AiPlayersUIApplyButton[playerId] = BlzCreateFrame("ScriptDialogButton", AiPlayersUIBackgroundFrame[playerId], 0, 0)
    set x = 0.34
    set y = 0.24
    call BlzFrameSetAbsPoint(AiPlayersUIApplyButton[playerId], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(AiPlayersUIApplyButton[playerId], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(AiPlayersUIApplyButton[playerId], "|cffFCD20DApply|r")
    call BlzFrameSetScale(AiPlayersUIApplyButton[playerId], 1.00)

    set AiPlayersUIApplyTrigger[playerId] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(AiPlayersUIApplyTrigger[playerId], AiPlayersUIApplyButton[playerId], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(AiPlayersUIApplyTrigger[playerId], function AiPlayersUIApplyFunction)
    call SaveTriggerParameterInteger(AiPlayersUIApplyTrigger[playerId], 0, playerId)


    // next page button

    set AiPlayersUINextPageButton[playerId] = BlzCreateFrame("ScriptDialogButton", AiPlayersUIBackgroundFrame[playerId], 0, 0)
    set x = 0.50
    set y = 0.24
    call BlzFrameSetAbsPoint(AiPlayersUINextPageButton[playerId], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(AiPlayersUINextPageButton[playerId], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(AiPlayersUINextPageButton[playerId], "|cffFCD20DNext Page|r")
    call BlzFrameSetScale(AiPlayersUINextPageButton[playerId], 1.00)
    call BlzFrameSetEnable(AiPlayersUINextPageButton[playerId], counter > AI_PLAYERS_UI_MAX_PLAYERS)

    set AiPlayersUINextPageTrigger[playerId] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(AiPlayersUINextPageTrigger[playerId], AiPlayersUINextPageButton[playerId], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(AiPlayersUINextPageTrigger[playerId], function AiPlayersUINextPageFunction)
    call SaveTriggerParameterInteger(AiPlayersUINextPageTrigger[playerId], 0, playerId)

    // hide
    call BlzFrameSetVisible(AiPlayersUIBackgroundFrame[playerId], false)
endfunction

/**
 * Savecode GUI which helps to copy & paste savecodes.
 */
globals
    constant real SAVECODE_UI_LABEL_X = 0.055
    constant real SAVECODE_UI_LABEL_WIDTH = 0.058018

    constant real SAVECODE_UI_LINEEDIT_X = SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH + 0.01
    constant real SAVECODE_UI_LINEEDIT_WIDTH = 0.35

    constant real SAVECODE_UI_UPDATE_BUTTON_X = 0.47837
    constant real SAVECODE_UI_UPDATE_BUTTON_WIDTH = 0.060

    constant real SAVECODE_UI_LOAD_BUTTON_X = 0.54136
    constant real SAVECODE_UI_LOAD_BUTTON_WIDTH = 0.060

    constant real SAVECODE_UI_LOAD_AUTO_BUTTON_X = 0.3
    constant real SAVECODE_UI_LOAD_AUTO_BUTTON_WIDTH = 0.066

    constant real SAVECODE_UI_WRITE_AUTO_BUTTON_X = 0.4
    constant real SAVECODE_UI_WRITE_AUTO_BUTTON_WIDTH = 0.066

    constant real SAVECODE_UI_LINE_START_Y = 0.528122
    constant real SAVECODE_UI_LINE_HEIGHT = 0.03
    constant real SAVECODE_UI_LINE_SPACING = 0.01

    constant real SAVECODE_UI_TOOLTIP_X = 0.61
    constant real SAVECODE_UI_TOOLTIP_WIDTH = 0.17
    constant real SAVECODE_UI_TOOLTIP_HEIGHT = 0.34

    constant real SAVECODE_UI_TOOLTIP_LABEL_X = 0.64
    constant real SAVECODE_UI_TOOLTIP_LABEL_Y = 0.49
    constant real SAVECODE_UI_TOOLTIP_LABEL_WIDTH = 0.10
    constant real SAVECODE_UI_TOOLTIP_LABEL_HEIGHT = 0.32

    framehandle array SaveCodeUIBackgroundFrame
    framehandle array SaveCodeUITitleFrame

    framehandle array SaveCodeUITooltipBackgroundFrame
    framehandle array SaveCodeUITooltipLabelFrame

    // line 1: heroes savecode
    framehandle array SaveCodeUILabelFrameHeroes
    framehandle array SaveCodeUIEditBoxHeroes
    trigger array SaveCodeUITriggerEditBoxHeroes
    framehandle array SaveCodeUIUpdateButtonFrameHeroes
    trigger array SaveCodeUIUpdateTriggerHeroes
    framehandle array SaveCodeUILoadButtonFrameHeroes
    trigger array SaveCodeUILoadTriggerHeroes
    trigger array SaveCodeUIEnterTriggerHeroes

    // line 2: items savecode
    framehandle array SaveCodeUILabelFrameItems
    framehandle array SaveCodeUIEditBoxItems
    trigger array SaveCodeUITriggerEditBoxItems
    framehandle array SaveCodeUIUpdateButtonFrameItems
    trigger array SaveCodeUIUpdateTriggerItems
    framehandle array SaveCodeUILoadButtonFrameItems
    trigger array SaveCodeUILoadTriggerItems
    trigger array SaveCodeUIEnterTriggerItems

    // line 3: units savecode
    framehandle array SaveCodeUILabelFrameUnits
    framehandle array SaveCodeUIEditBoxUnits
    trigger array SaveCodeUITriggerEditBoxUnits
    framehandle array SaveCodeUIUpdateButtonFrameUnits
    trigger array SaveCodeUIUpdateTriggerUnits
    framehandle array SaveCodeUILoadButtonFrameUnits
    trigger array SaveCodeUILoadTriggerUnits
    trigger array SaveCodeUIEnterTriggerUnits

    // line 4: researches savecode
    framehandle array SaveCodeUILabelFrameResearches
    framehandle array SaveCodeUIEditBoxResearches
    trigger array SaveCodeUITriggerEditBoxResearches
    framehandle array SaveCodeUIUpdateButtonFrameResearches
    trigger array SaveCodeUIUpdateTriggerResearches
    framehandle array SaveCodeUILoadButtonFrameResearches
    trigger array SaveCodeUILoadTriggerResearches
    trigger array SaveCodeUIEnterTriggerResearches

    // line 5: buildings savecode
    framehandle array SaveCodeUILabelFrameBuildings
    framehandle array SaveCodeUIEditBoxBuildings
    trigger array SaveCodeUITriggerEditBoxBuildings
    framehandle array SaveCodeUIUpdateButtonFrameBuildings
    trigger array SaveCodeUIUpdateTriggerBuildings
    framehandle array SaveCodeUILoadButtonFrameBuildings
    trigger array SaveCodeUILoadTriggerBuildings
    trigger array SaveCodeUIEnterTriggerBuildings


    // line 6: clan savecode
    framehandle array SaveCodeUILabelFrameClan
    framehandle array SaveCodeUIEditBoxClan
    trigger array SaveCodeUITriggerEditBoxClan
    framehandle array SaveCodeUIUpdateButtonFrameClan
    trigger array SaveCodeUIUpdateTriggerClan
    framehandle array SaveCodeUILoadButtonFrameClan
    trigger array SaveCodeUILoadTriggerClan
    trigger array SaveCodeUIEnterTriggerClan

    // end line: all save codes
    framehandle array SaveCodeUILabelFrameAll
    framehandle array SaveCodeUIWriteAllButtonFrameAll
    trigger array SaveCodeUIWriteAllTriggerAll
    framehandle array SaveCodeUILoadAllButtonFrameAll
    trigger array SaveCodeUILoadAllTriggerAll
    framehandle array SaveCodeUIUpdateButtonFrameAll
    trigger array SaveCodeUIUpdateTriggerAll
    framehandle array SaveCodeUILoadButtonFrameAll
    trigger array SaveCodeUILoadTriggerAll

    framehandle array SaveCodeUICloseButton
    trigger array SaveCodeUICloseTrigger
endglobals

function SetSaveCodeUITooltip takes player whichPlayer, string tooltip returns nothing
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], tooltip)
endfunction

function FormattedSaveCodeHeroes takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-load ")) then
        return StringRemoveFromStart(saveCode, "-load ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIHeroesText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIHeroesText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIHeroesText takes player whichPlayer returns nothing
    call SetSaveCodeUIHeroesText(whichPlayer, "-load " + GetSaveCode(whichPlayer))
endfunction

function SetSaveCodeUITooltipHeroesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeHeroes(GetSaveCodeUIHeroesText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Heroes:|n" + GetSaveCodeInfos(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeItems takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadi ")) then
        return StringRemoveFromStart(saveCode, "-loadi ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIItemsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIItemsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIItemsText takes player whichPlayer returns nothing
    call SetSaveCodeUIItemsText(whichPlayer, "-loadi " + GetSaveCodeItems(whichPlayer))
endfunction

function SetSaveCodeUITooltipItemsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeItems(GetSaveCodeUIItemsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Items:|n" + GetSaveCodeInfosItems(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeUnits takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadu ")) then
        return StringRemoveFromStart(saveCode, "-loadu ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIUnitsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIUnitsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIUnitsText takes player whichPlayer returns nothing
    call SetSaveCodeUIUnitsText(whichPlayer, "-loadu " + GetSaveCodeUnits(whichPlayer))
endfunction

function SetSaveCodeUITooltipUnitsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeUnits(GetSaveCodeUIUnitsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Units:|n" + GetSaveCodeInfosUnits(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeResearches takes string saveCode returns string
    //call BJDebugMsg("Click load heroes")
    if (StringStartsWith(saveCode, "-loadr ")) then
        return StringRemoveFromStart(saveCode, "-loadr ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIResearchesText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIResearchesText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIResearchesText takes player whichPlayer returns nothing
    call SetSaveCodeUIResearchesText(whichPlayer, "-loadr " + GetSaveCodeResearches(whichPlayer))
endfunction

function SetSaveCodeUITooltipResearchesSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResearches(GetSaveCodeUIResearchesText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Researches:|n" + GetSaveCodeInfosResearches(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeBuildings takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadb ")) then
        return StringRemoveFromStart(saveCode, "-loadb ")
    endif

    return saveCode
endfunction

function SetSaveCodeUIBuildingsText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIBuildingsText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIBuildingsText takes player whichPlayer returns nothing
    call SetSaveCodeUIBuildingsText(whichPlayer, "-loadb " + GetSaveCodeBuildings(whichPlayer))
endfunction

function SetSaveCodeUITooltipBuildingsSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeBuildings(GetSaveCodeUIBuildingsText(whichPlayer))
    call SetSaveCodeUITooltip(whichPlayer, "Buildings:|n" + GetSaveCodeInfosBuildings(whichPlayer, saveCode))
endfunction

function FormattedSaveCodeClan takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadc ")) then
        return StringToken(saveCode, 1)
    endif

    return StringToken(saveCode, 0)
endfunction

function FormattedSaveCodeClanName takes string saveCode returns string
    if (StringStartsWith(saveCode, "-loadc ")) then
        return StringToken(saveCode, 2)
    endif

    return StringToken(saveCode, 1)
endfunction

function SetSaveCodeUIClanText takes player whichPlayer, string txt returns nothing
    call BlzFrameSetText(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], txt)
endfunction

function GetSaveCodeUIClanText takes player whichPlayer returns string
    return BlzFrameGetText(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)])
endfunction

function UpdateSaveCodeUIClanText takes player whichPlayer returns nothing
    if (udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)] > 0) then
        call SetSaveCodeUIClanText(whichPlayer, "-loadc " + GetSaveCodeClan(udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)]) + " " + udg_ClanName[udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)]])
    endif
endfunction

function SetSaveCodeUITooltipClanSaveCodeInfo takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeClan(GetSaveCodeUIClanText(whichPlayer))
    local string clanName = FormattedSaveCodeClanName(GetSaveCodeUIClanText(whichPlayer))
    //call BJDebugMsg("Clan name: " + clanName)
    if (StringLength(clanName) > 0) then
        call SetSaveCodeUITooltip(whichPlayer, "Clan:|n" + GetSaveCodeInfosClan(clanName, saveCode))
    else
        call SetSaveCodeUITooltip(whichPlayer, "Missing clan name! Enter \"-loadc XXX <Clan Name>\"")
    endif
endfunction

function SaveCodeUIUpdateAll takes player whichPlayer returns nothing
    call UpdateSaveCodeUIHeroesText(whichPlayer)
    call UpdateSaveCodeUIItemsText(whichPlayer)
    call UpdateSaveCodeUIUnitsText(whichPlayer)
    call UpdateSaveCodeUIResearchesText(whichPlayer)
    call UpdateSaveCodeUIBuildingsText(whichPlayer)
    call UpdateSaveCodeUIClanText(whichPlayer)
endfunction

function SetSaveCodeUIVisible takes player whichPlayer, boolean visible returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], visible)
        // heroes
        call BlzFrameSetVisible(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], visible)
        // items
        call BlzFrameSetVisible(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], visible)
        // units
        call BlzFrameSetVisible(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], visible)
        // researches
        call BlzFrameSetVisible(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], visible)
        // buildings
        call BlzFrameSetVisible(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], visible)
        // clan
        call BlzFrameSetVisible(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], visible)
        // all
        call BlzFrameSetVisible(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        //call BlzFrameSetVisible(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        call BlzFrameSetVisible(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], visible)
        // close
        call BlzFrameSetVisible(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], visible)
    endif

    if (visible) then
        call SaveCodeUIUpdateAll(whichPlayer)
    endif
endfunction

function ShowSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, true)
endfunction

function HideSaveCodeUI takes player whichPlayer returns nothing
    call SetSaveCodeUIVisible(whichPlayer, false)
endfunction

function SaveCodeUIEditBoxEnterHeroes takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipHeroesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionHeroes takes nothing returns nothing
    call SaveCodeUIEditBoxEnterHeroes(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionHeroes takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateSaveCodeUIHeroesText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for heroes.")
endfunction

function SaveCodeUILoadHeroes takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeHeroes(GetSaveCodeUIHeroesText(whichPlayer))
    //call BJDebugMsg("Click load heroes")

    if (TimerGetRemaining(udg_SaveCodeCooldownHeroTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCode(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownHeroTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownHeroes)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: "  + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load hero savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownHeroTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionHeroes takes nothing returns nothing
    call SaveCodeUILoadHeroes(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterItems takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipItemsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionItems takes nothing returns nothing
    call SaveCodeUIEditBoxEnterItems(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionItems takes nothing returns nothing
    //call BJDebugMsg("Click update heroes")
    call UpdateSaveCodeUIItemsText(GetTriggerPlayer())
    call SetSaveCodeUITooltip(GetTriggerPlayer(), "Updated savecode for items.")
endfunction

function SaveCodeUILoadItems takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeItems(GetSaveCodeUIItemsText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeItems(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load item savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownItemsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionItems takes nothing returns nothing
    call SaveCodeUILoadItems(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterUnits takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipUnitsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionUnits takes nothing returns nothing
    call SaveCodeUIEditBoxEnterUnits(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionUnits takes nothing returns nothing
    //call BJDebugMsg("Click update units")
    call UpdateSaveCodeUIUnitsText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for units.")
endfunction

function SaveCodeUILoadUnits takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeUnits(GetSaveCodeUIUnitsText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeUnits(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load unit savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownUnitsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionUnits takes nothing returns nothing
    call SaveCodeUILoadUnits(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterResearches takes player whichPlayer returns nothing
     call SetSaveCodeUITooltipResearchesSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeUIEnterFunctionResearches takes nothing returns nothing
    call SaveCodeUIEditBoxEnterResearches(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionResearches takes nothing returns nothing
    //call BJDebugMsg("Click update researches")
    call UpdateSaveCodeUIResearchesText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for researches.")
endfunction

function SaveCodeUILoadResearches takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeResearches(GetSaveCodeUIResearchesText(whichPlayer))

    if (TimerGetRemaining(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeResearches(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load research savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownResearchesTime[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionResearches takes nothing returns nothing
    call SaveCodeUILoadResearches(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterBuildings takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipBuildingsSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionBuildings takes nothing returns nothing
    call SaveCodeUIEditBoxEnterBuildings(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionBuildings takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateSaveCodeUIBuildingsText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for buildings.")
endfunction

function SaveCodeUILoadBuildings takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeBuildings(GetSaveCodeUIBuildingsText(whichPlayer))
    //call BJDebugMsg("Click load buildings")

    if (TimerGetRemaining(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeBuildings(whichPlayer, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load building savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownBuildingsTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionBuildings takes nothing returns nothing
    call SaveCodeUILoadBuildings(GetTriggerPlayer())
endfunction

function SaveCodeUIEditBoxEnterClan takes player whichPlayer returns nothing
    call SetSaveCodeUITooltipClanSaveCodeInfo(whichPlayer)
endfunction

function SaveCodeEnterFunctionClan takes nothing returns nothing
    call SaveCodeUIEditBoxEnterClan(GetTriggerPlayer())
endfunction

function SaveCodeUIUpdateFunctionClan takes nothing returns nothing
    //call BJDebugMsg("Click update buildings")
    call UpdateSaveCodeUIClanText(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated savecode for clan.")
endfunction

function SaveCodeUILoadClan takes player whichPlayer returns nothing
    local string saveCode = FormattedSaveCodeClan(GetSaveCodeUIClanText(whichPlayer))
    local string clanName = FormattedSaveCodeClanName(GetSaveCodeUIClanText(whichPlayer))
    //call BJDebugMsg("Click load buildings")

    if (TimerGetRemaining(udg_SaveCodeCooldownClanTimer[GetConvertedPlayerId(whichPlayer)]) <= 0.0) then
        if (ApplySaveCodeClan(whichPlayer, clanName, saveCode)) then
            call StartTimerBJ(udg_SaveCodeCooldownClanTimer[GetConvertedPlayerId(whichPlayer)], false, udg_SaveCodeCooldownObjects)
            call SetSaveCodeUITooltip(whichPlayer, "Successfully loaded the savecode: " + ColoredSaveCode(saveCode))
        else
            call SetSaveCodeUITooltip(whichPlayer, "Error on loading the savecode: " + ColoredSaveCode(saveCode))
        endif
    else
        call SetSaveCodeUITooltip(whichPlayer, "You can load clan savecodes in: " + FormatTimeString(R2I(TimerGetRemaining(udg_SaveCodeCooldownClanTimer[GetConvertedPlayerId(whichPlayer)]))))
    endif
endfunction

function SaveCodeUILoadFunctionClan takes nothing returns nothing
    call SaveCodeUILoadClan(GetTriggerPlayer())
endfunction

function SaveCodeUILoadAllFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click load auto")
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Tried to load all savecodes.")
endfunction

function SaveCodeUIWriteAllFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click write auto")
    local string clanSaveCode = null
    if (udg_ClanPlayerClan[GetConvertedPlayerId(GetTriggerPlayer())] > 0) then
        set clanSaveCode = GetSaveCodeClan(udg_ClanPlayerClan[GetConvertedPlayerId(GetTriggerPlayer())])
    endif
    call CreateSaveCodeAllTextFile(GetTriggerPlayer())

    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Saved all save codes into \"XXX-all.txt\".")
endfunction

function SaveCodeUIUpdateFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click update all")
    call SaveCodeUIUpdateAll(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Updated all savecodes.")
endfunction

function SaveCodeUILoadFunctionAll takes nothing returns nothing
    //call BJDebugMsg("Click load all")
    call SaveCodeUILoadHeroes(GetTriggerPlayer())
    call SaveCodeUILoadItems(GetTriggerPlayer())
    call SaveCodeUILoadUnits(GetTriggerPlayer())
    call SaveCodeUILoadResearches(GetTriggerPlayer())
    call SaveCodeUILoadBuildings(GetTriggerPlayer())
    call SaveCodeUILoadClan(GetTriggerPlayer())
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(GetTriggerPlayer())], "Tried to load all savecodes.")
endfunction

function SaveCodeUICloseFunction takes nothing returns nothing
    local integer playerId = LoadTriggerParameterInteger(GetTriggeringTrigger(), 0)
    //call BJDebugMsg("Click close")
    call HideSaveCodeUI(Player(playerId))
endfunction

function CreateSaveCodeUI takes player whichPlayer returns nothing
    local real x
    local real y

    set SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.57)
    call BlzFrameSetAbsPoint(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.57 - BACKPACK_UI_SIZE_Y)

    set SaveCodeUITitleFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiTitle" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, 0.0, 0.54)
    call BlzFrameSetAbsPoint(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, BACKPACK_UI_SIZE_X, 0.54 - 0.1)
    call BlzFrameSetText(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], "Save Codes")
    call BlzFrameSetTextAlignment(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetScale(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], 1.0)
    call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], false)

    set SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_TOOLTIP_X, SAVECODE_UI_LINE_START_Y)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_TOOLTIP_X + SAVECODE_UI_TOOLTIP_WIDTH, SAVECODE_UI_LINE_START_Y - SAVECODE_UI_TOOLTIP_HEIGHT)

    set SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiTooltipLabel" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_TOOLTIP_LABEL_X, SAVECODE_UI_TOOLTIP_LABEL_Y)
    call BlzFrameSetAbsPoint(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_TOOLTIP_LABEL_X + SAVECODE_UI_TOOLTIP_LABEL_WIDTH, SAVECODE_UI_TOOLTIP_LABEL_Y - SAVECODE_UI_TOOLTIP_LABEL_HEIGHT)
    call BlzFrameSetText(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], "Save Code Info")
    call BlzFrameSetEnable(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

    // line 1: heroes
    set y = SAVECODE_UI_LINE_START_Y

    set SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelHeroes" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], "|cffFFCC00Heroes:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionHeroes)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxHeroes[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionHeroes)

    set SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionHeroes)

    set SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerHeroes[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionHeroes)

    // line 2: items
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelItems" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], "|cffFFCC00Items:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionItems)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxItems[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionItems)

    set SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionItems)

    set SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerItems[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionItems)

    // line 3: units
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelUnits" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], "|cffFFCC00Units:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionUnits)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxUnits[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionUnits)

    set SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionUnits)

    set SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerUnits[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionUnits)

    // line 4: researches
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelResearches" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], "|cffFFCC00Researches:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)], function SaveCodeUIEnterFunctionResearches)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxResearches[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUIEnterFunctionResearches)

    set SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionResearches)

    set SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerResearches[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionResearches)

    // line 4: buildings
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelBuildings" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], "|cffFFCC00Buildings:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], "-load xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionBuildings)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxBuildings[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionBuildings)

    set SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionBuildings)

    set SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerBuildings[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionBuildings)

    // line 5: clan
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelClan" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], "|cffFFCC00Clan:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], true)

    set SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)] = BlzCreateFrame("EscMenuEditBoxTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LINEEDIT_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LINEEDIT_X + SAVECODE_UI_LINEEDIT_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], "-loadc xxx")
    call BlzFrameSetEnable(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], true)

    set SaveCodeUITriggerEditBoxClan[GetPlayerId(whichPlayer)] = CreateTrigger()
    call TriggerAddAction(SaveCodeUITriggerEditBoxClan[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionClan)
    call BlzTriggerRegisterFrameEvent(SaveCodeUITriggerEditBoxClan[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], FRAMEEVENT_EDITBOX_ENTER)

    set SaveCodeUIEnterTriggerClan[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIEnterTriggerClan[GetPlayerId(whichPlayer)], SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], FRAMEEVENT_MOUSE_ENTER)
    call TriggerAddAction(SaveCodeUIEnterTriggerClan[GetPlayerId(whichPlayer)], function SaveCodeEnterFunctionClan)

    set SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerClan[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerClan[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerClan[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionClan)

    set SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerClan[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerClan[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerClan[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionClan)


    // final line: all
    set y = y - SAVECODE_UI_LINE_HEIGHT - SAVECODE_UI_LINE_SPACING

    set SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrameByType("TEXT", "SaveGuiLabelAll" + I2S(GetPlayerId(whichPlayer)), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LABEL_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LABEL_X + SAVECODE_UI_LABEL_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], "|cffFFCC00All:|r")
    call BlzFrameSetEnable(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetScale(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], 1.00)
    call BlzFrameSetTextAlignment(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetEnable(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], true)

    //set SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    //call BlzFrameSetAbsPoint(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_AUTO_BUTTON_X, y)
    //call BlzFrameSetAbsPoint(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_AUTO_BUTTON_X + SAVECODE_UI_LOAD_AUTO_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    //call BlzFrameSetText(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DLoad All|r")
    //call BlzFrameSetScale(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    //set SaveCodeUILoadAllTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    //call BlzTriggerRegisterFrameEvent(SaveCodeUILoadAllTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    //call TriggerAddAction(SaveCodeUILoadAllTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUILoadAllFunctionAll)

    set SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_WRITE_AUTO_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_WRITE_AUTO_BUTTON_X + SAVECODE_UI_WRITE_AUTO_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DWrite All|r")
    call BlzFrameSetScale(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIWriteAllTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIWriteAllTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIWriteAllTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUIWriteAllFunctionAll)

    set SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_UPDATE_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_UPDATE_BUTTON_X + SAVECODE_UI_UPDATE_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DUpdate|r")
    call BlzFrameSetScale(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUIUpdateTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUIUpdateFunctionAll)

    set SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, SAVECODE_UI_LOAD_BUTTON_X, y)
    call BlzFrameSetAbsPoint(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, SAVECODE_UI_LOAD_BUTTON_X + SAVECODE_UI_LOAD_BUTTON_WIDTH, y - SAVECODE_UI_LINE_HEIGHT)
    call BlzFrameSetText(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], "|cffFCD20DLoad|r")
    call BlzFrameSetScale(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)], SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUILoadTriggerAll[GetPlayerId(whichPlayer)], function SaveCodeUILoadFunctionAll)

    // close button


    //eventHandler = CreateTrigger() --Create the FRAMEEVENT_EDITBOX_TEXT_CHANGED trigger
    //TriggerAddAction(eventHandler, TEXT_CHANGED)
    //BlzTriggerRegisterFrameEvent(eventHandler, editbox, FRAMEEVENT_EDITBOX_TEXT_CHANGED)

    set SaveCodeUICloseButton[GetPlayerId(whichPlayer)] = BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    set x = 0.34
    set y = 0.22
    call BlzFrameSetAbsPoint(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEPOINT_BOTTOMRIGHT, x + 0.12, y - 0.03)
    call BlzFrameSetText(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], "|cffFCD20DClose|r")
    call BlzFrameSetScale(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], 1.00)

    set SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)] = CreateTrigger()
    call BlzTriggerRegisterFrameEvent(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], SaveCodeUICloseButton[GetPlayerId(whichPlayer)], FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], function SaveCodeUICloseFunction)
    call SaveTriggerParameterInteger(SaveCodeUICloseTrigger[GetPlayerId(whichPlayer)], 0, GetPlayerId(whichPlayer))

    call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITitleFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITooltipBackgroundFrame[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUITooltipLabelFrame[GetPlayerId(whichPlayer)], false)
    // heroes
    call BlzFrameSetVisible(SaveCodeUILabelFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameHeroes[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameHeroes[GetPlayerId(whichPlayer)], false)
    // items
    call BlzFrameSetVisible(SaveCodeUILabelFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameItems[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameItems[GetPlayerId(whichPlayer)], false)
    // units
    call BlzFrameSetVisible(SaveCodeUILabelFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameUnits[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameUnits[GetPlayerId(whichPlayer)], false)
    // researches
    call BlzFrameSetVisible(SaveCodeUILabelFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameResearches[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameResearches[GetPlayerId(whichPlayer)], false)
    // buildings
    call BlzFrameSetVisible(SaveCodeUILabelFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameBuildings[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameBuildings[GetPlayerId(whichPlayer)], false)
    // clan
    call BlzFrameSetVisible(SaveCodeUILabelFrameClan[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIEditBoxClan[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameClan[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameClan[GetPlayerId(whichPlayer)], false)
    // all
    call BlzFrameSetVisible(SaveCodeUILabelFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIWriteAllButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadAllButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUIUpdateButtonFrameAll[GetPlayerId(whichPlayer)], false)
    call BlzFrameSetVisible(SaveCodeUILoadButtonFrameAll[GetPlayerId(whichPlayer)], false)
    // close
    call BlzFrameSetVisible(SaveCodeUICloseButton[GetPlayerId(whichPlayer)], false)
endfunction

// Prestored Savecodes

globals
    constant integer PRESTORED_SAVECODE_TYPE_HEROES = 0
    constant integer PRESTORED_SAVECODE_TYPE_ITEMS = 1
    constant integer PRESTORED_SAVECODE_TYPE_UNITS = 2
    constant integer PRESTORED_SAVECODE_TYPE_BUILDINGS = 3
    constant integer PRESTORED_SAVECODE_TYPE_RESEARCHES = 4
    constant integer PRESTORED_SAVECODE_TYPE_CLANS = 5
    constant integer PRESTORED_SAVECODE_TYPE_LETTER = 6

    constant integer PRESTORED_SAVECODE_MAX_CLAN_MEMBERS = 20

    string array PrestoredSaveCodePlayerName // can also be the clan name
    string array PrestoredSaveCode
    integer array PrestoredSaveCodeType
    boolean array PrestoredSaveCodeMultiplayer
    string array PrestoredSaveCodePlayerNames // only for clan save codes
    integer array PrestoredSaveCodePlayerRanks // only for clan save codes
    integer array PrestoredSaveCodePlayerNamesCounter // only for clan save codes
    integer PrestoredSaveCodeCounter = 0

    integer lastAddedPrestoredClan = 0

    force prestoredElvenClanMembers = CreateForce()
endglobals

function GetPrestoredClanSaveCodeMatchingPlayer takes integer saveCodeIndex returns player
    local player result = null
    local integer playerRank = -1
    local integer index = 0
    local integer i = 0
    local integer j = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        if (GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING) then
            set j = 0
            loop
                exitwhen (j >= PrestoredSaveCodePlayerNamesCounter[saveCodeIndex])
                set index = Index2D(saveCodeIndex, j, PRESTORED_SAVECODE_MAX_CLAN_MEMBERS)
                //call BJDebugMsg("Comparing player name " + PrestoredSaveCodePlayerNames[index] + " to online player name " + GetPlayerName(Player(i)))
                if (GetPlayerName(Player(i)) == PrestoredSaveCodePlayerNames[index] and PrestoredSaveCodePlayerRanks[index] > playerRank) then
                    set result = Player(i)
                    set playerRank = PrestoredSaveCodePlayerRanks[index]
                endif
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
    return result
endfunction

function LoadPrestoredClanSaveCodes takes nothing returns nothing
    local player matchingPlayer = null
    local boolean foundElvenClan = false
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS) then
            if (PrestoredSaveCodePlayerName[i] == "TheElvenClan" and PrestoredSaveCodeMultiplayer[i] == not IsInSinglePlayer()) then
                set foundElvenClan = true
                set matchingPlayer = GetPrestoredClanSaveCodeMatchingPlayer(i)
                if (matchingPlayer != null) then
                    //call BJDebugMsg("Applying TheElvenClan savecode for player " + GetPlayerName(matchingPlayer))
                    call ApplySaveCodeClan(matchingPlayer, "TheElvenClan", PrestoredSaveCode[i])
                    set j = 0
                    loop
                        exitwhen (j >= bj_MAX_PLAYERS)
                        if (GetPlayerController(Player(j)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(j)) == PLAYER_SLOT_STATE_PLAYING and udg_ClanPlayerClan[j + 1] > 0 and udg_ClanName[udg_ClanPlayerClan[j + 1]] == "TheElvenClan") then
                            //call BJDebugMsg("Adding player to TheElvenClan")
                            call ForceAddPlayer(prestoredElvenClanMembers, Player(j))
                        endif
                        set j = j + 1
                    endloop
                endif
            endif
        endif
        set i = i + 1
    endloop
    if (not foundElvenClan) then
        //call BJDebugMsg("Did not find TheElvenClan")
    endif
    if (matchingPlayer == null) then
        //call BJDebugMsg("No player of TheElvenClan is online")
    endif
endfunction

function PlayerIsInElvenClan takes player whichPlayer returns boolean
    return IsPlayerInForce(whichPlayer, prestoredElvenClanMembers)
endfunction

function AddPrestoredSaveCodeEx takes integer saveCodeType, string playerName, string saveCode returns integer
    local integer index = PrestoredSaveCodeCounter
    set PrestoredSaveCodePlayerName[index] = playerName
    set PrestoredSaveCode[index] = saveCode
    set PrestoredSaveCodeType[index] = saveCodeType
    set PrestoredSaveCodePlayerNamesCounter[index] = 0
    set PrestoredSaveCodeCounter = PrestoredSaveCodeCounter + 1
    set lastAddedPrestoredClan = index
    return index
endfunction

function AddPrestoredSaveCode takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_HEROES, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeItems takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_ITEMS, playerName, saveCode)
endfunction


function AddPrestoredSaveCodeUnits takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_UNITS, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeBuildings takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_BUILDINGS, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeResearches takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_RESEARCHES, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeLetter takes string playerName, string saveCode returns integer
    return AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_LETTER, playerName, saveCode)
endfunction

function AddPrestoredSaveCodeClan takes string clanName, boolean isSinglePlayer, string saveCode returns integer
    local integer result = AddPrestoredSaveCodeEx(PRESTORED_SAVECODE_TYPE_CLANS, clanName, saveCode)
    set PrestoredSaveCodeMultiplayer[result] = not isSinglePlayer
    return result
endfunction

function AddPrestoredSaveCodeClanPlayer takes string playerName, integer playerRank returns integer
    local integer saveCodePlayerIndex = PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan]
    local integer index = Index2D(lastAddedPrestoredClan, saveCodePlayerIndex, PRESTORED_SAVECODE_MAX_CLAN_MEMBERS)
    set PrestoredSaveCodePlayerNames[index] = playerName
    set PrestoredSaveCodePlayerRanks[index] = playerRank
    set PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan] = PrestoredSaveCodePlayerNamesCounter[lastAddedPrestoredClan] + 1
    return saveCodePlayerIndex
endfunction

function GetPrestoredSaveCodePlayerNameByIndex takes integer index returns string
    return PrestoredSaveCodePlayerName[index]
endfunction

function GetPrestoredSaveCodeByIndex takes integer index returns string
    return PrestoredSaveCode[index]
endfunction

function GetPrestoredSaveCodeCounter takes string playerName returns integer
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName) then
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return counter
endfunction

function GetPrestoredSaveCodeIndices takes string playerName returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result + "- " + I2S(i)
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeAccounts takes nothing returns string
    local string result = ""
    local string array onlinePlayers
    local player array onlinePlayersMatching
    local integer onlinePlayersCounter = 0
    local string array offlinePlayers
    local integer offlinePlayersCounter = 0
    local player matchingPlayer = null
    local boolean add = true
    local integer counter = 0
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] != PRESTORED_SAVECODE_TYPE_CLANS and PrestoredSaveCodePlayerName[i] != "all") then
            set add = true
            set matchingPlayer = null
            set j = 0
            loop
                exitwhen (j >= bj_MAX_PLAYERS or matchingPlayer != null)
                if (GetPlayerName(Player(j)) == PrestoredSaveCodePlayerName[i]) then
                    set matchingPlayer = Player(j)
                endif
                set j = j + 1
            endloop
            if (matchingPlayer != null) then
                set j = 0
                loop
                    exitwhen (j >= onlinePlayersCounter or not add)
                    if (onlinePlayers[j] == PrestoredSaveCodePlayerName[i]) then
                        set add = false
                    endif
                    set j = j + 1
                endloop
                if (add) then
                    set onlinePlayers[onlinePlayersCounter] = PrestoredSaveCodePlayerName[i]
                    set onlinePlayersMatching[onlinePlayersCounter] = matchingPlayer
                    set onlinePlayersCounter = onlinePlayersCounter + 1
                endif
            else
                set j = 0
                loop
                    exitwhen (j >= offlinePlayersCounter or not add)
                    if (offlinePlayers[j] == PrestoredSaveCodePlayerName[i]) then
                        set add = false
                    endif
                    set j = j + 1
                endloop
                if (add) then
                    set offlinePlayers[offlinePlayersCounter] = PrestoredSaveCodePlayerName[i]
                    set offlinePlayersCounter = offlinePlayersCounter + 1
                endif
            endif
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= onlinePlayersCounter)
        if (counter > 0) then
            set result = result + "\n"
        endif

        set result = result + GetPlayerNameColored(onlinePlayersMatching[i])
        set counter = counter + 1
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= offlinePlayersCounter)
        if (counter > 0) then
            set result = result + "\n"
        endif

        set result = result  + offlinePlayers[i] + " (offline)"
        set counter = counter + 1
        set i = i + 1
    endloop

    return result
endfunction

// only shows matching savecodes to keep the number limited
function GetPrestoredSaveCodeInfos takes player whichPlayer returns string
    local string playerName = GetPlayerName(whichPlayer)
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodePlayerName[i] == playerName or PrestoredSaveCodePlayerName[i] == "all") then
            if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_HEROES and GetSaveCodeIsMatching(whichPlayer, PrestoredSaveCode[i])) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadp " + I2S(i) + ": " + GetSaveCodeShortInfos(playerName, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_ITEMS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpi " + I2S(i) + ": " + GetSaveCodeShortInfosItems(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_UNITS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpu " + I2S(i) + ": " + GetSaveCodeShortInfosUnits(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_BUILDINGS) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpb " + I2S(i) + ": " + GetSaveCodeShortInfosBuildings(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
            elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_RESEARCHES) then
                if (counter > 0) then
                    set result = result + "\n"
                endif

                set result = result  + "-loadpr " + I2S(i) + ": " + GetSaveCodeShortInfosResearches(whichPlayer, PrestoredSaveCode[i])

                set counter = counter + 1
//             elseif (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_LETTER) then
//                 if (counter > 0) then
//                     set result = result + "\n"
//                 endif
//
//                 set result = result  + "-loadpl " + I2S(i) + ": " + GetSaveCodeShortInfosLetter(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
//
//                 set counter = counter + 1
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeInfosClans takes nothing returns string
    local string result = ""
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_CLANS) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result  + "- " + I2S(i) + ": " + GetSaveCodeShortInfosClan(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeInfosLetters takes player whichPlayer returns string
    local string result = ""
    local string playerName = GetPlayerName(whichPlayer)
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if (PrestoredSaveCodeType[i] == PRESTORED_SAVECODE_TYPE_LETTER and (PrestoredSaveCodePlayerName[i] == playerName or PrestoredSaveCodePlayerName[i] == "all" or (udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)] > 0 and udg_ClanName[udg_ClanPlayerClan[GetConvertedPlayerId(whichPlayer)]] == PrestoredSaveCodePlayerName[i]))) then
            if (counter > 0) then
                set result = result + "\n"
            endif
            set result = result  + "-loadpl " + I2S(i) + ": " + GetSaveCodeShortInfosLetter(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            set counter = counter + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function GetPrestoredSaveCodeMaxLevelIndex takes string skipPlayerName1, string skipPlayerName2, string skipPlayerName3 returns integer
    local integer maxLevel = 0
    local integer tmpMaxLevel = 0
    local integer result = -1
    local integer i = 0
    loop
        exitwhen (i >= PrestoredSaveCodeCounter)
        if ((skipPlayerName1 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName1) and (skipPlayerName2 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName2) and (skipPlayerName3 == null or GetPrestoredSaveCodePlayerNameByIndex(i) != skipPlayerName3)) then
            set tmpMaxLevel = GetSaveCodeMaxHeroLevel(PrestoredSaveCodePlayerName[i], PrestoredSaveCode[i])
            if (tmpMaxLevel > maxLevel) then
                set maxLevel = tmpMaxLevel
                set result = i
            endif
        endif
        set i = i + 1
    endloop

    return result
endfunction

// Floating Text Utility Functions

function ShowTextTagForForce takes force whichForce, texttag textTag, boolean show returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        call SetTextTagVisibility(textTag, true)
    endif
endfunction

function ShowFadingTextTagForForce takes force whichForce, string text, real size, real x, real y, integer red, integer green, integer blue, integer alpha, real velocity, real fadepoint, real lifespan returns nothing
    local player localPlayer
    local texttag textTag = CreateTextTag()
    call SetTextTagText(textTag, text, size)
    call SetTextTagPos(textTag, x, y, 0.0)
    call SetTextTagColor(textTag, red, green, blue, alpha)
    call SetTextTagVelocity(textTag, 0.0, velocity)
    if (whichForce == null) then
        call SetTextTagVisibility(textTag, true)
    else
        call ShowTextTagForForce(whichForce, textTag, true)
    endif
    call SetTextTagFadepoint(textTag, fadepoint)
    call SetTextTagLifespan(textTag, lifespan)
    call SetTextTagPermanent(textTag, false)
    set textTag = null
endfunction

function ShowGeneralFadingTextTagForForce takes force whichForce, string text, real x, real y, integer red, integer green, integer blue, integer alpha returns nothing
    call ShowFadingTextTagForForce(whichForce, text, 0.025, x, y, red, green, blue, alpha, 0.03, 1.0, 2.0)
endfunction

function ShowGoldTextTagForForce takes force whichForce, real x, real y, integer gold returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(gold), 0.025, x, y, 255, 220, 0, 255, 0.03, 1.0, 2.0)
endfunction

function ShowLumberTextTagForForce takes force whichForce, real x, real y, integer lumber returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(lumber), 0.025, x, y, 0, 200, 80, 255, 0.03, 1.0, 2.0)
endfunction

function ShowBountyTextTagForForce takes force whichForce, real x, real y, integer bounty returns nothing
    call ShowFadingTextTagForForce(whichForce, "+" + I2S(bounty), 0.025, x, y, 255, 220, 0, 255, 0.03, 2.0, 3.0)
endfunction

function ShowMissTextTagForForce takes force whichForce, real x, real y returns nothing
    call ShowFadingTextTagForForce(whichForce, GetLocalizedString("MISS") + "!", 0.025, x, y, 255, 0, 0, 255, 0.03, 1.0, 3.0)
endfunction

function ShowCriticalStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowShadowStrikeTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 160, 255, 0, 255, 0.04, 2.0, 5.0)
endfunction

function ShowManaBurnTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, "-" + I2S(damage), 0.025, x, y, 82, 82, 255, 255, 0.04, 2.0, 5.0)
endfunction

function ShowBashTextTagForForce takes force whichForce, real x, real y, integer damage returns nothing
    call ShowFadingTextTagForForce(whichForce, I2S(damage) + "!", 0.025, x, y, 255, 0, 0, 255, 0.04, 2.0, 5.0)
endfunction

function Bounty takes force whichForce, real x, real y, integer bounty returns nothing
    local string effectPath = ""
    local effect whichEffect
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), whichForce)) then
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + bounty)
        endif
        set i = i + 1
    endloop
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        set effectPath = "UI\\Feedback\\GoldCredit\\GoldCredit.mdl"
    endif
    set whichEffect = AddSpecialEffect(effectPath, x, y)
    call DestroyEffect(whichEffect)
    set whichEffect = null
    call ShowBountyTextTagForForce(whichForce, x, y, bounty)
endfunction

function RandomizeString takes string source returns string
    local string result = ""
    local integer sourcePosition = 0
    loop
        exitwhen (StringLength(source) == 0)
        set sourcePosition = GetRandomInt(0, StringLength(source) - 1)
        set result = result + SubString(source, sourcePosition, sourcePosition + 1)
        set source = SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, StringLength(source))
    endloop

    return result
endfunction

// Goblin Tunnel System

globals
    constant integer GOBLIN_TUNNEL_DIRECTION_NORTH = 0
    constant integer GOBLIN_TUNNEL_DIRECTION_SOUTH = 1
    constant integer GOBLIN_TUNNEL_DIRECTION_WEST = 2
    constant integer GOBLIN_TUNNEL_DIRECTION_EAST = 3
    constant integer GOBLIN_TUNNEL_DIRECTION_PREVIOUS = 4
    constant integer GOBLIN_TUNNEL_DIRECTION_NORTH_START = 5
    constant integer GOBLIN_TUNNEL_DIRECTION_SOUTH_START = 6
    constant integer GOBLIN_TUNNEL_DIRECTION_WEST_START = 7
    constant integer GOBLIN_TUNNEL_DIRECTION_EAST_START = 8
    constant integer GOBLIN_TUNNEL_DIRECTION_USER_1 = 9

    constant integer GOBLIN_TUNNEL_SYSTEM = 'o018'
    constant integer GOBLIN_TUNNEL = 'o00P'
    constant real GOBLIN_TUNNEL_EXPAND_DISTANCE = 100.0

    constant integer GOBLIN_TUNNEL_START_ABILITY_ID = 'A0CS'
    constant integer GOBLIN_TUNNEL_END_ABILITY_ID = 'A0CT'
endglobals

function GetAngleByGoblinTunnelDirection takes integer direction returns real
    if (direction == GOBLIN_TUNNEL_DIRECTION_NORTH) then
        return 90.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_SOUTH) then
        return 270.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_WEST) then
        return 180.0
    elseif (direction == GOBLIN_TUNNEL_DIRECTION_EAST) then
        return 0.0
    endif

    return 0.0
endfunction

function SetNextGoblinTunnelPart takes unit whichUnit, integer direction, unit part returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction, part)
endfunction

function GetNextGoblinTunnelPart takes unit whichUnit, integer direction returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction)
endfunction

function SetPreviousGoblinTunnelPart takes unit whichUnit, unit part returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_PREVIOUS, part)
endfunction

function GetPreviousGoblinTunnelPart takes unit whichUnit returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_PREVIOUS)
endfunction

function SetUserGoblinTunnelPartDestructable takes unit whichUnit, destructable part returns nothing
    call SaveDestructableHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_USER_1, part)
endfunction

function GetUserGoblinTunnelPartDestructable takes unit whichUnit returns destructable
    return LoadDestructableHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), GOBLIN_TUNNEL_DIRECTION_USER_1)
endfunction

function GetGoblinTunnelSystem takes unit whichUnit returns unit
    local unit tmpUnit = whichUnit
    loop
        set tmpUnit = GetPreviousGoblinTunnelPart(whichUnit)
        exitwhen (tmpUnit == null)
        set whichUnit = tmpUnit
    endloop

    if (GetUnitTypeId(whichUnit) == GOBLIN_TUNNEL_SYSTEM) then
        return whichUnit
    endif

    return null
endfunction

function SetGoblinTunnelSystemStart takes unit whichUnit, integer direction, unit start returns nothing
    call SaveUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction + GOBLIN_TUNNEL_DIRECTION_PREVIOUS + 1, start)
endfunction

function GetGoblinTunnelSystemStart takes unit whichUnit, integer direction returns unit
    return LoadUnitHandle(udg_GoblinTunnelsUnits, GetHandleId(whichUnit), direction + GOBLIN_TUNNEL_DIRECTION_PREVIOUS + 1)
endfunction

function FilterFunctionIsLivingGoblinTunnel takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == 'o00P' and IsUnitAliveBJ(GetFilterUnit())
endfunction


function GetNextGoblinTunnelEx takes unit start, integer direction, group allConnected, integer recursionLevel returns unit
    local unit next = GetNextGoblinTunnelPart(start, direction)

    if (next != null) then
        if (allConnected != null) then
            call GroupAddUnit(allConnected, next)
        endif

        return GetNextGoblinTunnelEx(next, direction, allConnected, recursionLevel + 1)
    else
        //call BJDebugMsg("Return start")

        return start
    endif
endfunction

function GetNextGoblinTunnel takes unit start, integer direction returns unit
    local unit next = GetNextGoblinTunnelEx(start, direction, null, 0)

    if (next != null) then
        return next
    else
        //call BJDebugMsg("Return start")

        return start
    endif
endfunction

function PolarProjectionX takes real x, real angle, real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function PolarProjectionY takes real y, real angle, real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function AngleBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

function ExpandGoblinTunnelEx takes unit start, integer direction, integer unitTypeId, boolean waygate, integer endAbilityId, real distance returns unit
    local real angle = GetAngleByGoblinTunnelDirection(direction)
    local unit previous = GetNextGoblinTunnel(start, direction)
    local unit expanded = null
    local unit system = null
    if (previous != null and GetNextGoblinTunnelPart(previous, direction) == null) then
        set expanded = CreateUnit(GetOwningPlayer(start), unitTypeId, PolarProjectionX(GetUnitX(previous), angle, distance), PolarProjectionY(GetUnitY(previous), angle, distance), bj_UNIT_FACING)
        call SetNextGoblinTunnelPart(previous, direction, expanded)
        call SetPreviousGoblinTunnelPart(expanded, previous)
        call GroupAddUnit(udg_GoblinTunnels, expanded)

        if (GetUnitTypeId(previous) == GOBLIN_TUNNEL_SYSTEM) then
            call SetGoblinTunnelSystemStart(previous, direction, expanded)
            if (waygate) then
                call WaygateActivate(expanded, true)
                call WaygateSetDestination(expanded, GetUnitX(expanded), GetUnitY(expanded))
            endif

            if (endAbilityId != 0) then
                call UnitAddAbility(expanded, endAbilityId)
            endif
        else
            call WaygateActivate(previous, false)
            call UnitRemoveAbility(previous, GOBLIN_TUNNEL_END_ABILITY_ID)

            set system = GetGoblinTunnelSystem(expanded)
            if (system != null) then
                set system = GetGoblinTunnelSystemStart(system, direction)
                if (system != null) then
                    if (waygate) then
                        call WaygateActivate(system, true)
                        call WaygateSetDestination(system, GetUnitX(expanded), GetUnitY(expanded))
                    endif

                    if (endAbilityId != 0) then
                        call UnitAddAbility(expanded, endAbilityId)
                    endif

                    if (waygate) then
                        call WaygateActivate(expanded, true)
                        call WaygateSetDestination(expanded, GetUnitX(system), GetUnitY(system))
                    endif
                endif
            endif
        endif
    else
        call BJDebugMsg("Previous: " + GetUnitName(previous) + " and next existing part " + GetUnitName(GetNextGoblinTunnelPart(previous, direction)))
    endif

    return expanded
endfunction

function ExpandGoblinTunnel takes unit start, integer direction returns unit
    return ExpandGoblinTunnelEx(start, direction, GOBLIN_TUNNEL, true, GOBLIN_TUNNEL_END_ABILITY_ID, GOBLIN_TUNNEL_EXPAND_DISTANCE)
endfunction

function UpdateDeadGoblinTunnelPart takes unit whichUnit returns nothing
    local unit previous = GetPreviousGoblinTunnelPart(whichUnit)
    local unit next = null
    local integer i = 0
    loop
        exitwhen (i == GOBLIN_TUNNEL_DIRECTION_EAST + 1)
        set next = GetNextGoblinTunnelPart(whichUnit, i)
        if (next != null) then
            call SetPreviousGoblinTunnelPart(next, null)
        endif
        set i = i + 1
    endloop
    if (previous != null) then
        set i = 0
        loop
            exitwhen (i == GOBLIN_TUNNEL_DIRECTION_EAST + 1)
            set next = GetNextGoblinTunnelPart(previous, i)
            if (next == whichUnit) then
                call SetNextGoblinTunnelPart(previous, i, null)
                exitwhen (true)
            endif
            set i = i + 1
        endloop
    endif
endfunction

function GetAllConnectedGoblinTunnelParts takes unit start returns group
    local group result = CreateGroup()
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_NORTH, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_SOUTH, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_WEST, result, 0)
    call GetNextGoblinTunnelEx(start, GOBLIN_TUNNEL_DIRECTION_EAST, result, 0)

    return result
endfunction

function ForGroupFunctionKill takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function KillAllConnectedGoblinTunnelParts takes unit start returns nothing
    local group connected = GetAllConnectedGoblinTunnelParts(start)
    call ForGroup(connected, function ForGroupFunctionKill)
    call GroupClear(connected)
    call DestroyGroup(connected)
    set connected = null
endfunction

// Railroad System

function FilterFunctionIsRailroad takes nothing returns boolean
    return (GetUnitTypeId(GetEnumUnit()) == 'o01N' or GetUnitTypeId(GetEnumUnit()) == 'o01K') and IsUnitAliveBJ(GetEnumUnit())
endfunction

function GetRailroad takes unit train, real angle returns unit
    local group whichGroup = CreateGroup()
    local unit result = null
    local unit first = null
    call GroupEnumUnitsInRange(whichGroup, PolarProjectionX(GetUnitX(train), angle, 40.0), PolarProjectionY(GetUnitY(train), angle, 40.0), 200.0, Filter(function FilterFunctionIsRailroad))
    loop
        exitwhen (result != null)
        set first = FirstOfGroup(whichGroup)
        exitwhen (first == null)
        if (GetOwningPlayer(first) == GetOwningPlayer(train) or IsUnitAlly(first, GetOwningPlayer(train))) then
            set result = first
        endif
        call GroupRemoveUnit(whichGroup, first)
    endloop

    call GroupClear(whichGroup)
    call DestroyGroup(whichGroup)
    set whichGroup = null

    return result
endfunction

function GetNextRailroad takes unit source returns unit
    return GetRailroad(source, 90.0)
endfunction

function GetPreviousRailroad takes unit source returns unit
    return GetRailroad(source, 270.0)
endfunction

// Hero Ability System

globals
    hashtable HeroAbilitiesHashTable = InitHashtable()
    hashtable HeroAbilitiesMaximumLevelHashTable = InitHashtable()
endglobals

function GetHeroAbilityMaximum takes integer unitTypeId returns integer
    return LoadInteger(HeroAbilitiesHashTable, unitTypeId, 0) + 1
endfunction

function GetHeroAbility takes integer unitTypeId, integer index returns integer
    return LoadInteger(HeroAbilitiesHashTable, unitTypeId, index)
endfunction

function GetHeroAbilityMaximumLevel takes integer unitTypeId, integer index returns integer
    return LoadInteger(HeroAbilitiesMaximumLevelHashTable, unitTypeId, index)
endfunction

function GetHeroAbilityIndex takes integer unitTypeId, integer abilityId returns integer
    local integer i = 1
    local integer max = GetHeroAbilityMaximum(unitTypeId)
    loop
        exitwhen (i >= max)
        if (GetHeroAbility(unitTypeId, i) == abilityId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function RegisterHeroAbilityEx takes integer unitTypeId, integer abilityId, integer maxLevel returns integer
    local integer maxIndex = GetHeroAbilityMaximum(unitTypeId)
    call SaveInteger(HeroAbilitiesHashTable, unitTypeId, 0, maxIndex)
    call SaveInteger(HeroAbilitiesHashTable, unitTypeId, maxIndex, abilityId)
    call SaveInteger(HeroAbilitiesMaximumLevelHashTable, unitTypeId, maxIndex, maxLevel)

    return maxIndex
endfunction

function RegisterHeroAbility takes nothing returns integer
    return RegisterHeroAbilityEx(udg_TmpUnitType, udg_TmpAbilityCode, udg_TmpInteger)
endfunction

function RemoveHeroAbility takes unit hero, integer abilityId returns boolean
    local integer level = GetUnitAbilityLevel(hero, abilityId)
    local integer skillPoints = GetHeroSkillPoints(hero)
    local integer index = GetHeroAbilityIndex(GetUnitTypeId(hero), abilityId)
    local integer diff = GetHeroAbilityMaximumLevel(GetUnitTypeId(hero), index) - level
    local integer i = 0
    if (index < 1) then
        call BJDebugMsg("Invalid ability index " + I2S(index) + " for hero ability " + GetObjectName(abilityId) + " for unit type " + GetObjectName(GetUnitTypeId(hero)))
    endif
    //call BJDebugMsg("Removing hero ability " + GetObjectName(abilityId) + " by adding " + I2S(diff) + " skill points and skilling the ability to its max level which currently has level " + I2S(level) + " (readded as skill points) to remove it.")
    // TODO Do we need to increase the hero level as well for skip requirements? We will have to disable ALL triggers which react to a gain level event!
    if (diff > 0) then
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_ADD, diff)
        set i = 0
        loop
            exitwhen (i == diff)
            call SelectHeroSkill(hero, abilityId)
            set i = i + 1
        endloop
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_SET, skillPoints)
    endif

    // give all skill points back
    if (level > 0) then
        call ModifyHeroSkillPoints(hero, bj_MODIFYMETHOD_ADD, level)
    endif

    return UnitRemoveAbility(hero, abilityId)
endfunction

function RemoveAllHeroAbilities takes unit hero returns nothing
    local integer max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
    local integer i = 1
    loop
        exitwhen (i >= max)
        call RemoveHeroAbility(hero, GetHeroAbility(GetUnitTypeId(hero), i))
        set i = i + 1
    endloop
endfunction

function AddAllHeroAbilities takes unit hero returns nothing
    local integer max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
    local integer i = 1
    loop
        exitwhen (i >= max)
        call BJDebugMsg("Adding hero ability " + GetObjectName(GetHeroAbility(GetUnitTypeId(hero), i)))
        if (GetUnitAbilityLevel(hero, GetHeroAbility(GetUnitTypeId(hero), i)) <= 0) then
            call UnitAddAbility(hero, GetHeroAbility(GetUnitTypeId(hero), i))
            call SetUnitAbilityLevel(hero, GetHeroAbility(GetUnitTypeId(hero), i), 0)
        endif
        set i = i + 1
    endloop
endfunction

function AutoSkillHero takes unit hero returns integer
    local integer level = GetHeroLevel(hero)
    local integer skillPoints = GetHeroSkillPoints(hero)
    local integer start = level - skillPoints
    //local integer modulo = 0
    local boolean matched = false
    local integer remaining = skillPoints
    local integer index = 1
    local integer max = 0
    local integer abilityId = 0
    local integer abilityMaxLevel = 0
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i >= skillPoints)
        set matched = false
        //set modulo = ModuloInteger(start + i, 5)
        set max = GetHeroAbilityMaximum(GetUnitTypeId(hero))
        set index = 1
        loop
            exitwhen (index >= max or matched)
            set abilityId = GetHeroAbility(GetUnitTypeId(hero), index)
            set abilityMaxLevel = GetHeroAbilityMaximumLevel(GetUnitTypeId(hero), index)
            if (GetUnitAbilityLevel(hero, abilityId) < abilityMaxLevel) then
                call SelectHeroSkill(hero, abilityId)
                set remaining = remaining - 1
                set matched = true
            endif
            set index = index + 1
        endloop
        exitwhen (not matched)
        set i = i + 1
    endloop

    return remaining
endfunction

function SetEvolutionLevelOfPlayer takes player whichPlayer, integer level returns nothing
    call SetPlayerTechResearched(whichPlayer, UPG_EVOLUTION, level)
endfunction

function GetEvolutionLevelOfPlayer takes player whichPlayer returns integer
    return GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
endfunction

// Order Record System

globals
    trigger orderTrigger
endglobals

function TriggerConditionDebugOrder takes nothing returns boolean
    local string order = OrderId2String(GetIssuedOrderId())
    return order != "move" and order != "harvest" and order != "stop" and order != "attack" and order != "resumeharvesting" and order != "smart" and order != "unsubmerge"
endfunction

function GetOrderName takes integer orderId returns string
    if (UnitId2String(orderId) != "" and UnitId2String(orderId) != null) then
        return UnitId2String(orderId)
    elseif (AbilityId2String(orderId) != "" and AbilityId2String(orderId) != null) then
        return AbilityId2String(orderId)
    endif

     return OrderId2String(orderId)
endfunction

function TriggerActionDebugOrder takes nothing returns nothing
    if (GetOrderTargetUnit() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target unit " + GetUnitName(GetOrderTargetUnit()))
    elseif (GetOrderTargetDestructable() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target destructible " + GetDestructableName(GetOrderTargetDestructable()))
    elseif (GetOrderTargetItem() != null) then
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()) + " for target item " + GetItemName(GetOrderTargetItem()))
    else
        call BJDebugMsg(GetPlayerNameColored(GetOwningPlayer(GetTriggerUnit())) + ": Issuing order with ID " + I2S(GetIssuedOrderId()) + " with name " + GetOrderName(GetIssuedOrderId()) + " for unit " + GetUnitName(GetTriggerUnit()))
    endif
endfunction

function InitOrderDebugger takes nothing returns nothing
    set orderTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionDebugOrder))
    call TriggerAddAction(orderTrigger, function TriggerActionDebugOrder)
    call DisableTrigger(orderTrigger)
endfunction

function EnableOrderDebugger takes nothing returns nothing
    call EnableTrigger(orderTrigger)
endfunction

function DisableOrderDebugger takes nothing returns nothing
    call DisableTrigger(orderTrigger)
endfunction

// Baradé's Item Unstack System 1.6
//
// Supports the missing Warcraft III feature of unstacking stacked items in your inventory.
//
// Usage:
// - Enable Warcraft's native stack system in the "Advanced - Gameplay Constants - Inventory - Enable Item Stacking".
// - Give certain item types a maximum stack value: "Stats - Max Stacks". Note that some of them like Wards do already have specified some values greater than 0 here.
// - Copy this code into your map script or a trigger converted into code.
// - Optional: Adapt the values of the constants for your map.
// - Optional: Redefine ItemUnstackItemGetMaxStacks if necessary.
// - Optional (recommended): Change the "Advanced - Game Interface - Text - General" from "|cff808080Drop item on shop to sell|R" into "|cff808080Drop item on shop to sell|NDouble right click item to unstack|R" to guide the player.
//
// Download:
// https://www.hiveworkshop.com/threads/barad%C3%A9s-item-unstack-system-1-1.339109/

// Define this function, to return custom values. It is only used if CHECK_MAX_STACKS is false.
constant function ItemUnstackItemGetMaxStacks takes integer itemTypeId returns integer
    return 1000
endfunction

library ItemUnstackSystem initializer Init requires optional MaxItemStacks

globals
    // The number of charges which are unstacked at maximum if available.
    private constant integer MAX_UNSTACKED_CHARGES = 1
    // Overwrites the previous value if set to true. It always unstacks the half of charges. For uneven numbers it will unstack the lower value. For example, for 3 it will unstack 1 charge.
    private constant boolean UNSTACK_HALF_CHARGES = false
    // Unstacking an item can be moved to the next slot if it has the same item type and stack with it.
    private constant boolean ALLOW_STACKING_NEXT_ITEM = true
    // Checks for the maximum possible stacks for every item type. Otherwise, ItemUnstackItemGetMaxStacks is used.
    private constant boolean CHECK_MAX_STACKS = true

    private trigger orderTrigger = CreateTrigger()
endglobals

private function GetMaxStacksByItemTypeIdIntern takes integer itemTypeId returns integer
static if (CHECK_MAX_STACKS) then
    return GetMaxStacksByItemTypeId(itemTypeId)
else
    return ItemUnstackItemGetMaxStacks(itemTypeId)
endif
endfunction

private function CopyItemProps takes item sourceItem, item targetItem returns nothing
    // some seem broken
    //call BlzSetItemName(targetItem, GetItemName(sourceItem))
    call BlzSetItemDescription(targetItem, BlzGetItemDescription(sourceItem))
    //call BlzSetItemTooltip(targetItem, BlzGetItemTooltip(sourceItem))
    call BlzSetItemExtendedTooltip(targetItem, BlzGetItemExtendedTooltip(sourceItem))
    //call BlzSetItemIconPath(targetItem, BlzGetItemIconPath(sourceItem))
    call SetItemPawnable(targetItem, IsItemPawnable(sourceItem))
    call SetItemInvulnerable(targetItem, IsItemInvulnerable(sourceItem))
    if (GetItemPlayer(sourceItem) != null) then
        call SetItemPlayer(targetItem, GetItemPlayer(sourceItem), false)
    endif
endfunction

private function GetItemSlot takes unit hero, item whichItem returns integer
    local integer sourceSlot = -1
    local integer i = 0
    loop
        if (UnitItemInSlot(hero, i) == whichItem) then
            set sourceSlot = i
        endif
        set i = i + 1
        exitwhen (sourceSlot != -1 or i >= UnitInventorySize(hero))
    endloop
    return sourceSlot
endfunction

private function AddUnstackedItem takes unit hero, integer itemTypeId, integer charges, integer sourceSlot, item sourceItem returns nothing
    local item itemInNextSlot = null
    local item itemInPreviousSlot = null
    local boolean addedToFreeSlot = false
    // we need to specify the target slot explicitly to prevent stacking the items again
    // we prefer empty slots next to the unstacked item
    local item unstackedItem = null
    local integer i = sourceSlot + 1
    local integer j = sourceSlot - 1
    // check for a slot with an item with the same type and free stacks
    if (ALLOW_STACKING_NEXT_ITEM) then
        loop
            set itemInNextSlot = UnitItemInSlot(hero, i)
            if (i < UnitInventorySize(hero)) then
                if (itemInNextSlot == null) then
                    set addedToFreeSlot = true
                    call UnitAddItemToSlotById(hero, itemTypeId, i)
                    set unstackedItem = UnitItemInSlot(hero, i)
                elseif (GetItemTypeId(itemInNextSlot) == itemTypeId and GetItemCharges(itemInNextSlot) < GetMaxStacksByItemTypeIdIntern(itemTypeId)) then
                    set unstackedItem = itemInNextSlot
                endif
            endif
            set i = i + 1
            exitwhen (unstackedItem != null or i >= UnitInventorySize(hero))
        endloop
    endif

    // check for a free slot
    if (unstackedItem == null) then
        set i = sourceSlot + 1
        set j = sourceSlot - 1
        loop
            set itemInNextSlot = UnitItemInSlot(hero, i)
            set itemInPreviousSlot = UnitItemInSlot(hero, j)
            if (i < UnitInventorySize(hero) and itemInNextSlot == null) then
                set addedToFreeSlot = true
                call UnitAddItemToSlotById(hero, itemTypeId, i)
                set unstackedItem = UnitItemInSlot(hero, i)
            elseif (j >= 0 and itemInPreviousSlot == null) then
                set addedToFreeSlot = true
                call UnitAddItemToSlotById(hero, itemTypeId, j)
                set unstackedItem = UnitItemInSlot(hero, j)
            endif
            set i = i + 1
            set j = j - 1
            exitwhen (unstackedItem != null or (i >= UnitInventorySize(hero) and j < 0))
        endloop
    endif

    if (addedToFreeSlot) then
        call SetItemCharges(unstackedItem, charges)
        call CopyItemProps(sourceItem, unstackedItem)
    else
        call SetItemCharges(unstackedItem, GetItemCharges(unstackedItem) + charges)
    endif

    // create the item for the hero with one slot if all slots are used
    if (unstackedItem == null) then
        set unstackedItem = CreateItem(itemTypeId, GetUnitX(hero), GetUnitY(hero))
        call SetItemCharges(unstackedItem, charges)
        call CopyItemProps(sourceItem, unstackedItem)
    endif

    set unstackedItem = null
endfunction

private function TriggerConditionOrderUnstack takes nothing returns boolean
static if (CHECK_MAX_STACKS) then
    local boolean isNotStackDummy = GetTriggerUnit() != MaxItemStacks_GetStackItemDummy()
else
    local boolean isNotStackDummy = true
endif
    return isNotStackDummy and GetIssuedOrderId() >= 852002 and GetIssuedOrderId() <= 852007 and GetOrderTargetItem() != null and GetMaxStacksByItemTypeIdIntern(GetItemTypeId(GetOrderTargetItem())) > 0 and GetItemCharges(GetOrderTargetItem()) > 1 and GetItemSlot(GetTriggerUnit(), GetOrderTargetItem()) == GetIssuedOrderId() - 852002
endfunction

private function TriggerActionOrderUnstack takes nothing returns nothing
    local unit hero = GetTriggerUnit()
    local item sourceItem = GetOrderTargetItem()
    local integer sourceItemTypeId = GetItemTypeId(sourceItem)
    local integer sourceSlot = GetItemSlot(hero, sourceItem)
    local integer charges = 1
    // wait for completing the order or the item is not at the target slot
    call TriggerSleepAction(0.0)
    // item does still exist and was dropped on its previous slot
    // we are not sure if this works when the item is removed via triggers since the value of the variable becomes an invalid reference
    if (sourceItem != null and GetWidgetLife(sourceItem) > 0.0 and GetItemCharges(sourceItem) > 0 and UnitItemInSlot(hero, sourceSlot) == sourceItem) then
        if (UNSTACK_HALF_CHARGES) then
            set charges = IMaxBJ(GetItemCharges(sourceItem) / 2, 1)
        else
            set charges = IMinBJ(GetItemCharges(sourceItem), MAX_UNSTACKED_CHARGES)
        endif
        call SetItemCharges(sourceItem, GetItemCharges(sourceItem) - charges)
        call AddUnstackedItem(hero, sourceItemTypeId, charges, sourceSlot, sourceItem)
    endif

    set hero = null
    set sourceItem = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrderUnstack))
    call TriggerAddAction(orderTrigger, function TriggerActionOrderUnstack)
endfunction

// Change Log:
//
// 1.6 2022-07-15:
// - Add separate library MaxItemStacks.
//
// 1.5 2022-07-10:
// - Use vJass since we have two triggers now, can use the initializer and use static ifs.
// - Use constants instead of constant functions for the options of the system.
// - Calculate the max stacks per item type with the help of a dummy if enabled.
// - Increase the max stacks possible to 1000 since this is the maximum possible value in the object editor.
// - Add option UNSTACK_HALF_CHARGES.
//
// 1.4 2022-07-09:
// - ItemUnstackMaximumCharges allows changing the number of unstacked charges.
// - ItemUnstackAllowStackingNextItem allows stacking the unstacked item to the next item with the same type instead of only using a free slot.
// - ItemUnstackItemGetMaxStacks to check if the item is even stackable and to make sure item charges will not be over the maximum.
//
// 1.3 2022-04-16:
// - Refactor function names.
//
// 1.2 2022-04-13:
// - Use UnitInventorySize instead of bj_MAX_INVENTORY to support different inventory sizes.
// - Place Footmen with unit inventories to check different inventory sizes.
//
// 1.1 2022-04-11:
// - Split into multiple functions.
// - Do not apply item name, tooltip and icon path on unstacking since it is broken.
// - Prefer the nearest empty slot on unstacking.
// - Add a line break to the unstacking hint.
// - Add some items with custom names and descriptions to test stacking/unstacking them.
// - Move system code into converted trigger.
// - Update preview image.
endlibrary

// Baradé's Max Item Stacks System 1.0
//
// Supports the missing Warcraft III feature of calculating the value of 'ista' per item type ID.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Use the function GetMaxStacksByItemTypeId to get the value of 'ista' per item type ID.
//
// Download:
// https://www.hiveworkshop.com/threads/barad%C3%A9s-item-unstack-system-1-1.339109/
library MaxItemStacks initializer Init

globals
    // This dummy is created and hidden once only if CHECK_MAX_STACKS is set to true. It requires an inventory with at least 2 slots.
    private constant integer DUMMY_UNIT_TYPE_MAX_CHECKS = 'Hpal'
    // Warcraft III has a limit of number of stacks for the field "Stats - Max Stacks" ('ista').
    private constant integer MAX_STACKS_ALLOWED = 1000
    private constant real DUMMY_X = 0.0
    private constant real DUMMY_Y = 0.0

    private integer stackCounter = 0
    private hashtable stackHashTable = InitHashtable()
    private unit stackItemDummy = null
    private trigger stackItemTrigger = CreateTrigger()
endglobals

public function GetStackItemDummy takes nothing returns unit
    return stackItemDummy
endfunction

function GetMaxStacksByItemTypeId takes integer itemTypeId returns integer
    local integer i = 0
    local item tmpItem = null

    if (HaveSavedInteger(stackHashTable, itemTypeId, 0)) then
        return LoadInteger(stackHashTable, itemTypeId, 0)
    endif
    set stackCounter = 1
    set tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
    call SetItemCharges(tmpItem, 1)
    call UnitAddItem(stackItemDummy, tmpItem)
    set i = 1
    loop
        set tmpItem = CreateItem(itemTypeId, 0.0, 0.0)
        call SetItemCharges(tmpItem, 1)
        call UnitAddItem(stackItemDummy, tmpItem)
        exitwhen (stackCounter <= i)
        set i = i + 1
        exitwhen (i >= MAX_STACKS_ALLOWED)
    endloop
    if (UnitItemInSlot(stackItemDummy, 0) != null) then
        call RemoveItem(UnitItemInSlot(stackItemDummy, 0))
    endif
    if (UnitItemInSlot(stackItemDummy, 1) != null) then
        call RemoveItem(UnitItemInSlot(stackItemDummy, 1))
    endif
    call SaveInteger(stackHashTable, itemTypeId, 0, stackCounter)
    return stackCounter
endfunction


private function TriggerConditionStack takes nothing returns boolean
    set stackCounter = stackCounter + 1
    return false
endfunction

private function Init takes nothing returns nothing
    set stackItemDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), DUMMY_UNIT_TYPE_MAX_CHECKS, DUMMY_X, DUMMY_Y, 0.0)
    call SetUnitInvulnerable(stackItemDummy, true)
    if (IsUnitType(stackItemDummy, UNIT_TYPE_HERO)) then
        call SuspendHeroXP(stackItemDummy, true)
    endif
    call SetUnitUseFood(stackItemDummy, false)
    call ShowUnit(stackItemDummy, false)
    call BlzSetUnitWeaponBooleanField(stackItemDummy, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0, false)
    call BlzSetUnitWeaponBooleanField(stackItemDummy, UNIT_WEAPON_BF_ATTACKS_ENABLED, 1, false)
    call SetUnitPathing(stackItemDummy, false)
    call SetUnitMoveSpeed(stackItemDummy, 0.0)
    call TriggerRegisterUnitEvent(stackItemTrigger, stackItemDummy, EVENT_UNIT_STACK_ITEM)
    call TriggerAddCondition(stackItemTrigger, Condition(function TriggerConditionStack))
endfunction

endlibrary

// Baradé's Black Arrow System 1.1
//
// Supports Black Arrow abilities for target units with levels greater than 5.
// The standard Black Arrow abilities from Warcraft only work with target units up to level 5.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Copy the custom buff ability "Black Arrow Buff" (A000) into your map and adapt the raw code in the constant BUFF_ABILITY_ID to the new raw code in your map.
// - Optional: Add all preplaced units in your map with enabled Black Arrow auto casting using the function BlackArrowAddAutoCaster.
// - Optional: Use the API functions to register custom abilities and item types.
// - Optional: Create triggers and register Black Arrow events for further custom actions.
//
// Design:
// Auto casters are detected by issued orders. Preplaced units are created in the generated map script function CreateAllUnits which is called in the generated
// method main before the initialization of this system. This means that issued orders from preplaced units won't be detected by the system's order triggers.
// Hence, you have to use the function BlackArrowAddAutoCaster to add all preplaced units in your map with enabled Black Arrow auto casting.
//
// API:
//
// function BlackArrowAddAbility takes integer abilityId, integer level, integer summonedUnitTypeId, integer summonedUnitsCount, real summonedUnitDuration, real durationHero, real durationUnit, integer buffId returns integer
//
// Adds another custom ability to the system with the given configuration. Whenever a unit with the added ability at the given level kills a target with a level greater than 5, it will automatically summon the minions
// with the given unit type for the given amount of time.
// The function returns a unique index refering to the added ability. The first index starts at 1.
//
// function BlackArrowAddItemTypeId takes integer itemTypeId, integer abilityIndex returns integer
//
// Adds an item type which has the Black Arrow ability with the given index. You can combine this function with BlackArrowAddAbility and directly add the ability when adding the item type.
// Whenever a unit with carrying an item with the added item type kills a target unit with a level greater than 5, it will automatically summon the minions with the given configuration from the given ability.
// The function returns a unique index refering to the added item type. The first index starts at 1.
//
//
// function BlackArrowAddAutoCaster takes unit whichUnit returns nothing
//
// Adds the given unit as auto caster. This is required to detect damage caused by auto casters and cast the Black Arrow effect.
// All preplaced units with an enabled Black Arrow ability in the map must be added manually with this function.
//
// function BlackArrowRemoveAutoCaster takes unit whichUnit returns nothing
//
// Removes the given unit from the group of auto casters.
//
// function BlackArrowIsAutoCaster takes unit which returns boolean
//
// Returns true if the given unit is an auto caster. Otherwise, it returns false.
//
// function TriggerRegisterBlackArrowEvent takes trigger whichTrigger returns nothing
//
// Registers a Black Arrow event for the given callback trigger. This means that the trigger is evaluated and executed whenever an added Black Arrow ability is casted for a target unit above level 5.
// For the standard ability casts, you have to use the standard ability cast events instead.
//
// function GetTriggerBlackArrowCaster takes nothing returns unit
//
// Returns the casting unit for the current callback trigger.
//
// function GetTriggerBlackArrowTarget takes nothing returns unit
//
// Returns the target unit for the current callback trigger.
//
// function GetTriggerBlackArrowSummonedUnits takes nothing returns group
//
// Returns all summoned minions for the current callback trigger. Never destroy this group since it is basically bj_lastCreatedGroup and does not leak.
//
// function GetTriggerBlackArrowAbilityId takes nothing returns integer
//
// Returns the ability ID of the casted Black Arrow ability.
//
library BlackArrowSystem

globals
    public constant integer BUFF_ABILITY_ID = 'A0FU'
    //public constant integer BUFF_ABILITY_ID = 'A000'
    public constant string ORDER_ON = "blackarrowon"
    public constant string ORDER_OFF = "blackarrowoff"
    public constant boolean ADD_STANDARD_OBJECT_DATA = true
    public constant boolean ADD_ALL_UNITS_WITH_ORBS = true

    private integer array BlackArrowAbiliyId
    private integer array BlackArrowAbiliyLevel
    private integer array BlackArrowAbiliySummonedUnitTypeId
    private integer array BlackArrowAbiliySummonedUnitsCount
    private real array BlackArrowAbiliySummonedUnitDuration
    private real array BlackArrowAbiliyDurationHero
    private real array BlackArrowAbiliyDurationUnit
    private integer array BlackArrowAbiliyBuffId
    private integer BlackArrowAbilityCounter = 1

    private integer array BlackArrowItemTypeId
    private integer array BlackArrowItemTypeAbilityIndex
    private integer BlackArrowItemTypeCounter = 1

    private hashtable BlackArrowHashTable = InitHashtable()
    private group BlackArrowTargets = CreateGroup()
    private group BlackArrowAutoCasters = CreateGroup()
    private group BlackArrowItemUnits = CreateGroup()
    private trigger BlackArrowDamageTrigger = CreateTrigger()
    private trigger BlackArrowDeathTrigger = CreateTrigger()
    private trigger BlackArrowOrderTrigger = CreateTrigger()
    private trigger BlackArrowItemPickupTrigger = CreateTrigger()
    private trigger BlackArrowItemDropTrigger = CreateTrigger()

    // callbacks
    private unit BlackArrowCaster = null
    private unit BlackArrowTarget = null
    private group BlackArrowSummonedUnits = null
    private integer BlackArrowAbilityId = 0
    private trigger array BlackArrowCallbackTrigger
    private integer BlackArrowCallbackTriggerCounter = 0

    private boolean hookEnabled = true
endglobals

function GetTriggerBlackArrowCaster takes nothing returns unit
    return BlackArrowCaster
endfunction

function GetTriggerBlackArrowTarget takes nothing returns unit
    return BlackArrowTarget
endfunction

function GetTriggerBlackArrowSummonedUnits takes nothing returns group
    return BlackArrowSummonedUnits
endfunction

function GetTriggerBlackArrowAbilityId takes nothing returns integer
    return BlackArrowAbilityId
endfunction

function TriggerRegisterBlackArrowEvent takes trigger whichTrigger returns nothing
    set BlackArrowCallbackTrigger[BlackArrowCallbackTriggerCounter] = whichTrigger
    set BlackArrowCallbackTriggerCounter = BlackArrowCallbackTriggerCounter + 1
endfunction

function BlackArrowAddAbility takes integer abilityId, integer level, integer summonedUnitTypeId, integer summonedUnitsCount, real summonedUnitDuration, real durationHero, real durationUnit, integer buffId returns integer
    set BlackArrowAbiliyId[BlackArrowAbilityCounter] = abilityId
    set BlackArrowAbiliyLevel[BlackArrowAbilityCounter] = level
    set BlackArrowAbiliySummonedUnitTypeId[BlackArrowAbilityCounter] = summonedUnitTypeId
    set BlackArrowAbiliySummonedUnitsCount[BlackArrowAbilityCounter] = summonedUnitsCount
    set BlackArrowAbiliySummonedUnitDuration[BlackArrowAbilityCounter] = summonedUnitDuration
    set BlackArrowAbiliyDurationHero[BlackArrowAbilityCounter] = durationHero
    set BlackArrowAbiliyDurationUnit[BlackArrowAbilityCounter] = durationUnit
    set BlackArrowAbiliyBuffId[BlackArrowAbilityCounter] = buffId

    set BlackArrowAbilityCounter = BlackArrowAbilityCounter + 1

    return BlackArrowAbilityCounter - 1
endfunction

function BlackArrowAddItemTypeId takes integer itemTypeId, integer abilityIndex returns integer
    set BlackArrowItemTypeId[BlackArrowItemTypeCounter] = itemTypeId
    set BlackArrowItemTypeAbilityIndex[BlackArrowItemTypeCounter] = abilityIndex

    set BlackArrowItemTypeCounter = BlackArrowItemTypeCounter + 1

    return BlackArrowItemTypeCounter - 1
endfunction

function BlackArrowAddAutoCaster takes unit whichUnit returns nothing
    call GroupAddUnit(BlackArrowAutoCasters, whichUnit)
endfunction

function BlackArrowRemoveAutoCaster takes unit whichUnit returns nothing
    call GroupRemoveUnit(BlackArrowAutoCasters, whichUnit)
endfunction

function BlackArrowIsAutoCaster takes unit which returns boolean
    return IsUnitInGroup(which, BlackArrowAutoCasters)
endfunction

function BlackArrowPrintDebug takes nothing returns nothing
    call BJDebugMsg("Targets: " + I2S(CountUnitsInGroup(BlackArrowTargets)))
    call BJDebugMsg("Auto Casters: " + I2S(CountUnitsInGroup(BlackArrowAutoCasters)))
    call BJDebugMsg("Item Units: " + I2S(CountUnitsInGroup(BlackArrowItemUnits)))
endfunction

private function GetMatchingBlackArrowAbilityIndex takes unit caster returns integer
    local integer result = 0
    local integer i = 1
    loop
        exitwhen (i >= BlackArrowAbilityCounter or result > 0)
        if (GetUnitAbilityLevel(caster, BlackArrowAbiliyId[i]) == BlackArrowAbiliyLevel[i]) then
            set result = i
        endif
        set i = i + 1
    endloop

    return result
endfunction

private function GetMatchingBlackArrowItemTypeIndex takes integer itemTypeId returns integer
    local integer result = 0
    local integer i = 1
    loop
        exitwhen (i >= BlackArrowItemTypeCounter or result > 0)
        if (BlackArrowItemTypeId[i] == itemTypeId) then
            set result = i
        endif
        set i = i + 1
    endloop

    return result
endfunction

private function TimerFunctionBlackArrowBuffExpires takes nothing returns nothing
    local unit target = LoadUnitHandle(BlackArrowHashTable, GetHandleId(GetExpiredTimer()), 0)
    call FlushChildHashtable(BlackArrowHashTable, GetHandleId(target))
    call UnitRemoveAbility(target, BUFF_ABILITY_ID)
    call GroupRemoveUnit(BlackArrowTargets, target)
    set target = null
endfunction

private function MarkTarget takes integer abilityIndex, unit source, unit target returns nothing
    local timer whichTimer = LoadTimerHandle(BlackArrowHashTable, 0, GetHandleId(target))

    //call BJDebugMsg("Marking Black Arrow target " + GetUnitName(GetTriggerUnit()))

    if (whichTimer != null) then
        call FlushChildHashtable(BlackArrowHashTable, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer = null
    endif

    set whichTimer = CreateTimer()
    call SaveUnitHandle(BlackArrowHashTable, GetHandleId(whichTimer), 0, target)
    call SaveTimerHandle(BlackArrowHashTable, GetHandleId(target), 0, whichTimer)
    call SaveUnitHandle(BlackArrowHashTable, GetHandleId(target), 1, source)
    call SaveInteger(BlackArrowHashTable, GetHandleId(target), 2, abilityIndex)
    if (IsUnitType(target, UNIT_TYPE_HERO)) then
        call TimerStart(whichTimer, BlackArrowAbiliyDurationHero[abilityIndex], false, function TimerFunctionBlackArrowBuffExpires)
    else
        call TimerStart(whichTimer, BlackArrowAbiliyDurationUnit[abilityIndex], false, function TimerFunctionBlackArrowBuffExpires)
    endif

    call UnitAddAbility(target, BUFF_ABILITY_ID)

    if (not IsUnitInGroup(target, BlackArrowTargets)) then
        call GroupAddUnit(BlackArrowTargets, target)
    endif
endfunction

private function ExecuteCallbackTriggers takes unit source, unit target, group summonedUnits, integer abilityId returns nothing
    local integer i = 0
    set BlackArrowCaster = source
    set BlackArrowTarget = target
    set BlackArrowSummonedUnits = summonedUnits
    set BlackArrowAbilityId = abilityId
    loop
        exitwhen (i == BlackArrowCallbackTriggerCounter)
        call TriggerExecute(BlackArrowCallbackTrigger[i])
        set i = i + 1
    endloop
endfunction

private function SummonEffect takes integer abilityIndex, unit source, unit target returns group
    local location tmpLocation = GetUnitLoc(target)
    // Does not leak since it uses bj_lastCreatedGroup:
    local group summonedUnits = CreateNUnitsAtLoc(BlackArrowAbiliySummonedUnitsCount[abilityIndex],  BlackArrowAbiliySummonedUnitTypeId[abilityIndex], GetOwningPlayer(source), tmpLocation, GetUnitFacing(target))
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(summonedUnits))
        call SetUnitAnimation(BlzGroupUnitAt(summonedUnits, i), "Birth")
        call UnitApplyTimedLife(BlzGroupUnitAt(summonedUnits, i), BlackArrowAbiliyBuffId[abilityIndex], BlackArrowAbiliySummonedUnitDuration[abilityIndex])
        set i = i + 1
    endloop

    call ExecuteCallbackTriggers(source, target, summonedUnits, BlackArrowAbiliyId[abilityIndex])

    return summonedUnits
endfunction

private function Effect takes unit target returns group
     local timer whichTimer = LoadTimerHandle(BlackArrowHashTable, GetHandleId(target), 0)
     local unit source = LoadUnitHandle(BlackArrowHashTable, GetHandleId(target), 1)
     local integer abilityIndex = LoadInteger(BlackArrowHashTable, GetHandleId(target), 2)
     local group summonedUnits = SummonEffect(abilityIndex, source, target)

     //call BJDebugMsg("Black Arrow effect on target " + GetUnitName(target) + " with ability level " + I2S(BlackArrowAbiliyLevel[abilityIndex]) + " summoning units of type " + GetObjectName(BlackArrowAbiliySummonedUnitTypeId[abilityIndex]))

    if (whichTimer != null) then
        call FlushChildHashtable(BlackArrowHashTable, GetHandleId(whichTimer))
        call PauseTimer(whichTimer)
        call DestroyTimer(whichTimer)
        set whichTimer = null
    endif

    call FlushChildHashtable(BlackArrowHashTable, GetHandleId(target))
    call UnitRemoveAbility(target, BUFF_ABILITY_ID)
    call GroupRemoveUnit(BlackArrowTargets, target)

    // remove the decaying corpse
    call RemoveUnit(target)
    set target = null

    set source = null

    return summonedUnits
endfunction

private function TriggerConditionDamage takes nothing returns boolean
    return not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_MECHANICAL) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_RESISTANT) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_MAGIC_IMMUNE) and GetUnitLevel(GetTriggerUnit()) > 5 and ((IsUnitInGroup(GetEventDamageSource(), BlackArrowAutoCasters) and GetMatchingBlackArrowAbilityIndex(GetEventDamageSource()) > 0) or IsUnitInGroup(GetEventDamageSource(), BlackArrowItemUnits))
endfunction

function BlackArrowUnitGetOrbItem takes unit whichUnit, item excludeItem returns integer
    local integer i = 0
    loop
        exitwhen (i >= UnitInventorySize(whichUnit))
        if ((excludeItem == null or UnitItemInSlot(whichUnit, i) != excludeItem) and GetMatchingBlackArrowItemTypeIndex(GetItemTypeId(UnitItemInSlot(whichUnit, i))) > 0) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function TriggerActionDamage takes nothing returns nothing
    local integer itemIndex = BlackArrowUnitGetOrbItem(GetEventDamageSource(), null)
    local integer abilityIndex = GetMatchingBlackArrowAbilityIndex(GetEventDamageSource())
    if (itemIndex != -1 and abilityIndex == 0) then
        call MarkTarget(BlackArrowItemTypeAbilityIndex[itemIndex], GetEventDamageSource(), GetTriggerUnit())
    else
        call MarkTarget(abilityIndex, GetEventDamageSource(), GetTriggerUnit())
    endif
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), BlackArrowTargets)
endfunction

private function TriggerActionDeath takes nothing returns nothing
    call Effect(GetTriggerUnit())
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    return GetIssuedOrderId() == OrderId(ORDER_ON) or GetIssuedOrderId() == OrderId(ORDER_OFF)
endfunction

private function TriggerActionOrder takes nothing returns nothing
    if (GetIssuedOrderId() == OrderId(ORDER_ON)) then
        if (not BlackArrowIsAutoCaster(GetTriggerUnit())) then
            call BlackArrowAddAutoCaster(GetTriggerUnit())
        //call BJDebugMsg("Adding unit " + GetUnitName(caster) + " to casters.")
        endif
    else
        if (BlackArrowIsAutoCaster(GetTriggerUnit())) then
            call BlackArrowRemoveAutoCaster(GetTriggerUnit())
            //call BJDebugMsg("Removing unit " + GetUnitName(GetTriggerUnit()) + " from casters.")
        endif
    endif
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    return not IsUnitInGroup(GetTriggerUnit(), BlackArrowItemUnits) and GetMatchingBlackArrowItemTypeIndex(GetItemTypeId(GetManipulatedItem())) > 0
endfunction

private function TriggerActionPickupItem takes nothing returns nothing
    call GroupAddUnit(BlackArrowItemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " picked up a Black Arrow orb item.")
endfunction

private function TriggerConditionDropItem takes nothing returns boolean
    local boolean result = IsUnitInGroup(GetTriggerUnit(), BlackArrowItemUnits) and GetMatchingBlackArrowItemTypeIndex(GetItemTypeId(GetManipulatedItem())) > 0

    if (result) then
        // we need to exclude the dropped item since it is not dropped yet
        return BlackArrowUnitGetOrbItem(GetTriggerUnit(), GetManipulatedItem()) == -1
    endif

    return result
endfunction

private function TriggerActionDropItem takes nothing returns nothing
    call GroupRemoveUnit(BlackArrowItemUnits, GetTriggerUnit())
    //call BJDebugMsg("Unit " + GetUnitName(GetTriggerUnit()) + " dropped the final Black Arrow orb item.")
endfunction

private function AddStandardObjectData takes nothing returns nothing
    call BlackArrowAddAbility('ANba', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ANba', 2, 'ndr2', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ANba', 3, 'ndr3', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddAbility('ACbk', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm')
    call BlackArrowAddItemTypeId('odef', BlackArrowAddAbility('ANbs', 1, 'ndr1', 1, 80.0, 0.0, 2.0, 'BNdm'))
endfunction

private function FilterForUnitWithOrb takes nothing returns boolean
    return UnitInventorySize(GetFilterUnit()) > 0 and BlackArrowUnitGetOrbItem(GetFilterUnit(), null) != -1
endfunction

private function AddAllUnitsWithOrbs takes nothing returns nothing
    local group whichGroup = CreateGroup()
    call GroupEnumUnitsInRect(whichGroup, GetPlayableMapRect(), Filter(function FilterForUnitWithOrb))
    set bj_wantDestroyGroup = true
    call GroupAddGroup(whichGroup, BlackArrowItemUnits)
    //call BJDebugMsg("Units with orbs size " + I2S(CountUnitsInGroup(BlackArrowItemUnits)))
    set whichGroup = null
endfunction

private module Init

    private static method onInit takes nothing returns nothing
        call TriggerRegisterAnyUnitEventBJ(BlackArrowDamageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
        call TriggerAddCondition(BlackArrowDamageTrigger, Condition(function TriggerConditionDamage))
        call TriggerAddAction(BlackArrowDamageTrigger, function TriggerActionDamage)

        call TriggerRegisterAnyUnitEventBJ(BlackArrowDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(BlackArrowDeathTrigger, Condition(function TriggerConditionDeath))
        call TriggerAddAction(BlackArrowDeathTrigger, function TriggerActionDeath)

        call TriggerRegisterAnyUnitEventBJ(BlackArrowOrderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(BlackArrowOrderTrigger, Condition(function TriggerConditionOrder))
        call TriggerAddAction(BlackArrowOrderTrigger, function TriggerActionOrder)

        call TriggerRegisterAnyUnitEventBJ(BlackArrowItemPickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(BlackArrowItemPickupTrigger, Condition(function TriggerConditionPickupItem))
        call TriggerAddAction(BlackArrowItemPickupTrigger, function TriggerActionPickupItem)

        call TriggerRegisterAnyUnitEventBJ(BlackArrowItemDropTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddCondition(BlackArrowItemDropTrigger, Condition(function TriggerConditionDropItem))
        call TriggerAddAction(BlackArrowItemDropTrigger, function TriggerActionDropItem)

static if (ADD_STANDARD_OBJECT_DATA) then
        call AddStandardObjectData()
endif
static if (ADD_ALL_UNITS_WITH_ORBS) then
        call AddAllUnitsWithOrbs()
endif
    endmethod
endmodule

private struct S
    implement Init
endstruct

// ChangeLog:
//
// 1.1 2022-09-24:
// - Use vJass and a library, many private declarations and with early automatic initialization in a module.
// - Add options ADD_STANDARD_OBJECT_DATA and ADD_ALL_UNITS_WITH_ORBS.
// - Add function BlackArrowIsAutoCaster.
// - BlackArrowAbiliyDurationHero is used for target heroes now.
// - Add API documentation with usable functions.
// - Add event handling functions which allow adding actions to Black Arrow events.
// - Refactor some functions.
endlibrary

library WallSystem initializer Init

globals
    constant integer WALL_DIRECTION_WEST = 0
    constant integer WALL_DIRECTION_EAST = 1
    constant integer WALL_DIRECTION_NORTH = 2
    constant integer WALL_DIRECTION_SOUTH = 3
    constant real WALL_WIDTH = bj_CELLWIDTH
    constant real WALL_RANGE = 30.0

    constant integer WALL_CONSTRUCTED = 'h04Q'
    constant integer WALL_STRAIGHT_HORIZONTAL = 'h04R'
    constant integer WALL_STRAIGHT_VERTICAL = 'h096'
    constant integer WALL_CROSS_SECTION = 'h092'
    constant integer WALL_END_NORTH = 'h094'
    constant integer WALL_END_SOUTH = 'h095'
    constant integer WALL_END_EAST = 'h093'
    constant integer WALL_END_WEST = 'h04S'

    private group walls = CreateGroup()
    private trigger constructionTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
endglobals

function GetAngleFromWallDirection takes integer direction returns real
    if (direction == WALL_DIRECTION_WEST) then
        return 180.0
    elseif (direction == WALL_DIRECTION_EAST) then
        return 0.0
    elseif (direction == WALL_DIRECTION_NORTH) then
        return 90.0
    elseif (direction == WALL_DIRECTION_SOUTH) then
        return 270.0
    endif
    return 0.0
endfunction

function FilterFunctionWall takes nothing returns boolean
    local integer unitTypeId = GetUnitTypeId(GetFilterUnit())
    return unitTypeId == WALL_STRAIGHT_HORIZONTAL or unitTypeId == WALL_STRAIGHT_VERTICAL or unitTypeId == WALL_CROSS_SECTION or unitTypeId == WALL_END_NORTH or unitTypeId == WALL_END_SOUTH or unitTypeId == WALL_END_EAST or unitTypeId == WALL_END_WEST
endfunction

private function PolarProjectionX takes real x, real dist, real angle returns real
    return x + dist * Cos(angle * bj_DEGTORAD)
endfunction

private function PolarProjectionY takes real y, real dist, real angle returns real
    return y + dist * Sin(angle * bj_DEGTORAD)
endfunction

function GetWallNeighbour takes unit wall, player owner, real x, real y, integer direction returns unit
    local group whichGroup = CreateGroup()
    local real angle = GetAngleFromWallDirection(direction)
    local real neighbourX = PolarProjectionX(x, angle, WALL_WIDTH)
    local real neighbourY = PolarProjectionY(y, angle, WALL_WIDTH)
    local unit first = null
    local unit result = null
    call GroupEnumUnitsInRange(whichGroup, neighbourX, neighbourY, WALL_RANGE, Filter(function FilterFunctionWall))
    loop
        set first = FirstOfGroup(whichGroup)
        exitwhen (first == null)
        call GroupRemoveUnit(whichGroup, first)
        if (owner == GetOwningPlayer(first) and wall != first) then
            set result = first
        endif
    endloop

    call GroupClear(whichGroup)
    call DestroyGroup(whichGroup)
    set whichGroup = null

    return result
endfunction

function GetWallUnitTypeId takes player owner, real x, real y returns integer
    local unit west = GetWallNeighbour(null, owner, x, y, WALL_DIRECTION_WEST)
    local unit east = GetWallNeighbour(null, owner, x, y, WALL_DIRECTION_EAST)
    local unit north = GetWallNeighbour(null, owner, x, y, WALL_DIRECTION_NORTH)
    local unit south = GetWallNeighbour(null, owner, x, y, WALL_DIRECTION_SOUTH)

    if (west != null and east != null and north != null and south != null) then
        return WALL_CROSS_SECTION
    endif

    if (west == null and east != null) then
        return WALL_END_WEST
    endif

    if (east == null and west != null) then
        return WALL_END_EAST
    endif

    if (west != null and east != null) then
        return WALL_STRAIGHT_HORIZONTAL
    endif

    if (north == null and south != null) then
        return WALL_END_NORTH
    endif

    if (south == null and north != null) then
        return WALL_END_SOUTH
    endif

    if (south != null and north != null) then
        return WALL_STRAIGHT_VERTICAL
    endif

    return WALL_CROSS_SECTION
endfunction

function UpdateWallUnitType takes unit wall returns unit
    local integer unitTypeId = GetWallUnitTypeId(GetOwningPlayer(wall), GetUnitX(wall), GetUnitY(wall))
    if (GetUnitTypeId(wall) != unitTypeId) then
        call GroupRemoveUnit(walls, wall)
        set wall = ReplaceUnitBJ(wall, unitTypeId, bj_UNIT_STATE_METHOD_RELATIVE)
        call GroupAddUnit(walls, wall)
    endif

    return wall
endfunction

function UpdateWallNeighbours takes unit wall returns nothing
    local player owner = GetOwningPlayer(wall)
    local real x = GetUnitX(wall)
    local real y = GetUnitY(wall)
    local unit west = GetWallNeighbour(wall, owner, x, y, WALL_DIRECTION_WEST)
    local unit east = GetWallNeighbour(wall, owner, x, y, WALL_DIRECTION_EAST)
    local unit north = GetWallNeighbour(wall, owner, x, y, WALL_DIRECTION_NORTH)
    local unit south = GetWallNeighbour(wall, owner, x, y, WALL_DIRECTION_SOUTH)
    set owner = null

    call UpdateWallUnitType(wall)

    if (west != null) then
        call UpdateWallNeighbours(west)
    endif

    if (east != null) then
        call UpdateWallNeighbours(east)
    endif

    if (north != null) then
        call UpdateWallNeighbours(north)
    endif

    if (south != null) then
        call UpdateWallNeighbours(south)
    endif
endfunction

function ExpandWall takes unit wall, integer direction returns unit
    local unit neighbour = GetWallNeighbour(wall, GetOwningPlayer(wall), GetUnitX(wall), GetUnitY(wall), direction)
    local real angle = GetAngleFromWallDirection(direction)
    local real x = PolarProjectionX(GetUnitX(wall), angle, WALL_WIDTH)
    local real y = PolarProjectionY(GetUnitY(wall), angle, WALL_WIDTH)
    local integer unitTypeId = GetWallUnitTypeId(GetOwningPlayer(wall), x, y)

    // TODO slow recursion. Store neighbours in a hashtable like for the Goblin Tunnel System. Maybe create one single unit network system for this, Goblin Tunnels and Railroads.
    if (neighbour != null) then
        return ExpandWall(neighbour, direction)
    endif

    set wall = CreateUnit(GetOwningPlayer(wall), unitTypeId, x, y, bj_UNIT_FACING)
    call UpdateWallNeighbours(wall)

    return wall
endfunction

function TriggerConditionConstruction takes nothing returns boolean
    return GetUnitTypeId(GetConstructedStructure()) == WALL_CONSTRUCTED
endfunction

function TriggerActionConstruction takes nothing returns nothing
    call GroupAddUnit(walls, GetConstructedStructure())
    call UpdateWallNeighbours(GetConstructedStructure())
endfunction

function TriggerConditionDeath takes nothing returns boolean
    return IsUnitInGroup(GetTriggerUnit(), walls)
endfunction

function TriggerActionDeath takes nothing returns nothing
    call UpdateWallNeighbours(GetTriggerUnit())
    call GroupRemoveUnit(walls, GetTriggerUnit())
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(constructionTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructionTrigger, Condition(function TriggerConditionConstruction))
    call TriggerAddAction(constructionTrigger, function TriggerActionConstruction)

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
endfunction

endlibrary

globals
    constant real PING_DURATION = 5.0
endglobals

// Non leaking ping functions:

function PingUnitForPlayer takes unit whichUnit, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetUnitX(whichUnit), GetUnitY(whichUnit), PING_DURATION)
endfunction

function PingItemForPlayer takes item whichItem, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetItemX(whichItem), GetItemY(whichItem), PING_DURATION)
endfunction

function PingRectForPlayer takes rect whichRect, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetRectCenterX(whichRect), GetRectCenterY(whichRect), PING_DURATION)
endfunction

function PingDestructableForPlayer takes destructable whichDestructable, player whichPlayer returns nothing
    call PingMinimapForPlayer(whichPlayer, GetDestructableX(whichDestructable), GetDestructableY(whichDestructable), PING_DURATION)
endfunction

function DropAllItemsNotFromRaceForHero takes unit hero returns nothing
    local player owner = GetOwningPlayer(hero)
    local boolean playerUnlockedAllRaces = udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(owner)]
    local integer playerRace1 = udg_PlayerRace[GetConvertedPlayerId(owner)]
    local integer playerRace2 = udg_PlayerRace2[GetConvertedPlayerId(owner)]
    local integer itemRace = udg_RaceNone
    local integer i = 0
    if (not playerUnlockedAllRaces) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            if (UnitItemInSlot(hero, i) != null) then
                set itemRace = GetItemRace(GetItemTypeId(UnitItemInSlot(hero, i)))
                if (itemRace != udg_RaceNone and itemRace != playerRace1 and itemRace != playerRace2) then
                    call UnitRemoveItemFromSlot(hero, i)
                endif
            endif
            set i = i + 1
        endloop
    endif
    set owner = null
endfunction

function DropAllItemsNotFromRace takes player whichPlayer returns nothing
    if (udg_Hero[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromRaceForHero(udg_Hero[GetPlayerId(whichPlayer)])
    endif
    if (udg_Hero2[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromRaceForHero(udg_Hero2[GetPlayerId(whichPlayer)])
    endif
    if (udg_Hero3[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromRaceForHero(udg_Hero3[GetPlayerId(whichPlayer)])
    endif
endfunction

function DropAllItemsNotFromProfessionForHero takes unit hero returns nothing
    local player owner = GetOwningPlayer(hero)
    local integer playerProfession1 = udg_PlayerProfession[GetConvertedPlayerId(owner)]
    local integer playerProfession2 = udg_PlayerProfession2[GetConvertedPlayerId(owner)]
    local integer j = 0
    local integer i = 0
    if (not udg_PlayerUnlockedAllRaces[GetConvertedPlayerId(owner)]) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            if (UnitItemInSlot(hero, i) != null) then
                set j = 0
                loop
                    exitwhen (j == udg_Max_Berufe)
                    if (udg_ProfessionItemType[j] == GetItemTypeId(UnitItemInSlot(hero, i)) and playerProfession1 != j and playerProfession2 != j) then
                        call UnitRemoveItemFromSlot(hero, i)
                        exitwhen (true)
                    endif
                    set j = j + 1
                endloop
            endif
            set i = i + 1
        endloop
    endif
    set owner = null
endfunction

function DropAllItemsNotFromProfession takes player whichPlayer returns nothing
    if (udg_Hero[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromProfessionForHero(udg_Hero[GetPlayerId(whichPlayer)])
    endif
    if (udg_Hero2[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromProfessionForHero(udg_Hero2[GetPlayerId(whichPlayer)])
    endif
    if (udg_Hero3[GetPlayerId(whichPlayer)] != null) then
        call DropAllItemsNotFromProfessionForHero(udg_Hero3[GetPlayerId(whichPlayer)])
    endif
endfunction

function DropItemAtRectFromHeroByItemType takes unit hero, integer itemTypeId, rect whichRect returns nothing
    local player owner = GetOwningPlayer(hero)
    if (hero == udg_Held[GetPlayerId(owner)]) then
        call DropQuestItemFromHeroAtRect(GetPlayerId(owner), itemTypeId, whichRect)
    else
        call DropQuestItemFromCreepHeroAtRect(hero, itemTypeId, whichRect)
    endif
    set owner = null
endfunction

// Baradé's Layer System 1.0
//
// Supports walking ground units on different layers on top of each other.
//
// Usage:
// - Copy the code into a trigger in your map.
// - Create unit types with movement type flying for all supported ground unit types.
// - Create Storm Crow based abilities for the passive unit transformation into ground and flying unit types.
// - Register all rects for layers during the map initialization.
// - Optional: Create bridge destructibles without any pathing texture and with "Is Walkable" set to "false" and place them at the layer rects in your map.
//
// Dependencies (integrated):
// - GetTerrainZ and GetUnitZ: https://www.hiveworkshop.com/threads/snippet-getterrainz-unitz.236942/
//
// Known issues:
// - You have to add unit types and two abilities per unit type to allow morphing into and unmorphing from an air unit type. This is required since the movement type and classification cannot be changed via natives.
// - Units on layers cannot attack and cannot be attack by ground units next to the layer. They are classified as air units to avoid attacks from ground units below the layer and have disabled attacks to prevent them from attacking real air units.
// - Pathfinding won't work with layers. It would work with fake Way Gates but on entering the Way Gate redirecting the unit to the layer and at the end of the layer back to the original destination which is too complicated to implement.
// - TerrainZ does not return the exact Z and hence the units on layers are often too low.

globals
    region array LayerRegion
    integer array LayerCliffLevel
    real array LayerFlyHeight
    trigger array LayerLeaveTrigger // recognize leave event before enter event
    trigger array LayerEnterTrigger
    group array LayerGroup
    group array LayerGroupFlyingUnits
    integer LayerCounter = 0

    integer array LayerUnitTypeId
    integer array LayerCrowFormMorphAbilityId
    integer array LayerCrowFormUnmorphAbilityId
    integer LayerUnitTypeIdCounter = 0

    hashtable LayerHashTable = InitHashtable()
    timer LayerFlyingHeightTimer = CreateTimer()
    boolean LayerFlyingHeightTimerStarted = false
    integer LayerTotalUnitsCounter = 0

    constant location LayerL = Location(0, 0)
endglobals

function LayerAddUnitType takes integer unitTypeId, integer morphAbilityId, integer unmorphAbilityId returns integer
    local integer index = LayerUnitTypeIdCounter
    set LayerUnitTypeId[index] = unitTypeId
    set LayerCrowFormMorphAbilityId[index] = morphAbilityId
    set LayerCrowFormUnmorphAbilityId[index] = unmorphAbilityId
    set LayerUnitTypeIdCounter = LayerUnitTypeIdCounter + 1
    return index
endfunction

function LayerGetUnitType takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i >= LayerUnitTypeIdCounter)
        if (LayerUnitTypeId[i] == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function LayerGetTerrainZ takes real x, real y returns real
    call MoveLocation(LayerL, x, y)
    return GetLocationZ(LayerL)
endfunction

function LayerGetUnitZ takes unit u returns real
    return LayerGetTerrainZ(GetUnitX(u), GetUnitY(u)) + GetUnitFlyHeight(u)
endfunction

function LayerSetUnitZ takes unit u, real z returns nothing
    call SetUnitFlyHeight(u, z - LayerGetTerrainZ(GetUnitX(u), GetUnitY(u)), 0)
endfunction


function LayerPolarProjectionX takes real x, real angle, real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function LayerPolarProjectionY takes real y, real angle, real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function LayerStopUnitAndMoveBack takes unit whichUnit returns nothing
    local real angle = ModuloReal(GetUnitFacing(whichUnit) - 180.0, 360.0)
    call SetUnitPosition(whichUnit, LayerPolarProjectionX(GetUnitX(whichUnit), angle, 10.0), LayerPolarProjectionY(GetUnitY(whichUnit), angle, 300.0))
    call IssueImmediateOrder(whichUnit, "stop")
    //call BJDebugMsg(GetUnitName(GetTriggerUnit()) + " was moved back and stopped")
endfunction

function LayerTimerFunctionUpdateFlyingHeight takes nothing returns nothing
    local unit whichUnit = null
    local integer j = 0
    local integer i = 0
    loop
        exitwhen (i == LayerCounter)
        set j = 0
        loop
            exitwhen (j == BlzGroupGetSize(LayerGroup[i]))
            set whichUnit = BlzGroupUnitAt(LayerGroup[i], j)
            call LayerSetUnitZ(whichUnit, LayerFlyHeight[i])
            set whichUnit = null
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function LayerStartUpdateFlyingHeightTimer takes nothing returns nothing
    if (not LayerFlyingHeightTimerStarted) then
        call TimerStart(LayerFlyingHeightTimer, 0.01, true, function LayerTimerFunctionUpdateFlyingHeight)
        set LayerFlyingHeightTimerStarted = true
    endif
endfunction

function LayerStopUpdateFlyingHeightTimer takes nothing returns nothing
    if (LayerTotalUnitsCounter <= 0) then
        call PauseTimer(LayerFlyingHeightTimer)
        set LayerFlyingHeightTimerStarted = false
    endif
endfunction

function LayerTriggerConditionEnter takes nothing returns boolean
    local integer layer = LoadInteger(LayerHashTable, GetHandleId(GetTriggeringTrigger()), 0)
    local integer cliffLevel = GetTerrainCliffLevel(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))

    //call BJDebugMsg(GetUnitName(GetTriggerUnit()) + " entering layer " + I2S(layer) + " with cliff level " + I2S(LayerCliffLevel[layer]) + " having cliff level " + I2S(cliffLevel))

    if (not IsUnitType(GetTriggerUnit(), UNIT_TYPE_FLYING)) then
        if (not IsUnitInGroup(GetTriggerUnit(), LayerGroup[layer])) then
            if (LayerGetUnitType(GetUnitTypeId(GetTriggerUnit())) != -1) then
                if (cliffLevel == LayerCliffLevel[layer]) then
                    return true
                else
                    call LayerStopUnitAndMoveBack(GetTriggerUnit())
                endif
            endif
        endif
    elseif (not IsUnitInGroup(GetTriggerUnit(), LayerGroupFlyingUnits[layer])) then
        call GroupAddUnit(LayerGroupFlyingUnits[layer], GetTriggerUnit())
        set LayerTotalUnitsCounter = LayerTotalUnitsCounter + 1
        call LayerStartUpdateFlyingHeightTimer()
    endif

    return false
endfunction

function LayerTriggerActionEnter takes nothing returns nothing
    local integer layer = LoadInteger(LayerHashTable, GetHandleId(GetTriggeringTrigger()), 0)
    local integer unitTypeIndex = LayerGetUnitType(GetUnitTypeId(GetTriggerUnit()))

    call GroupAddUnit(LayerGroup[layer], GetTriggerUnit())
    set LayerTotalUnitsCounter = LayerTotalUnitsCounter + 1

    call SaveInteger(LayerHashTable, GetHandleId(GetTriggerUnit()), 0, layer)

    if (UnitAddAbility(GetTriggerUnit(), LayerCrowFormMorphAbilityId[unitTypeIndex])) then // Amrf
        call UnitRemoveAbility(GetTriggerUnit(), LayerCrowFormMorphAbilityId[unitTypeIndex])
    endif
    call LayerStartUpdateFlyingHeightTimer()
endfunction

function LayerTriggerConditionLeave takes nothing returns boolean
    local integer layer = LoadInteger(LayerHashTable, GetHandleId(GetTriggeringTrigger()), 0)

    //call BJDebugMsg(GetUnitName(GetTriggerUnit()) + " leaving layer " + I2S(layer))

    if (IsUnitInGroup(GetTriggerUnit(), LayerGroup[layer])) then
        return true
    elseif (IsUnitInGroup(GetTriggerUnit(), LayerGroupFlyingUnits[layer])) then
        call GroupRemoveUnit(LayerGroupFlyingUnits[layer], GetTriggerUnit())
        set LayerTotalUnitsCounter = LayerTotalUnitsCounter - 1
        call LayerStopUpdateFlyingHeightTimer()
    endif

    return false
endfunction

function LayerTriggerActionLeave takes nothing returns nothing
    local integer layer = LoadInteger(LayerHashTable, GetHandleId(GetTriggeringTrigger()), 0)
    local integer unitTypeIndex = LayerGetUnitType(GetUnitTypeId(GetTriggerUnit()))
    local integer cliffLevel = GetTerrainCliffLevel(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))

    //call BJDebugMsg(GetUnitName(GetTriggerUnit()) + " leaving layer " + I2S(layer) + " with cliff level " + I2S(LayerCliffLevel[layer]) + " having cliff level " + I2S(cliffLevel))

    if (cliffLevel < LayerCliffLevel[layer]) then
        // keeps the unit in the layer region
        call LayerStopUnitAndMoveBack(GetTriggerUnit())
    else
        call GroupRemoveUnit(LayerGroup[layer], GetTriggerUnit())
        set LayerTotalUnitsCounter = LayerTotalUnitsCounter - 1

        call FlushChildHashtable(LayerHashTable, GetHandleId(GetTriggerUnit()))

        call SetUnitFlyHeight(GetTriggerUnit(), 0.0, 0.0)
        if (UnitAddAbility(GetTriggerUnit(), LayerCrowFormUnmorphAbilityId[unitTypeIndex])) then // Amrf
            call UnitRemoveAbility(GetTriggerUnit(), LayerCrowFormUnmorphAbilityId[unitTypeIndex])
        endif

        call LayerStopUpdateFlyingHeightTimer()
    endif
endfunction

function LayerAdd takes region whichRegion, integer cliffLevel returns integer
    local integer index = LayerCounter
    set LayerRegion[index] = whichRegion
    set LayerCliffLevel[index] = cliffLevel
    //set LayerFlyHeight[index] = R2I(cliffLevel) * bj_CLIFFHEIGHT
    set LayerFlyHeight[index] = R2I(cliffLevel) * 42.0
    set LayerEnterTrigger[index] = CreateTrigger()
    call TriggerRegisterEnterRegion(LayerEnterTrigger[index], whichRegion, null)
    call TriggerAddCondition(LayerEnterTrigger[index], Condition(function LayerTriggerConditionEnter))
    call TriggerAddAction(LayerEnterTrigger[index], function LayerTriggerActionEnter)
    call SaveInteger(LayerHashTable, GetHandleId(LayerEnterTrigger[index]), 0, index)
    set LayerLeaveTrigger[index] = CreateTrigger()
    call TriggerRegisterLeaveRegion(LayerLeaveTrigger[index], whichRegion, null)
    call TriggerAddCondition(LayerLeaveTrigger[index], Condition(function LayerTriggerConditionLeave))
    call TriggerAddAction(LayerLeaveTrigger[index], function LayerTriggerActionLeave)
    call SaveInteger(LayerHashTable, GetHandleId(LayerLeaveTrigger[index]), 0, index)
    set LayerGroup[index] = CreateGroup()
    set LayerGroupFlyingUnits[index] = CreateGroup()
    set LayerCounter = LayerCounter + 1
    return index
endfunction

function LayerAddRect takes rect r, integer cliffLevel returns integer
    local region rectRegion = CreateRegion()
    call RegionAddRect(rectRegion, r)
    return LayerAdd(rectRegion, cliffLevel)
endfunction

function LayerAddRectSimple takes rect r returns integer
    local integer cliffLevel = GetTerrainCliffLevel(GetRectMaxX(r), GetRectMaxY(r))
    return LayerAddRect(r, cliffLevel)
endfunction

function LayerEnable takes integer layer returns nothing
    call EnableTrigger(LayerEnterTrigger[layer])
    call EnableTrigger(LayerLeaveTrigger[layer])
endfunction

function LayerDisable takes integer layer returns nothing
    call DisableTrigger(LayerEnterTrigger[layer])
    call DisableTrigger(LayerLeaveTrigger[layer])
endfunction

function LayerGetUnitLayer takes unit whichUnit returns integer
    return LoadInteger(LayerHashTable, GetHandleId(whichUnit), 0)
endfunction


// ---------------------------

function GetPlayerInfo takes player whichPlayer returns string
    local integer playerId = GetPlayerId(whichPlayer)
    local integer playerIdConverted = GetConvertedPlayerId(whichPlayer)
    local string result = GetPlayerNameColored(whichPlayer)

    if (udg_PlayerIsWarlord[playerIdConverted]) then
        set result = result + "\n" + "Warlord"
    else
        set result = result + "\n" + "Freelancer"
    endif

    if (udg_Hero[playerId] != null) then
        set result = result + "\n" + "Hero: " + GetUnitName(udg_Hero[playerId])
        set result = result + "\n" + "Hero Level: " + I2S(GetHeroLevel(udg_Hero[playerId]))
    endif

    if (udg_Hero2[playerId] != null) then
        set result = result + "\n" + "Hero 2: " + GetUnitName(udg_Hero2[playerId])
        set result = result + "\n" + "Hero 2 Level: " + I2S(GetHeroLevel(udg_Hero2[playerId]))
    endif

    if (udg_Hero3[playerId] != null) then
        set result = result + "\n" + "Hero 3: " + GetUnitName(udg_Hero3[playerId])
        set result = result + "\n" + "Hero 3 Level: " + I2S(GetHeroLevel(udg_Hero3[playerId]))
    endif

    if (udg_PlayerProfession[playerIdConverted] != udg_ProfessionNone) then
        set result = result + "\n" + "Profession 1: " + udg_ProfessionName[udg_PlayerProfession[playerIdConverted]]
    else
        set result = result + "\n" + "Profession 1: None"
    endif

    if (udg_PlayerProfession2[playerIdConverted] != udg_ProfessionNone) then
        set result = result + "\n" + "Profession 2: " + udg_ProfessionName[udg_PlayerProfession2[playerIdConverted]]
    else
        set result = result + "\n" + "Profession 2: None"
    endif

    if (udg_PlayerIsWarlord[playerIdConverted]) then
        if (udg_PlayerRace[playerIdConverted] != udg_RaceNone) then
            set result = result + "\n" + "Race 1: " + udg_RaceName[udg_PlayerRace[playerIdConverted]]
        endif

        if (udg_PlayerRace2[playerIdConverted] != udg_RaceNone) then
            set result = result + "\n" + "Race 2: " + udg_RaceName[udg_PlayerRace2[playerIdConverted]]
        endif
    endif

    if (udg_ClanPlayerClan[playerIdConverted] != 0) then
        set result = result + "\n" + "Clan: " + udg_ClanName[udg_ClanPlayerClan[playerIdConverted]]
    endif

    set result = result + "\n" + "PvP Wins: " + I2S(udg_PlayerPvPWins[playerIdConverted])

    return result
endfunction

globals
    string array PlayerColorNames
endglobals

function InitPlayerColorNames takes nothing returns nothing
    set PlayerColorNames[0] = "RED"
    set PlayerColorNames[1] = "BLUE"
    set PlayerColorNames[2] = "CYAN"
    set PlayerColorNames[3] = "PURPLE"
    set PlayerColorNames[4] = "YELLOW"
    set PlayerColorNames[5] = "ORANGE"
    set PlayerColorNames[6] = "GREEN"
    set PlayerColorNames[7] = "PINK"
    set PlayerColorNames[8] = "LIGHT_GRAY"
    set PlayerColorNames[9] = "LIGHT_BLUE"
    set PlayerColorNames[10] = "AQUA"
    set PlayerColorNames[11] = "BROWN"
    set PlayerColorNames[12] = "MAROON"
    set PlayerColorNames[13] = "NAVY"
    set PlayerColorNames[14] = "TURQUOISE"
    set PlayerColorNames[15] = "VIOLET"
    set PlayerColorNames[16] = "WHEAT"
    set PlayerColorNames[17] = "PEACH"
    set PlayerColorNames[18] = "MINT"
    set PlayerColorNames[19] = "LAVENDER"
    set PlayerColorNames[20] = "COAL"
    set PlayerColorNames[21] = "SNOW"
    set PlayerColorNames[22] = "EMERALD"
    set PlayerColorNames[23] = "PEANUT"
endfunction

function GetPlayerColorName takes player whichPlayer returns string
    return StringCase(PlayerColorNames[GetPlayerId(whichPlayer)], false)
endfunction

function GetPlayerFromString takes string whichString returns player
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (whichString == I2S(i + 1) or (PlayerColorNames[i] != null and StringLength(PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorNames[i]) or StringStartsWith(GetPlayerName(Player(i)), whichString)) then
            return Player(i)
        endif
        set i = i + 1
    endloop

    return null
endfunction

library TurretSystemConfig

globals
    constant real TURRET_SYSTEM_UPDATE_INTERVAL = 0.01
    constant boolean TURRET_SYSTEM_USE_SELECT_TURRETS_ABILITY = true
    constant integer TURRET_SYSTEM_SELECT_TURRETS_ABILITY_ID = 'A0J1'
    constant boolean TURRET_SYSTEM_APPLY_MOVEMENT_SETTINGS = true
endglobals

function TurretSystemGetAttackAnimation takes unit vehicle, unit turret returns string
    // Goblin War Zeppelin
    if (GetUnitTypeId(vehicle) == 'N06M') then
       return "attack two"
    // Goblin Heavy Tank
    elseif (GetUnitTypeId(vehicle) == 'N06N') then
        if (GetUnitAbilityLevel(vehicle, 'A0ID') > 0) then
            if (GetUnitTypeId(turret) == 'h065') then
                return "attack one alternate"
            else
                return "attack two alternate"
            endif
        else
            if (GetUnitTypeId(turret) == 'h065') then
                return "attack one"
            else
                return "attack two"
            endif
        endif
    endif
    return "attack"
endfunction

function TurretSystemApplyWeaponStatsBefore takes unit vehicle, unit turret returns nothing
endfunction

function TurretSystemApplyWeaponStatsAfter takes unit vehicle, unit turret returns nothing
    if (GetUnitTypeId(turret) == 'h065' or GetUnitTypeId(turret) == 'h066') then
        call BlzSetUnitBaseDamage(turret, BlzGetUnitBaseDamage(vehicle, 0) / 2, 0)
        call BlzSetUnitDiceNumber(turret, BlzGetUnitDiceNumber(vehicle, 0) / 2, 0)
        call BlzSetUnitDiceSides(turret, BlzGetUnitDiceSides(vehicle, 0) / 2, 0)
    endif
endfunction

endlibrary

// Baradé's Turret System 1.0
//
// Usage:
// - Create some custom unit types for turrets and if necessary for vehicles:
// Usually, turret unit types should be invulnerable, have no valid model to be invisible since most turrets are shown on the vehicle's model.
// Turret unit types have the Locust ability if you want them to be unselectable.
// Give them a matching damage type, damage amount and missiles. The Z coordinate can be configured setting their flying height
// Make sure that their movement settings and sight range match the vehicle. Otherwise, you cannot order your vehicle when selecting all the turrets.
// If the turret's missile depends on the scale and team color, you can change those settings as well since you probably do not want to see the turret's model anyway.
// - Copy this code into one of your triggers or the map script.
// - Provide the library TurretSystemConfig with the following constants and functions:
//
// constant real TURRET_SYSTEM_UPDATE_INTERVAL = 0.01
// constant boolean TURRET_SYSTEM_USE_SELECT_TURRETS_ABILITY = true
// constant integer TURRET_SYSTEM_SELECT_TURRETS_ABILITY_ID = 'A000'
//
// function TurretSystemGetAttackAnimation takes unit vehicle, unit turret returns string
//    return "attack"
//endfunction
//
// function TurretSystemApplyWeaponStatsBefore takes unit vehicle, unit turret returns nothing
//
// function TurretSystemApplyWeaponStatsAfter takes unit vehicle, unit turret returns nothing
//
// - Initialize the system during the map initialization with:
// Actions
//     -------- Turret System --------
//     Custom script:   call TurretSystemAddVehicleUnitType('H002', true, true, "bone_turret")
//     Custom script:   call TurretSystemAddVehicleUnitType('H003', true, true, "Turret")
// - Add turrets at the beginning of the game and start the system like this:
// Actions
//     -------- Turret System --------
//     Set VariableSet TmpUnit = Tank 0001 <gen>
//     Custom script:   call TurretSystemAddTurret(udg_TmpUnit, 'h001', 40.0, 0.0, true, false)
//
// - Note: Vehicle unit types do not have to be registered with TurretSystemAddVehicleUnitType except you want to specify one of the values.
//
// API:
//
// function TurretSystemAddVehicleUnitType takes integer unitTypeId, boolean canAttack, boolean changeFacing, string facingBone returns integer
//
// Configures the specified unit type ID as vehicle type with the given settings.
//
// function TurretSystemAddTurret takes unit vehicle, integer turretUnitTypeId, real offsetX, real offsetY, boolean autoAttack, boolean vehicleDamage returns unit
//
// Adds a turret with the given unit type ID, offsets and settings to the specified vehicle. The turret will automatically search for targets and attack them if autoAttack is true.
// The turret will get applied the vehicle unit*s damage automatically periodically if vehicleDamage is true. This will call the two callbacks TurretSystemApplyWeaponStatsBefore
// and TurretSystemApplyWeaponStatsAfter.
//
//
// Detailed description:
//
// Turrets are independently attacking components of a unit.
// A unit with at least one turret is called vehicle.
// Turrets are automatically moved with the vehicle but can attack different targets at the same time
// while the vehicle has different orders.
// This allows multi attacks with different weapon settings for one single vehicle which is not natively
// supported by Warcraft III.
//
// Current turrent systems are either based on the Phoenix Fire ability or custom missile systems
// and target detection systems.
// The Phoenix Fire ability is rather limited compared to a dummy unit with a regular weapon type
// since you cannot configure its damage type etc.
// Custom missile and target detection systems are rather slow and require more code to be configured.
// Both approaches usually do not allow the player to prioritize specific targets for the turrets.
//
// This system avoids these issues by using dummy units for turrets based on custom unit types.
// Their weapon types specify the missile, damage type, damage etc. without any custom system.
//
// You can add an unlimited number of turret to every vehicle.
// Every turret can have a completely different weapon type.
// Every turret can be located at a completely different position at the vehicle.
//
// Vehicles with a rotating turret bone in their 3D model can automatically rotate the bone into
// the direction of their turret. This is useful for a number of tank models.
//
// Vehicles can use different attack animations depending on the turret which is attacking.
//
// Ordering vehicles to attack units, items or destructables will prioritize the target for all
// turrets to be attacked if they are in range and have a matching weapon type which can attack
// the target. Ordering the vehicles to attack to prioritize a target for the turrets will not stop
// their current orders. This allows you to move vehicles around, targetting widgets for the turrets
// without stopping the vehicle.
// Ordering vehicles to stop will stop the attacks of all corresponding turrets and reset their
// target to none.
//
// Turrets can be configured to be selectable and destructable. Selecting the turrets of a vehicle
// is must be triggered manually, for example with some custom ability. Selecting the turrets helps
// to see their actual weapon type (range, damage type etc.) and to prioritize different targets for
// each turret of a vehicle.
//
// TODOS:
// - Fix saving and restoring all orders for vehicles.
// - Disable turrets when the unit is loaded/transported. Just check with a flag during the attack.
// - Fix selecting and unselecting turrets without desync.
// - Remove the selectable flag for turrets.
// - Add offset Z for turrets and use the unit flying height to achieve it. It can also be set by a fixed flying height for the unit type which is much easier.
// - You cannot order the vehicle to move with the turrets selected in the demo map. Fix the movement type and speed of the turrets so they match the vehicle.
// - Allow simplified registering of turret unit types for vehicle unit types which includes training or summoning of new units as well as the destruction, their death and hero revival.
// - Improve the performance for too many turrets in the map: Only move turrets if the position has changed. Only update the target search if the current target is out of range or dead. Changing the priority target also should update the target.
// - Disable auto target search for the vehicles in the demo map which only use turrets. Their acquision range should be either low or they should never be able to attack an enemy with the attack order.
// - Fix the tooltips of turrets and vehicles in the demo map (shown in the selection).
// - Fix the bombs model in the demo map.
// - Let the bombs auto bomb the ground all the time except you stop the turret.
// - Use custom icons in the demo map.
// - Add some Sith and Jedi to the demo map.
// - Add some ground soldiers to the demo map.
// - Add some water area with battle ships and sub marines to the demo map.
// - Allow turret groups to be sync with each other to attack the same target or not attack if not in range. This would allow double cannons to always attack the same target. IS this already possible if the vehicle can still attack?
// - Do not update the bone turret's target everytime when it has not changed. It leads to weird rotation animations.
library TurretSystem requires TurretSystemConfig

globals
    // vehicle keys
    private constant integer TURRET_SYSTEM_KEY_TURRETS = 0
    private constant integer TURRET_SYSTEM_KEY_TARGET = 1

    // turret keys
    private constant integer TURRET_SYSTEM_KEY_VEHICLE = 0
    private constant integer TURRET_SYSTEM_KEY_OFFSET_X = 1
    private constant integer TURRET_SYSTEM_KEY_OFFSET_Y = 2
    private constant integer TURRET_SYSTEM_KEY_AUTO_ATTACK = 3
    private constant integer TURRET_SYSTEM_KEY_VEHICLE_DAMAGE = 4
    private constant integer TURRET_SYSTEM_KEY_ENABLED = 5
    private constant integer TURRET_SYSTEM_KEY_TURRET_TARGET = 6
    private constant integer TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE = 7
    private constant integer TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET = 8

    // vehicle and turret keys
    private constant integer TURRET_SYSTEM_KEY_ORDER_TYPE = 9
    private constant integer TURRET_SYSTEM_KEY_ORDER = 10
    private constant integer TURRET_SYSTEM_KEY_ORDER_TARGET = 11
    private constant integer TURRET_SYSTEM_KEY_ORDER_TARGET_X = 12
    private constant integer TURRET_SYSTEM_KEY_ORDER_TARGET_Y = 13

    // order types
    private constant integer TURRET_SYSTEM_ORDER_TYPE_NO_TARGET = 0
    private constant integer TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET = 1
    private constant integer TURRET_SYSTEM_ORDER_TYPE_ITEM_TARGET = 2
    private constant integer TURRET_SYSTEM_ORDER_TYPE_DESTRUCTABLE_TARGET = 3
    private constant integer TURRET_SYSTEM_ORDER_TYPE_POINT_TARGET = 4

    private integer array TurretSystemVehicleUnitTypeId
    private boolean array TurretSystemVehicleCanAttack
    private boolean array TurretSystemVehicleChangeFacing
    private string array TurretSystemVehicleFacingBone
    private integer TurretSystemVehicleCounter = 0

    // callbacks
    private trigger array TurretSystemCallbackAutoTargetTriggers
    private integer TurretSystemCallbackAutoTargetTriggersCounter = 0
    private unit TurretSystemTriggerVehicle = null
    private unit TurretSystemTriggerTurret = null
    private unit TurretSystemTriggerTargetUnit = null
    private item TurretSystemTriggerTargetItem = null
    private destructable TurretSystemTriggerTargetDestructable = null

    private hashtable TurretSystemHashTable = InitHashtable()
    private group TurretSystemAllVehicles = CreateGroup()
    private group TurretSystemAllTurrets = CreateGroup()
    private timer TurretSystemUpdateTimer = CreateTimer()
    private boolean TurretSystemUpdatedTimerPaused = true
    private trigger TurretSystemAttackTrigger = CreateTrigger()
    private trigger TurretSystemDeathTrigger = CreateTrigger()
    private trigger TurretSystemReviveTrigger = CreateTrigger()
    private trigger TurretSystemOrderTrigger = CreateTrigger()
    private trigger TurretSystemSelectionTrigger = CreateTrigger()
endglobals

function TurretSystemAddVehicleUnitType takes integer unitTypeId, boolean canAttack, boolean changeFacing, string facingBone returns integer
    local integer index = TurretSystemVehicleCounter
    set TurretSystemVehicleUnitTypeId[index] = unitTypeId
    set TurretSystemVehicleCanAttack[index] = canAttack
    set TurretSystemVehicleChangeFacing[index] = changeFacing
    set TurretSystemVehicleFacingBone[index] = facingBone
    set TurretSystemVehicleCounter = TurretSystemVehicleCounter + 1
    return index
endfunction

function TurretSystemGetIndex takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i == TurretSystemVehicleCounter)
        if (TurretSystemVehicleUnitTypeId[i] == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function TurretSystemCopyGroup takes group whichGroup returns group
    local group tmpGroup = CreateGroup()
    call GroupAddGroup(whichGroup, tmpGroup)
    return tmpGroup
endfunction

function TurretSystemGetAllVehicles takes nothing returns group
    return TurretSystemCopyGroup(TurretSystemAllVehicles)
endfunction

function TurretSystemGetAllTurrets takes nothing returns group
    return TurretSystemCopyGroup(TurretSystemAllTurrets)
endfunction

function TurretSystemIsVehicle takes unit vehicle returns boolean
    return IsUnitInGroup(vehicle, TurretSystemAllVehicles)
endfunction

function TurretSystemIsTurret takes unit turret returns boolean
    return IsUnitInGroup(turret, TurretSystemAllTurrets)
endfunction

function TurretSystemGetVehicleTarget takes unit vehicle returns unit
    return LoadUnitHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TARGET)
endfunction

function TurretSystemGetTurretTarget takes unit vehicle returns unit
    return LoadUnitHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRET_TARGET)
endfunction

function TurretSystemGetTurrets takes unit vehicle returns group
    local group turrets = LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS)
    local group result = CreateGroup()
    call GroupAddGroup(turrets, result)
    set turrets = null
    return result
endfunction

function TurretSystemTurretsCountUnitTypeId takes unit vehicle, integer unitTypeId returns integer
    local group turrets = TurretSystemGetTurrets(vehicle)
    local integer count = 0
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(turrets))
        if (GetUnitTypeId(BlzGroupUnitAt(turrets, i)) == unitTypeId) then
            set count = count + 1
        endif
        set i = i + 1
    endloop
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null

    return count
endfunction

private function TurretSystemUnselectGroupEnum takes nothing returns nothing
    call SelectUnit(GetEnumUnit(), false)
endfunction

function TurretSystemSelectionAddTurrets takes player whichPlayer, unit vehicle returns nothing
    local group turrets = TurretSystemGetTurrets(vehicle)
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ForGroup(turrets, function SelectGroupBJEnum)
    endif
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
endfunction

function TurretSystemSelectionRemoveTurrets takes player whichPlayer, unit vehicle returns nothing
    local group turrets = TurretSystemGetTurrets(vehicle)
    if (GetLocalPlayer() == whichPlayer) then
        // Use only local code (no net traffic) within this block to avoid desyncs.
        call ForGroup(turrets, function TurretSystemUnselectGroupEnum)
    endif
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
endfunction

function TurretSystemGetVehicle takes unit turret returns unit
    return LoadUnitHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_VEHICLE)
endfunction

private function TurretSystemFlushVehicle takes unit vehicle returns nothing
    if (HaveSavedHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS)) then
        call GroupClear(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
        call DestroyGroup(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
    endif
    call FlushChildHashtable(TurretSystemHashTable, GetHandleId(vehicle))
endfunction

private function TurretSystemFlushTurret takes unit turret returns nothing
    call FlushChildHashtable(TurretSystemHashTable, GetHandleId(turret))
endfunction

function TurretSystemIsTurretEnabled takes unit turret returns boolean
    return LoadBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ENABLED)
endfunction

function TurretSystemSetTurretEnabled takes unit turret, boolean enabled returns nothing
    call SaveBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ENABLED, enabled)
    call PauseUnit(turret, not enabled)
    //call SetUnitInvulnerable(turret, true)
endfunction

private function TurretSystemPolarProjectionX takes real x, real angle, real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

private function TurretSystemPolarProjectionY takes real y, real angle, real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

private function TurretSystemAngleBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

private function TurretSystemDistanceBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
    local real dx = x2 - x1
    local real dy = y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

function TurretSystemGetTurretPriorityTargetUnit takes unit turret returns unit
    local integer targetType = LoadInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE)
    if (targetType == TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET) then
        return LoadUnitHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET)
    endif
    return null
endfunction

function TurretSystemGetTurretPriorityTargetItem takes unit turret returns item
    local integer targetType = LoadInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE)
    if (targetType == TURRET_SYSTEM_ORDER_TYPE_ITEM_TARGET) then
        return LoadItemHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET)
    endif
    return null
endfunction

function TurretSystemGetTurretPriorityTargetDestructable takes unit turret returns destructable
    local integer targetType = LoadInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE)
    if (targetType == TURRET_SYSTEM_ORDER_TYPE_DESTRUCTABLE_TARGET) then
        return LoadDestructableHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET)
    endif
    return null
endfunction

function TurretSystemRegisterTurretAutoTargetEvent takes trigger whichTrigger returns nothing
    set TurretSystemCallbackAutoTargetTriggers[TurretSystemCallbackAutoTargetTriggersCounter] = whichTrigger
    set TurretSystemCallbackAutoTargetTriggersCounter = TurretSystemCallbackAutoTargetTriggersCounter + 1
endfunction

function TurretSystemGetTriggerVehicle takes nothing returns unit
    return TurretSystemTriggerVehicle
endfunction

function TurretSystemGetTriggerTurret takes nothing returns unit
    return TurretSystemTriggerTurret
endfunction

function TurretSystemGetTriggerTargetUnit takes nothing returns unit
    return TurretSystemTriggerTargetUnit
endfunction

function TurretSystemGetTriggerTargetItem takes nothing returns item
    return TurretSystemTriggerTargetItem
endfunction

function TurretSystemGetTriggerTargetDestructable takes nothing returns destructable
    return TurretSystemTriggerTargetDestructable
endfunction

private function TurretSystemExecuteCallbackTurretAutoTarget takes unit vehicle, unit turret, unit targetUnit, item targetItem, destructable targetDestructable returns nothing
    local integer i = 0
    set TurretSystemTriggerVehicle = vehicle
    set TurretSystemTriggerTurret = turret
    set TurretSystemTriggerTargetUnit = targetUnit
    set TurretSystemTriggerTargetItem = targetItem
    set TurretSystemTriggerTargetDestructable = targetDestructable
    loop
        exitwhen (i == TurretSystemCallbackAutoTargetTriggersCounter)
        call ConditionalTriggerExecute(TurretSystemCallbackAutoTargetTriggers[i])
        set i = i + 1
    endloop
endfunction

private function TurretSystemApplyWeaponStats takes unit sourceUnit, unit targetUnit returns nothing
    call BlzSetUnitWeaponIntegerField(targetUnit, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, BlzGetUnitWeaponIntegerField(sourceUnit, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0))
    call BlzSetUnitWeaponIntegerField(targetUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE, 0, BlzGetUnitWeaponIntegerField(sourceUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE, 0))
    call BlzSetUnitWeaponIntegerField(targetUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE, 0, BlzGetUnitWeaponIntegerField(sourceUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE, 0))
    call BlzSetUnitWeaponIntegerField(targetUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE, 0, BlzGetUnitWeaponIntegerField(sourceUnit, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE, 0))
    call BlzSetUnitWeaponRealField(targetUnit, UNIT_WEAPON_RF_ATTACK_RANGE, 0, BlzGetUnitWeaponRealField(sourceUnit, UNIT_WEAPON_RF_ATTACK_RANGE, 0))
    call BlzSetUnitBaseDamage(targetUnit, BlzGetUnitBaseDamage(sourceUnit, 0), 0)
    call BlzSetUnitDiceNumber(targetUnit, BlzGetUnitDiceNumber(sourceUnit, 0), 0)
    call BlzSetUnitDiceSides(targetUnit, BlzGetUnitDiceSides(sourceUnit, 0), 0)
    call BlzSetUnitAttackCooldown(targetUnit, BlzGetUnitAttackCooldown(sourceUnit, 0), 0)
endfunction

private function TurretSystemApplyMovementSettings takes unit sourceUnit, unit targetUnit returns nothing
    call SetUnitMoveSpeed(targetUnit, GetUnitMoveSpeed(sourceUnit))
endfunction

private function TurretSystemUpdate takes nothing returns nothing
    local unit turret = null
    local unit vehicle = null
    local unit target = null
    local real turretFacing = 0.0
    local real offsetX = 0.0
    local real offsetY = 0.0
    local real rotationForY = 0.0
    local real x = 0.0
    local real y = 0.0
    local unit priorityTargetUnit = null
    local item priorityTargetItem = null
    local destructable priorityTargetDestructable = null
    local real priorityTargetX = 0.0
    local real priorityTargetY = 0.0
    local boolean turretUsesVehicleDamage = false
    local boolean turretHasAttack = false
    local real turretRange = 0.0
    local integer turretOrderType = TURRET_SYSTEM_ORDER_TYPE_NO_TARGET
    local integer turretOrderId = 0
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(TurretSystemAllTurrets))
        set turret = BlzGroupUnitAt(TurretSystemAllTurrets, i)
        if (TurretSystemIsTurretEnabled(turret) and not IsUnitDeadBJ(turret) and not IsUnitPaused(turret) and not IsUnitLoaded(turret)) then
            set vehicle = TurretSystemGetVehicle(turret)
            if (not IsUnitDeadBJ(vehicle) and not IsUnitPaused(vehicle) and not IsUnitLoaded(vehicle)) then
                set target = TurretSystemGetTurretTarget(turret)
                //call BJDebugMsg("Updating turret position for " + GetUnitName(turret) + " with vehicle " + GetUnitName(vehicle))
                set offsetX = LoadReal(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_OFFSET_X)
                set offsetY = LoadReal(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_OFFSET_Y)
                //call BJDebugMsg("2 Updating turret position for " + GetUnitName(turret))
                //set x = GetUnitX(vehicle)
                //set y = GetUnitY(vehicle)
                if (target == null) then
                    set turretFacing = GetUnitFacing(vehicle)
                else
                    set turretFacing = TurretSystemAngleBetweenCoordinates(GetUnitX(vehicle), GetUnitY(vehicle), GetUnitX(target), GetUnitY(target))
                endif
                set x = TurretSystemPolarProjectionX(GetUnitX(vehicle), turretFacing, offsetX)
                set y = TurretSystemPolarProjectionY(GetUnitY(vehicle), turretFacing, offsetX)
                //call BJDebugMsg("3 Updating turret position for " + GetUnitName(turret))
                set rotationForY = ModuloReal(turretFacing + 90, 360.0)
                set x = TurretSystemPolarProjectionX(x, rotationForY, offsetY)
                set y = TurretSystemPolarProjectionY(y, rotationForY, offsetY)
                // do not use SetUnitPosition since it would interrupt the attack
                call SetUnitX(turret, x)
                call SetUnitY(turret, y)

static if (TURRET_SYSTEM_APPLY_MOVEMENT_SETTINGS) then
                call TurretSystemApplyMovementSettings(vehicle, target)
endif

                set turretUsesVehicleDamage = LoadBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_VEHICLE_DAMAGE)

                if (turretUsesVehicleDamage) then
                    call TurretSystemApplyWeaponStatsBefore(vehicle, target)
                    call TurretSystemApplyWeaponStats(vehicle, target)
                    call TurretSystemApplyWeaponStatsAfter(vehicle, target)
                endif

                // TODO This slows everything down massively! Just order wants every X seconds or check if the orders are like move or smart something
                // TODO Maybe catch the orders in a separate trigger to check the state (faster)
                // TODO Sometimes the turrets want to attack some target outside their range and hence already have an attack order!
                // TODO Catch smart orders from the vehicle and continue with the previous order but let the turrets attack the target.
                // prevent stopping the attacks
                set priorityTargetUnit = TurretSystemGetTurretPriorityTargetUnit(turret)
                set priorityTargetItem = TurretSystemGetTurretPriorityTargetItem(turret)
                set priorityTargetDestructable = TurretSystemGetTurretPriorityTargetDestructable(turret)
                set turretHasAttack = LoadBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_AUTO_ATTACK) and BlzGetUnitWeaponBooleanField(turret, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0)

                if (turretHasAttack) then
                    set turretRange = BlzGetUnitWeaponRealField(turret, UNIT_WEAPON_RF_ATTACK_RANGE, 0) // TODO Support both attack types and check targets?

                    if (priorityTargetUnit != null) then
                        set priorityTargetX = GetUnitX(priorityTargetUnit)
                        set priorityTargetY = GetUnitY(priorityTargetUnit)
                    elseif (priorityTargetItem != null) then
                        set priorityTargetX = GetItemX(priorityTargetItem)
                        set priorityTargetY = GetItemY(priorityTargetItem)
                    elseif (priorityTargetDestructable != null) then
                        set priorityTargetX = GetDestructableX(priorityTargetDestructable)
                        set priorityTargetY = GetDestructableY(priorityTargetDestructable)
                    endif

                    set turretOrderType = LoadInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ORDER_TYPE)
                    set turretOrderId = LoadInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ORDER)

                    if (priorityTargetUnit != null and (turretOrderId != OrderId("attack") or turretOrderType != TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET or LoadUnitHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ORDER_TARGET) != priorityTargetUnit) and IsUnitAliveBJ(priorityTargetUnit) and IsUnitVisible(priorityTargetUnit, GetOwningPlayer(turret)) and turretRange >= TurretSystemDistanceBetweenCoordinates(x, y, priorityTargetX, priorityTargetY)) then
                        call IssueTargetOrder(turret, "attack", priorityTargetUnit)
                    elseif (priorityTargetItem != null and not IsItemInvulnerable(priorityTargetItem) and GetWidgetLife(priorityTargetItem) > 0.0 and IsItemVisible(priorityTargetItem) and turretRange >= TurretSystemDistanceBetweenCoordinates(x, y, priorityTargetX, priorityTargetY)) then
                        call IssueTargetOrder(turret, "attack", priorityTargetItem)
                    elseif (priorityTargetDestructable != null and not IsDestructableInvulnerable(priorityTargetDestructable) and turretRange >= TurretSystemDistanceBetweenCoordinates(x, y, priorityTargetX, priorityTargetY)) then
                        call IssueTargetOrder(turret, "attack", priorityTargetDestructable)
                    elseif (GetUnitCurrentOrder(turret) == OrderId("move") or GetUnitCurrentOrder(turret) == OrderId("patrol") and GetUnitCurrentOrder(vehicle) != OrderId("stop")) then
                        call IssuePointOrder(turret, "attack", GetUnitX(turret), GetUnitY(turret))
                    elseif (GetUnitCurrentOrder(vehicle) == OrderId("stop")) then
                        call IssueImmediateOrder(turret, "stop")
                    endif
                elseif (GetUnitCurrentOrder(vehicle) == OrderId("stop")) then
                    call IssueImmediateOrder(turret, "stop")
                endif
                call TurretSystemExecuteCallbackTurretAutoTarget(vehicle, turret, priorityTargetUnit, priorityTargetItem, priorityTargetDestructable)
                set vehicle = null
                set target = null
            else
                call IssueImmediateOrder(turret, "stop")
            endif
        else
            call IssueImmediateOrder(turret, "stop")
        endif
        set turret = null
        set i = i + 1
    endloop
endfunction

function TurretSystemStart takes nothing returns nothing
    set TurretSystemUpdatedTimerPaused = false
    call TimerStart(TurretSystemUpdateTimer, TURRET_SYSTEM_UPDATE_INTERVAL, true, function TurretSystemUpdate)
endfunction

function TurretSystemPause takes boolean pause returns nothing
    if (pause) then
        set TurretSystemUpdatedTimerPaused = true
        call PauseTimer(TurretSystemUpdateTimer)
    else
        set TurretSystemUpdatedTimerPaused = false
        call TimerStart(TurretSystemUpdateTimer, TURRET_SYSTEM_UPDATE_INTERVAL, true, function TurretSystemUpdate)
    endif
endfunction

function TurretSystemAddTurret takes unit vehicle, integer turretUnitTypeId, real offsetX, real offsetY, boolean autoAttack, boolean vehicleDamage returns unit
    local group turrets = TurretSystemGetTurrets(vehicle)
    local unit turret = CreateUnit(GetOwningPlayer(vehicle), turretUnitTypeId, GetUnitX(vehicle), GetUnitY(vehicle), GetUnitFacing(vehicle))
    call GroupAddUnit(turrets, turret)
    call GroupAddUnit(TurretSystemAllTurrets, turret)

    if (not IsUnitInGroup(vehicle, TurretSystemAllVehicles)) then
        call GroupAddUnit(TurretSystemAllVehicles, vehicle)
    endif

    // prevent memory leaks
    if (HaveSavedHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS)) then
        call GroupClear(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
        call DestroyGroup(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
    endif

    call SaveGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS, turrets)
    set turrets = null
    call SaveUnitHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_VEHICLE, vehicle)
    call SaveReal(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_OFFSET_X, offsetX)
    call SaveReal(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_OFFSET_Y, offsetY)
    call SaveBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_AUTO_ATTACK, autoAttack)
    call SaveBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_VEHICLE_DAMAGE, vehicleDamage)
    call SaveBoolean(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_ENABLED, true)
    set turret = null

    if (TurretSystemUpdatedTimerPaused) then
        call TurretSystemPause(false)
    endif

    return turret
endfunction

function TurretSystemRemoveTurret takes unit vehicle, unit turret returns nothing
    local group turrets = TurretSystemGetTurrets(vehicle)

    call TurretSystemFlushTurret(turret)
    call GroupRemoveUnit(turrets, turret)
    call GroupRemoveUnit(TurretSystemAllTurrets, turret)
    call RemoveUnit(turret)
    set turret = null

    if (TurretSystemIsVehicle(vehicle)) then
        // prevent memory leaks
        if (HaveSavedHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS)) then
            call GroupClear(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
            call DestroyGroup(LoadGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS))
        endif

        call SaveGroupHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TURRETS, turrets)
    else
        // prevent memory leaks
        call GroupClear(turrets)
        call DestroyGroup(turrets)
        set turrets = null
     endif

    if (BlzGroupGetSize(TurretSystemAllTurrets) == 0) then
        call TurretSystemPause(true)
    endif
endfunction

function TurretSystemRemoveTurretUnit takes nothing returns nothing
    call TurretSystemFlushTurret(GetEnumUnit())
    call GroupRemoveUnit(TurretSystemAllTurrets, GetEnumUnit())
    call RemoveUnit(GetEnumUnit())
endfunction

function TurretSystemRemoveAllTurrets takes unit vehicle returns nothing
    local group turrets = TurretSystemGetTurrets(vehicle)
    call ForGroup(turrets, function TurretSystemRemoveTurretUnit)
    call TurretSystemFlushVehicle(vehicle)
    call GroupRemoveUnit(TurretSystemAllVehicles, vehicle)

    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null

    if (BlzGroupGetSize(TurretSystemAllTurrets) == 0) then
        call TurretSystemPause(true)
    endif
endfunction

function TurretSystemRemoveVehicle takes unit vehicle returns boolean
    if (TurretSystemIsVehicle(vehicle)) then
        call TurretSystemRemoveAllTurrets(vehicle)
        call TurretSystemFlushVehicle(vehicle)
        call GroupRemoveUnit(TurretSystemAllVehicles, vehicle)
        return true
    endif

    return false
endfunction

private function TurretSystemTriggerConditionAttack takes nothing returns boolean
    return TurretSystemIsTurret(GetAttacker()) or TurretSystemIsVehicle(GetAttacker())
endfunction

private function TurretSystemTurretAttacksTarget takes nothing returns nothing
    local unit vehicle = TurretSystemGetVehicle(GetAttacker())
    local integer index = TurretSystemGetIndex(GetUnitTypeId(vehicle))
    local string attackAnimation = null
    //call BJDebugMsg("Turret " + GetUnitName(GetAttacker()) + " attacks from vehicle " + GetUnitName(vehicle) + " target " + GetUnitName(GetTriggerUnit()))

    if (index != -1) then
        if (TurretSystemVehicleChangeFacing[index]) then
            call SetUnitLookAt(vehicle, TurretSystemVehicleFacingBone[index], GetTriggerUnit(), 0, 0, 90)
        endif
        //call BJDebugMsg("Turret " + GetUnitName(GetAttacker()) + "adjust facing of " + GetUnitName(vehicle))
    else
        //call BJDebugMsg("Turret " + GetUnitName(GetAttacker()) + " has unknown vehicle type " + GetUnitName(vehicle))
    endif

    set attackAnimation = TurretSystemGetAttackAnimation(vehicle, GetAttacker())
    if (attackAnimation != null) then
        call SetUnitAnimation(vehicle, attackAnimation)
    endif

    call SaveUnitHandle(TurretSystemHashTable, GetHandleId(GetAttacker()), TURRET_SYSTEM_KEY_TURRET_TARGET, GetTriggerUnit())
    call SaveUnitHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_TARGET, GetTriggerUnit())

    set vehicle = null
endfunction

private function TurretSystemTriggerActionAttack takes nothing returns nothing
    if (TurretSystemIsTurret(GetAttacker())) then
        call TurretSystemTurretAttacksTarget()
    else
        // vehicles should never cause real damage
        call BlzUnitInterruptAttack(GetAttacker())
        call ResetUnitAnimation(GetAttacker())
        // TODO Mark the target as priority for all turrets?
    endif
endfunction

private function TurretSystemTriggerConditionIsVehicle takes nothing returns boolean
    return TurretSystemIsVehicle(GetTriggerUnit())
endfunction

private function TurretSystemDisableTurretUnit takes nothing returns nothing
    call TurretSystemSetTurretEnabled(GetEnumUnit(), false)
endfunction

private function TurretSystemEnableTurretUnit takes nothing returns nothing
    call TurretSystemSetTurretEnabled(GetEnumUnit(), true)
endfunction

private function TurretSystemTriggerActionDeath takes nothing returns nothing
    local group turrets = TurretSystemGetTurrets(GetTriggerUnit())

    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)) then
        call ForGroup(turrets, function TurretSystemDisableTurretUnit)
    else
        call ForGroup(turrets, function TurretSystemRemoveTurretUnit)
        call TurretSystemFlushVehicle(GetTriggerUnit())
        call GroupRemoveUnit(TurretSystemAllVehicles, GetTriggerUnit())
    endif

    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
endfunction

function TurretSystemTriggerActionRevive takes nothing returns nothing
    local group turrets = TurretSystemGetTurrets(GetTriggerUnit())
    call ForGroup(turrets, function TurretSystemEnableTurretUnit)
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
endfunction

function TurretSystemSaveOrderUnit takes unit vehicle, unit target returns nothing
    call SaveInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE, TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET)
    call SaveUnitHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET, target)
endfunction

function TurretSystemStopTurrets takes unit vehicle returns nothing
    local integer vehicleIndex = TurretSystemGetIndex(GetUnitTypeId(vehicle))
    local boolean resetBone = vehicleIndex != -1 and TurretSystemVehicleChangeFacing[vehicleIndex]
    local group turrets = TurretSystemGetTurrets(vehicle)
    local unit turret = null
    local boolean result = false
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(turrets))
        set turret = BlzGroupUnitAt(turrets, i)
        call IssueImmediateOrder(turret, "stop")
        call SaveInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE, TURRET_SYSTEM_ORDER_TYPE_NO_TARGET)
        set turret = null
        set i = i + 1
    endloop
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
    if (resetBone) then
        call ResetUnitLookAt(vehicle)
    endif
endfunction

private function TurretSystemPriorityTargetUnit takes unit vehicle, integer orderId, unit target returns boolean
    local group turrets = TurretSystemGetTurrets(vehicle)
    local unit turret = null
    local boolean result = false
    local integer i = 0
    loop
        exitwhen (i == BlzGroupGetSize(turrets))
        set turret = BlzGroupUnitAt(turrets, i)
        // TODO Detect if it is a valid order for each turret, for example if the turret can only attack air units check if it is an air unit etc.
        if (orderId == OrderId("attack") or (orderId == OrderId("smart") and not IsUnitAlly(target, GetOwningPlayer(vehicle)))) then
            call SaveInteger(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET_TYPE, TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET)
            call SaveUnitHandle(TurretSystemHashTable, GetHandleId(turret), TURRET_SYSTEM_KEY_TURRET_PRIORITY_TARGET, target)
            set result = true
        endif
        set turret = null
        set i = i + 1
    endloop
    call GroupClear(turrets)
    call DestroyGroup(turrets)
    set turrets = null
    return result
endfunction

private function TurretSystemSaveOrderItem takes unit vehicle, item target returns nothing
    call SaveInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE, TURRET_SYSTEM_ORDER_TYPE_ITEM_TARGET)
    call SaveItemHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET, target)
endfunction

private function TurretSystemSaveOrderDestructable takes unit vehicle, destructable target returns nothing
    call SaveInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE, TURRET_SYSTEM_ORDER_TYPE_DESTRUCTABLE_TARGET)
    call SaveDestructableHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET, target)
endfunction

private function TurretSystemSaveOrderPoint takes unit vehicle, real x, real y returns nothing
    call SaveInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE, TURRET_SYSTEM_ORDER_TYPE_POINT_TARGET)
    call SaveReal(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET_X, x)
    call SaveReal(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET_Y, y)
endfunction

private function TurretSystemSaveOrder takes unit vehicle returns nothing
    call SaveInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE, TURRET_SYSTEM_ORDER_TYPE_NO_TARGET)
endfunction

private function TurretSystemRestorePreviousOrder takes unit vehicle returns nothing
    local integer orderType = LoadInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TYPE)
    local integer orderId = LoadInteger(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER)
    if (orderType == TURRET_SYSTEM_ORDER_TYPE_NO_TARGET) then
        call IssueImmediateOrderById(vehicle, orderId)
    elseif (orderType == TURRET_SYSTEM_ORDER_TYPE_UNIT_TARGET) then
        call IssueTargetOrderById(vehicle, orderId, LoadUnitHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET))
    elseif (orderType == TURRET_SYSTEM_ORDER_TYPE_ITEM_TARGET) then
        call IssueTargetOrderById(vehicle, orderId, LoadItemHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET))
    elseif (orderType == TURRET_SYSTEM_ORDER_TYPE_DESTRUCTABLE_TARGET) then
        call IssueTargetOrderById(vehicle, orderId, LoadDestructableHandle(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET))
    elseif (orderType == TURRET_SYSTEM_ORDER_TYPE_POINT_TARGET) then
        //call BJDebugMsg("Restore previous point order for " + GetUnitName(vehicle))
        call IssuePointOrderById(vehicle, orderId, LoadReal(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET_X), LoadReal(TurretSystemHashTable, GetHandleId(vehicle), TURRET_SYSTEM_KEY_ORDER_TARGET_Y))
    endif
endfunction

private function TurretSystemTriggerConditionIsVehicleOrTurret takes nothing returns boolean
    return TurretSystemIsVehicle(GetTriggerUnit()) or TurretSystemIsTurret(GetTriggerUnit())
endfunction

// TURRET_SYSTEM_KEY_TURRET_CURRENT_TARGET
private function TurretSystemTriggerActionIssueOrder takes nothing returns nothing
    local boolean matchingTarget = false
    local integer vehicleTypeIndex = -1

    if (TurretSystemIsVehicle(GetOrderedUnit())) then
        if (GetIssuedOrderId() == OrderId("stop")) then
            call TurretSystemStopTurrets(GetOrderedUnit())
        else
            if (GetOrderTargetUnit() != null) then
                set matchingTarget = TurretSystemPriorityTargetUnit(GetOrderedUnit(), GetIssuedOrderId(), GetOrderTargetUnit())
            elseif (GetOrderTargetItem() != null) then
            elseif (GetOrderTargetDestructable() != null) then
            elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) then
            elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_ORDER) then
            endif

            // TODO Check if the vehicle itself is allowed to attack with its regular attack.
            if (GetIssuedOrderId() == OrderId("attack") or (GetIssuedOrderId() == OrderId("smart") and matchingTarget) or GetIssuedOrderId() == OrderId("attackground")) then
                // TODO If the vehicle is ordered smart on something neutral or hostile, the turrets should have this target as priority in their loop.

                //call BJDebugMsg("Restore previous order for " + GetUnitName(GetOrderedUnit()))

                set vehicleTypeIndex = TurretSystemGetIndex(GetUnitTypeId(GetOrderedUnit()))

                if (vehicleTypeIndex == -1 or not TurretSystemVehicleCanAttack[vehicleTypeIndex]) then
                    //call BJDebugMsg("Resume previous order for " + GetUnitName(GetOrderedUnit()) + " with vehicle type index "  + I2S(vehicleTypeIndex))
                    call TurretSystemRestorePreviousOrder(GetOrderedUnit())
                else
                    //call BJDebugMsg("Do not previous order for " + GetUnitName(GetOrderedUnit()) + " with vehicle type index "  + I2S(vehicleTypeIndex))
                endif
            // store this order as previous order
            else
                //call BJDebugMsg("Store order for " + GetUnitName(GetOrderedUnit()))
                if (GetOrderTargetUnit() != null) then
                    call TurretSystemSaveOrderUnit(GetOrderedUnit(), GetOrderTargetUnit())
                elseif (GetOrderTargetItem() != null) then
                    call TurretSystemSaveOrderItem(GetOrderedUnit(), GetOrderTargetItem())
                elseif (GetOrderTargetDestructable() != null) then
                    call TurretSystemSaveOrderDestructable(GetOrderedUnit(), GetOrderTargetDestructable())
                elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) then
                    call TurretSystemSaveOrderPoint(GetOrderedUnit(), GetOrderPointX(), GetOrderPointY())
                elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_ORDER) then
                    call TurretSystemSaveOrder(GetOrderedUnit())
                endif
                call SaveInteger(TurretSystemHashTable, GetHandleId(GetOrderedUnit()), TURRET_SYSTEM_KEY_ORDER, GetIssuedOrderId())
            endif
        endif
    // turret
    else
        if (GetOrderTargetUnit() != null) then
            call TurretSystemSaveOrderUnit(GetOrderedUnit(), GetOrderTargetUnit())
        elseif (GetOrderTargetItem() != null) then
            call TurretSystemSaveOrderItem(GetOrderedUnit(), GetOrderTargetItem())
        elseif (GetOrderTargetDestructable() != null) then
            call TurretSystemSaveOrderDestructable(GetOrderedUnit(), GetOrderTargetDestructable())
        elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) then
            call TurretSystemSaveOrderPoint(GetOrderedUnit(), GetOrderPointX(), GetOrderPointY())
        elseif (GetTriggerEventId() == EVENT_PLAYER_UNIT_ISSUED_ORDER) then
            // prevents slow movement when the turrets and the vehicle are selected together
            if (GetIssuedOrderId() == OrderId("move")) then
                call TurretSystemRestorePreviousOrder(GetOrderedUnit())
            else
                call TurretSystemSaveOrder(GetOrderedUnit())
            endif
        endif
        call SaveInteger(TurretSystemHashTable, GetHandleId(GetOrderedUnit()), TURRET_SYSTEM_KEY_ORDER, GetIssuedOrderId())
    endif
endfunction

static if (TURRET_SYSTEM_USE_SELECT_TURRETS_ABILITY) then
private function TurretSystemTriggerConditionIsSelectionAbility takes nothing returns boolean
    return GetSpellAbilityId() == TURRET_SYSTEM_SELECT_TURRETS_ABILITY_ID and TurretSystemIsVehicle(GetTriggerUnit())
endfunction

private function TurretSystemTriggerActionSelectAllTurrets takes nothing returns nothing
    local unit vehicle = GetTriggerUnit()
    call TurretSystemSelectionAddTurrets(GetOwningPlayer(vehicle), vehicle)
    set vehicle = null
endfunction
endif

private module Init

    private static method onInit takes nothing returns nothing
        call TriggerRegisterAnyUnitEventBJ(TurretSystemAttackTrigger, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(TurretSystemAttackTrigger, Condition(function TurretSystemTriggerConditionAttack))
        call TriggerAddAction(TurretSystemAttackTrigger, function TurretSystemTriggerActionAttack)

        call TriggerRegisterAnyUnitEventBJ(TurretSystemDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(TurretSystemDeathTrigger, Condition(function TurretSystemTriggerConditionIsVehicle))
        call TriggerAddAction(TurretSystemDeathTrigger, function TurretSystemTriggerActionDeath)

        call TriggerRegisterAnyUnitEventBJ(TurretSystemReviveTrigger, EVENT_PLAYER_HERO_REVIVE_FINISH)
        call TriggerAddCondition(TurretSystemReviveTrigger, Condition(function TurretSystemTriggerConditionIsVehicle))
        call TriggerAddAction(TurretSystemReviveTrigger, function TurretSystemTriggerActionRevive)

        call TriggerRegisterAnyUnitEventBJ(TurretSystemOrderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterAnyUnitEventBJ(TurretSystemOrderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterAnyUnitEventBJ(TurretSystemOrderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(TurretSystemOrderTrigger, Condition(function TurretSystemTriggerConditionIsVehicleOrTurret))
        call TriggerAddAction(TurretSystemOrderTrigger, function TurretSystemTriggerActionIssueOrder)

static if (TURRET_SYSTEM_USE_SELECT_TURRETS_ABILITY) then
        call TriggerRegisterAnyUnitEventBJ(TurretSystemSelectionTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddCondition(TurretSystemSelectionTrigger, Condition(function TurretSystemTriggerConditionIsSelectionAbility))
        call TriggerAddAction(TurretSystemSelectionTrigger, function TurretSystemTriggerActionSelectAllTurrets)
endif
    endmethod
endmodule

private struct S
    implement Init
endstruct

hook RemoveUnit TurretSystemRemoveVehicle

endlibrary

// Equipment Bag System

globals
    hashtable EquipmentBagSystemHashTable = InitHashtable()
    hashtable EquipmentBagSystemStackingHashTable = InitHashtable()
    integer array EquipmentBagRegisteredItemTypeIds
    integer EquipmentBagRegisteredItemTypeIdsCounter = 0
endglobals

function EquipmentBagListItemTypeIds takes nothing returns string
    local string result = ""
    local integer i = 0
    loop
        exitwhen (i >= EquipmentBagRegisteredItemTypeIdsCounter)
        if (i > 0) then
            set result = result + "\n"
        endif
        set result = result + "- " + GetObjectName(EquipmentBagRegisteredItemTypeIds[i])
        set i = i + 1
    endloop
    return result
endfunction

function EquipmentBagSetAbilityCount takes integer itemTypeId, integer count returns nothing
    call SaveInteger(EquipmentBagSystemHashTable, itemTypeId, 0, count)
endfunction

function EquipmentBagGetAbilityCount takes integer itemTypeId returns integer
    return LoadInteger(EquipmentBagSystemHashTable, itemTypeId, 0)
endfunction

function EquipmentBagGetAbilityId takes integer itemTypeId, integer index returns integer
    return LoadInteger(EquipmentBagSystemHashTable, itemTypeId, index)
endfunction

function EquipmentBagGetAbilityIdStacking takes integer itemTypeId, integer abilityId returns boolean
    return LoadBoolean(EquipmentBagSystemStackingHashTable, itemTypeId, abilityId)
endfunction

function EquipmentBagRegisterAbilityEx takes integer itemTypeId, integer abilityId, boolean stacking returns nothing
    local integer i = 0
    local boolean found = false
    local integer count = EquipmentBagGetAbilityCount(itemTypeId) + 1
    call SaveInteger(EquipmentBagSystemHashTable, itemTypeId, count, abilityId)
    call SaveBoolean(EquipmentBagSystemStackingHashTable, itemTypeId, abilityId, stacking)
    call EquipmentBagSetAbilityCount(itemTypeId, count)
    // we store all item type IDs for player information
    loop
        exitwhen (i >= EquipmentBagRegisteredItemTypeIdsCounter or found)
        if (EquipmentBagRegisteredItemTypeIds[i] == itemTypeId) then
            set found = true
        endif
        set i = i + 1
    endloop
    if (not found) then
        set EquipmentBagRegisteredItemTypeIds[EquipmentBagRegisteredItemTypeIdsCounter] = itemTypeId
        set EquipmentBagRegisteredItemTypeIdsCounter = EquipmentBagRegisteredItemTypeIdsCounter + 1
    endif
endfunction

function EquipmentBagRegisterAbility takes nothing returns nothing
    call EquipmentBagRegisterAbilityEx(udg_TmpItemTypeId, udg_TmpAbilityCode, udg_TmpBoolean)
endfunction

function EquipmentBagAddAbilities takes unit bag, item whichItem returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(bag))
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer count = EquipmentBagGetAbilityCount(itemTypeId)
    local integer abilityId = 0
    local boolean stacking = false
    local unit hero = udg_Hero[playerId]
    local integer i = 1
    if (hero != null) then
        loop
            exitwhen (i > count)
            set abilityId = EquipmentBagGetAbilityId(itemTypeId, i)
            set stacking = EquipmentBagGetAbilityIdStacking(itemTypeId, abilityId)

            if (stacking or GetUnitAbilityLevel(hero, abilityId) <= 0) then
                call UnitAddAbility(hero, abilityId)
            endif
            set i = i + 1
        endloop
    endif
    set hero = null
endfunction

function CountItemsOfTypeFromHero takes unit hero, integer itemTypeId returns integer
    local item whichItem = null
    local integer count = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null and GetItemTypeId(whichItem) == itemTypeId) then
            set count = count + 1
        endif
        set whichItem = null
        set i = i + 1
    endloop
    return count
endfunction

function EquipmentBagRemoveAbilities takes unit bag, item whichItem returns nothing
    local integer playerId = GetPlayerId(GetOwningPlayer(bag))
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer count = EquipmentBagGetAbilityCount(itemTypeId)
    local integer abilityId = 0
    local boolean stacking = false
    local unit hero = udg_Hero[playerId]
    local integer i = 1
    if (hero != null) then
        loop
            exitwhen (i > count)
            set abilityId = EquipmentBagGetAbilityId(itemTypeId, i)
            set stacking = EquipmentBagGetAbilityIdStacking(itemTypeId, abilityId)

            if (stacking or CountItemsOfTypeFromHero(hero, itemTypeId) == 0) then
                call UnitRemoveAbility(hero, abilityId)
            endif
            set i = i + 1
        endloop
    endif
    set hero = null
endfunction

// Ability Field System
// Stores all fields which can be used to apply bonuses to.
// This is required by the Enchanter profession and for Evolution Stones.

globals
    hashtable AbilityFieldHashTable = InitHashtable()
    hashtable AbilityFieldCountersHashTable = InitHashtable()

    constant integer ABILITY_FIELD_TYPE_DEFENSE_INTEGER = 0
    constant integer ABILITY_FIELD_TYPE_HERO_STATS_INTEGER = 1
    constant integer ABILITY_FIELD_TYPE_DURATION_REAL = 2
    constant integer ABILITY_FIELD_TYPE_DAMAGE_REAL = 3
    constant integer ABILITY_FIELD_TYPE_LIFE_REAL = 4
    constant integer ABILITY_FIELD_TYPE_MANA_REAL = 5
    constant integer ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER = 6
    constant integer ABILITY_FIELD_TYPE_CHANCE_REAL = 7
    constant integer ABILITY_FIELD_TYPE_DEFENSE_REAL = 8
endglobals

function RegisterAbilityFieldEx takes integer abilityId, integer fieldId, integer fieldType returns integer
    local integer counter = LoadInteger(AbilityFieldCountersHashTable, abilityId, 0) + 1
    call SaveInteger(AbilityFieldHashTable, abilityId, fieldId, fieldType)
    call SaveInteger(AbilityFieldCountersHashTable, abilityId, counter, fieldId)
    call SaveInteger(AbilityFieldCountersHashTable, abilityId, 0, counter)
    return counter
endfunction

function RegisterAbilityField takes nothing returns integer
    return RegisterAbilityFieldEx(udg_TmpAbilityCode, udg_TmpInteger, udg_TmpInteger2)
endfunction

function GetMaxAbilityFields takes integer abilityId returns integer
    return LoadInteger(AbilityFieldCountersHashTable, abilityId, 0)
endfunction

function GetAbilityFieldId takes integer abilityId, integer index returns integer
    return LoadInteger(AbilityFieldCountersHashTable, abilityId, index + 1)
endfunction

function GetAbilityFieldType takes integer abilityId, integer index returns integer
    local integer fieldId = GetAbilityFieldId(abilityId, index)
    return LoadInteger(AbilityFieldHashTable, abilityId, fieldId)
endfunction

function GetAbilityFieldTypeByFieldId takes integer abilityId, integer fieldId returns integer
    return LoadInteger(AbilityFieldHashTable, abilityId, fieldId)
endfunction

function AddAbilityFieldBonuses takes integer abilityId, ability whichAbility, integer level, integer defenseBonus, integer heroStatsBonus, real durationBonus, real damageBonus, real lifeBonus, real manaBonus, integer lifeRegenerationBonus, real chanceRealBonus, real defenseRealBonus returns nothing
    local integer max = GetMaxAbilityFields(abilityId)
    local integer fieldType = 0
    local integer fieldId = 0
    local integer i = 0
    loop
        exitwhen (i >= max)
        set fieldId = GetAbilityFieldId(abilityId, i)
        set fieldType = GetAbilityFieldTypeByFieldId(abilityId, fieldId)
        if (fieldType == ABILITY_FIELD_TYPE_DEFENSE_INTEGER and defenseBonus > 0) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + defenseBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_HERO_STATS_INTEGER and heroStatsBonus > 0) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + heroStatsBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DURATION_REAL and durationBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + durationBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DAMAGE_REAL and damageBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + damageBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REAL and lifeBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + lifeBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_MANA_REAL and manaBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + manaBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER and lifeRegenerationBonus > 0) then
            call BlzSetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level, BlzGetAbilityIntegerLevelField(whichAbility, ConvertAbilityIntegerLevelField(fieldId), level) + lifeRegenerationBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_CHANCE_REAL and chanceRealBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + chanceRealBonus)
        elseif (fieldType == ABILITY_FIELD_TYPE_DEFENSE_REAL and defenseRealBonus > 0.0) then
            call BlzSetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level, BlzGetAbilityRealLevelField(whichAbility, ConvertAbilityRealLevelField(fieldId), level) + defenseRealBonus)
        endif
        set i = i + 1
    endloop
endfunction

/*


    call BlzSetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_STRENGTH_BONUS_ISTR, 1, BlzGetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_STRENGTH_BONUS_ISTR, 1) + bonus)
    call BlzSetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_AGILITY_BONUS, 1, BlzGetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_AGILITY_BONUS, 1) + bonus)
    call BlzSetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_INTELLIGENCE_BONUS, 1, BlzGetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_INTELLIGENCE_BONUS, 1) + bonus)
    call BlzSetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_DEFENSE_BONUS_IDEF, 1, BlzGetAbilityIntegerLevelField(whichAbility, ABILITY_ILF_DEFENSE_BONUS_IDEF, 1) + bonus)
    //call BlzSetAbilityRealLevelField(whichAbility, ABILITY_RLF_DAMAGE_INCREASE, 1, BlzGetAbilityRealLevelField(whichAbility, ABILITY_RLF_DAMAGE_INCREASE, 1) + bonus)
    // orb ability
    call BlzSetAbilityRealLevelField(whichAbility, ABILITY_RLF_DAMAGE_BONUS_IDAM, 1, BlzGetAbilityRealLevelField(whichAbility, ABILITY_RLF_DAMAGE_BONUS_IDAM, 1) + bonus)

*/


// Enchanter System

globals
    hashtable EnchanterSystemHashTable = InitHashtable()
    constant integer ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS = 1
    constant integer ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS = 2
    constant integer ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS = 3
endglobals

function EnchanterSystemSaveBonus takes unit hero, integer bonusType, integer bonus returns nothing
    call SaveInteger(EnchanterSystemHashTable, GetHandleId(hero), bonusType, bonus)
endfunction

function EnchanterSystemLoadBonus takes unit hero, integer bonusType returns integer
    return LoadInteger(EnchanterSystemHashTable, GetHandleId(hero), bonusType)
endfunction

function EnchanterSystemSaveBonusReal takes unit hero, integer bonusType, real bonus returns nothing
    call SaveReal(EnchanterSystemHashTable, GetHandleId(hero), bonusType, bonus)
endfunction

function EnchanterSystemLoadBonusReal takes unit hero, integer bonusType returns real
    return LoadReal(EnchanterSystemHashTable, GetHandleId(hero), bonusType)
endfunction

function EnchanterAddItemBonusHeroStatsAndDefense takes item whichItem, integer abilityId, integer bonus returns nothing
    local ability whichAbility = BlzGetItemAbility(whichItem, abilityId)

    call AddAbilityFieldBonuses(abilityId, whichAbility, 1, bonus, bonus, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0)
endfunction

function EnchanterRemoveItemBonusHeroStatsAndDefense takes item whichItem, integer abilityId, integer bonus returns nothing
    call EnchanterAddItemBonusHeroStatsAndDefense(whichItem, abilityId, -bonus)
endfunction

function EnchanterAddItemBonusDamage takes item whichItem, integer abilityId, real bonus returns nothing
    local ability whichAbility = BlzGetItemAbility(whichItem, abilityId)

    call AddAbilityFieldBonuses(abilityId, whichAbility, 1, 0, 0, 0.0, bonus, 0.0, 0.0, 0, 0.0, 0.0)
endfunction

function EnchanterRemoveItemBonusDamage takes item whichItem, integer abilityId, real bonus returns nothing
    call EnchanterAddItemBonusDamage(whichItem, abilityId, -bonus)
endfunction

function EnchanterGetHeroStatsAndDefenseBonus takes unit hero returns integer
    local integer result = 0
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null and GetItemTypeId(whichItem) == 'I07F') then
            set result = result + 1
        endif
        set whichItem = null
        set i = i + 1
    endloop
    return result
endfunction

function EnchanterGetDamageBonus takes unit hero returns real
    local real result = 0.0
    local item whichItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null and GetItemTypeId(whichItem) == 'I07F') then
            set result = result + 3.0
        endif
        set whichItem = null
        set i = i + 1
    endloop
    return result
endfunction

function EnchanterAddItemBonusesEx takes unit hero, item whichItem, integer bonusHeroStatsAndDefense, real bonusDamage returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer count = EquipmentBagGetAbilityCount(itemTypeId)
    local integer i = 1
    loop
        exitwhen (i > count)
        call EnchanterAddItemBonusHeroStatsAndDefense(whichItem, EquipmentBagGetAbilityId(itemTypeId, i), bonusHeroStatsAndDefense)
        call EnchanterAddItemBonusDamage(whichItem, EquipmentBagGetAbilityId(itemTypeId, i), bonusDamage)
        set i = i + 1
    endloop
endfunction

function EnchanterAddItemBonuses takes unit hero, item whichItem returns nothing
    call EnchanterAddItemBonusesEx(hero, whichItem, EnchanterGetHeroStatsAndDefenseBonus(hero), EnchanterGetDamageBonus(hero))
endfunction

function EnchanterRemoveItemBonuses takes unit hero, item whichItem returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer count = EquipmentBagGetAbilityCount(itemTypeId)
    local integer bonusHeroStatAndDefense = EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local real bonusDamage = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local integer i = 1
    loop
        exitwhen (i > count)
        call EnchanterRemoveItemBonusHeroStatsAndDefense(whichItem, EquipmentBagGetAbilityId(itemTypeId, i), bonusHeroStatAndDefense)
        call EnchanterRemoveItemBonusDamage(whichItem, EquipmentBagGetAbilityId(itemTypeId, i), bonusDamage)
        set i = i + 1
    endloop
endfunction

function EnchanterRecalculateItemBonuses takes unit hero, item whichItem returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    local integer count = EquipmentBagGetAbilityCount(itemTypeId)
    local integer oldEnchantingBonusHeroStatAndDefense = EnchanterSystemLoadBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)
    local integer updatedEnchantingBonusHeroStatAndDefense = EnchanterGetHeroStatsAndDefenseBonus(hero)
    local integer enchantingBonusHeroStatAndDefenseDiff = updatedEnchantingBonusHeroStatAndDefense - oldEnchantingBonusHeroStatAndDefense
    local real oldEnchantingBonusDamage = EnchanterSystemLoadBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS)
    local real updatedEnchantingBonusDamage = EnchanterGetDamageBonus(hero)
    local real enchantingBonusDamageDiff = updatedEnchantingBonusDamage - oldEnchantingBonusDamage
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null) then
            call EnchanterAddItemBonusesEx(hero, whichItem, enchantingBonusHeroStatAndDefenseDiff, enchantingBonusDamageDiff)
        endif
        set whichItem = null
        set i = i + 1
    endloop
    call EnchanterSystemSaveBonus(hero, ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS, updatedEnchantingBonusHeroStatAndDefense)
    call EnchanterSystemSaveBonusReal(hero, ENCHANTER_SYSTEM_KEY_DAMAGE_BONUS, updatedEnchantingBonusDamage)
endfunction

function EnchanterSystemRemoveUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(EnchanterSystemHashTable, GetHandleId(whichUnit))
endfunction

hook RemoveUnit EnchanterSystemRemoveUnit

// Arrow Key System by Anitarf

library AStructCoreInterfaceArrowKeys

	/**
	 * Functions following this function interface can be used as keypress event responses.
	 * \param key Parameter values: \p AArrowKeys.keyUp, \p AArrowKeys.keyDown, \p AArrowKeys.keyLeft, \p AArrowKeys.keyRight
	 * \param pressed true-key was pressed, false-key was released
	 */
	function interface AArrowKeysOnPressAction takes AArrowKeys arrowKeys, integer key, boolean pressed returns nothing

	/**
	 * Use \ref playerArrowKeys() to refer to each player's instance.
	 * \author Anitarf
	 * \author Baradé (adaption for World of Warcraft Reforged)
	 * <a href="http://www.wc3c.net/showthread.php?t=101271">source</a>
	 */
	struct AArrowKeys
		public static constant integer keyUp = 0
		public static constant integer keyDown = 1
		public static constant integer keyLeft = 2
		public static constant integer keyRight = 3
		/**
		* the following constant determines the behaviour of the vertical and horizontal
		* variables. For example, if a player presses the up key and then presses the down
		* key afterwards while still holding the up key, the vertical variable will be set
		* to -1. Then, if the player releases the down key while still keeping the up key
		* pressed, if RESUME_PREVIOUS_KEY is true the vertical variable will be set back
		* to 1, else it will be set to 0.
		*/
		// static construction members
		private static boolean m_resumePreviousKey
		// static dynamic members
		/**
		* these are the external functions that get called when an arrow key is pressed/released
		* you can set these variables to your functions that follow the Event function interface
		* you don't need a different function for each event, you can set all these variables to
		* a single function, since the function's parameters tell you what event occured.
		*/
		private static AArrowKeysOnPressAction m_onPressUpAction
		private static AArrowKeysOnPressAction m_onReleaseUpAction
		private static AArrowKeysOnPressAction m_onPressDownAction
		private static AArrowKeysOnPressAction m_onReleaseDownAction
		private static AArrowKeysOnPressAction m_onPressLeftAction
		private static AArrowKeysOnPressAction m_onReleaseLeftAction
		private static AArrowKeysOnPressAction m_onPressRightAction
		private static AArrowKeysOnPressAction m_onReleaseRightAction
		// static members
		private static trigger m_pressUpTrigger
		private static trigger m_releaseUpTrigger
		private static trigger m_pressDownTrigger
		private static trigger m_releaseDownTrigger
		private static trigger m_pressLeftTrigger
		private static trigger m_releaseLeftTrigger
		private static trigger m_pressRightTrigger
		private static trigger m_releaseRightTrigger
		private static thistype array m_playerArrowKeys[28] /// \todo Use \ref bj_MAX_PLAYERS, vJass bug.
		// dynamic members
		// these are the "quick press" variables. They work similarly to the variables above,
		// except that they aren't set to 0/false when a key is released. If you are checking
		// the above variables on a periodic timer, you could miss a keypress if a player
		// quickly presses and releases a key, the variables below allow you to catch such
		// quick keypresses. Note that you must set these variables to 0/false yourself once
		// you check them or they'll remain permanently set to 1/-1/true. Basicaly these
		// variables tell you if a key has been pressed since you last set them to 0/false.
		private integer m_verticalQuickPress
		private integer m_horizontalQuickPress
		private boolean m_upQuickPress
		private boolean m_downQuickPress
		private boolean m_leftQuickPress
		private boolean m_rightQuickPress
		// construction members
		private player m_player
		//members
		// this tells you the status of the arrow keys in the two directions for each player
		// index 0 holds the values for player 1 (red), index 11 for player 12 (brown)
		// a value of 0 means no keys pressed, 1 means right/up, -1 means left/down
		 // do not change the value of these variables
		private integer m_vertical
		private integer m_horizontal
		// this tells you the status of each arrow key individualy for each player
		// index 0 holds the values for player 1 (red), index 11 for player 12 (brown)
		// this is basicaly the same as vertical/horizontal, you can use whichever you want
		// do not change the value of these variables
		private boolean m_up
		private boolean m_down
		private boolean m_left
		private boolean m_right

		// dynamic members

		public method setVerticalQuickPress takes integer verticalQuickPress returns nothing
			set this.m_verticalQuickPress = verticalQuickPress
		endmethod

		public method verticalQuickPress takes nothing returns integer
			return this.m_verticalQuickPress
		endmethod

		public method setHorizontalQuickPress takes integer horizontalQuickPress returns nothing
			set this.m_horizontalQuickPress = horizontalQuickPress
		endmethod

		public method horizontalQuickPress takes nothing returns integer
			return this.m_horizontalQuickPress
		endmethod

		public method setUpQuickPress takes boolean upQuickPress returns nothing
			set this.m_upQuickPress = upQuickPress
		endmethod

		public method upQuickPress takes nothing returns boolean
			return this.m_upQuickPress
		endmethod

		public method setDownQuickPress takes boolean downQuickPress returns nothing
			set this.m_downQuickPress = downQuickPress
		endmethod

		public method downQuickPress takes nothing returns boolean
			return this.m_downQuickPress
		endmethod

		public method setLeftQuickPress takes boolean leftQuickPress returns nothing
			set this.m_leftQuickPress = leftQuickPress
		endmethod

		public method leftQuickPress takes nothing returns boolean
			return this.m_leftQuickPress
		endmethod

		public method setRightQuickPress takes boolean rightQuickPress returns nothing
			set this.m_rightQuickPress = rightQuickPress
		endmethod

		public method rightQuickPress takes nothing returns boolean
			return this.m_rightQuickPress
		endmethod

		// construction members

		public method player takes nothing returns player
			return this.m_player
		endmethod

		// members

		public method vertical takes nothing returns integer
			return this.m_vertical
		endmethod

		public method horizontal takes nothing returns integer
			return this.m_horizontal
		endmethod

		public method up takes nothing returns boolean
			return this.m_up
		endmethod

		public method down takes nothing returns boolean
			return this.m_down
		endmethod

		public method left takes nothing returns boolean
			return this.m_left
		endmethod

		public method right takes nothing returns boolean
			return this.m_right
		endmethod

		public static method create takes player user returns thistype
			local thistype this = thistype.allocate()
			// dynamic members
			set this.m_verticalQuickPress = 0
			set this.m_horizontalQuickPress = 0
			set this.m_upQuickPress = false
			set this.m_downQuickPress = false
			set this.m_leftQuickPress = false
			set this.m_rightQuickPress = false
			// construction members
			set this.m_player = user
			// members
			set this.m_vertical = 0
			set this.m_horizontal = 0
			set this.m_up = false
			set this.m_down = false
			set this.m_left = false
			set this.m_right = false
			return this
		endmethod

		// members

		private static method triggerActionKeyPressDown takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_down = true
			set this.m_vertical = -1
			set this.m_downQuickPress = true
			set this.m_verticalQuickPress = -1
			if (thistype.m_onPressDownAction != 0) then
				call thistype.m_onPressDownAction.execute(this, thistype.keyDown, true)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyReleaseDown takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_down = false
			if (thistype.m_resumePreviousKey and this.m_up) then
				set this.m_vertical = 1
			else
				set this.m_vertical = 0
			endif
			if (thistype.m_onReleaseDownAction != 0) then
				call thistype.m_onReleaseDownAction.execute(this, thistype.keyDown, false)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyPressUp takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_up = true
			set this.m_vertical = 1
			set this.m_upQuickPress = true
			set this.m_verticalQuickPress = 1
			if (thistype.m_onPressUpAction != 0) then
				call thistype.m_onPressUpAction.execute(this, thistype.keyUp, true)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyReleaseUp takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_up = false
			if (thistype.m_resumePreviousKey and this.m_down) then
				set this.m_vertical = -1
			else
				set this.m_vertical = 0
			endif
			if (thistype.m_onReleaseUpAction != 0) then
				call thistype.m_onReleaseUpAction.execute(this, thistype.keyUp, false)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyPressLeft takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_left = true
			set this.m_horizontal = -1
			set this.m_leftQuickPress = true
			set this.m_horizontalQuickPress = -1
			if (thistype.m_onPressLeftAction != 0) then
				call thistype.m_onPressLeftAction.execute(this, thistype.keyLeft, true)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyReleaseLeft takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_left = false
			if (thistype.m_resumePreviousKey and this.m_right) then
				set this.m_horizontal = 1
			else
				set this.m_horizontal = 0
			endif
			if (thistype.m_onReleaseLeftAction != 0) then
				call thistype.m_onReleaseLeftAction.execute(this, thistype.keyLeft, false)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyPressRight takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_right = true
			set this.m_horizontal = 1
			set this.m_rightQuickPress = true
			set this.m_horizontalQuickPress = 1
			if (thistype.m_onPressRightAction != 0) then
				call thistype.m_onPressRightAction.execute(this, thistype.keyRight, true)
			endif
			set triggerPlayer = null
		endmethod

		private static method triggerActionKeyReleaseRight takes nothing returns nothing
			local player triggerPlayer = GetTriggerPlayer()
			local thistype this = thistype.m_playerArrowKeys[GetPlayerId(triggerPlayer)]
			set this.m_right = false
			if (thistype.m_resumePreviousKey and this.m_left) then
				set this.m_horizontal = -1
			else
				set this.m_horizontal = 0
			endif
			if (thistype.m_onReleaseRightAction != 0) then
				call thistype.m_onReleaseRightAction.execute(this, thistype.keyRight, false)
			endif
			set triggerPlayer = null
		endmethod

		public static method init takes boolean resumePreviousKey returns nothing
			local triggeraction triggerAction
			local integer i
			local player user
			local event triggerEvent
			// static dynamic members
			set thistype.m_onPressUpAction = 0
			set thistype.m_onReleaseUpAction = 0
			set thistype.m_onPressDownAction = 0
			set thistype.m_onReleaseDownAction = 0
			set thistype.m_onPressLeftAction = 0
			set thistype.m_onReleaseLeftAction = 0
			set thistype.m_onPressRightAction = 0
			set thistype.m_onReleaseRightAction = 0
			// static construction members
			set thistype.m_resumePreviousKey = resumePreviousKey
			// static members
			set thistype.m_pressUpTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_pressUpTrigger, function thistype.triggerActionKeyPressUp)
			set triggerAction = null
			set thistype.m_releaseUpTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_releaseUpTrigger, function thistype.triggerActionKeyReleaseUp)
			set triggerAction = null
			set thistype.m_pressDownTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_pressDownTrigger, function thistype.triggerActionKeyPressDown)
			set triggerAction = null
			set thistype.m_releaseDownTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_releaseDownTrigger, function thistype.triggerActionKeyReleaseDown)
			set triggerAction = null
			set thistype.m_pressLeftTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_pressLeftTrigger, function thistype.triggerActionKeyPressLeft)
			set triggerAction = null
			set thistype.m_releaseLeftTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_releaseLeftTrigger, function thistype.triggerActionKeyReleaseLeft)
			set triggerAction = null
			set thistype.m_pressRightTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_pressRightTrigger, function thistype.triggerActionKeyPressRight)
			set triggerAction = null
			set thistype.m_releaseRightTrigger = CreateTrigger()
			set triggerAction = TriggerAddAction(thistype.m_releaseRightTrigger, function thistype.triggerActionKeyReleaseRight)
			set triggerAction = null
			set i = 0
			loop
				exitwhen (i == bj_MAX_PLAYERS)
				set user = Player(i)
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_pressUpTrigger, user, EVENT_PLAYER_ARROW_UP_DOWN)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_releaseUpTrigger, user, EVENT_PLAYER_ARROW_UP_UP)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_pressDownTrigger, user, EVENT_PLAYER_ARROW_DOWN_DOWN)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_releaseDownTrigger, user, EVENT_PLAYER_ARROW_DOWN_UP)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_pressLeftTrigger, user, EVENT_PLAYER_ARROW_LEFT_DOWN)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_releaseLeftTrigger, user, EVENT_PLAYER_ARROW_LEFT_UP)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_pressRightTrigger, user, EVENT_PLAYER_ARROW_RIGHT_DOWN)
				set triggerEvent = null
				set triggerEvent = TriggerRegisterPlayerEvent(thistype.m_releaseRightTrigger, user, EVENT_PLAYER_ARROW_RIGHT_UP)
				set triggerEvent = null
				set user = null
				set thistype.m_playerArrowKeys[i] = thistype.create(user)
				set i = i + 1
			endloop
		endmethod

		public static method cleanUp takes nothing returns nothing
			local integer i
			// static members
			call DestroyTrigger(thistype.m_pressUpTrigger)
			set thistype.m_pressUpTrigger = null
			call DestroyTrigger(thistype.m_releaseUpTrigger)
			set thistype.m_releaseUpTrigger = null
			call DestroyTrigger(thistype.m_pressDownTrigger)
			set thistype.m_pressDownTrigger = null
			call DestroyTrigger(thistype.m_releaseDownTrigger)
			set thistype.m_releaseDownTrigger = null
			call DestroyTrigger(thistype.m_pressLeftTrigger)
			set thistype.m_pressLeftTrigger = null
			call DestroyTrigger(thistype.m_releaseLeftTrigger)
			set thistype.m_releaseLeftTrigger = null
			call DestroyTrigger(thistype.m_pressRightTrigger)
			set thistype.m_pressRightTrigger = null
			call DestroyTrigger(thistype.m_releaseRightTrigger)
			set thistype.m_releaseRightTrigger = null
			set i = 0
			loop
				exitwhen (i == bj_MAX_PLAYERS)
				if (thistype.m_playerArrowKeys[i] != 0) then
					call thistype.m_playerArrowKeys[i].destroy()
					set thistype.m_playerArrowKeys[i] = 0
				endif
				set i = i + 1
			endloop
		endmethod

		// static dynamic members

		public static method setOnPressUpAction takes AArrowKeysOnPressAction onPressUpAction returns nothing
			set thistype.m_onPressUpAction = onPressUpAction
		endmethod

		public static method onPressUpAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onPressUpAction
		endmethod

		public static method setOnReleaseUpAction takes AArrowKeysOnPressAction onReleaseUpAction returns nothing
			set thistype.m_onReleaseUpAction = onReleaseUpAction
		endmethod

		public static method onReleaseUpAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onReleaseUpAction
		endmethod

		public static method setOnPressDownAction takes AArrowKeysOnPressAction onPressDownAction returns nothing
			set thistype.m_onPressDownAction = onPressDownAction
		endmethod

		public static method onPressDownAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onPressDownAction
		endmethod

		public static method setOnReleaseDownAction takes AArrowKeysOnPressAction onReleaseDownAction returns nothing
			set thistype.m_onReleaseDownAction = onReleaseDownAction
		endmethod

		public static method onReleaseDownAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onReleaseDownAction
		endmethod

		public static method setOnPressLeftAction takes AArrowKeysOnPressAction onPressLeftAction returns nothing
			set thistype.m_onPressLeftAction = onPressLeftAction
		endmethod

		public static method onPressLeftAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onPressLeftAction
		endmethod

		public static method setOnReleaseLeftAction takes AArrowKeysOnPressAction onReleaseLeftAction returns nothing
			set thistype.m_onReleaseLeftAction = onReleaseLeftAction
		endmethod

		public static method onReleaseLeftAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onReleaseLeftAction
		endmethod

		public static method setOnPressRightAction takes AArrowKeysOnPressAction onPressRightAction returns nothing
			set thistype.m_onPressRightAction = onPressRightAction
		endmethod

		public static method onPressRightAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onPressRightAction
		endmethod

		public static method setOnReleaseRightAction takes AArrowKeysOnPressAction onReleaseRightAction returns nothing
			set thistype.m_onReleaseRightAction = onReleaseRightAction
		endmethod

		public static method onReleaseRightAction takes nothing returns AArrowKeysOnPressAction
			return thistype.m_onReleaseRightAction
		endmethod

		// static methods

		public static method playerArrowKeys takes player user returns thistype
			return thistype.m_playerArrowKeys[GetPlayerId(user)]
		endmethod
    endstruct

endlibrary

// Third person camera system by Opossum

library AStructCoreInterfaceThirdPersonCamera requires AStructCoreInterfaceArrowKeys

	/**
	 * \brief Adds a dynamic third person camera to the game.
	 * Its main purpose is to enable the user a highly configurable camera without the usual
	 * limitations of third person cameras. Using this camera you can basically use any kind
	 * of terrain on your map without caring about the cam falling below the terrain or
	 * clipping parts of the terrain.
	 * Note that you have to initialize \ref AArrowKeys before initializing this structure.
	 * Thanks to Wc3C.net user Opossum for this great system!
	 * \author Opossum
	 * \author Baradé (adaption for World of Warcraft Reforged)
	 * <a href="http://www.wc3c.net/showthread.php?t=104786">Wc3C.net thread</a>
	 */
	struct AThirdPersonCamera
		private static constant real distanceAoaMin = -15.0
		private static constant real distanceDistanceMin = 300.0
		private static constant real distanceAoaMax = -65.0
		private static constant real distanceDistanceMax = 500.0
		private static constant real offsetAoaMin = -35.0
		private static constant real offsetOffsetMin = 0.0
		private static constant real offsetAoaMax = -70.0
		private static constant real offsetOffsetMax = 150.0
		private static constant real zOffset = 100.0
		private static constant real timeout = 0.1
		private static constant real terrainSampling = 32
		private static constant real panDuration = 0.5
		private static constant real angleAboveTerrain = 15.0
		private static constant real defaultAoa = -20.0
		private static constant real defaultRot = 0.0
		private static constant real fieldOfView = 120.0
		private static constant real farZ = 5000.0
		private static constant real cliffDistance = 500.0
		// key settings
		private static constant boolean inverted = false
		private static constant real minAoa = -65.0
		private static constant real maxAoa = 0.0
		private static constant real maxRot = 105.0
		private static constant real aoaInterval = 3.0
		private static constant real rotInterval = 7.5
		// static construction members
		private static boolean m_useArrowKeys
		// static members
		private static thistype array m_playerThirdPersonCamera[28] /// \todo bj_MAX_PLAYERS
		private static location m_location
		private static real m_distanceM
		private static real m_distanceT
		private static real m_offsetM
		private static real m_offsetT
		private static timer m_timer
		// dynamic members
		private real m_camAoa
		private real m_camRot
		// construction members
		private player m_player
		// members
		private unit m_unit
		private boolean m_isEnabled
		private timer m_firstPan

		// dynamic members

		public method setCamAoa takes real camAoa returns nothing
			set this.m_camAoa = camAoa
		endmethod

		public method camAoa takes nothing returns real
			return this.m_camAoa
		endmethod

		public method setCamRot takes real camRot returns nothing
			set this.m_camRot = camRot
		endmethod

		public method camRot takes nothing returns real
			return this.m_camRot
		endmethod

		// construction members

		public method player takes nothing returns player
			return this.m_player
		endmethod

		// members

		public method unit takes nothing returns unit
			return this.m_unit
		endmethod

		public method isEnabled takes nothing returns boolean
			return this.m_isEnabled
		endmethod

		//methods

		public method disable takes nothing returns nothing
			if (TimerGetRemaining(this.m_firstPan) > 0.0) then
				call PauseTimer(this.m_firstPan)
			endif
			set this.m_unit = null
			set this.m_isEnabled = false
		endmethod

		/// Functions for distance and offset. These are linear mathematical functions y = mx+t.
		private static method interpolateDistance takes real angleOfAttack returns real
			if (angleOfAttack <= thistype.distanceAoaMax * bj_DEGTORAD) then
				return thistype.distanceDistanceMax
			elseif (angleOfAttack >= thistype.distanceAoaMin * bj_DEGTORAD) then
				return thistype.distanceDistanceMin
			endif
			return thistype.m_distanceM * angleOfAttack + thistype.m_distanceT
		endmethod

		private static method interpolateOffset takes real angleOfAttack returns real
			if (angleOfAttack <= thistype.offsetAoaMax * bj_DEGTORAD) then
				return thistype.offsetOffsetMax
			elseif (angleOfAttack >= thistype.offsetAoaMin * bj_DEGTORAD) then
				return thistype.offsetOffsetMin
			endif
			return thistype.m_offsetM * angleOfAttack + thistype.m_offsetT
		endmethod

		private static method cappedReal takes real r, real lowBound, real highBound returns real
			if r < lowBound then
				return lowBound
			elseif r > highBound then
				return highBound
			endif
			return r
		endmethod

		private method applyCam takes real duration returns nothing
			local real aoa = GetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK) - 2 * bj_PI
			local real offset = thistype.interpolateOffset(aoa)
			local real newaoa
			local real maxd
			local real tarz
			local real newx
			local real newy
			local real newm
			local real maxm = -1
			local real r = thistype.terrainSampling
			local real dx
			local real dy

			if (thistype.m_useArrowKeys) then
				if (thistype.inverted) then
					set this.m_camRot = thistype.cappedReal(this.m_camRot + (AArrowKeys.playerArrowKeys(this.m_player).horizontal() + AArrowKeys.playerArrowKeys(this.m_player).horizontalQuickPress()) * thistype.rotInterval, -thistype.maxRot, thistype.maxRot)
				else
					set this.m_camRot = thistype.cappedReal(this.m_camRot - (AArrowKeys.playerArrowKeys(this.m_player).horizontal() + AArrowKeys.playerArrowKeys(this.m_player).horizontalQuickPress()) * thistype.rotInterval, -thistype.maxRot, thistype.maxRot)
				endif
				call AArrowKeys.playerArrowKeys(this.m_player).setHorizontalQuickPress(0)
				set this.m_camAoa = thistype.cappedReal(this.m_camAoa - (AArrowKeys.playerArrowKeys(this.m_player).vertical() + AArrowKeys.playerArrowKeys(this.m_player).verticalQuickPress()) * thistype.aoaInterval, thistype.minAoa, thistype.maxAoa)
				call AArrowKeys.playerArrowKeys(this.m_player).setVerticalQuickPress(0)
			endif

			call SetCameraField(CAMERA_FIELD_ROTATION, GetUnitFacing(this.m_unit) + this.m_camRot, duration)
			call SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, thistype.fieldOfView, duration)
			call SetCameraField(CAMERA_FIELD_FARZ, thistype.farZ, duration)
			call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, thistype.interpolateDistance(aoa), duration)

			call PanCameraToTimed(GetUnitX(this.m_unit) + offset * Cos(bj_DEGTORAD*GetUnitFacing(this.m_unit)), GetUnitY(this.m_unit) + offset * Sin(bj_DEGTORAD*GetUnitFacing(this.m_unit)), duration)

			set newx = GetCameraTargetPositionX()
			set newy = GetCameraTargetPositionY()
			set maxd = thistype.cliffDistance + GetCameraField(CAMERA_FIELD_TARGET_DISTANCE)
			set dx = -Cos(GetCameraField(CAMERA_FIELD_ROTATION))*r
			set dy = -Sin(GetCameraField(CAMERA_FIELD_ROTATION))*r

			call MoveLocation(thistype.m_location, newx, newy)
			set tarz = GetCameraTargetPositionZ()
			call SetCameraField(CAMERA_FIELD_ZOFFSET, GetCameraField(CAMERA_FIELD_ZOFFSET) + GetLocationZ(thistype.m_location) + thistype.zOffset + GetUnitFlyHeight(this.m_unit) - tarz, duration)

			loop
				exitwhen (r > maxd)
				set newx = newx + dx
				set newy = newy + dy
				call MoveLocation(thistype.m_location, newx, newy)
				set newm = (GetLocationZ(thistype.m_location) - tarz) / r
				if (newm > maxm) then
					set maxm = newm
				endif
				set r = r + thistype.terrainSampling
			endloop
			set newaoa = - Atan(maxm) * bj_RADTODEG - thistype.angleAboveTerrain
			if (this.m_camAoa < newaoa) then
				set newaoa = this.m_camAoa
			endif
			call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, newaoa, duration)
		endmethod

		public method enable takes unit whichUnit, real firstPan returns nothing
			if (this.isEnabled()) then
				call this.disable()
			endif
			set this.m_unit = whichUnit
			set this.m_isEnabled = true
			call TimerStart(this.m_firstPan, firstPan, false, null)
			if (GetLocalPlayer() == this.m_player) then
				call StopCamera()
				if (whichUnit != null) then
					call this.applyCam(firstPan)
				endif
			endif
		endmethod

		public method pause takes nothing returns nothing
			call PauseTimer(this.m_firstPan)
			set this.m_isEnabled = false
		endmethod

		public method resume takes nothing returns nothing
			call ResumeTimer(this.m_firstPan)
			set this.m_isEnabled = true
		endmethod

		public method resetCamAoa takes nothing returns nothing
			set this.m_camAoa = thistype.defaultAoa
		endmethod

		public method resetCamRot takes nothing returns nothing
			set this.m_camRot = thistype.defaultRot
		endmethod

		private static method create takes player usedPlayer returns thistype
			local thistype this = thistype.allocate()
			// dynamic members
			set this.m_camAoa = thistype.defaultAoa
			set this.m_camRot = thistype.defaultRot
			// construction members
			set this.m_player = usedPlayer
			// members
			set this.m_unit = null
			set this.m_isEnabled = false
			set this.m_firstPan = CreateTimer()
			return this
		endmethod

		public method onDestroy takes nothing returns nothing
			// construction members
			set this.m_player = null
			// members
			set this.m_unit = null
			call PauseTimer(this.m_firstPan)
			call DestroyTimer(this.m_firstPan)
			set this.m_firstPan = null
		endmethod

		private static method timerFunctionRefresh takes nothing returns nothing
			local player localPlayer = GetLocalPlayer()
			local integer playerId = GetPlayerId(localPlayer)
			if (thistype.m_playerThirdPersonCamera[playerId] != 0 and thistype.m_playerThirdPersonCamera[playerId].m_isEnabled) then
				if (TimerGetRemaining(thistype.m_playerThirdPersonCamera[playerId].m_firstPan) <= thistype.panDuration) then
					call thistype.m_playerThirdPersonCamera[playerId].applyCam(thistype.panDuration)
				else
					call thistype.m_playerThirdPersonCamera[playerId].applyCam(TimerGetRemaining(thistype.m_playerThirdPersonCamera[playerId].m_firstPan))
				endif
			endif
		endmethod

		public static method init takes boolean useArrowKeys returns nothing
			// static construction members
			set thistype.m_useArrowKeys = useArrowKeys
			// static members
			set thistype.m_location = Location(0,0)
			set thistype.m_distanceM = (thistype.distanceDistanceMax-thistype.distanceDistanceMin)/((thistype.distanceAoaMax - thistype.distanceAoaMin)*bj_DEGTORAD)
			set thistype.m_distanceT = thistype.distanceDistanceMin-thistype.distanceAoaMin*bj_DEGTORAD*thistype.m_distanceM
			set thistype.m_offsetM = (thistype.offsetOffsetMax-thistype.offsetOffsetMin)/((thistype.offsetAoaMax-thistype.offsetAoaMin)*bj_DEGTORAD)
			set thistype.m_offsetT = thistype.offsetOffsetMin-thistype.offsetAoaMin*bj_DEGTORAD* thistype.m_offsetM
			set thistype.m_timer = CreateTimer()
			call TimerStart(thistype.m_timer, thistype.timeout, true, function thistype.timerFunctionRefresh)
		endmethod

		public static method cleanUp takes nothing returns nothing
			call PauseTimer(thistype.m_timer)
			call RemoveLocation(thistype.m_location)
			set thistype.m_location = null
			call DestroyTimer(thistype.m_timer)
			set thistype.m_timer = null
		endmethod

		public static method playerThirdPersonCamera takes player user returns thistype
			if (thistype.m_playerThirdPersonCamera[GetPlayerId(user)] == 0) then
				set thistype.m_playerThirdPersonCamera[GetPlayerId(user)] = thistype.create(user)
			endif
			return thistype.m_playerThirdPersonCamera[GetPlayerId(user)]
		endmethod
	endstruct

endlibrary

// Barade's IJKL Movement System 1.0

globals
    constant real MOVEMENT_SYSTEM_ROTATION_PER_INTERVAL = 12.0

    unit array MovementSystemUnit
    boolean array MovementSystemMoveForward
    boolean array MovementSystemMoveBackward
    boolean array MovementSystemMoveUp
    boolean array MovementSystemRotateRight
    boolean array MovementSystemRotateLeft
    trigger MovementSystemForwardTrigger = CreateTrigger()
    trigger MovementSystemForwardStopTrigger = CreateTrigger()
    trigger MovementSystemBackwardTrigger = CreateTrigger()
    trigger MovementSystemBackwardStopTrigger = CreateTrigger()
    trigger MovementSystemUpTrigger = CreateTrigger()
    trigger MovementSystemUpStopTrigger = CreateTrigger()
    trigger MovementSystemRightTrigger = CreateTrigger()
    trigger MovementSystemRightStopTrigger = CreateTrigger()
    trigger MovementSystemLeftTrigger = CreateTrigger()
    trigger MovementSystemLeftStopTrigger = CreateTrigger()
    timer MovementSystemUpdateTimer = CreateTimer()
endglobals

function MovementSystemSetPlayerUnit takes player whichPlayer, unit whichUnit returns nothing
    set MovementSystemUnit[GetPlayerId(whichPlayer)] = whichUnit
endfunction

function MovementSystemResetPlayerUnit takes player whichPlayer returns nothing
    set MovementSystemUnit[GetPlayerId(whichPlayer)] = null
endfunction

function MovementSystemGetPlayerUnit takes player whichPlayer returns unit
    return MovementSystemUnit[GetPlayerId(whichPlayer)]
endfunction

function MovementSystemTriggerConditionMovementForward takes nothing returns boolean
    return MovementSystemGetPlayerUnit(GetTriggerPlayer()) != null
endfunction

function MovementSystemTriggerActionMoveForward takes nothing returns nothing
    set MovementSystemMoveForward[GetPlayerId(GetTriggerPlayer())] = true
endfunction

function MovementSystemTriggerConditionMovementForwardStop takes nothing returns boolean
    return MovementSystemMoveForward[GetPlayerId(GetTriggerPlayer())]
endfunction

function MovementSystemTriggerActionMoveForwardStop takes nothing returns nothing
    set MovementSystemMoveForward[GetPlayerId(GetTriggerPlayer())] = false
    call ResetUnitAnimation(MovementSystemGetPlayerUnit(GetTriggerPlayer()))
endfunction

function MovementSystemTriggerConditionMovementBackward takes nothing returns boolean
    return MovementSystemGetPlayerUnit(GetTriggerPlayer()) != null
endfunction

function MovementSystemTriggerActionMoveBackward takes nothing returns nothing
    set MovementSystemMoveBackward[GetPlayerId(GetTriggerPlayer())] = true
endfunction

function MovementSystemTriggerConditionMovementBackwardStop takes nothing returns boolean
    return MovementSystemMoveBackward[GetPlayerId(GetTriggerPlayer())]
endfunction

function MovementSystemTriggerActionMoveBackwardStop takes nothing returns nothing
    set MovementSystemMoveBackward[GetPlayerId(GetTriggerPlayer())] = false
    call ResetUnitAnimation(MovementSystemGetPlayerUnit(GetTriggerPlayer()))
endfunction

function MovementSystemTriggerConditionMovementUp takes nothing returns boolean
    return MovementSystemGetPlayerUnit(GetTriggerPlayer()) != null
endfunction

function MovementSystemTriggerActionMoveUp takes nothing returns nothing
    set MovementSystemMoveUp[GetPlayerId(GetTriggerPlayer())] = true
endfunction

function MovementSystemTriggerConditionMovementUpStop takes nothing returns boolean
    return MovementSystemMoveUp[GetPlayerId(GetTriggerPlayer())]
endfunction

function MovementSystemTriggerActionMoveUpStop takes nothing returns nothing
    set MovementSystemMoveUp[GetPlayerId(GetTriggerPlayer())] = false
endfunction

function MovementSystemTriggerConditionMovementRight takes nothing returns boolean
    return MovementSystemGetPlayerUnit(GetTriggerPlayer()) != null
endfunction

function MovementSystemTriggerActionRotateRight takes nothing returns nothing
    set MovementSystemRotateRight[GetPlayerId(GetTriggerPlayer())] = true
endfunction

function MovementSystemTriggerConditionMovementRightStop takes nothing returns boolean
    return MovementSystemRotateRight[GetPlayerId(GetTriggerPlayer())]
endfunction

function MovementSystemTriggerActionRotateRightStop takes nothing returns nothing
    set MovementSystemRotateRight[GetPlayerId(GetTriggerPlayer())] = false
endfunction

function MovementSystemTriggerConditionMovementLeft takes nothing returns boolean
    return MovementSystemGetPlayerUnit(GetTriggerPlayer()) != null
endfunction

function MovementSystemTriggerActionRotateLeft takes nothing returns nothing
    set MovementSystemRotateLeft[GetPlayerId(GetTriggerPlayer())] = true
endfunction

function MovementSystemTriggerConditionMovementLeftStop takes nothing returns boolean
    return MovementSystemRotateLeft[GetPlayerId(GetTriggerPlayer())]
endfunction

function MovementSystemTriggerActionRotateLeftStop takes nothing returns nothing
    set MovementSystemRotateLeft[GetPlayerId(GetTriggerPlayer())] = false
endfunction

function MovementSystemTimerFunctionUpdate takes nothing returns nothing
    local unit whichUnit = null
    local real facing = 0.0
    local real x = 0.0
    local real y = 0.0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichUnit = MovementSystemGetPlayerUnit(Player(i))
        if (whichUnit != null and IsUnitAliveBJ(whichUnit)) then
            if (MovementSystemRotateRight[i]) then
                set facing = ModuloReal(GetUnitFacing(whichUnit) - MOVEMENT_SYSTEM_ROTATION_PER_INTERVAL, 360.0)
            elseif (MovementSystemRotateLeft[i]) then
                set facing = ModuloReal(GetUnitFacing(whichUnit) + MOVEMENT_SYSTEM_ROTATION_PER_INTERVAL, 360.0)
            elseif (MovementSystemMoveForward[i]) then
                set facing = GetUnitFacing(whichUnit)
            elseif (MovementSystemMoveBackward[i]) then
                set facing =  ModuloReal(GetUnitFacing(whichUnit) - 180.0, 360.0)
            endif

            if (MovementSystemMoveForward[i]) then
                if (GetUnitCurrentOrder(whichUnit) == OrderId("idle")) then
                    set x = PolarProjectionX(GetUnitX(whichUnit), facing, 5.0)
                    set y = PolarProjectionY(GetUnitY(whichUnit), facing, 5.0)
                    call SetUnitPosition(whichUnit, x, y)
                    call SetUnitAnimation(whichUnit, "stand")
                endif
            elseif (MovementSystemMoveBackward[i]) then
                if (GetUnitCurrentOrder(whichUnit) == OrderId("idle")) then
                    set x = PolarProjectionX(GetUnitX(whichUnit), facing, 5.0)
                    set y = PolarProjectionY(GetUnitY(whichUnit), facing, 5.0)
                    call SetUnitPosition(whichUnit, x, y)
                    call SetUnitAnimation(whichUnit, "stand")
                endif
            elseif (MovementSystemRotateRight[i] or MovementSystemRotateLeft[i]) then
                call SetUnitFacing(whichUnit, facing)
            endif

            if (MovementSystemMoveUp[i] and IsUnitType(whichUnit, UNIT_TYPE_FLYING)) then
                call SetUnitFlyHeight(whichUnit, RMinBJ(GetUnitFlyHeight(whichUnit) + 3.0, 500.0), 0.0)
            endif
        endif
        set whichUnit = null
        set i = i + 1
    endloop
endfunction

function MovementSystemEnable takes nothing returns nothing
    call TimerStart(MovementSystemUpdateTimer, 0.01, true, function MovementSystemTimerFunctionUpdate)
endfunction

function MovementSystemDisable takes nothing returns nothing
    call PauseTimer(MovementSystemUpdateTimer)
endfunction

function MovementSystemInit takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemForwardTrigger, Player(i), OSKEY_I, 0, true)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemForwardStopTrigger, Player(i), OSKEY_I, 0, false)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemUpTrigger, Player(i), OSKEY_SPACE, 0, true)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemUpStopTrigger, Player(i), OSKEY_SPACE, 0, false)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemBackwardTrigger, Player(i), OSKEY_K, 0, true)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemBackwardStopTrigger, Player(i), OSKEY_K, 0, false)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemRightTrigger, Player(i), OSKEY_L, 0, true)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemRightStopTrigger, Player(i), OSKEY_L, 0, false)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemLeftTrigger, Player(i), OSKEY_J, 0, true)
        call BlzTriggerRegisterPlayerKeyEvent(MovementSystemLeftStopTrigger, Player(i), OSKEY_J, 0, false)
        set i = i + 1
    endloop
    call TriggerAddCondition(MovementSystemForwardTrigger, Condition(function MovementSystemTriggerConditionMovementForward))
    call TriggerAddAction(MovementSystemForwardTrigger, function MovementSystemTriggerActionMoveForward)
    call TriggerAddCondition(MovementSystemForwardStopTrigger, Condition(function MovementSystemTriggerConditionMovementForwardStop))
    call TriggerAddAction(MovementSystemForwardStopTrigger, function MovementSystemTriggerActionMoveForwardStop)

    call TriggerAddCondition(MovementSystemUpTrigger, Condition(function MovementSystemTriggerConditionMovementUp))
    call TriggerAddAction(MovementSystemUpTrigger, function MovementSystemTriggerActionMoveUp)
    call TriggerAddCondition(MovementSystemUpStopTrigger, Condition(function MovementSystemTriggerConditionMovementUpStop))
    call TriggerAddAction(MovementSystemUpStopTrigger, function MovementSystemTriggerActionMoveUpStop)

    call TriggerAddCondition(MovementSystemBackwardTrigger, Condition(function MovementSystemTriggerConditionMovementBackward))
    call TriggerAddAction(MovementSystemBackwardTrigger, function MovementSystemTriggerActionMoveBackward)
    call TriggerAddCondition(MovementSystemBackwardStopTrigger, Condition(function MovementSystemTriggerConditionMovementBackwardStop))
    call TriggerAddAction(MovementSystemBackwardStopTrigger, function MovementSystemTriggerActionMoveBackwardStop)

    call TriggerAddCondition(MovementSystemRightTrigger, Condition(function MovementSystemTriggerConditionMovementRight))
    call TriggerAddAction(MovementSystemRightTrigger, function MovementSystemTriggerActionRotateRight)
    call TriggerAddCondition(MovementSystemRightStopTrigger, Condition(function MovementSystemTriggerConditionMovementRightStop))
    call TriggerAddAction(MovementSystemRightStopTrigger, function MovementSystemTriggerActionRotateRightStop)

    call TriggerAddCondition(MovementSystemLeftTrigger, Condition(function MovementSystemTriggerConditionMovementLeft))
    call TriggerAddAction(MovementSystemLeftTrigger, function MovementSystemTriggerActionRotateLeft)
    call TriggerAddCondition(MovementSystemLeftStopTrigger, Condition(function MovementSystemTriggerConditionMovementLeftStop))
    call TriggerAddAction(MovementSystemLeftStopTrigger, function MovementSystemTriggerActionRotateLeftStop)
endfunction

// TOC files

function LoadTOCFiles takes nothing returns nothing
    call BlzLoadTOCFile("war3mapImported\\saveguiTOC.toc")
    call BlzLoadTOCFile("war3mapImported\\aiplayersTOC.toc")
endfunction


// Baradé's Mount System

globals
    hashtable MountHashTable = InitHashtable()
endglobals

function MountGet takes unit hero returns unit
    return LoadUnitHandle(MountHashTable, GetHandleId(hero), 0)
endfunction

function MountClear takes unit hero returns nothing
    call FlushChildHashtable(MountHashTable, GetHandleId(hero))
endfunction

function MountKill takes unit hero returns nothing
    local unit mount = MountGet(hero)
    if (mount != null) then
        call KillUnit(mount) // in case there are transported units
    endif
    set mount = null
    call MountClear(hero)
endfunction

function MountReplace takes unit hero, unit mount returns nothing
    call MountKill(hero)
    call SaveUnitHandle(MountHashTable, GetHandleId(hero), 0, mount)
endfunction

function MountGetAll takes player whichPlayer returns group
    local group result = CreateGroup()
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null and MountGet(udg_Hero[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero[playerId]))
    endif

    if (udg_Hero2[playerId] != null and MountGet(udg_Hero2[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero2[playerId]))
    endif

    if (udg_Hero3[playerId] != null and MountGet(udg_Hero3[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero3[playerId]))
    endif

    return result
endfunction

function MountKillAll takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null and MountGet(udg_Hero[playerId]) != null) then
        call MountKill(udg_Hero[playerId])
    endif

    if (udg_Hero2[playerId] != null and MountGet(udg_Hero2[playerId]) != null) then
        call MountKill(udg_Hero2[playerId])
    endif

    if (udg_Hero3[playerId] != null and MountGet(udg_Hero3[playerId]) != null) then
        call MountKill(udg_Hero[playerId])
    endif
endfunction

function MountClearAll takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null) then
        call MountClear(udg_Hero[playerId])
    endif

    if (udg_Hero2[playerId] != null) then
        call MountClear(udg_Hero2[playerId])
    endif

    if (udg_Hero3[playerId] != null) then
        call MountClear(udg_Hero[playerId])
    endif
endfunction

// Barade's Pickpocketing System

globals
    constant real PICKPOCKETING_CHANCE = 45.0
    constant integer PICKPOCKETING_ITEM_TYPE_ID = 'I03F'
endglobals

function PickpocketingStealItem takes unit hero, unit target returns item
    local integer countStealingItem = 0
    local real random = 0.0
    local item stolenItem = null
    if (hero == udg_Hero[GetPlayerId(GetOwningPlayer(hero))]) then
        set countStealingItem = Hero1CountItemsOfItemType(hero, PICKPOCKETING_ITEM_TYPE_ID)
    else
        set countStealingItem = HeroCountItemsOfItemType(hero, PICKPOCKETING_ITEM_TYPE_ID)
    endif
    if (countStealingItem > 0) then
        set random = GetRandomReal(0.0, 100.0)
        if (random <= PICKPOCKETING_CHANCE) then
            set stolenItem = HeroDropRandomItem(target)
            if (stolenItem != null) then
                call UnitAddItem(hero, stolenItem)
                call DisplayTextToPlayer(GetOwningPlayer(target), 0.0, 0.0, GetUnitName(hero) + " has stolen the item " + GetItemName(stolenItem) + " from your unit " + GetUnitName(target) + "!")
                call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, "Stole item " + GetItemName(stolenItem) + " from " + GetUnitName(target) + "!")
            endif

            return stolenItem
        endif
    endif

    return null
endfunction

// Baradé's Vote System
globals
    constant real VOTE_SYSTEM_DEFAULT_TIMEOUT = 15.0

    dialog array VoteSystemVoteDialog
    trigger array VoteSystemVoteButtonClickTrigger
    timer array VoteSystemVoteTimer
    timerdialog array VoteSystemVoteTimerDialog
    boolean array VoteSystemVoteIsRunning
    integer array VoteSystemVoteVotes
    // choices
    button array VoteSystemVoteDialogButton
    trigger array VoteSystemVoteChoiceCallbackTrigger

    integer VoteSystemVotesCounter = 0

    trigger VoteSystemPlayerLeavesTrigger = CreateTrigger()
endglobals

function VoteCreate takes string title returns integer
    return 0
endfunction

function VoteAddChoice takes string name, code callback returns nothing
endfunction

function VoteStart takes integer vote returns nothing
endfunction

// Baradé's Evolution Stone System

function EvolutionStoneSet takes unit hero, integer level returns nothing
    local integer unitTypeId = GetUnitTypeId(hero)
    local integer abilityId = 0
    local ability whichAbility = null
    local integer maxAbilityLevel = 0
    local integer defenseBonus = level * 2
    local integer heroStatsBonus = level * 2
    local real durationBonus = level * 2.0
    local real damageBonus = level * 5.0
    local real lifeBonus = level * 100.0
    local real manaBonus = level * 100.0
    local integer lifeRegenerationBonus = level
    local real chanceRealBonus = level * 0.01
    local real defenseRealBonus = level * 2.0

    local integer i = 1
    local integer j = 0
    local integer max = GetHeroAbilityMaximum(unitTypeId)
    // TODO Reskill hero to restore the base values of the abilities.
    loop
        exitwhen (i >= max)
        set abilityId = GetHeroAbility(unitTypeId, i)
        set whichAbility = BlzGetUnitAbility(hero, abilityId)
        set maxAbilityLevel = GetHeroAbilityMaximumLevel(unitTypeId, i)
        set j = 1
        loop
            exitwhen (j >= maxAbilityLevel)
            call AddAbilityFieldBonuses(abilityId, whichAbility, j, defenseBonus, heroStatsBonus, durationBonus, damageBonus, lifeBonus, manaBonus, lifeRegenerationBonus, chanceRealBonus, defenseRealBonus)
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    // TODO Restore basic hero stats
    // apply increased hero stats
    call ModifyHeroStat(bj_HEROSTAT_STR, hero, bj_MODIFYMETHOD_ADD, heroStatsBonus)
    call ModifyHeroStat(bj_HEROSTAT_AGI, hero, bj_MODIFYMETHOD_ADD, heroStatsBonus)
    call ModifyHeroStat(bj_HEROSTAT_INT, hero, bj_MODIFYMETHOD_ADD, heroStatsBonus)
endfunction

function EvolutionStoneReset takes unit hero returns nothing
    call EvolutionStoneSet(hero, 0)
endfunction

// Jedi Academy

library WoWReforgedJediSystem

function StringTokenToLightSaberColor takes string token returns player
    local string lowerToken = StringCase(token, false)
    if (lowerToken == "red" or lowerToken == "r" or lowerToken == "1") then
        return Player(0)
    elseif (lowerToken == "blue" or lowerToken == "b" or lowerToken == "2") then
        return Player(1)
    elseif (lowerToken == "purple" or lowerToken == "p" or lowerToken == "4") then
        return Player(3)
    elseif (lowerToken == "yellow" or lowerToken == "y" or lowerToken == "5") then
        return Player(4)
    elseif (lowerToken == "orange" or lowerToken == "o" or lowerToken == "6") then
        return Player(5)
    elseif (lowerToken == "green" or lowerToken == "g" or lowerToken == "7") then
        return Player(6)
    endif
    return null
endfunction

function GetLightSaberColorHelpText takes nothing returns string
    return "Available Light Saber Colors (the second number Y is optional and can specify which of the two light sabers should be changed):\n- red/r/1\n- blue/b/2\n- purple/p/4\n- yellow/y/5\n- orange/o/6\n- green/g/7"
endfunction


function StringTokenToLightSaberType takes string token returns integer
    local string lowerToken = StringCase(token, false)
    if (lowerToken == "single" or lowerToken == "s" or lowerToken == "1") then
        return 0
    elseif (lowerToken == "two" or lowerToken == "t" or lowerToken == "2") then
        return 1
    elseif (lowerToken == "double" or lowerToken == "d" or lowerToken == "3") then
        return 2
    elseif (lowerToken == "hilt" or lowerToken == "h" or lowerToken == "4") then
        return 3
    elseif (lowerToken == "obiwan" or lowerToken == "o" or lowerToken == "5") then
        return 4
    elseif (lowerToken == "anakin" or lowerToken == "a" or lowerToken == "6") then
        return 5
    endif
    return -1
endfunction

function GetLightSaberTypeHelpText takes nothing returns string
    return "Available Light Saber Types:\n- single/s/1\n- two/t/2\n- double/d/3\n- hilt/h/3\n- obiwan/o/5\n- anakin/a/6"
endfunction

function RemoveJedi takes unit whichUnit returns nothing
    set udg_TmpUnit = whichUnit
    call ConditionalTriggerExecute(gg_trg_Jedi_Academy_Hero_Leaves)
endfunction

hook RemoveUnit RemoveJedi

endlibrary

library GroupSystem
// Baradé's Group System 1.0
//
// Group support for all kinds of types.
//
// Usage:
// - Copy this code into your map script or a trigger converted into code.
// - Configure the system by changing the values of the constants. Only enable group types which you really need in your map. Adapt the limits to your map.
//
// API:
// The following API functions exist for the type item. Similar functions except for the Enum helper functions provided especially for items should be available for the other supported types.
//
// function GetGroupFilterItem takes nothing returns item
//
// Returns the current filtered item for all functions like ItemGroupEnumItemsInRect.
// You can also use GetFilterItem for items since this Blizzard native exists.
//
// function GetGroupEnumItem takes nothing returns item
//
// Returns the current enumerated item for ForItemGroup.
// Do not use Blizzard's GetEnumItem here. It is only usable in Blizzard's native EnumItemsInRect.
//
// function IsItemInItemGroup takes item whichItem, ItemGroup whichGroup returns boolean
//
// Checks if the given item belongs to the given group and returns true if this is the case or returns false if the item does not belong to the given group.
//
// function CreateItemGroup takes nothing returns ItemGroup
//
// Creates a new item group which must be destroyed at some point or it will leak.
//
// function DestroyItemGroup takes ItemGroup whichGroup returns nothing
//
// Destroys the given item group to prevent leaks.
//
// function ItemGroupAddItem takes ItemGroup whichGroup, item whichItem returns boolean
//
// Adds the givem item to the given item group which makes it a member of the group. Returns only true if it is newly added. If CHECK_UNIQUE is enabled and the group does already
// contain the given item, it won't add it a second time and return false.
//
// function ItemGroupRemoveItem takes ItemGroup whichGroup, item whichItem returns boolean
//
// Removes the given item from the given group and only returns true if the given item was a member of the given group. Otherwise, nothing happens and it returns false.
//
// function BlzItemGroupAddItemGroupFast takes ItemGroup whichGroup, ItemGroup addGroup returns integer
//
// Adds all members of the group addGroup to the group whichGroup.
//
// function BlzGroupRemoveGroupFast takes ItemGroup whichGroup, ItemGroup removeGroup returns integer
//
// Removes all members of the group removeGroup from the group whichGroup.
//
// function ItemGroupClear takes ItemGroup whichGroup returns nothing
//
// Clears the given group which changes the number of members to 0.
//
// function BlzItemGroupGetSize takes ItemGroup whichGroup returns integer
//
// Returns the number of members from the given group.
//
// function BlzItemGroupItemAt takes ItemGroup whichGroup, integer index returns item
//
// Returns the item at the given index from the given group. Make sure that the index is valid. Otherwise, it might return null or some previous member.
//
// function ForItemGroup takes ItemGroup whichGroup, code callback returns nothing
//
// Executes the given callback per member of the given group. You can access the enumerated item with GetGroupEnumItem.
//
// function FirstOfItemGroup takes ItemGroup whichGroup returns item
//
// Returns the first item of the group or null if the group is empty.
//
// function ItemGroupEnumItemsOfType takes ItemGroup whichGroup, integer itemTypeId, boolexpr filter returns nothing
//
// Fills the given group with all items placed on the map which have the given item type ID and match the given filter.
// Use GetGroupFilterItem in the filter to access the filtered item.
// Note that this function does not enumerate items in inventories of units since it uses the Blizzard native EnumItemsInRect with the playable map rect.
//
// function ItemGroupEnumItemsOfPlayer takes ItemGroup whichGroup, player whichPlayer, boolexpr filter returns nothing
//
// Fills the given group with all items placed on the map which have the given owner and match the given filter.
// Use GetGroupFilterItem in the filter to access the filtered item.
// Note that this function does not enumerate items in inventories of units since it uses the Blizzard native EnumItemsInRect with the playable map rect.
//
// function ItemGroupEnumItemsInRect takes ItemGroup whichGroup, rect r, boolexpr filter returns nothing
//
// Fills the given group with all items placed in the given rect and match the given filter.
// Use GetGroupFilterItem in the filter to access the filtered item.
//
// function ItemGroupEnumItemsInRange takes ItemGroup whichGroup, real x, real y, real radius, boolexpr filter returns nothing
//
// Fills the given group with all items placed on the map which have a distance with the maximum of radius from the given coordiantes and match the given filter.
// Use GetGroupFilterItem in the filter to access the filtered item.
// Note that this function does not enumerate items in inventories of units since it uses the Blizzard native EnumItemsInRect with the playable map rect.
//
// Design:
// The provided API is based on Blizzard's Group, Force, Destructable and Item API.
// This system is designed to provide many helper functions to simplify your code.
// It is not intended to make your code faster.
//
// By default, no unit or player groups are supported because of the native types group and force.
// Only primitive types and handle based types are supported for which it makes sense to have groups because of either unique values or because they are placable on the map.
// For IntegerGroups 0 is the null value and means no member.
// However, you can easily use the textmacro to support different types.
// It is recommended that you simply use an IntegerGroup for struct based types.
//
// Adding new members to a group can be faster if CHECK_UNIQUE is disabled but removing members takes longer since the member must be found in the group.
// This could be made faster in the future by storing the index per member per group in a hashtable or using something faster than a JASS array.

    globals
        // The maximum number of group instances per type.
        public constant integer MAX_INSTANCES = 5000
        // The maxmimum number of members per group.
        public constant integer MAX_MEMBERS = 5000
        // Checks if a member does already belong to a group and only adds it if it does not belong to the group yet if this value is true.
        // Otherwise, it won't check and the operation will be faster.
        public constant boolean CHECK_UNIQUE = true
        // types with movable stuff:
        public constant boolean SUPPORT_ITEM_GROUPS = true
        public constant boolean SUPPORT_DESTRUCTABLE_GROUPS = true
        public constant boolean SUPPORT_FOGMODIFIER_GROUPS = false
        public constant boolean SUPPORT_TEXTTAG_GROUPS = false
        public constant boolean SUPPORT_WEATHEREFFECT_GROUPS = false
        public constant boolean SUPPORT_TERRAINDEFORMATION_GROUPS = false
        public constant boolean SUPPORT_EFFECT_GROUPS = false
        public constant boolean SUPPORT_LIGHTNING_GROUPS = false
        public constant boolean SUPPORT_IMAGE_GROUPS = false
        public constant boolean SUPPORT_UBERSPLAT_GROUPS = false
        // basic types:
        public constant boolean SUPPORT_INTEGER_GROUPS = false
        public constant boolean SUPPORT_STRING_GROUPS = false
        public constant boolean SUPPORT_HANDLE_GROUPS = false
        public constant boolean SUPPORT_WIDGET_GROUPS = false
        public constant boolean SUPPORT_TRIGGER_GROUPS = false
    endglobals

    //! textmacro HANDLE_GROUP_SYSTEM takes NAME, TYPE, NULLVALUE
        globals
            private $TYPE$ filter$NAME$ = $NULLVALUE$
            private $TYPE$ enum$NAME$ = $NULLVALUE$
        endglobals

        function GetGroupFilter$NAME$ takes nothing returns $TYPE$
            return filter$NAME$
        endfunction

        function GetGroupEnum$NAME$ takes nothing returns $TYPE$
            return enum$NAME$
        endfunction

        struct $NAME$Group[MAX_INSTANCES]
            private $TYPE$ array members[MAX_MEMBERS]
            private integer count = 0

            public method add takes $TYPE$ which$NAME$ returns boolean
static if (CHECK_UNIQUE) then
                local integer i = 0
                loop
                    exitwhen (i >= count)
                    if (members[i] == which$NAME$) then
                        return false
                    endif
                    set i = i + 1
                endloop
endif
                set members[count] = which$NAME$
                set count = count + 1
                return true
            endmethod

            public method remove takes $TYPE$ which$NAME$ returns boolean
                local integer j = 0
                local integer i = 0
                loop
                    exitwhen (i >= count)
                    if (members[i] == which$NAME$) then
                        set members[i] = $NULLVALUE$

                        set j = i + 1
                        loop
                            exitwhen (j >= count)
                            set members[j - 1] = members[j]
                            set j = j + 1
                        endloop
                        set count = count - 1

                        return true
                    endif
                    set i = i + 1
                endloop

                return false
            endmethod

            public method addGroup takes $NAME$Group addGroup returns integer
                local integer i = 0
                loop
                    exitwhen (i >= addGroup.count)
                    call add(addGroup.members[i])
                    set i = i + 1
                endloop
                return count
            endmethod

            public method removeGroup takes $NAME$Group removeGroup returns integer
                local integer i = 0
                loop
                    exitwhen (i >= removeGroup.count)
                    call remove(removeGroup.members[i])
                    set i = i + 1
                endloop
                return count
            endmethod

            public method contains takes $TYPE$ which$NAME$ returns boolean
                local integer i = 0
                loop
                    exitwhen (i >= count)
                    if (members[i] == which$NAME$) then
                        return true
                    endif
                    set i = i + 1
                endloop
                return false
            endmethod

            public method clear takes nothing returns nothing
                set count = 0
            endmethod

            public method size takes nothing returns integer
                return count
            endmethod

            public method forEach takes code callback returns nothing
                local integer i = 0
                loop
                    exitwhen (i >= count)
                    set enum$NAME$ = members[i]
                    call ForForce(bj_FORCE_PLAYER[0], callback)
                    set i = i + 1
                endloop
            endmethod

            public method operator[] takes integer index returns $TYPE$
                return members[index]
            endmethod

            public method first takes nothing returns $TYPE$
                if (count == 0) then
                    return $NULLVALUE$
                endif
                return members[0]
            endmethod
        endstruct

        function Is$NAME$In$NAME$Group takes $TYPE$ which$NAME$, $NAME$Group whichGroup returns boolean
            return whichGroup.contains(which$NAME$)
        endfunction

        function Create$NAME$Group takes nothing returns $NAME$Group
            return $NAME$Group.create()
        endfunction

        function Destroy$NAME$Group takes $NAME$Group whichGroup returns nothing
            call whichGroup.destroy()
        endfunction

        function $NAME$GroupAdd$NAME$ takes $NAME$Group whichGroup, $TYPE$ which$NAME$ returns boolean
            return whichGroup.add(which$NAME$)
        endfunction

        function $NAME$GroupRemove$NAME$ takes $NAME$Group whichGroup, $TYPE$ which$NAME$ returns boolean
            return whichGroup.remove(which$NAME$)
        endfunction

        function $NAME$GroupAdd$NAME$GroupFast takes $NAME$Group whichGroup, $NAME$Group addGroup returns integer
            return whichGroup.addGroup(addGroup)
        endfunction

        function $NAME$GroupRemove$NAME$GroupFast takes $NAME$Group whichGroup, $NAME$Group removeGroup returns integer
            return whichGroup.removeGroup(removeGroup)
        endfunction

        function $NAME$GroupClear takes $NAME$Group whichGroup returns nothing
            call whichGroup.clear()
        endfunction

        function Blz$NAME$GroupGetSize takes $NAME$Group whichGroup returns integer
            return whichGroup.size()
        endfunction

        function Blz$NAME$Group$NAME$At takes $NAME$Group whichGroup, integer index returns $TYPE$
            return whichGroup[index]
        endfunction

        function For$NAME$Group takes $NAME$Group whichGroup, code callback returns nothing
            call whichGroup.forEach(callback)
        endfunction

        function FirstOf$NAME$Group takes $NAME$Group whichGroup returns $TYPE$
            return whichGroup.first()
        endfunction
    //! endtextmacro

static if (SUPPORT_ITEM_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Item", "item", "null")

    globals
        private ItemGroup enumItemGroup = 0
        private integer filterItemTypeId = 0
        private player filterOwner = null
        private real filterX = 0.0
        private real filterY = 0.0
        private real filterRadius = 0.0
    endglobals

    private function FilterChangeFilterItem takes nothing returns boolean
        set filterItem = GetFilterItem()
        return true
    endfunction

    private function AddEnumItemToGroup takes nothing returns nothing
        call ItemGroupAddItem(enumItemGroup, GetEnumItem())
    endfunction

    function ItemGroupEnumItemsInRect takes ItemGroup whichGroup, rect r, boolexpr filter returns nothing
        local boolexpr combinedFilters = And(function FilterChangeFilterItem, filter)
        set enumItemGroup = whichGroup
        call EnumItemsInRect(r, combinedFilters, function AddEnumItemToGroup)
        set enumItemGroup = 0
        call DestroyBoolExpr(combinedFilters)
        set combinedFilters = null
    endfunction

    private function FilterItemTypeMatches takes nothing returns boolean
        return GetItemTypeId(GetGroupFilterItem()) == filterItemTypeId
    endfunction

    function ItemGroupEnumItemsOfType takes ItemGroup whichGroup, integer itemTypeId, boolexpr filter returns nothing
        local boolexpr combinedFilters = And(function FilterItemTypeMatches, filter)
        set filterItemTypeId = itemTypeId
        call ItemGroupEnumItemsInRect(whichGroup, GetPlayableMapRect(), combinedFilters)
        call DestroyBoolExpr(combinedFilters)
        set combinedFilters = null
    endfunction

    private function FilterOwnerMatches takes nothing returns boolean
        return GetItemPlayer(GetGroupFilterItem()) == filterOwner
    endfunction

    function ItemGroupEnumItemsOfPlayer takes ItemGroup whichGroup, player whichPlayer, boolexpr filter returns nothing
        local boolexpr combinedFilters = And(function FilterItemTypeMatches, filter)
        set filterOwner = whichPlayer
        call ItemGroupEnumItemsInRect(whichGroup, GetPlayableMapRect(), combinedFilters)
        call DestroyBoolExpr(combinedFilters)
        set combinedFilters = null
    endfunction

    private function DistanceBetweenCoordinates takes real x1, real y1, real x2, real y2 returns real
        local real dx = x2 - x1
        local real dy = y2 - y1
        return SquareRoot(dx * dx + dy * dy)
    endfunction

    private function FilterRangeMatches takes nothing returns boolean
        return DistanceBetweenCoordinates(GetItemX(GetGroupFilterItem()), GetItemY(GetGroupFilterItem()), filterX, filterY) <= filterRadius
    endfunction

    function ItemGroupEnumItemsInRange takes ItemGroup whichGroup, real x, real y, real radius, boolexpr filter returns nothing
        local boolexpr combinedFilters = And(function FilterItemTypeMatches, filter)
        set filterX = x
        set filterY = y
        set filterRadius = radius
        call ItemGroupEnumItemsInRect(whichGroup, GetPlayableMapRect(), combinedFilters)
        call DestroyBoolExpr(combinedFilters)
        set combinedFilters = null
    endfunction
endif

static if (SUPPORT_DESTRUCTABLE_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Destructable", "destructable", "null")

    globals
        private DestructableGroup enumDestructableGroup = 0
    endglobals

    private function AddEnumDestructableToGroup takes nothing returns nothing
        call DestructableGroupAddDestructable(enumDestructableGroup, GetEnumDestructable())
    endfunction

    function DestructableGroupEnumDestructablesInRect takes ItemGroup whichGroup, rect r, boolexpr filter returns nothing
        set enumDestructableGroup = whichGroup
        call EnumDestructablesInRect(r, filter, function AddEnumDestructableToGroup)
        set enumDestructableGroup = 0
    endfunction
endif

static if (SUPPORT_FOGMODIFIER_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("FogModifier", "fogmodifier", "null")
endif

static if (SUPPORT_TEXTTAG_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("TextTag", "texttag", "null")
endif

static if (SUPPORT_WEATHEREFFECT_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("WeatherEffect", "weathereffect", "null")
endif

static if (SUPPORT_WEATHEREFFECT_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("TerrainDeformation", "terraindeformation", "null")
endif

static if (SUPPORT_EFFECT_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Effect", "effect", "null")
endif

static if (SUPPORT_LIGHTNING_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Lightning", "lightning", "null")
endif

static if (SUPPORT_IMAGE_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Image", "image", "null")
endif

static if (SUPPORT_UBERSPLAT_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Ubersplat", "ubersplat", "null")
endif

static if (SUPPORT_INTEGER_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Integer", "integer", "0")
endif

static if (SUPPORT_STRING_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("String", "string", "null")
endif

static if (SUPPORT_STRING_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Handle", "handle", "null")
endif

static if (SUPPORT_WIDGET_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Widget", "widget", "null")
endif

static if (SUPPORT_TRIGGER_GROUPS) then
    //! runtextmacro HANDLE_GROUP_SYSTEM("Trigger", "trigger", "null")
endif

endlibrary

// Baradé's Item Crafting System 1.0
//
// Allows crafting items by using the items in the unit inventory.
// The required items can change add an item to the inventory to be sold as crafting button.
//
library ItemCraftingSystem initializer Init

function interface ItemCraftingSystemRequirementCallback takes integer recipe, unit craftingUnit returns integer

globals
    public constant integer MAX_REQUIREMENTS = 15
    public constant boolean ENABLE_PAGING = true
    public constant integer MAX_RECIPES_PER_PAGE = 9
    public constant integer NEXT_RECIPES_ABILITY_ID = 'A0MD'
    public constant integer PREVIOUS_RECIPES_ABILITY_ID = 'A0ME'

    private integer array recipesItemTypeIds
    private integer array recipesUIItemTypeIds
    private boolean array recipesHideUIItemOnNotAvailable
    private integer array recipesMinRequirements
    private integer array recipesRequirementCounters
    private integer array recipesRequirementItemTypeIds
    private integer array recipesRequirementCharges
    private integer recipesCounter = 0

    // callbacks
    private ItemCraftingSystemRequirementCallback recipeRequirementCallback = 0
    private trigger recipeRequirementCallbackTrigger = null
    private trigger array craftingCallbackTriggers
    private integer craftingCallbackTriggersCounter = 0

    private integer triggerRecipe = 0
    private unit triggerCraftingUnit = null
    private item triggerCraftedItem = null

    private group itemCraftingUnits = CreateGroup()
    private trigger itemCheckTrigger = CreateTrigger()
    private trigger itemCraftTrigger = CreateTrigger()

    private hashtable itemCraftingUnitsHashTable = InitHashtable()
    private trigger itemCraftingNextRecipesTrigger = CreateTrigger()
    private trigger itemCraftingPreviousRecipesTrigger = CreateTrigger()
    private timer itemCraftingStockUpdateTimer = CreateTimer()

    private constant integer HASHTABLE_KEY_PAGE = 0
    //private constant integer HASHTABLE_KEY_GROUP = 1 // for linking multiple crafting units
    //private constant integer HASHTABLE_KEY_DISABLED_RECIPES = 2 // disable recipes per unit
endglobals

private function Index2D takes integer Value1, integer Value2, integer MaxValue2 returns integer
    return ((Value1 * MaxValue2) + Value2)
endfunction

function AddRecipe takes integer itemTypeId, integer uiItemTypeId returns integer
    local integer index = recipesCounter
    set recipesItemTypeIds[index] = itemTypeId
    set recipesUIItemTypeIds[index] = uiItemTypeId
    set recipesHideUIItemOnNotAvailable[index] = false
    set recipesMinRequirements[index] = 0
    set recipesRequirementCounters[index] = 0
    set recipesCounter = recipesCounter + 1
    return index
endfunction

function AddRecipeRequirementItem takes integer recipe, integer itemTypeId, integer charges returns integer
    local integer counter = recipesRequirementCounters[recipe]
    local integer index = Index2D(recipe, counter, MAX_REQUIREMENTS)
    set recipesRequirementItemTypeIds[index] = itemTypeId
    set recipesRequirementCharges[index] = charges
    set recipesRequirementCounters[recipe] = counter + 1
    set recipesMinRequirements[recipe] = counter + 1
    return counter
endfunction

function SetRecipeHideUIItemOnNotAvailable takes integer recipe, boolean hide returns nothing
    set recipesHideUIItemOnNotAvailable[recipe] = hide
endfunction

function SetRecipeMinRequirements takes integer recipe, integer minRequirements returns nothing
    set recipesMinRequirements[recipe] = minRequirements
endfunction

function SetRecipeRequirementCallback takes ItemCraftingSystemRequirementCallback callback returns nothing
    set recipeRequirementCallback = callback
endfunction

function SetRecipeRequirementCallbackTrigger takes trigger callback returns nothing
    set recipeRequirementCallbackTrigger = callback
endfunction

function TriggerRegisterItemCraftingEvent takes trigger whichTrigger returns integer
    local integer counter = craftingCallbackTriggersCounter
    set craftingCallbackTriggers[counter] = whichTrigger
    set craftingCallbackTriggersCounter = craftingCallbackTriggersCounter + 1
    return counter
endfunction

function GetTriggerRecipe takes nothing returns integer
    return triggerRecipe
endfunction

function GetTriggerCraftingUnit takes nothing returns unit
    return triggerCraftingUnit
endfunction

function GetTriggerCraftedItem takes nothing returns item
    return triggerCraftedItem
endfunction

private function ExecuteCraftingCallbacks takes integer recipe, unit craftingUnit, item craftedItem returns nothing
    local integer i = 0
    set triggerRecipe = recipe
    set triggerCraftingUnit = craftingUnit
    set triggerCraftedItem = craftedItem
    loop
        exitwhen (i == craftingCallbackTriggersCounter)
        call ConditionalTriggerExecute(craftingCallbackTriggers[i])
        set i = i + 1
    endloop
endfunction

function CheckRecipeRequirement takes integer recipe, integer requirement, unit whichUnit returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    local integer requiredItemTypeId = recipesRequirementItemTypeIds[index]
    local integer matchingCharges = 0
    local item slotItem = null
    local integer i = 0
    if (requiredItemTypeId != 0) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(whichUnit, i)
            if (slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId) then
                set matchingCharges = matchingCharges + IMaxBJ(GetItemCharges(slotItem), 1)
            endif
            set i = i + 1
        endloop
        return matchingCharges / recipesRequirementCharges[index]
    endif

    return 0
endfunction

function ConsumeRecipeRequirement takes integer recipe, integer requirement, integer charges, unit whichUnit returns integer
    local integer index = Index2D(recipe, requirement, MAX_REQUIREMENTS)
    local integer requiredItemTypeId = recipesRequirementItemTypeIds[index]
    local integer matchingCharges = 0
    local integer reducedCharges = 0
    local item slotItem = null
    local integer i = 0
    if (requiredItemTypeId != 0) then
        loop
            exitwhen (i == bj_MAX_INVENTORY)
            set slotItem = UnitItemInSlot(whichUnit, i)
            if (slotItem != null and GetItemTypeId(slotItem) == requiredItemTypeId) then
                set reducedCharges = charges * recipesRequirementCharges[index]
                set matchingCharges = matchingCharges + reducedCharges
                //call BJDebugMsg("Consuming " + I2S(reducedCharges) + " of item " + GetItemName(slotItem) + " from unit " + GetUnitName(whichUnit) + ".")
                set reducedCharges = GetItemCharges(slotItem) - reducedCharges
                if (reducedCharges > 0) then
                    call SetItemCharges(slotItem, reducedCharges)
                else
                    call UnitRemoveItemFromSlot(whichUnit, i)
                endif
            endif
            set i = i + 1
        endloop
    endif

    return reducedCharges
endfunction

function CheckRecipeRequirements takes integer recipe, unit whichUnit returns integer
    local integer requirementCheckCounter = 0
    local integer result = 0
    local boolean resultInitialized = false
    local integer matchingRequirements = 0
    local integer minRequirements = recipesMinRequirements[recipe]
    local integer counter = recipesRequirementCounters[recipe]
    local integer i = 0

    if (recipeRequirementCallback != 0) then
        set result = recipeRequirementCallback.evaluate(recipe, whichUnit)

        if (result <= 0) then
            return result
        else
            set result = 0
        endif
    endif

    if (recipeRequirementCallbackTrigger != null) then
        set triggerRecipe = recipe
        set triggerCraftingUnit = whichUnit
        set triggerCraftedItem = null
        if (not TriggerEvaluate(recipeRequirementCallbackTrigger)) then
            return -1
        endif
    endif

    loop
        exitwhen (i == counter or matchingRequirements >= minRequirements)
        set requirementCheckCounter = CheckRecipeRequirement(recipe, i, whichUnit)
        if (not resultInitialized) then
            set result = requirementCheckCounter
            set resultInitialized = true
        else
            set result = IMinBJ(result, requirementCheckCounter)
        endif
        if (requirementCheckCounter > 0) then
            set matchingRequirements = matchingRequirements + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ConsumeRecipeRequirements takes integer recipe, integer charges, unit whichUnit returns integer
    local integer result = 0
    local integer counter = recipesRequirementCounters[recipe]
    local integer matchingRequirements = 0
    local integer minRequirements = recipesMinRequirements[recipe]
    local integer consumedRequirements = 0
    local integer i = 0
    loop
        exitwhen (i == counter or matchingRequirements >= minRequirements)
        set consumedRequirements = ConsumeRecipeRequirement(recipe, i, charges, whichUnit)
        set result = result + consumedRequirements
        if (consumedRequirements > 0) then
            set matchingRequirements = matchingRequirements + 1
        endif
        set i = i + 1
    endloop
    return result
endfunction

function CheckAllRecipesRequirements takes unit whichUnit returns integer
    local integer result = 0
    local integer counter = recipesCounter
    local integer requirementCheckCounter = 0
    local integer i = 0
    //call BJDebugMsg("Checking " + I2S(counter) + " recipes.")
    loop
        exitwhen (i == counter)
        set requirementCheckCounter = CheckRecipeRequirements(i, whichUnit)
        //call BJDebugMsg("Get requirement counter " + I2S(requirementCheckCounter))
        if (requirementCheckCounter > 0) then
            set result = result + 1
            if (recipesUIItemTypeIds[i] != 0) then
                //call BJDebugMsg("Adding UI item type " + GetObjectName(recipesUIItemTypeIds[i]) + " to unit " + GetUnitName(whichUnit))
                call RemoveItemFromStock(whichUnit, recipesUIItemTypeIds[i])
                call AddItemToStock(whichUnit, recipesUIItemTypeIds[i], requirementCheckCounter, requirementCheckCounter)
            endif
        else
            if (recipesUIItemTypeIds[i] != 0) then
                //call BJDebugMsg("Removing UI item type " + GetObjectName(recipesUIItemTypeIds[i]) + " from unit " + GetUnitName(whichUnit))
                call RemoveItemFromStock(whichUnit, recipesUIItemTypeIds[i])
                if (not recipesHideUIItemOnNotAvailable[i]) then
                    call AddItemToStock(whichUnit, recipesUIItemTypeIds[i], 0, 1)
                endif
            endif
        endif
        set i = i + 1
    endloop
    return result
endfunction

function ClearAllRecipesForPage takes unit whichUnit, integer page, integer recipesPerPage returns integer
    local integer result = 0
    local integer counter = recipesCounter
    local integer requirementCheckCounter = 0
    local integer recipe = page * recipesPerPage
    local integer i = 0
    //call BJDebugMsg("Checking " + I2S(counter) + " recipes.")
    loop
        exitwhen (i == recipesPerPage and recipe >= counter)
        if (recipesUIItemTypeIds[recipe] != 0) then
            //call BJDebugMsg("Removing UI item type " + GetObjectName(recipesUIItemTypeIds[i]) + " from unit " + GetUnitName(whichUnit))
            call RemoveItemFromStock(whichUnit, recipesUIItemTypeIds[recipe])
        endif
        set i = i + 1
        set recipe = recipe + 1
    endloop
    return result
endfunction

function CheckAllRecipesRequirementsForPage takes unit whichUnit, integer page, integer recipesPerPage returns integer
    local integer result = 0
    local integer counter = recipesCounter
    local integer requirementCheckCounter = 0
    local integer recipe = page * recipesPerPage
    local integer i = 0
    call ClearAllRecipesForPage(whichUnit, page, recipesPerPage)
    //call BJDebugMsg("Checking " + I2S(counter) + " recipes.")
    loop
        exitwhen (i == recipesPerPage and recipe >= counter)
        set requirementCheckCounter = CheckRecipeRequirements(recipe, whichUnit)
        //call BJDebugMsg("Get requirement counter " + I2S(requirementCheckCounter))
        if (requirementCheckCounter > 0) then
            set result = result + 1
            if (recipesUIItemTypeIds[recipe] != 0) then
                //call BJDebugMsg("Adding UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " to unit " + GetUnitName(whichUnit))
                call RemoveItemFromStock(whichUnit, recipesUIItemTypeIds[recipe])
                call AddItemToStock(whichUnit, recipesUIItemTypeIds[recipe], requirementCheckCounter, requirementCheckCounter)
            endif
        else
            if (recipesUIItemTypeIds[recipe] != 0) then
                //call BJDebugMsg("Removing UI item type " + GetObjectName(recipesUIItemTypeIds[recipe]) + " from unit " + GetUnitName(whichUnit))
                call RemoveItemFromStock(whichUnit, recipesUIItemTypeIds[recipe])
                call AddItemToStock(whichUnit, recipesUIItemTypeIds[recipe], 0, 1)
            endif
        endif
        set i = i + 1
        set recipe = recipe + 1
    endloop
    return result
endfunction

function GetMaxRecipesPages takes integer recipesPerPage returns integer
    local integer result = recipesCounter / recipesPerPage
    local integer modulo = ModuloInteger(recipesCounter, recipesPerPage)

    if (modulo > 0) then
        return result + 1
    endif

    return result
endfunction

static if (ENABLE_PAGING) then
private function ClearItemCraftingUnit takes unit whichUnit returns nothing
    call FlushChildHashtable(itemCraftingUnitsHashTable, GetHandleId(whichUnit))
endfunction

private function SetItemCraftingUnitPage takes unit whichUnit, integer page returns nothing
    call SaveInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_PAGE, page)
endfunction

private function GetItemCraftingUnitPage takes unit whichUnit returns integer
    return LoadInteger(itemCraftingUnitsHashTable, GetHandleId(whichUnit), HASHTABLE_KEY_PAGE)
endfunction
endif

function CraftItem takes item soldItem, unit sellingUnit, unit buyingUnit returns item
static if (ENABLE_PAGING) then
    local integer page = GetItemCraftingUnitPage(sellingUnit)
endif
    local integer soldItemTypeId = GetItemTypeId(soldItem)
    local integer charges = 0
    local item craftedItem = null
    local integer counter = recipesCounter
    local integer i = 0
    loop
        exitwhen (i == counter and craftedItem != null)
        if (recipesUIItemTypeIds[i] != 0 and recipesUIItemTypeIds[i] == soldItemTypeId) then
            set charges = CheckRecipeRequirements(i, GetSellingUnit())
            if (charges > 0) then
                // TODO Check if the item type is stackable or create n items.
                set craftedItem = CreateItem(recipesItemTypeIds[i], GetUnitX(buyingUnit), GetUnitY(buyingUnit))
                call SetItemCharges(craftedItem, charges)
                //call BJDebugMsg("Crafted item " + GetItemName(craftedItem) + " with " + I2S(charges))
                call RemoveItem(soldItem)
                set soldItem = null
                call ExecuteCraftingCallbacks(i, buyingUnit, craftedItem)
                // add item after callbacks since it might lead to stacking and the crafted item may become null
                call UnitAddItem(buyingUnit, craftedItem)
                call ConsumeRecipeRequirements(i, charges, sellingUnit)
            endif
        endif
        set i = i + 1
    endloop
static if (ENABLE_PAGING) then
    call CheckAllRecipesRequirementsForPage(sellingUnit, page, MAX_RECIPES_PER_PAGE)
else
    call CheckAllRecipesRequirements(sellingUnit)
endif
    return craftedItem
endfunction

private function ForGroupUpdateStocks takes nothing returns nothing
static if (ENABLE_PAGING) then
    local integer page = GetItemCraftingUnitPage(GetEnumUnit())
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
    call CheckAllRecipesRequirementsForPage(GetEnumUnit(), page, MAX_RECIPES_PER_PAGE)
else
    call CheckAllRecipesRequirements(GetEnumUnit())
endif
endfunction

private function TimerFunctionUpdateItemCraftingStocks takes nothing returns nothing
    call ForGroup(itemCraftingUnits, function ForGroupUpdateStocks)
endfunction

function EnableItemCraftingUnit takes unit whichUnit returns nothing
static if (ENABLE_PAGING) then
    local integer page = GetItemCraftingUnitPage(whichUnit)
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
endif
    call GroupAddUnit(itemCraftingUnits, whichUnit)
static if (ENABLE_PAGING) then
    call CheckAllRecipesRequirementsForPage(whichUnit, page, MAX_RECIPES_PER_PAGE)
else
    call CheckAllRecipesRequirements(whichUnit)
endif

    if (BlzGroupGetSize(itemCraftingUnits) == 1) then
        // This timer is required since we can only set the maximum time to 3600 seconds.
        call TimerStart(itemCraftingStockUpdateTimer, 15.0, true, function TimerFunctionUpdateItemCraftingStocks)
    endif
endfunction

function DisableItemCraftingUnit takes unit whichUnit returns nothing
static if (ENABLE_PAGING) then
    local integer page = GetItemCraftingUnitPage(whichUnit)
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
endif
    call GroupRemoveUnit(itemCraftingUnits, whichUnit)
static if (ENABLE_PAGING) then
    call ClearAllRecipesForPage(whichUnit, page, MAX_RECIPES_PER_PAGE)
    call ClearItemCraftingUnit(whichUnit)
endif

    if (BlzGroupGetSize(itemCraftingUnits) == 0) then
        call PauseTimer(itemCraftingStockUpdateTimer)
    endif
endfunction

function IsItemCraftingUnitEnabled takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, itemCraftingUnits)
endfunction

private function TriggerConditionIsItemCraftingUnitEnabled takes nothing returns boolean
    return IsItemCraftingUnitEnabled(GetTriggerUnit())
endfunction

private function TriggerActionCheckAllRecipesRequirements takes nothing returns nothing
    //call BJDebugMsg("Crafter " + GetUnitName(GetTriggerUnit()) + " picks up or drops an item.")
static if (ENABLE_PAGING) then
    local integer page = GetItemCraftingUnitPage(GetTriggerUnit())
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
    call CheckAllRecipesRequirementsForPage(GetTriggerUnit(), page, MAX_RECIPES_PER_PAGE)
else
    call CheckAllRecipesRequirements(GetTriggerUnit())
endif
endfunction

private function TriggerActionCraftItem takes nothing returns nothing
    call CraftItem(GetSoldItem(), GetSellingUnit(), GetBuyingUnit())
endfunction

static if (ENABLE_PAGING) then
private function TriggerConditionNextRecipes takes nothing returns boolean
    return GetSpellAbilityId() == NEXT_RECIPES_ABILITY_ID and IsItemCraftingUnitEnabled(GetTriggerUnit())
endfunction

private function DisplayRecipesPage takes player whichPlayer, integer page, integer maxPages returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Changed to recipes page " + I2S(page + 1) + "/" + I2S(maxPages) + ".")
endfunction

private function TriggerActionNextRecipes takes nothing returns nothing
    local integer page = GetItemCraftingUnitPage(GetTriggerUnit())
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
    call ClearAllRecipesForPage(GetTriggerUnit(), page, MAX_RECIPES_PER_PAGE)
    set page = page + 1
    if (page >= maxPages) then
        set page = 0
    endif
    call SetItemCraftingUnitPage(GetTriggerUnit(), page)
    call CheckAllRecipesRequirementsForPage(GetTriggerUnit(), page, MAX_RECIPES_PER_PAGE)
    call DisplayRecipesPage(GetOwningPlayer(GetTriggerUnit()), page, maxPages)
endfunction

private function TriggerConditionPreviousRecipes takes nothing returns boolean
    return GetSpellAbilityId() == PREVIOUS_RECIPES_ABILITY_ID and IsItemCraftingUnitEnabled(GetTriggerUnit())
endfunction

private function TriggerActionPreviousRecipes takes nothing returns nothing
    local integer page = GetItemCraftingUnitPage(GetTriggerUnit())
    local integer maxPages = GetMaxRecipesPages(MAX_RECIPES_PER_PAGE)
    call ClearAllRecipesForPage(GetTriggerUnit(), page, MAX_RECIPES_PER_PAGE)
    set page = page - 1
    if (page < 0) then
        set page = maxPages - 1
    endif
    call SetItemCraftingUnitPage(GetTriggerUnit(), page)
    call CheckAllRecipesRequirementsForPage(GetTriggerUnit(), page, MAX_RECIPES_PER_PAGE)
    call DisplayRecipesPage(GetOwningPlayer(GetTriggerUnit()), page, maxPages)
endfunction
endif

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(itemCheckTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerRegisterAnyUnitEventBJ(itemCheckTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(itemCheckTrigger, Condition(function TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(itemCheckTrigger, function TriggerActionCheckAllRecipesRequirements)

    call TriggerRegisterAnyUnitEventBJ(itemCraftTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(itemCraftTrigger, Condition(function TriggerConditionIsItemCraftingUnitEnabled))
    call TriggerAddAction(itemCraftTrigger, function TriggerActionCraftItem)

static if (ENABLE_PAGING) then
    call TriggerRegisterAnyUnitEventBJ(itemCraftingNextRecipesTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(itemCraftingNextRecipesTrigger, Condition(function TriggerConditionNextRecipes))
    call TriggerAddAction(itemCraftingNextRecipesTrigger, function TriggerActionNextRecipes)

    call TriggerRegisterAnyUnitEventBJ(itemCraftingPreviousRecipesTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(itemCraftingPreviousRecipesTrigger, Condition(function TriggerConditionPreviousRecipes))
    call TriggerAddAction(itemCraftingPreviousRecipesTrigger, function TriggerActionPreviousRecipes)
endif
endfunction

endlibrary

function AddRecipeWoWReforged takes nothing returns integer
    set udg_TmpInteger = AddRecipe(udg_TmpItemTypeId, udg_TmpItemTypeId2)
    call SetRecipeHideUIItemOnNotAvailable(udg_TmpInteger, true)
    set udg_TmpInteger2 = 1
    return udg_TmpInteger
endfunction

function AddRecipeRequirementWoWReforged takes nothing returns integer
    local integer requirement = AddRecipeRequirementItem(udg_TmpInteger, udg_TmpItemTypeId, udg_TmpInteger2)
    set udg_TmpInteger2 = 1
    return requirement
endfunction

function SetRecipeMinRequirementsWoWReforged takes nothing returns nothing
    call SetRecipeMinRequirements(udg_TmpInteger, udg_TmpInteger2)
endfunction

function ShowPlayers takes player to returns nothing
    local player listedPlayer = null
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set listedPlayer = Player(i)
        if (GetPlayerSlotState(listedPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call DisplayTextToPlayer(to, 0, 0, GetPlayerColorString(listedPlayer, GetPlayerName(listedPlayer)) + ": " + I2S(i + 1) + " - " + GetPlayerColorName(listedPlayer) + " - Team " + I2S(GetPlayerTeam(listedPlayer) + 1))
        endif
        set listedPlayer = null
        set i = i + 1
    endloop
endfunction

function GetItemProfession takes integer itemTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i >= udg_Max_Berufe)
        if (udg_ProfessionItemType[i] == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return udg_ProfessionNone
endfunction

// TODO Make this function faster by caching item type races and professions!
function CanItemTypeIdBePickedUp takes integer itemTypeId, player whichPlayer returns boolean
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    local integer itemRace = udg_RaceNone
    local integer itemProfession = udg_ProfessionNone
    if (udg_PlayerUnlockedAllRaces[playerId]) then
        return true
    endif
    set itemRace = GetItemRace(itemTypeId)
    set itemProfession = GetItemProfession(itemTypeId)
    return (itemRace == udg_RaceNone or itemRace == udg_PlayerRace[playerId] or itemRace == udg_PlayerRace2[playerId]) and (itemProfession == udg_ProfessionNone or itemProfession == udg_PlayerProfession[playerId] or itemProfession == udg_PlayerProfession2[playerId])
endfunction

function GetItemTypeIdPickupErrorReason takes integer itemTypeId, player whichPlayer returns string
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    local integer itemRace = udg_RaceNone
    local integer itemProfession = udg_ProfessionNone
    if (not udg_PlayerUnlockedAllRaces[playerId]) then
        set itemRace = GetItemRace(itemTypeId)
        if (itemRace != udg_RaceNone and itemRace != udg_PlayerRace[playerId] and itemRace != udg_PlayerRace2[playerId]) then
            return "Belongs to race " + udg_RaceName[itemRace] + "!"
        endif
        set itemProfession = GetItemProfession(itemTypeId)
        if (itemProfession != udg_ProfessionNone and itemProfession != udg_PlayerProfession[playerId] and itemProfession != udg_PlayerProfession2[playerId]) then
            return "Belongs to profession " + udg_ProfessionName[itemProfession] + "!"
        endif
    endif
    return null
endfunction

function CanItemBePickedUp takes item whichItem, player whichPlayer returns boolean
    local player owner = GetItemPlayer(whichItem)
    local boolean result = (owner == null or owner == Player(PLAYER_NEUTRAL_PASSIVE) or owner == whichPlayer) and CanItemTypeIdBePickedUp(GetItemTypeId(whichItem), whichPlayer)
    set owner = null
    return result
endfunction

function GetItemPickupErrorReason takes item whichItem, player whichPlayer returns string
    local player owner = GetItemPlayer(whichItem)
    local string result = null
    if (owner != null and owner != Player(PLAYER_NEUTRAL_PASSIVE) and owner != whichPlayer) then
        set result = "Owner is " + GetPlayerNameColored(owner) + "!"
    else
        set result = GetItemTypeIdPickupErrorReason(GetItemTypeId(whichItem), whichPlayer)
    endif
    set owner = null
    return result
endfunction

// Add all prestored savecodes into this function
function InitPrestoredSaveCodes takes nothing returns nothing
    // ##############################################################
    // all
    // Hello citizens!
    call AddPrestoredSaveCodeLetter("all", "?bGl~x:RVRY)Gwu::~T?Y)Y%u43oG?WG")
    // ##############################################################
    call AddPrestoredSaveCode("Razuqze#1414", "WNHAHlHmPHWSyHRbHK4UHmHlHlHlHlHlHlHmmHrHvHlHlHlHlHlHlHWjH")
    // ##############################################################
    // Runeblade14#2451
    call AddPrestoredSaveCode("Runeblade14#2451", "nVTxTJTnMTlAsHTgUldTsHl9TRT0TPT4TaTlTST38TxTZTndT2dXTJTJTJTJTnlT")
    call AddPrestoredSaveCode("Runeblade14#2451", "nVTnTJTsuT3wrsTeKNTsR81TsbT0TPT4TaTnTUTxATnTsTxxT2dXTJTJTJTJTCT")
    call AddPrestoredSaveCode("Runeblade14#2451", "nVTxTJTnMTIvjATZLM9TnhCQTCT0TpT4TaT3TeTkTnTJTgXT2dXTJTJTJTJTsJT")
    // ##############################################################
    // WorldEdit
    call AddPrestoredSaveCode("WorldEdit", "zZeReRezjeKpgxRebkeF1eReReReReReIeRe5eIezezeReReReReReIxe")
    call AddPrestoredSaveCode("WorldEdit", "zZezeReIQeD2Z5YeykqneyFudekeReReReReReReReIeReReReReReReRez3e")
    // WorldOfWarcraftReforged-WorldEdit-Singleplayer-Normal-Freelancer-items-4-Green Dragon Whelp Egg,Green Drake Egg,Green Dragon Whelp Egg,Green Drake Egg.txt
    call AddPrestoredSaveCodeItems("WorldEdit", "zZezeReIQeXezewezeXezewezeIRe")
    // WorldOfWarcraftReforged-WorldEdit-Singleplayer-Normal-Warlord-items-5-Orb of Fire,Orb of Fire,Orb of Fire,Orb of Fire,Orb of Fire.txt
    call AddPrestoredSaveCodeItems("WorldEdit", "zZeReRezjezqeRezqeRezqeRezqeRezqeReISe")
    // WorldOfWarcraftReforged-WorldEdit-Singleplayer-Normal-Warlord-buildings-8-Dragonhawk Aviary,Mage Tower,Mage Tower,High Elven Guard Tower,High Elf Stables,Enchanter Tower,Bazaar,High Elf Barracks.txt
    call AddPrestoredSaveCodeBuildings("WorldEdit", "zZeReRezjezreI6ye8wTezleI0re8jBezleIgPeYFpezAeIxme8XyezHeIxme8N9ezLeI1se8SXezmeIiwe8Z8ez4eIOTe8jBezke")
    // WorldOfWarcraftReforged-WorldEdit-Singleplayer-Normal-Warlord-units-10-8Arch Cleric,3Archer,2Ranger,4Captain,2Swordsman,2War Eagle,3Dragonhawk,2Dragonhawk Rider,1Birdiepult,2High Elf Knight
    call AddPrestoredSaveCodeBuildings("WorldEdit", "zZeReRezjezreQez7eDez4eIezHekezLeIezmeIezWeDezPeIezlezezKeIeI7e")
    // ##############################################################
    // Barade#2569
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Freelancer-level1-1000-level2-1000-level3-1000-gold-800000-lumber-800000.txt
    call AddPrestoredSaveCode("Barade#2569", "06sgsns0fsgureEsgvJCsgvJCs2HsxNsxNsxNsxNs0ZZsnsb4Osnsb4OsxcTsgureEsgureEsxNsxNs0sgszs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-level1-1000-level2-1000-level3-1000-gold-800000-lumber-800000.txt
    call AddPrestoredSaveCode("Barade#2569", "06s0snsxNsgureEsgvJCsgvJCs2HsxNsxNsxNsxNs0ZZsnsb4Osnsb4OsxcTsgureEsgureEsxNsxNs0sgsxQs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-level1-1000-level2-1000-level3-1000-gold-800000-lumber-800000.txt
    call AddPrestoredSaveCode("Barade#2569", "06s0snsxNsgureEsgvJCsgvJCs2HsxNsxNsxNsxNs0ZZsnsb4Osnsb4OsxcTsgureEsgureEsxNsxNs0sgsxQs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-level1-13-level2-1-level3-1-gold-8897-lumber-95445.txt
    call AddPrestoredSaveCode("Barade#2569", "06s0snsxNs0mFs0L6slNRsnsnsnsnsnsasxsgCs0sxsxsnsnsnsnsnsnsxcs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-items-6-Gloves of Haste,Potion of Invulnerability,Scroll of Restoration,Ankh of Reincarnation,Healing Wards,Health Stone.txt
    call AddPrestoredSaveCodeItems("Barade#2569", "06s0snsxNsTsxNsgsxNs7sxNsLsxNsxusxNs0sxNsxns")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-items-4-Bow of Fire,Bow of Fire,Bow of Fire,Mithril Long Sword.txt
    call AddPrestoredSaveCodeItems("Barade#2569", "06s0snsxNsZsnsZsnsZsnsEsnsts")
    // WorldOfWarcraftReforged-Barade#2569-Singleplayer-Normal-Freelancer-items-6-Gloves of Haste,Potion of Invulnerability,Scroll of Restoration,Ankh of Reincarnation,Healing Wards,Health Stone.txt
    call AddPrestoredSaveCodeItems("Barade#2569", "06sxsnsxNsTsxNsgsxNs7sxNsLsxNsxusxNs0sxNsUs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-buildings-8-Outpost,Outpost,Outpost,Outpost,Dragonhawk Aviary,Dragonhawk Aviary,Mage Tower,Mage Tower.txt
    call AddPrestoredSaveCodeBuildings("Barade#2569", "06s0snsxNsx8sfRYs3LPsx8sfRYs3AVsx8sfwAs3o0sx8sfzqs3nAsxYsfeVs3bIsxYsfa1s31gsxCsfc6s3HUsxCsflgs30osEs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-units-6-10Clan Emissary,2Blue Drake,1Black Dragon,1Blood Elf Lieutenant,3High Elf Knight,1Archer.txt
    call AddPrestoredSaveCodeUnits("Barade#2569", "06s0snsxNsbasEsxys0s0asxstsxsxYsgsxIsxsnsnsnsnsnsnsnsns0bs")
    // WorldOfWarcraftReforged-Barade#2569-Multiplayer-Normal-Warlord-units-6-30Red Dragon,30Green Dragon,30Black Dragon,30Blue Dragon,30Bronze Dragon,30Nether Dragon
    call AddPrestoredSaveCodeUnits("Barade#2569", "06s0snsxNs0EsrsxTsrs0asrs01srs0xsrs03srsnsnsnsnsnsnsnsnsxs")
    // ##############################################################
    // AntiDenseMan#1202
    // WorldOfWarcraftReforged-AntiDenseMan#1202-Multiplayer-Normal-Warlord-level1-4-level2-0-level3-0-gold-37077-lumber-27049
    call AddPrestoredSaveCode("AntiDenseMan#1202", "NgueuSuNButduFoWukq0uSuSuSuSuSuSuNu4uzuSuSuSuSuSuSuSu3u")
    // WorldOfWarcraftReforged-AntiDenseMan#1202-Multiplayer-Normal-Warlord-units-3-1Heavy Tank,4Assault Tank,3Goblin War Zeppelin
    call AddPrestoredSaveCodeUnits("AntiDenseMan#1202", "NgueuSuNBuNZuNuNbuzuNjuRuSuSuSuSuSuSuSuSuSuSuSuSuSuSuku")
    // WorldOfWarcraftReforged-AntiDenseMan#1202-Multiplayer-Normal-Warlord-items-6-Bow of Fire,Bow of Fire,Bow of Fire,Bow of Fire,Bow of Fire,Bow of Fire.txt
    call AddPrestoredSaveCodeItems("AntiDenseMan#1202", "NgueuSuNBuFuSuFuSuFuSuFuSuFuSuFuSuedu")
    // ##############################################################
    // MeowPeow#21783
    // WorldOfWarcraftReforged-MeowPeow#21783-Multiplayer-Normal-Warlord-level1-7-level2-1-level3-1-gold-13570-lumber-17369.txt
    call AddPrestoredSaveCode("MeowPeow#21783", "Wj7j5jcijbRj4iFjLT0j5j5j5j5j5jcjcjcRjvj5j5j5j5j5j5j5j5jEj")
    // WorldOfWarcraftReforged-MeowPeow#21783-Multiplayer-Normal-Warlord-buildings-8-Slaughterhouse,Slaughterhouse,Graveyard,Graveyard,Temple of the Damned,Temple of the Damned,Spirit Tower,Spirit Tower.txt
    call AddPrestoredSaveCodeBuildings("MeowPeow#21783", "Wj7j5jcijqjWB3jm1YjqjWfkjm1YjOjmASjAoFjOjmLLjAAKjdjWfkjA7EjdjWB3jA7EjJjWztjmbTjJjWNVjmagjczj")
    // ##############################################################
    // StiX#1311
    // WorldOfWarcraftReforged-StiX#1311-Multiplayer-Normal-Freelancer-level1-10-level2-1-level3-1-gold-1144-lumber-0.txt
    call AddPrestoredSaveCode("StiX#1311", "bTgag3gMwgbPUg48g3g3g3g3g3g3g3gbgMLgag3g3g3g3g3g3g3g3g2g")
    // WorldOfWarcraftReforged-StiX#1311-Multiplayer-Normal-Freelancer-items-3-Khadgar's Pipe of Insight,Scourge Bone Chimes,Ancient Janggo of Endurance.txt
    call AddPrestoredSaveCodeItems("StiX#1311", "bTgag3gMwg8g3gOg3gQg3gbEg")
    // ##############################################################
    // Rhum#11986
    // WorldOfWarcraftReforged-Rhum#11986-Multiplayer-Normal-Warlord-level1-9-level2-1-level3-1-gold-19998-lumber-18444.txt
    call AddPrestoredSaveCode("Rhum#11986", "4252h2jy2jKm24NM271N2h2h2h2h2h2j252jj2c2h2h2h2h2h2h2h2h2jH2")
    // ##############################################################
    // BobElDonuts#2355
    // WorldOfWarcraftReforged-BobElDonuts#2355-Multiplayer-Normal-Freelancer-level1-14-level2-1-level3-1-gold-2403-lumber-0.txt
    call AddPrestoredSaveCode("BobElDonuts#2355", "qxbx0x3Ex3TPxRWx0x0x0x0x0x0x0x0x3ZxMx0x0x0x0x0x0x0x0xQx")
    // ##############################################################
    // Cryingbandi#2663
    // WorldOfWarcraftReforged-Cryingbandi#2663-Multiplayer-Normal-Warlord-level1-20-level2-1-level3-1-gold-26279-lumber-3791.txt
    call AddPrestoredSaveCode("Cryingbandi#2663", "8HF8FVFQlFqQtFdYpFQQtFOFQFVFVFVF8F6FYaF6F6FQFVFVFYFqFVFVF9F")
    // ##############################################################
    // Dragon#18628
    // WorldOfWarcraftReforged-Dragon#18628-Multiplayer-Normal-Warlord-level1-9-level2-0-level3-0-gold-10783-lumber-9960.txt
    call AddPrestoredSaveCode("Dragon#18628", "VJxJsJnSJn7PJxOCJxe2JsJnJsJsJsJsJ0JgTJgJsJsJsJsJsJsJxCJ")
    // ##############################################################
    // Racnel#1228
    // WorldOfWarcraftReforged-Racnel#1228-Multiplayer-Normal-Warlord-level1-9-level2-1-level3-1-gold-17506-lumber-10826.txt
    call AddPrestoredSaveCode("Racnel#1228", "bi0b0g03z03ht0akx0biG0g0g0g0g0g0f0a0aj0f0f0a0g0g0g0g0g0g0bS0")
    // ##############################################################
    // CLANS
    // MULTIPLAYER
    // TheElvenClan
    // WorldOfWarcraftReforged-Clan-TheElvenClan-WorldEdit-Multiplayer-gold-10000-lumber-10000-WorldEdit_Leader, WorldEdit_Leader, Barade_Leader, Runeblade14#2451_Captain, AntiDenseMan#1202_Captain.txt
    call AddPrestoredSaveCodeClan("TheElvenClan", false, ">c!cMc>c>uKc>uKcucuc>;cMc>;cMc>icMc@c>c>Ec>cMcMcMcMc>cic")
    call AddPrestoredSaveCodeClanPlayer("Barade#2569", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("WorldEdit", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Barade", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Runeblade14#2451", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("AntiDenseMan#1202", udg_ClanRankCaptain)
    // SINGLEPLAYER
    // TheElvenClan
    // WorldOfWarcraftReforged-Clan-TheElvenClan-WorldEdit-Singleplayer-gold-10000-lumber-10000-WorldEdit_Leader, WorldEdit_Leader, Barade_Leader, Runeblade14#2451_Captain, AntiDenseMan#1202_Captain.txt
    call AddPrestoredSaveCodeClan("TheElvenClan", true, "Mc!cMc>c>uKc>uKcucuc>;cMc>;cMc>icMc@c>c>Ec>cMcMcMcMc>c>*c")
    call AddPrestoredSaveCodeClanPlayer("Barade#2569", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("WorldEdit", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Barade", udg_ClanRankLeader)
    call AddPrestoredSaveCodeClanPlayer("Runeblade14#2451", udg_ClanRankCaptain)
    call AddPrestoredSaveCodeClanPlayer("AntiDenseMan#1202", udg_ClanRankCaptain)
endfunction
