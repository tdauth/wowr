library WoWReforgedMapArena initializer Init requires WoWReforgedArena

globals
    private trigger enterTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
endglobals

function EnableArena takes nothing returns nothing
    call EnableTrigger(enterTrigger)
endfunction

private function TriggerConditionEnter takes nothing returns boolean
    return GetTriggerUnit() == udg_Held[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]
endfunction

private function TriggerActionEnter takes nothing returns nothing
    call EnterArena(GetTriggerUnit(), gg_rct_Arena, gg_rct_Arena_Hero_Position, GetLocalizedStringSafe("ENTERING_ARENA"), gg_snd_Arena_Start)
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    return IsUnitEnemyFromArena(GetTriggerUnit())
endfunction

private function DoDropItem takes nothing returns boolean
    return GetRandomInt(0, 100) >= 50
endfunction

private function TriggerActionDeath takes nothing returns nothing
    call MoveTmpLocationToUnit(GetTriggerUnit())
    // Level 1
    if (GetUnitTypeId(GetTriggerUnit()) == 'nogr') then
        if (DoDropItem()) then
            call CreateItem('fgrg', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 2
    if (GetUnitTypeId(GetTriggerUnit()) == 'nowb') then
        if (DoDropItem()) then
            call CreateItem('totw', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 3
    if (GetUnitTypeId(GetTriggerUnit()) == 'nmgw') then
        if (DoDropItem()) then
            call CreateItem('shar', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 4
    if (GetUnitTypeId(GetTriggerUnit()) == 'nbzk') then
        if (DoDropItem()) then
            call CreateItem('gvsm', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 5
    if (GetUnitTypeId(GetTriggerUnit()) == 'nogn' or GetUnitTypeId(GetTriggerUnit()) == 'nogo') then
        if (DoDropItem()) then
            call CreateItem('shcw', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 6
    if (GetUnitTypeId(GetTriggerUnit()) == 'nehy') then
        if (DoDropItem()) then
            call CreateItem('thdm', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 7
    if (GetUnitTypeId(GetTriggerUnit()) == 'nwna') then
        if (DoDropItem()) then
            call CreateItem('shhn', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 8
    if (GetUnitTypeId(GetTriggerUnit()) == 'nsqa' or GetUnitTypeId(GetTriggerUnit()) == 'nsqo') then
        if (DoDropItem()) then
            call CreateItem('srtl', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        endif
    endif
    // Level 9
    if (GetUnitTypeId(GetTriggerUnit()) == 'n00B') then
        if (DoDropItem()) then
            call CreateItem('I03G', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
        else
            if (IsQuestEnabled(udg_OrcQuest[3]) and not IsQuestCompleted(udg_OrcQuest[3]) and not udg_ArenaDroppedOrcQuest3Reward) then
                call SetItemInvulnerable(CreateItem( 'I03G', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit())), true)
                set udg_ArenaDroppedOrcQuest3Reward = true
                set udg_TmpQuest = udg_OrcQuest[3]
                call QuestCompleteItem(0)
            endif
        endif
    endif
endfunction

private function Init takes nothing returns nothing
    call DisableTrigger(enterTrigger)
    call TriggerRegisterEnterRectSimple(enterTrigger, gg_rct_Arena)
    call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
    call TriggerAddAction(enterTrigger, function TriggerActionEnter)

    call TriggerRegisterPlayerUnitEventSimple(deathTrigger, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterPlayerUnitEventSimple(deathTrigger, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
endfunction

endlibrary
