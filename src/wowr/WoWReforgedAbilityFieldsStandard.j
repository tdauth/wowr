library WoWReforgedAbilityFieldsStandard initializer Init requires WoWReforgedAbilityFields

private function RegisterUnitAbility takes integer abilityId returns nothing
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterUnitAbilityField takes integer abilityId, integer fieldId returns nothing
    call RegisterAbilityField(abilityId, fieldId)
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterInvisibility takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_HERO))
    call RegisterAbilityWithFields(abilityId, false, true, false, false)
endfunction

private function RegisterPolymorph takes integer abilityId returns nothing
    call RegisterUnitAbility(abilityId)
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_HERO))
endfunction

private function RegisterPossession takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1))
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterSilence takes integer abilityId returns nothing
    call RegisterUnitAbility(abilityId)
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DURATION_HERO))
endfunction

private function RegisterHealAura takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED))
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterDevotionAura takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_ARMOR_BONUS_HAD1))
    call RegisterAbilityWithFields(abilityId, true, false, false, false)
endfunction

private function RegisterCargoHold takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_CARGO_CAPACITY))
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterAOEDamageUponDeath takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2))
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterItemAttackBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_ATTACK_BONUS))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemDefenseBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_DEFENSE_BONUS_IDEF))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemDamageBonusOrb takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_IDAM))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemStrengthBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_STRENGTH_BONUS_ISTR))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemAgilityBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_AGILITY_BONUS))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemIntelligenceBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_INTELLIGENCE_BONUS))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemAllStatsBonus takes integer abilityId returns nothing
    call RegisterItemStrengthBonus(abilityId)
    call RegisterItemAgilityBonus(abilityId)
    call RegisterItemIntelligenceBonus(abilityId)
endfunction

private function RegisterItemLevelsGained takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_LEVELS_GAINED))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemAttackModification takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_ATTACK_MODIFICATION))
    call RegisterAbilityWithFields(abilityId, false, false, true, true)
endfunction

private function RegisterItemChainLightningBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_OCL1))
    call RegisterAbilityWithFields(abilityId, true, false, false, true)
endfunction

private function RegisterShadowStrikeBonus takes integer abilityId, boolean isItem returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_DECAYING_DAMAGE))
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_INITIAL_DAMAGE_ESH5))
    call RegisterAbilityWithFields(abilityId, true, false, false, isItem)
endfunction

private function RegisterUnitShadowStrikeBonus takes integer abilityId returns nothing
    call RegisterShadowStrikeBonus(abilityId, false)
endfunction

private function RegisterItemShadowStrikeBonus takes integer abilityId returns nothing
    call RegisterShadowStrikeBonus(abilityId, true)
endfunction

private function RegisterSummon1UnitTypeBonus takes integer abilityId, boolean isItem returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_SUMMON_1_AMOUNT))
    call RegisterAbilityWithFields(abilityId, true, false, false, isItem)
endfunction

private function RegisterUnitSummon1UnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon1UnitTypeBonus(abilityId, false)
endfunction

private function RegisterItemSummon1UnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon1UnitTypeBonus(abilityId, true)
endfunction

private function RegisterSummon1AmountUnitTypeBonus takes integer abilityId, boolean isItem returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2))
    call RegisterAbilityWithFields(abilityId, true, false, false, isItem)
endfunction

private function RegisterUnitSummon1AmountUnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon1AmountUnitTypeBonus(abilityId, false)
endfunction

private function RegisterItemSummon1AmountUnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon1AmountUnitTypeBonus(abilityId, true)
endfunction

private function RegisterSummon2AmountUnitTypeBonus takes integer abilityId, boolean isItem returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2))
    call RegisterAbilityWithFields(abilityId, true, false, false, isItem)
endfunction

private function RegisterUnitSummon2AmountUnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon2AmountUnitTypeBonus(abilityId, false)
endfunction

private function RegisterItemSummon2AmountUnitTypeBonus takes integer abilityId returns nothing
    call RegisterSummon2AmountUnitTypeBonus(abilityId, true)
endfunction

private function RegisterReanimateBonus takes integer abilityId, boolean isItem returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1))
    call RegisterAbilityWithFields(abilityId, true, false, false, isItem)
endfunction

private function RegisterUnitReanimateBonus takes integer abilityId returns nothing
    call RegisterReanimateBonus(abilityId, false)
endfunction

private function RegisterItemReanimateBonus takes integer abilityId returns nothing
    call RegisterReanimateBonus(abilityId, true)
endfunction

private function RegisterItemLifeRegenerationBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemLifeBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_MAX_LIFE_GAINED))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemManaBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_MAX_MANA_GAINED))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemXPBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_ILF_EXPERIENCE_GAINED))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterItemCriticalStrikeBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

private function RegisterEvasion takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_CHANCE_TO_EVADE_EEV1))
    call RegisterAbilityWithFields(abilityId, false, false, false, false)
endfunction

private function RegisterItemEvasionBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_CHANCE_TO_EVADE_EEV1))
    call RegisterAbilityWithFields(abilityId, false, true, false, true)
endfunction

// ABILITY_RLF_ARMOR_BONUS_HAD1
private function RegisterItemArmorAuraBonus takes integer abilityId returns nothing
    call RegisterAbilityField(abilityId, GetHandleId(ABILITY_RLF_ARMOR_BONUS_HAD1))
    call RegisterAbilityWithFields(abilityId, false, false, false, true)
endfunction

private function RegisterUnitHealBonus takes integer abilityId, integer fieldId returns nothing
    call RegisterAbilityField(abilityId, fieldId)
    call RegisterAbilityWithFields(abilityId, true, false, false, false)
endfunction

private function RegisterItemHealBonus takes integer abilityId, integer fieldId returns nothing
    call RegisterAbilityField(abilityId, fieldId)
    call RegisterAbilityWithFields(abilityId, false, false, false, true)
endfunction

private function Init takes nothing returns nothing
    // Field Types
    call RegisterAbilityFieldType('ci00', ABILITY_FIELD_TYPE_CUSTOM_INTEGER_0)
    call RegisterAbilityFieldType('ci01', ABILITY_FIELD_TYPE_CUSTOM_INTEGER_1)
    call RegisterAbilityFieldType('cr00', ABILITY_FIELD_TYPE_CUSTOM_REAL_0)
    call RegisterAbilityFieldType('cr01', ABILITY_FIELD_TYPE_CUSTOM_REAL_1)
    call RegisterAbilityFieldType('cr02', ABILITY_FIELD_TYPE_CUSTOM_REAL_2)
    
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DURATION_NORMAL), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DURATION_HERO), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_COOLDOWN), ABILITY_FIELD_TYPE_COOLDOWN_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AREA_OF_EFFECT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CAST_RANGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CASTING_TIME), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ARMOR_BONUS_HAD1), ABILITY_FIELD_TYPE_DEFENSE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_CARGO_CAPACITY), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_ATTACK_BONUS), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_DEFENSE_BONUS_IDEF), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_IDAM), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_STRENGTH_BONUS_ISTR), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_AGILITY_BONUS), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_INTELLIGENCE_BONUS), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_LEVELS_GAINED), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_ATTACK_MODIFICATION), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_OCL1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DECAYING_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_INITIAL_DAMAGE_ESH5), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_SUMMON_1_AMOUNT), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND), ABILITY_FIELD_TYPE_LIFE_REGENRATION_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAX_LIFE_GAINED), ABILITY_FIELD_TYPE_LIFE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAX_MANA_GAINED), ABILITY_FIELD_TYPE_LIFE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_EXPERIENCE_GAINED), ABILITY_FIELD_TYPE_LIFE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE), ABILITY_FIELD_TYPE_DEFENSE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_EVADE_EEV1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_HEA1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_INF2), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_TARGETS_HIT), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED_UNITS), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED_HEROS), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAXIMUM_RANGE), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_ABSORBED_PERCENT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_POINTS_DRAINED), ABILITY_FIELD_TYPE_MANA_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_REGENERATION_INCREASE), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED), ABILITY_FIELD_TYPE_HERO_STATS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_MISS_CRS), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_NBA1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_DRAINED), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_NFD3), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_HTB1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_INTERVAL), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_HBZ2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_FULL_DAMAGE_DEALT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HALF_DAMAGE_DEALT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_ROCK_RING_COUNT), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_UCS1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_DAMAGE_UCS2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_EXTRA_DAMAGE_HCA1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_DEALT_ESF1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_BASH), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HBH3), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINT_BONUS), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DEFENSE_BONUS_HAV1), ABILITY_FIELD_TYPE_DEFENSE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HAV3), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_REJ1), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_POINTS_GAINED_REJ2), ABILITY_FIELD_TYPE_MANA_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_INCREASE), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_EVADE_OCR4), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2), ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS), ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_MODIFIER), ABILITY_FIELD_TYPE_NEGATIVE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_CHANCE_TO_MISS_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_AMOUNT_NCS1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_DAMAGE_NCS4), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MISSILE_COUNT), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAX_CREEP_LEVEL_NTM3), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_GOLD_COST_FACTOR), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LUMBER_COST_FACTOR), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_WAVE_COUNT_NHS6), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_NDO1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_EFK1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)    
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAX_CREEP_LEVEL_DEV1), ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AOE_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_TAKEN_INCREASE), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_DEALT_UIM3), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_RETURNED_DAMAGE_FACTOR), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DEFENSE_BONUS_UTS3), ABILITY_FIELD_TYPE_DEFENSE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_WRS1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_REPAIR_COST_RATIO), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_PER_UNIT), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_PER_UNIT), ABILITY_FIELD_TYPE_MANA_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)    
    call RegisterAbilityFieldType('Ndo4', ABILITY_FIELD_TYPE_UNIT_LEVEL_INTEGER) // TODO Field 'Ndo4' is missing in common.j - Doom maximum creep level
    call RegisterAbilityFieldType('Ndo5', ABILITY_FIELD_TYPE_CHANCE_REAL) // TODO Field 'Ndo5' is missing in common.j - Doom movement speed
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_HIT_POINTS), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_CONVERTED_TO_LIFE), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_CONVERTED_TO_MANA), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAX_UNITS_SUMMONED), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_APL2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_DRAINED), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_WAVES), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AREA_OF_EFFECT_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType('Ufn2', ABILITY_FIELD_TYPE_DAMAGE_REAL) // TODO Field 'Ufn2' is missing in common.j - Doom movement speed
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_NBF5), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_OSH1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DURATION_OF_OWLS), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HFA1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_AMOUNT_NST3), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_PER_HIT_POINT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_TDG1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_IMAGES), ABILITY_FIELD_TYPE_ILLUSIONS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_OWW1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_BACKSTAB_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_ROA2), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_HEALED), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_DEFENSE_REDUCTION), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_EER1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_EAT3), ABILITY_FIELD_TYPE_LIFE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_CTB1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4), ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_WAVE_INTERVAL), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER) 
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_BONUS_FAK1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_MAXIMUM_UNITS), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_REDUCTION_CRI3), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_UHF2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_UNITS_SLOWED_PERCENT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_UIN1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DURATION), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER), ABILITY_FIELD_TYPE_DAMAGE_MULTIPLIER_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_INTERVAL_ESF2), ABILITY_FIELD_TYPE_DURATION_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_BUILDING_REDUCTION_ESF3), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ARMOR_BONUS_UFA2), ABILITY_FIELD_TYPE_DEFENSE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_NUMBER_OF_SWARM_UNITS), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_RETURN_FACTOR), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_EXTRA_DAMAGE_POA1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_POA2), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_POI1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_ARMOR_PENALTY_NAB3), ABILITY_FIELD_TYPE_DEFENSE_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_PRIMARY_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_SECONDARY_DAMAGE), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_ILF_GENERATION_COUNT), ABILITY_FIELD_TYPE_SUMMONED_UNITS_INTEGER)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MAX_HITPOINT_FACTOR), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_CTC1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_MLS1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_AMOUNT_REGENERATED), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_LSH1), ABILITY_FIELD_TYPE_DAMAGE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1), ABILITY_FIELD_TYPE_CHANCE_REAL)
    call RegisterAbilityFieldType(GetHandleId(ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2), ABILITY_FIELD_TYPE_CHANCE_REAL)
    
    // Invisibility
    call RegisterInvisibility('Aivs') // Human original
    call RegisterInvisibility('A10Q') // Dalaran
    call RegisterInvisibility('A1BL') // Lordaeron
    call RegisterInvisibility('A08L') // Human
    call RegisterInvisibility('A1PC') // Stormwind
    call RegisterInvisibility('A1F7') // Worgen
    call RegisterInvisibility('A1JN') // Tauren
    call RegisterInvisibility('A165') // Troll
    call RegisterInvisibility(ABILITY_INVISIBILITY) // Creep

    // Polymorph
    call RegisterPolymorph('Aply') // Human
    call RegisterPolymorph(ABILITY_POLYMORPH) // Creep
    call RegisterPolymorph('A0G9') // Bandit
    call RegisterPolymorph('A10P') // Dalaran
    call RegisterPolymorph('A1BM') // Lordaeron
    call RegisterPolymorph('A1PB') // Stormwind
    call RegisterPolymorph('A099') // Blood Elf
    call RegisterPolymorph('A0S5') // Kul Tiras
    call RegisterPolymorph('A0CI') // Goblin
    
    // Possession
    call RegisterPossession('Apos')
    call RegisterPossession('Aps2')
    call RegisterPossession('ACps')
    call RegisterPossession('A0G7')
    call RegisterPossession('A0R4')
    call RegisterPossession('A1VW')
    
    // Power Generator
    call RegisterUnitAbility(ABILITY_STARFALL_POWER_GENERATOR)
    call RegisterAbilityField(ABILITY_STARFALL_POWER_GENERATOR, GetHandleId(ABILITY_RLF_DAMAGE_DEALT_ESF1))
    
    call RegisterHealAura(ABILITY_LIFE_REGENERATION_NEUTRAL)
    call RegisterHealAura(ABILITY_AUTO_REPAIR)
    call RegisterHealAura(ABILITY_ANCIENT_AUTO_REPAIR)

    call RegisterDevotionAura(ABILITY_DEVOTION_AURA_POWER_GENERATOR)
    call RegisterDevotionAura(ABILITY_ANCIENT_DEVOTION_AURA)

    // Cargo Hold
    call RegisterCargoHold('Abun')
    call RegisterCargoHold('Sch2')
    call RegisterCargoHold('Sch3')
    call RegisterCargoHold('Sch5')
    call RegisterCargoHold('S000')
    call RegisterCargoHold('S007')
    call RegisterCargoHold('S01A')

    // Goblin Land Mines/Sappers etc.
    call RegisterAOEDamageUponDeath('Amnz')
    call RegisterAOEDamageUponDeath('Amnx')
    call RegisterAOEDamageUponDeath('Adda')
    call RegisterAOEDamageUponDeath('A0BD')
    call RegisterAOEDamageUponDeath('A0BD')
    call RegisterAOEDamageUponDeath('A1SU')
    call RegisterAOEDamageUponDeath('A0C0')
    call RegisterAOEDamageUponDeath('A1Z0')
    call RegisterAOEDamageUponDeath('A1E6')
    call RegisterAOEDamageUponDeath('A0KB')
    call RegisterAOEDamageUponDeath('A0YT')
    call RegisterAOEDamageUponDeath('A0YU')
    call RegisterAOEDamageUponDeath('A0Z3')
    
    // Claws etc.
    call RegisterItemAttackBonus('AItg')
    call RegisterItemAttackBonus('AIth')
    call RegisterItemAttackBonus('AIat')
    call RegisterItemAttackBonus('AIti')
    call RegisterItemAttackBonus('AItj')
    call RegisterItemAttackBonus('AIt6')
    call RegisterItemAttackBonus('AItk')
    call RegisterItemAttackBonus('AItl')
    call RegisterItemAttackBonus('AIt9')
    call RegisterItemAttackBonus('AItn')
    call RegisterItemAttackBonus('AItc')
    call RegisterItemAttackBonus('AItf')
    call RegisterItemAttackBonus('AItx') // +20 damage
    call RegisterItemAttackBonus('A24B') // +25 damage
    
    // Ring of Protections etc.
    call RegisterItemDefenseBonus('AId1')
    call RegisterItemDefenseBonus('AId2')
    call RegisterItemDefenseBonus('AId3')
    call RegisterItemDefenseBonus('AId4')
    call RegisterItemDefenseBonus('AId5')
    call RegisterItemDefenseBonus('AId7')
    call RegisterItemDefenseBonus('AId8')
    call RegisterItemDefenseBonus('AId0')
    call RegisterItemDefenseBonus('A09D')
    call RegisterItemDefenseBonus('A14K')
    
    // Orbs
    call RegisterItemDamageBonusOrb('AIdf') // Item Attack Block Arrow Bonus
    call RegisterItemDamageBonusOrb('AIfb') // Item Attack Fire Bonus
    call RegisterItemDamageBonusOrb('AIgd') // Item Attack Fire Bonus  (Gul'dan)
    call RegisterItemDamageBonusOrb('AIob') // Item Attack Frost Bonus
    call RegisterItemDamageBonusOrb('AIlb') // Item Attack Lightning Bonus
    call RegisterItemDamageBonusOrb('AIll') // Item Attack Lightning Bonus (new)
    call RegisterItemDamageBonusOrb('AIpb') // Item Attack Poison Bonus
    call RegisterItemDamageBonusOrb('AIsb') // Item Attack Slow Bonus
    
    // Permanent hero stats
    call RegisterItemAllStatsBonus('AIx1')
    call RegisterItemAllStatsBonus('AIx2')
    call RegisterItemAllStatsBonus('AIx3')
    call RegisterItemAllStatsBonus('AIx4')
    call RegisterItemAllStatsBonus('AIx5')
    call RegisterItemAllStatsBonus('A10U') // Item Hero Stat Bonus (+6 All Stats)
    call RegisterItemAllStatsBonus('A10V') // Item Hero Stat Bonus (+7 All Stats)
    call RegisterItemAllStatsBonus('A05E') // Item Hero Stat Bonus (+10 All Stats)
    call RegisterItemAllStatsBonus('A0AA') // Item Hero Stat Bonus (+15 All Stats)
    call RegisterItemAllStatsBonus('A0CF') // Item Hero Stat Bonus (+30 All Stats)
 
    // Tomes
    call RegisterItemLevelsGained('AIlm')
    call RegisterItemAllStatsBonus('AIxm')
    call RegisterItemStrengthBonus('AIsm')
    call RegisterItemStrengthBonus('AInm')
    call RegisterItemAgilityBonus('AIam')
    call RegisterItemAgilityBonus('AIgm')
    call RegisterItemIntelligenceBonus('AIim')
    call RegisterItemIntelligenceBonus('AItm')
    call RegisterItemAttackModification('AIaa')
    
    // Chain Lightning
    call RegisterItemChainLightningBonus('AIcl')
    
    // Shadow Strike
    call RegisterUnitShadowStrikeBonus('AEsh')
    call RegisterUnitShadowStrikeBonus('ACss')
    call RegisterItemShadowStrikeBonus('A0YE')
    
    // Summon 1 Unit Type
    call RegisterItemSummon1UnitTypeBonus('AIfu')
    call RegisterItemSummon1UnitTypeBonus('AIir')
    call RegisterItemSummon1UnitTypeBonus('AIbd')
    call RegisterItemSummon1UnitTypeBonus('AIbd')
    call RegisterItemSummon1UnitTypeBonus('AIes')
    call RegisterItemSummon1UnitTypeBonus('AIfs')
    call RegisterItemSummon1UnitTypeBonus('AIuw')
    call RegisterItemSummon1UnitTypeBonus('AIfd')
    call RegisterItemSummon1UnitTypeBonus('AIfh')
    call RegisterItemSummon1UnitTypeBonus('AIfr')
    call RegisterItemSummon1UnitTypeBonus('AIut')
    call RegisterItemSummon1UnitTypeBonus('AIsh')
    call RegisterItemSummon1UnitTypeBonus('A06R')
    call RegisterItemSummon1UnitTypeBonus('A06S')
    call RegisterItemSummon1UnitTypeBonus('A06T')
    call RegisterItemSummon1UnitTypeBonus('A06U')
    call RegisterItemSummon1UnitTypeBonus('A0MB')
    
    // Summon 1 Unit Type Amount
    call RegisterUnitSummon1AmountUnitTypeBonus('AHwe')
    call RegisterUnitSummon1AmountUnitTypeBonus('ANsg')
    call RegisterUnitSummon1AmountUnitTypeBonus('ANsw')
    call RegisterUnitSummon1AmountUnitTypeBonus('ANsq')
    
    // Summon 2 Unit Type Amount
    call RegisterUnitSummon2AmountUnitTypeBonus('ANdo')
    
    // Reanimate
    call RegisterUnitReanimateBonus('AUan')

    // Life Regeneration
    call RegisterItemLifeRegenerationBonus('Arel')
    
    // Life Bonus
    call RegisterItemLifeBonus('AIl1')
    call RegisterItemLifeBonus('AIl2')
    call RegisterItemLifeBonus('AIlz')
    call RegisterItemLifeBonus('AIlf')
    call RegisterItemLifeBonus('AImh')
    call RegisterItemLifeBonus('AIpx')
    
    // Mana Bonus
    call RegisterItemManaBonus('AIbm')
    call RegisterItemManaBonus('AImb')
    
    // XP Bonus
    call RegisterItemXPBonus('AIem')
    call RegisterItemXPBonus('AIl2')
    
    // Critical Strikes
    call RegisterItemCriticalStrikeBonus('AIcs')
   
    // Evasion
    call RegisterEvasion(ABILITY_EVASION)
    call RegisterItemEvasionBonus('AIev')
    
    // Armor Aura
    call RegisterItemArmorAuraBonus('AIev')
    
    // Classes
    
    // Paladin
    call RegisterUnitAbilityField(ABILITY_HEAL, GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_HEA1))
    
    call RegisterUnitAbility(ABILITY_INNFER_FIRE)
    call RegisterAbilityField(ABILITY_INNFER_FIRE, GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1))
    call RegisterAbilityField(ABILITY_INNFER_FIRE, GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_INF2))
    
    call RegisterUnitHealBonus(ABILITY_HOLY_LIGHT, GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1))
    call RegisterUnitHealBonus(ABILITY_MASS_HOLY_LIGHT_DUMMY, GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1))
    
    call RegisterUnitAbility(ABILITY_HEALING_WAVE)
    call RegisterAbilityField(ABILITY_HEALING_WAVE, GetHandleId(ABILITY_ILF_NUMBER_OF_TARGETS_HIT))
    call RegisterAbilityField(ABILITY_HEALING_WAVE, GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_OCL1))
    
    call RegisterUnitAbility(ABILITY_DEVOTION_AURA)
    call RegisterAbilityField(ABILITY_DEVOTION_AURA, GetHandleId(ABILITY_RLF_ARMOR_BONUS_HAD1))
    
    call RegisterUnitAbility(ABILITY_HOLY_AURA)
    call RegisterAbilityField(ABILITY_HOLY_AURA, GetHandleId(ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT))
    call RegisterAbilityField(ABILITY_HOLY_AURA, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1))
    
    call RegisterUnitAbility(ABILITY_HEALING_SPRAY)
    call RegisterAbilityField(ABILITY_HEALING_SPRAY, GetHandleId(ABILITY_RLF_DAMAGE_AMOUNT_NCS1))
    //call RegisterAbilityField(ABILITY_HEALING_SPRAY, GetHandleId(ABILITY_RLF_MAX_DAMAGE_NCS4))
    call RegisterAbilityField(ABILITY_HEALING_SPRAY, GetHandleId(ABILITY_ILF_WAVE_COUNT_NHS6))
    
    call RegisterUnitAbility(ABILITY_HORN_OF_STORMWIND)
    call RegisterAbilityField(ABILITY_HORN_OF_STORMWIND, GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_ROA2))
    
    call RegisterUnitAbilityField(ABILITY_RESURRECTION, GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1))

    // Arcanist
    call RegisterUnitAbility(ABILITY_BANISH)
    call RegisterAbilityField(ABILITY_BANISH, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_BANISH, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    call RegisterUnitAbility(ABILITY_SPELL_STEAL)
    call RegisterAbilityField(ABILITY_SPELL_STEAL, GetHandleId(ABILITY_RLF_CAST_RANGE))
    call RegisterAbilityField(ABILITY_SPELL_STEAL, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterUnitAbility(ABILITY_CONTROL_MAGIC)
    call RegisterAbilityField(ABILITY_CONTROL_MAGIC, GetHandleId(ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT))
    call RegisterAbilityField(ABILITY_CONTROL_MAGIC, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1))
    
    call RegisterUnitAbility(ABILITY_FEEDBACK)
    call RegisterAbilityField(ABILITY_FEEDBACK, GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED_UNITS))
    call RegisterAbilityField(ABILITY_FEEDBACK, GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED_HEROS))
    
    call RegisterUnitAbilityField(ABILITY_MANA_SHIELD, GetHandleId(ABILITY_RLF_MANA_PER_HIT_POINT))
    
    call RegisterUnitAbility(ABILITY_SIPHON_MANA)
    call RegisterAbilityField(ABILITY_SIPHON_MANA, GetHandleId(ABILITY_RLF_MANA_POINTS_DRAINED))
    call RegisterAbilityField(ABILITY_SIPHON_MANA, GetHandleId(ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND))
    
    call RegisterUnitAbility(ABILITY_DISPEL_MAGIC)
    call RegisterAbilityField(ABILITY_DISPEL_MAGIC, GetHandleId(ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2))
    
    call RegisterUnitAbilityField(ABILITY_BRILLIANCE_AURA, GetHandleId(ABILITY_RLF_MANA_REGENERATION_INCREASE))
    call RegisterUnitAbilityField(ABILITY_MASS_TELEPORT, GetHandleId(ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED))
    call RegisterUnitAbilityField(ABILITY_MASS_TELEPORT, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterPolymorph(ABILITY_POLYMORPH)

    // Death Knight
    call RegisterUnitAbility(ABILITY_CURSE)
    call RegisterAbilityField(ABILITY_CURSE, GetHandleId(ABILITY_RLF_CHANCE_TO_MISS_CRS))
    
    call RegisterUnitHealBonus(ABILITY_DEATH_COIL, GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1))
    call RegisterUnitHealBonus(ABILITY_MASS_DEATH_COIL_DUMMY, GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1))
    
    call RegisterUnitAbility(ABILITY_CARRION_SWARM)
    call RegisterAbilityField(ABILITY_CARRION_SWARM, GetHandleId(ABILITY_RLF_DAMAGE_UCS1))
    call RegisterAbilityField(ABILITY_CARRION_SWARM, GetHandleId(ABILITY_RLF_MAX_DAMAGE_UCS2))
    
    call RegisterUnitAbility(ABILITY_SLEEP)
    call RegisterAbilityField(ABILITY_SLEEP, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_SLEEP, GetHandleId(ABILITY_RLF_DURATION_HERO))

    call RegisterUnitAbility(ABILITY_UNHOLY_FRENZY)
    call RegisterAbilityField(ABILITY_UNHOLY_FRENZY, GetHandleId(ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT))
    //call RegisterAbilityField(ABILITY_UNHOLY_FRENZY, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_UHF2)) // This will allow killing enemy units.
    
    call RegisterUnitAbilityField(ABILITY_BLACK_ARROW, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_NBA1))
    call RegisterUnitAbilityField(ABILITY_BLACK_ARROW, GetHandleId(ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2))
    
    call RegisterUnitAbility(ABILITY_UNHOLY_AURA)
    call RegisterAbilityField(ABILITY_UNHOLY_AURA, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1))
    call RegisterAbilityField(ABILITY_UNHOLY_AURA, GetHandleId(ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT))
    
    call RegisterUnitAbility(ABILITY_VAMPIRIC_AURA)
    call RegisterAbilityField(ABILITY_VAMPIRIC_AURA, GetHandleId(ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT))
    
    call RegisterUnitAbility(ABILITY_ORB_OF_ANNHILIATION)
    call RegisterAbilityField(ABILITY_ORB_OF_ANNHILIATION, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_FAK1))
    
    call RegisterUnitAbility(ABILITY_ANIMATE_DEAD)
    call RegisterAbilityField(ABILITY_ANIMATE_DEAD, GetHandleId(ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1))
    
    call RegisterUnitAbility(ABILITY_ANIMATE_DEAD)
    call RegisterAbilityField(ABILITY_DEATH_AND_DECAY, GetHandleId(ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT))

    // Warlock
    call RegisterUnitAbility(ABILITY_CRIPPLE)
    call RegisterAbilityField(ABILITY_CRIPPLE, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1))
    call RegisterAbilityField(ABILITY_CRIPPLE, GetHandleId(ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2))
    call RegisterAbilityField(ABILITY_CRIPPLE, GetHandleId(ABILITY_RLF_DAMAGE_REDUCTION_CRI3))
    
    call RegisterUnitAbility(ABILITY_MANA_BURN)
    call RegisterAbilityField(ABILITY_MANA_BURN, GetHandleId(ABILITY_RLF_MAX_MANA_DRAINED))
    
    call RegisterUnitAbility(ABILITY_DEVOUR_MAGIC)
    call RegisterAbilityField(ABILITY_DEVOUR_MAGIC, GetHandleId(ABILITY_RLF_LIFE_PER_UNIT))
    call RegisterAbilityField(ABILITY_DEVOUR_MAGIC, GetHandleId(ABILITY_RLF_MANA_PER_UNIT))
    call RegisterAbilityField(ABILITY_DEVOUR_MAGIC, GetHandleId(ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5))
    
    call RegisterUnitAbility(ABILITY_DARK_SUMMONING)
    call RegisterAbilityField(ABILITY_DARK_SUMMONING, GetHandleId(ABILITY_ILF_MAXIMUM_UNITS))
    
    call RegisterUnitAbility(ABILITY_HOWL_OF_TERROR)
    call RegisterAbilityField(ABILITY_HOWL_OF_TERROR, GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1))
    
    call RegisterUnitAbility(ABILITY_DOOM)
    call RegisterAbilityField(ABILITY_DOOM, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_NDO1))
    // TODO Field 'Ndo4' is missing in common.j
    call RegisterAbilityField(ABILITY_DOOM, 'Ndo4')
    
    call RegisterUnitAbility(ABILITY_FINGER_OF_DEATH)
    call RegisterAbilityField(ABILITY_FINGER_OF_DEATH, GetHandleId(ABILITY_RLF_DAMAGE_NFD3))
    
    // Pyromancer
    call RegisterUnitAbility(ABILITY_FIREBOLT)
    call RegisterAbilityField(ABILITY_FIREBOLT, GetHandleId(ABILITY_RLF_DAMAGE_HTB1))
    call RegisterAbilityField(ABILITY_FIREBOLT, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_FIREBOLT, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    call RegisterUnitAbilityField(ABILITY_IMMOLATION, GetHandleId(ABILITY_RLF_DAMAGE_PER_INTERVAL))
    
    call RegisterUnitAbility(ABILITY_RAIN_OF_FIRE)
    call RegisterAbilityField(ABILITY_RAIN_OF_FIRE, GetHandleId(ABILITY_RLF_DAMAGE_HBZ2))
    call RegisterAbilityField(ABILITY_RAIN_OF_FIRE, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5))
    
    call RegisterUnitAbility(ABILITY_FLAME_STRIKE)
    call RegisterAbilityField(ABILITY_FLAME_STRIKE, GetHandleId(ABILITY_RLF_FULL_DAMAGE_DEALT))
    call RegisterAbilityField(ABILITY_FLAME_STRIKE, GetHandleId(ABILITY_RLF_HALF_DAMAGE_DEALT))
    
    call RegisterUnitAbility(ABILITY_VOLCANO)
    call RegisterAbilityField(ABILITY_VOLCANO, GetHandleId(ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5))
    call RegisterAbilityField(ABILITY_VOLCANO, GetHandleId(ABILITY_ILF_ROCK_RING_COUNT))
    
    call RegisterUnitAbility(ABILITY_INCINERATE)
    call RegisterAbilityField(ABILITY_INCINERATE, GetHandleId(ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER))
    call RegisterAbilityField(ABILITY_INCINERATE, GetHandleId(ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT))
    call RegisterAbilityField(ABILITY_INCINERATE, GetHandleId(ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT))
    
    // Hydromancer
    call RegisterUnitAbility(ABILITY_FROST_BOLT)
    call RegisterAbilityField(ABILITY_FROST_BOLT, GetHandleId(ABILITY_RLF_DAMAGE_HTB1))
    
    call RegisterUnitAbility(ABILITY_CRUSHING_WAVE)
    call RegisterAbilityField(ABILITY_CRUSHING_WAVE, GetHandleId(ABILITY_RLF_DAMAGE_UCS1))
    call RegisterAbilityField(ABILITY_CRUSHING_WAVE, GetHandleId(ABILITY_RLF_MAX_DAMAGE_UCS2))
    
    // Fountain of Power
    call RegisterUnitAbility(ABILITY_LIFE_REGENERATION_NEUTRAL)
    call RegisterAbilityField(ABILITY_LIFE_REGENERATION_NEUTRAL, GetHandleId(ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED))
    call RegisterUnitAbility(ABILITY_MANA_REGENERATION_NEUTRAL)
    call RegisterAbilityField(ABILITY_MANA_REGENERATION_NEUTRAL, GetHandleId(ABILITY_RLF_AMOUNT_REGENERATED))
    
    call RegisterUnitAbility(ABILITY_BREATH_OF_FROST)
    call RegisterUnitHealBonus(ABILITY_BREATH_OF_FROST, GetHandleId(ABILITY_RLF_DAMAGE_UCS1))
    call RegisterUnitHealBonus(ABILITY_BREATH_OF_FROST, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_NBF5))
    
    call RegisterUnitHealBonus(ABILITY_FROST_ARMOR, GetHandleId(ABILITY_RLF_ARMOR_BONUS_UFA2))
    
    call RegisterUnitAbility(ABILITY_BLIZZARD)
    call RegisterAbilityField(ABILITY_BLIZZARD, GetHandleId(ABILITY_RLF_DAMAGE_HBZ2))
   
    call RegisterUnitAbility(FROST_NOVA)
    call RegisterUnitHealBonus(FROST_NOVA, GetHandleId(ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2))
    call RegisterAbilityField(FROST_NOVA, GetHandleId(ABILITY_RLF_AREA_OF_EFFECT_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_FROST_ARROWS)
    call RegisterAbilityField(ABILITY_FROST_ARROWS, GetHandleId(ABILITY_RLF_EXTRA_DAMAGE_HCA1))
    call RegisterAbilityField(ABILITY_FROST_ARROWS, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2))
    call RegisterAbilityField(ABILITY_FROST_ARROWS, GetHandleId(ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3))
    
    call RegisterUnitAbilityField(ABILITY_MONSOON, GetHandleId(ABILITY_RLF_DAMAGE_DEALT_ESF1))
    
    // Geomancer
    call RegisterUnitAbility(ABILITY_HURL_BOULDER)
    call RegisterAbilityField(ABILITY_HURL_BOULDER, GetHandleId(ABILITY_RLF_DAMAGE_CTB1))
    
    call RegisterUnitAbility(ABILITY_ENDURANCE_AURA)
    call RegisterAbilityField(ABILITY_ENDURANCE_AURA, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1))
    call RegisterAbilityField(ABILITY_ENDURANCE_AURA, GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2))
    
    call RegisterUnitAbility(ABILITY_FAR_SIGHT)
    call RegisterAbilityField(ABILITY_FAR_SIGHT, GetHandleId(ABILITY_RLF_AREA_OF_EFFECT))
    call RegisterAbilityField(ABILITY_FAR_SIGHT, GetHandleId(ABILITY_RLF_DURATION_NORMAL))

    call RegisterUnitAbility(ABILITY_SHOCKWAVE)
    call RegisterAbilityField(ABILITY_SHOCKWAVE, GetHandleId(ABILITY_RLF_DAMAGE_OSH1))
    
    call RegisterUnitAbility(ABILITY_SLAM)
    call RegisterAbilityField(ABILITY_SLAM, GetHandleId(ABILITY_RLF_DAMAGE_CTC1))
    call RegisterAbilityField(ABILITY_SLAM, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3))
    call RegisterAbilityField(ABILITY_SLAM, GetHandleId(ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4))

    call RegisterUnitAbility(ABILITY_BLOODLUST)
    call RegisterAbilityField(ABILITY_BLOODLUST, GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1))
    call RegisterAbilityField(ABILITY_BLOODLUST, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2))
    
    call RegisterUnitAbility(ABILITY_STAMPEDE)
    call RegisterAbilityField(ABILITY_STAMPEDE, GetHandleId(ABILITY_RLF_DAMAGE_AMOUNT_NST3))
    
    call RegisterUnitAbility(ABILITY_REINCARNATION)
    call RegisterAbilityField(ABILITY_REINCARNATION, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterUnitAbility(ABILITY_EARTH_QUAKE)
    call RegisterAbilityField(ABILITY_EARTH_QUAKE, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS))
    call RegisterAbilityField(ABILITY_EARTH_QUAKE, GetHandleId(ABILITY_RLF_UNITS_SLOWED_PERCENT))
    
    // Aeromancer
    call RegisterUnitAbilityField(ABILITY_CHAIN_LIGHTNING, GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_OCL1))
    call RegisterUnitAbilityField(ABILITY_FORKED_LIGHTNING, GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_OCL1))
    
    call RegisterUnitAbility(ABILITY_BLINK)
    call RegisterAbilityField(ABILITY_BLINK, GetHandleId(ABILITY_RLF_MAXIMUM_RANGE))
    
    call RegisterUnitAbility(ABILITY_AERIAL_SHACKLES)
    call RegisterAbilityField(ABILITY_AERIAL_SHACKLES, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_MLS1))

    call RegisterUnitAbility(ABILITY_LIGHTNING_SHIELD)
    call RegisterAbilityField(ABILITY_LIGHTNING_SHIELD, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_LSH1))
    
    call RegisterUnitAbility(ABILITY_TORNADO_BUILDING_DAMAGE_AURA)
    call RegisterAbilityField(ABILITY_TORNADO_BUILDING_DAMAGE_AURA, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_TDG1))
    call RegisterAbilityField(ABILITY_TORNADO_BUILDING_DAMAGE_AURA, GetHandleId(ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND))
    
    // Warrior
    call RegisterUnitAbility(ABILITY_STORM_BOLT)
    call RegisterAbilityField(ABILITY_STORM_BOLT, GetHandleId(ABILITY_RLF_DAMAGE_HTB1))
    
    call RegisterUnitAbility(ABILITY_BERSERK)
    call RegisterAbilityField(ABILITY_BERSERK, GetHandleId(ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2))
    
    call RegisterUnitAbility(ABILITY_THUNDER_CLAP)
    call RegisterAbilityField(ABILITY_THUNDER_CLAP, GetHandleId(ABILITY_RLF_AOE_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_SPIKED_SHELL)
    call RegisterAbilityField(ABILITY_SPIKED_SHELL, GetHandleId(ABILITY_RLF_RETURNED_DAMAGE_FACTOR))
    call RegisterAbilityField(ABILITY_SPIKED_SHELL, GetHandleId(ABILITY_RLF_DEFENSE_BONUS_UTS3))
    
    call RegisterUnitAbility(ABILITY_WAR_STOMP)
    call RegisterAbilityField(ABILITY_WAR_STOMP, GetHandleId(ABILITY_RLF_DAMAGE_WRS1))
    
    call RegisterUnitAbility(ABILITY_BASH)
    call RegisterAbilityField(ABILITY_BASH, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HBH3))
    
    call RegisterUnitAbility(ABILITY_CLEAVING_ATTACK)
    call RegisterAbilityField(ABILITY_CLEAVING_ATTACK, GetHandleId(ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1))
    
    call RegisterUnitAbility(ABILITY_COMMAND_AURA)
    call RegisterAbilityField(ABILITY_COMMAND_AURA, GetHandleId(ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1))
    
    call RegisterUnitAbility(ABILITY_IMPALE)
    call RegisterAbilityField(ABILITY_IMPALE, GetHandleId(ABILITY_RLF_DAMAGE_DEALT_UIM3))

    call RegisterUnitAbility(ABILITY_AVATAR)
    call RegisterAbilityField(ABILITY_AVATAR, GetHandleId(ABILITY_RLF_HIT_POINT_BONUS))
    call RegisterAbilityField(ABILITY_AVATAR, GetHandleId(ABILITY_RLF_DEFENSE_BONUS_HAV1))
    call RegisterAbilityField(ABILITY_AVATAR, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HAV3))
    
    // Druid
    call RegisterUnitAbility(ABILITY_REJUVENATION)
    call RegisterAbilityField(ABILITY_REJUVENATION, GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_REJ1))
    call RegisterAbilityField(ABILITY_REJUVENATION, GetHandleId(ABILITY_RLF_MANA_POINTS_GAINED_REJ2))
    
    call RegisterUnitAbility(ABILITY_FAERIE_FIRE)
    call RegisterAbilityField(ABILITY_FAERIE_FIRE, GetHandleId(ABILITY_ILF_DEFENSE_REDUCTION))
    
    call RegisterUnitAbility(ABILITY_THORNS_AURA)
    call RegisterAbilityField(ABILITY_THORNS_AURA, GetHandleId(ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS))
    
    call RegisterUnitAbility(ABILITY_ENTANGLING_ROOTS)
    call RegisterAbilityField(ABILITY_ENTANGLING_ROOTS, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_EER1))
    
    call RegisterUnitAbility(ABILITY_EAT_TREE)
    call RegisterAbilityField(ABILITY_EAT_TREE, GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_EAT3))
    
    call RegisterUnitAbility(ABILITY_MASS_FORESTATION)
    call RegisterAbilityField(ABILITY_MASS_FORESTATION, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterUnitAbility(ABILITY_ROAR)
    call RegisterAbilityField(ABILITY_ROAR, GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1))
    
    call RegisterUnitAbility(ABILITY_TRANQUILITY)
    call RegisterAbilityField(ABILITY_TRANQUILITY, GetHandleId(ABILITY_RLF_LIFE_HEALED))
    
    // Hunter
    call RegisterUnitAbility(ABILITY_RAIN_OF_ARROWS)
    call RegisterAbilityField(ABILITY_RAIN_OF_ARROWS, GetHandleId(ABILITY_RLF_DAMAGE_HBZ2))
    call RegisterAbilityField(ABILITY_RAIN_OF_ARROWS, GetHandleId(ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE))
    
    call RegisterUnitAbility(ABILITY_SENTINEL)
    call RegisterAbilityField(ABILITY_SENTINEL, GetHandleId(ABILITY_RLF_DURATION_OF_OWLS))
    call RegisterAbilityField(ABILITY_SENTINEL, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterUnitAbility(ABILITY_SCOUT)
    call RegisterAbilityField(ABILITY_SCOUT, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    
    call RegisterUnitAbility(ABILITY_FAN_OF_KNIVES)
    call RegisterAbilityField(ABILITY_FAN_OF_KNIVES, GetHandleId(ABILITY_RLF_DAMAGE_PER_TARGET_EFK1))
    call RegisterAbilityField(ABILITY_FAN_OF_KNIVES, GetHandleId(ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_SEARING_ARROWS)
    call RegisterAbilityField(ABILITY_SEARING_ARROWS, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_HFA1))
    
    call RegisterUnitAbility(ABILITY_BARRAGE)
    call RegisterAbilityField(ABILITY_BARRAGE, GetHandleId(ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3))
    
    call RegisterUnitAbility(ABILITY_TRUESHOT_AURA)
    call RegisterAbilityField(ABILITY_TRUESHOT_AURA, GetHandleId(ABILITY_RLF_DAMAGE_BONUS_PERCENT))
    
    call RegisterUnitAbility(ABILITY_MASS_DEVOUR_CARGO)
    call RegisterAbilityField(ABILITY_MASS_DEVOUR_CARGO, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3))
    call RegisterUnitAbility(ABILITY_MASS_DEVOUR_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_DEVOUR_DUMMY, GetHandleId(ABILITY_ILF_MAX_CREEP_LEVEL_DEV1))
    
    call RegisterUnitAbility(ABILITY_STARFALL)
    call RegisterAbilityField(ABILITY_STARFALL, GetHandleId(ABILITY_RLF_DAMAGE_DEALT_ESF1))
    
    // Rogue
    call RegisterUnitAbility(ABILITY_ENSNARE)
    call RegisterAbilityField(ABILITY_ENSNARE, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_ENSNARE, GetHandleId(ABILITY_RLF_DURATION_HERO))

    call RegisterUnitAbility(ABILITY_WIND_WALK)
    call RegisterAbilityField(ABILITY_WIND_WALK, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2))
    call RegisterAbilityField(ABILITY_WIND_WALK, GetHandleId(ABILITY_RLF_BACKSTAB_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_SHADOW_STRIKE)
    call RegisterAbilityField(ABILITY_SHADOW_STRIKE, GetHandleId(ABILITY_RLF_INITIAL_DAMAGE_ESH5))
    call RegisterAbilityField(ABILITY_SHADOW_STRIKE, GetHandleId(ABILITY_RLF_DECAYING_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_ACID_BOMB)
    call RegisterAbilityField(ABILITY_ACID_BOMB, GetHandleId(ABILITY_ILF_ARMOR_PENALTY_NAB3))
    call RegisterAbilityField(ABILITY_ACID_BOMB, GetHandleId(ABILITY_RLF_PRIMARY_DAMAGE))
    call RegisterAbilityField(ABILITY_ACID_BOMB, GetHandleId(ABILITY_RLF_SECONDARY_DAMAGE))
    
    call RegisterUnitAbility(ABILITY_POISON_ARROWS)
    call RegisterAbilityField(ABILITY_POISON_ARROWS, GetHandleId(ABILITY_RLF_EXTRA_DAMAGE_POA1))
    call RegisterAbilityField(ABILITY_POISON_ARROWS, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_POA2))
    
    call RegisterUnitAbility(ABILITY_ENVENOMED_WEAPONS)
    call RegisterAbilityField(ABILITY_ENVENOMED_WEAPONS, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_POI1))

    // Monk
    call RegisterUnitAbility(ABILITY_CHARGE)
    call RegisterAbilityField(ABILITY_CHARGE, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterUnitAbility(ABILITY_DRUNKEN_BRAWLER)
    call RegisterAbilityField(ABILITY_DRUNKEN_BRAWLER, GetHandleId(ABILITY_RLF_CHANCE_TO_EVADE_OCR4))
    call RegisterAbilityField(ABILITY_DRUNKEN_BRAWLER, GetHandleId(ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE))
    call RegisterAbilityField(ABILITY_DRUNKEN_BRAWLER, GetHandleId(ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2))
    
    call RegisterUnitAbility(ABILITY_DRUNKEN_HAZE)
    call RegisterAbilityField(ABILITY_DRUNKEN_HAZE, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_MODIFIER))
    call RegisterAbilityField(ABILITY_DRUNKEN_HAZE, GetHandleId(ABILITY_RLF_CHANCE_TO_MISS_PERCENT))
    
    call RegisterUnitAbility(ABILITY_MIRROR_IMAGE)
    call RegisterAbilityField(ABILITY_MIRROR_IMAGE, GetHandleId(ABILITY_ILF_NUMBER_OF_IMAGES))
    
    call RegisterSilence(ABILITY_DISARMAMENT)
    
    call RegisterUnitAbility(ABILITY_CLONE)
    call RegisterAbilityField(ABILITY_CLONE, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_CLONE, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    call RegisterUnitAbility(ABILITY_BLADESTORM)
    call RegisterAbilityField(ABILITY_BLADESTORM, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_OWW1))
    
    // Necromancer
    //call RegisterUnitAbilityField(ABILITY_RAISE_DEAD, GetHandleId(ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE))
    
    call RegisterUnitAbility(ABILITY_CANNIBALIZE)
    call RegisterAbilityField(ABILITY_CANNIBALIZE, GetHandleId(ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1))
    call RegisterAbilityField(ABILITY_CANNIBALIZE, GetHandleId(ABILITY_RLF_MAX_HIT_POINTS))
    
    call RegisterUnitAbility(ABILITY_DEATH_PACT)
    call RegisterAbilityField(ABILITY_DEATH_PACT, GetHandleId(ABILITY_RLF_LIFE_CONVERTED_TO_LIFE))
    
    call RegisterUnitAbility(ABILITY_DARK_RITUAL)
    call RegisterAbilityField(ABILITY_DARK_RITUAL, GetHandleId(ABILITY_RLF_LIFE_CONVERTED_TO_MANA))
    
    call RegisterUnitAbility(ABILITY_CARRION_BEETLES)
    call RegisterAbilityField(ABILITY_CARRION_BEETLES, GetHandleId(ABILITY_ILF_MAX_UNITS_SUMMONED))
    
    call RegisterUnitAbility(ABILITY_DISEASE_CLOUD)
    call RegisterAbilityField(ABILITY_DISEASE_CLOUD, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_APL2))
    
    call RegisterUnitAbility(ABILITY_DISEASE_CLOUD_MEAT_WAGON)
    call RegisterAbilityField(ABILITY_DISEASE_CLOUD_MEAT_WAGON, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_APL2))
    call RegisterCargoHold(ABILITY_CARGO_HOLD_MEAT_WAGON)
    call RegisterUnitAbility(ABILITY_EXHUME_CORPSES_MEAT_WAGON)
    call RegisterAbilityField(ABILITY_EXHUME_CORPSES_MEAT_WAGON, GetHandleId(ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1))
    
    call RegisterUnitAbility(ABILITY_LIFE_DRAIN)
    call RegisterAbilityField(ABILITY_LIFE_DRAIN, GetHandleId(ABILITY_RLF_HIT_POINTS_DRAINED))
    call RegisterAbilityField(ABILITY_LIFE_DRAIN, GetHandleId(ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND))

    // Witch Doctor
    call RegisterSilence(ABILITY_SILENCE)
    
    call RegisterUnitAbility(ABILITY_SLOW)
    call RegisterAbilityField(ABILITY_SLOW, GetHandleId(ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1))
    call RegisterAbilityField(ABILITY_SLOW, GetHandleId(ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2))
    
    call RegisterSilence(ABILITY_HEX)
    call RegisterAbilityField(ABILITY_HEX, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_HEX, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    call RegisterSilence(ABILITY_SCREAM)
    call RegisterAbilityField(ABILITY_SCREAM, GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_ROA2))
    
    call RegisterSilence(ABILITY_LOCUST_SWARM)
    call RegisterAbilityField(ABILITY_LOCUST_SWARM, GetHandleId(ABILITY_ILF_NUMBER_OF_SWARM_UNITS))
    call RegisterAbilityField(ABILITY_LOCUST_SWARM, GetHandleId(ABILITY_RLF_DAMAGE_RETURN_FACTOR))
    
    call RegisterUnitAbility(ABILITY_SPELL_SHIELD)
    call RegisterAbilityField(ABILITY_SPELL_SHIELD, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_SPELL_SHIELD, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    call RegisterUnitAbility(ABILITY_CHARM)
    call RegisterAbilityField(ABILITY_CHARM, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1))
    
    call RegisterSilence(ABILITY_BIG_BAD_VOODOO)
    call RegisterAbilityField(ABILITY_BIG_BAD_VOODOO, GetHandleId(ABILITY_RLF_DURATION_NORMAL))
    call RegisterAbilityField(ABILITY_BIG_BAD_VOODOO, GetHandleId(ABILITY_RLF_DURATION_HERO))
    
    // Tinker
    call RegisterUnitAbility(ABILITY_REPAIR)
    call RegisterAbilityField(ABILITY_REPAIR, GetHandleId(ABILITY_RLF_REPAIR_COST_RATIO))
    
    call RegisterUnitAbility(ABILITY_DEMOLISH)
    call RegisterAbilityField(ABILITY_DEMOLISH, GetHandleId(ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS))
    
    call RegisterUnitAbility(ABILITY_CLUSTER_ROCKETS)
    call RegisterAbilityField(ABILITY_CLUSTER_ROCKETS, GetHandleId(ABILITY_RLF_DAMAGE_AMOUNT_NCS1))
    //call RegisterAbilityField(ABILITY_CLUSTER_ROCKETS, GetHandleId(ABILITY_RLF_MAX_DAMAGE_NCS4))
    //call RegisterAbilityField(ABILITY_CLUSTER_ROCKETS, GetHandleId(ABILITY_ILF_MISSILE_COUNT)) // If you increase the Effect Duration to let's say 1/2/3 seconds then it will fire the 6/12/18 missiles at the same rate.
    
    call RegisterUnitAbility(ABILITY_JETPACK)
    call RegisterAbilityField(ABILITY_JETPACK, GetHandleId(ABILITY_RLF_CAST_RANGE))
    
    call RegisterUnitAbility(ABILITY_TRANSMUTE)
    call RegisterAbilityField(ABILITY_TRANSMUTE, GetHandleId(ABILITY_ILF_MAX_CREEP_LEVEL_NTM3))
    call RegisterAbilityField(ABILITY_TRANSMUTE, GetHandleId(ABILITY_RLF_GOLD_COST_FACTOR))
    call RegisterAbilityField(ABILITY_TRANSMUTE, GetHandleId(ABILITY_RLF_LUMBER_COST_FACTOR))
    
    call RegisterUnitAbility(ABILITY_MASS_TRANSMUTE_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_TRANSMUTE_DUMMY, GetHandleId(ABILITY_ILF_MAX_CREEP_LEVEL_NTM3))
    call RegisterAbilityField(ABILITY_MASS_TRANSMUTE_DUMMY, GetHandleId(ABILITY_RLF_GOLD_COST_FACTOR))
    call RegisterAbilityField(ABILITY_MASS_TRANSMUTE_DUMMY, GetHandleId(ABILITY_RLF_LUMBER_COST_FACTOR))
    
    // Other abilities
    call RegisterUnitAbility(ABILITY_ATTRIBUTE_BONUS)
    call RegisterAbilityField(ABILITY_ATTRIBUTE_BONUS, GetHandleId(ABILITY_ILF_STRENGTH_BONUS_ISTR))
    call RegisterAbilityField(ABILITY_ATTRIBUTE_BONUS, GetHandleId(ABILITY_ILF_AGILITY_BONUS))
    call RegisterAbilityField(ABILITY_ATTRIBUTE_BONUS, GetHandleId(ABILITY_ILF_INTELLIGENCE_BONUS))
    
    call RegisterUnitAbility(ABILITY_TRUE_SIGHT)
    call RegisterAbilityField(ABILITY_TRUE_SIGHT, GetHandleId(ABILITY_RLF_CAST_RANGE))
    
    call RegisterUnitAbility(ABILITY_INFERNO)
    call RegisterAbilityField(ABILITY_INFERNO, GetHandleId(ABILITY_RLF_DAMAGE_UIN1))
    call RegisterAbilityField(ABILITY_INFERNO, GetHandleId(ABILITY_RLF_DURATION))
    
    call RegisterUnitAbility(ABILITY_MASS_DOOM_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_DOOM_DUMMY, GetHandleId(ABILITY_RLF_DAMAGE_PER_SECOND_NDO1))
    // TODO Field 'Ndo4' is missing in common.j
    call RegisterAbilityField(ABILITY_MASS_DOOM_DUMMY, 'Ndo4')
    
    call RegisterUnitAbility(ABILITY_MASS_REJUVENATION_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_REJUVENATION_DUMMY, GetHandleId(ABILITY_RLF_HIT_POINTS_GAINED_REJ1))
    call RegisterAbilityField(ABILITY_MASS_REJUVENATION_DUMMY, GetHandleId(ABILITY_RLF_MANA_POINTS_GAINED_REJ2))
    
    call RegisterUnitAbility(ABILITY_MASS_CHARM_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_CHARM_DUMMY, GetHandleId(ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1))
    
    call RegisterUnitAbility(ABILITY_MASS_FINGER_OF_DEATH_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_FINGER_OF_DEATH_DUMMY, GetHandleId(ABILITY_RLF_DAMAGE_NFD3))
    
    call RegisterUnitAbilityField(ABILITY_MASS_HOLY_LIGHT_DUMMY, GetHandleId(ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1))
    call RegisterUnitAbility(ABILITY_MASS_INNER_FIRE_DUMMY)
    call RegisterAbilityField(ABILITY_MASS_INNER_FIRE_DUMMY, GetHandleId(ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1))
    call RegisterAbilityField(ABILITY_MASS_INNER_FIRE_DUMMY, GetHandleId(ABILITY_ILF_DEFENSE_INCREASE_INF2))

    call RegisterUnitAbility(ABILITY_DISCHARGE)
    call RegisterAbilityField(ABILITY_DISCHARGE, GetHandleId(ABILITY_RLF_COOLDOWN))
    
    call RegisterSilence(ABILITY_TELEKINESIS)
    call RegisterAbilityField(ABILITY_TELEKINESIS, GetHandleId(ABILITY_RLF_CAST_RANGE))
    call RegisterAbilityField(ABILITY_TELEKINESIS, GetHandleId(ABILITY_RLF_COOLDOWN))
endfunction

endlibrary
