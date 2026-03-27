library WoWReforgedCalendarMultiboard initializer Init requires TimeOfDayUtils, OnStartGame, WoWReforgedCalendar, WoWReforgedI18n

globals
    private constant real SIZE = 0.06

    private multiboard m = null
    private timer t = CreateTimer()
endglobals

function GetCalendarMultiboardTimerHandleId takes nothing returns integer
    return GetHandleId(t)
endfunction

function ShowCalendarMultiboard takes nothing returns nothing
    call MultiboardDisplay(m, true)
endfunction

function HideCalendarMultiboard takes nothing returns nothing
    call MultiboardDisplay(m, false)
endfunction

function ShowCalendarMultiboardForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call ShowCalendarMultiboard()
    endif
endfunction

function HideCalendarMultiboardForPlayer takes player whichPlayer returns nothing
    if (whichPlayer == GetLocalPlayer()) then
        call HideCalendarMultiboard()
    endif
endfunction

private function UpdateMultiboard takes nothing returns nothing
    local multiboarditem mbitem = null
    local CalendarEvent e = GetRunningCalendarEvent()

    set mbitem = MultiboardGetItem(m, 0, 1)
    call MultiboardSetItemIcon(mbitem, GetSeasonIcon(GetCurrentSeason()))
    call MultiboardSetItemValue(mbitem, GetSeasonName(GetCurrentSeason()))
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 1, 1)
    call MultiboardSetItemIcon(mbitem, GetCurrentWeatherIcon())
    call MultiboardSetItemValue(mbitem, GetCurrentWeatherName())
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 2, 1)
    call MultiboardSetItemValue(mbitem, GetCurrentDate())
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 3, 1)
    call MultiboardSetItemValue(mbitem, GetMonthName(GetCurrentMonth()))
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 4, 1)
    call MultiboardSetItemValue(mbitem, FormatTimeOfDay())
    if (IsNight()) then
        call MultiboardSetItemIcon(mbitem, "ReplaceableTextures\\CommandButtons\\BTNElunesBlessing.blp")
    else
        call MultiboardSetItemIcon(mbitem, "ReplaceableTextures\\CommandButtons\\BTNDay Time2.blp")
    endif
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 5, 1)
    if (e != 0) then
        call MultiboardSetItemValue(mbitem, GetLocalizedString(e.name))
        call MultiboardSetItemValue(mbitem, e.icon)
        call MultiboardSetItemStyle(mbitem, true, true)
    else
        call MultiboardSetItemValue(mbitem, GetLocalizedString("DASH"))
        call MultiboardSetItemStyle(mbitem, true, false)
    endif
    call MultiboardReleaseItem(mbitem)
endfunction

private function StartGame takes nothing returns nothing
    local multiboarditem mbitem = null
    
    set m = CreateMultiboard()
    call MultiboardSetTitleText(m, GetLocalizedString("CALENDAR"))
    call MultiboardSetColumnCount(m, 2)
    call MultiboardSetRowCount(m, 6)
    call MultiboardDisplay(m, false)
    
    set mbitem = MultiboardGetItem(m, 0, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_SEASON"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 0, 1)
    call MultiboardSetItemStyle(mbitem, true, true)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 1, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_WEATHER"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 1, 1)
    call MultiboardSetItemStyle(mbitem, true, true)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 2, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_DATE"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 2, 1)
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 3, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_MONTH"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 3, 1)
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 4, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_TIME"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 4, 1)
    call MultiboardSetItemStyle(mbitem, true, true)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 5, 0)
    call MultiboardSetItemValue(mbitem, GetLocalizedString("COLON_EVENT"))
    call MultiboardSetItemStyle(mbitem, true, false)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    set mbitem = MultiboardGetItem(m, 5, 1)
    call MultiboardSetItemStyle(mbitem, true, true)
    call MultiboardSetItemWidth(mbitem, SIZE)
    call MultiboardReleaseItem(mbitem)
    
    call TimerStart(t, 0.3, true, function UpdateMultiboard)
endfunction

function FixCalendarMultiboardTitleColor takes nothing returns nothing
    call MultiboardSetTitleTextColorBJ(m, 100, 80, 20, 0)
endfunction

private function Init takes nothing returns nothing
    call OnStartGame(function StartGame)
endfunction


endlibrary
