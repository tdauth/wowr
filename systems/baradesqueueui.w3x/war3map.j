globals
//globals from FrameLoader:
constant boolean LIBRARY_FrameLoader=true
trigger FrameLoader__eventTrigger= CreateTrigger()
trigger FrameLoader__actionTrigger= CreateTrigger()
timer FrameLoader__t= CreateTimer()
//endglobals from FrameLoader
//globals from HeroReviveCancelEvent:
constant boolean LIBRARY_HeroReviveCancelEvent=true
//endglobals from HeroReviveCancelEvent
//globals from OnStartGame:
constant boolean LIBRARY_OnStartGame=true
trigger OnStartGame__startGameTrigger= CreateTrigger()
//endglobals from OnStartGame
//globals from QueueUIResearches:
constant boolean LIBRARY_QueueUIResearches=true
hashtable QueueUIResearches__h= InitHashtable()
constant integer QueueUIResearches__KEY_LEVELS= 0
constant integer QueueUIResearches__KEY_LEVEL_1= 1
//endglobals from QueueUIResearches
//globals from HeroReviveEvents:
constant boolean LIBRARY_HeroReviveEvents=true
constant integer HeroReviveEvents_ORDER_ID_START_REVIVE= 852027
constant integer HeroReviveEvents_ORDER_ID_REVIVE= 852039

trigger HeroReviveEvents__orderTrigger= CreateTrigger()
trigger HeroReviveEvents__startReviveTrigger= CreateTrigger()
trigger HeroReviveEvents__finishReviveTrigger= CreateTrigger()
group HeroReviveEvents__heroes= CreateGroup()
hashtable HeroReviveEvents__h= InitHashtable()
     
trigger array HeroReviveEvents__callbackOrderStartReviveTriggers
integer HeroReviveEvents__callbackStartOrderStartTriggersCounter= 0
trigger array HeroReviveEvents__callbackOrderCancelReviveTriggers
integer HeroReviveEvents__callbackStartOrderCancelTriggersCounter= 0
trigger array HeroReviveEvents__callbackStartReviveTriggers
integer HeroReviveEvents__callbackStartReviveTriggersCounter= 0
trigger array HeroReviveEvents__callbackFinishReviveTriggers
integer HeroReviveEvents__callbackFinishReviveTriggersCounter= 0
unit HeroReviveEvents__triggerReviveAltar= null
unit HeroReviveEvents__triggerReviveHero= null
//endglobals from HeroReviveEvents
//globals from Queue:
constant boolean LIBRARY_Queue=true
    // This is an indicator for an invalid ObjectName. It has to be the same for every language to avoid desyncs.
constant string Queue__EMPTY_STRING= "Default string"

trigger Queue__cancelTrainTrigger= CreateTrigger()
trigger Queue__finishTrainTrigger= CreateTrigger()
trigger Queue__cancelResearchTrigger= CreateTrigger()
trigger Queue__finishResearchTrigger= CreateTrigger()
trigger Queue__cancelUpgradeTrigger= CreateTrigger()
trigger Queue__finishUpgradeTrigger= CreateTrigger()
trigger Queue__startConstructTrigger= CreateTrigger()
trigger Queue__finishConstructTrigger= CreateTrigger()
trigger Queue__orderReviveStartTrigger= CreateTrigger()
trigger Queue__orderReviveCancelTrigger= CreateTrigger()
trigger Queue__finishReviveTrigger= CreateTrigger()
trigger Queue__orderTrigger= CreateTrigger()
trigger Queue__deathTrigger= CreateTrigger()
    
integer array Queue__playerQueue
boolean array Queue__isEnabledForPlayer
    
hashtable Queue__h= InitHashtable()
group Queue__constructions= CreateGroup()
    
group Queue__ignored= CreateGroup()
    
    // callbacks
trigger array Queue__callbackTriggers
integer Queue__callbackTriggersCount= 0
unit Queue__triggerUnit= null
integer Queue__triggerId= 0
//endglobals from Queue
//globals from QueueUI:
constant boolean LIBRARY_QueueUI=true
    // Set to false if the TOC file should not be loaded automatically.
constant boolean QueueUI_LOAD_TOC_FILE= true
constant string QueueUI_TOC_FILE= "war3mapImported\\QueueUI.toc"
constant integer QueueUI_MAX_SLOTS= 8
constant boolean QueueUI_PAN_CAMERA= true
constant string QueueUI_PREFIX= "QueueUI"
constant real QueueUI_Y= 0.19
constant real QueueUI_CHECK_BOX_X= 0.05
constant real QueueUI_CHECK_BOX_Y= QueueUI_Y
constant real QueueUI_CHECK_BOX_SIZE= 0.02
constant real QueueUI_BUTTON_SPACE= 0.001
constant real QueueUI_BUTTON_X= QueueUI_CHECK_BOX_X + QueueUI_CHECK_BOX_SIZE + QueueUI_BUTTON_SPACE
constant real QueueUI_BUTTON_Y= QueueUI_Y
constant real QueueUI_BUTTON_SIZE= 0.024
constant real QueueUI_CHARGES_SIZE= 0.014
constant real QueueUI_TOOLTIP_FONT_HEIGHT= 0.009
constant real QueueUI_TOOLTIP_Y= 0.007
constant string QueueUI_TOOLTIP_FONT= "fonts\\dfst-m3u.ttf"
    
boolean array QueueUI__enabledForPlayer
trigger QueueUI__CheckboxCheckedTrigger
trigger QueueUI__CheckboxUncheckedTrigger
framehandle QueueUI__Checkbox
framehandle QueueUI__CheckboxTooltip
framehandle array QueueUI__SlotFrame
framehandle array QueueUI__SlotBackdropFrame
framehandle array QueueUI__SlotChargesBackdropFrame
framehandle array QueueUI__SlotChargesFrame
framehandle array QueueUI__SlotTooltip
trigger array QueueUI__SlotClickTrigger
    
boolean array QueueUI__checked
    
hashtable QueueUI__h= InitHashtable()
trigger QueueUI__syncTrigger= CreateTrigger()
trigger QueueUI__queueTrigger= CreateTrigger()
//endglobals from QueueUI
    // User-defined
force udg_Players= null

    // Generated
trigger gg_trg_Initialization= null
trigger gg_trg_Game_Start= null
unit gg_unit_Hpal_0004= null
unit gg_unit_Hpal_0005= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__HeroReviveCancelEvent=1
integer si__HeroReviveCancelEvent_F=0
integer si__HeroReviveCancelEvent_I=0
integer array si__HeroReviveCancelEvent_V
constant integer s__HeroReviveCancelEvent_REVIVE_ORDER_ID_OFFSET= 852027
constant integer s__HeroReviveCancelEvent_CANCEL_ORDER_ID= 851976
constant integer s__HeroReviveCancelEvent_MAX_HERO_AMOUNT= 4
constant real s__HeroReviveCancelEvent_TIMEOUT= 0.1
hashtable s__HeroReviveCancelEvent_hash= InitHashtable()
trigger s__HeroReviveCancelEvent_handler= CreateTrigger()
integer s__HeroReviveCancelEvent_instance
unit array s__HeroReviveCancelEvent_hero
unit array s__HeroReviveCancelEvent_building
timer array s__HeroReviveCancelEvent_clock
player array s__HeroReviveCancelEvent_owner
boolean array s__HeroReviveCancelEvent_exists
constant integer si__QueueUIResearches__Research=2
integer si__QueueUIResearches__Research_F=0
integer si__QueueUIResearches__Research_I=0
integer array si__QueueUIResearches__Research_V
string array s__QueueUIResearches__Research_name
string array s__QueueUIResearches__Research_icon
constant integer si__Queue=3
integer si__Queue_F=0
integer si__Queue_I=0
integer array si__Queue_V
integer array s__Queue_id
group array s__Queue_sources
integer array s__Queue_counter
integer array s__Queue_previous
integer array s__Queue_next
trigger st__Queue_onDestroy
trigger array st___prototype10
unit f__arg_unit1
integer f__arg_this

endglobals
native UnitAlive takes unit u returns boolean


//Generated allocator of HeroReviveCancelEvent
function s__HeroReviveCancelEvent__allocate takes nothing returns integer
 local integer this=si__HeroReviveCancelEvent_F
    if (this!=0) then
        set si__HeroReviveCancelEvent_F=si__HeroReviveCancelEvent_V[this]
    else
        set si__HeroReviveCancelEvent_I=si__HeroReviveCancelEvent_I+1
        set this=si__HeroReviveCancelEvent_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__HeroReviveCancelEvent_V[this]=-1
 return this
endfunction

//Generated destructor of HeroReviveCancelEvent
function s__HeroReviveCancelEvent_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__HeroReviveCancelEvent_V[this]!=-1) then
        return
    endif
    set si__HeroReviveCancelEvent_V[this]=si__HeroReviveCancelEvent_F
    set si__HeroReviveCancelEvent_F=this
endfunction

//Generated method caller for Queue.onDestroy
function sc__Queue_onDestroy takes integer this returns nothing
    set f__arg_this=this
    call TriggerEvaluate(st__Queue_onDestroy)
endfunction

//Generated allocator of Queue
function s__Queue__allocate takes nothing returns integer
 local integer this=si__Queue_F
    if (this!=0) then
        set si__Queue_F=si__Queue_V[this]
    else
        set si__Queue_I=si__Queue_I+1
        set this=si__Queue_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__Queue_sources[this]= CreateGroup()
   set s__Queue_counter[this]= 0
   set s__Queue_previous[this]= 0
   set s__Queue_next[this]= 0
    set si__Queue_V[this]=-1
 return this
endfunction

//Generated destructor of Queue
function sc__Queue_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__Queue_V[this]!=-1) then
        return
    endif
    set f__arg_this=this
    call TriggerEvaluate(st__Queue_onDestroy)
    set si__Queue_V[this]=si__Queue_F
    set si__Queue_F=this
endfunction

//Generated allocator of QueueUIResearches__Research
function s__QueueUIResearches__Research__allocate takes nothing returns integer
 local integer this=si__QueueUIResearches__Research_F
    if (this!=0) then
        set si__QueueUIResearches__Research_F=si__QueueUIResearches__Research_V[this]
    else
        set si__QueueUIResearches__Research_I=si__QueueUIResearches__Research_I+1
        set this=si__QueueUIResearches__Research_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__QueueUIResearches__Research_V[this]=-1
 return this
endfunction

//Generated destructor of QueueUIResearches__Research
function s__QueueUIResearches__Research_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__QueueUIResearches__Research_V[this]!=-1) then
        return
    endif
    set si__QueueUIResearches__Research_V[this]=si__QueueUIResearches__Research_F
    set si__QueueUIResearches__Research_F=this
endfunction
function sc___prototype10_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype10[i])
endfunction
function sc___prototype10_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype10[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: HeroReviveEvents__RemoveUnitHook
    call sc___prototype10_evaluate(1,a0)
    //hook: Queue__ClearSourceCounterExtended
    call sc___prototype10_evaluate(2,a0)
call RemoveUnit(a0)
endfunction

//library FrameLoader:
// in 1.31 and upto 1.32.9 PTR (when I wrote this). Frames are not correctly saved and loaded, breaking the game.
// This library runs all functions added to it with a 0s delay after the game was loaded.
// function FrameLoaderAdd takes code func returns nothing
    // func runs when the game is loaded.
    function FrameLoaderAdd takes code func returns nothing
        call TriggerAddAction(FrameLoader__actionTrigger, func)
    endfunction

    function FrameLoader__timerAction takes nothing returns nothing
        call TriggerExecute(FrameLoader__actionTrigger)
    endfunction
    function FrameLoader__eventAction takes nothing returns nothing
        call TimerStart(FrameLoader__t, 0, false, function FrameLoader__timerAction)
    endfunction
    function FrameLoader__init_function takes nothing returns nothing
        call TriggerRegisterGameEvent(FrameLoader__eventTrigger, EVENT_GAME_LOADED)
        call TriggerAddAction(FrameLoader__eventTrigger, function FrameLoader__eventAction)
    endfunction

//library FrameLoader ends
//library HeroReviveCancelEvent:

//  ====API ====
//  ===== End API ====


                                                 
       
       
       
       
       
       
        function s__HeroReviveCancelEvent_destroy takes integer this returns nothing
            if s__HeroReviveCancelEvent_exists[this] then
                set s__HeroReviveCancelEvent_exists[this]=false
               
                call RemoveSavedInteger(s__HeroReviveCancelEvent_hash, GetHandleId(s__HeroReviveCancelEvent_clock[this]), 0)
                call RemoveSavedInteger(s__HeroReviveCancelEvent_hash, GetHandleId(s__HeroReviveCancelEvent_hero[this]), 0)
                call DestroyTimer(s__HeroReviveCancelEvent_clock[this])
               
                set s__HeroReviveCancelEvent_clock[this]=null
                set s__HeroReviveCancelEvent_hero[this]=null
                set s__HeroReviveCancelEvent_building[this]=null
               
                call s__HeroReviveCancelEvent_deallocate(this)
            endif
        endfunction
       
        function s__HeroReviveCancelEvent_callback takes nothing returns nothing
            local integer food
            local integer gold
            local integer lumber
           
            local integer this= LoadInteger(s__HeroReviveCancelEvent_hash, GetHandleId(GetExpiredTimer()), 0)
            if not UnitAlive(s__HeroReviveCancelEvent_building[this]) or UnitAlive(s__HeroReviveCancelEvent_hero[this]) then
                 call s__HeroReviveCancelEvent_destroy(this)
            endif
           
            // resources backup
            set gold=GetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_GOLD)
            set lumber=GetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_LUMBER)
            set food=GetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_FOOD_USED)
           
            // give some conditions that will hopefully be always enough to successfuly order the revive order
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_GOLD, 1000000)
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_LUMBER, 1000000)
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_FOOD_USED, 0)
           
            if IssueTargetOrder(s__HeroReviveCancelEvent_building[this], "revive", s__HeroReviveCancelEvent_hero[this]) then
               
                // 
                call IssueImmediateOrderById(s__HeroReviveCancelEvent_building[this], s__HeroReviveCancelEvent_CANCEL_ORDER_ID)
               
                // retrieve original resources before the handler is fired
                call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_GOLD, gold)
                call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_LUMBER, lumber)
                call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_FOOD_USED, food)
               
                // fire event
                set s__HeroReviveCancelEvent_instance=this
                call TriggerEvaluate(s__HeroReviveCancelEvent_handler)
                call s__HeroReviveCancelEvent_destroy(this)
                return
            endif
           
            // retrieve original resources
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_GOLD, gold)
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_LUMBER, lumber)
            call SetPlayerState(s__HeroReviveCancelEvent_owner[this], PLAYER_STATE_RESOURCE_FOOD_USED, food)
        endfunction

        function s__HeroReviveCancelEvent_create takes unit b,unit h returns integer
            local integer this= s__HeroReviveCancelEvent__allocate()
           
            set s__HeroReviveCancelEvent_exists[this]=true
            set s__HeroReviveCancelEvent_clock[this]=CreateTimer()
            set s__HeroReviveCancelEvent_hero[this]=h
            set s__HeroReviveCancelEvent_building[this]=b
            set s__HeroReviveCancelEvent_owner[this]=GetOwningPlayer(h)
           
            call TimerStart(s__HeroReviveCancelEvent_clock[this], s__HeroReviveCancelEvent_TIMEOUT, true, function s__HeroReviveCancelEvent_callback)
            call SaveInteger(s__HeroReviveCancelEvent_hash, GetHandleId(s__HeroReviveCancelEvent_clock[this]), 0, this)
            call SaveInteger(s__HeroReviveCancelEvent_hash, GetHandleId(s__HeroReviveCancelEvent_hero[this]), 0, this)
           
            return this
        endfunction
       
        // hero gets into revive queue, so now we start periodicaly watching it
        function s__HeroReviveCancelEvent_onReviveStart takes nothing returns boolean
            local integer orderId= GetIssuedOrderId()
            if ( orderId >= s__HeroReviveCancelEvent_REVIVE_ORDER_ID_OFFSET and orderId <= s__HeroReviveCancelEvent_REVIVE_ORDER_ID_OFFSET + s__HeroReviveCancelEvent_MAX_HERO_AMOUNT ) then
                call s__HeroReviveCancelEvent_create(GetOrderedUnit() , GetOrderTargetUnit())
            endif
            return false
        endfunction
       
        // instantly destroy instance when unit finished reviving
        function s__HeroReviveCancelEvent_onReviveFinish takes nothing returns boolean
            call s__HeroReviveCancelEvent_destroy((LoadInteger(s__HeroReviveCancelEvent_hash, GetHandleId(GetTriggerUnit()), 0)))
            return false
        endfunction
       
        function s__HeroReviveCancelEvent_onInit takes nothing returns nothing
            local trigger t
            set t=CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
            call TriggerAddCondition(t, Condition(function s__HeroReviveCancelEvent_onReviveStart))
           
            set t=CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_REVIVE_FINISH)
            call TriggerAddCondition(t, Condition(function s__HeroReviveCancelEvent_onReviveFinish))
        endfunction
       
        // for API
       
        function s__HeroReviveCancelEvent_register takes code c returns nothing
            local boolexpr bx= Condition(c)
            call SaveTriggerConditionHandle(s__HeroReviveCancelEvent_hash, GetHandleId(bx), 0, TriggerAddCondition(s__HeroReviveCancelEvent_handler, bx))
            set bx=null
        endfunction
       
        function s__HeroReviveCancelEvent_unregister takes code c returns nothing
            local boolexpr bx= Condition(c)
            call TriggerRemoveCondition(s__HeroReviveCancelEvent_handler, LoadTriggerConditionHandle(s__HeroReviveCancelEvent_hash, GetHandleId(bx), 0))
            call FlushChildHashtable(s__HeroReviveCancelEvent_hash, GetHandleId(bx))
            call DestroyBoolExpr(bx)
            set bx=null
        endfunction


//library HeroReviveCancelEvent ends
//library OnStartGame:


function OnStartGame takes code func returns nothing
    call TriggerAddAction(OnStartGame__startGameTrigger, func)
endfunction

function OnStartGame__TimerFunctionStartGame takes nothing returns nothing
    local timer t= GetExpiredTimer()
    call TriggerExecute(OnStartGame__startGameTrigger)
    call PauseTimer(t)
    call DestroyTimer(t)
    set t=null
endfunction

function OnStartGame__Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 0.0, false, function OnStartGame__TimerFunctionStartGame)
endfunction


//library OnStartGame ends
//library QueueUIResearches:



function QueueUIResearches__AddResearch takes integer id,string name,string icon returns nothing
    local integer this= s__QueueUIResearches__Research__allocate()
    local integer level= LoadInteger(QueueUIResearches__h, id, QueueUIResearches__KEY_LEVELS)
    set s__QueueUIResearches__Research_name[this]=name
    set s__QueueUIResearches__Research_icon[this]=icon
    call SaveInteger(QueueUIResearches__h, id, QueueUIResearches__KEY_LEVEL_1 + level, this)
    call SaveInteger(QueueUIResearches__h, id, QueueUIResearches__KEY_LEVELS, level + 1)
endfunction

function QueueUIResearches__GetResearch takes integer id,player whichPlayer returns integer
    local integer level= GetPlayerTechCount(whichPlayer, id, true)
    if ( level > 0 ) then
        return LoadInteger(QueueUIResearches__h, id, level) // start with level 1
    endif
    return 0
endfunction

function QueueUIResearches_GetName takes integer id,player whichPlayer returns string
    local integer r= QueueUIResearches__GetResearch(id , whichPlayer)
    if ( r != 0 ) then
        return s__QueueUIResearches__Research_name[r]
    endif
    return GetObjectName(id)
endfunction

function QueueUIResearches_GetIcon takes integer id,player whichPlayer returns string
    local integer r= QueueUIResearches__GetResearch(id , whichPlayer)
    if ( r != 0 ) then
        return s__QueueUIResearches__Research_icon[r]
    endif
    return BlzGetAbilityIcon(id)
endfunction

function QueueUIResearches__Init takes nothing returns nothing
    // Human
    call QueueUIResearches__AddResearch('Rhme' , "Steel Forged Swords" , "ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp")
    call QueueUIResearches__AddResearch('Rhme' , "Mithril Forged Swords" , "ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp")
    call QueueUIResearches__AddResearch('Rhra' , "Refined Gunpowder" , "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpTwo.blp")
    call QueueUIResearches__AddResearch('Rhra' , "Imbued Gunpowder" , "ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpThree.blp")
    call QueueUIResearches__AddResearch('Rhla' , "Reinforced Leather Armor" , "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeTwo.blp")
    call QueueUIResearches__AddResearch('Rhla' , "Dragonhide Armor" , "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeThree.blp")
    call QueueUIResearches__AddResearch('Rhar' , "Steel Plating" , "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpTwo.blp")
    call QueueUIResearches__AddResearch('Rhar' , "Mithril Plating" , "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp")
    call QueueUIResearches__AddResearch('Rhlh' , "Advanced Lumber Harvesting" , "ReplaceableTextures\\CommandButtons\\BTNHumanLumberUpgrade2.blp")
    call QueueUIResearches__AddResearch('Rhac' , "Advanced Masonry" , "ReplaceableTextures\\CommandButtons\\BTNArcaniteArchitecture.blp")
    call QueueUIResearches__AddResearch('Rhac' , "Imbued Masonry" , "ReplaceableTextures\\CommandButtons\\BTNImbuedMasonry.blp")
    call QueueUIResearches__AddResearch('Rhpt' , "Priest Master Training" , "ReplaceableTextures\\CommandButtons\\BTNPriestMaster.blp")
    call QueueUIResearches__AddResearch('Rhst' , "Sorceress Master Training" , "ReplaceableTextures\\CommandButtons\\BTNSorceressMaster.blp")
    
    // Orc
    call QueueUIResearches__AddResearch('Rost' , "Shaman Master Training" , "ReplaceableTextures\\CommandButtons\\BTNShamanMaster.blp")
    call QueueUIResearches__AddResearch('Rosp' , "Improved Spiked Barricades" , "ReplaceableTextures\\CommandButtons\\BTNImprovedSpikedBarricades.blp")
    call QueueUIResearches__AddResearch('Rosp' , "Advanced Spiked Barricades" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedSpikedBarricades.blp")
    call QueueUIResearches__AddResearch('Rowt' , "Spirit Walker Master Training" , "ReplaceableTextures\\CommandButtons\\BTNSpiritWalkerMasterTraining.blp")
    call QueueUIResearches__AddResearch('Roar' , "Thorium Armor" , "ReplaceableTextures\\CommandButtons\\BTNThoriumArmor.blp")
    call QueueUIResearches__AddResearch('Roar' , "Arcanite Armor" , "ReplaceableTextures\\CommandButtons\\BTNArcaniteArmor.blp")
    call QueueUIResearches__AddResearch('Rome' , "Thorium Melee Weapons" , "ReplaceableTextures\\CommandButtons\\BTNOrcMeleeUpTwo.blp")
    call QueueUIResearches__AddResearch('Rome' , "Arcanite Melee Weapons" , "ReplaceableTextures\\CommandButtons\\BTNOrcMeleeUpThree.blp")
    call QueueUIResearches__AddResearch('Rora' , "Thorium Ranged Weapons" , "ReplaceableTextures\\CommandButtons\\BTNThoriumRanged.blp")
    call QueueUIResearches__AddResearch('Rora' , "Arcanite Ranged Weapons" , "ReplaceableTextures\\CommandButtons\\BTNArcaniteRanged.blp")
    call QueueUIResearches__AddResearch('Rowd' , "Witch Doctor Master Training" , "ReplaceableTextures\\CommandButtons\\BTNWitchDoctorMaster.blp")
    
    // Undead
    call QueueUIResearches__AddResearch('Ruba' , "Banshee Master Training" , "ReplaceableTextures\\CommandButtons\\BTNBansheeMaster.blp")
    call QueueUIResearches__AddResearch('Rura' , "Improved Creature Attack" , "ReplaceableTextures\\CommandButtons\\BTNImprovedCreatureAttack.blp")
    call QueueUIResearches__AddResearch('Rura' , "Advanced Creature Attack" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedCreatureAttack.blp")
    call QueueUIResearches__AddResearch('Rucr' , "Improved Creature Carapace" , "ReplaceableTextures\\CommandButtons\\BTNImprovedCreatureCarapace.blp")
    call QueueUIResearches__AddResearch('Rucr' , "Advanced Creature Carapace" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedCreatureCarapace.blp")
    call QueueUIResearches__AddResearch('Rune' , "Necromancer Master Training" , "ReplaceableTextures\\CommandButtons\\BTNNecromancerMaster.blp")
    call QueueUIResearches__AddResearch('Ruar' , "Improved Unholy Armor" , "ReplaceableTextures\\CommandButtons\\BTNImprovedUnholyArmor.blp")
    call QueueUIResearches__AddResearch('Ruar' , "Advanced Unholy Armor" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyArmor.blp")
    call QueueUIResearches__AddResearch('Rume' , "Improved Unholy Strength" , "ReplaceableTextures\\CommandButtons\\BTNImprovedUnholyStrength.blp")
    call QueueUIResearches__AddResearch('Rume' , "Advanced Unholy Strength" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyStrength.blp")
    
    // Night Elf
    call QueueUIResearches__AddResearch('Redc' , "Druid of the Claw Master Training" , "ReplaceableTextures\\CommandButtons\\BTNDOCMasterTraining.blp")
    call QueueUIResearches__AddResearch('Redt' , "Druid of the Talon Master Training" , "ReplaceableTextures\\CommandButtons\\BTNDOTMasterTraining.blp")
    call QueueUIResearches__AddResearch('Rema' , "Improved Moon Armor" , "ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp")
    call QueueUIResearches__AddResearch('Rema' , "Advanced Moon Armor" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedMoonArmor.blp")
    call QueueUIResearches__AddResearch('Rerh' , "Improved Reinforced Hides" , "ReplaceableTextures\\CommandButtons\\BTNImprovedReinforcedHides.blp")
    call QueueUIResearches__AddResearch('Rerh' , "Advanced Reinforced Hides" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedReinforcedHides.blp")
    call QueueUIResearches__AddResearch('Resm' , "Improved Strength of the Moon" , "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheMoon.blp")
    call QueueUIResearches__AddResearch('Resm' , "Advanced Strength of the Moon" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp")
    call QueueUIResearches__AddResearch('Resw' , "Improved Strength of the Wild" , "ReplaceableTextures\\CommandButtons\\BTNImprovedStrengthOfTheWild.blp")
    call QueueUIResearches__AddResearch('Resw' , "Advanced Strength of the Wild" , "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheWild.blp")
    
    // Naga
    call QueueUIResearches__AddResearch('Rnat' , "Chitinous Blades" , "ReplaceableTextures\\CommandButtons\\BTNNagaWeaponUp2.blp")
    call QueueUIResearches__AddResearch('Rnat' , "Razorspine Blades" , "ReplaceableTextures\\CommandButtons\\BTNNagaWeaponUp3.blp")
    call QueueUIResearches__AddResearch('Rnam' , "Chitinous Scales" , "ReplaceableTextures\\CommandButtons\\BTNNagaArmorUp2.blp")
    call QueueUIResearches__AddResearch('Rnam' , "Razorspine Scales" , "ReplaceableTextures\\CommandButtons\\BTNNagaArmorUp3.blp")
    call QueueUIResearches__AddResearch('Rnsw' , "Naga Siren Master Training" , "ReplaceableTextures\\CommandButtons\\BTNSirenMaster.blp")
endfunction


//library QueueUIResearches ends
//library HeroReviveEvents:


function TriggerRegisterHeroReviveOrderStartEvent takes trigger whichTrigger returns nothing
    set HeroReviveEvents__callbackOrderStartReviveTriggers[HeroReviveEvents__callbackStartOrderStartTriggersCounter]=whichTrigger
    set HeroReviveEvents__callbackStartOrderStartTriggersCounter=HeroReviveEvents__callbackStartOrderStartTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveOrderCancelEvent takes trigger whichTrigger returns nothing
    set HeroReviveEvents__callbackOrderCancelReviveTriggers[HeroReviveEvents__callbackStartOrderCancelTriggersCounter]=whichTrigger
    set HeroReviveEvents__callbackStartOrderCancelTriggersCounter=HeroReviveEvents__callbackStartOrderCancelTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveStartEvent takes trigger whichTrigger returns nothing
    set HeroReviveEvents__callbackStartReviveTriggers[HeroReviveEvents__callbackStartReviveTriggersCounter]=whichTrigger
    set HeroReviveEvents__callbackStartReviveTriggersCounter=HeroReviveEvents__callbackStartReviveTriggersCounter + 1
endfunction

function TriggerRegisterHeroReviveFinishEvent takes trigger whichTrigger returns nothing
    set HeroReviveEvents__callbackFinishReviveTriggers[HeroReviveEvents__callbackFinishReviveTriggersCounter]=whichTrigger
    set HeroReviveEvents__callbackFinishReviveTriggersCounter=HeroReviveEvents__callbackFinishReviveTriggersCounter + 1
endfunction

function GetTriggerReviveAltar takes nothing returns unit
    return HeroReviveEvents__triggerReviveAltar
endfunction

function GetTriggerReviveHero takes nothing returns unit
    return HeroReviveEvents__triggerReviveHero
endfunction

function HeroReviveEvents__ExecuteCallbacksOrderStartRevive takes unit altar,unit hero returns nothing
    local integer i= 0
    set HeroReviveEvents__triggerReviveAltar=altar
    set HeroReviveEvents__triggerReviveHero=hero
    loop
        exitwhen ( i == HeroReviveEvents__callbackStartOrderStartTriggersCounter )
        if ( IsTriggerEnabled(HeroReviveEvents__callbackOrderStartReviveTriggers[i]) ) then
            call ConditionalTriggerExecute(HeroReviveEvents__callbackOrderStartReviveTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function HeroReviveEvents__ExecuteCallbacksOrderCancelRevive takes unit altar,unit hero returns nothing
    local integer i= 0
    set HeroReviveEvents__triggerReviveAltar=altar
    set HeroReviveEvents__triggerReviveHero=hero
    loop
        exitwhen ( i == HeroReviveEvents__callbackStartOrderCancelTriggersCounter )
        if ( IsTriggerEnabled(HeroReviveEvents__callbackOrderCancelReviveTriggers[i]) ) then
            call ConditionalTriggerExecute(HeroReviveEvents__callbackOrderCancelReviveTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function HeroReviveEvents__ExecuteCallbacksStartRevive takes unit altar,unit hero returns nothing
    local integer i= 0
    set HeroReviveEvents__triggerReviveAltar=altar
    set HeroReviveEvents__triggerReviveHero=hero
    loop
        exitwhen ( i == HeroReviveEvents__callbackStartReviveTriggersCounter )
        if ( IsTriggerEnabled(HeroReviveEvents__callbackStartReviveTriggers[i]) ) then
            call ConditionalTriggerExecute(HeroReviveEvents__callbackStartReviveTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function HeroReviveEvents__ExecuteCallbacksFinishRevive takes unit altar,unit hero returns nothing
    local integer i= 0
    set HeroReviveEvents__triggerReviveAltar=altar
    set HeroReviveEvents__triggerReviveHero=hero
    loop
        exitwhen ( i == HeroReviveEvents__callbackFinishReviveTriggersCounter )
        if ( IsTriggerEnabled(HeroReviveEvents__callbackFinishReviveTriggers[i]) ) then
            call ConditionalTriggerExecute(HeroReviveEvents__callbackFinishReviveTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function HeroReviveEvents__TriggerConditionOrder takes nothing returns boolean
    local unit altar= GetTriggerUnit()
    local unit hero= GetOrderTargetUnit()
    local integer orderId= GetIssuedOrderId()
    //call BJDebugMsg("Order " + GetUnitName(altar) + " " + I2S(orderId) + " with target unit " + GetUnitName(hero))
    // https://www.hiveworkshop.com/threads/getting-the-reviving-altar-for-event_unit_hero_revive_start.356746/#post-3645129
    if ( orderId == HeroReviveEvents_ORDER_ID_START_REVIVE ) then
        // save the corresponding altar for the hero
        call SaveUnitHandle(HeroReviveEvents__h, GetHandleId(hero), 0, altar)
        call HeroReviveEvents__ExecuteCallbacksOrderStartRevive(altar , hero)
    elseif ( orderId == HeroReviveEvents_ORDER_ID_REVIVE ) then // works only with HeroReviveCancelEvent
        call FlushChildHashtable(HeroReviveEvents__h, GetHandleId(hero))
        call GroupRemoveUnit(HeroReviveEvents__heroes, hero)
        call HeroReviveEvents__ExecuteCallbacksOrderCancelRevive(altar , hero)
    endif
    set altar=null
    set hero=null

    return false
endfunction

function HeroReviveEvents__TriggerConditionStartRevive takes nothing returns boolean
    local unit hero= GetRevivingUnit()
    if ( not IsUnitInGroup(hero, HeroReviveEvents__heroes) ) then
        call GroupAddUnit(HeroReviveEvents__heroes, hero)
        // GetTriggerUnit is not the altar https://www.hiveworkshop.com/threads/getting-the-reviving-altar-for-event_unit_hero_revive_start.356746/
        call HeroReviveEvents__ExecuteCallbacksStartRevive(LoadUnitHandle(HeroReviveEvents__h, GetHandleId(hero), 0) , hero)
    endif
    set hero=null

    return false
endfunction

function HeroReviveEvents__TriggerConditionFinishRevive takes nothing returns boolean
    local unit hero= GetRevivingUnit()
    if ( IsUnitInGroup(GetRevivingUnit(), HeroReviveEvents__heroes) ) then
        call GroupRemoveUnit(HeroReviveEvents__heroes, hero)
        call HeroReviveEvents__ExecuteCallbacksFinishRevive(LoadUnitHandle(HeroReviveEvents__h, GetHandleId(hero), 0) , hero)
        call FlushChildHashtable(HeroReviveEvents__h, GetHandleId(hero))
    endif
    set hero=null
    
    return false
endfunction

function HeroReviveEvents__Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(HeroReviveEvents__orderTrigger, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(HeroReviveEvents__orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(HeroReviveEvents__orderTrigger, Condition(function HeroReviveEvents__TriggerConditionOrder))

    call TriggerRegisterAnyUnitEventBJ(HeroReviveEvents__startReviveTrigger, EVENT_PLAYER_HERO_REVIVE_START)
    call TriggerAddCondition(HeroReviveEvents__startReviveTrigger, Condition(function HeroReviveEvents__TriggerConditionStartRevive))
    
    call TriggerRegisterAnyUnitEventBJ(HeroReviveEvents__finishReviveTrigger, EVENT_PLAYER_HERO_REVIVE_FINISH)
    call TriggerAddCondition(HeroReviveEvents__finishReviveTrigger, Condition(function HeroReviveEvents__TriggerConditionFinishRevive))
endfunction

function HeroReviveEvents__RemoveUnitHook takes unit whichUnit returns nothing
    call FlushChildHashtable(HeroReviveEvents__h, GetHandleId(whichUnit))
    if ( IsUnitInGroup(whichUnit, HeroReviveEvents__heroes) ) then
        call GroupRemoveUnit(HeroReviveEvents__heroes, whichUnit)
    endif
endfunction

//processed hook: hook RemoveUnit HeroReviveEvents__RemoveUnitHook


//library HeroReviveEvents ends
//library Queue:



    
    function s__Queue_onDestroy takes integer this returns nothing
        if ( s__Queue_next[this] != 0 ) then
            set s__Queue_previous[s__Queue_next[this]]=s__Queue_previous[this]
        endif
        
        if ( s__Queue_previous[this] != 0 ) then
            set s__Queue_next[s__Queue_previous[this]]=s__Queue_next[this]
        endif
        
        call GroupClear(s__Queue_sources[this])
        call DestroyGroup(s__Queue_sources[this])
        set s__Queue_sources[this]=null
    endfunction

//Generated destructor of Queue
function s__Queue_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__Queue_V[this]!=-1) then
        return
    endif
    call s__Queue_onDestroy(this)
    set si__Queue_V[this]=si__Queue_F
    set si__Queue_F=this
endfunction

function IsQueueEnabledForPlayer takes player whichPlayer returns boolean
    return Queue__isEnabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

function SetQueueEnabledForPlayer takes player whichPlayer,boolean enabled returns nothing
    set Queue__isEnabledForPlayer[GetPlayerId(whichPlayer)]=enabled
endfunction

function IgnoreQueueUnit takes unit whichUnit returns nothing
    call GroupAddUnit(Queue__ignored, whichUnit)
endfunction

function UnignoreQueueUnit takes unit whichUnit returns nothing
    call GroupRemoveUnit(Queue__ignored, whichUnit)
endfunction

function IsQueueUnitIgnored takes unit whichUnit returns boolean
    return IsUnitInGroup(whichUnit, Queue__ignored)
endfunction

function Queue__SetSourceCounter takes unit source,integer id,integer count returns nothing
    call SaveInteger(Queue__h, GetHandleId(source), id, count)
endfunction

function Queue__GetSourceCounter takes unit source,integer id returns integer
    return LoadInteger(Queue__h, GetHandleId(source), id)
endfunction

function Queue__ClearSourceCounter takes unit source returns nothing
    call FlushChildHashtable(Queue__h, GetHandleId(source))
endfunction

function GetTriggerQueueUnit takes nothing returns unit
    return Queue__triggerUnit
endfunction

function GetTriggerQueueId takes nothing returns integer
    return Queue__triggerId
endfunction

function TriggerRegisterQueueEvent takes trigger whichTrigger returns nothing
    set Queue__callbackTriggers[Queue__callbackTriggersCount]=whichTrigger
    set Queue__callbackTriggersCount=Queue__callbackTriggersCount + 1
endfunction

function Queue__ExecuteTriggerCallbacks takes unit whichUnit,integer id returns nothing
    local integer i= 0
    loop
        exitwhen ( i == Queue__callbackTriggersCount )
        if ( IsTriggerEnabled(Queue__callbackTriggers[i]) ) then
            set Queue__triggerUnit=whichUnit
            set Queue__triggerId=id
            call ConditionalTriggerExecute(Queue__callbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function GetPlayerQueue takes player whichPlayer returns integer
    return Queue__playerQueue[GetPlayerId(whichPlayer)]
endfunction

function GetPlayerQueueByIndex takes player whichPlayer,integer index returns integer
    local integer current= (Queue__playerQueue[GetPlayerId((whichPlayer))]) // INLINED!!
    local integer i= 0
    loop
        exitwhen ( current == 0 or index == i )
        set current=s__Queue_next[current]
        set i=i + 1
    endloop
    return current
endfunction

function ClearQueue takes integer queue returns nothing
    local integer current= queue
    local unit source= null
    local integer j= 0
    local integer max= 0
    loop
        exitwhen ( current == 0 )
        set queue=s__Queue_next[current]
        
        set j=0
        set max=BlzGroupGetSize(s__Queue_sources[queue])
        loop
            exitwhen ( j == max )
            set source=BlzGroupUnitAt(s__Queue_sources[current], j)
            call SaveInteger(Queue__h, GetHandleId((source )), ( s__Queue_id[current] ), ( (LoadInteger(Queue__h, GetHandleId((source )), ( s__Queue_id[current]))) - 1)) // INLINED!!
            set source=null
            set j=j + 1
        endloop
        call s__Queue_deallocate(current)
        set current=queue
    endloop
endfunction

function AddQueue takes unit source,integer id returns nothing
    local integer current= (Queue__playerQueue[GetPlayerId((GetOwningPlayer(source)))]) // INLINED!!
    local integer previous= 0
    local boolean found= false
    loop
        exitwhen ( current == 0 )
        //call BJDebugMsg("Test: " + I2S(current) + " with ID " + GetObjectName(current.id) + " looking for ID " + GetObjectName(id))
        if ( s__Queue_id[current] == id ) then
            set found=true
        endif
        
        exitwhen ( found )
        
        set previous=current
        set current=s__Queue_next[current]
    endloop
    if ( current == 0 ) then
        set current=s__Queue__allocate()
        set s__Queue_id[current]=id
        //call BJDebugMsg("Creating new queue " + I2S(current) + " with previous " + I2S(previous))
        
        if ( Queue__playerQueue[GetPlayerId(GetOwningPlayer(source))] == 0 ) then
            set Queue__playerQueue[GetPlayerId(GetOwningPlayer(source))]=current
        elseif ( previous != 0 ) then
            set s__Queue_previous[current]=previous
            set s__Queue_next[previous]=current
        endif
    endif
    
    //call BJDebugMsg("Current: " + I2S(current))
    
    if ( not IsUnitInGroup(source, s__Queue_sources[current]) ) then
        call GroupAddUnit(s__Queue_sources[current], source)
    endif
    
    call SaveInteger(Queue__h, GetHandleId((source )), ( id ), ( (LoadInteger(Queue__h, GetHandleId((source )), ( id))) + 1)) // INLINED!!
    set s__Queue_counter[current]=s__Queue_counter[current] + 1
    
    call Queue__ExecuteTriggerCallbacks(source , id)
endfunction

function RemoveQueue takes unit source,integer id returns nothing
    local player owner= GetOwningPlayer(source)
    local integer playerId= GetPlayerId(owner)
    local integer current= (Queue__playerQueue[GetPlayerId((owner))]) // INLINED!!
    local integer previous= current
    local boolean found= false
    loop
        exitwhen ( current == 0 )
        if ( s__Queue_id[current] == id and IsUnitInGroup(source, s__Queue_sources[current]) ) then
            set found=true
        endif
        
        exitwhen ( found )
        
        set previous=current
        set current=s__Queue_next[current]
    endloop
    
    if ( current != 0 ) then
        call SaveInteger(Queue__h, GetHandleId((source )), ( id ), ( (LoadInteger(Queue__h, GetHandleId((source )), ( id))) - 1)) // INLINED!!
        set s__Queue_counter[current]=s__Queue_counter[current] - 1
        if ( (LoadInteger(Queue__h, GetHandleId((source )), ( id))) == 0 ) then // INLINED!!
            call GroupRemoveUnit(s__Queue_sources[current], source)
        endif
        
        if ( BlzGroupGetSize(s__Queue_sources[current]) == 0 ) then
            if ( (Queue__playerQueue[GetPlayerId((owner))]) == current ) then // INLINED!!
                set Queue__playerQueue[playerId]=s__Queue_next[current]
            endif
            //call BJDebugMsg("Destroying " + I2S(current))
            call s__Queue_deallocate(current)
        endif
    endif
    
    call Queue__ExecuteTriggerCallbacks(source , id)
endfunction

function Queue__TriggerConditionCancelTrain takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , GetTrainedUnitType())
    endif
    
    return false
endfunction

function Queue__TriggerConditionFinishTrain takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , GetTrainedUnitType())
    endif

    return false
endfunction

function Queue__TriggerConditionCancelResearch takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , GetResearched())
    endif
    
    return false
endfunction

function Queue__TriggerConditionFinishResearch takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , GetResearched())
    endif

    return false
endfunction

function Queue__TriggerConditionCancelUpgrade takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , LoadInteger(Queue__h, GetHandleId(GetTriggerUnit()), 0)) // Use the ID from start upgrade.
    endif
    
    return false
endfunction

function Queue__TriggerConditionFinishUpgrade takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call RemoveQueue(GetTriggerUnit() , GetUnitTypeId(GetTriggerUnit())) // Already has the new ID from start upgrade at this point.
    endif

    return false
endfunction

function Queue__TriggerConditionStartConstruct takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetConstructingStructure())))]) ) then // INLINED!!
        call AddQueue(GetConstructingStructure() , GetUnitTypeId(GetConstructingStructure()))
        call GroupAddUnit(Queue__constructions, GetConstructingStructure())
    endif
    
    return false
endfunction

function Queue__TriggerConditionCancelConstruct takes nothing returns boolean
    //call BJDebugMsg("Cancel construction of " + GetUnitName(GetTriggerUnit()))
    
    return false
endfunction

function Queue__TriggerConditionFinishConstruct takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetConstructedStructure())))]) ) then // INLINED!!
        call RemoveQueue(GetConstructedStructure() , GetUnitTypeId(GetConstructedStructure()))
        call GroupRemoveUnit(Queue__constructions, GetConstructedStructure())
    endif

    return false
endfunction


function Queue__TriggerConditionOrderReviveStart takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " starts the revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer((HeroReviveEvents__triggerReviveAltar))))]) ) then // INLINED!!
        call AddQueue((HeroReviveEvents__triggerReviveAltar) , GetUnitTypeId((HeroReviveEvents__triggerReviveHero))) // INLINED!!
    endif

    return false
endfunction

function Queue__TriggerConditionOrderReviveCancel takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " cancels the revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer((HeroReviveEvents__triggerReviveAltar))))]) ) then // INLINED!!
        call RemoveQueue((HeroReviveEvents__triggerReviveAltar) , GetUnitTypeId((HeroReviveEvents__triggerReviveHero))) // INLINED!!
    endif
    
    return false
endfunction

function Queue__TriggerConditionFinishRevive takes nothing returns boolean
    //call BJDebugMsg("Altar " + GetUnitName(GetTriggerReviveAltar()) + " finishes revival of hero " + GetUnitName(GetTriggerReviveHero()))
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer((HeroReviveEvents__triggerReviveAltar))))]) ) then // INLINED!!
        call RemoveQueue((HeroReviveEvents__triggerReviveAltar) , GetUnitTypeId((HeroReviveEvents__triggerReviveHero))) // INLINED!!
    endif

    return false
endfunction


function Queue__IsValidBuilding takes unit whichUnit returns boolean
    if ( not IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE) ) then
        return false
    elseif ( IsUnitType(whichUnit, UNIT_TYPE_HERO) ) then // structure heroes are possible with the Root ability
        return false
    elseif ( GetUnitAbilityLevel(whichUnit, 'Aneu') > 0 ) then
        return false
    elseif ( GetUnitAbilityLevel(whichUnit, 'Ane2') > 0 ) then
        return false
    elseif ( GetUnitAbilityLevel(whichUnit, 'Apit') > 0 ) then
        return false
    elseif ( IsUnitInGroup(whichUnit, Queue__ignored) ) then
        return false
    endif
    return true
endfunction

function Queue__TriggerConditionOrder takes nothing returns boolean
    local unit building= GetTriggerUnit()
    local integer trainId= GetIssuedOrderId()
    //call BJDebugMsg("Order " + I2S(GetIssuedOrderId()) + ": " + GetObjectName(GetIssuedOrderId()))
    // Use only structures which do not sell units or items to avoid getting summoned and sold units and sold items.
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(building)))]) and GetObjectName(trainId) != Queue__EMPTY_STRING and GetObjectName(trainId) != null and Queue__IsValidBuilding(building) ) then // INLINED!!
        call SaveInteger(Queue__h, GetHandleId(building), 0, trainId)
        call AddQueue(building , trainId)
    endif
    
    set building=null
    
    return false
endfunction

function Queue__ClearSourceCounterExtended takes unit whichUnit returns nothing
    if ( IsUnitInGroup(whichUnit, Queue__constructions) ) then
        call RemoveQueue(whichUnit , GetUnitTypeId(whichUnit))
        call GroupRemoveUnit(Queue__constructions, whichUnit)
    endif

    call FlushChildHashtable(Queue__h, GetHandleId((whichUnit))) // INLINED!!
endfunction

function Queue__TriggerConditionDeath takes nothing returns boolean
    if ( (Queue__isEnabledForPlayer[GetPlayerId((GetOwningPlayer(GetTriggerUnit())))]) ) then // INLINED!!
        call Queue__ClearSourceCounterExtended(GetTriggerUnit())
    endif

    return false
endfunction

function Queue__Init takes nothing returns nothing
    local player slotPlayer= null
    local integer i= 0
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER ) then
            set Queue__isEnabledForPlayer[i]=true
        endif
        set slotPlayer=null
        set i=i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(Queue__cancelTrainTrigger, EVENT_PLAYER_UNIT_TRAIN_CANCEL)
    call TriggerAddCondition(Queue__cancelTrainTrigger, Condition(function Queue__TriggerConditionCancelTrain))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__finishTrainTrigger, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    call TriggerAddCondition(Queue__finishTrainTrigger, Condition(function Queue__TriggerConditionFinishTrain))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__cancelResearchTrigger, EVENT_PLAYER_UNIT_RESEARCH_CANCEL)
    call TriggerAddCondition(Queue__cancelResearchTrigger, Condition(function Queue__TriggerConditionCancelResearch))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__finishResearchTrigger, EVENT_PLAYER_UNIT_RESEARCH_FINISH)
    call TriggerAddCondition(Queue__finishResearchTrigger, Condition(function Queue__TriggerConditionFinishResearch))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__cancelUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_CANCEL)
    call TriggerAddCondition(Queue__cancelUpgradeTrigger, Condition(function Queue__TriggerConditionCancelUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__finishUpgradeTrigger, EVENT_PLAYER_UNIT_UPGRADE_FINISH)
    call TriggerAddCondition(Queue__finishUpgradeTrigger, Condition(function Queue__TriggerConditionFinishUpgrade))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__startConstructTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_START)
    call TriggerAddCondition(Queue__startConstructTrigger, Condition(function Queue__TriggerConditionStartConstruct))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__finishConstructTrigger, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(Queue__finishConstructTrigger, Condition(function Queue__TriggerConditionFinishConstruct))
    

    call TriggerRegisterHeroReviveOrderStartEvent(Queue__orderReviveStartTrigger)
    call TriggerAddCondition(Queue__orderReviveStartTrigger, Condition(function Queue__TriggerConditionOrderReviveStart))
    
    call TriggerRegisterHeroReviveOrderCancelEvent(Queue__orderReviveCancelTrigger)
    call TriggerAddCondition(Queue__orderReviveCancelTrigger, Condition(function Queue__TriggerConditionOrderReviveCancel))
    
    call TriggerRegisterHeroReviveFinishEvent(Queue__finishReviveTrigger)
    call TriggerAddCondition(Queue__finishReviveTrigger, Condition(function Queue__TriggerConditionFinishRevive))


    call TriggerRegisterAnyUnitEventBJ(Queue__orderTrigger, EVENT_PLAYER_UNIT_ISSUED_ORDER)
    call TriggerAddCondition(Queue__orderTrigger, Condition(function Queue__TriggerConditionOrder))
    
    call TriggerRegisterAnyUnitEventBJ(Queue__deathTrigger, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(Queue__deathTrigger, Condition(function Queue__TriggerConditionDeath))
endfunction

function Queue__RemoveUnitHook takes unit whichUnit returns nothing
    call Queue__ClearSourceCounterExtended(whichUnit)
    if ( (IsUnitInGroup((whichUnit), Queue__ignored)) ) then // INLINED!!
        call GroupRemoveUnit(Queue__ignored, (whichUnit)) // INLINED!!
    endif
endfunction

//processed hook: hook RemoveUnit Queue__ClearSourceCounterExtended


//library Queue ends
//library QueueUI:


function IsQueueUIEnabledForPlayer takes player whichPlayer returns boolean
    return QueueUI__enabledForPlayer[GetPlayerId(whichPlayer)]
endfunction

function QueueUI__SetSlotVisible takes integer i,boolean visible returns nothing
    call BlzFrameSetVisible(QueueUI__SlotFrame[i], visible)
    call BlzFrameSetVisible(QueueUI__SlotBackdropFrame[i], visible)
    call BlzFrameSetVisible(QueueUI__SlotChargesBackdropFrame[i], visible)
    call BlzFrameSetVisible(QueueUI__SlotChargesFrame[i], visible)
    call BlzFrameSetEnable(QueueUI__SlotTooltip[i], visible)
endfunction

function QueueUI__SetAllSlotChargesVisible takes boolean visible returns nothing
    local integer i= 0
    loop
        exitwhen ( i >= QueueUI_MAX_SLOTS )
        call QueueUI__SetSlotVisible(i , visible)
        set i=i + 1
    endloop
endfunction

function QueueUI__UpdateUIForPlayer takes player whichPlayer returns nothing
    local integer playerId= GetPlayerId(whichPlayer)
    local integer current= (Queue__playerQueue[GetPlayerId((whichPlayer))]) // INLINED!!
    local integer i= 0
    if ( QueueUI__Checkbox != null and (QueueUI__enabledForPlayer[GetPlayerId((whichPlayer))]) and not QueueUI__checked[playerId] ) then // INLINED!!
        //call BJDebugMsg("Update for player " + GetPlayerName(whichPlayer))
        loop
            exitwhen ( i >= QueueUI_MAX_SLOTS or current == 0 )
            if ( whichPlayer == GetLocalPlayer() and BlzFrameIsVisible(QueueUI__Checkbox) ) then // has not been manually hidden before
                //call BJDebugMsg("Show slot " + I2S(i))

                call BlzFrameSetTexture(QueueUI__SlotBackdropFrame[i], QueueUIResearches_GetIcon(s__Queue_id[current] , whichPlayer), 0, true)
                call BlzFrameSetText(QueueUI__SlotTooltip[i], QueueUIResearches_GetName(s__Queue_id[current] , whichPlayer))




                call BlzFrameSetText(QueueUI__SlotChargesFrame[i], I2S(s__Queue_counter[current]))
                call BlzFrameSetEnable(QueueUI__SlotTooltip[i], true)
                call QueueUI__SetSlotVisible(i , true)
            endif
            
            //call BJDebugMsg("Show slot " + I2S(i) + ": " + BlzGetAbilityIcon(current.id))
            //call BJDebugMsg("UI check " + I2S(current) + " with ID " + GetObjectName(current.id))
            
            set current=s__Queue_next[current]
            set i=i + 1
        endloop
    endif
    
    loop
        exitwhen ( i >= QueueUI_MAX_SLOTS )
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetTexture(QueueUI__SlotBackdropFrame[i], "", 0, true)
            call BlzFrameSetEnable(QueueUI__SlotTooltip[i], false)
            call QueueUI__SetSlotVisible(i , false)
        endif
        
        set i=i + 1
    endloop
endfunction

function QueueUI__ForForceUpdateUI takes nothing returns nothing
    call QueueUI__UpdateUIForPlayer(GetEnumPlayer())
endfunction

function QueueUI__UpdateUI takes nothing returns nothing
    call ForForce(GetPlayersAll(), function QueueUI__ForForceUpdateUI)
endfunction

function QueueUI__GetNextUnitToSelect takes group g,player whichPlayer returns unit
    local integer max= BlzGroupGetSize(g)
    local integer i= 0
    local unit u= null
    local unit result= null
    local boolean found= false
    if ( max > 0 ) then
        loop
            exitwhen ( i == max )
            set u=BlzGroupUnitAt(g, i)
            if ( IsUnitSelected(u, whichPlayer) ) then
                set found=true
            elseif ( found ) then
                set result=u
            endif
            set u=null
            set i=i + 1
        endloop
    
        // this happens if none of them is selected or the last one
        if ( result == null ) then
            set result=BlzGroupUnitAt(g, 0) // start at first
        endif
    endif
    
    return result
endfunction

function QueueUI__DistanceBetweenCoordinates takes real x1,real y1,real x2,real y2 returns real
    local real dx= ( x2 - x1 )
    local real dy= ( y2 - y1 )

    return SquareRoot(dx * dx + dy * dy)
endfunction

function QueueUI__SmartCameraPanToUnit takes player whichPlayer,unit target,real duration returns nothing
    local real dist
    local real x= GetUnitX(target)
    local real y= GetUnitY(target)
    if ( GetLocalPlayer() == whichPlayer ) then
        // Use only local code (no net traffic) within this block to avoid desyncs.

        set dist=QueueUI__DistanceBetweenCoordinates(x , y , GetCameraTargetPositionX() , GetCameraTargetPositionY())
        if ( dist >= bj_SMARTPAN_TRESHOLD_SNAP ) then
            // If the user is too far away, snap the camera.
            call PanCameraToTimed(x, y, 0)
        elseif ( dist >= bj_SMARTPAN_TRESHOLD_PAN ) then
            // If the user is moderately close, pan the camera.
            call PanCameraToTimed(x, y, duration)
        else
            // User is close enough, so don't touch the camera.
        endif
    endif
endfunction

function QueueUI__SelectNextSource takes player whichPlayer,integer slot returns nothing
    local integer q= GetPlayerQueueByIndex(whichPlayer , slot)
    local unit n= null
    if ( q != 0 ) then
        set n=QueueUI__GetNextUnitToSelect(s__Queue_sources[q] , whichPlayer)
        
        if ( n != null ) then
            call SelectUnitForPlayerSingle(n, whichPlayer)

            call QueueUI__SmartCameraPanToUnit(whichPlayer , n , 0.0)

        endif
    endif
endfunction

function QueueUI__TriggerActionSyncData takes nothing returns nothing
    local player whichPlayer= GetTriggerPlayer()
    local integer playerId= GetPlayerId(whichPlayer)
    local string data= BlzGetTriggerSyncData()
    local integer slot= 0
    if ( data == "Checked" ) then
        set QueueUI__checked[playerId]=true
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetText(QueueUI__CheckboxTooltip, GetLocalizedString("SHOW_QUEUE_UI"))
        endif
        call QueueUI__UpdateUIForPlayer(whichPlayer)
    elseif ( data == "Unchecked" ) then
        set QueueUI__checked[playerId]=false
        if ( whichPlayer == GetLocalPlayer() ) then
            call BlzFrameSetText(QueueUI__CheckboxTooltip, GetLocalizedString("HIDE_QUEUE_UI"))
        endif
        call QueueUI__UpdateUIForPlayer(whichPlayer)
    else
        set slot=S2I(data)
        call QueueUI__SelectNextSource(whichPlayer , slot)
    endif
    set whichPlayer=null
endfunction

function ShowQueueUI takes nothing returns nothing
    call BlzFrameSetVisible(QueueUI__Checkbox, true)
    //call BlzFrameSetVisible(CheckboxTooltip, true) // will show the text
    call QueueUI__SetAllSlotChargesVisible(true)
endfunction

function HideQueueUI takes nothing returns nothing
    call BlzFrameSetVisible(QueueUI__Checkbox, false)
    call BlzFrameSetVisible(QueueUI__CheckboxTooltip, false)
    call QueueUI__SetAllSlotChargesVisible(false)
endfunction

function SetQueueUIEnabledForPlayer takes player whichPlayer,boolean enabled returns nothing
    set QueueUI__enabledForPlayer[GetPlayerId(whichPlayer)]=enabled
    if ( enabled ) then
        if ( whichPlayer == GetLocalPlayer() ) then
            call ShowQueueUI()
        endif
        call QueueUI__UpdateUIForPlayer(whichPlayer)
    else
        if ( whichPlayer == GetLocalPlayer() ) then
            call HideQueueUI()
        endif
    endif
endfunction

function QueueUI__CheckedFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(QueueUI_PREFIX, "Checked")
    endif
endfunction

function QueueUI__UncheckedFunction takes nothing returns nothing
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(QueueUI_PREFIX, "Unchecked")
    endif
endfunction

function QueueUI__ClickItemFunction takes nothing returns nothing
    local integer handleId= GetHandleId(GetTriggeringTrigger())
    local integer slot= LoadInteger(QueueUI__h, handleId, 0)
    if ( GetLocalPlayer() == GetTriggerPlayer() ) then
        call BlzSendSyncData(QueueUI_PREFIX, I2S(slot))
    endif
endfunction

function QueueUI__CreateUI takes nothing returns nothing
    local integer i= 0
    local integer handleId= 0
    local real x= 0.0
    local real y= 0.0

    set x=QueueUI_CHECK_BOX_X
    set y=QueueUI_CHECK_BOX_Y
    
    set QueueUI__Checkbox=BlzCreateFrame("QuestCheckBox2", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
    call BlzFrameSetAbsPoint(QueueUI__Checkbox, FRAMEPOINT_TOPLEFT, x, y)
    call BlzFrameSetAbsPoint(QueueUI__Checkbox, FRAMEPOINT_BOTTOMRIGHT, x + QueueUI_CHECK_BOX_SIZE, y - QueueUI_CHECK_BOX_SIZE)
    
    set QueueUI__CheckboxTooltip=BlzCreateFrameByType("TEXT", "QueueUICheckboxTooltip", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    call BlzFrameSetTooltip(QueueUI__Checkbox, QueueUI__CheckboxTooltip)
    call BlzFrameSetPoint(QueueUI__CheckboxTooltip, FRAMEPOINT_BOTTOM, QueueUI__Checkbox, FRAMEPOINT_TOP, 0, QueueUI_TOOLTIP_Y)
    call BlzFrameSetFont(QueueUI__CheckboxTooltip, QueueUI_TOOLTIP_FONT, QueueUI_TOOLTIP_FONT_HEIGHT, 0)
    call BlzFrameSetText(QueueUI__CheckboxTooltip, GetLocalizedString("HIDE_QUEUE_UI"))
    
    set QueueUI__CheckboxCheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(QueueUI__CheckboxCheckedTrigger, QueueUI__Checkbox, FRAMEEVENT_CHECKBOX_CHECKED)
    call TriggerAddAction(QueueUI__CheckboxCheckedTrigger, function QueueUI__CheckedFunction)
    
    set QueueUI__CheckboxUncheckedTrigger=CreateTrigger()
    call BlzTriggerRegisterFrameEvent(QueueUI__CheckboxUncheckedTrigger, QueueUI__Checkbox, FRAMEEVENT_CHECKBOX_UNCHECKED)
    call TriggerAddAction(QueueUI__CheckboxUncheckedTrigger, function QueueUI__UncheckedFunction)
    
    set x=QueueUI_BUTTON_X
    set y=QueueUI_BUTTON_Y
    set i=0
    loop
        exitwhen ( i == QueueUI_MAX_SLOTS )
        set QueueUI__SlotFrame[i]=BlzCreateFrame("ScriptDialogButton", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetAbsPoint(QueueUI__SlotFrame[i], FRAMEPOINT_TOPLEFT, x, y)
        call BlzFrameSetAbsPoint(QueueUI__SlotFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + QueueUI_BUTTON_SIZE, y - QueueUI_BUTTON_SIZE)
        //call BlzFrameSetTexture(SlotFrame[index], GetIconByItemType(0), 0, true)
        //call BlzFrameSetText(SlotFrame[index], I2S(index))

        set QueueUI__SlotBackdropFrame[i]=BlzCreateFrameByType("BACKDROP", "QueueUIBackdropFrame" + I2S(i), QueueUI__SlotFrame[i], "", 1)
        call BlzFrameSetAllPoints(QueueUI__SlotBackdropFrame[i], QueueUI__SlotFrame[i])
//             call BlzFrameSetTexture(SlotBackdropFrame[index], "UI\\Widgets\\Console\\Human\\human-inventory-slotfiller.blp", 0, true)

        // TODO Set Tooltip frame for the object name
        
        set QueueUI__SlotChargesBackdropFrame[i]=BlzCreateFrameByType("BACKDROP", "QueueUIChargesBackdropFrame" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetAbsPoint(QueueUI__SlotChargesBackdropFrame[i], FRAMEPOINT_TOPLEFT, x + QueueUI_BUTTON_SIZE - QueueUI_CHARGES_SIZE, y - QueueUI_BUTTON_SIZE + QueueUI_CHARGES_SIZE)
        call BlzFrameSetAbsPoint(QueueUI__SlotChargesBackdropFrame[i], FRAMEPOINT_BOTTOMRIGHT, x + QueueUI_BUTTON_SIZE, y - QueueUI_BUTTON_SIZE)
        call BlzFrameSetTexture(QueueUI__SlotChargesBackdropFrame[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0, true)
        call BlzFrameSetLevel(QueueUI__SlotChargesBackdropFrame[i], 1)

        set QueueUI__SlotChargesFrame[i]=BlzCreateFrameByType("TEXT", "QueueUIChargesFrame" + I2S(i), QueueUI__SlotChargesBackdropFrame[i], "", 0)
        call BlzFrameSetAllPoints(QueueUI__SlotChargesFrame[i], QueueUI__SlotChargesBackdropFrame[i])
        call BlzFrameSetTextAlignment(QueueUI__SlotChargesFrame[i], TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetScale(QueueUI__SlotChargesFrame[i], 0.7)
        call BlzFrameSetEnable(QueueUI__SlotChargesFrame[i], false)
        call BlzFrameSetLevel(QueueUI__SlotChargesFrame[i], 2)

        set QueueUI__SlotClickTrigger[i]=CreateTrigger()
        call BlzTriggerRegisterFrameEvent(QueueUI__SlotClickTrigger[i], QueueUI__SlotFrame[i], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(QueueUI__SlotClickTrigger[i], function QueueUI__ClickItemFunction)
        set handleId=GetHandleId(QueueUI__SlotClickTrigger[i])
        call SaveInteger(QueueUI__h, handleId, 0, i)
        
        set QueueUI__SlotTooltip[i]=BlzCreateFrameByType("TEXT", "QueueUITooltip" + I2S(i), BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetTooltip(QueueUI__SlotFrame[i], QueueUI__SlotTooltip[i])
        call BlzFrameSetPoint(QueueUI__SlotTooltip[i], FRAMEPOINT_BOTTOM, QueueUI__SlotFrame[i], FRAMEPOINT_TOP, 0, QueueUI_TOOLTIP_Y)
        call BlzFrameSetFont(QueueUI__SlotTooltip[i], QueueUI_TOOLTIP_FONT, QueueUI_TOOLTIP_FONT_HEIGHT, 0)
        call BlzFrameSetEnable(QueueUI__SlotTooltip[i], false)

        set x=x + QueueUI_BUTTON_SIZE + QueueUI_BUTTON_SPACE

        set i=i + 1
    endloop

    call ForForce(GetPlayersAll(), function QueueUI__ForForceUpdateUI) // INLINED!!
endfunction

function QueueUI__TriggerActionUpdateQueue takes nothing returns nothing
    //call BJDebugMsg("Queue update " + GetObjectName(GetTriggerQueueId()))
    call QueueUI__UpdateUIForPlayer(GetOwningPlayer((Queue__triggerUnit))) // INLINED!!
endfunction

function QueueUI__Init takes nothing returns nothing
    local integer i= 0
    local player slotPlayer= null
    loop
        exitwhen ( i == bj_MAX_PLAYERS )
        set slotPlayer=Player(i)
        if ( GetPlayerSlotState(slotPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(slotPlayer) == MAP_CONTROL_USER ) then
            set QueueUI__enabledForPlayer[i]=true
            call BlzTriggerRegisterPlayerSyncEvent(QueueUI__syncTrigger, slotPlayer, QueueUI_PREFIX, false)
        endif
        set slotPlayer=null
        set i=i + 1
    endloop
    call TriggerAddAction(QueueUI__syncTrigger, function QueueUI__TriggerActionSyncData)
    
    call TriggerRegisterQueueEvent(QueueUI__queueTrigger)
    call TriggerAddAction(QueueUI__queueTrigger, function QueueUI__TriggerActionUpdateQueue)
    

    call BlzLoadTOCFile(QueueUI_TOC_FILE)


    call TriggerAddAction(OnStartGame__startGameTrigger, (function QueueUI__CreateUI)) // INLINED!!
    

    call TriggerAddAction(FrameLoader__actionTrigger, (function QueueUI__CreateUI)) // INLINED!!

endfunction


//library QueueUI ends
//===========================================================================
// 
// 
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: 
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
    set udg_Players=CreateForce()
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades On Start Game
//***************************************************************************
//*  HeroReviveCancelEvent
//***************************************************************************
//*  FrameLoader vjass

//***************************************************************************
//*  Barades HeroReviveEvents
//***************************************************************************
//*  Barades Queue
//***************************************************************************
//*  Barades Queue UI Researches
//***************************************************************************
//*  Barades Queue UI

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateBuildingsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hbar', - 768.0, 1280.0, 270.000, 'hbar')
    set u=BlzCreateUnitWithSkin(p, 'nmer', - 256.0, 256.0, 270.000, 'nmer')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'hcas', - 320.0, 1280.0, 270.000, 'hcas')
    set u=BlzCreateUnitWithSkin(p, 'halt', - 736.0, 800.0, 270.000, 'halt')
    set u=BlzCreateUnitWithSkin(p, 'hlum', - 1248.0, 1824.0, 270.000, 'hlum')
    set u=BlzCreateUnitWithSkin(p, 'harm', - 1280.0, 1280.0, 270.000, 'harm')
    set u=BlzCreateUnitWithSkin(p, 'hgra', - 1280.0, 768.0, 270.000, 'hgra')
    set u=BlzCreateUnitWithSkin(p, 'hbla', - 1792.0, 1280.0, 270.000, 'hbla')
    set u=BlzCreateUnitWithSkin(p, 'hctw', - 896.0, 384.0, 270.000, 'hctw')
    set u=BlzCreateUnitWithSkin(p, 'hgtw', - 1152.0, 384.0, 270.000, 'hgtw')
    set u=BlzCreateUnitWithSkin(p, 'hatw', - 640.0, 384.0, 270.000, 'hatw')
    set u=BlzCreateUnitWithSkin(p, 'hvlt', - 320.0, 768.0, 270.000, 'hvlt')
    set u=BlzCreateUnitWithSkin(p, 'hwtw', - 1408.0, 384.0, 270.000, 'hwtw')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 1856.0, 2112.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 1984.0, 1856.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 2240.0, 2176.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 2112.0, 2368.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', - 2240.0, 1856.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hars', - 1792.0, 768.0, 270.000, 'hars')
    set u=BlzCreateUnitWithSkin(p, 'ntav', - 256.0, - 256.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'ngme', - 832.0, - 256.0, 270.000, 'ngme')
    set u=BlzCreateUnitWithSkin(p, 'ngad', - 1344.0, - 192.0, 270.000, 'ngad')
endfunction

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0004=BlzCreateUnitWithSkin(p, 'Hpal', - 553.6, 1579.7, 90.000, 'Hpal')
    set u=BlzCreateUnitWithSkin(p, 'hpea', - 452.7, 1574.1, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', - 377.8, 1571.6, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', - 304.1, 1571.3, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', - 243.9, 1566.7, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', - 196.6, 1568.7, 90.000, 'hpea')
endfunction

//===========================================================================
function CreateBuildingsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'hbar', 768.0, 1280.0, 270.000, 'hbar')
    set u=BlzCreateUnitWithSkin(p, 'nmer', 256.0, 256.0, 270.000, 'nmer')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'hcas', 192.0, 1280.0, 270.000, 'hcas')
    set u=BlzCreateUnitWithSkin(p, 'hvlt', 192.0, 768.0, 270.000, 'hvlt')
    set u=BlzCreateUnitWithSkin(p, 'halt', 736.0, 736.0, 270.000, 'halt')
    set u=BlzCreateUnitWithSkin(p, 'hgra', 1280.0, 768.0, 270.000, 'hgra')
    set u=BlzCreateUnitWithSkin(p, 'harm', 1280.0, 1280.0, 270.000, 'harm')
    set u=BlzCreateUnitWithSkin(p, 'hars', 1792.0, 768.0, 270.000, 'hars')
    set u=BlzCreateUnitWithSkin(p, 'hbla', 1792.0, 1280.0, 270.000, 'hbla')
    set u=BlzCreateUnitWithSkin(p, 'hlum', 1312.0, 1824.0, 270.000, 'hlum')
    set u=BlzCreateUnitWithSkin(p, 'hatw', 640.0, 384.0, 270.000, 'hatw')
    set u=BlzCreateUnitWithSkin(p, 'hctw', 896.0, 384.0, 270.000, 'hctw')
    set u=BlzCreateUnitWithSkin(p, 'ntav', 256.0, - 256.0, 270.000, 'ntav')
    call SetUnitColor(u, ConvertPlayerColor(0))
    set u=BlzCreateUnitWithSkin(p, 'ngme', 768.0, - 256.0, 270.000, 'ngme')
    set u=BlzCreateUnitWithSkin(p, 'ngad', 1280.0, - 192.0, 270.000, 'ngad')
    set u=BlzCreateUnitWithSkin(p, 'hgtw', 1152.0, 384.0, 270.000, 'hgtw')
    set u=BlzCreateUnitWithSkin(p, 'hwtw', 1408.0, 384.0, 270.000, 'hwtw')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2112.0, 1280.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2304.0, 1344.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2368.0, 1216.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2368.0, 1088.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2560.0, 1216.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2496.0, 1472.0, 270.000, 'hhou')
    set u=BlzCreateUnitWithSkin(p, 'hhou', 2176.0, 1536.0, 270.000, 'hhou')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set gg_unit_Hpal_0005=BlzCreateUnitWithSkin(p, 'Hpal', 450.9, 1601.2, 90.000, 'Hpal')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 89.3, 1585.3, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 164.2, 1582.8, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 237.9, 1582.5, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 298.0, 1577.8, 90.000, 'hpea')
    set u=BlzCreateUnitWithSkin(p, 'hpea', 345.3, 1579.9, 90.000, 'hpea')
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'ngol', - 256.0, 2176.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
    set u=BlzCreateUnitWithSkin(p, 'ngol', 256.0, 2176.0, 270.000, 'ngol')
    call SetResourceAmount(u, 1000000)
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
    call CreateBuildingsForPlayer0()
    call CreateBuildingsForPlayer1()
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Initialization
//===========================================================================
function Trig_Initialization_Actions takes nothing returns nothing
    call SetMapFlag(MAP_FOG_ALWAYS_VISIBLE, true)
    call SetMapFlag(MAP_FOG_MAP_EXPLORED, true)
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call ForceAddPlayerSimple(Player(0), udg_Players)
    call ForceAddPlayerSimple(Player(1), udg_Players)
endfunction

//===========================================================================
function InitTrig_Initialization takes nothing returns nothing
    set gg_trg_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Initialization, function Trig_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Game Start
//===========================================================================
function Trig_Game_Start_Func002A takes nothing returns nothing
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, 999999)
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 999999)
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 300)
endfunction

function Trig_Game_Start_Actions takes nothing returns nothing
    call FogEnableOff()
    call ForForce(udg_Players, function Trig_Game_Start_Func002A)
    call KillUnit(gg_unit_Hpal_0004)
    call KillUnit(gg_unit_Hpal_0005)
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_011")
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_037")
endfunction

//===========================================================================
function InitTrig_Game_Start takes nothing returns nothing
    set gg_trg_Game_Start=CreateTrigger()
    call TriggerRegisterTimerEventSingle(gg_trg_Game_Start, 0.00)
    call TriggerAddAction(gg_trg_Game_Start, function Trig_Game_Start_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Initialization()
    call InitTrig_Game_Start()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Initialization)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: 
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)

    //   Shared Control
    call SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)

    //   Shared Advanced Control
    call SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs65710187")
call ExecuteFunc("FrameLoader__init_function")
call ExecuteFunc("OnStartGame__Init")
call ExecuteFunc("QueueUIResearches__Init")
call ExecuteFunc("HeroReviveEvents__Init")
call ExecuteFunc("Queue__Init")
call ExecuteFunc("QueueUI__Init")

    set udg_Players=CreateForce() // INLINED!!
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_Initialization) // INLINED!!

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_001")
    call SetMapDescription("TRIGSTR_003")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 320.0, 1216.0)
    call DefineStartLocation(1, 192.0, 1216.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa__Queue_onDestroy takes nothing returns boolean
local integer this=f__arg_this
        if ( s__Queue_next[this] != 0 ) then
            set s__Queue_previous[s__Queue_next[this]]=s__Queue_previous[this]
        endif
        if ( s__Queue_previous[this] != 0 ) then
            set s__Queue_next[s__Queue_previous[this]]=s__Queue_next[this]
        endif
        call GroupClear(s__Queue_sources[this])
        call DestroyGroup(s__Queue_sources[this])
        set s__Queue_sources[this]=null
   return true
endfunction
function sa___prototype10_HeroReviveEvents__RemoveUnitHook takes nothing returns boolean
    call HeroReviveEvents__RemoveUnitHook(f__arg_unit1)
    return true
endfunction
function sa___prototype10_Queue__ClearSourceCounterExtended takes nothing returns boolean
    call Queue__ClearSourceCounterExtended(f__arg_unit1)
    return true
endfunction

function jasshelper__initstructs65710187 takes nothing returns nothing
    set st__Queue_onDestroy=CreateTrigger()
    call TriggerAddCondition(st__Queue_onDestroy,Condition( function sa__Queue_onDestroy))
    set st___prototype10[1]=CreateTrigger()
    call TriggerAddAction(st___prototype10[1],function sa___prototype10_HeroReviveEvents__RemoveUnitHook)
    call TriggerAddCondition(st___prototype10[1],Condition(function sa___prototype10_HeroReviveEvents__RemoveUnitHook))
    set st___prototype10[2]=CreateTrigger()
    call TriggerAddAction(st___prototype10[2],function sa___prototype10_Queue__ClearSourceCounterExtended)
    call TriggerAddCondition(st___prototype10[2],Condition(function sa___prototype10_Queue__ClearSourceCounterExtended))




    call ExecuteFunc("s__HeroReviveCancelEvent_onInit")
endfunction

