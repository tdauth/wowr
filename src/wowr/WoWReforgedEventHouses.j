library WoWReforgedEventHouses initializer Init requires SafeString, StringFormat, PlayerColorUtils, ForceUtils, WoWReforgedAutoSkill, WoWReforgedMapData

globals
    private constant integer HERO_LEVELS = 10

    private filterfunc f = null
    private player owner = null
    private trigger pickupItemTrigger = CreateTrigger()
endglobals

private function FilterIsHero takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO)
endfunction

private function EnumIncreaseHeroLevel takes nothing returns nothing
    call SetHeroLevelBJ(GetEnumUnit(), GetHeroLevel(GetEnumUnit()) + HERO_LEVELS, false)
    call AutoSkillHero(GetEnumUnit())
endfunction

private function DisplayQuestMessage takes player whichPlayer, player targetPlayer returns nothing
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UNITACQUIRED, Format(GetLocalizedStringSafe("INCREASE_HERO_LEVELS")).s(GetPlayerNameColored(whichPlayer)) .s(GetPlayerNameColored(targetPlayer)).i(HERO_LEVELS).result())
endfunction

private function EnumAiPlayerIncreaseHeroLevels takes nothing returns nothing
    call DisplayQuestMessage(owner, GetEnumPlayer())
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerMatching(GetEnumPlayer(), f), function EnumIncreaseHeroLevel)
endfunction

private function IncreaseAiHeroLevels takes player whichPlayer returns nothing
    local force aiPlayers = CreateForce()
    call ForceAddPlayingComputerPlayers(aiPlayers)
    set owner = whichPlayer
    call ForForce(aiPlayers, function EnumAiPlayerIncreaseHeroLevels)
    call ForceClear(aiPlayers)
    call DestroyForce(aiPlayers)
    set aiPlayers = null
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    local integer itemTypeId = GetItemTypeId(GetManipulatedItem())
    if (itemTypeId == 'I04G') then // Feed bosses
        call DisplayQuestMessage(GetOwningPlayer(GetTriggerUnit()), GetMapBossesPlayer())
        set bj_wantDestroyGroup = true
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetMapBossesPlayer(), f), function EnumIncreaseHeroLevel)
    elseif (itemTypeId == 'I05D') then // Feed AI
        call IncreaseAiHeroLevels(GetOwningPlayer(GetTriggerUnit()))
    elseif (itemTypeId == 'I08V') then // Purchase Deathwing
        call StartTimerBJ(udg_BossDeathwingTimer, false, 0.0)
    elseif (itemTypeId == 'I08W') then // Purchase Cenarius
        call StartTimerBJ(udg_BossCenariusTimer, false, 0.0)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set f = Filter(function FilterIsHero)
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))
endfunction

endlibrary
