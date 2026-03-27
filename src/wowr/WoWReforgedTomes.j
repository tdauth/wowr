library WoWReforgedTomes initializer Init requires NewBonus, UnitGroupUtils, WoWReforgedProfessionEnchanter, WoWReforgedSkillMenu, WoWReforgedAbilitySkill, WoWReforgedI18n

globals
    private trigger castTrigger = CreateTrigger()
    private trigger useItemTrigger = CreateTrigger()
endglobals

function IsTome takes integer itemTypeId returns boolean
    if (itemTypeId == TOME_OF_AGILITY) then
        return true
    elseif (itemTypeId == TOME_OF_AGILITY_2) then
        return true
    elseif (itemTypeId == TOME_OF_EXPERIENCE) then
        return true
    elseif (itemTypeId == TOME_OF_GREATER_EXPERIENCE) then
        return true
    elseif (itemTypeId == TOME_OF_INTELLIGENCE) then
        return true
    elseif (itemTypeId == TOME_OF_INTELLIGENCE_2) then
        return true
    elseif (itemTypeId == TOME_OF_KNOWLEDGE) then
        return true
    elseif (itemTypeId == TOME_OF_STRENGTH) then
        return true
    elseif (itemTypeId == TOME_OF_STRENGTH_2) then
        return true
    elseif (itemTypeId == TOME_OF_POWER) then
        return true
    elseif (itemTypeId == TOME_OF_ARMOR) then
        return true
    elseif (itemTypeId == TOME_OF_DAMAGE) then
        return true
    elseif (itemTypeId == TOME_OF_MOVEMENT) then
        return true
    elseif (itemTypeId == TOME_OF_SIGHT) then
        return true
    elseif (itemTypeId == TOME_OF_MAGIC) then
        return true
    elseif (itemTypeId == TOME_OF_CHAOS) then
        return true
    elseif (itemTypeId == TOME_OF_DIVINITY) then
        return true
    elseif (itemTypeId == TOME_OF_SKILL_POINTS) then
        return true
    elseif (itemTypeId == MANUAL_OF_HEALTH) then
        return true
    elseif (itemTypeId == MANUAL_OF_MANA) then
        return true
    elseif (itemTypeId == TOME_OF_LIFE_REGENARTION) then
        return true
    elseif (itemTypeId == TOME_OF_MANA_REGENERATION) then
        return true
    endif
    return false
endfunction

function TomeOfMagic takes unit hero, integer levels returns nothing
    local integer abilityId = 0
    local integer i = 0
    loop
        exitwhen (i == MAX_UNIT_ABILITIES)
        set abilityId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(hero, i))
        exitwhen (abilityId == 0)
        call SkillAbility(hero, abilityId, levels)
        set i = i + 1
    endloop
endfunction

private function TriggerConditionCast takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local boolean result = false
    
    if (abilityId == 'AIsm') then
        set result = true
    elseif (abilityId == 'AInm') then
        set result = true
    elseif (abilityId == 'AIam') then
        set result = true
    elseif (abilityId == 'AIgm') then
        set result = true
    elseif (abilityId == 'AIim') then
        set result = true
    elseif (abilityId == 'AItm') then
        set result = true
    elseif (abilityId == 'AIxm') then
        set result = true
    elseif (abilityId == 'AIlm') then
        set result = true
    elseif (abilityId == 'AIem') then
        set result = true
    elseif (abilityId == 'AIe2') then
        set result = true
    elseif (abilityId == 'AImh') then
        set result = true
    elseif (abilityId == 'AIpx') then
        set result = true
    elseif (abilityId == 'AIaa') then
        set result = true
    elseif (abilityId == 'A24E') then
        set result = true
    endif
    
    if (result and not udg_Tomes) then
        call IssueImmediateOrder(GetTriggerUnit(), "stop")
        call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("TOMES_DISABLED"))
    endif
    
    return false
endfunction

function TriggerConditionUseItem takes nothing returns boolean
    local integer itemTypeId = GetItemTypeId(GetManipulatedItem())

    if (udg_Tomes) then
        if (itemTypeId == TOME_OF_CHAOS) then
            if (BlzGetUnitWeaponBooleanField(GetTriggerUnit(), UNIT_WEAPON_BF_ATTACKS_ENABLED, 0)) then
                call BlzSetUnitWeaponIntegerField(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 5) // ATTACK_TYPE_CHAOS
            endif
            if (BlzGetUnitWeaponBooleanField(GetTriggerUnit(), UNIT_WEAPON_BF_ATTACKS_ENABLED, 1)) then
                call BlzSetUnitWeaponIntegerField(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, 5) // ATTACK_TYPE_CHAOS
            endif
        elseif (itemTypeId == TOME_OF_DIVINITY) then
            call BlzSetUnitIntegerField(GetTriggerUnit(), UNIT_IF_DEFENSE_TYPE, 6) // DEFENSE_TYPE_DIVINE
        elseif (itemTypeId == TOME_OF_SKILL_POINTS) then
            call AddHeroSkillPoints(GetTriggerUnit(), 1 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS))
        elseif (itemTypeId == TOME_OF_ARMOR) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_ARMOR, I2R(3 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)))
        elseif (itemTypeId == TOME_OF_MOVEMENT) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_MOVEMENT_SPEED, I2R(3 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)))
        elseif (itemTypeId == TOME_OF_SIGHT) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_SIGHT_RANGE, I2R(3 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS)))
        elseif (itemTypeId == TOME_OF_MAGIC) then
            call TomeOfMagic(GetTriggerUnit(), 1)
        elseif (itemTypeId == MANUAL_OF_MANA) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_MANA, 50.00 + EnchanterSystemLoadBonusReal(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HIT_POINTS_AND_MANA_BONUS))
        elseif (itemTypeId == TOME_OF_LIFE_REGENARTION) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_HEALTH_REGEN, I2R(1 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)))
        elseif (itemTypeId == TOME_OF_MANA_REGENERATION) then
            call AddUnitBonus(GetTriggerUnit(), BONUS_MANA_REGEN, I2R(1 + EnchanterSystemLoadBonus(GetTriggerUnit(), ENCHANTER_SYSTEM_KEY_HERO_STATS_AND_DEFENSE_BONUS)))
        endif
    endif

    return false
endfunction

private function EnumShowLibrary takes nothing returns nothing
    call ShowUnit(GetEnumUnit(), true)
    call SetUnitPathing(GetEnumUnit(), true)
endfunction

function HideLibrary takes unit whichUnit returns nothing
    call ShowUnit(whichUnit, false)
    call SetUnitPathing(whichUnit, false)
endfunction

private function EnumHideLibrary takes nothing returns nothing
    call HideLibrary(GetEnumUnit())
endfunction

function ShowLibraries takes nothing returns nothing
    local group g = GetUnitsOfTypeId(LIBRARY, Player(PLAYER_NEUTRAL_PASSIVE))
    call ForGroup(g, function EnumShowLibrary)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

function HideLibraries takes nothing returns nothing
    local group g = GetUnitsOfTypeId(LIBRARY, Player(PLAYER_NEUTRAL_PASSIVE))
    call ForGroup(g, function EnumHideLibrary)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition(castTrigger, Condition(function TriggerConditionCast))
    
    call TriggerRegisterAnyUnitEventBJ(useItemTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(useItemTrigger, Condition(function TriggerConditionUseItem))
endfunction

endlibrary
