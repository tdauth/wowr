library Votes initializer Init requires MathUtils, PlayerColorUtils, ForceUtils
/*
 * Baradé's Votes 1.0
 *
 * Supports chat based votes with expiring timers.
 *
 * TODO:
 * - Support dialog based votes.
 * - Support tavern based votes.
 * etc.
*/

globals
    constant real VOTE_SYSTEM_DEFAULT_TIMEOUT = 20.0
    constant integer MAX_CHOICES = 12

    // TODO introduce struct V and store it in a single array.
    private integer VotesCounter = 0
    private string array VoteTitle
    private trigger array VoteYesTrigger
    private string array VoteStartChatCommand
    //private dialog array VoteDialog
    //private trigger array VoteButtonClickTrigger
    private timer array VoteTimer
    private real array VoteTimeout
    private timerdialog array VoteTimerDialog
    private force array VotePlayers
    private boolean array VoteIsRunning
    private integer array VoteDefaultChoice
    private integer array VoteChoices
    private string array VoteChoicesNames
    private string array VoteChoicesChatCommands
    private force array VoteChoicesVotes
    // choices
    //private button array VoteSystemVoteDialogButton
    //private trigger array VoteSystemVoteChoiceCallbackTrigger
    
    private integer callbackVote = 0
    private integer callbackChoice = 0
    private integer callbackVotes = 0
    
    private integer CallbacksCounter = 0
    private trigger array CallbackTriggers

    private trigger chatCommandTrigger = CreateTrigger()
    private trigger leavesTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

private function VoteChoiceIndex takes integer choice, integer vote returns integer
    return Index2D(vote, choice, MAX_CHOICES)
endfunction

function VoteGetTitle takes integer vote returns string
    return VoteTitle[vote]
endfunction

function VoteGetDefaultChoiceChatCommand takes integer vote returns string
    return VoteChoicesChatCommands[VoteDefaultChoice[vote]]
endfunction

private function TimerDialogDisplayForForce takes boolean show, timerdialog whichDialog, force whichForce returns nothing
    if (IsPlayerInForce(GetLocalPlayer(), whichForce)) then
        call TimerDialogDisplay(whichDialog, show)
    endif
endfunction

function GetTriggerVote takes nothing returns integer
    return callbackVote
endfunction

function GetTriggerChoice takes nothing returns integer
    return callbackChoice
endfunction

function GetTriggerVotesCount takes nothing returns integer
    return callbackVotes
endfunction

function TriggerRegisterVoteEvent takes trigger whichTrigger returns integer
    local integer t = CallbacksCounter
    set CallbackTriggers[t] = whichTrigger
    set CallbacksCounter = CallbacksCounter + 1
    
    return t
endfunction

function VoteCreate takes string title returns integer
    local integer vote = VotesCounter
    set VoteTitle[vote] = title
    set VoteTimer[vote] = CreateTimer()
    call SaveInteger(h, GetHandleId(VoteTimer[vote]), 0, vote)
    set VoteTimeout[vote] = VOTE_SYSTEM_DEFAULT_TIMEOUT
    set VoteTimerDialog[vote] = CreateTimerDialog(VoteTimer[vote])
    set VotePlayers[vote] = CreateForce()
    set VoteIsRunning[vote] = false
    set VoteDefaultChoice[vote] = -1
    set VoteChoices[vote] = 0
    set VotesCounter = VotesCounter + 1
    return vote
endfunction

function VoteAddChoice takes integer vote, boolean default, string name, string chatCommand returns integer
    local integer choice = VoteChoices[vote]
    local integer index = VoteChoiceIndex(choice, vote)
        
    set VoteChoicesNames[index] = name
    set VoteChoicesChatCommands[index] = chatCommand
    set VoteChoicesVotes[index] = CreateForce()
    
    if (default) then
        set VoteDefaultChoice[vote] = choice
    endif
    
    set VoteChoices[vote] = VoteChoices[vote] + 1

    return choice
endfunction

function VoteAddYesChoice takes integer vote returns integer
    return VoteAddChoice(vote, false, "yes", "-yes")
endfunction

function IsVoteRunning takes integer vote returns boolean
    return VoteIsRunning[vote]
endfunction

function IsPlayerInVote takes integer vote, player whichPlayer returns boolean
    return IsPlayerInForce(whichPlayer, VotePlayers[vote])
endfunction

private function ExecuteCallbacks takes integer vote, integer choice, integer votes returns nothing
    local integer i = 0
    loop
        exitwhen (i >= CallbacksCounter)
        set callbackVote = vote
        set callbackChoice = choice
        set callbackVotes = votes
        if (IsTriggerEnabled(CallbackTriggers[i])) then
            call ConditionalTriggerExecute(CallbackTriggers[i])
        endif
        set i = i + 1
    endloop
    if (VoteYesTrigger[vote] != null and choice == 0) then
        set callbackVote = vote
        set callbackChoice = choice
        set callbackVotes = votes
        if (IsTriggerEnabled(VoteYesTrigger[i])) then
            call ConditionalTriggerExecute(VoteYesTrigger[vote])
        endif
    endif
endfunction

private function GetVoteChoiceVotes takes integer index returns integer
    return CountPlayersInForceBJ(VoteChoicesVotes[index])
endfunction

private function VoteResetVotes takes integer vote returns nothing
    local integer i = 0
    local integer index = 0
    loop
        exitwhen (i >= VoteChoices[vote])
        set index = VoteChoiceIndex(i, vote)
        call ForceClear(VoteChoicesVotes[index])
        set i = i + 1
    endloop
endfunction

private function VoteRecalculateAllChoices takes integer vote, boolean expired returns integer
    local integer availableVotes = CountPlayersInForceBJ(VotePlayers[vote])
    local integer choiceVotes = 0
    local integer totalVotes = 0
    local integer notVoted = 0
    local integer maxChoice = 0
    local integer maxChoiceVotes = 0
    local integer votedChoice = -1
    local integer votedVotes = 0
    local integer index = 0
    local integer i = 0
    //call BJDebugMsg("Recalculate votes for " + I2S(VoteChoices[vote]) + " choices.")
    loop
        exitwhen (i >= VoteChoices[vote])
        set index = VoteChoiceIndex(i, vote)
        set choiceVotes = GetVoteChoiceVotes(index)
        set totalVotes = totalVotes + choiceVotes
        if (choiceVotes > maxChoiceVotes) then
            set maxChoice = i
            set maxChoiceVotes = choiceVotes
        endif
        set i = i + 1
    endloop
    set notVoted = availableVotes - totalVotes
    //call BJDebugMsg("Available votes: " + I2S(availableVotes) + ", maxChoiceVotes " + I2S(maxChoiceVotes) + " and not voted: " + I2S(notVoted))
    if (maxChoiceVotes > notVoted) then
        set votedChoice = maxChoice
        set votedVotes = maxChoiceVotes
    elseif (expired and VoteDefaultChoice[vote] != -1) then
        set votedChoice = VoteDefaultChoice[vote]
        set index = VoteChoiceIndex(votedChoice, vote)
        set votedVotes = GetVoteChoiceVotes(index)
    endif
    
    if (votedChoice != -1) then
        call PauseTimer(VoteTimer[vote])
        call TimerDialogDisplayForForce(false, VoteTimerDialog[vote], VotePlayers[vote])
        call ExecuteCallbacks(vote, votedChoice, maxChoiceVotes)
        call VoteResetVotes(vote)
        set VoteIsRunning[vote] = false
    elseif (expired) then
        call PauseTimer(VoteTimer[vote])
        call TimerDialogDisplayForForce(false, VoteTimerDialog[vote], VotePlayers[vote])
        call VoteResetVotes(vote)
        set VoteIsRunning[vote] = false
    endif
        
    return votedChoice
endfunction

function VoteRecalculate takes integer vote, boolean expired returns integer
    if (not IsVoteRunning(vote)) then
        return -1
    endif
    
    return VoteRecalculateAllChoices(vote, expired)
endfunction

private function TimerFunctionVoteExpires takes nothing returns nothing
    local integer vote = LoadInteger(h, GetHandleId(GetExpiredTimer()), 0)
    //call BJDebugMsg("Timer has expired for vote: " + I2S(vote))
    call VoteRecalculate(vote, true)
endfunction

function VoteStart takes integer vote, force whichForce returns boolean
    if (IsVoteRunning(vote)) then
        return false
    endif
    
    set VoteIsRunning[vote] = true
    call ForceClear(VotePlayers[vote])
    call ForceAddForce(VotePlayers[vote], whichForce)
    call TimerStart(VoteTimer[vote], VoteTimeout[vote], false, function TimerFunctionVoteExpires)
    call TimerDialogSetTitle(VoteTimerDialog[vote], VoteTitle[vote])
    call TimerDialogDisplayForForce(true, VoteTimerDialog[vote], VotePlayers[vote])
    call VoteResetVotes(vote)
    
    return true
endfunction

private function VoteCheckChatCommandChoices takes integer vote, string command returns integer
    local integer i = 0
    local integer max = VoteChoices[vote]
    loop
        exitwhen (i >= max)
        if (VoteChoicesChatCommands[VoteChoiceIndex(i, vote)] == command) then
            return i
        endif
        set i = i + 1
    endloop

    return -1
endfunction

function VoteAddVote takes integer vote, integer choice, player whichPlayer, boolean showMessage returns nothing
    local integer index = VoteChoiceIndex(choice, vote)
    
    if (not IsPlayerInForce(whichPlayer, VoteChoicesVotes[index])) then
        //call BJDebugMsg("Add vote to choice " + I2S(choice))
        call ForceAddPlayer(VoteChoicesVotes[index], whichPlayer)
        
        if (showMessage) then
            call DisplayTextToForce(VotePlayers[vote], Format(GetLocalizedString("VOTE_MESSAGE")).s(GetPlayerNameColored(whichPlayer)).s(VoteChoicesNames[index]).i(CountPlayersInForceBJ(VoteChoicesVotes[index])).i(CountPlayersInForceBJ(VotePlayers[vote])).result())
        endif
    
        call VoteRecalculate(vote, false)
    else
        call SimError(whichPlayer, GetLocalizedString("UNABLE_TO_VOTE"))
    endif
endfunction

function VoteSetStartChatCommand takes integer vote, string chatCommand returns nothing
    set VoteStartChatCommand[vote] = chatCommand
endfunction

function VoteSetYesTrigger takes integer vote, trigger whichTrigger returns nothing
    set VoteYesTrigger[vote] = whichTrigger
endfunction

function VoteSetYesTriggerAction takes integer vote, code triggerAction returns nothing
    set VoteYesTrigger[vote] = CreateTrigger()
    call TriggerAddAction(VoteYesTrigger[vote], triggerAction)
endfunction

function VoteRemovePlayer takes integer vote, player whichPlayer returns nothing
    call ForceRemovePlayer(VotePlayers[vote], whichPlayer)
endfunction

function VoteStartForAllPlayingUsers takes integer vote returns boolean
    return VoteStart(vote, GetAllPlayingUsers())
endfunction

function VoteStartForAllPlayingUsersWithInitialVote takes integer vote, player whichPlayer returns boolean
    local boolean result = VoteStartForAllPlayingUsers(vote)
    if (result) then
        call VoteAddVote(vote, 0, whichPlayer, false)
    else
        call SimError(whichPlayer, GetLocalizedString("UNABLE_TO_START_VOTE"))
    endif
    return result
endfunction

function StartGlobalVote takes integer vote, player whichPlayer returns nothing
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("START_VOTE_MESSAGE")).s(GetPlayerNameColored(whichPlayer)).s(VoteGetTitle(vote)).s(VoteStartChatCommand[vote]).result())
    call VoteStartForAllPlayingUsersWithInitialVote(vote, whichPlayer)
endfunction

private function TriggerActionChatCommand takes nothing returns nothing
    local string chatCommand = GetEventPlayerChatString()
    local player triggerPlayer = GetTriggerPlayer()
    local integer matchingChoice = -1
    local integer i = 0
    loop
        exitwhen (i >= VotesCounter)
        if (not IsVoteRunning(i)) then
            if (VoteYesTrigger[i] != null and VoteStartChatCommand[i] == chatCommand) then
                call StartGlobalVote(i, triggerPlayer)
            endif
        else
            set matchingChoice = VoteCheckChatCommandChoices(i, chatCommand)
            
            if (matchingChoice != -1) then
                call VoteAddVote(i, matchingChoice, triggerPlayer, true)
            endif
        endif
        set i = i + 1
    endloop
    set triggerPlayer = null
endfunction

private function TriggerActionPlayerLeaves takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i >= VotesCounter)
        if (IsVoteRunning(i)) then
            call VoteRemovePlayer(i, GetTriggerPlayer())
            call VoteRecalculate(i, false)
        endif
        set i = i + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    local player whichPlayer = null
    local integer i = 0
    loop
        exitwhen (i >= bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER) then
            call TriggerRegisterPlayerChatEvent(chatCommandTrigger, whichPlayer, "", false)
            call TriggerRegisterPlayerEvent(leavesTrigger, whichPlayer, EVENT_PLAYER_LEAVE)
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    call TriggerAddAction(chatCommandTrigger, function TriggerActionChatCommand)
    call TriggerAddAction(leavesTrigger, function TriggerActionPlayerLeaves)
endfunction

endlibrary
