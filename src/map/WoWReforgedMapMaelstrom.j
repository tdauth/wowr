library WoWReforgedMapMaelstrom initializer Init requires SafeString, WoWReforgedMapData

globals
    private trigger enterTrigger = CreateTrigger()
endglobals

private function TriggerConditionEnter takes nothing returns boolean
    local player owner = GetOwningPlayer(GetTriggerUnit())
    if (owner != Player(PLAYER_NEUTRAL_PASSIVE) and owner != Player(PLAYER_NEUTRAL_AGGRESSIVE) and owner != GetMapBossesPlayer() and GetUnitTypeId(GetTriggerUnit()) != BACK_PACK and GetUnitTypeId(GetTriggerUnit()) != EQUIPMENT_BAG and not UnitHasBuffBJ(GetTriggerUnit(), 'Bvul') and GetUnitAbilityLevel(GetTriggerUnit(), 'Avul') == 0 and not IsUnitInGroup(GetTriggerUnit(), udg_TuskarrQuest3Ships) and GetPlayerTechCountSimple(UPG_STORM_PROTECTION, owner) == 0) then
        call KillUnit(GetTriggerUnit())
        call QuestMessageBJ(bj_FORCE_PLAYER[GetPlayerId(owner)], bj_QUESTMESSAGE_WARNING, GetLocalizedStringSafe("MAELSTROM_ENTER"))
    endif
    set owner = null
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterEnterRectSimple(enterTrigger, gg_rct_Maelstrom_Center)
    call TriggerAddCondition(enterTrigger, Condition(function TriggerConditionEnter))
endfunction

endlibrary
