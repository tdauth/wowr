library WoWReforgedProfessionHunter initializer Init requires ItemCarrierGroups

globals
    private filterfunc filterIsCritterWithTrophy = null

    private integer array trophyUnitTypeIds
    private integer array trophyItemTypeIds
    private integer trophyCounter = 0

    private timer spawnCrittersTimer = CreateTimer()
    private group critterSpawners = CreateGroup()
    private trigger constructFinishTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger damageTrigger = CreateTrigger()
    private trigger summonTrigger = CreateTrigger()
    private trigger channelTrigger = CreateTrigger()
endglobals

function GetCritterSpawnerTimerHandleId takes nothing returns integer
    return GetHandleId(spawnCrittersTimer)
endfunction

private function SpawnRandomCritter takes real x, real y, real face returns unit
    return CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), trophyUnitTypeIds[GetRandomInt(0, trophyCounter)], x, y, face)
endfunction

private function EnumSpawnCritter takes nothing returns nothing
    call SpawnRandomCritter(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), GetRandomDirectionDeg())
endfunction

private function TimerFunctionSpawnCritters takes nothing returns nothing
    call ForGroup(critterSpawners, function EnumSpawnCritter)
endfunction

private function AddCritterSpawner takes unit whichUnit returns nothing
    if (BlzGroupGetSize(critterSpawners) == 0) then
        call TimerStart(spawnCrittersTimer, 120.0, true, function TimerFunctionSpawnCritters)
    endif
    call GroupAddUnit(critterSpawners, whichUnit)
endfunction

private function RemoveCritterSpawner takes unit whichUnit returns nothing
    if (IsUnitInGroup(whichUnit, critterSpawners)) then
        call GroupRemoveUnit(critterSpawners, whichUnit)
        if (BlzGroupGetSize(critterSpawners) == 0) then
            call PauseTimer(spawnCrittersTimer)
        endif
    endif
endfunction

function GetTrophyCounter takes nothing returns integer
    return trophyCounter
endfunction

function GetTrophyUnitTypeId takes integer index returns integer
    return trophyUnitTypeIds[index]
endfunction

function GetTrophyItemTypeId takes integer index returns integer
    return trophyItemTypeIds[index]
endfunction

function GetRandomTrophyItemTypeId takes nothing returns integer
    return trophyItemTypeIds[GetRandomInt(0, trophyCounter - 1)]
endfunction

function IsCritter takes integer unitTypeId returns boolean
    local integer i = 0
    loop
        exitwhen (i == trophyCounter)
        if (trophyUnitTypeIds[i] == unitTypeId) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function IsUnitCritter takes unit whichUnit returns boolean
    return IsCritter(GetUnitTypeId(whichUnit))
endfunction

private function IsTrophy takes integer itemTypeId returns boolean
    local integer i = 0
    loop
        exitwhen (i == trophyCounter)
        if (trophyItemTypeIds[i] == itemTypeId) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function GetUnitTypeIdTrophy takes integer unitTypeId returns integer
    local integer i = 0
    loop
        exitwhen (i == trophyCounter)
        if (trophyUnitTypeIds[i] == unitTypeId) then
            return trophyItemTypeIds[i]
        endif
        set i = i + 1
    endloop
    return 0
endfunction

private function AddTrophy takes integer unitTypeId, integer itemTypeId returns integer
    local integer index = trophyCounter
    set trophyUnitTypeIds[index] = unitTypeId
    set trophyItemTypeIds[index] = itemTypeId
    set trophyCounter = trophyCounter + 1
    return index
endfunction

private function GetUnitTypeIdHasTrophy takes integer unitTypeId returns boolean
    return GetUnitTypeIdTrophy(unitTypeId) != 0
endfunction

private function DropTrophies takes unit whichUnit returns nothing
    local integer itemTypeId = GetUnitTypeIdTrophy(GetUnitTypeId(whichUnit))
    if (itemTypeId != 0) then
        call UnitDropItem(whichUnit, itemTypeId)
    endif
endfunction

private function DuplicateTrophies takes unit whichUnit returns nothing
    local item slotItem = null
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_INVENTORY)
        set slotItem = UnitItemInSlot(whichUnit, i)
        if (slotItem != null and IsTrophy(GetItemTypeId(slotItem))) then
            call SetItemCharges(slotItem, IMaxBJ(1, GetItemCharges(slotItem)) + 1)
        endif
        set slotItem = null
        set i = i + 1
    endloop
    call UnitDropItem(whichUnit, GetRandomTrophyItemTypeId())
    call UnitDropItem(whichUnit, GetRandomTrophyItemTypeId())
endfunction

function TrophiesInfo takes player whichPlayer returns string
    local string msg = GetLocalizedString("TROPHIES")
    local integer i = 0
    loop
        exitwhen (i == trophyCounter)
        if (i > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + GetObjectName(trophyItemTypeIds[i]) + " (" + GetObjectName(trophyUnitTypeIds[i]) + ")"
        set i = i + 1
    endloop
    return msg
endfunction

private function TrackCittersAndTrophies takes unit caster returns nothing
    local group g = CreateGroup()
    local integer i = 0
    local integer max = 0
    local unit u = null
    local player owner = GetOwningPlayer(caster)
    call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 512.0, filterIsCritterWithTrophy)
    set max = BlzGroupGetSize(g)
    set i = 0
    loop
        exitwhen (i == max)
        set u = BlzGroupUnitAt(g, i)
        call PingMinimapForPlayer(owner, GetUnitX(u), GetUnitY(u), 12.0)
        set u = null
        set i = i + 1
    endloop
    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    set caster = null
endfunction

private function IsCritterWithTrophy takes nothing returns boolean
    return GetUnitTypeIdHasTrophy(GetUnitTypeId(GetFilterUnit()))
endfunction

private function TriggerConditionConstructFinish takes nothing returns boolean
    if (GetUnitTypeId(GetConstructedStructure()) == HUNTING_CAMP) then
        call AddCritterSpawner(GetConstructedStructure())
    endif
    return false
endfunction

private function TriggerConditionDeath takes nothing returns boolean
    call RemoveCritterSpawner(GetTriggerUnit())
    // marked target dies or any target got killed by hunter
    if (UnitHasBuffBJ(GetTriggerUnit(), 'B03D') or (GetKillingUnit() != null and IsUnitInItemCarrierGroup(GetKillingUnit(), ITEM_HUNTING_BOW))) then
        call DropTrophies(GetTriggerUnit())
    endif
    if (IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) and IsUnitInItemCarrierGroup(GetTriggerUnit(), ITEM_HUNTING_BOW)) then
        call RemoveUnitFromItemCarrierGroup(ITEM_HUNTING_BOW, GetTriggerUnit())
    endif
    if (GetUnitTypeId(GetTriggerUnit()) == SKINNING_RACK) then
        call DuplicateTrophies(GetTriggerUnit())
    endif
    return false
endfunction

private function TriggerConditionOrder takes nothing returns boolean
    local integer orderId = GetIssuedOrderId()
    if ((orderId == ORDER_ID_SMART or orderId == ORDER_ID_MOVE) and IsUnitInItemCarrierGroup(GetTriggerUnit(), ITEM_HUNTING_BOW) and GetUnitTypeIdHasTrophy(GetUnitTypeId(GetOrderTargetUnit()))) then
        call IssueTargetOrder(GetTriggerUnit(), "attack", GetOrderTargetUnit())
    endif
    return false
endfunction

private function TriggerActionDamage takes nothing returns nothing
    local unit dummy = null
    if (IsUnitInItemCarrierGroup(GetEventDamageSource(), ITEM_HUNTING_BOW) and GetUnitTypeIdHasTrophy(GetUnitTypeId(GetTriggerUnit())) ) then
        set dummy = CreateUnit(GetOwningPlayer(GetEventDamageSource()), 'h0T7', GetUnitX(GetEventDamageSource()), GetUnitY(GetEventDamageSource()), bj_UNIT_FACING)
        call IssueTargetOrder(dummy, "slow", GetTriggerUnit())
        call ShowUnit(dummy, true)
        call SetUnitInvulnerable(dummy, true)
        call PolledWait(2.0)
        call RemoveUnit(dummy)
        set dummy = null
    endif
endfunction

private function TriggerConditionSummon takes nothing returns boolean
    if (GetUnitTypeId(GetSummonedUnit()) == HUNTING_DOG or GetUnitTypeId(GetSummonedUnit()) == BEAR_TRAP) then
        call AddUnitToItemCarrierGroup(ITEM_HUNTING_BOW, GetSummonedUnit())
    endif
    return false
endfunction

private function TriggerConditionChannel takes nothing returns boolean
    if (GetSpellAbilityId() == 'A1Z8') then // Track (Hunting Dog)
        call TrackCittersAndTrophies(GetTriggerUnit())
    endif
    return false
endfunction

private function Init takes nothing returns nothing
    set filterIsCritterWithTrophy = Filter(function IsCritterWithTrophy)

    call TriggerRegisterAnyUnitEventBJ(constructFinishTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(constructFinishTrigger, Condition(function TriggerConditionConstructFinish))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))

    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))

    call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DAMAGED)
    call TriggerAddAction(damageTrigger, function TriggerActionDamage)

    call TriggerRegisterAnyUnitEventBJ(summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddCondition(summonTrigger, Condition(function TriggerConditionSummon))

    call TriggerRegisterAnyUnitEventBJ(channelTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddCondition(channelTrigger, Condition(function TriggerConditionChannel))

    call AddItemCarrierGroup(ITEM_HUNTING_BOW)

    call AddTrophy(STAG, ITEM_ANTLER)
    call AddTrophy(PIG, ITEM_PIG_SKIN)
    call AddTrophy(SHEEP, ITEM_SHEEP_WOOL)
    call AddTrophy(FROG, ITEM_FROG_LEGS)
    call AddTrophy(SNOWY_OWL, ITEM_SNOWY_OWL_FEATHER)
    call AddTrophy(RABBIT, ITEM_RABBIT_SKIN)
    call AddTrophy(HERMIT_CRAB, ITEM_HERMIT_CRAB_SHELL)
    call AddTrophy(CRAB, ITEM_CRAB_SHELL)
    call AddTrophy(FEL_BOAR, ITEM_FEL_BOAR_SKIN)
    call AddTrophy(BEE, ITEM_BEE_STING)
    call AddTrophy(RACCOON, ITEM_RACOON_SKIN)
    call AddTrophy(ALBATROSS, ITEM_ALBATROSS_PLUMAGE)
    call AddTrophy(SKINK, ITEM_SKINK_SKIN)
    call AddTrophy(RAT, ITEM_RATS_TAIL)
    call AddTrophy(DOG, ITEM_DOG_SKIN)
    call AddTrophy(DUNE_WORM, ITEM_DUNE_WORM_PISS)
    call AddTrophy(PENGUIN, ITEM_PENGUIN_WINGS)
    call AddTrophy(SEAL, ITEM_SEAL_BLUBBER)
    call AddTrophy(VULTURE, ITEM_VULTURE_FEATHER)
    call AddTrophy(TALBUK, ITEM_TALBUK_ANTLER)
    call AddTrophy(RAVEN, ITEM_RAVEN_FEATHER)
    call AddTrophy(PARROT, ITEM_PARROT_FEATHER)
    call AddTrophy(FOX, ITEM_FOX_SKIN)
    call AddTrophy(HEDGEHOG, ITEM_HEDGEHOG_SKIN)
    call AddTrophy(PIGEON, ITEM_PIGEON_FEATHER)
    call AddTrophy(TURTLE, ITEM_TURTLE_SHELL)
endfunction

hook RemoveUnit RemoveCritterSpawner

endlibrary
