globals
//globals from DiplomacyUIConfig:
constant boolean LIBRARY_DiplomacyUIConfig=true
//endglobals from DiplomacyUIConfig
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
//globals from SimError:
constant boolean LIBRARY_SimError=true
sound SimError__error
//endglobals from SimError
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from PlayerColorUtils:
constant boolean LIBRARY_PlayerColorUtils=true
string array PlayerColorUtils___PlayerColorNames
//endglobals from PlayerColorUtils
//globals from StringFormat:
constant boolean LIBRARY_StringFormat=true
//endglobals from StringFormat
//globals from DiplomacyUI:
constant boolean LIBRARY_DiplomacyUI=true
constant string DiplomacyUI_CHAT_COMMAND= "-diplomacy"
constant string DiplomacyUI_CHAT_COMMAND_SHORT= "-dp"
constant string DiplomacyUI_PREFIX= "DiplomacyUI"
constant string DiplomacyUI_TOC_FILE= "war3mapImported\\diplomacyui.toc"
constant boolean DiplomacyUI_LOAD_TOC_FILE= true
    
constant real DiplomacyUI_PLAYER_SCALE= 0.1
constant real DiplomacyUI_PLAYER_INDENTION= 0.013
constant real DiplomacyUI_X= 0.0
constant real DiplomacyUI_Y= 0.55
constant real DiplomacyUI_TITLE_Y= DiplomacyUI_Y - 0.03
constant real DiplomacyUI_WIDTH= 0.8
constant real DiplomacyUI_HEIGHT= 0.4
constant real DiplomacyUI_TITLE_HEIGHT= 0.04
constant real DiplomacyUI_TITLE_VERTICAL_SPACE= 0.01
constant real DiplomacyUI_BUTTON_Y= 0.21
constant real DiplomacyUI_BUTTON_WIDTH= 0.09
constant real DiplomacyUI_BUTTON_HEIGHT= 0.032
constant real DiplomacyUI_CANCEL_BUTTON_X= 0.32
constant real DiplomacyUI_APPLY_BUTTON_X= DiplomacyUI_CANCEL_BUTTON_X + DiplomacyUI_BUTTON_WIDTH
constant real DiplomacyUI_TABLE_WIDTH= DiplomacyUI_WIDTH - 0.02
constant real DiplomacyUI_TABLE_HEIGHT= DiplomacyUI_HEIGHT - DiplomacyUI_TITLE_HEIGHT - DiplomacyUI_TITLE_VERTICAL_SPACE - ( DiplomacyUI_BUTTON_Y - ( DiplomacyUI_Y - DiplomacyUI_HEIGHT ) )
constant real DiplomacyUI_CELL_WIDTH= 0.07
constant real DiplomacyUI_CELL_HEIGHT= 0.07
constant string DiplomacyUI_TOOLTIP_FONT= "fonts\\dfst-m3u.ttf"
constant real DiplomacyUI_TOOLTIP_FONT_HEIGHT= 0.008
constant real DiplomacyUI_TOOLTIP_X= 0.55
constant real DiplomacyUI_TOOLTIP_Y= 0.50
constant real DiplomacyUI_TOOLTIP_WIDTH= 0.20
constant real DiplomacyUI_TOOLTIP_HEIGHT= 0.6
    
framehandle DiplomacyUI___Background
framehandle DiplomacyUI___Title
framehandle DiplomacyUI___TableTitle
framehandle array DiplomacyUI___ColumnTitles
framehandle array DiplomacyUI___RowTitles
framehandle array DiplomacyUI___Cells
framehandle array DiplomacyUI___CellsTooltip
framehandle DiplomacyUI___CancelButton
framehandle DiplomacyUI___ApplyButton

force DiplomacyUI___allPlayers= null
integer DiplomacyUI___allPlayersCount= 0
real DiplomacyUI___scale= 1.0
real DiplomacyUI___indentionX= 0.0
trigger DiplomacyUI___syncTrigger= CreateTrigger()
trigger DiplomacyUI___chatTrigger= CreateTrigger()
trigger DiplomacyUI___changeTrigger= null
trigger DiplomacyUI___cancelTrigger= null
trigger DiplomacyUI___applyTrigger= null
//endglobals from DiplomacyUI
//globals from Map:
constant boolean LIBRARY_Map=true
integer Map___max= bj_MAX_PLAYERS
//endglobals from Map
    // Generated
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
trigger gg_trg_Timer= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__AFormat=1
integer si__AFormat_F=0
integer si__AFormat_I=0
integer array si__AFormat_V
integer array s__AFormat_m_position
string array s__AFormat_m_text

endglobals


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

//library DiplomacyUIConfig:

function DiplomacyUIConfig_IsPlayerAllowed takes player whichPlayer returns boolean
    return true
endfunction

function DiplomacyUIConfig_GetValidPlayers takes nothing returns force
    local force f= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) != PLAYER_SLOT_STATE_EMPTY ) then
            call ForceAddPlayer(f, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    return f
endfunction


//library DiplomacyUIConfig ends
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
            call StartSound(SimError__error)
        endif
    endfunction

    function SimError__init takes nothing returns nothing
         set SimError__error=CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
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
    local integer max=  StringLength(start)
    local integer max2= StringLength(source)
    loop
        exitwhen ( i == max or i >= max2 )

        if ( SubString(source, i, i + 1) != SubString(start, i, i + 1) ) then
            return false
        endif

        set i=i + 1
    endloop

    return i == max
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
    local integer max= StringLength(source)
    loop
        exitwhen ( max == 0 )
        set sourcePosition=GetRandomInt(0, max - 1)
        set result=result + SubString(source, sourcePosition, sourcePosition + 1)
        set source=SubString(source, 0, sourcePosition) + SubString(source, sourcePosition + 1, max)
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

function FormatTime takes real time returns string
    local integer hours= R2I(time / 3600.0)
    local integer minutes=  R2I(time - hours * 3600) / 60
    local integer seconds= R2I(time - hours * 3600 - minutes * 60)
    
    return I2SW(hours , 2) + ":" + I2SW(minutes , 2) + ":" + I2SW(seconds , 2)
endfunction

function IsCharacterNumber takes string c returns boolean
    return c == "0" or c == "1" or c == "2" or c == "3" or c == "4" or c == "5" or c == "6" or c == "7" or c == "8" or c == "9"
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


function InsertLineBreaks takes string whichString,integer maxLineLength returns string
    local integer i
    local string result
    local integer max= StringLength(whichString)
    if ( max <= maxLineLength ) then
        return whichString
    endif
    set result=""
    set i=maxLineLength
    loop
        exitwhen ( i > max )
        set result=result + SubString(whichString, i - maxLineLength, i) + "\n"
        set i=i + maxLineLength
    endloop

    if ( i < max ) then
        set result=result + SubString(whichString, i - maxLineLength, max)
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
//library DiplomacyUI:


function GetAllianceState takes player sourcePlayer,player otherPlayer returns integer
    if ( IsPlayerAlly(sourcePlayer, otherPlayer) ) then
        if ( GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL) ) then
            return bj_ALLIANCE_ALLIED_ADVUNITS
        elseif ( GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_CONTROL) ) then
            return bj_ALLIANCE_ALLIED_UNITS
        elseif ( GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION) ) then
            return bj_ALLIANCE_ALLIED_VISION
        endif
        
        return bj_ALLIANCE_ALLIED
    elseif ( IsPlayerEnemy(sourcePlayer, otherPlayer) ) then
        if ( GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION) ) then
            return bj_ALLIANCE_UNALLIED_VISION
        endif
        
        return bj_ALLIANCE_UNALLIED
    endif
    
    if ( GetPlayerAlliance(sourcePlayer, otherPlayer, ALLIANCE_SHARED_VISION) ) then
        return bj_ALLIANCE_NEUTRAL_VISION
    endif
    
    return bj_ALLIANCE_NEUTRAL
endfunction

function DiplomacyUI___GetAllianceStateName takes integer allianceState returns string
    if ( allianceState == bj_ALLIANCE_UNALLIED ) then
        return GetLocalizedString("UNALLIED")
    elseif ( allianceState == bj_ALLIANCE_UNALLIED_VISION ) then
        return GetLocalizedString("UNALLIED_VISION")
    elseif ( allianceState == bj_ALLIANCE_ALLIED ) then
        return GetLocalizedString("ALLIED")
    elseif ( allianceState == bj_ALLIANCE_ALLIED_VISION ) then
        return GetLocalizedString("ALLIED_VISION")
    elseif ( allianceState == bj_ALLIANCE_ALLIED_UNITS ) then
        return GetLocalizedString("ALLIED_UNITS")
    elseif ( allianceState == bj_ALLIANCE_ALLIED_ADVUNITS ) then
        return GetLocalizedString("ALLIED_ADVANCED_UNITS")
    elseif ( allianceState == bj_ALLIANCE_NEUTRAL ) then
        return GetLocalizedString("NEUTRAL")
    endif
    return GetLocalizedString("NEUTRAL_VISION")
endfunction

function DiplomacyUI___UpdateTooltips takes nothing returns nothing
    local player rowPlayer= null
    local player columnPlayer= null
    local integer row= 0
    local integer column= 0
    local integer index= 0
    local integer allianceState= 0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    if ( rowPlayer != columnPlayer ) then
                        set index=Index2D(row , column , bj_MAX_PLAYERS)
                        set allianceState=R2I(BlzFrameGetValue(DiplomacyUI___Cells[index]))
                        call BlzFrameSetText(DiplomacyUI___CellsTooltip[index], s__AFormat_result(s__AFormat_s(s__AFormat_s(s__AFormat_s((s__AFormat_create((GetLocalizedString("FROM_TO_X")))),GetPlayerNameColored(rowPlayer)),GetPlayerNameColored(columnPlayer)),DiplomacyUI___GetAllianceStateName(allianceState)))) // INLINED!!
                    endif
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
endfunction

function DiplomacyUI___UpdateUI takes nothing returns nothing
    local player rowPlayer= null
    local player columnPlayer= null
    local integer row= 0
    local integer column= 0
    local integer index= 0
    local integer allianceState= 0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            call BlzFrameSetTexture(DiplomacyUI___RowTitles[row], ("ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId((GetPlayerColor(rowPlayer))) , 2)), 0, true) // INLINED!!
            call BlzFrameSetTexture(DiplomacyUI___ColumnTitles[row], ("ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId((GetPlayerColor(rowPlayer))) , 2)), 0, true) // INLINED!!

            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    if ( rowPlayer != columnPlayer ) then
                        set index=Index2D(row , column , bj_MAX_PLAYERS)
                        set allianceState=GetAllianceState(rowPlayer , columnPlayer)
                        call BlzFrameSetValue(DiplomacyUI___Cells[index], I2R(allianceState))
                    endif
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
    call DiplomacyUI___UpdateTooltips()
endfunction

function SetDiplomacyUIVisible takes boolean visible returns nothing
    local player rowPlayer= null
    local player columnPlayer= null
    local integer row= 0
    local integer column= 0
    local integer index= 0
    call BlzFrameSetVisible(DiplomacyUI___Background, visible)
    call BlzFrameSetVisible(DiplomacyUI___Title, visible)
    call BlzFrameSetVisible(DiplomacyUI___TableTitle, visible)
    call BlzFrameSetVisible(DiplomacyUI___CancelButton, visible)
    call BlzFrameSetVisible(DiplomacyUI___ApplyButton, visible)
    set row=0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            call BlzFrameSetVisible(DiplomacyUI___ColumnTitles[row], visible)
            call BlzFrameSetVisible(DiplomacyUI___RowTitles[row], visible)
            
            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    if ( rowPlayer != columnPlayer ) then
                        set index=Index2D(row , column , bj_MAX_PLAYERS)
                        call BlzFrameSetVisible(DiplomacyUI___Cells[index], visible)
                        
                        if ( not visible ) then
                            call BlzFrameSetVisible(DiplomacyUI___CellsTooltip[index], visible)
                        endif
                    endif
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
endfunction

function ShowDiplomacyUI takes nothing returns nothing
    call DiplomacyUI___UpdateUI()
    call SetDiplomacyUIVisible(true)
endfunction

function HideDiplomacyUI takes nothing returns nothing
    call SetDiplomacyUIVisible(false)
endfunction

function DiplomacyUI___TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer= GetTriggerPlayer()
    local integer playerId= GetPlayerId(whichPlayer)
    local string data= BlzGetTriggerSyncData()
    local integer sourcePlayerId= S2I(StringSplit(data , 0 , "_"))
    local integer otherPlayerId= S2I(StringSplit(data , 1 , "_"))
    local integer allianceState= S2I(StringSplit(data , 2 , "_"))
    local player sourcePlayer= Player(sourcePlayerId)
    local player otherPlayer= Player(otherPlayerId)
    //call BJDebugMsg("Synced data " + GetPlayerName(whichPlayer) + " for " + GetPlayerName(sourcePlayer) + " and " + GetPlayerName(otherPlayer) + ": " + I2S(allianceState))
    call SetPlayerAllianceStateBJ(sourcePlayer, otherPlayer, allianceState)
    set whichPlayer=null
    set sourcePlayer=null
    set otherPlayer=null
endfunction

function DiplomacyUI___TriggerActionChat takes nothing returns nothing
    if ( DiplomacyUIConfig_IsPlayerAllowed(GetTriggerPlayer()) ) then
        if ( GetTriggerPlayer() == GetLocalPlayer() ) then
            call ShowDiplomacyUI()
        endif
    else
        call SimError(GetTriggerPlayer() , GetLocalizedString("DIPLOMACY_CHANGE_NOT_ALLOWED"))
    endif
endfunction

function DiplomacyUI___ApplyFunction takes nothing returns nothing
    local player rowPlayer= null
    local player columnPlayer= null
    local integer row= 0
    local integer column= 0
    local integer index= 0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    if ( rowPlayer != columnPlayer ) then
                        set index=Index2D(row , column , bj_MAX_PLAYERS)
                        if ( GetLocalPlayer() == GetTriggerPlayer() ) then
                            call BlzSendSyncData(DiplomacyUI_PREFIX, I2S(row) + "_" + I2S(column) + "_" + I2S(R2I(BlzFrameGetValue(DiplomacyUI___Cells[index]))))
                        endif
                    endif
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
    call SetDiplomacyUIVisible(false) // INLINED!!
endfunction

function DiplomacyUI___CreateUI takes nothing returns nothing
    local integer row= 0
    local integer column= 0
    local player rowPlayer= null
    local player columnPlayer= null
    local real x= 0.0
    local real headerX= 0.0
    local real headerY= 0.0
    local real y= 0.0
    local integer index= 0
    local real cellWidth= DiplomacyUI_CELL_WIDTH * DiplomacyUI___scale
    local real cellHeight= DiplomacyUI_CELL_HEIGHT * DiplomacyUI___scale

    set DiplomacyUI___Background=BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(DiplomacyUI___Background, FRAMEPOINT_TOPLEFT, DiplomacyUI_X, DiplomacyUI_Y)
    call BlzFrameSetAbsPoint(DiplomacyUI___Background, FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI_X + DiplomacyUI_WIDTH, DiplomacyUI_Y - DiplomacyUI_HEIGHT)
    
    set DiplomacyUI___Title=BlzCreateFrameByType("TEXT", "DiplomacyUITitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(DiplomacyUI___Title, FRAMEPOINT_TOPLEFT, DiplomacyUI_X, DiplomacyUI_TITLE_Y)
    call BlzFrameSetAbsPoint(DiplomacyUI___Title, FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI_X + DiplomacyUI_WIDTH, DiplomacyUI_TITLE_Y - DiplomacyUI_TITLE_HEIGHT)
    call BlzFrameSetText(DiplomacyUI___Title, GetLocalizedString("DIPLOMACY"))
    call BlzFrameSetTextAlignment(DiplomacyUI___Title, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)

    set y=DiplomacyUI_Y - DiplomacyUI_TITLE_HEIGHT - DiplomacyUI_TITLE_VERTICAL_SPACE - cellHeight
    set headerX=DiplomacyUI___indentionX + cellWidth
    set headerY=DiplomacyUI_Y - DiplomacyUI_TITLE_HEIGHT - DiplomacyUI_TITLE_VERTICAL_SPACE
    
    set DiplomacyUI___TableTitle=BlzCreateFrameByType("TEXT", "DiplomacyUITableTitle", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetAbsPoint(DiplomacyUI___TableTitle, FRAMEPOINT_TOPLEFT, DiplomacyUI___indentionX, headerY)
    call BlzFrameSetAbsPoint(DiplomacyUI___TableTitle, FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI___indentionX + cellWidth, headerY - cellHeight)
    call BlzFrameSetText(DiplomacyUI___TableTitle, GetLocalizedString("SOURCE_TARGET"))
    call BlzFrameSetTextAlignment(DiplomacyUI___TableTitle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT)
    call BlzFrameSetScale(DiplomacyUI___TableTitle, DiplomacyUI___scale)
    
    set DiplomacyUI___changeTrigger=CreateTrigger()
    set DiplomacyUI___cancelTrigger=CreateTrigger()
    set DiplomacyUI___applyTrigger=CreateTrigger()
    
    call TriggerAddAction(DiplomacyUI___changeTrigger, function DiplomacyUI___UpdateTooltips)
    
    set row=0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            set x=DiplomacyUI___indentionX
            
            set DiplomacyUI___RowTitles[row]=BlzCreateFrameByType("BACKDROP", DiplomacyUI_PREFIX + "RowTitle" + I2S(row), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(DiplomacyUI___RowTitles[row], FRAMEPOINT_TOPLEFT, x, y)
            call BlzFrameSetAbsPoint(DiplomacyUI___RowTitles[row], FRAMEPOINT_BOTTOMRIGHT, x + cellHeight, y - cellHeight)
            //call BlzFrameSetText(RowTitles[row], GetPlayerNameColoredSimple(rowPlayer))
            call BlzFrameSetTexture(DiplomacyUI___RowTitles[row], ("ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId((GetPlayerColor(rowPlayer))) , 2)), 0, true) // INLINED!!
            call BlzFrameSetTextAlignment(DiplomacyUI___RowTitles[row], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
            call BlzFrameSetScale(DiplomacyUI___RowTitles[row], DiplomacyUI___scale)
            
            set x=x + cellHeight
            
            set DiplomacyUI___ColumnTitles[row]=BlzCreateFrameByType("BACKDROP", DiplomacyUI_PREFIX + "ColumnTitle" + I2S(row), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
            call BlzFrameSetAbsPoint(DiplomacyUI___ColumnTitles[row], FRAMEPOINT_TOPLEFT, headerX, headerY)
            call BlzFrameSetAbsPoint(DiplomacyUI___ColumnTitles[row], FRAMEPOINT_BOTTOMRIGHT, headerX + cellHeight, headerY - cellHeight)
            //call BlzFrameSetText(ColumnTitles[row], GetPlayerNameColoredSimple(rowPlayer))
            call BlzFrameSetTexture(DiplomacyUI___ColumnTitles[row], ("ReplaceableTextures\\TeamColor\\TeamColor" + I2SW(GetHandleId((GetPlayerColor(rowPlayer))) , 2)), 0, true) // INLINED!!
            call BlzFrameSetTextAlignment(DiplomacyUI___ColumnTitles[row], TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER)
            call BlzFrameSetScale(DiplomacyUI___ColumnTitles[row], DiplomacyUI___scale)
            
            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    set index=Index2D(row , column , bj_MAX_PLAYERS)
                    
                    if ( rowPlayer != columnPlayer ) then
                        set DiplomacyUI___Cells[index]=BlzCreateFrame("AlliancePopup", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
                        call BlzFrameSetAbsPoint(DiplomacyUI___Cells[index], FRAMEPOINT_TOPLEFT, x, y)
                        call BlzFrameSetAbsPoint(DiplomacyUI___Cells[index], FRAMEPOINT_BOTTOMRIGHT, x + cellWidth, y - cellHeight)
                        call BlzFrameSetScale(DiplomacyUI___Cells[index], DiplomacyUI___scale)
                        
                        call BlzTriggerRegisterFrameEvent(DiplomacyUI___changeTrigger, DiplomacyUI___Cells[index], FRAMEEVENT_POPUPMENU_ITEM_CHANGED)
                        
                        set DiplomacyUI___CellsTooltip[index]=BlzCreateFrameByType("TEXT", DiplomacyUI_PREFIX + "CellsTooltip" + I2S(index), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
                        call BlzFrameSetTooltip(DiplomacyUI___Cells[index], DiplomacyUI___CellsTooltip[index])
                        call BlzFrameSetAbsPoint(DiplomacyUI___CellsTooltip[index], FRAMEPOINT_TOPLEFT, DiplomacyUI_TOOLTIP_X, DiplomacyUI_TOOLTIP_Y)
                        call BlzFrameSetAbsPoint(DiplomacyUI___CellsTooltip[index], FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI_TOOLTIP_X + DiplomacyUI_TOOLTIP_WIDTH, DiplomacyUI_TOOLTIP_Y - DiplomacyUI_TOOLTIP_HEIGHT)
                        call BlzFrameSetFont(DiplomacyUI___CellsTooltip[index], DiplomacyUI_TOOLTIP_FONT, DiplomacyUI_TOOLTIP_FONT_HEIGHT, 0)
                    endif
                    
                    set x=x + cellWidth
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
            
            set y=y - cellHeight
            set headerX=headerX + cellWidth
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
    
    set DiplomacyUI___CancelButton=BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(DiplomacyUI___CancelButton, FRAMEPOINT_TOPLEFT, DiplomacyUI_CANCEL_BUTTON_X, DiplomacyUI_BUTTON_Y)
    call BlzFrameSetAbsPoint(DiplomacyUI___CancelButton, FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI_CANCEL_BUTTON_X + DiplomacyUI_BUTTON_WIDTH, DiplomacyUI_BUTTON_Y - DiplomacyUI_BUTTON_HEIGHT)
    call BlzFrameSetText(DiplomacyUI___CancelButton, GetLocalizedString("CANCEL_YELLOW"))

    set DiplomacyUI___cancelTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(DiplomacyUI___cancelTrigger, DiplomacyUI___CancelButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(DiplomacyUI___cancelTrigger, function HideDiplomacyUI)
    
    set DiplomacyUI___ApplyButton=BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(DiplomacyUI___ApplyButton, FRAMEPOINT_TOPLEFT, DiplomacyUI_APPLY_BUTTON_X, DiplomacyUI_BUTTON_Y)
    call BlzFrameSetAbsPoint(DiplomacyUI___ApplyButton, FRAMEPOINT_BOTTOMRIGHT, DiplomacyUI_APPLY_BUTTON_X + DiplomacyUI_BUTTON_WIDTH, DiplomacyUI_BUTTON_Y - DiplomacyUI_BUTTON_HEIGHT)
    call BlzFrameSetText(DiplomacyUI___ApplyButton, GetLocalizedString("APPLY_YELLOW"))

    set DiplomacyUI___applyTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(DiplomacyUI___applyTrigger, DiplomacyUI___ApplyButton, FRAMEEVENT_CONTROL_CLICK)
    call TriggerAddAction(DiplomacyUI___applyTrigger, function DiplomacyUI___ApplyFunction)

    call DiplomacyUI___UpdateUI()
    call SetDiplomacyUIVisible(false) // INLINED!!
endfunction

function DiplomacyUI___DestroyUI takes nothing returns nothing
    local integer row= 0
    local integer column= 0
    local player rowPlayer= null
    local player columnPlayer= null
    local integer index= 0
    
    call SetDiplomacyUIVisible(false) // INLINED!!

    call BlzDestroyFrame(DiplomacyUI___Background)
    call BlzDestroyFrame(DiplomacyUI___Title)
    call BlzDestroyFrame(DiplomacyUI___TableTitle)
    
    set row=0
    loop
        exitwhen ( row == bj_MAX_PLAYERS )
        set rowPlayer=Player(row)
        if ( IsPlayerInForce(rowPlayer, DiplomacyUI___allPlayers) ) then
            call BlzDestroyFrame(DiplomacyUI___RowTitles[row])
            call BlzDestroyFrame(DiplomacyUI___ColumnTitles[row])
          
            set column=0
            loop
                exitwhen ( column == bj_MAX_PLAYERS )
                set columnPlayer=Player(column)
                if ( IsPlayerInForce(columnPlayer, DiplomacyUI___allPlayers) ) then
                    set index=Index2D(row , column , bj_MAX_PLAYERS)
                    
                    if ( rowPlayer != columnPlayer ) then
                        call BlzDestroyFrame(DiplomacyUI___Cells[row])
                        call BlzDestroyFrame(DiplomacyUI___CellsTooltip[row])
                    endif
                endif
                set columnPlayer=null
                set column=column + 1
            endloop
        endif
        set rowPlayer=null
        set row=row + 1
    endloop
    
    call BlzDestroyFrame(DiplomacyUI___CancelButton)
    call DestroyTrigger(DiplomacyUI___cancelTrigger)
    call BlzDestroyFrame(DiplomacyUI___ApplyButton)
    call DestroyTrigger(DiplomacyUI___applyTrigger)
endfunction

function SetDiplomacyUIPlayers takes force whichForce returns nothing
    local integer cellsCount= CountPlayersInForceBJ(whichForce) + 1
    local real width= I2R(cellsCount) * DiplomacyUI_CELL_WIDTH
    local real height= I2R(cellsCount) * DiplomacyUI_CELL_HEIGHT
    local real widthScale= DiplomacyUI_TABLE_WIDTH / width
    local real heightScale= DiplomacyUI_TABLE_HEIGHT / height
    set DiplomacyUI___scale=RMinBJ(widthScale, heightScale)

    if ( DiplomacyUI___allPlayers != null ) then
        call SetDiplomacyUIVisible(false) // INLINED!!
        call DiplomacyUI___DestroyUI()
        call DestroyForce(DiplomacyUI___allPlayers)
    endif
    set DiplomacyUI___allPlayers=whichForce
    //call BJDebugMsg("with count " + I2S(cellsCount) + ": " + R2S(scale))
    set DiplomacyUI___indentionX=DiplomacyUI_X + ( DiplomacyUI_WIDTH - cellsCount * DiplomacyUI___scale * DiplomacyUI_CELL_WIDTH ) / 2.0
    
    call DiplomacyUI___CreateUI()
endfunction

function DiplomacyUI___Init takes nothing returns nothing
    local integer i= 0
    local player slotPlayer= null
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER ) then
            call BlzTriggerRegisterPlayerSyncEvent(DiplomacyUI___syncTrigger, slotPlayer, DiplomacyUI_PREFIX, false)
            call TriggerRegisterPlayerChatEvent(DiplomacyUI___chatTrigger, slotPlayer, DiplomacyUI_CHAT_COMMAND, true)
            call TriggerRegisterPlayerChatEvent(DiplomacyUI___chatTrigger, slotPlayer, DiplomacyUI_CHAT_COMMAND_SHORT, true)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    call TriggerAddAction(DiplomacyUI___syncTrigger, function DiplomacyUI___TriggerActionSyncData)
    call TriggerAddAction(DiplomacyUI___chatTrigger, function DiplomacyUI___TriggerActionChat)
    
    call SetDiplomacyUIPlayers(DiplomacyUIConfig_GetValidPlayers())
    

    call BlzLoadTOCFile(DiplomacyUI_TOC_FILE)

    

    call TriggerAddAction(FrameLoader__actionTrigger, (function DiplomacyUI___CreateUI)) // INLINED!!


    call TriggerAddAction(OnStartGame__startGameTrigger, (function DiplomacyUI___CreateUI)) // INLINED!!
endfunction


//library DiplomacyUI ends
//library Map:


function IncreaseMax takes nothing returns nothing
    local force f= CreateForce()
    local player slotPlayer= null
    local integer i= 0
    set Map___max=ModuloInteger(Map___max + 1, bj_MAX_PLAYERS)
    call BJDebugMsg("Maximum shown players: " + I2S(Map___max))
    loop
        exitwhen ( i == Map___max )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) != PLAYER_SLOT_STATE_EMPTY ) then
            call ForceAddPlayer(f, slotPlayer)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    call SetDiplomacyUIPlayers(f)
    call ShowDiplomacyUI()
endfunction


//library Map ends
//===========================================================================
// 
// Baradé's Diplomacy UI 1.0
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
//*  Barades On Start Game
//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades String Format
//***************************************************************************
//*  Barades Player Color Utils
//***************************************************************************
//*  Barades Math Utils
//***************************************************************************
//*  Barades Diplomacy UI
//***************************************************************************
//*  Barades Diplomacy UI Config
//***************************************************************************
//*  Map

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

    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 181.9, - 80.0, 328.644, 'hfoo')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 47.3, - 56.1, 265.328, 'hfoo')
endfunction

//===========================================================================
function CreateUnitsForPlayer2 takes nothing returns nothing
    local player p= Player(2)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ugho', - 163.5, - 190.4, 7.306, 'ugho')
endfunction

//===========================================================================
function CreateUnitsForPlayer3 takes nothing returns nothing
    local player p= Player(3)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'earc', - 46.1, - 223.3, 158.054, 'earc')
endfunction

//===========================================================================
function CreateUnitsForPlayer4 takes nothing returns nothing
    local player p= Player(4)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hfoo', - 162.1, - 326.4, 187.630, 'hfoo')
endfunction

//===========================================================================
function CreateUnitsForPlayer5 takes nothing returns nothing
    local player p= Player(5)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ogru', - 44.2, - 358.0, 255.879, 'ogru')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
    call CreateUnitsForPlayer2()
    call CreateUnitsForPlayer3()
    call CreateUnitsForPlayer4()
    call CreateUnitsForPlayer5()
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
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_037")
    call ShowDiplomacyUI()
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
// Trigger: Timer
//===========================================================================
function Trig_Timer_Actions takes nothing returns nothing
    call IncreaseMax()
endfunction

//===========================================================================
function InitTrig_Timer takes nothing returns nothing
    set gg_trg_Timer=CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(gg_trg_Timer, 1.00)
    call TriggerAddAction(gg_trg_Timer, function Trig_Timer_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
    call InitTrig_Timer()
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
    call SetPlayerRacePreference(Player(0), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_COMPUTER)

    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_COMPUTER)

    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call ForcePlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_COMPUTER)

    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call ForcePlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_COMPUTER)

    // Player 6
    call SetPlayerStartLocation(Player(6), 6)
    call ForcePlayerStartLocation(Player(6), 6)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_COMPUTER)

    // Player 7
    call SetPlayerStartLocation(Player(7), 7)
    call ForcePlayerStartLocation(Player(7), 7)
    call SetPlayerColor(Player(7), ConvertPlayerColor(7))
    call SetPlayerRacePreference(Player(7), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(7), false)
    call SetPlayerController(Player(7), MAP_CONTROL_COMPUTER)

    // Player 8
    call SetPlayerStartLocation(Player(8), 8)
    call ForcePlayerStartLocation(Player(8), 8)
    call SetPlayerColor(Player(8), ConvertPlayerColor(8))
    call SetPlayerRacePreference(Player(8), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(8), false)
    call SetPlayerController(Player(8), MAP_CONTROL_COMPUTER)

    // Player 9
    call SetPlayerStartLocation(Player(9), 9)
    call ForcePlayerStartLocation(Player(9), 9)
    call SetPlayerColor(Player(9), ConvertPlayerColor(9))
    call SetPlayerRacePreference(Player(9), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(9), false)
    call SetPlayerController(Player(9), MAP_CONTROL_COMPUTER)

    // Player 10
    call SetPlayerStartLocation(Player(10), 10)
    call ForcePlayerStartLocation(Player(10), 10)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)

    // Player 11
    call SetPlayerStartLocation(Player(11), 11)
    call ForcePlayerStartLocation(Player(11), 11)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)

    // Player 12
    call SetPlayerStartLocation(Player(12), 12)
    call ForcePlayerStartLocation(Player(12), 12)
    call SetPlayerColor(Player(12), ConvertPlayerColor(12))
    call SetPlayerRacePreference(Player(12), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(12), false)
    call SetPlayerController(Player(12), MAP_CONTROL_COMPUTER)

    // Player 13
    call SetPlayerStartLocation(Player(13), 13)
    call ForcePlayerStartLocation(Player(13), 13)
    call SetPlayerColor(Player(13), ConvertPlayerColor(13))
    call SetPlayerRacePreference(Player(13), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(13), false)
    call SetPlayerController(Player(13), MAP_CONTROL_COMPUTER)

    // Player 14
    call SetPlayerStartLocation(Player(14), 14)
    call ForcePlayerStartLocation(Player(14), 14)
    call SetPlayerColor(Player(14), ConvertPlayerColor(14))
    call SetPlayerRacePreference(Player(14), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(14), false)
    call SetPlayerController(Player(14), MAP_CONTROL_COMPUTER)

    // Player 15
    call SetPlayerStartLocation(Player(15), 15)
    call ForcePlayerStartLocation(Player(15), 15)
    call SetPlayerColor(Player(15), ConvertPlayerColor(15))
    call SetPlayerRacePreference(Player(15), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(15), false)
    call SetPlayerController(Player(15), MAP_CONTROL_COMPUTER)

    // Player 16
    call SetPlayerStartLocation(Player(16), 16)
    call ForcePlayerStartLocation(Player(16), 16)
    call SetPlayerColor(Player(16), ConvertPlayerColor(16))
    call SetPlayerRacePreference(Player(16), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(16), false)
    call SetPlayerController(Player(16), MAP_CONTROL_COMPUTER)

    // Player 17
    call SetPlayerStartLocation(Player(17), 17)
    call ForcePlayerStartLocation(Player(17), 17)
    call SetPlayerColor(Player(17), ConvertPlayerColor(17))
    call SetPlayerRacePreference(Player(17), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(17), false)
    call SetPlayerController(Player(17), MAP_CONTROL_COMPUTER)

    // Player 18
    call SetPlayerStartLocation(Player(18), 18)
    call ForcePlayerStartLocation(Player(18), 18)
    call SetPlayerColor(Player(18), ConvertPlayerColor(18))
    call SetPlayerRacePreference(Player(18), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(18), false)
    call SetPlayerController(Player(18), MAP_CONTROL_COMPUTER)

    // Player 19
    call SetPlayerStartLocation(Player(19), 19)
    call ForcePlayerStartLocation(Player(19), 19)
    call SetPlayerColor(Player(19), ConvertPlayerColor(19))
    call SetPlayerRacePreference(Player(19), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(19), false)
    call SetPlayerController(Player(19), MAP_CONTROL_COMPUTER)

    // Player 20
    call SetPlayerStartLocation(Player(20), 20)
    call ForcePlayerStartLocation(Player(20), 20)
    call SetPlayerColor(Player(20), ConvertPlayerColor(20))
    call SetPlayerRacePreference(Player(20), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(20), false)
    call SetPlayerController(Player(20), MAP_CONTROL_COMPUTER)

    // Player 21
    call SetPlayerStartLocation(Player(21), 21)
    call ForcePlayerStartLocation(Player(21), 21)
    call SetPlayerColor(Player(21), ConvertPlayerColor(21))
    call SetPlayerRacePreference(Player(21), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(21), false)
    call SetPlayerController(Player(21), MAP_CONTROL_COMPUTER)

    // Player 22
    call SetPlayerStartLocation(Player(22), 22)
    call ForcePlayerStartLocation(Player(22), 22)
    call SetPlayerColor(Player(22), ConvertPlayerColor(22))
    call SetPlayerRacePreference(Player(22), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(22), false)
    call SetPlayerController(Player(22), MAP_CONTROL_COMPUTER)

    // Player 23
    call SetPlayerStartLocation(Player(23), 23)
    call ForcePlayerStartLocation(Player(23), 23)
    call SetPlayerColor(Player(23), ConvertPlayerColor(23))
    call SetPlayerRacePreference(Player(23), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(23), false)
    call SetPlayerController(Player(23), MAP_CONTROL_COMPUTER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_006
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(6), 0)
    call SetPlayerState(Player(6), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(7), 0)
    call SetPlayerState(Player(7), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(8), 0)
    call SetPlayerState(Player(8), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(9), 0)
    call SetPlayerState(Player(9), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(10), 0)
    call SetPlayerState(Player(10), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(11), 0)
    call SetPlayerState(Player(11), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(12), 0)
    call SetPlayerState(Player(12), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(13), 0)
    call SetPlayerState(Player(13), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(14), 0)
    call SetPlayerState(Player(14), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(15), 0)
    call SetPlayerState(Player(15), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(16), 0)
    call SetPlayerState(Player(16), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(17), 0)
    call SetPlayerState(Player(17), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(18), 0)
    call SetPlayerState(Player(18), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(19), 0)
    call SetPlayerState(Player(19), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(20), 0)
    call SetPlayerState(Player(20), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(21), 0)
    call SetPlayerState(Player(21), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(22), 0)
    call SetPlayerState(Player(22), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(23), 0)
    call SetPlayerState(Player(23), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(12), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(13), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(14), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(15), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(16), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(17), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(18), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(19), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(20), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(22), true)
    call SetPlayerAllianceStateAllyBJ(Player(21), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(22), Player(23), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(12), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(13), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(14), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(15), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(16), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(17), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(18), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(19), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(20), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(21), true)
    call SetPlayerAllianceStateAllyBJ(Player(23), Player(22), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(12), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(13), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(14), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(15), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(16), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(17), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(18), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(19), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(20), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(22), true)
    call SetPlayerAllianceStateVisionBJ(Player(21), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(22), Player(23), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(12), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(13), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(14), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(15), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(16), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(17), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(18), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(19), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(20), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(21), true)
    call SetPlayerAllianceStateVisionBJ(Player(23), Player(22), true)

    //   Shared Control
    call SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(0), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(2), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(3), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(4), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(5), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(6), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(7), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(8), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(9), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(10), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(11), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(12), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(13), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(14), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(15), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(16), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(17), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(18), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(19), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(20), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(22), true)
    call SetPlayerAllianceStateControlBJ(Player(21), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(22), Player(23), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(0), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(2), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(3), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(4), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(5), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(6), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(7), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(8), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(9), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(10), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(11), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(12), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(13), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(14), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(15), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(16), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(17), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(18), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(19), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(20), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(21), true)
    call SetPlayerAllianceStateControlBJ(Player(23), Player(22), true)

    //   Shared Advanced Control
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(2), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(3), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(4), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(5), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(6), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(7), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(8), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(9), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(10), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(11), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(12), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(13), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(14), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(15), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(16), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(17), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(18), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(19), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(20), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(22), true)
    call SetPlayerAllianceStateFullControlBJ(Player(21), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(22), Player(23), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(0), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(2), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(3), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(4), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(5), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(6), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(7), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(8), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(9), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(10), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(11), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(12), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(13), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(14), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(15), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(16), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(17), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(18), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(19), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(20), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(21), true)
    call SetPlayerAllianceStateFullControlBJ(Player(23), Player(22), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(2, 16)
    call SetStartLocPrio(2, 0, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 1, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 2, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 3, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 4, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 5, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 6, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 7, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 8, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 9, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 10, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 11, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 12, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 13, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 14, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(2, 15, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(2, 7)
    call SetEnemyStartLocPrio(2, 0, 17, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 1, 18, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 2, 19, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 3, 20, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 4, 21, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 5, 22, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(2, 6, 23, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(3, 16)
    call SetStartLocPrio(3, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 2, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 3, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 4, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 5, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 6, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 7, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 8, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 9, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 10, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 11, 16, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 12, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 13, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 14, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(3, 15, 20, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(3, 17)
    call SetEnemyStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(3, 1, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 2, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 3, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 4, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 5, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 6, 9, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(3, 7, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 8, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 10, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 11, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 12, 16, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(3, 16, 20, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(4, 12)
    call SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 3, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 4, 8, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 5, 13, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 6, 14, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 7, 16, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 8, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 9, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 10, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(4, 11, 22, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(4, 19)
    call SetEnemyStartLocPrio(4, 0, 0, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 1, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(4, 3, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 6, 8, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 7, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 8, 12, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(4, 9, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 10, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 11, 16, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 12, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 13, 18, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(4, 14, 19, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(4, 15, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 16, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(4, 17, 22, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(5, 21)
    call SetStartLocPrio(5, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(5, 4, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 5, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 6, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 7, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 8, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 9, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(5, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(5, 21)
    call SetEnemyStartLocPrio(5, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(5, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(5, 4, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 5, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 6, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 7, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 8, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(5, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(6, 21)
    call SetStartLocPrio(6, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 5, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 6, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 7, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 8, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 9, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(6, 21)
    call SetEnemyStartLocPrio(6, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 5, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 6, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 7, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 8, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(6, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(7, 21)
    call SetStartLocPrio(7, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 6, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 7, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 8, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 9, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(7, 21)
    call SetEnemyStartLocPrio(7, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 6, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 7, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 8, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(7, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(8, 21)
    call SetStartLocPrio(8, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 16, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 17, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 18, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 19, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(8, 20, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(8, 21)
    call SetEnemyStartLocPrio(8, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 16, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 17, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 18, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 19, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(8, 20, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(9, 20)
    call SetStartLocPrio(9, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 1, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 2, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 3, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 4, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 5, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 6, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 7, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 14, 18, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 15, 19, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(9, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(9, 18, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(9, 21)
    call SetEnemyStartLocPrio(9, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 7, 10, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 8, 11, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 9, 12, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 10, 13, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 11, 14, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 12, 15, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(9, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(9, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(10, 21)
    call SetStartLocPrio(10, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 8, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 9, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(10, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(10, 21)
    call SetEnemyStartLocPrio(10, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 8, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(10, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(11, 21)
    call SetStartLocPrio(11, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 9, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(11, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(11, 21)
    call SetEnemyStartLocPrio(11, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 9, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(11, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(12, 21)
    call SetStartLocPrio(12, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 10, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(12, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(12, 21)
    call SetEnemyStartLocPrio(12, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 10, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(12, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(13, 21)
    call SetStartLocPrio(13, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 11, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(13, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(13, 21)
    call SetEnemyStartLocPrio(13, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 11, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(13, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(14, 21)
    call SetStartLocPrio(14, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 12, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(14, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(14, 21)
    call SetEnemyStartLocPrio(14, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 12, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(14, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(15, 21)
    call SetStartLocPrio(15, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 13, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(15, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(15, 21)
    call SetEnemyStartLocPrio(15, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 13, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(15, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(16, 16)
    call SetStartLocPrio(16, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 1, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 2, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 3, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 4, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 5, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 6, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 7, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 8, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 9, 17, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(16, 10, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 11, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 12, 20, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(16, 13, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(16, 14, 22, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(16, 15, 23, MAP_LOC_PRIO_HIGH)

    call SetEnemyStartLocPrioCount(16, 21)
    call SetEnemyStartLocPrio(16, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 16, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 17, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 18, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 19, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(16, 20, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(17, 21)
    call SetStartLocPrio(17, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 14, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(17, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(17, 21)
    call SetEnemyStartLocPrio(17, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 14, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(17, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(18, 21)
    call SetStartLocPrio(18, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 15, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(18, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(18, 21)
    call SetEnemyStartLocPrio(18, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 15, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(18, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(19, 21)
    call SetStartLocPrio(19, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 16, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(19, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(19, 21)
    call SetEnemyStartLocPrio(19, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 16, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(19, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(20, 21)
    call SetStartLocPrio(20, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 16, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 17, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(20, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(20, 21)
    call SetEnemyStartLocPrio(20, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 16, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 17, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(20, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(21, 21)
    call SetStartLocPrio(21, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 16, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 17, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 18, 22, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(21, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(21, 21)
    call SetEnemyStartLocPrio(21, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 16, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 17, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 18, 22, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(21, 19, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(22, 21)
    call SetStartLocPrio(22, 0, 1, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 2, 3, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 3, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 4, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 5, 6, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 6, 7, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 7, 9, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 8, 10, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 9, 11, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 10, 12, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 11, 13, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 12, 14, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 13, 15, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 16, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 17, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 18, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(22, 19, 23, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(22, 22)
    call SetEnemyStartLocPrio(22, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 14, 16, MAP_LOC_PRIO_HIGH)
    call SetEnemyStartLocPrio(22, 15, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 16, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 17, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 18, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 19, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(22, 20, 23, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(23, 21)
    call SetStartLocPrio(23, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 2, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 3, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 4, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 5, 6, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 6, 7, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 7, 9, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 8, 10, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 9, 11, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 10, 12, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 11, 13, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 12, 14, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 13, 15, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(23, 14, 17, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(23, 15, 18, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(23, 16, 19, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(23, 17, 20, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(23, 18, 21, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(23, 19, 22, MAP_LOC_PRIO_LOW)

    call SetEnemyStartLocPrioCount(23, 21)
    call SetEnemyStartLocPrio(23, 0, 1, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 1, 2, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 2, 3, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 3, 4, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 4, 5, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 5, 6, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 6, 7, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 7, 9, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 8, 10, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 9, 11, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 10, 12, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 11, 13, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 12, 14, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 13, 15, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 14, 17, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 15, 18, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 16, 19, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 17, 20, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 18, 21, MAP_LOC_PRIO_LOW)
    call SetEnemyStartLocPrio(23, 19, 22, MAP_LOC_PRIO_LOW)
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

call ExecuteFunc("jasshelper__initstructs914841968")
call ExecuteFunc("FrameLoader__init_function")
call ExecuteFunc("OnStartGame__Init")
call ExecuteFunc("SimError__init")
call ExecuteFunc("PlayerColorUtils___Init")
call ExecuteFunc("DiplomacyUI___Init")

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
    call SetPlayers(24)
    call SetTeams(24)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 64.0, - 256.0)
    call DefineStartLocation(1, - 64.0, - 256.0)
    call DefineStartLocation(2, - 64.0, - 256.0)
    call DefineStartLocation(3, - 64.0, - 256.0)
    call DefineStartLocation(4, - 64.0, - 256.0)
    call DefineStartLocation(5, - 64.0, - 256.0)
    call DefineStartLocation(6, - 64.0, - 256.0)
    call DefineStartLocation(7, - 64.0, - 256.0)
    call DefineStartLocation(8, 896.0, - 768.0)
    call DefineStartLocation(9, 1664.0, 2368.0)
    call DefineStartLocation(10, 1024.0, - 1472.0)
    call DefineStartLocation(11, 1856.0, - 1792.0)
    call DefineStartLocation(12, - 512.0, 2048.0)
    call DefineStartLocation(13, 960.0, 896.0)
    call DefineStartLocation(14, - 128.0, 1472.0)
    call DefineStartLocation(15, 896.0, - 128.0)
    call DefineStartLocation(16, 2240.0, 576.0)
    call DefineStartLocation(17, - 1152.0, - 2496.0)
    call DefineStartLocation(18, 3008.0, 1536.0)
    call DefineStartLocation(19, - 576.0, - 2944.0)
    call DefineStartLocation(20, 256.0, - 768.0)
    call DefineStartLocation(21, - 1920.0, - 192.0)
    call DefineStartLocation(22, - 1600.0, 1472.0)
    call DefineStartLocation(23, 0.0, - 2176.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

function jasshelper__initstructs914841968 takes nothing returns nothing


endfunction

