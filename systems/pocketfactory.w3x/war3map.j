globals
//globals from WorldBounds:
constant boolean LIBRARY_WorldBounds=true
//endglobals from WorldBounds
//globals from PocketFactory:
constant boolean LIBRARY_PocketFactory=true
unit PocketFactory__triggerCaster= null
unit PocketFactory__triggerPocketFactory= null
trigger array PocketFactory__callbackTriggers
integer PocketFactory__callbackTriggersCounter= 0
    
group PocketFactory__casters= CreateGroup()
    
trigger PocketFactory__castTrigger= CreateTrigger()
trigger PocketFactory__enterTrigger= CreateTrigger()
//endglobals from PocketFactory
    // Generated
trigger gg_trg_Melee_Initialization= null
trigger gg_trg_Summon_Pocket_Factory= null
trigger gg_trg_WorldBounds= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__WorldBounds=1
integer s__WorldBounds_maxX
integer s__WorldBounds_maxY
integer s__WorldBounds_minX
integer s__WorldBounds_minY
integer s__WorldBounds_centerX
integer s__WorldBounds_centerY
rect s__WorldBounds_world
region s__WorldBounds_worldRegion
trigger array st___prototype8
unit f__arg_unit1

endglobals

function sc___prototype8_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype8[i])
endfunction
function sc___prototype8_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype8[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: PocketFactory__RemoveUnitHook
    call sc___prototype8_evaluate(1,a0)
call RemoveUnit(a0)
endfunction

//library WorldBounds:
	
		
		
		
		
//Implemented from module WorldBounds__WorldBoundInit:
  function s__WorldBounds_WorldBounds__WorldBoundInit__onInit takes nothing returns nothing
			set s__WorldBounds_world=GetWorldBounds()
			
			set s__WorldBounds_maxX=R2I(GetRectMaxX(s__WorldBounds_world))
			set s__WorldBounds_maxY=R2I(GetRectMaxY(s__WorldBounds_world))
			set s__WorldBounds_minX=R2I(GetRectMinX(s__WorldBounds_world))
			set s__WorldBounds_minY=R2I(GetRectMinY(s__WorldBounds_world))
			
			set s__WorldBounds_centerX=R2I(( s__WorldBounds_maxX + s__WorldBounds_minX ) / 2)
			set s__WorldBounds_centerY=R2I(( s__WorldBounds_minY + s__WorldBounds_maxY ) / 2)
			
			set s__WorldBounds_worldRegion=CreateRegion()
			
			call RegionAddRect(s__WorldBounds_worldRegion, s__WorldBounds_world)
  endfunction

//library WorldBounds ends
//library PocketFactory:


function IsPocketFactoryAbility takes integer id returns boolean
    return id == 'ANsy' or id == 'ANs1' or id == 'ANs2' or id == 'ANs3'
endfunction

function IsPocketFactory takes integer id returns boolean
    return id == 'nfac' or id == 'nfa1' or id == 'nfa2'
endfunction

function IsUnitPocketFactory takes unit whichUnit returns boolean
    return IsPocketFactory(GetUnitTypeId(whichUnit))
endfunction

function GetTriggerPocketFactoryCaster takes nothing returns unit
    return PocketFactory__triggerCaster
endfunction

function GetTriggerPocketFactory takes nothing returns unit
    return PocketFactory__triggerPocketFactory
endfunction

function TriggerRegisterPocketFactorySummon takes trigger whichTrigger returns nothing
    set PocketFactory__callbackTriggers[PocketFactory__callbackTriggersCounter]=whichTrigger
    set PocketFactory__callbackTriggersCounter=PocketFactory__callbackTriggersCounter + 1
endfunction

function PocketFactory__TriggerConditionCast takes nothing returns boolean
    if ( IsPocketFactoryAbility(GetSpellAbilityId()) and not IsUnitInGroup(GetTriggerUnit(), PocketFactory__casters) ) then
        call GroupAddUnit(PocketFactory__casters, GetTriggerUnit())
    endif
    return false
endfunction

function PocketFactory__SummonPocketFactory takes unit factory,unit caster returns nothing
    local integer i= 0
    if ( caster != null ) then
        call GroupRemoveUnit(PocketFactory__casters, caster)
    endif
    loop
        exitwhen ( i == PocketFactory__callbackTriggersCounter )
        if ( IsTriggerEnabled(PocketFactory__callbackTriggers[i]) ) then
            set PocketFactory__triggerCaster=caster
            set PocketFactory__triggerPocketFactory=factory
            call ConditionalTriggerExecute(PocketFactory__callbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function PocketFactory__TriggerConditionEnter takes nothing returns boolean
    if ( (IsPocketFactory(GetUnitTypeId((GetTriggerUnit())))) ) then // INLINED!!
        call PocketFactory__SummonPocketFactory(GetTriggerUnit() , FirstOfGroup(PocketFactory__casters))
    endif
    return false
endfunction

function PocketFactory__Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(PocketFactory__castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(PocketFactory__castTrigger, Condition(function PocketFactory__TriggerConditionCast))
    
    call TriggerRegisterEnterRegion(PocketFactory__enterTrigger, s__WorldBounds_worldRegion, null)
    call TriggerAddCondition(PocketFactory__enterTrigger, Condition(function PocketFactory__TriggerConditionEnter))
endfunction

function PocketFactory__RemoveUnitHook takes unit whichUnit returns nothing
    call GroupRemoveUnit(PocketFactory__casters, whichUnit)
endfunction

//processed hook: hook RemoveUnit PocketFactory__RemoveUnitHook


//library PocketFactory ends
//===========================================================================
// 
// Pocket Factory
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
//*  Barades Pocket Factory

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

    set u=BlzCreateUnitWithSkin(p, 'Ntin', - 310.0, - 188.6, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
    set u=BlzCreateUnitWithSkin(p, 'Ntin', - 477.5, - 191.1, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'Ntin', 52.7, - 181.4, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
    set u=BlzCreateUnitWithSkin(p, 'Ntin', 202.8, - 188.6, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
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
    call CreatePlayerBuildings()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: WorldBounds
//===========================================================================
//===========================================================================
// Trigger: Melee Initialization
//
// Default melee game initialization for all players
//===========================================================================
function Trig_Melee_Initialization_Actions takes nothing returns nothing
    call FogEnableOff()
    call FogMaskEnableOff()
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call MeleeGrantHeroItems()
    call TriggerRegisterPocketFactorySummon(gg_trg_Summon_Pocket_Factory)
endfunction

//===========================================================================
function InitTrig_Melee_Initialization takes nothing returns nothing
    set gg_trg_Melee_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Melee_Initialization, function Trig_Melee_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Summon Pocket Factory
//===========================================================================
function Trig_Summon_Pocket_Factory_Actions takes nothing returns nothing
    call BJDebugMsg("Summon pocket factory " + GetUnitName((PocketFactory__triggerPocketFactory)) + " from caster " + GetUnitName((PocketFactory__triggerCaster))) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Summon_Pocket_Factory takes nothing returns nothing
    set gg_trg_Summon_Pocket_Factory=CreateTrigger()
    call TriggerAddAction(gg_trg_Summon_Pocket_Factory, function Trig_Summon_Pocket_Factory_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_WorldBounds()
    call InitTrig_Melee_Initialization()
    call InitTrig_Summon_Pocket_Factory()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Melee_Initialization)
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
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
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

call ExecuteFunc("jasshelper__initstructs295573937")
call ExecuteFunc("PocketFactory__Init")

    call InitGlobals()
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_Melee_Initialization) // INLINED!!

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_003")
    call SetMapDescription("TRIGSTR_005")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 448.0, - 192.0)
    call DefineStartLocation(1, 128.0, - 192.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype8_PocketFactory__RemoveUnitHook takes nothing returns boolean
    call GroupRemoveUnit(PocketFactory__casters, (f__arg_unit1)) // INLINED!!
    return true
endfunction

function jasshelper__initstructs295573937 takes nothing returns nothing
    set st___prototype8[1]=CreateTrigger()
    call TriggerAddAction(st___prototype8[1],function sa___prototype8_PocketFactory__RemoveUnitHook)
    call TriggerAddCondition(st___prototype8[1],Condition(function sa___prototype8_PocketFactory__RemoveUnitHook))

call ExecuteFunc("s__WorldBounds_WorldBounds__WorldBoundInit__onInit")

endfunction

