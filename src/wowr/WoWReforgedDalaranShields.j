library WoWReforgedDalaranShields

globals
    private hashtable h = InitHashtable()
    private weathereffect array shieldWeatherEffects
    private integer shieldWeatherEffectsCounter = 1
    private group powerGenerators = CreateGroup()
endglobals

private function AddShieldWeatherEffect takes weathereffect w returns integer
    local integer index = shieldWeatherEffectsCounter
    set shieldWeatherEffects[index] = w
    set shieldWeatherEffectsCounter = shieldWeatherEffectsCounter + 1
    return index
endfunction

private function GetShieldWeatherEffect takes integer index returns weathereffect
    return shieldWeatherEffects[index]
endfunction

private function FreeShieldWeatherEffect takes integer index returns nothing
    local integer i = index
    local integer j = i + 1
    loop
        exitwhen (j >= shieldWeatherEffectsCounter)
        set shieldWeatherEffects[i] = shieldWeatherEffects[j]
        set i = i + 1
        set j = i + 1
    endloop
    set shieldWeatherEffectsCounter = i
endfunction

function EnableDalaranShield takes unit powerGenerator returns nothing
    local integer handleId = GetHandleId(powerGenerator)
    local location pos = GetUnitLoc(powerGenerator)
    local rect where = GetRectFromCircleBJ(pos, 500.0)
    local weathereffect w = AddWeatherEffect(where, 'MEds')
    call EnableWeatherEffect(w, true)
    call GroupAddUnit(powerGenerators, powerGenerator)
    call SaveRectHandle(h, handleId, 0, where)
    call SaveInteger(h, handleId, 1, AddShieldWeatherEffect(w))
    call RemoveLocation(pos)
    set pos = null
    set where = null
    set w = null
endfunction

function GetDalaranShieldRect takes unit powerGenerator returns rect
    local integer handleId = GetHandleId(powerGenerator)
    return LoadRectHandle(h, handleId, 0)
endfunction

function DisableDalaranShield takes unit powerGenerator returns nothing
    local integer handleId = GetHandleId(powerGenerator)
    local integer weatherEffectIndex = LoadInteger(h, handleId, 1)
    local weathereffect w = null
    local rect where = LoadRectHandle(h, handleId, 0)
    
    if (weatherEffectIndex > 0) then
        set w = GetShieldWeatherEffect(weatherEffectIndex)
        if (w != null) then
            call EnableWeatherEffect(w, false)
            call RemoveWeatherEffect(w)
        endif
        call FreeShieldWeatherEffect(weatherEffectIndex)
        set w = null
    endif
    
    if (where != null) then
        call RemoveRect(where)
        set where = null
    endif
    
    call GroupRemoveUnit(powerGenerators, powerGenerator)
endfunction

function IsDalaranShieldEnabled takes unit powerGenerator returns boolean
    return IsUnitInGroup(powerGenerator, powerGenerators)
endfunction

function DalaranShieldsAreEmpty takes nothing returns boolean
    return BlzGroupGetSize(powerGenerators) == 0
endfunction

function GroupAddDalaranShields takes group destGroup returns nothing
    call GroupAddGroup(powerGenerators, destGroup)
endfunction

endlibrary
