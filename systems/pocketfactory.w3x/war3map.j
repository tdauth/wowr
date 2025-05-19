globals
//globals from Alloc:
constant boolean LIBRARY_Alloc=true
//endglobals from Alloc
//globals from Indexer:
constant boolean LIBRARY_Indexer=true
//endglobals from Indexer
//globals from LineSegmentEnumeration:
constant boolean LIBRARY_LineSegmentEnumeration=true
//endglobals from LineSegmentEnumeration
//globals from RegisterPlayerUnitEvent:
constant boolean LIBRARY_RegisterPlayerUnitEvent=true
trigger array RegisterPlayerUnitEvent___t
//endglobals from RegisterPlayerUnitEvent
//globals from Table:
constant boolean LIBRARY_Table=true
integer Table___less= 0
integer Table___more= 8190
    //Configure it if you use more than 8190 "key" variables in your map (this will never happen though).
    
hashtable Table___ht= InitHashtable()
constant integer Table___sizeK=11
constant integer Table___listK=12
//endglobals from Table
//globals from TimerUtils:
constant boolean LIBRARY_TimerUtils=true
        //How to tweak timer utils:
        // USE_HASH_TABLE = true  (new blue)
        //  * SAFEST
        //  * SLOWEST (though hash tables are kind of fast)
        //
        // USE_HASH_TABLE = false, USE_FLEXIBLE_OFFSET = true  (orange)
        //  * kinda safe (except there is a limit in the number of timers)
        //  * ALMOST FAST
        //
        // USE_HASH_TABLE = false, USE_FLEXIBLE_OFFSET = false (red)
        //  * THE FASTEST (though is only  faster than the previous method
        //                  after using the optimizer on the map)
        //  * THE LEAST SAFE ( you may have to tweak OFSSET manually for it to
        //                     work)
        //
constant boolean TimerUtils___USE_HASH_TABLE= true
constant boolean TimerUtils___USE_FLEXIBLE_OFFSET= false

constant integer TimerUtils___OFFSET= 0x100000
integer TimerUtils___VOFFSET= TimerUtils___OFFSET

        //Timers to preload at map init:
constant integer TimerUtils___QUANTITY= 256

        //Changing this  to something big will allow you to keep recycling
        // timers even when there are already AN INCREDIBLE AMOUNT of timers in
        // the stack. But it will make things far slower so that's probably a bad idea...
constant integer TimerUtils___ARRAY_SIZE= 8190

// processed:         integer array TimerUtils___data[TimerUtils___ARRAY_SIZE]
hashtable TimerUtils___ht
// processed:         timer array TimerUtils___tT[TimerUtils___ARRAY_SIZE]
integer TimerUtils___tN= 0
constant integer TimerUtils___HELD=0x28829022
        //use a totally random number here, the more improbable someone uses it, the better.

boolean TimerUtils___didinit= false
//endglobals from TimerUtils
//globals from WorldBounds:
constant boolean LIBRARY_WorldBounds=true
//endglobals from WorldBounds
//globals from PluginSpellEffect:
constant boolean LIBRARY_PluginSpellEffect=true
//endglobals from PluginSpellEffect
//globals from SpellEffectEvent:
constant boolean LIBRARY_SpellEffectEvent=true
//endglobals from SpellEffectEvent
//globals from TimedHandles:
constant boolean LIBRARY_TimedHandles=true
        // If you don't want a timer to be ran each instance
        // set this to true.
constant boolean TimedHandles___SINGLE_TIMER= true
        // If you chose a single timer then this will be the speed
        // at which the timer will update
constant real TimedHandles___UPDATE_PERIOD= 0.05
//endglobals from TimedHandles
//globals from Utilities:
constant boolean LIBRARY_Utilities=true
        // The dummy caster unit id 
constant integer Utilities_DUMMY= 'dumi'
        // Update period
constant real Utilities___PERIOD= 0.031250000
        // location z
location Utilities___LOCZ= Location(0, 0)
        // One hashtable to rule them all
hashtable Utilities___table= InitHashtable()
        // Closest Unit
unit Utilities___bj_closestUnitGroup
//endglobals from Utilities
//globals from PocketFactory:
constant boolean LIBRARY_PocketFactory=true
unit PocketFactory___triggerCaster= null
unit PocketFactory___triggerPocketFactory= null
unit PocketFactory___triggerClockwerkGoblin= null
trigger array PocketFactory___callbackTriggers
integer PocketFactory___callbackTriggersCounter= 0
trigger array PocketFactory___callbackTriggersClockwerkGoblin
integer PocketFactory___callbackTriggersClockwerkGoblinCounter= 0
    
group PocketFactory___casters= CreateGroup()
    
trigger PocketFactory___castTrigger= CreateTrigger()
trigger PocketFactory___enterTrigger= CreateTrigger()
player PocketFactory___filterPlayer= null
filterfunc PocketFactory___f= null
//endglobals from PocketFactory
    // Generated
trigger gg_trg_WorldBounds= null
trigger gg_trg_Melee_Initialization= null
trigger gg_trg_Summon_Pocket_Factory= null
trigger gg_trg_Summon_Unit= null
trigger gg_trg_Summon_Clockwerk_Goblin= null
trigger gg_trg_SpellEffectEvent= null
trigger gg_trg_SpellEffectPlugin= null
trigger gg_trg_TimedHandles= null
trigger gg_trg_LineSegment= null
trigger gg_trg_Indexer= null
trigger gg_trg_Utilities= null
trigger gg_trg_Table= null
trigger gg_trg_Alloc= null
trigger gg_trg_TimerUtils= null
trigger gg_trg_RegisterPlayerUnitEvent_Magtheridon96= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__Indexer=1
integer si__Indexer_F=0
integer si__Indexer_I=0
integer array si__Indexer_V
integer s__Indexer_ability= 'A1YZ'
integer array s__Indexer_array
integer s__Indexer_key= - 1
integer s__Indexer_id= - 1
unit s__Indexer_unit
trigger s__Indexer_onIndex= CreateTrigger()
trigger s__Indexer_onDeindex= CreateTrigger()
constant integer si__LineSegment=2
constant real s__LineSegment_MAX_UNIT_COLLISION= 197.00
constant rect s__LineSegment_RECT= Rect(0, 0, 0, 0)
constant group s__LineSegment_GROUP= CreateGroup()
real s__LineSegment_ox
real s__LineSegment_oy
real s__LineSegment_dx
real s__LineSegment_dy
real s__LineSegment_da
real s__LineSegment_db
real s__LineSegment_ui
real s__LineSegment_uj
real s__LineSegment_wdx
real s__LineSegment_wdy
integer s__LineSegment_DestructableCounter= - 1
destructable array s__LineSegment_Destructable
integer s__LineSegment_ItemCounter= - 1
item array s__LineSegment_Item
constant integer si__Table___dex=3
constant integer si__Table___handles=4
constant integer si__Table___agents=5
constant integer si__Table___reals=6
constant integer si__Table___booleans=7
constant integer si__Table___strings=8
constant integer si__Table___integers=9
constant integer si__Table___players=10
constant integer si__Table___widgets=11
constant integer si__Table___destructables=12
constant integer si__Table___items=13
constant integer si__Table___units=14
constant integer si__Table___abilitys=15
constant integer si__Table___timers=16
constant integer si__Table___triggers=17
constant integer si__Table___triggerconditions=18
constant integer si__Table___triggeractions=19
constant integer si__Table___events=20
constant integer si__Table___forces=21
constant integer si__Table___groups=22
constant integer si__Table___locations=23
constant integer si__Table___rects=24
constant integer si__Table___boolexprs=25
constant integer si__Table___sounds=26
constant integer si__Table___effects=27
constant integer si__Table___unitpools=28
constant integer si__Table___itempools=29
constant integer si__Table___quests=30
constant integer si__Table___questitems=31
constant integer si__Table___defeatconditions=32
constant integer si__Table___timerdialogs=33
constant integer si__Table___leaderboards=34
constant integer si__Table___multiboards=35
constant integer si__Table___multiboarditems=36
constant integer si__Table___trackables=37
constant integer si__Table___dialogs=38
constant integer si__Table___buttons=39
constant integer si__Table___texttags=40
constant integer si__Table___lightnings=41
constant integer si__Table___images=42
constant integer si__Table___ubersplats=43
constant integer si__Table___regions=44
constant integer si__Table___fogstates=45
constant integer si__Table___fogmodifiers=46
constant integer si__Table___hashtables=47
constant integer si__Table=48
constant integer si__TableArray=49
integer s__TableArray_tempTable
integer s__TableArray_tempEnd
constant integer si__HashTable=50
constant integer si__WorldBounds=51
integer s__WorldBounds_maxX
integer s__WorldBounds_maxY
integer s__WorldBounds_minX
integer s__WorldBounds_minY
integer s__WorldBounds_centerX
integer s__WorldBounds_centerY
rect s__WorldBounds_world
region s__WorldBounds_worldRegion
constant integer si__PluginSpellEffect___SUnit=52
integer si__PluginSpellEffect___SUnit_F=0
integer si__PluginSpellEffect___SUnit_I=0
integer array si__PluginSpellEffect___SUnit_V
unit array s__PluginSpellEffect___SUnit_unit
player array s__PluginSpellEffect___SUnit_player
integer array s__PluginSpellEffect___SUnit_handle
boolean array s__PluginSpellEffect___SUnit_isHero
boolean array s__PluginSpellEffect___SUnit_isStructure
integer array s__PluginSpellEffect___SUnit_id
real array s__PluginSpellEffect___SUnit_x
real array s__PluginSpellEffect___SUnit_y
real array s__PluginSpellEffect___SUnit_z
constant integer si__Spell=53
location s__Spell_location= Location(0, 0)
integer s__Spell_source
integer s__Spell_target
ability s__Spell_ability
integer s__Spell_level
integer s__Spell_id
real s__Spell_x
real s__Spell_y
real s__Spell_z
constant integer si__SpellEffectEvent___S=54
integer s__SpellEffectEvent___S_tb
constant integer si__effectTimed=55
integer si__effectTimed_F=0
integer si__effectTimed_I=0
integer array si__effectTimed_V
effect array s__effectTimed_effect_var
integer s__effectTimed_index= - 1
integer array s__effectTimed_instance
real s__effectTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__effectTimed_timer= CreateTimer()
real array s__effectTimed_duration
real array s__effectTimed_elapsed
constant integer si__lightningTimed=56
integer si__lightningTimed_F=0
integer si__lightningTimed_I=0
integer array si__lightningTimed_V
lightning array s__lightningTimed_lightning_var
integer s__lightningTimed_index= - 1
integer array s__lightningTimed_instance
real s__lightningTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__lightningTimed_timer= CreateTimer()
real array s__lightningTimed_duration
real array s__lightningTimed_elapsed
constant integer si__weathereffectTimed=57
integer si__weathereffectTimed_F=0
integer si__weathereffectTimed_I=0
integer array si__weathereffectTimed_V
weathereffect array s__weathereffectTimed_weathereffect_var
integer s__weathereffectTimed_index= - 1
integer array s__weathereffectTimed_instance
real s__weathereffectTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__weathereffectTimed_timer= CreateTimer()
real array s__weathereffectTimed_duration
real array s__weathereffectTimed_elapsed
constant integer si__itemTimed=58
integer si__itemTimed_F=0
integer si__itemTimed_I=0
integer array si__itemTimed_V
item array s__itemTimed_item_var
integer s__itemTimed_index= - 1
integer array s__itemTimed_instance
real s__itemTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__itemTimed_timer= CreateTimer()
real array s__itemTimed_duration
real array s__itemTimed_elapsed
constant integer si__unitTimed=59
integer si__unitTimed_F=0
integer si__unitTimed_I=0
integer array si__unitTimed_V
unit array s__unitTimed_unit_var
integer s__unitTimed_index= - 1
integer array s__unitTimed_instance
real s__unitTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__unitTimed_timer= CreateTimer()
real array s__unitTimed_duration
real array s__unitTimed_elapsed
constant integer si__ubersplatTimed=60
integer si__ubersplatTimed_F=0
integer si__ubersplatTimed_I=0
integer array si__ubersplatTimed_V
ubersplat array s__ubersplatTimed_ubersplat_var
integer s__ubersplatTimed_index= - 1
integer array s__ubersplatTimed_instance
real s__ubersplatTimed_REAL=TimedHandles___UPDATE_PERIOD
timer s__ubersplatTimed_timer= CreateTimer()
real array s__ubersplatTimed_duration
real array s__ubersplatTimed_elapsed
constant integer si__ResetCooldown=61
integer si__ResetCooldown_F=0
integer si__ResetCooldown_I=0
integer array si__ResetCooldown_V
timer array s__ResetCooldown_timer
unit array s__ResetCooldown_unit
integer array s__ResetCooldown_ability
constant integer si__TimedAbility=62
integer si__TimedAbility_F=0
integer si__TimedAbility_I=0
integer array si__TimedAbility_V
timer s__TimedAbility_timer= CreateTimer()
integer s__TimedAbility_key= - 1
integer array s__TimedAbility_array
unit array s__TimedAbility_unit
integer array s__TimedAbility_ability
real array s__TimedAbility_duration
constant integer si__EffectSpam=63
integer si__EffectSpam_F=0
integer si__EffectSpam_I=0
integer array si__EffectSpam_V
timer array s__EffectSpam_timer
unit array s__EffectSpam_unit
integer array s__EffectSpam_i
string array s__EffectSpam_effect
string array s__EffectSpam_point
real array s__EffectSpam_scale
real array s__EffectSpam_x
real array s__EffectSpam_y
real array s__EffectSpam_z
constant integer si__ChainLightning=64
integer si__ChainLightning_F=0
integer si__ChainLightning_I=0
integer array si__ChainLightning_V
timer array s__ChainLightning_timer
unit array s__ChainLightning_unit
unit array s__ChainLightning_prev
unit array s__ChainLightning_self
unit array s__ChainLightning_next
group array s__ChainLightning_group
group array s__ChainLightning_damaged
player array s__ChainLightning_player
real array s__ChainLightning_damage
real array s__ChainLightning_range
real array s__ChainLightning_duration
integer array s__ChainLightning_bounces
attacktype array s__ChainLightning_attacktype
damagetype array s__ChainLightning_damagetype
string array s__ChainLightning_lightning
string array s__ChainLightning_effect
string array s__ChainLightning_attach
boolean array s__ChainLightning_rebounce
constant integer si__DummyPool=65
integer si__DummyPool_F=0
integer si__DummyPool_I=0
integer array si__DummyPool_V
player s__DummyPool_player= Player(PLAYER_NEUTRAL_PASSIVE)
group s__DummyPool_group= CreateGroup()
timer array s__DummyPool_timer
unit array s__DummyPool_unit
constant integer si__EffectLink=66
integer si__EffectLink_F=0
integer si__EffectLink_I=0
integer array si__EffectLink_V
timer s__EffectLink_timer= CreateTimer()
integer s__EffectLink_didx= - 1
integer array s__EffectLink_data
integer s__EffectLink_ditem= - 1
integer array s__EffectLink_items
unit array s__EffectLink_unit
effect array s__EffectLink_effect
item array s__EffectLink_item
integer array s__EffectLink_buff
constant integer si__AbilityCooldown=67
integer si__AbilityCooldown_F=0
integer si__AbilityCooldown_I=0
integer array si__AbilityCooldown_V
timer array s__AbilityCooldown_timer
unit array s__AbilityCooldown_unit
integer array s__AbilityCooldown_ability
real array s__AbilityCooldown_newCd
constant integer si__TimedDestructable=68
integer si__TimedDestructable_F=0
integer si__TimedDestructable_I=0
integer array si__TimedDestructable_V
constant real s__TimedDestructable_period= 0.03125000
timer s__TimedDestructable_timer= CreateTimer()
integer s__TimedDestructable_id= - 1
integer array s__TimedDestructable_array
destructable array s__TimedDestructable_destructable
real array s__TimedDestructable_duration
constant integer si__TimedPause=69
integer si__TimedPause_F=0
integer si__TimedPause_I=0
integer array si__TimedPause_V
integer array s__TimedPause_array
timer array s__TimedPause_timer
unit array s__TimedPause_unit
integer array s__TimedPause_key
boolean array s__TimedPause_flag
integer array s__TimerUtils___data
timer array s__TimerUtils___tT
trigger st__ResetCooldown_reset
trigger st__TimedAbility_add
trigger st__EffectSpam_spam
trigger st__ChainLightning_create
trigger st__DummyPool_recycle
trigger st__DummyPool_retrieve
trigger st__DummyPool_recycleTimed
trigger st__EffectLink_BuffLink
trigger st__EffectLink_ItemLink
trigger st__AbilityCooldown_start
trigger st__TimedDestructable_create
trigger st__TimedPause_create
trigger array st___prototype11
trigger array st___prototype46
unit f__arg_unit1
unit f__arg_unit2
integer f__arg_integer1
integer f__arg_integer2
real f__arg_real1
real f__arg_real2
real f__arg_real3
real f__arg_real4
real f__arg_real5
boolean f__arg_boolean1
string f__arg_string1
string f__arg_string2
string f__arg_string3
attacktype f__arg_attacktype1
damagetype f__arg_damagetype1
player f__arg_player1
item f__arg_item1
destructable f__arg_destructable1
integer f__result_integer
unit f__result_unit

endglobals
    native UnitAlive takes unit id returns boolean


//Generated allocator of Indexer
function s__Indexer__allocate takes nothing returns integer
 local integer this=si__Indexer_F
    if (this!=0) then
        set si__Indexer_F=si__Indexer_V[this]
    else
        set si__Indexer_I=si__Indexer_I+1
        set this=si__Indexer_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__Indexer_V[this]=-1
 return this
endfunction

//Generated destructor of Indexer
function s__Indexer_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__Indexer_V[this]!=-1) then
        return
    endif
    set si__Indexer_V[this]=si__Indexer_F
    set si__Indexer_F=this
endfunction

//Generated method caller for TimedPause.create
function sc__TimedPause_create takes unit u,real duration,boolean pause returns integer
    set f__arg_unit1=u
    set f__arg_real1=duration
    set f__arg_boolean1=pause
    call TriggerEvaluate(st__TimedPause_create)
 return f__result_integer
endfunction

//Generated allocator of TimedPause
function s__TimedPause__allocate takes nothing returns integer
 local integer this=si__TimedPause_F
    if (this!=0) then
        set si__TimedPause_F=si__TimedPause_V[this]
    else
        set si__TimedPause_I=si__TimedPause_I+1
        set this=si__TimedPause_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__TimedPause_V[this]=-1
 return this
endfunction

//Generated destructor of TimedPause
function s__TimedPause_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__TimedPause_V[this]!=-1) then
        return
    endif
    set si__TimedPause_V[this]=si__TimedPause_F
    set si__TimedPause_F=this
endfunction

//Generated method caller for TimedDestructable.create
function sc__TimedDestructable_create takes destructable dest,real timeout returns integer
    set f__arg_destructable1=dest
    set f__arg_real1=timeout
    call TriggerEvaluate(st__TimedDestructable_create)
 return f__result_integer
endfunction

//Generated allocator of TimedDestructable
function s__TimedDestructable__allocate takes nothing returns integer
 local integer this=si__TimedDestructable_F
    if (this!=0) then
        set si__TimedDestructable_F=si__TimedDestructable_V[this]
    else
        set si__TimedDestructable_I=si__TimedDestructable_I+1
        set this=si__TimedDestructable_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__TimedDestructable_V[this]=-1
 return this
endfunction

//Generated destructor of TimedDestructable
function s__TimedDestructable_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__TimedDestructable_V[this]!=-1) then
        return
    endif
    set si__TimedDestructable_V[this]=si__TimedDestructable_F
    set si__TimedDestructable_F=this
endfunction

//Generated method caller for AbilityCooldown.start
function sc__AbilityCooldown_start takes unit source,integer abilCode,real cooldown returns nothing
    set f__arg_unit1=source
    set f__arg_integer1=abilCode
    set f__arg_real1=cooldown
    call TriggerEvaluate(st__AbilityCooldown_start)
endfunction

//Generated allocator of AbilityCooldown
function s__AbilityCooldown__allocate takes nothing returns integer
 local integer this=si__AbilityCooldown_F
    if (this!=0) then
        set si__AbilityCooldown_F=si__AbilityCooldown_V[this]
    else
        set si__AbilityCooldown_I=si__AbilityCooldown_I+1
        set this=si__AbilityCooldown_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__AbilityCooldown_V[this]=-1
 return this
endfunction

//Generated destructor of AbilityCooldown
function s__AbilityCooldown_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__AbilityCooldown_V[this]!=-1) then
        return
    endif
    set si__AbilityCooldown_V[this]=si__AbilityCooldown_F
    set si__AbilityCooldown_F=this
endfunction

//Generated method caller for EffectLink.BuffLink
function sc__EffectLink_BuffLink takes unit target,integer id,string model,string attach returns nothing
    set f__arg_unit1=target
    set f__arg_integer1=id
    set f__arg_string1=model
    set f__arg_string2=attach
    call TriggerEvaluate(st__EffectLink_BuffLink)
endfunction

//Generated method caller for EffectLink.ItemLink
function sc__EffectLink_ItemLink takes unit target,item i,string model,string attach returns nothing
    set f__arg_unit1=target
    set f__arg_item1=i
    set f__arg_string1=model
    set f__arg_string2=attach
    call TriggerEvaluate(st__EffectLink_ItemLink)
endfunction

//Generated allocator of EffectLink
function s__EffectLink__allocate takes nothing returns integer
 local integer this=si__EffectLink_F
    if (this!=0) then
        set si__EffectLink_F=si__EffectLink_V[this]
    else
        set si__EffectLink_I=si__EffectLink_I+1
        set this=si__EffectLink_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__EffectLink_V[this]=-1
 return this
endfunction

//Generated destructor of EffectLink
function s__EffectLink_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__EffectLink_V[this]!=-1) then
        return
    endif
    set si__EffectLink_V[this]=si__EffectLink_F
    set si__EffectLink_F=this
endfunction

//Generated method caller for DummyPool.recycle
function sc__DummyPool_recycle takes unit dummy returns nothing
            if GetUnitTypeId(dummy) != Utilities_DUMMY then
            else
                call GroupAddUnit(s__DummyPool_group, dummy)
                call SetUnitX(dummy, s__WorldBounds_maxX)
                call SetUnitY(dummy, s__WorldBounds_maxY)
                call SetUnitOwner(dummy, s__DummyPool_player, false)
                call ShowUnit(dummy, false)
                call BlzPauseUnitEx(dummy, true)
            endif
endfunction

//Generated method caller for DummyPool.retrieve
function sc__DummyPool_retrieve takes player owner,real x,real y,real z,real face returns unit
    set f__arg_player1=owner
    set f__arg_real1=x
    set f__arg_real2=y
    set f__arg_real3=z
    set f__arg_real4=face
    call TriggerEvaluate(st__DummyPool_retrieve)
 return f__result_unit
endfunction

//Generated method caller for DummyPool.recycleTimed
function sc__DummyPool_recycleTimed takes unit dummy,real delay returns nothing
    set f__arg_unit1=dummy
    set f__arg_real1=delay
    call TriggerEvaluate(st__DummyPool_recycleTimed)
endfunction

//Generated allocator of DummyPool
function s__DummyPool__allocate takes nothing returns integer
 local integer this=si__DummyPool_F
    if (this!=0) then
        set si__DummyPool_F=si__DummyPool_V[this]
    else
        set si__DummyPool_I=si__DummyPool_I+1
        set this=si__DummyPool_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__DummyPool_V[this]=-1
 return this
endfunction

//Generated destructor of DummyPool
function s__DummyPool_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__DummyPool_V[this]!=-1) then
        return
    endif
    set si__DummyPool_V[this]=si__DummyPool_F
    set si__DummyPool_F=this
endfunction

//Generated method caller for ChainLightning.create
function sc__ChainLightning_create takes unit source,unit target,real dmg,real aoe,real dur,real interval,integer bounceCount,attacktype attackType,damagetype damageType,string lightningType,string sfx,string attachPoint,boolean canRebounce returns integer
    set f__arg_unit1=source
    set f__arg_unit2=target
    set f__arg_real1=dmg
    set f__arg_real2=aoe
    set f__arg_real3=dur
    set f__arg_real4=interval
    set f__arg_integer1=bounceCount
    set f__arg_attacktype1=attackType
    set f__arg_damagetype1=damageType
    set f__arg_string1=lightningType
    set f__arg_string2=sfx
    set f__arg_string3=attachPoint
    set f__arg_boolean1=canRebounce
    call TriggerEvaluate(st__ChainLightning_create)
 return f__result_integer
endfunction

//Generated allocator of ChainLightning
function s__ChainLightning__allocate takes nothing returns integer
 local integer this=si__ChainLightning_F
    if (this!=0) then
        set si__ChainLightning_F=si__ChainLightning_V[this]
    else
        set si__ChainLightning_I=si__ChainLightning_I+1
        set this=si__ChainLightning_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__ChainLightning_V[this]=-1
 return this
endfunction

//Generated destructor of ChainLightning
function s__ChainLightning_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__ChainLightning_V[this]!=-1) then
        return
    endif
    set si__ChainLightning_V[this]=si__ChainLightning_F
    set si__ChainLightning_F=this
endfunction

//Generated method caller for EffectSpam.spam
function sc__EffectSpam_spam takes unit target,string model,string attach,real x,real y,real z,real scale,real interval,integer count returns nothing
    set f__arg_unit1=target
    set f__arg_string1=model
    set f__arg_string2=attach
    set f__arg_real1=x
    set f__arg_real2=y
    set f__arg_real3=z
    set f__arg_real4=scale
    set f__arg_real5=interval
    set f__arg_integer1=count
    call TriggerEvaluate(st__EffectSpam_spam)
endfunction

//Generated allocator of EffectSpam
function s__EffectSpam__allocate takes nothing returns integer
 local integer this=si__EffectSpam_F
    if (this!=0) then
        set si__EffectSpam_F=si__EffectSpam_V[this]
    else
        set si__EffectSpam_I=si__EffectSpam_I+1
        set this=si__EffectSpam_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__EffectSpam_V[this]=-1
 return this
endfunction

//Generated destructor of EffectSpam
function s__EffectSpam_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__EffectSpam_V[this]!=-1) then
        return
    endif
    set si__EffectSpam_V[this]=si__EffectSpam_F
    set si__EffectSpam_F=this
endfunction

//Generated method caller for TimedAbility.add
function sc__TimedAbility_add takes unit u,integer id,real duration,integer level,boolean hide returns nothing
    set f__arg_unit1=u
    set f__arg_integer1=id
    set f__arg_real1=duration
    set f__arg_integer2=level
    set f__arg_boolean1=hide
    call TriggerEvaluate(st__TimedAbility_add)
endfunction

//Generated allocator of TimedAbility
function s__TimedAbility__allocate takes nothing returns integer
 local integer this=si__TimedAbility_F
    if (this!=0) then
        set si__TimedAbility_F=si__TimedAbility_V[this]
    else
        set si__TimedAbility_I=si__TimedAbility_I+1
        set this=si__TimedAbility_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__TimedAbility_V[this]=-1
 return this
endfunction

//Generated destructor of TimedAbility
function s__TimedAbility_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__TimedAbility_V[this]!=-1) then
        return
    endif
    set si__TimedAbility_V[this]=si__TimedAbility_F
    set si__TimedAbility_F=this
endfunction

//Generated method caller for ResetCooldown.reset
function sc__ResetCooldown_reset takes unit u,integer id returns nothing
    set f__arg_unit1=u
    set f__arg_integer1=id
    call TriggerEvaluate(st__ResetCooldown_reset)
endfunction

//Generated allocator of ResetCooldown
function s__ResetCooldown__allocate takes nothing returns integer
 local integer this=si__ResetCooldown_F
    if (this!=0) then
        set si__ResetCooldown_F=si__ResetCooldown_V[this]
    else
        set si__ResetCooldown_I=si__ResetCooldown_I+1
        set this=si__ResetCooldown_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__ResetCooldown_V[this]=-1
 return this
endfunction

//Generated destructor of ResetCooldown
function s__ResetCooldown_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__ResetCooldown_V[this]!=-1) then
        return
    endif
    set si__ResetCooldown_V[this]=si__ResetCooldown_F
    set si__ResetCooldown_F=this
endfunction

//Generated allocator of ubersplatTimed
function s__ubersplatTimed__allocate takes nothing returns integer
 local integer this=si__ubersplatTimed_F
    if (this!=0) then
        set si__ubersplatTimed_F=si__ubersplatTimed_V[this]
    else
        set si__ubersplatTimed_I=si__ubersplatTimed_I+1
        set this=si__ubersplatTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__ubersplatTimed_elapsed[this]= 0
    set si__ubersplatTimed_V[this]=-1
 return this
endfunction

//Generated destructor of ubersplatTimed
function s__ubersplatTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__ubersplatTimed_V[this]!=-1) then
        return
    endif
    set si__ubersplatTimed_V[this]=si__ubersplatTimed_F
    set si__ubersplatTimed_F=this
endfunction

//Generated allocator of unitTimed
function s__unitTimed__allocate takes nothing returns integer
 local integer this=si__unitTimed_F
    if (this!=0) then
        set si__unitTimed_F=si__unitTimed_V[this]
    else
        set si__unitTimed_I=si__unitTimed_I+1
        set this=si__unitTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__unitTimed_elapsed[this]= 0
    set si__unitTimed_V[this]=-1
 return this
endfunction

//Generated destructor of unitTimed
function s__unitTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__unitTimed_V[this]!=-1) then
        return
    endif
    set si__unitTimed_V[this]=si__unitTimed_F
    set si__unitTimed_F=this
endfunction

//Generated allocator of itemTimed
function s__itemTimed__allocate takes nothing returns integer
 local integer this=si__itemTimed_F
    if (this!=0) then
        set si__itemTimed_F=si__itemTimed_V[this]
    else
        set si__itemTimed_I=si__itemTimed_I+1
        set this=si__itemTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__itemTimed_elapsed[this]= 0
    set si__itemTimed_V[this]=-1
 return this
endfunction

//Generated destructor of itemTimed
function s__itemTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__itemTimed_V[this]!=-1) then
        return
    endif
    set si__itemTimed_V[this]=si__itemTimed_F
    set si__itemTimed_F=this
endfunction

//Generated allocator of weathereffectTimed
function s__weathereffectTimed__allocate takes nothing returns integer
 local integer this=si__weathereffectTimed_F
    if (this!=0) then
        set si__weathereffectTimed_F=si__weathereffectTimed_V[this]
    else
        set si__weathereffectTimed_I=si__weathereffectTimed_I+1
        set this=si__weathereffectTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__weathereffectTimed_elapsed[this]= 0
    set si__weathereffectTimed_V[this]=-1
 return this
endfunction

//Generated destructor of weathereffectTimed
function s__weathereffectTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__weathereffectTimed_V[this]!=-1) then
        return
    endif
    set si__weathereffectTimed_V[this]=si__weathereffectTimed_F
    set si__weathereffectTimed_F=this
endfunction

//Generated allocator of lightningTimed
function s__lightningTimed__allocate takes nothing returns integer
 local integer this=si__lightningTimed_F
    if (this!=0) then
        set si__lightningTimed_F=si__lightningTimed_V[this]
    else
        set si__lightningTimed_I=si__lightningTimed_I+1
        set this=si__lightningTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__lightningTimed_elapsed[this]= 0
    set si__lightningTimed_V[this]=-1
 return this
endfunction

//Generated destructor of lightningTimed
function s__lightningTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__lightningTimed_V[this]!=-1) then
        return
    endif
    set si__lightningTimed_V[this]=si__lightningTimed_F
    set si__lightningTimed_F=this
endfunction

//Generated allocator of effectTimed
function s__effectTimed__allocate takes nothing returns integer
 local integer this=si__effectTimed_F
    if (this!=0) then
        set si__effectTimed_F=si__effectTimed_V[this]
    else
        set si__effectTimed_I=si__effectTimed_I+1
        set this=si__effectTimed_I
    endif
    if (this>8190) then
        return 0
    endif

   set s__effectTimed_elapsed[this]= 0
    set si__effectTimed_V[this]=-1
 return this
endfunction

//Generated destructor of effectTimed
function s__effectTimed_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__effectTimed_V[this]!=-1) then
        return
    endif
    set si__effectTimed_V[this]=si__effectTimed_F
    set si__effectTimed_F=this
endfunction

//Generated allocator of PluginSpellEffect___SUnit
function s__PluginSpellEffect___SUnit__allocate takes nothing returns integer
 local integer this=si__PluginSpellEffect___SUnit_F
    if (this!=0) then
        set si__PluginSpellEffect___SUnit_F=si__PluginSpellEffect___SUnit_V[this]
    else
        set si__PluginSpellEffect___SUnit_I=si__PluginSpellEffect___SUnit_I+1
        set this=si__PluginSpellEffect___SUnit_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__PluginSpellEffect___SUnit_V[this]=-1
 return this
endfunction

//Generated destructor of PluginSpellEffect___SUnit
function s__PluginSpellEffect___SUnit_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__PluginSpellEffect___SUnit_V[this]!=-1) then
        return
    endif
    set si__PluginSpellEffect___SUnit_V[this]=si__PluginSpellEffect___SUnit_F
    set si__PluginSpellEffect___SUnit_F=this
endfunction
function sc___prototype11_execute takes integer i returns nothing

    call TriggerExecute(st___prototype11[i])
endfunction
function sc___prototype11_evaluate takes integer i returns nothing

    call TriggerEvaluate(st___prototype11[i])

endfunction
function sc___prototype46_execute takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerExecute(st___prototype46[i])
endfunction
function sc___prototype46_evaluate takes integer i,unit a1 returns nothing
    set f__arg_unit1=a1

    call TriggerEvaluate(st___prototype46[i])

endfunction
function h__RemoveUnit takes unit a0 returns nothing
    //hook: PocketFactory___RemoveUnitHook
    call sc___prototype46_evaluate(1,a0)
call RemoveUnit(a0)
endfunction

//library Alloc:

//library Alloc ends
//library Indexer:
    
    // Simple unit indexer for version 1.31+
    // Simply copy and paste to import
    
    
    
    
    
        
        function s__Indexer_index takes unit source returns nothing
            if GetUnitUserData(source) == 0 then
                set s__Indexer_unit=source
                
                if s__Indexer_key > - 1 then
                    set s__Indexer_id=s__Indexer_array[s__Indexer_key]
                    set s__Indexer_array[s__Indexer_key]=0
                    set s__Indexer_key=s__Indexer_key - 1
                else
                    set s__Indexer_id=s__Indexer_id + 1
                endif
                
                if GetUnitAbilityLevel(s__Indexer_unit, s__Indexer_ability) == 0 then
                    call UnitAddAbility(s__Indexer_unit, s__Indexer_ability)
                    call UnitMakeAbilityPermanent(s__Indexer_unit, true, s__Indexer_ability)
                    call BlzUnitDisableAbility(s__Indexer_unit, s__Indexer_ability, true, true)
                endif
                call SetUnitUserData(s__Indexer_unit, s__Indexer_id)
                call TriggerEvaluate(s__Indexer_onIndex)
                
                set s__Indexer_unit=null
            endif
        endfunction
    
        function s__Indexer_onOrder takes nothing returns nothing
            if GetIssuedOrderId() == 852056 then
                if GetUnitAbilityLevel(GetTriggerUnit(), s__Indexer_ability) == 0 then
                    set s__Indexer_unit=GetTriggerUnit()
                    call TriggerEvaluate(s__Indexer_onDeindex)
                    set s__Indexer_key=s__Indexer_key + 1
                    set s__Indexer_array[s__Indexer_key]=GetUnitUserData(s__Indexer_unit)
                    set s__Indexer_unit=null
                endif
            endif
        endfunction
    
        function s__Indexer_onEnter takes nothing returns nothing
            call s__Indexer_index(GetFilterUnit())
        endfunction
    
        function s__Indexer_onInit takes nothing returns nothing
            local trigger t= CreateTrigger()
            local region r= CreateRegion()
            local rect map= GetWorldBounds()
            local integer i= 0
            
            call RegionAddRect(r, map)
            call RemoveRect(map)
            call TriggerRegisterEnterRegion(CreateTrigger(), r, Filter(function s__Indexer_onEnter))
            loop
                exitwhen i == bj_MAX_PLAYER_SLOTS
                    call GroupEnumUnitsOfPlayer(bj_lastCreatedGroup, Player(i), null)
                    loop
                        set s__Indexer_unit=FirstOfGroup(bj_lastCreatedGroup)
                        exitwhen s__Indexer_unit == null
                            call s__Indexer_index(s__Indexer_unit)
                        call GroupRemoveUnit(bj_lastCreatedGroup, s__Indexer_unit)
                    endloop
                    call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_ISSUED_ORDER, null)
                set i=i + 1
            endloop
            call TriggerAddCondition(t, Filter(function s__Indexer_onOrder))
            
            set r=null
            set map=null
        endfunction
    
    
    
    
    
    
    function RegisterUnitDeindexEvent takes code c returns nothing
        call TriggerAddCondition(s__Indexer_onDeindex, Filter(c))
    endfunction
    
    function GetIndexUnit takes nothing returns unit
        return s__Indexer_unit
    endfunction

//library Indexer ends
//library LineSegmentEnumeration:
//  --- API ---
// ==== End API ====






        function s__LineSegment_PrepareRect takes real ax,real ay,real bx,real by,real offset,real offsetCollision returns nothing
            local real maxX
            local real maxY
            local real minX
            local real minY

            // get center coordinates of rectangle
            set s__LineSegment_ox=0.5 * ( ax + bx )
            set s__LineSegment_oy=0.5 * ( ay + by )

            // get rectangle major axis as vector
            set s__LineSegment_dx=0.5 * ( bx - ax )
            set s__LineSegment_dy=0.5 * ( by - ay )

            // get half of rectangle length (da) and height (db)
            set s__LineSegment_da=SquareRoot(s__LineSegment_dx * s__LineSegment_dx + s__LineSegment_dy * s__LineSegment_dy)
            set s__LineSegment_db=offset

            // get unit vector of the major axis
            set s__LineSegment_ui=s__LineSegment_dx / s__LineSegment_da
            set s__LineSegment_uj=s__LineSegment_dy / s__LineSegment_da

            // Prepare the bounding Jass Rect
            set offset=offset + offsetCollision

            if ax > bx then
                set maxX=ax + offset
                set minX=bx - offset
            else
                set maxX=bx + offset
                set minX=ax - offset
            endif

            if ay > by then
                set maxY=ay + offset
                set minY=by - offset
            else
                set maxY=by + offset
                set minY=ay - offset
            endif

            call SetRect(s__LineSegment_RECT, minX, minY, maxX, maxY)
        endfunction

        function s__LineSegment_RotateWidgetCoordinates takes widget w returns nothing
            // distance of widget from rectangle center in vector form
            set s__LineSegment_wdx=GetWidgetX(w) - s__LineSegment_ox
            set s__LineSegment_wdy=GetWidgetY(w) - s__LineSegment_oy

            set s__LineSegment_dx=s__LineSegment_wdx * s__LineSegment_ui + s__LineSegment_wdy * s__LineSegment_uj // get the component of above vector in the rect's major axis
            set s__LineSegment_dy=s__LineSegment_wdx * ( - s__LineSegment_uj ) + s__LineSegment_wdy * s__LineSegment_ui // get the component of above vector in the rect's transverse axis
        endfunction

        function s__LineSegment_IsWidgetInRect takes widget w returns boolean
            call s__LineSegment_RotateWidgetCoordinates(w)

            // Check if the components above are less than half the length and height of the rectangle
            // (Square them to compare absolute values)
            return s__LineSegment_dx * s__LineSegment_dx <= s__LineSegment_da * s__LineSegment_da and s__LineSegment_dy * s__LineSegment_dy <= s__LineSegment_db * s__LineSegment_db
        endfunction

        function s__LineSegment_IsUnitInRect takes unit u,boolean checkCollision returns boolean
            if checkCollision then
                call s__LineSegment_RotateWidgetCoordinates(u)

                // Check if the perpendicular distances of the unit from both axes of the rect are less than
                // da and db
                return IsUnitInRangeXY(u, s__LineSegment_ox - s__LineSegment_dy * s__LineSegment_uj, s__LineSegment_oy + s__LineSegment_dy * s__LineSegment_ui, RAbsBJ(s__LineSegment_da)) and IsUnitInRangeXY(u, s__LineSegment_ox + s__LineSegment_dx * s__LineSegment_ui, s__LineSegment_oy + s__LineSegment_dx * s__LineSegment_uj, RAbsBJ(s__LineSegment_db))
            endif

            return s__LineSegment_IsWidgetInRect(u)
        endfunction

        function s__LineSegment_EnumUnitsEx takes group whichgroup,real ax,real ay,real bx,real by,real offset,boolean checkCollision returns nothing
            local unit u

            if checkCollision then
                call s__LineSegment_PrepareRect(ax , ay , bx , by , offset , s__LineSegment_MAX_UNIT_COLLISION)
            else
                call s__LineSegment_PrepareRect(ax , ay , bx , by , offset , 0.00)
            endif

            call GroupEnumUnitsInRect(s__LineSegment_GROUP, s__LineSegment_RECT, null)

            // enum through all tracked units, and check if it's inside bounds
            call GroupClear(whichgroup)
            loop
                set u=FirstOfGroup(s__LineSegment_GROUP)
                exitwhen u == null

                if s__LineSegment_IsUnitInRect(u , checkCollision) then
                    call GroupAddUnit(whichgroup, u)
                endif

                call GroupRemoveUnit(s__LineSegment_GROUP, u)
            endloop
        endfunction

        function s__LineSegment_EnumUnits takes group whichgroup,real ax,real ay,real bx,real by,real offset returns nothing
            call s__LineSegment_EnumUnitsEx(whichgroup , ax , ay , bx , by , offset , false)
        endfunction


//textmacro instance: LSE_WIDGET("destructable", "Destructable")
     
        function s__LineSegment_onDestructableFilter takes nothing returns nothing
            local destructable t= GetFilterDestructable()

            if s__LineSegment_IsWidgetInRect(t) then
                set s__LineSegment_DestructableCounter=s__LineSegment_DestructableCounter + 1
                set s__LineSegment_Destructable[s__LineSegment_DestructableCounter]=t
            endif

            set t=null
        endfunction
     
        function s__LineSegment_EnumDestructables takes real ax,real ay,real bx,real by,real offset returns nothing
            call s__LineSegment_PrepareRect(ax , ay , bx , by , offset , 0.00)

            set s__LineSegment_DestructableCounter=- 1
            call EnumDestructablesInRect(s__LineSegment_RECT, Filter(function s__LineSegment_onDestructableFilter), null)
        endfunction
//end of: LSE_WIDGET("destructable", "Destructable")
//textmacro instance: LSE_WIDGET("item", "Item")
     
        function s__LineSegment_onItemFilter takes nothing returns nothing
            local item t= GetFilterItem()

            if s__LineSegment_IsWidgetInRect(t) then
                set s__LineSegment_ItemCounter=s__LineSegment_ItemCounter + 1
                set s__LineSegment_Item[s__LineSegment_ItemCounter]=t
            endif

            set t=null
        endfunction
     
        function s__LineSegment_EnumItems takes real ax,real ay,real bx,real by,real offset returns nothing
            call s__LineSegment_PrepareRect(ax , ay , bx , by , offset , 0.00)

            set s__LineSegment_ItemCounter=- 1
            call EnumItemsInRect(s__LineSegment_RECT, Filter(function s__LineSegment_onItemFilter), null)
        endfunction
//end of: LSE_WIDGET("item", "Item")
     

//library LineSegmentEnumeration ends
//library RegisterPlayerUnitEvent:
    
    function RegisterPlayerUnitEvent takes playerunitevent p,code c returns nothing
        local integer i= GetHandleId(p)
        local integer k= 15
        if RegisterPlayerUnitEvent___t[i] == null then
            set RegisterPlayerUnitEvent___t[i]=CreateTrigger()
            loop
                call TriggerRegisterPlayerUnitEvent(RegisterPlayerUnitEvent___t[i], Player(k), p, null)
                exitwhen k == 0
                set k=k - 1
            endloop
        endif
        call TriggerAddCondition(RegisterPlayerUnitEvent___t[i], Filter(c))
    endfunction
    
    function RegisterPlayerUnitEventForPlayer takes playerunitevent p,code c,player pl returns nothing
        local integer i= 16 * GetHandleId(p) + GetPlayerId(pl)
        if RegisterPlayerUnitEvent___t[i] == null then
            set RegisterPlayerUnitEvent___t[i]=CreateTrigger()
            call TriggerRegisterPlayerUnitEvent(RegisterPlayerUnitEvent___t[i], pl, p, null)
        endif
        call TriggerAddCondition(RegisterPlayerUnitEvent___t[i], Filter(c))
    endfunction
    
    function GetPlayerUnitEventTrigger takes playerunitevent p returns trigger
        return RegisterPlayerUnitEvent___t[GetHandleId(p)]
    endfunction

//library RegisterPlayerUnitEvent ends
//library Table:
    

    function s__Table___dex__get_size takes nothing returns integer
        return Table___sizeK
    endfunction
    function s__Table___dex__get_list takes nothing returns integer
        return Table___listK
    endfunction

    function s__Table___handles_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___handles_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction

    function s__Table___agents__setindex takes integer this,integer key,agent value returns nothing
        call SaveAgentHandle(Table___ht, this, key, value)
    endfunction

    

//Run these textmacros to include the entire hashtable API as wrappers.
//Don't be intimidated by the number of macros - Vexorian's map optimizer is
//supposed to kill functions which inline (all of these functions inline).
//textmacro instance: NEW_ARRAY_BASIC("Real", "Real", "real")
    function s__Table___reals__getindex takes integer this,integer key returns real
        return LoadReal(Table___ht, this, key)
    endfunction
    function s__Table___reals__setindex takes integer this,integer key,real value returns nothing
        call SaveReal(Table___ht, this, key, value)
    endfunction
    function s__Table___reals_has takes integer this,integer key returns boolean
        return HaveSavedReal(Table___ht, this, key)
    endfunction
    function s__Table___reals_remove takes integer this,integer key returns nothing
        call RemoveSavedReal(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY_BASIC("Real", "Real", "real")
//textmacro instance: NEW_ARRAY_BASIC("Boolean", "Boolean", "boolean")
    function s__Table___booleans__getindex takes integer this,integer key returns boolean
        return LoadBoolean(Table___ht, this, key)
    endfunction
    function s__Table___booleans__setindex takes integer this,integer key,boolean value returns nothing
        call SaveBoolean(Table___ht, this, key, value)
    endfunction
    function s__Table___booleans_has takes integer this,integer key returns boolean
        return HaveSavedBoolean(Table___ht, this, key)
    endfunction
    function s__Table___booleans_remove takes integer this,integer key returns nothing
        call RemoveSavedBoolean(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY_BASIC("Boolean", "Boolean", "boolean")
//textmacro instance: NEW_ARRAY_BASIC("String", "Str", "string")
    function s__Table___strings__getindex takes integer this,integer key returns string
        return LoadStr(Table___ht, this, key)
    endfunction
    function s__Table___strings__setindex takes integer this,integer key,string value returns nothing
        call SaveStr(Table___ht, this, key, value)
    endfunction
    function s__Table___strings_has takes integer this,integer key returns boolean
        return HaveSavedString(Table___ht, this, key)
    endfunction
    function s__Table___strings_remove takes integer this,integer key returns nothing
        call RemoveSavedString(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY_BASIC("String", "Str", "string")
//New textmacro to allow table.integer[] syntax for compatibility with textmacros that might desire it.
//textmacro instance: NEW_ARRAY_BASIC("Integer", "Integer", "integer")
    function s__Table___integers__getindex takes integer this,integer key returns integer
        return LoadInteger(Table___ht, this, key)
    endfunction
    function s__Table___integers__setindex takes integer this,integer key,integer value returns nothing
        call SaveInteger(Table___ht, this, key, value)
    endfunction
    function s__Table___integers_has takes integer this,integer key returns boolean
        return HaveSavedInteger(Table___ht, this, key)
    endfunction
    function s__Table___integers_remove takes integer this,integer key returns nothing
        call RemoveSavedInteger(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY_BASIC("Integer", "Integer", "integer")

//textmacro instance: NEW_ARRAY("Player", "player")
    function s__Table___players__getindex takes integer this,integer key returns player
        return LoadPlayerHandle(Table___ht, this, key)
    endfunction
    function s__Table___players__setindex takes integer this,integer key,player value returns nothing
        call SavePlayerHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___players_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___players_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Player", "player")
//textmacro instance: NEW_ARRAY("Widget", "widget")
    function s__Table___widgets__getindex takes integer this,integer key returns widget
        return LoadWidgetHandle(Table___ht, this, key)
    endfunction
    function s__Table___widgets__setindex takes integer this,integer key,widget value returns nothing
        call SaveWidgetHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___widgets_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___widgets_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Widget", "widget")
//textmacro instance: NEW_ARRAY("Destructable", "destructable")
    function s__Table___destructables__getindex takes integer this,integer key returns destructable
        return LoadDestructableHandle(Table___ht, this, key)
    endfunction
    function s__Table___destructables__setindex takes integer this,integer key,destructable value returns nothing
        call SaveDestructableHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___destructables_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___destructables_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Destructable", "destructable")
//textmacro instance: NEW_ARRAY("Item", "item")
    function s__Table___items__getindex takes integer this,integer key returns item
        return LoadItemHandle(Table___ht, this, key)
    endfunction
    function s__Table___items__setindex takes integer this,integer key,item value returns nothing
        call SaveItemHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___items_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___items_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Item", "item")
//textmacro instance: NEW_ARRAY("Unit", "unit")
    function s__Table___units__getindex takes integer this,integer key returns unit
        return LoadUnitHandle(Table___ht, this, key)
    endfunction
    function s__Table___units__setindex takes integer this,integer key,unit value returns nothing
        call SaveUnitHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___units_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___units_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Unit", "unit")
//textmacro instance: NEW_ARRAY("Ability", "ability")
    function s__Table___abilitys__getindex takes integer this,integer key returns ability
        return LoadAbilityHandle(Table___ht, this, key)
    endfunction
    function s__Table___abilitys__setindex takes integer this,integer key,ability value returns nothing
        call SaveAbilityHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___abilitys_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___abilitys_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Ability", "ability")
//textmacro instance: NEW_ARRAY("Timer", "timer")
    function s__Table___timers__getindex takes integer this,integer key returns timer
        return LoadTimerHandle(Table___ht, this, key)
    endfunction
    function s__Table___timers__setindex takes integer this,integer key,timer value returns nothing
        call SaveTimerHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___timers_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___timers_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Timer", "timer")
//textmacro instance: NEW_ARRAY("Trigger", "trigger")
    function s__Table___triggers__getindex takes integer this,integer key returns trigger
        return LoadTriggerHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggers__setindex takes integer this,integer key,trigger value returns nothing
        call SaveTriggerHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___triggers_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggers_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Trigger", "trigger")
//textmacro instance: NEW_ARRAY("TriggerCondition", "triggercondition")
    function s__Table___triggerconditions__getindex takes integer this,integer key returns triggercondition
        return LoadTriggerConditionHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggerconditions__setindex takes integer this,integer key,triggercondition value returns nothing
        call SaveTriggerConditionHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___triggerconditions_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggerconditions_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("TriggerCondition", "triggercondition")
//textmacro instance: NEW_ARRAY("TriggerAction", "triggeraction")
    function s__Table___triggeractions__getindex takes integer this,integer key returns triggeraction
        return LoadTriggerActionHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggeractions__setindex takes integer this,integer key,triggeraction value returns nothing
        call SaveTriggerActionHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___triggeractions_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___triggeractions_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("TriggerAction", "triggeraction")
//textmacro instance: NEW_ARRAY("TriggerEvent", "event")
    function s__Table___events__getindex takes integer this,integer key returns event
        return LoadTriggerEventHandle(Table___ht, this, key)
    endfunction
    function s__Table___events__setindex takes integer this,integer key,event value returns nothing
        call SaveTriggerEventHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___events_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___events_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("TriggerEvent", "event")
//textmacro instance: NEW_ARRAY("Force", "force")
    function s__Table___forces__getindex takes integer this,integer key returns force
        return LoadForceHandle(Table___ht, this, key)
    endfunction
    function s__Table___forces__setindex takes integer this,integer key,force value returns nothing
        call SaveForceHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___forces_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___forces_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Force", "force")
//textmacro instance: NEW_ARRAY("Group", "group")
    function s__Table___groups__getindex takes integer this,integer key returns group
        return LoadGroupHandle(Table___ht, this, key)
    endfunction
    function s__Table___groups__setindex takes integer this,integer key,group value returns nothing
        call SaveGroupHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___groups_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___groups_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Group", "group")
//textmacro instance: NEW_ARRAY("Location", "location")
    function s__Table___locations__getindex takes integer this,integer key returns location
        return LoadLocationHandle(Table___ht, this, key)
    endfunction
    function s__Table___locations__setindex takes integer this,integer key,location value returns nothing
        call SaveLocationHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___locations_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___locations_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Location", "location")
//textmacro instance: NEW_ARRAY("Rect", "rect")
    function s__Table___rects__getindex takes integer this,integer key returns rect
        return LoadRectHandle(Table___ht, this, key)
    endfunction
    function s__Table___rects__setindex takes integer this,integer key,rect value returns nothing
        call SaveRectHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___rects_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___rects_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Rect", "rect")
//textmacro instance: NEW_ARRAY("BooleanExpr", "boolexpr")
    function s__Table___boolexprs__getindex takes integer this,integer key returns boolexpr
        return LoadBooleanExprHandle(Table___ht, this, key)
    endfunction
    function s__Table___boolexprs__setindex takes integer this,integer key,boolexpr value returns nothing
        call SaveBooleanExprHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___boolexprs_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___boolexprs_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("BooleanExpr", "boolexpr")
//textmacro instance: NEW_ARRAY("Sound", "sound")
    function s__Table___sounds__getindex takes integer this,integer key returns sound
        return LoadSoundHandle(Table___ht, this, key)
    endfunction
    function s__Table___sounds__setindex takes integer this,integer key,sound value returns nothing
        call SaveSoundHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___sounds_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___sounds_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Sound", "sound")
//textmacro instance: NEW_ARRAY("Effect", "effect")
    function s__Table___effects__getindex takes integer this,integer key returns effect
        return LoadEffectHandle(Table___ht, this, key)
    endfunction
    function s__Table___effects__setindex takes integer this,integer key,effect value returns nothing
        call SaveEffectHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___effects_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___effects_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Effect", "effect")
//textmacro instance: NEW_ARRAY("UnitPool", "unitpool")
    function s__Table___unitpools__getindex takes integer this,integer key returns unitpool
        return LoadUnitPoolHandle(Table___ht, this, key)
    endfunction
    function s__Table___unitpools__setindex takes integer this,integer key,unitpool value returns nothing
        call SaveUnitPoolHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___unitpools_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___unitpools_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("UnitPool", "unitpool")
//textmacro instance: NEW_ARRAY("ItemPool", "itempool")
    function s__Table___itempools__getindex takes integer this,integer key returns itempool
        return LoadItemPoolHandle(Table___ht, this, key)
    endfunction
    function s__Table___itempools__setindex takes integer this,integer key,itempool value returns nothing
        call SaveItemPoolHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___itempools_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___itempools_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("ItemPool", "itempool")
//textmacro instance: NEW_ARRAY("Quest", "quest")
    function s__Table___quests__getindex takes integer this,integer key returns quest
        return LoadQuestHandle(Table___ht, this, key)
    endfunction
    function s__Table___quests__setindex takes integer this,integer key,quest value returns nothing
        call SaveQuestHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___quests_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___quests_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Quest", "quest")
//textmacro instance: NEW_ARRAY("QuestItem", "questitem")
    function s__Table___questitems__getindex takes integer this,integer key returns questitem
        return LoadQuestItemHandle(Table___ht, this, key)
    endfunction
    function s__Table___questitems__setindex takes integer this,integer key,questitem value returns nothing
        call SaveQuestItemHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___questitems_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___questitems_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("QuestItem", "questitem")
//textmacro instance: NEW_ARRAY("DefeatCondition", "defeatcondition")
    function s__Table___defeatconditions__getindex takes integer this,integer key returns defeatcondition
        return LoadDefeatConditionHandle(Table___ht, this, key)
    endfunction
    function s__Table___defeatconditions__setindex takes integer this,integer key,defeatcondition value returns nothing
        call SaveDefeatConditionHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___defeatconditions_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___defeatconditions_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("DefeatCondition", "defeatcondition")
//textmacro instance: NEW_ARRAY("TimerDialog", "timerdialog")
    function s__Table___timerdialogs__getindex takes integer this,integer key returns timerdialog
        return LoadTimerDialogHandle(Table___ht, this, key)
    endfunction
    function s__Table___timerdialogs__setindex takes integer this,integer key,timerdialog value returns nothing
        call SaveTimerDialogHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___timerdialogs_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___timerdialogs_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("TimerDialog", "timerdialog")
//textmacro instance: NEW_ARRAY("Leaderboard", "leaderboard")
    function s__Table___leaderboards__getindex takes integer this,integer key returns leaderboard
        return LoadLeaderboardHandle(Table___ht, this, key)
    endfunction
    function s__Table___leaderboards__setindex takes integer this,integer key,leaderboard value returns nothing
        call SaveLeaderboardHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___leaderboards_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___leaderboards_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Leaderboard", "leaderboard")
//textmacro instance: NEW_ARRAY("Multiboard", "multiboard")
    function s__Table___multiboards__getindex takes integer this,integer key returns multiboard
        return LoadMultiboardHandle(Table___ht, this, key)
    endfunction
    function s__Table___multiboards__setindex takes integer this,integer key,multiboard value returns nothing
        call SaveMultiboardHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___multiboards_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___multiboards_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Multiboard", "multiboard")
//textmacro instance: NEW_ARRAY("MultiboardItem", "multiboarditem")
    function s__Table___multiboarditems__getindex takes integer this,integer key returns multiboarditem
        return LoadMultiboardItemHandle(Table___ht, this, key)
    endfunction
    function s__Table___multiboarditems__setindex takes integer this,integer key,multiboarditem value returns nothing
        call SaveMultiboardItemHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___multiboarditems_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___multiboarditems_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("MultiboardItem", "multiboarditem")
//textmacro instance: NEW_ARRAY("Trackable", "trackable")
    function s__Table___trackables__getindex takes integer this,integer key returns trackable
        return LoadTrackableHandle(Table___ht, this, key)
    endfunction
    function s__Table___trackables__setindex takes integer this,integer key,trackable value returns nothing
        call SaveTrackableHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___trackables_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___trackables_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Trackable", "trackable")
//textmacro instance: NEW_ARRAY("Dialog", "dialog")
    function s__Table___dialogs__getindex takes integer this,integer key returns dialog
        return LoadDialogHandle(Table___ht, this, key)
    endfunction
    function s__Table___dialogs__setindex takes integer this,integer key,dialog value returns nothing
        call SaveDialogHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___dialogs_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___dialogs_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Dialog", "dialog")
//textmacro instance: NEW_ARRAY("Button", "button")
    function s__Table___buttons__getindex takes integer this,integer key returns button
        return LoadButtonHandle(Table___ht, this, key)
    endfunction
    function s__Table___buttons__setindex takes integer this,integer key,button value returns nothing
        call SaveButtonHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___buttons_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___buttons_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Button", "button")
//textmacro instance: NEW_ARRAY("TextTag", "texttag")
    function s__Table___texttags__getindex takes integer this,integer key returns texttag
        return LoadTextTagHandle(Table___ht, this, key)
    endfunction
    function s__Table___texttags__setindex takes integer this,integer key,texttag value returns nothing
        call SaveTextTagHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___texttags_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___texttags_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("TextTag", "texttag")
//textmacro instance: NEW_ARRAY("Lightning", "lightning")
    function s__Table___lightnings__getindex takes integer this,integer key returns lightning
        return LoadLightningHandle(Table___ht, this, key)
    endfunction
    function s__Table___lightnings__setindex takes integer this,integer key,lightning value returns nothing
        call SaveLightningHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___lightnings_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___lightnings_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Lightning", "lightning")
//textmacro instance: NEW_ARRAY("Image", "image")
    function s__Table___images__getindex takes integer this,integer key returns image
        return LoadImageHandle(Table___ht, this, key)
    endfunction
    function s__Table___images__setindex takes integer this,integer key,image value returns nothing
        call SaveImageHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___images_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___images_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Image", "image")
//textmacro instance: NEW_ARRAY("Ubersplat", "ubersplat")
    function s__Table___ubersplats__getindex takes integer this,integer key returns ubersplat
        return LoadUbersplatHandle(Table___ht, this, key)
    endfunction
    function s__Table___ubersplats__setindex takes integer this,integer key,ubersplat value returns nothing
        call SaveUbersplatHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___ubersplats_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___ubersplats_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Ubersplat", "ubersplat")
//textmacro instance: NEW_ARRAY("Region", "region")
    function s__Table___regions__getindex takes integer this,integer key returns region
        return LoadRegionHandle(Table___ht, this, key)
    endfunction
    function s__Table___regions__setindex takes integer this,integer key,region value returns nothing
        call SaveRegionHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___regions_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___regions_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Region", "region")
//textmacro instance: NEW_ARRAY("FogState", "fogstate")
    function s__Table___fogstates__getindex takes integer this,integer key returns fogstate
        return LoadFogStateHandle(Table___ht, this, key)
    endfunction
    function s__Table___fogstates__setindex takes integer this,integer key,fogstate value returns nothing
        call SaveFogStateHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___fogstates_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___fogstates_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("FogState", "fogstate")
//textmacro instance: NEW_ARRAY("FogModifier", "fogmodifier")
    function s__Table___fogmodifiers__getindex takes integer this,integer key returns fogmodifier
        return LoadFogModifierHandle(Table___ht, this, key)
    endfunction
    function s__Table___fogmodifiers__setindex takes integer this,integer key,fogmodifier value returns nothing
        call SaveFogModifierHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___fogmodifiers_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___fogmodifiers_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("FogModifier", "fogmodifier")
//textmacro instance: NEW_ARRAY("Hashtable", "hashtable")
    function s__Table___hashtables__getindex takes integer this,integer key returns hashtable
        return LoadHashtableHandle(Table___ht, this, key)
    endfunction
    function s__Table___hashtables__setindex takes integer this,integer key,hashtable value returns nothing
        call SaveHashtableHandle(Table___ht, this, key, value)
    endfunction
    function s__Table___hashtables_has takes integer this,integer key returns boolean
        return HaveSavedHandle(Table___ht, this, key)
    endfunction
    function s__Table___hashtables_remove takes integer this,integer key returns nothing
        call RemoveSavedHandle(Table___ht, this, key)
    endfunction
//end of: NEW_ARRAY("Hashtable", "hashtable")


    // Implement modules for intuitive syntax (tb.handle; tb.unit; etc.)
//Implemented from module Table___realm:
    function s__Table__get_real takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___integerm:
    function s__Table__get_integer takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___booleanm:
    function s__Table__get_boolean takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___stringm:
    function s__Table__get_string takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___playerm:
    function s__Table__get_player takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___widgetm:
    function s__Table__get_widget takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___destructablem:
    function s__Table__get_destructable takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___itemm:
    function s__Table__get_item takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___unitm:
    function s__Table__get_unit takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___abilitym:
    function s__Table__get_ability takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___timerm:
    function s__Table__get_timer takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___triggerm:
    function s__Table__get_trigger takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___triggerconditionm:
    function s__Table__get_triggercondition takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___triggeractionm:
    function s__Table__get_triggeraction takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___eventm:
    function s__Table__get_event takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___forcem:
    function s__Table__get_force takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___groupm:
    function s__Table__get_group takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___locationm:
    function s__Table__get_location takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___rectm:
    function s__Table__get_rect takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___boolexprm:
    function s__Table__get_boolexpr takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___soundm:
    function s__Table__get_sound takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___effectm:
    function s__Table__get_effect takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___unitpoolm:
    function s__Table__get_unitpool takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___itempoolm:
    function s__Table__get_itempool takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___questm:
    function s__Table__get_quest takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___questitemm:
    function s__Table__get_questitem takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___defeatconditionm:
    function s__Table__get_defeatcondition takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___timerdialogm:
    function s__Table__get_timerdialog takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___leaderboardm:
    function s__Table__get_leaderboard takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___multiboardm:
    function s__Table__get_multiboard takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___multiboarditemm:
    function s__Table__get_multiboarditem takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___trackablem:
    function s__Table__get_trackable takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___dialogm:
    function s__Table__get_dialog takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___buttonm:
    function s__Table__get_button takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___texttagm:
    function s__Table__get_texttag takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___lightningm:
    function s__Table__get_lightning takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___imagem:
    function s__Table__get_image takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___ubersplatm:
    function s__Table__get_ubersplat takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___regionm:
    function s__Table__get_region takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___fogstatem:
    function s__Table__get_fogstate takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___fogmodifierm:
    function s__Table__get_fogmodifier takes integer this returns integer
        return this
    endfunction
//Implemented from module Table___hashtablem:
    function s__Table__get_hashtable takes integer this returns integer
        return this
    endfunction

    function s__Table__get_handle takes integer this returns integer
        return this
    endfunction

    function s__Table__get_agent takes integer this returns integer
        return this
    endfunction

    //set this = tb[GetSpellAbilityId()]
    function s__Table__getindex takes integer this,integer key returns integer
        return LoadInteger(Table___ht, this, key) //return this.integer[key]
    endfunction

    //set tb[389034] = 8192
    function s__Table__setindex takes integer this,integer key,integer tb returns nothing
        call SaveInteger(Table___ht, this, key, tb) //set this.integer[key] = tb
    endfunction

    //set b = tb.has(2493223)
    function s__Table_has takes integer this,integer key returns boolean
        return HaveSavedInteger(Table___ht, this, key) //return this.integer.has(key)
    endfunction

    //call tb.remove(294080)
    function s__Table_remove takes integer this,integer key returns nothing
        call RemoveSavedInteger(Table___ht, this, key) //call this.integer.remove(key)
    endfunction

    //Remove all data from a Table instance
    function s__Table_flush takes integer this returns nothing
        call FlushChildHashtable(Table___ht, this)
    endfunction

    //local Table tb = Table.create()
    function s__Table_create takes nothing returns integer
        local integer this= (LoadInteger(Table___ht, ((Table___listK)), (0))) // INLINED!!
        
        if this == 0 then
            set this=Table___more + 1
            set Table___more=this
        else
            call SaveInteger(Table___ht, ((Table___listK)), (0), ( (LoadInteger(Table___ht, ((Table___listK)), (this))))) // INLINED!!
            call RemoveSavedInteger(Table___ht, ((Table___listK)), (this)) //Clear hashed memory // INLINED!!
        endif
        
        return this
    endfunction

    // Removes all data from a Table instance and recycles its index.
    //
    //     call tb.destroy()
    //
    function s__Table_destroy takes integer this returns nothing
        call FlushChildHashtable(Table___ht, (this)) // INLINED!!

        call SaveInteger(Table___ht, ((Table___listK)), (this), ( (LoadInteger(Table___ht, ((Table___listK)), (0))))) // INLINED!!
        call SaveInteger(Table___ht, ((Table___listK)), (0), ( this)) // INLINED!!
    endfunction

//ignored textmacro command: TABLE_BC_METHODS()
    
//ignored textmacro command: TABLE_BC_STRUCTS()
    
    
    //Returns a new TableArray to do your bidding. Simply use:
    //
    //    local TableArray ta = TableArray[array_size]
    //
    function s__TableArray__staticgetindex takes integer array_size returns integer
        local integer tb= (LoadInteger(Table___ht, ((Table___sizeK)), (array_size))) // INLINED!!
        local integer this= (LoadInteger(Table___ht, (tb), (0))) // INLINED!!
        
        
        if this == 0 then
            set this=Table___less - array_size
            set Table___less=this
        else
            call SaveInteger(Table___ht, (tb), (0), ( (LoadInteger(Table___ht, (tb), (this))))) //Set the last destroyed to the last-last destroyed // INLINED!!
            call RemoveSavedInteger(Table___ht, (tb), (this)) //Clear hashed memory // INLINED!!
        endif
        
        call SaveInteger(Table___ht, ((Table___sizeK)), (this), ( array_size)) //This remembers the array size // INLINED!!
        return this
    endfunction
    
    //Returns the size of the TableArray
    function s__TableArray__get_size takes integer this returns integer
        return (LoadInteger(Table___ht, ((Table___sizeK)), (this))) // INLINED!!
    endfunction
    
    //This magic method enables two-dimensional[array][syntax] for Tables,
    //similar to the two-dimensional utility provided by hashtables them-
    //selves.
    //
    //ta[integer a].unit[integer b] = unit u
    //ta[integer a][integer c] = integer d
    //
    //Inline-friendly when not running in debug mode
    //
    function s__TableArray__getindex takes integer this,integer key returns integer










        return this + key
    endfunction
    
    //Destroys a TableArray without flushing it; I assume you call .flush()
    //if you want it flushed too. This is a public method so that you don't
    //have to loop through all TableArray indices to flush them if you don't
    //need to (ie. if you were flushing all child-keys as you used them).
    //
    function s__TableArray_destroy takes integer this returns nothing
        local integer tb= (LoadInteger(Table___ht, ((Table___sizeK)), ((LoadInteger(Table___ht, ((Table___sizeK)), ((this))))))) // INLINED!!
        
        
        if tb == 0 then
            //Create a Table to index recycled instances with their array size
            set tb=s__Table_create()
            call SaveInteger(Table___ht, ((Table___sizeK)), ((LoadInteger(Table___ht, ((Table___sizeK)), ((this))))), ( tb)) // INLINED!!
        endif
        
        call RemoveSavedInteger(Table___ht, ((Table___sizeK)), (this)) //Clear the array size from hash memory // INLINED!!
        
        call SaveInteger(Table___ht, (tb), (this), ( (LoadInteger(Table___ht, (tb), (0))))) // INLINED!!
        call SaveInteger(Table___ht, (tb), (0), ( this)) // INLINED!!
    endfunction
    
    
    //Avoids hitting the op limit
    function s__TableArray_clean takes nothing returns nothing
        local integer tb= s__TableArray_tempTable
        local integer end= tb + 0x1000
        if end < s__TableArray_tempEnd then
            set s__TableArray_tempTable=end
            call ForForce(bj_FORCE_PLAYER[0], function s__TableArray_clean)
        else
            set end=s__TableArray_tempEnd
        endif
        loop
            call FlushChildHashtable(Table___ht, (tb)) // INLINED!!
            set tb=tb + 1
            exitwhen tb == end
        endloop
    endfunction
    
    //Flushes the TableArray and also destroys it. Doesn't get any more
    //similar to the FlushParentHashtable native than this.
    //
    function s__TableArray_flush takes integer this returns nothing
        set s__TableArray_tempTable=this
        set s__TableArray_tempEnd=this + (LoadInteger(Table___ht, ((Table___sizeK)), ((this)))) // INLINED!!
        call ForForce(bj_FORCE_PLAYER[0], function s__TableArray_clean)
        call s__TableArray_destroy(this)
    endfunction
    
    
//NEW: Added in Table 4.0. A fairly simple struct but allows you to do more
//than that which was previously possible.

    //Enables myHash[parentKey][childKey] syntax.
    //Basically, it creates a Table in the place of the parent key if
    //it didn't already get created earlier.
    function s__HashTable__getindex takes integer this,integer index returns integer
        local integer t= (LoadInteger(Table___ht, ((this)), (index))) // INLINED!!
        if t == 0 then
            set t=s__Table_create()
            call SaveInteger(Table___ht, ((this)), (index), ( t)) //whoops! Forgot that line. I'm out of practice! // INLINED!!
        endif
        return t
    endfunction

    //You need to call this on each parent key that you used if you
    //intend to destroy the HashTable or simply no longer need that key.
    function s__HashTable_remove takes integer this,integer index returns nothing
        local integer t= (LoadInteger(Table___ht, ((this)), (index))) // INLINED!!
        if t != 0 then
            call s__Table_destroy(t)
            call RemoveSavedInteger(Table___ht, ((this)), (index)) // INLINED!!
        endif
    endfunction

    //Added in version 4.1
    function s__HashTable_has takes integer this,integer index returns boolean
        return (HaveSavedInteger(Table___ht, ((this)), (index))) // INLINED!!
    endfunction

    //HashTables are just fancy Table indices.
    function s__HashTable_destroy takes integer this returns nothing
        call s__Table_destroy((this))
    endfunction

    //Like I said above...
    function s__HashTable_create takes nothing returns integer
        return s__Table_create()
    endfunction



//library Table ends
//library TimerUtils:
//*********************************************************************
//* TimerUtils (red+blue+orange flavors for 1.24b+) 2.0
//* ----------
//*
//*  To implement it , create a custom text trigger called TimerUtils
//* and paste the contents of this script there.
//*
//*  To copy from a map to another, copy the trigger holding this
//* library to your map.
//*
//* (requires vJass)   More scripts: htt://www.wc3c.net
//*
//* For your timer needs:
//*  * Attaching
//*  * Recycling (with double-free protection)
//*
//* set t=NewTimer()      : Get a timer (alternative to CreateTimer)
//* set t=NewTimerEx(x)   : Get a timer (alternative to CreateTimer), call
//*                            Initialize timer data as x, instead of 0.
//*
//* ReleaseTimer(t)       : Relese a timer (alt to DestroyTimer)
//* SetTimerData(t,2)     : Attach value 2 to timer
//* GetTimerData(t)       : Get the timer's value.
//*                         You can assume a timer's value is 0
//*                         after NewTimer.
//*
//* Multi-flavor:
//*    Set USE_HASH_TABLE to true if you don't want to complicate your life.
//*
//* If you like speed and giberish try learning about the other flavors.
//*
//********************************************************************

//================================================================

    //==================================================================================================



    //It is dependent on jasshelper's recent inlining optimization in order to perform correctly.
    function SetTimerData takes timer t,integer value returns nothing

            // new blue
            call SaveInteger(TimerUtils___ht, 0, GetHandleId(t), value)


















    endfunction

    function GetTimerData takes timer t returns integer

            // new blue
            return LoadInteger(TimerUtils___ht, 0, GetHandleId(t))


















    endfunction

    //==========================================================================================

    //==========================================================================================
    // I needed to decide between duplicating code ignoring the "Once and only once" rule
    // and using the ugly textmacros. I guess textmacros won.
    //

    function NewTimerEx takes integer value returns timer
        if ( TimerUtils___tN == 0 ) then
            if ( not TimerUtils___didinit ) then
                //This extra if shouldn't represent a major performance drawback
                //because QUANTITY rule is not supposed to be broken every day.
                call TriggerEvaluate(st___prototype11[(1)]) // INLINED!!
                set TimerUtils___tN=TimerUtils___tN - 1
            else
                //If this happens then the QUANTITY rule has already been broken, try to fix the
                // issue, else fail.
                set s__TimerUtils___tT[0]= CreateTimer()















            endif
        else
            set TimerUtils___tN=TimerUtils___tN - 1
        endif
        call SaveInteger(TimerUtils___ht, 0, GetHandleId((s__TimerUtils___tT[TimerUtils___tN] )), ( value)) // INLINED!!
     return s__TimerUtils___tT[TimerUtils___tN]
    endfunction

    function NewTimer takes nothing returns timer
        return NewTimerEx(0)
    endfunction


    //==========================================================================================
    function ReleaseTimer takes timer t returns nothing
        if ( t == null ) then
            return
        endif
        if ( TimerUtils___tN == TimerUtils___ARRAY_SIZE ) then
            //stack is full, the map already has much more troubles than the chance of bug
            call DestroyTimer(t)
        else
            call PauseTimer(t)
            if ( (LoadInteger(TimerUtils___ht, 0, GetHandleId((t)))) == TimerUtils___HELD ) then // INLINED!!
                return
            endif
            call SaveInteger(TimerUtils___ht, 0, GetHandleId((t )), ( TimerUtils___HELD)) // INLINED!!
            set s__TimerUtils___tT[TimerUtils___tN]= t
            set TimerUtils___tN=TimerUtils___tN + 1
        endif
    endfunction

    function TimerUtils___init takes nothing returns nothing
     local integer i=0
     local integer o=- 1
     local boolean oops= false
        if ( TimerUtils___didinit ) then
            return
        else
            set TimerUtils___didinit=true
        endif


            set TimerUtils___ht=InitHashtable()
            loop
                exitwhen ( i == TimerUtils___QUANTITY )
                set s__TimerUtils___tT[i]= CreateTimer()
                call SaveInteger(TimerUtils___ht, 0, GetHandleId((s__TimerUtils___tT[i] )), ( TimerUtils___HELD)) // INLINED!!
                set i=i + 1
            endloop
            set TimerUtils___tN=TimerUtils___QUANTITY










































    endfunction


//library TimerUtils ends
//library WorldBounds:
	
		
		
		
		
//Implemented from module WorldBounds___WorldBoundInit:
  function s__WorldBounds_WorldBounds___WorldBoundInit__onInit takes nothing returns nothing
			set s__WorldBounds_world=GetWorldBounds()
			
			set s__WorldBounds_maxX=R2I(GetRectMaxX(s__WorldBounds_world))
			set s__WorldBounds_maxY=R2I(GetRectMaxY(s__WorldBounds_world))
			set s__WorldBounds_minX=R2I(GetRectMinX(s__WorldBounds_world))
			set s__WorldBounds_minY=R2I(GetRectMinY(s__WorldBounds_world))
			
			set s__WorldBounds_centerX=R2I(( s__WorldBounds_maxX + s__WorldBounds_minX ) / 2)
			set s__WorldBounds_centerY=R2I(( s__WorldBounds_minY + s__WorldBounds_maxY ) / 2)
			
			set s__WorldBounds_worldRegion=CreateRegion()
			
			call RegionAddRect(s__WorldBounds_worldRegion, s__WorldBounds_world)
  endfunction

//library WorldBounds ends
//library PluginSpellEffect:
    
    // Simple plugin for the SpellEffectEvent library by Bribe to cache some usefull
    // values.

    // Credits to Bribe and Magtheridon96
    
        
        function s__PluginSpellEffect___SUnit_create takes nothing returns integer
            return s__PluginSpellEffect___SUnit__allocate()
        endfunction
    

//Implemented from module PluginSpellEffect___Event:

        function s__Spell_PluginSpellEffect___Event__GetUnitZ takes unit u returns real
            call MoveLocation(s__Spell_location, GetUnitX(u), GetUnitY(u))
            return GetUnitFlyHeight(u) + GetLocationZ(s__Spell_location)
        endfunction

        function s__Spell_PluginSpellEffect___Event__GetSpellTargetZ takes nothing returns real
            call MoveLocation(s__Spell_location, s__Spell_x, s__Spell_y)
            if s__PluginSpellEffect___SUnit_unit[s__Spell_target] != null then
                return s__Spell_PluginSpellEffect___Event__GetUnitZ(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            else
                return GetLocationZ(s__Spell_location)
            endif
        endfunction

        function s__Spell_PluginSpellEffect___Event__onCast takes nothing returns nothing
            set s__PluginSpellEffect___SUnit_unit[s__Spell_source]=GetTriggerUnit()
            set s__PluginSpellEffect___SUnit_player[s__Spell_source]=GetOwningPlayer(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_handle[s__Spell_source]=GetHandleId(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_id[s__Spell_source]=GetUnitUserData(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_x[s__Spell_source]=GetUnitX(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_y[s__Spell_source]=GetUnitY(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_z[s__Spell_source]=s__Spell_PluginSpellEffect___Event__GetUnitZ(s__PluginSpellEffect___SUnit_unit[s__Spell_source])
            set s__PluginSpellEffect___SUnit_isHero[s__Spell_source]=IsUnitType(s__PluginSpellEffect___SUnit_unit[s__Spell_source], UNIT_TYPE_HERO)
            set s__PluginSpellEffect___SUnit_isStructure[s__Spell_source]=IsUnitType(s__PluginSpellEffect___SUnit_unit[s__Spell_source], UNIT_TYPE_STRUCTURE)
            
            set s__PluginSpellEffect___SUnit_unit[s__Spell_target]=GetSpellTargetUnit()
            set s__PluginSpellEffect___SUnit_player[s__Spell_target]=GetOwningPlayer(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_handle[s__Spell_target]=GetHandleId(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_id[s__Spell_target]=GetUnitUserData(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_x[s__Spell_target]=GetUnitX(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_y[s__Spell_target]=GetUnitY(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_z[s__Spell_target]=s__Spell_PluginSpellEffect___Event__GetUnitZ(s__PluginSpellEffect___SUnit_unit[s__Spell_target])
            set s__PluginSpellEffect___SUnit_isHero[s__Spell_target]=IsUnitType(s__PluginSpellEffect___SUnit_unit[s__Spell_target], UNIT_TYPE_HERO)
            set s__PluginSpellEffect___SUnit_isStructure[s__Spell_target]=IsUnitType(s__PluginSpellEffect___SUnit_unit[s__Spell_target], UNIT_TYPE_STRUCTURE)
            
            set s__Spell_x=GetSpellTargetX()
            set s__Spell_y=GetSpellTargetY()
            set s__Spell_z=s__Spell_PluginSpellEffect___Event__GetSpellTargetZ()
            set s__Spell_id=GetSpellAbilityId()
            set s__Spell_level=GetUnitAbilityLevel(s__PluginSpellEffect___SUnit_unit[s__Spell_source], s__Spell_id)
            set s__Spell_ability=BlzGetUnitAbility(s__PluginSpellEffect___SUnit_unit[s__Spell_source], s__Spell_id)
        endfunction

        function s__Spell_PluginSpellEffect___Event__onInit takes nothing returns nothing
            set s__Spell_source=(s__PluginSpellEffect___SUnit__allocate()) // INLINED!!
            set s__Spell_target=(s__PluginSpellEffect___SUnit__allocate()) // INLINED!!
        
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT , function s__Spell_PluginSpellEffect___Event__onCast)
        endfunction

//library PluginSpellEffect ends
//library SpellEffectEvent:
 
    //============================================================================
     
    //============================================================================
//Implemented from module SpellEffectEvent___M:
       




       
        function s__SpellEffectEvent___S_onCast takes nothing returns nothing

                call TriggerEvaluate((LoadTriggerHandle(Table___ht, (((s__SpellEffectEvent___S_tb))), (GetSpellAbilityId())))) // INLINED!!



        endfunction
     
        function s__SpellEffectEvent___S_SpellEffectEvent___M__onInit takes nothing returns nothing

                set s__SpellEffectEvent___S_tb=s__Table_create()

            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT , function s__SpellEffectEvent___S_onCast)
        endfunction
     
    //============================================================================
    function RegisterSpellEffectEvent takes integer abil,code onCast returns nothing

            if not (HaveSavedHandle(Table___ht, (((s__SpellEffectEvent___S_tb))), (abil))) then // INLINED!!
                call SaveTriggerHandle(Table___ht, (((s__SpellEffectEvent___S_tb))), (abil), ( CreateTrigger())) // INLINED!!
            endif
            call TriggerAddCondition((LoadTriggerHandle(Table___ht, (((s__SpellEffectEvent___S_tb))), (abil))), Filter(onCast)) // INLINED!!






    endfunction

//library SpellEffectEvent ends
//library TimedHandles:



    // here you may add or remove handle types
//textmacro instance: TIMEDHANDLES("effect", "DestroyEffect")
        
        
            




            
            function s__effectTimed_destroy takes integer this returns nothing
                call DestroyEffect(s__effectTimed_effect_var[this])
                set s__effectTimed_effect_var[this]=null
                

                    set s__effectTimed_elapsed[this]=0

                
                call s__effectTimed_deallocate(this)
            endfunction
            
            function s__effectTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__effectTimed_index
                        set this=s__effectTimed_instance[i]
                        set s__effectTimed_elapsed[this]=s__effectTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__effectTimed_elapsed[this] >= s__effectTimed_duration[this] ) then
                            set s__effectTimed_instance[i]=s__effectTimed_instance[s__effectTimed_index]
                            set i=i - 1
                            set s__effectTimed_index=s__effectTimed_index - 1
                            call s__effectTimed_destroy(this)
                            if ( s__effectTimed_index == - 1 ) then
                                call PauseTimer(s__effectTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__effectTimed_create takes effect h,real timeout returns integer
                local integer this= s__effectTimed__allocate()
                

                    set s__effectTimed_index=s__effectTimed_index + 1
                    set s__effectTimed_instance[s__effectTimed_index]=this
                    if ( s__effectTimed_index == 0 ) then
                        call TimerStart(s__effectTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__effectTimed_remove)
                    endif
                    set s__effectTimed_duration[this]=timeout










                
                set s__effectTimed_effect_var[this]=h
                
                return this
            endfunction
            
        
        function DestroyEffectTimed takes effect h,real duration returns integer
            return s__effectTimed_create(h , duration)
        endfunction
        
        function GeteffectTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__effectTimed_timer)



        endfunction

//end of: TIMEDHANDLES("effect", "DestroyEffect")
//textmacro instance: TIMEDHANDLES("lightning", "DestroyLightning")
        
        
            




            
            function s__lightningTimed_destroy takes integer this returns nothing
                call DestroyLightning(s__lightningTimed_lightning_var[this])
                set s__lightningTimed_lightning_var[this]=null
                

                    set s__lightningTimed_elapsed[this]=0

                
                call s__lightningTimed_deallocate(this)
            endfunction
            
            function s__lightningTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__lightningTimed_index
                        set this=s__lightningTimed_instance[i]
                        set s__lightningTimed_elapsed[this]=s__lightningTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__lightningTimed_elapsed[this] >= s__lightningTimed_duration[this] ) then
                            set s__lightningTimed_instance[i]=s__lightningTimed_instance[s__lightningTimed_index]
                            set i=i - 1
                            set s__lightningTimed_index=s__lightningTimed_index - 1
                            call s__lightningTimed_destroy(this)
                            if ( s__lightningTimed_index == - 1 ) then
                                call PauseTimer(s__lightningTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__lightningTimed_create takes lightning h,real timeout returns integer
                local integer this= s__lightningTimed__allocate()
                

                    set s__lightningTimed_index=s__lightningTimed_index + 1
                    set s__lightningTimed_instance[s__lightningTimed_index]=this
                    if ( s__lightningTimed_index == 0 ) then
                        call TimerStart(s__lightningTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__lightningTimed_remove)
                    endif
                    set s__lightningTimed_duration[this]=timeout










                
                set s__lightningTimed_lightning_var[this]=h
                
                return this
            endfunction
            
        
        function DestroyLightningTimed takes lightning h,real duration returns integer
            return s__lightningTimed_create(h , duration)
        endfunction
        
        function GetlightningTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__lightningTimed_timer)



        endfunction

//end of: TIMEDHANDLES("lightning", "DestroyLightning")
//textmacro instance: TIMEDHANDLES("weathereffect", "RemoveWeatherEffect")
        
        
            




            
            function s__weathereffectTimed_destroy takes integer this returns nothing
                call RemoveWeatherEffect(s__weathereffectTimed_weathereffect_var[this])
                set s__weathereffectTimed_weathereffect_var[this]=null
                

                    set s__weathereffectTimed_elapsed[this]=0

                
                call s__weathereffectTimed_deallocate(this)
            endfunction
            
            function s__weathereffectTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__weathereffectTimed_index
                        set this=s__weathereffectTimed_instance[i]
                        set s__weathereffectTimed_elapsed[this]=s__weathereffectTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__weathereffectTimed_elapsed[this] >= s__weathereffectTimed_duration[this] ) then
                            set s__weathereffectTimed_instance[i]=s__weathereffectTimed_instance[s__weathereffectTimed_index]
                            set i=i - 1
                            set s__weathereffectTimed_index=s__weathereffectTimed_index - 1
                            call s__weathereffectTimed_destroy(this)
                            if ( s__weathereffectTimed_index == - 1 ) then
                                call PauseTimer(s__weathereffectTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__weathereffectTimed_create takes weathereffect h,real timeout returns integer
                local integer this= s__weathereffectTimed__allocate()
                

                    set s__weathereffectTimed_index=s__weathereffectTimed_index + 1
                    set s__weathereffectTimed_instance[s__weathereffectTimed_index]=this
                    if ( s__weathereffectTimed_index == 0 ) then
                        call TimerStart(s__weathereffectTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__weathereffectTimed_remove)
                    endif
                    set s__weathereffectTimed_duration[this]=timeout










                
                set s__weathereffectTimed_weathereffect_var[this]=h
                
                return this
            endfunction
            
        
        function RemoveWeatherEffectTimed takes weathereffect h,real duration returns integer
            return s__weathereffectTimed_create(h , duration)
        endfunction
        
        function GetweathereffectTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__weathereffectTimed_timer)



        endfunction

//end of: TIMEDHANDLES("weathereffect", "RemoveWeatherEffect")
//textmacro instance: TIMEDHANDLES("item", "RemoveItem")
        
        
            




            
            function s__itemTimed_destroy takes integer this returns nothing
                call RemoveItem(s__itemTimed_item_var[this])
                set s__itemTimed_item_var[this]=null
                

                    set s__itemTimed_elapsed[this]=0

                
                call s__itemTimed_deallocate(this)
            endfunction
            
            function s__itemTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__itemTimed_index
                        set this=s__itemTimed_instance[i]
                        set s__itemTimed_elapsed[this]=s__itemTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__itemTimed_elapsed[this] >= s__itemTimed_duration[this] ) then
                            set s__itemTimed_instance[i]=s__itemTimed_instance[s__itemTimed_index]
                            set i=i - 1
                            set s__itemTimed_index=s__itemTimed_index - 1
                            call s__itemTimed_destroy(this)
                            if ( s__itemTimed_index == - 1 ) then
                                call PauseTimer(s__itemTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__itemTimed_create takes item h,real timeout returns integer
                local integer this= s__itemTimed__allocate()
                

                    set s__itemTimed_index=s__itemTimed_index + 1
                    set s__itemTimed_instance[s__itemTimed_index]=this
                    if ( s__itemTimed_index == 0 ) then
                        call TimerStart(s__itemTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__itemTimed_remove)
                    endif
                    set s__itemTimed_duration[this]=timeout










                
                set s__itemTimed_item_var[this]=h
                
                return this
            endfunction
            
        
        function RemoveItemTimed takes item h,real duration returns integer
            return s__itemTimed_create(h , duration)
        endfunction
        
        function GetitemTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__itemTimed_timer)



        endfunction

//end of: TIMEDHANDLES("item", "RemoveItem")
//textmacro instance: TIMEDHANDLES("unit", "RemoveUnit")
        
        
            




            
            function s__unitTimed_destroy takes integer this returns nothing
                call h__RemoveUnit(s__unitTimed_unit_var[this])
                set s__unitTimed_unit_var[this]=null
                

                    set s__unitTimed_elapsed[this]=0

                
                call s__unitTimed_deallocate(this)
            endfunction
            
            function s__unitTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__unitTimed_index
                        set this=s__unitTimed_instance[i]
                        set s__unitTimed_elapsed[this]=s__unitTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__unitTimed_elapsed[this] >= s__unitTimed_duration[this] ) then
                            set s__unitTimed_instance[i]=s__unitTimed_instance[s__unitTimed_index]
                            set i=i - 1
                            set s__unitTimed_index=s__unitTimed_index - 1
                            call s__unitTimed_destroy(this)
                            if ( s__unitTimed_index == - 1 ) then
                                call PauseTimer(s__unitTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__unitTimed_create takes unit h,real timeout returns integer
                local integer this= s__unitTimed__allocate()
                

                    set s__unitTimed_index=s__unitTimed_index + 1
                    set s__unitTimed_instance[s__unitTimed_index]=this
                    if ( s__unitTimed_index == 0 ) then
                        call TimerStart(s__unitTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__unitTimed_remove)
                    endif
                    set s__unitTimed_duration[this]=timeout










                
                set s__unitTimed_unit_var[this]=h
                
                return this
            endfunction
            
        
        function RemoveUnitTimed takes unit h,real duration returns integer
            return s__unitTimed_create(h , duration)
        endfunction
        
        function GetunitTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__unitTimed_timer)



        endfunction

//end of: TIMEDHANDLES("unit", "RemoveUnit")
//textmacro instance: TIMEDHANDLES("ubersplat", "DestroyUbersplat")
        
        
            




            
            function s__ubersplatTimed_destroy takes integer this returns nothing
                call DestroyUbersplat(s__ubersplatTimed_ubersplat_var[this])
                set s__ubersplatTimed_ubersplat_var[this]=null
                

                    set s__ubersplatTimed_elapsed[this]=0

                
                call s__ubersplatTimed_deallocate(this)
            endfunction
            
            function s__ubersplatTimed_remove takes nothing returns nothing

                    local integer i= 0
                    local integer this
                    loop
                        exitwhen i > s__ubersplatTimed_index
                        set this=s__ubersplatTimed_instance[i]
                        set s__ubersplatTimed_elapsed[this]=s__ubersplatTimed_elapsed[this] + TimedHandles___UPDATE_PERIOD
                        if ( s__ubersplatTimed_elapsed[this] >= s__ubersplatTimed_duration[this] ) then
                            set s__ubersplatTimed_instance[i]=s__ubersplatTimed_instance[s__ubersplatTimed_index]
                            set i=i - 1
                            set s__ubersplatTimed_index=s__ubersplatTimed_index - 1
                            call s__ubersplatTimed_destroy(this)
                            if ( s__ubersplatTimed_index == - 1 ) then
                                call PauseTimer(s__ubersplatTimed_timer)
                            endif
                        endif
                        set i=i + 1
                    endloop













            endfunction
            
            function s__ubersplatTimed_create takes ubersplat h,real timeout returns integer
                local integer this= s__ubersplatTimed__allocate()
                

                    set s__ubersplatTimed_index=s__ubersplatTimed_index + 1
                    set s__ubersplatTimed_instance[s__ubersplatTimed_index]=this
                    if ( s__ubersplatTimed_index == 0 ) then
                        call TimerStart(s__ubersplatTimed_timer, TimedHandles___UPDATE_PERIOD, true, function s__ubersplatTimed_remove)
                    endif
                    set s__ubersplatTimed_duration[this]=timeout










                
                set s__ubersplatTimed_ubersplat_var[this]=h
                
                return this
            endfunction
            
        
        function DestroyUbersplatTimed takes ubersplat h,real duration returns integer
            return s__ubersplatTimed_create(h , duration)
        endfunction
        
        function GetubersplatTimedTimerHandleId takes nothing returns integer

                return GetHandleId(s__ubersplatTimed_timer)



        endfunction

//end of: TIMEDHANDLES("ubersplat", "DestroyUbersplat")
    
    // Do not edit below this line
    
    

//library TimedHandles ends
//library Utilities:
    
    // How to Import:
    // 1 - Copy this library into your map
    // 2 - Copy the dummy unit in object editor and match its raw code below
    // 3 - Copy the TimerUtils library into your map and follow its install instructions
    // 4 - Copy the Indexer library over to your map and follow its install instructions
    // 5 - Copy the TimedHandles library over to your map and follow its install instructions
    // 6 - Copy the RegisterPlayerUnitEvent library over to your map and follow its install instructions
    
    
    
    
    

    
    
    
    // Only one declaration per map required


    // Returns the terrain Z value (Desync safe)
    function GetLocZ takes real x,real y returns real
        call MoveLocation(Utilities___LOCZ, x, y)
        return GetLocationZ(Utilities___LOCZ)
    endfunction
    
    // Similar to GetUnitX and GetUnitY but for Z axis
    function GetUnitZ takes unit u returns real
        return GetLocZ(GetUnitX(u) , GetUnitY(u)) + GetUnitFlyHeight(u)
    endfunction
    
    // Similar to SetUnitX and SetUnitY but for Z axis
    function SetUnitZ takes unit u,real z returns nothing
        call SetUnitFlyHeight(u, z - GetLocZ(GetUnitX(u) , GetUnitY(u)), 0)
    endfunction

    // Anlge between 2D points
    function AngleBetweenCoordinates takes real x,real y,real x2,real y2 returns real
        return Atan2(y2 - y, x2 - x)
    endfunction

    // Similar to AddSpecialEffect but scales the effect and considers z and return it
    function AddSpecialEffectEx takes string model,real x,real y,real z,real scale returns effect
        set bj_lastCreatedEffect=AddSpecialEffect(model, x, y)

        if z != 0 then
            call BlzSetSpecialEffectZ(bj_lastCreatedEffect, z + GetLocZ(x , y))
        endif
        call BlzSetSpecialEffectScale(bj_lastCreatedEffect, scale)
        
        return bj_lastCreatedEffect
    endfunction

    // Returns a group of enemy units of the specified player within the specified AOE of x and y
    function GetEnemyUnitsInRange takes player enemyOf,real x,real y,real aoe,boolean structures,boolean magicImmune returns group
        local group g= CreateGroup()
        local group h= CreateGroup()
        local unit w
        
        call GroupEnumUnitsInRange(h, x, y, aoe, null)
        if structures and magicImmune then
            loop
                set w=FirstOfGroup(h)
                exitwhen w == null
                    if IsUnitEnemy(w, enemyOf) and UnitAlive(w) then
                        call GroupAddUnit(g, w)
                    endif
                call GroupRemoveUnit(h, w)
            endloop
        elseif structures and not magicImmune then
            loop
                set w=FirstOfGroup(h)
                exitwhen w == null
                    if IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) then
                        call GroupAddUnit(g, w)
                    endif
                call GroupRemoveUnit(h, w)
            endloop
        elseif magicImmune and not structures then
            loop
                set w=FirstOfGroup(h)
                exitwhen w == null
                    if IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) then
                        call GroupAddUnit(g, w)
                    endif
                call GroupRemoveUnit(h, w)
            endloop
        else
            loop
                set w=FirstOfGroup(h)
                exitwhen w == null
                    if IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) then
                        call GroupAddUnit(g, w)
                    endif
                call GroupRemoveUnit(h, w)
            endloop
        endif
        call DestroyGroup(h)
    
        set h=null
        return g
    endfunction

    // Returns the closest unit in a unit group with center at x and y
    function GetClosestUnitGroup takes real x,real y,group g returns unit
        local unit u
        local real dx
        local real dy
        local real md= 100000
        local integer i= 0
        local integer size= BlzGroupGetSize(g)
        
        set Utilities___bj_closestUnitGroup=null
        loop
            exitwhen i == size
                set u=BlzGroupUnitAt(g, i)
                if UnitAlive(u) then
                    set dx=GetUnitX(u) - x
                    set dy=GetUnitY(u) - y
                    
                    if ( dx * dx + dy * dy ) / 100000 < md then
                        set Utilities___bj_closestUnitGroup=u
                        set md=( dx * dx + dy * dy ) / 100000
                    endif
                endif
            set i=i + 1
        endloop
        
        return Utilities___bj_closestUnitGroup
    endfunction
    
    // Removes a destructable after a period of time
    function RemoveDestructableTimed takes destructable dest,real timeout returns nothing
        call sc__TimedDestructable_create(dest , timeout)
    endfunction

    // Link an effect to a unit buff or ability
    function LinkEffectToBuff takes unit target,integer buffId,string model,string attach returns nothing
        call sc__EffectLink_BuffLink(target , buffId , model , attach)
    endfunction

    // Link an effect to an unit item.
    function LinkEffectToItem takes unit target,item i,string model,string attach returns nothing
        call sc__EffectLink_ItemLink(target , i , model , attach)
    endfunction

    // Pretty obvious.
    function R2I2S takes real r returns string
        return I2S(R2I(r))
    endfunction

    // Spams the specified effect model at a location with the given interval for the number of times count
    function SpamEffect takes string model,real x,real y,real z,real scale,real interval,integer count returns nothing
        call sc__EffectSpam_spam(null , model , "" , x , y , z , scale , interval , count)
    endfunction

    // Spams the specified effect model attached to a unit for the given interval for the number of times count
    function SpamEffectUnit takes unit target,string model,string attach,real interval,integer count returns nothing
        call sc__EffectSpam_spam(target , model , attach , 0 , 0 , 0 , 0 , interval , count)
    endfunction   

    // Add the specified ability to the specified unit for the given duration. Use hide to show or not the ability button.
    function UnitAddAbilityTimed takes unit whichUnit,integer abilityId,real duration,integer level,boolean hide returns nothing
        call sc__TimedAbility_add(whichUnit , abilityId , duration , level , hide)
    endfunction

    // Resets the specified unit ability cooldown
    function ResetUnitAbilityCooldown takes unit whichUnit,integer abilCode returns nothing
        call sc__ResetCooldown_reset(whichUnit , abilCode)
    endfunction 

    // Returns the distance between 2 coordinates in Warcraft III units
    function DistanceBetweenCoordinates takes real x1,real y1,real x2,real y2 returns real
        local real dx= ( x2 - x1 )
        local real dy= ( y2 - y1 )
    
        return SquareRoot(dx * dx + dy * dy)
    endfunction

    // Makes the specified source damage an area respecting some basic unit filters
    function UnitDamageArea takes unit source,real x,real y,real aoe,real damage,attacktype atkType,damagetype dmgType,boolean structures,boolean magicImmune,boolean allies returns nothing
        local group h= CreateGroup()
        local player enemyOf= GetOwningPlayer(source)
        local unit w
        
        call GroupEnumUnitsInRange(h, x, y, aoe, null)
        if allies then
            if structures and magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and w != source ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif structures and not magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and w != source ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif magicImmune and not structures then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and w != source ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            else
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and w != source ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            endif
        else
            if structures and magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif structures and not magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif magicImmune and not structures then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            else
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            endif
        endif
        call DestroyGroup(h)
    
        set h=null
        set enemyOf=null
    endfunction

    // Makes the specified source damage a group. Creates a special effect if specified
    function UnitDamageGroup takes unit u,group g,real damage,attacktype atk_type,damagetype dmg_type,string sfx,string atch_point,boolean destroy returns group
        local unit v
        local integer i= 0
        local integer t= BlzGroupGetSize(g)

        loop
            exitwhen i == t
                set v=BlzGroupUnitAt(g, i)
                call UnitDamageTarget(u, v, damage, true, false, atk_type, dmg_type, null)

                if sfx != "" and atch_point != "" then
                    call DestroyEffect(AddSpecialEffectTarget(sfx, v, atch_point))
                endif
            set i=i + 1
        endloop

        if destroy then
            call DestroyGroup(g)
        endif

        return g
    endfunction

    // Returns a random range given a max value
    function GetRandomRange takes real radius returns real
        local real r= GetRandomReal(0, 1) + GetRandomReal(0, 1)

        if r > 1 then
            return ( 2 - r ) * radius
        endif

        return r * radius
    endfunction

    // Returns a random value in the x/y coordinates depending on the value of boolean x
    function GetRandomCoordInRange takes real center,real radius,boolean x returns real
        local real theta= 2 * bj_PI * GetRandomReal(0, 1)
        local real r

        if x then
            set r=center + radius * Cos(theta)
        else
            set r=center + radius * Sin(theta)
        endif

        return r
    endfunction

    // Clones the items in the source unit inventory to the target unit
    function CloneItems takes unit source,unit target,boolean isIllusion returns nothing
        local integer i= 0
        local integer j
        local item k
        
        loop
            exitwhen i > bj_MAX_INVENTORY
                set k=UnitItemInSlot(source, i)
                set j=GetItemCharges(k)
                set k=CreateItem(GetItemTypeId(k), GetUnitX(target), GetUnitY(target))
                call SetItemCharges(k, j)
                call UnitAddItem(target, k)

                if isIllusion then
                    if GetItemTypeId(k) == 'ankh' then
                        call BlzItemRemoveAbility(k, 'AIrc')
                    endif

                    call BlzSetItemBooleanField(k, ITEM_BF_ACTIVELY_USED, false)
                endif
            set i=i + 1
        endloop
        
        set k=null
    endfunction

    // Add the mount for he unit mana pool
    function AddUnitMana takes unit whichUnit,real amount returns nothing
        call SetUnitState(whichUnit, UNIT_STATE_MANA, ( GetUnitState(whichUnit, UNIT_STATE_MANA) + amount ))
    endfunction

    // Add the specified amounts to a hero str/agi/int base amount
    function UnitAddStat takes unit whichUnit,integer strength,integer agility,integer intelligence returns nothing
        if strength != 0 then
            call SetHeroStr(whichUnit, GetHeroStr(whichUnit, false) + strength, true)
        endif
    
        if agility != 0 then
            call SetHeroAgi(whichUnit, GetHeroAgi(whichUnit, false) + agility, true)
        endif
    
        if intelligence != 0 then
            call SetHeroInt(whichUnit, GetHeroInt(whichUnit, false) + intelligence, true)
        endif
    endfunction

    // Returns the closest unit from the x and y coordinates in the map
    function GetClosestUnit takes real x,real y,boolexpr e returns unit
        local real md= 100000
        local group g= CreateGroup()
        local unit u
        local real dx
        local real dy

        set Utilities___bj_closestUnitGroup=null
        
        call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, e)
        loop
            set u=FirstOfGroup(g)
            exitwhen u == null
                if UnitAlive(u) then
                    set dx=GetUnitX(u) - x
                    set dy=GetUnitY(u) - y
                    
                    if ( dx * dx + dy * dy ) / 100000 < md then
                        set Utilities___bj_closestUnitGroup=u
                        set md=( dx * dx + dy * dy ) / 100000
                    endif
                endif
            call GroupRemoveUnit(g, u)
        endloop
        call DestroyGroup(g)
        call DestroyBoolExpr(e)
        set g=null

        return Utilities___bj_closestUnitGroup
    endfunction
    
    // Creates a chain lightning with the specified ligihtning effect with the amount of bounces
    function CreateChainLightning takes unit source,unit target,real damage,real aoe,real duration,real interval,integer bounceCount,attacktype attackType,damagetype damageType,string lightningType,string sfx,string attachPoint,boolean canRebounce returns nothing
        call sc__ChainLightning_create(source , target , damage , aoe , duration , interval , bounceCount , attackType , damageType , lightningType , sfx , attachPoint , canRebounce)
    endfunction

    // Add the specified amount to the specified player gold amount
    function AddPlayerGold takes player whichPlayer,integer amount returns nothing
        call SetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(whichPlayer, PLAYER_STATE_RESOURCE_GOLD) + amount)
    endfunction

    // Creates a text tag in an unit position for a duration
    function CreateTextOnUnit takes unit whichUnit,string text,real duration,integer red,integer green,integer blue,integer alpha returns nothing
        local texttag tx= CreateTextTag()
        
        call SetTextTagText(tx, text, 0.015)
        call SetTextTagPosUnit(tx, whichUnit, 0)
        call SetTextTagColor(tx, red, green, blue, alpha)
        call SetTextTagLifespan(tx, duration)
        call SetTextTagVelocity(tx, 0.0, 0.0355)
        call SetTextTagPermanent(tx, false)
        
        set tx=null
    endfunction

    // Add health regeneration to the unit base value
    function UnitAddHealthRegen takes unit whichUnit,real regen returns nothing
        call BlzSetUnitRealField(whichUnit, UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(whichUnit, UNIT_RF_HIT_POINTS_REGENERATION_RATE) + regen)
    endfunction

    // Retrieves a dummy from the pool. Facing angle in radians
    function DummyRetrieve takes player owner,real x,real y,real z,real face returns unit
        return sc__DummyPool_retrieve(owner , x , y , z , face)
    endfunction

    // Recycles a dummy unit type, putting it back into the pool.
    function DummyRecycle takes unit dummy returns nothing
        call sc__DummyPool_recycle(dummy)
    endfunction

    // Recycles a dummy with a delay.
    function DummyRecycleTimed takes unit dummy,real delay returns nothing
        call sc__DummyPool_recycleTimed(dummy , delay)
    endfunction

    // Casts an ability in the target unit. Must have no casting time
    function CastAbilityTarget takes unit target,integer id,string order,integer level returns nothing
        local unit dummy= (sc__DummyPool_retrieve((GetOwningPlayer(target) ) , (( 0 )*1.0) , (( 0 )*1.0) , (( 0 )*1.0) , (( 0)*1.0))) // INLINED!!
        
        call UnitAddAbility(dummy, id)
        call SetUnitAbilityLevel(dummy, id, level)
        call IssueTargetOrder(dummy, order, target)
        call UnitRemoveAbility(dummy, id)
        call sc__DummyPool_recycle((dummy)) // INLINED!!

        set dummy=null
    endfunction

    // Returns a random unit within a group
    function GroupPickRandomUnitEx takes group g returns unit
        if BlzGroupGetSize(g) > 0 then
            return BlzGroupUnitAt(g, GetRandomInt(0, BlzGroupGetSize(g) - 1))
        else
            return null
        endif
    endfunction

    // Returns true if a unit is within a cone given a facing and fov angle in degrees (Less precise)
    function IsUnitInConeEx takes unit u,real x,real y,real face,real fov returns boolean
        return Acos(Cos(( Atan2(GetUnitY(u) - y, GetUnitX(u) - x) ) - face * bj_DEGTORAD)) < fov * bj_DEGTORAD / 2
    endfunction

    // Returns true if a unit is within a cone given a facing, fov angle and a range in degrees (takes collision into consideration). Credits to AGD.
    function IsUnitInCone takes unit u,real x,real y,real range,real face,real fov returns boolean
        if IsUnitInRangeXY(u, x, y, range) then
            set x=GetUnitX(u) - x
            set y=GetUnitY(u) - y
            set range=x * x + y * y
    
            if range > 0. then
                set face=face * bj_DEGTORAD - Atan2(y, x)
                set fov=fov * bj_DEGTORAD / 2 + Asin(BlzGetUnitCollisionSize(u) / SquareRoot(range))
    
                return RAbsBJ(face) <= fov or RAbsBJ(face - 2.00 * bj_PI) <= fov
            endif
    
            return true
        endif
    
        return false
    endfunction

    // Makes the source unit damage enemy unit in a cone given a direction, foy and range
    function UnitDamageCone takes unit source,real x,real y,real face,real fov,real aoe,real damage,attacktype atkType,damagetype dmgType,boolean structures,boolean magicImmune,boolean allies returns nothing
        local group h= CreateGroup()
        local player enemyOf= GetOwningPlayer(source)
        local unit w
        
        call GroupEnumUnitsInRange(h, x, y, aoe, null)
        if allies then
            if structures and magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and w != source and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif structures and not magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and w != source and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif magicImmune and not structures then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and w != source and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            else
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and w != source and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            endif
        else
            if structures and magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif structures and not magicImmune then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            elseif magicImmune and not structures then
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            else
                loop
                    set w=FirstOfGroup(h)
                    exitwhen w == null
                        if ( IsUnitEnemy(w, enemyOf) and UnitAlive(w) and not IsUnitType(w, UNIT_TYPE_STRUCTURE) and not IsUnitType(w, UNIT_TYPE_MAGIC_IMMUNE) and IsUnitInCone(w , x , y , aoe , face , fov) ) then
                            call UnitDamageTarget(source, w, damage, true, false, atkType, dmgType, null)
                        endif
                    call GroupRemoveUnit(h, w)
                endloop
            endif
        endif
        call DestroyGroup(h)
    
        set h=null
        set enemyOf=null
    endfunction

    // Heals all allied units of specified player in an area
    function HealArea takes player alliesOf,real x,real y,real aoe,real amount,string fxpath,string attchPoint returns nothing
        local group g= CreateGroup()
        local unit v
        
        call GroupEnumUnitsInRange(g, x, y, aoe, null)
        loop
            set v=FirstOfGroup(g)
            exitwhen v == null
                if IsUnitAlly(v, alliesOf) and UnitAlive(v) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                    call SetWidgetLife(v, GetWidgetLife(v) + amount)
                    if fxpath != "" then
                        if attchPoint != "" then
                            call DestroyEffect(AddSpecialEffectTarget(fxpath, v, attchPoint))
                        else
                            call DestroyEffect(AddSpecialEffect(fxpath, GetUnitX(v), GetUnitY(v)))
                        endif
                    endif
                endif
            call GroupRemoveUnit(g, v)
        endloop
        call DestroyGroup(g)
    
        set g=null
    endfunction

    // Returns an ability real level field as a string. Usefull for toolltip manipulation.
    function AbilityRealField takes unit u,integer abilityId,abilityreallevelfield field,integer level,integer multiplier,boolean asInteger returns string
        if asInteger then
            return (I2S(R2I(((BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilityId), field, level) * multiplier)*1.0)))) // INLINED!!
        else
            return R2SW(BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilityId), field, level) * multiplier, 1, 1)
        endif
    endfunction

    // Fix for camera pan desync. credits do Daffa
    function SmartCameraPanBJModified takes player whichPlayer,location loc,real duration returns nothing
        local real tx= GetLocationX(loc)
        local real ty= GetLocationY(loc)
        local real dx= tx - GetCameraTargetPositionX()
        local real dy= ty - GetCameraTargetPositionY()
        local real dist= SquareRoot(dx * dx + dy * dy)

        if ( GetLocalPlayer() == whichPlayer ) then
            if ( dist >= bj_SMARTPAN_TRESHOLD_SNAP ) then
                call PanCameraToTimed(tx, ty, duration)
                // Far away = snap camera immediately to point
            elseif ( dist >= bj_SMARTPAN_TRESHOLD_PAN ) then
                call PanCameraToTimed(tx, ty, duration)
                // Moderately close = pan camera over duration
            else
                // User is close, don't move camera
            endif
        endif
    endfunction
    
    // Fix for camera pan desync. credits do Daffa
    function SmartCameraPanBJModifiedXY takes player whichPlayer,real x,real y,real duration returns nothing
        local real dx= x - GetCameraTargetPositionX()
        local real dy= y - GetCameraTargetPositionY()
        local real dist= SquareRoot(dx * dx + dy * dy)

        if ( GetLocalPlayer() == whichPlayer ) then
            if ( dist >= bj_SMARTPAN_TRESHOLD_SNAP ) then
                call PanCameraToTimed(x, y, duration)
                // Far away = snap camera immediately to point
            elseif ( dist >= bj_SMARTPAN_TRESHOLD_PAN ) then
                call PanCameraToTimed(x, y, duration)
                // Moderately close = pan camera over duration
            else
                // User is close, don't move camera
            endif
        endif
    endfunction

    // Start the cooldown for the source unit unit the new value
    function StartUnitAbilityCooldown takes unit source,integer abilCode,real cooldown returns nothing
        call sc__AbilityCooldown_start(source , abilCode , cooldown)
    endfunction
    
    // Pauses or Unpauses a unit after a delay. If flag = true than the unit will be paused and unpaused after the duration. If flag = false than the unit will be unpaused and paused after the duration.
    function PauseUnitTimed takes unit u,real duration,boolean flag returns nothing
        call sc__TimedPause_create(u , duration , flag)
    endfunction

    
    
    
    

        function s__ResetCooldown_onExpire takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!

            call BlzEndUnitAbilityCooldown(s__ResetCooldown_unit[this], s__ResetCooldown_ability[this])
            call ReleaseTimer(s__ResetCooldown_timer[this])
            call s__ResetCooldown_deallocate(this)
            
            set s__ResetCooldown_unit[this]=null
            set s__ResetCooldown_timer[this]=null
        endfunction

        function s__ResetCooldown_reset takes unit u,integer id returns nothing
            local integer this= s__ResetCooldown__allocate()

            set s__ResetCooldown_timer[this]=NewTimerEx(this)
            set s__ResetCooldown_unit[this]=u
            set s__ResetCooldown_ability[this]=id

            call TimerStart(s__ResetCooldown_timer[this], 0.01, false, function s__ResetCooldown_onExpire)
        endfunction 

    


        function s__TimedAbility_remove takes integer this,integer i returns integer
            call UnitRemoveAbility(s__TimedAbility_unit[this], s__TimedAbility_ability[this])
            call RemoveSavedInteger(Utilities___table, GetHandleId(s__TimedAbility_unit[this]), s__TimedAbility_ability[this])

            set s__TimedAbility_array[i]=s__TimedAbility_array[s__TimedAbility_key]
            set s__TimedAbility_key=s__TimedAbility_key - 1
            set s__TimedAbility_unit[this]=null

            if s__TimedAbility_key == - 1 then
                call PauseTimer(s__TimedAbility_timer)
            endif

            call s__TimedAbility_deallocate(this)

            return i - 1
        endfunction

        function s__TimedAbility_onPeriod takes nothing returns nothing
            local integer i= 0
            local integer this

            loop
                exitwhen i > s__TimedAbility_key
                    set this=s__TimedAbility_array[i]

                    if s__TimedAbility_duration[this] <= 0 then
                        set i=s__TimedAbility_remove(this,i)
                    endif
                    set s__TimedAbility_duration[this]=s__TimedAbility_duration[this] - 0.1
                set i=i + 1
            endloop
        endfunction


        function s__TimedAbility_add takes unit u,integer id,real duration,integer level,boolean hide returns nothing
            local integer this= LoadInteger(Utilities___table, GetHandleId(u), id)
            
            if this == 0 then
                set this=s__TimedAbility__allocate()
                set s__TimedAbility_unit[this]=u
                set s__TimedAbility_ability[this]=id
                set s__TimedAbility_key=s__TimedAbility_key + 1
                set s__TimedAbility_array[s__TimedAbility_key]=this

                call SaveInteger(Utilities___table, GetHandleId(s__TimedAbility_unit[this]), s__TimedAbility_ability[this], this)

                if s__TimedAbility_key == 0 then
                    call TimerStart(s__TimedAbility_timer, 0.1, true, function s__TimedAbility_onPeriod)
                endif
            endif

            if GetUnitAbilityLevel(s__TimedAbility_unit[this], s__TimedAbility_ability[this]) != level then
                call UnitAddAbility(s__TimedAbility_unit[this], s__TimedAbility_ability[this])
                call SetUnitAbilityLevel(s__TimedAbility_unit[this], s__TimedAbility_ability[this], level)
                call UnitMakeAbilityPermanent(s__TimedAbility_unit[this], true, s__TimedAbility_ability[this])
                call BlzUnitHideAbility(s__TimedAbility_unit[this], s__TimedAbility_ability[this], hide)
            endif

            set s__TimedAbility_duration[this]=duration
        endfunction

    

        function s__EffectSpam_onPeriod takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!

            if s__EffectSpam_i[this] > 0 then
                if s__EffectSpam_unit[this] == null then
                    call DestroyEffect(AddSpecialEffectEx(s__EffectSpam_effect[this] , s__EffectSpam_x[this] , s__EffectSpam_y[this] , s__EffectSpam_z[this] , s__EffectSpam_scale[this]))
                else
                    call DestroyEffect(AddSpecialEffectTarget(s__EffectSpam_effect[this], s__EffectSpam_unit[this], s__EffectSpam_point[this]))
                endif
            else
                call ReleaseTimer(s__EffectSpam_timer[this])
                call s__EffectSpam_deallocate(this)
                set s__EffectSpam_timer[this]=null
                set s__EffectSpam_unit[this]=null
            endif
            set s__EffectSpam_i[this]=s__EffectSpam_i[this] - 1
        endfunction

        function s__EffectSpam_spam takes unit target,string model,string attach,real x,real y,real z,real scale,real interval,integer count returns nothing
            local integer this= s__EffectSpam__allocate()

            set s__EffectSpam_timer[this]=NewTimerEx(this)
            set s__EffectSpam_unit[this]=target
            set s__EffectSpam_i[this]=count
            set s__EffectSpam_effect[this]=model
            set s__EffectSpam_x[this]=x
            set s__EffectSpam_y[this]=y
            set s__EffectSpam_z[this]=z
            set s__EffectSpam_scale[this]=scale
            set s__EffectSpam_point[this]=attach

            call TimerStart(s__EffectSpam_timer[this], interval, true, function s__EffectSpam_onPeriod)
        endfunction

    

        function s__ChainLightning_destroy takes integer this returns nothing
            call DestroyGroup(s__ChainLightning_group[this])
            call ReleaseTimer(s__ChainLightning_timer[this])
            call DestroyGroup(s__ChainLightning_damaged[this])

            set s__ChainLightning_prev[this]=null
            set s__ChainLightning_self[this]=null
            set s__ChainLightning_next[this]=null
            set s__ChainLightning_unit[this]=null
            set s__ChainLightning_group[this]=null
            set s__ChainLightning_timer[this]=null
            set s__ChainLightning_player[this]=null
            set s__ChainLightning_damaged[this]=null
            set s__ChainLightning_attacktype[this]=null
            set s__ChainLightning_damagetype[this]=null

            call s__ChainLightning_deallocate(this)
        endfunction

        function s__ChainLightning_onPeriod takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!
            
            call DestroyGroup(s__ChainLightning_group[this])
            if s__ChainLightning_bounces[this] > 0 then
                set s__ChainLightning_group[this]=GetEnemyUnitsInRange(s__ChainLightning_player[this] , GetUnitX(s__ChainLightning_self[this]) , GetUnitY(s__ChainLightning_self[this]) , s__ChainLightning_range[this] , false , false)
                call GroupRemoveUnit(s__ChainLightning_group[this], s__ChainLightning_self[this])
                
                if not s__ChainLightning_rebounce[this] then
                    call BlzGroupRemoveGroupFast(s__ChainLightning_damaged[this], s__ChainLightning_group[this])
                endif
                
                if BlzGroupGetSize(s__ChainLightning_group[this]) == 0 then
                    call s__ChainLightning_destroy(this)
                else
                    set s__ChainLightning_next[this]=GetClosestUnitGroup(GetUnitX(s__ChainLightning_self[this]) , GetUnitY(s__ChainLightning_self[this]) , s__ChainLightning_group[this])
                    
                    if s__ChainLightning_next[this] == s__ChainLightning_prev[this] and BlzGroupGetSize(s__ChainLightning_group[this]) > 1 then
                        call GroupRemoveUnit(s__ChainLightning_group[this], s__ChainLightning_prev[this])
                        set s__ChainLightning_next[this]=GetClosestUnitGroup(GetUnitX(s__ChainLightning_self[this]) , GetUnitY(s__ChainLightning_self[this]) , s__ChainLightning_group[this])
                    endif
                    
                    if s__ChainLightning_next[this] != null then
call s__lightningTimed_create((AddLightningEx(s__ChainLightning_lightning[this], true, GetUnitX(s__ChainLightning_self[this]), GetUnitY(s__ChainLightning_self[this]), GetUnitZ(s__ChainLightning_self[this]) + 60.0, GetUnitX(s__ChainLightning_next[this]), GetUnitY(s__ChainLightning_next[this]), GetUnitZ(s__ChainLightning_next[this]) + 60.0) ) , (( s__ChainLightning_duration[this])*1.0)) // INLINED!!
                        call DestroyEffect(AddSpecialEffectTarget(s__ChainLightning_effect[this], s__ChainLightning_next[this], s__ChainLightning_attach[this]))
                        call GroupAddUnit(s__ChainLightning_damaged[this], s__ChainLightning_next[this])
                        call UnitDamageTarget(s__ChainLightning_unit[this], s__ChainLightning_next[this], s__ChainLightning_damage[this], false, false, s__ChainLightning_attacktype[this], s__ChainLightning_damagetype[this], null)
                        call DestroyGroup(s__ChainLightning_group[this])
                        set s__ChainLightning_prev[this]=s__ChainLightning_self[this]
                        set s__ChainLightning_self[this]=s__ChainLightning_next[this]
                        set s__ChainLightning_next[this]=null
                    else
                        call s__ChainLightning_destroy(this)
                    endif
                endif
            else
                call s__ChainLightning_destroy(this)
            endif
            set s__ChainLightning_bounces[this]=s__ChainLightning_bounces[this] - 1
        endfunction

        function s__ChainLightning_create takes unit source,unit target,real dmg,real aoe,real dur,real interval,integer bounceCount,attacktype attackType,damagetype damageType,string lightningType,string sfx,string attachPoint,boolean canRebounce returns integer
            local group g
            local integer this

            set g=GetEnemyUnitsInRange(GetOwningPlayer(source) , GetUnitX(target) , GetUnitY(target) , aoe , false , false)

            if BlzGroupGetSize(g) == 1 then
call s__lightningTimed_create((AddLightningEx(lightningType, true, GetUnitX(source), GetUnitY(source), BlzGetUnitZ(source) + 60.0, GetUnitX(target), GetUnitY(target), BlzGetUnitZ(target) + 60.0) ) , (( dur)*1.0)) // INLINED!!
                call DestroyEffect(AddSpecialEffectTarget(sfx, target, attachPoint))
                call UnitDamageTarget(source, target, dmg, false, false, attackType, damageType, null)
            else
                set this=s__ChainLightning__allocate()
                set s__ChainLightning_timer[this]=NewTimerEx(this)
                set s__ChainLightning_prev[this]=null
                set s__ChainLightning_self[this]=target
                set s__ChainLightning_next[this]=null
                set s__ChainLightning_unit[this]=source
                set s__ChainLightning_player[this]=GetOwningPlayer(source)
                set s__ChainLightning_damage[this]=dmg
                set s__ChainLightning_range[this]=aoe
                set s__ChainLightning_duration[this]=dur
                set s__ChainLightning_bounces[this]=bounceCount
                set s__ChainLightning_attacktype[this]=attackType
                set s__ChainLightning_damagetype[this]=damageType
                set s__ChainLightning_lightning[this]=lightningType
                set s__ChainLightning_effect[this]=sfx
                set s__ChainLightning_attach[this]=attachPoint
                set s__ChainLightning_rebounce[this]=canRebounce
                set s__ChainLightning_damaged[this]=CreateGroup()

                call GroupRemoveUnit(g, target)
                call GroupAddUnit(s__ChainLightning_damaged[this], target)
                call DestroyEffect(AddSpecialEffectTarget(sfx, target, attachPoint))
                call UnitDamageTarget(source, target, s__ChainLightning_damage[this], false, false, s__ChainLightning_attacktype[this], s__ChainLightning_damagetype[this], null)
                call TimerStart(s__ChainLightning_timer[this], interval, true, function s__ChainLightning_onPeriod)
            endif
            call DestroyGroup(g)
            set g=null

            return this
        endfunction

    


        function s__DummyPool_recycle takes unit dummy returns nothing
            if GetUnitTypeId(dummy) != Utilities_DUMMY then
            else
                call GroupAddUnit(s__DummyPool_group, dummy)
                call SetUnitX(dummy, s__WorldBounds_maxX)
                call SetUnitY(dummy, s__WorldBounds_maxY)
                call SetUnitOwner(dummy, s__DummyPool_player, false)
                call ShowUnit(dummy, false)
                call BlzPauseUnitEx(dummy, true)
            endif
        endfunction

        function s__DummyPool_retrieve takes player owner,real x,real y,real z,real face returns unit
            if BlzGroupGetSize(s__DummyPool_group) > 0 then
                set bj_lastCreatedUnit=FirstOfGroup(s__DummyPool_group)
                call BlzPauseUnitEx(bj_lastCreatedUnit, false)
                call ShowUnit(bj_lastCreatedUnit, true)
                call GroupRemoveUnit(s__DummyPool_group, bj_lastCreatedUnit)
                call SetUnitX(bj_lastCreatedUnit, x)
                call SetUnitY(bj_lastCreatedUnit, y)
                call SetUnitFlyHeight(bj_lastCreatedUnit, z, 0)
                call BlzSetUnitFacingEx(bj_lastCreatedUnit, face * bj_RADTODEG)
                call SetUnitOwner(bj_lastCreatedUnit, owner, false)
            else
                set bj_lastCreatedUnit=CreateUnit(owner, Utilities_DUMMY, x, y, face * bj_RADTODEG)
                call SetUnitFlyHeight(bj_lastCreatedUnit, z, 0)
            endif

            return bj_lastCreatedUnit
        endfunction

        function s__DummyPool_onExpire takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!

            call s__DummyPool_recycle(s__DummyPool_unit[this])
            call ReleaseTimer(s__DummyPool_timer[this])
            
            set s__DummyPool_timer[this]=null
            set s__DummyPool_unit[this]=null

            call s__DummyPool_deallocate(this)
        endfunction

        function s__DummyPool_recycleTimed takes unit dummy,real delay returns nothing
            local integer this

            if GetUnitTypeId(dummy) != Utilities_DUMMY then
            else
                set this=s__DummyPool__allocate()

                set s__DummyPool_timer[this]=NewTimerEx(this)
                set s__DummyPool_unit[this]=dummy
                
                call TimerStart(s__DummyPool_timer[this], delay, false, function s__DummyPool_onExpire)
            endif
        endfunction

        function s__DummyPool_onInit takes nothing returns nothing
            local integer i= 0
            local unit u

            loop
                exitwhen i == 20
                    set u=CreateUnit(s__DummyPool_player, Utilities_DUMMY, s__WorldBounds_maxX, s__WorldBounds_maxY, 0)
                    call BlzPauseUnitEx(u, false)
                    call GroupAddUnit(s__DummyPool_group, u)
                set i=i + 1
            endloop

            set u=null
        endfunction

    
        //Dynamic Indexing for buff and timed
        //Dynamic Indexing for items


        function s__EffectLink_remove takes integer this,integer i,boolean isItem returns integer
            call DestroyEffect(s__EffectLink_effect[this])

            if isItem then
                set s__EffectLink_items[i]=s__EffectLink_items[s__EffectLink_ditem]
                set s__EffectLink_ditem=s__EffectLink_ditem - 1
            else
                set s__EffectLink_data[i]=s__EffectLink_data[s__EffectLink_didx]
                set s__EffectLink_didx=s__EffectLink_didx - 1

                if s__EffectLink_didx == - 1 then
                    call PauseTimer(s__EffectLink_timer)
                endif
            endif

            set s__EffectLink_unit[this]=null
            set s__EffectLink_item[this]=null
            set s__EffectLink_effect[this]=null

            call s__EffectLink_deallocate(this)

            return i - 1
        endfunction

        function s__EffectLink_onDrop takes nothing returns nothing
            local item j= GetManipulatedItem()
            local integer i= 0
            local integer this

            loop
                exitwhen i > s__EffectLink_ditem
                    set this=s__EffectLink_items[i]

                    if s__EffectLink_item[this] == j then
                        set i=s__EffectLink_remove(this,i , true)
                    endif
                set i=i + 1
            endloop

            set j=null
        endfunction

        function s__EffectLink_onPeriod takes nothing returns nothing
            local integer i= 0
            local integer this

            loop
                exitwhen i > s__EffectLink_didx
                    set this=s__EffectLink_data[i]

                    if GetUnitAbilityLevel(s__EffectLink_unit[this], s__EffectLink_buff[this]) == 0 then
                        set i=s__EffectLink_remove(this,i , false)
                    endif
                set i=i + 1
            endloop
        endfunction

        function s__EffectLink_BuffLink takes unit target,integer id,string model,string attach returns nothing
            local integer this= s__EffectLink__allocate()

            set s__EffectLink_unit[this]=target
            set s__EffectLink_buff[this]=id
            set s__EffectLink_effect[this]=AddSpecialEffectTarget(model, target, attach)
            set s__EffectLink_didx=s__EffectLink_didx + 1
            set s__EffectLink_data[s__EffectLink_didx]=this
            
            if s__EffectLink_didx == 0 then
                call TimerStart(s__EffectLink_timer, 0.03125000, true, function s__EffectLink_onPeriod)
            endif
        endfunction

        function s__EffectLink_ItemLink takes unit target,item i,string model,string attach returns nothing
            local integer this= s__EffectLink__allocate()

            set s__EffectLink_item[this]=i
            set s__EffectLink_effect[this]=AddSpecialEffectTarget(model, target, attach)
            set s__EffectLink_ditem=s__EffectLink_ditem + 1
            set s__EffectLink_items[s__EffectLink_ditem]=this
        endfunction

        function s__EffectLink_onInit takes nothing returns nothing
            call RegisterPlayerUnitEvent(EVENT_PLAYER_UNIT_DROP_ITEM , function s__EffectLink_onDrop)
        endfunction

    

        function s__AbilityCooldown_onExpire takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!

            call BlzStartUnitAbilityCooldown(s__AbilityCooldown_unit[this], s__AbilityCooldown_ability[this], s__AbilityCooldown_newCd[this])
            call ReleaseTimer(s__AbilityCooldown_timer[this])
            call s__AbilityCooldown_deallocate(this)

            set s__AbilityCooldown_timer[this]=null
            set s__AbilityCooldown_unit[this]=null
        endfunction

        function s__AbilityCooldown_start takes unit source,integer abilCode,real cooldown returns nothing
            local integer this= s__AbilityCooldown__allocate()

            set s__AbilityCooldown_timer[this]=NewTimerEx(this)
            set s__AbilityCooldown_unit[this]=source
            set s__AbilityCooldown_ability[this]=abilCode
            set s__AbilityCooldown_newCd[this]=cooldown

            call TimerStart(s__AbilityCooldown_timer[this], 0.01, false, function s__AbilityCooldown_onExpire)
        endfunction

    


        function s__TimedDestructable_remove takes integer this,integer i returns integer
            call RemoveDestructable(s__TimedDestructable_destructable[this])

            set s__TimedDestructable_destructable[this]=null
            set s__TimedDestructable_array[i]=s__TimedDestructable_array[s__TimedDestructable_id]
            set s__TimedDestructable_id=s__TimedDestructable_id - 1

            if s__TimedDestructable_id == - 1 then
                call PauseTimer(s__TimedDestructable_timer)
            endif

            call s__TimedDestructable_deallocate(this)

            return i - 1
        endfunction

        function s__TimedDestructable_onPeriod takes nothing returns nothing
            local integer i= 0
            local integer this

            loop
                exitwhen i > s__TimedDestructable_id
                    set this=s__TimedDestructable_array[i]

                    if s__TimedDestructable_duration[this] <= 0 then
                        set i=s__TimedDestructable_remove(this,i)
                    endif
                    set s__TimedDestructable_duration[this]=s__TimedDestructable_duration[this] - s__TimedDestructable_period
                set i=i + 1
            endloop
        endfunction

        function s__TimedDestructable_create takes destructable dest,real timeout returns integer
            local integer this= s__TimedDestructable__allocate()

            set s__TimedDestructable_destructable[this]=dest
            set s__TimedDestructable_duration[this]=timeout
            set s__TimedDestructable_id=s__TimedDestructable_id + 1
            set s__TimedDestructable_array[s__TimedDestructable_id]=this

            if s__TimedDestructable_id == 0 then
                call TimerStart(s__TimedDestructable_timer, s__TimedDestructable_period, true, function s__TimedDestructable_onPeriod)
            endif

            return this
        endfunction

    


        function s__TimedPause_onExpire takes nothing returns nothing
            local integer this= (LoadInteger(TimerUtils___ht, 0, GetHandleId((GetExpiredTimer())))) // INLINED!!

            set s__TimedPause_array[s__TimedPause_key[this]]=s__TimedPause_array[s__TimedPause_key[this]] - 1
            if s__TimedPause_array[s__TimedPause_key[this]] == 0 then
                call BlzPauseUnitEx(s__TimedPause_unit[this], not s__TimedPause_flag[this])
            endif
            call ReleaseTimer(s__TimedPause_timer[this])
            call s__TimedPause_deallocate(this)
            
            set s__TimedPause_timer[this]=null
            set s__TimedPause_unit[this]=null
        endfunction


        function s__TimedPause_create takes unit u,real duration,boolean pause returns integer
            local integer this= s__TimedPause__allocate()

            set s__TimedPause_timer[this]=NewTimerEx(this)
            set s__TimedPause_unit[this]=u
            set s__TimedPause_flag[this]=pause
            set s__TimedPause_key[this]=GetUnitUserData(u)
            
            if s__TimedPause_array[s__TimedPause_key[this]] == 0 then
                call BlzPauseUnitEx(u, pause)
            endif
            set s__TimedPause_array[s__TimedPause_key[this]]=s__TimedPause_array[s__TimedPause_key[this]] + 1
            
            call TimerStart(s__TimedPause_timer[this], duration, false, function s__TimedPause_onExpire)
            
            return this
        endfunction

//library Utilities ends
//library PocketFactory:




function IsPocketFactoryAbility takes integer id returns boolean
    return id == 'ANsy' or id == 'ANs1' or id == 'ANs2' or id == 'ANs3'
endfunction

function IsPocketFactory takes integer id returns boolean
    return id == 'nfac' or id == 'nfa1' or id == 'nfa2'
endfunction

function IsUnitPocketFactory takes unit whichUnit returns boolean
    return IsPocketFactory(GetUnitTypeId(whichUnit))
endfunction

function IsClockwerkGoblin takes integer id returns boolean
    return id == 'ncgb' or id == 'ncg1' or id == 'ncg2' or id == 'ncg3'
endfunction

function IsUnitClockwerkGoblin takes unit whichUnit returns boolean
    return IsClockwerkGoblin(GetUnitTypeId(whichUnit))
endfunction

function GetTriggerPocketFactoryCaster takes nothing returns unit
    return PocketFactory___triggerCaster
endfunction

function GetTriggerPocketFactory takes nothing returns unit
    return PocketFactory___triggerPocketFactory
endfunction

function GetTriggerClockwerkGoblin takes nothing returns unit
    return PocketFactory___triggerClockwerkGoblin
endfunction

function TriggerRegisterPocketFactorySummon takes trigger whichTrigger returns nothing
    set PocketFactory___callbackTriggers[PocketFactory___callbackTriggersCounter]=whichTrigger
    set PocketFactory___callbackTriggersCounter=PocketFactory___callbackTriggersCounter + 1
endfunction

function TriggerRegisterPocketFactorySummonClockwerkGoblin takes trigger whichTrigger returns nothing
    set PocketFactory___callbackTriggersClockwerkGoblin[PocketFactory___callbackTriggersClockwerkGoblinCounter]=whichTrigger
    set PocketFactory___callbackTriggersClockwerkGoblinCounter=PocketFactory___callbackTriggersClockwerkGoblinCounter + 1
endfunction

function PocketFactory___TriggerConditionCast takes nothing returns boolean
    if ( IsPocketFactoryAbility(GetSpellAbilityId()) and not IsUnitInGroup(GetTriggerUnit(), PocketFactory___casters) ) then
        call GroupAddUnit(PocketFactory___casters, GetTriggerUnit())
    endif
    return false
endfunction

function PocketFactory___SummonPocketFactory takes unit factory,unit caster returns nothing
    local integer i= 0
    if ( caster != null ) then
        call GroupRemoveUnit(PocketFactory___casters, caster)
    endif
    loop
        exitwhen ( i == PocketFactory___callbackTriggersCounter )
        if ( IsTriggerEnabled(PocketFactory___callbackTriggers[i]) ) then
            set PocketFactory___triggerCaster=caster
            set PocketFactory___triggerPocketFactory=factory
            call ConditionalTriggerExecute(PocketFactory___callbackTriggers[i])
        endif
        set i=i + 1
    endloop
endfunction

function PocketFactory___SummonClockwerkGoblin takes unit clockwerkGoblin,unit caster returns nothing
    local integer i= 0
    loop
        exitwhen ( i == PocketFactory___callbackTriggersClockwerkGoblinCounter )
        if ( IsTriggerEnabled(PocketFactory___callbackTriggersClockwerkGoblin[i]) ) then
            set PocketFactory___triggerPocketFactory=caster
            set PocketFactory___triggerClockwerkGoblin=clockwerkGoblin
            call ConditionalTriggerExecute(PocketFactory___callbackTriggersClockwerkGoblin[i])
        endif
        set i=i + 1
    endloop
endfunction

function PocketFactory___FindClosestFactory takes real x,real y,player owner returns unit
    local group g= CreateGroup()
    local unit result= null
    set PocketFactory___filterPlayer=owner
    call GroupEnumUnitsInRange(g, x, y, 600.0, PocketFactory___f)
    set result=GetClosestUnitGroup(x , y , g)
    call GroupClear(g)
    call DestroyGroup(g)
    set g=null
    return result
endfunction

function PocketFactory___TriggerConditionEnter takes nothing returns boolean
    if ( (IsPocketFactory(GetUnitTypeId((GetTriggerUnit())))) ) then // INLINED!!
        call PocketFactory___SummonPocketFactory(GetTriggerUnit() , FirstOfGroup(PocketFactory___casters))
    elseif ( (IsClockwerkGoblin(GetUnitTypeId((GetTriggerUnit())))) ) then // INLINED!!
        call PocketFactory___SummonClockwerkGoblin(GetTriggerUnit() , PocketFactory___FindClosestFactory(GetUnitX(GetTriggerUnit()) , GetUnitY(GetTriggerUnit()) , GetOwningPlayer(GetTriggerUnit())))
    endif
    return false
endfunction

function PocketFactory___FilterIsPocketFactory takes nothing returns boolean
    return (IsPocketFactory(GetUnitTypeId((GetFilterUnit())))) and GetOwningPlayer(GetFilterUnit()) == PocketFactory___filterPlayer // INLINED!!
endfunction

function PocketFactory___Init takes nothing returns nothing
    call TriggerRegisterAnyUnitEventBJ(PocketFactory___castTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(PocketFactory___castTrigger, Condition(function PocketFactory___TriggerConditionCast))
    
    call TriggerRegisterEnterRegion(PocketFactory___enterTrigger, s__WorldBounds_worldRegion, null)
    call TriggerAddCondition(PocketFactory___enterTrigger, Condition(function PocketFactory___TriggerConditionEnter))
    
    set PocketFactory___f=Filter(function PocketFactory___FilterIsPocketFactory)
endfunction

function PocketFactory___RemoveUnitHook takes unit whichUnit returns nothing
    call GroupRemoveUnit(PocketFactory___casters, whichUnit)
endfunction

//processed hook: hook RemoveUnit PocketFactory___RemoveUnitHook


//library PocketFactory ends
//===========================================================================
// 
// Pocket Factory
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Map Author: Baradé
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*  Barades Pocket Factory

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'Ntin', - 310.0, - 188.6, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
    set u=BlzCreateUnitWithSkin(p, 'Ntin', - 477.5, - 191.1, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
endfunction

//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=BlzCreateUnitWithSkin(p, 'Ntin', 52.7, - 181.4, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
    set u=BlzCreateUnitWithSkin(p, 'Ntin', 202.8, - 188.6, 270.000, 'Ntin')
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANsy')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANcs')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANeg')
    call SelectHeroSkill(u, 'ANrg')
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreatePlayerBuildings()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: WorldBounds
//===========================================================================
//===========================================================================
// Trigger: RegisterPlayerUnitEvent Magtheridon96
//===========================================================================

//===========================================================================
// Trigger: TimerUtils
//===========================================================================
//===========================================================================
// Trigger: Alloc
//===========================================================================
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~ Alloc ~~ By Sevion ~~ Version 1.09 ~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  What is Alloc?
//         - Alloc implements an intuitive allocation method for array structs
//
//    =Pros=
//         - Efficient.
//         - Simple.
//         - Less overhead than regular structs.
//
//    =Cons=
//         - Must use array structs (hardly a con).
//         - Must manually call OnDestroy.
//         - Must use Delegates for inheritance.
//         - No default values for variables (use onInit instead).
//         - No array members (use another Alloc struct as a linked list or type declaration).
//
//    Methods:
//         - struct.allocate()
//         - struct.deallocate()
//
//           These methods are used just as they should be used in regular structs.
//
//    Modules:
//         - Alloc
//           Implements the most basic form of Alloc. Includes only create and destroy
//           methods.
//
//  Details:
//         - Less overhead than regular structs
//
//         - Use array structs when using Alloc. Put the implement at the top of the struct.
//
//         - Alloc operates almost exactly the same as default structs in debug mode with the exception of onDestroy.
//
//  How to import:
//         - Create a trigger named Alloc.
//         - Convert it to custom text and replace the whole trigger text with this.
//
//  Thanks:
//         - Nestharus for the method of allocation and suggestions on further merging.
//         - Bribe for suggestions like the static if and method names.
//         - PurgeandFire111 for some suggestions like the merging of Alloc and AllocX as well as OnDestroy stuff.
//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//===========================================================================
// Trigger: Table
//===========================================================================
//===========================================================================
// Trigger: Utilities
//===========================================================================
//===========================================================================
// Trigger: Indexer
//
// RegisterUnitIndexEvent collides with UnitDex.
// GetIndexUnit collides with AIDS.
//===========================================================================
//===========================================================================
// Trigger: LineSegment
//===========================================================================
//===========================================================================
// Trigger: TimedHandles
//===========================================================================
//===========================================================================
// Trigger: SpellEffectPlugin
//===========================================================================
//===========================================================================
// Trigger: SpellEffectEvent
//===========================================================================
//============================================================================
// SpellEffectEvent
// - Version 1.1.0.0
//
// API
// ---
//     RegisterSpellEffectEvent(integer abil, code onCast)
//
// Requires
// --------
//     RegisterPlayerUnitEvent: hiveworkshop.com/forums/showthread.php?t=203338
//
// Optional
// --------
//     Table: hiveworkshop.com/forums/showthread.php?t=188084
//
//===========================================================================
// Trigger: Melee Initialization
//
// Default melee game initialization for all players
//===========================================================================
function Trig_Melee_Initialization_Actions takes nothing returns nothing
    call FogEnableOff()
    call FogMaskEnableOff()
    call MeleeStartingVisibility()
    call MeleeStartingHeroLimit()
    call MeleeGrantHeroItems()
    call TriggerRegisterPocketFactorySummon(gg_trg_Summon_Pocket_Factory)
    call TriggerRegisterPocketFactorySummonClockwerkGoblin(gg_trg_Summon_Clockwerk_Goblin)
endfunction

//===========================================================================
function InitTrig_Melee_Initialization takes nothing returns nothing
    set gg_trg_Melee_Initialization=CreateTrigger()
    call TriggerAddAction(gg_trg_Melee_Initialization, function Trig_Melee_Initialization_Actions)
endfunction

//===========================================================================
// Trigger: Summon Pocket Factory
//===========================================================================
function Trig_Summon_Pocket_Factory_Actions takes nothing returns nothing
    call BJDebugMsg("Summon pocket factory " + GetUnitName((PocketFactory___triggerPocketFactory)) + " from caster " + GetUnitName((PocketFactory___triggerCaster))) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Summon_Pocket_Factory takes nothing returns nothing
    set gg_trg_Summon_Pocket_Factory=CreateTrigger()
    call TriggerAddAction(gg_trg_Summon_Pocket_Factory, function Trig_Summon_Pocket_Factory_Actions)
endfunction

//===========================================================================
// Trigger: Summon Clockwerk Goblin
//===========================================================================
function Trig_Summon_Clockwerk_Goblin_Actions takes nothing returns nothing
    call BJDebugMsg("Pocket factory " + GetUnitName((PocketFactory___triggerPocketFactory)) + " summons Clockwerk Goblin " + GetUnitName((PocketFactory___triggerClockwerkGoblin))) // INLINED!!
endfunction

//===========================================================================
function InitTrig_Summon_Clockwerk_Goblin takes nothing returns nothing
    set gg_trg_Summon_Clockwerk_Goblin=CreateTrigger()
    call TriggerAddAction(gg_trg_Summon_Clockwerk_Goblin, function Trig_Summon_Clockwerk_Goblin_Actions)
endfunction

//===========================================================================
// Trigger: Summon Unit
//===========================================================================
function Trig_Summon_Unit_Actions takes nothing returns nothing
    call DisplayTextToForce(GetPlayersAll(), ( GetUnitName(GetSummoningUnit()) + ( " summons " + ( GetUnitName(GetSummonedUnit()) + "." ) ) ))
endfunction

//===========================================================================
function InitTrig_Summon_Unit takes nothing returns nothing
    set gg_trg_Summon_Unit=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Summon_Unit, EVENT_PLAYER_UNIT_SUMMON)
    call TriggerAddAction(gg_trg_Summon_Unit, function Trig_Summon_Unit_Actions)
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_WorldBounds()
    //Function not found: call InitTrig_RegisterPlayerUnitEvent_Magtheridon96()
    //Function not found: call InitTrig_TimerUtils()
    //Function not found: call InitTrig_Alloc()
    //Function not found: call InitTrig_Table()
    //Function not found: call InitTrig_Utilities()
    //Function not found: call InitTrig_Indexer()
    //Function not found: call InitTrig_LineSegment()
    //Function not found: call InitTrig_TimedHandles()
    //Function not found: call InitTrig_SpellEffectPlugin()
    //Function not found: call InitTrig_SpellEffectEvent()
    call InitTrig_Melee_Initialization()
    call InitTrig_Summon_Pocket_Factory()
    call InitTrig_Summon_Clockwerk_Goblin()
    call InitTrig_Summon_Unit()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_Melee_Initialization)
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
    // Force: TRIGSTR_002
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

call ExecuteFunc("jasshelper__initstructs302785812")
call ExecuteFunc("TimerUtils___init")
call ExecuteFunc("PocketFactory___Init")

    call InitGlobals()
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_Melee_Initialization) // INLINED!!

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_003")
    call SetMapDescription("TRIGSTR_005")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 448.0, - 192.0)
    call DefineStartLocation(1, 128.0, - 192.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

//Functions for BigArrays:
function sa__TimedPause_create takes nothing returns boolean
    set f__result_integer=s__TimedPause_create(f__arg_unit1,f__arg_real1,f__arg_boolean1)
   return true
endfunction
function sa__TimedDestructable_create takes nothing returns boolean
    set f__result_integer=s__TimedDestructable_create(f__arg_destructable1,f__arg_real1)
   return true
endfunction
function sa__AbilityCooldown_start takes nothing returns boolean
    call s__AbilityCooldown_start(f__arg_unit1,f__arg_integer1,f__arg_real1)
   return true
endfunction
function sa__EffectLink_BuffLink takes nothing returns boolean
    call s__EffectLink_BuffLink(f__arg_unit1,f__arg_integer1,f__arg_string1,f__arg_string2)
   return true
endfunction
function sa__EffectLink_ItemLink takes nothing returns boolean
    call s__EffectLink_ItemLink(f__arg_unit1,f__arg_item1,f__arg_string1,f__arg_string2)
   return true
endfunction
function sa__DummyPool_recycle takes nothing returns boolean
    call s__DummyPool_recycle(f__arg_unit1)
   return true
endfunction
function sa__DummyPool_retrieve takes nothing returns boolean
local player owner=f__arg_player1
local real x=f__arg_real1
local real y=f__arg_real2
local real z=f__arg_real3
local real face=f__arg_real4
            if BlzGroupGetSize(s__DummyPool_group) > 0 then
                set bj_lastCreatedUnit=FirstOfGroup(s__DummyPool_group)
                call BlzPauseUnitEx(bj_lastCreatedUnit, false)
                call ShowUnit(bj_lastCreatedUnit, true)
                call GroupRemoveUnit(s__DummyPool_group, bj_lastCreatedUnit)
                call SetUnitX(bj_lastCreatedUnit, x)
                call SetUnitY(bj_lastCreatedUnit, y)
                call SetUnitFlyHeight(bj_lastCreatedUnit, z, 0)
                call BlzSetUnitFacingEx(bj_lastCreatedUnit, face * bj_RADTODEG)
                call SetUnitOwner(bj_lastCreatedUnit, owner, false)
            else
                set bj_lastCreatedUnit=CreateUnit(owner, Utilities_DUMMY, x, y, face * bj_RADTODEG)
                call SetUnitFlyHeight(bj_lastCreatedUnit, z, 0)
            endif
set f__result_unit= bj_lastCreatedUnit
   return true
endfunction
function sa__DummyPool_recycleTimed takes nothing returns boolean
    call s__DummyPool_recycleTimed(f__arg_unit1,f__arg_real1)
   return true
endfunction
function sa__ChainLightning_create takes nothing returns boolean
    set f__result_integer=s__ChainLightning_create(f__arg_unit1,f__arg_unit2,f__arg_real1,f__arg_real2,f__arg_real3,f__arg_real4,f__arg_integer1,f__arg_attacktype1,f__arg_damagetype1,f__arg_string1,f__arg_string2,f__arg_string3,f__arg_boolean1)
   return true
endfunction
function sa__EffectSpam_spam takes nothing returns boolean
    call s__EffectSpam_spam(f__arg_unit1,f__arg_string1,f__arg_string2,f__arg_real1,f__arg_real2,f__arg_real3,f__arg_real4,f__arg_real5,f__arg_integer1)
   return true
endfunction
function sa__TimedAbility_add takes nothing returns boolean
    call s__TimedAbility_add(f__arg_unit1,f__arg_integer1,f__arg_real1,f__arg_integer2,f__arg_boolean1)
   return true
endfunction
function sa__ResetCooldown_reset takes nothing returns boolean
    call s__ResetCooldown_reset(f__arg_unit1,f__arg_integer1)
   return true
endfunction
function sa___prototype11_TimerUtils___init takes nothing returns boolean

     local integer i=0
     local integer o=- 1
     local boolean oops= false
        if ( TimerUtils___didinit ) then
    return true
        else
            set TimerUtils___didinit=true
        endif
            set TimerUtils___ht=InitHashtable()
            loop
                exitwhen ( i == TimerUtils___QUANTITY )
                set s__TimerUtils___tT[i]= CreateTimer()
                call SaveInteger(TimerUtils___ht, 0, GetHandleId((s__TimerUtils___tT[i] )), ( TimerUtils___HELD)) // INLINED!!
                set i=i + 1
            endloop
            set TimerUtils___tN=TimerUtils___QUANTITY
    return true
endfunction
function sa___prototype46_PocketFactory___RemoveUnitHook takes nothing returns boolean
    call GroupRemoveUnit(PocketFactory___casters, (f__arg_unit1)) // INLINED!!
    return true
endfunction

function jasshelper__initstructs302785812 takes nothing returns nothing
    set st__TimedPause_create=CreateTrigger()
    call TriggerAddCondition(st__TimedPause_create,Condition( function sa__TimedPause_create))
    set st__TimedDestructable_create=CreateTrigger()
    call TriggerAddCondition(st__TimedDestructable_create,Condition( function sa__TimedDestructable_create))
    set st__AbilityCooldown_start=CreateTrigger()
    call TriggerAddCondition(st__AbilityCooldown_start,Condition( function sa__AbilityCooldown_start))
    set st__EffectLink_BuffLink=CreateTrigger()
    call TriggerAddCondition(st__EffectLink_BuffLink,Condition( function sa__EffectLink_BuffLink))
    set st__EffectLink_ItemLink=CreateTrigger()
    call TriggerAddCondition(st__EffectLink_ItemLink,Condition( function sa__EffectLink_ItemLink))
    set st__DummyPool_recycle=CreateTrigger()
    call TriggerAddCondition(st__DummyPool_recycle,Condition( function sa__DummyPool_recycle))
    set st__DummyPool_retrieve=CreateTrigger()
    call TriggerAddCondition(st__DummyPool_retrieve,Condition( function sa__DummyPool_retrieve))
    set st__DummyPool_recycleTimed=CreateTrigger()
    call TriggerAddCondition(st__DummyPool_recycleTimed,Condition( function sa__DummyPool_recycleTimed))
    set st__ChainLightning_create=CreateTrigger()
    call TriggerAddCondition(st__ChainLightning_create,Condition( function sa__ChainLightning_create))
    set st__EffectSpam_spam=CreateTrigger()
    call TriggerAddCondition(st__EffectSpam_spam,Condition( function sa__EffectSpam_spam))
    set st__TimedAbility_add=CreateTrigger()
    call TriggerAddCondition(st__TimedAbility_add,Condition( function sa__TimedAbility_add))
    set st__ResetCooldown_reset=CreateTrigger()
    call TriggerAddCondition(st__ResetCooldown_reset,Condition( function sa__ResetCooldown_reset))
    set st___prototype11[1]=CreateTrigger()
    call TriggerAddAction(st___prototype11[1],function sa___prototype11_TimerUtils___init)
    call TriggerAddCondition(st___prototype11[1],Condition(function sa___prototype11_TimerUtils___init))
    set st___prototype46[1]=CreateTrigger()
    call TriggerAddAction(st___prototype46[1],function sa___prototype46_PocketFactory___RemoveUnitHook)
    call TriggerAddCondition(st___prototype46[1],Condition(function sa___prototype46_PocketFactory___RemoveUnitHook))



















































call ExecuteFunc("s__WorldBounds_WorldBounds___WorldBoundInit__onInit")


call ExecuteFunc("s__Spell_PluginSpellEffect___Event__onInit")

call ExecuteFunc("s__SpellEffectEvent___S_SpellEffectEvent___M__onInit")
















    call ExecuteFunc("s__Indexer_onInit")
    call ExecuteFunc("s__DummyPool_onInit")
    call ExecuteFunc("s__EffectLink_onInit")
endfunction

