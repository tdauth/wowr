library WoWReforgedBan initializer Init requires ForceUtils, WoWReforgedI18n

globals
    private integer banCount = 0
    private string array bans
    private string array bansReasons
endglobals

function GetBanInfo takes nothing returns string
    local string message = GetLocalizedString("BAN_LIST_HEADER")
    local integer i = 0
    loop
        exitwhen (i == banCount)
        if (i > 0) then
            set message = message + "\n"
        endif
        set message = message + Format(GetLocalizedString("BAN_LIST_ITEM")).s(bans[i]).s(bansReasons[i]).result()
        set i = i + 1
    endloop
    return message
endfunction

function AddBan takes string account, string reason returns integer
    local integer index = banCount
    set bans[index] = account
    set bansReasons[index] = reason
    set banCount = banCount + 1
    return index
endfunction

function GetBan takes integer index returns string
    return bans[index]
endfunction

function GetBanIndex takes string account returns integer
    local integer i = 0
    loop
        exitwhen (i == banCount)
        if (GetBan(i) == account) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function ForGroupCheckBan takes nothing returns nothing
    local player p = GetEnumPlayer()
    local string playerName = GetPlayerName(p)
    local integer index = GetBanIndex(playerName)
    if (index != -1) then
        call CustomDefeatBJ(p, Format(GetLocalizedString("BANNED_REASON")).s(bansReasons[index]).result())
        call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("BANNED_KICKED_REASON")).s(playerName).s(bansReasons[index]).result())
    endif
    set p = null
endfunction

private function Init takes nothing returns nothing
    local force whichForce = CreateForce()
    call ForceAddPlayingUserPlayers(whichForce)
    //call AddBan("WorldEditX", "Spamming and killing allies.")
    
    call ForForce(whichForce, function ForGroupCheckBan)
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
endfunction

endlibrary
