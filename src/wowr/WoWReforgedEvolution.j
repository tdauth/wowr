library WoWReforgedEvolution requires NewBonus, UnitTypeUtils, WoWReforgedUtils, WoWReforgedRaces, WoWReforgedAbilitySkill, WoWReforgedSkillMenu, WoWReforgedI18n, MaxHPResearchConfig

function SetEvolutionLevelOfPlayer takes player whichPlayer, integer level returns nothing
    call SetPlayerTechResearched(whichPlayer, UPG_EVOLUTION, level)
endfunction

function GetEvolutionLevelOfPlayer takes player whichPlayer returns integer
    return GetPlayerTechCountSimple(UPG_EVOLUTION, whichPlayer)
endfunction

private function FilterIsEvolutionAffected takes nothing returns boolean
    return IsUnitAffectedByEvolution(GetFilterUnit())
endfunction

private function SetUnitEvolutionFields takes unit whichUnit, integer evolutionLevels, integer level, real armor returns nothing
    local integer currentEvolutionLevel = GetEvolutionLevelOfPlayer(GetOwningPlayer(whichUnit))
    local integer powerGeneratorLevel = IMaxBJ(1, currentEvolutionLevel / MAX_HERO_SPELL_LEVEL)
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        call BJDebugMsg("Warning: Applying evolution level " + I2S(level) + " to hero " + GetUnitName(whichUnit) + " of player " + GetPlayerName(GetOwningPlayer(whichUnit)))
    endif
    //local integer lifeBonus = evolutionLevel * 50
    // devotion aura etc.
    // do not kill summoned units with timed life buffs
    call UnitRemoveBuffsEx(whichUnit, true, true, true, true, false, true, true)
    call BlzSetUnitIntegerField(whichUnit, UNIT_IF_LEVEL, level)
    call BlzSetUnitRealField(whichUnit, UNIT_RF_DEFENSE, armor)
    // Using the research instead leads to an overflow and negative maximum life.
    //call BlzSetUnitMaxHP(whichUnit, R2I(GetUnitState(whichUnit, UNIT_STATE_MAX_LIFE)) + lifeBonus)
    //call SetUnitState(whichUnit, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE) + I2R(lifeBonus))
    // improved navy
    if (IsUnitShip(whichUnit)) then
        call AddUnitBonus(whichUnit, BONUS_SIGHT_RANGE, 30.0 * I2R(evolutionLevels))
        call AddUnitBonus(whichUnit, BONUS_MOVEMENT_SPEED, 20.0 * I2R(evolutionLevels))
    endif
    if (GetUnitTypeId(whichUnit) == POWER_GENERATOR) then
        call SkillAbility(whichUnit, ABILITY_STARFALL_POWER_GENERATOR, powerGeneratorLevel)
        call SkillAbility(whichUnit, ABILITY_AUTO_REPAIR, powerGeneratorLevel)
        call SkillAbility(whichUnit, ABILITY_AUTO_REPAIR_ICON, powerGeneratorLevel)
        call SkillAbility(whichUnit, ABILITY_ANCIENT_AUTO_REPAIR, powerGeneratorLevel)
        call SkillAbility(whichUnit, ABILITY_DEVOTION_AURA_POWER_GENERATOR, powerGeneratorLevel)
        call SkillAbility(whichUnit, ABILITY_ANCIENT_DEVOTION_AURA, powerGeneratorLevel)
    endif
    
    // Possession/Charm/Polymorph
    call SkillAbility(whichUnit, 'Aply', powerGeneratorLevel) // Polymorph Human
    call SkillAbility(whichUnit, ABILITY_POLYMORPH, powerGeneratorLevel)
    call SkillAbility(whichUnit, 'A0G9', powerGeneratorLevel) // Polymorph Bandit
    call SkillAbility(whichUnit, 'A10P', powerGeneratorLevel) // Polymorph Dalaran
    call SkillAbility(whichUnit, 'A1BM', powerGeneratorLevel) // Polymorph Lordaeron
    call SkillAbility(whichUnit, 'A1PB', powerGeneratorLevel) // Polymorph Stormwind
    call SkillAbility(whichUnit, 'Apos', powerGeneratorLevel) // Possession Undead
    call SkillAbility(whichUnit, 'Aps2', powerGeneratorLevel) // Possession Undead Channeling
    call SkillAbility(whichUnit, 'ACps', powerGeneratorLevel) // Possession Neutral Hostile
    call SkillAbility(whichUnit, 'A0G7', powerGeneratorLevel) // Possession Bandit
    call SkillAbility(whichUnit, 'A0R4', powerGeneratorLevel) // Possession Dungeon
    call SkillAbility(whichUnit, 'A1VW', powerGeneratorLevel) // Possession Faceless One

    if (IsUnitMount(whichUnit)) then
        // cargo
        call SkillAbility(whichUnit, 'S000', powerGeneratorLevel) // Cargo Hold Hero Mount
        call AddUnitBonus(whichUnit, BONUS_MANA, 30.0 * I2R(evolutionLevels))
        call AddUnitBonus(whichUnit, BONUS_MOVEMENT_SPEED, 20.0 * I2R(evolutionLevels))
    endif
endfunction

private function SetEvolutionLevelEx takes player whichPlayer, integer levels returns nothing
    local integer bonus = levels / 10
    local group units = CreateGroup()
    local unit member = null
    local integer i = 0
    local integer max = 0
    call GroupEnumUnitsOfPlayer(units, whichPlayer, Filter(function FilterIsEvolutionAffected))
    set max = BlzGroupGetSize(units)
    loop
        exitwhen(i == max)
        set member = BlzGroupUnitAt(units, i)
        call SetUnitEvolutionFields(member, levels, BlzGetUnitIntegerField(member, UNIT_IF_LEVEL) + bonus, BlzGetUnitRealField(member, UNIT_RF_DEFENSE) + I2R(bonus))
        set member = null
        set i = i + 1
    endloop
    call GroupClear(units)
    call DestroyGroup(units)
    set units = null
endfunction

private function SetEvolutionLevel takes player whichPlayer, integer levels returns nothing
    if (levels != 0) then
        call SetEvolutionLevelEx(whichPlayer, levels)
    endif
endfunction

function SetEvolution takes unit whichUnit returns nothing
    local player owner = GetOwningPlayer(whichUnit)
    local integer evolutionLevel = GetEvolutionLevelOfPlayer(owner)
    local integer bonus = evolutionLevel / 10
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    if (bonus != 0) then
        call SetUnitEvolutionFields(whichUnit, evolutionLevel, GetUnitLevelByType(unitTypeId, owner) + bonus, GetUnitDefenseByType(unitTypeId, owner) + R2I(bonus))
        if (GetSkillMenu(whichUnit) != 0) then
            call SetHeroSkillPoints(whichUnit, evolutionLevel * SKILL_POINTS_PER_LEVEL)
        endif
    endif
    set owner = null
endfunction

function AddEvolution takes unit whichUnit returns nothing
    local integer evolutionLevel = GetEvolutionLevelOfPlayer(GetOwningPlayer(whichUnit))
    local integer bonus = evolutionLevel / 10
    if (bonus != 0) then
        call SetUnitEvolutionFields(whichUnit, evolutionLevel, BlzGetUnitIntegerField(whichUnit, UNIT_IF_LEVEL) + bonus, BlzGetUnitRealField(whichUnit, UNIT_RF_DEFENSE) + I2R(bonus))
        if (GetSkillMenu(whichUnit) != 0) then
            call AddHeroSkillPoints(whichUnit, evolutionLevel * SKILL_POINTS_PER_LEVEL)
        endif
    endif
endfunction

function UpgradeEvolution takes player whichPlayer returns nothing
    call SetEvolutionLevel(whichPlayer, 1)
endfunction

function SetEvolutionLevelForCreeps takes integer level returns nothing
    call SetEvolutionLevelOfPlayer(Player(PLAYER_NEUTRAL_AGGRESSIVE), level)
    call SetEvolutionLevelOfPlayer(udg_BossesPlayer, level)
endfunction

private function HookSetPlayerTechResearched takes player whichPlayer, integer techid, integer setToLevel returns nothing
    if (techid == UPG_EVOLUTION) then
        call SetEvolutionLevel(whichPlayer, setToLevel - GetEvolutionLevelOfPlayer(whichPlayer))
    endif
endfunction

private function HookAddPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    if (techid == UPG_EVOLUTION) then
        call SetEvolutionLevel(whichPlayer, levels)
    endif
endfunction

private function HookBlzDecPlayerTechResearched takes player whichPlayer, integer techid, integer levels returns nothing
    if (techid == UPG_EVOLUTION) then
        call SetEvolutionLevel(whichPlayer, -levels)
    endif
endfunction

hook SetPlayerTechResearched HookSetPlayerTechResearched
hook AddPlayerTechResearched HookAddPlayerTechResearched
hook BlzDecPlayerTechResearched HookBlzDecPlayerTechResearched

endlibrary
