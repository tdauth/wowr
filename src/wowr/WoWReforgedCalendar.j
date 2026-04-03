library WoWReforgedCalendar initializer Init requires StringUtils, TreeUtils, WeatherEffectUtils, TimeOfDayUtils, Votes, OnStartGame, WoWReforgedUtils, WoWReforgedTerrain, WoWReforgedZones, WoWReforgedI18n

struct TreeMapping
    integer summerId
    integer fallId
    integer winterId
    integer winterSnowyId
    integer easterId
    integer christmasId
endstruct

struct TileMapping
    integer summerId
    integer fallId
    integer winterId
endstruct

function interface CalendarEventFunction takes CalendarEvent e returns nothing

struct CalendarEvent
    string name
    string vote
    integer startDay
    real startTimeOfDay
    integer endDay
    real endTimeOfDay
    CalendarEventFunction startFunc
    CalendarEventFunction endFunc
    string icon
    trigger voteTrigger = CreateTrigger()
    boolean running = false
endstruct

globals
    constant integer DAYS_PER_YEAR = 36
    constant integer DAYS_PER_MONTH = DAYS_PER_YEAR / 12
    constant integer WINTER_DAY = 0
    constant integer SPRING_DAY = 9
    constant integer SUMMER_DAY = 18
    constant integer FALL_DAY = 27

    constant real MIN_NO_WEATHER_DURATION = 60.0
    constant real MAX_NO_WEATHER_DURATION = 440.0
    constant real MIN_WEATHER_DURATION = 30.0
    constant real MAX_WEATHER_DURATION = 240.0
    constant real MIN_THUNDER_DURATION = 10.0
    constant real MAX_THUNDER_DURATION = 120.0

    constant integer SEASON_SUMMER = 0
    constant integer SEASON_SPRING = 1
    constant integer SEASON_FALL = 2
    constant integer SEASON_WINTER = 3
    
    constant integer JANUARY = 1
    constant integer FEBRUARY = 2
    constant integer MARCH = 3
    constant integer APRIL = 4
    constant integer MAY = 5
    constant integer JUNE = 6
    constant integer JULY = 7
    constant integer AUGUST = 8
    constant integer SEPTEMBER = 9
    constant integer OCTOBER = 10
    constant integer NOVEMBER = 11
    constant integer DECEMBER = 12
    
    private integer passedTime = 0
    private trigger changeDayTrigger = CreateTrigger()
    private timer changeSecondTimer = CreateTimer()
    private weathereffect array weather
    private integer array weatherEffectIds
    private integer days = SUMMER_DAY // we always start in summer
    private integer years = 24
    private integer season = SEASON_WINTER
    
    private boolean seasonsEnabled = true
    
    private boolean easterTrees = false
    private boolean christmasTrees = false
    private effect array newYearEffects
    
    private boolean weatherRunning = false
    private timer weatherTimer = CreateTimer()
    private timer thunderTimer = CreateTimer()
    
    private TileMapping array tileMappings
    private integer tileMappingsCounter = 0
    
    private CalendarEvent array calendarEvents
    private integer calendarEventsCounter = 0
    
    private hashtable h = InitHashtable()
    
    private filterfunc filterIsMineWithResourceWaterNotFull = null
    
    private rect tmpRect = null
endglobals

function GetCalendarChangeSecondTimerHandleId takes nothing returns integer
    return GetHandleId(changeSecondTimer)
endfunction

function GetCalendarThunderTimerHandleId takes nothing returns integer
    return GetHandleId(thunderTimer) 
endfunction

function GetCalendarWeatherTimerHandleId takes nothing returns integer
    return GetHandleId(weatherTimer)
endfunction

function IsBetweenCalendarDay takes integer startDay, real startTimeOfDay, integer endDay, real endTimeOfDay returns boolean
    if (days < startDay or days > endDay) then
        return false
    elseif (startDay == endDay and not IsBetweenTimeOfDay(startTimeOfDay, endTimeOfDay)) then
        return false
    elseif (days == startDay and not IsBetweenTimeOfDay(startTimeOfDay, 0.0)) then
        return false
    elseif (days == endDay and IsBetweenTimeOfDay(0.0, endTimeOfDay)) then
        return false
    endif
    return false
endfunction

private function TriggerActionVote takes nothing returns nothing
    local CalendarEvent e = LoadInteger(h, GetHandleId(GetTriggeringTrigger()), 0)
    if (e.running) then
        if (e.endFunc != 0) then
            call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("EVENT_STARTING")).s(GetLocalizedString(e.name)).result())
            call e.endFunc.execute(e)
            set e.running = false
        endif
    else
        if (e.startFunc != 0) then
            set e.running = true
            call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("EVENT_ENDING")).s(GetLocalizedString(e.name)).result())
            call e.startFunc.execute(e)
        endif
    endif
endfunction

function GetCalendarEventsMax takes nothing returns integer
    return calendarEventsCounter
endfunction

function GetCalendarEvent takes integer index returns CalendarEvent
    return calendarEvents[index]
endfunction

function AddCalendarEvent takes string name, string vote, integer startDay, real startTimeOfDay, integer endDay, real endTimeOfDay, CalendarEventFunction startFunc, CalendarEventFunction endFunc, string icon returns CalendarEvent
    local CalendarEvent e = CalendarEvent.create()
    local integer v = 0
    set e.name = name
    set e.vote = vote
    set e.startDay = startDay
    set e.startTimeOfDay = startTimeOfDay
    set e.endDay = endDay
    set e.endTimeOfDay = endTimeOfDay
    set e.startFunc = startFunc
    set e.endFunc = endFunc
    set e.icon = icon
    set calendarEvents[calendarEventsCounter] = e
    set calendarEventsCounter = calendarEventsCounter + 1
    
    call SaveInteger(h, GetHandleId(e.voteTrigger), 0, e)
    call TriggerAddAction(e.voteTrigger, function TriggerActionVote)

    set v = VoteCreate(name)
    //call VoteAddYesChoice(vote)
    call VoteAddChoice(v, false, vote, vote)
    call VoteSetStartChatCommand(v, vote)
    call VoteSetYesTrigger(v, e.voteTrigger)
    
    return e
endfunction

// use when dropping more food during harvesting season or candy during halloween
function IsCalendarEventRunning takes CalendarEvent e returns boolean
       return e.running
endfunction

// call this on every change of time
private function CheckCalendarEvents takes nothing returns nothing
    local CalendarEvent e = 0
    local integer i = 0
    set passedTime = passedTime + 1
    loop
        exitwhen (i >= calendarEventsCounter)
        set e = calendarEvents[i]
        if (e.running) then 
           if (not IsBetweenCalendarDay(e.startDay, e.startTimeOfDay, e.endDay, e.endTimeOfDay)) then
                if (e.endFunc != 0) then
                    call e.endFunc.execute(e)
                    set e.running = false
                endif
            endif
        else
            if (IsBetweenCalendarDay(e.startDay, e.startTimeOfDay, e.endDay, e.endTimeOfDay)) then
                if (e.startFunc != 0) then
                    set e.running = true
                    call DisplayTextToForce(GetPlayersAll(), Format(GetLocalizedString("CALENDAR_EVENT_START")).s(GetLocalizedString(e.name)).result())
                    call e.startFunc.execute(e)
                endif
            endif
        endif
        set i = i + 1
    endloop
endfunction

function GetRunningCalendarEvent takes nothing returns CalendarEvent
    local CalendarEvent e = 0
    local integer i = 0
    loop
        exitwhen (i >= calendarEventsCounter)
        set e = calendarEvents[i]
        if (e.running) then 
           return e
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function AddTreeMapping takes integer summerId, integer fallId, integer winterId, integer winterSnowyId, integer easterId, integer christmasId returns TreeMapping
    local TreeMapping t = TreeMapping.create()
    set t.summerId = summerId
    set t.fallId = fallId
    set t.winterId = winterId
    set t.winterSnowyId = winterSnowyId
    set t.easterId = easterId
    set t.christmasId = christmasId
    
    call SaveInteger(h, summerId, 0, t)
    call SaveInteger(h, fallId, 0, t)
    call SaveInteger(h, winterId, 0, t)
    call SaveInteger(h, winterSnowyId, 0, t)
    call SaveInteger(h, easterId, 0, t)
    call SaveInteger(h, christmasId, 0, t)
    
    return t
endfunction

function GetTreeMappingById takes integer id returns TreeMapping
    if (HaveSavedInteger(h, id, 0)) then
        return LoadInteger(h, id, 0)
    endif
    return 0
endfunction

function AddTileMapping takes integer summerId, integer fallId, integer winterId returns TileMapping
    local TileMapping t = TileMapping.create()
    set t.summerId = summerId
    set t.fallId = fallId
    set t.winterId = winterId
    set tileMappings[tileMappingsCounter] = t
    set tileMappingsCounter = tileMappingsCounter + 1
    
    call SaveInteger(h, summerId, 0, t)
    call SaveInteger(h, fallId, 0, t)
    call SaveInteger(h, winterId, 0, t)
    
    return t
endfunction

function GetTileMappingById takes integer id returns TileMapping
    return LoadInteger(h, id, 0)
endfunction

function GetCurrentWeatherIcon takes nothing returns string
    if (weatherRunning) then
        return "ReplaceableTextures\\CommandButtons\\BTNRainyWeather.blp"
    endif
    return "ReplaceableTextures\\CommandButtons\\BTNOrbOfTheSun.blp"
endfunction

function GetCurrentWeatherName takes nothing returns string
    if (weatherRunning) then
        return GetLocalizedString("BAD")
    endif
    return GetLocalizedString("GOOD")
endfunction

function GetSeasonName takes integer s returns string
    if (s == SEASON_SUMMER) then
        return GetLocalizedString("SUMMER")
    elseif (s == SEASON_SPRING) then
        return GetLocalizedString("SPRING")
    elseif (s == SEASON_FALL) then
        return GetLocalizedString("FALL")
    endif
    return GetLocalizedString("WINTER")
endfunction

function GetSeasonIcon takes integer s returns string
    if (s == SEASON_SUMMER) then
        return "ReplaceableTextures\\CommandButtons\\BTNOrbOfTheSun.blp"
    elseif (s == SEASON_SPRING) then
        return "ReplaceableTextures\\CommandButtons\\BTNFlower1.blp"
    elseif (s == SEASON_FALL) then
        return "ReplaceableTextures\\CommandButtons\\BTNEntangled Gold Mine (Fall).blp"
    endif
    return "ReplaceableTextures\\CommandButtons\\BTNSnowFlake.blp"
endfunction

function GetCurrentSeason takes nothing returns integer
    return season
endfunction

function GetPassedTime takes nothing returns integer
    return passedTime
endfunction

function GetCurrentDay takes nothing returns integer
    return days
endfunction

function GetCurrentYear takes nothing returns integer
    return years
endfunction

function GetCurrentMonth takes nothing returns integer
    return days / DAYS_PER_MONTH + 1
endfunction

function GetDayByMonth takes integer day, integer month returns integer
    return day + (month - 1) * DAYS_PER_MONTH
endfunction

function GetMonthName takes integer month returns string
    if (month == JANUARY) then
        return GetLocalizedString("MONTH_01")
    elseif (month == FEBRUARY) then
        return GetLocalizedString("MONTH_02")
    elseif (month == MARCH) then
        return GetLocalizedString("MONTH_03")
    elseif (month == APRIL) then
        return GetLocalizedString("MONTH_04")
    elseif (month == MAY) then
        return GetLocalizedString("MONTH_05")
    elseif (month == JUNE) then
        return GetLocalizedString("MONTH_06")
    elseif (month == JULY) then
        return GetLocalizedString("MONTH_07")
    elseif (month == AUGUST) then
        return GetLocalizedString("MONTH_08")
    elseif (month == SEPTEMBER) then
        return GetLocalizedString("MONTH_09")
    elseif (month == OCTOBER) then
        return GetLocalizedString("MONTH_10")
    elseif (month == NOVEMBER) then
        return GetLocalizedString("MONTH_11")
    elseif (month == DECEMBER) then
        return GetLocalizedString("MONTH_12")
    endif
    
    return "Unknown"
endfunction

function GetCurrentDate takes nothing returns string
    return Format(GetLocalizedString("CALENDAR_DATE_SHORT")).i(GetCurrentYear()).s(I2SW(GetCurrentMonth(), 2)).s(I2SW(GetCurrentDay(), 2)).result()
endfunction

function GetTimeText takes nothing returns string
    return Format(GetLocalizedString("CALENDAR_TIME_TEXT")).s(GetCurrentDate()).s(GetMonthName(GetCurrentMonth())).s(GetSeasonName(GetCurrentSeason())).s(FormatTimeOfDay()).s(FormatTimeString(GetPassedTime())).s(FormatTimeString(R2I(TimerGetRemaining(weatherTimer)))).s(FormatTimeString(R2I(TimerGetRemaining(thunderTimer)))).result()
endfunction

function DisplayTime takes player whichPlayer returns nothing
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, GetTimeText())
endfunction

globals
    private integer sourceSeason = 0
    private integer targetSeason = 0
    private filterfunc treeFilter = null
endglobals

private function FilterIsTree takes nothing returns boolean
    return GetTreeMappingById(GetDestructableTypeId(GetFilterDestructable())) != 0
endfunction

private function ReplaceTreeEx takes destructable d, TreeMapping t returns nothing
    local real x = GetDestructableX(d)
    local real y = GetDestructableY(d)
    local real life = GetDestructableLife(d)
    local integer targetId = t.summerId
    if (easterTrees) then
        set targetId = t.easterId
    elseif (christmasTrees) then
        set targetId = t.christmasId
    elseif (targetSeason == SEASON_SUMMER) then
        set targetId = t.summerId
    elseif (targetSeason == SEASON_FALL) then
        set targetId = t.fallId
    elseif (targetSeason == SEASON_WINTER) then
        if (weatherRunning) then
            set targetId = t.winterSnowyId
        else
            set targetId = t.winterId
        endif
    elseif (targetSeason == SEASON_SPRING) then
        set targetId = t.summerId
    endif
    if (targetId != 0) then
        call RemoveDestructable(d)
        set d = null
        set d = CreateDestructable(targetId, x, y, GetRandomDirectionDeg(), 1.0, 0)
        call SetDestructableLife(d, life)
        set d = null
    endif
endfunction

private function ReplaceTree takes nothing returns nothing
    local destructable d = GetEnumDestructable()
    local TreeMapping t = GetTreeMappingById(GetDestructableTypeId(d))
    if (t != 0) then
        call ReplaceTreeEx(d, t)
    endif
    set d = null
endfunction

private function ReplaceTreeNewOpLimit takes nothing returns nothing
    call NewOpLimit(function ReplaceTree)
endfunction

private function ReplaceTreesNewOpLimit takes nothing returns nothing
    // TODO Causes an endless lag!
    //call EnumDestructablesInRect(tmpRect, treeFilter, function ReplaceTreeNewOpLimit)
endfunction

private function ReplaceTrees takes rect r, integer source, integer target returns nothing
    set tmpRect = r
    set sourceSeason = source
    set targetSeason = target
    call NewOpLimit(function ReplaceTreesNewOpLimit)
endfunction

private function ReplaceAffectedWithTrees takes integer source, integer target returns nothing
    local Zone z = 0
    local integer t = TERRAIN_TYPE_NONE
    local integer j = 0
    local integer max2 = 0
    local integer max = GetZonesMax()
    local integer i = 0
    //call BJDebugMsg("Trees")
    loop
        exitwhen (i >= max)
        set z = GetZone(i)
        set t = GetZoneTerrainType(z)
        //call BJDebugMsg(GetZoneName(z) + " with rects counter " + I2S(GetZoneRectsCounter(z)) + " and terrain type " + I2S(t))
        if (t == TERRAIN_TYPE_LORDAERON or t == TERRAIN_TYPE_ASHENVALE) then
            //call BJDebugMsg("Trees zone " + I2S(z) + " zone name " + z.name + "has terrain Lordaeron or Ashenvale")
            set j = 0
            set max2 = GetZoneRectsCounter(z)
            loop
                exitwhen (j >= max2)
                call ReplaceTrees(GetZoneRect(z, j), source, target)
                set j = j + 1
            endloop
        endif
        //call BJDebugMsg("After trees")
        set i = i + 1
    endloop
endfunction

private function ReplaceWithWinterTrees takes nothing returns nothing
    call ReplaceAffectedWithTrees(season, SEASON_WINTER)
endfunction

private function ReplaceWithSummerTrees takes nothing returns nothing
    call ReplaceAffectedWithTrees(season, SEASON_SUMMER)
endfunction

private function ReplaceWithFallTrees takes nothing returns nothing
    call ReplaceAffectedWithTrees(season, SEASON_FALL)
endfunction

private function GetEffectIndex takes integer zoneIndex, integer rectIndex returns integer
    return Index2D(zoneIndex, rectIndex, MAX_ZONE_RECTS)
endfunction

private function HasWeather takes integer t returns boolean
    return t != TERRAIN_TYPE_NONE
endfunction

private function GetRandomWeatherEffect takes integer t returns integer
    if (t == TERRAIN_TYPE_ASHENVALE) then
        if (GetCurrentSeason() == SEASON_WINTER) then
            return GetRandomSnowWeatherEffect()
        else
            return GetRandomAshenvaleRainWeatherEffect()
        endif
    elseif (t == TERRAIN_TYPE_LORDAERON) then
        if (GetCurrentSeason() == SEASON_WINTER) then
            return GetRandomSnowWeatherEffect()
        else
            return GetRandomLordaeronRainWeatherEffect()
        endif
    elseif (t == TERRAIN_TYPE_LORDAERON_FALL) then
        return GetRandomLordaeronRainWeatherEffect()
    elseif (t == TERRAIN_TYPE_NORTHREND) then
        return GetRandomSnowWeatherEffect()
    elseif (t == TERRAIN_TYPE_BARRENS) then
        return WIND_HEAVY
    elseif (t == TERRAIN_TYPE_OUTLAND) then
        return GetRandomOutlandWindWeatherEffect()
    elseif (t == TERRAIN_TYPE_SUNKEN_RUINS) then
        return GetRandomAshenvaleRainWeatherEffect()
    elseif (t == TERRAIN_TYPE_SEA) then
        return GetRandomSeaWeatherEffect()
    elseif (t == TERRAIN_TYPE_DUNGEON or t == TERRAIN_TYPE_UNDERGROUND) then
        return GetRandomDungeonWhiteFogEffect()
    endif
    
    return 0
endfunction

private function ForForceAddWeatherResourceBonus takes nothing returns nothing
    call AddPlayerResourceBonus(GetEnumPlayer(), udg_ResourceWater, 20)
endfunction

private function ForForceRemoveWeatherResourceBonus takes nothing returns nothing
    call RemovePlayerResourceBonus(GetEnumPlayer(), udg_ResourceWater, 20)
endfunction

private function AddWeatherResourceBonus takes nothing returns nothing
    call ForForce(GetPlayersAll(), function ForForceAddWeatherResourceBonus)
endfunction

private function RemoveWeatherResourceBonus takes nothing returns nothing
    call ForForce(GetPlayersAll(), function ForForceRemoveWeatherResourceBonus)
endfunction

private function EnumUnitFillWater takes nothing returns nothing
    call SetUnitResource(GetEnumUnit(), udg_ResourceWater, GetUnitResourceMax(GetEnumUnit(), udg_ResourceWater))
endfunction

private function RainAddResourceBonus takes rect r returns nothing
    local group g = CreateGroup()
    call GroupEnumUnitsInRect(g, r, filterIsMineWithResourceWaterNotFull)
    call ForGroup(g, function EnumUnitFillWater)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function RemoveWeatherEffects takes nothing returns nothing
    local Zone z = 0
    local integer t = TERRAIN_TYPE_NONE
    local integer j = 0
    local integer max2 = 0
    local integer index = 0
    local integer max = GetZonesMax()
    local integer i = 0
    if (weatherRunning) then
        call RemoveWeatherResourceBonus()
        set weatherRunning = false
    endif
    loop
        exitwhen (i >= max)
        set z = GetZone(i)
        set t = GetZoneTerrainType(z)
        set j = 0
        set max2 = GetZoneRectsCounter(z)
        loop
            exitwhen (j >= max2)
            set index = GetEffectIndex(i, j)
            if (weather[index] != null) then
                call EnableWeatherEffect(weather[index], false)
                call RemoveWeatherEffect(weather[index])
                set weather[index] = null
                set weatherEffectIds[index] = 0
            endif
            if (t == TERRAIN_TYPE_LORDAERON or t == TERRAIN_TYPE_ASHENVALE) then
                call ReplaceTrees(GetZoneRect(z, j), GetCurrentSeason(), GetCurrentSeason())
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function AddWeatherEffects takes nothing returns nothing
    local Zone z = 0
    local integer t = TERRAIN_TYPE_NONE
    local integer j = 0
    local integer max2 = 0
    local integer index = 0
    local integer max = GetZonesMax()
    local integer i = 0
    if (not weatherRunning) then
        call AddWeatherResourceBonus()
        set weatherRunning = true
    endif
    loop
        exitwhen (i >= max)
        set z = GetZone(i)
        set t = GetZoneTerrainType(z)
        if (HasWeather(t)) then
            set j = 0
            set max2 = GetZoneRectsCounter(z)
            loop
                exitwhen (j >= max2)
                set index = GetEffectIndex(i, j)
                if (weather[index] != null) then
                    call EnableWeatherEffect(weather[index], false)
                    call RemoveWeatherEffect(weather[index])
                    set weather[index] = null
                    set weatherEffectIds[index] = 0
                endif
                set weatherEffectIds[index] = GetRandomWeatherEffect(t)
                if (weatherEffectIds[index] != 0) then
                    set weather[index] = AddWeatherEffect(GetZoneRect(z, j), weatherEffectIds[index])
                    call EnableWeatherEffect(weather[index], true)
                    
                    if (IsRainWeatherEffect(weatherEffectIds[index])) then
                        call RainAddResourceBonus(GetZoneRect(z, j))
                    endif
                endif
                
                if ((t == TERRAIN_TYPE_LORDAERON or t == TERRAIN_TYPE_ASHENVALE) and GetCurrentSeason() == SEASON_WINTER) then
                    call ReplaceTrees(GetZoneRect(z, j), SEASON_WINTER, SEASON_WINTER)
                endif
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
endfunction

function Lightning takes nothing returns nothing
    //call PlaySound("Sound\\Doodads\\Cinematic\\Lightningbolt\\LightningBolt1.flac")
    // call PlaySound("Abilities\\Spells\\Orc\\LightningBolt\\LightningBolt.flac")
    call StartSound(gg_snd_LightningBoltWeather)
    call CinematicFilterGenericBJ(1.0, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100.0, 100.0, 100.0, 0.0, 100.0, 100.0, 100.0, 100.0)
    //call BJDebugMsg("Lightning")
endfunction

function Thunder takes nothing returns nothing
    call StartSound(gg_snd_RollingThunder1)
    //call PlaySound("Sound\\Ambient\\DoodadEffects\\RollingThunder1.flac")
    //call BJDebugMsg("Thunder")
endfunction

private function TimerFunctionThunder takes nothing returns nothing
    if (GetRandomInt(0, 1) == 0) then
        call Thunder()
    else
        call Lightning()
    endif
endfunction

private function StopThunder takes nothing returns nothing
    call PauseTimer(thunderTimer)
endfunction

private function StartThunder takes nothing returns nothing
    call TimerStart(thunderTimer, GetRandomReal(MIN_THUNDER_DURATION, MAX_THUNDER_DURATION), true, function TimerFunctionThunder)
endfunction

private function TimerFunctionEndWeather takes nothing returns nothing
    call NewOpLimit(function RemoveWeatherEffects)
    //call BJDebugMsg("Stop thunder 1")
    call StopThunder()
    //call BJDebugMsg("Stop thunder 2")
endfunction

private function EndWeather takes nothing returns nothing
    call TimerStart(weatherTimer, GetRandomReal(MIN_WEATHER_DURATION, MAX_WEATHER_DURATION), false, function TimerFunctionEndWeather)
endfunction

private function TimerFunctionStartWeather takes nothing returns nothing
    call NewOpLimit(function AddWeatherEffects)
    call StartThunder()
    call EndWeather()
endfunction

function StartWeather takes nothing returns nothing
    //call BJDebugMsg("Start weather 1")
    call TimerStart(weatherTimer, GetRandomReal(MIN_NO_WEATHER_DURATION, MAX_NO_WEATHER_DURATION), false, function TimerFunctionStartWeather)
    //call BJDebugMsg("Start weather 2")
endfunction

function StartWeatherImmediately takes nothing returns nothing
    call TimerStart(weatherTimer, 0.0, false, function TimerFunctionStartWeather)
endfunction

function StopWeather takes nothing returns nothing
    //call BJDebugMsg("Stop weather 1")
    call PauseTimer(weatherTimer)
    //call BJDebugMsg("Stop weather 2")
    call PauseTimer(thunderTimer)
    //call BJDebugMsg("Stop weather 3")
    call TimerFunctionEndWeather()
    //call BJDebugMsg("Stop weather 4")
endfunction

private function ReplaceWithTerrain takes rect whichRect, integer source, integer target returns nothing
    local real x = GetRectMinX(whichRect)
    local real y = 0.0
    local real maxX = GetRectMaxX(whichRect)
    local real maxY = GetRectMaxY(whichRect)
    local TileMapping t = 0
    local integer targetId = 0
    loop
        exitwhen (x >= maxX)
        set y = GetRectMinY(whichRect)
        //call BJDebugMsg("ReplaceWithTerrain 2")
        loop
            exitwhen (y >= maxY)
            set t = GetTileMappingById(GetTerrainType(x, y))
            //call BJDebugMsg("ReplaceWithTerrain 3")
            if (t != 0) then
                if (target == SEASON_WINTER) then
                    set targetId = t.winterId
                elseif (target == SEASON_SUMMER) then
                    set targetId = t.summerId
                elseif (target == SEASON_SPRING) then
                    set targetId = t.summerId
                elseif (target == SEASON_FALL) then
                    set targetId = t.fallId
                endif
                call SetTerrainType(x, y, targetId, GetTerrainVariance(x, y), 1, 0)
                //call BJDebugMsg("ReplaceWithTerrain 4")
            endif
            //call BJDebugMsg("ReplaceWithTerrain 5")
            set y = y + bj_CELLWIDTH
        endloop
        set x = x  + bj_CELLWIDTH
    endloop
endfunction

private function ReplaceWithTerrainNewOpLmit takes nothing returns nothing
    call ReplaceWithTerrain(udg_TmpRect, sourceSeason, targetSeason)
endfunction

private function ReplaceAffectedWithTerrain takes integer source, integer target returns nothing
    local Zone z = 0
    local integer t = TERRAIN_TYPE_NONE
    local integer j = 0
    local integer max2 = 0
    local integer max = GetZonesMax()
    local integer i = 0
    //call BJDebugMsg("Replace terrain")
    loop
        exitwhen (i >= max)
        set z = GetZone(i)
        set t = GetZoneTerrainType(z)
        //call BJDebugMsg("Zone " + I2S(z))
        if (t == TERRAIN_TYPE_LORDAERON or t == TERRAIN_TYPE_ASHENVALE) then
            set j = 0
            set max2 = GetZoneRectsCounter(z)
            loop
                exitwhen (j >= max2)
                set udg_TmpRect = GetZoneRect(z, j)
                set sourceSeason = source
                set targetSeason = target
                call NewOpLimit(function ReplaceWithTerrainNewOpLmit)
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
endfunction

private function ReplaceWithWinterTerrain takes nothing returns nothing
    call ReplaceAffectedWithTerrain(GetCurrentSeason(), SEASON_WINTER)
endfunction

private function ReplaceWithSummerTerrain takes nothing returns nothing
    call ReplaceAffectedWithTerrain(GetCurrentSeason(), SEASON_SUMMER)
endfunction

private function ReplaceWithFallTerrain takes nothing returns nothing
    call ReplaceAffectedWithTerrain(GetCurrentSeason(), SEASON_FALL)
endfunction

private function ForForceAddFallResourceBonus takes nothing returns nothing
    call AddPlayerResourceBonus(GetEnumPlayer(), udg_ResourceGrain, 20)
endfunction

private function ForForceRemoveFallResourceBonus takes nothing returns nothing
    call RemovePlayerResourceBonus(GetEnumPlayer(), udg_ResourceGrain, 20)
endfunction

private function ResourceBonus takes integer previousSeason, integer currentSeason returns nothing
    if (previousSeason == SEASON_FALL) then
        call ForForce(GetPlayersAll(), function ForForceRemoveFallResourceBonus)
    elseif (currentSeason == SEASON_FALL) then
        call ForForce(GetPlayersAll(), function ForForceAddFallResourceBonus)
    endif
endfunction

function Winter takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronWinterSky\\LordaeronWinterSky.mdl")
    call SetTerrainFogEx(0, 1000, 8000, 0, 1, 1, 1)
    call NewOpLimit(function ReplaceWithWinterTerrain)
    call NewOpLimit(function ReplaceWithWinterTrees)
    call ResourceBonus(GetCurrentSeason(), SEASON_WINTER)
    set season = SEASON_WINTER
    call StopWeather()
    call StartWeather()
endfunction

function Summer takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
    call SetTerrainFogEx(0, 1000, 8000, 0, 1, 1, 1)
    call NewOpLimit(function ReplaceWithSummerTerrain)
    call NewOpLimit(function ReplaceWithSummerTrees)
    call ResourceBonus(GetCurrentSeason(), SEASON_SUMMER)
    set season = SEASON_SUMMER
    call StopWeather()
    call StartWeather()
endfunction

function Spring takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronSummerSky.mdl")
    call SetTerrainFogEx(0, 1000, 8000, 0, 1, 1, 1)
    call NewOpLimit(function ReplaceWithSummerTerrain)
    call NewOpLimit(function ReplaceWithSummerTrees)
    call ResourceBonus(GetCurrentSeason(), SEASON_SPRING)
    set season = SEASON_SPRING
    call StopWeather()
    call StartWeather()
endfunction

function Fall takes nothing returns nothing
    call SetSkyModel("Environment\\Sky\\LordaeronSummerSky\\LordaeronFallSky.mdl")
    call SetTerrainFogEx(0, 1000, 8000, 0, 1, 1, 1)
    call NewOpLimit(function ReplaceWithFallTerrain)
    call NewOpLimit(function ReplaceWithFallTrees)
    call ResourceBonus(GetCurrentSeason(), SEASON_FALL)
    set season = SEASON_FALL
    call StopWeather()
    call StartWeather()
endfunction

function IsSeasonsEnabled takes nothing returns boolean
    return seasonsEnabled
endfunction

function HappyNewYear takes nothing returns nothing
    call QuestMessageBJ(GetPlayersAll(), bj_QUESTMESSAGE_ITEMACQUIRED, Format(GetLocalizedString("HAPPY_NEW_YEAR")).i(GetCurrentYear()).result())
endfunction

function WeatherPrediction takes player whichPlayer returns nothing
    local string msg = ""
    if (weatherRunning) then
        set msg = Format(GetLocalizedString("WEATHER_RUNNING")).s(FormatTime(TimerGetRemaining(thunderTimer))).s(FormatTime(TimerGetRemaining(weatherTimer))).result()
    else
        set msg = Format(GetLocalizedString("WEATHER_PREDICTION")).s(FormatTime(TimerGetRemaining(weatherTimer))).result()
    endif
    call DisplayTimedTextToPlayer(whichPlayer, 0.0, 0.0, 6.0, msg)
endfunction

private function TriggerConditionTimeOfDay takes nothing returns boolean
    if (days == DAYS_PER_YEAR) then
        set days = 1
        set years = years + 1
        
        call HappyNewYear()
    else
        set days = days + 1
    endif
    
    //call BJDebugMsg("Day " + I2S(days))
    
    if (IsSeasonsEnabled()) then
        //call BJDebugMsg("seasons " + I2S(days))
        
        if (days == SUMMER_DAY) then
            set season = SEASON_SUMMER
            call Summer()
        elseif (days == SPRING_DAY) then
            set season = SEASON_SPRING
            call Spring()
        elseif (days == FALL_DAY) then
            set season = SEASON_FALL
            call Fall()
        elseif (days == WINTER_DAY) then
            set season = SEASON_WINTER
            call Winter()
        endif
    endif
    
    return false
endfunction

function StartCurrentSeason takes nothing returns nothing
    if (days >= FALL_DAY) then
        set season = SEASON_FALL
        call Fall()
    elseif (days >= SUMMER_DAY) then
        set season = SEASON_SUMMER
        call Summer()
    elseif (days >= SPRING_DAY) then
        set season = SEASON_SPRING
        call Spring()
    else
        set season = SEASON_WINTER
        call Winter()
    endif
endfunction

function EnableCalendar takes nothing returns nothing
    call EnableTrigger(changeDayTrigger)
    call TimerStart(changeSecondTimer, 1.0, true, function CheckCalendarEvents)
    call StartCurrentSeason()
endfunction

function DisableCalendar takes nothing returns nothing
    call DisableTrigger(changeDayTrigger)
    call PauseTimer(changeSecondTimer)
    call PauseTimer(weatherTimer)
    call PauseTimer(thunderTimer)
endfunction

function EnableSeasons takes nothing returns nothing
    set seasonsEnabled = true
    call EnableCalendar()
endfunction

function DisableSeasons takes nothing returns nothing
    set seasonsEnabled = false
    call DisableCalendar()
endfunction

private function StartEaster takes CalendarEvent e returns nothing
    set easterTrees = true
    call ReplaceAffectedWithTrees(season, season)
    call PlaySoundBJ(gg_snd_EasterIntro)
endfunction

private function EndEaster takes CalendarEvent e returns nothing
    set easterTrees = false
    call ReplaceAffectedWithTrees(season, season)
endfunction

private function StartChristmas takes CalendarEvent e returns nothing
    set christmasTrees = true
    call ReplaceAffectedWithTrees(season, season)
endfunction

private function EndChristmas takes CalendarEvent e returns nothing
    set christmasTrees = false
    call ReplaceAffectedWithTrees(season, season)
endfunction

private function StartNewYear takes CalendarEvent e returns nothing
    local integer index = 0
    local Zone zone = 0
    local integer i = 0
    local integer max = GetZonesMax()
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set zone = GetZone(i)
        set max2 = GetZoneRectsCounter(zone)
        set j = 0
        loop
            exitwhen (j == max2)
            set index = Index2D(i, j, MAX_ZONE_RECTS)
            set newYearEffects[index] = AddSpecialEffect("war3mapImported\\Firework3.mdx", GetRectCenterX(GetZoneRect(zone, j)), GetRectCenterY(GetZoneRect(zone, j)))
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

private function EndNewYear takes CalendarEvent e returns nothing
    local integer index = 0
    local Zone zone = 0
    local integer i = 0
    local integer max = GetZonesMax()
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set zone = GetZone(i)
        set max2 = GetZoneRectsCounter(zone)
        set j = 0
        loop
            exitwhen (j == max2)
            set index = Index2D(i, j, MAX_ZONE_RECTS)
            if (newYearEffects[index] != null) then
                call DestroyEffect(newYearEffects[index])
                set newYearEffects[index] = null
            endif
            set j = j + 1
        endloop
        set i = i + 1
    endloop
endfunction

globals
    CalendarEvent easter = 0
    CalendarEvent christmas = 0
    CalendarEvent newyear = 0
    CalendarEvent thanksgiving = 0
    CalendarEvent halloween = 0
    CalendarEvent carnival = 0
endglobals

private function IsMineWithResourceWaterNotFull takes nothing returns boolean
    return IsMine(GetFilterUnit()) and GetUnitResourceMax(GetFilterUnit(), udg_ResourceWater) > 0 and GetUnitResource(GetFilterUnit(), udg_ResourceWater) < GetUnitResourceMax(GetFilterUnit(), udg_ResourceWater)    
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterGameStateEventTimeOfDay(changeDayTrigger, EQUAL, 0.0)
    call TriggerAddCondition(changeDayTrigger, Condition(function TriggerConditionTimeOfDay))
    call OnStartGame(function EnableCalendar)
    
    set treeFilter = Filter(function FilterIsTree)
    
    set filterIsMineWithResourceWaterNotFull = Filter(function IsMineWithResourceWaterNotFull)
    
    call AddTreeMapping(SUMMER_TREE_WALL, FALL_TREE_WALL, WINTER_TREE_WALL, SNOWY_TREE_WALL, EASTERN_TREE_WALL_1, CHRISTMAS_TREE_WALL)
    call AddTreeMapping(CITYSCAPE_SUMMER_TREE_WALL, CITYSCAPE_FALL_TREE_WALL, CITYSCAPE_WINTER_TREE_WALL, CITYSCAPE_SNOWY_TREE_WALL, CARROT_TREE_WALL_1, CITYSCAPE_CHRISTMAS_TREE_WALL)
    call AddTreeMapping(VILLAGE_TREE_WALL, VILLAGE_TREE_WALL_FALL, VILLAGE_TREE_WALL_WINTER, VILLAGE_SNOWY_TREE_WALL, CARROT_TREE_WALL_1, CITYSCAPE_CHRISTMAS_TREE_WALL)
    call AddTreeMapping(ASHENVALE_TREE_WALL, ASHENVALE_TREE_WALL_FALL, ASHENVALE_TREE_WALL_WINTER, ASHENVALE_SNOWY_TREE_WALL, CARROT_TREE_WALL_2, ASHENVALE_CHRISTMAS_TREE_WALL)
    call AddTreeMapping(ASHENVALE_CANOPY_TREE, ASHENVALE_CANOPY_TREE_FALL, ASHENVALE_CANOPY_TREE_WINTER, ASHENVALE_CANOPY_TREE_WINTER, CARROT_TREE_WALL_2, ASHENVALE_CANOPY_CHRISTMAS_TREE_WALL)
    call AddTreeMapping(AZUREMYST_ISLES_TREE_WALL, AZUREMYST_ISLES_TREE_WALL_FALL, AZUREMYST_ISLES_TREE_WALL_WINTER, AZUREMYST_ISLES_TREE_WALL_WINTER, CARROT_TREE_WALL_1, AZUREMYST_ISLES_CHRISTMAS_TREE_WALL)
    call AddTreeMapping(CRANNIES_SUMMER, CRANNIES_FALL, CRANNIES_WINTER, CRANNIES_WINTER_SNOWY, 0, 0)
    
    call AddTileMapping(TILE_TYPE_GRASS, TILE_TYPE_DARK_GRASS, TILE_TYPE_SNOW)
    
    set easter = AddCalendarEvent("EASTER", "-easter", GetDayByMonth(22, MARCH), 0.0, GetDayByMonth(25, APRIL), 24.0, StartEaster, EndEaster, "ReplaceableTextures\\CommandButtons\\BTNEasterWabbit.blp")
    set christmas = AddCalendarEvent("CHRISTMAS", "-christmas", GetDayByMonth(24, DECEMBER), 22.0, GetDayByMonth(26, DECEMBER), 24.0, StartChristmas, EndChristmas, "ReplaceableTextures\\CommandButtons\\BTNGiftHive.blp")
    set newyear = AddCalendarEvent("NEW_YEAR", "-newyear", GetDayByMonth(30, DECEMBER), 22.0, GetDayByMonth(1, JANUARY), 3.0, StartNewYear, EndNewYear, "ReplaceableTextures\\CommandButtons\\BTNFirework.blp")
    set thanksgiving = AddCalendarEvent("THANKSGIVING", "-thanksgiving", GetDayByMonth(6, OCTOBER), 0.0, GetDayByMonth(8, OCTOBER), 24.0, 0, 0, "ReplaceableTextures\\CommandButtons\\BTNWheat.blp")
    set halloween = AddCalendarEvent("HALLOWEEN", "-halloween", GetDayByMonth(30, OCTOBER), 22.0, GetDayByMonth(1, NOVEMBER), 3.0, 0, 0, "ReplaceableTextures\\CommandButtons\\BTNPumpkinMonster.blp")
    set carnival = AddCalendarEvent("CARNIVAL", "-carnival", GetDayByMonth(14, FEBRUARY), 0.0, GetDayByMonth(4, MARCH), 24.0, 0, 0, "ReplaceableTextures\\CommandButtons\\BTNMasks.blp")
endfunction

endlibrary
