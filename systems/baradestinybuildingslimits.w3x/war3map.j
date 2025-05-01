globals
//globals from SimError:
constant boolean LIBRARY_SimError=true
sound SimError__error
//endglobals from SimError
//globals from StringUtils:
constant boolean LIBRARY_StringUtils=true
//endglobals from StringUtils
//globals from UnitGroupUtils:
constant boolean LIBRARY_UnitGroupUtils=true
integer UnitGroupUtils__counterLivingPlayerUnitsOfTypeId= 0
boolexpr UnitGroupUtils__filterLivingPlayerUnitsOfTypeIdWithCount= null
//endglobals from UnitGroupUtils
//globals from StringFormat:
constant boolean LIBRARY_StringFormat=true
//endglobals from StringFormat
//globals from TinyBuildingsLimits:
constant boolean LIBRARY_TinyBuildingsLimits=true
trigger TinyBuildingsLimits__constructionTrigger= CreateTrigger()
hashtable TinyBuildingsLimits__h= InitHashtable()
//endglobals from TinyBuildingsLimits
//globals from Helpers:
constant boolean LIBRARY_Helpers=true
//endglobals from Helpers
    // User-defined
integer udg_AbilityCode= 0
integer udg_UnitType= 0

    // Generated
trigger gg_trg_Init_Tiny_Building_Items= null
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
unit gg_unit_Hamg_0013= null
unit gg_unit_Hamg_0012= null

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
    local integer max= StringLength(start)
    local integer max2= StringLength(source)
    loop
        exitwhen ( i == max or i == max2 )

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
//library UnitGroupUtils:

// Similar to GetUnitsOfTypeIdAll but for one single owner only.
function GetUnitsOfTypeId takes integer unitid,player owner returns group
    local group result= CreateGroup()
    set bj_groupEnumTypeId=unitid
    call GroupEnumUnitsOfPlayer(result, owner, filterGetUnitsOfTypeIdAll)
    return result
endfunction


function CountLivingPlayerUnitsOfTypeIdFast takes integer unitId,player whichPlayer returns integer
    local group g= CreateGroup()
    set bj_livingPlayerUnitsTypeId=unitId
    set UnitGroupUtils__counterLivingPlayerUnitsOfTypeId=0
    call GroupEnumUnitsOfPlayer(g, whichPlayer, UnitGroupUtils__filterLivingPlayerUnitsOfTypeIdWithCount)
    call DestroyGroup(g)
    set g=null

    return UnitGroupUtils__counterLivingPlayerUnitsOfTypeId
endfunction

function LivingPlayerUnitsOfTypeIdFilterFast takes nothing returns boolean
    local unit filterUnit= GetFilterUnit()
    local boolean result= IsUnitAliveBJ(filterUnit) and GetUnitTypeId(filterUnit) == bj_livingPlayerUnitsTypeId
    if ( result ) then
        set UnitGroupUtils__counterLivingPlayerUnitsOfTypeId=UnitGroupUtils__counterLivingPlayerUnitsOfTypeId + 1
    endif
    return result
endfunction

function UnitGroupUtils__Init takes nothing returns nothing
    set UnitGroupUtils__filterLivingPlayerUnitsOfTypeIdWithCount=Filter(function LivingPlayerUnitsOfTypeIdFilterFast)
endfunction


//library UnitGroupUtils ends
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
//library TinyBuildingsLimits:


function AddTinyBuildingItem takes integer abilityId,integer buildingTypeId returns nothing
    call SaveInteger(TinyBuildingsLimits__h, abilityId, 0, buildingTypeId)
endfunction

function CheckTinyBuildingForPlayer takes unit caster,integer unitTypeId returns boolean
    local player owner= GetOwningPlayer(caster)
    local integer max= GetPlayerTechMaxAllowed(owner, unitTypeId)
    if ( max >= 0 ) then
        if ( CountLivingPlayerUnitsOfTypeIdFast(unitTypeId , owner) >= max ) then
            call IssueImmediateOrder(caster, "stop")
            call SimError(owner , s__AFormat_result(s__AFormat_s(s__AFormat_i((s__AFormat_create((GetLocalizedString("REACHED_LIMIT_OF_X_FOR_Y")))),max),GetObjectName(unitTypeId)))) // INLINED!!
            set owner=null
            
            return false
        endif
    endif
    
    set owner=null
    
    return true
endfunction

function TinyBuildingsLimits__TriggerConditionConstruct takes nothing returns boolean
    local integer buildingTypeId= LoadInteger(TinyBuildingsLimits__h, GetSpellAbilityId(), 0)
    if ( buildingTypeId != 0 ) then
        call CheckTinyBuildingForPlayer(GetTriggerUnit() , buildingTypeId)
    endif
    return false
endfunction

function TinyBuildingsLimits__Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(TinyBuildingsLimits__constructionTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(TinyBuildingsLimits__constructionTrigger, Condition(function TinyBuildingsLimits__TriggerConditionConstruct))
endfunction


//library TinyBuildingsLimits ends
//library Helpers:

function AddMapTinyBuildingItem takes nothing returns nothing
    call SaveInteger(TinyBuildingsLimits__h, (udg_AbilityCode ), 0, ( udg_UnitType)) // INLINED!!
endfunction


//library Helpers ends
//===========================================================================
// 
// Tiny Buildings Limits 1.0
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
//*  Barades Unit Group Utils
//***************************************************************************
//*  Barades String Utils
//***************************************************************************
//*  Barades String Format
//***************************************************************************
//*  Barades Tiny Buildings Limits
//***************************************************************************
//*  Helpers

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

    set gg_unit_Hamg_0012=BlzCreateUnitWithSkin(p, 'Hamg', 72.8, - 60.4, 270.000, 'Hamg')
    call SetHeroLevel(gg_unit_Hamg_0012, 10, false)
    call SetUnitState(gg_unit_Hamg_0012, UNIT_STATE_MANA, 705)
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0012, 'AHmt')
    call UnitAddItemToSlotById(gg_unit_Hamg_0012, 'tfar', 0)
    call UnitAddItemToSlotById(gg_unit_Hamg_0012, 'tbar', 1)
    call UnitAddItemToSlotById(gg_unit_Hamg_0012, 'tlum', 2)
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hamg_0013=BlzCreateUnitWithSkin(p, 'Hamg', - 64.0, - 56.9, 270.000, 'Hamg')
    call SetHeroLevel(gg_unit_Hamg_0013, 10, false)
    call SetUnitState(gg_unit_Hamg_0013, UNIT_STATE_MANA, 705)
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHbz')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHwe')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHab')
    call SelectHeroSkill(gg_unit_Hamg_0013, 'AHmt')
    call UnitAddItemToSlotById(gg_unit_Hamg_0013, 'tfar', 0)
    call UnitAddItemToSlotById(gg_unit_Hamg_0013, 'tbar', 1)
    call UnitAddItemToSlotById(gg_unit_Hamg_0013, 'tlum', 2)
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
// Trigger: Init Tiny Building Items
//===========================================================================
function Trig_Init_Tiny_Building_Items_Actions takes nothing returns nothing
    // #############################################
    set udg_AbilityCode='AIbf'
    set udg_UnitType='hhou'
    call SaveInteger(TinyBuildingsLimits__h, (udg_AbilityCode ), 0, ( udg_UnitType)) // INLINED!!
    // #############################################
endfunction

//===========================================================================
function InitTrig_Init_Tiny_Building_Items takes nothing returns nothing
    set gg_trg_Init_Tiny_Building_Items=CreateTrigger()
    call TriggerAddAction(gg_trg_Init_Tiny_Building_Items, function Trig_Init_Tiny_Building_Items_Actions)
endfunction

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
    call SelectUnitForPlayerSingle(gg_unit_Hamg_0012, Player(0))
    call SetPlayerTechMaxAllowedSwap('hhou', 4, Player(0))
    call SetPlayerTechMaxAllowedSwap('hlum', 4, Player(0))
    call SelectUnitForPlayerSingle(gg_unit_Hamg_0013, Player(1))
    call SetPlayerTechMaxAllowedSwap('hhou', 4, Player(1))
    call SetPlayerTechMaxAllowedSwap('hlum', 4, Player(1))
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_034")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_037")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_035")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_036")
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Init_Tiny_Building_Items()
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Init_Tiny_Building_Items)
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

call ExecuteFunc("jasshelper__initstructs298686343")
call ExecuteFunc("SimError__init")
call ExecuteFunc("UnitGroupUtils__Init")
call ExecuteFunc("TinyBuildingsLimits__Init")

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

function jasshelper__initstructs298686343 takes nothing returns nothing


endfunction

