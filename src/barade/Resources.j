library Resources initializer Init requires SimError, MathUtils, StringFormat

globals
    public constant real GOLD_GOLD_EXCHANGE_RATE = 1.0
    public constant real LUMBER_GOLD_EXCHANGE_RATE = 2.0
    public constant real FOOD_GOLD_EXCHANGE_RATE = 0.0
    public constant real FOOD_MAX_GOLD_EXCHANGE_RATE = 0.0
    public constant string GOLD_ICON = "UI\\Feedback\\Resources\\ResourceGold.blp"
    public constant string GOLD_ICON_ATT = "UI\\Widgets\\Console\\Human\\infocard-gold.blp"
    public constant string LUMBER_ICON = "UI\\Feedback\\Resources\\ResourceLumber.blp"
    public constant string LUMBER_ICON_ATT = "UI\\Feedback\\Resources\\ResourceLumber.blp"
    public constant string FOOD_ICON = "UI\\Feedback\\Resources\\ResourceSupply.blp"
    public constant string FOOD_ICON_ATT = "UI\\Widgets\\Console\\Human\\infocard-supply.blp"
    public constant string FOOD_MAX_ICON = "UI\\Feedback\\Resources\\ResourceSupply.blp"
    public constant string FOOD_MAX_ICON_ATT = "UI\\Widgets\\Console\\Human\\infocard-supply.blp"
    
    private hashtable h = InitHashtable()
    private trigger castTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger orderResetTrigger = CreateTrigger()
    private trigger returnTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
    private group mines = CreateGroup()
    private group workers = CreateGroup()
    private group returnBuildings = CreateGroup()
    
    // callbacks
    private trigger array callbackTriggers
    private integer callbackTriggersCounter = 0
    private trigger array callbackReturnTriggers
    private integer callbackReturnTriggersCounter = 0
    private trigger array callbackDeathTriggers
    private integer callbackDeathTriggersCounter = 0
    private unit triggerMine = null
    private unit triggerReturnBuilding = null
    private unit triggerDyingResourceUnit = null
    private unit triggerWorker = null
    private Resource triggerResource = 0
    private integer triggerResourceAmount = 0
    
    private constant integer KEY_RESOURCE = 0
    private constant integer KEY_MAX_RESOURCE = 1
    private constant integer KEY_RESOURCE_PER_HIT = 2
    private constant integer KEY_MINE = 3
    private constant integer KEY_RETURN_RESOURCE = 4
    private constant integer KEY_HARVEST_ORDER_ID = 5
    private constant integer KEY_HARVEST_ABILITY_ID = 6
    private constant integer KEY_RETURN_ORDER_ID = 7
    private constant integer KEY_RETURN_ABILITY_ID = 8
    private constant integer KEY_RETURN_HIDDEN_ORDER_ID = 9
    private constant integer KEY_RETURN_HIDDEN_ABILITY_ID = 10
    private constant integer KEY_HARVEST_DURATION = 11
    private constant integer KEY_EXPLODE_ON_DEATH = 12
    private constant integer KEY_MINE_WORKERS = 13
    private constant integer KEY_MAX_MINE_WORKERS = 14
    private constant integer KEY_TAKE_WORKER_INSIDE = 15
    private constant integer KEY_ANIMATION_PROPERTIES = 16
    private constant integer KEY_SKIN = 17
    private constant integer KEY_QUEUE_TIMER = 18
    private constant integer KEY_QUEUE_WORKER_RELEASE_TIMER = 19
    private constant integer KEY_DISABLE_STOP_MINING_ON_ERROR = 20
    private constant integer KEY_MAX = 21
endglobals

private function GetAlliesWithSharedControl takes player owner returns force
    local force allies = CreateForce()
    local player slotPlayer = null
    local integer i = 0
    call ForceAddPlayer(allies, owner)
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        set slotPlayer = Player(i)
        if (slotPlayer == owner or GetPlayerAlliance(owner, slotPlayer, ALLIANCE_SHARED_ADVANCED_CONTROL)) then
            call ForceAddPlayer(allies, slotPlayer)
        endif
        set slotPlayer = null
        set i = i + 1
    endloop
    return allies
endfunction

private function ShowFadingTextTag takes unit worker, integer amount, integer red, integer green, integer blue returns nothing
    local texttag textTag = CreateTextTag()
    local force allies = GetAlliesWithSharedControl(GetOwningPlayer(worker))
    call SetTextTagText(textTag, "+" + I2S(amount), 0.024)
    call SetTextTagPos(textTag, GetUnitX(worker), GetUnitY(worker), 0.0)
    call SetTextTagColor(textTag, red, green, blue, 255)
    call SetTextTagVelocity(textTag, 0.0, 0.03)
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call SetTextTagVisibility(textTag, true)
    endif
    call SetTextTagFadepoint(textTag, 2.0)
    call SetTextTagLifespan(textTag, 3.0)
    call SetTextTagPermanent(textTag, false)
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
    set textTag = null
endfunction

// u0 - worker/source
// u1 - return building/mine/target
private function MovementTypesMatch takes unit u0, unit u1 returns boolean
    local movetype mt0 = ConvertMoveType(BlzGetUnitIntegerField(u0, UNIT_IF_MOVE_TYPE))
    local real targetX = GetUnitX(u1)
    local real targetY = GetUnitY(u1)
    // air
    if (mt0 == MOVE_TYPE_FLY  and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_FLYABILITY)) then
        return true
    // water or ground
    elseif (mt0 == MOVE_TYPE_AMPHIBIOUS  and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_AMPHIBIOUSPATHING)) then
        return true
    // water
    elseif (mt0 == MOVE_TYPE_FLOAT and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_FLOATABILITY)) then
        return true
    // ground
    elseif ((mt0 == MOVE_TYPE_FOOT or mt0 == MOVE_TYPE_HORSE or mt0 == MOVE_TYPE_HOVER) and not IsTerrainPathable(targetX, targetY, PATHING_TYPE_WALKABILITY)) then
        return true
    endif
    
    return false
endfunction

struct Resource
    string name
    string icon
    string iconAtt
    string description
    real goldExchangeRate = 1.0
    integer red
    integer blue
    integer green
    integer array playerAmount[28]
    integer array playerBonus[28]
    integer array playerUpkeepRate[28]
    static Resource array resources
    static integer resourcesCount = 0
    
    public static method create takes string name returns thistype
        local thistype this = thistype.allocate()
        local integer i = 0
        set this.name = name
        set this.goldExchangeRate = goldExchangeRate
        set thistype.resources[thistype.resourcesCount] = this
        set thistype.resourcesCount = thistype.resourcesCount + 1
        return this
    endmethod
    
endstruct

function GetResource takes integer index returns Resource
    return Resource.resources[index]
endfunction

function GetMaxResources takes nothing returns integer
    return Resource.resourcesCount
endfunction

function GetResourceInfo takes Resource r, player whichPlayer returns string
    return r.name + " (" + R2SW(r.goldExchangeRate, 0, 1) + ") - " + I2S(r.playerAmount[GetPlayerId(whichPlayer)])
endfunction

function GetAllResourcesInfo takes player whichPlayer returns string
    local string msg = "Resources: "
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        if (i > 0) then
            set msg = msg + ", "
        endif
        set msg = msg + I2S(i) + ": " + GetResourceInfo(GetResource(i), whichPlayer)
        set i = i + 1
    endloop
    return msg
endfunction

function AddResource takes string name returns Resource
    return Resource.create(name)
endfunction

function SetResourceName takes Resource resource, string name returns nothing
    set resource.name = resource.name
endfunction

function GetResourceName takes Resource resource returns string
    return resource.name
endfunction

function SetResourceIcon takes Resource resource, string icon returns nothing
    set resource.icon = icon
endfunction

function GetResourceIcon takes Resource resource returns string
    return resource.icon
endfunction

function SetResourceIconAtt takes Resource resource, string icon returns nothing
    set resource.iconAtt = icon
endfunction

function GetResourceIconAtt takes Resource resource returns string
    return resource.iconAtt
endfunction

function SetResourceDescription takes Resource resource, string description returns nothing
    set resource.description = description
endfunction

function GetResourceDescription takes Resource resource returns string
    return resource.description
endfunction

function SetResourceGoldExchangeRate takes Resource resource, real goldExchangeRate returns nothing
    set resource.goldExchangeRate = goldExchangeRate
endfunction

function GetResourceGoldExchangeRate takes Resource resource returns real
    return resource.goldExchangeRate
endfunction

function SetResourceColorRed takes Resource resource, integer red returns nothing
    set resource.red = red
endfunction

function GetResourceColorRed takes Resource resource returns integer
    return resource.red
endfunction

function SetResourceColorGreen takes Resource resource, integer green returns nothing
    set resource.green = green
endfunction

function GetResourceColorGreen takes Resource resource returns integer
    return resource.green
endfunction

function SetResourceColorBlue takes Resource resource, integer blue returns nothing
    set resource.blue = blue
endfunction

function GetResourceColorBlue takes Resource resource returns integer
    return resource.blue
endfunction

globals
    public Resource GOLD = 0
    public Resource LUMBER = 0
    public Resource FOOD = 0
    public Resource FOOD_MAX = 0
endglobals

function SetPlayerResource takes player whichPlayer, Resource resource, integer amount returns nothing
    set resource.playerAmount[GetPlayerId(whichPlayer)] = amount
    if (resource == GOLD) then
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, amount)
    elseif (resource == LUMBER) then
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER, amount)
    endif
endfunction

function GetPlayerResource takes player whichPlayer, Resource resource returns integer
    if (resource == GOLD) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD)
    elseif (resource == LUMBER) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_LUMBER)
     elseif (resource == FOOD) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_USED)
    elseif (resource == FOOD_MAX) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP)
    endif
    
    return resource.playerAmount[GetPlayerId(whichPlayer)]
endfunction

function SetPlayerResourceBonus takes player whichPlayer, Resource resource, integer bonus returns nothing
    set resource.playerBonus[GetPlayerId(whichPlayer)] = bonus
endfunction

function GetPlayerResourceBonus takes player whichPlayer, Resource resource returns integer
    return resource.playerBonus[GetPlayerId(whichPlayer)]
endfunction

function AddPlayerResourceBonus takes player whichPlayer, Resource resource, integer bonus returns nothing
    call SetPlayerResourceBonus(whichPlayer, resource, GetPlayerResourceBonus(whichPlayer, resource) + bonus)
endfunction

function RemovePlayerResourceBonus takes player whichPlayer, Resource resource, integer bonus returns nothing
    call SetPlayerResourceBonus(whichPlayer, resource, GetPlayerResourceBonus(whichPlayer, resource) - bonus)
endfunction

function AddPlayerResource takes player whichPlayer, Resource resource, integer amount returns nothing
    call SetPlayerResource(whichPlayer, resource, GetPlayerResource(whichPlayer, resource) + amount)
endfunction

function RemovePlayerResource takes player whichPlayer, Resource resource, integer amount returns nothing
    call SetPlayerResource(whichPlayer, resource, IMaxBJ(0, GetPlayerResource(whichPlayer, resource) - amount))
endfunction

function SetPlayerResourceUpkeepRate takes player whichPlayer, Resource resource, integer upkeepRate returns nothing
    set resource.playerUpkeepRate[GetPlayerId(whichPlayer)] = upkeepRate
endfunction

function GetPlayerResourceUpkeepRate takes player whichPlayer, Resource resource returns integer
    if (resource == GOLD) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_GOLD_UPKEEP_RATE)
    elseif (resource == LUMBER) then
        return GetPlayerState(whichPlayer, PLAYER_STATE_LUMBER_UPKEEP_RATE)
    endif
    return resource.playerUpkeepRate[GetPlayerId(whichPlayer)]
endfunction

function GivePlayerResource takes player from, player to, Resource resource, integer amount, real cost returns integer
    local integer actualAmount = R2I(I2R(amount) * cost)
    set actualAmount = IMaxBJ(GetPlayerResource(from, resource), actualAmount)
    call RemovePlayerResource(from, resource, actualAmount)
    call AddPlayerResource(to, resource, actualAmount)
    return actualAmount
endfunction

function GetExchangedResource takes Resource source, Resource target, integer amount returns integer
    return R2I(source.goldExchangeRate * I2R(amount) / target.goldExchangeRate)
endfunction

function ExchangePlayerResource takes player whichPlayer, Resource source, Resource target, integer amount returns integer
    local integer actualAmount = IMinBJ(GetPlayerResource(whichPlayer, source), amount)
    local integer targetAmount = GetExchangedResource(source, target, actualAmount)
    
    //call BJDebugMsg("Get target amount " + I2S(targetAmount) + " with source gold exchange rate " + R2S(source.goldExchangeRate) + " and source resource name " + GetResourceName(source))
    
    if (targetAmount > 0) then
        call RemovePlayerResource(whichPlayer, source, actualAmount)
        call AddPlayerResource(whichPlayer, target, targetAmount)
    endif
    
    return targetAmount
endfunction

function GetUnitResource takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RESOURCE, KEY_MAX))
endfunction

function SetUnitResource takes unit whichUnit, Resource r, integer amount returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RESOURCE, KEY_MAX), amount)
endfunction

function SetUnitResourceMax takes unit whichUnit, Resource r, integer max returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_MAX_RESOURCE, KEY_MAX), max)
endfunction

function GetUnitResourceMax takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_MAX_RESOURCE, KEY_MAX))
endfunction

function SetUnitResourcePerHit takes unit whichUnit, Resource r, integer amount returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RESOURCE_PER_HIT, KEY_MAX), amount)
endfunction

function GetUnitResourcePerHit takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RESOURCE_PER_HIT, KEY_MAX))
endfunction

function SetUnitMine takes unit whichUnit, unit mine returns nothing
    call SaveUnitHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_MINE, KEY_MAX), mine)
endfunction

function GetUnitMine takes unit whichUnit returns unit
    return LoadUnitHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_MINE, KEY_MAX))
endfunction

function SetUnitReturnResource takes unit whichUnit, Resource r, boolean allow returns nothing
    call SaveBoolean(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_RESOURCE, KEY_MAX), allow)
endfunction

function GetUnitReturnResource takes unit whichUnit, Resource r returns boolean
    return LoadBoolean(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_RESOURCE, KEY_MAX))
endfunction

function AddUnitReturnResource takes unit whichUnit, Resource r returns nothing
    call SetUnitReturnResource(whichUnit, r, true)
endfunction

function SetUnitHarvestOrderId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_ORDER_ID, KEY_MAX), orderId)
endfunction

function GetUnitHarvestOrderId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_ORDER_ID, KEY_MAX))
endfunction

function SetUnitHarvestAbilityId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_ABILITY_ID, KEY_MAX), orderId)
endfunction

function GetUnitHarvestAbilityId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_ABILITY_ID, KEY_MAX))
endfunction

function SetUnitReturnOrderId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_ORDER_ID, KEY_MAX), orderId)
endfunction

function GetUnitReturnOrderId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_ORDER_ID, KEY_MAX))
endfunction

function SetUnitReturnAbilityId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_ABILITY_ID, KEY_MAX), orderId)
endfunction

function GetUnitReturnAbilityId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_ABILITY_ID, KEY_MAX))
endfunction

function SetUnitReturnHiddenOrderId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_HIDDEN_ORDER_ID, KEY_MAX), orderId)
endfunction

function GetUnitReturnHiddenOrderId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_HIDDEN_ORDER_ID, KEY_MAX))
endfunction

function SetUnitReturnHiddenAbilityId takes unit whichUnit, Resource r, integer orderId returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_HIDDEN_ABILITY_ID, KEY_MAX), orderId)
endfunction

function GetUnitReturnHiddenAbilityId takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_RETURN_HIDDEN_ABILITY_ID, KEY_MAX))
endfunction

function IsMine takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, mines)
endfunction

function SetUnitHarvestDuration takes unit whichUnit, Resource r, real duration returns nothing
    call SaveReal(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_DURATION, KEY_MAX), duration)
endfunction

function GetUnitHarvestDuration takes unit whichUnit, Resource r returns real
    return LoadReal(h, GetHandleId(whichUnit), Index2D(r, KEY_HARVEST_DURATION, KEY_MAX))
endfunction

function SetMineExplodesOnDeath takes unit mine, boolean explode returns nothing
    call SaveBoolean(h, GetHandleId(mine), Index2D(0, KEY_EXPLODE_ON_DEATH, KEY_MAX), explode)
endfunction

function GetMineExplodesOnDeath takes unit mine returns boolean
    return LoadBoolean(h, GetHandleId(mine), Index2D(0, KEY_EXPLODE_ON_DEATH, KEY_MAX))
endfunction

function SetMineWorkers takes unit mine, group workers returns nothing
    call SaveGroupHandle(h, GetHandleId(mine), Index2D(0, KEY_MINE_WORKERS, KEY_MAX), workers)
endfunction

function GetMineWorkers takes unit mine returns group
    return LoadGroupHandle(h, GetHandleId(mine), Index2D(0, KEY_MINE_WORKERS, KEY_MAX))
endfunction

function SetMineMaxWorkers takes unit mine, integer max returns nothing
    call SaveInteger(h, GetHandleId(mine), Index2D(0, KEY_MAX_MINE_WORKERS, KEY_MAX), max)
endfunction

function GetMineMaxWorkers takes unit mine returns integer
    return LoadInteger(h, GetHandleId(mine), Index2D(0, KEY_MAX_MINE_WORKERS, KEY_MAX))
endfunction

function SetMineTakeWorkerInside takes unit mine, boolean take returns nothing
    call SaveBoolean(h, GetHandleId(mine), Index2D(0, KEY_TAKE_WORKER_INSIDE, KEY_MAX), take)
endfunction

function GetMineTakeWorkerInside takes unit mine returns boolean
    return LoadBoolean(h, GetHandleId(mine), Index2D(0, KEY_TAKE_WORKER_INSIDE, KEY_MAX))
endfunction

function SetUnitResourceAnimationProperties takes unit whichUnit, Resource r, string animationProperties returns nothing
    call SaveStr(h, GetHandleId(whichUnit), Index2D(r, KEY_ANIMATION_PROPERTIES, KEY_MAX), animationProperties)
endfunction

function GetUnitResourceAnimationProperties takes unit whichUnit, Resource r returns string
    return LoadStr(h, GetHandleId(whichUnit), Index2D(r, KEY_ANIMATION_PROPERTIES, KEY_MAX))
endfunction

function SetUnitResourceSkin takes unit whichUnit, Resource r, integer skin returns nothing
    call SaveInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_SKIN, KEY_MAX), skin)
endfunction

function GetUnitResourceSkin takes unit whichUnit, Resource r returns integer
    return LoadInteger(h, GetHandleId(whichUnit), Index2D(r, KEY_SKIN, KEY_MAX))
endfunction

function SetUnitQueueTimer takes unit whichUnit, timer t returns nothing
    call SaveTimerHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_QUEUE_TIMER, KEY_MAX), t)
endfunction

function GetUnitQueueTimer takes unit whichUnit returns timer
    return LoadTimerHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_QUEUE_TIMER, KEY_MAX))
endfunction

function SetUnitQueueWorkerReleaseTimer takes unit whichUnit, timer t returns nothing
    call SaveTimerHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_QUEUE_WORKER_RELEASE_TIMER, KEY_MAX), t)
endfunction

function GetUnitQueueWorkerReleaseTimer takes unit whichUnit returns timer
    return LoadTimerHandle(h, GetHandleId(whichUnit), Index2D(0, KEY_QUEUE_WORKER_RELEASE_TIMER, KEY_MAX))
endfunction

function SetUnitDisableStopMiningOnError takes unit whichUnit, boolean disable returns nothing
    call SaveBoolean(h, GetHandleId(whichUnit), Index2D(0, KEY_DISABLE_STOP_MINING_ON_ERROR, KEY_MAX), disable)
endfunction

function GetUnitDisableStopMiningOnError takes unit whichUnit returns boolean
    return LoadBoolean(h, GetHandleId(whichUnit), Index2D(0, KEY_DISABLE_STOP_MINING_ON_ERROR, KEY_MAX))
endfunction

function AddMine takes unit whichUnit returns nothing
    call GroupAddUnit(mines, whichUnit)
    call SetMineWorkers(whichUnit, CreateGroup())
endfunction

function AddMineEx takes unit whichUnit, Resource resource, integer amount returns nothing
    call AddMine(whichUnit)
    call SetUnitResource(whichUnit, resource, amount)
    call SetMineExplodesOnDeath(whichUnit, true)
    call SetMineTakeWorkerInside(whichUnit, false)
endfunction

function RemoveMine takes unit whichUnit returns nothing
    call GroupRemoveUnit(mines, whichUnit)
    if (GetMineWorkers(whichUnit) != null) then
        call DestroyGroup(GetMineWorkers(whichUnit))
    endif
endfunction

function IsWorker takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, workers)
endfunction

function AddWorker takes unit whichUnit returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    call GroupAddUnit(workers, whichUnit)
endfunction

function AddAllResourcesToWorker takes unit worker, integer maxResource, integer resourcePerHit returns nothing
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        call SetUnitResourceMax(worker, GetResource(i), maxResource)
        call SetUnitResourcePerHit(worker, GetResource(i), resourcePerHit)
        set i = i + 1
    endloop
endfunction

function AddResourceToWorker takes unit worker, Resource resource, integer abilityId, string order, integer returnAbilityId, string returnOrder, integer returnHiddenAbilityId, string returnHiddenOrder, integer max, integer perHit, string animationProperties returns nothing
    call SetUnitHarvestAbilityId(worker, resource, abilityId)
    call SetUnitHarvestOrderId(worker, resource, OrderId(order))
    call SetUnitReturnAbilityId(worker, resource, returnAbilityId)
    call SetUnitReturnOrderId(worker, resource, OrderId(returnOrder))
    call SetUnitReturnHiddenAbilityId(worker, resource, returnHiddenAbilityId)
    call SetUnitReturnHiddenOrderId(worker, resource, OrderId(returnHiddenOrder))
    call SetUnitResourceMax(worker, resource, max)
    call SetUnitResourcePerHit(worker, resource, perHit)
    call SetUnitResourceAnimationProperties(worker, resource, animationProperties)
    // do not ever add the abilities twice since they will be permanently hidden
    if (GetUnitAbilityLevel(worker, abilityId) == 0) then
        call UnitAddAbility(worker, abilityId)
        call UnitMakeAbilityPermanent(worker, true, abilityId)
    endif
    if (GetUnitAbilityLevel(worker, returnAbilityId) == 0) then
        call UnitAddAbility(worker, returnAbilityId)
        call UnitMakeAbilityPermanent(worker, true, returnAbilityId)
        call BlzUnitHideAbility(worker, returnAbilityId, true)
    endif
    if (GetUnitAbilityLevel(worker, returnHiddenAbilityId) == 0) then
        call UnitAddAbility(worker, returnHiddenAbilityId)
        call UnitMakeAbilityPermanent(worker, true, returnHiddenAbilityId)
    endif
    
endfunction

function RemoveWorker takes unit whichUnit returns nothing
    call GroupRemoveUnit(workers, whichUnit)
endfunction

function IsReturnBuilding takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, returnBuildings)
endfunction

function AddReturnBuilding takes unit whichUnit returns nothing
    call GroupAddUnit(returnBuildings, whichUnit)
endfunction

function AddReturnBuildingEx takes unit whichUnit, Resource r returns nothing
    call AddReturnBuilding(whichUnit)
    call SetUnitReturnResource(whichUnit, r, true)
endfunction

function RemoveReturnBuilding takes unit whichUnit returns nothing
    call GroupRemoveUnit(returnBuildings, whichUnit)
endfunction

function CustomBountyFadingText takes unit worker, Resource resource, integer amount returns nothing
    call ShowFadingTextTag(worker, amount, GetResourceColorRed(resource), GetResourceColorGreen(resource), GetResourceColorBlue(resource))
endfunction

function CustomBountyEx takes unit worker, player whichPlayer, Resource resource, integer amount returns nothing
    call AddPlayerResource(whichPlayer, resource, amount)
    call CustomBountyFadingText(worker, resource, amount)
endfunction

function CustomBounty takes unit worker, Resource resource, integer amount returns nothing
    call CustomBountyEx(worker, GetOwningPlayer(worker), resource, amount)
endfunction

function GetWorkerTotalResources takes unit worker returns integer
    local integer i = 0
    local integer result = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        set result = result + GetUnitResource(worker, GetResource(i))
        set i = i + 1
    endloop
    return result
endfunction

function TriggerRegisterGatherEvent takes trigger whichTrigger returns nothing
    set callbackTriggers[callbackTriggersCounter] = whichTrigger
    set callbackTriggersCounter = callbackTriggersCounter + 1
endfunction

function TriggerRegisterReturnEvent takes trigger whichTrigger returns nothing
    set callbackReturnTriggers[callbackReturnTriggersCounter] = whichTrigger
    set callbackReturnTriggersCounter = callbackReturnTriggersCounter + 1
endfunction

function TriggerRegisterDeathResourceEvent takes trigger whichTrigger returns nothing
    set callbackDeathTriggers[callbackDeathTriggersCounter] = whichTrigger
    set callbackDeathTriggersCounter = callbackDeathTriggersCounter + 1
endfunction

function GetTriggerMine takes nothing returns unit
    return triggerMine
endfunction

function GetTriggerReturnBuilding takes nothing returns unit
    return triggerReturnBuilding
endfunction

function GetTriggerDyingResourceUnit takes nothing returns unit
    return triggerDyingResourceUnit
endfunction

function GetTriggerWorker takes nothing returns unit
    return triggerWorker
endfunction

function GetTriggerResource takes nothing returns Resource
    return triggerResource
endfunction

function GetTriggerResourceAmount takes nothing returns integer
    return triggerResourceAmount
endfunction

function ExecuteGatherCallbacks takes unit mine, unit worker, Resource resource, integer amount returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackTriggersCounter)
        if (IsTriggerEnabled(callbackTriggers[i])) then
            set triggerMine = mine
            set triggerWorker = worker
            set triggerResource = resource
            set triggerResourceAmount = amount
            call ConditionalTriggerExecute(callbackTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function ExecuteReturnCallbacks takes unit returnBuilding, unit worker, Resource resource, integer amount returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackReturnTriggersCounter)
        if (IsTriggerEnabled(callbackReturnTriggers[i])) then
            set triggerReturnBuilding = returnBuilding
            set triggerWorker = worker
            set triggerResource = resource
            set triggerResourceAmount = amount
            call ConditionalTriggerExecute(callbackReturnTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function ExecuteDeathCallbacks takes unit whichUnit returns nothing
    local integer i = 0
    loop
        exitwhen (i == callbackReturnTriggersCounter)
        if (IsTriggerEnabled(callbackDeathTriggers[i])) then
            set triggerDyingResourceUnit = whichUnit
            call ConditionalTriggerExecute(callbackDeathTriggers[i])
        endif
        set i = i + 1
    endloop
endfunction

function IsSmartOrder takes integer orderId returns boolean
    return orderId == OrderId("smart") or orderId == OrderId("move") or orderId == OrderId("patrol")
endfunction

function IsAlliedMine takes unit mine, player whichPlayer returns boolean
    return GetOwningPlayer(mine) == whichPlayer or IsUnitAlly(mine, whichPlayer) or GetOwningPlayer(mine) == Player(PLAYER_NEUTRAL_PASSIVE)
endfunction

function SetWorkerPathing takes unit worker, boolean enable returns nothing
    call SetUnitPathing(worker, enable)
    if (enable) then
        // avoids being stuck in return buildings
        // this will crash the game
        // it would be better to reset the pathing as soon as the mine collapses and before returning all resources
        //call SetUnitPosition(worker, GetUnitX(worker), GetUnitY(worker))
    endif
endfunction

function IsMineEmpty takes unit mine returns boolean
    local boolean empty = true
    local integer max = GetMaxResources()
    local integer i = 0
    loop
        exitwhen (i == max or not empty)
        if (GetUnitResource(mine, GetResource(i)) > 0) then
            set empty = false
        endif
        set i = i + 1
    endloop
    
    return empty
endfunction

function Gather takes unit worker, unit mine returns integer
    local integer i = 0
    local integer actualAmount = 0
    local integer max = GetMaxResources()
    local Resource resource = 0
    local integer result = 0
    
    // has to be a non-loop animation to stop automatically
    call QueueUnitAnimation(mine, "stand work")
    
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        set actualAmount = IMinBJ(GetUnitResource(mine, resource), GetUnitResourcePerHit(worker, resource))
        //call BJDebugMsg("Actual amount 1: " + I2S(actualAmount))
        if (actualAmount > 0) then
            set actualAmount = IMinBJ(actualAmount, GetUnitResourceMax(worker, resource) - GetUnitResource(worker, resource))
            //call BJDebugMsg("Actual amount 2: " + I2S(actualAmount) + " workerresource amount " + I2S(GetUnitResource(worker, resource)) + " and max resource: " + I2S(GetUnitResourceMax(worker, resource)))
            if (actualAmount > 0) then
                call SetUnitResource(mine, resource, GetUnitResource(mine, resource) - actualAmount)
                call SetUnitResource(worker, resource, GetUnitResource(worker, resource) + actualAmount)
                if (GetUnitResourceAnimationProperties(worker, resource) != null and GetUnitResourceAnimationProperties(worker, resource) != "") then
                    call AddUnitAnimationProperties(worker, GetUnitResourceAnimationProperties(worker, resource), true)
                endif
                if (GetUnitResourceSkin(worker, resource) != 0) then
                    call BlzSetUnitSkin(worker, GetUnitResourceSkin(worker, resource))
                endif
                call ExecuteGatherCallbacks(mine, worker, resource, actualAmount)
                //call BJDebugMsg("Actual amount 3: " + I2S(actualAmount))
                set result = result + actualAmount
            endif
        endif
        set i = i + 1
    endloop
    
    call SetUnitMine(worker, mine)
    
    if (IsMineEmpty(mine)) then
        if (GetMineExplodesOnDeath(mine)) then
            call KillUnit(mine)
        else
            call RemoveMine(mine)
        endif
    endif
    
    return result
endfunction

globals
    private unit filterWorker = null
    private Resource filterResource = 0
endglobals

private function FilterFunctionIsMine takes nothing returns boolean
    return IsMine(GetFilterUnit()) and MovementTypesMatch(filterWorker, GetFilterUnit()) and GetUnitResource(GetFilterUnit(), filterResource) > 0
endfunction

function FindNearestMineOfResource takes unit worker, real radius, Resource resource returns unit
    local real x = GetUnitX(worker)
    local real y = GetUnitY(worker)
    local group mines = CreateGroup()
    local unit currentMine = null
    local real currentDistance = 0.0
    local real distance = 0.0
    local unit mine = null
    local integer i = 0
    local integer max = 0
    set filterWorker = worker
    set filterResource = resource
    call GroupEnumUnitsInRange(mines, x, y, radius, Filter(function FilterFunctionIsMine))
    set i = 0
    set max = BlzGroupGetSize(mines)
    loop
        exitwhen (i == max)
        set currentMine = BlzGroupUnitAt(mines, i)
        if (mine == null) then
            set mine = currentMine
        else
            set currentDistance = DistBetweenCoordinates(x, y, GetUnitX(currentMine), GetUnitY(currentMine))
            if (currentDistance < distance) then
                set mine = currentMine
                set distance = currentDistance
            endif
        endif
        set currentMine = null
        set i = i + 1
    endloop
    call GroupClear(mines)
    call DestroyGroup(mines)
    set mines = null
    return mine
endfunction

function ConstructedReturnBuilding takes unit worker, unit returnBuilding returns unit
    local integer i = 0
    local integer max = GetMaxResources()
    local integer amount = 0
    local Resource result = 0
    local Resource resource = 0
    local boolean returnOrder = false
    local unit mine = null
    loop
        exitwhen (i == max or returnOrder)
        set resource = GetResource(i)
        if (GetUnitReturnResource(returnBuilding, resource)) then
            if (GetUnitResource(worker, resource) > 0) then
                set returnOrder = true
                set result = resource
            elseif (GetUnitResourceMax(worker, resource) > amount) then
                set result = resource
                set amount = GetUnitResourceMax(worker, resource)
            endif
        endif
        set i = i + 1
    endloop
    
    if (result != 0) then
        if (returnOrder) then
            call IssueTargetOrderById(worker, GetUnitReturnHiddenOrderId(worker, result), returnBuilding)
        else
            set mine = FindNearestMineOfResource(worker, 2048.0, result)
            if (mine != null) then
                call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, result), mine)
            endif
        endif
    endif
    return mine
endfunction

function ConstructedMine takes unit worker, unit mine returns Resource
    local integer i = 0
    local integer max = GetMaxResources()
    local Resource result = 0
    local Resource resource = 0
    local boolean returnOrder = false
    loop
        exitwhen (i == max or returnOrder)
        set resource = GetResource(i)
        //call BJDebugMsg("Checking resource " + GetResourceName(resource) + " for worker " + GetUnitName(worker) + " and mine " + GetUnitName(mine))
        if (GetUnitResource(mine, resource) > 0 and GetUnitResourceMax(worker, resource) > 0) then
            set result = resource
            
            if (GetUnitResource(worker, resource) > 0 and GetUnitResource(worker, resource) == GetUnitResourceMax(worker, resource)) then
                set returnOrder = true
            endif
        endif
        set i = i + 1
    endloop
    
    if (result != 0) then
        if (returnOrder) then
            call IssueImmediateOrderById(worker, GetUnitReturnOrderId(worker, result))
            //call BJDebugMsg("Order return")
        else
            call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, result), mine)
            //call BJDebugMsg("Order harvest for resource " + GetResourceName(result))
        endif
    endif
    
    return result
endfunction

function GetPrimaryResourceForWorker takes unit worker returns Resource
    local integer i = 0
    local integer max = GetMaxResources()
    local integer amount = 0
    local Resource result = 0
    local Resource resource = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (GetUnitResource(worker, resource) > amount) then
            set result = resource
            set amount = GetUnitResource(worker, resource)
        endif
        set i = i + 1
    endloop
    
    return result
endfunction

function GetPrimaryMineResourceForWorker takes unit mine, unit worker returns Resource
    local integer i = 0
    local integer max = GetMaxResources()
    local integer workerMax = 0
    local integer mineMax = 0
    local Resource result = 0
    local Resource resource = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (GetUnitResourceMax(worker, resource) > 0 and GetUnitResource(mine, resource) > 0 and IsAlliedMine(mine, GetOwningPlayer(worker))) then
            if (GetUnitResourceMax(worker, resource) > workerMax) then
                set result = resource
                set workerMax = GetUnitResourceMax(worker, resource)
            elseif (GetUnitResourceMax(worker, resource) == workerMax and GetUnitResource(mine, resource) > mineMax) then
                set result = resource
                set mineMax = GetUnitResource(mine, resource)
            endif
        endif
        set i = i + 1
    endloop
    
    return result
endfunction

function GetResourceFromReturnResourcesAbilityId takes unit worker, integer abilityId returns Resource
    local integer i = 0
    local integer v = 0
    local integer max = GetMaxResources()
    local Resource result = 0
    local Resource resource = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (GetUnitReturnAbilityId(worker, resource) == abilityId and GetUnitResource(worker, resource) > v) then
            set result = resource
            set v = GetUnitResource(worker, resource)
        endif
        set i = i + 1
    endloop
    
    return result
endfunction

function IsReturnResourcesHiddenAbilityId takes unit worker, integer abilityId returns boolean
    local integer i = 0
    local integer max = GetMaxResources()
    loop
        exitwhen (i == max)
        if (GetUnitReturnHiddenAbilityId(worker, GetResource(i)) == abilityId) then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

private function TimerFunctionQueue takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit worker = LoadUnitHandle(h, handleId, 0)
    local integer orderId = LoadInteger(h, handleId, 1)
    local integer abilityId = LoadInteger(h, handleId, 2)
    local unit mine = LoadUnitHandle(h, handleId, 3)
    //local real cooldown = BlzGetAbilityRealLevelField(BlzGetUnitAbility(worker, abilityId), ABILITY_RLF_COOLDOWN, 0)
    if (IsUnitAliveBJ(worker) and IsUnitAliveBJ(mine)) then
        //call BJDebugMsg("trigger queued order with ID " + I2S(orderId) + " for worker " + GetUnitName(worker) + " to mine " + GetUnitName(mine))
        call IssueTargetOrderById(worker, orderId, mine)
    endif
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    call SetUnitQueueTimer(worker, null)
    set t = null
endfunction

private function CancelUnitQueueTimer takes unit worker returns nothing
    local timer t = GetUnitQueueTimer(worker)
    if (t != null) then
        call FlushChildHashtable(h, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif
endfunction

private function QueueOrderEx takes unit worker, integer orderId, integer abilityId, unit mine, real duration returns nothing
    local timer t = null
    local integer handleId = 0
    //call BJDebugMsg("Queue order with order ID " + OrderId2String(orderId) + " with mine " + GetUnitName(mine) + " and duration " + R2S(duration))
    call CancelUnitQueueTimer(worker)
    if (duration <= 0.0) then
        //call BJDebugMsg("Issue order id immediately to  mine " + GetUnitName(mine))
        call IssueTargetOrderById(worker, orderId, mine)
    else
        set t = CreateTimer()
        set handleId = GetHandleId(t)
        call SaveUnitHandle(h, handleId, 0, worker)
        call SaveInteger(h, handleId, 1, orderId)
        call SaveInteger(h, handleId, 2, abilityId)
        call SaveUnitHandle(h, handleId, 3, mine)
        call SetUnitQueueTimer(worker, t)
        // add threshold since the timer might not be as precise as the cooldown
        call TimerStart(t, duration, false, function TimerFunctionQueue)
    endif
endfunction

private function QueueOrder takes unit worker, integer orderId, integer abilityId, unit mine returns nothing
   local real cooldown = BlzGetUnitAbilityCooldownRemaining(worker, abilityId)
   
   if (cooldown > 0.0) then
        // add threshold since the timer might not be as precise as the cooldown
        set cooldown = cooldown + 0.6
    endif
    
    call QueueOrderEx(worker, orderId, abilityId, mine, cooldown)
endfunction

function ReturnResources takes unit worker, unit returnBuilding returns integer
    local integer i = 0
    local integer actualAmount = 0
    local integer max = GetMaxResources()
    local Resource resource = 0
    local player owner = GetOwningPlayer(worker)
    local unit mine = null
    local integer result = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        set actualAmount = GetUnitResource(worker, resource)
        if (actualAmount > 0) then
            set actualAmount = actualAmount + GetPlayerResourceBonus(owner, resource)
        endif
        set actualAmount = actualAmount - (actualAmount * GetPlayerResourceUpkeepRate(owner, resource) / 100)
        if (actualAmount > 0) then
            set result = result + GetUnitResource(worker, resource)
            call SetUnitResource(worker, resource, 0)
            if (GetUnitResourceAnimationProperties(worker, resource) != null and GetUnitResourceAnimationProperties(worker, resource) != "") then
                call AddUnitAnimationProperties(worker, GetUnitResourceAnimationProperties(worker, resource), false)
            endif
            //call BJDebugMsg("returned resource " + GetResourceName(resource))
            if (GetUnitResourceSkin(worker, resource) != 0) then
                //call BJDebugMsg("change skin")
                call BlzSetUnitSkin(worker, GetUnitTypeId(worker))
            endif
            call BlzUnitHideAbility(worker, GetUnitReturnAbilityId(worker, resource), true)
            //call BJDebugMsg("hide return ability " + GetObjectName(GetUnitReturnAbilityId(worker, resource)) + " for worker " + GetUnitName(worker))
            call BlzUnitHideAbility(worker, GetUnitHarvestAbilityId(worker, resource), false)
            //call BJDebugMsg("Fading text")
            call CustomBounty(worker, resource, actualAmount) // adds the resource to the player
            call ExecuteReturnCallbacks(returnBuilding, worker, resource, actualAmount)
        endif
        set i = i + 1
    endloop

    // continue harvest
    set mine = GetUnitMine(worker)
    if (mine != null and IsUnitAliveBJ(mine)) then
        // TODO Continue with the previous resource
        set resource = GetPrimaryMineResourceForWorker(mine, worker)
        //call BJDebugMsg("Continue harvest with primary resource" + GetResourceName(resource))
        if (resource != 0) then
            //call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, resource), mine)
            // consider cooldown
            call QueueOrder(worker, GetUnitHarvestOrderId(worker, resource), GetUnitHarvestAbilityId(worker, resource), mine)
        else
            call SetWorkerPathing(worker, true)
        endif
    else
        call SetWorkerPathing(worker, true)
        // will find another mine
        call ConstructedReturnBuilding(worker, returnBuilding)
    endif
    
    set owner = null
    set mine = null
    
    return result
endfunction

private function FilterFunctionReturnBuilding takes nothing returns boolean
    return IsReturnBuilding(GetFilterUnit()) and MovementTypesMatch(filterWorker, GetFilterUnit())
endfunction

function NextReturnBuilding takes unit worker returns unit
    local group returnBuildings = CreateGroup()
    local Resource resource = 0
    local unit groupMember = null
    local real groupMemberDistance = 0.0
    local real distance = 0.0
    local unit result = null
    local integer i = 0
    local integer max = 0
    local integer j = 0
    local integer max2 = 0
    local boolean valid = false
    set filterWorker = worker
    call GroupEnumUnitsOfPlayer(returnBuildings, GetOwningPlayer(worker), Filter(function FilterFunctionReturnBuilding))
    set max = BlzGroupGetSize(returnBuildings)
    loop
        exitwhen (i == max)
        set groupMember = BlzGroupUnitAt(returnBuildings, i)
        //call BJDebugMsg("Checking return building "  + GetUnitName(groupMember))
        
        set valid = false
        set j = 0
        set max2 = GetMaxResources()
        loop
            exitwhen (j == max2)
            set resource = GetResource(j)
            //call BJDebugMsg("Resource "  + GetResourceName(resource) + " carrying " + I2S(GetUnitResource(worker, resource)))
            if (GetUnitReturnResource(groupMember, resource) and GetUnitResource(worker, resource) > 0) then
                //call BJDebugMsg("Enable for resource "  + GetResourceName(resource))
                set valid = true
            endif
            set j = j + 1
        endloop
        
        if (valid) then
            set groupMemberDistance = DistanceBetweenUnits(worker, groupMember)
            if (result == null or groupMemberDistance < distance) then
                set result = groupMember
                set distance = groupMemberDistance
            endif
        else
            //call BJDebugMsg("Disabled")
        endif
        set groupMember = null
        set i = i + 1
    endloop
    
    call GroupClear(returnBuildings)
    call DestroyGroup(returnBuildings)
    set returnBuildings = null
    
    return result
endfunction

private function HasMaxOfMineResources takes unit worker, unit mine returns boolean
    local integer i = 0
    local integer actualAmount = 0
    local integer max = GetMaxResources()
    local Resource resource = 0
    loop
        exitwhen (i == max)
        set resource = GetResource(i)
        if (GetUnitResource(mine, resource) > 0 and GetUnitResource(worker, resource) < GetUnitResourceMax(worker, resource)) then
            return false
        endif
        set i = i + 1
    endloop
    return true
endfunction

function ReleaseWorkerFromMine takes unit worker, unit mine returns nothing
    call ShowUnit(worker, true)
    call SetUnitInvulnerable(worker, false)
    call GroupRemoveUnit(GetMineWorkers(mine), worker)
    if (BlzGroupGetSize(GetMineWorkers(mine)) == 0) then
        call ResetUnitAnimation(mine)
    endif
endfunction

function AddWorkerToMine takes unit worker, unit mine returns nothing
    call SelectUnitRemove(worker)
    call ShowUnit(worker, false)
    call SetUnitInvulnerable(worker, true)
    call GroupAddUnit(GetMineWorkers(mine), worker)
    call QueueUnitAnimation(mine, "stand work")
endfunction

function ReleaseAllWorkersFromMine takes unit mine returns nothing
    local unit first = null
    loop
        set first = FirstOfGroup(GetMineWorkers(mine))
        exitwhen (first == null)
        call ReleaseWorkerFromMine(first, mine)
    endloop
endfunction

private function TimerFunctionReleaseWorkerFromMine takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer handleId = GetHandleId(t)
    local unit worker = LoadUnitHandle(h, handleId, 0)
    local unit mine = LoadUnitHandle(h, handleId, 1)
    local Resource resource = LoadInteger(h, handleId, 2)
    local integer amount = Gather(worker, mine)
    
    // did not explode
    if (IsUnitAliveBJ(mine)) then
        call ReleaseWorkerFromMine(worker, mine)
        //all BJDebugMsg("Release worker with resource " + GetResourceName(resource))
    endif
    
    //call BJDebugMsg("Show and order return ability " + GetObjectName(GetUnitReturnAbilityId(worker, resource)))
    call BlzUnitHideAbility(worker, GetUnitHarvestAbilityId(worker, resource), true)
    call BlzUnitHideAbility(worker, GetUnitReturnAbilityId(worker, resource), false)
    call IssueImmediateOrderById(worker, GetUnitReturnOrderId(worker, resource))
    
    call FlushChildHashtable(h, handleId)
    call PauseTimer(t)
    call DestroyTimer(t)
    call SetUnitQueueWorkerReleaseTimer(worker, null)
    set t = null
endfunction

private function CancelUnitQueueWorkerReleaseTimer takes unit worker returns nothing
    local timer t = GetUnitQueueWorkerReleaseTimer(worker)
    if (t != null) then
        call FlushChildHashtable(h, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif
endfunction

private function QueueWorkerRelease takes unit worker, unit mine, Resource resource returns nothing
    local real duration = GetUnitHarvestDuration(worker, resource)
    local timer t = null
    local integer handleId = 0
    //call BJDebugMsg("Queue order with cooldown " + R2S(duration) + " and worker handle ID " + I2S(GetHandleId(worker)) + " for resource " + GetResourceName(resource))
    call CancelUnitQueueWorkerReleaseTimer(worker)
    if (duration <= 0.0) then
        call Gather(worker, mine)
        call ReleaseWorkerFromMine(worker, mine)
        call BlzUnitHideAbility(worker, GetUnitHarvestAbilityId(worker, resource), true)
        call BlzUnitHideAbility(worker, GetUnitReturnAbilityId(worker, resource), false)
        call IssueImmediateOrderById(worker, GetUnitReturnOrderId(worker, resource))
        //call BJDebugMsg("Immediate release")
    else
        set t = CreateTimer()
        set handleId = GetHandleId(t)
        call SaveUnitHandle(h, handleId, 0, worker)
        call SaveUnitHandle(h, handleId, 1, mine)
        call SaveInteger(h, handleId, 2, resource)
        call SetUnitQueueWorkerReleaseTimer(worker, t)
        call TimerStart(t, duration, false, function TimerFunctionReleaseWorkerFromMine)
    endif
endfunction

function GatherInsideMine takes unit worker, unit mine, Resource resource returns nothing
    call AddWorkerToMine(worker, mine)
    call QueueWorkerRelease(worker, mine, resource)
endfunction

private function TriggerActionCast takes nothing returns nothing
    local integer abilityId = GetSpellAbilityId()
    local unit worker = GetTriggerUnit()
    local unit mine = GetSpellTargetUnit()
    local integer i = 0
    local integer max = GetMaxResources()
    local integer matchingResources = 0
    local integer nonEmptyResources = 0
    local integer amount = 0
    local Resource foundResource = 0
    local Resource resource = 0
    local boolean queued = false
    local boolean gatherInside = GetMineTakeWorkerInside(mine)
    if (IsAlliedMine(mine, GetOwningPlayer(worker))) then
        loop
            exitwhen (i == max)
            set resource = GetResource(i)
            if (GetUnitHarvestAbilityId(worker, resource) == abilityId) then
                //call BJDebugMsg("Harvest ability for resource: " + GetResourceName(resource) + " with mine " + GetUnitName(mine))
                set matchingResources = matchingResources + 1
                if (GetUnitResource(mine, resource) > 0) then
                    set nonEmptyResources = nonEmptyResources + 1
                    set foundResource = resource
                    if (not gatherInside) then
                        set amount = amount + Gather(worker, mine)
                    endif
                    //call BJDebugMsg("Gathered: " + I2S(amount))
                endif
            endif
            set i = i + 1
        endloop
    endif

    if (gatherInside and foundResource != 0) then
        //call BJDebugMsg("Worker with handle ID wants to harvest inside mine " + I2S(GetHandleId(worker)))
        if (GetMineMaxWorkers(mine) == 0 or BlzGroupGetSize(GetMineWorkers(mine)) < GetMineMaxWorkers(mine)) then
            call GatherInsideMine(worker, mine, foundResource)
        else
            // queue harvest until the mine has a free slot
            set queued = true
            call QueueOrderEx(worker, GetUnitHarvestOrderId(worker, foundResource), abilityId, mine, 0.5)
            //call BJDebugMsg("Queue for free slot for resource " + GetResourceName(foundResource) + " and worker with handle ID " + I2S(GetHandleId(worker)) + " and order " + OrderId2String(GetUnitHarvestOrderId(worker, foundResource)))
        endif
    elseif (matchingResources > 0 and nonEmptyResources == 0) then
        call IssueImmediateOrder(worker, "stop")
        //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
        //call BJDebugMsg("Stop worker " + GetUnitName(worker))
    elseif (not gatherInside and foundResource != 0 and amount == 0 or HasMaxOfMineResources(worker, mine)) then // return resources if necessary
        call IssueImmediateOrder(worker, "stop")
        //call BJDebugMsg("has max looking for return building")
        if (GetWorkerTotalResources(worker) > 0) then
            call BlzUnitHideAbility(worker, GetUnitHarvestAbilityId(worker, foundResource), true)
            call BlzUnitHideAbility(worker, GetUnitReturnAbilityId(worker, foundResource), false)
            //call BJDebugMsg("Show return ability " + GetObjectName(GetUnitReturnAbilityId(worker, foundResource)) + " with level on unit " + I2S(GetUnitAbilityLevel(worker, GetUnitReturnAbilityId(worker, foundResource))))
            call IssueImmediateOrderById(worker, GetUnitReturnOrderId(worker, foundResource))
        else
            //call BJDebugMsg("Has no resources")
        endif
    elseif (amount > 0 and foundResource != 0) then // continue harvesting
        //call BJDebugMsg("Continue harvesting and hide return ability")
        //call BJDebugMsg("Queue worker for resource " + GetResourceName(foundResource) + " with harvest order ID " + I2S(OrderId("harvest")) + " and order id " + I2S(GetUnitHarvestOrderId(worker, foundResource)))
        //call BJDebugMsg("harvest ability level " + I2S(GetUnitAbilityLevel(worker, abilityId)))
        //call BJDebugMsg("harvest cooldown " + R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(worker, abilityId), ABILITY_RLF_COOLDOWN, 0)))
        //call BlzUnitClearOrders(worker, true)
        //call BlzQueueTargetOrderById(worker, GetUnitHarvestOrderId(worker, foundResource), mine)
        call BlzUnitHideAbility(worker, GetUnitReturnAbilityId(worker, foundResource), false)
            
        call QueueOrderEx(worker, GetUnitHarvestOrderId(worker, foundResource), abilityId, mine, 0.5) // add some threshold to continue
        set queued = true
        //call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, foundResource), mine)
    elseif (matchingResources > 0) then
        call IssueImmediateOrder(worker, "stop")
        call SimError(GetOwningPlayer(worker), GetLocalizedString("TARGET_IS_NO_VALID_MINE"))
    endif
    
    // cancel queue if any other ability has been cast
    if (not queued) then
        call CancelUnitQueueTimer(worker)
    endif
    
    set mine = null
    set worker = null
endfunction

function ReorderWorkerToMineRally takes unit producer, unit worker returns nothing
    local unit mine = GetUnitRallyUnit(producer)
    local Resource resource = 0
    if (mine != null and IsWorker(worker) and IsMine(mine)) then
        set resource = GetPrimaryMineResourceForWorker(mine, worker)
        if (resource != 0) then
            //call BJDebugMsg("Rally order to mine " + GetUnitName(mine))
            call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, resource), mine)
        endif
    endif
    set mine = null
endfunction

function GetReturnResource takes unit worker, unit returnBuilding returns Resource
    local Resource r = 0
    local integer i = 0
    local integer max = GetMaxResources()
    local integer returnResourceAmount = 0
    local Resource returnResource = 0
    loop
        exitwhen (i == max)
        set r = GetResource(i)
        if (GetUnitResource(worker, r) > 0 and GetUnitReturnResource(returnBuilding, r) and GetUnitResource(worker, r) > returnResourceAmount) then
            set returnResourceAmount = GetUnitResource(worker, r)
            set returnResource = r
        endif
        set i = i + 1
    endloop
    return returnResource
endfunction

private function TriggerActionOrder takes nothing returns nothing
    local unit mine = GetOrderTargetUnit()
    local unit worker = GetTriggerUnit()
    local integer orderId = GetIssuedOrderId()
    local Resource r = 0
    local integer i = 0
    local integer max = 0
    local unit returnBuilding = null
    local boolean foundResourceInMine = false
    local boolean isBusyHarvestingOrReturning = false
    local boolean movement = MovementTypesMatch(worker, mine)
    if (IsMine(mine) and IsWorker(worker) and movement) then
        if (IsSmartOrder(orderId)) then
            set r = GetPrimaryMineResourceForWorker(mine, worker)
            //call BJDebugMsg("Got primary resource from mine " + I2S(r) + " and order ID " + OrderId2String(GetUnitHarvestOrderId(worker, r)))
            if (r != 0) then
                if (GetUnitResource(mine, r) == 0) then
                    call IssueImmediateOrder(worker, "stop")
                    //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
                else
                    if (HasMaxOfMineResources(worker, mine)) then
                        // return resource
                        // In Warcraft III workers would actually go to the mine and then return the resources.
                        call SetUnitMine(worker, mine)
                        set returnBuilding = NextReturnBuilding(worker)
                        if (returnBuilding != null) then
                            call IssueTargetOrderById(worker, GetUnitReturnHiddenOrderId(worker, r), returnBuilding)
                            set returnBuilding = null
                        endif
                    else
                        // harvest
                        //call BJDebugMsg("Harvest order " + I2S(GetUnitHarvestOrderId(worker, r)))
                        call IssueTargetOrderById(worker, GetUnitHarvestOrderId(worker, r), mine)
                    endif
                endif
            else
                if (not GetUnitDisableStopMiningOnError(mine)) then
                    call IssueImmediateOrder(worker, "stop")
                    call SimError(GetOwningPlayer(worker), Format(GetLocalizedString("CANNOT_HARVEST")).s(GetUnitName(worker)).s(GetUnitName(mine)).result())
                endif
            endif
        else
            // check if mine is empty on harvesting order
            set i = 0
            set max = GetMaxResources()
            loop
                exitwhen (i == max or foundResourceInMine)
                set r = GetResource(i)
                if (GetUnitHarvestOrderId(worker, r) == orderId) then
                    if (GetUnitResource(mine, r) > 0) then
                        set foundResourceInMine = true
                    endif
                endif
                set i = i + 1
            endloop
            if (not foundResourceInMine) then
                call IssueImmediateOrder(worker, "stop")
                //call BJDebugMsg("Could not find resource in mine for worker " + I2S(GetHandleId(worker)))
                //call SimError(GetOwningPlayer(worker), "Empty " + GetUnitName(mine) + ".")
            endif
        endif
    endif
    
    // return resources
    if (IsReturnBuilding(mine) and IsWorker(worker) and IsSmartOrder(orderId) and movement) then
        set r = GetReturnResource(worker, mine)
        //call BJDebugMsg("Return resource " + I2S(r))
        if (r != 0) then
            call IssueTargetOrderById(worker, GetUnitReturnHiddenOrderId(worker, r), mine)
            set isBusyHarvestingOrReturning = true
        endif
    endif

    if (IsWorker(worker) and movement) then
        // disable pathing of busy workers to avoid blocking
        set i = 0
        set max = GetMaxResources()
        loop
            exitwhen (i == max or isBusyHarvestingOrReturning)
            set r = GetResource(i)
            if (GetUnitHarvestOrderId(worker, r) == orderId or GetUnitReturnHiddenOrderId(worker, r) == orderId) then
                set isBusyHarvestingOrReturning = true
            endif
            set i = i + 1
        endloop
        call SetWorkerPathing(worker, not isBusyHarvestingOrReturning)

        // cancel queued order for any other order
        call CancelUnitQueueTimer(worker)
    endif
    set mine = null
    set worker = null
endfunction

private function TriggerActionOrderReset takes nothing returns nothing
    local unit worker = GetTriggerUnit()
    if (IsWorker(worker)) then
        call CancelUnitQueueTimer(worker)
        call SetWorkerPathing(worker, true)
    endif
    set worker = null
endfunction

private function TriggerActionReturn takes nothing returns nothing
    local unit returnBuilding = GetSpellTargetUnit()
    local unit worker = GetTriggerUnit()
    local integer abilityId = GetSpellAbilityId()
    local Resource foundResource = 0
    local boolean movement = MovementTypesMatch(worker, returnBuilding)
    if (IsWorker(worker) and movement) then
        //call BJDebugMsg("Return resources with return building " + GetUnitName(returnBuilding))
        if (returnBuilding != null and IsReturnBuilding(returnBuilding) and IsReturnResourcesHiddenAbilityId(worker, abilityId)) then
            //call BJDebugMsg("Returning resources NOW!")
            call ReturnResources(worker, returnBuilding)
        else
            set foundResource = GetResourceFromReturnResourcesAbilityId(worker, abilityId)
            //call BJDebugMsg("Return resource " + I2S(foundResource) + " from ability " + GetObjectName(abilityId))
            if (foundResource != 0) then
                set returnBuilding = NextReturnBuilding(worker)
                if (returnBuilding != null) then
                    call IssueTargetOrderById(worker, GetUnitReturnHiddenOrderId(worker, foundResource), returnBuilding)
                    set returnBuilding = null
                else
                    // nothing happens in Warcraft III if no return building is found
                    //call SimError(GetOwningPlayer(worker), "No return building found.")
                endif
            endif
        endif
    endif
    set returnBuilding = null
    set worker = null
endfunction

private function TriggerActionDeath takes nothing returns nothing
    local unit dyingUnit = GetDyingUnit()
    if (IsMine(dyingUnit) or IsWorker(dyingUnit) or IsReturnBuilding(dyingUnit)) then
        // this could actually remove it from any of these so we have to check again afterwards
        call ExecuteDeathCallbacks(dyingUnit)
        call ReleaseAllWorkersFromMine(dyingUnit)
    endif
    if (IsMine(dyingUnit)) then
        call RemoveMine(dyingUnit)
    endif
    if (IsWorker(dyingUnit)) then
        call RemoveWorker(dyingUnit)
    endif
    if (IsReturnBuilding(dyingUnit)) then
        call RemoveReturnBuilding(dyingUnit)
    endif
    set dyingUnit = null
endfunction

private function Init takes nothing returns nothing
    // use trigger actions to avoid issues with unfinished Channel abilities
    call TriggerRegisterAnyUnitEventBJ(castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction(castTrigger, function TriggerActionCast)
    
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(orderTrigger, function TriggerActionOrder)
    
    call TriggerRegisterAnyUnitEventBJ(orderResetTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderResetTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddAction(orderResetTrigger, function TriggerActionOrderReset)
    
    call TriggerRegisterAnyUnitEventBJ(returnTrigger, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    call TriggerAddAction(returnTrigger, function TriggerActionReturn)

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(deathTrigger, function TriggerActionDeath)
    
    set GOLD = AddResource(GetLocalizedString("GOLD"))
    call SetResourceIcon(GOLD, GOLD_ICON)
    call SetResourceIconAtt(GOLD, GOLD_ICON_ATT)
    call SetResourceDescription(GOLD, GetLocalizedString("RESOURCE_UBERTIP_GOLD"))
    call SetResourceGoldExchangeRate(GOLD, GOLD_GOLD_EXCHANGE_RATE)
    call SetResourceColorRed(GOLD, 255)
    call SetResourceColorGreen(GOLD, 255)
    set LUMBER = AddResource(GetLocalizedString("LUMBER"))
    call SetResourceIcon(LUMBER, LUMBER_ICON)
    call SetResourceIconAtt(LUMBER, LUMBER_ICON_ATT)
    call SetResourceDescription(LUMBER, GetLocalizedString("RESOURCE_UBERTIP_LUMBER"))
    call SetResourceGoldExchangeRate(LUMBER, LUMBER_GOLD_EXCHANGE_RATE)
    call SetResourceColorGreen(LUMBER, 255)
    set FOOD = AddResource(GetLocalizedString("FOOD"))
    call SetResourceIcon(FOOD, FOOD_ICON)
    call SetResourceIconAtt(FOOD, FOOD_ICON_ATT)
    call SetResourceDescription(FOOD, GetLocalizedString("RESOURCE_UBERTIP_SUPPLY"))
    call SetResourceGoldExchangeRate(FOOD, FOOD_GOLD_EXCHANGE_RATE)
    set FOOD_MAX = AddResource(GetLocalizedString("FOOD_MAXIMUM"))
    call SetResourceIcon(FOOD_MAX, FOOD_MAX_ICON)
    call SetResourceIconAtt(FOOD_MAX, FOOD_MAX_ICON_ATT)
    call SetResourceDescription(FOOD_MAX, GetLocalizedString("RESOURCE_UBERTIP_SUPPLY"))
    call SetResourceGoldExchangeRate(FOOD_MAX, FOOD_MAX_GOLD_EXCHANGE_RATE)
endfunction

function IsStandardResource takes Resource r returns boolean
    return r == GOLD or r == LUMBER or r == FOOD or r == FOOD_MAX
endfunction

private function RemoveUnitHook takes unit whichUnit returns nothing
    call CancelUnitQueueTimer(whichUnit)
    call CancelUnitQueueWorkerReleaseTimer(whichUnit)
    call RemoveMine(whichUnit)
    call RemoveWorker(whichUnit)
    call RemoveReturnBuilding(whichUnit)
    call FlushChildHashtable(h, GetHandleId(whichUnit))
endfunction

hook RemoveUnit RemoveUnitHook

endlibrary
