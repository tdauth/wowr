library WoWReforgedAccount initializer Init requires SimError, UnitTypeUtils, WoWReforgedVIPs

globals
    private Account array playerAccount
    
    private Account array accounts
    private integer accountsCounter = 0
    
    private hashtable h = InitHashtable()
    private string array restrictedChatCommands
    private integer restrictedChatCommandsCounter = 0
endglobals

function IsIdRestricted takes integer id returns boolean
    return LoadBoolean(h, id, 0)
endfunction

function IsChatCommandRestricted takes string chatCommand returns boolean
    local integer i = 0
    loop
        exitwhen (i == restrictedChatCommandsCounter)
        if (restrictedChatCommands[i] == chatCommand) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

private function SetChatCommandRestricted takes string chatCommand returns nothing
    local integer i = 0
    loop
        exitwhen (i == restrictedChatCommandsCounter)
        if (restrictedChatCommands[i] == chatCommand) then
            return
        endif
        set i = i + 1
    endloop
    set restrictedChatCommands[restrictedChatCommandsCounter] = chatCommand
    set restrictedChatCommandsCounter = restrictedChatCommandsCounter + 1
endfunction

struct Account
    string name
    string icon
    integer array unlocked[100] // object raw code IDs
    integer unlockedCounter = 0
    string array unlockedChatCommands[100]
    integer unlockedChatCommandsCounter = 0
endstruct

function GetAccount takes integer index returns Account
    return accounts[index]
endfunction

function GetAccountsMax takes nothing returns integer
    return accountsCounter
endfunction

private function AddAccount takes string name, string icon returns Account
    local Account this = Account.create()
    set this.name = name
    set this.icon = icon
    set accounts[accountsCounter] = this
    set accountsCounter = accountsCounter + 1
    return this
endfunction

private function AccountUnlock takes Account a, integer id returns nothing
    call SaveBoolean(h, id, 0, true)
    set a.unlocked[a.unlockedCounter] = id
    set a.unlockedCounter = a.unlockedCounter + 1
endfunction

private function AccountUnlockChatCommand takes Account a, string chatCommand returns nothing
    set a.unlockedChatCommands[a.unlockedChatCommandsCounter] = chatCommand
    set a.unlockedChatCommandsCounter = a.unlockedChatCommandsCounter + 1
endfunction

function GetAccountByName takes string name returns Account
    local integer i = 0
    loop
        exitwhen (i == accountsCounter)
        if (accounts[i].name == name) then
            return accounts[i]
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function AccountHasUnlocked takes Account a, integer id returns boolean
    local integer i = 0
    if (not IsIdRestricted(id)) then
        return true
    endif
    loop
        exitwhen (i == a.unlockedCounter)
        if (a.unlocked[i] == id) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function AccountHasUnlockedChatCommand takes Account a, string chatCommand returns boolean
    local integer i = 0
    if (not IsChatCommandRestricted(chatCommand)) then
        return true
    endif
    loop
        exitwhen (i == a.unlockedChatCommandsCounter)
        if (a.unlockedChatCommands[i] == chatCommand) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function GetPlayerAccountName takes player whichPlayer returns string
    local integer playerId = GetPlayerId(whichPlayer)
    if (playerAccount[playerId] != 0) then
        return playerAccount[playerId].name
    endif
    return "none"
endfunction

function GetAllUnlockedAccountNames takes integer id returns string
    local string result = ""
    local integer i = 0
    local integer counter = 0
    if (IsIdRestricted(id)) then
        loop
            exitwhen (i == accountsCounter)
            if (AccountHasUnlocked(accounts[i], id)) then
                if (counter > 0) then
                    set result = result + ","
                endif
                set result = result + accounts[i].name
                set counter = counter + 1
            endif
            set i = i + 1
        endloop
    endif
    return result
endfunction

function SimErrorLocked takes player whichPlayer, integer id returns nothing
    call SimError(whichPlayer, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(GetActualObjectName(id)).s(GetAllUnlockedAccountNames(id)).result())
endfunction

function GetAllUnlockedAccountNamesChatCommand takes string chatCommand returns string
    local string result = ""
    local integer i = 0
    local integer counter = 0
    if (IsChatCommandRestricted(chatCommand)) then
        loop
            exitwhen (i == accountsCounter)
            if (AccountHasUnlockedChatCommand(accounts[i], chatCommand)) then
                if (counter > 0) then
                    set result = result + ","
                endif
                set result = result + accounts[i].name
                set counter = counter + 1
            endif
            set i = i + 1
        endloop
    endif
    return result
endfunction

function SimErrorLockedChatCommand takes player whichPlayer, string chatCommand returns nothing
    call SimError(whichPlayer, Format(GetLocalizedString("RESTRICTED_TO_ACCOUNTS")).s(chatCommand).s(GetAllUnlockedAccountNamesChatCommand(chatCommand)).result())
endfunction

function UnlockedAccountIds takes Account a returns string
    local string result = ""
    local string name = a.name
    local integer counter = 0
    local integer i = 0
    loop
        exitwhen (i == a.unlockedCounter)
        if (counter > 0) then
            set result = result + ","
        endif
        //if (IsCampaign(a.unlocked[i])) then
        // TODO GetNpcName
        //else
            set result = result + GetActualObjectName(a.unlocked[i])
        //endif
        set counter = counter + 1
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i == a.unlockedChatCommandsCounter)
        if (counter > 0) then
            set result = result + ","
        endif
        set result = result + a.unlockedChatCommands[i]
        set counter = counter + 1
        set i = i + 1
    endloop
    if (counter == 0) then
        set result = "-"
    endif
    return result
endfunction

function ShowUnlockedAccountIds takes player whichPlayer returns nothing
    local string result = "-"
    local integer playerId = GetPlayerId(whichPlayer)
    local Account a = playerAccount[playerId]
    local string name = GetPlayerName(whichPlayer)
    if (a != 0) then
        set name = a.name
        set result = UnlockedAccountIds(a)
    endif
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 4.0, Format(GetLocalizedString("UNLOCKED_X_FOR_Y")).s(name).s(result).result())
endfunction

function PlayerHasUnlocked takes player whichPlayer, integer id returns boolean
    local integer playerId = GetPlayerId(whichPlayer)
    if (not IsIdRestricted(id)) then
        return true
    endif
    if (playerAccount[playerId] != 0) then
        return AccountHasUnlocked(playerAccount[playerId], id)
    endif
    return false
endfunction

function PlayerHasUnlockedChatCommand takes player whichPlayer, string chatCommand returns boolean
    local integer playerId = GetPlayerId(whichPlayer)
    if (not IsChatCommandRestricted(chatCommand)) then
        return true
    endif
    if (playerAccount[playerId] != 0) then
        return AccountHasUnlockedChatCommand(playerAccount[playerId], chatCommand)
    endif
    return false
endfunction

private function UnlockVIP takes Account a returns nothing
    call AccountUnlock(a, AEGWYNN)
    call AccountUnlock(a, TICHONDRIUS_HERO)
    call AccountUnlock(a, LICH_KING)
    call AccountUnlock(a, ARTHAS_WIELDING_FROSTMOURNE)
    call AccountUnlock(a, ARTHAS_UNDEAD)
    call AccountUnlock(a, ILLIDAN) // Evil
    call AccountUnlock(a, DEMON_HUNTER_M)
    call AccountUnlock(a, CENARIUS_HERO)
    call AccountUnlock(a, ARCHIMONDE)
    call AccountUnlock(a, MANNOROTH)
    call AccountUnlock(a, KIL_JAEDEN)
    call AccountUnlock(a, VELEN)
    call AccountUnlock(a, PHOENIX_MOUNT)
    call AccountUnlock(a, SNOWY_OWL_MOUNT)
    call AccountUnlock(a, PHOENIX)
    call AccountUnlock(a, ITEM_HOUSE_KEY)
    call AccountUnlock(a, PROPERTY_WYRMREST_TEMPLE)
    call AccountUnlockChatCommand(a, "-playername")
    call AccountUnlockChatCommand(a, "-cleargenerated")
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    local Account a = 0
    
    set a = AddAccount("Barade#2569", "ReplaceableTextures\\CommandButtons\\BTNPenguin.blp")
    call AccountUnlock(a, BARADE)
    call UnlockVIP(a)
    
    set a = AddAccount("Etos7#2138", "ReplaceableTextures\\CommandButtons\\BTNHeroBloodelffemale.blp")
    call AccountUnlock(a, EYLON)
    call UnlockVIP(a)
    
    // All VIPs
    set i = 0
    loop
        exitwhen (i == GetVIPsMax())
        set a = GetAccountByName(GetVIP(i))
        if (a == 0) then
            set a = AddAccount(GetVIP(i), "")
            call UnlockVIP(a)
        endif
        set i = i + 1
    endloop
    
    // We store the corresponding accounts in the beginning for performance reasons and to allow players to change their names later in game.
    set i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerAccount[i] = GetAccountByName(GetPlayerName(Player(i)))
        set i = i + 1
    endloop
endfunction

endlibrary
