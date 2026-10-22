library WoWReforgedPlayerSelection initializer Init requires SimError, ItemUtils, StringFormat, WoWReforgedUtils, WoWReforgedBackpacks, WoWReforgedProperties, WoWReforgedMapData

globals
    constant integer PLAYER_SELECTION_MODE_INITIAL = 0
    constant integer PLAYER_SELECTION_MODE_REPICK = 1
    constant integer PLAYER_SELECTION_MODE_REPICK_FULL = 2
    constant integer PLAYER_SELECTION_MODE_REPICK_HERO_1 = 3
    constant integer PLAYER_SELECTION_MODE_REPICK_HERO_2 = 4
    constant integer PLAYER_SELECTION_MODE_REPICK_HERO_3 = 5
    constant integer PLAYER_SELECTION_MODE_REPICK_PROFESSION_1 = 6
    constant integer PLAYER_SELECTION_MODE_REPICK_PROFESSION_2 = 7
    constant integer PLAYER_SELECTION_MODE_REPICK_PROFESSION_3 = 8
    constant integer PLAYER_SELECTION_MODE_REPICK_RACE_1 = 9
    constant integer PLAYER_SELECTION_MODE_REPICK_RACE_2 = 10
    constant integer PLAYER_SELECTION_MODE_REPICK_RACE_3 = 11
    constant integer PLAYER_SELECTION_MODE_REPICK_NONE = 12

    constant integer PLAYER_SELECTION_HERO_TYPE_1 = 0
    constant integer PLAYER_SELECTION_HERO_TYPE_2 = 1
    constant integer PLAYER_SELECTION_HERO_TYPE_3 = 2

/*
    integer udg_PlayerSelectionModeInitial= 0
integer udg_PlayerSelectionModeRepick= 0
integer udg_PlayerSelectionModeRepickFull= 0
integer udg_PlayerSelectionModeRepickHero1= 0
integer udg_PlayerSelectionModeRepickHero2= 0
integer udg_PlayerSelectionModeRepickHero3= 0
integer udg_PlayerSelectionModeRepickProf1= 0
integer udg_PlayerSelectionModeRepickProf2= 0
integer udg_PlayerSelectionModeRepickRace1= 0
integer udg_PlayerSelectionModeRepickRace2= 0
integer udg_PlayerSelectionModeNone= 0

    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionMode[i]=0
        set i=i + 1
    endloop

    set udg_PlayerSelectionModeInitial=0
    set udg_PlayerSelectionModeRepick=1
    set udg_PlayerSelectionModeRepickFull=2
    set udg_PlayerSelectionModeRepickHero1=3
    set udg_PlayerSelectionModeRepickHero2=4
    set udg_PlayerSelectionModeRepickHero3=5
    set udg_PlayerSelectionModeRepickProf1=6
    set udg_PlayerSelectionModeRepickProf2=7
    set udg_PlayerSelectionModeRepickRace1=9
    set udg_PlayerSelectionModeRepickRace2=10
    set udg_PlayerSelectionModeNone=12
    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionGameMode[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionProfession1[i]=0
        set i=i + 1
    endloop
RemovePlayerSelectionHero
    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionProfession2[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionRace1[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionRace2[i]=0
        set i=i + 1
    endloop

    set i=0
    loop
        exitwhen ( i > 28 )
        set udg_PlayerSelectionStartLocation[i]=0
        set i=i + 1
    endloop
*/

    private player filterPlayer = null
    private boolexpr filterIsEnemy = null
    private boolexpr filterIsValidUnitRemovalTarget = null
endglobals

function GetPlayerSelectionRaceType takes player whichPlayer returns integer
    return udg_PlayerSelectionRaceType[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionProfessionType takes player whichPlayer returns integer
    return udg_PlayerSelectionProfessionType[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionHeroType takes player whichPlayer returns integer
    return udg_PlayerSelectionHeroType[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionSelectModeText takes player whichPlayer returns texttag
    return udg_PlayerSelectionSelectModeText[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionSoul takes player whichPlayer returns unit
    return udg_PlayerSelectionSoul[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionMode takes player whichPlayer returns integer
    return udg_PlayerSelectionMode[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionGameMode takes player whichPlayer returns integer
    return udg_PlayerSelectionGameMode[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionProfession1 takes player whichPlayer returns integer
    return udg_PlayerSelectionProfession1[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionProfession2 takes player whichPlayer returns integer
    return udg_PlayerSelectionProfession2[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionProfession3 takes player whichPlayer returns integer
    return udg_PlayerSelectionProfession3[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionRace1 takes player whichPlayer returns integer
    return udg_PlayerSelectionRace1[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionRace2 takes player whichPlayer returns integer
    return udg_PlayerSelectionRace2[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionRace3 takes player whichPlayer returns integer
    return udg_PlayerSelectionRace3[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionStartLocation takes player whichPlayer returns integer
    return udg_PlayerSelectionStartLocation[GetConvertedPlayerId(whichPlayer)]
endfunction

function GetPlayerSelectionSettingsText takes player whichPlayer returns texttag
    return udg_PlayerSelectionSettingsText[GetConvertedPlayerId(whichPlayer)]
endfunction

function RemovePlayerSelectionSoul takes player whichPlayer returns nothing
    if (GetPlayerSelectionSoul(whichPlayer) != null) then
        call RemoveUnit(GetPlayerSelectionSoul(whichPlayer))
        set udg_PlayerSelectionSoul[GetConvertedPlayerId(whichPlayer)] = null
    endif
endfunction

function GetPlayerSelectionHero takes player whichPlayer returns unit
    if (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_1) then
        return GetPlayerHero1(whichPlayer)
    elseif (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_2) then
        return GetPlayerHero2(whichPlayer)
    elseif (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_3) then
        return GetPlayerHero3(whichPlayer)
    endif
    return null
endfunction

function RemovePlayerSelectionHero takes player whichPlayer returns nothing
    if (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_1) then
        if (GetPlayerHero1(whichPlayer) != null) then
            call RemoveUnit(GetPlayerHero1(whichPlayer))
            call SetPlayerHero1(whichPlayer, null)
        endif
    elseif (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_2) then
        if (GetPlayerHero2(whichPlayer) != null) then
            call RemoveUnit(GetPlayerHero2(whichPlayer))
            call SetPlayerHero2(whichPlayer, null)
        endif
    elseif (GetPlayerSelectionHeroType(whichPlayer) == PLAYER_SELECTION_HERO_TYPE_3) then
        if (GetPlayerHero3(whichPlayer) != null) then
            call RemoveUnit(GetPlayerHero3(whichPlayer))
            call SetPlayerHero3(whichPlayer, null)
        endif
    endif
endfunction

function DisplayPlayerSelectionInfo takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), GetLocalizedString("PLAYER_SELECTION_INFO"))
endfunction

function DisplayPlayerSelectionStart takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("PLAYER_SELECTION_START"))
endfunction

function DisplayPlayerSelectionStartH2 takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("PLAYER_SELECTION_START_H2"))
endfunction

function DisplayPlayerSelectionStartH3 takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("PLAYER_SELECTION_START_H3"))
endfunction

function DisplayPlayerSelectionHelp takes player whichPlayer returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, GetLocalizedString("PLAYER_SELECTION_HELP"))
endfunction

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
