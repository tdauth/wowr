//! novjass
/*
                                                                                                              
                                               KNOCKBACK                                                      
                                              VERSION 1.0                                                     
                                               BY KRICZ                                                       
                                                                                                               

                                                                                                              
                                                Credits:                                                      
                                    Vexorian: vJass, BoundSentinel                           
                              Rising_Dusk: GroupUtils, TerrainPathability
                                          grim001: ListModule
                                                                                                              

                                                                                                               
  Knockback is a knockback system, which is used to push units away.                                           
  The System has much features such like detecting hits with destructables and other units.                    
                                                                                                                
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                               
  The syntax to call a new knockback on a unit is:                                                           
  set myKnockback = Knockback.create(caster, target, distance, time, angle, kbType)          
                                                                                                               
  @caster: This is the unit where the knockback comes from.                                                    
  @target: This is the unit which will be knocked back.                                                        
  @distance: The distance the target will be knocked back.
  @time: The time the unit requires until it reaches the distance
  @angle: The angle of the knockback.                                        
  @kbType: The KnockbackType Struct which saves all the actions for several events (read more below).          
                                                                                                               
                                                                                                               
  This is a small example of a basic knockback:                                                                
  set myKnockback = Knockback.create(GetTriggerUnit(), GetSpellTargetUnit(), 500, 2.5, GetUnitFacing(GetSpellTargetUnit()), kbType)     
                                                                                                               
  This would knockback the target of an spell 500 units away, which requires 2.5 seconds in the target unit's
  facing angle.
                                                                                                               
/////////////////////////////////////////////////////////////////////////////////////////////////////////////  
                                                                                                       
  The KnockbackType Struct:                                                                                    
                                                                                                               
  The KnockbackType Struct is a struct which stores all the actions a knockback can has.                      
  This system features the following actions:                                                                  
                                                                                                               
  This funtion will be called, when a new knockback is started on an unit                                      
    private function interface onStart takes Knockback kb returns nothing                                      
                                                                                                               
  This function will be called whenever the units position will be updated                                    
    private function interface onLoop takes Knockback kb returns nothing                                      
                                                                                                              
  This function will be called whenever the knocked unit hits another unit                                    
  You can use the filterFunction function to filter out specified units                                            
  The system itself will filter out all units arround the target                                              
    private function interface onUnitHit takes Knockback kb, unit hit returns nothing                         
                                                                                                              
  This is the filterFunction. You can use this to filter out specified units. The parameter                   
  enum is the unit which will be filtered at the moment.                                                      
  Use it like a normal FilterFunction which would return an boolean like:                                     
  return IsUnitType(enum) == UNIT_TYPE_HERO                                                                   
    private function interface filterFunction takes Knockback kb, unit enum returns boolean                   
                                                                                                              
  This function will be called whenever the knocked unit hits a destructable                                  
    private function interface onDestructableHit takes Knockback kb, destructable hit returns nothing         
                                                                                                              
  This function will be called when the unit being knocked back dies. If it returns true,                     
  the knockback will continue, else it will be stopped, calling the onEnd function below.                     
    private function interface onTargetDeath takes Knockback kb returns boolean                               
                                                                                                              
  This function will be called when a knockback ends                                                          
    private function interface onEnd takes Knockback kb returns nothing                                       
                                                                                                              
                                                                                                              
  You don not need to declare a new KnockbackType whenever you create a new knockback.                        
  Just create a global KnockbackType and assign its actions at map init and use this variable.                
                                                                                                              
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                              
  Setup variables:                                                                                            
                                                                                                              
  private constant real STANDARD_DEST_RADIUS / STANDARD_UNIT_RADIUS                                         
  This variables are used for gettings near units or destructables around the target.                         
  You can change them while the unit is being knocked back using the aoeDest / aoeUnit variables 
  
  private constant real TIMER_INTERVAL
  This is the interval, in which the position of units being knocked back are changed. The lower this value,
  the smoother is the movement, but the higher this value, the better is the performance.
  The standard value is 0.03125.
  
  private constant boolean STOP_WHEN_IMPASSABLE
  If this boolean is true, the knockback will instantly end, when a unit can not be moved on an impassable terrain.
  For example cliffs, deep water or destructables. Please note, that the system will first run the onDestructableHit Action
  before the unit receive its new position.
  
  private constant USE_KNOCKBACK_EFFECTS
  If this boolean is true, the system will add special effects depending on the terrain type it is currently being on.
  EARTH_EFFECT and WATER_EFFECT are the effects being used, which are attached to KNOCKBACK_EFFECT_ATTACHPOINT.
  If IGNORE_FLYING_UNITS is true, the system will not create these effects on flying units.
                                                                                                              
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                
  User methods:                                                                                               
                                                                                                              
  method destroy takes nothing returns nothing                                                                 
  This method (you can not see it in the code) destroys the current knockback and cleans up all variables.
  Using this method will call the onEnd function.                                                                                                                                                 
                                                                                                              
  method addSpecialEffect takes string fx, string attachPoint returns nothing                              
  Adds or changes the effect attached to the target. 
  
  static method isUnitKnockedBack takes unit whichUnit returns boolean
  This method returns true, if the given unit is being knocked back currently, else it returns false
  
  method operator angle= takes real angle returns nothing
  Changes the angle of the knockback.
 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////    
                                                                                                      
  User variables:                                                                                                                                         
                                                                                                              
  real aoeDest / aoeUnit                                                                                   
  These reals are used to get near units or destructables. You can                                            
  change these variables to every value you want while the unit is beeing knocked back.
  
  integer array userData[3]
  You can use this integer array to store some integer or other structs you may need in the onLoop function or whenever.
                                                                                                              
            
/////////////////////////////////////////////////////////////////////////////////////////////////////////////    
   
  Readonly variables:                                                                                         
  These variables can not be changed. They are only for reading outside of the struct.
                                                                                                              
  unit caster / target                                                                                      
  Caster should be self-evident. Target is the unit beeing knocked back.                                     
                                                                                                               
  real timeOver                                                                                             
  This variable saves the time the unit has been knocked back.                                                
                                                                                                              
  real currentSpeed                                                                                         
  This variable is the current speed of the knockback.         
                                                                                                              
  real movedDistance                                                                                       
  This variable saves the distance the has been knocked back.   
  
  real duration
  This is the base duration used when the knockback was created.
        
  real distance 
  This is the base distance used when the knockback was created.
                                                                                                                
  real knockbackAngle                                                                                                
  This variable saves the angle of the knockback.
*/
//! endnovjass

library Knockback requires ListModule, GroupUtils, TerrainPathability, optional BoundSentinel

    //Please check the Knockback Info Trigger for more information about this system.

    globals
    
        public constant real TIMER_INTERVAL             = 0.03125
        
        private constant real STANDARD_DEST_RADIUS      = 100.00
        private constant real STANDARD_UNIT_RADIUS      = 75.00
        private constant boolean STOP_WHEN_IMPASSABLE   = false
        private constant boolean USE_KNOCKBACK_EFFECTS  = true
            //will only be used, if USE_KNOCKBACK_EFFECTS is true
            private constant string EARTH_EFFECT                    = "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl"
            private constant string WATER_EFFECT                    = "Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl"
            private constant string KNOCKBACK_EFFECT_ATTACHPOINT    = "origin"
            private constant boolean IGNORE_FLYING_UNITS            = true
    
    endglobals

    //The Action Respones
    private function interface onStart              takes Knockback kb                      returns nothing
    private function interface onLoop               takes Knockback kb                      returns nothing
    private function interface onUnitHit            takes Knockback kb, unit hit            returns nothing
    private function interface onDestructableHit    takes Knockback kb, destructable hit    returns nothing
    private function interface onTargetDeath        takes Knockback kb                      returns nothing
    private function interface onEnd                takes Knockback kb                      returns nothing
    private function interface filterFunction       takes Knockback kb, unit enum           returns boolean
        
    //The KnockbackType Struct
    struct KnockbackType
        onStart             onStartAction = 0
        onLoop              onLoopAction = 0
        onUnitHit           onUnitHitAction = 0
        onDestructableHit   onDestructableHitAction = 0
        onEnd               onEndAction = 0
        onTargetDeath       onTargetDeathAction = 0
        filterFunction      filterFunc = 0
    endstruct

    //The Knockback Struct
    struct Knockback
    
        //public readonly variables
        readonly unit caster = null
        readonly unit target = null
        readonly real timeOver = 0.00
        readonly real currentSpeed = 0.00
        readonly real movedDistance = 0.00
        readonly real duration = 0.00
        readonly real distance = 0.00
        
        //variables you can change while the unit is being knocked back
        public real angle = 0.00
        public real aoeUnit = STANDARD_UNIT_RADIUS
        public real aoeDest = STANDARD_DEST_RADIUS
        public integer array userData[3]
        
        //private variables
        private real deceleration = 0.00
        private effect fx = null
        private effect kbEffect = null
        private integer kbEffectMode = 0
        private boolean ranDeathAction = false
        private boolean isGround = false
        
        //the actions
        private onStart onStartAction = 0
        private onLoop onLoopAction = 0
        private onUnitHit onUnitHitAction = 0
        private onDestructableHit onDestructableHitAction = 0
        private onEnd onEndAction = 0
        private onTargetDeath onTargetDeathAction = 0
        private filterFunction filterFunc = 0
        
        //just some static variables to make the system faster/work
        private static timer ticker         = null
        private static boolexpr unitFilter  = null 
        private static boolexpr destFilter  = null
        private static code unitActions     = null
        private static code destActions     = null
        private static thistype temp        = 0
        private static rect destRect        = Rect(0,0,1,1)
        private static real tx              = 0.00
        private static real ty              = 0.00
        
        //ListModule
        implement ListModule_List
        
        
        //saves the actions in the Knockback Struct (will be used in the create method)
        private method assignActions takes KnockbackType kb returns nothing
            set .onStartAction = kb.onStartAction
            set .onLoopAction = kb.onLoopAction
            set .onUnitHitAction = kb.onUnitHitAction
            set .onDestructableHitAction = kb.onDestructableHitAction
            set .onEndAction = kb.onEndAction
            set .onTargetDeathAction = kb.onTargetDeathAction
            set .filterFunc = kb.filterFunc
        endmethod
        
        //this is the filter for destructables around the target
        private static method destFilterMethod takes nothing returns boolean
            local real x = GetDestructableX(GetFilterDestructable())
            local real y = GetDestructableY(GetFilterDestructable())
            return (.tx-x)*(.tx-x) + (.ty-y)*(.ty-y) <= .temp.aoeDest * .temp.aoeDest
        endmethod
        
        //this method will run the onDestructableHit action for every destructable hit
        private static method runDestActions takes nothing returns nothing
            if .temp.onDestructableHitAction != 0 then
                call .temp.onDestructableHitAction.evaluate(.temp, GetEnumDestructable())
            endif
        endmethod
        
        //this method calls the user defined filter method
        private static method filterMethod takes nothing returns boolean
            if .temp.filterFunc != 0 then
                return GetFilterUnit() != .temp.target and temp.filterFunc.evaluate(.temp, GetFilterUnit())
            else
                return GetFilterUnit() != .temp.target
            endif
        endmethod
        
        //this method will run the onUnitHit action for every unit hit
        private static method runUnitActions takes nothing returns nothing
            if .temp.onUnitHitAction != 0 then
                call .temp.onUnitHitAction.evaluate(.temp, GetEnumUnit())
            endif
        endmethod
        
        //cleans up the struct and runs the onEnd actions
        private method onDestroy takes nothing returns nothing
            if .fx != null then
                call DestroyEffect(.fx)
            endif
            static if USE_KNOCKBACK_EFFECTS then
                call DestroyEffect(.kbEffect)
            endif
            if .onEndAction != 0 then
                call .onEndAction.evaluate(this)
            endif
            call .listRemove()
        endmethod
        
        //this method will be called every TIMER_INTERVAL and update the units position as well as runs the onLoop action
        private static method onExpire takes nothing returns nothing
            local thistype this = .first
            local real x 
            local real y
            
            local group g = NewGroup()
            
            loop
                exitwhen this == 0
                
                //run the onLoop action
                if .onLoopAction != 0 then
                    call .onLoopAction.evaluate(this)
                endif
                
                if IsUnitType(.target, UNIT_TYPE_DEAD) or GetUnitTypeId(.target) == 0 and not .ranDeathAction then
                    if .onTargetDeathAction != 0 then
                        call .onTargetDeathAction.evaluate(this)
                    endif
                    set .ranDeathAction = true
                endif
                
                //change the time which has been gone
                set .timeOver = .timeOver + TIMER_INTERVAL
                set .currentSpeed = .currentSpeed - .deceleration
                set .movedDistance = .movedDistance + .currentSpeed
                
                set x = GetUnitX(.target) + (.currentSpeed) * Cos(angle * bj_DEGTORAD)
                set y = GetUnitY(.target) + (.currentSpeed) * Sin(angle * bj_DEGTORAD)
                
                ///check for destructables arround the target
                set .tx = x
                set .ty = y
                call SetRect(.destRect, -.aoeDest, -.aoeDest, .aoeDest, .aoeDest)
                call MoveRectTo(.destRect, x, y)
                call EnumDestructablesInRect(.destRect, .destFilter, .destActions)
                
                //check pathability and set new unit position if walkable
                if IsTerrainWalkable(x, y) then
                    call SetUnitX(.target, x)
                    call SetUnitY(.target, y)
                else
                    static if STOP_WHEN_UNPASSABLE then
                        call .destroy()
                    endif
                endif
                
                //change the knockback effect if the user want to use it
                static if USE_KNOCKBACK_EFFECTS then
                    if .isGround or not IGNORE_FLYING_UNITS then
                        if .kbEffectMode == 2 and IsTerrainLand(x, y) then
                            call DestroyEffect(.kbEffect)
                            set .kbEffect = AddSpecialEffectTarget(EARTH_EFFECT, .target, KNOCKBACK_EFFECT_ATTACHPOINT)
                        elseif .kbEffectMode == 1 and IsTerrainShallowWater(x, y) then
                            call DestroyEffect(.kbEffect)
                            set .kbEffect = AddSpecialEffectTarget(WATER_EFFECT, .target, KNOCKBACK_EFFECT_ATTACHPOINT)
                        endif
                    endif
                endif
                             
                //catch units in the aoe around the target
                set .temp = this
                call GroupEnumUnitsInArea(g, x, y, .aoeUnit, .unitFilter)
                call ForGroup(g, .unitActions)
                
                //if the knockback ended because the target reached the end or the speed is smaller than 0
                if .currentSpeed <= 0 or .movedDistance >= .distance then
                    call .destroy()
                endif
                
                //pause the timer if no knockback is active anymore
                if .count < 1 then
                    call PauseTimer(.ticker)
                endif
                
                //refresh group and get next instance
                call GroupRefresh(g)
                set this = .next
            endloop
            
            //cleanup locals
            call ReleaseGroup(g)
            set g = null
        endmethod

        //adds or changes the current effect attached to the target
        public method addSpecialEffect takes string fx, string attachPoint returns nothing
            if .fx != null then
                call DestroyEffect(.fx)
            endif
            set .fx = AddSpecialEffectTarget(fx, .target, attachPoint)
        endmethod
        
        //use this method to check if a unit is being knocked back
        static method isUnitKnockedBack takes unit whichUnit returns boolean
            local thistype this = .first
            if this == 0 then
                return false
            endif
            loop
                exitwhen this == 0
                if .target == whichUnit then
                    return true
                endif
                set this = .next
            endloop
            return false
        endmethod
                
        
        //this method creates a new knockback
        public static method create takes unit caster, unit target, real distance, real time, real angle, KnockbackType kbType returns thistype
            local thistype this = thistype.allocate()
            local real speed = 2 * distance / ((time / TIMER_INTERVAL) + 1)
            local real deceleration = speed / (time / TIMER_INTERVAL)
            local integer i = 0
            
            //reset userData
            loop
                exitwhen i >= 2
                set .userData[i] = 0
                set i = i + 1
            endloop
            
            //set variables
            set .caster = caster
            set .target = target
            set .angle = angle
            set .distance = distance
            set .duration = time
            set .currentSpeed = speed
            set .deceleration = deceleration
            
            set .isGround = not IsUnitType(.target, UNIT_TYPE_FLYING)
            
            //Adds the knockback effect when USE_KNOCKBACK_EFFECTS is set to true
            static if USE_KNOCKBACK_EFFECTS then
                if .isGround or not IGNORE_FLYING_UNITS then
                    if IsTerrainLand(GetUnitX(.target), GetUnitY(.target)) then
                        set .kbEffect = AddSpecialEffectTarget(EARTH_EFFECT, .target, KNOCKBACK_EFFECT_ATTACHPOINT)
                        set .kbEffectMode = 1
                    elseif IsTerrainShallowWater(GetUnitX(.target), GetUnitY(.target)) then
                        set .kbEffect = AddSpecialEffectTarget(WATER_EFFECT, .target, KNOCKBACK_EFFECT_ATTACHPOINT)
                        set .kbEffectMode = 2
                    endif
                endif
            endif
            
            //add the event actions to the struct
            call .assignActions(kbType)
            
            //run the onStart action
            if .onStartAction != 0 then
                call .onStartAction.evaluate(this)
            endif
            
            //add the knockback to the List
            call .listAdd()
            
            //start the timer if the new instance is the only one
            if .count == 1 then
                call TimerStart(.ticker, TIMER_INTERVAL, true, function thistype.onExpire)
            endif
        
            return this
        endmethod
    
        //Initialization
        private static method onInit takes nothing returns nothing
            set .ticker = CreateTimer()
            set .unitFilter  = Condition(function thistype.filterMethod)
            set .destFilter  = Condition(function thistype.destFilterMethod)
            set .unitActions = function thistype.runUnitActions
            set .destActions = function thistype.runDestActions
        endmethod
        
        public static method getTickerTimerHandleId takes nothing returns integer
            return GetHandleId(.ticker)
        endmethod
        
        
    endstruct
    
    
    function GetKnockbackTickerTimerHandleId takes nothing returns integer
        return Knockback.getTickerTimerHandleId()
    endfunction
    

endlibrary
