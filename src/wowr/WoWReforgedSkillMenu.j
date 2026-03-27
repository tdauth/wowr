library WoWReforgedSkillMenu initializer Init requires SimError MathUtils, ForceUtils,, HideAbility, WoWReforgedAbilitySkill, WoWReforgedAccount
/*
Custom skill menu which allows changing any slot ability of a corresponding hero.
This is based on unit abilities rather than hero abilities which allows us to use more than 5 slots on the UI.

The skill menu has 3 different views:
- All learned abilities.
- One single learned ability of a specific slot.
- All possible learnable abilities for a specific slot.

Sources:
- https://www.hiveworkshop.com/threads/the-mysteries-of-the-spellbook.33039/
- https://www.hiveworkshop.com/threads/learn-spells-in-spell-book.326702/
*/

globals
    private constant integer MAX_ALLOWED_UNIT_TYPES = 10
endglobals

struct SkillMenuAbility
    integer abilityId
    boolean forbidEquipmentBag = false
    boolean heroesOnly = false
    integer array allowedUnitTypeIds[MAX_ALLOWED_UNIT_TYPES]
    integer array allowedUnitTypeIds2[MAX_ALLOWED_UNIT_TYPES]
    integer array mappedAbilityIds[MAX_ALLOWED_UNIT_TYPES]
    integer allowedUnitTypeIdsCounter = 0
    
    method addAllowedUnitTypeId takes integer unitTypeId, integer unitTypeId2, integer allowedAbilityId returns nothing
        local integer c = this.allowedUnitTypeIdsCounter
        set this.allowedUnitTypeIds[c] = unitTypeId
        set this.allowedUnitTypeIds2[c] = unitTypeId2
        set this.mappedAbilityIds[c] = allowedAbilityId
        set this.allowedUnitTypeIdsCounter = c + 1
    endmethod
    
    method matchingAbilityId takes integer unitTypeId returns integer
        local integer i = 0
        if (this.allowedUnitTypeIdsCounter > 0) then
            loop
                exitwhen (i == this.allowedUnitTypeIdsCounter)
                if (this.allowedUnitTypeIds[i] == unitTypeId or this.allowedUnitTypeIds2[i] == unitTypeId) then
                    return this.mappedAbilityIds[i]
                endif
                set i = i + 1
            endloop
            return 0
        endif
        return this.abilityId
    endmethod
    
    method available takes integer unitTypeId returns boolean
        return matchingAbilityId(unitTypeId) != 0
    endmethod
    
    public static method create takes integer id returns thistype
        local thistype this = thistype.allocate()
        set this.abilityId = id
        return this
    endmethod
    
endstruct

globals
    private constant integer MODE_CURRENTLY_LEARNED_ABILITIES = 0
    private constant integer MODE_SINGLE_ABILITY = 1
    private constant integer MODE_ALL_ABILITIES_FOR_SPECIFIC_SLOT = 2
    
    private constant integer ABILITY_HERO_ABILITIES_HIDDEN = 'A0XJ' // Second spell book ability with same order ID and more abilities.
    private constant integer ABILITY_HERO_ABILITY_PLACEHOLDER = 'A0W3' // Add to any hero to show unspend skill points on the hero icon.

    private constant integer ABILITY_SLOT_1 = 'A0VL'
    private constant integer ABILITY_SLOT_2 = 'A0VV'
    private constant integer ABILITY_SLOT_3 = 'A0W4'
    private constant integer ABILITY_SLOT_4 = 'A0WG'
    private constant integer ABILITY_SLOT_5 = 'A0WT'
    private constant integer ABILITY_SLOT_6 = 'A0X1'
    private constant integer ABILITY_SLOT_7 = 'A0X2'
    private constant integer ABILITY_SLOT_8 = 'A0XM'
    private constant integer ABILITY_SLOT_9 = 'A0Y9'
    private constant integer ABILITY_SLOT_10 = 'A0YA'
    private constant integer ABILITY_SLOT_11 = 'A0YC'
    
    public constant integer MAX_SLOTS = 11
    private constant integer SLOTS_PER_PAGE = MAX_SLOTS - 3 // Back, Next/Previous Page
    
    private constant integer ABILITY_PLACEHOLDER = 'A0VS'
    private constant integer ABILITY_PLACE_HOLDER_SPELLBOOK = 'A03S'
    
    private constant integer ABILITY_INCREASE_ABILITY_LEVEL = 'A0VQ'
    private constant integer ABILITY_INCREASE_ABILITY_LEVEL_SPELLBOOK = 'A03T'
    
    private constant integer ABILITY_DECREASE_ABILITY_LEVEL = 'A0W0'
    private constant integer ABILITY_DECREASE_ABILITY_LEVEL_SPELLBOOK = 'A03X'
    
    constant integer ABILITY_AUTO_SKILL = 'A1XA'
    
    constant integer ABILITY_MATCHING_CLASS = 'A03N'
    private constant integer ABILITY_MATCHING_CLASS_SPELL_BOOK = 'A03O'
    
    constant integer ABILITY_RANDOM_CLASS = 'A08Y'
    private constant integer ABILITY_RANDOM_CLASS_SPELL_BOOK = 'A0AE'
    
    constant integer ABILITY_RANDOMIZE_SPELLS = 'A14U'
    
    constant integer ABILITY_RANDOM_SPELL = 'A0A7'
    private constant integer ABILITY_RANDOM_SPELL_SPELL_BOOK = 'A0AF'
    
    constant integer ABILITY_NEXT_SPELL_VARIATION = 'A0CQ'
    private constant integer ABILITY_NEXT_SPELL_VARIATION_SPELL_BOOK = 'A0DH'
    
    private constant integer ABILITY_BACK = 'A0VZ'
    private constant integer ABILITY_BACK_SPELLBOOK = 'A034'
    
    private constant integer ABILITY_NEXT_PAGE = 'A0WU'
    private constant integer ABILITY_NEXT_PAGE_SPELL_BOOK = 'A03E'
    
    private constant integer ABILITY_PREVIOUS_PAGE = 'A0WX'
    private constant integer ABILITY_PREVIOUS_PAGE_SPELL_BOOK = 'A03G'
    
    private SkillMenuAbility array learnableAbilityIds
    private integer array learnableAbilityIdsCounter
    private SkillMenuAbility lastAddedAbility = 0
    
    private integer array slotAbilityIds
    private hashtable h = InitHashtable()
    private trigger channelTrigger = CreateTrigger()
endglobals

function OpenSkillMenu takes unit whichUnit returns nothing
    local player whichPlayer = GetOwningPlayer(whichUnit)
    //call TriggerSleepAction(0.03)
    // Reopen spell book.
    //call BJDebugMsg("Opening skill menu by forcing player " + GetPlayerName(GetOwningPlayer(whichUnit)) + " hotkey J")
    if (IsUnitSelected(whichUnit, whichPlayer)) then
        //call ForceUIKeyBJ(whichPlayer, "Q")
        call ForceUIKeyBJ(whichPlayer, "Q") // Make sure that this hotkey is not used by any of the placeholder or other skill menu abilities to prevent endless clicks.
    endif
    set whichPlayer = null
endfunction

function OpenSkillMenuTwice takes unit whichUnit returns nothing
    local player whichPlayer = GetOwningPlayer(whichUnit)
    //call TriggerSleepAction(0.03)
    // Reopen spell book.
    //call BJDebugMsg("Opening skill menu by forcing player " + GetPlayerName(GetOwningPlayer(whichUnit)) + " hotkey J")
    if (IsUnitSelected(whichUnit, whichPlayer)) then
        call ForceUIKeyBJ(whichPlayer, "Q")
        call ForceUIKeyBJ(whichPlayer, "Q") // Make sure that this hotkey is not used by any of the placeholder or other skill menu abilities to prevent endless clicks.
    endif
    set whichPlayer = null
endfunction

private function HideSpellBookAbility takes unit whichUnit, integer abilityId, boolean hide returns nothing
    if (hide) then
        call UnitRemoveAbility(whichUnit, abilityId)
    else
        call UnitAddAbility(whichUnit, abilityId)
        call UnitMakeAbilityPermanent(whichUnit, true, abilityId)
    endif
endfunction

private function HidePlaceholderAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_PLACE_HOLDER_SPELLBOOK, hide)
endfunction

private function HideIncreaseAbilityLevelAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_INCREASE_ABILITY_LEVEL_SPELLBOOK, hide)
endfunction
    
private function HideDecreaseAbilityLevelAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_DECREASE_ABILITY_LEVEL_SPELLBOOK, hide)
endfunction

private function HideMatchingClassAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_MATCHING_CLASS_SPELL_BOOK, hide)
endfunction

private function HideRandomClassAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_RANDOM_CLASS_SPELL_BOOK, hide)
endfunction

private function HideRandomSpellAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_RANDOM_SPELL_SPELL_BOOK, hide)
endfunction

private function HideNextSpellVariationAbility takes unit whichUnit, boolean hide returns nothing
    //call HideSpellBookAbility(whichUnit, ABILITY_NEXT_SPELL_VARIATION_SPELL_BOOK, hide) // TODO This ability somehow crashes when made visible
endfunction

private function HideBackAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_BACK_SPELLBOOK, hide)
endfunction

private function HideNextPageAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_NEXT_PAGE_SPELL_BOOK, hide)
endfunction

private function HidePreviousPageAbility takes unit whichUnit, boolean hide returns nothing
    call HideSpellBookAbility(whichUnit, ABILITY_PREVIOUS_PAGE_SPELL_BOOK, hide)
endfunction

private function GetMaxPagesForSlot takes integer slot returns integer
    local integer count = learnableAbilityIdsCounter[slot]
    local integer pages = count / SLOTS_PER_PAGE
    if (ModuloInteger(count, SLOTS_PER_PAGE) > 0) then
        set pages = pages + 1
    endif
    return pages
endfunction

function GetLearnableAbilityId takes integer slot, integer i returns SkillMenuAbility
    return learnableAbilityIds[Index2D(i, slot, MAX_SLOTS)]
endfunction

function GetLearnableAbilityIdsCount takes integer slot returns integer
    return learnableAbilityIdsCounter[slot]
endfunction

function AddLearnableAbilityId takes integer slot, integer abilityId returns integer
    local integer count = learnableAbilityIdsCounter[slot]
    set lastAddedAbility = SkillMenuAbility.create(abilityId)
    set learnableAbilityIds[Index2D(count, slot, MAX_SLOTS)] = lastAddedAbility
    set learnableAbilityIdsCounter[slot] = count + 1
    
    return count
endfunction

function AddAllowedUnitType takes integer unitTypeId, integer unitTypeId2, integer allowedAbilityId returns nothing
    call lastAddedAbility.addAllowedUnitTypeId(unitTypeId, unitTypeId2, allowedAbilityId)
endfunction

function SetAbilityForHeroesOnly takes nothing returns nothing
    set lastAddedAbility.heroesOnly = true
endfunction

function GetLearnableAbilitByAbilityId takes integer slot, integer abilityId returns SkillMenuAbility
    local SkillMenuAbility a = 0
    local integer i = 0
    local integer max = GetLearnableAbilityIdsCount(slot)
    loop
        exitwhen (i == max)
        set a = GetLearnableAbilityId(slot, i)
        if (a.abilityId == abilityId) then
            return a
        endif
        set i = i + 1
    endloop
    return 0
endfunction

struct SkillMenu
    unit hero
    integer slot = 0
    integer mode = MODE_CURRENTLY_LEARNED_ABILITIES
    integer page = 0
    SkillMenuAbility array abilityIds[MAX_SLOTS] // all learned/not yet learned abilities for all the slots
    integer array abilityLevels[MAX_SLOTS] // all learned/not yet learned abilities for all the slots, store them for transfer
    SkillMenuAbility array skillableAbilityIds[MAX_SLOTS] // for choosing another ability for the current slot
endstruct

private function GetAbilityIdSlot takes integer abilityId returns integer
    local integer i = 0
    local integer max = MAX_SLOTS
    loop
        exitwhen (i == max)
        if (slotAbilityIds[i] == abilityId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

private function GetSlotAbilityId takes integer slot returns integer
    return slotAbilityIds[slot]
endfunction

function GetSkillMenu takes unit whichUnit returns SkillMenu
    return LoadInteger(h, GetHandleId(whichUnit), 0)
endfunction

private function HideAllSlotsAbilitiesUpTo takes unit whichUnit, integer max, boolean hide returns nothing
    local integer i = 0
    //call BJDebugMsg("Hide all slot abilities up to " + I2S(max) + " " + B2S(hide))
    loop
        exitwhen (i == max)
         call UnitHideAbilitySafely(whichUnit, slotAbilityIds[i], hide)
        set i = i + 1
    endloop
endfunction

private function HideAllSlotsAbilities takes unit whichUnit, boolean hide returns nothing
    call HideAllSlotsAbilitiesUpTo(whichUnit, MAX_SLOTS, hide)
endfunction

private function ChangeAbilityToOtherAbility takes unit whichUnit, integer abilityId, integer sourceAbilityId returns nothing
    local ability a = BlzGetUnitAbility(whichUnit, abilityId)
    local integer level = 0
    if (a != null) then
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_ICON_NORMAL, 0, BlzGetAbilityIcon(sourceAbilityId))
        set level = GetUnitAbilitySkillLevel(whichUnit, sourceAbilityId)
        if (level > 0) then
            call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("ABILITY_LEVEL_X")).s(GetObjectName(sourceAbilityId)).i(level).result())
        else
            call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("LEARN_ABILITY_X")).s(GetObjectName(sourceAbilityId)).result())
        endif
        if (HasAbilitySkillExtendedTooltip(sourceAbilityId, 0)) then
            call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, FormatAbilityTooltip(whichUnit, sourceAbilityId, 1, GetLocalizedString(GetAbilitySkillExtendedTooltip(sourceAbilityId, 0))))
        else
            call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, BlzGetAbilityExtendedTooltip(sourceAbilityId, 0))
        endif
        
        // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
        //call IncUnitAbilityLevel(whichUnit, abilityId)
        //call DecUnitAbilityLevel(whichUnit, abilityId)
    else
        call BJDebugMsg("WARNING: Unit " + GetUnitName(whichUnit) + " (" + A2S(GetUnitTypeId(whichUnit)) + ") of player " + GetPlayerName(GetOwningPlayer(whichUnit)) + ") has no ability " + GetObjectName(abilityId))
    endif
endfunction

private function GetSlotIcon takes integer slot returns string
    return "ReplaceableTextures\\CommandButtons\\BTN" + I2S(slot + 1) + ".blp"
endfunction

private function ResetSlotAbility takes unit whichUnit, integer slot returns nothing
    local ability a = BlzGetUnitAbility(whichUnit, slotAbilityIds[slot])
    call BlzSetAbilityStringLevelField(a, ABILITY_SLF_ICON_NORMAL, 0, GetSlotIcon(slot))
    call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, GetObjectName(slotAbilityIds[slot]))
    call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, GetLocalizedString("CLICK_TO_CHANGE_ABILITY"))

    // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
    //call IncUnitAbilityLevel(whichUnit, slotAbilityIds[i])
    //call DecUnitAbilityLevel(whichUnit, slotAbilityIds[i])
endfunction

private function UpdatePageAbilities takes unit whichUnit returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local ability a = null
    local integer maxPages = 0
    if (skillMenu != 0) then
        set maxPages = GetMaxPagesForSlot(skillMenu.slot)
        set a = BlzGetUnitAbility(whichUnit, ABILITY_NEXT_PAGE)
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("NEXT_PAGE_X_Y")).i(skillMenu.page + 1).i(maxPages).result())
        set a = BlzGetUnitAbility(whichUnit, ABILITY_PREVIOUS_PAGE)
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("PREVIOUS_PAGE_X_Y")).i(skillMenu.page + 1).i(maxPages).result())
    endif

    // Required for all entries where "Set works by set level" is 1 but "Set works directly" is 0: https://www.hiveworkshop.com/pastebin/b2769ab71109c3634b3115937deaa34a.24187
    //call IncUnitAbilityLevel(whichUnit, slotAbilityIds[i])
    //call DecUnitAbilityLevel(whichUnit, slotAbilityIds[i])
endfunction

private function UpdateCurrentlySkilledAbilities takes SkillMenu skillMenu returns nothing
    local integer i = 0
    //call BJDebugMsg("Updating currently skilled abilities.")
    loop
        exitwhen (i == MAX_SLOTS)
        if (skillMenu.abilityIds[i] != 0) then
            //call BJDebugMsg("Change " + GetObjectName(slotAbilityIds[i]) + " for unit " + GetUnitName(skillMenu.hero) + " to ability " + GetObjectName(skillMenu.abilityIds[i].abilityId))
            call ChangeAbilityToOtherAbility(skillMenu.hero, slotAbilityIds[i], skillMenu.abilityIds[i].abilityId)
        else
            //call BJDebugMsg("Resetting slot ability for slot " + I2S(i) + " for hero " + GetUnitName(skillMenu.hero))
            call ResetSlotAbility(skillMenu.hero, i)
        endif
        set i = i + 1
    endloop
endfunction

// TODO Seems to be lagging when clicking on back. The spell book is not reopened and we have to stop the hero. Initial call seems to work?
function ShowCurrentlySkilledAbilities takes unit whichUnit returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    set skillMenu.mode = MODE_CURRENTLY_LEARNED_ABILITIES
    set skillMenu.page = 0 // Reset page for different slots.
    //call BJDebugMsg("Show all currently skilled abilities: 1")
    call HidePlaceholderAbility(whichUnit, true)
    call HideIncreaseAbilityLevelAbility(whichUnit, true)
    call HideDecreaseAbilityLevelAbility(whichUnit, true)
    call HideNextPageAbility(whichUnit, true)
    call HidePreviousPageAbility(whichUnit, true)
    call HideBackAbility(whichUnit, true)
    call HideMatchingClassAbility(whichUnit, true)
    call HideRandomClassAbility(whichUnit, true)
    call HideRandomSpellAbility(whichUnit, true)
    call HideNextSpellVariationAbility(whichUnit, true)
    
    //call BJDebugMsg("Show all currently skilled abilities: 2")
    
    call HideAllSlotsAbilities(whichUnit, false)
    
    //call BJDebugMsg("Show all currently skilled abilities: 3")
    
    call UpdateCurrentlySkilledAbilities(skillMenu)
    //call BJDebugMsg("Show all currently skilled abilities: 4 for unit " + GetUnitName(whichUnit))
endfunction

private function ShowAllAbilitiesForSpecificSlot takes unit whichUnit, integer slot, integer page returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local integer i = 0
    local integer max = 0
    set skillMenu.mode = MODE_ALL_ABILITIES_FOR_SPECIFIC_SLOT
    set skillMenu.page = page
    
    call HidePlaceholderAbility(whichUnit, true)
    call HideIncreaseAbilityLevelAbility(whichUnit, true)
    call HideDecreaseAbilityLevelAbility(whichUnit, true)
    call HideMatchingClassAbility(whichUnit, true)
    call HideRandomClassAbility(whichUnit, true)
    call HideRandomSpellAbility(whichUnit, true)
    call HideNextSpellVariationAbility(whichUnit, true)
    
    call HideNextPageAbility(whichUnit, false)
    call HidePreviousPageAbility(whichUnit, false)
    call HideBackAbility(whichUnit, false)
    call HideAllSlotsAbilitiesUpTo(whichUnit, MAX_SLOTS - 3, false)
    
    call UpdatePageAbilities(whichUnit)
    
    //call BJDebugMsg("Show all possible abilities for slot " + I2S(slot) + " with page " + I2S(page))
    set i = 0
    loop
        exitwhen (i == MAX_SLOTS)
        set skillMenu.skillableAbilityIds[i] = 0
        set i = i + 1
    endloop
    set i = 0
    set max = IMinBJ(MAX_SLOTS - 3, GetLearnableAbilityIdsCount(slot) - page * SLOTS_PER_PAGE)
    loop
        exitwhen (i >= max)
        set skillMenu.skillableAbilityIds[i] = GetLearnableAbilityId(slot, page * SLOTS_PER_PAGE + i)
        if (skillMenu.skillableAbilityIds[i] != 0) then
            call ChangeAbilityToOtherAbility(whichUnit, GetSlotAbilityId(i), skillMenu.skillableAbilityIds[i].abilityId)
        else
            call ResetSlotAbility(whichUnit, i)
        endif
        set i = i + 1
    endloop
endfunction

function ShowSingleAbility takes unit whichUnit, integer slot returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local unit hero = skillMenu.hero
    local SkillMenuAbility a = skillMenu.abilityIds[slot]
    local integer abilityId = 0
    local integer level = 0
    local ability a1 = null
    local ability a2 = null
    if (a != 0) then
        set abilityId = a.abilityId
    endif
    set skillMenu.slot = slot
    set skillMenu.mode = MODE_SINGLE_ABILITY
    
    call HideAllSlotsAbilities(whichUnit, true)
    call HideNextPageAbility(whichUnit, true)
    call HidePreviousPageAbility(whichUnit, true)
    
    call HidePlaceholderAbility(whichUnit, false)
    call HideIncreaseAbilityLevelAbility(whichUnit, false)
    call HideDecreaseAbilityLevelAbility(whichUnit, false)
    call HideBackAbility(whichUnit, false)
    call HideMatchingClassAbility(whichUnit, false)
    call HideRandomClassAbility(whichUnit, false)
    call HideRandomSpellAbility(whichUnit, false)
    call HideNextSpellVariationAbility(whichUnit, false)

    set a2 = BlzGetUnitAbility(whichUnit, ABILITY_PLACEHOLDER) // assign after showing it
    
    if (abilityId != 0) then
        set level = GetUnitAbilitySkillLevel(hero, abilityId)
        // TODO Changing it of an ability with spell book with the same ID has no effect.
        call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_ICON_NORMAL, 0, BlzGetAbilityIcon(abilityId))
        
        if (level > 0) then
            call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("ABILITY_LEVEL_X")).s(GetObjectName(abilityId)).i(level).result())
        else
            call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL, 0, Format(GetLocalizedString("LEARN_ABILITY_X")).s(GetObjectName(abilityId)).result())
        endif
        
        if (GetUnitAbilityLevel(whichUnit, abilityId) > 0) then
            if (HasAbilitySkillExtendedTooltip(abilityId, 0)) then
                call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, FormatAbilityTooltip(hero, abilityId, level, GetLocalizedString(GetAbilitySkillExtendedTooltip(abilityId, 0))))
            else
                set a1 = BlzGetUnitAbility(hero, abilityId)
                call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, BlzGetAbilityStringLevelField(a1, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, IMinBJ(BlzGetAbilityIntegerField(a1, ABILITY_IF_LEVELS) - 1, level)))
            endif
        else
            if (HasAbilitySkillExtendedTooltip(abilityId, 0)) then
                call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, FormatAbilityTooltip(hero, abilityId, 0, GetLocalizedString(GetAbilitySkillExtendedTooltip(abilityId, 0))))
            else
                call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, BlzGetAbilityExtendedTooltip(abilityId, 0))
            endif
        endif
    else
        //call BJDebugMsg("Replace placeholder icon and tooltip.")
        call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_ICON_NORMAL, 0, GetSlotIcon(slot))
        call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL, 0, GetObjectName(slotAbilityIds[slot]))
        call BlzSetAbilityStringLevelField(a2, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, GetLocalizedString("CLICK_TO_CHANGE_ABILITY"))
        //call BJDebugMsg("After replacing placeholder icon and tooltip.")
    endif
    set hero = null
endfunction

function ReplaceAbility takes unit whichUnit, integer slot, SkillMenuAbility newAbility returns boolean
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local SkillMenuAbility oldAbility = 0
    local integer oldAbilityId = 0
    local integer oldLevel = 0
    local integer abilityId = 0
    //call BJDebugMsg("Changing ability for current slot with " + I2S(newAbility))
    if (skillMenu != 0) then
        if (newAbility != 0) then
            //call BJDebugMsg("Trying ability " + GetObjectName(newAbility.abilityId))
            if (not newAbility.heroesOnly or IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
                if (newAbility.available(GetUnitTypeId(whichUnit))) then
                    if (not newAbility.forbidEquipmentBag or GetUnitTypeId(whichUnit) != EQUIPMENT_BAG) then
                        set oldAbility = skillMenu.abilityIds[slot]
                        if (oldAbility != 0) then
                            set oldAbilityId = oldAbility.abilityId
                        endif
                        set skillMenu.abilityIds[slot] = newAbility
                        if (newAbility != 0) then
                            set abilityId = newAbility.abilityId
                        endif
                        //call BJDebugMsg("Changing ability of slot " + I2S(slot) + " to " + GetObjectName(abilityId))
                        if (oldAbilityId != 0) then
                            // restore the old level
                            set oldLevel = GetUnitAbilitySkillLevel(whichUnit, oldAbilityId)
                            //set oldLevel = skillMenu.abilityLevels[slot]
                            
                            // unskill and remove old ability
                            call SkillAbility(skillMenu.hero, oldAbilityId, 0)
                            if (GetUnitAbilityLevel(whichUnit, oldAbilityId) > 0) then
                                call UnitRemoveAbility(whichUnit, oldAbilityId)
                            endif
                            
                            if (oldLevel > 0) then
                                call UnitAddAbility(whichUnit, abilityId)
                                call UnitMakeAbilityPermanent(whichUnit, true, abilityId)
                                call SkillAbility(skillMenu.hero, abilityId, oldLevel)
                            endif
                        endif
                        return true
                    else
                        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("NO_SPELL_FOR_EQUIPMENT_BAG"))
                    endif
                else
                    call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("DOT_NOT_AVAILABLE"))
                endif
            else
                call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("DOT_NOT_AVAILABLE"))
            endif
        endif
    else
        call BJDebugMsg("Error: No skill menu for unit " + GetUnitName(whichUnit) + "!")
    endif
    return false
endfunction

function AbilityHasNoCooldown takes unit whichUnit, integer slot returns boolean
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    return skillMenu != 0 and skillMenu.abilityIds[slot] != 0 and skillMenu.abilityIds[slot].abilityId != 0 and BlzGetUnitAbilityCooldownRemaining(whichUnit, skillMenu.abilityIds[slot].abilityId) <= 0.0
endfunction

private function ChangeAbilityForCurrentSlot takes unit whichUnit, SkillMenuAbility newAbility returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    if (AbilityHasNoCooldown(whichUnit, skillMenu.slot)) then
        if (ReplaceAbility(whichUnit, skillMenu.slot, newAbility)) then
            call ShowSingleAbility(whichUnit, skillMenu.slot)
        endif
    else
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("ONE_ABILITY_HAS_COOLDOWN"))
    endif
endfunction

function ChangeAllSlotAbilities takes unit whichUnit, integer index returns nothing
    local integer i = 0
    if (GetSkillMenu(whichUnit) != 0) then
        loop
            exitwhen (i == MAX_SLOTS)
            if (GetLearnableAbilityId(i, index) != 0) then
                call ReplaceAbility(whichUnit, i, GetLearnableAbilityId(i, index))
            endif
            set i = i + 1
        endloop
    endif
endfunction

function GetHeroSkillPointsCustom takes unit hero returns integer
    return R2I(GetUnitAttribute(hero, udg_AttributeSkillPoints))
endfunction

function SetHeroSkillPoints takes unit hero, integer skillPoints returns nothing
    call SetUnitAttribute(hero, udg_AttributeSkillPoints, I2R(skillPoints))
    if (IsUnitType(hero, UNIT_TYPE_HERO)) then
        call UnitModifySkillPoints(hero, skillPoints - GetHeroSkillPoints(hero))
    endif
endfunction

function AddHeroSkillPoints takes unit hero, integer skillPoints returns nothing
    call AddUnitAttribute(hero, udg_AttributeSkillPoints, I2R(skillPoints))
    if (IsUnitType(hero, UNIT_TYPE_HERO)) then
        call UnitModifySkillPoints(hero, skillPoints)
    endif
endfunction

function RemoveHeroSkillPoints takes unit hero, integer skillPoints returns nothing
    call RemoveUnitAttribute(hero, udg_AttributeSkillPoints, I2R(skillPoints))
    if (IsUnitType(hero, UNIT_TYPE_HERO)) then
        call UnitModifySkillPoints(hero, -skillPoints)
    endif
endfunction

private function UpdateHeroSkillPoints takes unit hero returns nothing
    if (IsUnitType(hero, UNIT_TYPE_HERO)) then
        call UnitModifySkillPoints(hero, R2I(GetUnitAttribute(hero, udg_AttributeSkillPoints)) - GetHeroSkillPoints(hero))
    endif
endfunction

function AddWowReforgedSkillPointsInitial takes nothing returns nothing
    local integer skillPoints = SKILL_POINTS_PER_LEVEL
    if (skillPoints > 0) then
        call AddUnitAttribute(udg_TmpUnit, udg_AttributeSkillPoints, I2R(skillPoints))
        call UpdateHeroSkillPoints(udg_TmpUnit)
    endif
endfunction

function AddWowReforgedSkillPointsLevelUp takes nothing returns nothing
    local integer gainedHeroLevels = GetGainedHeroLevels(udg_TmpUnit)
    local integer skillPoints = gainedHeroLevels * SKILL_POINTS_PER_LEVEL
    //local integer actualAddedHeroSkillPoints = skillPoints - gainedHeroLevels
    //call BJDebugMsg("Level up for " + GetUnitName(udg_TmpUnit) + " with gained levels " + I2S(gainedHeroLevels) + " and skill points per level " + I2S(SKILL_POINTS_PER_LEVEL) + ": " + I2S(skillPoints) + " leading to actual added hero skill points: " + I2S(actualAddedHeroSkillPoints))
    if (skillPoints > 0) then
        call AddUnitAttribute(udg_TmpUnit, udg_AttributeSkillPoints, I2R(skillPoints))
        call UpdateHeroSkillPoints(udg_TmpUnit)
    endif
endfunction

// For auto skilling.
function IncreaseAbilityEx takes unit whichUnit, integer slot, boolean updateTooltip returns boolean
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local unit hero = skillMenu.hero
    local SkillMenuAbility a = skillMenu.abilityIds[slot]
    local integer abilityId = 0
    //call BJDebugMsg("Increase level slot " + I2S(slot))
    if (GetHeroSkillPointsCustom(hero) > 0) then
        if (a != 0) then
            set abilityId = a.abilityId
        endif
        if (abilityId != 0) then
            if (GetUnitAbilitySkillLevelSafe(hero, abilityId) < MAX_HERO_SPELL_LEVEL) then
                if (GetUnitAbilityLevel(hero, abilityId) <= 0) then
                    //call BJDebugMsg("Learning ability " + GetObjectName(abilityId))
                    call UnitAddAbility(hero, abilityId)
                    call UnitMakeAbilityPermanent(hero, true, abilityId)    
                endif
                //call BJDebugMsg("Increasing ability level to " + I2S(GetUnitAbilitySkillLevel(hero, abilityId) + 1))
                call SkillAbilityEx2(hero, abilityId, GetUnitAbilitySkillLevel(hero, abilityId) + 1, updateTooltip)
                set skillMenu.abilityLevels[slot] = skillMenu.abilityLevels[slot] + 1
                call RemoveHeroSkillPoints(hero, 1)
                
                return true
            else
                call SimError(GetOwningPlayer(whichUnit), Format(GetLocalizedString("REACHED_MAXIMUM_ABILITY_LEVEL")).i(MAX_HERO_SPELL_LEVEL).result())
            endif
        else
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("NO_ABILITY"))
        endif
    else
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("NOT_ENOUGH_SKILL_POINTS"))
    endif
    set hero = null
    return false
endfunction

function IncreaseAbility takes unit whichUnit, integer slot returns boolean
    local boolean result = IncreaseAbilityEx(whichUnit, slot, true)
    if (result) then
        call ShowSingleAbility(whichUnit, slot)
    endif
    
    return result
endfunction

function DecreaseAbilityEx takes unit whichUnit, integer slot, boolean updateTooltip returns boolean
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local unit hero = skillMenu.hero
    local SkillMenuAbility a = skillMenu.abilityIds[slot]
    local integer abilityId = 0
    //call BJDebugMsg("Decrease level slot " + I2S(slot))
    if (a != 0) then
        set abilityId = a.abilityId
    endif
    if (abilityId != 0) then
        if (GetUnitAbilitySkillLevel(hero, abilityId) > 0) then
            //call BJDebugMsg("Decreasing ability level to " + I2S(GetUnitAbilitySkillLevel(hero, abilityId) - 1) + " of ability " + GetObjectName(abilityId))
            call SkillAbilityEx2(hero, abilityId, GetUnitAbilitySkillLevel(hero, abilityId) - 1, updateTooltip)
            if (GetUnitAbilitySkillLevel(hero, abilityId) <= 0 and GetUnitAbilityLevel(hero, abilityId) > 0) then
                call UnitRemoveAbility(hero, abilityId)
            endif
            set skillMenu.abilityLevels[slot] = skillMenu.abilityLevels[slot] - 1
            call AddHeroSkillPoints(hero, 1)
            return true
        else
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("ABILITY_HAS_LEVEL_0"))
        endif
    else
        call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("NO_ABILITY"))
    endif
    set hero = null
    return false
endfunction

private function DecreaseAbility takes unit whichUnit, integer slot returns boolean
    local boolean result = DecreaseAbilityEx(whichUnit, slot, true)
    if (result) then
        call ShowSingleAbility(whichUnit, slot)
    endif
    
    return result
endfunction

private function TransferAllSkillMenuAbilities takes SkillMenu skillMenu returns nothing
    local unit hero = skillMenu.hero
    local SkillMenuAbility a = 0
    local integer abilityId = 0
    local integer i = 0
    loop
        exitwhen (i == MAX_SLOTS)
        set a = skillMenu.abilityIds[i]
        if (a != 0 and skillMenu.abilityLevels[i] > 0) then
            set abilityId = a.abilityId
            //call BJDebugMsg("Transfering ability " + GetObjectName(abilityId) + " with level " + I2S(skillMenu.abilityLevels[i]))
            call UnitAddAbility(hero, abilityId)
            call UnitMakeAbilityPermanent(hero, true, abilityId)
            call SkillAbility(hero, abilityId, skillMenu.abilityLevels[i])
        endif
        set i = i + 1
    endloop
    set hero = null
endfunction

function TransferSkillMenu takes integer sourceHandleId, integer targetHandleId, unit whichUnit returns nothing
    local SkillMenu skillMenu = LoadInteger(h, sourceHandleId, 0)
    //call BJDebugMsg("Transfering skill menu to " + GetUnitName(whichUnit) + ": " + I2S(skillMenu))
    if (skillMenu != 0) then
        call RemoveSavedInteger(h, sourceHandleId, 0)
        call SaveInteger(h, targetHandleId, 0, skillMenu)
        set skillMenu.hero = whichUnit
        if (whichUnit != null) then
            call TransferAllSkillMenuAbilities(skillMenu)
            call ShowCurrentlySkilledAbilities(whichUnit)
        endif
    endif
endfunction

function AddSkillMenu takes unit hero returns nothing
    local SkillMenu skillMenu = SkillMenu.create()
    local integer i = 0
    set skillMenu.hero = hero
    call SaveInteger(h, GetHandleId(hero), 0, skillMenu)
    call SetHeroSkillPoints(hero, GetHeroSkillPoints(hero))
    // Makes sure the abilities do not disappear after a hero transformation.
    call UnitMakeAbilityPermanent(hero, true, ABILITY_PLACEHOLDER)
    call UnitMakeAbilityPermanent(hero, true, ABILITY_INCREASE_ABILITY_LEVEL)
    call UnitMakeAbilityPermanent(hero, true, ABILITY_DECREASE_ABILITY_LEVEL)
    call UnitMakeAbilityPermanent(hero, true, ABILITY_AUTO_SKILL)
    //call UnitMakeAbilityPermanent(hero, true, ABILITY_BACK)
    call UnitMakeAbilityPermanent(hero, true, ABILITY_NEXT_PAGE)
    call UnitMakeAbilityPermanent(hero, true, ABILITY_PREVIOUS_PAGE)
    loop
        exitwhen (i == MAX_SLOTS)
        call UnitMakeAbilityPermanent(hero, true, slotAbilityIds[i])
        set i = i + 1
    endloop
    call ShowCurrentlySkilledAbilities(hero)
endfunction

function RemoveSkillMenu takes unit hero returns nothing
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        call FlushChildHashtable(h, GetHandleId(hero))
        call skillMenu.destroy()
    endif
endfunction

hook RemoveUnit RemoveSkillMenu

function ShowAbilityOrderId takes unit hero, integer abilityId returns nothing
    call BJDebugMsg(GetObjectName(abilityId) + ": " + BlzGetAbilityStringLevelField(BlzGetUnitAbility(hero, abilityId), ABILITY_SLF_BASE_ORDER_ID_NCL6, 0))
endfunction

function ShowAllAbilityOrderIds takes unit hero returns nothing
    local integer i = 0
    call BJDebugMsg("All ability order IDs:")
    loop
        exitwhen (i == MAX_SLOTS)
        call ShowAbilityOrderId(hero, slotAbilityIds[i])
        set i = i + 1
    endloop
    call ShowAbilityOrderId(hero, ABILITY_HERO_ABILITIES_HIDDEN)
    call ShowAbilityOrderId(hero, ABILITY_PLACEHOLDER)
    call ShowAbilityOrderId(hero, ABILITY_INCREASE_ABILITY_LEVEL)
    call ShowAbilityOrderId(hero, ABILITY_DECREASE_ABILITY_LEVEL)
    call ShowAbilityOrderId(hero, ABILITY_AUTO_SKILL)
    call ShowAbilityOrderId(hero, ABILITY_MATCHING_CLASS)
    call ShowAbilityOrderId(hero, ABILITY_RANDOM_CLASS)
    call ShowAbilityOrderId(hero, ABILITY_RANDOMIZE_SPELLS)
    call ShowAbilityOrderId(hero, ABILITY_NEXT_SPELL_VARIATION)
    call ShowAbilityOrderId(hero, ABILITY_BACK)
    call ShowAbilityOrderId(hero, ABILITY_NEXT_PAGE)
    call ShowAbilityOrderId(hero, ABILITY_PREVIOUS_PAGE)
endfunction

function UpdateSkillMenuLearnedAbilityTooltips takes unit hero returns nothing
    local integer i = 0
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        loop
            exitwhen (i == MAX_SLOTS)
            if (skillMenu.abilityIds[i] != 0) then
                //call BJDebugMsg("Level for hero " + GetUnitName(hero) + " of ability " + GetObjectName(skillMenu.abilityIds[i].abilityId) + ": " + I2S(GetUnitAbilitySkillLevelSafe(hero, skillMenu.abilityIds[i].abilityId)))
                call UpdateAbilityTooltip(hero, skillMenu.abilityIds[i].abilityId, BlzGetUnitAbility(hero, skillMenu.abilityIds[i].abilityId), GetUnitAbilitySkillLevelSafe(hero, skillMenu.abilityIds[i].abilityId))
            endif
            set i = i + 1
        endloop
    endif
endfunction

function UpdateSkillMenu takes unit hero returns nothing
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        if (skillMenu.mode == MODE_CURRENTLY_LEARNED_ABILITIES) then
            call ShowCurrentlySkilledAbilities(hero)
        elseif (skillMenu.mode == MODE_ALL_ABILITIES_FOR_SPECIFIC_SLOT) then
            call ShowAllAbilitiesForSpecificSlot(hero, skillMenu.slot, skillMenu.page)
        else
            call ShowSingleAbility(hero, skillMenu.slot)
        endif
    endif
endfunction

private function TimerFunctionAbility takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit caster = LoadUnitHandle(h, handleId, 0)
    local integer abilityId = LoadInteger(h, handleId, 1)
    local SkillMenu skillMenu = 0
    local integer slot = -1
    if (GetUnitTypeId(caster) != 0) then
        set skillMenu = GetSkillMenu(caster)
        if (skillMenu != 0) then
            //call ShowAllAbilityOrderIds(skillMenu.hero)
            set slot = GetAbilityIdSlot(abilityId)
            if (slot != -1) then
                //call BJDebugMsg("Click with slot " + I2S(slot))
                if (skillMenu.mode == MODE_CURRENTLY_LEARNED_ABILITIES) then
                    //call BJDebugMsg("Mode currently skilled.")
                    call ShowSingleAbility(caster, slot)
                    //call OpenSkillMenu(caster)
                elseif (skillMenu.mode == MODE_ALL_ABILITIES_FOR_SPECIFIC_SLOT and skillMenu.skillableAbilityIds[slot] != 0) then
                    //call BJDebugMsg("Mode specific abilities for slot. Changing current ability for specific slot")
                    call ChangeAbilityForCurrentSlot(caster, skillMenu.skillableAbilityIds[slot])
                    call OpenSkillMenuTwice(caster)
                else
                    //call BJDebugMsg("Ignore slot click with mode " + I2S(skillMenu.mode) + ".")
                endif
            elseif (abilityId == ABILITY_BACK) then
                if (skillMenu.mode == MODE_ALL_ABILITIES_FOR_SPECIFIC_SLOT) then
                    call ShowSingleAbility(caster, skillMenu.slot)
                    call OpenSkillMenuTwice(caster)
                elseif (skillMenu.mode == MODE_SINGLE_ABILITY) then
                    call ShowCurrentlySkilledAbilities(caster)
                    call OpenSkillMenuTwice(caster)
                else
                    //call BJDebugMsg("Ignore back click.")
                endif
            elseif (abilityId == ABILITY_INCREASE_ABILITY_LEVEL) then
                call IncreaseAbility(caster, skillMenu.slot)
            elseif (abilityId == ABILITY_DECREASE_ABILITY_LEVEL) then
                call DecreaseAbility(caster, skillMenu.slot)
            elseif (abilityId == ABILITY_PLACEHOLDER) then
                set skillMenu.page = 0 // Reset page for different slots
                call ShowAllAbilitiesForSpecificSlot(caster, skillMenu.slot, skillMenu.page)
                call OpenSkillMenuTwice(caster)
            elseif (abilityId == ABILITY_NEXT_PAGE) then
                //call BJDebugMsg("Next page with max pages for slot " + I2S(skillMenu.slot) + ": " + I2S(GetMaxPagesForSlot(skillMenu.slot)))
                if (skillMenu.page >= GetMaxPagesForSlot(skillMenu.slot) - 1) then
                    call ShowAllAbilitiesForSpecificSlot(caster, skillMenu.slot, 0)
                    //call OpenSkillMenu(caster)
                else
                    call ShowAllAbilitiesForSpecificSlot(caster, skillMenu.slot, skillMenu.page + 1)
                    //call OpenSkillMenu(caster)
                endif
            elseif (abilityId == ABILITY_PREVIOUS_PAGE) then
                //call BJDebugMsg("Previous page with max pages for slot " + I2S(skillMenu.slot) + ": " + I2S(GetMaxPagesForSlot(skillMenu.slot)))
                if (skillMenu.page == 0) then
                    call ShowAllAbilitiesForSpecificSlot(caster, skillMenu.slot, GetMaxPagesForSlot(skillMenu.slot) - 1)
                    //call OpenSkillMenu(caster)
                else
                    call ShowAllAbilitiesForSpecificSlot(caster, skillMenu.slot, skillMenu.page - 1)
                    //call OpenSkillMenu(caster)
                endif
            endif
        endif
    endif
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
    set caster = null
endfunction

private function TriggerActionChannel takes nothing returns nothing
    local timer t = CreateTimer()
    call SaveUnitHandle(h, GetHandleId(t), 0, GetTriggerUnit())
    call SaveInteger(h, GetHandleId(t), 1, GetSpellAbilityId())
    // Do not react instantly since it will lead to endless casting and requires to call a stop order.
    call TimerStart(t, 0.0, false, function TimerFunctionAbility)
    set t = null
endfunction

private function EnumPlayerDisableAbility takes nothing returns nothing
    local player p = GetEnumPlayer()
    call SetPlayerAbilityAvailable(p, ABILITY_HERO_ABILITIES_HIDDEN, false)
    call SetPlayerAbilityAvailable(p, ABILITY_HERO_ABILITY_PLACEHOLDER, false)
    call SetPlayerAbilityAvailable(p, ABILITY_PLACE_HOLDER_SPELLBOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_INCREASE_ABILITY_LEVEL_SPELLBOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_DECREASE_ABILITY_LEVEL_SPELLBOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_MATCHING_CLASS_SPELL_BOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_RANDOM_CLASS_SPELL_BOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_RANDOM_SPELL_SPELL_BOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_NEXT_SPELL_VARIATION_SPELL_BOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_BACK_SPELLBOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_NEXT_PAGE_SPELL_BOOK, false)
    call SetPlayerAbilityAvailable(p, ABILITY_PREVIOUS_PAGE_SPELL_BOOK, false)
    set p = null
endfunction

private function DisableAbilities takes nothing returns nothing
    local force f = CreateForce()
    call ForceAddForce(f, GetPlayersAll())
    call ForceAddPlayer(f, Player(PLAYER_NEUTRAL_PASSIVE))
    call ForForce(f, function EnumPlayerDisableAbility)
    call ForceClear(f)
    call DestroyForce(f)
    set f = null
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(channelTrigger, function TriggerActionChannel)
    
    set slotAbilityIds[0] = ABILITY_SLOT_1
    set slotAbilityIds[1] = ABILITY_SLOT_2
    set slotAbilityIds[2] = ABILITY_SLOT_3
    set slotAbilityIds[3] = ABILITY_SLOT_4
    set slotAbilityIds[4] = ABILITY_SLOT_5
    set slotAbilityIds[5] = ABILITY_SLOT_6
    set slotAbilityIds[6] = ABILITY_SLOT_7
    set slotAbilityIds[7] = ABILITY_SLOT_8
    set slotAbilityIds[8] = ABILITY_SLOT_9
    set slotAbilityIds[9] = ABILITY_SLOT_10
    set slotAbilityIds[10] = ABILITY_SLOT_11
    
    call DisableAbilities()
endfunction

endlibrary
