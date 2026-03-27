library WoWReforgedTransformations initializer Init requires NewBonus, WoWReforgedHeroTransformation, WoWReforgedAbilitySkill, WoWReforgedAncientBow

globals
    private trigger transformTrigger = CreateTrigger()
    private trigger normalFormTrigger = CreateTrigger()
endglobals

function GetMetamorphosisLifeBonus takes unit caster, integer abilityId, integer level returns real
    return 100.0 + I2R(level) * 100.0
endfunction

function GetGhostFormLifeBonus takes unit caster, integer abilityId, integer level returns real
    return 100.0 + I2R(level) * 100.0
endfunction

function GetRoboGoblinStrengthBonus takes unit caster, integer abilityId, integer level returns integer
    return level
endfunction

function GetRoboGoblinArmorBonus takes unit caster, integer abilityId, integer level returns integer
    return level
endfunction

private function TriggerConditionTransform takes nothing returns boolean
    // Do not remove any bonuses since they are not stored anyway when replacing the hero.
    if (GetUnitTypeId(GetTriggerTransformedHero()) == DEMON_HUNTER_M) then
        call AddUnitBonus(GetTriggerTransformedHero(), BONUS_HEALTH, GetMetamorphosisLifeBonus(GetTriggerTransformedHero(), ABILITY_METAMORPHOSIS, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_METAMORPHOSIS)))
    //elseif (GetTriggerTransformOriginalUnitTypeId() == DEMON_HUNTER_M) then
    //    call AddUnitBonus(GetTriggerTransformedHero(), BONUS_HEALTH, -GetMetamorphosisLifeBonus(GetTriggerTransformedHero(), ABILITY_METAMORPHOSIS, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_METAMORPHOSIS)))
    elseif (GetUnitTypeId(GetTriggerTransformedHero()) == GHOST_FORM) then
        call AddUnitBonus(GetTriggerTransformedHero(), BONUS_HEALTH, GetMetamorphosisLifeBonus(GetTriggerTransformedHero(), ABILITY_GHOST_FORM, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_GHOST_FORM)))
    //elseif (GetTriggerTransformOriginalUnitTypeId() == GHOST_FORM) then
        //call AddUnitBonus(GetTriggerTransformedHero(), BONUS_HEALTH, -GetMetamorphosisLifeBonus(GetTriggerTransformedHero(), ABILITY_GHOST_FORM, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_GHOST_FORM)))
    elseif (GetUnitTypeId(GetTriggerTransformedHero()) == TINKER_M) then
        call AddUnitBonus(GetTriggerTransformedHero(), BONUS_STRENGTH, GetRoboGoblinStrengthBonus(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN)))
        call AddUnitBonus(GetTriggerTransformedHero(), BONUS_ARMOR, GetRoboGoblinArmorBonus(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN)))
    //elseif (GetTriggerTransformOriginalUnitTypeId() == TINKER_M) then
      //  call AddUnitBonus(GetTriggerTransformedHero(), BONUS_STRENGTH, -GetRoboGoblinStrengthBonus(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN)))
       // call AddUnitBonus(GetTriggerTransformedHero(), BONUS_ARMOR, -GetRoboGoblinArmorBonus(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN, GetUnitAbilitySkillLevelSafe(GetTriggerTransformedHero(), ABILITY_ROBO_GOBLIN)))
    endif
    
    if (GetTriggerTransformedHero() == udg_BossesFrostmourneCarrier) then
        call BlzSetUnitWeaponIntegerField(GetTriggerTransformedHero(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 5)
    endif
    
    if (GetTriggerTransformedHero() == udg_BossesTurtleShellCarrier) then
        call BlzSetUnitIntegerField(GetTriggerUnit(), UNIT_IF_DEFENSE_TYPE, 6)
    endif
    
    if (GetTriggerTransformedHero() == udg_BossesBowCarrier) then
        call AddAncientBowBonus(GetTriggerTransformedHero())
    endif
    
    return false
endfunction

private function TriggerConditionNormalForm takes nothing returns boolean
    return GetSpellAbilityId() == 'A1H4'
endfunction

private function TriggerActionNormalForm takes nothing returns nothing
    call TransformHeroBack(GetTriggerUnit())
endfunction

private function Init takes nothing returns nothing
    local integer index = 0
    
    call TriggerRegisterHeroTransform(transformTrigger)
    call TriggerAddCondition(transformTrigger, Condition(function TriggerConditionTransform))
    
    call TriggerRegisterAnyUnitEventBJ(normalFormTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(normalFormTrigger, Condition(function TriggerConditionNormalForm))
    call TriggerAddAction(normalFormTrigger, function TriggerActionNormalForm)
    
    set index = AddHeroTransformationItemTypeIdEx(ABILITY_METAMORPHOSIS, DEMON_HUNTER_M)
    call SetHeroTransformationAnimProperties(index, "alternate")
    set index = AddHeroTransformationItemTypeIdEx(ABILITY_GHOST_FORM, GHOST_FORM)
    set index = AddHeroTransformationItemTypeIdEx(ABILITY_ROBO_GOBLIN, TINKER_M)
    call SetHeroTransformationAnimProperties(index, "alternate")
    
    call RegisterAbilityFieldCustomReal0(ABILITY_METAMORPHOSIS, GetMetamorphosisLifeBonus)
    call RegisterAbilityFieldCustomReal0(ABILITY_GHOST_FORM, GetGhostFormLifeBonus)
    call RegisterAbilityFieldCustomInteger0(ABILITY_ROBO_GOBLIN, GetRoboGoblinStrengthBonus)
    call RegisterAbilityFieldCustomInteger1(ABILITY_ROBO_GOBLIN, GetRoboGoblinArmorBonus)
    
    // TODO Chaos for Orcs/Grommash
    // TODO Battleship for Proudmoore
    // TODO Etheral Form for Spirit Walker
    // TODO Lich King for Nerzul
    // TODO Destroyer Form for Obsidian Statue
    // TODO Shade Form for Acolyte
    // TODO Corruption Furbolg Ursa Warrior
    // TODO Lion-skull Helmet for Anduin ReplaceableTextures\CommandButtons\BTNKingAnduin.blp
    // TODO Worgen Form for Worgen heroes
    
    // Druid Forms
    set index = AddHeroTransformationItemTypeIdEx('A1H2', DRUID_FORM_BEAR)
    set index = AddHeroTransformationItemTypeIdEx('A1H3', DRUID_FORM_CROW)
    set index = AddHeroTransformationItemTypeIdEx('A1GV', DRUID_FORM_AQUATIC)
    set index = AddHeroTransformationItemTypeIdEx('A1GX', DRUID_FORM_FLIGHT)
    set index = AddHeroTransformationItemTypeIdEx('A1GY', DRUID_FORM_TREE)
    set index = AddHeroTransformationItemTypeIdEx('A1H0', DRUID_FORM_STAG)
    set index = AddHeroTransformationItemTypeIdEx('A1GU', DRUID_FORM_WILDKIN)
    set index = AddHeroTransformationItemTypeIdEx('A1GW', DRUID_FORM_CAT)
    set index = AddHeroTransformationItemTypeIdEx('A1GZ', DRUID_FORM_WOLF)
    set index = AddHeroTransformationItemTypeIdEx('A1H1', DRUID_FORM_SPIDER)
endfunction

endlibrary
