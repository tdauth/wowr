library TimeOfDayUtils requires StringUtils

globals
    constant real HOURS_PER_DAY = 24.000
    constant real REAL_SECONDS_PER_DAY = 480.0
endglobals

function GetTimeOfDayHoursEx takes real timeOfDay returns integer
    return R2I(timeOfDay)
endfunction

function GetTimeOfDayHours takes nothing returns integer
    return GetTimeOfDayHoursEx(GetTimeOfDay())
endfunction

function GetTimeOfDayMinutesEx takes real timeOfDay returns integer
    return R2I(ModuloReal(timeOfDay, 1.0) * 60.0) 
endfunction

function GetTimeOfDayMinutes takes nothing returns integer
    return GetTimeOfDayMinutesEx(GetTimeOfDay()) 
endfunction

function FormatTimeOfDayEx takes real timeOfDay returns string
    return I2SW(GetTimeOfDayHoursEx(timeOfDay), 2) + ":" + I2SW(GetTimeOfDayMinutesEx(timeOfDay), 2)
endfunction

function FormatTimeOfDay takes nothing returns string
    return FormatTimeOfDayEx(GetTimeOfDay())
endfunction

function IsBetweenTimeOfDayEx takes real timeOfDay, real startTimeOfDay, real endTimeOfDay returns boolean
    if (startTimeOfDay < endTimeOfDay) then
        return timeOfDay >= startTimeOfDay and timeOfDay < endTimeOfDay
    endif
    return timeOfDay >= startTimeOfDay or timeOfDay < endTimeOfDay
endfunction

function IsBetweenTimeOfDay takes real startTimeOfDay, real endTimeOfDay returns boolean
    return IsBetweenTimeOfDayEx(GetTimeOfDay(), startTimeOfDay, endTimeOfDay)
endfunction

function IsDay takes nothing returns boolean
    local real ToD = GetTimeOfDay()
    return ToD >= bj_TOD_DAWN and ToD < bj_TOD_DUSK
endfunction

function IsNight takes nothing returns boolean
    local real ToD = GetTimeOfDay()
    return ToD >= bj_TOD_DUSK or ToD < bj_TOD_DAWN
endfunction

endlibrary
