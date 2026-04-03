library WoWReforgedWebsite initializer Init requires Ascii, OpLimit, UnitDex, Indexer, SafeString, Resources, DamageCalculationTableUI, GenerateIds, UnitTypeUtils, ItemUtils, FileUtils, StringUtils, UnitCost, TimeOfDayUtils, QuestUtils, SaveCodeSystem, WoWReforgedBosses, WoWReforgedRaces, WoWReforgedPrestoredSaveCodes, WoWReforgedQuests, WoWReforgedInfoQuests, WoWReforgedProfessions, WoWReforgedMounts, WoWReforgedResearches, WoWReforgedSkins, WoWReforgedEquipment, WoWReforgedProperties, WoWReforgedRacing, WoWReforgedCalendar, WoWReforgedArena, WoWReforgedNpcs, WoWReforgedDependencyEquivalents, WoWReforgedObjectMappings, WoWReforgedHunter, WoWReforgedStartLocations, WoWReforgedVIPs, WoWReforgedAccount, WoWReforgedResources, WoWReforgedSkillMenu, WoWReforgedClasses, WoWReforgedComputerStartLocations, WoWReforgedHeroTransformation

/*
Generates data necessary for https://github.com/tdauth/wowr-website

GetUmkiCount GetUmki GetUsei GetUres GetUtra GetUtraCount
function GetUtra takes integer objectId, integer index returns integer
function GetUtraCount takes integer objectId returns integer
*/

globals
    private trigger chatCommandTrigger = CreateTrigger()

    private integer tmpInteger = 0
    private integer tmpInteger2 = 0
    private integer tmpInteger3 = 0
    private unit tmpUnit = null
    private string tmpString = ""
    private item tmpItem = null
endglobals

//! runtextmacro DEBUG_MODE_CHECK()

private function CreateTmpUnit takes integer unitTypeId returns unit
    local unit whichUnit = CreateUnit(Player(0), unitTypeId, 0.0, 0.0, 0.0)
        
    call SetUnitLifePercentBJ(whichUnit, 100.0)
    call SetUnitManaPercentBJ(whichUnit, 100.0)
    
    return whichUnit
endfunction

// Converts Warcraft III tooltips color codes into HTML.
private function FormatToken takes string token, boolean isInColorBlock returns boolean
    local string result = ""
    local integer i = 0
    local string subString = ""
    local boolean isInColor = false
    local integer colorCounter = 0
    local integer max = StringLength(token)
    loop
        exitwhen (i >= max)
        set subString = SubString(token, i, i + 1)
        if (subString == "<" or subString == ">") then
            set i = i + 1
        // prevents the string from getting too long for Warcraft III strings and to be cut off:
        // MAX_STRING_LENGTH 
        elseif (subString == " " and StringLength(result) >= 50) then
            call FileWriteLine(result + subString)
            set result = ""
            set i = i + 1
        elseif (StringStartsWith(SubString(token, i, i + 2), "|c")) then
            // Close never closed color codes.
            if (isInColorBlock) then
                set result = result + "</div>"
            endif
            set result = result + "<div style=\"color: #"
            // ARGB so we replace the alpha value to convert it into RGB.
            set i = i + 4
            set isInColor = true
            set isInColorBlock = true
            set colorCounter = 0
        elseif (StringStartsWith(SubString(token, i, i + 2), "|r")) then
            // Prevent closing never opened color codes.
            if (isInColorBlock) then
                set result = result + "</div>"
            endif
            set i = i + 2
            set isInColor = false
            set isInColorBlock = false
            set colorCounter = 0
        else
            set result = result + SubString(token, i, i + 1)
            set i = i + 1
            if (isInColor) then
                set colorCounter = colorCounter + 1
                if (colorCounter >= 6) then
                    set result = result + "\">"
                    set isInColor = false
                    set colorCounter = 0
                endif
            endif
        endif
    endloop
    
    if (StringLength(result) > 0) then
        call FileWriteLine(result)
        set result = ""
    endif
    
    return isInColorBlock
endfunction

private function FormatTooltip takes string tooltip returns nothing
    // there can be multiple line breaks without any content
    local integer max = 0
    local integer index = 0
    local boolean isInColorBlock = false
    if (StringLength(tooltip) > 0) then
        set max = StringCount(tooltip, "|n") + 1
        loop
            exitwhen (index >= max)
            
            if (index > 0) then
                call FileWriteLine("<br/>")
            endif
            
            set isInColorBlock = FormatToken(StringSplit(tooltip, index, "|n"), isInColorBlock)
            set index = index + 1
        endloop
        
        // close an unclosed color code to prevent invalid HTML
        if (isInColorBlock) then
            call FileWriteLine("</div>")
        endif
    endif
endfunction

private function R2SHtml takes real r returns string
    return R2SW(r, 1, 2)
endfunction

private function IconPath takes string iconPath returns string
    set iconPath = StringReplace(iconPath, "\\\\", "/")
    set iconPath = StringReplace(iconPath, "\\", "/")
    set iconPath = StringReplace(iconPath, "#", "%23")
    return iconPath
endfunction

private function Icon takes string name, string iconPath returns nothing
    local string path = IconPath(iconPath)
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + path + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + name + "\"")
    call FileWriteLine("alt=\"" + path + "\"")
    call FileWriteLine("/>")
endfunction

private function GetIconPath takes integer objectTypeId returns string
    local string iconPath = BlzGetAbilityIcon(objectTypeId)
    if (iconPath != null and StringLength(iconPath) > 0) then
        return IconPath(iconPath)
    endif
    return ""
endfunction

private function IconButton takes integer objectTypeId returns nothing
    local string path = GetIconPath(objectTypeId)
    local string name = GetObjectName(objectTypeId)
    call FileWriteLine("<button>")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + path + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("alt=\"" + path + "\"")
    call FileWriteLine("/>")
    call FileWriteLine("</button>")
endfunction

private function IconToHtmlEx4 takes string path, string file, string name, string id returns nothing
    local string href = file + "#" + id
    call FileWriteLine("<a href=\"" + href + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + path + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + name + "\"")
    call FileWriteLine("alt=\"" + path + "\"")
    call FileWriteLine("/></a>")
endfunction

private function IconToHtmlEx3 takes string path, string file, string name returns nothing
    local string href = file + "#" + name
    call FileWriteLine("<a href=\"" + href + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + path + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + name + "\"")
    call FileWriteLine("alt=\"" + path + "\"")
    call FileWriteLine("/></a>")
endfunction

private function IconToHtmlEx2 takes integer objectTypeId, string file, string name returns nothing
    local string path = GetIconPath(objectTypeId)
    local string href = file + "#" + A2S(objectTypeId)
    call FileWriteLine("<a href=\"" + href + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + path + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + name + "\"")
    call FileWriteLine("alt=\"" + path + "\"")
    call FileWriteLine("/></a>")
endfunction

private function IconToHtmlEx takes integer objectTypeId, string file returns nothing
    call IconToHtmlEx2(objectTypeId, file, GetObjectName(objectTypeId))
endfunction

private function IconToHtml takes integer objectTypeId returns nothing
    call IconToHtmlEx(objectTypeId, "")
endfunction

private function ColumnDataOrder takes string order, string search returns string
    local string txt = "<td"
    if (order != null and StringLength(order) > 0) then
        set txt = txt + " data-order=\"" + order + "\""
    endif
    if (search != null and StringLength(search) > 0) then
        set txt = txt + " data-search=\"" + search + "\""
    endif
    set txt = txt + ">"
    
    return txt
endfunction

private function GenerateGoldIcon takes nothing returns nothing
    call FileWriteLine("<img src=\"UI/Widgets/Console/Human/Infocard-gold.blp\" alt=\"UI/Widgets/Console/Human/Infocard-gold.blp\" />")
endfunction

private function GenerateLumberIcon takes nothing returns nothing
    call FileWriteLine("<img src=\"UI/Widgets/Console/Human/Infocard-lumber.blp\" alt=\"UI/Widgets/Console/Human/Infocard-lumber.blp\" />")
endfunction

private function GenerateFoodIcon takes nothing returns nothing
    call FileWriteLine("<img src=\"UI/Widgets/Console/Human/Infocard-supply.blp\" alt=\"UI/Widgets/Console/Human/Infocard-supply.blp\" />")
endfunction

private function GenerateUnitTypeIdGoldCostPopover takes integer unitTypeId returns nothing
    local integer goldCost = GetUnitGoldCostSafe(unitTypeId) 
    if (goldCost > 0) then
        call FileWriteLine(I2S(goldCost))
        call GenerateGoldIcon()
    endif
endfunction

private function GenerateUnitTypeIdGoldCost takes integer unitTypeId returns nothing
    local integer goldCost = GetUnitGoldCostSafe(unitTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(goldCost), I2S(goldCost)))
    if (goldCost > 0) then
        call FileWriteLine(I2S(goldCost))
        call GenerateGoldIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function GenerateUnitTypeIdLumberCostPopover takes integer unitTypeId returns nothing
    local integer lumberCost = GetUnitWoodCostSafe(unitTypeId)
    if (lumberCost > 0) then
        call FileWriteLine(I2S(lumberCost))
        call GenerateLumberIcon()
    endif
endfunction

private function GenerateUnitTypeIdLumberCost takes integer unitTypeId returns nothing
    local integer lumberCost = GetUnitWoodCostSafe(unitTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(lumberCost), I2S(lumberCost)))
    if (lumberCost > 0) then
        call FileWriteLine(I2S(lumberCost))
        call GenerateLumberIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function GenerateUnitTypeIdFoodCostPopover takes integer unitTypeId returns nothing
    local integer foodCost = GetFoodUsed(unitTypeId)
    if (foodCost > 0) then
        call FileWriteLine(I2S(foodCost))
        call GenerateFoodIcon()
    endif
endfunction

private function GenerateUnitTypeIdFoodCost takes integer unitTypeId returns nothing
    local integer foodCost = GetFoodUsed(unitTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(foodCost), I2S(foodCost)))
    if (foodCost > 0) then
        call FileWriteLine(I2S(foodCost))
        call GenerateFoodIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function GenerateUnitTypeIdFoodMadePopover takes integer unitTypeId returns nothing
    local integer foodMade = GetFoodMade(unitTypeId)
    if (foodMade > 0) then
        call FileWriteLine(I2S(foodMade))
        call GenerateFoodIcon()
    endif
endfunction

private function GenerateUnitTypeIdFoodMade takes integer unitTypeId returns nothing
    local integer foodMade = GetFoodMade(unitTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(foodMade), I2S(foodMade)))
    if (foodMade > 0) then
        call FileWriteLine(I2S(foodMade))
        call GenerateFoodIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function GenerateItemTypeIdGoldCost takes integer itemTypeId returns nothing
    local integer goldCost = GetItemGoldCost(itemTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(goldCost), I2S(goldCost)))
    if (goldCost > 0) then
        call FileWriteLine(I2S(goldCost))
        call GenerateGoldIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function GenerateItemTypeIdLumberCost takes integer itemTypeId returns nothing
    local integer lumberCost = GetItemWoodCost(itemTypeId)
    call FileWriteLine(ColumnDataOrder(I2S(lumberCost), I2S(lumberCost)))
    if (lumberCost > 0) then
        call FileWriteLine(I2S(lumberCost))
        call GenerateLumberIcon()
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function RaceIconToHtml takes integer whichRace returns nothing
    if (whichRace == udg_RaceNone) then
        call FileWriteLine("-")
    else
        call IconToHtmlEx(udg_RaceTavernItemType[whichRace], "races.html")
    endif
endfunction

private function GetQuestByReward takes integer objectId returns integer
    local integer i = 0
    local integer max = GetQuestsMax()
    loop
        exitwhen (i == max)
        if (objectId == GetQuestReward(i)) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function RaceOrProfessionOrQuestIconToHtml takes integer objectId, integer whichRace returns nothing
    local integer profession = GetObjectProfession(objectId)
    local integer whichQuest = GetQuestByReward(objectId)
    local integer legendaryItem = GetLegendaryItemByItemTypeId(objectId)
    local integer recipe = GetRecipeByItemTypeId(objectId)
    local boolean isArenaReward = IsArenaReward(objectId)
    local boolean isArenaOpponent = IsArenaOpponent(objectId)
    local boolean matches = false
    if (whichRace != udg_RaceNone) then
        call RaceIconToHtml(whichRace)
        set matches = true
    endif
    if (profession != udg_ProfessionNone) then
        call IconToHtmlEx(GetProfessionItemTypeId(profession), "professions.html")
        set matches = true
    endif
    if (whichQuest != -1) then
        call IconToHtmlEx4(GetQuestIcon(whichQuest), "quests.html", GetQuestId(whichQuest), GetQuestId(whichQuest))
        set matches = true
    endif
    if (legendaryItem != -1) then
        call IconToHtmlEx2(GetUnitTypeId(GetLegendaryItemBoss(legendaryItem)), "bosses.html", GetActualObjectName(GetUnitTypeId(GetLegendaryItemBoss(legendaryItem))))
        set matches = true
    endif
    if (recipe != -1) then
        call IconToHtmlEx(GetRecipeUIItemTypeId(recipe), "recipes.html")
        set matches = true
    endif
    if (isArenaReward) then
        call Icon("Arena Reward", "ReplaceableTextures\\CommandButtons\\BTNArmoredOge.blp")
        set matches = true
    endif
    if (isArenaOpponent) then
        call Icon("Arena Opponent", "ReplaceableTextures\\CommandButtons\\BTNArmoredOge.blp")
        set matches = true
    endif
    if (not matches) then
        call FileWriteLine("-")
    endif
endfunction

private function GetPrimaryAttribute takes unit hero returns string
    local integer v = BlzGetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE)
    return "<img class=\"wowr-icon primary-attribute\" src=\"" + GetHeroAttributeInfocardIcon(v) + "\" title=\"" + GetHeroAttributeName(v) + "\" alt=\"" + GetHeroAttributeName(v) + " \" />"
endfunction

private function WriteHeroPrimaryAttributeColumn takes unit hero returns nothing
    local integer a = GetHeroPrimaryStat(hero)
    call FileWriteLine(ColumnDataOrder(I2S(a), GetHeroAttributeName(a)))
    call FileWriteLine("<a href=\"attributes.html\">")
    call FileWriteLine(GetPrimaryAttribute(hero))
    call FileWriteLine("</a>")
    call FileWriteLine("</td>")
endfunction

private function GetUnitBountyBase takes unit creep returns integer
    return BlzGetUnitIntegerField(creep, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE)
endfunction

private function GenerateUnitBountyGold takes unit creep returns nothing
    local integer bountyBase = GetUnitBountyBase(creep)
    local integer bountyNumberOfDice = BlzGetUnitIntegerField(creep, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local integer bountySidesPerDice = BlzGetUnitIntegerField(creep, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE)
    local integer bountyMax = bountyBase + bountyNumberOfDice * bountySidesPerDice
    
    if (bountyBase > 0) then
        call FileWriteLine(I2S(bountyBase) + " - " + I2S(bountyMax))
        call GenerateGoldIcon()
    else
        call FileWriteLine("-")
    endif
endfunction

private function GetUnitDamage takes unit creep returns string
    local integer damageBase = BlzGetUnitWeaponIntegerField(creep, UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE, 0)
    local integer damageNumberOfDice = BlzGetUnitWeaponIntegerField(creep, UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE, 0)
    local integer damageSidesPerDice = BlzGetUnitWeaponIntegerField(creep, UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE, 0)
    local integer damageMax = damageBase + damageNumberOfDice * damageSidesPerDice
    
    if (damageBase > 0) then
        return I2S(damageBase) + " - " + I2S(damageMax)
    endif
    
    return "-"
endfunction

private function GetMoveType takes unit hero returns string
    local movetype v = ConvertMoveType(BlzGetUnitIntegerField(hero, UNIT_IF_MOVE_TYPE))
    if (v == MOVE_TYPE_FOOT) then
        return "Foot"
    elseif (v == MOVE_TYPE_HORSE) then
        return "On Horse"
    elseif (v == MOVE_TYPE_FLY) then
        return "Fly"
    elseif (v == MOVE_TYPE_HOVER) then
        return "Hover"
    elseif (v == MOVE_TYPE_FLOAT) then
        return "Float"
    elseif (v == MOVE_TYPE_AMPHIBIOUS) then
        return "Amphibious"
    endif
    
    return "None"
endfunction

private function GetArmorTypeForUnit takes unit hero returns string
    return GetDefenseTypeName(BlzGetUnitIntegerField(hero, UNIT_IF_DEFENSE_TYPE))
endfunction

private function GetArmorTypeIconForUnit takes unit hero returns string
    return GetDefenseTypeIcon(BlzGetUnitIntegerField(hero, UNIT_IF_DEFENSE_TYPE))
endfunction

private function GenerateArmorCell takes unit hero returns nothing
    call FileWriteLine("<a href=\"damagecalculationtable.html\">")
    call FileWriteLine("<img")
    call FileWriteLine("class=\"wowr-icon\"")
    call FileWriteLine("src=\"" + GetArmorTypeIconForUnit(hero) + "\"")
    call FileWriteLine("title=\"" + GetArmorTypeForUnit(hero) + "\"")
    call FileWriteLine("/>")
    call FileWriteLine("</a>")
endfunction

private function GetAttackTypeForName takes unit hero returns string
    return GetAttackTypeName(BlzGetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0))
endfunction

private function GetAttackTypeIconForUnit takes unit hero returns string
    return GetAttackTypeIcon(BlzGetUnitWeaponIntegerField(hero, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0))
endfunction

private function GenerateAttackTypeCell takes unit hero returns nothing
    call FileWriteLine("<a href=\"damagecalculationtable.html\">")
    call FileWriteLine("<img")
    call FileWriteLine("class=\"wowr-icon\"")
    call FileWriteLine("src=\"" + GetAttackTypeIconForUnit(hero) + "\"")
    call FileWriteLine("title=\"" + GetAttackTypeForName(hero) + "\"")
    call FileWriteLine("/>")
    call FileWriteLine("</a>")
endfunction

globals
    private integer array ignoredAbilities
    private integer ignoredAbilitiesCounter = 0
endglobals

private function AddIgnoredAbility takes integer abilityId returns nothing
    set ignoredAbilities[ignoredAbilitiesCounter] = abilityId
    set ignoredAbilitiesCounter = ignoredAbilitiesCounter + 1
endfunction

private function IsValidAbility takes integer abilityId returns boolean
    local integer i = 0
    loop
        exitwhen (i == ignoredAbilitiesCounter)
        if (ignoredAbilities[i] == abilityId) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

private function GenerateUnitAttack takes unit whichUnit returns nothing
    local integer attackType = BlzGetUnitWeaponIntegerField(whichUnit, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0)
    local boolean attack0Enabled = BlzGetUnitWeaponBooleanField(whichUnit, UNIT_WEAPON_BF_ATTACKS_ENABLED, 0)

    // attack type
    if (attack0Enabled) then
        call FileWriteLine(ColumnDataOrder(I2S(attackType), GetAttackTypeForName(whichUnit)))
        call GenerateAttackTypeCell(whichUnit)
    else
        call FileWriteLine("<td>")
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // attack speed
    call FileWriteLine("<td>")
    if (attack0Enabled) then
        call FileWriteLine(R2SHtml(BlzGetUnitWeaponRealField(whichUnit, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0)))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
    
    // attack range
    call FileWriteLine("<td>")
    if (attack0Enabled) then
        call FileWriteLine(I2S(R2I(BlzGetUnitWeaponRealField(whichUnit, UNIT_WEAPON_RF_ATTACK_RANGE, 0))))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
    
    // attack damage
    call FileWriteLine("<td>")
    if (attack0Enabled) then
        call FileWriteLine(GetUnitDamage(whichUnit))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
endfunction

private function WriteBuildingPopoverWithIcon takes integer unitTypeId returns nothing
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(unitTypeId, "buildings.html")
    // name
    call FileWriteLine(GetObjectName(unitTypeId))
    call FileWriteLine("<br/>")
    // gold cost
    call GenerateUnitTypeIdGoldCostPopover(unitTypeId)
    // wood cost
    call GenerateUnitTypeIdLumberCostPopover(unitTypeId)
    
    // tooltip
    call FileWriteLine("<br/>")
    call FormatTooltip(BlzGetAbilityExtendedTooltip(unitTypeId, 0))
    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(unitTypeId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteUnitPopoverWithIconExExEx takes unit whichUnit, integer iconUnitTypeId, string file returns nothing
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(iconUnitTypeId, file)
    // name
    call FileWriteLine(GetActualObjectName(unitTypeId))
    call FileWriteLine("<br/>")
    
    // gold cost
    call GenerateUnitTypeIdGoldCostPopover(unitTypeId)

    // wood cost
    call GenerateUnitTypeIdLumberCostPopover(unitTypeId)
    
    // food cost
    call GenerateUnitTypeIdFoodCostPopover(unitTypeId)
    
    // tooltip
    call FileWriteLine("<br/>")
    call FormatTooltip(BlzGetAbilityExtendedTooltip(unitTypeId, 0))
    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(iconUnitTypeId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteUnitPopoverWithIconExEx takes unit whichUnit, string file returns nothing
    call WriteUnitPopoverWithIconExExEx(whichUnit, GetUnitTypeId(whichUnit), file)
endfunction

private function WriteUnitPopoverWithIconExNewOpLimit takes nothing returns nothing
    call WriteUnitPopoverWithIconExEx(tmpUnit, tmpString)
endfunction

private function WriteUnitPopoverWithIconEx takes unit whichUnit, string file returns nothing
    if (whichUnit != null) then
        set tmpUnit = whichUnit
        set tmpString = file
        call NewOpLimit(function WriteUnitPopoverWithIconExNewOpLimit)
    else
        call BJDebugMsg("Warning: Unit is null.")
    endif
endfunction

private function WriteUnitPopoverWithIcon takes integer unitTypeId, string file returns nothing
    local unit whichUnit = null
    
    if (unitTypeId != 0) then
        set whichUnit = CreateTmpUnit(unitTypeId)
        call WriteUnitPopoverWithIconEx(whichUnit, file)
        call RemoveUnit(whichUnit)
        set whichUnit = null
    else
        call BJDebugMsg("Warning: unit type ID is 0.")
    endif
endfunction

private function WriteItemPopoverWithIconEx takes integer itemTypeId, string file returns nothing
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(itemTypeId, file)
    // name
    call FileWriteLine(GetObjectName(itemTypeId))
    call FileWriteLine("<br/>")
    
    // gold cost
    if (GetItemGoldCost(itemTypeId) > 0) then
        call FileWriteLine(I2S(GetItemGoldCost(itemTypeId)))
        call GenerateGoldIcon()
    endif
    
    // lumber cost
    if (GetItemWoodCost(itemTypeId) > 0) then
        call FileWriteLine(I2S(GetItemWoodCost(itemTypeId)))
        call GenerateLumberIcon()
    endif
    
    // tooltip
    call FileWriteLine("<br/>")
    call FormatTooltip(BlzGetAbilityExtendedTooltip(itemTypeId, 0))
    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(itemTypeId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteItemPopoverWithIconExNewOpLimit takes nothing returns nothing
    call WriteItemPopoverWithIconEx(tmpInteger, tmpString)
endfunction

private function WriteItemPopoverWithIcon takes integer itemTypeId, string file returns nothing
    if (itemTypeId != 0) then
        set tmpInteger = itemTypeId
        set tmpString = file
        call NewOpLimit(function WriteItemPopoverWithIconExNewOpLimit)
    else
        call BJDebugMsg("Warning: itemTypeId is 0.")
    endif
endfunction

private function WriteAbilityPopoverWithIcon takes integer abilityId, string file returns nothing
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
    
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(abilityId, file)
    // name
    call FileWriteLine(GetObjectName(abilityId))
    call FileWriteLine("<br/>")
    
    // tooltip
    call FileWriteLine("<br/>")
    if (HasAbilitySkillExtendedTooltip(abilityId, 0)) then
        call FormatTooltip(FormatAbilityTooltip(null, abilityId, 1, GetLocalizedStringSafe(GetAbilitySkillExtendedTooltip(abilityId, 0))))
    else
        call FormatTooltip(BlzGetAbilityExtendedTooltip(abilityId, 0))
    endif

    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(abilityId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteResearchPopoverWithIcon takes integer researchId returns nothing
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(researchId, "researches.html")
    
    // name
    call FileWriteLine(GetObjectName(researchId))
    call FileWriteLine("<br/>")
    
    // research levels
    call FileWriteLine("Levels: ")
    call FileWriteLine(I2S(GetPlayerTechMaxAllowed(Player(0), researchId)))
    
    // tooltip
    call FileWriteLine("<br/>")
    call FormatTooltip(BlzGetAbilityExtendedTooltip(researchId, 0))
    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(researchId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteRacePopoverWithIconExEx takes item whichItem, string file returns nothing
    local integer itemTypeId = GetItemTypeId(whichItem)
    
    call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
    // popover
    call FileWriteLine("<div class=\"wowr-popover\">")
    call IconToHtmlEx(itemTypeId, file)
    // name
    call FileWriteLine(GetItemName(whichItem))
    call FileWriteLine("<br/>")
    
    // tooltip
    call FileWriteLine("<br/>")
    call FormatTooltip(BlzGetItemExtendedTooltip(whichItem))
    call FileWriteLine("</div>")
    // popover end
    
    // icon
    call IconButton(itemTypeId)
    
    call FileWriteLine("</div>")
endfunction

private function WriteRacePopoverWithIconExNewOpLimit takes nothing returns nothing
    call WriteRacePopoverWithIconExEx(tmpItem, tmpString)
endfunction

private function WriteRacePopoverWithIconEx takes item whichItem, string file returns nothing
    if (whichItem != null) then
        set tmpItem = whichItem
        set tmpString = file
        call NewOpLimit(function WriteRacePopoverWithIconExNewOpLimit)
    else
        call BJDebugMsg("Warning: Item is null.")
    endif
endfunction

private function GenerateHeroClass takes integer unitTypeId returns nothing
    local integer c = GetHeroClass(unitTypeId)
    if (c != CLASS_NONE) then
        call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
        // popover
        call FileWriteLine("<div class=\"wowr-popover\">")
        call IconToHtmlEx(GetHeroClassItemTypeId(c), "classes.html")
        // name
        call FileWriteLine(GetHeroClassName(c))
        call FileWriteLine("<br/>")
        
        // tooltip
        call FileWriteLine("<br/>")
        call FormatTooltip(GetHeroClassDescription(c))
        call FileWriteLine("</div>")
        // popover end
        
        // icon
        call IconButton(GetHeroClassItemTypeId(c))
        
        call FileWriteLine("</div>")
    else
        call FileWriteLine("-")
    endif
endfunction


private function GenerateDamageCalculationTable takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    
    call FileStart()

    call FileWriteLine("<!-- Damage Calculation Table generated with chat command \"-website\". -->")
    call FileWriteLine("<tr>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("</td>")
    call FileWriteLine("<td>")
    call FileWriteLine("</td>")
    
    set i = 0
    loop
        exitwhen (i >= MAX_DEFENSE_TYPES)
        call FileWriteLine("<td>")
        call FileWriteLine(GetDefenseTypeName(i))
        call FileWriteLine("</td>")
        set i = i + 1
    endloop
    
    call FileWriteLine("</tr>")
    
    call FileWriteLine("<tr>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("</td>")
    call FileWriteLine("<td>")
    call FileWriteLine("</td>")
    
    set i = 0
    loop
        exitwhen (i >= MAX_DEFENSE_TYPES)
        call FileWriteLine("<td>")
        
        call FileWriteLine("<img")
        call FileWriteLine("class=\"wowr-icon\"")
        call FileWriteLine("src=\"" + GetDefenseTypeIcon(i) + "\"")
        call FileWriteLine("title=\"" + GetDefenseTypeName(i) + "\"")
        call FileWriteLine("/>")
            
        call FileWriteLine("</td>")
        set i = i + 1
    endloop
    
    call FileWriteLine("</tr>")
    
    set i = 0
    loop
        exitwhen (i >= MAX_ATTACK_TYPES)
        call FileWriteLine("<tr>")
        
        call FileWriteLine("<td>")
        call FileWriteLine(GetAttackTypeName(i))
        call FileWriteLine("</td>")
        
        call FileWriteLine("<td>")
        call FileWriteLine("<img")
        call FileWriteLine("class=\"wowr-icon\"")
        call FileWriteLine("src=\"" + GetAttackTypeIcon(i) + "\"")
        call FileWriteLine("title=\"" + GetAttackTypeName(i) + "\"")
        call FileWriteLine("/>")
        call FileWriteLine("</td>")
        
        set j = 0
        loop
            exitwhen (j >= MAX_DEFENSE_TYPES)
            call FileWriteLine("<td>")
            call FileWriteLine("<div")
            call FileWriteLine("title=\"" + GetAttackTypeName(i)+ " - " + GetDefenseTypeName(j) + "\"")
            call FileWriteLine(">")
            call FileWriteLine(I2S(R2I(GetDamageCalculationTableValue(i, j) * 100.0)))
            call FileWriteLine(" %%</div>")
            call FileWriteLine("</td>")
            set j = j + 1
        endloop
        
        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Heroes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-DamageCalculationTable.txt")
endfunction

private function GenerateHeroEx takes integer heroTypeId, integer whichRace, integer index returns nothing
    local unit hero = CreateTmpUnit(heroTypeId)
    local integer j = 0
    local integer maxHeroSpells = 0
    local integer abilityId = 0
    local integer mount = 0
    local integer baseId = GetPrimaryDependencyEquivalent(heroTypeId)
    local boolean primary = IsPrimaryDependencyEquivalent(heroTypeId)
    
    call FileWriteLine("<tr id=\"" + A2S(heroTypeId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetActualObjectName(heroTypeId)))
    //call IconToHtml(heroTypeId)
    call WriteUnitPopoverWithIconEx(hero, "heroes.html")
    call FileWriteLine("</td>")
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetActualObjectName(heroTypeId))
    if (not primary) then
        call FileWriteLine(" <div title=\"Depndency equivalent.\">(d)</div>")
    endif
    call FileWriteLine("</td>")
    // race
    call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
    call RaceIconToHtml(whichRace)
    call FileWriteLine("</td>")
    // primary attribute
    call WriteHeroPrimaryAttributeColumn(hero)
    
    // mount
    call FileWriteLine("<td>")
    set mount = GetHeroMountUnitTypeId(GetHeroIndexByUnitTypeId(baseId))
    if (mount != 0) then
        call IconToHtmlEx(mount, "mounts.html")
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
    
    // hero class
    call FileWriteLine("<td>")
    call GenerateHeroClass(heroTypeId)
    call FileWriteLine("</td>")
    
    // start strength
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_STRENGTH)))
    call FileWriteLine("</td>")

    // start agility
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_AGILITY)))
    call FileWriteLine("</td>")

    // start intelligence
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_INTELLIGENCE)))
    call FileWriteLine("</td>")

    // strength per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_STRENGTH_PER_LEVEL)))
    call FileWriteLine("</td>")
    
    // agility per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_AGILITY_PER_LEVEL)))
    call FileWriteLine("</td>")

    // intelligence per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_INTELLIGENCE_PER_LEVEL)))
    call FileWriteLine("</td>")

    // move type
    call FileWriteLine("<td>")
    call FileWriteLine(GetMoveType(hero))
    call FileWriteLine("</td>")

    // move speed
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(GetUnitMoveSpeed(hero))))
    call FileWriteLine("</td>")

    call GenerateUnitAttack(hero)
    
    // armor type
    call FileWriteLine("<td>")
    call GenerateArmorCell(hero)
    call FileWriteLine("</td>")
    
    // armor
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitArmor(hero))))
    call FileWriteLine("</td>")
    
    // day sight range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(hero, UNIT_RF_SIGHT_RADIUS))))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    call RemoveUnit(hero)
    set hero = null
endfunction

private function GenerateHeroNewOpLimit takes nothing returns nothing
    call GenerateHeroEx(tmpInteger, tmpInteger2, tmpInteger3)
endfunction

private function GenerateHero takes integer heroTypeId, integer whichRace, integer index returns nothing
    set tmpInteger = heroTypeId
    set tmpInteger2 = whichRace
    set tmpInteger3 = index
    call NewOpLimit(function GenerateHeroNewOpLimit)
endfunction

private function GenerateHeroes takes nothing returns nothing
    local integer id = 0
    local integer i = 0
    local integer max = GetHeroesMax()
    local DependencyEquivalents d = 0
    local integer j = 0
    local integer max2 = 0
    local integer index = 0
    
    call ClearGeneratedIds()
    
    call FileStart()

    call FileWriteLine("<!-- Heroes generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i >= max)
        set id = GetHeroUnitType(i)
        if (GenerateId(id)) then
            call GenerateHero(id, GetHeroRace(i), index)
            
            set d = GetDependencyEquivalents(id)
            if (d != 0) then
                set j = 0
                set max2 = d.count
                loop
                    exitwhen (j >= max2)
                    set index = index + 1
                    if (GenerateId(d.ids[j])) then
                        call GenerateHero(d.ids[j], GetHeroRace(i), index)
                    endif
                    set j = j + 1
                endloop
            endif
            
            set index = index + 1
        endif
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetMaxHeroTransformationTypes()
    loop
        exitwhen (i >= max)
        set id = GetHeroTransformationType(i).unitTypeId
        if (GenerateId(id)) then
            call GenerateHero(id, udg_RaceNone, index)
            
            set d = GetDependencyEquivalents(id)
            if (d != 0) then
                set j = 0
                set max2 = d.count
                loop
                    exitwhen (j >= max2)
                    set index = index + 1
                    if (GenerateId(d.ids[j])) then
                        call GenerateHero(d.ids[j], udg_RaceNone, index)
                    endif
                    set j = j + 1
                endloop
            endif
            
            set index = index + 1
        endif
        set i = i + 1
    endloop

    call FileWriteLine("<!-- Heroes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Heroes.txt")
endfunction

private function GenerateBossEx takes unit hero, integer index returns nothing
    local AbstractZone zone = 0
    local integer heroTypeId = GetUnitTypeId(hero)
    local integer legendaryItemIndex = -1
    call FileWriteLine("<tr id=\"" + A2S(heroTypeId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetActualObjectName(heroTypeId)))
    //call IconToHtml(GetUnitTypeId(hero))
    call WriteUnitPopoverWithIconEx(hero, "bosses.html")
    call FileWriteLine("</td>")

    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetActualObjectName(heroTypeId))
    call FileWriteLine("</td>")
    
    // level
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(GetHeroLevel(hero)))
    call FileWriteLine("</td>")
    
    // location
    call FileWriteLine("<td>")
    
    set zone = GetZoneByCoordinates(GetUnitX(hero), GetUnitY(hero))
    if (zone != 0) then
        call IconToHtmlEx4(GetZoneIcon(zone), "zones.html", GetZoneName(zone), GetZoneId(zone))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // legendary item
    set legendaryItemIndex = GetLegendaryItemByBoss(hero)
    
    if (legendaryItemIndex != -1) then
        call FileWriteLine("<td>")
        call IconToHtmlEx(GetLegendaryItemTypeId(legendaryItemIndex), "items.html")
        call FileWriteLine("</td>")
    else
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
    endif
    
    // hero class
    call FileWriteLine("<td>")
    call GenerateHeroClass(heroTypeId)
    call FileWriteLine("</td>")

    // primary attribute
    call WriteHeroPrimaryAttributeColumn(hero)

    // start strength
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_STRENGTH)))
    call FileWriteLine("</td>")

    // start agility
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_AGILITY)))
    call FileWriteLine("</td>")
    
    // start intelligence
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(BlzGetUnitIntegerField(hero, UNIT_IF_INTELLIGENCE)))
    call FileWriteLine("</td>")
    
    // strength per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_STRENGTH_PER_LEVEL)))
    call FileWriteLine("</td>")

    // agility per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_AGILITY_PER_LEVEL)))
    call FileWriteLine("</td>")

    // intelligence per level
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitRealField(hero, UNIT_RF_INTELLIGENCE_PER_LEVEL)))
    call FileWriteLine("</td>")

    // move type
    call FileWriteLine("<td>")
    call FileWriteLine(GetMoveType(hero))
    call FileWriteLine("</td>")

    // move speed
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(GetUnitMoveSpeed(hero))))
    call FileWriteLine("</td>")

    // attack type
    call FileWriteLine("<td>")
    call GenerateAttackTypeCell(hero)
    call FileWriteLine("</td>")

    // attack speed
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0)))
    call FileWriteLine("</td>")
    
    // attack range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitWeaponRealField(hero, UNIT_WEAPON_RF_ATTACK_RANGE, 0))))
    call FileWriteLine("</td>")
    
    // attack damage
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitDamage(hero))
    call FileWriteLine("</td>")

    // armor type
    call FileWriteLine("<td>")
    call GenerateArmorCell(hero)
    call FileWriteLine("</td>")

    // armor
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitArmor(hero))))
    call FileWriteLine("</td>")

    // day sight range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(hero, UNIT_RF_SIGHT_RADIUS))))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateBossNewOpLimit takes nothing returns nothing
    call GenerateBossEx(tmpUnit, tmpInteger)
endfunction

private function GenerateBoss takes unit hero, integer index returns nothing
    set tmpUnit = hero
    set tmpInteger = index
    call NewOpLimit(function GenerateBossNewOpLimit)
endfunction

private function GenerateBosses takes nothing returns nothing
    local integer i = 0
    local integer max = 0
    local integer index = 0
    
    call FileStart()
    call FileWriteLine("<!-- Bosses generated with chat command \"-website\". -->")

    set i = 0
    set max = BlzGroupGetSize(udg_Bosses)
    loop
        exitwhen (i == max)
        call GenerateBoss(BlzGroupUnitAt(udg_Bosses, i), index)
        set index = index + 1
        set i = i + 1
    endloop
    
    set i = 0
    set max = BlzGroupGetSize(udg_BossesQuests)
    loop
        exitwhen (i == max)
        call GenerateBoss(BlzGroupUnitAt(udg_BossesQuests, i), index)
        set index = index + 1
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Bosses generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Bosses.txt")
endfunction

private function GetUnitCountInMap takes integer unitTypeId returns string
    local group g = GetUnitsOfTypeIdAll(unitTypeId)
    local integer count = BlzGroupGetSize(g)  - 1
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    if (count > 0) then
        return I2S(count)
    endif
    return "-"
endfunction

private function GetItemCountInMap takes integer itemTypeId returns string
    local integer count = CountItemsOfTypeIdAll(itemTypeId) - 1
    if (count > 0) then
        return I2S(count)
    endif
    return "-"
endfunction

private function GenerateUnitEx takes integer unitTypeId, integer whichRace, integer index returns nothing
    local unit creep = CreateTmpUnit(unitTypeId)
    local integer i = 0
    local integer max = 0
    local integer abilityId = 0
    local boolean primary = IsPrimaryDependencyEquivalent(unitTypeId)
    
    call FileWriteLine("<tr id=\"" + A2S(unitTypeId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetUnitName(creep)))
    //call IconToHtml(unitTypeId)
    call WriteUnitPopoverWithIconEx(creep, "units.html")
    call FileWriteLine("</td>")

    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitName(creep))
    if (not primary) then
        call FileWriteLine(" <div title=\"Depndency equivalent.\">(d)</div>")
    endif
    call FileWriteLine("</td>")
    
    // count
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitCountInMap(unitTypeId))
    call FileWriteLine("</td>")
    
    // abilities and description
    call FileWriteLine("<td>")
    call FileWriteLine("<div class=\"spells\">")
    set i = 0
    loop
        exitwhen (i == MAX_UNIT_ABILITIES)
        if (BlzGetUnitAbilityByIndex(creep, i) != null) then
            set abilityId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(creep, i))
            if (abilityId != 0 and IsValidAbility(abilityId)) then
                call IconToHtmlEx(abilityId, "spells.html")
            endif
        endif
        set i = i + 1
    endloop
    call FileWriteLine("</div>")
    //call FileWriteLine("<div class=\"description\">")
    //call FormatTooltip(BlzGetAbilityExtendedTooltip(unitTypeId, 0))
    //call FileWriteLine("</div>")
    call FileWriteLine("</td>")
    
    // race
    call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
    call RaceOrProfessionOrQuestIconToHtml(unitTypeId, whichRace)
    call FileWriteLine("</td>")
    
    // items
    if (GetUnitTypeIdTrophy(unitTypeId) != 0) then
        call FileWriteLine("<td>")
        call IconToHtmlEx(GetUnitTypeIdTrophy(unitTypeId), "items.html")
        call FileWriteLine("</td>")
    else
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
    endif
    
    // level
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(GetUnitLevel(creep)))
    call FileWriteLine("</td>")

    // gold bounty
    call FileWriteLine(ColumnDataOrder(I2S(GetUnitBountyBase(creep)), I2S(GetUnitBountyBase(creep))))
    call GenerateUnitBountyGold(creep)
    call FileWriteLine("</td>")

    // food cost
    call GenerateUnitTypeIdFoodCost(unitTypeId)

    // gold cost
    call GenerateUnitTypeIdGoldCost(unitTypeId)

    // wood cost
    call GenerateUnitTypeIdLumberCost(unitTypeId)
    
    // move type
    call FileWriteLine("<td>")
    call FileWriteLine(GetMoveType(creep))
    call FileWriteLine("</td>")

    // move speed
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(GetUnitMoveSpeed(creep))))
    call FileWriteLine("</td>")

    // armor type
    call FileWriteLine("<td>")
    call GenerateArmorCell(creep)
    call FileWriteLine("</td>")

    // armor
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitArmor(creep))))
    call FileWriteLine("</td>")
    
    call GenerateUnitAttack(creep)
    
    // max hp
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_HP))))
    call FileWriteLine("</td>")
    
    // hp regeneration
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_HIT_POINTS_REGENERATION_RATE) > 0.0) then
        call FileWriteLine(R2SHtml(BlzGetUnitRealField(creep, UNIT_RF_HIT_POINTS_REGENERATION_RATE)))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // max mana
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_MANA) > 0.0) then
        call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_MANA))))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // mana regeneration
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_MANA_REGENERATION) > 0.0) then
        call FileWriteLine(R2SHtml(BlzGetUnitRealField(creep, UNIT_RF_MANA_REGENERATION)))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // sight range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_SIGHT_RADIUS))))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    call RemoveUnit(creep)
    set creep = null
endfunction

private function OpLimitGenerateUnit takes nothing returns nothing
    if (GenerateId(tmpInteger)) then
        call GenerateUnitEx(tmpInteger, tmpInteger2, tmpInteger3)
    endif
endfunction

private function GenerateUnit takes integer objectTypeId, integer index returns nothing
    set tmpInteger = objectTypeId
    set tmpInteger2 = GetObjectRace(objectTypeId)
    set tmpInteger3 = index
    call NewOpLimit(function OpLimitGenerateUnit)
endfunction

private function GenerateNonCreepUnits takes nothing returns integer
    local integer index = 0
    local integer id = 0
    local integer i = 0
    local integer max = GetSaveObjectUnitMax()
    local DependencyEquivalents d = 0
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set id = GetSaveObjectUnitId(i)
        if (id != 0) then
            call GenerateUnit(id, index)
            
            set d = GetDependencyEquivalents(id)
            if (d != 0) then
                set j = 0
                set max2 = d.count
                loop
                    exitwhen (j >= max2)
                    set index = index + 1
                    call GenerateUnit(d.ids[j], index)
                    set j = j + 1
                endloop
            endif
        else
            call BJDebugMsg("Warning: ID 0 for unit type with index " + I2S(i))
        endif
        set i = i + 1
        set index = index + 1
    endloop
    
    return index
endfunction

private function GenerateCreepUnits takes integer index returns nothing
    local integer id = 0
    local integer i = 0
    local integer max = GetNeutralUnitsMax()
    local DependencyEquivalents d = 0
    local integer j = 0
    local integer max2 = 0
    loop
        exitwhen (i == max)
        set id = GetNeutralUnit(i)
        if (id != 0) then
            call GenerateUnit(id, index)
            
            set d = GetDependencyEquivalents(id)
            if (d != 0) then
                set j = 0
                set max2 = d.count
                loop
                    exitwhen (j >= max2)
                    set index = index + 1
                    call GenerateUnit(d.ids[j], index)
                    set j = j + 1
                endloop
            endif
        else
            call BJDebugMsg("Warning: ID 0 for unit type with index " + I2S(i))
        endif
        set i = i + 1
        set index = index + 1
    endloop
endfunction

private function GenerateUnits takes nothing returns nothing
    local integer index = 0

    call FileStart()
    call FileWriteLine("<!-- Units generated with chat command \"-website\". -->")
    
    call ClearGeneratedIds()
    
    set index = GenerateNonCreepUnits()
    call GenerateCreepUnits(index)
    
    call FileWriteLine("<!-- Units generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Units.txt")
endfunction

private function GenerateBuildingEx takes integer unitTypeId, integer whichRace, integer index returns nothing
    local unit creep = CreateTmpUnit(unitTypeId)
    local integer i = 0
    local integer max = 0
    local integer abilityId = 0

    call FileWriteLine("<tr id=\"" + A2S(unitTypeId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetUnitName(creep)))
    //call IconToHtml(unitTypeId)
    call WriteUnitPopoverWithIconEx(creep, "buildings.html")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitName(creep))
    call FileWriteLine("</td>")
    
    // count
    call FileWriteLine("<td>")
    if (unitTypeId == RANDOM_MINE) then
        call FileWriteLine(I2S(GetRandomMinesCount()))
    elseif (unitTypeId == RANDOM_WATER_MINE) then
        call FileWriteLine(I2S(GetRandomWaterMinesCount()))
    else
        call FileWriteLine(GetUnitCountInMap(unitTypeId))
    endif
    call FileWriteLine("</td>")

    // abilities/items/tooltip
    call FileWriteLine("<td>")
    call FileWriteLine("<div class=\"spells\">")
    set i = 0
    loop
        exitwhen (i == MAX_UNIT_ABILITIES)
        set abilityId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(creep, i))
        if (abilityId != 0 and IsValidAbility(abilityId)) then
            call IconToHtmlEx(abilityId, "spells.html")
        endif
        set i = i + 1
    endloop
    call FileWriteLine("</div>")
    
    /*
    set max = GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UMKI)
    
    if (max > 0) then
        call FileWriteLine("<div class=\"items\">")
        set i = 0
        loop
            exitwhen (i == max)
            call IconToHtmlEx(GetObjectIdIntegerListFieldValue(unitTypeId, OBJECT_DATA_FIELD_UMKI, i), "items.html")
            set i = i + 1
        endloop
        call FileWriteLine("</div>")
    endif

    //call FileWriteLine("<div class=\"description\">")
    //call FormatTooltip(BlzGetAbilityExtendedTooltip(unitTypeId, 0))
    //call FileWriteLine("</div>")
    */
    call FileWriteLine("</td>")
    
    // race
    call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
    call RaceIconToHtml(whichRace)
    call FileWriteLine("</td>")
    
    // tiny item
    if (GetObjectMapping(unitTypeId) != 0) then
        call FileWriteLine(ColumnDataOrder(A2S(GetObjectMapping(unitTypeId)), GetObjectName(GetObjectMapping(unitTypeId))))
        call IconToHtmlEx(GetObjectMapping(unitTypeId), "items.html")
        call FileWriteLine("</td>")
    else
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
    endif

    // gold cost
    call GenerateUnitTypeIdGoldCost(unitTypeId)
    
    // wood cost
    call GenerateUnitTypeIdLumberCost(unitTypeId)
    
    // food made
    call GenerateUnitTypeIdFoodMade(unitTypeId)
    
    // armor type
    call FileWriteLine("<td>")
    call GenerateArmorCell(creep)
    call FileWriteLine("</td>")
    
    // armor
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitArmor(creep))))
    call FileWriteLine("</td>")
    
    call GenerateUnitAttack(creep)

    // max hp
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_HP))))
    call FileWriteLine("</td>")

    // hp regeneration
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_HIT_POINTS_REGENERATION_RATE) > 0.0) then
        call FileWriteLine(R2SHtml(BlzGetUnitRealField(creep, UNIT_RF_HIT_POINTS_REGENERATION_RATE)))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // max mana
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_MANA) > 0.0) then
        call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_MANA))))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // mana regeneration
    call FileWriteLine("<td>")
    if (BlzGetUnitRealField(creep, UNIT_RF_MANA_REGENERATION) > 0.0) then
        call FileWriteLine(R2SHtml(BlzGetUnitRealField(creep, UNIT_RF_MANA_REGENERATION)))
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // sight range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(creep, UNIT_RF_SIGHT_RADIUS))))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    call RemoveUnit(creep)
    set creep = null
endfunction

private function GenerateBuildingNewOpLimit takes nothing returns nothing
    if (GenerateId(tmpInteger)) then
        call GenerateBuildingEx(tmpInteger, tmpInteger2, tmpInteger3)
    endif
endfunction

private function GenerateBuilding takes integer unitTypeId, integer index returns nothing
    set tmpInteger = unitTypeId
    set tmpInteger2 = GetObjectRace(unitTypeId)
    set tmpInteger3 = index
    call NewOpLimit(function GenerateBuildingNewOpLimit)
endfunction

private function GenerateNeutralBuildings takes nothing returns nothing
    local integer max = GetNeutralBuildingsMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        call GenerateBuilding(GetNeutralBuilding(i), i)
        set i = i + 1
    endloop
endfunction

private function GenerateRaceBuildings takes nothing returns nothing
    local integer max = GetSaveObjectBuildingMax()
    local integer i = 0
    loop
        exitwhen (i == max)
        call GenerateBuilding(GetSaveObjectBuildingId(i), GetNeutralBuildingsMax() + i)
        set i = i + 1
    endloop
endfunction

private function GenerateBuildings takes nothing returns nothing
    call FileStart()
    call FileWriteLine("<!-- Buildings generated with chat command \"-website\". -->")
    
    call ClearGeneratedIds()
    
    call NewOpLimit(function GenerateNeutralBuildings)

    call NewOpLimit(function GenerateRaceBuildings)
    
    call FileWriteLine("<!-- Buildings generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Buildings.txt")
endfunction

private function GenerateItemEx takes integer itemTypeId, integer whichRace, integer index returns nothing
    local item whichItem = CreateItem(itemTypeId, 0.0, 0.0)
    local integer goldCost = 0
    local integer lumberCost = 0
    
    call FileWriteLine("<tr id=\"" + A2S(itemTypeId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetItemName(whichItem)))
    //call IconToHtml(itemTypeId)
    call WriteItemPopoverWithIcon(itemTypeId, "items.html")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetItemName(whichItem))
    call FileWriteLine("</td>")
    
    // count
    call FileWriteLine("<td>")
    call FileWriteLine(GetItemCountInMap(itemTypeId))
    call FileWriteLine("</td>")
    
    // race
    call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
    call RaceOrProfessionOrQuestIconToHtml(itemTypeId, whichRace)
    call FileWriteLine("</td>")
    
    // building for tiny item
    if (GetObjectMapping(itemTypeId) != 0) then
        call FileWriteLine(ColumnDataOrder(A2S(GetObjectMapping(itemTypeId)), GetObjectName(GetObjectMapping(itemTypeId))))
        call IconToHtmlEx(GetObjectMapping(itemTypeId), "buildings.html")
        call FileWriteLine("</td>")
    else
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
    endif
    
    // can be dropped by creeps
    /*
    call FileWriteLine("<td>")
    if (BlzGetItemBooleanField(whichItem, ITEM_BF_INCLUDE_AS_RANDOM_CHOICE)) then // TODO Always returns false.
        call FileWriteLine("yes")
    else
        call FileWriteLine("no")
    endif
    call FileWriteLine("</td>")
    */
    
    // level
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(GetItemLevel(whichItem)))
    call FileWriteLine("</td>")
    
    // tooltip
    //call FileWriteLine("<td>")
    //call FormatTooltip(BlzGetItemExtendedTooltip(whichItem))
    //call FileWriteLine("</td>")
    
    // gold cost
    call GenerateItemTypeIdGoldCost(itemTypeId)
    
    // lumber cost
    call GenerateItemTypeIdLumberCost(itemTypeId)
    
    // charges
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(GetItemCharges(whichItem)))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")    
    
    call RemoveItem(whichItem)
    set whichItem = null
endfunction

private function GenerateItemNewOpLimit takes nothing returns nothing
    if (GenerateId(tmpInteger)) then
        call GenerateItemEx(tmpInteger, tmpInteger2, tmpInteger3)
    endif
endfunction

private function GenerateItem takes integer itemTypeId, integer index returns nothing
    set tmpInteger = itemTypeId
    set tmpInteger2 = GetObjectRace(itemTypeId)
    set tmpInteger3 = index
    call NewOpLimit(function GenerateItemNewOpLimit)
endfunction

private function GenerateNormalItemsEx takes integer start, integer count returns nothing
    local integer i = start
    local integer max = IMinBJ(start + count, GetSaveObjectItemMax())
    // contain race and profession items
    loop
        exitwhen (i >= max)
        if (GetSaveObjectItemId(i) != 0) then
            call GenerateItem(GetSaveObjectItemId(i), i)
        else
            call BJDebugMsg("Warning: Item save object with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

private function GenerateNormalItemsNewOpLimit takes nothing returns nothing
    call GenerateNormalItemsEx(tmpInteger, tmpInteger2)
endfunction

private function GenerateNormalItems takes integer start, integer count returns nothing
    set tmpInteger = start
    set tmpInteger2 = count
    call NewOpLimit(function GenerateNormalItemsNewOpLimit)
endfunction

private function GenerateLegendaryItems takes nothing returns nothing
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (udg_LegendaryItemType[i] != 0) then
            call GenerateItem(udg_LegendaryItemType[i], GetSaveObjectItemMax() + i)
        else
            call BJDebugMsg("Warning: Legendary item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

private function GenerateQuestRewardItems takes nothing returns nothing
    local integer i = 0
    local integer max = GetQuestsMax()
    loop
        exitwhen (i == max)
        if (GetQuestReward(i) != 0) then
            call GenerateItem(GetQuestReward(i), GetSaveObjectItemMax() + GetLegendaryItemsMax() + i)
        else
            call BJDebugMsg("Warning: Quest reward item with index " + I2S(i) + " is 0.")
        endif
        set i = i + 1
    endloop
endfunction

private function GenerateItems takes nothing returns nothing
    local integer i = 0
    local integer max = GetSaveObjectItemMax()
    call FileStart()
    call FileWriteLine("<!-- Items generated with chat command \"-website\". -->")
    
    call ClearGeneratedIds()
    
    // contain race and profession items
    // split because of huge number
    loop
        exitwhen (i >= max)
        call GenerateNormalItems(i, 100)
        set i = i + 100
    endloop
    
    call NewOpLimit(function GenerateLegendaryItems)
    
    call NewOpLimit(function GenerateQuestRewardItems)
    
    call FileWriteLine("<!-- Items generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Items.txt")
endfunction

private function GenerateAllRaceIconsEx takes integer whichRace returns nothing
    local unit hero = null
    local Research r = 0
    local integer id = 0
    local integer i = 0
    local integer max = GetHeroesMax()
    local DependencyEquivalents d = 0
    local integer j = 0
    local integer max2 = 0
    
    call ClearGeneratedIds()
    // heroes
    set i = 0
    loop
        exitwhen (i >= max)
        set id = GetHeroUnitType(i)
        if (GetHeroRace(i) == whichRace and id != 0 and GenerateId(id)) then
            set hero = CreateTmpUnit(id)
            call WriteUnitPopoverWithIconEx(hero, "heroes.html")
            call RemoveUnit(hero)
            set hero = null
        endif
        set i = i + 1
    endloop
    // buildings
    set i = RACE_OBJECT_TYPE_FARM
    set max = RACE_OBJECT_TYPE_SPECIAL_BUILDING_2 + 1
    loop
        exitwhen (i >= max)
        set id = GetRaceObjectTypeId(whichRace, i)
        if (id != 0 and GenerateId(id)) then
            call WriteBuildingPopoverWithIcon(id)
        endif
        set i = i + 1
    endloop
    // units
    set i = RACE_OBJECT_TYPE_WORKER
    set max = RACE_MAX_OBJECT_TYPES
    loop
        exitwhen (i >= max)
        set id = GetRaceObjectTypeId(whichRace, i)
        if (id != 0 and GenerateId(id)) then
            call WriteUnitPopoverWithIcon(id, "units.html")
            
            set d = GetDependencyEquivalents(id)
            if (d != 0) then
                set j = 0
                set max2 = d.count
                loop
                    exitwhen (j >= max2)
                    call WriteUnitPopoverWithIcon(d.ids[j], "units.html")
                    set j = j + 1
                endloop
            endif
        endif
        set i = i + 1
    endloop
    // researches
    set max = GetResearchesMax()
    set i = 0
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        if (r != 0 and GetResearchRace(r) == whichRace and GetResearchId(r) != 0 and GenerateId(GetResearchId(r))) then
            call WriteResearchPopoverWithIcon(GetResearchId(r))
        endif
        set i = i + 1
    endloop
endfunction

private function GenerateAllRaceIconsNewOpLimit takes nothing returns nothing
    call GenerateAllRaceIconsEx(tmpInteger)
endfunction

private function GenerateAllRaceIcons takes integer whichRace returns nothing
    set tmpInteger = whichRace
    call NewOpLimit(function GenerateAllRaceIconsNewOpLimit)
endfunction

private function GetRaceTeamName takes integer team returns string
    if (team == TEAM_ALLIANCE) then
        return GetLocalizedStringSafe("ALLIANCE")
    elseif (team == TEAM_HORDE) then
        return GetLocalizedStringSafe("HORDE")
    endif
    return "-"
endfunction

private function GenerateRaceEx takes integer i returns nothing
    local item whichItem = CreateItem(udg_RaceTavernItemType[i], 0.0, 0.0)
    local item tinyItem = CreateItem(GetRaceObjectType(i, RACE_OBJECT_TYPE_TIER_1_ITEM), 0.0, 0.0)
    call FileWriteLine("<tr id=\"" + A2S(udg_RaceTavernItemType[i]) + "\">")
    // icon
    call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
    call WriteRacePopoverWithIconEx(whichItem, "races.html")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine("<a href=\"" + GetItemName(whichItem) + ".html\">")
    call FileWriteLine(GetItemName(whichItem))
    call FileWriteLine("</a>")
    call FileWriteLine("</td>")
    
    // scepter
    call FileWriteLine("<td>")
    if (udg_RaceItemType[i] != 0) then
        call IconToHtmlEx(udg_RaceItemType[i], "items.html")
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
    
    // start building
    call FileWriteLine("<td>")
    call IconToHtmlEx(GetItemTypeId(tinyItem), "items.html")
    call FileWriteLine("</td>")
    
    // team
    call FileWriteLine("<td>")
    call FileWriteLine(GetRaceTeamName(GetRaceTeam(i)))
    call FileWriteLine("</td>")
    
    // bonus/required hero level
    call FileWriteLine("<td>")
    if (IsRaceBonus(i)) then
        call FileWriteLine("30")
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")
    
    // all heroes buildings, units and researches
    call FileWriteLine("<td>")
    call GenerateAllRaceIcons(i)
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
    
    call RemoveItem(whichItem)
    set whichItem = null
    call RemoveItem(tinyItem)
    set tinyItem = null
endfunction

private function GenerateRaceNewOpLimit takes nothing returns nothing
    call GenerateRaceEx(tmpInteger)
endfunction

private function GenerateRace takes integer whichRace returns nothing
    set tmpInteger = whichRace
    call NewOpLimit(function GenerateRaceNewOpLimit)
endfunction

private function GenerateRaceTechnologyTreeBuildingEx takes integer unitTypeId returns nothing
    local unit whichUnit
    local integer i = 0
    local integer max = 0
    local integer t = 0
    
    if (unitTypeId != 0 and GenerateId(unitTypeId)) then
        set whichUnit = CreateTmpUnit(unitTypeId)
        
        call FileWriteLine("<td>")
    
        call FileWriteLine("<table>")
        call FileWriteLine("<tbody>")
        call FileWriteLine("<tr>")
        call FileWriteLine("<td>")
        
        call WriteBuildingPopoverWithIcon(unitTypeId)
        call FileWriteLine("<br/>")
        
        // name
        call FileWriteLine(GetUnitName(whichUnit))
        call FileWriteLine("<br/>")

        // units trained
        /*
        if (GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UTRA) > 0) then
            call FileWriteLine("<br/>")
            call FileWriteLine("Trains:")
            call FileWriteLine("<br/>")
            set i = 0
            set max = GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UTRA)
            loop
                exitwhen (i >= max or max <= 0)
                set t = GetObjectIdIntegerListFieldValue(unitTypeId, OBJECT_DATA_FIELD_UTRA, i)
                
                if (t != 0) then
                    // icon
                    call WriteUnitPopoverWithIcon(t)     
                    //call BJDebugMsg("List value with index " + I2S(i) + " of type " + GetObjectName(unitTypeId) + " with field utra is " + A2S(t))
                endif
                
                set i = i + 1
            endloop
        endif

        // items made
        if (GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UMKI) > 0) then
            call FileWriteLine("<br/>")
            call FileWriteLine("Items:")
            call FileWriteLine("<br/>")
            set i = 0
            set max = GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UMKI)
            loop
                exitwhen (i >= max)
                set t = GetObjectIdIntegerListFieldValue(unitTypeId, OBJECT_DATA_FIELD_UMKI, i)
                
                if (t != 0) then
                    // icon
                    call WriteItemPopoverWithIcon(t)
                endif
                
                set i = i + 1
            endloop
        endif
        
        // researches
        if (GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_URES) > 0) then
            call FileWriteLine("<br/>")
            call FileWriteLine("Researches:")
            call FileWriteLine("<br/>")
            set i = 0
            set max = GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_URES)
            loop
                exitwhen (i >= max)
                set t = GetObjectIdIntegerListFieldValue(unitTypeId, OBJECT_DATA_FIELD_URES, i)
                
                if (t != 0) then
                    // icon
                    call WriteResearchPopoverWithIcon(t)
                endif
                
                set i = i + 1
            endloop
        endif
        
        call FileWriteLine("</td>")
        call FileWriteLine("</tr>")
        
        // upgrades to:
        if (GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UUPT) > 0) then
            call FileWriteLine("<br/>")
            call FileWriteLine("Upgrades to:")
            call FileWriteLine("<br/>")
            set i = 0
            set max = GetObjectIdIntegerListFieldValueCount(unitTypeId, OBJECT_DATA_FIELD_UUPT)
            loop
                exitwhen (i >= max)
                call GenerateRaceTechnologyTreeBuildingEx(GetObjectIdIntegerListFieldValue(unitTypeId, OBJECT_DATA_FIELD_UUPT, i))
                set i = i + 1
            endloop
        endif
        */
        
        call FileWriteLine("</tbody>")
        call FileWriteLine("</table>")
        call FileWriteLine("</td>")
        
        call RemoveUnit(whichUnit)
        set whichUnit = null
    endif
endfunction

private function GenerateRaceTechnologyTreeBuildingNewOpLimit takes nothing returns nothing
    call GenerateRaceTechnologyTreeBuildingEx(tmpInteger)
endfunction

private function GenerateRaceTechnologyTreeBuilding takes integer unitTypeId returns nothing
    set tmpInteger = unitTypeId
    call NewOpLimit(function GenerateRaceTechnologyTreeBuildingNewOpLimit)
endfunction

private function GenerateRaceTechnologyTreeEx takes integer whichRace returns nothing
    local integer i = 0
    local integer max = 0
    
    call ClearGeneratedIds()
    
    // tier 1
    call FileWriteLine("<tr id=\"tier1\">")
    
    // tier 1
    call FileWriteLine("<td>")
    call FileWriteLine("Tier 1")
    call FileWriteLine("</td>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("<table>")
    call FileWriteLine("<tr>")
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_TIER_1))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_HOUSING))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_FARM))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_ALTAR))
    
    // summoned heroes
    /*
    call FileWriteLine("<br/>")
    call FileWriteLine("Summons:")
    call FileWriteLine("<br/>")
    set i = 0
    set max = udg_MaxHeroUnitTypes
    loop
        exitwhen (i >= max)
        if (GetHeroRace(i) == whichRace) then
            // icon
            //call WriteUnitPopoverWithIcon(udg_HeroUnitType[i])
        endif
        
        set i = i + 1
    endloop
    */
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_BARRACKS))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MILL))
    
    if (GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MILL) != GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH)) then
        call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_BLACK_SMITH))
    endif
    
    // tower
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SCOUT_TOWER))
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_GUARD_TOWER))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_CANNON_TOWER))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_ARCANE_TOWER))
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SHOP))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_MINE))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SHIPYARD))
    
    call FileWriteLine("</tr>")
    call FileWriteLine("</table>")
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
    
    // tier 2
    call FileWriteLine("<tr id=\"tier2\">")
    
    // tier 2
    call FileWriteLine("<td>")
    call FileWriteLine("Tier 2")
    call FileWriteLine("</td>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("<table>")
    call FileWriteLine("<tr>")
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_TIER_2))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_ARCANE_SANCTUM))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_GRYPHON_AVIARY))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_WORKSHOP))
    
    if (GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT) != 0) then
        call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SACRIFICIAL_PIT))
    endif
    
    call FileWriteLine("</tr>")
    call FileWriteLine("</table>")
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
    
    // tier 3
    call FileWriteLine("<tr id=\"tier3\">")
    
    // tier 3
    call FileWriteLine("<td>")
    call FileWriteLine("Tier 3")
    call FileWriteLine("</td>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("<table>")
    call FileWriteLine("<tr>")
    
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_TIER_3))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING))
    call GenerateRaceTechnologyTreeBuilding(GetRaceObjectTypeId(whichRace, RACE_OBJECT_TYPE_SPECIAL_BUILDING_2))
    
    // Citizen Male
    call GenerateRaceTechnologyTreeBuilding(CRAFTING_STASH)
    call GenerateRaceTechnologyTreeBuilding(WALL)
    call GenerateRaceTechnologyTreeBuilding(EVENT_HOUSE)
    call GenerateRaceTechnologyTreeBuilding(TRADING_POST)
    call GenerateRaceTechnologyTreeBuilding(RESEARCH_TENT)
    call GenerateRaceTechnologyTreeBuilding(POWER_GENERATOR)
    call GenerateRaceTechnologyTreeBuilding(PORTAL)
    
    // Citizen Female
    call GenerateRaceTechnologyTreeBuilding(TRAINER)
    call GenerateRaceTechnologyTreeBuilding(SKINS)
    call GenerateRaceTechnologyTreeBuilding(HERO_ABILITIES)
    call GenerateRaceTechnologyTreeBuilding(WITCH_HUT)
    call GenerateRaceTechnologyTreeBuilding(ALCHEMIST_LAB)
    call GenerateRaceTechnologyTreeBuilding(MOUNTS_CAGE)
    call GenerateRaceTechnologyTreeBuilding(SPELL_BOOK)
    call GenerateRaceTechnologyTreeBuilding(DRAGON_ROOST)
    call GenerateRaceTechnologyTreeBuilding(THIEVES_GUILD)
    call GenerateRaceTechnologyTreeBuilding(MARKETPLACE)
    call GenerateRaceTechnologyTreeBuilding(ANTIMAGIC_WARD)
    
    // Child
    call GenerateRaceTechnologyTreeBuilding(ARMORY)
    call GenerateRaceTechnologyTreeBuilding(BANNER_SHOP)
    
    call FileWriteLine("</tr>")
    call FileWriteLine("</table>")
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
    
    // tier 4
    call FileWriteLine("<tr id=\"tier4\">")
    
    // tier 4
    call FileWriteLine("<td>")
    call FileWriteLine("Tier 4")
    call FileWriteLine("</td>")
    
    call FileWriteLine("<td>")
    call FileWriteLine("<table>")
    call FileWriteLine("<tr>")
    
    call GenerateRaceTechnologyTreeBuilding(TEMPLE_OF_LIGHT)
    call GenerateRaceTechnologyTreeBuilding(TEMPLE_OF_DARKNESS)
    
    call FileWriteLine("</tr>")
    call FileWriteLine("</table>")
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
endfunction

private function GenerateRaceTechnologyTreeNewOpLimit takes nothing returns nothing
    call GenerateRaceTechnologyTreeEx(tmpInteger)
endfunction

private function GenerateRaceTechnologyTree takes integer whichRace returns nothing
    set tmpInteger = whichRace
    call NewOpLimit(function GenerateRaceTechnologyTreeNewOpLimit)
endfunction

private function GenerateRaces takes nothing returns nothing
    local integer i = 0
    local integer max = GetRacesMax()

    call FileStart()
    call FileWriteLine("<!-- Races generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        call GenerateRace(i)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Races generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Races.txt")
    
    set i = 0
    loop
        exitwhen (i == max)
        call FileStart()
        call FileWriteLine("<!-- Races generated with chat command \"-website\". -->")
        call GenerateRaceTechnologyTree(i)
        call FileWriteLine("<!-- Races generated with chat command \"-website\". -->")
        
        // The line below creates the file at the specified location
        call FileSave("WorldOfWarcraftReforged-Race-" + GetRaceName(i) + ".txt")
        set i = i + 1
    endloop
endfunction

private function GenerateProfessionEx takes integer p returns nothing
    local integer i = 0
    local integer max = PROFESSION_RANK_MAX
    local integer j = 0
    local integer max2 = 0

    call FileWriteLine("<tr id=\"" + A2S(GetProfessionItemTypeId(p)) + "\">")
    // icon
    call FileWriteLine("<td data-order=\"" + I2S(p) + "\">")
    call WriteItemPopoverWithIcon(GetProfessionItemTypeId(p), "professions.html")
    call FileWriteLine("</td>")
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetProfessionName(p))
    call FileWriteLine("</td>")
    // crafted items/units
    call FileWriteLine("<td>")
    call FileWriteLine("<div class=\"items\">")
    set i = 0
    set max = PROFESSION_RANK_MAX
    loop
        exitwhen (i == max)
        set j = 0
        set max2 = GetProfessionCraftedItemsCount(p, i)
        loop
            exitwhen (j >= max2)
            if (GetProfessionCraftedUnit(p, i, j) == 0) then
                call WriteItemPopoverWithIcon(GetProfessionCraftedItem(p, i, j), "items.html")
            else
                call WriteUnitPopoverWithIcon(GetProfessionCraftedUnit(p, i, j), "units.html")
            endif
            call FileWriteLine("<div title=\"" + GetRankName(i) + "\">(" + I2S(GetProfessionCraftedCount(p, i, j)) + ")</div>")
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    call FileWriteLine("</div>")
    call FileWriteLine("</td>")
    // book
    call FileWriteLine("<td>")
    call WriteItemPopoverWithIcon(GetProfessionBookItemTypeId(p), "items.html")
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
endfunction

private function GenerateProfessionNewOpLimit takes nothing returns nothing
    call GenerateProfessionEx(tmpInteger)
endfunction

private function GenerateProfession takes integer p returns nothing
    set tmpInteger = p
    call NewOpLimit(function GenerateProfessionNewOpLimit)
endfunction

private function GenerateClassEx takes integer i returns nothing
    local integer j = 0
    local SkillMenuAbility skillMenuAbility = 0
    call FileWriteLine("<tr id=\"" + A2S(GetHeroClassItemTypeId(i)) + "\">")
    // icon
    call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
    call WriteItemPopoverWithIcon(GetHeroClassItemTypeId(i), "classes.html")
    call FileWriteLine("</td>")
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetHeroClassName(i))
    call FileWriteLine("</td>")
    // spells
    call FileWriteLine("<td>")
    set j = 0
    loop
        exitwhen (j == WoWReforgedSkillMenu_MAX_SLOTS)
        set skillMenuAbility = GetLearnableAbilityId(j, i)
        if (skillMenuAbility != 0) then
            //call IconToHtml(skillMenuAbility.abilityId)
            call WriteAbilityPopoverWithIcon(skillMenuAbility.abilityId, "spells.html")
        endif
        set j = j + 1
    endloop

    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateClassNewOpLimit takes nothing returns nothing
    call GenerateClassEx(tmpInteger)
endfunction

private function GenerateClass takes integer p returns nothing
    set tmpInteger = p
    call NewOpLimit(function GenerateClassNewOpLimit)
endfunction

private function GenerateClasses takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxHeroClasses()
    
    call FileStart()
    call FileWriteLine("<!-- Classes generated with chat command \"-website\". -->")
    loop
        exitwhen (i == max)
        call GenerateClass(i)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Classes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Classes.txt")
endfunction

private function GenerateClassesOverview takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxHeroClasses()
    
    call FileStart()
    call FileWriteLine("<!-- Classes generated with chat command \"-website\". -->")
    loop
        exitwhen (i == max)
        call WriteItemPopoverWithIcon(GetHeroClassItemTypeId(i), "classes.html")
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Classes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-ClassesOverview.txt")
endfunction

private function GenerateProfessions takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()

    call FileStart()
    call FileWriteLine("<!-- Professions generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        call GenerateProfession(i)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Professions generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Professions.txt")
endfunction

private function GenerateProfessionsOverview takes nothing returns nothing
    local integer i = 0
    local integer max = GetProfessionsMax()

    call FileStart()
    call FileWriteLine("<!-- Professions generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        call WriteItemPopoverWithIcon(GetProfessionItemTypeId(i), "professions.html")
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Professions generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-ProfessionsOverview.txt")
endfunction

private function GeneratePlayers takes nothing returns nothing
    local integer i = 0
    local integer max = GetPrestoredSaveCodesMax()
    local string saveCode = ""
    local string playerName = ""
    local Account a = 0
    
    call FileStart()
    call FileWriteLine("<!-- Players generated with chat command \"-website\". -->")
    
    call ClearGeneratedStringIds()
    
    set i = 0
    loop
        exitwhen (i == max)
        if (GetPrestoredSaveCodeTypeByIndex(i) == PRESTORED_SAVECODE_TYPE_HEROES) then
            set playerName = GetPrestoredSaveCodePlayerNameByIndex(i)
            
            if (GenerateIdString(playerName)) then
                set saveCode = GetPrestoredSaveCodeByIndex(i)
                set a = GetAccountByName(playerName)
            
                call FileWriteLine("<tr id=\"" + playerName + "\">")
                
                // icon
                call FileWriteLine("<td>")
                if (a != 0 and StringLength(a.icon) > 0) then
                    call Icon(playerName, a.icon)
                else
                    call FileWriteLine("-")
                endif
                call FileWriteLine("</td>")
                
                // name
                call FileWriteLine("<td>")
                call FileWriteLine("<a href=\"https://us.forums.blizzard.com/en/warcraft3/u/" + playerName + "\">")
                call FileWriteLine(playerName)
                call FileWriteLine("</a>")
                call FileWriteLine("</td>")
                
                // VIP
                call FileWriteLine("<td>")
                if (IsAccountVIP(playerName)) then
                    call FileWriteLine("yes")
                else
                    call FileWriteLine("no")
                endif
                call FileWriteLine("</td>")

                // hero level 1
                call FileWriteLine("<td>")
                call FileWriteLine(I2S(IMinBJ(MAX_HERO_LEVEL, GetHeroLevelByXP(GetSaveCodeXp1(playerName, saveCode)))))
                call FileWriteLine("</td>")
                
                // hero level 2
                call FileWriteLine("<td>")
                call FileWriteLine(I2S(IMinBJ(MAX_HERO_LEVEL, GetHeroLevelByXP(GetSaveCodeXp2(playerName, saveCode)))))
                call FileWriteLine("</td>")
                
                // hero level 3
                call FileWriteLine("<td>")
                call FileWriteLine(I2S(IMinBJ(MAX_HERO_LEVEL, GetHeroLevelByXP(GetSaveCodeXp3(playerName, saveCode)))))
                call FileWriteLine("</td>")
                
                // gold
                call FileWriteLine("<td>")
                call FileWriteLine(I2S(GetSaveCodeGold(playerName, saveCode)))
                call FileWriteLine("</td>")
                
                // lumber
                call FileWriteLine("<td>")
                call FileWriteLine(I2S(GetSaveCodeLumber(playerName, saveCode)))
                call FileWriteLine("</td>")
                
                // unlocked
                if (a != 0) then
                    call FileWriteLine("<td>")
                    call FileWriteLine(UnlockedAccountIds(a))
                    call FileWriteLine("</td>")
                else
                    call FileWriteLine("<td>")
                    call FileWriteLine("-")
                    call FileWriteLine("</td>")
                endif

                // savecode
                call FileWriteLine("<td>")
                call FileWriteLine(saveCode)
                call FileWriteLine("</td>")

                call FileWriteLine("</tr>")
            endif
        endif
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetAccountsMax()
    loop
        exitwhen (i == max)
        set a = GetAccount(i)
        
        set saveCode = "-"
        set playerName = a.name
        
        if (GenerateIdString(playerName)) then
            call FileWriteLine("<tr id=\"" + playerName + "\">")
            
            // icon
            call FileWriteLine("<td>")
            if (a != 0 and StringLength(a.icon) > 0) then
                call Icon(playerName, a.icon)
            else
                call FileWriteLine("-")
            endif
            call FileWriteLine("</td>")
            
            // name
            call FileWriteLine("<td>")
            call FileWriteLine("<a href=\"https://us.forums.blizzard.com/en/warcraft3/u/" + playerName + "\">")
            call FileWriteLine(playerName)
            call FileWriteLine("</a>")
            call FileWriteLine("</td>")
            
            // VIP
            call FileWriteLine("<td>")
            if (IsAccountVIP(playerName)) then
                call FileWriteLine("yes")
            else
                call FileWriteLine("no")
            endif
            call FileWriteLine("</td>")

            // hero level 1
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero level 2
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero level 3
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // gold
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // lumber
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // unlocked
            call FileWriteLine("<td>")
            call FileWriteLine(UnlockedAccountIds(a))
            call FileWriteLine("</td>")

            // savecode
            call FileWriteLine("<td>")
            call FileWriteLine(saveCode)
            call FileWriteLine("</td>")

            call FileWriteLine("</tr>")
        endif
        
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetVIPsMax()
    loop
        exitwhen (i == max)
        set a = 0
        
        set saveCode = "-"
        set playerName = GetVIP(i)
        
        if (GenerateIdString(playerName)) then
            call FileWriteLine("<tr id=\"" + playerName + "\">")
            
            // icon
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // name
            call FileWriteLine("<td>")
            call FileWriteLine("<a href=\"https://us.forums.blizzard.com/en/warcraft3/u/" + playerName + "\">")
            call FileWriteLine(playerName)
            call FileWriteLine("</a>")
            call FileWriteLine("</td>")
            
            // VIP
            call FileWriteLine("<td>")
            call FileWriteLine("yes")
            call FileWriteLine("</td>")

            // hero level 1
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero level 2
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero level 3
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // gold
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // lumber
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero kills
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // hero deaths
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")
            
            // unlocked
            call FileWriteLine("<td>")
            call FileWriteLine("-")
            call FileWriteLine("</td>")

            // savecode
            call FileWriteLine("<td>")
            call FileWriteLine(saveCode)
            call FileWriteLine("</td>")

            call FileWriteLine("</tr>")
        endif
        
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Players generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Players.txt")
endfunction

private function GenerateQuestEx takes integer i returns nothing
    local integer j = 0
    local integer max2 = 0

    call FileWriteLine("<tr id=\"" + GetQuestId(i) + "\">")
    // icon
    call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
    call FileWriteLine("<a href=\"#" + GetQuestId(i) + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetQuestIcon(i) + "\" title=\"" + GetQuestIcon(i) + "\" />")
    call FileWriteLine("</a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetQuestTitle(i))
    call FileWriteLine("</td>")
    
     // npc
    call FileWriteLine("<td>")
    call IconToHtmlEx2(GetUnitTypeId(GetQuestNpc(i)), "npcs.html", GetActualObjectName(GetUnitTypeId(GetQuestNpc(i))))
    call FileWriteLine("</td>")
    
    // reward
    call FileWriteLine("<td>")
    call IconToHtmlEx(GetQuestReward(i), "items.html")
    call FileWriteLine("</td>")

    // requirement
    call FileWriteLine("<td>")
    if (GetQuestRequirement(i) != -1) then
        call FileWriteLine("<a href=\"#" + GetQuestId(GetQuestRequirement(i)) + "\">")
        call FileWriteLine("<img")
        call FileWriteLine("class=\"wowr-icon\"")
        call FileWriteLine("src=\"" + GetQuestIcon(GetQuestRequirement(i)) + "\"")
        call FileWriteLine("title=\"" + GetQuestTitle(GetQuestRequirement(i)) + "\"")
        call FileWriteLine("alt=\"" + GetQuestIcon(GetQuestRequirement(i)) + "\"")
        call FileWriteLine("/>")
        call FileWriteLine("</a>")
    else
        call FileWriteLine("-")
    endif
    call FileWriteLine("</td>")

    // description
    call FileWriteLine("<td>")
    call FormatTooltip(GetQuestDescription(i))
    
    set j = 0
    set max2 = QuestGetItemCount(GetQuest(i))
    if (max2 > 0) then
        call FileWriteLine("<br/>")
        call FileWriteLine("<ul>")
        loop
            exitwhen (j == max2)
            call FileWriteLine("<li>")
            call FileWriteLine(GetLocalizedStringSafe(QuestItemGetDescription(QuestGetItem(GetQuest(i), j))))
            call FileWriteLine("</li>")
            set j = j + 1
        endloop
        call FileWriteLine("</ul>")
    endif
    
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateQuest takes nothing returns nothing
    call GenerateQuestEx(tmpInteger)
endfunction

private function GenerateQuests takes nothing returns nothing
    local integer i = 0
    local integer max = GetQuestsMax()
    
    call FileStart()
    call FileWriteLine("<!-- Quests generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        set tmpInteger = i
        call NewOpLimit(function GenerateQuest)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Quests generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Quests.txt")
endfunction

private function GenerateInfoQuest takes integer i returns nothing
    local string id = StringReplace(GetInfoQuestId(i), " ", "")
    local integer j = 0
    local integer max2 = 0
    
    call FileWriteLine("<tr id=\"" + id + "\">")
    // icon
    call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
    call FileWriteLine("<a href=\"#" + id + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetInfoQuestIcon(i) + "\" title=\"" + GetInfoQuestIcon(i) + "\" />")
    call FileWriteLine("</a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetInfoQuestTitle(i))
    call FileWriteLine("</td>")

    // description
    call FileWriteLine("<td>")
    call FormatTooltip(GetInfoQuestDescription(i))
    call FileWriteLine("</td>")
    
    // items
    call FileWriteLine("<td>")
    call FileWriteLine("<ul class=\"questitems\">")
    if (GetInfoQuestHandle(i) != null) then
        set j = 0
        set max2 = QuestGetItemCount(GetInfoQuestHandle(i))
        loop
            exitwhen (j == max2)
            call FileWriteLine("<li>" + GetLocalizedStringSafe(QuestItemGetDescription(QuestGetItem(GetInfoQuestHandle(i), j))) + "</li>")
            set j = j + 1
        endloop
    endif
    call FileWriteLine("</ul>")
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateInfoQuestTmpInteger takes nothing returns nothing
    call GenerateInfoQuest(tmpInteger)
endfunction

private function GenerateInfoQuestOpLimit takes integer i returns nothing
    set tmpInteger = i
    call NewOpLimit(function GenerateInfoQuestTmpInteger)
endfunction

private function GenerateInfoQuests takes nothing returns nothing
    local integer i = 0
    local integer max = GetInfoQuestsMax()
    
    call FileStart()
    call FileWriteLine("<!-- Info quests generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        call GenerateInfoQuestOpLimit(i)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Info quests generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-InfoQuests.txt")
endfunction

private function GenerateNpcs takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxNpcs()
    local integer unitTypeId = 0
    local Zone zone = 0
    local unit u = null
    
    call FileStart()
    call FileWriteLine("<!-- NPCs generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        set unitTypeId = GetNpc(i)
        set u = GetNpcUnitByUnitTypeId(unitTypeId)
        
        if (u != null) then
            call FileWriteLine("<tr id=\"" + A2S(unitTypeId) + "\">")
            // icon
            call FileWriteLine("<td>")
            call IconToHtml(unitTypeId)
            call FileWriteLine("</td>")
            
            // name
            call FileWriteLine("<td>")
            call FileWriteLine(GetActualObjectName(unitTypeId))
            call FileWriteLine("</td>")
            
            // location
            call FileWriteLine("<td>")
            set zone = GetZoneByCoordinates(GetUnitX(u), GetUnitY(u))
            if (zone != 0) then
                call IconToHtmlEx4(GetZoneIcon(zone), "zones.html", GetZoneName(zone), GetZoneId(zone))
            else
                call FileWriteLine("-")
            endif
            call FileWriteLine("</td>")

            call FileWriteLine("</tr>")
        endif
        set u = null
        set i = i + 1
    endloop

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Npcs.txt")
endfunction

private function GenerateResearchEx takes integer researchId, integer whichRace, integer index returns nothing
    call FileWriteLine("<tr id=\"" + A2S(researchId) + "\">")
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(index), GetObjectName(researchId)))
    //call IconToHtml(researchId)
    call WriteResearchPopoverWithIcon(researchId)
    call FileWriteLine("</td>")

    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetObjectName(researchId))
    call FileWriteLine("</td>")
    
    // race
    call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
    call RaceIconToHtml(whichRace)
    call FileWriteLine("</td>")
    
    // description
    /*
    call FileWriteLine("<td>")
    call FileWriteLine("<div class=\"wc3-tooltip\">")
    call FormatTooltip(BlzGetAbilityExtendedTooltip(researchId, 0))
    call FileWriteLine("</div>")
    call FileWriteLine("</td>")
    */
    
     // levels
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(GetPlayerTechMaxAllowed(Player(0), researchId)))
    call FileWriteLine("</td>")
    
    call FileWriteLine("</tr>")
endfunction

private function GenerateResearchNewOpLimit takes nothing returns nothing
    if (GenerateId(tmpInteger)) then
        call GenerateResearchEx(tmpInteger, tmpInteger2, tmpInteger3)
    endif
endfunction

private function GenerateResearch takes integer researchId, integer whichRace, integer index returns nothing
    set tmpInteger = researchId
    set tmpInteger2 = whichRace
    set tmpInteger3 = index
    call NewOpLimit(function GenerateResearchNewOpLimit)
endfunction

private function GenerateResearches takes nothing returns nothing
    local integer i = 0
    local integer max = GetResearchesMax()
    local Research r = 0

    call FileStart()

    call FileWriteLine("<!-- Researches generated with chat command \"-website\". -->")
    set i = 0
    loop
        exitwhen (i == max)
        set r = GetResearch(i)
        if (r != 0) then
            call GenerateResearch(GetResearchId(r), GetResearchRace(r), i)
        endif
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Researches generated with chat command \"-website\". -->")
    
    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Researches.txt")
endfunction

private function GenerateSpellEx takes SkillMenuAbility skillMenuAbility, integer slot, integer counter returns nothing
    local integer abilityId = 0
    if (skillMenuAbility != 0) then
        set abilityId = skillMenuAbility.abilityId
        
        call FileWriteLine("<tr id=\"" + A2S(abilityId) + "\">")
        // icon
        call FileWriteLine("<td data-order=\"" + I2S(counter) + "\">")
        //call IconToHtml(GetLearnableSkillAbilityId(i))
        call WriteAbilityPopoverWithIcon(abilityId, "spells.html")
        
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine("<td>")
        call FileWriteLine(GetObjectName(abilityId))
        call FileWriteLine("</td>")
        
        // race
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
        
        // hero
        call FileWriteLine("<td>")
        call FileWriteLine("yes")
        call FileWriteLine("</td>")
        
        // slot
        call FileWriteLine("<td>")
        call FileWriteLine(I2S(slot + 1))
        call FileWriteLine("</td>")

        // equipment bag
        call FileWriteLine("<td>")
        if (skillMenuAbility.forbidEquipmentBag) then
            call FileWriteLine("no")
        else
            call FileWriteLine("yes")
        endif
        call FileWriteLine("</td>")
        
        call FileWriteLine("</tr>")
    endif
endfunction

private function GenerateSpellNewOpLimit takes nothing returns nothing
    call GenerateSpellEx(tmpInteger, tmpInteger2, tmpInteger3)
endfunction

private function GenerateSpell takes SkillMenuAbility skillMenuAbility, integer slot, integer counter returns nothing
    set tmpInteger = skillMenuAbility
    set tmpInteger2 = slot
    set tmpInteger3 = counter
    call NewOpLimit(function GenerateSpellNewOpLimit)
endfunction

private function GenerateSpells takes nothing returns nothing
    local integer i = 0
    local integer j = 0
    local integer max2 = 0
    local integer counter = 0
    local integer abilityId = 0
    
    call FileStart()
    call FileWriteLine("<!-- Spells generated with chat command \"-website\". -->")
    
    set i = 0
    loop
        exitwhen (i == WoWReforgedSkillMenu_MAX_SLOTS)
        set j = 0
        set max2 = GetLearnableAbilityIdsCount(i)
        loop
            exitwhen (j == max2)
            call GenerateSpell(GetLearnableAbilityId(i, j), i, counter)
            set counter = counter + 1
            set j = j + 1
        endloop
        set i = i + 1
    endloop
    
    set i = 0
    set max2 = GetAbilitiesMax()
    loop
        exitwhen (i == max2)
        set abilityId = GetAbility(i)
        call FileWriteLine("<tr id=\"" + A2S(abilityId) + "\">")
        // icon
        call FileWriteLine("<td data-order=\"" + I2S(counter) + "\">")
        //call IconToHtml(abilityId)
        call WriteAbilityPopoverWithIcon(abilityId, "spells.html")
        call FileWriteLine("</td>")
        // name
        call FileWriteLine("<td>")
        call FileWriteLine(GetObjectName(abilityId))
        call FileWriteLine("</td>")
        // race
        call FileWriteLine(ColumnDataOrder(I2S(GetAbilityRace(i)), GetRaceName(GetAbilityRace(i))))
        call RaceIconToHtml(GetAbilityRace(i))
        call FileWriteLine("</td>")
        
        // hero
        call FileWriteLine("<td>")
        call FileWriteLine("no")
        call FileWriteLine("</td>")

        // slot
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")

        // levels
        //call FileWriteLine("<td>")
        //call FileWriteLine(I2S(GetAbilityLevels(i)))
        //call FileWriteLine("</td>")
        
        // equipment bag
        call FileWriteLine("<td>")
        call FileWriteLine("-")
        call FileWriteLine("</td>")
        
        call FileWriteLine("</tr>")
        
        set counter = counter + 1
        
        set i = i + 1
    endloop

    call FileWriteLine("<!-- Spells generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Spells.txt")
endfunction

private function GenerateMountEx takes integer i returns nothing
    local integer max = 0
    local integer j = 0
    local integer maxHeroSpells = 0
    local integer abilityId = 0
    local unit mount = CreateTmpUnit(GetMountType(i).unitTypeId)
    call FileWriteLine("<tr id=\"" + A2S(GetUnitTypeId(mount)) + "\">")
    
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(i), GetObjectName(GetMountType(i).unitTypeId)))
    call WriteUnitPopoverWithIcon(GetMountType(i).unitTypeId, "items.html")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitName(mount))
    call FileWriteLine("</td>")
    
    // abilities
    call FileWriteLine("<td>")
    call FileWriteLine("<div class=\"spells\">")
    set j = 0
    loop
        exitwhen (j == MAX_UNIT_ABILITIES)
        set abilityId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(mount, j))
        if (abilityId != 0 and IsValidAbility(abilityId)) then
            call IconToHtmlEx(abilityId, "spells.html")
        endif
        set j = j + 1
    endloop
    call FileWriteLine("</div>")
    call FileWriteLine("</td>")

    // move type
    call FileWriteLine("<td>")
    call FileWriteLine(GetMoveType(mount))
    call FileWriteLine("</td>")
    
    // move speed
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(GetUnitMoveSpeed(mount))))
    call FileWriteLine("</td>")

    // attack type
    call FileWriteLine("<td>")
    call GenerateAttackTypeCell(mount)
    call FileWriteLine("</td>")
    
    // attack speed
    call FileWriteLine("<td>")
    call FileWriteLine(R2SHtml(BlzGetUnitWeaponRealField(mount, UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN, 0)))
    call FileWriteLine("</td>")

    // attack range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitWeaponRealField(mount, UNIT_WEAPON_RF_ATTACK_RANGE, 0))))
    call FileWriteLine("</td>")
    
    // attack damage
    call FileWriteLine("<td>")
    call FileWriteLine(GetUnitDamage(mount))
    call FileWriteLine("</td>")

    // armor type
    call FileWriteLine("<td>")
    call GenerateArmorCell(mount)
    call FileWriteLine("</td>")
    
    // armor
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitArmor(mount))))
    call FileWriteLine("</td>")

    // day sight range
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(BlzGetUnitRealField(mount, UNIT_RF_SIGHT_RADIUS))))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    call RemoveUnit(mount)
    set mount = null
endfunction

private function GenerateMount takes nothing returns nothing
    call GenerateMountEx(tmpInteger)
endfunction

private function GenerateMounts takes nothing returns nothing
    local integer i = 0
    local integer max = GetMountTypesMax()
    
    call FileStart()
    call FileWriteLine("<!-- Mounts generated with chat command \"-website\". -->")

    set i = 0
    loop
        exitwhen (i == max)
        set tmpInteger = i
        call NewOpLimit(function GenerateMount)
        
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Mounts generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Mounts.txt")
endfunction

private function GenerateChatCommands takes nothing returns nothing
    local integer i = 0
    local integer max = QuestGetItemCount(udg_QuestChatCommands)
    
    call FileStart()
    call FileWriteLine("<!-- Chat Commands generated with chat command \"-website\". -->")
    call FileWriteLine("<ul>")
    loop
        exitwhen (i == max)
        call FileWriteLine("<li>" + GetLocalizedStringSafe(QuestItemGetDescription(QuestGetItem(udg_QuestChatCommands, i))) + "</li>")
        set i = i + 1
    endloop
    
    call FileWriteLine("</ul>")
    call FileWriteLine("<!-- Chat Commands generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-ChatCommands.txt")
endfunction

private function GenerateHeroJourney takes nothing returns nothing
    local integer i = 0
    local integer max = QuestGetItemCount(udg_QuestHeroJourney)
    
    call FileStart()
    call FileWriteLine("<!-- Hero journey generated with chat command \"-website\". -->")
    call FileWriteLine("<ul>")
    loop
        exitwhen (i == max)
        call FileWriteLine("<li>" + QuestItemGetDescription(QuestGetItem(udg_QuestHeroJourney, i)) + "</li>")
        set i = i + 1
    endloop
    
    call FileWriteLine("</ul>")
    call FileWriteLine("<!-- Hero journey generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-HeroJourney.txt")
endfunction

private function GenerateCredits takes nothing returns nothing
    local integer i = 0
    local integer max = QuestGetItemCount(udg_QuestCredits)
    
    call FileStart()
    call FileWriteLine("<!-- Credits generated with chat command \"-website\". -->")
    call FileWriteLine("<ul>")
    loop
        exitwhen (i == max)
        call FileWriteLine("<li>" + QuestItemGetDescription(QuestGetItem(udg_QuestCredits, i)) + "</li>")
        set i = i + 1
    endloop
    
    call FileWriteLine("</ul>")
    call FileWriteLine("<!-- Credits generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Credits.txt")
endfunction

private function GenerateZoneEx takes integer i returns nothing
    local Zone zone = GetZone(i)
    call FileWriteLine("<tr id=\"" + GetZoneId(zone) + "\">")

    // icon
    call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
    call Icon(GetZoneName(zone), GetZoneIcon(zone))
    call FileWriteLine("</td>")

    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetZoneName(zone))
    call FileWriteLine("</td>")
    
    // type
    call FileWriteLine("<td>")
    if (zone.zoneType == ZONE_TYPE_ZONE) then
        call FileWriteLine("Zone")
    elseif (zone.zoneType == ZONE_TYPE_CONTINENT) then
        call FileWriteLine("Continent")
    elseif (zone.zoneType == ZONE_TYPE_WORLD) then
        call FileWriteLine("World")
    else
        call FileWriteLine("???")
    endif
    call FileWriteLine("</td>")

    // size
    call FileWriteLine("<td>")
    call FileWriteLine(I2S(R2I(GetZoneTotalArea(zone) / bj_CELLWIDTH)))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateZoneOpLimit takes nothing returns nothing
    call GenerateZoneEx(tmpInteger)
endfunction

private function GenerateZone takes integer index returns nothing
    set tmpInteger = index
    call NewOpLimit(function GenerateZoneOpLimit)
endfunction

private function GenerateZones takes nothing returns nothing
    local integer i = 0
    local integer max = GetZonesMax()
    local Zone zone = 0
    
    call FileStart()
    call FileWriteLine("<!-- Zones generated with chat command \"-website\". -->")
    loop
        exitwhen (i == max)
        call GenerateZone(i)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Zones generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Zones.txt")
endfunction

private function GenerateRecipeEx takes integer i returns nothing
    local integer j = 0
    local integer max2 = 0
    
    call FileWriteLine("<tr id=\"" + A2S(GetRecipeUIItemTypeId(i)) + "\">")
            
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(i), GetObjectName(GetRecipeUIItemTypeId(i))))
    //call IconToHtml(itemTypeId)
    call WriteItemPopoverWithIcon(GetRecipeUIItemTypeId(i), "items.html") // BlzGetAbilityExtendedTooltip(GetRecipeUIItemTypeId(i), 0)
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetRecipeName(i))
    call FileWriteLine("</td>")
    
    // item/unit
    call FileWriteLine("<td>")
    if (GetRecipeIsUnit(i)) then
        call IconToHtmlEx(GetRecipeItemTypeId(i), "units.html")
    else
        call IconToHtmlEx(GetRecipeItemTypeId(i), "items.html")
    endif
    call FileWriteLine("</td>")
    
    // requirements
    call FileWriteLine("<td>")
    set j = 0
    set max2 = GetRecipeRequirementsCount(i)
    
    loop
        exitwhen (j == max2)
        call IconToHtmlEx(GetRecipeRequirementItemTypeId(i, j), "items.html")
        call FileWriteLine(" (" + I2S(GetRecipeRequirementCharges(i, j)) + ")")
        set j = j + 1
    endloop
    
     call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateRecipeNewOpLimit takes nothing returns nothing
    call GenerateRecipeEx(tmpInteger)
endfunction

private function GenerateRecipe takes integer recipe returns nothing
    set tmpInteger = recipe
    call NewOpLimit(function GenerateRecipeNewOpLimit)
endfunction

private function GenerateRecipes takes nothing returns nothing
    local integer i = 0
    local integer max = GetRecipesMax()
    
    call FileStart()
    call FileWriteLine("<!-- Recipes generated with chat command \"-website\". -->")
    loop
        exitwhen (i == max)
        if (not GetRecipeIsSpacer(i)) then
            call GenerateRecipe(i)
        endif
        set i = i + 1
    endloop

    call FileWriteLine("<!-- Recipes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Recipes.txt")
endfunction

private function GenerateResources takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    local integer r = 0
    
    call FileStart()
    call FileWriteLine("<!-- Resources generated with chat command \"-website\". -->")
    
    loop
        exitwhen (i == max)
        set r = GetResource(i)
        call FileWriteLine("<tr id=\"" + GetResourceName(r) + "\">")
            
        // icon
        call FileWriteLine("<td data-order=\"" + I2S(i) + "\">")
        call IconToHtmlEx3(GetResourceIcon(r), "resources.html", GetResourceName(r))
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine("<td>")
        call FileWriteLine(GetResourceName(r))
        call FileWriteLine("</td>")
        
        // gold exchange rate
        call FileWriteLine("<td>")
        call FileWriteLine(R2SW(GetResourceGoldExchangeRate(r), 0, 2))
        call FileWriteLine("</td>")
        
        // tax levels
        call FileWriteLine("<td>")
        if (r == Resources_GOLD) then
            call FileWriteLine("<ul>")
            call FileWriteLine("<li>")
            call FileWriteLine("0-150 Food: 100 percent income")
            call FileWriteLine("</li>")
            call FileWriteLine("<li>")
            call FileWriteLine("151-250 Food: 70 percent income")
            call FileWriteLine("</li>")
            call FileWriteLine("<li>")
            call FileWriteLine("251-600 Food: 40 percent income")
            call FileWriteLine("</li>")
            call FileWriteLine("</ul>")
        elseif (r == Resources_LUMBER) then
            call FileWriteLine("-")
        else
            call FileWriteLine("-")
        endif
        call FileWriteLine("</td>")
        
        // description
        call FileWriteLine("<td>")
        call FileWriteLine(GetResourceDescription(r))
        call FileWriteLine("</td>")

        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Resources generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Resources.txt")
endfunction

private function GenerateSkins takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxSkins()
    
    call FileStart()
    call FileWriteLine("<!-- Skins generated with chat command \"-website\". -->")
    
    loop
        exitwhen (i == max)
        call FileWriteLine("<tr id=\"" + A2S(GetSkinItemTypeId(i)) + "\">")
            
        // icon
        call FileWriteLine("<td>")
        call IconToHtml(GetSkinItemTypeId(i))
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine("<td>")
        call FileWriteLine(GetObjectName(GetSkinItemTypeId(i)))
        call FileWriteLine("</td>")

        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
    
    set i = 0
    set max = GetHeroesMax()
    loop
        exitwhen (i == max)
        call FileWriteLine("<tr id=\"" + A2S(GetHeroUnitType(i)) + "\">")
            
        // icon
        call FileWriteLine("<td>")
        call IconToHtml(GetHeroUnitType(i))
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine("<td>")
        call FileWriteLine(GetActualObjectName(GetHeroUnitType(i)))
        call FileWriteLine("</td>")

        call FileWriteLine("</tr>")
        
        set i = i + 1
    endloop
        
    call FileWriteLine("<!-- Skins generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Skins.txt")
endfunction

private function GenerateEquipment takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxEquipmentItemTypes()
    local integer itemTypeId = 0
    local item whichItem = null
    
    call FileStart()
    call FileWriteLine("<!-- Equipment generated with chat command \"-website\". -->")
    
    loop
        exitwhen (i == max)
        set itemTypeId = GetEquipmentItemTypeId(i)
        if (itemTypeId != 0) then
            set whichItem = CreateItem(itemTypeId, 0.0, 0.0)
            call FileWriteLine("<tr id=\"" + A2S(itemTypeId) + "\">")
                
            // icon
            call FileWriteLine("<td>")
            call IconToHtml(itemTypeId)
            call FileWriteLine("</td>")
            
            // name
            call FileWriteLine("<td>")
            call FileWriteLine(GetObjectName(itemTypeId))
            call FileWriteLine("</td>")
            
            // level
            call FileWriteLine("<td>")
            call FileWriteLine(I2S(GetItemLevel(whichItem)))
            call FileWriteLine("</td>")
            
            // tooltip
            //call FileWriteLine("<td>")
            //call FormatTooltip(BlzGetItemExtendedTooltip(whichItem))
            //call FileWriteLine("</td>")
            
            // gold cost
            call GenerateItemTypeIdGoldCost(itemTypeId)
            
            // lumber cost
            call GenerateItemTypeIdLumberCost(itemTypeId)
            
            // description
            call FileWriteLine("<td>")
            call FormatTooltip(BlzGetAbilityExtendedTooltip(itemTypeId, 0))
            call FileWriteLine("</td>")

            call FileWriteLine("</tr>")
            
            call RemoveItem(whichItem)
            set whichItem = null
        endif
        set i = i + 1
    endloop
        
    call FileWriteLine("<!-- Equipment generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Equipment.txt")
endfunction

private function GenerateAttribute takes integer attribute, integer index returns nothing
    call FileWriteLine("<tr id=\"" + I2S(index) + "\">")

    // icon
    call FileWriteLine("<td>")
    call FileWriteLine("<a href=\"" + I2S(index) + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetAttributeIcon(attribute) + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + GetAttributeName(attribute) + "\"")
    call FileWriteLine("alt=\"" + GetAttributeIcon(attribute) + "\"")
    call FileWriteLine("/></a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetAttributeName(attribute))
    call FileWriteLine("</td>")
    
    // description
    call FileWriteLine("<td>")
    call FormatTooltip(GetAttributeDescription(attribute))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateAttributes takes nothing returns nothing
    local integer i = 0
    local integer max = 0
    call FileStart()
    call FileWriteLine("<!-- Attributes generated with chat command \"-website\". -->")
    
    // Strength
    call FileWriteLine("<tr id=\"" + I2S(0) + "\">")

    // icon
    call FileWriteLine("<td>")
    call FileWriteLine("<a href=\"" + I2S(0) + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_STR)) + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + GetHeroAttributeName(GetHandleId(HERO_ATTRIBUTE_STR)) + "\"")
    call FileWriteLine("alt=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_STR)) + "\"")
    call FileWriteLine("/></a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetHeroAttributeName(GetHandleId(HERO_ATTRIBUTE_STR)))
    call FileWriteLine("</td>")
    
    // description
    call FileWriteLine("<td>")
    call FormatTooltip("Increases maximum hit points and hit points regeneration.")
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    // Agility
    call FileWriteLine("<tr id=\"" + I2S(1) + "\">")

    // icon
    call FileWriteLine("<td>")
    call FileWriteLine("<a href=\"" + I2S(1) + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_AGI)) + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"Agility\"")
    call FileWriteLine("alt=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_AGI)) + "\"")
    call FileWriteLine("/></a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetHeroAttributeName(GetHandleId(HERO_ATTRIBUTE_AGI)))
    call FileWriteLine("</td>")
    
    // description
    call FileWriteLine("<td>")
    call FormatTooltip("Increases the armor and attack speed.")
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    // Intelligence
    call FileWriteLine("<tr id=\"" + I2S(2) + "\">")

    // icon
    call FileWriteLine("<td>")
    call FileWriteLine("<a href=\"" + I2S(2) + "\">")
    call FileWriteLine("<img class=\"wowr-icon\" src=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_INT)) + "\" width=\"64\" height=\"64\"")
    call FileWriteLine("title=\"" + GetHeroAttributeName(GetHandleId(HERO_ATTRIBUTE_INT)) + "\"")
    call FileWriteLine("alt=\"" + GetHeroAttributeInfocardIcon(GetHandleId(HERO_ATTRIBUTE_INT)) + "\"")
    call FileWriteLine("/></a>")
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine("<td>")
    call FileWriteLine(GetHeroAttributeName(GetHandleId(HERO_ATTRIBUTE_INT)))
    call FileWriteLine("</td>")
    
    // description
    call FileWriteLine("<td>")
    call FormatTooltip("Increases the maximum mana and mana regeneration.")
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
    
    set max = GetMaxAttributes()
    set i = 0
    loop
        exitwhen (i == max)
        call GenerateAttribute(GetAttribute(i), i + 3)
        set i = i + 1
    endloop
    
    call FileWriteLine("<!-- Attributes generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Attributes.txt")
endfunction

function FirstUnitOfTypeId takes integer unitTypeId returns unit
    local group g = GetUnitsOfTypeIdAll(unitTypeId)
    local unit first = FirstOfGroup(g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    return first
endfunction

private function GenerateProperties takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxProperties()
    local Zone zone = 0
    local unit creep = null
    
    call FileStart()
    call FileWriteLine("<!-- Properties generated with chat command \"-website\". -->")
    
    loop
        exitwhen (i == max)
        call FileWriteLine("<tr id=\"" + A2S(GetProperty(i).unitTypeId) + "\">")
            
        // icon
        call FileWriteLine(ColumnDataOrder(I2S(i), GetObjectName(GetProperty(i).unitTypeId)))
        
        call FileWriteLine("<div class=\"wowr-popover-wrapper\">")
        
        // popover
        call FileWriteLine("<div class=\"wowr-popover\">")
        call IconToHtmlEx(GetProperty(i).unitTypeId, "buildings.html")
        // name
        call FileWriteLine(GetObjectName(GetProperty(i).unitTypeId))
        call FileWriteLine("<br/>")
        
        // gold cost
        call GenerateUnitTypeIdGoldCostPopover(GetProperty(i).purchaseUnitTypeId)

        // wood cost
        call GenerateUnitTypeIdLumberCostPopover(GetProperty(i).purchaseUnitTypeId)
        
        // tooltip
        call FileWriteLine("<br/>")
        call FormatTooltip(BlzGetAbilityExtendedTooltip(GetProperty(i).purchaseUnitTypeId, 0))
        call FileWriteLine("</div>")
        // popover end
        
        // icon
        call IconButton(GetProperty(i).unitTypeId)
        
        call FileWriteLine("</div>")
        
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine(ColumnDataOrder(I2S(i), GetObjectName(GetProperty(i).unitTypeId)))
        call FileWriteLine(GetObjectName(GetProperty(i).unitTypeId))
        call FileWriteLine("</td>")
        
        // gold
        call GenerateUnitTypeIdGoldCost(GetProperty(i).purchaseUnitTypeId)
        
        // lumber
        call GenerateUnitTypeIdLumberCost(GetProperty(i).purchaseUnitTypeId)
        
        // race
        call FileWriteLine(ColumnDataOrder(I2S(GetProperty(i).soldRace), GetRaceName(GetProperty(i).soldRace)))
        call RaceIconToHtml(GetProperty(i).soldRace)
        call FileWriteLine("</td>")
        
        // food made
        call GenerateUnitTypeIdFoodMade(GetProperty(i).unitTypeId)
        
        // resource
        call FileWriteLine("<td>")
        call IconToHtmlEx3(GetResourceIcon(GetProperty(i).resource), "resources.html", GetResourceName(GetProperty(i).resource))
        call FileWriteLine("</td>")
        
        // shipyard
        call FileWriteLine("<td>")
        if (GetProperty(i).shipyard) then
            call FileWriteLine("yes")
        else
            call FileWriteLine("-")
        endif
        call FileWriteLine("</td>")
        
        // location
        call FileWriteLine("<td>")
        
        set creep = FirstUnitOfTypeId(GetProperty(i).unitTypeId)
        set zone = GetZoneByCoordinates(GetUnitX(creep), GetUnitY(creep))
        set creep = null
        if (zone != 0) then
            call IconToHtmlEx4(GetZoneIcon(zone), "zones.html", GetZoneName(zone), GetZoneId(zone))
        else
            call FileWriteLine("-")
        endif
        call FileWriteLine("</td>")


        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
        
    call FileWriteLine("<!-- Properties generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-Properties.txt")
endfunction

private function GenerateRacingTracks takes nothing returns nothing
    local integer i = 0
    local integer max = GetRacingTracksCount()
    local RacingTrack t = 0
    
    call FileStart()
    call FileWriteLine("<!-- Racing tracks generated with chat command \"-website\". -->")
    
    loop
        exitwhen (i == max)
        set t = GetRacingTrack(i)
        call FileWriteLine("<tr id=\"" + A2S(t.itemTypeId) + "\">")
            
        // icon
        call FileWriteLine(ColumnDataOrder(I2S(i), GetObjectName(t.itemTypeId)))
        call WriteItemPopoverWithIcon(t.itemTypeId, "items.html")
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine(ColumnDataOrder(I2S(i), t.name))
        call FileWriteLine(t.name)
        call FileWriteLine("</td>")
        
        // gold
        call GenerateUnitTypeIdGoldCost(t.itemTypeId)
        
        // lumber
        call GenerateItemTypeIdLumberCost(t.itemTypeId)
        
        // trophies
        call FileWriteLine("<td>")
        call WriteItemPopoverWithIcon(t.firstPlaceTrophyItemTypeId, "items.html")
        call WriteItemPopoverWithIcon(t.secondPlaceTrophyItemTypeId, "items.html")
        call WriteItemPopoverWithIcon(t.thirdPlaceTrophyItemTypeId, "items.html")
        call FileWriteLine("</td>")
        
        // checkpoints
        call FileWriteLine("<td>")
        call FileWriteLine(I2S(t.checkpointsCounter ))
        call FileWriteLine("</td>")

        // distance
        call FileWriteLine("<td>")
        call FileWriteLine(I2S(R2I(GetRacingTrackDistance(t))))
        call FileWriteLine("</td>")
        
        // durations
        call FileWriteLine("<td>")
        call FileWriteLine(I2S(R2I(GetRacingTrackDuration(t))))
        call FileWriteLine("</td>")

        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
        
    call FileWriteLine("<!-- Racing tracks generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-RacingTracks.txt")
endfunction

private function GenerateSeason takes integer season, integer startDay, integer endDay returns nothing
    // icon
    call FileWriteLine(ColumnDataOrder(I2S(season), GetSeasonName(season)))
    call Icon(GetSeasonName(season), GetSeasonIcon(season))
    call FileWriteLine("</td>")
    
    // name
    call FileWriteLine(ColumnDataOrder(I2S(season), GetSeasonName(season)))
    call FileWriteLine(GetSeasonName(season))
    call FileWriteLine("</td>")
    
    // start day
    call FileWriteLine(ColumnDataOrder(I2S(season), I2S(startDay)))
    call FileWriteLine(I2S(startDay))
    call FileWriteLine(" day, ")
    call FileWriteLine(FormatTimeOfDayEx(0.0))
    call FileWriteLine("</td>")
    
    // end day
    call FileWriteLine(ColumnDataOrder(I2S(season), I2S(endDay)))
    call FileWriteLine(I2S(endDay))
    call FileWriteLine(" day, ")
    call FileWriteLine(FormatTimeOfDayEx(0.0))
    call FileWriteLine("</td>")

    call FileWriteLine("</tr>")
endfunction

private function GenerateCalendarEvents takes nothing returns nothing
    local integer i = 0
    local integer index = 0
    local integer max = GetCalendarEventsMax()
    local CalendarEvent t = 0
    
    call FileStart()
    call FileWriteLine("<!-- Calendar events generated with chat command \"-website\". -->")
    
    call FileWriteLine("<tr id=\"" + I2S(t) + "\">")
    
    // seasons
    call GenerateSeason(SEASON_SPRING, SPRING_DAY, SUMMER_DAY - 1)
    call GenerateSeason(SEASON_SUMMER, SUMMER_DAY, FALL_DAY - 1)
    call GenerateSeason(SEASON_FALL, FALL_DAY, DAYS_PER_YEAR - 1)
    call GenerateSeason(SEASON_WINTER, WINTER_DAY, SPRING_DAY - 1)
    
    loop
        exitwhen (i == max)
        set index = i + SEASON_WINTER
        set t = GetCalendarEvent(i)
        call FileWriteLine("<tr id=\"" + I2S(t) + "\">")
            
        // icon
        call FileWriteLine(ColumnDataOrder(I2S(index), GetLocalizedStringSafe(t.name)))
        call Icon(GetLocalizedStringSafe(t.name), t.icon)
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine(ColumnDataOrder(I2S(index), GetLocalizedStringSafe(t.name)))
        call FileWriteLine(GetLocalizedStringSafe(t.name))
        call FileWriteLine("</td>")
        
        // start day
        call FileWriteLine(ColumnDataOrder(I2S(index), I2S(t.startDay)))
        call FileWriteLine(I2S(t.startDay))
        call FileWriteLine(" day, ")
        call FileWriteLine(FormatTimeOfDayEx(t.startTimeOfDay))
        call FileWriteLine("</td>")
        
        // end day
        call FileWriteLine(ColumnDataOrder(I2S(index), I2S(t.endDay)))
        call FileWriteLine(I2S(t.endDay))
        call FileWriteLine(" day, ")
        call FileWriteLine(FormatTimeOfDayEx(t.endTimeOfDay))
        call FileWriteLine("</td>")

        call FileWriteLine("</tr>")
        set i = i + 1
    endloop
        
    call FileWriteLine("<!-- Calendar events generated with chat command \"-website\". -->")

    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-CalendarEvents.txt")
endfunction

private function GenerateChangeLogs takes nothing returns nothing
    local integer i = 0
    local integer max = GetMaxVersions()
    local integer j = 0
    local integer max2 = 0

    loop
        exitwhen (i == max)
        call FileStart()
        call FileWriteLine("<!-- ChangeLogs generated with chat command \"-website\". -->")
        
        set j = 0
        set max2 = QuestGetItemCount(GetVersionQuest(i))
        loop
            exitwhen (j == max2)
            call FileWriteLine("- " + QuestItemGetDescription(QuestGetItem(GetVersionQuest(i), j)))
            set j = j + 1
        endloop
            
        call FileWriteLine("<!-- ChangeLogs generated with chat command \"-website\". -->")

        // The line below creates the file at the specified location
        call FileSave("WorldOfWarcraftReforged-ChangeLog-" + QuestGetTitle(GetVersionQuest(i)) + ".txt")
        set i = i + 1
    endloop
endfunction

private function GenerateStartLocations takes nothing returns nothing
    local integer i = 0
    local integer index = 0
    local integer max = GetMaxStartLocations()
    local Zone zone = 0
    local string icon
    local string name
    local integer whichRace
    
    call FileStart()
    call FileWriteLine("<!-- StartLocations generated with chat command \"-website\". -->")
        
    loop
        exitwhen (i >= GetMaxStartLocations())
         call FileWriteLine("<tr id=\"" + I2S(index) + "\">")
    
        // icon
        call FileWriteLine(ColumnDataOrder(I2S(index), GetStartLocationName(i)))
        call Icon(GetStartLocationName(i), GetStartLocationIcon(i))
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine(ColumnDataOrder(I2S(i), GetStartLocationName(i)))
        call FileWriteLine(GetStartLocationName(i))
        call FileWriteLine("</td>")
        
        // zone
        set zone = GetZoneByCoordinates(GetStartLocationCoordinateX(i), GetStartLocationCoordinateY(i))
        if (zone != 0) then
            call FileWriteLine(ColumnDataOrder(I2S(index), GetZoneName(zone)))
            call IconToHtmlEx4(GetZoneIcon(zone), "zones.html", GetZoneName(zone), GetZoneId(zone))
        else
            call FileWriteLine(ColumnDataOrder(I2S(index), "-"))
            call FileWriteLine("-")
        endif
        call FileWriteLine("</td>")
        
        // has navy
        call FileWriteLine(ColumnDataOrder(I2S(index), "no"))
        call FileWriteLine("no")
        call FileWriteLine("</td>")
        
        // race
        call FileWriteLine(ColumnDataOrder(I2S(index), "-"))
        call FileWriteLine("-")
        call FileWriteLine("</td>")
        
        call FileWriteLine("</tr>")
        
        set index = index + 1
        set i = i + 1
    endloop
    
    set i = 0
    loop
        exitwhen (i == GetMaxComputerStartLocations())
        set zone = GetZoneByCoordinates(GetComputerStartLocation(i).x, GetComputerStartLocation(i).y)
        set icon = "???"
        if (zone != 0) then
            set icon = GetZoneIcon(zone)
        endif
        set name = "Computer Start Location " + I2S(i + 1)
        call FileWriteLine("<tr id=\"" + I2S(index) + "\">")
    
        // icon
        call FileWriteLine(ColumnDataOrder(I2S(index), name))
        call Icon(name, icon)
        call FileWriteLine("</td>")
        
        // name
        call FileWriteLine(ColumnDataOrder(I2S(i), name))
        call FileWriteLine(name)
        call FileWriteLine("</td>")
        
        // zone
        if (zone != 0) then
            call FileWriteLine(ColumnDataOrder(I2S(index), GetZoneName(zone)))
            call IconToHtmlEx4(GetZoneIcon(zone), "zones.html", GetZoneName(zone), GetZoneId(zone))
        else
            call FileWriteLine(ColumnDataOrder(I2S(index), "-"))
            call FileWriteLine("-")
        endif
        call FileWriteLine("</td>")
        
        // has shipyard
         if (udg_TownHallHasNavy[i]) then
            call FileWriteLine(ColumnDataOrder(I2S(index), "yes"))
            call FileWriteLine("yes")
        else
            call FileWriteLine(ColumnDataOrder(I2S(index), "no"))
            call FileWriteLine("no")
        endif
        call FileWriteLine("</td>")
        
        // race
        set whichRace = udg_TownHallRace[i]
        call FileWriteLine(ColumnDataOrder(I2S(whichRace), GetRaceName(whichRace)))
        call RaceIconToHtml(whichRace)
        call FileWriteLine("</td>")
        
        call FileWriteLine("</tr>")
        
        set index = index + 1
        set i = i + 1
    endloop
    
    // The line below creates the file at the specified location
    call FileSave("WorldOfWarcraftReforged-StartLocations.txt")
endfunction

private function TriggerConditionIsSinglePlayer takes nothing returns boolean
    local boolean result = bj_isSinglePlayer
    if (result) then
        return true
    endif
    
    call SimError(GetTriggerPlayer(), "Requires single player.")
    
    return false
endfunction

private function TriggerActionWebsite takes nothing returns nothing
    // Summon all bosses:
    call TimerStart(udg_BossDeathwingTimer, 0.0, false, null)
    call TimerStart(udg_BossCenariusTimer, 0.0, false, null)
    call TriggerSleepAction(1.0)
    call SetTimeOfDay(12.0)
    call SuspendTimeOfDay(true)
    
    call NewOpLimit(function GenerateClasses)
    call NewOpLimit(function GenerateClassesOverview)
    call NewOpLimit(function GenerateSpells)
    call NewOpLimit(function GenerateDamageCalculationTable)
    call NewOpLimit(function GenerateHeroes)
    call NewOpLimit(function GenerateMounts)
    call NewOpLimit(function GenerateBosses)
    call NewOpLimit(function GenerateUnits)
    call NewOpLimit(function GenerateBuildings)
    call NewOpLimit(function GenerateItems)
    call NewOpLimit(function GenerateProfessions)
    call NewOpLimit(function GenerateProfessionsOverview)
    call NewOpLimit(function GeneratePlayers)
    call NewOpLimit(function GenerateNpcs)
    call NewOpLimit(function GenerateQuests)
    call NewOpLimit(function GenerateInfoQuests)
    call NewOpLimit(function GenerateResearches)
    call NewOpLimit(function GenerateChatCommands)
    call NewOpLimit(function GenerateHeroJourney)
    call NewOpLimit(function GenerateCredits)
    call NewOpLimit(function GenerateZones)
    call NewOpLimit(function GenerateRecipes)
    call NewOpLimit(function GenerateResources)
    call NewOpLimit(function GenerateSkins)
    call NewOpLimit(function GenerateEquipment)
    call NewOpLimit(function GenerateAttributes)
    call NewOpLimit(function GenerateProperties)
    call NewOpLimit(function GenerateRacingTracks)
    call NewOpLimit(function GenerateCalendarEvents)
    call NewOpLimit(function GenerateChangeLogs)
    call NewOpLimit(function GenerateStartLocations)
    call NewOpLimit(function GenerateRaces)

    call SuspendTimeOfDay(false)
    
    /*
    call BJDebugMsg("String token 0 " + StringSplit("1|n|n|n2", 0, "|n") + " and token 3 " + StringSplit("1|n|n|n2", 3, "|n"))
    call BJDebugMsg("String token 0 " + StringSplit("1|n2|n3|n4", 0, "|n") + " and token 3 " + StringSplit("1|n2|n3|n4", 3, "|n"))
    call BJDebugMsg("String count: " + I2S(StringCount("|n|n|n", "|n")))
    call BJDebugMsg("Icon path: " + GetIconPath('R02Q'))
    */
endfunction

private function Init takes nothing returns nothing
    local player slotPlayer = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (GetPlayerController(slotPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING) then
            call TriggerRegisterPlayerChatEvent(chatCommandTrigger, slotPlayer, "-website", true)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    call TriggerAddCondition(chatCommandTrigger, Condition(function TriggerConditionIsSinglePlayer))
    call TriggerAddAction(chatCommandTrigger, function TriggerActionWebsite)
    
    call AddIgnoredAbility('A1YZ')
    call AddIgnoredAbility('A02Z')
    call AddIgnoredAbility('AInv')
    call AddIgnoredAbility('AHer')
    call AddIgnoredAbility('Aatk')
    call AddIgnoredAbility('Amov')
    call AddIgnoredAbility('Achd')
    call AddIgnoredAbility('Abdt')
    call AddIgnoredAbility('BHad')
    call AddIgnoredAbility('Aalr')
    call AddIgnoredAbility('Afih')
    call AddIgnoredAbility('Afio')
    call AddIgnoredAbility('Afin')
    call AddIgnoredAbility('Asei')
    call AddIgnoredAbility('Asel')
    call AddIgnoredAbility('Afiu')
    call AddIgnoredAbility('Aque')
    call AddIgnoredAbility('Advc')
    call AddIgnoredAbility('Srtt')
    call AddIgnoredAbility('Sch2')
    call AddIgnoredAbility('Amai')
    call AddIgnoredAbility('Aupg')
    call AddIgnoredAbility('Atol')
    call AddIgnoredAbility('A07A')
    call AddIgnoredAbility('BNpi')
    call AddIgnoredAbility('S000')
    call AddIgnoredAbility('BUtt')
    call AddIgnoredAbility('BUau')
    call AddIgnoredAbility('Bakb')
    call AddIgnoredAbility('BOac')
    call AddIgnoredAbility('Sch3')
    call AddIgnoredAbility('ACsp')
    call AddIgnoredAbility('BEah')
    call AddIgnoredAbility('BHab')
    call AddIgnoredAbility('BUav')
    call AddIgnoredAbility('Abun')
    call AddIgnoredAbility('BOae')
    call AddIgnoredAbility('BEar')
    call AddIgnoredAbility('S00G')
    call AddIgnoredAbility('Ablr')
    call AddIgnoredAbility('S00T')
    call AddIgnoredAbility('Sch5')
    call AddIgnoredAbility('A0NY')
    call AddIgnoredAbility('Aegm')
    call AddIgnoredAbility('A0O3')
    call AddIgnoredAbility('S013')
    call AddIgnoredAbility('A09X')
    call AddIgnoredAbility('A1ZN')
    call AddIgnoredAbility('A0P8')
    call AddIgnoredAbility('S004')
    call AddIgnoredAbility('S01B')
    call AddIgnoredAbility('S00L')
    call AddIgnoredAbility('S014')
    call AddIgnoredAbility('Sch4')
    call AddIgnoredAbility('A1EE')
    call AddIgnoredAbility('A1V5')
    call AddIgnoredAbility('S00S')
    call AddIgnoredAbility('S00W')
    call AddIgnoredAbility('S011')
    call AddIgnoredAbility('S012')
    call AddIgnoredAbility('S015')
    call AddIgnoredAbility('o04S')
    call AddIgnoredAbility('Aphx')
    call AddIgnoredAbility('Bphx')
    call AddIgnoredAbility('Adt1')
    call AddIgnoredAbility('Asp1')
    call AddIgnoredAbility('S00Z')
    call AddIgnoredAbility('BUts')
    call AddIgnoredAbility('A0O5')
    call AddIgnoredAbility('S016')
    call AddIgnoredAbility('S01M')
    call AddIgnoredAbility('A0BD')
    call AddIgnoredAbility('S01F')
    call AddIgnoredAbility('Bmil')
    call AddIgnoredAbility('S01G')
    call AddIgnoredAbility('S00P')
    call AddIgnoredAbility('A0C0')
    call AddIgnoredAbility('S01A')
    call AddIgnoredAbility('A1E6')
    call AddIgnoredAbility('Amgi')
    call AddIgnoredAbility('A1ZO')
endfunction

endlibrary
