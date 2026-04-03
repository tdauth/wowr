library WoWReforgedResurrectionStone initializer Init requires WoWReforgedUtils

struct ResurrectionStone
    unit u
    rect activationRect
    rect revivalRect
    real facing
    trigger activationTrigger = CreateTrigger()
    group g = CreateGroup()
endstruct

globals
    constant integer ITEM_ACTIVATE_RESURRECTION_STONE = 'I147'
    constant integer ITEM_DEACTIVATE_RESURRECTION_STONE = 'I14A'
    constant real RESURRECTION_TIME = 30.0

    private ResurrectionStone array resurrectionStones
    private integer resurrectionStonesCounter = 0
    
    private trigger deathTrigger = CreateTrigger()
    private trigger reviveTrigger = CreateTrigger()
    private trigger chatTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
    
    private ResurrectionStone array heroResurrectionStones
    private timer array heroResurrectionTimers
endglobals

function IsResurrectionStone takes integer unitTypeId returns boolean
    return unitTypeId == RESURRECTION_STONE_0 or unitTypeId == RESURRECTION_STONE_1
endfunction

function IsUnitResurrectionStone takes unit whichUnit returns boolean
    return IsResurrectionStone(GetUnitTypeId(whichUnit))
endfunction

function GetResurrectionStoneFromUnit takes unit whichUnit returns ResurrectionStone
    return LoadInteger(h, GetHandleId(whichUnit), 0)
endfunction

function ResurrectionStoneHasHeroOfPlayer takes ResurrectionStone r, player whichPlayer returns boolean
    local boolean result = false
    local unit u = null
    local integer i = 0
    local integer max = BlzGroupGetSize(r.g)
    loop
        exitwhen (i == max or result)
        set u = BlzGroupUnitAt(r.g, i)
        if (GetOwningPlayer(u) == whichPlayer) then
            set result = true
        endif
        set u = null
        set i = i + 1
    endloop
    return result
endfunction

function DeactivateResurrectionStone takes player whichPlayer, integer heroIndex returns nothing
    local ResurrectionStone r = 0
    local integer playerId = GetPlayerId(whichPlayer)
    local integer index = Index2D(playerId, heroIndex, MAX_HEROES)
    local unit hero = GetPlayerHeroByIndex(whichPlayer, heroIndex)
    if (heroResurrectionStones[index] != 0) then
        set r = heroResurrectionStones[index]
        call GroupRemoveUnit(r.g, hero)
        if (not ResurrectionStoneHasHeroOfPlayer(r, whichPlayer)) then
            call UnitShareVision(r.u, whichPlayer, false)
        endif
        if (BlzGroupGetSize(r.g) == 0) then
            call SetUnitAnimation(r.u, "stand")
        endif
    endif
    call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_HINT, GetLocalizedString("DEACTIVATED_RESURRECTION_STONE"))
    set hero = null
endfunction

function DeactivateAllResurrectionStones takes player whichPlayer returns nothing
    call DeactivateResurrectionStone(whichPlayer, 0)
    call DeactivateResurrectionStone(whichPlayer, 1)
    call DeactivateResurrectionStone(whichPlayer, 2)
endfunction

private function TriggerConditionActivate takes nothing returns boolean
    local ResurrectionStone r = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    
    return r.u == GetSellingUnit()
endfunction

private function GetHeroIndex takes unit hero returns integer
    local integer index = GetPlayerHeroIndex(GetOwningPlayer(hero), hero)
    if (index == -1) then
        return 0
    endif
    return index
endfunction

private function TriggerActionActivate takes nothing returns nothing
    local ResurrectionStone r = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    local unit hero = GetBuyingUnit()
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    local integer index = 0
    local item whichItem = GetSoldItem()
    local integer itemTypeId = GetItemTypeId(whichItem)
    local effect e = null
    if (itemTypeId == ITEM_ACTIVATE_RESURRECTION_STONE) then
        if (IsPlayerHero(hero)) then
            set index = Index2D(playerId, GetHeroIndex(hero), MAX_HEROES)
            if (heroResurrectionStones[index] != 0) then
                call GroupRemoveUnit(r.g, hero)
                if (not ResurrectionStoneHasHeroOfPlayer(r, owner)) then
                    call UnitShareVision(r.u, owner, false)
                endif
                if (BlzGroupGetSize(r.g) == 0) then
                    call SetUnitAnimation(r.u, "stand")
                endif
            endif
            call GroupAddUnit(r.g, hero)
            set heroResurrectionStones[index] = r
            call UnitShareVision(r.u, owner, true)
            call SetUnitAnimation(r.u, "stand alternate")
            set e = AddSpecialEffect("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", GetUnitX(r.u), GetUnitY(r.u))
            call QuestMessageBJ(bj_FORCE_PLAYER[playerId], bj_QUESTMESSAGE_HINT, GetLocalizedString("ACTIVATED_RESURRECTION_STONE"))
            call PolledWait(2.0)
            call DestroyEffect(e)
            set e = null
        else
            call SimError(owner, GetLocalizedString("RESURRECTION_STONE_HERO_ONLY"))
        endif
        
        call RemoveItem(whichItem)
    elseif (itemTypeId == ITEM_DEACTIVATE_RESURRECTION_STONE) then
        if (IsPlayerHero(hero)) then
            call DeactivateResurrectionStone(owner, GetHeroIndex(hero))
        else
            call SimError(owner, GetLocalizedString("RESURRECTION_STONE_HERO_ONLY"))
        endif
        
        call RemoveItem(whichItem)
    endif
    set whichItem = null
    set hero = null
    set owner = null
endfunction

function AddResurrectionStone takes unit u, rect revivalRect, real facing returns ResurrectionStone
    local ResurrectionStone r = ResurrectionStone.create()
    set r.u = u
    set r.revivalRect = revivalRect
    set r.facing = facing
    call TriggerRegisterAnyUnitEventBJ(r.activationTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(r.activationTrigger, Condition(function TriggerConditionActivate))
    call TriggerAddAction(r.activationTrigger, function TriggerActionActivate)
    call SaveInteger(h, GetHandleId(r.activationTrigger), 0, r)
    call SaveInteger(h, GetHandleId(u), 0, r)
    
    return r
endfunction

private function TimerFunctionResurrect takes nothing returns nothing
    local integer index = LoadInteger(h, GetHandleId(GetExpiredTimer()), 0)
    local integer playerId = LoadInteger(h, GetHandleId(GetExpiredTimer()), 1)
    local integer i = LoadInteger(h, GetHandleId(GetExpiredTimer()), 2)
    local ResurrectionStone r = heroResurrectionStones[index]
    local real x = GetRectCenterX(r.revivalRect)
    local real y = GetRectCenterY(r.revivalRect)
    local unit hero = GetPlayerHeroByIndex(Player(playerId), i)
    call ReviveHero(hero, x, y, true)
    call SetUnitFacing(hero, r.facing)
    call PingMinimapForPlayer(Player(playerId), x, y, 6.0)
    call SetUnitAnimation(r.u, "stand alternate")
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    local ResurrectionStone r = 0
    local integer index = 0
    if (IsPlayerHero(GetTriggerUnit())) then
        set index = Index2D(GetPlayerId(owner), GetHeroIndex(GetTriggerUnit()), MAX_HEROES)
        set r = heroResurrectionStones[index]
        if (r != 0) then
            call TimerStart(heroResurrectionTimers[index], RESURRECTION_TIME, false, function TimerFunctionResurrect)
            call SetUnitAnimation(r.u, "stand work")
        endif
    endif
    set owner = null
    return false
endfunction

private function TriggerConditionReviveStart takes nothing returns boolean
    local ResurrectionStone r = 0
    local integer index = 0
    if (IsPlayerHero(GetRevivingUnit())) then
        set index = Index2D(GetPlayerId(GetOwningPlayer(GetRevivingUnit())), GetHeroIndex(GetRevivingUnit()), MAX_HEROES)
        call PauseTimer(heroResurrectionTimers[index])
        set r = heroResurrectionStones[index]
        if (r != 0) then
            call SetUnitAnimation(r.u, "stand alternate")
        endif
    endif
    return false
endfunction

private function TriggerConditionChat takes nothing returns boolean
    local string msg = GetEventPlayerChatString()
    if (msg == "-noresurrect") then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 0)
        endif
        if (GetPlayerHero2(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 1)
        endif
        if (GetPlayerHero3(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 2)
        endif
    elseif (msg == "-noresurrect1") then
        if (GetPlayerHero1(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 0)
        else
            call SimError(GetTriggerPlayer(), Format(GetLocalizedString("NO_HERO_X")).i(1).result())
        endif
    elseif (msg == "-noresurrect2") then
        if (GetPlayerHero2(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 1)
        else
            call SimError(GetTriggerPlayer(), Format(GetLocalizedString("NO_HERO_X")).i(2).result())
        endif
    elseif (msg == "-noresurrect3") then
        if (GetPlayerHero3(GetTriggerPlayer()) != null) then
            call DeactivateResurrectionStone(GetTriggerPlayer(), 2)
        else
            call SimError(GetTriggerPlayer(), Format(GetLocalizedString("NO_HERO_X")).i(3).result())
        endif
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local integer index = 0
    local player slotPlayer = null
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        set j = 0
        loop
            exitwhen (j == MAX_HEROES)
            set index = Index2D(i, j, MAX_HEROES)
            set heroResurrectionTimers[index] = CreateTimer()
            call SaveInteger(h, GetHandleId(heroResurrectionTimers[index]), 0, index)
            call SaveInteger(h, GetHandleId(heroResurrectionTimers[index]), 1, i)
            call SaveInteger(h, GetHandleId(heroResurrectionTimers[index]), 2, j)
            set heroResurrectionStones[index] = 0
            set j = j + 1
        endloop
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, "-noresurrect", true)
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, "-noresurrect1", true)
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, "-noresurrect2", true)
            call TriggerRegisterPlayerChatEvent(chatTrigger, slotPlayer, "-noresurrect3", true)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call TriggerRegisterAnyUnitEventBJ(reviveTrigger, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerAddCondition(reviveTrigger, Condition(function TriggerConditionReviveStart))
    
    call TriggerAddCondition(chatTrigger, Condition(function TriggerConditionChat))
endfunction

endlibrary
