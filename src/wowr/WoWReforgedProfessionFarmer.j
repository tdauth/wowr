library WoWReforgedProfessionFarmer initializer Init

globals
    private filterfunc f
    private player owner
endglobals

private function FilterIsWaterSupply takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == WATER_SUPPLY and GetOwningPlayer(GetFilterUnit()) == owner
endfunction

function ApplySeedChargesToLastCreatedItem takes nothing returns nothing
    local group g = CreateGroup()
    local item i = GetLastCreatedItem()
    set owner = GetOwningPlayer(GetTriggerUnit())
    call GroupEnumUnitsInRange(g, GetItemX(i), GetItemY(i), 400.0, f)
    call SetItemCharges(i, 1 + BlzGroupGetSize(g))
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    set i = null
endfunction

private function Init takes nothing returns nothing
    set f = Filter(function FilterIsWaterSupply)
endfunction

endlibrary
