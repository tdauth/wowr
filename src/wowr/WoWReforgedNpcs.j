library WoWReforgedNpcs initializer Init requires UnitTypeUtils

globals
    private integer array npcUnitTypeIds
    private integer npcUnitTypeIdsCount = 0
endglobals

function GetMaxNpcs takes nothing returns integer
    return npcUnitTypeIdsCount
endfunction

function GetNpc takes integer index returns integer
    return npcUnitTypeIds[index]
endfunction

private function AddNpc takes integer unitTypeId returns integer
    local integer index = npcUnitTypeIdsCount
    set npcUnitTypeIds[index] = unitTypeId
    set npcUnitTypeIdsCount = index + 1
    call SetIsCampaign(unitTypeId, true)
    return index
endfunction

function GetNpcIndexByUnitTypeId takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i >= npcUnitTypeIdsCount)
        if (npcUnitTypeIds[i] == unitTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function IsNpc takes integer unitTypeId returns boolean
    return GetNpcIndexByUnitTypeId(unitTypeId) != -1
endfunction

function IsUnitNpc takes unit whichUnit returns boolean
    return IsNpc(GetUnitTypeId(whichUnit))
endfunction

globals
    private integer filterUnitTypeId = 0
endglobals

private function FilterIsUnitType takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == filterUnitTypeId
endfunction

function GetNpcUnitByUnitTypeId takes integer unitTypeId returns unit
    local group g = CreateGroup()
    local unit first = null
    set filterUnitTypeId = unitTypeId
    call GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_PASSIVE), Filter(function FilterIsUnitType))
    set first = FirstOfGroup(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return first
endfunction

private function Init takes nothing returns nothing
    call AddNpc('H005')
    call AddNpc('Haah')
    call AddNpc('Hpb1')
    call AddNpc('H006')
    call AddNpc('Hjai')
    call AddNpc('Nklj')
    call AddNpc('H08B')
    call AddNpc('Hhkl')
    call AddNpc('H089')
    call AddNpc('Hkal')
    call AddNpc('Othr')
    call AddNpc('Ocbh')
    call AddNpc('Orex')
    call AddNpc('Nsjs')
    call AddNpc('N08W')
    call AddNpc('Etyr')
    call AddNpc('Emfr')
    call AddNpc('Eevi')
    call AddNpc('Hvsh')
    call AddNpc('Uanb')
    call AddNpc('Uktl')
    call AddNpc('Usyl')
    call AddNpc('H0U3')
    call AddNpc('Uear')
    call AddNpc('U016')
    call AddNpc('U01J')
    call AddNpc('N0AF')
    call AddNpc('N0CZ')
    call AddNpc('h00P')
    call AddNpc('N0GE')
    call AddNpc('Naka')
    call AddNpc('U00P')
    call AddNpc('U00S')
    call AddNpc('U00R')
    call AddNpc('H0U4')
    call AddNpc('H0UX')
    call AddNpc('H0Q1')
    call AddNpc('H0Q2')
    call AddNpc('N0O1')
    call AddNpc('H0AQ')
    call AddNpc('H0AP')
    call AddNpc('H01A')
    call AddNpc('H0AP')
    call AddNpc('H01K')
    call AddNpc('H01L')
    call AddNpc('H03N')
    call AddNpc('H02N')
    call AddNpc('H02P')
    call AddNpc('N09S')
    call AddNpc('N03G')
    call AddNpc('N0AP')
    call AddNpc('N09F')
    call AddNpc('N0M3')
    call AddNpc('H0T2')
    call AddNpc('H0T8')
endfunction

endlibrary
