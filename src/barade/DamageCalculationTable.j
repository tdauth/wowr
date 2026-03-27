library DamageCalculationTable initializer Init requires MathUtils, StringUtils

globals
    constant integer MAX_DEFENSE_TYPES = 9
    constant integer MAX_ATTACK_TYPES = 7
    
    constant integer DEFENSE_TYPE_ETHEREAL = 8

    private real array percentages
endglobals

function SetDamageCalculationTableValue takes integer a, integer d, real percentage returns nothing
    set percentages[Index2D(a, d, MAX_DEFENSE_TYPES)] = percentage
endfunction

function GetDamageCalculationTableValue takes integer a, integer d returns real
    return percentages[Index2D(a, d, MAX_DEFENSE_TYPES)]
endfunction

private function FromGameplayConstantsValuesDefenseType takes integer d, string line returns nothing
    local string cell = null
    local integer index = 0
    loop
        set cell = StringSplit(line, index, ",")
        exitwhen (cell == null)
        call SetDamageCalculationTableValue(index, d, S2R(cell))
        set index = index + 1
    endloop
endfunction

private function FromGameplayConstantsValuesAttackType takes integer a, string line returns nothing
    local string cell = null
    local integer index = 0
    loop
        set cell = StringSplit(line, index, ",")
        exitwhen (cell == null)
        call SetDamageCalculationTableValue(a, index, S2R(cell))
        set index = index + 1
    endloop
endfunction

private function GetAttackTypeFromGamePlayConstants takes string name returns integer
    if (name == "DamageBonusHero") then
        return GetHandleId(ATTACK_TYPE_HERO)
    elseif (name == "DamageBonusMagic") then
        return GetHandleId(ATTACK_TYPE_MAGIC)
    elseif (name == "DamageBonusNormal") then
        return GetHandleId(ATTACK_TYPE_MELEE)
    elseif (name == "DamageBonusPierce") then
        return GetHandleId(ATTACK_TYPE_PIERCE)
    elseif (name == "DamageBonusSiege") then
        return GetHandleId(ATTACK_TYPE_SIEGE)
    elseif (name == "DamageBonusChaos") then
        return GetHandleId(ATTACK_TYPE_CHAOS)
    elseif (name == "DamageBonusSpells") then
        return GetHandleId(ATTACK_TYPE_NORMAL)
    endif
    return GetHandleId(ATTACK_TYPE_HERO)
endfunction

private function FromGameplayConstantsLine takes string line returns nothing
    local string cell = StringSplit(line, 0, "=")
    if (cell != null) then
        if (cell == "EtherealDamageBonus") then
            call FromGameplayConstantsValuesDefenseType(DEFENSE_TYPE_ETHEREAL, SubString(line, StringLength(cell + "="), StringLength(line)))
        else
            call FromGameplayConstantsValuesAttackType(GetAttackTypeFromGamePlayConstants(cell), SubString(line, StringLength(cell + "="), StringLength(line)))
        endif
    endif
endfunction

// Reads the lines with DamageBonusXXX of the war3mapMisc.txt file.
function DamageCalculationTableFromGameplayConstants takes string lines returns nothing
    local string line = null
    local integer index = 0
    loop
        set line = StringSplit(lines, index, "\n")
        exitwhen (line == null)
        call FromGameplayConstantsLine(line)
        set index = index + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    //call DamageCalculationTableFromGameplayConstants("DamageBonusChaos=1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00\nDamageBonusHero=1.00,1.00,1.00,0.50,1.00,1.00,0.30,1.00\nDamageBonusMagic=1.25,0.75,2.00,0.35,1.00,0.50,0.20,1.00\nDamageBonusNormal=1.00,1.50,1.00,0.70,1.00,1.00,0.20,1.00\nDamageBonusPierce=2.00,0.75,1.00,0.35,1.00,0.50,0.20,1.50\nDamageBonusSiege=1.00,0.50,1.00,1.50,1.00,0.50,0.20,1.50\nDamageBonusSpells=1.00,1.00,1.00,1.00,1.00,0.70,0.20,1.00")
    call FromGameplayConstantsLine("DamageBonusChaos=1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00")
    call FromGameplayConstantsLine("DamageBonusHero=1.00,1.00,1.00,0.50,1.00,1.00,0.30,1.00")
    call FromGameplayConstantsLine("DamageBonusMagic=1.25,0.75,2.00,0.35,1.00,0.50,0.20,1.00")
    call FromGameplayConstantsLine("DamageBonusNormal=1.00,1.50,1.00,0.70,1.00,1.00,0.20,1.00")
    call FromGameplayConstantsLine("DamageBonusPierce=2.00,0.75,1.00,0.35,1.00,0.50,0.20,1.50")
    call FromGameplayConstantsLine("DamageBonusSiege=1.00,0.50,1.00,1.50,1.00,0.50,0.20,1.50")
    call FromGameplayConstantsLine("DamageBonusSpells=1.00,1.00,1.00,1.00,1.00,0.70,0.20,1.00")
    call FromGameplayConstantsLine("EtherealDamageBonus=0.00,0.00,0.00,1.66,0.00,1.66,0.00")
endfunction

endlibrary
