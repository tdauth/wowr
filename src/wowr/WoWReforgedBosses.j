library WoWReforgedBosses initializer Init requires UnitTypeUtils, WoWReforgedUtils, WoWReforgedHeroes, WoWReforgedCommandButtons, WoWReforgedSkillMenu, WoWReforgedClasses, WoWReforgedAutoSkill, WoWReforgedMapData
// Require WoWReforgedHeroes to assign the boss hero classes to the correct ones.

function IsBoss takes integer unitTypeId returns boolean
    local boolean result = false
    local unit boss = null
    local integer i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(udg_Bosses) or result)
        set boss = BlzGroupUnitAt(udg_Bosses, i)
        if (GetUnitTypeId(boss) == unitTypeId) then
            set result = true
        endif
        set boss = null
        set i = i + 1
    endloop
    return result
endfunction

function UpdateBossPlayerHeroes takes nothing returns nothing
    local unit boss = null
    local unit boss1 = null
    local unit boss2 = null
    local unit boss3 = null
    local integer i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(udg_Bosses))
        set boss = BlzGroupUnitAt(udg_Bosses, i)
        if (boss1 == null or GetHeroLevel(boss) > GetHeroLevel(boss1)) then
            set boss1 = boss
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(udg_Bosses))
        set boss = BlzGroupUnitAt(udg_Bosses, i)
        if (boss != boss1 and (boss2 == null or GetHeroLevel(boss) > GetHeroLevel(boss2))) then
            set boss2 = boss
        endif
        set i = i + 1
    endloop
    set i = 0
    loop
        exitwhen (i >= BlzGroupGetSize(udg_Bosses))
        set boss = BlzGroupUnitAt(udg_Bosses, i)
        if (boss != boss1 and boss != boss2 and (boss3 == null or GetHeroLevel(boss) > GetHeroLevel(boss3))) then
            set boss3 = boss
        endif
        set i = i + 1
    endloop
    
    call SetPlayerHero1(udg_BossesPlayer, boss1)
    call SetPlayerHero2(udg_BossesPlayer, boss2)
    call SetPlayerHero3(udg_BossesPlayer, boss3)
endfunction

globals
    private trigger deathTrigger = CreateTrigger()

    private integer legendaryItemsCounter = 0
    private integer array legendaryItemTypeId
    private unit array legendaryItemBoss
    private unit array legendaryItemBuilding
    private rect array legendaryItemRect
endglobals

function GetLegendaryItemsMax takes nothing returns integer
    return legendaryItemsCounter
endfunction

function GetLegendaryItemTypeId takes integer index returns integer
    return legendaryItemTypeId[index]
endfunction

function GetLegendaryItemBoss takes integer index returns unit
    return legendaryItemBoss[index]
endfunction

function GetLegendaryItemBuilding takes integer index returns unit
    return legendaryItemBuilding[index]
endfunction

function GetLegendaryItemRect takes integer index returns rect
    return legendaryItemRect[index]
endfunction

function GetLegendaryItemByBuilding takes unit b returns integer
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (GetLegendaryItemBuilding(i) == b) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetLegendaryItemByBoss takes unit boss returns integer
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (GetLegendaryItemBoss(i) == boss) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function GetLegendaryItemByItemTypeId takes integer itemTypeId returns integer
    local integer i = 0
    local integer max = GetLegendaryItemsMax()
    loop
        exitwhen (i == max)
        if (GetLegendaryItemTypeId(i) == itemTypeId) then
            return i
        endif
        set i = i + 1
    endloop
    return -1
endfunction

function IsLegendaryItem takes integer itemTypeId returns boolean
    return GetLegendaryItemByItemTypeId(itemTypeId) != -1
endfunction

function IsItemLegendaryItem takes item whichItem returns boolean
    return GetLegendaryItemByItemTypeId(GetItemTypeId(whichItem)) != -1
endfunction

function GetUnitLegendaryItemsCount takes unit hero returns integer
    local item slotItem = null
    local integer result = 0
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set slotItem = UnitItemInSlot(hero, i)
        if (slotItem != null and GetLegendaryItemByItemTypeId(GetItemTypeId(slotItem)) != -1) then
            set result = result + 1
        endif
        set slotItem = null
        set i = i + 1
    endloop
    return result
endfunction

function AddLegendaryItem takes integer itemTypeId, unit boss, unit building, rect r returns nothing
    set legendaryItemTypeId[legendaryItemsCounter] = itemTypeId
    set legendaryItemBoss[legendaryItemsCounter] = boss
    set legendaryItemBuilding[legendaryItemsCounter] = building
    set legendaryItemRect[legendaryItemsCounter] = r
    
    set udg_LegendaryItemType[legendaryItemsCounter] = itemTypeId
    set udg_LegendaryItemDropRect[legendaryItemsCounter] = r
    
    set legendaryItemsCounter = legendaryItemsCounter + 1
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    local unit dyingUnit = GetDyingUnit()
    local integer index = -1
    if (IsUnitType(dyingUnit, UNIT_TYPE_HERO) and (GetOwningPlayer(dyingUnit) == GetMapBossesPlayer() or IsUnitInGroup(dyingUnit, udg_Bosses))) then
        set index = GetLegendaryItemByBoss(dyingUnit)
        if (index != -1) then
            call SetUnitInvulnerable(GetLegendaryItemBuilding(index), false)
        endif
    elseif (GetUnitTypeId(dyingUnit) == LEGENDARY_ARTIFACT) then
        set index = GetLegendaryItemByBuilding(dyingUnit)
        if (index != -1) then
            call SetItemInvulnerable(UnitDropItem(dyingUnit, GetLegendaryItemTypeId(index)), true)
        endif
    endif
    
    set dyingUnit = null

    return false
endfunction

private function AddBoss takes integer id, integer class returns nothing
    call AssignHeroClass(id, class)
    call SetIsCampaign(id, true)
endfunction

private function Init takes nothing returns nothing
    set deathTrigger = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
    
    call AddBoss(ARCHIMONDE_BOSS, CLASS_WARLOCK)
    call AddBoss(XALATATH, CLASS_WITCH_DOCTOR)
    call AddBoss(ARCH_LICH, CLASS_NECROMANCER)
    call AddBoss(AVATAR_OF_SARGERAS, CLASS_WARLOCK)
    call AddBoss(DENATHRIUS, CLASS_DEATH_KNIGHT)
    call AddBoss(XAVIUS, CLASS_WARLOCK)
    call AddBoss(YSERA, CLASS_DRUID)
    call AddBoss(OHNAHRA, CLASS_AEROMANCER)
    call AddBoss(YULON, CLASS_DRUID)
    call AddBoss(SMOLDERON, CLASS_PYROMANCER)
    call AddBoss(NEPTULON, CLASS_HYDROMANCER)
    call AddBoss(THUNDERAAN, CLASS_AEROMANCER)
    call AddBoss(THERAZANE, CLASS_GEOMANCER)
    call AddBoss(IMONAR, CLASS_WARRIOR)
    call AddBoss(QUEEN_AZSHARA, CLASS_HYDROMANCER)
    call AddBoss(GIZLOCK, CLASS_TINKER)
    call AddBoss(RUMBLEFITZ, CLASS_TINKER)
    call AddBoss(YOGG_SARON, CLASS_HYDROMANCER)
    call AddBoss(NZOTH, CLASS_DEATH_KNIGHT)
    call AddBoss(CTHUN, CLASS_WARLOCK)
    call AddBoss(SIR_GREGORY_EDMUNSON, CLASS_PALADIN)
    call AddBoss(LORD_NICHOLAS_BUZAN, CLASS_PALADIN)
    call AddBoss(MAGROTH_THE_DEFENDER, CLASS_PALADIN)
    call AddBoss(AKAMA, CLASS_ROGUE)
    call AddBoss(ALAR, CLASS_PYROMANCER)
    call AddBoss(ANTONIDAS_BOSS, CLASS_ARCANIST)
    call AddBoss(CENARIUS_BOSS, CLASS_DRUID)
    call AddBoss(DEATHWING, CLASS_PYROMANCER)
    call AddBoss(DRAGON_TEMPLE_GUARDIAN, CLASS_HYDROMANCER)
    call AddBoss(ELUNE, CLASS_HUNTER)
    call AddBoss(FACELESS_NIGHTMARE, CLASS_DEATH_KNIGHT)
    call AddBoss(FELWOODS_PAIN, CLASS_WARLOCK)
    call AddBoss(GRUUL_THE_DRAGONKILLER, CLASS_WARRIOR)
    call AddBoss(ZARJIRA, CLASS_HYDROMANCER)
    call AddBoss(MATHOG, CLASS_ROGUE)
    call AddBoss(GULDAN_BOSS, CLASS_WARLOCK)
    call AddBoss(THE_EYE_OF_SARGERAS, CLASS_WARLOCK)
    call AddBoss(MURLOC_SORCERER_BOSS, CLASS_HYDROMANCER)
    call AddBoss(TORTOLLA, CLASS_WARRIOR)
    call AddBoss(KING_DEEPBEARD, CLASS_HYDROMANCER)
    call AddBoss(KIL_JAEDEN_BOSS, CLASS_WARLOCK)
    call AddBoss(VERAKU, CLASS_WARLOCK)
    call AddBoss(VARIMATHRAS, CLASS_DEATH_KNIGHT)
    call AddBoss(HYDRA_QUEEN_BOSS, CLASS_HYDROMANCER)
    call AddBoss(VOID_REVENANT_BOSS, CLASS_DEATH_KNIGHT)
    call AddBoss(STORMBRINGER_BOSS, CLASS_AEROMANCER)
    call AddBoss(LICH_KING_BOSS, CLASS_DEATH_KNIGHT)
    call AddBoss(TARAN_ZHU, CLASS_MONK)
    call AddBoss(MURMUR, CLASS_DEATH_KNIGHT)
    
    call AddBoss(MAIEV_BOSS, CLASS_ROGUE)
    call AddBoss(KAEL_BOSS, CLASS_PYROMANCER)
    call AddBoss(CAPTAIN_BOSS, CLASS_WARRIOR)
    call AddBoss(GOBLIN_BANK_DIRECTOR, CLASS_TINKER)
    call AddBoss(HERALD_OF_THE_DEEP_MOTHER, CLASS_HYDROMANCER)
    call AddBoss(MAGTHERIDON_BOSS, CLASS_WARLOCK)
    call AddBoss(GHOST_BOSS, CLASS_DRUID)
    
    call AddBoss(DETHEROC, CLASS_DEATH_KNIGHT)
    call AddBoss(DALVENGYR_BOSS, CLASS_DEATH_KNIGHT)
    call AddBoss(BALNAZZAR_BOSS, CLASS_DEATH_KNIGHT)
    call AddBoss(MALGANIS, CLASS_DEATH_KNIGHT)
    
    call AddBoss(ILLIDAN, CLASS_WARLOCK)
endfunction

endlibrary
