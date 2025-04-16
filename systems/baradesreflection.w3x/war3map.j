globals
//globals from MathUtils:
constant boolean LIBRARY_MathUtils=true
//endglobals from MathUtils
//globals from Reflection:
constant boolean LIBRARY_Reflection=true
constant integer Reflection_ABILITY_ID= 'A000'
constant integer Reflection_DUMMY_UNIT_TYPE_ID= 'h000'
constant integer Reflection_BASE_CHANCE= 30
constant integer Reflection_LEVEL_CHANCE= 10
constant integer Reflection_BASE_PERCENTAGE= 100
constant integer Reflection_LEVEL_PERCENTAGE= 0
trigger Reflection___damageTrigger= CreateTrigger()
//endglobals from Reflection
    // Generated
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null

trigger l__library_init

//JASSHelper struct globals:

endglobals


//library MathUtils:

function Index2D takes integer v1,integer v2,integer max2 returns integer
    return v1 * max2 + v2
endfunction

function Index3D takes integer v1,integer v2,integer v3,integer max2,integer max3 returns integer
    return v1 * max2 * max3 + v2 * max3 + v3
endfunction

function PolarProjectionX takes real x,real angle,real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function PolarProjectionY takes real y,real angle,real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function AngleBetweenCoordinatesRad takes real x1,real y1,real x2,real y2 returns real
    return Atan2(y2 - y1, x2 - x1)
endfunction

// Utilities already uses the identifier AngleBetweenCoordinates.
function AngleBetweenCoordinatesDeg takes real x1,real y1,real x2,real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

function AngleBetweenUnitsDeg takes unit whichUnit0,unit whichUnit1 returns real
    return AngleBetweenCoordinatesDeg(GetUnitX(whichUnit0) , GetUnitY(whichUnit0) , GetUnitX(whichUnit1) , GetUnitY(whichUnit1))
endfunction

// Utilities already uses the identifier DistanceBetweenCoordinates.
function DistBetweenCoordinates takes real x1,real y1,real x2,real y2 returns real
    local real dx= x2 - x1
    local real dy= y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

function DistanceBetweenUnits takes unit whichUnit0,unit whichUnit1 returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit0) , GetUnitY(whichUnit0) , GetUnitX(whichUnit1) , GetUnitY(whichUnit1))
endfunction

function DistanceBetweenUnitAndItem takes unit whichUnit,item whichItem returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit) , GetUnitY(whichUnit) , GetItemX(whichItem) , GetItemY(whichItem))
endfunction

function DistanceBetweenUnitAndDestructable takes unit whichUnit,destructable whichDestructable returns real
    return DistBetweenCoordinates(GetUnitX(whichUnit) , GetUnitY(whichUnit) , GetDestructableX(whichDestructable) , GetDestructableY(whichDestructable))
endfunction

function IntToPrecentage takes integer v,integer max returns real
    return I2R(v) * 100.0 / I2R(max)
endfunction

function GetRectFromCircle takes real centerX,real centerY,real radius returns rect
    return Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
endfunction


//library MathUtils ends
//library Reflection:


function Reflect takes unit whichUnit,unit source,real damage returns nothing
    local unit dummy= CreateUnit(GetOwningPlayer(whichUnit), Reflection_DUMMY_UNIT_TYPE_ID, GetUnitX(whichUnit), GetUnitY(whichUnit), AngleBetweenUnitsDeg(whichUnit , source))

    call SetUnitState(whichUnit, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE) + damage)

    call BlzSetUnitWeaponStringField(dummy, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0, BlzGetUnitWeaponStringField(source, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE, 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE, 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE, 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE, 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE, 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE, 0))
    call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS, 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS, 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE               , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE               , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND              , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND              , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS                  , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS                  , 0))
    //call BlzSetUnitWeaponIntegerField(dummy, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED                         , 0, BlzGetUnitWeaponIntegerField(source, UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED                         , 0))
    
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT                            , 0))
    
    call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0))
    call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR, 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR, 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE                            , 0))
    //call BlzSetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS                            , 0, BlzGetUnitWeaponRealField(source, UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS                            , 0))

    //call BlzSetUnitAttackCooldown(dummy, BlzGetUnitAttackCooldown(dummy, 0), 0)
    
    //call SetUnitAnimation(whichUnit, "Parry")
    //call SetUnitAnimationByIndex(whichUnit, 8)
    call IssueTargetOrder(dummy, "attack", source)
    
    call TriggerSleepAction(BlzGetUnitWeaponRealField(dummy, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0))
    call RemoveUnit(dummy)
    set dummy=null
endfunction

function Reflection___TriggerConditionDamage takes nothing returns boolean
    local integer level= GetUnitAbilityLevel(GetTriggerUnit(), Reflection_ABILITY_ID)
    return level > 0 and BlzGetEventWeaponType() == WEAPON_TYPE_WHOKNOWS and GetRandomInt(0, 100) <= Reflection_BASE_CHANCE + level * Reflection_LEVEL_CHANCE
endfunction

function Reflection___TriggerActionDamage takes nothing returns nothing
    local integer level= GetUnitAbilityLevel(GetTriggerUnit(), Reflection_ABILITY_ID)
    call Reflect(GetTriggerUnit() , GetEventDamageSource() , GetEventDamage() * I2R(Reflection_BASE_PERCENTAGE + level * Reflection_LEVEL_PERCENTAGE) / 100)
endfunction

function Reflection___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(Reflection___damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddCondition(Reflection___damageTrigger, Condition(function Reflection___TriggerConditionDamage))
    call TriggerAddAction(Reflection___damageTrigger, function Reflection___TriggerActionDamage)
endfunction


//library Reflection ends
//===========================================================================
// 
// Baradé's Reflection 1.0
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: Baradé
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades Math Utils
//***************************************************************************
//*  Barades Reflection

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'E000', - 70.7, - 48.1, 270.000, 'E000')
    call SetHeroLevel(u, 10, false)
    call SetUnitState(u, UNIT_STATE_MANA, 510)
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOww')
    call SelectHeroSkill(u, 'AUdd')
    set u=BlzCreateUnitWithSkin(p, 'earc', - 242.2, 320.6, 273.205, 'earc')
    set u=BlzCreateUnitWithSkin(p, 'earc', - 369.3, 324.5, 356.979, 'earc')
    set u=BlzCreateUnitWithSkin(p, 'earc', - 363.0, 488.6, 55.219, 'earc')
    set u=BlzCreateUnitWithSkin(p, 'earc', - 250.4, 486.5, 271.777, 'earc')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'E000', 79.2, - 36.3, 270.000, 'E000')
    call SetHeroLevel(u, 10, false)
    call SetUnitState(u, UNIT_STATE_MANA, 510)
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AEmb')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOws')
    call SelectHeroSkill(u, 'AOww')
    call SelectHeroSkill(u, 'AUdd')
endfunction

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nbrg', - 235.0, - 1317.1, 90.000, 'nbrg')
    set u=BlzCreateUnitWithSkin(p, 'nbrg', 84.0, - 1333.7, 90.000, 'nbrg')
    set u=BlzCreateUnitWithSkin(p, 'nbrg', 295.1, - 1292.6, 90.000, 'nbrg')
    set u=BlzCreateUnitWithSkin(p, 'nbrg', - 52.7, - 1293.9, 90.000, 'nbrg')
    set u=BlzCreateUnitWithSkin(p, 'nass', - 125.8, - 1462.4, 90.000, 'nass')
    set u=BlzCreateUnitWithSkin(p, 'nass', 139.9, - 1484.0, 90.000, 'nass')
    set u=BlzCreateUnitWithSkin(p, 'nass', 283.1, - 1473.2, 90.000, 'nass')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 319.9, - 1460.0, 90.000, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', 464.0, - 1443.2, 90.000, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nele', - 381.2, - 1275.0, 90.000, 'nele')
    set u=BlzCreateUnitWithSkin(p, 'nele', 453.7, - 1266.5, 90.000, 'nele')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2049.5, - 109.4, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2054.5, - 330.3, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2091.7, - 528.8, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2257.0, - 189.4, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2280.0, - 418.3, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nenf', - 2252.0, - 588.1, 0.000, 'nenf')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 129.8, - 1629.0, 90.000, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', 135.8, - 1651.3, 90.000, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', 377.4, - 1644.8, 90.000, 'nska')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ntav', 64.0, 512.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateNeutralHostile()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func006A takes nothing returns nothing
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(500000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call FogMaskEnableOff()
    call FogEnableOff()
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func006A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_030")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_031")
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(0), true)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    call SetPlayerRaceSelectable(Player(1), true)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_002
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)

    //   Shared Control
    call SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)

    //   Shared Advanced Control
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("Reflection___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_Initialization) // INLINED!!

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_003")
    call SetMapDescription("TRIGSTR_029")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 0.0, - 64.0)
    call DefineStartLocation(1, 0.0, - 64.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

