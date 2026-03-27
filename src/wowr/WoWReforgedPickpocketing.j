library WoWReforgedPickpocketing requires ItemUtils, TextTagUtils, WoWReforgedUtils, WoWReforgedBackpacks

globals
    constant real PICKPOCKETING_CHANCE = 15.0
    constant real PICKPOCKETING_BOUNTY_PERCENTAGE = 20.0
    constant integer PICKPOCKETING_ITEM_TYPE_ID = 'I03F'
    constant integer PICKPOCKETING_ABILITY_ID = 'A17B'
endglobals

function GetBountyGold takes unit whichUnit returns integer
    local integer bountyBase = BlzGetUnitIntegerField(whichUnit, UNIT_IF_GOLD_BOUNTY_AWARDED_BASE)
    local integer bountyNumberOfDice = BlzGetUnitIntegerField(whichUnit, UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local integer bountySidesPerDice = BlzGetUnitIntegerField(whichUnit, UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE)
    local integer bounty = bountyBase
    local integer i = 0
    loop
        exitwhen (i == bountyNumberOfDice)
        set bounty = bounty + GetRandomInt(0, bountySidesPerDice)
        set i = i + 1
    endloop
    
    return bounty
endfunction

function GetBountyLumber takes unit whichUnit returns integer
    local integer bountyBase = BlzGetUnitIntegerField(whichUnit, UNIT_IF_LUMBER_BOUNTY_AWARDED_BASE)
    local integer bountyNumberOfDice = BlzGetUnitIntegerField(whichUnit, UNIT_IF_LUMBER_BOUNTY_AWARDED_NUMBER_OF_DICE)
    local integer bountySidesPerDice = BlzGetUnitIntegerField(whichUnit, UNIT_IF_LUMBER_BOUNTY_AWARDED_SIDES_PER_DIE)
    local integer bounty = bountyBase
    local integer i = 0
    loop
        exitwhen (i == bountyNumberOfDice)
        set bounty = bounty + GetRandomInt(0, bountySidesPerDice)
        set i = i + 1
    endloop
    
    return bounty
endfunction

function ThiefBounty takes unit hero, unit whichUnit returns nothing
    local force whichForce = CreateForce()
    local integer bountyGold = R2I(I2R(GetBountyGold(whichUnit)) * PICKPOCKETING_BOUNTY_PERCENTAGE)
    local integer bountyLumber = R2I(I2R(GetBountyLumber(whichUnit)) * PICKPOCKETING_BOUNTY_PERCENTAGE)
    call ForceAddPlayer(whichForce, GetOwningPlayer(hero))
    if (bountyGold > 0) then
        call Bounty(whichForce, GetUnitX(whichUnit), GetUnitY(whichUnit), bountyGold)
    endif
    if (bountyLumber > 0) then
        call BountyLumber(whichForce, GetUnitX(whichUnit) - 200.0, GetUnitY(whichUnit), bountyLumber)
    endif
    call ForceClear(whichForce)
    call DestroyForce(whichForce)
    set whichForce = null
endfunction

function PickpocketingStealItem takes unit hero, unit target returns item
    local integer countStealingItem = 0
    local real random = 0.0
    local item stolenItem = null
    local real chance = 0
    if (not IsUnitIllusion(target)) then
        if (GetUnitAbilityLevel(hero, PICKPOCKETING_ABILITY_ID) > 0) then
            set chance = GetUnitAbilityLevel(hero, PICKPOCKETING_ABILITY_ID) * 5.0 + 20
            set countStealingItem = 1
        elseif (IsUnitType(hero, UNIT_TYPE_HERO) and GetUnitTypeId(hero) != BACKPACK) then
            if (hero == udg_Hero[GetPlayerId(GetOwningPlayer(hero))]) then
                set countStealingItem = Hero1CountItemsOfItemType(hero, PICKPOCKETING_ITEM_TYPE_ID)
            else
                set countStealingItem = CountItemsOfItemTypeId(hero, PICKPOCKETING_ITEM_TYPE_ID)
            endif
            set chance = chance + I2R(countStealingItem) * PICKPOCKETING_CHANCE
        endif
        if (countStealingItem > 0) then
            set random = GetRandomReal(0.0, 100.0)
            if (random <= chance) then
                set stolenItem = HeroDropRandomItem(target)
                if (stolenItem != null) then
                    call UnitAddItem(hero, stolenItem)
                    call DisplayTextToPlayer(GetOwningPlayer(target), 0.0, 0.0, Format(GetLocalizedString("HAS_STOLEN_ITEM_FROM_YOUR_UNIT")).s(GetUnitName(hero)).s(GetItemName(stolenItem)).s(GetUnitName(target)).result())
                    call DisplayTextToPlayer(GetOwningPlayer(hero), 0.0, 0.0, Format(GetLocalizedString("STOLE_ITEM_FROM_UNIT")).s(GetItemName(stolenItem)).s(GetUnitName(target)).result())
                endif

                return stolenItem
            endif
            
            call ThiefBounty(hero, target)
        endif
    endif

    return null
endfunction

endlibrary
