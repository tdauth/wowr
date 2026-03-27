library ResourcesWarnings initializer Init requires SimError, MathUtils, Resources

/**
 * Optional system for resource warnings sounds.
 */

globals
    private integer array resourceLowValue
    private sound array playerSoundLow
    private string array playerMessageLow
    private sound array playerSoundCollapsed
    private string array playerMessageCollapsed
   
    private trigger gatherTrigger = CreateTrigger()
endglobals

function SetResourceLowValue takes Resource resource, integer lowValue returns nothing
    set resourceLowValue[resource] = lowValue
endfunction

function GetResourceLowValue takes Resource resource returns integer
    return resourceLowValue[resource]
endfunction

private function GetAlliesWithSharedControl takes player owner returns force
    local force allies = CreateForce()
    local player slotPlayer = null
    local integer i = 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    return allies
endfunction

private function StartSoundForAllies takes player whichPlayer, sound whichSound returns nothing
    local force allies = GetAlliesWithSharedControl(whichPlayer)
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call StartSound(whichSound)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

private function SimErrorForAllies takes player whichPlayer, string msg returns nothing
    local force allies = GetAlliesWithSharedControl(whichPlayer)
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (IsPlayerInForce(Player(i), allies)) then
            call SimError(Player(i), msg)
        endif
        set i = i + 1
    endloop
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

private function PingMinimapForAllies takes player whichPlayer, real x, real y returns nothing
    local force allies = GetAlliesWithSharedControl(whichPlayer)
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call PingMinimapEx(x, y, 4.0, 255, 255, 22, false)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
endfunction

function SetLowResourcesSound takes player whichPlayer, Resource resource, sound whichSound returns nothing
    set playerSoundLow[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)] = whichSound
endfunction

function GetLowResourcesSound takes player whichPlayer, Resource resource returns sound
    return playerSoundLow[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)]
endfunction

function SetLowResourcesSoundForAllPlayers takes Resource resource, sound whichSound returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerSoundLow[Index2D(resource, i, bj_MAX_PLAYERS)] = whichSound
        set i = i + 1
    endloop
endfunction

function SetLowResourcesMessage takes player whichPlayer, Resource resource, string message returns nothing
    set playerMessageLow[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)] = message
endfunction

function GetLowResourcesMessage takes player whichPlayer, Resource resource returns string
    return playerMessageLow[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)]
endfunction

function SetLowResourcesMessageForAllPlayers takes Resource resource, string message returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerMessageLow[Index2D(resource, i, bj_MAX_PLAYERS)] = message
        set i = i + 1
    endloop
endfunction

function SetCollapsedesourcesSound takes player whichPlayer, Resource resource, sound whichSound returns nothing
    set playerSoundCollapsed[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)] = whichSound
endfunction

function GetCollapsedResourcesSound takes player whichPlayer, Resource resource returns sound
    return playerSoundCollapsed[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)]
endfunction

function SetCollapsedResourcesSoundForAllPlayers takes Resource resource, sound whichSound returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerSoundCollapsed[Index2D(resource, i, bj_MAX_PLAYERS)] = whichSound
        set i = i + 1
    endloop
endfunction

function SetCollapsedResourcesMessage takes player whichPlayer, Resource resource, string message returns nothing
    set playerMessageCollapsed[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)] = message
endfunction

function GetCollapsedResourcesMessage takes player whichPlayer, Resource resource returns string
    return playerMessageCollapsed[Index2D(resource, GetPlayerId(whichPlayer), bj_MAX_PLAYERS)]
endfunction

function SetCollapsedResourcesMessageForAllPlayers takes Resource resource, string message returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set playerMessageCollapsed[Index2D(resource, i, bj_MAX_PLAYERS)] = message
        set i = i + 1
    endloop
endfunction

private function TriggerConditionGather takes nothing returns boolean
    local Resource resource = GetTriggerResource()
    local unit mine = GetTriggerMine()
    local unit worker = GetTriggerWorker()
    local player owner = GetOwningPlayer(worker)
    if (GetLowResourcesSound(owner, resource) != null and GetUnitResource(mine, resource) <= GetResourceLowValue(resource) and  GetUnitResource(mine, resource) + resource > GetResourceLowValue(resource)) then
        call StartSoundForAllies(owner, GetLowResourcesSound(GetOwningPlayer(GetTriggerWorker()), resource))
        call PingMinimapForAllies(owner, GetUnitX(mine), GetUnitY(mine))
        if (GetLowResourcesMessage(owner, resource) != null and GetLowResourcesMessage(owner, resource) != "") then
            call SimErrorForAllies(owner, GetLowResourcesMessage(owner, resource))
        endif
    endif
    if (GetCollapsedResourcesSound(owner, resource) != null and GetUnitResource(mine, resource) <= 0) then
        call StartSoundForAllies(owner, GetCollapsedResourcesSound(owner, resource))
        call PingMinimapForAllies(owner, GetUnitX(mine), GetUnitY(mine))
        if (GetCollapsedResourcesMessage(owner, resource) != null and GetCollapsedResourcesMessage(owner, resource) != "") then
            call SimErrorForAllies(owner, GetCollapsedResourcesMessage(owner, resource))
        endif
    endif
    set mine = null
    set worker = null
    set mine = null
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterGatherEvent(gatherTrigger)
    call TriggerAddCondition(gatherTrigger, Condition(function TriggerConditionGather))
endfunction

endlibrary
