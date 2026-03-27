library WeatherEffectUtils

globals
    constant integer ASHENVALE_RAIN_HEAVY = 'RAhr'
    constant integer ASHENVALE_RAIN_LIGHT = 'RAlr'
    constant integer LORDAERON_RAIN_HEAVY = 'RLhr'
    constant integer LORDAERON_RAIN_LIGHT = 'RLlr'
    constant integer NORTHREND_BLIZZARD = 'SNbs'
    constant integer NORTHREND_SNOW_HEAVY = 'SNhs'
    constant integer OUTLAND_WIND_HEAVY = 'WOcw'
    constant integer OUTLAND_WIND_LIGHT = 'WOlw'
    constant integer WIND_HEAVY = 'WNcw'
    constant integer DUNGEON_WHITE_FOG_HEAVY = 'FDwh'
    constant integer DUNGEON_WHITE_FOG_LIGHT = 'FDwl'
endglobals

function IsRainWeatherEffect takes integer effectId returns boolean
    if (effectId == ASHENVALE_RAIN_HEAVY) then
        return true
    elseif (effectId == ASHENVALE_RAIN_LIGHT) then
        return true
    elseif (effectId == LORDAERON_RAIN_HEAVY) then
        return true
    elseif (effectId == LORDAERON_RAIN_LIGHT) then
        return true
    endif
    return false
endfunction

function GetRandomAshenvaleRainWeatherEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = ASHENVALE_RAIN_HEAVY
    set counter = counter + 1
    set e[counter] = ASHENVALE_RAIN_LIGHT
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

function GetRandomLordaeronRainWeatherEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = LORDAERON_RAIN_HEAVY
    set counter = counter + 1
    set e[counter] = LORDAERON_RAIN_LIGHT
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

function GetRandomSnowWeatherEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = NORTHREND_BLIZZARD
    set counter = counter + 1
    set e[counter] = NORTHREND_SNOW_HEAVY
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

function GetRandomOutlandWindWeatherEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = OUTLAND_WIND_HEAVY
    set counter = counter + 1
    set e[counter] = OUTLAND_WIND_LIGHT
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

function GetRandomSeaWeatherEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = LORDAERON_RAIN_HEAVY
    set counter = counter + 1
    set e[counter] = LORDAERON_RAIN_LIGHT
    set counter = counter + 1
    set e[counter] = WIND_HEAVY
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

function GetRandomDungeonWhiteFogEffect takes nothing returns integer
    local integer array e
    local integer counter = 0
    set e[counter] = DUNGEON_WHITE_FOG_HEAVY
    set counter = counter + 1
    set e[counter] = DUNGEON_WHITE_FOG_LIGHT
    set counter = counter + 1
    
    return e[GetRandomInt(0, counter)]
endfunction

endlibrary
