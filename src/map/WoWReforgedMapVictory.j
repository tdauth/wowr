library WoWReforgedMapVictory initializer Init requires WoWReforgedMapCinematics

globals
    private trigger deathTrigger = CreateTrigger()
endglobals

private function TriggerConditionDeath takes nothing returns boolean
    return udg_VictoryByKillingArchimonde and GetTriggerUnit() == gg_unit_N011_0053 and IsPlayerInForce(GetOwningPlayer(GetKillingUnit()), GetMapLobbyPlayers())
endfunction

private function EnumVictory takes nothing returns nothing
    call CustomVictoryBJ(GetEnumPlayer(), true, true)
endfunction

private function EnumDefeat takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(), GetLocalizedString("GAMEOVER_DEFEAT"))
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local player winner = GetOwningPlayer(GetKillingUnit())
    local force winners = CreateForce()
    local force losers = CreateForce()
    local force allies = GetPlayersAllies(winner)
    local force enemies = GetPlayersEnemies(winner)
    call ForceAddPlayer(winners, winner)
    call ForceAddForce(winners, allies)
    call ForceAddForce(losers, enemies)

    call PlayOutroCinematic()

    // Player wins
    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("X_HAS_WON_THE_GAME")).s(GetPlayerNameColored(winner)).result())
    call ForForce(winners, function EnumVictory)
    call ForForce(losers, function EnumDefeat)

    set winner = null

    call ForceClear(winners)
    call DestroyForce(winners)
    set winners = null

    call ForceClear(losers)
    call DestroyForce(losers)
    set losers = null

    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null

    call ForceClear(enemies)
    call DestroyForce(enemies)
    set enemies = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
endfunction

endlibrary
