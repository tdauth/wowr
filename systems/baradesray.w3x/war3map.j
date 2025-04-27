globals
//globals from MathUtils:
constant boolean LIBRARY_MathUtils=true
//endglobals from MathUtils
//globals from MouseUtils:
constant boolean LIBRARY_MouseUtils=true
constant integer EVENT_MOUSE_UP= 0x400
constant integer EVENT_MOUSE_DOWN= 0x800
constant integer EVENT_MOUSE_MOVE= 0xC00
    //  Introduced in v1.0.2.3
    //  Commented out in v1.0.2.4
    // private constant real STARTUP_DELAY = 0.00
    // private constant boolean NO_DELAY   = false
    //  Introduced in v1.0.2.2
constant boolean MouseUtils___IMPL_LOCK= true
//endglobals from MouseUtils
//globals from TreeUtils:
constant boolean LIBRARY_TreeUtils=true
constant integer TreeUtils_SUMMER_TREE_WALL= 'LTlt'
constant integer TreeUtils_ASHENVALE_TREE_WALL= 'ATtr'
constant integer TreeUtils_ASHENVALE_CANOPY_TREE= 'ATtc'
constant integer TreeUtils_BARRENS_TREE_WALL= 'BTtw'
constant integer TreeUtils_BARRENS_CANOPY_TREE= 'BTtc'
constant integer TreeUtils_BLACK_CITADEL_TREE_WALL= 'KTtw'
constant integer TreeUtils_CITYSCAPE_SNOWY_TREE_WALL= 'YTst'
constant integer TreeUtils_CITYSCAPE_FALL_TREE_WALL= 'YTft'
constant integer TreeUtils_CITYSCAPE_WINTER_TREE_WALL= 'YTwt'
constant integer TreeUtils_CITYSCAPE_SUMMER_TREE_WALL= 'YTct'
constant integer TreeUtils_DALARAN_RUINS_TREE_WALL= 'JTtw'
constant integer TreeUtils_DUNGEON_TREE_WALL= 'DTsh'
constant integer TreeUtils_FELWOOD_TREE_WALL= 'CTtr'
constant integer TreeUtils_FELWOOD_CANOPY_TREE= 'CTtc'
constant integer TreeUtils_ICECROWN_TREE_WALL= 'ITtw'
constant integer TreeUtils_ICECROWN_CANOPY_TREE= 'ITtc'
constant integer TreeUtils_WINTER_TREE_WALL= 'WTtw'
constant integer TreeUtils_NORTHREND_TREE_WALL= 'NTtw'
constant integer TreeUtils_SNOWY_TREE_WALL= 'WTst'
constant integer TreeUtils_OUTLAND_TREE_WALL= 'OTtw'
constant integer TreeUtils_RUINS_TREE_WALL= 'ZTtw'
constant integer TreeUtils_RUINS_CANOPY_TREE= 'ZTtc'
constant integer TreeUtils_UNDERGROUND_TREE_WALL= 'GTsh'
constant integer TreeUtils_VILLAGE_TREE_WALL= 'VTlt'
constant integer TreeUtils_FALL_TREE_WALL= 'FTtw'
constant integer TreeUtils_SCORCHED_TREE_WALL= 'Ytsc'
constant integer TreeUtils_SILVERMOON_TREE= 'Yts1'
integer array TreeUtils___ids
integer TreeUtils___count= 0
//endglobals from TreeUtils
//globals from RayConfig:
constant boolean LIBRARY_RayConfig=true
constant real RayConfig_REFRESH_INTERVAL= 0.02
constant real RayConfig_HARVEST_INTERVAL= 0.5
constant real RayConfig_HOLD_KEY_DURATION= 0.6
    
constant integer RayConfig_FROST_RAY= 'A000'
constant integer RayConfig_FIRE_RAY= 'A001'
constant integer RayConfig_HOLY_RAY= 'A002'
constant integer RayConfig_HARVEST_RAY= 'A003'
constant integer RayConfig_LOOT_RAY= 'A004'
constant integer RayConfig_WATER_RAY= 'A005'
constant integer RayConfig_DRAIN_RAY= 'A006'
constant integer RayConfig_FROST_AND_FIRE_RAY= 'A007'
constant integer RayConfig_CHAIN_RAY= 'A008'
constant integer RayConfig_MANA_RAY= 'A009'
constant integer RayConfig_RAISE_RAY= 'A00A'
constant integer RayConfig_POISON_RAY= 'A00C'
constant integer RayConfig_WIND_RAY= 'A00E'
constant integer RayConfig_RESURRECTION_RAY= 'A00D'
constant integer RayConfig_HEX_RAY= 'A00J'
constant integer RayConfig_CHARM_RAY= 'A00K'
constant integer RayConfig_NEUTRALIZATION_RAY= 'A00N'
constant integer RayConfig_RESURRECT_DUMMY= 'h000'
constant integer RayConfig_FROST_DUMMY= 'h001'
constant integer RayConfig_FIRE_DUMMY= 'h002'
constant integer RayConfig_WIND_DUMMY= 'h003'
constant integer RayConfig_POISON_DUMMY= 'h005'
constant integer RayConfig_CHARM_DUMMY= 'h006'
constant integer RayConfig_HEX_DUMMY= 'h007'
constant integer RayConfig_FROST_DUMMY_ABILITY_ID= 'A00G'
constant integer RayConfig_FIRE_DUMMY_ABILITY_ID= 'A00B'
constant integer RayConfig_WIND_DUMMY_ABILITY_ID= 'A00I'
constant integer RayConfig_POISON_DUMMY_ABILITY_ID= 'A00H'
constant integer RayConfig_CHARM_DUMMY_ABILITY_ID= 'A00L'
constant integer RayConfig_HEX_DUMMY_ABILITY_ID= 'A00M'
constant integer RayConfig_BUFF_ID_FROST= 'B000'
constant integer RayConfig_BUFF_ID_FIRE= 'Bliq'
constant integer RayConfig_BUFF_ID_WIND= 'Bcyc'
constant integer RayConfig_BUFF_ID_POISON= 'Bpoi'
hashtable RayConfig___h= InitHashtable()
    
constant real RayConfig_MANA_COST_PER_SECOND= 10.0
//endglobals from RayConfig
//globals from Ray:
constant boolean LIBRARY_Ray=true
constant real Ray_STEP_DISTANCE= 100.0
constant real Ray_STEP_DISTANCE_HALF= Ray_STEP_DISTANCE / 2.0
constant real Ray_Z_THRESHOLD= 32.0
constant boolean Ray_ALLOW_DISABLING= true
constant boolean Ray_LOCK_TARGET= false
constant boolean Ray_DETECT_UNIT_COLLISION= true
constant integer Ray_MAX_LIGHTNINGS= 5
constant integer Ray_ORDER_ID_STOP= 851972
constant integer Ray_ORDER_ID_SMART= 851971
constant integer Ray_ORDER_ID_MOVE= 851986
integer Ray___filterTarget= 0
real Ray___filterClosestDistance= 0.0
unit Ray___filterClosestUnit= null
destructable Ray___filterClosestDestructable= null
item Ray___filterClosestItem= null
hashtable Ray___h= InitHashtable()
trigger Ray___castTrigger= CreateTrigger()
trigger Ray___deathTrigger= CreateTrigger()
trigger Ray___orderTrigger= CreateTrigger()
trigger Ray___attackTrigger= CreateTrigger()
group Ray___casters= CreateGroup()
timer Ray___refreshTimer= CreateTimer()
filterfunc Ray___filterIsClosestUnit= null
filterfunc Ray___filterIsClosestDestructable= null
filterfunc Ray___filterIsClosestItem= null
trigger Ray___refreshTrigger= CreateTrigger()
//endglobals from Ray
    // Generated
sound gg_snd_BlueFireBurstLoop= null
sound gg_snd_BreathOfFrost1= null
sound gg_snd_HealTarget= null
sound gg_snd_HolyBolt= null
sound gg_snd_ImmolationTarget1= null
sound gg_snd_LifeDrain= null
sound gg_snd_MagicLariatLoop1= null
sound gg_snd_MagicWallLoop1= null
sound gg_snd_MonsoonRainLoop= null
sound gg_snd_RainOfFireLoop1= null
sound gg_snd_ShimmeringPortalLoop= null
sound gg_snd_WaterWaterFallLoop1= null
sound gg_snd_FreezingBreathTarget1= null
sound gg_snd_Incinerate1= null
sound gg_snd_Tranquility= null
sound gg_snd_CycloneLoop1= null
sound gg_snd_RaiseSkeleton= null
sound gg_snd_MineDomeLoop1= null
sound gg_snd_CharmTarget1= null
trigger gg_trg_Initialization= null
trigger gg_trg_Start= null
trigger gg_trg_Revive_Player_1= null
trigger gg_trg_Revive_Player_2= null
trigger gg_trg_Barrel_Explodes= null
unit gg_unit_Hblm_0000= null
unit gg_unit_Hblm_0001= null
unit gg_unit_ntav_0036= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__UserMouse=1
constant real s__UserMouse_INTERVAL= 0.031250000
constant integer s__UserMouse_MOUSE_COUNT_MAX= 16
constant integer s__UserMouse_MOUSE_COUNT_LOSS= 8
constant boolean s__UserMouse_IS_INSTANT= ( s__UserMouse_INTERVAL <= 0. )
integer s__UserMouse_currentEventType= 0
integer s__UserMouse_updateCount= 0
trigger s__UserMouse_stateDetector= null
timer s__UserMouse_resetTimer= null
integer array s__UserMouse_mouseEventCount
timer array s__UserMouse_mouseEventReductor
trigger array s__UserMouse_evTrigger
integer array s__UserMouse_mouseButtonStack
integer array s__UserMouse_next
integer array s__UserMouse_prev
integer array s__UserMouse_resetNext
integer array s__UserMouse_resetPrev
trigger array s__UserMouse_posDetector
integer array s__UserMouse_mouseClickCount
real array s__UserMouse_mouseX
real array s__UserMouse_mouseY
constant integer si__Ray___T=2
integer si__Ray___T_F=0
integer si__Ray___T_I=0
integer array si__Ray___T_V
unit array s__Ray___T_caster
integer array s__Ray___T_abilityId
sound array s__Ray___T_loopSound
sound array s__Ray___T_hitSound
real array s__Ray___T_x
real array s__Ray___T_y
real array s__Ray___T_z
real array s__Ray___T_distance
real array s__Ray___T_range
unit array s__Ray___T_u
destructable array s__Ray___T_d
item array s__Ray___T_i
timer array s__Ray___T_t
lightning array s___Ray___T_l
constant integer s___Ray___T_l_size=5
integer array s__Ray___T_l
integer array s__Ray___T_maxLightnings
real array s__Ray___T_maxDistance
real array s__Ray___T_duration
effect array s__Ray___T_casterEffect
effect array s__Ray___T_targetEffect
boolean array s__Ray___T_disableAttack
boolean array s__Ray___T_disableMovement
boolean array s__Ray___T_mouseAiming
trigger array st___prototype17
unit f__arg_unit1

endglobals


//Generated allocator of Ray___T
function s__Ray___T__allocate takes nothing returns integer
 local integer this=si__Ray___T_F
    if (this!=0) then
        set si__Ray___T_F=si__Ray___T_V[this]
    else
        set si__Ray___T_I=si__Ray___T_I+1
        set this=si__Ray___T_I
    endif
    if (this>1637) then
        return 0
    endif
    set s__Ray___T_l[this]=(this-1)*5
   set s__Ray___T_duration[this]= 0.0
    set si__Ray___T_V[this]=-1
 return this
endfunction

//Generated destructor of Ray___T
function s__Ray___T_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__Ray___T_V[this]!=-1) then
        return
    endif
    set si__Ray___T_V[this]=si__Ray___T_F
    set si__Ray___T_F=this
endfunction
function sc___prototype17_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype17[i])
endfunction
function sc___prototype17_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype17[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: RayConfig___RemoveUnitHook
    call sc___prototype17_evaluate(1,a0)
    //hook: Ray___RemoveUnitHook
    call sc___prototype17_evaluate(2,a0)
call RemoveUnit(a0)
endfunction

//library MathUtils:

function PolarProjectionX takes real x,real angle,real distance returns real
    return x + distance * Cos(angle * bj_DEGTORAD)
endfunction

function PolarProjectionY takes real y,real angle,real distance returns real
    return y + distance * Sin(angle * bj_DEGTORAD)
endfunction

function DistanceBetweenCoordinates takes real x1,real y1,real x2,real y2 returns real
    local real dx= x2 - x1
    local real dy= y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction

function AngleBetweenCoordinatesDeg takes real x1,real y1,real x2,real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction

function GetRectFromCircle takes real centerX,real centerY,real radius returns rect
    return Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
endfunction


//library MathUtils ends
//library MouseUtils:

//  Arbitrary constants

        //  Determines the minimum interval that a mouse move event detector
        //  will be deactivated. (Globally-based)
        //  You can configure it to any amount you like.
        
        //  Determines how many times a mouse move event detector can fire
        //  before being deactivated. (locally-based)
        //  You can configure this to any integer value. (Preferably positive)
        
        // Determines the amount to be deducted from mouseEventCount
        // per INTERVAL. Runs independently of resetTimer



 
    
    
    
    //  Converts the enum type mousebuttontype into an integer
    function s__UserMouse_toIndex takes mousebuttontype mouseButton returns integer
        return GetHandleId(mouseButton)
    endfunction
    
    function s__UserMouse_getCurEventType takes nothing returns integer
        return s__UserMouse_currentEventType
    endfunction
    
    function s__UserMouse__staticgetindex takes player p returns integer
        if s__UserMouse_posDetector[(GetPlayerId(p) + 1)] != null then
            return GetPlayerId(p) + 1
        endif
        return 0
    endfunction
        
    function s__UserMouse__get_player takes integer this returns player
        return Player(this - 1)
    endfunction
    function s__UserMouse__get_isMouseClicked takes integer this returns boolean
        return s__UserMouse_mouseClickCount[this] > 0
    endfunction
    function s__UserMouse_isMouseButtonClicked takes integer this,mousebuttontype mouseButton returns boolean
        return s__UserMouse_mouseButtonStack[( this - 1 ) * 3 + (GetHandleId((mouseButton)))] > 0 // INLINED!!
    endfunction
    function s__UserMouse_setMousePos takes integer this,integer x,integer y returns nothing
        if GetLocalPlayer() == (Player((this) - 1)) then // INLINED!!
            call BlzSetMousePos(x, y)
        endif
    endfunction

    function s__UserMouse_getMouseEventReductor takes timer t returns integer
        local integer this= s__UserMouse_next[(0)]
        loop
        exitwhen s__UserMouse_mouseEventReductor[this] == t or this == 0
            set this=s__UserMouse_next[this]
        endloop
        return this
    endfunction
    function s__UserMouse_onMouseUpdateListener takes nothing returns nothing
        local integer this= s__UserMouse_resetNext[(0)]
        set s__UserMouse_updateCount=0
        
        loop
            exitwhen this == 0
            set s__UserMouse_updateCount=s__UserMouse_updateCount + 1
                        
            set s__UserMouse_mouseEventCount[this]=0
            call EnableTrigger(s__UserMouse_posDetector[this])
            
            set s__UserMouse_resetPrev[s__UserMouse_resetNext[this]]=s__UserMouse_resetPrev[this]
            set s__UserMouse_resetNext[s__UserMouse_resetPrev[this]]=s__UserMouse_resetNext[this]
            
            set this=s__UserMouse_resetNext[this]
        endloop
        if s__UserMouse_updateCount > 0 then

                call TimerStart(s__UserMouse_resetTimer, s__UserMouse_INTERVAL, false, function s__UserMouse_onMouseUpdateListener)



        else

                call TimerStart(s__UserMouse_resetTimer, 0.00, false, null)
                call PauseTimer(s__UserMouse_resetTimer)

        endif
    endfunction
    function s__UserMouse_onMouseReductListener takes nothing returns nothing
        local integer this= s__UserMouse_getMouseEventReductor(GetExpiredTimer())
        if s__UserMouse_mouseEventCount[this] <= 0 then
            call PauseTimer(s__UserMouse_mouseEventReductor[this])
        else
            set s__UserMouse_mouseEventCount[this]=IMaxBJ(s__UserMouse_mouseEventCount[this] - s__UserMouse_MOUSE_COUNT_LOSS, 0)
            call TimerStart(s__UserMouse_mouseEventReductor[this], s__UserMouse_INTERVAL, false, function s__UserMouse_onMouseReductListener)
        endif
    endfunction

    function s__UserMouse_onMouseUpOrDown takes nothing returns nothing
        local integer this= s__UserMouse__staticgetindex(GetTriggerPlayer())
        local integer index= ( this - 1 ) * 3 + (GetHandleId((BlzGetTriggerPlayerMouseButton()))) // INLINED!!
        local boolean releaseFlag= false
        
        if GetTriggerEventId() == EVENT_PLAYER_MOUSE_DOWN then
            set s__UserMouse_mouseClickCount[this]=IMinBJ(s__UserMouse_mouseClickCount[this] + 1, 3)
            set releaseFlag=s__UserMouse_mouseButtonStack[index] <= 0
            set s__UserMouse_mouseButtonStack[index]=IMinBJ(s__UserMouse_mouseButtonStack[index] + 1, 1)
           
            if releaseFlag then
                set s__UserMouse_currentEventType=EVENT_MOUSE_DOWN
                call TriggerEvaluate(s__UserMouse_evTrigger[EVENT_MOUSE_DOWN])
            endif
        else
            set s__UserMouse_mouseClickCount[this]=IMaxBJ(s__UserMouse_mouseClickCount[this] - 1, 0)
            set releaseFlag=s__UserMouse_mouseButtonStack[index] > 0
            set s__UserMouse_mouseButtonStack[index]=IMaxBJ(s__UserMouse_mouseButtonStack[index] - 1, 0)
            
            if releaseFlag then
                set s__UserMouse_currentEventType=EVENT_MOUSE_UP
                call TriggerEvaluate(s__UserMouse_evTrigger[EVENT_MOUSE_UP])
            endif
        endif
    endfunction
    
    function s__UserMouse_onMouseMove takes nothing returns nothing
        local integer this= s__UserMouse__staticgetindex(GetTriggerPlayer())
        local boolean started= false
        set s__UserMouse_mouseX[this]=BlzGetTriggerPlayerMouseX()
        set s__UserMouse_mouseY[this]=BlzGetTriggerPlayerMouseY()

            set s__UserMouse_mouseEventCount[this]=s__UserMouse_mouseEventCount[this] + 1
            if s__UserMouse_mouseEventCount[this] <= 1 then
                call TimerStart(s__UserMouse_mouseEventReductor[this], s__UserMouse_INTERVAL, false, function s__UserMouse_onMouseReductListener)
            endif

        set s__UserMouse_currentEventType=EVENT_MOUSE_MOVE
        call TriggerEvaluate(s__UserMouse_evTrigger[EVENT_MOUSE_MOVE])

            if s__UserMouse_mouseEventCount[this] >= s__UserMouse_MOUSE_COUNT_MAX then
                call DisableTrigger(s__UserMouse_posDetector[this])
                if s__UserMouse_resetNext[(0)] == 0 then

                        call TimerStart(s__UserMouse_resetTimer, s__UserMouse_INTERVAL, false, function s__UserMouse_onMouseUpdateListener)
                    // Mouse event reductor should be paused



                    call PauseTimer(s__UserMouse_mouseEventReductor[this])
                endif
                set s__UserMouse_resetNext[this]=0
                set s__UserMouse_resetPrev[this]=s__UserMouse_resetPrev[s__UserMouse_resetNext[this]]
                set s__UserMouse_resetNext[s__UserMouse_resetPrev[this]]=this
                set s__UserMouse_resetPrev[s__UserMouse_resetNext[this]]=this
                if started then
                    call s__UserMouse_onMouseUpdateListener()
                endif
            endif

    endfunction
        
    function s__UserMouse_initCallback takes nothing returns nothing
        local integer this= 1
        local player p= (Player((this) - 1)) // INLINED!!
  

            set s__UserMouse_resetTimer=CreateTimer()

        set s__UserMouse_stateDetector=CreateTrigger()
        call TriggerAddCondition(s__UserMouse_stateDetector, Condition(function s__UserMouse_onMouseUpOrDown))
        loop
            exitwhen (this) > bj_MAX_PLAYER_SLOTS
            if GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
                set s__UserMouse_next[this]=0
                set s__UserMouse_prev[this]=s__UserMouse_prev[(0)]
                set s__UserMouse_next[s__UserMouse_prev[(0)]]=this
                set s__UserMouse_prev[(0)]=this
                
                set s__UserMouse_posDetector[this]=CreateTrigger()

                    set s__UserMouse_mouseEventReductor[this]=CreateTimer()

                call TriggerRegisterPlayerEvent(s__UserMouse_posDetector[this], p, EVENT_PLAYER_MOUSE_MOVE)
                call TriggerAddCondition(s__UserMouse_posDetector[this], Condition(function s__UserMouse_onMouseMove))
                
                call TriggerRegisterPlayerEvent(s__UserMouse_stateDetector, p, EVENT_PLAYER_MOUSE_UP)
                call TriggerRegisterPlayerEvent(s__UserMouse_stateDetector, p, EVENT_PLAYER_MOUSE_DOWN)
            endif
            set this=this + 1
            set p=(Player((this) - 1)) // INLINED!!
        endloop
    endfunction
    
    function s__UserMouse_timerInit takes nothing returns nothing
        call s__UserMouse_initCallback()
    endfunction
    function s__UserMouse_registerCode takes code handlerFunc,integer eventId returns triggercondition
        return TriggerAddCondition(s__UserMouse_evTrigger[eventId], Condition(handlerFunc))
    endfunction
    
    function s__UserMouse_unregisterCallback takes triggercondition whichHandler,integer eventId returns nothing
        call TriggerRemoveCondition(s__UserMouse_evTrigger[eventId], whichHandler)
    endfunction
    
//Implemented from module MouseUtils___Init:
    function s__UserMouse_MouseUtils___Init___invokeTimerInit takes nothing returns nothing
        call PauseTimer(GetExpiredTimer())
        call DestroyTimer(GetExpiredTimer())
        call s__UserMouse_initCallback() // INLINED!!
    endfunction
    function s__UserMouse_MouseUtils___Init___onInit takes nothing returns nothing
        set s__UserMouse_evTrigger[EVENT_MOUSE_UP]=CreateTrigger()
        set s__UserMouse_evTrigger[EVENT_MOUSE_DOWN]=CreateTrigger()
        set s__UserMouse_evTrigger[EVENT_MOUSE_MOVE]=CreateTrigger()
        call TimerStart(CreateTimer(), 0.00, false, function s__UserMouse_MouseUtils___Init___invokeTimerInit)
    endfunction
function GetPlayerMouseX takes player p returns real
    return s__UserMouse_mouseX[s__UserMouse__staticgetindex(p)]
endfunction
function GetPlayerMouseY takes player p returns real
    return s__UserMouse_mouseY[s__UserMouse__staticgetindex(p)]
endfunction
function OnMouseEvent takes code func,integer eventId returns triggercondition
    return s__UserMouse_registerCode(func , eventId)
endfunction
function GetMouseEventType takes nothing returns integer
    return (s__UserMouse_currentEventType) // INLINED!!
endfunction
function UnregisterMouseCallback takes triggercondition whichHandler,integer eventId returns nothing
    call s__UserMouse_unregisterCallback(whichHandler , eventId)
endfunction
function SetUserMousePos takes player p,integer x,integer y returns nothing
    call s__UserMouse_setMousePos(s__UserMouse__staticgetindex(p),x , y)
endfunction

//library MouseUtils ends
//library TreeUtils:



function AddTree takes integer id returns integer
    local integer index= TreeUtils___count
    set TreeUtils___ids[index]=id
    set TreeUtils___count=index + 1
    return index
endfunction

function GetTree takes integer index returns integer
    return TreeUtils___ids[index]
endfunction

function GetTreeCount takes nothing returns integer
    return TreeUtils___count
endfunction

function IsTree takes integer id returns boolean
    local integer i= 0
    loop
        exitwhen ( i == TreeUtils___count )
        if ( TreeUtils___ids[i] == id ) then
            return true
        endif
        set i=i + 1
    endloop
    return false
endfunction

function IsDestructableTree takes destructable whichDestructable returns boolean
    return IsTree(GetDestructableTypeId(whichDestructable))
endfunction

function TreeUtils___Init takes nothing returns nothing
    call AddTree(TreeUtils_SUMMER_TREE_WALL)
    call AddTree(TreeUtils_ASHENVALE_TREE_WALL)
    call AddTree(TreeUtils_ASHENVALE_CANOPY_TREE)
    call AddTree(TreeUtils_BARRENS_TREE_WALL)
    call AddTree(TreeUtils_BARRENS_CANOPY_TREE)
    call AddTree(TreeUtils_BLACK_CITADEL_TREE_WALL)
    call AddTree(TreeUtils_CITYSCAPE_SNOWY_TREE_WALL)
    call AddTree(TreeUtils_CITYSCAPE_FALL_TREE_WALL)
    call AddTree(TreeUtils_CITYSCAPE_WINTER_TREE_WALL)
    call AddTree(TreeUtils_CITYSCAPE_SUMMER_TREE_WALL)
    call AddTree(TreeUtils_DALARAN_RUINS_TREE_WALL)
    call AddTree(TreeUtils_DUNGEON_TREE_WALL)
    call AddTree(TreeUtils_FELWOOD_TREE_WALL)
    call AddTree(TreeUtils_FELWOOD_CANOPY_TREE)
    call AddTree(TreeUtils_ICECROWN_TREE_WALL)
    call AddTree(TreeUtils_ICECROWN_CANOPY_TREE)
    call AddTree(TreeUtils_WINTER_TREE_WALL)
    call AddTree(TreeUtils_NORTHREND_TREE_WALL)
    call AddTree(TreeUtils_SNOWY_TREE_WALL)
    call AddTree(TreeUtils_OUTLAND_TREE_WALL)
    call AddTree(TreeUtils_RUINS_TREE_WALL)
    call AddTree(TreeUtils_RUINS_CANOPY_TREE)
    call AddTree(TreeUtils_UNDERGROUND_TREE_WALL)
    call AddTree(TreeUtils_VILLAGE_TREE_WALL)
    call AddTree(TreeUtils_FALL_TREE_WALL)
    call AddTree(TreeUtils_SCORCHED_TREE_WALL)
    call AddTree(TreeUtils_SILVERMOON_TREE)
endfunction


//library TreeUtils ends
//library RayConfig:



function RayConfig___HasDummy takes unit target,integer abilityId returns boolean
    return HaveSavedHandle(RayConfig___h, GetHandleId(target), abilityId)
endfunction

function RayConfig___AttachDummy takes player owner,integer unitTypeId,unit target,integer abilityId returns unit
    local real face= GetUnitFacing(target)
    local real x= PolarProjectionX(GetUnitX(target) , 30.0 , face)
    local real y= PolarProjectionY(GetUnitY(target) , 30.0 , face)
    local real faceToTarget= AngleBetweenCoordinatesDeg(GetUnitX(target) , GetUnitY(target) , x , y)
    local unit dummy= CreateUnit(owner, unitTypeId, x, y, faceToTarget)
    call SaveUnitHandle(RayConfig___h, GetHandleId(target), abilityId, dummy)
    call ShowUnit(dummy, false)
    return dummy
endfunction

function RayConfig___CleanDummy takes unit target,integer abilityId returns nothing
    local integer handleId= GetHandleId(target)
    local unit dummy= LoadUnitHandle(RayConfig___h, handleId, abilityId)
    if ( dummy != null ) then
        call RemoveSavedHandle(RayConfig___h, handleId, abilityId)
        call h__RemoveUnit(dummy)
        set dummy=null
    endif
endfunction

function RayConfig___TimerFunctionCleanDummy takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local unit target= LoadUnitHandle(RayConfig___h, handleId, 0)
    local integer abilityId= LoadInteger(RayConfig___h, handleId, 1)
    call RayConfig___CleanDummy(target , abilityId)
    call PauseTimer(t)
    call DestroyTimer(t)
    call FlushChildHashtable(RayConfig___h, handleId)
endfunction

function RayConfig___CleanDummyDelayed takes unit target,integer abilityId,real delay returns nothing
    local timer t= CreateTimer()
    local integer handleId= GetHandleId(t)
    call SaveUnitHandle(RayConfig___h, handleId, 0, target)
    call SaveInteger(RayConfig___h, handleId, 1, abilityId)
    call TimerStart(t, delay, false, function RayConfig___TimerFunctionCleanDummy)
endfunction

function RayConfig___RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(RayConfig___h, GetHandleId(whichUnit))
endfunction

//processed hook: hook RemoveUnit RayConfig___RemoveUnitHook

function RayConfig_IsValidAbility takes integer abilityId returns boolean
    if ( abilityId == RayConfig_FROST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_HOLY_RAY ) then
        return true
    elseif ( abilityId == RayConfig_HARVEST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_LOOT_RAY ) then
        return true
    elseif ( abilityId == RayConfig_WATER_RAY ) then
        return true
    elseif ( abilityId == RayConfig_DRAIN_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_CHAIN_RAY ) then
        return true
    elseif ( abilityId == RayConfig_MANA_RAY ) then
        return true
    elseif ( abilityId == RayConfig_RAISE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_POISON_RAY ) then
        return true
    elseif ( abilityId == RayConfig_CHARM_RAY ) then
        return true
    elseif ( abilityId == RayConfig_NEUTRALIZATION_RAY ) then
        return true
    elseif ( abilityId == RayConfig_HEX_RAY ) then
        return true
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        return true
    elseif ( abilityId == RayConfig_WIND_RAY ) then
        return true
    endif
    return false
endfunction

function RayConfig_CanTargetUnits takes integer abilityId returns boolean
    return true
endfunction

function RayConfig_CanTargetDestructables takes integer abilityId returns boolean
    return true
endfunction

function RayConfig_CanTargetItems takes integer abilityId returns boolean
    return abilityId == RayConfig_LOOT_RAY
endfunction

function RayConfig___IsNoAlly takes unit target,unit caster returns boolean
    return GetOwningPlayer(caster) != GetOwningPlayer(target) and ( not IsUnitAlly(target, GetOwningPlayer(caster)) or GetOwningPlayer(target) == Player(PLAYER_NEUTRAL_PASSIVE) )
endfunction

function RayConfig_IsUnitAllowed takes unit caster,unit target,integer abilityId returns boolean
    if ( caster == target ) then
        return false
    // Locust is used by dummy units.
    elseif ( GetUnitAbilityLevel(target, 'Aloc') > 0 ) then
        return false
    elseif ( abilityId == RayConfig_RAISE_RAY and IsUnitAliveBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_HARVEST_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_HOLY_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_LOOT_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_WATER_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_POISON_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_CHARM_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_MANA_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_HEX_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_NEUTRALIZATION_RAY and IsUnitDeadBJ(target) ) then
        return false
    elseif ( abilityId == RayConfig_CHAIN_RAY and ( IsUnitDeadBJ(target) or DistanceBetweenCoordinates(GetUnitX(caster) , GetUnitY(caster) , GetUnitX(target) , GetUnitY(target)) <= 100.0 ) ) then
        return false
    elseif ( abilityId == RayConfig_RESURRECTION_RAY and ( IsUnitType(target, UNIT_TYPE_STRUCTURE) or IsUnitAliveBJ(target) or IsUnitEnemy(target, GetOwningPlayer(caster)) ) ) then
        return false
    elseif ( abilityId == RayConfig_WIND_RAY and ( not IsUnitType(target, UNIT_TYPE_GROUND) or IsUnitType(target, UNIT_TYPE_STRUCTURE) or IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) ) ) then
        return false
    elseif ( ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FIRE_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY or abilityId == RayConfig_WIND_RAY ) and IsUnitDeadBJ(target) ) then
        return false
    endif
    
    return true
endfunction

function RayConfig_IsDestructableAllowed takes unit caster,destructable target,integer abilityId returns boolean
    if ( abilityId == RayConfig_RESURRECTION_RAY ) then
        return IsDestructableDeadBJ(target)
    endif
    return IsDestructableAliveBJ(target)
endfunction

function RayConfig_IsItemAllowed takes unit caster,item target,integer abilityId returns boolean
    return GetItemLifeBJ(target) > 0.0 and DistanceBetweenCoordinates(GetUnitX(caster) , GetUnitY(caster) , GetItemX(target) , GetItemY(target)) > 100.0
endfunction

function RayConfig___IsFrostRay takes integer index returns boolean
    return ModuloInteger(index, 2) == 1
endfunction

function RayConfig_GetLightningOffsetWidthX takes unit caster,integer abilityId,integer index returns real
    if ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        if ( (ModuloInteger((index), 2) == 1) ) then // INLINED!!
            return index * 20.0
        else
            return index * - 20.0
        endif
    endif
    return 0.0
endfunction

function RayConfig_GetLightningOffsetWidthY takes unit caster,integer abilityId,integer index returns real
    if ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        if ( (ModuloInteger((index), 2) == 1) ) then // INLINED!!
            return index * 20.0
        else
            return index * - 20.0
        endif
    endif
    return 0.0
endfunction

function RayConfig_GetLightningOffsetLengthX takes unit caster,integer abilityId,integer index returns real
    return 40.0
endfunction

function RayConfig_GetLightningOffsetLengthY takes unit caster,integer abilityId,integer index returns real
    return 40.0
endfunction

function RayConfig_GetLightningOffsetZ takes unit caster,integer abilityId,integer index returns real
    return 40.0
endfunction

function RayConfig___GetDamage takes unit caster,integer abilityId,real duration returns real
    local real result= ( I2R(GetUnitAbilityLevel(caster, abilityId)) * 9.0 + 7.0 ) * RayConfig_REFRESH_INTERVAL
    
    if ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return result * 2.0
    endif
    
    return result
endfunction

function RayConfig___GetSpeed takes unit caster,integer abilityId,real duration returns real
    return ( GetUnitAbilityLevel(caster, abilityId) * 10.0 + 220.0 ) * RayConfig_REFRESH_INTERVAL
endfunction

function RayConfig___GetHealingLife takes unit caster,integer abilityId,real duration returns real
    return ( I2R(GetUnitAbilityLevel(caster, abilityId)) * 9.0 + 7.0 ) * RayConfig_REFRESH_INTERVAL
endfunction

function RayConfig___GetMana takes unit caster,integer abilityId,real duration returns real
    return ( I2R(GetUnitAbilityLevel(caster, abilityId)) * 10.0 + 10.0 ) * RayConfig_REFRESH_INTERVAL
endfunction

function RayConfig___GetManaCost takes unit caster,integer abilityId,real duration returns real
    return ( I2R(GetUnitAbilityLevel(caster, abilityId)) * 7.0 + 5.0 ) * RayConfig_REFRESH_INTERVAL
endfunction

function RayConfig___WaitDuration takes real duration,real expected returns boolean
    if ( duration >= expected ) then
        return true
    endif
    return false
endfunction

function RayConfig___EveryDuration takes real duration,real interval returns boolean
    local real mod= ModuloReal(duration, interval)
    return ( mod >= 0.0 and mod < RayConfig_REFRESH_INTERVAL )
endfunction

function RayConfig___GetGold takes unit caster,integer abilityId,real duration returns integer
    if ( RayConfig___EveryDuration(duration , RayConfig_HARVEST_INTERVAL) ) then
        return GetUnitAbilityLevel(caster, abilityId)
    endif
    return 0
endfunction

function RayConfig___GetLumber takes unit caster,integer abilityId,real duration returns integer
    if ( RayConfig___EveryDuration(duration , RayConfig_HARVEST_INTERVAL) ) then
        return GetUnitAbilityLevel(caster, abilityId)
    endif
    return 0
endfunction

function RayConfig___MoveUnit takes unit caster,unit target,real distance returns nothing
    local real sourceX= GetUnitX(caster)
    local real sourceY= GetUnitY(caster)
    local real targetX= GetUnitX(target)
    local real targetY= GetUnitY(target)
    local real dist= DistanceBetweenCoordinates(sourceX , sourceY , targetX , targetY)
    local real d= dist + distance
    local real facing= GetUnitFacing(caster)
    local real x= PolarProjectionX(sourceX , d , facing)
    local real y= PolarProjectionY(sourceY , d , facing)
    call SetUnitPosition(target, x, y)
endfunction

function RayConfig___KnockBack takes unit caster,unit target,real distance returns nothing
    call RayConfig___MoveUnit(caster , target , distance)
endfunction

function RayConfig___PullUnit takes unit caster,unit target,real distance returns nothing
    call RayConfig___MoveUnit(caster , target , - distance)
endfunction

function RayConfig___PullItem takes unit caster,item target,real distance returns nothing
    local real casterX= GetUnitX(caster)
    local real casterY= GetUnitY(caster)
    local real itemX= GetItemX(target)
    local real itemY= GetItemY(target)
    local real dist= DistanceBetweenCoordinates(casterX , casterY , itemX , itemY)
    local real d= dist - distance
    local real facing= GetUnitFacing(caster)
    local real x= PolarProjectionX(casterX , d , facing)
    local real y= PolarProjectionY(casterY , d , facing)
    call SetItemPosition(target, x, y)
    
    if ( DistanceBetweenCoordinates(casterX , casterY , x , y) <= 100.0 ) then
        call UnitAddItem(caster, target)
    endif
endfunction

function RayConfig___Drain takes unit caster,unit target,real amount,real manaAmount returns nothing
    // damaging triggers the creep
    call UnitDamageTarget(caster, target, amount, false, true, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    call SetUnitState(target, UNIT_STATE_MANA, RMaxBJ(GetUnitState(target, UNIT_STATE_MANA) - manaAmount, 0.0))
    
    call SetUnitState(caster, UNIT_STATE_LIFE, RMinBJ(GetUnitState(caster, UNIT_STATE_LIFE) + amount, GetUnitState(caster, UNIT_STATE_MAX_LIFE)))
    call SetUnitState(caster, UNIT_STATE_MANA, RMinBJ(GetUnitState(caster, UNIT_STATE_MANA) + manaAmount, GetUnitState(caster, UNIT_STATE_MAX_MANA)))
endfunction

function RayConfig___Restore takes unit caster,unit target,real amount,real manaAmount returns nothing
    call SetUnitState(target, UNIT_STATE_LIFE, RMinBJ(GetUnitState(target, UNIT_STATE_LIFE) + amount, GetUnitState(target, UNIT_STATE_MAX_LIFE)))
    call SetUnitState(target, UNIT_STATE_MANA, RMinBJ(GetUnitState(target, UNIT_STATE_MANA) + manaAmount, GetUnitState(target, UNIT_STATE_MAX_MANA)))
endfunction

function RayConfig___DrainMana takes unit caster,unit target,real amount returns nothing
    call SetUnitState(target, UNIT_STATE_MANA, RMaxBJ(GetUnitState(target, UNIT_STATE_MANA) - amount, 0.0))
    
    call SetUnitState(caster, UNIT_STATE_MANA, RMinBJ(GetUnitState(caster, UNIT_STATE_MANA) + amount, GetUnitState(caster, UNIT_STATE_MAX_MANA)))
endfunction

function RayConfig___RestoreMana takes unit caster,unit target,real amount returns nothing
    call SetUnitState(target, UNIT_STATE_MANA, RMinBJ(GetUnitState(target, UNIT_STATE_MANA) + amount, GetUnitState(target, UNIT_STATE_MAX_MANA)))
endfunction

function RayConfig___SummonSkeleton takes unit caster,unit target returns nothing
    local unit s= CreateUnit(GetOwningPlayer(caster), 'nske', GetUnitX(target), GetUnitY(target), GetUnitFacing(target))
    call UnitApplyTimedLife(s, 'BTLF', 60)
    call SetUnitAnimation(s, "Birth")
    call h__RemoveUnit(target)
    set s=null
endfunction

function RayConfig___ResurrectNonHeroUnit takes unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(target) , RayConfig_RESURRECT_DUMMY , target , RayConfig_RESURRECTION_RAY)
    call IssueImmediateOrder(dummy, "resurrection")
    call RayConfig___CleanDummyDelayed(target , RayConfig_RESURRECTION_RAY , 2.0)
    //call BJDebugMsg("Remove dummy!")
    set dummy=null
endfunction

function RayConfig___FrostDamage takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_FROST_DUMMY , target , RayConfig_FROST_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_FROST_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_FROST_RAY))
    call IssueTargetOrder(dummy, "attack", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_FROST_DUMMY , 2.0)
    set dummy=null
endfunction

function RayConfig___FireDamage takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_FIRE_DUMMY , target , RayConfig_FIRE_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_FIRE_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_FIRE_RAY))
    call IssueTargetOrder(dummy, "attack", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_FIRE_DUMMY , 2.0)
    //call BJDebugMsg("Remove dummy!")
    set dummy=null
endfunction

function RayConfig___PoisonDamage takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_POISON_DUMMY , target , RayConfig_POISON_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_POISON_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_POISON_RAY))
    //call BJDebugMsg("Create poison dummy " + GetUnitName(dummy))
    call IssueTargetOrder(dummy, "attack", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_POISON_DUMMY , 2.0)
    //call BJDebugMsg("Remove dummy!")
    set dummy=null
endfunction

function RayConfig___Cyclone takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_WIND_DUMMY , target , RayConfig_WIND_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_WIND_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_WIND_RAY))
    call IssueTargetOrder(dummy, "cyclone", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_WIND_DUMMY , 2.0)
    //call BJDebugMsg("Remove dummy cyclone!")
    set dummy=null
endfunction

function RayConfig___GetMaxCharmLevel takes unit caster,integer abilityId returns integer
    return 5 + GetUnitAbilityLevel(caster, abilityId)
endfunction

function RayConfig___Charm takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_CHARM_DUMMY , target , RayConfig_CHARM_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_CHARM_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_CHARM_RAY))
    call IssueTargetOrder(dummy, "charm", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_CHARM_DUMMY , 2.0)
    //call BJDebugMsg("Remove dummy cyclone!")
    set dummy=null
endfunction

function RayConfig___Hex takes unit caster,unit target returns nothing
    local unit dummy= RayConfig___AttachDummy(GetOwningPlayer(caster) , RayConfig_HEX_DUMMY , target , RayConfig_HEX_RAY)
    call SetUnitAbilityLevel(dummy, RayConfig_HEX_DUMMY_ABILITY_ID, GetUnitAbilityLevel(caster, RayConfig_HEX_RAY))
    call IssueTargetOrder(dummy, "hex", target)
    call RayConfig___CleanDummyDelayed(target , RayConfig_HEX_DUMMY , 2.0)
    //call BJDebugMsg("Remove dummy cyclone!")
    set dummy=null
endfunction

function RayConfig___ResurrectUnit takes unit target returns nothing
    if ( IsUnitType(target, UNIT_TYPE_HERO) ) then
        //call BJDebugMsg("Revive hero " + GetUnitName(target))
        call ReviveHero(target, GetUnitX(target), GetUnitY(target), true)
    else
        //call BJDebugMsg("Mod " + R2S(ModuloReal(duration, 1.0)))
        if ( not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_RESURRECTION_RAY))) ) then // INLINED!!
            //call BJDebugMsg("Resurrect unit " + GetUnitName(target))
            call RayConfig___ResurrectNonHeroUnit(target)
        endif
    endif
endfunction

function RayConfig_OnHitUnit takes unit caster,unit target,integer abilityId,real duration returns nothing
    if ( abilityId == RayConfig_HOLY_RAY ) then
        if ( IsUnitAlly(target, GetOwningPlayer(caster)) ) then
            if ( not IsUnitType(target, UNIT_TYPE_UNDEAD) ) then
                call SetUnitState(target, UNIT_STATE_LIFE, RMinBJ(GetUnitState(target, UNIT_STATE_MAX_LIFE), GetUnitState(target, UNIT_STATE_LIFE) + RayConfig___GetHealingLife(caster , abilityId , duration)))
            endif
        else
            if ( IsUnitType(target, UNIT_TYPE_UNDEAD) ) then
                call UnitDamageTarget(caster, target, RayConfig___GetDamage(caster , abilityId , duration), false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
            endif
        endif
    elseif ( abilityId == RayConfig_HARVEST_RAY ) then
        if ( GetResourceAmount(target) > 0 ) then
            call AdjustPlayerStateBJ(RayConfig___GetGold(caster , abilityId , duration), GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD)
            call SetResourceAmount(target, IMaxBJ(0, GetResourceAmount(target) - RayConfig___GetGold(caster , abilityId , duration)))
        endif
    elseif ( abilityId == RayConfig_WATER_RAY ) then
        if ( RayConfig___IsNoAlly(target , caster) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) ) then
            call RayConfig___MoveUnit((caster ) , ( target ) , (( RayConfig___GetSpeed(caster , abilityId , duration))*1.0)) // INLINED!!
        endif
    elseif ( abilityId == RayConfig_LOOT_RAY ) then
        // nothing
    elseif ( abilityId == RayConfig_CHAIN_RAY ) then
        if ( RayConfig___IsNoAlly(target , caster) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) ) then
            call RayConfig___MoveUnit((caster ) , ( target ) , - (( RayConfig___GetSpeed(caster , abilityId , duration))*1.0)) // INLINED!!
        endif
    elseif ( abilityId == RayConfig_MANA_RAY ) then
        if ( RayConfig___IsNoAlly(target , caster) ) then
            call RayConfig___DrainMana(caster , target , RayConfig___GetMana(caster , abilityId , duration))
        else
            call RayConfig___RestoreMana(caster , target , RayConfig___GetMana(caster , abilityId , duration))
        endif
    elseif ( abilityId == RayConfig_DRAIN_RAY ) then
        if ( RayConfig___IsNoAlly(target , caster) ) then
            call RayConfig___Drain(caster , target , RayConfig___GetHealingLife(caster , abilityId , duration) , RayConfig___GetMana(caster , abilityId , duration))
        else
            call RayConfig___Restore(caster , target , RayConfig___GetHealingLife(caster , abilityId , duration) , RayConfig___GetMana(caster , abilityId , duration))
        endif
    elseif ( abilityId == RayConfig_RAISE_RAY ) then
        if ( RayConfig___WaitDuration(duration , 1.0) ) then
            if ( IsUnitDeadBJ(target) and not IsUnitType(target, UNIT_TYPE_HERO) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) ) then
                call RayConfig___SummonSkeleton(caster , target)
            endif
        endif
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        if ( RayConfig___WaitDuration(duration , 1.0) ) then
            if ( not RayConfig___IsNoAlly(target , caster) or GetOwningPlayer(target) == Player(PLAYER_NEUTRAL_PASSIVE) ) then
                call RayConfig___ResurrectUnit(target)
            endif
        endif
    elseif ( abilityId == RayConfig_WIND_RAY ) then
        if ( RayConfig___WaitDuration(duration , 2.0) ) then
            if ( not UnitHasBuffBJ(target, RayConfig_BUFF_ID_WIND) and RayConfig___IsNoAlly(target , caster) and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_WIND_RAY))) ) then // INLINED!!
                call RayConfig___Cyclone(caster , target)
            endif
        endif
    elseif ( abilityId == RayConfig_CHARM_RAY ) then
        if ( RayConfig___WaitDuration(duration , 6.0) ) then
            if ( GetUnitLevel(target) <= (5 + GetUnitAbilityLevel((caster ), ( abilityId))) and not IsUnitType(target, UNIT_TYPE_HERO) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and RayConfig___IsNoAlly(target , caster) and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_CHARM_RAY))) ) then // INLINED!!
                call RayConfig___Charm(caster , target)
            endif
        endif
    elseif ( abilityId == RayConfig_HEX_RAY ) then
        if ( RayConfig___WaitDuration(duration , 1.0) ) then
            if ( not IsUnitType(target, UNIT_TYPE_HERO) and not IsUnitType(target, UNIT_TYPE_STRUCTURE) and RayConfig___IsNoAlly(target , caster) and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_HEX_RAY))) ) then // INLINED!!
                call RayConfig___Hex(caster , target)
            endif
        endif
    elseif ( abilityId == RayConfig_NEUTRALIZATION_RAY ) then
        if ( RayConfig___WaitDuration(duration , 1.0) ) then
            if ( IsUnitType(target, UNIT_TYPE_SUMMONED) and RayConfig___IsNoAlly(target , caster) ) then
                call UnitDamageTarget(caster, target, RayConfig___GetDamage(caster , abilityId , duration) * 2.0, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
            else
                if ( RayConfig___IsNoAlly(target , caster) ) then
                    call UnitRemoveBuffs(target, true, false)
                else
                    call UnitRemoveBuffs(target, false, true)
                endif
            endif
        endif
    elseif ( RayConfig___IsNoAlly(target , caster) ) then
        if ( ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_FROST_RAY))) and not UnitHasBuffBJ(target, RayConfig_BUFF_ID_FROST) ) then // INLINED!!
            call RayConfig___FrostDamage(caster , target)
        endif
        if ( ( abilityId == RayConfig_FIRE_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_FIRE_RAY))) and not UnitHasBuffBJ(target, RayConfig_BUFF_ID_FIRE) ) then // INLINED!!
            call RayConfig___FireDamage(caster , target)
        endif
        if ( abilityId == RayConfig_POISON_RAY and not (HaveSavedHandle(RayConfig___h, GetHandleId((target )), ( RayConfig_POISON_RAY))) and not UnitHasBuffBJ(target, RayConfig_BUFF_ID_POISON) ) then // INLINED!!
            call RayConfig___PoisonDamage(caster , target)
        endif
        call UnitDamageTarget(caster, target, RayConfig___GetDamage(caster , abilityId , duration), false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
    endif
endfunction

function RayConfig_OnHitDestructable takes unit caster,destructable target,integer abilityId,real duration returns nothing
    if ( abilityId == RayConfig_HARVEST_RAY ) then
        if ( IsTree(GetDestructableTypeId(target)) ) then
            call AdjustPlayerStateBJ(RayConfig___GetLumber(caster , abilityId , duration), GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_LUMBER)
            call SetDestructableLife(target, RMaxBJ(0.0, GetDestructableLife(target) - RayConfig___GetLumber(caster , abilityId , duration)))
        endif
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        if ( RayConfig___WaitDuration(duration , 2.0) ) then
            if ( IsDestructableDeadBJ(target) ) then
                call DestructableRestoreLife(target, GetDestructableMaxLife(target), true)
            endif
        endif
    else
        call SetDestructableLife(target, RMaxBJ(0.0, GetDestructableLife(target) - RayConfig___GetDamage(caster , abilityId , duration)))
    endif
endfunction

function RayConfig_OnHitItem takes unit caster,item target,integer abilityId,real duration returns nothing
    call RayConfig___PullItem(caster , target , RayConfig___GetSpeed(caster , abilityId , duration))
endfunction

function RayConfig_OnCastLoop takes unit caster,integer abilityId,real duration returns boolean
    call SetUnitManaBJ(caster, RMaxBJ(0.0, GetUnitState(caster, UNIT_STATE_MANA) - RayConfig___GetManaCost(caster , abilityId , duration)))
    
    return GetUnitState(caster, UNIT_STATE_MANA) > 0.0
endfunction

function RayConfig_GetDuration takes unit caster,integer abilityId returns real
    if ( abilityId == RayConfig_FROST_RAY ) then
        return RayConfig_HOLD_KEY_DURATION
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return RayConfig_HOLD_KEY_DURATION
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return RayConfig_HOLD_KEY_DURATION
    endif
    return 0.0
endfunction

function RayConfig_GetMaxDistance takes unit caster,integer abilityId returns real
    return BlzGetUnitRealField(caster, UNIT_RF_SIGHT_RADIUS)
endfunction

function RayConfig_GetRange takes unit caster,integer abilityId returns real
    return 100.0
endfunction

function RayConfig_GetCooldown takes unit caster,integer abilityId returns real
    return 0.0
endfunction

function RayConfig_GetMaxLightnings takes unit caster,integer abilityId returns integer
    if ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return 1 + GetUnitAbilityLevel(caster, abilityId)
    endif
    return 1
endfunction

function RayConfig_GetLightningCode takes unit caster,integer abilityId,integer index returns string
    if ( abilityId == RayConfig_FROST_RAY ) then
        return "BLBM"
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return "FIPA"
    elseif ( abilityId == RayConfig_HOLY_RAY ) then
        return "YEBM"
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        return "YEBM"
    elseif ( abilityId == RayConfig_HARVEST_RAY ) then
        return "MYSB"
    elseif ( abilityId == RayConfig_LOOT_RAY ) then
        return "WHBM"
    elseif ( abilityId == RayConfig_WATER_RAY ) then
        return "BLBM"
    elseif ( abilityId == RayConfig_DRAIN_RAY ) then
        return "DRAB"
    elseif ( abilityId == RayConfig_CHAIN_RAY ) then
        return "WHCH"
    elseif ( abilityId == RayConfig_MANA_RAY ) then
        return "DRAM"
    elseif ( abilityId == RayConfig_RAISE_RAY ) then
        return "WHSB"
    elseif ( abilityId == RayConfig_POISON_RAY ) then
        return "GRSB"
    elseif ( abilityId == RayConfig_WIND_RAY ) then
        return "SPNL"
    elseif ( abilityId == RayConfig_HEX_RAY ) then
        return "GRBM"
    elseif ( abilityId == RayConfig_CHARM_RAY ) then
        return "BLBM"
    elseif ( abilityId == RayConfig_NEUTRALIZATION_RAY ) then
        return "MYNL"
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        if ( (ModuloInteger((index), 2) == 1) ) then // INLINED!!
            return "BLBM"
        else
            return "FIPA"
        endif
    endif
    return "CLPB"
endfunction

function RayConfig_GetLoopSound takes unit caster,integer abilityId returns sound
    if ( abilityId == RayConfig_FIRE_RAY ) then
        return gg_snd_Incinerate1
        //return gg_snd_BlueFireBurstLoop
    elseif ( abilityId == RayConfig_FROST_RAY ) then
        return gg_snd_BreathOfFrost1
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return gg_snd_BreathOfFrost1
    elseif ( abilityId == RayConfig_DRAIN_RAY ) then
        return gg_snd_LifeDrain
    elseif ( abilityId == RayConfig_POISON_RAY ) then
        return gg_snd_LifeDrain
    elseif ( abilityId == RayConfig_HOLY_RAY ) then
        return gg_snd_HealTarget
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        return gg_snd_HealTarget
    elseif ( abilityId == RayConfig_WATER_RAY ) then
        return gg_snd_WaterWaterFallLoop1
    elseif ( abilityId == RayConfig_LOOT_RAY ) then
        return gg_snd_ShimmeringPortalLoop
    elseif ( abilityId == RayConfig_HARVEST_RAY ) then
        return gg_snd_MineDomeLoop1
    elseif ( abilityId == RayConfig_WIND_RAY ) then
        return gg_snd_CycloneLoop1
    elseif ( abilityId == RayConfig_HEX_RAY ) then
        return gg_snd_CharmTarget1
    endif
    return null
endfunction

function RayConfig_GetHitSound takes unit caster,integer abilityId returns sound
    if ( abilityId == RayConfig_FIRE_RAY ) then
        return gg_snd_ImmolationTarget1
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return gg_snd_ImmolationTarget1
    elseif ( abilityId == RayConfig_FROST_RAY ) then
        return gg_snd_FreezingBreathTarget1
    elseif ( abilityId == RayConfig_DRAIN_RAY ) then
        return gg_snd_LifeDrain
    elseif ( abilityId == RayConfig_POISON_RAY ) then
        return gg_snd_LifeDrain
    elseif ( abilityId == RayConfig_HOLY_RAY ) then
        return gg_snd_HealTarget
    elseif ( abilityId == RayConfig_RAISE_RAY ) then
        return gg_snd_RaiseSkeleton
    elseif ( abilityId == RayConfig_RESURRECTION_RAY ) then
        return gg_snd_Tranquility
    elseif ( abilityId == RayConfig_WATER_RAY ) then
        return gg_snd_WaterWaterFallLoop1
    elseif ( abilityId == RayConfig_LOOT_RAY ) then
        return gg_snd_ShimmeringPortalLoop
    elseif ( abilityId == RayConfig_HARVEST_RAY ) then
        return gg_snd_MagicWallLoop1
    endif
    return null
endfunction

function RayConfig_GetCasterEffect takes unit caster,integer abilityId,real duration returns string
    if ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return "Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl"
    endif
    return null
endfunction

function RayConfig_GetCasterEffectAttachmentPoint takes unit caster,integer abilityId,real duration returns string
    if ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return "origin"
    endif
    return null
endfunction

function RayConfig_GetTargetEffect takes unit caster,integer abilityId,real duration returns string
    if ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return "Abilities\\Spells\\Items\\AIob\\AIobSpecialArt.mdl"
    endif
    return null
endfunction

function RayConfig_GetTargetEffectAttachmentPoint takes unit caster,integer abilityId,real duration returns string
    if ( abilityId == RayConfig_FROST_RAY or abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return "origin"
    endif
    return null
endfunction

function RayConfig_DisableAttack takes unit caster,integer abilityId returns boolean
    if ( abilityId == RayConfig_FROST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_CHARM_RAY ) then
        return true
    endif
    return false
endfunction

function RayConfig_GetDisableMovement takes unit caster,integer abilityId returns boolean
    if ( abilityId == RayConfig_FROST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return true
    endif
    return false
endfunction

function RayConfig_GetHoldKey takes unit caster,integer abilityId returns boolean
    if ( abilityId == RayConfig_FROST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return true
    endif
    return false
endfunction

function RayConfig_GetMouseAiming takes unit caster,integer abilityId returns boolean
    if ( abilityId == RayConfig_FROST_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FIRE_RAY ) then
        return true
    elseif ( abilityId == RayConfig_FROST_AND_FIRE_RAY ) then
        return true
    endif
    return false
endfunction


//library RayConfig ends
//library Ray:




function Ray___FilterIsClosestUnit takes nothing returns boolean
    local unit u= GetFilterUnit()
    local real distance= 0.0
    if ( RayConfig_IsUnitAllowed(s__Ray___T_caster[Ray___filterTarget] , u , s__Ray___T_abilityId[Ray___filterTarget]) ) then
        set distance=DistanceBetweenCoordinates(GetUnitX(u) , GetUnitY(u) , GetUnitX(s__Ray___T_caster[Ray___filterTarget]) , GetUnitY(s__Ray___T_caster[Ray___filterTarget]))
        if ( Ray___filterClosestUnit == null or distance < Ray___filterClosestDistance ) then
            //call BJDebugMsg("Matched destructable " + GetDestructableName(d))
            set Ray___filterClosestDistance=distance
            set Ray___filterClosestUnit=u
        endif
    endif
    set u=null
    return false
endfunction

function Ray___FilterIsClosestDestructable takes nothing returns boolean
    local destructable d= GetFilterDestructable()
    local real distance= 0.0
    if ( RayConfig_IsDestructableAllowed(s__Ray___T_caster[Ray___filterTarget] , d , s__Ray___T_abilityId[Ray___filterTarget]) ) then
        set distance=DistanceBetweenCoordinates(GetDestructableX(d) , GetDestructableY(d) , GetUnitX(s__Ray___T_caster[Ray___filterTarget]) , GetUnitY(s__Ray___T_caster[Ray___filterTarget]))
        if ( Ray___filterClosestDestructable == null or distance < Ray___filterClosestDistance ) then
            //call BJDebugMsg("Matched destructable " + GetDestructableName(d))
            set Ray___filterClosestDistance=distance
            set Ray___filterClosestDestructable=d
        endif
    endif
    set d=null
    return false
endfunction

function Ray___FilterIsClosestItem takes nothing returns boolean
    local item i= GetFilterItem()
    local real distance= 0.0
    if ( RayConfig_IsItemAllowed(s__Ray___T_caster[Ray___filterTarget] , i , s__Ray___T_abilityId[Ray___filterTarget]) ) then
        set distance=DistanceBetweenCoordinates(GetItemX(i) , GetItemY(i) , GetUnitX(s__Ray___T_caster[Ray___filterTarget]) , GetUnitY(s__Ray___T_caster[Ray___filterTarget]))
        if ( Ray___filterClosestItem == null or distance < Ray___filterClosestDistance ) then
            set Ray___filterClosestDistance=distance
            set Ray___filterClosestItem=i
        endif
    endif
    set i=null
    return false
endfunction


function Ray___GetTargetUnit takes integer target,real casterX,real casterY,real face,real x,real y returns unit
    local group g= CreateGroup()
    local unit result= null
    set Ray___filterTarget=target
    set Ray___filterClosestDistance=0.0
    set Ray___filterClosestUnit=null
    call GroupEnumUnitsInRange(g, x, y, s__Ray___T_range[target], Ray___filterIsClosestUnit)
    call GroupClear(g)
    call DestroyGroup(g)
    set g=null
    return Ray___filterClosestUnit
endfunction

function Ray___GetTargetDestructable takes integer target,real casterX,real casterY,real face,real x,real y returns destructable
    local rect r= GetRectFromCircle(x , y , s__Ray___T_range[target])
    set Ray___filterTarget=target
    set Ray___filterClosestDistance=0.0
    set Ray___filterClosestDestructable=null
    call EnumDestructablesInRect(r, Ray___filterIsClosestDestructable, null)
    call RemoveRect(r)
    set r=null
    return Ray___filterClosestDestructable
endfunction

function Ray___GetTargetItem takes integer target,real casterX,real casterY,real face,real x,real y returns item
    local rect r= GetRectFromCircle(x , y , s__Ray___T_range[target])
    set Ray___filterTarget=target
    set Ray___filterClosestDistance=0.0
    set Ray___filterClosestItem=null
    call EnumItemsInRect(r, Ray___filterIsClosestItem, null)
    call RemoveRect(r)
    set r=null
    return Ray___filterClosestItem
endfunction

function Ray___UpdateTarget takes integer target returns nothing
    local real face= GetUnitFacing(s__Ray___T_caster[target])
    local real x= GetUnitX(s__Ray___T_caster[target])
    local real y= GetUnitY(s__Ray___T_caster[target])
    local real z= BlzGetUnitZ(s__Ray___T_caster[target]) + GetUnitFlyHeight(s__Ray___T_caster[target])
    local real targetX= x
    local real targetY= y
    local real targetWidth= 0.0
    local real centerX= PolarProjectionX(targetX , face , Ray_STEP_DISTANCE_HALF)
    local real centerY= PolarProjectionY(targetY , face , Ray_STEP_DISTANCE_HALF)
    local real tmpTargetX= x
    local real tmpTargetY= y
    local location tmpTarget= Location(tmpTargetX, tmpTargetY)
    local real distanceUnit= 0.0
    local real distanceDestructable= 0.0
    local real distanceItem= 0.0
    local real maxDistance= s__Ray___T_maxDistance[target]
    local real distance= 0.0
    local integer i= 0
    local real lightningX= 0.0
    local real lightningY= 0.0
    local real lightningZ= 0.0
    local unit oldTargetUnit= s__Ray___T_u[target]
    local destructable oldTargetDestructable= s__Ray___T_d[target]
    local item oldTargetItem= s__Ray___T_i[target]
    local boolean oldTarget= false
    set s__Ray___T_u[target]=null
    set s__Ray___T_d[target]=null
    set s__Ray___T_i[target]=null
    //call BJDebugMsg("Face " + R2S(face))
    loop
        if ( RayConfig_CanTargetUnits(s__Ray___T_abilityId[target]) ) then
            set s__Ray___T_u[target]=Ray___GetTargetUnit(target , x , y , face , centerX , centerY)
        endif

        if ( RayConfig_CanTargetDestructables(s__Ray___T_abilityId[target]) ) then
            set s__Ray___T_d[target]=Ray___GetTargetDestructable(target , x , y , face , centerX , centerY)
        endif
        
        if ( ((s__Ray___T_abilityId[target]) == RayConfig_LOOT_RAY) ) then // INLINED!!
            set s__Ray___T_i[target]=Ray___GetTargetItem(target , x , y , face , centerX , centerY)
        endif

        if ( s__Ray___T_u[target] != null and s__Ray___T_d[target] != null ) then
            set distanceUnit=DistanceBetweenCoordinates(x , y , GetUnitX(s__Ray___T_u[target]) , GetUnitY(s__Ray___T_u[target]))
            set distanceDestructable=DistanceBetweenCoordinates(x , y , GetDestructableX(s__Ray___T_d[target]) , GetDestructableY(s__Ray___T_d[target]))
            if ( distanceDestructable < distanceUnit ) then
                set s__Ray___T_u[target]=null
            else
                set s__Ray___T_d[target]=null
            endif
        endif
        
        if ( s__Ray___T_u[target] != null and s__Ray___T_i[target] != null ) then
            set distanceUnit=DistanceBetweenCoordinates(x , y , GetUnitX(s__Ray___T_u[target]) , GetUnitY(s__Ray___T_u[target]))
            set distanceItem=DistanceBetweenCoordinates(x , y , GetItemX(s__Ray___T_i[target]) , GetItemY(s__Ray___T_i[target]))
            if ( distanceItem < distanceUnit ) then
                set s__Ray___T_u[target]=null
            else
                set s__Ray___T_i[target]=null
            endif
        endif
        
        if ( s__Ray___T_d[target] != null and s__Ray___T_i[target] != null ) then
            set distanceDestructable=DistanceBetweenCoordinates(x , y , GetDestructableX(s__Ray___T_d[target]) , GetDestructableY(s__Ray___T_d[target]))
            set distanceItem=DistanceBetweenCoordinates(x , y , GetItemX(s__Ray___T_i[target]) , GetItemY(s__Ray___T_i[target]))
            if ( distanceItem < distanceDestructable ) then
                set s__Ray___T_d[target]=null
            else
                set s__Ray___T_i[target]=null
            endif
        endif
        
        exitwhen ( s__Ray___T_u[target] != null or s__Ray___T_d[target] != null or s__Ray___T_i[target] != null )
        
        //call BJDebugMsg("Updating target loop (" + R2S(targetX) + "|" + R2S(targetX) + ")")
        
        set tmpTargetX=PolarProjectionX(targetX , face , Ray_STEP_DISTANCE)
        set tmpTargetY=PolarProjectionY(targetY , face , Ray_STEP_DISTANCE)
        call MoveLocation(tmpTarget, tmpTargetX, tmpTargetY)
        exitwhen ( IsTerrainPathable(tmpTargetX, tmpTargetY, PATHING_TYPE_FLYABILITY) )
        exitwhen ( IsTerrainPathable(tmpTargetX, tmpTargetY, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(tmpTargetX, tmpTargetY, PATHING_TYPE_FLOATABILITY) )
        exitwhen ( tmpTargetX >= GetRectMaxX(GetPlayableMapRect()) )
        exitwhen ( tmpTargetX <= GetRectMinX(GetPlayableMapRect()) )
        exitwhen ( tmpTargetY >= GetRectMaxY(GetPlayableMapRect()) )
        exitwhen ( tmpTargetY <= GetRectMinY(GetPlayableMapRect()) )
        exitwhen ( GetLocationZ(tmpTarget) > z + Ray_Z_THRESHOLD )
        exitwhen ( DistanceBetweenCoordinates(x , y , tmpTargetX , tmpTargetY) > maxDistance )
        set targetX=tmpTargetX
        set targetY=tmpTargetY
        set centerX=PolarProjectionX(targetX , face , Ray_STEP_DISTANCE_HALF)
        set centerY=PolarProjectionY(targetY , face , Ray_STEP_DISTANCE_HALF)
    endloop
    
    if ( s__Ray___T_u[target] != null ) then
        set s__Ray___T_x[target]=GetUnitX(s__Ray___T_u[target])
        set s__Ray___T_y[target]=GetUnitY(s__Ray___T_u[target])
        set s__Ray___T_z[target]=BlzGetUnitZ(s__Ray___T_u[target]) + GetUnitFlyHeight(s__Ray___T_u[target])

        set targetWidth=BlzGetUnitCollisionSize(s__Ray___T_u[target])

        
        if ( oldTargetUnit == s__Ray___T_u[target] ) then
            set oldTarget=true
        endif
    elseif ( s__Ray___T_d[target] != null ) then
        set s__Ray___T_x[target]=GetDestructableX(s__Ray___T_d[target])
        set s__Ray___T_y[target]=GetDestructableY(s__Ray___T_d[target])
        set s__Ray___T_z[target]=z
        
        if ( oldTargetDestructable == s__Ray___T_d[target] ) then
            set oldTarget=true
        endif
    elseif ( s__Ray___T_i[target] != null ) then
        set s__Ray___T_x[target]=GetItemX(s__Ray___T_i[target])
        set s__Ray___T_y[target]=GetItemY(s__Ray___T_i[target])
        set s__Ray___T_z[target]=z
        
        if ( oldTargetItem == s__Ray___T_i[target] ) then
            set oldTarget=true
        endif
    else
        set s__Ray___T_x[target]=targetX
        set s__Ray___T_y[target]=targetY
        set s__Ray___T_z[target]=z
    endif
    
    if ( oldTarget ) then
        set s__Ray___T_duration[target]=s__Ray___T_duration[target] + RayConfig_REFRESH_INTERVAL
    else
        set s__Ray___T_duration[target]=0.0
    endif


    set distance=DistanceBetweenCoordinates(x , y , s__Ray___T_x[target] , s__Ray___T_y[target]) - targetWidth
    set s__Ray___T_x[target]=PolarProjectionX(x , face , distance)
    set s__Ray___T_y[target]=PolarProjectionY(y , face , distance)






    
    set i=0
    loop
        exitwhen ( i == s__Ray___T_maxLightnings[target] )
        set lightningX=PolarProjectionX(x , ModuloReal(face + 90.0, 360.0) , RayConfig_GetLightningOffsetWidthX(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , i))
        set lightningY=PolarProjectionY(y , ModuloReal(face + 90.0, 360.0) , RayConfig_GetLightningOffsetWidthY(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , i))
        set lightningX=PolarProjectionX(lightningX , face , RayConfig_GetLightningOffsetLengthX(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , i))
        set lightningY=PolarProjectionY(lightningY , face , RayConfig_GetLightningOffsetLengthY(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , i))
        set lightningZ=z + RayConfig_GetLightningOffsetZ(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , i)
        
        call MoveLightningEx(s___Ray___T_l[s__Ray___T_l[target]+i], false, lightningX, lightningY, lightningZ, s__Ray___T_x[target], s__Ray___T_y[target], s__Ray___T_z[target])
        set i=i + 1
    endloop
    
    call RemoveLocation(tmpTarget)
    set tmpTarget=null
endfunction

function Ray___EndRay takes unit caster returns nothing
    local integer handleId= GetHandleId(caster)
    local integer i= 0
    local integer target= LoadInteger(Ray___h, handleId, 0)
    local real cooldown= RayConfig_GetCooldown(s__Ray___T_caster[target] , s__Ray___T_abilityId[target])
    
    if ( s__Ray___T_loopSound[target] != null and GetSoundIsPlaying(s__Ray___T_loopSound[target]) ) then
        call StopSound(s__Ray___T_loopSound[target], false, false)
    endif
    
    if ( s__Ray___T_hitSound[target] != null and GetSoundIsPlaying(s__Ray___T_hitSound[target]) ) then
        call StopSound(s__Ray___T_hitSound[target], false, false)
    endif
    
    if ( s__Ray___T_casterEffect[target] != null ) then
        call DestroyEffect(s__Ray___T_casterEffect[target])
        set s__Ray___T_casterEffect[target]=null
    endif
    
    if ( s__Ray___T_targetEffect[target] != null ) then
        call DestroyEffect(s__Ray___T_targetEffect[target])
        set s__Ray___T_targetEffect[target]=null
    endif
    
    call GroupRemoveUnit(Ray___casters, s__Ray___T_caster[target])
    
    if ( BlzGroupGetSize(Ray___casters) == 0 ) then
        call PauseTimer(Ray___refreshTimer)
    endif
    
    set i=0
    loop
        exitwhen ( i == s__Ray___T_maxLightnings[target] )
        call DestroyLightning(s___Ray___T_l[s__Ray___T_l[target]+i])
        set i=i + 1
    endloop
    
    call BlzStartUnitAbilityCooldown(s__Ray___T_caster[target], s__Ray___T_abilityId[target], cooldown)
    
    call s__Ray___T_deallocate(target)
    call FlushChildHashtable(Ray___h, handleId)
endfunction

function Ray___GetUnitController takes unit caster returns player
    local player slotPlayer= null
    local player owner= GetOwningPlayer(caster)
    local player result= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( ( owner == slotPlayer or GetPlayerAlliance(slotPlayer, owner, ALLIANCE_SHARED_ADVANCED_CONTROL) ) and IsUnitSelected(caster, slotPlayer) ) then
            if ( result == null or owner == slotPlayer ) then
                set result=slotPlayer
            endif
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    set owner=null
    return result
endfunction


function Ray___MouseAiming takes unit caster returns nothing
    local player controller= Ray___GetUnitController(caster)
    call SetUnitFacing(caster, AngleBetweenCoordinatesDeg(GetUnitX(caster) , GetUnitY(caster) , (s__UserMouse_mouseX[s__UserMouse__staticgetindex((controller))]) , (s__UserMouse_mouseY[s__UserMouse__staticgetindex((controller))]))) // INLINED!!
    set controller=null
endfunction


function Ray___TriggerActionRefresh takes nothing returns nothing
    local integer i= 0
    local integer max= BlzGroupGetSize(Ray___casters)
    local integer target= 0
    loop
        exitwhen ( i == max )
        set target=LoadInteger(Ray___h, GetHandleId(BlzGroupUnitAt(Ray___casters, i)), 0)
        

        if ( s__Ray___T_mouseAiming[target] ) then
            call Ray___MouseAiming(s__Ray___T_caster[target])
        endif

        
        //call BJDebugMsg("Update target " + I2S(target))
        call Ray___UpdateTarget(target)
        if ( s__Ray___T_loopSound[target] != null and not GetSoundIsPlaying(s__Ray___T_loopSound[target]) ) then
            //call BJDebugMsg("Play sound.")
            call PlaySoundOnUnitBJ(s__Ray___T_loopSound[target], 100.0, s__Ray___T_caster[target])
        endif
        if ( s__Ray___T_u[target] != null ) then
            call RayConfig_OnHitUnit(s__Ray___T_caster[target] , s__Ray___T_u[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target])
            
            if ( s__Ray___T_hitSound[target] != null and not GetSoundIsPlaying(s__Ray___T_hitSound[target]) ) then
                call PlaySoundOnUnitBJ(s__Ray___T_hitSound[target], 100.0, s__Ray___T_u[target])
            endif
                
            if ( RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]) != null and s__Ray___T_targetEffect[target] == null ) then
                set s__Ray___T_targetEffect[target]=AddSpecialEffectTarget(RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]), s__Ray___T_u[target], RayConfig_GetTargetEffectAttachmentPoint(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]))
            endif
            
            call BlzSetSpecialEffectX(s__Ray___T_targetEffect[target], GetUnitX(s__Ray___T_u[target]))
            call BlzSetSpecialEffectY(s__Ray___T_targetEffect[target], GetUnitY(s__Ray___T_u[target]))
            call BlzSetSpecialEffectY(s__Ray___T_targetEffect[target], BlzGetUnitZ(s__Ray___T_u[target]) + GetUnitFlyHeight(s__Ray___T_u[target]))
        elseif ( s__Ray___T_d[target] != null ) then
            call RayConfig_OnHitDestructable(s__Ray___T_caster[target] , s__Ray___T_d[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target])
            
            if ( s__Ray___T_hitSound[target] != null ) then
                if ( not GetSoundIsPlaying(s__Ray___T_hitSound[target]) ) then
                    call StartSound(s__Ray___T_hitSound[target])
                    call SetSoundVolume(s__Ray___T_hitSound[target], 127)
                endif
                call SetSoundPosition(s__Ray___T_hitSound[target], s__Ray___T_x[target], s__Ray___T_y[target], s__Ray___T_z[target])
            endif
            
            if ( RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]) != null and s__Ray___T_targetEffect[target] == null ) then
                set s__Ray___T_targetEffect[target]=AddSpecialEffect(RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]), GetDestructableX(s__Ray___T_d[target]), GetDestructableY(s__Ray___T_d[target]))
            endif
            
            call BlzSetSpecialEffectX(s__Ray___T_targetEffect[target], GetDestructableX(s__Ray___T_d[target]))
            call BlzSetSpecialEffectY(s__Ray___T_targetEffect[target], GetDestructableY(s__Ray___T_d[target]))
            //call BlzSetSpecialEffectY(target.targetEffect, BlzGetUnitZ(target.u) + GetUnitFlyHeight(target.u))
        elseif ( s__Ray___T_i[target] != null ) then
            call RayConfig_OnHitItem(s__Ray___T_caster[target] , s__Ray___T_i[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target])
            
            if ( s__Ray___T_hitSound[target] != null ) then
                if ( not GetSoundIsPlaying(s__Ray___T_hitSound[target]) ) then
                    call StartSound(s__Ray___T_hitSound[target])
                    call SetSoundVolume(s__Ray___T_hitSound[target], 127)
                endif
                call SetSoundPosition(s__Ray___T_hitSound[target], s__Ray___T_x[target], s__Ray___T_y[target], s__Ray___T_z[target])
            endif
            
            if ( RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]) != null and s__Ray___T_targetEffect[target] == null ) then
                set s__Ray___T_targetEffect[target]=AddSpecialEffect(RayConfig_GetTargetEffect(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]), GetItemX(s__Ray___T_i[target]), GetItemY(s__Ray___T_i[target]))
            endif
            
            call BlzSetSpecialEffectX(s__Ray___T_targetEffect[target], GetItemX(s__Ray___T_i[target]))
            call BlzSetSpecialEffectY(s__Ray___T_targetEffect[target], GetItemY(s__Ray___T_i[target]))
            //call BlzSetSpecialEffectY(target.targetEffect, BlzGetUnitZ(target.u) + GetUnitFlyHeight(target.u))
        endif
        
        if ( not RayConfig_OnCastLoop(s__Ray___T_caster[target] , s__Ray___T_abilityId[target] , s__Ray___T_duration[target]) ) then
            call Ray___EndRay(s__Ray___T_caster[target])
        endif

        set i=i + 1
    endloop
endfunction  

function Ray___TimerFunctionRefresh takes nothing returns nothing
    // allows using trigger sleep actions
    call TriggerExecute(Ray___refreshTrigger)
endfunction

function Ray___TimerFunctionExpire takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local integer target= LoadInteger(Ray___h, handleId, 0)
    
    call Ray___EndRay(s__Ray___T_caster[target])
    
    call FlushChildHashtable(Ray___h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function Ray_GetCastingRayAbilityId takes unit caster returns integer
    local integer handleId= GetHandleId(caster)
    local integer target= LoadInteger(Ray___h, handleId, 0)
    
    if ( target == 0 ) then
        return 0
    endif
    
    return s__Ray___T_abilityId[target]
endfunction

function Ray_IsCastingRay takes unit caster,integer abilityId returns boolean
    return Ray_GetCastingRayAbilityId(caster) == abilityId
endfunction

function Ray_IsCastingAnyRay takes unit caster returns boolean
    local integer handleId= GetHandleId(caster)
    local integer target= LoadInteger(Ray___h, handleId, 0)
    
    return target != 0
endfunction

function Ray___Ray takes unit caster,integer abilityId returns nothing
    local real x= GetUnitX(caster)
    local real y= GetUnitY(caster)
    local real face= GetUnitFacing(caster)
    local integer handleId= GetHandleId(caster)
    local integer target= LoadInteger(Ray___h, handleId, 0)
    local real duration= RayConfig_GetDuration(caster , abilityId)
    local integer i= 0
    if ( target == 0 ) then
        set target=s__Ray___T__allocate()
        set s__Ray___T_t[target]=CreateTimer()
        set s__Ray___T_caster[target]=caster
        call SaveInteger(Ray___h, handleId, 0, target)
        set handleId=GetHandleId(s__Ray___T_t[target])
        call SaveInteger(Ray___h, handleId, 0, target)
    endif
    
    set s__Ray___T_duration[target]=0.0
    set s__Ray___T_disableAttack[target]=RayConfig_DisableAttack(caster , abilityId)
    set s__Ray___T_disableMovement[target]=RayConfig_GetDisableMovement(caster , abilityId)
    set s__Ray___T_mouseAiming[target]=RayConfig_GetMouseAiming(caster , abilityId)
    
    set s__Ray___T_maxLightnings[target]=RayConfig_GetMaxLightnings(caster , abilityId)
    set i=0
    loop
        exitwhen ( i == s__Ray___T_maxLightnings[target] )
        set s___Ray___T_l[s__Ray___T_l[target]+i]=AddLightning(RayConfig_GetLightningCode(caster , abilityId , i), true, x, y, x, y)
        set i=i + 1
    endloop
    
    if ( RayConfig_GetCasterEffect(caster , abilityId , s__Ray___T_duration[target]) != null ) then
        set s__Ray___T_casterEffect[target]=AddSpecialEffectTarget(RayConfig_GetCasterEffect(caster , abilityId , s__Ray___T_duration[target]), caster, RayConfig_GetCasterEffectAttachmentPoint(caster , abilityId , s__Ray___T_duration[target]))
    endif
    
    call Ray___UpdateTarget(target)
    set s__Ray___T_abilityId[target]=abilityId
    set s__Ray___T_loopSound[target]=RayConfig_GetLoopSound(caster , abilityId)
    set s__Ray___T_hitSound[target]=RayConfig_GetHitSound(caster , abilityId)
    set s__Ray___T_maxDistance[target]=RayConfig_GetMaxDistance(caster , abilityId)
    set s__Ray___T_range[target]=RayConfig_GetRange(caster , abilityId)
    
    if ( not IsUnitInGroup(caster, Ray___casters) ) then
        call GroupAddUnit(Ray___casters, caster)
        
        if ( BlzGroupGetSize(Ray___casters) == 1 ) then
            call TimerStart(Ray___refreshTimer, RayConfig_REFRESH_INTERVAL, true, function Ray___TimerFunctionRefresh)
        endif
    endif
    
    if ( duration > 0.0 ) then
        call TimerStart(s__Ray___T_t[target], duration, false, function Ray___TimerFunctionExpire)
    endif
endfunction

function Ray___TriggerConditionCast takes nothing returns boolean
    local unit caster= GetTriggerUnit()
    local integer abilityId= GetSpellAbilityId()
    local integer target= 0
    if ( RayConfig_IsValidAbility(abilityId) ) then
        if ( Ray_IsCastingRay(caster , abilityId) and RayConfig_GetHoldKey(caster , abilityId) ) then
            set target=LoadInteger(Ray___h, GetHandleId(caster), 0)
            //call BJDebugMsg("Renew " + GetObjectName(target.abilityId) + " with duration " + R2S(RayConfig_GetDuration(caster, target.abilityId)))
            call TimerStart(s__Ray___T_t[target], RayConfig_GetDuration(caster , s__Ray___T_abilityId[target]), false, function Ray___TimerFunctionExpire)
            call DisableTrigger(Ray___orderTrigger)
            call IssueImmediateOrder(caster, "stop")
            call EnableTrigger(Ray___orderTrigger)
            return false
        endif
    

        if ( Ray_IsCastingRay(caster , abilityId) ) then
            call Ray___EndRay(caster)
        else
            if ( Ray_IsCastingAnyRay(caster) ) then
                call Ray___EndRay(caster)
            endif
            call Ray___Ray(caster , abilityId)
        endif






    endif
    set caster=null
    return false
endfunction

function Ray___TriggerConditionDeath takes nothing returns boolean
    local unit caster= GetTriggerUnit()
    if ( Ray_IsCastingAnyRay(caster) ) then
        call Ray___EndRay(caster)
    endif
    set caster=null
    return false
endfunction

function Ray___TriggerConditionOrder takes nothing returns boolean
    local integer orderId= GetIssuedOrderId()
    local unit caster= GetTriggerUnit()
    //call BJDebugMsg("Order " + I2S(orderId))
    if ( Ray_IsCastingAnyRay(caster) ) then
        //call BJDebugMsg("Check 1")
        if ( orderId == Ray_ORDER_ID_STOP ) then
            //call BJDebugMsg("Stop")
            call Ray___EndRay(caster)
        endif
    endif
    set caster=null
    return true
endfunction

function Ray___TimerFunctionChangeFacing takes nothing returns nothing
    local timer t= GetExpiredTimer()
    local integer handleId= GetHandleId(t)
    local unit caster= LoadUnitHandle(Ray___h, handleId, 0)
    local integer abilityId= LoadInteger(Ray___h, handleId, 1)
    local real x= LoadReal(Ray___h, handleId, 2)
    local real y= LoadReal(Ray___h, handleId, 3)
    if ( GetUnitTypeId(caster) != 0 and Ray_GetCastingRayAbilityId(caster) == abilityId ) then
        call DisableTrigger(Ray___orderTrigger)
        call IssueImmediateOrder(caster, "stop")
        call EnableTrigger(Ray___orderTrigger)
        call SetUnitFacing(caster, AngleBetweenCoordinatesDeg(GetUnitX(caster) , GetUnitY(caster) , x , y))
    endif
    call FlushChildHashtable(Ray___h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
    set caster=null
endfunction

function Ray___TimedChangeFacing takes unit caster,integer abilityId,real x,real y returns nothing
    local timer t= CreateTimer()
    local integer handleId= GetHandleId(t)
    call SaveUnitHandle(Ray___h, handleId, 0, caster)
    call SaveInteger(Ray___h, handleId, 1, abilityId)
    call SaveReal(Ray___h, handleId, 2, x)
    call SaveReal(Ray___h, handleId, 3, y)
    //call BJDebugMsg("Start time changed facing")
    call TimerStart(t, 0.0, false, function Ray___TimerFunctionChangeFacing)
endfunction

function Ray___TriggerActionOrder takes nothing returns nothing
    local trigger whichTrigger= GetTriggeringTrigger()
    local integer orderId= GetIssuedOrderId()
    local unit caster= GetTriggerUnit()
    //call BJDebugMsg("Order " + I2S(orderId))
    if ( Ray_IsCastingAnyRay(caster) ) then
        //call BJDebugMsg("Check 2")
        if ( ( orderId == Ray_ORDER_ID_MOVE or orderId == Ray_ORDER_ID_SMART ) and RayConfig_GetDisableMovement(caster , Ray_GetCastingRayAbilityId(caster)) ) then
            call Ray___TimedChangeFacing(caster , Ray_GetCastingRayAbilityId(caster) , GetOrderPointX() , GetOrderPointY())
            //call BJDebugMsg("Change facing")
        endif
    endif
    set caster=null
    set whichTrigger=null
endfunction

function Ray___TriggerConditionAttack takes nothing returns boolean
    local integer handleId= GetHandleId(GetAttacker())
    local integer t= LoadInteger(Ray___h, handleId, 0)
    if ( t != 0 and s__Ray___T_disableAttack[t] ) then
        call BlzUnitInterruptAttack(GetAttacker())
    endif
    return false
endfunction

function Ray___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(Ray___castTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(Ray___castTrigger, Condition(function Ray___TriggerConditionCast))
    call TriggerRegisterAnyUnitEventBJ(Ray___deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(Ray___deathTrigger, Condition(function Ray___TriggerConditionDeath))
    call TriggerRegisterAnyUnitEventBJ(Ray___orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(Ray___orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(Ray___orderTrigger, Condition(function Ray___TriggerConditionOrder))
    call TriggerAddAction(Ray___orderTrigger, function Ray___TriggerActionOrder)
    call TriggerRegisterAnyUnitEventBJ(Ray___attackTrigger, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(Ray___attackTrigger, Condition(function Ray___TriggerConditionAttack))
    call TriggerAddAction(Ray___refreshTrigger, function Ray___TriggerActionRefresh)
    
    set Ray___filterIsClosestUnit=Filter(function Ray___FilterIsClosestUnit)
    set Ray___filterIsClosestDestructable=Filter(function Ray___FilterIsClosestDestructable)
    set Ray___filterIsClosestItem=Filter(function Ray___FilterIsClosestItem)
endfunction

function Ray___RemoveUnitHook takes unit whichUnit returns nothing
    if ( Ray_IsCastingAnyRay(whichUnit) ) then
        call Ray___EndRay(whichUnit)
    endif
endfunction

//processed hook: hook RemoveUnit Ray___RemoveUnitHook


//library Ray ends
//===========================================================================
// 
// Baradé's Ray 1.0
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
//*  MouseUtils


//***************************************************************************
//*  Barades Tree Utils
//***************************************************************************
//*  Barades Math Utils
//***************************************************************************
//*  Barades Ray Config
//***************************************************************************
//*  Barades Ray

//***************************************************************************
//*
//*  Sound Assets
//*
//***************************************************************************

function InitSounds takes nothing returns nothing
    set gg_snd_BlueFireBurstLoop=CreateSound("Sound/Ambient/DoodadEffects/BlueFireBurstLoop.flac", true, true, true, 0, 0, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_BlueFireBurstLoop, "BlueFireLoop")
    call SetSoundDuration(gg_snd_BlueFireBurstLoop, 4000)
    call SetSoundVolume(gg_snd_BlueFireBurstLoop, 127)
    set gg_snd_BreathOfFrost1=CreateSound("Abilities/Spells/Other/BreathOfFrost/BreathOfFrost1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_BreathOfFrost1, "BreathOfFrost")
    call SetSoundDuration(gg_snd_BreathOfFrost1, 2234)
    call SetSoundVolume(gg_snd_BreathOfFrost1, 127)
    set gg_snd_HealTarget=CreateSound("Abilities/Spells/Human/Heal/HealTarget.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_HealTarget, "Heal")
    call SetSoundDuration(gg_snd_HealTarget, 1398)
    call SetSoundVolume(gg_snd_HealTarget, 110)
    set gg_snd_HolyBolt=CreateSound("Abilities/Spells/Human/HolyBolt/HolyBolt.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_HolyBolt, "HolyBolt")
    call SetSoundDuration(gg_snd_HolyBolt, 1590)
    call SetSoundVolume(gg_snd_HolyBolt, 127)
    set gg_snd_ImmolationTarget1=CreateSound("Abilities/Spells/NightElf/Immolation/ImmolationTarget1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ImmolationTarget1, "ImmolationTarget")
    call SetSoundDuration(gg_snd_ImmolationTarget1, 3204)
    call SetSoundVolume(gg_snd_ImmolationTarget1, 127)
    set gg_snd_LifeDrain=CreateSound("Abilities/Spells/Other/Drain/LifeDrain.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_LifeDrain, "DrainLoop")
    call SetSoundDuration(gg_snd_LifeDrain, 2490)
    call SetSoundVolume(gg_snd_LifeDrain, 127)
    set gg_snd_MagicLariatLoop1=CreateSound("Abilities/Spells/Human/AerialShackles/MagicLariatLoop1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_MagicLariatLoop1, "AerialShacklesLoop")
    call SetSoundDuration(gg_snd_MagicLariatLoop1, 3230)
    call SetSoundVolume(gg_snd_MagicLariatLoop1, 127)
    set gg_snd_MagicWallLoop1=CreateSound("Doodads/Dungeon/Props/Forcewall/MagicWallLoop1.flac", true, true, true, 0, 0, "DoodadsEAX")
    call SetSoundParamsFromLabel(gg_snd_MagicWallLoop1, "Cine_ForceWallLoop")
    call SetSoundDuration(gg_snd_MagicWallLoop1, 7319)
    call SetSoundVolume(gg_snd_MagicWallLoop1, 120)
    set gg_snd_MonsoonRainLoop=CreateSound("Abilities/Spells/Other/Monsoon/MonsoonRainLoop.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_MonsoonRainLoop, "MonsoonLoop")
    call SetSoundDuration(gg_snd_MonsoonRainLoop, 1622)
    call SetSoundVolume(gg_snd_MonsoonRainLoop, 127)
    set gg_snd_RainOfFireLoop1=CreateSound("Abilities/Spells/Demon/RainOfFire/RainOfFireLoop1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_RainOfFireLoop1, "RainOfFireLoop")
    call SetSoundDuration(gg_snd_RainOfFireLoop1, 4000)
    call SetSoundVolume(gg_snd_RainOfFireLoop1, 127)
    set gg_snd_ShimmeringPortalLoop=CreateSound("Doodads/Cinematic/ShimmeringPortal/ShimmeringPortalLoop.flac", true, true, true, 0, 0, "DoodadsEAX")
    call SetSoundParamsFromLabel(gg_snd_ShimmeringPortalLoop, "Cine_ShimmeringPortalLoop")
    call SetSoundDuration(gg_snd_ShimmeringPortalLoop, 7441)
    call SetSoundVolume(gg_snd_ShimmeringPortalLoop, 32)
    set gg_snd_WaterWaterFallLoop1=CreateSound("Sound/Ambient/DoodadEffects/WaterWaterFallLoop1.flac", true, true, true, 0, 0, "DoodadsEAX")
    call SetSoundParamsFromLabel(gg_snd_WaterWaterFallLoop1, "WaterfallLoop")
    call SetSoundDuration(gg_snd_WaterWaterFallLoop1, 1021)
    call SetSoundVolume(gg_snd_WaterWaterFallLoop1, 120)
    set gg_snd_FreezingBreathTarget1=CreateSound("Abilities/Spells/Undead/FreezingBreath/FreezingBreathTarget1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FreezingBreathTarget1, "FreezingBreath")
    call SetSoundDuration(gg_snd_FreezingBreathTarget1, 2832)
    call SetSoundVolume(gg_snd_FreezingBreathTarget1, 127)
    set gg_snd_Incinerate1=CreateSound("Abilities/Spells/Other/Incinerate/Incinerate1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_Incinerate1, "IncinerateDeath")
    call SetSoundDuration(gg_snd_Incinerate1, 2716)
    call SetSoundVolume(gg_snd_Incinerate1, 127)
    set gg_snd_Tranquility=CreateSound("Abilities/Spells/NightElf/Tranquility/Tranquility.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_Tranquility, "Tranquility")
    call SetSoundDuration(gg_snd_Tranquility, 3572)
    call SetSoundVolume(gg_snd_Tranquility, 127)
    set gg_snd_CycloneLoop1=CreateSound("Abilities/Spells/NightElf/Cyclone/CycloneLoop1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_CycloneLoop1, "CycloneLoop")
    call SetSoundDuration(gg_snd_CycloneLoop1, 4003)
    call SetSoundVolume(gg_snd_CycloneLoop1, 127)
    set gg_snd_RaiseSkeleton=CreateSound("Abilities/Spells/Undead/RaiseSkeletonWarrior/RaiseSkeleton.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_RaiseSkeleton, "RaiseSkeletonWarrior")
    call SetSoundDuration(gg_snd_RaiseSkeleton, 2329)
    call SetSoundVolume(gg_snd_RaiseSkeleton, 127)
    set gg_snd_MineDomeLoop1=CreateSound("Abilities/Spells/Undead/UndeadMine/MineDomeLoop1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_MineDomeLoop1, "MineDomeLoop")
    call SetSoundDuration(gg_snd_MineDomeLoop1, 1869)
    call SetSoundVolume(gg_snd_MineDomeLoop1, 60)
    set gg_snd_CharmTarget1=CreateSound("Abilities/Spells/Items/AIco/CharmTarget1.flac", false, true, true, 0, 0, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_CharmTarget1, "Charm")
    call SetSoundDuration(gg_snd_CharmTarget1, 2681)
    call SetSoundVolume(gg_snd_CharmTarget1, 127)
endfunction

//***************************************************************************
//*
//*  Items
//*
//***************************************************************************

function CreateAllItems takes nothing returns nothing
    local integer itemID

    call BlzCreateItemWithSkin('blba', 2356.3, - 2707.9, 'blba')
    call BlzCreateItemWithSkin('blba', 1953.2, - 2443.1, 'blba')
    call BlzCreateItemWithSkin('blba', 1909.1, - 2340.1, 'blba')
    call BlzCreateItemWithSkin('blba', 1860.8, - 2157.5, 'blba')
    call BlzCreateItemWithSkin('blba', 1912.5, - 1996.7, 'blba')
    call BlzCreateItemWithSkin('blba', 2037.9, - 1845.3, 'blba')
    call BlzCreateItemWithSkin('blba', 2248.3, - 1703.9, 'blba')
    call BlzCreateItemWithSkin('blba', 2381.2, - 1622.8, 'blba')
    call BlzCreateItemWithSkin('blba', 2451.7, - 1603.2, 'blba')
    call BlzCreateItemWithSkin('blba', 2602.3, - 1590.1, 'blba')
    call BlzCreateItemWithSkin('blba', 2716.3, - 1581.3, 'blba')
    call BlzCreateItemWithSkin('blba', 2679.9, - 1799.0, 'blba')
    call BlzCreateItemWithSkin('blba', 2504.8, - 2206.6, 'blba')
    call BlzCreateItemWithSkin('blba', 2463.1, - 2323.6, 'blba')
    call BlzCreateItemWithSkin('blba', 2462.2, - 2425.7, 'blba')
    call BlzCreateItemWithSkin('blba', 2466.9, - 2496.1, 'blba')
    call BlzCreateItemWithSkin('blba', 2099.4, - 2863.1, 'blba')
    call BlzCreateItemWithSkin('blba', 1985.0, - 3031.4, 'blba')
    call BlzCreateItemWithSkin('blba', 1750.5, - 3119.3, 'blba')
    call BlzCreateItemWithSkin('blba', 1571.1, - 3126.2, 'blba')
    call BlzCreateItemWithSkin('blba', 1336.2, - 2110.5, 'blba')
    call BlzCreateItemWithSkin('blba', 1271.1, - 2098.0, 'blba')
    call BlzCreateItemWithSkin('blba', 1094.4, - 2125.2, 'blba')
    call BlzCreateItemWithSkin('blba', 788.5, - 2217.2, 'blba')
    call BlzCreateItemWithSkin('blba', 610.7, - 2215.2, 'blba')
    call BlzCreateItemWithSkin('blba', 437.9, - 2055.6, 'blba')
    call BlzCreateItemWithSkin('blba', 269.3, - 1852.0, 'blba')
    call BlzCreateItemWithSkin('blba', 154.9, - 1748.6, 'blba')
    call BlzCreateItemWithSkin('blba', 72.6, - 1537.8, 'blba')
    call BlzCreateItemWithSkin('blba', 325.6, - 1415.7, 'blba')
    call BlzCreateItemWithSkin('blba', 821.6, - 1397.5, 'blba')
    call BlzCreateItemWithSkin('blba', 954.3, - 1370.9, 'blba')
    call BlzCreateItemWithSkin('blba', 1039.2, - 1300.3, 'blba')
    call BlzCreateItemWithSkin('blba', - 114.1, - 1778.3, 'blba')
    call BlzCreateItemWithSkin('blba', - 326.7, - 1653.5, 'blba')
    call BlzCreateItemWithSkin('blba', - 421.0, - 1532.9, 'blba')
    call BlzCreateItemWithSkin('blba', - 528.5, - 1481.5, 'blba')
    call BlzCreateItemWithSkin('blba', - 675.5, - 1484.8, 'blba')
    call BlzCreateItemWithSkin('blba', - 763.3, - 1564.4, 'blba')
    call BlzCreateItemWithSkin('blba', - 786.2, - 1632.3, 'blba')
    call BlzCreateItemWithSkin('blba', - 832.6, - 1779.7, 'blba')
    call BlzCreateItemWithSkin('blba', - 898.0, - 1834.7, 'blba')
    call BlzCreateItemWithSkin('blba', - 200.3, - 1348.2, 'blba')
    call BlzCreateItemWithSkin('blba', - 86.8, - 1380.5, 'blba')
    call BlzCreateItemWithSkin('blba', 6.8, - 1353.3, 'blba')
    call BlzCreateItemWithSkin('blba', 172.1, - 1019.5, 'blba')
endfunction

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

    set gg_unit_Hblm_0000=BlzCreateUnitWithSkin(p, 'Hblm', - 448.7, - 73.3, 284.240, 'Hblm')
    call SetHeroLevel(gg_unit_Hblm_0000, 20, false)
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A005')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A005')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A005')
    call IssueImmediateOrder(gg_unit_Hblm_0000, "")
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A000')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A000')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A000')
    call IssueImmediateOrder(gg_unit_Hblm_0000, "")
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A001')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A001')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A001')
    call IssueImmediateOrder(gg_unit_Hblm_0000, "")
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A002')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A002')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A002')
    call IssueImmediateOrder(gg_unit_Hblm_0000, "")
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A003')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A003')
    call SelectHeroSkill(gg_unit_Hblm_0000, 'A003')
    call IssueImmediateOrder(gg_unit_Hblm_0000, "")
    set u=BlzCreateUnitWithSkin(p, 'Hamg', - 462.8, 49.7, 270.000, 'Hamg')
    call SetHeroLevel(u, 20, false)
    call SelectHeroSkill(u, 'A007')
    call SelectHeroSkill(u, 'A007')
    call SelectHeroSkill(u, 'A007')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A008')
    call SelectHeroSkill(u, 'A008')
    call SelectHeroSkill(u, 'A008')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A009')
    call SelectHeroSkill(u, 'A009')
    call SelectHeroSkill(u, 'A009')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00A')
    call SelectHeroSkill(u, 'A00A')
    call SelectHeroSkill(u, 'A00A')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00C')
    call SelectHeroSkill(u, 'A00C')
    call SelectHeroSkill(u, 'A00C')
    call IssueImmediateOrder(u, "")
    set u=BlzCreateUnitWithSkin(p, 'H004', - 555.1, 60.3, 270.000, 'H004')
    call SetHeroLevel(u, 20, false)
    call SelectHeroSkill(u, 'A005')
    call SelectHeroSkill(u, 'A005')
    call SelectHeroSkill(u, 'A005')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00E')
    call SelectHeroSkill(u, 'A00E')
    call SelectHeroSkill(u, 'A00E')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A000')
    call SelectHeroSkill(u, 'A000')
    call SelectHeroSkill(u, 'A000')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00J')
    call SelectHeroSkill(u, 'A00J')
    call SelectHeroSkill(u, 'A00J')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00K')
    call SelectHeroSkill(u, 'A00K')
    call SelectHeroSkill(u, 'A00K')
    call IssueImmediateOrder(u, "")
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hblm_0001=BlzCreateUnitWithSkin(p, 'Hblm', - 64.4, - 64.9, 284.240, 'Hblm')
    call SetHeroLevel(gg_unit_Hblm_0001, 20, false)
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A005')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A005')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A005')
    call IssueImmediateOrder(gg_unit_Hblm_0001, "")
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A000')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A000')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A000')
    call IssueImmediateOrder(gg_unit_Hblm_0001, "")
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A001')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A001')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A001')
    call IssueImmediateOrder(gg_unit_Hblm_0001, "")
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A002')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A002')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A002')
    call IssueImmediateOrder(gg_unit_Hblm_0001, "")
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A003')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A003')
    call SelectHeroSkill(gg_unit_Hblm_0001, 'A003')
    call IssueImmediateOrder(gg_unit_Hblm_0001, "")
    set u=BlzCreateUnitWithSkin(p, 'Hamg', - 68.5, 59.4, 270.000, 'Hamg')
    call SetHeroLevel(u, 20, false)
    call SelectHeroSkill(u, 'A007')
    call SelectHeroSkill(u, 'A007')
    call SelectHeroSkill(u, 'A007')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A008')
    call SelectHeroSkill(u, 'A008')
    call SelectHeroSkill(u, 'A008')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A009')
    call SelectHeroSkill(u, 'A009')
    call SelectHeroSkill(u, 'A009')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00A')
    call SelectHeroSkill(u, 'A00A')
    call SelectHeroSkill(u, 'A00A')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00C')
    call SelectHeroSkill(u, 'A00C')
    call SelectHeroSkill(u, 'A00C')
    call IssueImmediateOrder(u, "")
    set u=BlzCreateUnitWithSkin(p, 'H004', - 161.1, 50.5, 270.000, 'H004')
    call SetHeroLevel(u, 20, false)
    call SelectHeroSkill(u, 'A005')
    call SelectHeroSkill(u, 'A005')
    call SelectHeroSkill(u, 'A005')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00E')
    call SelectHeroSkill(u, 'A00E')
    call SelectHeroSkill(u, 'A00E')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A000')
    call SelectHeroSkill(u, 'A000')
    call SelectHeroSkill(u, 'A000')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00J')
    call SelectHeroSkill(u, 'A00J')
    call SelectHeroSkill(u, 'A00J')
    call IssueImmediateOrder(u, "")
    call SelectHeroSkill(u, 'A00K')
    call SelectHeroSkill(u, 'A00K')
    call SelectHeroSkill(u, 'A00K')
    call IssueImmediateOrder(u, "")
endfunction

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nftr', - 2733.7, 868.1, 137.828, 'nftr')
    set u=BlzCreateUnitWithSkin(p, 'nfsp', - 2652.7, 910.5, 135.839, 'nfsp')
    set u=BlzCreateUnitWithSkin(p, 'nfsp', - 2867.9, 892.0, 78.038, 'nfsp')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2211.3, - 2704.6, 19.545, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2374.4, - 2696.3, 99.023, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2317.2, - 2357.7, 42.837, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2125.5, - 2472.9, 301.287, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2005.0, - 2606.5, 352.430, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 1999.0, - 2809.9, 280.468, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2345.0, - 2900.4, 0.978, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2430.9, - 2567.6, 108.746, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2298.4, - 2541.6, 16.304, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskg', - 2589.1, - 2338.6, 183.565, 'nskg')
    set u=BlzCreateUnitWithSkin(p, 'nskf', - 2670.5, - 2670.6, 329.842, 'nskf')
    set u=BlzCreateUnitWithSkin(p, 'nskf', - 2365.3, - 3086.7, 167.832, 'nskf')
    set u=BlzCreateUnitWithSkin(p, 'nskf', - 2272.6, - 3124.2, 231.994, 'nskf')
    set u=BlzCreateUnitWithSkin(p, 'nskf', - 2193.0, - 3118.1, 104.593, 'nskf')
    set u=BlzCreateUnitWithSkin(p, 'nskf', - 1954.1, - 3094.8, 46.210, 'nskf')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 1741.4, - 2993.9, 204.857, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 1780.0, - 2780.6, 11.514, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 1818.0, - 2715.6, 285.587, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 1891.0, - 2468.6, 100.187, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nska', - 2091.7, - 2347.6, 133.543, 'nska')
    set u=BlzCreateUnitWithSkin(p, 'nrdk', - 286.6, - 3143.2, 277.721, 'nrdk')
    set u=BlzCreateUnitWithSkin(p, 'nrdk', - 616.5, - 2966.6, 298.826, 'nrdk')
    set u=BlzCreateUnitWithSkin(p, 'nrdk', - 344.3, - 2817.0, 307.725, 'nrdk')
    set u=BlzCreateUnitWithSkin(p, 'nrdr', 376.2, - 3160.9, 339.037, 'nrdr')
    set u=BlzCreateUnitWithSkin(p, 'nrdr', - 89.2, - 2950.6, 216.679, 'nrdr')
    set u=BlzCreateUnitWithSkin(p, 'nrdr', 126.4, - 2593.6, 93.266, 'nrdr')
    set u=BlzCreateUnitWithSkin(p, 'nrwm', - 73.3, - 3421.2, 338.016, 'nrwm')
    set u=BlzCreateUnitWithSkin(p, 'nrwm', - 611.4, - 3356.3, 130.609, 'nrwm')
    set u=BlzCreateUnitWithSkin(p, 'nahy', 2826.7, 616.2, 8.581, 'nahy')
    set u=BlzCreateUnitWithSkin(p, 'nahy', 2775.8, 1049.5, 254.111, 'nahy')
    set u=BlzCreateUnitWithSkin(p, 'nahy', 3089.4, 163.3, 327.721, 'nahy')
    set u=BlzCreateUnitWithSkin(p, 'nahy', 3074.1, 900.5, 123.062, 'nahy')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_ntav_0036=BlzCreateUnitWithSkin(p, 'ntav', - 320.0, 256.0, 270.000, 'ntav')
    call SetUnitColor(gg_unit_ntav_0036, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'ngol', - 384.0, - 2048.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 896.0, - 1792.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 1408.0, - 1152.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 576.0, - 2560.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 1280.0, - 2560.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
endfunction

//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'nvlk', 450.5, 387.8, 134.158, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', 294.4, 513.8, 132.016, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', 141.7, 580.3, 214.789, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 504.3, 613.3, 329.820, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 740.5, 444.3, 228.039, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 295.3, 800.6, 147.463, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 501.1, 944.4, 145.354, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 167.6, 1020.5, 121.941, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 399.6, 1006.9, 115.305, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 613.4, 1077.8, 43.727, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1204.1, 127.5, 326.688, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 986.0, - 175.9, 133.444, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 792.2, - 338.7, 157.032, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1232.3, - 325.2, 298.969, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1399.9, - 104.1, 236.400, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1317.0, - 63.9, 349.365, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvil', 256.7, - 638.5, 213.735, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 15.7, - 692.1, 81.796, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 172.6, - 692.1, 326.381, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 325.1, - 514.8, 211.878, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', 648.8, 115.4, 85.487, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 65.2, 538.2, 192.080, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 58.9, 735.1, 288.279, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', 873.2, 228.9, 340.751, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', 532.1, - 63.8, 100.572, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', 203.1, - 372.3, 324.920, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', 110.4, - 745.8, 90.442, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 352.7, - 666.3, 332.676, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 602.9, - 515.5, 73.896, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 966.3, - 328.3, 34.333, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1287.3, - 475.1, 134.642, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1490.0, - 18.1, 349.716, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 2190.6, 1896.9, 54.823, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 2375.1, 2049.7, 272.667, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 2359.1, 2340.5, 215.185, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 2163.9, 2319.8, 127.237, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 1937.2, 2046.3, 97.507, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 1844.5, 1876.6, 308.462, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 1668.3, 1755.3, 118.623, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 1649.1, 1550.0, 254.396, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 1775.8, 1370.4, 75.874, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvlk', - 2129.3, 1498.4, 46.902, 'nvlk')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 1825.1, 1671.4, 244.607, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 2143.4, 1761.2, 90.124, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 1945.5, 1901.7, 232.434, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 2194.3, 2073.3, 274.897, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 2401.4, 2233.0, 350.178, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 2675.2, 2314.1, 188.916, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvk2', - 2790.6, 2121.3, 98.155, 'nvk2')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 2533.8, 1821.2, 239.465, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 2507.2, 2147.4, 353.496, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 2222.9, 2350.0, 122.633, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 2386.4, 2539.6, 32.059, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1726.7, 1896.9, 132.521, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1541.2, 1748.0, 46.331, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1436.7, 1601.6, 184.653, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1699.8, 1401.4, 229.962, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvlw', - 1921.5, 1398.9, 200.693, 'nvlw')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 2030.2, 2156.2, 35.014, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 1946.0, 2276.9, 127.577, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvil', - 2434.7, 2133.5, 77.862, 'nvil')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 2574.5, 2476.8, 275.622, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 2439.5, 1777.6, 121.029, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 2260.1, 1579.7, 83.301, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1745.1, 1242.1, 78.994, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 2006.8, 1273.4, 129.621, 'nvl2')
    set u=BlzCreateUnitWithSkin(p, 'nvl2', - 1479.7, 1280.4, 9.174, 'nvl2')
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
    call CreateNeutralPassive()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Initialization
//
// Default melee game initialization for all players
//===========================================================================
function Trig_Initialization_Func005Func001C takes nothing returns boolean
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) == 'LTex' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Initialization_Func005A takes nothing returns nothing
    if ( Trig_Initialization_Func005Func001C() ) then
        call TriggerRegisterDeathEvent(gg_trg_Barrel_Explodes, GetEnumDestructable())
    else
        call DoNothing()
    endif
endfunction

function Trig_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call MeleeStartingResources()
    call EnumDestructablesInRectAll(GetPlayableMapRect(), function Trig_Initialization_Func005A)
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Start
//===========================================================================
function Trig_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call FogMaskEnableOff()
    call SelectUnitForPlayerSingle(gg_unit_Hblm_0000, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hblm_0001, Player(1))
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_290")
endfunction

//===========================================================================
function InitTrig_Start takes nothing returns nothing
    set gg_trg_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Start, 0.00)
    call TriggerAddAction(gg_trg_Start, function Trig_Start_Actions)
endfunction

//===========================================================================
// Trigger: Revive Player 1
//===========================================================================
function Trig_Revive_Player_1_Func002001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_Revive_Player_1_Func002A takes nothing returns nothing
    call ReviveHeroLoc(GetEnumUnit(), GetPlayerStartLocationLoc(Player(0)), true)
    call SetUnitLifePercentBJ(GetEnumUnit(), 100)
    call SetUnitManaPercentBJ(GetEnumUnit(), 100)
endfunction

function Trig_Revive_Player_1_Actions takes nothing returns nothing
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsOfPlayerMatching(Player(0), Condition(function Trig_Revive_Player_1_Func002001002)), function Trig_Revive_Player_1_Func002A)
endfunction

//===========================================================================
function InitTrig_Revive_Player_1 takes nothing returns nothing
    set gg_trg_Revive_Player_1=CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Revive_Player_1, Player(0))
    call TriggerAddAction(gg_trg_Revive_Player_1, function Trig_Revive_Player_1_Actions)
endfunction

//===========================================================================
// Trigger: Revive Player 2
//===========================================================================
function Trig_Revive_Player_2_Func002001002 takes nothing returns boolean
    return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
endfunction

function Trig_Revive_Player_2_Func002A takes nothing returns nothing
    call ReviveHeroLoc(GetEnumUnit(), GetPlayerStartLocationLoc(Player(1)), true)
    call SetUnitLifePercentBJ(GetEnumUnit(), 100)
    call SetUnitManaPercentBJ(GetEnumUnit(), 100)
endfunction

function Trig_Revive_Player_2_Actions takes nothing returns nothing
    set bj_wantDestroyGroup=true
    call ForGroupBJ(GetUnitsOfPlayerMatching(Player(1), Condition(function Trig_Revive_Player_2_Func002001002)), function Trig_Revive_Player_2_Func002A)
endfunction

//===========================================================================
function InitTrig_Revive_Player_2 takes nothing returns nothing
    set gg_trg_Revive_Player_2=CreateTrigger()
    call TriggerRegisterPlayerEventEndCinematic(gg_trg_Revive_Player_2, Player(1))
    call TriggerAddAction(gg_trg_Revive_Player_2, function Trig_Revive_Player_2_Actions)
endfunction

//===========================================================================
// Trigger: Barrel Explodes
//===========================================================================
function Trig_Barrel_Explodes_Actions takes nothing returns nothing
    call UnitDamagePointLoc(gg_unit_ntav_0036, 0, 500, GetDestructableLoc(GetDyingDestructable()), 200.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
endfunction

//===========================================================================
function InitTrig_Barrel_Explodes takes nothing returns nothing
    set gg_trg_Barrel_Explodes=CreateTrigger()
    call TriggerAddAction(gg_trg_Barrel_Explodes, function Trig_Barrel_Explodes_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Start()
    call InitTrig_Revive_Player_1()
    call InitTrig_Revive_Player_2()
    call InitTrig_Barrel_Explodes()
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
    // Force: TRIGSTR_005
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
    call InitSounds()
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs14482906")
call ExecuteFunc("TreeUtils___Init")
call ExecuteFunc("Ray___Init")

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
    call SetMapName("TRIGSTR_001")
    call SetMapDescription("")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 448.0, - 64.0)
    call DefineStartLocation(1, - 64.0, - 64.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype17_RayConfig___RemoveUnitHook takes nothing returns boolean
    call FlushChildHashtable(RayConfig___h, GetHandleId((f__arg_unit1))) // INLINED!!
    return true
endfunction
function sa___prototype17_Ray___RemoveUnitHook takes nothing returns boolean
    call Ray___RemoveUnitHook(f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs14482906 takes nothing returns nothing
    set st___prototype17[1]=CreateTrigger()
    call TriggerAddAction(st___prototype17[1],function sa___prototype17_RayConfig___RemoveUnitHook)
    call TriggerAddCondition(st___prototype17[1],Condition(function sa___prototype17_RayConfig___RemoveUnitHook))
    set st___prototype17[2]=CreateTrigger()
    call TriggerAddAction(st___prototype17[2],function sa___prototype17_Ray___RemoveUnitHook)
    call TriggerAddCondition(st___prototype17[2],Condition(function sa___prototype17_Ray___RemoveUnitHook))

call ExecuteFunc("s__UserMouse_MouseUtils___Init___onInit")



endfunction

