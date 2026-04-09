library WoWReforgedDayNightCycleEffects initializer Init requires TimeOfDayUtils

globals
    private boolean effectsIsDaytime = false
    private filterfunc filter = null
    private trigger dayEffectsTrigger = null
    private trigger nightEffectsTrigger = null

    private integer array destructableIds
    private boolean array destructableHide
    private real array destructableHideDelay
    private integer destructableIdsCounter = 0

    private integer array doodadIds
    private string array doodadDayAnimNames
    private string array doodadNightAnimNames
    private integer doodadIdsCounter = 0
endglobals

private function AddDestructableEx takes integer id, boolean hide, real hideDelay returns nothing
    set destructableIds[destructableIdsCounter] = id
    set destructableHide[destructableIdsCounter] = hide
    set destructableHideDelay[destructableIdsCounter] = hideDelay
    set destructableIdsCounter = destructableIdsCounter + 1
endfunction

private function AddDestructable takes integer id returns nothing
    call AddDestructableEx(id, false, 0.0)
endfunction

private function GetDestructableIndex takes integer id returns integer
    local integer i = 0
    loop
        exitwhen (i >= destructableIdsCounter)
        if (destructableIds[i] == id) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function FilterIsDayNightDestructable takes nothing returns boolean
    return GetDestructableIndex(GetDestructableTypeId(GetFilterDestructable())) != -1
endfunction

private function EnumDestructableDayEffect takes nothing returns nothing
    local destructable d = GetEnumDestructable()
    local integer index = GetDestructableIndex(GetDestructableTypeId(d))
    if (destructableHide[index]) then
        call ShowDestructable(d, true)
    endif
    call SetDestructableAnimation(d, "Stand")
    set d = null
endfunction

private function EnumDestructableNightEffect takes nothing returns nothing
    local destructable d = GetEnumDestructable()
    local integer index = GetDestructableIndex(GetDestructableTypeId(d))
    call SetDestructableAnimation(d, "Death")
    if (destructableHide[index]) then
        call TriggerSleepAction(destructableHideDelay[index])
        call ShowDestructable(d, false)
    endif
    set d = null
endfunction

private function AddDoodadEx takes integer id, string dayAnimName, string nightAnimName returns nothing
    set doodadIds[doodadIdsCounter] = id
    set doodadDayAnimNames[doodadIdsCounter] = dayAnimName
    set doodadNightAnimNames[doodadIdsCounter] = nightAnimName
    set doodadIdsCounter = doodadIdsCounter + 1
endfunction

private function AddDoodad takes integer id returns nothing
    call AddDoodadEx(id, "Death", "Stand")
endfunction

private function PlayDoodadAnimations takes boolean day returns nothing
    local integer i = 0
    loop
        exitwhen (i >= doodadIdsCounter)
        if (day) then
            call SetDoodadAnimationRect(GetPlayableMapRect(), doodadIds[i], doodadDayAnimNames[i], false)
        else
            call SetDoodadAnimationRect(GetPlayableMapRect(), doodadIds[i], doodadNightAnimNames[i], false)
        endif
        set i = i + 1
    endloop
endfunction

private function DayEffects takes nothing returns nothing
     if (IsDay() and not effectsIsDaytime) then
        set effectsIsDaytime = true

        call PlayDoodadAnimations(true)
        call EnumDestructablesInRect(GetPlayableMapRect(), filter, function EnumDestructableDayEffect)
    endif
endfunction

private function NightEffects takes nothing returns nothing
    local real ToD = GetTimeOfDay()

    if (IsNight() and effectsIsDaytime) then
        set effectsIsDaytime = false

        call PlayDoodadAnimations(false)
        call EnumDestructablesInRect(GetPlayableMapRect(), filter, function EnumDestructableNightEffect)
    endif
endfunction

private function Init takes nothing returns nothing
    set filter = Filter(function FilterIsDayNightDestructable)
    //call TriggerAddAction(bj_dncSoundsDay, function DayEffects)
    //call TriggerAddAction(bj_dncSoundsNight, function NightEffects)

    // Set up triggers to respond to changes from day to night or vice-versa.
    set dayEffectsTrigger = CreateTrigger()
    call TriggerRegisterGameStateEvent(dayEffectsTrigger,   GAME_STATE_TIME_OF_DAY, GREATER_THAN_OR_EQUAL, bj_TOD_DAWN)
    call TriggerRegisterGameStateEvent(dayEffectsTrigger,   GAME_STATE_TIME_OF_DAY, LESS_THAN,             bj_TOD_DUSK)
    call TriggerAddAction(dayEffectsTrigger, function DayEffects)

    set nightEffectsTrigger = CreateTrigger()
    call TriggerRegisterGameStateEvent(nightEffectsTrigger, GAME_STATE_TIME_OF_DAY, LESS_THAN,             bj_TOD_DAWN)
    call TriggerRegisterGameStateEvent(nightEffectsTrigger, GAME_STATE_TIME_OF_DAY, GREATER_THAN_OR_EQUAL, bj_TOD_DUSK)
    call TriggerAddAction(nightEffectsTrigger, function NightEffects)

    //call AddDestructable()

    call AddDoodad('YOlp') // Post Lantern Cityscape
    call AddDoodad('LOlp') // Post Lantern Lordaeron Summer
    call AddDoodad('LObz') // Brazier Glowing Loraderon Summer
    call AddDoodad('LOtz') // Torch Glowing Lordaeron Summer
    call AddDoodad('ZObz') // Brazier Ruins
    call AddDoodad('D013') // Gypsy Wagon
    call AddDestructableEx('D00F', true, 2.167) // Fireflies
    call AddDoodadEx('AOgs', "Stand", "Stand Alternate") // Statue Guardian of Aszune
    call AddDoodadEx('AOks', "Stand", "Stand Alternate") // Statue Keeper
endfunction

endlibrary
