library WoWReforgedAutoSkill initializer Init requires WoWReforgedUtils, WoWReforgedSkillMenu, WoWReforgedDependencyEquivalents, WoWReforgedClasses

globals
    constant integer ABILITY_TOME_OF_RETRAINING = 'A09F'

    private trigger channelTrigger = CreateTrigger()
    private hashtable h = InitHashtable()
endglobals

function AutoSkillHero takes unit hero returns integer
    local SkillMenu skillMenu = GetSkillMenu(hero)
    local integer i = 0
    local integer remainingSkillPoints = 0
    local integer unsuccessfulTries = 0
    if (skillMenu != 0) then
        set remainingSkillPoints = GetHeroSkillPointsCustom(hero)
        loop
            exitwhen (remainingSkillPoints <= 0 or unsuccessfulTries >= WoWReforgedSkillMenu_MAX_SLOTS)
            //call BJDebugMsg("Auto skilling " + I2S(remainingSkillPoints))
            set unsuccessfulTries = 0
            set i = 0
            loop
                exitwhen (i == WoWReforgedSkillMenu_MAX_SLOTS or remainingSkillPoints <= 0)
                if (skillMenu.abilityIds[i] != 0) then
                    if (GetUnitAbilitySkillLevel(hero, skillMenu.abilityIds[i].abilityId) < MAX_HERO_SPELL_LEVEL and IncreaseAbilityEx(hero, i, false)) then
                        set remainingSkillPoints = GetHeroSkillPointsCustom(hero)
                    else
                        set unsuccessfulTries = unsuccessfulTries + 1
                    endif
                else
                    set unsuccessfulTries = unsuccessfulTries + 1
                endif
                set i = i + 1
            endloop
        endloop
    endif
    
    // Do at the end for much better performance.
    call UpdateSkillMenuLearnedAbilityTooltips(hero)
    call UpdateSkillMenu(hero)
    
    return remainingSkillPoints
endfunction

function UnlearnHero takes unit hero returns integer
    local SkillMenu skillMenu = GetSkillMenu(hero)
    local integer i = 0
    local integer j = 0
    local integer unskilledPoints = 0
    if (skillMenu != 0) then
        set i = 0
        loop
            exitwhen (i == WoWReforgedSkillMenu_MAX_SLOTS)
            if (skillMenu.abilityIds[i] != 0) then
                set j = GetUnitAbilitySkillLevel(hero, skillMenu.abilityIds[i].abilityId)
                loop
                    exitwhen (j <= 0)
                    if (DecreaseAbilityEx(hero, i, false)) then
                        set unskilledPoints = unskilledPoints + 1
                    else
                        exitwhen (true)
                    endif
                    set j = GetUnitAbilitySkillLevel(hero, skillMenu.abilityIds[i].abilityId)
                endloop
            endif
            set i = i + 1
        endloop
    endif
    
    // Do at the end for much better performance.
    call UpdateSkillMenuLearnedAbilityTooltips(hero)
    call UpdateSkillMenu(hero)
    
    return unskilledPoints
endfunction

private function GetRandomLearnableAbility takes unit whichUnit, integer slot returns SkillMenuAbility
    local SkillMenuAbility array abilities
    local integer count = 0
    local SkillMenuAbility a = 0
    local integer i = 0
    local integer max = GetLearnableAbilityIdsCount(slot)
    loop
        exitwhen (i == max)
        set a = GetLearnableAbilityId(slot, i)
        if ((not a.heroesOnly or IsUnitType(whichUnit, UNIT_TYPE_HERO)) and a.available(GetUnitTypeId(whichUnit)) and (not a.forbidEquipmentBag or GetUnitTypeId(whichUnit) != EQUIPMENT_BAG)) then
            set abilities[count] = a
            set count = count + 1
        endif
        set i = i + 1
    endloop                    
    return abilities[GetRandomInt(0, count - 1)]
endfunction

function RandomizeHeroSkill takes unit hero returns boolean
    local SkillMenu skillMenu = GetSkillMenu(hero)
    local integer i = 0
    local boolean hasNoCooldown = true
    if (skillMenu != 0) then
        set i = 0
        loop
            exitwhen (i == WoWReforgedSkillMenu_MAX_SLOTS or not hasNoCooldown)
            set hasNoCooldown = AbilityHasNoCooldown(hero, i)
            set i = i + 1
        endloop
        if (hasNoCooldown) then
            set i = 0
            loop
                exitwhen (i == WoWReforgedSkillMenu_MAX_SLOTS)
                call ReplaceAbility(hero, i, GetRandomLearnableAbility(hero, i))
                set i = i + 1
            endloop
            return true
        endif
    endif
    return false
endfunction

function RandomizeSingleHeroSkill takes unit hero returns boolean
    local SkillMenu skillMenu = GetSkillMenu(hero)
    if (skillMenu != 0) then
        //call BJDebugMsg("Randomize single hero skill for slot " + I2S(skillMenu.slot))
        if (AbilityHasNoCooldown(hero, skillMenu.slot)) then
            call ReplaceAbility(hero, skillMenu.slot, GetRandomLearnableAbility(hero, skillMenu.slot))
            call ShowSingleAbility(hero, skillMenu.slot)
            return true
        endif
    endif
    return false
endfunction

function NextSpellVariation takes unit whichUnit returns nothing
    local SkillMenu skillMenu = GetSkillMenu(whichUnit)
    local SkillMenuAbility a = 0
    local SkillMenuAbility newAbility = 0
    local integer id = 0
    local integer baseId = 0
    local DependencyEquivalents d = 0
    local integer i = 0
    local integer array skins
    local integer skinsCounter = 0
    local integer currentIndex = 0
    local integer skinIndex = 0
    local integer skin = baseId
    if (skillMenu != 0) then
        if (AbilityHasNoCooldown(whichUnit, skillMenu.slot)) then
            set a = skillMenu.abilityIds[skillMenu.slot]
            if (a != 0) then
                set id = a.abilityId
                set baseId = GetPrimaryDependencyEquivalent(id)
                set d = GetDependencyEquivalents(baseId)
                if (d != 0 and d.count > 0) then
                    set skins[0] = baseId
                    set skinsCounter = skinsCounter + 1
                    set i = 0
                    loop
                        exitwhen (i >= d.count)
                        if (PlayerHasUnlocked(GetOwningPlayer(whichUnit), d.ids[i])) then
                            if (id == d.ids[i]) then
                                set currentIndex = skinsCounter
                            endif
                            set skins[skinsCounter] = d.ids[i]
                            set skinsCounter = skinsCounter + 1
                        endif
                        set i = i + 1
                    endloop
                    //call BJDebugMsg("Current skin index " + I2S(currentIndex) + " with skins counter " + I2S(skinsCounter))
                    set skinIndex = ModuloInteger(currentIndex + 1, skinsCounter)
                    set skin = skins[skinIndex]
                    set newAbility = GetLearnableAbilitByAbilityId(skillMenu.slot, skin)
                    
                    call ReplaceAbility(whichUnit, skillMenu.slot, newAbility)
                  
                    call DisplayTextToPlayer(GetOwningPlayer(whichUnit), 0.0, 0.0, Format(GetLocalizedString("ABILITY_CHANGED_RANGE")).s(GetObjectName(newAbility.abilityId)).i(skinIndex + 1).i(skinsCounter).result())
                else
                    call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("ABILITY_NO_OTHER"))
                endif
            endif
        else
            call SimError(GetOwningPlayer(whichUnit), GetLocalizedString("ONE_ABILITY_HAS_COOLDOWN"))
        endif
    endif
endfunction

private function TimerFunctionChannel takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit caster = LoadUnitHandle(h, GetHandleId(t), 0)
    local integer abilityId = LoadInteger(h, GetHandleId(t), 1)
    if (abilityId == ABILITY_MATCHING_CLASS) then
        call ApplyMatchingHeroClass(caster)
        call OpenSkillMenuTwice(caster)
    elseif (abilityId == ABILITY_RANDOM_CLASS) then
        call ApplyRandomHeroClass(caster)
        call OpenSkillMenuTwice(caster)
    endif
    set caster = null
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    local integer abilityId = GetSpellAbilityId()
    local integer remaining = 0
    local timer t = null
    if (abilityId == ABILITY_AUTO_SKILL) then
        if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO)) then
            call ResetUnitAnimation(GetTriggerUnit())
            set remaining = AutoSkillHero(GetTriggerUnit())
            if (remaining == 0) then
                call UnitMessage(GetTriggerUnit(), GetLocalizedString("AUTO_SKILL_MESSAGE"))
            else
                call SimError(GetOwningPlayer(GetTriggerUnit()), Format(GetLocalizedString("SKILL_POINTS_REMAINING")).i(remaining).result())
            endif
        else
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("UNIT_IS_NO_HERO"))
        endif
    elseif (abilityId == ABILITY_TOME_OF_RETRAINING) then
        if (UnlearnHero(GetTriggerUnit()) == 0) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("NO_SKILLED_ABILITIES")) 
        endif
    elseif (abilityId == ABILITY_RANDOMIZE_SPELLS) then
        if (not RandomizeHeroSkill(GetTriggerUnit())) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("ONE_ABILITY_HAS_COOLDOWN"))
        endif
    elseif (abilityId == ABILITY_RANDOM_SPELL) then
        if (not RandomizeSingleHeroSkill(GetTriggerUnit())) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call SimError(GetOwningPlayer(GetTriggerUnit()), GetLocalizedString("ONE_ABILITY_HAS_COOLDOWN"))
        endif
    elseif (abilityId == ABILITY_NEXT_SPELL_VARIATION) then
        call NextSpellVariation(GetTriggerUnit())
    elseif (abilityId == ABILITY_MATCHING_CLASS or abilityId == ABILITY_RANDOM_CLASS) then
        // This timer prevents endless casting.
        set t = CreateTimer()
        call SaveUnitHandle(h, GetHandleId(t), 0, GetTriggerUnit())
        call SaveInteger(h, GetHandleId(t), 1, abilityId)
        call TimerStart(t, 0.0, false, function TimerFunctionChannel)
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))
endfunction

endlibrary
