library WoWReforgedGoblinToolBox requires NewBonus, Attributes, UnitCost, HeroUtils, PlayerColorUtils, WoWReforgedSaveCodeObjects, ItemTypeUtils, WoWReforgedRaces, WoWReforgedHeroes, WoWReforgedTerrain, WoWReforgedAbilityFields, WoWReforgedAttributes, WoWReforgedRespawn

globals
    private terraindeformation array playerTerrainDeformations
    private integer array playerTerrainDeformationsCounters
    
    constant integer MAX_BONUSES = 28
endglobals

function GetBonusName takes integer b returns string
    if (b == BONUS_DAMAGE) then
        return "Damage"
    elseif (b == BONUS_ARMOR) then
        return "Armor"
    elseif (b == BONUS_AGILITY) then
        return "Agility"
    elseif (b == BONUS_STRENGTH) then
        return "Strength"
    elseif (b == BONUS_INTELLIGENCE) then
        return "Intelligence"
    elseif (b == BONUS_HEALTH) then
        return "Health"
    elseif (b == BONUS_MANA) then
        return "Mana"
    elseif (b == BONUS_MOVEMENT_SPEED) then
        return "Movement Speed"
    elseif (b == BONUS_SIGHT_RANGE) then
        return "Sight Range"
    elseif (b == BONUS_HEALTH_REGEN) then
        return "Health Regeneration"
    elseif (b == BONUS_MANA_REGEN) then
        return "Mana Regeneration"
    elseif (b == BONUS_ATTACK_SPEED) then
        return "Attack Speed"
    elseif (b == BONUS_MAGIC_RESISTANCE) then
        return "Magic Resistance"
    elseif (b == BONUS_EVASION_CHANCE) then
        return "Evasion Chance"
    elseif (b == BONUS_CRITICAL_DAMAGE) then
        return "Critical Damage"
    elseif (b == BONUS_CRITICAL_CHANCE) then
        return "Critical Chance"
    elseif (b == BONUS_LIFE_STEAL) then
        return "Life Steal"
    elseif (b == BONUS_MISS_CHANCE) then
        return "Miss Chance"
    elseif (b == BONUS_SPELL_POWER_FLAT) then
        return "Spell Power Flat"
    elseif (b == BONUS_SPELL_POWER_PERCENT) then
        return "Spell Power Percent"
    elseif (b == BONUS_SPELL_VAMP) then
        return "Spell Power Vamp"
    elseif (b == BONUS_COOLDOWN_REDUCTION) then
        return "Cooldown Reduction"
    elseif (b == BONUS_COOLDOWN_REDUCTION_FLAT) then
        return "Cooldown Reduction Flat"
    elseif (b == BONUS_COOLDOWN_OFFSET) then
        return "Cooldown Offset"
    elseif (b == BONUS_TENACITY) then
        return "Tenacity"
    elseif (b == BONUS_TENACITY_FLAT) then
        return "Tenacity Flat"
    elseif (b == BONUS_TENACITY_OFFSET) then
        return "Tenacity Offset"
    endif
    return "Unknown"
endfunction

function RemoveAllPlayerTerrainDeformations takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer i = 0
    local integer max = playerTerrainDeformationsCounters[playerId]
    loop
        exitwhen (i >= max)
        call TerrainDeformStop(playerTerrainDeformations[Index2D(i, playerId, bj_MAX_PLAYERS)], 1)
        set i = i + 1
    endloop
    set playerTerrainDeformationsCounters[playerId] = 0
endfunction

function AddPlayerTerrainDeformation takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)
    local integer counter = playerTerrainDeformationsCounters[playerId]
    set playerTerrainDeformations[Index2D(counter, playerId, bj_MAX_PLAYERS)] = GetLastCreatedTerrainDeformation()
    set playerTerrainDeformationsCounters[playerId] = counter + 1
endfunction

private function ExamineAbility takes ability a returns string
    local integer abilityId = BlzGetAbilityId(a)
    local integer level = 1
    local integer manaCost = BlzGetAbilityManaCost(abilityId, level)
    local real cooldown = BlzGetAbilityCooldown(abilityId, level)
    local string msg = GetObjectName(abilityId)
    local integer max = 0
    local integer i = 0
    if (manaCost > 0) then
        set msg = msg + " Mana Cost: " + I2S(manaCost)
    endif
    if (cooldown > 0) then
        set msg = msg + " Cooldown: " + I2S(R2I(cooldown))
    endif
    set i = 0
    set max = GetMaxAbilityFields(abilityId)
    if (max > 0) then
        loop
            exitwhen (i >= max)
            if (i > 0) then
                set msg = msg + ", "
            endif
            set msg = msg + A2S(GetAbilityFieldId(abilityId, i)) + "(" + GetAbilityFieldTypeName(GetAbilityFieldType(abilityId, i)) + ")"
            set i = i + 1
        endloop
    endif
    return msg
endfunction

function ExamineUnit takes unit caster, unit whichUnit returns nothing
    local integer id = GetUnitTypeId(whichUnit)
    local string msg = GetUnitName(whichUnit) + " level " + I2S(GetUnitLevel(whichUnit))
    local integer whichRace = GetObjectRace(id)
    local integer whichProfession = GetObjectProfession(id)
    local integer saveCodeIndex = GetSaveObjectUnitType(id)
    local integer i = 0
    local integer max = 0
    local integer countClassifications = 0
    local integer heroIndex = 0
    
    set msg = msg + "\nSkin: " + GetObjectName(BlzGetUnitSkin(whichUnit))
    set msg = msg + "\nOwner: " + GetPlayerNameColored(GetOwningPlayer(whichUnit))
    
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        set heroIndex = GetHeroIndexByUnitTypeId(id)
        if (heroIndex != -1) then
            set whichRace = GetHeroRace(heroIndex)
        endif
    endif
    
    if (whichRace == udg_RaceNone) then
        set msg = msg + "\nNo race." 
    else
        set msg = msg + "\nRace: " + GetRaceName(whichRace)
    endif
    
    if (whichProfession == udg_ProfessionNone) then
        set msg = msg + "\nNo profession." 
    else
        set msg = msg + "\nProfession: " + GetProfessionName(whichProfession)
    endif
    
    if (saveCodeIndex == -1) then
        set saveCodeIndex = GetSaveObjectBuildingType(id)
    endif
    
    if (saveCodeIndex == -1) then
        set msg = msg + "\nNot savable." 
    else
        set msg = msg + "\nSave code index: "  + I2S(saveCodeIndex)
    endif
    
    set msg = msg + "\n" + I2S(GetUnitGoldCostSafe(id)) + " gold, " + I2S(GetUnitWoodCostSafe(id)) + " lumber, " + I2S(GetUnitFoodUsed(whichUnit))  + " food used, " + I2S(GetUnitFoodMade(whichUnit))  + " food made"
    
    /*
    TODO Get all spells from SkillMenu.
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        set msg = msg + "\nHero spells: "
        set i = 1
        set max = GetHeroAbilityMaximum(id)
        loop
            exitwhen (i >= max)
            if (i > 1) then
                set msg = msg + ", "
            endif
            set msg = msg + GetObjectName(GetHeroAbilityId(id, i))
            set i = i + 1
        endloop
        if (max == 0) then
            set msg = msg + "-"
        endif
    endif
    */
    
    set msg = msg + "\nClassifications: "
    
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
        set msg = msg + "hero"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_ANCIENT)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "ancient"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "structure"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "mechanical"
        set countClassifications =  countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_ETHEREAL)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "ethereal"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_FLYING)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "flying"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_GROUND)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "ground"
        set countClassifications = countClassifications + 1
    endif
    
     if (IsUnitType(whichUnit, UNIT_TYPE_MAGIC_IMMUNE)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "magic immune"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_PEON)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "peon"
        set countClassifications = countClassifications + 1
    endif
    
    if (IsUnitType(whichUnit, UNIT_TYPE_PLAGUED)) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + "plagued"
        set countClassifications = countClassifications + 1
    endif
    
    if (countClassifications == 0) then
        set msg = msg + "-"
    endif
    
    set msg = msg + "\nAbilities: "
    
    set i = 0
    loop
        exitwhen (i >= MAX_UNIT_ABILITIES)
        if (BlzGetUnitAbilityByIndex(whichUnit, i) != null) then
            if (i > 0) then
                set msg = msg + ", "
            endif
            set msg = msg + ExamineAbility(BlzGetUnitAbilityByIndex(whichUnit, i))
        else
            exitwhen (true)
        endif
        set i = i + 1
    endloop

    // only the bonus types supported in this map
    set msg = msg + "\nBonuses: "
    set countClassifications = 0
    if (GetUnitBonus(whichUnit, BONUS_DAMAGE) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_DAMAGE) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_DAMAGE))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_ARMOR) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_ARMOR) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_ARMOR))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_HEALTH) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_HEALTH) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_HEALTH))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_MANA) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_MANA) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_MANA))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_AGILITY) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_AGILITY) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_AGILITY))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_STRENGTH) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_STRENGTH) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_STRENGTH))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_INTELLIGENCE) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_INTELLIGENCE) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_INTELLIGENCE))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_MOVEMENT_SPEED) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_MOVEMENT_SPEED) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_MOVEMENT_SPEED))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_SIGHT_RANGE) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_SIGHT_RANGE) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_SIGHT_RANGE))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_HEALTH_REGEN) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_HEALTH_REGEN) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_HEALTH_REGEN))
        set countClassifications = countClassifications + 1
    endif
    
    if (GetUnitBonus(whichUnit, BONUS_MANA_REGEN) > 0.0) then
        if (countClassifications > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetBonusName(BONUS_MANA_REGEN) + ": " + R2S(GetUnitBonus(whichUnit, BONUS_MANA_REGEN))
        set countClassifications = countClassifications + 1
    endif
    
    if (countClassifications == 0) then
        set msg = msg + "-"
    endif
    
    set msg = msg + "\nAttributes: "
    set countClassifications = 0
    
    if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
         set msg = msg + "Strength: " + I2S(GetHeroStr(whichUnit, false)) + " (+ " + I2S(GetHeroStrBonus(whichUnit)) + ")"
         set msg = msg + ", Agility: " + I2S(GetHeroAgi(whichUnit, false)) + " (+ " + I2S(GetHeroAgiBonus(whichUnit)) + ")"
         set msg = msg + ", Intelligence: " + I2S(GetHeroInt(whichUnit, false)) + " (+ " + I2S(GetHeroIntBonus(whichUnit)) + ")"
         set countClassifications = countClassifications + 3
    endif
    
    set i = 0
    loop
        exitwhen (i >= GetMaxAttributes())
        if (GetUnitAttribute(whichUnit, GetAttribute(i)) > 0.0) then
            if (i > 0) then
                set msg = msg + ", "
            endif
            set msg = msg + GetAttributeName(GetAttribute(i)) + ": " + R2S(GetUnitAttribute(whichUnit, GetAttribute(i)))
            set countClassifications = countClassifications + 1
        endif
        set i = i + 1
    endloop
    
    if (countClassifications == 0) then
        set msg = msg + "-"
    endif
    
    call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, bj_TEXT_DELAY_HINT, msg)
endfunction

function ExamineItem takes unit caster, item whichItem returns nothing
    local integer id = GetItemTypeId(whichItem)
    local string msg = GetItemName(whichItem) + " level " + I2S(GetItemLevel(whichItem))
    local integer whichRace = GetObjectRace(id)
    local integer whichProfession = GetObjectProfession(id)
    local integer saveCodeIndex = GetSaveObjectItemType(id)
    local integer i = 0
    
    set msg = msg + "\nSkin: " + GetObjectName(BlzGetItemSkin(whichItem))

    if (GetItemPlayer(whichItem) == null) then
        set msg = msg + "\nNo owner." 
    else
        set msg = msg + "\nOwner: " + GetPlayerNameColored(GetItemPlayer(whichItem))
    endif
    
    if (whichRace == udg_RaceNone) then
        set msg = msg + "\nNo race." 
    else
        set msg = msg + "\nRace: " + GetRaceName(whichRace)
    endif
    
    if (whichProfession == udg_ProfessionNone) then
        set msg = msg + "\nNo profession." 
    else
        set msg = msg + "\nProfession: " + GetProfessionName(whichProfession)
    endif
    
    if (saveCodeIndex == -1) then
        set msg = msg + "\nNot savable." 
    else
        set msg = msg + "\nSave code index: "  + I2S(saveCodeIndex)
    endif
    
    set msg = msg + "\n" + I2S(GetItemValueGold(id)) + " gold, " + I2S(GetItemValueLumber(id)) + " lumber"
    
    set msg = msg + "\nType: "
    
    if (GetItemType(whichItem) == ITEM_TYPE_PERMANENT) then
        set msg = msg + "permanent"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_CHARGED) then
        set msg = msg + "charged"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_POWERUP) then
        set msg = msg + "powerup"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_ARTIFACT) then
        set msg = msg + "artifact"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_PURCHASABLE) then
        set msg = msg + "purchasable"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_CAMPAIGN) then
        set msg = msg + "campaign"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_MISCELLANEOUS) then
        set msg = msg + "misc"
    endif
    
    if (GetItemType(whichItem) == ITEM_TYPE_ANY) then
        set msg = msg + "any"
    endif
    
    if (IsItemInvulnerable(whichItem)) then
        set msg = msg + ", invulnerable"
    endif
    
    if (IsItemSellable(whichItem)) then
        set msg = msg + ", sellable"
    endif
    
    if (IsItemPawnable(whichItem)) then
        set msg = msg + ", pawnable"
    endif
    
    set msg = msg + "\n " + I2S(GetItemCharges(whichItem)) + " charges"
    
    set msg = msg + "\nAbilities: "
    
    set i = 0
    loop
        exitwhen (i >= MAX_ITEM_ABILITIES)
        if (BlzGetItemAbilityByIndex(whichItem, i) != null) then
            if (i > 0) then
                set msg = msg + ", "
            endif
            set msg = msg + ExamineAbility(BlzGetItemAbilityByIndex(whichItem, i))
        else
            exitwhen (true)
        endif
        set i = i + 1
    endloop
    
    call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, bj_TEXT_DELAY_HINT, msg)
endfunction

function ExamineDestructable takes unit caster, destructable whichDestructable returns nothing
    local string msg = GetDestructableName(whichDestructable)
    
    set msg = msg + "\nHit Points: " + I2S(R2I(GetDestructableLife(whichDestructable))) + "/" + I2S(R2I(GetDestructableMaxLife(whichDestructable)))

    if (IsDestructableInvulnerable(whichDestructable)) then
        set msg = msg + "\ninvulnerable"
    endif
    
    if (IsDestructableTree(whichDestructable)) then
        set msg = msg + "\nTree"
    endif
    
    set msg = msg + "\nOccluder height: " + R2S(GetDestructableOccluderHeight(whichDestructable))

    call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, bj_TEXT_DELAY_HINT, msg)
endfunction

function ExamineGround takes unit caster, real x, real y returns nothing
    local location l = Location(x, y)
    local real z = GetLocationZ(l)
    local integer t = GetTerrainType(x, y)
    local integer v = GetTerrainVariance(x, y)
    local string tileName = GetTileName(t)
    local integer cliffLevel = GetTerrainCliffLevel(x, y)
    local string pathing = ""
    local string msg = ""
    
    if (not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)) then
        if (StringLength(pathing) > 0) then
            set pathing = pathing + ","
        endif
        set pathing = pathing + "walkable"
    endif
    
    if (not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)) then
        if (StringLength(pathing) > 0) then
            set pathing = pathing + ","
        endif
        set pathing = pathing + "floatable"
    endif
    
    if (not IsTerrainPathable(x, y, PATHING_TYPE_FLYABILITY)) then
        if (StringLength(pathing) > 0) then
            set pathing = pathing + ","
        endif
        set pathing = pathing + "flyable"
    endif
    
    if (IsPointBlighted(x, y)) then
        if (StringLength(pathing) > 0) then
            set pathing = pathing + ","
        endif
        set pathing = pathing + "blight"
    endif
    
    set msg = tileName + " (variant " + I2S(v) + ")\nCliff level: " + I2S(cliffLevel) + "\nHeight: " + R2S(z) + "\n" + pathing
    
    if (RespawnCoordinatesContainNoBuilding(x, y)) then
        set msg = msg + ", creeps will respawn here."
    else
        set msg = msg + ", creeps won't respawn here because of buildings nearby."
    endif
    
    call RemoveLocation(l)
    set l = null

    call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0.0, 0.0, bj_TEXT_DELAY_HINT, msg)
endfunction

endlibrary
