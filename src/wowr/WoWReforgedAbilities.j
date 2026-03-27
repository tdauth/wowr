library WoWReforgedAbilities initializer Init requires WoWReforgedSkillMenu, WoWReforgedClasses

private function AddLearnableAbilityIdWithTooltip takes integer slot, integer abilityId, string tooltip returns nothing
    call AddLearnableAbilityId(slot, abilityId)
    call SetAbilityTooltip(abilityId, tooltip)
endfunction

private function Init takes nothing returns nothing
    local integer slot = 0
    
    // Slot 1
    set slot = 0
    
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_WEB, GetLocalizedString("WEB_TOOLTIP"))
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_SLOW, GetLocalizedString("SLOW_TOOLTIP"))
    
    // Slot 2
    set slot = 1
    
    // Submerge
    call AddLearnableAbilityId(slot, ABILITY_SUBMERGE_SEA_WITCH)
    call AddAllowedUnitType(NAGA_SORCERESS, SUBMERGED_SEAWITCH, ABILITY_SUBMERGE_SEA_WITCH)
    call AddAllowedUnitType(NAGA_ROYAL_GUARD_HERO, SUBMERGED_NAGA_ROYAL_GUARD_HERO, ABILITY_SUBMERGE_NAGA_ROYAL_GUARD)
    call AddAllowedUnitType(LADY_VASHJ, SUBMERGED_LADY_VASHJ, ABILITY_SUBMERGE_LADY_VASHJ)
    
    // Burrow
    call AddLearnableAbilityId(slot, ABILITY_BURROW_CRYPT_LORD)
    call AddAllowedUnitType(CRYPT_LORD, CRYPT_LORD_BURROWED, ABILITY_BURROW_CRYPT_LORD)
    call AddAllowedUnitType(NERUBIAN_QUEEN_HERO, NERUBIAN_QUEEN_HERO_BURROWED, ABILITY_BURROW_NERUBIAN_QUEEN)
    call AddAllowedUnitType(ANUBARAK_HERO, ANUBARAK_HERO_BURROWED, ABILITY_BURROW_ANUBARAK)
    call AddAllowedUnitType(GEOMANCER, GEOMANCER_BURROWED, ABILITY_BURROW_GEOMANCER)
    
    // Root
    call AddLearnableAbilityId(slot, ABILITY_ROOT_ANCIENT_OF_LORE)
    call AddAllowedUnitType(ANCIENT_OF_LORE_HERO, ANCIENT_OF_LORE_HERO_ROOTED, ABILITY_BURROW_GEOMANCER)
    
    // Slot 3
    set slot = 2
    
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_TELEPORTATION, GetLocalizedString("TELEPORTATION_TOOLTIP"))
    
    // Slot 10
    set slot = 9
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_ATTRIBUTE_BONUS, GetLocalizedString("ATTRIBUTE_BONUS_TOOLTIP"))
    call SetAbilityForHeroesOnly()
    
    // Slot 11
    set slot = 10
    call AddLearnableAbilityId(slot, ABILITY_SUMMON_SEA_ELEMENTAL)
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_SUMMON_FIRE_ELEMENTAL, GetLocalizedString("SUMMON_FIRE_ELEMENTAL_TOOLTIP"))
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_SUMMON_EARTH_ELEMENTAL, GetLocalizedString("SUMMON_EARTH_ELEMENTAL_TOOLTIP"))
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_INFERNO, GetLocalizedString("INFERNO_TOOLTIP"))
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_MASS_CHARM, GetLocalizedString("MASS_CHARM_TOOLTIP"))
    call AddLearnableAbilityIdWithTooltip(slot, ABILITY_MASS_FINGER_OF_DEATH, GetLocalizedString("MASS_FINGER_OF_DEATH_TOOLTIP"))
endfunction

endlibrary
