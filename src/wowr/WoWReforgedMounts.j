library WoWReforgedMounts initializer Init requires SimError, CameraUtils, PagedButtons, WoWReforgedUtils, WoWReforgedVIPs, WoWReforgedAccount

globals
    private constant integer MAX_ABILITIES = 8
    private constant integer SUMMON_MOUNT_ABILITY_ID = 'A0DJ'
endglobals

struct MountData
    string name
    integer mountIndex = 0
    integer abilityIdsCount = 0
    integer array abilityIds[MAX_ABILITIES]
endstruct

globals
    private hashtable h = InitHashtable()
    // For all 3 heroes.
    private MountData array mountData1
    private MountData array mountData2
    private MountData array mountData3
    
    private constant integer KEY_MOUNT = 0
    private constant integer KEY_HERO = 1
endglobals

function IsUnitMount takes unit mount returns boolean
    return HaveSavedHandle(h, GetHandleId(mount), KEY_HERO)
endfunction

function MountGet takes unit hero returns unit
    local integer handleId = GetHandleId(hero)
    if (HaveSavedHandle(h, handleId, KEY_MOUNT)) then
        return LoadUnitHandle(h, handleId, KEY_MOUNT)
    endif

    return null
endfunction

function MountAssign takes unit hero, unit mount returns nothing
    call SaveUnitHandle(h, GetHandleId(hero), KEY_MOUNT, mount)
    call SaveUnitHandle(h, GetHandleId(mount), KEY_HERO, hero)
endfunction

function MountClear takes unit hero returns nothing
    local integer handleId = GetHandleId(hero)
    local unit mount = LoadUnitHandle(h, handleId, KEY_MOUNT)
    if (mount != null) then
        call FlushChildHashtable(h, GetHandleId(mount))
        set mount = null
    endif
    call FlushChildHashtable(h, handleId)
endfunction

function GetMount1 takes player whichPlayer returns unit
    if (GetPlayerHero1(whichPlayer) != null and MountGet(GetPlayerHero1(whichPlayer)) != null) then
        return MountGet(GetPlayerHero1(whichPlayer))
    endif
    return null
endfunction

function GetMount2 takes player whichPlayer returns unit
    if (GetPlayerHero2(whichPlayer) != null and MountGet(GetPlayerHero2(whichPlayer)) != null) then
        return MountGet(GetPlayerHero2(whichPlayer))
    endif
    return null
endfunction

function GetMount3 takes player whichPlayer returns unit
    if (GetPlayerHero3(whichPlayer) != null and MountGet(GetPlayerHero3(whichPlayer)) != null) then
        return MountGet(GetPlayerHero3(whichPlayer))
    endif
    return null
endfunction

private function GetMountDataByHero takes unit hero returns MountData
    local player owner = GetOwningPlayer(hero)
    local integer playerId = GetPlayerId(owner)
    if (GetPlayerHero2(owner) == hero) then
        return mountData2[playerId]
    elseif (GetPlayerHero3(owner) == hero) then
        return mountData3[playerId]
    endif
    return mountData1[playerId]
endfunction

private function GetMountData takes unit mount returns MountData
    local player owner = GetOwningPlayer(mount)
    local integer playerId = GetPlayerId(owner)
    if (GetMount2(owner) == mount) then
        return mountData2[playerId]
    elseif (GetMount3(owner) == mount) then
        return mountData3[playerId]
    endif
    return mountData1[playerId]
endfunction

function AddMountAbility takes unit mount, integer abilityId returns nothing
    local MountData mountData = GetMountData(mount)
    if (mountData != 0) then
        if (mountData.abilityIdsCount < MAX_ABILITIES) then
            set mountData.abilityIds[mountData.abilityIdsCount] = abilityId
            set mountData.abilityIdsCount = mountData.abilityIdsCount + 1
        else
            call SimError(GetOwningPlayer(mount), GetLocalizedString("MOUNT_REACHED_MAX_ABILITIES"))
        endif
    endif
endfunction

function ClearMountAbilities takes unit mount returns nothing
    local MountData mountData = GetMountData(mount)
    if (mountData != 0) then
        set mountData.abilityIdsCount = 0
    endif
endfunction

private function RestoreMountAbilities takes unit mount returns nothing
    local MountData mountData = GetMountData(mount)
    local integer count = 0
    local integer i = 0
    if (mountData != 0) then
        set count = mountData.abilityIdsCount
        loop
            exitwhen (i == count)
            call UnitAddAbility(mount, mountData.abilityIds[i])
            set i = i + 1
        endloop
    endif
endfunction

private function SetMountNameMessage takes player whichPlayer, integer index, string name returns nothing
    call DisplayTextToPlayer(whichPlayer, 0.0, 0.0, Format(GetLocalizedString("SET_MOUNT_NAME")).i(index).s(name).result())
endfunction

function SetMountName1 takes player whichPlayer, string name returns nothing
    set mountData1[GetPlayerId(whichPlayer)].name = name
    call SetMountNameMessage(whichPlayer, 1, name)
    if (GetMount1(whichPlayer) != null) then
        if (StringLength(name) == 0) then
            call BlzSetUnitName(GetMount1(whichPlayer), GetObjectName(GetUnitTypeId(GetMount1(whichPlayer))))
        else
            call BlzSetUnitName(GetMount1(whichPlayer), name)
        endif
    endif
endfunction

function GetMountName1 takes player whichPlayer returns string
    return mountData1[GetPlayerId(whichPlayer)].name
endfunction

function SetMountName2 takes player whichPlayer, string name returns nothing
    set mountData2[GetPlayerId(whichPlayer)].name = name
    call SetMountNameMessage(whichPlayer, 2, name)
    if (GetMount2(whichPlayer) != null) then
        if (StringLength(name) == 0) then
            call BlzSetUnitName(GetMount2(whichPlayer), GetObjectName(GetUnitTypeId(GetMount2(whichPlayer))))
        else
            call BlzSetUnitName(GetMount2(whichPlayer), name)
        endif
    endif
endfunction

function GetMountName2 takes player whichPlayer returns string
    return mountData2[GetPlayerId(whichPlayer)].name
endfunction

function SetMountName3 takes player whichPlayer, string name returns nothing
    set mountData3[GetPlayerId(whichPlayer)].name = name
    call SetMountNameMessage(whichPlayer, 3, name)
    if (GetMount3(whichPlayer) != null) then
        if (StringLength(name) == 0) then
            call BlzSetUnitName(GetMount3(whichPlayer), GetObjectName(GetUnitTypeId(GetMount3(whichPlayer))))
        else
            call BlzSetUnitName(GetMount3(whichPlayer), name)
        endif
    endif
endfunction

function GetMountName3 takes player whichPlayer returns string
    return mountData3[GetPlayerId(whichPlayer)].name
endfunction

function MountKill takes unit hero returns nothing
    local unit mount = MountGet(hero)
    if (mount != null) then
        call KillUnit(mount) // in case there are transported units
    endif
    set mount = null
    call MountClear(hero)
endfunction

function MountKill1 takes player whichPlayer returns nothing
    call MountKill(udg_Hero[GetPlayerId(whichPlayer)])
endfunction

function MountKill2 takes player whichPlayer returns nothing
    call MountKill(udg_Hero2[GetPlayerId(whichPlayer)])
endfunction

function MountKill3 takes player whichPlayer returns nothing
    call MountKill(udg_Hero3[GetPlayerId(whichPlayer)])
endfunction

function MountReplace takes unit hero, unit mount returns nothing
    local player owner = GetOwningPlayer(hero)
    call MountKill(hero)
    call MountAssign(hero, mount)
    if (hero == GetPlayerHero1(owner) and StringLength(GetMountName1(owner)) > 0) then
        call BlzSetUnitName(mount, GetMountName1(owner))
        call RestoreMountAbilities(mount)
    elseif (hero == GetPlayerHero2(owner) and StringLength(GetMountName2(owner)) > 0) then
        call BlzSetUnitName(mount, GetMountName2(owner))
        call RestoreMountAbilities(mount)
    elseif (hero == GetPlayerHero3(owner) and StringLength(GetMountName3(owner)) > 0) then
        call BlzSetUnitName(mount, GetMountName3(owner))
        call RestoreMountAbilities(mount)
    endif
    set owner = null
endfunction

function MountGetAll takes player whichPlayer returns group
    local group result = CreateGroup()
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null and MountGet(udg_Hero[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero[playerId]))
    endif

    if (udg_Hero2[playerId] != null and MountGet(udg_Hero2[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero2[playerId]))
    endif

    if (udg_Hero3[playerId] != null and MountGet(udg_Hero3[playerId]) != null) then
        call GroupAddUnit(result, MountGet(udg_Hero3[playerId]))
    endif

    return result
endfunction

function MountKillAll takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null and MountGet(udg_Hero[playerId]) != null) then
        call MountKill(udg_Hero[playerId])
    endif

    if (udg_Hero2[playerId] != null and MountGet(udg_Hero2[playerId]) != null) then
        call MountKill(udg_Hero2[playerId])
    endif

    if (udg_Hero3[playerId] != null and MountGet(udg_Hero3[playerId]) != null) then
        call MountKill(udg_Hero[playerId])
    endif
endfunction

function MountClearAll takes player whichPlayer returns nothing
    local integer playerId = GetPlayerId(whichPlayer)

    if (udg_Hero[playerId] != null) then
        call MountClear(udg_Hero[playerId])
    endif

    if (udg_Hero2[playerId] != null) then
        call MountClear(udg_Hero2[playerId])
    endif

    if (udg_Hero3[playerId] != null) then
        call MountClear(udg_Hero[playerId])
    endif
endfunction

function SelectNextMount takes player whichPlayer returns unit
    local group mounts = MountGetAll(whichPlayer)
    local unit result = GetNextUnitToSelect(mounts, whichPlayer)
    call GroupClear(mounts)
    call DestroyGroup(mounts)
    set mounts = null
    
    if (result != null) then
        call SelectUnitForPlayerSingle(result, whichPlayer)
        call SmartCameraPanToUnit(whichPlayer, result, 0.0)
    else
        call SimError(whichPlayer, GetLocalizedString("NO_MOUNTS"))
    endif
    
    return result
endfunction

private struct M
    public integer unitTypeId
    public boolean bonus
    public integer index
    
    public static method create takes integer unitTypeId, boolean bonus, integer index returns thistype
        local thistype this = thistype.allocate()
        set this.unitTypeId = unitTypeId
        set this.bonus = bonus
        set this.index = index
        return this
    endmethod
endstruct

globals
    public constant integer MOUNTS_HERO_LEVEL = 20
    public constant integer MOUNTS_CAGE = 'o04H'

    private M array mountTypes
    private integer mountTypesCounter = 0
    
    private trigger levelTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
    private trigger pickupItemTrigger = CreateTrigger()
    private trigger dropItemTrigger = CreateTrigger()
    private trigger sellTrigger = CreateTrigger()
    private boolean array playerHasMounts
endglobals

function GetMountTypesMax takes nothing returns integer
    return mountTypesCounter
endfunction

function GetPlayerHasMounts takes player whichPlayer returns boolean
    return playerHasMounts[GetPlayerId(whichPlayer)]
endfunction

function GetMountType takes integer index returns M
    return mountTypes[index]
endfunction

private function SetPlayerHasMounts takes player whichPlayer, boolean flag returns nothing
    set playerHasMounts[GetPlayerId(whichPlayer)] = flag
endfunction

private function GetMountTypeByUnitTypeId takes integer unitTypeId returns M
    local integer max = GetMountTypesMax()
    local integer i = 0
    loop
        exitwhen (i >= max)
        if (GetMountType(i).unitTypeId == unitTypeId) then
            return GetMountType(i)
        endif
        set i = i + 1
    endloop
    return 0
endfunction

function GetHeroCurrentMountUnitTypeId takes unit hero returns integer
    return GetMountType(GetMountDataByHero(hero).mountIndex).unitTypeId
endfunction

function IsMount takes integer unitTypeId returns boolean
    return GetMountTypeByUnitTypeId(unitTypeId) != 0
endfunction

function AddMountType takes integer unitTypeId, boolean isBonus returns M
    local integer index = mountTypesCounter
    local M m = M.create(unitTypeId, isBonus, index)
    set mountTypes[index] = m
    set mountTypesCounter = index + 1
    return m
endfunction

private function ReplaceMountAbility takes unit hero, string icon, string tooltip, string tooltipExtended returns nothing
    local ability a = BlzGetUnitAbility(hero, SUMMON_MOUNT_ABILITY_ID)
    if (a != null) then
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_ICON_NORMAL, 0, icon)
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL, 0, tooltip)
        call BlzSetAbilityStringLevelField(a, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0, tooltipExtended)
    endif
endfunction

private function ReplaceMountType takes unit hero, M m returns nothing
    local MountData mountData = GetMountDataByHero(hero)
    if (mountData != 0) then
        set mountData.mountIndex = m.index
        call ReplaceMountAbility(hero, BlzGetAbilityIcon(m.unitTypeId), Format(GetLocalizedString("SUMMON_X")).s(GetObjectName(m.unitTypeId)).result(), GetLocalizedString("SUMMON_MOUNT_TOOLTIP"))
    else
        call BJDebugMsg("Hero " + GetUnitName(hero) + " should not get any mount replaced.")
    endif
endfunction

function SetHeroMountTypeByUnitTypeId takes unit hero, integer unitTypeId returns nothing
    local M m = GetMountTypeByUnitTypeId(unitTypeId)
    if (m != 0) then
        call ReplaceMountType(hero, m)
    endif
endfunction

private function TriggerConditionLevel takes nothing returns boolean
    local unit hero = GetLevelingUnit()
    local player owner = GetOwningPlayer(hero)
    if (GetPlayerHero1(owner) == hero and GetHeroLevel(hero) >= MOUNTS_HERO_LEVEL and not GetPlayerHasMounts(owner)) then
        call SetPlayerHasMounts(owner, true)
    endif
    set hero = null
    set owner = null
    
    return false
endfunction

private function PickupMathosCage takes unit hero returns nothing
    local unit mount = MountGet(hero)
    if (mount != null) then
        call BlzSetUnitWeaponIntegerField(mount, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, GetHandleId(ATTACK_TYPE_CHAOS))
        call BlzSetUnitWeaponIntegerField(mount, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, GetHandleId(ATTACK_TYPE_CHAOS))
        call BlzSetUnitIntegerField(mount, UNIT_IF_DEFENSE_TYPE, GetHandleId(DEFENSE_TYPE_DIVINE))
        set mount = null
    endif
endfunction

private function SummonMountForHero takes unit hero returns nothing
    local MountData mountData = GetMountDataByHero(hero)
    local unit mount = null
    if (mountData != 0) then
        set mount = CreateUnit(GetOwningPlayer(hero), GetMountType(mountData.mountIndex).unitTypeId, GetUnitX(hero), GetUnitY(hero), GetUnitFacing(hero))
        call SummonUnitEffect(mount)
        call MountReplace(hero, mount)
        if (UnitHasItemOfTypeBJ(hero, MATHOGS_CAGE)) then
            call PickupMathosCage(hero)
        endif
    else
        call SimError(GetOwningPlayer(hero), GetLocalizedString("NO_MOUNT"))
    endif
endfunction

private function TriggerConditionSummonMount takes nothing returns boolean
    if (GetSpellAbilityId() == SUMMON_MOUNT_ABILITY_ID and IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and IsPlayerHero(GetTriggerUnit())) then
        call SummonMountForHero(GetTriggerUnit())
    endif
    return false
endfunction

private function DropMathosCage takes unit hero returns nothing
    local unit mount = MountGet(hero)
    if (mount != null) then
        call BlzSetUnitWeaponIntegerField(mount, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, GetHandleId(ATTACK_TYPE_HERO))
        call BlzSetUnitWeaponIntegerField(mount, UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 1, GetHandleId(ATTACK_TYPE_HERO))
        call BlzSetUnitIntegerField(mount, UNIT_IF_DEFENSE_TYPE, GetHandleId(DEFENSE_TYPE_HERO))
        set mount = null
    endif
endfunction

private function TriggerConditionPickupItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == MATHOGS_CAGE) then
        call PickupMathosCage(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionDropItem takes nothing returns boolean
    if (GetItemTypeId(GetManipulatedItem()) == MATHOGS_CAGE) then
        call DropMathosCage(GetTriggerUnit())
    endif
    return false
endfunction

function IsMountsShop takes integer unitTypeId returns boolean
    return unitTypeId == MOUNTS_SHOP or unitTypeId == MOUNTS_CAGE
endfunction

function IsUnitMountsShop takes unit whichUnit returns boolean
    return IsMountsShop(GetUnitTypeId(whichUnit))
endfunction

private function TriggerConditionSell takes nothing returns boolean
    local M m = 0
    if (IsUnitMountsShop(GetTriggerUnit())) then
        set m = GetMountTypeByUnitTypeId(GetUnitTypeId(GetSoldUnit()))
        if (m != 0) then
            call RemoveUnit(GetSoldUnit())
            if (GetMountDataByHero(GetBuyingUnit()) != 0) then
                call ReplaceMountType(GetBuyingUnit(), m)
            else
                call SimError(GetOwningPlayer(GetBuyingUnit()), GetLocalizedString("NO_MOUNT"))
            endif
        endif
    endif
    return false
endfunction

function UpdateMount takes unit hero returns nothing
    local MountData mountData = GetMountDataByHero(hero)
    if (mountData != 0) then
        call ReplaceMountType(hero, GetMountType(mountData.mountIndex))
    endif
endfunction

function AddMountsShop takes unit shop returns nothing
    local integer i = 0
    local integer max = GetMountTypesMax()
    call EnablePagedButtons(shop)
    call SetPagedButtonsSlotsPerPage(shop , 9)
    loop
        exitwhen (i == max)
        call AddPagedButtonsUnitType(shop, GetMountType(i).unitTypeId)
        set i = i + 1
    endloop
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set mountData1[i] = MountData.create()
        set mountData2[i] = MountData.create()
        set mountData3[i] = MountData.create()
        set i = i + 1
    endloop
    
    call TriggerRegisterAnyUnitEventBJ(levelTrigger, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddCondition(levelTrigger, Condition(function TriggerConditionLevel))
  
    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummonMount))
    
    call TriggerRegisterAnyUnitEventBJ(pickupItemTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(pickupItemTrigger, Condition(function TriggerConditionPickupItem))
    
    call TriggerRegisterAnyUnitEventBJ(dropItemTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(dropItemTrigger, Condition(function TriggerConditionDropItem))
    
    call TriggerRegisterAnyUnitEventBJ(sellTrigger, EVENT_PLAYER_UNIT_SELL)
    call TriggerAddCondition(sellTrigger, Condition(function TriggerConditionSell))
    
    // All mounts
    call AddMountType(GRYPHON_MOUNT, false)
    call AddMountType(WYVERN_MOUNT, false)
    call AddMountType(BAT_MOUNT, false)
    call AddMountType(EAGLE_MOUNT, false)
    call AddMountType(GREEN_DRAGON_MOUNT, false)
    call AddMountType(BLACK_DRAGON_MOUNT, false)
    call AddMountType(FROST_WYRM_MOUNT, false)
    call AddMountType(GARGOYLE_MOUNT, false)
    call AddMountType(CHIMAERA_MOUNT, false)
    call AddMountType(HIPPOGROPH_MOUNT, false)
    call AddMountType(NETHER_DRAKE_MOUNT, false)
    call AddMountType(COUATL_MOUNT, false)
    call AddMountType(DRAGONHAWK_MOUNT, false)
    call AddMountType(PHOENIX_MOUNT, false)
    call AddMountType(ALBATROSS_MOUNT, false)
    call AddMountType(PROTO_DRAKE_MOUNT, false)
    call AddMountType(CROW_MOUNT, false)
    call AddMountType(BEAR_MOUNT, false)
    call AddMountType(POLAR_BEAR_MOUNT, false)
    call AddMountType(GIANT_SEA_TURTLE_MOUNT, false)
    call AddMountType(HORSE_MOUNT, false)
    call AddMountType(UNDEAD_HORSE_MOUNT, false)
    call AddMountType(WHITE_TIGER_MOUNT, false)
    call AddMountType(ANCIENT_OF_WAR_MOUNT, false)
    call AddMountType(LYNX_MOUNT, false)
    call AddMountType(ELK_MOUNT, false)
    call AddMountType(KODO_BEAST_MOUNT, false)
    call AddMountType(RAPTOR_MOUNT, false)
    call AddMountType(DIREHORN_MOUNT, false)
    call AddMountType(MECHANOSTRIDER_MOUNT, false)
    call AddMountType(FLYING_MACHINE_MOUNT, false)
    call AddMountType(ZEPPELIN_MOUNT, false)
    call AddMountType(CLOUD_SERPENT_MOUNT, false)
    call AddMountType(BRUTOSAUR_MOUNT, false)
    call AddMountType(TALBUK_MOUNT, false)
    call AddMountType(PANTHER_MOUNT, false)
    call AddMountType(WOLF_MOUNT, false)
    call AddMountType(DWARF_CAR_MOUNT, true)
    call AddMountType(ORC_CAR_MOUNT, true)
    call AddMountType(UNDEAD_CAR_MOUNT, true)
    call AddMountType(DEMON_CAR_MOUNT, true)
    call AddMountType(GOBLIN_CAR_MOUNT, true)
    call AddMountType(NIGHT_ELF_CAR_MOUNT, true)
    call AddMountType(SHIP_MOUNT, false)
    call AddMountType(SUBMARINE_MOUNT, false)
    call AddMountType(SNOWY_OWL_MOUNT, false)
endfunction

endlibrary
