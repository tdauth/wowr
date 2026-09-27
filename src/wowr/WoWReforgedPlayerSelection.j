library WoWReforgedPlayerSelection initializer Init requires SimError, ItemUtils, StringFormat, WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedProperties, WoWReforgedMapData

globals
    private player filterPlayer = null
    private boolexpr filterIsEnemy = null
    private boolexpr filterIsValidUnitRemovalTarget = null
endglobals

function DisplayPickedGameModeWarlord takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("WARLORD")).result())
endfunction

function DisplayPickedGameModeFreelancer takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("PICKED_GAME_MODE_X")).s(GetLocalizedString("FREELANCER")).result())
endfunction

function RecreatePlayerSoul takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    if ( udg_PlayerSelectionSoul[convertedPlayerId] != null) then
        call UnitRemoveItemFromSlot(udg_PlayerSelectionSoul[convertedPlayerId], 1)
        call RemoveUnit(udg_PlayerSelectionSoul[convertedPlayerId])
    endif
    set udg_PlayerSelectionSoul[convertedPlayerId] = CreateUnit(whichPlayer, HERO_SELECTOR, GetPlayerStartLocationX(whichPlayer), GetPlayerStartLocationY(whichPlayer), bj_UNIT_FACING)
    call SuspendHeroXP(udg_PlayerSelectionSoul[convertedPlayerId], false)
    call PanCameraToTimedForPlayer(whichPlayer, GetPlayerStartLocationX(whichPlayer), GetPlayerStartLocationY(whichPlayer), 0)
endfunction

private function FilterIsValidUnitRemovalTarget takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) != FOUNTAIN_OF_LIFE and GetUnitTypeId(GetFilterUnit()) != FREELANCER_PROTECTION_TOWER and GetUnitTypeId(GetFilterUnit()) != BACKPACK and GetUnitTypeId(GetFilterUnit()) != EQUIPMENT_BAG and not IsUnitProperty(GetFilterUnit()) and udg_Held2[GetConvertedPlayerId(filterPlayer)] != GetFilterUnit() and udg_Held3[GetConvertedPlayerId(filterPlayer)] != GetFilterUnit()
endfunction

private function EnumRemoveUnit takes nothing returns nothing
    call RemoveUnit(GetEnumUnit())
endfunction

private function FilterIsEnemy takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), filterPlayer) and GetOwningPlayer(GetFilterUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE)
endfunction

// Do not remove backpacks nor drop items.
// Non-profession and non-race items are dropped on repick.
function HeroRepick takes player whichPlayer returns nothing
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    // No repick during hero selection
    if (udg_Held[convertedPlayerId] != null and udg_PlayerSelectionSoul[convertedPlayerId] == null) then
        // No repicking with enemies in range except for Theramore
        set bj_wantDestroyGroup = true
        set filterPlayer = whichPlayer
        if (IsUnitGroupEmptyBJ(GetUnitsInRangeOfLocMatching(512, GetUnitLoc(udg_Held[convertedPlayerId]), filterIsEnemy)) or RectContainsUnit(GetMapPlayerSelectionRect(), udg_Held[convertedPlayerId])) then
            // No repicking when controlling Illidan
            if (udg_IllidanController == null or udg_IllidanControllerOriginalOwner != whichPlayer) then
                // Drop all items on Theramore (because of quest items)
                call DisplayTextToForce(bj_FORCE_PLAYER[GetPlayerId(whichPlayer)], GetLocalizedString("HERO_REPICK_INFO"))
                call SetUnitPosition(udg_Held[convertedPlayerId], GetMapNeutralZoneX(),  GetMapNeutralZoneY())
                // Drop Items
                call RemoveBackpackItemFromHero(udg_Held[convertedPlayerId])
                //call DropAllItemsNotFromRace(whichPlayer)
                //call DropAllItemsNotFromProfession(whichPlayer)
                call DropAllItemsFromHeroAt(udg_Held[convertedPlayerId], GetMapNeutralZoneX(),  GetMapNeutralZoneY())
                call DropBackpackForPlayerTo(whichPlayer, GetMapNeutralZoneX(),  GetMapNeutralZoneY())
                if (udg_Held[convertedPlayerId] != null) then
                    // Remove Mount
                    call MountKill(udg_Held[convertedPlayerId])
                    // Store XP so you don't start at level 0
                    set udg_CharacterStartXP[convertedPlayerId] = GetHeroXP(udg_Held[convertedPlayerId])
                    call RemoveUnit(udg_Held[convertedPlayerId])
                    set udg_Held[convertedPlayerId] = null
                endif
                // Kill all haunted goldmines
                call KillAllHauntedGoldMines(whichPlayer)
                // Select Tavern
                call RecreatePlayerSoul(whichPlayer)
                // Remove all units
                set bj_wantDestroyGroup = true
                set filterPlayer = whichPlayer
                call ForGroupBJ(GetUnitsOfPlayerMatching(whichPlayer, filterIsValidUnitRemovalTarget), function EnumRemoveUnit)
                set udg_Hideout[convertedPlayerId] = null
                set udg_PlayerRace2[convertedPlayerId] = udg_RaceNone
                set udg_PlayerProfession[convertedPlayerId] = udg_ProfessionNone
                set udg_PlayerProfession2[convertedPlayerId] = udg_ProfessionNone
                // Select Tavern
                call RecreatePlayerSoul(whichPlayer)
                // Selection Mode
                set udg_PlayerSelectionMode[convertedPlayerId] = udg_PlayerSelectionModeRepick
                set udg_TmpPlayer = whichPlayer
                call ConditionalTriggerExecute(gg_trg_Player_Selection_Update_Floating_Text)
            else
                call SimError(whichPlayer, GetLocalizedString("NO_REPICK_WITH_ILLIDAN"))
            endif
        else
            call SimError(whichPlayer, GetLocalizedString("NO_REPICK_WITH_ENEMIES"))
        endif
    else
        call SimError(whichPlayer, GetLocalizedString("NOT_ALLOWED_IN_PLAYER_SELECTION"))
    endif
endfunction

private function Init takes nothing returns nothing
    set filterIsEnemy = Condition(function FilterIsEnemy)
    set filterIsValidUnitRemovalTarget = Condition(function FilterIsValidUnitRemovalTarget)
endfunction

endlibrary
