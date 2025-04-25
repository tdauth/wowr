globals
//globals from FrameLoader:
constant boolean LIBRARY_FrameLoader=true
trigger FrameLoader__eventTrigger= CreateTrigger()
trigger FrameLoader__actionTrigger= CreateTrigger()
timer FrameLoader__t= CreateTimer()
//endglobals from FrameLoader
//globals from MathUtils:
constant boolean LIBRARY_MathUtils=true
//endglobals from MathUtils
//globals from OnStartGame:
constant boolean LIBRARY_OnStartGame=true
trigger OnStartGame__startGameTrigger= CreateTrigger()
//endglobals from OnStartGame
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from PlayerColorUtils:
constant boolean LIBRARY_PlayerColorUtils=true
string array PlayerColorUtils__PlayerColorNames
//endglobals from PlayerColorUtils
//globals from Log:
constant boolean LIBRARY_Log=true
constant boolean LOG_CHAT= true
constant boolean LOG_CINEMATIC_TRANSMISSIONS= true
    // This will remove all empty lines at the beginning of a message which helps with SimError.
constant boolean REMOVE_STARTING_EMPTY_LINES= true

constant integer LOG_MAXIMUM= 5000
string array Log__log
integer array Log__logCounter
boolean array Log__logEnabled
integer array Log__logMaximum
    
trigger array Log__callbackTriggers
integer Log__callbackTriggersCounter= 0
player Log__triggerLogPlayer= null
string Log__triggerLogMessage= null
    
string Log__tmpMessage= ""
//endglobals from Log
//globals from LogUI:
constant boolean LIBRARY_LogUI=true
constant boolean LogUI_CHAT_COMMAND_ENABLE= true
constant string LogUI_CHAT_COMMAND_SHORT= "-l"
constant string LogUI_CHAT_COMMAND= "-log"
    
constant boolean LogUI_UPPER_BUTTON_OVERWRITE= true
    
constant boolean LogUI_LOAD_TOC_FILE= true
constant string LogUI_TOC_FILE= "war3mapImported\\LogTOC.toc"

constant real LogUI_FULLSCREEN_HEIGHT= 0.6
constant real LogUI_FULLSCREEN_WIDTH= 0.8

    // UI/FrameDef/UI/LogDialog.fdf
constant real LogUI_WIDTH= 0.384
constant real LogUI_HEIGHT= 0.432
constant real LogUI_X= LogUI_FULLSCREEN_WIDTH / 2.0 - ( LogUI_WIDTH / 2.0 )
constant real LogUI_Y= LogUI_FULLSCREEN_HEIGHT - 0.0335
constant real LogUI_TITLE_X= LogUI_X
constant real LogUI_TITLE_Y= LogUI_Y - 0.028
constant real LogUI_TITLE_HEIGHT= 0.015
    
constant real LogUI_TEXT_AREA_SPACE= 0.02
constant real LogUI_TEXT_AREA_X= LogUI_X + LogUI_TEXT_AREA_SPACE
constant real LogUI_TEXT_AREA_Y= LogUI_TITLE_Y - LogUI_TITLE_HEIGHT - LogUI_TEXT_AREA_SPACE
constant real LogUI_TEXT_AREA_WIDTH= LogUI_WIDTH - 2.0 * LogUI_TEXT_AREA_SPACE
constant real LogUI_TEXT_AREA_HEIGHT= 0.29
    
constant real LogUI_CLOSE_BUTTON_WIDTH= 0.13
constant real LogUI_CLOSE_BUTTON_HEIGHT= 0.035
constant real LogUI_CLOSE_BUTTON_X= LogUI_FULLSCREEN_WIDTH / 2.0 - ( LogUI_CLOSE_BUTTON_WIDTH / 2.0 )
constant real LogUI_CLOSE_BUTTON_Y= LogUI_TEXT_AREA_Y - LogUI_TEXT_AREA_HEIGHT - LogUI_TEXT_AREA_SPACE
    
framehandle LogUI__BackgroundFrame= null
framehandle LogUI__TextAreaFrame= null
    
trigger LogUI__closeTrigger= null
trigger LogUI__clickUpperButtonTrigger= null
trigger LogUI__upperButtonHotkeyTrigger= null
trigger LogUI__chatCommandTrigger= CreateTrigger()
trigger LogUI__logTrigger= CreateTrigger()
//endglobals from LogUI
    // Generated
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Messages= null
unit gg_unit_Hpal_0000= null
unit gg_unit_Hpal_0029= null

trigger l__library_init

//JASSHelper struct globals:
trigger array st___prototype42
trigger array st___prototype43
trigger array st___prototype44
trigger array st___prototype45
trigger array st___prototype46
trigger array st___prototype47
trigger array st___prototype48
trigger array st___prototype49
trigger array st___prototype50
trigger array st___prototype51
trigger array st___prototype52
player f__arg_player1
real f__arg_real1
real f__arg_real2
real f__arg_real3
string f__arg_string1
string f__arg_string2
force f__arg_force1
integer f__arg_integer1
integer f__arg_integer2
unit f__arg_unit1
sound f__arg_sound1
boolean f__arg_boolean1
location f__arg_location1
playercolor f__arg_playercolor1

endglobals

function sc___prototype42_execute takes integer i,player a1,real a2,real a3,string a4 returns nothing
    set f__arg_player1=a1
    set f__arg_real1=a2
    set f__arg_real2=a3
    set f__arg_string1=a4

    call TriggerExecute(st___prototype42[i])
endfunction
function sc___prototype42_evaluate takes integer i,player a1,real a2,real a3,string a4 returns nothing
    set f__arg_player1=a1
    set f__arg_real1=a2
    set f__arg_real2=a3
    set f__arg_string1=a4

    call TriggerEvaluate(st___prototype42[i])

endfunction
function sc___prototype43_execute takes integer i,player a1,real a2,real a3,real a4,string a5 returns nothing
    set f__arg_player1=a1
    set f__arg_real1=a2
    set f__arg_real2=a3
    set f__arg_real3=a4
    set f__arg_string1=a5

    call TriggerExecute(st___prototype43[i])
endfunction
function sc___prototype43_evaluate takes integer i,player a1,real a2,real a3,real a4,string a5 returns nothing
    set f__arg_player1=a1
    set f__arg_real1=a2
    set f__arg_real2=a3
    set f__arg_real3=a4
    set f__arg_string1=a5

    call TriggerEvaluate(st___prototype43[i])

endfunction
function sc___prototype44_execute takes integer i,force a1,string a2 returns nothing
    set f__arg_force1=a1
    set f__arg_string1=a2

    call TriggerExecute(st___prototype44[i])
endfunction
function sc___prototype44_evaluate takes integer i,force a1,string a2 returns nothing
    set f__arg_force1=a1
    set f__arg_string1=a2

    call TriggerEvaluate(st___prototype44[i])

endfunction
function sc___prototype45_execute takes integer i,force a1,real a2,string a3 returns nothing
    set f__arg_force1=a1
    set f__arg_real1=a2
    set f__arg_string1=a3

    call TriggerExecute(st___prototype45[i])
endfunction
function sc___prototype45_evaluate takes integer i,force a1,real a2,string a3 returns nothing
    set f__arg_force1=a1
    set f__arg_real1=a2
    set f__arg_string1=a3

    call TriggerEvaluate(st___prototype45[i])

endfunction
function sc___prototype46_execute takes integer i,force a1,integer a2,string a3 returns nothing
    set f__arg_force1=a1
    set f__arg_integer1=a2
    set f__arg_string1=a3

    call TriggerExecute(st___prototype46[i])
endfunction
function sc___prototype46_evaluate takes integer i,force a1,integer a2,string a3 returns nothing
    set f__arg_force1=a1
    set f__arg_integer1=a2
    set f__arg_string1=a3

    call TriggerEvaluate(st___prototype46[i])

endfunction
function sc___prototype47_execute takes integer i,string a1 returns nothing
    set f__arg_string1=a1

    call TriggerExecute(st___prototype47[i])
endfunction
function sc___prototype47_evaluate takes integer i,string a1 returns nothing
    set f__arg_string1=a1

    call TriggerEvaluate(st___prototype47[i])

endfunction
function sc___prototype48_execute takes integer i,player a1,integer a2,string a3 returns nothing
    set f__arg_player1=a1
    set f__arg_integer1=a2
    set f__arg_string1=a3

    call TriggerExecute(st___prototype48[i])
endfunction
function sc___prototype48_evaluate takes integer i,player a1,integer a2,string a3 returns nothing
    set f__arg_player1=a1
    set f__arg_integer1=a2
    set f__arg_string1=a3

    call TriggerEvaluate(st___prototype48[i])

endfunction
function sc___prototype49_execute takes integer i,force a1,unit a2,string a3,sound a4,string a5,integer a6,real a7,boolean a8 returns nothing
    set f__arg_force1=a1
    set f__arg_unit1=a2
    set f__arg_string1=a3
    set f__arg_sound1=a4
    set f__arg_string2=a5
    set f__arg_integer1=a6
    set f__arg_real1=a7
    set f__arg_boolean1=a8

    call TriggerExecute(st___prototype49[i])
endfunction
function sc___prototype49_evaluate takes integer i,force a1,unit a2,string a3,sound a4,string a5,integer a6,real a7,boolean a8 returns nothing
    set f__arg_force1=a1
    set f__arg_unit1=a2
    set f__arg_string1=a3
    set f__arg_sound1=a4
    set f__arg_string2=a5
    set f__arg_integer1=a6
    set f__arg_real1=a7
    set f__arg_boolean1=a8

    call TriggerEvaluate(st___prototype49[i])

endfunction
function sc___prototype50_execute takes integer i,force a1,player a2,integer a3,string a4,location a5,sound a6,string a7,integer a8,real a9,boolean a10 returns nothing
    set f__arg_force1=a1
    set f__arg_player1=a2
    set f__arg_integer1=a3
    set f__arg_string1=a4
    set f__arg_location1=a5
    set f__arg_sound1=a6
    set f__arg_string2=a7
    set f__arg_integer2=a8
    set f__arg_real1=a9
    set f__arg_boolean1=a10

    call TriggerExecute(st___prototype50[i])
endfunction
function sc___prototype50_evaluate takes integer i,force a1,player a2,integer a3,string a4,location a5,sound a6,string a7,integer a8,real a9,boolean a10 returns nothing
    set f__arg_force1=a1
    set f__arg_player1=a2
    set f__arg_integer1=a3
    set f__arg_string1=a4
    set f__arg_location1=a5
    set f__arg_sound1=a6
    set f__arg_string2=a7
    set f__arg_integer2=a8
    set f__arg_real1=a9
    set f__arg_boolean1=a10

    call TriggerEvaluate(st___prototype50[i])

endfunction
function sc___prototype51_execute takes integer i,integer a1,playercolor a2,string a3,string a4,real a5,real a6 returns nothing
    set f__arg_integer1=a1
    set f__arg_playercolor1=a2
    set f__arg_string1=a3
    set f__arg_string2=a4
    set f__arg_real1=a5
    set f__arg_real2=a6

    call TriggerExecute(st___prototype51[i])
endfunction
function sc___prototype51_evaluate takes integer i,integer a1,playercolor a2,string a3,string a4,real a5,real a6 returns nothing
    set f__arg_integer1=a1
    set f__arg_playercolor1=a2
    set f__arg_string1=a3
    set f__arg_string2=a4
    set f__arg_real1=a5
    set f__arg_real2=a6

    call TriggerEvaluate(st___prototype51[i])

endfunction
function sc___prototype52_execute takes integer i,sound a1,integer a2,playercolor a3,string a4,string a5,real a6,real a7 returns nothing
    set f__arg_sound1=a1
    set f__arg_integer1=a2
    set f__arg_playercolor1=a3
    set f__arg_string1=a4
    set f__arg_string2=a5
    set f__arg_real1=a6
    set f__arg_real2=a7

    call TriggerExecute(st___prototype52[i])
endfunction
function sc___prototype52_evaluate takes integer i,sound a1,integer a2,playercolor a3,string a4,string a5,real a6,real a7 returns nothing
    set f__arg_sound1=a1
    set f__arg_integer1=a2
    set f__arg_playercolor1=a3
    set f__arg_string1=a4
    set f__arg_string2=a5
    set f__arg_real1=a6
    set f__arg_real2=a7

    call TriggerEvaluate(st___prototype52[i])

endfunction
function h__DisplayTextToPlayer takes player a0, real a1, real a2, string a3 returns nothing
    //hook: Log__DisplayTextToPlayerHook
    call sc___prototype42_evaluate(1,a0,a1,a2,a3)
call DisplayTextToPlayer(a0,a1,a2,a3)
endfunction
function h__DisplayTimedTextToPlayer takes player a0, real a1, real a2, real a3, string a4 returns nothing
    //hook: Log__DisplayTimedTextToPlayerHook
    call sc___prototype43_evaluate(1,a0,a1,a2,a3,a4)
call DisplayTimedTextToPlayer(a0,a1,a2,a3,a4)
endfunction
function h__DisplayTimedTextFromPlayer takes player a0, real a1, real a2, real a3, string a4 returns nothing
    //hook: Log__DisplayTimedTextFromPlayerHook
    call sc___prototype43_evaluate(2,a0,a1,a2,a3,a4)
call DisplayTimedTextFromPlayer(a0,a1,a2,a3,a4)
endfunction
function h__DisplayTextToForce takes force a0, string a1 returns nothing
    //hook: Log__DisplayTextToForceHook
    call sc___prototype44_evaluate(1,a0,a1)
call DisplayTextToForce(a0,a1)
endfunction
function h__DisplayTimedTextToForce takes force a0, real a1, string a2 returns nothing
    //hook: Log__DisplayTimedTextToForceHook
    call sc___prototype45_evaluate(1,a0,a1,a2)
call DisplayTimedTextToForce(a0,a1,a2)
endfunction
function h__QuestMessageBJ takes force a0, integer a1, string a2 returns nothing
    //hook: Log__QuestMessageBJHook
    call sc___prototype46_evaluate(1,a0,a1,a2)
call QuestMessageBJ(a0,a1,a2)
endfunction
function h__BJDebugMsg takes string a0 returns nothing
    //hook: Log__BJDebugMsgHook
    call sc___prototype47_evaluate(1,a0)
call BJDebugMsg(a0)
endfunction
function h__BlzDisplayChatMessage takes player a0, integer a1, string a2 returns nothing
    //hook: Log__BlzDisplayChatMessageHook
    call sc___prototype48_evaluate(1,a0,a1,a2)
call BlzDisplayChatMessage(a0,a1,a2)
endfunction
function h__TransmissionFromUnitWithNameBJ takes force a0, unit a1, string a2, sound a3, string a4, integer a5, real a6, boolean a7 returns nothing
    //hook: Log__TransmissionFromUnitWithNameBJHook
    call sc___prototype49_evaluate(1,a0,a1,a2,a3,a4,a5,a6,a7)
call TransmissionFromUnitWithNameBJ(a0,a1,a2,a3,a4,a5,a6,a7)
endfunction
function h__TransmissionFromUnitTypeWithNameBJ takes force a0, player a1, integer a2, string a3, location a4, sound a5, string a6, integer a7, real a8, boolean a9 returns nothing
    //hook: Log__TransmissionFromUnitTypeWithNameBJHook
    call sc___prototype50_evaluate(1,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
call TransmissionFromUnitTypeWithNameBJ(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
endfunction
function h__SetCinematicScene takes integer a0, playercolor a1, string a2, string a3, real a4, real a5 returns nothing
    //hook: Log__SetCinematicSceneHook
    call sc___prototype51_evaluate(1,a0,a1,a2,a3,a4,a5)
call SetCinematicScene(a0,a1,a2,a3,a4,a5)
endfunction
function h__SetCinematicSceneBJ takes sound a0, integer a1, playercolor a2, string a3, string a4, real a5, real a6 returns nothing
    //hook: Log__SetCinematicSceneBJHook
    call sc___prototype52_evaluate(1,a0,a1,a2,a3,a4,a5,a6)
call SetCinematicSceneBJ(a0,a1,a2,a3,a4,a5,a6)
endfunction

//library FrameLoader:
// in 1.31 and upto 1.32.9 PTR (when I wrote this). Frames are not correctly saved and loaded, breaking the game.
// This library runs all functions added to it with a 0s delay after the game was loaded.
// function FrameLoaderAdd takes code func returns nothing
    // func runs when the game is loaded.
    function FrameLoaderAdd takes code func returns nothing
        call TriggerAddAction(FrameLoader__actionTrigger, func)
    endfunction

    function FrameLoader__timerAction takes nothing returns nothing
        call TriggerExecute(FrameLoader__actionTrigger)
    endfunction
    function FrameLoader__eventAction takes nothing returns nothing
        call TimerStart(FrameLoader__t, 0, false, function FrameLoader__timerAction)
    endfunction
    function FrameLoader__init_function takes nothing returns nothing
        call TriggerRegisterGameEvent(FrameLoader__eventTrigger, EVENT_GAME_LOADED)
        call TriggerAddAction(FrameLoader__eventTrigger, function FrameLoader__eventAction)
    endfunction

//library FrameLoader ends
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
    call TriggerAddAction(OnStartGame__startGameTrigger, func)
endfunction

function OnStartGame__TimerFunctionStartGame takes nothing returns nothing
    local timer t= GetExpiredTimer()
    call TriggerExecute(OnStartGame__startGameTrigger)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function OnStartGame__Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 0.0, false, function OnStartGame__TimerFunctionStartGame)
endfunction


//library OnStartGame ends
//library StringUtils:

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
    local string result= ""
    local integer currentIndex= 0
    local integer separatorLength= StringLength(separator)
    local integer length= StringLength(source)
    local integer i= 0
    loop
        exitwhen ( i == length or currentIndex > index )
        if ( SubString(source, i, i + separatorLength) == separator ) then
            set currentIndex=currentIndex + 1
            set i=i + separatorLength
        else
            if ( currentIndex == index ) then
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


//library StringUtils ends
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


function PlayerColorUtils__Init takes nothing returns nothing
    set PlayerColorUtils__PlayerColorNames[0]="RED"
    set PlayerColorUtils__PlayerColorNames[1]="BLUE"
    set PlayerColorUtils__PlayerColorNames[2]="CYAN"
    set PlayerColorUtils__PlayerColorNames[3]="PURPLE"
    set PlayerColorUtils__PlayerColorNames[4]="YELLOW"
    set PlayerColorUtils__PlayerColorNames[5]="ORANGE"
    set PlayerColorUtils__PlayerColorNames[6]="GREEN"
    set PlayerColorUtils__PlayerColorNames[7]="PINK"
    set PlayerColorUtils__PlayerColorNames[8]="LIGHT_GRAY"
    set PlayerColorUtils__PlayerColorNames[9]="LIGHT_BLUE"
    set PlayerColorUtils__PlayerColorNames[10]="AQUA"
    set PlayerColorUtils__PlayerColorNames[11]="BROWN"
    set PlayerColorUtils__PlayerColorNames[12]="MAROON"
    set PlayerColorUtils__PlayerColorNames[13]="NAVY"
    set PlayerColorUtils__PlayerColorNames[14]="TURQUOISE"
    set PlayerColorUtils__PlayerColorNames[15]="VIOLET"
    set PlayerColorUtils__PlayerColorNames[16]="WHEAT"
    set PlayerColorUtils__PlayerColorNames[17]="PEACH"
    set PlayerColorUtils__PlayerColorNames[18]="MINT"
    set PlayerColorUtils__PlayerColorNames[19]="LAVENDER"
    set PlayerColorUtils__PlayerColorNames[20]="COAL"
    set PlayerColorUtils__PlayerColorNames[21]="SNOW"
    set PlayerColorUtils__PlayerColorNames[22]="EMERALD"
    set PlayerColorUtils__PlayerColorNames[23]="PEANUT"
endfunction

function GetPlayerColorName takes player whichPlayer returns string
    return StringCase(PlayerColorUtils__PlayerColorNames[GetPlayerId(whichPlayer)], false)
endfunction

function GetPlayerColorFromString takes string whichString returns playercolor
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        if ( whichString == I2S(i + 1) or ( PlayerColorUtils__PlayerColorNames[i] != null and StringLength(PlayerColorUtils__PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorUtils__PlayerColorNames[i] ) or StringStartsWith(GetPlayerName(Player(i)) , whichString) ) then
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
        if ( whichString == I2S(i + 1) or ( PlayerColorUtils__PlayerColorNames[i] != null and StringLength(PlayerColorUtils__PlayerColorNames[i]) > 0 and StringCase(whichString, true) == PlayerColorUtils__PlayerColorNames[i] ) or StringStartsWith(GetPlayerName(Player(i)) , whichString) ) then
            return Player(i)
        endif
        set i=i + 1
    endloop

    return null
endfunction


//library PlayerColorUtils ends
//library Log:


function TriggerRegisterLogEvent takes trigger whichTrigger returns nothing
    set Log__callbackTriggers[Log__callbackTriggersCounter]=whichTrigger
    set Log__callbackTriggersCounter=Log__callbackTriggersCounter + 1
endfunction

function GetTriggerLogPlayer takes nothing returns player
    return Log__triggerLogPlayer
endfunction

function GetTriggerLogMessage takes nothing returns string
    return Log__triggerLogMessage
endfunction

function Log__ExecuteCallbackTriggers takes player whichPlayer,string msg returns nothing
    local integer i= 0
    local player slotPlayer= null
    loop
        exitwhen ( i == Log__callbackTriggersCounter )
        if ( IsTriggerEnabled(Log__callbackTriggers[i]) ) then
            set Log__triggerLogPlayer=whichPlayer
            set Log__triggerLogMessage=msg
            call ConditionalTriggerExecute(Log__callbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function Log__GetLogEntryIndex takes player whichPlayer,integer index returns integer
    return Index2D(index , GetPlayerId(whichPlayer) , bj_MAX_PLAYERS)
endfunction

function ClearLog takes player whichPlayer returns nothing
    set Log__logCounter[GetPlayerId(whichPlayer)]=0
endfunction

function IsLogEnabled takes player whichPlayer returns boolean
    return Log__logEnabled[GetPlayerId(whichPlayer)]
endfunction

function SetLogEnabled takes player whichPlayer,boolean enabled returns nothing
    set Log__logEnabled[GetPlayerId(whichPlayer)]=enabled
endfunction

function GetLogMaximum takes player whichPlayer returns integer
    return Log__logMaximum[GetPlayerId(whichPlayer)]
endfunction

function SetLogMaximum takes player whichPlayer,integer maximum returns nothing
    set Log__logMaximum[GetPlayerId(whichPlayer)]=maximum
endfunction

function GetLogEntry takes player whichPlayer,integer index returns string
    return Log__log[Log__GetLogEntryIndex(whichPlayer , index)]
endfunction

function GetLogCounter takes player whichPlayer returns integer
    return Log__logCounter[GetPlayerId(whichPlayer)]
endfunction


function RemoveStartingEmptyLines takes string s returns string
    local integer i= 0
    local integer max= StringLength(s)
    if ( max > 0 ) then
        loop
            exitwhen ( i >= max or SubString(s, i, i + 1) != "\n" )
            set i=i + 1
        endloop
 
        return SubString(s, i, max)
    endif
    
    return s
endfunction


function AddLog takes player whichPlayer,string msg returns nothing
    local integer index= (Log__logCounter[GetPlayerId((whichPlayer))]) // INLINED!!
    local integer i= 0
    local integer max= 0
    if ( (Log__logEnabled[GetPlayerId((whichPlayer))]) ) then // INLINED!!
        // Do this before removing empty lines since StringLength seems to already localize the passed string.
        set msg=GetLocalizedString(msg)

        set msg=RemoveStartingEmptyLines(msg)

        
        set max=(Log__logMaximum[GetPlayerId((whichPlayer))]) // INLINED!!
        if ( index >= max ) then
            set i=1
            loop
                exitwhen ( i >= max )
                set Log__log[Log__GetLogEntryIndex(whichPlayer , i - 1)]=Log__log[Log__GetLogEntryIndex(whichPlayer , i)]
                set i=i + 1
            endloop
            set Log__log[Log__GetLogEntryIndex(whichPlayer , max - 1)]=msg
        else
            set Log__logCounter[GetPlayerId(whichPlayer)]=index + 1
            set Log__log[Log__GetLogEntryIndex(whichPlayer , index)]=msg
        endif
        
        call Log__ExecuteCallbackTriggers(whichPlayer , msg)
    endif
endfunction

function Log__DisplayTextToPlayerHook takes player toPlayer,real x,real y,string message returns nothing
    call AddLog(toPlayer , message)
endfunction

function Log__DisplayTimedTextToPlayerHook takes player toPlayer,real x,real y,real duration,string message returns nothing
    call AddLog(toPlayer , message)
endfunction

function Log__DisplayTimedTextFromPlayerHook takes player toPlayer,real x,real y,real duration,string message returns nothing
    call AddLog(toPlayer , message)
endfunction

function Log__ForForceAddLog takes nothing returns nothing
    call AddLog(GetEnumPlayer() , Log__tmpMessage)
endfunction

function Log__DisplayTextToForceHook takes force toForce,string message returns nothing
    set Log__tmpMessage=message
    call ForForce(toForce, function Log__ForForceAddLog)
endfunction

function Log__DisplayTimedTextToForceHook takes force toForce,real duration,string message returns nothing
    set Log__tmpMessage=message
    call ForForce(toForce, function Log__ForForceAddLog)
endfunction

function Log__QuestMessageBJHook takes force f,integer messageType,string message returns nothing
    set Log__tmpMessage=" "
    call ForForce(f, function Log__ForForceAddLog)
    set Log__tmpMessage=message
    call ForForce(f, function Log__ForForceAddLog)
endfunction

function Log__BJDebugMsgHook takes string msg returns nothing
    set Log__tmpMessage=msg
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
endfunction

function Log__GetChatMessageRecipient takes integer recipient returns string
    if ( recipient == 0 ) then
        return GetLocalizedString("CHAT_RECIPIENT_ALL")
    elseif ( recipient == 1 ) then
        return GetLocalizedString("CHAT_RECIPIENT_ALLIES")
    elseif ( recipient == 2 ) then
        return GetLocalizedString("CHAT_RECIPIENT_OBSERVERS")
    endif
    
    return GetLocalizedString("CHAT_RECIPIENT_PRIVATE")
endfunction

// recipient: changes the type of chat channel prefix shown. It has no effect on the message's visibility.
// 0: "All" chat prefix
// 1: "Allies"
// 2: "Observers"
// 3+: "Private"
function Log__BlzDisplayChatMessageHook takes player whichPlayer,integer recipient,string message returns nothing
    set Log__tmpMessage=Log__GetChatMessageRecipient(recipient) + " " + GetPlayerNameColoredSimple(whichPlayer) + ": " + message
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
endfunction

//processed hook: hook DisplayTextToPlayer Log__DisplayTextToPlayerHook
//processed hook: hook DisplayTimedTextToPlayer Log__DisplayTimedTextToPlayerHook
//processed hook: hook DisplayTimedTextFromPlayer Log__DisplayTimedTextFromPlayerHook
//processed hook: hook DisplayTextToForce Log__DisplayTextToForceHook
//processed hook: hook DisplayTimedTextToForce Log__DisplayTimedTextToForceHook
//processed hook: hook QuestMessageBJ Log__QuestMessageBJHook
//processed hook: hook BJDebugMsg Log__BJDebugMsgHook
//processed hook: hook BlzDisplayChatMessage Log__BlzDisplayChatMessageHook


function Log__TransmissionFromUnitWithNameBJHook takes force toForce,unit whichUnit,string unitName,sound soundHandle,string message,integer timeType,real timeVal,boolean wait returns nothing
    set Log__tmpMessage=" "
    call ForForce(toForce, function Log__ForForceAddLog)
    set Log__tmpMessage="|cffffcc00" + GetLocalizedString(unitName) + ":|r " + GetLocalizedString(message)
    call ForForce(toForce, function Log__ForForceAddLog)
endfunction

function Log__TransmissionFromUnitTypeWithNameBJHook takes force toForce,player fromPlayer,integer unitId,string unitName,location loc,sound soundHandle,string message,integer timeType,real timeVal,boolean wait returns nothing
    set Log__tmpMessage=" "
    call ForForce(toForce, function Log__ForForceAddLog)
    set Log__tmpMessage="|cffffcc00" + GetLocalizedString(GetObjectName(unitId)) + ":|r " + GetLocalizedString(message)
    call ForForce(toForce, function Log__ForForceAddLog)
endfunction

function Log__SetCinematicSceneHook takes integer portraitUnitId,playercolor color,string speakerTitle,string text,real sceneDuration,real voiceoverDuration returns nothing
    set Log__tmpMessage=" "
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    set Log__tmpMessage="|cffffcc00" + speakerTitle + ":|r " + GetLocalizedString(text)
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
endfunction

function Log__SetCinematicSceneBJHook takes sound soundHandle,integer portraitUnitId,playercolor color,string speakerTitle,string text,real sceneDuration,real voiceoverDuration returns nothing
    set Log__tmpMessage=" "
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    set Log__tmpMessage="|cffffcc00" + speakerTitle + ":|r " + GetLocalizedString(text)
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
endfunction

//processed hook: hook TransmissionFromUnitWithNameBJ Log__TransmissionFromUnitWithNameBJHook
//processed hook: hook TransmissionFromUnitTypeWithNameBJ Log__TransmissionFromUnitTypeWithNameBJHook
//processed hook: hook SetCinematicScene Log__SetCinematicSceneHook
//processed hook: hook SetCinematicSceneBJ Log__SetCinematicSceneBJHook




function Log__TriggerActionChatMessage takes nothing returns nothing
    call AddLog(GetTriggerPlayer() , GetPlayerNameColoredSimple(GetTriggerPlayer()) + ": " + GetEventPlayerChatString())
endfunction


function Log__Init takes nothing returns nothing
    local trigger t= null
    local integer i= 0
    local player slotPlayer= null

     set t=CreateTrigger()
     call TriggerAddAction(t, function Log__TriggerActionChatMessage)

    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        set Log__logEnabled[GetPlayerId((slotPlayer ))]=( GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) // INLINED!!
        set Log__logMaximum[GetPlayerId((slotPlayer ))]=( LOG_MAXIMUM) // INLINED!!

        call TriggerRegisterPlayerChatEvent(t, slotPlayer, "", false)

        set slotPlayer=null
        set i=i + 1
    endloop
endfunction


//library Log ends
//library LogUI:


function EnableLogUI takes nothing returns nothing
    call EnableTrigger(LogUI__closeTrigger)
    call EnableTrigger(LogUI__chatCommandTrigger)
    call EnableTrigger(LogUI__logTrigger)
endfunction

function DisableLogUI takes nothing returns nothing
    call DisableTrigger(LogUI__closeTrigger)
    call DisableTrigger(LogUI__chatCommandTrigger)
    call DisableTrigger(LogUI__logTrigger)
endfunction

function UpdateLogUIVisible takes nothing returns nothing
    local integer max= (Log__logCounter[GetPlayerId((GetLocalPlayer()))]) // INLINED!!
    local integer i= 0
    call BlzFrameSetText(LogUI__TextAreaFrame, "")
    loop
        exitwhen ( i == max )
        call BlzFrameAddText(LogUI__TextAreaFrame, (Log__log[Log__GetLogEntryIndex((GetLocalPlayer() ) , ( i))])) // INLINED!!
        set i=i + 1
    endloop
endfunction

function SetLogUIVisible takes boolean visible returns nothing
    if ( visible ) then
        call UpdateLogUIVisible()
    endif
    call BlzFrameSetVisible(LogUI__BackgroundFrame, visible)
endfunction

function ShowLogUI takes nothing returns nothing
    call SetLogUIVisible(true)
endfunction

function HideLogUI takes nothing returns nothing
    call SetLogUIVisible(false)
endfunction

function SetLogUIVisibleForPlayer takes player whichPlayer,boolean visible returns nothing
     if ( whichPlayer == GetLocalPlayer() ) then
        call SetLogUIVisible(visible)
    endif
endfunction

function ShowLogUIForPlayer takes player whichPlayer returns nothing
    if ( whichPlayer == GetLocalPlayer() ) then
        call SetLogUIVisible(true)
    endif
endfunction

function HideLogUIForPlayer takes player whichPlayer returns nothing
    if ( whichPlayer == GetLocalPlayer() ) then
        call SetLogUIVisible(false)
    endif
endfunction 

function LogUI__CloseFunction takes nothing returns nothing
    call HideLogUIForPlayer(GetTriggerPlayer())
endfunction

function LogUI__ClickUpperButtonFunction takes nothing returns nothing
    call ForceUIKeyBJ(GetTriggerPlayer(), "F12")
    call ShowLogUIForPlayer(GetTriggerPlayer())
    if ( GetTriggerPlayer() == GetLocalPlayer() ) then
        call PlaySound("Sound\\Interface\\BigButtonClick")
    endif
endfunction

function LogUI__CreateUpperButtonUI takes nothing returns nothing
    local integer i= 0
    local player slotPlayer= null
    if ( LogUI__clickUpperButtonTrigger != null ) then
        call DestroyTrigger(LogUI__clickUpperButtonTrigger)
    endif
    set LogUI__clickUpperButtonTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LogUI__clickUpperButtonTrigger, BlzGetFrameByName("UpperButtonBarChatButton", 0), FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LogUI__clickUpperButtonTrigger, function LogUI__ClickUpperButtonFunction)
    
    if ( LogUI__upperButtonHotkeyTrigger != null ) then
        call DestroyTrigger(LogUI__upperButtonHotkeyTrigger)
    endif
    set LogUI__upperButtonHotkeyTrigger=CreateTrigger()
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING ) then
            call BlzTriggerRegisterPlayerKeyEvent(LogUI__upperButtonHotkeyTrigger, slotPlayer, OSKEY_F12, 0, true)
        endif
        set i=i + 1
    endloop
    call TriggerAddAction(LogUI__upperButtonHotkeyTrigger, function LogUI__ClickUpperButtonFunction)
endfunction

function LogUI__CreateUI takes nothing returns nothing
    local framehandle f= null
    
    set LogUI__BackgroundFrame=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(LogUI__BackgroundFrame, FRAMEPOINT_TOPLEFT, LogUI_X, LogUI_Y)
    call BlzFrameSetAbsPoint(LogUI__BackgroundFrame, FRAMEPOINT_BOTTOMRIGHT, LogUI_X + LogUI_WIDTH, LogUI_Y - LogUI_HEIGHT)
    call BlzFrameSetLevel(LogUI__BackgroundFrame, 1)

    set f=BlzCreateFrame("EscMenuTitleTextTemplate", LogUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, LogUI_TITLE_X, LogUI_TITLE_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, LogUI_TITLE_X + LogUI_WIDTH, LogUI_TITLE_Y - LogUI_TITLE_HEIGHT)
    call BlzFrameSetTextAlignment(f, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
    call BlzFrameSetText(f, GetLocalizedString("MESSAGE_LOG"))
    
    set LogUI__TextAreaFrame=BlzCreateFrame("EscMenuTextAreaTemplate", LogUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(LogUI__TextAreaFrame, FRAMEPOINT_TOPLEFT, LogUI_TEXT_AREA_X, LogUI_TEXT_AREA_Y)
    call BlzFrameSetAbsPoint(LogUI__TextAreaFrame, FRAMEPOINT_BOTTOMRIGHT, LogUI_TEXT_AREA_X + LogUI_TEXT_AREA_WIDTH, LogUI_TEXT_AREA_Y - LogUI_TEXT_AREA_HEIGHT)
    call BlzFrameSetFont(LogUI__TextAreaFrame, "MasterFont", 0.011, 0)

    set f=BlzCreateFrame("ScriptDialogButton", LogUI__BackgroundFrame, 0, 0)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_TOPLEFT, LogUI_CLOSE_BUTTON_X, LogUI_CLOSE_BUTTON_Y)
    call BlzFrameSetAbsPoint(f, FRAMEPOINT_BOTTOMRIGHT, LogUI_CLOSE_BUTTON_X + LogUI_CLOSE_BUTTON_WIDTH, LogUI_CLOSE_BUTTON_Y - LogUI_CLOSE_BUTTON_HEIGHT)
    call BlzFrameSetText(f, "|cffffcc00" + GetLocalizedString("OK") + "|r")

    if ( LogUI__closeTrigger != null ) then
        call DestroyTrigger(LogUI__closeTrigger)
    endif
    set LogUI__closeTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(LogUI__closeTrigger, f, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(LogUI__closeTrigger, function LogUI__CloseFunction)


    call LogUI__CreateUpperButtonUI()


    call SetLogUIVisible(false) // INLINED!!
endfunction

function LogUI__TriggerActionShowLogUI takes nothing returns nothing
    call ShowLogUIForPlayer(GetTriggerPlayer())
endfunction

function LogUI__TriggerActionLog takes nothing returns nothing
    if ( (Log__triggerLogPlayer) == GetLocalPlayer() ) then // INLINED!!
        if ( BlzFrameIsVisible(LogUI__BackgroundFrame) ) then
            call UpdateLogUIVisible()
        endif
    endif
endfunction

function LogUI__Start takes nothing returns nothing
    local integer i= 0
    local player slotPlayer= null

    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING ) then
            if ( StringLength(LogUI_CHAT_COMMAND_SHORT) > 0 ) then
                call TriggerRegisterPlayerChatEvent(LogUI__chatCommandTrigger, slotPlayer, LogUI_CHAT_COMMAND_SHORT, true)
            endif
            if ( StringLength(LogUI_CHAT_COMMAND) > 0 ) then
                call TriggerRegisterPlayerChatEvent(LogUI__chatCommandTrigger, slotPlayer, LogUI_CHAT_COMMAND, true)
            endif
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    call TriggerAddAction(LogUI__chatCommandTrigger, function LogUI__TriggerActionShowLogUI)


    call TriggerRegisterLogEvent(LogUI__logTrigger)
    call TriggerAddAction(LogUI__logTrigger, function LogUI__TriggerActionLog)


    call BlzLoadTOCFile(LogUI_TOC_FILE)

    
    call LogUI__CreateUI()
endfunction

function LogUI__Init takes nothing returns nothing
    call TriggerAddAction(OnStartGame__startGameTrigger, (function LogUI__Start)) // INLINED!!
    // Prevents crashes on loading save games:

    call TriggerAddAction(FrameLoader__actionTrigger, (function LogUI__CreateUI)) // INLINED!!

endfunction


//library LogUI ends
//===========================================================================
// 
// Baradé's Log 1.0
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
//*  FrameLoader vjass

//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades Player Color Utils
//***************************************************************************
//*  Barades Math Utils
//***************************************************************************
//*  Barades On Start Game
//***************************************************************************
//*  Barades Log
//***************************************************************************
//*  Barades Log UI

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

    set gg_unit_Hpal_0000=BlzCreateUnitWithSkin(p, 'Hpal', - 57.8, - 386.3, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0000, 10, false)
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0000, 'AHds')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0029=BlzCreateUnitWithSkin(p, 'Hpal', 70.7, - 381.8, 270.000, 'Hpal')
    call SetHeroLevel(gg_unit_Hpal_0029, 10, false)
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHhb')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHad')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHre')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
    call SelectHeroSkill(gg_unit_Hpal_0029, 'AHds')
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
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
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
function Trig_Game_Start_Func002A takes nothing returns nothing
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 999999)
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 999999)
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 300)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call ForForce(GetPlayersAll(), function Trig_Game_Start_Func002A)
    call h__DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call h__DisplayTextToForce(GetPlayersAll(), "TRIGSTR_037")
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0000, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hpal_0029, Player(1))
    call SetLogUIVisible(true) // INLINED!!
    call ForceCinematicSubtitlesBJ(true)
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Messages
//===========================================================================
function Trig_Messages_Actions takes nothing returns nothing
    call h__DisplayTextToForce(GetPlayersAll(), "TRIGSTR_091")
    call h__DisplayTimedTextToForce(GetPlayersAll(), 30, "TRIGSTR_092")
    call h__DisplayTextToForce(bj_FORCE_PLAYER[0], "TRIGSTR_093")
    call h__DisplayTextToForce(bj_FORCE_PLAYER[1], "TRIGSTR_094")
    call h__QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_UPDATED, "TRIGSTR_095")
    call h__TransmissionFromUnitWithNameBJ(GetPlayersAll(), gg_unit_Hpal_0000, "TRIGSTR_096", null, "TRIGSTR_097", bj_TIMETYPE_ADD, 0, false)
    call h__TransmissionFromUnitWithNameBJ(GetForceOfPlayer(Player(0)), gg_unit_Hpal_0000, "TRIGSTR_098", null, "TRIGSTR_099", bj_TIMETYPE_ADD, 0, false)
    call h__TransmissionFromUnitWithNameBJ(GetForceOfPlayer(Player(1)), gg_unit_Hpal_0029, "TRIGSTR_100", null, "TRIGSTR_101", bj_TIMETYPE_ADD, 0, false)
    call h__TransmissionFromUnitTypeWithNameBJ(GetPlayersAll(), Player(0), 'Hamg', "TRIGSTR_102", GetRectCenter(GetPlayableMapRect()), null, "TRIGSTR_103", bj_TIMETYPE_ADD, 0, false)
    call h__BlzDisplayChatMessage(Player(0), 0, "Chat message from red!")
    call h__BlzDisplayChatMessage(Player(1), 0, "Chat message from blue!")
endfunction

//===========================================================================
function InitTrig_Messages takes nothing returns nothing
    set gg_trg_Messages=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Messages, 2.00)
    call TriggerAddAction(gg_trg_Messages, function Trig_Messages_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Messages()
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
    // Force: TRIGSTR_006
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
    call SetCameraBounds(- 1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs6659031")
call ExecuteFunc("FrameLoader__init_function")
call ExecuteFunc("OnStartGame__Init")
call ExecuteFunc("PlayerColorUtils__Init")
call ExecuteFunc("Log__Init")
call ExecuteFunc("LogUI__Init")

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
    call SetMapDescription("TRIGSTR_003")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, 0.0, - 384.0)
    call DefineStartLocation(1, 0.0, - 384.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa___prototype42_Log__DisplayTextToPlayerHook takes nothing returns boolean
 local player toPlayer=f__arg_player1
 local real x=f__arg_real1
 local real y=f__arg_real2
 local string message=f__arg_string1

    call AddLog(toPlayer , message)
    return true
endfunction
function sa___prototype43_Log__DisplayTimedTextToPlayerHook takes nothing returns boolean
 local player toPlayer=f__arg_player1
 local real x=f__arg_real1
 local real y=f__arg_real2
 local real duration=f__arg_real3
 local string message=f__arg_string1

    call AddLog(toPlayer , message)
    return true
endfunction
function sa___prototype43_Log__DisplayTimedTextFromPlayerHook takes nothing returns boolean
 local player toPlayer=f__arg_player1
 local real x=f__arg_real1
 local real y=f__arg_real2
 local real duration=f__arg_real3
 local string message=f__arg_string1

    call AddLog(toPlayer , message)
    return true
endfunction
function sa___prototype44_Log__DisplayTextToForceHook takes nothing returns boolean
    call Log__DisplayTextToForceHook(f__arg_force1,f__arg_string1)
    return true
endfunction
function sa___prototype45_Log__DisplayTimedTextToForceHook takes nothing returns boolean
    call Log__DisplayTimedTextToForceHook(f__arg_force1,f__arg_real1,f__arg_string1)
    return true
endfunction
function sa___prototype46_Log__QuestMessageBJHook takes nothing returns boolean
    call Log__QuestMessageBJHook(f__arg_force1,f__arg_integer1,f__arg_string1)
    return true
endfunction
function sa___prototype47_Log__BJDebugMsgHook takes nothing returns boolean
 local string msg=f__arg_string1

    set Log__tmpMessage=msg
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    return true
endfunction
function sa___prototype48_Log__BlzDisplayChatMessageHook takes nothing returns boolean
 local player whichPlayer=f__arg_player1
 local integer recipient=f__arg_integer1
 local string message=f__arg_string1

    set Log__tmpMessage=Log__GetChatMessageRecipient(recipient) + " " + GetPlayerNameColoredSimple(whichPlayer) + ": " + message
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    return true
endfunction
function sa___prototype49_Log__TransmissionFromUnitWithNameBJHook takes nothing returns boolean
    call Log__TransmissionFromUnitWithNameBJHook(f__arg_force1,f__arg_unit1,f__arg_string1,f__arg_sound1,f__arg_string2,f__arg_integer1,f__arg_real1,f__arg_boolean1)
    return true
endfunction
function sa___prototype50_Log__TransmissionFromUnitTypeWithNameBJHook takes nothing returns boolean
    call Log__TransmissionFromUnitTypeWithNameBJHook(f__arg_force1,f__arg_player1,f__arg_integer1,f__arg_string1,f__arg_location1,f__arg_sound1,f__arg_string2,f__arg_integer2,f__arg_real1,f__arg_boolean1)
    return true
endfunction
function sa___prototype51_Log__SetCinematicSceneHook takes nothing returns boolean
 local integer portraitUnitId=f__arg_integer1
 local playercolor color=f__arg_playercolor1
 local string speakerTitle=f__arg_string1
 local string text=f__arg_string2
 local real sceneDuration=f__arg_real1
 local real voiceoverDuration=f__arg_real2

    set Log__tmpMessage=" "
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    set Log__tmpMessage="|cffffcc00" + speakerTitle + ":|r " + GetLocalizedString(text)
    call ForForce(GetPlayersAll(), function Log__ForForceAddLog)
    return true
endfunction
function sa___prototype52_Log__SetCinematicSceneBJHook takes nothing returns boolean
    call Log__SetCinematicSceneBJHook(f__arg_sound1,f__arg_integer1,f__arg_playercolor1,f__arg_string1,f__arg_string2,f__arg_real1,f__arg_real2)
    return true
endfunction

function jasshelper__initstructs6659031 takes nothing returns nothing
    set st___prototype42[1]=CreateTrigger()
    call TriggerAddAction(st___prototype42[1],function sa___prototype42_Log__DisplayTextToPlayerHook)
    call TriggerAddCondition(st___prototype42[1],Condition(function sa___prototype42_Log__DisplayTextToPlayerHook))
    set st___prototype43[1]=CreateTrigger()
    call TriggerAddAction(st___prototype43[1],function sa___prototype43_Log__DisplayTimedTextToPlayerHook)
    call TriggerAddCondition(st___prototype43[1],Condition(function sa___prototype43_Log__DisplayTimedTextToPlayerHook))
    set st___prototype43[2]=CreateTrigger()
    call TriggerAddAction(st___prototype43[2],function sa___prototype43_Log__DisplayTimedTextFromPlayerHook)
    call TriggerAddCondition(st___prototype43[2],Condition(function sa___prototype43_Log__DisplayTimedTextFromPlayerHook))
    set st___prototype44[1]=CreateTrigger()
    call TriggerAddAction(st___prototype44[1],function sa___prototype44_Log__DisplayTextToForceHook)
    call TriggerAddCondition(st___prototype44[1],Condition(function sa___prototype44_Log__DisplayTextToForceHook))
    set st___prototype45[1]=CreateTrigger()
    call TriggerAddAction(st___prototype45[1],function sa___prototype45_Log__DisplayTimedTextToForceHook)
    call TriggerAddCondition(st___prototype45[1],Condition(function sa___prototype45_Log__DisplayTimedTextToForceHook))
    set st___prototype46[1]=CreateTrigger()
    call TriggerAddAction(st___prototype46[1],function sa___prototype46_Log__QuestMessageBJHook)
    call TriggerAddCondition(st___prototype46[1],Condition(function sa___prototype46_Log__QuestMessageBJHook))
    set st___prototype47[1]=CreateTrigger()
    call TriggerAddAction(st___prototype47[1],function sa___prototype47_Log__BJDebugMsgHook)
    call TriggerAddCondition(st___prototype47[1],Condition(function sa___prototype47_Log__BJDebugMsgHook))
    set st___prototype48[1]=CreateTrigger()
    call TriggerAddAction(st___prototype48[1],function sa___prototype48_Log__BlzDisplayChatMessageHook)
    call TriggerAddCondition(st___prototype48[1],Condition(function sa___prototype48_Log__BlzDisplayChatMessageHook))
    set st___prototype49[1]=CreateTrigger()
    call TriggerAddAction(st___prototype49[1],function sa___prototype49_Log__TransmissionFromUnitWithNameBJHook)
    call TriggerAddCondition(st___prototype49[1],Condition(function sa___prototype49_Log__TransmissionFromUnitWithNameBJHook))
    set st___prototype50[1]=CreateTrigger()
    call TriggerAddAction(st___prototype50[1],function sa___prototype50_Log__TransmissionFromUnitTypeWithNameBJHook)
    call TriggerAddCondition(st___prototype50[1],Condition(function sa___prototype50_Log__TransmissionFromUnitTypeWithNameBJHook))
    set st___prototype51[1]=CreateTrigger()
    call TriggerAddAction(st___prototype51[1],function sa___prototype51_Log__SetCinematicSceneHook)
    call TriggerAddCondition(st___prototype51[1],Condition(function sa___prototype51_Log__SetCinematicSceneHook))
    set st___prototype52[1]=CreateTrigger()
    call TriggerAddAction(st___prototype52[1],function sa___prototype52_Log__SetCinematicSceneBJHook)
    call TriggerAddCondition(st___prototype52[1],Condition(function sa___prototype52_Log__SetCinematicSceneBJHook))

endfunction

