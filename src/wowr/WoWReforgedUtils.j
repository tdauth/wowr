library WoWReforgedUtils requires TreeUtils, MathUtils, CameraUtils, HeroUtils, ForceUtils, SelectionUtils, AttackRange, StringUtils, CopyGroup, Aura, Crafting, UnitGroupRespawnSystem, MassSpell, WoWReforgedI18n
/*
function GetNpcName takes unit hero returns string
    return GetUnitNameByType(GetUnitTypeId(hero), GetOwningPlayer(hero))
endfunction
UnitTypeUtils
*/
globals
    constant boolean MAP_DEBUG_MODE_ENABLED = false // Disable for releases.
endglobals

//! textmacro DEBUG_MODE_CHECK
static if (not MAP_DEBUG_MODE_ENABLED) then
    // Disable this library SCOPE_PREFIX in debug mode!
endif
//! endtextmacro

function UnitMessage takes unit whichUnit, string message returns nothing
    call ShowFadingTextTagForForce(bj_FORCE_PLAYER[GetPlayerId(GetOwningPlayer(whichUnit))], message, 0.016, GetUnitActualX(whichUnit), GetUnitActualY(whichUnit), 255, 255, 255, 255, 0.0355, 1.0, 2.0)
endfunction

function SummonUnitEffect takes unit whichUnit returns nothing
    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", GetUnitX(whichUnit), GetUnitY(whichUnit)))
endfunction

function GiveHeroRangeAttack takes unit hero, integer index returns nothing
    call BlzSetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, index, 1)
    call BlzSetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED, index, BlzBitOr(GetHandleId(TARGET_FLAG_GROUND), BlzBitOr(GetHandleId(TARGET_FLAG_AIR), BlzBitOr(GetHandleId(TARGET_FLAG_STRUCTURE), BlzBitOr(GetHandleId(TARGET_FLAG_WARD), BlzBitOr(GetHandleId(TARGET_FLAG_ITEM), GetHandleId(TARGET_FLAG_DEBRIS)))))))
    call BlzSetUnitWeaponStringField(hero, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, index, "Abilities\\Weapons\\Arrow\\ArrowMissile.mdl")
    call BlzSetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED, index, 900.0)
    call BlzSetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC, index, 0.150)
    call SetUnitAttackRange(hero, 600.0)
    call SetUnitAcquireRange(hero, 600.0)
endfunction

function GiveHeroMeleeAttack takes unit hero, integer index returns nothing
    call BlzSetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, index, 5)
    call BlzSetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED, index, BlzBitOr(GetHandleId(TARGET_FLAG_GROUND), BlzBitOr(GetHandleId(TARGET_FLAG_DEBRIS), BlzBitOr(GetHandleId(TARGET_FLAG_STRUCTURE), BlzBitOr(GetHandleId(TARGET_FLAG_WARD), GetHandleId(TARGET_FLAG_ITEM))))))
    call BlzSetUnitWeaponStringField(hero, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, index, "")
    call BlzSetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED, index, 0.0)
    call BlzSetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC, index, 0.0)
    call SetUnitAttackRange(hero, 90.0)
endfunction

function PlayerHasFaction takes player whichPlayer, integer team returns boolean
    if (team == TEAM_NONE) then
        return true
    endif
    return GetPlayerTeam(whichPlayer) == team
endfunction

function GetFactionName takes integer team returns string
    if (team == TEAM_ALLIANCE) then
        return GetLocalizedString("ALLIANCE")
    elseif (team == TEAM_HORDE) then
        return GetLocalizedString("HORDE")
    endif
    return GetLocalizedString("NONE")
endfunction

function PlayerIsAlliance takes player whichPlayer returns boolean
    return GetPlayerTeam(whichPlayer) == TEAM_ALLIANCE
endfunction

function PlayerIsHorde takes player whichPlayer returns boolean
    return GetPlayerTeam(whichPlayer) == TEAM_HORDE
endfunction

private function IsTownHallFilter takes nothing returns boolean
    return IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL) and IsUnitAliveBJ(GetFilterUnit())
endfunction

function SelectNextTownHall takes player whichPlayer returns unit
    local group halls = CreateGroup()
    local unit result = null
    call GroupEnumUnitsOfPlayer(halls, whichPlayer, Filter(function IsTownHallFilter))
    set result = GetNextUnitToSelect(halls, whichPlayer)
    call GroupClear(halls)
    call DestroyGroup(halls)
    set halls = null
    
    if (result != null) then
        call SelectUnitForPlayerSingle(result, whichPlayer)
        call SmartCameraPanToUnit(whichPlayer, result, 0.0)
    else
        call SimError(whichPlayer, GetLocalizedString("NO_TOWN_HALLS"))
    endif
    
    return result
endfunction

function SetTechMaxAllowed takes integer id, integer maximum returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call SetPlayerTechMaxAllowed(Player(i), id, maximum)
        set i = i + 1
    endloop
endfunction

function FilterPlayerFunctionUsedUser takes nothing returns boolean
    return GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER and GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING
endfunction

globals
    private boolean initialized = false
    private boolean isInSinglePlayer = true
endglobals

function IsInSinglePlayer takes nothing returns boolean
    // cache it to avoid too many calls since it won't change during the game
    if (not initialized) then
        //return CountPlayersInForceBJ(GetPlayersMatching(Condition(function FilterPlayerFunctionUsedUser))) == 1
        // https://www.hiveworkshop.com/threads/how-to-detect-single-player.161490/
        // https://www.hiveworkshop.com/threads/how-to-detect-single-player.161490/#post-1512734
        // Even works when all players except one have left the game:
        set isInSinglePlayer = ReloadGameCachesFromDisk()
        set initialized = true
    endif
    
    return isInSinglePlayer
endfunction

function GetUnitBaseLevel takes unit whichUnit returns integer
    return GetUnitLevelByType(GetUnitTypeId(whichUnit), GetOwningPlayer(whichUnit))
endfunction

function IsPlayerFreelancer takes player whichPlayer returns boolean
    return not udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
endfunction

function IsPlayerWarlord takes player whichPlayer returns boolean
    return udg_PlayerIsWarlord[GetConvertedPlayerId(whichPlayer)]
endfunction

function PlayerHasUnlockedRace takes player whichPlayer, integer whichRace returns boolean
    local integer convertedPlayerId = GetConvertedPlayerId(whichPlayer)
    return whichRace == udg_RaceNone or udg_PlayerUnlockedAllRaces[convertedPlayerId] or whichRace == udg_PlayerRace[convertedPlayerId] or whichRace == udg_PlayerRace2[convertedPlayerId] or udg_UnlockedAll
endfunction

function SetPlayerHero1 takes player whichPlayer, unit hero returns nothing
    set udg_Hero[GetPlayerId(whichPlayer)] = hero
    set udg_Held[GetConvertedPlayerId(whichPlayer)] = hero
endfunction

function GetPlayerHero1 takes player whichPlayer returns unit
    return udg_Hero[GetPlayerId(whichPlayer)]
endfunction

function SetPlayerHero2 takes player whichPlayer, unit hero returns nothing
    set udg_Hero2[GetPlayerId(whichPlayer)] = hero
    set udg_Held2[GetConvertedPlayerId(whichPlayer)] = hero
endfunction

function GetPlayerHero2 takes player whichPlayer returns unit
    return udg_Hero2[GetPlayerId(whichPlayer)]
endfunction

function SetPlayerHero3 takes player whichPlayer, unit hero returns nothing
    set udg_Hero3[GetPlayerId(whichPlayer)] = hero
    set udg_Held3[GetConvertedPlayerId(whichPlayer)] = hero
endfunction

function GetPlayerHero3 takes player whichPlayer returns unit
    return udg_Hero3[GetPlayerId(whichPlayer)]
endfunction

function GetLivingPlayerHero takes player whichPlayer returns unit
    if (GetPlayerHero1(whichPlayer) != null and IsUnitAliveBJ(GetPlayerHero1(whichPlayer))) then
        return GetPlayerHero1(whichPlayer)
    endif
    
    if (GetPlayerHero2(whichPlayer) != null and IsUnitAliveBJ(GetPlayerHero2(whichPlayer))) then
        return GetPlayerHero2(whichPlayer)
    endif
    
    if (GetPlayerHero3(whichPlayer) != null and IsUnitAliveBJ(GetPlayerHero3(whichPlayer))) then
        return GetPlayerHero3(whichPlayer)
    endif
    
    return GetPlayerHero1(whichPlayer)
endfunction

function IsPlayerHero1 takes unit hero returns boolean
    return GetPlayerHero1(GetOwningPlayer(hero)) == hero
endfunction

function IsPlayerHero takes unit hero returns boolean
    local player owner = GetOwningPlayer(hero)
    local boolean result = GetPlayerHero1(owner) == hero or GetPlayerHero2(owner) == hero or GetPlayerHero3(owner) == hero
    set owner = null
    return result
endfunction

function GetPlayerHeroes takes player whichPlayer returns group
    local group heroes = CreateGroup()

    if (GetPlayerHero1(whichPlayer) != null) then
        call GroupAddUnit(heroes, GetPlayerHero1(whichPlayer))
    endif

    if (GetPlayerHero2(whichPlayer) != null) then
        call GroupAddUnit(heroes, GetPlayerHero2(whichPlayer))
    endif

    if (GetPlayerHero3(whichPlayer) != null) then
        call GroupAddUnit(heroes, GetPlayerHero3(whichPlayer))
    endif

    return heroes
endfunction

function GetPlayerHeroIndex takes player whichPlayer, unit hero returns integer
    if (GetPlayerHero1(whichPlayer) == hero) then
        return 0
    elseif (GetPlayerHero2(whichPlayer) == hero) then
        return 1
    elseif (GetPlayerHero3(whichPlayer) == hero) then
        return 2
    endif
    
    return -1
endfunction

function GetPlayerHeroByIndex takes player whichPlayer, integer index returns unit
    if (index == 0) then
        return GetPlayerHero1(whichPlayer)
    elseif (index == 1) then
        return GetPlayerHero2(whichPlayer)
    elseif (index == 2) then
        return GetPlayerHero3(whichPlayer)
    endif
    
    return GetPlayerHero1(whichPlayer)
endfunction

function GetSelectedForce takes unit hero returns force
    local force whichForce = CreateForce()
    call ForceAddSelectingUsers(whichForce, hero)
    return whichForce
endfunction

function GetLivingHero takes player whichPlayer returns unit
    if (IsUnitAliveBJ(GetPlayerHero1(whichPlayer))) then
        return GetPlayerHero1(whichPlayer)
    elseif (IsUnitAliveBJ(GetPlayerHero2(whichPlayer))) then
        return GetPlayerHero2(whichPlayer)
    elseif (IsUnitAliveBJ(GetPlayerHero3(whichPlayer))) then
        return GetPlayerHero3(whichPlayer)
    endif
    
    return GetPlayerHero1(whichPlayer)
endfunction

function GetHeroLevelMaxXP takes integer heroLevel returns integer
    local integer result = 0 // level 1 XP
    local integer i = 3
    loop
        exitwhen (i > heroLevel + 1)
        set result = result + i * 1000
        set i = i + 1
    endloop
    return result
endfunction

function GetHeroLevelByXP takes integer xp returns integer
    local integer heroLevel = 1
    local integer i = 3
    loop
        set xp = xp - i * 1000
        exitwhen (xp < 0)
        set heroLevel = heroLevel + 1
        set i = i + 1
    endloop
    return heroLevel
endfunction

function GetHeroLevel1 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held[playerId] != null) then
        return GetHeroLevel(udg_Held[playerId])
    endif

    return GetHeroLevelByXP(udg_CharacterStartXP[playerId])
endfunction

function GetHeroXP1 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held[playerId] != null) then
        return GetHeroXP(udg_Held[playerId])
    endif

    return udg_CharacterStartXP[playerId]
endfunction

function AddHeroXP1 takes player whichPlayer, integer xpToAdd, boolean showEyeCandy returns nothing
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held[playerId] != null) then
        call AddHeroXP(udg_Held[playerId], xpToAdd, showEyeCandy)
    else
        set udg_CharacterStartXP[playerId] = udg_CharacterStartXP[playerId] + xpToAdd
    endif
endfunction

function GetHeroLevel2 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held2[playerId] != null) then
        return GetHeroLevel(udg_Held2[playerId])
    endif

    return GetHeroLevelByXP(udg_Held2XP[playerId])
endfunction

function GetHeroXP2 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held2[playerId] != null) then
        return GetHeroXP(udg_Held2[playerId])
    endif

    return udg_Held2XP[playerId]
endfunction

function AddHeroXP2 takes player whichPlayer, integer xpToAdd, boolean showEyeCandy returns nothing
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held2[playerId] != null) then
        call AddHeroXP(udg_Held2[playerId], xpToAdd, showEyeCandy)
    else
        set udg_Held2XP[playerId] = udg_Held2XP[playerId] + xpToAdd
    endif
endfunction

function GetHeroLevel3 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held3[playerId] != null) then
        return GetHeroLevel(udg_Held3[playerId])
    endif

    return GetHeroLevelByXP(udg_Held3XP[playerId])
endfunction

function GetHeroXP3 takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held3[playerId] != null) then
        return GetHeroXP(udg_Held3[playerId])
    endif

    return udg_Held3XP[playerId]
endfunction

function AddHeroXP3 takes player whichPlayer, integer xpToAdd, boolean showEyeCandy returns nothing
    local integer playerId = GetConvertedPlayerId(whichPlayer)

    if (udg_Held3[playerId] != null) then
        call AddHeroXP(udg_Held3[playerId], xpToAdd, showEyeCandy)
    else
        set udg_Held3XP[playerId] = udg_Held3XP[playerId] + xpToAdd
    endif
endfunction

function GetHighestHeroLevel takes player whichPlayer returns integer
    local integer heroLevel1 = GetHeroLevel1(whichPlayer)
    local integer heroLevel2 = GetHeroLevel2(whichPlayer)
    local integer heroLevel3 = GetHeroLevel3(whichPlayer)

    if (heroLevel1 >= heroLevel2 and heroLevel1 >= heroLevel3) then
        return heroLevel1
    elseif (heroLevel2 >= heroLevel1 and heroLevel2 >= heroLevel3) then
        return heroLevel2
    endif

    return heroLevel3
endfunction

function GetHighestHeroLevelFromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetHighestHeroLevel(whichPlayer)
            if (heroLevel > result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function GetLowestHeroLevel takes player whichPlayer returns integer
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    local integer heroLevel1 = GetHeroLevel1(whichPlayer)
    local integer heroLevel2 = GetHeroLevel2(whichPlayer)
    local integer heroLevel3 = GetHeroLevel3(whichPlayer)

    if (heroLevel1 < heroLevel2 and heroLevel1 < heroLevel3) then
        return heroLevel1
    elseif (heroLevel2 < heroLevel1 and heroLevel2 < heroLevel3) then
        return heroLevel2
    endif

    return heroLevel3
endfunction

function GetLowestHeroLevelFromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetLowestHeroLevel(whichPlayer)
            if (heroLevel < result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function GetLowestHeroLevel1FromAllPlayingUsers takes nothing returns integer
    local player whichPlayer = null
    local integer heroLevel = 0
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set whichPlayer = Player(i)
        if (GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            set heroLevel = GetHeroLevel1(whichPlayer)
            if (result == 0 or heroLevel < result) then
                set result = heroLevel
            endif
        endif
        set whichPlayer = null
        set i = i + 1
    endloop
    return result
endfunction

function DropAllItemsFromHero1 takes player whichPlayer returns integer
    return DropAllItemsFromHero(udg_Hero[GetPlayerId(whichPlayer)])
endfunction

function DropAllItemsFromHero2 takes player whichPlayer returns integer
    return DropAllItemsFromHero(udg_Hero2[GetPlayerId(whichPlayer)])
endfunction

function DropAllItemsFromHero3 takes player whichPlayer returns integer
    return DropAllItemsFromHero(udg_Hero3[GetPlayerId(whichPlayer)])
endfunction

function IsHauntedGoldMine takes integer unitTypeId returns boolean
    if (unitTypeId == UNDEAD_MINE) then
        return true
    elseif (unitTypeId == ELF_MINE) then
        return true
    elseif (unitTypeId == DWARF_MINE) then
        return true
    elseif (unitTypeId == DWARF_MINE_2) then
        return true
    elseif (unitTypeId == DWARF_MINE_3) then
        return true
    elseif (unitTypeId == DALARAN_MINE) then
        return true
    elseif (unitTypeId == SATYR_MINE) then
        return true
    endif
    
    return false
endfunction

function IsUnitTypeNavyHero takes integer unitTypeId returns boolean
    if (unitTypeId == GNOMISH_SUBMARINE_HERO) then
        return true
    elseif (unitTypeId == GNOMISH_SUBMARINE_HERO_PILOT) then
        return true
    elseif (unitTypeId == GOBLIN_SUBMARINE_HERO) then
        return true
    elseif (unitTypeId == GOBLIN_SUBMARINE_HERO_SUBMERGED) then
        return true
    elseif (unitTypeId == DWARF_SUBMARINE_HERO) then
        return true
    elseif (unitTypeId == DWARF_SUBMARINE_HERO_SUBMERGED) then
        return true
    elseif (unitTypeId == HUMAN_BATTLESHIP_HERO) then
        return true
    elseif (unitTypeId == CAPTAIN_HERO) then
        return true
    endif
    return false
endfunction

private function FilterFunctionIsHauntedGoldMine takes nothing returns boolean
    return IsHauntedGoldMine(GetUnitTypeId(GetFilterUnit()))
endfunction

private function ForFunctionKillUnit takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function KillAllHauntedGoldMines takes player whichPlayer returns nothing
    set bj_wantDestroyGroup = true
    call ForGroupBJ(GetUnitsOfPlayerMatching(whichPlayer, Filter(function FilterFunctionIsHauntedGoldMine)), function ForFunctionKillUnit)
endfunction

function EnumLivingTreeDestructablesInCircleFilter takes nothing returns boolean
    local boolean result = IsDestructableAliveBJ(GetFilterDestructable()) and IsDestructableTree(GetFilterDestructable())
    local location destLoc = null

    if (result) then
        set destLoc = GetDestructableLoc(GetFilterDestructable())
        set result = DistanceBetweenPoints(destLoc, bj_enumDestructableCenter) <= bj_enumDestructableRadius
        call RemoveLocation(destLoc)
        set destLoc = null
    endif

    return result
endfunction

function RandomLivingTreeDestructableInCircle takes real radius, location loc returns destructable
    local boolexpr whichFilter= Filter(function EnumLivingTreeDestructablesInCircleFilter)
    local rect r

    if (radius >= 0) then
        set bj_enumDestructableCenter = loc
        set bj_enumDestructableRadius = radius
        set bj_destRandomConsidered = 0
        set bj_destRandomCurrentPick = null
        set r = GetRectFromCircleBJ(loc, radius)
        call EnumDestructablesInRect(r, whichFilter, function RandomDestructableInRectBJEnum)
        call RemoveRect(r)
        set r = null
    endif

    call DestroyBoolExpr(whichFilter)
    set whichFilter = null

    return bj_destRandomCurrentPick
endfunction

function IsWall takes integer buildingId returns boolean
    return buildingId == WALL
endfunction

globals
    private player tmpPlayer = null
endglobals

private function FilterIsGivableUnit takes nothing returns boolean
    return GetOwningPlayer(GetFilterUnit()) == tmpPlayer and not IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) and not  IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetFilterUnit(), UNIT_TYPE_PEON) and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') <= 0
endfunction

function UpdateGiveUnitsForPlayer takes player whichPlayer, real x, real y returns nothing
    local integer playerId = GetConvertedPlayerId(whichPlayer)
    set tmpPlayer = whichPlayer
    call GroupClear(udg_GivenUnitsToFreelancer[playerId])
    call GroupEnumUnitsInRange(udg_GivenUnitsToFreelancer[playerId], x, y, 512.0, Filter(function FilterIsGivableUnit))
endfunction

function DisplayNewBonusConfig takes nothing returns nothing
static if NewBonus_EXTENDED then
    call BJDebugMsg("NewBonus EXTENDED: on")
else
    call BJDebugMsg("NewBonus EXTENDED: off")
endif

static if LIBRARY_DamageInterface then
    call BJDebugMsg("DamageInterface: on")
else
    call BJDebugMsg("DamageInterface: off")
endif

static if LIBRARY_Evasion then
    call BJDebugMsg("Evasion: on")
else
    call BJDebugMsg("Evasion: off")
endif

static if LIBRARY_CriticalStrike then
    call BJDebugMsg("CriticalStrike: on")
else
    call BJDebugMsg("CriticalStrike: off")
endif

static if LIBRARY_SpellPower then
    call BJDebugMsg("SpellPower: on")
else
    call BJDebugMsg("SpellPower: off")
endif

static if LIBRARY_LifeSteal then
    call BJDebugMsg("LifeSteal: on")
else
    call BJDebugMsg("LifeSteal: off")
endif

static if LIBRARY_SpellVamp then
    call BJDebugMsg("SpellVamp: on")
else
    call BJDebugMsg("SpellVamp: off")
endif

static if LIBRARY_Tenacity then
    call BJDebugMsg("Tenacity: on")
else
    call BJDebugMsg("Tenacity: off")
endif
endfunction

function DisplayUnitRespawnInfo takes unit whichUnit, player whichPlayer returns nothing
    local integer unitIndex = GetUnitRespawnUnitIndex(whichUnit)
    local integer groupIndex = -1
    if (IsRespawnUnitValid(unitIndex)) then
        set groupIndex = GetRespawnUnitGroupIndex(unitIndex)
    endif
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, "Unit respawn index: " + I2S(unitIndex) + "\nUnit group index: " + I2S(groupIndex))
endfunction

endlibrary
