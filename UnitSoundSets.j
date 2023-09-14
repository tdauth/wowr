library UnitSoundSets initializer Init

/**
 * Baradé's Unit Sound Sets 1.0
 *
 * Allows using custom unit sound sets without replacing existing ones or using a custom SLK file.
 *
 * Usage:
 * - Disable the sound set of your unit type and then register the sounds using this system.
 * - Download a custom soundset from Hive: https://www.hiveworkshop.com/threads/genn-greymane.336359/ and import the files into your map.
 * - Call this during the map initialization:
 *   call AddUnitSoundSetFromFiles('H0F2', "war3Imported\\HeroPaladin", "flac")
 *
 *   H0F2 should be the raw code of your custom hero unit type.
 *
 *
 * Information about sound sets: https://world-editor-tutorials.thehelper.net/cat_usersubmit.php?view=39614
 */

globals
    // You will hear the pissed sounds after this number of clicks on the same unit.
    constant integer PISSED_COUNTER = 5
    constant boolean FORCE_PORTRAIT_ANIMATIONS = true

    // Death : Whenver the unit dies, the Death Sound will be played.
    constant integer SOUND_DEATH = 0
    // What : Occurs when you click on the unit only. Replaced by Pissed Sounds if you click multiple times on the unit in a short time.
    constant integer SOUND_WHAT_1 = 1
    constant integer SOUND_WHAT_2 = 2
    constant integer SOUND_WHAT_3 = 3
    constant integer SOUND_WHAT_4 = 4
    // Yes : Occurs when you order the unit to do a "Friendly" Action.
    constant integer SOUND_YES_1 = 5
    constant integer SOUND_YES_2 = 6
    constant integer SOUND_YES_3 = 7
    constant integer SOUND_YES_4 = 8
    // YesAttack : Occurs when you order the unit to "Attack-Move", or an order similar to it.
    constant integer SOUND_YES_ATTACK_1 = 9
    constant integer SOUND_YES_ATTACK_2 = 10
    constant integer SOUND_YES_ATTACK_3 = 11
    constant integer SOUND_YES_ATTACK_4 = 12
    // Ready : Occurs only one time for a single unit, it is played when the unit is spawned by a building (Example : Barracks for Rifleman), or when they got revived by an Altar (Example : Paladin).
    constant integer SOUND_READY_1 = 13
    // Warcry : Occurs when you order the unit to attack a specific unit.
    constant integer SOUND_WARCRY_1 = 14
    // Pissed : When you click a lot of times on the unit, weird sounds will be played instead of normals, which are called Pissed Sounds.
    constant integer SOUND_PISSED_1 = 15
    constant integer SOUND_PISSED_2 = 16
    constant integer SOUND_PISSED_3 = 17
    constant integer SOUND_PISSED_4 = 18
    constant integer SOUND_PISSED_5 = 19
    constant integer SOUND_PISSED_6 = 20
    constant integer SOUND_PISSED_7 = 21
    constant integer SOUND_PISSED_8 = 22
    // Attack : Occurs when the unit starts attacking an enemy. (You don't have to click on the unit)

    private hashtable h = InitHashtable()
    private integer array playerClickCounter
    private unit array playerClickTarget

    private trigger selectionTrigger = CreateTrigger()
    private trigger deselectionTrigger = CreateTrigger()
    private trigger orderTrigger = CreateTrigger()
    private trigger revivalTrigger = CreateTrigger()
    private trigger trainTrigger = CreateTrigger()
    private trigger deathTrigger = CreateTrigger()
endglobals

function RemoveUnitSoundSet takes integer unitTypeId returns nothing
    call FlushChildHashtable(h, unitTypeId)
endfunction

function AddUnitSoundSet takes integer unitTypeId, integer t, sound whichSound returns nothing
    call SaveSoundHandle(h, unitTypeId, t, whichSound)
endfunction

function AddUnitSoundSetDeath takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_DEATH, whichSound)
endfunction

function AddUnitSoundSetWhat1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_WHAT_1, whichSound)
endfunction

function AddUnitSoundSetWhat2 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_WHAT_2, whichSound)
endfunction

function AddUnitSoundSetWhat3 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_WHAT_3, whichSound)
endfunction

function AddUnitSoundSetWhat4 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_WHAT_4, whichSound)
endfunction

function AddUnitSoundSetYes1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_1, whichSound)
endfunction

function AddUnitSoundSetYes2 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_2, whichSound)
endfunction

function AddUnitSoundSetYes3 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_3, whichSound)
endfunction

function AddUnitSoundSetYes4 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_4, whichSound)
endfunction

function AddUnitSoundSetYesAttack1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_ATTACK_1, whichSound)
endfunction

function AddUnitSoundSetYesAttack2 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_ATTACK_2, whichSound)
endfunction

function AddUnitSoundSetYesAttack3 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_ATTACK_3, whichSound)
endfunction

function AddUnitSoundSetYesAttack4 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_YES_ATTACK_4, whichSound)
endfunction

function AddUnitSoundSetReady1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_READY_1, whichSound)
endfunction

function AddUnitSoundSetWarCry1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_WARCRY_1, whichSound)
endfunction

function AddUnitSoundSetPissed1 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_1, whichSound)
endfunction

function AddUnitSoundSetPissed2 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_2, whichSound)
endfunction

function AddUnitSoundSetPissed3 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_3, whichSound)
endfunction

function AddUnitSoundSetPissed4 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_4, whichSound)
endfunction

function AddUnitSoundSetPissed5 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_5, whichSound)
endfunction

function AddUnitSoundSetPissed6 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_6, whichSound)
endfunction

function AddUnitSoundSetPissed7 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_7, whichSound)
endfunction

function AddUnitSoundSetPissed8 takes integer unitTypeId, sound whichSound returns nothing
    call AddUnitSoundSet(unitTypeId, SOUND_PISSED_8, whichSound)
endfunction

private function CreateSoundFromFile takes string filePath returns sound
    local sound soundHandle = CreateSound(filePath, false, false, true, 12700, 12700, "")
    call SetSoundChannel(soundHandle, 1) // SOUND_VOLUMEGROUP_UNITSOUNDS
    returns soundHandle
endfunction

function AddUnitSoundSetFromFiles takes integer unitTypeId, string filePath, string extension returns nothing
    call AddUnitSoundSetDeath(unitTypeId, CreateSoundFromFile(filePath + "Death." + extension))
    call AddUnitSoundSetWhat1(unitTypeId, CreateSoundFromFile(filePath + "What1." + extension))
    call AddUnitSoundSetWhat2(unitTypeId, CreateSoundFromFile(filePath + "What2." + extension))
    call AddUnitSoundSetWhat3(unitTypeId, CreateSoundFromFile(filePath + "What3." + extension))
    call AddUnitSoundSetWhat4(unitTypeId, CreateSoundFromFile(filePath + "What4." + extension))
    call AddUnitSoundSetYes1(unitTypeId, CreateSoundFromFile(filePath + "Yes1." + extension))
    call AddUnitSoundSetYes2(unitTypeId, CreateSoundFromFile(filePath + "Yes2." + extension))
    call AddUnitSoundSetYes3(unitTypeId, CreateSoundFromFile(filePath + "Yes3." + extension))
    call AddUnitSoundSetYes4(unitTypeId, CreateSoundFromFile(filePath + "Yes4." + extension))
    call AddUnitSoundSetYesAttack1(unitTypeId, CreateSoundFromFile(filePath + "YesAttack1." + extension))
    call AddUnitSoundSetYesAttack2(unitTypeId, CreateSoundFromFile(filePath + "YesAttack2." + extension))
    call AddUnitSoundSetYesAttack3(unitTypeId, CreateSoundFromFile(filePath + "YesAttack3." + extension))
    call AddUnitSoundSetYesAttack4(unitTypeId, CreateSoundFromFile(filePath + "YesAttack4." + extension))
    call AddUnitSoundSetReady1(unitTypeId, CreateSoundFromFile(filePath + "Ready1." + extension))
    call AddUnitSoundSetWarCry1(unitTypeId, CreateSoundFromFile(filePath + "WarCry1." + extension))
    call AddUnitSoundSetPissed1(unitTypeId, CreateSoundFromFile(filePath + "Pissed1." + extension))
    call AddUnitSoundSetPissed2(unitTypeId, CreateSoundFromFile(filePath + "Pissed2." + extension))
    call AddUnitSoundSetPissed3(unitTypeId, CreateSoundFromFile(filePath + "Pissed3." + extension))
    call AddUnitSoundSetPissed4(unitTypeId, CreateSoundFromFile(filePath + "Pissed4." + extension))
    call AddUnitSoundSetPissed5(unitTypeId, CreateSoundFromFile(filePath + "Pissed5." + extension))
    call AddUnitSoundSetPissed6(unitTypeId, CreateSoundFromFile(filePath + "Pissed6." + extension))
    call AddUnitSoundSetPissed7(unitTypeId, CreateSoundFromFile(filePath + "Pissed7." + extension))
    call AddUnitSoundSetPissed8(unitTypeId, CreateSoundFromFile(filePath + "Pissed8." + extension))
endfunction

private function HasControl takes player whichPlayer, unit whichUnit returns boolean
    return GetOwningPlayer(whichUnit) == whichPlayer or GetPlayerAlliance(whichPlayer, GetOwningPlayer(whichUnit), ALLIANCE_SHARED_CONTROL)
endfunction

private function AlliesWithSharedControl takes player whichPlayer returns force
    local force whichForce = CreateForce()
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        if (whichPlayer == Player(i) or GetPlayerAlliance(whichPlayer, Player(i), ALLIANCE_SHARED_CONTROL)) then
            call ForceAddPlayer(whichForce, Player(i))
        endif
        set i = i + 1
    endloop
    return whichForce
endfunction

private function GetRandomSound takes integer unitTypeId, integer t0, integer t1 returns sound
    return LoadSoundHandle(h, unitTypeId, GetRandomInt(t0, t1))
endfunction

private function PlayRandomSound takes player whichPlayer, unit whichUnit, integer t0, integer t1 returns nothing
    local sound whichSound = GetRandomSound(unitTypeId, t0, t1)
    local integer unitTypeId = GetUnitTypeId(whichUnit)
    if (whichSound != null and GetLocalPlayer() == whichPlayer) then
        if (IsUnitSelected(whichUnit, whichPlayer)) then
static if (FORCE_PORTRAIT_ANIMATIONS) then
            call SetCinematicSceneBJ(whichSound, unitTypeId, GetPlayerColor(whichPlayer), "", "", 0.0, GetSoundDurationBJ(whichSound))
else
            call StartSound(whichSound)
endif
        else
            call StartSound(whichSound)
        endif
    endif
endfunction

private function PlayRandom3DSound takes unit whichUnit, integer t0, integer t1 returns nothing
    local sound soundHandle = GetRandomSound(unitTypeId, t0, t1)
    if (soundHandle != null) then
        call StartSound(soundHandle)
        call AttachSoundToUnit(soundHandle, whichUnit)
    endif
endfunction

private function UpdatePlayerSelect takes player whichPlayer, unit whichUnit returns boolean
    if (playerClickTarget[playerId] == whichUnit) then
        set playerClickCounter[playerId] = playerClickCounter[playerId] + 1
    else
        set playerClickCounter[playerId] = 0
    endif

    return playerClickCounter > PISSED_COUNTER
endfunction

private function TriggerConditionSelect takes nothing returns nothing
    local boolean pissed = UpdatePlayerSelect(GetTriggerPlayer(), GetTriggerUnit())
    if (HasControl(GetTriggerPlayer(), GetTriggerUnit())) then
        if (pissed) then
            call PlayRandomSound(GetTriggerPlayer(), GetTriggerUnit(), SOUND_PISSED_1, SOUND_PISSED_8)
        else
            call PlayRandomSound(GetTriggerPlayer(), GetTriggerUnit(), SOUND_WHAT_1, SOUND_WHAT_4)
        endif
    endif
    return false
endfunction

private function TriggerConditionDeselect takes nothing returns nothing
static if (FORCE_PORTRAIT_ANIMATIONS) then
    if (GetLocalPlayer() == GetTriggerPlayer()) then
        call EndCinematicScene()
    endif
endif
    return false
endfunction

private function TriggerConditionOrder takes nothing returns nothing
    if (HasControl(GetTriggerPlayer(), GetTriggerUnit())) then
        if (GetIssuedOrderId() == OrderId("attack")) then
            if (GetOrderTargetUnit() != null) then
                call PlayRandomSound(GetTriggerPlayer(), GetTriggerUnit(), SOUND_WARCRY_1, SOUND_WARCRY_1)
            else
                call PlayRandomSound(GetTriggerPlayer(), GetTriggerUnit(), SOUND_YES_ATTACK_1, SOUND_YES_ATTACK_4)
            endif
        elseif (GetIssuedOrderId() == OrderId("move") or GetIssuedOrderId() == OrderId("patrol") or GetIssuedOrderId() == OrderId("smart")) then
            call PlayRandomSound(GetTriggerPlayer(), GetTriggerUnit(), SOUND_YES_1, SOUND_YES_4)
        endif
    endif
    return false
endfunction

private function TriggerConditionReviveFinish takes nothing returns nothing
    local force allies = AlliesWithSharedControl(GetOwningPlayer(GetRevivingUnit()))
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call PlayRandomSound(GetLocalPlayer(), GetRevivingUnit(), SOUND_READY_1, SOUND_READY_1)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
    return false
endfunction

private function TriggerConditionTrainFinish takes nothing returns nothing
    local force allies = AlliesWithSharedControl(GetOwningPlayer(GetTrainedUnit()))
    if (IsPlayerInForce(GetLocalPlayer(), allies)) then
        call PlayRandomSound(GetLocalPlayer(), GetRevivingUnit(), SOUND_READY_1, SOUND_READY_1)
    endif
    call ForceClear(allies)
    call DestroyForce(allies)
    set allies = null
    return false
endfunction

private function TriggerConditionDeath takes nothing returns nothing
    call PlayRandom3DSound(GetDyingUnit(), SOUND_DEATH_1, SOUND_DEATH_1)
    return false
endfunction

private function Init takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen (i == bj_MAX_PLAYERS)
        call TriggerRegisterPlayerUnitEvent(selectionTrigger, whichPlayer, EVENT_PLAYER_UNIT_SELECTED, null)
        call TriggerRegisterPlayerUnitEvent(deselectionTrigger, whichPlayer, EVENT_PLAYER_UNIT_DESELECTED, null)
        set i = i + 1
    endloop
    call TriggerAddCondition(selectionTrigger, Condition(function TriggerConditionSelect))
    call TriggerAddCondition(deselectionTrigger, Condition(function TriggerConditionDeselect))

    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    call TriggerRegisterAnyUnitEventBJ(orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddCondition(orderTrigger, Condition(function TriggerConditionOrder))

    call TriggerRegisterAnyUnitEventBJ(revivalTrigger, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddCondition(revivalTrigger, Condition(function TriggerConditionReviveFinish))

    call TriggerRegisterAnyUnitEventBJ(trainTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(trainTrigger, Condition(function TriggerConditionTrainFinish))

    call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(deathTrigger, Condition(function TriggerConditionDeath))
endfunction

endlibrary