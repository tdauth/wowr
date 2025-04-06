globals
//globals from FrameLoader:
constant boolean LIBRARY_FrameLoader=true
trigger FrameLoader___eventTrigger= CreateTrigger()
trigger FrameLoader___actionTrigger= CreateTrigger()
timer FrameLoader___t= CreateTimer()
//endglobals from FrameLoader
//globals from GetSingleSelectedUnit:
constant boolean LIBRARY_GetSingleSelectedUnit=true
//endglobals from GetSingleSelectedUnit
//globals from ItemTypeUtils:
constant boolean LIBRARY_ItemTypeUtils=true
    // Barade: Cache all the values for better performance.
hashtable ItemTypeUtils___h= InitHashtable()
    
constant integer ItemTypeUtils___SHOP= 'ngme'
constant integer ItemTypeUtils___SELL_UNIT= 'Hpal'
constant real ItemTypeUtils___PAWN_ITEM_RATE= 0.6
    
constant integer ItemTypeUtils___KEY_VALUE_GOLD= 0
constant integer ItemTypeUtils___KEY_VALUE_LUMBER= 1
constant integer ItemTypeUtils___KEY_PERISHABLE= 2
constant integer ItemTypeUtils___KEY_MODEL= 3
constant integer ItemTypeUtils___KEY_ICON= 4
//endglobals from ItemTypeUtils
//globals from MathUtils:
constant boolean LIBRARY_MathUtils=true
//endglobals from MathUtils
//globals from OnStartGame:
constant boolean LIBRARY_OnStartGame=true
trigger OnStartGame___startGameTrigger= CreateTrigger()
//endglobals from OnStartGame
//globals from RegisterNativeEvent:
constant boolean LIBRARY_RegisterNativeEvent=true
integer RegisterNativeEvent___eventIndex= 500
//endglobals from RegisterNativeEvent
//globals from RegisterPlayerUnitEvent:
constant boolean LIBRARY_RegisterPlayerUnitEvent=true
trigger array RegisterPlayerUnitEvent___t
//endglobals from RegisterPlayerUnitEvent
//globals from SimError:
constant boolean LIBRARY_SimError=true
sound SimError___error
//endglobals from SimError
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from UnitCost:
constant boolean LIBRARY_UnitCost=true
constant integer UnitCost_HERO_GOLD_COST= 0
constant integer UnitCost_HERO_WOOD_COST= 0
//endglobals from UnitCost
//globals from WorldBounds:
constant boolean LIBRARY_WorldBounds=true
//endglobals from WorldBounds
//globals from PlayerColorUtils:
constant boolean LIBRARY_PlayerColorUtils=true
string array PlayerColorUtils___PlayerColorNames
//endglobals from PlayerColorUtils
//globals from Refund:
constant boolean LIBRARY_Refund=true
//endglobals from Refund
//globals from StringFormat:
constant boolean LIBRARY_StringFormat=true
//endglobals from StringFormat
//globals from UnitDex:
constant boolean LIBRARY_UnitDex=true
        // Event types
constant integer EVENT_UNIT_INDEX= 0
constant integer EVENT_UNIT_DEINDEX= 1
      
        // System variables
trigger array UnitDex___IndexTrig
integer UnitDex___Index= 0
real UnitDex___E=- 1
boolexpr UnitDex___FilterEnter
//endglobals from UnitDex
//globals from Resources:
constant boolean LIBRARY_Resources=true
constant real Resources_GOLD_GOLD_EXCHANGE_RATE= 1.0
constant real Resources_LUMBER_GOLD_EXCHANGE_RATE= 2.0
constant real Resources_FOOD_GOLD_EXCHANGE_RATE= 0.0
constant real Resources_FOOD_MAX_GOLD_EXCHANGE_RATE= 0.0
constant string Resources_GOLD_ICON= "UI\\Feedback\\Resources\\ResourceGold.blp"
constant string Resources_GOLD_ICON_ATT= "UI\\Widgets\\Console\\Human\\infocard-gold.blp"
constant string Resources_LUMBER_ICON= "UI\\Feedback\\Resources\\ResourceLumber.blp"
constant string Resources_LUMBER_ICON_ATT= "UI\\Feedback\\Resources\\ResourceLumber.blp"
constant string Resources_FOOD_ICON= "UI\\Feedback\\Resources\\ResourceSupply.blp"
constant string Resources_FOOD_ICON_ATT= "UI\\Widgets\\Console\\Human\\infocard-supply.blp"
constant string Resources_FOOD_MAX_ICON= "UI\\Feedback\\Resources\\ResourceSupply.blp"
constant string Resources_FOOD_MAX_ICON_ATT= "UI\\Widgets\\Console\\Human\\infocard-supply.blp"
    
hashtable Resources___h= InitHashtable()
trigger Resources___castTrigger= CreateTrigger()
trigger Resources___orderTrigger= CreateTrigger()
trigger Resources___orderResetTrigger= CreateTrigger()
trigger Resources___returnTrigger= CreateTrigger()
trigger Resources___deathTrigger= CreateTrigger()
group Resources___mines= CreateGroup()
group Resources___workers= CreateGroup()
group Resources___returnBuildings= CreateGroup()
    
    // callbacks
trigger array Resources___callbackTriggers
integer Resources___callbackTriggersCounter= 0
trigger array Resources___callbackReturnTriggers
integer Resources___callbackReturnTriggersCounter= 0
trigger array Resources___callbackDeathTriggers
integer Resources___callbackDeathTriggersCounter= 0
unit Resources___triggerMine= null
unit Resources___triggerReturnBuilding= null
unit Resources___triggerDyingResourceUnit= null
unit Resources___triggerWorker= null
integer Resources___triggerResource= 0
integer Resources___triggerResourceAmount= 0
    
constant integer Resources___KEY_RESOURCE= 0
constant integer Resources___KEY_MAX_RESOURCE= 1
constant integer Resources___KEY_RESOURCE_PER_HIT= 2
constant integer Resources___KEY_MINE= 3
constant integer Resources___KEY_RETURN_RESOURCE= 4
constant integer Resources___KEY_HARVEST_ORDER_ID= 5
constant integer Resources___KEY_HARVEST_ABILITY_ID= 6
constant integer Resources___KEY_RETURN_ORDER_ID= 7
constant integer Resources___KEY_RETURN_ABILITY_ID= 8
constant integer Resources___KEY_RETURN_HIDDEN_ORDER_ID= 9
constant integer Resources___KEY_RETURN_HIDDEN_ABILITY_ID= 10
constant integer Resources___KEY_HARVEST_DURATION= 11
constant integer Resources___KEY_EXPLODE_ON_DEATH= 12
constant integer Resources___KEY_MINE_WORKERS= 13
constant integer Resources___KEY_MAX_MINE_WORKERS= 14
constant integer Resources___KEY_TAKE_WORKER_INSIDE= 15
constant integer Resources___KEY_ANIMATION_PROPERTIES= 16
constant integer Resources___KEY_SKIN= 17
constant integer Resources___KEY_QUEUE_TIMER= 18
constant integer Resources___KEY_QUEUE_WORKER_RELEASE_TIMER= 19
constant integer Resources___KEY_DISABLE_STOP_MINING_ON_ERROR= 20
constant integer Resources___KEY_MAX= 21
integer Resources_GOLD= 0
integer Resources_LUMBER= 0
integer Resources_FOOD= 0
integer Resources_FOOD_MAX= 0
unit Resources___filterWorker= null
integer Resources___filterResource= 0
//endglobals from Resources
//globals from UnitEventEx:
constant boolean LIBRARY_UnitEventEx=true
    
    // CONFIGURATION
    
    // the transform detection ability. If DETECT_TRANSFORM is false, this is not needed.
constant integer UnitEventEx___DETECT_TRANSFORM_ABILITY= 'UEdt'
    
    // toggles the detection of transform events.
constant boolean UnitEventEx___DETECT_TRANSFORM= false
    
    // toggles the detection of load/unload of cargo units, except for dead units (eg Meat Wagon's Exhume Corpse)
constant boolean UnitEventEx___DETECT_CARGO= true
    
    // toggles the detection of unloading dead units in cargo (Exhume Corpse). Does nothing if DETECT_CARGO is false.
constant boolean UnitEventEx___DETECT_CARGO_DEAD= true
    
    // toggles the detection of when a unit begins and finishes reincarnating.
constant boolean UnitEventEx___DETECT_REINCARNATION= true
    
    // toggles the detection of when a unit is animated via animate dead.
constant boolean UnitEventEx___DETECT_ANIMATE_DEAD= true
    
    // toggles the detection of units that are brought back to life via resurrection.
constant boolean UnitEventEx___DETECT_RESURRECTION= false
    
    // this overrides reincarnation, animate dead and resurrection. Set to true if you want any of these events to work.
    // for some reason setting DETECT_REVIVES = (DETECT_REINCARNATION or DETECT_ANIMATE_DEAD or DETECT_RESURRECTION) does not work.
constant boolean UnitEventEx___DETECT_REVIVES= false
    // this particular event will run after a zero-second delay so that units are able to fully enter the creation scope.
    // it can be useful if you need something to run after both indexing and other events like EVENT_PLAYER_UNIT_CONSTRUCT_START
constant boolean UnitEventEx___DETECT_CREATION= false
    
    // END CONFIGURATION
    
unit UnitEventEx___eventUnit= null
unit UnitEventEx___eventOther= null
integer UnitEventEx___eventPreType= 0
    
integer EVENT_ON_TRANSFORM
integer EVENT_ON_CARGO_LOAD
integer EVENT_ON_CARGO_UNLOAD
integer EVENT_ON_RESURRECTION
integer EVENT_ON_ANIMATE_DEAD
integer EVENT_ON_REINCARNATION_START
integer EVENT_ON_REINCARNATION_FINISH
integer EVENT_ON_UNIT_CREATED
    
integer UnitEventEx___Stack= - 1
unit array UnitEventEx___IndexedUnit
unit array UnitEventEx___CargoUnit
group array UnitEventEx___CargoGroup
unit array UnitEventEx___Transporter
integer array UnitEventEx___PreTransformType
    
real UnitEventEx___MaxX
real UnitEventEx___MaxY
    
boolean array UnitEventEx___IsNew
boolean array UnitEventEx___IsAlive
boolean array UnitEventEx___IsReincarnating
boolean array UnitEventEx___IsTransforming
    
timer UnitEventEx___AfterIndexTimer= CreateTimer()
boolean UnitEventEx___rezCheck= true
    
//endglobals from UnitEventEx
//globals from ResourcesChatCommands:
constant boolean LIBRARY_ResourcesChatCommands=true
constant boolean ResourcesChatCommands_ALLOW_HELP= true
constant boolean ResourcesChatCommands_ALLOW_LIST= true
constant boolean ResourcesChatCommands_ALLOW_GIVE= true
constant boolean ResourcesChatCommands_ALLOW_ASK= true
constant boolean ResourcesChatCommands_ALLOW_SELL= true
constant boolean ResourcesChatCommands_ALLOW_SELL_ALL= true
constant boolean ResourcesChatCommands_ALLOW_SELL_WOOD= true
constant boolean ResourcesChatCommands_ALLOW_BUY= true
constant real ResourcesChatCommands_HELP_DURATION= 8.0
constant real ResourcesChatCommands_RESOURCES_DURATION= 8.0
constant real ResourcesChatCommands_INFO_DURATION= 4.0
   
trigger ResourcesChatCommands___chatTrigger= CreateTrigger()
//endglobals from ResourcesChatCommands
//globals from ResourcesCosts:
constant boolean LIBRARY_ResourcesCosts=true
    // Source for refund values: http://classic.battle.net/war3/basics/buildings.shtml
constant real ResourcesCosts_REFUND_BUILDING= 0.75
constant real ResourcesCosts_REFUND_RESEARCH= 1.0
constant real ResourcesCosts_REFUND_UPGRADE= 0.75
constant real ResourcesCosts_REFUND_UNIT_TRAINING= 1.0
constant real ResourcesCosts_REFUND_HERO_REVIVAL= 1.0
constant real ResourcesCosts_REFUND_ITEM= 0.5
constant integer ResourcesCosts_MAX_LEVEL= 100
constant integer ResourcesCosts_CANCEL_ORDER_ID= 851976
constant integer ResourcesCosts_KEY_HAS_COSTS= bj_MAX_PLAYERS
constant integer ResourcesCosts_KEY_IS_RESEARCH= bj_MAX_PLAYERS + 1
constant integer ResourcesCosts_KEY_IS_ABILITY= bj_MAX_PLAYERS + 2
constant integer ResourcesCosts_KEY_GOLD_VALUE= bj_MAX_PLAYERS + 3
constant integer ResourcesCosts_KEY_LUMBER_VALUE= bj_MAX_PLAYERS + 4
constant integer ResourcesCosts_MAX_KEYS= bj_MAX_PLAYERS + 5
    
sound array ResourcesCosts___playerSoundNotEnough
hashtable ResourcesCosts___h= InitHashtable()
hashtable ResourcesCosts___h2= InitHashtable()
trigger ResourcesCosts___issueTrigger= CreateTrigger()
trigger ResourcesCosts___constructCancelTrigger= CreateTrigger()
trigger ResourcesCosts___trainCancelTrigger= CreateTrigger()
trigger ResourcesCosts___researchCancelTrigger= CreateTrigger()
trigger ResourcesCosts___heroReviveCancelTrigger= CreateTrigger()
trigger ResourcesCosts___unitSellTrigger= CreateTrigger()
trigger ResourcesCosts___itemSellTrigger= CreateTrigger()
trigger ResourcesCosts___channelTrigger= CreateTrigger()
//endglobals from ResourcesCosts
//globals from ResourcesGui:
constant boolean LIBRARY_ResourcesGui=true
constant real ResourcesGui___X= 0.3053
constant real ResourcesGui___Y= 0.06
constant real ResourcesGui___WIDTH= 0.05
constant real ResourcesGui___HEIGHT= 0.05
constant real ResourcesGui___TEXT_X= ResourcesGui___X + ResourcesGui___WIDTH
constant real ResourcesGui___TEXT_WIDTH= 0.1
    
constant real ResourcesGui___X_GATHERED= 0.404
constant real ResourcesGui___Y_GATHERED= 0.09
constant real ResourcesGui___TEXT_X_GATHERED= ResourcesGui___X_GATHERED + ResourcesGui___WIDTH

framehandle ResourcesGui___IconFrame
framehandle ResourcesGui___TextFrame
    
framehandle ResourcesGui___IconFrameGathered
framehandle ResourcesGui___TextFrameGathered
    
framehandle ResourcesGui___IconFrameGathered2
framehandle ResourcesGui___TextFrameGathered2
    
trigger ResourcesGui___selectionTrigger= CreateTrigger()
trigger ResourcesGui___deselectionTrigger= CreateTrigger()
trigger ResourcesGui___gatherTrigger= CreateTrigger()
trigger ResourcesGui___returnTrigger= CreateTrigger()
hashtable ResourcesGui___h= InitHashtable()
timer array ResourcesGui___updateTimer
boolean array ResourcesGui___updateTimerRunning
unit array ResourcesGui___currentMine
    
trigger ResourcesGui___progressBarStartTrigger= CreateTrigger()
trigger ResourcesGui___progressBarFinishTrigger= CreateTrigger()
group ResourcesGui___progressBarUnits= CreateGroup()
    
player ResourcesGui___tmpPlayer= null
trigger ResourcesGui___tmpTrigger= CreateTrigger()
//endglobals from ResourcesGui
//globals from ResourcesLoadedMines:
constant boolean LIBRARY_ResourcesLoadedMines=true
constant real ResourcesLoadedMines_HARVEST_INTERVAL= 3.0
constant integer ResourcesLoadedMines_ORDER_ID_LOAD= 852046
group ResourcesLoadedMines___mines= CreateGroup()
trigger ResourcesLoadedMines___orderTrigger= CreateTrigger()
trigger ResourcesLoadedMines___deathTrigger= CreateTrigger()
timer ResourcesLoadedMines___harvestTimer= CreateTimer()
hashtable ResourcesLoadedMines___h= InitHashtable()
constant integer ResourcesLoadedMines___KEY_HARVEST_BONUS_PER_WORKER= 0
constant integer ResourcesLoadedMines___KEY_ALLOWED_WORKER_UNIT_TYPE_ID= 1
constant integer ResourcesLoadedMines___MAX_KEYS= 2
//endglobals from ResourcesLoadedMines
//globals from ResourcesTeamMultiboardGui:
constant boolean LIBRARY_ResourcesTeamMultiboardGui=true
constant real ResourcesTeamMultiboardGui_TIMER_INTERVAL= 0.5
constant boolean ResourcesTeamMultiboardGui_INCLUDE_VIEWING_PLAYERS= true
constant real ResourcesTeamMultiboardGui_NAME_COLUMN_WIDTH= 0.1
constant real ResourcesTeamMultiboardGui_RESOURCE_COLUMN_WIDTH= 0.07
constant real ResourcesTeamMultiboardGui_FOOD_COLUMN_WIDTH= 0.06
multiboard array ResourcesTeamMultiboardGui___playerMultiboards
boolean array ResourcesTeamMultiboardGui___playerIgnoredMultiboards
timer ResourcesTeamMultiboardGui___t= CreateTimer()
trigger ResourcesTeamMultiboardGui___allianceChangeTrigger= CreateTrigger()
//endglobals from ResourcesTeamMultiboardGui
//globals from ResourcesWarnings:
constant boolean LIBRARY_ResourcesWarnings=true
integer array ResourcesWarnings___resourceLowValue
sound array ResourcesWarnings___playerSoundLow
string array ResourcesWarnings___playerMessageLow
sound array ResourcesWarnings___playerSoundCollapsed
string array ResourcesWarnings___playerMessageCollapsed
   
trigger ResourcesWarnings___gatherTrigger= CreateTrigger()
//endglobals from ResourcesWarnings
    // Generated
sound gg_snd_GruntNoOil1= null
sound gg_snd_GruntNoRock1= null
sound gg_snd_GruntNoWheat1= null
sound gg_snd_GruntOilPlatformCollapsed1= null
sound gg_snd_GruntOilPlatformLow1= null
sound gg_snd_GruntRockMineCollapsed1= null
sound gg_snd_GruntRockMineLow1= null
sound gg_snd_GruntWheatFieldCollapsed1= null
sound gg_snd_GruntWheatFieldLow1= null
trigger gg_trg_UnitDex= null
trigger gg_trg_WorldBounds= null
trigger gg_trg_RegisterPlayerUnitEvent_Magtheridon96= null
trigger gg_trg_RegisterNativeEvent= null
trigger gg_trg_UnitEventEx= null
trigger gg_trg_Resources_Init= null
trigger gg_trg_Resources_Start= null
trigger gg_trg_Resources_Constructed_Town_Hall= null
trigger gg_trg_Resources_Constructed_Shipyard= null
trigger gg_trg_Resources_Starts_Constructing_Oil_Platform= null
trigger gg_trg_Resources_Starts_Constructing_Rock_Mine_Shaft= null
trigger gg_trg_Resources_Cancel_Constructing_Oil_Platform= null
trigger gg_trg_Resources_Issue_Order_Oil_Platform= null
trigger gg_trg_Resources_Issue_Order_Construct_Rock_Mine_Shaft= null
trigger gg_trg_Resources_Constructed_Oil_Platform= null
trigger gg_trg_Resources_Constructed_Oil_Refinery= null
trigger gg_trg_Resources_Constructed_Rock_Mine_Shaft= null
trigger gg_trg_Resources_Death_Oil_Refinery= null
trigger gg_trg_Resources_Constructed_Quarry= null
trigger gg_trg_Resources_Death_Quarry= null
trigger gg_trg_Resources_Constructed_Granary= null
trigger gg_trg_Resources_Train_Oil_Ship= null
trigger gg_trg_Resources_Train_Peon= null
trigger gg_trg_Resources_Hire_Drillbot= null
trigger gg_trg_Resources_Item_Wheat_Bundle= null
trigger gg_trg_Resources_Taxes_Wheat= null
trigger gg_trg_Buy_100_Oil= null
trigger gg_trg_Sell_100_Oil= null
trigger gg_trg_Buy_100_Rock= null
trigger gg_trg_Sell_100_Rock= null
trigger gg_trg_Buy_100_Wheat= null
trigger gg_trg_Sell_100_Wheat= null
trigger gg_trg_Initialization= null
trigger gg_trg_Melee_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Cheat_Resources= null
trigger gg_trg_Normal_Buildings= null
trigger gg_trg_Advanced_Buildings= null
trigger gg_trg_Normal_Buildings_Oil_Tanker= null
trigger gg_trg_Blue_Start= null
unit gg_unit_n001_0005= null
unit gg_unit_o002_0010= null
unit gg_unit_opeo_0044= null
unit gg_unit_opeo_0045= null
unit gg_unit_opeo_0046= null
unit gg_unit_n000_0050= null
unit gg_unit_opeo_0052= null
unit gg_unit_opeo_0053= null
unit gg_unit_opeo_0054= null
trigger gg_trg_Buy_100_Ore= null
trigger gg_trg_Sell_100_Ore= null
trigger deathTrigger= CreateTrigger()
integer Oil
integer Rock
integer Wheat
integer Ore
integer array playerRefineryCounters
integer array playerQuarryCounters
integer array playerGranaryCounters

trigger l__library_init

//JASSHelper struct globals:
constant integer si__RegisterNativeEvent___NativeEvent=1
hashtable s__RegisterNativeEvent___NativeEvent_table= InitHashtable()
constant integer si__WorldBounds=2
integer s__WorldBounds_maxX
integer s__WorldBounds_maxY
integer s__WorldBounds_minX
integer s__WorldBounds_minY
integer s__WorldBounds_centerX
integer s__WorldBounds_centerY
rect s__WorldBounds_world
region s__WorldBounds_worldRegion
constant integer si__AFormat=3
integer si__AFormat_F=0
integer si__AFormat_I=0
integer array si__AFormat_V
integer array s__AFormat_m_position
string array s__AFormat_m_text
constant integer si__UnitDex=4
boolean s__UnitDex_Enabled= true
integer s__UnitDex_LastIndex
boolean s__UnitDex_Initialized=false
group s__UnitDex_Group=CreateGroup()
unit array s__UnitDex_Unit
integer s__UnitDex_Count= 0
integer array s__UnitDex_List
constant integer s__UnitDex_DETECT_LEAVE_ABILITY= 'A02Z'
constant boolean s__UnitDex_ALLOW_DEBUGGING= true
integer s__UnitDex_Counter= 0
constant integer si__Resource=5
integer si__Resource_F=0
integer si__Resource_I=0
integer array si__Resource_V
string array s__Resource_name
string array s__Resource_icon
string array s__Resource_iconAtt
string array s__Resource_description
real array s__Resource_goldExchangeRate
integer array s__Resource_red
integer array s__Resource_blue
integer array s__Resource_green
integer array s___Resource_playerAmount
constant integer s___Resource_playerAmount_size=28
integer array s__Resource_playerAmount
integer array s___Resource_playerBonus
constant integer s___Resource_playerBonus_size=28
integer array s__Resource_playerBonus
integer array s___Resource_playerUpkeepRate
constant integer s___Resource_playerUpkeepRate_size=28
integer array s__Resource_playerUpkeepRate
integer array s__Resource_resources
integer s__Resource_resourcesCount= 0
constant integer si__UnitEventEx___Cargo=9
integer si__UnitEventEx___Cargo_F=0
integer si__UnitEventEx___Cargo_I=0
integer array si__UnitEventEx___Cargo_V
constant integer si__UnitEventEx___UnitEventEx=10
integer si__UnitEventEx___UnitEventEx_F=0
integer si__UnitEventEx___UnitEventEx_I=0
integer array si__UnitEventEx___UnitEventEx_V
trigger st__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer
trigger array st___prototype51
unit f__arg_unit1

endglobals
native UnitAlive takes unit u returns boolean
native GetUnitGoldCost takes integer unitid returns integer
native GetUnitWoodCost takes integer unitid returns integer


//Generated method caller for UnitEventEx___UnitEventEx.UnitEventEx___UnitEventExCore___resurrectionTimer
function sc__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer takes nothing returns nothing
        set UnitEventEx___rezCheck=false
        call DestroyTimer(GetExpiredTimer())
endfunction

//Generated allocator of UnitEventEx___UnitEventEx
function s__UnitEventEx___UnitEventEx__allocate takes nothing returns integer
 local integer this=si__UnitEventEx___UnitEventEx_F
    if (this!=0) then
        set si__UnitEventEx___UnitEventEx_F=si__UnitEventEx___UnitEventEx_V[this]
    else
        set si__UnitEventEx___UnitEventEx_I=si__UnitEventEx___UnitEventEx_I+1
        set this=si__UnitEventEx___UnitEventEx_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__UnitEventEx___UnitEventEx_V[this]=-1
 return this
endfunction

//Generated destructor of UnitEventEx___UnitEventEx
function s__UnitEventEx___UnitEventEx_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__UnitEventEx___UnitEventEx_V[this]!=-1) then
        return
    endif
    set si__UnitEventEx___UnitEventEx_V[this]=si__UnitEventEx___UnitEventEx_F
    set si__UnitEventEx___UnitEventEx_F=this
endfunction

//Generated allocator of UnitEventEx___Cargo
function s__UnitEventEx___Cargo__allocate takes nothing returns integer
 local integer this=si__UnitEventEx___Cargo_F
    if (this!=0) then
        set si__UnitEventEx___Cargo_F=si__UnitEventEx___Cargo_V[this]
    else
        set si__UnitEventEx___Cargo_I=si__UnitEventEx___Cargo_I+1
        set this=si__UnitEventEx___Cargo_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__UnitEventEx___Cargo_V[this]=-1
 return this
endfunction

//Generated destructor of UnitEventEx___Cargo
function s__UnitEventEx___Cargo_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__UnitEventEx___Cargo_V[this]!=-1) then
        return
    endif
    set si__UnitEventEx___Cargo_V[this]=si__UnitEventEx___Cargo_F
    set si__UnitEventEx___Cargo_F=this
endfunction

//Generated allocator of Resource
function s__Resource__allocate takes nothing returns integer
 local integer this=si__Resource_F
    if (this!=0) then
        set si__Resource_F=si__Resource_V[this]
    else
        set si__Resource_I=si__Resource_I+1
        set this=si__Resource_I
    endif
    if (this>291) then
        return 0
    endif
    set s__Resource_playerAmount[this]=(this-1)*28
    set s__Resource_playerBonus[this]=(this-1)*28
    set s__Resource_playerUpkeepRate[this]=(this-1)*28
   set s__Resource_goldExchangeRate[this]= 1.0
    set si__Resource_V[this]=-1
 return this
endfunction

//Generated destructor of Resource
function s__Resource_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__Resource_V[this]!=-1) then
        return
    endif
    set si__Resource_V[this]=si__Resource_F
    set si__Resource_F=this
endfunction

//Generated allocator of AFormat
function s__AFormat__allocate takes nothing returns integer
 local integer this=si__AFormat_F
    if (this!=0) then
        set si__AFormat_F=si__AFormat_V[this]
    else
        set si__AFormat_I=si__AFormat_I+1
        set this=si__AFormat_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__AFormat_V[this]=-1
 return this
endfunction

//Generated destructor of AFormat
function s__AFormat_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__AFormat_V[this]!=-1) then
        return
    endif
    set si__AFormat_V[this]=si__AFormat_F
    set si__AFormat_F=this
endfunction
function sc___prototype51_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype51[i])
endfunction
function sc___prototype51_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype51[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: Resources___RemoveUnitHook
    call sc___prototype51_evaluate(1,a0)
    //hook: ResourcesGui___RemoveUnitHook
    call sc___prototype51_evaluate(2,a0)
call RemoveUnit(a0)
endfunction

//library FrameLoader:
// in 1.31 and upto 1.32.9 PTR (when I wrote this). Frames are not correctly saved and loaded, breaking the game.
// This library runs all functions added to it with a 0s delay after the game was loaded.
// function FrameLoaderAdd takes code func returns nothing
    // func runs when the game is loaded.
    function FrameLoaderAdd takes code func returns nothing
        call TriggerAddAction(FrameLoader___actionTrigger, func)
    endfunction

    function FrameLoader___timerAction takes nothing returns nothing
        call TriggerExecute(FrameLoader___actionTrigger)
    endfunction
    function FrameLoader___eventAction takes nothing returns nothing
        call TimerStart(FrameLoader___t, 0, false, function FrameLoader___timerAction)
    endfunction
    function FrameLoader___init_function takes nothing returns nothing
        call TriggerRegisterGameEvent(FrameLoader___eventTrigger, EVENT_GAME_LOADED)
        call TriggerAddAction(FrameLoader___eventTrigger, function FrameLoader___eventAction)
    endfunction

//library FrameLoader ends
//library GetSingleSelectedUnit:


function GetSingleSelectedUnit takes player whichPlayer returns unit
    local group selected= GetUnitsSelectedAll(whichPlayer)
    local unit first= null
    if ( BlzGroupGetSize(selected) == 1 ) then
        set first=FirstOfGroup(selected)
    endif
    call GroupClear(selected)
    call DestroyGroup(selected)
    set selected=null
    return first
endfunction


//library GetSingleSelectedUnit ends
//library ItemTypeUtils:


// https://www.hiveworkshop.com/threads/detecting-item-price.120355/

// This is the x position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils___GetShopDummyX takes nothing returns real
    return 0.0
endfunction

// This is the y position where we create the dummy units. Dont place it in the water.
function ItemTypeUtils___GetShopDummyY takes nothing returns real
    return 0.0
endfunction

function GetItemValueGoldFresh takes integer i returns integer
    local real x= (0.0) // INLINED!!
    local real y= (0.0) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemById(u2, i)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD)
    local integer g2= 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2, a, u1)
    set g2=GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_GOLD) - g2)

    call h__RemoveUnit(u1)
    call h__RemoveUnit(u2)
    set u1=null
    set u2=null
    set a=null
    return g2
endfunction

function GetItemValueGold takes integer i returns integer
    if ( not HaveSavedInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD) ) then
        call SaveInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD, GetItemValueGoldFresh(i))
    endif
    return LoadInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_GOLD)
endfunction

function GetItemCostGold takes integer i returns integer
    return R2I(I2R(GetItemValueGold(i)) * ItemTypeUtils___PAWN_ITEM_RATE)
endfunction

function GetItemGoldCost takes integer i returns integer
    return (R2I(I2R(GetItemValueGold((i))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
endfunction

function GetItemValueLumberFresh takes integer i returns integer
    local real x= (0.0) // INLINED!!
    local real y= (0.0) // INLINED!!
    local unit u1= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SHOP, x, y, 0)
    local unit u2= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), ItemTypeUtils___SELL_UNIT, x, y - 100, 90)
    local item a= UnitAddItemById(u2, i)
    local integer g1= GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER)
    local integer g2= 0
    call SetItemPawnable(a, true)
    call UnitDropItemTarget(u2, a, u1)
    set g2=GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER) - g1
    call SetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(PLAYER_NEUTRAL_PASSIVE), PLAYER_STATE_RESOURCE_LUMBER) - g2)

    call h__RemoveUnit(u1)
    call h__RemoveUnit(u2)
    set u1=null
    set u2=null
    set a=null
    return g2
endfunction

function GetItemValueLumber takes integer i returns integer
    if ( not HaveSavedInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER) ) then
        call SaveInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER, GetItemValueLumberFresh(i))
    endif
    return LoadInteger(ItemTypeUtils___h, i, ItemTypeUtils___KEY_VALUE_LUMBER)
endfunction

function GetItemCostLumber takes integer i returns integer
    return R2I(I2R(GetItemValueLumber(i)) * ItemTypeUtils___PAWN_ITEM_RATE)
endfunction

function GetItemWoodCost takes integer i returns integer
    return (R2I(I2R(GetItemValueLumber((i))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
endfunction

function GetItemTypePerishableFresh takes integer i returns boolean
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local boolean result= BlzGetItemBooleanField(tmpItem, ITEM_BF_PERISHABLE)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypePerishable takes integer i returns boolean
    if ( not HaveSavedBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE) ) then
        call SaveBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE, GetItemTypePerishableFresh(i))
    endif
    return LoadBoolean(ItemTypeUtils___h, i, ItemTypeUtils___KEY_PERISHABLE)
endfunction

function GetItemTypeModelFresh takes integer i returns string
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local string result= BlzGetItemStringField(tmpItem, ITEM_SF_MODEL_USED)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypeModel takes integer i returns string
    if ( not HaveSavedString(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL) ) then
        call SaveStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL, GetItemTypeModelFresh(i))
    endif
    return LoadStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_MODEL)
endfunction

function GetItemTypeIconFresh takes integer i returns string
    local item tmpItem= CreateItem(i, 0.0, 0.0)
    local string result= BlzGetItemIconPath(tmpItem)
    call RemoveItem(tmpItem)
    set tmpItem=null

    return result
endfunction

function GetItemTypeIcon takes integer i returns string
    if ( not HaveSavedString(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON) ) then
        call SaveStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON, GetItemTypeIconFresh(i))
    endif
    return LoadStr(ItemTypeUtils___h, i, ItemTypeUtils___KEY_ICON)
endfunction


//library ItemTypeUtils ends
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
//library OnStartGame:


function OnStartGame takes code func returns nothing
    call TriggerAddAction(OnStartGame___startGameTrigger, func)
endfunction

function OnStartGame___TimerFunctionStartGame takes nothing returns nothing
    local timer t= GetExpiredTimer()
    call TriggerExecute(OnStartGame___startGameTrigger)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function OnStartGame___Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 0.0, false, function OnStartGame___TimerFunctionStartGame)
endfunction


//library OnStartGame ends
//library RegisterNativeEvent:







//Implemented from module RegisterNativeEvent___NativeEventInit:
    function s__RegisterNativeEvent___NativeEvent_RegisterNativeEvent___NativeEventInit___onInit takes nothing returns nothing



    endfunction

function IsNativeEventRegistered takes integer whichIndex,integer whichEvent returns boolean



    return HaveSavedHandle(s__RegisterNativeEvent___NativeEvent_table, whichEvent, whichIndex)

endfunction

function RegisterNativeEventTrigger takes integer whichIndex,integer whichEvent returns boolean
    if not IsNativeEventRegistered(whichIndex , whichEvent) then



        call SaveTriggerHandle(s__RegisterNativeEvent___NativeEvent_table, whichEvent, whichIndex, CreateTrigger())

        return true
    endif
    return false
endfunction

function GetIndexNativeEventTrigger takes integer whichIndex,integer whichEvent returns trigger



    return LoadTriggerHandle(s__RegisterNativeEvent___NativeEvent_table, whichEvent, whichIndex)

endfunction

function GetNativeEventTrigger takes integer whichEvent returns trigger
    return GetIndexNativeEventTrigger(bj_MAX_PLAYER_SLOTS , whichEvent)
endfunction

function CreateNativeEvent takes nothing returns integer
    local integer eventId= RegisterNativeEvent___eventIndex
    call RegisterNativeEventTrigger(bj_MAX_PLAYER_SLOTS , eventId)
    set RegisterNativeEvent___eventIndex=RegisterNativeEvent___eventIndex + 1
    return eventId
endfunction

function RegisterIndexNativeEvent takes integer whichIndex,integer whichEvent,code func returns triggercondition
    call RegisterNativeEventTrigger(whichIndex , whichEvent)
    return TriggerAddCondition(GetIndexNativeEventTrigger(whichIndex , whichEvent), Condition(func))
endfunction

function RegisterNativeEvent takes integer whichEvent,code func returns triggercondition
    return RegisterIndexNativeEvent(bj_MAX_PLAYER_SLOTS , whichEvent , func)
endfunction

function UnregisterNativeEventHandler takes integer whichEvent,triggercondition handler returns nothing
    call TriggerRemoveCondition((GetIndexNativeEventTrigger(bj_MAX_PLAYER_SLOTS , (whichEvent))), handler) // INLINED!!
endfunction


//library RegisterNativeEvent ends
//library RegisterPlayerUnitEvent:
    
    function RegisterPlayerUnitEvent takes playerunitevent p,code c returns nothing
        local integer i= GetHandleId(p)
        local integer k= 15
        if RegisterPlayerUnitEvent___t[i] == null then
            set RegisterPlayerUnitEvent___t[i]=CreateTrigger()
            loop
                call TriggerRegisterPlayerUnitEvent(RegisterPlayerUnitEvent___t[i], Player(k), p, null)
                exitwhen k == 0
                set k=k - 1
            endloop
        endif
        call TriggerAddCondition(RegisterPlayerUnitEvent___t[i], Filter(c))
    endfunction
    
    function RegisterPlayerUnitEventForPlayer takes playerunitevent p,code c,player pl returns nothing
        local integer i= 16 * GetHandleId(p) + GetPlayerId(pl)
        if RegisterPlayerUnitEvent___t[i] == null then
            set RegisterPlayerUnitEvent___t[i]=CreateTrigger()
            call TriggerRegisterPlayerUnitEvent(RegisterPlayerUnitEvent___t[i], pl, p, null)
        endif
        call TriggerAddCondition(RegisterPlayerUnitEvent___t[i], Filter(c))
    endfunction
    
    function GetPlayerUnitEventTrigger takes playerunitevent p returns trigger
        return RegisterPlayerUnitEvent___t[GetHandleId(p)]
    endfunction

//library RegisterPlayerUnitEvent ends
//library SimError:
//**************************************************************************************************
//*
//*  SimError
//*
//*     Mimic an interface error message
//*       call SimError(ForPlayer, msg)
//*         ForPlayer : The player to show the error
//*         msg       : The error
//*    
//*     To implement this function, copy this trigger and paste it in your map.
//* Unless of course you are actually reading the library from wc3c's scripts section, then just
//* paste the contents into some custom text trigger in your map.
//*
//**************************************************************************************************

//==================================================================================================
    //====================================================================================================

    function SimError takes player ForPlayer,string msg returns nothing
        set msg="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n|cffffcc00" + msg + "|r"
        if ( GetLocalPlayer() == ForPlayer ) then
            call ClearTextMessages()
            call DisplayTimedTextToPlayer(ForPlayer, 0.52, 0.96, 2.00, msg)
            call StartSound(SimError___error)
        endif
    endfunction

    function SimError___init takes nothing returns nothing
         set SimError___error=CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
         //call StartSound( error ) //apparently the bug in which you play a sound for the first time
                                    //and it doesn't work is not there anymore in patch 1.22
    endfunction


//library SimError ends
//library StringUtils:

function B2S takes boolean b returns string
    if ( b ) then
        return "true"
    endif
    return "false"
endfunction

function B2Option takes boolean b returns string
    if ( b ) then
        return GetLocalizedString("ON")
    endif
    return GetLocalizedString("OFF")
endfunction

function StringRepeat takes string str,integer count returns string
    local string result= ""
    local integer i= 0
    loop
        exitwhen ( i >= count )
        set result=result + str
        set i=i + 1
    endloop
    return result
endfunction

function StringReplace takes string source,string match,string replace returns string
    local integer i= 0
    local integer max= StringLength(source)
    local integer matchLength= StringLength(match)
    local integer index= 0
    local string result= ""
    loop
        exitwhen ( i == max )
        set index=i + matchLength
        if ( SubString(source, i, index) == match ) then
            set result=result + replace
            set i=index
        else
            set index=i + 1
            set result=result + SubString(source, i, index)
            set i=index
        endif
    endloop
    return result
endfunction

function StringRemove takes string source,string match returns string
    return StringReplace(source , match , "")
endfunction

function StringStartsWith takes string source,string start returns boolean
    local integer i= 0
    loop
        exitwhen ( i == StringLength(start) or i >= StringLength(source) )

        if ( SubString(source, i, i + 1) != SubString(start, i, i + 1) ) then
            return false
        endif

        set i=i + 1
    endloop

    return i == StringLength(start)
endfunction

function StringRemoveFromStart takes string source,string start returns string
    if ( StringStartsWith(source , start) ) then
        return SubString(source, StringLength(start), StringLength(source))
    endif

    return source
endfunction

function IndexOfStringEx takes string symbol,string source,integer start returns integer
    local integer symbolLength= StringLength(symbol)
    local integer length= StringLength(source)
    local integer i2= 0
    local integer i= start
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        set i2=i + symbolLength
        exitwhen ( i >= length or i2 > length )
        if ( SubString(source, i, i2) == symbol ) then
            //call BJDebugMsg("Index: " + I2S(i))
            return i
        endif
        set i=i + 1
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return - 1
endfunction

function IndexOfString takes string symbol,string source returns integer
    return IndexOfStringEx(symbol , source , 0)
endfunction

function StringIndexOf takes string symbol,string source returns integer
    return (IndexOfStringEx((symbol ) , ( source) , 0)) // INLINED!!
endfunction

function StringCount takes string source,string symbol returns integer
    local integer result= 0
    local integer symbolLength= StringLength(symbol)
    local integer length= StringLength(source)
    local integer i= 0
    //call BJDebugMsg("Checking for symbol: " + symbol + " in source " + source)
    loop
        exitwhen ( i == length )
        if ( SubString(source, i, i + symbolLength) == symbol ) then
            //call BJDebugMsg("Index: " + I2S(i))
            set result=result + 1
            set i=i + symbolLength
        else
            set i=i + 1
        endif
    endloop

    //call BJDebugMsg("Missing symbol " + symbol + " in source " + source)

    return result
endfunction


function StringSplit takes string source,integer index,string separator returns string
    local string result= null
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator ) then
            if ( currentIndex == index and result == null ) then
                set result=""
            endif
            set currentIndex=currentIndex + 1
            set i=i + separatorLength
        else
            if ( currentIndex == index ) then
                if ( result == null ) then
                    set result=""
                endif
                set result=result + SubString(source, i, i + 1)
            endif
            set i=i + 1
        endif
    endloop

    return result
endfunction


function StringTokenEx takes string source,integer index,string separator,boolean toTheEnd returns string
    local string result= ""
    local boolean inWhitespace= false
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator and ( not toTheEnd or currentIndex < index ) ) then
            if ( not inWhitespace ) then
                set inWhitespace=true
                set currentIndex=currentIndex + 1
                set i=i + separatorLength
            endif
        else
            if ( currentIndex == index ) then
                set result=result + SubString(source, i, i + 1)
            endif
            set inWhitespace=false
            set i=i + 1
        endif
    endloop

    return result
endfunction

function StringToken takes string source,integer index returns string
    return StringTokenEx(source , index , " " , false)
endfunction

function StringTokenEnteredChatMessageEx takes integer index,boolean toTheEnd returns string
    return StringTokenEx(GetEventPlayerChatString() , index , " " , toTheEnd)
endfunction

function StringTokenEnteredChatMessage takes integer index returns string
    return (StringTokenEx((GetEventPlayerChatString() ) , ( index) , " " , false)) // INLINED!!
endfunction

function RandomizeString takes string source returns string
    local string result= ""
    local integer sourcePosition= 0
    loop
        exitwhen ( StringLength(source) == 0 )
        set sourcePosition=GetRandomInt(0, StringLength(source) - 1)
        set result=result + SubString(source, sourcePosition, sourcePosition + 1)
        set source=SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, StringLength(source))
    endloop

    return result
endfunction

function StringRandomize takes string source returns string
    return RandomizeString(source)
endfunction

function I2SW takes integer i,integer width returns string
    local integer a= 0
    local string result= ""
    local integer max= 0
    if ( width > 0 ) then
        set a=IAbsBJ(i)
        set max=R2I(Pow(R2I(10), R2I(width - 1)))
        if ( i < 0 ) then
            set result=result + "-"
        endif
        loop
            if ( a >= max or max <= 1 ) then
                set result=result + I2S(a)
                exitwhen ( true )
            else
                set result=result + "0"
                set max=max / 10
            endif
        endloop
    else
        set result=I2S(i)
    endif
    return result
endfunction

function FormatTimeString takes integer seconds returns string
    local integer minutes= seconds / 60
    local integer hours= minutes / 60
    local integer hoursInMinutes= hours * 60
    local integer minutesInSeconds= minutes * 60

    set minutes=minutes - hoursInMinutes
    set seconds=seconds - minutesInSeconds

    if ( hours > 0 ) then
        return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
    elseif ( minutes > 0 ) then
        return I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
    else
        return I2S(seconds) + " seconds"
    endif
endfunction

function IsCharacterNumber takes string whichCharacter returns boolean
    return whichCharacter == "0" or whichCharacter == "1" or whichCharacter == "2" or whichCharacter == "3" or whichCharacter == "4" or whichCharacter == "5" or whichCharacter == "6" or whichCharacter == "7" or whichCharacter == "8" or whichCharacter == "9"
endfunction

function IsStringNumber takes string whichString returns boolean
    local integer length= StringLength(whichString)
    local integer i= 0
    loop
        exitwhen ( i == length )
        if ( not IsCharacterNumber(SubString(whichString, i, i + 1)) ) then
            return false
        endif
        set i=i + 1
    endloop
    return true
endfunction

function FormatTime takes real time returns string
    local integer hours= R2I(time / 3600.0)
    local integer minutes=  R2I(time - hours * 3600) / 60
    local integer seconds= R2I(time - hours * 3600 - minutes * 60)
    
    return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
endfunction



function InsertLineBreaks takes string whichString,integer maxLineLength returns string
    local integer i
    local string result
    if ( StringLength(whichString) <= maxLineLength ) then
        return whichString
    endif
    set result=""
    set i=maxLineLength
    loop
        exitwhen ( i > StringLength(whichString) )
        set result=result + SubString(whichString, i - maxLineLength, i) + "\n"
        set i=i + maxLineLength
    endloop

    if ( i < StringLength(whichString) ) then
        set result=result + SubString(whichString, i - maxLineLength, StringLength(whichString))
    endif

    return result
endfunction


function GetExternalString takes integer index returns string
    if ( index < 0 ) then
        return ""
    elseif ( index < 10 ) then
        return GetLocalizedString("TRIGSTR_00" + I2S(index))
    elseif ( index < 100 ) then
        return GetLocalizedString("TRIGSTR_0" + I2S(index))
    else
        return GetLocalizedString("TRIGSTR_" + I2S(index))
    endif
endfunction


function tr takes string source returns string
    return GetLocalizedString(source)
endfunction


function trp takes string singularSource,string pluralSource,integer count returns string
    if ( count == 1 ) then
        return (GetLocalizedString((singularSource))) // INLINED!!
    endif
    return (GetLocalizedString((pluralSource))) // INLINED!!
endfunction


function sc takes string source returns integer
    return GetLocalizedHotkey(source)
endfunction


function GetLanguage takes nothing returns string
    if ( GetObjectName('hfoo') == "Soldat" ) then
        return "German"
    endif
    return "English"
endfunction

function tre takes string german,string english returns string
    if ( GetLanguage() == "German" ) then
        return german
    endif
    return english
endfunction


//library StringUtils ends
//library UnitCost:




function GetUnitGoldCostSafe takes integer unitid returns integer
    if ( IsUnitIdType(unitid, UNIT_TYPE_HERO) ) then
        return UnitCost_HERO_GOLD_COST
    endif
    return GetUnitGoldCost(unitid)
endfunction

function GetUnitWoodCostSafe takes integer unitid returns integer
    if ( IsUnitIdType(unitid, UNIT_TYPE_HERO) ) then
        return UnitCost_HERO_WOOD_COST
    endif
    return GetUnitWoodCost(unitid)
endfunction


//library UnitCost ends
//library WorldBounds:
	
		
		
		
		
//Implemented from module WorldBounds___WorldBoundInit:
  function s__WorldBounds_WorldBounds___WorldBoundInit___onInit takes nothing returns nothing
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
//library PlayerColorUtils:

function GetPlayerColorTexture takes playercolor c returns string
    return "ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId(c) , 2)
endfunction

function GetPlayerColorRed takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0xFF
    elseif c == PLAYER_COLOR_BLUE then
        return 0x00
    elseif c == PLAYER_COLOR_CYAN then
        return 0x1B
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x53
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFF
    elseif c == PLAYER_COLOR_ORANGE then
        return 0xFE
    elseif c == PLAYER_COLOR_GREEN then
        return 0x1F
    elseif c == PLAYER_COLOR_PINK then
        return 0xE4
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x94
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0x7D
    elseif c == PLAYER_COLOR_AQUA then
        return 0x0F
    elseif c == PLAYER_COLOR_BROWN then
        return 0x4D
    elseif c == PLAYER_COLOR_MAROON then
        return 0x9B
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0x00
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xBE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xEB
    elseif c == PLAYER_COLOR_PEACH then
        return 0xF8
    elseif c == PLAYER_COLOR_MINT then
        return 0xBF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xDC
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xEB
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x00
    elseif c == PLAYER_COLOR_PEANUT then
        return 0xA4
    else
        return 0xFF
    endif
    return 0
endfunction

function GetPlayerColorGreen takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0x41
    elseif c == PLAYER_COLOR_CYAN then
        return 0xE5
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x00
    elseif c == PLAYER_COLOR_YELLOW then
        return 0xFC
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x89
    elseif c == PLAYER_COLOR_GREEN then
        return 0xBF
    elseif c == PLAYER_COLOR_PINK then
        return 0x5A
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x95
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xBE
    elseif c == PLAYER_COLOR_AQUA then
        return 0x61
    elseif c == PLAYER_COLOR_BROWN then
        return 0x29
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0x00
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xEA
    elseif c == PLAYER_COLOR_VIOLET then
        return 0x00
    elseif c == PLAYER_COLOR_WHEAT then
        return 0xCD
    elseif c == PLAYER_COLOR_PEACH then
        return 0xA4
    elseif c == PLAYER_COLOR_MINT then
        return 0xFF
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xB9
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xF0
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x78
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x6F
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorBlue takes playercolor c returns integer
    if c == PLAYER_COLOR_RED then
        return 0x02
    elseif c == PLAYER_COLOR_BLUE then
        return 0xFF
    elseif c == PLAYER_COLOR_CYAN then
        return 0xB8
    elseif c == PLAYER_COLOR_PURPLE then
        return 0x80
    elseif c == PLAYER_COLOR_YELLOW then
        return 0x00
    elseif c == PLAYER_COLOR_ORANGE then
        return 0x0D
    elseif c == PLAYER_COLOR_GREEN then
        return 0x00
    elseif c == PLAYER_COLOR_PINK then
        return 0xAF
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return 0x96
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return 0xF1
    elseif c == PLAYER_COLOR_AQUA then
        return 0x45
    elseif c == PLAYER_COLOR_BROWN then
        return 0x03
    elseif c == PLAYER_COLOR_MAROON then
        return 0x00
    elseif c == PLAYER_COLOR_NAVY then
        return 0xC3
    elseif c == PLAYER_COLOR_TURQUOISE then
        return 0xFF
    elseif c == PLAYER_COLOR_VIOLET then
        return 0xFE
    elseif c == PLAYER_COLOR_WHEAT then
        return 0x87
    elseif c == PLAYER_COLOR_PEACH then
        return 0x8B
    elseif c == PLAYER_COLOR_MINT then
        return 0x80
    elseif c == PLAYER_COLOR_LAVENDER then
        return 0xEB
    elseif c == PLAYER_COLOR_COAL then
        return 0x28
    elseif c == PLAYER_COLOR_SNOW then
        return 0xFF
    elseif c == PLAYER_COLOR_EMERALD then
        return 0x1E
    elseif c == PLAYER_COLOR_PEANUT then
        return 0x33
    else
        return 0xFF
    endif
endfunction

function GetPlayerColorString takes playercolor c,string text returns string
//Credits to Andrewgosu from TH for the color codes//
    if c == PLAYER_COLOR_RED then
        return "|cffFF0202" + text + "|r"
    elseif c == PLAYER_COLOR_BLUE then
        return "|cff0041FF" + text + "|r"
    elseif c == PLAYER_COLOR_CYAN then
        return "|cff1BE5B8" + text + "|r"
    elseif c == PLAYER_COLOR_PURPLE then
        return "|cff530080" + text + "|r"
    elseif c == PLAYER_COLOR_YELLOW then
        return "|cffFFFC00" + text + "|r"
    elseif c == PLAYER_COLOR_ORANGE then
        return "|cffFE890D" + text + "|r"
    elseif c == PLAYER_COLOR_GREEN then
        return "|cff1FBF00" + text + "|r"
    elseif c == PLAYER_COLOR_PINK then
        return "|cffE45AAF" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_GRAY then
        return "|cff949596" + text + "|r"
    elseif c == PLAYER_COLOR_LIGHT_BLUE then
        return "|cff7DBEF1" + text + "|r"
    elseif c == PLAYER_COLOR_AQUA then
        return "|cff0F6145" + text + "|r"
    elseif c == PLAYER_COLOR_BROWN then
        return "|cff4D2903" + text + "|r"
    elseif c == PLAYER_COLOR_MAROON then
        return "|cff9B0000" + text + "|r"
    elseif c == PLAYER_COLOR_NAVY then
        return "|cff0000C3" + text + "|r"
    elseif c == PLAYER_COLOR_TURQUOISE then
        return "|cff00EAFF" + text + "|r"
    elseif c == PLAYER_COLOR_VIOLET then
        return "|cffBE00FE" + text + "|r"
    elseif c == PLAYER_COLOR_WHEAT then
        return "|cffEBCD87" + text + "|r"
    elseif c == PLAYER_COLOR_PEACH then
        return "|cffF8A48B" + text + "|r"
    elseif c == PLAYER_COLOR_MINT then
        return "|cffBFFF80" + text + "|r"
    elseif c == PLAYER_COLOR_LAVENDER then
        return "|cffDCB9EB" + text + "|r"
    elseif c == PLAYER_COLOR_COAL then
        return "|cff282828" + text + "|r"
    elseif c == PLAYER_COLOR_SNOW then
        return "|cffEBF0FF" + text + "|r"
    elseif c == PLAYER_COLOR_EMERALD then
        return "|cff00781E" + text + "|r"
    elseif c == PLAYER_COLOR_PEANUT then
        return "|cffA46F33" + text + "|r"
    else
        return "|cffFFFFFF" + text + "|r"
    endif
endfunction

function GetPlayerNameColoredSimple takes player whichPlayer returns string
	return GetPlayerColorString(GetPlayerColor(whichPlayer) , GetPlayerName(whichPlayer))
endfunction

function GetPlayerNameColored takes player whichPlayer returns string
	return "[" + I2S(GetPlayerId(whichPlayer) + 1) + "]" + GetPlayerNameColoredSimple(whichPlayer)
endfunction


function PlayerColorUtils___Init takes nothing returns nothing
    set PlayerColorUtils___PlayerColorNames[0]="RED"
    set PlayerColorUtils___PlayerColorNames[1]="BLUE"
    set PlayerColorUtils___PlayerColorNames[2]="CYAN"
    set PlayerColorUtils___PlayerColorNames[3]="PURPLE"
    set PlayerColorUtils___PlayerColorNames[4]="YELLOW"
    set PlayerColorUtils___PlayerColorNames[5]="ORANGE"
    set PlayerColorUtils___PlayerColorNames[6]="GREEN"
    set PlayerColorUtils___PlayerColorNames[7]="PINK"
    set PlayerColorUtils___PlayerColorNames[8]="LIGHT_GRAY"
    set PlayerColorUtils___PlayerColorNames[9]="LIGHT_BLUE"
    set PlayerColorUtils___PlayerColorNames[10]="AQUA"
    set PlayerColorUtils___PlayerColorNames[11]="BROWN"
    set PlayerColorUtils___PlayerColorNames[12]="MAROON"
    set PlayerColorUtils___PlayerColorNames[13]="NAVY"
    set PlayerColorUtils___PlayerColorNames[14]="TURQUOISE"
    set PlayerColorUtils___PlayerColorNames[15]="VIOLET"
    set PlayerColorUtils___PlayerColorNames[16]="WHEAT"
    set PlayerColorUtils___PlayerColorNames[17]="PEACH"
    set PlayerColorUtils___PlayerColorNames[18]="MINT"
    set PlayerColorUtils___PlayerColorNames[19]="LAVENDER"
    set PlayerColorUtils___PlayerColorNames[20]="COAL"
    set PlayerColorUtils___PlayerColorNames[21]="SNOW"
    set PlayerColorUtils___PlayerColorNames[22]="EMERALD"
    set PlayerColorUtils___PlayerColorNames[23]="PEANUT"
endfunction

function GetPlayerColorName takes player whichPlayer returns string
    return StringCase(PlayerColorUtils___PlayerColorNames[GetPlayerId(whichPlayer)], false)
endfunction

function GetPlayerColorFromString takes string whichString returns playercolor
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( whichString == I2S(i + 1) or ( PlayerColorUtils___PlayerColorNames[i] != null and StringLength(PlayerColorUtils___PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorUtils___PlayerColorNames[i] ) or StringStartsWith(GetPlayerName(Player(i)) , whichString) ) then
            return ConvertPlayerColor(i)
        endif
        set i=i + 1
    endloop

    return null
endfunction

function GetPlayerFromString takes string whichString returns player
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( whichString == I2S(i + 1) or ( PlayerColorUtils___PlayerColorNames[i] != null and StringLength(PlayerColorUtils___PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorUtils___PlayerColorNames[i] ) or StringStartsWith(GetPlayerName(Player(i)) , whichString) ) then
            return Player(i)
        endif
        set i=i + 1
    endloop

    return null
endfunction


//library PlayerColorUtils ends
//library Refund:

function RefundUnit takes unit whichUnit returns nothing
    local player owner= GetOwningPlayer(whichUnit)
    local integer unitTypeId= GetUnitTypeId(whichUnit)
    local integer gold= GetUnitGoldCostSafe(unitTypeId)
    local integer lumber= GetUnitWoodCostSafe(unitTypeId)
    call AdjustPlayerStateSimpleBJ(owner, PLAYER_STATE_RESOURCE_GOLD, gold)
    call AdjustPlayerStateSimpleBJ(owner, PLAYER_STATE_RESOURCE_LUMBER, lumber)
    call h__RemoveUnit(whichUnit)
    set owner=null
endfunction

function RefundItem takes item whichItem,player whichPlayer returns nothing
    local integer itemTypeId= GetItemTypeId(whichItem)
    local integer gold= (R2I(I2R(GetItemValueGold(((itemTypeId)))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
    local integer lumber= (R2I(I2R(GetItemValueLumber(((itemTypeId)))) * ItemTypeUtils___PAWN_ITEM_RATE)) // INLINED!!
    call AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, gold)
    call AdjustPlayerStateSimpleBJ(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, lumber)
    call RemoveItem(whichItem)
endfunction


//library Refund ends
//library StringFormat:



    
    function s__AFormat_position takes integer this returns integer
        return s__AFormat_m_position[this]
    endfunction

    
    function s__AFormat_text takes integer this returns string
        return s__AFormat_m_text[this]
    endfunction

    

//textmacro instance: AFormatMethod("i", "integer", "i", "I2S(value)", "")
        function s__AFormat_i takes integer this,integer value returns integer
            local string positionString= "%i"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("i", "integer", "i", "I2S(value)", "")
//textmacro instance: AFormatMethod("integer", "integer", "i", "I2S(value)", "")
        function s__AFormat_integer takes integer this,integer value returns integer
            local string positionString= "%i"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("integer", "integer", "i", "I2S(value)", "")
//textmacro instance: AFormatMethod("r", "real", "r", "R2S(value)", "")
        function s__AFormat_r takes integer this,real value returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("r", "real", "r", "R2S(value)", "")
//textmacro instance: AFormatMethod("real", "real", "r", "R2S(value)", "")
        function s__AFormat_real takes integer this,real value returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2S(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2S(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("real", "real", "r", "R2S(value)", "")
//textmacro instance: AFormatMethod("rw", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
        function s__AFormat_rw takes integer this,real value,integer width,integer precision returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2SW(value, width, precision) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2SW(value, width, precision) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("rw", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
//textmacro instance: AFormatMethod("realWidth", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
        function s__AFormat_realWidth takes integer this,real value,integer width,integer precision returns integer
            local string positionString= "%r"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + R2SW(value, width, precision) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + R2SW(value, width, precision) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("realWidth", "real", "r", "R2SW(value, width, precision)", ", integer width, integer precision")
//textmacro instance: AFormatMethod("s", "string", "s", "value", "")
        function s__AFormat_s takes integer this,string value returns integer
            local string positionString= "%s"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + value + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + value + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("s", "string", "s", "value", "")
//textmacro instance: AFormatMethod("string", "string", "s", "value", "")
        function s__AFormat_string takes integer this,string value returns integer
            local string positionString= "%s"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + value + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + value + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("string", "string", "s", "value", "")
//textmacro instance: AFormatMethod("h", "handle", "h", "I2S(GetHandleId(value))", "")
        function s__AFormat_h takes integer this,handle value returns integer
            local string positionString= "%h"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetHandleId(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetHandleId(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("h", "handle", "h", "I2S(GetHandleId(value))", "")
//textmacro instance: AFormatMethod("handle", "handle", "h", "I2S(GetHandleId(value))", "")
        function s__AFormat_handle takes integer this,handle value returns integer
            local string positionString= "%h"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetHandleId(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetHandleId(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("handle", "handle", "h", "I2S(GetHandleId(value))", "")
//textmacro instance: AFormatMethod("u", "unit", "u", "GetUnitName(value)", "")
        function s__AFormat_u takes integer this,unit value returns integer
            local string positionString= "%u"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetUnitName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetUnitName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("u", "unit", "u", "GetUnitName(value)", "")
//textmacro instance: AFormatMethod("unit", "unit", "u", "GetUnitName(value)", "")
        function s__AFormat_unit takes integer this,unit value returns integer
            local string positionString= "%u"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetUnitName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetUnitName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("unit", "unit", "u", "GetUnitName(value)", "")
//textmacro instance: AFormatMethod("it", "item", "it", "GetItemName(value)", "")
        function s__AFormat_it takes integer this,item value returns integer
            local string positionString= "%it"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetItemName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetItemName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("it", "item", "it", "GetItemName(value)", "")
//textmacro instance: AFormatMethod("item", "item", "it", "GetItemName(value)", "")
        function s__AFormat_item takes integer this,item value returns integer
            local string positionString= "%it"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetItemName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetItemName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("item", "item", "it", "GetItemName(value)", "")
//textmacro instance: AFormatMethod("d", "destructable", "d", "GetDestructableName(value)", "")
        function s__AFormat_d takes integer this,destructable value returns integer
            local string positionString= "%d"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetDestructableName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetDestructableName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("d", "destructable", "d", "GetDestructableName(value)", "")
//textmacro instance: AFormatMethod("destructable", "destructable", "d", "GetDestructableName(value)", "")
        function s__AFormat_destructable takes integer this,destructable value returns integer
            local string positionString= "%d"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetDestructableName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetDestructableName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("destructable", "destructable", "d", "GetDestructableName(value)", "")
//textmacro instance: AFormatMethod("p", "player", "p", "GetPlayerName(value)", "")
        function s__AFormat_p takes integer this,player value returns integer
            local string positionString= "%p"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetPlayerName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetPlayerName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("p", "player", "p", "GetPlayerName(value)", "")
//textmacro instance: AFormatMethod("player", "player", "p", "GetPlayerName(value)", "")
        function s__AFormat_player takes integer this,player value returns integer
            local string positionString= "%p"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetPlayerName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetPlayerName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("player", "player", "p", "GetPlayerName(value)", "")
//textmacro instance: AFormatMethod("he", "unit", "he", "GetHeroProperName(value)", "")
        function s__AFormat_he takes integer this,unit value returns integer
            local string positionString= "%he"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetHeroProperName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetHeroProperName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("he", "unit", "he", "GetHeroProperName(value)", "")
//textmacro instance: AFormatMethod("hero", "unit", "he", "GetHeroProperName(value)", "")
        function s__AFormat_hero takes integer this,unit value returns integer
            local string positionString= "%he"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetHeroProperName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetHeroProperName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("hero", "unit", "he", "GetHeroProperName(value)", "")
//textmacro instance: AFormatMethod("o", "integer", "o", "GetObjectName(value)", "")
        function s__AFormat_o takes integer this,integer value returns integer
            local string positionString= "%o"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetObjectName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetObjectName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("o", "integer", "o", "GetObjectName(value)", "")
//textmacro instance: AFormatMethod("object", "integer", "o", "GetObjectName(value)", "")
        function s__AFormat_object takes integer this,integer value returns integer
            local string positionString= "%o"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetObjectName(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetObjectName(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("object", "integer", "o", "GetObjectName(value)", "")
//textmacro instance: AFormatMethod("l", "string", "l", "GetLocalizedString(value)", "")
        function s__AFormat_l takes integer this,string value returns integer
            local string positionString= "%l"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetLocalizedString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetLocalizedString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("l", "string", "l", "GetLocalizedString(value)", "")
//textmacro instance: AFormatMethod("localizedString", "string", "l", "GetLocalizedString(value)", "")
        function s__AFormat_localizedString takes integer this,string value returns integer
            local string positionString= "%l"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetLocalizedString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetLocalizedString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("localizedString", "string", "l", "GetLocalizedString(value)", "")
//textmacro instance: AFormatMethod("k", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
        function s__AFormat_k takes integer this,string value returns integer
            local string positionString= "%k"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetLocalizedHotkey(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetLocalizedHotkey(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("k", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
//textmacro instance: AFormatMethod("localizedHotkey", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
        function s__AFormat_localizedHotkey takes integer this,string value returns integer
            local string positionString= "%k"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + I2S(GetLocalizedHotkey(value)) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + I2S(GetLocalizedHotkey(value)) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("localizedHotkey", "string", "k", "I2S(GetLocalizedHotkey(value))", "")
//textmacro instance: AFormatMethod("e", "integer", "e", "GetExternalString(value)", "")
        function s__AFormat_e takes integer this,integer value returns integer
            local string positionString= "%e"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetExternalString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetExternalString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("e", "integer", "e", "GetExternalString(value)", "")
//textmacro instance: AFormatMethod("externalString", "integer", "e", "GetExternalString(value)", "")
        function s__AFormat_externalString takes integer this,integer value returns integer
            local string positionString= "%e"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + GetExternalString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + GetExternalString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("externalString", "integer", "e", "GetExternalString(value)", "")
    /// Use seconds as parameter!
//textmacro instance: AFormatMethod("t", "integer", "t", "FormatTimeString(value)", "")
        function s__AFormat_t takes integer this,integer value returns integer
            local string positionString= "%t"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + FormatTimeString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + FormatTimeString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("t", "integer", "t", "FormatTimeString(value)", "")
    /// Use seconds as parameter!
//textmacro instance: AFormatMethod("time", "integer", "t", "FormatTimeString(value)", "")
        function s__AFormat_time takes integer this,integer value returns integer
            local string positionString= "%t"
            local integer index= (IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            if ( index == - 1 ) then
                set positionString="%" + I2S(s__AFormat_m_position[this] + 1) + "%"
                set index=(IndexOfStringEx((positionString ) , ( s__AFormat_m_text[this]) , 0)) // INLINED!!
            endif
            
            if ( index != - 1 ) then
                set s__AFormat_m_text[this]=SubString(s__AFormat_m_text[this], 0, index) + FormatTimeString(value) + SubString(s__AFormat_m_text[this], index + StringLength(positionString), StringLength(s__AFormat_m_text[this]))
                set s__AFormat_m_position[this]=s__AFormat_m_position[this] + 1
            else
                call BJDebugMsg("Format error in string \"" + s__AFormat_m_text[this] + "\" at position " + I2S(s__AFormat_m_position[this]) + " for token argument \"" + FormatTimeString(value) + "\".")
            endif
            
            return this
        endfunction
//end of: AFormatMethod("time", "integer", "t", "FormatTimeString(value)", "")

    
    function s__AFormat_result takes integer this returns string
        local string result= s__AFormat_m_text[this]
        call s__AFormat_deallocate(this)
        return result
    endfunction

    
    function s__AFormat_create takes string text returns integer
        local integer this= s__AFormat__allocate()
        set s__AFormat_m_position[this]=0
        set s__AFormat_m_text[this]=text
        return this
    endfunction


function String takes integer format returns string
    return s__AFormat_result(format)
endfunction


function Format takes string text returns integer
    return s__AFormat_create(text)
endfunction


//library StringFormat ends
//library UnitDex:

    ///! external ObjectMerger w3a Adef uDex anam "Detect Leave" ansf "(UnitDex)" aart "" acat "" arac 0


  
  
    function GetUnitId takes unit whichUnit returns integer
        return GetUnitUserData(whichUnit)
    endfunction
  
    function GetUnitById takes integer index returns unit
        return s__UnitDex_Unit[index]
    endfunction
  
    function GetIndexedUnit takes nothing returns unit
        return s__UnitDex_Unit[s__UnitDex_LastIndex]
    endfunction
  
    function GetIndexedUnitId takes nothing returns integer
        return s__UnitDex_LastIndex
    endfunction
  
    function IsUnitIndexed takes unit u returns boolean
        return ( (s__UnitDex_Unit[((GetUnitUserData((u))))]) != null ) // INLINED!!
    endfunction
  
    function UnitDexEnable takes boolean flag returns nothing
        set s__UnitDex_Enabled=flag
    endfunction
  
    function IsIndexingEnabled takes nothing returns boolean
        return s__UnitDex_Enabled
    endfunction
  
    function RegisterUnitIndexEvent takes boolexpr func,integer eventtype returns triggercondition
        return TriggerAddCondition(UnitDex___IndexTrig[eventtype], func)
    endfunction
  
    function RemoveUnitIndexEvent takes triggercondition c,integer eventtype returns nothing
        call TriggerRemoveCondition(UnitDex___IndexTrig[eventtype], c)
    endfunction
  
    function TriggerRegisterUnitIndexEvent takes trigger t,integer eventtype returns nothing
        call TriggerRegisterVariableEvent(t, "UnitDex___E", EQUAL, eventtype)
    endfunction
  
    function OnUnitIndex takes code func returns triggercondition
        return TriggerAddCondition(UnitDex___IndexTrig[EVENT_UNIT_INDEX], Filter(func))
    endfunction

    function OnUnitDeindex takes code func returns triggercondition
        return TriggerAddCondition(UnitDex___IndexTrig[EVENT_UNIT_DEINDEX], Filter(func))
    endfunction
  
    
  
  
      
      
//Implemented from module UnitDex___UnitDexConfig:
  
        // The raw code of the leave detection ability.
        //static constant integer DETECT_LEAVE_ABILITY = 'uDex'
        // Barade: For World of Warcraft Reforged.
      
        // Allow debug messages (debug mode must also be on)
      
        // Uncomment the lines below to define a global filter for units being indexed
      
        
      
      
      
//Implemented from module UnitDex___UnitDexCore:
  
        function s__UnitDex_Remove takes unit u,boolean runEvents returns boolean
            local integer i
          
            if ( ((s__UnitDex_Unit[((GetUnitUserData(((u)))))]) != null) ) then // INLINED!!
                set i=(GetUnitUserData((u))) // INLINED!!
                set s__UnitDex_List[i]=UnitDex___Index
                set UnitDex___Index=i
              
                call GroupRemoveUnit(s__UnitDex_Group, u)
                call SetUnitUserData(u, 0)
          
                if ( runEvents ) then
                    set s__UnitDex_LastIndex=i
                    set UnitDex___E=EVENT_UNIT_DEINDEX
                    call TriggerEvaluate(UnitDex___IndexTrig[EVENT_UNIT_DEINDEX])
                    set UnitDex___E=- 1
                endif
              
                set s__UnitDex_Unit[i]=null
                set s__UnitDex_Count=s__UnitDex_Count - 1
              
                return true
            endif
          
            return false
        endfunction
      
        function s__UnitDex_UnitDex___UnitDexCore___onGameStart takes nothing returns nothing
            local integer i= 1
          
            loop
                exitwhen i > s__UnitDex_Counter
              
                set s__UnitDex_LastIndex=i
              
                call TriggerEvaluate(UnitDex___IndexTrig[EVENT_UNIT_INDEX])
                set UnitDex___E=EVENT_UNIT_INDEX
                set UnitDex___E=- 1
              
                set i=i + 1
            endloop

            set s__UnitDex_LastIndex=s__UnitDex_Counter
            set s__UnitDex_Initialized=true
            set UnitDex___FilterEnter=null
          
            call DestroyTimer(GetExpiredTimer())
        endfunction
      
        function s__UnitDex_UnitDex___UnitDexCore___onEnter takes nothing returns boolean
            local unit u= GetFilterUnit()
            local integer i= (GetUnitUserData((u))) // INLINED!!
            local integer t= UnitDex___Index
          
            if ( i == 0 and s__UnitDex_Enabled ) then
              
                // If a filter was defined pass the unit through it.






              
                // Handle debugging







              
                // Add to group of indexed units
                call GroupAddUnit(s__UnitDex_Group, u)
              
                // Give unit the leave detection ability
                call UnitAddAbility(u, s__UnitDex_DETECT_LEAVE_ABILITY)
                call UnitMakeAbilityPermanent(u, true, s__UnitDex_DETECT_LEAVE_ABILITY)
              
                // Allocate index
                if ( UnitDex___Index != 0 ) then
                    set UnitDex___Index=s__UnitDex_List[t]
                else
                    set s__UnitDex_Counter=s__UnitDex_Counter + 1
                    set t=s__UnitDex_Counter
                endif
              
                set s__UnitDex_List[t]=- 1
                set s__UnitDex_LastIndex=t
                set s__UnitDex_Unit[t]=u
                set s__UnitDex_Count=s__UnitDex_Count + 1
              
                // Store the index
                call SetUnitUserData(u, t)
              
                if ( s__UnitDex_Initialized ) then
                    // Execute custom events registered with RegisterUnitIndexEvent
                    call TriggerEvaluate(UnitDex___IndexTrig[EVENT_UNIT_INDEX])
                  
                    // Handle TriggerRegisterUnitIndexEvent
                    set UnitDex___E=EVENT_UNIT_INDEX

                    // Reset so the event can occur again
                    set UnitDex___E=- 1
                endif
            endif
          
            set u=null
          
            return false
        endfunction

        function s__UnitDex_UnitDex___UnitDexCore___onLeave takes nothing returns boolean
            local unit u
            local integer i
          
            // Check if order is undefend.
            if ( s__UnitDex_Enabled and GetIssuedOrderId() == 852056 ) then
              
                set u=GetTriggerUnit()
              
                // If unit was killed (not removed) then don't continue
                if ( GetUnitAbilityLevel(u, s__UnitDex_DETECT_LEAVE_ABILITY) != 0 ) then
                    set u=null
                    return false
                endif
              
                set i=(GetUnitUserData((u))) // INLINED!!

                // If unit has been indexed then deindex it
                if ( i > 0 and i <= s__UnitDex_Counter and u == (s__UnitDex_Unit[(i)]) ) then // INLINED!!
                  
                    // Recycle the index
                    set s__UnitDex_List[i]=UnitDex___Index
                    set UnitDex___Index=i
                    set s__UnitDex_LastIndex=i
                  
                    // Remove to group of indexed units
                    call GroupRemoveUnit(s__UnitDex_Group, u)
              
                    // Execute custom events without any associated triggers
                    call TriggerEvaluate(UnitDex___IndexTrig[EVENT_UNIT_DEINDEX])
                  
                    // Handle TriggerRegisterUnitIndexEvent
                    set UnitDex___E=EVENT_UNIT_DEINDEX
                  
                    // Remove entry
                    call SetUnitUserData(u, 0)
                    set s__UnitDex_Unit[i]=null
                  
                    // Decrement unit count
                    set s__UnitDex_Count=s__UnitDex_Count - 1
              
                    // Reset so the event can occur again
                    set UnitDex___E=- 1
                endif
              
                set u=null
            endif
          
            return false
        endfunction
      
        function s__UnitDex_UnitDex___UnitDexCore___onInit takes nothing returns nothing
            local trigger t= CreateTrigger()
            local integer i= 0
            local player p
            local unit u
          




          

                local group ENUM_GROUP= CreateGroup()

          
            set UnitDex___FilterEnter=Filter(function s__UnitDex_UnitDex___UnitDexCore___onEnter)
          
            // Begin to index units when they enter the map

                call TriggerRegisterEnterRegion(CreateTrigger(), s__WorldBounds_worldRegion, UnitDex___FilterEnter)






          
            call TriggerAddCondition(t, Filter(function s__UnitDex_UnitDex___UnitDexCore___onLeave))
          
            set UnitDex___IndexTrig[EVENT_UNIT_INDEX]=CreateTrigger()
            set UnitDex___IndexTrig[EVENT_UNIT_DEINDEX]=CreateTrigger()
          
            loop
                set p=Player(i)
              
                // Detect "undefend"
                call TriggerRegisterPlayerUnitEvent(t, p, EVENT_PLAYER_UNIT_ISSUED_ORDER, null)
              
                // Hide the detect ability from players
                call SetPlayerAbilityAvailable(p, s__UnitDex_DETECT_LEAVE_ABILITY, false)
              
                set i=i + 1
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
          
            // Index preplaced units
            set i=0
            loop
                call GroupEnumUnitsOfPlayer(ENUM_GROUP, Player(i), UnitDex___FilterEnter)
              
                set i=i + 1
              
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
          

                call DestroyGroup(ENUM_GROUP)
                set ENUM_GROUP=null


            set s__UnitDex_LastIndex=s__UnitDex_Counter
          
            // run init triggers
            call TimerStart(CreateTimer(), 0.00, false, function s__UnitDex_UnitDex___UnitDexCore___onGameStart)
        endfunction
  
  
    function UnitDexRemove takes unit u,boolean runEvents returns boolean
        return s__UnitDex_Remove(u , runEvents)
    endfunction
  
    
    
  

//library UnitDex ends
//library Resources:


function Resources___GetAlliesWithSharedControl takes player owner returns force
    local force allies= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) ) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return allies
endfunction

function Resources___ShowFadingTextTag takes unit worker,integer amount,integer red,integer green,integer blue returns nothing
    local texttag textTag= CreateTextTag()
    local force allies= Resources___GetAlliesWithSharedControl(GetOwningPlayer(worker))
    call SetTextTagText(textTag, "+" + I2S(amount), 0.024)
    call SetTextTagPos(textTag, GetUnitX(worker), GetUnitY(worker), 0.0)
    call SetTextTagColor(textTag, red, green, blue, 255)
    call SetTextTagVelocity(textTag, 0.0, 0.03)
    if ( IsPlayerInForce(GetLocalPlayer(), allies) ) then
        call SetTextTagVisibility(textTag, true)
    endif
    call SetTextTagFadepoint(textTag, 2.0)
    call SetTextTagLifespan(textTag, 3.0)
    call SetTextTagPermanent(textTag, false)
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
    set textTag=null
endfunction

// u0 - worker/source
// u1 - return building/mine/target
function Resources___MovementTypesMatch takes unit u0,unit u1 returns boolean
    local movetype mt0= ConvertMoveType(BlzGetUnitIntegerField(u0, UNIT_IF_MOVE_TYPE))
    local real targetX= GetUnitX(u1)
    local real targetY= GetUnitY(u1)
    // air
    if ( mt0 == MOVE_TYPE_FLY and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_FLYABILITY) ) then
        return true
    // water or ground
    elseif ( mt0 == MOVE_TYPE_AMPHIBIOUS and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_AMPHIBIOUSPATHING) ) then
        return true
    // water
    elseif ( mt0 == MOVE_TYPE_FLOAT and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_FLOATABILITY) ) then
        return true
    // ground
    elseif ( ( mt0 == MOVE_TYPE_FOOT or mt0 == MOVE_TYPE_HORSE or mt0 == MOVE_TYPE_HOVER ) and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_WALKABILITY) ) then
        return true
    endif
    
    return false
endfunction

    
    function s__Resource_create takes string name returns integer
        local integer this= s__Resource__allocate()
        local integer i= 0
        set s__Resource_name[this]=name
        set s__Resource_goldExchangeRate[this]=s__Resource_goldExchangeRate[this]
        set s__Resource_resources[s__Resource_resourcesCount]=this
        set s__Resource_resourcesCount=s__Resource_resourcesCount + 1
        return this
    endfunction
    

function GetResource takes integer index returns integer
    return s__Resource_resources[index]
endfunction

function GetMaxResources takes nothing returns integer
    return s__Resource_resourcesCount
endfunction

function GetResourceInfo takes integer r,player whichPlayer returns string
    return s__Resource_name[r] + " (" + R2SW(s__Resource_goldExchangeRate[r], 0, 1) + ") - " + I2S(s___Resource_playerAmount[s__Resource_playerAmount[r]+GetPlayerId(whichPlayer)])
endfunction

function GetAllResourcesInfo takes player whichPlayer returns string
    local string msg= "Resources: "
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        if ( i > 0 ) then
            set msg=msg + ", "
        endif
        set msg=msg + I2S(i) + ": " + GetResourceInfo((s__Resource_resources[(i)]) , whichPlayer) // INLINED!!
        set i=i + 1
    endloop
    return msg
endfunction

function AddResource takes string name returns integer
    return s__Resource_create(name)
endfunction

function SetResourceName takes integer resource,string name returns nothing
    set s__Resource_name[resource]=s__Resource_name[resource]
endfunction

function GetResourceName takes integer resource returns string
    return s__Resource_name[resource]
endfunction

function SetResourceIcon takes integer resource,string icon returns nothing
    set s__Resource_icon[resource]=icon
endfunction

function GetResourceIcon takes integer resource returns string
    return s__Resource_icon[resource]
endfunction

function SetResourceIconAtt takes integer resource,string icon returns nothing
    set s__Resource_iconAtt[resource]=icon
endfunction

function GetResourceIconAtt takes integer resource returns string
    return s__Resource_iconAtt[resource]
endfunction

function SetResourceDescription takes integer resource,string description returns nothing
    set s__Resource_description[resource]=description
endfunction

function GetResourceDescription takes integer resource returns string
    return s__Resource_description[resource]
endfunction

function SetResourceGoldExchangeRate takes integer resource,real goldExchangeRate returns nothing
    set s__Resource_goldExchangeRate[resource]=goldExchangeRate
endfunction

function GetResourceGoldExchangeRate takes integer resource returns real
    return s__Resource_goldExchangeRate[resource]
endfunction

function SetResourceColorRed takes integer resource,integer red returns nothing
    set s__Resource_red[resource]=red
endfunction

function GetResourceColorRed takes integer resource returns integer
    return s__Resource_red[resource]
endfunction

function SetResourceColorGreen takes integer resource,integer green returns nothing
    set s__Resource_green[resource]=green
endfunction

function GetResourceColorGreen takes integer resource returns integer
    return s__Resource_green[resource]
endfunction

function SetResourceColorBlue takes integer resource,integer blue returns nothing
    set s__Resource_blue[resource]=blue
endfunction

function GetResourceColorBlue takes integer resource returns integer
    return s__Resource_blue[resource]
endfunction


function SetPlayerResource takes player whichPlayer,integer resource,integer amount returns nothing
    set s___Resource_playerAmount[s__Resource_playerAmount[resource]+GetPlayerId(whichPlayer)]=amount
    if ( resource == Resources_GOLD ) then
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, amount)
    elseif ( resource == Resources_LUMBER ) then
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, amount)
    endif
endfunction

function GetPlayerResource takes player whichPlayer,integer resource returns integer
    if ( resource == Resources_GOLD ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
    elseif ( resource == Resources_LUMBER ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
     elseif ( resource == Resources_FOOD ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED)
    elseif ( resource == Resources_FOOD_MAX ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP)
    endif
    
    return s___Resource_playerAmount[s__Resource_playerAmount[resource]+GetPlayerId(whichPlayer)]
endfunction

function SetPlayerResourceBonus takes player whichPlayer,integer resource,integer bonus returns nothing
    set s___Resource_playerBonus[s__Resource_playerBonus[resource]+GetPlayerId(whichPlayer)]=bonus
endfunction

function GetPlayerResourceBonus takes player whichPlayer,integer resource returns integer
    return s___Resource_playerBonus[s__Resource_playerBonus[resource]+GetPlayerId(whichPlayer)]
endfunction

function AddPlayerResourceBonus takes player whichPlayer,integer resource,integer bonus returns nothing
    call SetPlayerResourceBonus(whichPlayer , resource , GetPlayerResourceBonus(whichPlayer , resource) + bonus)
endfunction

function RemovePlayerResourceBonus takes player whichPlayer,integer resource,integer bonus returns nothing
    call SetPlayerResourceBonus(whichPlayer , resource , GetPlayerResourceBonus(whichPlayer , resource) - bonus)
endfunction

function AddPlayerResource takes player whichPlayer,integer resource,integer amount returns nothing
    call SetPlayerResource(whichPlayer , resource , GetPlayerResource(whichPlayer , resource) + amount)
endfunction

function RemovePlayerResource takes player whichPlayer,integer resource,integer amount returns nothing
    call SetPlayerResource(whichPlayer , resource , IMaxBJ(0, GetPlayerResource(whichPlayer , resource) - amount))
endfunction

function SetPlayerResourceUpkeepRate takes player whichPlayer,integer resource,integer upkeepRate returns nothing
    set s___Resource_playerUpkeepRate[s__Resource_playerUpkeepRate[resource]+GetPlayerId(whichPlayer)]=upkeepRate
endfunction

function GetPlayerResourceUpkeepRate takes player whichPlayer,integer resource returns integer
    if ( resource == Resources_GOLD ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_GOLD_UPKEEP_RATE)
    elseif ( resource == Resources_LUMBER ) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_LUMBER_UPKEEP_RATE)
    endif
    return s___Resource_playerUpkeepRate[s__Resource_playerUpkeepRate[resource]+GetPlayerId(whichPlayer)]
endfunction

function GivePlayerResource takes player from,player to,integer resource,integer amount,real cost returns integer
    local integer actualAmount= R2I(I2R(amount) * cost)
    set actualAmount=IMaxBJ(GetPlayerResource(from , resource), actualAmount)
    call RemovePlayerResource(from , resource , actualAmount)
    call AddPlayerResource(to , resource , actualAmount)
    return actualAmount
endfunction

function GetExchangedResource takes integer source,integer target,integer amount returns integer
    return R2I(s__Resource_goldExchangeRate[source] * I2R(amount) / s__Resource_goldExchangeRate[target])
endfunction

function ExchangePlayerResource takes player whichPlayer,integer source,integer target,integer amount returns integer
    local integer actualAmount= IMinBJ(GetPlayerResource(whichPlayer , source), amount)
    local integer targetAmount= GetExchangedResource(source , target , actualAmount)
    
    //call BJDebugMsg("Get target amount " + I2S(targetAmount) + " with source gold exchange rate " + R2S(source.goldExchangeRate) + " and source resource name " + GetResourceName(source))
    
    if ( targetAmount > 0 ) then
        call RemovePlayerResource(whichPlayer , source , actualAmount)
        call AddPlayerResource(whichPlayer , target , targetAmount)
    endif
    
    return targetAmount
endfunction

function GetUnitResource takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RESOURCE , Resources___KEY_MAX))
endfunction

function SetUnitResource takes unit whichUnit,integer r,integer amount returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RESOURCE , Resources___KEY_MAX), amount)
endfunction

function SetUnitResourceMax takes unit whichUnit,integer r,integer max returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX), max)
endfunction

function GetUnitResourceMax takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))
endfunction

function SetUnitResourcePerHit takes unit whichUnit,integer r,integer amount returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RESOURCE_PER_HIT , Resources___KEY_MAX), amount)
endfunction

function GetUnitResourcePerHit takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RESOURCE_PER_HIT , Resources___KEY_MAX))
endfunction

function SetUnitMine takes unit whichUnit,unit mine returns nothing
    call SaveUnitHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_MINE , Resources___KEY_MAX), mine)
endfunction

function GetUnitMine takes unit whichUnit returns unit
    return LoadUnitHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_MINE , Resources___KEY_MAX))
endfunction

function SetUnitReturnResource takes unit whichUnit,integer r,boolean allow returns nothing
    call SaveBoolean(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_RESOURCE , Resources___KEY_MAX), allow)
endfunction

function GetUnitReturnResource takes unit whichUnit,integer r returns boolean
    return LoadBoolean(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_RESOURCE , Resources___KEY_MAX))
endfunction

function AddUnitReturnResource takes unit whichUnit,integer r returns nothing
    call SetUnitReturnResource(whichUnit , r , true)
endfunction

function SetUnitHarvestOrderId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitHarvestOrderId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))
endfunction

function SetUnitHarvestAbilityId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitHarvestAbilityId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))
endfunction

function SetUnitReturnOrderId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitReturnOrderId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX))
endfunction

function SetUnitReturnAbilityId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitReturnAbilityId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))
endfunction

function SetUnitReturnHiddenOrderId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitReturnHiddenOrderId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))
endfunction

function SetUnitReturnHiddenAbilityId takes unit whichUnit,integer r,integer orderId returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_HIDDEN_ABILITY_ID , Resources___KEY_MAX), orderId)
endfunction

function GetUnitReturnHiddenAbilityId takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_RETURN_HIDDEN_ABILITY_ID , Resources___KEY_MAX))
endfunction

function IsMine takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, Resources___mines)
endfunction

function SetUnitHarvestDuration takes unit whichUnit,integer r,real duration returns nothing
    call SaveReal(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_DURATION , Resources___KEY_MAX), duration)
endfunction

function GetUnitHarvestDuration takes unit whichUnit,integer r returns real
    return LoadReal(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_HARVEST_DURATION , Resources___KEY_MAX))
endfunction

function SetMineExplodesOnDeath takes unit mine,boolean explode returns nothing
    call SaveBoolean(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_EXPLODE_ON_DEATH , Resources___KEY_MAX), explode)
endfunction

function GetMineExplodesOnDeath takes unit mine returns boolean
    return LoadBoolean(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_EXPLODE_ON_DEATH , Resources___KEY_MAX))
endfunction

function SetMineWorkers takes unit mine,group l__Resources___workers returns nothing
    call SaveGroupHandle(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX), l__Resources___workers)
endfunction

function GetMineWorkers takes unit mine returns group
    return LoadGroupHandle(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX))
endfunction

function SetMineMaxWorkers takes unit mine,integer max returns nothing
    call SaveInteger(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_MAX_MINE_WORKERS , Resources___KEY_MAX), max)
endfunction

function GetMineMaxWorkers takes unit mine returns integer
    return LoadInteger(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_MAX_MINE_WORKERS , Resources___KEY_MAX))
endfunction

function SetMineTakeWorkerInside takes unit mine,boolean take returns nothing
    call SaveBoolean(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_TAKE_WORKER_INSIDE , Resources___KEY_MAX), take)
endfunction

function GetMineTakeWorkerInside takes unit mine returns boolean
    return LoadBoolean(Resources___h, GetHandleId(mine), Index2D(0 , Resources___KEY_TAKE_WORKER_INSIDE , Resources___KEY_MAX))
endfunction

function SetUnitResourceAnimationProperties takes unit whichUnit,integer r,string animationProperties returns nothing
    call SaveStr(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX), animationProperties)
endfunction

function GetUnitResourceAnimationProperties takes unit whichUnit,integer r returns string
    return LoadStr(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))
endfunction

function SetUnitResourceSkin takes unit whichUnit,integer r,integer skin returns nothing
    call SaveInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_SKIN , Resources___KEY_MAX), skin)
endfunction

function GetUnitResourceSkin takes unit whichUnit,integer r returns integer
    return LoadInteger(Resources___h, GetHandleId(whichUnit), Index2D(r , Resources___KEY_SKIN , Resources___KEY_MAX))
endfunction

function SetUnitQueueTimer takes unit whichUnit,timer t returns nothing
    call SaveTimerHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_QUEUE_TIMER , Resources___KEY_MAX), t)
endfunction

function GetUnitQueueTimer takes unit whichUnit returns timer
    return LoadTimerHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_QUEUE_TIMER , Resources___KEY_MAX))
endfunction

function SetUnitQueueWorkerReleaseTimer takes unit whichUnit,timer t returns nothing
    call SaveTimerHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_QUEUE_WORKER_RELEASE_TIMER , Resources___KEY_MAX), t)
endfunction

function GetUnitQueueWorkerReleaseTimer takes unit whichUnit returns timer
    return LoadTimerHandle(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_QUEUE_WORKER_RELEASE_TIMER , Resources___KEY_MAX))
endfunction

function SetUnitDisableStopMiningOnError takes unit whichUnit,boolean disable returns nothing
    call SaveBoolean(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_DISABLE_STOP_MINING_ON_ERROR , Resources___KEY_MAX), disable)
endfunction

function GetUnitDisableStopMiningOnError takes unit whichUnit returns boolean
    return LoadBoolean(Resources___h, GetHandleId(whichUnit), Index2D(0 , Resources___KEY_DISABLE_STOP_MINING_ON_ERROR , Resources___KEY_MAX))
endfunction

function AddMine takes unit whichUnit returns nothing
    call GroupAddUnit(Resources___mines, whichUnit)
    call SetMineWorkers(whichUnit , CreateGroup())
endfunction

function AddMineEx takes unit whichUnit,integer resource,integer amount returns nothing
    call AddMine(whichUnit)
    call SetUnitResource(whichUnit , resource , amount)
    call SetMineExplodesOnDeath(whichUnit , true)
    call SetMineTakeWorkerInside(whichUnit , false)
endfunction

function RemoveMine takes unit whichUnit returns nothing
    call GroupRemoveUnit(Resources___mines, whichUnit)
    if ( (LoadGroupHandle(Resources___h, GetHandleId((whichUnit)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX))) != null ) then // INLINED!!
        call DestroyGroup((LoadGroupHandle(Resources___h, GetHandleId((whichUnit)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX)))) // INLINED!!
    endif
endfunction

function IsWorker takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, Resources___workers)
endfunction

function AddWorker takes unit whichUnit returns nothing
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    call GroupAddUnit(Resources___workers, whichUnit)
endfunction

function AddAllResourcesToWorker takes unit worker,integer maxResource,integer resourcePerHit returns nothing
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        call SetUnitResourceMax(worker , (s__Resource_resources[(i)]) , maxResource) // INLINED!!
        call SetUnitResourcePerHit(worker , (s__Resource_resources[(i)]) , resourcePerHit) // INLINED!!
        set i=i + 1
    endloop
endfunction

function AddResourceToWorker takes unit worker,integer resource,integer abilityId,string order,integer returnAbilityId,string returnOrder,integer returnHiddenAbilityId,string returnHiddenOrder,integer max,integer perHit,string animationProperties returns nothing
    call SetUnitHarvestAbilityId(worker , resource , abilityId)
    call SetUnitHarvestOrderId(worker , resource , OrderId(order))
    call SetUnitReturnAbilityId(worker , resource , returnAbilityId)
    call SetUnitReturnOrderId(worker , resource , OrderId(returnOrder))
    call SetUnitReturnHiddenAbilityId(worker , resource , returnHiddenAbilityId)
    call SetUnitReturnHiddenOrderId(worker , resource , OrderId(returnHiddenOrder))
    call SetUnitResourceMax(worker , resource , max)
    call SetUnitResourcePerHit(worker , resource , perHit)
    call SetUnitResourceAnimationProperties(worker , resource , animationProperties)
    // do not ever add the abilities twice since they will be permanently hidden
    if ( GetUnitAbilityLevel(worker, abilityId) == 0 ) then
        call UnitAddAbility(worker, abilityId)
        call UnitMakeAbilityPermanent(worker, true, abilityId)
    endif
    if ( GetUnitAbilityLevel(worker, returnAbilityId) == 0 ) then
        call UnitAddAbility(worker, returnAbilityId)
        call UnitMakeAbilityPermanent(worker, true, returnAbilityId)
        call BlzUnitHideAbility(worker, returnAbilityId, true)
    endif
    if ( GetUnitAbilityLevel(worker, returnHiddenAbilityId) == 0 ) then
        call UnitAddAbility(worker, returnHiddenAbilityId)
        call UnitMakeAbilityPermanent(worker, true, returnHiddenAbilityId)
    endif
    
endfunction

function RemoveWorker takes unit whichUnit returns nothing
    call GroupRemoveUnit(Resources___workers, whichUnit)
endfunction

function IsReturnBuilding takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, Resources___returnBuildings)
endfunction

function AddReturnBuilding takes unit whichUnit returns nothing
    call GroupAddUnit(Resources___returnBuildings, whichUnit)
endfunction

function AddReturnBuildingEx takes unit whichUnit,integer r returns nothing
    call GroupAddUnit(Resources___returnBuildings, (whichUnit)) // INLINED!!
    call SetUnitReturnResource(whichUnit , r , true)
endfunction

function RemoveReturnBuilding takes unit whichUnit returns nothing
    call GroupRemoveUnit(Resources___returnBuildings, whichUnit)
endfunction

function CustomBountyFadingText takes unit worker,integer resource,integer amount returns nothing
    call Resources___ShowFadingTextTag(worker , amount , (s__Resource_red[(resource)]) , (s__Resource_green[(resource)]) , (s__Resource_blue[(resource)])) // INLINED!!
endfunction

function CustomBountyEx takes unit worker,player whichPlayer,integer resource,integer amount returns nothing
    call AddPlayerResource(whichPlayer , resource , amount)
    call CustomBountyFadingText(worker , resource , amount)
endfunction

function CustomBounty takes unit worker,integer resource,integer amount returns nothing
    call CustomBountyEx(worker , GetOwningPlayer(worker) , resource , amount)
endfunction

function GetWorkerTotalResources takes unit worker returns integer
    local integer i= 0
    local integer result= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        set result=result + (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( (s__Resource_resources[(i)])) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
        set i=i + 1
    endloop
    return result
endfunction

function TriggerRegisterGatherEvent takes trigger whichTrigger returns nothing
    set Resources___callbackTriggers[Resources___callbackTriggersCounter]=whichTrigger
    set Resources___callbackTriggersCounter=Resources___callbackTriggersCounter + 1
endfunction

function TriggerRegisterReturnEvent takes trigger whichTrigger returns nothing
    set Resources___callbackReturnTriggers[Resources___callbackReturnTriggersCounter]=whichTrigger
    set Resources___callbackReturnTriggersCounter=Resources___callbackReturnTriggersCounter + 1
endfunction

function TriggerRegisterDeathResourceEvent takes trigger whichTrigger returns nothing
    set Resources___callbackDeathTriggers[Resources___callbackDeathTriggersCounter]=whichTrigger
    set Resources___callbackDeathTriggersCounter=Resources___callbackDeathTriggersCounter + 1
endfunction

function GetTriggerMine takes nothing returns unit
    return Resources___triggerMine
endfunction

function GetTriggerReturnBuilding takes nothing returns unit
    return Resources___triggerReturnBuilding
endfunction

function GetTriggerDyingResourceUnit takes nothing returns unit
    return Resources___triggerDyingResourceUnit
endfunction

function GetTriggerWorker takes nothing returns unit
    return Resources___triggerWorker
endfunction

function GetTriggerResource takes nothing returns integer
    return Resources___triggerResource
endfunction

function GetTriggerResourceAmount takes nothing returns integer
    return Resources___triggerResourceAmount
endfunction

function ExecuteGatherCallbacks takes unit mine,unit worker,integer resource,integer amount returns nothing
    local integer i= 0
    loop
        exitwhen ( i == Resources___callbackTriggersCounter )
        if ( IsTriggerEnabled(Resources___callbackTriggers[i]) ) then
            set Resources___triggerMine=mine
            set Resources___triggerWorker=worker
            set Resources___triggerResource=resource
            set Resources___triggerResourceAmount=amount
            call ConditionalTriggerExecute(Resources___callbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function ExecuteReturnCallbacks takes unit returnBuilding,unit worker,integer resource,integer amount returns nothing
    local integer i= 0
    loop
        exitwhen ( i == Resources___callbackReturnTriggersCounter )
        if ( IsTriggerEnabled(Resources___callbackReturnTriggers[i]) ) then
            set Resources___triggerReturnBuilding=returnBuilding
            set Resources___triggerWorker=worker
            set Resources___triggerResource=resource
            set Resources___triggerResourceAmount=amount
            call ConditionalTriggerExecute(Resources___callbackReturnTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function ExecuteDeathCallbacks takes unit whichUnit returns nothing
    local integer i= 0
    loop
        exitwhen ( i == Resources___callbackReturnTriggersCounter )
        if ( IsTriggerEnabled(Resources___callbackDeathTriggers[i]) ) then
            set Resources___triggerDyingResourceUnit=whichUnit
            call ConditionalTriggerExecute(Resources___callbackDeathTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function IsSmartOrder takes integer orderId returns boolean
    return orderId == OrderId("smart") or orderId == OrderId("move") or orderId == OrderId("patrol")
endfunction

function IsAlliedMine takes unit mine,player whichPlayer returns boolean
    return GetOwningPlayer(mine) == whichPlayer or IsUnitAlly(mine, whichPlayer) or GetOwningPlayer(mine) == Player(PLAYER_NEUTRAL_PASSIVE)
endfunction

function SetWorkerPathing takes unit worker,boolean enable returns nothing
    call SetUnitPathing(worker, enable)
    if ( enable ) then
        // avoids being stuck in return buildings
        // this will crash the game
        // it would be better to reset the pathing as soon as the mine collapses and before returning all resources
        //call SetUnitPosition(worker, GetUnitX(worker), GetUnitY(worker))
    endif
endfunction

function IsMineEmpty takes unit mine returns boolean
    local boolean empty= true
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( i == max or not empty )
        if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( (s__Resource_resources[(i)])) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
            set empty=false
        endif
        set i=i + 1
    endloop
    
    return empty
endfunction

function Gather takes unit worker,unit mine returns integer
    local integer i= 0
    local integer actualAmount= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer resource= 0
    local integer result= 0
    
    // has to be a non-loop animation to stop automatically
    call QueueUnitAnimation(mine, "stand work")
    
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        set actualAmount=IMinBJ((LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))), (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE_PER_HIT , Resources___KEY_MAX)))) // INLINED!!
        //call BJDebugMsg("Actual amount 1: " + I2S(actualAmount))
        if ( actualAmount > 0 ) then
            set actualAmount=IMinBJ(actualAmount, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) - (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))) // INLINED!!
            //call BJDebugMsg("Actual amount 2: " + I2S(actualAmount) + " workerresource amount " + I2S(GetUnitResource(worker, resource)) + " and max resource: " + I2S(GetUnitResourceMax(worker, resource)))
            if ( actualAmount > 0 ) then
                call SetUnitResource(mine , resource , (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) - actualAmount) // INLINED!!
                call SetUnitResource(worker , resource , (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) + actualAmount) // INLINED!!
                if ( (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))) != null and (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))) != "" ) then // INLINED!!
                    call AddUnitAnimationProperties(worker, (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))), true) // INLINED!!
                endif
                if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_SKIN , Resources___KEY_MAX))) != 0 ) then // INLINED!!
                    call BlzSetUnitSkin(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_SKIN , Resources___KEY_MAX)))) // INLINED!!
                endif
                call ExecuteGatherCallbacks(mine , worker , resource , actualAmount)
                //call BJDebugMsg("Actual amount 3: " + I2S(actualAmount))
                set result=result + actualAmount
            endif
        endif
        set i=i + 1
    endloop
    
    call SetUnitMine(worker , mine)
    
    if ( IsMineEmpty(mine) ) then
        if ( (LoadBoolean(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_EXPLODE_ON_DEATH , Resources___KEY_MAX))) ) then // INLINED!!
            call KillUnit(mine)
        else
            call RemoveMine(mine)
        endif
    endif
    
    return result
endfunction


function Resources___FilterFunctionIsMine takes nothing returns boolean
    return (IsUnitInGroup((GetFilterUnit()), Resources___mines)) and Resources___MovementTypesMatch(Resources___filterWorker , GetFilterUnit()) and (LoadInteger(Resources___h, GetHandleId((GetFilterUnit() )), Index2D(( Resources___filterResource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 // INLINED!!
endfunction

function FindNearestMineOfResource takes unit worker,real radius,integer resource returns unit
    local real x= GetUnitX(worker)
    local real y= GetUnitY(worker)
    local group l__Resources___mines= CreateGroup()
    local unit currentMine= null
    local real currentDistance= 0.0
    local real distance= 0.0
    local unit mine= null
    local integer i= 0
    local integer max= 0
    set Resources___filterWorker=worker
    set Resources___filterResource=resource
    call GroupEnumUnitsInRange(l__Resources___mines, x, y, radius, Filter(function Resources___FilterFunctionIsMine))
    set i=0
    set max=BlzGroupGetSize(l__Resources___mines)
    loop
        exitwhen ( i == max )
        set currentMine=BlzGroupUnitAt(l__Resources___mines, i)
        if ( mine == null ) then
            set mine=currentMine
        else
            set currentDistance=DistBetweenCoordinates(x , y , GetUnitX(currentMine) , GetUnitY(currentMine))
            if ( currentDistance < distance ) then
                set mine=currentMine
                set distance=currentDistance
            endif
        endif
        set currentMine=null
        set i=i + 1
    endloop
    call GroupClear(l__Resources___mines)
    call DestroyGroup(l__Resources___mines)
    set l__Resources___mines=null
    return mine
endfunction

function ConstructedReturnBuilding takes unit worker,unit returnBuilding returns unit
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer amount= 0
    local integer result= 0
    local integer resource= 0
    local boolean returnOrder= false
    local unit mine= null
    loop
        exitwhen ( i == max or returnOrder )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadBoolean(Resources___h, GetHandleId((returnBuilding )), Index2D(( resource) , Resources___KEY_RETURN_RESOURCE , Resources___KEY_MAX))) ) then // INLINED!!
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
                set returnOrder=true
                set result=resource
            elseif ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) > amount ) then // INLINED!!
                set result=resource
                set amount=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            endif
        endif
        set i=i + 1
    endloop
    
    if ( result != 0 ) then
        if ( returnOrder ) then
            call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( result) , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))), returnBuilding) // INLINED!!
        else
            set mine=FindNearestMineOfResource(worker , 2048.0 , result)
            if ( mine != null ) then
                call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( result) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))), mine) // INLINED!!
            endif
        endif
    endif
    return mine
endfunction

function ConstructedMine takes unit worker,unit mine returns integer
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer result= 0
    local integer resource= 0
    local boolean returnOrder= false
    loop
        exitwhen ( i == max or returnOrder )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        //call BJDebugMsg("Checking resource " + GetResourceName(resource) + " for worker " + GetUnitName(worker) + " and mine " + GetUnitName(mine))
        if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
            set result=resource
            
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) == (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) ) then // INLINED!!
                set returnOrder=true
            endif
        endif
        set i=i + 1
    endloop
    
    if ( result != 0 ) then
        if ( returnOrder ) then
            call IssueImmediateOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( result) , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX)))) // INLINED!!
            //call BJDebugMsg("Order return")
        else
            call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( result) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))), mine) // INLINED!!
            //call BJDebugMsg("Order harvest for resource " + GetResourceName(result))
        endif
    endif
    
    return result
endfunction

function GetPrimaryResourceForWorker takes unit worker returns integer
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer amount= 0
    local integer result= 0
    local integer resource= 0
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > amount ) then // INLINED!!
            set result=resource
            set amount=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
        endif
        set i=i + 1
    endloop
    
    return result
endfunction

function GetPrimaryMineResourceForWorker takes unit mine,unit worker returns integer
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer workerMax= 0
    local integer mineMax= 0
    local integer result= 0
    local integer resource= 0
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) > 0 and (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 and IsAlliedMine(mine , GetOwningPlayer(worker)) ) then // INLINED!!
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) > workerMax ) then // INLINED!!
                set result=resource
                set workerMax=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            elseif ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) == workerMax and (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > mineMax ) then // INLINED!!
                set result=resource
                set mineMax=(LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            endif
        endif
        set i=i + 1
    endloop
    
    return result
endfunction

function GetResourceFromReturnResourcesAbilityId takes unit worker,integer abilityId returns integer
    local integer i= 0
    local integer v= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer result= 0
    local integer resource= 0
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))) == abilityId and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > v ) then // INLINED!!
            set result=resource
            set v=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
        endif
        set i=i + 1
    endloop
    
    return result
endfunction

function IsReturnResourcesHiddenAbilityId takes unit worker,integer abilityId returns boolean
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( (s__Resource_resources[(i)])) , Resources___KEY_RETURN_HIDDEN_ABILITY_ID , Resources___KEY_MAX))) == abilityId ) then // INLINED!!
            return true
        endif
        set i=i + 1
    endloop
    return false
endfunction

function Resources___TimerFunctionQueue takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local unit worker= LoadUnitHandle(Resources___h, handleId, 0)
    local integer orderId= LoadInteger(Resources___h, handleId, 1)
    local integer abilityId= LoadInteger(Resources___h, handleId, 2)
    local unit mine= LoadUnitHandle(Resources___h, handleId, 3)
    //local real cooldown = BlzGetAbilityRealLevelField(BlzGetUnitAbility(worker, abilityId), ABILITY_RLF_COOLDOWN, 0)
    if ( IsUnitAliveBJ(worker) and IsUnitAliveBJ(mine) ) then
        //call BJDebugMsg("trigger queued order with ID " + I2S(orderId) + " for worker " + GetUnitName(worker) + " to mine " + GetUnitName(mine))
        call IssueTargetOrderById(worker, orderId, mine)
    endif
    call FlushChildHashtable(Resources___h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    call SetUnitQueueTimer(worker , null)
    set t=null
endfunction

function Resources___CancelUnitQueueTimer takes unit worker returns nothing
    local timer t= (LoadTimerHandle(Resources___h, GetHandleId((worker)), Index2D(0 , Resources___KEY_QUEUE_TIMER , Resources___KEY_MAX))) // INLINED!!
    if ( t != null ) then
        call FlushChildHashtable(Resources___h, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif
endfunction

function Resources___QueueOrderEx takes unit worker,integer orderId,integer abilityId,unit mine,real duration returns nothing
    local timer t= null
    local integer handleId= 0
    //call BJDebugMsg("Queue order with order ID " + OrderId2String(orderId) + " with mine " + GetUnitName(mine) + " and duration " + R2S(duration))
    call Resources___CancelUnitQueueTimer(worker)
    if ( duration <= 0.0 ) then
        //call BJDebugMsg("Issue order id immediately to  mine " + GetUnitName(mine))
        call IssueTargetOrderById(worker, orderId, mine)
    else
        set t=CreateTimer()
        set handleId=GetHandleId(t)
        call SaveUnitHandle(Resources___h, handleId, 0, worker)
        call SaveInteger(Resources___h, handleId, 1, orderId)
        call SaveInteger(Resources___h, handleId, 2, abilityId)
        call SaveUnitHandle(Resources___h, handleId, 3, mine)
        call SetUnitQueueTimer(worker , t)
        // add threshold since the timer might not be as precise as the cooldown
        call TimerStart(t, duration, false, function Resources___TimerFunctionQueue)
    endif
endfunction

function Resources___QueueOrder takes unit worker,integer orderId,integer abilityId,unit mine returns nothing
   local real cooldown= BlzGetUnitAbilityCooldownRemaining(worker, abilityId)
   
   if ( cooldown > 0.0 ) then
        // add threshold since the timer might not be as precise as the cooldown
        set cooldown=cooldown + 0.6
    endif
    
    call Resources___QueueOrderEx(worker , orderId , abilityId , mine , cooldown)
endfunction

function ReturnResources takes unit worker,unit returnBuilding returns integer
    local integer i= 0
    local integer actualAmount= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer resource= 0
    local player owner= GetOwningPlayer(worker)
    local unit mine= null
    local integer result= 0
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        set actualAmount=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
        if ( actualAmount > 0 ) then
            set actualAmount=actualAmount + GetPlayerResourceBonus(owner , resource)
        endif
        set actualAmount=actualAmount - ( actualAmount * GetPlayerResourceUpkeepRate(owner , resource) / 100 )
        if ( actualAmount > 0 ) then
            set result=result + (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            call SetUnitResource(worker , resource , 0)
            if ( (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))) != null and (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))) != "" ) then // INLINED!!
                call AddUnitAnimationProperties(worker, (LoadStr(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_ANIMATION_PROPERTIES , Resources___KEY_MAX))), false) // INLINED!!
            endif
            //call BJDebugMsg("returned resource " + GetResourceName(resource))
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_SKIN , Resources___KEY_MAX))) != 0 ) then // INLINED!!
                //call BJDebugMsg("change skin")
                call BlzSetUnitSkin(worker, GetUnitTypeId(worker))
            endif
            call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))), true) // INLINED!!
            //call BJDebugMsg("hide return ability " + GetObjectName(GetUnitReturnAbilityId(worker, resource)) + " for worker " + GetUnitName(worker))
            call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))), false) // INLINED!!
            //call BJDebugMsg("Fading text")
            call CustomBounty(worker , resource , actualAmount) // adds the resource to the player
            call ExecuteReturnCallbacks(returnBuilding , worker , resource , actualAmount)
        endif
        set i=i + 1
    endloop

    // continue harvest
    set mine=(LoadUnitHandle(Resources___h, GetHandleId((worker)), Index2D(0 , Resources___KEY_MINE , Resources___KEY_MAX))) // INLINED!!
    if ( mine != null and IsUnitAliveBJ(mine) ) then
        // TODO Continue with the previous resource
        set resource=GetPrimaryMineResourceForWorker(mine , worker)
        //call BJDebugMsg("Continue harvest with primary resource" + GetResourceName(resource))
        if ( resource != 0 ) then
            //call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, resource), mine)
            // consider cooldown
            call Resources___QueueOrder(worker , (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))) , (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))) , mine) // INLINED!!
        else
            call SetWorkerPathing(worker , true)
        endif
    else
        call SetWorkerPathing(worker , true)
        // will find another mine
        call ConstructedReturnBuilding(worker , returnBuilding)
    endif
    
    set owner=null
    set mine=null
    
    return result
endfunction

function Resources___FilterFunctionReturnBuilding takes nothing returns boolean
    return (IsUnitInGroup((GetFilterUnit()), Resources___returnBuildings)) and Resources___MovementTypesMatch(Resources___filterWorker , GetFilterUnit()) // INLINED!!
endfunction

function NextReturnBuilding takes unit worker returns unit
    local group l__Resources___returnBuildings= CreateGroup()
    local integer resource= 0
    local unit groupMember= null
    local real groupMemberDistance= 0.0
    local real distance= 0.0
    local unit result= null
    local integer i= 0
    local integer max= 0
    local integer j= 0
    local integer max2= 0
    local boolean valid= false
    set Resources___filterWorker=worker
    call GroupEnumUnitsOfPlayer(l__Resources___returnBuildings, GetOwningPlayer(worker), Filter(function Resources___FilterFunctionReturnBuilding))
    set max=BlzGroupGetSize(l__Resources___returnBuildings)
    loop
        exitwhen ( i == max )
        set groupMember=BlzGroupUnitAt(l__Resources___returnBuildings, i)
        //call BJDebugMsg("Checking return building "  + GetUnitName(groupMember))
        
        set valid=false
        set j=0
        set max2=(s__Resource_resourcesCount) // INLINED!!
        loop
            exitwhen ( j == max2 )
            set resource=(s__Resource_resources[(j)]) // INLINED!!
            //call BJDebugMsg("Resource "  + GetResourceName(resource) + " carrying " + I2S(GetUnitResource(worker, resource)))
            if ( (LoadBoolean(Resources___h, GetHandleId((groupMember )), Index2D(( resource) , Resources___KEY_RETURN_RESOURCE , Resources___KEY_MAX))) and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
                //call BJDebugMsg("Enable for resource "  + GetResourceName(resource))
                set valid=true
            endif
            set j=j + 1
        endloop
        
        if ( valid ) then
            set groupMemberDistance=DistanceBetweenUnits(worker , groupMember)
            if ( result == null or groupMemberDistance < distance ) then
                set result=groupMember
                set distance=groupMemberDistance
            endif
        else
            //call BJDebugMsg("Disabled")
        endif
        set groupMember=null
        set i=i + 1
    endloop
    
    call GroupClear(l__Resources___returnBuildings)
    call DestroyGroup(l__Resources___returnBuildings)
    set l__Resources___returnBuildings=null
    
    return result
endfunction

function Resources___HasMaxOfMineResources takes unit worker,unit mine returns boolean
    local integer i= 0
    local integer actualAmount= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer resource= 0
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) < (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) ) then // INLINED!!
            return false
        endif
        set i=i + 1
    endloop
    return true
endfunction

function ReleaseWorkerFromMine takes unit worker,unit mine returns nothing
    call ShowUnit(worker, true)
    call SetUnitInvulnerable(worker, false)
    call GroupRemoveUnit((LoadGroupHandle(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX))), worker) // INLINED!!
    if ( BlzGroupGetSize((LoadGroupHandle(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX)))) == 0 ) then // INLINED!!
        call ResetUnitAnimation(mine)
    endif
endfunction

function AddWorkerToMine takes unit worker,unit mine returns nothing
    call SelectUnitRemove(worker)
    call ShowUnit(worker, false)
    call SetUnitInvulnerable(worker, true)
    call GroupAddUnit((LoadGroupHandle(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX))), worker) // INLINED!!
    call QueueUnitAnimation(mine, "stand work")
endfunction

function ReleaseAllWorkersFromMine takes unit mine returns nothing
    local unit first= null
    loop
        set first=FirstOfGroup((LoadGroupHandle(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX)))) // INLINED!!
        exitwhen ( first == null )
        call ReleaseWorkerFromMine(first , mine)
    endloop
endfunction

function Resources___TimerFunctionReleaseWorkerFromMine takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local unit worker= LoadUnitHandle(Resources___h, handleId, 0)
    local unit mine= LoadUnitHandle(Resources___h, handleId, 1)
    local integer resource= LoadInteger(Resources___h, handleId, 2)
    local integer amount= Gather(worker , mine)
    
    // did not explode
    if ( IsUnitAliveBJ(mine) ) then
        call ReleaseWorkerFromMine(worker , mine)
        //all BJDebugMsg("Release worker with resource " + GetResourceName(resource))
    endif
    
    //call BJDebugMsg("Show and order return ability " + GetObjectName(GetUnitReturnAbilityId(worker, resource)))
    call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))), true) // INLINED!!
    call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))), false) // INLINED!!
    call IssueImmediateOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX)))) // INLINED!!
    
    call FlushChildHashtable(Resources___h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    call SetUnitQueueWorkerReleaseTimer(worker , null)
    set t=null
endfunction

function Resources___CancelUnitQueueWorkerReleaseTimer takes unit worker returns nothing
    local timer t= (LoadTimerHandle(Resources___h, GetHandleId((worker)), Index2D(0 , Resources___KEY_QUEUE_WORKER_RELEASE_TIMER , Resources___KEY_MAX))) // INLINED!!
    if ( t != null ) then
        call FlushChildHashtable(Resources___h, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif
endfunction

function Resources___QueueWorkerRelease takes unit worker,unit mine,integer resource returns nothing
    local real duration= (LoadReal(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_DURATION , Resources___KEY_MAX))) // INLINED!!
    local timer t= null
    local integer handleId= 0
    //call BJDebugMsg("Queue order with cooldown " + R2S(duration) + " and worker handle ID " + I2S(GetHandleId(worker)) + " for resource " + GetResourceName(resource))
    call Resources___CancelUnitQueueWorkerReleaseTimer(worker)
    if ( duration <= 0.0 ) then
        call Gather(worker , mine)
        call ReleaseWorkerFromMine(worker , mine)
        call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))), true) // INLINED!!
        call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))), false) // INLINED!!
        call IssueImmediateOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX)))) // INLINED!!
        //call BJDebugMsg("Immediate release")
    else
        set t=CreateTimer()
        set handleId=GetHandleId(t)
        call SaveUnitHandle(Resources___h, handleId, 0, worker)
        call SaveUnitHandle(Resources___h, handleId, 1, mine)
        call SaveInteger(Resources___h, handleId, 2, resource)
        call SetUnitQueueWorkerReleaseTimer(worker , t)
        call TimerStart(t, duration, false, function Resources___TimerFunctionReleaseWorkerFromMine)
    endif
endfunction

function GatherInsideMine takes unit worker,unit mine,integer resource returns nothing
    call AddWorkerToMine(worker , mine)
    call Resources___QueueWorkerRelease(worker , mine , resource)
endfunction

function Resources___TriggerActionCast takes nothing returns nothing
    local integer abilityId= GetSpellAbilityId()
    local unit worker= GetTriggerUnit()
    local unit mine= GetSpellTargetUnit()
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer matchingResources= 0
    local integer nonEmptyResources= 0
    local integer amount= 0
    local integer foundResource= 0
    local integer resource= 0
    local boolean queued= false
    local boolean gatherInside= (LoadBoolean(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_TAKE_WORKER_INSIDE , Resources___KEY_MAX))) // INLINED!!
    if ( IsAlliedMine(mine , GetOwningPlayer(worker)) ) then
        loop
            exitwhen ( i == max )
            set resource=(s__Resource_resources[(i)]) // INLINED!!
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))) == abilityId ) then // INLINED!!
                //call BJDebugMsg("Harvest ability for resource: " + GetResourceName(resource) + " with mine " + GetUnitName(mine))
                set matchingResources=matchingResources + 1
                if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
                    set nonEmptyResources=nonEmptyResources + 1
                    set foundResource=resource
                    if ( not gatherInside ) then
                        set amount=amount + Gather(worker , mine)
                    endif
                    //call BJDebugMsg("Gathered: " + I2S(amount))
                endif
            endif
            set i=i + 1
        endloop
    endif

    if ( gatherInside and foundResource != 0 ) then
        //call BJDebugMsg("Worker with handle ID wants to harvest inside mine " + I2S(GetHandleId(worker)))
        if ( (LoadInteger(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MAX_MINE_WORKERS , Resources___KEY_MAX))) == 0 or BlzGroupGetSize((LoadGroupHandle(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MINE_WORKERS , Resources___KEY_MAX)))) < (LoadInteger(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_MAX_MINE_WORKERS , Resources___KEY_MAX))) ) then // INLINED!!
            call GatherInsideMine(worker , mine , foundResource)
        else
            // queue harvest until the mine has a free slot
            set queued=true
            call Resources___QueueOrderEx(worker , (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))) , abilityId , mine , 0.5) // INLINED!!
            //call BJDebugMsg("Queue for free slot for resource " + GetResourceName(foundResource) + " and worker with handle ID " + I2S(GetHandleId(worker)) + " and order " + OrderId2String(GetUnitHarvestOrderId(worker, foundResource)))
        endif
    elseif ( matchingResources > 0 and nonEmptyResources == 0 ) then
        call IssueImmediateOrder(worker, "stop")
        //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
        //call BJDebugMsg("Stop worker " + GetUnitName(worker))
    elseif ( not gatherInside and foundResource != 0 and amount == 0 or Resources___HasMaxOfMineResources(worker , mine) ) then // return resources if necessary
        call IssueImmediateOrder(worker, "stop")
        //call BJDebugMsg("has max looking for return building")
        if ( GetWorkerTotalResources(worker) > 0 ) then
            call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_HARVEST_ABILITY_ID , Resources___KEY_MAX))), true) // INLINED!!
            call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))), false) // INLINED!!
            //call BJDebugMsg("Show return ability " + GetObjectName(GetUnitReturnAbilityId(worker, foundResource)) + " with level on unit " + I2S(GetUnitAbilityLevel(worker, GetUnitReturnAbilityId(worker, foundResource))))
            call IssueImmediateOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_RETURN_ORDER_ID , Resources___KEY_MAX)))) // INLINED!!
        else
            //call BJDebugMsg("Has no resources")
        endif
    elseif ( amount > 0 and foundResource != 0 ) then // continue harvesting
        //call BJDebugMsg("Continue harvesting and hide return ability")
        //call BJDebugMsg("Queue worker for resource " + GetResourceName(foundResource) + " with harvest order ID " + I2S(OrderId("harvest")) + " and order id " + I2S(GetUnitHarvestOrderId(worker, foundResource)))
        //call BJDebugMsg("harvest ability level " + I2S(GetUnitAbilityLevel(worker, abilityId)))
        //call BJDebugMsg("harvest cooldown " + R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(worker, abilityId), ABILITY_RLF_COOLDOWN, 0)))
        //call BlzUnitClearOrders(worker, true)
        //call BlzQueueTargetOrderById(worker, GetUnitHarvestOrderId(worker, foundResource), mine)
        call BlzUnitHideAbility(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_RETURN_ABILITY_ID , Resources___KEY_MAX))), false) // INLINED!!
            
        call Resources___QueueOrderEx(worker , (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))) , abilityId , mine , 0.5) // add some threshold to continue // INLINED!!
        set queued=true
        //call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, foundResource), mine)
    elseif ( matchingResources > 0 ) then
        call IssueImmediateOrder(worker, "stop")
        call SimError(GetOwningPlayer(worker) , GetLocalizedString("TARGET_IS_NO_VALID_MINE"))
    endif
    
    // cancel queue if any other ability has been cast
    if ( not queued ) then
        call Resources___CancelUnitQueueTimer(worker)
    endif
    
    set mine=null
    set worker=null
endfunction

function ReorderWorkerToMineRally takes unit producer,unit worker returns nothing
    local unit mine= GetUnitRallyUnit(producer)
    local integer resource= 0
    if ( mine != null and (IsUnitInGroup((worker), Resources___workers)) and (IsUnitInGroup((mine), Resources___mines)) ) then // INLINED!!
        set resource=GetPrimaryMineResourceForWorker(mine , worker)
        if ( resource != 0 ) then
            //call BJDebugMsg("Rally order to mine " + GetUnitName(mine))
            call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))), mine) // INLINED!!
        endif
    endif
    set mine=null
endfunction

function GetReturnResource takes unit worker,unit returnBuilding returns integer
    local integer r= 0
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer returnResourceAmount= 0
    local integer returnResource= 0
    loop
        exitwhen ( i == max )
        set r=(s__Resource_resources[(i)]) // INLINED!!
        if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 and (LoadBoolean(Resources___h, GetHandleId((returnBuilding )), Index2D(( r) , Resources___KEY_RETURN_RESOURCE , Resources___KEY_MAX))) and (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > returnResourceAmount ) then // INLINED!!
            set returnResourceAmount=(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            set returnResource=r
        endif
        set i=i + 1
    endloop
    return returnResource
endfunction

function Resources___TriggerActionOrder takes nothing returns nothing
    local unit mine= GetOrderTargetUnit()
    local unit worker= GetTriggerUnit()
    local integer orderId= GetIssuedOrderId()
    local integer r= 0
    local integer i= 0
    local integer max= 0
    local unit returnBuilding= null
    local boolean foundResourceInMine= false
    local boolean isBusyHarvestingOrReturning= false
    local boolean movement= Resources___MovementTypesMatch(worker , mine)
    if ( (IsUnitInGroup((mine), Resources___mines)) and (IsUnitInGroup((worker), Resources___workers)) and movement ) then // INLINED!!
        if ( IsSmartOrder(orderId) ) then
            set r=GetPrimaryMineResourceForWorker(mine , worker)
            //call BJDebugMsg("Got primary resource from mine " + I2S(r) + " and order ID " + OrderId2String(GetUnitHarvestOrderId(worker, r)))
            if ( r != 0 ) then
                if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) == 0 ) then // INLINED!!
                    call IssueImmediateOrder(worker, "stop")
                    //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
                else
                    if ( Resources___HasMaxOfMineResources(worker , mine) ) then
                        // return resource
                        // In Warcraft III workers would actually go to the mine and then return the resources.
                        call SetUnitMine(worker , mine)
                        set returnBuilding=NextReturnBuilding(worker)
                        if ( returnBuilding != null ) then
                            call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))), returnBuilding) // INLINED!!
                            set returnBuilding=null
                        endif
                    else
                        // harvest
                        //call BJDebugMsg("Harvest order " + I2S(GetUnitHarvestOrderId(worker, r)))
                        call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))), mine) // INLINED!!
                    endif
                endif
            else
                if ( not (LoadBoolean(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_DISABLE_STOP_MINING_ON_ERROR , Resources___KEY_MAX))) ) then // INLINED!!
                    call IssueImmediateOrder(worker, "stop")
                    call SimError(GetOwningPlayer(worker) , s__AFormat_result(s__AFormat_s(s__AFormat_s((s__AFormat_create((GetLocalizedString("CANNOT_HARVEST")))),GetUnitName(worker)),GetUnitName(mine)))) // INLINED!!
                endif
            endif
        else
            // check if mine is empty on harvesting order
            set i=0
            set max=(s__Resource_resourcesCount) // INLINED!!
            loop
                exitwhen ( i == max or foundResourceInMine )
                set r=(s__Resource_resources[(i)]) // INLINED!!
                if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))) == orderId ) then // INLINED!!
                    if ( (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
                        set foundResourceInMine=true
                    endif
                endif
                set i=i + 1
            endloop
            if ( not foundResourceInMine ) then
                call IssueImmediateOrder(worker, "stop")
                //call BJDebugMsg("Could not find resource in mine for worker " + I2S(GetHandleId(worker)))
                //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
            endif
        endif
    endif
    
    // return resources
    if ( (IsUnitInGroup((mine), Resources___returnBuildings)) and (IsUnitInGroup((worker), Resources___workers)) and IsSmartOrder(orderId) and movement ) then // INLINED!!
        set r=GetReturnResource(worker , mine)
        //call BJDebugMsg("Return resource " + I2S(r))
        if ( r != 0 ) then
            call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))), mine) // INLINED!!
            set isBusyHarvestingOrReturning=true
        endif
    endif

    if ( (IsUnitInGroup((worker), Resources___workers)) and movement ) then // INLINED!!
        // disable pathing of busy workers to avoid blocking
        set i=0
        set max=(s__Resource_resourcesCount) // INLINED!!
        loop
            exitwhen ( i == max or isBusyHarvestingOrReturning )
            set r=(s__Resource_resources[(i)]) // INLINED!!
            if ( (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_HARVEST_ORDER_ID , Resources___KEY_MAX))) == orderId or (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( r) , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))) == orderId ) then // INLINED!!
                set isBusyHarvestingOrReturning=true
            endif
            set i=i + 1
        endloop
        call SetWorkerPathing(worker , not isBusyHarvestingOrReturning)

        // cancel queued order for any other order
        call Resources___CancelUnitQueueTimer(worker)
    endif
    set mine=null
    set worker=null
endfunction

function Resources___TriggerActionOrderReset takes nothing returns nothing
    local unit worker= GetTriggerUnit()
    if ( (IsUnitInGroup((worker), Resources___workers)) ) then // INLINED!!
        call Resources___CancelUnitQueueTimer(worker)
        call SetWorkerPathing(worker , true)
    endif
    set worker=null
endfunction

function Resources___TriggerActionReturn takes nothing returns nothing
    local unit returnBuilding= GetSpellTargetUnit()
    local unit worker= GetTriggerUnit()
    local integer abilityId= GetSpellAbilityId()
    local integer foundResource= 0
    local boolean movement= Resources___MovementTypesMatch(worker , returnBuilding)
    if ( (IsUnitInGroup((worker), Resources___workers)) and movement ) then // INLINED!!
        //call BJDebugMsg("Return resources with return building " + GetUnitName(returnBuilding))
        if ( returnBuilding != null and (IsUnitInGroup((returnBuilding), Resources___returnBuildings)) and IsReturnResourcesHiddenAbilityId(worker , abilityId) ) then // INLINED!!
            //call BJDebugMsg("Returning resources NOW!")
            call ReturnResources(worker , returnBuilding)
        else
            set foundResource=GetResourceFromReturnResourcesAbilityId(worker , abilityId)
            //call BJDebugMsg("Return resource " + I2S(foundResource) + " from ability " + GetObjectName(abilityId))
            if ( foundResource != 0 ) then
                set returnBuilding=NextReturnBuilding(worker)
                if ( returnBuilding != null ) then
                    call IssueTargetOrderById(worker, (LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( foundResource) , Resources___KEY_RETURN_HIDDEN_ORDER_ID , Resources___KEY_MAX))), returnBuilding) // INLINED!!
                    set returnBuilding=null
                else
                    // nothing happens in Warcraft III if no return building is found
                    //call SimError(GetOwningPlayer(worker), "No return building found.")
                endif
            endif
        endif
    endif
    set returnBuilding=null
    set worker=null
endfunction

function Resources___TriggerActionDeath takes nothing returns nothing
    local unit dyingUnit= GetDyingUnit()
    if ( (IsUnitInGroup((dyingUnit), Resources___mines)) or (IsUnitInGroup((dyingUnit), Resources___workers)) or (IsUnitInGroup((dyingUnit), Resources___returnBuildings)) ) then // INLINED!!
        // this could actually remove it from any of these so we have to check again afterwards
        call ExecuteDeathCallbacks(dyingUnit)
        call ReleaseAllWorkersFromMine(dyingUnit)
    endif
    if ( (IsUnitInGroup((dyingUnit), Resources___mines)) ) then // INLINED!!
        call RemoveMine(dyingUnit)
    endif
    if ( (IsUnitInGroup((dyingUnit), Resources___workers)) ) then // INLINED!!
        call GroupRemoveUnit(Resources___workers, (dyingUnit)) // INLINED!!
    endif
    if ( (IsUnitInGroup((dyingUnit), Resources___returnBuildings)) ) then // INLINED!!
        call GroupRemoveUnit(Resources___returnBuildings, (dyingUnit)) // INLINED!!
    endif
    set dyingUnit=null
endfunction

function Resources___Init takes nothing returns nothing
    // use trigger actions to avoid issues with unfinished Channel abilities
    call TriggerRegisterAnyUnitEventBJ(Resources___castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(Resources___castTrigger, function Resources___TriggerActionCast)
    
    call TriggerRegisterAnyUnitEventBJ(Resources___orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(Resources___orderTrigger, function Resources___TriggerActionOrder)
    
    call TriggerRegisterAnyUnitEventBJ(Resources___orderResetTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(Resources___orderResetTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddAction(Resources___orderResetTrigger, function Resources___TriggerActionOrderReset)
    
    call TriggerRegisterAnyUnitEventBJ(Resources___returnTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(Resources___returnTrigger, function Resources___TriggerActionReturn)

    call TriggerRegisterAnyUnitEventBJ(Resources___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(Resources___deathTrigger, function Resources___TriggerActionDeath)
    
    set Resources_GOLD=(s__Resource_create((GetLocalizedString("GOLD")))) // INLINED!!
    set s__Resource_icon[(Resources_GOLD )]=( Resources_GOLD_ICON) // INLINED!!
    set s__Resource_iconAtt[(Resources_GOLD )]=( Resources_GOLD_ICON_ATT) // INLINED!!
    set s__Resource_description[(Resources_GOLD )]=( GetLocalizedString("RESOURCE_UBERTIP_GOLD")) // INLINED!!
    set s__Resource_goldExchangeRate[(Resources_GOLD )]=(( Resources_GOLD_GOLD_EXCHANGE_RATE)*1.0) // INLINED!!
    set s__Resource_red[(Resources_GOLD )]=( 255) // INLINED!!
    set s__Resource_green[(Resources_GOLD )]=( 255) // INLINED!!
    set Resources_LUMBER=(s__Resource_create((GetLocalizedString("LUMBER")))) // INLINED!!
    set s__Resource_icon[(Resources_LUMBER )]=( Resources_LUMBER_ICON) // INLINED!!
    set s__Resource_iconAtt[(Resources_LUMBER )]=( Resources_LUMBER_ICON_ATT) // INLINED!!
    set s__Resource_description[(Resources_LUMBER )]=( GetLocalizedString("RESOURCE_UBERTIP_LUMBER")) // INLINED!!
    set s__Resource_goldExchangeRate[(Resources_LUMBER )]=(( Resources_LUMBER_GOLD_EXCHANGE_RATE)*1.0) // INLINED!!
    set s__Resource_green[(Resources_LUMBER )]=( 255) // INLINED!!
    set Resources_FOOD=(s__Resource_create((GetLocalizedString("FOOD")))) // INLINED!!
    set s__Resource_icon[(Resources_FOOD )]=( Resources_FOOD_ICON) // INLINED!!
    set s__Resource_iconAtt[(Resources_FOOD )]=( Resources_FOOD_ICON_ATT) // INLINED!!
    set s__Resource_description[(Resources_FOOD )]=( GetLocalizedString("RESOURCE_UBERTIP_SUPPLY")) // INLINED!!
    set s__Resource_goldExchangeRate[(Resources_FOOD )]=(( Resources_FOOD_GOLD_EXCHANGE_RATE)*1.0) // INLINED!!
    set Resources_FOOD_MAX=(s__Resource_create((GetLocalizedString("FOOD_MAXIMUM")))) // INLINED!!
    set s__Resource_icon[(Resources_FOOD_MAX )]=( Resources_FOOD_MAX_ICON) // INLINED!!
    set s__Resource_iconAtt[(Resources_FOOD_MAX )]=( Resources_FOOD_MAX_ICON_ATT) // INLINED!!
    set s__Resource_description[(Resources_FOOD_MAX )]=( GetLocalizedString("RESOURCE_UBERTIP_SUPPLY")) // INLINED!!
    set s__Resource_goldExchangeRate[(Resources_FOOD_MAX )]=(( Resources_FOOD_MAX_GOLD_EXCHANGE_RATE)*1.0) // INLINED!!
endfunction

function IsStandardResource takes integer r returns boolean
    return r == Resources_GOLD or r == Resources_LUMBER or r == Resources_FOOD or r == Resources_FOOD_MAX
endfunction

function Resources___RemoveUnitHook takes unit whichUnit returns nothing
    call Resources___CancelUnitQueueTimer(whichUnit)
    call Resources___CancelUnitQueueWorkerReleaseTimer(whichUnit)
    call RemoveMine(whichUnit)
    call GroupRemoveUnit(Resources___workers, (whichUnit)) // INLINED!!
    call GroupRemoveUnit(Resources___returnBuildings, (whichUnit)) // INLINED!!
    call FlushChildHashtable(Resources___h, GetHandleId(whichUnit))
endfunction

//processed hook: hook RemoveUnit Resources___RemoveUnitHook


//library Resources ends
//library UnitEventEx:

//ignored textmacro command: DEFINE_LIST("", "UEExList", "unit")
function UnitEventEx___FireEvent takes integer ev,unit u,unit other returns nothing
    local integer playerId= GetPlayerId(GetOwningPlayer(u))
    local integer handleId= GetHandleId(u)
    local integer id= (GetUnitUserData((u))) // INLINED!!
    local unit prevUnit= UnitEventEx___eventUnit
    local unit prevOther= UnitEventEx___eventOther
    local integer prevType= UnitEventEx___eventPreType
    
    set UnitEventEx___eventUnit=u
    set UnitEventEx___eventOther=other
    set UnitEventEx___eventPreType=UnitEventEx___PreTransformType[id]
    
    call TriggerEvaluate((GetIndexNativeEventTrigger(bj_MAX_PLAYER_SLOTS , (ev)))) // INLINED!!
    if IsNativeEventRegistered(playerId , ev) then
        call TriggerEvaluate(GetIndexNativeEventTrigger(playerId , ev))
    elseif IsNativeEventRegistered(handleId , ev) then
        call TriggerEvaluate(GetIndexNativeEventTrigger(handleId , ev))
    endif
    
    set UnitEventEx___eventUnit=prevUnit
    set UnitEventEx___eventOther=prevOther
    set UnitEventEx___eventPreType=prevType
    
    set prevUnit=null
    set prevOther=null
endfunction
    



    
    function s__UnitEventEx___Cargo_delete takes integer transport_id returns nothing



            call DestroyGroup(UnitEventEx___CargoGroup[transport_id])

    endfunction
    
    function s__UnitEventEx___Cargo_remove takes unit u,unit transport returns nothing
        local integer transport_id= (GetUnitUserData((transport))) // INLINED!!



            call GroupRemoveUnit(UnitEventEx___CargoGroup[transport_id], u)

        set UnitEventEx___Transporter[(GetUnitUserData((u)))]=null // INLINED!!
        call UnitEventEx___FireEvent(EVENT_ON_CARGO_UNLOAD , u , transport)
    endfunction
    
    function s__UnitEventEx___Cargo_add takes unit u,unit transport returns nothing
        local integer transport_id= (GetUnitUserData((transport))) // INLINED!!



            call GroupAddUnit(UnitEventEx___CargoGroup[transport_id], u)

        set UnitEventEx___Transporter[(GetUnitUserData((u)))]=transport // INLINED!!
        call UnitEventEx___FireEvent(EVENT_ON_CARGO_LOAD , u , transport)
    endfunction
    
    function s__UnitEventEx___Cargo_size takes integer transport_id returns integer



            return CountUnitsInGroup(UnitEventEx___CargoGroup[transport_id])

    endfunction
    
    function s__UnitEventEx___Cargo_exists takes integer transport_id returns boolean



            return ( UnitEventEx___CargoGroup[transport_id] != null )

    endfunction
    function s__UnitEventEx___Cargo_copyGroup takes integer transport_id returns group
        local group g= CreateGroup()








            //call BlzGroupAddGroupFast(g, )
            call GroupAddGroup(UnitEventEx___CargoGroup[transport_id], g)

        return g
    endfunction












    
    function s__UnitEventEx___Cargo_create takes integer transport_id returns integer



            set UnitEventEx___CargoGroup[transport_id]=CreateGroup()

        return 0
    endfunction
    
// these functions are here so that they don't call functions below them.
function GetEventUnit takes nothing returns unit
    return UnitEventEx___eventUnit
endfunction
function GetCargoUnit takes nothing returns unit
    return UnitEventEx___eventOther
endfunction
function GetCargoSize takes unit transport returns integer
    return (CountUnitsInGroup(UnitEventEx___CargoGroup[((GetUnitUserData((transport))))])) // INLINED!!
endfunction
function IsUnitInTransporter takes unit whichUnit returns boolean
    return UnitEventEx___Transporter[(GetUnitUserData((whichUnit)))] != null // INLINED!!
endfunction
function GetUnitTransporter takes unit whichUnit returns unit
    return UnitEventEx___Transporter[(GetUnitUserData((whichUnit)))] // INLINED!!
endfunction
function GetCargoTransportedUnitGroup takes unit transporter returns group
    return s__UnitEventEx___Cargo_copyGroup((GetUnitUserData((transporter)))) // INLINED!!
endfunction






//Implemented from module UnitEventEx___UnitEventExCore:
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___afterIndex takes nothing returns nothing
        local integer i= UnitEventEx___Stack
        local integer id
        local unit u
        
        loop
            exitwhen i < 0
            set u=UnitEventEx___IndexedUnit[i]
            set id=(GetUnitUserData((u))) // INLINED!!
            
            if UnitEventEx___IsNew[id] then
                set UnitEventEx___IsNew[id]=false



                
            elseif UnitEventEx___IsTransforming[id] then
                







                
            elseif UnitEventEx___IsAlive[id] then
            

                    set UnitEventEx___IsReincarnating[id]=true
                    set UnitEventEx___IsAlive[id]=false
                    call UnitEventEx___FireEvent(EVENT_ON_REINCARNATION_START , u , null)

                
            endif
            
            set UnitEventEx___IndexedUnit[i]=null
            set i=i - 1
        endloop
        set UnitEventEx___Stack=- 1
            
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___timerCheck takes unit u returns nothing
        set UnitEventEx___Stack=UnitEventEx___Stack + 1
        set UnitEventEx___IndexedUnit[UnitEventEx___Stack]=u
        call TimerStart(UnitEventEx___AfterIndexTimer, 0., false, function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___afterIndex)
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___unload takes unit u returns nothing
        local integer id= (GetUnitUserData((u))) // INLINED!!
        local integer cargo_id= (GetUnitUserData((UnitEventEx___CargoUnit[id]))) // INLINED!!
        
        call s__UnitEventEx___Cargo_remove(u , UnitEventEx___CargoUnit[id])
        
        if not IsUnitLoaded(u) or not UnitAlive(UnitEventEx___CargoUnit[id]) then
            set UnitEventEx___CargoUnit[id]=null
        endif
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onOrder takes nothing returns nothing
        local unit u= GetTriggerUnit()
        local integer id= (GetUnitUserData((u))) // INLINED!!
        
            // onOrder occurs after onEnter
            
        
        
        // If id is not zero then the unit has been indexed.
        if id > 0 then
            
            // Detect Cargo

                
                if GetIssuedOrderId() == 851972 then // order stop
                    
                    // This does not detect unloaded corpses.
                    if UnitEventEx___CargoUnit[id] != null and not IsUnitLoaded(u) or UnitAlive(u) then
                        call s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___unload(u)
                    endif
                    
                    set u=null
                    return
                endif
                

            
            // Detect Morph













            
            // Detect Revives


















































            
        endif
        
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onDeath takes nothing returns nothing
        local unit u= GetTriggerUnit()
        local integer id= (GetUnitUserData((u))) // INLINED!!
        
        // This checks if the unit has been indexed.
        if id > 0 then
            set UnitEventEx___IsAlive[id]=false
        endif
        

            if UnitEventEx___CargoUnit[id] != null then
                call UnitEventEx___FireEvent(EVENT_ON_CARGO_UNLOAD , u , UnitEventEx___CargoUnit[id])
                set UnitEventEx___CargoUnit[id]=null
            endif

        
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onLoad takes nothing returns nothing
        local unit u= GetTriggerUnit()
        local integer id= (GetUnitUserData((u))) // INLINED!!
        local integer cargo_id
        
        // if unit somehow loaded into a transport while being inside another, unload it
        if UnitEventEx___CargoUnit[id] != null then
            call s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___unload(u)
        endif
        

            // if a Meat Wagon loads up a corpse either by grabbing one on the ground or via Exhume
            // Corpse, that corpse is sent to the edge of the map by this system. This way, when it
            // is unloaded and placed back at the Meat Wagon's location, it fires an onEnter event,
            // which allows the system to detect when a corpse was unloaded from a transport.
            if not UnitAlive(u) then
                if LIBRARY_WorldBounds then
                    call SetUnitX(u, s__WorldBounds_maxX)
                    call SetUnitY(u, s__WorldBounds_maxY)
                else
                    call SetUnitX(u, UnitEventEx___MaxX)
                    call SetUnitY(u, UnitEventEx___MaxY)
                endif
            endif

        
        set UnitEventEx___CargoUnit[id]=GetTransportUnit()
        set cargo_id=(GetUnitUserData((UnitEventEx___CargoUnit[id]))) // INLINED!!
        
        if not (UnitEventEx___CargoGroup[(cargo_id)] != null) then // INLINED!!
            call s__UnitEventEx___Cargo_create(cargo_id)
        endif
        call s__UnitEventEx___Cargo_add(u , UnitEventEx___CargoUnit[id])
        
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onEnter takes nothing returns nothing
        local unit u= GetFilterUnit()
        local integer id= (GetUnitUserData((u))) // INLINED!!
        local integer cargo_id= (GetUnitUserData((UnitEventEx___CargoUnit[id]))) // INLINED!!
        
            // onEnter occurs AFTER onIndex
            
        // The unit was dead, but has re-entered the map. Used to detect when a Meat Wagon unloads a corpse.
        if id > 0 then
            if not IsUnitLoaded(u) and UnitEventEx___CargoUnit[id] != null then
                call s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___unload(u)
            endif
        endif
        
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onIndex takes nothing returns nothing
        local unit u= (s__UnitDex_Unit[s__UnitDex_LastIndex]) // INLINED!!
        local integer id= (GetUnitUserData((u))) // INLINED!!
        
            // onIndex occurs BEFORE onEnter
        
        set UnitEventEx___IsNew[id]=true
        





        



        
        if UnitAlive(u) then
            set UnitEventEx___IsAlive[id]=true
        else
            set UnitEventEx___IsAlive[id]=false
        endif
        
        // This is called here so as to set the variable IsNew[] to false after 0. seconds.
        call s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___timerCheck(u)
        
        set u=null
    endfunction
    
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onDeindex takes nothing returns nothing
        local unit u= (s__UnitDex_Unit[s__UnitDex_LastIndex]) // INLINED!!
        local integer id= (GetUnitUserData((u))) // INLINED!!
        
        if (UnitEventEx___CargoGroup[(id)] != null) then // INLINED!!
            call DestroyGroup(UnitEventEx___CargoGroup[(id)]) // INLINED!!
        endif
        
        set u=null
    endfunction
    
    
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onInit takes nothing returns nothing
        local integer i
        








        
        set EVENT_ON_CARGO_LOAD=CreateNativeEvent()
        set EVENT_ON_CARGO_UNLOAD=CreateNativeEvent()
        set EVENT_ON_TRANSFORM=CreateNativeEvent()
        set EVENT_ON_ANIMATE_DEAD=CreateNativeEvent()
        set EVENT_ON_RESURRECTION=CreateNativeEvent()
        set EVENT_ON_REINCARNATION_START=CreateNativeEvent()
        set EVENT_ON_REINCARNATION_FINISH=CreateNativeEvent()
        set EVENT_ON_UNIT_CREATED=CreateNativeEvent()
        
        call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_ISSUED_ORDER , function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onOrder)
        call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DEATH , function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onDeath)
        

            

            







                    call TriggerRegisterEnterRegion(CreateTrigger(), s__WorldBounds_worldRegion, Condition(function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onEnter))

                call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_LOADED , function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onLoad)
            

            call RegisterUnitIndexEvent(Condition(function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onDeindex) , EVENT_UNIT_DEINDEX)
            

        
        call RegisterUnitIndexEvent(Condition(function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onIndex) , EVENT_UNIT_INDEX)
        








        
        // see resurrectionTimer below.
        call TimerStart(CreateTimer(), 0., false, function sc__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer)
        
    endfunction
    
    // for some reason dummy recyclers creating dummies to store fires off a resurrection event, so
    // this boolean rezCheck is set to false after a 0. second timer to prevent this from happening.
    // rezCheck must be false for a resurrection event to happen.
    function s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer takes nothing returns nothing
        set UnitEventEx___rezCheck=false
        call DestroyTimer(GetExpiredTimer())
    endfunction
    

//library UnitEventEx ends
//library ResourcesChatCommands:




function GetResourceChatCommands takes nothing returns string
    local string msg= "-helpr/-hr, -resources/-res/-r"

    set msg=msg + ", -give amount resource player"



    set msg=msg + ", -ask amount resource player"



    set msg=msg + ", -sell amount resource"



    set msg=msg + ", -sellall/-sa"



    set msg=msg + ", -sellwood/-sw"

    

    set msg=msg + ", -buy amount resource"

    return msg
endfunction

function GetResources takes nothing returns string
    local string msg= "Resources: "
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( i == max )
        if ( (s__Resource_resources[(i)]) != Resources_FOOD and (s__Resource_resources[(i)]) != Resources_FOOD_MAX ) then // INLINED!!
            if ( i > 0 ) then
                set msg=msg + ", "
            endif
            set msg=msg + I2S(i + 1) + " " + (s__Resource_name[((s__Resource_resources[(i)]))]) // INLINED!!
        endif
        set i=i + 1
    endloop

    return msg
endfunction

function SellAllNonStandardResourcesForGold takes player whichPlayer returns integer
    local integer amount= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( i == max )
        if ( not IsStandardResource((s__Resource_resources[(i)])) ) then // INLINED!!
            set amount=amount + ExchangePlayerResource(whichPlayer , (s__Resource_resources[(i)]) , Resources_GOLD , GetPlayerResource(whichPlayer , (s__Resource_resources[(i)]))) // INLINED!!
        endif
        set i=i + 1
    endloop

    return amount
endfunction

function SellAllLumberForGold takes player whichPlayer returns integer
    return ExchangePlayerResource(whichPlayer , Resources_LUMBER , Resources_GOLD , GetPlayerResource(whichPlayer , Resources_LUMBER))
endfunction

function GetResourceFromString takes string s returns integer
    local string lower= StringCase(s, false)
    local integer index= S2I(s)
    local integer resource= 0
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( StringCase((s__Resource_name[(resource)]), false) == lower ) then // INLINED!!
            return resource
        endif
        set i=i + 1
    endloop
    
    if ( i >= 1 and i <= max ) then
        return (s__Resource_resources[(i - 1)]) // INLINED!!
    endif
    
    return 0
endfunction

function ResourcesChatCommands___GiveChatCommand takes player whichPlayer,string msg returns nothing
    local string amount= StringTokenEx(msg , 1 , " " , false)
    local string resource= StringTokenEx(msg , 2 , " " , false)
    local string to= StringTokenEx(msg , 3 , " " , false)
    local integer a= S2I(amount)
    local integer r= GetResourceFromString(resource)
    local player t= GetPlayerFromString(to)
    if ( r != 0 ) then
        if ( t != null ) then
            if ( a <= GetPlayerResource(whichPlayer , r) ) then
                call AddPlayerResource(t , r , a)
                call RemovePlayerResource(whichPlayer , r , a)
                call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_s(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("GAVE_RESOURCES_TO")))),a),(s__Resource_name[(r)])),GetPlayerNameColored(t)))) // INLINED!!
                call DisplayTimedTextToPlayer(t, 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_s(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("RECEIVED_RESOURCES_FROM")))),a),(s__Resource_name[(r)])),GetPlayerNameColored(whichPlayer)))) // INLINED!!
            else
                call SimError(whichPlayer , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("NOT_ENOUGH_X")))),(s__Resource_name[(r)])))) // INLINED!!
            endif
        else
            call SimError(whichPlayer , GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer , GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

function ResourcesChatCommands___AskChatCommand takes player whichPlayer,string msg returns nothing
    local string amount= StringTokenEx(msg , 1 , " " , false)
    local string resource= StringTokenEx(msg , 2 , " " , false)
    local string from= StringTokenEx(msg , 3 , " " , false)
    local integer a= S2I(amount)
    local integer r= GetResourceFromString(resource)
    local player f= GetPlayerFromString(from)
    if ( r != 0 ) then
        if ( f != null ) then
            if ( IsPlayerAlly(f, whichPlayer) and GetPlayerController(f) != MAP_CONTROL_USER ) then
                if ( a <= GetPlayerResource(f , r) ) then
                    call AddPlayerResource(whichPlayer , r , a)
                    call RemovePlayerResource(f , r , a)
                    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_s(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("RECEIVED_RESOURCES_FROM")))),a),(s__Resource_name[(r)])),GetPlayerNameColored(whichPlayer)))) // INLINED!!
                else
                    call SimError(whichPlayer , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("TARGET_PLAYER_HAS_NOT_ENOUGH")))),(s__Resource_name[(r)])))) // INLINED!!
                endif
            else
                call SimError(whichPlayer , GetLocalizedString("TARGET_PLAYER_HAS_TO_BE_ALLIED_C"))
            endif
        else
                call SimError(whichPlayer , GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer , GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

function ResourcesChatCommands___SellChatCommand takes player whichPlayer,string msg returns nothing
    local string amount= StringTokenEx(msg , 1 , " " , false)
    local string resource= StringTokenEx(msg , 2 , " " , false)
    local string targetResource= StringTokenEx(msg , 3 , " " , false)
    local integer a= S2I(amount)
    local integer r= GetResourceFromString(resource)
    local integer t= Resources_GOLD
    local integer received= 0
    
    if ( targetResource != "" and targetResource != null ) then
        set t=GetResourceFromString(targetResource)
    endif
    
    if ( r != 0 ) then
        if ( t != 0 ) then
            if ( a <= GetPlayerResource(whichPlayer , r) ) then
                set received=ExchangePlayerResource(whichPlayer , r , t , a)
                call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("RECEIVED_X_RESOURCES")))),received),(s__Resource_name[(t)])))) // INLINED!!
            else
                call SimError(whichPlayer , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("NOT_ENOUGH_X")))),(s__Resource_name[(r)])))) // INLINED!!
            endif
        else
                call SimError(whichPlayer , GetLocalizedString("INVALID_PLAYER"))
        endif
    else
        call SimError(whichPlayer , GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

function ResourcesChatCommands___BuyChatCommand takes player whichPlayer,string msg returns nothing
    local string amount= StringTokenEx(msg , 1 , " " , false)
    local string resource= StringTokenEx(msg , 2 , " " , false)
    local integer a= S2I(amount)
    local integer r= GetResourceFromString(resource)
    local integer received= 0
    
    if ( r != 0 ) then
        set received=ExchangePlayerResource(whichPlayer , Resources_GOLD , r , a)
        call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("RECEIVED_X_RESOURCES")))),received),(s__Resource_name[(r)])))) // INLINED!!
    else
        call SimError(whichPlayer , GetLocalizedString("INVALID_RESOURCE"))
    endif
endfunction

function ResourcesChatCommands___TriggerConditionChat takes nothing returns boolean
    local string msg= GetEventPlayerChatString()
    
    if ( ResourcesChatCommands_ALLOW_HELP and ( msg == "-helpresources" or msg == "-helpr" or msg == "-hr" ) ) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ResourcesChatCommands_HELP_DURATION, GetResourceChatCommands())
    elseif ( ResourcesChatCommands_ALLOW_LIST and ( msg == "-resources" or msg == "-res" or msg == "-r" ) ) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ResourcesChatCommands_RESOURCES_DURATION, GetResources())
    elseif ( ResourcesChatCommands_ALLOW_GIVE and StringStartsWith(msg , "-give") ) then
        call ResourcesChatCommands___GiveChatCommand(GetTriggerPlayer() , msg)
    elseif ( ResourcesChatCommands_ALLOW_ASK and StringStartsWith(msg , "-ask") ) then
        call ResourcesChatCommands___AskChatCommand(GetTriggerPlayer() , msg)
    elseif ( ResourcesChatCommands_ALLOW_SELL_ALL and ( msg == "-sellall" or msg == "-sa" ) ) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_i((s__AFormat_create((GetLocalizedString("SOLD_ALL_FOR_GOLD")))),SellAllNonStandardResourcesForGold(GetTriggerPlayer())))) // INLINED!!
    elseif ( ResourcesChatCommands_ALLOW_SELL_WOOD and ( msg == "-sellwood" or msg == "-sw" ) ) then
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0.0, 0.0, ResourcesChatCommands_INFO_DURATION, s__AFormat_result(s__AFormat_i((s__AFormat_create((GetLocalizedString("SOLD_ALL_LUMBER_FOR_GOLD")))),SellAllLumberForGold(GetTriggerPlayer())))) // INLINED!!
    elseif ( ResourcesChatCommands_ALLOW_SELL and StringStartsWith(msg , "-sell") ) then
        call ResourcesChatCommands___SellChatCommand(GetTriggerPlayer() , msg)
    elseif ( ResourcesChatCommands_ALLOW_BUY and StringStartsWith(msg , "-buy") ) then
        call ResourcesChatCommands___BuyChatCommand(GetTriggerPlayer() , msg)
    endif
    return false
endfunction

function ResourcesChatCommands___Init takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call TriggerRegisterPlayerChatEvent(ResourcesChatCommands___chatTrigger, Player(i), "", false)
        set i=i + 1
    endloop
    call TriggerAddCondition(ResourcesChatCommands___chatTrigger, Condition(function ResourcesChatCommands___TriggerConditionChat))
endfunction


//library ResourcesChatCommands ends
//library ResourcesCosts:




function ResourcesCosts___GetAlliesWithSharedControl takes player owner returns force
    local force allies= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) ) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return allies
endfunction

function ResourcesCosts___StartSoundForAllies takes player whichPlayer,sound whichSound returns nothing
    local force allies= ResourcesCosts___GetAlliesWithSharedControl(whichPlayer)
    if ( IsPlayerInForce(GetLocalPlayer(), allies) ) then
        call StartSound(whichSound)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function ResourcesCosts___SimErrorForAllies takes player whichPlayer,string msg returns nothing
    local force allies= ResourcesCosts___GetAlliesWithSharedControl(whichPlayer)
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( IsPlayerInForce(Player(i), allies) ) then
            call SimError(Player(i) , msg)
        endif
        set i=i + 1
    endloop
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function SetObjectTypeResourcesCostsIsResearch takes integer objectTypeId,boolean hasLevels returns nothing
    call SaveBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_IS_RESEARCH , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), hasLevels)
endfunction

function GetObjectTypeResourcesCostsIsResearch takes integer objectTypeId returns boolean
    return LoadBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_IS_RESEARCH , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetObjectTypeResourcesCostsIsAbility takes integer objectTypeId,boolean hasLevels returns nothing
    call SaveBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_IS_ABILITY , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), hasLevels)
endfunction

function GetObjectTypeResourcesCostsIsAbility takes integer objectTypeId returns boolean
    return LoadBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_IS_ABILITY , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetObjectTypeResourcesCostsHasCosts takes integer objectTypeId,boolean hasCosts returns nothing
    call SaveBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_HAS_COSTS , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), hasCosts)
endfunction

function GetObjectTypeResourcesCostsHasCosts takes integer objectTypeId returns boolean
    return LoadBoolean(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_HAS_COSTS , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetObjectTypeGoldValue takes integer objectTypeId,integer value returns nothing
    call SaveInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_GOLD_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), value)
endfunction

function GetObjectTypeGoldValue takes integer objectTypeId returns integer
    return LoadInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_GOLD_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function HasObjectTypeGoldValue takes integer objectTypeId returns boolean
    return HaveSavedInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_GOLD_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetObjectTypeLumberValue takes integer objectTypeId,integer value returns nothing
    call SaveInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_LUMBER_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), value)
endfunction

function GetObjectTypeLumberValue takes integer objectTypeId returns integer
    return LoadInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_LUMBER_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function HasObjectTypeLumberValue takes integer objectTypeId returns boolean
    return HaveSavedInteger(ResourcesCosts___h, objectTypeId, Index3D(0 , ResourcesCosts_KEY_LUMBER_VALUE , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetObjectTypeLevelResourcesCostsForPlayer takes player whichPlayer,integer objectTypeId,integer level,integer resource,integer amount returns nothing
    if ( amount > 0 ) then
        call SetObjectTypeResourcesCostsHasCosts(objectTypeId , true)
    endif
    call SaveInteger(ResourcesCosts___h, objectTypeId, Index3D(resource , GetPlayerId(whichPlayer) , level , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL), amount)
endfunction

function GetObjectTypeLevelResourcesCostsForPlayer takes player whichPlayer,integer objectTypeId,integer level,integer resource returns integer
    return LoadInteger(ResourcesCosts___h, objectTypeId, Index3D(resource , GetPlayerId(whichPlayer) , level , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))
endfunction

function SetResearchCostsForLevel takes integer objectTypeId,integer level,integer resource,integer amount returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call SetObjectTypeLevelResourcesCostsForPlayer(Player(i) , objectTypeId , level , resource , amount)
        set i=i + 1
    endloop
    call SetObjectTypeResourcesCostsIsResearch(objectTypeId , true)
endfunction

function SetResearchCosts takes integer objectTypeId,integer resource,integer amount returns nothing
    call SetResearchCostsForLevel(objectTypeId , 0 , resource , amount)
endfunction

function SetAbilityCostsForLevel takes integer objectTypeId,integer level,integer resource,integer amount returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call SetObjectTypeLevelResourcesCostsForPlayer(Player(i) , objectTypeId , level , resource , amount)
        set i=i + 1
    endloop
    call SetObjectTypeResourcesCostsIsAbility(objectTypeId , true)
endfunction

function SetAbilityCosts takes integer objectTypeId,integer resource,integer amount returns nothing
    call SetAbilityCostsForLevel(objectTypeId , 1 , resource , amount)
endfunction

function SetObjectTypeResourcesCostsForPlayer takes player whichPlayer,integer objectTypeId,integer resource,integer amount returns nothing
    call SetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , 0 , resource , amount)
endfunction

function GetObjectTypeResourcesCostsForPlayer takes player whichPlayer,integer objectTypeId,integer resource returns integer
    return GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , 0 , resource)
endfunction

function SetObjectTypeResourcesCosts takes integer objectTypeId,integer resource,integer amount returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call SetObjectTypeLevelResourcesCostsForPlayer((Player(i) ) , ( objectTypeId ) , 0 , ( resource ) , ( amount)) // INLINED!!
        set i=i + 1
    endloop
endfunction

function SetCosts takes integer objectTypeId,integer resource,integer amount returns nothing
    call SetObjectTypeResourcesCosts(objectTypeId , resource , amount)
endfunction

function GetCosts takes player whichPlayer,integer objectTypeId,integer resource returns nothing
call GetObjectTypeLevelResourcesCostsForPlayer((whichPlayer ) , ( objectTypeId ) , 0 , ( resource)) // INLINED!!
endfunction

function GetCostsForLevel takes player whichPlayer,integer objectTypeId,integer level,integer resource returns nothing
    call GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , level , resource)
endfunction

function RemoveObjectTypeResourcesCosts takes integer objectTypeId returns nothing
    call FlushChildHashtable(ResourcesCosts___h, objectTypeId)
endfunction

function SetNotEnoughResourcesSound takes player whichPlayer,integer resource,sound whichSound returns nothing
    set ResourcesCosts___playerSoundNotEnough[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]=whichSound
endfunction

function GetNotEnoughResourcesSound takes player whichPlayer,integer resource returns sound
    return ResourcesCosts___playerSoundNotEnough[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]
endfunction

function SetNotEnoughResourcesSoundForAllPlayers takes integer resource,sound whichSound returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesCosts___playerSoundNotEnough[Index2D(resource , i , bj_MAX_PLAYERS)]=whichSound
        set i=i + 1
    endloop
endfunction

function ResourcesCosts___GetLevel takes player whichPlayer,unit worker,integer objectTypeId returns integer
    if ( (LoadBoolean(ResourcesCosts___h, (objectTypeId), Index3D(0 , ResourcesCosts_KEY_IS_RESEARCH , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))) ) then // INLINED!!
        return GetPlayerTechCountSimple(objectTypeId, whichPlayer)
    elseif ( (LoadBoolean(ResourcesCosts___h, (objectTypeId), Index3D(0 , ResourcesCosts_KEY_IS_ABILITY , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))) ) then // INLINED!!
        return GetUnitAbilityLevel(worker, objectTypeId)
    endif
    return 0
endfunction

function CheckResourceCosts takes player whichPlayer,unit worker,integer objectTypeId,boolean showError returns boolean
    local integer resource= 0
    local integer cost= 0
    local boolean enough= true
    local boolean hasCost= (LoadBoolean(ResourcesCosts___h, (objectTypeId), Index3D(0 , ResourcesCosts_KEY_HAS_COSTS , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))) // INLINED!!
    local integer level= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    //call BJDebugMsg(GetObjectName(objectTypeId) + " has costs.")
    if ( hasCost ) then
        set level=ResourcesCosts___GetLevel(whichPlayer , worker , objectTypeId)
        //call BJDebugMsg("Level " + I2S(level))
        loop
            exitwhen ( i == max or not enough )
            set resource=(s__Resource_resources[(i)]) // INLINED!!
            set cost=GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , level , resource)
            if ( cost > GetPlayerResource(whichPlayer , resource) ) then
                if ( showError ) then
                    call ResourcesCosts___SimErrorForAllies(whichPlayer , s__AFormat_result(s__AFormat_s((s__AFormat_create((GetLocalizedString("NOT_ENOUGH_X")))),(s__Resource_name[(resource)])))) // INLINED!!
                    if ( GetNotEnoughResourcesSound(whichPlayer , resource) != null ) then
                        call ResourcesCosts___StartSoundForAllies(whichPlayer , GetNotEnoughResourcesSound(whichPlayer , resource))
                    endif
                endif
                set enough=false
            endif
            set i=i + 1
        endloop
    endif
    return enough
endfunction

function RemoveResourceCosts takes player whichPlayer,unit worker,integer objectTypeId returns nothing
    local integer resource= 0
    local boolean hasCost= (LoadBoolean(ResourcesCosts___h, (objectTypeId), Index3D(0 , ResourcesCosts_KEY_HAS_COSTS , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))) // INLINED!!
    local integer level= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    if ( hasCost ) then
        set level=ResourcesCosts___GetLevel(whichPlayer , worker , objectTypeId)
        loop
            exitwhen ( i == max )
            set resource=(s__Resource_resources[(i)]) // INLINED!!
            call RemovePlayerResource(whichPlayer , resource , GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , level , resource))
            set i=i + 1
        endloop
    endif
endfunction

function RefundResourceCosts takes player whichPlayer,unit worker,integer objectTypeId,real factor returns nothing
    local integer resource= 0
    local boolean hasCost= (LoadBoolean(ResourcesCosts___h, (objectTypeId), Index3D(0 , ResourcesCosts_KEY_HAS_COSTS , 0 , ResourcesCosts_MAX_KEYS , ResourcesCosts_MAX_LEVEL))) // INLINED!!
    local integer cost= 0
    local integer level= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer i= 0
    //call BJDebugMsg("Refund cost with factor " + R2S(factor))
    if ( hasCost ) then
        set level=ResourcesCosts___GetLevel(whichPlayer , worker , objectTypeId)
        loop
            exitwhen ( i == max )
            set resource=(s__Resource_resources[(i)]) // INLINED!!
            set cost=GetObjectTypeLevelResourcesCostsForPlayer(whichPlayer , objectTypeId , level , resource)
            if ( cost > 0 ) then
                call AddPlayerResource(whichPlayer , resource , R2I(I2R(cost) * factor))
                //call BJDebugMsg("Refund " + I2S(R2I(I2R(cost) * factor)) + " of " + GetResourceName(resource))
            endif
            set i=i + 1
        endloop
    endif
endfunction

function ResourcesCosts___TriggerConditionIssue takes nothing returns boolean
    if ( CheckResourceCosts(GetOwningPlayer(GetTriggerUnit()) , GetTriggerUnit() , GetIssuedOrderId() , true) ) then
        // remove resources on ordering the unit which also happens in Warcraft III when you order a worker to build something
        call RemoveResourceCosts(GetOwningPlayer(GetTriggerUnit()) , GetTriggerUnit() , GetIssuedOrderId())
        
        return false
    endif
    
    return true
endfunction

function ResourcesCosts___EnableCancelTriggers takes nothing returns nothing
    call EnableTrigger(ResourcesCosts___constructCancelTrigger)
    call EnableTrigger(ResourcesCosts___trainCancelTrigger)
    call EnableTrigger(ResourcesCosts___researchCancelTrigger)
    call EnableTrigger(ResourcesCosts___heroReviveCancelTrigger)
endfunction

function ResourcesCosts___DisableCancelTriggers takes nothing returns nothing
    call DisableTrigger(ResourcesCosts___constructCancelTrigger)
    call DisableTrigger(ResourcesCosts___trainCancelTrigger)
    call DisableTrigger(ResourcesCosts___researchCancelTrigger)
    call DisableTrigger(ResourcesCosts___heroReviveCancelTrigger)
endfunction

function ResourcesCosts___TimerFunctionCancel takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local unit whichUnit= LoadUnitHandle(ResourcesCosts___h2, handleId, 0)
    call ResourcesCosts___DisableCancelTriggers()
    call IssueImmediateOrderById(whichUnit, ResourcesCosts_CANCEL_ORDER_ID)
    call IssueImmediateOrder(whichUnit, "stop") // for constructions
    call ResourcesCosts___EnableCancelTriggers()
    call FlushChildHashtable(ResourcesCosts___h2, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
endfunction

function ResourcesCosts___TriggerActionIssue takes nothing returns nothing
    local timer t= CreateTimer()
    call SaveUnitHandle(ResourcesCosts___h2, GetHandleId(t), 0, GetTriggerUnit())
    call TimerStart(t, 0.0, false, function ResourcesCosts___TimerFunctionCancel)
endfunction

function ResourcesCosts___TriggerConditionConstructCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetCancelledStructure()) , GetTriggerUnit() , GetUnitTypeId(GetCancelledStructure()) , ResourcesCosts_REFUND_BUILDING)
    return false
endfunction

function ResourcesCosts___TriggerConditionTrainCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetTriggerUnit()) , GetTriggerUnit() , GetTrainedUnitType() , ResourcesCosts_REFUND_UNIT_TRAINING)
    return false
endfunction

function ResourcesCosts___TriggerConditionResearchCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetResearchingUnit()) , GetTriggerUnit() , GetResearched() , ResourcesCosts_REFUND_RESEARCH)
    return false
endfunction

function ResourcesCosts___TriggerConditionHeroReviveCancel takes nothing returns boolean
    call RefundResourceCosts(GetOwningPlayer(GetRevivingUnit()) , GetTriggerUnit() , GetUnitTypeId(GetRevivableUnit()) , ResourcesCosts_REFUND_HERO_REVIVAL)
    return false
endfunction

function ResourcesCosts___TriggerConditionUnitSell takes nothing returns boolean
    if ( CheckResourceCosts(GetOwningPlayer(GetBuyingUnit()) , GetBuyingUnit() , GetUnitTypeId(GetSoldUnit()) , true) ) then
        call RemoveResourceCosts(GetOwningPlayer(GetBuyingUnit()) , GetBuyingUnit() , GetUnitTypeId(GetSoldUnit()))
    else
        call RefundUnit(GetSoldUnit())
        call h__RemoveUnit(GetSoldUnit())
    endif
    return false
endfunction

function ResourcesCosts___TriggerConditionItemSell takes nothing returns boolean
    if ( CheckResourceCosts(GetOwningPlayer(GetBuyingUnit()) , GetBuyingUnit() , GetItemTypeId(GetSoldItem()) , true) ) then
        call RemoveResourceCosts(GetOwningPlayer(GetBuyingUnit()) , GetBuyingUnit() , GetItemTypeId(GetSoldItem()))
    else
        call RefundItem(GetSoldItem() , GetOwningPlayer(GetBuyingUnit()))
        call RemoveItem(GetSoldItem())
    endif
    return false
endfunction

function ResourcesCosts___TriggerConditionChannel takes nothing returns boolean
    //call BJDebugMsg("Checking ability costs for " + GetObjectName(GetSpellAbilityId()) + " for caster " + GetUnitName(GetTriggerUnit()) + " with level " + I2S(GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
    if ( CheckResourceCosts(GetOwningPlayer(GetTriggerUnit()) , GetTriggerUnit() , GetSpellAbilityId() , true) ) then
        call RemoveResourceCosts(GetOwningPlayer(GetTriggerUnit()) , GetTriggerUnit() , GetSpellAbilityId())
    else
        //call SetUnitState(GetTriggerUnit(), UNIT_STATE_MANA, GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) + BlzGetAbilityManaCost(GetSpellAbilityId(), GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())))
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
    endif
    return false
endfunction

function ResourcesCosts___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___issueTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___issueTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(ResourcesCosts___issueTrigger, Condition(function ResourcesCosts___TriggerConditionIssue))
    call TriggerAddAction(ResourcesCosts___issueTrigger, function ResourcesCosts___TriggerActionIssue)
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___constructCancelTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    call TriggerAddCondition(ResourcesCosts___constructCancelTrigger, Condition(function ResourcesCosts___TriggerConditionConstructCancel))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___trainCancelTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(ResourcesCosts___trainCancelTrigger, Condition(function ResourcesCosts___TriggerConditionTrainCancel))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___researchCancelTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerAddCondition(ResourcesCosts___researchCancelTrigger, Condition(function ResourcesCosts___TriggerConditionResearchCancel))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___heroReviveCancelTrigger, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    call TriggerAddCondition(ResourcesCosts___heroReviveCancelTrigger, Condition(function ResourcesCosts___TriggerConditionHeroReviveCancel))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___unitSellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(ResourcesCosts___unitSellTrigger, Condition(function ResourcesCosts___TriggerConditionUnitSell))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___itemSellTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
    call TriggerAddCondition(ResourcesCosts___itemSellTrigger, Condition(function ResourcesCosts___TriggerConditionItemSell))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesCosts___channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(ResourcesCosts___channelTrigger, Condition(function ResourcesCosts___TriggerConditionChannel))
endfunction


//library ResourcesCosts ends
//library ResourcesGui:


function ResourcesGui___SetResourcesUIVisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(ResourcesGui___IconFrame, visible)
    call BlzFrameSetVisible(ResourcesGui___TextFrame, visible)
endfunction

function ResourcesGui___SetResourcesUIGatheredVisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(ResourcesGui___IconFrameGathered, visible)
    call BlzFrameSetVisible(ResourcesGui___TextFrameGathered, visible)
    call BlzFrameSetVisible(ResourcesGui___IconFrameGathered2, visible)
    call BlzFrameSetVisible(ResourcesGui___TextFrameGathered2, visible)
endfunction

function ResourcesGui___SetResourcesUIGathered2VisibleAll takes boolean visible returns nothing
    call BlzFrameSetVisible(ResourcesGui___IconFrameGathered2, visible)
    call BlzFrameSetVisible(ResourcesGui___TextFrameGathered2, visible)
endfunction

function ResourcesGui___SetResourcesUIVisible takes player whichPlayer,boolean visible returns nothing
    if ( whichPlayer == GetLocalPlayer() ) then
        call ResourcesGui___SetResourcesUIVisibleAll(visible)
    endif
endfunction

function ResourcesGui___SetResourcesUIGatheredVisible takes player whichPlayer,boolean visible returns nothing
    if ( whichPlayer == GetLocalPlayer() ) then
        call ResourcesGui___SetResourcesUIGatheredVisibleAll(visible)
    endif
endfunction

function ResourcesGui___ShowResourcesUI takes player whichPlayer returns nothing
    call ResourcesGui___SetResourcesUIVisible(whichPlayer , true)
endfunction

function ResourcesGui___HideResourcesUI takes player whichPlayer returns nothing
    call ResourcesGui___SetResourcesUIVisible(whichPlayer , false)
endfunction

function ResourcesGui___ShowResourcesGatheredUI takes player whichPlayer returns nothing
    call ResourcesGui___SetResourcesUIGatheredVisible(whichPlayer , true)
endfunction

function ResourcesGui___HideResourcesGatheredUI takes player whichPlayer returns nothing
    call ResourcesGui___SetResourcesUIGatheredVisible(whichPlayer , false)
endfunction

function ResourcesGui___CreateResourcesUI takes nothing returns nothing
    set ResourcesGui___IconFrame=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrame, FRAMEPOINT_TOPLEFT, ResourcesGui___X, ResourcesGui___Y)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrame, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___X + ResourcesGui___WIDTH, ResourcesGui___Y - ResourcesGui___HEIGHT)
    call BlzFrameSetLevel(ResourcesGui___IconFrame, 1)

    set ResourcesGui___TextFrame=BlzCreateFrameByType("TEXT", "ResourceGuiText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrame, FRAMEPOINT_TOPLEFT, ResourcesGui___TEXT_X, ResourcesGui___Y)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrame, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___TEXT_X + ResourcesGui___TEXT_WIDTH, ResourcesGui___Y - ResourcesGui___HEIGHT)
    call BlzFrameSetTextAlignment(ResourcesGui___TextFrame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(ResourcesGui___TextFrame, 1.0)
    call BlzFrameSetLevel(ResourcesGui___TextFrame, 1)
    
    set ResourcesGui___IconFrameGathered=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrameGathered, FRAMEPOINT_TOPLEFT, ResourcesGui___X_GATHERED, ResourcesGui___Y_GATHERED)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrameGathered, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___X_GATHERED + ResourcesGui___WIDTH, ResourcesGui___Y_GATHERED - ResourcesGui___HEIGHT)
    call BlzFrameSetLevel(ResourcesGui___IconFrameGathered, 1)

    set ResourcesGui___TextFrameGathered=BlzCreateFrameByType("TEXT", "ResourceGuiTextGathered", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrameGathered, FRAMEPOINT_TOPLEFT, ResourcesGui___TEXT_X_GATHERED, ResourcesGui___Y_GATHERED)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrameGathered, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___TEXT_X_GATHERED + ResourcesGui___TEXT_WIDTH, ResourcesGui___Y_GATHERED - ResourcesGui___HEIGHT)
    call BlzFrameSetTextAlignment(ResourcesGui___TextFrameGathered, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(ResourcesGui___TextFrameGathered, 1.0)
    call BlzFrameSetLevel(ResourcesGui___TextFrameGathered, 1)
    
    set ResourcesGui___IconFrameGathered2=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrameGathered2, FRAMEPOINT_TOPLEFT, ResourcesGui___X_GATHERED, ResourcesGui___Y)
    call BlzFrameSetAbsPoint(ResourcesGui___IconFrameGathered2, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___X_GATHERED + ResourcesGui___WIDTH, ResourcesGui___Y - ResourcesGui___HEIGHT)
    call BlzFrameSetLevel(ResourcesGui___IconFrameGathered2, 1)

    set ResourcesGui___TextFrameGathered2=BlzCreateFrameByType("TEXT", "ResourceGuiTextGathered2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrameGathered2, FRAMEPOINT_TOPLEFT, ResourcesGui___TEXT_X_GATHERED, ResourcesGui___Y)
    call BlzFrameSetAbsPoint(ResourcesGui___TextFrameGathered2, FRAMEPOINT_BOTTOMRIGHT, ResourcesGui___TEXT_X_GATHERED + ResourcesGui___TEXT_WIDTH, ResourcesGui___Y - ResourcesGui___HEIGHT)
    call BlzFrameSetTextAlignment(ResourcesGui___TextFrameGathered2, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(ResourcesGui___TextFrameGathered2, 1.0)
    call BlzFrameSetLevel(ResourcesGui___TextFrameGathered2, 1)

    // hide for all players
    call ResourcesGui___SetResourcesUIVisibleAll(false)
    call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
    call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
endfunction

function ResourcesGui___GetPrimaryResourceEx takes unit mine,integer ignore returns integer
    local integer resource= 0
    local integer result= 0
    local integer current= 0
    local integer currentMax= 0
    local integer v= 0
    local integer w= 0
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    loop
        exitwhen ( i == max )
        set resource=(s__Resource_resources[(i)]) // INLINED!!
        if ( resource != ignore ) then
            set v=(LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            set w=(LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))) // INLINED!!
            if ( v > current ) then
                set result=resource
                set current=v
            elseif ( not IsStandardResource(resource) and current == 0 and w > currentMax ) then
                set result=resource
                set currentMax=w
            endif
        endif
        set i=i + 1
    endloop
    return result
endfunction

function ResourcesGui___GetPrimaryResource takes unit mine returns integer
    return ResourcesGui___GetPrimaryResourceEx(mine , 0)
endfunction

function ResourcesGui___GetResourceGatheredText takes unit worker,integer resource returns string
    if ( GetPlayerResourceBonus(GetOwningPlayer(worker) , resource) > 0 ) then
        return s__AFormat_result(s__AFormat_i(s__AFormat_i(s__AFormat_i(s__AFormat_s((s__AFormat_create((GetLocalizedString("RESOURCE_X_OF_Y_BONUS_POSITIVE")))),(s__Resource_name[(resource)])),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX)))),GetPlayerResourceBonus(GetOwningPlayer(worker) , resource))) // INLINED!!
    elseif ( GetPlayerResourceBonus(GetOwningPlayer(worker) , resource) < 0 ) then
        return s__AFormat_result(s__AFormat_i(s__AFormat_i(s__AFormat_i(s__AFormat_s((s__AFormat_create((GetLocalizedString("RESOURCE_X_OF_Y_BONUS_NEGATIVE")))),(s__Resource_name[(resource)])),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX)))),GetPlayerResourceBonus(GetOwningPlayer(worker) , resource))) // INLINED!!
    endif
    return s__AFormat_result(s__AFormat_i(s__AFormat_i(s__AFormat_s((s__AFormat_create((GetLocalizedString("RESOURCE_X_OF_Y")))),(s__Resource_name[(resource)])),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))),(LoadInteger(Resources___h, GetHandleId((worker )), Index2D(( resource) , Resources___KEY_MAX_RESOURCE , Resources___KEY_MAX))))) // INLINED!!
endfunction

function ResourcesGui___UpdateGathered takes player whichPlayer,unit worker returns nothing
    local integer resource= (ResourcesGui___GetPrimaryResourceEx((worker) , 0)) // INLINED!!
    local integer resource2= ResourcesGui___GetPrimaryResourceEx(worker , resource)
    //call BJDebugMsg("resource " + I2S(resource))
    if ( GetLocalPlayer() == whichPlayer ) then
        if ( resource != 0 ) then
            call BlzFrameSetTexture(ResourcesGui___IconFrameGathered, (s__Resource_iconAtt[(resource)]), 0, true) // INLINED!!
            call BlzFrameSetText(ResourcesGui___TextFrameGathered, ResourcesGui___GetResourceGatheredText(worker , resource))
            //call BJDebugMsg("Icon mine " + GetResourceIcon(resource))
            //call BJDebugMsg("Text mine " + BlzFrameGetText(TextFrame))
            call ResourcesGui___SetResourcesUIGatheredVisibleAll(true)
        else
            call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
        endif
        
        if ( resource2 != 0 ) then
            call BlzFrameSetTexture(ResourcesGui___IconFrameGathered2, (s__Resource_iconAtt[(resource2)]), 0, true) // INLINED!!
            call BlzFrameSetText(ResourcesGui___TextFrameGathered2, ResourcesGui___GetResourceGatheredText(worker , resource2))
            call ResourcesGui___SetResourcesUIGathered2VisibleAll(true)
        else
            call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
        endif
    endif
endfunction

function ResourcesGui___ForGroupPrint takes nothing returns nothing
    call BJDebugMsg(GetUnitName(GetEnumUnit()))
endfunction

function PrintResourcesGuiSelection takes player whichPlayer returns nothing
    call BJDebugMsg("current selected unit from system " + GetUnitName(ResourcesGui___currentMine[GetPlayerId(whichPlayer)]))
    call BJDebugMsg("current selected unit by player " + GetUnitName(GetSingleSelectedUnit(whichPlayer)))
endfunction

function ResourcesGui___HasNonEmptyCargo takes unit mine returns boolean

    return (CountUnitsInGroup(UnitEventEx___CargoGroup[((GetUnitUserData(((mine)))))])) > 0 // INLINED!!



endfunction

function ResourcesGui___HasProgressBar takes unit mine returns boolean
    return IsUnitInGroup(mine, ResourcesGui___progressBarUnits)
endfunction

function UpdatePlayerResourceSelectionGui takes player whichPlayer returns nothing
    local integer resource= 0
    local integer playerId= GetPlayerId(whichPlayer)
    //call BJDebugMsg("UpdatePlayerResourceSelectionGui")
    set ResourcesGui___currentMine[playerId]=GetSingleSelectedUnit(whichPlayer)
    //call BJDebugMsg("Current single selected unit " + GetUnitName(currentMine[playerId]))
    // heroes have no space for the icons
    if ( ResourcesGui___currentMine[playerId] != null and IsUnitType(ResourcesGui___currentMine[playerId], UNIT_TYPE_HERO) ) then
        set ResourcesGui___currentMine[playerId]=null
    endif
    
    // with cargo there is no space for icons

    if ( ResourcesGui___currentMine[playerId] != null and ((CountUnitsInGroup(UnitEventEx___CargoGroup[((GetUnitUserData((((ResourcesGui___currentMine[playerId]))))))])) > 0) ) then // INLINED!!
        set ResourcesGui___currentMine[playerId]=null
    endif


    if ( ResourcesGui___currentMine[playerId] != null and (IsUnitInGroup((ResourcesGui___currentMine[playerId]), ResourcesGui___progressBarUnits)) ) then // INLINED!!
        set ResourcesGui___currentMine[playerId]=null
    endif

    //call BJDebugMsg("XXXXXXXXXXXX")
    if ( ResourcesGui___currentMine[playerId] != null ) then
        set resource=(ResourcesGui___GetPrimaryResourceEx((ResourcesGui___currentMine[playerId]) , 0)) // INLINED!!
        
        //call PrintResourcesGuiSelection(whichPlayer)
        //call BJDebugMsg("mine " + GetUnitName(currentMine[playerId]) + " with primary resource " + I2S(resource))
        if ( (IsUnitInGroup((ResourcesGui___currentMine[playerId]), Resources___mines)) and IsAlliedMine(ResourcesGui___currentMine[playerId] , whichPlayer) ) then // INLINED!!
           // call BJDebugMsg("is mine")
            if ( resource != 0 ) then
                //call BJDebugMsg("Show mine " + GetUnitName(currentMine[playerId]))
                if ( GetLocalPlayer() == whichPlayer ) then
                    call BlzFrameSetTexture(ResourcesGui___IconFrame, (s__Resource_iconAtt[(resource)]), 0, true) // INLINED!!
                    call BlzFrameSetText(ResourcesGui___TextFrame, s__AFormat_result(s__AFormat_i(s__AFormat_s((s__AFormat_create((GetLocalizedString("RESOURCE_X")))),(s__Resource_name[(resource)])),(LoadInteger(Resources___h, GetHandleId((ResourcesGui___currentMine[playerId] )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))))) // INLINED!!
                    //call BJDebugMsg("Icon mine " + GetResourceIcon(resource))
                    //call BJDebugMsg("Text mine " + BlzFrameGetText(TextFrame))
                    call ResourcesGui___SetResourcesUIVisibleAll(true)
                    call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
                    call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
                endif
            else
                //call BJDebugMsg("selection counter is not 1 " + I2S(selectionCounter[playerId] ))
                //call BJDebugMsg("Hide mine " + GetUnitName(selected))
                if ( GetLocalPlayer() == whichPlayer ) then
                    call ResourcesGui___SetResourcesUIVisibleAll(false)
                    call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
                    call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
                endif
            endif
        elseif ( resource != 0 and IsAlliedMine(ResourcesGui___currentMine[playerId] , whichPlayer) ) then
            //call BJDebugMsg("Update gathered resources UI for player " + GetPlayerName(whichPlayer))
            call ResourcesGui___SetResourcesUIVisibleAll(false)
            call ResourcesGui___UpdateGathered(whichPlayer , ResourcesGui___currentMine[playerId])
        else
            //call BJDebugMsg("Hide gathered resources UI for player " + GetPlayerName(whichPlayer))
            call ResourcesGui___SetResourcesUIVisibleAll(false)
            call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
            call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
        endif
    else
        //call BJDebugMsg("Hide all resources UI for player " + GetPlayerName(whichPlayer))
        call ResourcesGui___SetResourcesUIVisibleAll(false)
        call ResourcesGui___SetResourcesUIGatheredVisibleAll(false)
        call ResourcesGui___SetResourcesUIGathered2VisibleAll(false)
    endif
endfunction

function ResourcesGui___TriggerActionTmp takes nothing returns nothing
    call UpdatePlayerResourceSelectionGui(ResourcesGui___tmpPlayer)
endfunction

function ResourcesGui___TimerFunctionUpdate takes nothing returns nothing
    local integer playerId= LoadInteger(ResourcesGui___h, GetHandleId(GetExpiredTimer()), 0)
    //call BJDebugMsg("Timer function with playerId " + I2S(playerId))
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    set ResourcesGui___tmpPlayer=Player(playerId)
    call TriggerExecute(ResourcesGui___tmpTrigger)
    set ResourcesGui___updateTimerRunning[playerId]=false
endfunction

function ResourcesGui___StartUpdateTimer takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    if ( not ResourcesGui___updateTimerRunning[playerId] ) then
        set ResourcesGui___updateTimerRunning[playerId]=true
        call TimerStart(ResourcesGui___updateTimer[playerId], 0.0, false, function ResourcesGui___TimerFunctionUpdate)
    endif
endfunction

function ResourcesGui_StartUpdateTimerForUnits takes unit u0,unit u1 returns nothing
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and ( ( u0 != null and IsUnitSelected(u0, slotPlayer) ) or ( u1 != null and IsUnitSelected(u1, slotPlayer) ) ) ) then
            call ResourcesGui___StartUpdateTimer(slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
endfunction

function ResourcesGui___TriggerActionSelected takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call ResourcesGui___StartUpdateTimer(GetTriggerPlayer())
endfunction

function ResourcesGui___TriggerActionDeselected takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call ResourcesGui___StartUpdateTimer(GetTriggerPlayer())
endfunction

function ResourcesGui___TriggerActionGather takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call ResourcesGui_StartUpdateTimerForUnits((Resources___triggerWorker) , (Resources___triggerMine)) // INLINED!!
endfunction

function ResourcesGui___TriggerActionReturn takes nothing returns nothing
    // This has to be done to make GetSingleSelectedUnit work. SyncSelections might hang the current thread otherwise.
    call ResourcesGui_StartUpdateTimerForUnits((Resources___triggerWorker) , (Resources___triggerReturnBuilding)) // INLINED!!
endfunction

function ResourcesGui___TriggerActionProgressBarStart takes nothing returns nothing
    local unit u= GetTriggerUnit()
    if ( not IsUnitInGroup(u, ResourcesGui___progressBarUnits) ) then
        call GroupAddUnit(ResourcesGui___progressBarUnits, u)
        call ResourcesGui_StartUpdateTimerForUnits(u , null)
    endif
    set u=null
endfunction

function ResourcesGui___TriggerActionProgressBarFinish takes nothing returns nothing
    local unit u= GetTriggerUnit()
    if ( IsUnitInGroup(u, ResourcesGui___progressBarUnits) ) then
        call GroupRemoveUnit(ResourcesGui___progressBarUnits, u)
        call ResourcesGui_StartUpdateTimerForUnits(u , null)
    endif
    set u=null
endfunction

function ResourcesGui___Init takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesGui___currentMine[i]=null
        set ResourcesGui___updateTimer[i]=CreateTimer()
        call SaveInteger(ResourcesGui___h, GetHandleId(ResourcesGui___updateTimer[i]), 0, i)
        set i=i + 1
    endloop
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___selectionTrigger, EVENT_PLAYER_UNIT_SELECTED)
    call TriggerAddAction(ResourcesGui___selectionTrigger, function ResourcesGui___TriggerActionSelected)
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___deselectionTrigger, EVENT_PLAYER_UNIT_DESELECTED)
    call TriggerAddAction(ResourcesGui___deselectionTrigger, function ResourcesGui___TriggerActionDeselected)
    
    call TriggerRegisterGatherEvent(ResourcesGui___gatherTrigger)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(ResourcesGui___gatherTrigger, function ResourcesGui___TriggerActionGather)
    
    call TriggerRegisterReturnEvent(ResourcesGui___returnTrigger)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(ResourcesGui___returnTrigger, function ResourcesGui___TriggerActionReturn)

    call TriggerAddAction(OnStartGame___startGameTrigger, (function ResourcesGui___CreateResourcesUI)) // INLINED!!
    
    call TriggerAddAction(ResourcesGui___tmpTrigger, function ResourcesGui___TriggerActionTmp)
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarStartTrigger, EVENT_PLAYER_UNIT_UPGRADE_START)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarStartTrigger, EVENT_PLAYER_UNIT_RESEARCH_START)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarStartTrigger, EVENT_PLAYER_UNIT_TRAIN_START)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(ResourcesGui___progressBarStartTrigger, function ResourcesGui___TriggerActionProgressBarStart)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerRegisterAnyUnitEventBJ(ResourcesGui___progressBarFinishTrigger, EVENT_PLAYER_UNIT_DEATH)
    // Use a trigger action here since trigger conditions will lead to weird behavior when checking player selections.
    call TriggerAddAction(ResourcesGui___progressBarFinishTrigger, function ResourcesGui___TriggerActionProgressBarFinish)
    

        call TriggerAddAction(FrameLoader___actionTrigger, (function ResourcesGui___CreateResourcesUI)) // INLINED!!

endfunction

function ResourcesGui___RemoveUnitHook takes unit whichUnit returns nothing
    if ( IsUnitInGroup(whichUnit, ResourcesGui___progressBarUnits) ) then
        call GroupRemoveUnit(ResourcesGui___progressBarUnits, whichUnit)
    endif
endfunction

//processed hook: hook RemoveUnit ResourcesGui___RemoveUnitHook


//library ResourcesGui ends
//library ResourcesLoadedMines:




function IsLoadedMine takes unit mine returns boolean
    return IsUnitInGroup(mine, ResourcesLoadedMines___mines)
endfunction

function SetLoadedMineHarvestBonusPerWorker takes unit mine,integer bonus returns nothing
    call SaveInteger(ResourcesLoadedMines___h, GetHandleId(mine), Index2D(0 , ResourcesLoadedMines___KEY_HARVEST_BONUS_PER_WORKER , ResourcesLoadedMines___MAX_KEYS), bonus)
endfunction

function GetLoadedMineHarvestBonusPerWorker takes unit mine returns integer
    return LoadInteger(ResourcesLoadedMines___h, GetHandleId(mine), Index2D(0 , ResourcesLoadedMines___KEY_HARVEST_BONUS_PER_WORKER , ResourcesLoadedMines___MAX_KEYS))
endfunction

function SetLoadedMineAllowedWorkerUnitTypeId takes unit mine,integer unitTypeId,boolean allowed returns nothing
    call SaveBoolean(ResourcesLoadedMines___h, GetHandleId(mine), Index2D(unitTypeId , ResourcesLoadedMines___KEY_ALLOWED_WORKER_UNIT_TYPE_ID , ResourcesLoadedMines___MAX_KEYS), allowed)
endfunction

function GetLoadedMineAllowedWorkerUnitTypeId takes unit mine,integer unitTypeId returns boolean
    return LoadBoolean(ResourcesLoadedMines___h, GetHandleId(mine), Index2D(unitTypeId , ResourcesLoadedMines___KEY_ALLOWED_WORKER_UNIT_TYPE_ID , ResourcesLoadedMines___MAX_KEYS))
endfunction

function AddLoadedMineWorkerUnitTypeId takes unit mine,integer unitTypeId returns nothing
    call SetLoadedMineAllowedWorkerUnitTypeId(mine , unitTypeId , true)
endfunction

function AddLoadedMine takes unit mine,integer resource,integer max,integer harvestBonusPerWorker returns nothing
    call AddMineEx(mine , resource , max)
    call GroupAddUnit(ResourcesLoadedMines___mines, mine)
    call SetLoadedMineHarvestBonusPerWorker(mine , harvestBonusPerWorker)
    call SetUnitDisableStopMiningOnError(mine , true)
endfunction

function RemoveLoadedMine takes unit mine returns nothing
    call RemoveMine(mine)
    call GroupRemoveUnit(ResourcesLoadedMines___mines, mine)
    call FlushChildHashtable(ResourcesLoadedMines___h, GetHandleId(mine))
endfunction

function PauseHarvestTimer takes nothing returns nothing
    call PauseTimer(ResourcesLoadedMines___harvestTimer)
endfunction

function ResumeHarvestTimer takes nothing returns nothing
    call ResumeTimer(ResourcesLoadedMines___harvestTimer)
endfunction

function ResourcesLoadedMines___GetFirstWorkerInLoadedMine takes unit mine returns unit
    local group cargo= (s__UnitEventEx___Cargo_copyGroup((GetUnitUserData(((mine)))))) // INLINED!!
    local unit first= FirstOfGroup(cargo)
    call GroupClear(cargo)
    call DestroyGroup(cargo)
    set cargo=null
    return first
endfunction

function ResourcesLoadedMines___HarvestMine takes unit mine,integer amount returns nothing
    local unit firstWorker= ResourcesLoadedMines___GetFirstWorkerInLoadedMine(mine)
    local integer r= 0
    local integer i= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer actualAmount= 0
    loop
        exitwhen ( i == max )
        set r=(s__Resource_resources[(i)]) // INLINED!!
        set actualAmount=(LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) // INLINED!!
        if ( actualAmount > 0 ) then
            set actualAmount=IMinBJ(actualAmount, amount + GetPlayerResourceBonus(GetOwningPlayer(mine) , r))
            call SetUnitResource(mine , r , (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( r) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) - actualAmount) // INLINED!!
            call CustomBountyEx(mine , GetOwningPlayer(firstWorker) , r , actualAmount)
            call ExecuteGatherCallbacks(mine , firstWorker , r , actualAmount)
        endif
        set i=i + 1
    endloop
    set firstWorker=null
endfunction

function ResourcesLoadedMines___ForGroupHarvest takes nothing returns nothing
    local unit mine= GetEnumUnit()
    local integer cargoSize= 0
    local integer amount= 0
    if ( not IsUnitPaused(mine) ) then
        set cargoSize=(CountUnitsInGroup(UnitEventEx___CargoGroup[((GetUnitUserData(((mine)))))])) // INLINED!!
        if ( cargoSize > 0 ) then
            set amount=cargoSize * (LoadInteger(ResourcesLoadedMines___h, GetHandleId((mine)), Index2D(0 , ResourcesLoadedMines___KEY_HARVEST_BONUS_PER_WORKER , ResourcesLoadedMines___MAX_KEYS))) // INLINED!!
            if ( amount > 0 ) then
                call QueueUnitAnimation(mine, "stand work")
                
                call ResourcesLoadedMines___HarvestMine(mine , amount)
                                    
                if ( IsMineEmpty(mine) ) then
                    if ( (LoadBoolean(Resources___h, GetHandleId((mine)), Index2D(0 , Resources___KEY_EXPLODE_ON_DEATH , Resources___KEY_MAX))) ) then // INLINED!!
                        call KillUnit(mine)
                    else
                        call RemoveLoadedMine(mine)
                    endif
                endif
            endif
        endif
    else
        call ResetUnitAnimation(mine)
    endif
    set mine=null
endfunction

function ResourcesLoadedMines___TimerFunctionHarvest takes nothing returns nothing
    call ForGroup(ResourcesLoadedMines___mines, function ResourcesLoadedMines___ForGroupHarvest)
endfunction

function ResourcesLoadedMines___TriggerConditionOrder takes nothing returns boolean
    local integer orderId= GetIssuedOrderId()
    local unit worker= GetOrderTargetUnit()
    local unit mine= GetTriggerUnit()
    if ( orderId == ResourcesLoadedMines_ORDER_ID_LOAD and mine != null and (IsUnitInGroup((mine), ResourcesLoadedMines___mines)) and not (LoadBoolean(ResourcesLoadedMines___h, GetHandleId((mine )), Index2D(( GetUnitTypeId(worker)) , ResourcesLoadedMines___KEY_ALLOWED_WORKER_UNIT_TYPE_ID , ResourcesLoadedMines___MAX_KEYS))) ) then // INLINED!!
        call IssueImmediateOrder(worker, "stop")
        call SimError(GetOwningPlayer(worker) , s__AFormat_result(s__AFormat_s(s__AFormat_s((s__AFormat_create((GetLocalizedString("CANNOT_HARVEST")))),GetUnitName(worker)),GetUnitName(mine)))) // INLINED!!
    endif
    set worker=null
    set mine=null
    return false
endfunction

function ResourcesLoadedMines___TriggerConditionDeath takes nothing returns boolean
    if ( (IsUnitInGroup((GetTriggerUnit()), ResourcesLoadedMines___mines)) ) then // INLINED!!
        call RemoveLoadedMine(GetTriggerUnit())
    endif
    return false
endfunction

function ResourcesLoadedMines___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(ResourcesLoadedMines___orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(ResourcesLoadedMines___orderTrigger, Condition(function ResourcesLoadedMines___TriggerConditionOrder))
    
    call TriggerRegisterAnyUnitEventBJ(ResourcesLoadedMines___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(ResourcesLoadedMines___deathTrigger, Condition(function ResourcesLoadedMines___TriggerConditionDeath))
    
    call TimerStart(ResourcesLoadedMines___harvestTimer, ResourcesLoadedMines_HARVEST_INTERVAL, true, function ResourcesLoadedMines___TimerFunctionHarvest)
endfunction


//library ResourcesLoadedMines ends
//library ResourcesTeamMultiboardGui:


function IsPlayerIgnoredForTeamResourceMultiboard takes player whichPlayer,player forPlayer returns boolean
    return ResourcesTeamMultiboardGui___playerIgnoredMultiboards[Index2D(GetPlayerId(whichPlayer) , GetPlayerId(forPlayer) , bj_MAX_PLAYERS)]
endfunction

function GetPlayerTeamResourceMultiboard takes player whichPlayer returns multiboard
    return ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId(whichPlayer)]
endfunction

function ResourcesTeamMultiboardGui___CountAlliesWithSharedControl takes player whichPlayer returns integer
    local integer count= 0
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)

         if ( slotPlayer == whichPlayer ) then
            set count=count + 1
         endif

        if ( slotPlayer != whichPlayer and GetPlayerAlliance(slotPlayer, whichPlayer, ALLIANCE_SHARED_CONTROL) or GetPlayerAlliance(slotPlayer, whichPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) and not (ResourcesTeamMultiboardGui___playerIgnoredMultiboards[Index2D(GetPlayerId((slotPlayer )) , GetPlayerId(( whichPlayer)) , bj_MAX_PLAYERS)]) ) then // INLINED!!
            set count=count + 1
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return count
endfunction

function ResourcesTeamMultiboardGui___IsAlliedPlayerWithSharedControl takes player viewingPlayer,player alliedPlayer returns boolean

    if ( viewingPlayer == alliedPlayer ) then
        return true
    endif

    return viewingPlayer != alliedPlayer and GetPlayerAlliance(alliedPlayer, viewingPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)
endfunction

function UpdatePlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    local multiboard mb= (ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId((whichPlayer))]) // INLINED!!
    local multiboarditem it= null
    local integer column= 1
    local integer percentage= 0
    local integer j= 0
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local player slotPlayer= null
    local integer r= 0
    local integer row= 0
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( not (ResourcesTeamMultiboardGui___playerIgnoredMultiboards[Index2D(GetPlayerId((slotPlayer )) , GetPlayerId(( whichPlayer)) , bj_MAX_PLAYERS)]) and ResourcesTeamMultiboardGui___IsAlliedPlayerWithSharedControl(whichPlayer , slotPlayer) ) then // INLINED!!
            set column=1
            set j=0
            loop
                exitwhen ( j == max )
                set r=(s__Resource_resources[(j)]) // INLINED!!
                if ( r != Resources_FOOD_MAX ) then
                    set it=MultiboardGetItem(mb, row, column)
                    if ( r == Resources_FOOD ) then
                        call MultiboardSetItemValue(it, I2S(GetPlayerResource(slotPlayer , r)) + "/" + I2S(GetPlayerResource(slotPlayer , Resources_FOOD_MAX)))
                    else
                        call MultiboardSetItemValue(it, I2S(GetPlayerResource(slotPlayer , r)))
                    endif
                    
                    if ( r != Resources_GOLD and r != Resources_LUMBER ) then
                        if ( r == Resources_FOOD ) then
                            set percentage=100 - GetPlayerResourceUpkeepRate(slotPlayer , Resources_GOLD)
                        else
                            set percentage=100 - GetPlayerResourceUpkeepRate(slotPlayer , r)
                        endif
                        if ( percentage <= 40 ) then
                            call MultiboardSetItemValueColor(it, 255, 0, 0, 0)
                        elseif ( percentage <= 70 ) then
                            call MultiboardSetItemValueColor(it, 255, 204, 0, 0)
                        elseif ( r == Resources_FOOD ) then
                            call MultiboardSetItemValueColor(it, 0, 255, 0, 0)
                        else
                            call MultiboardSetItemValueColor(it, 255, 255, 255, 0)
                        endif
                    endif
                    
                    call MultiboardReleaseItem(it)
                    set column=column + 1
                    set it=null
                endif
                set j=j + 1
            endloop
            set row=row + 1
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
endfunction

function UpdateAllTeamResourceMultiboards takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( ResourcesTeamMultiboardGui___playerMultiboards[i] != null ) then
            call UpdatePlayerTeamResourceMultiboard(Player(i))
        endif
        set i=i + 1
    endloop
endfunction

function PauseTeamResourceMultiboardsUpdates takes nothing returns nothing
    call PauseTimer(ResourcesTeamMultiboardGui___t)
endfunction

function ResumeTeamResourceMultiboardsUpdates takes nothing returns nothing
    call ResumeTimer(ResourcesTeamMultiboardGui___t)
endfunction

function ShowPlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay((ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId((whichPlayer))]), true) // INLINED!!
endfunction

function HidePlayerTeamResourceMultiboard takes player whichPlayer returns nothing
    call MultiboardDisplay((ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId((whichPlayer))]), false) // INLINED!!
endfunction

function ShowAllTeamResourceMultiboards takes nothing returns nothing
     local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call MultiboardDisplay((ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId((Player(i)))]), false) // INLINED!!
        set i=i + 1
    endloop
endfunction

function HideAllTeamResourceMultiboards takes nothing returns nothing
     local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call MultiboardDisplay((ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId((Player(i)))]), false) // INLINED!!
        set i=i + 1
    endloop
endfunction

function CreateTeamResourceMultiboards takes player whichPlayer returns multiboard
    local multiboarditem it= null
    local integer row= 0
    local integer column= 0
    local integer r= 0
    local integer i= 0
    local integer j= 0
    local player slotPlayer= null
    local integer max= (s__Resource_resourcesCount) // INLINED!!
    local integer columns= max
    local integer rows= ResourcesTeamMultiboardGui___CountAlliesWithSharedControl(whichPlayer)
    local multiboard mb= CreateMultiboardBJ(columns, rows, GetLocalizedString("TEAM_RESOURCES"))
    call MultiboardSetTitleTextColor(mb, 240, 240, 16, 0)
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( not (ResourcesTeamMultiboardGui___playerIgnoredMultiboards[Index2D(GetPlayerId((slotPlayer )) , GetPlayerId(( whichPlayer)) , bj_MAX_PLAYERS)]) and ResourcesTeamMultiboardGui___IsAlliedPlayerWithSharedControl(whichPlayer , slotPlayer) ) then // INLINED!!
            set column=0
            set it=MultiboardGetItem(mb, row, column)
            call MultiboardSetItemStyle(it, true, false)
            call MultiboardSetItemWidth(it, ResourcesTeamMultiboardGui_NAME_COLUMN_WIDTH)
            call MultiboardSetItemValue(it, GetPlayerName(slotPlayer))
            call MultiboardSetItemValueColor(it, GetPlayerColorRed(GetPlayerColor(slotPlayer)), GetPlayerColorGreen(GetPlayerColor(slotPlayer)), GetPlayerColorBlue(GetPlayerColor(slotPlayer)), 0)
            call MultiboardReleaseItem(it)
            set column=column + 1
            set j=0
            
            loop
                exitwhen ( column == columns )
                set r=(s__Resource_resources[(j)]) // INLINED!!

                if ( r != Resources_FOOD_MAX ) then
                    set it=MultiboardGetItem(mb, row, column)
                    call MultiboardSetItemStyle(it, true, true)
                    call MultiboardSetItemValue(it, "0")
                    call MultiboardSetItemIcon(it, (s__Resource_icon[(r)])) // INLINED!!
                    if ( r == Resources_FOOD ) then
                        call MultiboardSetItemWidth(it, ResourcesTeamMultiboardGui_FOOD_COLUMN_WIDTH)
                    else
                        call MultiboardSetItemWidth(it, ResourcesTeamMultiboardGui_RESOURCE_COLUMN_WIDTH)
                    endif
                    call MultiboardReleaseItem(it)
                    set column=column + 1
                endif
                set j=j + 1
            endloop
            
             set row=row + 1
        endif
        set slotPlayer=null
        
        set i=i + 1
    endloop
    call MultiboardDisplay(mb, GetLocalPlayer() == whichPlayer)
    call MultiboardMinimize(mb, false)
    
    return mb
endfunction

function RecreateTeamResourceMultiboardForPlayer takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    if ( ResourcesTeamMultiboardGui___playerMultiboards[playerId] != null ) then
        call DestroyMultiboard(ResourcesTeamMultiboardGui___playerMultiboards[playerId])
        set ResourcesTeamMultiboardGui___playerMultiboards[playerId]=null
    endif
    if ( ResourcesTeamMultiboardGui___CountAlliesWithSharedControl(whichPlayer) > 0 and GetPlayerController(whichPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING ) then
        set ResourcesTeamMultiboardGui___playerMultiboards[playerId]=CreateTeamResourceMultiboards(whichPlayer)
    endif
endfunction

function SetPlayerIgnoredForTeamResourceMultiboard takes player whichPlayer,player forPlayer,boolean ignored returns nothing
    set ResourcesTeamMultiboardGui___playerIgnoredMultiboards[Index2D(GetPlayerId(whichPlayer) , GetPlayerId(forPlayer) , bj_MAX_PLAYERS)]=ignored
    if ( ResourcesTeamMultiboardGui___playerMultiboards[GetPlayerId(forPlayer)] != null ) then
        call RecreateTeamResourceMultiboardForPlayer(forPlayer)
        call UpdatePlayerTeamResourceMultiboard(forPlayer)
    endif
endfunction

function RecreateTeamResourceMultiboards takes nothing returns nothing
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( ResourcesTeamMultiboardGui___playerMultiboards[i] != null ) then
            call DestroyMultiboard(ResourcesTeamMultiboardGui___playerMultiboards[i])
            set ResourcesTeamMultiboardGui___playerMultiboards[i]=null
        endif
        set slotPlayer=Player(i)
        if ( ResourcesTeamMultiboardGui___CountAlliesWithSharedControl(slotPlayer) > 0 and GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING ) then
            set ResourcesTeamMultiboardGui___playerMultiboards[i]=CreateTeamResourceMultiboards(slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
endfunction

function ResourcesTeamMultiboardGui___StartTeamResourceMultiboardsUpdates takes nothing returns nothing
    call TimerStart(ResourcesTeamMultiboardGui___t, ResourcesTeamMultiboardGui_TIMER_INTERVAL, true, function UpdateAllTeamResourceMultiboards)
endfunction

function ResourcesTeamMultiboardGui___StartGame takes nothing returns nothing
    call RecreateTeamResourceMultiboards()
    call UpdateAllTeamResourceMultiboards()
endfunction

function ResourcesTeamMultiboardGui___TriggerConditionAllianceChange takes nothing returns boolean
    call RecreateTeamResourceMultiboards()
    return false
endfunction

function ResourcesTeamMultiboardGui___Init takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        call TriggerRegisterPlayerAllianceChange(ResourcesTeamMultiboardGui___allianceChangeTrigger, Player(i), ALLIANCE_SHARED_ADVANCED_CONTROL)
        call TriggerRegisterPlayerAllianceChange(ResourcesTeamMultiboardGui___allianceChangeTrigger, Player(i), ALLIANCE_SHARED_CONTROL)
        set i=i + 1
    endloop
    call TriggerAddCondition(ResourcesTeamMultiboardGui___allianceChangeTrigger, Condition(function ResourcesTeamMultiboardGui___TriggerConditionAllianceChange))
    call TimerStart(ResourcesTeamMultiboardGui___t, ResourcesTeamMultiboardGui_TIMER_INTERVAL, true, function UpdateAllTeamResourceMultiboards) // INLINED!!
    call TriggerAddAction(OnStartGame___startGameTrigger, (function ResourcesTeamMultiboardGui___StartGame)) // INLINED!!
endfunction


//library ResourcesTeamMultiboardGui ends
//library ResourcesWarnings:




function SetResourceLowValue takes integer resource,integer lowValue returns nothing
    set ResourcesWarnings___resourceLowValue[resource]=lowValue
endfunction

function GetResourceLowValue takes integer resource returns integer
    return ResourcesWarnings___resourceLowValue[resource]
endfunction

function ResourcesWarnings___GetAlliesWithSharedControl takes player owner returns force
    local force allies= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) ) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return allies
endfunction

function ResourcesWarnings___StartSoundForAllies takes player whichPlayer,sound whichSound returns nothing
    local force allies= ResourcesWarnings___GetAlliesWithSharedControl(whichPlayer)
    if ( IsPlayerInForce(GetLocalPlayer(), allies) ) then
        call StartSound(whichSound)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function ResourcesWarnings___SimErrorForAllies takes player whichPlayer,string msg returns nothing
    local force allies= ResourcesWarnings___GetAlliesWithSharedControl(whichPlayer)
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( IsPlayerInForce(Player(i), allies) ) then
            call SimError(Player(i) , msg)
        endif
        set i=i + 1
    endloop
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function ResourcesWarnings___PingMinimapForAllies takes player whichPlayer,real x,real y returns nothing
    local force allies= ResourcesWarnings___GetAlliesWithSharedControl(whichPlayer)
    if ( IsPlayerInForce(GetLocalPlayer(), allies) ) then
        call PingMinimapEx(x, y, 4.0, 255, 255, 22, false)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies=null
endfunction

function SetLowResourcesSound takes player whichPlayer,integer resource,sound whichSound returns nothing
    set ResourcesWarnings___playerSoundLow[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]=whichSound
endfunction

function GetLowResourcesSound takes player whichPlayer,integer resource returns sound
    return ResourcesWarnings___playerSoundLow[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]
endfunction

function SetLowResourcesSoundForAllPlayers takes integer resource,sound whichSound returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesWarnings___playerSoundLow[Index2D(resource , i , bj_MAX_PLAYERS)]=whichSound
        set i=i + 1
    endloop
endfunction

function SetLowResourcesMessage takes player whichPlayer,integer resource,string message returns nothing
    set ResourcesWarnings___playerMessageLow[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]=message
endfunction

function GetLowResourcesMessage takes player whichPlayer,integer resource returns string
    return ResourcesWarnings___playerMessageLow[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]
endfunction

function SetLowResourcesMessageForAllPlayers takes integer resource,string message returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesWarnings___playerMessageLow[Index2D(resource , i , bj_MAX_PLAYERS)]=message
        set i=i + 1
    endloop
endfunction

function SetCollapsedesourcesSound takes player whichPlayer,integer resource,sound whichSound returns nothing
    set ResourcesWarnings___playerSoundCollapsed[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]=whichSound
endfunction

function GetCollapsedResourcesSound takes player whichPlayer,integer resource returns sound
    return ResourcesWarnings___playerSoundCollapsed[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]
endfunction

function SetCollapsedResourcesSoundForAllPlayers takes integer resource,sound whichSound returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesWarnings___playerSoundCollapsed[Index2D(resource , i , bj_MAX_PLAYERS)]=whichSound
        set i=i + 1
    endloop
endfunction

function SetCollapsedResourcesMessage takes player whichPlayer,integer resource,string message returns nothing
    set ResourcesWarnings___playerMessageCollapsed[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]=message
endfunction

function GetCollapsedResourcesMessage takes player whichPlayer,integer resource returns string
    return ResourcesWarnings___playerMessageCollapsed[Index2D(resource , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)]
endfunction

function SetCollapsedResourcesMessageForAllPlayers takes integer resource,string message returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set ResourcesWarnings___playerMessageCollapsed[Index2D(resource , i , bj_MAX_PLAYERS)]=message
        set i=i + 1
    endloop
endfunction

function ResourcesWarnings___TriggerConditionGather takes nothing returns boolean
    local integer resource= (Resources___triggerResource) // INLINED!!
    local unit mine= (Resources___triggerMine) // INLINED!!
    local unit worker= (Resources___triggerWorker) // INLINED!!
    local player owner= GetOwningPlayer(worker)
    if ( GetLowResourcesSound(owner , resource) != null and (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) <= (ResourcesWarnings___resourceLowValue[(resource)]) and (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) + resource > (ResourcesWarnings___resourceLowValue[(resource)]) ) then // INLINED!!
        call ResourcesWarnings___StartSoundForAllies(owner , GetLowResourcesSound(GetOwningPlayer((Resources___triggerWorker)) , resource)) // INLINED!!
        call ResourcesWarnings___PingMinimapForAllies(owner , GetUnitX(mine) , GetUnitY(mine))
        if ( GetLowResourcesMessage(owner , resource) != null and GetLowResourcesMessage(owner , resource) != "" ) then
            call ResourcesWarnings___SimErrorForAllies(owner , GetLowResourcesMessage(owner , resource))
        endif
    endif
    if ( GetCollapsedResourcesSound(owner , resource) != null and (LoadInteger(Resources___h, GetHandleId((mine )), Index2D(( resource) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) <= 0 ) then // INLINED!!
        call ResourcesWarnings___StartSoundForAllies(owner , GetCollapsedResourcesSound(owner , resource))
        call ResourcesWarnings___PingMinimapForAllies(owner , GetUnitX(mine) , GetUnitY(mine))
        if ( GetCollapsedResourcesMessage(owner , resource) != null and GetCollapsedResourcesMessage(owner , resource) != "" ) then
            call ResourcesWarnings___SimErrorForAllies(owner , GetCollapsedResourcesMessage(owner , resource))
        endif
    endif
    set mine=null
    set worker=null
    set mine=null
    set owner=null
    return false
endfunction

function ResourcesWarnings___Init takes nothing returns nothing
    call TriggerRegisterGatherEvent(ResourcesWarnings___gatherTrigger)
    call TriggerAddCondition(ResourcesWarnings___gatherTrigger, Condition(function ResourcesWarnings___TriggerConditionGather))
endfunction


//library ResourcesWarnings ends
//===========================================================================
// 
// Baradé's Resources 1.0
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
//*  SimError


//***************************************************************************
//*  FrameLoader vjass

//***************************************************************************
//*  Barades Math Utils
//***************************************************************************
//*  Barades Item Type Utils
//***************************************************************************
//*  Barades Unit Cost



//***************************************************************************
//*  Barades Refund
//***************************************************************************
//*  Barades On Start Game
//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades Player Color Utils
//***************************************************************************
//*  Barades String Format
//***************************************************************************
//*  GetSingleSelectedUnit
//***************************************************************************
//*  Barades Resources
//***************************************************************************
//*  Barades Resource Team Multiboard Gui
//***************************************************************************
//*  Barades Resources Gui
//***************************************************************************
//*  Barades Resources Costs
//***************************************************************************
//*  Barades Resources Warnings
//***************************************************************************
//*  Barades Resources Chat Commands
//***************************************************************************
//*  Barades Resources Loaded Mines
//***************************************************************************
//*  Map Resources

function RecreateOilPatchFromPlatform takes unit platform returns nothing
    local unit mine= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'u000', GetUnitX(platform), GetUnitY(platform), bj_UNIT_FACING)
    call SetResourceAmount(mine, (LoadInteger(Resources___h, GetHandleId((platform )), Index2D(( Oil) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))) // INLINED!!
endfunction

function RecreateRockMineFromShaft takes unit shaft returns nothing
    local unit mine= CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n001', GetUnitX(shaft), GetUnitY(shaft), bj_UNIT_FACING)
    call AddMineEx(mine , Rock , (LoadInteger(Resources___h, GetHandleId((shaft )), Index2D(( Rock) , Resources___KEY_RESOURCE , Resources___KEY_MAX)))) // INLINED!!
endfunction

// death event before resources are lost
function TriggerConditionDeath takes nothing returns boolean
    if ( GetUnitTypeId((Resources___triggerDyingResourceUnit)) == 'o002' and (LoadInteger(Resources___h, GetHandleId(((Resources___triggerDyingResourceUnit) )), Index2D(( Oil) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
        call RecreateOilPatchFromPlatform((Resources___triggerDyingResourceUnit)) // INLINED!!
    endif
    
    if ( GetUnitTypeId((Resources___triggerDyingResourceUnit)) == 'e000' and (LoadInteger(Resources___h, GetHandleId(((Resources___triggerDyingResourceUnit) )), Index2D(( Rock) , Resources___KEY_RESOURCE , Resources___KEY_MAX))) > 0 ) then // INLINED!!
        call RecreateRockMineFromShaft((Resources___triggerDyingResourceUnit)) // INLINED!!
    endif
    
    return false
endfunction


function InitResources takes nothing returns nothing
    // resources
    set Oil=(s__Resource_create(("Oil"))) // INLINED!!
    set s__Resource_goldExchangeRate[(Oil )]=(( 2.0)*1.0) // INLINED!!
    set s__Resource_icon[(Oil )]=( "ReplaceableTextures\\CommandButtons\\BTNOil.blp") // INLINED!!
    set s__Resource_iconAtt[(Oil )]=( "ReplaceableTextures\\ATTOil.blp") // INLINED!!
    set s__Resource_red[(Oil )]=( 50) // INLINED!!
    set s__Resource_green[(Oil )]=( 50) // INLINED!!
    set s__Resource_blue[(Oil )]=( 50) // INLINED!!
    
    set Rock=(s__Resource_create(("Rock"))) // INLINED!!
    set s__Resource_goldExchangeRate[(Rock )]=(( 0.5)*1.0) // INLINED!!
    set s__Resource_icon[(Rock )]=( "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Rock_01.blp") // INLINED!!
    set s__Resource_iconAtt[(Rock )]=( "ReplaceableTextures\\ATTINV_Misc_Rock_01.blp") // INLINED!!
    set s__Resource_red[(Rock )]=( 128) // INLINED!!
    set s__Resource_green[(Rock )]=( 128) // INLINED!!
    set s__Resource_blue[(Rock )]=( 128) // INLINED!!
    
    set Wheat=(s__Resource_create(("Wheat"))) // INLINED!!
    set s__Resource_goldExchangeRate[(Wheat )]=(( 1.0)*1.0) // INLINED!!
    set s__Resource_icon[(Wheat )]=( "ReplaceableTextures\\CommandButtons\\BTNWheat.blp") // INLINED!!
    set s__Resource_iconAtt[(Wheat )]=( "ReplaceableTextures\\ATTWheat.blp") // INLINED!!
    set s__Resource_red[(Wheat )]=( 243) // INLINED!!
    set s__Resource_green[(Wheat )]=( 164) // INLINED!!
    set s__Resource_blue[(Wheat )]=( 2) // INLINED!!
    
    set Ore=(s__Resource_create(("Ore"))) // INLINED!!
    set s__Resource_goldExchangeRate[(Ore )]=(( 1.2)*1.0) // INLINED!!
    set s__Resource_icon[(Ore )]=( "ReplaceableTextures\\CommandButtons\\BTNINV_Ore_Iron_01.blp") // INLINED!!
    set s__Resource_iconAtt[(Ore )]=( "ReplaceableTextures\\ATTINV_Ore_Iron_01.blp") // INLINED!!
    set s__Resource_red[(Ore )]=( 192) // INLINED!!
    set s__Resource_green[(Ore )]=( 192) // INLINED!!
    set s__Resource_blue[(Ore )]=( 192) // INLINED!!
    
    // warnings
    call SetNotEnoughResourcesSoundForAllPlayers(Oil , gg_snd_GruntNoOil1)
    set ResourcesWarnings___resourceLowValue[(Oil )]=( 1500) // INLINED!!
    call SetLowResourcesSoundForAllPlayers(Oil , gg_snd_GruntOilPlatformLow1)
    call SetLowResourcesMessageForAllPlayers(Oil , GetLocalizedString("LOW_OIL"))
    call SetCollapsedResourcesSoundForAllPlayers(Oil , gg_snd_GruntOilPlatformCollapsed1)
    call SetCollapsedResourcesMessageForAllPlayers(Oil , GetLocalizedString("COLLAPESD_OIL"))
    
    call SetNotEnoughResourcesSoundForAllPlayers(Rock , gg_snd_GruntNoRock1)
    set ResourcesWarnings___resourceLowValue[(Rock )]=( 1500) // INLINED!!
    call SetLowResourcesSoundForAllPlayers(Rock , gg_snd_GruntRockMineLow1)
    call SetLowResourcesMessageForAllPlayers(Rock , GetLocalizedString("LOW_ROCK"))
    call SetCollapsedResourcesSoundForAllPlayers(Rock , gg_snd_GruntRockMineCollapsed1)
    call SetCollapsedResourcesMessageForAllPlayers(Rock , GetLocalizedString("COLLAPSED_ROCK"))
    
    call SetNotEnoughResourcesSoundForAllPlayers(Wheat , gg_snd_GruntNoWheat1)
    set ResourcesWarnings___resourceLowValue[(Wheat )]=( 1500) // INLINED!!
    call SetLowResourcesSoundForAllPlayers(Wheat , gg_snd_GruntWheatFieldLow1)
    call SetLowResourcesMessageForAllPlayers(Wheat , GetLocalizedString("LOW_WHEAT"))
    call SetCollapsedResourcesSoundForAllPlayers(Wheat , gg_snd_GruntWheatFieldCollapsed1)
    call SetCollapsedResourcesMessageForAllPlayers(Wheat , GetLocalizedString("COLLAPSED_WHEAT"))
    
    // costs
    call SetObjectTypeResourcesCosts(('ogru' ) , ( Wheat ) , ( 150)) // INLINED!!
    
    call SetObjectTypeResourcesCosts(('oli2' ) , ( Rock ) , ( 200)) // INLINED!!
    call SetObjectTypeResourcesCosts(('o003' ) , ( Oil ) , ( 200)) // INLINED!!
    call SetObjectTypeResourcesCosts(('o004' ) , ( Oil ) , ( 400)) // INLINED!!
    
    call SetObjectTypeResourcesCosts(('o000' ) , ( Rock ) , ( 500)) // INLINED!!
    call SetObjectTypeResourcesCosts(('obot' ) , ( Oil ) , ( 700)) // INLINED!!
    call SetObjectTypeResourcesCosts(('odes' ) , ( Oil ) , ( 700)) // INLINED!!
    call SetObjectTypeResourcesCosts(('ojgn' ) , ( Oil ) , ( 1000)) // INLINED!!
    
    call SetObjectTypeResourcesCosts(('ngrk' ) , ( Rock ) , ( 200)) // INLINED!!
    call SetObjectTypeResourcesCosts(('ngrk' ) , ( Oil ) , ( 200)) // INLINED!!
    call SetObjectTypeResourcesCosts(('ngrk' ) , ( Wheat ) , ( 200)) // INLINED!!
    
    call SetObjectTypeResourcesCosts(('bspd' ) , ( Rock ) , ( 200)) // INLINED!!
    call SetObjectTypeResourcesCosts(('bspd' ) , ( Oil ) , ( 200)) // INLINED!!
    
    call SetResearchCostsForLevel('R000' , 0 , Oil , 1000)
    call SetResearchCostsForLevel('R000' , 1 , Oil , 3000)
    
    call SetAbilityCostsForLevel(('A009' ) , 1 , ( Wheat ) , ( 150)) // INLINED!!
    
    // callbacks
    call TriggerRegisterDeathResourceEvent(deathTrigger)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

function UpdatePlayerTaxes takes player whichPlayer returns nothing
    local integer food= GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED)
    local integer oldUpkeepRate= GetPlayerResourceUpkeepRate(whichPlayer , Wheat)
    if ( food >= 81 and oldUpkeepRate < 60 ) then
        call SetPlayerResourceUpkeepRate(whichPlayer , Wheat , 60)
    elseif ( food >= 51 and oldUpkeepRate < 30 ) then
        call SetPlayerResourceUpkeepRate(whichPlayer , Wheat , 30)
    elseif ( food < 51 and oldUpkeepRate > 0 ) then
        call SetPlayerResourceUpkeepRate(whichPlayer , Wheat , 0)
    endif
endfunction

function AddStartResources takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Oil , 100)
    call AddPlayerResource(whichPlayer , Rock , 100)
    call AddPlayerResource(whichPlayer , Wheat , 100)
    call AddPlayerResource(whichPlayer , Ore , 100)
endfunction

function CheatResources takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Oil , 1000)
    call AddPlayerResource(whichPlayer , Rock , 1000)
    call AddPlayerResource(whichPlayer , Wheat , 1000)
    call AddPlayerResource(whichPlayer , Ore , 1000)
    
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, "Cheated 1000 units of Oil, Rock, Wheat and Ore!")
    call PrintResourcesGuiSelection(whichPlayer)
endfunction

function ForceUIBuildings takes unit worker returns nothing
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        // we could also check if it is the only selected unit for the player who has shared control
        if ( GetOwningPlayer(worker) == Player(i) or ( GetPlayerAlliance(GetOwningPlayer(worker), Player(i), ALLIANCE_SHARED_CONTROL) and IsUnitSelected(worker, Player(i)) ) ) then
            call ForceUIKeyBJ(Player(i), "B")
        endif
        set i=i + 1
    endloop
endfunction

function Buy100Oil takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Oil , 100)
endfunction

function Sell100Oil takes player whichPlayer returns nothing
    call ExchangePlayerResource(whichPlayer , Oil , Resources_GOLD , 100)
endfunction

function Buy100Rock takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Rock , 100)
endfunction

function Sell100Rock takes player whichPlayer returns nothing
    call ExchangePlayerResource(whichPlayer , Rock , Resources_GOLD , 100)
endfunction

function Buy100Wheat takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Wheat , 100)
endfunction

function Sell100Wheat takes player whichPlayer returns nothing
    call ExchangePlayerResource(whichPlayer , Wheat , Resources_GOLD , 100)
endfunction

function Buy100Ore takes player whichPlayer returns nothing
    call AddPlayerResource(whichPlayer , Ore , 100)
endfunction

function Sell100Ore takes player whichPlayer returns nothing
    call ExchangePlayerResource(whichPlayer , Ore , Resources_GOLD , 100)
endfunction

function AddOilTanker takes unit worker returns nothing
    call AddWorker(worker)
    call SetUnitHarvestDuration(worker , Oil , 2.0)
    call AddResourceToWorker(worker , Oil , 'A000' , "harvest" , 'A001' , "roar" , 'A004' , "robogoblin" , 100 , 100 , "gold")
endfunction

function AddPeon takes unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker , Rock , 'A003' , "heal" , 'A001' , "roar" , 'A005' , "robogoblin" , 15 , 15 , "gold")
    call AddResourceToWorker(worker , Wheat , 'A003' , "heal" , 'A001' , "roar" , 'A005' , "robogoblin" , 20 , 20 , "lumber")
    call SetUnitResourceSkin(worker , Wheat , 'o009')
endfunction

function AddDrillbot takes unit worker returns nothing
    call AddWorker(worker)
    call AddResourceToWorker(worker , Rock , 'A003' , "heal" , 'A001' , "roar" , 'A005' , "robogoblin" , 200 , 10 , "gold")
endfunction

function AddTownHall takes unit whichUnit returns nothing
    call GroupAddUnit(Resources___returnBuildings, (whichUnit)) // INLINED!!
    call SetUnitReturnResource((whichUnit ) , ( Oil) , true) // INLINED!!
    call SetUnitReturnResource((whichUnit ) , ( Rock) , true) // INLINED!!
    call SetUnitReturnResource((whichUnit ) , ( Wheat) , true) // INLINED!!
endfunction

function AddShipyard takes unit whichUnit returns nothing
    call AddReturnBuildingEx(whichUnit , Oil)
endfunction

function AddOilPlatformEx takes unit worker,unit mine,integer oil returns nothing
    call UnitRemoveAbility(mine, 'Aegm')
    call AddMineEx(mine , Oil , oil)
    call SetMineTakeWorkerInside(mine , true)
    call SetMineMaxWorkers(mine , 1)
    
    // TODO the worker seems to be the mine itself.
    //call ConstructedMine(worker, mine)
endfunction

function AddOilPlatform takes unit worker,unit mine returns nothing
    call AddOilPlatformEx(worker , mine , 20000)
endfunction

function AddOilPlatformLow takes unit mine returns nothing
    call AddOilPlatformEx(null , mine , 2000)
endfunction

function StartConstructingOilPlatform takes unit worker,unit mine returns nothing
    call UnitRemoveAbility(mine, 'Aegm')
endfunction

function AddRockMineShaft takes unit worker,unit mine returns nothing
    call UnitRemoveAbility(mine, 'Aegm')
    call AddLoadedMine(mine , Rock , 50000 , 10) // TODO Get the rock amount from the Rock Mine.
    call SetLoadedMineAllowedWorkerUnitTypeId((mine ) , ( 'o006') , true) // INLINED!!
    call SetLoadedMineAllowedWorkerUnitTypeId((mine ) , ( 'o007') , true) // INLINED!!

    // TODO the worker seems to be the mine itself.
    //call ConstructedMine(worker, mine)
endfunction

function StartConstructingRockMineShaft takes unit worker,unit mine returns nothing
    call UnitRemoveAbility(mine, 'Aegm')
endfunction

function AddRockMine takes unit whichUnit returns nothing
    call AddMineEx(whichUnit , Rock , 20000)
endfunction

function AddWheatField takes unit whichUnit returns nothing
    call AddMineEx(whichUnit , Wheat , 15000)
endfunction


function AddOilRefinery takes unit whichUnit returns nothing
    set playerRefineryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerRefineryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] + 1
    call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Oil , 25)
    call AddReturnBuildingEx(whichUnit , Oil)
endfunction

function RemoveOilRefinery takes unit whichUnit returns nothing
    set playerRefineryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerRefineryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] - 1
    if ( playerRefineryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] <= 0 ) then
        call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Oil , 0)
    endif
endfunction


function AddQuarry takes unit whichUnit returns nothing
    set playerQuarryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerQuarryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] + 1
    call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Rock , 25)
    call AddReturnBuildingEx(whichUnit , Rock)
endfunction

function RemoveQuarry takes unit whichUnit returns nothing
    set playerQuarryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerQuarryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] - 1
    if ( playerQuarryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] <= 0 ) then
        call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Rock , 0)
    endif
endfunction


function AddGranary takes unit whichUnit returns nothing
    set playerGranaryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerGranaryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] + 1
    call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Wheat , 25)
    call AddReturnBuildingEx(whichUnit , Wheat)
endfunction

function RemoveGranary takes unit whichUnit returns nothing
    set playerGranaryCounters[GetPlayerId(GetOwningPlayer(whichUnit))]=playerGranaryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] - 1
    if ( playerGranaryCounters[GetPlayerId(GetOwningPlayer(whichUnit))] <= 0 ) then
        call SetPlayerResourceBonus(GetOwningPlayer(whichUnit) , Wheat , 0)
    endif
endfunction

function AddOreMineShaft takes unit mine returns nothing
    call AddLoadedMine(mine , Ore , 50000 , 10)
    call SetLoadedMineAllowedWorkerUnitTypeId((mine ) , ( 'o006') , true) // INLINED!!
    call SetLoadedMineAllowedWorkerUnitTypeId((mine ) , ( 'o007') , true) // INLINED!!
endfunction


//***************************************************************************
//*
//*  Sound Assets
//*
//***************************************************************************

function InitSounds takes nothing returns nothing
    set gg_snd_GruntNoOil1=CreateSound("war3mapImported/GruntNoOil1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntNoOil1, 1764)
    call SetSoundChannel(gg_snd_GruntNoOil1, 8)
    call SetSoundVolume(gg_snd_GruntNoOil1, 127)
    call SetSoundPitch(gg_snd_GruntNoOil1, 1.0)
    set gg_snd_GruntNoRock1=CreateSound("war3mapImported/GruntNoRock1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntNoRock1, 1822)
    call SetSoundChannel(gg_snd_GruntNoRock1, 8)
    call SetSoundVolume(gg_snd_GruntNoRock1, 127)
    call SetSoundPitch(gg_snd_GruntNoRock1, 1.0)
    set gg_snd_GruntNoWheat1=CreateSound("war3mapImported/GruntNoWheat1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntNoWheat1, 1131)
    call SetSoundChannel(gg_snd_GruntNoWheat1, 8)
    call SetSoundVolume(gg_snd_GruntNoWheat1, 127)
    call SetSoundPitch(gg_snd_GruntNoWheat1, 1.0)
    set gg_snd_GruntOilPlatformCollapsed1=CreateSound("war3mapImported/GruntOilPlatformCollapsed1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntOilPlatformCollapsed1, 2461)
    call SetSoundChannel(gg_snd_GruntOilPlatformCollapsed1, 8)
    call SetSoundVolume(gg_snd_GruntOilPlatformCollapsed1, 127)
    call SetSoundPitch(gg_snd_GruntOilPlatformCollapsed1, 1.0)
    set gg_snd_GruntOilPlatformLow1=CreateSound("war3mapImported/GruntOilPlatformLow1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntOilPlatformLow1, 2728)
    call SetSoundChannel(gg_snd_GruntOilPlatformLow1, 8)
    call SetSoundVolume(gg_snd_GruntOilPlatformLow1, 127)
    call SetSoundPitch(gg_snd_GruntOilPlatformLow1, 1.0)
    set gg_snd_GruntRockMineCollapsed1=CreateSound("war3mapImported/GruntRockMineCollapsed1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntRockMineCollapsed1, 2240)
    call SetSoundChannel(gg_snd_GruntRockMineCollapsed1, 8)
    call SetSoundVolume(gg_snd_GruntRockMineCollapsed1, 127)
    call SetSoundPitch(gg_snd_GruntRockMineCollapsed1, 1.0)
    set gg_snd_GruntRockMineLow1=CreateSound("war3mapImported/GruntRockMineLow1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntRockMineLow1, 2461)
    call SetSoundChannel(gg_snd_GruntRockMineLow1, 8)
    call SetSoundVolume(gg_snd_GruntRockMineLow1, 127)
    call SetSoundPitch(gg_snd_GruntRockMineLow1, 1.0)
    set gg_snd_GruntWheatFieldCollapsed1=CreateSound("war3mapImported/GruntWheatFieldCollapsed1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntWheatFieldCollapsed1, 2229)
    call SetSoundChannel(gg_snd_GruntWheatFieldCollapsed1, 8)
    call SetSoundVolume(gg_snd_GruntWheatFieldCollapsed1, 127)
    call SetSoundPitch(gg_snd_GruntWheatFieldCollapsed1, 1.0)
    set gg_snd_GruntWheatFieldLow1=CreateSound("war3mapImported/GruntWheatFieldLow1.wav", false, false, false, 1, 1, "SpellsEAX")
    call SetSoundDuration(gg_snd_GruntWheatFieldLow1, 2670)
    call SetSoundChannel(gg_snd_GruntWheatFieldLow1, 8)
    call SetSoundVolume(gg_snd_GruntWheatFieldLow1, 127)
    call SetSoundPitch(gg_snd_GruntWheatFieldLow1, 1.0)
endfunction

//***************************************************************************
//*
//*  Items
//*
//***************************************************************************

function CreateAllItems takes nothing returns nothing
    local integer itemID

    call BlzCreateItemWithSkin('I000', 1113.6, - 239.3, 'I000')
    call BlzCreateItemWithSkin('I000', 1115.3, - 376.4, 'I000')
    call BlzCreateItemWithSkin('I000', 919.0, - 234.6, 'I000')
    call BlzCreateItemWithSkin('I000', 974.0, - 364.6, 'I000')
    call BlzCreateItemWithSkin('I000', 1010.7, - 219.5, 'I000')
    call BlzCreateItemWithSkin('I000', 1008.1, - 97.8, 'I000')
    call BlzCreateItemWithSkin('I000', 1091.3, - 128.2, 'I000')
    call BlzCreateItemWithSkin('I000', 884.2, - 145.1, 'I000')
    call BlzCreateItemWithSkin('I000', 860.8, - 354.6, 'I000')
    call BlzCreateItemWithSkin('I000', 1027.1, - 519.7, 'I000')
    call BlzCreateItemWithSkin('I000', 904.9, - 514.7, 'I000')
    call BlzCreateItemWithSkin('I000', - 2240.0, - 155.8, 'I000')
    call BlzCreateItemWithSkin('I000', - 2268.0, - 287.7, 'I000')
    call BlzCreateItemWithSkin('I000', - 2410.2, - 144.1, 'I000')
    call BlzCreateItemWithSkin('I000', - 2427.8, - 289.6, 'I000')
    call BlzCreateItemWithSkin('I000', - 2374.8, - 195.8, 'I000')
    call BlzCreateItemWithSkin('I000', - 2345.4, - 342.8, 'I000')
    call BlzCreateItemWithSkin('I000', - 2258.1, - 449.7, 'I000')
    call BlzCreateItemWithSkin('I000', - 2413.7, - 466.0, 'I000')
    call BlzCreateItemWithSkin('I000', - 2486.3, - 201.6, 'I000')
    call BlzCreateItemWithSkin('I000', - 2339.8, - 71.8, 'I000')
    call BlzCreateItemWithSkin('I000', - 2454.3, - 45.0, 'I000')
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateBuildingsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'o000', - 1856.0, - 1024.0, 270.000, 'o000')
    set u=BlzCreateUnitWithSkin(p, 'o002', - 3008.0, - 2496.0, 270.000, 'o002')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 2976.0, 96.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 3168.0, - 96.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 2976.0, - 96.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 3168.0, 96.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 3168.0, - 288.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 2976.0, - 288.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'ogre', - 1920.0, - 256.0, 270.000, 'ogre')
    set u=BlzCreateUnitWithSkin(p, 'obar', 128.0, - 320.0, 270.000, 'obar')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 3168.0, - 480.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 2976.0, - 480.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 3168.0, - 672.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 2976.0, - 672.0, 270.000, 'otrb')
endfunction

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'o001', - 1477.8, - 1236.0, 106.439, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'o001', - 1244.8, - 1205.6, 106.439, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'o001', - 1013.8, - 1141.4, 106.439, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'opeo', - 2061.9, 44.9, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', - 1961.4, 64.1, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', - 1840.3, 54.5, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', - 1728.5, 52.6, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', - 1637.6, 54.5, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'Ofar', - 1572.4, - 286.1, 270.000, 'Ofar')
    set u=BlzCreateUnitWithSkin(p, 'n003', - 1667.5, - 496.2, 270.000, 'n003')
    set u=BlzCreateUnitWithSkin(p, 'n003', - 1481.8, - 507.1, 270.000, 'n003')
    set u=BlzCreateUnitWithSkin(p, 'n005', - 1500.7, 45.6, 270.000, 'n005')
endfunction

//===========================================================================
function CreateBuildingsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'o000', 1664.0, - 1024.0, 270.000, 'o000')
    set gg_unit_o002_0010=BlzCreateUnitWithSkin(p, 'o002', 2880.0, - 2176.0, 270.000, 'o002')
    call SetResourceAmount(gg_unit_o002_0010, 12500)
    set u=BlzCreateUnitWithSkin(p, 'otrb', 32.0, 416.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 416.0, 608.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 32.0, 608.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 224.0, 608.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 224.0, 416.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'ogre', 1472.0, - 320.0, 270.000, 'ogre')
    set u=BlzCreateUnitWithSkin(p, 'o005', 2272.0, 288.0, 270.000, 'o005')
    set u=BlzCreateUnitWithSkin(p, 'o008', 2976.0, 288.0, 270.000, 'o008')
    set u=BlzCreateUnitWithSkin(p, 'o004', 1216.0, - 1024.0, 270.000, 'o004')
    set u=BlzCreateUnitWithSkin(p, 'o003', 2880.0, - 1024.0, 270.000, 'o003')
    set u=BlzCreateUnitWithSkin(p, 'obar', 576.0, - 320.0, 270.000, 'obar')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 416.0, 416.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 608.0, 608.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', 608.0, 416.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 160.0, 608.0, 270.000, 'otrb')
    set u=BlzCreateUnitWithSkin(p, 'otrb', - 160.0, 416.0, 270.000, 'otrb')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'o001', 2135.8, - 1050.8, 272.759, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'o001', 2376.0, - 1058.9, 272.759, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'o001', 2584.3, - 1070.2, 272.759, 'o001')
    set u=BlzCreateUnitWithSkin(p, 'opeo', 1282.5, - 44.0, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', 1410.1, - 29.5, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', 1527.1, - 33.2, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', 1655.8, - 16.9, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'opeo', 1750.3, - 29.5, 270.000, 'opeo')
    set gg_unit_opeo_0044=BlzCreateUnitWithSkin(p, 'opeo', 2193.5, 40.0, 270.000, 'opeo')
    set gg_unit_opeo_0045=BlzCreateUnitWithSkin(p, 'opeo', 2322.1, 56.3, 270.000, 'opeo')
    set gg_unit_opeo_0046=BlzCreateUnitWithSkin(p, 'opeo', 2416.6, 43.6, 270.000, 'opeo')
    set gg_unit_opeo_0052=BlzCreateUnitWithSkin(p, 'opeo', 2907.2, 24.8, 270.000, 'opeo')
    set gg_unit_opeo_0053=BlzCreateUnitWithSkin(p, 'opeo', 3035.9, 41.1, 270.000, 'opeo')
    set gg_unit_opeo_0054=BlzCreateUnitWithSkin(p, 'opeo', 3130.4, 28.4, 270.000, 'opeo')
    set u=BlzCreateUnitWithSkin(p, 'Obla', 1852.8, - 334.8, 270.000, 'Obla')
    set u=BlzCreateUnitWithSkin(p, 'n003', 1794.1, - 495.4, 270.000, 'n003')
    set u=BlzCreateUnitWithSkin(p, 'n003', 1968.3, - 504.8, 270.000, 'n003')
    set u=BlzCreateUnitWithSkin(p, 'n005', 1912.0, - 41.0, 270.000, 'n005')
endfunction

//===========================================================================
function CreateBuildingsForPlayer2 takes nothing returns nothing
    local player p= Player(2)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'n006', - 2560.0, 576.0, 270.000, 'n006')
    set u=BlzCreateUnitWithSkin(p, 'n006', 1088.0, 448.0, 270.000, 'n006')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ngol', - 1920.0, 576.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'n001', - 1152.0, - 256.0, 270.000, 'n001')
    set u=BlzCreateUnitWithSkin(p, 'ngol', 1600.0, 448.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set gg_unit_n001_0005=BlzCreateUnitWithSkin(p, 'n001', 2304.0, - 448.0, 270.000, 'n001')
    set u=BlzCreateUnitWithSkin(p, 'u000', - 2404.3, - 2900.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', - 2019.4, - 2272.0, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', 1883.7, - 2644.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', 667.7, - 2196.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'ngme', - 448.0, - 128.0, 270.000, 'ngme')
    set u=BlzCreateUnitWithSkin(p, 'nmer', - 512.0, 320.0, 270.000, 'nmer')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'n000', - 1152.0, 448.0, 270.000, 'n000')
    set gg_unit_n000_0050=BlzCreateUnitWithSkin(p, 'n000', 2944.0, - 448.0, 270.000, 'n000')
    set u=BlzCreateUnitWithSkin(p, 'n004', - 448.0, - 512.0, 270.000, 'n004')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'u000', - 1188.3, - 3028.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', - 548.3, - 2516.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', 27.7, - 3284.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', - 1188.3, - 1940.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', 987.7, - 3220.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'u000', 2843.7, - 3220.4, 270.000, 'u000')
    call SetResourceAmount(u, 12500)
    set u=BlzCreateUnitWithSkin(p, 'ngad', - 448.0, - 1024.0, 270.000, 'ngad')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
    call CreateBuildingsForPlayer0()
    call CreateBuildingsForPlayer1()
    call CreateBuildingsForPlayer2()
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
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: UnitDex
//===========================================================================


//===========================================================================
// Trigger: WorldBounds
//===========================================================================
//===========================================================================
// Trigger: RegisterPlayerUnitEvent Magtheridon96
//===========================================================================

//===========================================================================
// Trigger: RegisterNativeEvent
//===========================================================================



//===========================================================================
// Trigger: UnitEventEx
//
// Barade: Adapt to RegisterPlayerUnitEvent by Magtheridon96.
//===========================================================================



    // //! external ObjectMerger w3a Adef EETD anam "Detect Transform" ansf "(UnitEventEx)" aart "" acat "" arac 0


//===========================================================================
// Trigger: Resources Init
//===========================================================================
function Trig_Resources_Init_Actions takes nothing returns nothing
    call BlzLoadTOCFile("war3mapImported\\Resources.toc")
    call InitResources()
endfunction

//===========================================================================
function InitTrig_Resources_Init takes nothing returns nothing
    set gg_trg_Resources_Init=CreateTrigger()
    call TriggerAddAction(gg_trg_Resources_Init, function Trig_Resources_Init_Actions)
endfunction

//===========================================================================
// Trigger: Resources Start
//===========================================================================
function Trig_Resources_Start_Func001001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_TOWNHALL) == true )
endfunction

function Trig_Resources_Start_Func001A takes nothing returns nothing
    call AddTownHall(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func002A takes nothing returns nothing
    call AddOilPlatformEx(null , (GetEnumUnit()) , 2000) // INLINED!!
endfunction

function Trig_Resources_Start_Func003A takes nothing returns nothing
    call AddMineEx((GetEnumUnit()) , Rock , 20000) // INLINED!!
endfunction

function Trig_Resources_Start_Func004A takes nothing returns nothing
    call AddMineEx((GetEnumUnit()) , Wheat , 15000) // INLINED!!
endfunction

function Trig_Resources_Start_Func005A takes nothing returns nothing
    call AddPeon(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func006A takes nothing returns nothing
    call AddOilTanker(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func007A takes nothing returns nothing
    call AddReturnBuildingEx((GetEnumUnit()) , Oil) // INLINED!!
endfunction

function Trig_Resources_Start_Func008A takes nothing returns nothing
    call AddOilRefinery(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func009A takes nothing returns nothing
    call AddQuarry(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func010A takes nothing returns nothing
    call AddGranary(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func011A takes nothing returns nothing
    call AddDrillbot(GetEnumUnit())
endfunction

function Trig_Resources_Start_Func012A takes nothing returns nothing
    call AddOreMineShaft(GetEnumUnit())
endfunction

function Trig_Resources_Start_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function Trig_Resources_Start_Func001001002)), function Trig_Resources_Start_Func001A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o002'), function Trig_Resources_Start_Func002A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n001'), function Trig_Resources_Start_Func003A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n000'), function Trig_Resources_Start_Func004A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('opeo'), function Trig_Resources_Start_Func005A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o001'), function Trig_Resources_Start_Func006A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o000'), function Trig_Resources_Start_Func007A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o003'), function Trig_Resources_Start_Func008A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o005'), function Trig_Resources_Start_Func009A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('o008'), function Trig_Resources_Start_Func010A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n005'), function Trig_Resources_Start_Func011A)
    call ForGroupBJ(GetUnitsOfTypeIdAll('n006'), function Trig_Resources_Start_Func012A)
endfunction

//===========================================================================
function InitTrig_Resources_Start takes nothing returns nothing
    set gg_trg_Resources_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Resources_Start, 0.00)
    call TriggerAddAction(gg_trg_Resources_Start, function Trig_Resources_Start_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Town Hall
//===========================================================================
function Trig_Resources_Constructed_Town_Hall_Conditions takes nothing returns boolean
    if ( not ( IsUnitType(GetConstructedStructure(), UNIT_TYPE_TOWNHALL) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Town_Hall_Actions takes nothing returns nothing
    call AddTownHall(GetConstructedStructure())
    call ConstructedReturnBuilding(GetTriggerUnit() , GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Town_Hall takes nothing returns nothing
    set gg_trg_Resources_Constructed_Town_Hall=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Town_Hall, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Town_Hall, Condition(function Trig_Resources_Constructed_Town_Hall_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Town_Hall, function Trig_Resources_Constructed_Town_Hall_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Shipyard
//===========================================================================
function Trig_Resources_Constructed_Shipyard_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'o000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Shipyard_Actions takes nothing returns nothing
    call AddReturnBuildingEx((GetConstructedStructure()) , Oil) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Shipyard takes nothing returns nothing
    set gg_trg_Resources_Constructed_Shipyard=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Shipyard, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Shipyard, Condition(function Trig_Resources_Constructed_Shipyard_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Shipyard, function Trig_Resources_Constructed_Shipyard_Actions)
endfunction

//===========================================================================
// Trigger: Resources Starts Constructing Oil Platform
//===========================================================================
function Trig_Resources_Starts_Constructing_Oil_Platform_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructingStructure()) == 'o002' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Starts_Constructing_Oil_Platform_Actions takes nothing returns nothing
    call StartConstructingOilPlatform(GetTriggerUnit() , GetConstructingStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Starts_Constructing_Oil_Platform takes nothing returns nothing
    set gg_trg_Resources_Starts_Constructing_Oil_Platform=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Starts_Constructing_Oil_Platform, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(gg_trg_Resources_Starts_Constructing_Oil_Platform, Condition(function Trig_Resources_Starts_Constructing_Oil_Platform_Conditions))
    call TriggerAddAction(gg_trg_Resources_Starts_Constructing_Oil_Platform, function Trig_Resources_Starts_Constructing_Oil_Platform_Actions)
endfunction

//===========================================================================
// Trigger: Resources Starts Constructing Rock Mine Shaft
//===========================================================================
function Trig_Resources_Starts_Constructing_Rock_Mine_Shaft_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructingStructure()) == 'e000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Starts_Constructing_Rock_Mine_Shaft_Actions takes nothing returns nothing
    call StartConstructingRockMineShaft(GetTriggerUnit() , GetConstructingStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Starts_Constructing_Rock_Mine_Shaft takes nothing returns nothing
    set gg_trg_Resources_Starts_Constructing_Rock_Mine_Shaft=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Starts_Constructing_Rock_Mine_Shaft, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(gg_trg_Resources_Starts_Constructing_Rock_Mine_Shaft, Condition(function Trig_Resources_Starts_Constructing_Rock_Mine_Shaft_Conditions))
    call TriggerAddAction(gg_trg_Resources_Starts_Constructing_Rock_Mine_Shaft, function Trig_Resources_Starts_Constructing_Rock_Mine_Shaft_Actions)
endfunction

//===========================================================================
// Trigger: Resources Cancel Constructing Oil Platform
//===========================================================================
function Trig_Resources_Cancel_Constructing_Oil_Platform_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetCancelledStructure()) == 'o002' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Cancel_Constructing_Oil_Platform_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1, 'u000', Player(PLAYER_NEUTRAL_PASSIVE), GetUnitLoc(GetCancelledStructure()), bj_UNIT_FACING)
endfunction

//===========================================================================
function InitTrig_Resources_Cancel_Constructing_Oil_Platform takes nothing returns nothing
    set gg_trg_Resources_Cancel_Constructing_Oil_Platform=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Cancel_Constructing_Oil_Platform, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    call TriggerAddCondition(gg_trg_Resources_Cancel_Constructing_Oil_Platform, Condition(function Trig_Resources_Cancel_Constructing_Oil_Platform_Conditions))
    call TriggerAddAction(gg_trg_Resources_Cancel_Constructing_Oil_Platform, function Trig_Resources_Cancel_Constructing_Oil_Platform_Actions)
endfunction

//===========================================================================
// Trigger: Resources Issue Order Oil Platform
//===========================================================================
function Trig_Resources_Issue_Order_Oil_Platform_Func002C takes nothing returns boolean
    if ( ( GetIssuedOrderIdBJ() == String2OrderIdBJ("smart") ) ) then
        return true
    endif
    if ( ( GetIssuedOrderIdBJ() == String2OrderIdBJ("move") ) ) then
        return true
    endif
    return false
endfunction

function Trig_Resources_Issue_Order_Oil_Platform_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'o001' ) ) then
        return false
    endif
    if ( not Trig_Resources_Issue_Order_Oil_Platform_Func002C() ) then
        return false
    endif
    if ( not ( GetOrderTargetUnit() != null ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetOrderTargetUnit()) == 'u000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Issue_Order_Oil_Platform_Actions takes nothing returns nothing
    call IssueTargetOrderById(GetTriggerUnit(), 'o002', GetOrderTargetUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Issue_Order_Oil_Platform takes nothing returns nothing
    set gg_trg_Resources_Issue_Order_Oil_Platform=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Issue_Order_Oil_Platform, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(gg_trg_Resources_Issue_Order_Oil_Platform, Condition(function Trig_Resources_Issue_Order_Oil_Platform_Conditions))
    call TriggerAddAction(gg_trg_Resources_Issue_Order_Oil_Platform, function Trig_Resources_Issue_Order_Oil_Platform_Actions)
endfunction

//===========================================================================
// Trigger: Resources Issue Order Construct Rock Mine Shaft
//===========================================================================
function Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Func005C takes nothing returns boolean
    if ( ( GetOrderTargetUnit() == null ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetOrderTargetUnit()) != 'n001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Conditions takes nothing returns boolean
    if ( not ( GetIssuedOrderIdBJ() == UnitId2OrderIdBJ('e000') ) ) then
        return false
    endif
    if ( not Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Actions takes nothing returns nothing
    local unit worker= GetTriggerUnit()
    call TriggerSleepAction(0.00)
    call IssueImmediateOrderBJ(worker, "stop")
    call SimError(GetOwningPlayer(worker) , "Target must be a Rock Mine.")
endfunction

//===========================================================================
function InitTrig_Resources_Issue_Order_Construct_Rock_Mine_Shaft takes nothing returns nothing
    set gg_trg_Resources_Issue_Order_Construct_Rock_Mine_Shaft=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Issue_Order_Construct_Rock_Mine_Shaft, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(gg_trg_Resources_Issue_Order_Construct_Rock_Mine_Shaft, Condition(function Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Conditions))
    call TriggerAddAction(gg_trg_Resources_Issue_Order_Construct_Rock_Mine_Shaft, function Trig_Resources_Issue_Order_Construct_Rock_Mine_Shaft_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Oil Platform
//===========================================================================
function Trig_Resources_Constructed_Oil_Platform_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'o002' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Oil_Platform_Actions takes nothing returns nothing
    call AddOilPlatformEx((GetTriggerUnit() ) , ( GetConstructedStructure()) , 20000) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Oil_Platform takes nothing returns nothing
    set gg_trg_Resources_Constructed_Oil_Platform=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Oil_Platform, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Oil_Platform, Condition(function Trig_Resources_Constructed_Oil_Platform_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Oil_Platform, function Trig_Resources_Constructed_Oil_Platform_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Oil Refinery
//===========================================================================
function Trig_Resources_Constructed_Oil_Refinery_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'o003' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Oil_Refinery_Actions takes nothing returns nothing
    call AddOilRefinery(GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Oil_Refinery takes nothing returns nothing
    set gg_trg_Resources_Constructed_Oil_Refinery=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Oil_Refinery, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Oil_Refinery, Condition(function Trig_Resources_Constructed_Oil_Refinery_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Oil_Refinery, function Trig_Resources_Constructed_Oil_Refinery_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Rock Mine Shaft
//===========================================================================
function Trig_Resources_Constructed_Rock_Mine_Shaft_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'e000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Rock_Mine_Shaft_Actions takes nothing returns nothing
    call AddRockMineShaft(GetTriggerUnit() , GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Rock_Mine_Shaft takes nothing returns nothing
    set gg_trg_Resources_Constructed_Rock_Mine_Shaft=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Rock_Mine_Shaft, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Rock_Mine_Shaft, Condition(function Trig_Resources_Constructed_Rock_Mine_Shaft_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Rock_Mine_Shaft, function Trig_Resources_Constructed_Rock_Mine_Shaft_Actions)
endfunction

//===========================================================================
// Trigger: Resources Death Oil Refinery
//===========================================================================
function Trig_Resources_Death_Oil_Refinery_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'o003' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Death_Oil_Refinery_Actions takes nothing returns nothing
    call RemoveOilRefinery(GetDyingUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Death_Oil_Refinery takes nothing returns nothing
    set gg_trg_Resources_Death_Oil_Refinery=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Death_Oil_Refinery, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Resources_Death_Oil_Refinery, Condition(function Trig_Resources_Death_Oil_Refinery_Conditions))
    call TriggerAddAction(gg_trg_Resources_Death_Oil_Refinery, function Trig_Resources_Death_Oil_Refinery_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Quarry
//===========================================================================
function Trig_Resources_Constructed_Quarry_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'o005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Quarry_Actions takes nothing returns nothing
    call AddQuarry(GetConstructedStructure())
    call ConstructedReturnBuilding(GetTriggerUnit() , GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Quarry takes nothing returns nothing
    set gg_trg_Resources_Constructed_Quarry=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Quarry, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Quarry, Condition(function Trig_Resources_Constructed_Quarry_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Quarry, function Trig_Resources_Constructed_Quarry_Actions)
endfunction

//===========================================================================
// Trigger: Resources Death Quarry
//===========================================================================
function Trig_Resources_Death_Quarry_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'o005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Death_Quarry_Actions takes nothing returns nothing
    call RemoveQuarry(GetDyingUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Death_Quarry takes nothing returns nothing
    set gg_trg_Resources_Death_Quarry=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Death_Quarry, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(gg_trg_Resources_Death_Quarry, Condition(function Trig_Resources_Death_Quarry_Conditions))
    call TriggerAddAction(gg_trg_Resources_Death_Quarry, function Trig_Resources_Death_Quarry_Actions)
endfunction

//===========================================================================
// Trigger: Resources Constructed Granary
//===========================================================================
function Trig_Resources_Constructed_Granary_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetConstructedStructure()) == 'o008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Constructed_Granary_Actions takes nothing returns nothing
    call AddGranary(GetConstructedStructure())
    call ConstructedReturnBuilding(GetTriggerUnit() , GetConstructedStructure())
endfunction

//===========================================================================
function InitTrig_Resources_Constructed_Granary takes nothing returns nothing
    set gg_trg_Resources_Constructed_Granary=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Constructed_Granary, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Constructed_Granary, Condition(function Trig_Resources_Constructed_Granary_Conditions))
    call TriggerAddAction(gg_trg_Resources_Constructed_Granary, function Trig_Resources_Constructed_Granary_Actions)
endfunction

//===========================================================================
// Trigger: Resources Train Oil Ship
//===========================================================================
function Trig_Resources_Train_Oil_Ship_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'o001' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Train_Oil_Ship_Actions takes nothing returns nothing
    call AddOilTanker(GetTrainedUnit())
    call ReorderWorkerToMineRally(GetTriggerUnit() , GetTrainedUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Train_Oil_Ship takes nothing returns nothing
    set gg_trg_Resources_Train_Oil_Ship=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Train_Oil_Ship, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Train_Oil_Ship, Condition(function Trig_Resources_Train_Oil_Ship_Conditions))
    call TriggerAddAction(gg_trg_Resources_Train_Oil_Ship, function Trig_Resources_Train_Oil_Ship_Actions)
endfunction

//===========================================================================
// Trigger: Resources Train Peon
//===========================================================================
function Trig_Resources_Train_Peon_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'opeo' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Train_Peon_Actions takes nothing returns nothing
    call AddPeon(GetTrainedUnit())
    call ReorderWorkerToMineRally(GetTriggerUnit() , GetTrainedUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Train_Peon takes nothing returns nothing
    set gg_trg_Resources_Train_Peon=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Train_Peon, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(gg_trg_Resources_Train_Peon, Condition(function Trig_Resources_Train_Peon_Conditions))
    call TriggerAddAction(gg_trg_Resources_Train_Peon, function Trig_Resources_Train_Peon_Actions)
endfunction

//===========================================================================
// Trigger: Resources Hire Drillbot
//===========================================================================
function Trig_Resources_Hire_Drillbot_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'n005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Hire_Drillbot_Actions takes nothing returns nothing
    call AddDrillbot(GetSoldUnit())
endfunction

//===========================================================================
function InitTrig_Resources_Hire_Drillbot takes nothing returns nothing
    set gg_trg_Resources_Hire_Drillbot=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Hire_Drillbot, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Resources_Hire_Drillbot, Condition(function Trig_Resources_Hire_Drillbot_Conditions))
    call TriggerAddAction(gg_trg_Resources_Hire_Drillbot, function Trig_Resources_Hire_Drillbot_Actions)
endfunction

//===========================================================================
// Trigger: Resources Item Wheat Bundle
//===========================================================================
function Trig_Resources_Item_Wheat_Bundle_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Resources_Item_Wheat_Bundle_Actions takes nothing returns nothing
    call CustomBounty(GetTriggerUnit() , Wheat , 200)
endfunction

//===========================================================================
function InitTrig_Resources_Item_Wheat_Bundle takes nothing returns nothing
    set gg_trg_Resources_Item_Wheat_Bundle=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Item_Wheat_Bundle, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(gg_trg_Resources_Item_Wheat_Bundle, Condition(function Trig_Resources_Item_Wheat_Bundle_Conditions))
    call TriggerAddAction(gg_trg_Resources_Item_Wheat_Bundle, function Trig_Resources_Item_Wheat_Bundle_Actions)
endfunction

//===========================================================================
// Trigger: Resources Taxes Wheat
//===========================================================================
function Trig_Resources_Taxes_Wheat_Actions takes nothing returns nothing
    call UpdatePlayerTaxes(GetOwningPlayer(GetTriggerUnit()))
endfunction

//===========================================================================
function InitTrig_Resources_Taxes_Wheat takes nothing returns nothing
    set gg_trg_Resources_Taxes_Wheat=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_UNIT_TRAIN_START)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Resources_Taxes_Wheat, EVENT_PLAYER_HERO_REVIVE_CANCEL)
    call TriggerRegisterEnterRectSimple(gg_trg_Resources_Taxes_Wheat, GetEntireMapRect())
    call TriggerAddAction(gg_trg_Resources_Taxes_Wheat, function Trig_Resources_Taxes_Wheat_Actions)
endfunction

//===========================================================================
// Trigger: Buy 100 Oil
//===========================================================================
function Trig_Buy_100_Oil_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Buy_100_Oil_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call AddPlayerResource((GetOwningPlayer(GetBuyingUnit())) , Oil , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Buy_100_Oil takes nothing returns nothing
    set gg_trg_Buy_100_Oil=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Buy_100_Oil, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Buy_100_Oil, Condition(function Trig_Buy_100_Oil_Conditions))
    call TriggerAddAction(gg_trg_Buy_100_Oil, function Trig_Buy_100_Oil_Actions)
endfunction

//===========================================================================
// Trigger: Sell 100 Oil
//===========================================================================
function Trig_Sell_100_Oil_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h001' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sell_100_Oil_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call ExchangePlayerResource((GetOwningPlayer(GetBuyingUnit())) , Oil , Resources_GOLD , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Sell_100_Oil takes nothing returns nothing
    set gg_trg_Sell_100_Oil=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sell_100_Oil, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Sell_100_Oil, Condition(function Trig_Sell_100_Oil_Conditions))
    call TriggerAddAction(gg_trg_Sell_100_Oil, function Trig_Sell_100_Oil_Actions)
endfunction

//===========================================================================
// Trigger: Buy 100 Rock
//===========================================================================
function Trig_Buy_100_Rock_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Buy_100_Rock_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call AddPlayerResource((GetOwningPlayer(GetBuyingUnit())) , Rock , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Buy_100_Rock takes nothing returns nothing
    set gg_trg_Buy_100_Rock=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Buy_100_Rock, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Buy_100_Rock, Condition(function Trig_Buy_100_Rock_Conditions))
    call TriggerAddAction(gg_trg_Buy_100_Rock, function Trig_Buy_100_Rock_Actions)
endfunction

//===========================================================================
// Trigger: Sell 100 Rock
//===========================================================================
function Trig_Sell_100_Rock_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h002' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sell_100_Rock_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call ExchangePlayerResource((GetOwningPlayer(GetBuyingUnit())) , Rock , Resources_GOLD , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Sell_100_Rock takes nothing returns nothing
    set gg_trg_Sell_100_Rock=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sell_100_Rock, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Sell_100_Rock, Condition(function Trig_Sell_100_Rock_Conditions))
    call TriggerAddAction(gg_trg_Sell_100_Rock, function Trig_Sell_100_Rock_Actions)
endfunction

//===========================================================================
// Trigger: Buy 100 Wheat
//===========================================================================
function Trig_Buy_100_Wheat_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Buy_100_Wheat_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call AddPlayerResource((GetOwningPlayer(GetBuyingUnit())) , Wheat , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Buy_100_Wheat takes nothing returns nothing
    set gg_trg_Buy_100_Wheat=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Buy_100_Wheat, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Buy_100_Wheat, Condition(function Trig_Buy_100_Wheat_Conditions))
    call TriggerAddAction(gg_trg_Buy_100_Wheat, function Trig_Buy_100_Wheat_Actions)
endfunction

//===========================================================================
// Trigger: Sell 100 Wheat
//===========================================================================
function Trig_Sell_100_Wheat_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h003' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sell_100_Wheat_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call ExchangePlayerResource((GetOwningPlayer(GetBuyingUnit())) , Wheat , Resources_GOLD , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Sell_100_Wheat takes nothing returns nothing
    set gg_trg_Sell_100_Wheat=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sell_100_Wheat, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Sell_100_Wheat, Condition(function Trig_Sell_100_Wheat_Conditions))
    call TriggerAddAction(gg_trg_Sell_100_Wheat, function Trig_Sell_100_Wheat_Actions)
endfunction

//===========================================================================
// Trigger: Buy 100 Ore
//===========================================================================
function Trig_Buy_100_Ore_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h006' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Buy_100_Ore_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call AddPlayerResource((GetOwningPlayer(GetBuyingUnit())) , Ore , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Buy_100_Ore takes nothing returns nothing
    set gg_trg_Buy_100_Ore=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Buy_100_Ore, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Buy_100_Ore, Condition(function Trig_Buy_100_Ore_Conditions))
    call TriggerAddAction(gg_trg_Buy_100_Ore, function Trig_Buy_100_Ore_Actions)
endfunction

//===========================================================================
// Trigger: Sell 100 Ore
//===========================================================================
function Trig_Sell_100_Ore_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSoldUnit()) == 'h007' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sell_100_Ore_Actions takes nothing returns nothing
    call h__RemoveUnit(GetSoldUnit())
    call ExchangePlayerResource((GetOwningPlayer(GetBuyingUnit())) , Ore , Resources_GOLD , 100) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Sell_100_Ore takes nothing returns nothing
    set gg_trg_Sell_100_Ore=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Sell_100_Ore, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(gg_trg_Sell_100_Ore, Condition(function Trig_Sell_100_Ore_Conditions))
    call TriggerAddAction(gg_trg_Sell_100_Ore, function Trig_Sell_100_Ore_Actions)
endfunction

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Melee Initialization
//
// Default melee game initialization for all players
//===========================================================================
function Trig_Melee_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call MeleeGrantHeroItems()
    call MeleeStartingResources()
    call MeleeClearExcessUnits()
    call MeleeStartingAI()
endfunction

//===========================================================================
function InitTrig_Melee_Initialization takes nothing returns nothing
    set gg_trg_Melee_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Melee_Initialization, function Trig_Melee_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func005A takes nothing returns nothing
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call AdjustPlayerStateBJ(100000000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD)
    call AdjustPlayerStateBJ(100000000, GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER)
    call SetPlayerIgnoredForTeamResourceMultiboard(Player(2) , GetEnumPlayer() , true)
    call AddStartResources(GetEnumPlayer())
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call SetForceAllianceStateBJ(bj_FORCE_PLAYER[2], GetPlayersAll(), bj_ALLIANCE_ALLIED_ADVUNITS)
    call SetForceAllianceStateBJ(GetPlayersAll(), bj_FORCE_PLAYER[2], bj_ALLIANCE_ALLIED_ADVUNITS)
    call SetPlayerColorBJ(Player(2), ConvertPlayerColor(24), true)
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func005A)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_168")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_169")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_170")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_171")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_172")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_173")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_174")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_176")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_177")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_178")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_175")
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Cheat Resources
//===========================================================================
function Trig_Cheat_Resources_Actions takes nothing returns nothing
    call CheatResources(GetTriggerPlayer())
endfunction

//===========================================================================
function InitTrig_Cheat_Resources takes nothing returns nothing
    set gg_trg_Cheat_Resources=CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Cheat_Resources, Player(0))
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Cheat_Resources, Player(1))
    call TriggerAddAction(gg_trg_Cheat_Resources, function Trig_Cheat_Resources_Actions)
endfunction

//===========================================================================
// Trigger: Normal Buildings
//===========================================================================
function Trig_Normal_Buildings_Func005C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetTriggerUnit()) == 'o007' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetTriggerUnit()) == 'o006' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Normal_Buildings_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A002' ) ) then
        return false
    endif
    if ( not Trig_Normal_Buildings_Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_Normal_Buildings_Actions takes nothing returns nothing
    call UnitRemoveAbilityBJ('S001', GetTriggerUnit())
    call UnitAddAbilityBJ('S000', GetTriggerUnit())
    call ForceUIBuildings(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Normal_Buildings takes nothing returns nothing
    set gg_trg_Normal_Buildings=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Normal_Buildings, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Normal_Buildings, Condition(function Trig_Normal_Buildings_Conditions))
    call TriggerAddAction(gg_trg_Normal_Buildings, function Trig_Normal_Buildings_Actions)
endfunction

//===========================================================================
// Trigger: Advanced Buildings
//===========================================================================
function Trig_Advanced_Buildings_Func005C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetTriggerUnit()) == 'o007' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetTriggerUnit()) == 'o006' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Advanced_Buildings_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A007' ) ) then
        return false
    endif
    if ( not Trig_Advanced_Buildings_Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_Advanced_Buildings_Actions takes nothing returns nothing
    call UnitRemoveAbilityBJ('S000', GetTriggerUnit())
    call UnitAddAbilityBJ('S001', GetTriggerUnit())
    call ForceUIBuildings(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Advanced_Buildings takes nothing returns nothing
    set gg_trg_Advanced_Buildings=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Advanced_Buildings, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Advanced_Buildings, Condition(function Trig_Advanced_Buildings_Conditions))
    call TriggerAddAction(gg_trg_Advanced_Buildings, function Trig_Advanced_Buildings_Actions)
endfunction

//===========================================================================
// Trigger: Normal Buildings Oil Tanker
//===========================================================================
function Trig_Normal_Buildings_Oil_Tanker_Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetTriggerUnit()) == 'o001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Normal_Buildings_Oil_Tanker_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A002' ) ) then
        return false
    endif
    if ( not Trig_Normal_Buildings_Oil_Tanker_Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Normal_Buildings_Oil_Tanker_Actions takes nothing returns nothing
    call ForceUIBuildings(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_Normal_Buildings_Oil_Tanker takes nothing returns nothing
    set gg_trg_Normal_Buildings_Oil_Tanker=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Normal_Buildings_Oil_Tanker, EVENT_PLAYER_UNIT_SPELL_FINISH)
    call TriggerAddCondition(gg_trg_Normal_Buildings_Oil_Tanker, Condition(function Trig_Normal_Buildings_Oil_Tanker_Conditions))
    call TriggerAddAction(gg_trg_Normal_Buildings_Oil_Tanker, function Trig_Normal_Buildings_Oil_Tanker_Actions)
endfunction

//===========================================================================
// Trigger: Blue Start
//===========================================================================
function Trig_Blue_Start_Func013Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'o001' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blue_Start_Func013Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'o000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blue_Start_Func013Func003C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'o002' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blue_Start_Func013A takes nothing returns nothing
    if ( Trig_Blue_Start_Func013Func001C() ) then
        call RemoveGuardPosition(GetEnumUnit())
        call IssueTargetOrderBJ(GetEnumUnit(), "harvest", gg_unit_o002_0010)
    else
        call DoNothing()
    endif
    if ( Trig_Blue_Start_Func013Func002C() ) then
        call RemoveGuardPosition(GetEnumUnit())
    else
        call DoNothing()
    endif
    if ( Trig_Blue_Start_Func013Func003C() ) then
        call RemoveGuardPosition(GetEnumUnit())
    else
        call DoNothing()
    endif
endfunction

function Trig_Blue_Start_Actions takes nothing returns nothing
    call RemoveGuardPosition(gg_unit_opeo_0044)
    call RemoveGuardPosition(gg_unit_opeo_0045)
    call RemoveGuardPosition(gg_unit_opeo_0046)
    call IssueTargetOrderBJ(gg_unit_opeo_0044, "heal", gg_unit_n001_0005)
    call IssueTargetOrderBJ(gg_unit_opeo_0045, "heal", gg_unit_n001_0005)
    call IssueTargetOrderBJ(gg_unit_opeo_0046, "heal", gg_unit_n001_0005)
    call RemoveGuardPosition(gg_unit_opeo_0052)
    call RemoveGuardPosition(gg_unit_opeo_0053)
    call RemoveGuardPosition(gg_unit_opeo_0054)
    call IssueTargetOrderBJ(gg_unit_opeo_0052, "heal", gg_unit_n000_0050)
    call IssueTargetOrderBJ(gg_unit_opeo_0053, "heal", gg_unit_n000_0050)
    call IssueTargetOrderBJ(gg_unit_opeo_0054, "heal", gg_unit_n000_0050)
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(1)), function Trig_Blue_Start_Func013A)
endfunction

//===========================================================================
function InitTrig_Blue_Start takes nothing returns nothing
    set gg_trg_Blue_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Blue_Start, 1.00)
    call TriggerAddAction(gg_trg_Blue_Start, function Trig_Blue_Start_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_UnitDex()
    //Function not found: call InitTrig_WorldBounds()
    //Function not found: call InitTrig_RegisterPlayerUnitEvent_Magtheridon96()
    //Function not found: call InitTrig_RegisterNativeEvent()
    //Function not found: call InitTrig_UnitEventEx()
    call InitTrig_Resources_Init()
    call InitTrig_Resources_Start()
    call InitTrig_Resources_Constructed_Town_Hall()
    call InitTrig_Resources_Constructed_Shipyard()
    call InitTrig_Resources_Starts_Constructing_Oil_Platform()
    call InitTrig_Resources_Starts_Constructing_Rock_Mine_Shaft()
    call InitTrig_Resources_Cancel_Constructing_Oil_Platform()
    call InitTrig_Resources_Issue_Order_Oil_Platform()
    call InitTrig_Resources_Issue_Order_Construct_Rock_Mine_Shaft()
    call InitTrig_Resources_Constructed_Oil_Platform()
    call InitTrig_Resources_Constructed_Oil_Refinery()
    call InitTrig_Resources_Constructed_Rock_Mine_Shaft()
    call InitTrig_Resources_Death_Oil_Refinery()
    call InitTrig_Resources_Constructed_Quarry()
    call InitTrig_Resources_Death_Quarry()
    call InitTrig_Resources_Constructed_Granary()
    call InitTrig_Resources_Train_Oil_Ship()
    call InitTrig_Resources_Train_Peon()
    call InitTrig_Resources_Hire_Drillbot()
    call InitTrig_Resources_Item_Wheat_Bundle()
    call InitTrig_Resources_Taxes_Wheat()
    call InitTrig_Buy_100_Oil()
    call InitTrig_Sell_100_Oil()
    call InitTrig_Buy_100_Rock()
    call InitTrig_Sell_100_Rock()
    call InitTrig_Buy_100_Wheat()
    call InitTrig_Sell_100_Wheat()
    call InitTrig_Buy_100_Ore()
    call InitTrig_Sell_100_Ore()
    call InitTrig_Initialization()
    call InitTrig_Melee_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Cheat_Resources()
    call InitTrig_Normal_Buildings()
    call InitTrig_Advanced_Buildings()
    call InitTrig_Normal_Buildings_Oil_Tanker()
    call InitTrig_Blue_Start()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Resources_Init)
    call ConditionalTriggerExecute(gg_trg_Initialization)
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
    call SetPlayerRacePreference(Player(0), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_COMPUTER)

    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_COMPUTER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_006
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)

    //   Shared Control
    call SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(1), true)

    //   Shared Advanced Control
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(1), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(2, 2)
    call SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(2, 1)
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
    call InitSounds()
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs245401250")
call ExecuteFunc("FrameLoader___init_function")
call ExecuteFunc("OnStartGame___Init")
call ExecuteFunc("SimError___init")
call ExecuteFunc("PlayerColorUtils___Init")
call ExecuteFunc("Resources___Init")
call ExecuteFunc("ResourcesChatCommands___Init")
call ExecuteFunc("ResourcesCosts___Init")
call ExecuteFunc("ResourcesGui___Init")
call ExecuteFunc("ResourcesLoadedMines___Init")
call ExecuteFunc("ResourcesTeamMultiboardGui___Init")
call ExecuteFunc("ResourcesWarnings___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call RunInitializationTriggers()

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_001")
    call SetMapDescription("TRIGSTR_003")
    call SetPlayers(3)
    call SetTeams(3)
    call SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)

    call DefineStartLocation(0, - 1920.0, - 320.0)
    call DefineStartLocation(1, 1472.0, - 384.0)
    call DefineStartLocation(2, 2624.0, 256.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer takes nothing returns boolean

        set UnitEventEx___rezCheck=false
        call DestroyTimer(GetExpiredTimer())
   return true
endfunction
function sa___prototype51_Resources___RemoveUnitHook takes nothing returns boolean
    call Resources___RemoveUnitHook(f__arg_unit1)
    return true
endfunction
function sa___prototype51_ResourcesGui___RemoveUnitHook takes nothing returns boolean
    call ResourcesGui___RemoveUnitHook(f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs245401250 takes nothing returns nothing
    set st__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer=CreateTrigger()
    call TriggerAddCondition(st__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer,Condition( function sa__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___resurrectionTimer))
    set st___prototype51[1]=CreateTrigger()
    call TriggerAddAction(st___prototype51[1],function sa___prototype51_Resources___RemoveUnitHook)
    call TriggerAddCondition(st___prototype51[1],Condition(function sa___prototype51_Resources___RemoveUnitHook))
    set st___prototype51[2]=CreateTrigger()
    call TriggerAddAction(st___prototype51[2],function sa___prototype51_ResourcesGui___RemoveUnitHook)
    call TriggerAddCondition(st___prototype51[2],Condition(function sa___prototype51_ResourcesGui___RemoveUnitHook))

call ExecuteFunc("s__RegisterNativeEvent___NativeEvent_RegisterNativeEvent___NativeEventInit___onInit")

call ExecuteFunc("s__WorldBounds_WorldBounds___WorldBoundInit___onInit")


call ExecuteFunc("s__UnitDex_UnitDex___UnitDexCore___onInit")






call ExecuteFunc("s__UnitEventEx___UnitEventEx_UnitEventEx___UnitEventExCore___onInit")

endfunction

