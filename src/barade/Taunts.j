library Taunts initializer Init requires PlayerUtils, SoundUtils, optional QuestUtils

globals
    private hashtable h = InitHashtable()
    
    private trigger TauntsEnableChatTrigger = CreateTrigger()
    private trigger TauntsDisableChatTrigger = CreateTrigger()
    private trigger TauntsListChatTrigger = CreateTrigger()
    
    private boolean array TauntsEnabled

    private integer TauntsCount = 0
    private string array TauntChatCommands
    private string array TauntTexts
    private sound array TauntSounds
    private trigger array TauntsChatTrigger
endglobals

function GetTauntsCount takes nothing returns integer
    return TauntsCount
endfunction

function GetTauntChatCommand takes integer taunt returns string
    return TauntChatCommands[taunt]
endfunction

function GetTauntText takes integer taunt returns string
    return TauntTexts[taunt]
endfunction

function GetTauntSound takes integer taunt returns sound
    return TauntSounds[taunt]
endfunction

function SetPlayerTauntsEnabled takes player whichPlayer, boolean enabled returns nothing
    set TauntsEnabled[GetPlayerId(whichPlayer)] = enabled
endfunction

function IsPlayerTauntsEnabled takes player whichPlayer returns boolean
    return TauntsEnabled[GetPlayerId(whichPlayer)]
endfunction

function GetTauntsChatCommands takes nothing returns string
    local string text = "-taunts, -tauntson/off"
    local integer i = 0
    local integer max = GetTauntsCount()
    loop
        exitwhen (i == max)
        set text = text + ", " + GetTauntChatCommand(i)
        set i = i + 1
    endloop
    return text
endfunction

function PlayPlayerTaunt takes player whichPlayer, integer taunt returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (IsPlayerTauntsEnabled(slotPlayer)) then
            call PlaySoundForPlayer(slotPlayer, GetTauntSound(taunt))
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    // send to all at once even to the ones which have disabled taunts
    // otherwise the player will see his/her chat messages listed n times
    call BlzDisplayChatMessage(whichPlayer, 0, GetTauntText(taunt))
endfunction

private function TriggerConditionChatCommand takes nothing returns boolean
    local integer taunt = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    call PlayPlayerTaunt(GetTriggerPlayer(), taunt)
    return false
endfunction

function AddTaunt takes string chatCommand, string text, sound whichSound returns integer
    local integer index = TauntsCount
    set TauntChatCommands[index] = chatCommand
    set TauntTexts[index] = text
    set TauntSounds[index] = whichSound
    set TauntsChatTrigger[index] = CreateTrigger()
    call TriggerRegisterAnyPlayerChatEvent(TauntsChatTrigger[index], chatCommand, true)
    call TriggerAddCondition(TauntsChatTrigger[index], Condition(function TriggerConditionChatCommand))
    call SaveInteger(h, GetHandleId(TauntsChatTrigger[index]), 0, index)
    set TauntsCount = TauntsCount + 1
    return index
endfunction

private function TriggerConditionTauntsOn takes nothing returns boolean
    call SetPlayerTauntsEnabled(GetTriggerPlayer(), true)
    call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, 6.0, GetLocalizedString("ENABLED_TAUNTS"))
    return false
endfunction

private function TriggerConditionTauntsOff takes nothing returns boolean
    call SetPlayerTauntsEnabled(GetTriggerPlayer(), false)
    call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, 6.0, GetLocalizedString("DISABLED_TAUNTS"))
    return false
endfunction

private function TriggerConditionTaunts takes nothing returns boolean
    local string msg = GetLocalizedString("TAUNTS_DISABLED")
    if (IsPlayerTauntsEnabled(GetTriggerPlayer())) then
        set msg = GetLocalizedString("TAUNTS_ENABLED")
    endif
    set msg = msg + GetTauntsChatCommands()
    call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, 6.0, msg)
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set TauntsEnabled[i] = true
        set i = i + 1
    endloop
    call TriggerRegisterAnyPlayerChatEvent(TauntsEnableChatTrigger, "-tauntson", true)
    call TriggerAddCondition(TauntsEnableChatTrigger, Condition(function TriggerConditionTauntsOn))
    call TriggerRegisterAnyPlayerChatEvent(TauntsDisableChatTrigger, "-tauntsoff", true)
    call TriggerAddCondition(TauntsDisableChatTrigger, Condition(function TriggerConditionTauntsOff))
    call TriggerRegisterAnyPlayerChatEvent(TauntsListChatTrigger, "-taunts", true)
    call TriggerAddCondition(TauntsListChatTrigger, Condition(function TriggerConditionTaunts))
endfunction

endlibrary
