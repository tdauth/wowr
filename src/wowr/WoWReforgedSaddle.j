library WoWReforgedSaddle initializer Init requires SimError, UnitEventEx, WoWReforgedMounts

globals
    public constant integer ITEM_TYPE_ID = 'I0W4'
    public constant integer ABILITY_ID = 'A1T0'
    public constant integer BUFF_ID = 'B03F'
endglobals

function Saddle takes unit mount returns boolean
    local boolean result = false
    local group cargo = GetCargoTransportedUnitGroup(mount)
    local integer i = 0
    local integer max = BlzGroupGetSize(cargo)
    loop
        exitwhen (i == max or result)
        if (UnitHasItemOfTypeBJ(BlzGroupUnitAt(cargo, i), ITEM_TYPE_ID)) then
            set result = true
        endif
        set i = i + 1
    endloop
    
    if (result) then
        if (GetUnitAbilityLevel(mount, ABILITY_ID) == 0) then
            call UnitAddAbility(mount, ABILITY_ID)
            call LinkBonusToBuff(mount, BONUS_ATTACK_SPEED, 0.3, BUFF_ID)
            call LinkBonusToBuff(mount, BONUS_MOVEMENT_SPEED, 150.0, BUFF_ID)
        endif
    else
        call UnitRemoveAbility(mount, ABILITY_ID)
    endif
    
    call GroupClear(cargo)
    call DestroyGroup(cargo)
    set cargo = null
    
    return result
endfunction

private function Load takes nothing returns nothing
    if (IsMount(GetUnitTypeId(GetCargoUnit()))) then
        call Saddle(GetCargoUnit())
    endif
endfunction

private function Unload takes nothing returns nothing
    if (IsMount(GetUnitTypeId(GetCargoUnit()))) then
        call Saddle(GetCargoUnit())
    endif
endfunction

private function Init takes nothing returns nothing
    call RegisterNativeEvent(EVENT_ON_CARGO_LOAD, function Load)
    call RegisterNativeEvent(EVENT_ON_CARGO_UNLOAD, function Unload)
endfunction

endlibrary
