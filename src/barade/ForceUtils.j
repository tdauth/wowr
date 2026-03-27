library ForceUtils initializer Init

function IsPlayerPlayingUser takes player whichPlayer returns boolean
    return GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING
endfunction

function ForceAddForce takes force target, force source returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (IsPlayerInForce(slotPlayer, source)) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

// non leaking function
function ForceAddAlliesWithSharedControl takes force target, player owner returns nothing
    local player slotPlayer = null
    local integer i = 0
    call ForceAddPlayer(target, owner)
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

function GetAlliesWithSharedControl takes player owner returns force
    local force allies = CreateForce()
    call ForceAddAlliesWithSharedControl(allies, owner)
    return allies
endfunction

// non leaking function
function ForceAddComputerPlayers takes force target returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

// non leaking function
function ForceAddPlayingComputerPlayers takes force target returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_COMPUTER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

// non leaking function
function ForceAddUsers takes force target returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) != PLAYER_SLOT_STATE_EMPTY) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

// non leaking function
function ForceAddPlayingUserPlayers takes force target returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (IsPlayerPlayingUser(slotPlayer)) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i >= bj_MAX_PLAYERS)
    endloop
endfunction

// non leaking function
function ForceAddSelectingUsers takes force target, unit whichUnit returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and IsUnitSelected(whichUnit, slotPlayer)) then
            call ForceAddPlayer(target, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
endfunction

globals
   private force allUsers = CreateForce()
    private integer allUsersCounter = 0
    private force allPlayingUsers = CreateForce()
    private integer allPlayingUsersCounter = 0
    private trigger leaveTrigger = CreateTrigger()
endglobals

function GetAllUsers takes nothing returns force
    return allUsers
endfunction

function GetAllUsersCount takes nothing returns integer
    return allUsersCounter
endfunction

function GetAllPlayingUsers takes nothing returns force
    return allPlayingUsers
endfunction

function GetAllPlayingUsersCount takes nothing returns integer
    return allPlayingUsersCounter
endfunction

function TriggerRegisterAnyUserEvent takes trigger whichTrigger, playerevent whichPlayerEvent returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        set slotPlayer = Player(i)
        if (IsPlayerPlayingUser(slotPlayer)) then
            call TriggerRegisterPlayerEvent(whichTrigger, slotPlayer, whichPlayerEvent)
        endif
        set slotPlayer = null
        set i = i + 1
        exitwhen (i == bj_MAX_PLAYERS)
    endloop
endfunction

private function TriggerConditionPlayerLeaves takes nothing returns boolean
    call ForceRemovePlayer(allPlayingUsers, GetTriggerPlayer())
    set allPlayingUsersCounter = allPlayingUsersCounter - 1
    return false
endfunction

private function Init takes nothing returns nothing
    call ForceAddUsers(allUsers)
    set allUsersCounter = CountPlayersInForceBJ(allUsers)
    call ForceAddPlayingUserPlayers(allPlayingUsers)
    set allPlayingUsersCounter = CountPlayersInForceBJ(allPlayingUsers)
    call TriggerRegisterAnyUserEvent(leaveTrigger, EVENT_PLAYER_LEAVE)
    call TriggerAddCondition(leaveTrigger, Condition(function TriggerConditionPlayerLeaves))
endfunction

endlibrary
