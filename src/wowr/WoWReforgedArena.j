library WoWReforgedArena initializer Init requires MathUtils, WoWReforgedSaveCodeObjects

struct ArenaTicket
    integer itemTypeId
    integer rewardItemTypeId
    integer array unitTypeIds[4]
    integer array unitTypeIdsCounts[4]
    integer unitTypeIdsCounter = 0
endstruct

globals
    private ArenaTicket array tickets
    private integer ticketsCounter = 0
endglobals

function GetArenaTicketsMax takes nothing returns integer
    return ticketsCounter
endfunction

function GetArenaTicket takes integer index returns ArenaTicket
    return tickets[index]
endfunction

function GetArenaTicketByTicket takes integer itemTypeId returns ArenaTicket
    local integer i = 0
    local integer max = GetArenaTicketsMax()
    loop
        exitwhen (i == max)
        if (GetArenaTicket(i).itemTypeId == itemTypeId) then
            return GetArenaTicket(i)
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function GetArenaTicketByReward takes integer itemTypeId returns ArenaTicket
    local integer i = 0
    local integer max = GetArenaTicketsMax()
    loop
        exitwhen (i == max)
        if (GetArenaTicket(i).rewardItemTypeId == itemTypeId) then
            return GetArenaTicket(i)
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function GetArenaTicketByOpponent takes integer unitTypeId returns ArenaTicket
    local integer i = 0
    local integer max = GetArenaTicketsMax()
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = GetArenaTicket(i).unitTypeIdsCounter
        loop
            exitwhen (j == max2)
            if (GetArenaTicket(i).unitTypeIds[j] == unitTypeId) then
                return GetArenaTicket(i)
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    return 0
endfunction

function IsArenaReward takes integer itemTypeId returns boolean
    return GetArenaTicketByReward(itemTypeId) != 0
endfunction

function IsArenaOpponent takes integer unitTypeId returns boolean
    return GetArenaTicketByOpponent(unitTypeId) != 0
endfunction

function AddArenaTicket takes integer itemTypeId, integer rewardItemTypeId returns ArenaTicket
    local ArenaTicket this = ArenaTicket.create()
    set this.itemTypeId = itemTypeId
    set this.rewardItemTypeId = rewardItemTypeId
    
    set tickets[ticketsCounter] = this
    set ticketsCounter = ticketsCounter + 1
    
    return this
endfunction

function AddArenaTicketUnitType takes integer unitTypeId, integer count returns nothing
    local ArenaTicket t = tickets[ticketsCounter - 1]
    set t.unitTypeIds[t.unitTypeIdsCounter] = unitTypeId
    set t.unitTypeIdsCounts[t.unitTypeIdsCounter] = count
    set t.unitTypeIdsCounter = t.unitTypeIdsCounter + 1
endfunction

function AddSaveObjectItemTypesFromArena takes nothing returns nothing
    local integer i = 0
    local integer max = GetArenaTicketsMax()
    loop
        exitwhen (i == max)
        if (GetArenaTicket(i).rewardItemTypeId != 0) then
            call AddSaveObjectItemTypeEx(GetArenaTicket(i).rewardItemTypeId)
        endif
        set i = i + 1
    endloop
endfunction

function SpawnArenaEnemies takes ArenaTicket t, rect whichRect, rect targetRect returns nothing
    local real x = 0.0
    local real y = 0.0
    local real targetX = GetRectCenterX(targetRect)
    local real targetY = GetRectCenterY(targetRect)
    local location l = null
    local integer i = 0
    local integer max = t.unitTypeIdsCounter
    local integer j = 0
    local integer max2 = 0
    local unit u = null
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = t.unitTypeIdsCounts[i]
        loop
            exitwhen (j == max2)
            set l = GetRandomLocInRect(whichRect)
            set x = GetLocationX(l)
            set y = GetLocationY(l)
            set u = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), t.unitTypeIds[i], x, y, AngleBetweenCoordinatesDeg(x, y, targetX, targetY))
            call UnitAddSleepPerm(u, false)
            call UnitAddSleep(u, false)
            call IssuePointOrder(u, "patrol", targetX, targetY)
            call RemoveLocation(l)
            set l = null
            set u = null
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

function EnterArena takes unit hero, rect whichRect, rect targetRect, string enterMessage, sound enterSound returns boolean
    local location l = null
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    local boolean found = false
    local item whichItem = null
    local ArenaTicket t = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set whichItem = UnitItemInSlot(hero, i)
        if (whichItem != null) then
            set t = GetArenaTicketByTicket(GetItemTypeId(whichItem))
            if (t != 0) then
                set found = true
                call RemoveItem(whichItem)
                set whichItem = null
                call SpawnArenaEnemies(t, whichRect, targetRect)
            endif
        endif
        set i = i + 1
    endloop
    if (found) then
        call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_WARNING, enterMessage)
        set l = GetRectCenter(targetRect)
        call PanCameraToTimedLocForPlayer(owner, l, 0)
        call RemoveLocation(l)
        set l = null
        set l = GetRectCenter(whichRect)
        call PlaySoundAtPointBJ(enterSound, 100, l, 0)
        call RemoveLocation(l)
        set l = null
    endif
    set owner = null
    return found
endfunction

private function Init takes nothing returns nothing
    call AddArenaTicket(ITEM_TYPE_TICKET_1, ITEM_TYPE_STONE_TOKEN)
    call AddArenaTicketUnitType('nogr', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_2, ITEM_TYPE_TALISMAN_OF_THE_WILD)
    call AddArenaTicketUnitType('nowb', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_3, ITEM_TYPE_ICE_SHARD)
    call AddArenaTicketUnitType('nmgw', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_4, ITEM_TYPE_GLOVES_OF_SPELL_MASTERY)
    call AddArenaTicketUnitType('nbzk', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_5, ITEM_TYPE_SHAMAN_CLAWS)
    call AddArenaTicketUnitType('nogn', 2)
    call AddArenaTicketUnitType('nogo', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_6, ITEM_TYPE_THUNDERLIZARD_DIAMOND)
    call AddArenaTicketUnitType('nehy', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_7, ITEM_TYPE_SHIELD_OF_HONOR)
    call AddArenaTicketUnitType('nwna', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_8, ITEM_TYPE_SERATHIL)
    call AddArenaTicketUnitType('nsqa', 1)
    call AddArenaTicketUnitType('nsqo', 2)
    call AddArenaTicket(ITEM_TYPE_TICKET_9, ITEM_TYPE_STONEMAUL_ARENA_MASTER_BELT)
    call AddArenaTicketUnitType('nogn', 1)
    call AddArenaTicketUnitType('nogo', 2)
    call AddArenaTicketUnitType('n00B', 1)
endfunction

endlibrary
